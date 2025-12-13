Return-Path: <linux-pci+bounces-43021-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAEACBA4A2
	for <lists+linux-pci@lfdr.de>; Sat, 13 Dec 2025 05:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C02B330419B5
	for <lists+linux-pci@lfdr.de>; Sat, 13 Dec 2025 04:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229AE274B32;
	Sat, 13 Dec 2025 04:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMaNcSVX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9976238C1B;
	Sat, 13 Dec 2025 04:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765601113; cv=none; b=LL0iqZRBOPVuk6bKLP008YyGDpPxp8uzRlkLWx0+X4OF/G18zmCJUVs5JmC8I6anqcqT4LggfEA4w4O+Auiqsh/UFWddeHsKNASqCyC5wvdVSCkElpsb3rC+/1neInkQzKGu2DVIIrDt/DdxYzehPMStSpVjcj3bu9fJWHfyZNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765601113; c=relaxed/simple;
	bh=cAKKGVPOVigCRFANSYMcbuZFE5WUAMKLvaduFeKAG80=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=pO2Uwc4V609u31bG/aCbYTSm4jKovcJBj7Ux7msaCBvzxJ3pwE8eE5EcZKITM61P1KCvTmbEaTTfXZQ53dX0bppbWvLewWqIodPkdwmjaqP/5ijanfZPrsA7GPYTST8JzUsEsNSDrFyqJrCejpq/RZQn/v+cNTxH+iUsQGeO2Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMaNcSVX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65E61C116B1;
	Sat, 13 Dec 2025 04:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765601112;
	bh=cAKKGVPOVigCRFANSYMcbuZFE5WUAMKLvaduFeKAG80=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=hMaNcSVXe0U9dP+fwtGQ/YMO1XtdR22ofaKBssLe9k4xc3xvBx+SlWtvbvsqbEnp1
	 DEURg9RcfqWAkmrk2xnN0Q2W2OOGhhgqdtg3BkIVOTvkxm2JNnJGdvxRXHJhQzY6OF
	 PmX11QsaHtUAlpfI+0PQ6XRFvq+J/XIJR51L+9VWE2T470Hy9o3czSsphZh8YDV2YB
	 a1WZdPXlguCbywdisRcQzKrdT4XrgcNMMxV51tkzpaKKsOvABlMd6SOPOfM7ok+K1U
	 7BJmdr5q12mNV9dmcABoprYNCoLz2rJYuej2LFCXuJTHcSdDI7rAZTViun/ht2HVMM
	 XQKgc+kQn/FUA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7DCE7380A956;
	Sat, 13 Dec 2025 04:42:06 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v6.19
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251211184938.GA3604438@bhelgaas>
References: <20251211184938.GA3604438@bhelgaas>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251211184938.GA3604438@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.19-fixes-1
X-PR-Tracked-Commit-Id: 94bf74830a977a027042f685c7231c5e07cc3372
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 41572e2c05e5892ecdb18e47fd47f208ea648ec6
Message-Id: <176560092533.2403506.1812453142521571841.pr-tracker-bot@kernel.org>
Date: Sat, 13 Dec 2025 04:42:05 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, linux-renesas-soc@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 11 Dec 2025 12:49:38 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.19-fixes-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/41572e2c05e5892ecdb18e47fd47f208ea648ec6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

