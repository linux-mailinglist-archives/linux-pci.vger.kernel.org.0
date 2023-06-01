Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2D371A12B
	for <lists+linux-pci@lfdr.de>; Thu,  1 Jun 2023 16:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234562AbjFAO5r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Jun 2023 10:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234577AbjFAO5p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Jun 2023 10:57:45 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55147192
        for <linux-pci@vger.kernel.org>; Thu,  1 Jun 2023 07:57:44 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b0478487c3so4245695ad.1
        for <linux-pci@vger.kernel.org>; Thu, 01 Jun 2023 07:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685631464; x=1688223464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sAFeVd+dwK+9T/TQ3aqc3usXxG9M6VjGUKGIkkMeOq4=;
        b=SR29uoxZkJU2rRXz2K/+GXbSV7ktM5kimwDl55SJ+3lg1DFHEBenaRcK8ISGBNXrYS
         kSkTZ9lX1kuPIdt2eaNQF4HtRPQoGv6WXmTwZnik0J/iKSRZ+EDR8y7UjmxB2oa92cn1
         IwBleum9w9HxPvzLziqNtZvOUZOy/NhJC4rxIr5MgV5L7nBmid96DgwfEUXQNpMH8w4f
         Rk5WIS9vuTD51g/Ub8N/VHzxbyc5U20MfMWoG5+TGTonRBKGB4oNaW6pHG7YIH8k4TIZ
         WeDDcSqPFrSy95Jlo0t7JOGfOxPKQarJXHXVhzG4H3AuBMngiTUnVDp1ZifygAFw5VbJ
         1QoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685631464; x=1688223464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sAFeVd+dwK+9T/TQ3aqc3usXxG9M6VjGUKGIkkMeOq4=;
        b=Zqsrr8eT3su7TpsAnv7rZDr+9vtcBjyNxRxSQUwCQYPWzJCdaWmGKygheToXFYx7p8
         yVo94bK0bQnEIzLox1x1VkEx2sUSYm8XG/AMCVvmEfkJ5NzhGCbXNx4Qpq10tuo1CNbS
         rL40U5/7eIEKquapM547WUSxUk8N0vis0LCsqoyzvo7fhNDxrDiKyYHDkogDrvR5D/5n
         Ii2e0gBS6K6SoDmPb5VjHBaXysPh4aZkcAG43OkTihjdWkcSQ1zHsTlJ7DiebLjcFMQp
         Q8eNORE9EE0IlnrFT7YaTopzkyIOoA7yERvKmuJdJss/i177QINeNUSJvwRbAQZcs5o8
         QoSw==
X-Gm-Message-State: AC+VfDzrQoxE29I6E1qmYG+ceBMguUvEE4WmRlnCAxmIOhWJW/AePnvO
        ByUaJJo0KTeu/aEkTAxYXtvQ
X-Google-Smtp-Source: ACHHUZ7GbtGEG5eWiwQl6RB58x2QO8agoFIL4a3NAm4gDi3kntaIcmbZPiekDSmdV8ernFHhTgO8sw==
X-Received: by 2002:a17:902:b901:b0:1ac:6d4c:c265 with SMTP id bf1-20020a170902b90100b001ac6d4cc265mr5912141plb.28.1685631463700;
        Thu, 01 Jun 2023 07:57:43 -0700 (PDT)
Received: from localhost.localdomain ([117.217.186.123])
        by smtp.gmail.com with ESMTPSA id o17-20020a170902d4d100b001b0603829a0sm3577826plg.199.2023.06.01.07.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 07:57:43 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com
Cc:     kishon@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v5 2/9] PCI: endpoint: Add missing documentation about the MSI/MSI-X range
Date:   Thu,  1 Jun 2023 20:27:11 +0530
Message-Id: <20230601145718.12204-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230601145718.12204-1-manivannan.sadhasivam@linaro.org>
References: <20230601145718.12204-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Both pci_epc_raise_irq() and pci_epc_map_msi_irq() APIs expects the
MSI/MSI-X vectors to start from 1 but it is not documented. Add the
range info to the kdoc of the APIs to make it clear.

Fixes: 5e8cb4033807 ("PCI: endpoint: Add EP core layer to enable EP controller and EP functions")
Fixes: 87d5972e476f ("PCI: endpoint: Add pci_epc_ops to map MSI IRQ")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/endpoint/pci-epc-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 46c9a5c3ca14..0cf602c83d4a 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -213,7 +213,7 @@ EXPORT_SYMBOL_GPL(pci_epc_start);
  * @func_no: the physical endpoint function number in the EPC device
  * @vfunc_no: the virtual endpoint function number in the physical function
  * @type: specify the type of interrupt; legacy, MSI or MSI-X
- * @interrupt_num: the MSI or MSI-X interrupt number
+ * @interrupt_num: the MSI or MSI-X interrupt number with range (1-N)
  *
  * Invoke to raise an legacy, MSI or MSI-X interrupt
  */
@@ -246,7 +246,7 @@ EXPORT_SYMBOL_GPL(pci_epc_raise_irq);
  * @func_no: the physical endpoint function number in the EPC device
  * @vfunc_no: the virtual endpoint function number in the physical function
  * @phys_addr: the physical address of the outbound region
- * @interrupt_num: the MSI interrupt number
+ * @interrupt_num: the MSI interrupt number with range (1-N)
  * @entry_size: Size of Outbound address region for each interrupt
  * @msi_data: the data that should be written in order to raise MSI interrupt
  *            with interrupt number as 'interrupt num'
-- 
2.25.1

