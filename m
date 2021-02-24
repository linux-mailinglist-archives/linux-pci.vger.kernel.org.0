Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 350603243FC
	for <lists+linux-pci@lfdr.de>; Wed, 24 Feb 2021 19:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234536AbhBXSrL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Feb 2021 13:47:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:34182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233582AbhBXSrI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Feb 2021 13:47:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 5623064F0B;
        Wed, 24 Feb 2021 18:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614192388;
        bh=9biktzQADayIun6a+EnBTvkBSvdnAjQigj83Wz68Bkg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lwKvb1jc4aQU6E54cU0/rK180utsF/dCpPS12aHErAWefA9mGbeZYRBiSwZkkBrZi
         /IYOVPi3C/dGDk8D+6XJ3ip2TeBe2HFyKBHiCxNe4N8mVKRmZLyQCHM0yvw4dZ6YS5
         C2hvR0kaTdFtP2B6BAC9gEHoaJ9ghIodu9lM96aSFhkWaoegQy9tlkdc41kmvL6bCo
         QC13wpjsG/jCPz/xJt/krKtNWcoSSCa42OTswmcaAwzB28e+j/HufCAYEtns1G5tQ9
         /VqlESBL5L8BIrCtJnJWsCezcmcW8IvfzaFtqaolM8HWK5kiyuqqeqiCLPwtk+g8BP
         2ytzNneTJyRLA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 4FA3F60176;
        Wed, 24 Feb 2021 18:46:28 +0000 (UTC)
Subject: Re: [GIT PULL] Simple Firmware Interface (SFI) support removal for v5.12-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0j-pXGo4EFkwS23xWuhmw8ZgS8PPxE0NqQuj_3gzH+gMA@mail.gmail.com>
References: <CAJZ5v0j-pXGo4EFkwS23xWuhmw8ZgS8PPxE0NqQuj_3gzH+gMA@mail.gmail.com>
X-PR-Tracked-List-Id: <platform-driver-x86.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0j-pXGo4EFkwS23xWuhmw8ZgS8PPxE0NqQuj_3gzH+gMA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git sfi-removal-5.12-rc1
X-PR-Tracked-Commit-Id: c9c26882776a7adddb0173778957e690ac47b195
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c4fbde84fedeaf513ec96f0c6ed3f352bdcd61d6
Message-Id: <161419238832.20610.95673983797373463.pr-tracker-bot@kernel.org>
Date:   Wed, 24 Feb 2021 18:46:28 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Wed, 24 Feb 2021 15:59:15 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git sfi-removal-5.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c4fbde84fedeaf513ec96f0c6ed3f352bdcd61d6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
