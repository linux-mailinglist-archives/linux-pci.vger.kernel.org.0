Return-Path: <linux-pci+bounces-12774-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0808296C54E
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 19:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BB011C24F9D
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 17:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E25D1E2033;
	Wed,  4 Sep 2024 17:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BBPUbpMM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6850D1E2018;
	Wed,  4 Sep 2024 17:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725470462; cv=none; b=O0JWtnhPha6HObWgxzWeIduhN8c9/uvZuSiSWEMyMQfEIiWTmp3SphhI5Li7Y7qIogZ/BwCewgA3Hp+dCni48oU4UDAq7JVAA6chs1tWYt6bG3dolVLgUQWXwqgnD43omp8uDYipzLa4JDxVVyUVfhkI0PdSRCIzp6i80dWZCog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725470462; c=relaxed/simple;
	bh=CxoE9+EKENyfL1mcnA/KnEiQyWVNN9QNA8F3rKPR1S0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pBNJbjU8w/o+blaI4dctXiJLt+pqw89XHGneZ7BhZf1DwvG/AnXSMfNnAgN8rlDgynY+NpRh5F+BXS/OCeQ1g46b5gjIpLYUeu1ZhlG5WHHU75ptCdeVTCAdOiyRCQaM2UW9GNEc1vVpmbSR/GElv80I7cdyWgliv35WVV/Oyic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BBPUbpMM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 484Akds6026179;
	Wed, 4 Sep 2024 17:20:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eNn/39zt7ybLVISg8iNP715VpPtzk/C5TNhg4bfMq/k=; b=BBPUbpMMULWDph5A
	fSGB5AMcLKLAd0xMpn0IMMpbKWNvktJGHPPjpZ1pXHejsORzHRy7+7HtZaUskixs
	jiZ3Xc4hBngGnPl3t7H+11/pzkXsU9JvNOUiwKEWrMg7GyohYxXNBLC5qF9B8XZM
	vAZLkDzxSuwi1VyrT8b4+uhhdQWXLvYgHnribVZUPsxuhrL0ynDDRS+R8BGallKO
	Dr6fKh24Tad4PqbNzS2p1GDsnCKzZ7lThayevBqveDIEknhA/1VAJXMl+8hBwo9r
	Gkl99wGuzbix+9J1z+xHToI0EaIVAwHgu239sNxchPY7JcHFAnExTVea8RZpzFll
	ckYAHw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41bt673n95-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 17:20:34 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 484HKVSt016510
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Sep 2024 17:20:31 GMT
Received: from [10.50.7.129] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 4 Sep 2024
 10:20:22 -0700
Message-ID: <de17d37f-ed0c-4e73-91d5-fc902573212a@quicinc.com>
Date: Wed, 4 Sep 2024 22:50:17 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 1/6] dt-bindings: phy: qcom,uniphy-pcie: Document PCIe
 uniphy
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <andersson@kernel.org>, <konradybcio@kernel.org>,
        <p.zabel@pengutronix.de>, <dmitry.baryshkov@linaro.org>,
        <quic_nsekar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <robimarko@gmail.com>
References: <20240830081132.4016860-1-quic_srichara@quicinc.com>
 <20240830081132.4016860-2-quic_srichara@quicinc.com>
 <e2qgpvfccpo2sd4mbrynxruvt5attqmtd5oik26of7tv7u4lq6@kvb63sglwa5b>
Content-Language: en-US
From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <e2qgpvfccpo2sd4mbrynxruvt5attqmtd5oik26of7tv7u4lq6@kvb63sglwa5b>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: gBpkfBhrm5cPj714kocbIlQR-cZtFLfW
X-Proofpoint-GUID: gBpkfBhrm5cPj714kocbIlQR-cZtFLfW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_15,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 bulkscore=0 mlxscore=0 impostorscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409040132



On 8/30/2024 1:53 PM, Krzysztof Kozlowski wrote:
> On Fri, Aug 30, 2024 at 01:41:27PM +0530, Sricharan R wrote:
>> From: Nitheesh Sekar <quic_nsekar@quicinc.com>
>>
>> Document the Qualcomm UNIPHY PCIe 28LP present in IPQ5018.
>>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
>> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>> ---
>>   [v3] Added reviewed-by tags
>>
>>   .../phy/qcom,ipq5018-uniphy-pcie.yaml         | 70 +++++++++++++++++++
>>   1 file changed, 70 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/phy/qcom,ipq5018-uniphy-pcie.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/phy/qcom,ipq5018-uniphy-pcie.yaml b/Documentation/devicetree/bindings/phy/qcom,ipq5018-uniphy-pcie.yaml
>> new file mode 100644
>> index 000000000000..c04dd179eb8b
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/phy/qcom,ipq5018-uniphy-pcie.yaml
>> @@ -0,0 +1,70 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/phy/qcom,ipq5018-uniphy-pcie.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm UNIPHY PCIe 28LP PHY controller for genx1, genx2
>> +
>> +maintainers:
>> +  - Nitheesh Sekar <quic_nsekar@quicinc.com>
>> +  - Sricharan Ramabadhran <quic_srichara@quicinc.com>
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - qcom,ipq5018-uniphy-pcie-gen2x1
>> +      - qcom,ipq5018-uniphy-pcie-gen2x2
> 
> ... and now I wonder why there are two compatibles. Isn't the phy the
> same? We talk about the same hardware?
  We have 2 different physical phys. One with single lane and another
  with dual lane. Its same IP, but for 2 lanes, 2 sets of the phy
  specific registers needs to configured. So differentiating that here.

Regards,
  Sricharan




