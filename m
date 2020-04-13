Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8ED91A68F4
	for <lists+linux-pci@lfdr.de>; Mon, 13 Apr 2020 17:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbgDMPfa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Apr 2020 11:35:30 -0400
Received: from mga03.intel.com ([134.134.136.65]:64936 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728797AbgDMPf3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Apr 2020 11:35:29 -0400
IronPort-SDR: dTrZjsQpXrykNTmiGUBJ8VrANQh3+cLsIPotspP+suJ9UOnjWxEmT7iXlfx+0jYr299GkVZzYK
 blM0FAVBOnsQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 08:35:28 -0700
IronPort-SDR: t4Ds690eZ5sSmkqHBvhLlU9LnreOza69l9+NngN9LZN4vLcTcpu/uroKh11BFHhadEEtuLNYG1
 CeQkgmA56YvA==
X-IronPort-AV: E=Sophos;i="5.72,378,1580803200"; 
   d="scan'208";a="256209880"
Received: from erickaal-mobl.amr.corp.intel.com (HELO arch-ashland-svkelley.intel.com) ([10.135.57.115])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 08:35:26 -0700
From:   Sean V Kelley <sean.v.kelley@linux.intel.com>
To:     mj@ucw.cz, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@linux.intel.com>
Subject: [PATCH v4 0/2] pciutils: Add basic decode support for CXL DVSEC
Date:   Mon, 13 Apr 2020 08:35:24 -0700
Message-Id: <20200413153526.805776-1-sean.v.kelley@linux.intel.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Changes since v3 [1]:

- Non-functional changes, subject and typo corrections

Changes since v2 [2]:

- Separate DVSEC capabilities from CXL and provide a means to identify.
(Bjorn Helgaas)

Changes since v1 [3]:

- Use consistent syntax to match other lspci capability output.
(Bjorn Helgaas)

[1] https://lore.kernel.org/linux-pci/20200410232440.668057-1-sean.v.kelley@linux.intel.com/
[2] https://lore.kernel.org/linux-pci/20200409213019.335678-1-sean.v.kelley@linux.intel.com/
[3] https://lore.kernel.org/linux-pci/20200409183204.328057-1-sean.v.kelley@linux.intel.com/

This patch series adds support for basic lspci decode of Compute eXpress Link[4],
a new CPU interconnect building upon PCIe.  As a foundation for the CXL
support it adds separate Designated Vendor-Specific Capability (DVSEC) defines
and a cap function so as to align with PCIe r5.0, sec 7.9.6.2 terms and
provide available details.  It makes use of the Vendor ID so as to identify
a Flex Bus capable port for purposes of CXL support.

[4] https://www.computeexpresslink.org/

Sean V Kelley (2):
  pciutils: Decode available DVSEC details
  pciutils: Decode Compute eXpress Link DVSEC

 lib/header.h        |  24 ++++
 ls-ecaps.c          |  73 +++++++++-
 tests/cap-dvsec     | 340 ++++++++++++++++++++++++++++++++++++++++++++
 tests/cap-dvsec-cxl | 340 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 776 insertions(+), 1 deletion(-)
 create mode 100644 tests/cap-dvsec
 create mode 100644 tests/cap-dvsec-cxl

--
2.26.0

