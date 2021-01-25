Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBC613027DF
	for <lists+linux-pci@lfdr.de>; Mon, 25 Jan 2021 17:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730704AbhAYQbl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Jan 2021 11:31:41 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:31940 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727840AbhAYQbH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Jan 2021 11:31:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1611592266; x=1643128266;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=Y6cYRDZBHofXC1+fMpkWazCbSAWSF9dRS/TDToGnCxg=;
  b=e3inWXgvz39YTPy8FIiOTx9ZpqmAqhm10KlPLdDSYtRSPN09QS6N6EFN
   2MtfdlnPXwB4Q/05uM+rhl7Lw2hVwlESnFZ1IifETPzNKGjQZvhfYALfp
   7lAGQ+0hoTR8fLqXgt2SejYuu68FgRHlRZnfM20kKoHFrSHMCX1dFhTwn
   P85I5n2rb7vzBmD0aXM/zzCCs2ypfs9nwNuMz2a7lp8VY0SeFi5GCMqTM
   1pOmwI1p2pojusM+kMf+E+HsSWLCDsRPWG7sovMC6cpmmfR7uImcy1lc+
   KP2ACxK1ZYuIRulLA1WyVa9CQF4ptUwrWli0GxcQNQ7PZmzpYdXOWlSIi
   g==;
IronPort-SDR: QcCEgNQK5upIbX+b+qnkA7bBFXzY3TOPYZ4ralwBmfiJEGG16OKSCkKG2J4OGphoyD5WSiVrnA
 W+E0TSgkDyU/tcnoq+jF3/BOxWMbWccKvwnh4e3zWsFc4D6tkNRydA5WAb23oQGkBnxrniBayY
 DoAkeC1OBkPRDlevi5/zMqnZ/NV2iFfu8TMenE29gVxAjGfeMrSQRpnU5+GRO+yX4gg8ljcWh+
 4/WZp8vgW9atBYchYboT35ESEUuo+buEj3kinZKzMRrdcOR1IEPaFHoZ0CNIhrrvOlIIbGJhfE
 36Q=
X-IronPort-AV: E=Sophos;i="5.79,374,1602572400"; 
   d="scan'208";a="112382968"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Jan 2021 09:29:49 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 25 Jan 2021 09:29:49 -0700
Received: from ryzen.microchip.com (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Mon, 25 Jan 2021 09:29:47 -0700
From:   <daire.mcnamara@microchip.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh@kernel.org>, <linux-pci@vger.kernel.org>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <david.abdurachmanov@gmail.com>, <cyril.jean@microchip.com>,
        "Daire McNamara" <daire.mcnamara@microchip.com>
Subject: [PATCH v21 4/4] MAINTAINERS: Add Daire McNamara as maintainer for the Microchip PCIe driver
Date:   Mon, 25 Jan 2021 16:29:34 +0000
Message-ID: <20210125162934.5335-5-daire.mcnamara@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210125162934.5335-1-daire.mcnamara@microchip.com>
References: <20210125162934.5335-1-daire.mcnamara@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Daire McNamara <daire.mcnamara@microchip.com>

Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e73636b75f29..f2dafbf3393c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13628,6 +13628,13 @@ S:	Supported
 F:	Documentation/devicetree/bindings/pci/mediatek*
 F:	drivers/pci/controller/*mediatek*
 
+PCIE DRIVER FOR MICROCHIP
+M:	Daire McNamara <daire.mcnamara@microchip.com>
+L:	linux-pci@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/pci/microchip*
+F:	drivers/pci/controller/*microchip*
+
 PCIE DRIVER FOR QUALCOMM MSM
 M:	Stanimir Varbanov <svarbanov@mm-sol.com>
 L:	linux-pci@vger.kernel.org
-- 
2.25.1

