Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A05133DA29B
	for <lists+linux-pci@lfdr.de>; Thu, 29 Jul 2021 13:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235358AbhG2L4i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jul 2021 07:56:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:46362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234975AbhG2L4g (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Jul 2021 07:56:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6D5B060F22;
        Thu, 29 Jul 2021 11:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627559793;
        bh=rncMA8vl1pvuHqou4S/RmnWLK3jVEoJLkOEd1M5JIhI=;
        h=From:To:Cc:Subject:Date:From;
        b=fLPd42EVOWcLWnoiOJqYIqiQrdQpBsRkPih7KHw2/dYfSsCL/ex6Yw6Ei1ZE4olea
         qvTcvRh7tHWtGa0rTNg7u1dZ043YkXofUH797NYyzPftgyWuiurqMjsMfOtf7CDiz0
         JW3TFrrUD2hVu+Z9ip58s2iQlmOTuGbY7EzlBMER6r3L6vZFd3X+p9zvUpvsmCgzPa
         Yf+vDpTMG8wYIANpPG9mPD1jZCnt+HrcjXfIVYjIR+Y80z74g/Ylz+oLhPHTEOC5Vw
         D+vV3WWYfd3cp7yjlsGbcwYuaRQ+3BZtJz0M0N0BDdmjLPa7qjWXCG3WCRTTStSUSj
         bhaXOB0bWulRw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m94eN-004d1p-6f; Thu, 29 Jul 2021 13:56:31 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: [PATCH 0/5] DT schema changes for HiKey970 PCIe hardware to work
Date:   Thu, 29 Jul 2021 13:56:23 +0200
Message-Id: <cover.1627559126.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

After our discussions, I'm opting to submit first the DT bindings for the
Kirin 970 PCIe support.

Patch 1 is there just because patch 2 needs. You already acked on it.

Patch 5 is also there just as an example of the entire stuff added to
the DTS file.

The core of this series are patches 2 to 4. They contain the conversion
of the kirin-pcie.txt file to the DT schema, and adds the needed
bindings.

Currently, it generates some warnings:

   Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.example.dt.yaml: pcie@f5000000: pcie@4,0:compatible: None of ['pciclass,0604'] are valid under the given schema
	From schema: Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
	
  Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.example.dt.yaml: pcie@4,0: reset-gpios: [[4294967295, 1, 0]] is too short

Not sure how/where to fix those. Perhaps at the pci-bus.yaml?

Please review.

Thanks!
Mauro

Manivannan Sadhasivam (1):
  arm64: dts: HiSilicon: Add support for HiKey 970 PCIe controller
    hardware

Mauro Carvalho Chehab (4):
  dt-bindings: PCI: kirin: Fix compatible string
  dt-bindings: PCI: kirin: convert kirin-pcie.txt to yaml
  dt-bindings: PCI: kirin: Add support for Kirin970
  dt-bindings: phy: Add bindings for HiKey 970 PCIe PHY

 .../bindings/pci/hisilicon,kirin-pcie.yaml    | 145 ++++++++++++++++++
 .../devicetree/bindings/pci/kirin-pcie.txt    |  50 ------
 .../devicetree/bindings/pci/snps,dw-pcie.yaml |   2 +-
 .../phy/hisilicon,phy-hi3670-pcie.yaml        |  86 +++++++++++
 MAINTAINERS                                   |   2 +-
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi     |  99 ++++++++++++
 6 files changed, 332 insertions(+), 52 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/kirin-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/phy/hisilicon,phy-hi3670-pcie.yaml

-- 
2.31.1


