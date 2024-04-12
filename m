Return-Path: <linux-pci+bounces-6196-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFC18A36E9
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 22:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B97841F215BB
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 20:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063841514E0;
	Fri, 12 Apr 2024 20:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvkIAF3P"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11AF1514CC;
	Fri, 12 Apr 2024 20:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712953050; cv=none; b=XRmOS4zNka3Yy+BC0EMckQPwcLJuwXWTFXm8mIZcYx6Uciq5tZMDm4CJX7msNqtVVzSwBz/MFciYxLIhO9y9vGIVKKbeP6hqlELBeFPsFYbvwIr4BYA6kUhWjTg7cPdoGk/+Qaz/mciQyo/Y92GbHmT1xh312M4fZy1Ipy/33hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712953050; c=relaxed/simple;
	bh=s0xhJALo5oKhqr4auQHUxOc2tVL+cq3f2UXyRLK0tak=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=lKxvE95O5ZTpeQhVnsnlGXidFjvuVwt7t+WB8vyUoREetODWz7z0gUTsLHE3h9GglpG8FeDeoJ3PZpjNnHSGzwqCc1wVr1dsAPN6d4O2wm2rmTodpfQmESAS4gUD2PssCNXGoItMB0vpWFPfPULjBkKl9s1svm/C8b96Bmdloag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TvkIAF3P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A928AC4AF08;
	Fri, 12 Apr 2024 20:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712953050;
	bh=s0xhJALo5oKhqr4auQHUxOc2tVL+cq3f2UXyRLK0tak=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=TvkIAF3P827M08/mT1RCjR7jAwRZ7XmsHs+KV4//Etz3mJVpBAtSBveaJvmLzDlrB
	 tyESKvAxh8MVrJdKLznTp0N06kNAIbgf/ZTU1nfTDH/ItG0vCMfOON/Hc2it9hNWLM
	 qzHeiDx9MVZrJBcrDEjDUowlcPDGltmEIIpjZDWzjg0cQOtIUdrwUQjgo2pECt0PtW
	 00csDQuO3FtcD9BF4zTMZdDnUtX9BgCQKJfAWAi0/ykqrEmMCSPiPxyB4KejqsSh5C
	 4jTJp9IPacQyJlBzET/oEag0GjG4jkBfq5uhjgFse/QC6lZO+stQLRplcIn31EkVap
	 xl4ZD291VHk2A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9EF7CDF7856;
	Fri, 12 Apr 2024 20:17:30 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240412165945.GA6532@bhelgaas>
References: <20240412165945.GA6532@bhelgaas>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240412165945.GA6532@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.9-fixes-1
X-PR-Tracked-Commit-Id: 302b84e84d108b878efc56ebfea09474159be56b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b3812ff0cd3a61e8070acb09079a0eb52d2f8e0b
Message-Id: <171295305064.15771.17520696509034074081.pr-tracker-bot@kernel.org>
Date: Fri, 12 Apr 2024 20:17:30 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Edmund Raile <edmund.raile@proton.me>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 12 Apr 2024 11:59:45 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.9-fixes-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b3812ff0cd3a61e8070acb09079a0eb52d2f8e0b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

