Return-Path: <linux-pci+bounces-42712-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DAACA9DC7
	for <lists+linux-pci@lfdr.de>; Sat, 06 Dec 2025 02:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4480A3133AF5
	for <lists+linux-pci@lfdr.de>; Sat,  6 Dec 2025 01:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205822741BC;
	Sat,  6 Dec 2025 01:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aR0C4UvZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NvUrnJ4M"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8214A287506
	for <linux-pci@vger.kernel.org>; Sat,  6 Dec 2025 01:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764984580; cv=none; b=WSwVZEXz1UdRU55S/av5jZwAWUtlsmm8NgGLGIFFCTO7pGEAeLNudYNW0dELrTVpDJ8vI/tQLscdyjMXLZjk8uqKlO89YFoMU9G6Sho1217Zz5si+xC5l24GR5sMLmkJqWZibBFux+eUQwoi4NHw1ImulzaVmmQ0cdbvQbitvgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764984580; c=relaxed/simple;
	bh=SpuuqB3gCY8U4puQyo93dVG7sggojAtMr5PcQZ4msY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YISb/PWY/IvJjLffht9zt4LT/NgDniRjkn7RA+RTQs26vq4UnXAVw4H10g3/pLH57DadRQcUsartmGHs7wCD+7IzhRPDhgY1wTxCEXWGmLSn0MgzSCzM91vRAGPV8LI0YcRLpTpq5U++5avkWX7y/V4TQQ7jhAFwALeUhzjc0go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aR0C4UvZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NvUrnJ4M; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B5K26rA1644614
	for <linux-pci@vger.kernel.org>; Sat, 6 Dec 2025 01:29:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4BYCO2jlSJysGhVZ6+r+Jne2MzWsIDfsr9d93a0qCWY=; b=aR0C4UvZXXESJK1w
	FYdS16AgU9XleZt67eDtoehrncoTbqTSpQtyGWrcEF9jXcUnR6dYaaV7YepBep3b
	LU9ZX/q0d+aB/0Uhk7sBzlPpfgm267KajI4IMehBScJpOlljZDnGUeBSBEd0x007
	dDLFJkd3iGxsm6AN79/vDK6vF8obj8XdTGfvrP2ApqQPG0jqbkFjO3xEH1d+qBgr
	/vBUaRjBl4w/rJWVg1gk9OfgwVIlQ1UiJTU3AQblCo4mHLER0D8MnCjKDvHKyTGq
	FsJG2377vXKLwZuLGrCvucVBD0Ks7FTT3Jfs+LOCbX72JtFFO7/rQMYOA3dz78B8
	8yiITA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4av62u0mh4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 06 Dec 2025 01:29:37 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-bbcf3bd4c8fso1904733a12.0
        for <linux-pci@vger.kernel.org>; Fri, 05 Dec 2025 17:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764984576; x=1765589376; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4BYCO2jlSJysGhVZ6+r+Jne2MzWsIDfsr9d93a0qCWY=;
        b=NvUrnJ4Mw//SOynswYNpmjSkRzlHAOuGe6eKOj8VGsXJDLI/tDvYA2aj1IWdlqcmFH
         OIH3gXv0LP4fIqP+2/mYwwrs8SYiT+Cwh8Ob6zyz5u8xmG1OMhPyFwB/6FpHDmMJ7dNN
         SZA+vU6Rc8E4DqDVdtZi+KAQyF1jqkxcABOU8n9xmCoh54Nu8MUfUSOvX+3zb7Ba4tS0
         vTtqPq972Vi1fSwS6e7k3fEKpcJnxboDMxzzfUAN7l52gpZ7PQg1v6rWDdkKtWBUh7x6
         HRo61lWtsrLcLHk5RwpKN/jiWOsbtfzNgFcjz/DF5coRpqJIJK8NP1efUHUgteB+Vt0p
         gDHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764984576; x=1765589376;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4BYCO2jlSJysGhVZ6+r+Jne2MzWsIDfsr9d93a0qCWY=;
        b=B3KvTDksIdf4uggtjVh3AdhOLnqbmAwS+N1keLvg9UrHCbLQ77BbQEh0JzSejTbPYW
         +Z9XtaORfG5TNjkCU6OglOb1D8v9y4yn6XhCziCVOV7LlyNJWhertBHrMFpxLc+F4Bf8
         5xhKQk2BtSSUyAjRp6O9WLpes/1PFWx5XJuD9ujuVICW4nP1G/OnrNPrt+Whp6NxURPv
         DJnNkwSs9EGlMVI41zLd2d4yRC8o8jqp0GPkbHl2mAHpfHBVpJFzEP3mSoTmkAtGpbYB
         4yFBfWu5m6GhSPFH5gyQmB80svm0vjQI4Xc+qoqbkgZVqXnlT7r9SJSbQItsa14PFvOy
         u40w==
X-Gm-Message-State: AOJu0YwGE7hMqqNXiR79BqvhCQaoAHPy+PWEoGEeOWucyXQMI0fvhd97
	Z1ne2rEa6qfEon00UQUkRZcK3stdqGMiD91KcQ+rX4cuKdR62zGIYqkiwKZ2Bv2rKBmns4LeZWC
	bzBZwSubOzaZeW91ulh+XsaZvvWzjQRLVflh2ve9BYcjsKYV7vF/5FHv1hs3R+ngQ5vCVy+A=
X-Gm-Gg: ASbGncu1gf5wZcfTsXNZzWU3LuLDHt1RPCt37lWtpWM5nHQJrTsMCKbMkTX9hqd2/ii
	srn8tsV+VNrgLWs4nKjslfs8kORtgCWrhLLPb5B5GNHtxJB6PJmGkOOABfvRqARzFTNOMASKgmY
	NfAmFnyF1cORZJPgRw78HKMomcbF9+6xDTexsP6Pc17/+VCFtfJv7d8RMR+9rgG9nFDO/EhEl3E
	afD6vLQV7bGzftKQkg1h7FEk9os+VSVY0dDNF/Fkns7mgsz0yaDbSqD+8zVZUyQGT845LlDEwX7
	SnY5P+gFNuzI92cbIL+Ouj0ww7tteNFc04C5rZUAKpnQJ6sZ65zykuzpESJjKIg1q4j7UtD7oSl
	M+p2HPYXmYzsyWjtnSMdlMGztc3AKa9lkTMs1sPuHeA==
X-Received: by 2002:a05:6a00:2303:b0:7e8:3fcb:bc44 with SMTP id d2e1a72fcca58-7e8bb06ee59mr1098701b3a.25.1764984575951;
        Fri, 05 Dec 2025 17:29:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG4ghndnLUTwdPbWBg93PiHhWZqYjSRpjlaaHQl1YIklJbUj/BDHblAINfPMFltLyT7dRC5wA==
X-Received: by 2002:a05:6a00:2303:b0:7e8:3fcb:bc44 with SMTP id d2e1a72fcca58-7e8bb06ee59mr1098679b3a.25.1764984575442;
        Fri, 05 Dec 2025 17:29:35 -0800 (PST)
Received: from [192.168.29.63] ([49.43.226.9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7e2adc5c355sm6308508b3a.33.2025.12.05.17.29.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Dec 2025 17:29:35 -0800 (PST)
Message-ID: <a9b02517-0743-4716-8ffe-e2120d9c611a@oss.qualcomm.com>
Date: Sat, 6 Dec 2025 06:59:28 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PCI: rzg3s-host: Use pci_generic_config_write() for
 the root bus
To: Claudiu <claudiu.beznea@tuxon.dev>, bhelgaas@google.com,
        lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
        robh@kernel.org
Cc: linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        Bjorn Helgaas <helgaas@kernel.org>
References: <20251205112443.1408518-1-claudiu.beznea.uj@bp.renesas.com>
 <20251205112443.1408518-2-claudiu.beznea.uj@bp.renesas.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20251205112443.1408518-2-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: uueE3PmaZtQLCETF3ve3XREZgTjvjObx
X-Authority-Analysis: v=2.4 cv=VMPQXtPX c=1 sm=1 tr=0 ts=69338701 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=gtzuW6mAKwlXd79hODmrug==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=yC-0_ovQAAAA:8 a=VwQbUJbxAAAA:8
 a=LsleVm4LR1ejaCuuDOAA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAwOSBTYWx0ZWRfX9Z5O1tPrYowd
 nuvCYhJ3KUrXA6oJ+JIg1aKOffiKZ9X4mTf+JusZuLllmGGV+gDScbyAGaRuF/GIRm39X1aiBsv
 zi0jkPa3UnqHrsci+Z4cZMU9+uwdP90fdv17QHgO6/Z5Iv5htbsWvU+7lsWx10DAYBk4HCZAert
 YFs6A+mhD/3++oOz/vNjSDFOofSWbpXHWzZ/tUHsBZvnSoREhC/bNerPAC98ub6xEr8w2YMzyGh
 PmgKMRMuQPu5VZe28yCE0MB2NTNzM6c24vAO1IE2lTKko+RdfqAD/j5rJ/wZDMkHpDrBr64r+tm
 MuCpsIGPFGl7Vif5M79wHXD/Ca3wEw7baBFSlJVsTI0eAG8fVT4iAYQB0NH3iuPLSrRkQWICoF9
 Lj2hPZwQaV7AnddWJwSdWHQZ4BqZqA==
X-Proofpoint-GUID: uueE3PmaZtQLCETF3ve3XREZgTjvjObx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_09,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0 impostorscore=0
 bulkscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512060009



On 12/5/2025 4:54 PM, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> The Renesas RZ/G3S host controller allows writing to read-only PCIe
> configuration registers when the RZG3S_PCI_PERM_CFG_HWINIT_EN bit is set in
> the RZG3S_PCI_PERM register. However, callers of struct pci_ops::write
> expect the semantics defined by the PCIe specification, meaning that writes
> to read-only registers must not be allowed.
>
> The previous custom struct pci_ops::write implementation for the root bus
> temporarily enabled write access before calling pci_generic_config_write().
> This breaks the expected semantics.
>
> Remove the custom implementation and simply use pci_generic_config_write().
>
> Along with this change, the updates of the PCI_PRIMARY_BUS,
> PCI_SECONDARY_BUS, and PCI_SUBORDINATE_BUS registers were moved so that
> they no longer depends on the RZG3S_PCI_PERM_CFG_HWINIT_EN bit in the
> RZG3S_PCI_PERM_CFG register, since these registers are R/W.
>
Don't you need fixes tag and back port to stable kernels, this patch 
looks like a bug fix.

- Krishna Chaitanya.
> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>   drivers/pci/controller/pcie-rzg3s-host.c | 27 ++++--------------------
>   1 file changed, 4 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
> index 667e6d629474..547cbe676a25 100644
> --- a/drivers/pci/controller/pcie-rzg3s-host.c
> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
> @@ -439,28 +439,9 @@ static void __iomem *rzg3s_pcie_root_map_bus(struct pci_bus *bus,
>   	return host->pcie + where;
>   }
>   
> -/* Serialized by 'pci_lock' */
> -static int rzg3s_pcie_root_write(struct pci_bus *bus, unsigned int devfn,
> -				 int where, int size, u32 val)
> -{
> -	struct rzg3s_pcie_host *host = bus->sysdata;
> -	int ret;
> -
> -	/* Enable access control to the CFGU */
> -	writel_relaxed(RZG3S_PCI_PERM_CFG_HWINIT_EN,
> -		       host->axi + RZG3S_PCI_PERM);
> -
> -	ret = pci_generic_config_write(bus, devfn, where, size, val);
> -
> -	/* Disable access control to the CFGU */
> -	writel_relaxed(0, host->axi + RZG3S_PCI_PERM);
> -
> -	return ret;
> -}
> -
>   static struct pci_ops rzg3s_pcie_root_ops = {
>   	.read		= pci_generic_config_read,
> -	.write		= rzg3s_pcie_root_write,
> +	.write		= pci_generic_config_write,
>   	.map_bus	= rzg3s_pcie_root_map_bus,
>   };
>   
> @@ -1065,14 +1046,14 @@ static int rzg3s_pcie_config_init(struct rzg3s_pcie_host *host)
>   	writel_relaxed(0xffffffff, host->pcie + RZG3S_PCI_CFG_BARMSK00L);
>   	writel_relaxed(0xffffffff, host->pcie + RZG3S_PCI_CFG_BARMSK00U);
>   
> +	/* Disable access control to the CFGU */
> +	writel_relaxed(0, host->axi + RZG3S_PCI_PERM);
> +
>   	/* Update bus info */
>   	writeb_relaxed(primary_bus, host->pcie + PCI_PRIMARY_BUS);
>   	writeb_relaxed(secondary_bus, host->pcie + PCI_SECONDARY_BUS);
>   	writeb_relaxed(subordinate_bus, host->pcie + PCI_SUBORDINATE_BUS);
>   
> -	/* Disable access control to the CFGU */
> -	writel_relaxed(0, host->axi + RZG3S_PCI_PERM);
> -
>   	return 0;
>   }
>   


