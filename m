Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9014266AFE6
	for <lists+linux-pci@lfdr.de>; Sun, 15 Jan 2023 09:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjAOIWq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 15 Jan 2023 03:22:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjAOIWp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 15 Jan 2023 03:22:45 -0500
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [176.9.242.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDA1B45A
        for <linux-pci@vger.kernel.org>; Sun, 15 Jan 2023 00:22:41 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by mailout3.hostsharing.net (Postfix) with ESMTPS id 0D3A0101E6B2D;
        Sun, 15 Jan 2023 09:22:22 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 9A8D1603DB87;
        Sun, 15 Jan 2023 09:22:11 +0100 (CET)
X-Mailbox-Line: From 9f5ff00e1593d8d9a4b452398b98aa14d23fca11 Mon Sep 17 00:00:00 2001
Message-Id: <cover.1673769517.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Sun, 15 Jan 2023 09:20:30 +0100
Subject: [PATCH v2 0/3] PCI reset delay fixes
To:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc:     Keith Busch <kbusch@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ravi Kishore Koppuravuri <ravi.kishore.koppuravuri@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sheng Bi <windy.bi.enflame@gmail.com>,
        Stanislav Spassov <stanspas@amazon.de>,
        Yang Su <yang.su@linux.alibaba.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Delay fixes for recovery from Secondary Bus Resets and Downstream Port
Containment, v2:


Changes v1 -> v2:

* [PATCH 1/3] PCI/PM: Observe reset delay irrespective of bridge_d3
  * Add Reviewed-by tags (Mika, Sathyanarayanan)

* [PATCH 2/3] PCI: Unify delay handling for reset and resume
  * Introduce PCI_RESET_WAIT macro for 1 sec timeout prescribed by
    PCIe r6.0 sec 6.6.1 (Bjorn)
  * Note in kernel-doc of pci_bridge_wait_for_secondary_bus()
    that timeout parameter is in milliseconds (Bjorn)
  * Add Reviewed-by tags (Mika, Sathyanarayanan)

* [PATCH 3/3] PCI/DPC: Await readiness of secondary bus after reset
  * Move PCIE_RESET_READY_POLL_MS macro below the newly introduced
    PCI_RESET_WAIT from patch [2/3] and extend its code comment
  * Mention errors seen on Ponte Vecchio in commit message (Bjorn)
  * Avoid first person plural in commit message (Sathyanarayanan)
  * Add Reviewed-by tag (Mika)


Link to v1:

https://lore.kernel.org/linux-pci/cover.1672511016.git.lukas@wunner.de/


Lukas Wunner (3):
  PCI/PM: Observe reset delay irrespective of bridge_d3
  PCI: Unify delay handling for reset and resume
  PCI/DPC: Await readiness of secondary bus after reset

 drivers/pci/pci-driver.c |  2 +-
 drivers/pci/pci.c        | 59 +++++++++++++++++-----------------------
 drivers/pci/pci.h        | 16 ++++++++++-
 drivers/pci/pcie/dpc.c   |  4 +--
 4 files changed, 43 insertions(+), 38 deletions(-)

-- 
2.39.0

