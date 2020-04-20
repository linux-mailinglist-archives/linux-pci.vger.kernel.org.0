Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60D0B1B193C
	for <lists+linux-pci@lfdr.de>; Tue, 21 Apr 2020 00:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgDTWOq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Apr 2020 18:14:46 -0400
Received: from mga17.intel.com ([192.55.52.151]:35641 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726056AbgDTWOq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 20 Apr 2020 18:14:46 -0400
IronPort-SDR: 9N8sXmssmmP3FVfE+yMXChfJElnGUK6ty3P7lOKmp32izw0mHFOAo0eWoEccl+zzXq+OgDfjeO
 LQ/Olp9MWxRg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2020 15:14:46 -0700
IronPort-SDR: q8VS/1Yuw0b1O/JnfDcMxaReAXkOt/JUavPbRTYskoS3Twv4hhhFTqbKTQEUSNoQXDM1/CLtR9
 keOwer98O/EQ==
X-IronPort-AV: E=Sophos;i="5.72,407,1580803200"; 
   d="scan'208";a="279398601"
Received: from clmau-mobl.amr.corp.intel.com (HELO arch-ashland-svkelley.intel.com) ([10.254.28.212])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2020 15:14:44 -0700
From:   Sean V Kelley <sean.v.kelley@linux.intel.com>
To:     mj@ucw.cz, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@linux.intel.com>
Subject: [PATCH v6 0/2] pciutils: Add basic decode support for CXL DVSEC
Date:   Mon, 20 Apr 2020 15:14:42 -0700
Message-Id: <20200420221444.2641935-1-sean.v.kelley@linux.intel.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Changes since v5 [1]:

- There can be multiple vendor specific DVSEC IDs associated with CXL.
(Bjorn Helgaas)

[1] https://lore.kernel.org/linux-pci/20200415004751.2103963-1-sean.v.kelley@linux.intel.com/

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

