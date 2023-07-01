Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0AF744A75
	for <lists+linux-pci@lfdr.de>; Sat,  1 Jul 2023 18:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbjGAQMG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 1 Jul 2023 12:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjGAQMF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 1 Jul 2023 12:12:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89470273E;
        Sat,  1 Jul 2023 09:12:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1545C60B52;
        Sat,  1 Jul 2023 16:12:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79BAEC433CB;
        Sat,  1 Jul 2023 16:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688227923;
        bh=Hv37umIFK/WD8cqrC/tQE/2pjsRH2M0nt4EPSTaRIQQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=vFRr2UnmiLQ7PeivBYjRxAEQvtF1O9d+Tm62AjYbMMBtOVaC5rfAIYZexakfC4+iv
         WAuiPwM9h6J3+MqS3o+Am7JSK/mgGiFtMMwxPcDRvO2Kp79aAIR65OEb88iWLeryih
         fYslW/f4Wwms8q7gr9EieopVdJ5OnF7WZ77uIiwG9si96dImM4P1fOVaGVKtj3O0sP
         NyczG2kUCk61KwXrz58GMgm0aCDRkibTUc3E4PubKF0C5/26F0s1UwIFwoc0WX3K/e
         tK5e8Hj5R/ETBA7qEyINhAnZtebU7HZ/eq3EyxAWiHEMxQ98Yzdq3xGEjmGsKUsZQC
         9AS0JdJkRG4qQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 67207C0C40E;
        Sat,  1 Jul 2023 16:12:03 +0000 (UTC)
Subject: Re: [GIT PULL] Compute Express Link (CXL) for 6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <649f6e34d4386_14494294e2@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <649f6e34d4386_14494294e2@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <649f6e34d4386_14494294e2@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-for-6.5
X-PR-Tracked-Commit-Id: fe77cc2e5a6a7c85f5c6ef8a39d7694ffc7f41c9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d25f002575146d67b5ebea541e6db3696c957c25
Message-Id: <168822792341.621.2420979303551814095.pr-tracker-bot@kernel.org>
Date:   Sat, 01 Jul 2023 16:12:03 +0000
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     torvalds@linux-foundation.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Fri, 30 Jun 2023 17:07:16 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-for-6.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d25f002575146d67b5ebea541e6db3696c957c25

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
