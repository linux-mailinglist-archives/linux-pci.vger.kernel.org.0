Return-Path: <linux-pci+bounces-8985-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B560D90F08C
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 16:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A84841C21296
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 14:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615B911C92;
	Wed, 19 Jun 2024 14:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="c/t2MPbq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA4B1B948;
	Wed, 19 Jun 2024 14:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718807469; cv=none; b=N0pWJjiRLsjTMDpJL9r7AbXCi8cQXYMzVJx0GSPdtSRc53xRrtXUX6s6kKI8ORsdmN8uHfuwVXGH/MOvD5EBmqsqoxEDouVG3Nx78ASjMqard36F+IWyU7VLTznMLF9nWC92RaVu6H/EnYbe5er8TzPoZXvEejWQGnQLXhWi89Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718807469; c=relaxed/simple;
	bh=BPMMwZn6Og0jszVG/cAk8PDDmPQrHjsG2/h68r5PxxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DBFsF59eXtJxLT6n+vt01/C3gbmJ3cUSKMIQX8EYemkH79MY4LEfokf4m4DOuhj+Ko/opDg+mFq6bxZ/HlWXzcW9A3ssdXv3lnc8bawKTcL62eKY4jP2/uluFG5nwtkekma9NK+FETAVMCnFud/MBcY1zcj1oUqOgtv9y0ZyX0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=c/t2MPbq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45JA5G9n016085;
	Wed, 19 Jun 2024 14:30:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WMej7sJwoexITPuS9vB+WUyYogZePWN8zXQSXbZHGJ8=; b=c/t2MPbqOLSGrOao
	dP/r6yiiWlxbhjL8NLNexr8lzZfG7mIsF7ygRurxeXNl6eIILw6i7BudAGYqEW3n
	s1yUInqKxfT7kx2GNjffhofrxRlCH+3AgRg8whPmp+ul2OL9OKFo7sviBz91/3iM
	0kp6fLit3VeEqdOwXDttVzOuqKPwuLGmDAV8ND3elNeKqeZTvkXDlKsz0wceaFta
	CvOylF/MPq+L+rqIyVDpyJH02RhoTGy0VCNYsJFqJQ/QryYsuNYHGzCpZo1TKmFJ
	yMIvhIRJOzbHBx8FfpSEEDZfXUS2HZi00/QOR7NnaiP09BbSMEwreiXVbJGBDTb5
	gIUwsA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yuja51xju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 14:30:47 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45JEUk9q018160
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 14:30:46 GMT
Received: from [10.216.5.74] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 19 Jun
 2024 07:30:37 -0700
Message-ID: <15693666-edef-60c9-80e1-c74db00e07aa@quicinc.com>
Date: Wed, 19 Jun 2024 20:00:21 +0530
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
X-Proofpoint-ORIG-GUID: j1Vg0VY4XtheVwORlXDUtqCV06y-ub8Q
X-Proofpoint-GUID: j1Vg0VY4XtheVwORlXDUtqCV06y-ub8Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 adultscore=0 impostorscore=0 clxscore=1011 mlxscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406190108



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
Ack I will modify in the next patch.
> In general, I don't like moving that code into a header file, did you
> check how large footprint the new function is (when it's not inlined)?
> 
I checked with and without inline and I don't see any difference in both
cases
aarch64-linux-gnu-size ../drivers/pci/pci.o
    text    data     bss     dec     hex filename
   41440    1334      64   42838    a756 ../kobj/drivers/pci/pci.o

   text    data     bss     dec     hex filename
   41440    1334      64   42838    a756 ../kobj/drivers/pci/pci.o

- Krishna chaitanya.
> Unrelated to this patch, it would be nice if LNKSTA register read would
> not be needed at all here but since cur_bus_speed is what it is currently,
> it's just wishful thinki
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

