Return-Path: <linux-pci+bounces-42670-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 075D4CA5DE0
	for <lists+linux-pci@lfdr.de>; Fri, 05 Dec 2025 03:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 475293038CC2
	for <lists+linux-pci@lfdr.de>; Fri,  5 Dec 2025 02:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F6F26F293;
	Fri,  5 Dec 2025 01:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qDIkujp3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CA2274B39;
	Fri,  5 Dec 2025 01:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764899748; cv=none; b=l+r1ZKtoDWKBojk8/i34NwvajSepSbelzPx3gvycWjszJYI47QnTUgx6QBSrqSaMvS5BDWVvQpOCwwpX8CqntS19mLID4Exbu6X79SAamjI/4ev8dfr8ZZR06mL376Un0mbgC0bscR0xc7b5iiT7O8ZLEC+jSEI05QtGkK3LRPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764899748; c=relaxed/simple;
	bh=MLIwjno5IIk/ozytLF67M6wTsoYfvD3YI8qWzCNUCCc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=JDurqH7YlGnaSsWzd16yor/N3A9YAOmOXVEhLAoO663ezXm0IpOlJqW16LfExSvro7/ODmay9ZujsRCiqg61AQNsaozHBncwtlbS90OTAT9JzV9mdeSb5HpWerQA/3MZ5v18raiw5x5kt14k3DNUwf0TaQmhPgiSfgSgYdN+16w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qDIkujp3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02039C4CEFB;
	Fri,  5 Dec 2025 01:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764899748;
	bh=MLIwjno5IIk/ozytLF67M6wTsoYfvD3YI8qWzCNUCCc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qDIkujp3/f9324PqqhkZ62rsz032AQSCkVVT0F3VO2px8WXl5Ps9D8gOg2tbmRUME
	 6i1A1hvaAL/nUKyJ1LsKBQceivmGHNcLSJeRqcW7swPMDuvWnxdz9Sr/FqmceFzsOC
	 P0ea6I17neGfQqeExpINkkmvtO08Z4A2kU0l8L7XJLNGESHrncbb/q5pahb4nbzrVu
	 ZmV2WcamsklBoR0iPQtVpIVBIj8LMCPzgD/3xN/OAezNZc5HsGt3kwPwxBdx4QkI9h
	 /NJ6yaBlweuJl49iGIiNx5U4hva+oWgXReIXUDbyxyszppu9SXDfS60T9AU4dyVNf3
	 L4Pk3fiUHEwpw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3C3213AA9A85;
	Fri,  5 Dec 2025 01:52:47 +0000 (UTC)
Subject: Re: [GIT PULL] PCI changes for v6.19
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251203221103.GA3193083@bhelgaas>
References: <20251203221103.GA3193083@bhelgaas>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251203221103.GA3193083@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.19-changes
X-PR-Tracked-Commit-Id: cd6b7c82b69139070ee1aaa73f768ecac99e4c3e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 43dfc13ca972988e620a6edb72956981b75ab6b0
Message-Id: <176489956591.1057018.10232881767785671801.pr-tracker-bot@kernel.org>
Date: Fri, 05 Dec 2025 01:52:45 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Manivannan Sadhasivam <mani@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 3 Dec 2025 16:11:03 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.19-changes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/43dfc13ca972988e620a6edb72956981b75ab6b0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

