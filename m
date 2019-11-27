Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7910210A961
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2019 05:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbfK0EUN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Nov 2019 23:20:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:44308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727336AbfK0EUN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Nov 2019 23:20:13 -0500
Subject: Re: [GIT PULL] Power management updates for v5.5-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574828412;
        bh=MpGt7A+tJVPI9TqYM/+0komBT3LxkrKVeaJQlsO6wbw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=2s4iBhFrDJ9pbObCYBQZZ9M+tQ887pEftr+Yh7Pve0GDUguDfBu2bHgo9f6ELTBm8
         EeYSiHB1kUtiUod1k6CZqPv/JesWeb9zCQEh0+B7SuCPVk5DT0z6BKy0VAySOf6FxU
         Zz06I5KU6RvtEs5DLi3Hyq5eYSV91CU6jVk3DQ4c=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hNKs11t2d0L=GkMN5RgOBfQ7sgss4U0VEJtS=EETwtNA@mail.gmail.com>
References: <CAJZ5v0hNKs11t2d0L=GkMN5RgOBfQ7sgss4U0VEJtS=EETwtNA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hNKs11t2d0L=GkMN5RgOBfQ7sgss4U0VEJtS=EETwtNA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.5-rc1
X-PR-Tracked-Commit-Id: e350b60f4e0f089f585d738e27213c8133fe9093
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9e7a03233e02afd3ee061e373355f34d7254f1e6
Message-Id: <157482841259.9403.10685238655465251112.pr-tracker-bot@kernel.org>
Date:   Wed, 27 Nov 2019 04:20:12 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Tue, 26 Nov 2019 13:55:32 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9e7a03233e02afd3ee061e373355f34d7254f1e6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
