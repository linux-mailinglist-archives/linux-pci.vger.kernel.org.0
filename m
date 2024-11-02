Return-Path: <linux-pci+bounces-15823-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF409B9C11
	for <lists+linux-pci@lfdr.de>; Sat,  2 Nov 2024 02:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B429E2829E5
	for <lists+linux-pci@lfdr.de>; Sat,  2 Nov 2024 01:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C866212EBDB;
	Sat,  2 Nov 2024 01:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bxj6Yw+M"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A283B85C5E;
	Sat,  2 Nov 2024 01:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730512042; cv=none; b=ssoZ+6atiy9WurYd/Wk47FjYVUapxoDIaDJqUbBzhu1h89RHjjPYtgETpmT98MUHGiEQtzsnDqPO3cVYu/7IbwB9zGzNiHTBEvmwJfbBEDlJzWdYjKop2hiDIfKZlErV74yAL2Oma8LRJgqmygWKq+IVeCV44UKuzFOu0qwE68k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730512042; c=relaxed/simple;
	bh=yf03dK76ukhgW3LBR4zrDYpap1swzr/pEOEpKZcL1vg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=cDVpfEmRCOlQ670Mpodwn5EiHQ+xWtBejVeC21eUD4iAAIDKLp2Z4e474+QmUp0dRPSezIL9P7a5Xe8ifaBIh4E79ug+LzEoIh1kKjI0GLbVmznz2PrAyT/eBJk+ghMJqWBc9VQi07nq81uE15MFzAHZZ8qPaJDaHj5iRFmdAac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bxj6Yw+M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B68C4CED5;
	Sat,  2 Nov 2024 01:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730512042;
	bh=yf03dK76ukhgW3LBR4zrDYpap1swzr/pEOEpKZcL1vg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Bxj6Yw+Mep1X1fN7GyHa0u+/Y2uV7USH3H885INb8gyLWyAlcqWrZvQSO5rv/aYkA
	 PuT6ZycK+AnJ6ZWfUSV7hWamK4ryFSaGWPseuq2R5Q9h0+WkfBrw0WeSf7ir85CXGl
	 Wtll+mFt3H8LtHdZ3yA0rXVabS/h211w9IUrrr/pbfhSgFzGmfkXudHFYGu7hRj9Mr
	 ZMmhNJG2IeF7o8ZwFhZCWlsWfpCEgC8RrNxliXcT2t+EoOrg4zGpRuMSErE/dTp8aY
	 HG27mZsCi/a/ma2MM+FmjjrWjjgV1ctZ7ZC71SBuys6o7g3wkU6MdZrJtLf4W6gqiH
	 Ku7bbg9zNLoLg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD843AB8A90;
	Sat,  2 Nov 2024 01:47:31 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241101205109.GA1320603@bhelgaas>
References: <20241101205109.GA1320603@bhelgaas>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241101205109.GA1320603@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.12-fixes-2
X-PR-Tracked-Commit-Id: f3c3ccc4fe49dbc560b01d16bebd1b116c46c2b4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 05b92660cdfe53a49425467fa64b5ac4451a7f9e
Message-Id: <173051205047.2889628.12349701637057271956.pr-tracker-bot@kernel.org>
Date: Sat, 02 Nov 2024 01:47:30 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Jason Gunthorpe <jgg@nvidia.com>, Jiri Slaby <jirislaby@kernel.org>, Steffen Dirkwinkel <me@steffen.cc>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 1 Nov 2024 15:51:09 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.12-fixes-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/05b92660cdfe53a49425467fa64b5ac4451a7f9e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

