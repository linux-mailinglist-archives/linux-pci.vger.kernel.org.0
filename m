Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DEB369284B
	for <lists+linux-pci@lfdr.de>; Fri, 10 Feb 2023 21:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233367AbjBJU2i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Feb 2023 15:28:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233192AbjBJU2h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Feb 2023 15:28:37 -0500
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F52DA5C3;
        Fri, 10 Feb 2023 12:28:35 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by mailout2.hostsharing.net (Postfix) with ESMTPS id 5D6F410189E13;
        Fri, 10 Feb 2023 21:28:33 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 357C2600CA83;
        Fri, 10 Feb 2023 21:28:33 +0100 (CET)
X-Mailbox-Line: From 49c5299afc660ac33fee9a116ea37df0de938432 Mon Sep 17 00:00:00 2001
Message-Id: <cover.1676043318.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Fri, 10 Feb 2023 21:25:00 +0100
Subject: [PATCH v3 00/16] Collection of DOE material
To:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc:     Gregory Price <gregory.price@memverge.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Li, Ming" <ming4.li@intel.com>, Hillf Danton <hdanton@sina.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linuxarm@huawei.com,
        linux-cxl@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Collection of DOE material, v3:

Migrate to synchronous API, create mailboxes in PCI core instead of
in drivers, relax restrictions on request/response size.


One major change since v2 is the behavior on device removal:
Previously ongoing DOE exchanges were canceled before driver unbinding,
so that a driver doesn't wait for an ongoing DOE exchange to time out.
That's the right thing to do for surprise removal, but not for
orderly removal via sysfs or Attention Button, so canceling is
now confined to the former.

Another major change is a new patch at the end of the series
to rightsize CXL CDAT response allocation (per Jonathan's request).

A number of issues in CXL CDAT retrieval caught my eye.
Some of them look like potential vulnerabilities.
I'm adding 4 patches at the beginning of the series to fix them.

Ira kindly tested the series again and verified that the CDAT exposed
in sysfs remains identical.


Changes v2 -> v3:

* [PATCH v3 01/16] cxl/pci: Fix CDAT retrieval on big endian
  [PATCH v3 02/16] cxl/pci: Handle truncated CDAT header
  [PATCH v3 03/16] cxl/pci: Handle truncated CDAT entries
  [PATCH v3 04/16] cxl/pci: Handle excessive CDAT length
  * Newly added patch in v3

* [PATCH v3 05/16] PCI/DOE: Silence WARN splat with CONFIG_DEBUG_OBJECTS=y
  * Explain in commit message what the long-term fix implemented by
    a subsequent commit is (Jonathan)

* [PATCH v3 10/16] PCI/DOE: Deduplicate mailbox flushing
  * Newly added patch in v3

* [PATCH v3 11/16] PCI/DOE: Allow mailbox creation without devres management
  * Call pci_doe_flush_mb() from pci_doe_destroy_mb() to simplify
    error paths (Jonathan)
  * Explain in commit message why xa_destroy() is reordered in
    error path of the new pci_doe_create_mb() (Jonathan)

* [PATCH v3 12/16] PCI/DOE: Create mailboxes on device enumeration
  * Don't cancel ongoing DOE exchanges in pci_stop_dev() so that
    drivers may perform DOE in their ->remove() hooks
  * Instead cancel ongoing DOE exchanges on surprise removal in
    pci_dev_set_disconnected()
  * Emit error message in pci_doe_init() if mailbox creation fails (Ira)
  * Explain in commit message that pci_find_doe_mailbox() can later
    be amended with pci_find_next_doe_mailbox() (Jonathan)

* [PATCH v3 15/16] PCI/DOE: Relax restrictions on request and response size
  * Fix byte order of last dword on big endian arches (Ira)
  * Explain in commit message and kerneldoc that arbitrary-sized
    payloads are not stipulated by the spec, but merely for
    convenience of the caller (Bjorn, Jonathan)
  * Add code comment that "remainder" in pci_doe_recv_resp() signifies
    the number of data bytes in the last payload dword (Ira)

* [PATCH v3 16/16] cxl/pci: Rightsize CDAT response allocation
  * Newly added patch in v3 on popular request (Jonathan)


Link to v2:

https://lore.kernel.org/all/cover.1674468099.git.lukas@wunner.de/


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
 drivers/cxl/core/pci.c  | 125 ++++++---------
 drivers/cxl/cxl.h       |   3 +-
 drivers/cxl/cxlmem.h    |   3 -
 drivers/cxl/cxlpci.h    |  14 ++
 drivers/cxl/pci.c       |  49 ------
 drivers/cxl/port.c      |   2 +-
 drivers/pci/doe.c       | 340 ++++++++++++++++++++++++++++++----------
 drivers/pci/pci.h       |  12 ++
 drivers/pci/probe.c     |   1 +
 drivers/pci/remove.c    |   1 +
 include/linux/pci-doe.h |  62 +-------
 include/linux/pci.h     |   3 +
 13 files changed, 345 insertions(+), 271 deletions(-)

-- 
2.39.1

