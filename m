Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEE527A513
	for <lists+linux-pci@lfdr.de>; Mon, 28 Sep 2020 03:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgI1BLo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Sep 2020 21:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgI1BLo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 27 Sep 2020 21:11:44 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6626BC0613CE;
        Sun, 27 Sep 2020 18:11:44 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id t14so6841137pgl.10;
        Sun, 27 Sep 2020 18:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=brvnhRHveKpcyA289fKWkqddwqDpTeKxSpM0NIBNgNI=;
        b=Ip7HYjaFcNh8iBube4A0vFBHWqdpBW2GLeGxz8cmRVlZ7LLKoXUyrChLzenGuv+7d+
         Gelka4dnulxH5OtNGJy6f/qLZ6BYBcgBbwB724etiMUmajB6wDgl8PKKjCFg6folDwAp
         tFuHWKPTPoxusgpvz7G2ab9RYnAHZWH5bdV1t7EurDA3jHh9ThKkMUhq11KBdfkd/Rue
         HnN3C7U5MfKsi8+70iPdW9t5gflIveiAKQLwlJKZIOpn8IvWEAQregFmuylPGfsXnw17
         BANbDZajhoKUkpXe/O7JSFHx3uhRGvCdpJ6Ivg/mz5mrA54IztqCyhUlIIQlturrSrqP
         fjVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=brvnhRHveKpcyA289fKWkqddwqDpTeKxSpM0NIBNgNI=;
        b=Bz9RRkTvRBsP7lfD1BG/7B47lKxK6PgJiykaAbUN7l7nYXcBDlSIIGi5OH2O53B2V9
         dVYBAiA2CMPnKecSLRO7fLwCaAxdAqOZI3okz6JzqB1qxEC836AUUJj3WlH49gKlwAEd
         r9NVyZ+CU0roFoHHCQodAntreaRzl2GLJjs4hGsn6S50g2hvkQer8rK9Ja5siUAu/4g7
         C2emfWLKI9VwgkvU0tXNY83hUvPcOunPVSd+OLVIxZpgpDxPqKmndLgjn0j4EQ+kT5bv
         DZ959MjkcfmWmVdAW3QIrR3CVE0mcTpugW9DAfPMPq9M6c83V6OJEEv30S5eJ31GiXfu
         33VQ==
X-Gm-Message-State: AOAM532sLwiM3qtgj2WHPc6kmsAaRjEQyMYrqCH3jupmhO0oKV/NVd1h
        QPkX5JU57QXkoIEHAZ8bkJA=
X-Google-Smtp-Source: ABdhPJwXs2WQgMY/3KIGHrSBplUPoLhS47mHpcCvyOvOnfvhOYpy3gs2bT9z4JNoF0LKZT0PFljIEA==
X-Received: by 2002:a63:c00d:: with SMTP id h13mr7294429pgg.358.1601255503840;
        Sun, 27 Sep 2020 18:11:43 -0700 (PDT)
Received: from skuppusw-mobl5.amr.corp.intel.com (jfdmzpr04-ext.jf.intel.com. [134.134.137.73])
        by smtp.gmail.com with ESMTPSA id 137sm9368048pfb.183.2020.09.27.18.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 18:11:43 -0700 (PDT)
From:   Kuppuswamy Sathyanarayanan <sathyanarayanan.nkuppuswamy@gmail.com>
X-Google-Original-From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v9 0/5] Simplify PCIe native ownership detection logic
Date:   Sun, 27 Sep 2020 18:11:31 -0700
Message-Id: <cover.1600457297.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently, PCIe capabilities ownership status is detected by
verifying the status of pcie_ports_native, pcie_ports_dpc_native
and _OSC negotiated results (cached in  struct pci_host_bridge
->native_* members). But this logic can be simplified, and we can
use only struct pci_host_bridge ->native_* members to detect it. 

This patchset removes the distributed checks for pcie_ports_native,
pcie_ports_dpc_native parameters.

Changes since v8:
 * Simplified setting _OSC ownwership logic
 * Moved bridge->native_ltr out of #ifdef CONFIG_PCIEPORTBUS.

Changes since v7:
 * Fixed "fix array_size.cocci warnings".

Changes since v6:
 * Created new patch for CONFIG_PCIEPORTBUS check in
   pci_init_host_bridge().
 * Added warning message for a case when pcie_ports_native
   overrides _OSC negotiation result.

Changes since v5:
 * Rebased on top of v5.8-rc1

Changes since v4:
 * Changed the patch set title (Original link: https://lkml.org/lkml/2020/5/26/1710)
 * Added AER/DPC dependency logic cleanup fixes.
 

Kuppuswamy Sathyanarayanan (5):
  PCI: Conditionally initialize host bridge native_* members
  ACPI/PCI: Ignore _OSC negotiation result if pcie_ports_native is set.
  ACPI/PCI: Ignore _OSC DPC negotiation result if pcie_ports_dpc_native
    is set.
  PCI/portdrv: Remove redundant pci_aer_available() check in DPC enable
    logic
  PCI/DPC: Move AER/DPC dependency checks out of DPC driver

 drivers/acpi/pci_root.c           | 37 ++++++++++++++++++++++---------
 drivers/pci/hotplug/pciehp_core.c |  2 +-
 drivers/pci/pci-acpi.c            |  3 ---
 drivers/pci/pcie/aer.c            |  2 +-
 drivers/pci/pcie/dpc.c            |  3 ---
 drivers/pci/pcie/portdrv.h        |  2 --
 drivers/pci/pcie/portdrv_core.c   | 13 +++++------
 drivers/pci/probe.c               |  6 +++--
 include/linux/acpi.h              |  2 ++
 include/linux/pci.h               |  2 ++
 10 files changed, 42 insertions(+), 30 deletions(-)

-- 
2.17.1

