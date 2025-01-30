Return-Path: <linux-pci+bounces-20566-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5E7A228FB
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jan 2025 07:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A19B166B13
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jan 2025 06:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A83C1991CD;
	Thu, 30 Jan 2025 06:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="C7ZWaSs3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B6C1531DC;
	Thu, 30 Jan 2025 06:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738220189; cv=none; b=XrEkANjBeg3uwX0CpbS5HtuWST/4LczqotG/qGl6uVpt3LkT9/iknwiPewltl899R6pdit4ul+CzIEdxxNjGJbQvoAn0haLJSDeDlHs6PkxMM6ObH6p2QskDp22b/KWjdz742nEccMUp3crH4hGaTJsyLB8BFDeqBLk4x0CvvCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738220189; c=relaxed/simple;
	bh=bDUDa2kKJ2m28/SuqJvaFEwQArNQYtW+ACO7M0a6Mjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PthKhbNTxfBSKjb/me29pZaofQDcPbYg+WLUe973rjkDfog7DUKEBn6Qk8W/KiglYKH+YwALiTufiHicqyLI27G2cJVTfExs05maTq96PpGm+5Fs4xQ1MibOsqGy4zT4GgzsCkwB29nuRRFKUGBtIK3lfA/WA6UDDZJC6u701PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=C7ZWaSs3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50U2qp4c016525;
	Thu, 30 Jan 2025 06:56:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gOPD14HMCAKE464aezTE9xvjjU7zGIU5KHQ4DrNH65M=; b=C7ZWaSs3a4xIPnRi
	CJA5L98rswKmHdt60h0A/jPwndVUoVmHCNAlfPDi1mobdtts6CGFx9Cp/aw7IJoD
	FLkRqGCBPumNe+AgEiUvuQpQa8/jjO9dJBN0dX2rjOvpyfn98VvPdrcEIaATNHu8
	yrAmKTF3XoupapOJA4g21XrDTOt5OIZ2cS2BBUHkHxrYh14Jcgu6RJ433PCoMOhh
	770CSOMfLb02/ZYU0ddihdP1Xsrk/RE/VXFKIaZABx6cz9PtLnBpuKipeKJe/ZuX
	nW7Gaw4kw2Ntt2OtkaiLQHAyGprhvkms5LAgPMXGVRNzX7ip5DneRmZ6s/PMpvti
	mcO19A==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44fwe28r5w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 06:56:19 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50U6uIC2025170
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 06:56:18 GMT
Received: from [10.152.195.140] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 29 Jan
 2025 22:56:13 -0800
Message-ID: <1c30cce4-eb9f-4fb9-b454-c6f5de604237@quicinc.com>
Date: Thu, 30 Jan 2025 12:26:10 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] dt-bindings: clock: update interconnect cells for
 ipq5424
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
 <20250125035920.2651972-3-quic_mmanikan@quicinc.com>
 <56dfc864-9a7e-4954-a7f6-91ff6b6d05ec@oss.qualcomm.com>
Content-Language: en-US
From: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
In-Reply-To: <56dfc864-9a7e-4954-a7f6-91ff6b6d05ec@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: c102XWjtmUQa_Gq7Bf8umocxBRUsgq2Y
X-Proofpoint-GUID: c102XWjtmUQa_Gq7Bf8umocxBRUsgq2Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_03,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 adultscore=0 phishscore=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501300052



On 1/28/2025 4:56 PM, Konrad Dybcio wrote:
> On 25.01.2025 4:59 AM, Manikanta Mylavarapu wrote:
>> Interconnect cells differ between the IPQ5332 and IPQ5424.
>> Therefore, update the interconnect cells according to the SoC.
>>
>> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
>> ---
>>  .../devicetree/bindings/clock/qcom,ipq5332-gcc.yaml       | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/clock/qcom,ipq5332-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,ipq5332-gcc.yaml
>> index 1230183fc0a9..fac7922d2473 100644
>> --- a/Documentation/devicetree/bindings/clock/qcom,ipq5332-gcc.yaml
>> +++ b/Documentation/devicetree/bindings/clock/qcom,ipq5332-gcc.yaml
>> @@ -35,8 +35,6 @@ properties:
>>        - description: PCIE 2-lane PHY3 pipe clock source
>>  
>>    '#power-domain-cells': false
>> -  '#interconnect-cells':
>> -    const: 1
>>  
>>  required:
>>    - compatible
>> @@ -54,6 +52,9 @@ allOf:
>>          clocks:
>>            maxItems: 5
>>  
>> +        '#interconnect-cells':
>> +          const: 1
>> +
>>    - if:
>>        properties:
>>          compatible:
>> @@ -65,6 +66,9 @@ allOf:
>>            minItems: 7
>>            maxItems: 7
>>  
>> +        '#interconnect-cells':
>> +          const: 2
> 
> Please apply some criticism to the review comments you receive.. this only
> makes sense for platforms using icc-rpm or icc-rpmh.
> 
> Since this driver registers an interconnect provider through icc_clk APIs,
> it explicitly uses a simple, onecell translation function to .get the nodes
> 
> Please drop this patch


Hi Konrad,

Thank you for pointing this.
I will drop the patch.

Thanks & Regards,
Manikanta.

