Return-Path: <linux-pci+bounces-4514-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EB0871C71
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 11:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C1191C22979
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 10:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF7F5CDF1;
	Tue,  5 Mar 2024 10:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fPR76suc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112F058AD0;
	Tue,  5 Mar 2024 10:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709636036; cv=none; b=rcTvzYkq9C5ko1tfJYWoeIQManIDZHEBV3WC+jtPimI3XRTWt1x1o0O8Dwe4gMOqDREXiC3ItWzHtbJd+5+FTzhBHsZpGhFUMXUVeLwf+5SETH2v2hNYCyiqpDbIG8GJeHaudXLo90mjJ0Ffq4SOIYKUpVb7yq1rv9+BGlfyjZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709636036; c=relaxed/simple;
	bh=i4uWsuRa5/4DJKP1MupYCLB+thuPY6zku9TxPsa/2Pc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lLjKQqeH6RVLmrjMboENkmGY5DO/b07nh23THuQNiD6/lNWO5jcd7Y6hoDGGHEIuRU0yTEATBBBJynhPTn9Mp2A13T8lJ7CCkzuc1s9+rtkCAb27ZUJGUZT293KJBJOwT47ex0X5ZtEZsJDMKqw2auYvqOaw5rjib3pvh+mXW+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fPR76suc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4252EW5Y011488;
	Tue, 5 Mar 2024 10:53:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=pXnI3OiNTCdkH18BMDZXDRzlbP1Jbh2GqRwo9zrrAI8=; b=fP
	R76sucuzdB9nmQ8UtkSEKTdzxaCmdZVyT6ojBarfo/IbeXh1YOU3KZMNUr3APNWn
	cEDIgdcqts/3W2WRdZpKCpM/z+VrdgJ74XwkhGjx7Jjfq8SVKOlVnQ9V2MhixXY7
	Z3lrgv8BOavhp168HkA0KwtW4EQfjpneY7hn1qUhu2CJBorCz1XICUl4FO8CbMzP
	fCciNz96osmwdSzBq04d6NujzQ+JM9ivoHxOJl67BbNeLPm6/YLdjyX1NalZTps9
	7dxOjKLEonXpoM1a7EZQPMBY6A8D1mrj2NeBOPsjzscj9Kefr9EcTf5DKscViMR/
	MeW5vnlzMu8i9L5pyO3A==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wnqwhs680-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Mar 2024 10:53:46 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 425ArjiL012602
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 5 Mar 2024 10:53:45 GMT
Received: from [10.216.9.163] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 5 Mar
 2024 02:53:36 -0800
Message-ID: <9d878f69-c9d1-1ee4-f80e-1d8f16c6920e@quicinc.com>
Date: Tue, 5 Mar 2024 16:23:21 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v8 3/7] PCI: qcom: Add ICC bandwidth vote for CPU to PCIe
 path
Content-Language: en-US
To: Manivannan Sadhasivam <mani@kernel.org>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring
	<robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Brian Masney
	<bmasney@redhat.com>, Georgi Djakov <djakov@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vireshk@kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_parass@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
References: <20240302-opp_support-v8-0-158285b86b10@quicinc.com>
 <20240302-opp_support-v8-3-158285b86b10@quicinc.com>
 <20240304174111.GB31079@thinkpad>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20240304174111.GB31079@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VDkcFMikw_XkKE8PvWULLtmg61hONHIK
X-Proofpoint-ORIG-GUID: VDkcFMikw_XkKE8PvWULLtmg61hONHIK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_08,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 mlxlogscore=999
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403050087



On 3/4/2024 11:11 PM, Manivannan Sadhasivam wrote:
> On Sat, Mar 02, 2024 at 09:29:57AM +0530, Krishna chaitanya chundru wrote:
>> To access PCIe registers, PCIe BAR space, config space the CPU-PCIe
>> ICC (interconnect consumers) path should be voted otherwise it may
>> lead to NoC (Network on chip) timeout. We are surviving because of
>> other driver vote for this path.
>>
>> As there is less access on this path compared to PCIe to mem path
>> add minimum vote i.e 1KBps bandwidth always.
> 
> Please add the info that 1KBps is what shared by the HW team.
> 
Ack to all the comments
>>
>> When suspending, disable this path after register space access
>> is done.
>>
>> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-qcom.c | 38 ++++++++++++++++++++++++++++++++--
>>   1 file changed, 36 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>> index 10f2d0bb86be..a0266bfe71f1 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -240,6 +240,7 @@ struct qcom_pcie {
>>   	struct phy *phy;
>>   	struct gpio_desc *reset;
>>   	struct icc_path *icc_mem;
>> +	struct icc_path *icc_cpu;
>>   	const struct qcom_pcie_cfg *cfg;
>>   	struct dentry *debugfs;
>>   	bool suspended;
>> @@ -1372,6 +1373,9 @@ static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
>>   	if (IS_ERR(pcie->icc_mem))
>>   		return PTR_ERR(pcie->icc_mem);
>>   
>> +	pcie->icc_cpu = devm_of_icc_get(pci->dev, "cpu-pcie");
>> +	if (IS_ERR(pcie->icc_cpu))
>> +		return PTR_ERR(pcie->icc_cpu);
>>   	/*
>>   	 * Some Qualcomm platforms require interconnect bandwidth constraints
>>   	 * to be set before enabling interconnect clocks.
>> @@ -1381,7 +1385,19 @@ static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
>>   	 */
>>   	ret = icc_set_bw(pcie->icc_mem, 0, QCOM_PCIE_LINK_SPEED_TO_BW(1));
>>   	if (ret) {
>> -		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
>> +		dev_err(pci->dev, "failed to set interconnect bandwidth for pcie-mem: %d\n",
> 
> "PCIe-MEM"
> 
>> +			ret);
>> +		return ret;
>> +	}
>> +
>> +	/*
>> +	 * The config space, BAR space and registers goes through cpu-pcie path
>> +	 * Set peak bandwidth to 1KBps as recommended by HW team for this path
>> +	 * all the time.
> 
> How about,
> 
> 	"Since the CPU-PCIe path is only used for activities like register
> 	access, Config/BAR space access, HW team has recommended to use a
> 	minimal bandwidth of 1KBps just to keep the link active."
> 
>> +	 */
>> +	ret = icc_set_bw(pcie->icc_cpu, 0, kBps_to_icc(1));
>> +	if (ret) {
>> +		dev_err(pci->dev, "failed to set interconnect bandwidth for cpu-pcie: %d\n",
>>   			ret);
>>   		return ret;
>>   	}
>> @@ -1573,7 +1589,7 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
>>   	 */
>>   	ret = icc_set_bw(pcie->icc_mem, 0, kBps_to_icc(1));
>>   	if (ret) {
>> -		dev_err(dev, "Failed to set interconnect bandwidth: %d\n", ret);
>> +		dev_err(dev, "Failed to set interconnect bandwidth for pcie-mem: %d\n", ret);
> 
> "PCIe-MEM"
> 
>>   		return ret;
>>   	}
>>   
>> @@ -1597,6 +1613,18 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
>>   		pcie->suspended = true;
>>   	}
>>   
>> +	/* Remove CPU path vote after all the register access is done */
> 
> "Remove the vote for CPU-PCIe path now, since at this point onwards, no register
> access will be done."
> 
>> +	ret = icc_disable(pcie->icc_cpu);
>> +	if (ret) {
>> +		dev_err(dev, "failed to disable icc path of cpu-pcie: %d\n", ret);
> 
> "CPU-PCIe"
> 
>> +		if (pcie->suspended) {
>> +			qcom_pcie_host_init(&pcie->pci->pp);
> 
> Interesting. So if icc_disable() fails, can the IP continue to function?
>
As the ICC already enable before icc_disable() fails, the IP should work.
  - Krishna Chaitanya.
>> +			pcie->suspended = false;
>> +		}
>> +		qcom_pcie_icc_update(pcie);
>> +		return ret;
>> +	}
>> +
>>   	return 0;
>>   }
>>   
>> @@ -1605,6 +1633,12 @@ static int qcom_pcie_resume_noirq(struct device *dev)
>>   	struct qcom_pcie *pcie = dev_get_drvdata(dev);
>>   	int ret;
>>   
>> +	ret = icc_enable(pcie->icc_cpu);
>> +	if (ret) {
>> +		dev_err(dev, "failed to enable icc path of cpu-pcie: %d\n", ret);
> 
> "CPU-PCIe"
> 
> - Mani
> 

