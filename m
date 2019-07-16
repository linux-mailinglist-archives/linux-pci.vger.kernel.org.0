Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85BCD6A18A
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2019 06:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733223AbfGPEfU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Jul 2019 00:35:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:33288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733210AbfGPEfU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Jul 2019 00:35:20 -0400
Subject: Re: [GIT PULL] PCI changes for v5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563251719;
        bh=mfxJ4d3y7uYpSeVw0+B7MAFW2eHJDgfnJz3zbdiPcSA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=2UtKKDXhBqMKPjvhlelVjoVxjdUYjnFrn1Z7vT0uGxlAzN/rIRCc3BgljlLVODInk
         EF5UKm9sMonr5ZZyXApbppLBjlYHLxyKb/n5YhRbEey1kAM4wSBxEHtffbP5Nipxys
         ixdYuKYMl01pklqn9D2KP/7OQq5F1q8KHVyqgprw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190715192702.GF46935@google.com>
References: <20190715192702.GF46935@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190715192702.GF46935@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
 tags/pci-v5.3-changes
X-PR-Tracked-Commit-Id: 7b4b0f6b34d893be569da81ffad865a9d3a7d014
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fb4da215ed92f564f7ca090bb81a199b0d6cab8a
Message-Id: <156325171965.15429.6001801198442486414.pr-tracker-bot@kernel.org>
Date:   Tue, 16 Jul 2019 04:35:19 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Mon, 15 Jul 2019 14:27:02 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.3-changes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fb4da215ed92f564f7ca090bb81a199b0d6cab8a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
