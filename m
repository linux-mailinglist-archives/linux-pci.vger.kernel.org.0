Return-Path: <linux-pci+bounces-42679-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CB1CA6074
	for <lists+linux-pci@lfdr.de>; Fri, 05 Dec 2025 04:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD4A53098FB9
	for <lists+linux-pci@lfdr.de>; Fri,  5 Dec 2025 03:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C3318DB1E;
	Fri,  5 Dec 2025 03:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IJfjPI9A";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Pwi/j1dz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67656233149
	for <linux-pci@vger.kernel.org>; Fri,  5 Dec 2025 03:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764906142; cv=none; b=VhamExgkCDc0VCdiTdRYknXyVQFr2lU6bbW1C4bPnb9I2hrQ58LVP1ZfQZf21YsxgkYSRuDOFrIYOaOIbCm1li1ZUzp9bd5phTjY+2nnHE6Kzzn8+BXi0rZGenGYQo0gdHq5+KUyWwSfRIG3DHx2g68iRRF9PtL2YdPt/sNqo2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764906142; c=relaxed/simple;
	bh=/ffm5dZNqs18Wlxx6m8Q6HFpgn/Q+O/7HMn8oStQdlY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CzyOr2ejY1eb3iErxuKiTuUIgxpGW+ImGNSpZ6dMTLgTzS8PmIn0oa3otZiSxtrNA8B/fejP6jItstWEXCNOPBPzzuWsGbN9a02QXhfpsF4OQPJu6hembEuiA+7TRJIutwPyv0Zyg6SG6xG9p8B3exNH98AuKFZUBKUcdF1PexA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IJfjPI9A; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Pwi/j1dz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B52er2U3173559
	for <linux-pci@vger.kernel.org>; Fri, 5 Dec 2025 03:42:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6aaPuXoGDbI2EMcYjuuqwUlc3QiA4RI2K0QZyobNsNI=; b=IJfjPI9A0GViqOCM
	e6aV2XMRvWFt81uGPCyhEFzejzZmJLQ9BiXCawit6DNrUtMEA9kRghKpOD6Vfgoj
	ond6yfqQUvDXYAUpyXqWET1/93i1R1+b1REA4t0EB2ylA22JGkEEeMOzJG0VhrKb
	F7t/3DxcFJXEYexcG3HdmpQEgOwAKZoIcNfTHSnKoj8hOtajhHqq2ejfUb8Gk45H
	3wqu588By9vhJ5FvSFnfUZEGqJ6P+92Ax9F08aX1HVClRtyFpJd+ShVpuYmpc65t
	r4W16bb/lJFO++f+i0DPeX/pIqwaBY/SqMMW86EYIKB8DrULMNRCf4N2ETxLBw/g
	FHsHZw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4auptqr4xf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 05 Dec 2025 03:42:18 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7c240728e2aso3080548b3a.3
        for <linux-pci@vger.kernel.org>; Thu, 04 Dec 2025 19:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764906138; x=1765510938; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6aaPuXoGDbI2EMcYjuuqwUlc3QiA4RI2K0QZyobNsNI=;
        b=Pwi/j1dzI16Xr37s9l8Il/mf5OB27eA4GqZi3lZnk3+gKspWzl8/HZqXwARydMGvqU
         q1e1TYaNsRxJLhODI3y22KTasXm2B2U69Edv29wh34bPk2XJGEUu/roKgiaz0XDA1Ftv
         0QPGehtEljo++DI/ZTL6O94nfLNFkbPwRwgGPBHHbI4a7ixFPdO468I15QsdBj760sUa
         1ll/b5PuPN9JfgMCHKEsYmrOTIy28nt5hK8kHARzh5AmEr81QjHyfC1jxJa2YutkwZnx
         mNaZQtC85Jmdkj/hVwOuX1zfXz+v/HTKnU0Agl3na+pGwOSbvPmM7bU6iy57g1B/N6KE
         9EJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764906138; x=1765510938;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6aaPuXoGDbI2EMcYjuuqwUlc3QiA4RI2K0QZyobNsNI=;
        b=klP23dhrWeGpnUal+Qs/bhpwkZ3oR45jDs+BleF7Nv+8/WDDji2G/7uZxgT4YGCLeF
         584g4OHcxalAVO+iW/QoYr2e3zD0RbaBalDPO+Skwd8HKkM3VkaQJEqI1COZOyp5ZBzg
         qi2q5Q4jl0HE/XcI8nj7Xw8ILydvZPyWgfPEJmmEUlRNF5Ps/mk8xcvI5PWijNLE1UyD
         baKhumPtzNMm/tTtX0YawFFXDEhZVd+LDp3A95Kuiqixmm1q/IXyHp/gMGBXCrweN5Ez
         sv4s6LR7feyi/kQhGZclJzlljVpEaa11gMgP6h5jzYeE41aMW3H5KXxP17GbVuGBf+XW
         Z+Ew==
X-Gm-Message-State: AOJu0YwlQctgISjvs6ISnBpb1kPQopCDwiv2KRMlf1NqzzK7quYJmoR7
	nQNLHuMJXMK+8D50oSEPf76ktcx4kAbZxQnoU3MYuQbXNpCY3KcOIKdCaomg0ZvUtezekEC/9fM
	OHfwMN3JqpNeX/m3QRyo7+VJWpzx+Vo/JciyHLkTDTB4P2bCoRHyVrMy84jOL34Q=
X-Gm-Gg: ASbGnctdZ900WXv/hEmYBmAMTS4j2G6l/etDQeVBURcCr5wLqFlOds5T9UUvoBgUPnD
	SU2hfksxFO5rrJTbCM18jSmqAmQSldo0wF17hJKiZ6CssyrGpqVpiHxXNwBdYmLuwl1mdZdGZQS
	CmZP8qSOI76DxHPi7sk6vq7YdjoHK73/shn6uSUOVn9TBZCDuGWIaEmYVMDu0BapniH5AMuTTuk
	eWP2b9k9FhyizkPaatdUsyolxEK4/lts8mym0vy1LDPZC9jdQ9dZIWQNzwpaXCKaHQuTnRoj8nT
	1UF3GkcljruENSFF7p8A+o7qnHVg6nz1gHFz11v3TNHwdZ0vPNffsVXNzlSAQjMNML7TI4FdIna
	20gdrd5mMvHo9X+RMlxKQ4ZpN78+FFZ61Jf22gvnzJw==
X-Received: by 2002:a05:6a00:a24:b0:7b9:ea7a:9cbb with SMTP id d2e1a72fcca58-7e00dfd6852mr9164248b3a.19.1764906137967;
        Thu, 04 Dec 2025 19:42:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGRpzgdFxqVuZybaCj+GLxuQEQ14N0ibK94hedbAxWGSqAIIA0h1b61VknRRo6n5vnKTpjhSA==
X-Received: by 2002:a05:6a00:a24:b0:7b9:ea7a:9cbb with SMTP id d2e1a72fcca58-7e00dfd6852mr9164216b3a.19.1764906137426;
        Thu, 04 Dec 2025 19:42:17 -0800 (PST)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7e2adc5bf26sm3602015b3a.39.2025.12.04.19.42.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Dec 2025 19:42:17 -0800 (PST)
Message-ID: <5fbf0df7-4835-4765-9cdd-36e252f166cb@oss.qualcomm.com>
Date: Fri, 5 Dec 2025 09:12:13 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RFC: Is pci_wake_from_d3(true) allowed to be called in EP
 drivers' .shutdown()?
To: Shawn Lin <shawn.lin@rock-chips.com>, Bjorn Helgaas
 <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc: "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS"
 <linux-pci@vger.kernel.org>
References: <a6dae914-972e-45c4-90be-b52615edafa4@rock-chips.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <a6dae914-972e-45c4-90be-b52615edafa4@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: alLq3E-434--_H_3GsDcOyGLz9XxwtyR
X-Proofpoint-ORIG-GUID: alLq3E-434--_H_3GsDcOyGLz9XxwtyR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA1MDAyOCBTYWx0ZWRfXzRj9+AuoEXj9
 OBVTxBDv/unBgWJ2GYfez0LIZQWS/0wxhmsNL9aPdbdxXG4lLJhZQXvb/o3WFL2R+oXqM3yhdqO
 3/UHMzEOOpCgyZBMsSY/5OyWEOCBPEFA0z+upt486FlajnYvkBmIGuBeY6xLK39guInnQ3HUnF3
 n4vScTEOw5WQ3xCmIJbvyBI0f1PjC6mum4KPsNwBngQArF38PZ//XImilnHMBf6I9oNkwghhig0
 w/VuMicvcekRa8FdXb0PWAKVTPzc2m/5bcyAvs92Uo4IsKP8BIBdzKEhapSYOXAWhB8FsfwzC4N
 L2jCP5pZ0SBKTc2/jBsFtuKLYgxv15ihIdW2sdWXJkgkcRD3G/ugYbJqJwbJIb3l3b4xqczttwO
 EaZUyRWN9gjrHdEhXWL14aF74cpQ2Q==
X-Authority-Analysis: v=2.4 cv=fKQ0HJae c=1 sm=1 tr=0 ts=6932549b cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=GxtLFK48VY7HqebBNooA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_01,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512050028



On 12/4/2025 6:56 PM, Shawn Lin wrote:
> Hi folks,
>
> I ran into an occasional system hang when adding .shutdown() support 
> to pcie-dw-rockchip.c. Here's what I found.
>
> The Problem:
>
> During shutdown, my system would sometimes just hang. The call trace 
> shows a race between a NIC driver's shutdown and the PCIe host 
> driver's shutdown.
>
> What's Happening:
>
> My NIC driver (like r8168) calls pci_wake_from_d3(pdev, true)in its 
> .shutdown().
>
> This eventually queues a delayed work with a 1-second delay 
> (queue_delayed_work(pci_pme_work, PME_TIMEOUT)).
>
> pci_wake_from_d3(pdev, true)
>      -> pci_enable_wake(true)
>        -> __pci_enable_wake(true)
>          -> pci_pme_active(dev, true)
>            -> queue_delayed_work(pci_pme_work, PME_TIMEOUT) #1 second
>
> After the NIC driver finishes, the PCIe host driver's .shutdown() 
> kicks in. It starts cleaning up – gating clocks, powering down the IP, 
> etc.
>
> The Race:​ If that 1-second delayed work runs after the host 
> controller has begun its cleanup, it tries to read the PCI config 
> space. But the hardware might already be partially down, causing a hang.
As you are keeping PCIe link in D3cold, you should inform PCI framework 
that you are keeping link in D3cold whether you are in shutdown call or 
normal call.
Before gatting clocks and powering down the IP inform the PCI framework 
that you are going to D3cold by updating the Dstate to D3cold with this API
pci_bus_set_current_state(pp->bridge->bus, PCI_D3cold);

- Krishna Chaitanya.
>
> Here are the actual logs from a hung system showing the two sides of 
> the race:
>
> Log 1: NIC driver setting up the work during shutdown
>
> [ 49.961836][ T1] Hardware name: Rockchip RK3588 Decenta OPS C41 V10 
> Board (DT)
> [ 49.962494][ T1] Call trace:
> [ 49.962782][ T1] dump_backtrace+0xf4/0x114
> [ 49.963188][ T1] show_stack+0x18/0x24
> [ 49.963555][ T1] dump_stack_lvl+0x6c/0x90
> [ 49.963945][ T1] dump_stack+0x18/0x38
> [ 49.964301][ T1] pci_pme_active+0x80/0x1dc
> [ 49.964701][ T1] pci_wake_from_d3+0xc8/0x100
> [ 49.965111][ T1] rtl8168_shutdown+0x15c/0x194 [r8168]
> [ 49.965705][ T1] pci_device_shutdown+0x34/0x44
> [ 49.966138][ T1] device_shutdown+0x164/0x21c
> [ 49.966551][ T1] kernel_power_off+0x3c/0x14c
> [ 49.966961][ T1] __arm64_sys_reboot+0x268/0x270
> [ 49.967391][ T1] invoke_syscall+0x40/0x104
> [ 49.967791][ T1] el0_svc_common+0xb8/0x164
> [ 49.968190][ T1] do_el0_svc+0x1c/0x28
> [ 49.968556][ T1] el0_svc+0x1c/0x48
> [ 49.968890][ T1] el0t_64_sync_handler+0x68/0xb4
> [ 49.969320][ T1] el0t_64_sync+0x164/0x168
>
> Log 2: The delayed work trying to run after host cleanup, causing the 
> hang
>
> [ 51.258983][ T1] Call trace:
> [ 51.259261][ T1] dump_backtrace+0xf4/0x114
> [ 51.259663][ T1] show_stack+0x18/0x24
> [ 51.260020][ T1] dump_stack_lvl+0x6c/0x90
> [ 51.260409][ T1] dump_stack+0x18/0x38
> [ 51.260764][ T1] pci_generic_config_read+0x30/0xd0
> [ 51.261229][ T1] dw_pcie_rd_other_conf+0x18/0x5c
> [ 51.261673][ T1] pci_bus_read_config_word+0x74/0xd4
> [ 51.262136][ T1] pci_read_config_word+0x40/0x4c
> [ 51.262568][ T1] pci_pme_list_scan+0xd8/0x180
> [ 51.262989][ T1] process_one_work+0x1a8/0x3b8
> [ 51.263411][ T1] worker_thread+0x24c/0x420
> [ 51.263810][ T1] kthread+0xe8/0x1b4
> [ 51.264156][ T1] ret_from_fork+0x10/0x20
>
>
> This seems common as I found several upstream  PCI NIC drivers that call
> pci_wake_from_d3 during shutdown (like in igb_main.c, i40e_main.c, 
> atl1.c). Also, 7 other PCIe host drivers already implement .shutdown. 
> For example, pci-imx6.cresets the controller in its shutdown – I'm not 
> sure what happens on imx platforms, but it definitely causes hangs on 
> Rockchip.
>
> My main question is:
>
> Is it really a good idea for NIC drivers to call 
> pci_wake_from_d3(true) in .shutdown()? This queues a delayed work that 
> needs to access PCI config space, but the host controller might be 
> shutting down at the same time. This feels like a risky pattern. Are 
> these drivers doing the right thing? Or should this wake-up setup 
> happen differently to avoid this race?
>
> Would love to hear your thoughts on how to properly fix this.
>


