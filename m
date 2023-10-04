Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F417B859C
	for <lists+linux-pci@lfdr.de>; Wed,  4 Oct 2023 18:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243475AbjJDQov (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Oct 2023 12:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243472AbjJDQou (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Oct 2023 12:44:50 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA94495
        for <linux-pci@vger.kernel.org>; Wed,  4 Oct 2023 09:44:47 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-69335ddbe16so1843141b3a.1
        for <linux-pci@vger.kernel.org>; Wed, 04 Oct 2023 09:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696437887; x=1697042687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H81jI+2UrQq9I60V53NOI8YjscFjeeEaTqsqQZKREJU=;
        b=j+oTcgK7nk3nU3ntGpQPyk/PDT1aRQ4IPNX+F1o8DFB8hNzI109yf2tWAQbpfPx/+5
         tXRDSsrbmKw7W85VNbyNoJN+L880i/9Z2sIocNy1ULBmc7s8pUBqta0L24bAY/ijAbts
         LQ8kaLK+dz25QLZF4Raw239ngqFLbBjy6I0XovxQQU+DlynE5h5R4oWDTK9bzQi+0kpZ
         wjhLScl2XwT5UyaQknjzjmNkQzBzDCLGHTCyA1/ubNBlBU0p1HimFNrss2MO8Qjk05JM
         zuXYgZtMJ7n2IbzGERaz1+buxXvVELeg4wKBPMoCVjNJG2WbkWQftSBmOuPOGHRo8aJg
         z76A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696437887; x=1697042687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H81jI+2UrQq9I60V53NOI8YjscFjeeEaTqsqQZKREJU=;
        b=rHj/pgU2d3qwVfCDtl+ItCtB0MPUP3HsTD2uZ7uBKdzniTVTw+urJjizj13O1S9oT4
         atvCdC8MqVcRmtYnt6T4Gyjz/L60zmWB0ZNEHo8Vboa8wIhui8XbuMz8DwOboMK9OiXN
         EK+jxqW6zrc5+bttYOaJKouQHautXc38cMa/BUmWn7oOmibvnPYDciLt3OZ02F3xrBab
         ilreqpH5sXGcUfH/gWAM7UIabKlPqcN2dSU1nmnJ2+QdCIUOTN12A4UODrYLOHd3Aur+
         LexXCuaa3bXLtfSL+XmFdMmqc7oHJDHWYbrJ+V9AIxpu7iMkgCZfZxTo40CpA8r81E20
         WWkg==
X-Gm-Message-State: AOJu0YyBg6PG10W2tslYnyz/0Rv156CCySO1a2iT6BdSpZ8nJQ52vCVS
        9WmARtwtgzayPVQqFMzVg7IZ
X-Google-Smtp-Source: AGHT+IG5naMTjhE0XIZMckM1eR3qflLys7JqfIzDKkq+M+AenCFb0iLpIfwbxwr0a0DexEPZR590zA==
X-Received: by 2002:a05:6a00:2293:b0:690:449f:5e96 with SMTP id f19-20020a056a00229300b00690449f5e96mr3168001pfe.33.1696437887232;
        Wed, 04 Oct 2023 09:44:47 -0700 (PDT)
Received: from localhost.localdomain ([117.217.185.220])
        by smtp.gmail.com with ESMTPSA id k14-20020aa792ce000000b0066a31111cc5sm3434628pfa.152.2023.10.04.09.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 09:44:46 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org,
        bhelgaas@google.com, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        abel.vesa@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Vidya Sagar <vidyas@nvidia.com>
Subject: [PATCH v4 3/3] PCI: tegra194: Use Mbps_to_icc() macro for setting icc speed
Date:   Wed,  4 Oct 2023 22:14:30 +0530
Message-Id: <20231004164430.39662-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231004164430.39662-1-manivannan.sadhasivam@linaro.org>
References: <20231004164430.39662-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCIe speed returned by the PCIE_SPEED2MBS_ENC() macro is in Mbps. So
instead of converting it to MBps explicitly and using the MBps_to_icc()
macro, let's use the Mbps_to_icc() macro to pass the value directly.

Cc: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---

Changes in v4:

* No change

Changes in v3:

- New patch

 drivers/pci/controller/dwc/pcie-tegra194.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 4bba31502ce1..5feac690e127 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -321,9 +321,9 @@ static void tegra_pcie_icc_set(struct tegra_pcie_dw *pcie)
 	speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, val);
 	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, val);
 
-	val = width * (PCIE_SPEED2MBS_ENC(pcie_link_speed[speed]) / BITS_PER_BYTE);
+	val = width * PCIE_SPEED2MBS_ENC(pcie_link_speed[speed]);
 
-	if (icc_set_bw(pcie->icc_path, MBps_to_icc(val), 0))
+	if (icc_set_bw(pcie->icc_path, Mbps_to_icc(val), 0))
 		dev_err(pcie->dev, "can't set bw[%u]\n", val);
 
 	if (speed >= ARRAY_SIZE(pcie_gen_freq))
-- 
2.25.1

