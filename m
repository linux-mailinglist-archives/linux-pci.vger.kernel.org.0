Return-Path: <linux-pci+bounces-42087-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5FAC874F7
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 23:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AA27A4E2D0D
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 22:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5317727E07E;
	Tue, 25 Nov 2025 22:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eciMa9XV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27184241679;
	Tue, 25 Nov 2025 22:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764109626; cv=none; b=CLeOO5RID7QEj1DkUiGtsd5zjchBvXs5PxeXnu7NR6M3iGQZcIho0Kh3IE2NryYeBOO+XLagjgf1bPYWUV6uyAOcGk3B0SYx9LmsutLolAyOlYdLOXJkJGZzyPUUYlzZYeza6UjarBbyLStxM0S+uD0TNOqSoYpeNZ8OMKNjxcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764109626; c=relaxed/simple;
	bh=tvzsh/T0A1Kda45r2lEQQuHG2ohIode9EkWcu2UZIek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I3PozqHnUv3NB5r3KHkitwy5R7+t/bN7eluW90GWV7s15nmNmzJMtKxVdvuRHOjRJiw4uYG84TsDB6St+/NFd0zxIwtOziEGkDZlbs5XnSLQQAVlTSt2PCxF7WaD8XA3VEcmhb4QO7VbPzIWims/249RjH+GAPUdNQJbdyI/LK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eciMa9XV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6F1BC4CEF1;
	Tue, 25 Nov 2025 22:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764109625;
	bh=tvzsh/T0A1Kda45r2lEQQuHG2ohIode9EkWcu2UZIek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eciMa9XVclKKM37VFqsAQNYkPQFpSQTswvL3NjyQn2x1uJX1dppNf0Zepq7DvOr/b
	 uWR8/N2+Wv6WL7SUHLyqO4ej2wxkT4E/Q8ed6e2AZExYM/DjILvnF14b7OkilgA8mv
	 T0yzXODjyI6lE09j42XVtiZdF/jxZ/C9fZFhEr643pQGUuiGFCmsIMuV95V2r+Eu7g
	 BR3Mz3EaTpFApfjjzmHRMWUlSm6rnbReg9WAHOu6fatVxZcIhe2yZqcQhMY/G6NxKz
	 09xgUG+lvZxmVc4bsw8WfvFodx8ASbPIDd2I2vHeDYThNvAWw6L5hVbsA5trkPajrY
	 cKxbyt5+EweRw==
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org, Conor Dooley <conor@kernel.org>,
	=?utf-8?q?Conor_Dooley_=3Cconor+dt=40kernel=2Eorg=3E=2C_Rob_Herring_=3Cr?=@web.codeaurora.org,
	=?utf-8?q?obh=40kernel=2Eorg=3E=2C_Krzysztof_Kozlowski_=3Ckrzk+dt=40kernel?=@web.codeaurora.org,
	=?utf-8?q?=2Eorg=3E=2C_Palmer_Dabbelt_=3Cpalmer=40dabbelt=2Ecom=3E=2C_Paul_?=@web.codeaurora.org,
	=?utf-8?q?Walmsley_=3Cpjw=40kernel=2Eorg=3E=2C_Albert_Ou_=3Caou=40eecs=2Ebe?=@web.codeaurora.org,
	=?utf-8?q?rkeley=2Eedu=3E=2C_=22Rafael_J_=2E_Wysocki=22_=3Crafael=40kernel?=@web.codeaurora.org,
	=?utf-8?q?=2Eorg=3E=2C_Viresh_Kumar_=3Cviresh=2Ekumar=40linaro=2Eorg=3E=2C_?=@web.codeaurora.org,
	=?utf-8?q?Lorenzo_Pieralisi_=3Clpieralisi=40kernel=2Eorg=3E=2C_Krzysztof_Wi?=@web.codeaurora.org,
	=?utf-8?q?lczy=C5=84ski_=3Ckwilczynski=40kernel=2Eorg=3E=2C_Manivannan_Sadh?=@web.codeaurora.org,
	=?utf-8?q?asivam_=3Cmani=40kernel=2Eorg=3E=2C_Bjorn_Helgaas_=3Cbhelgaas=40g?=@web.codeaurora.org,
	=?utf-8?q?oogle=2Ecom=3E=2C_Liam_Girdwood_=3Clgirdwood=40gmail=2Ecom=3E=2C_?=@web.codeaurora.org,
	=?utf-8?q?Mark_Brown_=3Cbroonie=40kernel=2Eorg=3E=2C_Emil_Renner_Berthing_?=@web.codeaurora.org,
	=?utf-8?q?=3Cemil=2Erenner=2Eberthing=40canonical=2Ecom=3E=2C_Heinrich_Schu?=@web.codeaurora.org,
	=?utf-8?q?chardt_=3Cheinrich=2Eschuchardt=40canonical=2Ecom=3E=2C_E_Shattow?=@web.codeaurora.org,
	=?utf-8?q?_=3Ce=40freeshell=2Ede=3E=2C_Hal_Feng_=3Chal=2Efeng=40starfivetec?=@web.codeaurora.org,
	=?utf-8?q?h=2Ecom=3E?=@web.codeaurora.org
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Emil Renner Berthing <kernel@esmil.dk>,
	devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v4 0/6] Add support for StarFive VisionFive 2 Lite board
Date: Tue, 25 Nov 2025 22:24:39 +0000
Message-ID: <20251125-backfield-stuck-9791aa31b94f@spud>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251125075604.69370-1-hal.feng@starfivetech.com>
References: <20251125075604.69370-1-hal.feng@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1329; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=0VlMxwnrLqIMfMFpXWFwozvLls36noetgFAV71V4+bo=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJlqOkuKcxZoBhqaBzWnLKk5qjt1/trmj9xzrQXE1ujP2 TbxT+bkjlIWBjEuBlkxRZbE230tUuv/uOxw7nkLM4eVCWQIAxenAEwkW5aRYaHo+7IVC2Yf+Tfz a2nOg+tvq+taWUvPXbGUOFL9/f/nHzyMDFMFyjgMXd42v9qv/z+o/eupypvZvatOLz2p+nS/V+B NBQYA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

On Tue, 25 Nov 2025 15:55:58 +0800, Hal Feng wrote:
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

Applied to riscv-dt-for-next, thanks! No patch 1 of course, since that's
for PCI land.

[2/6] dt-bindings: riscv: Add StarFive JH7110S SoC and VisionFive 2 Lite board
      https://git.kernel.org/conor/c/7a1e15b248d6
[3/6] riscv: dts: starfive: jh7110-common: Move out some nodes to the board dts
      https://git.kernel.org/conor/c/84853940a733
[4/6] riscv: dts: starfive: Add common board dtsi for VisionFive 2 Lite variants
      https://git.kernel.org/conor/c/2ad6d71a0de8
[5/6] riscv: dts: starfive: Add VisionFive 2 Lite board device tree
      https://git.kernel.org/conor/c/900b32fd601b
[6/6] riscv: dts: starfive: Add VisionFive 2 Lite eMMC board device tree
      https://git.kernel.org/conor/c/ae264ae12442

Thanks,
Conor.

