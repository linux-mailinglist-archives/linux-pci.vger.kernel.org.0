Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9328A2C4C82
	for <lists+linux-pci@lfdr.de>; Thu, 26 Nov 2020 02:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730231AbgKZBS1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Nov 2020 20:18:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:38874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729679AbgKZBS1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Nov 2020 20:18:27 -0500
Received: from localhost (129.sub-72-107-112.myvzw.com [72.107.112.129])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80953206C0;
        Thu, 26 Nov 2020 01:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606353506;
        bh=V7MlPQFlobtD0sir/+h8W4SKAyV7EWgo18/G4Rrzi6U=;
        h=From:To:Cc:Subject:Date:From;
        b=wjbuZEfWDIJW+HIAFIOTpfDFKwsdiRB6q8dm8thZOoFe3x7d8e28ZYl45SGm9Xbnz
         IM2etds4mpg0y1+d+Dn6K2mFok6d+Z+19csbj6Mk3qnG4T9l0OQY4bpSJjHDxBUtLQ
         pIflPFLY0Ls1XdxtTGfzlibB+I5kWDiy1RCbwCZU=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     ashok.raj@intel.com, knsathya@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v12 0/5] Simplify PCIe native ownership
Date:   Wed, 25 Nov 2020 19:18:11 -0600
Message-Id: <20201126011816.711106-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

This is Sathy's work with a few tweaks on top.

I dropped the DPC pcie_ports_dpc_native changes for now just because I
haven't had time to understand it all.  We currently ignore the
OSC_PCI_EXPRESS_DPC_CONTROL bit, which seems wrong.  We might want to start
looking at it, but we should try to make that a separate patch that's as
small as possible.

Changes since v11:
 * Add bugfix for DPC with no AER Capability
 * Split OSC_OWNER trivial changes from pcie_ports_native changes
 * Temporarily drop pcie_ports_dpc_native changes

v11 posting: https://lore.kernel.org/r/cover.1603766889.git.sathyanarayanan.kuppuswamy@linux.intel.com

Bjorn Helgaas (2):
  PCI/DPC: Ignore devices with no AER Capability
  PCI/ACPI: Centralize pci_aer_available() checking

Kuppuswamy Sathyanarayanan (3):
  PCI: Assume control of portdrv-related features only when portdrv
    enabled
  PCI/ACPI: Tidy _OSC control bit checking
  PCI/ACPI: Centralize pcie_ports_native checking

 drivers/acpi/pci_root.c           | 49 ++++++++++++++++++++++++-------
 drivers/pci/hotplug/pciehp_core.c |  2 +-
 drivers/pci/pci-acpi.c            |  3 --
 drivers/pci/pcie/aer.c            |  2 +-
 drivers/pci/pcie/dpc.c            |  3 ++
 drivers/pci/pcie/portdrv_core.c   |  9 ++----
 drivers/pci/probe.c               |  6 ++--
 7 files changed, 50 insertions(+), 24 deletions(-)

-- 
2.25.1

