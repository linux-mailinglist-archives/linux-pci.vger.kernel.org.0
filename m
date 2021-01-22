Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 907FB300625
	for <lists+linux-pci@lfdr.de>; Fri, 22 Jan 2021 15:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbhAVOxs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Jan 2021 09:53:48 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:15866 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728715AbhAVOxJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jan 2021 09:53:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1611327189; x=1642863189;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=Y6cYRDZBHofXC1+fMpkWazCbSAWSF9dRS/TDToGnCxg=;
  b=QKz2GiX1OF6SUSmd0wI06GaxBYmj8v+Se/nmwoVtkJiRbhk6uRhh3hwX
   GoK7bi1XwjamNM0USTCSEcCEQUJmXMyW/2km0W27B+0vB45xzS9o7f8FM
   eHvLeM/NViu76h8h5q9NU6LMg40KwQoNFLx3VVHYPJP5/TFLMNOUkqa7J
   r6n9+FYB7qUWpJFbBa059Y9xNK0z0ZD6tit0hgh2Tz0ZFw61TOHbsCB9/
   Cx4VQ/CU4meDvlbWgaGOqdipSbGl14z6D97Wn1ULeDXOgZ2Ff2fT8mX72
   nov2LSQZ9mLlht2D6MC5nV89Q6Lc0/tnZLKh1vPpCw0HbyuNRlDN30+Dz
   A==;
IronPort-SDR: RrTTLCCVroj2hS3rAsvdwXeVsxNTwPsrwxBZIpprINLnzEifO6zHoxRoOPYOVKawOagJzdkpTt
 V7eK+ftx1DAgVAhZZdCQ2HKnL1f716zr7PWnyRP3cHny7xmbeETiIJ0/enzYT5JE5HRrdnpA9f
 ffBZX/TVTIuexNMM6/CCl+Jiu1Rlk8qu4V3dkjORwD25sKG6nz8RthrrZweKgLQ09aS/0qw3w9
 p/HKI1zC7T4CTPwJ9UTAd9xliIgKLID3IfQZgJYjoChLFAdnTh7m+UhG3W3bHD9zbEhMNPuUYt
 mVo=
X-IronPort-AV: E=Sophos;i="5.79,366,1602572400"; 
   d="scan'208";a="112095804"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Jan 2021 07:51:53 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 22 Jan 2021 07:51:53 -0700
Received: from ryzen.microchip.com (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 22 Jan 2021 07:51:51 -0700
From:   <daire.mcnamara@microchip.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh@kernel.org>, <linux-pci@vger.kernel.org>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <david.abdurachmanov@gmail.com>, <cyril.jean@microchip.com>,
        "Daire McNamara" <daire.mcnamara@microchip.com>
Subject: [PATCH v20 4/4] MAINTAINERS: Add Daire McNamara as maintainer for the Microchip PCIe driver
Date:   Fri, 22 Jan 2021 14:51:37 +0000
Message-ID: <20210122145137.29023-5-daire.mcnamara@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210122145137.29023-1-daire.mcnamara@microchip.com>
References: <20210122145137.29023-1-daire.mcnamara@microchip.com>
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

