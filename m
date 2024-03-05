Return-Path: <linux-pci+bounces-4515-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A328871C94
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 12:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 008B2285033
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 11:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED465A78D;
	Tue,  5 Mar 2024 10:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Rmm6d+2K"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8B65A787;
	Tue,  5 Mar 2024 10:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709636303; cv=none; b=eI5dwN9Nb9o2LP82W48MHCgVfbDu5/Av4ILws3yrJXQr8D5LYR5/XzRse39M2KQE4fVVirZl2fFdwjMdCgQdaIi4Gif1Vv/vZ3KJp/TVCCTzd9xKGaIS8FhqcHNvtG6IbLy2hOT36eWBgMZcYz1pmqJi0w2tDrheJGJRNzDY7vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709636303; c=relaxed/simple;
	bh=J5Baa+RIs5c1/+F+2dLX0DQE2pCW8Qxha1uK7wrtN/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lYVbeb9hY6psezRZhz1I+sMHIird9TTjuwqZ3qD+6D+Rg99GtrsHWp9u++4D6WCeb0zsCWf8EEytk/hEzVkO9Codk/ygWo7sI2DtKaqTFM2v6s21OgbE/PykkVJ4g37wisXocqT7RALPiS7bx7LCZ2AhwQg2cc2TK4D+bvVNC94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Rmm6d+2K; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4258XZMm008515;
	Tue, 5 Mar 2024 10:58:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=V0i8aVBJZSZ2LMZ0idyX+tr3gaOtJGswEKZkTKjXW+A=; b=Rm
	m6d+2KB5V0LpD2AgvkiIMmad5vg1rlN+shDpOMBqhUqyYIPg/a5pszF7j+RELL34
	PuoNNuZPUw0x+TJf9yVRwGxwdPw+o6Bu7Ul2rNPLbUTTT3Lsy9fjbueMQ2nzH3wO
	0lf6tQ+Mv3FMQWeERZa/li1JvFv5DP+vtFZ5aMd+BlZuxyOV/fywi/H3eTUSNV4W
	3KccSMMHw9WQfKiZa0M0x8v7OeRLGFg8AQ7ikTMzoXLTgo6xtkk62iHNy5CSqGJV
	7hNsLooxQh799t9f0PHpgwNOOU6aJW+32qdowYxRz7p5+G435cNTN7xztUB1kjHW
	BQjd/QdtdyiVO6uUZBSw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wnyyb89sw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Mar 2024 10:58:10 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 425Aw9kd019230
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 5 Mar 2024 10:58:09 GMT
Received: from [10.216.9.163] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 5 Mar
 2024 02:58:01 -0800
Message-ID: <86ce6b70-1c84-6e0d-528c-40fff7bf8326@quicinc.com>
Date: Tue, 5 Mar 2024 16:27:47 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v8 5/7] arm64: dts: qcom: sm8450: Add opp table support to
 PCIe
Content-Language: en-US
To: Manivannan Sadhasivam <mani@kernel.org>
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
References: <20240302-opp_support-v8-0-158285b86b10@quicinc.com>
 <20240302-opp_support-v8-5-158285b86b10@quicinc.com>
 <20240304174917.GC31079@thinkpad>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20240304174917.GC31079@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: sOaJXAaEzVyYVOrt4zirOe5rBfthHK9D
X-Proofpoint-GUID: sOaJXAaEzVyYVOrt4zirOe5rBfthHK9D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_08,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 bulkscore=0 phishscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403050088



On 3/4/2024 11:19 PM, Manivannan Sadhasivam wrote:
> On Sat, Mar 02, 2024 at 09:29:59AM +0530, Krishna chaitanya chundru wrote:
>> PCIe needs to choose the appropriate performance state of RPMH power
>> domain and interconnect bandwidth based up on the PCIe gen speed.
>>
>> Add the OPP table support to specify RPMH performance states and
>> interconnect peak bandwidth.
>>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sm8450.dtsi | 74 ++++++++++++++++++++++++++++++++++++
>>   1 file changed, 74 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>> index 6b1d2e0d9d14..662f2129f20d 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>> @@ -1827,7 +1827,32 @@ pcie0: pcie@1c00000 {
>>   			pinctrl-names = "default";
>>   			pinctrl-0 = <&pcie0_default_state>;
>>   
>> +			operating-points-v2 = <&pcie0_opp_table>;
>> +
>>   			status = "disabled";
>> +
>> +			pcie0_opp_table: opp-table {
>> +				compatible = "operating-points-v2";
>> +
>> +				opp-2500000 {
> 
> Add the comments that you added below.
ACK.
> 
>> +					opp-hz = /bits/ 64 <2500000>;
>> +					required-opps = <&rpmhpd_opp_low_svs>;
>> +					opp-peak-kBps = <250000 1>;
> 
> Isn't the peak bw should be greater that the avg bw? Atleast in upstream we
> follow that pattern.
> 
> - Mani
The two values which are defined are for peak BW only one value 
corresponds to PCI-MEM path and other to CPU to PCIe path.
- Krishna Chaitanya.
> 
>> +				};
>> +
>> +				opp-5000000 {
>> +					opp-hz = /bits/ 64 <5000000>;
>> +					required-opps = <&rpmhpd_opp_low_svs>;
>> +					opp-peak-kBps = <500000 1>;
>> +				};
>> +
>> +				opp-8000000 {
>> +					opp-hz = /bits/ 64 <8000000>;
>> +					required-opps = <&rpmhpd_opp_nom>;
>> +					opp-peak-kBps = <984500 1>;
>> +				};
>> +			};
>> +
>>   		};
>>   
>>   		pcie0_phy: phy@1c06000 {
>> @@ -1938,7 +1963,56 @@ pcie1: pcie@1c08000 {
>>   			pinctrl-names = "default";
>>   			pinctrl-0 = <&pcie1_default_state>;
>>   
>> +			operating-points-v2 = <&pcie1_opp_table>;
>> +
>>   			status = "disabled";
>> +
>> +			pcie1_opp_table: opp-table {
>> +				compatible = "operating-points-v2";
>> +
>> +				/* GEN 1x1 */
>> +				opp-2500000 {
>> +					opp-hz = /bits/ 64 <2500000>;
>> +					required-opps = <&rpmhpd_opp_low_svs>;
>> +					opp-peak-kBps = <250000 1>;
>> +				};
>> +
>> +				/* GEN 1x2 GEN 2x1 */
>> +				opp-5000000 {
>> +					opp-hz = /bits/ 64 <5000000>;
>> +					required-opps = <&rpmhpd_opp_low_svs>;
>> +					opp-peak-kBps = <500000 1>;
>> +				};
>> +
>> +				/* GEN 2x2 */
>> +				opp-10000000 {
>> +					opp-hz = /bits/ 64 <10000000>;
>> +					required-opps = <&rpmhpd_opp_low_svs>;
>> +					opp-peak-kBps = <1000000 1>;
>> +				};
>> +
>> +				/* GEN 3x1 */
>> +				opp-8000000 {
>> +					opp-hz = /bits/ 64 <8000000>;
>> +					required-opps = <&rpmhpd_opp_nom>;
>> +					opp-peak-kBps = <984500 1>;
>> +				};
>> +
>> +				/* GEN 3x2 GEN 4x1 */
>> +				opp-16000000 {
>> +					opp-hz = /bits/ 64 <16000000>;
>> +					required-opps = <&rpmhpd_opp_nom>;
>> +					opp-peak-kBps = <1969000 1>;
>> +				};
>> +
>> +				/* GEN 4x2 */
>> +				opp-32000000 {
>> +					opp-hz = /bits/ 64 <32000000>;
>> +					required-opps = <&rpmhpd_opp_nom>;
>> +					opp-peak-kBps = <3938000 1>;
>> +				};
>> +			};
>> +
>>   		};
>>   
>>   		pcie1_phy: phy@1c0e000 {
>>
>> -- 
>> 2.42.0
>>
> 

