Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7D73931DA
	for <lists+linux-pci@lfdr.de>; Thu, 27 May 2021 17:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236943AbhE0PKP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 May 2021 11:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236876AbhE0PJc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 May 2021 11:09:32 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E60C06138B;
        Thu, 27 May 2021 08:07:07 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id g24so616207pji.4;
        Thu, 27 May 2021 08:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A93D3Jz/qTgixftb1ASsD8T5vX2ZHOxs7SEr20+q3E4=;
        b=MMSdCu4bncyrpLvqO7+fLJ6ChGKSZ5Ya1+Xd4ofCq3UiwKYE+KO+bOl9v8i84CLqC9
         TbLSMWZLbSjywtbwyd37YAUmEn08KrG5xBOS0+P+9r9TrEpulg4E44QJ/XeQ98e0wNoM
         SThgxcuVH5J0CUUz/QKg/8AQ15DK5HiRNZz7EGYH5KcoCF7EV+XicDXTZmHGbs3NWOrY
         3sULIZxK/fnlEV8zdDiTt3r/lIj/z8m4/v02Jj6Q45sp4aWMr599psEF3y5La/XElZ7k
         X4j5yel/B4Vk9rYcViRqDf5QzMc4fWPK095yJXuPRsptKJ9jw65w7AYQgJdf2goMpURa
         NRAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A93D3Jz/qTgixftb1ASsD8T5vX2ZHOxs7SEr20+q3E4=;
        b=TcH7Y1x4m/QbnCOyxuXfEEQ1lkTHntLHg3NmT1HMde8RZftlM1MFbmDxnWaJ/qKGpu
         50rAs6eIKyC9eMKtkTmAr6Qt23H7LG/0joNuGL/tTyznmMERCc3S0VK/B0+8lYYOC1kG
         YcgvrI5GAud9kI2Kwj8kvzWFlHGv0Z1s5LwumF4xSwGHIVaqFkVdk9vZc2TbwAlM7jvo
         8g7kEK68sNJUTzUUX6reuDhf76YgYz1CoA4gZ32XRlUcbMhDmQ6jX8W6kzWFnZ8MeQ/3
         3wZUl6AtIn2ZyP4Pe2FZJe1O5dINPTi3q92CYLLJDRx8bUVdQXFnDR77imN/JD1rP+Tj
         QAPQ==
X-Gm-Message-State: AOAM533rzPtI/4niHm7g/o+K7de5wfb60kW4l2YxKLdYtBi/rwRg8xiP
        +2iLuPGqf8Xj/4BFyoSmc2Y=
X-Google-Smtp-Source: ABdhPJy0RolUbT16u5ASs6Qv4vTKJXckg5XvCboep7q0O8magnGUidJHGWe4kmXXIVxjYqFf+MFpPw==
X-Received: by 2002:a17:90a:ac12:: with SMTP id o18mr9969025pjq.65.1622128027426;
        Thu, 27 May 2021 08:07:07 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id t12sm2255790pjw.57.2021.05.27.08.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 08:07:06 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org
Cc:     Punit Agrawal <punitagrawal@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alexandru.elisei@arm.com, wqu@suse.com, robin.murphy@arm.com,
        pgwipeout@gmail.com, ardb@kernel.org, briannorris@chromium.org,
        shawn.lin@rock-chips.com, helgaas@kernel.org, robh+dt@kernel.org,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 2/2] arm64: dts: rockchip: Update PCI host bridge window to 32-bit address memory
Date:   Fri, 28 May 2021 00:05:42 +0900
Message-Id: <20210527150541.3130505-3-punitagrawal@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210527150541.3130505-1-punitagrawal@gmail.com>
References: <20210527150541.3130505-1-punitagrawal@gmail.com>
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

