Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78ABD2E8027
	for <lists+linux-pci@lfdr.de>; Thu, 31 Dec 2020 13:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgLaM5Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 31 Dec 2020 07:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbgLaM5Z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Dec 2020 07:57:25 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD680C061799
        for <linux-pci@vger.kernel.org>; Thu, 31 Dec 2020 04:56:44 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id y19so43728298lfa.13
        for <linux-pci@vger.kernel.org>; Thu, 31 Dec 2020 04:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0fBv2gpwapqGxc4UK93YsXY43KDSuwDEMOo2qzk7zYQ=;
        b=cacK2IEW77bys+SQJVCBhRtYkSAF0cwGhG3GelH7XRMPehnLWlQClM9v5WDgj7a2ox
         xTNDJaU0h1iBZ/x/oQKWFzqNppks2r62ysNcyEXYlPKJFPu1rxhPgcHtWKzZDU2uhuAz
         HEERNFCx7hETSdItud9NdD7Rdvos/vjHKnmbfcVBtZgXO4GtdlOrEP8FyqzPA7GovKPt
         oLTiqpfSUgMscXfOdIAtbhAGeP7KoA+xCNFlq1iH0L6ywM2l1SG66RJbC91R1FkQ3rIw
         DrMVhZe58RDlHpnxEcFgprPJrGLztGkimnkdBUYPIzFQ9QN9lykdwprxqYjs3ecA4Z/J
         gxdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0fBv2gpwapqGxc4UK93YsXY43KDSuwDEMOo2qzk7zYQ=;
        b=eUeBAe320A0LyWPvmp11AkC4sgYAsHA6ztfmjO+rRwYSpQxWNRcJ6GjFvC96QzHGXx
         BTOvrleGdt4XUwZqzy5X9DXf34Cs2oLkNcHHnY5hZcWNAstCuh+B9Yf1pWi5itOABtZj
         m5xEIrZmn19IntDFYrBSf27w1lgCtEA6n4Ag4FIWNeP2y42sf3v1qvM6d7R9fCgI1ugm
         5UFpTdgXcEapNKOqZpmXVNm1BsK8oDdQfkxHGnIdsu8WuNW4R2+60Z7ohzDw5caIFB+B
         CjOEasYq2Dltdd8uyfljxeE0Q4N47Fi5CHOjan4raY90BT6hgQGrIPefE9G1dgkAEnfg
         nq9Q==
X-Gm-Message-State: AOAM533KrYF+K3STcJ9ofOnXXERqZuoOP9r8564g2Cf/6iZT/5p4RAhC
        WQ6GUmge44yHf1O+YAyw6PforcnSJ9QGfQ==
X-Google-Smtp-Source: ABdhPJytSeX7EP+EU6g5Sis28jEYMyZJYLpLxGKAemzBn5XLYv0gEYWx4YEFfQ/33Dzzrm2KvqU3/A==
X-Received: by 2002:a05:651c:11c4:: with SMTP id z4mr29662150ljo.443.1609419403419;
        Thu, 31 Dec 2020 04:56:43 -0800 (PST)
Received: from localhost.localdomain (85-76-98-107-nat.elisa-mobile.fi. [85.76.98.107])
        by smtp.gmail.com with ESMTPSA id r201sm6230659lff.268.2020.12.31.04.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 04:56:42 -0800 (PST)
From:   =?UTF-8?q?Jari=20H=C3=A4m=C3=A4l=C3=A4inen?= <nuumiofi@gmail.com>
To:     Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     =?UTF-8?q?Jari=20H=C3=A4m=C3=A4l=C3=A4inen?= <nuumiofi@gmail.com>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [RFC PATCH 2/3] dt-bindings: PCI: rockchip: document bus-scan-delay-ms workaround property
Date:   Thu, 31 Dec 2020 14:52:13 +0200
Message-Id: <20201231125214.25733-3-nuumiofi@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201231125214.25733-1-nuumiofi@gmail.com>
References: <20201231125214.25733-1-nuumiofi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

New "rockchip,bus-scan-delay-ms" property can be used to set a delay
before PCIe bus scan as a workaround for some problematic devices causing
a crash in bus scan.

Signed-off-by: Jari Hämäläinen <nuumiofi@gmail.com>
---
 Documentation/devicetree/bindings/pci/rockchip-pcie-host.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/rockchip-pcie-host.txt b/Documentation/devicetree/bindings/pci/rockchip-pcie-host.txt
index af34c65773fd..394bdf562d58 100644
--- a/Documentation/devicetree/bindings/pci/rockchip-pcie-host.txt
+++ b/Documentation/devicetree/bindings/pci/rockchip-pcie-host.txt
@@ -57,6 +57,8 @@ Optional Property:
 	using 24MHz OSC for RC's PHY.
 - ep-gpios: contain the entry for pre-reset GPIO
 - num-lanes: number of lanes to use
+- rockchip,bus-scan-delay-ms: delay before PCIe bus scan in milliseconds.
+	Provides a workaround for some devices causing a crash in bus scan.
 - vpcie12v-supply: The phandle to the 12v regulator to use for PCIe.
 - vpcie3v3-supply: The phandle to the 3.3v regulator to use for PCIe.
 - vpcie1v8-supply: The phandle to the 1.8v regulator to use for PCIe.
@@ -106,6 +108,7 @@ pcie0: pcie@f8000000 {
 		 <&cru SRST_PCIE_PM>, <&cru SRST_P_PCIE>, <&cru SRST_A_PCIE>;
 	reset-names = "core", "mgmt", "mgmt-sticky", "pipe",
 		      "pm", "pclk", "aclk";
+	rockchip,bus-scan-delay-ms = <1100>;
 	/* deprecated legacy PHY model */
 	phys = <&pcie_phy>;
 	phy-names = "pcie-phy";
-- 
2.29.2

