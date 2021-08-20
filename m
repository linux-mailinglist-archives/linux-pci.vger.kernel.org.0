Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 018B13F34FB
	for <lists+linux-pci@lfdr.de>; Fri, 20 Aug 2021 22:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239196AbhHTUKG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Aug 2021 16:10:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:39070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238656AbhHTUKB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Aug 2021 16:10:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 1D08B61163;
        Fri, 20 Aug 2021 20:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629490161;
        bh=8gOu3paPJDDhQ9TWW4wuAzHx+AQQkyq84xMEwCm2PPg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Uok6AXpT07zUU/LElCtpfEt8SYgtiA4htT39S4rFJ3AH/AFrDtRVZUKg9EZ0vRD33
         luaajr8KopTuzWzXLylyVwWzSbVInK2rqzqtI3sbr0h3uEnyxQC7YuhRjGP8ilbVjG
         yut4X4YOexj1C6xHdmBftpltiy2bAfNRj553S6M/pYCGz6BJKD1jb4JJc0QJuyDcT3
         NJgKLoZ2Yf0AboMalDuRglbo8iCetq1o3G3GfYfjz/TZ67FVuGc+XKzNrfRZtpb0wk
         YZYZlcGue5YAzdTKpk9dtxM/zCQBALXIPDTpE0uRD5Qt8ZipiKO8kmYKWsmx2um8on
         GKpnyLuMg7gVQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 155E060A21;
        Fri, 20 Aug 2021 20:09:21 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210820150128.GA3317758@bjorn-Precision-5520>
References: <20210820150128.GA3317758@bjorn-Precision-5520>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210820150128.GA3317758@bjorn-Precision-5520>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.14-fixes-2
X-PR-Tracked-Commit-Id: 045a9277b5615846c7b662ffaba84e781f08a172
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3db903a8ead3e4466f6292e0809adac0cf3fe527
Message-Id: <162949016108.21370.16001515932829120188.pr-tracker-bot@kernel.org>
Date:   Fri, 20 Aug 2021 20:09:21 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rahul Tanwar <rtanwar@maxlinear.com>,
        Jim Quinlan <jim2101024@gmail.com>,
        Marcin Bachry <hegel666@gmail.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Greg KH <greg@kroah.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Fri, 20 Aug 2021 10:01:28 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.14-fixes-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3db903a8ead3e4466f6292e0809adac0cf3fe527

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
