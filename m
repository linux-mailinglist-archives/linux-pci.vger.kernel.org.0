Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BECC5F9747
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2019 18:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfKLRfT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Nov 2019 12:35:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:59638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbfKLRfS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Nov 2019 12:35:18 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6590F21A49;
        Tue, 12 Nov 2019 17:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573580117;
        bh=pJWYwPDI1b+7VTqKGjBEhvWsVOjHjFseDOVjhaStdhc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NH3I85rs04Cj7LE2dCGkcVub5miRBedV4VEu+E+WzltzlWm2def9vstZwbHOlX7Uf
         elNI4E9oHPtqqlgyWoXzuQtQHcfS4s0TX6XvSpvXFbxhEg/6RMr17xvTlx3eep9GsQ
         Nwlp0Fw9inZ9IGaFaJwel8v4cOusWuk6JevnY0PA=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Frederick Lawler <fred@fredlawl.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ilia Mirkin <imirkin@alum.mit.edu>,
        linux-pci@vger.kernel.org,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 1/3] PCI: Add #defines for Enter Compliance, Transmit Margin
Date:   Tue, 12 Nov 2019 11:35:01 -0600
Message-Id: <20191112173503.176611-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
In-Reply-To: <20191112173503.176611-1-helgaas@kernel.org>
References: <20191112173503.176611-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Add definitions for the Enter Compliance and Transmit Margin fields of the
PCIe Link Control 2 register.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 include/uapi/linux/pci_regs.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 29d6e93fd15e..5869e5778a05 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -673,6 +673,8 @@
 #define  PCI_EXP_LNKCTL2_TLS_8_0GT	0x0003 /* Supported Speed 8GT/s */
 #define  PCI_EXP_LNKCTL2_TLS_16_0GT	0x0004 /* Supported Speed 16GT/s */
 #define  PCI_EXP_LNKCTL2_TLS_32_0GT	0x0005 /* Supported Speed 32GT/s */
+#define  PCI_EXP_LNKCTL2_ENTER_COMP	0x0010 /* Enter Compliance */
+#define  PCI_EXP_LNKCTL2_TX_MARGIN	0x0380 /* Transmit Margin */
 #define PCI_EXP_LNKSTA2		50	/* Link Status 2 */
 #define PCI_CAP_EXP_ENDPOINT_SIZEOF_V2	52	/* v2 endpoints with link end here */
 #define PCI_EXP_SLTCAP2		52	/* Slot Capabilities 2 */
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

