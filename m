Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 579E53DB60C
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jul 2021 11:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238368AbhG3Jed (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Jul 2021 05:34:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:51866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238347AbhG3Jeb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Jul 2021 05:34:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 054EC60F5C;
        Fri, 30 Jul 2021 09:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627637667;
        bh=NXq0Hi8b5aSirn3qb7AXIhIajJhTyFfSBKSnQTXScPM=;
        h=From:To:Cc:Subject:Date:From;
        b=W+OmIie5D9+AAKg0xteqArun4Pw98MS8YQhGVTQMQUY+VKi658JxbAAyXq7mGQkoC
         sHiuxoBvTQ4/K7rI1jDMq8v5GtLbkxngrZ16bKXjEmp8MWBBbT/dTTYFjn3v2GwMwz
         54gEATJjcLJtA1DELiw2c63J7bHXZUt2qKwsWcGqtHwHUUm1UHJlEY7BpHHo2NvJnZ
         ikuCYiZypFgFts56QXjSDFJongb4Dayw01KmjHIgXMkXTfZ3MvsOQXCkZfh83JESs4
         YU4C/RHNLWNEBjhapgr3F8agRL2VE2XgnFUrsBWdx53KrByc+1JUTSqnX6WXNF3Gfn
         BzH2FMLgJHo/Q==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m9OuO-006qw0-El; Fri, 30 Jul 2021 11:34:24 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-phy@lists.infradead.org
Subject: [PATCH v2 0/4] DT schema changes for HiKey970 PCIe hardware to work
Date:   Fri, 30 Jul 2021 11:34:17 +0200
Message-Id: <cover.1627637448.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

That's the second version of the DT bindings for Kirin 970 PCIE and its
corresponding PHY.

IMO, the best would be to merge this series via your tree, as it
depends on the patch converting the DT bindings for the PCIe DWC
driver.

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


