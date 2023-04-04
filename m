Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F726D5AE3
	for <lists+linux-pci@lfdr.de>; Tue,  4 Apr 2023 10:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbjDDI0c (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Apr 2023 04:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234215AbjDDI0J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Apr 2023 04:26:09 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C2019A7;
        Tue,  4 Apr 2023 01:25:31 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id i5so127467628eda.0;
        Tue, 04 Apr 2023 01:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680596728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8XUQa3tTZYrqLB8ZmeHcjq7vHYuWTZQrN0dXU7k9lqI=;
        b=fD2qTEJx7JiveSjrGAiMG5AGWZGPxK1lg4ePRaP1pYnBfj7kfz+yfUUU2hKx0to43N
         zZvp2Sl8D638krQfJjWs0ah7bJ+27ECGaIo/V2VdPjiYKwoVLVbUnd4l9AK6tsW7RIx9
         G9BFmUYndLsfJz918OTi0TEgEwRuEsj79fgtHoXQ+PDmBzNby1OEHWp0fa8TZXVPnwZD
         KVq1jysdS/uMIKBsOry/tBGp1SQZm6vFFCdj12qmWULu9Qs5XtAsQBNxpgHC4ggHZDFz
         2u6IDiNoKXSAFjLf6dEDfYTFKQyspQKEMgQCVX08x0Fqd7ho0Zrfv0RNqd2byjp2my2d
         Gn2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680596728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8XUQa3tTZYrqLB8ZmeHcjq7vHYuWTZQrN0dXU7k9lqI=;
        b=ej1Q99mUFP3a807pr9HFkB8lRDYOyk2lTDVmuG2T9erLYos/0WX5zPTbnSsPTj25KD
         7orbHU983hLC5Y+G9FM+bGT7PFUgbp4cZ6DYXA2ziSExPUuHhSzFCczwGacp/O2WDJRb
         PYQ0TaMZohwbBTEKU1vR/ZgAkrMkRR64Teedp6I5dLmWPfNAHf2LsID5sgtknrhXuQX4
         53gYcTXXebHHh/mdQRaA3H+pUe9d0T20bEwjaADOHvJBnVfsddOEE67v+rAyhGq6Lc2L
         wNWWjmp0YCr/8BndcjoLTRyl2u9grb0TFaOwtVDvOk/FegychZvlSrYc318ATa25EY//
         Pm2g==
X-Gm-Message-State: AAQBX9cLNXKKoertRqp/P4q4VjqyLTQ5pHroS/vW9PSnavn/Zc78DiiG
        iEPGpsr+HBf++P6snrGmBuk=
X-Google-Smtp-Source: AKy350ZQz1lJo+m3TubIFZX0lfv6+qAeDNkvwtqQyFwmKtUazwtEsAnttwdalMXfJeFOkG4raYmxmw==
X-Received: by 2002:a17:907:d689:b0:8af:2a97:91d4 with SMTP id wf9-20020a170907d68900b008af2a9791d4mr1491773ejc.14.1680596728271;
        Tue, 04 Apr 2023 01:25:28 -0700 (PDT)
Received: from A13PC04R.einet.ad.eivd.ch ([193.134.219.72])
        by smtp.googlemail.com with ESMTPSA id s5-20020a170906454500b008e54ac90de1sm5640652ejq.74.2023.04.04.01.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 01:25:28 -0700 (PDT)
From:   Rick Wertenbroek <rick.wertenbroek@gmail.com>
To:     alberto.dassatti@heig-vd.ch
Cc:     damien.lemoal@opensource.wdc.com, xxm@rock-chips.com,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Brian Norris <briannorris@chromium.org>,
        Caleb Connolly <kc@postmarketos.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        Lin Huang <hl@rock-chips.com>,
        Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Hugh Cole-Baker <sigmaris@gmail.com>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 11/11] PCI: rockchip: Set address alignment for endpoint mode
Date:   Tue,  4 Apr 2023 10:24:24 +0200
Message-Id: <20230404082426.3880812-12-rick.wertenbroek@gmail.com>
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

From: Damien Le Moal <damien.lemoal@opensource.wdc.com>

The address translation unit of the rockchip EP controller does not use
the lower 8 bits of a PCIe-space address to map local memory. Thus we
must set the align feature field to 256 to let the user know about this
constraint.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/pci/controller/pcie-rockchip-ep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index 20c768287870..b79382c1938a 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -445,6 +445,7 @@ static const struct pci_epc_features rockchip_pcie_epc_features = {
 	.linkup_notifier = false,
 	.msi_capable = true,
 	.msix_capable = false,
+	.align = 256,
 };
 
 static const struct pci_epc_features*
-- 
2.25.1

