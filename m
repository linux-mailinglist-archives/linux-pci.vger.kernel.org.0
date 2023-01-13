Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B225B669E76
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jan 2023 17:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjAMQnu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Jan 2023 11:43:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjAMQnM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Jan 2023 11:43:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7017363D2F;
        Fri, 13 Jan 2023 08:41:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 25453B82196;
        Fri, 13 Jan 2023 16:41:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62132C433F0;
        Fri, 13 Jan 2023 16:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673628094;
        bh=FJhtEiC6ULwl4PcnADQiRPvVSQkqYUWhzXd8dnEWZMg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PlOwfN0gWWBpHjQTjn31FGB3azBt7UnFzDAlSY9DBqUONBzTMvt+sDky8ccI9HKf4
         +Ss19Db/75tOMdQXa+hx60haAPUSoO4xrNniDkQ9GAKtC3avI7hKkPLLZR+h+kRxm4
         c75TCmgsHzTVajmNrcX7gKkZM4EntJ7o2tVtKI6eMbVo4a+OPwqF+ieWReiEyZfw2T
         HHKyEFcufkjQDl7Q4/ZIe9v6GpLTnBDNGfxs/cKEZe1Re+ySl54gHLUMIGm6EHksqi
         DxFEZbfPKkn5KEJ0U2QpMETlln/nPTw5zElSP3feOsvTz22UBHaP+YKd8m53RcKLPU
         DA2e4NwIdvqUg==
Date:   Fri, 13 Jan 2023 17:41:28 +0100
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
        lorenzo.pieralisi@arm.com, hch@infradead.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com, michael.a.bottini@intel.com,
        rafael@kernel.org, me@adhityamohan.in, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V9 2/4] PCI: vmd: Use PCI_VDEVICE in device list
Message-ID: <Y8GJuE9KySv9AcHZ@lpieralisi>
References: <20221208023942.491721-1-david.e.box@linux.intel.com>
 <20221208023942.491721-3-david.e.box@linux.intel.com>
 <4d0d03c0-2880-1b90-ea94-e36d581ca040@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d0d03c0-2880-1b90-ea94-e36d581ca040@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 07, 2022 at 06:56:38PM -0800, Sathyanarayanan Kuppuswamy wrote:
> 
> 
> On 12/7/22 6:39 PM, David E. Box wrote:
> > Refactor the PCI ID list to use PCI_VDEVICE.
> 
> Add some info about why it is done.

I am waiting for the dust to settle on this series, it is pretty
close to completion it seems, please let me know when you consider
it ready.

Lorenzo

> > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > Reviewed-by: Jon Derrick <jonathan.derrick@linux.dev>
> > Reviewed-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> > ---
> >  V9 - No change
> > 
> >  V8 - No change
> > 
> >  V7 - New Patch. Separate patch suggested by Lorenzo
> > 
> >  drivers/pci/controller/vmd.c | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> > index e06e9f4fc50f..9dedca714c18 100644
> > --- a/drivers/pci/controller/vmd.c
> > +++ b/drivers/pci/controller/vmd.c
> > @@ -994,33 +994,33 @@ static int vmd_resume(struct device *dev)
> >  static SIMPLE_DEV_PM_OPS(vmd_dev_pm_ops, vmd_suspend, vmd_resume);
> >  
> >  static const struct pci_device_id vmd_ids[] = {
> > -	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_201D),
> > +	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_201D),
> >  		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP,},
> > -	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_28C0),
> > +	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_28C0),
> >  		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW |
> >  				VMD_FEAT_HAS_BUS_RESTRICTIONS |
> >  				VMD_FEAT_CAN_BYPASS_MSI_REMAP,},
> > -	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x467f),
> > +	{PCI_VDEVICE(INTEL, 0x467f),
> >  		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
> >  				VMD_FEAT_HAS_BUS_RESTRICTIONS |
> >  				VMD_FEAT_OFFSET_FIRST_VECTOR,},
> > -	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x4c3d),
> > +	{PCI_VDEVICE(INTEL, 0x4c3d),
> >  		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
> >  				VMD_FEAT_HAS_BUS_RESTRICTIONS |
> >  				VMD_FEAT_OFFSET_FIRST_VECTOR,},
> > -	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0xa77f),
> > +	{PCI_VDEVICE(INTEL, 0xa77f),
> >  		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
> >  				VMD_FEAT_HAS_BUS_RESTRICTIONS |
> >  				VMD_FEAT_OFFSET_FIRST_VECTOR,},
> > -	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x7d0b),
> > +	{PCI_VDEVICE(INTEL, 0x7d0b),
> >  		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
> >  				VMD_FEAT_HAS_BUS_RESTRICTIONS |
> >  				VMD_FEAT_OFFSET_FIRST_VECTOR,},
> > -	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0xad0b),
> > +	{PCI_VDEVICE(INTEL, 0xad0b),
> >  		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
> >  				VMD_FEAT_HAS_BUS_RESTRICTIONS |
> >  				VMD_FEAT_OFFSET_FIRST_VECTOR,},
> > -	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
> > +	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
> >  		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
> >  				VMD_FEAT_HAS_BUS_RESTRICTIONS |
> >  				VMD_FEAT_OFFSET_FIRST_VECTOR,},
> 
> -- 
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer
