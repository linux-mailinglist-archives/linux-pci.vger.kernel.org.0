Return-Path: <linux-pci+bounces-30983-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E89EAEC477
	for <lists+linux-pci@lfdr.de>; Sat, 28 Jun 2025 05:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F51B1BC6689
	for <lists+linux-pci@lfdr.de>; Sat, 28 Jun 2025 03:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6157521A94F;
	Sat, 28 Jun 2025 03:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o4C5hTqM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A60078F4C;
	Sat, 28 Jun 2025 03:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751081276; cv=none; b=I8BsKcbH0lcKQpCLNyATV2/WsG0DOuu0asL1we/quTias5JDsZ4ZxlqXzTFrumytBqekSLjbzkFZQIVk9IgTSBRDBEzu1RO+0/yiM0s8MtAJq0H6WeRPNZqORb3CcGyUJOS+6nBfhWhJ3PtJ10kNPW4zKuYt8biFm2aQL82t00c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751081276; c=relaxed/simple;
	bh=D2Ja0sBoUZLzSe79a0QRlWVmPVJj6bzc2cdNlvx0uio=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=N2gHqvuFQ2MxjrPmyJ9/q8iB5sqLvaJ5SyFxByOFgGzcMkhdaBZa8FaD9o769TYUe9nWPMsQ+dvQs/Njnzd+ITme4PbNR0qPuwPnhwkHyHwrZwXhN07j72lvgZixOzIEQuczvICnVYFXtYbJVD3WRxKGOyGIYrrZca/XgHLiPuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o4C5hTqM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 135E2C4CEE3;
	Sat, 28 Jun 2025 03:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751081276;
	bh=D2Ja0sBoUZLzSe79a0QRlWVmPVJj6bzc2cdNlvx0uio=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=o4C5hTqMEgpyJEf3YA4k60bjyv0jtDjZ3tI4le+BrCyixlKSzEG1fNKaBqtzbPLfU
	 xUegdv/VUQMBtPjhRdf6dcP7eAaoG/GviKFmIUc+K5wHTuWDzs4KUP9jH9gg5kUNM3
	 83v+HTSudvmDrPdnxLJl2ht7MarusF8N/62LgebuoSri6J5agkFAvBYoytRRvnciu+
	 qDdRkQ/wAOLlE1oWM4hB3JIE1XuZfpgVfvuSGfj9rhwxBrWRbaPlpARe42LeH+27FH
	 hwkchmJM+UQo2LcUc/ZeR53idv4Y+97YNjk69vgjwDgAGqmrtgWUy8II0Tw91EeWrP
	 wOBGRpmpe+sDQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C1438111CE;
	Sat, 28 Jun 2025 03:28:23 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v6.16
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250627202730.GA1683609@bhelgaas>
References: <20250627202730.GA1683609@bhelgaas>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250627202730.GA1683609@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.16-fixes-2
X-PR-Tracked-Commit-Id: 5aa326a6a2ff0a7e7c6e11777045e66704c2d5e4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fa33adcaf8af147f4238c84d76a316a47e43e091
Message-Id: <175108130183.2124567.6364679347598492053.pr-tracker-bot@kernel.org>
Date: Sat, 28 Jun 2025 03:28:21 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Eric Biggers <ebiggers@kernel.org>, Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 27 Jun 2025 15:27:30 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.16-fixes-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fa33adcaf8af147f4238c84d76a316a47e43e091

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

