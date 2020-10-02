Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB3FB281DE3
	for <lists+linux-pci@lfdr.de>; Fri,  2 Oct 2020 23:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725783AbgJBVyT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Oct 2020 17:54:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:57096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgJBVyP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Oct 2020 17:54:15 -0400
Subject: Re: [GIT PULL] PCI fixes for v5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601675654;
        bh=Sedu4Ol4Dx2hlL9u19V1g53nGqB7sE7TdbvwP8ClP0U=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=121ZF9EkqjiJX07IkIYxgRdQcSAxx5E/kLj1JvL1+4crocuy+xc3sAqHyRD1ukMys
         +2zd6fwLYV0UPnAW7BAFE7vgmJvVltpmVwURjRqVPS2TOEoXNR7oH94nDUuU9/txNK
         VeYCahl8FJvIFrLIqS2XEVq6KASGdjNi78IN+dRY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201002192340.GA2820115@bjorn-Precision-5520>
References: <20201002192340.GA2820115@bjorn-Precision-5520>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201002192340.GA2820115@bjorn-Precision-5520>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.9-fixes-2
X-PR-Tracked-Commit-Id: 76a6b0b90d532ed9bb9f6069aa12859c185e5b99
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4d9c3a688a01e7dd0a33cf3ddb7b206cf867b615
Message-Id: <160167565446.8763.4518696998898472595.pr-tracker-bot@kernel.org>
Date:   Fri, 02 Oct 2020 21:54:14 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Samuel Dionne-Riel <samuel@dionne-riel.com>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Fri, 2 Oct 2020 14:23:40 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.9-fixes-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4d9c3a688a01e7dd0a33cf3ddb7b206cf867b615

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
