Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7786252AED6
	for <lists+linux-pci@lfdr.de>; Wed, 18 May 2022 01:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbiEQXwP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 May 2022 19:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbiEQXwO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 May 2022 19:52:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1B741339;
        Tue, 17 May 2022 16:52:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74BBFB81D67;
        Tue, 17 May 2022 23:52:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0A553C34117;
        Tue, 17 May 2022 23:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652831531;
        bh=spYIMVPV55N3AgdMlDTGz8M6k1WuTg+xQApxQCdZtNs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=h1bXy9WiypVJqCB87dygxFOiAH6gbD/QyvxcIIP/SKbkFUumpFz210BvM72wVN5Kt
         lyRpTlqA9vAxUSpjxF5szDhefDwzGT43Cy0qiE+ECdjB9d2jcI06NMvQksytp4mLP0
         dZ+mJTywH5iwPT54f/QCDh9rzZuFkYD2UfR3ptdTEm0uydoWTUqJoBbMR++Ygnn8GD
         NrcvBuHDAddL9GUEmRvkterw4/zKFEUV7LjJftSWXoI8q3TD2YYPF1b8jpoLo56rPb
         y0MiCRPWPEbq2XOMJLULFImNw2ccAHy44zbMkT1BG7CuZL+njrvMeTQOvmWqf1gU/g
         7RPcZzBM25rPg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E6003F0389D;
        Tue, 17 May 2022 23:52:10 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220517203530.GA1102878@bhelgaas>
References: <20220517203530.GA1102878@bhelgaas>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220517203530.GA1102878@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.18-fixes-1
X-PR-Tracked-Commit-Id: a3b69dd0ad6265c29c4b6fb381cd76fb3bebdf8c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 210e04ff768142b96452030c4c2627512b30ad95
Message-Id: <165283153093.29538.8971651599965342621.pr-tracker-bot@kernel.org>
Date:   Tue, 17 May 2022 23:52:10 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Stefan Gottwald <gottwald@igel.com>,
        Steev Klimaszewski <steev@kali.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Tue, 17 May 2022 15:35:30 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.18-fixes-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/210e04ff768142b96452030c4c2627512b30ad95

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
