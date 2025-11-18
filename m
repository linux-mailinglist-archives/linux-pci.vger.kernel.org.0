Return-Path: <linux-pci+bounces-41473-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 60828C66C4E
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 02:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3F8664E4969
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 00:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C78B2E0B58;
	Tue, 18 Nov 2025 00:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="ZDj8c+t0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m32110.qiye.163.com (mail-m32110.qiye.163.com [220.197.32.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BACD258ED9;
	Tue, 18 Nov 2025 00:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763427593; cv=none; b=fm2pYxjgT9MVo4XR2Fa8mBrXA9qtn6J2wdFb+oyWRWHVUa64s3wYwk/eorMoCXfyO/5Ei3udiGK9ELXnYKShwN/JgHfZP2LmXHSsBU9gpvFOxULhzVU8wDx+8FFWByUCOcSKXga2S58wyKrMcbzi2pm+tz0SGtuRl6glh4fQUfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763427593; c=relaxed/simple;
	bh=SR3l0xfB9bHEG62S91LEnzihkqtPwhuE2XKKeJpWvck=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sKqcEHHVqpnc6Ogx2pZI6/CA+3eQzeB5AUHXO4+eW3/qi3SpjuMyk/677nPubQr7npzYbz7AYHD2EOrZ9EnMnb2m0Rwj0VovVFCxKZNo5SZ2vedQzjQxTdyzBvv/iTj91p2n2v+aOSHhYbRYWy29ylOgQ5C6+h9KaV8sRgsLMq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=ZDj8c+t0; arc=none smtp.client-ip=220.197.32.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 29e843e9e;
	Tue, 18 Nov 2025 08:54:29 +0800 (GMT+08:00)
Message-ID: <20d86c90-9066-4a44-8fff-f4e3edef256e@rock-chips.com>
Date: Tue, 18 Nov 2025 08:54:26 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>,
 "open list:PCIE DRIVER FOR ROCKCHIP" <linux-pci@vger.kernel.org>,
 "open list:PCIE DRIVER FOR ROCKCHIP" <linux-rockchip@lists.infradead.org>,
 "moderated list:ARM/Rockchip SoC support"
 <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC v1 0/5] Fix some register offset as per RK3399 TRM part 2
To: Anand Moon <linux.amoon@gmail.com>
References: <20251117181023.482138-1-linux.amoon@gmail.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20251117181023.482138-1-linux.amoon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a9474bc4909cckunma9a3e37740cfc
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUNDSFZKH01OGEwZSBkdHx5WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=ZDj8c+t0H/ppLW12rpDdGxE+CcklsaHR0Rd2uwBf1hZX8AIYU+Oa5dYiiaT1g2ToLEpfU5V59tWZRVlanl/OJBzfZkMFaOEpjT4uJvMsV6lAexk7ovOhquNARon8M/qSR4rDyRx/lsPaPQUsIFq+WQ2EVUmikYiWUhfZK3LOPEc=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=9PXroKdeKungPKSuFMqQVLZ09bF3qbvunSo1wZ/xkxk=;
	h=date:mime-version:subject:message-id:from;

Hi Anand,

在 2025/11/18 星期二 2:10, Anand Moon 写道:
> In order to enable ASPM we need to fix the register offset as
> RK3399 TRM part 2 - PCIe Controller.
> 
> Tested on Radxa Rock Pi 4b.
> 

I checked your patch, and it looks like indeed we made some mistakes
here. Could you add fixes tag for each?

BTW, regarding to patch 1, I think you should leave out ASPM part, that
should be another topic after these fixes.

> Thanks
> -Anand
> 
> Anand Moon (5):
>    PCI: rockchip: Fix Link Control register offset and enable ASPM/CLKREQ
>    PCI: rockchip: Fix Device Control register offset for Max payload size
>    PCI: rockchip: Fix Slot Capability Register offset for slot power
>      limit
>    PCI: rockchip: Fix Link Control and Status Register 2 for target link
>      speed
>    PCI: rockchip: Fix Linkwidth Control Register offset for Retrain Link
> 
>   drivers/pci/controller/pcie-rockchip-host.c | 31 +++++++++++----------
>   drivers/pci/controller/pcie-rockchip.h      |  5 ++++
>   2 files changed, 21 insertions(+), 15 deletions(-)
> 
> 
> base-commit: e7c375b181600caf135cfd03eadbc45eb530f2cb


