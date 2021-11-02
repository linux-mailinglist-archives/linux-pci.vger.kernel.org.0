Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B00DF4439A7
	for <lists+linux-pci@lfdr.de>; Wed,  3 Nov 2021 00:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbhKBXaC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Nov 2021 19:30:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:51662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229900AbhKBXaB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Nov 2021 19:30:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 3104460FC2;
        Tue,  2 Nov 2021 23:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635895646;
        bh=cNv+Rh3bHhhiwrg8VNods1Cl0319xmhhn4Mso9AA3Dc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=O6CcCRjUGpHSmeB3Lsxo+1k3JN6mFrVG/bD/ow47DwldcNbYN8tsJL8EZ1jJ+ysX7
         /f7Enbka7Ji9G07HvPY8fDVDoY53xVqVABQ2pTOrvpUgZ5q8pItOcFr3Q+hi0KHvvv
         UYjz2ozYXyjsy6XzQHAJpqvBFfj4IWjAzDVTeIzH5NlOTOKFF7yv0v9nFpjw61+6Iz
         N4z0F4u711PIQ7f64uxihEUWdpazYhOoRFmqzyba8trReQLW8IWRMNeNBDNzrmN0AN
         bSBmlDHJOruYGLM75PUxa6uPAcp1mxxpwGSDUolrL7XKwnQ2vAYB27GNWDombkruqv
         JucIRlFN8i6/Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 250EC60A90;
        Tue,  2 Nov 2021 23:27:26 +0000 (UTC)
Subject: Re: [GIT PULL] Power management updates for v5.16-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0iSL3vwvmRL_BvS1J4_NHCNoLO5bG4YFcjVK-oXH_uTAg@mail.gmail.com>
References: <CAJZ5v0iSL3vwvmRL_BvS1J4_NHCNoLO5bG4YFcjVK-oXH_uTAg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0iSL3vwvmRL_BvS1J4_NHCNoLO5bG4YFcjVK-oXH_uTAg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.16-rc1
X-PR-Tracked-Commit-Id: bf56b90797c4a03c94b702c50e62296edea9fad9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 833db72142b93a89211c1e43ca0a1e2e16457756
Message-Id: <163589564614.24792.1055478865512070340.pr-tracker-bot@kernel.org>
Date:   Tue, 02 Nov 2021 23:27:26 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Tue, 2 Nov 2021 20:53:09 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.16-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/833db72142b93a89211c1e43ca0a1e2e16457756

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
