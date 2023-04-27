Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F180F6F0C79
	for <lists+linux-pci@lfdr.de>; Thu, 27 Apr 2023 21:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245220AbjD0TUc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Apr 2023 15:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245156AbjD0TUT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Apr 2023 15:20:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE63421B;
        Thu, 27 Apr 2023 12:20:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC40863F54;
        Thu, 27 Apr 2023 19:20:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5D83C433A0;
        Thu, 27 Apr 2023 19:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682623212;
        bh=PQcClj4T45k8WOXXtuczKrpEr9a9LRxMPo0FWa9Qp1c=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OC6i7A4KsHNJQW+4CYwvDG7dleE7wUr2xknOPCNg2WYT0tvVFUdWY/8N/I13w8Lb1
         Hkj3MteGPaIbK+/6GRUmZDML52gpRCyzWoNK+eIWt6vDBX9ErVI7wP+mMSssCXws4w
         PzxYI+w1ars/yK4bwCLBtBaX3FvxM+JU16JXahw4csY68aXUzv1EPCrFv9Mc+a+xYe
         S0UTv2t/2KdJkyWwmGx6XOW6abMoXmUE2Uv66VBlkErp53MeCFJp72ZOh2Q4gdv88b
         RbXlmy2+2fMD8L2ECK8tgJKlFd6Tarl67TqUWwLXsX5LDbvPI+wmDRhX7PiVaoGg9Z
         bczZswfuFxoIA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9DBD4C73FF3;
        Thu, 27 Apr 2023 19:20:12 +0000 (UTC)
Subject: Re: [GIT PULL] PCI changes for v6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230425200936.GA66754@bhelgaas>
References: <20230425200936.GA66754@bhelgaas>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230425200936.GA66754@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.4-changes
X-PR-Tracked-Commit-Id: 09a8e5f01dfb30667a8f05e35c1cc073cb4fd134
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 34b62f186db9614e55d021f8c58d22fc44c57911
Message-Id: <168262321264.21394.12130531173337101576.pr-tracker-bot@kernel.org>
Date:   Thu, 27 Apr 2023 19:20:12 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Tue, 25 Apr 2023 15:09:36 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.4-changes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/34b62f186db9614e55d021f8c58d22fc44c57911

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
