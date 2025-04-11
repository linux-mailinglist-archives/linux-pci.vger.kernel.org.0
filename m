Return-Path: <linux-pci+bounces-25698-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1092FA8696F
	for <lists+linux-pci@lfdr.de>; Sat, 12 Apr 2025 01:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA2F017D8B7
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 23:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0822BF3DC;
	Fri, 11 Apr 2025 23:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRm19ZsW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E942BEC59;
	Fri, 11 Apr 2025 23:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744415078; cv=none; b=qjaWOA9zXaI4iVQLvtavci80EL9kxe6/h4/TMWsg3RwnAjdX5SpvsnjCitiKU5/edry05djTg3NO27s6se3SYXfmEwBGuhEYvuRrfrOKCLVAUbu+ODcIdfi7s0l6AK5eb14D7DtQdXkqdneWvKOMDhw0Q3bQNZOrBJpy+VD488U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744415078; c=relaxed/simple;
	bh=kgmk8DdWuXbolPl8ba6kiBrUPA2ZboQvnjwpxTh95M4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Nfho2/xvpIoe2V8V+SBK872ZP/WidyUdpG31q8x9aEQ5CyKA9F/CWV4C4yzmXx4j0FffbxCeF5qpaggdBE93LStmmzOMzuQ+Bd1gu0wlW//UXOfiPxDW+A0+drdnO2N9e75or4d0nChm3SdaLFTg3vA4u1K2N/5WWbRUJIEyTYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRm19ZsW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E147C4CEE2;
	Fri, 11 Apr 2025 23:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744415078;
	bh=kgmk8DdWuXbolPl8ba6kiBrUPA2ZboQvnjwpxTh95M4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MRm19ZsWFYpPMLD0pbhL9pjmcTjLWOOcm7p4rux0d44ZWFIkofTGwrZkoBLzxfkIB
	 GycbzCZulefFLrUEI1Wx9xoMiktMcJIgkuK2/+vLX91zetMsX88u2bWOY2oDxtqkjF
	 fIteVeq9DtyFc5071rBu6itw6pVPQkDz8kmE92Zbhykv2CngYq4af4M7AnTZq+fO/o
	 0RiNqs/875qfJrv6HULJp3o5i76VeF9D+3TuN8392ZPS5IrzRsSDHaaIX6YulOkQoo
	 nyVkHf8QtRLS/y9YuvblxzuckeIO4lBjbyLT0zqc7ynlSDfXrR5273Z+t8qGt+Qk4b
	 8oAo9CfFxW4Sg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 11D1538111E2;
	Fri, 11 Apr 2025 23:45:17 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v6.15
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250411181650.GA372618@bhelgaas>
References: <20250411181650.GA372618@bhelgaas>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250411181650.GA372618@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.15-fixes-1
X-PR-Tracked-Commit-Id: c8ba3f8aff672a5ea36e895f0f8f657271d855d7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5d74992343b969cd8e2d0a3d00cd152eeedcf57c
Message-Id: <174441511575.520992.167665194129849145.pr-tracker-bot@kernel.org>
Date: Fri, 11 Apr 2025 23:45:15 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Zhangfei Gao <zhangfei.gao@linaro.org>, Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 11 Apr 2025 13:16:50 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.15-fixes-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5d74992343b969cd8e2d0a3d00cd152eeedcf57c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

