Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA0E4F736
	for <lists+linux-pci@lfdr.de>; Sat, 22 Jun 2019 18:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbfFVQzI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 22 Jun 2019 12:55:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:39626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726373AbfFVQzI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 22 Jun 2019 12:55:08 -0400
Subject: Re: [GIT PULL] PCI fixes for v5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561222507;
        bh=TmI60IdstKwzL5rWX1gR16rSdB4fTmmT42vxELtOuGk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=D0YDXn8LGlTNqmMTOqPqtAisboqxa3OyEI7FZydADutCPj3aGsU9r/xtkZ69NZPfX
         AX0CI1uT8/3IxjHmJyyEQu5GRcEBNsCy9+u7s1gHWpGZIaRjxqlCQb4cs6R3/UYdBF
         IF11c0jjczzieyUXgiHjM0LdwfcIDEDqN2HLhV2o=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190622161623.GH127746@google.com>
References: <20190622161623.GH127746@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190622161623.GH127746@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
 tags/pci-v5.2-fixes-1
X-PR-Tracked-Commit-Id: 6dbbd053e6aea827abde89ac9b9d6855dab1a66b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b253d5f3ecc95c2b4e8d4a525fd754c9e32b0f6e
Message-Id: <156122250711.32167.7740430801446747430.pr-tracker-bot@kernel.org>
Date:   Sat, 22 Jun 2019 16:55:07 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Christoph Hellwig <hch@lst.de>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Sat, 22 Jun 2019 11:16:23 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.2-fixes-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b253d5f3ecc95c2b4e8d4a525fd754c9e32b0f6e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
