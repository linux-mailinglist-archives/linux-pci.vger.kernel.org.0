Return-Path: <linux-pci+bounces-19147-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 469339FF66A
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2025 07:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 667251881F00
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2025 06:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73B618FDA9;
	Thu,  2 Jan 2025 06:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="O3OyWlkY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7D4189BA2;
	Thu,  2 Jan 2025 06:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735798144; cv=none; b=LmPMwlPe8qPByy1ANqHfX6asl+cp6rpR1zZT8wxP+tRkrx2eNVVdpPJr1I0yc1qS71DRbhiPPjoLquonxAThCMSepuxZTWjZu7UVU/3d0Yo8O7OkfieBbfp7FW1hAHfqFCgta/PVIqE4LK3/1O/+v3KV/uE+vk1DoPkMC/BA828=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735798144; c=relaxed/simple;
	bh=mT4z74w94ZR5vgN6iI5EW/RF4NnnYLfA5jnpXauOjIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=j8jXg+LirDOE9dl5sgu7I3uilmeQDer5QMK2r0GiHva5BoITGKxrcSAL6Xx3FlRlQyNnmjZ31qwL+KqREKdiubpNd6lhipryoQeMGjiotB812lDUGB0oM/sdMHAHsSbyWCm+oaINennicLaPsCELEyDa87G/b0azye3WrGQRYas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=O3OyWlkY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 501NR65x015762;
	Thu, 2 Jan 2025 06:08:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	o4zSJ9D8YtpU9oWUMzOF0AsOSNX9YfvYK0GVDA0jsvE=; b=O3OyWlkY4v6hrlNI
	sicesMactFTuyNyFo6hLf3iBya1HPvi5s1RpnwAtzqtlPfss+KExgLqjJ5/OxYtX
	cpjyHNXCHMW5j+YcgnwACXbkM7eSsyNTyyCPpeERDchlrZsLgN4WE7HvEdXY7036
	RcyVwN/p79bt4sUpHvLIgA36hMuQ2qL9GisVHz+TP0Iyy4COwUjKao7s5Anb4OYF
	UA0ocHyqunh/yfLmG4iWJF2Lxv2k38uk+poyxyew8bodDg1YPp7QK/G4o2pTcyOB
	6oaMhcBHgRtccbwabW3wRi3YERHL7f9NRNy7VkUnFzZ1bDSxhJlMrLhUjUgabgUW
	S28z+w==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43w6xah3fv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Jan 2025 06:08:48 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50268lHT030800
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 2 Jan 2025 06:08:47 GMT
Received: from [10.152.195.140] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 1 Jan 2025
 22:08:42 -0800
Message-ID: <daffc5bc-c430-4400-af4d-404cd5984c59@quicinc.com>
Date: Thu, 2 Jan 2025 11:38:39 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] arm64: dts: qcom: ipq5424: Enable PCIe PHYs and
 controllers
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, <bhelgaas@google.com>,
        <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <andersson@kernel.org>, <konradybcio@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>
CC: <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
References: <20241213134950.234946-1-quic_mmanikan@quicinc.com>
 <20241213134950.234946-5-quic_mmanikan@quicinc.com>
 <e28773ef-12a4-4089-9c7b-1be5e5cc7aa5@oss.qualcomm.com>
Content-Language: en-US
From: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
In-Reply-To: <e28773ef-12a4-4089-9c7b-1be5e5cc7aa5@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: lfQq-CHW-M3dcK6cu3U_ienmjoyz1sBb
X-Proofpoint-ORIG-GUID: lfQq-CHW-M3dcK6cu3U_ienmjoyz1sBb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 impostorscore=0 mlxlogscore=837 mlxscore=0 spamscore=0 phishscore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501020052



On 12/13/2024 8:37 PM, Konrad Dybcio wrote:
> On 13.12.2024 2:49 PM, Manikanta Mylavarapu wrote:
>> Enable the PCIe controller and PHY nodes corresponding to RDP466.
>>
>> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
>> ---
> 
> 
>>  arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts | 43 +++++++++++++++++++++
>>  1 file changed, 43 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts b/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts
>> index d4d31026a026..8857b64df1be 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts
>> +++ b/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts
>> @@ -45,6 +45,26 @@ data-pins {
>>  			bias-pull-up;
>>  		};
>>  	};
>> +
>> +	pcie2_default_state: pcie2-default-state {
>> +		perst-n-pins {
>> +			pins = "gpio31";
>> +			function = "gpio";
>> +			drive-strength = <8>;
>> +			bias-pull-up;
>> +			output-low;
>> +		};
>> +	};
> 
> Drop the inner wrapper, in both definitions /\ \/
> 
> Konrad
> 

Okay, sure.

Thanks & Regards,
Manikanta.

