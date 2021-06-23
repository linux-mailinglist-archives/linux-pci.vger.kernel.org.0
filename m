Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB3C3B1F1A
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jun 2021 18:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbhFWRCO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Jun 2021 13:02:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:45090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229523AbhFWRCN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Jun 2021 13:02:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 9989C61166;
        Wed, 23 Jun 2021 16:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624467595;
        bh=TB2KEifs1rVjgZ9TIFfmS63QCJs3CaVCD3ylzqkt0c8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=n+KamRdzrHfL97F4633IODvPiQlUJUjhOt3Y/wDDb100Qjy3iciUDdhDFnLSYG7YQ
         6qzAHMiEkcjcpRs14Eet/jpQ5BdHgq/LXNSMYR7jT8CSJvUuAvx7XyAe+wR5JRgDS6
         QWbq1ZclDUTiHNDyGSimFkV3NcuzaA5PVTs0+PcKmbPHeDmwdptAbXeHBR3wYb/yi5
         X9ocBYSu+KnArR94qLzJUZD8XNFvS9WMdhfui2s8Wujc3hVtakeuYowYWaacdCcqw+
         5nQoQ9Xnc9zyqBPbs+dz5TCAl4HG54pFM047w1b3+Qev1txRcUDSUPS0RCw/xQMc3H
         UNNHEw3JWKCCA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 88758609AC;
        Wed, 23 Jun 2021 16:59:55 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fix for v5.13-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gcogmEi_-wcycEv77443_LT9w-7Ln_x1eiBm=mPiX9hA@mail.gmail.com>
References: <CAJZ5v0gcogmEi_-wcycEv77443_LT9w-7Ln_x1eiBm=mPiX9hA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gcogmEi_-wcycEv77443_LT9w-7Ln_x1eiBm=mPiX9hA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.13-rc8
X-PR-Tracked-Commit-Id: 4d6035f9bf4ea12776322746a216e856dfe46698
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7266f2030eb0e17c442aa6cf527263828eed79bd
Message-Id: <162446759549.29722.17202056975267179567.pr-tracker-bot@kernel.org>
Date:   Wed, 23 Jun 2021 16:59:55 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Wed, 23 Jun 2021 18:20:54 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.13-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7266f2030eb0e17c442aa6cf527263828eed79bd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
