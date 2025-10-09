Return-Path: <linux-pci+bounces-37746-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 833C9BC73A1
	for <lists+linux-pci@lfdr.de>; Thu, 09 Oct 2025 04:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A0B019E5CE6
	for <lists+linux-pci@lfdr.de>; Thu,  9 Oct 2025 02:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737531D6193;
	Thu,  9 Oct 2025 02:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3RGwdrO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D28E1D5AC6;
	Thu,  9 Oct 2025 02:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759977615; cv=none; b=q/VgTpSNCX0ZpJIh6lO/ypQH9AVx4f+FMQRTK0KINPG3Sf2Z6j789LdYFbCvwS9EuTWfOfRVbA4qNar+mo5cELQ06Or656cGNd/PoShK8wgXzazAPCd1NMPKlZGgLxbKoObclsi4IYlbzuk340EWZCpCZ42fFpx+g9vO68dcPCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759977615; c=relaxed/simple;
	bh=3UWbihVfIEaTlVHcWiaDU7vqLnLvQEwuYUs5vWk9nNQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ImqHWnn4Y+B4X2wa3YqjpnbJzqTrRnnwdY1DTN7hIrF9y8N/dhTEUDlV6ebge5IfCGAzWTd6jWHpGzUDJodBB5t+N9jtIce95ledwNjwYAgUq4HMQ2pmZ+m8kUtO1HH4cdRNsQDDF8vnNeO50ANp82F7usCXCpTiatLEBXvC69E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3RGwdrO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 218F6C4AF0B;
	Thu,  9 Oct 2025 02:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759977615;
	bh=3UWbihVfIEaTlVHcWiaDU7vqLnLvQEwuYUs5vWk9nNQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=O3RGwdrOP7bj4S2+HxL49ZboEI5IZhIZALo7JQJH9WwphTVQspS9kXai6DHDiTWCb
	 y6siNuAuQfjqMm2RFJC+sQ219EH2C/g6eQ3B+nFNLEhd6QKiu0tJRmSMYdu+YsMTp7
	 uAXT+Oc8OkpHMF+Hk9zcuTh2iDVEgtT+domceXjRWQ6ihCk5TzYmEt45dHkCZTtAcL
	 N5fblh8BbggVcv7tRzttFsT02K03H3VCiJ2GedcSBy3UcNX4RBwQiGBX1MvskGQRTb
	 /Oy8lwBu3ptAylsvfLezUziBNOe4xsKGSzpT5i/OAoyOc3sf6iOF2n7jiBHJBcbQqE
	 MSJGZrzajT3wQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD903A41022;
	Thu,  9 Oct 2025 02:40:04 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251008222545.GA648136@bhelgaas>
References: <20251008222545.GA648136@bhelgaas>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251008222545.GA648136@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.18-fixes-1
X-PR-Tracked-Commit-Id: a154f141604acacc0ec64a445d8058a045c308ef
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 37bfdbc11b245119210ac9924a192aec8bd07d16
Message-Id: <175997760321.3724664.6889093631436565732.pr-tracker-bot@kernel.org>
Date: Thu, 09 Oct 2025 02:40:03 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Yangyu Chen <cyy@cyyself.name>, "Kenneth R. Crudup" <kenny@panix.com>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 8 Oct 2025 17:25:45 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.18-fixes-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/37bfdbc11b245119210ac9924a192aec8bd07d16

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

