Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F86157B093
	for <lists+linux-pci@lfdr.de>; Wed, 20 Jul 2022 07:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235678AbiGTFvO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Jul 2022 01:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiGTFvN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jul 2022 01:51:13 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245D449B79
        for <linux-pci@vger.kernel.org>; Tue, 19 Jul 2022 22:51:12 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220720055110epoutp03d01ea731bf72fabffa3cf46e03fd2112~Dc6v0uBKv0969609696epoutp03X
        for <linux-pci@vger.kernel.org>; Wed, 20 Jul 2022 05:51:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220720055110epoutp03d01ea731bf72fabffa3cf46e03fd2112~Dc6v0uBKv0969609696epoutp03X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1658296270;
        bh=3p3lLHwRdWTjXTaLmAUolgHNqvzHyulS4Li8okLvbgE=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=FrY7l6JZrFMBhfnz0E/HmSU4jIo2wYVFJUQOgH9hev5lK2c9u2eBFzdM1C/goXMzz
         oMXU/qJU9K2pmodhq9chnmCbM4pr5B6+wBK1tG04SlwU5N+jBG+yRl7biKbMiNnO/n
         Bkr8DHBNNBhLRLyernrnk5h6oikQBuBbMxQqlDsk=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220720055109epcas2p44a64871e83de0d62ac39ecd83225fd00~Dc6vNK3gQ0172601726epcas2p4S;
        Wed, 20 Jul 2022 05:51:09 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.99]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4LnlDs00Grz4x9Q6; Wed, 20 Jul
        2022 05:51:08 +0000 (GMT)
X-AuditID: b6c32a46-0b9ff700000025b2-12-62d797cc5a28
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        FB.62.09650.CC797D26; Wed, 20 Jul 2022 14:51:08 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v4 0/5] Add support for Axis, ARTPEC-8 PCIe driver
Reply-To: wangseok.lee@samsung.com
Sender: Wangseok Lee <wangseok.lee@samsung.com>
From:   Wangseok Lee <wangseok.lee@samsung.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "lars.persson@axis.com" <lars.persson@axis.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "kw@linux.com" <kw@linux.com>,
        "linux-arm-kernel@axis.com" <linux-arm-kernel@axis.com>,
        "kernel@axis.com" <kernel@axis.com>
CC:     Moon-Ki Jun <moonki.jun@samsung.com>,
        Sang Min Kim <hypmean.kim@samsung.com>,
        Dongjin Yang <dj76.yang@samsung.com>,
        Yeeun Kim <yeeun119.kim@samsung.com>,
        Wangseok Lee <wangseok.lee@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220720055108epcms2p563c65b3de6333ccbc68386aa2471a800@epcms2p5>
Date:   Wed, 20 Jul 2022 14:51:08 +0900
X-CMS-MailID: 20220720055108epcms2p563c65b3de6333ccbc68386aa2471a800
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGJsWRmVeSWpSXmKPExsWy7bCmhe6Z6deTDM7OM7FY0pRh8fKQpsX8
        I+dYLXbPWM5kMXPqGWaL54dmMVt8alG1uPC0h83i5ax7bBYNPb9ZLY68+chssf/4SiaLy7vm
        sFmcnXeczWLCqm8sFm9+v2C3OLc406J17xF2i513TjBb3Dl8lsXi19Y/TA6iHmvmrWH0uL4u
        wGPBplKPTas62TyeXJnO5LF5Sb1H35ZVjB7Hb2xn8vi8SS6AMyrbJiM1MSW1SCE1Lzk/JTMv
        3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfoMyWFssScUqBQQGJxsZK+nU1RfmlJ
        qkJGfnGJrVJqQUpOgXmBXnFibnFpXrpeXmqJlaGBgZEpUGFCdsapY/8YC/4oV/ycvIC9gfGn
        TBcjJ4eEgInEwu0z2LoYuTiEBHYwSryYfI+xi5GDg1dAUOLvDmEQU1jASWJvdzBIuZCAksSO
        NfOYQWxhAX2J6yu6WUFsNgFdiX+LX7KB2CICn1klru8RBBnJLHCSUWL54fVsELt4JWa0P2WB
        sKUlti/fyghha0j8WNbLDGGLStxc/ZYdxn5/bD5UjYhE672zUDWCEg9+7oaKS0kseHKIFcKu
        ltj/9zcThN3AKNF/PxXkfgmgQ3dcNwYJ8wr4Slx8fg5sDIuAqkTn7DNQ57hInF2wCWwts4C8
        xPa3c5hBWpkFNCXW79KHmKIsceQWC8wjDRt/s6OzmQX4JDoO/4WL75j3BOoYNYl5K3cyQ4yR
        kdj60n8Co9IsRCjPQrJ2FsLaBYzMqxjFUguKc9NTi40KjOARm5yfu4kRnMC13HYwTnn7Qe8Q
        IxMH4yFGCQ5mJRHep4XXk4R4UxIrq1KL8uOLSnNSiw8xmgI9PJFZSjQ5H5hD8kriDU0sDUzM
        zAzNjUwNzJXEeb1SNiQKCaQnlqRmp6YWpBbB9DFxcEo1MK01KWT+dXjPZlXt0NtCr48tVmnL
        EDt7Mz9DolWAK/Qe978PvtpTV1RIuf+wvRaR3l9gdEpIoEn3jfpF0YnLbquEHTyjcYnxcfaB
        q+8W1bvOOvYr8HxQuI3gMxPnF3F1gk46hw4z19scd2J48dNw3y61S2+2z777mD/Re0JY/e81
        XtP6Sxds7WBYEJ0rtHPbrvkOX62dphtpX0q5fEfpcdMKnaO682IUo49dkq1iDA/YdeFf0d8w
        9/132Ntn7Vg7radC0rc6O0FuQq1S9Ye/Gc+qlm4+Mbtxxekr2Xs3/d/1sb2/4ML0zWKXpjtv
        KHyx5NbZBaoleUnPT+U/1VtStXGXmOfGOxEhtrUvr9ccDxRUYinOSDTUYi4qTgQAQlQM7GkE
        AAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220720055108epcms2p563c65b3de6333ccbc68386aa2471a800
References: <CGME20220720055108epcms2p563c65b3de6333ccbc68386aa2471a800@epcms2p5>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This v4 patchset is improvement several review comments received from patchset v3.

Main changes since v3 [3]:
dt-bindings: pci: Add ARTPEC-8 PCIe controller
-add missing properties

dt-bindings: phy: Add ARTPEC-8 PCIe phy
-add "fsys-sysreg" to properties
-modify the "lcpll-ref-clk" and "clocks" in properties
 "lcpll-ref-clk" is custom properties, so add 'vendor', type(enum),
 description
 Add the maxItem in clocks, add clock-names in properties

PCI: axis: Add ARTPEC-8 PCIe controller driver
-remove unnecessary enum type
-fix indentation

phy: Add ARTPEC-8 PCIe PHY driver
-modify to use GENMASK
-fix indentation
-remove the driver data

Main changes since v2 [2]:
dt-bindings: pci: Add ARTPEC-8 PCIe controller
-modify version history to fit the linux commit rule
-remove 'Device Tree Bindings' on title
-remove the interrupt-names, phy-names entries
-remove '_clk' suffix
-add the compatible entries on required
-change node name to soc from artpec8 on examples

dt-bindings: phy: Add ARTPEC-8 PCIe phy
-modify version history to fit the linux commit rule
-remove 'Device Tree Bindings' on title
-remove clock-names entries
-change node name to soc from artpec8 on excamples

PCI: axis: Add ARTPEC-8 PCIe controller driver
-add 'COMPILE_TEST' and improvement help on kconfig
-reorder obj on makefile
-use clk_bulk_api
-remove unnecessary comment
-redefine the ELBI register to distinguish between offset and
 bit definition
-improvement order local variable of function
-remove unnecessary local return variable

phy: Add ARTPEC-8 PCIe PHY driver
-remove unnecessary indentation
-redefine local struct to statis const
-add static const to struct that requires static const definition
-remove wrappers on writel and readl

Main changes since v1 [1]:
-'make dt_binding_check' result improvement
-Add the missing property list
-improvement review comment of Krzysztof on driver code
-change folder name of phy driver to axis from artpec

[3] https://lore.kernel.org/lkml/20220614011616epcms2p7dcaa67c53b7df5802dd7a697e2d472d7@epcms2p7/T
[2] https://lore.kernel.org/lkml/20220613015023epcms2p70e6700a99042d4deb560e40ab5397001@epcms2p7/T/
[1] https://lore.kernel.org/lkml/20220328014430epcms2p7063834feb0abdf2f38a62723c96c9ff1@epcms2p7/

--------------------------------------------------------------
This series patches include newly PCIe support for Axis ARTPEC-8 SoC.
ARTPEC-8 is the SoC platform of Axis Communications.
PCIe controller driver and phy driver have been newly added.
There is also a new MAINTAINER in the addition of phy driver.
PCIe controller is designed based on Design-Ware PCIe controller IP
and PCIe phy is desinged based on SAMSUNG PHY IP.
It also includes modifications to the Design-Ware controller driver to 
run the 64bit-based ARTPEC-8 PCIe controller driver.
It consists of 6 patches in total.

This series has been tested on AXIS SW bring-up board 
with ARTPEC-8 chipset.
--------------------------------------------------------------

Wangseok Lee (5):
  dt-bindings: pci: Add ARTPEC-8 PCIe controller
  dt-bindings: phy: Add ARTPEC-8 PCIe phy
  PCI: axis: Add ARTPEC-8 PCIe controller driver
  phy: Add ARTPEC-8 PCIe PHY driver
  MAINTAINERS: Add Axis ARTPEC-8 PCIe PHY maintainers

 .../bindings/pci/axis,artpec8-pcie-ep.yaml         | 138 ++++
 .../devicetree/bindings/pci/axis,artpec8-pcie.yaml | 148 ++++
 .../bindings/phy/axis,artpec8-pcie-phy.yaml        |  85 +++
 MAINTAINERS                                        |   2 +
 drivers/pci/controller/dwc/Kconfig                 |  31 +
 drivers/pci/controller/dwc/Makefile                |   1 +
 drivers/pci/controller/dwc/pcie-artpec8.c          | 788 +++++++++++++++++++++
 drivers/phy/Kconfig                                |   1 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/axis/Kconfig                           |   9 +
 drivers/phy/axis/Makefile                          |   2 +
 drivers/phy/axis/phy-artpec8-pcie.c                | 753 ++++++++++++++++++++
 12 files changed, 1959 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/axis,artpec8-pcie-ep.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/axis,artpec8-pcie.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/axis,artpec8-pcie-phy.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-artpec8.c
 create mode 100644 drivers/phy/axis/Kconfig
 create mode 100644 drivers/phy/axis/Makefile
 create mode 100644 drivers/phy/axis/phy-artpec8-pcie.c

-- 
2.9.5
