Return-Path: <linux-pci+bounces-11343-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45173948663
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 01:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7275E1C2233D
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 23:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD7916F260;
	Mon,  5 Aug 2024 23:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dXz7yv/I"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657B014B06C;
	Mon,  5 Aug 2024 23:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722902057; cv=none; b=ehtajq2rQae7JzWlDDpupY2YYDDcT2D6VU9d6dlw+V2pJNa+VRh7mPbGVn8Wx0xAAUdKIWsF3IRSpEjDOh/0Uc7G7avd1vLAQ3c9CDbQahu+jvi21e9gosMHDOT59mjdMXtIlocwatZnDkumJCA1tt2t7RvBuQZfTB1JaIqY+vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722902057; c=relaxed/simple;
	bh=aDDyWum/RdGNYK5afYA6i1DTP/tBbriSvjj5iiczVac=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SeGOt6X+5SoJPzNtigp+TxQmFJJelfDbXNT0A6q7su1YnjE2L4NqvOkd2UK46iIJ/BicIWSw0kzlADZC7KDKHgYLK1rBMM/B4XX7rPUjCiSwYda1l8WeQLvRV488xzBmiAys1AH6Hnz+TfFo93ZmMUEW9wMfhhUuq2C4IVa8cII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dXz7yv/I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 44328C4AF0B;
	Mon,  5 Aug 2024 23:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722902057;
	bh=aDDyWum/RdGNYK5afYA6i1DTP/tBbriSvjj5iiczVac=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dXz7yv/Io6QrVNxsM0JL4QpoGMNo2sYX6Es1CEPOBPJfG9Jjsa0UJqAtYWWBqQeCj
	 9vkplca+B5zlNDJgHYVb5/3BwwbM0Jl7uAqqPSRn+Ls1DcQ6gyQXYqkfozA39Fn/c5
	 mWNlO3zmVf0zLKvKVOTRcc9XRmTz7FF2b3M8ifFOI6jkk88BhA74QA8je2Fs0KueFI
	 zwbEPDBqW/9wklB6NDa0L1RatukjuvnUqDLJAQTTE3bfNW4gtYCi1epPmenE0lglPU
	 98bmtchjhMs4wmQ6JIMRUaOxiuwFBFNWtiYLhI3yhZv5DbaVUfC3YyeqYHf8T6267G
	 tYNy5iaUBjuDw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 343A6C433E9;
	Mon,  5 Aug 2024 23:54:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next V3 0/3] mlx5 PTM cross timestamping support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172290205721.12421.3111275453782018152.git-patchwork-notify@kernel.org>
Date: Mon, 05 Aug 2024 23:54:17 +0000
References: <20240730134055.1835261-1-tariqt@nvidia.com>
In-Reply-To: <20240730134055.1835261-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, saeedm@nvidia.com,
 gal@nvidia.com, leonro@nvidia.com, jstultz@google.com, tglx@linutronix.de,
 anna-maria@linutronix.de, frederic@kernel.org, linux-kernel@vger.kernel.org,
 bhelgaas@google.com, linux-pci@vger.kernel.org, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 cjubran@nvidia.com, bshapira@nvidia.com, rrameshbabu@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 30 Jul 2024 16:40:51 +0300 you wrote:
> Hi,
> 
> This is V3. You can find V2 as part of a larger series here:
> https://lore.kernel.org/netdev/d1dba3e1-2ecc-4fdf-a23b-7696c4bccf45@gmail.com/T/
> 
> This patchset by Rahul and Carolina adds PTM (Precision Time Measurement)
> support to the mlx5 driver.
> 
> [...]

Here is the summary with links:
  - [net-next,V3,1/3] net/mlx5: Add support for MTPTM and MTCTR registers
    https://git.kernel.org/netdev/net-next/c/7e45c1e9edc0
  - [net-next,V3,2/3] net/mlx5: Add support for enabling PTM PCI capability
    https://git.kernel.org/netdev/net-next/c/bec6d85d43eb
  - [net-next,V3,3/3] net/mlx5: Implement PTM cross timestamping support
    https://git.kernel.org/netdev/net-next/c/d17125fb0923

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



