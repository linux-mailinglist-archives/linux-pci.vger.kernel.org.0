Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 083AC427239
	for <lists+linux-pci@lfdr.de>; Fri,  8 Oct 2021 22:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242347AbhJHU2T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Oct 2021 16:28:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:55090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242602AbhJHU2S (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Oct 2021 16:28:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id BEA62611C3;
        Fri,  8 Oct 2021 20:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633724782;
        bh=ME2DJY5Ovvt154nTdfjp7jZE4e7kxW9afH7B9RjNa6c=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UpNmjSGdgU6GsHJt9jWMz3BbL2H6K12Adr5WbQcGqO54rpRDHCYS5G45IesLoARh/
         73qI/xqBMb0DK+v769nhuA+isbRFNiQX7+6LvcXOuzQkw8NaPY5DAmrKGEiVGhXe1J
         KcfSLJo8/+xLug1o9DNlGrRmwb74NcAe8GNd3YKl6rx3zUw5NCdzESf7GIKw+GCX1Y
         1O+DUSGVj1StxEkHvD8UrQsAhrDYnQYR2DPATyVt1oj1+WRdspkwLp0UkiXTog59Uo
         jFIdIUhAgN5VJkdqUXW2zRBMRsv3f1pp0DNxhsrBfccLAzaVFe8d8i+NvYqDO1iDpt
         Hn7Ivu2Xm/9mA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id B81C7609EF;
        Fri,  8 Oct 2021 20:26:22 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fix for v5.15-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gkdZRZRww8pXin+=xVQ+sCe-w7kS=NkFiSbcPSthTD+A@mail.gmail.com>
References: <CAJZ5v0gkdZRZRww8pXin+=xVQ+sCe-w7kS=NkFiSbcPSthTD+A@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gkdZRZRww8pXin+=xVQ+sCe-w7kS=NkFiSbcPSthTD+A@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.15-rc5
X-PR-Tracked-Commit-Id: 3fb937f441c64af1eec60bfd3732f64001fcc534
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cdc726fb35ede5dad4ae362e35f3ee5507299030
Message-Id: <163372478274.4543.11118823565336098167.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Oct 2021 20:26:22 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Fri, 8 Oct 2021 19:38:25 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.15-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cdc726fb35ede5dad4ae362e35f3ee5507299030

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
