Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A881B3918EF
	for <lists+linux-pci@lfdr.de>; Wed, 26 May 2021 15:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234263AbhEZNgu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 May 2021 09:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234231AbhEZNgt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 May 2021 09:36:49 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A892C061574;
        Wed, 26 May 2021 06:35:17 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id a7so631387plh.3;
        Wed, 26 May 2021 06:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F8dHlJ0lGaZ4wpJABZ5l0Lg6R0avpm3vrRyQsHumOeE=;
        b=epsWKguyEB98VsG4g5HiqVtaommrLsZL53nG6q0aN7yF5mJj0B/2cPn15+vS9HLNjQ
         uOUqzBaCc7DzRcE7UwwD/V8/culypfrKDsM37cyvTgNgbDtzTHWSrL8LDeVtn47gyftE
         b59vyfNQdRsjnneZWUU6y4Ir9Hy6wXzO8SJ67OX/9D29pXSk+lVJr1XIVZV1cNjh7JTd
         RfpTFJui1GUXo0nkuVCU250++QamJshEUlf7Ui6ygXT6jX2uu1GAeBscbIARb7uCgr9u
         +wPwTxWISZlSw0WvqHCFDkMYR1URvacMDOUnalfJ+9bdZU2uexdjI0LWXGoOopYjvD5Z
         hvXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F8dHlJ0lGaZ4wpJABZ5l0Lg6R0avpm3vrRyQsHumOeE=;
        b=MBdom0rXjEkKEgMdHkk07pVwmZEhQRi6cC6cJTmCW77U4rH3C/5HKOYKK0EiDAtfuT
         KZc39PLUcs9gZZyG7SU1WJy5n7ZTQDaGS/XxT0Glgyx3BZicwYJ1rQQ1pCJrrSaoy9Od
         HolM3tfnw6xnvu+Kd0OxQ1wIWVXOMpczbUowm8uR7M7xjJUL9lhOdFtSwyYMmJAXsADN
         HCaAuwAkISQNk8doUDJ2G1s9tDMEgLSqsN6T6a1fUn0PcNOdtflJywnk5jqAWr4Qer3G
         l4q4SdctekyFqrr0xOB9FfVTTMIrUH/ZshH9FUPBZxLrzqnD1/5VMC/vJTHNq2+yZRkn
         I9/g==
X-Gm-Message-State: AOAM532KzTf+17nXJMSyijW4bZ23WVDdjowKolaSH28kZ0wCkXXTrB5t
        iopT2M3Xr1GO4KK5vMzvmgs=
X-Google-Smtp-Source: ABdhPJzGn0Ut3JMzBSazvjKb8GN3035Bdop0143PDzTq0qfvM+JMplSl6F492wDKE5+6f14RKy3IsA==
X-Received: by 2002:a17:90a:9517:: with SMTP id t23mr3913586pjo.130.1622036116987;
        Wed, 26 May 2021 06:35:16 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id d18sm9301654pgm.93.2021.05.26.06.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 06:35:16 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     linux-rockchip@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alexandru.elisei@arm.com, wqu@suse.com, robin.murphy@arm.com,
        pgwipeout@gmail.com, ardb@kernel.org, briannorris@chromium.org,
        shawn.lin@rock-chips.com, linux-pci@vger.kernel.org,
        Punit Agrawal <punitagrawal@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH] arm64: dts: rockchip: Update PCI host bridge window to 32-bit address memory
Date:   Wed, 26 May 2021 22:34:57 +0900
Message-Id: <20210526133457.3102393-1-punitagrawal@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCIe host bridge on RK3399 advertises a single address range
marked as 64-bit memory even though it lies entirely below 4GB. While
previously, the OF PCI range parser treated 64-bit ranges more
leniently (i.e., as 32-bit), since commit 9d57e61bf723 ("of/pci: Add
IORESOURCE_MEM_64 to resource flags for 64-bit memory addresses") the
code takes a stricter view and treats the ranges as advertised in the
device tree (i.e, as 64-bit).

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
Hi,

The patch fixes the failure observed with detecting certain Samsung
NVMe drives on RK3399 based boards.

Hopefully, the folks on this thread can provide some input on the
reason the host bridge window was originally marked as 64-bit or if
there are any downsides to applying the patch.

Thanks,
Punit

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

