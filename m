Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C088E4231D
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2019 12:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438097AbfFLK5o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jun 2019 06:57:44 -0400
Received: from mga02.intel.com ([134.134.136.20]:8996 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438095AbfFLK5o (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Jun 2019 06:57:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2019 03:57:43 -0700
X-ExtLoop1: 1
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 12 Jun 2019 03:57:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id D5D41141; Wed, 12 Jun 2019 13:57:39 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v2 0/2] PCI: Power management improvements
Date:   Wed, 12 Jun 2019 13:57:37 +0300
Message-Id: <20190612105739.88578-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi all,

This series includes a couple of changes to the PCI power management that
should make Linux follow the PCIe spec better. The issues this series aims
to solve came up with Intel Ice Lake Thunderbolt enabling where the
controller is first time integrated into the SoC but I think these issues
are generic to any platform having similar configuration.

Changes from v1

  * I dropped the last patch as it requires bit more work and not dependent
    on the other two. I will send it out separately.
  * Re-arranged conditionals in wait_for_downstream_link()
  * Moved comments to be part of kernel-doc
  * Added tags from Rafael and Lukas

Previous version is here:

  https://www.spinics.net/lists/linux-pci/msg83582.html

Mika Westerberg (2):
  PCI: Add missing link delays required by the PCIe spec
  PCI: Do not poll for PME if the device is in D3cold

 drivers/pci/pci.c               | 36 +++++++++++++-----
 drivers/pci/pci.h               |  1 +
 drivers/pci/pcie/portdrv_core.c | 66 +++++++++++++++++++++++++++++++++
 3 files changed, 93 insertions(+), 10 deletions(-)

-- 
2.20.1

