Return-Path: <linux-pci+bounces-17497-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C9B9DF46F
	for <lists+linux-pci@lfdr.de>; Sun,  1 Dec 2024 03:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1849BB2147A
	for <lists+linux-pci@lfdr.de>; Sun,  1 Dec 2024 02:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4401235885;
	Sun,  1 Dec 2024 02:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="raWFPlM8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3672D05E;
	Sun,  1 Dec 2024 02:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733020897; cv=none; b=nbMjWX1FMyY+GItpEAg0IWP0+PsIvi73q8kQ5s1rRcJT4AANdele+uJXGTDwRNmhmuhT3iMGTRAyREZIk45Ttp3U7SQh3bYH/03eGJ2h7F6+spg3+ilcVKH77gkPo80QJx7w8GjmFJefB3ml8rj3STLYgIUObX4JFOALglZcXlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733020897; c=relaxed/simple;
	bh=0RHmullKYWWr6h/Aocqv6GyuPa/KJ7v/zPcWYH0u9UY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=UWyJWEIvave7iou/Idxj5BbNGR0VbBER2Fdtpi9dfcY1K4gsKx2GtPhhP78QJxF1h3xALxAraEpkupF7mFwwwM2CqcQbK5qVNbXAgf91hNtvjRnk4K2frkc/11MuAJuINqJ3iz/+7Dny3uEsrWXLraGW+Liq915zpoQUxlBq+p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=raWFPlM8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8BDDC4CECC;
	Sun,  1 Dec 2024 02:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733020897;
	bh=0RHmullKYWWr6h/Aocqv6GyuPa/KJ7v/zPcWYH0u9UY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=raWFPlM83mbM6CaAKnA4KGXJPziAJANVIH4xl+VO/HCF26qJftX0J04gjrTA4fG5c
	 knMbuiGNmoxQ45Y8zu/weYUyWn7sZ3LfEWo8VYtC0xUEdWJpCGX92rN4a786rFW6kl
	 lAEfrsiazz6r5lp/aa6S/MZhfFaAgWg85+eHAQto7264/Oaq3Y0f1Lg3g2GojFdScy
	 3vSMG+PXTncWawa3dOJ1QPa1r8uXwsnRCiVo7QAIYCI8iij9jeKHQjvbSfaCJUeDVf
	 KDsjU1PWfgkFIgv48W9o+g4wvQOvjv8zuZBjqZmU79Uiz7+qr/hWT5kOkRvcYTWbSo
	 pHP/7QHHYxRLg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE60380A944;
	Sun,  1 Dec 2024 02:41:51 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241201001444.GA2843588@bhelgaas>
References: <20241201001444.GA2843588@bhelgaas>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241201001444.GA2843588@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.13-fixes-1
X-PR-Tracked-Commit-Id: 5c8418cf4025388bedd4d65ada993f7d3786cc3a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0cb71708c5816569f8addd5c6f33cb9679e73b5b
Message-Id: <173302091055.2541785.4359795961642404522.pr-tracker-bot@kernel.org>
Date: Sun, 01 Dec 2024 02:41:50 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Brian Norris <briannorris@chromium.org>, Saurabh Sengar <ssengar@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 30 Nov 2024 18:14:44 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.13-fixes-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0cb71708c5816569f8addd5c6f33cb9679e73b5b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

