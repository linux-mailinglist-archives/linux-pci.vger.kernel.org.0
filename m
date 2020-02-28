Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C47F173BE8
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2020 16:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgB1PmZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Feb 2020 10:42:25 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35638 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727176AbgB1PmT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Feb 2020 10:42:19 -0500
Received: by mail-wm1-f67.google.com with SMTP id m3so3704022wmi.0;
        Fri, 28 Feb 2020 07:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hRkPExrL63331yWhoKi03csinXjXhPNQwWmMbM7w46o=;
        b=IO4EyAPn+xS3k3kXsj2p6D3mp+B71UwPYcFn/VwB6gUPmQz5tn+Ona5+GFFE9jVd7S
         xKejK+x/6KNw5awfV/txpxw3kSW3XBtsgsS/2A31Dc12V+TF1/YuCf0Umw6OEFqKjxI8
         NR/aDm3Zqpq6apW7gQogXtlpog1JiGHt/oGFGaakGNyX3Ermu87el+W5j2YCn/3tzmd/
         /QiFMyPPStLovPhlf6nx+IKdZ80eRSvoQzdoBJnwwN4s9vOwJH6AwBnzKBraPvYSFyWk
         cm1W4YjVDDzs1yaTQ3EFkx2Cp5nViqGmTOLfn8PbXZWyRAXSyxEu0Ch7MWJx0Zh6lKqu
         szvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hRkPExrL63331yWhoKi03csinXjXhPNQwWmMbM7w46o=;
        b=BowzVQerq5WGe2aRZzH1EJgjJsZawIVoqkLDXU1JcjaqkcHzgfjmI9GbtPxx2UkQ1s
         nzGpuqsD0hTP2cxBlC3UuP3lZHwUbXl4sXnrAa0AwOrF6ryoCIbO/9GADyQBEIWddYhx
         BtpqFDwpW/GNtxdbE+ba9aZNXiAOJMwSDkR61B4nkPVdcwlPGMd7HkbU0MzS+gODKXxF
         eLEL+kg+taiN1Rxge6xfWCh5uq6dgDOcdHvjp2yma2/NybG1zV5Nva7MIhz64eknB1tG
         EsVIUiGcALE0N/mB+NeK3Yf2GU4oq1jAw45JzpQstmjDD3wrYnzkx68B5y2CkbLS584u
         mH0g==
X-Gm-Message-State: APjAAAWHol5uiXrhJMMcBOyrcME5QZKDgwLYN082hqVMRNwaFPlE+wo3
        DTPQ+liPI+Iw/y5t687qtDI=
X-Google-Smtp-Source: APXvYqz/GzpMKjVbgeuIuiw7IadIFtmQ7Zb1hX5sTOTpT/zhw3XLGEkcEEHXB56OCUnevlwbKvibng==
X-Received: by 2002:a05:600c:218d:: with SMTP id e13mr5545446wme.102.1582904538161;
        Fri, 28 Feb 2020 07:42:18 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2510:d000:3855:fd13:6b76:a11b])
        by smtp.gmail.com with ESMTPSA id k16sm13355349wrd.17.2020.02.28.07.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 07:42:17 -0800 (PST)
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
Subject: [PATCH v5 7/7] misc: pci_endpoint_test: Add Device ID for RZ/G2E PCIe controller
Date:   Fri, 28 Feb 2020 15:41:22 +0000
Message-Id: <20200228154122.14164-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200228154122.14164-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20200228154122.14164-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

