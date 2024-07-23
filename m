Return-Path: <linux-pci+bounces-10631-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E79BC9398B8
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2024 05:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3E95282982
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2024 03:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADFB13B58D;
	Tue, 23 Jul 2024 03:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CPTBUqOo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4D42C9D;
	Tue, 23 Jul 2024 03:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721705882; cv=none; b=N22xfERxfcxMcZcYFd3R/V+sBsPivw6X9hzojzi6UJmAwRqS0cq7z0GHVDsWJnMsA3Ci3Ag07dzvs2OxOETToLtDOepp9yMa2KZqMeINPHARsdbEJU08U7hYWKyU4JaVc1NfBlSDL2uBWzbJPLLFb5G9QT+VSFoMBx+Qx3NBMJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721705882; c=relaxed/simple;
	bh=av4nnq2UyFrGFqUgLcItP/04XGvmpJVv15UHd5UAA8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dt4l7diE25eqN9LOkxstcsjZckKxdhOgZRs6ckgdrUefB5RDe5lZUvKDEBZ1lgHVdHOtNQM6M9cqnVazCooWM/iWQaiEKuBW6z/gcNb+ye4zP3z51t1mO3RaR1Hr+5wJLbS2t1ZeBwShht3RbtICW5cCVnd6GLrtyTAPWAd+bYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CPTBUqOo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46MJNjwc014036;
	Tue, 23 Jul 2024 03:37:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZlgAt45pyKKvWtNr9nbveSfR/vxlIg0Z3D2jQe/f9PU=; b=CPTBUqOo07AbodG5
	ERZrTUp10big1uYFflAXrCWrUSw/RKe9nSj6fwAQamcJaB8BVLy2/GOuV0ChtwlA
	75hmyTLWdQqzoAUJtMCAO6dnLVWff4N8Ul8FxOeNk5wIb72zlwEqkUpqCHtjc8Bp
	fVkUQDJ9DJv2yuinkW3wbCiR2YkArAalSXme6ySTeQoSIftoI/j82qNJQuhJdcwR
	5ab8fAloyJdQpTqRjwPPZWDI6SWN639FjMnSFGLQmEWe9/Vq5EFdcbVHhcHOlz5P
	clzS0srWYwLKEZY9sPYdc8wkTjcU39s2Pxhl30mFhFAMKng9DgDW0E2RmjtxVTyQ
	mHdtOw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40g5m6wjd2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 03:37:42 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46N3bekP004658
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 03:37:40 GMT
Received: from [10.216.60.30] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 22 Jul
 2024 20:37:35 -0700
Message-ID: <4662b4fb-8ef2-4a4b-adef-e862090defd7@quicinc.com>
Date: Tue, 23 Jul 2024 09:07:32 +0530
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
From: Yogesh Jadav <quic_yjadav@quicinc.com>
In-Reply-To: <20240710-dstate_notifier-v7-2-8d45d87b2b24@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: t283ZWU0wXzkdRumSYbkiu-xLkwsxvHu
X-Proofpoint-ORIG-GUID: t283ZWU0wXzkdRumSYbkiu-xLkwsxvHu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_18,2024-07-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1011 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407230025



On 7/10/2024 4:38 PM, Krishna chaitanya chundru wrote:
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
Can we use some meaningful name for variable "state" ? There is 
different purpose of variable "state" and "dstate" which is not getting 
reflected by looking variable names.

- Yogesh
> +		if (dstate == PCI_D3hot) {
>   			val = readl_relaxed(pcie_ep->parf + PARF_PM_CTRL);
>   			val |= PARF_PM_CTRL_REQ_EXIT_L1;
>   			writel_relaxed(val, pcie_ep->parf + PARF_PM_CTRL);
> +
> +			if (gpiod_get_value(pcie_ep->reset))
> +				state = PCI_D3cold;
>   		}
> +		pci_epc_dstate_notify(pci->ep.epc, state);
>   	} else if (FIELD_GET(PARF_INT_ALL_LINK_UP, status)) {
>   		dev_dbg(dev, "Received Linkup event. Enumeration complete!\n");
>   		dw_pcie_ep_linkup(&pci->ep);
> 

