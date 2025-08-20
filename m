Return-Path: <linux-pci+bounces-34412-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AA68AB2E6A8
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 22:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9D1944E56AD
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 20:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAECE284B33;
	Wed, 20 Aug 2025 20:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkpaWAch"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A95202980;
	Wed, 20 Aug 2025 20:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755722021; cv=none; b=WUkP36577sfAyx1GIE5y5aMUG3rH59ylg9ftDhOgqvTxFpJ2oAq6saRlPIovhjgLGd6PnLRDuZ+KTsyYH22y6hZ1Pbr+Auvvfn7jnOX5WXc0vf0YtwijKUfU2jVohRqL2pkkTxQdJ6YMn71z3m34i4DCyp3sYGyfipb5Z6kgFtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755722021; c=relaxed/simple;
	bh=nV05UJlrp7roLoq+inqT4PCSmEfqVxaF27EVF6B0ZCM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ZUTCnDfYJ28QvCqmS9FjeKaM7elm1rPp00pWWKCbB2ua9+qnHZhNVHiAkw6ZUE03W8MJKRDcWn5VtS/qnLBkVPnDLtufyFLui6jJti02BkYSg0pr/YkZKJQLXz/0O7hx8qcbJa6ADrrR5PjuZL7hPeQfXvXe8yBnCJWjeAQFdkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkpaWAch; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AEBEC4CEE7;
	Wed, 20 Aug 2025 20:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755722021;
	bh=nV05UJlrp7roLoq+inqT4PCSmEfqVxaF27EVF6B0ZCM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=nkpaWAchEqyzv0UTsnUjXkEmMuCPAcL9xxbekCZne86L5emg/UFsScgjEl/Izjqod
	 ANS4865sN5Z3KOdkpviBynC0pI8V+XBHqyeyMdasIOPu+m/5ohJaLdG5p+q4WDO9Lr
	 9NZu+J4+1utbT+G8hrtUiyRTTlTaIxgMa4XaRc1eycUtfNBLSxKQWWzjzipyGNWNUr
	 LGGamGtD0eGhfktGNMvUU1zmVZPESj9+ivmI/Jb//cbMpAaMDvOpu9VxPlEwfCRkiA
	 1CxgN35Yyf49KYliBOomdm1IX0RphQpargPJP5Cc0uGqrrEV37RE/eZjI4R48N/0ip
	 BTgXG1vL9O4PQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DBC383BF4E;
	Wed, 20 Aug 2025 20:33:52 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250820202441.GA638554@bhelgaas>
References: <20250820202441.GA638554@bhelgaas>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250820202441.GA638554@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.17-fixes-2
X-PR-Tracked-Commit-Id: 5149bbb56bdcf5c5f72904025fbb502217580b63
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 41cd3fd152634250fdd09a52a35352b3f323800d
Message-Id: <175572203085.365859.13266183315487613451.pr-tracker-bot@kernel.org>
Date: Wed, 20 Aug 2025 20:33:50 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Nam Cao <namcao@linutronix.de>, Ammar Faizi <ammarfaizi2@gnuweeb.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 20 Aug 2025 15:24:41 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.17-fixes-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/41cd3fd152634250fdd09a52a35352b3f323800d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

