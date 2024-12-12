Return-Path: <linux-pci+bounces-18283-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0B89EE6C6
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 13:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DA9518818BD
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 12:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D18211493;
	Thu, 12 Dec 2024 12:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ohdHzdtd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555A4259484;
	Thu, 12 Dec 2024 12:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734006785; cv=none; b=Yl5Q/yS7qe9dCLSiEFh3BVPEOhZwtLEtmFLsi9m6JM0iFBvHBdAiREB/u8H/PenKKhtGKpndY1Vul1BYoyokVG4qhIpu/IZ7cwQgV/v+fFo8kE7JsngXCABsI/37h1kMdUuVmq3ej/T3Z895BhCDJldqnd0kfnn4H+ANar3yyrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734006785; c=relaxed/simple;
	bh=vH0vBgFuIe8dDQ82xJv2ZSv/AxtME3Gh1/IaUDDFNA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Of70ZAPMzqEvWAYXgO9LMXNmlLwSGCEFwqJlozv+jB9rcf7UOkD0gykvvUZOD7VOsKtpABSmdbNZGR+Tlst3EyggpBJDAs1syiPvrSTexzcpO432aorQSc7G8w1xu3NzJRvPRpl/ef/rFXcLDEIOGgqmkPUv9fL0p+NCZwnn/Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ohdHzdtd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BC7qN6A002529;
	Thu, 12 Dec 2024 12:32:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7acbIkWM4iLpk4O9f9O/RM9xgv/bfIBosml57CWE0is=; b=ohdHzdtdf8R+wbL3
	POeObIWBZ/yrEvEWLM77ztBUSGC33JXlJi2E9RJ+rvI1IqonZOykC4owwPHSIyf3
	Ye+KaonE7ad6vwHf8CwaYQ5DcZRWtibtkJ4ai6EiJfAQqp9htweJXbzLCE0c1qrw
	Az13Q9X1azUXX8bL40f1e5S5JQof6uFAg0TTE3Uyu3XJBY+6BueulF7qWYFz5/wV
	4HqrcIRXdAf+FxyfVS6xYeUwTXsJG61NKuVEUJ8YDfxG+KKxNvGkDKu85NsrW9SJ
	BdlrhjYA5p7+ajgfg7ERvZ7XYIXHxJdyguVocJjRbHWRmYH+7l82mwU2r+w1t1BH
	DMwrsA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43eyg65du0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 12:32:56 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BCCWtfM002899
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 12:32:55 GMT
Received: from [10.216.33.6] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 12 Dec
 2024 04:32:48 -0800
Message-ID: <bd9d0b2b-cb69-3a20-8ae6-125c7010c1e5@quicinc.com>
Date: Thu, 12 Dec 2024 18:02:43 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/4] arm64: dts: qcom: x1e80100: Add PCIe lane
 equalization preset properties
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Krishna Chaitanya Chundru
	<krishna.chundru@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Bjorn
 Helgaas" <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        "Manivannan Sadhasivam" <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <konrad.dybcio@oss.qualcomm.com>, <quic_mrana@quicinc.com>,
        <quic_vbadigan@quicinc.com>, Bjorn Andersson <andersson@kernel.org>,
        "Konrad
 Dybcio" <konradybcio@kernel.org>
References: <20241212-preset_v2-v2-0-210430fbcd8a@oss.qualcomm.com>
 <20241212-preset_v2-v2-1-210430fbcd8a@oss.qualcomm.com>
 <beb7d859-8d68-49d9-8a35-b2ba50f00c33@kernel.org>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <beb7d859-8d68-49d9-8a35-b2ba50f00c33@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: f8lcgAskl-7SgMQOOXfB5qsby9pTC7_K
X-Proofpoint-ORIG-GUID: f8lcgAskl-7SgMQOOXfB5qsby9pTC7_K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120090



On 12/12/2024 5:55 PM, Krzysztof Kozlowski wrote:
> On 12/12/2024 11:32, Krishna Chaitanya Chundru wrote:
>> From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>>
>> Add PCIe lane equalization preset properties for 8 GT/s and 16 GT/s data
>> rates used in lane equalization procedure.
>>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
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
>> +
>> +			eq-presets-16gts = /bits/ 8 <0x55 0x55>;
> NAK for two reasons (stated many times during review):
> 1. There is no way driver code can depend on DTS, unless you fix
> something serious but nothing is explained about that serious fix in
> commit msg.
> 
Please ignore this series as the main patch was missing in this series,
I will resend this after adding missing patch shortly, currently facing
issues with git config on my system. If you look in to v1 patch there is
driver patch which is missing in this series. I will fix it next series.
> 2. There are no such properties. It does not look like you tested the
> DTS against bindings. Please run `make dtbs_check W=1` (see
> Documentation/devicetree/bindings/writing-schema.rst or
> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
> for instructions).
The property is added recently in to the dtschema in github repo, I
added the pull request details in the cover letter, I will add the
github link as part of the comment section for this patch in next
series.

- Krishna Chaitanya
> 
> Best regards,
> Krzysztof

