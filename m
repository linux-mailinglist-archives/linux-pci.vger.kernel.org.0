Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D06E4E8BB8
	for <lists+linux-pci@lfdr.de>; Mon, 28 Mar 2022 03:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237351AbiC1BqU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Mar 2022 21:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236175AbiC1BqR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 27 Mar 2022 21:46:17 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997BC4FC52
        for <linux-pci@vger.kernel.org>; Sun, 27 Mar 2022 18:44:36 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220328014434epoutp02a1c3ee536d046802d097fc0c03d4cf40~gaA5X_DyM1104011040epoutp02S
        for <linux-pci@vger.kernel.org>; Mon, 28 Mar 2022 01:44:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220328014434epoutp02a1c3ee536d046802d097fc0c03d4cf40~gaA5X_DyM1104011040epoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1648431874;
        bh=1DVfOb/VDpCbE+hBNZbGBz9ZRSgFDj3w/wRTXPKyIrE=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=oSJDYevXDme5VetXSy1E5h+RydZZtrUlEBjP+p8f3kNsiSIlTP5fO3pr6BZWygEIr
         vRdDMrqm3YiUvZDgtoNBBjFqG1e+qPuwxoypSHULffsV3bcfAuK+macdM2RA7VfDcK
         EGEYLERH44PsoFtqXPJQuFyAbu8fhXoi9MMvkQ60=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220328014433epcas2p3af42d44409d77a51e2e9056bd3d67002~gaA4tGebn1109011090epcas2p3u;
        Mon, 28 Mar 2022 01:44:33 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.101]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4KRb8v2mxJz4x9Q3; Mon, 28 Mar
        2022 01:44:31 +0000 (GMT)
X-AuditID: b6c32a47-81bff700000063c4-b7-624112fe2eaf
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        DA.AE.25540.EF211426; Mon, 28 Mar 2022 10:44:30 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH 0/5] Add support for Axis, ARTPEC-8 PCIe driver
Reply-To: wangseok.lee@samsung.com
Sender: =?UTF-8?B?7J207JmV7ISd?= <wangseok.lee@samsung.com>
From:   =?UTF-8?B?7J207JmV7ISd?= <wangseok.lee@samsung.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "lars.persson@axis.com" <lars.persson@axis.com>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "kw@linux.com" <kw@linux.com>,
        "linux-arm-kernel@axis.com" <linux-arm-kernel@axis.com>,
        "kernel@axis.com" <kernel@axis.com>,
        =?UTF-8?B?7KCE66y46riw?= <moonki.jun@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220328014430epcms2p7063834feb0abdf2f38a62723c96c9ff1@epcms2p7>
Date:   Mon, 28 Mar 2022 10:44:30 +0900
X-CMS-MailID: 20220328014430epcms2p7063834feb0abdf2f38a62723c96c9ff1
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPJsWRmVeSWpSXmKPExsWy7bCmhe4/Icckgy9/rSyWNGVYzD9yjtXi
        +aFZzBafWlQtLjztYbN4Oesem0VDz29WiyNvPjJb7D++ksni8q45bBZn5x1ns5iw6huLxZvf
        L9gtzi3OtGjde4TdYuedE8wOAh5r5q1h9Li+LsBjwaZSj02rOtk8nlyZzuSxeUm9R9+WVYwe
        x29sZ/L4vEkugDMq2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnF
        J0DXLTMH6AMlhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToF5gV5xYm5xaV66Xl5q
        iZWhgYGRKVBhQnZGywSDgg7BisVPT7E1MP7i6WLk5JAQMJHo+viWrYuRi0NIYAejRPun5yxd
        jBwcvAKCEn93CIPUCAvYS5zfe50FxBYSUJLYsWYeM0TcWuLTlMtgcTYBS4mLrQ8ZQeaICJxl
        krh5dzsriMMscJtZYv7z9ywQ23glZrQ/hbKlJbYv38oIYWtI/FjWywxhi0rcXP2WHcZ+f2w+
        VI2IROu9s1A1ghIPfu6GiktJLHhyiBXCrpbY//c3E4TdwCjRfz8V5BkJAX2JHdeNQcK8Ar4S
        h1b1sYHYLAKqEj/7GqHKXSR+XpoENoZZQF5i+9s5zCCtzAKaEut36UNMUZY4cosFooJPouPw
        X3aYp3bMewI1RU1i3sqdzBDlMhJbX/pDhD0kJt1sZYKEYKBE15dG5gmMCrMQ4TwLydpZCGsX
        MDKvYhRLLSjOTU8tNiowhsdscn7uJkZwStZy38E44+0HvUOMTByMhxglOJiVRHhlz9onCfGm
        JFZWpRblxxeV5qQWH2I0BXp4IrOUaHI+MCvklcQbmlgamJiZGZobmRqYK4nzeqVsSBQSSE8s
        Sc1OTS1ILYLpY+LglGpgSovotoyZtIb3h5uQi/rs/LVzZi9+o3Qmdt33ei53u2sRgZuqjkaF
        W+Ucjfdk/ML+6cwbacvn/351Mb+YHBZu3Tk95FeDcp2PVEH1n1T/OezvT5uILDL3ei82K1Xg
        kvmpqNMKNzpmzcmLOrXaq8kypuBOnd6JhYubGLzEOCcUC+1pK3i8O+al4PZ3az2PyU6zD83O
        CJmpK9k6TaD6Q9C8risXNc8cSa7+PlPsdLRFvt4FwdrdPorxF0OWiZ0OMqhxXtuZ1iKsuGDH
        fzU3hvcVJ5fwrQgP17li6HbjhvKstKdHufTl3rbUi4RmS03Wr1USUH9+v/OfcJnzx5WT9K4/
        Xvvd+69oaITY4f/3WFKVWIozEg21mIuKEwEKd9x0UgQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220328014430epcms2p7063834feb0abdf2f38a62723c96c9ff1
References: <CGME20220328014430epcms2p7063834feb0abdf2f38a62723c96c9ff1@epcms2p7>
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

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

wangseok.lee (5):
  dt-bindings: pci: Add ARTPEC-8 PCIe controller
  dt-bindings: phy: Add ARTPEC-8 PCIe phy
  PCI: axis: Add ARTPEC-8 PCIe controller driver
  phy: Add ARTPEC-8 PCIe PHY driver
  MAINTAINERS: Add maintainer for Axis ARTPEC-8 PCIe PHY driver

 .../bindings/pci/axis,artpec8-pcie-ep.yaml         | 110 +++
 .../devicetree/bindings/pci/axis,artpec8-pcie.yaml | 117 +++
 .../bindings/phy/axis,artpec8-pcie-phy.yaml        |  67 ++
 MAINTAINERS                                        |   2 +
 drivers/pci/controller/dwc/Kconfig                 |  31 +
 drivers/pci/controller/dwc/Makefile                |   1 +
 drivers/pci/controller/dwc/pcie-artpec8.c          | 912 +++++++++++++++++++++
 drivers/phy/Kconfig                                |   1 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/artpec/Kconfig                         |   9 +
 drivers/phy/artpec/Makefile                        |   2 +
 drivers/phy/artpec/phy-artpec8-pcie.c              | 879 ++++++++++++++++++++
 12 files changed, 2132 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/axis,artpec8-pcie-ep.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/axis,artpec8-pcie.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/axis,artpec8-pcie-phy.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-artpec8.c
 create mode 100644 drivers/phy/artpec/Kconfig
 create mode 100644 drivers/phy/artpec/Makefile
 create mode 100644 drivers/phy/artpec/phy-artpec8-pcie.c

-- 
2.9.5
