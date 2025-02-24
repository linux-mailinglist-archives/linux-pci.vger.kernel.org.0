Return-Path: <linux-pci+bounces-22142-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC92A414C6
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 06:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E8C016E7E7
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 05:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FE14A1D;
	Mon, 24 Feb 2025 05:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tQsv+qk0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579E07FBA2
	for <linux-pci@vger.kernel.org>; Mon, 24 Feb 2025 05:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740375278; cv=none; b=PbHKQ4HZCJZ7YfkFWuZvoPbDXOshQRU5STeOaoNtfOuYVEAWRHtJXeGpePW3Dncff82l21HNAsquGkmEBfankKnEyKxBY/5ShF8GvCAG8BkkI9i4tAM8qNJy23P9vSpb3m5d9il14Q0GNUc1BkvieALu2BvuHRe8+TtL/RKp4Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740375278; c=relaxed/simple;
	bh=jBaqHGDAg8bBa+vShvnVRxtbiqFKz1i46zbQ79fBeFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=artRyn5jsFcQPkbcRh3NiUfT4pJv4ZdRqy4Jhg/U2UF+BwBPZ8PYGYTnD4sVCnoWh+SJ7SzRF4k/Ds3WHqPqbO4rEHEbTbDE0mUSx8u+xT29y1jA0NunPbk/gkWlz3nwWZHx6ZW5FtiXmORunZsKypkSQ0tpTdAK+ottY4SCH1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tQsv+qk0; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2fbfa8c73a6so8049740a91.2
        for <linux-pci@vger.kernel.org>; Sun, 23 Feb 2025 21:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740375275; x=1740980075; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=43ga30Eg/2LYLuOZ6SqxZh5pp6MB94AP6T17p8FlCUE=;
        b=tQsv+qk0kfx/rWpyqlC/LE0qKTHgLcOktPg8wBhXKD81cAZlMJRtcnGjdkPX5D3+6J
         l9dd0YedK7vdEjUuOrzqPmwFuhYHHSO2nbh7Oy77IwOC9Q4YquKESibEsUxc/aqbQHNu
         y0IXIvEnpZXmtnciU9bZXoMkomA5Z83Ok/twMpZzi+sn48xvrEu9Y1nFz4dQTZtmnD7H
         FC/Wqi5UVMoP2zBlo+eLpy6LaxFvE+0puf/+HvGpE0Fhpy5aTxoaaIqImv/9gqK8s/ZR
         gWxI96UU+guNBe5TBd2WPk7jzraRtiZUCtnkhQHCItw67eNe38Jn3Rc7B5g33XORhGPc
         GP2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740375275; x=1740980075;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=43ga30Eg/2LYLuOZ6SqxZh5pp6MB94AP6T17p8FlCUE=;
        b=MNEAkFx+W44eZtRBiTeHvD1e8jMXkG1I5mI9PEeU5YqZ127GfsVLtqrWtPu7kboESH
         kPTs8if2gzdPAaYdK5BgetXYFDzCdjc/8j5cr1btq4tVGs8t2znpLxniZq3q36rT9Ane
         dN3W1RABjUjTtOxGE3k5lU2taNxvXWPR0EckWMK0e5dqEqLadlqR+LkWBh59JOGRFGCq
         hpFzMalJ0ovT8JWqTuIQ+mGF/LY1C99GyJnnMXGVdyMMPdwE6mf8GNAu82cqiR6FzWzb
         lvAk2OmtG1ZiJamE4/JBJUsq1M0AoDMSJvoyuK4dJMrdUoIeF6GZdMVhJIohBn0hYcLF
         FzUg==
X-Forwarded-Encrypted: i=1; AJvYcCWiQrF1k6/1PxhRC3V6A1DA1QIejfU9XS5gDIYQ3aFVSft7kypSsHgWaM8SlrwGSDThHrpkjI9VShY=@vger.kernel.org
X-Gm-Message-State: AOJu0YztDoP5BQORciUg2Kzat2K5xemapdGt4i4ZTlguKO/HoiGH1+Pw
	Pd0fFkKG+M07oVFIRMoDFI4n6y3GTqHNITIjxUsdMPCfoe3nBcicdExg+KPfSg==
X-Gm-Gg: ASbGnctvahUpZvxcy1V3j2x8iIjwjbfjWOXFr9Q7Vl84LUoxjwMV1Ib7rz2mr2I2sCd
	JE5KKA5Y8IMlECCLazF+O0ugbQWcH2mTpIpxO3MaZqQzgKZAcC8oja/SwzeQhLZWcWe6PpTJQLs
	1O3SLKbVaBLEXdmFfTwKsseBxuH7NAUx/AdQVIs1xWoavntJBDR0fqBbuJo35ZlHHyKCjOcdSUd
	W5zAZchYhK5OdrsCUbQRGOOOKqhMD2I63ED816nHd6wkRsEHRvQezUgXJjLD7GGw4/cNiT7EcC+
	p/hqIQa05ufXmKWPzHEXUJGMhXUlpY/FvpWE
X-Google-Smtp-Source: AGHT+IHE6fFDvFlmYFh4rC73io7Q24A/SjSS++QJyraNtZS3IyyuDX4jUVbXtZQ+X01dxsQcPdKfhQ==
X-Received: by 2002:a17:90b:1806:b0:2fa:ba3:5451 with SMTP id 98e67ed59e1d1-2fce87468f3mr19833570a91.35.1740375275469;
        Sun, 23 Feb 2025 21:34:35 -0800 (PST)
Received: from thinkpad ([36.255.17.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fceae32c24sm5511291a91.0.2025.02.23.21.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 21:34:34 -0800 (PST)
Date: Mon, 24 Feb 2025 11:04:28 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Hans Zhang <18255117159@163.com>
Cc: jingoohan1@gmail.com, shradha.t@samsung.com, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, bhelgaas@google.com,
	Frank.Li@nxp.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, rockswang7@gmail.com,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [v5] PCI: dwc: Add the debugfs property to provide the LTSSM
 status of the PCIe link
Message-ID: <20250224053428.m6w63a64u5lzm47t@thinkpad>
References: <20250223141848.231232-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250223141848.231232-1-18255117159@163.com>

On Sun, Feb 23, 2025 at 10:18:48PM +0800, Hans Zhang wrote:
> Add the debugfs property to provide a view of the current link's LTSSM
> status from the root port device.
> 
>   /sys/kernel/debug/dwc_pcie_<dev>/ltssm_status
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> Tested-by: Niklas Cassel <cassel@kernel.org>
> ---
> Changes since v4:
> https://lore.kernel.org/linux-pci/20250222143335.221168-1-18255117159@163.com/
> 
> - Change the return value of function dw_ltssm_sts_string from char *
>   to const char *.
> - Modify the Description of the Document.
> 
> Changes since v3:
> https://lore.kernel.org/linux-pci/20250214144618.176028-1-18255117159@163.com/
> 
> - My v4 patch is updated to the latest based on Shradha's v7 patch.
> - Submissions based on the following v7 patches:
> https://patchwork.kernel.org/project/linux-pci/patch/20250221131548.59616-2-shradha.t@samsung.com/
> https://patchwork.kernel.org/project/linux-pci/patch/20250221131548.59616-3-shradha.t@samsung.com/
> https://patchwork.kernel.org/project/linux-pci/patch/20250221131548.59616-4-shradha.t@samsung.com/
> https://patchwork.kernel.org/project/linux-pci/patch/20250221131548.59616-5-shradha.t@samsung.com/
> https://patchwork.kernel.org/project/linux-pci/patch/20250221131548.59616-6-shradha.t@samsung.com/
> 
> Changes since v2:
> https://lore.kernel.org/linux-pci/20250206151343.26779-1-18255117159@163.com/
> 
> - Git pulls the latest code and fixes conflicts.
> - Do not place into sysfs node as recommended by maintainer. Shradha-based patch
>   is put into debugfs.
> - Submissions based on the following v6 patches:
> https://patchwork.kernel.org/project/linux-pci/patch/20250214105007.97582-2-shradha.t@samsung.com/
> https://patchwork.kernel.org/project/linux-pci/patch/20250214105007.97582-3-shradha.t@samsung.com/
> https://patchwork.kernel.org/project/linux-pci/patch/20250214105007.97582-4-shradha.t@samsung.com/
> https://patchwork.kernel.org/project/linux-pci/patch/20250214105007.97582-5-shradha.t@samsung.com/
> 
> Changes since v1:
> https://lore.kernel.org/linux-pci/20250123071326.1810751-1-18255117159@163.com/
> 
> - Do not place into sysfs node as recommended by maintainer. Shradha-based patch
>   is put into debugfs.
> - Submissions based on the following v5 patches:
> https://patchwork.kernel.org/project/linux-pci/patch/20250121111421.35437-2-shradha.t@samsung.com/
> https://patchwork.kernel.org/project/linux-pci/patch/20250121111421.35437-3-shradha.t@samsung.com/
> https://patchwork.kernel.org/project/linux-pci/patch/20250121111421.35437-4-shradha.t@samsung.com/
> https://patchwork.kernel.org/project/linux-pci/patch/20250121111421.35437-5-shradha.t@samsung.com/
> ---
>  Documentation/ABI/testing/debugfs-dwc-pcie    |  5 ++
>  .../controller/dwc/pcie-designware-debugfs.c  | 29 +++++++++++
>  .../pci/controller/dwc/pcie-designware-host.c | 50 +++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-designware.h  | 33 ++++++++++++
>  4 files changed, 117 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/debugfs-dwc-pcie b/Documentation/ABI/testing/debugfs-dwc-pcie
> index 650a89b0511e..8245261506bc 100644
> --- a/Documentation/ABI/testing/debugfs-dwc-pcie
> +++ b/Documentation/ABI/testing/debugfs-dwc-pcie
> @@ -142,3 +142,8 @@ Description:	(RW) Some lanes in the event list are lane specific events. These i
>  		events 1) - 11) and 34) - 35).
>  		Write lane number for which counter needs to be enabled/disabled/dumped.
>  		Read will return the current selected lane number. Lane0 is selected by default.
> +
> +What:		/sys/kernel/debug/dwc_pcie_<dev>/ltssm_status
> +Date:		February 2025
> +Contact:	Hans Zhang <18255117159@163.com>
> +Description:	(RO) Read will return the current PCIe LTSSM state in both string and raw value.
> diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.c b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> index dca1e9999113..39487bd184e1 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> @@ -533,6 +533,33 @@ static int dwc_pcie_rasdes_debugfs_init(struct dw_pcie *pci, struct dentry *dir)
>  	return ret;
>  }
>  
> +static int dwc_pcie_ltssm_status_show(struct seq_file *s, void *v)
> +{
> +	struct dw_pcie *pci = s->private;
> +	enum dw_pcie_ltssm val;
> +
> +	val = dw_pcie_get_ltssm(pci);
> +	seq_printf(s, "%s (0x%02x)\n", dw_ltssm_sts_string(val), val);
> +
> +	return 0;
> +}
> +
> +static int dwc_pcie_ltssm_status_open(struct inode *inode, struct file *file)
> +{
> +	return single_open(file, dwc_pcie_ltssm_status_show, inode->i_private);
> +}
> +
> +static const struct file_operations dwc_pcie_ltssm_status_ops = {
> +	.open = dwc_pcie_ltssm_status_open,
> +	.read = seq_read,
> +};
> +
> +static void dwc_pcie_ltssm_debugfs_init(struct dw_pcie *pci, struct dentry *dir)
> +{
> +	debugfs_create_file("ltssm_status", 0444, dir, pci,
> +			    &dwc_pcie_ltssm_status_ops);
> +}
> +
>  void dwc_pcie_debugfs_deinit(struct dw_pcie *pci)
>  {
>  	dwc_pcie_rasdes_debugfs_deinit(pci);
> @@ -560,5 +587,7 @@ int dwc_pcie_debugfs_init(struct dw_pcie *pci)
>  	if (ret)
>  		dev_dbg(dev, "RASDES debugfs init failed\n");
>  
> +	dwc_pcie_ltssm_debugfs_init(pci, dir);
> +
>  	return 0;
>  }
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 2081e8c72d12..cbe9cdbde79f 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -418,6 +418,56 @@ static void dw_pcie_host_request_msg_tlp_res(struct dw_pcie_rp *pp)
>  	}
>  }
>  
> +const char *dw_ltssm_sts_string(enum dw_pcie_ltssm ltssm)
> +{
> +	const char *str;
> +
> +	switch (ltssm) {
> +#define DW_PCIE_LTSSM_NAME(n) case n: str = #n; break
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_DETECT_QUIET);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_DETECT_ACT);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_POLL_ACTIVE);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_POLL_COMPLIANCE);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_POLL_CONFIG);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_PRE_DETECT_QUIET);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_DETECT_WAIT);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_CFG_LINKWD_START);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_CFG_LINKWD_ACEPT);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_CFG_LANENUM_WAI);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_CFG_LANENUM_ACEPT);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_CFG_COMPLETE);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_CFG_IDLE);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_LOCK);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_SPEED);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_RCVRCFG);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_IDLE);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_L0);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_L0S);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_L123_SEND_EIDLE);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_L1_IDLE);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_L2_IDLE);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_L2_WAKE);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_DISABLED_ENTRY);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_DISABLED_IDLE);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_DISABLED);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_LPBK_ENTRY);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_LPBK_ACTIVE);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_LPBK_EXIT);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_LPBK_EXIT_TIMEOUT);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_HOT_RESET_ENTRY);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_HOT_RESET);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_EQ0);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_EQ1);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_EQ2);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_EQ3);
> +	default:
> +		str = "DW_PCIE_LTSSM_UNKNOWN";
> +		break;
> +	}
> +
> +	return str + strlen("DW_PCIE_LTSSM_");
> +}
> +
>  int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 7f9807d4e5de..00c32fa1b151 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -330,9 +330,40 @@ enum dw_pcie_ltssm {
>  	/* Need to align with PCIE_PORT_DEBUG0 bits 0:5 */
>  	DW_PCIE_LTSSM_DETECT_QUIET = 0x0,
>  	DW_PCIE_LTSSM_DETECT_ACT = 0x1,
> +	DW_PCIE_LTSSM_POLL_ACTIVE = 0x2,
> +	DW_PCIE_LTSSM_POLL_COMPLIANCE = 0x3,
> +	DW_PCIE_LTSSM_POLL_CONFIG = 0x4,
> +	DW_PCIE_LTSSM_PRE_DETECT_QUIET = 0x5,
>  	DW_PCIE_LTSSM_DETECT_WAIT = 0x6,
> +	DW_PCIE_LTSSM_CFG_LINKWD_START = 0x7,
> +	DW_PCIE_LTSSM_CFG_LINKWD_ACEPT = 0x8,
> +	DW_PCIE_LTSSM_CFG_LANENUM_WAI = 0x9,
> +	DW_PCIE_LTSSM_CFG_LANENUM_ACEPT = 0xa,
> +	DW_PCIE_LTSSM_CFG_COMPLETE = 0xb,
> +	DW_PCIE_LTSSM_CFG_IDLE = 0xc,
> +	DW_PCIE_LTSSM_RCVRY_LOCK = 0xd,
> +	DW_PCIE_LTSSM_RCVRY_SPEED = 0xe,
> +	DW_PCIE_LTSSM_RCVRY_RCVRCFG = 0xf,
> +	DW_PCIE_LTSSM_RCVRY_IDLE = 0x10,
>  	DW_PCIE_LTSSM_L0 = 0x11,
> +	DW_PCIE_LTSSM_L0S = 0x12,
> +	DW_PCIE_LTSSM_L123_SEND_EIDLE = 0x13,
> +	DW_PCIE_LTSSM_L1_IDLE = 0x14,
>  	DW_PCIE_LTSSM_L2_IDLE = 0x15,
> +	DW_PCIE_LTSSM_L2_WAKE = 0x16,
> +	DW_PCIE_LTSSM_DISABLED_ENTRY = 0x17,
> +	DW_PCIE_LTSSM_DISABLED_IDLE = 0x18,
> +	DW_PCIE_LTSSM_DISABLED = 0x19,
> +	DW_PCIE_LTSSM_LPBK_ENTRY = 0x1a,
> +	DW_PCIE_LTSSM_LPBK_ACTIVE = 0x1b,
> +	DW_PCIE_LTSSM_LPBK_EXIT = 0x1c,
> +	DW_PCIE_LTSSM_LPBK_EXIT_TIMEOUT = 0x1d,
> +	DW_PCIE_LTSSM_HOT_RESET_ENTRY = 0x1e,
> +	DW_PCIE_LTSSM_HOT_RESET = 0x1f,
> +	DW_PCIE_LTSSM_RCVRY_EQ0 = 0x20,
> +	DW_PCIE_LTSSM_RCVRY_EQ1 = 0x21,
> +	DW_PCIE_LTSSM_RCVRY_EQ2 = 0x22,
> +	DW_PCIE_LTSSM_RCVRY_EQ3 = 0x23,
>  
>  	DW_PCIE_LTSSM_UNKNOWN = 0xFFFFFFFF,
>  };
> @@ -683,6 +714,8 @@ static inline enum dw_pcie_ltssm dw_pcie_get_ltssm(struct dw_pcie *pci)
>  	return (enum dw_pcie_ltssm)FIELD_GET(PORT_LOGIC_LTSSM_STATE_MASK, val);
>  }
>  
> +const char *dw_ltssm_sts_string(enum dw_pcie_ltssm ltssm);
> +
>  #ifdef CONFIG_PCIE_DW_HOST
>  int dw_pcie_suspend_noirq(struct dw_pcie *pci);
>  int dw_pcie_resume_noirq(struct dw_pcie *pci);
> 
> base-commit: ff202c5028a195c07b16e1a2fbb8ca6b7ba11a1c
> prerequisite-patch-id: c153d1c334b19796f686e3a143e0e4ad0c22f373
> prerequisite-patch-id: 871aa1f094627d0e0cb4c89bea577e901bbc7b6a
> prerequisite-patch-id: 54b27bf41a444283be102709e2f8a7d1fdac456a
> prerequisite-patch-id: 95d8a6c78c32f2ea79ad967c134c881f9f3e0931
> prerequisite-patch-id: 751ccbe84a18d85c2beeec19f2d1d429569960d2
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்

