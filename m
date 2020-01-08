Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA81A1347B1
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2020 17:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729436AbgAHQWX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jan 2020 11:22:23 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50209 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729422AbgAHQWX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jan 2020 11:22:23 -0500
Received: by mail-wm1-f67.google.com with SMTP id a5so3144703wmb.0;
        Wed, 08 Jan 2020 08:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aBpKzW0DysSlCqpBbIOQ7IwtG+vQDqbV9o/9aw4xq+E=;
        b=sxgseL/7cesCABwZJ1lkUkZMf3g+t22y92wXapWpsRzLZPLcJgG758dCEJjCtnHIFb
         385Bw00mjiXslrxf0PJPtvPoAWbCeB28o+pu98WujS7hgyYHpc47909CrM1A6D8KQCON
         3mN8IOPrKDfpigRHDlZXQQY8/7CJ7U6zz2pURwZdf18xO84Sy9DaIdxTq7RiH303ZBm6
         2Z1xvuoZxr1uAFbLyF9kJKzwfzs/RvwepZguHuw0YhbWbJnm9aoF9pCzQWXS+0/vznVf
         82y1A5IcIvlC6ojD66Seq9zwPgSKvNpm6p1NYOf4NPFLnFJkyGBYRbOwZ4oy7GPM8vZa
         XWDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aBpKzW0DysSlCqpBbIOQ7IwtG+vQDqbV9o/9aw4xq+E=;
        b=enbNPyWZR28wjr8gs3PqIWQKcwBEHSEDeEAcOx+ZxBTD/qzw82W3mYu1RheBmZDAmu
         1YiVLPjTlk5snRNOvQpNlsArzEtjLOAbhEFaLJHVRabrCYuk/hT5kEmloCYysHN9hRV7
         dERLrRwZd9PX1L20UAkXNHTtpyHfzTXWTobcoV1sfHRkwMfNYccXKWt5KZs+EI3IIXPO
         zUHVKWOS/cFfAE3m5jWYrVP5/7eZJtaaU5eXWMPquAV+/OJn/Tzm4ETpHgDLOXmxynrN
         n5aLVn9DqSTE9R8uQi/6TBdtv8HVaeFQE5m5AcmzPu9GXQNfQEEEX6Ed1OP84Ba/YG3O
         hv8Q==
X-Gm-Message-State: APjAAAUknstc08nGabOKB85Kv79QxFlAkf/SPZ9dri0iXcuxZRT8dUWD
        mFPgZ/whfNcXaJcw4+9MbKo=
X-Google-Smtp-Source: APXvYqxwsO4hRnwBU4qNvNBYudqrLRYtxXPrDL2K47Q4rMNDd8IDSR95WAp82oBtVNj39288uOZ/1w==
X-Received: by 2002:a1c:6588:: with SMTP id z130mr4941894wmb.0.1578500540987;
        Wed, 08 Jan 2020 08:22:20 -0800 (PST)
Received: from prasmi.home ([2a00:23c6:d18:6d00:2811:8b65:294e:fa09])
        by smtp.gmail.com with ESMTPSA id q3sm5112180wrn.33.2020.01.08.08.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 08:22:20 -0800 (PST)
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
Subject: [v3 6/6] misc: pci_endpoint_test: Add Device ID for RZ/G2E PCIe controller
Date:   Wed,  8 Jan 2020 16:22:11 +0000
Message-Id: <20200108162211.22358-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200108162211.22358-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20200108162211.22358-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
index a5e317073d95..3c84e9a98a05 100644
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
2.20.1

