Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCFFF3C6F83
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jul 2021 13:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235968AbhGMLVA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Jul 2021 07:21:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:47956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235390AbhGMLU6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Jul 2021 07:20:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 344AA61178;
        Tue, 13 Jul 2021 11:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626175088;
        bh=G3DpPuSACBy7CTePMGBCkcBIAOUG+KzTOSbhqPO32E0=;
        h=From:To:Cc:Subject:Date:From;
        b=ESQW+vzQ0c21D41buSWvccNUGNN5X8LojV5B2NWlcjYl2b6wJFnmkm9KDpYL3TNL4
         rrN9gvVBsEag7eI0F+SoyUW+J0OXR/jx+8pQ+G3L2wf0MKChDFnsWYxxs9UBsbPGb3
         aBVcjc4QeCYJH34IodncdvAo5y3Of1z7bEwT8A1aVLwyz+qdfP6FuEeiSnp3LCwFXm
         cFq3kW0T54mQ9bcWKq1SWiMHvSj/V/egkSpQ7K0Vqggii237AqGFUdSwVvv5vFtfNp
         oUqISdXQa/Du+5om3X1ugLJoi8bcUNt+w74aGT3o97FhKjPGPWJ0d9lgRc7fXGeDYf
         468P+XCrKyARQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m3GQK-006b3Y-Rv; Tue, 13 Jul 2021 13:18:00 +0200
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
Subject: [PATCH v4 0/5] convert designware-pcie.txt and kirin-pcie.txt to yaml
Date:   Tue, 13 Jul 2021 13:17:50 +0200
Message-Id: <cover.1626174242.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

This series (in particular, the last patch) depends on this series:
	https://lore.kernel.org/lkml/cover.1626157454.git.mchehab+huawei@kernel.org/

It convert designware-pcie.txt and kirin-pcie.txt to DT schema.

This series uses a different strategy than v4: after doing lots of tests and
trying to tweak the syntax, I opted to create two files instead of one.

The first one (snps,dw-pcie.yaml) uses the pci-bus.yaml schema.
The second one (add snps,dw-pcie-ep.yaml) uses the pci-ep.yaml schema.

Without splitting it into two, I was unable to find a way that would work,
due to the need of using:

	AllOf:
	   - $ref: /schemas/pci/pci-bus.yaml#

For the non-endpoint part.

In order to make easier to review, I also opted to split the patch into
4 ones:

patch 1:
   adds the Designware PCI DT schema;
patch 2:
   adds the Designware PCI endpoint DT schema;
patch 3:
   changes the existing references to point to the new schemas.
   On yaml files, it uses the proper $ref to point to the right DT schema;
patch 4
   drops the old txt file.

Patch5 is independent: it converts the pcie-kirin.txt to DT schema and
adds a reference to the newly-converted DWC schema.

It should be noticed that I had to make a few amends at the "reg" field
on patches 1 and 2, in order to avoid warnings about some properties
found on some DWC-dependent DT schemas, as some have "addr_space",
"link", "app" and "elbi".

With this change, it now passes "make dt_binding_check".

Mauro Carvalho Chehab (5):
  dt-bindings: PCI: add snps,dw-pcie.yaml
  dt-bindings: PCI: add snps,dw-pcie-ep.yaml
  dt-bindings: PCI: update references to Designware schema
  dt-bindings: PCI: remove designware-pcie.txt
  dt-bindings: PCI: kirin-pcie.txt: Convert it to yaml

 .../bindings/pci/amlogic,meson-pcie.txt       |  4 +-
 .../bindings/pci/axis,artpec6-pcie.txt        |  2 +-
 .../bindings/pci/designware-pcie.txt          | 77 ---------------
 .../bindings/pci/fsl,imx6q-pcie.txt           |  2 +-
 .../bindings/pci/hisilicon,kirin-pcie.yaml    | 81 ++++++++++++++++
 .../bindings/pci/hisilicon-histb-pcie.txt     |  2 +-
 .../devicetree/bindings/pci/kirin-pcie.txt    | 41 --------
 .../bindings/pci/layerscape-pci.txt           |  2 +-
 .../bindings/pci/nvidia,tegra194-pcie.txt     |  5 +-
 .../devicetree/bindings/pci/pci-armada8k.txt  |  2 +-
 .../devicetree/bindings/pci/pcie-al.txt       |  2 +-
 .../devicetree/bindings/pci/qcom,pcie.txt     | 14 +--
 .../bindings/pci/samsung,exynos-pcie.yaml     |  4 +-
 .../bindings/pci/sifive,fu740-pcie.yaml       |  4 +-
 .../bindings/pci/snps,dw-pcie-ep.yaml         | 90 +++++++++++++++++
 .../devicetree/bindings/pci/snps,dw-pcie.yaml | 96 +++++++++++++++++++
 .../pci/socionext,uniphier-pcie-ep.yaml       |  4 +-
 .../devicetree/bindings/pci/ti-pci.txt        |  4 +-
 .../devicetree/bindings/pci/uniphier-pcie.txt |  2 +-
 MAINTAINERS                                   |  5 +-
 20 files changed, 297 insertions(+), 146 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pci/designware-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/kirin-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml

-- 
2.31.1


