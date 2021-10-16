Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E43B4303A6
	for <lists+linux-pci@lfdr.de>; Sat, 16 Oct 2021 18:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240647AbhJPQZ3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 16 Oct 2021 12:25:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:59386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240673AbhJPQZ2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 16 Oct 2021 12:25:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 95C866108E;
        Sat, 16 Oct 2021 16:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634401400;
        bh=RYR4OoeLbLWjD48Y+NDNZ2TZhnzgSmDN3Tq3+mVe5q8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mJ35tSv37M+SuJEOxM8ZAJ/yCJd0HtW8eWyLQZmD83Uzp2JGKEsS9vjd6R3LLa6/W
         auOYEablFQAcfiWI5sMMQAiEAF20egjXir7afHOR5cyoDt4qLnNTDXlcuUv57tawO+
         EBZqdoQnehZp5Rab6bCZo9v7syoS+tA9VR20IcfQRi2Z8LdUiEBBD6pKT5zfCb6YmU
         TNXnXDrKTqTdMPz76THzX8iVy3YCg2W9onjhIj4UdJ2ytcDGGyrldzy5+1Z+e4EHa1
         BKNY+dZ/Se7Nt8iT8ag3DpuiST09i3IYDDapistHcckv9GsFkQRD2ixJuXCgI+0W7O
         /iR2kwEJ+Jgxg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 85CC460A44;
        Sat, 16 Oct 2021 16:23:20 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211015195208.GA2151683@bhelgaas>
References: <20211015195208.GA2151683@bhelgaas>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211015195208.GA2151683@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci-v5.15-fixes-2
X-PR-Tracked-Commit-Id: 2b94b6b79b7c24092a6169db9e83c4565be0db42
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5a7ee55b1fcd23ebdb740fde9f4d795fff1b7443
Message-Id: <163440140054.26929.12288549816281766568.pr-tracker-bot@kernel.org>
Date:   Sat, 16 Oct 2021 16:23:20 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wang Hai <wanghai38@huawei.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Hulk Robot <hulkci@huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Fri, 15 Oct 2021 14:52:08 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci-v5.15-fixes-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5a7ee55b1fcd23ebdb740fde9f4d795fff1b7443

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
