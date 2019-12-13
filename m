Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCFE511DFC8
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2019 09:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfLMIsg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Dec 2019 03:48:36 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:39717 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbfLMIsg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Dec 2019 03:48:36 -0500
Received: by mail-pj1-f67.google.com with SMTP id v93so908588pjb.6;
        Fri, 13 Dec 2019 00:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0o2WJ0k/dFGgYEVYb9lTf6IgcR1UsXhdlPgkIAlPrXo=;
        b=o/MiNlBV3uFbxQ8l5rsULvY9OfMmoxiD0+Ojr2yUMDGOXKfUr1aQP2FtDnI/04RU9W
         OeW6jTavgoBI+fdF98xZt3NyfAgtEEnBL7HlKiq3zqvIxFCsdLR7gsaMkVZVrW6haAaI
         7wlEPq5VAFIVC4oMUhj3VUJhnnxXFiv5EGCGxdqT/z7Xel2tEAZ577OWJigyD1onNcoP
         W/9wUhOl2lRPSiq6WfXYmg6ThHpG5YDiydbQ6O/PHD5ST45vx0H4V+fKaqDaF3pJBi2D
         FYj/9ynztA1ftiXFZZo03heN1sj9mNLg1AwsOZHT8M75Q8w8r1WIS4mQ3VApakhVEUQ3
         T2JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0o2WJ0k/dFGgYEVYb9lTf6IgcR1UsXhdlPgkIAlPrXo=;
        b=cdX2HjK1aqlcU45FNbGKq1izuAYCECPWIBsGNw12otr8qoQ6gSz7Ht6gcSHxPMWGnD
         F/onzeAjThbeWwA0YAZsikL1PJ2nQFj24d7HlFJ9TeOpGBLIeC9cGOfhhy7X+AD7hqiP
         ZOOTQu5WLsfOqdE3LCG9BpydYxp0towhytwn/OhmkzHCPqlfwlELI0poE/+ulHWQID1B
         p7bOcgKjd9t6U5WrA3VlxqW8Vxz4XYRfaO5wTZ0mrFPiq3+Xj+NJvczMUb6aO8lcJX6k
         QoCoA0smJbjgY61haA6TUa64V6cCFquVhkNoA15i3jd9H91jr6B/hCaOxHIwf0pGgMwU
         dKnw==
X-Gm-Message-State: APjAAAV/HGKJFK29npudmesEUlUAFmnhWR6PzzClLIMzsOlIoZFFnWE7
        uOG14eU4JO+GTrjub542rlY=
X-Google-Smtp-Source: APXvYqx3CBPs5CiTHbJaTZiz/1F1M0U10K5CQO0kJsbSdQ5viEx76NO4a+RVs6U23XLqRUKHVyojOg==
X-Received: by 2002:a17:90a:28a1:: with SMTP id f30mr15310586pjd.77.1576226914896;
        Fri, 13 Dec 2019 00:48:34 -0800 (PST)
Received: from prasmi.domain.name ([103.219.60.167])
        by smtp.gmail.com with ESMTPSA id 68sm9985632pge.14.2019.12.13.00.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 00:48:34 -0800 (PST)
From:   Lad Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-pci@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Murray <andrew.murray@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Simon Horman <horms@verge.net.au>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [v2 4/6] dt-bindings: PCI: rcar: Add bindings for R-Car PCIe endpoint controller
Date:   Fri, 13 Dec 2019 08:47:46 +0000
Message-Id: <20191213084748.11210-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191213084748.11210-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20191213084748.11210-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>

This patch adds the bindings for the R-Car PCIe endpoint driver.

Signed-off-by: Lad, Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../devicetree/bindings/pci/rcar-pci-ep.txt        | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/rcar-pci-ep.txt

diff --git a/Documentation/devicetree/bindings/pci/rcar-pci-ep.txt b/Documentation/devicetree/bindings/pci/rcar-pci-ep.txt
new file mode 100644
index 0000000..7f0a97e
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/rcar-pci-ep.txt
@@ -0,0 +1,37 @@
+* Renesas R-Car PCIe Endpoint Controller DT description
+
+Required properties:
+	    "renesas,pcie-ep-r8a774c0" for the R8A774C0 SoC;
+	    "renesas,pcie-ep-rcar-gen3" for a generic R-Car Gen3 or
+				     RZ/G2 compatible device.
+
+	    When compatible with the generic version, nodes must list the
+	    SoC-specific version corresponding to the platform first
+	    followed by the generic version.
+
+- reg: base address and length of the PCIe controller registers.
+- outbound-ranges: outbound windows base address and length including the flags.
+- resets: Must contain phandles to PCIe-related reset lines exposed by IP block
+- clocks: from common clock binding: clock specifiers for the PCIe controller
+	 clock.
+- clock-names: from common clock binding: should be "pcie".
+
+Optional Property:
+- max-functions: Maximum number of functions that can be configured (default 1).
+
+Example:
+
+SoC-specific DT Entry:
+
+	pcie_ep: pcie_ep@fe000000 {
+		compatible = "renesas,pcie-ep-r8a774c0", "renesas,pcie-rcar-gen2";
+		reg = <0 0xfe000000 0 0x80000>;
+		outbound-ranges = <0xa 0x0 0xfe100000 0 0x000100000
+				   0xa 0x0 0xfe200000 0 0x000200000
+				   0x6 0x0 0x30000000 0 0x008000000
+				   0x6 0x0 0x38000000 0 0x008000000>;
+		clocks = <&cpg CPG_MOD 319>;
+		clock-names = "pcie";
+		power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
+		resets = <&cpg 319>;
+	};
-- 
2.7.4

