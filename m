Return-Path: <linux-pci+bounces-44391-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86EDCD0B613
	for <lists+linux-pci@lfdr.de>; Fri, 09 Jan 2026 17:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 28987305455A
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jan 2026 16:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5F3363C78;
	Fri,  9 Jan 2026 16:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IzpDeCEE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDA335CB82;
	Fri,  9 Jan 2026 16:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767977011; cv=none; b=RLsFheGmsdpolILJhx3OzU9gDwnokYkk3YYXxr1nvwL5v9ZxrimEsYyZu4Ju98d8qrJJN45IMjZgx7iG+VCQK9at2sEb//E0z76xMjsND84hCJEU6erMwTd+TcwIhaoED4Mcaf+MuHWcuhZXeVgDzqiQnE9+7dTD1xzoALbiKtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767977011; c=relaxed/simple;
	bh=D05/d7xlS/NgL8w4M7Bx4u1dBqnl22zhThCyNumZMFE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=dW911dx+KKvya0VwE20MLfHN9judOTUgz+V+kGrpnFrbu5f3vsINsLuePDlTkJq0wKj5M6DM5f0lJWl+guBO1fmS1Mee+XfdQRxeoS3ZgZ5vI/7mEqpZBhRq5PO53XQRB31ma+XHqV619wSjqCgVxThhbfhNhulURaH4CDue+F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IzpDeCEE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70C5EC4CEF1;
	Fri,  9 Jan 2026 16:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767977011;
	bh=D05/d7xlS/NgL8w4M7Bx4u1dBqnl22zhThCyNumZMFE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=IzpDeCEEa/OZZPkuE8ti9AYbMZRFGS1fpO+SkXPzPxLR8Xsg9EXGLaJPXjDoFVe3O
	 9rraPpa4i56MlwtXfafxWh30Kx6GGf0Uj7YOly30HUhItI88GUe/cdPxdjpgWHouzM
	 Fn7IN+6HZ/U7BMUWOLWOJd4HEM8+YU9+dEv6244NQJ2H3I+VabFHNh6A/dY4wxHn98
	 6eSV9LhRGP65ye5rdo1o+vsotPq1viaFTNxwj0gcKOu8jJcz3oS6WzefqWuXbvT3WN
	 dODTQYjsVf6fAD7trQwLIqHliThRVIWywQ4tUfn6ndQ6ISXqTqJuR12Ai8I/k4tQU5
	 L6W0OOMWZrZ2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 83C4F3AA9A96;
	Fri,  9 Jan 2026 16:40:08 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI support fix for v6.19-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0ioRVFo16psNNWeFaWCCew-X1-zoxfJWggo8eWGOrbP3w@mail.gmail.com>
References: <CAJZ5v0ioRVFo16psNNWeFaWCCew-X1-zoxfJWggo8eWGOrbP3w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0ioRVFo16psNNWeFaWCCew-X1-zoxfJWggo8eWGOrbP3w@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.19-rc5
X-PR-Tracked-Commit-Id: 1ca8677d9f3491e51395b0e6b9a2b7a75089dc6f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 553410fcb95e3acf1a4ac7c08c5b30407f5f30b6
Message-Id: <176797680735.322717.9971524872580371629.pr-tracker-bot@kernel.org>
Date: Fri, 09 Jan 2026 16:40:07 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 9 Jan 2026 16:24:40 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.19-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/553410fcb95e3acf1a4ac7c08c5b30407f5f30b6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

