Return-Path: <linux-pci+bounces-33657-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 166D8B1F261
	for <lists+linux-pci@lfdr.de>; Sat,  9 Aug 2025 07:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B9071AA2757
	for <lists+linux-pci@lfdr.de>; Sat,  9 Aug 2025 05:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEA227A935;
	Sat,  9 Aug 2025 05:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n484+ipx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FDC27A92F;
	Sat,  9 Aug 2025 05:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754718334; cv=none; b=RGiGetPtz+81jUNvlIEoMmg7pSGoXviIvp/S5yEvNJdm4KW3h6JFXMl5l0Qqd586m13K0UAPftOUqIgmC2s8oVyuy/d3Qwn7IQZYz+04GAhVMHHYVJy27YTre1c3iB0C+VAjF+Gx8sXI6s0dulJLtB2erLV4JSgMkpFUvTpmhUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754718334; c=relaxed/simple;
	bh=5SCb8+HPoVvAdXXUZADziFK0wm+bJAhQlDkm4TDjvwc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=cGP+TPgL1kLvfwXX+aQyGlGrLAgwJ4AYni3s8CiEAwOnKzcqaEL6gCODUKrRUTg+oj50iFLExkhKsRMnVDAv8imqNfg3Sknvkhai4qRxB4JG5zy1kSfOR0xy2sbb4qttVlug8IihwfvVm6Ks8hlYJNGI6y/UmQ691NxFF5DGSzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n484+ipx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA3E1C4CEE7;
	Sat,  9 Aug 2025 05:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754718333;
	bh=5SCb8+HPoVvAdXXUZADziFK0wm+bJAhQlDkm4TDjvwc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=n484+ipxG/DEyHcH6arQA8dnOK9VEunGqruf9b0rPwSrlBwpValJqzsCn8EEKJPYg
	 U/0xruICATJCvm89Lnijp+8QLPoDvhNo5nZjcbs6XyVB9YpfLg0Hvnc64UrTo2b1mQ
	 O828klJVK33n/fsIQY5CrLsyiPcydAwBVnZdVSDnnbPFy3wo7bgYDeJ/Q1z4yR/5l+
	 O3mz5+a+CtjsSpoUtbWPiclO4QrwVCiPwzEM/MabOoDonaM6u9Ji/xR1bpAWcVadX/
	 HwVA/Ic2VIypFthQ/ZwyI38G/8fKYSC8LVa5xICxGxuIz+JhDMp3nMbQBwZFdh0s2v
	 gKCFlPBlCQBVQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CFA383BF5A;
	Sat,  9 Aug 2025 05:45:48 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250808171400.GA95044@bhelgaas>
References: <20250808171400.GA95044@bhelgaas>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250808171400.GA95044@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.17-fixes-1
X-PR-Tracked-Commit-Id: d5c647b08ee02cb7fa50d89414ed0f5dc7c1ca0e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 25046d5b005bddb927182df9780ef2e99bc19535
Message-Id: <175471834683.387690.11620787432358735142.pr-tracker-bot@kernel.org>
Date: Sat, 09 Aug 2025 05:45:46 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Nam Cao <namcao@linutronix.de>, Kenneth Crudup <kenny@panix.com>, Ammar Faizi <ammarfaizi2@gnuweeb.org>, Thomas Gleixner <tglx@linutronix.de>, Jinjie Ruan <ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 8 Aug 2025 12:14:00 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.17-fixes-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/25046d5b005bddb927182df9780ef2e99bc19535

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

