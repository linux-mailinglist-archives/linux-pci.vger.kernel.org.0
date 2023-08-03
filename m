Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B033776F155
	for <lists+linux-pci@lfdr.de>; Thu,  3 Aug 2023 20:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235344AbjHCSD5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Aug 2023 14:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235751AbjHCSDN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Aug 2023 14:03:13 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040384231
        for <linux-pci@vger.kernel.org>; Thu,  3 Aug 2023 11:02:05 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6873a30d02eso866550b3a.3
        for <linux-pci@vger.kernel.org>; Thu, 03 Aug 2023 11:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1691085716; x=1691690516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oa5JuUdn7+qjYPf/m5YirkX0l5WPw2pxjpAQ3vHoF5I=;
        b=KQbJbLeA4TGtIxIuFW6WC8NJApS9TUoRPunkwh/7C0r1L0sLBDwJGs8OUTxRfQN8yL
         IZgS1FD+/A7me33MFHYJD0l0yTtrtfiDYXF3e8iNfPm93ITz3TvFfxLpZrkvFjfajmGf
         EMdRXrFFA3X7X7YRRnEWo+UPpR2JQ9GgdKaKpv9xyaKOqY2AwIvxxCCF7PewHi3Faua6
         jFe8/UkDo4eFfqQ4KvSjqlO/i1RJALvToWFdrastu4Qw7KsNlgXKVspIMSkXJgK5IbJo
         eJSEBF9ZP7B5NkjyH0BsRNEDtOJgtdIONOGak2Or0tgEW0/gVlXNtRRwCRBHdYyNBhLJ
         6pIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691085716; x=1691690516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oa5JuUdn7+qjYPf/m5YirkX0l5WPw2pxjpAQ3vHoF5I=;
        b=RoLToI8qGFg3r4x/Crz9bOPBOhM1ro6r618ZDuL2gC4lZPhrXJGUtxsEzNSBJrVsfk
         leAJS4y0PyIC+xkAduvw8vXqMxxor7aNsmiZVzJepUELuxsatEsklqt6S9w3JqH1otnx
         bYGzEyv+k4z/TgcdW0GPDHkuWBoRjRyWrWD6m31833b2vuauwIjrjINzNhn/hzQFZAn9
         ASgGbGB6H+dq2uE5AjlUmuMtzToUcihEgYpnUWjUXDmWnqe8zmu32QoHueGl3QM8UpRa
         UCoMJiFx1flGdoyQp5njUEJqh0hgGzLcYhGqifbGdF9P9smJYF46x2pFkcEnZVn+JkT5
         6sKA==
X-Gm-Message-State: ABy/qLYPLx9z2h8BotX3DK14Ka3gyzEUzhRdfBWBAl8v8Nehy2n/mGe5
        n+CncVHrOxpbRkQM+ri/svrm7g==
X-Google-Smtp-Source: APBJJlEdZK4VF6uWpmNFHink+0Aa6EYjLEIulHdNF+NehNeb7SxIQC3cwBrCreK5H/j8S4RNIEykOQ==
X-Received: by 2002:a05:6a20:191:b0:12f:c61e:7cac with SMTP id 17-20020a056a20019100b0012fc61e7cacmr16449922pzy.31.1691085716659;
        Thu, 03 Aug 2023 11:01:56 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.190.143])
        by smtp.gmail.com with ESMTPSA id s8-20020aa78d48000000b0065a1b05193asm134952pfe.185.2023.08.03.11.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 11:01:56 -0700 (PDT)
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
Subject: [RFC PATCH v1 19/21] ACPI: bus: Add PLIC IRQ model
Date:   Thu,  3 Aug 2023 23:29:14 +0530
Message-Id: <20230803175916.3174453-20-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230803175916.3174453-1-sunilvl@ventanamicro.com>
References: <20230803175916.3174453-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add the IRQ model for RISC-V PLIC so that acpi_set_irq_model
can use this for RISC-V.

Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/bus.c   | 3 +++
 include/linux/acpi.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index dd9d80630bf6..68b8d38ec48a 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1135,6 +1135,9 @@ static int __init acpi_bus_init_irq(void)
 	case ACPI_IRQ_MODEL_APLIC:
 		message = "APLIC";
 		break;
+	case ACPI_IRQ_MODEL_PLIC:
+		message = "PLIC";
+		break;
 	default:
 		pr_info("Unknown interrupt routing model\n");
 		return -ENODEV;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 698d120a1bd2..31f080df179d 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -96,6 +96,7 @@ enum acpi_irq_model_id {
 	ACPI_IRQ_MODEL_GIC,
 	ACPI_IRQ_MODEL_LPIC,
 	ACPI_IRQ_MODEL_APLIC,
+	ACPI_IRQ_MODEL_PLIC,
 	ACPI_IRQ_MODEL_COUNT
 };
 
-- 
2.39.2

