Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939F976F15E
	for <lists+linux-pci@lfdr.de>; Thu,  3 Aug 2023 20:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235558AbjHCSEQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Aug 2023 14:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjHCSDe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Aug 2023 14:03:34 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A201E4236
        for <linux-pci@vger.kernel.org>; Thu,  3 Aug 2023 11:02:16 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-686bea20652so1130687b3a.1
        for <linux-pci@vger.kernel.org>; Thu, 03 Aug 2023 11:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1691085731; x=1691690531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6v/OYLYVQR57/X+MrAxBhstfGEPE9Vxe5lIE5dFdYi8=;
        b=AeOusJd65H1nN1T0NetBGmbqBfBlOSImAu7Uelx9yA3pASs2f7sefFvXswRe4EVo2O
         CvUG6NJ6T0Pauy/FEY1z5ifwQKaQ06fZ/QslUnSfxbFdlQQHr+pvPalyXWSwjuG3lGFe
         N1LN4E6rnrgXD+zSMCTdgWsdIH0dBVzy56DIMSqXW0LgorqgduoErF2Wbz+QyBps81Ai
         wV5S04bojOgDVv2obMHVmqCVcIR+bI4vWpp49wguFw5PN1QGxBVRCxnEyACKDFScpqmP
         f1VlfC3SCiQWQ3gVN3KnKCA9ctwnKV1CBt9CVqeVS5hcazcDOMedqZBolJmK3o+QT4M9
         R8QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691085731; x=1691690531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6v/OYLYVQR57/X+MrAxBhstfGEPE9Vxe5lIE5dFdYi8=;
        b=b+ltm6gx0s3KzaRK7TiMx+oCOsvjXNAj3T9x7Oa/1gPzlJs1X9LObKuIb2V9S//vSe
         AAx+Lupg2MXc8QCI94m8hS+QoHV39r7+ImXIB1ANFjsot7+hgU31QEtpvk3WLvSIFmwY
         6jphbF4XgDadbWqgCbAzgvdd9UJME0vcxb/yoQFkeER0snmz8vPYhjPdeN3So8yZgGP6
         jiDnBxLwOSmLe4JMLC0lSU6i3NwlPI20fgjWU9yjQ+MnbfVz6a7681n0GiTJ2StDALv5
         WKql5hKLCFQgNpj35oilJ6gik2kRr1FRiVLGmbPnxywDtQBipWRXp7nYKZ/0PJV4e05/
         pBFQ==
X-Gm-Message-State: ABy/qLYsE51OSExGrsCtVT+VKIRPaN9oJObOOz2TAjPA31i6EjAUih6J
        NPtG0OUv6BNPQRcm3GP6gu5EgA==
X-Google-Smtp-Source: APBJJlHFcm8ihxMfvEuKYdAJoJ0melHlBTDt1Jia2pL1VWUw/BkWIxLDR2Ghhray/SCxDTG4+7EhFQ==
X-Received: by 2002:a05:6a20:938b:b0:13e:f5b5:48ee with SMTP id x11-20020a056a20938b00b0013ef5b548eemr7542379pzh.59.1691085731121;
        Thu, 03 Aug 2023 11:02:11 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.190.143])
        by smtp.gmail.com with ESMTPSA id s8-20020aa78d48000000b0065a1b05193asm134952pfe.185.2023.08.03.11.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 11:02:10 -0700 (PDT)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anup Patel <anup@brainfault.org>,
        Marc Zyngier <maz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Robert Moore <robert.moore@intel.com>,
        Haibo Xu <haibo1.xu@intel.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Atish Kumar Patra <atishp@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>
Subject: [RFC PATCH v1 21/21] irqchip/sifive-plic: Add GSI conversion support
Date:   Thu,  3 Aug 2023 23:29:16 +0530
Message-Id: <20230803175916.3174453-22-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230803175916.3174453-1-sunilvl@ventanamicro.com>
References: <20230803175916.3174453-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

ACPI uses flat Global System Interrupt Vector space and
hence the GSI number needs to be converted to corresponding
local IRQ number of the interrupt controller. Add a new
gsi_base field in the priv structure to handle this which
will be 0 on DT based systems.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/irqchip/irq-sifive-plic.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 72d6e06ef52b..1c22070e9cdd 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -68,6 +68,7 @@ struct plic_priv {
 	unsigned long plic_quirks;
 	unsigned int nr_irqs;
 	unsigned long *prio_save;
+	u32 gsi_base;
 };
 
 struct plic_handler {
@@ -314,6 +315,10 @@ static int plic_irq_domain_translate(struct irq_domain *d,
 {
 	struct plic_priv *priv = d->host_data;
 
+	/* For DT, gsi_base is always zero. */
+	if (fwspec->param[0] >= priv->gsi_base)
+		fwspec->param[0] = fwspec->param[0] - priv->gsi_base;
+
 	if (test_bit(PLIC_QUIRK_EDGE_INTERRUPT, &priv->plic_quirks))
 		return irq_domain_translate_twocell(d, fwspec, hwirq, type);
 
@@ -453,6 +458,17 @@ static int plic_probe(struct platform_device *pdev)
 		return -EIO;
 	}
 
+	/*
+	 * Find out GSI base number
+	 *
+	 * Note: DT does not define "riscv,gsi-base" property so GSI
+	 * base is always zero for DT.
+	 */
+	rc = fwnode_property_read_u32_array(dev->fwnode, "riscv,gsi-base",
+					    &priv->gsi_base, 1);
+	if (rc)
+		priv->gsi_base = 0;
+
 	rc = fwnode_property_read_u32_array(dev->fwnode, "riscv,ndev",
 						&nr_irqs, 1);
 	if (rc) {
-- 
2.39.2

