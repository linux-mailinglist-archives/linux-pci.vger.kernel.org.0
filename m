Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7135F3C255D
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jul 2021 15:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbhGIOAb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Jul 2021 10:00:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:34642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231918AbhGIOAa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Jul 2021 10:00:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D05D613B2;
        Fri,  9 Jul 2021 13:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625839067;
        bh=HyNehvqgAJQzHq1MhZD/QmNgbhv9hin721hnafe3LcI=;
        h=From:To:Cc:Subject:Date:From;
        b=toOdvWw5iKKMV7gg70ONZoGKe3kIMcaKbL9tBcnZ6fQCipRadtQuP6o5myjdowG6K
         yBxVgSqRaP1ZSBfkmvIFC5FC1N6TEY6CddTYG62SR6Fg/6iEgwLmLwX5VxogkIGDUs
         afRoG2e5sMmA9EYSqOG4P1jb90w3Alz4L7pbqmOlpbVkirRXJ2kVpmFRD7sJsBKXUO
         vY8zqFToJJxgS1uYKx9x0/78G+QMfqcv9e5W/U3ad5Rmfs6B3pL7NCxdi0PWJe4lgD
         p+PFFgmr1TBdGROLHQbTeNMFNTKjCiZordM2C8hglZ25/+Rf4fkN5G355TVrYZpL54
         h5lCS444TGgUg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m1r0i-0004lB-Ik; Fri, 09 Jul 2021 15:57:44 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@axis.com, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v3 0/2] convert designware-pcie.txt and kirin-pcie.txt to yaml
Date:   Fri,  9 Jul 2021 15:57:41 +0200
Message-Id: <cover.1625838920.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

This series applies after this one:
   https://lore.kernel.org/lkml/cover.1625826353.git.mchehab+huawei@kernel.org/

It basically converts two PCI DT-bindings to DT schema. On this version, I'm
addressing some of your comments from v2, and rebased it on the top of
my Hikey 960/970 tree (based on linus/master).

The example for the designware file is producing some warnings here, as it
can't find the right propertiesPattern. No idea why.

Mauro Carvalho Chehab (2):
  dt-bindings: PCI: designware-pcie.txt: convert it to yaml
  dt-bindings: PCI: kirin-pcie.txt: convert it to yaml

 .../bindings/pci/amlogic,meson-pcie.txt       |   4 +-
 .../bindings/pci/axis,artpec6-pcie.txt        |   2 +-
 .../bindings/pci/designware-pcie.txt          |  77 ----------
 .../bindings/pci/fsl,imx6q-pcie.txt           |   2 +-
 .../bindings/pci/hisilicon,kirin-pcie.yaml    |  79 ++++++++++
 .../bindings/pci/hisilicon-histb-pcie.txt     |   2 +-
 .../devicetree/bindings/pci/kirin-pcie.txt    |  41 ------
 .../bindings/pci/layerscape-pci.txt           |   2 +-
 .../bindings/pci/nvidia,tegra194-pcie.txt     |   4 +-
 .../devicetree/bindings/pci/pci-armada8k.txt  |   2 +-
 .../devicetree/bindings/pci/pcie-al.txt       |   2 +-
 .../devicetree/bindings/pci/qcom,pcie.txt     |  14 +-
 .../bindings/pci/samsung,exynos-pcie.yaml     |   2 +-
 .../bindings/pci/sifive,fu740-pcie.yaml       |   2 +-
 .../devicetree/bindings/pci/snps,dw-pcie.yaml | 135 ++++++++++++++++++
 .../pci/socionext,uniphier-pcie-ep.yaml       |   2 +-
 .../devicetree/bindings/pci/ti-pci.txt        |   4 +-
 .../devicetree/bindings/pci/uniphier-pcie.txt |   2 +-
 MAINTAINERS                                   |   4 +-
 19 files changed, 239 insertions(+), 143 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pci/designware-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/kirin-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml

-- 
2.31.1


