Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D176C42F5E6
	for <lists+linux-pci@lfdr.de>; Fri, 15 Oct 2021 16:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240535AbhJOOpb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Oct 2021 10:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236502AbhJOOpb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Oct 2021 10:45:31 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB711C061762;
        Fri, 15 Oct 2021 07:43:24 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id s136so5566766pgs.4;
        Fri, 15 Oct 2021 07:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E2kMW7De0WUTFR8R6pbmw+v+DfoEFjJfFZEPmx6TpIo=;
        b=eMtI6REOFWix9KtW5tFZKnYJASMZfWRLSZnk5Z3YHrAZfJHAzvFnr8ylXwPFqc2a/a
         sSZ8UvQq1tqytMA7xvcnnsiLWefZHtOIvyR4w48y0+/FL2UKgIHln+v2qE2m/w+JTFM1
         5/mXXW1NrvfbNEM0Kxme6uJJEBTs38ZYlbTHW6Re7rHSajvVurS8Uq1V2v4NCeWCfPhp
         0AMJSPYYm2sBLxJatPIFmiVJT/Oh5NHr53JmOewoMKlOnjkfBC7TBlY4MypeOeGa17pJ
         HGEAOs0d5LPR7Euvw8ZGAQvAt0r8Wbzm43Xw5FKSEaUKTN3vn6bLTxu6DfAsFds4nbK0
         6Xag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E2kMW7De0WUTFR8R6pbmw+v+DfoEFjJfFZEPmx6TpIo=;
        b=abcCKJ862rC3oxYZKPlpeogY3LHRU2KmvCQ5GGuOznL8frk1aDYPY8ctqrhDw73leE
         tVWdevuXeDkFRlasrJWbyw/kDJWltmM4z9fV4xMg4OI0652Vnmel++1w+a0hV1i6yyFn
         Rvk/mvJ0ofnbeX2ksOSNV6bGT2y6oHwIXXWdYC2ZhqSra5tozFF06JwG0T7Zp4HAJSd+
         eWdiA69B6gctj8MbHPPWvirwmWxUBpT+Ohl31Ew5GMMWm1hWjRJyeFxZb36sVu5gJOPp
         prYzXyZrE7qQegIFuzzY6MzKSVBdmTtcNWmkY7RTPBhVv9C5d+4CmblLJVTVmYBAsNnC
         8N7w==
X-Gm-Message-State: AOAM532jijJFWIhQjl/h+0JJ2/K0XYOWnsAaKu4oatljkZreCYF4/cS4
        z74ulerp4HXtCjUeZILsPtE=
X-Google-Smtp-Source: ABdhPJznv5Me0M33f8HkD/iBEPi7jNhXlMeZY3pyG0z8AuGV93euaOSAW3r29nVl5vtoWE0qzOFOmg==
X-Received: by 2002:a62:2f81:0:b0:44b:b390:956b with SMTP id v123-20020a622f81000000b0044bb390956bmr12110659pfv.30.1634309004189;
        Fri, 15 Oct 2021 07:43:24 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:4806:9a51:7f4b:9b5c:337a])
        by smtp.gmail.com with ESMTPSA id f18sm5293491pfa.60.2021.10.15.07.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 07:43:23 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org (open list:PCIE DRIVER FOR MEDIATEK),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support)
Subject: [PATCH v2 07/24] PCI: mediatek: Remove redundant error fabrication when device read fails
Date:   Fri, 15 Oct 2021 20:08:48 +0530
Message-Id: <4aa74ccd31c42b108b61f2ad274bae59a1d25114.1634306198.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1634306198.git.naveennaidu479@gmail.com>
References: <cover.1634306198.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

An MMIO read from a PCI device that doesn't exist or doesn't respond
causes a PCI error. There's no real data to return to satisfy the
CPU read, so most hardware fabricates ~0 data.

The host controller drivers sets the error response values (~0) and
returns an error when faulty hardware read occurs. But the error
response value (~0) is already being set in PCI_OP_READ and
PCI_USER_READ_CONFIG whenever a read by host controller driver fails.

Thus, it's no longer necessary for the host controller drivers to
fabricate any error response.

This helps unify PCI error response checking and make error check
consistent and easier to find.

Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/controller/pcie-mediatek.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 2f3f974977a3..a19f8ec5d392 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -365,19 +365,12 @@ static int mtk_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
 {
 	struct mtk_pcie_port *port;
 	u32 bn = bus->number;
-	int ret;
 
 	port = mtk_pcie_find_port(bus, devfn);
-	if (!port) {
-		*val = ~0;
+	if (!port)
 		return PCIBIOS_DEVICE_NOT_FOUND;
-	}
-
-	ret = mtk_pcie_hw_rd_cfg(port, bn, devfn, where, size, val);
-	if (ret)
-		*val = ~0;
 
-	return ret;
+	return mtk_pcie_hw_rd_cfg(port, bn, devfn, where, size, val);
 }
 
 static int mtk_pcie_config_write(struct pci_bus *bus, unsigned int devfn,
-- 
2.25.1

