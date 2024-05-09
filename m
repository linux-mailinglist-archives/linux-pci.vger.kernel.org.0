Return-Path: <linux-pci+bounces-7308-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BAC8C14CD
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2024 20:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0D991F21467
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2024 18:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C44C73535;
	Thu,  9 May 2024 18:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jVfJY8Iv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBDEC2ED;
	Thu,  9 May 2024 18:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715279699; cv=none; b=pYGeHbIkvsVKw3qnhhikMuMVyc4RSUlEajMtNa83c120b6O7ZJTIKTQKGuHCL4Lln/nKSO50Ovjc/5IZVvTmIO9bK3nfxPrnWGy8wUAkhpfp2XoIKnzoa4Pt+7bRBVhfkXLPebujOG4Fku4AE+vQoHcFOZc21op0z3SO4/aVFlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715279699; c=relaxed/simple;
	bh=i06qz+Ewc1F2GzNxYBKo2Ffrx2bf5FSB8oMTTxYIVPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cp8YtONmCcXyXIRh6yyaC2V5tM4f5Fqtr/aWN6s0kgqeH4x5WcSK1R6XJjJ86sqsErGuD+qUKGfJRnpqtFi6wTPfZUEtottewFuaD3WTFe1Xi/Nl4CwPB+UzuiSjSBQvxKMHRNf+aIaUN2KBSFADiLGJLskC8ftbo7H7Z9BTI4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jVfJY8Iv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 449F8ZrK019979;
	Thu, 9 May 2024 18:34:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=99WYyI9vlXZSEFdK7/orUJbo3u1ic/cbbZEy9v9qzxo=; b=jV
	fJY8IvObaakyRANoXA6UjZsMye8djuXXRfgCIaRj6UA2fw8u5zNJMTsvAp3tHAJy
	dL/v7CWpMhR2bPQPH6p8xdjTQebD7g9DsEc5o7n7RUEz7x+NNHy0DQZ9psuM9lQP
	PTOqDrOlj2bWLwXZYBoO/YjPuNpU8qcMHmYpGsDYSIlBoxyOo12ObN6UruqfdDtG
	wOROC4btHqudOuYmwRG6oinQA2EH016nWkEX8Cf9NQquyFsKAokg3Jjbppux3LFB
	NhGy5zRDzHvY14TJS+JeueAdxJaGO7JpBl9+1ODOrfJWcgS4rm6pjJZo0av0zQ75
	ZfN/CEODisy0ohl8RJ1A==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y09g5kbed-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 May 2024 18:34:33 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 449IYWTg018499
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 9 May 2024 18:34:32 GMT
Received: from [10.110.110.113] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 9 May 2024
 11:34:31 -0700
Message-ID: <60e92614-5e56-46c4-ab4f-1f0261a3a9ab@quicinc.com>
Date: Thu, 9 May 2024 11:34:31 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 2/6] PCI: qcom: Add ICC bandwidth vote for CPU to PCIe
 path
Content-Language: en-US
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
	<kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, <johan+linaro@kernel.org>,
        <bmasney@redhat.com>, <djakov@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <vireshk@kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_parass@quicinc.com>, <krzysztof.kozlowski@linaro.org>,
        Bryan O'Donoghue
	<bryan.odonoghue@linaro.org>
References: <20240427-opp_support-v12-0-f6beb0a1f2fc@quicinc.com>
 <20240427-opp_support-v12-2-f6beb0a1f2fc@quicinc.com>
From: Mayank Rana <quic_mrana@quicinc.com>
In-Reply-To: <20240427-opp_support-v12-2-f6beb0a1f2fc@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: WCAhRzdDdrrCuc6XE6SSFZk7BgsvpH83
X-Proofpoint-GUID: WCAhRzdDdrrCuc6XE6SSFZk7BgsvpH83
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-09_10,2024-05-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 mlxlogscore=999 suspectscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405090130

Hi Krishna

On 4/26/2024 6:52 PM, Krishna chaitanya chundru wrote:
> To access the host controller registers of the host controller and the
> endpoint BAR/config space, the CPU-PCIe ICC (interconnect) path should
> be voted otherwise it may lead to NoC (Network on chip) timeout.
> We are surviving because of other driver voting for this path.
> 
> As there is less access on this path compared to PCIe to mem path
> add minimum vote i.e 1KBps bandwidth always which is sufficient enough
> to keep the path active and is recommended by HW team.
> 
> During S2RAM (Suspend-to-RAM), the DBI access can happen very late (while
> disabling the boot CPU). So do not disable the CPU-PCIe interconnect path
> during S2RAM as that may lead to NoC error.
> 
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>   drivers/pci/controller/dwc/pcie-qcom.c | 44 ++++++++++++++++++++++++++++++----
>   1 file changed, 40 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 14772edcf0d3..465d63b4be1c 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -245,6 +245,7 @@ struct qcom_pcie {
>   	struct phy *phy;
>   	struct gpio_desc *reset;
>   	struct icc_path *icc_mem;
> +	struct icc_path *icc_cpu;
>   	const struct qcom_pcie_cfg *cfg;
>   	struct dentry *debugfs;
>   	bool suspended;
> @@ -1409,6 +1410,9 @@ static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
>   	if (IS_ERR(pcie->icc_mem))
>   		return PTR_ERR(pcie->icc_mem);
>   
> +	pcie->icc_cpu = devm_of_icc_get(pci->dev, "cpu-pcie");
> +	if (IS_ERR(pcie->icc_cpu))
> +		return PTR_ERR(pcie->icc_cpu);
>   	/*
>   	 * Some Qualcomm platforms require interconnect bandwidth constraints
>   	 * to be set before enabling interconnect clocks.
> @@ -1418,7 +1422,20 @@ static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
>   	 */
>   	ret = icc_set_bw(pcie->icc_mem, 0, QCOM_PCIE_LINK_SPEED_TO_BW(1));
>   	if (ret) {
> -		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
> +		dev_err(pci->dev, "Failed to set bandwidth for PCIe-MEM interconnect path: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	/*
> +	 * Since the CPU-PCIe path is only used for activities like register
> +	 * access of the host controller and endpoint Config/BAR space access,
> +	 * HW team has recommended to use a minimal bandwidth of 1KBps just to
> +	 * keep the path active.
> +	 */
> +	ret = icc_set_bw(pcie->icc_cpu, 0, kBps_to_icc(1));
> +	if (ret) {
> +		dev_err(pci->dev, "Failed to set bandwidth for CPU-PCIe interconnect path: %d\n",
>   			ret);
Is it needed to undo icc_mem related bus bandwidth vote here ?
>   		return ret;
>   	}
> @@ -1448,7 +1465,7 @@ static void qcom_pcie_icc_update(struct qcom_pcie *pcie)
>   
>   	ret = icc_set_bw(pcie->icc_mem, 0, width * QCOM_PCIE_LINK_SPEED_TO_BW(speed));
>   	if (ret) {
> -		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
> +		dev_err(pci->dev, "Failed to set bandwidth for PCIe-MEM interconnect path: %d\n",
>   			ret);
>   	}
>   }


