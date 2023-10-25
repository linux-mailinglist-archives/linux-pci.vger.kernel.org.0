Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE1A7D7588
	for <lists+linux-pci@lfdr.de>; Wed, 25 Oct 2023 22:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235016AbjJYUY5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Oct 2023 16:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234337AbjJYUYl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Oct 2023 16:24:41 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E30812A
        for <linux-pci@vger.kernel.org>; Wed, 25 Oct 2023 13:24:38 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6bd73395bceso116564b3a.0
        for <linux-pci@vger.kernel.org>; Wed, 25 Oct 2023 13:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1698265477; x=1698870277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J8S/JDCmwBJX/s4tcuif01AJjqTYAtUjVSzvHHCYv3Q=;
        b=nNqvGjA6QPmPkU0pIK+PisNTyVgj2VgA4U5e51WIi1UAtB68oOcDrAFNkopUNesM5k
         x5L/8RGmTh7GA0rwpMIDrGTAfFijRQogXgvaxhxfntL7XlcCcztZsFKcL45pLMhuRGcP
         HDaG3Z2kIzvvvvrPWQh+rvSak5AwjfkNG5+O6B6BLQxWc+MTHPvMxYWttNwgWppF25vJ
         glcd/sy1FvIwxr7bfe//85NgZBsIJ+qhTJAByTugflLc9l77og8LLV94aKgAb/i72lJx
         V4qVcEQj5eXnFn3BigSXcUMY7LN3Zr7E5hveMCoS84pk0QvbHq4XbsyfXz85Gezfp/m6
         Tuvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698265477; x=1698870277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J8S/JDCmwBJX/s4tcuif01AJjqTYAtUjVSzvHHCYv3Q=;
        b=ePgdCPqmZuX2nDU8SoBLSz20h/80zSMZnMBCrqTwZu8qnbL36zYqz187HNGneRV6Oc
         QUq7ijrd7CbRmhVXrVJZ45fjx4Jpcs7juuxz53Q8fatJNTegY69vsaSWN6XZ9uTlNniI
         bypZhBy1jXEpmdIixHUe4661VD0ynwMii/pbRdlLoIUf20xWX68U2VsfDlU6yn1n+7b/
         T1FDsallt47HVmpbUK/zjFQbxSvfWnHVcbqFnV28EeefXUtp+fknOdtqoRh53swOWLlB
         FzhXkx0tMEIoVwuLuVBreOKscrGhWsGQaXimmb9I1x0E5XEBnZU4Y56XDa9hePNile8h
         EpTQ==
X-Gm-Message-State: AOJu0YwfkbvwDxrrIoRyRO5Fq4tO/38oreJe85KVRcnf34fMr3RLbKFY
        fkLDm84K/k0nTLPYRWirLSf88g==
X-Google-Smtp-Source: AGHT+IGn0Ntg16V2ATutjBKN8vUehxORe09c59/GsjNsvnPR9Qebb6VfuMhALgVB74e2gHGUr8GJNA==
X-Received: by 2002:a05:6a00:1396:b0:68f:b015:ea99 with SMTP id t22-20020a056a00139600b0068fb015ea99mr913751pfg.10.1698265477463;
        Wed, 25 Oct 2023 13:24:37 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.78])
        by smtp.gmail.com with ESMTPSA id y3-20020aa79423000000b006b84ed9371esm10079590pfo.177.2023.10.25.13.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 13:24:37 -0700 (PDT)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Anup Patel <anup@brainfault.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Kumar Patra <atishp@rivosinc.com>,
        Haibo Xu <haibo1.xu@intel.com>,
        Sunil V L <sunilvl@ventanamicro.com>
Subject: [RFC PATCH v2 05/21] pnp.h: Return -EPROBE_DEFER for disabled IRQ resource in pnp_irq()
Date:   Thu, 26 Oct 2023 01:53:28 +0530
Message-Id: <20231025202344.581132-6-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231025202344.581132-1-sunilvl@ventanamicro.com>
References: <20231025202344.581132-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

To support deferred PNP driver probe, pnp_irq() must return -EPROBE_DEFER
so that the device driver can do deferred probe if the interrupt controller
is not probed early.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 include/linux/pnp.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/linux/pnp.h b/include/linux/pnp.h
index c2a7cfbca713..21cf833789fb 100644
--- a/include/linux/pnp.h
+++ b/include/linux/pnp.h
@@ -147,12 +147,18 @@ static inline resource_size_t pnp_mem_len(struct pnp_dev *dev,
 }
 
 
-static inline resource_size_t pnp_irq(struct pnp_dev *dev, unsigned int bar)
+static inline int pnp_irq(struct pnp_dev *dev, unsigned int bar)
 {
 	struct resource *res = pnp_get_resource(dev, IORESOURCE_IRQ, bar);
 
-	if (pnp_resource_valid(res))
+	if (pnp_resource_valid(res)) {
+#if IS_ENABLED(CONFIG_ARCH_ACPI_DEFERRED_GSI)
+		if (!pnp_resource_enabled(res))
+			return -EPROBE_DEFER;
+#endif
+
 		return res->start;
+	}
 	return -1;
 }
 
-- 
2.39.2

