Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE06064CF15
	for <lists+linux-pci@lfdr.de>; Wed, 14 Dec 2022 19:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239011AbiLNSFt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Dec 2022 13:05:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239287AbiLNSF0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Dec 2022 13:05:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D6F222BD;
        Wed, 14 Dec 2022 10:04:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 32BCBB819B8;
        Wed, 14 Dec 2022 18:04:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E4C2DC433EF;
        Wed, 14 Dec 2022 18:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671041083;
        bh=cZ/k0V0RtH/clyYfhp9l3wrlGVl8EtOcsfjmtnrwuRA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hB74D+FUZJ+xHFzEf0tIvehoRnwVtvb9K3UhMtwVZvzxF/0Wpab9xsNvgHmMN0nuq
         cUH2Qg2X4R+hH3rW91RMxmfIhdhtQRgHmsDvJinnX6b+w6wMTczys0aXHNLJR9+U6q
         PiMrcpJgh857BqfyYT20Mrjeu975toTsDkZntBQF50uLA0ll2BOZtx0ADglS+hzGxH
         Zfrx/Ka+XG9lXYqfJpK5ioIpdRyhl07mM4VBLBE9sIQQDP5kJnLqHu0hUBtGGgqZhg
         tF6NIIo5dyXTDTubzpD+psDzXkzOXZdNNHN8iJq/QDcqyDp97uKCDZct2jvRnabAG1
         3VyLxlfRYkewQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D39DDE29F4D;
        Wed, 14 Dec 2022 18:04:42 +0000 (UTC)
Subject: Re: [GIT PULL] PCI changes for v6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221213233050.GA218218@bhelgaas>
References: <20221213233050.GA218218@bhelgaas>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221213233050.GA218218@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v6.2-changes
X-PR-Tracked-Commit-Id: f826afe5eae856b3834cbc65db6178cccd4a3142
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c7020e1b346d5840e93b58cc4f2c67fc645d8df9
Message-Id: <167104108286.17244.9350901660666471628.pr-tracker-bot@kernel.org>
Date:   Wed, 14 Dec 2022 18:04:42 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Thierry Reding <treding@nvidia.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Tue, 13 Dec 2022 17:30:50 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v6.2-changes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c7020e1b346d5840e93b58cc4f2c67fc645d8df9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
