Return-Path: <linux-pci+bounces-10735-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A4193B5A9
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 19:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EB9AB23B55
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 17:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A659116A95B;
	Wed, 24 Jul 2024 17:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O7KmRGYN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E00515FA92
	for <linux-pci@vger.kernel.org>; Wed, 24 Jul 2024 17:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721841317; cv=none; b=Qm4whKfNbfFe363iiStq68jOx9AwH5buyhLvZe3Dv/XsGO+G/TTJ4QTsMS1PH9sr5wwFjs8L6YOlt744fbij0JDiL//DphRF8SvWTlRzQcxm0n2S/NKKtEt+bLe4cXmrvw6wj0wJZPdMhS9dCy2UTefBRKBfTkWBp3KejNcVdzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721841317; c=relaxed/simple;
	bh=vjhJz4pq9OFKa1HL0y4o8+1/oICWOw4BleRi1JLJSVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AStOprHOXeR1U5xM5V7c1G4yWZJ7tCOGzcP0z5BBzcmnJIiVURchMoL8vNChFewXL/DU2rYTV6tnASoCmUrrHxvlJ2im9BHunysdVa3yWm697IiHY0yPpDPqf6hnxUPwdmBBwm2YRjJVZV2/5XGNSB2WB9RQ+rLsBKEekLsLh44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O7KmRGYN; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70d28023accso37672b3a.0
        for <linux-pci@vger.kernel.org>; Wed, 24 Jul 2024 10:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721841315; x=1722446115; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ec611eZK/V5MSJ8SPnbp0mNOZttJdkC3Da0hoMsO6wM=;
        b=O7KmRGYN0kioxY0BnjQ3+mMfMyLIvRLDMc03NtTvPAsLbFiMavR6/li5pxNAoTfH58
         M9MkPWPaK52LYoUFOwIEilKHhoe1xHb9RyXu4jtUyfzak8mEeURPPRdLl92RIdCnAoEY
         j+6+VfyRST+u6CR6y9OG7Mo8mP4jL1iLQuu27UxMtKrC4Q3eGX9s+OsCYMvZr3bvR4+O
         svYie5cDsxOV5jhzdGrBoKZ0ANwqorbSI92NPqxWFwMzX9VZ+S8YahjOZ/0piU9JnHUv
         8kbBflC4DKRPmuBeQEnYZ8+sTTqqHmC04tGMd79Rxu8bsG+3dc018Y0FNXx4goMmR/Qj
         82YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721841315; x=1722446115;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ec611eZK/V5MSJ8SPnbp0mNOZttJdkC3Da0hoMsO6wM=;
        b=Lk9uzihAwUCs/zbUEa/8Ew7E96i7ME+WKdivIXlVCT95q+et6wzbkN02jcp9d/h88D
         BDO82P0Ljv12sKFYsiS/TpfzCEh/7jjry/3CKWHUQYHtfibkGr9vgVcE6l33RedGw1dN
         aMBP7WUS4qs7dzN/RxoNxYu//eaR6Yjbr7BOsia9JTMjrEmuKNkph9fvgR027JK2N4V4
         jmKfSOHEIDI/20k9a8VTtFK0zBXJ1cL+/S90iZb2OOZQZVj531oAMRhp7Cx4SaOq4RQ5
         Y3RhS4MqNCTR8rMCbPsV8B7kDldKDiFFzpLUUYurBoUh0O3eWOsyF3hY1eVJDZwaNGgY
         6pNw==
X-Forwarded-Encrypted: i=1; AJvYcCXbbr7+/yWON9rhn+aoYH+h2lr3/wep4hHEGmnUBUdM9sRyh8x1SzqTztUtHzld41U5KZ1tpDGpUDepDstCdhJwfKIxqQNInJbj
X-Gm-Message-State: AOJu0YxpREQ0kFiosiqfK5erm18U0BDbs73/qhIHOMgkFGlvmfT2H2Bj
	GraBOzrzAo/S2/IcCMn+Xq0ty5rEGN/b9HrBs8IWKixxvAdhSt+zVEVI1sEAmg==
X-Google-Smtp-Source: AGHT+IH2ytgCqZGxePBT45ws//JUzG4yEA3mFCln9OU5s9Pqhuczkz3PWuSVrCF9zFVEG/NUdojwyQ==
X-Received: by 2002:a05:6a21:99a9:b0:1c2:8dd5:71d9 with SMTP id adf61e73a8af0-1c4731eb6efmr652172637.4.1721841314679;
        Wed, 24 Jul 2024 10:15:14 -0700 (PDT)
Received: from thinkpad ([103.244.168.26])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f2947a1sm96755735ad.86.2024.07.24.10.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 10:15:14 -0700 (PDT)
Date: Wed, 24 Jul 2024 22:45:08 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Shradha Todi <shradha.t@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, jingoohan1@gmail.com, fancer.lancer@gmail.com,
	yoshihiro.shimoda.uh@renesas.com, conor.dooley@microchip.com,
	pankaj.dubey@samsung.com, gost.dev@samsung.com
Subject: Re: [PATCH 2/3] PCI: debugfs: Add support for RASDES framework in DWC
Message-ID: <20240724171508.GI3349@thinkpad>
References: <20240625093813.112555-1-shradha.t@samsung.com>
 <CGME20240625094443epcas5p3093ac786a7d0f09de5a3bba17bbd4458@epcas5p3.samsung.com>
 <20240625093813.112555-3-shradha.t@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240625093813.112555-3-shradha.t@samsung.com>

On Tue, Jun 25, 2024 at 03:08:12PM +0530, Shradha Todi wrote:
> Add support to use the RASDES feature of DesignWare PCIe controller
> using debugfs entries.
> 
> RASDES is a vendor specific extended PCIe capability which reads the
> current hardware internal state of PCIe device. Following primary
> features are provided to userspace via debugfs:
> - Debug registers
> - Error injection
> - Statistical counters
> 
> Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> ---
>  drivers/pci/controller/dwc/Kconfig            |   8 +
>  drivers/pci/controller/dwc/Makefile           |   1 +
>  .../controller/dwc/pcie-designware-debugfs.c  | 474 ++++++++++++++++++
>  .../controller/dwc/pcie-designware-debugfs.h  |   0
>  drivers/pci/controller/dwc/pcie-designware.h  |  17 +
>  5 files changed, 500 insertions(+)
>  create mode 100644 drivers/pci/controller/dwc/pcie-designware-debugfs.c
>  create mode 100644 drivers/pci/controller/dwc/pcie-designware-debugfs.h
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index 8afacc90c63b..e8e920470412 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -6,6 +6,14 @@ menu "DesignWare-based PCIe controllers"
>  config PCIE_DW
>  	bool
>  
> +config PCIE_DW_DEBUGFS
> +	bool "DWC PCIe debugfs entries"

What is the benefit of making this driver selectable? If debugfs is enabled in
the kernel, then exposing this interface for all platforms is of no harm (ofc
you should not spam the log as I mentioned below).

> +	help
> +	  Enables debugfs entries for the DWC PCIe Controller.
> +	  These entries make use of the RAS features in the DW
> +	  controller to help in debug, error injection and statistical
> +	  counters
> +
>  config PCIE_DW_HOST
>  	bool
>  	select PCIE_DW
> diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
> index bac103faa523..77bd4f7a2f75 100644
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
> index 000000000000..af5e4ad53fcb
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> @@ -0,0 +1,474 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Synopsys DesignWare PCIe controller debugfs driver
> + *
> + * Copyright (C) 2023 Samsung Electronics Co., Ltd.

2024

> + *		http://www.samsung.com
> + *
> + * Author: Shradha Todi <shradha.t@samsung.com>
> + */
> +
> +#include <linux/debugfs.h>
> +
> +#include "pcie-designware.h"
> +
> +#define RAS_DES_EVENT_COUNTER_CTRL_REG	0x8
> +#define RAS_DES_EVENT_COUNTER_DATA_REG	0xc
> +#define SD_STATUS_L1LANE_REG		0xb0
> +#define ERR_INJ_ENABLE_REG		0x30
> +#define ERR_INJ0_OFF			0x34
> +
> +#define LANE_DETECT_SHIFT		17
> +#define LANE_DETECT_MASK		0x1
> +#define PIPE_RXVALID_SHIFT		18
> +#define PIPE_RXVALID_MASK		0x1
> +
> +#define LANE_SELECT_SHIFT		8
> +#define LANE_SELECT_MASK		0xf
> +#define EVENT_COUNTER_STATUS_SHIFT	7
> +#define EVENT_COUNTER_STATUS_MASK	0x1
> +#define EVENT_COUNTER_ENABLE		(0x7 << 2)
> +#define PER_EVENT_OFF			(0x1 << 2)
> +#define PER_EVENT_ON			(0x3 << 2)
> +
> +#define EINJ_COUNT_MASK			0xff
> +#define EINJ_TYPE_MASK			0xf
> +#define EINJ_TYPE_SHIFT			8
> +#define EINJ_INFO_MASK			0xfffff
> +#define EINJ_INFO_SHIFT			12
> +
> +#define DWC_DEBUGFS_MAX			128

DWC_DEBUGFS_BUF_MAX?

> +
> +struct rasdes_info {
> +	/* to store rasdes capability offset */

Not needed. If you really want to provide comment, please add kdoc for the whole
struct.

> +	u32 ras_cap;
> +	struct mutex dbg_mutex;

dbg_mutex? Use a better name like reg_lock or something else.

> +	struct dentry *rasdes;
> +};
> +
> +struct rasdes_priv {
> +	struct dw_pcie *pci;
> +	int idx;
> +};
> +
> +struct event_counter {
> +	const char *name;
> +	/* values can be between 0-15 */

Use Kdoc.

> +	u32 group_no;
> +	/* values can be between 0-32 */
> +	u32 event_no;
> +};
> +
> +static const struct event_counter event_counters[] = {
> +	{"ebuf_overflow", 0x0, 0x0},
> +	{"ebuf_underrun", 0x0, 0x1},
> +	{"decode_err", 0x0, 0x2},
> +	{"running_disparity_err", 0x0, 0x3},
> +	{"skp_os_parity_err", 0x0, 0x4},
> +	{"sync_header_err", 0x0, 0x5},
> +	{"detect_ei_infer", 0x1, 0x5},
> +	{"receiver_err", 0x1, 0x6},
> +	{"rx_recovery_req", 0x1, 0x7},
> +	{"framing_err", 0x1, 0x9},
> +	{"deskew_err", 0x1, 0xa},
> +	{"bad_tlp", 0x2, 0x0},
> +	{"lcrc_err", 0x2, 0x1},
> +	{"bad_dllp", 0x2, 0x2},
> +};
> +
> +struct err_inj {
> +	const char *name;
> +	/* values can be from group 0 - 6 */

Same here.

> +	u32 err_inj_group;
> +	/* within each group there can be types */
> +	u32 err_inj_type;
> +	/* More details about the error */
> +	u32 err_inj_12_31;
> +};
> +
> +static const struct err_inj err_inj_list[] = {
> +	{"tx_lcrc", 0x0, 0x0, 0x0},
> +	{"tx_ecrc", 0x0, 0x3, 0x0},
> +	{"rx_lcrc", 0x0, 0x8, 0x0},
> +	{"rx_ecrc", 0x0, 0xb, 0x0},
> +	{"b16_crc_dllp", 0x0, 0x1, 0x0},
> +	{"b16_crc_upd_fc", 0x0, 0x2, 0x0},
> +	{"fcrc_tlp", 0x0, 0x4, 0x0},
> +	{"parity_tsos", 0x0, 0x5, 0x0},
> +	{"parity_skpos", 0x0, 0x6, 0x0},
> +	{"ack_nak_dllp", 0x2, 0x0, 0x0},
> +	{"upd_fc_dllp", 0x2, 0x1, 0x0},
> +	{"nak_dllp", 0x2, 0x2, 0x0},
> +	{"inv_sync_hdr_sym", 0x3, 0x0, 0x0},
> +	{"com_pad_ts1", 0x3, 0x1, 0x0},
> +	{"com_pad_ts2", 0x3, 0x2, 0x0},
> +	{"com_fts", 0x3, 0x3, 0x0},
> +	{"com_idl", 0x3, 0x4, 0x0},
> +	{"end_edb", 0x3, 0x5, 0x0},
> +	{"stp_sdp", 0x3, 0x6, 0x0},
> +	{"com_skp", 0x3, 0x7, 0x0},
> +	{"duplicate_dllp", 0x5, 0x0, 0x0},
> +	{"nullified_tlp", 0x5, 0x1, 0x0},
> +};
> +

You can add a Kdoc comment for each helper to document the debugfs entries.

> +static ssize_t dbg_lane_detect_read(struct file *file, char __user *buf,
> +				    size_t count, loff_t *ppos)

Either use 'dwc_debugfs' prefix or no prefix (for static helpers). 'dbg' doesn't
convey much info.

> +{
> +	struct dw_pcie *pci = file->private_data;
> +	struct rasdes_info *rinfo = pci->dump_info;
> +	u32 val;
> +	ssize_t off = 0;
> +	char debugfs_buf[DWC_DEBUGFS_MAX];

Use reverse XMAS tree order.

> +
> +	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap + SD_STATUS_L1LANE_REG);
> +	val = (val >> LANE_DETECT_SHIFT) & LANE_DETECT_MASK;

Use FIELD_* macros whereever applicable.

> +	if (val)
> +		off += scnprintf(debugfs_buf, DWC_DEBUGFS_MAX - off,
> +				 "Detected\n");
> +	else
> +		off += scnprintf(debugfs_buf, DWC_DEBUGFS_MAX - off,
> +				 "Undetected\n");
> +
> +	return simple_read_from_buffer(buf, count, ppos, debugfs_buf, off);
> +}
> +
> +static ssize_t dbg_lane_detect_write(struct file *file, const char __user *buf,
> +				     size_t count, loff_t *ppos)
> +{
> +	struct dw_pcie *pci = file->private_data;
> +	struct rasdes_info *rinfo = pci->dump_info;
> +	u32 val;
> +	u32 lane;
> +
> +	val = kstrtou32_from_user(buf, count, 0, &lane);
> +	if (val)
> +		return val;
> +
> +	if (lane > 15)

What does 15 corresponds to? Can you add a macro?

> +		return -EINVAL;
> +
> +	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap + SD_STATUS_L1LANE_REG);
> +	val &= ~LANE_SELECT_MASK;
> +	val |= lane;
> +	dw_pcie_writel_dbi(pci, rinfo->ras_cap + SD_STATUS_L1LANE_REG, val);
> +
> +	return count;
> +}

[...]

> +static ssize_t cnt_val_read(struct file *file, char __user *buf, size_t count,
> +			    loff_t *ppos)
> +{
> +	struct rasdes_priv *pdata = file->private_data;
> +	struct dw_pcie *pci = pdata->pci;
> +	struct rasdes_info *rinfo = pci->dump_info;
> +	u32 val;
> +	ssize_t off = 0;
> +	char debugfs_buf[DWC_DEBUGFS_MAX];
> +
> +	mutex_lock(&rinfo->dbg_mutex);
> +	set_event_number(pdata, pci, rinfo);
> +	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap +
> +				RAS_DES_EVENT_COUNTER_DATA_REG);
> +	mutex_unlock(&rinfo->dbg_mutex);
> +	off += scnprintf(debugfs_buf, DWC_DEBUGFS_MAX - off,
> +				 "Value: %d\n", val);

Use elaborative text instead of just 'Value'.

> +
> +	return simple_read_from_buffer(buf, count, ppos, debugfs_buf, off);
> +}
> +
> +static ssize_t err_inj_write(struct file *file, const char __user *buf,
> +			     size_t count, loff_t *ppos)
> +{
> +	struct rasdes_priv *pdata = file->private_data;
> +	struct dw_pcie *pci = pdata->pci;
> +	struct rasdes_info *rinfo = pci->dump_info;
> +	u32 val;
> +	u32 counter;
> +
> +	val = kstrtou32_from_user(buf, count, 0, &counter);
> +	if (val)
> +		return val;
> +
> +	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap + ERR_INJ0_OFF +
> +			(0x4 * err_inj_list[pdata->idx].err_inj_group));
> +	val &= ~(EINJ_TYPE_MASK << EINJ_TYPE_SHIFT);
> +	val |= err_inj_list[pdata->idx].err_inj_type << EINJ_TYPE_SHIFT;
> +	val &= ~(EINJ_INFO_MASK << EINJ_INFO_SHIFT);
> +	val |= err_inj_list[pdata->idx].err_inj_12_31 << EINJ_INFO_SHIFT;
> +	val &= ~EINJ_COUNT_MASK;
> +	val |= counter;
> +	dw_pcie_writel_dbi(pci, rinfo->ras_cap + ERR_INJ0_OFF +
> +			(0x4 * err_inj_list[pdata->idx].err_inj_group), val);
> +	dw_pcie_writel_dbi(pci, rinfo->ras_cap + ERR_INJ_ENABLE_REG,
> +			   (0x1 << err_inj_list[pdata->idx].err_inj_group));
> +
> +	return count;
> +}
> +
> +#define dwc_debugfs_create(name)			\
> +debugfs_create_file(#name, 0644, rasdes_debug, pci,	\
> +			&dbg_ ## name ## _fops)
> +
> +#define DWC_DEBUGFS_FOPS(name)					\
> +static const struct file_operations dbg_ ## name ## _fops = {	\
> +	.read = dbg_ ## name ## _read,				\
> +	.write = dbg_ ## name ## _write				\
> +}
> +
> +DWC_DEBUGFS_FOPS(lane_detect);
> +DWC_DEBUGFS_FOPS(rx_valid);
> +
> +static const struct file_operations cnt_en_ops = {

'cnt_en_ops' is not descriptive enough. Pick a better name that reflects what
this ops is meant for, like 'counter_enable_ops'. This applies to all other ops
as well.

> +	.open = simple_open,
> +	.read = cnt_en_read,
> +	.write = cnt_en_write,
> +};
> +
> +static const struct file_operations cnt_lane_ops = {
> +	.open = simple_open,
> +	.read = cnt_lane_read,
> +	.write = cnt_lane_write,
> +};
> +
> +static const struct file_operations cnt_val_ops = {
> +	.open = simple_open,
> +	.read = cnt_val_read,
> +};
> +
> +static const struct file_operations err_inj_ops = {
> +	.open = simple_open,
> +	.write = err_inj_write,
> +};
> +
> +void dwc_pcie_rasdes_debugfs_deinit(struct dw_pcie *pci)
> +{
> +	struct rasdes_info *rinfo = pci->dump_info;
> +
> +	debugfs_remove_recursive(rinfo->rasdes);
> +	mutex_destroy(&rinfo->dbg_mutex);
> +}
> +
> +int dwc_pcie_rasdes_debugfs_init(struct dw_pcie *pci)
> +{
> +	struct device *dev = pci->dev;
> +	int ras_cap;
> +	struct rasdes_info *dump_info;
> +	char dirname[DWC_DEBUGFS_MAX];
> +	struct dentry *dir, *rasdes_debug, *rasdes_err_inj;
> +	struct dentry *rasdes_event_counter, *rasdes_events;
> +	int i;
> +	struct rasdes_priv *priv_tmp;
> +
> +	ras_cap = dw_pcie_find_vsec_capability(pci, DW_PCIE_RAS_DES_CAP);
> +	if (!ras_cap) {
> +		dev_err(dev, "No RASDES capability available\n");

If all controllers start calling this API, then this will become a noise. Can
you move it to dev_dbg()?

> +		return -ENODEV;
> +	}
> +
> +	dump_info = devm_kzalloc(dev, sizeof(*dump_info), GFP_KERNEL);
> +	if (!dump_info)
> +		return -ENOMEM;
> +
> +	/* Create main directory for each platform driver */
> +	sprintf(dirname, "pcie_dwc_%s", dev_name(dev));
> +	dir = debugfs_create_dir(dirname, NULL);
> +
> +	/* Create subdirectories for Debug, Error injection, Statistics */
> +	rasdes_debug = debugfs_create_dir("rasdes_debug", dir);
> +	rasdes_err_inj = debugfs_create_dir("rasdes_err_inj", dir);
> +	rasdes_event_counter = debugfs_create_dir("rasdes_event_counter", dir);
> +
> +	mutex_init(&dump_info->dbg_mutex);
> +	dump_info->ras_cap = ras_cap;
> +	dump_info->rasdes = dir;
> +	pci->dump_info = dump_info;
> +
> +	/* Create debugfs files for Debug subdirectory */
> +	dwc_debugfs_create(lane_detect);
> +	dwc_debugfs_create(rx_valid);
> +
> +	/* Create debugfs files for Error injection subdirectory */
> +	for (i = 0; i < ARRAY_SIZE(err_inj_list); i++) {
> +		priv_tmp = devm_kzalloc(dev, sizeof(*priv_tmp), GFP_KERNEL);
> +		if (!priv_tmp)
> +			goto err;
> +
> +		priv_tmp->idx = i;
> +		priv_tmp->pci = pci;
> +		debugfs_create_file(err_inj_list[i].name, 0200,

Use macros for file attributes.

> +				    rasdes_err_inj, priv_tmp, &err_inj_ops);
> +	}
> +
> +	/* Create debugfs files for Statistical counter subdirectory */
> +	for (i = 0; i < ARRAY_SIZE(event_counters); i++) {
> +		priv_tmp = devm_kzalloc(dev, sizeof(*priv_tmp), GFP_KERNEL);
> +		if (!priv_tmp)
> +			goto err;
> +
> +		priv_tmp->idx = i;
> +		priv_tmp->pci = pci;
> +		rasdes_events = debugfs_create_dir(event_counters[i].name,
> +						   rasdes_event_counter);
> +		if (event_counters[i].group_no == 0) {
> +			debugfs_create_file("lane_select", 0644, rasdes_events,
> +					    priv_tmp, &cnt_lane_ops);
> +		}
> +		debugfs_create_file("counter_value", 0444, rasdes_events, priv_tmp,
> +				    &cnt_val_ops);

What does the 'counter value' represent?

> +		debugfs_create_file("counter_enable", 0644, rasdes_events, priv_tmp,
> +				    &cnt_en_ops);
> +	}
> +
> +	return 0;
> +err:

err_deinit?

> +	dwc_pcie_rasdes_debugfs_deinit(pci);
> +	return -ENOMEM;

It is really a bad design to return a fixed error no in the error path. Pass the
error no and return it.

> +}
> diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.h b/drivers/pci/controller/dwc/pcie-designware-debugfs.h
> new file mode 100644
> index 000000000000..e69de29bb2d1
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 77686957a30d..9fa9f33e4ddb 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -223,6 +223,8 @@
>  
>  #define PCIE_RAS_DES_EVENT_COUNTER_DATA		0xc
>  
> +#define DW_PCIE_RAS_DES_CAP			0x2
> +
>  /*
>   * The default address offset between dbi_base and atu_base. Root controller
>   * drivers are not required to initialize atu_base if the offset matches this
> @@ -410,6 +412,7 @@ struct dw_pcie {
>  	struct reset_control_bulk_data	core_rsts[DW_PCIE_NUM_CORE_RSTS];
>  	struct gpio_desc		*pe_rst;
>  	bool			suspended;
> +	void			*dump_info;

Why an opaque pointer? Also, the name is not elaborative.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

