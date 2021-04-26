Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6965936BBD3
	for <lists+linux-pci@lfdr.de>; Tue, 27 Apr 2021 00:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235573AbhDZWwN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Apr 2021 18:52:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:41988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234767AbhDZWwJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 26 Apr 2021 18:52:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id C400060FE3;
        Mon, 26 Apr 2021 22:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619477487;
        bh=Gr+9xNcXOfKgfJqgJX/i8LVqX5wv0wsXPLdQSO25qug=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=nOWbobEwFX1rFXrY/8I1+gTKhfkOGfqolC+yLfNUmsGmHpaYn/5xrN2cGZ194XR6X
         teOaGUu7G0qGP3M03sJRucYwoL/01jTiktMk68GmWKP1/FmTip7TF2ROL/UWO2I2VB
         /q2I2rdUddwfBurqr4hEJD2t9cBvUwsnpqpC1mYDQOOFTuXAsxdeHM0Bzg/L2PfKAU
         D+pnoPi+S/6l1bRblsiqgFhtbw9q91/DmXBTlucLtg/muDVDFsJ6xQpz2a0Ob+4MSQ
         BREKwpFHuJ129Hk/zO7YDIEKdZ6xr4PbKQkK3ACJ2HarQljo7sV6ynRmvLxPC9sq5g
         tF4EbIZ9PfNFg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id BCAEA609AE;
        Mon, 26 Apr 2021 22:51:27 +0000 (UTC)
Subject: Re: [GIT PULL] Power management updates for v5.13-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0iuTS8iDCUVQcqAB5N=8f6KkY00e-A+9Jtq7P3gzj=HmA@mail.gmail.com>
References: <CAJZ5v0iuTS8iDCUVQcqAB5N=8f6KkY00e-A+9Jtq7P3gzj=HmA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0iuTS8iDCUVQcqAB5N=8f6KkY00e-A+9Jtq7P3gzj=HmA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.13-rc1
X-PR-Tracked-Commit-Id: 59e2c959f20f9f255a42de52cde54a2962fb726f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5469f160e6bf38b84eb237055868286e629b8d44
Message-Id: <161947748776.6408.15220602274569744550.pr-tracker-bot@kernel.org>
Date:   Mon, 26 Apr 2021 22:51:27 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Mon, 26 Apr 2021 20:27:20 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5469f160e6bf38b84eb237055868286e629b8d44

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
