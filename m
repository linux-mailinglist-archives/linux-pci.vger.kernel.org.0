Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC9422D395
	for <lists+linux-pci@lfdr.de>; Sat, 25 Jul 2020 03:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbgGYBpG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jul 2020 21:45:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:33512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726777AbgGYBpE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Jul 2020 21:45:04 -0400
Subject: Re: [GIT PULL] PCI fixes for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595641504;
        bh=TLPSRgQNl4mELXBsWUruist1EL/Q5kutrSoa4wfjJ3g=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=pE5YKB9fgRWEMCGpjoCXkYBkRsyNFmD3agN1chDL2k0i+51ZQd2NhkR6FSi/4+LW0
         cxkkk6aYY7+hSkM1NeyHlPvK3pf5ZVejjfw1/d7e9kkRzeGln8MIiu6g1WYPPz7R/v
         bAhqj/Surc49Ktg61E0i18B75o5/LcgFxwh0u+Xw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200725001753.GA1556558@bjorn-Precision-5520>
References: <20200725001753.GA1556558@bjorn-Precision-5520>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200725001753.GA1556558@bjorn-Precision-5520>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
 tags/pci-v5.8-fixes-2
X-PR-Tracked-Commit-Id: d08c30d7a0d1826f771f16cde32bd86e48401791
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 23ee3e4e5bd27bdbc0f1785eef7209ce872794c7
Message-Id: <159564150443.24850.11511871924806850622.pr-tracker-bot@kernel.org>
Date:   Sat, 25 Jul 2020 01:45:04 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Patrick Volkerding <volkerdi@gmail.com>,
        Karol Herbst <kherbst@redhat.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Fri, 24 Jul 2020 19:17:53 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.8-fixes-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/23ee3e4e5bd27bdbc0f1785eef7209ce872794c7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
