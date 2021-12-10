Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6591F470611
	for <lists+linux-pci@lfdr.de>; Fri, 10 Dec 2021 17:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243873AbhLJQrp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Dec 2021 11:47:45 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51510 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbhLJQro (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Dec 2021 11:47:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C3F79B828FF;
        Fri, 10 Dec 2021 16:44:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D57AC00446;
        Fri, 10 Dec 2021 16:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639154647;
        bh=1dCV6LcfGpHJEPhtJfXNwx9G47Jlz6Mvns/Al5xom8o=;
        h=Date:From:To:Cc:Subject:From;
        b=TV7XzByI1n79hcV6qfP7RqSqMhIe2NycHRJ0fuKh9eYe/20vX6d/9Q3ywDduXOl9O
         SFM/Blep28gT9caxvu6Aa2/KnSQ1QFzF8s2mheAytrq4AkSUesxz8iDMOYpoysp0yw
         27P4koz2Y6uRCyy8osD5c5XNc55khb2N1R41CbdOMKku0guj6sRNGmtMtigryTZN/J
         7Vup3j6bldaZmRAoyh5m6U/haJ4ikNdTP/2qNVwtPHig67r5C8zX6jkHe9kATI9/jY
         HOYpT9OAXy2RU7XVAuiLlUYN+U48kexVvgU5J2zsycEqd8FcUIowjl8oYfIs3JvCpX
         KbC9+WT2IesJg==
Date:   Fri, 10 Dec 2021 10:44:06 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Mark Kettenis <kettenis@openbsd.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [GIT PULL] PCI fixes for v5.16
Message-ID: <20211210164406.GA320857@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.16-fixes-2

for you to fetch changes up to 87620512681a20ef24ece85ac21ff90c9efed37d:

  PCI: apple: Fix PERST# polarity (2021-12-07 14:27:29 -0600)

----------------------------------------------------------------
PCI fixes:

  - Revert emulation of Marvell Armada A3720 expansion ROM because it
    doesn't work as expected (Marek Behún) 

  - Assert PERST# in Apple M1 driver to fix initialization when booting
    from bootloaders using PCIe, such as U-Boot (Marc Zyngier)

  - Describe PERST# as active low in Apple T8103 DT and update driver to
    match (Marc Zyngier)

----------------------------------------------------------------
Marc Zyngier (3):
      PCI: apple: Follow the PCIe specifications when resetting the port
      arm64: dts: apple: t8103: Mark PCIe PERST# polarity active low in DT
      PCI: apple: Fix PERST# polarity

Marek Behún (1):
      Revert "PCI: aardvark: Fix support for PCI_ROM_ADDRESS1 on emulated bridge"

 arch/arm64/boot/dts/apple/t8103.dtsi  |  7 ++++---
 drivers/pci/controller/pci-aardvark.c |  9 ---------
 drivers/pci/controller/pcie-apple.c   | 14 ++++++++++++--
 3 files changed, 16 insertions(+), 14 deletions(-)
