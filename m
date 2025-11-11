Return-Path: <linux-pci+bounces-40811-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E6AC4B4E8
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 04:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D55BD3A2F69
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 03:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2377D2F5311;
	Tue, 11 Nov 2025 03:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="FKlailV5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m32108.qiye.163.com (mail-m32108.qiye.163.com [220.197.32.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771C833B6C8;
	Tue, 11 Nov 2025 03:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762831365; cv=none; b=DGM1A1ImeFsOwYltYqyvA+1UxJ46xXITUsuPsG6i6G4LzQ+6TbwO6hLDU8sNKueESIhwhmrceDh4WOdrG/LS3wC3ZYWudPT+LNQlYu3koxqolyX6DVPRgYR1ZWbV2rU/+7ZzhlPNwEtp9PUVCwt5jR5+D4n2xQtbqaV1epwsl2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762831365; c=relaxed/simple;
	bh=kT2YaKBzTRkmBnVi68pXEXDYGZj1X4zMox0oM5Y386E=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=M6i71NEdjrXFOkJF/yZO5KzBkTs5Cn0WC1wGkif5+WqpdPDEca3K7bCi8/KELBPDGUXJN8G6b5bELhSdrLlwkve2d8nJpjjeZa7mCzVJXCBhcNHsqkNAGq3bio/Lh9ufOUTqansbZJ2hlW96rwjMdnQ1XZb616xPUhOnaLp6Q1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=FKlailV5; arc=none smtp.client-ip=220.197.32.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.129] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2920392a1;
	Tue, 11 Nov 2025 11:17:24 +0800 (GMT+08:00)
Message-ID: <05bd0efe-9a84-40e9-af07-51c0b0d865bf@rock-chips.com>
Date: Tue, 11 Nov 2025 11:17:23 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Damien Le Moal <dlemoal@kernel.org>,
 Anand Moon <linux.amoon@gmail.com>, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Dragan Simic <dsimic@manjaro.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Heiko Stuebner <heiko@sntech.de>, Niklas Cassel <cassel@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [RESEND] Re: [PATCH] PCI: dw-rockchip: Skip waiting for link up
To: FUKAUMI Naoki <naoki@radxa.com>
References: <55EB0E5F655F3AFC+136b89fd-98d4-42af-a99d-a0bb05cc93f3@radxa.com>
 <aRCI5kG16_1erMME@ryzen>
 <F8B2B6FA2884D69A+b7da13f2-0ffb-4308-b1ba-0549bc461be8@radxa.com>
 <780a4209-f89f-43a9-9364-331d3b77e61e@rock-chips.com>
 <4487DA40249CC821+19232169-a096-4737-bc6a-5cec9592d65f@radxa.com>
 <363d6b4d-c999-43d4-866e-880ef7d0dec3@rock-chips.com>
 <0C31787C387488ED+fd39bfe6-0844-4a87-bf48-675dd6d6a2df@radxa.com>
 <dc932773-af5b-4af7-a0d0-8cc72dfbd3c7@rock-chips.com>
 <aRHb4S40a7ZUDop1@ryzen>
 <2n3wamm3txxc6xbmvf3nnrvaqpgsck3w4a6omxnhex3mqeujib@2tb4svn5d3z6>
 <aRJEDEEJr9Ic-RKN@fedora>
 <B721C8A516FDB604+a04b38d3-64ec-423f-9e4c-040c8d2aec76@radxa.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <B721C8A516FDB604+a04b38d3-64ec-423f-9e4c-040c8d2aec76@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a70eb0e3b09cckunm01a7eea81458b7c
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGk5OTVZNQ05KSU5CSUMZQk9WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=FKlailV5rqm923DDW0DU9rfU+TO/zidhTTeZUIGI9pQ9ppnHtt7efud90vTJpVC6/FOYjoiplSbH0R5EtAFYbldT2IzwOtsLUmRBFmpcAHH3p3yhIV3A3EpZ73wWPJHaJ3clVb2y/VshDuvK/8/n7XtUj8IMcVAW8xV6rbpOawI=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=K5ABXh2/uhWraYUqJ9BUk7p0Ge5LHjETStkwwcjp/eo=;
	h=date:mime-version:subject:message-id:from;

在 2025/11/11 星期二 10:09, FUKAUMI Naoki 写道:
> On 11/11/25 04:59, Niklas Cassel wrote:

...

> 
> Leaving the commit message aside, I'm currently testing with a revert of 
> the two patches.
> 
> Vanilla v6.18-rc5, CONFIG_PCI_DYNAMIC_OF_NODES=y, revert ec9fd499b9c6, 
> revert 0e0b45ab5d77.
> 
> It works stably on the ROCK 5A. The link speed is 2Gb/s.
> 
> The ROCK 5C is unstable. It initially worked with a link speed of 4Gb/s, 
> but eventually started showing kernel oops. The dts files for the 5A and 
> 5C are compatible and interchangeable, but even using the 5A's dts on 
> the 5C, the operation remains unstable.

The link speed on ROCK 5A is 2Gb/s also means it's downgraded now. Did
ROCK 5A work under the link speed of 4Gb/s before?

In case it's signal integrity relevant, you could enable PCIE_DW_DEBUGFS
and refer to Documentation/ABI/testing/debugfs-dwc-pcie to collect
RASDES info from there.

> 
> I plan to thoroughly investigate the ROCK 5C's behavior on v6.13, but 
> for now, I believe reverting the two patches is the correct action.
> 
> Best regards,
> 
> -- 
> FUKAUMI Naoki
> Radxa Computer (Shenzhen) Co., Ltd.
> 
>> Kind regards,
>> Niklas
>>
> 
> 
> 


