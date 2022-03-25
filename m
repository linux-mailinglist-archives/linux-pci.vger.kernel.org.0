Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAC94E6C1B
	for <lists+linux-pci@lfdr.de>; Fri, 25 Mar 2022 02:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357471AbiCYBka (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Mar 2022 21:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357648AbiCYBiC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Mar 2022 21:38:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31D2C1C9A;
        Thu, 24 Mar 2022 18:35:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FD5360A66;
        Fri, 25 Mar 2022 01:35:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9D95C340EC;
        Fri, 25 Mar 2022 01:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648172148;
        bh=EfccCXCDP9v3AWrkINxr6QnCr0Zhsre9PjSPa2Y6WM4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=X5geBuMWoA/whgbBM7byqLXiguLQ4wS4qINeB5sDqAG/51qbp7rUA6jCUYLXjDaVg
         9W+1FvfUWE4CpFNiWWTdHaJ+4PyWA6ChtFQkL9hghxP2WgFKxJ/ENSGOvywCkUGNP5
         J+506tCFulzuhNsU/IeU3weu6LXpHp4VRD/C3facp4r7mSardcfWow0b0csmQ03ark
         Iydr0SG57qNbtGFTu0jSeBenqYUlRksaEJEsx58/sc5U5GnonxMcnJUXx7KVp/nIKK
         i7mX3E9rwl8e9YTprwzZpwGN46c3DC66Gs2pI9MRvBbK/gG+AwyBAow/3y8P4188rv
         N/6DLOBB1EQog==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B6739E7BB0B;
        Fri, 25 Mar 2022 01:35:48 +0000 (UTC)
Subject: Re: [GIT PULL] Compute Express Link update for v5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPcyv4jE=wfmfWS94WyMWhHwub0jJ4Vm6hnz8G3HJ9rd8pXKSA@mail.gmail.com>
References: <CAPcyv4jE=wfmfWS94WyMWhHwub0jJ4Vm6hnz8G3HJ9rd8pXKSA@mail.gmail.com>
X-PR-Tracked-List-Id: <nvdimm.lists.linux.dev>
X-PR-Tracked-Message-Id: <CAPcyv4jE=wfmfWS94WyMWhHwub0jJ4Vm6hnz8G3HJ9rd8pXKSA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-for-5.18
X-PR-Tracked-Commit-Id: 05e815539f3f161585c13a9ab023341bade2c52f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b9132c32e01976686efa26252cc246944a0d2cab
Message-Id: <164817214874.9489.1769734777447328707.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Mar 2022 01:35:48 +0000
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-cxl@vger.kernel.org, Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux PCI <linux-pci@vger.kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Tue, 22 Mar 2022 16:36:48 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-for-5.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b9132c32e01976686efa26252cc246944a0d2cab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
