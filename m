Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE502E2D0A
	for <lists+linux-pci@lfdr.de>; Sat, 26 Dec 2020 05:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgLZEU3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Dec 2020 23:20:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:32832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbgLZEU3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 Dec 2020 23:20:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 6BEE7221E9;
        Sat, 26 Dec 2020 04:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608956388;
        bh=8dWhGGRA+w2WwX6UVwQ6xADnS9FzpGPLfAnM7yLBXgE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=O8qXh98jD4tOT8dQ01eDwX8BrpTY2TSG3tbaymnQLzYcju/pF/FBxxtcMkOIJTXF+
         xG7ILdwnthV95fnNOKbtijBmBpMp4RcxB2EbNMMm2IKYo0wDRSDEgrJYka5BNkx3JF
         mmAZMiMYtoAiaSuX/kz69qTiEBkJtGs16HGySJdEJ6K218y6srfWPJFO5ILla7GW4K
         ZuB8B1LFgL17LAmwgk9SAcbd4+XE8li/gCtNWlJ9P7BIIjFUfN7CRXHWCi3owFuNXZ
         I/0tWBWMPOWIzdD0Fg71W+xLMKBbLD1IMsn96XOoJy05U5thEAD68xiaDeo4+pkQ8y
         eIlyIL0cSf4uA==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id 575B9600D9;
        Sat, 26 Dec 2020 04:19:48 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v5.11
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201226041103.GA469463@bjorn-Precision-5520>
References: <20201226041103.GA469463@bjorn-Precision-5520>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201226041103.GA469463@bjorn-Precision-5520>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.11-fixes-1
X-PR-Tracked-Commit-Id: 99e629f14b471d852d28ecf554093c4730ed0927
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 40f78232f97344afbbeb5b0008615f17c4b93466
Message-Id: <160895638826.20546.14668267211736174159.pr-tracker-bot@kernel.org>
Date:   Sat, 26 Dec 2020 04:19:48 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Alexander Lobakin <alobakin@pm.me>,
        Mian Yousaf Kaukab <ykaukab@suse.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Fri, 25 Dec 2020 22:11:03 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.11-fixes-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/40f78232f97344afbbeb5b0008615f17c4b93466

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
