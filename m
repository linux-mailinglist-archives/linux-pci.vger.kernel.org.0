Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1AA46B97A
	for <lists+linux-pci@lfdr.de>; Tue,  7 Dec 2021 11:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235397AbhLGKxH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Dec 2021 05:53:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235320AbhLGKxE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Dec 2021 05:53:04 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B47C061354;
        Tue,  7 Dec 2021 02:49:33 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id p18so10343883wmq.5;
        Tue, 07 Dec 2021 02:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MpmprtYs1zzkd2ypJgJU4YoRdsGFG26a01JTF8ywYGA=;
        b=XS341Y19MKcD014RAlf7vhzLHteYLhaMx+y1FgPtC6BGzQqCrCN65hGlts1CPfpzp0
         pkQF42lJWO7vYT4QleV/6LDLYV2aczQoms494d5Ok+LnC3Tl6OIzh3x6hAm8kLB2hTwG
         wAT4m6WBTESLxYEP9Xu2Rys94dX1d/SCv79oU2UmMDvv0QQcehrR7j7fGWGz6tiOobBA
         LxbAy4LwD/dIHCLtgyk3jsw3vRbinCxTJHFTUfLwp7sHJ+bMkI3at2GqVrnc/R9/Ol4g
         sWTrur0RJbwGzNHUotFzi/QrnGzaAIOr56UYJJHEEtx3g1wP3ArtsXPpB4TY1GwtDOJZ
         WhSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MpmprtYs1zzkd2ypJgJU4YoRdsGFG26a01JTF8ywYGA=;
        b=f1nEisDtdoorSOHBOPpzHOIhXMv/zY/AbEk3pCzbhf0VJps2M3ZhTKxST1tYGwJxOZ
         PlfKg5RfR+75rGnAPqyilEi+kyg0lU20PN1DgaNhYl1FKntqc6zWI0U5Rm9OZedPnz7g
         yUVGiiQvo4dgPjOxmagPmQCGcSVMxAPKkFZJECnUZYClm30Um1ZMvzZhgjWzqG3DpdFC
         8plDI9sWZLCFp06lZCGhVEHQAl4avUCL5zIw6DVCUjIBNLSb8skGfhoFiLfD+nhOqP1T
         C8VNn39cVt/gSIQjSIoqHx+xRx6FcNlCkEfXLHXuZOXdxCTOI4gAFDlG97DEXj+z3cYZ
         DuMQ==
X-Gm-Message-State: AOAM5305R119ZURv2hWeQs4pazsnBKNpP6zd4kS6cPTA46TLIQcjp+lH
        Iuv3pk7uygqDBxltbfsO03n2cCGyEx4=
X-Google-Smtp-Source: ABdhPJwChH48i3YCiJ/49kL/1E+g2zAMHxM5A9k1oQo3pkmhAQDXo/9DUwCGe5DCe2TtT0ckUZvLLw==
X-Received: by 2002:a05:600c:3541:: with SMTP id i1mr6279770wmq.124.1638874172126;
        Tue, 07 Dec 2021 02:49:32 -0800 (PST)
Received: from localhost.localdomain (27.red-83-54-181.dynamicip.rima-tde.net. [83.54.181.27])
        by smtp.gmail.com with ESMTPSA id z6sm13958561wrm.93.2021.12.07.02.49.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Dec 2021 02:49:31 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     tsbogend@alpha.franken.de, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, linux@roeck-us.net,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Yanteng Si <siyanteng@loongson.cn>
Subject: [PATCH v3 4/5] PCI: mt7621: Add missing 'MODULE_LICENSE()' definition
Date:   Tue,  7 Dec 2021 11:49:23 +0100
Message-Id: <20211207104924.21327-5-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211207104924.21327-1-sergio.paracuellos@gmail.com>
References: <20211207104924.21327-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

MT7621 PCIe host controller driver can be built as a module but there is no
'MODULE_LICENSE()' specified in code, causing a build error due to missing
license information.

ERROR: modpost: missing MODULE_LICENSE() in drivers/pci/controller/pcie-mt7621.o

Fix this by adding 'MODULE_LICENSE()' to the driver.

Fixes: 2bdd5238e756 ("PCI: mt7621: Add MediaTek MT7621 PCIe host controller driver")
Reviewed-by: Krzysztof Wilczyński <kw@linux.com>
Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 drivers/pci/controller/pcie-mt7621.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/pcie-mt7621.c b/drivers/pci/controller/pcie-mt7621.c
index 42cce31df943..9da7452f565e 100644
--- a/drivers/pci/controller/pcie-mt7621.c
+++ b/drivers/pci/controller/pcie-mt7621.c
@@ -561,3 +561,5 @@ static struct platform_driver mt7621_pci_driver = {
 	},
 };
 builtin_platform_driver(mt7621_pci_driver);
+
+MODULE_LICENSE("GPL v2");
-- 
2.33.0

