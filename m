Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAFE57794FA
	for <lists+linux-pci@lfdr.de>; Fri, 11 Aug 2023 18:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236266AbjHKQpJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Aug 2023 12:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236256AbjHKQpI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Aug 2023 12:45:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE90530C1;
        Fri, 11 Aug 2023 09:45:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32F33676FB;
        Fri, 11 Aug 2023 16:45:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 942ABC433CA;
        Fri, 11 Aug 2023 16:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691772307;
        bh=I6R5KQkKlw1HwVGsLIBBi/OcOwPSHhWLIQHeR1CZ6BY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kmDTDbD0xRs6QkJxlDSb4TRePjEYYHtc6sXi+2OTJ2E4w74djwfYQnVcbrF8fnP4/
         pjR4y6G2S0fMhk/RAsB+ue2NlVJagwG169prAqKZV833R0VCiZKPmVBEVkNtYIy90z
         VplQG1N0S7FvsbxgchDfYmhbps3XdYq6OSK+rATtr2/NDNey9DVwu+yUdks587MQMH
         0is+82QxcithQw6zRxDIG9w96djxlNemMkofuHLxKh9MrM2WwRrIMnidcCIYm1RnN6
         wQ+01JOafgeree/zOcO0UaEdOvJZV2/adpoWRtrCiaUxGdXBPRmcJHc3+PeuHOTk0l
         4cgRSz32+R1Lg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7E6D0C3274B;
        Fri, 11 Aug 2023 16:45:07 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230811163144.GA75144@bhelgaas>
References: <20230811163144.GA75144@bhelgaas>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230811163144.GA75144@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.5-fixes-1
X-PR-Tracked-Commit-Id: cc22522fd55e257c86d340ae9aedc122e705a435
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9106536c1aa37bcf60202ad93bb8b94bcd29f3f0
Message-Id: <169177230751.3076.1875490980295081306.pr-tracker-bot@kernel.org>
Date:   Fri, 11 Aug 2023 16:45:07 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Fabio Estevam <festevam@gmail.com>,
        Xiaolei Wang <xiaolei.wang@windriver.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Woody Suwalski <terraluna977@gmail.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Sajid Dalvi <sdalvi@google.com>,
        Ajay Agarwal <ajayagarwal@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Fri, 11 Aug 2023 11:31:44 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.5-fixes-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9106536c1aa37bcf60202ad93bb8b94bcd29f3f0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
