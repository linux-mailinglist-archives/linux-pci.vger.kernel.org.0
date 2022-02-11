Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7004B2F74
	for <lists+linux-pci@lfdr.de>; Fri, 11 Feb 2022 22:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353763AbiBKVgO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Feb 2022 16:36:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348044AbiBKVgM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Feb 2022 16:36:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550CFC61;
        Fri, 11 Feb 2022 13:36:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 11B48B82C8E;
        Fri, 11 Feb 2022 21:36:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D1B28C340E9;
        Fri, 11 Feb 2022 21:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644615368;
        bh=HIzsksC2Y+PVkRniajjV2uvBQ33fNa+wjeVJHIazHjk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ebjTRDAiTfVVQeX/FhV5nys5JTl0MvRN5bu9zvqRadvZE9IV9tSrxf/NZ/eeRAPuY
         5TnSHMsvl1X7YVdANfecXdDfviZAcLUdMZZi8/O/cWsyrn7aTDtDwOQkyuzfFtXF9j
         mZOJbFIOqbFc/I3AJXdewdDMR8swp47eQ9EUgMo3YcFRTSCtZ+xfcEY1PJuUMNIUXB
         Q3Gn/maYkWI0EdDz7/5NGVGZ7A+vAjibCu2ZbBQLrOHtB7vqTdOVsL+loov/4H3XSi
         0v3494OwbjueXmeUwlEix2An9V3mKfO0KM0xh4HSwWjVb3rBVDpPZh3dKi9LfuM+VC
         PJAiJ3cukFnAA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BFFB5E5CF96;
        Fri, 11 Feb 2022 21:36:08 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220211204005.GA732009@bhelgaas>
References: <20220211204005.GA732009@bhelgaas>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220211204005.GA732009@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.17-fixes-4
X-PR-Tracked-Commit-Id: 075b7d363c675ef7fa03918881caeca3458e2a96
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: adccc16ea3c5fb205bdec0133d08e799aa6cc9ea
Message-Id: <164461536877.13388.13292671559580408157.pr-tracker-bot@kernel.org>
Date:   Fri, 11 Feb 2022 21:36:08 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joey Corleone <joey.corleone@mail.ru>,
        Sergiu Deitsch <sergiu.deitsch@gmail.com>,
        David Spencer <dspencer577@gmail.com>,
        Jan Kiszka <jan.kiszka@siemens.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Fri, 11 Feb 2022 14:40:05 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.17-fixes-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/adccc16ea3c5fb205bdec0133d08e799aa6cc9ea

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
