Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE6C915460F
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2020 15:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbgBFOZP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Feb 2020 09:25:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:56640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728238AbgBFOZP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 Feb 2020 09:25:15 -0500
Subject: Re: [GIT PULL] PCI fixes for v5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580999114;
        bh=FXPwXwaP9L2zkVLxzXLl/Vl33H+sO3swbrnYtqNGsd4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ujHuEr/j/44fbBXuQ8Uywc0Ms9RUph3XRvzPNCeasTouFmkRPikg+XULtWEX62yZG
         asWCA65PhHMuvUSuB4Yb4g/4KtRspll/3KKznNq80lyK1lvxKrKAUWoI724p5U9taV
         NIgwlWU0Q4CcfktmSxCqI2vSSMRiuLAuui2MdfiI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200206140915.GA124818@google.com>
References: <20200206140915.GA124818@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200206140915.GA124818@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
 tags/pci-v5.6-fixes-1
X-PR-Tracked-Commit-Id: 2e34673be0bd6bb0c6c496a861cbc3f7431e7ce3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9e6c535c64adf6155e4a11fe8d63b384fe3452f8
Message-Id: <158099911485.19829.18445721911611606284.pr-tracker-bot@kernel.org>
Date:   Thu, 06 Feb 2020 14:25:14 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Randy Dunlap <rdunlap@infradead.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Thu, 6 Feb 2020 08:09:15 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.6-fixes-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9e6c535c64adf6155e4a11fe8d63b384fe3452f8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
