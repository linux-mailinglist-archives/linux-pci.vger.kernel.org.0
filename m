Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B85A1F083C
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jun 2020 21:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbgFFTPQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 6 Jun 2020 15:15:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:34194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728861AbgFFTPP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 6 Jun 2020 15:15:15 -0400
Subject: Re: [GIT PULL] PCI changes for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591470914;
        bh=0OAUsjS8ejSBSUuqOzZpCMvyYK4oslAfpDIzBCWdxSw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=lYP4Epxw9HvlYtrG8RJaC5X78zPB7U/r+Jh6iF5VnwvOpHLs9SKJ0xeWxCTIv6mya
         jHMYxLuXBj/T/qmWYZpiw1XLn3tW2opguMbH+jkseYWvMyFFPoYZZFF+YTbi6lIHoH
         +Ie1vuBjNT/T6QmaXAfQpcNPyykRre5DePlUIddo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200605202257.GA1152522@bjorn-Precision-5520>
References: <20200605202257.GA1152522@bjorn-Precision-5520>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200605202257.GA1152522@bjorn-Precision-5520>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
 tags/pci-v5.8-changes
X-PR-Tracked-Commit-Id: 2bd81cd04a3f5eb873cc81fa16c469377be3b092
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3925c3bbdf886f1ddf64461b9b380e1bb36f90c1
Message-Id: <159147091458.3313.10169776897827819725.pr-tracker-bot@kernel.org>
Date:   Sat, 06 Jun 2020 19:15:14 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Fri, 5 Jun 2020 15:22:57 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.8-changes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3925c3bbdf886f1ddf64461b9b380e1bb36f90c1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
