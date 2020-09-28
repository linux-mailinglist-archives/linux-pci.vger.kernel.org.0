Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9BE27A52F
	for <lists+linux-pci@lfdr.de>; Mon, 28 Sep 2020 03:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgI1B0I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Sep 2020 21:26:08 -0400
Received: from mga17.intel.com ([192.55.52.151]:64441 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726409AbgI1B0H (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 27 Sep 2020 21:26:07 -0400
IronPort-SDR: zO7gg8CL1dcPdc4CI2ippYlL5LjWXYpJ8sTw39YZyBU9jPJhmZcskfxfgMnFxo93OvROFwpBeB
 m5qzBIL9t8TA==
X-IronPort-AV: E=McAfee;i="6000,8403,9757"; a="141939475"
X-IronPort-AV: E=Sophos;i="5.77,312,1596524400"; 
   d="scan'208";a="141939475"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2020 18:26:22 -0700
IronPort-SDR: 0VSKrOT+v7m8T671vnRLXaD4gw0KcXcKhzaKDotwCl+bYj2Fz+HeayPxBr7pyD8cClT6Mf8Z+L
 bOHb6kNiehzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,312,1596524400"; 
   d="scan'208";a="456639867"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.116.36])
  by orsmga004.jf.intel.com with ESMTP; 27 Sep 2020 18:26:22 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     <linux-pci@vger.kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Andrzej Jakowski <andrzej.jakowski@linux.intel.com>,
        Dave Fugate <david.fugate@intel.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH 0/3] PCI: Minimizing resource assignment algorithm
Date:   Sun, 27 Sep 2020 21:06:06 -0400
Message-Id: <20200928010609.5375-1-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This set adds a minimizing resource assignment algorithm. VMD domains
frequently have issues with default hotplug settings and large arrays of
drives such as those in JBOFs. This algorithm uses the default or
user-specified hotplug resource settings, then tries with minimal
settings using 256 for IO, and 1MB for MMIO and Prefetch, and finally
tries without additional hotplug resources as if the bridge were not
hotplug capable.

This set allows a resource constrained domain to at the very least
enumerate and attach drivers to devices, though may not result in
supportable hotplug slot if a device is not already occupied in the
slot.

Jon Derrick (3):
  PCI: Create helper to release/restore bridge resources
  PCI: Introduce a minimizing assignment algorithm
  PCI: vmd: Wire up VMD for fallback resource assignment

 drivers/pci/controller/vmd.c |   2 +-
 drivers/pci/setup-bus.c      | 147 ++++++++++++++++++++++++++++-------
 include/linux/pci.h          |   2 +
 3 files changed, 124 insertions(+), 27 deletions(-)

-- 
2.18.1

