Return-Path: <linux-pci+bounces-19940-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F88BA1318F
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 03:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45D93164008
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 02:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A7E78F40;
	Thu, 16 Jan 2025 02:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VcGWGV/n"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79ABE555;
	Thu, 16 Jan 2025 02:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736995859; cv=none; b=oFt579jMBy3/xLcPsvqaIimeUKoEmv3XZP6VgYFC6GJuT51Xuc62VVjUc+45VNGLZgXYGAJ8BznnM1sqpht0x+FwCjPOIIaVw60Fr1uvJJ5ouUHcR5ccHA6dLliqxM0HKFfpD54bhfvjE2yW0aPuieATYEQ1eEV9hzn8oDIHm0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736995859; c=relaxed/simple;
	bh=+ZYNwZATOq0t2LdGXDouWYN7G+SKSyQoiBOOSmTuqyA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DCvA3da8HQCVMv7ptXMzVcoU3BnfkerDp15Mje5RNW/1HxhHWxsXZ/0sgw/nN1uUkEDPZ1tx0EbmuAFhiEY09zzEpX7U4fJZ47BwqL7IIgrf0uqoMWURWP8teHgeyLtDOrhumuVW88CZeIdLsOSgVjN7FCsc2MgpLPQUL4lHEIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VcGWGV/n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36EFFC4CED1;
	Thu, 16 Jan 2025 02:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736995859;
	bh=+ZYNwZATOq0t2LdGXDouWYN7G+SKSyQoiBOOSmTuqyA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VcGWGV/nnfVGLM4fXGW5RSC/Xei+1ResxNcw3ICxmalD15Skcrz6hFpF4iJ97/asV
	 fD3GEBmm5G6tw0DStQQEtaUi1hprYUF8WjLzzQtN+Hs4tVlq4cbvKPlEwYNP/PW9sO
	 3ZlAMcNZrpX2p47LRcsqAGG+vHFfgHloDgjsSNH+17/Bx69su/JE59/U+OUsan7Jun
	 EmXc9ekXUp6xxsR2sIY6fQtoOGLwNz/2ewU+LIowhYuBLzDQCFY241LrwcPmEKE9Nl
	 3OEPo0h6xeqtMSnEnOA9/GEPsP6eK+npDHooDglX0bO4oVxployOg1NYctRcmL4nhJ
	 amInC/r1aaanA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 712EE380AA5F;
	Thu, 16 Jan 2025 02:51:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] net: wwan: iosm: Fix hibernation by re-binding the driver
 around it
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173699588213.987898.18343161167546299162.git-patchwork-notify@kernel.org>
Date: Thu, 16 Jan 2025 02:51:22 +0000
References: <e60287ebdb0ab54c4075071b72568a40a75d0205.1736372610.git.mail@maciej.szmigiero.name>
In-Reply-To: <e60287ebdb0ab54c4075071b72568a40a75d0205.1736372610.git.mail@maciej.szmigiero.name>
To: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Cc: m.chetan.kumar@intel.com, loic.poulain@linaro.org, ryazanov.s.a@gmail.com,
 johannes@sipsolutions.net, bhelgaas@google.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 rafael@kernel.org, netdev@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  9 Jan 2025 00:33:50 +0100 you wrote:
> Currently, the driver is seriously broken with respect to the
> hibernation (S4): after image restore the device is back into
> IPC_MEM_EXEC_STAGE_BOOT (which AFAIK means bootloader stage) and needs
> full re-launch of the rest of its firmware, but the driver restore
> handler treats the device as merely sleeping and just sends it a
> wake-up command.
> 
> [...]

Here is the summary with links:
  - [v3] net: wwan: iosm: Fix hibernation by re-binding the driver around it
    https://git.kernel.org/netdev/net-next/c/0b6f6593aa8c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



