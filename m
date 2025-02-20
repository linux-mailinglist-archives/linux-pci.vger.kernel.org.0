Return-Path: <linux-pci+bounces-21870-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 171C1A3D148
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 07:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA72E3B23D2
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 06:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34761B4254;
	Thu, 20 Feb 2025 06:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W82X0e/q"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B423C130E58
	for <linux-pci@vger.kernel.org>; Thu, 20 Feb 2025 06:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740032244; cv=none; b=ChI/8iMH2NuMpTes3TnKFePxhoMCFWFYJ5kcPLWFxevODeCUaYd/KtIPrCUBYhpTA8OD1fdlBCRjKW6lNLU+pW2A1tqUjjEWdxcpNM9EjJYiCtJqwY7rTajIeVSYTLpBWkJUBTXaIRumWoK/ASf0kn8DCDYPB7YUPylojnokXdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740032244; c=relaxed/simple;
	bh=loAGvE1LogVZow+OeMmNWjVUuuN1XZNsVA/EPoAAjWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dmT+La3PFhpUtAYaCzP4I3/vMknME1iZE/7Ef3B9ZHZTm5ZmSOKZb2KoxRXb/uNPg9Sdxt5J+/mNLe6HHZsMomhc8ZmjLQ71z6KfPoX/6L7wdPiZL5eGjPi3+ERpcG+LAmmS2IZ+aBxab8L6QsFA7aa3M2rK3KJdZikP5rVgc7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W82X0e/q; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2fa8ada6662so1144046a91.1
        for <linux-pci@vger.kernel.org>; Wed, 19 Feb 2025 22:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740032242; x=1740637042; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gJ+u5CFaxNoI8PCqD+CDfdqmiUgZuHbBRfRyiTK8C64=;
        b=W82X0e/qvRGvk6cDvqlczyyDLKlOJUBTIpYOCaapKz7uc7S3wOszGx7ClLrPOTQ81V
         7mBiqW5+0fbVvok1UYYRsRTnTirdPruF7z3TDPXC8cFXxl9hq7Wd6ewTlXCX2HYS6+l2
         VtfWFmsmKRwFzgaJib4+KBL0eoojehXmax0kjzTKUnaOx5nQk2Jeu2SUEOLhbq6o3eKA
         ejZplqarFVfyl2d+y1qikBhhADWHPh4gqoL4ZPrlSy3l3XVoTovjeg3Ned4hmiCXNroc
         dvS5fNZtMoHtZjZSccykIh7lw4G1kWGqEzRskrL7Ed/szM7uzAk8GjuBZkPQCJXdEc3R
         0onQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740032242; x=1740637042;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gJ+u5CFaxNoI8PCqD+CDfdqmiUgZuHbBRfRyiTK8C64=;
        b=so0yhzjnOxyypfnFc/O9syYGw5AfY6TaXEOL3hwHK2lJ3UWD6blOzMoQK0LnNiJ+9N
         3MMNGTKnRkjxHtWihRsjVYxKLzJGgVjHDrIQi4FzrSouubFtoUcmuXaYiAWancZpmqSP
         6VjkkCqLmoo7Ef09kLqPv3WyFKAYdkjnGxa8EuqTC50IuhsEZX4KSugfbEL3x+E6Me1V
         mG3yyjntalozBNLe0Edk17rzHGPEr01rOLdAAFtiPQnoMZ5JqcprcLs7P9Ohj9NowxGL
         eR2EvF9dC/IhgY1pHMEhIYNOkgCqxhzjOemEc+oo2bwCfJ1rn36qEzWPjP9wQ31Zhalb
         seMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsC1nK/K2wfWcxsg5/QIKPIP4hv8RzradlWVmeMIvqyaycVyer3M0iq0BVyXCYO9RqdTOVPU4xnNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeC+Y7mtZZ5gNXWbdRCJVeM1V9J0FLnmidCWXz0su6BYz7nMLA
	vqDmIQ7qoYfTt6pNGgI/U8SOBdzbtOh/kjxZ0Zl1QHB7eC02v9cXABtpuwexVw==
X-Gm-Gg: ASbGncsg/Vu+8tBN5lY2fHWQT2gT8ST+IjQZMfdKb9RX+ZhBQyW78tl33Mt7ipABfD8
	y2wJrrnrIRJ0ZL5GrOz+TaRSeglbVtF81Gj+AmgNOAXGeOwkH/FvpwwnqybAhidW5I+tfBy/Nmf
	ioMDz3jA9qpRX8v4Nakwk0RzPIgjvmVAYTBXc9cMKLK3WpNAS1SaughdeJ/s4OLnrEg9OfcKmNo
	TM/9QrnDfGY9+UI0nCdBDPI0bMS3W9vXdMQi/nvjinneReyMUbUah8vOc4SEcy07G7jn8wb9/KM
	aMZbs/I5txL+esspcyYEdqjR1w==
X-Google-Smtp-Source: AGHT+IFoXSLUnVw+J6T/mfE/SAmkl8aSxZJChVH8oTXgrNJbmBGohVtcI8iJzgZMuZJVTQ36qlZCkw==
X-Received: by 2002:a17:90b:1b4b:b0:2ee:b26c:10a0 with SMTP id 98e67ed59e1d1-2fc410404b0mr34389488a91.24.1740032241944;
        Wed, 19 Feb 2025 22:17:21 -0800 (PST)
Received: from thinkpad ([120.60.70.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fbf999b602sm15182492a91.35.2025.02.19.22.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 22:17:21 -0800 (PST)
Date: Thu, 20 Feb 2025 11:47:14 +0530
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
Subject: Re: [PATCH v6 4/4] Add debugfs based statistical counter support in
 DWC
Message-ID: <20250220061714.kbadyamh4euqub6g@thinkpad>
References: <20250214105007.97582-1-shradha.t@samsung.com>
 <CGME20250214105352epcas5p17fa94017786a363f4381c9b11ae43e24@epcas5p1.samsung.com>
 <20250214105007.97582-5-shradha.t@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250214105007.97582-5-shradha.t@samsung.com>

On Fri, Feb 14, 2025 at 04:20:07PM +0530, Shradha Todi wrote:
> Add support to provide statistical counter interface to userspace. This set
> of debug registers are part of the RASDES feature present in DesignWare
> PCIe controllers.
> 
> Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> ---
>  Documentation/ABI/testing/debugfs-dwc-pcie    |  61 +++++
>  .../controller/dwc/pcie-designware-debugfs.c  | 229 +++++++++++++++++-
>  2 files changed, 289 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/debugfs-dwc-pcie b/Documentation/ABI/testing/debugfs-dwc-pcie
> index 9eae0ab1dbea..01aa9d3a00c6 100644
> --- a/Documentation/ABI/testing/debugfs-dwc-pcie
> +++ b/Documentation/ABI/testing/debugfs-dwc-pcie
> @@ -81,3 +81,64 @@ Description:	rasdes_err_inj is the directory which can be used to inject errors
>  
>  			<count>
>  				Number of errors to be injected
> +
> +What:		/sys/kernel/debug/dwc_pcie_<dev>/rasdes_event_counters/<event>/counter_enable
> +Date:		Feburary 2025
> +Contact:	Shradha Todi <shradha.t@samsung.com>
> +Description:	rasdes_event_counters is the directory which can be used to collect
> +		statistical data about the number of times a certain event has occurred
> +		in the controller. The list of possible events are:
> +
> +		1) EBUF Overflow
> +		2) EBUF Underrun
> +		3) Decode Error
> +		4) Running Disparity Error
> +		5) SKP OS Parity Error
> +		6) SYNC Header Error
> +		7) Rx Valid De-assertion
> +		8) CTL SKP OS Parity Error
> +		9) 1st Retimer Parity Error
> +		10) 2nd Retimer Parity Error
> +		11) Margin CRC and Parity Error
> +		12) Detect EI Infer
> +		13) Receiver Error
> +		14) RX Recovery Req
> +		15) N_FTS Timeout
> +		16) Framing Error
> +		17) Deskew Error
> +		18) Framing Error In L0
> +		19) Deskew Uncompleted Error
> +		20) Bad TLP
> +		21) LCRC Error
> +		22) Bad DLLP
> +		23) Replay Number Rollover
> +		24) Replay Timeout
> +		25) Rx Nak DLLP
> +		26) Tx Nak DLLP
> +		27) Retry TLP
> +		28) FC Timeout
> +		29) Poisoned TLP
> +		30) ECRC Error
> +		31) Unsupported Request
> +		32) Completer Abort
> +		33) Completion Timeout
> +		34) EBUF SKP Add
> +		35) EBUF SKP Del
> +
> +		counter_enable is RW. Write 1 to enable the event counter and write 0 to

Please use (RW) pattern at the start as you did for other attributes.

> +		disable the event counter. Read will return whether the counter is currently
> +		enabled	or disabled. Counter is disabled by default.
> +
> +What:		/sys/kernel/debug/dwc_pcie_<dev>/rasdes_event_counters/<event>/counter_value
> +Date:		Feburary 2025
> +Contact:	Shradha Todi <shradha.t@samsung.com>
> +Description:	(RO) Read will return the current value of the event counter. To reset the counter,
> +		counter should be disabled and enabled back using the 'counter_enable' attribute.
> +
> +What:		/sys/kernel/debug/dwc_pcie_<dev>/rasdes_event_counters/<event>/lane_select
> +Date:		Feburary 2025
> +Contact:	Shradha Todi <shradha.t@samsung.com>
> +Description:	(RW) Some lanes in the event list are lane specific events. These include
> +		events 1) - 11) and 34) - 35).
> +		Write lane number for which counter needs to be enabled/disabled/dumped.
> +		Read will return the current selected lane number. Lane0 is selected by default.
> diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.c b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> index dfb0840390d3..2087185a1968 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> @@ -31,6 +31,17 @@
>  
>  #define ERR_INJ_ENABLE_REG		0x30
>  
> +#define RAS_DES_EVENT_COUNTER_DATA_REG	0xc
> +
> +#define RAS_DES_EVENT_COUNTER_CTRL_REG	0x8
> +#define EVENT_COUNTER_GROUP_SELECT	GENMASK(27, 24)
> +#define EVENT_COUNTER_EVENT_SELECT	GENMASK(23, 16)
> +#define EVENT_COUNTER_LANE_SELECT	GENMASK(11, 8)
> +#define EVENT_COUNTER_STATUS		BIT(7)
> +#define EVENT_COUNTER_ENABLE		GENMASK(4, 2)
> +#define PER_EVENT_ON			0x3
> +#define PER_EVENT_OFF			0x1
> +
>  #define DWC_DEBUGFS_BUF_MAX		128
>  
>  struct dwc_pcie_vsec_id {
> @@ -135,6 +146,61 @@ static const u32 err_inj_type_mask[] = {
>  	EINJ5_TYPE,
>  };
>  
> +/**
> + * struct dwc_pcie_event_counter - Store details about each event counter supported in DWC RASDES
> + * @name: Name of the error counter
> + * @group_no: Group number that the event belongs to. Value ranges from 0 - 4
> + * @event_no: Event number of the particular event. Value ranges from -
> + *		Group 0: 0 - 10
> + *		Group 1: 5 - 13
> + *		Group 2: 0 - 7
> + *		Group 3: 0 - 5
> + *		Group 4: 0 - 1
> + */
> +struct dwc_pcie_event_counter {
> +	const char *name;
> +	u32 group_no;
> +	u32 event_no;
> +};
> +
> +static const struct dwc_pcie_event_counter event_list[] = {
> +	{"ebuf_overflow", 0x0, 0x0},
> +	{"ebuf_underrun", 0x0, 0x1},
> +	{"decode_err", 0x0, 0x2},
> +	{"running_disparity_err", 0x0, 0x3},
> +	{"skp_os_parity_err", 0x0, 0x4},
> +	{"sync_header_err", 0x0, 0x5},
> +	{"rx_valid_deassertion", 0x0, 0x6},
> +	{"ctl_skp_os_parity_err", 0x0, 0x7},
> +	{"retimer_parity_err_1st", 0x0, 0x8},
> +	{"retimer_parity_err_2nd", 0x0, 0x9},
> +	{"margin_crc_parity_err", 0x0, 0xA},
> +	{"detect_ei_infer", 0x1, 0x5},
> +	{"receiver_err", 0x1, 0x6},
> +	{"rx_recovery_req", 0x1, 0x7},
> +	{"n_fts_timeout", 0x1, 0x8},
> +	{"framing_err", 0x1, 0x9},
> +	{"deskew_err", 0x1, 0xa},
> +	{"framing_err_in_l0", 0x1, 0xc},
> +	{"deskew_uncompleted_err", 0x1, 0xd},
> +	{"bad_tlp", 0x2, 0x0},
> +	{"lcrc_err", 0x2, 0x1},
> +	{"bad_dllp", 0x2, 0x2},
> +	{"replay_num_rollover", 0x2, 0x3},
> +	{"replay_timeout", 0x2, 0x4},
> +	{"rx_nak_dllp", 0x2, 0x5},
> +	{"tx_nak_dllp", 0x2, 0x6},
> +	{"retry_tlp", 0x2, 0x7},
> +	{"fc_timeout", 0x3, 0x0},
> +	{"poisoned_tlp", 0x3, 0x1},
> +	{"ecrc_error", 0x3, 0x2},
> +	{"unsupported_request", 0x3, 0x3},
> +	{"completer_abort", 0x3, 0x4},
> +	{"completion_timeout", 0x3, 0x5},
> +	{"ebuf_skp_add", 0x4, 0x0},
> +	{"ebuf_skp_del", 0x4, 0x1},
> +};
> +
>  static ssize_t lane_detect_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
>  {
>  	struct dw_pcie *pci = file->private_data;
> @@ -252,6 +318,127 @@ static ssize_t err_inj_write(struct file *file, const char __user *buf, size_t c
>  	return count;
>  }
>  
> +static void set_event_number(struct dwc_pcie_rasdes_priv *pdata, struct dw_pcie *pci,
> +			     struct dwc_pcie_rasdes_info *rinfo)
> +{
> +	u32 val;
> +
> +	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG);
> +	val &= ~EVENT_COUNTER_ENABLE;
> +	val &= ~(EVENT_COUNTER_GROUP_SELECT | EVENT_COUNTER_EVENT_SELECT);
> +	val |= FIELD_PREP(EVENT_COUNTER_GROUP_SELECT, event_list[pdata->idx].group_no);
> +	val |= FIELD_PREP(EVENT_COUNTER_EVENT_SELECT, event_list[pdata->idx].event_no);
> +	dw_pcie_writel_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG, val);
> +}
> +
> +static ssize_t counter_enable_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
> +{
> +	struct dwc_pcie_rasdes_priv *pdata = file->private_data;
> +	struct dw_pcie *pci = pdata->pci;
> +	struct dwc_pcie_rasdes_info *rinfo = pci->debugfs->rasdes_info;
> +	char debugfs_buf[DWC_DEBUGFS_BUF_MAX];
> +	ssize_t off = 0;
> +	u32 val;
> +
> +	mutex_lock(&rinfo->reg_lock);
> +	set_event_number(pdata, pci, rinfo);
> +	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG);
> +	mutex_unlock(&rinfo->reg_lock);
> +	val = FIELD_GET(EVENT_COUNTER_STATUS, val);
> +	if (val)
> +		off += scnprintf(debugfs_buf, DWC_DEBUGFS_BUF_MAX - off, "Counter Enabled\n");

Here also, adding 'off' doesn't make sense.

> +	else
> +		off += scnprintf(debugfs_buf, DWC_DEBUGFS_BUF_MAX - off, "Counter Disabled\n");
> +
> +	return simple_read_from_buffer(buf, count, ppos, debugfs_buf, off);
> +}
> +
> +static ssize_t counter_enable_write(struct file *file, const char __user *buf,
> +				    size_t count, loff_t *ppos)
> +{
> +	struct dwc_pcie_rasdes_priv *pdata = file->private_data;
> +	struct dw_pcie *pci = pdata->pci;
> +	struct dwc_pcie_rasdes_info *rinfo = pci->debugfs->rasdes_info;
> +	u32 val, enable;
> +
> +	val = kstrtou32_from_user(buf, count, 0, &enable);
> +	if (val)
> +		return val;
> +
> +	mutex_lock(&rinfo->reg_lock);
> +	set_event_number(pdata, pci, rinfo);
> +	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG);
> +	if (enable)
> +		val |= FIELD_PREP(EVENT_COUNTER_ENABLE, PER_EVENT_ON);
> +	else
> +		val |= FIELD_PREP(EVENT_COUNTER_ENABLE, PER_EVENT_OFF);
> +
> +	dw_pcie_writel_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG, val);
> +	mutex_unlock(&rinfo->reg_lock);
> +
> +	return count;
> +}
> +
> +static ssize_t counter_lane_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
> +{
> +	struct dwc_pcie_rasdes_priv *pdata = file->private_data;
> +	struct dw_pcie *pci = pdata->pci;
> +	struct dwc_pcie_rasdes_info *rinfo = pci->debugfs->rasdes_info;
> +	char debugfs_buf[DWC_DEBUGFS_BUF_MAX];
> +	ssize_t off = 0;
> +	u32 val;
> +
> +	mutex_lock(&rinfo->reg_lock);
> +	set_event_number(pdata, pci, rinfo);
> +	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG);
> +	mutex_unlock(&rinfo->reg_lock);
> +	val = FIELD_GET(EVENT_COUNTER_LANE_SELECT, val);
> +	off += scnprintf(debugfs_buf, DWC_DEBUGFS_BUF_MAX - off, "Lane: %d\n", val);

Same here.

> +
> +	return simple_read_from_buffer(buf, count, ppos, debugfs_buf, off);
> +}
> +
> +static ssize_t counter_lane_write(struct file *file, const char __user *buf,
> +				  size_t count, loff_t *ppos)
> +{
> +	struct dwc_pcie_rasdes_priv *pdata = file->private_data;
> +	struct dw_pcie *pci = pdata->pci;
> +	struct dwc_pcie_rasdes_info *rinfo = pci->debugfs->rasdes_info;
> +	u32 val, lane;
> +
> +	val = kstrtou32_from_user(buf, count, 0, &lane);
> +	if (val)
> +		return val;
> +
> +	mutex_lock(&rinfo->reg_lock);
> +	set_event_number(pdata, pci, rinfo);
> +	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG);
> +	val &= ~(EVENT_COUNTER_LANE_SELECT);
> +	val |= FIELD_PREP(EVENT_COUNTER_LANE_SELECT, lane);
> +	dw_pcie_writel_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG, val);
> +	mutex_unlock(&rinfo->reg_lock);
> +
> +	return count;
> +}
> +
> +static ssize_t counter_value_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
> +{
> +	struct dwc_pcie_rasdes_priv *pdata = file->private_data;
> +	struct dw_pcie *pci = pdata->pci;
> +	struct dwc_pcie_rasdes_info *rinfo = pci->debugfs->rasdes_info;
> +	char debugfs_buf[DWC_DEBUGFS_BUF_MAX];
> +	ssize_t off = 0;
> +	u32 val;
> +
> +	mutex_lock(&rinfo->reg_lock);
> +	set_event_number(pdata, pci, rinfo);
> +	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_DATA_REG);
> +	mutex_unlock(&rinfo->reg_lock);
> +	off += scnprintf(debugfs_buf, DWC_DEBUGFS_BUF_MAX - off, "Counter value: %d\n", val);

Here also.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

