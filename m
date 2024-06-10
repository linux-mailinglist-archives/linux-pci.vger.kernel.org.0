Return-Path: <linux-pci+bounces-8506-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEF3901A57
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 07:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E8171C20F9D
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 05:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A53107B3;
	Mon, 10 Jun 2024 05:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jM/6Mk4L"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A6217F6;
	Mon, 10 Jun 2024 05:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717998407; cv=none; b=lb8R8yC0p599inAaOV3yaKh/E9mo68ogX0aP373C1MnhvoDAWddRYbq/e+WlmlbUmFSgLgWH5U4sVZMHj40/gMv9Ulwx2rk0DlClnvNKIUoVL8aimOc6in1vdtUsTRhzy4ZfHb16oFGfd3rL9tzl/q4cTdUpDu6cBudAzENFrIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717998407; c=relaxed/simple;
	bh=XbhYBwVPqpt29+w0LmozsqSODlI6R8kdk85kSFDG0ek=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jyqJMVNZdUdjmecakZwdhZkico1dwTZVVBnBjccSju9WAj9xdiqjz0XlVQwaqqfbQaTmflXbLfxzOBXXSyayrssX70ljqOs29m/BlzZPwAzqsqs0zv5Z5CUt8g7J9IM6g83UP+PaU8EQxvCNzWMTjIhucBvEAqWGeSSOSc9LT34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jM/6Mk4L; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45A3ObdG002331;
	Mon, 10 Jun 2024 05:46:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8+R3FfBVHH53yF1hEFqLmkirCoKue9yVbij80F+66XQ=; b=jM/6Mk4L6Xe53e2n
	8MTasK+YKlzCfP/QfkbAciKjBUL+5Jg+4Ru5KjyeD1PjrYrUPJ8C863Ddg6ufD/E
	gsL+CdSAWM5lC1kHiJNJg4BAKm9Y5KmllN6TeGE6FnrfH7a1qxKBnKv7VEA2foJj
	SSIhGbyLofSaHT1bkvtuF2UCinl298q7zq0+j53eatqDvrEP/tG8+4nFLRw/Zgih
	yMpAOlretpcWhquwpkUvaw4ecEXFXM1mUCgHwV8VkW5VBVOMWrreGfVkdgjdbpvD
	98wfQlkmKlb5pEfBw4rhG3jNnWyIa4S8v3mKnBBGe5wJwpineSBvhtA2mZ7eMBdl
	x9P7zQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ymfcv2ncg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 05:46:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45A5kJQF024800
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 05:46:19 GMT
Received: from [10.50.54.237] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 9 Jun 2024
 22:46:05 -0700
Message-ID: <f42559f5-9d4c-4667-bf0e-7abfd9983c36@quicinc.com>
Date: Mon, 10 Jun 2024 11:15:55 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 6/6] PCI: qcom: Add support for IPQ9574
To: Manivannan Sadhasivam <mani@kernel.org>
CC: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <manivannan.sadhasivam@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
References: <20240512082858.1806694-1-quic_devipriy@quicinc.com>
 <20240512082858.1806694-7-quic_devipriy@quicinc.com>
 <20240530144730.GG2770@thinkpad>
Content-Language: en-US
From: Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <20240530144730.GG2770@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ZlnDledWP7shLPwQ7xvLG6ZXuzoG-dz1
X-Proofpoint-GUID: ZlnDledWP7shLPwQ7xvLG6ZXuzoG-dz1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-10_02,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1011 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406100043



On 5/30/2024 8:17 PM, Manivannan Sadhasivam wrote:
> On Sun, May 12, 2024 at 01:58:58PM +0530, devi priya wrote:
>> The IPQ9574 platform has 4 Gen3 PCIe controllers:
>> two single-lane and two dual-lane based on SNPS core 5.70a
>>
>> The Qcom IP rev is 1.27.0 and Synopsys IP rev is 5.80a
>> Added a new compatible 'qcom,pcie-ipq9574' and 'ops_1_27_0'
>> which reuses all the members of 'ops_2_9_0' except for the post_init
>> as the SLV_ADDR_SPACE_SIZE configuration differs between 2_9_0
>> and 1_27_0.
>>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
>> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
>> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
>> Signed-off-by: devi priya <quic_devipriy@quicinc.com>
>> ---
>>   Changes in V5:
>> 	- Rebased on top of the below series which adds support for fetching
>> 	  clocks from the device tree
>> 	  https://lore.kernel.org/linux-pci/20240417-pci-qcom-clk-bulk-v1-1-52ca19b3d6b2@linaro.org/
>>
>>   drivers/pci/controller/dwc/pcie-qcom.c | 36 +++++++++++++++++++++++---
>>   1 file changed, 32 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>> index 3d2eeff9a876..af36a29c092e 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -106,6 +106,7 @@
>>   
>>   /* PARF_SLV_ADDR_SPACE_SIZE register value */
>>   #define SLV_ADDR_SPACE_SZ			0x10000000
>> +#define SLV_ADDR_SPACE_SZ_1_27_0		0x08000000
> 
> Can you please explain what this value corresponds to? Even though there is an
> old value, I didn't get much info earlier on what it is.

The PARF_SLV_ADDR_SPACE_SIZE register indicates the range of RC accesses
to the EP's memory space. Default PoR value is 16MB, which seems to be 
sufficient for IPQ9574 SoC.
As per the memory map, the memory space corresponding to each PCIe 
region is 128Mb. As the older value corresponds to 256Mb we see PCIe 
enumeration failures.
This register should either be updated to 128Mb(0x8000000) or left at 
the PoR value 16Mb (0x1000000).

Thanks,
Devi Priya
> 
> - Mani
> 
>>   
>>   /* PARF_MHI_CLOCK_RESET_CTRL register fields */
>>   #define AHB_CLK_EN				BIT(0)
>> @@ -1095,16 +1096,13 @@ static int qcom_pcie_init_2_9_0(struct qcom_pcie *pcie)
>>   	return clk_bulk_prepare_enable(res->num_clks, res->clks);
>>   }
>>   
>> -static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
>> +static int qcom_pcie_post_init(struct qcom_pcie *pcie)
>>   {
>>   	struct dw_pcie *pci = pcie->pci;
>>   	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
>>   	u32 val;
>>   	int i;
>>   
>> -	writel(SLV_ADDR_SPACE_SZ,
>> -		pcie->parf + PARF_SLV_ADDR_SPACE_SIZE);
>> -
>>   	val = readl(pcie->parf + PARF_PHY_CTRL);
>>   	val &= ~PHY_TEST_PWR_DOWN;
>>   	writel(val, pcie->parf + PARF_PHY_CTRL);
>> @@ -1144,6 +1142,22 @@ static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
>>   	return 0;
>>   }
>>   
>> +static int qcom_pcie_post_init_1_27_0(struct qcom_pcie *pcie)
>> +{
>> +	writel(SLV_ADDR_SPACE_SZ_1_27_0,
>> +	       pcie->parf + PARF_SLV_ADDR_SPACE_SIZE);
>> +
>> +	return qcom_pcie_post_init(pcie);
>> +}
>> +
>> +static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
>> +{
>> +	writel(SLV_ADDR_SPACE_SZ,
>> +	       pcie->parf + PARF_SLV_ADDR_SPACE_SIZE);
>> +
>> +	return qcom_pcie_post_init(pcie);
>> +}
>> +
>>   static int qcom_pcie_link_up(struct dw_pcie *pci)
>>   {
>>   	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
>> @@ -1297,6 +1311,15 @@ static const struct qcom_pcie_ops ops_2_9_0 = {
>>   	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
>>   };
>>   
>> +/* Qcom IP rev.: 1.27.0  Synopsys IP rev.: 5.80a */
>> +static const struct qcom_pcie_ops ops_1_27_0 = {
>> +	.get_resources = qcom_pcie_get_resources_2_9_0,
>> +	.init = qcom_pcie_init_2_9_0,
>> +	.post_init = qcom_pcie_post_init_1_27_0,
>> +	.deinit = qcom_pcie_deinit_2_9_0,
>> +	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
>> +};
>> +
>>   static const struct qcom_pcie_cfg cfg_1_0_0 = {
>>   	.ops = &ops_1_0_0,
>>   };
>> @@ -1334,6 +1357,10 @@ static const struct qcom_pcie_cfg cfg_sc8280xp = {
>>   	.no_l0s = true,
>>   };
>>   
>> +static const struct qcom_pcie_cfg cfg_1_27_0 = {
>> +	.ops = &ops_1_27_0,
>> +};
>> +
>>   static const struct dw_pcie_ops dw_pcie_ops = {
>>   	.link_up = qcom_pcie_link_up,
>>   	.start_link = qcom_pcie_start_link,
>> @@ -1603,6 +1630,7 @@ static const struct of_device_id qcom_pcie_match[] = {
>>   	{ .compatible = "qcom,pcie-ipq8064-v2", .data = &cfg_2_1_0 },
>>   	{ .compatible = "qcom,pcie-ipq8074", .data = &cfg_2_3_3 },
>>   	{ .compatible = "qcom,pcie-ipq8074-gen3", .data = &cfg_2_9_0 },
>> +	{ .compatible = "qcom,pcie-ipq9574", .data = &cfg_1_27_0 },
>>   	{ .compatible = "qcom,pcie-msm8996", .data = &cfg_2_3_2 },
>>   	{ .compatible = "qcom,pcie-qcs404", .data = &cfg_2_4_0 },
>>   	{ .compatible = "qcom,pcie-sa8540p", .data = &cfg_sc8280xp },
>> -- 
>> 2.34.1
>>
> 

