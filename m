Return-Path: <linux-pci+bounces-20844-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B921BA2B66D
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 00:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 571E9166F5D
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2025 23:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE4722FF2D;
	Thu,  6 Feb 2025 23:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOxV7Awl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BA81A5B8A;
	Thu,  6 Feb 2025 23:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738883524; cv=none; b=BKN+qx5UwKhRcPZygPkqdR6JqmVpMDEGIHetGrwSPopQPDLVlM1K8IIN4y5xaVJY6EZ8FQZ+2IkdrNhHTl9tpyMDEC07wXCGtnvchhnQLrw0fTWJz17nVrYIY69KIaeV2iube9KbWuT7gL0SzquOAwnzriM8JsTOyfSedy37M7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738883524; c=relaxed/simple;
	bh=ZK/7DgiUCypzRJYLffPZjfN2UrT6nmKJM+6+XasLcyQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=bzG8JdzC38IzATIv21tGbRxtJqofjo+mGorSfPyBVNMWReu7FBZJ7rqlTRGf/peP5wBSnZfiKcwPIrJI9Ru2Jd2jIFIPKBn3HO2iDQXrFm6r5e/vJzTbprGRt8KtBxiuNKocINK3VqbhsZtYCIHbCL4ne1Ys8gTlEfqaiS1Af1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOxV7Awl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C1DCC4CEDD;
	Thu,  6 Feb 2025 23:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738883524;
	bh=ZK/7DgiUCypzRJYLffPZjfN2UrT6nmKJM+6+XasLcyQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=oOxV7AwlBsftJ5uUQDB46aYEqMiqyqU4bMi1M36R7JoggyAJQ+fCofDt+RIhqqvQ1
	 0wwXnt9ocyfzNWzf96rLikOmGd1gxS/uPnHlZa3soeuwDL+Ku+u4yvzfhZ1HBGOFw3
	 9C294a3eIbNqQurN+gmh8QR0C9r8uU7x0nx9ADyQohm0lMI8Tk6ZGTHTntXDpaOrLH
	 ml5LxOgq5kf/+l7Bv8sR7ZZrE8G26C7780jic8UDRRB6ue4aJ4tmsDzzWvGxK433Tw
	 LN57LwfnXoUmRyCrpR9L/rue8DMUC4CrKQC8UVqeJjoiENqUJQI1qbbLxHCYUieaF5
	 Eq8jw0xfPnbtA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 341F8380AADE;
	Thu,  6 Feb 2025 23:12:33 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v6.14
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250206194642.GA999100@bhelgaas>
References: <20250206194642.GA999100@bhelgaas>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250206194642.GA999100@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.14-fixes-2
X-PR-Tracked-Commit-Id: 6f64b83d9fe9729000a0616830cb1606945465d8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bb066fe812d6fb3a9d01c073d9f1e2fd5a63403b
Message-Id: <173888355181.1693200.6359934363919903996.pr-tracker-bot@kernel.org>
Date: Thu, 06 Feb 2025 23:12:31 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Robin Murphy <robin.murphy@arm.com>, Wei Huang <wei.huang2@amd.com>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, =?utf-8?B?TmlrbMSBdnMgS2/EvGVzxYZpa292cw==?= <pinkflames.linux@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Paul Menzel <pmenzel@molgen.mpg.de>, Tasev Nikola <tasev.stefanoska@skynet.be>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 6 Feb 2025 13:46:42 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.14-fixes-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bb066fe812d6fb3a9d01c073d9f1e2fd5a63403b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

