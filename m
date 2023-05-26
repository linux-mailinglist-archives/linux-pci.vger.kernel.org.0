Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B647130B1
	for <lists+linux-pci@lfdr.de>; Sat, 27 May 2023 01:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237823AbjEZXxa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 May 2023 19:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjEZXx3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 May 2023 19:53:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98C010CB;
        Fri, 26 May 2023 16:53:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82926654AF;
        Fri, 26 May 2023 23:51:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF13DC4339C;
        Fri, 26 May 2023 23:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685145097;
        bh=BvmLRsnmHeyg5CavFMJROF0P+A1F7hrwvh+07iE8pc0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=YY5XeTV/pc94aruRYYy/MTA+y6FQBSsJjhCmV9V0FGppE+df74quev5+ea3P4V+Ax
         JzViJe/U0eqEqTi+5WrB+TiICzXEaEEue4McZbX9mVIuI6s/PVpD0GnB2rKOcfr6qL
         Ss6XIAATAGKlBzzLLAphQAbQHl3e21iQn3vZ+Qr894CE0rqGlFP6jBD+xqSYI+lW8S
         2SxSWoL1k7ZxQ9e43UDoX5Q9cdJS9INnOXPl+m5iqsjfEGR7JKLXjF529hH+AG/QUb
         W181wKWpArmIAxbHyemKCw+c9Z/ykMEPcbGD54eF5VK5hV3uq36EZXSd56T7fKo4UJ
         uRt41OpAbd+rA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C8BACE270C2;
        Fri, 26 May 2023 23:51:37 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZHErfurfF9cNIION@bhelgaas>
References: <ZHErfurfF9cNIION@bhelgaas>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZHErfurfF9cNIION@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.4-fixes-1
X-PR-Tracked-Commit-Id: 3b8803494a0612acdeee714cb72aa142b1e05ce5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 96f15fc6cc020f68ea23e099da34858678060002
Message-Id: <168514509781.17241.8988137463807316846.pr-tracker-bot@kernel.org>
Date:   Fri, 26 May 2023 23:51:37 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mark Blakeney <mark.blakeney@bullet-systems.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Fri, 26 May 2023 16:58:22 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.4-fixes-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/96f15fc6cc020f68ea23e099da34858678060002

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
