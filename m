Return-Path: <linux-pci+bounces-17918-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2589A9E91EE
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 12:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66147280D86
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 11:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DF921570F;
	Mon,  9 Dec 2024 11:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rAKcUGQa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F77C216E36
	for <linux-pci@vger.kernel.org>; Mon,  9 Dec 2024 11:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733742935; cv=none; b=d0N5+CK2gu3GJOXfbyslyRmL1xaQaUOGerWonnaFF4b/pTXTstXgP+xypfhW3G5xMfOEp4e4Yct5c+lz1FA+alGcUbIX7aQ4x6mFdd5518FZENLA45sy+xupwhV9hYXaLi89MauFxyqoMQsdM/Oke1Ka9D7WkQb6fgG6j4/ah40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733742935; c=relaxed/simple;
	bh=RO7kNikL9g+3lFMrapfkVYDcM0ZuWgb3OmFL6ptgUT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eETGwMVJDS95JpvefVEJoRoOj5APZoxUs1uxhe0G/EnXWboX2PVZjOVpNTlEeNaw8hqf93eFzHX+opMO3HJ9ye0UrMRUCKDeHrCsjGTeen1k2G351XbUCyw4etmOi9LDK4KGhqg1EzI7ypd+0vvNRPWIRlp1gnyrbOXjiOkSoOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rAKcUGQa; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-725ed193c9eso620307b3a.1
        for <linux-pci@vger.kernel.org>; Mon, 09 Dec 2024 03:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733742933; x=1734347733; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OVkyJahyGma3QcDBGZSqqD++2HSB1Bswo9qJGoc6gSc=;
        b=rAKcUGQaCkpdmNcl1RMh59a/C28TIizCXQ5S4MvBhjTbQu15+fPFMoxqrbrz73FK1t
         yPOVNb9DLqT2czSOaN7kN8P+n39daeBQlEJ4mEiR62TVlADyisUicrPS2yRKi/e+6gkO
         9ku/RxUuymNvC9kWyhyQb1ei83+dXdNiyiC6xv6FykPSehiO+xBWzu7aGJtGDDDG/3Tg
         qBoAJQYux/uedy2RW7dmBhkuhqRYNheO165gKPA2G7dSG3aN2KpS5HV6Ka4p6YO725dg
         1PHvKDkc6raKQljEDohC6PMDnL464Zujd8m9wpeAKrck4PFyMq+Ale/GuJBjEb/+fzPm
         iinA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733742933; x=1734347733;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OVkyJahyGma3QcDBGZSqqD++2HSB1Bswo9qJGoc6gSc=;
        b=UAWWtZ/mAnVGrMwTKFe5dlBaTy3lg0RrTcH2GXRLcNzGCXlassJkJsKjK4mmyFNV3s
         nKUP6XBO5RPAMPfKAJ+GyvyP81mxzHUbzfhUYQ70eRA6Q1thIbLRntpwIsM8CNmyWAHL
         T36+npHI+pVm09y0w45wzBtdnSuD/XnuslzjEuvz83Z13Ua6OoSGwknQwia18OFjgqsK
         r5NCXoxPs0/nNwURoNrSnp/GpKwAmjGM1mqXSVP9Q9sKVBYd/mBG4GAWVVd5BTkT+d2x
         I+pyHx4FJaoqJRV2zTTCWE8zD0tQBKotFBflFJjnYHvlKEddGG7VBicoylSgjjNJ5x0b
         QFJw==
X-Forwarded-Encrypted: i=1; AJvYcCWTTSePSAUDFOuYxRC6THI76jY7EfHdrYznKPw4o44HoNF7EXuHZFR7LBeQyoBG3jOW6agsqNchWX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YybabFYf2MRnriTwW6RIQaOZf7Z5jjMEHQDRh6PXIATleJobkQk
	EKGawHxFZnSWvLB5VM5kzU37jn9BfZDbtenLWL5B9CGcRPd7gb6kKhIyWQEUHQ==
X-Gm-Gg: ASbGnctNp03axjEWCfpcSy2YuAMkddqSjTDjwB0r1vOEfb9pYMtOt4Qn/KSIZGfdD/P
	Bg1CBt07GBjEXL8oAcEgRqFArtFhRtRdgMeraC8eZrxzFLnqdWcMcat9ttYGIiI2TsQPlY4Laxv
	Ng7DNAxbjAUpSH/OCK8kiQEuz6pd76qAxjdVfiCcmOQ7Wrf9c/zw25xQzVfkNC8bED8/mqgawVQ
	zrZbAnYRc6VPcR98ox5k/yzI8vDhkb7P5/uYpvDljLi2KImu2xoecfZ7FswsyPTKH4i5gvbzbiA
	ngsCrr/nUgcDSg5gX9o=
X-Google-Smtp-Source: AGHT+IER07FJ4K7xln/mDShfSyG+TL40w7xcVCvzkmcK1CZR2jPrwXlngVXWXvDkX5l0uSrx8QyKvg==
X-Received: by 2002:a05:6a21:7895:b0:1e0:cbcf:8917 with SMTP id adf61e73a8af0-1e1b1ac445amr3546637.21.1733742933318;
        Mon, 09 Dec 2024 03:15:33 -0800 (PST)
Received: from google.com (104.132.143.34.bc.googleusercontent.com. [34.143.132.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725a29c5ad8sm7289250b3a.8.2024.12.09.03.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 03:15:32 -0800 (PST)
Date: Mon, 9 Dec 2024 16:45:24 +0530
From: Ajay Agarwal <ajayagarwal@google.com>
To: Jian-Hong Pan <jhp@endlessos.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux@endlessos.org,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"David E. Box" <david.e.box@linux.intel.com>,
	Sajid Dalvi <sdalvi@google.com>,
	Brian Norris <briannorris@google.com>
Subject: Re: [PATCH v13] PCI/ASPM: Make pci_save_aspm_l1ss_state save both
 child and parent's L1SS configuration
Message-ID: <Z1bRTCHls22fMoBT@google.com>
References: <20241115072200.37509-3-jhp@endlessos.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241115072200.37509-3-jhp@endlessos.org>

On Fri, Nov 15, 2024 at 03:22:02PM +0800, Jian-Hong Pan wrote:
> PCI devices' parameters on the VMD bus have been programmed properly
> originally. But, cleared after pci_reset_bus() and have not been restored
> correctly. This leads the link's L1.2 between PCIe Root Port and child
> device gets wrong configs.
> 
> Here is a failed example on ASUS B1400CEAE with enabled VMD. Both PCIe
> bridge and NVMe device should have the same LTR1.2_Threshold value.
> However, they are configured as different values in this case:
> 
> 10000:e0:06.0 PCI bridge [0604]: Intel Corporation 11th Gen Core Processor PCIe Controller [8086:9a09] (rev 01) (prog-if 00 [Normal decode])
>   ...
>   Capabilities: [200 v1] L1 PM Substates
>     L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
>       PortCommonModeRestoreTime=45us PortTPowerOnTime=50us
>     L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
>       T_CommonMode=0us LTR1.2_Threshold=0ns
>     L1SubCtl2: T_PwrOn=0us
> 
> 10000:e1:00.0 Non-Volatile memory controller [0108]: Sandisk Corp WD Blue SN550 NVMe SSD [15b7:5009] (rev 01) (prog-if 02 [NVM Express])
>   ...
>   Capabilities: [900 v1] L1 PM Substates
>     L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1- L1_PM_Substates+
>       PortCommonModeRestoreTime=32us PortTPowerOnTime=10us
>     L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
>       T_CommonMode=0us LTR1.2_Threshold=101376ns
>     L1SubCtl2: T_PwrOn=50us
> 
> Here is VMD mapped PCI device tree:
> 
> -+-[0000:00]-+-00.0  Intel Corporation Device 9a04
>  | ...
>  \-[10000:e0]-+-06.0-[e1]----00.0  Sandisk Corp WD Blue SN550 NVMe SSD
>               \-17.0  Intel Corporation Tiger Lake-LP SATA Controller
> 
> When pci_reset_bus() resets the bus [e1] of the NVMe, it only saves and
> restores NVMe's state before and after reset. Then, when it restores the
> NVMe's state, ASPM code restores L1SS for both the parent bridge and the
> NVMe in pci_restore_aspm_l1ss_state(). The NVMe's L1SS is restored
> correctly. But, the parent bridge's L1SS is restored with a wrong value 0x0
> because the parent bridge's L1SS wasn't saved by pci_save_aspm_l1ss_state()
> before reset.
> 
> To avoid pci_restore_aspm_l1ss_state() restore wrong value to the parent's
> L1SS config like this example, make pci_save_aspm_l1ss_state() save the
> parent's L1SS config, if the PCI device has a parent.
> 
> Link: https://lore.kernel.org/linux-pci/CAPpJ_eexU0gCHMbXw_z924WxXw0+B6SdS4eG9oGpEX1wmnMLkQ@mail.gmail.com/
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218394
> Fixes: 17423360a27a ("PCI/ASPM: Save L1 PM Substates Capability for suspend/resume")
> Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Reviewed-by: David E. Box <david.e.box@linux.intel.com>
> ---
> v9:
> - Drop the v8 fix about drivers/pci/pcie/aspm.c. Use this in VMD instead.
> 
> v10:
> - Drop the v9 fix about drivers/pci/controller/vmd.c
> - Fix in PCIe ASPM to make it symmetric between pci_save_aspm_l1ss_state()
>   and pci_restore_aspm_l1ss_state()
> 
> v11:
> - Introduce __pci_save_aspm_l1ss_state as a resusable helper function
>   which is same as the original pci_configure_aspm_l1ss
> - Make pci_save_aspm_l1ss_state invoke __pci_save_aspm_l1ss_state for
>   both child and parent devices
> - Smooth the commit message
> 
> v12:
> - Update the commit message
> 
> v13:
> - Tweak the commit message to make it more like a general fix
> - When pci_alloc_dev() prepares the pci_dev, it sets the pci_dev's bus.
>   So, let pci_save_aspm_l1ss_state() access pdev's bus directly.
> - Add comment in pci_save_aspm_l1ss_state() to describe why it does not
>   save both the PCIe device and the parent's L1SS config like
>   pci_restore_aspm_l1ss_state() directly.
> 
>  drivers/pci/pcie/aspm.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 28567d457613..0bcd060aab32 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -79,7 +79,7 @@ void pci_configure_aspm_l1ss(struct pci_dev *pdev)
>  			ERR_PTR(rc));
>  }
>  
> -void pci_save_aspm_l1ss_state(struct pci_dev *pdev)
> +static void __pci_save_aspm_l1ss_state(struct pci_dev *pdev)
>  {
>  	struct pci_cap_saved_state *save_state;
>  	u16 l1ss = pdev->l1ss;
> @@ -101,6 +101,22 @@ void pci_save_aspm_l1ss_state(struct pci_dev *pdev)
>  	pci_read_config_dword(pdev, l1ss + PCI_L1SS_CTL1, cap++);
>  }
>  
> +void pci_save_aspm_l1ss_state(struct pci_dev *pdev)
> +{
> +	struct pci_dev *parent = pdev->bus->self;
> +
> +	__pci_save_aspm_l1ss_state(pdev);
> +
> +	/*
> +	 * Save parent's L1 substate configuration, if the parent has not saved
> +	 * state. It avoids pci_restore_aspm_l1ss_state() restore wrong value to
> +	 * parent's L1 substate configuration. However, the parent might be
> +	 * nothing, if pdev is a PCI bridge.
> +	 */
> +	if (parent && !parent->state_saved)
> +		__pci_save_aspm_l1ss_state(parent);
> +}
> +
>  void pci_restore_aspm_l1ss_state(struct pci_dev *pdev)
>  {
>  	struct pci_cap_saved_state *pl_save_state, *cl_save_state;
> -- 
> 2.47.0
> 
> 
Thanks for sending this patch! I tested on a Pixel device with 6.6
kernel. I verified that the root port and the endpoint device were
being restored with the L1ss configuration which was determined on
endpoint enumeration. Feel free to include

Tested-by: Ajay Agarwal <ajayagarwal@google.com>

