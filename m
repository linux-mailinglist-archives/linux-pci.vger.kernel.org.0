Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6357D7583
	for <lists+linux-pci@lfdr.de>; Wed, 25 Oct 2023 22:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234878AbjJYUZ0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Oct 2023 16:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjJYUZD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Oct 2023 16:25:03 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4439219A
        for <linux-pci@vger.kernel.org>; Wed, 25 Oct 2023 13:24:55 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6934202b8bdso143109b3a.1
        for <linux-pci@vger.kernel.org>; Wed, 25 Oct 2023 13:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1698265495; x=1698870295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jdOBYbLR+bXetJ+YmrkOyswglZ/H3DLDZKjYZYq4pUE=;
        b=HmX0WIx5ZKR8Cg3REtV8WvU+4A28I3jLrhYLezQY+rp0mQhBER7xMb/ToHKODSjlj7
         9aLYkV02gUF/2XnEVo1AwnEOt58O6rZquL0s3P53ziGLqlbYyPbjdycjDYoUW1stjWvr
         rKgGnj5V3bcFCfmCjdxyPLXDN0xB2fxplJUE3DqCkdHc3mzjVEKH0kXwgsDTy4hYAqP9
         P/WBTpzN7E0ZoKTHRR2UA05tUxCkaAIkx+j19OSo9SBppQIUcY9JUwadvgwhh3sG76gl
         R7B0oJcJMu5lOEj+1NQvmnD88vwGK+ehl5SxiF0Ecwg7iRYw96TElPdqUlCsZbN/v6ch
         4ANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698265495; x=1698870295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jdOBYbLR+bXetJ+YmrkOyswglZ/H3DLDZKjYZYq4pUE=;
        b=Hm85VcSfJxHdJBEmM9CKzvXjDHMAjiUBsj2T0MvpXX61pzYSaZ8kD3+c6smtU7GHXq
         Sn6L63DKjrKn272WH7uMcAkb094e1Wk773iEOs+0kqrWRGMmI1WR2SleaWi1iuKGuHWT
         NJ/oSpBcaUH9NKER67Ch/97u2AHGc4nK/Osp+9QDsLQreAkueeVfmJrnQNnD4riXzp4i
         oK/nwAiHt2E40Ysf7x2xVrgzn4BPRl6iBPkUkr/bCly0JsupkUCgyLC1B3k5CiPurRA5
         CrFp/0diQxSf8HGjysBuAHhAT3kgMKWWqbQyLCdjeCnVy+uZESy1Ss8RAM/LSILgAkqn
         x8wg==
X-Gm-Message-State: AOJu0YzThqy/RttyYmjWtEv2eB0jIpnz3JYHP7MfbBpqSB7MN+jBhisC
        pg/5Md9jwO/nh/YiW+iCP1J39A==
X-Google-Smtp-Source: AGHT+IGOtWmx7Z9hH5AFpr5sZFQnzIJZNuxwJNKWTB6+enKWMWr67WgjO7Vy6dwjrSM8D50mINvLmA==
X-Received: by 2002:aa7:888b:0:b0:6bd:9281:9446 with SMTP id z11-20020aa7888b000000b006bd92819446mr19185035pfe.10.1698265495348;
        Wed, 25 Oct 2023 13:24:55 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.78])
        by smtp.gmail.com with ESMTPSA id y3-20020aa79423000000b006b84ed9371esm10079590pfo.177.2023.10.25.13.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 13:24:54 -0700 (PDT)
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
Subject: [RFC PATCH v2 08/21] ACPI: pci_irq: Avoid warning for deferred probe in acpi_pci_irq_enable()
Date:   Thu, 26 Oct 2023 01:53:31 +0530
Message-Id: <20231025202344.581132-9-sunilvl@ventanamicro.com>
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

When the architecture like RISC-V supports deferred GSI interrupt
controller probe,  acpi_register_gsi() can return -EPROBE_DEFER which is
a valid use case to delay the dependent driver probe. So, avoid printing
the warning for the deferred probe case.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/pci_irq.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index ff30ceca2203..f7d0822da08f 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -452,8 +452,11 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
 
 	rc = acpi_register_gsi(&dev->dev, gsi, triggering, polarity);
 	if (rc < 0) {
-		dev_warn(&dev->dev, "PCI INT %c: failed to register GSI\n",
-			 pin_name(pin));
+		if (rc != -EPROBE_DEFER) {
+			dev_warn(&dev->dev, "PCI INT %c: failed to register GSI\n",
+				 pin_name(pin));
+		}
+
 		kfree(entry);
 		return rc;
 	}
-- 
2.39.2

