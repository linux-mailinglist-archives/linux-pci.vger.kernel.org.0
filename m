Return-Path: <linux-pci+bounces-5825-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CEF89AC6B
	for <lists+linux-pci@lfdr.de>; Sat,  6 Apr 2024 19:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB532281C44
	for <lists+linux-pci@lfdr.de>; Sat,  6 Apr 2024 17:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF893B18D;
	Sat,  6 Apr 2024 17:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hZV0VKF/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45B0381C2;
	Sat,  6 Apr 2024 17:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712423941; cv=none; b=UZwEA9wS5xo392hGgnx3GWmVEOIJqUV9xeJ8IWfukH5V3sY0PHxzuO0WgRd8Q0bBjibvrLgjVebGrOCTZOzBom/vnz/ygUvXxOtpBUV+pM3l0RF0y6ygxBFUrfimQOy4Rtyt91Z8W/9YNMM4DakjjhWExCFdw19ypTpSPUVOdbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712423941; c=relaxed/simple;
	bh=FTrOH0OlOjWrK3A0l8wznAoEtxiq1cIfTifGsp+jt+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ewa0ZSNRaXn6Beaes6FlCvup3C/145oEoNLnIyCV1A7/O+Idmh7WPac53uSwxroyvgQ3+bd3dPljwP/cLlqs92xrroRImfo5RRg7aBC2SRe4Etw/1fcmS8IMTh34LuUBPPWOIAOeayFT/0eprJBiGiq7xpk4dH5tNiMorB3vwrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hZV0VKF/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 436HACiE017060;
	Sat, 6 Apr 2024 17:18:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=nAEQxXw+XRp9uZGd5HCvDnmTyd3ZDuxqbC75fH5/7VA=; b=hZ
	V0VKF/XyDc2l6bqY8V4L8Hds+OAqM21wtlU4JMPzzkr3xWmaTP9//vSbhvVB3YF7
	yN0XQ7jALOZ4vkoVzeXq/YzfRCuowRnkhaARto6YTz2ZPty0YJ4CNaeYuwK9uZHN
	JzyBzxUcL/iqeN0KhMXjOy+m30OkgNLRjms6HB48iuQJNehBdB3QYHFsIzxHnhNq
	vugnJ5PcpZol8WnSsHjelG2p4q7bEm3B8SokiJDnED6xW2rtszEhFo7QW3TgZ9pT
	H5gmoueXYJLU8rcuAmNUk9DkSxWluLTVGCKkk6G2Yh1UsN9hxc21KlGKZsPFNZp+
	gZxfzEoeHtB/Jv3otrNg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xax04gsrn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 06 Apr 2024 17:18:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 436HIg73016124
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 6 Apr 2024 17:18:42 GMT
Received: from [10.216.54.180] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 6 Apr 2024
 10:18:34 -0700
Message-ID: <b9b3c698-fbf3-a2d0-3420-4b33016a5560@quicinc.com>
Date: Sat, 6 Apr 2024 22:48:29 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v8 2/7] arm64: dts: qcom: sm8450: Add interconnect path to
 PCIe node
Content-Language: en-US
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>
CC: Bjorn Andersson <andersson@kernel.org>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?=
	<kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rob
 Herring" <robh+dt@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        "Brian
 Masney" <bmasney@redhat.com>,
        Georgi Djakov <djakov@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <vireshk@kernel.org>,
        <quic_vbadigan@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_parass@quicinc.com>
References: <20240302-opp_support-v8-0-158285b86b10@quicinc.com>
 <20240302-opp_support-v8-2-158285b86b10@quicinc.com>
 <4bd2e661-8e1e-41ff-9b7f-917bb92a196d@linaro.org>
 <20240405074044.GC2953@thinkpad>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20240405074044.GC2953@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: szxG_ZrRKvw6_b92RnkY6ajW2_sFXmSw
X-Proofpoint-ORIG-GUID: szxG_ZrRKvw6_b92RnkY6ajW2_sFXmSw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-06_13,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404060136



On 4/5/2024 1:10 PM, Manivannan Sadhasivam wrote:
> On Wed, Mar 06, 2024 at 05:04:54PM +0100, Konrad Dybcio wrote:
>>
>>
>> On 3/2/24 04:59, Krishna chaitanya chundru wrote:
>>> Add pcie-mem & cpu-pcie interconnect path to the PCIe nodes.
>>>
>>> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>>> ---
>>>    arch/arm64/boot/dts/qcom/sm8450.dtsi | 8 ++++++++
>>>    1 file changed, 8 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>>> index 01e4dfc4babd..6b1d2e0d9d14 100644
>>> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>>> @@ -1781,6 +1781,10 @@ pcie0: pcie@1c00000 {
>>>    					<0 0 0 3 &intc 0 0 0 151 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
>>>    					<0 0 0 4 &intc 0 0 0 152 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
>>> +			interconnects = <&pcie_noc MASTER_PCIE_0 0 &mc_virt SLAVE_EBI1 0>,
>>
>> Please use QCOM_ICC_TAG_ALWAYS.
>>
>>> +					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_PCIE_0 0>;
>>
>> And this path could presumably be demoted to QCOM_ICC_TAG_ACTIVE_ONLY?
>>
> 
> I think it should be fine since there would be no register access done while the
> RPMh is put into sleep state. Krishna, can you confirm that by executing the CX
> shutdown with QCOM_ICC_TAG_ACTIVE_ONLY vote for cpu-pcie path on any supported
> platform?
> 
> But if we do such change, then it should also be applied to other SoCs.
> 
> - Mani
>
we don't a have platform to test this now, we will keep
QCOM_ICC_TAG_ALWAYS for now.

- Krishna Chaitanya.


