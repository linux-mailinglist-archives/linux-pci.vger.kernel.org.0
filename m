Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE48D5319A9
	for <lists+linux-pci@lfdr.de>; Mon, 23 May 2022 22:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243043AbiEWSjQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 May 2022 14:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243420AbiEWSi7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 May 2022 14:38:59 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B0E175695
        for <linux-pci@vger.kernel.org>; Mon, 23 May 2022 11:18:51 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id t25so26998547lfg.7
        for <linux-pci@vger.kernel.org>; Mon, 23 May 2022 11:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Db68uHKl1+UUBIZ5yalfu7z/18tYxDiBSXR8pSKlIHc=;
        b=IFtJOdo6qh45Vv6VL8WNpxgCaAjOHurkfzmO7bRTI2BolPV6OjXikSBAwYgrIzhO48
         bziFK4bYLZGPgNCnKZPuuPB4wHITaJayqrKShwNPsqLL8go3uUN2swUhp6wR/VWnJXMD
         wj1HDSHr3Cy5wgFiWYZ/7E0dQcF9kumzlXCHn3wQPKrfKmEJkyMRpqok/q0W31y6xY4l
         Vrdoj9kYkFv92zMONCTqGOq8sUI0+mfdIySZ5BAPQvfMsKCzYJZecNN/xetuqouRW0Gf
         X6ZhjANeZY0IJFvSyitzbXfkG5Bl7S80BytlOW8crNkEsnUqrJd6BD5C+fhF+gipglSK
         pWVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Db68uHKl1+UUBIZ5yalfu7z/18tYxDiBSXR8pSKlIHc=;
        b=fXreVtG4uvoBUAY2doEHxiSk7DKdtxwibkGBYdnU1fVBiK/3CoPD4LJ29QqGFbLfwP
         bKVoSHDtHwNlkquwQqcKE8EEH1Kx3kjXk7S15Vzrsqut2RsOPZ2U/Gr4KKI/BkaGFnpG
         /otmh94Byiv3SzYBW/XWqbidkWhK6wOuOq4AT0l4YbiHD0RjC8SEilTTe+WtQ+URSg9F
         Kdd2kKf/V01JDar2k41kwXv/bjf5BNVtpzyurVr7+fVJIS0oZ1mABZib15AoqtU9buC+
         TjGr7jkiq8c0mckpx0FJws+lGgJx34yVO/WGXKlMtYmPlcKKZImH8eWFTGh1GTInMTdm
         52RA==
X-Gm-Message-State: AOAM532z8rvDpWGO3N6HEW6jyZKNW9clhT0nhMkKaMYJbRzHsRBzIv8L
        ehRcIZnkk0et7L6+Klz2cmSLqQ==
X-Google-Smtp-Source: ABdhPJxSrlHpZn4gDnhb4ltJQQlDuUuZgI4TVCCxbECdjFlVfTtoG/i+jEMAnpCOpbw7VgE/ODDekg==
X-Received: by 2002:ac2:5e32:0:b0:477:c733:9d91 with SMTP id o18-20020ac25e32000000b00477c7339d91mr15968093lfg.485.1653329920237;
        Mon, 23 May 2022 11:18:40 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id j20-20020a2e6e14000000b0024f3d1daedesm1904127ljc.102.2022.05.23.11.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 11:18:39 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v12 2/8] PCI: dwc: Correct msi_irq condition in dw_pcie_free_msi()
Date:   Mon, 23 May 2022 21:18:30 +0300
Message-Id: <20220523181836.2019180-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220523181836.2019180-1-dmitry.baryshkov@linaro.org>
References: <20220523181836.2019180-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The subdrivers pass -ESOMETHING if they do not want the core to touch
MSI IRQ. dw_pcie_host_init() also checks if (msi_irq > 0) rather than
just if (msi_irq). So let's make dw_pcie_free_msi() also check that
msi_irq is greater than zero.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 9979302532b7..af91fe69f542 100644
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

