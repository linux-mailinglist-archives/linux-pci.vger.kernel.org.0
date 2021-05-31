Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2D9396998
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jun 2021 00:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbhEaWN7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 May 2021 18:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232363AbhEaWN6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 May 2021 18:13:58 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15754C06174A;
        Mon, 31 May 2021 15:12:18 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 133so4184481pgf.2;
        Mon, 31 May 2021 15:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A93D3Jz/qTgixftb1ASsD8T5vX2ZHOxs7SEr20+q3E4=;
        b=HTLnK1XWJOcuYF3R+7sQnyXy23CUZ3FTl9vIaAzRylyOyYuZ/pHaPGo0oSyZ04i3uT
         bNqPOfNvw1vDI9q1dl7wGhCESH0zbF8BtGH7F36YPlA7Bh8mC8Xl5fpilxoR1y6IAgYC
         m7deMyiiwJQ5+2uL0oXn5OHWNrfnFxEsi2m2OsqtuGMZmFcCutR/SVl7/P+3LVbNotGe
         CmeD1YEQRaOPbRWSAyYYZ9WT3t37qmLwd1WHClkNBgG95xqMSzx5ylaY7rIucgruhb7l
         XX5FA+vgcdxRAEO2w8rMx5IoA7vJKSPE9yHDysSSnromn/hn7Vk5VDKJKwlXRFq6dH8o
         tBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A93D3Jz/qTgixftb1ASsD8T5vX2ZHOxs7SEr20+q3E4=;
        b=s/Cvo14fLu+iFuaOEiHbuJbwuhteIAOoczAE26PbNSxmNdbQBv9nNjwbPNBhwZeOb5
         SAGILlJaQPoPSRgDQGpGc+Z7+8Na1HGbXiHWkcprTlfbG4qJOAxK5O6iwt7FQqVwiu0X
         MedY1b+gLvvSqn1VYEYBnPCiPmb1pQsYxF2vmVsXHG5IM+KCy4ATVouFi4d7qcxXNbBR
         cKEIPCY/eUuhE0KJb95+qjTVQcWTgQyPejs7WHcq/VB42jKi24zSuvtdmzyER2SG3JC5
         PGEqv/FMwnkIXd6RnZxjAT+A2kvzbNBvaZlOyrpjcc08x8fORzh17/lfDCCNF6Y8ofmf
         MWgA==
X-Gm-Message-State: AOAM5304//lOJt5alU+DnY5okgiMwrwQOhhFL/PBWeK4VqzbjVl8HcVc
        Vf9zSZzXaQ9ErGb4x8VBxWSZBRM9lfShOg==
X-Google-Smtp-Source: ABdhPJzaxMK1rdEP8xfRiv9p/10iq31iiVonl5FIBWNHvWwP4NcZfSugseh8JaT+fbY0SyaMDE5SGg==
X-Received: by 2002:a63:5a19:: with SMTP id o25mr24462502pgb.122.1622499137637;
        Mon, 31 May 2021 15:12:17 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id j3sm11949637pfe.98.2021.05.31.15.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 15:12:17 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org
Cc:     Punit Agrawal <punitagrawal@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alexandru.elisei@arm.com, wqu@suse.com, robin.murphy@arm.com,
        pgwipeout@gmail.com, ardb@kernel.org, briannorris@chromium.org,
        shawn.lin@rock-chips.com, helgaas@kernel.org, robh+dt@kernel.org,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v2 4/4] arm64: dts: rockchip: Update PCI host bridge window to 32-bit address memory
Date:   Tue,  1 Jun 2021 07:10:57 +0900
Message-Id: <20210531221057.3406958-5-punitagrawal@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210531221057.3406958-1-punitagrawal@gmail.com>
References: <20210531221057.3406958-1-punitagrawal@gmail.com>
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

