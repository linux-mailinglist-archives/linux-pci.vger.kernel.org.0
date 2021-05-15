Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A76423818CB
	for <lists+linux-pci@lfdr.de>; Sat, 15 May 2021 14:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbhEOMmQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 15 May 2021 08:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbhEOMmP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 15 May 2021 08:42:15 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8251DC061573;
        Sat, 15 May 2021 05:40:59 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id h4so1729487wrt.12;
        Sat, 15 May 2021 05:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YWAKRSKjuVwXHj547jD7swDaSS5/nkXNep5jUTBM2h8=;
        b=rmGbSlQtviY60sTtjMrRQOGtfSOh7vaReKMjtlVGS8LMRasQDY2hvNq50q67ibQ3yZ
         +cIWIDqV9mVpFb6wuu92gxzngGbCkJRetXvZwPsLjzyUuGI25OetjhprgI1moAJmceyS
         bDI3NbA7QvBH+pgXV0AOzV67k3zbP9a7Ah9Y3YG9a8Av7Me0U3Y1blSjNCjIqZjVsZ4/
         hZADEq7vtUFz8tntMbgtQ2glc3Zu/fXMPRP094sUyRU6csgrelVhDKQ+StyXdSa/VHa5
         COi/frdkEWRPMl5qvmnzg1XkDuHrqO4I5Yffx+QxV4TbE9yIGgOiSKfefqmv+YufblHe
         kVMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YWAKRSKjuVwXHj547jD7swDaSS5/nkXNep5jUTBM2h8=;
        b=V29pzN7eehkfPDSVAC78HS4pRrGOSvZmUd0U9wjDYq13oJeOMezkGlooAL5bmzDS0L
         28XjiIaAApAfiltfDxg3/ueCCyzpJSz0WptQjdk70PwhgK3yBakZ1cvIXOeCFHb8Rp1b
         pPCN2b5/urOJH5EyZoqKIwzrhQwsEGWJM8Q/75HdQJpbrOfoGRLlcxEbs7tkm8Plctwd
         of3hXsLGy49RMMKPmPeGZk1Jm3F2kL5/gbg09IvtEd45z0iiWq5g56RvqkXSN73W9cAI
         HkgZiILfiQJTgDxgVIz+Rz1X2QvPP73UrG9SnU5TGzfNI716CzDuBktgZ9QdQgXTzOpT
         oPtQ==
X-Gm-Message-State: AOAM531dcYNRDnkEwL3pYWxeJPJ77LzJO4SAuaCbJrLTuhorgmQrR4+Q
        IZrE9dVMJQ70ysdOHC2ZTIMDhVk400TpoLeZ
X-Google-Smtp-Source: ABdhPJye3BL6Wtnn7eS7GpkzG94zZqlaXHdv49/2d9179RGlmN8Fcx+CPEw2MIp7hIbHcWI8vH22lQ==
X-Received: by 2002:adf:fc44:: with SMTP id e4mr784584wrs.23.1621082457854;
        Sat, 15 May 2021 05:40:57 -0700 (PDT)
Received: from localhost.localdomain (29.red-83-49-33.dynamicip.rima-tde.net. [83.49.33.29])
        by smtp.gmail.com with ESMTPSA id w7sm9472749wru.51.2021.05.15.05.40.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 May 2021 05:40:57 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-mips@vger.kernel.org
Cc:     tsbogend@alpha.franken.de, devicetree@vger.kernel.org,
        matthias.bgg@gmail.com, john@phrozen.org, bhelgaas@google.com,
        robh+dt@kernel.org, linux-staging@lists.linux.dev,
        gregkh@linuxfoundation.org, neil@brown.name,
        ilya.lipnitskiy@gmail.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH 0/4] MIPS: ralink: pci: driver for Pcie controller in MT7621 SoCs
Date:   Sat, 15 May 2021 14:40:51 +0200
Message-Id: <20210515124055.22225-1-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

MediaTek MT7621 PCIe subsys supports single Root complex (RC)
with 3 Root Ports. Each Root Ports supports a Gen1 1-lane Link.
Topology is as follows:

                          MT7621 PCIe HOST Topology

                                   .-------.
                                   |       |
                                   |  CPU  |
                                   |       |
                                   '-------'
                                       |
                                       |
                                       |
                                       v
                              .------------------.
                  .-----------|  HOST/PCI Bridge |------------.
                  |           '------------------'            |     Type1 
         BUS0     |                     |                     |    Access 
                  v                     v                     v    On Bus0
          .-------------.        .-------------.       .-------------.
          | VIRTUAL P2P |        | VIRTUAL P2P |       | VIRTUAL P2P |
          |    BUS0     |        |    BUS0     |       |    BUS0     |
          |    DEV0     |        |    DEV1     |       |    DEV2     |
          '-------------'        '-------------'       '-------------'
    Type0        |          Type0       |         Type0       |
   Access   BUS1 |         Access   BUS2|        Access   BUS3|
   On Bus1       v         On Bus2      v        On Bus3      v
           .----------.           .----------.          .----------.
           | Device 0 |           | Device 0 |          | Device 0 |
           |  Func 0  |           |  Func 0  |          |  Func 0  |
           '----------'           '----------'          '----------'

This driver has been very long time in staging and I have been cleaning
it from its first versions where there was code kaos and PCI_LEGACY support.
Original code came probably from openWRT based on mediatek's SDK code. There
is no documentation at all about the mt7621 PCI subsystem.
I have been cleaning it targeting mt7621 SoC which is the one I use in
my GNUBee PC1 board and HiLink HLK-MT7621A evaluation board.

Now I think is clean enough to be moved into 'arch/mips/pci'.

This driver also uses already mainlined pci phy driver located in
'drivers/phy/ralink/phy-mt7621-pci.c'. There are two instances of
the phy being the first one dual ported for pci0 and pci1, and the 
second one not dual ported dedicated to pci2. Because of writing twice 
some phy registers of the dual-ported one sometimes become in not
confident boot cycles we have to take care of this when device link
is checked here in controller driver. We power on the dual ported-phy
if there is something connected in pcie0 or pcie1. In the same manner
we have to properly disable it only if nothing is connected in of both
pcie0 and pci1 slots.

Another thing that must be mentioned is that this driver uses IO
in physical address 0x001e160000. IO_SPACE_LIMIT for MIPS is 0xffff
so some generic PCI functions (like of_pci_range_to_resource) won't
work and the resource ranges part for IO is set manually.

I had already sent binding documentation to be reviewed but I am
include also here with the driver itself and this cover letter
to make easy review process.

Best regards,
    Sergio Paracuellos

Sergio Paracuellos (4):
  dt-bindings: mt7621-pci: PCIe binding documentation for MT7621 SoCs
  MIPS: pci: Add driver for MT7621 PCIe controller
  staging: mt7621-pci: remove driver from staging
  MAINTAINERS: add myself as maintainer of the MT7621 PCI controller
    driver

 .../bindings/pci/mediatek,mt7621-pci.yaml     | 149 ++++++++++++++++++
 MAINTAINERS                                   |   6 +
 arch/mips/pci/Makefile                        |   1 +
 .../mt7621-pci => arch/mips/pci}/pci-mt7621.c |   0
 arch/mips/ralink/Kconfig                      |   9 +-
 drivers/staging/Kconfig                       |   2 -
 drivers/staging/Makefile                      |   1 -
 drivers/staging/mt7621-pci/Kconfig            |   8 -
 drivers/staging/mt7621-pci/Makefile           |   2 -
 drivers/staging/mt7621-pci/TODO               |   4 -
 .../mt7621-pci/mediatek,mt7621-pci.txt        | 104 ------------
 11 files changed, 164 insertions(+), 122 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.yaml
 rename {drivers/staging/mt7621-pci => arch/mips/pci}/pci-mt7621.c (100%)
 delete mode 100644 drivers/staging/mt7621-pci/Kconfig
 delete mode 100644 drivers/staging/mt7621-pci/Makefile
 delete mode 100644 drivers/staging/mt7621-pci/TODO
 delete mode 100644 drivers/staging/mt7621-pci/mediatek,mt7621-pci.txt

-- 
2.25.1
