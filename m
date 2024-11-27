Return-Path: <linux-pci+bounces-17380-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 074139DA06D
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 02:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A72121658DA
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 01:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3CA14263;
	Wed, 27 Nov 2024 01:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FJdg0jpL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EEC28E8;
	Wed, 27 Nov 2024 01:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732671766; cv=none; b=ZuV5xc1HIQbniHP5aLGyw0PLEr0XRGecYgiM0WIwvJbmFxXu4klpM2O/E57xXsc33YCinS3YdSOoQdlY/EZdQaWR1XNTGA9c6wSBZQsurpg+PYlIP3l9fO9QEgZFd3UaoZWJZtTIg9Qr38ZLCFWUE2Yn6YrRz724IiXSuR7PhbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732671766; c=relaxed/simple;
	bh=W+y24p0JQZmblXrM2wuNDcuR7LGrAv4BH99beYTBo78=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rTxqlBWz3t0GKDb4XdzQvzN3hXpl4o5f0+wiMw4i9gkCsAiIJJca1YYnEMpQquT8RZHzcpoHN/045qystW3VSxp7bZeqDhqbMIsFx0OFxdQtMjbDm5WAJ7uA5L3H4sJuHnFdIJmDhTkIH7VraTz3fy7/lFezFgMaGxHBAaGdayk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FJdg0jpL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQKKxGB028826;
	Wed, 27 Nov 2024 01:42:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OrONQ+CWoo/0YARp8CoV9PkeUGcON1u1GMLGMH9wdJw=; b=FJdg0jpLsjECGTus
	6WUCG60EtrjrkwHv0MWeSIbtXo9URssMwdyQAdiIVTYE2/MpYcrefnmVPIw94u3r
	MWSoEEadVzmXHm4i3Gnu4vNuGqFtjiAMKpswIuZBfvtCtzaDjA20aLlGuHa4HjOC
	hHydaZfN9WRUa8PViRvIm40fz8bfPun9EUf9xh7FidCun5dck2jpXyth7Wd6TY77
	xhMf3EsFtp6blpKAhjmsCdWm0WLAGmlVrnecYO8v6dJR41YnJECZCEXqrVmki+Qu
	kk5oX5iLR09MyoaMWUq5mJ6AlB4xIkEetWGMbZaEqguSkSoGrkCVloVoQAIejZnT
	xYEnfQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 434nyg61tn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 01:42:33 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AR1gRxW004857
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 01:42:27 GMT
Received: from [10.216.8.10] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 26 Nov
 2024 17:42:19 -0800
Message-ID: <9ff459ed-4491-4bd4-1402-622d9c31cb71@quicinc.com>
Date: Wed, 27 Nov 2024 07:12:16 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/4] arm64: dts: qcom: x1e80100: Add PCIe lane
 equalization preset properties
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, <quic_mrana@quicinc.com>,
        <quic_vbadigan@quicinc.com>, <kernel@quicinc.com>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han
	<jingoohan1@gmail.com>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
References: <20241116-presets-v1-0-878a837a4fee@quicinc.com>
 <20241116-presets-v1-1-878a837a4fee@quicinc.com>
 <5648484f-38f2-4c75-b8a3-7a0148dc940b@oss.qualcomm.com>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <5648484f-38f2-4c75-b8a3-7a0148dc940b@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wZDQKUsZMpz6e0I4pL6xTejUgl1-tWfW
X-Proofpoint-ORIG-GUID: wZDQKUsZMpz6e0I4pL6xTejUgl1-tWfW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 mlxlogscore=768 clxscore=1015 mlxscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411270012



On 11/16/2024 4:49 PM, Konrad Dybcio wrote:
> On 16.11.2024 2:37 AM, Krishna chaitanya chundru wrote:
>> Add PCIe lane equalization preset properties for 8 GT/s and 16 GT/s data
>> rates used in lane equalization procedure.
>>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/x1e80100.dtsi | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
>> index a36076e3c56b..6a2074297030 100644
>> --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
>> @@ -2993,6 +2993,10 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
>>   			phys = <&pcie6a_phy>;
>>   			phy-names = "pciephy";
>>   
>> +			eq-presets-8gts = /bits/ 16 <0x5555 0x5555>;
> 
> If we make all of these presets u8 arrays, we can use the:
> 
> property = [0xff 0xff 0xff 0xff];
> 
> syntax
> 
> Konrad
we can't make the property as u8 as each index represents single lane
and for 8 GT/s data rates each value needs 16bits. So for 8 GT/s we have
to use u16 array only.

- Krishna Chaitanya.

