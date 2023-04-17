Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E75B6E43DE
	for <lists+linux-pci@lfdr.de>; Mon, 17 Apr 2023 11:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbjDQJ3I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Apr 2023 05:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbjDQJ1n (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Apr 2023 05:27:43 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01838271B;
        Mon, 17 Apr 2023 02:27:28 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id ud9so62161313ejc.7;
        Mon, 17 Apr 2023 02:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681723647; x=1684315647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mIzKLg4GpjOzi297VJ0dtCu0S6Mi4dppQa6/15EW5pk=;
        b=DGwKRCNVQmOXvqi1wI53bFf+tp8DMr0UfGFDldJ1hYnZv9tpCW2WTYgVa1QA17xwC+
         YHL6JmzMiuHDLrGts81MkWsgHDF66J5Oz7A1O1cbLT5vUgoWb2zKGAuGeLg4US4NBVCc
         TnirPg0MAj4NOfTESsXhbHThAQRt3lqknbPksa79D0CSSsmLz0wJvr4AIz7XKPQRsclm
         hO1GZNyXDQdgt/gmuj30I1fj1EQr6+1K/8xZF8FMiirgNLcsGg8Qxala5zqixKMi5W1B
         oa5k2wUsFNqh77QKDqnGuiaptUoWj8t3Ew2o6Cpt/e93dvnpwwwgYMrxKOEMI8D59ABU
         W7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681723647; x=1684315647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mIzKLg4GpjOzi297VJ0dtCu0S6Mi4dppQa6/15EW5pk=;
        b=Ah0AVgqJ78pc7JwlQOT6PU/Zv13bcUDldQuheIlAq2534wYkIQKPP2AB2eYblm+Tn1
         FdblRaF/T4M2GqSRmB19ghbOkSgt9pUZHSRFoleUqsPtdqjCM1R9LYc36ZPlvhkAsAgr
         mnfkGSFD1hCh1/A2X2fMiERFxUKk5WwoZQlH2zdokDXJz29vjwdbpZzepLR36DetQ4DN
         OVIzZjFCte3LJMikA++uSgCcTHsaeoqzUiqPPTUDt9QEdXYUqbiTovR0YAoZvIpvnBZd
         8AZkaAP3c3wtDCAMA4wBCcYdyFQlXBCqOrfNRehrtu2JUMUpsFCiVMMdlDqZ6PU1o6sh
         Oiyw==
X-Gm-Message-State: AAQBX9fjQ+WaB9IxODDkPebYcf+MAYavjgN/dXBWlcwzDMvKWncPZyly
        slpqthdf9Mw/cHnJ5vm2W3I=
X-Google-Smtp-Source: AKy350a1J6+gjrzwXv0Ks+vuzPkCdPg2TE3nyMnSTa1A9epJMEunrqg4MJREhDQaLIBvDxzcasA+mA==
X-Received: by 2002:a17:907:6e14:b0:94f:4bd4:36f with SMTP id sd20-20020a1709076e1400b0094f4bd4036fmr4374087ejc.64.1681723647131;
        Mon, 17 Apr 2023 02:27:27 -0700 (PDT)
Received: from A13PC04R.einet.ad.eivd.ch ([193.134.219.72])
        by smtp.googlemail.com with ESMTPSA id p20-20020a170906615400b0094aa087578csm6398596ejl.171.2023.04.17.02.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 02:27:26 -0700 (PDT)
From:   Rick Wertenbroek <rick.wertenbroek@gmail.com>
To:     alberto.dassatti@heig-vd.ch
Cc:     xxm@rock-chips.com, Damien Le Moal <dlemoal@kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Caleb Connolly <kc@postmarketos.org>,
        Brian Norris <briannorris@chromium.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Hugh Cole-Baker <sigmaris@gmail.com>,
        Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 11/11] PCI: rockchip: Set address alignment for endpoint mode
Date:   Mon, 17 Apr 2023 11:26:29 +0200
Message-Id: <20230417092631.347976-12-rick.wertenbroek@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230417092631.347976-1-rick.wertenbroek@gmail.com>
References: <20230417092631.347976-1-rick.wertenbroek@gmail.com>
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

From: Damien Le Moal <dlemoal@kernel.org>

The address translation unit of the rockchip EP controller does not use
the lower 8 bits of a PCIe-space address to map local memory. Thus we
must set the align feature field to 256 to let the user know about this
constraint.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/pci/controller/pcie-rockchip-ep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index edfced311a9f..0af0e965fb57 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -442,6 +442,7 @@ static const struct pci_epc_features rockchip_pcie_epc_features = {
 	.linkup_notifier = false,
 	.msi_capable = true,
 	.msix_capable = false,
+	.align = 256,
 };
 
 static const struct pci_epc_features*
-- 
2.25.1

