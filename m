Return-Path: <linux-pci+bounces-2304-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 248B18310CB
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jan 2024 02:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 464841C21AF7
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jan 2024 01:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B312D1C06;
	Thu, 18 Jan 2024 01:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U8z0YuMO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD59187E;
	Thu, 18 Jan 2024 01:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705540811; cv=none; b=XuR7XUUSVrvKP5NWTvMH0DsyfWkf0iqG9pjM1ITfrhwYPAzOXCCVpxtXhBzCXkQZm2x3VegyGtL4iad06wlkfZDljEc6Qa5NLW9fAlrGuNSXs2PLUibO4yY9/dpQCrYUOXANn1708uemVw/fXCsGqcW3UctLQeKFl+tZ8Q1jO4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705540811; c=relaxed/simple;
	bh=2iIAmdUSsRk6rmRZVREfsr3G2CXhJdyX72Vx6rnmdcc=;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:
	 References:X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:
	 X-PR-Tracked-Remote:X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:
	 X-PR-Merge-Refname:X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc; b=uhcVk+8NyeaGw0O38mYfp+xmWpCuqZAkSRkhY4iHAEKGpvMqILmuvtIgf7PoKTQuSkPf51JIEnjdbMYql0+uAtM4AFOxmTNFK5kgsDbHGQdaLsto7ATMKx5by2BcxH/Qmg/jj0iWwzywTLEycS6XjDw6IGvqxzH4Z1pD7dCBQEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U8z0YuMO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13FB0C433F1;
	Thu, 18 Jan 2024 01:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705540811;
	bh=2iIAmdUSsRk6rmRZVREfsr3G2CXhJdyX72Vx6rnmdcc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=U8z0YuMOGgY31YuwW1K6oYjibYJRI6nwYyYDAHBnyk3Cy5/lE9gUGRJZ/s0yg/7aG
	 Eg0338p3t9eVbmPQs+ubD4iwWkgaW7VDrum4roULTLNea/GJJ1WY98nPPw+lblxQqM
	 VzhUgVGK5+RygAW7zwJMEC6vxC54niIFOzLTHNeK5moSfPXIABQbWBnp8s+8U3wx4H
	 kfWxeuEuvYgGejPWrI+Dgfpj5klysBQ7LjJogos37q2RvWmDPSPYQGiMfx4LRzEX0q
	 n1QVFwt0xa6Bh2BiCtaDTdjFB8catkrldIsGDEaxtIppChfhpmlzJuoiT7T3AVinoJ
	 3LXZROgMiv5eg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F38B5D8C96C;
	Thu, 18 Jan 2024 01:20:10 +0000 (UTC)
Subject: Re: [GIT PULL] PCI changes for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240115225703.GA73226@bhelgaas>
References: <20240115225703.GA73226@bhelgaas>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240115225703.GA73226@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.8-changes
X-PR-Tracked-Commit-Id: 7119ca35ee4a0129ae86ae9d36f357edc55aab2f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e1aa9df440186af73a9e690244eb49cbc99f36ac
Message-Id: <170554081096.21862.13166270989994142545.pr-tracker-bot@kernel.org>
Date: Thu, 18 Jan 2024 01:20:10 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 15 Jan 2024 16:57:03 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.8-changes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e1aa9df440186af73a9e690244eb49cbc99f36ac

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

