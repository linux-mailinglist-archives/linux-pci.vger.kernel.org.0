Return-Path: <linux-pci+bounces-17616-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4340A9E3104
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 02:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DC5EB278B4
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 01:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6970317C60;
	Wed,  4 Dec 2024 01:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pyW+3v/1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2E2802;
	Wed,  4 Dec 2024 01:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733277550; cv=none; b=KejbB0KYRs42hBtBlf8fmQ8Cm0ZXRNntH9doUbuOhVxbVdxjUls2aSFKwvr730vCwHgfdxVZd3GsABt4Ak5GiudCMyw992Uobzqb9rlCXgVne1ZETmrMGj68PkhgPbImntNt9z/F6TcX5mPLyHgdKKJMryWZY2hJa4aHAdLs6xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733277550; c=relaxed/simple;
	bh=6px3nMewNz5U3azGAq8dupSl8iP0Ism8ATYbvHM22uY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=R+zt6dwSm9fEAE6FQ1nMF7/hO137wmlEvTRQJZ/P/p184QbU8misNpJeYYVndXGtjB2BxYbL94C2bO0SfjWo+HZNAlrzpZpdAn0wcADc6052aw9GWCeMU0QRSHCPGWKq8HOTLMh8UJAoOfmo4JL8rIkPgkqAVrGgdkUigVP+Pjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pyW+3v/1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B3H2Qtg031188;
	Wed, 4 Dec 2024 01:58:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OlsOEZknfuP2mKF9fzrlKtZr6iB5ieP+FcHOtEu9FkA=; b=pyW+3v/1PJ7ojsqn
	hegA0pqdIijvJl4ov+avNOv8hDs0tKMuZW3lAbdIPKKj4h6i/pPhVrQALZFJUPWb
	CJsUl0N9x24OIsxHaUDBMjq7hKmbXRXFAXrRCD7T3qwIoD/ItqOaS0afVx6Afh+C
	2HNW0RvbeTbaZG8ryo/xQtP7mk59c+0j55icM/uRobL6kM0N8uBf1l7zXsb2d1wf
	5VbC8o092cerFGYl1gjm/9VzqHaKsfO83F4mJ5yPcLDnO8Uy3TbUG8YwsvG4B0/P
	rCk+s2qJYBcctv7VnwKr/7DQb1cZZRkC31O0atb/5ffCKGke08S8F6LZmQlMiYML
	EE4tRQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 439w90tqam-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Dec 2024 01:58:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B41wwcQ013223
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Dec 2024 01:58:58 GMT
Received: from [10.216.45.237] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 3 Dec 2024
 17:58:49 -0800
Message-ID: <064b93db-5e7b-23d2-46e9-b1fe28233def@quicinc.com>
Date: Wed, 4 Dec 2024 07:28:45 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/3] arm64: dts: qcom: sc7280: Increase config size to
 256MB for ECAM feature
Content-Language: en-US
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: <cros-qcom-dts-watchers@chromium.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?=
	<kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, <quic_vbadigan@quicinc.com>,
        <quic_ramkri@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_vpernami@quicinc.com>,
        <quic_mrana@quicinc.com>, <mmareddy@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
References: <20241117-ecam-v1-0-6059faf38d07@quicinc.com>
 <20241117-ecam-v1-1-6059faf38d07@quicinc.com>
 <20241202150648.fwi2wzbdyyedueby@thinkpad>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20241202150648.fwi2wzbdyyedueby@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: wpGnz_c3EvE3_2jUrX-VUlnUbS_d4rB9
X-Proofpoint-GUID: wpGnz_c3EvE3_2jUrX-VUlnUbS_d4rB9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=969 bulkscore=0
 impostorscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412040015



On 12/2/2024 8:36 PM, Manivannan Sadhasivam wrote:
> On Sun, Nov 17, 2024 at 03:30:18AM +0530, Krishna chaitanya chundru wrote:
>> Increase the configuration size to 256MB as required by the ECAM feature.
>> And also move config space, DBI, ELBI, IATU to upper PCIe region and use
>> lower PCIe region entierly for BAR region.
>>
> 
> Is this change compatible with old kernels before commit '10ba0854c5e6 ("PCI:
> qcom: Disable mirroring of DBI and iATU register space in BAR region")'?
> 
> - Mani
No mani, we need this commit '10ba0854c5e6 ("PCI:
 > qcom: Disable mirroring of DBI and iATU register space in BAR region")
for this.

- Krishna Chaitanya.
> 
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sc7280.dtsi | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> index 3d8410683402..a7e3d3e9d034 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> @@ -2196,10 +2196,10 @@ wifi: wifi@17a10040 {
>>   		pcie1: pcie@1c08000 {
>>   			compatible = "qcom,pcie-sc7280";
>>   			reg = <0 0x01c08000 0 0x3000>,
>> -			      <0 0x40000000 0 0xf1d>,
>> -			      <0 0x40000f20 0 0xa8>,
>> -			      <0 0x40001000 0 0x1000>,
>> -			      <0 0x40100000 0 0x100000>;
>> +			      <4 0x00000000 0 0xf1d>,
>> +			      <4 0x00000f20 0 0xa8>,
>> +			      <4 0x10000000 0 0x1000>,
>> +			      <4 0x00000000 0 0x10000000>;
>>   
>>   			reg-names = "parf", "dbi", "elbi", "atu", "config";
>>   			device_type = "pci";
>> @@ -2210,8 +2210,8 @@ pcie1: pcie@1c08000 {
>>   			#address-cells = <3>;
>>   			#size-cells = <2>;
>>   
>> -			ranges = <0x01000000 0x0 0x00000000 0x0 0x40200000 0x0 0x100000>,
>> -				 <0x02000000 0x0 0x40300000 0x0 0x40300000 0x0 0x1fd00000>;
>> +			ranges = <0x01000000 0x0 0x00000000 0x0 0x40000000 0x0 0x100000>,
>> +				 <0x02000000 0x0 0x40100000 0x0 0x40100000 0x0 0x1ff00000>;
>>   
>>   			interrupts = <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>,
>>   				     <GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH>,
>>
>> -- 
>> 2.34.1
>>
> 

