Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE5FDC9B2
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2019 17:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409116AbfJRPuG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Oct 2019 11:50:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:42190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394076AbfJRPuG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Oct 2019 11:50:06 -0400
Subject: Re: [GIT PULL] Power management fixes for v5.4-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571413805;
        bh=pbmgVM5FBJRtDKo2MHb0gJ8MdlAWiu/R5y4aNSZOQow=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=m0KLCB4QcXtUHDW/Y64t1MG4q9toc9vbemYzeuWibLfnktF4g1X9XVxORC6TWtp9u
         oiletYwW+azX1WQ6BUC4hdTmSxqmgTqo+FGKsh1d5XdcIuMxV5LxicDdWRg7PCgwG5
         u+qeek1RDbYsPxWcT0lwe7Pvz78JUVhJqo5l4TJc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0iMdUWVv8G1D075eSEBOMoqUfoWC_ik6qy5CxNapUo1xg@mail.gmail.com>
References: <CAJZ5v0iMdUWVv8G1D075eSEBOMoqUfoWC_ik6qy5CxNapUo1xg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0iMdUWVv8G1D075eSEBOMoqUfoWC_ik6qy5CxNapUo1xg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.4-rc4
X-PR-Tracked-Commit-Id: b23eb5c74e6eb6a0b3fb9cf3eb64481a17ce1cd1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e59b76ff67e527e58914409f13a9cffa1cbf42e7
Message-Id: <157141380553.28894.10224105996340827276.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Oct 2019 15:50:05 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Fri, 18 Oct 2019 11:17:32 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.4-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e59b76ff67e527e58914409f13a9cffa1cbf42e7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
