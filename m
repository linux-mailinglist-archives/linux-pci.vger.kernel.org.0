Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F39D4198774
	for <lists+linux-pci@lfdr.de>; Tue, 31 Mar 2020 00:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729862AbgC3WfK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Mar 2020 18:35:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:49446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729060AbgC3WfK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Mar 2020 18:35:10 -0400
Subject: Re: [GIT PULL] ACPI updates for v5.7-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585607710;
        bh=7IBOz4ePh/jjgfmw3X/FQZqGRPMvQmJNyVifg+HBytY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=HkqyKkM9rsA4QRdy0qixISBiD7fGB/r26nNSA72sFpblStfpZaqXvDp0AhsNzXH8p
         IMXKQe1ArtIph+dmAmlexNC47pRdgJLG5uc5sS32WksOUfmTRjIdQN2xcrsdIvY1DM
         SovMlLIxa89MnQ/XpG9h0I9EOdSn0xtnwqmC8CqI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0ja_cmfL2Rwj-k-__B2QjH8kY-t2pM1Tg+yP0A=6kMYSg@mail.gmail.com>
References: <CAJZ5v0ja_cmfL2Rwj-k-__B2QjH8kY-t2pM1Tg+yP0A=6kMYSg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0ja_cmfL2Rwj-k-__B2QjH8kY-t2pM1Tg+yP0A=6kMYSg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 acpi-5.7-rc1
X-PR-Tracked-Commit-Id: 1da28f032305383a664e5711ba07b7957901a72e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6d90508121fd0c92c276ec731ad6109bf2986cc6
Message-Id: <158560771002.3567.6314103050384706394.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Mar 2020 22:35:10 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Mon, 30 Mar 2020 17:25:41 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6d90508121fd0c92c276ec731ad6109bf2986cc6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
