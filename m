Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA3F6B5CFB
	for <lists+linux-pci@lfdr.de>; Sat, 11 Mar 2023 15:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjCKOoI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 11 Mar 2023 09:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjCKOoI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 11 Mar 2023 09:44:08 -0500
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f236:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914643401B;
        Sat, 11 Mar 2023 06:44:03 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by mailout3.hostsharing.net (Postfix) with ESMTPS id 67170102F174D;
        Sat, 11 Mar 2023 15:44:01 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 082F560049B2;
        Sat, 11 Mar 2023 15:44:00 +0100 (CET)
X-Mailbox-Line: From 7a4e1f86958a79a70f29b96a92199522f08f8322 Mon Sep 17 00:00:00 2001
Message-Id: <cover.1678543498.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Sat, 11 Mar 2023 15:40:00 +0100
Subject: [PATCH v4 00/17] Collection of DOE material
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
Cc:     Gregory Price <gregory.price@memverge.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Li, Ming" <ming4.li@intel.com>, Hillf Danton <hdanton@sina.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Alexey Kardashevskiy <aik@amd.com>,
        Davidlohr Bueso <dave@stgolabs.net>, linuxarm@huawei.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Collection of DOE material, v4:

Migrate to synchronous API, create mailboxes in PCI core instead of
in drivers, relax restrictions on request/response size.

This should probably go in via the cxl tree because Dave Jiang is
basing his cxl work for the next merge window on it.

The first 6 patches are fixes, so could be applied immediately.

Thanks!


Changes v3 -> v4:

* [PATCH v4 01/17] cxl/pci: Fix CDAT retrieval on big endian
  * In pci_doe_discovery(), add request_pl_le / response_pl_le variables
    to avoid typecasts in pci_doe_task initializer (Jonathan)
  * In cxl_cdat_read_table(), use __le32 instead of u32 for "*data"
    variable (Jonathan)
  * Use sizeof(__le32) instead of sizeof(u32) (Jonathan)

* [PATCH v4 03/17] cxl/pci: Handle truncated CDAT entries
  * Check for sizeof(*entry) instead of sizeof(struct cdat_entry_header)
    for clarity (Jonathan)

* [PATCH v4 12/17] PCI/DOE: Create mailboxes on device enumeration
  * Amend commit message with additional justification for the commit
    (Alexey)

* [PATCH v4 16/17] cxl/pci: cxl/pci: Simplify CDAT retrieval error path
  * Newly added patch in v4 on popular request (Jonathan, Dave)

* [PATCH v4 17/17] cxl/pci: Rightsize CDAT response allocation
  * Amend commit message with spec reference to the Table Access
    Response Header (Ira)
  * In cxl_cdat_get_length(), check for sizeof(response) instead of
    2 * sizeof(u32) for clarity

Link to v3:

https://lore.kernel.org/linux-pci/cover.1676043318.git.lukas@wunner.de/


Dave Jiang (1):
  cxl/pci: Simplify CDAT retrieval error path

Lukas Wunner (16):
  cxl/pci: Fix CDAT retrieval on big endian
  cxl/pci: Handle truncated CDAT header
  cxl/pci: Handle truncated CDAT entries
  cxl/pci: Handle excessive CDAT length
  PCI/DOE: Silence WARN splat with CONFIG_DEBUG_OBJECTS=y
  PCI/DOE: Fix memory leak with CONFIG_DEBUG_OBJECTS=y
  PCI/DOE: Provide synchronous API and use it internally
  cxl/pci: Use synchronous API for DOE
  PCI/DOE: Make asynchronous API private
  PCI/DOE: Deduplicate mailbox flushing
  PCI/DOE: Allow mailbox creation without devres management
  PCI/DOE: Create mailboxes on device enumeration
  cxl/pci: Use CDAT DOE mailbox created by PCI core
  PCI/DOE: Make mailbox creation API private
  PCI/DOE: Relax restrictions on request and response size
  cxl/pci: Rightsize CDAT response allocation

 .clang-format           |   1 -
 drivers/cxl/core/pci.c  | 140 +++++++---------
 drivers/cxl/cxlmem.h    |   3 -
 drivers/cxl/cxlpci.h    |  14 ++
 drivers/cxl/pci.c       |  49 ------
 drivers/pci/doe.c       | 342 ++++++++++++++++++++++++++++++----------
 drivers/pci/pci.h       |  11 ++
 drivers/pci/probe.c     |   1 +
 drivers/pci/remove.c    |   1 +
 include/linux/pci-doe.h |  62 +-------
 include/linux/pci.h     |   3 +
 11 files changed, 350 insertions(+), 277 deletions(-)

-- 
2.39.1

