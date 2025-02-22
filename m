Return-Path: <linux-pci+bounces-22103-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E012A40A1A
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 17:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 456DA19C053E
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 16:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA0420125F;
	Sat, 22 Feb 2025 16:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aqWhFfSA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4966A13C81B
	for <linux-pci@vger.kernel.org>; Sat, 22 Feb 2025 16:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740242359; cv=none; b=AzIGfRxKv+bCNWr5E1BO96Tz0d6pjw1f8BOcDXQq0KCEE1DXRP7zteQh+65TzmYcnXkYmN5RehBehLsilZs8dKA3JIDgqiMWvypmGCAXvGQJLzxRbETEs4AjFrOlvRXpyHtXeo0oDoL7T5KZx/LFGiLqQ12/uLcrsACW9D3OCJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740242359; c=relaxed/simple;
	bh=SpRv6/AbKNgGsFEbEJqsi5HWVi6J4eLOO9+oDkvmTOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BTYKlUXmYaftkdOQ+O57Y5vFz9yOg92YeCiJTiVVmCo9zCVWmJNBLV00hE0rsqpsL+ckYcO4Hv4maa5Rilo9KVV0zszkizeKexgTxwd0GUkOlwc4v8tr9fcwia2TsRD9WuU6d/OeZvYLpU/QBOwvwJ4x03aZ4f7fO9kNJzb9S2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aqWhFfSA; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2210d92292eso94521765ad.1
        for <linux-pci@vger.kernel.org>; Sat, 22 Feb 2025 08:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740242355; x=1740847155; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Tqs7xAa2Cq/UQesroDo6ja5Dth1i/w+m4iS9Gg2570I=;
        b=aqWhFfSA72AHjxu4m7xKGFwTWxrJewf2F0DHfH3I85Gx/Fc5f8aQto84QpUYG/Pu0g
         tY1ZLBpuaHAjbaSs1i/qSZTyS+/BGZr+j/ojGMtDPVcw3AK+F6CbsW37QW0QAQhzuU3I
         GVUKhs0s2PdHEb13R2jAr9T+9Yh2NkvS1+T1Ma1t9EKGu2G0yQkC4RatGjKGB2OM2SuX
         yJW02Z9Yz5JCiYvypn3wEzPIOwjrub1qPQeOHzUgAXz4tTyci4rqrbukWpK3J/SUPWfT
         WEaucv85UTVHOtnb5NtVqVBEUZ8HGgF/q+sZkQvH8ARH6I80OjW3asnSFC49KKrqNyp4
         wFkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740242355; x=1740847155;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tqs7xAa2Cq/UQesroDo6ja5Dth1i/w+m4iS9Gg2570I=;
        b=qIEeHkFIHVrI9iI4jzLu/yFcPQD7RyHdGbYmWvmPQGd+eAY/OYAYTWiLkA16Ej/C4U
         scnLxvKdTPlpnRlx+uZe9x0q9nzIAgLdbg7IfdwHeViNUgjXNBiOo4d7yd1//5YOHUCQ
         2PpAyi61wJufkK18LQlfugLLGPOKhTLcA28FOdARSlZZ7w2PEZyAv+5DuU24frWlTS9u
         B+Bcn73lP5GU0YqpRrwdrxrR0hXR1Mn7P/oqnGcPv2+8yUh3iSrlJ8STzR8jrk/eXX9/
         rI1KIAT9CZ41yS2tB47tPbRp0BJDopUyccbOogLYa7LEOzQlbSBZc4hSmGsVh7Qos/PN
         Nc0g==
X-Forwarded-Encrypted: i=1; AJvYcCVr82Le/XFkxllwBwflKTUD+fopAMaRbMJkU75H+y+dspZH4aA+neCIJPDiqMTVp+yfkwlqPx79xds=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBm3K8hOUZErBctk6ny28rFOhcEeKXY7YF1rwbI8T29fyvlJJ0
	01s2TOknSsw/lapQSI+Rg8KZI0PjMsVB7qd648vpumUAwJqXmEyPQPx1IrpQeA==
X-Gm-Gg: ASbGnctZqO49t/Hq/lUsZ4YF5qkuFBQYnnBBhaOg5Psonh/NJ9FDMGKF7HFIsM72cIv
	5eVt9pUc9GKbfhNe90aMDWafH3CvgnM5WarJOGNoBCVy4J6J6RsNFEdQoXz5nB+t8Gjon0U19Kr
	fQHWxS+6aJYzZosxoRR1E6T9mLDUCa1E1hxmISv6pmUYKsD6mc2Ag6wSHbW4Ws4sqk2Z61k5ylg
	IyeSJIxk5u6hkrlFG1cx+tOldCfZc7IJ7+rDX4H+M40H4loUSAvIBv1SsWfU3EKoE/W72N0fqOz
	2wvYOVEKPW7Lh9uz9ww6s9Uk+UQkKg0S8jhiWA==
X-Google-Smtp-Source: AGHT+IGxoEle+dcdR02axYdJD2KI5aLsN+Jm2xf8ibtthdrWfx2Ecn8yYv/P3bvSGAeXgchNUjr0bQ==
X-Received: by 2002:a05:6a00:14c8:b0:732:5164:3bb with SMTP id d2e1a72fcca58-73426cab028mr9628439b3a.9.1740242355452;
        Sat, 22 Feb 2025 08:39:15 -0800 (PST)
Received: from thinkpad ([120.60.135.149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73242568af8sm17596951b3a.48.2025.02.22.08.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 08:39:14 -0800 (PST)
Date: Sat, 22 Feb 2025 22:09:09 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Hans Zhang <18255117159@163.com>
Cc: jingoohan1@gmail.com, shradha.t@samsung.com, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, bhelgaas@google.com,
	Frank.Li@nxp.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, rockswang7@gmail.com,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [v4] PCI: dwc: Add the debugfs property to provide the LTSSM
 status of the PCIe link
Message-ID: <20250222163909.mmjvnlsituqrrocf@thinkpad>
References: <20250222143335.221168-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250222143335.221168-1-18255117159@163.com>

On Sat, Feb 22, 2025 at 10:33:35PM +0800, Hans Zhang wrote:
> Add the debugfs property to provide a view of the current link's LTSSM
> status from the root port device.
> 
>   /sys/kernel/debug/dwc_pcie_<dev>/ltssm_status
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>

Just minor comments below.

> Tested-by: Niklas Cassel <cassel@kernel.org>
> ---
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
>  Documentation/ABI/testing/debugfs-dwc-pcie    |  6 +++
>  .../controller/dwc/pcie-designware-debugfs.c  | 29 +++++++++++
>  .../pci/controller/dwc/pcie-designware-host.c | 50 +++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-designware.h  | 33 ++++++++++++
>  4 files changed, 118 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/debugfs-dwc-pcie b/Documentation/ABI/testing/debugfs-dwc-pcie
> index 650a89b0511e..86418f7ed4b5 100644
> --- a/Documentation/ABI/testing/debugfs-dwc-pcie
> +++ b/Documentation/ABI/testing/debugfs-dwc-pcie
> @@ -142,3 +142,9 @@ Description:	(RW) Some lanes in the event list are lane specific events. These i
>  		events 1) - 11) and 34) - 35).
>  		Write lane number for which counter needs to be enabled/disabled/dumped.
>  		Read will return the current selected lane number. Lane0 is selected by default.
> +
> +What:		/sys/kernel/debug/dwc_pcie_<dev>/ltssm_status
> +Date:		February 2025
> +Contact:	Hans Zhang <18255117159@163.com>
> +Description:	(RO) Read will return the current value of the PCIe link status raw value and
> +		string status.

'Read will return the current PCIe LTSSM state in both string and raw value.'

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
> index 2081e8c72d12..46182e97659e 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -418,6 +418,56 @@ static void dw_pcie_host_request_msg_tlp_res(struct dw_pcie_rp *pp)
>  	}
>  }
>  
> +char *dw_ltssm_sts_string(enum dw_pcie_ltssm ltssm)

const char *dw_pcie_ltssm_string()

> +{
> +	char *str;

const char *

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
> index 7f9807d4e5de..65ff271eaabc 100644
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
> +char *dw_ltssm_sts_string(enum dw_pcie_ltssm ltssm);

const char *dw_pcie_ltssm_string()

- Mani

-- 
மணிவண்ணன் சதாசிவம்

