Return-Path: <linux-pci+bounces-43507-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C48CD51C2
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 09:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A00BE302BA9E
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 08:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7BA313285;
	Mon, 22 Dec 2025 08:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EGDfIdvj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MkXbBWx6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD83F28690
	for <linux-pci@vger.kernel.org>; Mon, 22 Dec 2025 08:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766391569; cv=none; b=O/qP7FB0/Zw94G1asnnhlcIE02JL9dTfyMVomcqumb86tJnaSGcerfqSJ5Ps5dY7koEn26fZ2F1DQ96dPtxinU7x7Fx40o2U8WK9jp8n2oN2pp5JsgYu9bxshvjJumeFJ02PrYKc5JYqFUzhCrtZ9t6e+SrAkOfjE5JMq7HeLFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766391569; c=relaxed/simple;
	bh=nA8y2bEM4Yx1Oq5BRChFqdoB8+NVx6rAe6y8oTeQGFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TaBkvHM1OpnqQSyVOBk0JSiLU9nR9h4n4pZ4/kd+gHgze0XbC3s0yoKoUdM658pWqpEmVR96wPdThE+Tuek1ayMEQScJq+P0eM2OoRg9NSRJHqUpEJmlS9GaGEIj5k1F8GWj21PjjjfwN0CjzVl3FaD06ynhKJbllcsaouHxNK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EGDfIdvj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MkXbBWx6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BM824Hi3586371
	for <linux-pci@vger.kernel.org>; Mon, 22 Dec 2025 08:19:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2Y3yLJRT2ENhfqeGTgY5YZoHEsYe5JwKTqP5zOTwVno=; b=EGDfIdvjM8scpHFU
	JC2/lb64uYp5swg0jniRs63ZZ7Gln5jXcnqy3xTcbRbarIufaEiIQ7hhK0g56q0Z
	kNJ7j/8Mh4Vmx3Y8M4ZeaUMczaVW6/mK7t6VrEjdDJZGHPvKauM19XZ2loClnaCZ
	+ULoO0tSjBeu28s/wjn/ac98yfcRDqJiyv9lDxAyI6odOCmLy54TSyCTvvYFg7ZO
	04H6GWpzwKZLOpHqVABerG9p7q8JsRFawvpGCUefpozb45GxzvrgfAThA1a39zC9
	pvtsFs5v9KABqfVQ3ECfJSKxS7plj80LrKLDtZYcewYO7kI6ZS4AlK5sT7h+3B4H
	yugNcw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b69ahjhnj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 22 Dec 2025 08:19:26 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7b90740249dso6456793b3a.0
        for <linux-pci@vger.kernel.org>; Mon, 22 Dec 2025 00:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766391566; x=1766996366; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Y3yLJRT2ENhfqeGTgY5YZoHEsYe5JwKTqP5zOTwVno=;
        b=MkXbBWx6olMvrEET71VqChJF2IH7rZjIOIEmP3gyLLNd3skaUQijtQ1MmgC4AcxAIK
         WYh2Zqxx9msdhpDHXWVVSWb4Wt4ipVw2j2GXcc25gHp1drrNuwkgXbEvz3JPdHRVWZcY
         tZFfNvxuZ1k15xjf2OZMkqgvN2ulHn5PZi6imd2/uKXrWIs392H9HlWht5NinOVM+7o0
         oYfFV3DS/qvjfaJ6/gsLjni4zHdgSQUh5k5uEnZKkSrefJQHq+MCZ6Ua5XISpUE1m7DJ
         /ICWQafZ3BMYP7wmZmvSS7OwU0ClOO8nN1OKtlM0fsqfOU2sdmo7kYMQg4tzPNwo2jT/
         YJfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766391566; x=1766996366;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Y3yLJRT2ENhfqeGTgY5YZoHEsYe5JwKTqP5zOTwVno=;
        b=RXVX3j8THFqDi7x+K0zcHrgQhbEiHe8JxvcVvIdFP4HPVW93mSB53sTZjpOA9ZA3/D
         +du/bY6zm/PM1ISwo7kaZTdQ7bPLt/okw41BPnqTb7PJOlugK4azyL5WQrgkx9pRl0w4
         7ITJE9SKgh1XMw8+xxEQMAh7KakwB510dpq0vjhs2yOsfhuvFVtn0+DZzFj4HEZELhdw
         19b1Oa0uUh+lIF55Jax9LSi13Iy1VEki8IAlbe+lEEx1wGiVh4dqfiLRANliizkr8P6L
         X19REwAAwntXaCOMrzEYw1CqrQ51ETaReU2/8dehXI/4gJClOGlJzVkc01dRLrnUsw/N
         374g==
X-Forwarded-Encrypted: i=1; AJvYcCWzeKgZTNVeuAzWokjfjSIfK6hCG7RKUa824v83HGG9XUZAEhVs4tm1J8dOrxYEOiKKzS8CfvBa5/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO1HCV2mNWFX/wgKfuvNwV62Cu4Nv0ku/3cCThmAQt6JJWhLHk
	ysnE9csGQ+zyPqG9bqw7a56vXPQ1F+9eEFCGKCo23qMd3VcuP7Mc9iIkFbn5PUAtUZ9OtpE1BYH
	BNd0h0liDqZxspmOGs8F0Lqm2djlma/74DmUdMqCEFwAKsoOm5xzT2SblPuG7uss=
X-Gm-Gg: AY/fxX4XXuZH696OaH1b+/YjYhNJfT6u5JQHCqP0wnc/+kJpQ3/hXQQWJNXNYiz9B14
	cQ6zdDIbjyFGh6y8W0+rILg2mvMQG1rpbQnFJBC5vkQ8EovC2OCFCeGPDr/BR1qrg0cHs9m+flE
	g+MjWIerAvgLldzif13Mee58CTDD3j3gBpKolCEz5S2w1r5j3UNOPkQnFB7A4RK1PvUYXQZ8Kfg
	O3nfQVFGwTXVFK4j+KAJnSAYZTpwrnvnmcWJPj/OpSrgcf8H0nXNby42Wft1emOrQzOeFMuSqau
	q8BtinW5cs7+MwQWHhM+26mEexic07KjmQ8R5Zp5zbshu9p3dyUQnKB+Y/6GT+ICT+HvHPoW0lw
	Z+stze0jWMX2IEswjWrYUCE1Mqufx47RAweEB//Qdeg==
X-Received: by 2002:a05:6a00:1d15:b0:7ac:d1fe:5c1c with SMTP id d2e1a72fcca58-7ff648ed92dmr7873389b3a.18.1766391566126;
        Mon, 22 Dec 2025 00:19:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGck4J5jvLctnijHRv9r5uef899dc2vnTKCfD1ohkAB1TPymZGpX+qghP9G1pceHXjBo7EfSQ==
X-Received: by 2002:a05:6a00:1d15:b0:7ac:d1fe:5c1c with SMTP id d2e1a72fcca58-7ff648ed92dmr7873372b3a.18.1766391565581;
        Mon, 22 Dec 2025 00:19:25 -0800 (PST)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7b4234e2sm9557121b3a.27.2025.12.22.00.19.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 00:19:25 -0800 (PST)
Message-ID: <8e00bd1c-29ae-43fd-90e8-ea0943cb02b6@oss.qualcomm.com>
Date: Mon, 22 Dec 2025 13:49:21 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: dwc: ep: Cache MSI outbound iATU mapping
To: Niklas Cassel <cassel@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Frank Li <Frank.Li@nxp.com>, Damien Le Moal <dlemoal@kernel.org>,
        Koichiro Den <den@valinux.co.jp>, linux-pci@vger.kernel.org
References: <20251210071358.2267494-2-cassel@kernel.org>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20251210071358.2267494-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=JuH8bc4C c=1 sm=1 tr=0 ts=6948ff0e cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=Op2LraesObuKZ0PTTu4A:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: 3BSnLQrcqNcVVpsHaP-7wryhszf93ZOa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDA3NCBTYWx0ZWRfX1TtdJLoz1OWm
 8VIQ5uUyFLfoAO03yP2DG/vYbXwpkyxKEAOm1lYFx9JzTD+iklkxq++ybJXp6HLfwo5zyPLHwOG
 UKkCx1SCOnNs+D4ck7H7h21TpVmFoy1dORJOADDaPct3hgavu2xeu4rZWc1MpufestTod5Gh541
 hnDppPQ52kbnMd5YrxA+61bWg9ZEGE6iDBYOaqIylgSke8ov0ljYu5hmEPPJeIpPcrByOiKu2Ir
 xmbVF0tjHdOWDwYEud8C8Uw4V6syGa5VNdGbHw18B28463g2R/m6VSLgFB2I++M4dTRDvN51bZ6
 smw+Rru4cG7jePY6khbH2EklNkDAjpqHlE0lDeG9VNQVAs7OGUM2tOT8BHipDWYKPSr70mo3G0+
 /oIH6+2DfW2g6pXC5n54/k0WdPw2ez+48KTXIsrjeQ7xu9xWzfsnQPQWeMvwrsoKMrCJjmZ3oHH
 Nme4zI4VFBEc4IniXVw==
X-Proofpoint-GUID: 3BSnLQrcqNcVVpsHaP-7wryhszf93ZOa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_05,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 adultscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512220074



On 12/10/2025 12:43 PM, Niklas Cassel wrote:
> From: Koichiro Den <den@valinux.co.jp>
>
> dw_pcie_ep_raise_msi_irq() currently programs an outbound iATU window
> for the MSI target address on every interrupt and tears it down again
> via dw_pcie_ep_unmap_addr().
>
> On systems that heavily use the AXI bridge interface (for example when
> the integrated eDMA engine is active), this means the outbound iATU
> registers are updated while traffic is in flight. The DesignWare
> endpoint databook 5.40a - "3.10.6.1 iATU Outbound Programming Overview"
> warns that updating iATU registers in this situation is not supported,
> and the behavior is undefined.
>
> Under high MSI and eDMA load this pattern results in occasional bogus
> outbound transactions and IOMMU faults, on the RC side, such as:
>
>    ipmmu-vmsa eed40000.iommu: Unhandled fault: status 0x00001502 iova 0xfe000000
>
> followed by the system becoming unresponsive. This is the actual output
> observed on Renesas R-Car S4, with its ipmmu_hc used with PCIe ch0.
>
> There is no need to reprogram the iATU region used for MSI on every
> interrupt. The host-provided MSI address is stable while MSI is enabled,
> and the endpoint driver already dedicates a scratch buffer for MSI
> generation.
>
> Cache the aligned MSI address and map size, program the outbound iATU
> once, and keep the window enabled. Subsequent interrupts only perform a
> write to the MSI scratch buffer, avoiding dynamic iATU reprogramming in
> the hot path and fixing the lockups seen under load.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> [cassel: do same change for dw_pcie_ep_raise_msix_irq()]
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
> Notes: Without this patch, I also see IOMMU errors on the host side,
> when running drivers/nvme/target/pci-epf.c with a large queue depth.
>
> pci_epc_raise_irq() does take a mutex, so the calls to these functions
> are serialized, so it really appears that the DWC controller does not
> handle iATU reprogramming while there are outstanding transactions.
>
> Just like Koichiro describes here:
> https://lore.kernel.org/linux-pci/ddriorsgyjs6klcb6d7pi2u3ah3wxlzku7v2dpyjlo6tmalvfw@yj5dczlkggt6/
>
> I also see the iova faulting on the RC side to be the start of "addr_space"
> on the EP, so it appears that a transaction has gone through untranslated.
> (Most likely because the DWC controller does handle the iATU table being
> modified while there are outstanding transactions.)
>
> This patch has been tested using pci-epf-test and nvmet-pci-epf on rock5b.
>
> pci-epf-test does change between MSI and MSI-X without calling
> dw_pcie_ep_stop(), however, the msg_addr address written by the host
> will be the same address, at least when using a Linux host using a DWC
> based controller. If another host ends up using different msg_addr for
> MSI and MSI-X, then I think that we will need to modify pci-epf-test to
> call a function when changing IRQ type, such that pcie-designware-ep.c
> can tear down the MSI/MSI-X mapping.
>
>   .../pci/controller/dwc/pcie-designware-ep.c   | 82 ++++++++++++++++---
>   drivers/pci/controller/dwc/pcie-designware.h  |  5 ++
>   2 files changed, 75 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 7f2112c2fb21..2bbeddaa73d4 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -601,6 +601,16 @@ static void dw_pcie_ep_stop(struct pci_epc *epc)
>   	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
>   	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>   
> +	/*
> +	 * Tear down the dedicated outbound window used for MSI
> +	 * generation. This avoids leaking an iATU window across
> +	 * endpoint stop/start cycles.
> +	 */
> +	if (ep->msi_iatu_mapped) {
> +		dw_pcie_ep_unmap_addr(epc, 0, 0, ep->msi_mem_phys);
> +		ep->msi_iatu_mapped = false;
> +	}
> +
>   	dw_pcie_stop_link(pci);
>   }
>   
> @@ -702,14 +712,37 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
>   	msg_addr = ((u64)msg_addr_upper) << 32 | msg_addr_lower;
>   
>   	msg_addr = dw_pcie_ep_align_addr(epc, msg_addr, &map_size, &offset);
> -	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
> -				  map_size);
> -	if (ret)
> -		return ret;
>   
> -	writel(msg_data | (interrupt_num - 1), ep->msi_mem + offset);
> +	/*
> +	 * Program the outbound iATU once and keep it enabled.
> +	 *
> +	 * The spec warns that updating iATU registers while there are
> +	 * operations in flight on the AXI bridge interface is not
> +	 * supported, so we avoid reprogramming the region on every MSI,
> +	 * specifically unmapping immediately after writel().
> +	 */
> +	if (!ep->msi_iatu_mapped) {
> +		ret = dw_pcie_ep_map_addr(epc, func_no, 0,
> +					  ep->msi_mem_phys, msg_addr,
> +					  map_size);
> +		if (ret)
> +			return ret;
> +
> +		ep->msi_iatu_mapped = true;
> +		ep->msi_msg_addr = msg_addr;
> +		ep->msi_map_size = map_size;
> +	} else if (WARN_ON_ONCE(ep->msi_msg_addr != msg_addr ||
> +				ep->msi_map_size != map_size)) {
> +		/*
> +		 * The host changed the MSI target address or the required
> +		 * mapping size changed. Reprogramming the iATU at runtime is
> +		 * unsafe on this controller, so bail out instead of trying to
> +		 * update the existing region.
> +		 */
> +		return -EINVAL;
> +	}
>   
> -	dw_pcie_ep_unmap_addr(epc, func_no, 0, ep->msi_mem_phys);
> +	writel(msg_data | (interrupt_num - 1), ep->msi_mem + offset);
>   
>   	return 0;
>   }
> @@ -786,14 +819,36 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
>   	}
>   
>   	msg_addr = dw_pcie_ep_align_addr(epc, msg_addr, &map_size, &offset);
> -	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
> -				  map_size);
> -	if (ret)
> -		return ret;
>   
> -	writel(msg_data, ep->msi_mem + offset);
> +	/*
> +	 * Program the outbound iATU once and keep it enabled.
> +	 *
> +	 * The spec warns that updating iATU registers while there are
> +	 * operations in flight on the AXI bridge interface is not
> +	 * supported, so we avoid reprogramming the region on every MSI-X,
> +	 * specifically unmapping immediately after writel().
> +	 */
> +	if (!ep->msi_iatu_mapped) {
This is wrong, in MSIX each vector can give you different address, you 
can't expect same address for
all the vectors in MSIX table. In ARM based system you might see only 
single address for X86 this will
change.

And also we see in MSIX the address are getting updated at runtime with 
x86 windows host machines.

Use the MSIX doorbell method which will not use iATU at all, 
dw_pcie_ep_raise_msix_irq_doorbell().

- Krishna Chaitanya.
> +		ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
> +					  map_size);
> +		if (ret)
> +			return ret;
> +
> +		ep->msi_iatu_mapped = true;
> +		ep->msi_msg_addr = msg_addr;
> +		ep->msi_map_size = map_size;
> +	} else if (WARN_ON_ONCE(ep->msi_msg_addr != msg_addr ||
> +				ep->msi_map_size != map_size)) {
> +		/*
> +		 * The host changed the MSI-X target address or the required
> +		 * mapping size changed. Reprogramming the iATU at runtime is
> +		 * unsafe on this controller, so bail out instead of trying to
> +		 * update the existing region.
> +		 */
> +		return -EINVAL;
> +	}
>   
> -	dw_pcie_ep_unmap_addr(epc, func_no, 0, ep->msi_mem_phys);
> +	writel(msg_data, ep->msi_mem + offset);
>   
>   	return 0;
>   }
> @@ -1086,6 +1141,9 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>   	struct device *dev = pci->dev;
>   
>   	INIT_LIST_HEAD(&ep->func_list);
> +	ep->msi_iatu_mapped = false;
> +	ep->msi_msg_addr = 0;
> +	ep->msi_map_size = 0;
>   
>   	epc = devm_pci_epc_create(dev, &epc_ops);
>   	if (IS_ERR(epc)) {
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index a31bd93490dc..1093c622826d 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -472,6 +472,11 @@ struct dw_pcie_ep {
>   	void __iomem		*msi_mem;
>   	phys_addr_t		msi_mem_phys;
>   	struct pci_epf_bar	*epf_bar[PCI_STD_NUM_BARS];
> +
> +	/* MSI outbound iATU state */
> +	bool			msi_iatu_mapped;
> +	u64			msi_msg_addr;
> +	size_t			msi_map_size;
>   };
>   
>   struct dw_pcie_ops {


