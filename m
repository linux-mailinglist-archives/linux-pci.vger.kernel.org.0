Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 008866E9FA5
	for <lists+linux-pci@lfdr.de>; Fri, 21 Apr 2023 01:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbjDTXG4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Apr 2023 19:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbjDTXGy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Apr 2023 19:06:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0588240DA;
        Thu, 20 Apr 2023 16:06:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CA9E61229;
        Thu, 20 Apr 2023 23:06:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 06C7AC433EF;
        Thu, 20 Apr 2023 23:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682032012;
        bh=YPEThUCmUuzqTAxM0tLwaGorSYVzBQPritSzHypwb9I=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Vdmo48Mjm6W9AkEXp2z+8oF0GEbTJhR6sENSm4ZAzhEalXJReIzjoZUcmy+4HvSJl
         gA18UsSDpwGqr5qLQtWEvogHtidJMPeAzdowtUztsJrCvGwH3L1Nunn6DQYvWNaQkw
         t5cQRcN5bfk8L4dHuR1xrEfJUc5dR7j7tz5GfGMWTgoWyA/Ns4jjdXfJMNeQVH9E34
         /fiFHC9Vu9E/n+JhWZkmysVsIbmg3ycMkKYyGpK2LU4BN/ncJHZ3vmPXP6vubLCxBf
         MNWqM7dkPKgvuLdqjYgq8TK9mBAXjdjsGCfjhKN4KL+IYDJEwRINSSbIIjZZwl4juA
         IaOuT/H/Plq+A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E341BE270E1;
        Thu, 20 Apr 2023 23:06:51 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230420202732.GA322005@bhelgaas>
References: <20230420202732.GA322005@bhelgaas>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230420202732.GA322005@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.3-fixes-3
X-PR-Tracked-Commit-Id: 0d21e71a91debc87e88437a2cf9c6f34f8bf012f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b7bc77e2f2c714c82aa723445d98fa4c2fb63e90
Message-Id: <168203201192.12702.13834466231225845676.pr-tracker-bot@kernel.org>
Date:   Thu, 20 Apr 2023 23:06:51 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Donald Hunter <donald.hunter@gmail.com>,
        Binbin Zhou <zhoubinbin@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Thu, 20 Apr 2023 15:27:32 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.3-fixes-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b7bc77e2f2c714c82aa723445d98fa4c2fb63e90

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
