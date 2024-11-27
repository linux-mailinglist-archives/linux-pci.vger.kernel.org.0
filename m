Return-Path: <linux-pci+bounces-17382-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0B69DA0AF
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 03:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2BAEB24B50
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 02:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469F740BF2;
	Wed, 27 Nov 2024 02:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mtjzkj6c"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8894086A;
	Wed, 27 Nov 2024 02:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732675220; cv=none; b=d0v0Hhtx9XRLzkaunm1gHBgtWu4TTpSiTroC7AkIZ6ypEvsKwi0KnwvMtd2g9ZVU3gbD/4CoDMESvKyb0TOj2Y5JLCg+U+Wz6hG7vaAizbF14ADH24Epd1+EwyBCZKoTNaXo2ruD3RydbITQqTwjX29ByNvCKEPByzjL+zufuLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732675220; c=relaxed/simple;
	bh=S6z3h9uQINYnhHr64W7hGtUAZQoECIxJIrI5ZDykv3g=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=rtlZl720LFmUtWZ9xcrbVEAeaIibUoD3W03DUK5EDSVJRyMoayYgjqrloNgVLXLr2Cx32Zzfe/gOxID5naNXJAhTxbb2hxWYqDup8lfXI24wceTTUNk5LgxeG9V85GF92BT+Hm5RaK3BTmoxvo8Arqi0igPJSueVJU1hXiNAHKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mtjzkj6c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBFDEC4CED0;
	Wed, 27 Nov 2024 02:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732675220;
	bh=S6z3h9uQINYnhHr64W7hGtUAZQoECIxJIrI5ZDykv3g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Mtjzkj6c7x1Rj/MJ4uplFfRCwt/70+MLQ7qaKrXj/ojmkAU5e6Jr+W+M9cV46bUXb
	 L1fnjBaL+ojxJg3t9pOtQ9OdfOL4RzmmIn2Gwnf3Mo8sWygj94z5uJ855K7/zUju4o
	 0VonWs4eiUa9RMAAPmA7Rx31XJN/5UlNaVA0CYEOYdjr/4lOYZmDKJ16GqRWQ6ChON
	 BBV+Tq396PoDsXtD//X6nju1kLqY+Fpfukg5SbHx2s6hysmEzeEdq54TE8o0D1jEye
	 k2m1435J74rmvMcK/73mUdfRQNohTxD/TuotaHru+ehMZDMy8X+11ryz7uC+bIxLGI
	 xQQLTRlBLzA2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0FC013809A01;
	Wed, 27 Nov 2024 02:40:34 +0000 (UTC)
Subject: Re: [GIT PULL] PCI changes for v6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241125201915.GA2609291@bhelgaas>
References: <20241125201915.GA2609291@bhelgaas>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241125201915.GA2609291@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.13-changes
X-PR-Tracked-Commit-Id: 10099266dec8275a6899e6a27dcdfebbcc726cc7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1746db26f85e4f4b3dd11d7b55f4eff4b0423884
Message-Id: <173267523282.617991.7017339592083508284.pr-tracker-bot@kernel.org>
Date: Wed, 27 Nov 2024 02:40:32 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 25 Nov 2024 14:19:15 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.13-changes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1746db26f85e4f4b3dd11d7b55f4eff4b0423884

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

