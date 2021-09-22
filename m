Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE9544140F1
	for <lists+linux-pci@lfdr.de>; Wed, 22 Sep 2021 07:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbhIVFCJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Sep 2021 01:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbhIVFCJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Sep 2021 01:02:09 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7470C061574;
        Tue, 21 Sep 2021 22:00:39 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id t8so3029556wrq.4;
        Tue, 21 Sep 2021 22:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IHrQEFVF44k2fbyHAhZ+TFuZ8lKa2bQ16gGSgsPMKMM=;
        b=c98+MPh8vMk8ZJAGwRqca+iKoMa6ZlyPZ76BZSvobl+F4fm1BWS719pLpdVL+HeWOL
         8k2d9OjI+ojNEcU+uHjWjw1wAcRfQi4pPQqqNkxCIAx0+DxjulmRBSgpojZlXiwjWHCg
         XqbR57H4znmYnlu94qRMHu5Vp2nZzAP5Nw+z983Z8Jzag5ENVLg4ZsTDh7LFfpMC8YYU
         aPerwyHrNmRaCWec71vFQBq5WvsPQx4qGkXu5/fA5QL6rlt5qNgsXbvMOkpq/pKLmsm0
         88+NpTc9CBdAecjMWdVVqAz3Exafjrvw/UgMi/cIy7hwoHolU9UFWvkvAXZuvE+KYhql
         4X8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IHrQEFVF44k2fbyHAhZ+TFuZ8lKa2bQ16gGSgsPMKMM=;
        b=QB62IaKRMCRIPXt1n8z5Ggq49mNNNZF1qHNIpsa1PhiVUCEbJOl5H3J/euVjQ2SQQg
         JkaFmP4SNOLsm2RRP4NRpSn5YAs3sy/PloPAZT1tDSNEa61kfWgwK15PM+1kJzdAWj/f
         lmW/FXniKVjh2pIP0r3Guck+XWCZOihLHx3Fu/9In42QMoJWPrZjjsv7ZhGXGJe8wXpb
         nC1hQQFSO2BZV2jub+xVAfapGBWxDWcEFfje+tNm5fxBij2nOWCjPns26pccFzXUNSMS
         nsTt+fBBJiAG0R7sU/lZ65BY29jGMJLYbUV5ElWaKYg6B9texGOjtOsMk+u/hSvVR578
         g7ew==
X-Gm-Message-State: AOAM530iP6goYDEV3WmQsrGSWjTuVTe44Muob4lj2zLBO3v3Ym3UOFMq
        otEdlTBIRLA82ITeTPASRZpNdSMYKSA=
X-Google-Smtp-Source: ABdhPJybsyt2COp8s5DQjMgQXvOz5y5bpce2gzIZGFWEAuludQO9Hc+BBjfSRaAoSV5nlQuVxCXSuA==
X-Received: by 2002:a7b:c350:: with SMTP id l16mr7980429wmj.151.1632286837636;
        Tue, 21 Sep 2021 22:00:37 -0700 (PDT)
Received: from localhost.localdomain (252.red-83-54-181.dynamicip.rima-tde.net. [83.54.181.252])
        by smtp.gmail.com with ESMTPSA id b187sm4811625wmd.33.2021.09.21.22.00.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Sep 2021 22:00:37 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     lorenzo.pieralisi@arm.com, john@phrozen.org,
        devicetree@vger.kernel.org, tsbogend@alpha.franken.de,
        bhelgaas@google.com, matthias.bgg@gmail.com,
        gregkh@linuxfoundation.org, linux-mips@vger.kernel.org,
        linux-staging@lists.linux.dev, neil@brown.name,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] PCI: mt7621: Add MediaTek MT7621 PCIe host controller driver
Date:   Wed, 22 Sep 2021 07:00:32 +0200
Message-Id: <20210922050035.18162-1-sergio.paracuellos@gmail.com>
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

This changes are rebased on the top of staging-next branch of staging
tree for a clean git mv since last changes are always in that tree.
Since this a git mv as I was told to do, include link to the last code
here [0].

Changes in v3:
 - Add Rob's Reviewed-by for the bindings.
 - Avoid custom 'of_pci_range_to_resource' in driver side since
   PCI core APIs has been changed to properly support this architecture.
 - Kconfig:
   - Change from 'bool' to 'tristate'.
   - Add phy's selection 'select PHY_MT7621_PCI'.
   - Move PCI_DRIVERS_GENERIC selection to 'arch/mips' since its mips
     internal stuff (change requested by Lorenzo in v2 review of this series).

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

Thanks in advance for your time.

Best regards,
    Sergio Paracuellos

[0]: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/tree/drivers/staging/mt7621-pci/pci-mt7621.c?h=staging-testing
Sergio Paracuellos (3):
  dt-bindings: mt7621-pci: PCIe binding documentation for MT7621 SoCs
  PCI: mt7621: Add MediaTek MT7621 PCIe host controller driver
  MAINTAINERS: add myself as maintainer of the MT7621 PCI controller
    driver

 .../bindings/pci/mediatek,mt7621-pci.yaml     | 142 ++++++++++++++++++
 MAINTAINERS                                   |   6 +
 arch/mips/ralink/Kconfig                      |   3 +-
 drivers/pci/controller/Kconfig                |   8 +
 drivers/pci/controller/Makefile               |   1 +
 .../controller}/pci-mt7621.c                  |   0
 drivers/staging/Kconfig                       |   2 -
 drivers/staging/Makefile                      |   1 -
 drivers/staging/mt7621-pci/Kconfig            |   8 -
 drivers/staging/mt7621-pci/Makefile           |   2 -
 drivers/staging/mt7621-pci/TODO               |   4 -
 .../mt7621-pci/mediatek,mt7621-pci.txt        | 104 -------------
 12 files changed, 159 insertions(+), 122 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.yaml
 rename drivers/{staging/mt7621-pci => pci/controller}/pci-mt7621.c (100%)
 delete mode 100644 drivers/staging/mt7621-pci/Kconfig
 delete mode 100644 drivers/staging/mt7621-pci/Makefile
 delete mode 100644 drivers/staging/mt7621-pci/TODO
 delete mode 100644 drivers/staging/mt7621-pci/mediatek,mt7621-pci.txt

-- 
2.25.1
