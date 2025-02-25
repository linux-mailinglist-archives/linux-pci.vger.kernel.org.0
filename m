Return-Path: <linux-pci+bounces-22312-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D321A43AE4
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 11:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D0C31889BEA
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 10:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF6326136A;
	Tue, 25 Feb 2025 10:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mL7oyq2O"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE941519A5;
	Tue, 25 Feb 2025 10:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740478013; cv=none; b=e7nmUayazoYncU5vJ58hD4Ce3CwAZfKWSjRwdBn5A8eP75i4ETv2CCjkcPcwca1jFeqj6/4JOovz9qIf5+lgzODiRnYumhAnzXA/1TUGsw7ZAvSy0ticzUc8NlDHGmNNQ3KcWHIxSynLwVdeBMUnIhEe4ESWKBTj6PcP+JdAFXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740478013; c=relaxed/simple;
	bh=BdXYIMubP68iO4yl2tcuwaKsQURZC7iC1Rei84h8/PY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mmpVhgB5HkprHGIdkoUZQnoTbjOIHb86p6EgDiu9woaXkmb64VEWw/Y+onaL9u6En3IbFi1MdubYJFGBaDcD7ROVCxl2U/MvYnMmjccgxI3qBbwtaT5l/MdX6fToAJZAFhbfoGeACJoVrGNnW2h1UmxzQ22fzqPf+EJ6lb+vU98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mL7oyq2O; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P8dnNP013317;
	Tue, 25 Feb 2025 10:06:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3eaFx6OR3vSlzAH+D+Vm5WEpKwhhMdM90BqPI5fV0kY=; b=mL7oyq2Ox96LAXZg
	b2hN0qzx5F4h+zJ7TvDePRD+z04H3vy1DStOWRGvnkzWKAK557wKZx4YwTnopbwB
	9hzBIH/PfzEM/8FNmOjzBkMED1jeTSIKFDA7v8PSewG998K9ffzcvu1A9pRmta91
	SbmmGfht5kncrON9l3tyAtgSzGe6OKepHynpSly4genojRbOUW8L1JZqVcvXHc8T
	ek82DGi56j9cUwvugULdlGJVo1PFHJjGZLu91TOilfPfud583x7vp33UrP5Hj6YI
	pxgxpxPmnmtPGDuk6agoB1mPs7PP2SiMlbhN7RE5MyT5sM16yfBBao7l6BSlwDHn
	g/f8NA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44y5wgrhus-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 10:06:23 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51PA6LlS009496
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 10:06:21 GMT
Received: from [10.216.17.28] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 25 Feb
 2025 02:06:14 -0800
Message-ID: <29809286-cc04-fbc4-60bd-460821c4bc72@quicinc.com>
Date: Tue, 25 Feb 2025 15:36:10 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 07/10] PCI: PCI: Add pcie_is_link_active() to determine
 if the PCIe link is active
Content-Language: en-US
To: Lukas Wunner <lukas@wunner.de>,
        Krishna Chaitanya Chundru
	<krishna.chundru@oss.qualcomm.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        Krzysztof Wilczy??ski <kw@linux.com>,
        "Manivannan
 Sadhasivam" <manivannan.sadhasivam@linaro.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>,
        <cros-qcom-dts-watchers@chromium.org>,
        Jingoo Han
	<jingoohan1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, <quic_vbadigan@quicnic.com>,
        <amitk@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <jorge.ramirez@oss.qualcomm.com>
References: <20250225-qps615_v4_1-v4-0-e08633a7bdf8@oss.qualcomm.com>
 <20250225-qps615_v4_1-v4-7-e08633a7bdf8@oss.qualcomm.com>
 <Z72TRBvpzizcgm9S@wunner.de>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <Z72TRBvpzizcgm9S@wunner.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Y_GkRtIcYlsQfTa9XnF0htPFgpJHWRAM
X-Proofpoint-ORIG-GUID: Y_GkRtIcYlsQfTa9XnF0htPFgpJHWRAM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_03,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1011 adultscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502250070



On 2/25/2025 3:24 PM, Lukas Wunner wrote:
> On Tue, Feb 25, 2025 at 03:04:04PM +0530, Krishna Chaitanya Chundru wrote:
>> Introduce a common API to check if the PCIe link is active, replacing
>> duplicate code in multiple locations.
> [...]
>> --- a/drivers/pci/hotplug/pciehp_hpc.c
>> +++ b/drivers/pci/hotplug/pciehp_hpc.c
>> @@ -234,18 +234,7 @@ static void pcie_write_cmd_nowait(struct controller *ctrl, u16 cmd, u16 mask)
>>    */
>>   int pciehp_check_link_active(struct controller *ctrl)
>>   {
>> -	struct pci_dev *pdev = ctrl_dev(ctrl);
>> -	u16 lnk_status;
>> -	int ret;
>> -
>> -	ret = pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
>> -	if (ret == PCIBIOS_DEVICE_NOT_FOUND || PCI_POSSIBLE_ERROR(lnk_status))
>> -		return -ENODEV;
>> -
>> -	ret = !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
>> -	ctrl_dbg(ctrl, "%s: lnk_status = %x\n", __func__, lnk_status);
>> -
>> -	return ret;
>> +	return pcie_is_link_active(ctrl_dev(ctrl));
>>   }
> 
> Please replace all call sites of pciehp_check_link_active() with a call
> to the new function.
> 
> 
ack
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -4923,8 +4922,7 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
>>   		if (!dev->link_active_reporting)
>>   			return -ENOTTY;
>>   
>> -		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &status);
>> -		if (!(status & PCI_EXP_LNKSTA_DLLLA))
>> +		if (pcie_is_link_active(dev))
>>   			return -ENOTTY;
> 
> Missing negation.
> 
> 
ack
>> +/**
>> + * pcie_is_link_active() - Checks if the link is active or not
>> + * @pdev: PCI device to query
>> + *
>> + * Check whether the link is active or not.
>> + *
>> + * If the config read returns error then return -ENODEV.
>> + */
>> +int pcie_is_link_active(struct pci_dev *pdev)
> 
> Why not return bool?
> 
pciehp_check_link_active is expecting int to make sure this new function
not disturbing the hotplug driver I added return type as int, I can 
change it to bool if it fine with hotplug drivers.
> I don't quite like the function name because in English the correct word
> order is subject - predicate - object, i.e. pcie_link_is_active() or
> even shorter, pcie_link_active().
> 
ack
> 
>> @@ -2094,6 +2095,10 @@ pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
>>   {
>>   	return -ENOSPC;
>>   }
>> +
>> +static inline int pcie_is_link_active(struct pci_dev *dev)
>> +{ return -ENODEV; }
>> +
>>   #endif /* CONFIG_PCI */
> 
> Is the empty inline really necessary?  What breaks if you leave it out?
> 
ack I will remove it.

- Krishna Chaitanya.
> Thanks,
> 
> Lukas

