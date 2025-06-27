Return-Path: <linux-pci+bounces-30954-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8941AEBF77
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 21:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 487BE1C47308
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 19:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44CA2045AD;
	Fri, 27 Jun 2025 19:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7ozsarX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679AB1FF7C8;
	Fri, 27 Jun 2025 19:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751051446; cv=none; b=qhWflJVEAX2baqtROwjB3BCwQ7Vui9yzOpmDLpuWPqGAmWLWXm9nN6iNlvxaTuoy2BW/xQuJWZDUQMdFKv3/YFiCQsuV74S0atXb2SLUa9OFNIlS5EkXOfra3b/zIFL7cmIS9WDh+aScm1ygdjm10RRUnos5QTL0bGkwiwWJkZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751051446; c=relaxed/simple;
	bh=bg9tB9I9faxzYlBn/xY1jdGxrsBIjGiAFrTVicB87qU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=RGrpcoVKxtklCDJB6mvWnuDi2OuqJhnE+PbKJG0WPmOs0WcTfcajHK4+f8jscLhsk9ELgZziEA5BHKh2rt8sVGQKVULLbhzkG+JbspPFnN5K3zz2zlkIZ38IKMzE0AHmE0W4+iK0/M/dz/tms34A2vgjfr3dzTY8jCmzGWZ07as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7ozsarX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48145C4CEE3;
	Fri, 27 Jun 2025 19:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751051446;
	bh=bg9tB9I9faxzYlBn/xY1jdGxrsBIjGiAFrTVicB87qU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=V7ozsarX16kcX8BIbTcEzTH/JQ1Y8+iFw8ILkSGwpKzA1LTjaKYCjAuKLe8wBPO3j
	 c7280ynmx6lq86Umw7ZsvLR1geSnuPW6NEKXnWW+ZwN/u+geAOzR4I3rcx742czIoN
	 uIqyFd0UpIMzcgQY6T9X7OcULuzlQKljcXN2+f8aENwp3/JNBGwHFEwwMDWDknmZ+R
	 Ns4BoOHLPFrS+SlgcnZySfOdrd1niFQf48VcUkWOvF9BF74sSnWLZGjyKD9u2d6fJR
	 3vbg/4bBWXTFrtmxX7SRdZKoeKb3NhhjjdayjPnUSMq9Rb/ZeAdUlxu4MfQqtKAXl4
	 Rxak1LlUGiIHQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EAE38111CE;
	Fri, 27 Jun 2025 19:11:13 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fix for v6.16-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gp+fK8tVZf1K04nBpvUpAiXoPx0O0Ge4yJitPGOyEi+g@mail.gmail.com>
References: <CAJZ5v0gp+fK8tVZf1K04nBpvUpAiXoPx0O0Ge4yJitPGOyEi+g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gp+fK8tVZf1K04nBpvUpAiXoPx0O0Ge4yJitPGOyEi+g@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.16-rc4
X-PR-Tracked-Commit-Id: 2b8be57fa0c88ac824a906f29c04d728f9f6047a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 35e261cd95ddc741d8664f5ac897bbd0d384bbd0
Message-Id: <175105147207.2027229.224644361569027435.pr-tracker-bot@kernel.org>
Date: Fri, 27 Jun 2025 19:11:12 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 27 Jun 2025 20:40:19 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.16-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/35e261cd95ddc741d8664f5ac897bbd0d384bbd0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

