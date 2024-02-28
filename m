Return-Path: <linux-pci+bounces-4169-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6772686A884
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 07:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E6AA289293
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 06:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1355822EF0;
	Wed, 28 Feb 2024 06:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CujYX1md"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9AF21370;
	Wed, 28 Feb 2024 06:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709102855; cv=none; b=NhWoeHGgpM7P29/OaeTlHREvCG4r1FsxvsRWEh/utxYu778+Dnu92j1v0v/Y8Cprwkhy6It79M3KEpTYCJtVa9mK1RiMU95or72wcHL55xdcLKMTpI2q+klERAhXXxWshKlR3cp3HvpeLFpADRgXNnT2+B6J8ozJ+ZGAjmFB9jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709102855; c=relaxed/simple;
	bh=5SbDjU3QwpVjoPHbjFs4J5Fk2GJkrh4T7GJ0c2xGZcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SstM9IwWiRu5VMb2D8SzWnXunJJUI2Dpn3ls4FUYBLJOm0vR6iFvnmV2L81onsqf4amTCKF5k7+4Bi4wyDU7dfSGUYkc+RS4nWufw9lM6gpZQoRNzt7WT3/ZEXt14h7tZizytKl2l8++J/cW+cFy17znWteG4s2nylTqDu1E6fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CujYX1md; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41S0gBUC001337;
	Wed, 28 Feb 2024 06:47:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=os1hq5VVDv2NtOb+/wPepEcvLauwFLr6VI5nYFxjm2E=; b=Cu
	jYX1mdZZGi9jNsAwzXiJwqkj6GdqtX6aRYAT51/roMUSPp7/PXA3Lol/1JloEqCE
	Poesi/B9D0VR0FZzu0s2lvZuFbY+r5AZfRDKhWBFLdJN2inJQc557kIa9eJAEMkx
	4V/wBiW03dxwuDzWCUG4QlJyylLlVJ7dAHCafskzFU2xPzagZq0aVeCqGoRMzj9L
	+LbqU1V/AcYPcN/y9PwXNYEKuBmYKLfANS2xTjGeaP2ZhpNrKG2r31RENYitFvw2
	NTGu72d8Ya67bdQLTbjYdBZ3LVEh8smNWuKxAJhp0Q8MughHW/7zaRXLRCHQEIDz
	jM3OIA/aRP/+jX1JDm4g==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3whrqagrhb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 06:47:22 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41S6lLHP027853
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 06:47:21 GMT
Received: from [10.216.14.152] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 27 Feb
 2024 22:47:12 -0800
Message-ID: <ede43e87-21e7-7f08-a78c-b7e1e547dab6@quicinc.com>
Date: Wed, 28 Feb 2024 12:17:09 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v7 6/7] PCI: Bring out the pcie link speed to MBps logic
 to new function
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
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
        <quic_parass@quicinc.com>
References: <20240228002530.GA250175@bhelgaas>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20240228002530.GA250175@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wcbCBBdf9ReTukzBTdxTGf0U6vYY0fS1
X-Proofpoint-ORIG-GUID: wcbCBBdf9ReTukzBTdxTGf0U6vYY0fS1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_04,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 priorityscore=1501
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2402280051



On 2/28/2024 5:55 AM, Bjorn Helgaas wrote:
> Mention the new interface name in the subject and in the commit log.
> 
> s/pcie/PCIe/
> 
> The subject says "to MBps", but the commit log says "to frequency".
> 
> On Fri, Feb 23, 2024 at 08:18:03PM +0530, Krishna chaitanya chundru wrote:
>> Bring the switch case in pcie_link_speed_mbps to new function to
>> the header file so that it can be used in other places like
>> in controller driver.
> 
> s/pcie_link_speed_mbps/pcie_link_speed_mbps()/ to identify it as a
> function.
> 
>> Create a new macro to convert from MBps to frequency.
> 
> Include the new macro name here.
> 
> I think pcie_link_speed_mbps() returns Mb/s (mega*bits* per second),
> not MB/s (mega*bytes* per second).
> 
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>>   drivers/pci/pci.c | 19 +------------------
>>   drivers/pci/pci.h | 24 ++++++++++++++++++++++++
>>   2 files changed, 25 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index d8f11a078924..b441ab862a8d 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -6309,24 +6309,7 @@ int pcie_link_speed_mbps(struct pci_dev *pdev)
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
>>   }
>>   EXPORT_SYMBOL(pcie_link_speed_mbps);
>>   
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index 2336a8d1edab..82e715ebe383 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -282,6 +282,30 @@ void pci_bus_put(struct pci_bus *bus);
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
>> +
>> +#define PCIE_MBS2FREQ(speed) (pcie_link_speed_to_mbps(speed) * 1000)
> 
> I feel like I might have asked some of this before; if so, my
> apologies and maybe a comment would be useful here to save answering
> again.
> 
> The MBS2FREQ name suggests that "speed" is Mb/s, but it's not; it's an
> enum pci_bus_speed just like PCIE_SPEED2MBS_ENC() takes.
> 
> When PCI SIG defines a new data rate, PCIE_MBS2FREQ() will do
> something completely wrong when pcie_link_speed_to_mbps() returns
> -EINVAL.  I think it would be better to do this in a way that we can
> warn about the unknown speed and fall back to some reasonable default
> instead of whatever (-EINVAL * 1000) works out to.
> 
As commented below I will move PCIE_MBS2FREQ to qcom driver and I will 
take care about -EINVAL in the qcom driver itself.
> PCIE_MBS2FREQ() looks an awful lot like PCIE_SPEED2MBS_ENC(), except
> that it doesn't adjust for the encoding overhead and it multiplies by
> 1000.  I don't know what that result means.  The name suggests a
> frequency?
> 
>    pcie_link_speed_to_mbps(PCIE_SPEED_2_5GT) == 2500 Mbit/s (raw data rate)
>    PCIE_SPEED2MBS_ENC(PCIE_SPEED_2_5GT) == 2000 Mbit/s or 2 Gbit/s (effective data rate)
>    PCIE_MBS2FREQ(PCIE_SPEED_2_5GT) == 2500000 (? 2.5M of something)
> 
> I don't really know how OPP works, but it looks like maybe
> PCIE_MBS2FREQ() is a shim that depends on how the OPP tables in DT are
> encoded?  I'm surprised that the DT OPP tables aren't encoded with
> either the raw data rate or the effective data rate directly instead
> of what looks like the raw data rate / 1000.
> 
> Is this a standard OPP encoding that will apply to other drivers?  If
> so, it would be helpful to point to where that encoding is defined.
> If not, PCIE_MBS2FREQ() should probably be defined in pcie-qcom.c.
> 
It depends on how driver use OPP, I think as you suggested PCIE_MBS2FREQ
should belong to pcie-qcom.c as no other driver is using it for now.
I will move to pcie_qcom.c in my next series.

- Krishna Chaitanya.
> Bjorn
> 

