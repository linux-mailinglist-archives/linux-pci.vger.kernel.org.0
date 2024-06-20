Return-Path: <linux-pci+bounces-9020-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4520991085F
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2024 16:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D112AB23D8B
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2024 14:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED3B1AF683;
	Thu, 20 Jun 2024 14:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K5MlKvy8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6CE1AED20;
	Thu, 20 Jun 2024 14:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718893851; cv=none; b=H+6Fk3qkOb4pZQfe36kK87/fGF/sq7Y6DhJoQebZPMBIwjquEJRnt8t4H6Jt+4fkXrtdLO2YiiPYhYlwjoUP8pXWR8S2sihmO/QTY7N3L0JwdPt3OESSc/AIeDBcPS4xpnuWi3XpaZskA4tKdg0peAeO7aqNEbVuz3fiP6pxoXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718893851; c=relaxed/simple;
	bh=MCEdSf7+2gNB9bRow0LmNrkJ5TryvBvJFSq8fOZe7Rg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cyto9yB/74kHVOGoRXPRM/f/9VBIIEOmttBEDRrT8qQMBvzx+jc+p0TUlZfk7WjEZ3nV3NvR4uG9G7eHgAogYa7CiLpa4GWroshzcl7YceAA6hetUytMrBlpO4284yTvtwqm9laLD3D/StBrTyjTmir1vezlJ75EOTrSblrCKcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K5MlKvy8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 754EDC4AF08;
	Thu, 20 Jun 2024 14:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718893850;
	bh=MCEdSf7+2gNB9bRow0LmNrkJ5TryvBvJFSq8fOZe7Rg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=K5MlKvy87w2ZwcwG/Mb+ggZHPQRRRAsjnPfz5F/9Rw3ACzo50kWz4W/1sPKRsx2OD
	 45eJ8PJhfT9C1aSYG2oOOgEz+4pmU2qtcoDQQGDJjKM0vkdc2yPDvx7BKGEKYgUVfJ
	 FbJJ3SHC715N7y2gwH8X8Iarb/5jC5/Ag2YNJNCp9yR768tH/pzNSKCVNFyqQ+EmGk
	 Qe94ZYQ3qZ7SE+cBm4X+6bEGLap4rWytkSdmouOPCDSoDglqpewIDO836XoaVi9yvu
	 NEAxY8FQhqm3R7R7kvd87h48C07OD9j7BGxz2P5qUju6kcFwPuPmw9/B2XOOiweZox
	 aoPYuE7BiyA6g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5B2D8E7C4C6;
	Thu, 20 Jun 2024 14:30:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v9 0/2] pwrseq: introduce the subsystem and first driver
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171889385036.4585.6482250630135606154.git-patchwork-notify@kernel.org>
Date: Thu, 20 Jun 2024 14:30:50 +0000
References: <20240605123850.24857-1-brgl@bgdev.pl>
In-Reply-To: <20240605123850.24857-1-brgl@bgdev.pl>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, kvalo@kernel.org,
 andersson@kernel.org, konrad.dybcio@linaro.org, lgirdwood@gmail.com,
 broonie@kernel.org, catalin.marinas@arm.com, will@kernel.org,
 bhelgaas@google.com, saravanak@google.com, geert+renesas@glider.be,
 arnd@arndb.de, neil.armstrong@linaro.org, m.szyprowski@samsung.com,
 elder@linaro.org, srinivas.kandagatla@linaro.org, gregkh@linuxfoundation.org,
 abel.vesa@linaro.org, mani@kernel.org, lukas@wunner.de,
 dmitry.baryshkov@linaro.org, amit.pundir@linaro.org, wuxilin123@gmail.com,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-pm@vger.kernel.org, bartosz.golaszewski@linaro.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Bartosz Golaszewski <bartosz.golaszewski@linaro.org>:

On Wed,  5 Jun 2024 14:38:48 +0200 you wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Hi!
> 
> These are the power sequencing patches sent separately after some
> improvements suggested by Bjorn Helgaas. I intend to pick them up into a
> new branch and maintain the subsystem from now on. I then plan to
> provide an immutable tag to the Bluetooth and PCI subsystems so that the
> rest of the C changes can be applied. This new branch will then be
> directly sent to Linus Torvalds for the next merge window.
> 
> [...]

Here is the summary with links:
  - [v9,1/2] power: sequencing: implement the pwrseq core
    https://git.kernel.org/bluetooth/bluetooth-next/c/249ebf3f65f8
  - [v9,2/2] power: pwrseq: add a driver for the PMU module on the QCom WCN chipsets
    https://git.kernel.org/bluetooth/bluetooth-next/c/2f1630f437df

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



