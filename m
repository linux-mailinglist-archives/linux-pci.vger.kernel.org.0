Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89C113142D
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2019 19:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfEaRuP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 31 May 2019 13:50:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:53612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726559AbfEaRuP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 31 May 2019 13:50:15 -0400
Subject: Re: [GIT PULL] Power management fixes for v5.2-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559325014;
        bh=1uNn4UV8s8gJqIbrHZ2bjVDwyLQo8Ul7KEirUnLw2H8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=YYyPrUzpoXk1ovcrAaM0FczXF8G1paH2rGUNujfLMPHNXK7evfI9u/8VCK0OOrTbC
         rKczvo3WAWU8eH9U7m2eQXxHd/j7Lz5TYBM2b38pQ5Y5Pag+seeetOar5RkbBKm2yz
         +iLwYk9J+8ZRBzfwQsyCvYxvjZAODUFdZ4ecyQKY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0j_uQxWZRjJ_=S1b=NRpLfyf_0KHfyPwSj30SRWr9RzHg@mail.gmail.com>
References: <CAJZ5v0j_uQxWZRjJ_=S1b=NRpLfyf_0KHfyPwSj30SRWr9RzHg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0j_uQxWZRjJ_=S1b=NRpLfyf_0KHfyPwSj30SRWr9RzHg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.2-rc3
X-PR-Tracked-Commit-Id: d491f2b75237ef37d8867830ab7fad8d9659e853
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 702c31e8564c386dd5e304e46cf22fcaa40b1a66
Message-Id: <155932501464.32255.6800544085473144174.pr-tracker-bot@kernel.org>
Date:   Fri, 31 May 2019 17:50:14 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Fri, 31 May 2019 11:21:57 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.2-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/702c31e8564c386dd5e304e46cf22fcaa40b1a66

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
