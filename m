Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 893B43A166C
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jun 2021 16:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbhFIOEQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Jun 2021 10:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbhFIOEP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Jun 2021 10:04:15 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4467BC061574;
        Wed,  9 Jun 2021 07:02:04 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id h3so4085278wmq.3;
        Wed, 09 Jun 2021 07:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N+/riSjz4euVjoS0RyWGJtslWdSbTXbIIzdHyoJErc4=;
        b=CmEM6g3wKtqAtYflVQVVErEtCQXW7Uy97gHNNQMjxtonip1VUyhvcZC2QebjWgKwCi
         mTwlhj6sJugCtXWgwTDKYP7Dgw/sM58GRyFv5FQEGYkCwLYFWh1Sm14Mhikl7RyGLpVx
         5rwwrSAwCRSdayPE3twckTuAnsjOsNX3mgm9fUArlTkRqWz5RI3SYIeLlT0v/r686OJE
         Hp2c8EZDe0diw7WWe1oq0c0gKahOs6oj3sTodA7+lK4AiG2LeuX+3I6p6S7mT+uy13zd
         oZDVmcNiNuqFszcQnViykC4Ulq9c6IbD7u4akpvCoHXRumMc0XNMbm10q7oy3XJuU7tF
         QKBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N+/riSjz4euVjoS0RyWGJtslWdSbTXbIIzdHyoJErc4=;
        b=OQbDUA1AeaSUBCJuk9yx/WaQihYp5Vk3Kw7IwWabmyAtO97SEkhjhQMS6uShWE3RGb
         F1iPrkR58B7N39EUCWbKL57N3SYQTj2rH4v6cTVggFDkTxr0Nvi18voY2JthgV9t2m3T
         4almrkgMhdxEFdeZeyUcIUQbk50j/umMUtfbNm/LwUhc5ebq5tFFtXza/hYrFkXonZRK
         YZtoqpr+pm62cnTjSjmtzkp4WmRwRwPgRix8lTXscQbs6oZ4sXYd4cFdhfIqQt8YfU9e
         SY22tmGCGF8uP8BfsfwPtW288gCnm8vcDZ9ONGInRy3Rba5uJK1Tmha3u+DOy93GCyzI
         vH7w==
X-Gm-Message-State: AOAM530RyVEo5CMgMq5PhqbZ4x88FDD1sf4yvjNqXOY1u+BTm6nrY4bk
        /e8t3HI/lfVniilx5ZjcE4eZXGe6JyrbCg==
X-Google-Smtp-Source: ABdhPJxxFNmbfZIorFhb7skleM0DfQgbYgi6xFHPj/VVl6nDB7ZfDAyLHUwUiAruZiFx1d9ydxCZBg==
X-Received: by 2002:a1c:c256:: with SMTP id s83mr221wmf.86.1623247322353;
        Wed, 09 Jun 2021 07:02:02 -0700 (PDT)
Received: from localhost.localdomain (103.red-81-47-144.staticip.rima-tde.net. [81.47.144.103])
        by smtp.gmail.com with ESMTPSA id m23sm5673912wms.2.2021.06.09.07.02.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jun 2021 07:02:01 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        devicetree@vger.kernel.org, matthias.bgg@gmail.com,
        john@phrozen.org, bhelgaas@google.com, robh+dt@kernel.org,
        linux-staging@lists.linux.dev, gregkh@linuxfoundation.org,
        neil@brown.name, ilya.lipnitskiy@gmail.com,
        linux-kernel@vger.kernel.org, pali@kernel.org
Subject: [PATCH v2 0/3] PCI: mt7621: Add MediaTek MT7621 PCIe host controller driver
Date:   Wed,  9 Jun 2021 16:01:56 +0200
Message-Id: <20210609140159.20476-1-sergio.paracuellos@gmail.com>
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

Now I think is clean enough to be moved into 'drivers/pci/controller'.
This driver is mips/ralink architecture and need 'mips_cps_numiocu()'
to properly configure iocu regions for mips.

This driver also uses already mainlined pci phy driver located in
'drivers/phy/ralink/phy-mt7621-pci.c'. There are two instances of
the phy being the first one dual ported for pci0 and pci1, and the
second one not dual ported dedicated to pci2. Because of writing twice
some phy registers of the dual-ported one sometimes become in not
confident boot cycles we have to take care of this when device link
is checked here in controller driver. We power on the dual ported-phy
if there is something connected in pcie0 or pcie1. In the same manner
we have to properly disable it only if nothing is connected in of both
pcie0 and pcie1 slots.

Another thing that must be mentioned is that this driver uses IO
in physical address 0x001e160000. IO_SPACE_LIMIT for MIPS is 0xffff
so some generic PCI functions (like of_pci_range_to_resource) won't
work and the resource ranges part for IO is set manually.

Changes in v2:
    - Make one commit moving driver directly from staging into
     'drivers/pci/controllers' instead of two commits making
     one add and a later remove.
    - Update binding documentation moving 'clocks', 'resets' and
     'phys' properties to child root bridge nodes. 
    - Update code to properly be able to use new bindings.
    - Kconfig: add || (MIPS && COMPILE_TEST).
    - Use {read/write}_relaxed versions.
    - Use 'PCI_BASE_ADDRESS_0' instead of a custom definition.
    - Avoid to set 'PCI_COMMAND_MASTER' and re-do functions
     'mt7621_pcie_enable_ports' and 'mt7621_pcie_enable_port'.

NOTE: Greg, I have maintained your Acked-by from previous series in
delete driver commit and added in the one which is moving code here
and delete the remaining stuff. If you are not ok with this, just
let me now and I'll drop it and resend.

Thanks in advance for your time.

Best regards,
    Sergio Paracuellos

Sergio Paracuellos (3):
  dt-bindings: mt7621-pci: PCIe binding documentation for MT7621 SoCs
  PCI: mt7621: Add MediaTek MT7621 PCIe host controller driver
  MAINTAINERS: add myself as maintainer of the MT7621 PCI controller
    driver

 .../bindings/pci/mediatek,mt7621-pci.yaml     | 142 ++++++++++++++++++
 MAINTAINERS                                   |   6 +
 arch/mips/ralink/Kconfig                      |   2 +-
 drivers/pci/controller/Kconfig                |   8 +
 drivers/pci/controller/Makefile               |   1 +
 .../controller}/pci-mt7621.c                  |   0
 drivers/staging/Kconfig                       |   2 -
 drivers/staging/Makefile                      |   1 -
 drivers/staging/mt7621-pci/Kconfig            |   8 -
 drivers/staging/mt7621-pci/Makefile           |   2 -
 drivers/staging/mt7621-pci/TODO               |   4 -
 .../mt7621-pci/mediatek,mt7621-pci.txt        | 104 -------------
 12 files changed, 158 insertions(+), 122 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.yaml
 rename drivers/{staging/mt7621-pci => pci/controller}/pci-mt7621.c (100%)
 delete mode 100644 drivers/staging/mt7621-pci/Kconfig
 delete mode 100644 drivers/staging/mt7621-pci/Makefile
 delete mode 100644 drivers/staging/mt7621-pci/TODO
 delete mode 100644 drivers/staging/mt7621-pci/mediatek,mt7621-pci.txt

-- 
2.25.1

