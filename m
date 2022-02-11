Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9244B2314
	for <lists+linux-pci@lfdr.de>; Fri, 11 Feb 2022 11:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243963AbiBKK12 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Feb 2022 05:27:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238663AbiBKK11 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Feb 2022 05:27:27 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6084DE47;
        Fri, 11 Feb 2022 02:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644575247; x=1676111247;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RCuCxhjV4esmnxdab6oU2vPqQ9Idnpu43es31WIDuUM=;
  b=mUtE7WikhP45LXtbdFLzf/K6XNii7C2kuabCpio2HB7JA/9zpHhHUTNs
   Lr0ejHOf9VO1gBNkkpylSYZlCBmqsth3xo/z71iD2vj9yc+pjpwI7ZUh/
   njLwJKDEYMM+eIz19Fi4k+SAq6K2nn/l6SCr6jbydAFAOmj09sIVUDo0x
   RKeO16rYPY1lD+M6QakVDI+LLeStHxUJyK0tmoU/5UWkLa406nm+TdCEw
   baW6qWY9cbND1xCLMR7aBoSe/yZ36TYoQQTNsyhW8lc4zCpQ4yIokyaAA
   WO0vtmkmVwdHkhdMibuhH2HFoZHZAmVSgVJBBmlxkUQIt5mYxQLUomhfV
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="312990242"
X-IronPort-AV: E=Sophos;i="5.88,360,1635231600"; 
   d="scan'208";a="312990242"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 02:27:13 -0800
X-IronPort-AV: E=Sophos;i="5.88,360,1635231600"; 
   d="scan'208";a="542034263"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 02:27:08 -0800
Received: by lahna (sSMTP sendmail emulation); Fri, 11 Feb 2022 12:23:51 +0200
Date:   Fri, 11 Feb 2022 12:23:51 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
        "open list:RADEON and AMDGPU DRM DRIVERS" 
        <amd-gfx@lists.freedesktop.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <nouveau@lists.freedesktop.org>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Lukas Wunner <lukas@wunner.de>, Alexander.Deucher@amd.com
Subject: Re: [PATCH v2 3/9] PCI: drop `is_thunderbolt` attribute
Message-ID: <YgY5N1eVWmi0Xyuw@lahna>
References: <20220210224329.2793-1-mario.limonciello@amd.com>
 <20220210224329.2793-4-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210224329.2793-4-mario.limonciello@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Mario,

On Thu, Feb 10, 2022 at 04:43:23PM -0600, Mario Limonciello wrote:
> The `is_thunderbolt` attribute is currently a dumping ground for a
> variety of things.
> 
> Instead use the driver core removable attribute to indicate the
> detail a device is attached to a thunderbolt or USB4 chain.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/pci/pci.c                 |  2 +-
>  drivers/pci/probe.c               | 20 +++++++-------------
>  drivers/platform/x86/apple-gmux.c |  2 +-
>  include/linux/pci.h               |  5 ++---
>  4 files changed, 11 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 9ecce435fb3f..1264984d5e6d 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2955,7 +2955,7 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
>  			return true;
>  
>  		/* Even the oldest 2010 Thunderbolt controller supports D3. */
> -		if (bridge->is_thunderbolt)
> +		if (dev_is_removable(&bridge->dev))

For this, I'm not entirely sure this is what we want. The purpose of
this check is to enable port power management of Apple systems with
Intel Thunderbolt controller and therefore checking for "removable" here
is kind of misleading IMHO.

I wonder if we could instead remove the check completely here and rely
on the below:

	if (platform_pci_bridge_d3(bridge))
		return true;

and that would then look like:

static inline bool platform_pci_bridge_d3(struct pci_dev *dev)
{
	if (pci_use_mid_pm())
		return false;

	if (acpi_pci_bridge_d3(dev))
		return true;

	if (device_property_read_bool(&dev->dev, "HotPlugSupportInD3"))
		return true;

	return false;
}

and then make a quirk in quirks.c that adds the software node property
for the Apple systems? Or something along those lines.

@Lukas, what do you think?
