Return-Path: <linux-pci+bounces-22127-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C533BA40D83
	for <lists+linux-pci@lfdr.de>; Sun, 23 Feb 2025 09:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 141D47AA07D
	for <lists+linux-pci@lfdr.de>; Sun, 23 Feb 2025 08:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A631FCFEE;
	Sun, 23 Feb 2025 08:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mZZpN81q"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BE71FC0EE
	for <linux-pci@vger.kernel.org>; Sun, 23 Feb 2025 08:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740300889; cv=none; b=O13HYm8xlR3jaIehPKjfNfN8LI0tW1VSkUD1sNlijvXdgJ3jZ+uwM6Jrwkb0LAV1eAZzQb6NGWqtK6+3NDKxwoGphSGchi7rTyg3MBe4+0Xbv9LDSi3xznF4oa+g9cfykf/ATV0jJdNQSFYMEnMvnwS5jiZki0DlKBaKfO03/Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740300889; c=relaxed/simple;
	bh=GMR3wHAQ7OLAK+0WIGs23NaDK/GUoW4XVGEi7BLl23E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LtFyoY3FKlsEF9cfb2ygr9mQ0o3uJAAroDjxXvuI9EC17lNOyNzXtL6I0LjUNOfQNfmJM/62zQpNc6u/D6l1RQHy6jvK0p1gVH7YnSnsNHXx4hTMykvlgdbHbnykGYUEMpu+86Oh2DMt4Yh1E4O8H5zz8bKGgClREk7PK9KeDno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mZZpN81q; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2fbffe0254fso7116212a91.3
        for <linux-pci@vger.kernel.org>; Sun, 23 Feb 2025 00:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740300887; x=1740905687; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qhtfFGtrm/r/EdIHI4NWAw5GAp/ALVl3MX5Mqx7Mu6w=;
        b=mZZpN81q4EwmaNxbyQ76GUdXpvL0vVkpzq2qdDqCEZrVTkdQw4vziVlWHLXXhlc0gx
         yJ7MK5S2zYwJoo3Az2QCeNp+YsagLtcYlG0ns1utCLOJVTaf7KLXIZPSaK4imimZS/AE
         FbcEh+tM3qAIdfelXCiAStk+SKTcWBTdpdhG48/DKmUv3E0IZX5S4DkeyQ5rtfTU61Wa
         fU0McnMyCLZl5J/QVrX/xbAfzVdBT5V/HnWlwo3WkiwG1uT36QOo1tw6KxVoExJKIPFI
         Bb+hakIMfFt2NrFmpVfx8WXAe1Ja/tO0iL9U3/awXqRfyw7e9+CL8bMr1UOfgLnmdBHp
         mD/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740300887; x=1740905687;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qhtfFGtrm/r/EdIHI4NWAw5GAp/ALVl3MX5Mqx7Mu6w=;
        b=aSPuwynU8TAyxif5dhcWNRHVWa/9zzkIgFpxzM0zR3tFHSnqJMJmQvJ86UqrwIBK9R
         h58ZTXpHnFynoinzCTFcTIUPmoECmpyGbiecPRigx429usHYCqSOn4QEW9pd4HyjW22A
         oAW4GZp6jo+wbLhiSZSMRnw4Fpr3OG0bA4fCQcl2FskdQ1axt+dkmiTSzAPJEZo+I3zn
         dymBOZXoNv0JpAXySjiooPl5jkPZYcxEMQtFTCZO2NQqcFr9jE+j1mzC8Os5qe0xGKS8
         TgyOjm4S40ySgPXoPv0Tt6UHSl53iUJqyKiWDJ5EsjTQ878SRs4i34h0EfaU1V3ZgFNm
         AHcw==
X-Forwarded-Encrypted: i=1; AJvYcCV9vlrvlQlPbK1HvcJYLhznKnCyF1zJZIKwUaj6LzL7lsH2e5QgPrfQuwWXErK+SvOD2Nv7ehk/MDI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqkU8ySFs9nKEpCxx0BEScbxv/2jszRt1aDM1BZjQgiKRFi1wT
	AbdDqr7ko7QxllgEQnjaTBvwTT9WwoNTV/lsvcbyHGEY6ngc3MbcGQW/8sVGgw==
X-Gm-Gg: ASbGncu5dJ3EPdgDuj8Ybls1bjnxD3wYy0eB59VGfVJvbQJRjnBoyIXvu+AgADNxJ2E
	S+SnUXo6hQSraiIeOnzq7EYWX2gOfheO8shiLwxdeGGXp6PH0fA6ojBjSgyw80lpT5o8YvQ3bdy
	+Pd6yRvOBMVcc4dYizkO3Ot+rfzoQ4COjTJMX04Czvuj9yXSsyNEqgiiqIIZ3dmU5+INJXD8kSY
	MAKFceMi1jv9e/mRz25cBvg4q7ojT9GlEXCs0pofqQvsJsXierU5GYPSfCF7Mn68zSVdhNKWHRv
	LgXHBxQTlHJAvEW8s8kC8d5KxA13kcLT5mfVgDE=
X-Google-Smtp-Source: AGHT+IEccR+ch+6Bpf4ueioZ0PgXfplXUF7AWlKJxIQS4x0ObG/yscvNDoElJGtPW6a87MTyMeTVtQ==
X-Received: by 2002:a17:90b:5106:b0:2f9:9ddd:68b9 with SMTP id 98e67ed59e1d1-2fce7b1da4amr13812767a91.26.1740300887190;
        Sun, 23 Feb 2025 00:54:47 -0800 (PST)
Received: from thinkpad ([220.158.156.216])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fcbaaf9785sm6461472a91.1.2025.02.23.00.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 00:54:46 -0800 (PST)
Date: Sun, 23 Feb 2025 14:24:39 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Shradha Todi <shradha.t@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, bhelgaas@google.com,
	jingoohan1@gmail.com, Jonathan.Cameron@Huawei.com,
	fan.ni@samsung.com, nifan.cxl@gmail.com, a.manzanares@samsung.com,
	pankaj.dubey@samsung.com, cassel@kernel.org, 18255117159@163.com,
	xueshuai@linux.alibaba.com, renyu.zj@linux.alibaba.com,
	will@kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH v7 5/5] Add debugfs based statistical counter support in
 DWC
Message-ID: <20250223085439.esnpificf3xxih56@thinkpad>
References: <20250221131548.59616-1-shradha.t@samsung.com>
 <CGME20250221132043epcas5p27fde98558b13b3311cdc467e8f246380@epcas5p2.samsung.com>
 <20250221131548.59616-6-shradha.t@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250221131548.59616-6-shradha.t@samsung.com>

On Fri, Feb 21, 2025 at 06:45:48PM +0530, Shradha Todi wrote:
> Add support to provide statistical counter interface to userspace. This set
> of debug registers are part of the RASDES feature present in DesignWare
> PCIe controllers.
> 
> Signed-off-by: Shradha Todi <shradha.t@samsung.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  Documentation/ABI/testing/debugfs-dwc-pcie    |  61 +++++
>  .../controller/dwc/pcie-designware-debugfs.c  | 229 +++++++++++++++++-
>  2 files changed, 289 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/debugfs-dwc-pcie b/Documentation/ABI/testing/debugfs-dwc-pcie
> index 6ee0897fe753..650a89b0511e 100644
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
> +		(RW) Write 1 to enable the event counter and write 0 to disable the event counter.
> +		Read will return whether the counter is currently enabled or disabled. Counter is
> +		disabled by default.
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
> index b7260edd2336..dca1e9999113 100644
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
>  /**
> @@ -113,6 +124,61 @@ static const u32 err_inj_type_mask[] = {
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
> @@ -230,6 +296,127 @@ static ssize_t err_inj_write(struct file *file, const char __user *buf, size_t c
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
> +	ssize_t pos;
> +	u32 val;
> +
> +	mutex_lock(&rinfo->reg_event_lock);
> +	set_event_number(pdata, pci, rinfo);
> +	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG);
> +	mutex_unlock(&rinfo->reg_event_lock);
> +	val = FIELD_GET(EVENT_COUNTER_STATUS, val);
> +	if (val)
> +		pos = scnprintf(debugfs_buf, DWC_DEBUGFS_BUF_MAX, "Counter Enabled\n");
> +	else
> +		pos = scnprintf(debugfs_buf, DWC_DEBUGFS_BUF_MAX, "Counter Disabled\n");
> +
> +	return simple_read_from_buffer(buf, count, ppos, debugfs_buf, pos);
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
> +	mutex_lock(&rinfo->reg_event_lock);
> +	set_event_number(pdata, pci, rinfo);
> +	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG);
> +	if (enable)
> +		val |= FIELD_PREP(EVENT_COUNTER_ENABLE, PER_EVENT_ON);
> +	else
> +		val |= FIELD_PREP(EVENT_COUNTER_ENABLE, PER_EVENT_OFF);
> +
> +	dw_pcie_writel_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG, val);
> +	mutex_unlock(&rinfo->reg_event_lock);
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
> +	ssize_t pos;
> +	u32 val;
> +
> +	mutex_lock(&rinfo->reg_event_lock);
> +	set_event_number(pdata, pci, rinfo);
> +	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG);
> +	mutex_unlock(&rinfo->reg_event_lock);
> +	val = FIELD_GET(EVENT_COUNTER_LANE_SELECT, val);
> +	pos = scnprintf(debugfs_buf, DWC_DEBUGFS_BUF_MAX, "Lane: %d\n", val);
> +
> +	return simple_read_from_buffer(buf, count, ppos, debugfs_buf, pos);
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
> +	mutex_lock(&rinfo->reg_event_lock);
> +	set_event_number(pdata, pci, rinfo);
> +	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG);
> +	val &= ~(EVENT_COUNTER_LANE_SELECT);
> +	val |= FIELD_PREP(EVENT_COUNTER_LANE_SELECT, lane);
> +	dw_pcie_writel_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG, val);
> +	mutex_unlock(&rinfo->reg_event_lock);
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
> +	ssize_t pos;
> +	u32 val;
> +
> +	mutex_lock(&rinfo->reg_event_lock);
> +	set_event_number(pdata, pci, rinfo);
> +	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_DATA_REG);
> +	mutex_unlock(&rinfo->reg_event_lock);
> +	pos = scnprintf(debugfs_buf, DWC_DEBUGFS_BUF_MAX, "Counter value: %d\n", val);
> +
> +	return simple_read_from_buffer(buf, count, ppos, debugfs_buf, pos);
> +}
> +
>  #define dwc_debugfs_create(name)			\
>  debugfs_create_file(#name, 0644, rasdes_debug, pci,	\
>  			&dbg_ ## name ## _fops)
> @@ -249,6 +436,23 @@ static const struct file_operations dwc_pcie_err_inj_ops = {
>  	.write = err_inj_write,
>  };
>  
> +static const struct file_operations dwc_pcie_counter_enable_ops = {
> +	.open = simple_open,
> +	.read = counter_enable_read,
> +	.write = counter_enable_write,
> +};
> +
> +static const struct file_operations dwc_pcie_counter_lane_ops = {
> +	.open = simple_open,
> +	.read = counter_lane_read,
> +	.write = counter_lane_write,
> +};
> +
> +static const struct file_operations dwc_pcie_counter_value_ops = {
> +	.open = simple_open,
> +	.read = counter_value_read,
> +};
> +
>  static void dwc_pcie_rasdes_debugfs_deinit(struct dw_pcie *pci)
>  {
>  	struct dwc_pcie_rasdes_info *rinfo = pci->debugfs->rasdes_info;
> @@ -258,7 +462,7 @@ static void dwc_pcie_rasdes_debugfs_deinit(struct dw_pcie *pci)
>  
>  static int dwc_pcie_rasdes_debugfs_init(struct dw_pcie *pci, struct dentry *dir)
>  {
> -	struct dentry *rasdes_debug, *rasdes_err_inj;
> +	struct dentry *rasdes_debug, *rasdes_err_inj, *rasdes_event_counter, *rasdes_events;
>  	struct dwc_pcie_rasdes_info *rasdes_info;
>  	struct dwc_pcie_rasdes_priv *priv_tmp;
>  	struct device *dev = pci->dev;
> @@ -277,6 +481,7 @@ static int dwc_pcie_rasdes_debugfs_init(struct dw_pcie *pci, struct dentry *dir)
>  	/* Create subdirectories for Debug, Error injection, Statistics */
>  	rasdes_debug = debugfs_create_dir("rasdes_debug", dir);
>  	rasdes_err_inj = debugfs_create_dir("rasdes_err_inj", dir);
> +	rasdes_event_counter = debugfs_create_dir("rasdes_event_counter", dir);
>  
>  	mutex_init(&rasdes_info->reg_event_lock);
>  	rasdes_info->ras_cap_offset = ras_cap;
> @@ -299,6 +504,28 @@ static int dwc_pcie_rasdes_debugfs_init(struct dw_pcie *pci, struct dentry *dir)
>  		debugfs_create_file(err_inj_list[i].name, 0200, rasdes_err_inj, priv_tmp,
>  				    &dwc_pcie_err_inj_ops);
>  	}
> +
> +	/* Create debugfs files for Statistical counter subdirectory */
> +	for (i = 0; i < ARRAY_SIZE(event_list); i++) {
> +		priv_tmp = devm_kzalloc(dev, sizeof(*priv_tmp), GFP_KERNEL);
> +		if (!priv_tmp) {
> +			ret = -ENOMEM;
> +			goto err_deinit;
> +		}
> +
> +		priv_tmp->idx = i;
> +		priv_tmp->pci = pci;
> +		rasdes_events = debugfs_create_dir(event_list[i].name, rasdes_event_counter);
> +		if (event_list[i].group_no == 0 || event_list[i].group_no == 4) {
> +			debugfs_create_file("lane_select", 0644, rasdes_events,
> +					    priv_tmp, &dwc_pcie_counter_lane_ops);
> +		}
> +		debugfs_create_file("counter_value", 0444, rasdes_events, priv_tmp,
> +				    &dwc_pcie_counter_value_ops);
> +		debugfs_create_file("counter_enable", 0644, rasdes_events, priv_tmp,
> +				    &dwc_pcie_counter_enable_ops);
> +	}
> +
>  	return 0;
>  
>  err_deinit:
> -- 
> 2.17.1
> 

-- 
மணிவண்ணன் சதாசிவம்

