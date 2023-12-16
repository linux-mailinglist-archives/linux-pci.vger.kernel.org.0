Return-Path: <linux-pci+bounces-1088-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C70F181572E
	for <lists+linux-pci@lfdr.de>; Sat, 16 Dec 2023 05:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A8181F25640
	for <lists+linux-pci@lfdr.de>; Sat, 16 Dec 2023 04:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B87DDAF;
	Sat, 16 Dec 2023 04:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZicD/w+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E1C125B4;
	Sat, 16 Dec 2023 04:07:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 97E56C433C8;
	Sat, 16 Dec 2023 04:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702699641;
	bh=3u1wKpYl5XzL9MgVlhlIDf6uCn2yok7GCLz8x3NPSG0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=PZicD/w+LWN5rr8yrYIBczZXn5JIXrFajyTH/rlBFC1G81mY7eJNZMnvMPOFwsVYH
	 9os30CbfPEdadyqd4M+t1lsm1EFSpHVydE1GZ4vhSIXOwyco4pyFCf6S/R3QwKH7DK
	 a19OSXJy99K5ItksKbicBCNComE2w9neyONTtL1gN+B6tcKB3+cKuDHz9q7g7QOQYJ
	 f/Ncj3N7zyoSOzJnwNEd0brGixvr3lbtG7xkrnTohvoj5UAfN8XwnAD/ZKE80zcifr
	 HDp+24L4WOle8zfNJ8TcOZxxRXDhsdobqBnufGI0//jZS7UoNGWu/QfhqLsPanzp6x
	 n36oUZqn7zmtg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 83B1BDD4EF0;
	Sat, 16 Dec 2023 04:07:21 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v6.7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231215211115.GA1141361@bhelgaas>
References: <20231215211115.GA1141361@bhelgaas>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231215211115.GA1141361@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.7-fixes-1
X-PR-Tracked-Commit-Id: 5df12742b7e3aae2594a30a9d14d5d6e9e7699f4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2e3f280b24ea89f6f061c8b56771b06351c7745d
Message-Id: <170269964152.27029.3576696816284064330.pr-tracker-bot@kernel.org>
Date: Sat, 16 Dec 2023 04:07:21 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Rob Herring <robh@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@loongson.cn>, Johan Hovold <johan+linaro@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Igor Mammedov <imammedo@redhat.com>, Fiona Ebner <f.ebner@proxmox.com>, Dongli Zhang <dongli.zhang@oracle.com>, Jonathan Woithe <jwoithe@just42.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 15 Dec 2023 15:11:15 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.7-fixes-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2e3f280b24ea89f6f061c8b56771b06351c7745d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

