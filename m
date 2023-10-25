Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31BE7D75A6
	for <lists+linux-pci@lfdr.de>; Wed, 25 Oct 2023 22:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235026AbjJYU1E (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Oct 2023 16:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235019AbjJYU0b (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Oct 2023 16:26:31 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60942173B
        for <linux-pci@vger.kernel.org>; Wed, 25 Oct 2023 13:25:48 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-565e54cb93aso169231a12.3
        for <linux-pci@vger.kernel.org>; Wed, 25 Oct 2023 13:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1698265548; x=1698870348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8cuOe+AU3MQZSBvbMUo9B/kQ2SYr1hcMCXHjeEaDcfY=;
        b=cZDdqT/gtqqI0oRq7UCAkp68DsV0s5Wqf+YVZ1of5fXPaZ95fQ1mwqXd5CoOeff3Pn
         cWT82Cg/EhuvcFsKVQTjTH4THO35VgzBwMguia2vgolJ9+0ZyEwWwJ1cOkjg20y8VuZY
         sLOhrr7oUewiG4Rhb2YweEwgUxxUhYD1lb8Rymo1TEkjYyO0NmbW6HUsmHjuOP75O+Nh
         ZFPnpmAU1Z7lbL8uugrDLcXdMyQtMUhSFFvt6+WJAS91FdwgYZQbquE1TJ5hBPh1po5a
         +c4wrcjBMG7B/TuKcikOoUPZC8GpKJ3/8NHrgBSMFJjQpR9Vkl7OB/9FHz7/+XqTg6e7
         /iVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698265548; x=1698870348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8cuOe+AU3MQZSBvbMUo9B/kQ2SYr1hcMCXHjeEaDcfY=;
        b=ZhJMZChcN3bCzFTI/EdsKmzSGYLf4hIimgOXJjuh9Kcs8+HeP8ffcpGz+6ufEG7vyi
         KjsXAZPcwllXHcvfAbhadkMWcF00NMyfMrChMhTUGoWa5R5AuP3AttHvYyy0/Gm0536/
         lrqxWCTs93ck+oS53OSV4O+SfQ3WC9xPpOeOpW7VpF8aCO5Vor8Tkvdx39Hki3XsSz/K
         KTbICw/96Fa3yBXEvkJcX5QbmzWorlQK6CVt3J/aqxc7f6992AYSlcEMOXxUG+356vv9
         /veDNrWCJqDo9DkPC45Ne7Jf2e8iiefjbKT1sCf+aIfkXjgG1ibJIcj7SJYtwNwT4XPc
         myhQ==
X-Gm-Message-State: AOJu0YxMw2VD9CD39FRVkR5wR7rd7c+VDdCoI/0+UceDkL1JMofQw0TG
        OwOMZChi19aKidVZbz72HLxBqw==
X-Google-Smtp-Source: AGHT+IEhemy4634FjVGt90Fqrc/7Er8LwdUnaKYZ7F/EhXxC4jPWbW3jfNiUW2TVJUJPoCyPB2P5Hw==
X-Received: by 2002:a05:6a21:78a3:b0:17a:eddb:acc2 with SMTP id bf35-20020a056a2178a300b0017aeddbacc2mr8715766pzc.46.1698265547753;
        Wed, 25 Oct 2023 13:25:47 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.78])
        by smtp.gmail.com with ESMTPSA id y3-20020aa79423000000b006b84ed9371esm10079590pfo.177.2023.10.25.13.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 13:25:47 -0700 (PDT)
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
Subject: [RFC PATCH v2 17/21] ACPI: bus: Add RINTC IRQ model for RISC-V
Date:   Thu, 26 Oct 2023 01:53:40 +0530
Message-Id: <20231025202344.581132-18-sunilvl@ventanamicro.com>
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

Add the IRQ model for RISC-V INTC so that acpi_set_irq_model can use this
for RISC-V.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/bus.c   | 3 +++
 include/linux/acpi.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index a4aa53b7e2bb..9eace6c7042e 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1158,6 +1158,9 @@ static int __init acpi_bus_init_irq(void)
 	case ACPI_IRQ_MODEL_LPIC:
 		message = "LPIC";
 		break;
+	case ACPI_IRQ_MODEL_RINTC:
+		message = "RINTC";
+		break;
 	default:
 		pr_info("Unknown interrupt routing model\n");
 		return -ENODEV;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 4ad256a0039c..19c3dda9c2ed 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -95,6 +95,7 @@ enum acpi_irq_model_id {
 	ACPI_IRQ_MODEL_PLATFORM,
 	ACPI_IRQ_MODEL_GIC,
 	ACPI_IRQ_MODEL_LPIC,
+	ACPI_IRQ_MODEL_RINTC,
 	ACPI_IRQ_MODEL_COUNT
 };
 
-- 
2.39.2

