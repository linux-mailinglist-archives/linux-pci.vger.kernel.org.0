Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 290271EC3C0
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jun 2020 22:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbgFBUfX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Jun 2020 16:35:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:46354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728480AbgFBUfH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Jun 2020 16:35:07 -0400
Subject: Re: [GIT PULL] ACPI updates for v5.8-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591130107;
        bh=6cCiFyMRcZFVDUkImbtj3s9jMcNm754T1C6+u8hcetU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=OJmJVUGDLnJZzfRUFMnNG8qW8+oZFSMK+R7idcNOnv72uDUaEwm63Njz++pGnpOXA
         o2zdZpDYwPU0Oza6Xi9kW0gibzFH4povFeZUTKB4QA7DOGVe/vQsHWlfJhBniwJC9T
         IXYE06rnwFwTRx9W1mvKyCewGve/VMFetc9tur3k=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gfVaNkSvDCXghKKXL34cLTwyC5jWBX8TYZjPVUOEvdjw@mail.gmail.com>
References: <CAJZ5v0gfVaNkSvDCXghKKXL34cLTwyC5jWBX8TYZjPVUOEvdjw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gfVaNkSvDCXghKKXL34cLTwyC5jWBX8TYZjPVUOEvdjw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 acpi-5.8-rc1
X-PR-Tracked-Commit-Id: 48ccdeddc54771ecdc46fac098bac689e9df24ca
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 118d6e98293b30aee378a6b08d27a35320a3e34f
Message-Id: <159113010703.19446.16764361401557635752.pr-tracker-bot@kernel.org>
Date:   Tue, 02 Jun 2020 20:35:07 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Mon, 1 Jun 2020 17:50:25 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/118d6e98293b30aee378a6b08d27a35320a3e34f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
