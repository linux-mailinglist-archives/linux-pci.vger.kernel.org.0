Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 818F93255AD
	for <lists+linux-pci@lfdr.de>; Thu, 25 Feb 2021 19:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbhBYSiQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Feb 2021 13:38:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:34840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233984AbhBYSha (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Feb 2021 13:37:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 7F80864F27;
        Thu, 25 Feb 2021 18:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614278205;
        bh=VobkIFVTdagdQFJoXDl2ODTK74l3/TAVlyqpuXbPn+Q=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Tgy6l4r2KX/GB6n30BhVrT3LzgNfht29NehwrhvfqBVvBPoHqSimNYkuGsUfOWueW
         gmdbAw1SUvfsoG+tVacYL/tRvCW4Qtt6zNo7a2rGvDEKAkfBlUpFHvXmrTE6SbEMcG
         Rcz9wjCXd7nN2UjjlivFMU5QQmvw5kG2zotWtzKxW/Kx5rnU91zHSqKuV1urUnJP2x
         UhsrEWtvvsgCNShNCBdvXF6vkCKICZjOyIhKFmFcsjWCgw7H5CfCbFMx/hfJLW+X7w
         tiyHkINLrzN+tMEKp7pmL/LkWBDseqdyspZoaykUFYgMuHwktqkYIHjDCtNTRELpQk
         3tAi+mNCV7ykw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 7ADAD60A0E;
        Thu, 25 Feb 2021 18:36:45 +0000 (UTC)
Subject: Re: [GIT PULL v2] PCI changes for v5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210225153738.GA1730576@bjorn-Precision-5520>
References: <20210225153738.GA1730576@bjorn-Precision-5520>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210225153738.GA1730576@bjorn-Precision-5520>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.12-changes
X-PR-Tracked-Commit-Id: e18fb64b79860cf5f381208834b8fbc493ef7cbc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5b47b10e8fb92f8beca6aa8a7d97fc84e090384c
Message-Id: <161427820549.26451.13322892856799080814.pr-tracker-bot@kernel.org>
Date:   Thu, 25 Feb 2021 18:36:45 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Thu, 25 Feb 2021 09:37:38 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.12-changes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5b47b10e8fb92f8beca6aa8a7d97fc84e090384c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
