Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4191A3BF1
	for <lists+linux-pci@lfdr.de>; Thu,  9 Apr 2020 23:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgDIVaX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Apr 2020 17:30:23 -0400
Received: from mga18.intel.com ([134.134.136.126]:36956 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726806AbgDIVaX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Apr 2020 17:30:23 -0400
IronPort-SDR: gwxzt4VSyavpOP3gTqZgcfFjR5Cqo7+HQhkRTZkX7tokxmrEVvsxWfIZPYQqe6tXBDgCgAWBhI
 TMK3nDeKMdDw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2020 14:30:22 -0700
IronPort-SDR: P9C46eNYxgsB9qtyaPSWhW16wAd5vYDo5RlgWkxiUIunLpXBM5SSybSh0xN09ONuSRcFh++umK
 AaTQ7VzgF8cA==
X-IronPort-AV: E=Sophos;i="5.72,364,1580803200"; 
   d="scan'208";a="452152714"
Received: from rlbossma-mobl.amr.corp.intel.com (HELO arch-ashland-svkelley.intel.com) ([10.212.188.199])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2020 14:30:21 -0700
From:   Sean V Kelley <sean.v.kelley@linux.intel.com>
To:     mj@ucw.cz, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@linux.intel.com>
Subject: [PATCH v2 0/1] pciutils: Add available DVSEC Details
Date:   Thu,  9 Apr 2020 14:30:18 -0700
Message-Id: <20200409213019.335678-1-sean.v.kelley@linux.intel.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Changes since v1 [1]:

- Use consistent syntax to match other lspci capability output.
(Bjorn Helgaas)

[1] https://lore.kernel.org/linux-pci/20200409183204.328057-1-sean.v.kelley@linux.intel.com/

Add separate Designated Vendor-Specific Capability (DVSEC) defines
and cap function so as to align with PCIe r5.0, sec 7.9.6.2 terms and
provide available details.  First step in later adding support for CXL.

--

Sean V Kelley (1):
  lspci: Add available DVSEC details

 lib/header.h    |   4 +
 ls-ecaps.c      |  25 +++-
 tests/cap-dvsec | 340 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 368 insertions(+), 1 deletion(-)
 create mode 100644 tests/cap-dvsec

--
2.26.0

