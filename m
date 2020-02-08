Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 452EC1566D3
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2020 19:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbgBHShH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 8 Feb 2020 13:37:07 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54527 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728237AbgBHShG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 8 Feb 2020 13:37:06 -0500
Received: by mail-wm1-f66.google.com with SMTP id g1so5698979wmh.4;
        Sat, 08 Feb 2020 10:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hRkPExrL63331yWhoKi03csinXjXhPNQwWmMbM7w46o=;
        b=UEC0UpG2p14iHJSU4WkX6eWFx9d1ZrjGwMix75y6gn4mB9vo2Bz6OdbOAiTVnDFNdA
         kHaNYBVtSdWUb18uYt8Re2C4VmqtY2KceHrDEzhVTPz56EF+OLyaOorEsPkZsK9Nbsd6
         wz64iQkTrWLpcoNNc8Hn5TUKkPQonvA/P8nBTKbRvODetvF85EV4PPhEnGa7/GYjmZaY
         x2l6XgCInciUapSaXHUipQ+PN6LW3H+ypy/b0/gIKCUXccGDLWT52kK2XyAd0wDY7STv
         CILOQSijsDnx98PqipPyD/awNKYdaLa1audtC62ntVJ0kHpwpvk3ufeHtzE6Lov0Tojl
         LDaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hRkPExrL63331yWhoKi03csinXjXhPNQwWmMbM7w46o=;
        b=s3/AP4Ajs79BJwVjIeZIpDhSxubXXclIw7Uy+uX4c7L/WvxuEFZhuVls4ecIPoZZsk
         /3K65NlI660iBHc2yJ4R35kbTaRN1Rdo/kctRDEVLZ8o6Hr3REqx+GLZQ2OcNCxNh3Pv
         vQV4Vj8ISglyhIhvxRlx70V5WkPqtlITjc/CJfYbdwc1EEX3uWu90GEfvCOAVj6a+ozE
         vZeSpaokMIM+uQfpnO+w+riMBvZvryQp5UzAgyb0szx53kCCy7PBhaTJ6wbGzo779onQ
         fhEYl+u3qFnklBmsfftrNtXulzt5lXHoEtucOi6OU1QZ3dZTsck8NHzpNQENGDUYYj6x
         KreA==
X-Gm-Message-State: APjAAAVVgMU9PJSxedrl7d2U0LKQkc0YZ8wmLAgM/zWVkC9vwydVWykl
        JVbBeBPztqnoauleFgZY41k=
X-Google-Smtp-Source: APXvYqwFu7OC7ixOqiSrg18we1AFkhBXmQoqPIvj66lfI/PTesneFDIRfoJbBRYAkWP5qo2AT7T7xQ==
X-Received: by 2002:a1c:3b09:: with SMTP id i9mr5239091wma.31.1581187023994;
        Sat, 08 Feb 2020 10:37:03 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2510:d000:a553:90a1:93f5:e306])
        by smtp.gmail.com with ESMTPSA id b67sm8404385wmc.38.2020.02.08.10.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2020 10:37:03 -0800 (PST)
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
Subject: [PATCH v4 6/6] misc: pci_endpoint_test: Add Device ID for RZ/G2E PCIe controller
Date:   Sat,  8 Feb 2020 18:36:41 +0000
Message-Id: <20200208183641.6674-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200208183641.6674-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20200208183641.6674-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add RZ/G2E in pci_device_id table so that pci-epf-test can be used for
testing PCIe EP in RZ/G2E.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/misc/pci_endpoint_test.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index a5e3170..3c84e9a 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -66,6 +66,8 @@
 
 #define PCI_DEVICE_ID_TI_AM654			0xb00c
 
+#define PCI_DEVICE_ID_RENESAS_RZG2E		0x002d
+
 #define is_am654_pci_dev(pdev)		\
 		((pdev)->device == PCI_DEVICE_ID_TI_AM654)
 
@@ -797,6 +799,7 @@ static const struct pci_device_id pci_endpoint_test_tbl[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_AM654),
 	  .driver_data = (kernel_ulong_t)&am654_data
 	},
+	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_RZG2E) },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, pci_endpoint_test_tbl);
-- 
2.7.4

