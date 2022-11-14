Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E75628617
	for <lists+linux-pci@lfdr.de>; Mon, 14 Nov 2022 17:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237195AbiKNQym (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Nov 2022 11:54:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236117AbiKNQyl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2022 11:54:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B619F63;
        Mon, 14 Nov 2022 08:54:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 072DA612FA;
        Mon, 14 Nov 2022 16:54:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CF11C433C1;
        Mon, 14 Nov 2022 16:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668444879;
        bh=MUy8O5WFGyXPVwY1Gpp83dzNZ67hEk35Q6+dyzfGqQQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=nseCzYfBwjX++T+61HAXaIWWQwdFnHY1w2zmhmK4nuSDU1npeMBrbRW9jOr7P+Bsc
         b2y6GMp9oqCNP/RoJkdFq3Q/0MxotWPQ/b+d9zIVaXBi3Ts6XxmF5pNFZUFblna+PD
         P2zn/EBIcsTmyeOTFLH+1q14KCwFkfCWQOKMvJPOlhNWwFGobLrHInqN7HOio9UoSr
         gOWJchUyyWtj3lVKlAYo5gVvc2w3HBO2tQMjf2jqEDwT2IBTzKp05LsEjamZfo9m2h
         QskYroBVriNQFfguj35pWXQZpg1od2mb0wD6lrCU7R553f1gTObL1zusdquVUszDev
         R1Nl7OUTNX2JA==
Date:   Mon, 14 Nov 2022 10:54:37 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mehta Sanju <Sanju.Mehta@amd.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] PCI/ACPI: PCI/ACPI: Validate devices with power
 resources support D3
Message-ID: <20221114165437.GA917550@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53e6278b-9261-952e-56bb-4bd288cd2e9e@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 14, 2022 at 09:37:58AM -0600, Limonciello, Mario wrote:
> On 11/14/2022 09:33, Rafael J. Wysocki wrote:
> > On Fri, Nov 11, 2022 at 10:42 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Fri, Nov 11, 2022 at 12:58:28PM -0600, Limonciello, Mario wrote:
> > > > On 11/11/2022 11:41, Bjorn Helgaas wrote:
> > > > > On Mon, Oct 31, 2022 at 05:33:55PM -0500, Mario Limonciello wrote:
> > > > > > Firmware typically advertises that ACPI devices that represent PCIe
> > > > > > devices can support D3 by a combination of the value returned by
> > > > > > _S0W as well as the HotPlugSupportInD3 _DSD [1].
> > > > > > 
> > > > > > `acpi_pci_bridge_d3` looks for this combination but also contains
> > > > > > an assumption that if an ACPI device contains power resources the PCIe
> > > > > > device it's associated with can support D3.  This was introduced
> > > > > > from commit c6e331312ebf ("PCI/ACPI: Whitelist hotplug ports for
> > > > > > D3 if power managed by ACPI").
> > > > > > 
> > > > > > Some firmware configurations for "AMD Pink Sardine" do not support
> > > > > > wake from D3 in _S0W for the ACPI device representing the PCIe root
> > > > > > port used for tunneling. The PCIe device will still be opted into
> > > > > > runtime PM in the kernel [2] because of the logic within
> > > > > > `acpi_pci_bridge_d3`. This currently happens because the ACPI
> > > > > > device contains power resources.
> > > 
> > > Wait.  Is this as simple as just recognizing that:
> > > 
> > >    _PS0 means the OS has a knob to put the device in D0, but it doesn't
> > >    mean the device can wake itself from a low-power state.  The OS has
> > >    to use _S0W to learn the device's ability to wake itself.
> > 
> > It is.
> > 
> > > If that's enough, maybe we don't need to complicate this with all the
> > > Thunderbolt and device link stuff.  Which would be great, because the
> > > code change itself has nothing to do with those things.
> > 
> > Indeed.
> 
> I'd think it's still useful to leave "something" in the commit message about
> how we got to that conclusion though.
> 
> Bjorn, do you want me to to attempt to rewrite the commit message and send a
> v6, or would you like to?

Let me give it a try and post it for your reaction.

Bjorn
