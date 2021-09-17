Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1746D40FFDD
	for <lists+linux-pci@lfdr.de>; Fri, 17 Sep 2021 21:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343743AbhIQTbH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Sep 2021 15:31:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:58466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343751AbhIQTbB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 17 Sep 2021 15:31:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 452A860F9C;
        Fri, 17 Sep 2021 19:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631906979;
        bh=+PtFrtVDGamZu8i8tqw2cJyUDNj11YNwJZPZsX0uuW0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OIZuJr5NMY0BWNb/6k+w+Ytj3ee1cf9UjdJZ3kc2010b59LmqF7EAS/aXUbMVReVF
         eaJTHOoz+q+fSjsBMQSpSeIVGeb2vxlMKNCLu11SG/WrwYNdijPoTZun9E3SRYxz8v
         69zm8D7qTj+YcvAUDmGI/YZEplUB2I/PhooaSRd/Q3e2VZKenspvtRIMOOcc+lPCMZ
         NINQuAIhq7RX894fziW1ChU/vFmkS26qCKUnH20XF111+Nxvs0ifXzInu5PKM37BMd
         WEprgnBGbG5LkfzcGggcHcnZThy7Ri+FhguoPk+xABgnh4X/f+UkjC9M717J+Qu02U
         dFGqKFn3GFS3w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 3DE8460726;
        Fri, 17 Sep 2021 19:29:39 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210917151842.GA1716604@bjorn-Precision-5520>
References: <20210917151842.GA1716604@bjorn-Precision-5520>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210917151842.GA1716604@bjorn-Precision-5520>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.15-fixes-1
X-PR-Tracked-Commit-Id: e042a4533fc346a655de7f1b8ac1fa01a2ed96e5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7639afad8b8d6671a645fb3d6e6fd1432dcdf6ac
Message-Id: <163190697924.17353.27447357961674104.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Sep 2021 19:29:39 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Evan Quan <evan.quan@amd.com>,
        Alex Deucher <Alexander.Deucher@amd.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jon Derrick <jonathan.derrick@linux.dev>,
        Dave Jones <davej@codemonkey.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Fri, 17 Sep 2021 10:18:42 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.15-fixes-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7639afad8b8d6671a645fb3d6e6fd1432dcdf6ac

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
