Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7901A4C9C
	for <lists+linux-pci@lfdr.de>; Sat, 11 Apr 2020 01:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgDJXYo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Apr 2020 19:24:44 -0400
Received: from mga01.intel.com ([192.55.52.88]:57875 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726626AbgDJXYm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 10 Apr 2020 19:24:42 -0400
IronPort-SDR: 1aUeHFaNMDHE9tZNvl/5A89Yb95Sjk4h2Dh4yZu9gY0ebJcnnYx6RF2QqU2dtHQVoriKdkKNPP
 Kw0ptUjUmlPA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2020 16:24:41 -0700
IronPort-SDR: fb5CRftmrjIxRe//+vHr1EnASnWPkRZhCOl3hcqtdF0kyTOziWLLFL+BZTlvP1bB2G/TCF4YJq
 o8eDVxw9Kurg==
X-IronPort-AV: E=Sophos;i="5.72,368,1580803200"; 
   d="scan'208";a="426058854"
Received: from unknown (HELO arch-ashland-svkelley.intel.com) ([10.213.160.89])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2020 16:24:40 -0700
From:   Sean V Kelley <sean.v.kelley@linux.intel.com>
To:     mj@ucw.cz, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@linux.intel.com>
Subject: [PATCH v3 0/2] pciutils: Add basic decode support for CXL
Date:   Fri, 10 Apr 2020 16:24:38 -0700
Message-Id: <20200410232440.668057-1-sean.v.kelley@linux.intel.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Changes since v2 [1]:

- Separate DVSEC capabilities from CXL and provide a means to identify.
(Bjorn Helgaas)

Changes since v1 [2]:

- Use consistent syntax to match other lspci capability output.
(Bjorn Helgaas)

[1] https://lore.kernel.org/linux-pci/20200409213019.335678-1-sean.v.kelley@linux.intel.com/
[2] https://lore.kernel.org/linux-pci/20200409183204.328057-1-sean.v.kelley@linux.intel.com/

This patch series adds support for basic lspci decode of Compute eXpress Link[3],
a new CPU interconnect building upon PCIe.  As a foundation for the CXL
support it adds separate Designated Vendor-Specific Capability (DVSEC) defines
and a cap function so as to align with PCIe r5.0, sec 7.9.6.2 terms and
provide available details.  It makes use of the Vendor ID so as to identify
a Flex Bus capable port for purposes of CXL support.

[3] https://www.computeexpresslink.org/

Sean V Kelley (2):
  lspci: Add available DVSEC details
  lspci: Add basic decode support for Compute eXpress Link

 lib/header.h        |  24 ++++
 ls-ecaps.c          |  73 +++++++++-
 tests/cap-dvsec     | 340 ++++++++++++++++++++++++++++++++++++++++++++
 tests/cap-dvsec-cxl | 340 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 776 insertions(+), 1 deletion(-)
 create mode 100644 tests/cap-dvsec
 create mode 100644 tests/cap-dvsec-cxl

--
2.26.0

