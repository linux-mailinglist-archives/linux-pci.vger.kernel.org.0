Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE9C674EDA
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jan 2023 09:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjATICt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Jan 2023 03:02:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjATICr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Jan 2023 03:02:47 -0500
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86A140D6;
        Fri, 20 Jan 2023 00:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1674201765;
  x=1705737765;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=ZasFDb7nYvB8EN2NFjes7tHLvuWokK8uCN1JO+3qhDQ=;
  b=iqNv+OApEn3+iQMc3EAR6qdFrEooUCc/4ozsGNUkstoARhSKiOww9kbV
   BZ7DTryP2zS/3artu1EwqIymoJgo1Ig+NhgrsCwvY9DuiJlSYVMD91ZyD
   q6sP8iABhF/C5f4g2f5t9U1HWRXrQxvc+hM/fZo8kikGcronWutXvaBPy
   KwA1aqTKFTrKngxXBUfiofT2JNeDkiDPdhyJsdoINqnElY898UBmaOkW7
   YQD3JTyXHfp1bE2rTRN4a38yrfaQpFIxWeBXArn+AhvAm3JZlzRE2Xnsh
   XHZ2KzjFkHk2VfRy27FDd91DCOTwCzxcaMt31F3WAOhc7AFBT0JpgjiL2
   Q==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
Date:   Fri, 20 Jan 2023 09:02:32 +0100
Subject: [PATCH] um: virt-pci: implement pcibios_get_phb_of_node()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230120-uml-pci-of-v1-1-134fb66643d8@axis.com>
X-B4-Tracking: v=1; b=H4sIAJhKymMC/x2NQQqEMAwAvyI5G2izetmvLB7ammpAa2lVFqR/t
 3qcgWEuyJyEM3ybCxKfkmULFXTbgJtNmBhlrAyk6KM0KTzWBaMT3Dx60mNvTWep66EG1mRGm0xw
 85Psa3xsTOzl/y5+Qyk35d7giHIAAAA=
To:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>
CC:     <linux-um@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <kernel@axis.com>
X-Mailer: b4 0.11.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Implement pcibios_get_phb_of_node() as x86 does in order to allow PCI
busses to be associated with devicetree nodes.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 arch/um/drivers/virt-pci.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/um/drivers/virt-pci.c b/arch/um/drivers/virt-pci.c
index 3ac220dafec4..6884e1be38e4 100644
--- a/arch/um/drivers/virt-pci.c
+++ b/arch/um/drivers/virt-pci.c
@@ -533,6 +533,25 @@ static void um_pci_irq_vq_cb(struct virtqueue *vq)
 	}
 }
 
+/* Copied from arch/x86/kernel/devicetree.c */
+struct device_node *pcibios_get_phb_of_node(struct pci_bus *bus)
+{
+	struct device_node *np;
+
+	for_each_node_by_type(np, "pci") {
+		const void *prop;
+		unsigned int bus_min;
+
+		prop = of_get_property(np, "bus-range", NULL);
+		if (!prop)
+			continue;
+		bus_min = be32_to_cpup(prop);
+		if (bus->number == bus_min)
+			return np;
+	}
+	return NULL;
+}
+
 static int um_pci_init_vqs(struct um_pci_device *dev)
 {
 	struct virtqueue *vqs[2];

---
base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
change-id: 20230120-uml-pci-of-f21d5ba4b245

Best regards,
-- 
Vincent Whitchurch <vincent.whitchurch@axis.com>
