Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467FF6320EB
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 12:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbiKULld (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 06:41:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbiKULku (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 06:40:50 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D030B7F5
        for <linux-pci@vger.kernel.org>; Mon, 21 Nov 2022 03:40:44 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20221121114042epoutp03196211f76d05725a66d89f040c305723~plrVjHeD30989809898epoutp03b
        for <linux-pci@vger.kernel.org>; Mon, 21 Nov 2022 11:40:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20221121114042epoutp03196211f76d05725a66d89f040c305723~plrVjHeD30989809898epoutp03b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1669030842;
        bh=JAjDOi0UPBRuQmw/4iptna7NRf/JlL41ndKpEzYFly0=;
        h=From:To:Cc:Subject:Date:References:From;
        b=tOXXb0fJDGjW0la6WF+97EUwqp8wjDkeDvVKpd8u1pF1+aYc7oTTo8+UgM4nFjOcs
         7bo4tS0NRmOOb8u8Pcc4LALXv0ALe4ZNCn1pE1lei1AFgdjOVbfWaUisZZrXAKoybg
         LBaiXiCAnsRi7nieYnwuOYcVXE1eOFZuvWRGmNfU=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20221121114041epcas5p15cb082216d3d85dc735e10fec6c12d7b~plrUz3E5H0823008230epcas5p1j;
        Mon, 21 Nov 2022 11:40:41 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4NG56w51qsz4x9Pv; Mon, 21 Nov
        2022 11:40:40 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1A.AC.39477.8B36B736; Mon, 21 Nov 2022 20:40:40 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20221121104714epcas5p27508b91010c72117dd7116fc387b382f~pk8pO18NA1910019100epcas5p2a;
        Mon, 21 Nov 2022 10:47:14 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221121104714epsmtrp1af1d090f12c8ed21d5c7dfcf7b8f9719~pk8pNhkuC2438624386epsmtrp1P;
        Mon, 21 Nov 2022 10:47:14 +0000 (GMT)
X-AuditID: b6c32a4a-259fb70000019a35-e1-637b63b851c6
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CE.4B.14392.1375B736; Mon, 21 Nov 2022 19:47:13 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221121104710epsmtip18f866e7d637eafa26ab0fb923b4208e0~pk8ltSTLF1013310133epsmtip1s;
        Mon, 21 Nov 2022 10:47:09 +0000 (GMT)
From:   Shradha Todi <shradha.t@samsung.com>
To:     bhelgaas@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, kishon@ti.com, vkoul@kernel.org,
        lpieralisi@kernel.org, kw@linux.com, mani@kernel.org,
        arnd@arndb.de, gregkh@linuxfoundation.org, alim.akhtar@samsung.com,
        ajaykumar.rs@samsung.com, rcsekar@samsung.com,
        sriranjani.p@samsung.com, bharat.uppal@samsung.com,
        s.prashar@samsung.com, aswani.reddy@samsung.com,
        pankaj.dubey@samsung.com, p.rajanbabu@samsung.com,
        niyas.ahmed@samsung.com, chanho61.park@samsung.com
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        Shradha Todi <shradha.t@samsung.com>
Subject: [PATCH 0/6] Add PCIe support for Tesla FSD SoC
Date:   Mon, 21 Nov 2022 16:22:04 +0530
Message-Id: <20221121105210.68596-1-shradha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKJsWRmVeSWpSXmKPExsWy7bCmpu6O5Opkg5trFC0OvD/IYvFg3jY2
        i7+TjrFbHNq8ld3i2ssL7BZLmjIsLu/Xtph/5ByrRfPi9WwWF572sFn0vXjIbNHQ85vV4vKu
        OWwWZ+cdZ7OYsOobi0XLnxYWiwMfVjFaPJnyiNXi6MZgi0Vbv7BbzLqwg9Wide8Rdot5O+Yy
        WvQerrW4/WYdq8XOOyeYHaQ8fv+axOixYFOpx6ZVnWwed67tYfN4cmU6k8f+uWvYPTYvqffo
        27KK0eP4je1MHp83yQVwRWXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXm
        ptoqufgE6Lpl5gA9rqRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMCnQK07MLS7N
        S9fLSy2xMjQwMDIFKkzIzvh99zdrwXWBiucXnRoYu3i7GDk5JARMJK4tWcLYxcjFISSwm1Hi
        yJq57BDOJ0aJiZfvskI43xglHv2aCVTGAday+7sORHwvo8Sia7egOlqZJDbe72cGmcsmoCXR
        +LULzBYR+MQs8X2aFUgRs8ACRomHN1YygiSEBcwlDi2ZzgZiswioSsyd+5AJxOYVsJI4uW4r
        E8SB8hKrNxxgBmmWELjDIbHvyxo2iISLxJmTh5ghbGGJV8e3sEPYUhIv+9ug7HSJlZtnQNXk
        SHzbvARqqL3EgStzWEDeYRbQlFi/Sx8iLCsx9dQ6sBJmAT6J3t9PoMp5JXbMg7GVJb783cMC
        YUtKzDt2mRXC9pCYt+oF2CohgViJT1PXsE9glJ2FsGEBI+MqRsnUguLc9NRi0wKjvNRyeEQl
        5+duYgSnZy2vHYwPH3zQO8TIxMF4iFGCg1lJhLc+pjpZiDclsbIqtSg/vqg0J7X4EKMpMMwm
        MkuJJucDM0ReSbyhiaWBiZmZmYmlsZmhkjjv4hlayUIC6YklqdmpqQWpRTB9TBycUg1MK5ov
        2rMeOedQdP5/ZM0p1ZkdDj/8vK+7Xzxl82axQ+iDL7u3bCzIMirufJCtUfRMOa4t6u/W+/7N
        RoIffy5NivsjtCRr1yURiXsTq/YF8bEx1C2fpuHJdD59s6Ts6s2u4f4fVT/Yr/+RVJf0rV2v
        8HSLxnWfZR+eTUpJ+p+0rsmBYQ930ontrJsMfzarTvw3+8aH7145ckyZa/yW3HvNaN5uulrn
        YejN1yHqU68ZHTGdURb0YfNUzpC7oa1Mq2Zd9Yn8JBR1caHma1PuOXvNl0/SuZ6nl3/sgP7W
        S1GcOwTOndv9w2NO1qrdwuJGB6v4n28tDj9YmxPCki/n/eLOyyOtBomuoeXL4uSvqHuWKrEU
        ZyQaajEXFScCAPcRoG1YBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrILMWRmVeSWpSXmKPExsWy7bCSnK5heHWyQf9pY4sD7w+yWDyYt43N
        4u+kY+wWhzZvZbe49vICu8WSpgyLy/u1LeYfOcdq0bx4PZvFhac9bBZ9Lx4yWzT0/Ga1uLxr
        DpvF2XnH2SwmrPrGYtHyp4XF4sCHVYwWT6Y8YrU4ujHYYtHWL+wWsy7sYLVo3XuE3WLejrmM
        Fr2Hay1uv1nHarHzzglmBymP378mMXos2FTqsWlVJ5vHnWt72DyeXJnO5LF/7hp2j81L6j36
        tqxi9Dh+YzuTx+dNcgFcUVw2Kak5mWWpRfp2CVwZv+/+Zi24LlDx/KJTA2MXbxcjB4eEgInE
        7u86XYxcHEICuxkl7kzsZOli5ASKS0p8vriOCcIWllj57zk7RFEzk8TuvnOMIAk2AS2Jxq9d
        zCAJEYEeFonZW++AVTELLGGU2Hx3DxtIlbCAucShJdPBbBYBVYm5cx+CjeUVsJI4uW4r1Ap5
        idUbDjBPYORZwMiwilEytaA4Nz232LDAMC+1XK84Mbe4NC9dLzk/dxMjOFa0NHcwbl/1Qe8Q
        IxMH4yFGCQ5mJRFekWOVyUK8KYmVValF+fFFpTmpxYcYpTlYlMR5L3SdjBcSSE8sSc1OTS1I
        LYLJMnFwSjUwTf1poTnNZP/+3UdlN7mwmO26+vKf3blXLzq3L1ZlfDhX9dC8dwU3jwWuZnzP
        fI7hU7fT/SslT+8oblwwV5754dOidIYC8Q1h/Nu2hjD46wVrrGnk03zQH10quuLmddbVT6c0
        VuZz7QgNLFyR/r1Aq++m6awpR5dyuUxym2znsntCm/PSi85tulfTi35+q/XeeVHmWPf/lWve
        CK7u6d11p9B0xtS7be7tii/KXitz973TO7nHfYuLedeW35fO7nsSVyru0Kf88AYn/132FTXa
        +2R2eP178L2FP3h7fvjRF4lbHua15ZzcJpz1PFnzsKNYQg/rrJ4bdxs5eTw/r7J4d/354vnV
        L9byH6t4fYUv4ZoSS3FGoqEWc1FxIgDh3o1HBAMAAA==
X-CMS-MailID: 20221121104714epcas5p27508b91010c72117dd7116fc387b382f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221121104714epcas5p27508b91010c72117dd7116fc387b382f
References: <CGME20221121104714epcas5p27508b91010c72117dd7116fc387b382f@epcas5p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

FSD platform has three instances of DesignWare based PCIe IP,
one is in FSYS0 block and other two in FSYS1 block.
This patch series add required DT binding, DT file modifications,
Controller driver support and PHY driver support for the same.

This series needs following three patches to be merged before
this patchset
[1]: https://www.spinics.net/lists/netdev/msg854161.html
[2]: https://www.spinics.net/lists/netdev/msg854158.html
[3]: https://lore.kernel.org/all/20221013104024.50179-2-p.rajanbabu@samsung.com/


Shradha Todi (6):
  dt-bindings: phy: Add PCIe PHY bindings for FSD
  dt-bindings: PCI: Add PCIe controller bindings for FSD
  PCI: dwc: fsd: Add FSD PCIe Controller driver support
  phy: tesla-pcie: Add PCIe PHY driver support for FSD
  arm64: dts: fsd: Add PCIe support for Tesla FSD SoC
  misc: pci_endpoint_test: Add driver data for FSD PCIe controllers

 .../bindings/pci/tesla,pcie-fsd-ep.yaml       |  107 ++
 .../bindings/pci/tesla,pcie-fsd.yaml          |  117 ++
 .../bindings/phy/phy-tesla-pcie.yaml          |   75 ++
 arch/arm64/boot/dts/tesla/fsd-evb.dts         |   48 +
 arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi    |   65 ++
 arch/arm64/boot/dts/tesla/fsd.dtsi            |  171 +++
 drivers/misc/pci_endpoint_test.c              |    3 +
 drivers/pci/controller/dwc/Kconfig            |   35 +
 drivers/pci/controller/dwc/Makefile           |    1 +
 drivers/pci/controller/dwc/pcie-fsd.c         | 1021 +++++++++++++++++
 drivers/phy/samsung/Kconfig                   |   10 +
 drivers/phy/samsung/Makefile                  |    1 +
 drivers/phy/samsung/phy-tesla-pcie.c          |  397 +++++++
 include/linux/pci_ids.h                       |    2 +
 14 files changed, 2053 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/tesla,pcie-fsd-ep.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/tesla,pcie-fsd.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/phy-tesla-pcie.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-fsd.c
 create mode 100644 drivers/phy/samsung/phy-tesla-pcie.c

-- 
2.17.1

