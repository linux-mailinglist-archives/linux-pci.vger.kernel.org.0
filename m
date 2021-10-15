Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57E6B42FC8E
	for <lists+linux-pci@lfdr.de>; Fri, 15 Oct 2021 21:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242814AbhJOTyR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Oct 2021 15:54:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:49846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238441AbhJOTyQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 15 Oct 2021 15:54:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A94E860200;
        Fri, 15 Oct 2021 19:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634327530;
        bh=hxwAnk1FabSqj7op8VZYmRJzUis5S3d4s2vbmcC+0G8=;
        h=Date:From:To:Cc:Subject:From;
        b=TwJgksIF/ABRFEoVIT6fC//RyS5YRuq8Z5OwFBqS16wOAFTK368o/HZicsiFBcE3q
         YZYvIQbAuihfPb00hBdmeYeeQUtkTSWBzgSHK5zraabU98NHM84MNYQWWULm22IkN4
         ZEMViqUD7OxqEXaHS7NWGmPT0q4KUblvBKlipbjZ1+NM2kbCJ7nVTbFmUCD847CDCI
         s2Lk6V+qqA4b9Uun7gmDgMbtcAICwrpk26lrRUK2tPzgykkpQopA8oZHMAQ+VtuGtU
         ziuFJVosb9OABmDsYbL1nxay12VxAIV+HoX0SEy+SnLom00Y3dnqs93PL7BUZ18x+2
         hwY6Y16upLtDw==
Date:   Fri, 15 Oct 2021 14:52:08 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wang Hai <wanghai38@huawei.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Hulk Robot <hulkci@huawei.com>
Subject: [GIT PULL] PCI fixes for v5.15
Message-ID: <20211015195208.GA2151683@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The following changes since commit e4e737bb5c170df6135a127739a9e6148ee3da82:

  Linux 5.15-rc2 (2021-09-19 17:28:22 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci-v5.15-fixes-2

for you to fetch changes up to 2b94b6b79b7c24092a6169db9e83c4565be0db42:

  PCI/MSI: Handle msi_populate_sysfs() errors correctly (2021-10-12 20:32:58 -0500)

----------------------------------------------------------------
PCI fixes:

  - Don't save msi_populate_sysfs() error code as dev->msi_irq_groups
    so we don't dereference the error code as a pointer (Wang Hai)

----------------------------------------------------------------
Wang Hai (1):
      PCI/MSI: Handle msi_populate_sysfs() errors correctly

 drivers/pci/msi.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)
