Return-Path: <linux-pci+bounces-20437-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5341BA204EE
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 08:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C708F163DDA
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 07:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11021C75E2;
	Tue, 28 Jan 2025 07:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aXBuOYiL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11524192D84;
	Tue, 28 Jan 2025 07:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738048359; cv=none; b=BCZrG998TfP34aXoZb7Lm5EczPp1EH2/bVvOhb3LApg9jQqWDRFKwaD38s6y8KVQhWFcto2PAlgNiC6+KdII3y3HL2ER4j7B9RI0fM9sf5vbKE+1Z1ith7J3I/i3auia8Qj5Esj0fquZosh+AWSOzGdzswnNIpkkkuch+trFFrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738048359; c=relaxed/simple;
	bh=3Hq/aQRA6XtpaP8m2hWyIrpgOuAkx1dzItP3xXOz7g4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aSAqEEM9FVEregXYfouzp7+sV6bcgth5HSGMgm8V5fQdsdz7dQ9jHGC3D7SEsU3e+9diUEAR+3DikfFhHubbvmIz5E5Y9KvntDbaeznaDOVCqcG/HF2ZnpuUXniKB/5fCOoO1ml9n5G6YryrVBtkIQLvgC4H6AzwOXbbyoEt+Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aXBuOYiL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50S5qXjC028267;
	Tue, 28 Jan 2025 07:12:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AD7gsPnSNQeBvV3Zwp8fvkKBiRLpeCVhXd7KYhv2Uz4=; b=aXBuOYiL/VNAPq+v
	6PbIxhonFiLWK7Aw3beMaIpZQSWxncI5baciarnLZLbcACHy0jR14+JuY/ii0L9s
	IEf3sPeF6R5yy7A7p1visnohnVCs1B043AvOS6Y5vxDK5RSE2IRap/SY6x+RxqXY
	pstg5K18KjDKvy1hnGBI/qkJsHJHqXGsqh+GOaW8MIKCiSfftt2sU9dNMQCf71+w
	8LVOUkKyd/nEQKdL+JVvE5YH5k6OWvuozylLIFmVaTrG0U2wb3SoqqMiCuIUn3yf
	wG5YEOn4hJZkjMQohgGxZZM6qzKIt+iAd3mf18wyq/+73EDUqQkm56LAdjj6y7wY
	Xci63g==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44esfq071d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 07:12:31 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50S7CUIv032677
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 07:12:30 GMT
Received: from [10.152.195.140] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 27 Jan
 2025 23:12:23 -0800
Message-ID: <fe34b401-e9a8-4a69-853c-4bcd468e6cc7@quicinc.com>
Date: Tue, 28 Jan 2025 12:42:19 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] dt-bindings: clock: update interconnect cells for
 ipq5424
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <bhelgaas@google.com>,
        <konradybcio@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
References: <20250125035920.2651972-1-quic_mmanikan@quicinc.com>
 <20250125035920.2651972-3-quic_mmanikan@quicinc.com>
 <20250127-amethyst-capybara-from-uranus-5e6bf4@krzk-bin>
Content-Language: en-US
From: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
In-Reply-To: <20250127-amethyst-capybara-from-uranus-5e6bf4@krzk-bin>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HGZM0DjtlzhOkKvK2dHA0wC0vy-mq6IE
X-Proofpoint-ORIG-GUID: HGZM0DjtlzhOkKvK2dHA0wC0vy-mq6IE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_02,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501280053



On 1/27/2025 12:57 PM, Krzysztof Kozlowski wrote:
> On Sat, Jan 25, 2025 at 09:29:18AM +0530, Manikanta Mylavarapu wrote:
>> Interconnect cells differ between the IPQ5332 and IPQ5424.
>> Therefore, update the interconnect cells according to the SoC.
> 
> Why do they differ? Why they cannot be the same?
> 

Based on the comment received here [1], i updated interconnect cells to 2
to accommodate icc tags for IPQ5424.

[1]: https://lore.kernel.org/linux-arm-msm/20250119124551.nl5272bz36ozvlqu@thinkpad/

I will update interconnect cells to 2 for IPQ5332 as well.

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
> 
> Properties are always defined top-level or in other schema.

I will define it in top-level and initialize with 2.

Thanks & Regards,
Manikanta.

