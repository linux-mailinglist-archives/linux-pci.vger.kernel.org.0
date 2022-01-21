Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1758495AF4
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jan 2022 08:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379062AbiAUHiN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jan 2022 02:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349262AbiAUHiN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jan 2022 02:38:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095FDC061574;
        Thu, 20 Jan 2022 23:38:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BA35617B8;
        Fri, 21 Jan 2022 07:38:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 101D1C340E3;
        Fri, 21 Jan 2022 07:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642750692;
        bh=zXkb2ok2mgiZpR8XJNcz4+niW6G1cJSkJ5qEilrGpBA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=f8Zgttx8hT26mKKl0CR7BZMmDst7ukqWrt88qp5uUhdIzQc2/Sshz9T5bcg1yVGnT
         ChvK43vwM3FbvQ6xU5XOxId4uaKr0J0yF/pV53HoAvt0YYIlokr/PojnoPe/AnSLWs
         eDf5jruxbu0XfwHtPVBVvjJA6fHmkgYCiWDFfL/UYDDZQedc1EaIzQD3NCNmCFEBUL
         7SUanhjXQzgoRAauorEvG5qMXwpaDc1dvCmh/703toJYJTRq42scfg6jK3mRRkjWHi
         eLTuFjNRglcUoX95dkx3AzTgd8yOQtUR1dyE/7pKz6bj4V4e08xpMFlhFn2DB8SOMP
         lMD/m+vvcKVDA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F1635F6079C;
        Fri, 21 Jan 2022 07:38:11 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220120204817.GA1065181@bhelgaas>
References: <20220120204817.GA1065181@bhelgaas>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220120204817.GA1065181@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.17-fixes-1
X-PR-Tracked-Commit-Id: 9c494ca4d3a535f9ca11ad6af1813983c1c6cbdd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4141a5e694588897cbec955bc4a646075dc0afd7
Message-Id: <164275069198.15932.5725510103578792675.pr-tracker-bot@kernel.org>
Date:   Fri, 21 Jan 2022 07:38:11 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        intel-gfx@lists.freedesktop.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Thu, 20 Jan 2022 14:48:17 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.17-fixes-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4141a5e694588897cbec955bc4a646075dc0afd7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
