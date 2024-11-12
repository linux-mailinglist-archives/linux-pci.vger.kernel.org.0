Return-Path: <linux-pci+bounces-16599-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDC59C635A
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 22:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D1B128130F
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 21:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CF321A4A3;
	Tue, 12 Nov 2024 21:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QtPc88R6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73242170DD;
	Tue, 12 Nov 2024 21:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731446689; cv=none; b=Z4mgJ05NZOWI4u09sBwRqzr4tz8tZeBGoOMqd1/Z3if469h1WLDxWBAQj2I45gePKhFKHiXMGy4EFde5ZbiUGuo+6BT596psnmKxCeasKz8Z4SmH8tA2nRxO9nI72r35C8zHHDzNkH9hHmfRhCfmHJn51muE5sHocioV9t8HaUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731446689; c=relaxed/simple;
	bh=IcTJgLodvSURGaK4wqAzdTDDMij+U5Fu23bdAxDaorg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=DWTEyq+Sd95Y7DQ8JMyZgSZ4MtZjkIxhmqxdoSM2FA9kz+1AyBjaRLMrSHRbduwM/FuJUnltNwXnDb9XLeWMZ3t0L0YHPx2bXrTfUcFfx2FhHe1hjDr9uY6CP6U29m3S83/+8gotlVIOLKITLZc/aNBqvoBpY0YGFLTfKSzSihM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QtPc88R6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2543BC4CECD;
	Tue, 12 Nov 2024 21:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731446689;
	bh=IcTJgLodvSURGaK4wqAzdTDDMij+U5Fu23bdAxDaorg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=QtPc88R6MNDMn8zqqI1B9uJrVb9jLqWL5ToBEKV+RxMCJW92huc1DxZg2adpjHUX6
	 aZXq1kKE5zX0Ey1E4e4vSCGjuQHgMygguL5X0C657sxGqYbq8uohO+xYAJWTAq0DU8
	 MN7w8BxC0H4dGiAF6lN4zyDAtx9UuMgT7D/NMc7vxIcaI6BGjRL9Ao7rwzzoySl0bm
	 egE33GKzO7eo9qaJgvFU1cCBXXWbCOOhT+vWZJbaIKP+pqu9UXi864epLTZgyK+BtS
	 g9zhmeVR3mFnD4xcc+F6UqPNkcqJ9X6nPcUKODln2QB8sd+DBYdTKPe2ULK6pmVXda
	 JxCGpcywl/irA==
Date: Tue, 12 Nov 2024 15:24:47 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Peter Chen <peter.chen@kernel.org>,
	Pawel Laszczak <pawell@cadence.com>,
	Roger Quadros <rogerq@kernel.org>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v1 1/1] usb: cdns3: Synchronise PCI IDs via common data
 base
Message-ID: <20241112212447.GA1861184@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112160125.2340972-1-andriy.shevchenko@linux.intel.com>

On Tue, Nov 12, 2024 at 06:01:25PM +0200, Andy Shevchenko wrote:
> There are a few places in the kernel where PCI IDs for different Cadence
> USB controllers are being used. Besides different naming, they duplicate
> each other. Make this all in order by providing common definitions via
> PCI IDs database and use in all users. While doing that, rename
> definitions as Roger suggested.
> 
> Suggested-by: Roger Quadros <rogerq@kernel.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Looks like maybe something for the USB tree?

> ---
>  drivers/usb/cdns3/cdns3-pci-wrap.c       |  4 +---
>  drivers/usb/cdns3/cdnsp-pci.c            | 26 +++++++++---------------
>  drivers/usb/gadget/udc/cdns2/cdns2-pci.c |  3 +--
>  drivers/usb/host/xhci-pci.c              |  5 ++---
>  include/linux/pci_ids.h                  |  4 ++++
>  5 files changed, 18 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/usb/cdns3/cdns3-pci-wrap.c b/drivers/usb/cdns3/cdns3-pci-wrap.c
> index 591d149de8f3..3b3b3dc75f35 100644
> --- a/drivers/usb/cdns3/cdns3-pci-wrap.c
> +++ b/drivers/usb/cdns3/cdns3-pci-wrap.c
> @@ -37,8 +37,6 @@ struct cdns3_wrap {
>  #define PCI_DRIVER_NAME		"cdns3-pci-usbss"
>  #define PLAT_DRIVER_NAME	"cdns-usb3"
>  
> -#define PCI_DEVICE_ID_CDNS_USB3	0x0100
> -
>  static struct pci_dev *cdns3_get_second_fun(struct pci_dev *pdev)
>  {
>  	struct pci_dev *func;
> @@ -189,7 +187,7 @@ static void cdns3_pci_remove(struct pci_dev *pdev)
>  }
>  
>  static const struct pci_device_id cdns3_pci_ids[] = {
> -	{ PCI_VDEVICE(CDNS, PCI_DEVICE_ID_CDNS_USB3) },
> +	{ PCI_VDEVICE(CDNS, PCI_DEVICE_ID_CDNS_USBSS) },
>  	{ 0, }
>  };
>  
> diff --git a/drivers/usb/cdns3/cdnsp-pci.c b/drivers/usb/cdns3/cdnsp-pci.c
> index 2d05368a6745..a51144504ff3 100644
> --- a/drivers/usb/cdns3/cdnsp-pci.c
> +++ b/drivers/usb/cdns3/cdnsp-pci.c
> @@ -28,12 +28,6 @@
>  #define PCI_DRIVER_NAME		"cdns-pci-usbssp"
>  #define PLAT_DRIVER_NAME	"cdns-usbssp"
>  
> -#define PCI_DEVICE_ID_CDNS_USB3		0x0100
> -#define PCI_DEVICE_ID_CDNS_UDC		0x0200
> -
> -#define PCI_CLASS_SERIAL_USB_CDNS_USB3	(PCI_CLASS_SERIAL_USB << 8 | 0x80)
> -#define PCI_CLASS_SERIAL_USB_CDNS_UDC	PCI_CLASS_SERIAL_USB_DEVICE
> -
>  static struct pci_dev *cdnsp_get_second_fun(struct pci_dev *pdev)
>  {
>  	/*
> @@ -41,10 +35,10 @@ static struct pci_dev *cdnsp_get_second_fun(struct pci_dev *pdev)
>  	 * Platform has two function. The fist keeps resources for
>  	 * Host/Device while the secon keeps resources for DRD/OTG.
>  	 */
> -	if (pdev->device == PCI_DEVICE_ID_CDNS_UDC)
> -		return pci_get_device(pdev->vendor, PCI_DEVICE_ID_CDNS_USB3, NULL);
> -	if (pdev->device == PCI_DEVICE_ID_CDNS_USB3)
> -		return pci_get_device(pdev->vendor, PCI_DEVICE_ID_CDNS_UDC, NULL);
> +	if (pdev->device == PCI_DEVICE_ID_CDNS_USBSSP)
> +		return pci_get_device(pdev->vendor, PCI_DEVICE_ID_CDNS_USBSS, NULL);
> +	if (pdev->device == PCI_DEVICE_ID_CDNS_USBSS)
> +		return pci_get_device(pdev->vendor, PCI_DEVICE_ID_CDNS_USBSSP, NULL);
>  
>  	return NULL;
>  }
> @@ -221,12 +215,12 @@ static const struct dev_pm_ops cdnsp_pci_pm_ops = {
>  };
>  
>  static const struct pci_device_id cdnsp_pci_ids[] = {
> -	{ PCI_DEVICE(PCI_VENDOR_ID_CDNS, PCI_DEVICE_ID_CDNS_UDC),
> -	  .class = PCI_CLASS_SERIAL_USB_CDNS_UDC },
> -	{ PCI_DEVICE(PCI_VENDOR_ID_CDNS, PCI_DEVICE_ID_CDNS_UDC),
> -	  .class = PCI_CLASS_SERIAL_USB_CDNS_USB3 },
> -	{ PCI_DEVICE(PCI_VENDOR_ID_CDNS, PCI_DEVICE_ID_CDNS_USB3),
> -	  .class = PCI_CLASS_SERIAL_USB_CDNS_USB3 },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_CDNS, PCI_DEVICE_ID_CDNS_USBSSP),
> +	  .class = PCI_CLASS_SERIAL_USB_DEVICE },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_CDNS, PCI_DEVICE_ID_CDNS_USBSSP),
> +	  .class = PCI_CLASS_SERIAL_USB_CDNS },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_CDNS, PCI_DEVICE_ID_CDNS_USBSS),
> +	  .class = PCI_CLASS_SERIAL_USB_CDNS },
>  	{ 0, }
>  };
>  
> diff --git a/drivers/usb/gadget/udc/cdns2/cdns2-pci.c b/drivers/usb/gadget/udc/cdns2/cdns2-pci.c
> index b1a8f772467c..e589593b4cbf 100644
> --- a/drivers/usb/gadget/udc/cdns2/cdns2-pci.c
> +++ b/drivers/usb/gadget/udc/cdns2/cdns2-pci.c
> @@ -15,7 +15,6 @@
>  #include "cdns2-gadget.h"
>  
>  #define PCI_DRIVER_NAME		"cdns-pci-usbhs"
> -#define PCI_DEVICE_ID_CDNS_USB2	0x0120
>  #define PCI_BAR_DEV		0
>  #define PCI_DEV_FN_DEVICE	0
>  
> @@ -113,7 +112,7 @@ static const struct dev_pm_ops cdns2_pci_pm_ops = {
>  };
>  
>  static const struct pci_device_id cdns2_pci_ids[] = {
> -	{ PCI_DEVICE(PCI_VENDOR_ID_CDNS, PCI_DEVICE_ID_CDNS_USB2),
> +	{ PCI_DEVICE(PCI_VENDOR_ID_CDNS, PCI_DEVICE_ID_CDNS_USB),
>  	  .class = PCI_CLASS_SERIAL_USB_DEVICE },
>  	{ 0, }
>  };
> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> index 47c4f70793e4..b21474e81482 100644
> --- a/drivers/usb/host/xhci-pci.c
> +++ b/drivers/usb/host/xhci-pci.c
> @@ -82,8 +82,6 @@
>  #define PCI_DEVICE_ID_ASMEDIA_3042_XHCI			0x3042
>  #define PCI_DEVICE_ID_ASMEDIA_3242_XHCI			0x3242
>  
> -#define PCI_DEVICE_ID_CDNS_SSP				0x0200
> -
>  static const char hcd_name[] = "xhci_hcd";
>  
>  static struct hc_driver __read_mostly xhci_pci_hc_driver;
> @@ -475,8 +473,9 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
>  		if (pdev->device == 0x9203)
>  			xhci->quirks |= XHCI_ZHAOXIN_TRB_FETCH;
>  	}
> +
>  	if (pdev->vendor == PCI_VENDOR_ID_CDNS &&
> -	    pdev->device == PCI_DEVICE_ID_CDNS_SSP)
> +	    pdev->device == PCI_DEVICE_ID_CDNS_USBSSP)
>  		xhci->quirks |= XHCI_CDNS_SCTX_QUIRK;
>  
>  	/* xHC spec requires PCI devices to support D3hot and D3cold */
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index e4bddb927795..d2402bf4aea2 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -121,6 +121,7 @@
>  #define PCI_CLASS_SERIAL_USB_OHCI	0x0c0310
>  #define PCI_CLASS_SERIAL_USB_EHCI	0x0c0320
>  #define PCI_CLASS_SERIAL_USB_XHCI	0x0c0330
> +#define PCI_CLASS_SERIAL_USB_CDNS	0x0c0380
>  #define PCI_CLASS_SERIAL_USB_DEVICE	0x0c03fe
>  #define PCI_CLASS_SERIAL_FIBER		0x0c04
>  #define PCI_CLASS_SERIAL_SMBUS		0x0c05
> @@ -2421,6 +2422,9 @@
>  #define PCI_VENDOR_ID_QCOM		0x17cb
>  
>  #define PCI_VENDOR_ID_CDNS		0x17cd
> +#define PCI_DEVICE_ID_CDNS_USBSS	0x0100
> +#define PCI_DEVICE_ID_CDNS_USB		0x0120
> +#define PCI_DEVICE_ID_CDNS_USBSSP	0x0200
>  
>  #define PCI_VENDOR_ID_ARECA		0x17d3
>  #define PCI_DEVICE_ID_ARECA_1110	0x1110
> -- 
> 2.43.0.rc1.1336.g36b5255a03ac
> 

