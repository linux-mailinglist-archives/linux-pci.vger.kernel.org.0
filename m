Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 218EE470B35
	for <lists+linux-pci@lfdr.de>; Fri, 10 Dec 2021 20:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243753AbhLJUC0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Dec 2021 15:02:26 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:40712 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhLJUCZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Dec 2021 15:02:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 89A47CE2D3A;
        Fri, 10 Dec 2021 19:58:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B27F3C341CB;
        Fri, 10 Dec 2021 19:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639166326;
        bh=mb3FCELhAh5n8VF9/m2Tf6l+OweM8BjE3YSv8aHsKyI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OoFWmoj3fl4meF0GHQSZle/FWjVKS0sAVZmIC0xAQPLPgRXD9Z0mZyFhU1EO7/ilw
         D7AvQBkCjUBM89rQt3wSbxKhZDHWPgfLtLmEuopBelpxsvpH2RhWv5jrRxm+eOpjCs
         nZwOQTV+pnKpQMXfz5SWdjjCoUEHEybi69ywPOtoHnjI9JTDV7YFC4LVjD+XpJT26/
         LRC21gMPQcVr94TJEeOscy344NNsoiu5iRcK7I0AITqRIq+HG2agnRRlekarxAuKx0
         plWSvDY3w/5WCKocWUaMs8HhiOYl7D3PTDeGiZH0c9oJdrM8BJ5cX5+Tc0f0UbYmCM
         7k8quSreFZAHw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 9F7E360A39;
        Fri, 10 Dec 2021 19:58:46 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211210164406.GA320857@bhelgaas>
References: <20211210164406.GA320857@bhelgaas>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211210164406.GA320857@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.16-fixes-2
X-PR-Tracked-Commit-Id: 87620512681a20ef24ece85ac21ff90c9efed37d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b8a98b6bf66ae35361e987333233d07241642909
Message-Id: <163916632664.27955.16039161675534314476.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Dec 2021 19:58:46 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Mark Kettenis <kettenis@openbsd.org>,
        Arnd Bergmann <arnd@arndb.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Fri, 10 Dec 2021 10:44:06 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.16-fixes-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b8a98b6bf66ae35361e987333233d07241642909

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
