Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C09973C3645
	for <lists+linux-pci@lfdr.de>; Sat, 10 Jul 2021 21:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbhGJTLb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 10 Jul 2021 15:11:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:56488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229652AbhGJTLa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 10 Jul 2021 15:11:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 6A42B6135F;
        Sat, 10 Jul 2021 19:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625944125;
        bh=1dcQ3bsc224Yww/7bR72g0x+lCZqr1o2XXQNy2c1c8Y=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NQe43PGy27fcjbG+kCO/ktnpUK21+Uyu4i/WiXzrxZJ5Et8jC1AvEGc3C1TPwpnQI
         Ci4veKwIVdOqzc4Wft+a4BroVqDmKxgWgtVKwYtaBPEiKptlKBHzxvb37Fpcc3y2Q6
         JVbMieHPLZTfQpgk8Uhn5qWhlBfr34odG/2Szo8S7hNSrQILCLoR+fjk30kB5OC+63
         1Kj135FBt5TYhXSZV4PgcxAi4YBI9IbkLZngd9YDVZo5O1kHfronV7Ez0S+CAXoyYr
         3KtOj9FeTxujj9fd3AT1UgTl1oDNfXe3FWC9EY2ZcXhFhGnMbyYaYsjYTwTvwzj52i
         fGF5jmEK/vgPw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 635F160A36;
        Sat, 10 Jul 2021 19:08:45 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210710002245.GA1190136@bjorn-Precision-5520>
References: <20210710002245.GA1190136@bjorn-Precision-5520>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210710002245.GA1190136@bjorn-Precision-5520>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.14-fixes-1
X-PR-Tracked-Commit-Id: 62efe3eebc8bfc351961eee769a5c2fc30221451
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 67d8d365646217225b458d90234f332e8d41f93d
Message-Id: <162594412540.8052.10406577944726862262.pr-tracker-bot@kernel.org>
Date:   Sat, 10 Jul 2021 19:08:45 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Fri, 9 Jul 2021 19:22:45 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.14-fixes-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/67d8d365646217225b458d90234f332e8d41f93d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
