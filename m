Return-Path: <linux-pci+bounces-10491-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A23B2934841
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 08:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20E851F215C2
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 06:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19ACA6EB7D;
	Thu, 18 Jul 2024 06:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iafXJI0j"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D775FB8A;
	Thu, 18 Jul 2024 06:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721285031; cv=none; b=onS3V20PhPGXi+B9B4vh/ysRQLzCLmitdM8hf2JWKnirFspTFobhGCJJzCbNJiR5lDGzRETuvG3S8i7DjcIZTBfB3Iq1seDoTqzOxhJXrttUaH5n71vREomfqkHhbOwIbSbHXyDCZs9gM+0WKlMFMpIcxf3mvODpu/EuYqlIegE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721285031; c=relaxed/simple;
	bh=jyY9+99v2YwBKp1b/vSnaYlfjK379yRxOnO+QtRYWO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=P0xAHduFgwUDLZSt8yiftgT+LN0f8FJUhlq79YwocQpsh58gvDQnL/AaswDWJqDKsDF2uC0M92zYKXsza81KMjD9L8v+joZlpDY0/pbcGWO5k0vV1qZdVfBTuPO6/PRWpkOChZ9nHdI4CGWw7ScFDc3faEmLOYaAfqV8hp6Sky8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iafXJI0j; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46I1FLKU001753;
	Thu, 18 Jul 2024 06:43:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FzHd8BfRF/tt9UYrgZHqu1HlvsI5sz3lmgH0cRhUT8w=; b=iafXJI0jDrtFJwvc
	KIVPIuDcQ+SvbkIpHeZxSDQkyw+6u7rieu3AleQBYI6lgKERPwhCEhahO4vt33jY
	T7y7aEBScn+YjOXtnrKopCOOk7uE22qwb++fNn7EYbGZKK6R7x0UGA0L27z+7YTD
	+ssn8suFyOPiJX84ERa5hWk8VJnQhWLjTrqAsotXSCGAtah/S2uCXTKH11oxemx6
	kBP0CBTc+d1LjnyQtSgLdGR9Zv/Ql8oik8Dnh4SCx9cgZi4IBtV9A8hv4ieUb8AP
	TDP/Rc/CetT2s4h1owf9Z7vnCcg8H10Qaef9klN5e9a1ajHAlOaogg15gzr85Lp3
	YT3xqQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40es1wrj23-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 06:43:43 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46I6hhOH004524
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 06:43:43 GMT
Received: from [10.151.37.100] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 17 Jul
 2024 23:43:37 -0700
Message-ID: <de9f2ab7-e6d0-4c59-8653-c60d9f5a2a33@quicinc.com>
Date: Thu, 18 Jul 2024 12:13:34 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 4/4] PCI: qcom: Add support for IPQ9574
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        devi priya
	<quic_devipriy@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Anusha Rao <quic_anusha@quicinc.com>
References: <20240716092347.2177153-1-quic_srichara@quicinc.com>
 <20240716092347.2177153-5-quic_srichara@quicinc.com>
 <20240717083856.GD2574@thinkpad>
Content-Language: en-US
From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <20240717083856.GD2574@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ufqeYTtQOUeouqgZUXXrvP064jfAI_zQ
X-Proofpoint-ORIG-GUID: ufqeYTtQOUeouqgZUXXrvP064jfAI_zQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-18_03,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 mlxscore=0 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407180044



On 7/17/2024 2:08 PM, Manivannan Sadhasivam wrote:
> On Tue, Jul 16, 2024 at 02:53:47PM +0530, Sricharan R wrote:
>> From: devi priya <quic_devipriy@quicinc.com>
>>
>> The IPQ9574 platform has four Gen3 PCIe controllers:
>> two single-lane and two dual-lane based on SNPS core 5.70a.
>>
>> QCOM IP rev is 1.27.0 and Synopsys IP rev is 5.80a.
>> Add a new compatible 'qcom,pcie-ipq9574' and 'ops_1_27_0'
>> which reuses all the members of 'ops_2_9_0' except for the
>> post_init as the SLV_ADDR_SPACE_SIZE configuration differs
>> between 2_9_0 and 1_27_0.
>>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
>> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
>> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
>> Signed-off-by: devi priya <quic_devipriy@quicinc.com>
>> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>> ---
>>   [V6] Fixed all Manivannan's and Bjorn Helgaas comments.
>>        Removed the SLV_ADDR_SPACE_SZ_1_27_0 macro to have default value.
>>
>>   drivers/pci/controller/dwc/pcie-qcom.c | 31 ++++++++++++++++++++++----
>>   1 file changed, 27 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>> index 0180edf3310e..26acd9f5385e 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -1116,16 +1116,13 @@ static int qcom_pcie_init_2_9_0(struct qcom_pcie *pcie)
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
>> @@ -1165,6 +1162,18 @@ static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
>>   	return 0;
>>   }
>>   
>> +static int qcom_pcie_post_init_1_27_0(struct qcom_pcie *pcie)
>> +{
>> +	return qcom_pcie_post_init(pcie);
>> +}
>> +
>> +static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
>> +{
>> +	writel(SLV_ADDR_SPACE_SZ, pcie->parf + PARF_SLV_ADDR_SPACE_SIZE);
>> +
> As discussed in [1], DBI/ATU mirroring should be disabled completely to avoid
> the enumeration issue you are seeing on this platform. Please rebase on top of
> the referenced patch (once v2 gets posted).
ok, got it.

Regards,
  Sricharan

