Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 858951CE1F8
	for <lists+linux-pci@lfdr.de>; Mon, 11 May 2020 19:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbgEKRqX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 May 2020 13:46:23 -0400
Received: from mga02.intel.com ([134.134.136.20]:4539 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726891AbgEKRqX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 May 2020 13:46:23 -0400
IronPort-SDR: FQUQfqMp007Tzg7Bz3EY/+gu5yMxcMyc4NWQK3nJ6ublt4iIumLQYSpLqGG8oVMOClKYj9J44r
 PvOxCl71dgyA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2020 10:46:21 -0700
IronPort-SDR: vEi0JV047fDjSh5Z1LuyitmkaEH/nvmALATMxJ4LrZKZMXuIpDfxTjzFbOj8Ve/MMzPT6fuAGI
 xLZ+p5B+shiA==
X-IronPort-AV: E=Sophos;i="5.73,380,1583222400"; 
   d="scan'208";a="279854841"
Received: from unknown (HELO arch-ashland-svkelley.intel.com) ([10.254.2.203])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2020 10:46:20 -0700
From:   Sean V Kelley <sean.v.kelley@linux.intel.com>
To:     mj@ucw.cz, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, f.fangjian@huawei.com,
        huangdaode@hisilicon.com,
        Sean V Kelley <sean.v.kelley@linux.intel.com>
Subject: [PATCH v7 0/2] pciutils: Add basic decode support for CXL DVSEC
Date:   Mon, 11 May 2020 10:46:16 -0700
Message-Id: <20200511174618.10589-1-sean.v.kelley@linux.intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Changes since v6 [1]:

- The CXL Vendor ID assigned by the PCI SIG is 1e98h and replaces the 8086h
value used in the CXL rev1.1 and prior specifications.
(Errata CXL 1.1 sec E27)

[1] https://lore.kernel.org/linux-pci/20200420221444.2641935-1-sean.v.kelley@linux.intel.com/

This patch series adds support for basic lspci decode of Compute eXpress Link,
a new CPU interconnect building upon PCIe. As a foundation for the CXL
support it adds separate Designated Vendor-Specific Capability (DVSEC) defines
and a cap function so as to align with PCIe r5.0, sec 7.9.6.2 terms and
provide available details. It makes use of the DVSEC Vendor ID and DVSEC ID so as
to identify a CXL capable device.

DocLink: https://www.computeexpresslink.org/

Sean V Kelley (2):
  pciutils: Decode available DVSEC details
  pciutils: Decode Compute eXpress Link DVSEC

 lib/header.h        |  25 ++++
 ls-ecaps.c          |  79 +++++++++-
 tests/cap-dvsec     | 340 ++++++++++++++++++++++++++++++++++++++++++++
 tests/cap-dvsec-cxl | 340 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 783 insertions(+), 1 deletion(-)
 create mode 100644 tests/cap-dvsec
 create mode 100644 tests/cap-dvsec-cxl

--
2.26.2

