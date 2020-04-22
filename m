Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B45A41B4BCB
	for <lists+linux-pci@lfdr.de>; Wed, 22 Apr 2020 19:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbgDVR36 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Apr 2020 13:29:58 -0400
Received: from mga12.intel.com ([192.55.52.136]:36971 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbgDVR36 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 22 Apr 2020 13:29:58 -0400
IronPort-SDR: HPWFAsKBWTXFPFmoPOG69kwBs5KSlCusEXTomly41NWABoEAid7IPiEsplOmfCx2kboBSX8cRj
 NCT3RdIC/e5A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2020 10:29:56 -0700
IronPort-SDR: EiEq+kTDM6tei4m+yriecOUR7/nl9gUyjwZa8YQ1eFsTnL1I1Aba9k3y0wferZufB6GAqnyARO
 kY7Gz/RrR2xQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,304,1583222400"; 
   d="scan'208";a="402622629"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.116.40])
  by orsmga004.jf.intel.com with ESMTP; 22 Apr 2020 10:29:56 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>, qemu-devel@nongnu.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <linux-pci@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Andrzej Jakowski <andrzej.jakowski@intel.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH 0/1] KVM support for VMD devices
Date:   Wed, 22 Apr 2020 13:14:44 -0400
Message-Id: <20200422171444.10992-1-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The two patches (Linux & QEMU) add support for passthrough VMD devices
in QEMU/KVM. VMD device 28C0 already supports passthrough natively by
providing the Host Physical Address in a shadow register to the guest
for correct bridge programming.

The QEMU patch emulates the 28C0 mode by creating a shadow register and
advertising its support by using QEMU's subsystem vendor/id.
The Linux patch matches the QEMU subsystem vendor/id to use the shadow
register.

Jon Derrick (1):
  pci: vmd: Use Shadow MEMBAR registers for QEMU/KVM guests

 drivers/pci/controller/vmd.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

-- 
2.18.1

