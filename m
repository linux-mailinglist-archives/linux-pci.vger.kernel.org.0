Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9220B5FFCAE
	for <lists+linux-pci@lfdr.de>; Sun, 16 Oct 2022 02:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiJPAPo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 15 Oct 2022 20:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiJPAPn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 15 Oct 2022 20:15:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82BE3FA3A;
        Sat, 15 Oct 2022 17:15:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 91359B80B47;
        Sun, 16 Oct 2022 00:15:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3F9BAC433C1;
        Sun, 16 Oct 2022 00:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665879340;
        bh=J70ZjdCmIKdmPSrWtliery7yD5P5VZbS3rv00eI3b/g=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=p2fHKXtDe04pnpp2KYtVqQKR1Qv8CAOe1V2zUve+P/g9mXRxifbx0aaCJK988y+Ua
         4hMU3jaobdKZthCuMfwpurBtOMWO3HPERkdXH9uyVI+9M92czFHp5PXuETyOAyz3bu
         RsuFe12MrYtzWbhp2ecC8ppV/FpN2afzivObCZqFt6eeOP4bfTmf3mftYURbPFmtuw
         p3+Dijl8nlgthrvIIgBSifvLt0dugdKrbNKixPJhzm/L+W1pVBqAmcFg6vJgPhYPn5
         IBFsuNHUv55L8IC9jIJGlRfqNsBciMW3XaxXWL+DBwBsMmR6cytp1ZSFJfaf9qzBow
         yJQVZwFsqJX8g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2B264E29F31;
        Sun, 16 Oct 2022 00:15:40 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221015152736.GA3574429@bhelgaas>
References: <20221015152736.GA3574429@bhelgaas>
X-PR-Tracked-List-Id: <linux-cxl.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221015152736.GA3574429@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v6.1-fixes-1
X-PR-Tracked-Commit-Id: 5632e2beaf9d5dda694c0572684dea783d8a9492
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 41410965c3629367cbd0889dc0c8bddfb9e8a2d5
Message-Id: <166587934016.18523.586383078430762257.pr-tracker-bot@kernel.org>
Date:   Sun, 16 Oct 2022 00:15:40 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Chris Chiu <chris.chiu@canonical.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Lukas Wunner <lukas@wunner.de>, linux-cxl@vger.kernel.org,
        linuxarm@huawei.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Sat, 15 Oct 2022 10:27:36 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v6.1-fixes-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/41410965c3629367cbd0889dc0c8bddfb9e8a2d5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
