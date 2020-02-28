Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7C8E174092
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2020 20:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgB1TzI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Feb 2020 14:55:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:59866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgB1TzH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 28 Feb 2020 14:55:07 -0500
Subject: Re: [GIT PULL] PCI fixes for v5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582919707;
        bh=7e01PYQtmVbFyozelgJ8XBP/mOO01pmq3UcmFX20UCk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=NnaSU57hzsG06fp+CBtPX3TdXCqLGDmiL1wYqzYktEkB8JsiBdi45bjcExg4owz/a
         OSZVoJIjgIf39VrzeXlnG8NRVtMHcFFqeZX1IP3vKuSBe15648n2mJnD74kG320NlJ
         E9zzHn8bJeAkhz+HbP8W0bA7ygygSMXQhHYC5aNk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200228192153.GA97492@google.com>
References: <20200228192153.GA97492@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200228192153.GA97492@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
 tags/pci-v5.6-fixes-2
X-PR-Tracked-Commit-Id: 5901b51f3e5d9129da3e59b10cc76e4cc983e940
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 29795de0d242a5ba45904b36a5fb67e38a304cb7
Message-Id: <158291970739.11737.5560436819113052472.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Feb 2020 19:55:07 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Fri, 28 Feb 2020 13:21:53 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.6-fixes-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/29795de0d242a5ba45904b36a5fb67e38a304cb7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
