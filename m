Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46022726E46
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jun 2023 22:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235180AbjFGUtW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Jun 2023 16:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235107AbjFGUs4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Jun 2023 16:48:56 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9765A1FCC
        for <linux-pci@vger.kernel.org>; Wed,  7 Jun 2023 13:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=Nk2vTCJEsnlPnE56r3fJgIEOB6M
        ZuR6H9s9EOtmA/NA=; b=yRsWiNYWRM7ooz35PXbdckapHagJ+oZ9qr3iiT3mWPr
        zv0nMTE92AFKb5y9ILF/H+lGmxhzkA4+v+ScPb45/7n0JqjsfxKg12/3pPfOn3qw
        yNZD+cUpfDvSYcRD8UGMnMxLkJ/489LNfYPVMupqC6DL556syGfFu4hi8CUx1PSQ
        =
Received: (qmail 730854 invoked from network); 7 Jun 2023 22:47:53 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 7 Jun 2023 22:47:53 +0200
X-UD-Smtp-Session: l3s3148p1@/nzuP5D99qcujnt4
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] PCI: rcar: use proper naming for R-Car
Date:   Wed,  7 Jun 2023 22:47:50 +0200
Message-Id: <20230607204750.27837-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Neither RCar, nor Rcar, but R-Car.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Change since V1:
* fix typo in $subject (Thanks, Biju!)

 drivers/pci/controller/pcie-rcar-host.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
index e80e56b2a842..f4dac8ff97cb 100644
--- a/drivers/pci/controller/pcie-rcar-host.c
+++ b/drivers/pci/controller/pcie-rcar-host.c
@@ -684,7 +684,7 @@ static void rcar_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 }
 
 static struct irq_chip rcar_msi_bottom_chip = {
-	.name			= "Rcar MSI",
+	.name			= "R-Car MSI",
 	.irq_ack		= rcar_msi_irq_ack,
 	.irq_mask		= rcar_msi_irq_mask,
 	.irq_unmask		= rcar_msi_irq_unmask,
@@ -813,7 +813,7 @@ static int rcar_pcie_enable_msi(struct rcar_pcie_host *host)
 
 	/*
 	 * Setup MSI data target using RC base address address, which
-	 * is guaranteed to be in the low 32bit range on any RCar HW.
+	 * is guaranteed to be in the low 32bit range on any R-Car HW.
 	 */
 	rcar_pci_write_reg(pcie, lower_32_bits(res.start) | MSIFE, PCIEMSIALR);
 	rcar_pci_write_reg(pcie, upper_32_bits(res.start), PCIEMSIAUR);
-- 
2.35.1

