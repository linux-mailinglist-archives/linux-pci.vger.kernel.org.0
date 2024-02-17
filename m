Return-Path: <linux-pci+bounces-3662-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 872268590E4
	for <lists+linux-pci@lfdr.de>; Sat, 17 Feb 2024 17:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16876B216C1
	for <lists+linux-pci@lfdr.de>; Sat, 17 Feb 2024 16:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC34D7CF14;
	Sat, 17 Feb 2024 16:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qrnZhyWY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84918657AF;
	Sat, 17 Feb 2024 16:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708187222; cv=none; b=NCs/jb/rkT4N+I97koacKUiC2AmQ6CS5durzE25ZL91moFklKQWEAHMhIy9pq9463R0uU7WOwF4deYkJvKNKGjtp3NOGOYwcFRxI5jv5sTeYUN3E8VIj+lD+DRji45jOQWSCVavGFLmIqzIZrWutFs+GUyDoWN0dZBvUB+NeoDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708187222; c=relaxed/simple;
	bh=XHopmcflDr0JJM1EJWao3MAlVCspOakQnG3Dj3moEfs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jM9kwxT2Bbz2PTJy1l0yNqZ4K1AfdXkDES8X8AN5yEVBDpGADbgm/zIHpDp96GB3HqA7Ewlcs8erxQhhcj3hoPXY3DQxUiBhbdonUgdyRmwSW+C6ikCekG0fxiPaI7AuDYPfWj66GZYYb85F4vSgkkV+J+F6b0vcreXwcmDSUGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qrnZhyWY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 10603C433F1;
	Sat, 17 Feb 2024 16:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708187222;
	bh=XHopmcflDr0JJM1EJWao3MAlVCspOakQnG3Dj3moEfs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qrnZhyWYhpPOo/mpuX16KWFMMNdBhQmySqjN8Z/rH4F3VzW4951P0Uosh9sjE1Uqw
	 FgJ3SYbIV+22izIu8GB79f6Pk881LGtr1CqvEZds5takQeSbyy9zUv4ltcPmoHjCRs
	 Guhbgp4ef9Kk8j3hpDMGvBte1bmo1HlkUSCuNMcZ12+d1NzHkIqwyGfAm6Euk6lnTL
	 dEfQ8ioIloft0wXuO98d1bzModSFh8h4zAMdzOxpL4KN9Xo+yH9YhAYmvzu6c6p1zi
	 LIpABO6u3IOEbwvgxYYwj+jVSKTf14srXcAn13VBTX+pQSKMTboRRlEmLu0zxB1So7
	 ssVR1okNEVw+Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F2C4EC04E24;
	Sat, 17 Feb 2024 16:27:01 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240216233501.GA1362441@bhelgaas>
References: <20240216233501.GA1362441@bhelgaas>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240216233501.GA1362441@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.8-fixes-3
X-PR-Tracked-Commit-Id: 172c0cf519fb52860157c57067f1a58cfc0aa861
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4a7571485c467b76cc19fae304452fd56921c789
Message-Id: <170818722198.7289.3341384652547057643.pr-tracker-bot@kernel.org>
Date: Sat, 17 Feb 2024 16:27:01 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>, Sanath S <sanath.s@amd.com>, Siddharth Vadapalli <s-vadapalli@ti.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 16 Feb 2024 17:35:01 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.8-fixes-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4a7571485c467b76cc19fae304452fd56921c789

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

