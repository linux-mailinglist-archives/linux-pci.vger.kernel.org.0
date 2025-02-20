Return-Path: <linux-pci+bounces-21869-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D886CA3D11E
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 07:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD83A18917BE
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 06:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0981D5175;
	Thu, 20 Feb 2025 06:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D54e+EWL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CF01BE86E
	for <linux-pci@vger.kernel.org>; Thu, 20 Feb 2025 06:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740031623; cv=none; b=bRYTaN0Wlk7g6/GW+Q4j9SLHAKl2G98QHRS5U1LCMoPXNKVwb3qONuboHAEkfluyGco1VmsebPR2JZ6Oa2otPa4fm4072PS5jkDEVjzAYgnZYVOh8A6mYkXmiOSnoLckQI37OJKFm+zzkxulVcsgUbE2n6zNpsn6Q0CQH4gjVUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740031623; c=relaxed/simple;
	bh=Vp7S5aMZRDaxlLaB+xF04clldlJwFwjrvZun2TKdfrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jlAZDSchrFAPey52mfHKkZLTr/7TQgUUvwqmSZx0fadFyjMTj2ZcHLT7yg+ii2WrpQBCVZlAA4mVILRjIyhB6RQFlhTbSV02AamdIOFdN83w1HgjxLCCuox5913YitzBQaGD8xCJhv4IkUVK7eIrPszVC/Ey6Zq7EZtJ21OVyQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D54e+EWL; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21c2f1b610dso14151445ad.0
        for <linux-pci@vger.kernel.org>; Wed, 19 Feb 2025 22:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740031621; x=1740636421; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O/X2ikjCAl1i7RsE9nBl+7NV4Kv1B2h8vdTq8JIddNw=;
        b=D54e+EWLCbVGWMsoWeQqZoCb8XHSHzQX+i2PEaPxJvjlIWHlTYiVQ5WrLNBAb91DQu
         uHuEhhn1QnzcCRUksxGEAGf+2JL3dV6/kdIZBlGgQg4Bfplogtuc5wH66FNEc1f8iEQ+
         7eJEtREFwfy+V7wN+B6UJxbBgFQ3hcSGIs012i4e11ovxqO0v2ixh8+qPJPxA6a2u50s
         2qBmuWNeIAQXi2snMC+FHmCJTAWvZATaYLbjNlNrxplv5JTGwezBhGhdaDUl6lj8lbn0
         FmT/5TL9pzt2cXafVCuut7PsZo2nlZlLhAWGcrAhRNAAJ2SiMW3oyPu4YPw52ZR0/6VT
         vLmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740031621; x=1740636421;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O/X2ikjCAl1i7RsE9nBl+7NV4Kv1B2h8vdTq8JIddNw=;
        b=DE0ED/R8LG3aqjRm2R7BL8HvSW0MEztUSiXaDN1y8NwaG2WnQSi/PSUuW+ZsNh9Nqk
         fF/8p/Qb6Dx6GIJCr+Vlh46MgjIiBQncJQmCQ6th2Rz8MHUPtXfoJU2+S750TsR17OU7
         wo3AcSgirNK0/aZy3SNn38iiWYUPEC0JPvZouDYpN2X4md+ytCcE6oKBBEM1Fob9yrLK
         kueX0ToyJpHcU0+jpw2J6HPXwrDoiiWmmDSyfIfAlEB004MUTHQpR9kP5dh4I6P4/HGc
         ZG/NwJQJoTme2BhsadEMktlgG9orVpzOUT3cVovwbtEPYpII4t2ksT0ms1Qzt5j0ZCZN
         B7uw==
X-Forwarded-Encrypted: i=1; AJvYcCUzFHeO8qEtQMKViXToDgw3sPYnPsrC16Ja+kHf64/tLzyyKN4utwMDsV1VZACldFqpAPC5tN/z8Pw=@vger.kernel.org
X-Gm-Message-State: AOJu0YznOw5/+7wqgKhIEavhzOV/xzcg0lSyXAs55205aroV7pCWjvlE
	TPuGQlBuAkqTJn8szyn1Qxta2b+W8Z5/L1BQbJpzqTXM9aGb3qgsUl7NPA254A==
X-Gm-Gg: ASbGncvOozN5/nmbUK2Qr0l0CNqkL/eq5IH+V4VaZ8BOrLR+TnCP/xAQicVkYV70jMT
	Cg/Gs6rO/XAxe2Kyp/FUWlKr0WSn4/WXe/5vgLxWjwcRt5wpZ7sOW9eo49KML9lB1TG36G+mbv2
	coV6RlK4cHOFrnzdq/5SEWhh9kpTVS3oTJllX8CXfxJGHmGV0QIBqcQ+tOtMIT967zhMIoL6NKU
	SFXMHT0KUbMdNfBUFMUHDeEkvzjC5+6QkTzmCrQc9tVUNpmAlLcb+AC617Gd9oht47strRjgYVb
	roSWvY8whF3LR4k+/jOzgrwlBg==
X-Google-Smtp-Source: AGHT+IFw7Z785uVCKGSbJY6+y8LFZJ9WfdDWB0seduWV88kZGRwVoXW28Qc/vPpZr3dOY9tilZlsZQ==
X-Received: by 2002:a05:6a21:1506:b0:1ee:e641:ca8 with SMTP id adf61e73a8af0-1eee6410dc4mr2206274637.20.1740031620635;
        Wed, 19 Feb 2025 22:07:00 -0800 (PST)
Received: from thinkpad ([120.60.70.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73287ac0ea9sm5725205b3a.152.2025.02.19.22.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 22:06:59 -0800 (PST)
Date: Thu, 20 Feb 2025 11:36:50 +0530
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
Subject: Re: [PATCH v6 3/4] Add debugfs based error injection support in DWC
Message-ID: <20250220060650.sqioighxfputkifs@thinkpad>
References: <20250214105007.97582-1-shradha.t@samsung.com>
 <CGME20250214105347epcas5p1205c5925fd239e34b3608ded2c0349c7@epcas5p1.samsung.com>
 <20250214105007.97582-4-shradha.t@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250214105007.97582-4-shradha.t@samsung.com>

On Fri, Feb 14, 2025 at 04:20:06PM +0530, Shradha Todi wrote:
> Add support to provide error injection interface to userspace. This set
> of debug registers are part of the RASDES feature present in DesignWare
> PCIe controllers.
> 
> Signed-off-by: Shradha Todi <shradha.t@samsung.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  Documentation/ABI/testing/debugfs-dwc-pcie    |  70 ++++++++
>  .../controller/dwc/pcie-designware-debugfs.c  | 165 +++++++++++++++++-
>  2 files changed, 233 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/debugfs-dwc-pcie b/Documentation/ABI/testing/debugfs-dwc-pcie
> index e8ed34e988ef..9eae0ab1dbea 100644
> --- a/Documentation/ABI/testing/debugfs-dwc-pcie
> +++ b/Documentation/ABI/testing/debugfs-dwc-pcie
> @@ -11,3 +11,73 @@ Contact:	Shradha Todi <shradha.t@samsung.com>
>  Description:	(RW) Write the lane number to be checked as valid or invalid. Read
>  		will return the status of PIPE RXVALID signal of the selected lane.
>  		The default selected lane is Lane0.
> +
> +What:		/sys/kernel/debug/dwc_pcie_<dev>/rasdes_err_inj/<error>
> +Date:		Feburary 2025
> +Contact:	Shradha Todi <shradha.t@samsung.com>
> +Description:	rasdes_err_inj is the directory which can be used to inject errors in the
> +		system. The possible errors that can be injected are:
> +
> +		1) TLP LCRC error injection TX Path - tx_lcrc
> +		2) 16b CRC error injection of ACK/NAK DLLP - b16_crc_dllp
> +		3) 16b CRC error injection of Update-FC DLLP - b16_crc_upd_fc
> +		4) TLP ECRC error injection TX Path - tx_ecrc
> +		5) TLP's FCRC error injection TX Path - fcrc_tlp
> +		6) Parity error of TSOS - parity_tsos
> +		7) Parity error on SKPOS - parity_skpos
> +		8) LCRC error injection RX Path - rx_lcrc
> +		9) ECRC error injection RX Path - rx_ecrc
> +		10) TLPs SEQ# error - tlp_err_seq
> +		11) DLLPS ACK/NAK SEQ# error - ack_nak_dllp_seq
> +		12) ACK/NAK DLLPs transmission block - ack_nak_dllp
> +		13) UpdateFC DLLPs transmission block - upd_fc_dllp
> +		14) Always transmission for NAK DLLP - nak_dllp
> +		15) Invert SYNC header - inv_sync_hdr_sym
> +		16) COM/PAD TS1 order set - com_pad_ts1
> +		17) COM/PAD TS2 order set - com_pad_ts2
> +		18) COM/FTS FTS order set - com_fts
> +		19) COM/IDL E-idle order set - com_idl
> +		20) END/EDB symbol - end_edb
> +		21) STP/SDP symbol - stp_sdp
> +		22) COM/SKP SKP order set - com_skp
> +		23) Posted TLP Header credit value control - posted_tlp_hdr
> +		24) Non-Posted TLP Header credit value control - non_post_tlp_hdr
> +		25) Completion TLP Header credit value control - cmpl_tlp_hdr
> +		26) Posted TLP Data credit value control - posted_tlp_data
> +		27) Non-Posted TLP Data credit value control - non_post_tlp_data
> +		28) Completion TLP Data credit value control - cmpl_tlp_data
> +		29) Generates duplicate TLPs - duplicate_dllp
> +		30) Generates Nullified TLPs - nullified_tlp
> +
> +		Each of the possible errors are WO attributes. Write to the attribute will
> +		prepare controller to inject the respective error in the next transmission
> +		of data. Parameter required to write will change in the following ways:
> +
> +		i) Errors 9) - 10) are sequence errors. The write command for these will be
> +
> +			echo <count> <diff> > /sys/kernel/debug/dwc_pcie_<dev>/rasdes_err_inj/<error>
> +
> +			<count>
> +				Number of errors to be injected
> +			<diff>
> +				The difference to add or subtract from natural sequence number to
> +				generate sequence error. Range (-4095 : 4095)
> +
> +		ii) Errors 23) - 28) are credit value error insertions. Write command:
> +
> +			echo <count> <diff> <vc> > /sys/kernel/debug/dwc_pcie_<dev>/rasdes_err_inj/<error>
> +
> +			<count>
> +				Number of errors to be injected
> +			<diff>
> +				The difference to add or subtract from UpdateFC credit value.
> +				Range (-4095 : 4095)
> +			<vc>
> +				Target VC number
> +
> +		iii) All other errors. Write command:
> +
> +			echo <count> > /sys/kernel/debug/dwc_pcie_<dev>/rasdes_err_inj/<error>
> +
> +			<count>
> +				Number of errors to be injected
> diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.c b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> index fe799d36fa7f..dfb0840390d3 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> @@ -17,6 +17,20 @@
>  #define PIPE_DETECT_LANE		BIT(17)
>  #define LANE_SELECT			GENMASK(3, 0)
>  
> +#define ERR_INJ0_OFF			0x34
> +#define EINJ_VAL_DIFF			GENMASK(28, 16)
> +#define EINJ_VC_NUM			GENMASK(14, 12)
> +#define EINJ_TYPE_SHIFT			8
> +#define EINJ0_TYPE			GENMASK(11, 8)
> +#define EINJ1_TYPE			BIT(8)
> +#define EINJ2_TYPE			GENMASK(9, 8)
> +#define EINJ3_TYPE			GENMASK(10, 8)
> +#define EINJ4_TYPE			GENMASK(10, 8)
> +#define EINJ5_TYPE			BIT(8)
> +#define EINJ_COUNT			GENMASK(7, 0)
> +
> +#define ERR_INJ_ENABLE_REG		0x30
> +
>  #define DWC_DEBUGFS_BUF_MAX		128
>  
>  struct dwc_pcie_vsec_id {
> @@ -55,6 +69,72 @@ struct dwc_pcie_rasdes_info {
>  	struct mutex reg_lock;
>  };
>  
> +/**
> + * struct dwc_pcie_rasdes_priv - Stores file specific private data information
> + * @pci: Reference to the dw_pcie structure
> + * @idx: Index to point to specific file related information in array of structs
> + *
> + * All debugfs files will have this struct as its private data.
> + */
> +struct dwc_pcie_rasdes_priv {
> +	struct dw_pcie *pci;
> +	int idx;
> +};
> +
> +/**
> + * struct dwc_pcie_err_inj - Store details about each error injection supported by DWC RASDES
> + * @name: Name of the error that can be injected
> + * @err_inj_group: Group number to which the error belongs to. Value can range from 0 - 5
> + * @err_inj_type: Each group can have multiple types of error
> + */
> +struct dwc_pcie_err_inj {
> +	const char *name;
> +	u32 err_inj_group;
> +	u32 err_inj_type;
> +};
> +
> +static const struct dwc_pcie_err_inj err_inj_list[] = {
> +	{"tx_lcrc", 0x0, 0x0},
> +	{"b16_crc_dllp", 0x0, 0x1},
> +	{"b16_crc_upd_fc", 0x0, 0x2},
> +	{"tx_ecrc", 0x0, 0x3},
> +	{"fcrc_tlp", 0x0, 0x4},
> +	{"parity_tsos", 0x0, 0x5},
> +	{"parity_skpos", 0x0, 0x6},
> +	{"rx_lcrc", 0x0, 0x8},
> +	{"rx_ecrc", 0x0, 0xb},
> +	{"tlp_err_seq", 0x1, 0x0},
> +	{"ack_nak_dllp_seq", 0x1, 0x1},
> +	{"ack_nak_dllp", 0x2, 0x0},
> +	{"upd_fc_dllp", 0x2, 0x1},
> +	{"nak_dllp", 0x2, 0x2},
> +	{"inv_sync_hdr_sym", 0x3, 0x0},
> +	{"com_pad_ts1", 0x3, 0x1},
> +	{"com_pad_ts2", 0x3, 0x2},
> +	{"com_fts", 0x3, 0x3},
> +	{"com_idl", 0x3, 0x4},
> +	{"end_edb", 0x3, 0x5},
> +	{"stp_sdp", 0x3, 0x6},
> +	{"com_skp", 0x3, 0x7},
> +	{"posted_tlp_hdr", 0x4, 0x0},
> +	{"non_post_tlp_hdr", 0x4, 0x1},
> +	{"cmpl_tlp_hdr", 0x4, 0x2},
> +	{"posted_tlp_data", 0x4, 0x4},
> +	{"non_post_tlp_data", 0x4, 0x5},
> +	{"cmpl_tlp_data", 0x4, 0x6},
> +	{"duplicate_dllp", 0x5, 0x0},
> +	{"nullified_tlp", 0x5, 0x1},
> +};
> +
> +static const u32 err_inj_type_mask[] = {
> +	EINJ0_TYPE,
> +	EINJ1_TYPE,
> +	EINJ2_TYPE,
> +	EINJ3_TYPE,
> +	EINJ4_TYPE,
> +	EINJ5_TYPE,
> +};
> +
>  static ssize_t lane_detect_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
>  {
>  	struct dw_pcie *pci = file->private_data;
> @@ -115,6 +195,63 @@ static ssize_t rx_valid_write(struct file *file, const char __user *buf, size_t
>  	return lane_detect_write(file, buf, count, ppos);
>  }
>  
> +static ssize_t err_inj_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
> +{
> +	struct dwc_pcie_rasdes_priv *pdata = file->private_data;
> +	struct dw_pcie *pci = pdata->pci;
> +	struct dwc_pcie_rasdes_info *rinfo = pci->debugfs->rasdes_info;
> +	u32 val, counter, vc_num, err_group, type_mask;
> +	int val_diff = 0;
> +	char *kern_buf;
> +
> +	err_group = err_inj_list[pdata->idx].err_inj_group;
> +	type_mask = err_inj_type_mask[err_group];
> +
> +	kern_buf = memdup_user_nul(buf, count);
> +	if (IS_ERR(kern_buf))
> +		return PTR_ERR(kern_buf);
> +
> +	if (err_group == 4) {
> +		val = sscanf(kern_buf, "%u %d %u", &counter, &val_diff, &vc_num);
> +		if ((val != 3) || (val_diff < -4095 || val_diff > 4095)) {
> +			kfree(kern_buf);
> +			return -EINVAL;
> +		}
> +	} else if (err_group == 1) {
> +		val = sscanf(kern_buf, "%u %d", &counter, &val_diff);
> +		if ((val != 2) || (val_diff < -4095 || val_diff > 4095)) {
> +			kfree(kern_buf);
> +			return -EINVAL;
> +		}
> +	} else {
> +		val = kstrtou32(kern_buf, 0, &counter);
> +		if (val) {
> +			kfree(kern_buf);
> +			return val;
> +		}
> +	}
> +
> +	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + ERR_INJ0_OFF + (0x4 * err_group));
> +	val &= ~(type_mask | EINJ_COUNT);
> +	val |= ((err_inj_list[pdata->idx].err_inj_type << EINJ_TYPE_SHIFT) & type_mask);
> +	val |= FIELD_PREP(EINJ_COUNT, counter);
> +
> +	if (err_group == 1 || err_group == 4) {
> +		val &= ~(EINJ_VAL_DIFF);
> +		val |= FIELD_PREP(EINJ_VAL_DIFF, val_diff);
> +	}
> +	if (err_group == 4) {
> +		val &= ~(EINJ_VC_NUM);
> +		val |= FIELD_PREP(EINJ_VC_NUM, vc_num);
> +	}
> +
> +	dw_pcie_writel_dbi(pci, rinfo->ras_cap_offset + ERR_INJ0_OFF + (0x4 * err_group), val);
> +	dw_pcie_writel_dbi(pci, rinfo->ras_cap_offset + ERR_INJ_ENABLE_REG, (0x1 << err_group));
> +
> +	kfree(kern_buf);
> +	return count;
> +}
> +
>  #define dwc_debugfs_create(name)			\
>  debugfs_create_file(#name, 0644, rasdes_debug, pci,	\
>  			&dbg_ ## name ## _fops)
> @@ -129,6 +266,11 @@ static const struct file_operations dbg_ ## name ## _fops = {	\
>  DWC_DEBUGFS_FOPS(lane_detect);
>  DWC_DEBUGFS_FOPS(rx_valid);
>  
> +static const struct file_operations dwc_pcie_err_inj_ops = {
> +	.open = simple_open,
> +	.write = err_inj_write,
> +};
> +
>  static void dwc_pcie_rasdes_debugfs_deinit(struct dw_pcie *pci)
>  {
>  	struct dwc_pcie_rasdes_info *rinfo = pci->debugfs->rasdes_info;
> @@ -138,11 +280,12 @@ static void dwc_pcie_rasdes_debugfs_deinit(struct dw_pcie *pci)
>  
>  static int dwc_pcie_rasdes_debugfs_init(struct dw_pcie *pci, struct dentry *dir)
>  {
> -	struct dentry *rasdes_debug;
> +	struct dentry *rasdes_debug, *rasdes_err_inj;
>  	struct dwc_pcie_rasdes_info *rasdes_info;
> +	struct dwc_pcie_rasdes_priv *priv_tmp;
>  	const struct dwc_pcie_vsec_id *vid;
>  	struct device *dev = pci->dev;
> -	int ras_cap;
> +	int ras_cap, i, ret;
>  
>  	for (vid = dwc_pcie_vsec_ids; vid->vendor_id; vid++) {
>  		ras_cap = dw_pcie_find_vsec_capability(pci, vid->vendor_id,
> @@ -161,6 +304,7 @@ static int dwc_pcie_rasdes_debugfs_init(struct dw_pcie *pci, struct dentry *dir)
>  
>  	/* Create subdirectories for Debug, Error injection, Statistics */
>  	rasdes_debug = debugfs_create_dir("rasdes_debug", dir);
> +	rasdes_err_inj = debugfs_create_dir("rasdes_err_inj", dir);
>  
>  	mutex_init(&rasdes_info->reg_lock);
>  	rasdes_info->ras_cap_offset = ras_cap;
> @@ -170,7 +314,24 @@ static int dwc_pcie_rasdes_debugfs_init(struct dw_pcie *pci, struct dentry *dir)
>  	dwc_debugfs_create(lane_detect);
>  	dwc_debugfs_create(rx_valid);
>  
> +	/* Create debugfs files for Error injection subdirectory */
> +	for (i = 0; i < ARRAY_SIZE(err_inj_list); i++) {
> +		priv_tmp = devm_kzalloc(dev, sizeof(*priv_tmp), GFP_KERNEL);
> +		if (!priv_tmp) {
> +			ret = -ENOMEM;
> +			goto err_deinit;
> +		}
> +
> +		priv_tmp->idx = i;
> +		priv_tmp->pci = pci;
> +		debugfs_create_file(err_inj_list[i].name, 0200, rasdes_err_inj, priv_tmp,
> +				    &dwc_pcie_err_inj_ops);
> +	}
>  	return 0;
> +
> +err_deinit:
> +	dwc_pcie_rasdes_debugfs_deinit(pci);
> +	return ret;
>  }
>  
>  void dwc_pcie_debugfs_deinit(struct dw_pcie *pci)
> -- 
> 2.17.1
> 

-- 
மணிவண்ணன் சதாசிவம்

