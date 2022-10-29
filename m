Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53422612271
	for <lists+linux-pci@lfdr.de>; Sat, 29 Oct 2022 13:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiJ2Lfo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 29 Oct 2022 07:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiJ2Lfm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 29 Oct 2022 07:35:42 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B845A2C5
        for <linux-pci@vger.kernel.org>; Sat, 29 Oct 2022 04:35:41 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id d59-20020a17090a6f4100b00213202d77e1so12113411pjk.2
        for <linux-pci@vger.kernel.org>; Sat, 29 Oct 2022 04:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aHrf4/ua/bP2fhJLYsi8YFH+OWTvuSQYXS/+2VW1Ev0=;
        b=I9g+VCSV+zesHYNJbKc0yUccjLk+eGuoOnslD2rsd70ar/2uFJMsBaW0frPa64wRLe
         QDg6ZpHO7EyYw2zXffiRuarpAS6Z+j2p2We44drdVTMS37msLfy4EfjEN4PqcicHiToW
         K85/dU0TAaYSBXuEuJWSi9Sv3XbSAoz38KtZ7UZOvTjGZkia4T4c2u9GPtlVv6RuYvly
         yhGdkTfznbcncwWJefsxChmiaadeH072yj9Z90p7Txzggf6R4iYs++4rjc9nDeqoAE95
         Db3QVeHoc7emPHPBhGWz+SrwkugflA8G1+vTegg5lL6kX1afMkLzMwMctxcUE5T02aB/
         LQ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aHrf4/ua/bP2fhJLYsi8YFH+OWTvuSQYXS/+2VW1Ev0=;
        b=iINI5JL29yd7kl977fvDE5twunZdP5jsLXUhYTYRjiS8joKjuyZYUHJsssX/8E69Pb
         FJoNgrffbM2ergvhGnvU9x5U2ZwOf/E7J73xKQ1Bqhdu2FZovmUMTjIz2abBqR0cjoB6
         laMcfVPbk2LRwYR3KkLXuB+EQ197YSLzGK/pvOp4fkG0BpZh713/Fzzrxqx44MJoH/QL
         kb8dsis5Xcmc6bi5OnTi0u6BiaPLKFXwVqnoeSbyeFApaQ6uDegNZyEPuBj0RbdC9R97
         DjlZ8wntPnl4LSznKK1/d+bAjoqbnUJixXu0UJHvclJFjSVSmGo90bcp4nt6OBsmCb1E
         xLZA==
X-Gm-Message-State: ACrzQf3BoOq9RwJawIM3QSU1SsDRJzheGs/bOMsuTyIdr2d68xbexZTy
        r/+lqJ9WMfH0Gp1xVYw47XqN
X-Google-Smtp-Source: AMsMyM71NxDrO34qEW6NTTZhgP2jTUdSMzjgUKJGZTImNZWgB5kLuzzT+FIYqH5UnqXJvBhQv8FVNA==
X-Received: by 2002:a17:90a:5781:b0:20a:9962:bb4a with SMTP id g1-20020a17090a578100b0020a9962bb4amr20838383pji.185.1667043340967;
        Sat, 29 Oct 2022 04:35:40 -0700 (PDT)
Received: from localhost.localdomain ([117.193.208.18])
        by smtp.gmail.com with ESMTPSA id y189-20020a6264c6000000b00540f96b7936sm1045888pfb.30.2022.10.29.04.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 04:35:39 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, johan+linaro@kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH] PCI: qcom: Add async probe support
Date:   Sat, 29 Oct 2022 17:05:20 +0530
Message-Id: <20221029113520.242970-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
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

Qcom PCIe RC driver waits for the PHY link to be up during the probe. This
consumes several milliseconds during boot. So add async probe support so
that other drivers can load in parallel while this driver waits for the
link to be up.

Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index f711acacaeaf..e0b8d6dc4ce2 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1768,6 +1768,7 @@ static struct platform_driver qcom_pcie_driver = {
 		.name = "qcom-pcie",
 		.suppress_bind_attrs = true,
 		.of_match_table = qcom_pcie_match,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 builtin_platform_driver(qcom_pcie_driver);
-- 
2.25.1

