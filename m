Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45AE14B2E2B
	for <lists+linux-pci@lfdr.de>; Fri, 11 Feb 2022 21:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353171AbiBKUF1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Feb 2022 15:05:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353167AbiBKUFZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Feb 2022 15:05:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C49CE5;
        Fri, 11 Feb 2022 12:05:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA191B82C99;
        Fri, 11 Feb 2022 20:05:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9D9DCC340E9;
        Fri, 11 Feb 2022 20:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644609921;
        bh=bKbqNxmW+7k+RCMvj4vtfijICXlc4s2mWU4IT47p5F8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BHZ3PUEeRAK4hXHk5CMe5sRV31Xf7FJxVLqwCjtOp5/rB2Ws9UeLTUVE7otm5MwAq
         KPM0DCLw20iJjxWZhjXpT/EnPn9SOR+VerO9994TNi3EwmPf1WYl4tO+OecyHBnzCE
         0XqzfbSdT3wtVOnKfvnm7asJVkFMXFs8TizFwmHS0rzJxwpe3io6+wE1gwx/ND6tnR
         agCjNEKDrPWYNJ08PcmMv9prWEVdKonw2ZPUA6IJWNMjzObOytx+54gqBKci1t2J9g
         bjE7kfKoscI43U1Epk4ukpYHBGyHKOwmEx295k6zDC3vLre9sEa/mji384HtthjyHf
         68S9KK4r3jZ5Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8A9ECE5D09D;
        Fri, 11 Feb 2022 20:05:21 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fixes for v5.17-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0i=QT9GjEgWcqT-+CUKL=aScS3S6NZLUDznN-fNBahVYw@mail.gmail.com>
References: <CAJZ5v0i=QT9GjEgWcqT-+CUKL=aScS3S6NZLUDznN-fNBahVYw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0i=QT9GjEgWcqT-+CUKL=aScS3S6NZLUDznN-fNBahVYw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.17-rc4
X-PR-Tracked-Commit-Id: 27a98fe60b033dfce95361abe368750994b8a78e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 883fd0aba1ae52b800081b9aa9ba9edfc88f36b0
Message-Id: <164460992156.1412.11559056276253228923.pr-tracker-bot@kernel.org>
Date:   Fri, 11 Feb 2022 20:05:21 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Fri, 11 Feb 2022 17:57:41 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.17-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/883fd0aba1ae52b800081b9aa9ba9edfc88f36b0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
