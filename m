Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043D36791A3
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jan 2023 08:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233404AbjAXHM1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Jan 2023 02:12:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233440AbjAXHM0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Jan 2023 02:12:26 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A323EC64
        for <linux-pci@vger.kernel.org>; Mon, 23 Jan 2023 23:12:25 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id o13so13959587pjg.2
        for <linux-pci@vger.kernel.org>; Mon, 23 Jan 2023 23:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1hyDFi6BwQQxvnWgZlqZn5l8SdU7JiBSKsGQ5Uy8Nc4=;
        b=EMi6+ex7LzvEf+4jAa4H1gDNLyufeXIPS3/cQkdUnOQT3uSqT+hHVa6hxSDUL8gPee
         Th/9VuQ5pV8OYO1p7QPrpnSsS2KusxlEKxmEovQ2hd8MUrtTgWOgPm8PN9WkwZ/Wao+a
         7rWQl7tuLVJRSVVTyyYPzHQF4AFsbAnoNEsnbk0SBx3mbMRbFfbIM5JV8sZINxhQJCtL
         kWZK94ri9PpSkD2x7ALbqXqp0e9gIKQ3YAiAyDijsMRMPRol57KKDBthJX30QQcgXXMA
         y3GSdGoWFZD1IwJJaZ40AlZ9GqHXMMG7Wwsdo5fxLCNaZLTozQZ4hliIzeoTzbBZBbsj
         uI5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1hyDFi6BwQQxvnWgZlqZn5l8SdU7JiBSKsGQ5Uy8Nc4=;
        b=XVuQxAEGHjua5IFc/z9Ka8i/1sNWLqeTRsAbVGnEkcQqOAw5iuLm+cq34I11XuCxdg
         znJsRSdMrdEa58lXfBQmw4cakK//KM/qIH3xRONyBld6vlI2UQDIXwYElnP0xERwKb5M
         G+vskjs0hP5IjGXjjoHSAoFd/3TJL9LAn7tS6GESlltlSsRzwKk94QkW22r1Fs5uUtBy
         zqwj6wzWwWrmQ2ace1/rf+WBdJf5S76acSk+qQ6ReNe3Mr8AQCnwG0s86EJzphkATjyD
         azvhd21tSWyabjZaMuRgG/25epsecBqTp41+9mvUjUY2I9R+jaua/c9UOEzTGF0iDMKX
         rwWA==
X-Gm-Message-State: AO0yUKV2XvbRAmlozDClcl4BeZi3ap0a5LpRQQfjx0FwFCQlfYdo5xiu
        e38vBqZyD8aZyOelV3esMphm
X-Google-Smtp-Source: AK7set9x6A6vcKwaiRqcIU7FBPRuI4jt1iSvgqZc+9WrxfuMW3z5EdGwT0KWyy9a/ZeZOC4g/hoAsw==
X-Received: by 2002:a17:90a:191a:b0:22b:e59c:d50d with SMTP id 26-20020a17090a191a00b0022be59cd50dmr2804915pjg.15.1674544345302;
        Mon, 23 Jan 2023 23:12:25 -0800 (PST)
Received: from localhost.localdomain ([117.193.209.165])
        by smtp.gmail.com with ESMTPSA id 7-20020a17090a174700b00219220edf0dsm736041pjm.48.2023.01.23.23.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 23:12:24 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     kishon@kernel.org, lpieralisi@kernel.org, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, robh@kernel.org, vidyas@nvidia.com, vigneshr@ti.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v5 1/5] PCI: dra7xx: Use threaded IRQ handler for "dra7xx-pcie-main" IRQ
Date:   Tue, 24 Jan 2023 12:41:54 +0530
Message-Id: <20230124071158.5503-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230124071158.5503-1-manivannan.sadhasivam@linaro.org>
References: <20230124071158.5503-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The "dra7xx-pcie-main" hard IRQ handler is just printing the IRQ status
and calling the dw_pcie_ep_linkup() API if LINK_UP status is set. But the
execution of dw_pcie_ep_linkup() depends on the EPF driver and may take
more time depending on the EPF implementation.

In general, hard IRQ handlers are supposed to return quickly and not block
for so long. Moreover, there is no real need of the current IRQ handler to
be a hard IRQ handler. So switch to the threaded IRQ handler for the
"dra7xx-pcie-main" IRQ.

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pci-dra7xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index 38462ed11d07..4ae807e7cf79 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -840,7 +840,7 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
 	}
 	dra7xx->mode = mode;
 
-	ret = devm_request_irq(dev, irq, dra7xx_pcie_irq_handler,
+	ret = devm_request_threaded_irq(dev, irq, NULL, dra7xx_pcie_irq_handler,
 			       IRQF_SHARED, "dra7xx-pcie-main", dra7xx);
 	if (ret) {
 		dev_err(dev, "failed to request irq\n");
-- 
2.25.1

