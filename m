Return-Path: <linux-pci+bounces-39978-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE298C270B8
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 22:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C69581899FBA
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 21:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D69325724;
	Fri, 31 Oct 2025 21:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVTu+evn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA734325702;
	Fri, 31 Oct 2025 21:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761946213; cv=none; b=VkJXGeQ6Q0lFGBU4F8x8F5VtUqKCCnKmV8mEhs/OVYZWupOZkl/MHwb8yjMEMLTKmDBIwuFg6Fe84pu2M/pGCcRtvP52TnZUk3T9lRMPXXpfTqpvSJuGj51M2OXpxV1ievovGAdkGkayPZNjj40EKWcfeu1QBaGDcWgbRTNfByI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761946213; c=relaxed/simple;
	bh=yAfMwB5xi+mJbUJPU+io5R28oNlvVjusnjwxcoTQir8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=IpmmEGhFqKngwQPzgAdZcebkenSy4j7jGupiqJLDTOhVdIaSr0vl6dKHUJ2P3R39ANTaxeUzLYiXuSF3rXOKkqBuV+jr0gA4ECvj2wUy9SEucXYZ5gbrBiiBM72ndmUREXXbVAi+xMgDA9j2h68Z5vHPLxowD/+MB/bmOnBoXLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PVTu+evn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A58C7C4CEFD;
	Fri, 31 Oct 2025 21:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761946213;
	bh=yAfMwB5xi+mJbUJPU+io5R28oNlvVjusnjwxcoTQir8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=PVTu+evn3j7Tmew2sfepS2S19UbbiWi9rFMiNYx4P8mxBGhqu7KpZV+Nvey9AHGW+
	 wVB2AjNbKzFyc9FgvYdPauluv7+QZv4O/yXZ3IqBKF/1ufrkf+P5pdPW3sTUvr1BBm
	 GPg8/BFQSRJtwW7V8eWWT7Q4S8J8B8pHsUXx6ySpktzf16VTmeL0F2QFZZiszq3TKe
	 4lrFfqLCwUQZsE/FXQtuqmi+y53Atkmcv5UsxDjup3ngJSLTgP0d9/4cOBLbU/fNff
	 KlD+2rzczEvjOIEShXws5Xng9E96eR5PlUNuvvp2XC07IRtXi1K/gLMNGXz4dfRhlq
	 ENFNEIzzgvPZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD943809A00;
	Fri, 31 Oct 2025 21:29:50 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251031201926.GA1706862@bhelgaas>
References: <20251031201926.GA1706862@bhelgaas>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251031201926.GA1706862@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.18-fixes-4
X-PR-Tracked-Commit-Id: 437aa64c8e32b724fc6d60100ef0eb313d32c88f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f414f9fd68797182f8de4e1cd9855b6b28abde99
Message-Id: <176194618943.642175.10615761486331101416.pr-tracker-bot@kernel.org>
Date: Fri, 31 Oct 2025 21:29:49 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Johan Hovold <johan@kernel.org>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Klaus Kudielka <klaus.kudielka@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 31 Oct 2025 15:19:26 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.18-fixes-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f414f9fd68797182f8de4e1cd9855b6b28abde99

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

