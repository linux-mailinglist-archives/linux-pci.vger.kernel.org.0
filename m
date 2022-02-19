Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058B04BCA65
	for <lists+linux-pci@lfdr.de>; Sat, 19 Feb 2022 20:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbiBSTEj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 19 Feb 2022 14:04:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234188AbiBSTEj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 19 Feb 2022 14:04:39 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7841D0C8;
        Sat, 19 Feb 2022 11:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645297457; x=1676833457;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Id7PccVx1dTQUjTAWCdj0oxuQ0emN1aAc5phA2X2hIU=;
  b=kC6XlErFnsZPso9Fuhz8ddVlnWttm9NBEx28tMuR2KcP8dgDXzVNNtGe
   jkFoyqoeqiRZzuqS33AQ6bExwLzGijWiSnOD0apU3Hnz2NKl+JL79KlZW
   qOVXNeCTH6wg+XuH34H5whJoYIiv2rGVmlsPMN6rxPqEqs1n+ccX9lsMv
   T8bxgCucgFZEiql/7FHXp4ZtGkJ88FZw405stWk5ub9HhRS4kRL4MdBnY
   CByz3X7I/v6/CxmsGvyscLwm1zfRmbpUJTefRfU+LOuHvr53wwIpYiN8K
   umSoBC9n1zmgYposPEPNNplY6M/CQj3GyO61SJjUCYp5LPSbdQiuEaFiy
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10263"; a="231286852"
X-IronPort-AV: E=Sophos;i="5.88,381,1635231600"; 
   d="scan'208";a="231286852"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2022 11:04:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,381,1635231600"; 
   d="scan'208";a="626945610"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Feb 2022 11:04:17 -0800
Received: from kpavlasx-mobl2.amr.corp.intel.com (kpavlasx-mobl2.amr.corp.intel.com [10.209.114.238])
        by linux.intel.com (Postfix) with ESMTP id A0A8A580191;
        Sat, 19 Feb 2022 11:04:16 -0800 (PST)
Message-ID: <27f83612922249a845e9d93134d92e8cb278346c.camel@linux.intel.com>
Subject: Re: [PATCH V5 2/3] PCI: vmd: Add vmd_device_data
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Jonathan Derrick <jonathan.derrick@linux.dev>,
        nirmal.patel@linux.intel.com, lorenzo.pieralisi@arm.com,
        hch@infradead.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, michael.a.bottini@linux.intel.com,
        rafael@kernel.org, me@adhityamohan.in
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sat, 19 Feb 2022 11:04:16 -0800
In-Reply-To: <366a9602-555f-7a1b-a8db-bbcbf84b7b08@linux.dev>
References: <20220218045056.333799-1-david.e.box@linux.intel.com>
         <20220218045056.333799-3-david.e.box@linux.intel.com>
         <366a9602-555f-7a1b-a8db-bbcbf84b7b08@linux.dev>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 2022-02-18 at 14:19 -0700, Jonathan Derrick wrote:
> Hi David,
> 
> On 2/17/2022 9:50 PM, David E. Box wrote:
> > Add vmd_device_data to allow adding additional info for driver
> > data. Also
> > refactor the PCI ID list to use PCI_VDEVICE and simplify
> > assignments for
> > devices that use the same driver_data.
> > 
> > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > ---
> > 
> > V5
> >    - New patch
> > 
> >   drivers/pci/controller/vmd.c | 58 ++++++++++++++++++++-----------
> > -----
> >   1 file changed, 32 insertions(+), 26 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/vmd.c
> > b/drivers/pci/controller/vmd.c
> > index cc166c683638..a582c351b461 100644
> > --- a/drivers/pci/controller/vmd.c
> > +++ b/drivers/pci/controller/vmd.c
> > @@ -69,6 +69,10 @@ enum vmd_features {
> >   	VMD_FEAT_CAN_BYPASS_MSI_REMAP		= (1 << 4),
> >   };
> >   
> > +struct vmd_device_data {
> > +	enum vmd_features features;
> > +};
> > +
> >   static DEFINE_IDA(vmd_instance_ida);
> >   
> >   /*
> > @@ -710,11 +714,12 @@ static void vmd_copy_host_bridge_flags(struct
> > pci_host_bridge *root_bridge,
> >   	vmd_bridge->native_dpc = root_bridge->native_dpc;
> >   }
> >   
> > -static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long
> > features)
> > +static int vmd_enable_domain(struct vmd_dev *vmd, struct
> > vmd_device_data *info)
> >   {
> >   	struct pci_sysdata *sd = &vmd->sysdata;
> >   	struct resource *res;
> >   	u32 upper_bits;
> > +	unsigned long features = info->features;
> >   	unsigned long flags;
> >   	LIST_HEAD(resources);
> >   	resource_size_t offset[2] = {0};
> > @@ -881,7 +886,8 @@ static int vmd_enable_domain(struct vmd_dev
> > *vmd, unsigned long features)
> >   
> >   static int vmd_probe(struct pci_dev *dev, const struct
> > pci_device_id *id)
> >   {
> > -	unsigned long features = (unsigned long) id->driver_data;
> > +	struct vmd_device_data *info = (struct vmd_device_data *)id-
> > >driver_data;
> > +	unsigned long features = info->features;
> >   	struct vmd_dev *vmd;
> >   	int err;
> >   
> > @@ -925,7 +931,7 @@ static int vmd_probe(struct pci_dev *dev, const
> > struct pci_device_id *id)
> >   
> >   	spin_lock_init(&vmd->cfg_lock);
> >   	pci_set_drvdata(dev, vmd);
> > -	err = vmd_enable_domain(vmd, features);
> > +	err = vmd_enable_domain(vmd, info);
> >   	if (err)
> >   		goto out_release_instance;
> >   
> > @@ -993,30 +999,30 @@ static int vmd_resume(struct device *dev)
> >   #endif
> >   static SIMPLE_DEV_PM_OPS(vmd_dev_pm_ops, vmd_suspend,
> > vmd_resume);
> >   
> > +static const struct vmd_device_data vmd_201d_data = {
> > +	.features = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP,
> > +};
> > +
> > +static const struct vmd_device_data vmd_28c0_data = {
> > +	.features = VMD_FEAT_HAS_MEMBAR_SHADOW |
> > +		    VMD_FEAT_HAS_BUS_RESTRICTIONS |
> > +		    VMD_FEAT_CAN_BYPASS_MSI_REMAP,
> > +};
> > +
> > +static const struct vmd_device_data vmd_467f_data = {
> > +	.features = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
> > +		    VMD_FEAT_HAS_BUS_RESTRICTIONS |
> > +		    VMD_FEAT_OFFSET_FIRST_VECTOR,
> > +};
> > +
> 
> I'm not the biggest fan of this structure
> Can you inline the declarations into the vmd_ids table below?
> 
> 
> 
> >   static const struct pci_device_id vmd_ids[] = {
> > -	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_201D),
> > -		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP,},
> > -	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_28C0),
> > -		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW |
> > -				VMD_FEAT_HAS_BUS_RESTRICTIONS |
> > -				VMD_FEAT_CAN_BYPASS_MSI_REMAP,},
> > -	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x467f),
> > -		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
> > -				VMD_FEAT_HAS_BUS_RESTRICTIONS |
> > -				VMD_FEAT_OFFSET_FIRST_VECTOR,},
> > -	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x4c3d),
> > -		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
> > -				VMD_FEAT_HAS_BUS_RESTRICTIONS |
> > -				VMD_FEAT_OFFSET_FIRST_VECTOR,},
> > -	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0xa77f),
> > -		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
> > -				VMD_FEAT_HAS_BUS_RESTRICTIONS |
> > -				VMD_FEAT_OFFSET_FIRST_VECTOR,},
> > -	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
> > -		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
> > -				VMD_FEAT_HAS_BUS_RESTRICTIONS |
> > -				VMD_FEAT_OFFSET_FIRST_VECTOR,},
> > -	{0,}
> > +	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_201D),
> > (kernel_ulong_t)&vmd_201d_data },
> > +	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_28C0),
> > (kernel_ulong_t)&vmd_28c0_data },
> > +	{ PCI_VDEVICE(INTEL, 0x467f), (kernel_ulong_t)&vmd_467f_data },
> > +	{ PCI_VDEVICE(INTEL, 0x4c3d), (kernel_ulong_t)&vmd_467f_data },
> > +	{ PCI_VDEVICE(INTEL, 0xa77f), (kernel_ulong_t)&vmd_467f_data },
> > +	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
> > (kernel_ulong_t)&vmd_467f_data },
> > +	{ }
> 
> For instance:
> { PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_201D),
> (kernel_ulong_t)&(struct vmd_device_data) {
> 							.features =
> VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP,

Sure.

David

> 
> 
> >   };
> >   MODULE_DEVICE_TABLE(pci, vmd_ids);
> >   

