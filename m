Return-Path: <linux-pci+bounces-26153-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BDDA92E2A
	for <lists+linux-pci@lfdr.de>; Fri, 18 Apr 2025 01:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79CB47B5EA2
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 23:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE4F224B10;
	Thu, 17 Apr 2025 23:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sNC4w7Re"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D45224AE4;
	Thu, 17 Apr 2025 23:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744931968; cv=none; b=CdfD8eKjIFDbVHCm37XWhgCLobbiFCmAhJKA1LHwed/8V0KZ+d4bAjJcztv6hwQX0fy/6GsN6Ua7xejllh1qfdSvwAhiHk+G7xn6ZBjRwUtHq1SHInSg2WHuL+dY/lbigPS2I9aQcrGRAqKn5Xgh9RrqyMbjJElUD11hFV6JKo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744931968; c=relaxed/simple;
	bh=GmU4kYSZtteVKJnRfYlmEJtmfazciAWvWhEJDvGI4OA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=JtNDwe7A+eRbvwSPxjfXXwN75lUB2vry02BiQ8mvxj6j73KT95CcQO5W0pKJuEdmHLfpl89OPbjakKaZo+L47fCbvhRHkzxKS1roxRYv9BSlnxR7+xNlzlFJnL62WTz+pZZxkub0g1cXsZTdrMWrSrkxiAiSNDf5q3XhyaEiBWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sNC4w7Re; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23F6BC4CEE4;
	Thu, 17 Apr 2025 23:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744931968;
	bh=GmU4kYSZtteVKJnRfYlmEJtmfazciAWvWhEJDvGI4OA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=sNC4w7ReR+xJ6reoj8dMDSWbfSRiXxYhvI4Nkn279cVFtfAlOEPaBZIH44A9Pq08Q
	 XxRrzD6wcSmgUn9mY5E6qL40W+fdZ2UZhkaJIrvPoF99sH7Zl/Z81JaJE5rbDVkjbu
	 0i5xUWhR2ttA7OIknXCQHZoDtVzMRlBBOTxB8oeAhJ2UqA8oMmYwLmpyV4RV7mrOWe
	 oHYOizSGjHDwSd3Ic4mAdtR9xyv4ncGP4k5M4VaQNreS5hql2X3pELa352F1nlKzte
	 pm32ejf1lv+Wd+qee1vkmUxQ4z5qLCsM4HIBA1JM8uYdLnYtZJBE9P/SCEFWzdt10d
	 riV6fjjQ3X8rw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71C78380AAEB;
	Thu, 17 Apr 2025 23:20:07 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v6.15
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250417224143.GA134013@bhelgaas>
References: <20250417224143.GA134013@bhelgaas>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250417224143.GA134013@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.15-fixes-2
X-PR-Tracked-Commit-Id: bc0b828ef6e561081ebc4c758d0c4d166bb9829c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fc96b232f8e7c0a6c282f47726b2ff6a5fb341d2
Message-Id: <174493200597.45874.11276434309873731679.pr-tracker-bot@kernel.org>
Date: Thu, 17 Apr 2025 23:20:05 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Alex Williamson <alex.williamson@redhat.com>, Cal Peake <cp@absolutedigital.net>, Athul Krishna <athul.krishna.kr@protonmail.com>, Kevin Tian <kevin.tian@intel.com>, Nishanth Aravamudan <naravamudan@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 17 Apr 2025 17:41:43 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.15-fixes-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fc96b232f8e7c0a6c282f47726b2ff6a5fb341d2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

