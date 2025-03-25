Return-Path: <linux-pci+bounces-24610-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60392A6E8ED
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 05:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3C031897120
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 04:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E111A5BB9;
	Tue, 25 Mar 2025 04:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lP5czc5t"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8109E1624E0
	for <linux-pci@vger.kernel.org>; Tue, 25 Mar 2025 04:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742877721; cv=none; b=BOW+Xovcdm8etc9aNMWi0IHqqQMK5p5hRZ1+5lXDl0JMIXbYCS+r11EFlmUs8P5XLWfHx/pbI/NzC4En11S6uNUs5A0FRigoB9VVH6Ba+VeXgSNpBgR2VL3ecVgIojVSWP+pqAm4F5T2BJV/H880iVV1glT630VmE6vqjSHZKFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742877721; c=relaxed/simple;
	bh=7xWy80QMrujZ0Ex5DlTo0yWkJidfRM8xZL9THcZoR9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ChAGweekHkbrfQAsb6tUN12tTQe2NE/ah5Ucpn2s4HIDo6GCfsEUt+X+8xasYmebkS6uaVDh14G+z/shN3s/6DHvDh924ibfhgMSB6bzeGkepRRsYMJuZhQHYTGJCXmoRj7XN69mnYQMjjD2a4EerGaCJVncTmh3Uf2P0WNCVX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lP5czc5t; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52OIj1JO015727
	for <linux-pci@vger.kernel.org>; Tue, 25 Mar 2025 04:41:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1NVjTuv2vpO9LvwcHKST3gkeOTVrunOLOzDwRQAoVj8=; b=lP5czc5tEOR+Sg2U
	O/y928utt4d9HJeUsFEDvJmT83DMwey+bMiGpgoQcpyfHMPd+Yes5WL571MdsDub
	8QvdVh71pZhJBFh4Ay/ZAGV1offA29qadrr7fYTK+ypW2mfbsb2vWUGp+nzMZ5Dg
	PtQGR0x2xqg7+UHMozKW6tD4AtSmCewwPGqpeaXjlUCD1UyRAxJNvkO9g+Cvw/O+
	DlANmTtlAX6sZHAxlqV5PXX/XqbNxkH0tQhYZ7fGZeyUXbuoNBS3gigHlXKmu9BX
	bfluLFEEvfnpRRNxaoZ+S7xQkiSExe9d9wShZycdI6JIv8+WierliyictdLqOCEC
	QlbSTw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45hn9wefgf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 25 Mar 2025 04:41:51 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-30364fc706fso1472206a91.3
        for <linux-pci@vger.kernel.org>; Mon, 24 Mar 2025 21:41:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742877710; x=1743482510;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1NVjTuv2vpO9LvwcHKST3gkeOTVrunOLOzDwRQAoVj8=;
        b=fBmmRRz85lS58MJTPsuzKLl9hVHx3HMVTWFhqN8EovKulBfufp34X3hjmtrZjw+IUc
         26HUDYzwc99as2GNGNClQSIzqSe/O8jb5G65N/1p87nvpBxN0ZJakFS8CW4pSq86HqrJ
         Nl5Z9GbLZ87z1KjioeLxc75cjtPugXPft70xa0PFnKQ9zGixHMcwTLBp9JD3KNNemdFC
         B2XOM9RIrqH1v1DkGoq2ub/hfbjfYm48/7PNc6VbL9ady36O9r1+BzqsXPUGGtdEGLWC
         j1yvYF7tv0SMzm91G5p8HLR8f86yvz3M5MAGz/M8YIbsZJxRe0kh2ypw6LhWpuXiwlS4
         75Kw==
X-Forwarded-Encrypted: i=1; AJvYcCUE+T4MaPh5RU7P+QPC5IhmjZpsQMIXbSxWpU2vuGumgBWxGsiF2s+70WYjRB2ijEytUPb4y23jz2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrsEPFAjWuZoQ/OLl+NJfj1MxoPWvLtnL4RZmJ8bl5BGJMfbo2
	AqFU4/Quju8wYaan2HYPHCsaW9NmPExno/7mX2+anWIxI5HEE24HsVN0UfcFYZNPI11x8FhuSO+
	QZaDJymt4r7WhOD9ZEcj9uBEM5BWkcqwaKdSU0XwnIcZqCvuioMicM8crmNY=
X-Gm-Gg: ASbGncukJ6kZSPEkIek+MF16OI4PumST9/MzjrgTZBhfdWTUHtR6iXNN4+V6Zo5vml6
	16PwcMLLC8bDpQ3tKL3NUrZnbRZuMxnbIpiFeaspefHB23x67auZBWul2OXud/KpXBt2dRrzpla
	O+EkQLwLMMcDW1Ma+dfeLHUTS5Iz+JAo6ii3ndS9zSInvIcaFcr6yeMpkM20dQYGWsX519VzUpD
	fdB3Aphzq1r7IH/oukjH3zrELDZ3J+SFvLxxRvVvyEY9z0EnreCqx4b0rTeY272XPTto0ZNT22Z
	oGuPTvflOKyScqmrnghckMI4dkbWV5QNdTpkP+Ly6186xA==
X-Received: by 2002:a05:6a20:2589:b0:1f3:48d5:7303 with SMTP id adf61e73a8af0-1fe4300f771mr33673881637.31.1742877709933;
        Mon, 24 Mar 2025 21:41:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHx8jVmGZQjbSLUZtNjlclkoC+wjvKr3wBjOfaf15PVujgPxwv0lUOLrrAJyTEPiV5QhOiaDQ==
X-Received: by 2002:a05:6a20:2589:b0:1f3:48d5:7303 with SMTP id adf61e73a8af0-1fe4300f771mr33673825637.31.1742877709329;
        Mon, 24 Mar 2025 21:41:49 -0700 (PDT)
Received: from [10.92.192.202] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af8a2a4c905sm8046504a12.66.2025.03.24.21.41.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 21:41:48 -0700 (PDT)
Message-ID: <7a0e7b48-6c08-abbe-7c23-a7e1c746351c@oss.qualcomm.com>
Date: Tue, 25 Mar 2025 10:11:42 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/3] dt-bindings: PCI: qcom: Move phy, wake & reset gpio's
 to root port
To: Rob Herring <robh@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski
 <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_mrana@quicinc.com
References: <20250322-perst-v1-0-e5e4da74a204@oss.qualcomm.com>
 <20250322-perst-v1-1-e5e4da74a204@oss.qualcomm.com>
 <20250324163945.GA304502-robh@kernel.org>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20250324163945.GA304502-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: qFX0T13BX6HANkProg-1ekgDnou8gYos
X-Proofpoint-ORIG-GUID: qFX0T13BX6HANkProg-1ekgDnou8gYos
X-Authority-Analysis: v=2.4 cv=CPoqXQrD c=1 sm=1 tr=0 ts=67e2340f cx=c_pps a=RP+M6JBNLl+fLTcSJhASfg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Fxgvsqju1LP9AadwZSIA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_02,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 spamscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 phishscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503250030



On 3/24/2025 10:09 PM, Rob Herring wrote:
> On Sat, Mar 22, 2025 at 08:30:43AM +0530, Krishna Chaitanya Chundru wrote:
>> Move the phy, phy-names, wake-gpio's to the pcie root port node instead of
>> the bridge node, as agreed upon in multiple places one instance is[1].
> 
> You aren't really moving them except in the example. This is an ABI
> break for sc7280. Is anyone going to care?
> 
> You need to deprecate the properties in the old location.
>
Hi Rob,

we are actually moving these properties in the driver also
patch 3 
https://lore.kernel.org/linux-arm-msm/20250322-perst-v1-3-e5e4da74a204@oss.qualcomm.com/T/#m168bec3f5d218a7f0c18293ff7380cba07a12e0e
is the driver change in this series.

>> Update the qcom,pcie-common.yaml to include the phy, phy-names, and
>> wake-gpios properties in the root port node. There is already reset-gpio
>> defined for PERST# in pci-bus-common.yaml, start using that property
>> instead of perst-gpio.
>>
>> For backward compatibility, do not remove any existing properties in the
>> bridge node.
>>
>> [1] https://lore.kernel.org/linux-pci/20241211192014.GA3302752@bhelgaas/
>>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
>>   .../devicetree/bindings/pci/qcom,pcie-common.yaml  | 22 ++++++++++++++++++++++
>>   .../devicetree/bindings/pci/qcom,pcie-sc7280.yaml  | 18 ++++++++++++++----
>>   2 files changed, 36 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml
>> index 0480c58f7d99..258c21c01c72 100644
>> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml
>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml
>> @@ -85,6 +85,28 @@ properties:
>>     opp-table:
>>       type: object
>>   
>> +patternProperties:
>> +  "^pcie@":
>> +    type: object
>> +    $ref: /schemas/pci/pci-pci-bridge.yaml#
>> +
>> +    properties:
>> +      reg:
>> +        maxItems: 1
>> +
>> +      phys:
>> +        maxItems: 1
>> +
>> +      phy-names:
>> +        items:
>> +          - const: pciephy
> 
> Just drop phy-names in the new location. It's pointless especially when
> foo-names is just "${module}foo".
ack

- Krishna Chaitanya.
> 
>> +
>> +      wake-gpios:
>> +        description: GPIO controlled connection to WAKE# signal
>> +        maxItems: 1
>> +
>> +    unevaluatedProperties: false
>> +
>>   required:
>>     - reg
>>     - reg-names

