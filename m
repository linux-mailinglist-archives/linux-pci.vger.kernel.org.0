Return-Path: <linux-pci+bounces-2191-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0BD82E907
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 06:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A27BE1C22CC1
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 05:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C0B10A29;
	Tue, 16 Jan 2024 05:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ot3dOR6R"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334CC11185;
	Tue, 16 Jan 2024 05:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40G4wBBJ025828;
	Tue, 16 Jan 2024 05:04:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=3FrMSBXWUEckvi/8fCO2JIg1h2wbBot8oiaLYS7Q6ns=; b=Ot
	3dOR6RM61ULtB0KzZTGB1mwtneOygxB8Jixy92o9Vs0/I3wlWQtXJ2mPKHgppoX7
	UYiqzNRSzlOIlkJ6lE5MRriX/wwb8o61zv0lcNFGgTwAIJA/B3wLUH4YRjjRIbWX
	j/JKU1et5w+TzbdG0Q5HeEic+z9JEVQi7nxhDrZuRo1e/2mpLF3p8VqeIazBUKc6
	ySekVYZqVpxCvHnjAjHS6whj8FP+eYCduNN//P7sJ/VKWevOt1oP9JZqn+GNUMIw
	3jRLByfVH0icxX1oc1/zRWU+WUTpRpsInEhskGhV/EHWZwBXN6A2J1f4k0YG7aVs
	Cqm9qhy9WDlQB0fvQI+Q==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vmyhk27r4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 05:04:33 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40G54WPM017931
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 05:04:32 GMT
Received: from [10.216.3.129] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 15 Jan
 2024 21:04:25 -0800
Message-ID: <1a3aeab6-740b-ebcc-e934-6153a4292151@quicinc.com>
Date: Tue, 16 Jan 2024 10:34:22 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v6 3/6] PCI: qcom: Add missing icc bandwidth vote for cpu
 to PCIe path
Content-Language: en-US
To: Johan Hovold <johan@kernel.org>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
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
        Brian Masney <bmasney@redhat.com>, Georgi Djakov <djakov@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <vireshk@kernel.org>,
        <quic_vbadigan@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
References: <20240112-opp_support-v6-0-77bbf7d0cc37@quicinc.com>
 <20240112-opp_support-v6-3-77bbf7d0cc37@quicinc.com>
 <ZaFhzOCTpZYlAh60@hovoldconsulting.com>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <ZaFhzOCTpZYlAh60@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: fBzEcAs2t2If6X8NZCVLKQfMaaUi5OAV
X-Proofpoint-GUID: fBzEcAs2t2If6X8NZCVLKQfMaaUi5OAV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1011
 lowpriorityscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 phishscore=0 mlxscore=0 mlxlogscore=954 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401160036



On 1/12/2024 9:29 PM, Johan Hovold wrote:
> On Fri, Jan 12, 2024 at 07:52:02PM +0530, Krishna chaitanya chundru wrote:
>> CPU-PCIe path consits for registers PCIe BAR space, config space.
> 
> consits?
> 
>> As there is less access on this path compared to pcie to mem path
>> add minimum vote i.e GEN1x1 bandwidth always.
> 
> gen1 bandwidth can't be right.
> 
There is no recommended value we need vote for this path, as there is
BAR and config space in this path we are voting for GEN1x1.
Please suggest a recommended value for this path if the GEN1x1 is high.
>> In suspend remove the cpu vote after register space access is done.
>>
>> Fixes: c4860af88d0c ("PCI: qcom: Add basic interconnect support")
>> cc: stable@vger.kernel.org
> 
> This does not look like a fix so drop the above.
> 
> The commit you refer to explicitly left this path unconfigured for now
> and only added support for the configuring the mem path as needed on
> sc8280xp which otherwise would crash.
> 
Without this path vote BAR and config space can result NOC timeout
errors, we are surviving because of other driver vote for this path.
For that reason we added a fix tag.
>> @@ -1573,7 +1588,7 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
>>   	 */
>>   	ret = icc_set_bw(pcie->icc_mem, 0, kBps_to_icc(1));
>>   	if (ret) {
>> -		dev_err(dev, "Failed to set interconnect bandwidth: %d\n", ret);
>> +		dev_err(dev, "Failed to set interconnect bandwidth for pcie-mem: %d\n", ret);
>>   		return ret;
>>   	}
>>   
>> @@ -1597,6 +1612,12 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
>>   		pcie->suspended = true;
>>   	}
>>   
>> +	/* Remove cpu path vote after all the register access is done */
>> +	ret = icc_set_bw(pcie->icc_cpu, 0, 0);
> 
> I believe you should use icc_disable() here.
> 
>> +	if (ret) {
>> +		dev_err(dev, "failed to set interconnect bandwidth for cpu-pcie: %d\n", ret);
>> +		return ret;
> 
> And you need to unwind before returning on errors.
> 
>> +	}
>>   	return 0;
>>   }
>>   
>> @@ -1605,6 +1626,12 @@ static int qcom_pcie_resume_noirq(struct device *dev)
>>   	struct qcom_pcie *pcie = dev_get_drvdata(dev);
>>   	int ret;
>>   
>> +	ret = icc_set_bw(pcie->icc_cpu, 0, QCOM_PCIE_LINK_SPEED_TO_BW(1));
> 
> icc_enable()
> 
I was not aware of these API's, I will add them in next patch.

- Krishna Chaitanya.
>> +	if (ret) {
>> +		dev_err(dev, "failed to set interconnect bandwidth for cpu-pcie: %d\n", ret);
>> +		return ret;
>> +	}
> 
> Johan

