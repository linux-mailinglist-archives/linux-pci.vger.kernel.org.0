Return-Path: <linux-pci+bounces-43354-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5E8CCEE89
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 09:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 676B4301D65D
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 08:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5C22D46B4;
	Fri, 19 Dec 2025 08:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUEVguAS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC1D27AC31;
	Fri, 19 Dec 2025 08:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766131986; cv=none; b=HPl7ZMRUWZYou3g70N7TSjIIYOAZiR9JGFLdvyEqcRobu7seQXMeyikBJjiE6W0H69zW/8tCAWXgVglsgTiRFr6nhwXsT6ifKoY0CNtWKW/L0EBJei2irzvNt/3/NXLPhUg+LgWhTY/YsIATcZE30JwiTomSv4QnOnTc2EnVIls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766131986; c=relaxed/simple;
	bh=f+RrjfVCBgq3UY1No8gqDTUXVFcFPU09Uy5DhqORVsA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=J1RmM5aQRIaQldEUcO/vyxJgKSWWN2IHvb1SINkYD7Y5/JsVL+kfqZa00AZAQ1CKUjy9+3pwr/NjEj8ixXXGyKyH5U0cP207oUjhRT4aSJ14nyyxS8HD1d2v7QqsTEfuQ8Ks5nPQvp2EbY90jT01G3bBe9psZsI3mBr33gp/o4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUEVguAS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE4B5C4CEF1;
	Fri, 19 Dec 2025 08:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766131985;
	bh=f+RrjfVCBgq3UY1No8gqDTUXVFcFPU09Uy5DhqORVsA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hUEVguASheuvLht0vG4bqerZ4qXyBJDhgQ9N4gICfgoYkp2tcOdnUvuiXsQbR5vWb
	 2MRjucnHZFaLP+IyIrhDMjtcQrimJtAiPF3eUaYbb2pq1JHNoCEVbrjjm5QWaXWmap
	 5t+8ZZ0LESAAJYtRcrtT0UanhCz7t6IbAF+FGuj2iKcJ3RqMcK20pjvwfSWFdumvv+
	 9gGAeSRfvGhR5vWbNnUhVPf5wDsGT21A/Qu8Ua227VjPGRBi4Z9KPd2O2dfldfod2r
	 5YTbgYdRs8RmbJJZqTH1Z7OaiqsZxWPr3t+G0ETOpmGiz8S5gwVnw9jwhs/lv+SVDn
	 dfEXWXMQvPrqQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F3005380AA50;
	Fri, 19 Dec 2025 08:09:55 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 0/6] Add support for StarFive VisionFive 2 Lite board
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <176613179479.3684357.2451207324135136166.git-patchwork-notify@kernel.org>
Date: Fri, 19 Dec 2025 08:09:54 +0000
References: <20251125075604.69370-1-hal.feng@starfivetech.com>
In-Reply-To: <20251125075604.69370-1-hal.feng@starfivetech.com>
To: Hal Feng <hal.feng@starfivetech.com>
Cc: linux-riscv@lists.infradead.org, conor+dt@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, palmer@dabbelt.com, pjw@kernel.org,
 aou@eecs.berkeley.edu, rafael@kernel.org, viresh.kumar@linaro.org,
 lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 bhelgaas@google.com, lgirdwood@gmail.com, broonie@kernel.org,
 emil.renner.berthing@canonical.com, heinrich.schuchardt@canonical.com,
 e@freeshell.de, devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Conor Dooley <conor.dooley@microchip.com>:

On Tue, 25 Nov 2025 15:55:58 +0800 you wrote:
> VisionFive 2 Lite is a mini SBC based on the StarFive JH7110S industrial
> SoC which can run at -40~85 degrees centigrade and up to 1.25GHz.
> 
> Board features:
> - JH7110S SoC
> - 4/8 GiB LPDDR4 DRAM
> - AXP15060 PMIC
> - 40 pin GPIO header
> - 1x USB 3.0 host port
> - 3x USB 2.0 host port
> - 1x M.2 M-Key (size: 2242)
> - 1x MicroSD slot (optional non-removable 64GiB eMMC)
> - 1x QSPI Flash
> - 1x I2C EEPROM
> - 1x 1Gbps Ethernet port
> - SDIO-based Wi-Fi & UART-based Bluetooth
> - 1x HDMI port
> - 1x 2-lane DSI
> - 1x 2-lane CSI
> 
> [...]

Here is the summary with links:
  - [v4,1/6] PCI: starfive: Use regulator APIs instead of GPIO APIs to enable the 3V3 power supply of PCIe slots
    (no matching commit)
  - [v4,2/6] dt-bindings: riscv: Add StarFive JH7110S SoC and VisionFive 2 Lite board
    https://git.kernel.org/riscv/c/7a1e15b248d6
  - [v4,3/6] riscv: dts: starfive: jh7110-common: Move out some nodes to the board dts
    https://git.kernel.org/riscv/c/84853940a733
  - [v4,4/6] riscv: dts: starfive: Add common board dtsi for VisionFive 2 Lite variants
    https://git.kernel.org/riscv/c/2ad6d71a0de8
  - [v4,5/6] riscv: dts: starfive: Add VisionFive 2 Lite board device tree
    https://git.kernel.org/riscv/c/900b32fd601b
  - [v4,6/6] riscv: dts: starfive: Add VisionFive 2 Lite eMMC board device tree
    https://git.kernel.org/riscv/c/ae264ae12442

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



