Return-Path: <linux-pci+bounces-8987-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3585590F15F
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 16:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D34DC28AB66
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 14:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6F422619;
	Wed, 19 Jun 2024 14:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OPcx6dLx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B443310A03;
	Wed, 19 Jun 2024 14:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718808882; cv=none; b=bQ7aORKUVpZ2oleXuj9Dt4tG4Wh73e2xLpqjQ7cR5exCDLTOup7vEL7Upsh6Xv60hbg0iJmwcVD4iX8VRPFFprBVMBDPFO4NI9OeLp9+FeIuEHUcv7eMSCsUk6RFFk7fXzdB6MaYpcfsmBAkj5min2RvyoF5piDJRFyQA1WFsno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718808882; c=relaxed/simple;
	bh=ZMlyc+L4U80HtDiudoSdpft6wYgVfkC7WdRxSopLmtI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=X9YKkaaKJtf4rykxmRCKNHffY+UiSUf6G3jxl3NZqxxHE+O21vi2nTVV9KWpdVVjmvWDBoHiOSdTzd8VA6hdy1XFjEtI4qoSoqyVaSQQlPpgfB3XrizAcZTV18CNLnfCg9jecYbN6L67ssdRQoIEpuaSGPf6AgPUVqpR/hIDOv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OPcx6dLx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45JAList023156;
	Wed, 19 Jun 2024 14:54:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YyaGkDrShbWQyeHFtX9sDyxJbeURS0AvAucuhdXEPu4=; b=OPcx6dLxKDrEPVNX
	EDFw59FxnTApRfzHAJCW7J9Qg7Unc7Brw+cHLlGPNyhnNFnqC9bTt6i8qVhYhj70
	WP+5otBjt9PX0eH02KZksUDYRMYKnWskqGoRsFshkJ+oMupTSAXvBbqDQFfcs0ey
	VERnFZnMqc+C6d2fr5sJFnvDPB0REo906IDAuHYUkaTxEItzutSXNkMfqZFg/DUb
	T18n9wkk5TOt9dMtw6qa5VG/PVyZ21OqYyVmO72ob3E89r9ekYDmcrWEoQTwLzXp
	7wWT+F/pTUebV5WW9H26C2MTwaDOmZ/4pYw5aPbyPJEm+OwFRXKDhrv02CvXGu/f
	sSc4VA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yuj9x218k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 14:54:30 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45JEsSEY019586
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 14:54:28 GMT
Received: from [10.216.5.74] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 19 Jun
 2024 07:54:19 -0700
Message-ID: <3ed39bb0-f1bb-6973-21e5-aaa34db8013e@quicinc.com>
Date: Wed, 19 Jun 2024 20:24:16 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v14 3/4] PCI: Bring the PCIe speed to MBps logic to new
 pcie_link_speed_to_mbps()
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?=
	<kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, <johan+linaro@kernel.org>,
        <bmasney@redhat.com>, <djakov@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <vireshk@kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_parass@quicinc.com>, <krzysztof.kozlowski@linaro.org>
References: <20240609-opp_support-v14-0-801cff862b5a@quicinc.com>
 <20240609-opp_support-v14-3-801cff862b5a@quicinc.com>
 <c76624fa-1c07-1bb4-dff0-e35fe072f176@linux.intel.com>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <c76624fa-1c07-1bb4-dff0-e35fe072f176@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: eyUBOMCMLAAFHn2kcLcOV1kSKhbEv3rH
X-Proofpoint-GUID: eyUBOMCMLAAFHn2kcLcOV1kSKhbEv3rH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 suspectscore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406190111



On 6/14/2024 6:02 PM, Ilpo Järvinen wrote:
> On Sun, 9 Jun 2024, Krishna chaitanya chundru wrote:
> 
>> Bring the switch case in pcie_link_speed_mbps() to new function to
>> the header file so that it can be used in other places like
>> in controller driver.
>>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>> ---
>>   drivers/pci/pci.c | 19 +------------------
>>   drivers/pci/pci.h | 22 ++++++++++++++++++++++
>>   2 files changed, 23 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index d2c388761ba9..6e50fa89b913 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -6027,24 +6027,7 @@ int pcie_link_speed_mbps(struct pci_dev *pdev)
>>   	if (err)
>>   		return err;
>>   
>> -	switch (to_pcie_link_speed(lnksta)) {
>> -	case PCIE_SPEED_2_5GT:
>> -		return 2500;
>> -	case PCIE_SPEED_5_0GT:
>> -		return 5000;
>> -	case PCIE_SPEED_8_0GT:
>> -		return 8000;
>> -	case PCIE_SPEED_16_0GT:
>> -		return 16000;
>> -	case PCIE_SPEED_32_0GT:
>> -		return 32000;
>> -	case PCIE_SPEED_64_0GT:
>> -		return 64000;
>> -	default:
>> -		break;
>> -	}
>> -
>> -	return -EINVAL;
>> +	return pcie_link_speed_to_mbps(to_pcie_link_speed(lnksta));
> 
> pcie_link_speed_mbps() calls pcie_link_speed_to_mbps(), seems quite
> confusing to me. Perhaps renaming one to pcie_dev_speed_mbps() would help
> against the almost identical naming.
> 
> In general, I don't like moving that code into a header file, did you
> check how large footprint the new function is (when it's not inlined)?
> 
if we remove this patch we see difference of 8, I think it should be fine.
with change
aarch64-linux-gnu-size ../drivers/pci/pci.o
    text    data     bss     dec     hex filename
   41440    1334      64   42838    a756 ../kobj/drivers/pci/pci.o
without the change
text    data     bss     dec     hex filename
   41432    1334      64   42830    a74e ../kobj/drivers/pci/pci.o

- Krishna Chaitanya.
> Unrelated to this patch, it would be nice if LNKSTA register read would
> not be needed at all here but since cur_bus_speed is what it is currently,
> it's just wishful thinking.
> 
>>   }
>>   EXPORT_SYMBOL(pcie_link_speed_mbps);
>>   
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index 1b021579f26a..391a5cd388bd 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -333,6 +333,28 @@ void pci_bus_put(struct pci_bus *bus);
>>   	 (speed) == PCIE_SPEED_2_5GT  ?  2500*8/10 : \
>>   	 0)
>>   
>> +static inline int pcie_link_speed_to_mbps(enum pci_bus_speed speed)
>> +{
>> +	switch (speed) {
>> +	case PCIE_SPEED_2_5GT:
>> +		return 2500;
>> +	case PCIE_SPEED_5_0GT:
>> +		return 5000;
>> +	case PCIE_SPEED_8_0GT:
>> +		return 8000;
>> +	case PCIE_SPEED_16_0GT:
>> +		return 16000;
>> +	case PCIE_SPEED_32_0GT:
>> +		return 32000;
>> +	case PCIE_SPEED_64_0GT:
>> +		return 64000;
>> +	default:
>> +		break;
>> +	}
>> +
>> +	return -EINVAL;
>> +}
> 
> 
> 

