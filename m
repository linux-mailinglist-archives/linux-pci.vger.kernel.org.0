Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF065512ED6
	for <lists+linux-pci@lfdr.de>; Thu, 28 Apr 2022 10:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344720AbiD1Is1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Apr 2022 04:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344612AbiD1Irt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Apr 2022 04:47:49 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5EFD926FF
        for <linux-pci@vger.kernel.org>; Thu, 28 Apr 2022 01:40:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2ACE61474;
        Thu, 28 Apr 2022 01:40:47 -0700 (PDT)
Received: from lpieralisi (unknown [10.57.13.193])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 81FA53F774;
        Thu, 28 Apr 2022 01:40:46 -0700 (PDT)
Date:   Thu, 28 Apr 2022 09:40:41 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     "Patel, Nirmal" <nirmal.patel@linux.intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 1/2] PCI: vmd: Assign VMD IRQ domain before enumeration
Message-ID: <20220428084041.GA15506@lpieralisi>
References: <20220405171005.45586-1-nirmal.patel@linux.intel.com>
 <b2b73869-9889-a70f-73a9-bb7215ab7daf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2b73869-9889-a70f-73a9-bb7215ab7daf@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 27, 2022 at 07:21:08PM -0700, Patel, Nirmal wrote:
> On 4/5/2022 10:10 AM, Nirmal Patel wrote:
> > VMD creates and assigns a separate IRQ domain only when MSI remapping is
> > enabled. For example VMD-MSI. But VMD doesn't assign IRQ domain when
> > MSI remapping is disabled resulting child devices getting default
> > PCI-MSI IRQ domain. Now when interrupt remapping is enabled by
> > intel-iommu all the PCI devices are assigned INTEL-IR-MSI domain
> > including VMD endpoints. But devices behind VMD get PCI-MSI IRQ domain
> > when VMD create a root bus and configures child devices.
> >
> > As a result DMAR errors were observed when interrupt remapping was
> > enabled on Intel Icelake CPUs. For instance:
> >
> >   DMAR: DRHD: handling fault status reg 2
> >   DMAR: [INTR-REMAP] Request device [0xe2:0x00.0] fault index 0xa00 [fault reason 0x25] Blocked a compatibility format interrupt request
> >
> > Acked-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> > ---
> > v2->v3: Update commit log.
> > v1->v2: Split patch into two separate patches. One applies the fix and
> > 	other reverts the commit 2565e5b69c44 which was added as a
> > 	workaround.
> > ---
> >  drivers/pci/controller/vmd.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> > index cc166c683638..3a6570e5b765 100644
> > --- a/drivers/pci/controller/vmd.c
> > +++ b/drivers/pci/controller/vmd.c
> > @@ -853,6 +853,8 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
> >  	vmd_attach_resources(vmd);
> >  	if (vmd->irq_domain)
> >  		dev_set_msi_domain(&vmd->bus->dev, vmd->irq_domain);
> > +	else
> > +		dev_set_msi_domain(&vmd->bus->dev, dev_get_msi_domain(&vmd->dev->dev));
> >  
> >  	vmd_acpi_begin();
> >  
> 
> Gentle reminder.

Instead of sending these reminders, could you please, as Bjorn
requested, fix your patch posting flow to make sure your patches are
logged in lore and patchwork/linux-pci, where I look for patches to
review please ?

There is no point in sending reminders for something I don't see,
I have no idea you are waiting for me to review this series if it
does not show up in patchwork/linux-pci, if it is not there for
me it does not exist.

Thanks,
Lorenzo


