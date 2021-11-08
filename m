Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F279C449D0F
	for <lists+linux-pci@lfdr.de>; Mon,  8 Nov 2021 21:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236422AbhKHUaH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Nov 2021 15:30:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:41886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230243AbhKHUaH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 8 Nov 2021 15:30:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id F28D66105A;
        Mon,  8 Nov 2021 20:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636403242;
        bh=wiPye9ZW4Cw+QEu4MgNR0oKoJP1XMIm5TW6cm5zIAUw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MYZlV4RwGwGXspUSD9APTDPrrJG0YqoHf74ydkZS/+Z7siwNJ0igyJSRhU2MfTOOV
         uRuoiFc/NNorxkwxDyg1+77Z+mUDCLr4jfEoNcp2Ku0Hp38yGFECwoDRrT61kLBOMG
         3nFIrtKHyU/4XMz5MeJeaSJF/qPkMXPKqmQfM9q/MC4Z2ozujwIKrdB/qRJYZZo7jK
         RCv9d4y9zi28aAixf14rkl34+mqOLtYHMlII4QD49p3221HSec/LJHV7kFp2jfrB7Q
         fReYKQ+Z7Swyq1YofFfvoqcCML2TJNHn+Ewg+GYpDtpgg42l0GyJsDVV7uyFjKOCBf
         MLkuQqBClRJaQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id DE628609F7;
        Mon,  8 Nov 2021 20:27:21 +0000 (UTC)
Subject: Re: [GIT PULL] Compute Express Link update for v5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPcyv4gSGURnUvkvMyfr+SbSZikhBdyCLXVkqn_Sa8PbjtxUXQ@mail.gmail.com>
References: <CAPcyv4gSGURnUvkvMyfr+SbSZikhBdyCLXVkqn_Sa8PbjtxUXQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPcyv4gSGURnUvkvMyfr+SbSZikhBdyCLXVkqn_Sa8PbjtxUXQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-for-5.16
X-PR-Tracked-Commit-Id: c6d7e1341cc99ba49df1384c8c5b3f534a5463b1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dd72945c43d34bee496b847e021069dc31f7398f
Message-Id: <163640324185.16718.9269640037737097197.pr-tracker-bot@kernel.org>
Date:   Mon, 08 Nov 2021 20:27:21 +0000
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-cxl@vger.kernel.org, Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux PCI <linux-pci@vger.kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Thu, 4 Nov 2021 18:20:55 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-for-5.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dd72945c43d34bee496b847e021069dc31f7398f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
