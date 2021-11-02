Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B88184439A8
	for <lists+linux-pci@lfdr.de>; Wed,  3 Nov 2021 00:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbhKBXaD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Nov 2021 19:30:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:51650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229747AbhKBXaB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Nov 2021 19:30:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 1B17F60EB9;
        Tue,  2 Nov 2021 23:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635895646;
        bh=+zP3aXeZUnrEHWlfJCQ0jXmyDaxPAiLydng20BVxsDU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bphAaV0L87flv9TU2MN/oKhkXhAGgMobboPOO2madO1hnMebEtJwWkyFY9iBhbLzU
         ot8hem09SoGiJ3NiZx1wtLv1PX25oE2aIW63WdpjK7c6Tv23JCWBLFKPiImtNSCAdf
         fo1zFM4gcQjqtasMIIsoxP7XiASb65UCTNOoDj4GTg5sNWRiWWRYvgPbaCE1GJUg5X
         nUqQcnD5ALDAxyQc7N9cjLo/ASg8XOS9cX4YH0dxy6HVQD9y2PK3UZkOB67tRTN46e
         siABbk8dL2HUikKwvmBVr/t1f7UzKmBJRsG2cK6koEwq4cd1jPKNdiOlgiuKsF/2e4
         36VpzRbNtpuFw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 060C6609B9;
        Tue,  2 Nov 2021 23:27:26 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI updates for v5.16-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jT44cw=Ls=imqBs1ErO60tbeDnOhD-wGPjPe9L=aa1=Q@mail.gmail.com>
References: <CAJZ5v0jT44cw=Ls=imqBs1ErO60tbeDnOhD-wGPjPe9L=aa1=Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jT44cw=Ls=imqBs1ErO60tbeDnOhD-wGPjPe9L=aa1=Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.16-rc1
X-PR-Tracked-Commit-Id: 90e17edac46882ee5fa4dfb6a72956b89dd188f3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c0d6586afa3546a3d148cf4b9d9a407b4f79d0bb
Message-Id: <163589564596.24792.10451054427710528764.pr-tracker-bot@kernel.org>
Date:   Tue, 02 Nov 2021 23:27:25 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Tue, 2 Nov 2021 20:51:24 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.16-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c0d6586afa3546a3d148cf4b9d9a407b4f79d0bb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
