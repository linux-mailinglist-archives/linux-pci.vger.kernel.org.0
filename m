Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5656478E524
	for <lists+linux-pci@lfdr.de>; Thu, 31 Aug 2023 05:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240756AbjHaDuM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Aug 2023 23:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346021AbjHaDuM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Aug 2023 23:50:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886A8CD6;
        Wed, 30 Aug 2023 20:50:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2D5EEB82177;
        Thu, 31 Aug 2023 03:50:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2A34C433CA;
        Thu, 31 Aug 2023 03:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693453807;
        bh=ay6/KDRPlvUFJk/zU5BOLgy0hePM/EK6/TQqcAYdcm4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NWHwlsoMhsc0bI+pIM6ctPCSltDqAlEtjvPFwhZyACVM2OSwLI12duGqzugxXGCUM
         XuBl5erzYggXwDw3z1eKaB/zzV/+HPITPCAFis3zwHS7BnWSzjr8G9/00ATVxTwzdu
         fnM5ZLgWgPXfWlahK89SaultV5WdHbyeOcko4SvlWdcdgYsXpZyi9UPD+Aag2YnKTm
         Ah1qG7Wlvim8FZDovVQBhmwXB9j0Q66dquwawh6xypOHa87a37sspS62qN2g2yRU8I
         BKlm7ejPwiYKFRhhlAorQfKBmU2gjEXVH6syRJeNe0oBwosYDCl277nnUm2o+ZNczN
         e4/mP7uwiLxYg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CA3E1C595D2;
        Thu, 31 Aug 2023 03:50:06 +0000 (UTC)
Subject: Re: [GIT PULL] PCI changes for v6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230830190642.GA10547@bhelgaas>
References: <20230830190642.GA10547@bhelgaas>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230830190642.GA10547@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.6-changes
X-PR-Tracked-Commit-Id: 43cc31da9146f9ce60e4a03d96ef0807c2cdac94
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b6f6167ea8a424d14b41c172fe7a5f49e164f221
Message-Id: <169345380679.16977.6439070945739172296.pr-tracker-bot@kernel.org>
Date:   Thu, 31 Aug 2023 03:50:06 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Wed, 30 Aug 2023 14:06:42 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.6-changes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b6f6167ea8a424d14b41c172fe7a5f49e164f221

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
