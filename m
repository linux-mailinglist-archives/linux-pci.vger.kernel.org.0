Return-Path: <linux-pci+bounces-7763-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B638CC9A1
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2024 01:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94CD51C21B7F
	for <lists+linux-pci@lfdr.de>; Wed, 22 May 2024 23:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9C714C58C;
	Wed, 22 May 2024 23:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMFLPMK/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17C47D3E6;
	Wed, 22 May 2024 23:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716420743; cv=none; b=os7zvh+B21puGfAPBQNjlWh+jAkirutsbxOf6MHFhrE9q31IdWqTlak6NJlYRx7a0o1UDeWi9LLi2fLiHHTndkRB71mjgqtlW2d+UPCqtjmAqDPNZZ4g0j23a5AqV/8cMxF8PHD4vH9vaFFIC8/CE+kezT4kPWwnvh0SFuA3sGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716420743; c=relaxed/simple;
	bh=tEHrjijHfI1dW0qehjRUeQTBRs2hxXM4LHxZP9ugrHc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LLn3zWCk+fmhfWWJe196RfWi4/Fi9ews2tqcRuWCpKiINh4Np1oSOvK6ewDq5G+pA+zAok5Hyk6oD9eu6VFg9HpJjK+mAP48ddAV3JPw1JoYGkNrcI7UyJUO2szT52X4y4Gs7PYy/tlfCJKslq4J8Fg9m9CwkMHAsQmH9lVrLeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMFLPMK/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A0791C4AF0D;
	Wed, 22 May 2024 23:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716420743;
	bh=tEHrjijHfI1dW0qehjRUeQTBRs2hxXM4LHxZP9ugrHc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bMFLPMK/srok+FyjdHtbHkP+ZgL5XHdr2nMDlz3R/AiQk7J6GWWuCYpHf6Hc4QEGj
	 YNcTJfbYyYqyQ/EOjlGQ1OMPsBJbP24gN7+b5fQQ/ips+o4jGvIAuhfLhP0bq0ZnRK
	 aXdQzA+eTgDk/wDII14GbvuaUNUCDV+HRTY9EE9DoygEw7sZAFKeBWAa5eixwP+5R+
	 9VPI/VbwsXbg4rvK2YNLfNWmwwbukxfZzhhVp6Iwe42YwN4L48ri9oMXnAXM74UT2K
	 Vu5P2+0QxQDzzp9AZzwBuTI9w24o/w9wSD4DshN1zkLczfdE4YXrco0sduX6a+/S7+
	 hHEXqgLYa4siA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8DAFAC4361C;
	Wed, 22 May 2024 23:32:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 0/5] BeagleV Fire support
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171642074357.9409.6131755278467232949.git-patchwork-notify@kernel.org>
Date: Wed, 22 May 2024 23:32:23 +0000
References: <20240327-parkway-dodgy-f0fe1fa20892@spud>
In-Reply-To: <20240327-parkway-dodgy-f0fe1fa20892@spud>
To: Conor Dooley <conor@kernel.org>
Cc: linux-riscv@lists.infradead.org, conor.dooley@microchip.com,
 daire.mcnamara@microchip.com, jamie.gibbons@microchip.com,
 valentina.fernandezalanis@microchip.com, linus.walleij@linaro.org,
 brgl@bgdev.pl, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Rob Herring (Arm) <robh@kernel.org>:

On Wed, 27 Mar 2024 12:24:35 +0000 you wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Yo,
> 
> Wee series adding support for the BeagleV Fire. I've had a dts sitting
> locally for this for over a year for testing Auto Update and I meant to
> submit something to mainline once the board got announced publicly, but
> only got around to that now.
> 
> [...]

Here is the summary with links:
  - [v1,1/5] dt-bindings: riscv: microchip: document beaglev-fire
    (no matching commit)
  - [v1,2/5] dt-bindings: gpio: mpfs: add coreGPIO support
    https://git.kernel.org/riscv/c/6e12a52c1459
  - [v1,3/5] dt-bindings: gpio: mpfs: allow gpio-line-names
    https://git.kernel.org/riscv/c/f752a52d34cb
  - [v1,4/5] dt-bindings: PCI: microchip: increase number of items in ranges property
    https://git.kernel.org/riscv/c/649bad67d4b1
  - [v1,5/5] riscv: dts: microchip: add an initial devicetree for the BeagleV Fire
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



