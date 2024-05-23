Return-Path: <linux-pci+bounces-7767-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05ADD8CCB63
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2024 06:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC2E6283154
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2024 04:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C282C13A3E3;
	Thu, 23 May 2024 04:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RPTYm7jl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165B653363;
	Thu, 23 May 2024 04:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716438602; cv=none; b=LpkOYmjI3xxnB8utuHeIz4nvIpSeveSQG0LFgXiw8040uxcpduY6G4IEa6ENTowNwkzzw6kHl0Om5+sHX5WO6SqdN7kO5l5e2prwjc7YONvl2M9fOMOHkAwQCQGdVx/bpQJOLr6DTNuOi4kHQtU70Ca94wasbY73PC3EtHmj1g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716438602; c=relaxed/simple;
	bh=yoojRH4ide105GN6ojTQqE2X18u3pw9SmuGlClZ1oQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eAse0XBY5fdsJa+6WP02wlgB2B04jWzjQe2m3y4Kz4AJl8DSxi7PtmMgp1VaFzhvx0zp5SVCvrUxCsNOMd2QVvrQC1q5TxO4o4SSu/bD4Iju2nZwFrvDN18BjbaawV+qrnaEcaHJwnoUNO12+uqfAs6mNQHArRZIykrWpvUNfqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RPTYm7jl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44N4TmWW014104;
	Thu, 23 May 2024 04:29:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=j4Kb6l8HeqhXUxmTOgLT085k+1NuizCjW5HVIpNYDFA=; b=RP
	TYm7jlmHPZ118QjGvaa6ZkbvXs2MqYZszFimvyDYcCk83jCcJk/BiW2UnEZN7j+2
	Af6B1Ilv3Cd3Rpa/0OA9KQWGDIPLchAXbmNQdJ5MABd/l1/pL+2Pam1c2igPrXXS
	bnY0+dffY4tFSdU1Qz2HJaCMKTV6qgo8IA7u1gzfi88lpUV8+4/WBTeh+tv/ttsz
	t/z9jGzZMb0lYxm41T4MDJ7TXPdpL24o+fbqqyHzI8YOYSSoeAPRC2wWNEsUhLMm
	fhAZJIAJtGE+jgvVieYrzyQWDKu6MDFz3VaWD06i6rOfdRCrW+Y42YZkNX48eKWE
	NBhlvO7jcYkwUIFX84wA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y6n4gjq80-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 May 2024 04:29:48 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44N4TZeJ015724
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 May 2024 04:29:35 GMT
Received: from [10.50.38.127] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 22 May
 2024 21:29:29 -0700
Message-ID: <03f7c498-775d-43a1-a8b1-8c340ef6a81f@quicinc.com>
Date: Thu, 23 May 2024 09:59:21 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 3/6] dt-bindings: PCI: qcom: Document the IPQ9574 PCIe
 controller.
To: Krzysztof Kozlowski <krzk@kernel.org>, <bhelgaas@google.com>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <manivannan.sadhasivam@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
References: <20240512082858.1806694-1-quic_devipriy@quicinc.com>
 <20240512082858.1806694-4-quic_devipriy@quicinc.com>
 <b3199f40-0983-4185-bd0c-2e2d45d690ad@kernel.org>
Content-Language: en-US
From: Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <b3199f40-0983-4185-bd0c-2e2d45d690ad@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qQ3oEreRA_vKjHSeGu3EQ_pH0qeAcnWF
X-Proofpoint-ORIG-GUID: qQ3oEreRA_vKjHSeGu3EQ_pH0qeAcnWF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-23_02,2024-05-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 adultscore=0 mlxlogscore=969
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405230029



On 5/13/2024 12:18 PM, Krzysztof Kozlowski wrote:
> On 12/05/2024 10:28, devi priya wrote:
> 
>>   
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - qcom,pcie-ipq9574
>> +    then:
>> +      properties:
>> +        clocks:
>> +          minItems: 6
>> +          maxItems: 6
>> +        clock-names:
>> +          items:
>> +            - const: ahb  # AHB clock
>> +            - const: aux  # Auxiliary clock
>> +            - const: axi_m # AXI Master clock
>> +            - const: axi_s # AXI Slave clock
>> +            - const: axi_bridge # AXI bridge clock
>> +            - const: rchng
> 
> That's introducing one more order of clocks... Please keep it
> consistent. The only existing case with ahb has it at after axi_m and
> others. Why making things everytime differently?
> 
> I also to propose to finally drop the obvious comments, like "AHB
> clock". It cannot be anything else. AXI Master / slave are descriptive,
> so should stay.
Sure okay, will update this in next spin.

Thanks,
Devi Priya
> 
> Best regards,
> Krzysztof
> 

