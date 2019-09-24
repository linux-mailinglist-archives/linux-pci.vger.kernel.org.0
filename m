Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4127BC048
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2019 04:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389515AbfIXCpX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Sep 2019 22:45:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:54882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728992AbfIXCpX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 23 Sep 2019 22:45:23 -0400
Subject: Re: [GIT PULL] PCI changes for v5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569293123;
        bh=1pqi1o5kTkczsUhGwByCal3rDExdaHunGswaYZKIshk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=dfU0EnSBQAv2nmUsX0sHkYErCoeXOQitXh2rGwOTYS8Qorl9KCtNSB6Zc1QqYihyO
         TW6/fwFXPdaCDT1gbxwjvPZuJz9G31UzLWvbYibQTCqVjnYKNBpJACpfdIxRNFz11e
         gXMpBw3yG90EDLdbcUjIKxP7Ofd9yMvktS9Zj20I=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190923225822.GC11938@google.com>
References: <20190923225822.GC11938@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190923225822.GC11938@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
 tags/pci-v5.4-changes
X-PR-Tracked-Commit-Id: c5048a73b4770304699cb15e3ffcb97acab685f7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 299d14d4c31aff3b37a03894e012edf8421676ee
Message-Id: <156929312306.18533.8072618572523592384.pr-tracker-bot@kernel.org>
Date:   Tue, 24 Sep 2019 02:45:23 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Mon, 23 Sep 2019 17:58:22 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.4-changes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/299d14d4c31aff3b37a03894e012edf8421676ee

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
