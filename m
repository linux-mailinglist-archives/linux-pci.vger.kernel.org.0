Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077716F2A94
	for <lists+linux-pci@lfdr.de>; Sun, 30 Apr 2023 22:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbjD3UI0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 30 Apr 2023 16:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbjD3UIU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 30 Apr 2023 16:08:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47B1170C;
        Sun, 30 Apr 2023 13:08:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E93960BBA;
        Sun, 30 Apr 2023 20:08:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 83BBCC433D2;
        Sun, 30 Apr 2023 20:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682885290;
        bh=3yJMy6Ws/MifcnWZlneF421HOV4bniHgCFt7BwUpq/4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=aUaaSDgLDfLiqvyM8Au8i/PPmOMCuAYLMdLm7fcgCtvKSeIYw8YqbHXs17kj3gnNP
         lYDtBqKl+NaMTqHhF4wLGp6jS4M4RlI+/ouvngU5+8DapWuFWKgIad5K4/sZmFTsYd
         B2fxeQcMqqerpuSrCNM49uS4Jjst21/qwufOEUnvDEgOww3f3YdFhcJGnGWQmDAToH
         z8IYI/wkuPgZ2+ILYQtKN+FYaAymk+XNCBPD1r3U6D5fRpxOszc9TjW7h4rJZId0FT
         sSqEaWxT9TaGnALzGOhY4L4RtEbZ6plh5h5C+icW/cVQu+8cGIvaf3/kh4cn1X14Ni
         /7Z9bdxGSd2gg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 72860C395C8;
        Sun, 30 Apr 2023 20:08:10 +0000 (UTC)
Subject: Re: [GIT PULL] Compute Express Link (CXL) for 6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <644da9e8104cd_8ca7294c2@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <644da9e8104cd_8ca7294c2@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <644da9e8104cd_8ca7294c2@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-for-6.4
X-PR-Tracked-Commit-Id: fd35fdcbf75b5f31dba6c284886b676bb2145fe6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7acc1372113083fa281ba426021801e2402caca1
Message-Id: <168288529045.32747.3467719057226739155.pr-tracker-bot@kernel.org>
Date:   Sun, 30 Apr 2023 20:08:10 +0000
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     torvalds@linux-foundation.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Sat, 29 Apr 2023 16:36:08 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-for-6.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7acc1372113083fa281ba426021801e2402caca1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
