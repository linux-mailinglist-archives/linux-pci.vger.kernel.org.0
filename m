Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8851B3DE585
	for <lists+linux-pci@lfdr.de>; Tue,  3 Aug 2021 06:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233837AbhHCEjO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Aug 2021 00:39:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:44786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233858AbhHCEjO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Aug 2021 00:39:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B051960F92;
        Tue,  3 Aug 2021 04:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627965543;
        bh=HPK28uCi1iOsyLvrqkwrijwn8LbLWGJtlix8oYTZDDo=;
        h=From:To:Cc:Subject:Date:From;
        b=Kyj4k5SBhiAKWQEG+JyRR8OhCCgFqaVfhG/apEvyqWEazuD+CBUaCAT/EwzCU+Mbm
         71MeZCySfJJRCXqhtrPYC/lJkbJFNBqBtu9QTC7dNKaQxy2DMJT2JqMiH6RDUgWlP3
         s8m/0EgAimHcumC/KV69n5JqLNF3UzhlPM62b8M/SHKrKjTzAQ5qfT9YOKhH+N8mVP
         wn27eqMPRz6w8mnDZBE0ZaaGL/UfRhJ6TxQs43sguM8dZMQRKdFKWl1/88BrTWCiYS
         KCBDpZ3gfxEP0dGQUG0nTg4Ji2YAdZ1otY+BNeUUzP6YH9Nxe3KU57Ehm2BuEU211N
         C/7pcf7MJRtOg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mAmCj-00D8KA-EN; Tue, 03 Aug 2021 06:39:01 +0200
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
Subject: [PATCH v3 0/4] DT schema changes for HiKey970 PCIe hardware to work
Date:   Tue,  3 Aug 2021 06:38:54 +0200
Message-Id: <cover.1627965261.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

That's the third version of the DT bindings for Kirin 970 PCIE and its
corresponding PHY. 

It is identical to v2, except by:
	-          pcie@7,0 { // Lane 7: Ethernet
	+          pcie@7,0 { // Lane 6: Ethernet

at Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml

IMO, the best would be to merge this series via your tree, as it
depends on the patch converting the DT bindings for the PCIe DWC
driver.

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
 .../phy/hisilicon,phy-hi3670-pcie.yaml        |  86 ++++++++++
 MAINTAINERS                                   |   2 +-
 5 files changed, 248 insertions(+), 52 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/kirin-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/phy/hisilicon,phy-hi3670-pcie.yaml

-- 
2.31.1


