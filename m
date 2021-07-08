Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52CCC3C1A1D
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jul 2021 21:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbhGHTwA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Jul 2021 15:52:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:55384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229631AbhGHTwA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 8 Jul 2021 15:52:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id CBEB16141E;
        Thu,  8 Jul 2021 19:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625773757;
        bh=WTJ8UavVAdBvcncxyhwKqeDpvOWQ22qQ90/5ehNgq3U=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OXt8aAZjTZwRthj2zik4jeqYZle8/tFYfG3GqS5nOhm2QJUsnZH/b9qwh5G/iriWZ
         dcy0xsBYZ16Z7mfJF7jiVciQ21lUPpy3gU/GuWpJTgdt9Hqoj4kgf3e7fulxKpowg+
         osiRFYn81aKrI0x0Iu50dCkd/4uh5VdxEUk2nzAiCi/ZHqDb4eU0zVFLx3MISJ8C44
         AxAxCQTVMBaf2TluOuvAHYJ3q1MPs0vWhY82VuFOZ+YEyLGLi3RRjLJ7QCthDllVwd
         arCRkIGnbeBviXN2ygOu9faOQl5XgRAO2FV0zeilcUdP4MaradTpSSqbiIay31zgQu
         cf/VrgGxPYjzg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id B8C12609D6;
        Thu,  8 Jul 2021 19:49:17 +0000 (UTC)
Subject: Re: [GIT PULL] PCI changes for v5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210707214240.GA937039@bjorn-Precision-5520>
References: <20210707214240.GA937039@bjorn-Precision-5520>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210707214240.GA937039@bjorn-Precision-5520>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.14-changes
X-PR-Tracked-Commit-Id: d58b2061105956f6e69691bf0259b1dd1e9fb601
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 316a2c9b6a5f6f056441275f748e077027179f36
Message-Id: <162577375769.18035.3357898383161596606.pr-tracker-bot@kernel.org>
Date:   Thu, 08 Jul 2021 19:49:17 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Wed, 7 Jul 2021 16:42:40 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.14-changes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/316a2c9b6a5f6f056441275f748e077027179f36

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
