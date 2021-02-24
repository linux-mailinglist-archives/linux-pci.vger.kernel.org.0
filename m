Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 508353243FA
	for <lists+linux-pci@lfdr.de>; Wed, 24 Feb 2021 19:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233995AbhBXSrK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Feb 2021 13:47:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:34172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233204AbhBXSrI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Feb 2021 13:47:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 2326C64F0D;
        Wed, 24 Feb 2021 18:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614192388;
        bh=FrQixc8e3rZo/OEW1ahxLjAM38zkv7Y4pqS9ZqgfZlM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=AhW6kbqKV/lbu583tecQWjEh+TLQ/wQej38W/Fb/QxRVhKVri+y3rNvURqyAppquP
         QHT7UZlq0YAzxNqmWZVZxKMRCGrvBIa5tSp+N1pE4vvYm2gxYCjCgFxS6jwh4SX0y0
         We6v6WnT3cqBIv9JcItV2yBCGOPw4jlPQHHQU8/8j4hbdgqQ9pw7sKifn7AnBdRaTc
         lOpmbZAez5jtqYXViUH/v8DcQJ7V72XLBPmwOuZNoqAGCSsYKeDLE880DXpwABg1GV
         6yoKyWK15Rl52sOghGFr4h8MM3TP9Ke0yhdlfL99Nq6MpdOLaKkpqOFoHDH9SY3lec
         jCCOY8Ofiz4zw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 0665F60176;
        Wed, 24 Feb 2021 18:46:28 +0000 (UTC)
Subject: Re: [GIT PULL] Compute Express Linux (CXL) for v5.12-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPcyv4gsXbi6Cc71wW5hob8mGuupXKkL5tHLRaZkdLZ1oAuK8Q@mail.gmail.com>
References: <CAPcyv4gsXbi6Cc71wW5hob8mGuupXKkL5tHLRaZkdLZ1oAuK8Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cxl.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPcyv4gsXbi6Cc71wW5hob8mGuupXKkL5tHLRaZkdLZ1oAuK8Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/cxl-for-5.12
X-PR-Tracked-Commit-Id: 88ff5d466c0250259818f3153dbdc4af1f8615dd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 825d1508750c0cad13e5da564d47a6d59c7612d6
Message-Id: <161419238797.20610.4661050005924774981.pr-tracker-bot@kernel.org>
Date:   Wed, 24 Feb 2021 18:46:27 +0000
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Tue, 23 Feb 2021 20:05:36 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/cxl-for-5.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/825d1508750c0cad13e5da564d47a6d59c7612d6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
