Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6E8D2140A0
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jul 2020 23:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbgGCVPL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Jul 2020 17:15:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:56274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726903AbgGCVPJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 3 Jul 2020 17:15:09 -0400
Subject: Re: [GIT PULL] PCI fixes for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593810908;
        bh=3RFNe7O4/XnANe+AF6v/cwBPi/6xSUP2qXTlQ9fyF5U=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=TR/2R00xpe3/z5oOJT+t/HuRWfrIQEoG+ePGRlZfkf1u8Hao0vaQl6EOMckdcs11V
         MyESI1LXCUt3dduXDL5v1QJ9Tcw17GTovlaa1V00feNUoLEm226nJrKJrSOdwH55uy
         Y2hoLdbRk930d5XNzctJXQswZA5p/SeOmO0eQFS0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200703160455.GA3899841@bjorn-Precision-5520>
References: <20200703160455.GA3899841@bjorn-Precision-5520>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200703160455.GA3899841@bjorn-Precision-5520>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
 pci-v5.8-fixes-1
X-PR-Tracked-Commit-Id: 5396956cc7c6874180c9bfc1ceceb02b739a6a87
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7fec3ce50a5d3fc54de9c0e9d43682ea9320b199
Message-Id: <159381090863.9451.6625199989743957374.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Jul 2020 21:15:08 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yicong Yang <yangyicong@hisilicon.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Fri, 3 Jul 2020 11:04:55 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci-v5.8-fixes-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7fec3ce50a5d3fc54de9c0e9d43682ea9320b199

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
