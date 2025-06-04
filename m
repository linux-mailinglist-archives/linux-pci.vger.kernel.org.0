Return-Path: <linux-pci+bounces-29004-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7339ACE581
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 22:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7762A3A9808
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 20:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5771A42C4;
	Wed,  4 Jun 2025 20:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PdC7nw6a"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD81111BF;
	Wed,  4 Jun 2025 20:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749067679; cv=none; b=B6nUQD5ApEe39K3N8um3W7FuhgSaDTLaVcXjx3st+658NvEEdbFf1shLkeTbTyM7CdKEgrmmau7GlScv1T9U3TPs90dVw6zpNlwuxVpRdItxVlCZg9CzhLaw0nw4JVy5S7BXXRN3vkYlNxEmUJjeDS1tG5bW5FxSuoClYKgRzpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749067679; c=relaxed/simple;
	bh=Qit1sA+kwTzNsiFqm8laY+LA4eKEs3f0ODnrucD8s3g=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qcj67LIuBzTFyoN2nJcjt1yWJSrWM+sPcesHj6QKw3sRFAUQgAdMZ+A79RhFRqbfkNpmi9caD6uUUJADFWpa8ZHtWeJ/gx2hf9cjrkuyQqEk1GpuJ20sNLRxRyj9HmmwIhIojpecJiC76rUQzoR4fHJ/FTGZqcoXulXphGRgXMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PdC7nw6a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C20C3C4CEED;
	Wed,  4 Jun 2025 20:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749067678;
	bh=Qit1sA+kwTzNsiFqm8laY+LA4eKEs3f0ODnrucD8s3g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=PdC7nw6afX25n4WEJVRvi2+YxIqiFD20oOX8Yq0a++IG/fUw6SciygncXQdwOrr/J
	 3rrE5RTp87d4nuyZjcDlrN8ZfOGY/gu8CD2rnVPCR+9Ao8YfjvJBkn9e0FJF5ZCOgl
	 L9vZn+zU76Gu31IcyOg0ixtN8Z8hrAyxE42P7r6zZeEKJ+mwq0s1PODJj9yAyxbhqE
	 il8CJ54ZWm0il1QzRV2mvPldvDP7IlNsRO8o53xBBGOmeLPi9cv47MLK9pWzRkENQ9
	 PlwMXqFjN0uYkxL122ntO2K6FZMt9g41K6isccNoX5sC8PuapE6/M65shpIRsB8MP2
	 nedDjnj6DPDpA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB19B38111E5;
	Wed,  4 Jun 2025 20:08:31 +0000 (UTC)
Subject: Re: [GIT PULL] PCI changes for v6.16
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250604171300.GA533412@bhelgaas>
References: <20250604171300.GA533412@bhelgaas>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250604171300.GA533412@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.16-changes
X-PR-Tracked-Commit-Id: 3de914864c0d53b7c49aaa94e4ccda9e1dd271d7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3719a04a80caf660f899a462cd8f3973bcfa676e
Message-Id: <174906771057.2413472.14519966999221384526.pr-tracker-bot@kernel.org>
Date: Wed, 04 Jun 2025 20:08:30 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Manivannan Sadhasivam <mani@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 4 Jun 2025 12:13:00 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.16-changes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3719a04a80caf660f899a462cd8f3973bcfa676e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

