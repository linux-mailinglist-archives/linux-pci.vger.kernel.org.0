Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 454E039DB5B
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jun 2021 13:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbhFGLcP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Jun 2021 07:32:15 -0400
Received: from mail-pf1-f181.google.com ([209.85.210.181]:38806 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbhFGLcO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Jun 2021 07:32:14 -0400
Received: by mail-pf1-f181.google.com with SMTP id z26so12836807pfj.5;
        Mon, 07 Jun 2021 04:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H/Yt3X2SxGHabq+c62sPHm2CdmHzwbxXy3zXvTGn4O4=;
        b=ldrUEjrnpMhEVVxmlliYmACwqqm8IvzyyrQfhmAk1A6f9Su/OdpzkQSBVsgxvFPCM5
         gmXNlbuzGrSi47sfuyW/Sr/LapMRlUXY2WO91uQL3trreQOzg6abRzKeE0U96cVl+QYL
         s9c5/UlRESxzHcXUOwydNQ1aVaIb6/ftBY5tOORuq8nvbK71LgzR76wREqMhqb6BbaIw
         1jKMRPA31xU2/FsOVSnKC+O2W6+ixL1spxhtXwuB9KucDT/Gj2bTezmRK9a+vvpEf0p4
         XEEfnvTR8CrWN7hxigRzRDpM+3vX3+TRfDVZxjPe57eErtAUAlfaondGrvJ81N63D8Yt
         2J1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H/Yt3X2SxGHabq+c62sPHm2CdmHzwbxXy3zXvTGn4O4=;
        b=btm+wsE2gVWy6Aw8Ah85ZdmuRYZ2aP4sgN6soqPJ1iX3DoCN2801KqQS/5dz6SDkY7
         I+8uAQZcf//wtETG5l605vh+VP2gnpEoOMpOJdTa6L+3vzmGszTF5Ku+08NaWIJpQtSH
         7NFOx/S5+BgwZs77wQhs07CTm/cPnHFnqqDqwX/+wCcPQBS5xQ7Zok+oJSqGNjt6dWDm
         xApfCVYKNTRZh8T9mGBeYQzIAaa6L/IeA8CRNSsMBtsBTBlftFioGMRFVvYIRShDOQnO
         V8m6TtzKuaUy/AtcOrCmuqqXmfi8fxtFkXTNv1Y9fvXy4pQ0FC8vYsiqTaIkQaqDr8XX
         xpfQ==
X-Gm-Message-State: AOAM531dv/4evKv9YR/GaLtAQ44CAqa9qHdoj9ZEoKaMvDiQYmX4N9yi
        rFBfes82CRNdLJ5v7x73/P0=
X-Google-Smtp-Source: ABdhPJzZluhwYML3k2RzI64KyTnPU63QAHQCUn82ffdDDiH0PpVuJ0F+5G0pCsKr0rDDuVbI+qA6Yg==
X-Received: by 2002:aa7:9515:0:b029:2e9:c6f4:2c44 with SMTP id b21-20020aa795150000b02902e9c6f42c44mr17038239pfp.28.1623065363761;
        Mon, 07 Jun 2021 04:29:23 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id e17sm7950720pfi.131.2021.06.07.04.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 04:29:23 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     helgaas@kernel.org, robh+dt@kernel.org
Cc:     Punit Agrawal <punitagrawal@gmail.com>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, alexandru.elisei@arm.com, wqu@suse.com,
        robin.murphy@arm.com, pgwipeout@gmail.com, ardb@kernel.org,
        briannorris@chromium.org, shawn.lin@rock-chips.com,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v3 4/4] arm64: dts: rockchip: Update PCI host bridge window to 32-bit address memory
Date:   Mon,  7 Jun 2021 20:28:56 +0900
Message-Id: <20210607112856.3499682-5-punitagrawal@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210607112856.3499682-1-punitagrawal@gmail.com>
References: <20210607112856.3499682-1-punitagrawal@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCIe host bridge on RK3399 advertises a single 64-bit memory
address range even though it lies entirely below 4GB.

Previously the OF PCI range parser treated 64-bit ranges more
leniently (i.e., as 32-bit), but since commit 9d57e61bf723 ("of/pci:
Add IORESOURCE_MEM_64 to resource flags for 64-bit memory addresses")
the code takes a stricter view and treats the ranges as advertised in
the device tree (i.e, as 64-bit).

The change in behaviour causes failure when allocating bus addresses
to devices connected behind a PCI-to-PCI bridge that require
non-prefetchable memory ranges. The allocation failure was observed
for certain Samsung NVMe drives connected to RockPro64 boards.

Update the host bridge window attributes to treat it as 32-bit address
memory. This fixes the allocation failure observed since commit
9d57e61bf723.

Reported-by: Alexandru Elisei <alexandru.elisei@arm.com>
Link: https://lore.kernel.org/r/7a1e2ebc-f7d8-8431-d844-41a9c36a8911@arm.com
Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
Tested-by: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh+dt@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 634a91af8e83..4b854eb21f72 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -227,7 +227,7 @@ pcie0: pcie@f8000000 {
 		       <&pcie_phy 2>, <&pcie_phy 3>;
 		phy-names = "pcie-phy-0", "pcie-phy-1",
 			    "pcie-phy-2", "pcie-phy-3";
-		ranges = <0x83000000 0x0 0xfa000000 0x0 0xfa000000 0x0 0x1e00000>,
+		ranges = <0x82000000 0x0 0xfa000000 0x0 0xfa000000 0x0 0x1e00000>,
 			 <0x81000000 0x0 0xfbe00000 0x0 0xfbe00000 0x0 0x100000>;
 		resets = <&cru SRST_PCIE_CORE>, <&cru SRST_PCIE_MGMT>,
 			 <&cru SRST_PCIE_MGMT_STICKY>, <&cru SRST_PCIE_PIPE>,
-- 
2.30.2

