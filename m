Return-Path: <linux-pci+bounces-22509-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E19B7A473D2
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 04:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD29A3A4CEA
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 03:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725C11D61A1;
	Thu, 27 Feb 2025 03:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J1RW+1ID"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDCF270031
	for <linux-pci@vger.kernel.org>; Thu, 27 Feb 2025 03:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740628437; cv=none; b=JxdMJSME4MvjP3w/XdD+87DMzXByq7W4j4w84BTujX3elJECKslTmCtk8FnHKbb0iDkbfbRT49pM0+wBwweHd4vslhnZvuB5yHiVBIFdLDB8sZLY3KGxdPpYjao+puOqaJSJP4+gGTpoNab8ttG+iEZVsOcvRXeXFoB4xFRUr8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740628437; c=relaxed/simple;
	bh=u/foCfHoF4Hhis1COb7ssCDiziDNwwO0Pz383KIp1gU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DTaeSHuulZ6ja8htKYOAZgxk1PcVKk4bx7lNTHpc3290WCqK+YGD71bSRoR76uOOkk0YBE35fTSuAzg8gToSWl47QGmziy3s2oocYTB8hNrkymONB1wJmoQTrbCqgHjYN4c8KylqqdmDh7ptWcykA0yHb3qwRMV0qF1XkM3lsn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J1RW+1ID; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QM4dFQ005768
	for <linux-pci@vger.kernel.org>; Thu, 27 Feb 2025 03:53:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	n4tn9hxlyuN0T8oneJTvd5298cAkhX5piGDV4+xPeq0=; b=J1RW+1IDWNGC0D+h
	REZ7g99Ou5r4gIlLfbwJt8wY3RgkRyjWvJcLMLYz1hgNnj5B9x2K3p4LIh8qhqNN
	oU3wNYaixr2nM6IY5KkIeDyl0ANj1Ds7nwScGlK4s93LQY9rbRCe9gbGtidcAa6O
	IlILH1PBFYyqtQeVquLKeRgl7Gr/h4YsXrSp3HO57olhcUDyxiPHPvcFupr2Baxg
	nFwJjK/a9xhqO1dgJhL6aQBxX5BodzRe7faO3J2x7bw0pPVSRtz8l94SiKymABRG
	sok+zdeYhh47HYCPZakyZvPSM+8OyoMPc8mIuuSj03GzdUu2tJFf1LV8Exlnevus
	h54w0g==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 452be6gq6p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 27 Feb 2025 03:53:54 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-220e04e67e2so12631215ad.2
        for <linux-pci@vger.kernel.org>; Wed, 26 Feb 2025 19:53:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740628434; x=1741233234;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n4tn9hxlyuN0T8oneJTvd5298cAkhX5piGDV4+xPeq0=;
        b=vUyZWusXxA4psyOaNKiDshkorayGfgGAUrtEn6X9Wuay0IH41+MvEeXdtarFa+1uxq
         GX5SnTt444hsCaQRUL738fYDzntaJvykZQ/UOOlQate7LkS+GnmokCQoV9sRb1hjWw0Z
         hVv6UvNx/uSnH4SocqraBiSQlmqYs5GSTxKTLhAq6PEUfZbQXS2lERX6SE2xWBrsCFxQ
         js9R0poM18zL36sZGO2BxHAwt7KmvzIuWQYKY4amaOm21qtOq29nQUPECO12nhrAuN3p
         Fuq5AishmLiFjadxDuZojCvnhLReUbBN0k8QLg0IjycRNjpOf/a6r7HNwFpEbxTo0PPl
         T1eg==
X-Forwarded-Encrypted: i=1; AJvYcCUp1/UXMzSQ5DmMirJxmtiNgUCjlJpQQAA8UMNKWh8h4sas4yeWYNK/X3dDn5WgZzEQJN5qYv4Y9sM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHbfoDZX671LkJI6iu4iZzxhWL/44Z2L/0vdldo+6yE17d2l0c
	qg0xH8BoYRiV8Hkaa3osTdlaz2CuEI5Y+5mYK2+tMVaCreRG3hbkbwmkHG2BoDveO77OlMa0J/n
	Jz/onCvtZvapr8qDlDxovRJDeM4MgEZbM6qbYw9YdeVMFMyDb6tZTJNcSo7k=
X-Gm-Gg: ASbGnctldqUm0ttbcs0oGk0/4sLrAydjqJSqmJ0qux5c8VQsGHFp3z+5/9D6/QOTwpo
	+K0o76QYOcTXjGCjDu4jjxyEPilCmOgSB+XAPss4oaF4laKnijviVJtEO89HnQasI0IMU0ZemwS
	DDatkHva8MNbmXhMTl/CtW+6HFjnROA0/dCrvi6Z7duO4Xj8//XzIl171dyb9SEWGLx/QtTvkou
	Tk2IzLX1/whauDM6JUHOea4zhFOPXWNkqOJDuTAdE+mEIeMzAiOCZInoybWaAXGZI/kgeHWTkeR
	KAl4LxpraCkFW4Hrm3zcJXusPnpQDhWKvI7yqVddFVMl
X-Received: by 2002:a05:6a00:114c:b0:732:1840:8382 with SMTP id d2e1a72fcca58-7348ba6d783mr10093713b3a.0.1740628433614;
        Wed, 26 Feb 2025 19:53:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFh5X7bgV3zo/n3ZH5yQ0HTLXd54y0J4VfRDomVEkH4D5IP+RagxLDPvQ42BOJMUDwWpa3BLA==
X-Received: by 2002:a05:6a00:114c:b0:732:1840:8382 with SMTP id d2e1a72fcca58-7348ba6d783mr10093679b3a.0.1740628433225;
        Wed, 26 Feb 2025 19:53:53 -0800 (PST)
Received: from [10.92.199.34] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7349fe4ccb0sm451884b3a.65.2025.02.26.19.53.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 19:53:52 -0800 (PST)
Message-ID: <304a92ea-1a73-1400-a020-dd2e0f14bfd0@oss.qualcomm.com>
Date: Thu, 27 Feb 2025 09:23:35 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 01/10] dt-bindings: PCI: Add binding for Toshiba TC956x
 PCIe switch
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        chaitanya chundru <quic_krichai@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Jingoo Han <jingoohan1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, quic_vbadigan@quicnic.com,
        amitk@kernel.org, dmitry.baryshkov@linaro.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        jorge.ramirez@oss.qualcomm.com
References: <20250225-qps615_v4_1-v4-0-e08633a7bdf8@oss.qualcomm.com>
 <20250225-qps615_v4_1-v4-1-e08633a7bdf8@oss.qualcomm.com>
 <20250226-eager-urchin-of-performance-b71ae4@krzk-bin>
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20250226-eager-urchin-of-performance-b71ae4@krzk-bin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 6Wk70KEGV3WdzkWm9pGpehp8CsVSDO5L
X-Proofpoint-ORIG-GUID: 6Wk70KEGV3WdzkWm9pGpehp8CsVSDO5L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_02,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 impostorscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502270027



On 2/26/2025 1:00 PM, Krzysztof Kozlowski wrote:
> On Tue, Feb 25, 2025 at 03:03:58PM +0530, Krishna Chaitanya Chundru wrote:
>> From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>>
>> Add a device tree binding for the Toshiba TC956x PCIe switch, which
>> provides an Ethernet MAC integrated to the 3rd downstream port and two
>> downstream PCIe ports.
>>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> 
> Drop, file was named entirely different. I see other changes, altough
> comparing with b4 is impossible.
> 
ack
> Why b4 does not work for this patch?
> 
>    b4 diff '20250225-qps615_v4_1-v4-1-e08633a7bdf8@oss.qualcomm.com'
>    Checking for older revisions
>    Grabbing search results from lore.kernel.org
>    Nothing matching that query.
> 
> Looks like you use b4 but decide to not use b4 changesets/versions. Why
> making it difficult for reviewers and for yourself?
> 
There is workspace issue at my end instead of fixing them I tried to
create new branch. I will try to use same changeset from next series
onwards.
> 
>> ---
>>   .../devicetree/bindings/pci/toshiba,tc956x.yaml    | 178 +++++++++++++++++++++
>>   1 file changed, 178 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/toshiba,tc956x.yaml b/Documentation/devicetree/bindings/pci/toshiba,tc956x.yaml
>> new file mode 100644
>> index 000000000000..ffed23004f0d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/toshiba,tc956x.yaml
> 
> What is "x" here? Wildcard?
> 
>> @@ -0,0 +1,178 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/pci/toshiba,tc956x.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Toshiba TC956x PCIe switch
>> +
>> +maintainers:
>> +  - Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> +
>> +description: |
>> +  Toshiba TC956x PCIe switch has one upstream and three downstream
> 
> TC9560? Which one are you using here?
> 
'x' is the series of the switch and we use tc9563
>> +  ports. The 3rd downstream port has integrated endpoint device of
>> +  Ethernet MAC. Other two downstream ports are supposed to connect
>> +  to external device.
>> +
>> +  The TC956x PCIe switch can be configured through I2C interface before
>> +  PCIe link is established to change FTS, ASPM related entry delays,
>> +  tx amplitude etc for better power efficiency and functionality.
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - enum:
>> +          - "pci1179,0623"
> 
> Why quotes?
> 
I will remove the, in the next patch.
>> +      - const: pciclass,0604
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  i2c-parent:
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +    description:
>> +      A phandle to the parent I2C node and the slave address of the device
>> +      used to do configure tc956x to change FTS, tx amplitude etc.
>> +    items:
>> +      - description: Phandle to the I2C controller node
>> +      - description: I2C slave address
>> +
>> +  vdd18-supply: true
>> +
>> +  vdd09-supply: true
>> +
>> +  vddc-supply: true
>> +
>> +  vddio1-supply: true
>> +
>> +  vddio2-supply: true
>> +
>> +  vddio18-supply: true
>> +
>> +  reset-gpios:
>> +    maxItems: 1
>> +    description:
>> +      GPIO controlling the RESX# pin.
>> +
>> +allOf:
>> +  - $ref: "#/$defs/tc956x-node"
>> +
>> +patternProperties:
>> +  "^pcie@[1-3],0$":
>> +    description:
>> +      child nodes describing the internal downstream ports
>> +      the tc956x switch.
>> +    type: object
>> +    $ref: "#/$defs/tc956x-node"
>> +    unevaluatedProperties: false
>> +
>> +$defs:
>> +  tc956x-node:
>> +    type: object
>> +
>> +    properties:
>> +      tc956x,tx-amplitude-microvolt:
> 
> You already got comments on this.
> 
In V3 I got a comment saying "-microvolt does not work for you?"
so based on this we changed to microvolt.
>> +        $ref: /schemas/types.yaml#/definitions/uint32
> 
> Never tested.
>  >
>> +        description:
>> +          Change Tx Margin setting for low power consumption.
>> +
>> +      tc956x,no-dfe-support:
> 
> There is no such vendor prefix and you already got exactly the same
> comment at v3. How did you resolve that comment?
>
It is my mistake I taught the comment was applicable to removed property
"qps615,axi-clk-freq-hz". It is applicable to all the properties I will
correct it in the next patch.

For some reasons there are no errors shown in my workspace when I run
make dt_binding_check DT_SCHEMA_FILES=toshiba,tc956x.yaml
& make CHECK_DTBS=y qcom/qcs6490-rb3gen2.dtb

I will check my tools versions etc and will fix them.

>> +        type: boolean
>> +        description:
>> +          Disable DFE (Decision Feedback Equalizer), which mitigates
>> +          intersymbol interference and some reflections caused by impedance mismatches.
>> +
>> +    allOf:
>> +      - $ref: /schemas/pci/pci-pci-bridge.yaml#
>> +
>> +unevaluatedProperties: false
> 
> Keep order as in example-schema.
> 
ack.

- Krishna Chaitanya.
> Best regards,
> Krzysztof
> 

