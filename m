Return-Path: <linux-pci+bounces-31985-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13821B02851
	for <lists+linux-pci@lfdr.de>; Sat, 12 Jul 2025 02:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28A7B1BC637C
	for <lists+linux-pci@lfdr.de>; Sat, 12 Jul 2025 00:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364BD28E17;
	Sat, 12 Jul 2025 00:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SegdZW9O"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC0CF507;
	Sat, 12 Jul 2025 00:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752280134; cv=none; b=fQ6saloCVJ79EiLziZiAPHHZnTBtEdJ1NqpJK6hrudRtPFgYdAtnGnACFhDoYS5oktBD0hh3JU2m3/L2lATegC4IyxEMY0INsyMyzxj1jgY490/WDCVe8l4th29xOP9GNmjTK/b2Nvgq6Xv/26zNYOt+b2Ae2wrcUzQtpKQ9Um0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752280134; c=relaxed/simple;
	bh=au26bROcrqarJ4UJmqYmkzcfWBJIKIMTjh+GfJUei1k=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Mvj6i3mr10LbafoGw76vqZDlqb8p+7LWr6pG2d+FAwGjr6CJhz+JZiJwbuEP5VbECCQW8NBe2XB71GhPcNzWeV3U3BagDJ5PIfMgdZYVyXpqF010HwK2td2I9CtJy5zxYg6Wq1bgx4gNKv8VDD41B0ejQX+JMms7Nx1zw/TalIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SegdZW9O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFA5EC4CEED;
	Sat, 12 Jul 2025 00:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752280133;
	bh=au26bROcrqarJ4UJmqYmkzcfWBJIKIMTjh+GfJUei1k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=SegdZW9OAX63+mpQL+COP9N/O1Jup3W6HkUAcSI8aYkEhoOLd3hUt01Ieb5I1TDiY
	 PC5EZTk6yNVurYrJY5Bgt1xUjEn8ZDg4p+VDyRPZzcwu0kLAOiPhttSb+VCafl4F/t
	 feM87kDkuhPQrd+q3svjxxo13QYVEogxlFwDzt0WlkllIUR+KMoY9v4OAqAtuX9vLJ
	 iyAfg4HgzqSi/0iBVdXfXlKL0CgFAuQxj+3hDMLiNbUuu3M1FQKgQD4XsyihoV8K2E
	 GVRSgBSob4YmUC3GKjFCkRoUqczO7g9GF4h5nA8Yr7wjKP2cAUD7UxR3BF2kqIOBP5
	 WuR6baTpKBUGw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB2A4383B275;
	Sat, 12 Jul 2025 00:29:16 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v6.16
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250711202802.GA2304110@bhelgaas>
References: <20250711202802.GA2304110@bhelgaas>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250711202802.GA2304110@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.16-fixes-3
X-PR-Tracked-Commit-Id: ba74278c638df7c333a970a265dfcc258e70807b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 379f604cc3dc2c865dc2b13d81faa166b6df59ec
Message-Id: <175228015538.2445691.16864250063906208124.pr-tracker-bot@kernel.org>
Date: Sat, 12 Jul 2025 00:29:15 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Marc Zyngier <maz@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 11 Jul 2025 15:28:02 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.16-fixes-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/379f604cc3dc2c865dc2b13d81faa166b6df59ec

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

