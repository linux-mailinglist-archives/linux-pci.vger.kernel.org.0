Return-Path: <linux-pci+bounces-32190-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C46CB067DE
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 22:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75B677B385C
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 20:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B696326E701;
	Tue, 15 Jul 2025 20:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k5Iwa94N"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B432254AEC
	for <linux-pci@vger.kernel.org>; Tue, 15 Jul 2025 20:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752612187; cv=none; b=j7YtbhhXTR687xBjAdUrzbmOyDPLOIVUaf/u1N8/GANivEjQw4XkOf15CNxJbufTHuxRZEfzQLa4MEp9LN1kjY/eBhIuSPdzFeqLy51k/m06LU2Tijj7Rm3LMEsZTz02AhguHqjA4OzhCu9Rf2YUnX/fyvVWz6KpuWzl4xz5MI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752612187; c=relaxed/simple;
	bh=096GrYtNxo6MX6U8gE4TUzx3MesHCK40ZyzYd0x2VMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F6G8AkjHnm4Oy3p982j9Kix+GIxIwCpTLpI6mFJnh8tJUwWf9no4BTT9k7za48fWA+ObEC4h4sZxVOg9Mi2y8EcxgJd9CgW/vlVdoI/YtltUlANcoj3uHoPARwm4OShDXVqd/jRJwhF8ZWkb3R/HL/QFUMWtMnXaMQf8j/6xSco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k5Iwa94N; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FGDOfY018184
	for <linux-pci@vger.kernel.org>; Tue, 15 Jul 2025 20:43:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fkdWocIkXBnxpO5dQBPXK4H2mvwJNbJbFXsendZvKaI=; b=k5Iwa94NWUInC8zZ
	BapKetQfFK6Yx+tx04cvoFX93fEYS/PzStxgNPA9P5fxHdPHJAAyJ8KoQ7MjcmnR
	URy6upAJF+q7DUraovzA4BjipFDQh6YgPKiSUmsL5YN4hYwkVgIhoVjsdjs0K6sz
	aCBy9vAd0ssVT50GuQVeJYDGkRuhMqz2GYP3fIVoCQWzpJKZmOe7lByhF7Uz0PiN
	BUI/XBbyeaJ6sDS8dBMkrSwxu6imp6g7MKljbxYyrsZwBIveW3KLGnEudJpxxc6V
	uoSYgBlinL1UYdPIfUaUwFEm8iJC0fWvYngvIxkF4KgfiNBPLPvxNdjw7cxcbT0X
	/k2xsw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ug381q0u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 15 Jul 2025 20:43:04 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-23638e1605dso45071615ad.0
        for <linux-pci@vger.kernel.org>; Tue, 15 Jul 2025 13:43:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752612183; x=1753216983;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fkdWocIkXBnxpO5dQBPXK4H2mvwJNbJbFXsendZvKaI=;
        b=mAFEAbZoyTufvlBcO3H1ye8lVkxHINcFgh4TwE59R++/w/wSaiIB9k5sBDG1EfpwVV
         ZKzcgqEXPqSfRhQ7VqzYAJZsmrZDkW8El3c3grhkIx9PZtijBfH2C2ZykL8Ug6nsqV2x
         Uph/wk067GHzYI7tZaCE2xLgsuvnqH7MwMNrsCLbqn6snn0tPyuMvNyJRn7UcHBR8pnI
         9nwQUjkb+qyZ9dJABJRCRbocof+kMJfra6GcfcXoziqtUp/Em3pQ90ISVwjPmo9atpEG
         1Zhfls6ElvZW5kaCVlihc02ZJlikcDEFEyc61l46HI/H4fUXsrVJrVmRX5KITrYoK1ro
         0uCw==
X-Gm-Message-State: AOJu0YzfoJ4EOcS1xc4wEVcdQGcw6pJrRSIz6lFk9xu253ke6T/30c39
	NvGwBtf5kS9eSpRmSxE0zlafWFWBdk6yYfsVnN75BGmzkUh5iWDsFdAgKNi7fHMP1wNsBg7paRt
	SXk4Agk0flYmRBoApmQS6SHMeUj42+Gs6AP1qVhv8yRYPRWT/FrLb/hGc+JBwi1M=
X-Gm-Gg: ASbGncu1E1a+P0DkwptLFLR8Ygrlxk8lb0de/yFncMtr4Vd1guECLz4CAOcIRAIlKL6
	UKKVPzix4yW4u5nkSakZP6Uz9/G8phcMiZSAQCNLlFHdcGr6Z8uIDnLkJR8zq9pdkFePTZ0qpKA
	IgNf2AfBLvYR+tTMmVY84Hg8PktTmPeB4ABoq+YYM6c01rfEI1/bTkrK6WHgTD8kg3uIaglVGXr
	H4FUMxmbrHyGMXscBxVFiBLygTHv5yR8RC+sn8kv6XL6x+ccS6O4QgF/FjE0GkzHIADjuuqkMC4
	OOd8snqvDAk7W98cZNMuJEHuR1w9BAGUp2RIPrqpgh9BwgvKpDH9QBpmoPStEU9+3NN37Utzymc
	iknXGb2s=
X-Received: by 2002:a17:902:d2c5:b0:235:7c6:ebdb with SMTP id d9443c01a7336-23e2566b0bfmr2209005ad.10.1752612183417;
        Tue, 15 Jul 2025 13:43:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIhbMmyIr7zVej/BKQltO0GntSzucFDQVsI2picZ5pOCxWjfJ0K47v2K6Z0XZyvBH35dVG/w==
X-Received: by 2002:a17:902:d2c5:b0:235:7c6:ebdb with SMTP id d9443c01a7336-23e2566b0bfmr2208645ad.10.1752612182871;
        Tue, 15 Jul 2025 13:43:02 -0700 (PDT)
Received: from [10.73.114.202] (pat_11.qualcomm.com. [192.35.156.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9f2a2549sm31776a91.42.2025.07.15.13.43.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 13:43:02 -0700 (PDT)
Message-ID: <fae42c03-c58d-4ed6-8570-ae4b147b1d43@oss.qualcomm.com>
Date: Tue, 15 Jul 2025 13:43:00 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] dt-bindings: PCI: qcom,pcie-sa8255p: Document ECAM
 compliant PCIe root complex
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, will@kernel.org, lpieralisi@kernel.org,
        kw@linux.com, robh@kernel.org, bhelgaas@google.com,
        andersson@kernel.org, mani@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        quic_ramkri@quicinc.com, quic_shazhuss@quicinc.com,
        quic_msarkar@quicinc.com, quic_nitegupt@quicinc.com
References: <20250715181630.GA2469794@bhelgaas>
Content-Language: en-US
From: Mayank Rana <mayank.rana@oss.qualcomm.com>
In-Reply-To: <20250715181630.GA2469794@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDE5MSBTYWx0ZWRfX3ozYQJ7TyvUG
 fSqxot5JinvWpqcYao6gQ5/hX6Y2656NsooTq1O742jDukyhxPPy8mwYFehAKPOSm0g4tMJfKpQ
 VhEi4H4yB/17EFWjAbK5YhZ0BlMLyYPiQrgDEISjBsDaHg4ywVehyTKD7Lq4CAi6RzFQmqpg9fO
 8g+rmDgmxkYMilJpEx9ayywZd1s6xdMqOOVUnbE87d9dZPECYDy/hVnhTgMlgZ7oL7RlsfQeq8A
 OCGaPpZ+y1Rsza9gb45yo97JFyiyyLxVlJQ+IriPksVwiAtxa9obKlKnlSi24SaI5V9SEmePq4r
 +MflFPLA5l8oIjSWbU40+ysiwb7DxhupCEgOk0oDqJ15Bwxm+oJXa3lDLc5EVIMZcO0teHXmu21
 vyCQP/PkGouECJ+HXhlRU1BezNbBoSmnaRWH/sG4P6J+pVYL1IOlr0O6Lb7uigt9MsJPYhDl
X-Proofpoint-GUID: MzejVjhY_V4KTlNN3YHVKg-b20wYA9lv
X-Authority-Analysis: v=2.4 cv=SZT3duRu c=1 sm=1 tr=0 ts=6876bd58 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZdW6uxA9NKXbfdqeeS2OGA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=LFZAdqBXG_KN2Z8UtmoA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=sptkURWiP4Gy88Gu7hUp:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: MzejVjhY_V4KTlNN3YHVKg-b20wYA9lv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_05,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507150191



On 7/15/2025 11:16 AM, Bjorn Helgaas wrote:
> On Mon, Jun 16, 2025 at 03:42:58PM -0700, Mayank Rana wrote:
>> Document the required configuration to enable the PCIe root complex on
>> SA8255p, which is managed by firmware using power-domain based handling
>> and configured as ECAM compliant.
>>
>> Signed-off-by: Mayank Rana <mayank.rana@oss.qualcomm.com>
>> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
>> ---
>>   .../bindings/pci/qcom,pcie-sa8255p.yaml       | 122 ++++++++++++++++++
>>   1 file changed, 122 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie-sa8255p.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sa8255p.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sa8255p.yaml
>> new file mode 100644
>> index 000000000000..88c8f012708c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sa8255p.yaml
>> @@ -0,0 +1,122 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/pci/qcom,pcie-sa8255p.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm SA8255p based firmware managed and ECAM compliant PCIe Root Complex
>> +
>> +maintainers:
>> +  - Bjorn Andersson <andersson@kernel.org>
>> +  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>> +
>> +description:
>> +  Qualcomm SA8255p SoC PCIe root complex controller is based on the Synopsys
>> +  DesignWare PCIe IP which is managed by firmware, and configured in ECAM mode.
>> +
>> +properties:
>> +  compatible:
>> +    const: qcom,pcie-sa8255p
>> +
>> +  reg:
>> +    description:
>> +      The Configuration Space base address and size, as accessed from the parent
>> +      bus. The base address corresponds to the first bus in the "bus-range"
>> +      property. If no "bus-range" is specified, this will be bus 0 (the
>> +      default).
> 
> Do you mind if I add "ECAM" to this description, e.g.,
>    The base address and size of the ECAM area for accessing PCI
>    Configuration Space, as accessed from the parent bus.
> 
> I think having the "ECAM" keyword would make this easier to grep for.
I agree that it helps clarify the intended usage. Please help with 
updating the description.

Regards,
Mayank



