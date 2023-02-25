Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4796C6A2B1F
	for <lists+linux-pci@lfdr.de>; Sat, 25 Feb 2023 18:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjBYRdH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 25 Feb 2023 12:33:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjBYRdD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 25 Feb 2023 12:33:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD67426AD;
        Sat, 25 Feb 2023 09:33:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D08260B55;
        Sat, 25 Feb 2023 17:33:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A532DC433EF;
        Sat, 25 Feb 2023 17:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677346381;
        bh=6NZHfqzfAo19cNKksjq+o/SCM1i/OjyrFCDF9l0TwoA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WctzGEymlJyadp8JqsSHP/WF4T9ifp7V2Ncs+kUXh8+9kmhDwylIIg7wMyiowEQug
         4+rCFJx4oiOJOeci1LKGaaQRgCzs/gJEnNS9y4p3J7BBZkyQYIhiyzhumGI70AVetP
         dkx1VKZn7poFipoONQRx5nPN5eVJw6K20TWVhUDQvBrYrV0eYkTd1p5Fz6hKJklz/t
         c8tQY1PpFB/aeNxNoXFPDJkgW7hYNvz6HnH2UC1PMHXqw3g4eb2iI5ydwYG123FLic
         sAtnhT7YB1W9/7BFeEUKPSBsQV9n4Zfpf5YnWJGREp38Xe+SpAZH1oCZs2xY3keUH6
         vdLeo5E3dufZQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 93D3FE68D26;
        Sat, 25 Feb 2023 17:33:01 +0000 (UTC)
Subject: Re: [GIT PULL] Compute Express Link (CXL) for 6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <63f5a4e2277b1_c94229453@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <63f5a4e2277b1_c94229453@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <63f5a4e2277b1_c94229453@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-for-6.3
X-PR-Tracked-Commit-Id: e686c32590f40bffc45f105c04c836ffad3e531a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7c3dc440b1f5c75f45e24430f913e561dc82a419
Message-Id: <167734638160.8970.6794755420865287571.pr-tracker-bot@kernel.org>
Date:   Sat, 25 Feb 2023 17:33:01 +0000
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     torvalds@linux-foundation.org, linux-cxl@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Tue, 21 Feb 2023 21:15:14 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-for-6.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7c3dc440b1f5c75f45e24430f913e561dc82a419

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
