Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCF3839A9E5
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jun 2021 20:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbhFCSUh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Jun 2021 14:20:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:48380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhFCSUg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Jun 2021 14:20:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CAAAF61358;
        Thu,  3 Jun 2021 18:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622744332;
        bh=CSJutBaO8ghp6Ba0z+y7XoQ0Jho9Le2PuTYpsD5hnG8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KAtgFrvsRc5X2el0TXXVx4faTShu8l1zXitosLH3Ry6ovuubCJygWuWxxl3qUZG6T
         /PzM+8kLh/bXM4Ommd3dWwf84M5lXZhrvCOYyHZMnTnqzNC01L6zezNKJ/eKMJ9tQE
         Ws+uhdoktwXVW2vCDc1nH8HKY+rJzv/NbjRscpbaKnHq3inrkQd6uZ4QFT5hu9l9ph
         HdnGe6hKIKRm6A5UWQAbGZN1exz4QmeLNjsu8DPy9j1p/RZHnt1gYW8aw10k560Q+i
         60ahUXVOwBa+rDX1Mh52pM5aKuY4xNAWrmpZsohA9Cbi9gHoTrxoJjT2E9UJwC9wL6
         x8ypzMjD1vyhQ==
Received: by pali.im (Postfix)
        id 78F471229; Thu,  3 Jun 2021 20:18:49 +0200 (CEST)
Date:   Thu, 3 Jun 2021 20:18:49 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Simon Glass <sjg@chromium.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Remi Pommarel <repk@triplefau.lt>, Xogium <contact@xogium.me>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        lak <linux-arm-kernel@lists.infradead.org>,
        lk <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/42] PCI: aardvark: Various driver fixes
Message-ID: <20210603181849.gec53hz6c4rdya3q@pali>
References: <20210506153153.30454-1-pali@kernel.org>
 <20210603151605.GA18917@lpieralisi>
 <CAPnjgZ38G2Xzz1pTp3kCdaTZrDe+hKoBbqsGLKHyLfjUM7wH7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPnjgZ38G2Xzz1pTp3kCdaTZrDe+hKoBbqsGLKHyLfjUM7wH7g@mail.gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday 03 June 2021 12:02:28 Simon Glass wrote:
> Reordering to put the important things first seems reasonable.

This is already done. Patches are in "logical" order and the first patch
is the most important.
