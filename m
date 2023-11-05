Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91D67E121D
	for <lists+linux-pci@lfdr.de>; Sun,  5 Nov 2023 04:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbjKEDCE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 4 Nov 2023 23:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbjKEDCD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 4 Nov 2023 23:02:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37555184;
        Sat,  4 Nov 2023 20:02:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D6550C433C7;
        Sun,  5 Nov 2023 03:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699153320;
        bh=FQR9ATd8ddIZBHiEIToFW1Ari4GxDoC9kMLc3FxoHZc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Kal+1POyFd7cgBEAhOAWQlwlhZjG67oPkD2r7enx8rEUceh/c2TNhZIj1Xek8fK9O
         im5S4NqVxpyr9OCEXqc5YhIwd5jAI+Gfta51My4TNb3QRUo3q56eHbGAuzugjaje+s
         Ka5SvUHAFb7VEtwJRdBv9G+9u9gTj3seNIPwOZ08Vc79jtFjlnfg1CJeohrfI1kdgt
         1IRcUYTAEOLs1XVfpYUC+soGrJVMA4Nt8HqTGL/BjDKpo0f36Gpi9bL1Bcao/FiBbp
         R6DTNWefXWt25HXR8qN2zDJgJrYfCazja2TncCHlYiK0qt3jraA623L3ZkDnF/XE9G
         9t+lmIPaqseoQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C4AD9C4316B;
        Sun,  5 Nov 2023 03:02:00 +0000 (UTC)
Subject: Re: [GIT PULL] Compute Express Link (CXL) for 6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <6546aecbae94b_3f602948@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <6546aecbae94b_3f602948@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <6546aecbae94b_3f602948@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-for-6.7
X-PR-Tracked-Commit-Id: 4b92894064b3df472b2cf5741c7f080e16dcd1ec
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b8cc56d0414e2330d9fe05342843512b1ad8cdb7
Message-Id: <169915332079.2133.9651943876124044697.pr-tracker-bot@kernel.org>
Date:   Sun, 05 Nov 2023 03:02:00 +0000
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     torvalds@linux-foundation.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Sat, 4 Nov 2023 13:51:23 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-for-6.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b8cc56d0414e2330d9fe05342843512b1ad8cdb7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
