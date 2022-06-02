Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF4C53BF2C
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jun 2022 21:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239018AbiFBT5w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Jun 2022 15:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239021AbiFBT5v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jun 2022 15:57:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1382D21E;
        Thu,  2 Jun 2022 12:57:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AF514B81F31;
        Thu,  2 Jun 2022 19:57:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4B421C34114;
        Thu,  2 Jun 2022 19:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654199868;
        bh=J3nzQJ2G5GUnpqid20W9LzfsX1dhp5znOLrD1Ct0mhc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gEWHH3m52ImQLjRxQSdag6AAqK//82AI75/smt9dsJiuakDbGxuSizb+S/HjShGgl
         4ZfnGyuy1vj3h2sRRB/HyQUAm73uGkM198bkkn+SSQ49CEnCP2/QbT3AKMoIOrS0HE
         FKpPO3h0t8H4yYJ/Et/y1Y6Ykn+++dp7M+H7Ziav6F/w6/xthdmsTfbG5SgQb8mtrw
         FcIN39iOoBueLzmCbWDOh+J6BeXUanLY+axcqjgyAWepajRS2X7HZKo/r24fwLJN3u
         YdTCnZ1dpAZHSvYUD3QKRh+3eYyaavesI7r/w6QNBrVgQwsL2jL0Vh673JrTlFLGpX
         vjpKYlUGS+9VA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 39555F03945;
        Thu,  2 Jun 2022 19:57:48 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220602184913.GA36164@bhelgaas>
References: <20220602184913.GA36164@bhelgaas>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220602184913.GA36164@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.19-fixes-1
X-PR-Tracked-Commit-Id: 833e53a4ffe92e742e99347c68d99dc33986598b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c399c85d60a4295bd911d366399a97df2865fb86
Message-Id: <165419986822.9476.1311560009781878411.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Jun 2022 19:57:48 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Cyril Brulebois <kibi@debian.org>,
        Jim Quinlan <jim2101024@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Thu, 2 Jun 2022 13:49:13 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.19-fixes-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c399c85d60a4295bd911d366399a97df2865fb86

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
