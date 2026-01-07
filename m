Return-Path: <linux-pci+bounces-44148-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAFFCFCA54
	for <lists+linux-pci@lfdr.de>; Wed, 07 Jan 2026 09:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 939363007C6A
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jan 2026 08:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09EA2C0F79;
	Wed,  7 Jan 2026 08:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="b/xEkBuA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m49226.qiye.163.com (mail-m49226.qiye.163.com [45.254.49.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C7A23EAAF;
	Wed,  7 Jan 2026 08:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767774914; cv=none; b=tDnoTy0P+hpYHSQoN31EYCKG7/SesK2oaUomyKWThHAH/8OyW0L19ig/ez9fYBfXn9ScQ8pukxFyxr1tacUyByNNCCe1++GK5uUmY1sKHMf6JWeWwqsnWHTMpkazuTtbVaZUDsze1Uy4AMb4hWViKMi3fEzTZm47PziyPySe5Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767774914; c=relaxed/simple;
	bh=DB5H0Ope0Egpr+w8oBSyuWkt2umS+gIMNHRqJ7IPTp8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=o6Z1HdJeC0jHmWbAsDMc7yZpEv5jCI4VG93pF5VbiCJN16GtTat+PXG3acAEBKdN531VHbWveTGE2S18PiyKh5j8x0z6pC2Gfe+eGVZXA/llo0mF8BfatQF9qevLwrz2V7e3q8HTTZc4PAzO76qPBhNdzN/4FKero059ZS7L7T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=b/xEkBuA; arc=none smtp.client-ip=45.254.49.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2fcc4d482;
	Wed, 7 Jan 2026 16:35:01 +0800 (GMT+08:00)
Message-ID: <b996a040-33b7-4934-9b4d-6e23e83f07a1@rock-chips.com>
Date: Wed, 7 Jan 2026 16:35:00 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, vincent.guittot@linaro.org,
 zhangsenchuan@eswincomputing.com, Richard Zhu <hongxing.zhu@nxp.com>
Subject: Re: [PATCH v4 2/6] PCI: dwc: Rename and move ltssm_status_string() to
 pcie-designware.c
To: manivannan.sadhasivam@oss.qualcomm.com, Jingoo Han
 <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
References: <20260107-pci-dwc-suspend-rework-v4-0-9b5f3c72df0a@oss.qualcomm.com>
 <20260107-pci-dwc-suspend-rework-v4-2-9b5f3c72df0a@oss.qualcomm.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20260107-pci-dwc-suspend-rework-v4-2-9b5f3c72df0a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9b979854ea09cckunm8d6d55958d809f
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGk9OGlYZSUJMSEMdGRhMQkxWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=b/xEkBuA/+hueL9jBZzYjIBY00bQfWaMhnS3Og7qnQqazLNHN6X6O9MXLLHBW8my+UG2Yjf/FovaIFOUo/OrbjEOB3YyjKrqYY4Gw0xlbho+F1PIFHSCpmDhBg4qopeCJBqev2+kDbglQzJTU68cSg+j2H8yefeK78o+awmgx3A=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=KUBG8uMGb2HfMWW/80TsVMw92cDvTUopz4ia5kRwcB8=;
	h=date:mime-version:subject:message-id:from;

在 2026/01/07 星期三 16:11, Manivannan Sadhasivam via B4 Relay 写道:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> Rename ltssm_status_string() to dw_pcie_ltssm_status_string() and move it
> to the common file pcie-designware.c so that this function could be used
> outside of pcie-designware-debugfs.c file.
> 

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>   .../pci/controller/dwc/pcie-designware-debugfs.c   | 54 +---------------------
>   drivers/pci/controller/dwc/pcie-designware.c       | 52 +++++++++++++++++++++
>   drivers/pci/controller/dwc/pcie-designware.h       |  2 +
>   3 files changed, 55 insertions(+), 53 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.c b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> index df98fee69892..0d1340c9b364 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> @@ -443,65 +443,13 @@ static ssize_t counter_value_read(struct file *file, char __user *buf,
>   	return simple_read_from_buffer(buf, count, ppos, debugfs_buf, pos);
>   }
>   
> -static const char *ltssm_status_string(enum dw_pcie_ltssm ltssm)
> -{
> -	const char *str;
> -
> -	switch (ltssm) {
> -#define DW_PCIE_LTSSM_NAME(n) case n: str = #n; break
> -	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_DETECT_QUIET);
> -	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_DETECT_ACT);
> -	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_POLL_ACTIVE);
> -	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_POLL_COMPLIANCE);
> -	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_POLL_CONFIG);
> -	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_PRE_DETECT_QUIET);
> -	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_DETECT_WAIT);
> -	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_CFG_LINKWD_START);
> -	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_CFG_LINKWD_ACEPT);
> -	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_CFG_LANENUM_WAI);
> -	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_CFG_LANENUM_ACEPT);
> -	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_CFG_COMPLETE);
> -	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_CFG_IDLE);
> -	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_LOCK);
> -	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_SPEED);
> -	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_RCVRCFG);
> -	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_IDLE);
> -	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_L0);
> -	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_L0S);
> -	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_L123_SEND_EIDLE);
> -	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_L1_IDLE);
> -	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_L2_IDLE);
> -	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_L2_WAKE);
> -	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_DISABLED_ENTRY);
> -	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_DISABLED_IDLE);
> -	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_DISABLED);
> -	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_LPBK_ENTRY);
> -	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_LPBK_ACTIVE);
> -	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_LPBK_EXIT);
> -	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_LPBK_EXIT_TIMEOUT);
> -	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_HOT_RESET_ENTRY);
> -	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_HOT_RESET);
> -	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_EQ0);
> -	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_EQ1);
> -	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_EQ2);
> -	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_RCVRY_EQ3);
> -	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_L1_1);
> -	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_L1_2);
> -	default:
> -		str = "DW_PCIE_LTSSM_UNKNOWN";
> -		break;
> -	}
> -
> -	return str + strlen("DW_PCIE_LTSSM_");
> -}
> -
>   static int ltssm_status_show(struct seq_file *s, void *v)
>   {
>   	struct dw_pcie *pci = s->private;
>   	enum dw_pcie_ltssm val;
>   
>   	val = dw_pcie_get_ltssm(pci);
> -	seq_printf(s, "%s (0x%02x)\n", ltssm_status_string(val), val);
> +	seq_printf(s, "%s (0x%02x)\n", dw_pcie_ltssm_status_string(val), val);
>   
>   	return 0;
>   }
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 55c1c60f7f8f..87f2ebc134d6 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -692,6 +692,58 @@ void dw_pcie_disable_atu(struct dw_pcie *pci, u32 dir, int index)
>   	dw_pcie_writel_atu(pci, dir, index, PCIE_ATU_REGION_CTRL2, 0);
>   }
>   
> +const char *dw_pcie_ltssm_status_string(enum dw_pcie_ltssm ltssm)
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
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_L1_1);
> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_L1_2);
> +	default:
> +		str = "DW_PCIE_LTSSM_UNKNOWN";
> +		break;
> +	}
> +
> +	return str + strlen("DW_PCIE_LTSSM_");
> +}
> +
>   /**
>    * dw_pcie_wait_for_link - Wait for the PCIe link to be up
>    * @pci: DWC instance
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index f87c67a7a482..c1def4d9cf62 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -828,6 +828,8 @@ static inline enum dw_pcie_ltssm dw_pcie_get_ltssm(struct dw_pcie *pci)
>   	return (enum dw_pcie_ltssm)FIELD_GET(PORT_LOGIC_LTSSM_STATE_MASK, val);
>   }
>   
> +const char *dw_pcie_ltssm_status_string(enum dw_pcie_ltssm ltssm);
> +
>   #ifdef CONFIG_PCIE_DW_HOST
>   int dw_pcie_suspend_noirq(struct dw_pcie *pci);
>   int dw_pcie_resume_noirq(struct dw_pcie *pci);
> 


