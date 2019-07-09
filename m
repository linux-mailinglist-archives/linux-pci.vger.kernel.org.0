Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1FA463A7C
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2019 20:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbfGISFN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Jul 2019 14:05:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:35882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727407AbfGISFN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Jul 2019 14:05:13 -0400
Subject: Re: [GIT PULL] Power management updates for v5.3-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562695512;
        bh=JXFlGuoJXpneeEIC1DGQOldTVYNYQFEZ4HClAl0Zq6Y=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=2R/9EQI0jqaMfRBpti9I3/WhrPn0eydtZ30+RCt47segUyREPb973WxkhpR+KrtM2
         7mbcCN1i6IU5Szsx6fK+2y5BZAdt9gd9weFI1GNuUDtsYmdlxouumTTmWzeyO4+cVh
         dj2EBrQeRPUrEmShAMZP9Bjj4n/rICnTahuLPh3E=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jfQX=QmX9NFRu7M98=WjeVhSW4X0nTW93-MeB3FR1uWw@mail.gmail.com>
References: <CAJZ5v0jfQX=QmX9NFRu7M98=WjeVhSW4X0nTW93-MeB3FR1uWw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jfQX=QmX9NFRu7M98=WjeVhSW4X0nTW93-MeB3FR1uWw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.3-rc1
X-PR-Tracked-Commit-Id: 586a07dca8c51b966960d1f0d8be9c27d7e0a95c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cf2d213e49fdf47e4c10dc629a3659e0026a54b8
Message-Id: <156269551195.14383.18023006962596679738.pr-tracker-bot@kernel.org>
Date:   Tue, 09 Jul 2019 18:05:11 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Mon, 8 Jul 2019 23:36:26 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cf2d213e49fdf47e4c10dc629a3659e0026a54b8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
