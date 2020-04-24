Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 728BC1B8122
	for <lists+linux-pci@lfdr.de>; Fri, 24 Apr 2020 22:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgDXUu1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Apr 2020 16:50:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:46710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbgDXUuT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Apr 2020 16:50:19 -0400
Subject: Re: [GIT PULL] ACPI fixes for v5.7-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587761419;
        bh=MrZDhQH3qL3b2Pu8BnrKB3mKxJmjlRW24pb89xcWtT0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=A+VtHgXUIrQDehT/X7QQP2zF4s6I69DWfmVYS9p7ifOxMo59wj+oHVoT8hWx3kb4X
         tT/yOJDYSqwzBXEx1L0WM8wJn/YVldx/cn9p3QT3SR88nwI00+OsJJTUWDd07xvcK3
         l1mGbIDQ4hlPzL41Lo8Bdj3Z4JDcT0g/XA1rs2Qg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0i=yOFpKuXeGnLh25xyvJsKcr9-3iSnHq7nA0_WMQKQwA@mail.gmail.com>
References: <CAJZ5v0i=yOFpKuXeGnLh25xyvJsKcr9-3iSnHq7nA0_WMQKQwA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0i=yOFpKuXeGnLh25xyvJsKcr9-3iSnHq7nA0_WMQKQwA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 acpi-5.7-rc3
X-PR-Tracked-Commit-Id: 0db0d142e2d2c7522764511f45c0d3c15dbd8be0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9dc5d985fdab0af8927f2cbe846e2d144cc4dbac
Message-Id: <158776141936.11860.9037659742850327145.pr-tracker-bot@kernel.org>
Date:   Fri, 24 Apr 2020 20:50:19 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Fri, 24 Apr 2020 21:22:11 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.7-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9dc5d985fdab0af8927f2cbe846e2d144cc4dbac

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
