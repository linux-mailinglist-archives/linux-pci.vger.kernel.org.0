Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1CF29659C
	for <lists+linux-pci@lfdr.de>; Thu, 22 Oct 2020 22:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S370542AbgJVUEY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Oct 2020 16:04:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:56958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S370522AbgJVUEP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Oct 2020 16:04:15 -0400
Subject: Re: [GIT PULL] PCI changes for v5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603397055;
        bh=frl2OYMoZ3nwHpGZk4Vq8/JvdbcJnyUeiL/E3TFNt2Y=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=c9/etLzNHyjEi0z7qdaXosxqCpWoF7ezJNUmdj8bv1hr9ZOKNVy/IBX7CgsZhhjrs
         TjzG41MGlCq3J8vhdkywDfM4PfU7/FT4yXxKJ+lftZa8M0j4ZsuHpPotJUojBX+6Tq
         SVg2H89/wCb+MOb22KBSV0l+FwKs/gDDVJygChcc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201021212443.GA466346@bjorn-Precision-5520>
References: <20201021212443.GA466346@bjorn-Precision-5520>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201021212443.GA466346@bjorn-Precision-5520>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.10-changes
X-PR-Tracked-Commit-Id: 28e34e751f6c50098d9bcecb30c97634b6126730
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 00937f36b09e89c74e4a059dbb8acbf4b971d5eb
Message-Id: <160339705537.15216.3349175696210702383.pr-tracker-bot@kernel.org>
Date:   Thu, 22 Oct 2020 20:04:15 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Wed, 21 Oct 2020 16:24:43 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.10-changes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/00937f36b09e89c74e4a059dbb8acbf4b971d5eb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
