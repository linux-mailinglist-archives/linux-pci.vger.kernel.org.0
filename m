Return-Path: <linux-pci+bounces-21746-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1067A3A0BE
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 16:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDB5518899DB
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 15:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D20F26B0AC;
	Tue, 18 Feb 2025 15:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qCc+Uo4U"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1C626AA8D
	for <linux-pci@vger.kernel.org>; Tue, 18 Feb 2025 15:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739890969; cv=none; b=j5nlRu1UF1tW4vQKS72Ane6LCe99YWVLVAtCTeVZPLfZZdwTEJHIPqv1BruE22v3riQbPONmcESiUm/Rnnhpb8L5BWInKBvfL+8YojY3FZBrkoxzGAIzyuhcVAzRDevKoO6eiDvHbYCjs9nnwapAZzruOlMs+96/CS1r8lcAtnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739890969; c=relaxed/simple;
	bh=IJqDsCY7HJfENXpaqjfftAGCHoVZB5afzR2gtzOaUlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r91CF1FdhetKuxQz9pz6wVW7opxHqyxS5350ZpOCZ8YtJ1Xfa8H5jSNSX1wUe0g+cuRrCr4jN7rJa8JLu8CwjwP+lYmyzaiHdaDarMjJPzbN5MvLTEkRUpXslnaajnZfKsUUID9vQZfjQ54hlSJTJysEL08XUamwQs+pZpNpu5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qCc+Uo4U; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-220bfdfb3f4so114165435ad.2
        for <linux-pci@vger.kernel.org>; Tue, 18 Feb 2025 07:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739890966; x=1740495766; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jWcJBMztVJPnjv77fK+NPeNY4keL9ty0/4Tf67Wb3BE=;
        b=qCc+Uo4UPB3hH9e0vQOIFG2HLivcdFqhqd3u+lKL1gjgR0Z4EL7Cvp7NmNk24T7F3i
         It0k+x5FLwgxg91NAnRzWbq/s0aXdhX6iAwNrfJIajZNz1Ly5kN922OBEUnyzDKsqca7
         w0e69UYPYFPx6qdpAc7oqMZtX0fXzm1eQohaDB2WYY2eDeO9aS3DCOzMSDTxEbH00QyF
         2h8PMqCxF1g9QzRaTUL7JsOlSKTc3w6sfMSRuZFcN4WVKkJw8YkFU5xl+fnUrPK7OyQn
         7RhUEP7ux64wopV9bRy+nI8pPIBIFQX27bx7qaZn2QNbNK7/H4xQ9/s5aeUtJ5A5AxdQ
         QiNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739890966; x=1740495766;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jWcJBMztVJPnjv77fK+NPeNY4keL9ty0/4Tf67Wb3BE=;
        b=bXLgJIl9NIVTfXhDWzZLdSJ6rVvXR264wjIC24snTWc69tf3TpAWNd2Ma3WME58XXw
         m5jKVNMaJV4+TTW8gf2TcgjMWpZO6+sPEJvD+S/N4kUe9xASbgE4N8tvcYnYvRalSG45
         pnDZ4iQRpR7Vq+UKAHYo55TrUUIgUDcN6geqQdRYG6E9TMeGoEgqhOLGTuSxuQDm56/Y
         C8CewmeHZENnErKX5CbDIexKGu9qTGksLXBYXf0ECryA6Ez5/tvhkahfX/b90wGoZDxx
         RbfV/MaGtTse4AYjfpUMwQ0Y5auiuOSXcsMx1tzYlb2dGguhLYbN15K2Iffkwh4Z8sU9
         6Guw==
X-Forwarded-Encrypted: i=1; AJvYcCXSy6PGNU8q1l5LE2I2jM+xCFfilztvJDCylOHE7lIygnO1ARrWM91trgvFQBlgYutQAMLPa5qS820=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+xR6Dvh/VYeyHsTdvCwTzGTruSIXP4i7xCK2BbpZmQfK9AqaK
	1psIRKXbLrw6O5Xsrb6b2C3lzuVs9b8xKxSE2pwZc0GJjtugFjXe5jqw6Aqe6w==
X-Gm-Gg: ASbGncsoBfZ1iRxQi+2HPdHfJuMrugPeOYEITEaQPhYGIcV7Uyktt7H4NBroK0zppb0
	MSD66SKTcYPtVwTp/jd+6zszKQbvU6lE3cPdImrBH5xiX2CSvylnrJXP5QtWL0FmQFMzUj031DG
	K5Ka8Vzu5aWIKiWuvt0Yki8zuTz481tmuNGiM9/2eupDruhsS4Js88uHFv8t6QTQztRKlCpcHqw
	cIW/rzY8Vy6H0xiXF1klk6fqrq/4U40EqSgHGzE0y/NJ1EUZkNbYoiWKvccP42rAFOtbGLYalWd
	2WQZfatx4OG74hv4ZzoyqHK62K8=
X-Google-Smtp-Source: AGHT+IF+vWFeQAwC0HTJEP2zVCzr9RvYcRojW9qsaHZE9h4rXSus+Sx1wVii57C3PhSK5l9G3L3+IA==
X-Received: by 2002:a05:6a21:9999:b0:1ee:66f6:87e6 with SMTP id adf61e73a8af0-1ee8cbbba1amr25798990637.31.1739890966357;
        Tue, 18 Feb 2025 07:02:46 -0800 (PST)
Received: from thinkpad ([120.56.197.245])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7324273e318sm10548970b3a.96.2025.02.18.07.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 07:02:45 -0800 (PST)
Date: Tue, 18 Feb 2025 20:32:39 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Shradha Todi <shradha.t@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, jingoohan1@gmail.com,
	Jonathan.Cameron@Huawei.com, fan.ni@samsung.com,
	nifan.cxl@gmail.com, a.manzanares@samsung.com,
	pankaj.dubey@samsung.com, cassel@kernel.org, 18255117159@163.com,
	quic_nitegupt@quicinc.com, quic_krichai@quicinc.com,
	gost.dev@samsung.com
Subject: Re: [PATCH v6 2/4] Add debugfs based silicon debug support in DWC
Message-ID: <20250218150239.mnylvhyfnw6dtzag@thinkpad>
References: <20250214105007.97582-1-shradha.t@samsung.com>
 <CGME20250214105341epcas5p11ea07dba0a55700bc098077eb53e79b8@epcas5p1.samsung.com>
 <20250214105007.97582-3-shradha.t@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250214105007.97582-3-shradha.t@samsung.com>

On Fri, Feb 14, 2025 at 04:20:05PM +0530, Shradha Todi wrote:
> Add support to provide silicon debug interface to userspace. This set
> of debug registers are part of the RASDES feature present in DesignWare
> PCIe controllers.
> 
> Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> ---
>  Documentation/ABI/testing/debugfs-dwc-pcie    |  13 ++
>  drivers/pci/controller/dwc/Kconfig            |  10 +
>  drivers/pci/controller/dwc/Makefile           |   1 +
>  .../controller/dwc/pcie-designware-debugfs.c  | 207 ++++++++++++++++++
>  .../pci/controller/dwc/pcie-designware-ep.c   |   5 +
>  .../pci/controller/dwc/pcie-designware-host.c |   6 +
>  drivers/pci/controller/dwc/pcie-designware.h  |  20 ++
>  7 files changed, 262 insertions(+)
>  create mode 100644 Documentation/ABI/testing/debugfs-dwc-pcie
>  create mode 100644 drivers/pci/controller/dwc/pcie-designware-debugfs.c
> 
> diff --git a/Documentation/ABI/testing/debugfs-dwc-pcie b/Documentation/ABI/testing/debugfs-dwc-pcie
> new file mode 100644
> index 000000000000..e8ed34e988ef
> --- /dev/null
> +++ b/Documentation/ABI/testing/debugfs-dwc-pcie
> @@ -0,0 +1,13 @@
> +What:		/sys/kernel/debug/dwc_pcie_<dev>/rasdes_debug/lane_detect
> +Date:		Feburary 2025

Please align these fields

> +Contact:	Shradha Todi <shradha.t@samsung.com>
> +Description:	(RW) Write the lane number to be checked for detection.	Read
> +		will return whether PHY indicates receiver detection on the
> +		selected lane. The default selected lane is Lane0.
> +
> +What:		/sys/kernel/debug/dwc_pcie_<dev>/rasdes_debug/rx_valid
> +Date:		Feburary 2025
> +Contact:	Shradha Todi <shradha.t@samsung.com>
> +Description:	(RW) Write the lane number to be checked as valid or invalid. Read
> +		will return the status of PIPE RXVALID signal of the selected lane.
> +		The default selected lane is Lane0.
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index b6d6778b0698..48a10428a492 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -6,6 +6,16 @@ menu "DesignWare-based PCIe controllers"
>  config PCIE_DW
>  	bool
>  
> +config PCIE_DW_DEBUGFS
> +	default y
> +	depends on DEBUG_FS
> +	depends on PCIE_DW_HOST || PCIE_DW_EP
> +	bool "DWC PCIe debugfs entries"
> +	help
> +	  Enables debugfs entries for the DW PCIe Controller. These entries
> +	  provide all debug features related to DW controller including the RAS
> +	  DES features to help in debug, error injection and statistical counters.
> +
>  config PCIE_DW_HOST
>  	bool
>  	select PCIE_DW
> diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
> index a8308d9ea986..54565eedc52c 100644
> --- a/drivers/pci/controller/dwc/Makefile
> +++ b/drivers/pci/controller/dwc/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_PCIE_DW) += pcie-designware.o
> +obj-$(CONFIG_PCIE_DW_DEBUGFS) += pcie-designware-debugfs.o
>  obj-$(CONFIG_PCIE_DW_HOST) += pcie-designware-host.o
>  obj-$(CONFIG_PCIE_DW_EP) += pcie-designware-ep.o
>  obj-$(CONFIG_PCIE_DW_PLAT) += pcie-designware-plat.o
> diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.c b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> new file mode 100644
> index 000000000000..fe799d36fa7f
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> @@ -0,0 +1,207 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Synopsys DesignWare PCIe controller debugfs driver
> + *
> + * Copyright (C) 2025 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com
> + *
> + * Author: Shradha Todi <shradha.t@samsung.com>
> + */
> +
> +#include <linux/debugfs.h>
> +
> +#include "pcie-designware.h"
> +
> +#define SD_STATUS_L1LANE_REG		0xb0
> +#define PIPE_RXVALID			BIT(18)
> +#define PIPE_DETECT_LANE		BIT(17)
> +#define LANE_SELECT			GENMASK(3, 0)
> +
> +#define DWC_DEBUGFS_BUF_MAX		128
> +
> +struct dwc_pcie_vsec_id {
> +	u16 vendor_id;
> +	u16 vsec_id;
> +	u8 vsec_rev;
> +};
> +
> +/*
> + * VSEC IDs are allocated by the vendor, so a given ID may mean different
> + * things to different vendors. See PCIe r6.0, sec 7.9.5.2.
> + */
> +static const struct dwc_pcie_vsec_id dwc_pcie_vsec_ids[] = {
> +	{ .vendor_id = PCI_VENDOR_ID_ALIBABA,
> +		.vsec_id = 0x02, .vsec_rev = 0x4 },
> +	{ .vendor_id = PCI_VENDOR_ID_AMPERE,
> +		.vsec_id = 0x02, .vsec_rev = 0x4 },
> +	{ .vendor_id = PCI_VENDOR_ID_QCOM,
> +		.vsec_id = 0x02, .vsec_rev = 0x4 },
> +	{ .vendor_id = PCI_VENDOR_ID_SAMSUNG,
> +		.vsec_id = 0x02, .vsec_rev = 0x4 },
> +	{} /* terminator */

This should go into the common include file as I proposed in my series:
https://lore.kernel.org/linux-pci/20250218-pcie-qcom-ptm-v1-1-16d7e480d73e@linaro.org/

> +};
> +
> +/**
> + * struct dwc_pcie_rasdes_info - Stores controller common information
> + * @ras_cap_offset: RAS DES vendor specific extended capability offset
> + * @reg_lock: Mutex used for RASDES shadow event registers

If this is not used by all register accesses, please rename it as such. Like,
reg_event_lock.

> + *
> + * Any parameter constant to all files of the debugfs hierarchy for a single controller
> + * will be stored in this struct. It is allocated and assigned to controller specific
> + * struct dw_pcie during initialization.
> + */
> +struct dwc_pcie_rasdes_info {
> +	u32 ras_cap_offset;
> +	struct mutex reg_lock;
> +};
> +
> +static ssize_t lane_detect_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
> +{
> +	struct dw_pcie *pci = file->private_data;
> +	struct dwc_pcie_rasdes_info *rinfo = pci->debugfs->rasdes_info;
> +	char debugfs_buf[DWC_DEBUGFS_BUF_MAX];
> +	ssize_t off = 0;

Not required. See below.

> +	u32 val;
> +
> +	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + SD_STATUS_L1LANE_REG);
> +	val = FIELD_GET(PIPE_DETECT_LANE, val);
> +	if (val)
> +		off += scnprintf(debugfs_buf, DWC_DEBUGFS_BUF_MAX - off, "Lane Detected\n");

I don't understand why you want to add 'off' which was initialized to 0. Also
this just prints single string.

> +	else
> +		off += scnprintf(debugfs_buf, DWC_DEBUGFS_BUF_MAX - off, "Lane Undetected\n");
> +
> +	return simple_read_from_buffer(buf, count, ppos, debugfs_buf, off);
> +}
> +
> +static ssize_t lane_detect_write(struct file *file, const char __user *buf,
> +				 size_t count, loff_t *ppos)
> +{
> +	struct dw_pcie *pci = file->private_data;
> +	struct dwc_pcie_rasdes_info *rinfo = pci->debugfs->rasdes_info;
> +	u32 lane, val;
> +
> +	val = kstrtou32_from_user(buf, count, 0, &lane);
> +	if (val)
> +		return val;
> +
> +	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + SD_STATUS_L1LANE_REG);
> +	val &= ~(LANE_SELECT);
> +	val |= FIELD_PREP(LANE_SELECT, lane);
> +	dw_pcie_writel_dbi(pci, rinfo->ras_cap_offset + SD_STATUS_L1LANE_REG, val);
> +
> +	return count;
> +}
> +
> +static ssize_t rx_valid_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
> +{
> +	struct dw_pcie *pci = file->private_data;
> +	struct dwc_pcie_rasdes_info *rinfo = pci->debugfs->rasdes_info;
> +	char debugfs_buf[DWC_DEBUGFS_BUF_MAX];
> +	ssize_t off = 0;
> +	u32 val;
> +
> +	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + SD_STATUS_L1LANE_REG);
> +	val = FIELD_GET(PIPE_RXVALID, val);
> +	if (val)
> +		off += scnprintf(debugfs_buf, DWC_DEBUGFS_BUF_MAX - off, "RX Valid\n");

Same here.

> +	else
> +		off += scnprintf(debugfs_buf, DWC_DEBUGFS_BUF_MAX - off, "RX Invalid\n");
> +
> +	return simple_read_from_buffer(buf, count, ppos, debugfs_buf, off);
> +}
> +
> +static ssize_t rx_valid_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
> +{
> +	return lane_detect_write(file, buf, count, ppos);
> +}
> +
> +#define dwc_debugfs_create(name)			\
> +debugfs_create_file(#name, 0644, rasdes_debug, pci,	\
> +			&dbg_ ## name ## _fops)
> +
> +#define DWC_DEBUGFS_FOPS(name)					\
> +static const struct file_operations dbg_ ## name ## _fops = {	\
> +	.open = simple_open,				\
> +	.read = name ## _read,				\
> +	.write = name ## _write				\
> +}
> +
> +DWC_DEBUGFS_FOPS(lane_detect);
> +DWC_DEBUGFS_FOPS(rx_valid);
> +
> +static void dwc_pcie_rasdes_debugfs_deinit(struct dw_pcie *pci)
> +{
> +	struct dwc_pcie_rasdes_info *rinfo = pci->debugfs->rasdes_info;
> +
> +	mutex_destroy(&rinfo->reg_lock);
> +}
> +
> +static int dwc_pcie_rasdes_debugfs_init(struct dw_pcie *pci, struct dentry *dir)
> +{
> +	struct dentry *rasdes_debug;
> +	struct dwc_pcie_rasdes_info *rasdes_info;
> +	const struct dwc_pcie_vsec_id *vid;
> +	struct device *dev = pci->dev;
> +	int ras_cap;
> +
> +	for (vid = dwc_pcie_vsec_ids; vid->vendor_id; vid++) {
> +		ras_cap = dw_pcie_find_vsec_capability(pci, vid->vendor_id,
> +							vid->vsec_id);
> +		if (ras_cap)
> +			break;
> +	}
> +	if (!ras_cap) {
> +		dev_dbg(dev, "no rasdes capability available\n");
> +		return -ENODEV;
> +	}

This will also go inside a new API, dw_pcie_find_rasdes_capability(pci).

> +
> +	rasdes_info = devm_kzalloc(dev, sizeof(*rasdes_info), GFP_KERNEL);
> +	if (!rasdes_info)
> +		return -ENOMEM;
> +
> +	/* Create subdirectories for Debug, Error injection, Statistics */
> +	rasdes_debug = debugfs_create_dir("rasdes_debug", dir);

_debug prefix is not needed since the directory itself belongs to debugfs.

> +
> +	mutex_init(&rasdes_info->reg_lock);
> +	rasdes_info->ras_cap_offset = ras_cap;
> +	pci->debugfs->rasdes_info = rasdes_info;
> +
> +	/* Create debugfs files for Debug subdirectory */
> +	dwc_debugfs_create(lane_detect);
> +	dwc_debugfs_create(rx_valid);
> +
> +	return 0;
> +}
> +
> +void dwc_pcie_debugfs_deinit(struct dw_pcie *pci)
> +{
> +	dwc_pcie_rasdes_debugfs_deinit(pci);
> +	debugfs_remove_recursive(pci->debugfs->debug_dir);
> +}
> +
> +int dwc_pcie_debugfs_init(struct dw_pcie *pci)
> +{
> +	char dirname[DWC_DEBUGFS_BUF_MAX];
> +	struct device *dev = pci->dev;
> +	struct debugfs_info *debugfs;
> +	struct dentry *dir;
> +	int ret;
> +
> +	/* Create main directory for each platform driver */
> +	snprintf(dirname, DWC_DEBUGFS_BUF_MAX, "dwc_pcie_%s", dev_name(dev));
> +	dir = debugfs_create_dir(dirname, NULL);
> +	if (IS_ERR(dir))
> +		return PTR_ERR(dir);

debugfs creation is not supposed to fail. So you should remove the error check.

> +
> +	debugfs = devm_kzalloc(dev, sizeof(*debugfs), GFP_KERNEL);
> +	if (!debugfs)
> +		return -ENOMEM;
> +
> +	debugfs->debug_dir = dir;
> +	pci->debugfs = debugfs;
> +	ret = dwc_pcie_rasdes_debugfs_init(pci, dir);
> +	if (ret)
> +		dev_dbg(dev, "rasdes debugfs init failed\n");

RASDES

> +
> +	return 0;
> +}
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index f3ac7d46a855..a87a714bb472 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -642,6 +642,7 @@ void dw_pcie_ep_cleanup(struct dw_pcie_ep *ep)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  
> +	dwc_pcie_debugfs_deinit(pci);
>  	dw_pcie_edma_remove(pci);
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_ep_cleanup);
> @@ -813,6 +814,10 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
>  
>  	dw_pcie_ep_init_non_sticky_registers(pci);
>  
> +	ret = dwc_pcie_debugfs_init(pci);
> +	if (ret)
> +		goto err_remove_edma;
> +
>  	return 0;
>  
>  err_remove_edma:
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index d2291c3ceb8b..6b03ef7fd014 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -524,6 +524,10 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  	if (ret)
>  		goto err_remove_edma;
>  
> +	ret = dwc_pcie_debugfs_init(pci);
> +	if (ret)
> +		goto err_remove_edma;
> +

Why can't you move it to the end of the function?

>  	if (!dw_pcie_link_up(pci)) {
>  		ret = dw_pcie_start_link(pci);
>  		if (ret)
> @@ -571,6 +575,8 @@ void dw_pcie_host_deinit(struct dw_pcie_rp *pp)
>  
>  	dw_pcie_stop_link(pci);
>  
> +	dwc_pcie_debugfs_deinit(pci);
> +

This should be moved to the start of the function.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

