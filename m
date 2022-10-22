Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD28608320
	for <lists+linux-pci@lfdr.de>; Sat, 22 Oct 2022 03:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiJVB2l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Oct 2022 21:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiJVB2j (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Oct 2022 21:28:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7AE2A5683;
        Fri, 21 Oct 2022 18:28:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CEAD1B82DB5;
        Sat, 22 Oct 2022 01:28:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8E94BC433C1;
        Sat, 22 Oct 2022 01:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666402115;
        bh=2Sk/3lIYamfUY5C9LLGc0MR2yjRE7JKe3t3JGmktUuw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=vR7uD+1OYU+EQSJbKZ4AlsvQTT1SepsMwkaiNQ1fb+hZHn1qPC82wlbCP+DpZaAL4
         PJZkO0upV7O1+WlpZO2IWdRCaksXVFnvwgpK9cS7+Nr4H57Ujl7M8hW7zA/zRKBbRc
         EJ2fnPz+MnVtv++VgBn0YtQjgPlrP6sgC9JAbU4bWY7isczNKmLL6jUTZVQvee49qM
         rByIgOeoknWYK+gv2t7MdFodtbdOlh9Sv6B+vn7tjeMXCkI/srebqtosovkVivEgql
         o+rMjt9jO+34114f94SuEJAhABSHxQhtuL4srJWTfLT6+FfWZfn99RyTxHB2h9Rs1z
         iiKHXK4H5Hjmg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6FDC5E270DF;
        Sat, 22 Oct 2022 01:28:35 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fixes for v6.1-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0h6OWoyO3om5GjsU-6+jPcXPiR-p+4LA22YD6-ptpnhbg@mail.gmail.com>
References: <CAJZ5v0h6OWoyO3om5GjsU-6+jPcXPiR-p+4LA22YD6-ptpnhbg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0h6OWoyO3om5GjsU-6+jPcXPiR-p+4LA22YD6-ptpnhbg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.1-rc2
X-PR-Tracked-Commit-Id: 3f8deab61ea86d738a1e7fdf95e9ad2bf08d14b8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9d6e681d33943e7e5b26b945e680a71311683795
Message-Id: <166640211544.11783.7532023669913523373.pr-tracker-bot@kernel.org>
Date:   Sat, 22 Oct 2022 01:28:35 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Fri, 21 Oct 2022 20:48:42 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.1-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9d6e681d33943e7e5b26b945e680a71311683795

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
