Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 626534470B6
	for <lists+linux-pci@lfdr.de>; Sat,  6 Nov 2021 22:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbhKFVp7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 6 Nov 2021 17:45:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:38970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231144AbhKFVp7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 6 Nov 2021 17:45:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 75C066108D;
        Sat,  6 Nov 2021 21:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636234997;
        bh=xfxS5A+SRREsEjx/qyiwD4oINsRywkoLs4GhmoejLJQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TW4AAnz3OApNGI9dRBVE4euNf1EwIcbw9mdMqol2HWjHD07L/8cE665EjzBb4vHoA
         Sfwoa75YNTk4cGbxh14o5loA7Rbah9foyQr6Yn4NbUrlzA2FjII1+8b1eRLQGLz/8O
         g1OBv7NW6Xb5JrhjY1hPZOAWrHuzFhrqd/+PA/WIAUx1DCKx0tsnGTO7HdX7iO3EQP
         aCbZ7Ty/XVX5Poc2HEZ8hyDHlaDOb7ORkOYW2YAFf1ALCHOP4AbPIJehIuoPlgueKW
         Xkj15rmhnvq94qqzzUKOmbsbPcn/pCiXmXRFSaCaM1AJoDuQPC2V64E0yzHdskmEXF
         BvmfYDLWFzBLQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 624E8609E7;
        Sat,  6 Nov 2021 21:43:17 +0000 (UTC)
Subject: Re: [GIT PULL] PCI changes for v5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211105170017.GA929912@bhelgaas>
References: <20211105170017.GA929912@bhelgaas>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211105170017.GA929912@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.16-changes
X-PR-Tracked-Commit-Id: dda4b381f05d447a0ae31e2e44aeb35d313a311f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0c5c62ddf88c34bc83b66e4ac9beb2bb0e1887d4
Message-Id: <163623499733.3982.17655028721184386436.pr-tracker-bot@kernel.org>
Date:   Sat, 06 Nov 2021 21:43:17 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Fri, 5 Nov 2021 12:00:17 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.16-changes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0c5c62ddf88c34bc83b66e4ac9beb2bb0e1887d4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
