Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72ADE2A87DF
	for <lists+linux-pci@lfdr.de>; Thu,  5 Nov 2020 21:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbgKEUVU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Nov 2020 15:21:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:34516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbgKEUVU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Nov 2020 15:21:20 -0500
Subject: Re: [GIT PULL] PCI fixes for v5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604607679;
        bh=H4u4Bd6m0go6FQOJfir2Lu1yBBs7zGIfHVh0EBZVELw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=f8JNbMehEQOlgoAOCfx/Wb5lc3EkbFhDH2Ehpp0UxLpb+58co4NCXfl0glJuBmnqZ
         yeQSP+tjmBCNrFH52WY+ZYROFjkPyjFEM+1XlTzGpoF1RwuCMIyJZaoDC0CtgWnO5P
         X5thB6ieuR549nviv6oXzJtv6y6aY5Bs92409M+Y=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201104211033.GA418499@bjorn-Precision-5520>
References: <20201104211033.GA418499@bjorn-Precision-5520>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201104211033.GA418499@bjorn-Precision-5520>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.10-fixes-1
X-PR-Tracked-Commit-Id: 832ea234277a2465ec6602fa6a4db5cd9ee87ae3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e2557a2cdeb2e6a6e258e27e63af34e3ac6c1069
Message-Id: <160460767950.18865.11417118347211160640.pr-tracker-bot@kernel.org>
Date:   Thu, 05 Nov 2020 20:21:19 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, vtolkm@googlemail.com,
        Vidya Sagar <vidyas@nvidia.com>, Boris V <borisvk@bstnet.org>,
        Rajat Jain <rajatja@google.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Wed, 4 Nov 2020 15:10:33 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.10-fixes-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e2557a2cdeb2e6a6e258e27e63af34e3ac6c1069

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
