Return-Path: <linux-pci+bounces-42238-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A3340C90E03
	for <lists+linux-pci@lfdr.de>; Fri, 28 Nov 2025 06:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 98C4F34EBA3
	for <lists+linux-pci@lfdr.de>; Fri, 28 Nov 2025 05:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C2324466C;
	Fri, 28 Nov 2025 05:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oNm0Uu5/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jsx/B04w"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A634233704
	for <linux-pci@vger.kernel.org>; Fri, 28 Nov 2025 05:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764306897; cv=none; b=iKDCQUGhKV6WBDQQWRjAkl7UR4Hn9TLgA9ac6CB+ZSdn4oJi6t+1UQYbtAtoXQtm9Nics1x1M42iWm81/xkSXPJiAGDvX8SiHoD5D+t5V683J9JfT0eWNS0eGaSYjWDwn3rOZ5BNLr6nccBeTs33kUJMdPZk/2Pt4EYwpmWolx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764306897; c=relaxed/simple;
	bh=M8GlfEiklZuOY7nx6BPVuMoql6qI/PxDeGyNTmts0SE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tV9SnbJc3GYiljPBuYVFyOisHupUh6V9eDtWRWDNvfoyGKYvk7l5XpUnGDPt5YVFzXa8he4yWIfpLsPNWDlrc5ACndj9aNDdT2uK+zt8C9uP/pX6RISwVGCFcrGG3z10KjWCNzzn6p5QqsIzOFa9Hsbd7s6k2A5yg3uox3so+d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oNm0Uu5/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jsx/B04w; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ARNFie12271529
	for <linux-pci@vger.kernel.org>; Fri, 28 Nov 2025 05:14:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3P7RhofvXTDR3ANF/0/Z5BBID9rk3iIYywYc2CR0VEs=; b=oNm0Uu5/r39zmsXH
	Ww/FxY7zU5a7FLLSd+H/n31b9Orq7Q9fkO1gA3afaUoVgaerND5f/rpRu6SpKBNg
	Uo8i3rSKuxU1MNezK+jZQuOsCuTIgZKT9UklabBxrtCdizAl3LEM4qZbYOv2WUyf
	DxRqpb/kt4mAxLePaiWLf7F246MuSjbhqq8RGGu7ehN6otRMPSIAKp9QeI7/QtBj
	ZxPkos2CPCYDRNXzI9OEJfADPm/ryAKiLVM9PB9J73gKZZMshIM2s4c37YCN1Fea
	Kq2/0hX98VcRi2sfA1I2weW1dw610SbaYdQN0x9u+uecLVzH5Q6jWjzuJ9NE6cxt
	+dTPOw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4apq66hr90-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 28 Nov 2025 05:14:54 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-29845b18d1aso27077855ad.1
        for <linux-pci@vger.kernel.org>; Thu, 27 Nov 2025 21:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764306894; x=1764911694; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3P7RhofvXTDR3ANF/0/Z5BBID9rk3iIYywYc2CR0VEs=;
        b=jsx/B04wTXhQqv9ijWj0ToNPJvn3/ZyetS9evjh+mGiFBynOLYb8QNUKeeZsNrXXh4
         Z5ZJFQ67ic/Ke39pS+3UkmRf+NHIrnj8nto0thrBsnnWcRAVt1JTG7+tAIxcC6wPEf/4
         18Dpo19tJ3x0PJgP7pjxRGLVswq9O/8r6KmVf+R0qH5vRyNfUjz6b33BLQv6UjCJ9eTK
         o/3FoWB9KQdqoKm9V55EP3SYXB9xJ2xyPcbTaAJaGkO1xyahtYlZTFEpCgRlerqkEjTr
         lUEOAm8oxKwPFcuR7gJGomDmYmbMzpqvoCnADOcvQMNOW+e3p0MBKhPV9l2qvJuHfBTq
         lgiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764306894; x=1764911694;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3P7RhofvXTDR3ANF/0/Z5BBID9rk3iIYywYc2CR0VEs=;
        b=rfh137pO8U1yfA1KmnQnnxeWup9mmHqlC0YJ0tHrWU9IkAqPcuffDyIWDFYLPDEKnn
         fHlPI7KEnHhgVp0/Qvymcj1qfYJxOeBat+Q1FRnrDFZrhXBtQPnzyauIrmYjauh4JIY3
         Df06CA7kCg7YN/goOeynUH6Q1VDhqfQgTtzrPO7SaYeYaVGFTHEPyoC69UDjZytX5w2T
         mmACxMnCOn/XBvUUCl4XiVjQhEaED9Z6qe6vh2HH32ElEQraHtSD1C20HDR7IEqnaLum
         QpyZXZc4HOTMVcsGDBqu3uMYfli72iIDFpMeUcUED3caNFB2+zoGE1RSfugTvfOiOEOR
         Hgiw==
X-Forwarded-Encrypted: i=1; AJvYcCWf3B/FTqEqKhC3K7R5zQTNowL/zoLsKSkcohc3UTm6P+V9iW4IGuK/Bjy4ut4XNCCWmikOsC/MN/E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0VjbJEZ8FJ+QtcmwF6joVdb/RQcwSaMwTsRB5ya4FS+QbaZmf
	yXfbnyETfbuY+cZHGHGqjyJjmd43KVkYtuahZ4FaglPjBaBJtAx4wi6zRgjphbAcGfjggGZD7VR
	s75IxdcMr275Cy8yzM9bdOXxQAx0DOyBeUpcTIAF41kkNi9aph9Bm1vZ8pr6x1fk=
X-Gm-Gg: ASbGncspBomRO+4i15kZeJH5z3WIjmr8VcGnAUqH4tPirK3aJAOTwkFZ/afKAmxgj0S
	Gd9WZsVDRrom1AU6FPC1PcX9faR9E3WjgjuU1F5kDFsYDGD3/WeC1fZHPynDOyYzNcchrfA5WLc
	LC/0xsJwjDnvQmvLzcPigeGZLUnX8tqliVxbFrj1tL82Nc4JKq/2hrX4K1g4gnv6T0UsfekZB4j
	/ElcKrs9Ln7B5xddZN2knmfmA/EWrOTOJ3zWpLxAuX9fQwgrN/yo/FBuHeGs9bt6Ambi8XqeAbL
	OO+MlPYZ99+Fx8q3e/D7f0kmqGyKTHx+Ze08Ightaz/joKjQ5qUVGQq0GrD9QAhIaLm5FAhRKMJ
	ziAfoqVMeYjvwQNkK5WTW9dR+7wjD9BNLyZsRNcLkvA==
X-Received: by 2002:a17:902:ce11:b0:298:49db:a9c5 with SMTP id d9443c01a7336-29b6c692349mr241764485ad.43.1764306893905;
        Thu, 27 Nov 2025 21:14:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFpM/HnNqs7nEOD0HrLHZoIO3ahaX4CGZhGquWcB2wHc70S2K19Gzp2KSzLQy29XVA/M1epWg==
X-Received: by 2002:a17:902:ce11:b0:298:49db:a9c5 with SMTP id d9443c01a7336-29b6c692349mr241764245ad.43.1764306893389;
        Thu, 27 Nov 2025 21:14:53 -0800 (PST)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bceb40ac4sm32286365ad.77.2025.11.27.21.14.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Nov 2025 21:14:53 -0800 (PST)
Message-ID: <c7aea2b3-6984-40f5-8234-14d265dabefc@oss.qualcomm.com>
Date: Fri, 28 Nov 2025 10:44:47 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 4/4] PCI: dwc: Support ECAM mechanism by enabling iATU
 'CFG Shift Feature'
To: "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alim Akhtar
 <alim.akhtar@samsung.com>,
        Jonathan Chocron <jonnyc@amazon.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20250909-controller-dwc-ecam-v9-0-7d5b651840dd@kernel.org>
 <20250909-controller-dwc-ecam-v9-4-7d5b651840dd@kernel.org>
 <alpine.DEB.2.21.2511280256260.36486@angie.orcam.me.uk>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <alpine.DEB.2.21.2511280256260.36486@angie.orcam.me.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: toOwrmKel_mg0U4svKT6nR0wM_cxOlwY
X-Proofpoint-ORIG-GUID: toOwrmKel_mg0U4svKT6nR0wM_cxOlwY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI4MDAzNSBTYWx0ZWRfXyqlplEy6xmem
 HDxgOzIoS3rZUnireFHXB3bHud9JT90/R3CERyRG3A+GtHAO8idtVs9prBTT3Z8jYreWzqlt4h1
 7hM6zMpRG275YVXIEdlz4Hm5ubyYKQKdfoJCfACt8kGZsvwOgRRyAVy+9DO3xhLdTq5VyUVIW37
 B+uZLzEgwK6W5fnZlx2C9BYTa5FOQC/n2T/jmzJjJRPk5JNS1EkJSce1BDS+x4bT1P+cZSmlPGY
 1C2i94epXE86ulWz5jkvT+X75VeLDxso0fLhWUmJuby0EEBzaK0wkm5aqooiw11B6V84xsV0Q29
 fs7+zGZ1wKCRGtn9CYTn43BBh3ZMNyWRNtEmqNzgNhBWiP2IIXyx8YMire4kDduMKf+GZIO1Xht
 nzFLr88Tc9A60ctoN9y6WxdEwg6ZjA==
X-Authority-Analysis: v=2.4 cv=BYHVE7t2 c=1 sm=1 tr=0 ts=69292fce cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=5rJZNewN76S2RKxIRykA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511280035



On 11/28/2025 8:47 AM, Maciej W. Rozycki wrote:
> On Tue, 9 Sep 2025, Manivannan Sadhasivam wrote:
>
>> From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>>
>> Designware databook r5.20a, sec 3.10.10.3 documents the 'CFG Shift Feature'
>> of the internal Address Translation Unit (iATU). When this feature is
>> enabled, it shifts/maps the BDF contained in the bits [27:12] of the target
>> address in MEM TLP to become BDF of the CFG TLP. This essentially
>> implements the Enhanced Configuration Address Mapping (ECAM) mechanism as
>> defined in PCIe r6.0, sec 7.2.2.
>   So this broke a parallel port on my HiFive Unmatched machine (a SiFive
> FU740-C000 based system), the driver no longer registers the device, no
> /dev/parport0 anymore.
Hi Maciej, can you share us lspci -vvv o/p with working & non working 
case and also can you point us parport driver. - Krishna Chaitanya.
>   I've had to bisect it with commit a1978b692a39 ("PCI: dwc: Use custom
> pci_ops for root bus DBI vs ECAM config access") and commit fc2bc2623e3a
> ("Revert "PCI: qcom: Prepare for the DWC ECAM enablement"") applied on top
> and it's affirmative it's this change, i.e. upstream commit 0da48c5b2fa7
> ("PCI: dwc: Support ECAM mechanism by enabling iATU 'CFG Shift Feature'").
>
>   Here's the relevant part of a diff between bootstrap logs:
>
> --- dmesg-good.log	2025-11-28 03:41:18.943097032 +0100
> +++ dmesg-bad.log	2025-11-28 03:47:29.582049781 +0100
> @@ -1,5 +1,5 @@
> -Booting Linux on hartid 3
> -Linux version 6.17.0-rc1-00008-g4660e50cf818-dirty (macro@angie) (riscv64-linux-gnu-gcc (GCC) 13.0.0 20220602 (experimental), GNU ld (GNU Binutils) 2.38.50.20220503) #19 SMP Fri Nov 28 02:37:51 GMT 2025
> +Booting Linux on hartid 1
> +Linux version 6.17.0-rc1-00009-g0da48c5b2fa7-dirty (macro@angie) (riscv64-linux-gnu-gcc (GCC) 13.0.0 20220602 (experimental), GNU ld (GNU Binutils) 2.38.50.20220503) #20 SMP Fri Nov 28 02:43:00 GMT 2025
>   Machine model: SiFive HiFive Unmatched A00
>   SBI specification v0.3 detected
>   SBI implementation ID=0x1 Version=0x9
> @@ -61,7 +61,7 @@
>   EFI services will not be available.
>   smp: Bringing up secondary CPUs ...
>   smp: Brought up 1 node, 4 CPUs
> -Memory: 16383064K/16777216K available (10746K kernel code, 2200K rwdata, 4972K rodata, 537K init, 371K bss, 389448K reserved, 0K cma-reserved)
> +Memory: 16383064K/16777216K available (10746K kernel code, 2200K rwdata, 4972K rodata, 536K init, 371K bss, 389448K reserved, 0K cma-reserved)
>   devtmpfs: initialized
>   clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
>   posixtimers hash table entries: 2048 (order: 3, 32768 bytes, linear)
> @@ -161,6 +161,7 @@
>   fu740-pcie e00000000.pcie:       IO 0x0060080000..0x006008ffff -> 0x0060080000
>   fu740-pcie e00000000.pcie:      MEM 0x0060090000..0x007fffffff -> 0x0060090000
>   fu740-pcie e00000000.pcie:      MEM 0x2000000000..0x3fffffffff -> 0x2000000000
> +fu740-pcie e00000000.pcie: ECAM at [mem 0xdf0000000-0xdffffffff] for [bus 00-ff]
>   fu740-pcie e00000000.pcie: Using 256 MSI vectors
>   fu740-pcie e00000000.pcie: iATU: unroll T, 8 ob, 8 ib, align 4K, limit 4096G
>   fu740-pcie e00000000.pcie: cap_exp at 70
> @@ -655,7 +656,7 @@
>   usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.17
>   usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
>   usb usb1: Product: xHCI Host Controller
> -usb usb1: Manufacturer: Linux 6.17.0-rc1-00008-g4660e50cf818-dirty xhci-hcd
> +usb usb1: Manufacturer: Linux 6.17.0-rc1-00009-g0da48c5b2fa7-dirty xhci-hcd
>   usb usb1: SerialNumber: 0000:04:00.0
>   hub 1-0:1.0: USB hub found
>   hub 1-0:1.0: 2 ports detected
> @@ -663,7 +664,7 @@
>   usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.17
>   usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
>   usb usb2: Product: xHCI Host Controller
> -usb usb2: Manufacturer: Linux 6.17.0-rc1-00008-g4660e50cf818-dirty xhci-hcd
> +usb usb2: Manufacturer: Linux 6.17.0-rc1-00009-g0da48c5b2fa7-dirty xhci-hcd
>   usb usb2: SerialNumber: 0000:04:00.0
>   hub 2-0:1.0: USB hub found
>   hub 2-0:1.0: 2 ports detected
> @@ -735,8 +736,6 @@
>   pcieport 0000:06:01.0: enabling bus mastering
>   parport_pc 0000:07:00.0: enabling device (0000 -> 0001)
>   PCI parallel port detected: 1415:c118, I/O at 0x1000(0x1008), IRQ 35
> -parport0: PC-style at 0x1000 (0x1008), irq 35, using FIFO [PCSPP,TRISTATE,EPP,ECP]
> -lp0: using parport0 (interrupt-driven).
>   parport_pc 0000:07:00.0: vgaarb: pci_notify
>   serial 0000:07:00.3: vgaarb: pci_notify
>   serial 0000:07:00.3: assign IRQ: got 40
>
> and then it goes on with insignificant changes only owing to differences
> in the order of messages produced, the kernel version ID or date stamps.
> As you can see the PCIe parallel port device continues being accessible,
> it's only the driver that doesn't pick up the device anymore.
>
>   I'm stumped as to where it might be coming from.  Any ideas?
>
>    Maciej


