Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D297DFDA5
	for <lists+linux-pci@lfdr.de>; Fri,  3 Nov 2023 02:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344692AbjKCBAX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Nov 2023 21:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347959AbjKCBAW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Nov 2023 21:00:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71D5199;
        Thu,  2 Nov 2023 18:00:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 66709C433D9;
        Fri,  3 Nov 2023 01:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698973219;
        bh=/BnU3fiNslEzM8YSYjtVWWMn19yARu1CXzGGyR0ZcW8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XsWWQlyG5IYp88fU3orNJ2Yk9LM8NwdSSz6P0awHoXsw3Ag2MZIFdNYhzNOA0kWnm
         A7MuEuX+tWfCYacDOld05cAqAbbPNufzJLB1ZQt8Izsjb/UO8anhQrUHnLWQ9XfGdj
         u4WSQqPonnNtSMuzMWoCx8VJXdOR+Ecg0h5shqD98rODE3Pjh16bcZTUMZxwyHO0EQ
         d01nEZ9L7ceGFK6260HTuRoYR7vAh2ZgI+xvZZK+UJM+kaDedGWeZ17GQmcXIinoau
         r+sa2Zjagnb3K6H1xLSuwl2FCmMgkcEUa1yZQgKlVslmHnvfWq6LoREWXCtToubkpp
         V3KDY/OxQNObw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4EF2FC43168;
        Fri,  3 Nov 2023 01:00:19 +0000 (UTC)
Subject: Re: [GIT PULL] PCI changes for v6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231101195110.GA93982@bhelgaas>
References: <20231101195110.GA93982@bhelgaas>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231101195110.GA93982@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.7-changes
X-PR-Tracked-Commit-Id: 50b3ef14c26b20476e67af582e788b17512023cf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 27beb3ca347fa29fef5c23b351120239b8cf0612
Message-Id: <169897321930.13409.2986106471610433617.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Nov 2023 01:00:19 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Wed, 1 Nov 2023 14:51:10 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.7-changes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/27beb3ca347fa29fef5c23b351120239b8cf0612

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
