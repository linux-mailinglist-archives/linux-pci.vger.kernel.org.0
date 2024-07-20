Return-Path: <linux-pci+bounces-10561-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E66937EE2
	for <lists+linux-pci@lfdr.de>; Sat, 20 Jul 2024 06:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40EFE2822EF
	for <lists+linux-pci@lfdr.de>; Sat, 20 Jul 2024 04:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6152322E;
	Sat, 20 Jul 2024 04:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vH8iopwz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFFFD50F;
	Sat, 20 Jul 2024 04:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721448113; cv=none; b=Z+Sr2QHcKNDuUMWSlsQF8rWmcsywZZTEOubI6EhFgj7SLvjjOcrE98lpWkjxiM7GVYUnFHHPWinRUmRXtc6ZcJzNDamKkc5s+IdPQdyG4TB9F5gIk/Ng6qihc6pVLP8TVTrGKt3XGw2U84NfpNDdnHFprnoEe/Nq1xjhfMrNZSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721448113; c=relaxed/simple;
	bh=O8rs9AUKGCGMRHdgSeel3BwU4fyso7HvNCUBJOKsFbk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=D4zogzGXV37ors9vYZpp1XoRKAE4gq4Rf6Miu+k0i4lXsBGmwC/u+piLPZ9OR6A1TjKkB22fdoeQ+8CLashJvYdzFTwRQy9/Xb+i/ReYo2VZRLEFJaZmHe2t/9I0X8GiLtAJbKW/RW8xifYrx1uuUgCV9v4s1MD69/Pn+KpU7sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vH8iopwz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 751AFC4AF0B;
	Sat, 20 Jul 2024 04:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721448113;
	bh=O8rs9AUKGCGMRHdgSeel3BwU4fyso7HvNCUBJOKsFbk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=vH8iopwzaV8tIXCcj9ddBsNIkb7I3JFkkYT/b24+JZGJYDKjP4wbV3tlQZTBQ5HoI
	 iz5XvjET0nk3lR/3/nzaWEnoSRACU/+v932GJ8WCB1UHO11hxvoYy0ZbkZ1CSGbHQp
	 6Kwa+HidrxoTlV33s1FUwTZWxL3QAs2pUoRavXkYatww4bK0RGbAWd0W18wNNNFAh5
	 LLXObgNCDwe9kjv8yfhfbRRHU5w1mtbQLWGn0w1m2IVJfRjw0XlVhYOq9Dk7yLWffa
	 8sa8FwE5LUb7d/iOR9hSAoD4mp8YxkiX71WNvoT8VESekRxwOg2cPOSssuZE+ugXRc
	 qZLY1NgQI8k4g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 69DFEC43335;
	Sat, 20 Jul 2024 04:01:53 +0000 (UTC)
Subject: Re: [GIT PULL] PCI changes for v6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240719224454.GA657774@bhelgaas>
References: <20240719224454.GA657774@bhelgaas>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240719224454.GA657774@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.11-changes
X-PR-Tracked-Commit-Id: 45659274e60864f9acabba844468e405362bdc8c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3f386cb8ee9f04ff4be164ca7a1d0ef3f81f7374
Message-Id: <172144811341.25819.5089141357087238880.pr-tracker-bot@kernel.org>
Date: Sat, 20 Jul 2024 04:01:53 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 19 Jul 2024 17:44:54 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.11-changes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3f386cb8ee9f04ff4be164ca7a1d0ef3f81f7374

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

