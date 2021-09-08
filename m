Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7DA40329B
	for <lists+linux-pci@lfdr.de>; Wed,  8 Sep 2021 04:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347136AbhIHC0j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Sep 2021 22:26:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:35310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345608AbhIHC0j (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 7 Sep 2021 22:26:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 0F2686103D;
        Wed,  8 Sep 2021 02:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631067932;
        bh=x5eJIw8d5pU1nHyQe8PRTorbBS4Wew8tnK31KU472kQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gUE3MEJnzsrsNpGbcdtofcsfglwV4S9G93oJgzfuIHA4lqBpn/qJgPQ2LD0dlLz5O
         46KuFpraEzZFvBZu2elSRIRYKNiYOoSq0wNC96AB7SN0WdNe2zJbpOtyOVf9nixYxt
         i1wW6CTsLWr/hY8U+l6bt46Bg5RUyts+YBtInYyyzqpm2qzrtrEQgoivKmE82ZyoiQ
         Gp3eiesrDA7SOGPalieIb2XcZOuSwiBbChLrAOgkFOBPMRHUZECTQgFnGq5V/atl3B
         ob14vtN1xYxcE+cNvwU3ZX1uJc/rRX2ZXXFybFvvkF63Jr/ghIgkkcitPFC31qvtMe
         6zCBaPmCXaB1w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id F0E33609AB;
        Wed,  8 Sep 2021 02:25:31 +0000 (UTC)
Subject: Re: [GIT PULL] PCI changes for v5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210907213943.GA822380@bjorn-Precision-5520>
References: <20210907213943.GA822380@bjorn-Precision-5520>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210907213943.GA822380@bjorn-Precision-5520>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.15-changes
X-PR-Tracked-Commit-Id: 742a4c49a82a8fe1369e4ec2af4a9bf69123cb88
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ac08b1c68d1b1ed3cebb218fc3ea2c07484eb07d
Message-Id: <163106793192.22425.9151403771501141128.pr-tracker-bot@kernel.org>
Date:   Wed, 08 Sep 2021 02:25:31 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Tue, 7 Sep 2021 16:39:43 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.15-changes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ac08b1c68d1b1ed3cebb218fc3ea2c07484eb07d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
