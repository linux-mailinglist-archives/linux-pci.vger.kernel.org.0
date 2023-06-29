Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3912742BF2
	for <lists+linux-pci@lfdr.de>; Thu, 29 Jun 2023 20:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234381AbjF2Sew (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jun 2023 14:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234355AbjF2SeB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Jun 2023 14:34:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9462F468C
        for <linux-pci@vger.kernel.org>; Thu, 29 Jun 2023 11:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688063538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q6Zb91TnjuHlOEl7WpTQiF4JXnoBDKh12FzcAV06XV4=;
        b=gF93JVs+EYvScwreUCmGnkwaalIwxz1ZgqsEYglLW6AN5imgF5rLOAqvwjwD9Vu8hU2qzQ
        q3OVfXVnQ0EnWg5EA2FtedvpBnMWU49mpjaSolr3T0Q6qV98+Z5e6QBCbfZ1Uy03T2mtEw
        5EgDGoLT21ZIuSMLCYB5MD9uc/HLklA=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-wGk9XoaCM_WNdSZNKuTWUw-1; Thu, 29 Jun 2023 14:32:16 -0400
X-MC-Unique: wGk9XoaCM_WNdSZNKuTWUw-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-3f9ae2181beso11038731cf.1
        for <linux-pci@vger.kernel.org>; Thu, 29 Jun 2023 11:32:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688063536; x=1690655536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q6Zb91TnjuHlOEl7WpTQiF4JXnoBDKh12FzcAV06XV4=;
        b=S/5o1YrgHV1juOQ4taNgbVDxhlqhA4JAkEQNZ1k0r/U1yPsN8ni6KDIBF3PSV1XOSN
         lQNamP+pyhb9BHF7JQN1KmDq7kNlDZ6qSzyyQWh/77FNTV9KOgYB8SJQd7sA/lx/Hc/j
         AvN/H2Zjdsy1Fr2aaWWPO+UWul45uqKUkXBBneKk+wOnMbr98wsZLrrgsXTGhOISuprQ
         hMDQ22+GgqFHRCTfFMN+ncLpVwOeBfDY9+egcSzsbmlCnh67kDd2vxBvOpbvbqRz7WAg
         na8A5SrU8pV8ZFxgotH0vcXDhdkmR5pNyB91fM1KMSBtofgo2ILxApMldXYH5jZAfDox
         gn9A==
X-Gm-Message-State: ABy/qLautzwuG/T3tX7UUZx4ETev+yBQFMHqbgvb69S6CJ348rW8jZJ4
        bzkYqwzOA7rWfpxyOPC39bMbg7XkLwm5FJMQ2+Ru6kPjBNNkWdOAJ7WF6QydBW35AHv0OMp6+mu
        k48uPIxOxQIoG/f1XvT7Q
X-Received: by 2002:ac8:5ac8:0:b0:400:8180:bebd with SMTP id d8-20020ac85ac8000000b004008180bebdmr382441qtd.10.1688063535688;
        Thu, 29 Jun 2023 11:32:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4FOUIciTzKBAlUl5QS0fQ5VsfpaOsIyhjClGQupX50n7OkhbkOS7v/SAnpyEyoiqlM4oa0Og==
X-Received: by 2002:ac8:5ac8:0:b0:400:8180:bebd with SMTP id d8-20020ac85ac8000000b004008180bebdmr382425qtd.10.1688063535456;
        Thu, 29 Jun 2023 11:32:15 -0700 (PDT)
Received: from thinkpad-p1.kanata.rendec.net (cpe00fc8d79db03-cm00fc8d79db00.cpe.net.fido.ca. [72.137.118.218])
        by smtp.gmail.com with ESMTPSA id r15-20020ac85e8f000000b00403214e8862sm2458867qtx.33.2023.06.29.11.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 11:32:14 -0700 (PDT)
From:   Radu Rendec <rrendec@redhat.com>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] PCI: dwc: Use regular interrupt instead of chained
Date:   Thu, 29 Jun 2023 14:30:19 -0400
Message-ID: <20230629183019.1992819-2-rrendec@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230629183019.1992819-1-rrendec@redhat.com>
References: <20230629183019.1992819-1-rrendec@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The DesignWare PCIe host driver uses a chained interrupt to demultiplex
the downstream MSI interrupts. On Qualcomm SA8540P Ride, enabling both
pcie2a and pcie3a at the same time can create an interrupt storm where
the parent interrupt fires continuously, even though reading the PCIe
host registers doesn't identify any child MSI interrupt source. This
effectively locks up CPU0, which spends all the time servicing these
interrupts.

This is a clear example of how bypassing the interrupt core by using
chained interrupts can be very dangerous if the hardware misbehaves.

Convert the driver to use a regular interrupt for the demultiplex
handler. This allows the interrupt storm detector to detect the faulty
interrupt and disable it, allowing the system to run normally.

Signed-off-by: Radu Rendec <rrendec@redhat.com>
---
 .../pci/controller/dwc/pcie-designware-host.c | 35 +++++++++----------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 9952057c8819c..b603796d415d7 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -83,18 +83,9 @@ irqreturn_t dw_handle_msi_irq(struct dw_pcie_rp *pp)
 	return ret;
 }
 
-/* Chained MSI interrupt service routine */
-static void dw_chained_msi_isr(struct irq_desc *desc)
+static irqreturn_t dw_pcie_msi_isr(int irq, void *dev_id)
 {
-	struct irq_chip *chip = irq_desc_get_chip(desc);
-	struct dw_pcie_rp *pp;
-
-	chained_irq_enter(chip, desc);
-
-	pp = irq_desc_get_handler_data(desc);
-	dw_handle_msi_irq(pp);
-
-	chained_irq_exit(chip, desc);
+	return dw_handle_msi_irq(dev_id);
 }
 
 static void dw_pci_setup_msi_msg(struct irq_data *d, struct msi_msg *msg)
@@ -254,20 +245,21 @@ int dw_pcie_allocate_domains(struct dw_pcie_rp *pp)
 	return 0;
 }
 
-static void dw_pcie_free_msi(struct dw_pcie_rp *pp)
+static void __dw_pcie_free_msi(struct dw_pcie_rp *pp, u32 num_ctrls)
 {
 	u32 ctrl;
 
-	for (ctrl = 0; ctrl < MAX_MSI_CTRLS; ctrl++) {
+	for (ctrl = 0; ctrl < num_ctrls; ctrl++) {
 		if (pp->msi_irq[ctrl] > 0)
-			irq_set_chained_handler_and_data(pp->msi_irq[ctrl],
-							 NULL, NULL);
+			free_irq(pp->msi_irq[ctrl], pp);
 	}
 
 	irq_domain_remove(pp->msi_domain);
 	irq_domain_remove(pp->irq_domain);
 }
 
+#define dw_pcie_free_msi(pp) __dw_pcie_free_msi(pp, MAX_MSI_CTRLS)
+
 static void dw_pcie_msi_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -361,9 +353,16 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
 		return ret;
 
 	for (ctrl = 0; ctrl < num_ctrls; ctrl++) {
-		if (pp->msi_irq[ctrl] > 0)
-			irq_set_chained_handler_and_data(pp->msi_irq[ctrl],
-						    dw_chained_msi_isr, pp);
+		if (pp->msi_irq[ctrl] > 0) {
+			ret = request_irq(pp->msi_irq[ctrl], dw_pcie_msi_isr, 0,
+					  dev_name(dev), pp);
+			if (ret) {
+				dev_err(dev, "Failed to request irq %d: %d\n",
+					pp->msi_irq[ctrl], ret);
+				__dw_pcie_free_msi(pp, ctrl);
+				return ret;
+			}
+		}
 	}
 
 	/*
-- 
2.41.0

