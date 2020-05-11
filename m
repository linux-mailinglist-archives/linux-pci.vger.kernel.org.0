Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8D6D1CE09F
	for <lists+linux-pci@lfdr.de>; Mon, 11 May 2020 18:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729800AbgEKQhJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 May 2020 12:37:09 -0400
Received: from mga05.intel.com ([192.55.52.43]:60989 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729730AbgEKQhJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 May 2020 12:37:09 -0400
IronPort-SDR: SLGXswSZnl0/eszObj5ECZuBFdphO+mS3KzkzhdSYwYxv3SiwhS6NQu81TU9xFGjCiaG/r1Jz9
 +jgR+kEqOJCw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2020 09:37:08 -0700
IronPort-SDR: UNlc4pCuKZkqk8GyFoR/pP1va/9/HmNwImjI1+Gv12s2IMIcufWUaMM3fuma/hqqoZmd8k4L9x
 uoUemfUZVphw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,380,1583222400"; 
   d="scan'208";a="286334374"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.116.74])
  by fmsmga004.fm.intel.com with ESMTP; 11 May 2020 09:37:07 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     <linux-pci@vger.kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Rob Herring <robh@kernel.org>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH v2 0/4] Align PCI Emul Bridge to PCIe 5.0
Date:   Mon, 11 May 2020 12:21:13 -0400
Message-Id: <20200511162117.6674-1-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This set updates pci-bridge-emul for PCIe 4.0 and 5.0. It fixes a few
bit conflicts and comments, and updates a few missing 4.0 and 5.0
definitions. Additionally it eliminates the 'reserved' member by
assuming that ro, rw, and w1c bits are valid and non-conflicting, and
using the inversion of those fields.

v2 changes:
Removed GENMASK/BIT conversion. Existing named fields are left as-is.
Added Rob's acks for unchanged patches 1 & 2

v1: https://lore.kernel.org/linux-pci/20200414203005.5166-1-jonathan.derrick@intel.com/T/#t

Jon Derrick (4):
  PCI: pci-bridge-emul: Fix PCIe bit conflicts
  PCI: pci-bridge-emul: Fix Root Cap/Status comment
  PCI: pci-bridge-emul: Update for PCIe 5.0 r1.0
  PCI: pci-bridge-emul: Eliminate the 'reserved' member

 drivers/pci/pci-bridge-emul.c | 61 ++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 30 deletions(-)

-- 
2.18.1

