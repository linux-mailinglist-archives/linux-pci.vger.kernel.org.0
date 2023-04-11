Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0466DE471
	for <lists+linux-pci@lfdr.de>; Tue, 11 Apr 2023 21:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjDKTE1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Apr 2023 15:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjDKTE0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Apr 2023 15:04:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB50440D5;
        Tue, 11 Apr 2023 12:04:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 762A662576;
        Tue, 11 Apr 2023 19:04:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D44DEC433EF;
        Tue, 11 Apr 2023 19:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681239864;
        bh=+9I/F41PQ6iADnl1oeZ74xC8JfG5sSUnoHlcCzH5EY4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TpuDFf6Ri1U5RTrAZfXqEimyH9XUExsXKddrNABPDMPK8gi60s7nePAUsEOEb4pzT
         wuCB6lksiETI4WVHQimMNoZ2ZEw94VMqdIyV40O0JPmDkHEN++KbtsFxB+3W2qxtcY
         Vf5ezG/lNOsg5ewL+T3hq6Zdd/YaNEKh8JXpWUUDsDcFnmw4E1bF70BhffYjHCE0ek
         G8gujMjlTjtp69Jh7IYrYkXG/Xi2RsTphFevNs+vaTovkgAkGtdS4c7IAZ6BqVHw3J
         APtUPDOYdr8+3LkfMJ1Hs7iJYpotjRcc8stW5oUjfPEJigy8Cf1xh85yfhWuCMVbdK
         OtKirk4KVVHdQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BE73DE52443;
        Tue, 11 Apr 2023 19:04:24 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230411184227.GA4167614@bhelgaas>
References: <20230411184227.GA4167614@bhelgaas>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230411184227.GA4167614@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git pci-v6.3-fixes-2
X-PR-Tracked-Commit-Id: 30ba2d09edb5ea857a1473ae3d820911347ada62
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e62252bc55b6d4eddc6c2bdbf95a448180d6a08d
Message-Id: <168123986476.10373.1428412764317577027.pr-tracker-bot@kernel.org>
Date:   Tue, 11 Apr 2023 19:04:24 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Thomas Glanzmann <thomas@glanzmann.de>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Arnd Bergmann <arnd@kernel.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Tue, 11 Apr 2023 13:42:27 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git pci-v6.3-fixes-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e62252bc55b6d4eddc6c2bdbf95a448180d6a08d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
