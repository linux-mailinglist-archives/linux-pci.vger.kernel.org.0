Return-Path: <linux-pci+bounces-32376-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A6AB08B28
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 12:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C9751C249CF
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 10:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763902D948C;
	Thu, 17 Jul 2025 10:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fhwLQQSg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651752D879C
	for <linux-pci@vger.kernel.org>; Thu, 17 Jul 2025 10:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752749183; cv=none; b=RiyUo5svD5SdvW3rjoB0lgtF7Wd/bmlyD+TwQljlDw5qAesbMVcDhM/Lv9QqZ/ipCN8jRxjFTwL2ABbklnt8bcEqWtNBCwpePPLfiQDu6/OhnpTCE8oZsiz9AWAjakKeneqTFRcdBycWmWKoQPeErLDi8CNbwY53JJ2PD/Edenc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752749183; c=relaxed/simple;
	bh=VvUtV52l3KImX65+9uDS4CdyADX7cz8MKiwoD8yRVK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u9OmWkDP0ppyCTjbefQNIzf6lldMMaMGDkSosMkrkBb+536aEo0Cq/NkoHpLVHS9LV9U8RKkjClyF4XEx6gYNPrJcA5n46Z/EOmpNNOIrMvL+4yq+jwokk+UojWP28nAYTTTm20PDlXDvTsb26GfS6WUUQH7SdSphmbLZa0s8kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fhwLQQSg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56H3uRQw000598
	for <linux-pci@vger.kernel.org>; Thu, 17 Jul 2025 10:46:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	B723+r5BA8byBPbGDEYFQhUBH8gC/ULM8G4kkMzp/9M=; b=fhwLQQSgwvLCf9ab
	+C/qprDc5R9QOC2pu3ZcWhRDBjWWi9PTbsx2XUyhTnsVoAJagIZscIRrl+VMH6yi
	sr107eM3f2aBaXIya40TniFoJ0BXK0V4BYXl/qIkW5BznQeH1pmTPZC39Drv4IbT
	wDwhOzBz1a3xuhpb1cv916N0bBN4RuI4Q9UT7rSlnTWHROHcRhGUk1YqEnIyjTca
	ByOCxcESv6JrlX3Fsb3JzVI9KfSEK2uaQaCGYNNYcaa6KV63dAtCGY6fJNRDy8mM
	2iqd2A7QiZlZUeMCrFC2TnelAQsUmGKXZ9MV/goKKXXBp6/0Ocf/HlDBuPFkuqQ3
	ur08+Q==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5drtbcp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 17 Jul 2025 10:46:20 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-74ad608d60aso883447b3a.1
        for <linux-pci@vger.kernel.org>; Thu, 17 Jul 2025 03:46:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752749179; x=1753353979;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B723+r5BA8byBPbGDEYFQhUBH8gC/ULM8G4kkMzp/9M=;
        b=UMTJ2aENQN8Af7YUdqybCWiREfqCBWmmmxbYXxH0a3M78GBz+W6L76NYDpj4F3jE0Y
         R3Qsigpsh1A0IkDwq8vTc2fSpJ1iluy28EgVAKNZoWj1u48VlWkZZhfZ0Hix6Hn8dj/P
         7zoSbHTONAdh1AtKyD7sY+d/zHf7Byht9fi8fYAow3OfyFQlSkStB94Kbkgwlx3mz8tv
         9YLJ8nTfLftLajNs1NzETy6ujyu3SM6KrCqVWHZIU1QYT//UMkb99k+LJdU3amreisfQ
         abr7E3hiiCaCdHtqOfkeLjs4ZBJzrNG8gtDzJ69Ts8Esf4sAuWu1UAK7rYGpI26JuEYq
         E4SQ==
X-Forwarded-Encrypted: i=1; AJvYcCXftYKSQxVST3JJIGpLulSWUcYKncRQh/L94S2qfZynd/vOpQepVdt7r5SUoQCFxWT4w6qXjDyu7rQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIb5NmJUBOfYMfk199LDHqFGZhVnu/1J8Lumn7bmwcH7vyUz5Y
	upcF6P0PthBFMxjYxH1ejCEjwVhl+BXb+ggKZrdiM2ngaG6xeP3VcLq5MOj9HiS+bUOgIHXobAX
	XYM/1VutXq6/yeumMeUG6c8dwlUR2k/JdNPCWORiMqDlTxnehlMTodMkk7s+K1j4=
X-Gm-Gg: ASbGncuc7aA+mAb/DS326YGrrs+dhB4AAQsNLn4ITE+lF+eHwUaqjm0k4mJ48p5dij2
	zoVCJA8DlOrT+UUqZCAc1iGBeqforjV+OotHMFRg4eGoYB/+qm7C7VHpSYstV8xO+MmqyRVvct6
	k6vbe0ug+Ak8uOBYqgDQfB8vDqDHvNSH3XB8nX3h22SwAl//6H0Il6gejMMFyUcEHjgUBddDoqI
	oZsnBuY/8fGEii2QIs6GQ0QlYtXb6X1Rgj54z0GradCf6tMwnlYXTXqEbjq/cIAepTP6sAnVDX4
	nE0c7wCiUowxhKOjM6mOxK7kdsAh0rVapHmcNwCi1avbzPPExpD7YVTE5oU9gBXkFEcNccKLdDV
	Vu8hijNDw9FOG2U4ES1OlbQ7VStVXbuc3
X-Received: by 2002:a05:6a00:1d82:b0:759:3013:8dfa with SMTP id d2e1a72fcca58-75930138e54mr181459b3a.18.1752749179254;
        Thu, 17 Jul 2025 03:46:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJuVslIFv21m6ImazfJSUw6oMv57Mp8930u7+QPOdytv2k43uhEySGP6kVYQgfWfa8cNhOpw==
X-Received: by 2002:a05:6a00:1d82:b0:759:3013:8dfa with SMTP id d2e1a72fcca58-75930138e54mr181410b3a.18.1752749178734;
        Thu, 17 Jul 2025 03:46:18 -0700 (PDT)
Received: from [10.133.33.245] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f25269sm15886150b3a.107.2025.07.17.03.46.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 03:46:18 -0700 (PDT)
Message-ID: <03806d02-1cfc-4db2-8b63-c1e51f5456e2@oss.qualcomm.com>
Date: Thu, 17 Jul 2025 18:46:12 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] wifi: ath12k: Use pci_{enable/disable}_link_state()
 APIs to enable/disable ASPM states
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com,
        Jeff Johnson
 <jjohnson@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        ath12k@lists.infradead.org, ath11k@lists.infradead.org,
        ath10k@lists.infradead.org, Bjorn Helgaas <helgaas@kernel.org>,
        ilpo.jarvinen@linux.intel.com, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>
References: <20250716-ath-aspm-fix-v1-0-dd3e62c1b692@oss.qualcomm.com>
 <20250716-ath-aspm-fix-v1-4-dd3e62c1b692@oss.qualcomm.com>
 <38ace6a3-d594-4438-a193-cf730a7b87d6@oss.qualcomm.com>
 <wyqtr3tz3k2zdf62kgtcepf3sedm7z7wacv27visl2xsrqspmq@wi4fgef2mn2m>
Content-Language: en-US
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
In-Reply-To: <wyqtr3tz3k2zdf62kgtcepf3sedm7z7wacv27visl2xsrqspmq@wi4fgef2mn2m>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: NYerf-uMUGb16Z-4I0kf6UUs-PK91_TR
X-Authority-Analysis: v=2.4 cv=D4xHKuRj c=1 sm=1 tr=0 ts=6878d47c cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=oqDAYNfCzTduPHUzJrAA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: NYerf-uMUGb16Z-4I0kf6UUs-PK91_TR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDA5NCBTYWx0ZWRfX1Rr9Ec8cCoLH
 uHelSloyjtq2KE8fAZQPToJNnfQkxpVeqaUmbif2d4gkEqj/UeTz8PDDwpRppHa8Auww1hgSH1P
 oG8U4YFxGuT5WkRokc69qcCiV7TW0LUWPpHkPhZJTO/cW185fe6opAc50mTt0PEDy2dljVYOVNQ
 mVXOya4GzcAo/WwFeYgpaUHZ5NH+F0CJmZRUG2aAfXSoRa8Y6WK79U2lrLo7tcb3cbm4w6ccf0h
 UPwsF+PINwlBG3hB7nGBKoGiRENYVMGMd0CaXm8PstZXMLMi44QFgfyKFN0YUL3kBWbsdX8Fwp4
 zckSNqDg22UP19VMv90EZGrjBHSebZxDdo2mB04lurs4Jki6rwXH+grNhbIxHyRSYWmcKrWjtXO
 vbbHpnqn3Qc0rOFbhP6xBxFqVhuVxLdLC/UYR6aRsENOekOPn/fI2Rnc5rLwmor9Jn6pcNPt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=999 impostorscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507170094



On 7/17/2025 6:31 PM, Manivannan Sadhasivam wrote:
> On Thu, Jul 17, 2025 at 05:24:13PM GMT, Baochen Qiang wrote:
> 
> [...]
> 
>>> @@ -16,6 +16,8 @@
>>>  #include "mhi.h"
>>>  #include "debug.h"
>>>  
>>> +#include "../ath.h"
>>> +
>>>  #define ATH12K_PCI_BAR_NUM		0
>>>  #define ATH12K_PCI_DMA_MASK		36
>>>  
>>> @@ -928,8 +930,7 @@ static void ath12k_pci_aspm_disable(struct ath12k_pci *ab_pci)
>>>  		   u16_get_bits(ab_pci->link_ctl, PCI_EXP_LNKCTL_ASPM_L1));
>>>  
>>>  	/* disable L0s and L1 */
>>> -	pcie_capability_clear_word(ab_pci->pdev, PCI_EXP_LNKCTL,
>>> -				   PCI_EXP_LNKCTL_ASPMC);
>>> +	pci_disable_link_state(ab_pci->pdev, PCIE_LINK_STATE_L0S | PCIE_LINK_STATE_L1);
>>
>> Not always, but sometimes seems the 'disable' does not work:
>>
>> [  279.920507] ath12k_pci_power_up 1475: link_ctl 0x43 //before disable
>> [  279.920539] ath12k_pci_power_up 1482: link_ctl 0x43 //after disable
>>
>>
>>>  
>>>  	set_bit(ATH12K_PCI_ASPM_RESTORE, &ab_pci->flags);
>>>  }
>>> @@ -958,10 +959,7 @@ static void ath12k_pci_aspm_restore(struct ath12k_pci *ab_pci)
>>>  {
>>>  	if (ab_pci->ab->hw_params->supports_aspm &&
>>>  	    test_and_clear_bit(ATH12K_PCI_ASPM_RESTORE, &ab_pci->flags))
>>> -		pcie_capability_clear_and_set_word(ab_pci->pdev, PCI_EXP_LNKCTL,
>>> -						   PCI_EXP_LNKCTL_ASPMC,
>>> -						   ab_pci->link_ctl &
>>> -						   PCI_EXP_LNKCTL_ASPMC);
>>> +		pci_enable_link_state(ab_pci->pdev, ath_pci_aspm_state(ab_pci->link_ctl));
>>
>> always, the 'enable' is not working:
>>
>> [  280.561762] ath12k_pci_start 1180: link_ctl 0x43 //before restore
>> [  280.561809] ath12k_pci_start 1185: link_ctl 0x42 //after restore
>>
> 
> Interesting! I applied your diff and I never see this issue so far (across 10+
> reboots):

I was not testing reboot. Here is what I am doing:

step1: rmmod ath12k
step2: force LinkCtrl using setpci (make sure it is 0x43, which seems more likely to see
the issue)

	sudo setpci -s 02:00.0 0x80.B=0x43

step3: insmod ath12k and check linkctrl

> 
> [    3.758239] ath12k_pci_power_up 1475: link_ctl 0x42
> [    3.758315] ath12k_pci_power_up 1480: link_ctl 0x40
> [    4.383900] ath12k_pci_start 1180: link_ctl 0x40
> [    4.384026] ath12k_pci_start 1185: link_ctl 0x42
> 
> Are you sure that you applied all the 6 patches in the series and not just the
> ath patches? Because, the first 3 PCI core patches are required to make the API
> work as intended.

pretty sure all of them:

$ git log --oneline
07387d1bc17f (HEAD -> VALIDATE-pci-enable-link-state-behavior) wifi: ath12k: dump linkctrl reg
dbb3e5a7828b wifi: ath10k: Use pci_{enable/disable}_link_state() APIs to enable/disable
ASPM states
392d7b3486b3 wifi: ath11k: Use pci_{enable/disable}_link_state() APIs to enable/disable
ASPM states
f2b0685c456d wifi: ath12k: Use pci_{enable/disable}_link_state() APIs to enable/disable
ASPM states
b1c8fad998f1 PCI/ASPM: Improve the kernel-doc for pci_disable_link_state*() APIs
b8f5204ba4b0 PCI/ASPM: Transition the device to D0 (if required) inside
pci_enable_link_state_locked() API
186b1bbd4c62 PCI/ASPM: Fix the behavior of pci_enable_link_state*() APIs
5a1ad8faaa16 (tag: ath-202507151704, origin/master, origin/main, origin/HEAD) Add
localversion-wireless-testing-ath


> 
>>
>>>  }
>>>  
>>>  static void ath12k_pci_cancel_workqueue(struct ath12k_base *ab)
>>>
>>
>> In addition, frequently I can see below AER warnings:
>>
>> [  280.383143] aer_ratelimit: 30 callbacks suppressed
>> [  280.383151] pcieport 0000:00:1c.0: AER: Correctable error message received from
>> 0000:00:1c.0
>> [  280.383177] pcieport 0000:00:1c.0: PCIe Bus Error: severity=Correctable, type=Data Link
>> Layer, (Transmitter ID)
>> [  280.383184] pcieport 0000:00:1c.0:   device [8086:7ab8] error status/mask=00001000/00002000
>> [  280.383193] pcieport 0000:00:1c.0:    [12] Timeout
>>
> 
> I don't see any AER errors either.

My WLAN chip is attached via a PCIe-to-M.2 adapter, maybe some hardware issue? However I
never saw them until your changes applied.

> 
> - Mani
> 


