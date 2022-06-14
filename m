Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C15754A3B7
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jun 2022 03:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348171AbiFNBhB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jun 2022 21:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234895AbiFNBhA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jun 2022 21:37:00 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0257733E00
        for <linux-pci@vger.kernel.org>; Mon, 13 Jun 2022 18:36:59 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220614013657epoutp03cc8dadb2c22035f2d39a0d73afd369a6~4WOgsgshl2945329453epoutp03j
        for <linux-pci@vger.kernel.org>; Tue, 14 Jun 2022 01:36:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220614013657epoutp03cc8dadb2c22035f2d39a0d73afd369a6~4WOgsgshl2945329453epoutp03j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1655170617;
        bh=jA5LhY2FU1o8vJngFMJ1TU1lJY0CuOKBbhd2Dp2tDos=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=Vjjx2N65kgRDYZY7Sp7dLCTBcfIHE+HxMbLG2WRiOhywO9ILdIKEZVJ0sCeLQbDDB
         Wd1wUmbFe+pNaK54Ti0byFI59+6NOUnufrJRfY0O8SAn8l29ZZve6+r8Qmcy/hhrHi
         YUS0FdzkqYhZbwh9t+b74aToy58/NIRvd6cpLnsk=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220614013656epcas2p2256307430c211ec0bd8ea70dcb1445dd~4WOgFFOWx0196001960epcas2p2m;
        Tue, 14 Jun 2022 01:36:56 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.99]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4LMWJ72XPhz4x9Q1; Tue, 14 Jun
        2022 01:36:55 +0000 (GMT)
X-AuditID: b6c32a46-f8bff70000002624-07-62a7e637a250
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        9D.B7.09764.736E7A26; Tue, 14 Jun 2022 10:36:55 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v3 5/5] MAINTAINERS: Add Axis ARTPEC-8 PCIe PHY maintainers
Reply-To: wangseok.lee@samsung.com
Sender: Wangseok Lee <wangseok.lee@samsung.com>
From:   Wangseok Lee <wangseok.lee@samsung.com>
To:     Wangseok Lee <wangseok.lee@samsung.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
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
        Yeeun Kim <yeeun119.kim@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20220614011616epcms2p7dcaa67c53b7df5802dd7a697e2d472d7@epcms2p7>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220614013654epcms2p6b8f11dd03c42b1dfcd908ed3e59c13d8@epcms2p6>
Date:   Tue, 14 Jun 2022 10:36:54 +0900
X-CMS-MailID: 20220614013654epcms2p6b8f11dd03c42b1dfcd908ed3e59c13d8
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA12Tf1CTZQDHe/ZuLy9205cJ9RzeAb2kgAT7IbBnCV0BZwu0W8dV1h/RC3sF
        ZGxz71ZWGitEiaaQkiBwYyWB8qsCgSEJ3piuuxphWfw4IPQw4GBSiYkiFWNDu/77PN/7Pt/n
        +T4/CEwwiAcSOWo9o1PTKgpfx+3oi5BGSX+rzxD9cIxEtR9moxlbBKqx9/NQd0U9B5369HsM
        TdkqMfTnoc1o4IYJRzOV4zgympZ4yD73B4Z6HWc56Kfz1Thymh04Km34i4vmlqZ9UP/pHFR4
        we6Duka/xdBon5OL7rXf5zwbIG8yNwH5YItCbmk1yFsbPsLlk1fLOfK22nz5sXMNQO4Y6uTI
        b7UGKXxfz43PZmglowth1JkaZY46K4FKTUtPSo+NE4mjxDIkpULUdB6TQCXvVETtyFGtNKNC
        3qJVhhVJQbMsJXwmXqcx6JmQbA2rT6AYrVKllWqjWTqPNaizotWM/mmxSCSJXTG+mZs901cO
        tFXE/oqxMmAE/+DFgCAgGQMb+6XFYB0hIK0AftM9Bdw6n/SDy9aNxcCX2EimwsISM+5mAUlB
        a5MZ8+hCOHjmY56bcTIK/n16Bnfn+JPVODw+PcVzDzDSAmDvUg9wuyDJhxVHbnA9vAl21rev
        6r7ki/CzS8c5Hj0cLtYdxTwcAIcbXT5rPH+5xpvjDwvHnV6PH5y42+3VA6Fl0sbz8Huwd3nJ
        m2kEsORXxlNYCK2D2zwdd8HFxp1uB5fcDE+M2r0pybC21rmagpHBsNNVjbntGBkBvzwv9ISE
        QvsId62T8esln/8zRq6HRX3LD3SredK7ly3QfLYLKwWhlQ/PufI/a1U+XMsCsAbwGKNl87IY
        VqKVPLjZTE1eK1h94Vt3WEGZ6/doG+AQwAYggVH+/BNX6jIEfCX9zruMTpOuM6gY1gZiV1p+
        ggUGZGpWvohany6OkYli4uLEUkmsSEo9zk9RfkULyCxaz+QyjJbRrc3jEL6BRk7ekGx24Lv5
        t9eLtldbHLNP3LK30YfuHih/rqYv+M4G18EFouWl+eGRR95gk2ypBa5IWXg4NWfUXpg49wKP
        u1yOhDVXU3rCUu6pILpk+qDUEmmexMb2XR9OIhNfuZb4xfNpE84Cv1O/MLe35A/oS5Kvtz06
        rRq54jhD7xbkKNISQy+2zRJHXjbN7+kK24uP1b7qnG9vv+wqDLsjG9sk3H4gruPgyfH6ize3
        3WTj9hRNcVomgyRBEz2NzVWRsR2v1eWnHw1+H/AX4nWHwX4Fb99ijcFUJTOWgcMJ4gKryA9k
        DN8vesrB1CU0N//YruSES/SfXyvcbbr989DeyO4F+skNFJfNpsVbMR1L/wuB9p+sagQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220614011616epcms2p7dcaa67c53b7df5802dd7a697e2d472d7
References: <20220614011616epcms2p7dcaa67c53b7df5802dd7a697e2d472d7@epcms2p7>
        <CGME20220614011616epcms2p7dcaa67c53b7df5802dd7a697e2d472d7@epcms2p6>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add maintainer for Axis ARTPEC-8 PCIe PHY.

Add Jesper Nilsson <jesper.nilsson@axis.com> and
Lars Persson <lars.persson@axis.com> as maintainer for these files.

ARTPEC-8 is the SoC platform of Axis Communications and PCIe PHY is designe
d based on Samsung PHY.

Signed-off-by: Wangseok Lee <wangseok.lee@samsung.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 475e2836..5ad377f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1876,12 +1876,14 @@ M:	Jesper Nilsson <jesper.nilsson@axis.com>
 M:	Lars Persson <lars.persson@axis.com>
 L:	linux-arm-kernel@axis.com
 S:	Maintained
+F:	Documentation/devicetree/bindings/phy/axis,artpec8-pcie-phy.yaml
 F:	Documentation/devicetree/bindings/pinctrl/axis,artpec6-pinctrl.txt
 F:	arch/arm/boot/dts/artpec6*
 F:	arch/arm/mach-artpec
 F:	drivers/clk/axis
 F:	drivers/crypto/axis
 F:	drivers/mmc/host/usdhi6rol0.c
+F:	drivers/phy/artpec/phy-artpec*
 F:	drivers/pinctrl/pinctrl-artpec*
 
 ARM/ASPEED I2C DRIVER
-- 
2.9.5
