Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1AF31006E
	for <lists+linux-pci@lfdr.de>; Fri,  5 Feb 2021 00:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbhBDXBl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Feb 2021 18:01:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:38166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229549AbhBDXBl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Feb 2021 18:01:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C04B664FAC;
        Thu,  4 Feb 2021 23:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612479660;
        bh=kVM6VBgL+y9qipwjc0ExHBNzA16ZOO2uYRWiHLi7BxQ=;
        h=Date:From:To:Cc:Subject:From;
        b=cMqrGVaKLyV9RCZgXb4nwz6hzSaxLyR64ozh6olheCBEgC1JF8gKyGvPiMl/wPeAM
         AiUgKObgKgHGxhxI0c9NCT+PSvn3L+rZVZxrhfgCaodjPXVGx8r1mfP4aqvwE9BYLm
         CJdMcFaZ81D2D68okdW1oo5GDNTKEkbSUMZUa4hgGMFYPX9FQ2UkFUvLG1wb4vroaq
         HTJXeIx3aOd3Q+8n9waRupxhyDQ+6sPJarpCB9x5IL/Ij2CxJQ6H6G1tzUbbEwIOOG
         l4npnHqLHi3fPzd3p/jaOciKHc++2i7i1SvawlMeOo2WdHItHaXBPwTg/u8t+7lVXe
         ZFIxJQLz2pjYw==
Date:   Thu, 4 Feb 2021 17:00:58 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        "Kenneth R. Crudup" <kenny@panix.com>,
        Vidya Sagar <vidyas@nvidia.com>
Subject: [GIT PULL] PCI fixes for v5.11
Message-ID: <20210204230058.GA124906@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The following changes since commit 7c53f6b671f4aba70ff15e1b05148b10d58c2837:

  Linux 5.11-rc3 (2021-01-10 14:34:50 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci-v5.11-fixes-2

for you to fetch changes up to 40fb68c7725aee024ed99ad38504f5d25820c6f0:

  Revert "PCI/ASPM: Save/restore L1SS Capability for suspend/resume" (2021-01-27 10:12:43 -0600)

----------------------------------------------------------------
PCI fixes:

  - Revert ASPM suspend/resume fix that regressed NVMe devices (Bjorn
    Helgaas)

----------------------------------------------------------------
Bjorn Helgaas (1):
      Revert "PCI/ASPM: Save/restore L1SS Capability for suspend/resume"

 drivers/pci/pci.c       |  7 -------
 drivers/pci/pci.h       |  4 ----
 drivers/pci/pcie/aspm.c | 44 --------------------------------------------
 3 files changed, 55 deletions(-)
