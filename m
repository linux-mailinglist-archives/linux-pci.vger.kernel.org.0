Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F10524536
	for <lists+linux-pci@lfdr.de>; Thu, 12 May 2022 07:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350035AbiELF4T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 May 2022 01:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350033AbiELF4M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 May 2022 01:56:12 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D5B2497D;
        Wed, 11 May 2022 22:56:10 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id bv19so8034673ejb.6;
        Wed, 11 May 2022 22:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jovg6Gn1+l1bFNNGDKkLFFufpn4EfrWqOlCPZrp3sfU=;
        b=Xy0o+hM3tLvfZFqKsOhlwTwoOuWhFr+FGKgTHRYaM9okG67pwCh0qkD6FMf5tWO121
         xVQr8qgZ67VG+OwWVYSJTnrXQhiRcrY4GQfVlcvJvd0IhUVkii0biNd4WAWiT5Txe+uh
         MH/ftG2j7rUul1mbXRvZLlI/EigyjBpjZtoC87FbIhYbH2Ve/8pHNo3DgkQJT4dGciLq
         De+oSIkX1ckMoS9Vkkv/sN77ejblRiyyNQ3DDJhVOx0sGJa6LQrLpA5HLQCZHLNDtfG/
         uuzIJI9/J1WDGgV6X8iTnAW+74TOYGNaeZP4ixBR1wvLTp6VNSGFedzaA4+vhVVacclI
         0rvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jovg6Gn1+l1bFNNGDKkLFFufpn4EfrWqOlCPZrp3sfU=;
        b=JP0zALe3Mwsb/hZjsNzPB63okiArrOwR3LtG3sK6zYZUIhz2v9o+yh1nBGD15V+nd9
         7BH3vbUiCFLEn8WrbE735bXYGq12/yy1Y7UKIH5oxXjbKzPEGNQ3LqKQDKqy9zQ5i5Q3
         XgqtWH7K6yjG6NGEmrL7DVG1Tk4Zxr+VXUP1/QnrI90X/mh297vx3LVvv9gIKaRhaYiX
         S+j4uVC1Gl51LF38Znfxhovprc5kLzhBE9iyobZwNcDM+pRtV7fcZwDK2BUoADrWqHua
         /eCYOutPa2alpB0GrExwZWJous0oU56cOL5smRyk3RRueyWwozFEfVq5UMc2EqnqJpWQ
         3z2Q==
X-Gm-Message-State: AOAM532S/Yu+rRWftPjLyBvCX1Z1hQ1m0lQpZY4fJwHLObbdriQymKEt
        TmzgiMlbTxd4q77W5lTCnY0+/q0HQFUdgQ==
X-Google-Smtp-Source: ABdhPJyI3xxnYv+nUrY0ShpToYWh0lCS4SMpU7AgO5U14xIuKB6L20Ofw4VRc/Rv1YFCN5AboQIS+w==
X-Received: by 2002:a17:907:6287:b0:6e1:6ac:c769 with SMTP id nd7-20020a170907628700b006e106acc769mr28929968ejc.388.1652334968811;
        Wed, 11 May 2022 22:56:08 -0700 (PDT)
Received: from localhost.localdomain.info (62-178-82-229.cable.dynamic.surfer.at. [62.178.82.229])
        by smtp.gmail.com with ESMTPSA id n14-20020a170906700e00b006f3ef214e34sm1686320ejj.154.2022.05.11.22.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 22:56:08 -0700 (PDT)
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     dominic.rath@ibv-augsburg.net, kishon@ti.com,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH v3] PCI: cadence: Allow PTM Responder to be enabled
Date:   Thu, 12 May 2022 07:55:38 +0200
Message-Id: <20220512055539.1782437-1-christian.gmeiner@gmail.com>
X-Mailer: git-send-email 2.36.1
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

This enables the Controller [RP] to automatically respond with
Response/ResponseD messages if CDNS_PCIE_LM_TPM_CTRL_PTMRSEN
and PCI_PTM_CTRL_ENABLE bits are both set.

Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
---
 drivers/pci/controller/cadence/pcie-cadence-host.c | 10 ++++++++++
 drivers/pci/controller/cadence/pcie-cadence.h      |  4 ++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index fb96d37a135c..940c7dd701d6 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -123,6 +123,14 @@ static int cdns_pcie_retrain(struct cdns_pcie *pcie)
 	return ret;
 }
 
+static void cdns_pcie_host_enable_ptm_response(struct cdns_pcie *pcie)
+{
+	u32 val;
+
+	val = cdns_pcie_readl(pcie, CDNS_PCIE_LM_PTM_CTRL);
+	cdns_pcie_writel(pcie, CDNS_PCIE_LM_PTM_CTRL, val | CDNS_PCIE_LM_TPM_CTRL_PTMRSEN);
+}
+
 static int cdns_pcie_host_start_link(struct cdns_pcie_rc *rc)
 {
 	struct cdns_pcie *pcie = &rc->pcie;
@@ -501,6 +509,8 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
 	if (rc->quirk_detect_quiet_flag)
 		cdns_pcie_detect_quiet_min_delay_set(&rc->pcie);
 
+	cdns_pcie_host_enable_ptm_response(pcie);
+
 	ret = cdns_pcie_start_link(pcie);
 	if (ret) {
 		dev_err(dev, "Failed to start link\n");
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index c8a27b6290ce..1ffa8fa77a8a 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -116,6 +116,10 @@
 #define LM_RC_BAR_CFG_APERTURE(bar, aperture)		\
 					(((aperture) - 2) << ((bar) * 8))
 
+/* PTM Control Register */
+#define CDNS_PCIE_LM_PTM_CTRL 	(CDNS_PCIE_LM_BASE + 0x0da8)
+#define CDNS_PCIE_LM_TPM_CTRL_PTMRSEN 	BIT(17)
+
 /*
  * Endpoint Function Registers (PCI configuration space for endpoint functions)
  */
-- 
2.36.1

