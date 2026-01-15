Return-Path: <linux-pci+bounces-44884-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2DAD22017
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 02:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBD06304654D
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 01:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6259241C71;
	Thu, 15 Jan 2026 01:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="kK8nOhBf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m15591.qiye.163.com (mail-m15591.qiye.163.com [101.71.155.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEC417C220
	for <linux-pci@vger.kernel.org>; Thu, 15 Jan 2026 01:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768439818; cv=none; b=p5SaQWSP4EbZNqGSia3dgzl7j4q3kwxyp+GYYCFOFtB5urkpLfrHpytD5Aaqbx81K73Xf0IOESXuJaGDO/BJIuiYFPgmKgMHZXskaGmokIVO8oCWjgdvUPivDMnnukGyrnttHRb8wPlsaOG5IcEPT3GNwBA7l8K9H4RqV77bRqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768439818; c=relaxed/simple;
	bh=+MairoeOK03feU8q+wmNVupoGrXZbpMpJ867p6P1XaE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dC9PKrIV4xm/kOby4CPSAYC+6l4Ft4plr9bP1xtUtfZjE2vWzjDkOhtS2aa750TZTFOMa1X7rCcTmd941BX22t6z3ebjchz03DuXp5FxevYgURQYRkSTWaU8BUZbOiy+eyhEpgXBaWvumCvY+U9GgZPUysvSSA8Kf2MsMVcg14g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=kK8nOhBf; arc=none smtp.client-ip=101.71.155.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 30b0570b3;
	Thu, 15 Jan 2026 08:41:17 +0800 (GMT+08:00)
Message-ID: <354e3edb-ac42-4610-89ec-227fe07d4cf6@rock-chips.com>
Date: Thu, 15 Jan 2026 08:41:14 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Manivannan Sadhasivam <mani@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Vinod Koul <vkoul@kernel.org>,
 linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-phy@lists.infradead.org, Heiko Stuebner <heiko@sntech.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH 0/5] Add calibration for Synopsys PCIe PHY and Controller
To: Niklas Cassel <cassel@kernel.org>
References: <1766560210-100883-1-git-send-email-shawn.lin@rock-chips.com>
 <aWe5s5mqFt26lRGL@ryzen>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <aWe5s5mqFt26lRGL@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9bbf197d9f09cckunma8104af25048b4
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0wYTVZKTRlJHU5LHkgYTh5WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=kK8nOhBfeBjm+qLybyuZBQDiWagiaYZERdgLtmd90l44dyWCGokOOtCVYGIsPO+IHRKsrwF+0nAFU9DDogPC/0uYvWLySUA59MsK9/ZsVQ8iXPABWeLJiQvMA/k/BqqXLrc5GvEVmUg8C25q+RcUB0FqDH0NTysnBNRpTYZNa9I=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=RHktkXwIGR8cU+9o2qWN73LkcikteCMvtYc9osiW8ZM=;
	h=date:mime-version:subject:message-id:from;


在 2026/01/14 星期三 23:43, Niklas Cassel 写道:
> On Wed, Dec 24, 2025 at 03:10:05PM +0800, Shawn Lin wrote:
>>
>> Currently, when pcie-dw-rockchip uses the Synopsys PHY, it relies on
>> the phy_init() callback of the phy-rockchip-snps-pcie3 driver to
>> perform calibration. This is incorrect because the controller is
>> still held in reset at that time, preventing the PHY from accurately
>> reflecting the actual PLL lock and calibration status.
> 
> Hello Shawn,
> 
> I can see that you move the calibration code from .phy_init() to
> .phy_calibrate().
> 
> And I understandthat the controller is still held in reset.
> 
> I understand that the the PHY calibration is supposed to be done
> when the controller is not held in reset, and that alone is
> enough to warrant a fix.

Sure.

> 
> The Synopsys Gen3 PHY is used in e.g. Rock5b, and link training
> currently works fine with this PHY, so what is the actual

It just happended to work as in most cases, the calibration finished
very quickly after controller is not held in reset.

> implications of performing the PHY calibration when the controller
> is held in reset?
> 
> Will it somehow it improve signal integrity?
> 

Performing the PHY calibration when the controller is held
in reset is the wrong way. If the refclk or PHY power supply isn't
ready, the bogus calibration still passes, then the system will get
stuck when accessing DBI. So performing the PHY calibration must be done
after controller quit the reset state.

> 
> Kind regards,
> Niklas
> 
>>
>> To fix this, this series:
>> 1. Calls phy_calibrate() in the pcie-dw-rockchip driver (if supported)
>>     after the controller is out of reset, ensuring the PHY can
>>     properly synchronize with the controller state.
>> 2. Adds the necessary calibration support in the Synopsys PHY driver
>>     to implement this callback.
> 


