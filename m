Return-Path: <linux-pci+bounces-36277-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEAEB59DA6
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 18:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09C5B3BFBCC
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 16:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5911A9FB8;
	Tue, 16 Sep 2025 16:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kS4lkw4R"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3939374271
	for <linux-pci@vger.kernel.org>; Tue, 16 Sep 2025 16:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758040146; cv=none; b=KKbitVDGXWcq5gNoBLE67AB2mkzruZbYQ0Se+WJFyxdSmjW0Ek5uTlh6SxHRiULHugnVUF7DNCUJOFfPYv0Rp7KlV700fAZKrFYUsu8FkwhZA//aQIjTeSI0XCdxHCCr/ScqCHiXaO25qMjsl0NZ2BWnlHTBv7VDRyAUM7V2YmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758040146; c=relaxed/simple;
	bh=V6lAa+9GoxL6c9GboJo7qMttke2uib1segmBaCPWwYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sKyTZde5fOF+2qP0zac/aK6S77dzyeouQS3Y3C2iuRfroj+HCEWJnwag2rmbou/bLU34WGHUog6mkRemGcl1YpW8slzG+IvNS6lEmw4leSDyFhSfLQ6IlfJfknpeuNcDrl1HSo8rVLZgpekUIvGjXAWCg1woYYHSRsR327B9nH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kS4lkw4R; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GGLMRW032342
	for <linux-pci@vger.kernel.org>; Tue, 16 Sep 2025 16:29:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6z+mI/JcrpDzLXkYUuAhV+t032JKtC0auFvwYLf3i/s=; b=kS4lkw4Rhpjk1jzH
	ycLSJ5U87zk0eOVpcBxNZq7sUuJu69qpcRQ2DO8P+UcYiguE1u7la5nmNZgw5jtJ
	w6OfL0juOzhm/eLbPvHdbIbBln6GTjYO3UqlHA6sZ6uoPqqBHhy9HVWsQbd9e5+U
	Sv5Jd140IzOPzrHdf3i7sqQZa+a8u1qVgtymhuXynYUKm2MvRxlh13j37fMT0mUD
	Lu41y3jdHloXYs0FNBvfdHnjKu5qy6YRSUY+1ndA7I74kCZy2O0487IfsysUC9wA
	mNBIgZJXvOFMcB/GaoCdSKQWoK51wLiHPM0jITCD7VcjYbAmVh5BFa39ijJ26cRY
	PMLyOA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497bb5r0su-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 16 Sep 2025 16:29:02 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70dca587837so16662456d6.3
        for <linux-pci@vger.kernel.org>; Tue, 16 Sep 2025 09:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758040142; x=1758644942;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6z+mI/JcrpDzLXkYUuAhV+t032JKtC0auFvwYLf3i/s=;
        b=HcRtdkbLuzGLOYQ891aUs4gjMtKisnnf6NAAnXPbS2g/x5RLCOhSRitpiIY0+V7RE/
         cbanwdLfYcQgUsLF//Hqy1ql/n0xyGeIRV0TorIl2i7snM31FeCgddbmGp/VOy6HG7/+
         kwqTnBU0U1y6cR0Fr+0fSP4L+ymGwikV2OXu6XjMgtR62LV1N3xQ9aEbsILZQOB0w+Su
         zlU8CJttz5ruwVJXwjxcEA9BHJo7fjlJ3IhCYuedz0KZqAVO9Tbjo8RZ6oMw9Mha93oL
         zci00PPU4QwEb4YpOVAT8iiwJOLk6OrHP6Civboc7nMrXaTHAnXZ6gxp3q2CCimS7fZI
         QraA==
X-Gm-Message-State: AOJu0YxDwnR6Mlq+BIxrzTe1n7wqAiDgKLkVihzvx6kWBPHvZ2T1EcZq
	yAJUpKhX6LKbAcLb1ko7PxMYo6ZD65xXwAxAu0jNjZmmC25PU36tGTGzNUABs/qqZJo3GgGFUJ9
	ddNsV0DOH8VG5BPICk69k2sNbkxN1VThdhZ/rOxMPTXWaez6aGBE9mCY3x9mU6sY=
X-Gm-Gg: ASbGncsqgvBm5idiY9Yl1aDhoD0jHaAJc2PEdgtsy7U/tLFKA22rIq9ORI/8umbZ8T/
	he+StHqPZDo8M7pfd/Db8hrP/rtSqWRHYAXRUQ0t2GQj7PF5XL/71btxW20UezaGVVM9YXrcpT6
	sqPl0msRxRKMnGOp3R7ZX8QFSFzdXN6DPJ4u3uTddDb7NpuoQYbsC4iDL61C5wuN9KYVQO0Auza
	l6bXqKafbwg89dyAGBZdnZ/7zLIGWtnILC74kL1wXwuzuuSh47fYoj/EHykRp/lERIBBptSMoZ8
	12HysE3P5W5Gcqm/VY55R4neKfKMGovZz01ximp1osvLctq7cHZVDmsihVajGUhSb9aXlOSc89r
	SpN3cEpQ1/bUwv8lgLcDrUw==
X-Received: by 2002:a05:620a:9482:b0:827:1a76:e8f3 with SMTP id af79cd13be357-8271a862d1emr782817185a.7.1758040141727;
        Tue, 16 Sep 2025 09:29:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEazc1AwmHCnYAYH/ad0hiuc9j4t/7hoTAeblgvj8r7zz/qfCWQgQ6/hxOe2uHonNnxY7+aLw==
X-Received: by 2002:a05:620a:9482:b0:827:1a76:e8f3 with SMTP id af79cd13be357-8271a862d1emr782814485a.7.1758040141090;
        Tue, 16 Sep 2025 09:29:01 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07e1aed5ffsm791617666b.81.2025.09.16.09.28.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 09:29:00 -0700 (PDT)
Message-ID: <ccf1b22b-8b6d-4aae-ac27-e84943b7ffd0@oss.qualcomm.com>
Date: Tue, 16 Sep 2025 18:28:58 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PCI/ASPM: Override the ASPM and Clock PM states set
 by BIOS for devicetree platforms
To: manivannan.sadhasivam@oss.qualcomm.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam
 <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        "David E. Box" <david.e.box@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>
References: <20250916-pci-dt-aspm-v1-0-778fe907c9ad@oss.qualcomm.com>
 <20250916-pci-dt-aspm-v1-1-778fe907c9ad@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250916-pci-dt-aspm-v1-1-778fe907c9ad@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: i5zHw0YFoJMiV2RACWXcPsy3MNVUEk9N
X-Proofpoint-ORIG-GUID: i5zHw0YFoJMiV2RACWXcPsy3MNVUEk9N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDE1MiBTYWx0ZWRfX4Z5eZJabQx1V
 BW4ucrs2Dd82gYVe7unCdAekZzwcl/Tq7jbGm0dReZMrNlonyBstRQyIfISF+2BVRnIveI0znHG
 94WmGVKoVDCB48NSc4f6vm9rZEQtZMtLYUOdoea5SiEVkc8xSsdO3kII67diA7MecjjRF6R9d+v
 BOoFfK3/7Naz8vGBf/pmlPXjp+ABMDvF7M9HyALZyDPeXFfvqE6n5w1JgPEXG+6dw3zXdCDsuiG
 xuSUq5Rgi9/jWfIcMKtohvHF6Edx163NfVegg518BDPNnLPHImHecgkLKViU71DzFpwcMy6j6w9
 w7CUUo/qdFxuAbaainHxs1jAZnVdq5I2BBejd1dsAu9e08twdHZfMTmJRjL6UivXKMvGmReZD8h
 Q8Bglxvf
X-Authority-Analysis: v=2.4 cv=ZfMdNtVA c=1 sm=1 tr=0 ts=68c9904e cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=AEKlotozOucuHJhDSDgA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160152

On 9/16/25 6:12 PM, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> So far, the PCI subsystem has honored the ASPM and Clock PM states set by
> the BIOS (through LNKCTL) during device initialization. This was done
> conservatively to avoid issues with the buggy devices that advertise
> ASPM capabilities, but behave erratically if the ASPM states are enabled.
> So the PCI subsystem ended up trusting the BIOS to enable only the ASPM
> states that were known to work for the devices.
> 
> But this turned out to be a problem for devicetree platforms, especially
> the ARM based devicetree platforms powering Embedded and *some* Compute
> devices as they tend to run without any standard BIOS. So the ASPM states
> on these platforms were left disabled during boot and the PCI subsystem
> never bothered to enable them, unless the user has forcefully enabled the
> ASPM states through Kconfig, cmdline, and sysfs or the device drivers
> themselves, enabling the ASPM states through pci_enable_link_state() APIs.
> 
> This caused runtime power issues on those platforms. So a couple of
> approaches were tried to mitigate this BIOS dependency without user
> intervention by enabling the ASPM states in the PCI controller drivers
> after device enumeration, and overriding the ASPM/Clock PM states
> by the PCI controller drivers through an API before enumeration.
> 
> But it has been concluded that none of these mitigations should really be
> required and the PCI subsystem should enable the ASPM states advertised by
> the devices without relying on BIOS or the PCI controller drivers. If any
> device is found to be misbehaving after enabling ASPM states that they
> advertised, then those devices should be quirked to disable the problematic
> ASPM/Clock PM states.
> 
> In an effort to do so, start by overriding the ASPM and Clock PM states set
> by the BIOS for devicetree platforms first. Separate helper functions are
> introduced to set the default ASPM and Clock PM states and they will
> override the BIOS set states by enabling all of them if CONFIG_OF is
> enabled. To aid debugging, print the overridden ASPM and Clock PM states.
> 
> In the future, these helpers could be extended to allow other platforms
> like VMD, newer ACPI systems with a cutoff year etc... to follow the path.
> 
> Link: https://lore.kernel.org/linux-pci/20250828204345.GA958461@bhelgaas
> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---

[...]

> +	/* Override the BIOS disabled Clock PM state for devicetree platforms */
> +	if (IS_ENABLED(CONFIG_OF) && !enabled) {

JFYI CONFIG_OF=y && CONFIG_ACPI=y is valid, at least on arm64
Maybe something like of_have_populated_dt()?

You can then choose which one to use with e.g. acpi=force

Konrad

