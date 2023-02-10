Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37604692A44
	for <lists+linux-pci@lfdr.de>; Fri, 10 Feb 2023 23:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233184AbjBJWhk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Feb 2023 17:37:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232950AbjBJWhj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Feb 2023 17:37:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360651B55B;
        Fri, 10 Feb 2023 14:37:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4C2B61E8A;
        Fri, 10 Feb 2023 22:37:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2C743C433D2;
        Fri, 10 Feb 2023 22:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676068658;
        bh=Bxm2J+euH2y9G/idbo6RFJeHE4FW3ZdKvaFx+mNEi04=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qbjxMI+hXx+1RZiCrpYcuEtJu9YE9L8JvR8BWH6oRe9zqO+P2sqjWCletwv2PPfgF
         YOef3vjqaSXEm593T2nNs/g1X2uMVGbk2szpebMUeBPkPYvgKgxJmCK6ZVjKCfCcyO
         kWpDgUN6kYLcRiVV907z0R18Zoxxi0KNx761/sAf79iaKb+AjmqPa5yefj5OzHNQ2F
         C8B27kIfgNlRgolXWejCmMG4kuVhOTw4fB6ZoR5OS9J3YZemiZB2cPfxFV3CYQfwM1
         zse+TUFXD4cFkezelqPPZ8V40DfdWNl7IoYoqOikbf77et1w5Qh3TZJrD7sMpyUitx
         PhQhNJyu3j1Xw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1812AE55F00;
        Fri, 10 Feb 2023 22:37:38 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230210215735.GA2700622@bhelgaas>
References: <20230210215735.GA2700622@bhelgaas>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230210215735.GA2700622@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.2-fixes-2
X-PR-Tracked-Commit-Id: ff209ecc376a2ea8dd106a1f594427a5d94b7dd3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4cfd5afcd87eb213f08863b6f34944978b0a678d
Message-Id: <167606865808.6495.9583725953592138944.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Feb 2023 22:37:38 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Thomas Witt <kernel@witt.link>,
        Vidya Sagar <vidyas@nvidia.com>,
        Tasev Nikola <tasev.stefanoska@skynet.be>,
        Mark Enriquez <enriquezmark36@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Fri, 10 Feb 2023 15:57:35 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.2-fixes-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4cfd5afcd87eb213f08863b6f34944978b0a678d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
