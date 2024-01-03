Return-Path: <linux-pci+bounces-1635-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A06EB8237C8
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jan 2024 23:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FD9E1F223C1
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jan 2024 22:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22D32032C;
	Wed,  3 Jan 2024 22:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/JOL9/g"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B374820321;
	Wed,  3 Jan 2024 22:21:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1F808C433C9;
	Wed,  3 Jan 2024 22:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704320472;
	bh=wOBZV3ibgSj8rsPL6O+JggixUHGy17B+e/eETzMVJT4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=A/JOL9/gMdAUxXr1IMLcr1lxVhv/cTlKGeUyR93aDy6r5cAepKKjAl9Y3Ge1fqP5W
	 FWeIb0xi6HBmNcIPi4grB/bPKhFX8o5g8qYhaATLagoBOiRQ16G6WkuqB9irzW1/Lm
	 O94+gMlC4BFscGfTnmw/qVhha9RsV3/kecy80/pgMtMAlLBc8TS89JygR5pST1oHnH
	 tmXLO89mu7XTvuRYgbczsWZIfi/0KxOEhD6g9FSJEHb7QC4iGf38zW8wkecmwXACcn
	 WBMKrFXYKUJgkZ8KpaqeTRH/LQZOeZceXGxneH+yVdjJg0CMK05F3kmco+y229qT7h
	 84vyN7a34RYXA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 093C4DCB6FE;
	Wed,  3 Jan 2024 22:21:12 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v6.7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240103221335.GA1797305@bhelgaas>
References: <20240103221335.GA1797305@bhelgaas>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240103221335.GA1797305@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.7-fixes-2
X-PR-Tracked-Commit-Id: 0ee2030af4e3e0a9cd26dfaa8c2f935beffa91d1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ac865f00af293d081356bec56eea90815094a60e
Message-Id: <170432047202.21817.14232662667208695983.pr-tracker-bot@kernel.org>
Date: Wed, 03 Jan 2024 22:21:12 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Rob Herring <robh@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Tom Joseph <tjoseph@cadence.com>, Michael Schaller <michael@5challer.de>, Kai-Heng Feng <kai.heng.feng@canonical.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 3 Jan 2024 16:13:35 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.7-fixes-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ac865f00af293d081356bec56eea90815094a60e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

