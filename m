Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1A64C37F2
	for <lists+linux-pci@lfdr.de>; Thu, 24 Feb 2022 22:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235094AbiBXVlL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Feb 2022 16:41:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234971AbiBXVlH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Feb 2022 16:41:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D84186B96;
        Thu, 24 Feb 2022 13:40:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2CD48B829BE;
        Thu, 24 Feb 2022 21:40:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C4425C340E9;
        Thu, 24 Feb 2022 21:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645738834;
        bh=mftOn5Nfik4TVPSmweW4i6KzvDszFFGtAI0VzO7wjZk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lUyi79UiHYvyk6vY55JuUWoCrKkkIw5fFT9LTZwcCHkh0FOQ4UqrbmLHB/Zz+mLYU
         RRHmlp9S+gqD7m9vCcOgjxLaRV2S5VzxLk2wMr0Hc6FitYJKq6d5xrGy6EuOHWpSRc
         ygKrrZOx/N1t88zemh3PthaeuyONoCWEZ0u9IAxRTBjgtlb8r0aj/ESlUMrzy9D8Je
         LD8Rt/lUVhSl2zhlaZIcwTFIFzhm42w2ukQHd1yFxYPXMiMeUIWU5NdKK55XkMZDsA
         3ZJPkMdCEeeK+ESk79je31PdQXSXunhN566BvJN0ouU9j5ojWCeLvJ5VpIeEwAnFpY
         dk1O8NmXy9uug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B0630E6D3DE;
        Thu, 24 Feb 2022 21:40:34 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220224195611.GA289605@bhelgaas>
References: <20220224195611.GA289605@bhelgaas>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220224195611.GA289605@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.17-fixes-5
X-PR-Tracked-Commit-Id: 3f1271b54edcc692da5a3663f2aa2a64781f9bc3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d8152cfe2f21d6930c680311b03b169899c8d2a0
Message-Id: <164573883471.15008.15419625252124832547.pr-tracker-bot@kernel.org>
Date:   Thu, 24 Feb 2022 21:40:34 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Guchun Chen <guchun.chen@amd.com>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Jan Palus <jpalus@fastmail.com>, Marcel Menzel <mail@mcl.gg>,
        linux-arm-kernel@lists.infradead.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Thu, 24 Feb 2022 13:56:11 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.17-fixes-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d8152cfe2f21d6930c680311b03b169899c8d2a0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
