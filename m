Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582AB4F0559
	for <lists+linux-pci@lfdr.de>; Sat,  2 Apr 2022 20:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244789AbiDBSMi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 2 Apr 2022 14:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244778AbiDBSMh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 2 Apr 2022 14:12:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2D41B780;
        Sat,  2 Apr 2022 11:10:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26C3EB80B51;
        Sat,  2 Apr 2022 18:10:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BE934C34111;
        Sat,  2 Apr 2022 18:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648923042;
        bh=KJjrQrWl2FusWB1BVg5NXpOJOA99gIR/4LmDUjDO/fk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=l4Ksr5IL3SAy58z6ZubEiACfLegz/qUAaB37BZrEqnGQZCiPaMJ+R3/iy28GS03dK
         tOYjnxQ2GZrSRe1J+pdJJhkJQ1YQoC0w314cVR5K7wo/tb664bM7k12mHlriPMCNyj
         vZ68Ll5r9QZAH1AXNkyqFPvHU8kye2n3WVMimvGCZj2WYseaxA70UkYfe2crYduwCu
         w9FDU++meSpXVB2Fwcj+pwF5eLTP6f4TMLnsXLAdTfdRm+vsEdbZghO4ekJxy7XY01
         VHtnbm1C3PIkW1dQa5Rj+uJ1JsNRza4bwqb/08mqAv6QRsPRKv6MOELSR8+yMxpFuC
         QPHCiZKnYN/Sg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A882FF0384A;
        Sat,  2 Apr 2022 18:10:42 +0000 (UTC)
Subject: Re: [GIT PULL] PCI changes for v5.18, part 2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220402172137.GA272816@bhelgaas>
References: <20220402172137.GA272816@bhelgaas>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220402172137.GA272816@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci-v5.18-changes-2
X-PR-Tracked-Commit-Id: 22ef7ee3eeb2a41e07f611754ab9a2663232fedf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9a212aaf95369d56f811b60a1ebdfa7e6b0ca030
Message-Id: <164892304268.15050.6825968175560781882.pr-tracker-bot@kernel.org>
Date:   Sat, 02 Apr 2022 18:10:42 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        YueHaibing <yuehaibing@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Sat, 2 Apr 2022 12:21:37 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci-v5.18-changes-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9a212aaf95369d56f811b60a1ebdfa7e6b0ca030

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
