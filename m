Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 659C111EE3F
	for <lists+linux-pci@lfdr.de>; Sat, 14 Dec 2019 00:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbfLMXKP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Dec 2019 18:10:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:38182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726769AbfLMXKP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Dec 2019 18:10:15 -0500
Subject: Re: [GIT PULL] PCI fixes for v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576278614;
        bh=5uBLogaohz96zGdirUoyepPtmgaEPKVWB6JHuprQSek=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=vG8Fr6Yj1hzydmFc1d4tVZ2Gf+XjimWbEU/ZyXy7vxN8+odmFJZvKtNU06ls9USix
         MmVGaJU2XjiscMll3NVZ7dA4AIZz150fo3mWYZByluCXsyrZC1DN196xxyeUbIui/X
         P8UezN9grTUwrjbXxOHgCf2vtHZuZZNrA2wNwjWQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191213211409.GA200528@google.com>
References: <20191213211409.GA200528@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191213211409.GA200528@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
 tags/pci-v5.5-fixes-1
X-PR-Tracked-Commit-Id: ca01e7987463e8675f223c366e262e82f633481a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1d76c0792a0a12529b4d7b052d511dff9cc1b273
Message-Id: <157627861467.1837.10905283759987326525.pr-tracker-bot@kernel.org>
Date:   Fri, 13 Dec 2019 23:10:14 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Vicente Bergas <vicencb@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Fri, 13 Dec 2019 15:14:09 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.5-fixes-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1d76c0792a0a12529b4d7b052d511dff9cc1b273

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
