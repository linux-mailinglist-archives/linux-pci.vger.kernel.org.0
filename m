Return-Path: <linux-pci+bounces-33320-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD41B188DE
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 23:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4AEE3B4D4A
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 21:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9A3290BBD;
	Fri,  1 Aug 2025 21:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRIpdKor"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8914328D8F5;
	Fri,  1 Aug 2025 21:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754084233; cv=none; b=pHHY+yQvcttLNYggVvK1HT5VdorARndvnnlJ+G/RD6Fz8v6aMNeztau2VmN6wFzZCFTgS0braKITiWulOm3OOmM5m9BDPB0EOEeTkJFmEyvKgfc9V21EM7zPD2I+QSUu0Ac7X5c6oxy0JGm8r1kfUR+18Cd5JrDJYjPDUawdA2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754084233; c=relaxed/simple;
	bh=VvuGk48h3/PTybGBp1ALHCnf1eSgxTZ3v7EP5XZy3A4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Q64vHLqbV7uRP8tU+YXFOl5xFsKtscqVbb8oXc2/DRmFi33CNDKawjCTf5ZeievqyKny4fCW7dAogWwo3oxIDCqA49gsL4Yx54sXhljvTNANkdwBwUOHFEcK2M3790pnEqXBxc37SPJ2ZalvU/DBQkJGHAf3VWH9QRgcTymuwLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oRIpdKor; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A13BC4CEE7;
	Fri,  1 Aug 2025 21:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754084233;
	bh=VvuGk48h3/PTybGBp1ALHCnf1eSgxTZ3v7EP5XZy3A4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=oRIpdKor6Ve37+jkS+xf6TJ0Lrn6tX7wmRsgbsdqUIcqbI/1Gtn5cbZdqGxh/pzUV
	 9a1sifTn5iPVRhwyRN4ErdfitF6i5hiIh3yLXkl4GXXCpG3Gnp9EwZU3c8zNbKr/mx
	 VbZ75dcM4tFlMWZmKdlaN6jc/0L/MwDn/gnAB1gsw4+qRCUS2XrBr2BGrZwXR00Ihb
	 obDwOBAF7lnmws8myfm3/4G9gn1wOqbhS6vH+NkqcXH2CwRwzaX838NOQCHS7MSZAI
	 6cHkrztuJiR+XT/6ZetQWpoxueK3NZsDLFqJZdExsZXA0qSmUDdCTlMf38yvws48AZ
	 SgGme5NuYnCxQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB68B383BF56;
	Fri,  1 Aug 2025 21:37:29 +0000 (UTC)
Subject: Re: [GIT PULL v2] PCI changes for v6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250801142254.GA3496192@bhelgaas>
References: <20250801142254.GA3496192@bhelgaas>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250801142254.GA3496192@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.17-changes
X-PR-Tracked-Commit-Id: 58d2b6b6b214d8b4914cd4c821a8bd0c75436c2c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0bd0a41a5120f78685a132834865b0a631b9026a
Message-Id: <175408424863.4088284.13236765550439476565.pr-tracker-bot@kernel.org>
Date: Fri, 01 Aug 2025 21:37:28 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Manivannan Sadhasivam <mani@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 1 Aug 2025 09:22:54 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.17-changes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0bd0a41a5120f78685a132834865b0a631b9026a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

