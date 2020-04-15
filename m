Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B66021A8FDE
	for <lists+linux-pci@lfdr.de>; Wed, 15 Apr 2020 02:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392430AbgDOAsf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Apr 2020 20:48:35 -0400
Received: from mga12.intel.com ([192.55.52.136]:14892 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2634692AbgDOArx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Apr 2020 20:47:53 -0400
IronPort-SDR: zi8d5BJbsl6Ya1UNpGy+/1V+4InnMfMkL0Gg+ggfx+SDvf4svikJEQ/bAUjeJVNsR6u1pGteJF
 nX5WGSRyON8g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 17:47:52 -0700
IronPort-SDR: aIN07uQ7qeic/yA5uZq3fxS96Dx8+FNjVXKB8B2kSRMdWdFAlc/oRY0jTc1zOzF0UW3qqbHoPt
 82uXE8piFCKg==
X-IronPort-AV: E=Sophos;i="5.72,385,1580803200"; 
   d="scan'208";a="242156526"
Received: from ktscannx-mobl1.amr.corp.intel.com (HELO arch-ashland-svkelley.intel.com) ([10.135.63.23])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 17:47:51 -0700
From:   Sean V Kelley <sean.v.kelley@linux.intel.com>
To:     mj@ucw.cz, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@linux.intel.com>
Subject: [PATCH v5 0/2] pciutils: Add basic decode support for CXL DVSEC
Date:   Tue, 14 Apr 2020 17:47:49 -0700
Message-Id: <20200415004751.2103963-1-sean.v.kelley@linux.intel.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Changes since v4 [1]:

- Describe CXL in terms of both the DVSEC Vendor ID and DVSEC ID.
(Bjorn Helgaas)

- Check the DVSEC Vendor ID first. Both the DVSEC Vendor ID and DVSEC ID must
match for CXL identification.
(Bjorn Helgaas)

- Renamed is_flexbus_cap() to is_cxl_cap() to more accurately reflect use.

- Added descriptions to the CXL support/control/status register bitfields.

[1] https://lore.kernel.org/linux-pci/20200413153526.805776-1-sean.v.kelley@linux.intel.com/

This patch series adds support for basic lspci decode of Compute eXpress Link[2],
a new CPU interconnect building upon PCIe. As a foundation for the CXL
support it adds separate Designated Vendor-Specific Capability (DVSEC) defines
and a cap function so as to align with PCIe r5.0, sec 7.9.6.2 terms and
provide available details. It makes use of the DVSEC Vendor ID and DVSEC ID so as
to identify a CXL capable device.

[2] https://www.computeexpresslink.org/

Sean V Kelley (2):
  pciutils: Decode available DVSEC details
  pciutils: Decode Compute eXpress Link DVSEC

 lib/header.h        |  24 ++++
 ls-ecaps.c          |  79 +++++++++-
 tests/cap-dvsec     | 340 ++++++++++++++++++++++++++++++++++++++++++++
 tests/cap-dvsec-cxl | 340 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 782 insertions(+), 1 deletion(-)
 create mode 100644 tests/cap-dvsec
 create mode 100644 tests/cap-dvsec-cxl

--
2.26.0

