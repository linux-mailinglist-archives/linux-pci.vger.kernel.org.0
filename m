Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCB258A502
	for <lists+linux-pci@lfdr.de>; Fri,  5 Aug 2022 05:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240508AbiHED0z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Aug 2022 23:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240498AbiHED0f (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Aug 2022 23:26:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68693B2;
        Thu,  4 Aug 2022 20:26:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9AFFCB827D4;
        Fri,  5 Aug 2022 03:26:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5157BC433C1;
        Fri,  5 Aug 2022 03:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659669990;
        bh=cD9zPWur39yAhHVxry5/WS80QtJHGTkcu8A/gV31aek=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UnzV53pH3VmyBGsFXJ5P5zQjPllFZvU9cSuDtrr06zTM5nXSg5PJb9LsQqgFaV5Ys
         9Qm0VyWPxRxw8ExAE6/zAsPnrL08IzwOKcOKOeCy5E6MeWIP+g0c7taDz6ND/Dzgkc
         cMAA5COYU9MvJiKOBSyKTMG8/JvNlnQ6CVn5CuSAAxISx26FlIk6sPtWkJhDflrqYg
         k6ZX26NrF4hGg8twCEadjTbchT2ZWKHwI0oEsnPEkx9DZuu9/v9JQlVAVbOs+D9wN7
         eDnoOtVYWWYiUFaL0qDtoRzP2XkGOPW+3amJ2c23DijhSprdyoJRoa4fFFLUnpMQZ6
         xfp19lRnDxcuw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 41144C43142;
        Fri,  5 Aug 2022 03:26:30 +0000 (UTC)
Subject: Re: [GIT PULL] PCI changes for v5.20
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220804172504.GA943002@bhelgaas>
References: <20220804172504.GA943002@bhelgaas>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220804172504.GA943002@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.20-changes
X-PR-Tracked-Commit-Id: c4f36c3ab065065a87d641ca2fd5d5c4eb2bfa82
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eff0cb3d91c06acbb957be1134a07afa2c4978e3
Message-Id: <165966999026.9883.12737348350427164044.pr-tracker-bot@kernel.org>
Date:   Fri, 05 Aug 2022 03:26:30 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Thu, 4 Aug 2022 12:25:04 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.20-changes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eff0cb3d91c06acbb957be1134a07afa2c4978e3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
