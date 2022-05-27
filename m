Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6CD5368FE
	for <lists+linux-pci@lfdr.de>; Sat, 28 May 2022 00:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354894AbiE0Wpq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 May 2022 18:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234011AbiE0Wpp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 May 2022 18:45:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E272F8217E;
        Fri, 27 May 2022 15:45:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E6D3614C6;
        Fri, 27 May 2022 22:45:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DD78CC385A9;
        Fri, 27 May 2022 22:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653691543;
        bh=CLm3D+RIorKLdn9LDVB11Tw9YDagVwmHRE1Mzvwm1j8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Tl7QCyFMmvH591utzRbo3Gx5fiHXJQMcjrPsY3zYWfis14C7nbcwgTvilKeoBJ2RA
         egD9H7VUgMKw7/RtxI+3CUw6ZTsOPMsh7L4CfTwcgC3MRunaOSbK59XgA4Mm5fNle+
         zh+3C3GVtXiAKfpOv6P+6NNNeqA17M5Ue+fBoKB0kpK8R760BrNgUVt831ZGwZiLdO
         eXqYm6Me+2sMJuWxBVi0/03CVfme6TznzCmYT/PFpXSJOaulOIPd5J3yADgKXTrqlQ
         so0OurVMxwOP1X1YdG/pa5I7yCncoFDD6OrOjGd7oRORvoB+6V7JvsPY0drBHOCTEZ
         N2VGRytnHwVOw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CB64AE8DBDA;
        Fri, 27 May 2022 22:45:43 +0000 (UTC)
Subject: Re: [GIT PULL] PCI changes for v5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220526223320.GA419755@bhelgaas>
References: <20220526223320.GA419755@bhelgaas>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220526223320.GA419755@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.19-changes
X-PR-Tracked-Commit-Id: 32f479d05a445b52cb7fcbe6e06f579fb852be71
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3cc30140dbe2df9b5ac000898e0ae3d1df980f2c
Message-Id: <165369154382.860.14898902704613878914.pr-tracker-bot@kernel.org>
Date:   Fri, 27 May 2022 22:45:43 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Thu, 26 May 2022 17:33:20 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.19-changes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3cc30140dbe2df9b5ac000898e0ae3d1df980f2c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
