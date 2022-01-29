Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B36A04A30F9
	for <lists+linux-pci@lfdr.de>; Sat, 29 Jan 2022 18:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352902AbiA2RHt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 29 Jan 2022 12:07:49 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:53828 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245664AbiA2RHs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 29 Jan 2022 12:07:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5CE40B8279C;
        Sat, 29 Jan 2022 17:07:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1F0DBC340E5;
        Sat, 29 Jan 2022 17:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643476066;
        bh=mK4GOxjWQhgRBxEZl+E4VWsLx6wsCN7ihIaJ91iTUj0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GdlQvadpZItLZKHQeaAo/69i91fqU+knvzzcHU5wGgL/6llcQFwxq/dytA1HPv+CV
         SeYTy6P32XFZNZfZR+7thit3bAlRjN112WnuViIITpzcSHQhUWalHvF0gmhsQX3bv3
         c9HrqElGb5savYCAZV6obr+OlA3U64wn22RXhOrjj5axZtLh7evJrUrIWz/R6mopbv
         eMazdV16ZaEzBggb1d+8UcjdrRSluSBFQ0OfSWBEfgXTgksHGMsTaxOAZBBtsOzVpC
         vyZYq0+RncErBvhaArEykqLRJW7eDwmhbsiLIiCzUt+SGQfAbVxUy6ShLfu5UeyvNC
         wyX5X1Gg0/NxA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0E9D0E5D07E;
        Sat, 29 Jan 2022 17:07:46 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220129161547.GA352890@bhelgaas>
References: <20220129161547.GA352890@bhelgaas>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220129161547.GA352890@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.17-fixes-2
X-PR-Tracked-Commit-Id: 66d28b21fe6b3da8d1e9f0a7ba38bc61b6c547e1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f8c7e4ede46fe63ff10000669652648aab09d112
Message-Id: <164347606605.4234.11517840311801526698.pr-tracker-bot@kernel.org>
Date:   Sat, 29 Jan 2022 17:07:46 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Sat, 29 Jan 2022 10:15:47 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.17-fixes-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f8c7e4ede46fe63ff10000669652648aab09d112

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
