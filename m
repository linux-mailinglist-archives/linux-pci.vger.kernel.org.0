Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBF3799A78
	for <lists+linux-pci@lfdr.de>; Sat,  9 Sep 2023 20:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240881AbjIISxn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 9 Sep 2023 14:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240681AbjIISxn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 9 Sep 2023 14:53:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378ED1B5;
        Sat,  9 Sep 2023 11:53:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C5806C433C8;
        Sat,  9 Sep 2023 18:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694285618;
        bh=lL+VyvETBnD4XTSiK85xXcQD5f1ANuC86zeKjrpstL8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=nbpghKaWUzaTPc5I2L1xTWZijiyyYfS0CRldgPfh+B9s2jJefAKHr9neRVhrmEbdw
         uL58SddoCSqx5JP+647jb3KGCvLHEAfHrPDgx6sL5lkWEvpxej77d9JhQ0wl/6GYil
         J31hAbWVaqZRTc7c8mGUbmuwr75pf4CZF/KCQni4Z+TvWz0Wyna2/+e3WTCzo115mM
         Wt5laVLMB0gw3R+hA5xpxtwD0ix9mh1h0IYbfSHL5JGNMBfvqigNsktIZlOyAzn4VV
         EXA4XVa9yiBH70CPTy/6B+0dTANvB18hB6Cxa7n5CiJo5njaXLicbuQGhYXZ4o75xo
         2j/cUf1JfYIyg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B2A4CE505B7;
        Sat,  9 Sep 2023 18:53:38 +0000 (UTC)
Subject: Re: [GIT PULL] PCI changes for v6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230909144437.GA326030@bhelgaas>
References: <20230909144437.GA326030@bhelgaas>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230909144437.GA326030@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.6-fixes-1
X-PR-Tracked-Commit-Id: 5260bd6d36c83c5b269c33baaaf8c78e520908b0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 060249b5d3447a84c91f22276d3fec723363319d
Message-Id: <169428561872.13340.1297699335011603148.pr-tracker-bot@kernel.org>
Date:   Sat, 09 Sep 2023 18:53:38 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Wu Zongyong <wuzongyong@linux.alibaba.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        Kalle Valo <kvalo@kernel.org>, Lizhi Hou <lizhi.hou@amd.com>,
        Guenter Roeck <groeck7@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Sat, 9 Sep 2023 09:44:37 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.6-fixes-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/060249b5d3447a84c91f22276d3fec723363319d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
