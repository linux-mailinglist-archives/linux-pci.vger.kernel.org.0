Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A2F636E40
	for <lists+linux-pci@lfdr.de>; Thu, 24 Nov 2022 00:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiKWXUV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Nov 2022 18:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKWXUU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Nov 2022 18:20:20 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E4811578C;
        Wed, 23 Nov 2022 15:20:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6E5C9CE27E8;
        Wed, 23 Nov 2022 23:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8D80EC433C1;
        Wed, 23 Nov 2022 23:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669245615;
        bh=3uEi4qCPx5D9Z45/cBLDuq/p9O3Rh3dGGUxklC8rMoY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MyjxmyIoxrD3gal0dU23UXiNAKWa1jTVzsBFi0BiPo4F28GbSNEpEmcRUA9nRV3aN
         4IZUc9/GEqNLA5vGmWKqqKkhGvdZwwSPR/XUmHiwNmTFkoiyzfiV5o2ttqc61XEZle
         UbquuqPYbWYBcv7Mbbr1HGxkoSSwlwgKaFH1/cB7fWb1L8CDOcpHKAcRsumb6LDCqv
         KP0LkAWNqnFk4dokzXVsr/fzZmeEDpZ+nTYbzkgH/OLPwkb++3iKo1rsB8oScd2RKb
         nvqpJ7pqMmKWMiZwXRHHJKAVUwyKWevIatKQ2TKo24GSqQy46kkTSH2FHPAifCGCF4
         9ZzTBSuIFtTig==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 77770C395C5;
        Wed, 23 Nov 2022 23:20:15 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221123211318.GA281503@bhelgaas>
References: <20221123211318.GA281503@bhelgaas>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221123211318.GA281503@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci-v6.1-fixes-3
X-PR-Tracked-Commit-Id: ac9ccce8717df5aa5361c0cea9d8619f6d87af3c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c3eb11fbb826879be773c137f281569efce67aa8
Message-Id: <166924561547.1739.12477298726846211908.pr-tracker-bot@kernel.org>
Date:   Wed, 23 Nov 2022 23:20:15 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Wed, 23 Nov 2022 15:13:18 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci-v6.1-fixes-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c3eb11fbb826879be773c137f281569efce67aa8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
