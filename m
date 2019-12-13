Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C965511DFD1
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2019 09:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfLMIsw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Dec 2019 03:48:52 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43601 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfLMIsw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Dec 2019 03:48:52 -0500
Received: by mail-pl1-f196.google.com with SMTP id p27so948253pli.10;
        Fri, 13 Dec 2019 00:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yrmwheM1+hl4xPG9UeGTOMJP5qq8jouvYWPI+cmTnHk=;
        b=JXoAHKm2bI0UF8C3jLaI9pvYELwmQXbNwNN2AtjdVI+1nSAgHqrbt+7mijVaetV20Y
         6zQovqYzG18kdJuyfxMhQWB1JJynIx4K47ONJ0I+sOBz1A+DfTildAzUkIwkxZfuMhlH
         pAi6iJ6fk1NmUlCYsXZkHO0txpiD0UyWmrcLxJwuldyvXjhUBo5+tHJhSwPMVOi4WSz4
         +nDGpU7GVMaqCj3zyBPOKqfd0KEGupjIUghCCe4QBguZZ9d1cJgAICDyf6YwfSFtAMPP
         GrJU+GqqFIFP7fZNANPqfUubQdzy/Oiw63YKt5jyDH8yWauSZgX8kp4feWIVhDLry4tI
         zZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yrmwheM1+hl4xPG9UeGTOMJP5qq8jouvYWPI+cmTnHk=;
        b=dlTYgF4bx4/807/E80f+hVqDiLTfk11MNK0K7CNKozfs4+DuV3mFMs4cC2LXuhZVcY
         U9pHxd1mPSvBMJbqtqmNbS2nMFlimuC2hqVutJmNarC8cm436V+L6PdOz6Qy0bj15Jue
         a5QV15+exJ0w9H3giSSYoVAQa7uA+7o0IErbPBlNYizvta5XSHZ9AnaAItr9mFoBd5et
         SUkJLRL/TMPlfuygZpnc4Sx6NIgn/TwTOrhqygDcAF838URIYK/mDtqwGTHN+bDAelPq
         ZkfWXAqhW/oGjxKQJ3lLefrbuTbcrvloVpYD0whwqECuxVDA0Y5myWXUodWZae0Wf14R
         KB6A==
X-Gm-Message-State: APjAAAWcdlpvweZRJ31/Ywdgvk7LUbahb9HWycdfFJvtMqxlQpopf2Ud
        /8IcEu2Ibwxz5+dL81E+ZwI=
X-Google-Smtp-Source: APXvYqzicnEwVE9B41IwGGyGmDGn6PjfwuHMeFWgsbEx+ksTLkPbjB2d4SolnSLbApVjeqKZ3461Mg==
X-Received: by 2002:a17:90a:1704:: with SMTP id z4mr15379073pjd.131.1576226931296;
        Fri, 13 Dec 2019 00:48:51 -0800 (PST)
Received: from prasmi.domain.name ([103.219.60.167])
        by smtp.gmail.com with ESMTPSA id 68sm9985632pge.14.2019.12.13.00.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 00:48:50 -0800 (PST)
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
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [v2 6/6] misc: pci_endpoint_test: add device-id for RZ/G2E pcie controller
Date:   Fri, 13 Dec 2019 08:47:48 +0000
Message-Id: <20191213084748.11210-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191213084748.11210-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20191213084748.11210-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add RZ/G2E in pci_device_id table so that pci-epf-test can be used
for testing PCIe EP in RZ/G2E.

Signed-off-by: Lad, Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/misc/pci_endpoint_test.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 6e208a0..3e879c7 100644
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

