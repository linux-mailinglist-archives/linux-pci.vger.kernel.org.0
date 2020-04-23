Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE0871B65C1
	for <lists+linux-pci@lfdr.de>; Thu, 23 Apr 2020 22:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbgDWUuS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Apr 2020 16:50:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:46586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbgDWUuS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 Apr 2020 16:50:18 -0400
Subject: Re: [GIT PULL] PCI fixes for v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587675018;
        bh=AdfVc9jHOKmzcM5ts3Z7u9YEIcRlZk2jm2fkwZjfBRM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=yacrZg405u+zMEabzpdcWAhl0TDtrwI19yCx6U7UWoSlX3rEktRYgh06HwY0MC1F5
         Su92xqqQJ3jqe6FOnD76S2KVktWV0d7voccN1JlXWzW4B1Y4G4wnp/Ds5KoG9wG8Pw
         pPspbjHOX3gmZlpHblPQGUoTdyCbcL3WSkV70uto=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200423173955.GA193359@google.com>
References: <20200423173955.GA193359@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200423173955.GA193359@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
 tags/pci-v5.7-fixes-1
X-PR-Tracked-Commit-Id: ef46738cc47adb6f70d548c03bd44508f18e14a5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 25b1fa8dfb3fe2578c04a077953b13c534f30902
Message-Id: <158767501830.2530.11160481403245965059.pr-tracker-bot@kernel.org>
Date:   Thu, 23 Apr 2020 20:50:18 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        =?iso-8859-1?Q?Lu=EDs?= Mendes <luis.p.mendes@gmail.com>,
        Todd Poynor <toddpoynor@google.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Thu, 23 Apr 2020 12:39:55 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.7-fixes-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/25b1fa8dfb3fe2578c04a077953b13c534f30902

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
