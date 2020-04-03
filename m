Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA91B19E0A0
	for <lists+linux-pci@lfdr.de>; Sat,  4 Apr 2020 00:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgDCWFR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Apr 2020 18:05:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:38472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727879AbgDCWFR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 3 Apr 2020 18:05:17 -0400
Subject: Re: [GIT PULL] PCI changes for v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585951517;
        bh=oNx9ba2rXfHlsxoKf41mOoZva2B3xmQuMYxiPkXFIrw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=WdiCeCe2stD6fg21iv+SmYC7ahzcjhd4eb8qQzgjsb3IzkoeSwp9lA+hdhpewAeuj
         StzaAJAi1s+BGnBs20+7PjmBf419IzjLsDGblIBfRUuKTh8I8kzfNo2ibEr54s/D6R
         GofQzCSsAdsHC89EnhYaSHJ9RayY8lQ4fquZRMGo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200403154841.GA241702@google.com>
References: <20200403154841.GA241702@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200403154841.GA241702@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
 tags/pci-v5.7-changes
X-PR-Tracked-Commit-Id: 86ce3c90c910110540ac25cae5d9b90b268542bd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 86f26a77cb0cf532a92be18d2c065f5158e1a545
Message-Id: <158595151699.22871.11795513248478547542.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Apr 2020 22:05:16 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Fri, 3 Apr 2020 10:48:41 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.7-changes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/86f26a77cb0cf532a92be18d2c065f5158e1a545

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
