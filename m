Return-Path: <linux-pci+bounces-41280-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 803C5C5FA0B
	for <lists+linux-pci@lfdr.de>; Sat, 15 Nov 2025 00:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D3E84356AE7
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 23:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940612E0406;
	Fri, 14 Nov 2025 23:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNjCkzRz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A90735898;
	Fri, 14 Nov 2025 23:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763164429; cv=none; b=tFi5iEXutgGMRjBqR22MrH32SeNt/0XcO85ptx+3b6jpXS1QGgcNoVH0JQI87EhmkRyde5hcKZewxH/N5BnImiHW3rYZuwwaU0mvp+QpDMzVinaRdeYmdSkRpt807mpbblRkXZ4qHLVcHqZguLIOdjHHIvjghBiVNtFcFlUP7O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763164429; c=relaxed/simple;
	bh=Y+T8c1YmINJrU4C2k/nYgcXHTy7HRhPlKpNn+mG9VoE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=IE4zkiZJehxr5lrGmgy/JpfW3/7DCrwy+ZfgZyVvhp7RVKiUh5BvqLZWHfXOyhSdzoY3lhJZNNKN1EB68yQGVk89RzSLhHGfTIp0tH8SsenEcufmcplHCnDI+lhtnk/62pjjyB4N7nhO0c+WD02OjALKT0Zcy5mVdLGR6ZsKbuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iNjCkzRz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FF7CC4CEF5;
	Fri, 14 Nov 2025 23:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763164429;
	bh=Y+T8c1YmINJrU4C2k/nYgcXHTy7HRhPlKpNn+mG9VoE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=iNjCkzRz55SKhioD7KBxMWCD2efspYpbUC/oIKCjBdxFG7+H/HW8GCtUjPOynAFjr
	 7FfcbHfWe6RNZaLCMAXOlWpLmJi8U8/j70jIXvp7GuR1dRUK+Wr09ml95O1a1lSpzR
	 2fSUbI48Id+xcnNmniKPcqSdh7lUDA92ea9ctrZUimuH9goV+LVk+M5Mv+dkrhq5WR
	 YbXfQlI4fmHFF31aDjd+kZ/nE5He4sVRGBzKm7q4A5GrUIEzNrdSAcvrrCVmvvtByo
	 YlSWRi24CObaNHeotbSHNgrgvDPXRfjZbdZYKvPLN/WgPe1q5sbyErAPA+QM3txmIO
	 n+p4kG3phrBvw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE123A78A61;
	Fri, 14 Nov 2025 23:53:18 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251114222420.GA2346148@bhelgaas>
References: <20251114222420.GA2346148@bhelgaas>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251114222420.GA2346148@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.18-fixes-5
X-PR-Tracked-Commit-Id: 921b3f59b7b00cd7067ab775b0e0ca4eca436c2f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7a0892d2836e12cc61b6823f888629a3eb64e268
Message-Id: <176316439762.1879382.4119193063808876633.pr-tracker-bot@kernel.org>
Date: Fri, 14 Nov 2025 23:53:17 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>, Christian Zigotzky <chzigotzky@xenosoft.de>, Lukas Wunner <lukas@wunner.de>, hypexed@yahoo.com.au, linuxppc-dev@lists.ozlabs.org, debian-powerpc@lists.debian.org, mad skateman <madskateman@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 14 Nov 2025 16:24:20 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.18-fixes-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7a0892d2836e12cc61b6823f888629a3eb64e268

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

