Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 484862DB814
	for <lists+linux-pci@lfdr.de>; Wed, 16 Dec 2020 02:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgLPBAp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Dec 2020 20:00:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:50588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726326AbgLPBAo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Dec 2020 20:00:44 -0500
Subject: Re: [GIT PULL] PCI changes for v5.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608080404;
        bh=4vIwGLtmlwusJpyielJLpW0POUf+abIMCvZWlBiNb70=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Xt0Za2ThVMd12ObTYGgGNqxovv90dXh0CYFPlBEt7AT0IGA6IAPh8PfbFvyi6Sd3j
         X0WBggY0SgXGxxH6NIGaFvfKg514wTjxV6jz4CrKhG9QJnUTyhK00xF/kl4BhxybJe
         glxSnYmcW4gOyQHtkOOZh9tFzWOfkszUxgekU4OElmVl/0FmHCf2n00pXVKxSV4FJg
         amv4bZvvyxlLGKzGUQAzsRMIkldsHLVIl/jicLN7Uz1WjfT67POvDlF+vIqpAXxJNg
         1GKqRemDJiocIjgKgKfHJu7GkJT0RFRNJbnjjFCJB6eEZZ4GPrY3K09MHq6H8qbw2e
         dklVhzQPFbnjw==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201215212315.GA329401@bjorn-Precision-5520>
References: <20201215212315.GA329401@bjorn-Precision-5520>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201215212315.GA329401@bjorn-Precision-5520>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.11-changes
X-PR-Tracked-Commit-Id: 255b2d524884e4ec60333131aa0ca0ef19826dc2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 489e9fea66f31086f85d9a18e61e4791d94a56a4
Message-Id: <160808040445.29576.2650908190722218652.pr-tracker-bot@kernel.org>
Date:   Wed, 16 Dec 2020 01:00:04 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Tue, 15 Dec 2020 15:23:15 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.11-changes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/489e9fea66f31086f85d9a18e61e4791d94a56a4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
