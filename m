Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D31BE3F5DDA
	for <lists+linux-pci@lfdr.de>; Tue, 24 Aug 2021 14:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237149AbhHXMVr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Aug 2021 08:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237036AbhHXMVr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Aug 2021 08:21:47 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B35EC061757;
        Tue, 24 Aug 2021 05:21:03 -0700 (PDT)
Received: from cap.home.8bytes.org (p4ff2b1ea.dip0.t-ipconnect.de [79.242.177.234])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by theia.8bytes.org (Postfix) with ESMTPSA id 49C16ED;
        Tue, 24 Aug 2021 14:20:59 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, joro@8bytes.org, jroedel@suse.de
Subject: [PATCH v3 0/4] PCI/ACPI: Simplify PCIe _OSC feature negotiation
Date:   Tue, 24 Aug 2021 14:20:50 +0200
Message-Id: <20210824122054.29481-1-joro@8bytes.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Hi,

here is the third version of my patches to simplify the _OSC
negotiation of PCIe features between Linux and the firmware.

This version is a complete rewrite, so there is no changelog to the
previous version. Patches 1-3 are cleanups and small restructurings of
the code as a preparation for patch 4.

The last patch gets rid of the dedicated _OSC query to check for _OSC
support and merges that functionality into acpi_pci_osc_control_set().

This allows to simplify and/or remove other functions and consilidate
error handling in negotiate_os_control().

I have tested the patches with and without 'pcie_ports=compat' and
found no regressions on my test machine.

Please review.

Thanks,

	Joerg



Joerg Roedel (4):
  PCI/ACPI: Remove OSC_PCI_SUPPORT_MASKS and OSC_PCI_CONTROL_MASKS
  PCI/ACPI: Move supported and control calculations to separaten
    functions
  PCI/ACPI: Move _OSC query checks to separate function
  PCI/ACPI: Check for _OSC support in acpi_pci_osc_control_set()

 drivers/acpi/pci_root.c | 161 +++++++++++++++++++++-------------------
 include/linux/acpi.h    |   2 -
 2 files changed, 84 insertions(+), 79 deletions(-)

-- 
2.32.0

