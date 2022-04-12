Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2B64FDD3E
	for <lists+linux-pci@lfdr.de>; Tue, 12 Apr 2022 13:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241179AbiDLLCJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Apr 2022 07:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237083AbiDLLAI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Apr 2022 07:00:08 -0400
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DAB365406;
        Tue, 12 Apr 2022 02:50:57 -0700 (PDT)
Received: from relay2-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::222])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 75E75CE289;
        Tue, 12 Apr 2022 09:41:06 +0000 (UTC)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 1001D40005;
        Tue, 12 Apr 2022 09:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649756458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xc7elETUhx4Ylc8cUvJvfmJyb8bpXLKnBKj1vDU7LOQ=;
        b=UAqUgyzAD5RDK5aUtx8RhEHu5pV/ZosSkZZ9QbAentA8pU2q0I6B1QxgWtu66bB37VuRmq
        /ApiySh5muMEsucwjUgknODrJ6ejhlX3POD2nBfRln2Cc7D+zlMHdzTHYtpI1NDRQSGE7y
        G2iF/wa5LEH4oWmJ6pZ6G7SegecdiJPRrDo1yoOq2pSKcc7yQJcpgJF2GkclPfhKzZxvUA
        arWxwRTsR1aL7dyvKjhHu8QmPrSZJHLGR4ljkNUd7B1gWvyf/CzCLinzp6V29prOWlWZtj
        L4Tkmr0QPeOMWp5ZyMMMAZDoE87iXmi8gHzsnsdTGqqopdkMjsxMeiexVu764A==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH 2/6] dt-bindings: PCI: pci-rcar-gen2: Add device tree support for r9a06g032
Date:   Tue, 12 Apr 2022 11:40:25 +0200
Message-Id: <20220412094029.287562-3-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220412094029.287562-1-herve.codina@bootlin.com>
References: <20220412094029.287562-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add internal PCI bridge support for the r9a06g032 SoC. The Renesas
RZ/N1D (R9A06G032) internal PCI bridge is compatible with the one
present in the R-Car Gen2 family.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt b/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
index aeba38f0a387..098ea12e6c95 100644
--- a/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
+++ b/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
@@ -15,7 +15,9 @@ Required properties:
 	      "renesas,pci-r8a7793" for the R8A7793 SoC;
 	      "renesas,pci-r8a7794" for the R8A7794 SoC;
 	      "renesas,pci-rcar-gen2" for a generic R-Car Gen2 or
-				      RZ/G1 compatible device.
+				      RZ/G1 compatible device;
+	      "renesas,pci-r9a06g032" for the R9A06G032 (RZ/N1D) SoC;
+	      "renesas,pci-rzn1" for a generic RZ/N1 compatible device.
 
 
 	      When compatible with the generic version, nodes must list the
-- 
2.35.1

