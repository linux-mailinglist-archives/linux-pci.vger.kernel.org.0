Return-Path: <linux-pci+bounces-32904-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C282B11439
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jul 2025 00:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20DAD1CC67DD
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jul 2025 22:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FF423ABB2;
	Thu, 24 Jul 2025 22:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qgaNBmkF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9B03595D;
	Thu, 24 Jul 2025 22:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753396943; cv=none; b=j5LiGz00zDUTohqdwkaIiAYZWS+Nz72Tvd8SCjoclffUcJjnLmX1VQr6olYfMkgBdt36L90HNIaR5V5e5N91ozZGxNjn4NE8/lhBu9AeqfKS/c+UBz+zEpebd2HQJEFHtjqv+lxQm9kzhL9vIRHwG7bqCFidb3CbSyPA0BuUfUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753396943; c=relaxed/simple;
	bh=kyaUc0YxRHWNhwRKUIjwnjMSiD8luSmM157tsQrBxdA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=dBe8j1c4YJQb77fXm2PYqfe8EXAO7NzYJdtDIM/QzsDcAwSP0FzKLeVk7YcoPoBM30LuSAH+fdhsIweqj4IDFLUamMBsTB5dcZdhUDd+qZ91npThjpfatvB02xeUgI+jBqIidR0tSbmH2Kwq/Yo/IyX2v/l/W2CA++hnffkjaNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qgaNBmkF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A38BC4CEED;
	Thu, 24 Jul 2025 22:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753396943;
	bh=kyaUc0YxRHWNhwRKUIjwnjMSiD8luSmM157tsQrBxdA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qgaNBmkFJfr9vLsL3r8eFNtu4lYulXUBdAsCcurRQ27/3JeVtoFGVeRdr4Lq+te8x
	 RSsZDBnI8cK8oiKk/2aADlpWew4pp2WYuSgrCDunb07k8i0XbwPYyfA1RguJL52NWH
	 8CNIB9SoeJOY51Qd6FzXLWSEBWikOXvhsFj2zeAPEwuyJqxXtMeO2d8kG+BkMARBu9
	 3ER8uigNA6UiPDD3B/RIhlAIDkX4V77VSHiRQEUmPQR+JoOQ9Jh7XpaQ/gLvy11bM2
	 SujP++quEJ1sjlvaqXyKAInTx5qL8I3Lbd4Ev09AYtfG2H8ifr1bokpZBQVowyYA1n
	 j+9Kw2RzmZltg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34DF5383BF4E;
	Thu, 24 Jul 2025 22:42:42 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v6.16
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250724221009.GA3059501@bhelgaas>
References: <20250724221009.GA3059501@bhelgaas>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250724221009.GA3059501@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.16-fixes-4
X-PR-Tracked-Commit-Id: 8c493cc91f3a1102ad2f8c75ae0cf80f0a057488
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 94ce1ac2c9b4925c39fc976dc3f4421fc9230942
Message-Id: <175339696086.2557347.17923563816988546273.pr-tracker-bot@kernel.org>
Date: Thu, 24 Jul 2025 22:42:40 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Jim Quinlan <james.quinlan@broadcom.com>, Lukas Wunner <lukas@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 24 Jul 2025 17:10:09 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.16-fixes-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/94ce1ac2c9b4925c39fc976dc3f4421fc9230942

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

