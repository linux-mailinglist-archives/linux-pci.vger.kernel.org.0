Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72301173BBD
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2020 16:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgB1Pla (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Feb 2020 10:41:30 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39735 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727060AbgB1Pla (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Feb 2020 10:41:30 -0500
Received: by mail-wm1-f66.google.com with SMTP id c84so3647624wme.4;
        Fri, 28 Feb 2020 07:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XNr9LS4NdBHHOaGNbY4Rvbef+Vzw8n41HfwyhtLS84U=;
        b=V+4T56gijWkocDCf9UuoVhIlpqQou5tVyjGVTxcqIhks9Ikt5iJs6SyM+ArNyb3AaJ
         yXm2/PfBheCmPfkkn1K6kgvJEoMAoaZ2SPw4G0BZmG8lpER5EEBuQ9KQET1ESWQO7nas
         /IErfsz4Cf7rsxnTfdkNspNCHZsac6f7X1wNWhuB9kmzFq4sKC6Bbuo5SWEJ6XdoNlsb
         o/0dh8BcJQlEQbIk3V3c+FmVxXyS91iHErWDX/ssZZAgW55B720dQtLlsl66IN3ixKEu
         PB2r3pZunzJMhrXyfDjwGlmv06I8TlRt/6U7jeExuuLhrJVMk+T288qgq3AQLUvsgWEp
         zukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XNr9LS4NdBHHOaGNbY4Rvbef+Vzw8n41HfwyhtLS84U=;
        b=p39LCpTucuj2fGtr76bR0oOAQPv+bp3x3p8BXDWIm02LnEPIHPtadf72K4BtTwyQog
         U54KECF2tS/V1JaM06udReNYbnEedAvjv9IiVTKU2Z00PPv/TPgO9pEEwL6OlKgsz83P
         ujm/ERBVZq6xyVx6ZaU74k1dCVJth+aMMmFPGj8x+H/cI2Gl88pv9qUs8Mmc2LHL6iyU
         6hl1WwsbCqdpRd+WigNKD6sKHklT7Qxm94cb12vywCgn7fMBSBnkNzuhQTFSvDDFo6OW
         OzHQGYgSJKc/pl6wyI8ta32jrT72A5bf7Hzb+w4Uc8kUmqJObZ81+CxEa42VxU4Owx4b
         pFpA==
X-Gm-Message-State: APjAAAUtM8nNOd9y8UM1khRP53kYG4u/uWAwzqQDtCFkrII7WsXjLpn/
        2OKtx46OIly6eM1l/b1oVhA=
X-Google-Smtp-Source: APXvYqx07nbNnJcNa+gIPlfmOe/rE95wPUQ9FmQByVrfLSt460UDzFev6s0hSOVfySBvJ0w5DozNQA==
X-Received: by 2002:a1c:4908:: with SMTP id w8mr5178421wma.57.1582904488030;
        Fri, 28 Feb 2020 07:41:28 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2510:d000:3855:fd13:6b76:a11b])
        by smtp.gmail.com with ESMTPSA id k16sm13355349wrd.17.2020.02.28.07.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 07:41:27 -0800 (PST)
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
Subject: [PATCH v5 0/7] Add support for PCIe controller to work in endpoint mode on R-Car SoCs
Date:   Fri, 28 Feb 2020 15:41:15 +0000
Message-Id: <20200228154122.14164-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch series adds support for PCIe controller on rcar to work in
endpoint mode, this also extends the epf framework to handle base region
for mapping PCI address locally.

Note:
The cadence/rockchip/designware endpoint drivers are build tested only.

Changes for v5:
1] Rebased the patches on next branch of https://git.kernel.org/pub/scm/
   linux/kernel/git/helgaas/pci.git
2] Fixed review comments reported by Kishon while fetching the matching
   window in function pci_epc_get_matching_window()
3] Fixed review comments reported by Bjorn
   a] Split patch up first patch so that its easier to review and incremental
   b] Fixed typos
4] Included Reviewed tag from Rob for the dt-binding patch
5] Fixed issue reported by Nathan for assigning variable to itself

Changes for v4:
1] Fixed dtb_check error reported by Rob
2] Fixed review comments reported by Kishon
   a] Dropped pci_epc_find_best_fit_window()
   b] Fixed initializing mem ptr in __pci_epc_mem_init()
   c] Dropped map_size from pci_epc_mem_window structure

Changes for v3:
1] Fixed review comments from Bjorn and Kishon.
3] Converted to DT schema

Changes for v2:
1] Fixed review comments from Biju for dt-bindings to include an example
   for a tested platform.
2] Fixed review comments from Kishon to extend the features of outbound
   regions in epf framework.
3] Added support to parse outbound-ranges in OF.

Lad Prabhakar (7):
  PCI: rcar: Rename pcie-rcar.c to pcie-rcar-host.c
  PCI: rcar: Move shareable code to a common file
  PCI: rcar: Fix calculating mask for PCIEPAMR register
  PCI: endpoint: Add support to handle multiple base for mapping
    outbound memory
  dt-bindings: PCI: rcar: Add bindings for R-Car PCIe endpoint
    controller
  PCI: rcar: Add support for rcar PCIe controller in endpoint mode
  misc: pci_endpoint_test: Add Device ID for RZ/G2E PCIe controller

 .../devicetree/bindings/pci/rcar-pci-ep.yaml       |   76 ++
 arch/arm64/configs/defconfig                       |    2 +-
 drivers/misc/pci_endpoint_test.c                   |    3 +
 drivers/pci/controller/Kconfig                     |   15 +-
 drivers/pci/controller/Makefile                    |    3 +-
 drivers/pci/controller/cadence/pcie-cadence-ep.c   |    7 +-
 drivers/pci/controller/dwc/pcie-designware-ep.c    |   29 +-
 drivers/pci/controller/pcie-rcar-ep.c              |  490 ++++++++
 drivers/pci/controller/pcie-rcar-host.c            | 1053 +++++++++++++++++
 drivers/pci/controller/pcie-rcar.c                 | 1229 +-------------------
 drivers/pci/controller/pcie-rcar.h                 |  129 ++
 drivers/pci/controller/pcie-rockchip-ep.c          |    7 +-
 drivers/pci/endpoint/pci-epc-mem.c                 |  167 ++-
 include/linux/pci-epc.h                            |   39 +-
 14 files changed, 1985 insertions(+), 1264 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
 create mode 100644 drivers/pci/controller/pcie-rcar-ep.c
 create mode 100644 drivers/pci/controller/pcie-rcar-host.c
 create mode 100644 drivers/pci/controller/pcie-rcar.h

-- 
2.7.4

