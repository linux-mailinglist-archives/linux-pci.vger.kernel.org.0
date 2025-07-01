Return-Path: <linux-pci+bounces-31202-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D43AF04B4
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 22:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65E141C07537
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 20:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A61B2ED86E;
	Tue,  1 Jul 2025 20:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PVj8XoI0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E79D2EE5EB
	for <linux-pci@vger.kernel.org>; Tue,  1 Jul 2025 20:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751401295; cv=none; b=CGJskbPV/nGMgYEjJZUNagwrTMa4d1IbWlhzdYspJK1JM2EzW5/vKEXdZPlRBxYUNgxkBfwPATcD7JnKhSxkV8LhAuYVZvcmwGkTxchIqNh/7V5ZkV08g+3rTLY94nAnyywFsg9Exu/gvAwHYdx9bfojqqqBkFL6lmlJVyKWK3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751401295; c=relaxed/simple;
	bh=ezE2n18Omi/MOjX73Sr3/tMK4T9hA/BPKdf80o00DBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PE6Ofjr9anDUElKqLDc8WVJSIIahnsw58GGAtBfANJJ0VJF2Qj12LtgGy86AYBLZihCAxVWEqTBIHNFrON1xDwrUoFkzNaAQGyU+2W63+ODKW0jH4n7vuHXljwckcZbkyJxuTE05+p/NxEit3uTBSMQ0NUr2866bII0CjNEN3c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PVj8XoI0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 561F27qr022671
	for <linux-pci@vger.kernel.org>; Tue, 1 Jul 2025 20:21:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hUrytFkRXZ1kyGSNxdZDA+tX90rrT6JMS9+T22SMUsA=; b=PVj8XoI0Q3y0tW87
	zA5GLcA1bosb3F1naOB2mSl0UkwnoWIOAH7oWo0b5ZWFYIGH9fFhRbF4coGGhrYj
	TBSEIL/vR08M/xu5zEHP+KsCYHeCYEUkyq6uPvMM76SEcYDH9PZVOCxthegb+qEl
	sYHDi31K3jfsRvmc1Os4H+9O4EW6BKJOZ2/cKlr5G99nyW6r9bZOrmMgg0j1MRyB
	kNDh94BaD/jXg1qymIaTPuShELus0ZjdIeabw56bIFTJlvb07n0Ju0aKL9LyiXZU
	RjvyBlud113UDjsCzqn0pWbArd4lB0lCyx6tl0xHqntF6e9TWKeGZvzBpjWAHNQ/
	mtmVWA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47mhxn0uux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 01 Jul 2025 20:21:33 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-236725af87fso73401195ad.3
        for <linux-pci@vger.kernel.org>; Tue, 01 Jul 2025 13:21:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751401292; x=1752006092;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hUrytFkRXZ1kyGSNxdZDA+tX90rrT6JMS9+T22SMUsA=;
        b=aTyQ59YhNbQ6ZoUVR/ND2mOTsagaZa8FIftZJcWFNRZgh7J1EWC80e3euqJyhB472L
         7NfJCN6KDDDIU7EfLzzh2u62V6J/oseqyUpEiBpVjkMcKdvbi31mYKM1xVKKVNqe82Lq
         fcAql7ehHlU87apqc7jl3wMubmMCHw6oDZ0mrAWR8XsOQz/CbQVoF9lJIkjGa6jXFYGJ
         qddQWlaE8FXqX4NnoU0+gGdbUZtIMjdiaXEcm1bgvtz0BaYufs/ANnWhshN8jLUCIIgI
         SbbeIMOmXUsKiHYLx5kORP74RpyBS09wbX1me7jwGOOGN6rwY9GWP4WtADBwxDc/M2tb
         U9zQ==
X-Gm-Message-State: AOJu0YyvsXL/tJdSF3ZwJlfMmd420EjDhtukt9fRweSQCfU7pG0WiXnB
	oll/rrLlpPlG77aBUdrX6gVWW51vc0X8rLqk4cj06otj5qrzASDC5ttn2iLI9TuBniOXBsklGGw
	k3cCWn4aEY1pg2+jr2tOHkxQn/RgIsDti+qzkahlg28CdbNHmcXZBZjLyJe4l1Xs=
X-Gm-Gg: ASbGncsOgARLvDUaCq+iUMOmJU44r1gxdvAV6hI2oc4AfXT1+XgF1Gv2G9qwwyskakz
	wrcPi1lZIUIUvv40w8GChf9aGblgVtG6Zig8a8EWbCzSEUIDb7nXJvvWltmXSB8HKSIx3FqKPN7
	gZFvIDoJ29swStnXHkPnjrOLm8/DOC4F/FxLpufwIgBwAs4RUUF4BGuL6KbUN5zuplhVGDqPMlV
	w2G8tOX0EnAAP0B+c/IhlP47BWizTOhoodZW7UCUwoTV3nQjTXHToru/FkDFa5pj3zdeHsd/4mS
	EswKAy2avh7S8Q8Nf6nFMVPhSDzRdBH1/MVsOGpa9iltyNCRMsXPh3YsTkuCs/wO
X-Received: by 2002:a17:902:ea0e:b0:236:363e:55d with SMTP id d9443c01a7336-23c6e591826mr752555ad.28.1751401291823;
        Tue, 01 Jul 2025 13:21:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFq2/qAA6kM0CeuXpCcxP+BXUf/kabRYb4GipX6TGcMwNAVDXbJ8LpM3G58LJeO9rQYMHePRA==
X-Received: by 2002:a17:902:ea0e:b0:236:363e:55d with SMTP id d9443c01a7336-23c6e591826mr752165ad.28.1751401291387;
        Tue, 01 Jul 2025 13:21:31 -0700 (PDT)
Received: from [10.73.112.69] (pat_11.qualcomm.com. [192.35.156.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb2f39bdsm118879695ad.80.2025.07.01.13.21.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 13:21:30 -0700 (PDT)
Message-ID: <89ded76a-8bd7-43b5-932d-f139f4154320@oss.qualcomm.com>
Date: Tue, 1 Jul 2025 13:21:29 -0700
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
References: <20250701165257.GA1839070@bhelgaas>
Content-Language: en-US
From: Mayank Rana <mayank.rana@oss.qualcomm.com>
In-Reply-To: <20250701165257.GA1839070@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDE0MiBTYWx0ZWRfX0pqI56qfDwrz
 QJRP9iiruzXPGt6t5tBo7qsXIwDBrYINWw2v6U06mJROKffj2EBkxe85DoUGYDWDfM8pJHp8+v7
 1CFBIgZgGfEiKI0aPuP2m+CefWOcZPcz4CmCGCWAG74GD8obOA8/gvHZEvg6YLKmSOHrmVmeq03
 Oe5dPjSmrqS2k9F/44qoGw/R+5s4Mc7VQ1z+Hej8hMI1Oa6R9jOVmYBbGvjiFkL1oB+250pwmdt
 rsqG7m4CyFQIX30q9GdwpvTCf1j2t7qwcOm2ukavBcJdcLFHAqzUaOHNA8qUxEzvctwMldUD6yJ
 nPJ5U1RADBR8O3NSAWux1me2wrDx6ggSo6yhEfBK5v771S7Yz6aATkH72vKUDX65hp0pt4vdXUf
 TwO+AM5fmNgv5yQE7je0+pQlUpYzBKHXOpmm6+fRdCodOZcplsk9Q9OpN7x8Eh5pUbvTT0Rq
X-Authority-Analysis: v=2.4 cv=EbvIQOmC c=1 sm=1 tr=0 ts=6864434d cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZdW6uxA9NKXbfdqeeS2OGA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=99n8J7Ytk5hhnKoTW6cA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: nKp8FBSuGekATGoNVCo1MQdFDnTXRexR
X-Proofpoint-GUID: nKp8FBSuGekATGoNVCo1MQdFDnTXRexR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507010142

Hi Bjorn

On 7/1/2025 9:52 AM, Bjorn Helgaas wrote:
> On Mon, Jun 16, 2025 at 03:42:58PM -0700, Mayank Rana wrote:
>> Document the required configuration to enable the PCIe root complex on
>> SA8255p, which is managed by firmware using power-domain based handling
>> and configured as ECAM compliant.
> 
>> +    soc {
>> +        #address-cells = <2>;
>> +        #size-cells = <2>;
>> +
>> +        pci@1c00000 {
>> +           compatible = "qcom,pcie-sa8255p";
>> +           reg = <0x4 0x00000000 0 0x10000000>;
>> +           device_type = "pci";
>> +           #address-cells = <3>;
>> +           #size-cells = <2>;
>> +           ranges = <0x02000000 0x0 0x40100000 0x0 0x40100000 0x0 0x1ff00000>,
>> +                    <0x43000000 0x4 0x10100000 0x4 0x10100000 0x0 0x40000000>;
>> +           bus-range = <0x00 0xff>;
>> +           dma-coherent;
>> +           linux,pci-domain = <0>;
>> ...
> 
>> +           pcie@0 {
>> +                   device_type = "pci";
>> +                   reg = <0x0 0x0 0x0 0x0 0x0>;
>> +                   bus-range = <0x01 0xff>;
> 
> This is a Root Port, right?  Why do we need bus-range here?  I assume
> that even without this, the PCI core can detect and manage the bus
> range using PCI_SECONDARY_BUS and PCI_SUBORDINATE_BUS.
On Qualcomm SOCs, root complex based root host bridge is connected to 
single PCIe bridge
with single root port. I have added bus-range based on discussion on 
this thread https://lore.kernel.org/all/20240321-pcie-qcom-bridge-dts-
2-0-1eb790c53e43@linaro.org/
 >> +                   #address-cells = <3>;>> + 
#size-cells = <2>;
>> +                   ranges;
>> +            };
>> +        };
>> +    };
>> -- 
>> 2.25.1
>>
Regards,
Mayank



