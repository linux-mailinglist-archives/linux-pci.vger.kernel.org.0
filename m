Return-Path: <linux-pci+bounces-43290-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A32CCBC88
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 13:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 652E4301E188
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 12:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E8F32E735;
	Thu, 18 Dec 2025 12:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="asepEsiO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gLPaqNvi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A6F32ED33
	for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 12:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766060860; cv=none; b=rgBwPvfYftd6gebrzGG3NtvtRUKdSAwGyCy833HfMeman9PfRUZiocTwDLCWeCiyjM65jLZdSbZZuxaqNSSfheQLuJuLS4tJDJ+fhcymqbi8rpP+jOJLXCTRM2/xA6wzAfA4De2KfNDDVmM9I7X8NF1jSxcL+WcP0/W+zqD38UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766060860; c=relaxed/simple;
	bh=gxqd/Cknq4GHduWkmglMeRYPbQ1CBWMJnYnU8qrYblQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qxKg/vyqGaE2zJ+GEh736DLxO5WOq1Ww5SDhnuAn2el3oSH9nqzpdlP+3L43Z4cBSp+Hw6zeJ0eTZBJL3CpKRn86CuNV7CeThEwBBIlITSImaXfRtQwbY1TnKxldR45B4rwwowo8XwTMGbhHVyuo0cbfhqX6BXkuFANNfvzU6Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=asepEsiO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gLPaqNvi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BI8swJj680488
	for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 12:27:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Nke1jB7g3bqerrkvuvpBT7m/sV5Z4bOM9LsLmXYBlLY=; b=asepEsiOAE4jHLcc
	pJPw6zZDe67DdPR6s1em4pVsLkS7yCaZ5lpsvoBCGWPIQ0y9ZiMIG5I4VeHRgEpz
	sW2EVX6o6agZfCtj/isgJRmIImcGPThTZKnPK/lfaFlOiCdmDHLP9peDZ1iQUK4y
	QRo3M1ips/k+lqejIyEzIKK8+4HXGCsvgsLJXUCqEOFux6uQE1hdgLdHzOTBZFk3
	GZmoESWAiLd+W0qO2xYJU+2lygpFYas/EToAE2ErRzZ0HH/puWrHym+C4lAENEec
	klf7AbmVCuv+HbRhPQa7t+EcBSOGc5zVgTSrQlRXccJnCCs6PzSTiMvuq4ih0pbZ
	ODzRlw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b45bhj81c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 12:27:37 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a0e9e0fd49so18795365ad.0
        for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 04:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766060856; x=1766665656; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nke1jB7g3bqerrkvuvpBT7m/sV5Z4bOM9LsLmXYBlLY=;
        b=gLPaqNviqQB3O0g9uPMqII3e0IBrSOHHvvGGpYno9ZIfLuVMg8lJf9cBjQANwpMt0m
         He3SpXxdFi4GuN43tSaiwsSsC14OFHUTUaonoVx2SLJYOETswno/lPyf4VS4d4JNu4V7
         Oh2BtQmEc1z4XhOH8kVHpo8HinQHNYvwMB3fzKnGVx3YpeSA80FKjNrpvMxwHGcFpvCH
         ohiRKh2maveP9ELshuE/kTd0MEYQYs100FY359cX4u26maOVokN13oN4R9CcrrOCdzSA
         OF+zjeBjZZaDvWA9NZO/tZAd3sx/UXu5q1KpQBZ++ZYyRxZNHA8fy+B1N/kZ7ceFWHVH
         238A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766060856; x=1766665656;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nke1jB7g3bqerrkvuvpBT7m/sV5Z4bOM9LsLmXYBlLY=;
        b=qgyEUpFVElxafaEjvlrKN/LfE1ynEBI8dW3EWop5Ra9uZ99196KGshbvYehFk+41Ol
         4h8YDUcpnShBVsvKL5ZiTKkZb0afL9HsbvHT55utsjGjnem11/BdJSFZvJSxIdGy3um5
         /0bSmiDHLnwnOYRw7epldJ1aoconAMf2CrlKwAV/fuviuv0/sDtzErrYJOoRMrtHwpeQ
         IG04luvmbM9cuXGrn0RWTkigQx3lAK/+ibqXzavAR2F7pTvi2mdSjeBWexWnxnZPjweO
         Uygh7GvqpiwWR7EfG4LtU4SvGUdMRrulG6vNBhaIYCz+Qny9beif4XQcnxoEJH3ebSTE
         MVuQ==
X-Gm-Message-State: AOJu0YxtsPLiudebUfmolYa3Kf1GMOBrJjDmQjw4SkSZ1+5vEs3mscLb
	GJu0b5FHswysX9v085hpcmZb+IYkkpulb8Fp5qF2VcNUOk9Z+fBFgXI6HtNRtEiT7T2jy27sFmF
	FfancF4IKJD5iXuDZmIqnrW4+WmCQnLqzKclx7dE42XRwrfPZ4q3XFr1T0E6bUQI=
X-Gm-Gg: AY/fxX7wVKLt7LelKbR9ZpikL8GEzRXyo59bpDQrpyuOrpVWuM+SqarKvBVESo6pLsX
	KU2jHHW1sr/tH+7HG3WZhxGZR/GAEzqA4XwoRVHbdoBokUayTcccyyBzqmH+EL0gMgjyXP1Ea8b
	njAC3SSrMIm6k9DqAlGb6bZQsJxrctyQhRslue9ESpguIyhEXPsC0nVfvO9i5XUmLRakqz+bcdb
	7kXiJfU+fXq/SGzm21ry9fGPNppgL9BTN5QOqKb1it7zQJiH2ZMpGIVUSdYhof6sgU2H4J3H4Yd
	OcdQS+RWg/f5RZF7AYZaI5Fj07Zzc7qZGiFjORxyBdtwSlOzE5AB47AN3fy05o7FMewgJjuzPqE
	7haQK5QgsGkG+f5+xw2+y+y/Jv6CI9k+QYOr1UFha8w==
X-Received: by 2002:a17:902:c951:b0:295:28a4:f0c6 with SMTP id d9443c01a7336-2a2ca902bc7mr29120675ad.0.1766060856532;
        Thu, 18 Dec 2025 04:27:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGxsZ5KKM/k1jJXpL4x+24gnjXHUZaN/U/5zUK34RnmcvN9TYgvj0/WoDy6lfsmiEbMOC/o+A==
X-Received: by 2002:a17:902:c951:b0:295:28a4:f0c6 with SMTP id d9443c01a7336-2a2ca902bc7mr29120415ad.0.1766060856013;
        Thu, 18 Dec 2025 04:27:36 -0800 (PST)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2d1926ca3sm24148385ad.83.2025.12.18.04.27.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Dec 2025 04:27:35 -0800 (PST)
Message-ID: <237606b2-783a-4e11-854b-fed787e2903d@oss.qualcomm.com>
Date: Thu, 18 Dec 2025 17:57:30 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] PCI: dwc: Do not return failure if link is in
 Detect.Quiet/Active states
To: manivannan.sadhasivam@oss.qualcomm.com, Jingoo Han
 <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        vincent.guittot@linaro.org, zhangsenchuan@eswincomputing.com
References: <20251218-pci-dwc-suspend-rework-v2-0-5a7778c6094a@oss.qualcomm.com>
 <20251218-pci-dwc-suspend-rework-v2-2-5a7778c6094a@oss.qualcomm.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20251218-pci-dwc-suspend-rework-v2-2-5a7778c6094a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: bklW8f0Giku1y-1FdcjYlVM-44IJHQRT
X-Proofpoint-ORIG-GUID: bklW8f0Giku1y-1FdcjYlVM-44IJHQRT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDEwMyBTYWx0ZWRfX3BjnkukCT6VA
 3/cM/gzfl1hwaR+yXyT9erMCipdT9uqaFLehb3Q9Wufhl/lO47uZWcA3frjwA7CcgVqE50gn8rA
 f3WsugOBdfbv80PaSCt9VWwJ0Ex7NsGDpzEDfBPJD9uKSEki3MizmrESnxfOusSQlUjIo/OOI3z
 KTqflpZ925MTC/mYmIPSC83ip1ED9DE+ywnjL/QydHMhDA/ohnRFZ818hCvxz/fI6dEyJySPs6P
 tnpAgvpIMYqicZaEVwbcxb3iYOV04qg+EXwdii+8ZNwWwC42NWqy50o8qzBvOeZEkP8qicgnHIH
 arZGPXamuDBFVPjXFtx1wYLw4E1RkXwyrECvgzSGnKq3sm42yNuzV6wcvRwcohniUEBGbeFvQb3
 8pmPE7UP6SP+j4mUijMbWqdaU23nBg==
X-Authority-Analysis: v=2.4 cv=SZr6t/Ru c=1 sm=1 tr=0 ts=6943f339 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=W4O9Uj2zEgxfpYwkYKQA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512180103



On 12/18/2025 5:34 PM, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>
> dw_pcie_wait_for_link() API waits for the link to be up and returns failure
> if the link is not up within the 1 second interval. But if there was no
> device connected to the bus, then the link up failure would be expected.
> In that case, the callers might want to skip the failure in a hope that the
> link will be up later when a device gets connected.
>
> One of the callers, dw_pcie_host_init() is currently skipping the failure
> irrespective of the link state, in an assumption that the link may come up
> later. But this assumption is wrong, since LTSSM states other than
> Detect.Quiet and Detect.Active during link training phase are considered to
> be fatal and the link needs to be retrained.
>
> So to avoid callers making wrong assumptions, skip returning failure from
> dw_pcie_wait_for_link() only if the link is in Detect.Quiet or
> Detect.Active states after timeout and also check the return value of the
> API in dw_pcie_host_init().
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>   drivers/pci/controller/dwc/pcie-designware-host.c |  8 +++++---
>   drivers/pci/controller/dwc/pcie-designware.c      | 12 +++++++++++-
>   2 files changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 43d091128ef7..ef6d9ae6eddb 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -670,9 +670,11 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>   	 * If there is no Link Up IRQ, we should not bypass the delay
>   	 * because that would require users to manually rescan for devices.
>   	 */
> -	if (!pp->use_linkup_irq)
> -		/* Ignore errors, the link may come up later */
> -		dw_pcie_wait_for_link(pci);
> +	if (!pp->use_linkup_irq) {
> +		ret = dw_pcie_wait_for_link(pci);
> +		if (ret)
> +			goto err_stop_link;
> +	}
>   
>   	ret = pci_host_probe(bridge);
>   	if (ret)
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 75fc8b767fcc..b58baf26ce58 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -641,7 +641,7 @@ void dw_pcie_disable_atu(struct dw_pcie *pci, u32 dir, int index)
>   
>   int dw_pcie_wait_for_link(struct dw_pcie *pci)
>   {
> -	u32 offset, val;
> +	u32 offset, val, ltssm;
>   	int retries;
>   
>   	/* Check if the link is up or not */
> @@ -653,6 +653,16 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
>   	}
>   
>   	if (retries >= PCIE_LINK_WAIT_MAX_RETRIES) {
> +		/*
> +		 * If the link is in Detect.Quiet or Detect.Active state, it
> +		 * indicates that no device is detected. So return success to
> +		 * allow the device to show up later.
> +		 */
> +		ltssm = dw_pcie_get_ltssm(pci);
> +		if (ltssm == DW_PCIE_LTSSM_DETECT_QUIET ||
> +		    ltssm == DW_PCIE_LTSSM_DETECT_ACT)
> +			return 0;
> +
>   		dev_info(pci->dev, "Phy link never came up\n");
Can you move this print above, as this print is useful for the user to 
know that, link is not up yet.

- Krishna Chaitanya.
>   		return -ETIMEDOUT;
>   	}
>


