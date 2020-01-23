Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5FF21471C7
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2020 20:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbgAWTaE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jan 2020 14:30:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:39532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728842AbgAWTaE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 Jan 2020 14:30:04 -0500
Subject: Re: [GIT PULL] PCI fixes for v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579807803;
        bh=nnKfFFOtKn+z9h+7nGWyLYPUBDcBcY4YEokYGfYQxHU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=OBdwWlgn9JBP72UuSZ1fk9AfaW+W6thsuIf4paZg1uD2lCOIaG79AnZgGerBHm4bd
         sMnXmiBA8zkGQOaxrQoJSXkVPewiTXM9SxwyiC26SK13sD+FCQTT4gu0ZddHXxert3
         CBqLLwTInD1JgL88ZCVkGFeo/SrDoZN03qj3lVnA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200123143129.GA101517@google.com>
References: <20200123143129.GA101517@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200123143129.GA101517@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
 pci-v5.5-fixes-2
X-PR-Tracked-Commit-Id: 5e89cd303e3a4505752952259b9f1ba036632544
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a572582b1a4d6c8418739abfdfa5d1796d148d35
Message-Id: <157980780375.24133.9920696009867814747.pr-tracker-bot@kernel.org>
Date:   Thu, 23 Jan 2020 19:30:03 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Thu, 23 Jan 2020 08:31:29 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci-v5.5-fixes-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a572582b1a4d6c8418739abfdfa5d1796d148d35

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
