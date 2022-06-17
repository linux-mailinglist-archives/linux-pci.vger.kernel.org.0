Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D044354FE3F
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jun 2022 22:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348945AbiFQUXl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Jun 2022 16:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245445AbiFQUXY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jun 2022 16:23:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F3250059;
        Fri, 17 Jun 2022 13:23:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3F404B82BC5;
        Fri, 17 Jun 2022 20:23:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D7AAAC3411F;
        Fri, 17 Jun 2022 20:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655497400;
        bh=KlzgfuA96URb6EeVFN4xfFJN42ygroLo/AvhjR1yW/A=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=u3kokvDrulMXFx2UhUvQnhNcYBzIKe5H6bMOlGEGnr6pi/7Eonf4hJSlhhTrkzIPA
         GCBKl/ffJBWKzqfbpQ0qR37GExPHjZg/pXkVgiCmkhkpmYhiGpMlgsaDCebddUK68R
         a3QyqTPdcVKhBAvUTbA7yQ1Dk+LAhh00tKY1uUrfRaR+NFs7obsOUubqVhRRZdU2BS
         Fcg6h9DWkf8cVrAq9HZDomfvpiiPSZWh9GhM+vgMrSt2JJsDMt+Wu7qlxtcrEYxeMZ
         tniksge2SUvpZCEFL0zS6DJtCV/rUTb/gfu9XuS3ZeMuBUCE8fUdM3dML9Qmqx50/2
         XCkzBueAf96Vw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BDF50E73858;
        Fri, 17 Jun 2022 20:23:20 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220617200141.GA1202513@bhelgaas>
References: <20220617200141.GA1202513@bhelgaas>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220617200141.GA1202513@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.19-fixes-2
X-PR-Tracked-Commit-Id: a2b36ffbf5b6ec301e61249c8b09e610bc80772f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 32efdbffff280b304bb2cd48844ee4166078e69c
Message-Id: <165549740077.12674.8391848743677386359.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Jun 2022 20:23:20 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Fri, 17 Jun 2022 15:01:41 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.19-fixes-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/32efdbffff280b304bb2cd48844ee4166078e69c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
