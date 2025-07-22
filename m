Return-Path: <linux-pci+bounces-32732-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE812B0DAFA
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 15:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B704562E32
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 13:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668332EA171;
	Tue, 22 Jul 2025 13:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qzwu8WvU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E61F2E9EB9;
	Tue, 22 Jul 2025 13:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753191448; cv=none; b=S8GqOWupD0B674HbFQRlQyICeMiE5v9Q8S4Ls5zMfcYWW7f7i/13Aqym9xLjckSunF+TcirlSQC2/0xMHp5zgfIhYIXxSI+pN/QAvjGBWA+xNMoCS8JKBjlX3JKJl7oE81gyP5Xaa2BuyD8sGLvF18hh7mokT9Uo9A8FNn6fMOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753191448; c=relaxed/simple;
	bh=ldeVLAYqLGElj4agrBFxudHwOutEqS6Dqz8z/EKBx/Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ddfCiei7lOBC0VZUPDmH5q/8STUOzn/WDD7ryUO3J/7N5kbSAo4ZBuVorfEqwFmMDRMVM6k5Wxk5pqe6DxnGPKi+G3tHIREWsylCjNr6s0wvtIRf26is/g0HfQmaK0OIliDhkRbUdO3nArWl5a9buJhwUQv23l9hynd6FKqt02w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qzwu8WvU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D9F3C4CEEB;
	Tue, 22 Jul 2025 13:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753191447;
	bh=ldeVLAYqLGElj4agrBFxudHwOutEqS6Dqz8z/EKBx/Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Qzwu8WvUnCoSWHubicThQ9HH8uBprGz+8IW2608cpnFrZqSMz/vmnaBrYDeEftn+m
	 zwQp+Bucb+LuPRR07EKbVBE3QkO8OZM+vMfJcAp8f73uzehcmUBazjMzvr9FXoxvBw
	 s+qGYizK/NvlJti6vJ3pY6r2Z8FLLjrq1tw8NynObz1e0KoTW+XLDK4xE1VG3yULMb
	 BuaPPGeBWs5vk1E8MNleteL4U4AOHEhRXDUTkYgjo1u/8Lyb8juAP9DyiYuu2wnAH5
	 bz1SZZphEgQbQH7Htnn7IDTGZw5XXzGUvoxzLWNUQio+kmWZuySTAB0vHUo0zviVVU
	 HeiOfVIQ2qd6A==
From: Vinod Koul <vkoul@kernel.org>
To: linux-rockchip@lists.infradead.org, 
 Geraldo Nascimento <geraldogabriel@gmail.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Rick wertenbroek <rick.wertenbroek@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Valmantas Paliksa <walmis@gmail.com>, linux-phy@lists.infradead.org, 
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
In-Reply-To: <cover.1751322015.git.geraldogabriel@gmail.com>
References: <cover.1751322015.git.geraldogabriel@gmail.com>
Subject: Re: (subset) [RESEND PATCH v9 0/4] PCI: rockchip: Improve driver
 quality
Message-Id: <175319144299.114152.2563260088897607918.b4-ty@kernel.org>
Date: Tue, 22 Jul 2025 19:07:22 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Mon, 30 Jun 2025 19:24:15 -0300, Geraldo Nascimento wrote:
> During a 30-day debugging-run fighting quirky PCIe devices on RK3399
> some quality improvements began to take form and after feedback from
> community they reached more polished state.
> 
> This will ensure maximum chance of retraining to 5.0GT/s, on all four
> lanes and fix async strobe TEST_WRITE disablement. On top of this,
> standard PCIe defines are now used to reference registers from offset
> at Capabilities Register.
> 
> [...]

Applied, thanks!

[3/4] phy: rockchip-pcie: Enable all four lanes if required
      commit: c3fe7071e196e25789ecf90dbc9e8491a98884d7
[4/4] phy: rockchip-pcie: Properly disable TEST_WRITE strobe signal
      commit: 25facbabc3fc33c794ad09d73f73268c0f8cbc7d

Best regards,
-- 
~Vinod



