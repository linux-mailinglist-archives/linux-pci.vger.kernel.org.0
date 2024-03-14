Return-Path: <linux-pci+bounces-4835-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A97687C276
	for <lists+linux-pci@lfdr.de>; Thu, 14 Mar 2024 19:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B177F285256
	for <lists+linux-pci@lfdr.de>; Thu, 14 Mar 2024 18:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548BD74C07;
	Thu, 14 Mar 2024 18:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RSlsN7fx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEBA74C06;
	Thu, 14 Mar 2024 18:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710440404; cv=none; b=fzhxakXG8TxJcwsLhp9tkXK3nGdV2SxaRwRSYNNsgUh1yZsGuc9XVJhoKpuBQzMoY/WDm1M/8THSmK9SYinVhf+wwOT6KXXDzftZWUNebqSXK67lzOxVH7Km2oaD3f4ShFNaYFY8ZQJDswbJdDsfDjaUpt1UoOTq0bzokNHSgRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710440404; c=relaxed/simple;
	bh=Cd5f3MJNw2fZs7dQjF0bqB0ogSBSkE7EmatswUJ7OrA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NBuXD3XZTjnG5p2YQ9H3QRkzoJCQw0dyQJPIdlMzxtjEuhzirQAJR3aPuXjAe0PWAypKHH4TTReiCXf/X7EquHDRU8h2EJegMtpd27LIkQCCWevTcVWeYZxGwXH2XzhSgvc2n3cboYseJCRm4mi0YrqYhPLBLx6RgsR0riSk428=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RSlsN7fx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0586EC43394;
	Thu, 14 Mar 2024 18:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710440404;
	bh=Cd5f3MJNw2fZs7dQjF0bqB0ogSBSkE7EmatswUJ7OrA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=RSlsN7fxcKE34g0vOlHyJz1764keeyLPYODJzmcQatDXoNM6UBWp2vassVQW7ukLE
	 qCN5dInBQINPTCbfO0GeiVL0a25d2fqqUOpYRfRcDKHlAXB+a5/2cu3IfvJVHBrVkC
	 83xIMd0nSYdC+iDf0BvTlYQNl9Qg/5icK58ekFwayXiOLhkWAHV60LkNrY3fE5ETr4
	 j5E9aqNm7EBhYksZH2GdxC4OXKAJnuwP+WUmBY/G3osOPIAsJLBGqZhx3i468HL/DS
	 11Grg5UBconEXF9RUnWuJWTlfv0HkJfgO3L/5GCmYbNKhTEZ7QH46cXzZUHjnRUKRA
	 iw6/G1hk0rlgg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DB60DD84BBF;
	Thu, 14 Mar 2024 18:20:03 +0000 (UTC)
Subject: Re: [GIT PULL] PCI changes for v6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240313145930.GA918008@bhelgaas>
References: <20240313145930.GA918008@bhelgaas>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240313145930.GA918008@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.9-changes
X-PR-Tracked-Commit-Id: aabf7173cdfed20ba8677548b601ee6d966712aa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 705c1da8fa4816fb0159b5602fef1df5946a3ee2
Message-Id: <171044040387.24196.11569961171897938588.pr-tracker-bot@kernel.org>
Date: Thu, 14 Mar 2024 18:20:03 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 13 Mar 2024 09:59:30 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.9-changes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/705c1da8fa4816fb0159b5602fef1df5946a3ee2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

