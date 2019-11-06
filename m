Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0456AF1EF7
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2019 20:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732137AbfKFTgf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Nov 2019 14:36:35 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45354 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732033AbfKFTgf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Nov 2019 14:36:35 -0500
Received: by mail-wr1-f68.google.com with SMTP id h3so122492wrx.12;
        Wed, 06 Nov 2019 11:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gj4RT4MBYSN72SobANamHwk9q8SqC3Bq4JtqR0nv/88=;
        b=ith+FyjYfh++cNpEYyESkqNV2WQG2t3qx5/9OTWj8CcQ8Tx0Ho4mS7TB2wAukxmMe1
         7w1KaKYooUfTUzPilS4Ailr9wwDmnAcwo9ZZCy9sAriE04kPtwxxW3z9uWgnRoZX08Aq
         QUFk0IjDpdNvxtyLOafBA9zK4Ucrq51PpczFdg6kZiTtckcTpTW+C7hI+CuTyRm4IwlQ
         /uTdIMeNVtt4/nrlEX8ZEt93K4LkPcbMJ7YCO21Fi0JY+L09txnvnTj1MJF8HxN8MheH
         /WRvhJKv2WKkb71culGvsEj0lMsaKFJ4n7NGNVBk5r5TImn664O6vDBtcsK81V05I6M7
         AQ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gj4RT4MBYSN72SobANamHwk9q8SqC3Bq4JtqR0nv/88=;
        b=CIJB0eAf3iflgXSc3M4z2BRqiy1Zo9HOTjFt0ebGwm205EMzzYPi2NULokAVboZAUT
         Uu3VQc87wXI8qYSiryVCB2iQkZ+TSq1QVp/26kpY+3Sp63XShMsEgDNy048mRWE2FLCu
         +TnJ684fpl13WN1aYbi9D9PcMPwVISGl2LVfCadFKuTT5bgqhmx4bFGIGmtLgNNpuKVc
         82NWLql1HMYlg3jZODHqsPDV33l1g6jA/sXHkoB+WQAArfwqi5dYsXVqRBBZZ/h5dRLb
         fbc3BJYvCyHwUFlckUwZVK+Ot+wMx5p74rLd4WJFJl0VmPIjac/JfWMxtGgbQyK/r3dO
         WQRg==
X-Gm-Message-State: APjAAAUbkMataFKz3Ht5ew0cKRH3Cjs1iQqNsbysOaIWrKfhV6RFMgAT
        lO02yveHRcTs+UsSF1oRHZo=
X-Google-Smtp-Source: APXvYqz9azLA+Dqz04lPNS8MBMy2mPkTQxd5aWdoJYpBB9Skkh0PrDAauvRn05Sa0YLfoJ0/etRUzA==
X-Received: by 2002:a5d:4e90:: with SMTP id e16mr4567362wru.224.1573068992127;
        Wed, 06 Nov 2019 11:36:32 -0800 (PST)
Received: from prasmi.home ([2a00:23c6:d18:6d00:1d3d:daa8:4e74:8240])
        by smtp.gmail.com with ESMTPSA id 76sm4311737wma.0.2019.11.06.11.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 11:36:31 -0800 (PST)
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
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 3/5] PCI: rcar: Add R-Car PCIe endpoint device tree bindings
Date:   Wed,  6 Nov 2019 19:36:07 +0000
Message-Id: <20191106193609.19645-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191106193609.19645-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20191106193609.19645-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
 .../devicetree/bindings/pci/rcar-pci-ep.txt   | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/rcar-pci-ep.txt

diff --git a/Documentation/devicetree/bindings/pci/rcar-pci-ep.txt b/Documentation/devicetree/bindings/pci/rcar-pci-ep.txt
new file mode 100644
index 000000000000..b8c8616ca007
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/rcar-pci-ep.txt
@@ -0,0 +1,43 @@
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
+- reg: Five register ranges as listed in the reg-names property
+- reg-names: Must include the following names
+	- "apb-base"
+	- "memory0"
+	- "memory1"
+	- "memory2"
+	- "memory3"
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
+		compatible = "renesas,pcie-r8a7791", "renesas,pcie-rcar-gen2";
+		reg = <0 0xfe000000 0 0x80000>,
+			<0x0 0xfe100000 0 0x100000>,
+			<0x0 0xfe200000 0 0x200000>,
+			<0x0 0x30000000 0 0x8000000>,
+			<0x0 0x38000000 0 0x8000000>;
+		reg-names = "apb-base", "memory0", "memory1", "memory2", "memory3";
+		clocks = <&cpg CPG_MOD 319>;
+		clock-names = "pcie";
+		power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
+		resets = <&cpg 319>;
+	};
-- 
2.20.1

