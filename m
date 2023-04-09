Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731866DC0D5
	for <lists+linux-pci@lfdr.de>; Sun,  9 Apr 2023 19:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjDIRRJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 9 Apr 2023 13:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjDIRRH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 9 Apr 2023 13:17:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BA630FA;
        Sun,  9 Apr 2023 10:17:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B932960C0A;
        Sun,  9 Apr 2023 17:17:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 25C49C433D2;
        Sun,  9 Apr 2023 17:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681060626;
        bh=+60+evKe12vCKD4ZmG92NX7ESeM+VD36QLizMcxRvO8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=m0QuGRTQt/TiYzszjrmW2W+Hzd3bBSvH6/BvNT0MGNsRPOX99TUxnjKgsudN/uoez
         bWXY5nStENWbLthBC22254T7TqmeSRKoWHDbUldgxv6L0yhh8xApQXeWC+Kc3qYJ3b
         +P0pZrOT21DcqZPff26Qif9kVPP63VomAOF6n51qE03b+fvTUtKSHdvQTdkRvpatW1
         Gh9fMmhKgS81ukJGTCnyztZwctWHkebQU1lf05G6vIUA4JtomgJRvoUN0Saq9hivVU
         N56ONh/cPTEUKkB43jK/OiO/L5UH2AK7SzAuifHxXueGduwOOx8LvUyVs/MpvGfk9A
         ouQqLPEec1AmQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 10BCCC41671;
        Sun,  9 Apr 2023 17:17:06 +0000 (UTC)
Subject: Re: [GIT PULL] Compute Express Link (CXL) Fixes for 6.3-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <643269b8b7cb2_93aa294d7@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <643269b8b7cb2_93aa294d7@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <643269b8b7cb2_93aa294d7@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-fixes-6.3-rc6
X-PR-Tracked-Commit-Id: ca712e47054678c5ce93a0e0f686353ad5561195
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c08cfd6716a170c549c1140f1d4a0e749c888a79
Message-Id: <168106062606.14171.5846171180708518780.pr-tracker-bot@kernel.org>
Date:   Sun, 09 Apr 2023 17:17:06 +0000
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     torvalds@linux-foundation.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Sun, 9 Apr 2023 00:31:04 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-fixes-6.3-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c08cfd6716a170c549c1140f1d4a0e749c888a79

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
