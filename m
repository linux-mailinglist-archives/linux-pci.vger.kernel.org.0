Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91DB74FC500
	for <lists+linux-pci@lfdr.de>; Mon, 11 Apr 2022 21:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349207AbiDKTZd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Apr 2022 15:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiDKTZc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Apr 2022 15:25:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC5B1098;
        Mon, 11 Apr 2022 12:23:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9D43614FF;
        Mon, 11 Apr 2022 19:23:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83187C385A3;
        Mon, 11 Apr 2022 19:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649704996;
        bh=tmSDuqNUHvsaWRtzIyZ9WnDFsd3xmPFiXXja+DVu69Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=h7IiUkYwyvxf6ZTBMQd3QpnzSnpFttxpxvzmlbDd9YCu2cRI+AS63mfYFqZYKBGhk
         zdfZ7C+sXry6672QSiR019M2rqoRE+uqZDm5ruICOTK3aDXo471jcx7HVX1U5gOxE8
         DekdlN4Cp6d1enkdclHFaYBDYh7b/6830XADdrpO33h3v+hYLlFaYibkCoh6V6mdC7
         4nFIDRGCt5RSTV7q0lZ11Fn8D3thi7tYNb4dar0NxDC1YmMQer6XnRhSJ6ptiQpPZ9
         tNk9QQv4WQHGd9NU2+MgCf6+3Co/NFKyv8BV+nQ+t7eO8A9lEtRS0dhnegew/uiR0d
         5tJzQf9aHjaaA==
Date:   Mon, 11 Apr 2022 14:23:12 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH RESEND 1/2] PCI: Extend isolated function probing to s390
Message-ID: <20220411192312.GA531449@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e565547113567e9fd6cacce333bc28d2af088b72.camel@linux.ibm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 11, 2022 at 10:43:56AM +0200, Niklas Schnelle wrote:
> On Fri, 2022-04-08 at 17:45 -0500, Bjorn Helgaas wrote:
> > On Mon, Apr 04, 2022 at 11:53:45AM +0200, Niklas Schnelle wrote:
> > > Like the jailhouse hypervisor s390's PCI architecture allows passing
> > > isolated PCI functions to an OS instance. As of now this is was not
> > > utilized even with multi-function support as the s390 PCI code makes
> > > sure that only virtual PCI busses including a function with devfn 0 are
> > > presented to the PCI subsystem. A subsequent change will remove this
> > > restriction.
> > > 
> > > Allow probing such functions by replacing the existing check for
> > > jailhouse_paravirt() with a new hypervisor_isolated_pci_functions()
> > > helper.
> > > 
> > > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > 
> > I'm OK with the idea of generalizing this Jailhouse test, but I wonder
> > if this check should be in pci_scan_slot() rather than in
> > pci_scan_child_bus_extend().
> > 
> > I think the idea is that pci_scan_slot() should find all the functions
> > of a device (a.k.a. "slot"), so it's a little weird to have a loop
> > calling pci_scan_single_device() for each function in both places.
> 
> Yeah, I agree.
> > 
> > Currently we never call pcie_aspm_init_link_state() for these
> > Jailhouse or s390 functions.  Maybe that's OK (and I think
> > pci_scan_slot() is the wrong place to initialize ASPM anyway) but if
> > we could move the Jailhouse/s390 checking to pci_scan_slot(), it would
> > at least remove the inconsistency.
> > 
> > I'm thinking something along the lines of the patch below.  I'm sure
> > Jan considered this originally, so maybe there's some reason this
> > won't work.
> 
> One thing I already noticed is that I think next_fn() may need to be
> changed. If pci_ari_enabled(bus) is true, then it immediately returns 0
> on dev == NULL while if it is false there is an extra check for non-
> contiguous multifunction devices. Even then I think on jailhouse() dev-
> >multifunction might not be set at that point. This is in contrast to
> s390 where we set dev->multifunction based on information provided by
> the platform before scanning the bus. So I'll have to be careful not to
> create a state where this works on s390 but might not work for
> jailhouse.
> 
> I also do wonder what the role of the PCI_SCAN_ALL_PCIE_DEVS flag
> should be here. At least the comment in only_one_child() sounds a lot
> like that flag kind of indicates the same thing.

I looked at PCI_SCAN_ALL_PCIE_DEVS, too, but I think that's for a
slightly different situation; see
https://git.kernel.org/linus/284f5f9dbac1

Bjorn
