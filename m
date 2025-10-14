Return-Path: <linux-pci+bounces-38011-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 600BABD7725
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 07:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D7E3A34EE80
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 05:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542821E98E3;
	Tue, 14 Oct 2025 05:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Bm8YKhch"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FF2299943
	for <linux-pci@vger.kernel.org>; Tue, 14 Oct 2025 05:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760420176; cv=none; b=lVAmA6TCizdAtOuUwyBwzdk3vA/sDpJfHuPLGMtsW3WqcPW6ucrpWsaAIXGWxCpztSOz71XrgZotNlajSwRLGS0CoAxd34kx4bJoY/QqNLGWkUkg2ER2VZHAkjAcPC/4SOYgZaAYVq0n5ChPW5Dq6MLzlYdfw0l1fOe2BLjm1/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760420176; c=relaxed/simple;
	bh=5RlDZIH/oxFVBlQHiYFsX5wFXeqeq6URgoE2IqTx2jI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dqmwENts1sakDy6pjkiP4pdUU0JL4k3vz/bp77yxQXQ0EKareIeFWwdVRgys6mrQFILMK4lGgf6bLyKh/L33nrExJq7x7MEMGAPVWJVh9atA0PNzdAo4uV1Sb/PCBBqvaxlv7A8IOJFksoBaQ9b4n3+slb0d3zl9zV/IdomM/fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Bm8YKhch; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59DHD8r5002361
	for <linux-pci@vger.kernel.org>; Tue, 14 Oct 2025 05:36:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nGQ1HH2B6A4U5Y0vYjvst9AOWsJbygVsidDBRZJFqLM=; b=Bm8YKhchNTQWmJjN
	jUjOdXQyZYANctX0THA3f25h2SlmblfVPHtvC+rES8PaCmr5/PpLcBxwYPSDgps7
	w5CYFGhsYFU+t9PYf/Mt7OEOl8/EFMFyfTxgQtpw/ocxd6TGhUqkcR6hiVpzq/P5
	fMKLqP4V9voGH47iKRrSbSsAdJ4OKWL9xttEBmaKnSoIWKK1yZvxYOWEP7ONhvIg
	0nQ3iGZK7elNFtouFjZNv9X4X+sbkLlsdYHaH6P1xFVeXrPd4Ejp0P1rkN/fTPHO
	JWid4pHEtPwG9HECFsrfYTm6eOct58r2vYVIRRXQ4C7Lx1htJU6nyUYcu2plrFP1
	nZpDyQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfdk77nt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 14 Oct 2025 05:36:13 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-77f2466eeb5so8613117b3a.2
        for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 22:36:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760420172; x=1761024972;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nGQ1HH2B6A4U5Y0vYjvst9AOWsJbygVsidDBRZJFqLM=;
        b=U6blrliZpyw5NV/adjx9zJmtJKBqzQDQjL1aI00KXNYPIqkK83M3rDsDBLyf2WkJUS
         QyNEQ6Hzo2EIBgzYswlEkqYhpRnR+we1Fwlpfa/gLJHsQUCk5CjiNthA65DlrbrYxyrH
         FC/EIZ53WzKfrA/1Nom8YNpLFRwQvO9BrAgYbzq4RMk3/wfpxOvNbN21p6IT+xeiMFK+
         FFCdjEM5vJSjOlMKchyQYhhTO7H4csoH2YzDPr76JZ6bxjXx1TgpqwEJ4Tz/1H3aiXBt
         SulLTiOZy/TxMqViMvKvo8deujS9bFnirJqdf1JZGvSelHKGZauW+pYr844sAIlx6YTB
         wHLw==
X-Forwarded-Encrypted: i=1; AJvYcCWLSaVTQllw1/LGKSTo8Er2crEj2tnrykgukrdfCWfQwZ+67QATITlyBHXUQFjDNn8Cd1ZfCkCW15g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfFwBzMWO4hGtmh2AbUtTN5oqfG9onyPpnh1rPZqBhKaayXloQ
	gMEdbLcVGcpTWCifVo2xeJmRcLkGnAyrnCL476Tw5Uj98xXoaQm8dBG4VQLTKjAT/nUyvJzhOoI
	xMOpAS8zoVp8SM3nazg1sjF/QRbNKmFRTXquiH6feffVXeRHggNbLgeIc3fxYWEU=
X-Gm-Gg: ASbGncsHzqOyraT9dZ6veW0RA05QeNIBAp8wo/YLdikWEN31sriT58uYZKWIyvaWdZv
	wKHbj5jm2tacyix1h4r4OK1v2OOyZuYYOIkGpRfg4kEDKIpZSz8S7meoBepPDqgJY8AAdhkoEa6
	pGQ3vcovqHggrDNSTc5FPOd6hACvXaFNsX3FX6Q9feh5qnGJN6kD6Dsacg2Y8TUUoGwBzcpWfHe
	0aryVg1+qmUz+gAJra3uuomQeN+sBD4nI7cEJkD+D9Fm9UnGTM6n+c+4lA6h0/KHGprCM/kf7GS
	ohWctOxQ5Gfx8z9FEOQitK6QZnkJvhb68nCV2XFpJJr/We9/eVru8//C//Duw8jJRWTsGBvkMg=
	=
X-Received: by 2002:a05:6a20:9188:b0:32b:83bf:2cdb with SMTP id adf61e73a8af0-32da8206da3mr31448323637.15.1760420171891;
        Mon, 13 Oct 2025 22:36:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSlhc1mcSl8tmhuzaLaI+INs35wZ1CSXhcN7zcbL3S2avPe4DXFk5/GWDyliZFU2mc1MPfpg==
X-Received: by 2002:a05:6a20:9188:b0:32b:83bf:2cdb with SMTP id adf61e73a8af0-32da8206da3mr31448282637.15.1760420171401;
        Mon, 13 Oct 2025 22:36:11 -0700 (PDT)
Received: from [10.218.42.132] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b678df4c40esm10506658a12.33.2025.10.13.22.36.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 22:36:11 -0700 (PDT)
Message-ID: <759e429c-b160-46ff-923e-000415c749ee@oss.qualcomm.com>
Date: Tue, 14 Oct 2025 11:06:06 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: SiFive FU740 PCI driver fails on 6.18-rc1
To: Ron Economos <re@w6rz.net>, Bjorn Helgaas <helgaas@kernel.org>,
        Conor Dooley <conor@kernel.org>
Cc: bhelgaas@google.com, mani@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Paul Walmsley <pjw@kernel.org>, Greentime Hu <greentime.hu@sifive.com>,
        Samuel Holland <samuel.holland@sifive.com>,
        regressions@lists.linux.dev
References: <20251013212801.GA865570@bhelgaas>
 <bc7deb1a-5f93-4a36-bd6a-b0600b150d48@oss.qualcomm.com>
 <95a0f2a4-3ddd-4dec-a67e-27f774edb5fd@w6rz.net>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <95a0f2a4-3ddd-4dec-a67e-27f774edb5fd@w6rz.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: vrglKYDjWRDmu9j3kTKOZ1nthjKhAjSd
X-Authority-Analysis: v=2.4 cv=MrNfKmae c=1 sm=1 tr=0 ts=68ede14d cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=JizxZ_2zm4TzMdWxA80A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: vrglKYDjWRDmu9j3kTKOZ1nthjKhAjSd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX5gZEw7mpSRXC
 bFr5PAVrpjqjrFZUYCYvePlcoyxPjBCzQYf6fy8WRg6D3dWBgFBBq3KHYcJfeyYAKDOs/pB0TUU
 SSaq0ybLktCKQpUuzEgkenmcNxnOp6L2/iMzvp/mVCmDwhcKIT0IWULvotvCOJnwuih+wdo3En7
 iKeZ6l0TzdyLBI1uzrX+Y8bpRPjv5vIJKSu/htV2IZy/H+rggfc9O4Mc7XGZ9ANCASfJ0V+lAXr
 kQOLBHzT0cpbFJ8gvtSuTVlyr8wh3h01KkG5XflqtrtRLjToxkK3/NQrtCWkGbfX9hugcDRPNg2
 NSq7Mm+5xDZ4i+ElcJX5106t+j6Ev4T4NGkckG5geh6H2lhGjBJb8OfrIRF3FPI70YRmi36LGJz
 H/6hnO5G7dP0/z9C9jPEqf5zJxMSBw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_09,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018



On 10/14/2025 10:56 AM, Ron Economos wrote:
> On 10/13/25 22:20, Krishna Chaitanya Chundru wrote:
>>
>>
>> On 10/14/2025 2:58 AM, Bjorn Helgaas wrote:
>>> [+cc FU740 driver folks, Conor, regressions]
>>>
>>> On Mon, Oct 13, 2025 at 12:14:54AM -0700, Ron Economos wrote:
>>>> The SiFive FU740 PCI driver fails on the HiFive Unmatched board with 
>>>> Linux
>>>> 6.18-rc1. The error message is:
>>>>
>>>> [    3.166624] fu740-pcie e00000000.pcie: host bridge 
>>>> /soc/pcie@e00000000
>>>> ranges:
>>>> [    3.166706] fu740-pcie e00000000.pcie:       IO
>>>> 0x0060080000..0x006008ffff -> 0x0060080000
>>>> [    3.166767] fu740-pcie e00000000.pcie:      MEM
>>>> 0x0060090000..0x007fffffff -> 0x0060090000
>>>> [    3.166805] fu740-pcie e00000000.pcie:      MEM
>>>> 0x2000000000..0x3fffffffff -> 0x2000000000
>>>> [    3.166950] fu740-pcie e00000000.pcie: ECAM at [mem
>>>> 0xdf0000000-0xdffffffff] for [bus 00-ff]
>>>> [    3.579500] fu740-pcie e00000000.pcie: No iATU regions found
>>>> [    3.579552] fu740-pcie e00000000.pcie: Failed to configure iATU 
>>>> in ECAM
>>>> mode
>>>> [    3.579655] fu740-pcie e00000000.pcie: probe with driver fu740-pcie
>>>> failed with error -22
>>>>
>>>> The normal message (on Linux 6.17.2) is:
>>>>
>>>> [    3.381487] fu740-pcie e00000000.pcie: host bridge 
>>>> /soc/pcie@e00000000
>>>> ranges:
>>>> [    3.381584] fu740-pcie e00000000.pcie:       IO
>>>> 0x0060080000..0x006008ffff -> 0x0060080000
>>>> [    3.381682] fu740-pcie e00000000.pcie:      MEM
>>>> 0x0060090000..0x007fffffff -> 0x0060090000
>>>> [    3.381724] fu740-pcie e00000000.pcie:      MEM
>>>> 0x2000000000..0x3fffffffff -> 0x2000000000
>>>> [    3.484809] fu740-pcie e00000000.pcie: iATU: unroll T, 8 ob, 8 
>>>> ib, align
>>>> 4K, limit 4096G
>>>> [    3.683678] fu740-pcie e00000000.pcie: PCIe Gen.1 x8 link up
>>>> [    3.883674] fu740-pcie e00000000.pcie: PCIe Gen.3 x8 link up
>>>> [    3.987678] fu740-pcie e00000000.pcie: PCIe Gen.3 x8 link up
>>>> [    3.988164] fu740-pcie e00000000.pcie: PCI host bridge to bus 
>>>> 0000:00
>>>>
>>>> Reverting the following commits solves the issue.
>>>>
>>>> 0da48c5b2fa731b21bc523c82d927399a1e508b0 PCI: dwc: Support ECAM 
>>>> mechanism by
>>>> enabling iATU 'CFG Shift Feature'
>>>>
>>>> 4660e50cf81800f82eeecf743ad1e3e97ab72190 PCI: qcom: Prepare for the 
>>>> DWC ECAM
>>>> enablement
>>>>
>>>> f6fd357f7afbeb34a633e5688a23b9d7eb49d558 PCI: dwc: Prepare the 
>>>> driver for
>>>> enabling ECAM mechanism using iATU 'CFG Shift Feature'
>>>
>>> As Conor pointed out, we can't fix a code regression with a DT change.
>>>
>>> #regzbot introduced: f6fd357f7afb ("PCI: dwc: Prepare the driver for 
>>> enabling ECAM mechanism using iATU 'CFG Shift Feature'")
>> Hi Conor,
>>
>> Can you try with this patch and see if it is fixing the issue.
>> diff --git a/drivers/pci/controller/dwc/pcie-fu740.c 
>> b/drivers/pci/controller/dwc/pcie-fu740.c
>> index 66367252032b..b5e0f016a580 100644
>> --- a/drivers/pci/controller/dwc/pcie-fu740.c
>> +++ b/drivers/pci/controller/dwc/pcie-fu740.c
>> @@ -328,6 +328,8 @@ static int fu740_pcie_probe(struct platform_device 
>> *pdev)
>>
>>         platform_set_drvdata(pdev, afp);
>>
>> +       pci->pp.native_ecam = true;
>> +
>>         return dw_pcie_host_init(&pci->pp);
>>  }
>>
>> - Krishna Chaitanya.
>>
>>>
> I've already tried it. It doesn't work. Same error message as before.
Can you share us dmesg logs for this change.

- Krishna Chaitanya.
> 

