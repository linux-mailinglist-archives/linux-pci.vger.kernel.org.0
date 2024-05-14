Return-Path: <linux-pci+bounces-7443-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E598C4EEC
	for <lists+linux-pci@lfdr.de>; Tue, 14 May 2024 12:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 861A1B213D9
	for <lists+linux-pci@lfdr.de>; Tue, 14 May 2024 10:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4E212FB28;
	Tue, 14 May 2024 09:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BvTi86nG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAFB12FB18;
	Tue, 14 May 2024 09:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715679516; cv=none; b=Cb9ixMRYiLBT7IFY+JYoKetZOEQm1WEg4BwC2laCjarcrlIFBtN5KzAoTeZveVFJmXZEyFqQoHEjeqi2juKveYmUVqs2eIkeHbbI6H3SEdyWpWYE2IBNUIOmPAB2UHgUsjDUKW8twkKNClxV4Lgr62wXB+OQxvKHjkYgjG4Seug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715679516; c=relaxed/simple;
	bh=062kHjfpUH0Bia/aG5u1+e8jCWUmUyRdqujljE4MKEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=r/kaE58pwDdn7+vlM0ZTaXe9sGVxa2SaXfgE2YLfcLtlB+ko7/V7d1Oq+N5bkrvv3veozGB4C2PybAr5hmTAiqIMdG27XqlGeXG5DRUC6181oRf85PNxykJvapwz54jaH/Z14//rR1AkajrlB7yRUfjX+rRiSHtcRq0OKrqoI2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BvTi86nG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44E6KaSn003622;
	Tue, 14 May 2024 09:38:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=StzIah23MS2XaSrNazpAdNEW9sK7/dHfb00hi8K/fck=; b=Bv
	Ti86nGVj83taBQcY3pvciSKsNgn3CTzBc+uZpU7jaZvvcb8GWiDHeFji18Mbt8ap
	WfTdXuTQJ338dLyybkEd/lvnb8WH3WJ3TfBumJm0sw3NfAYvF6NB7uBqixfwtabx
	luol89+pOJK6m3OI5N8rks6w7mkrxRygYa8OCW5a5vzJ7vedHMucX0puuOXVjnJC
	59tmgQ/PxyhrgGlyo9i/1e7g1/3dqKxN8Bf+qgbUMQSiaPmyjzKP98XAqjzdIWPj
	sRdb3BpHM+eBuMQnFBuo0F10dSYaVsbftIWTo0xTfl9nw9vwZID9cxyrBiLCZH2c
	Z6rQIUPooN4ZhE8cmMqw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y42kvrcpk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 09:38:08 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44E9c6aA022941
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 09:38:06 GMT
Received: from [10.216.46.205] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 14 May
 2024 02:37:59 -0700
Message-ID: <825d76be-1e97-ee3f-55e6-baecdc1bded8@quicinc.com>
Date: Tue, 14 May 2024 15:07:55 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v12 2/6] PCI: qcom: Add ICC bandwidth vote for CPU to PCIe
 path
Content-Language: en-US
To: Mayank Rana <quic_mrana@quicinc.com>,
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
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?=
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
 <60e92614-5e56-46c4-ab4f-1f0261a3a9ab@quicinc.com>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <60e92614-5e56-46c4-ab4f-1f0261a3a9ab@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: sHInhvsBHo1fwgWiIp7JpksYePDESjNV
X-Proofpoint-ORIG-GUID: sHInhvsBHo1fwgWiIp7JpksYePDESjNV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-14_04,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 adultscore=0 mlxscore=0 impostorscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405140067



On 5/10/2024 12:04 AM, Mayank Rana wrote:
> Hi Krishna
> 
> On 4/26/2024 6:52 PM, Krishna chaitanya chundru wrote:
>> To access the host controller registers of the host controller and the
>> endpoint BAR/config space, the CPU-PCIe ICC (interconnect) path should
>> be voted otherwise it may lead to NoC (Network on chip) timeout.
>> We are surviving because of other driver voting for this path.
>>
>> As there is less access on this path compared to PCIe to mem path
>> add minimum vote i.e 1KBps bandwidth always which is sufficient enough
>> to keep the path active and is recommended by HW team.
>>
>> During S2RAM (Suspend-to-RAM), the DBI access can happen very late (while
>> disabling the boot CPU). So do not disable the CPU-PCIe interconnect path
>> during S2RAM as that may lead to NoC error.
>>
>> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-qcom.c | 44 
>> ++++++++++++++++++++++++++++++----
>>   1 file changed, 40 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c 
>> b/drivers/pci/controller/dwc/pcie-qcom.c
>> index 14772edcf0d3..465d63b4be1c 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -245,6 +245,7 @@ struct qcom_pcie {
>>       struct phy *phy;
>>       struct gpio_desc *reset;
>>       struct icc_path *icc_mem;
>> +    struct icc_path *icc_cpu;
>>       const struct qcom_pcie_cfg *cfg;
>>       struct dentry *debugfs;
>>       bool suspended;
>> @@ -1409,6 +1410,9 @@ static int qcom_pcie_icc_init(struct qcom_pcie 
>> *pcie)
>>       if (IS_ERR(pcie->icc_mem))
>>           return PTR_ERR(pcie->icc_mem);
>> +    pcie->icc_cpu = devm_of_icc_get(pci->dev, "cpu-pcie");
>> +    if (IS_ERR(pcie->icc_cpu))
>> +        return PTR_ERR(pcie->icc_cpu);
>>       /*
>>        * Some Qualcomm platforms require interconnect bandwidth 
>> constraints
>>        * to be set before enabling interconnect clocks.
>> @@ -1418,7 +1422,20 @@ static int qcom_pcie_icc_init(struct qcom_pcie 
>> *pcie)
>>        */
>>       ret = icc_set_bw(pcie->icc_mem, 0, QCOM_PCIE_LINK_SPEED_TO_BW(1));
>>       if (ret) {
>> -        dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
>> +        dev_err(pci->dev, "Failed to set bandwidth for PCIe-MEM 
>> interconnect path: %d\n",
>> +            ret);
>> +        return ret;
>> +    }
>> +
>> +    /*
>> +     * Since the CPU-PCIe path is only used for activities like register
>> +     * access of the host controller and endpoint Config/BAR space 
>> access,
>> +     * HW team has recommended to use a minimal bandwidth of 1KBps 
>> just to
>> +     * keep the path active.
>> +     */
>> +    ret = icc_set_bw(pcie->icc_cpu, 0, kBps_to_icc(1));
>> +    if (ret) {
>> +        dev_err(pci->dev, "Failed to set bandwidth for CPU-PCIe 
>> interconnect path: %d\n",
>>               ret);
> Is it needed to undo icc_mem related bus bandwidth vote here ?
I will add the logic to remove icc_mem path while returning from here,
in the next patch series.

- Krishna Chaitanya.
>>           return ret;
>>       }
>> @@ -1448,7 +1465,7 @@ static void qcom_pcie_icc_update(struct 
>> qcom_pcie *pcie)
>>       ret = icc_set_bw(pcie->icc_mem, 0, width * 
>> QCOM_PCIE_LINK_SPEED_TO_BW(speed));
>>       if (ret) {
>> -        dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
>> +        dev_err(pci->dev, "Failed to set bandwidth for PCIe-MEM 
>> interconnect path: %d\n",
>>               ret);
>>       }
>>   }
> 

