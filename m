Return-Path: <linux-pci+bounces-36051-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8AEB5559E
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 19:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C18F176CAE
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 17:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BAAF32A3F2;
	Fri, 12 Sep 2025 17:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZ3Uy4KF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53096329F3F;
	Fri, 12 Sep 2025 17:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757699344; cv=none; b=R6QxYQD+UG/becBG4o5fh2jfqJH92BjehuM+T2rLMcZnCHGRJ8SGrHhrSLNo1EGLrXvox3au/ISLtS6ve7w4BJoPqKRHpJke5qWglaJ9EPZrn304/5c38Zg54uz+pqozrgno2DOZKrCPw/r6gGLObTI2NvkUfZtmUySHF6gZi1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757699344; c=relaxed/simple;
	bh=QW9jAxsE0BHuYb8pADHkxYBs4aPFw2GiNbEAj9orAMA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qZqne9nZWDjDvND6ZASEc4fHvYe1rdHQX0+XOj2m5RJYUPvznx2PhGPuz5IdLMxF/feGS1oKubk+D0pwAoroffKk6KznIwMSKF3KH9tbFEaq9QYMxRSsx6lXADmBptvpZRi6lD403aMkcsLijT9sobczdqvrrdESnG/SCRDD41Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZ3Uy4KF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D609AC4CEF1;
	Fri, 12 Sep 2025 17:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757699343;
	bh=QW9jAxsE0BHuYb8pADHkxYBs4aPFw2GiNbEAj9orAMA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MZ3Uy4KFtUP99h/jsj293C9ZB23Ca1cQZxusNBo3rja2NjqmzRKihgc4Qj2DZPYHd
	 pDaAeFL2HbbVbZ7d0K2z4s7CtXYbZpkLc/q+fJn0bS/ptpeJ0RkHmpsN6L3vLLYDA0
	 Jy9ahpLKC0a3w+O6E3sa9to9R5QIX1WY/Re1PpF6AUrZctKsCXu9kxBBO8e+DkC7Y6
	 S2JMAA6R+w93ZgwY2IF/8kXbAOS5uAFVMp37GavZCLJV0zMwn78h8+XGT2houJMBpo
	 VrDgB7G/v5Nfdyro/JcPLBSSaCVMvKJlaGCEfIa00WJsA/9WrKUm/tu2Umpn0MXbPK
	 dF9MRwEu/7QCA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71410383BF4E;
	Fri, 12 Sep 2025 17:49:07 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250912152842.GA1625331@bhelgaas>
References: <20250912152842.GA1625331@bhelgaas>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250912152842.GA1625331@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.17-fixes-3
X-PR-Tracked-Commit-Id: b816265396daf1beb915e0ffbfd7f3906c2bf4a4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 22f20375f5b71f30c0d6896583b93b6e4bba7279
Message-Id: <175769934592.3023336.8078993412767026909.pr-tracker-bot@kernel.org>
Date: Fri, 12 Sep 2025 17:49:05 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Klaus Kudielka <klaus.kudielka@gmail.com>, Jan Palus <jpalus@fastmail.com>, Tony Dinh <mibodhi@gmail.com>, Rob Herring <robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 12 Sep 2025 10:28:42 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.17-fixes-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/22f20375f5b71f30c0d6896583b93b6e4bba7279

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

