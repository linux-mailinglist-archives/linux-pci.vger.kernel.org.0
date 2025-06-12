Return-Path: <linux-pci+bounces-29616-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78969AD7D5D
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 23:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F37053B58BE
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 21:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DBE156C69;
	Thu, 12 Jun 2025 21:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A0svTzDM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7263D1E5B90
	for <linux-pci@vger.kernel.org>; Thu, 12 Jun 2025 21:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749763452; cv=none; b=kQEOUEIfxbpX12ondaoucYZprwDXybwhIcJWm60f5BNH6cjaxlHcP5cTCWatgJKZ/fCxCjV0HKcsMttxXGwzect/D3BLgMg2RmVfOmwCvm6vCphUEmSD3TdjvDW2s/Qt18sg+LvQ9d8wXrgSEN8XPC1ZXD/3TaaClPbAmek4+W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749763452; c=relaxed/simple;
	bh=EAiFdZRb0iwdQ7gdqsgVwQKl6NqJs/YQOLPXfSliJ50=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=eEfk08eKe29LtEl7QilNBUkPn3FagA7fl/Xs4Latm0UrAlyAyynBlpPXoQspRf+Qzbc68y5UJjOmoTrPYwfBAgim16K1eNcCXjnU895cQvYO5hME+P8aS2J6C87x+T9k/L7GqXFECHGwNPJfjNpWga57TQciksxUht17wsqT0W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A0svTzDM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55CKagqA031502
	for <linux-pci@vger.kernel.org>; Thu, 12 Jun 2025 21:24:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	R4kkaqz6aoxGxzS4kTIIcyBNqY3fNdzJXVUNZZZLfnE=; b=A0svTzDMFjZBJMSQ
	qmC9YDrXyO+28J483GHtxHwYApBrQNam0M7my+6AY2nuDc3r9QxxpKGiaB9wJM1y
	71aE6XuWmbm4/jFMn/gRO/83sWH4dbIgAm/VhqikjFXZqHTTOued/o2dgj25Z4xX
	d29f5TvThXd1S/v0C47c1zhmyNFXx00BRch1kmnEqxiyNs3IT9Qsb9ee1ai5Y6vj
	BTwXNRzWMyoU4+ldx8LwVbY7h3fLNvwthfRkilgvWZm8WA9moBl7g28f6n6ZVxW9
	ayzektr493EYn3yENzj81Zicveg1gJGFQyZqArFRmzem2u+KKcyUSWlPLexXJKen
	1gIdGw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 474eqcsx1y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 12 Jun 2025 21:24:08 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-747d394f45fso1264082b3a.2
        for <linux-pci@vger.kernel.org>; Thu, 12 Jun 2025 14:24:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749763447; x=1750368247;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R4kkaqz6aoxGxzS4kTIIcyBNqY3fNdzJXVUNZZZLfnE=;
        b=TTB8uubKtlLLlWaxsWJSdWrew0Ppx9onquE8QGQl1cWkMElyqlHwIAvfrxE8DIYOCU
         2HmIneK8fvug0q3ZpCKCoE5PKF4rWDCB6fvU101RdNLPSbgn8cqmXom/nfeJbEQC8Sc+
         1l4ZdRh/T438Ivowt2HUzUc8IiKVFUJ0l/z5QGZrhIihJP1T1vSVRtFkoG1XwIBmZSE6
         xPzEHSosw8LZ00rYwP4ofQLBDbesJV1ppN49Zb1tYkunDHy1p0JiEfOYFp1IGKTU5gSb
         qNr9oxTGBXEZv2ZHZefFmclCfiA9J+dQc5IBn4tyj6jGeziImMi7MZ9+KyIfOoBJRqpC
         Guog==
X-Gm-Message-State: AOJu0YxXggi/UYWIlsnQNRDkbrQ/bKO0Ow8Dc0FvW7PtafGXzytin8xX
	O+v7RpVgpCkHVE8cThhq+JTjDmP3faFYbKmnzv54X0Ibe6Ocr0Q0fxmB0tAR3KWH3Ti59vzF3g9
	RgRn18s01W7pb0HvhYL9ps6PC6e9GTji3oCRYLD+uZClpQWCo9nQNg1omD/FLG72qOLOavhQ=
X-Gm-Gg: ASbGncuJCc3vr8dqQjLpp/UuMXY7gDJhkO2K+a49M102x/VVxg8JL5W4jwDV9yTnSsE
	e8VL18PRIxRWr9rWgEEl2mlhnv5hyWnYN425CeoYNNqOSp3Ph2Ed4zZmDaOPmIksPAyCeHDTakv
	aggbkqm7ut0Nt4duAOCKSRb2IWJec2J1t3EciTaY2TO/dfOaKUcyFX9XrucJFTSTQxgIw+cRb86
	MXGKX7aaNdjYjR/Lhm5kwVEztfjpHXVc4PMTWuif0zamu9NR8j6InD2B2WZbNNkiQHNthova0Oy
	5Vxx8Zmw/M2WrlYXicdcUAvDJ2ABsSkOgqhExy2KaeJWf1K3NDSi3K/IN0w6L1iS
X-Received: by 2002:a05:6a00:3a04:b0:736:5438:ccc with SMTP id d2e1a72fcca58-7488f70d83amr946335b3a.9.1749763447178;
        Thu, 12 Jun 2025 14:24:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaro1S2SqADI8S7Y/c1VRuYB/ZsLniuDLm1/0zeqvd20a25ETugb6/sj+dQE9QI9PmVnCp5A==
X-Received: by 2002:a05:6a00:3a04:b0:736:5438:ccc with SMTP id d2e1a72fcca58-7488f70d83amr946307b3a.9.1749763446715;
        Thu, 12 Jun 2025 14:24:06 -0700 (PDT)
Received: from [10.73.112.69] (pat_11.qualcomm.com. [192.35.156.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7489000749csm214938b3a.68.2025.06.12.14.24.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 14:24:06 -0700 (PDT)
Message-ID: <683bc42f-2810-4d8f-8712-80f933c4b8ad@oss.qualcomm.com>
Date: Thu, 12 Jun 2025 14:24:04 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] Add Qualcomm SA8255p based firmware managed PCIe
 root complex
From: Mayank Rana <mayank.rana@oss.qualcomm.com>
To: linux-pci@vger.kernel.org, lpieralisi@kernel.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com, andersson@kernel.org,
        manivannan.sadhasivam@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, quic_ramkri@quicinc.com,
        quic_shazhuss@quicinc.com, quic_msarkar@quicinc.com,
        quic_nitegupt@quicinc.com
References: <20250522001425.1506240-1-mayank.rana@oss.qualcomm.com>
 <584d217a-e8df-4dbe-ad70-2c69597a0545@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <584d217a-e8df-4dbe-ad70-2c69597a0545@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDE2NSBTYWx0ZWRfXx0CGSqriZtaq
 RDkwNieAWqgL/y9Fl96V17RcarwTG33bEr+LRybZRyMsmuihxW+wtEYer11wRjlubT+jT27ss04
 P/6mY5DV/Lb8JUv7bfTzRBr6B084ULShWlXSXgbblAPZtuvtFjr7Wjx1Zs7RUDQaYsUGXQbfLCK
 Z7bP5nGLrBUuYJZsu509RQIvQnUG+Gi+gE/Yp94zcBkem/KYCexett/pnbpRMgygrTUlHfcW0BW
 BASwi8HyA3WEHJY6++adUHk52v7pMl81klcSa5A5Y4K2+80uzZD1g22SHVhcAwiIcgDlro7Sk3I
 Mbjg2plZjFvXcIRWqJy0gMQEHupdk72YQY0CKA0s3gOszYKeJ4xUe9e20paX93e7kDvlk03O+qN
 5wHQ9rrV7TQmsleFPKvX+NLnF9nogj5mJCel7d7QRmF0OB/6fL2bqXwdQu1DRM0UO6qmAOl6
X-Authority-Analysis: v=2.4 cv=Q7TS452a c=1 sm=1 tr=0 ts=684b4578 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZdW6uxA9NKXbfdqeeS2OGA==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=zt2UopkEdLRU5ZEdUz8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: UZ8iGHlQR4SsHiRHcBwUBOgLd2lIhQQ3
X-Proofpoint-ORIG-GUID: UZ8iGHlQR4SsHiRHcBwUBOgLd2lIhQQ3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_10,2025-06-12_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506120165

Hi Mani

Gentle reminder for review.

Regards
Mayank

On 6/4/2025 10:38 AM, Mayank Rana wrote:
> Hi Mani
> 
> As we discussed previously, I resumed working on this functionality.
> Please help with reviewing this patchset.
> 
> Regards,
> Mayank
> On 5/21/2025 5:14 PM, Mayank Rana wrote:
>> Based on received feedback, this patch series adds support with existing
>> Linux qcom-pcie.c driver to get PCIe host root complex functionality on
>> Qualcomm SA8255P auto platform.
>>
>> 1. Interface to allow requesting firmware to manage system resources and
>> performing PCIe Link up (devicetree binding in terms of power domain and
>> runtime PM APIs is used in driver)
>>
>> 2. SA8255P is using Synopsys Designware PCIe controller which supports 
>> MSI
>> controller. Using existing MSI controller based functionality by 
>> exporting
>> important pcie dwc core driver based MSI APIs, and using those from
>> pcie-qcom.c driver.
>>
>> Below architecture is used on Qualcomm SA8255P auto platform to get ECAM
>> compliant PCIe controller based functionality. Here firmware VM based 
>> PCIe
>> driver takes care of resource management and performing PCIe link related
>> handling (D0 and D3cold). Linux pcie-qcom.c driver uses power domain to
>> request firmware VM to perform these operations using SCMI interface.
>> --------------------
>>
>>
>>                                     ┌────────────────────────┐
>>                                     │                        │
>>    ┌──────────────────────┐         │     SHARED MEMORY      
>> │            ┌──────────────────────────┐
>>    │     Firmware VM      │         │                        
>> │            │         Linux VM         │
>>    │ ┌─────────┐          │         │                        
>> │            │    ┌────────────────┐    │
>>    │ │ Drivers │ ┌──────┐ │         │                        
>> │            │    │   PCIE Qcom    │    │
>>    │ │ PCIE PHY◄─┤      │ │         │   ┌────────────────┐   
>> │            │    │    driver      │    │
>>    │ │         │ │ SCMI │ │         │   │                │   
>> │            │    │                │    │
>>    │ │PCIE CTL │ │      │ ├─────────┼───►    PCIE        
>> ◄───┼─────┐      │    └──┬──────────▲──┘    │
>>    │ │         ├─►Server│ │         │   │    SHMEM       │   │     
>> │      │       │          │       │
>>    │ │Clk, Vreg│ │      │ │         │   │                │   │     
>> │      │    ┌──▼──────────┴──┐    │
>>    │ │GPIO,GDSC│ └─▲──┬─┘ │         │   └────────────────┘   │     
>> └──────┼────┤PCIE SCMI Inst  │    │
>>    │ └─────────┘   │  │   │         │                        
>> │            │    └──▲──────────┬──┘    │
>>    │               │  │   │         │                        
>> │            │       │          │       │
>>    └───────────────┼──┼───┘         │                        
>> │            └───────┼──────────┼───────┘
>>                    │  │             │                        
>> │                    │          │
>>                    │  │             
>> └────────────────────────┘                    │          │
>>                    │  
>> │                                                           │          │
>>                    │  
>> │                                                           │          │
>>                    │  
>> │                                                           │          │
>>                    │  
>> │                                                           │IRQ       
>> │HVC
>>                IRQ │  
>> │HVC                                                        │          │
>>                    │  
>> │                                                           │          │
>>                    │  
>> │                                                           │          │
>>                    │  
>> │                                                           │          │
>> ┌─────────────────┴──▼───────────────────────────────────────────────────────────┴──────────▼──────────────┐
>> │                                                                                                          │
>> │                                                                                                          │
>> │                                      
>> HYPERVISOR                                                          │
>> │                                                                                                          │
>> │                                                                                                          │
>> │                                                                                                          │
>> └──────────────────────────────────────────────────────────────────────────────────────────────────────────┘
>>    ┌─────────────┐    ┌─────────────┐  ┌──────────┐   ┌───────────┐   
>> ┌─────────────┐  ┌────────────┐
>>    │             │    │             │  │          │   │           │   
>> │  PCIE       │  │   PCIE     │
>>    │   CLOCK     │    │   REGULATOR │  │   GPIO   │   │   GDSC    │   
>> │  PHY        │  │ controller │
>>    └─────────────┘    └─────────────┘  └──────────┘   └───────────┘   
>> └─────────────┘  └────────────┘
>> -----------------
>> Changes in v4:
>> - Addressed provided review comments from reviewers
>> Link to v3: https://lore.kernel.org/lkml/20241106221341.2218416-1- 
>> quic_mrana@quicinc.com/
>>
>> Changes in v3:
>> - Drop usage of PCIE host generic driver usage, and splitting of MSI 
>> functionality
>> - Modified existing pcie-qcom.c driver to add support for getting ECAM 
>> compliant and firmware managed
>> PCIe root complex functionality
>> Link to v2: https://lore.kernel.org/linux-arm- 
>> kernel/925d1eca-975f-4eec-bdf8-ca07a892361a@quicinc.com/T/
>>
>> Changes in v2:
>> - Drop new PCIe Qcom ECAM driver, and use existing PCIe designware 
>> based MSI functionality
>> - Add power domain based functionality within existing ECAM driver
>> Link to v1: https://lore.kernel.org/all/d10199df-5fb3-407b-b404- 
>> a0a4d067341f@quicinc.com/T/
>>
>> Tested:
>> - Validated NVME functionality with PCIe1 on SA8255P-RIDE platform
>>
>> Mayank Rana (4):
>>    PCI: dwc: Export dwc MSI controller related APIs
>>    PCI: host-generic: Rename and export gen_pci_init() API to allow ECAM
>>      creation
>>    dt-bindings: PCI: qcom,pcie-sa8255p: Document ECAM compliant PCIe root
>>      complex
>>    PCI: qcom: Add Qualcomm SA8255p based PCIe root complex functionality
>>
>>   .../bindings/pci/qcom,pcie-sa8255p.yaml       | 103 ++++++++++++++++
>>   drivers/pci/controller/dwc/Kconfig            |   1 +
>>   .../pci/controller/dwc/pcie-designware-host.c |  38 +++---
>>   drivers/pci/controller/dwc/pcie-designware.h  |  14 +++
>>   drivers/pci/controller/dwc/pcie-qcom.c        | 114 ++++++++++++++++--
>>   drivers/pci/controller/pci-host-common.c      |   5 +-
>>   include/linux/pci-ecam.h                      |   2 +
>>   7 files changed, 248 insertions(+), 29 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie- 
>> sa8255p.yaml
>>
> 


