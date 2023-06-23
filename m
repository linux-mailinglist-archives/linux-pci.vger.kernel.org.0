Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C19873AE25
	for <lists+linux-pci@lfdr.de>; Fri, 23 Jun 2023 03:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbjFWBDl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Jun 2023 21:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbjFWBDh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Jun 2023 21:03:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC2DE42;
        Thu, 22 Jun 2023 18:03:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48057618CD;
        Fri, 23 Jun 2023 01:03:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9F2C1C433D9;
        Fri, 23 Jun 2023 01:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687482214;
        bh=2zGOMJ7byHxtsvWQDbQ3IVYrQxvs4qsFdYRs9tS20NY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IER3PUc6gRi52oQNlSOJjxhT+uBjMVmBeaYwoOPz9lMA0m9mI/Z3vK4nVkQfUtSp9
         uGSbvN6bEcOif452zd7Tgff9Vzev5ogZQmtngmYaTT/NT9dcVttbdTqLZs6QiI84Mz
         pSYlmwbAYIetsYYv+iNtmRZPtfgoZsmRxmYboQRcrTQoVxs5/0T9Ty0MmQS3neZZGv
         cwYevWYRBVXnRZ3ZVkU1Fph+Dk15CM+lnFkp/ZQ57ckEB8TTKMoZcOdVdIemZoohoe
         ElxwWDz2OmaLIpvwnB0TANzZzMIr9l6uxNB4tI+d78upKFnVG/zqwbLD9t6KFr++eb
         h7Ur2eDSf1/1g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8C575C691EE;
        Fri, 23 Jun 2023 01:03:34 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230622222631.GA153948@bhelgaas>
References: <20230622222631.GA153948@bhelgaas>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230622222631.GA153948@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.4-fixes-2
X-PR-Tracked-Commit-Id: 40994ce0ea010b1843e620bacc26d29ddebfc08d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4a426aa1a2967e4963a77bddaeab143f1d1f821f
Message-Id: <168748221457.12146.12311856362882923128.pr-tracker-bot@kernel.org>
Date:   Fri, 23 Jun 2023 01:03:34 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Zhu YiXin <yzhu@maxlinear.com>,
        Lei Chuanhua <lchuanhua@maxlinear.com>,
        Rahul Tanwar <rahul_tanwar@yahoo.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Thu, 22 Jun 2023 17:26:31 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.4-fixes-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4a426aa1a2967e4963a77bddaeab143f1d1f821f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
