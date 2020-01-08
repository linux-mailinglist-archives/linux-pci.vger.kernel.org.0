Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD8113479E
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2020 17:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729262AbgAHQWT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jan 2020 11:22:19 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45821 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729239AbgAHQWS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jan 2020 11:22:18 -0500
Received: by mail-wr1-f67.google.com with SMTP id j42so3961709wrj.12;
        Wed, 08 Jan 2020 08:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1ZZ17RtXPy8tSyIYbQsLgFSMBLvUQK+nBuSFJoACxY0=;
        b=vYz3CpTLbJuo6+9G79VOAWktV29RybG7tGXwN1AkTt4KNIxTvURD+Q3bhWx/SLX7BI
         so4VMbcEz0jii2m8R7tp/PnRHuC8vSpZSLx7i/dpzxOrSE3quOa7GyR02kpfRgdNjwPG
         r4vJdr3/92Y4+DcTp+7sUL3de1BBF+cnBHwzwQ4RejFqOD6BdXdsXGOG8b0kXeUAVj4l
         bQYnqNC+lu9uJRUw495+1nxGuAAtc+mDaeFQR5Y9W0vjJ9csh2lAPfQUQ0jnYACy+8ag
         WwYEueTRDa3tT4PkmcOorUbileEg77JVeaP4XwflNnBoeiRhwsN1LWFP7oAOriQwHfCZ
         RCCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1ZZ17RtXPy8tSyIYbQsLgFSMBLvUQK+nBuSFJoACxY0=;
        b=a0E5pY8esu7EV7ikcTp6K5j7ONJpM0VGTeXfWIrob7b+vK9GYdRGWoepJIkRvQmMRN
         KdddJeYXMc6FHGeIoBf/tgcpSVDJTO5qg9/1Q/ltae7beByvefqOUnf80Hg8EnHXWKaR
         2n2L2w4wPCIKqVg8Lp6JuK+DsqoMkhNrvIr6AzugidzFISdp3D4P1w4C8rc703b2BLZN
         rCg56PXg3zSnoE4ikDL1c4ryPR3XGDunPX7EaxcnV2NpGbDX6kuMKGQwOy8U7tDh2bZ1
         5tg5qXUuoQfAG5wA/fHR5+whL2OJroyiTAXo0VVAMv/GCk0ijMIsc68N7rlQsYsJizgB
         3yTg==
X-Gm-Message-State: APjAAAVMGExQAz0jxWxOnjaoC67sG8H/SS9Oaewm1ljOajxAHTe2ro/T
        irJDHeOgD7lMc6cgDkPVtOU=
X-Google-Smtp-Source: APXvYqx5YNjXAvzMMnnBbQbs3EDgieNZcQ06Hpx9SaPmwC7WO/tJ2xmpnfS4ZxX1IQC9CHcxSXE8GA==
X-Received: by 2002:a5d:6ca1:: with SMTP id a1mr5332087wra.36.1578500536305;
        Wed, 08 Jan 2020 08:22:16 -0800 (PST)
Received: from prasmi.home ([2a00:23c6:d18:6d00:2811:8b65:294e:fa09])
        by smtp.gmail.com with ESMTPSA id q3sm5112180wrn.33.2020.01.08.08.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 08:22:15 -0800 (PST)
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
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [v3 2/6] PCI: rcar: Fix calculating mask for PCIEPAMR register
Date:   Wed,  8 Jan 2020 16:22:07 +0000
Message-Id: <20200108162211.22358-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200108162211.22358-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20200108162211.22358-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The mask value was calculated incorrectly for PCIEPAMR register if the
size was less the 128bytes, this patch fixes the above by adding a check
on size.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pci/controller/pcie-rcar.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
index d5568db27efc..c76a92a8b72e 100644
--- a/drivers/pci/controller/pcie-rcar.c
+++ b/drivers/pci/controller/pcie-rcar.c
@@ -71,7 +71,7 @@ void rcar_pcie_set_outbound(int win, void __iomem *base,
 	/* Setup PCIe address space mappings for each resource */
 	resource_size_t res_start;
 	resource_size_t size;
-	u32 mask;
+	u32 mask = 0x0;
 
 	rcar_pci_write_reg(base, 0x00000000, PCIEPTCTLR(win));
 
@@ -80,7 +80,8 @@ void rcar_pcie_set_outbound(int win, void __iomem *base,
 	 * keeps things pretty simple.
 	 */
 	size = resource_size(res);
-	mask = (roundup_pow_of_two(size) / SZ_128) - 1;
+	if (size > 128)
+		mask = (roundup_pow_of_two(size) / SZ_128) - 1;
 	rcar_pci_write_reg(base, mask << 7, PCIEPAMR(win));
 
 	if (!host) {
-- 
2.20.1

