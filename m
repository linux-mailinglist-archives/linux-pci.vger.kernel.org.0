Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4C39A1DD
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2019 23:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732993AbfHVVPI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Aug 2019 17:15:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:45958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732447AbfHVVPI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Aug 2019 17:15:08 -0400
Subject: Re: [GIT PULL] PCI fixes for v5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566508507;
        bh=KgeuTIuadlXWsCpNhH8NufflIAPIfriFmJs7aNh4MR4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=eLRQ2Pb6GhPu8NPvzZ59XaxzK/8DbTVVF8VqEXIuEXZ4WmW2N/GQU/jdPPjXy0A4q
         Deyll9h8B6BFzan6n4XfHmGbz36P5jW2gyq1tM+VRUwde09BzZVjx6cqkh0/sJgYvW
         5Nsp6CESJtU5zE/vRoZYgEV81cKADTBW/yRftIIA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190822203239.GL14450@google.com>
References: <20190822203239.GL14450@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190822203239.GL14450@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
 tags/pci-v5.3-fixes-1
X-PR-Tracked-Commit-Id: 7bafda88de20b2990461d253c5475007436e355c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 59c36bc8d377c8764eb617a92211e0fc2f1318da
Message-Id: <156650850750.5209.13921717189408235811.pr-tracker-bot@kernel.org>
Date:   Thu, 22 Aug 2019 21:15:07 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Lyude Paul <lyude@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Thu, 22 Aug 2019 15:32:39 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.3-fixes-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/59c36bc8d377c8764eb617a92211e0fc2f1318da

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
