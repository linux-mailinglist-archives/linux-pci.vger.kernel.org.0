Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3087C3DDC05
	for <lists+linux-pci@lfdr.de>; Mon,  2 Aug 2021 17:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234688AbhHBPMq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Aug 2021 11:12:46 -0400
Received: from mga07.intel.com ([134.134.136.100]:15609 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234401AbhHBPMq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Aug 2021 11:12:46 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10064"; a="277241314"
X-IronPort-AV: E=Sophos;i="5.84,289,1620716400"; 
   d="scan'208";a="277241314"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 08:12:36 -0700
X-IronPort-AV: E=Sophos;i="5.84,289,1620716400"; 
   d="scan'208";a="478886392"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 08:12:33 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 02 Aug 2021 18:12:31 +0300
Date:   Mon, 2 Aug 2021 18:12:31 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Sanjay R Mehta <Sanju.Mehta@amd.com>
Cc:     andreas.noever@gmail.com, michael.jamet@intel.com,
        bhelgaas@google.com, YehezkelShB@gmail.com,
        Basavaraj.Natikar@amd.com, linux-usb@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/4] PCI: Add AMD USB4 host router device IDs
Message-ID: <YQgLX2CukV8oc8eW@lahna>
References: <1627909100-83338-1-git-send-email-Sanju.Mehta@amd.com>
 <1627909100-83338-2-git-send-email-Sanju.Mehta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1627909100-83338-2-git-send-email-Sanju.Mehta@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 02, 2021 at 07:58:17AM -0500, Sanjay R Mehta wrote:
> From: Sanjay R Mehta <sanju.mehta@amd.com>
> 
> This patch enables support for AMD USB4 host router.
> 
> Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
> ---
>  drivers/thunderbolt/nhi.c | 4 ++++
>  include/linux/pci_ids.h   | 2 ++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
> index fa44332..d7d9c4b 100644
> --- a/drivers/thunderbolt/nhi.c
> +++ b/drivers/thunderbolt/nhi.c
> @@ -1338,6 +1338,10 @@ static struct pci_device_id nhi_ids[] = {
>  	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_ADL_NHI1),
>  	  .driver_data = (kernel_ulong_t)&icl_nhi_ops },
>  
> +	/* AMD USB4 host */
> +	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_USB4_HIA0) },
> +	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_USB4_HIA1) },
> +
>  	/* Any USB4 compliant host */
>  	{ PCI_DEVICE_CLASS(PCI_CLASS_SERIAL_USB_USB4, ~0) },
>  
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 4bac183..6d50019 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -604,6 +604,8 @@
>  #define PCI_DEVICE_ID_AMD_HUDSON2_SMBUS		0x780b
>  #define PCI_DEVICE_ID_AMD_HUDSON2_IDE		0x780c
>  #define PCI_DEVICE_ID_AMD_KERNCZ_SMBUS  0x790b
> +#define PCI_DEVICE_ID_AMD_USB4_HIA0	0x162e
> +#define PCI_DEVICE_ID_AMD_USB4_HIA1	0x162f

No need to add them here (and you actually should not since these IDs
are not shared between multiple drivers, see the top level comment in
this header).

I suggest adding these to drivers/thunderbolt/nhi.h instead.

>  
>  #define PCI_VENDOR_ID_TRIDENT		0x1023
>  #define PCI_DEVICE_ID_TRIDENT_4DWAVE_DX	0x2000
> -- 
> 2.7.4
