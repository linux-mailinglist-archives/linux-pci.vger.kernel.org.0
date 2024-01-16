Return-Path: <linux-pci+bounces-2195-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6346282E924
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 06:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FEFA1C2271C
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 05:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F277848E;
	Tue, 16 Jan 2024 05:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GVRJUJGf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C3F79FD;
	Tue, 16 Jan 2024 05:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40G5GNfO032765;
	Tue, 16 Jan 2024 05:19:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=wS3rfmNA7q40qbJVSsHrdKN8favboaYx+n1VS8UcygM=; b=GV
	RJUJGfj2QCm/Wh3LUD3G23dRpQ5jofe0iM2Q+JmSjf+IOu2zapkSiWHDVlXdrhkD
	aMTquF2Eur2rLSD9f6yyNjn+hQMvy9cq9CfzDiPx1ZdWRD+70Y/IYj35wJtAnJss
	lmjAY+kKsCtObNJFmiLHVHlGH/khW5qLxECfA1h/k1QkrxF3PMCn985qNGf9g/b4
	ZLlzjd5i5qqSMiGS1KrQgt4l/NvNm2H4S+TXcOPjjCSNTm/hETZVB3ujC3xCP0gA
	eej5vlAWOU+xS4hQ//hXBUGnRPc812kr84Tgil9c5trNLWle0lk0YZZ6H9MEAKyw
	iakdL0usBaYxZBlNutMQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vn2bjhx18-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 05:19:01 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40G5J0WO011402
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 05:19:00 GMT
Received: from [10.216.3.129] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 15 Jan
 2024 21:18:54 -0800
Message-ID: <160e3c95-314a-712a-36c6-a7eddf175c5c@quicinc.com>
Date: Tue, 16 Jan 2024 10:48:50 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v6 6/6] PCI: qcom: Add OPP support to scale performance
 state of power domain
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Lorenzo
 Pieralisi" <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?=
	<kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Brian Masney <bmasney@redhat.com>, Georgi Djakov <djakov@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <vireshk@kernel.org>,
        <quic_vbadigan@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240112-opp_support-v6-0-77bbf7d0cc37@quicinc.com>
 <20240112-opp_support-v6-6-77bbf7d0cc37@quicinc.com>
 <d7bb676c-f881-4be0-aff2-da50c9fa7eda@linaro.org>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <d7bb676c-f881-4be0-aff2-da50c9fa7eda@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Ha8uzJEyL26jlBuhrXPrnz32uMtv8sYI
X-Proofpoint-ORIG-GUID: Ha8uzJEyL26jlBuhrXPrnz32uMtv8sYI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 phishscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401160038



On 1/13/2024 4:14 AM, Konrad Dybcio wrote:
> On 12.01.2024 15:22, Krishna chaitanya chundru wrote:
>> QCOM Resource Power Manager-hardened (RPMh) is a hardware block which
>> maintains hardware state of a regulator by performing max aggregation of
>> the requests made by all of the processors.
>>
>> PCIe controller can operate on different RPMh performance state of power
>> domain based up on the speed of the link. And this performance state varies
>> from target to target.
>>
>> It is manadate to scale the performance state based up on the PCIe speed
>> link operates so that SoC can run under optimum power conditions.
>>
>> Add Operating Performance Points(OPP) support to vote for RPMh state based
>> upon GEN speed link is operating.
>>
>> OPP can handle ICC bw voting also, so move icc bw voting through opp
>> framework if opp entries are present.
>>
>> In PCIe certain gen speeds like GEN1x2 & GEN2X1 or GEN3x2 & GEN4x1 use
>> same icc bw and has frequency, so use frequency based search to reduce
>> number of entries in the opp table.
>>
>> Don't initialize icc if opp is supported.
>>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
> 
> [...]
> 
>>   
>> -static void qcom_pcie_icc_update(struct qcom_pcie *pcie)
>> +static void qcom_pcie_icc_opp_update(struct qcom_pcie *pcie)
> 
> Or simply.. qcom_pcie_opp_update :) Especially with Dmitry's
> suggestions
> 
If OPP path is not present we are still voting through ICC, so it is 
better to have name as it.
>>   {
>>   	struct dw_pcie *pci = pcie->pci;
>> -	u32 offset, status;
>> +	u32 offset, status, freq;
>> +	struct dev_pm_opp *opp;
>>   	int speed, width;
>>   	int ret;
>>   
>> -	if (!pcie->icc_mem)
>> -		return;
>> -
>>   	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
>>   	status = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
>>   
>> @@ -1424,11 +1424,42 @@ static void qcom_pcie_icc_update(struct qcom_pcie *pcie)
>>   	speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, status);
>>   	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, status);
>>   
>> -	ret = icc_set_bw(pcie->icc_mem, 0, width * QCOM_PCIE_LINK_SPEED_TO_BW(speed));
>> -	if (ret) {
>> -		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
>> -			ret);
>> +	if (pcie->opp_supported) {
>> +		switch (speed) {
>> +		case 1:
>> +			freq = 2500000;
>> +			break;
>> +		case 2:
>> +			freq = 5000000;
>> +			break;
>> +		case 3:
>> +			freq = 8000000;
>> +			break;
>> +		default:
>> +			WARN_ON_ONCE(1);
>> +			fallthrough;
>> +		case 4:
>> +			freq = 16000000;
>> +			break;
>> +		}
> Might as well add gen5 and 6 rates of 3200.. and 6400.. since they're
> hard-in-stone in the spec by now, AFAIK
> 
> Konrad
ACK.

- Krishna Chaitanya.

