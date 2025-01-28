Return-Path: <linux-pci+bounces-20436-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7042A204BC
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 08:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC89E3A47B8
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 07:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F45818DF8D;
	Tue, 28 Jan 2025 07:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="F7iDgtvW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0004430;
	Tue, 28 Jan 2025 07:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738047662; cv=none; b=OttaO1q4P6cfM9tgFIUb90H1Mk1RFX8n0/EFSoPwBmQDSbCEJTwqu+ztjPeRs6RokUCNQFF6W2XA4uA3OEmwb4+EnZTagduILnLjIvFYJCHbYOvuOzLrrUe0RgOftQnSTbYJDApx3tRZtOnXcTGUuFgUf460BIFYSrm9CF3Vang=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738047662; c=relaxed/simple;
	bh=NOM2bU6XycdpJgQWcIi8dSw5Fs5gJR5xytaSbnUvBEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=u4iQjcJua0GMOvMMUVFysA7s8zM0pa72CSs5DYEeYt8bjMMfKxZa/GeacZ/3VAGlZTO7UE80rp4IlOLjLxwU+y0zFYH6SrdI04bR3JwfGaXJCEB9l/7oOxwJiv8o10D2ph6RPRwtZepdMYX0Nf3weucphkazWKQiklcTOhFSnPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=F7iDgtvW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50S3oNPc018394;
	Tue, 28 Jan 2025 07:00:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0n2UlLRG3puhOcewoCHetclewZtBDBO0w2dH1NxA2w4=; b=F7iDgtvWEI4HhqQ0
	jNebn8mGoqJFpXviAubJDhXjozmG7vWLeqKHHItekOXErOzBZetwnm6ti8afoQPo
	Yf2MW83/ff+vPkjJxVrhdaIoVsIC9eAs6ynVXeCzkagTLgZPG0mX67qpEeOWJVdL
	VKuILpkG4my0F/S7KDB3LGX5lvq4JhES7pXBKztm+dzcqH9BgEWYkT3lpj2k/Cjx
	lAeiSQoRTTtzguAT9EjPHcScXwUvUAJAxO5Tdha6EQIOAGqc0DChnjWZR5YILSaL
	VefyDWokqQjthMXRL7+IEGdGGJAxLtDzsvjREddC+o1N2utXW6+ASuTGG2HnlxHG
	TVMNOQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44emry0mka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 07:00:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50S70nw3012687
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 07:00:50 GMT
Received: from [10.152.195.140] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 27 Jan
 2025 23:00:43 -0800
Message-ID: <02c7dc71-5048-4736-9e42-ef7a835168a8@quicinc.com>
Date: Tue, 28 Jan 2025 12:30:40 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] dt-bindings: PCI: qcom: add global interrupt for
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
 <20250125035920.2651972-2-quic_mmanikan@quicinc.com>
 <20250127-convivial-wolf-of-eternity-cc1957@krzk-bin>
Content-Language: en-US
From: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
In-Reply-To: <20250127-convivial-wolf-of-eternity-cc1957@krzk-bin>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 0jINNeb6GioEhN076g_JjtpQ8WwPB3On
X-Proofpoint-GUID: 0jINNeb6GioEhN076g_JjtpQ8WwPB3On
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_02,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=853 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501280052



On 1/27/2025 12:55 PM, Krzysztof Kozlowski wrote:
> On Sat, Jan 25, 2025 at 09:29:17AM +0530, Manikanta Mylavarapu wrote:
>> Document the global interrupt found on IPQ5424 platform.
>>
>> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
>> ---
>>  Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>> index 7235d6554cfb..1fd6aea08bf0 100644
>> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>> @@ -49,11 +49,11 @@ properties:
>>  
>>    interrupts:
>>      minItems: 1
>> -    maxItems: 8
>> +    maxItems: 9
>>  
>>    interrupt-names:
>>      minItems: 1
>> -    maxItems: 8
>> +    maxItems: 9
> 
> You just added it for few other devices as well, like sdm845. If you
> raise one part of constrain, then you need to correct each block where
> old constrain was implied.
> 

Hi Krzysztof,

Thank you for reviewing the patch.

I will explicitly set the maxItems for other devices like sdm845 and msm8996 based on the
number of interrupts they support. This will ensure consistency across all devices.

Please correct me if my understanding is wrong.

Thanks & Regards,
Manikanta.

