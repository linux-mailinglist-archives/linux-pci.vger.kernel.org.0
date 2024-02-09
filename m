Return-Path: <linux-pci+bounces-3297-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A47684FC36
	for <lists+linux-pci@lfdr.de>; Fri,  9 Feb 2024 19:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D05921F23BF6
	for <lists+linux-pci@lfdr.de>; Fri,  9 Feb 2024 18:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BAB8287A;
	Fri,  9 Feb 2024 18:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PfYv6V4H"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAA933CF1;
	Fri,  9 Feb 2024 18:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707504381; cv=none; b=n1gkvq+zmPI97TUbSRZCMocZL6FRit7ywBijXrEhTNdD5MeQ2OfJEvC8RzF59GBY1qNFwocYfNfd3ZQS0Da8G3my8QJbpTh83mDZvuYSKgV9NxTklwU3i/NLWVj7XCxv9VfX+oikdrWtQO7L+ln4L4QblcqUd2JGZC2N5QHNrxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707504381; c=relaxed/simple;
	bh=mdYJJbr3Ndg/8K08UB1ewtnOQv0wFZNmoPn8cCYIn5M=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=PVJv/xwjP8fa5E2Y3i2hv+HvCVsTTY4V2NXbvsUPDENeQu+Q7Em9fl+U7aFoF9fR72zosd0IuMmuPEXqWCTDJKbcqIauTDJs/iqXyNN0qrE6ZcYlv7mo8Iglh58OLCYCaAQjr+7mEY8aSB/JGlohG7V4Y43GQtecr9hlcDT3K34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PfYv6V4H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 53292C433C7;
	Fri,  9 Feb 2024 18:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707504381;
	bh=mdYJJbr3Ndg/8K08UB1ewtnOQv0wFZNmoPn8cCYIn5M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=PfYv6V4Hj3Qx/pd86ivceRtYBmrJP3N9Grs12VTLmtR8cNfJ1SQir/kY6hXF8ZN3y
	 6HGvXzEW0T+oiIJY2TEHw98k/mztE5RNEPaK1bKEYd/eRSGszRXt/9HXWttv2K4UvB
	 ctvU47yzARFJXzSaZfxKQU4waJ9XGyp2tj4FB9l/IRj3+ReAudgRCCyPXQGr4ycjlU
	 AS4ZhB0ITzADUDdqGxByuFZdCUhe1OY168Tv96j+fw/RjLhNj/mjsHebmLa1F5hbvy
	 DY5QpuYHN6fZ+dzY0Uf/T+7bXBlq+z+W9VYpF8wa1tAjClC4nloJFVU5MpnpBYEZlJ
	 YfMmSp1D8rvqA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3D45DC41677;
	Fri,  9 Feb 2024 18:46:21 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240209155148.GA1001467@bhelgaas>
References: <20240209155148.GA1001467@bhelgaas>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240209155148.GA1001467@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.8-fixes-2
X-PR-Tracked-Commit-Id: 67057f48df79a3d73683385f521215146861684b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5ddfc2460611567cea5ed097f9534e7e8e84744b
Message-Id: <170750438123.872.18260210502686359751.pr-tracker-bot@kernel.org>
Date: Fri, 09 Feb 2024 18:46:21 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 9 Feb 2024 09:51:48 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.8-fixes-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5ddfc2460611567cea5ed097f9534e7e8e84744b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

