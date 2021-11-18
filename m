Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5153455D67
	for <lists+linux-pci@lfdr.de>; Thu, 18 Nov 2021 15:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbhKROJH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Nov 2021 09:09:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbhKROJH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Nov 2021 09:09:07 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9290C061570;
        Thu, 18 Nov 2021 06:06:06 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id h63so5382126pgc.12;
        Thu, 18 Nov 2021 06:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FA4eEA0vKwb58YOkbLP9K2NVmJYtwGLqPjb+iaCxg5k=;
        b=pvFZ0MRzAJrj8pt979HKbEHcM6RZZRo84yo77627EYv7H5wrgSzp+Tof5GsOgr6wmL
         DPAA5oSOmTX+Fz9oXY1GFjV6XxP3Csvm+jcu9V+6t0GXEPIpTIPxC1geB6HIdWwuNY4+
         sk5l4jsU1SifopQYlOtZLV/P7hdsHgV/2wh8F7PAJP6ZDNRNJ7N5pBGj3aK75YfFhZRZ
         GCJiIHMbk96TSg8nM0qOcdoXp3pcX5B9K16CH3HC+YiYhAI2ZWtytvT0NZWV5uq2bCW3
         zKdewD7ldn6cCDPa9jaZ4J++AeBybJbKcswV3mfPUtq+bCJ6Kj3bYaaYTlPv+vW4Ecze
         rKGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FA4eEA0vKwb58YOkbLP9K2NVmJYtwGLqPjb+iaCxg5k=;
        b=rbyJ/HfDcagt1dcCXRWx/an0sUjFh15SC+yggi4lSUnU9W+h8rFlBWATOvgGIJudWu
         McqfeuYxNX2mJVeo3LCaU7cvjZPsjNS+El16Y+/2t5qEGXpi79m/D5giPz0avm2rJdxH
         mTfzPjKh+RVlbEIF9f/E3mmD49tLOh/EyEhaodBKCv+tcFcF8e237VwKtyEQDE/9rTej
         mffyO6WVcJ8aP51Hv3bfcXnxQNFLdH0c4m9DsvBj8OXiaokPA9EDjJ+Jc97YZViHLHxn
         Ycu4830eZuTMioHfTS+eoFQO3dVfO6FfOyZZtXaKIHARa7PA4e5NRAixSVUMrgfWDoVc
         GAGw==
X-Gm-Message-State: AOAM532tfMUnMZ2n+fRF1vS/09DRxhOUVluypKTKDPfcJWn/NPkgs80z
        O0BpxMZzqqxyMmAS39lvKrk=
X-Google-Smtp-Source: ABdhPJyYmcR/6DtK9DVRdL5nij9z3SmJ2ySPLjdsrWeskedGCKj8rft+HErV7xfOCFlSXzH7EUe/EQ==
X-Received: by 2002:a65:5589:: with SMTP id j9mr11358991pgs.291.1637244366422;
        Thu, 18 Nov 2021 06:06:06 -0800 (PST)
Received: from localhost.localdomain ([2406:7400:63:2c47:5ffe:fc34:61f0:f1ea])
        by smtp.gmail.com with ESMTPSA id x14sm2822878pjl.27.2021.11.18.06.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 06:06:06 -0800 (PST)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, Shawn Guo <shawn.guo@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Subject: [PATCH v4 09/25] PCI: histb: Remove redundant error fabrication when device read fails
Date:   Thu, 18 Nov 2021 19:33:19 +0530
Message-Id: <7da7ea760abc5f85cad6e9b0d3e59eebd93f50d3.1637243717.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1637243717.git.naveennaidu479@gmail.com>
References: <cover.1637243717.git.naveennaidu479@gmail.com>
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
 drivers/pci/controller/dwc/pcie-histb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-histb.c b/drivers/pci/controller/dwc/pcie-histb.c
index 86f9d16c50d7..410555dccb6d 100644
--- a/drivers/pci/controller/dwc/pcie-histb.c
+++ b/drivers/pci/controller/dwc/pcie-histb.c
@@ -127,10 +127,8 @@ static int histb_pcie_rd_own_conf(struct pci_bus *bus, unsigned int devfn,
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(bus->sysdata);
 
-	if (PCI_SLOT(devfn)) {
-		*val = ~0;
+	if (PCI_SLOT(devfn))
 		return PCIBIOS_DEVICE_NOT_FOUND;
-	}
 
 	*val = dw_pcie_read_dbi(pci, where, size);
 	return PCIBIOS_SUCCESSFUL;
-- 
2.25.1

