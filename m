Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E312748FB3A
	for <lists+linux-pci@lfdr.de>; Sun, 16 Jan 2022 07:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234290AbiAPGpi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 16 Jan 2022 01:45:38 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:51844 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbiAPGph (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 16 Jan 2022 01:45:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 368A660C8C;
        Sun, 16 Jan 2022 06:45:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9C8FAC36AF2;
        Sun, 16 Jan 2022 06:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642315536;
        bh=oSyHYB2d4L5AZ0SdrGJMsCwBgXtU6IydW0hwK8TCcDY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=EwE86Bv27zIpHgJ23XKnWIntdfJE7mYX/WfcCVSqyYzG2tL6qXdEokTMgfHPJhWUP
         cnwcsxPuldf2Aj9s5+/gh3A4hb9cEET1wbRjDW01pYzUNpxo0+fYoa0QKi9nvXqI4K
         GeovYDVrjoa8761TRq3/PcMI0lqbeTUWlpVv7R7Cd8aC2+pLD7E1rscghwWDtOxCJU
         /368PHMxM9kIFN4m50qn08k+WyiW1wC/toOarO0aTc41muIhH3DfyNBwF0CQXrHKlT
         6aNhWDDeQPZ7Ijpbz0v9TvJbTFLr9C+oTwp7/c4eV6+QcLgXl5gpygFI9y6jyEiGsN
         ibP5BfNsoNlXQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8C325F60799;
        Sun, 16 Jan 2022 06:45:36 +0000 (UTC)
Subject: Re: [GIT PULL] PCI changes for v5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220114155608.GA557997@bhelgaas>
References: <20220114155608.GA557997@bhelgaas>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220114155608.GA557997@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.17-changes
X-PR-Tracked-Commit-Id: 87c71931633bd15e9cfd51d4a4d9cd685e8cdb55
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d0a231f01e5b25bacd23e6edc7c979a18a517b2b
Message-Id: <164231553657.30539.11483720642487121527.pr-tracker-bot@kernel.org>
Date:   Sun, 16 Jan 2022 06:45:36 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Fri, 14 Jan 2022 09:56:08 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.17-changes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d0a231f01e5b25bacd23e6edc7c979a18a517b2b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
