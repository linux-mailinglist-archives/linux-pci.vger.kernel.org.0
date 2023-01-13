Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE1666A725
	for <lists+linux-pci@lfdr.de>; Sat, 14 Jan 2023 00:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbjAMXgN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Jan 2023 18:36:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbjAMXgL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Jan 2023 18:36:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C34736E3;
        Fri, 13 Jan 2023 15:36:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E85762388;
        Fri, 13 Jan 2023 23:36:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 797ADC433EF;
        Fri, 13 Jan 2023 23:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673652969;
        bh=LP1keGHwXRjoBdkcxVrV7ouMLYyVf+YPLf9P/kqd1gw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=J+hUi5tKAx3N0VoYpUAZYGMVaKoqTud+Dlg5A6GIV8SOo8rtJ/apkklIJOJNB4BBM
         FfJnLZbeiXRgKmSw7mKZ/XJ8tAPKrlVg0htB6Id8SLaRlvVXod33AEnjJXGQG4JU2U
         VK4xCUf7Xjyd3q4HgUZoWCXrWKC/ONFr9Diyh5yAuYygAsHigcn1Szlzki5ZGxqndP
         AAQAqk5lxwAhqB1MaaMB8e04p2Is+zMBa8DXhG2rv06Wrmb0o1uoKASvPj9qNE5cj+
         RCIsH0XqVuFRV6mU2HcTntsBm88OhXm95eB+Odussv/KGrpm8Imo37/uNHEZQ8QjM8
         cNZ7YtFRVbkfQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 63E64C395C7;
        Fri, 13 Jan 2023 23:36:09 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230113181509.GA1852362@bhelgaas>
References: <20230113181509.GA1852362@bhelgaas>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230113181509.GA1852362@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v6.2-fixes-1
X-PR-Tracked-Commit-Id: fd3a8cff4d4a4acb0af49dd947c822717c053cf7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9e058c2952cad4baca0464266c4b1fe68f77052b
Message-Id: <167365296940.22378.2553119936849951590.pr-tracker-bot@kernel.org>
Date:   Fri, 13 Jan 2023 23:36:09 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Yunying Sun <yunying.sun@intel.com>,
        Baowen Zheng <baowen.zheng@corigine.com>,
        Zhenzhong Duan <zhenzhong.duan@intel.com>,
        Yang Lixiao <lixiao.yang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Fri, 13 Jan 2023 12:15:09 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v6.2-fixes-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9e058c2952cad4baca0464266c4b1fe68f77052b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
