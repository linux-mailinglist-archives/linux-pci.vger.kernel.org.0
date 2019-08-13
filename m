Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC2268B5BE
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2019 12:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbfHMKiI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Aug 2019 06:38:08 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33290 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727221AbfHMKiH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Aug 2019 06:38:07 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so107389633wru.0;
        Tue, 13 Aug 2019 03:38:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7fA4ImgTXDy54WkrrWpZEbCCgZQJp3nUMqu6kivAEHE=;
        b=FO/qnFt/sp+xk1BO5CqMw5J+EBN6WhpvDsaH/h/m97kzOLovP8o3zbMeR3Q+lQ0O3v
         5tYOH31Nv0sjwLJx+M1zz3SA76u6UtpKXPfQpRiU59ZASLelyufcH8aQDoq7bJa5qjJz
         BnuMb4V2qzu/DHgRRcWc4x2Ibkm98qe9U1IC8TP7Ohr7aZcvPA3VqzAEUMdv+MI8CINx
         gxw2kVQW0MvOj80ljfymDjp1lY39xAHBi7QlMCCtpDoNsZGNqDZUOzfGJWuPfibiRj2k
         R0HZEptCID9CBG2x66CtNGLXLcAy9YgYN/dHGLinDt8DyClLmTZRLdakmXpDgKzzdQye
         0vfQ==
X-Gm-Message-State: APjAAAV1zfihnhkTQrKE2hlG+WRY2iALHvWeofk+kPmr8j4vjqkwRSVz
        vVc62GSW0z1EwDSXWWWZmrIAVNaQ+qVbpw==
X-Google-Smtp-Source: APXvYqwJhQAcPo3ERBZnabP8qqSJfaIMlg+cCQT9+ITjd2tPgcv7HbOe4c56c7ufaMOznaURXCPzuw==
X-Received: by 2002:a5d:610d:: with SMTP id v13mr36286575wrt.249.1565692684135;
        Tue, 13 Aug 2019 03:38:04 -0700 (PDT)
Received: from 1aq-andre.garage.tyco.com ([77.107.218.170])
        by smtp.gmail.com with ESMTPSA id f70sm1484635wme.22.2019.08.13.03.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2019 03:38:03 -0700 (PDT)
From:   =?UTF-8?q?Andr=C3=A9=20Draszik?= <git@andred.net>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Andr=C3=A9=20Draszik?= <git@andred.net>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: imx6q-pcie: add "fsl,pcie-phy-refclk-internal" for i.MX7D
Date:   Tue, 13 Aug 2019 11:37:59 +0100
Message-Id: <20190813103759.38358-2-git@andred.net>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190813103759.38358-1-git@andred.net>
References: <20190813103759.38358-1-git@andred.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The i.MX7D variant of the IP can use either an external
crystal oscillator input or an internal clock input as
a reference clock input for the PCIe PHY.

Document the optional property 'fsl,pcie-phy-refclk-internal'

Signed-off-by: André Draszik <git@andred.net>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
index a7f5f5afa0e6..985d7083df9f 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
@@ -56,6 +56,11 @@ Additional required properties for imx7d-pcie and imx8mq-pcie:
 	       - "turnoff"
 - fsl,imx7d-pcie-phy: A phandle to an fsl,imx7d-pcie-phy node.
 
+Additional optional properties for imx7d-pcie:
+- fsl,pcie-phy-refclk-internal: If present then an internal PLL input is used
+  as PCIe PHY reference clock source. By default an external ocsillator input
+  is used.
+
 Additional required properties for imx8mq-pcie:
 - clock-names: Must include the following additional entries:
 	- "pcie_aux"
-- 
2.23.0.rc1

