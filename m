Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA20C6263C2
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 22:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbiKKVmP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 16:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbiKKVmO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 16:42:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0632E627F7;
        Fri, 11 Nov 2022 13:42:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 61759B827FB;
        Fri, 11 Nov 2022 21:42:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7EC1C433D6;
        Fri, 11 Nov 2022 21:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668202930;
        bh=cYMaPDX0W9LPdkEux2CBvkLVgOG4dFnW48WsrbjtPu4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=f1icSkwnHQ2Bfr1yLVBA4XMr5L9uaAJ6TYNdX7XXUogUZWk1unWiQKkmqX076U1nW
         aWEnEpkzICXV30Ta0iLtgJeKHWfJ6rbI7f8yOCTnlUS/KRFv1hP9qn58Yr/Y9yd6ND
         lEJ1JFctVQHkrZMXdw6+LvFgZoMdDP2yOsODT9udNHiulxbfqeLzBuHUYzipXnJRh7
         gG36qHM/uLih5F/eZKL7JKITijLYFL3qTSRzrF5H0rsnfyjeqF+NjIIZKvZM0558Fo
         he+waLkFNQnUtmWys4FlKLxdItx6LtQDtxSHoK31dCLMDl57flgaqMUFG/5Vcs/Inl
         KlfPcgA5WWbhA==
Date:   Fri, 11 Nov 2022 15:42:09 -0600
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
Message-ID: <20221111214209.GA748269@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5754039e-e3c6-cdb8-8d64-6332b0093940@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 11, 2022 at 12:58:28PM -0600, Limonciello, Mario wrote:
> On 11/11/2022 11:41, Bjorn Helgaas wrote:
> > On Mon, Oct 31, 2022 at 05:33:55PM -0500, Mario Limonciello wrote:
> > > Firmware typically advertises that ACPI devices that represent PCIe
> > > devices can support D3 by a combination of the value returned by
> > > _S0W as well as the HotPlugSupportInD3 _DSD [1].
> > > 
> > > `acpi_pci_bridge_d3` looks for this combination but also contains
> > > an assumption that if an ACPI device contains power resources the PCIe
> > > device it's associated with can support D3.  This was introduced
> > > from commit c6e331312ebf ("PCI/ACPI: Whitelist hotplug ports for
> > > D3 if power managed by ACPI").
> > > 
> > > Some firmware configurations for "AMD Pink Sardine" do not support
> > > wake from D3 in _S0W for the ACPI device representing the PCIe root
> > > port used for tunneling. The PCIe device will still be opted into
> > > runtime PM in the kernel [2] because of the logic within
> > > `acpi_pci_bridge_d3`. This currently happens because the ACPI
> > > device contains power resources.

Wait.  Is this as simple as just recognizing that:

  _PS0 means the OS has a knob to put the device in D0, but it doesn't
  mean the device can wake itself from a low-power state.  The OS has
  to use _S0W to learn the device's ability to wake itself.

If that's enough, maybe we don't need to complicate this with all the
Thunderbolt and device link stuff.  Which would be great, because the
code change itself has nothing to do with those things.

Bjorn
