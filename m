Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540746D5AE0
	for <lists+linux-pci@lfdr.de>; Tue,  4 Apr 2023 10:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbjDDI02 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Apr 2023 04:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233319AbjDDI0F (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Apr 2023 04:26:05 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420FB2D48;
        Tue,  4 Apr 2023 01:25:27 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id r11so127296968edd.5;
        Tue, 04 Apr 2023 01:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680596725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RBCeY3EEewEkw2R8YHGP/k/d6javu61/xUXZZ1FDqBk=;
        b=g5Xt8tTMjwxsBK6M1kTxLf56jkTiuNnKB4EzsZmMcSvCUEqljqilwIL4OfQOd1KUbU
         iUxh1LG8nlQFpxPX6XZpAOEfl5hV2XOkdRS14Vrt0UopN2cLxQjwr4QlAqy4ld2+B++b
         3R1uSIPMttuv/TDS8qURUb2SQB8m01cFBSIKzSKhBriZtANaLs85G0iAPDRaxDPC/egw
         g7ClanyCPoMIdryMwnteCmSRM5kzcUrknoGsLjlbAgrcPW8Zi3nraakM6RUg+K0EZJ0E
         FYzfVaDp4qxqoYyBC958O7VRmfWgizjFUuPMtcmQduv+3PUKhXcjKUf7VJ53DfN9qvG1
         zlZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680596725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RBCeY3EEewEkw2R8YHGP/k/d6javu61/xUXZZ1FDqBk=;
        b=27+0gRPDNCGFW8Fluhr64e83QZBbDxJNpOvqrBYWahoEdbgn182MXp6fDDdTTIK9+Q
         aMvnQ6HCX/K4rmTopib0HRN+dsJ516/3f38xZIJW7oFsP0mRGNDm9n5nOkTlA3RpSEdU
         7/zT9FsALxgIJM/ihbHitmeRxcT6oL3J9/qr2rGnkcyZGLCEfb4jQ007mDxR42UHphpr
         ahZfp7fzOW0nQOwAQProj04W8jZh+SEsMDnoDdEyJFiuFMWwDeTnNcAXp7pxqfRydD5f
         OpbUZ+UKl7zYdEjqGpXh/U727eLBIiFVHa2AinPQwmklOl6FydWBMMBlnMQh562uayLt
         ZLbg==
X-Gm-Message-State: AAQBX9fkn7KZP+JmAueP1MfUze1K82q5FlPNr4rbE8g6KQqIvnrYX7dn
        TG+rWx0o2gMK4OzYDt3IK7s=
X-Google-Smtp-Source: AKy350bxaJLguuUheH5puu+Kr9GQsSw1qq9xXlbpIvIOx6rqDFa6FfO12WN1/o8lPtldO2qyVNSFZw==
X-Received: by 2002:aa7:d448:0:b0:4fe:9bba:1d65 with SMTP id q8-20020aa7d448000000b004fe9bba1d65mr2033168edr.21.1680596725502;
        Tue, 04 Apr 2023 01:25:25 -0700 (PDT)
Received: from A13PC04R.einet.ad.eivd.ch ([193.134.219.72])
        by smtp.googlemail.com with ESMTPSA id s5-20020a170906454500b008e54ac90de1sm5640652ejq.74.2023.04.04.01.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 01:25:25 -0700 (PDT)
From:   Rick Wertenbroek <rick.wertenbroek@gmail.com>
To:     alberto.dassatti@heig-vd.ch
Cc:     damien.lemoal@opensource.wdc.com, xxm@rock-chips.com,
        Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Brian Norris <briannorris@chromium.org>,
        Caleb Connolly <kc@postmarketos.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>,
        Lin Huang <hl@rock-chips.com>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Hugh Cole-Baker <sigmaris@gmail.com>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 10/11] PCI: rockchip: Don't advertise MSI-X in PCIe capabilities
Date:   Tue,  4 Apr 2023 10:24:23 +0200
Message-Id: <20230404082426.3880812-11-rick.wertenbroek@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230404082426.3880812-1-rick.wertenbroek@gmail.com>
References: <20230404082426.3880812-1-rick.wertenbroek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The RK3399 PCIe endpoint controller cannot generate MSI-X IRQs.
This is documented in the RK3399 technical reference manual (TRM)
section 17.5.9 "Interrupt Support".

MSI-X capability should therefore not be advertised. Remove the
MSI-X capability by editing the capability linked-list. The
previous entry is the MSI capability, therefore get the next
entry from the MSI-X capability entry and set it as next entry
for the MSI capability. This in effect removes MSI-X from the list.

Linked list before : MSI cap -> MSI-X cap -> PCIe Device cap -> ...
Linked list now : MSI cap -> PCIe Device cap -> ...

Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
---
 drivers/pci/controller/pcie-rockchip-ep.c | 15 +++++++++++++++
 drivers/pci/controller/pcie-rockchip.h    |  5 +++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index 924b95bd736c..20c768287870 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -510,6 +510,7 @@ static int rockchip_pcie_ep_probe(struct platform_device *pdev)
 	size_t max_regions;
 	struct pci_epc_mem_window *windows = NULL;
 	int err, i;
+	u32 cfg_msi, cfg_msix_cp;
 
 	ep = devm_kzalloc(dev, sizeof(*ep), GFP_KERNEL);
 	if (!ep)
@@ -584,6 +585,20 @@ static int rockchip_pcie_ep_probe(struct platform_device *pdev)
 
 	ep->irq_pci_addr = ROCKCHIP_PCIE_EP_DUMMY_IRQ_ADDR;
 
+	cfg_msi = rockchip_pcie_read(rockchip, PCIE_EP_CONFIG_BASE +
+				     ROCKCHIP_PCIE_EP_MSI_CTRL_REG);
+
+	cfg_msi &= ~ROCKCHIP_PCIE_EP_MSI_CP1_MASK;
+
+	cfg_msix_cp = rockchip_pcie_read(rockchip, PCIE_EP_CONFIG_BASE +
+					 ROCKCHIP_PCIE_EP_MSIX_CAP_REG) &
+					 ROCKCHIP_PCIE_EP_MSIX_CAP_CP_MASK;
+
+	cfg_msi |= cfg_msix_cp;
+
+	rockchip_pcie_write(rockchip, cfg_msi,
+			    PCIE_EP_CONFIG_BASE + ROCKCHIP_PCIE_EP_MSI_CTRL_REG);
+
 	rockchip_pcie_write(rockchip, PCIE_CLIENT_CONF_ENABLE, PCIE_CLIENT_CONFIG);
 
 	return 0;
diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
index 1558eae298ae..a21070ea7166 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -226,6 +226,8 @@
 #define ROCKCHIP_PCIE_EP_CMD_STATUS			0x4
 #define   ROCKCHIP_PCIE_EP_CMD_STATUS_IS		BIT(19)
 #define ROCKCHIP_PCIE_EP_MSI_CTRL_REG			0x90
+#define   ROCKCHIP_PCIE_EP_MSI_CP1_OFFSET		8
+#define   ROCKCHIP_PCIE_EP_MSI_CP1_MASK			GENMASK(15, 8)
 #define   ROCKCHIP_PCIE_EP_MSI_FLAGS_OFFSET		16
 #define   ROCKCHIP_PCIE_EP_MSI_CTRL_MMC_OFFSET		17
 #define   ROCKCHIP_PCIE_EP_MSI_CTRL_MMC_MASK		GENMASK(19, 17)
@@ -233,6 +235,9 @@
 #define   ROCKCHIP_PCIE_EP_MSI_CTRL_MME_MASK		GENMASK(22, 20)
 #define   ROCKCHIP_PCIE_EP_MSI_CTRL_ME				BIT(16)
 #define   ROCKCHIP_PCIE_EP_MSI_CTRL_MASK_MSI_CAP	BIT(24)
+#define ROCKCHIP_PCIE_EP_MSIX_CAP_REG			0xb0
+#define   ROCKCHIP_PCIE_EP_MSIX_CAP_CP_OFFSET		8
+#define   ROCKCHIP_PCIE_EP_MSIX_CAP_CP_MASK		GENMASK(15, 8)
 #define ROCKCHIP_PCIE_EP_DUMMY_IRQ_ADDR				0x1
 #define ROCKCHIP_PCIE_EP_PCI_LEGACY_IRQ_ADDR		0x3
 #define ROCKCHIP_PCIE_EP_FUNC_BASE(fn) \
-- 
2.25.1

