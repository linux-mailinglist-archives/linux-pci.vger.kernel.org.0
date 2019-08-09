Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5137088048
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2019 18:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437308AbfHIQfJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Aug 2019 12:35:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:50646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437311AbfHIQfI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Aug 2019 12:35:08 -0400
Subject: Re: [GIT PULL] Power management fix for v5.3-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565368507;
        bh=G0du5UKxFgMmOYmCBIFTj9ntUjh4VpjlD4YwqFj3VB0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=jsHxWbzS9YpFfdEdMIPr4ZuHzS6EiW18xcwZk7x8QO+pFHJ1yQ803hmzNIXKizWDS
         vUzENB9ZyoCtm5q0iG3BzmIQFXDYcgXSZBH+Fb2fnY0QKLr+M4sDoveEyGzjMzlwSA
         HyoNBebqhhDAK8oX4UUx14XPfAsNsafl8c1DPn4M=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jeVsVCC70s-jVphdMH9zx+pFTcMm-EhHcthJCtDxwkvQ@mail.gmail.com>
References: <CAJZ5v0jeVsVCC70s-jVphdMH9zx+pFTcMm-EhHcthJCtDxwkvQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jeVsVCC70s-jVphdMH9zx+pFTcMm-EhHcthJCtDxwkvQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.3-rc4
X-PR-Tracked-Commit-Id: 0617bdede5114a0002298b12cd0ca2b0cfd0395d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0acf5676dc0ffe0683543a20d5ecbd112af5b8ee
Message-Id: <156536850784.6429.11653924089047359420.pr-tracker-bot@kernel.org>
Date:   Fri, 09 Aug 2019 16:35:07 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Fri, 9 Aug 2019 10:47:28 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.3-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0acf5676dc0ffe0683543a20d5ecbd112af5b8ee

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
