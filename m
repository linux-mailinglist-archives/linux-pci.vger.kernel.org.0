Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D78BA7BBC82
	for <lists+linux-pci@lfdr.de>; Fri,  6 Oct 2023 18:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232637AbjJFQO2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Oct 2023 12:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbjJFQO1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Oct 2023 12:14:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7249DA6;
        Fri,  6 Oct 2023 09:14:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0FA1DC433C7;
        Fri,  6 Oct 2023 16:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696608865;
        bh=fxwe8aH3Ht8gojdkE8uldU7Xh/h2+LztbuUjaKV2g1w=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JFyj1xotICR+r00PmxTYDp9Gz+Eiw6zZXpAZViOpmE+QgcDPujoXohAjYkE1JFCpz
         Vccz9ZN6WNJlS1fxnL+iQ92xHKzjWGxfDJNTjpZHHWhJIwJtKX4SwEGZHGwztseDnf
         5xNANEyDIvY1Nm0WcflegXQutZ/D0yxLrNKUEExi3GXWwJHkH6fdm6JLRDLkD6JATu
         Yflr+1NVv7PrZAUXmGEk0cluwm5VrtcBzNY5Ct0GrMYZ/IHrYaE2NlGvewLfZsmAt9
         BOMdxOSxH8/mFEwVdOl5zC6cjMpuCJYYNBpCu9WZ2Fk2VzXKqk0AzEl6afwPiRPRD/
         PHyO9C87ObjsQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EF635E632D2;
        Fri,  6 Oct 2023 16:14:24 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231006154802.GA855916@bhelgaas>
References: <20231006154802.GA855916@bhelgaas>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231006154802.GA855916@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.6-fixes-2
X-PR-Tracked-Commit-Id: c82458101d5490230d735caecce14c9c27b1010c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: af95dc6fdc25e616051d0234aad638e15c02ec8f
Message-Id: <169660886497.6012.5230240593694281886.pr-tracker-bot@kernel.org>
Date:   Fri, 06 Oct 2023 16:14:24 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mark Blakeney <mark.blakeney@bullet-systems.net>,
        Lizhi Hou <lizhi.hou@amd.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Fri, 6 Oct 2023 10:48:02 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.6-fixes-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/af95dc6fdc25e616051d0234aad638e15c02ec8f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
