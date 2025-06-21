Return-Path: <linux-pci+bounces-30296-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46898AE29F1
	for <lists+linux-pci@lfdr.de>; Sat, 21 Jun 2025 17:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4393F17765D
	for <lists+linux-pci@lfdr.de>; Sat, 21 Jun 2025 15:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B3E21FF28;
	Sat, 21 Jun 2025 15:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sOS5B8XX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0ED721FF21;
	Sat, 21 Jun 2025 15:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750520816; cv=none; b=qorQW6dovwNJalbb6neknZ8e286AwSOYQMDvXPWOwUIOX2XA36fkU+76u7s3SqXK0dChqVBINYOo8oLcwO4qB6ZkOobu/uB0u/Zxq8RuM7pt4nil5MXs77vIVPlaKPK5l19/cJBMXV/dY1DqbIMRh0+VZc4fA2AYkKrgxH5XQK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750520816; c=relaxed/simple;
	bh=bORCRbQdxyZEqBTeXrTdZOP0t84f5NHAiGR8pXOjMwk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=puFRgYuh7Bt+lWBGM3iobNBjGQdUr4ubRrplxt4lezZxIgmLxe+pK2lSf+tcivlUUFUGRAOpPrSFu9J6z7l1jXQ/DoVQlWPYB0JjSI7PzuP06riUkielaGCkLd19p+5eUAnhd6aPVTAYWO4qVpg7gRpkX4YzZLIMQOStzNbwxFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sOS5B8XX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBB44C4CEEE;
	Sat, 21 Jun 2025 15:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750520815;
	bh=bORCRbQdxyZEqBTeXrTdZOP0t84f5NHAiGR8pXOjMwk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=sOS5B8XXkyV0DhYzMBU+cX8Q6auU+gY9FcIYvid+J41qucMu44MJT7+q1f3w0kBOM
	 0ccF9rP+tWS6CpbOw/r8/iyVJPi9mv5CqKXz1Ex4BAFrlsm9iCWeSIuCmfMn/l2ShO
	 fdy2SNT2s1XsOTqmLw+rTidtxRKCXfyBOxjsCRzkre7u32UZHLoMTYLGq/PaZI3Nsg
	 Oinbrx+ipdtsZ3qAtTk3/IAjUG1PXemTVH+wkzXy4ybVbScdp1kMuG9LqMcTkrby31
	 5UAZgaJ56dUYx8i7qnOsP42Xkn2xADzDkVMX8dyp83T1Yzhma2b/Fpv1AVqcFFpaDp
	 6SgnoIiHI2Fpg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADBE838111DD;
	Sat, 21 Jun 2025 15:47:24 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v6.16
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250620194947.GA1311741@bhelgaas>
References: <20250620194947.GA1311741@bhelgaas>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250620194947.GA1311741@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.16-fixes-1
X-PR-Tracked-Commit-Id: bbf10cd686835d5a4b8566dc73a3b00b4cd7932a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f0eeb5f6f645d13446649b226b1dc026bab418ed
Message-Id: <175052084343.1887408.5355121916814478908.pr-tracker-bot@kernel.org>
Date: Sat, 21 Jun 2025 15:47:23 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Lukas Wunner <lukas@wunner.de>, =?utf-8?B?TMawxqFuZyBWaeG7h3QgSG/DoG5n?= <tcm4095@gmail.com>, Joel Mathew Thomas <proxy0@tutamail.com>, Mario Limonciello <mario.limonciello@amd.com>, Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Nicolas Dichtel <nicolas.dichtel@6wind.com>, Alex Williamson <alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 20 Jun 2025 14:49:47 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.16-fixes-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f0eeb5f6f645d13446649b226b1dc026bab418ed

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

