Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32DBB74714C
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jul 2023 14:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbjGDM13 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jul 2023 08:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbjGDM1J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jul 2023 08:27:09 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CED310FB
        for <linux-pci@vger.kernel.org>; Tue,  4 Jul 2023 05:26:58 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3a3719334a2so556011b6e.1
        for <linux-pci@vger.kernel.org>; Tue, 04 Jul 2023 05:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688473617; x=1691065617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P6fCPMG/mD9DvgQa8dhQsAsB5OzsfSms6y08RxS/QSw=;
        b=XQ/JzUDX7iHpjiguYmOdpVdcoY8ft9UsjGKblye02xAGbrmleHDbCMlxjtobfubdRP
         ZtwWq4RPT4j3f2d/h10hzPzN1SWKRXTeyIkY82MWD4XSxfNh4Te51WXLNtLZyH1Cy3lv
         37reROKrSfye37RWQ/xwlmKXLB/N3bFC41PyyixxD9ZzK4T42bJh1wKs3FPvpmwE6f+W
         wG9z+5FbLm1GiT1EDE8ccLO+/ZLPmuBCvj8QT2W84R05bA2ytNzHze4Z8TSUGLjC2PQh
         lgaqse7kFGfY5CVl4dgv4suGU222pUXALZjOL3ZfcUS7+8AUmuW9rSpWT0wWB55JAq1L
         5rwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688473617; x=1691065617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P6fCPMG/mD9DvgQa8dhQsAsB5OzsfSms6y08RxS/QSw=;
        b=ig7B6K3qj0pnPz3teHREJxWWKgOxOTUC0wVzYuPxJ4qs38JD+Z+XA7NU2WbScdoPAM
         pfEsJJCe1OKdE3wyNFFrgbPwSVa8U9HRuhkV22micP8IhlYf0BH2/skiSCp/FrgtfyV3
         oGuzky042GF9FCLQbhkwT6GVkfHdM1eWIb9nl++PWOpIh5N8NlyINAhpyTG6JyJ16RdH
         bOazKLQe9qEf4EOjB4dhrJFAdbmAIHEAV2ONouhLLVY1sOZV61xcu60Hwn/CACvczKXr
         hjD2CKxOQla/j/2nkSQBvXyMaRcipmx/ALduy+QRPK5PuWKU4IQaNULuFMDdeHPNbhT/
         y4yA==
X-Gm-Message-State: AC+VfDwTuSIXT/ZjBrj6hry1IumzOT1Vv8nQE7whGcmL+oYUoEc11iGQ
        1Jpj0/WtZiV/m6Ydc90dqT8=
X-Google-Smtp-Source: ACHHUZ61S/4YlDdxraaDSYj+Tg6RQx9MYvydVi2YvPFqB1LzwIIDaN4ptoCXAKDLqHy3TJvJ12KV7Q==
X-Received: by 2002:aca:db44:0:b0:3a1:d457:83b5 with SMTP id s65-20020acadb44000000b003a1d45783b5mr8132075oig.3.1688473617246;
        Tue, 04 Jul 2023 05:26:57 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:5eeb:c8fb:6587:eb13])
        by smtp.gmail.com with ESMTPSA id l1-20020a544501000000b003a3600182f8sm6701153oil.57.2023.07.04.05.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 05:26:56 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     bhelgaas@google.com
Cc:     ajayagarwal@google.com, robh@kernel.org, lpieralisi@kernel.org,
        hongxing.zhu@nxp.com, broonie@kernel.org,
        linux-pci@vger.kernel.org, kw@linux.com,
        gustavo.pimentel@synopsys.com, jingoohan1@gmail.com,
        sdalvi@google.com, Fabio Estevam <festevam@denx.de>
Subject: [PATCH] PCI: dwc: Do not fail to probe when link is down
Date:   Tue,  4 Jul 2023 09:26:35 -0300
Message-Id: <20230704122635.1362156-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Fabio Estevam <festevam@denx.de>

Since commit da56a1bfbab5 ("PCI: dwc: Wait for link up only if link is
started") the following probe error is observed when the PCI link is down:

imx6q-pcie 33800000.pcie: Phy link never came up
imx6q-pcie: probe of 33800000.pcie failed with error -110

The intention of commit 886a9c134755 ("PCI: dwc: Move link handling into
common code") was to standardize the behavior of link down as explained
in its commit log:
    
"The behavior for a link down was inconsistent as some drivers would fail
probe in that case while others succeed. Let's standardize this to
succeed as there are usecases where devices (and the link) appear later
even without hotplug. For example, a reconfigured FPGA device."

Restore the original behavior by ignoring the error from
dw_pcie_wait_for_link().

Fixes: da56a1bfbab5 ("PCI: dwc: Wait for link up only if link is started")
Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index cf61733bf78d..af6a7cd060b1 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -492,11 +492,8 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 		if (ret)
 			goto err_remove_edma;
 
-		if (pci->ops && pci->ops->start_link) {
-			ret = dw_pcie_wait_for_link(pci);
-			if (ret)
-				goto err_stop_link;
-		}
+		if (pci->ops && pci->ops->start_link)
+			dw_pcie_wait_for_link(pci);
 	}
 
 	bridge->sysdata = pp;
-- 
2.34.1

