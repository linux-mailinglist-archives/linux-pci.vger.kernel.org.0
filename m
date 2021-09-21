Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0C2413D46
	for <lists+linux-pci@lfdr.de>; Wed, 22 Sep 2021 00:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234138AbhIUWGf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Sep 2021 18:06:35 -0400
Received: from mga14.intel.com ([192.55.52.115]:40124 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235876AbhIUWGf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 21 Sep 2021 18:06:35 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10114"; a="223119115"
X-IronPort-AV: E=Sophos;i="5.85,311,1624345200"; 
   d="scan'208";a="223119115"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 15:05:04 -0700
X-IronPort-AV: E=Sophos;i="5.85,311,1624345200"; 
   d="scan'208";a="557114653"
Received: from ksankar-mobl2.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.132.1])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 15:05:03 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 0/7] cxl_pci refactor for reusability
Date:   Tue, 21 Sep 2021 15:04:52 -0700
Message-Id: <20210921220459.2437386-1-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Provide the ability to obtain CXL register blocks as discrete functionality.
This functionality will become useful for other CXL drivers that need access to
CXL register blocks. It is also in line with other additions to core which moves
register mapping functionality.

At the introduction of the CXL driver the only user of CXL MMIO was cxl_pci
(then known as cxl_mem). As the driver has evolved it is clear that cxl_pci will
not be the only entity that needs access to CXL MMIO. This series stops short of
moving the generalized functionality into cxl_core for the sake of getting eyes
on the important foundational bits sooner rather than later. The ultimate plan
is to move much of the code into cxl_core.

Via review of two previous patches [1] & [2] it has been suggested that the bits
which are being used for DVSEC enumeration move into PCI core. As CXL core is
soon going to require these, let's try to get the ball rolling now on making
that happen.

[1]: https://lore.kernel.org/linux-cxl/20210920225638.1729482-1-ben.widawsky@intel.com/
[2]: https://lore.kernel.org/linux-cxl/20210920225638.1729482-1-ben.widawsky@intel.com/

Ben Widawsky (7):
  cxl: Convert "RBI" to enum
  cxl/pci: Remove dev_dbg for unknown register blocks
  cxl/pci: Refactor cxl_pci_setup_regs
  cxl/pci: Make more use of cxl_register_map
  PCI: Add pci_find_dvsec_capability to find designated VSEC
  cxl/pci: Use pci core's DVSEC functionality
  ocxl: Use pci core's DVSEC functionality

 drivers/cxl/pci.c          | 144 ++++++++++++++++++-------------------
 drivers/cxl/pci.h          |  14 ++--
 drivers/misc/ocxl/config.c |  13 +---
 drivers/pci/pci.c          |  32 +++++++++
 include/linux/pci.h        |   1 +
 5 files changed, 113 insertions(+), 91 deletions(-)

-- 
2.33.0

