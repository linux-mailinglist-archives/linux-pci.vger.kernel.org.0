Return-Path: <linux-pci+bounces-41469-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB45C66AFF
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 01:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 47D1935ED32
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 00:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40B0269806;
	Tue, 18 Nov 2025 00:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="XlUMvPhb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m49211.qiye.163.com (mail-m49211.qiye.163.com [45.254.49.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904A326CE3F;
	Tue, 18 Nov 2025 00:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763426639; cv=none; b=OUpkIgnxchkqKLiAQLFOcA0weUXuUfq7SOa907AaAPAo21kt163h0Ts/NZTYL8GN+/VtWuTcF34cXD3EtqFMF5w4VNeZGPHzGwChQ/iRUjv6U2SyQ3V8ircp7k+7hOlVau+HLhKvYrnYP0iZVfv63oVoQvkft9AIktN3EcDDPSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763426639; c=relaxed/simple;
	bh=Av+Fr30NnWWSU2Hyahw/oBYnjYkuyxbSgctYZJ5+eL4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=heN4ryXzONFu9eAqpOWJ5NyzJu7GpTtBkN0Jx9TrWNxYQ1+/eHzoO6FNEOTVkG10E4oaztdummcwtzsXOWH/2R0Qr4s8oy28suIY5+ClZPdiyGlxsPuvQ3JcwYrH9kogNDo5T+fUMsgw/iw+VJYNk4dRHcCzd26a+6mzzk65k2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=XlUMvPhb; arc=none smtp.client-ip=45.254.49.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 29e80519c;
	Tue, 18 Nov 2025 08:43:45 +0800 (GMT+08:00)
Message-ID: <7e050003-f4ea-4e89-8140-2159c670182f@rock-chips.com>
Date: Tue, 18 Nov 2025 08:43:41 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, linux-rockchip@lists.infradead.org,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Johan Jonker <jbx6244@gmail.com>,
 Dragan Simic <dsimic@manjaro.org>
Subject: Re: [PATCH v2 0/4] PCI: rockchip: 5.0 GT/s speed may be dangerous
To: Geraldo Nascimento <geraldogabriel@gmail.com>
References: <cover.1763415705.git.geraldogabriel@gmail.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <cover.1763415705.git.geraldogabriel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a946ae62e09cckunm57c232373f288
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkoZTlYYSB9CQ09PSBpLQk1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=XlUMvPhbm3JQYF08zp7VfmtLoI5CPW40rJWIiWOOwW22Ofn4z9LH7QdQi8T8myJpAPlIZIntJgPnt1spqSnFcr6eoDbDWvCwxPzUOrQ3kJaJ034g0Zf/jWLilCXnSDKY0tJHyBdOPp2o9qilFekScxRVIefPavvgVb3hbrAi/lI=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=FeV+cp/B6o4d554Dl89hs7gOjhWAAS0EpuPZa0xZZIE=;
	h=date:mime-version:subject:message-id:from;

在 2025/11/18 星期二 5:46, Geraldo Nascimento 写道:
> Dragan Simic already had warned me of potential issues with 5.0 GT/s
> speed operation in Rockchip PCIe. However, in recent interactions
> with Shawn Lin from Rockchip it came to my attention there's grave
> danger in the unknown errata regarding 5.0 GT/s operational speed
> of their PCIe core. Even if the odds are low, to contain any damage,
> let's cover the remaining corner-cases where the default would lead
> to 5.0 GT/s operation as well as add a comment to Root Complex driver
> core, documenting this danger. Furthermore, remove redundant
> declaration of max-link-speed from rk3399-nanopi-r4s.dtsi
> 
> Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
> 

Thanks for fixing these.

Acked-by: Shawn Lin <shawn.lin@rock-chips.com>

> ---
> 
> Changes in v2:
> - hard limit to 2.5 GT/s, not just warn
> - add Reported-by: and Reviewed-by: Dragan Simic
> - remove redundant declaration of max-link-speed from helios64 dts
> - fix Link: of helios64 patch
> - simplify RC mode comment
> - Link to v1: https://lore.kernel.org/all/aRhR79u5BPtRRFw3@geday/
> 
> Geraldo Nascimento (4):
>    PCI: rockchip: limit RK3399 to 2.5 GT/s to prevent damage
>    PCI: rockchip-host: comment danger of 5.0 GT/s speed
>    arm64: dts: rockchip: remove dangerous max-link-speed from helios64
>    arm64: dts: rockchip: remove redundant max-link-speed from nanopi-r4s
> 
>   arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts |  1 -
>   arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dtsi    |  1 -
>   drivers/pci/controller/pcie-rockchip-host.c            |  3 +++
>   drivers/pci/controller/pcie-rockchip.c                 | 10 ++++++++--
>   4 files changed, 11 insertions(+), 4 deletions(-)
> 


