Return-Path: <linux-pci+bounces-2192-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD0382E910
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 06:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC788280D93
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 05:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DE68494;
	Tue, 16 Jan 2024 05:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CniwJgIV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C2279FD;
	Tue, 16 Jan 2024 05:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40G4LQcf020308;
	Tue, 16 Jan 2024 05:06:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=SL4AsbXq3MxY0CAbcuXPjmH5sxKSnQB23n5NxQcLdow=; b=Cn
	iwJgIVBwcDlN9XEgC1mt+QA4uJQVveHsEibH0FfXHfcDYGd8YaCC9ORIwEX244DL
	kMVP0BPyae0ryzS+Smbf+sJrgcLsf4v8cNlZVev4azfUUptBil5G/wDritZjVejV
	Cp/aEBUMKBLhOPbhMc5LuupMdKYAQ+TXN8KjQe/y/EAg6nU/qm0JTTeEYZQqdQNR
	pwxMPu6jWjsFzlSFyLc1iiJENaOaSGN0z1vn0sMgtgPi0sUNUOBESh8fSpNK7aiv
	GLYfpjCT76FEjctwMRPAw0Nv9vDEjpq5q9QyaRbBpnNAjvSPCCO5n9lpOcoLWDgi
	a3G7OtnXsLnvfOCzoeVg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vnejdghb5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 05:06:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40G56XSH025963
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 05:06:33 GMT
Received: from [10.216.3.129] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 15 Jan
 2024 21:06:26 -0800
Message-ID: <cf6ec52e-61ad-f76d-02fd-831c63e35d40@quicinc.com>
Date: Tue, 16 Jan 2024 10:36:23 +0530
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
To: Bjorn Helgaas <helgaas@kernel.org>
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
References: <20240112164712.GA2271535@bhelgaas>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20240112164712.GA2271535@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: EnYsFGSBuZGelaC04u8nhJyeRP1gT4mQ
X-Proofpoint-ORIG-GUID: EnYsFGSBuZGelaC04u8nhJyeRP1gT4mQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 spamscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=832 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401160036



On 1/12/2024 10:17 PM, Bjorn Helgaas wrote:
> Capitalize "ICC" and "CPU" to make the subject easier to read.
> "Missing" might be superfluous in the subject?  It would be nice to
> have the ICC expansion once in the commit log as a hook for newbies
> like me :)
> 
Sure I will change a suggested in next patch series.
> On Fri, Jan 12, 2024 at 07:52:02PM +0530, Krishna chaitanya chundru wrote:
>> CPU-PCIe path consits for registers PCIe BAR space, config space.
>> As there is less access on this path compared to pcie to mem path
>> add minimum vote i.e GEN1x1 bandwidth always.
> 
> "GEN1x1" is unnecessarily ambiguous, and the spec recommends avoiding
> it (PCIe r6.0, sec 1.2).  Use the actual bandwidth numbers instead.
> 
> "PCIe" to match above.  Also below in comments and messages.
> 
ACK.
>> In suspend remove the cpu vote after register space access is done.
> 
> "CPU" to match above.
> 
ACK
>> Fixes: c4860af88d0c ("PCI: qcom: Add basic interconnect support")
>> cc: stable@vger.kernel.org
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-qcom.c | 31 +++++++++++++++++++++++++++++--
>>   1 file changed, 29 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>> index 11c80555d975..035953f0b6d8 100644
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
>> @@ -1381,7 +1385,18 @@ static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
>>   	 */
>>   	ret = icc_set_bw(pcie->icc_mem, 0, QCOM_PCIE_LINK_SPEED_TO_BW(1));
>>   	if (ret) {
>> -		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
>> +		dev_err(pci->dev, "failed to set interconnect bandwidth for pcie-mem: %d\n",
>> +			ret);
>> +		return ret;
>> +	}
>> +
>> +	/*
>> +	 * The config space, BAR space and registers goes through cpu-pcie path.
>> +	 * Set peak bandwidth to single-lane Gen1 for this path all the time.
> 
> Numbers instead of "Gen1".
> 
ACK

-Krishna Chaitanya.
>> +	 */
>> +	ret = icc_set_bw(pcie->icc_cpu, 0, QCOM_PCIE_LINK_SPEED_TO_BW(1));
>> +	if (ret) {
>> +		dev_err(pci->dev, "failed to set interconnect bandwidth for cpu-pcie: %d\n",
>>   			ret);
>>   		return ret;
>>   	}
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
>> +	if (ret) {
>> +		dev_err(dev, "failed to set interconnect bandwidth for cpu-pcie: %d\n", ret);
>> +		return ret;
>> +	}
>>   	return 0;
>>   }
>>   
>> @@ -1605,6 +1626,12 @@ static int qcom_pcie_resume_noirq(struct device *dev)
>>   	struct qcom_pcie *pcie = dev_get_drvdata(dev);
>>   	int ret;
>>   
>> +	ret = icc_set_bw(pcie->icc_cpu, 0, QCOM_PCIE_LINK_SPEED_TO_BW(1));
>> +	if (ret) {
>> +		dev_err(dev, "failed to set interconnect bandwidth for cpu-pcie: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>>   	if (pcie->suspended) {
>>   		ret = qcom_pcie_host_init(&pcie->pci->pp);
>>   		if (ret)
>>
>> -- 
>> 2.42.0
>>

