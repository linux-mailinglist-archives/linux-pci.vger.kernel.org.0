Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3DAD39C02A
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jun 2021 21:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbhFDTHh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Jun 2021 15:07:37 -0400
Received: from mga06.intel.com ([134.134.136.31]:48564 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229823AbhFDTHg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Jun 2021 15:07:36 -0400
IronPort-SDR: 4ihZaKe9kVacOgEUPLpbhuDl9ODK095U7ctnHqjSRr4r+0jip9lve3cEZE0un9VTwrVcBg/PYm
 kP2ZvnYBSZ5A==
X-IronPort-AV: E=McAfee;i="6200,9189,10005"; a="265513933"
X-IronPort-AV: E=Sophos;i="5.83,248,1616482800"; 
   d="scan'208";a="265513933"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 12:05:46 -0700
IronPort-SDR: VIbn0inN8QFLJJwUIUTA/pJlhCe7egVGgBkIX2877wjGLDLgqVnxr51EfqY/9BPNrV78BXom6C
 7Aj9I+g0gIgg==
X-IronPort-AV: E=Sophos;i="5.83,248,1616482800"; 
   d="scan'208";a="401049105"
Received: from abathaly-mobl2.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.138.37])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 12:05:45 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-pci@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20Mare=C5=A1?= <mj@ucw.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>
Subject: [PATCH 0/9] Add CXL 2.0 DVSEC Decoding
Date:   Fri,  4 Jun 2021 12:05:32 -0700
Message-Id: <20210604190541.175602-1-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series improves decoding of CXL 2.0 DVSEC registers by adding more DVSEC
identifiers and adding fields for the existing decoded identifier. Not all DVSEC
fields from 2.0 spec are enabled here, only enough for what we needed in driver
bring-up. The restructuring of the code does make it easy to add support for the
remaining fields. I submitted a PR for this on github a few months ago [1]. The
spec is available for download [2].

Breakdown of patches:
1-5: Rework existing decoding to support more DVSEC IDs
6: Improve CXL Device Decoding (8.1.3 from CXL 2.0 spec)
7: Add port capabilities (8.1.5 from CXL 2.0 spec)
8: Add register locator (8.1.9 from CXL 2.0 spec)
9: Report undecoded DVSECs

Here is an example decoded output of a 5.12 based kernel running in QEMU
emulation [3]

36:00.0 Memory controller [0502]: Intel Corporation Device 0d93 (rev 01) (prog-if 10)
	Subsystem: Red Hat, Inc. Device 1100

	<...>

	Capabilities: [100 v1] Designated Vendor-Specific: Vendor=1e98 ID=0000 Rev=1 Len=56: CXL
		CXLCap:	Cache- IO+ Mem+ Mem HW Init+ HDMCount 1 Viral-
		CXLCtl:	Cache- IO+ Mem+ Cache SF Cov 0 Cache SF Gran 0 Cache Clean- Viral-
		CXLSta:	Viral-
		CXLSta2:	ResetComplete+ ResetError- PMComplete-
		Cache Size Not Reported
		Range1: 10000000-fffffff
			Valid+ Active+ Type=CDAT Class=CDAT interleave=0 timeout=1s
		Range2: 0-ffffffffffffffff
			Valid- Active- Type=Volatile Class=DRAM interleave=0 timeout=1s
	Capabilities: [138 v1] Designated Vendor-Specific: Vendor=1e98 ID=0008 Rev=0 Len=36: CXL
		Block2	BIR: bar0	ID: component registers
			RegisterOffset: 0000000000000000
		Block3	BIR: bar2	ID: CXL device registers
			RegisterOffset: 0000000000000000
	Kernel driver in use: cxl_pci

Ben Widawsky (9):
  cxl: Rename variable to match other code
  cxl: Make id check more explicit
  cxl: Collect all DVSEC Device fields
  cxl: Rework caps to new function
  cxl: Rename caps to be device caps
  cxl: Implement more device DVSEC decoding
  cxl: Add support for DVSEC port cap
  cxl: Add DVSEC Register Locator
  cxl: Add placeholder for undecoded DVSECs

 lib/header.h |  78 ++++++++++++++-----
 ls-ecaps.c   | 206 ++++++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 249 insertions(+), 35 deletions(-)

[1]: https://github.com/pciutils/pciutils/pull/59
[2]: https://www.computeexpresslink.org/download-the-specification
[3]: https://gitlab.com/bwidawsk/qemu

-- 
2.31.1


-- 
2.31.1

