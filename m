Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C71944C84A4
	for <lists+linux-pci@lfdr.de>; Tue,  1 Mar 2022 08:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiCAHFi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Mar 2022 02:05:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbiCAHFg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Mar 2022 02:05:36 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F9252E11;
        Mon, 28 Feb 2022 23:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646118296; x=1677654296;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cNy2VhZ7uIfEAZ6OMEmFA5tBH3wtQ7ZLN6kAGMbwVEs=;
  b=mYSJjN0gKehKuYKq5WJVAiuEgY2oQG56vZZzrpej9N28jyhrB6oVIZTq
   LIkc7wWwoc/GRUZ1USteBGa3lBWxP1JUcXKoAdFat6uuu4ucmhUoe/d74
   TlE+SjT+gLOIc7vUeKdYQqSikytCoTs8EMTDUwEiZLJksMNCYuVqX5ST5
   XmfDQY5e1E/Ckp46ggpQzE4Wl9hedumSNEyEIZYAKMnM2FC9E7HUFwCUw
   bcBRAo4o4Xl3hKq2JuL8FSQeFa/Dgxkzc4YP/rf676N3NPnh5o+ztQqyN
   YMzr21NBtUGTDAhW2Q1F6ghgTLZZ3xUYDGlEM6iuCqhUWoUlw98qagowT
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="316287788"
X-IronPort-AV: E=Sophos;i="5.90,145,1643702400"; 
   d="scan'208";a="316287788"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 23:04:54 -0800
X-IronPort-AV: E=Sophos;i="5.90,145,1643702400"; 
   d="scan'208";a="510405909"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 23:04:49 -0800
Received: by lahna (sSMTP sendmail emulation); Tue, 01 Mar 2022 09:04:47 +0200
Date:   Tue, 1 Mar 2022 09:04:47 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
        Michael Jamet <michael.jamet@intel.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        "open list:RADEON and AMDGPU DRM DRIVERS" 
        <amd-gfx@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <nouveau@lists.freedesktop.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH v5 3/7] PCI: Drop the `is_thunderbolt` attribute from PCI
 core
Message-ID: <Yh3Fj8kA5mkbp8Hp@lahna>
References: <BL1PR12MB5157004F38E3FEFF046D9BE4E2019@BL1PR12MB5157.namprd12.prod.outlook.com>
 <20220228221344.GA529289@bhelgaas>
 <20220228223246.GA11428@wunner.de>
 <BL1PR12MB5157D5E18AB8206E2085C952E2019@BL1PR12MB5157.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR12MB5157D5E18AB8206E2085C952E2019@BL1PR12MB5157.namprd12.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Mon, Feb 28, 2022 at 10:36:59PM +0000, Limonciello, Mario wrote:
> [AMD Official Use Only]
> 
> > -----Original Message-----
> > From: Lukas Wunner <lukas@wunner.de>
> > Sent: Monday, February 28, 2022 16:33
> > To: Bjorn Helgaas <helgaas@kernel.org>
> > Cc: Limonciello, Mario <Mario.Limonciello@amd.com>; Mika Westerberg
> > <mika.westerberg@linux.intel.com>; Michael Jamet
> > <michael.jamet@intel.com>; open list:PCI SUBSYSTEM <linux-
> > pci@vger.kernel.org>; open list:THUNDERBOLT DRIVER <linux-
> > usb@vger.kernel.org>; Yehezkel Bernat <YehezkelShB@gmail.com>; open
> > list:DRM DRIVERS <dri-devel@lists.freedesktop.org>; open list:X86
> > PLATFORM DRIVERS <platform-driver-x86@vger.kernel.org>; Andreas
> > Noever <andreas.noever@gmail.com>; open list:RADEON and AMDGPU
> > DRM DRIVERS <amd-gfx@lists.freedesktop.org>; open list:DRM DRIVER FOR
> > NVIDIA GEFORCE/QUADRO GPUS <nouveau@lists.freedesktop.org>; Bjorn
> > Helgaas <bhelgaas@google.com>; Deucher, Alexander
> > <Alexander.Deucher@amd.com>
> > Subject: Re: [PATCH v5 3/7] PCI: Drop the `is_thunderbolt` attribute from PCI
> > core
> > 
> > On Mon, Feb 28, 2022 at 04:13:44PM -0600, Bjorn Helgaas wrote:
> > > On Mon, Feb 28, 2022 at 03:33:13PM +0000, Limonciello, Mario wrote:
> > > > > On Fri, Feb 25, 2022 at 11:42:24AM -0600, Bjorn Helgaas wrote:
> > > > > > That would just leave the "PCI_VSEC_ID_INTEL_TBT implies external-
> > > > > facing"
> > > > > > assumption above.  Not having a Thunderbolt spec, I have no idea
> > how
> > > > > > you deal with that.
> > > > >
> > > > > You can download the spec here:
> > [...]
> > > > > Inside the archive there is also the DVSEC spec with name "USB4 DVSEC
> > > > > Version 1.0.pdf".
> > > >
> > > > The spec has Host_Router_indication (bits 18-19) as meaning external
> > facing.
> > > > I'll respin the patch 3 for using that.
> > >
> > > Thanks, please include the spec citation when you do.  And probably
> > > the URL, because it's not at all obvious how the casual reader would
> > > get from "is_thunderbolt" to a recent add-on to the USB4 spec.
> > 
> > PCI_VSEC_ID_INTEL_TBT is not mentioned at all in the USB4 spec,
> > hence there's no connection between "is_thunderbolt" and the USB4 spec.
> > 
> > It's a proprietary VSEC used by Intel and the only way to recognize
> > pre-USB4 Thunderbolt devices that I know of.  Its ID is also
> > different from the DVSEC IDs given in the above-mentioned spec.
> > 
> > Thanks,
> 
> The USB4 DVSEC spec makes comments about DVSEC_ID of 0x8086 and also
> DVSEC VENDOR_ID of 0x8086.  Is that not also present on the Intel TBT3 controllers?
> 
> My interpretation of this (and Mika's comment) was that rather than
> looking at the Intel VSEC we should look at the USB4 DVSEC to detect
> the Intel TBT3 controllers.

For pre-USB4 controllers (TBT 1-3) we need to use the existing method
(or a quirk based on device ID) as they don't have the USB4 DVSEC.
