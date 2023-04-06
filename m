Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7509E6D94BE
	for <lists+linux-pci@lfdr.de>; Thu,  6 Apr 2023 13:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjDFLLt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Apr 2023 07:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236180AbjDFLLs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Apr 2023 07:11:48 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B981E83FB;
        Thu,  6 Apr 2023 04:11:46 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 781DB24E0AE;
        Thu,  6 Apr 2023 19:11:45 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 6 Apr
 2023 19:11:45 +0800
Received: from ubuntu.localdomain (183.27.97.179) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 6 Apr
 2023 19:11:44 +0800
From:   Minda Chen <minda.chen@starfivetech.com>
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>,
        Minda Chen <minda.chen@starfivetech.com>
Subject: [PATCH v1 0/3] Add JH7110 PCIe driver support
Date:   Thu, 6 Apr 2023 19:11:39 +0800
Message-ID: <20230406111142.74410-1-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.97.179]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patchset adds PCIe driver for the StarFive JH7110 SoC.
The patch has been tested on the VisionFive 2 board. The test
devices include M.2 NVMe SSD and Realtek 8169 Ethernet adapter.

This patchset should be applied after the patchset [1], [2], [3] and[4]:
[1] https://patchwork.kernel.org/project/linux-riscv/cover/20230314124404.117592-1-xingyu.wu@starfivetech.com/
[2] https://lore.kernel.org/all/20230315055813.94740-1-william.qiu@starfivetech.com/
[3] https://patchwork.kernel.org/project/linux-phy/cover/20230315100421.133428-1-changhuang.liang@starfivetech.com/
[4] https://patchwork.kernel.org/project/linux-usb/cover/20230406015216.27034-1-minda.chen@starfivetech.com/

This patchset is base on v6.3-rc4

patch 1 is PCIe dt-binding document.
patch 2 is PCIe 2.0 driver codes.
patch 3 is PCIe device tree configuration.


Minda Chen (3):
  dt-binding: pci: add JH7110 PCIe dt-binding documents.
  pcie: starfive: add StarFive JH7110 PCIe driver.
  riscv: dts: starfive: add PCIe dts configuration for JH7110

 .../bindings/pci/starfive,jh7110-pcie.yaml    | 163 +++
 MAINTAINERS                                   |   6 +
 .../jh7110-starfive-visionfive-2.dtsi         |  58 ++
 arch/riscv/boot/dts/starfive/jh7110.dtsi      |  88 ++
 drivers/pci/controller/Kconfig                |   8 +
 drivers/pci/controller/Makefile               |   1 +
 drivers/pci/controller/pcie-starfive.c        | 958 ++++++++++++++++++
 7 files changed, 1282 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml
 create mode 100644 drivers/pci/controller/pcie-starfive.c


base-commit: 197b6b60ae7bc51dd0814953c562833143b292aa
prerequisite-patch-id: 55390537360f25c8b9cbfdc30b73ade004f436f7
prerequisite-patch-id: bb939c0c7c26b08addfccd890f9d3974b6eaec53
prerequisite-patch-id: 8a6f135bcabdad4a4bfb21f0c6a0ffd2bb57efe7
prerequisite-patch-id: c2366f993a9d85e28c06d8d09f064dd5e8b29a61
prerequisite-patch-id: 50d53a21f91f4087fc80b6f1f72864adfb0002b9
prerequisite-patch-id: 0df3703af91c30f1ca2c47f5609012f2d7200028
prerequisite-patch-id: 89f049f951e5acf75aab92541992f816fd0acc0d
prerequisite-patch-id: 551fae54377090044c3612fca9740a9b359abdd2
prerequisite-patch-id: c7fdf904f398d478f0ed6d57eb878982bc73329d
prerequisite-patch-id: 1b2d0982b18da060c82134f05bf3ce16425bac8d
prerequisite-patch-id: 090ba4b78d47bc19204916e76fdbc70021785388
prerequisite-patch-id: a5d9e0f7d4f8163f566678894cf693015119f2d9
prerequisite-patch-id: 4637a8fa2334a45fa6b64351f4e9e28d3e2d60d3
prerequisite-patch-id: 32647ec60a3b614e1c59ec8e54cb511ae832c22f
prerequisite-patch-id: aa06658ecf89c92d0dfdd6a4ba6d9e6e67532971
prerequisite-patch-id: 258ea5f9b8bf41b6981345dcc81795f25865d38f
prerequisite-patch-id: 8b6f2c9660c0ac0ee4e73e4c21aca8e6b75e81b9
prerequisite-patch-id: dbb0c0151b8bdf093e6ce79fd2fe3f60791a6e0b
prerequisite-patch-id: e7773c977a7b37692e9792b21cc4f17fa58f9215
prerequisite-patch-id: d57e95d31686772abc4c4d5aa1cadc344dc293cd
prerequisite-patch-id: 9f911969d0a550648493952c99096d26e05d4d83
prerequisite-patch-id: 41eddeabff082d08a76d8da523f90da4b5218d28
prerequisite-patch-id: 2ddada18ab6ea5cd1da14212aaf59632f5203d40
prerequisite-patch-id: 398744c61913c76a35754de867c4f820ca7a8d99
prerequisite-patch-id: 1a2c49c1cf81607f062f35898457037d86598cf9
prerequisite-patch-id: f59269382164b5d642a5e10443ca447f5caa595c
prerequisite-patch-id: 1babe83d6bf999bad17584dc595480f9070a5369
prerequisite-patch-id: d95ea69f88a048ef702dceed0f2edee31e6fdfd2
prerequisite-patch-id: 77be3d122d66df813f13088141ce27b21107a341
prerequisite-patch-id: 9fbb7ad1dd258bb8ff5946c4a0e59de4bfd82a04
prerequisite-patch-id: a02411a8fe009acc0888e4a7d60233c9ee5a1e71
prerequisite-patch-id: 6f6984916dffd0cc66aa733c9b6bd3a55495a50c
prerequisite-patch-id: 584c256c9acb52ee2773d0c81c3f4977fc18155a
prerequisite-patch-id: b37ac15032973e1fcd918f157c82a0606775c9e9
prerequisite-patch-id: 999c243dca89d56d452aa52ea3e181358b5c1d80
prerequisite-patch-id: ca653566085079839fb3dc1e722effafbc8109a4
prerequisite-patch-id: 2fe72c216673efe690db54cbf500ba7f15e6247a
prerequisite-patch-id: 776afb78743657e4a6bfebd2cd8a44c5c9017ee2
prerequisite-patch-id: c9b92e6d1531d0a9fb122d9d038cc3d9df380e0f
prerequisite-patch-id: c0fa5b1d697ab8434954a81a5992cf66d0cfafb8
prerequisite-patch-id: 1cca26d07ec4bc7ea07b1c6815631c8bf8224366
prerequisite-patch-id: 331bafaf79b4bb7c09152eb16598cdc9ba8096e9
prerequisite-patch-id: 9f2286829c70b6940c83834b150df685ab02c591
prerequisite-patch-id: b25b8295d7b8fdf1b45b634df5c2a7a7f9dfba76
prerequisite-patch-id: 9d3aab2e4428be5b1235a57dad3bf14eae5275fd
prerequisite-patch-id: 6090abbef6164dd0cc87d44c486a7eb1b5f64946
-- 
2.17.1

