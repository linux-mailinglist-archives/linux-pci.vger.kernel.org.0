Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9743AD444
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jun 2021 23:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234409AbhFRVS3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Jun 2021 17:18:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:55164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233725AbhFRVS3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Jun 2021 17:18:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 36CF861209;
        Fri, 18 Jun 2021 21:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624050979;
        bh=wT2zMcdIYi+tuN4Qngd7z5joDawv6bnBZC2kL+p5I+E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MmqymCxiZ2JAYIx+mzS0tNb2B+vB3qxEc6B8JUnKGe1JxP0RPjNkixdNNQXWX0uRJ
         RBb6P+EL5Av4xctoSYhrGouHiF0/u7tvRH51ZYIl6TbPT01Q3q+I+uMTbO5WpIbYLB
         0wX8fIkj1Cb+J3O5K3JX/aCXLhXvclfqVZZpjkY7yVdRBYj82RMyo5H5kqUFG4cS/+
         m6V9IEVwpqqoOaw86xyLkrIWXjY3ErRekECjKBFhVR+3pNQzmkgncRyptzapdHvWPH
         bhR5bE18h3Eut1nrS0vu7jNe/YkN0zfIJHX1chk20ZbzSWq/Y7X3TR0cfkSARlDxVL
         JQsFAoWevo/CA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 210F760A17;
        Fri, 18 Jun 2021 21:16:19 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210618204937.GA3216522@bjorn-Precision-5520>
References: <20210618204937.GA3216522@bjorn-Precision-5520>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210618204937.GA3216522@bjorn-Precision-5520>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.13-fixes-2
X-PR-Tracked-Commit-Id: f18139966d072dab8e4398c95ce955a9742e04f7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 728a748b3ff70326f652ab92081d639dc51269ea
Message-Id: <162405097907.7571.5080941137543538357.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Jun 2021 21:16:19 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Punit Agrawal <punitagrawal@gmail.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Qu Wenruo <wqu@suse.com>,
        Domenico Andreoli <domenico.andreoli@linux.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Antti =?iso-8859-1?Q?J=E4rvinen?= <antti.jarvinen@gmail.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        Chiqijun <chiqijun@huawei.com>, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Mikel Rychliski <mikel@mikelr.com>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Fri, 18 Jun 2021 15:49:37 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.13-fixes-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/728a748b3ff70326f652ab92081d639dc51269ea

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
