Return-Path: <linux-pci+bounces-37683-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A9DBC2682
	for <lists+linux-pci@lfdr.de>; Tue, 07 Oct 2025 20:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D8D14026C7
	for <lists+linux-pci@lfdr.de>; Tue,  7 Oct 2025 18:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D77D2E92C0;
	Tue,  7 Oct 2025 18:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zb7utcrZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F1E2147E5;
	Tue,  7 Oct 2025 18:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759862319; cv=none; b=VUu30piQdIabnKfXz9CsDHiwNyftxZFTux5pa8OoI/fAf0lKhtk5r8mwQiRUniuEBJ1TpoNrDHB8AAUGu4BJCcbIQmsD2bOmrOMWn+BAOAyWRRehkCmBeyQjEizmNrf5i4k7H6vqTWk2eqp2Nl11ztAOTwES3mR+5SX+/eytiSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759862319; c=relaxed/simple;
	bh=ETKpspy7sBhlQEqNsSQZTK6Oj9lxcBPpH914aocG1vA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=BXl+dk9kAViapAwUmevAs2tvaYKbqwp2hOC9WRQPG+CGjrazMXBgCg5sVMRUsmOzB9LcYXpvqRAnTTF7RrU/puyxTOWD5X+jmfFMiFo1SWHwIHv0XnVITnf6b2Ag65SM9sSJW5xhy9K8MzJMNJlpET/climq7hfdxMzNLtME0hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zb7utcrZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D16BDC4CEF1;
	Tue,  7 Oct 2025 18:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759862318;
	bh=ETKpspy7sBhlQEqNsSQZTK6Oj9lxcBPpH914aocG1vA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Zb7utcrZ87kgXF9Eqw+KOzRN5pxriDj5AB9O7XyHh/JFO249vnVfADhE7VkdFZ583
	 SiIs+Qkhh8eFfo98ypWDRqYHZOVT+wQMOY2OgMTQyn/aqNc3MOTOR9hM5bLIzSmJxp
	 +zIGO30zCtnyipdmSS5TU489gEt8ttFCWMrQ6mOvoTquQmcdlpOZfUU0fWRtKYnxZQ
	 CFRH+qisdKVox6eWrd7YBcITgq9cwx89GdszSSVHzFIAkG+ubMfguuAKFbo090JcVR
	 M44zZiiFSDnLDxDn9g8PZZ1e3H1JEm6Ju9co1+h+rOYYQcGu/k6ikbpIpUB32CWfbk
	 wD/U4DI/96Oig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 342CF39FEB72;
	Tue,  7 Oct 2025 18:38:29 +0000 (UTC)
Subject: Re: [GIT PULL] More power management updates for v6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0i7H832neTnZtHwHBD0gwQSJ_8Tyxc49K2NoO5n4=1eKQ@mail.gmail.com>
References: <CAJZ5v0i7H832neTnZtHwHBD0gwQSJ_8Tyxc49K2NoO5n4=1eKQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0i7H832neTnZtHwHBD0gwQSJ_8Tyxc49K2NoO5n4=1eKQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.18-rc1-2
X-PR-Tracked-Commit-Id: 53d4d315d4f7f17882ef11db49b06ca6b0be8ff7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: abdf766d149c51fb256118f73be947d7a82f702e
Message-Id: <175986230781.2733874.5256895340042638660.pr-tracker-bot@kernel.org>
Date: Tue, 07 Oct 2025 18:38:27 +0000
To: =?UTF-8?Q?Rafa=C5=82_Wysocki?= <rjwysocki@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 7 Oct 2025 13:30:06 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.18-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/abdf766d149c51fb256118f73be947d7a82f702e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

