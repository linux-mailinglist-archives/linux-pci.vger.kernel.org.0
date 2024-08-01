Return-Path: <linux-pci+bounces-11137-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 084769452D9
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2024 20:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3345C1C2029D
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2024 18:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF26714A4DC;
	Thu,  1 Aug 2024 18:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQa8BHM2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B9E14A4D6;
	Thu,  1 Aug 2024 18:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722537406; cv=none; b=BofUrFbLAr0158nMl00VN9pQJGVmj6DSdL0P9MBpn957WMIkQYHzedGbBUlbhg0ceNzMsLfecpyH4M98BHxpR+T5UJ9jtWy/BPXJa2mt+ds8fF5fbkmHrdSSEH9v6mCHbOMGKapB4EhLtntwGwEp0jxUbkgop49oUuKDsOvVKgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722537406; c=relaxed/simple;
	bh=Zlg4721NQS5/+FBXCbu9oVNq/L7l6OkL/o/WjbI8Lj0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=G1CaostSm+qz6Y1mpW64sJIEmZXwxmJGvZBht2qyYPj7OaXiRjGBMwhCqsxFFSmZGE+SYCLmWIPpYxiUZ6lS4AVhptR/8LQSkmf0Upc9pvH6A+dAYe3DCr9MFwscs5VWN+ojZ6VwK3u+icPpvUrmbYRbQzv0vgeaWqlg/IOcMMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQa8BHM2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4C3EEC4AF0C;
	Thu,  1 Aug 2024 18:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722537406;
	bh=Zlg4721NQS5/+FBXCbu9oVNq/L7l6OkL/o/WjbI8Lj0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=fQa8BHM2HKqzpKXt2MOr1XPHVqZu7iUqjd1n3CDbzn5OEsTy3obPBNbCZ1Kcf1j4E
	 0/vCcwKdzSOkBmD1MHur4wU3/423sJvQiQXm8z+WqUA8A4RLveKiyN9G5U8dMqIZqN
	 pkKQeww6uYtWJJhcpA/+Lpoof7E97JSDurX+F65C81J4skfYQ6AEyW7iEKLRSNa7qf
	 WDkmaZF6xdJyHEN9H81pgK2Y9f6vRvExe+aW6IO0XiYcXtHMAnyJBEK/RT91Qb9nB4
	 eWygtA/SdWG2wAo9ZXMk3/aVVR54E+BxG5yaEGKpcEYV680YfeHT4zVqwBiT03L7/k
	 3mSKEOQDbJsYA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3B2D4C43619;
	Thu,  1 Aug 2024 18:36:46 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240801181514.GA112131@bhelgaas>
References: <20240801181514.GA112131@bhelgaas>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240801181514.GA112131@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.11-fixes-1
X-PR-Tracked-Commit-Id: 5560a612c20d3daacbf5da7913deefa5c31742f4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c0ecd6388360d930440cc5554026818895199923
Message-Id: <172253740623.25955.6854334550105069611.pr-tracker-bot@kernel.org>
Date: Thu, 01 Aug 2024 18:36:46 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Blazej Kucman <blazej.kucman@intel.com>, Philipp Stanner <pstanner@redhat.com>, Damien Le Moal <dlemoal@kernel.org>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 1 Aug 2024 13:15:14 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.11-fixes-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c0ecd6388360d930440cc5554026818895199923

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

