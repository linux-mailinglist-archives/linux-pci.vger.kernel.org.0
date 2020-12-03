Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5692CD53D
	for <lists+linux-pci@lfdr.de>; Thu,  3 Dec 2020 13:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387983AbgLCMMC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Dec 2020 07:12:02 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:2777 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387902AbgLCMMC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Dec 2020 07:12:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1606997521; x=1638533521;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=G7gY21GQKpcQoIlmJJTL4aEgCgjYwZ+FVgSuyNr0Zsg=;
  b=DLSQlTw5HWXjyglz6PRu/DJ/M/VK9/xciBDqWmVkCRRXHwHfZ4msqTAq
   xmk1BBfvQdU/Q4gLbFqkSngqtG9D6lLUYI4Ujiw/mnZDQz1BV/YaD2EsP
   x7ilDdnjOdQ62oIDdhAO7s5cQ+15f4s6ikLg6JCKbl2GSKWxJhjbiITDp
   nysG3ByqRC3jRqgYo9qBQLje0ChnlYUk6MpTrt/qnzOO8ZlNYtDHZvIAp
   RjCHJGZq/L+0Yn8x/ok79pvqrd/XudX9LJfPdn4Pp5rHVcCpIAuefxXR0
   A1Dx6vELAHpDtfQC7rGD7Hlw8gYM1RNN/F3a/e8Kj/hCFNtGGMipBZDJP
   A==;
IronPort-SDR: g6uY8SusgNVqlOMFJPwqUqdLLW5T9wiyNheR7/IHBzHaGQrYShM0B5DonnyxFcI3exlVy1I2rl
 WFurIh43++5Cn0kTsY6CCu7yI/5Td6ez1NUBsb3nT81trNXQk1rJrH/+DZEetnEWhIOPCIsKDD
 v9dXhD+Q/qdFAnTME2DSXkoIBGfDUbkkuaafSdCF1uFRPnLMRUydfTVl0jTutjv9sDpuKKm9t8
 MWq1V69cPE4N87lbIS18zgp//0BzvYVh4adxzE70PL18+ixZHAe+Z4zg+a/1daxVyOKzXvoGJ1
 FXc=
X-IronPort-AV: E=Sophos;i="5.78,389,1599548400"; 
   d="scan'208";a="101273979"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Dec 2020 05:10:56 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 3 Dec 2020 05:10:56 -0700
Received: from ryzen.microchip.com (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 3 Dec 2020 05:10:54 -0700
From:   <daire.mcnamara@microchip.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh@kernel.org>, <linux-pci@vger.kernel.org>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <david.abdurachmanov@gmail.com>, <cyril.jean@microchip.com>,
        <ben.dooks@codethink.co.uk>,
        Daire McNamara <daire.mcnamara@microchip.com>
Subject: [PATCH v18 4/4] Add Daire McNamara as maintainer for the Microchip PCIe driver
Date:   Thu, 3 Dec 2020 12:10:18 +0000
Message-ID: <20201203121018.16432-5-daire.mcnamara@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201203121018.16432-1-daire.mcnamara@microchip.com>
References: <20201203121018.16432-1-daire.mcnamara@microchip.com>
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
index e73636b75f29..dc926b36116b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13628,6 +13628,13 @@ S:	Supported
 F:	Documentation/devicetree/bindings/pci/mediatek*
 F:	drivers/pci/controller/*mediatek*
 
+PCIE DRIVER FOR MICROCHIP
+M:	Daire McNamara <daire.mcnamara@microchip.com>
+L:	linux-pci@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindigs/pci/microchip*
+F:	drivers/pci/controller/*microchip*
+
 PCIE DRIVER FOR QUALCOMM MSM
 M:	Stanimir Varbanov <svarbanov@mm-sol.com>
 L:	linux-pci@vger.kernel.org
-- 
2.25.1

