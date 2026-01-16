Return-Path: <linux-pci+bounces-45080-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 01EA1D38A5F
	for <lists+linux-pci@lfdr.de>; Sat, 17 Jan 2026 00:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B6C353042914
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 23:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7D8274FE3;
	Fri, 16 Jan 2026 23:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cgQULsxr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC99E2E7180;
	Fri, 16 Jan 2026 23:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768607179; cv=none; b=igdw2LnXiH5qBaxar+RKCfjCyTGBL1yTwLAx4yW0sdhuviuY+HKscLF0J4uWvOMSV3XGQBKUWXDNo+KE+H+ENpz0Rbl5Z9t/1rwWenqvnkifNxli2df404vu27RFEj7bsaDZBjexBXjWYwP9Jn7x525VykDAEVAwCNKxxNqOdfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768607179; c=relaxed/simple;
	bh=psiWVThnyT+vX840qtn5vQTL5NzsgDrHbIjh+0C1qgU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=csW/JGXPn1f/AvUsHVPBzWKKncBt1I2e3HoVBjTgTqkPGGUqb15eMr8yTwUfG9YzdZdgacHBxhoTM6ye/EzGC9jVnF0GSNXpc6a1y4opky3hg3nYk9HnUYxqZNTa3XlkLQcb96AgRi+rUWL4V2vH9QLr5UXwQDBUJXv94S1wgxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cgQULsxr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A03A9C116C6;
	Fri, 16 Jan 2026 23:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768607179;
	bh=psiWVThnyT+vX840qtn5vQTL5NzsgDrHbIjh+0C1qgU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=cgQULsxrDST54+m6ib/0gj0oycQ1h58YXOg5Cv1bRx/asuR/Ldxo569l0Hb9ney4v
	 E4tDGd6xqIQyhemMdRmtXilQiuBVAbmv3S/KbmpyekAK7FLmZaeLcqSxrZ6gei3llz
	 x9F65jokWyEa8KoOHNgwVYzTivEHxmCTgfLTWrm+bK8D9VWPJjlzgfFblgRvloOv0M
	 3T0ed+uPp9Km//KfUrMneSkMkuGgkBOOh8urjbp7lPTCzNcO8qXVy5UVwWcY3GV7Ng
	 joBdzJpt2/Z44vav0FVSHh7sPrZA4NjChrgbMnzj+UOSQxjqeU+eHTcv+G0dBrU4Re
	 5TYaCOUYlPBFQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3BC0D380CECB;
	Fri, 16 Jan 2026 23:42:52 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v6.19
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260116165435.GA928390@bhelgaas>
References: <20260116165435.GA928390@bhelgaas>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260116165435.GA928390@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.19-fixes-3
X-PR-Tracked-Commit-Id: 05f66cf5e7a5fc7c7227541f8a4a476037999916
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d81585830017a896a1d6cfc1c626d7faaf9dfa55
Message-Id: <176860697075.838122.10487468763814483650.pr-tracker-bot@kernel.org>
Date: Fri, 16 Jan 2026 23:42:50 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, Liang Jie <liangjie@lixiang.com>, Drew Fustini <fustini@kernel.org>, David Gow <davidgow@google.com>, Joel Fernandes <joelagnelf@nvidia.com>, Danilo Krummrich <dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 16 Jan 2026 10:54:35 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.19-fixes-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d81585830017a896a1d6cfc1c626d7faaf9dfa55

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

