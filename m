Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F754E7CF7
	for <lists+linux-pci@lfdr.de>; Sat, 26 Mar 2022 01:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbiCYVIg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Mar 2022 17:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbiCYVIf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Mar 2022 17:08:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB131EC611;
        Fri, 25 Mar 2022 14:07:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A53861D41;
        Fri, 25 Mar 2022 21:07:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3701C004DD;
        Fri, 25 Mar 2022 21:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648242419;
        bh=M/x6qBkGqzdDZYrnIYl79Nsx6Wan8hcfIryiBqOzO5I=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=oHTSL0AdIkf9Cv+im8pwOXhCHYfDd7iF6VUUF6PhPG9X+Ck5X5Q5VIjhLv5SBkNg2
         es/EFrb6Nqdee5TZSpakjscXF4Ag7I09NDeejSHNuj7rEw4woWybTIGVKtIAwZhSi5
         GR+yBVPJE81rKIAJa5t3OfdkXXv37C9b7fMJNbjOX1JNrhwe5jxA/nfJm8dPD/pHhb
         HG2oq0Ox1eBwZbY+9Oirlgmpg0EZY6s1SBwzjUQMB2pB8Z++jiorirbTXP2RRRRnha
         zYfa5t8HLmSuBAtZZSRbxK+ZvW/sHzfD1nurD2PC1ipMGNE8F2fJI3PHccY8K5oOA0
         VjL65qBv1FhGA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C118BE7BB0B;
        Fri, 25 Mar 2022 21:06:59 +0000 (UTC)
Subject: Re: [GIT PULL] PCI changes for v5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220323211743.GA1372301@bhelgaas>
References: <20220323211743.GA1372301@bhelgaas>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220323211743.GA1372301@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.18-changes
X-PR-Tracked-Commit-Id: 611f841830aa5723ea67682628bd214cbc18df41
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 148a650476955705482dd57e7ffcf105d8b65440
Message-Id: <164824241978.8431.17098189777835562632.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Mar 2022 21:06:59 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Wed, 23 Mar 2022 16:17:43 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.18-changes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/148a650476955705482dd57e7ffcf105d8b65440

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
