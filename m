Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE64A44DC52
	for <lists+linux-pci@lfdr.de>; Thu, 11 Nov 2021 20:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbhKKTxc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Nov 2021 14:53:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:51804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229710AbhKKTxb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Nov 2021 14:53:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E901561241;
        Thu, 11 Nov 2021 19:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636660242;
        bh=fPyBt7AKMRfKpDiq/z/CYanNpyOJhV3N4JWIwUTEOtU=;
        h=Date:From:To:Cc:Subject:From;
        b=FSC/65Qpk9LM54xgnpSiH2tes2MD0Boz+0/wy4qR3dWfBx/f5E4u9SwBh6abb/BYU
         2HmUwVUYDazXXU8JPiPLDEid2d7B3DAG/yDLj28GZRO+N0br5tSJ+XTgmVy5b3hIo5
         JKAqy57y73H19MRZ5YlnDpMK4FSRUCZyiLnPzfpIqx5rCljXyGpJPFfWQuEMq1hdi6
         NKk/qgebKpmYTajZOecJFjHwrXqrQnJhbuOPrMEA9On9oQzM6OIxYc+osRtujqUpjb
         RlKXn5YD/ipT+sjbLTEwHT8uR1DG5IrBXnkZ7sfzBxE5xt5O1K284bLf9lfRJjsnKE
         jpRfhfKez1N1Q==
Date:   Thu, 11 Nov 2021 13:50:40 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Robert =?utf-8?B?xZp3acSZY2tp?= <robert@swiecki.net>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] PCI fixes for v5.16
Message-ID: <20211111195040.GA1345641@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The following changes since commit dda4b381f05d447a0ae31e2e44aeb35d313a311f:

  Merge branch 'remotes/lorenzo/pci/xgene' (2021-11-05 11:28:53 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci-v5.16-fixes-1

for you to fetch changes up to e0217c5ba10d7bf640f038b2feae58e630f2f958:

  Revert "PCI: Use to_pci_driver() instead of pci_dev->driver" (2021-11-11 13:36:22 -0600)

N.B.: My for-linus branch, which contains these, also includes a revert of
041284181226 ("of/irq: Allow matching of an interrupt-map local to an
interrupt controller").  That revert is *not* included here and we hope we
don't need it, but that issue is not resolved yet.

----------------------------------------------------------------
PCI fixes:

  - Revert conversion to struct device.driver instead of struct
    pci_dev.driver.  The device.driver is set earlier, and using it
    caused the PCI core to call driver PM entry points before .probe()
    and after .remove(), when the driver isn't prepared.  This caused
    NULL pointer dereferences in i2c_designware_pci and probably other
    driver issues (Bjorn Helgaas)

----------------------------------------------------------------
Bjorn Helgaas (2):
      Revert "PCI: Remove struct pci_dev->driver"
      Revert "PCI: Use to_pci_driver() instead of pci_dev->driver"

 drivers/pci/iov.c        | 24 +++++++++---------------
 drivers/pci/pci-driver.c | 37 ++++++++++++++++++++-----------------
 drivers/pci/pci.c        | 17 ++++++++---------
 drivers/pci/pcie/err.c   |  8 ++++----
 include/linux/pci.h      |  1 +
 5 files changed, 42 insertions(+), 45 deletions(-)
