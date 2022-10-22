Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5AE960905D
	for <lists+linux-pci@lfdr.de>; Sun, 23 Oct 2022 01:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbiJVXJO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 22 Oct 2022 19:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbiJVXJD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 22 Oct 2022 19:09:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD347EA9D2;
        Sat, 22 Oct 2022 16:09:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5E055B80BFC;
        Sat, 22 Oct 2022 23:09:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 08F3EC43140;
        Sat, 22 Oct 2022 23:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666480140;
        bh=zJjUDE0+HEkEXA+iCdlwxJdqhZK7KypezPw2VhppUQM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qVueg/cOIH2YYQkwpsjHXAxRpgKLLTlCKeAj3H5YBoryvpBanhSloA0qQqVZfECBo
         wk5U/lWb6ibH0KP8ULDfT47fy35ZllBv3PeRmKOouJ6/K5KNe6E6m465NLYPrrkP9s
         QJBnA1sMKjCfT+quh7wmHCml6ZChXvgquzVOlcC7Tj6W3NhGF8CVLl+iVZIWkyc7RN
         0Hl7EOKnDQJnlXzAAI5WrWENsGw3lwaJoosF3MVQ8CHNxdUXjyUHDhLbbmFfU2KnaB
         noS3f1hbXtNZSn49aodlKGwQSCFM2ExhW3g3dJrIdRBLf8BJt1F31JiSc0FknA3mgd
         BoR1KVVDnMbVg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E8B98E270E2;
        Sat, 22 Oct 2022 23:08:59 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221021211757.GA311020@bhelgaas>
References: <20221021211757.GA311020@bhelgaas>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221021211757.GA311020@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v6.1-fixes-2
X-PR-Tracked-Commit-Id: e6aa4edd2f5b07fdc41de287876dd98c6e44322b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fd79882ff281776260849b658d41fc06553e7fea
Message-Id: <166648013994.24083.621841284715930793.pr-tracker-bot@kernel.org>
Date:   Sat, 22 Oct 2022 23:08:59 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Fri, 21 Oct 2022 16:17:57 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v6.1-fixes-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fd79882ff281776260849b658d41fc06553e7fea

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
