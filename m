Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5679E3DFBEA
	for <lists+linux-pci@lfdr.de>; Wed,  4 Aug 2021 09:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235532AbhHDHT3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Aug 2021 03:19:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:56724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235764AbhHDHTN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 4 Aug 2021 03:19:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5FE2D60FC3;
        Wed,  4 Aug 2021 07:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628061541;
        bh=DuCVUYP7oviwKz23wsYZqPNLLQEdkO9PaJNmlDPw5TI=;
        h=From:To:Cc:Subject:Date:From;
        b=RoQ4/9xs6bAfnpO0Z+2f51GvkoebeQxBXOeUzed8pRtqPojG2u8q+TCL5KAZDDEj/
         iYFX8OjWeTiagFkdBde4fAnmUIYsiHxQxxq8o9Q6h/rKf61ThUAquxBaPGcXP4Hyy0
         zwSdiem33aLQsX39k5+fPvdwsdcH9riIn77vUJ+qfcNVBQZ1e28NmIEHRYQCedoilC
         /YnQJwOK8ZAIHuibax4AQVd6Wx8atr26q3yrD3PLPJ2mSefjzd8MpV7UDs9nVT/XHM
         HGAqDST8DnQdmrR26Z8cybN6UlLyJaGPBtspS5Q1uUuAiM1lQ8ZbG6zonXVTqduPif
         Uo4HytOUo0pEg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mBBB5-000BlA-3j; Wed, 04 Aug 2021 09:18:59 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-phy@lists.infradead.org
Subject: [PATCH v4 0/4] DT schema changes for HiKey970 PCIe hardware to work
Date:   Wed,  4 Aug 2021 09:18:53 +0200
Message-Id: <cover.1628061310.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

It follows the DT bindings for Kirin 970 PCIE and its corresponding PHY,
rebased on the top of next-20210803.

It should apply cleanly on the top of:
	https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git/log/?h=dt/next

Note: you mentioned that patch 1 was already applied, but it is not
there yet. I opted to keep it at the tree, in case someone wants to
apply this series on the top of linux-next.

v4:
  - Rebased and fixed a merge conflict

v3:
  - Fixed a comment on patch 3: The Ethernet controller is at lane 6.

v2:
  - removed the DTS file. I'll submit it in separate, once having
    everything else merged;
  - it now doesn't produce any warnings with:
        make DT_SCHEMA_FILES=Documentation/devicetree/bindings/pci/hisilicon,kirin
-pcie.yaml DT_CHECKER_FLAGS=-m dt_binding_check
  - added the upstream node;
  - the clock enable now uses a new property (hisilicon,clken-gpios);
  - the reg for the PCI devices are now properly filled;
  - the pcie@x,y nodes now match the port number from table 4-1 from the
   datasheet.


Mauro Carvalho Chehab (4):
  dt-bindings: PCI: kirin: Fix compatible string
  dt-bindings: PCI: kirin: Convert kirin-pcie.txt to yaml
  dt-bindings: PCI: kirin: Add support for Kirin970
  dt-bindings: phy: Add bindings for HiKey 970 PCIe PHY

 .../bindings/pci/hisilicon,kirin-pcie.yaml    | 160 ++++++++++++++++++
 .../devicetree/bindings/pci/kirin-pcie.txt    |  50 ------
 .../devicetree/bindings/pci/snps,dw-pcie.yaml |   2 +-
 .../phy/hisilicon,phy-hi3670-pcie.yaml        |  82 +++++++++
 MAINTAINERS                                   |   2 +-
 5 files changed, 244 insertions(+), 52 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/kirin-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/phy/hisilicon,phy-hi3670-pcie.yaml

-- 
2.31.1


