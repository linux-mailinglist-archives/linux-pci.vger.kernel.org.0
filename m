Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95AEF9A0BB
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2019 22:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392582AbfHVUGA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Aug 2019 16:06:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:57916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387738AbfHVUGA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Aug 2019 16:06:00 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3463423400;
        Thu, 22 Aug 2019 20:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566504359;
        bh=E+RM8lcOXSVIMYx4+rXzzGMSVrhC1b6YIQ0v0hDRtG4=;
        h=From:To:Cc:Subject:Date:From;
        b=gEi5ksaa9IiQKCO40DUHyjA4t8hhezRyG4yFoVnlCwlS2OzU6PtiMBv4Q8C5C0EiR
         Xb2cGtGYsiuDwF8yl5xp7I6QqeJNJl5DQyoJ8wXfjmgsVdYTELkfnLuoxmycnfv41b
         mGOH0VBhCsjTJS6mkFr20D1ToX/qo7gS9DQ4EWyU=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <keith.busch@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 0/3] PCI: Add PCI_ERROR_RESPONSE, check for errors
Date:   Thu, 22 Aug 2019 15:05:48 -0500
Message-Id: <20190822200551.129039-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Reads from a PCI device may fail if the device has been turned off (put
into D3cold), removed, or if some other error occurs.  The PCI host bridge
typically fabricates ~0 data to complete the CPU's read.

We check for that in a few places, but not in a consistent way.  This
series adds a PCI_ERROR_RESPONSE definition to make the checks more
consistent and easier to find.  Note that ~0 may indicate a PCI error, but
it may also be valid read data, so you need more information (such as
knowing that a register can never contain ~0) before concluding that it's
an error.

This series also adds a new check for PCI_ERROR_RESPONSE in the power
management code because that code frequently encounters devices in D3cold,
where we previously misinterpreted ~0 data.  It also uses pci_power_name()
to print D-state names more consistently.

Rafael, I didn't add your Reviewed-by to "PCI / PM: Return error when
changing power state from D3cold" because I made small changes to try to
make the messages more consistent, and I didn't want to presume they'd be
OK with you.

Changes since v1:
  - Add Rafael's Reviewed-By to the first two patches
  - Drop "PCI / PM: Check for error when reading PME status" because Rafael
    pointed out that some devices can signal PME even when in D3cold, so
    this would require additional rework
  - Drop "PCI / PM: Check for error when reading Power State" because
    Rafael thinks it's mostly redundant

Bjorn Helgaas (3):
  PCI: Add PCI_ERROR_RESPONSE definition
  PCI / PM: Decode D3cold power state correctly
  PCI / PM: Return error when changing power state from D3cold

 drivers/pci/access.c                          | 13 ++++----
 .../pci/controller/dwc/pcie-designware-host.c |  2 +-
 drivers/pci/controller/pci-aardvark.c         |  2 +-
 drivers/pci/controller/pci-mvebu.c            |  4 +--
 drivers/pci/controller/pci-thunder-ecam.c     | 20 ++++++------
 drivers/pci/controller/pci-thunder-pem.c      |  2 +-
 drivers/pci/controller/pcie-altera.c          |  2 +-
 drivers/pci/controller/pcie-iproc.c           |  2 +-
 drivers/pci/controller/pcie-mediatek.c        |  4 +--
 drivers/pci/controller/pcie-rcar.c            |  2 +-
 drivers/pci/controller/pcie-rockchip-host.c   |  2 +-
 drivers/pci/controller/vmd.c                  |  2 +-
 drivers/pci/hotplug/cpqphp_ctrl.c             | 12 +++----
 drivers/pci/hotplug/cpqphp_pci.c              | 20 ++++++------
 drivers/pci/hotplug/pciehp_hpc.c              |  6 ++--
 drivers/pci/pci.c                             | 31 ++++++++++++-------
 drivers/pci/pcie/dpc.c                        |  3 +-
 drivers/pci/pcie/pme.c                        |  4 +--
 drivers/pci/probe.c                           |  4 +--
 drivers/pci/quirks.c                          |  2 +-
 include/linux/pci.h                           |  7 +++++
 21 files changed, 81 insertions(+), 65 deletions(-)

-- 
2.23.0.187.g17f5b7556c-goog

