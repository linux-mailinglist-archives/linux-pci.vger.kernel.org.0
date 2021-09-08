Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C15EA4041EC
	for <lists+linux-pci@lfdr.de>; Thu,  9 Sep 2021 01:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244979AbhIHXv5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Sep 2021 19:51:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:56536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233834AbhIHXv5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Sep 2021 19:51:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 7C4FE61157;
        Wed,  8 Sep 2021 23:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631145048;
        bh=TWceRenTLJ4V3ytpuHZj89ufyHnGipRz2CcEh1r9qgs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UtA+82g/0lsK40WpLpEVIg4pPxZ9YluV22dbrST2KVgGu1ph7i9g4La6zVddlrnpE
         Nfb/u7vJDGo0K+TJ+rpY+RrCI6tgzWSj8Ae2DRe2IS44PnH2QixBCnvIG3IUfDKRZI
         dTZhXxG+r81q9NRb8Cdpjh8Gj3Z85nMYsnlwAOjqfRtGh7F8+JJKhHC0UKcJ/svQW5
         3zTTHTYt9h2LrArGC1X53WzMhlhyiPwp6B79K6Vd9fA9I5yVadLSYzDFWJQ993ZIMZ
         Ng6sIumLhLwrDx1ixpTV7DfyAwYFiZ5IAnCn03OLi1yyRc6YOoPgf14ybThN9QNtmQ
         NMhvTqzFNQ1EQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6C71D60A38;
        Wed,  8 Sep 2021 23:50:48 +0000 (UTC)
Subject: Re: [GIT PULL] More ACPI updates for v5.15-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0isrxaOi_C50qO1S5t81xQZpnr-bunZp+Y_St+VuH6XxA@mail.gmail.com>
References: <CAJZ5v0isrxaOi_C50qO1S5t81xQZpnr-bunZp+Y_St+VuH6XxA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0isrxaOi_C50qO1S5t81xQZpnr-bunZp+Y_St+VuH6XxA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.15-rc1-2
X-PR-Tracked-Commit-Id: e543b10cd9d75309c820d2175200d09b2a62f249
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9c566611ac5cc7b45af943632f7a9b1b6a642991
Message-Id: <163114504838.23960.9468749259210760444.pr-tracker-bot@kernel.org>
Date:   Wed, 08 Sep 2021 23:50:48 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Wed, 8 Sep 2021 17:32:32 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.15-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9c566611ac5cc7b45af943632f7a9b1b6a642991

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
