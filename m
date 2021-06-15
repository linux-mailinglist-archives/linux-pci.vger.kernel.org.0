Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E40B3A8948
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jun 2021 21:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbhFOTQj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Jun 2021 15:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbhFOTQi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Jun 2021 15:16:38 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B6FC061574;
        Tue, 15 Jun 2021 12:14:34 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 13-20020a17090a08cdb029016eed209ca4so276851pjn.1;
        Tue, 15 Jun 2021 12:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uorcgZXlgqJQcGsdoYZaoV5DX2P7q/2KdrcuQbDRB/0=;
        b=jw6lzZnCGdUya6JfGU0QecPnq5KIND1/KNNBuz9GepBrkruH9DqzaDfoT7TsjuJC4/
         jhMYjv/5rzuaWy/cJqYOVVfZZvUJZSsezFzDvfrJfvxpNLJPISnkjn0pf2mfdATilXzs
         LnaHALRG3fBxpDAPNkS0EM6DunIBQy9Xf22nBMrCz4pqgKN+B6kzgYiBT6CWKQe0mJVv
         YSdUKs11YE9ZYjjpWEmn16mCKEEIPF3SlHu3xiDmK/a/leoMIWZk0sT6NhmJkyEzjvxG
         M/9quwjKnK3sTZ9vN7KIEdTyAy/OAXo8Y8yvCOovfcmfLGqDmCKE1oX61QbjteSNcMnk
         b4gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uorcgZXlgqJQcGsdoYZaoV5DX2P7q/2KdrcuQbDRB/0=;
        b=sr/OpGY8KteVWheK0qFYUe4Nd2HFP0HcaLRsmjfOLZqSiTxcRZSDS56zaN7v1tEcq2
         6e/sZW5JOLw72c7vBRr8R0CtQenm2vNNDf50cNVQDXmKyOeJrWIMbehQc52IG++ziPpJ
         RSob2k58f8AnMSxxjiw8XPe3PJiWuh4AZQ7zUqVayLc3gRd7MdpTtQskzC+4Rhy5qquQ
         5IuKhjDfPhRvqXLl0VHpIyDX1SBrh7MK2rGfdCodSZQEtRI49C3rZipob4oFd4wcIUgv
         QdGkazyYL9smxcS4XvOngdAyRwZdL8vNNm/Fzomwhryd11TC9CytChotNTKjM0AYizkr
         0TAQ==
X-Gm-Message-State: AOAM533xjDbPbKhZNiOW833Tk8myziqbTS3EOryu4D3a0uPHvgfh+iDy
        uMkuMYCbLplpVLblQaSVA9gh+gHFuVNieg==
X-Google-Smtp-Source: ABdhPJzGtvGuoKoVV6S8/vTL6PuoFi3mXD9AFM4nY55kFTDRu2WD/SFf+JV/rENW1efmmWLvgeREIg==
X-Received: by 2002:a17:90a:708a:: with SMTP id g10mr6650326pjk.108.1623784473569;
        Tue, 15 Jun 2021 12:14:33 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id j4sm3165008pjv.7.2021.06.15.12.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 12:14:33 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/3] PCI: brcmstb: Give 7216 SOCs their own config type
Date:   Tue, 15 Jun 2021 15:14:03 -0400
Message-Id: <20210615191405.21878-3-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210615191405.21878-1-jim2101024@gmail.com>
References: <20210615191405.21878-1-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This distinction is required for an imminent commit.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index abc62a86d94e..51ce51a6cb61 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -257,6 +257,13 @@ static const struct pcie_cfg_data bcm2711_cfg = {
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
 };
 
+static const struct pcie_cfg_data bcm7216_cfg = {
+	.offsets	= pcie_offset_bcm7278,
+	.type		= BCM7278,
+	.perst_set	= brcm_pcie_perst_set_7278,
+	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_7278,
+};
+
 struct brcm_msi {
 	struct device		*dev;
 	void __iomem		*base;
@@ -1227,7 +1234,7 @@ static const struct of_device_id brcm_pcie_match[] = {
 	{ .compatible = "brcm,bcm4908-pcie", .data = &bcm4908_cfg },
 	{ .compatible = "brcm,bcm7211-pcie", .data = &generic_cfg },
 	{ .compatible = "brcm,bcm7278-pcie", .data = &bcm7278_cfg },
-	{ .compatible = "brcm,bcm7216-pcie", .data = &bcm7278_cfg },
+	{ .compatible = "brcm,bcm7216-pcie", .data = &bcm7216_cfg },
 	{ .compatible = "brcm,bcm7445-pcie", .data = &generic_cfg },
 	{},
 };
-- 
2.17.1

