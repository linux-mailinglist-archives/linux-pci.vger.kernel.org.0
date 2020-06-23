Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5DB205537
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jun 2020 16:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732851AbgFWOzi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Jun 2020 10:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732738AbgFWOzi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Jun 2020 10:55:38 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19F7C061573;
        Tue, 23 Jun 2020 07:55:36 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id w6so10617000ejq.6;
        Tue, 23 Jun 2020 07:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZoNn/kpfy4EOqV/F84P2FYlfojkZZi4ZcYifbOpUmbc=;
        b=IG2STyNaS325DioJWbHdwVE6LZvETJb0OUG5l9W9w2Liu4rVS/E8Q8Kgdr2+acpGgk
         INk4bWbnxbcEVwQrG6BayYgEWHiwDp/tThbKDtfCGS5p+fHpW3QNDyp5CHB3KUGDTj5F
         UNMCcPOepb9Rer4lDnDltiyyoUduB1erVERoTTBzYl+Iw+UTz5foiu6pUiFZrIHx5sXW
         SuLdztptajl3XvO4CYGuwoIDqzbu4h980Pe+2TAw86pnIkdcgiNYXAWfXGuJhQMBCMS2
         ljnZDw2+ZQ3C9KnaQnzbMckqDOkXgBRkJ0NI+IDel6nLkvb9ehQX+/tQCSU7IlNFyHO/
         x2qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZoNn/kpfy4EOqV/F84P2FYlfojkZZi4ZcYifbOpUmbc=;
        b=PnT+C1KVT/XpbPEoXd48hycS4uSFwsTctqsqinKUtYNGcqlRSL+CAPX5QnRdiBBd6S
         Phwd7ICS8WmWo6P5S8HYsc8GdT2/qwEN2OqnPfdRhHuK48d7LN5OZU1U4RZsw/QBiDzB
         Khxp0mw8765GElV+NGgj31sQ1b2otS751eHwgNj8+BuXzZ0u80hfvkahvPxeHUIH4KM5
         uudz4pcjPS7ROjhYchBgNL1eE3roR33lzHU5m8DwjJl9K1TsYI3xIr2zCbn6pZi4a16a
         5jHX8QMvDh9XTPPFp5A14Jh+2EG7kDK2ltrvRrEgD2UOqKg+JlcHpM/EugXwYq9T3PTE
         MDug==
X-Gm-Message-State: AOAM530/q8Nmp00815lF1jJa5N2NItXsuLsyDhcFiqUpxrML+mtYbXmw
        YkovaSsRw3Oz1JFVBkbSIwg=
X-Google-Smtp-Source: ABdhPJzCdsyT1/vZeG/XK8ILBOHjer3JOHBRVsmSyxl0EED/uDPBfyTUsGQBKt4o8AaU9VPsUkni9g==
X-Received: by 2002:a17:906:3e15:: with SMTP id k21mr21576565eji.525.1592924135087;
        Tue, 23 Jun 2020 07:55:35 -0700 (PDT)
Received: from localhost (pd9e51079.dip0.t-ipconnect.de. [217.229.16.121])
        by smtp.gmail.com with ESMTPSA id js3sm13649354ejb.65.2020.06.23.07.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 07:55:30 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Jon Hunter <jonathanh@nvidia.com>, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: pci: tegra: Remove PLL power supplies
Date:   Tue, 23 Jun 2020 16:55:27 +0200
Message-Id: <20200623145528.1658337-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

The XUSB pad controller, which provides access to various USB, PCI and
SATA pads (or PHYs), needs to bring up the PLLs associated with these
pads. In order to properly do so, it needs to control the power supplied
to these PLLs.

Remove the PLL power supplies from the PCIe controller because it does
not need direct access to them. Instead it will only use the configured
pads provided by the XUSB pad controller.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Hi Rob,

I already made this change as part of the conversion series, but wanted
to send this out as part of this subseries since it addresses a fairly
long-standing issue that I'd like to clean up irrespective of the DT
binding conversion. Since it looks like the conversion series will take
a bit longer, I think it makes sense to send this out separately.

Thierry

 .../devicetree/bindings/pci/nvidia,tegra20-pcie.txt  | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
index 7939bca47861..d099f3476ccc 100644
--- a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
@@ -112,28 +112,16 @@ Power supplies for Tegra124:
 - Required:
   - avddio-pex-supply: Power supply for analog PCIe logic. Must supply 1.05 V.
   - dvddio-pex-supply: Power supply for digital PCIe I/O. Must supply 1.05 V.
-  - avdd-pex-pll-supply: Power supply for dedicated (internal) PCIe PLL. Must
-    supply 1.05 V.
   - hvdd-pex-supply: High-voltage supply for PCIe I/O and PCIe output clocks.
     Must supply 3.3 V.
-  - hvdd-pex-pll-e-supply: High-voltage supply for PLLE (shared with USB3).
-    Must supply 3.3 V.
   - vddio-pex-ctl-supply: Power supply for PCIe control I/O partition. Must
     supply 2.8-3.3 V.
-  - avdd-pll-erefe-supply: Power supply for PLLE (shared with USB3). Must
-    supply 1.05 V.
 
 Power supplies for Tegra210:
 - Required:
-  - avdd-pll-uerefe-supply: Power supply for PLLE (shared with USB3). Must
-    supply 1.05 V.
   - hvddio-pex-supply: High-voltage supply for PCIe I/O and PCIe output
     clocks. Must supply 1.8 V.
   - dvddio-pex-supply: Power supply for digital PCIe I/O. Must supply 1.05 V.
-  - dvdd-pex-pll-supply: Power supply for dedicated (internal) PCIe PLL. Must
-    supply 1.05 V.
-  - hvdd-pex-pll-e-supply: High-voltage supply for PLLE (shared with USB3).
-    Must supply 3.3 V.
   - vddio-pex-ctl-supply: Power supply for PCIe control I/O partition. Must
     supply 1.8 V.
 
-- 
2.27.0

