Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97BEE44DE6E
	for <lists+linux-pci@lfdr.de>; Fri, 12 Nov 2021 00:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234244AbhKKXZx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Nov 2021 18:25:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:40068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230131AbhKKXZx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Nov 2021 18:25:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 97AD361267;
        Thu, 11 Nov 2021 23:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636672983;
        bh=ENO8AQEnukGph4xnKsmEAMZANo+vLEmlxmcxLLgQ5CY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=i2E4JFbuEPhf0S1dqSAgQaCgLT3CAaJjSCuKHzduTpa0j2K5MO433olBnRxj6GzhN
         LWmM9NSdRGfNR2X+/uNTJkzBwkPCzgemtdS8oIBhDKYBifz5AH14e91LZJ9phqYn3q
         WuTh9y7+Sw8A4dUlhSZ1PJN6tVAvsMoAUdLds8/swKetdFNTwQL+fWMLmjtv7E+j9h
         s9oBBpZly85RYjNT6jP6sNfwb7VDiPt8XvdemoHEGl7tEhWXdxFPYWAjpgG0awOTW1
         5v8zZGq8+A7Aaq1NN7I/plj65gqm7bY1wPOAd/s40EMYeuPRhC7eAwktOCWi35XP2U
         ZniNwxNw0z7XA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 841E860726;
        Thu, 11 Nov 2021 23:23:03 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211111195040.GA1345641@bhelgaas>
References: <20211111195040.GA1345641@bhelgaas>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211111195040.GA1345641@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci-v5.16-fixes-1
X-PR-Tracked-Commit-Id: e0217c5ba10d7bf640f038b2feae58e630f2f958
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5833291ab6de9c3e2374336b51c814e515e8f3a5
Message-Id: <163667298347.23960.17167773583022894247.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Nov 2021 23:23:03 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Robert =?utf-8?B?xZp3acSZY2tp?= <robert@swiecki.net>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Thu, 11 Nov 2021 13:50:40 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci-v5.16-fixes-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5833291ab6de9c3e2374336b51c814e515e8f3a5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
