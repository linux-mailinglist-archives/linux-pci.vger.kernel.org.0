Return-Path: <linux-pci+bounces-20525-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8878CA21AC0
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 11:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDAB71649C8
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 10:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316FC1A9B40;
	Wed, 29 Jan 2025 10:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hqiu30rH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7630D16C854;
	Wed, 29 Jan 2025 10:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738145512; cv=none; b=U+tgHr5M7Rp/2kaTjpRpybl1h1twn1H+M0TiYe1fd/fjjhPZhYmdcTyDGIdX0rGh1X8npRV/WzBHe4iP9CtPnrcQr6G/QqSyoEK4F2CbihKECti/+62GA1cI6uLj7gDkMHgWSjjB+t771sUwfnPiMDs5/mUgDCL9ivBIx3RWeWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738145512; c=relaxed/simple;
	bh=tBkppjVXsn9B2MEol1Nn2brAXT24xOJpyu7reeKlEI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eCulsgPXgXXFAIRchEtZd8SVmKjuj8hMaeD0YEBeVj0/AoJl4+pSumM/f1RzU4NTmdYDDMRRe0ziKJXSco4Dpxgab6jpM8DUlcsUB7XqUOJiJoNTvk1+ywYt69EzQt9lXEWT9LhoWOHmc9NM/rF8prK6xYjxIdI/qBQ9tdE5hvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hqiu30rH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50T8Sodc012740;
	Wed, 29 Jan 2025 10:11:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/bT1gqjk4MonCeC0VkfnwWluu7UqtmxAs1W41GSbqFY=; b=hqiu30rHF3VqJpVG
	DFZuy2vPxanMzwwxWoh+VyvNC/XAM+UtOxfuFKZaD4hxOJOX9iRbYKexgniCiaYx
	vbt8UQj2gxuU2f7eqXJccG4XelgEbdNa87jTiQIjGHCISuTOfv9k/g4JvoW5Uefm
	gRXrnsUEh3GKFy0qmUw9sIOudM32UJdILNh8qj8p8sYtRr4TQ/E2PTcge4Uigx7G
	SAn426HpkQExMUJnfnzrOmqeJbxhgX3Gj6iFGWpM+69oZqfKAa9QweJtDXwwUqmV
	9Lj5s7hYmACVeu4qTkqeBuy0qRUaQHMFUXhpQvcaYT82ZCLaoZSAvPQN5h53sgFR
	TytNJA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44fguvg5rr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 10:11:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50TABc0E005382
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 10:11:38 GMT
Received: from [10.152.195.140] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 29 Jan
 2025 02:11:32 -0800
Message-ID: <a6d01332-1f3a-483e-ad32-49265bdda4b0@quicinc.com>
Date: Wed, 29 Jan 2025 15:41:29 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] arm64: dts: qcom: ipq5424: Enable PCIe PHYs and
 controllers
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, <andersson@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <manivannan.sadhasivam@linaro.org>,
        <bhelgaas@google.com>, <konradybcio@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
CC: <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
References: <20250125035920.2651972-1-quic_mmanikan@quicinc.com>
 <20250125035920.2651972-5-quic_mmanikan@quicinc.com>
 <3e92c8e2-7745-4205-8a48-5ef783b098a2@oss.qualcomm.com>
Content-Language: en-US
From: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
In-Reply-To: <3e92c8e2-7745-4205-8a48-5ef783b098a2@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: JACaO_Pl-Hfslr77pklejouLWdAfKZs7
X-Proofpoint-GUID: JACaO_Pl-Hfslr77pklejouLWdAfKZs7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 mlxlogscore=933 bulkscore=0 suspectscore=0
 mlxscore=0 adultscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501290083



On 1/28/2025 5:09 PM, Konrad Dybcio wrote:
> On 25.01.2025 4:59 AM, Manikanta Mylavarapu wrote:
>> Enable the PCIe controller and PHY nodes corresponding to RDP466.
>>
>> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
>> ---
>> Changes in V3:
>> 	- No change.
>>
>>  arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts | 41 ++++++++++++++++++++-
>>  1 file changed, 40 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts b/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts
>> index b6e4bb3328b3..73e6b38ecc26 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts
>> +++ b/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts
>> @@ -53,6 +53,30 @@ &dwc_1 {
>>  	dr_mode = "host";
>>  };
>>  
>> +&pcie2 {
>> +	pinctrl-0 = <&pcie2_default_state>;
>> +	pinctrl-names = "default";
>> +
>> +	perst-gpios = <&tlmm 31 GPIO_ACTIVE_LOW>;
>> +	status = "okay";
> 
> Please add a new line before 'status'
> 

Okay, sure.

>> +};
>> +
>> +&pcie2_phy {
>> +	status = "okay";
>> +};
>> +
>> +&pcie3 {
>> +	pinctrl-0 = <&pcie3_default_state>;
>> +	pinctrl-names = "default";
>> +
>> +	perst-gpios = <&tlmm 34 GPIO_ACTIVE_LOW>;
>> +	status = "okay";
>> +};
>> +
>> +&pcie3_phy {
>> +	status = "okay";
>> +};
>> +
>>  &qusb_phy_0 {
>>  	vdd-supply = <&vreg_misc_0p925>;
>>  	vdda-pll-supply = <&vreg_misc_1p8>;
>> @@ -147,6 +171,22 @@ data-pins {
>>  			bias-pull-up;
>>  		};
>>  	};
>> +
>> +	pcie2_default_state: pcie2-default-state {
>> +		pins = "gpio31";
>> +		function = "gpio";
>> +		drive-strength = <8>;
>> +		bias-pull-up;
>> +		output-low;
>> +	};
>> +
>> +	pcie3_default_state: pcie3-default-state {
>> +		pins = "gpio34";
>> +		function = "gpio";
>> +		drive-strength = <8>;
>> +		bias-pull-up;
>> +		output-low;
> 
> The GPIO APIs are in control of in/out state instead, please remove the
> last property from both entries

Okay, sure.

Thanks & Regards,
Manikanta.

