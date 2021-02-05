Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95196310157
	for <lists+linux-pci@lfdr.de>; Fri,  5 Feb 2021 01:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbhBEAIg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Feb 2021 19:08:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:54356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231366AbhBEAIg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Feb 2021 19:08:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 1CE7A64FA9;
        Fri,  5 Feb 2021 00:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612483675;
        bh=jNLmguFD8+tZi/lXe+zyo/f8aUtFwVfL6qWf1YCn6KQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BL/7HOqloNcbK+9l/KAeDZyryyOeXnvzxgs2kz18pQGVsmhTtsfTFdgDTUZmGJ1sl
         dSvtW+yKyfg1Z/j7N9kAlPbGOhCUlhThHtMo+9jR0avo933pXBeKo/joAdiKezHIKe
         BhsSzr2lFnr49xKnZrmC1gCv+OFTs5s6pcBJVDitPdhD07eTycc6kCkwCyK9yoIHg3
         YpBiG3pYmGfpPLgcw3negzJ7zFV1gi8wgd3qq2w4auotFtsn7hHDysM2N/nOIq62eR
         HNZqha+gBV0Qog7ArW+lOirs2V3XxHQ4ERIxCyS/FBHIN6o/1EXIgZS00iEhNX/pBF
         eqpgV8Vae1Wvw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 08689609F1;
        Fri,  5 Feb 2021 00:07:55 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v5.11
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210204230058.GA124906@bjorn-Precision-5520>
References: <20210204230058.GA124906@bjorn-Precision-5520>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210204230058.GA124906@bjorn-Precision-5520>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci-v5.11-fixes-2
X-PR-Tracked-Commit-Id: 40fb68c7725aee024ed99ad38504f5d25820c6f0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dd86e7fa07a3ec33c92c957ea7b642c4702516a0
Message-Id: <161248367496.10625.109166622431095088.pr-tracker-bot@kernel.org>
Date:   Fri, 05 Feb 2021 00:07:54 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        "Kenneth R. Crudup" <kenny@panix.com>,
        Vidya Sagar <vidyas@nvidia.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Thu, 4 Feb 2021 17:00:58 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci-v5.11-fixes-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dd86e7fa07a3ec33c92c957ea7b642c4702516a0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
