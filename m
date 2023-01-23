Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B35B6778FE
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jan 2023 11:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbjAWKUO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Jan 2023 05:20:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbjAWKUN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Jan 2023 05:20:13 -0500
X-Greylist: delayed 355 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 23 Jan 2023 02:20:10 PST
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583DA113E2;
        Mon, 23 Jan 2023 02:20:10 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by mailout2.hostsharing.net (Postfix) with ESMTPS id 1BF4410189E10;
        Mon, 23 Jan 2023 11:14:13 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id EB416600D2E1;
        Mon, 23 Jan 2023 11:14:12 +0100 (CET)
X-Mailbox-Line: From 4dba01ff87d630abdd5a09d52e954d3c212d2018 Mon Sep 17 00:00:00 2001
Message-Id: <cover.1674468099.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Mon, 23 Jan 2023 11:10:00 +0100
Subject: [PATCH v2 00/10] Collection of DOE material
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

Collection of DOE material, v2:

* Fix WARN splat reported by Gregory Price
* Migrate to synchronous API
* Create DOE mailboxes in PCI core instead of in drivers
* No longer require request and response size to be multiple of 4 bytes

This is in preparation for CMA device authentication (PCIe r6.0, sec 6.31),
which performs DOE exchanges of irregular size and is going to be handled
in the PCI core.  The synchronous API reduces code size for DOE users.

Link to CMA development branch:
https://github.com/l1k/linux/commits/doe


Changes v1 -> v2:
* [PATCH v2 01/10] PCI/DOE: Silence WARN splat with CONFIG_DEBUG_OBJECTS=y 
  * Add note in kernel-doc of pci_doe_submit_task() that pci_doe_task must
    be allocated on the stack (Jonathan)
* [PATCH v2 05/10] PCI/DOE: Make asynchronous API private
  * Deduplicate note in kernel-doc of struct pci_doe_task that caller need
    not initialize certain fields (Jonathan)

Link to v1:
https://lore.kernel.org/linux-pci/cover.1669608950.git.lukas@wunner.de/


Lukas Wunner (10):
  PCI/DOE: Silence WARN splat with CONFIG_DEBUG_OBJECTS=y
  PCI/DOE: Fix memory leak with CONFIG_DEBUG_OBJECTS=y
  PCI/DOE: Provide synchronous API and use it internally
  cxl/pci: Use synchronous API for DOE
  PCI/DOE: Make asynchronous API private
  PCI/DOE: Allow mailbox creation without devres management
  PCI/DOE: Create mailboxes on device enumeration
  cxl/pci: Use CDAT DOE mailbox created by PCI core
  PCI/DOE: Make mailbox creation API private
  PCI/DOE: Relax restrictions on request and response size

 .clang-format           |   1 -
 drivers/cxl/core/pci.c  |  89 ++++--------
 drivers/cxl/cxlmem.h    |   3 -
 drivers/cxl/pci.c       |  49 -------
 drivers/pci/doe.c       | 315 ++++++++++++++++++++++++++++++----------
 drivers/pci/pci.h       |  10 ++
 drivers/pci/probe.c     |   1 +
 drivers/pci/remove.c    |   2 +
 include/linux/pci-doe.h |  62 +-------
 include/linux/pci.h     |   3 +
 10 files changed, 283 insertions(+), 252 deletions(-)

-- 
2.39.1

