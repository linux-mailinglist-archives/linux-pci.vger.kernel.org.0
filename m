Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F3B611B7C
	for <lists+linux-pci@lfdr.de>; Fri, 28 Oct 2022 22:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiJ1UWf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Oct 2022 16:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJ1UWd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Oct 2022 16:22:33 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8856B1E3EF8;
        Fri, 28 Oct 2022 13:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666988552; x=1698524552;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Zaho+B/YL7/9kX/wMDa/kjF3p1Otv6zFxWzCOBgXNOc=;
  b=C+bQr/+NAj0xd+cvVSYItIdwz9WuKSaSMhc6zoJpsOCpvlclc47lZt2P
   4b3Z6v3ue5VTEHUkx5Bugm21MROkeSi6HRwdkl7yRyFcy7ebFrNAekGGA
   lkgOiZTpWZUVbV977T446zzu9Jj5XzQj8gddQiMlY0oDDlDLqmdHkjhrA
   o4g2NGn4+8Xga77OhH2KGJELEZkAd2e7X8lb3scdx/lYvr6DjiOb9GnqB
   xBlKRtkEXPW0WRqkcj64yc7FsQOsT//uejdmP7aEvsZFABXbJXVp/Jl4s
   imHjj49vAKkLmTydTbwP6lmsc+rxMynbXimERUHpQCr2doT1d0NOpklto
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="291880729"
X-IronPort-AV: E=Sophos;i="5.95,222,1661842800"; 
   d="scan'208";a="291880729"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2022 13:22:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="962152830"
X-IronPort-AV: E=Sophos;i="5.95,222,1661842800"; 
   d="scan'208";a="962152830"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 28 Oct 2022 13:22:31 -0700
Received: from dckekula-mobl1.amr.corp.intel.com (unknown [10.209.84.4])
        by linux.intel.com (Postfix) with ESMTP id E00FB5808F0;
        Fri, 28 Oct 2022 13:22:30 -0700 (PDT)
Message-ID: <85336561282c1c444501b799096e9c94b23722e0.camel@linux.intel.com>
Subject: Re: [PATCH V7 3/4] PCI: vmd: Add vmd_device_data
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Jonathan Derrick <jonathan.derrick@linux.dev>
Cc:     nirmal.patel@linux.intel.com, lorenzo.pieralisi@arm.com,
        hch@infradead.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, michael.a.bottini@intel.com,
        rafael@kernel.org, me@adhityamohan.in, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 28 Oct 2022 13:22:30 -0700
In-Reply-To: <20221028194014.GA907046@bhelgaas>
References: <20221028194014.GA907046@bhelgaas>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 2022-10-28 at 14:40 -0500, Bjorn Helgaas wrote:
> On Fri, Oct 28, 2022 at 02:18:48PM -0500, Jonathan Derrick wrote:
> > On 10/28/2022 2:13 PM, Bjorn Helgaas wrote:
> > > On Mon, Oct 24, 2022 at 05:44:10PM -0700, David E. Box wrote:
> > > > Add vmd_device_data to allow adding additional info for driver data.
> > > >  	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
> > > > -		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
> > > > -				VMD_FEAT_HAS_BUS_RESTRICTIONS |
> > > > -				VMD_FEAT_OFFSET_FIRST_VECTOR,},
> > > > +		(kernel_ulong_t)&(struct vmd_device_data) {
> > > > +			.features = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
> > > > +				    VMD_FEAT_HAS_BUS_RESTRICTIONS |
> > > > +				    VMD_FEAT_OFFSET_FIRST_VECTOR,
> > > > +		},
> > > > +	},
> > > 
> > > It looks like these devices come in families where several device IDs
> > > share the same features.  I think this would be more readable if you
> > > defined each family outside this table and simply referenced the
> > > family here.  E.g., you could do something like:
> > > 
> > >   static struct vmd_device_data vmd_v1 = {
> > >     .features = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
> > > 		VMD_FEAT_HAS_BUS_RESTRICTIONS |
> > > 		VMD_FEAT_OFFSET_FIRST_VECTOR,
> > >   };
> > 
> > I seem to recall it being similar to this in one of the previous revisions
> > It's fine with me either way
> 
> Indeed it was:
> https://lore.kernel.org/r/366a9602-555f-7a1b-a8db-bbcbf84b7b08@linux.dev
> I'd forgotten that.
> 
> At the time there were four devices (0x467f 0x4c3d 0xa77f 0x9a0b)
> that used the 467f data.  The current series adds two more (0x7d0b
> 0x0ad0b).  Maybe the "vmd_467f_data" name could have been more
> descriptive, but the code was definitely shorter:
> 
>   +     { PCI_VDEVICE(INTEL, 0x467f), (kernel_ulong_t)&vmd_467f_data },
>   +     { PCI_VDEVICE(INTEL, 0x4c3d), (kernel_ulong_t)&vmd_467f_data },
>   +     { PCI_VDEVICE(INTEL, 0xa77f), (kernel_ulong_t)&vmd_467f_data },
>   +     { PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
> (kernel_ulong_t)&vmd_467f_data },

I prefer this too but don't know what's the best name. Could just be by the
platform that started this grouping, e.g. vmd_tgl_data for Tiger Lake. What do
you think Jonathan?

David

> 
> I do wish pci_device_id.driver_data were a void pointer, as it is for
> of_device_id, which makes it much more natural to express [1], but
> that ship has long sailed.
> 
> [1] 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/dwc/pcie-kirin.c?id=v6.0#n768
> 
> > >   {PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
> > >     .driver_data = (kernel_ulong_t) &vmd_v1,
> > > 
> > > Then you can add VMD_FEAT_BIOS_PM_QUIRK and the .ltr value in one place
> > > instead of repeating it a half dozen times.
> > > 
> > > >  	{0,}
> > > >  };
> > > >  MODULE_DEVICE_TABLE(pci, vmd_ids);
> > > > -- 
> > > > 2.25.1
> > > > 

