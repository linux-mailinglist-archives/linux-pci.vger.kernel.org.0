Return-Path: <linux-pci+bounces-20360-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA76A1C5FE
	for <lists+linux-pci@lfdr.de>; Sun, 26 Jan 2025 02:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A01D3167FC8
	for <lists+linux-pci@lfdr.de>; Sun, 26 Jan 2025 01:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A8E191F88;
	Sun, 26 Jan 2025 01:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8PWrpGm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08001917D6;
	Sun, 26 Jan 2025 01:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737853409; cv=none; b=QVygADUmibpHVNk7Ga8exu3CuXyi2H7RNdeCbNDu5B6CadH/Dm7NKWMcmj5QQN46JQf/Lv75ObeBINn8MQYYe4so55rt5HHaBEyWeQwHZc+3uGMHM/j6lRCbDH1CDsWSihsrFiZBkAeVHPyAMVXygHHSZJAgvb2GTVxS8wZB+C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737853409; c=relaxed/simple;
	bh=wgTJQ8s10/+PEMAST94/lTJT8sCEX5ErmLfppINuDA4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YsWuoOWuBgjzzsEqMw94uXIXEcIy7jwGrXWYDrixo/iD2rYr+Jv7hPXnk4+s905+tFXK05mG8UXYIAEMBn+AesTbRaAZjZmZ+1c4K4pYSN2YerFHMyUjTYLRFicByGCuk0shk8JDYX8WON58EepEdvPJQETZpw2YJtWu45pIjWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P8PWrpGm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C8EFC4CEDF;
	Sun, 26 Jan 2025 01:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737853409;
	bh=wgTJQ8s10/+PEMAST94/lTJT8sCEX5ErmLfppINuDA4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=P8PWrpGm+erFKo0N9586wNfXQi1FwfImpxVfR4WHL+q2PDPU/tMGS+u0F4YXJPEqP
	 yvvd8G8V7RVM1nR0O0+kSroUpEZAv1DcuUMSpuWO5tiVwk6IymL7JGdQSvvn2exEmz
	 DjIzaNpeegHnf/gV1qP8cV364Y2qAaU+ur2OhXZYpuaxZIJ+snX4u+dYLVBw/13zCW
	 3xZ8bE0SvQV+G1QeJhkvA6AQGw1elAvUsOj16HAjjB308s9Fq1CcqyzM332FvI7eyl
	 k8WM4rSMkqcpKueT3kU4CPt0+3oq+CjYHA8rpHQDQgYiYDeIvUCY1zyH4H2rwq9DQ0
	 PhQYIbN+mQk5w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE5C380AA79;
	Sun, 26 Jan 2025 01:03:55 +0000 (UTC)
Subject: Re: [GIT PULL] PCI changes for v6.14
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250124185734.GA1372974@bhelgaas>
References: <20250124185734.GA1372974@bhelgaas>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250124185734.GA1372974@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.14-changes
X-PR-Tracked-Commit-Id: 10ff5bbfd4b020e58fd8863e44ae59f0d4c337bf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 647d69605c70368d54fc012fce8a43e8e5955b04
Message-Id: <173785343451.2645989.18380120156682992708.pr-tracker-bot@kernel.org>
Date: Sun, 26 Jan 2025 01:03:54 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 24 Jan 2025 12:57:34 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.14-changes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/647d69605c70368d54fc012fce8a43e8e5955b04

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

