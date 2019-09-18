Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67C04B59E6
	for <lists+linux-pci@lfdr.de>; Wed, 18 Sep 2019 04:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbfIRCzV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Sep 2019 22:55:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:48546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726791AbfIRCzV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Sep 2019 22:55:21 -0400
Subject: Re: [GIT PULL] ACPI updates for v5.4-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568775321;
        bh=Wa5nUNHuUc8GgHYrNCCYBYFTQGAD7VYOgndSgjMpuMQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=QO1AX0/qhDJ5zYv5Tc6SwFJDxdWkF1zL3k5jl2tZq8rIewyemsMpKidFm9i6lzfS5
         6HVsrPrBS8uTe01WeaENZmHSpMjXeTYO1qyTEAYIrJ8jV7eSPYHifmlXxwuZol9lyM
         ppmyUeL60/sLbmpxWL1DWhwU1CKg04Ep7zQY74JA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jHzVKJiLzMxC6eqqCkpeKA-UD_9fhy1KpVp6fM=XwiSQ@mail.gmail.com>
References: <CAJZ5v0jHzVKJiLzMxC6eqqCkpeKA-UD_9fhy1KpVp6fM=XwiSQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jHzVKJiLzMxC6eqqCkpeKA-UD_9fhy1KpVp6fM=XwiSQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 acpi-5.4-rc1
X-PR-Tracked-Commit-Id: 0b3e7973128528e804b05dd7f79d54c2792318d6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d2aaa49e281959828370667edbc1cdcc7fc4026a
Message-Id: <156877532122.3897.11937478419380294753.pr-tracker-bot@kernel.org>
Date:   Wed, 18 Sep 2019 02:55:21 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Tue, 17 Sep 2019 12:25:05 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d2aaa49e281959828370667edbc1cdcc7fc4026a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
