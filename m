Return-Path: <linux-pci+bounces-42729-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 16158CAACB7
	for <lists+linux-pci@lfdr.de>; Sat, 06 Dec 2025 20:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03F8A30FF05B
	for <lists+linux-pci@lfdr.de>; Sat,  6 Dec 2025 19:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1DD30216F;
	Sat,  6 Dec 2025 19:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L7eHjm+V"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054D03016EE;
	Sat,  6 Dec 2025 19:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765048047; cv=none; b=NexJeVyrkl8Ovon1hEmhM6HKQhP06LyYR8+jKmf0lTEpbu4DV2Llw5PlUw6/K6DyaXfG+9bSZTolVjQ1dJH4/trzV5+MII4F3A3GW9EPd9dlfUQ8ZDuEftLfhyI+buSgsmUH8vrdivWMcptIQEKefjvNyHW5VnLO5BUO7hOQbcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765048047; c=relaxed/simple;
	bh=3LClfbrwH1dLomjTViTZhLme/Vy9ZAYYBGAM7wLDa1Q=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Zs7AvYAxK8B1WH57SHuCpy57N1rIbSYxtfQn42Vvf8M0/OuQuXQi53gXqeBt4FRvRZZGBp5XV1Sx0RscNrGS+enl9ORseY6pq4Hx5gshHXBZ8ukg9AZ31lcah8Z11vd1S0c0JntYmyRuHU7QUSa1Z8AkhbLjxmMixL3IbPEHrRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L7eHjm+V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C98E0C4CEF5;
	Sat,  6 Dec 2025 19:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765048045;
	bh=3LClfbrwH1dLomjTViTZhLme/Vy9ZAYYBGAM7wLDa1Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=L7eHjm+Vd2OOzGTDqNZWt+TQ+5xT+Gzn/DELQ/BBTGUeV98ovVTOyyAHS2r0kp7Op
	 Apga4lhDDcXdEGcN7bVuzCrX68tb4U6+WHkc8ENcjMLJBHuGqTMfE1KmvLcyLIqF6J
	 o+y7G/uLyKNdnNOSuoewQgB8AB4psuAmTjP3mv4lN3Fy4RqkAzcqbJgdLtIgfiJfGH
	 pUJsVan67/vi8mEbY3XvtrY0fr0JSWEaUAiy5UfZR5SnNpFM4fcz3I7/OGCj9jPB3n
	 EO3JTn/Bzd5IcyK1mWmSE4AJB8rAqlr8DwyAMH2mlH6S0UYxYflxxr+eYBjlJPoM8J
	 gOKK+WaOBLgXA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F29103808200;
	Sat,  6 Dec 2025 19:04:23 +0000 (UTC)
Subject: Re: [GIT PULL] PCIe Link Encryption and Device Authentication
From: pr-tracker-bot@kernel.org
In-Reply-To: <69339e215b09f_1e0210057@dwillia2-mobl4.notmuch>
References: <69339e215b09f_1e0210057@dwillia2-mobl4.notmuch>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <69339e215b09f_1e0210057@dwillia2-mobl4.notmuch>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/devsec/tsm tags/tsm-for-6.19
X-PR-Tracked-Commit-Id: 7dfbe9a6751973c17138ddc0d33deff5f5f35b94
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 249872f53d64441690927853e9d3af36394802d5
Message-Id: <176504786263.2170003.10766964741979894178.pr-tracker-bot@kernel.org>
Date: Sat, 06 Dec 2025 19:04:22 +0000
To: dan.j.williams@intel.com
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-coco@lists.linux.dev, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Alexey Kardashevskiy <aik@amd.com>, Xu Yilun <yilun.xu@linux.intel.com>, "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 5 Dec 2025 19:08:17 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/devsec/tsm tags/tsm-for-6.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/249872f53d64441690927853e9d3af36394802d5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

