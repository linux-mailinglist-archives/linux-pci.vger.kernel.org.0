Return-Path: <linux-pci+bounces-27111-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AFEAA80D7
	for <lists+linux-pci@lfdr.de>; Sat,  3 May 2025 15:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26F497AB9C4
	for <lists+linux-pci@lfdr.de>; Sat,  3 May 2025 13:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBE4266EEC;
	Sat,  3 May 2025 13:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fr3VtQ79"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380AF266560
	for <linux-pci@vger.kernel.org>; Sat,  3 May 2025 13:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746278414; cv=none; b=ZyU+YwLceyUjRrLFnyZZL3Zu2H2SLKhHNHJUTdoLqPVdkALjhF8qR67jeWpLQrQQpWSay04iRGaeYftKvGdvArN0F1OGZUhaSMbtnW1Sj2ZCVZ+Z6mGfFSzA8R2r/5eHD5fL2DJv8O0cqn0vdNmxpwXEaRWFfKdHpa92K6YEDmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746278414; c=relaxed/simple;
	bh=ed3DeabF7aBPv9pg8P8XvtmLV9tXVo/RMkaYO0eG698=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HXNBY55GKlWrkDB/RHesTMjx0Ks9+9vqPQqEbjjclNWwWY84UeAYiqffO08oCnlj0DYxIHcfPrEcyiR6k2ZR1CGKU35puJCSGcGfKQxtaXYtYgF0ql5PQwIp12EXWIvTYw1jYrqhfaSbS4DVHMAno+Ef3Qxp/wOoQTYdHwwF8h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Fr3VtQ79; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22c33e5013aso32206475ad.0
        for <linux-pci@vger.kernel.org>; Sat, 03 May 2025 06:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746278411; x=1746883211; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SK9YRsQUqLL0xcebcLQIiook7NHZ9YSziSFQTHbkXNw=;
        b=Fr3VtQ790ptfoz2CNgQelmZ1BWJ3mLY0JCJRRJGY5fUl3ZvySks3sDLAXm+VVHvAvI
         9K96TE73eU0XhqpffHcTdrpQZc6+XhVpaY1MzEzPiQ2yT590gvwmtGbxgigeP0H32ds7
         potxXNUBV3A5KdElWvfyEF5fHVyfg0ywkkiXfKQwCBA7LiO7/QKZqkAWCxhBHkBlbYS5
         /6GfFibc/57ngAtYHZGIaqLclKECD2QIr52goHsbmCoGwvxLrsiUDKUWQe1NDlymH0V+
         AHlEY9iXbTznujR3GVVbWUIUc1fQOPAUC8awaUmM938fH7lpJ/RKyLztoPyhhiN5SWAz
         h4mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746278411; x=1746883211;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SK9YRsQUqLL0xcebcLQIiook7NHZ9YSziSFQTHbkXNw=;
        b=eXJmjzpFBsMY1dC3V6mKWJs4ESXOVQIDYElN4GMe6K8qBae32hxFLLQtr+xdRcq+/Q
         xYP8qEtEBJglaHZ3G7Zle7aLmWB2BrmKXZViN772ZaQDG/kPJ4PVtK8OT7tSlInHyx0X
         2fZmXvppbPRx1B8wcvGY+71CeeCTH5VDRfcPtuSGtPdgp7vDtEJw0/6FG6nZJB+2Olis
         wr5Oy0o2qn3W5TUABB1rNF+wVVfLXP+uwstMhNl1RFzGmO5RMnpiLdZwMe0l8h3n9cZe
         X6UqDVuSFdukZeBoKxf0vIdW14h0+YOV9euE5PNVd4+aZKEoXzRFUse3oUrcWfmMw3GO
         Ytng==
X-Forwarded-Encrypted: i=1; AJvYcCXbnzD0dstWbC2AyqBpK0+/wFofnVsM63YZjuxXYbinRZjHmi7AbwR4Ge7QUAhlXLWGIayXKy51TOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsoO2M4KNypIz+3iVfOjvT8XMVwY4Z8W8KQ5xOBM6Rs18thyh0
	WyrRlMugL7OOHKpmYQ9caRbEdvadPwkvbYY7hRC32a/Y7FesWpSE0hNlIYu/SQ==
X-Gm-Gg: ASbGncswAbCQC6+5yv8NaFr2IwptHp6OZ0oXFvZ/8855HV+9ZWlGzu3ECLmnBxSlpdI
	hFGIV0WIKQzVqwm42t2KGU7QE20byvHczFJBhzY8nGW2cfznMctigB4iLDTcv1mhveuWdVazXdf
	/6zONd49REC3O9fdkMOQBJiy3PWZx0WDfdQ8iA2Vp6kkq2caBuPpwLR4nQJEsf4EcUT7H8jNM5i
	NtC1D6qn09cuuhC9L0lfA6Gi9JKVT/3jy3Lv8tVGxKYEbLGiKTjTA+ldDjT2RSIIZfsQ9EFLv/S
	yUMt9+dXazvkvAiSnVOZEhDnOx7iOKh1vMJ6IsL8P1b+riutf0kdRQ==
X-Google-Smtp-Source: AGHT+IGy8W2NM1vrlsV7C/5pIguwy5iwnjQP7ZKxdJnUkQqYyO2bhEbFndX+h1mtJEdm1wVzpSsa1w==
X-Received: by 2002:a17:902:ce8c:b0:223:4c09:20b8 with SMTP id d9443c01a7336-22e1eae3f54mr12032305ad.37.1746278411236;
        Sat, 03 May 2025 06:20:11 -0700 (PDT)
Received: from thinkpad ([220.158.156.122])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74058d7a230sm3427874b3a.12.2025.05.03.06.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 May 2025 06:20:10 -0700 (PDT)
Date: Sat, 3 May 2025 18:50:05 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Szymon Durawa <szymon.durawa@linux.intel.com>
Cc: helgaas@kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Dan Williams <dan.j.williams@intel.com>, Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org, 
	Nirmal Patel <nirmal.patel@linux.intel.com>, Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Subject: Re: [PATCH v3 7/8] PCI: vmd: Add support for second rootbus under VMD
Message-ID: <yjntzbop2iuoqbop7aqvt2nbe7yczqy7ay3lw4e37zkumr5djp@ohkqwejntsrx>
References: <20241122085215.424736-1-szymon.durawa@linux.intel.com>
 <20241122085215.424736-8-szymon.durawa@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241122085215.424736-8-szymon.durawa@linux.intel.com>

On Fri, Nov 22, 2024 at 09:52:14AM +0100, Szymon Durawa wrote:
> Starting from Intel Arrow Lake VMD enhancement introduces second rootbus
> support with fixed root bus number (0x80). It means that all 3 MMIO BARs
> exposed by VMD are shared now between both buses (current BUS0 and
> new BUS1).
> 
> Add new BUS1 enumeration and divide MMIO space to be shared between
> both rootbuses. Due to enumeration issues with rootbus hardwired to a
> fixed non-zero value, this patch will work with a workaround proposed
> in next patch. Without workaround user won't see attached devices for BUS1
> rootbus.
> 

Series mostly looks good to me. But I'm not comfortable with patches 7 and 8 due
to the dependency. Patch 7 is adding the second root bus, but the devices will
only be detected after applying patch 8, which will break bisecting.

Can you try moving patch 8 before 7? Or merge both of them?

- Mani

> Suggested-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> Reviewed-by: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
> Signed-off-by: Szymon Durawa <szymon.durawa@linux.intel.com>
> ---
>  drivers/pci/controller/vmd.c | 208 ++++++++++++++++++++++++++++++-----
>  1 file changed, 180 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 6d8397b5ebee..6cd14c28fd4e 100755
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -26,6 +26,7 @@
>  #define VMD_RESTRICT_0_BUS_START 0
>  #define VMD_RESTRICT_1_BUS_START 128
>  #define VMD_RESTRICT_2_BUS_START 224
> +#define VMD_RESTRICT_3_BUS_START 225
>  
>  #define PCI_REG_VMCAP		0x40
>  #define BUS_RESTRICT_CAP(vmcap)	(vmcap & 0x1)
> @@ -38,15 +39,33 @@
>  #define MB2_SHADOW_OFFSET	0x2000
>  #define MB2_SHADOW_SIZE		16
>  
> +#define VMD_PRIMARY_BUS0 0x00
> +#define VMD_PRIMARY_BUS1 0x80
> +#define VMD_BUSRANGE0 0xc8
> +#define VMD_BUSRANGE1 0xcc
> +#define VMD_MEMBAR1_OFFSET 0xd0
> +#define VMD_MEMBAR2_OFFSET1 0xd8
> +#define VMD_MEMBAR2_OFFSET2 0xdc
> +#define VMD_BUS_END(busr) ((busr >> 8) & 0xff)
> +#define VMD_BUS_START(busr) (busr & 0x00ff)
> +
> +/*
> + * Add VMD resources for BUS1, it will share the same MMIO space with
> + * previous VMD resources.
> + */
>  enum vmd_resource {
>  	VMD_RES_CFGBAR = 0, /* VMD Bus0 Config BAR */
>  	VMD_RES_MBAR_1, /* VMD Bus0 Resource MemBAR 1 */
>  	VMD_RES_MBAR_2, /* VMD Bus0 Resource MemBAR 2 */
> +	VMD_RES_BUS1_CFGBAR, /* VMD Bus1 Config BAR */
> +	VMD_RES_BUS1_MBAR_1, /* VMD Bus1 Resource MemBAR 1 */
> +	VMD_RES_BUS1_MBAR_2, /* VMD Bus1 Resource MemBAR 2 */
>  	VMD_RES_COUNT
>  };
>  
>  enum vmd_rootbus {
>  	VMD_BUS_0 = 0,
> +	VMD_BUS_1,
>  	VMD_BUS_COUNT
>  };
>  
> @@ -90,6 +109,12 @@ enum vmd_features {
>  	 * proper power management of the SoC.
>  	 */
>  	VMD_FEAT_BIOS_PM_QUIRK		= (1 << 5),
> +
> +	/*
> +	 * Starting from Intel Arrow Lake, VMD devices have their VMD rootports
> +	 * connected to additional BUS1 rootport.
> +	 */
> +	VMD_FEAT_HAS_BUS1_ROOTBUS	= (1 << 6)
>  };
>  
>  #define VMD_BIOS_PM_QUIRK_LTR	0x1003	/* 3145728 ns */
> @@ -97,7 +122,8 @@ enum vmd_features {
>  #define VMD_FEATS_CLIENT	(VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |	\
>  				 VMD_FEAT_HAS_BUS_RESTRICTIONS |	\
>  				 VMD_FEAT_OFFSET_FIRST_VECTOR |		\
> -				 VMD_FEAT_BIOS_PM_QUIRK)
> +				 VMD_FEAT_BIOS_PM_QUIRK |		\
> +				 VMD_FEAT_HAS_BUS1_ROOTBUS)
>  
>  static DEFINE_IDA(vmd_instance_ida);
>  
> @@ -155,6 +181,7 @@ struct vmd_dev {
>  	u8			first_vec;
>  	char			*name;
>  	int			instance;
> +	bool			bus1_rootbus;
>  };
>  
>  static inline struct vmd_dev *vmd_from_bus(struct pci_bus *bus)
> @@ -532,11 +559,16 @@ static inline void vmd_acpi_end(void) { }
>  
>  static void vmd_domain_reset(struct vmd_dev *vmd)
>  {
> -	u16 bus, max_buses = resource_size(&vmd->resources[VMD_RES_CFGBAR]);
> +	u16 bus, bus_cnt = resource_size(&vmd->resources[VMD_RES_CFGBAR]);
>  	u8 dev, functions, fn, hdr_type;
>  	char __iomem *base;
>  
> -	for (bus = 0; bus < max_buses; bus++) {
> +	if (vmd->bus1_rootbus) {
> +		bus_cnt += resource_size(&vmd->resources[VMD_RES_BUS1_CFGBAR]);
> +		bus_cnt += 2;
> +	}
> +
> +	for (bus = 0; bus < bus_cnt; bus++) {
>  		for (dev = 0; dev < 32; dev++) {
>  			base = vmd->cfgbar + PCIE_ECAM_OFFSET(bus,
>  						PCI_DEVFN(dev, 0), 0);
> @@ -582,12 +614,24 @@ static void vmd_attach_resources(struct vmd_dev *vmd)
>  {
>  	vmd->dev->resource[VMD_MEMBAR1].child = &vmd->resources[VMD_RES_MBAR_1];
>  	vmd->dev->resource[VMD_MEMBAR2].child = &vmd->resources[VMD_RES_MBAR_2];
> +
> +	if (vmd->bus1_rootbus) {
> +		vmd->resources[VMD_RES_MBAR_1].sibling =
> +			&vmd->resources[VMD_RES_BUS1_MBAR_1];
> +		vmd->resources[VMD_RES_MBAR_2].sibling =
> +			&vmd->resources[VMD_RES_BUS1_MBAR_2];
> +	}
>  }
>  
>  static void vmd_detach_resources(struct vmd_dev *vmd)
>  {
>  	vmd->dev->resource[VMD_MEMBAR1].child = NULL;
>  	vmd->dev->resource[VMD_MEMBAR2].child = NULL;
> +
> +	if (vmd->bus1_rootbus) {
> +		vmd->resources[VMD_RES_MBAR_1].sibling = NULL;
> +		vmd->resources[VMD_RES_MBAR_2].sibling = NULL;
> +	}
>  }
>  
>  /*
> @@ -660,7 +704,7 @@ static int vmd_get_phys_offsets(struct vmd_dev *vmd, bool native_hint,
>  	return 0;
>  }
>  
> -static int vmd_get_bus_number_start(struct vmd_dev *vmd)
> +static int vmd_get_bus_number_start(struct vmd_dev *vmd, unsigned long features)
>  {
>  	struct pci_dev *dev = vmd->dev;
>  	u16 reg;
> @@ -679,6 +723,19 @@ static int vmd_get_bus_number_start(struct vmd_dev *vmd)
>  		case 2:
>  			vmd->busn_start[VMD_BUS_0] = VMD_RESTRICT_2_BUS_START;
>  			break;
> +		case 3:
> +			if (!(features & VMD_FEAT_HAS_BUS1_ROOTBUS)) {
> +				pci_err(dev, "VMD Bus Restriction detected type %d, but BUS1 Rootbus is not supported, aborting.\n",
> +					BUS_RESTRICT_CFG(reg));
> +				return -ENODEV;
> +			}
> +
> +			/* BUS0 start number */
> +			vmd->busn_start[VMD_BUS_0] = VMD_RESTRICT_2_BUS_START;
> +			/* BUS1 start number */
> +			vmd->busn_start[VMD_BUS_1] = VMD_RESTRICT_3_BUS_START;
> +			vmd->bus1_rootbus = true;
> +			break;
>  		default:
>  			pci_err(dev, "Unknown Bus Offset Setting (%d)\n",
>  				BUS_RESTRICT_CFG(reg));
> @@ -805,6 +862,30 @@ static void vmd_configure_cfgbar(struct vmd_dev *vmd)
>  		       (resource_size(res) >> 20) - 1,
>  		.flags = IORESOURCE_BUS | IORESOURCE_PCI_FIXED,
>  	};
> +
> +	if (vmd->bus1_rootbus) {
> +		u16 bus0_range = 0;
> +		u16 bus1_range = 0;
> +
> +		pci_read_config_word(vmd->dev, VMD_BUSRANGE0, &bus0_range);
> +		pci_read_config_word(vmd->dev, VMD_BUSRANGE1, &bus1_range);
> +
> +		/*
> +		 * Resize BUS0 CFGBAR range to make space for BUS1
> +		 * owned devices by adjusting range end with value stored in
> +		 * VMD_BUSRANGE0 register.
> +		 */
> +		vmd->resources[VMD_RES_CFGBAR].start = VMD_BUS_START(bus0_range);
> +		vmd->resources[VMD_RES_CFGBAR].end = VMD_BUS_END(bus0_range);
> +
> +		vmd->resources[VMD_RES_BUS1_CFGBAR] = (struct resource){
> +			.name = "VMD CFGBAR BUS1",
> +			.start = VMD_BUS_START(bus1_range),
> +			.end = VMD_BUS_END(bus1_range),
> +			.flags = IORESOURCE_BUS | IORESOURCE_PCI_FIXED,
> +			.parent = res,
> +		};
> +	}
>  }
>  
>  /*
> @@ -834,8 +915,9 @@ static void vmd_configure_membar(struct vmd_dev *vmd,
>  		flags &= ~IORESOURCE_MEM_64;
>  
>  	vmd->resources[resource_number] = (struct resource){
> -		.name = kasprintf(GFP_KERNEL, "VMD MEMBAR%d",
> -				  membar_number / 2),
> +		.name = kasprintf(
> +			GFP_KERNEL, "VMD MEMBAR%d %s", membar_number / 2,
> +			resource_number > VMD_RES_MBAR_2 ? "BUS1" : ""),
>  		.start = res->start + start_offset,
>  		.end = res->end - end_offset,
>  		.flags = flags,
> @@ -846,41 +928,80 @@ static void vmd_configure_membar(struct vmd_dev *vmd,
>  static void vmd_configure_membar1_membar2(struct vmd_dev *vmd,
>  					  resource_size_t mbar2_ofs)
>  {
> -	vmd_configure_membar(vmd, 1, VMD_MEMBAR1, 0, 0);
> -	vmd_configure_membar(vmd, 2, VMD_MEMBAR2, mbar2_ofs, 0);
> +	if (vmd->bus1_rootbus) {
> +		u32 bus1_mbar1_ofs = 0;
> +		u64 bus1_mbar2_ofs = 0;
> +		u32 reg;
> +
> +		pci_read_config_dword(vmd->dev, VMD_MEMBAR1_OFFSET,
> +				      &bus1_mbar1_ofs);
> +
> +		pci_read_config_dword(vmd->dev, VMD_MEMBAR2_OFFSET1, &reg);
> +		bus1_mbar2_ofs = reg;
> +
> +		pci_read_config_dword(vmd->dev, VMD_MEMBAR2_OFFSET2, &reg);
> +		bus1_mbar2_ofs |= (u64)reg << 32;
> +
> +		/*
> +		 * Resize BUS MEMBAR1 and MEMBAR2 ranges to make space
> +		 * for BUS1 owned devices by adjusting range end with values
> +		 * stored in VMD_MEMBAR1_OFFSET and VMD_MEMBAR2_OFFSET registers
> +		 */
> +		vmd_configure_membar(vmd, VMD_RES_MBAR_1, VMD_MEMBAR1, 0,
> +				     bus1_mbar1_ofs);
> +		vmd_configure_membar(vmd, VMD_RES_MBAR_2, VMD_MEMBAR2,
> +				     mbar2_ofs, bus1_mbar2_ofs - mbar2_ofs);
> +
> +		vmd_configure_membar(vmd, VMD_RES_BUS1_MBAR_1, VMD_MEMBAR1,
> +				     bus1_mbar1_ofs, 0);
> +		vmd_configure_membar(vmd, VMD_RES_BUS1_MBAR_2, VMD_MEMBAR2,
> +				     mbar2_ofs + bus1_mbar2_ofs, 0);
> +	} else {
> +		vmd_configure_membar(vmd, VMD_RES_MBAR_1, VMD_MEMBAR1, 0, 0);
> +		vmd_configure_membar(vmd, VMD_RES_MBAR_2, VMD_MEMBAR2,
> +				     mbar2_ofs, 0);
> +	}
>  }
>  
> -static int vmd_create_bus(struct vmd_dev *vmd, struct pci_sysdata *sd,
> -			  resource_size_t *offset)
> +static int vmd_create_bus(struct vmd_dev *vmd, enum vmd_rootbus bus_number,
> +			  struct pci_sysdata *sd, resource_size_t *offset)
>  {
> +	u8 cfgbar = bus_number * 3;
> +	u8 membar1 = cfgbar + 1;
> +	u8 membar2 = cfgbar + 2;
> +	struct pci_bus *vmd_bus;
>  	LIST_HEAD(resources);
>  
> -	pci_add_resource(&resources, &vmd->resources[VMD_RES_CFGBAR]);
> -	pci_add_resource_offset(&resources, &vmd->resources[VMD_RES_MBAR_1],
> +	pci_add_resource(&resources, &vmd->resources[cfgbar]);
> +	pci_add_resource_offset(&resources, &vmd->resources[membar1],
>  				offset[0]);
> -	pci_add_resource_offset(&resources, &vmd->resources[VMD_RES_MBAR_2],
> +	pci_add_resource_offset(&resources, &vmd->resources[membar2],
>  				offset[1]);
>  
> -	vmd->bus[VMD_BUS_0] = pci_create_root_bus(&vmd->dev->dev,
> -						  vmd->busn_start[VMD_BUS_0],
> -						  &vmd_ops, sd, &resources);
> -	if (!vmd->bus[VMD_BUS_0]) {
> +	vmd_bus = pci_create_root_bus(&vmd->dev->dev,
> +				      vmd->busn_start[bus_number], &vmd_ops, sd,
> +				      &resources);
> +
> +	if (!vmd_bus) {
>  		pci_free_resource_list(&resources);
> -		vmd_remove_irq_domain(vmd);
> +
> +		if (bus_number == VMD_PRIMARY_BUS0)
> +			vmd_remove_irq_domain(vmd);
>  		return -ENODEV;
>  	}
>  
> -	vmd_copy_host_bridge_flags(
> -		pci_find_host_bridge(vmd->dev->bus),
> -		to_pci_host_bridge(vmd->bus[VMD_BUS_0]->bridge));
> +	vmd_copy_host_bridge_flags(pci_find_host_bridge(vmd->dev->bus),
> +				   to_pci_host_bridge(vmd_bus->bridge));
>  
>  	vmd_attach_resources(vmd);
>  	if (vmd->irq_domain)
> -		dev_set_msi_domain(&vmd->bus[VMD_BUS_0]->dev, vmd->irq_domain);
> +		dev_set_msi_domain(&vmd_bus->dev, vmd->irq_domain);
>  	else
> -		dev_set_msi_domain(&vmd->bus[VMD_BUS_0]->dev,
> +		dev_set_msi_domain(&vmd_bus->dev,
>  				   dev_get_msi_domain(&vmd->dev->dev));
>  
> +	vmd->bus[bus_number] = vmd_bus;
> +
>  	return 0;
>  }
>  
> @@ -893,7 +1014,9 @@ static void vmd_bus_enumeration(struct pci_bus *bus, unsigned long features)
>  	vmd_acpi_begin();
>  
>  	pci_scan_child_bus(bus);
> -	vmd_domain_reset(vmd_from_bus(bus));
> +
> +	if (bus->primary == VMD_PRIMARY_BUS0)
> +		vmd_domain_reset(vmd_from_bus(bus));
>  
>  	/*
>  	 * When Intel VMD is enabled, the OS does not discover the Root Ports
> @@ -961,7 +1084,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  	 * limits the bus range to between 0-127, 128-255, or 224-255
>  	 */
>  	if (features & VMD_FEAT_HAS_BUS_RESTRICTIONS) {
> -		ret = vmd_get_bus_number_start(vmd);
> +		ret = vmd_get_bus_number_start(vmd, features);
>  		if (ret)
>  			return ret;
>  	}
> @@ -1021,7 +1144,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  		vmd_set_msi_remapping(vmd, false);
>  	}
>  
> -	ret = vmd_create_bus(vmd, sd, offset);
> +	ret = vmd_create_bus(vmd, VMD_BUS_0, sd, offset);
>  
>  	if (ret) {
>  		pci_err(vmd->dev, "Can't create bus: %d\n", ret);
> @@ -1034,6 +1157,27 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  
>  	vmd_bus_enumeration(vmd->bus[VMD_BUS_0], features);
>  
> +	if (vmd->bus1_rootbus) {
> +		ret = vmd_create_bus(vmd, VMD_BUS_1, sd, offset);
> +		if (ret) {
> +			pci_err(vmd->dev, "Can't create BUS1: %d\n", ret);
> +			return ret;
> +		}
> +
> +		/*
> +		 * Primary bus is not set by pci_create_root_bus(), it is
> +		 * updated here
> +		 */
> +		vmd->bus[VMD_BUS_1]->primary = VMD_PRIMARY_BUS1;
> +
> +		WARN(sysfs_create_link(&vmd->dev->dev.kobj,
> +				       &vmd->bus[VMD_BUS_1]->dev.kobj,
> +				       "domain1"),
> +		     "Can't create symlink to domain1\n");
> +
> +		vmd_bus_enumeration(vmd->bus[VMD_BUS_1], features);
> +	}
> +
>  	return 0;
>  }
>  
> @@ -1113,10 +1257,18 @@ static void vmd_remove(struct pci_dev *dev)
>  	sysfs_remove_link(&vmd->dev->dev.kobj, "domain");
>  	pci_remove_root_bus(vmd->bus[VMD_BUS_0]);
>  
> -	/* CFGBAR is static, does not require releasing memory */
> +	/* CFGBARs are static, do not require releasing memory */
>  	kfree(vmd->resources[VMD_RES_MBAR_1].name);
>  	kfree(vmd->resources[VMD_RES_MBAR_2].name);
>  
> +	if (vmd->bus1_rootbus) {
> +		pci_stop_root_bus(vmd->bus[VMD_BUS_1]);
> +		sysfs_remove_link(&vmd->dev->dev.kobj, "domain1");
> +		pci_remove_root_bus(vmd->bus[VMD_BUS_1]);
> +		kfree(vmd->resources[VMD_RES_BUS1_MBAR_1].name);
> +		kfree(vmd->resources[VMD_RES_BUS1_MBAR_2].name);
> +	}
> +
>  	vmd_cleanup_srcu(vmd);
>  	vmd_detach_resources(vmd);
>  	vmd_remove_irq_domain(vmd);
> @@ -1202,4 +1354,4 @@ module_pci_driver(vmd_drv);
>  MODULE_AUTHOR("Intel Corporation");
>  MODULE_DESCRIPTION("Volume Management Device driver");
>  MODULE_LICENSE("GPL v2");
> -MODULE_VERSION("0.6");
> +MODULE_VERSION("0.7");
> -- 
> 2.39.3
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

