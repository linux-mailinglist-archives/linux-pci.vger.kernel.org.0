Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8C6649206F
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jan 2022 08:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245600AbiARHlw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jan 2022 02:41:52 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:44602 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245617AbiARHlv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jan 2022 02:41:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95AEB61387;
        Tue, 18 Jan 2022 07:41:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0D96BC00446;
        Tue, 18 Jan 2022 07:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642491711;
        bh=iNIkWQPmpKD4eh7g0YAYJGDoyZOdku7nuquEp8Xokjs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uPBTXW0GKAOkxKk5xfn5yBh7cxQOC33btATNa40G6GPhQ3DfIFoQnUnM+CMcupjLS
         q01/IukspSb6c5oepbHTE3zggS0VYm5kglhZX4NoRIsVkyL1i4VkA3imRTqMzS+yqu
         BO1Etv2dd4kakHU18G7oXLB5H4ohrs42YEcxEnrG2AQLuNz8NrSkqx6CUGJzLSywmC
         +x5n3LK8Ktl86hxrY1zy2fDIyiUsrfab5ura/LHixu2L+9rVDcMtsFglore4pWs58X
         DV6fOZDKNbnChxTrGnKMOlJouQFfEGIr2h7ZX/1vO6w+9t0LbCKyE2A9+T9kDyYEfN
         OYHfa4oLazdNg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ED7E8F60797;
        Tue, 18 Jan 2022 07:41:50 +0000 (UTC)
Subject: Re: [GIT PULL] More ACPI updates for v5.17-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0iD_Ar15npwR8Cp2oEKF3DgPVo2KaKqfYax5RmTBkbZmg@mail.gmail.com>
References: <CAJZ5v0iD_Ar15npwR8Cp2oEKF3DgPVo2KaKqfYax5RmTBkbZmg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0iD_Ar15npwR8Cp2oEKF3DgPVo2KaKqfYax5RmTBkbZmg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.17-rc1-2
X-PR-Tracked-Commit-Id: e3daa2607b1f4bb1d09a5a8ad89ad9f7327a2e63
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6a8d7fbf1c65034b85e7676b42449a56e4206bd3
Message-Id: <164249171096.10229.6241357949791582942.pr-tracker-bot@kernel.org>
Date:   Tue, 18 Jan 2022 07:41:50 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Mon, 17 Jan 2022 19:09:53 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.17-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6a8d7fbf1c65034b85e7676b42449a56e4206bd3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
