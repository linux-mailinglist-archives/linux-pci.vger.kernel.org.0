Return-Path: <linux-pci+bounces-41363-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E60C62ADB
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 08:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 5FD1422954
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 07:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345B73176E0;
	Mon, 17 Nov 2025 07:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="iqz49SGW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m32105.qiye.163.com (mail-m32105.qiye.163.com [220.197.32.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87805316910;
	Mon, 17 Nov 2025 07:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763363545; cv=none; b=Febhd/1fTXV7gB6rzMkJbn2xneEBbBGWyj5TiNwa/wFxlilasiipTXTSPhpRJv6mecmRIOVjEKetfUMVnKMkvDXcqy+hnqZUqj8ktx+50FHY9J7WVK/CpOjjWCsTaQEQMAj1IdPJIBdZw/c3jhb2nfDvfVzuYg0MrSJoOLC+OKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763363545; c=relaxed/simple;
	bh=hBs7BWFuJLm3njcdhha6spSB4xF2eB1P648L2la8O7A=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ABRQ7a1U/e/DXOW4qC5jRK25L+27OMqF5/S+x0xrdeTgZ/r2kQGvunt3lPghRqrNGWTH6sLf2ohOXUAA8H5cMgoh15NoH2fUmCMCciCRcKMahVcZmMbD+avshwaiemxOWxDshBErIG2vjH2gF7EX/WKzWDaAu66jR3wu7Cb4i5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=iqz49SGW; arc=none smtp.client-ip=220.197.32.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 29c9004d4;
	Mon, 17 Nov 2025 11:42:59 +0800 (GMT+08:00)
Message-ID: <8f3cc1c1-7bf7-4610-b7ce-79ebd6f05a6e@rock-chips.com>
Date: Mon, 17 Nov 2025 11:42:59 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Johan Jonker <jbx6244@gmail.com>,
 Dragan Simic <dsimic@manjaro.org>, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 0/3] PCI: rockchip: 5.0 GT/s speed may be dangerous
To: Geraldo Nascimento <geraldogabriel@gmail.com>
References: <cover.1763197368.git.geraldogabriel@gmail.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <cover.1763197368.git.geraldogabriel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a8fe8a40409cckunm2225600d70b383
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGk9ISFZDHx8aThpIQxkdTU1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=iqz49SGWasZFgXzvmpgvrAR/MiWOraupVXaPEaboWVYCcb/RkncHqs1bDxk236bb5xLnrZpa/O9g9zIVR3QitzVvwYdmqnu25XhHXnG5UGEq/cJdWiS4vzlPE29CJQ8C9imQcmwuPVBFSZsuTZaZ61zjdE1XET97PRp2eNCjBec=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=L/mOHkyVCGlpZGPK0VdOwC9RDdilpu9JCgLw5m5Dy4Y=;
	h=date:mime-version:subject:message-id:from;

Hi Geraldo,

在 2025/11/15 星期六 17:10, Geraldo Nascimento 写道:
> In recent interactions with Shawn Lin from Rockchip it came to my
> attention there's an unknown errata regarding 5.0 GT/s operational
> speed of their PCIe core. According to Shawn there's grave danger
> even if the odds are low. To contain any damage, let's cover the
> remaining corner-cases where the default would lead to 5.0 GT/s
> operation as well as add a comment to Root Complex driver core,
> documenting this danger.
> 

I'm not sure just adding a warn would be a good choice. Could we totally
force to use gen1 and add a warn if trying to use Gen2.

Meanwhile amend the commit message to add a reference
of RK3399 official datesheet[1] which says PCIe on RK3399 should only
support 2.5GT/s?


[1]https://opensource.rock-chips.com/images/d/d7/Rockchip_RK3399_Datasheet_V2.1-20200323.pdf

> Geraldo Nascimento (3):
>    PCI: rockchip: warn of danger of 5.0 GT/s speeds
>    PCI: rockchip-host: comment danger of 5.0 GT/s speed
>    arm64: dts: rockchip: drop max-link-speed = <2> in helios64 PCIe
> 
>   arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts | 1 -
>   drivers/pci/controller/pcie-rockchip-host.c            | 5 +++++
>   drivers/pci/controller/pcie-rockchip.c                 | 8 ++++++--
>   3 files changed, 11 insertions(+), 3 deletions(-)
> 


