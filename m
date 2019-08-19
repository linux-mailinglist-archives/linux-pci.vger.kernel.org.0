Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8D39922C5
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2019 13:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfHSLxL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Aug 2019 07:53:11 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42225 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbfHSLxL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Aug 2019 07:53:11 -0400
Received: by mail-wr1-f65.google.com with SMTP id b16so8400869wrq.9;
        Mon, 19 Aug 2019 04:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2K8Jpmcg33sO6sZplY+4qwE+wKb080N1/bRHaIx7mAc=;
        b=ghZEcu0OSbIZPIYtUMgCM2aQEsNJwtryVhOXqRYI8w+nnfeqVUS/Ak+ISmSBsvUGyY
         0F7NOK9EolYyNgTiYyslW99h0sYg1mfG4Pdx9yKUk6iKV4jLd4ArsmNFoPLaKbzth0QJ
         dDHdYUmZG2jBClhiakAnyAiKqX+/C107B6dvgI8O+oKS3XKvNpzvXaVhAUMdNbEQbamE
         0+69/0Rjow9C2MSfFyxRimDTcdZmCR2+wLpMM2RRCp8IMqo9i4HW/wYLMYUb16utvySf
         iq4o6JbCC1HdWgDK74UZxFOVcYQBSy+f8xxqNl0hZLnG6wKzt8ykjG/ROsGVNK+ep2Sr
         BQ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=2K8Jpmcg33sO6sZplY+4qwE+wKb080N1/bRHaIx7mAc=;
        b=bH3lsdY1ATMZV0o9QdCNB+WbLjKhyGUOe14BxYAsGDPfHkTaVcPsmRmauO1pU0q0nb
         cWV4HWU2DxYOdOH97o6MYsJbEfIQMbhX4gLNfFYiI0h1GnJe3KgZC9naBWEvvrw/saRO
         dZJ7fCB2BsnxW9fILcffpdb0ApvSJSIIMSrmIWkp4qZgBcAh8KdEJFlnFpJi+7hRUG2C
         K19/P8U97JHWCJ9c4YXhd6tOGq/m85+DHwA4SaUGFmYmRcVG4ZwVZhrDFF4WMkqwYKc3
         CoSRN6GwLsD7q8s2Vh5ZdeLs8ZL/6iuK7A9yRsXXXFdiOcSm0ggOnVmRotSj+RjUYZEM
         +/DA==
X-Gm-Message-State: APjAAAXLqt7RFPywsRHpHfhA2u3GWUMBNp9mdANK6Yo6dYXZkLEJodqB
        fjJtS8B8CjyE23NmI+4hTyo=
X-Google-Smtp-Source: APXvYqxGFgSI6YXZhC0JfAaRU0VSaVFZ6L9DmCBdPMd6vHTk0lnpryAGiRzI/JEgV4ljg4Xo3P/Ogw==
X-Received: by 2002:a5d:6ccd:: with SMTP id c13mr20359407wrc.4.1566215588274;
        Mon, 19 Aug 2019 04:53:08 -0700 (PDT)
Received: from localhost.localdomain (ip5f5aef41.dynamic.kabel-deutschland.de. [95.90.239.65])
        by smtp.gmail.com with ESMTPSA id a23sm26105630wma.24.2019.08.19.04.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 04:53:07 -0700 (PDT)
From:   Krzysztof Wilczynski <kw@linux.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH] PCI: Fix misspelled words.
Date:   Mon, 19 Aug 2019 13:53:06 +0200
Message-Id: <20190819115306.27338-1-kw@linux.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix misspelled words in include/linux/pci.h, drivers/pci/Kconfig,
and in the documentation for Freescale i.MX6 and Marvell Armada 7K/8K
PCIe interfaces.  No functional change intended.

Related commit 96291d565550 ("PCI: Fix typos and whitespace errors").

Signed-off-by: Krzysztof Wilczynski <kw@linux.com>
---
 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt | 2 +-
 Documentation/devicetree/bindings/pci/pci-armada8k.txt   | 2 +-
 drivers/pci/Kconfig                                      | 2 +-
 include/linux/pci.h                                      | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
index a7f5f5afa0e6..de4b2baf91e8 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
@@ -50,7 +50,7 @@ Additional required properties for imx7d-pcie and imx8mq-pcie:
 - power-domains: Must be set to a phandle pointing to PCIE_PHY power domain
 - resets: Must contain phandles to PCIe-related reset lines exposed by SRC
   IP block
-- reset-names: Must contain the following entires:
+- reset-names: Must contain the following entries:
 	       - "pciephy"
 	       - "apps"
 	       - "turnoff"
diff --git a/Documentation/devicetree/bindings/pci/pci-armada8k.txt b/Documentation/devicetree/bindings/pci/pci-armada8k.txt
index 9e3fc15e1af8..1aaa09254001 100644
--- a/Documentation/devicetree/bindings/pci/pci-armada8k.txt
+++ b/Documentation/devicetree/bindings/pci/pci-armada8k.txt
@@ -11,7 +11,7 @@ Required properties:
 - reg-names:
    - "ctrl" for the control register region
    - "config" for the config space region
-- interrupts: Interrupt specifier for the PCIe controler
+- interrupts: Interrupt specifier for the PCIe controller
 - clocks: reference to the PCIe controller clocks
 - clock-names: mandatory if there is a second clock, in this case the
    name must be "core" for the first clock and "reg" for the second
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 2ab92409210a..46f4912a370d 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -170,7 +170,7 @@ config PCI_P2PDMA
 
 	  Many PCIe root complexes do not support P2P transactions and
 	  it's hard to tell which support it at all, so at this time,
-	  P2P DMA transations must be between devices behind the same root
+	  P2P DMA transactions must be between devices behind the same root
 	  port.
 
 	  If unsure, say N.
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 463486016290..5a89854bd3cb 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -961,7 +961,7 @@ resource_size_t pcibios_align_resource(void *, const struct resource *,
 				resource_size_t,
 				resource_size_t);
 
-/* Weak but can be overriden by arch */
+/* Weak but can be overridden by arch */
 void pci_fixup_cardbus(struct pci_bus *);
 
 /* Generic PCI functions used internally */
-- 
2.22.0

