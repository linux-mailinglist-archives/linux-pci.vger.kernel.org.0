Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF5072A657
	for <lists+linux-pci@lfdr.de>; Sat, 10 Jun 2023 00:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjFIWqm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Jun 2023 18:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjFIWql (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Jun 2023 18:46:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DA43A86;
        Fri,  9 Jun 2023 15:46:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B65D6141C;
        Fri,  9 Jun 2023 22:46:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BDEDC433D2;
        Fri,  9 Jun 2023 22:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686350799;
        bh=FtH2QZMQ1JGLR5r1ba0Fxz9Y54cyrhKmVHcch9tZEDk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Agn8Af7OQtIjX5cP6IES+ilkotj4Z7zQAzTJvkjdjpvLFieQB8/DcAAfHtq8cCIWw
         KW23YjJGYbnv/V3p+6deXqEdKK+HuLpcMqkCq+6n0oc0msVhsyOMAxYRNXasoYXazH
         qHFkyo3Dz/Cvjci/qnvPUy3ZzjI9mErBKxNExx0/PviMNEdSyWfmV4MNUbRJgoOjWR
         JPW1XVMlet6/b4aiIaybZbaLpy1BIPle9ohpdvyx+BRXe1UZVF/WQrHSRpiGsak3Ws
         +y5v3zA/ixzLke0yyAlzeo9VUwpSR13uFfR4x+z7MOmncuwsrJ7QpFEnw0Gldy52o8
         fWHM4wAGZFYFA==
Date:   Fri, 9 Jun 2023 17:46:37 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     me@adhityamohan.in, kw@linux.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, linux-pci@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, hch@infradead.org,
        jonathan.derrick@linux.dev, bhelgaas@google.com,
        nirmal.patel@linux.intel.com, michael.a.bottini@intel.com
Subject: Re: [Intel-gfx] [PATCH V2] PCI: Move VMD ASPM/LTR fix to PCI quirk
Message-ID: <20230609224637.GA1267887@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fd3212e6f74dee60c66dee821f601e9440c5ae67.camel@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 09, 2023 at 03:09:26PM -0700, David E. Box wrote:
> Hi Bjorn,
> 
> On Thu, 2023-06-08 at 15:52 -0500, Bjorn Helgaas wrote:
> > On Tue, Apr 11, 2023 at 02:33:23PM -0700, David E. Box wrote:
> > > In commit f492edb40b54 ("PCI: vmd: Add quirk to configure PCIe ASPM and
> > > LTR") the VMD driver calls pci_enabled_link_state as a callback from
> > > pci_bus_walk. Both will acquire the pci_bus_sem lock leading to a lockdep
> > > warning. Instead of doing the pci_bus_walk, move the fix to quirks.c using
> > > DECLARE_PCI_FIXUP_FINAL.

> > > +#define VMD_DEVICE_LTR 0x1003  /* 3145728 ns */
> > 
> > It would be nice to know how this value was derived.  But I know we
> > had this hard-coded value before, so it's not new with this patch.
> 
> Do you mean to show the multiplier that determines that value or to
> say why this particular number was chosen? For the latter, it the
> largest that could be set (given the multipier options) that will
> allow the SoC to get to it's lowest power state. And it's the same
> so far on all the SoCs covered by the VMD driver.

Oh, sorry, I meant "why this number was chosen".  PCIe r6.0, sec
7.8.2, says this capability allows software to provide "platform
latency information," so I assume this is somehow dependent on
platform, but I really don't understand the details of how LTR works,
and we didn't have an explanation before, so this was just a "if you
happen to know, it might be useful here" comment.

> > > +static void quirk_intel_vmd(struct pci_dev *pdev)
> > 
> > I think this quirk could possibly stay in
> > drivers/pci/controller/vmd.c, couldn't it?  It has a lot of
> > VMD-specific knowledge that it would nice to contain in vmd.c.
> 
> I may have misunderstood your comment on V1 then. But you suggested
> that this would be typically done as PCI_FIXUP so that the PCI core
> could call it and we could avoid the locking issue that was seen
> while walking the bus in vmd.c.

Right, I think it makes sense to be a DECLARE_PCI_FIXUP_CLASS_FINAL(),
but I was thinking that it could be implemented in vmd.c and still be
called by the PCI core.

But now I'm uncertain since vmd.c can be compiled as a module, and I'm
not sure how that could work, since pci_fixup_device() calls things in
the __start_pci_fixups_final[] table, and I don't see how loading a
module would insert the fixup entry into that table.

So maybe it needs to be in quirks.c after all.

I think my only remaining questions here are about how to identify
devices below VMD and the order of enabling ASPM states vs setting
LTR.

Bjorn
