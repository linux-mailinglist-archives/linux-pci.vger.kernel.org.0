Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C45671566C8
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2020 19:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbgBHSg5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 8 Feb 2020 13:36:57 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42115 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727964AbgBHSg4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 8 Feb 2020 13:36:56 -0500
Received: by mail-wr1-f68.google.com with SMTP id k11so2666564wrd.9;
        Sat, 08 Feb 2020 10:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KjY0ZxPgA8xDdI4P8UFFhtICRDQWXvSYtBAZooAhylM=;
        b=Ug6trja9jfyujkI7OOVeJvqVNOFLdsZkvVDlOHWng8rLWSgGZC7IcBQBT6XtFCgbBA
         U+Ijyf1DornRokrSN6El65xgvgpYfUFrbtFZTBxAHtdeuVZ0QH79GeZMqoKe6uyUUElr
         tJ3jBOAkYMrmE9iJBl9e9rqx0jMEI6Pt/LGD9hDHsRrugAj2zfJmRYL6qoDfoMHxNgIe
         lbjjxYYEn1uA8xgnvR6LsGGlvEPs6wnDqIqKqzIOSDDYY0UHSW/T661hq0ufNVJicayr
         woY8m+UU8c7fdXhhjto6pDPpsMTFVKUcOqUtJ1kt47NzomDZiC/Kw4ZwUaP14QF20Lz9
         wNEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KjY0ZxPgA8xDdI4P8UFFhtICRDQWXvSYtBAZooAhylM=;
        b=Q0oV/8y5VW+EBS5dNZa2NsJqQsNPOQVgu41O2YNHHwVunt9THyx4wyZyYmTv01NnpZ
         /vSr/AGmhxOHfLrtUzxdEtI5/Kit4orJCG3fZAeR6k6Y5Zas5BUpobzM7uCmwpXkBGyT
         BxhHt2baR8jNaRqFG7Vw8udSLj7YHtqw6zcrB57I178r8x76lOTLMX823W0oQHyCu4Ew
         Rqdj4xGtsRgJGOgdBQRcnSJ4hZdEy+XkyN8D+hcsdNRg7jD9Hsd7PgDD33hjxU0cvLCw
         7KAq2WbVkt5bL51cOjGxXyX/tPxDihsH9ngMooxQNF7UqAaf5Hcd/kkHvh06D+mvcvlF
         RwAA==
X-Gm-Message-State: APjAAAXMomzUdjPHkoGkdZh1EC5jk+y2V2GNQualJgbWjqbGnvwPgj1s
        riQePqaKWH81sWqiY2w9hfY=
X-Google-Smtp-Source: APXvYqxIu6atAePt2heYHf7buiIaKkoy/ZjBtwOXRU6/ElHpeC9rstK/20wPHyjKhEeZtut77LTr3w==
X-Received: by 2002:a5d:6284:: with SMTP id k4mr6541427wru.398.1581187014097;
        Sat, 08 Feb 2020 10:36:54 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2510:d000:a553:90a1:93f5:e306])
        by smtp.gmail.com with ESMTPSA id b67sm8404385wmc.38.2020.02.08.10.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2020 10:36:53 -0800 (PST)
From:   Lad Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Andrew Murray <andrew.murray@arm.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v4 2/6] PCI: rcar: Fix calculating mask for PCIEPAMR register
Date:   Sat,  8 Feb 2020 18:36:37 +0000
Message-Id: <20200208183641.6674-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200208183641.6674-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20200208183641.6674-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
index d5568db..c76a92a 100644
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
2.7.4

