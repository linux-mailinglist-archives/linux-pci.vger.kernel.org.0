Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0A03749AE
	for <lists+linux-pci@lfdr.de>; Wed,  5 May 2021 22:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhEEUub (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 May 2021 16:50:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:59836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229893AbhEEUuY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 May 2021 16:50:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id BC85161176;
        Wed,  5 May 2021 20:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620247766;
        bh=p7Qt1nsJPc48Dnwbz9EhBx//Eh+iqM/EKCePqsyQIa8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=u4SV70FJ6ZJE1SyMiUK/psE61ZUqJLRlPs3jNsQyBZd9f0dLla1kp66+Mc2o9BEni
         LbsQDj3Bmd+aUMBtI5nNCloFxhbfQs2nQDqk8w+cPoJwPl41AX1thWd68UI3LYJVKB
         60y2q0zWBAwVdrpFuAJfT/mSUQJpxTstSTw+LtHVY24Oz/CS6IebanUSkqekKnyNbZ
         ShE81B20nzim1dtAzXbY3B58m9kld63MNPmvoo6waJKiCnFOHX++bGO1TG1ysPccKe
         YJ/kgy/BNWWZkFVYviq7i4MPrnTMJ/QUS01jhOwJ7DdNe8blro6EWqR8d+DNVK+lDB
         ijwkNxLBelUwQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id B6964609E8;
        Wed,  5 May 2021 20:49:26 +0000 (UTC)
Subject: Re: [GIT PULL] PCI changes for v5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210505163611.GA1310028@bjorn-Precision-5520>
References: <20210505163611.GA1310028@bjorn-Precision-5520>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210505163611.GA1310028@bjorn-Precision-5520>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.13-changes
X-PR-Tracked-Commit-Id: 882862aaacefcb9f723b0f7817ddafc154465d8f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 57151b502cbc0fa6ff9074a76883fa9d9eda322e
Message-Id: <162024776674.12235.8495124452855702495.pr-tracker-bot@kernel.org>
Date:   Wed, 05 May 2021 20:49:26 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Wed, 5 May 2021 11:36:11 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.13-changes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/57151b502cbc0fa6ff9074a76883fa9d9eda322e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
