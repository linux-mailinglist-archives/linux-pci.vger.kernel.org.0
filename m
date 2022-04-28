Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD41513343
	for <lists+linux-pci@lfdr.de>; Thu, 28 Apr 2022 14:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343553AbiD1MC5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Apr 2022 08:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345840AbiD1MC4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Apr 2022 08:02:56 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D04A0BD9
        for <linux-pci@vger.kernel.org>; Thu, 28 Apr 2022 04:59:39 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 4so6337336ljw.11
        for <linux-pci@vger.kernel.org>; Thu, 28 Apr 2022 04:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WbPm7wPFz42k3w9HjVTRf/Wo4cb2U+ygFCZJLREQuWI=;
        b=tKVXRxi0FQAex+EUDlNEK+vvE4VoAGaCMuLCUJgV8fy/FzGGt/f0JwA5uLMWk1Zymi
         /gI7vodQ+M5MAZtKGGDrVG5Q3Ic7rK1S7Sv16JFwkbxEkNuJ0YewboXbhIBEljYsLyJ/
         H7xbVcjZ4eW1PkpKTtQIYubtsvxpB/6oZYM2Sna75yJjtHN2p7wCK9BNG33I28lo4yuS
         nQ+9+IU6nJsjbD7wsgR/WLZna5YNAVs9lvoAXuJ0atnZMBukhkGJ0K0sZCQ9annP9aJH
         jiZ/DCRlx7ZPitQJry9Pb7P3NofElHX963KjsBAeVsfLF9dJDWSx6mfICQXmqw9Fa4XY
         5RKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WbPm7wPFz42k3w9HjVTRf/Wo4cb2U+ygFCZJLREQuWI=;
        b=aJKs7iXPS6XdR8blCrD9rNyta/J/nb9NgcuP70RiWwpzbJ20P2iJY6VhRFYwntLvpz
         nFaqlVp5IyUX2AtM7pmPxeTkrB3FuADbMHxTu4VDJUjImNGRxD44jOMdfuPIzuYJZ53q
         Q9fGZlImiI/QtVtOO9sCYQ6L0SDglhzHRHKMhjiTELah6nZHckzWKuBPmIiI8Y94ntA1
         +OIxi8mXwmA6BurOsdjLK0bVwBCFih8kKcqiEoggdnFHXLjhSaqeofkEL87DnfNzpHJA
         HimSk98s+s5mGJNugHwk3+MUq1gHtLO9vSHClpO54Js40zID/oGWeljCxRiwRxhibqmd
         zeQg==
X-Gm-Message-State: AOAM530nA8iRwTDxBkmXToIUYNy2lRWd/K/Qr82lov8Zo0ZedU4RpyyY
        KXFDQwji3544Q5CUOhvudwu4sg==
X-Google-Smtp-Source: ABdhPJy6vp6i1rdb9UHuBwFsFqAoe9yJXTNmOmw6V3lAjGNT1Kq2jGP9Fq69adoxOw0YFMmHaLlw8A==
X-Received: by 2002:a2e:96d3:0:b0:24f:11ea:2118 with SMTP id d19-20020a2e96d3000000b0024f11ea2118mr13269423ljj.316.1651147177343;
        Thu, 28 Apr 2022 04:59:37 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id f1-20020a2e1f01000000b0024602522b5dsm2069137ljf.120.2022.04.28.04.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 04:59:36 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v4 2/7] PCI: dwc: Correct msi_irq condition in dw_pcie_free_msi()
Date:   Thu, 28 Apr 2022 14:59:29 +0300
Message-Id: <20220428115934.3414641-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220428115934.3414641-1-dmitry.baryshkov@linaro.org>
References: <20220428115934.3414641-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The subdrivers pass -ESOMETHING if they do not want the core to touch
MSI IRQ. dw_pcie_host_init() also checks if (msi_irq > 0) rather than
just if (msi_irq). So let's make dw_pcie_free_msi() also check that
msi_irq is greater than zero.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 2fa86f32d964..43d1d6116007 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -257,7 +257,7 @@ int dw_pcie_allocate_domains(struct pcie_port *pp)
 
 static void dw_pcie_free_msi(struct pcie_port *pp)
 {
-	if (pp->msi_irq)
+	if (pp->msi_irq > 0)
 		irq_set_chained_handler_and_data(pp->msi_irq, NULL, NULL);
 
 	irq_domain_remove(pp->msi_domain);
-- 
2.35.1

