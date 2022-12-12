Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE1964AA92
	for <lists+linux-pci@lfdr.de>; Mon, 12 Dec 2022 23:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbiLLWqt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Dec 2022 17:46:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234020AbiLLWqa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Dec 2022 17:46:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0457A1C112;
        Mon, 12 Dec 2022 14:46:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 51A2BB80E7A;
        Mon, 12 Dec 2022 22:46:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F2487C433D2;
        Mon, 12 Dec 2022 22:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670885184;
        bh=MstQfPbhIAU7j4DKA3OFGf5pW7AaPX/kJtPtU1oAINA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=duJ/O74l5PkZ/768MtkNWpVY9AIK+xovaiy1zKdLSZQHbW3NwNQ0s8RFiev68WktA
         qQXuJqasT7wIonS+TJU/iXLe015GCKV2HVhl/a94a0GDa37il2RAHV403eHlZ7Vtux
         VHF/to7MQsoPLKeIpsj+kk+nMno8GuLRy1EEhg4yBUhhLNYfRlLouQ4Go/xkHRSBVi
         LT4rluBqUwK4Yjib6q4kYRAhjJV8EEQApolXiBvLUIiWGxgeZmoUNwdGfvBHt7q9Fz
         wAKge3MVXG7aLxP35w3C10asxcYU4clvM3srWGUB5fu4VmBBFGd6Gg7YnRvyfYiKmg
         +vUbYZ+6DwqgQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DFC4CC00448;
        Mon, 12 Dec 2022 22:46:23 +0000 (UTC)
Subject: Re: [GIT PULL] Compute Express Link (CXL) for 6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <6395383a608a5_4962d294e9@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <6395383a608a5_4962d294e9@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <6395383a608a5_4962d294e9@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-for-6.2
X-PR-Tracked-Commit-Id: f04facfb993de47e2133b2b842d72b97b1c50162
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c1f0fcd85d3d66f002fc1a4986363840fcca766d
Message-Id: <167088518390.6748.16216442840433238533.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Dec 2022 22:46:23 +0000
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     torvalds@linux-foundation.org, linux-cxl@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Sat, 10 Dec 2022 17:54:02 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-for-6.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c1f0fcd85d3d66f002fc1a4986363840fcca766d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
