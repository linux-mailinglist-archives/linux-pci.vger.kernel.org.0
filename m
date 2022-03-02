Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB954CB055
	for <lists+linux-pci@lfdr.de>; Wed,  2 Mar 2022 21:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbiCBUzr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Mar 2022 15:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbiCBUzr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Mar 2022 15:55:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966CFCA0C7
        for <linux-pci@vger.kernel.org>; Wed,  2 Mar 2022 12:55:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3BBCA6183D
        for <linux-pci@vger.kernel.org>; Wed,  2 Mar 2022 20:55:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE93C340E9;
        Wed,  2 Mar 2022 20:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646254502;
        bh=tV7w4saViO7EUo7xBhjGw3Efi0LTKT0dUJ8JH7+V4Kk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=hvbSE/jaSGylMF+MCNrnxZQ+5Ag2f0/LToMdo1+2Yb1bMb98U6RdY7MW4BE48oQ7D
         qnS9K5ugYhlyZ4bY0au93Tm8TW1nq7LjcnjTRH2eukF2D2cOzOc2VDMA9NZSKNT6gj
         ISBEGRke1K4zIEjzrPQWH27eDbDlOH7Lwt+Yh49JZ3R26haQep9KZyfqpAm1CsyGCV
         cQapzMkNE+LX9+gh1hezdZntAVceHuC/G3sdOdf29O12vzA47nxHKg3zTjJ71gxhoB
         mYgTf/f7V7umCm4WZ4AXGu1U/5Ue8mtLzO8BShW7j2LUF5pegox7F6sJv23btOnBQK
         FJaZBp6dkVYCA==
Date:   Wed, 2 Mar 2022 14:55:00 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jonathan Derrick <jonathan.derrick@linux.dev>
Cc:     "Patel, Nirmal" <nirmal.patel@linux.intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: vmd: Assign vmd irq domain before enumeration
Message-ID: <20220302205500.GA753039@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80ae742a-b958-c141-6c3e-cbdbd671990f@linux.dev>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 02, 2022 at 12:35:20PM -0700, Jonathan Derrick wrote:
> Hey Nirmal,
> 
> Sorry I didn't catch this earlier.
> 
> On 3/2/2022 10:41 AM, Patel, Nirmal wrote:
> > On 2/23/2022 12:52 AM, Nirmal Patel wrote:
> > > vmd creates and assigns separate irq domain only when MSI remapping is
> > > enabled. For example VMD-MSI. But vmd doesn't assign irq domain when
> > > MSI remapping is disabled resulting child devices getting default
> > > PCI-MSI irq domain. Now when Interrupt remapping is enabled all the
> > > pci devices are assigned INTEL-IR-MSI domain including vmd endpoints.
> > > But devices behind vmd gets PCI-MSI irq domain when vmd creates root
> > > bus and configures child devices.
> can you capitalize VMD for consistency?

And IRQ, while you're at it.  Both occur several times above (and
below).  And PCI.

Also, s/Interrupt remapping/interrupt remapping/ above, since
there's no reason to capitalize "Interrupt" there.

s/behind vmd gets/behind VMD get/

> > > As a result DMAR errors were observed when interrupt remapping was
> > > enabled on Intel Icelake CPUs.
> > > For instance:
> > > DMAR: DRHD: handling fault status reg 2
> > > DMAR: [INTR-REMAP] Request device [0xe2:0x00.0] fault index 0xa00
> > > [fault reason 0x25] Blocked a compatibility format interrupt request

Quote material as in 2565e5b69c44, e.g.,

  As a result DMAR errors were observed ...  For instance:

    DMAR: DRHD: handling fault status reg 2
    DMAR: [INTR-REMAP] Request device [0xe2:0x00.0] fault index 0xa00 [fault reason 0x25] Blocked a compatibility format interrupt request

(Blank line before and after quoted material, indent quote two spaces,
don't break messages over lines, so they're easy to grep for.)

> > > So make sure vmd assigns proper irq domain. This patch also removes
> > > a placeholder patch 2565e5b69c44 (PCI: vmd: Do not disable MSI-X
> > > remapping if interrupt remapping is enabled by IOMMU.)

Usual commit citation style is

  2565e5b69c44 ("PCI: vmd: Do not disable MSI-X remapping if interrupt
  remapping is enabled by IOMMU")

Why is this revert part of this patch?  Could it be a separate patch?
Either way, we should explain why we can now revert it.

> > > MSI remapping
> > > should be enabled or disabled with and without Interrupt remap.
> > > 
> So this keeps the performance path working with remapping?
> Great!
> 
> 
> > > Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> > > ---
> > >   drivers/pci/controller/vmd.c | 7 ++++---
> > >   1 file changed, 4 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> > > index cc166c683638..c8d73d75a1c0 100644
> > > --- a/drivers/pci/controller/vmd.c
> > > +++ b/drivers/pci/controller/vmd.c
> > > @@ -813,8 +813,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
> > >   	 * acceptable because the guest is usually CPU-limited and MSI
> > >   	 * remapping doesn't become a performance bottleneck.
> > >   	 */
> > > -	if (iommu_capable(vmd->dev->dev.bus, IOMMU_CAP_INTR_REMAP) ||
> > > -	    !(features & VMD_FEAT_CAN_BYPASS_MSI_REMAP) ||
> > > +	if (!(features & VMD_FEAT_CAN_BYPASS_MSI_REMAP) ||
> > >   	    offset[0] || offset[1]) {
> > >   		ret = vmd_alloc_irqs(vmd);
> > >   		if (ret)
> > > @@ -853,7 +852,9 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
> > >   	vmd_attach_resources(vmd);
> > >   	if (vmd->irq_domain)
> > >   		dev_set_msi_domain(&vmd->bus->dev, vmd->irq_domain);
> > > -
> > > +	else
> > > +		dev_set_msi_domain(&vmd->bus->dev, vmd->dev->dev.msi.domain);
> how about dev_get_msi_domain(vmd->dev) ?
> 
> > > +	
> > >   	vmd_acpi_begin();
> > >   	pci_scan_child_bus(vmd->bus);
> > 
> > Gentle ping!
> > 
> > Thanks
> > 
> > nirmal
> > 
