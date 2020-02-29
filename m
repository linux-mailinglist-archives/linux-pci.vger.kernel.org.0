Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDFB1744A3
	for <lists+linux-pci@lfdr.de>; Sat, 29 Feb 2020 04:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgB2DHX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Feb 2020 22:07:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:53424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbgB2DHX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 28 Feb 2020 22:07:23 -0500
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 213522467B;
        Sat, 29 Feb 2020 03:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582945642;
        bh=JQxEDDVntbAL1wk6neHNK4wBWljvTi4O65b62BxELh0=;
        h=From:To:Cc:Subject:Date:From;
        b=vSP691vGIoT6My8ECozvrzBEXRhfc+6CriSmFzVAHAv48XCz0u6fOH6+egKm8a2Lf
         FKRpq04IqOENEZFIJJ4ppYmaqmoKwZfsmhMALFBS17gK0DXwQiS5FIWpF3oNlDdgjE
         rtVRhKT14P5BkJZzj9LD7eJ10jXhbOkE4H6MJuO8=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     Jay Fang <f.fangjian@huawei.com>, huangdaode@huawei.com,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v5 0/4] Improve link speed presentation process
Date:   Fri, 28 Feb 2020 21:07:02 -0600
Message-Id: <20200229030706.17835-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Here's my proposal for merging this series.

The main difference from v4 is that this adds a pci_speed_string()
interface instead of making the table public and uses that everywhere
instead of PCI_SPEED2STR().


v4: https://lore.kernel.org/r/1581937984-40353-1-git-send-email-yangyicong@hisilicon.com

Bjorn Helgaas (2):
  PCI: Add pci_speed_string()
  PCI: Use pci_speed_string() for all PCI/PCI-X/PCIe strings

Yicong Yang (2):
  PCI: Add 32 GT/s decoding in some macros
  PCI: Add PCIE_LNKCAP2_SLS2SPEED() macro

 drivers/pci/controller/pcie-brcmstb.c |  3 +--
 drivers/pci/pci-sysfs.c               | 27 ++++---------------
 drivers/pci/pci.c                     | 23 +++++-----------
 drivers/pci/pci.h                     | 19 ++++++++------
 drivers/pci/probe.c                   | 38 +++++++++++++++++++++++++++
 drivers/pci/slot.c                    | 38 +--------------------------
 include/linux/pci.h                   |  2 +-
 7 files changed, 64 insertions(+), 86 deletions(-)


base-commit: bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9
-- 
2.25.0.265.gbab2e86ba0-goog

