Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58E06A268F
	for <lists+linux-pci@lfdr.de>; Sat, 25 Feb 2023 02:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjBYBh4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Feb 2023 20:37:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjBYBhz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Feb 2023 20:37:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F9E7689;
        Fri, 24 Feb 2023 17:37:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5062461840;
        Sat, 25 Feb 2023 01:37:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A6832C4339B;
        Sat, 25 Feb 2023 01:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677289073;
        bh=QtEcdqeN85r3F5gqZ1SS/QJJ0RedqPEHc8X+atZpEuA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Xm+Wkcx+NgGz9HIKRFzcG6zBvJOQ/HpYPxhHWpF/KuQpoVbvgIgWlDIpDYKgHNN8G
         1NMfRwhR8HFRccyPtg8Q+zxutvmAxPZ63QqhoOUVRBn+UFOpF/THtu9dv0ZaxPDyad
         LgPzYj1ESZAWuBU4sycU5x3iJFM2+6CSGnBu8cEBsWX9d1w6tovZZso3mj1zhkXiyz
         6k4oHAmPc9GqqfULKXqgSEau4+hm7n3apqiAOu1BLOFMX0XqZKFKUjmk1k5veBCDgS
         6uNeAnMDhQrl3A8a+ByStqAFoUJV9ezCXWkQlTkfQVC1Osl1K1jmkWYQ+WCWW8wmVl
         50tsRzFXa2Cog==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 940EEC43151;
        Sat, 25 Feb 2023 01:37:53 +0000 (UTC)
Subject: Re: [GIT PULL] PCI changes for v6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230222201749.GA3798224@bhelgaas>
References: <20230222201749.GA3798224@bhelgaas>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230222201749.GA3798224@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.3-changes
X-PR-Tracked-Commit-Id: 3eb5d0f26f4ea604e83ca499a72c0d33638f4765
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 90ddb3f03418cce0d83c415c0c1d470cf524ba46
Message-Id: <167728907359.28954.12600143614951122974.pr-tracker-bot@kernel.org>
Date:   Sat, 25 Feb 2023 01:37:53 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Vinod Koul <vkoul@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Wed, 22 Feb 2023 14:17:49 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.3-changes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/90ddb3f03418cce0d83c415c0c1d470cf524ba46

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
