Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27AF6D2936
	for <lists+linux-pci@lfdr.de>; Fri, 31 Mar 2023 22:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbjCaUPB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 31 Mar 2023 16:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbjCaUPA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 31 Mar 2023 16:15:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CC722218;
        Fri, 31 Mar 2023 13:14:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4980462B7F;
        Fri, 31 Mar 2023 20:14:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A4B66C433D2;
        Fri, 31 Mar 2023 20:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680293696;
        bh=yKd6AaGKUmyvt2RKt+k37EJe452jNrWaZgc0Gjccu6g=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=r8iqKLNNUmwoteMG+oAkRcprajDvu3l3BlBCi681fDX8Mta2A7FoO3OfmjV9PX31M
         qzgFEvZRajYfIppyuHqKm++QxTOmqx6JKjxPTd75PZTt3d37/UegSRfTU33GTCFk9C
         4MoeTGiRQuUnn655caCGdmrAxyTK3pWFEF/t6V6AP6FOBvqLUxjBTPlF7J2YsWpbux
         l6dhQWB0VryzKXnEzrOpHcRIxF4mXJ5tYjHGqvwmgZVgvn77xZm+F1+Zs/lh66jIqz
         nkPGa0c5Yr/Mh4UqzS3AvCyHSqrBM5ylKwsdc+VoAxDVrHRV7oVVUSq8gWETyj38vP
         WY0XYWjTRi2rA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8D968C73FE0;
        Fri, 31 Mar 2023 20:14:56 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230331162714.GA3232819@bhelgaas>
References: <20230331162714.GA3232819@bhelgaas>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230331162714.GA3232819@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.3-fixes-1
X-PR-Tracked-Commit-Id: cdce67099117ece371582f706c6eff7d3a65326d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 916fc60988545499530104342a01df6357fd3647
Message-Id: <168029369657.23236.13093783594264009333.pr-tracker-bot@kernel.org>
Date:   Fri, 31 Mar 2023 20:14:56 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Serge Semin <fancer.lancer@gmail.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Fri, 31 Mar 2023 11:27:14 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.3-fixes-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/916fc60988545499530104342a01df6357fd3647

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
