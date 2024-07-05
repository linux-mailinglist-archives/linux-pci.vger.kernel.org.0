Return-Path: <linux-pci+bounces-9857-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA87D928DD8
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2024 21:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83FAF2824BE
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2024 19:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F00176229;
	Fri,  5 Jul 2024 19:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWZ/EcIn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20051175570;
	Fri,  5 Jul 2024 19:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720208279; cv=none; b=cc/R4yv64gLEmvkxQ3fjT/tlhy6hnHrWW9eCelJk+AtDtwWtZZWF5vci8KwbUXOSvF9qr1oKHv05KiwgAfNCYSEAHhm0aJ8Ny51rZXO3mHqGHYlRiWOBBN8HUY5CtisqtYcowhFSTXyvjEaerKAKUa9mfNK9lAhnW31smY51kbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720208279; c=relaxed/simple;
	bh=enq6c/A9Zmuq4E6QVo125fBwI0H/UY4d1pnIRyJQffk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=fJDDIFox2hgMhMYjOzUfxeF3KqQUvmsD/P1d8aBiWM6GJL6iejvGpKQAoWTsMXiXt/T+fOkqcZK8Q8NOX7iJhl5e24uA69gYPEyUef3guizWlEortoBhSmAT58GYK7wrQjAuzSp4urQ3n8LSi9Gvg3pjnAIEniOTm2/1kkl8SkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mWZ/EcIn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC899C4AF14;
	Fri,  5 Jul 2024 19:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720208279;
	bh=enq6c/A9Zmuq4E6QVo125fBwI0H/UY4d1pnIRyJQffk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mWZ/EcInwbz09pxTDJ1+Egih9HclFpH1TB74O1EZq6N8D5QoPjKo9NDAweoeuCpoj
	 oLm7PhzDaftaAfz9cvUwxWV1NPKZ9iiBXGyhupXhXCksaZzupRlCDQ4OuXkLweM7mm
	 6y2s68l3u9xeSl1+YctkNmo+YAHeL+O2Gm6mLZPfr69VrjYHwImq3upCh3IV97JxXo
	 +eyS/PgtKU1nKblvGD2lQos/67su19KxXKnf0qIR2Yr7ZTaHZiTxOZJUA5eAElktmV
	 SSYL0iXI457T53O9VTm80RPCOyDgt0F86fB/K3znnjplaxOQ5b7sw7C50rZ1iYbGrf
	 l1MI4F0c3ts1A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E2164C43446;
	Fri,  5 Jul 2024 19:37:58 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240705190513.GA72897@bhelgaas>
References: <20240705190513.GA72897@bhelgaas>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240705190513.GA72897@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git pci-v6.10-fixes-2
X-PR-Tracked-Commit-Id: 419d57d429f6e1fbd9024d34b11eb84b3138c60e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d270dd21bee023ab627f34cfb77a9b89a688492a
Message-Id: <172020827892.9250.4027681564754499231.pr-tracker-bot@kernel.org>
Date: Fri, 05 Jul 2024 19:37:58 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 5 Jul 2024 14:05:13 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git pci-v6.10-fixes-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d270dd21bee023ab627f34cfb77a9b89a688492a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

