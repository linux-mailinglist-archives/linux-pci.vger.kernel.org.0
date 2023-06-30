Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9284A7444D5
	for <lists+linux-pci@lfdr.de>; Sat,  1 Jul 2023 00:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbjF3W3g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Jun 2023 18:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjF3W3e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Jun 2023 18:29:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEA53C22;
        Fri, 30 Jun 2023 15:29:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D42FD6166E;
        Fri, 30 Jun 2023 22:29:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3CCD6C433C7;
        Fri, 30 Jun 2023 22:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688164173;
        bh=VzR0B8mmHtedFXvTB26r0Eh7F5F4F9J5vQopchEoSHg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=pB5qT9ZoWnxDHwKpuoLUPeFqHiEgXVb2MWo2qn9CUyINN8KMVkxlkpc6jw9D5Ai21
         hMhBWSa89/o+MOKDW5LaaAnk1OMKc2A7k43KU8CsneFGZg9hmLWyFJhsWEsixZ+XRQ
         MmNxWLuY85WRy1/FewmnhRQ/ZHg0oxSCUSldLPeAhwQwVh/3b09xPgIa+Ak1ZcsMHo
         Xa0Aeen/9vUCZhKhd2uFb9bPxMSTZ+In6k5KbvdoaHBlw/ppqTxtgyU15V3LT41Jlk
         ILOUIOv+KzNhGmJR4B8hYXAnxAqQIjjwYKKLjOmLqkQ1nTh0VkkdTlxXndMkiwjGj2
         2i/7Jq88xQhoA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2BD24C39563;
        Fri, 30 Jun 2023 22:29:33 +0000 (UTC)
Subject: Re: [GIT PULL] PCI changes for v6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230629165838.GA438762@bhelgaas>
References: <20230629165838.GA438762@bhelgaas>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230629165838.GA438762@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.5-changes
X-PR-Tracked-Commit-Id: 6ecac465eee887de7ceda7ffe3bccf538eb786bc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9070577ae9d6065e447d422bdf85a09f89eaa9e8
Message-Id: <168816417317.26572.8230148836516977547.pr-tracker-bot@kernel.org>
Date:   Fri, 30 Jun 2023 22:29:33 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Thu, 29 Jun 2023 11:58:38 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.5-changes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9070577ae9d6065e447d422bdf85a09f89eaa9e8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
