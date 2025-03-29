Return-Path: <linux-pci+bounces-24970-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A48EA7541D
	for <lists+linux-pci@lfdr.de>; Sat, 29 Mar 2025 04:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A09A61895D72
	for <lists+linux-pci@lfdr.de>; Sat, 29 Mar 2025 03:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865A82AF12;
	Sat, 29 Mar 2025 03:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mAXd3LS7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB3C23774;
	Sat, 29 Mar 2025 03:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743218674; cv=none; b=DvIBoQg/zPqO0qQsAQCiT0sT2arQekg9WIu7SEYiHHMw29wuT/wwZd48nsld6CQuOzd6IBpSD96MNF+UE/wgfBfHXq/lrCVKuUnKlKx9d1AQJmDRGHQAb5ND4Q0Nwp9ZqwbJSNF/5ZQTCH5kfLy3r8EhnGwzzL+n+LeRpnD7y1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743218674; c=relaxed/simple;
	bh=tcp2K/tv+kU6UvXNkQlqZQ3LMC/1SM4Y78TnXI/ei48=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=XK6FnT9x4ePJao0LpNB5izyyvbCU/6t6Qe07zr/IYPIKClKbSnMSGW/k/X/a8rfwQ797fqhvDs4Lje9qTlTZasK7PY133gZGzYMkuqwIaRey2nj6dVM9655M03PAQYZbnR9fgBEKsZIaHpRMJPq0s06+VtSmOdYXjInf/Xxl2kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mAXd3LS7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA88C4CEE4;
	Sat, 29 Mar 2025 03:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743218673;
	bh=tcp2K/tv+kU6UvXNkQlqZQ3LMC/1SM4Y78TnXI/ei48=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mAXd3LS7sR3AywWuc2ONT0ujXulws2qOB5TA27JY5Rv3GFgBJ0PFUoI0m01l5Y5Ij
	 EJQ98G2ISuqTgIsxnRwnjTxoEE9rYLNkZEhHY4maWXHJlvojdBRSFk79+QRN9HvZsm
	 OYy0FARUFTQK+mkF+W22F1x4qBGU8pCRW7tSuaCEM6RNjwAnehuQFRItf4xlZ2N4JX
	 unaIXbbEKgGd+4bD9NmIkjyf0KMDJqcKi0pP8Rk60cvpbmyHWZ5sF3mO667CLkiato
	 iaPYgGZpiA4nyQjrl5jCBFmFJWZ2SPSDMvdyjOC1l/b7RVzqNmaH6gscI8vU8IN4ee
	 /J0gjbuP1LYRg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71024380AAFA;
	Sat, 29 Mar 2025 03:25:11 +0000 (UTC)
Subject: Re: [GIT PULL] PCI changes for v6.15
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250328150308.GA1504545@bhelgaas>
References: <20250328150308.GA1504545@bhelgaas>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250328150308.GA1504545@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.15-changes
X-PR-Tracked-Commit-Id: dea140198b846f7432d78566b7b0b83979c72c2b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7d06015d936c861160803e020f68f413b5c3cd9d
Message-Id: <174321871003.3067838.16190207142048549199.pr-tracker-bot@kernel.org>
Date: Sat, 29 Mar 2025 03:25:10 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 28 Mar 2025 10:03:08 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.15-changes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7d06015d936c861160803e020f68f413b5c3cd9d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

