Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D559B1A39D7
	for <lists+linux-pci@lfdr.de>; Thu,  9 Apr 2020 20:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgDIScH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Apr 2020 14:32:07 -0400
Received: from mga11.intel.com ([192.55.52.93]:23249 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726470AbgDIScH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Apr 2020 14:32:07 -0400
IronPort-SDR: fioVEh3Hhqvppe6/J44M8t70WLm4pBd3huA2vGAnPUB70nbftguplcm4QNObaVejWNzzWR1mWT
 F53cloMIwnPQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2020 11:32:07 -0700
IronPort-SDR: tHSY2lulP9g1EAsoewB5FurY1Tt798XWLiNHDSD/CWLRoQpHCbOyMUYaXuLQ3BCDKfFfb9AqDh
 QDiOnC4UdhFg==
X-IronPort-AV: E=Sophos;i="5.72,363,1580803200"; 
   d="scan'208";a="398663262"
Received: from rlbossma-mobl.amr.corp.intel.com (HELO arch-ashland-svkelley.intel.com) ([10.212.188.199])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2020 11:32:06 -0700
From:   Sean V Kelley <sean.v.kelley@linux.intel.com>
To:     mj@ucw.cz, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@linux.intel.com>
Subject: [Patch 0/1] pciutils: Add available DVSEC Details
Date:   Thu,  9 Apr 2020 11:32:03 -0700
Message-Id: <20200409183204.328057-1-sean.v.kelley@linux.intel.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add separate Designated Vendor Specific Capability (DVSEC) defines
and cap function so as to align with PCIe r5.0, sec 7.9.6.2 terms and
provide available details.  First step in later adding support for CXL.

Sean V Kelley (1):
  lspci: Add available DVSEC details

 lib/header.h    |   4 +
 ls-ecaps.c      |  25 +++-
 tests/cap-dvsec | 340 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 368 insertions(+), 1 deletion(-)
 create mode 100644 tests/cap-dvsec

--
2.26.0

