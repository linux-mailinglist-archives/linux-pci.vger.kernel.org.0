Return-Path: <linux-pci+bounces-33091-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD2CB1489F
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 08:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5641E4E362F
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 06:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DFE2609D9;
	Tue, 29 Jul 2025 06:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0yrjfC2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E05259CBB;
	Tue, 29 Jul 2025 06:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753771788; cv=none; b=Htx6NnwLP1I2I6hsFPjo3vBcBuHn5dOZzkLv7JZ04WKU0XpbR7Coddu+mBbKoTZPxhNmNhKcqnTKH9XundwmSORzVAYauNNHio9mpmWlt1dOuKKQvKom1YO6HLbUh+yzhXQ2ya9VdG9G1GjvRdCDxQBNs+SprOV9o0iCj/VYq6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753771788; c=relaxed/simple;
	bh=AaBeR2wGhXcdNiVVeKsvQNtLzX1Ac4F+JosSqd5eqeg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=JoBswMYMoGo4UuwxfX1DFS93nGML4DXnD5oibFouR6nGZS4ama2wEpZfA/dhwJm/iVK+LLKfbMyczTo30uiH/S3kQrCtX2fw/QYR+R4fQ1HCrDDFxF++48QByCfTvZTcmiAA/FTtOZEqYAAOwtGcv1vH1f9ahM21po+VWuHbt2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V0yrjfC2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CF7CC4CEF8;
	Tue, 29 Jul 2025 06:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753771788;
	bh=AaBeR2wGhXcdNiVVeKsvQNtLzX1Ac4F+JosSqd5eqeg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=V0yrjfC2aJbL+qgRXf1z4LWYFa75DyRgJleqN2Svc+KItlDaTWyqe1Sloql/zeP+u
	 Huupmmp7X9iymyIOyGJAoimQU3srEfYEtqKmLrO0M9sQvFCtpEwUR5CWj8cCpxVGrR
	 Z6q3kPmDJXVDtAlomvaWSpdJAKHoADHKyiLTPZgFDbWDGJZkphrgS2xQLKrWF4IK/Q
	 fnF0FmEwH4ya9BWE8IbNZ9RPKezyanmrxxPZZi1+YVGzd96CbFHiL9i0cGOXvuPNe1
	 q7Zpfh/0G/ehiqGzsaK63X8BCKrBHVYWFU9piB3NTCSxVfu7pcxoQO1Fv+yGgec6vx
	 2tAmAIx9dNoew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id DADE1383BF60;
	Tue, 29 Jul 2025 06:50:05 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI updates for v6.17-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jTEdWhm-1aYbLtyqo99dJw4kY0PaYUy=_zh+1M+jo3Vw@mail.gmail.com>
References: <CAJZ5v0jTEdWhm-1aYbLtyqo99dJw4kY0PaYUy=_zh+1M+jo3Vw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jTEdWhm-1aYbLtyqo99dJw4kY0PaYUy=_zh+1M+jo3Vw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.17-rc1
X-PR-Tracked-Commit-Id: ea34e67ae7a6318dc775a8d98cf00c3e45bfb7d2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9bbf8e17d8521211c5c5516ed5ec78d7581aacff
Message-Id: <175377180480.1356386.697179706068332215.pr-tracker-bot@kernel.org>
Date: Tue, 29 Jul 2025 06:50:04 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 24 Jul 2025 14:38:05 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9bbf8e17d8521211c5c5516ed5ec78d7581aacff

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

