Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B350C7C41D0
	for <lists+linux-pci@lfdr.de>; Tue, 10 Oct 2023 22:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344004AbjJJUpM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Oct 2023 16:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344034AbjJJUpJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Oct 2023 16:45:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62485CA;
        Tue, 10 Oct 2023 13:45:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68796C433CB;
        Tue, 10 Oct 2023 20:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696970706;
        bh=OVB+pKuPDbde+zczlAAsnMMXpVXRTCdD+xIMqYLAWl8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XOdBLoBNWYWkZLs/1SLg1z2PdC1Yy6R7NbVsdHosYAzTgTDyhvltE78FBR7m3gKBh
         Qqh4g0vony4q5xLfvdSSzVmKd41HwAgOE3g+ydk+kon2DfdaJp8fob6CQACEp0JvHj
         kpnRMLDpwG0Omv+cLS/va3n3GOGRKdMRV0QvW/7eOI0/MWUho91H+2n7ktYcFvV6mZ
         lhuZkyH2sv7WztIevBMixnXqvIemp6BGuS++DgcRpnR9KoEuNcGEJeeE8s/BP5dyVi
         A+2moRZNzZreUI1zMaHdXHyP946R3GcLEYTRgeEjpZCami57eevd52LR5qORnOjp43
         5bChSgbd50xSw==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 09/10] PCI/VC: Use FIELD_GET()
Date:   Tue, 10 Oct 2023 15:44:35 -0500
Message-Id: <20231010204436.1000644-10-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010204436.1000644-1-helgaas@kernel.org>
References: <20231010204436.1000644-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Use FIELD_GET() to remove dependences on the field position, i.e., the
shift value.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/vc.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/vc.c b/drivers/pci/vc.c
index 5fc59ac31145..a4ff7f5f66dd 100644
--- a/drivers/pci/vc.c
+++ b/drivers/pci/vc.c
@@ -6,6 +6,7 @@
  *     Author: Alex Williamson <alex.williamson@redhat.com>
  */
 
+#include <linux/bitfield.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -201,9 +202,9 @@ static int pci_vc_do_save_buffer(struct pci_dev *dev, int pos,
 	/* Extended VC Count (not counting VC0) */
 	evcc = cap1 & PCI_VC_CAP1_EVCC;
 	/* Low Priority Extended VC Count (not counting VC0) */
-	lpevcc = (cap1 & PCI_VC_CAP1_LPEVCC) >> 4;
+	lpevcc = FIELD_GET(PCI_VC_CAP1_LPEVCC, cap1);
 	/* Port Arbitration Table Entry Size (bits) */
-	parb_size = 1 << ((cap1 & PCI_VC_CAP1_ARB_SIZE) >> 10);
+	parb_size = 1 << FIELD_GET(PCI_VC_CAP1_ARB_SIZE, cap1);
 
 	/*
 	 * Port VC Control Register contains VC Arbitration Select, which
@@ -231,7 +232,7 @@ static int pci_vc_do_save_buffer(struct pci_dev *dev, int pos,
 		int vcarb_offset;
 
 		pci_read_config_dword(dev, pos + PCI_VC_PORT_CAP2, &cap2);
-		vcarb_offset = ((cap2 & PCI_VC_CAP2_ARB_OFF) >> 24) * 16;
+		vcarb_offset = FIELD_GET(PCI_VC_CAP2_ARB_OFF, cap2) * 16;
 
 		if (vcarb_offset) {
 			int size, vcarb_phases = 0;
@@ -277,7 +278,7 @@ static int pci_vc_do_save_buffer(struct pci_dev *dev, int pos,
 
 		pci_read_config_dword(dev, pos + PCI_VC_RES_CAP +
 				      (i * PCI_CAP_VC_PER_VC_SIZEOF), &cap);
-		parb_offset = ((cap & PCI_VC_RES_CAP_ARB_OFF) >> 24) * 16;
+		parb_offset = FIELD_GET(PCI_VC_RES_CAP_ARB_OFF, cap) * 16;
 		if (parb_offset) {
 			int size, parb_phases = 0;
 
-- 
2.34.1

