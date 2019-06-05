Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1E1635FBA
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2019 16:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbfFEO6Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Jun 2019 10:58:25 -0400
Received: from mga11.intel.com ([192.55.52.93]:16351 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728287AbfFEO6Z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Jun 2019 10:58:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jun 2019 07:58:24 -0700
X-ExtLoop1: 1
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 05 Jun 2019 07:58:22 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 37C8A2D4; Wed,  5 Jun 2019 17:58:20 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH 0/3] PCI: Power management improvements
Date:   Wed,  5 Jun 2019 17:58:17 +0300
Message-Id: <20190605145820.37169-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi all,

This series includes a couple of changes to the PCI power management that
should make Linux follow the PCIe spec better and also support for sibling
PCIe devices sharing ACPI power resources. The issues this series aims to
solve came up with Intel Ice Lake Thunderbolt enabling where the controller
is first time integrated into the SoC but I think these issues are generic
to any platform having similar configuration.

Mika Westerberg (3):
  PCI: Add missing link delays required by the PCIe spec
  PCI: Do not poll for PME if the device is in D3cold
  PCI / ACPI: Handle sibling devices sharing power resources

 drivers/acpi/power.c            |  32 ++++++++
 drivers/pci/pci-acpi.c          |  32 ++++++--
 drivers/pci/pci.c               | 138 ++++++++++++++++++++++++--------
 drivers/pci/pci.h               |   6 ++
 drivers/pci/pcie/portdrv_core.c |  62 ++++++++++++++
 include/acpi/acpi_bus.h         |   3 +
 6 files changed, 233 insertions(+), 40 deletions(-)

-- 
2.20.1

