Return-Path: <linux-pci+bounces-17240-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D17829D6C72
	for <lists+linux-pci@lfdr.de>; Sun, 24 Nov 2024 02:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 595EE161649
	for <lists+linux-pci@lfdr.de>; Sun, 24 Nov 2024 01:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8F215E8B;
	Sun, 24 Nov 2024 01:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="phwr6oYV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBE82F26;
	Sun, 24 Nov 2024 01:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732412673; cv=none; b=nDkRcDyX5s/Y45f9FkxJ9vrR3LP/ghJqlwyG+tZNjGc6u86q7L3La9kZk1BrzX8xTyMexFIGpTcaeNLfNYdPQ0pC7WLXpix0eEX/JpH9yLP1Eky94HJQLmZbKOdKaF1J+gJIcPwYn5IuppYQcMuRolFjHLTx+LSzOPBXNsuizJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732412673; c=relaxed/simple;
	bh=HfTua57kegNRfT6STmuD15q6lJAvFdxokP/cBoAzAfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=B5YzV8VrUETHnTCW6PWWBKV9FV0RVOriLJSCkDxLUH3XWvGLPBjV5APrjYzY7TJ3rtvNL1BUKJ46dIpKc1shu5x8xr8f+GhNYiG2hQveqwL6F1s2NlX+Gs7/ePFOrHhoYDPExgW9hOXDKFuoskpkEX8cfJ+CkrRdgu+SvAL5Atk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=phwr6oYV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AO0F12h006558;
	Sun, 24 Nov 2024 01:44:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+e7MoueAaCrUQ0s0RkvzIxfJfB32OKnEoD9FCsA0ZUk=; b=phwr6oYVBy3vxCJ+
	JroeWYG3mqGivh7vVKkPcxuRXn1oQFpOp6j8dAwzgWLDF1SmiK75g4FeQna6NIpm
	Ab8TwkqtJBdyz7wqwfBoxV35HgNYQNbXS0j3PvKTh/LXMgJv1QpI4KtXh1qwKk45
	2rErlgmk4+nlCVdahKP9gKpEtMAY0AJf/Nd7gLHDkghD7gx2nOZyQGVl/pSq5Pl6
	W2q8wThDTMpKUuy0YMRE3FjnNsoMVtHHZEvg29eTGSTNHGyCZbx/bNiKdClPDjYj
	Yp3iYBjAyp22IthBJObFSKrNyeI0M2Ggalsau8nL7Ttw8SpmVRqZA0jXhWAnxI0S
	1Q/v9w==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4334rd1qkv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 24 Nov 2024 01:44:23 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AO1iNpC012418
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 24 Nov 2024 01:44:23 GMT
Received: from [10.216.29.212] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 23 Nov
 2024 17:44:17 -0800
Message-ID: <e0ed1805-a5ba-4bed-d0df-d5f8f09a1b5f@quicinc.com>
Date: Sun, 24 Nov 2024 07:14:14 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 5/6] PCI: qcom: Add support for host_stop_link() &
 host_start_link()
Content-Language: en-US
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: <andersson@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        "Lorenzo
 Pieralisi" <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?=
	<kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>,
        <cros-qcom-dts-watchers@chromium.org>,
        Jingoo Han
	<jingoohan1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, <quic_vbadigan@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241112-qps615_pwr-v3-0-29a1e98aa2b0@quicinc.com>
 <20241112-qps615_pwr-v3-5-29a1e98aa2b0@quicinc.com>
 <20241115115729.wmcohbbc6sl4il3e@thinkpad>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20241115115729.wmcohbbc6sl4il3e@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: eyKfJMKNIinCvmMyIerXsX3MPT6VLrYk
X-Proofpoint-GUID: eyKfJMKNIinCvmMyIerXsX3MPT6VLrYk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 adultscore=0 impostorscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411240013



On 11/15/2024 5:27 PM, Manivannan Sadhasivam wrote:
> On Tue, Nov 12, 2024 at 08:31:37PM +0530, Krishna chaitanya chundru wrote:
>> For the switches like QPS615 which needs to configure it before
>> the PCIe link is established.
>>
>> If the link is up, the boatloader might powered and configured the
>> endpoint/switch already. In that case don't touch PCIe link else
>> assert the PERST# and disable LTSSM bit so that PCIe controller
>> will not participate in the link training as part of host_stop_link().
>>
>> De-assert the PERST# and enable LTSSM bit back in host_start_link().
>>
>> Introduce ltssm_disable function op to stop the link training.
>>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-qcom.c | 39 ++++++++++++++++++++++++++++++++++
>>   1 file changed, 39 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>> index ef44a82be058..048aea94e319 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -246,6 +246,7 @@ struct qcom_pcie_ops {
>>   	void (*host_post_init)(struct qcom_pcie *pcie);
>>   	void (*deinit)(struct qcom_pcie *pcie);
>>   	void (*ltssm_enable)(struct qcom_pcie *pcie);
>> +	void (*ltssm_disable)(struct qcom_pcie *pcie);
>>   	int (*config_sid)(struct qcom_pcie *pcie);
>>   };
>>   
>> @@ -617,6 +618,41 @@ static int qcom_pcie_post_init_1_0_0(struct qcom_pcie *pcie)
>>   	return 0;
>>   }
>>   
>> +static int qcom_pcie_host_start_link(struct dw_pcie *pci)
>> +{
>> +	struct qcom_pcie *pcie = to_qcom_pcie(pci);
>> +
>> +	if (!dw_pcie_link_up(pcie->pci))  {
> 
> I don't think the controller driver should worry about the bootloader
> initialization. You should export dw_pcie_link_up() as a callback and call
> start/stop link if only required (link not up) from the pwrctl driver.
>
Instead of exporting this API, I will try to read config space and see 
if the link is up or not. if it is not up then will call these.

- Krishna Chaitanya.

> - Mani
> 
>> +		qcom_ep_reset_deassert(pcie);
>> +
>> +		if (pcie->cfg->ops->ltssm_enable)
>> +			pcie->cfg->ops->ltssm_enable(pcie);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void qcom_pcie_host_stop_link(struct dw_pcie *pci)
>> +{
>> +	struct qcom_pcie *pcie = to_qcom_pcie(pci);
>> +
>> +	if (!dw_pcie_link_up(pcie->pci))  {
>> +		qcom_ep_reset_assert(pcie);
>> +
>> +		if (pcie->cfg->ops->ltssm_disable)
>> +			pcie->cfg->ops->ltssm_disable(pcie);
>> +	}
>> +}
>> +
>> +static void qcom_pcie_2_3_2_ltssm_disable(struct qcom_pcie *pcie)
>> +{
>> +	u32 val;
>> +
>> +	val = readl(pcie->parf + PARF_LTSSM);
>> +	val &= ~LTSSM_EN;
>> +	writel(val, pcie->parf + PARF_LTSSM);
>> +}
>> +
>>   static void qcom_pcie_2_3_2_ltssm_enable(struct qcom_pcie *pcie)
>>   {
>>   	u32 val;
>> @@ -1361,6 +1397,7 @@ static const struct qcom_pcie_ops ops_1_9_0 = {
>>   	.host_post_init = qcom_pcie_host_post_init_2_7_0,
>>   	.deinit = qcom_pcie_deinit_2_7_0,
>>   	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
>> +	.ltssm_disable = qcom_pcie_2_3_2_ltssm_disable,
>>   	.config_sid = qcom_pcie_config_sid_1_9_0,
>>   };
>>   
>> @@ -1418,6 +1455,8 @@ static const struct qcom_pcie_cfg cfg_sc8280xp = {
>>   static const struct dw_pcie_ops dw_pcie_ops = {
>>   	.link_up = qcom_pcie_link_up,
>>   	.start_link = qcom_pcie_start_link,
>> +	.host_start_link = qcom_pcie_host_start_link,
>> +	.host_stop_link = qcom_pcie_host_stop_link,
>>   };
>>   
>>   static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
>>
>> -- 
>> 2.34.1
>>
> 

