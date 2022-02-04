Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2484AA45A
	for <lists+linux-pci@lfdr.de>; Sat,  5 Feb 2022 00:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236204AbiBDX3a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Feb 2022 18:29:30 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:35354 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378171AbiBDX31 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Feb 2022 18:29:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0CB3CB83971;
        Fri,  4 Feb 2022 23:29:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B7555C004E1;
        Fri,  4 Feb 2022 23:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644017364;
        bh=HqXYjSPcs1Nd7maNYa4Zhc0ns4YFkZt7J2ARyltZRxA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=owh0Ts0wUy4Nv2fAM+DEkfgd3g/h4Z4rf5xrk4loYkO4ZlyhWcpdXBH+gTQeo9pSx
         /oUCiIFfyPMwJu97oaft7KDNrNeIAc0kD9HkFCFfzO5y+SYPlNN3DFjFT4U8zggCDq
         DmDG2QccL2K/ZcqiXb3+lQaMLeAdzG2VmIVN9IgmPv/fnQgbkVRKs1IWZvE5j6mYdt
         1pQ9LseS+n/RCE2PzjAHS+BQ1YpV+cWjfu5h09LPZ8ntHDQrona64OXOHyYnJ1kAVi
         YoxPx/g709fuceAcxnnFYEg7ktmOJ4rQN1Q7dOW6szL8jbbj+SPUQPKjmoaYTHlhGa
         8SDPzQYfqRYkg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A61F4C6D4EA;
        Fri,  4 Feb 2022 23:29:24 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220204213034.GA217708@bhelgaas>
References: <20220204213034.GA217708@bhelgaas>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220204213034.GA217708@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.17-fixes-3
X-PR-Tracked-Commit-Id: 7dd3876205df92e07d824fe2264b38e0b8a9eec1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e09e1a40639ba10eff22984003c201db57fe033a
Message-Id: <164401736467.17432.13563131203041715100.pr-tracker-bot@kernel.org>
Date:   Fri, 04 Feb 2022 23:29:24 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bean Huo <huobean@gmail.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tom Joseph <tjoseph@cadence.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Fri, 4 Feb 2022 15:30:34 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.17-fixes-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e09e1a40639ba10eff22984003c201db57fe033a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
