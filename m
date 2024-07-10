Return-Path: <linux-pci+bounces-10097-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCA492DA01
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 22:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C959C2866CD
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 20:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E23F198841;
	Wed, 10 Jul 2024 20:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QBPG2a2e"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73621198821;
	Wed, 10 Jul 2024 20:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720643354; cv=none; b=p9hYn4aIrmiJtgJn8rYhnCtPtjuUIIlyS71nZi7JNeWiKk2geBoso8hBkcRqOmiTDP2iGBiGi+sUeeQV+mvmYbgNHpG2IQ/AZi5CznTedd/Vo/lTvv9beiwttHLynQGFydP0sbHX7It5vsOtcK7S6/PGu04IaUyPBMTO23CuUNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720643354; c=relaxed/simple;
	bh=Ab4dyjGo3s7pHsz5/ulNmvnZqavLu3mWbxo6X+2wGGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=C+tY7gcaNhgBBVzqfbDQbRO1I7yDfZ85y9f/Bm7/Z1HWioKo1prAF5zmGnjTyCa2+WdhPu2R/ZkOy4RIvREf37A/l0WzB9mcdHx8q2os5v6QaiNTM5z8YTfWBvOIGM/RqF5oMFb0mbrkEo7G1hOHGoTlUoihG1uV5NNCHoIkbQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QBPG2a2e; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46ACnK06024771;
	Wed, 10 Jul 2024 20:29:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/C8Dd1IaJCe5rvJYmcGSvfztZGrxmsF+Dg8Fz7OEvrQ=; b=QBPG2a2e+XFF/AC0
	5e5/TmUUqL5KZ3SgC7/bG6khgNcfPBiy0B9acSAeI2Q2akr5XpSYpR8GpHmJEvIL
	vS/0/yBfXwFgFXc/aTifUfrB13FvMyTiC3A2969hoJnPDj3nIgjHEKsQphZEv8Na
	/6rqKfIDdwlvHKOKMrX+5WHd4CFqGL+A/fepTopBQ5H0dgrDwswHPNn0ap4ubdsT
	U/cZEXpJ9BZUgSacrHYbBXogEZLU88zfuBuu+KKsPkm7z97MioVow8LuSNSWRTt9
	CTs5jv6NFObacvaZTqkHYv2DQPHzdFs/KWmg/bvqnrT7GExjmml0tUMdsDdNbxAM
	OjS+bw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 409kdtj818-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 20:29:01 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46AKSxpF023891
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 20:28:59 GMT
Received: from [10.110.41.85] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 10 Jul
 2024 13:28:58 -0700
Message-ID: <0d659413-1122-402a-bf85-aa9abb720850@quicinc.com>
Date: Wed, 10 Jul 2024 13:28:58 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/4] PCI: qcom-ep: Add support for D-state change
 notification
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        "Manivannan
 Sadhasivam" <manivannan.sadhasivam@linaro.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I
	<kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet
	<corbet@lwn.net>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring
	<robh@kernel.org>
CC: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <mhi@lists.linux.dev>, <quic_vbadigan@quicinc.com>,
        <quic_ramkri@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_parass@quicinc.com>,
        Manivannan Sadhasivam
	<mani@kernel.org>
References: <20240710-dstate_notifier-v7-0-8d45d87b2b24@quicinc.com>
 <20240710-dstate_notifier-v7-2-8d45d87b2b24@quicinc.com>
Content-Language: en-US
From: Mayank Rana <quic_mrana@quicinc.com>
In-Reply-To: <20240710-dstate_notifier-v7-2-8d45d87b2b24@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: bIS7u-y-X3Zr1nM-Owgr6W3JVQHyygWi
X-Proofpoint-GUID: bIS7u-y-X3Zr1nM-Owgr6W3JVQHyygWi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_15,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 impostorscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407100145



On 7/10/2024 4:08 AM, Krishna chaitanya chundru wrote:
> Add support to pass D-state change notification to Endpoint
> function driver.
> Read perst value to determine if the link is in D3Cold/D3hot.
> 
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>   drivers/pci/controller/dwc/pcie-qcom-ep.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> index 236229f66c80..817fad805c51 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> @@ -648,6 +648,7 @@ static irqreturn_t qcom_pcie_ep_global_irq_thread(int irq, void *data)
>   	struct device *dev = pci->dev;
>   	u32 status = readl_relaxed(pcie_ep->parf + PARF_INT_ALL_STATUS);
>   	u32 mask = readl_relaxed(pcie_ep->parf + PARF_INT_ALL_MASK);
> +	pci_power_t state;
>   	u32 dstate, val;
>   
>   	writel_relaxed(status, pcie_ep->parf + PARF_INT_ALL_CLEAR);
> @@ -671,11 +672,16 @@ static irqreturn_t qcom_pcie_ep_global_irq_thread(int irq, void *data)
>   		dstate = dw_pcie_readl_dbi(pci, DBI_CON_STATUS) &
>   					   DBI_CON_STATUS_POWER_STATE_MASK;
>   		dev_dbg(dev, "Received D%d state event\n", dstate);
> -		if (dstate == 3) {
> +		state = dstate;
> +		if (dstate == PCI_D3hot) {
>   			val = readl_relaxed(pcie_ep->parf + PARF_PM_CTRL);
>   			val |= PARF_PM_CTRL_REQ_EXIT_L1;
>   			writel_relaxed(val, pcie_ep->parf + PARF_PM_CTRL);
Can you please also check that do we really need to bring link back out 
of L1/L1SS on receiving D3 hot ?
> +			if (gpiod_get_value(pcie_ep->reset))
> +				state = PCI_D3cold;
>   		}
> +		pci_epc_dstate_notify(pci->ep.epc, state);
>   	} else if (FIELD_GET(PARF_INT_ALL_LINK_UP, status)) {
>   		dev_dbg(dev, "Received Linkup event. Enumeration complete!\n");
>   		dw_pcie_ep_linkup(&pci->ep);
> 

Regards,
Mayank

