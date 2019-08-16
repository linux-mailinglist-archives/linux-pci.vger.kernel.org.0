Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 954F5905D1
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2019 18:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfHPQaJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Aug 2019 12:30:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:51096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727457AbfHPQaI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Aug 2019 12:30:08 -0400
Subject: Re: [GIT PULL] Power management fixes for v5.3-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565973007;
        bh=XHjlZmKTF9nNMGhgjea6r5OALoj3MwKvj+3B+20nqFI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=RT3tspNBfxudhjqy1BRPh2T1OxocwyBShKCEBeEj/NKaMJ+HxS6S+MHIE/Hy0Iv0k
         IPemShark9xJhwpYnFuXj7ALffjBlfb9nbKtolb3lF/3d+qq6nXbeH1B0XKoP+5gNs
         gE7hYjZGskOAQzbktfsqYg0WoU5j2nhUczA59np4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0j4ezEuK1dk0J3wwjSuudzjhKWTXzJL=EkE1QG39HKRiw@mail.gmail.com>
References: <CAJZ5v0j4ezEuK1dk0J3wwjSuudzjhKWTXzJL=EkE1QG39HKRiw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0j4ezEuK1dk0J3wwjSuudzjhKWTXzJL=EkE1QG39HKRiw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.3-rc5
X-PR-Tracked-Commit-Id: a3ee2477c45f73184a64d9c6cf97855a52732dc6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2d63ba3e41db3ceb0d23924ed2879b910276e24c
Message-Id: <156597300748.15122.2547327554860184999.pr-tracker-bot@kernel.org>
Date:   Fri, 16 Aug 2019 16:30:07 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Fri, 16 Aug 2019 15:11:27 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.3-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2d63ba3e41db3ceb0d23924ed2879b910276e24c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
