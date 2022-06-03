Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C91553C24C
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jun 2022 04:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239066AbiFCByk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Jun 2022 21:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238094AbiFCByj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jun 2022 21:54:39 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238102B25D
        for <linux-pci@vger.kernel.org>; Thu,  2 Jun 2022 18:54:37 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220603015435epoutp03b5642df4f1d0ee19687d7a23968647d7~0_Xw-CGLo0998909989epoutp03X
        for <linux-pci@vger.kernel.org>; Fri,  3 Jun 2022 01:54:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220603015435epoutp03b5642df4f1d0ee19687d7a23968647d7~0_Xw-CGLo0998909989epoutp03X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1654221275;
        bh=iltdJsmgnbu0JcWYL1RKkqqbZCa+Qc8BFE7Yie5EMQA=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=dL5Za0uDl67LA6TIx2HJ2iyHzjFxGqeSN0ZO1XtqJwJQAEefbRzewssDnOpUTa505
         IXFzjJxvJimPbu6pYv+9BTSFvZklmItP5Qo11aTbctsm52w1kr8uxE+h26n3O5nBF6
         qrPyiGiL3YigY1p/E0e9Wj72h4xP5pbg+gko1FYE=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220603015434epcas2p33cfb84fa687df58be91884a5d4ccd113~0_Xv-e9b23019030190epcas2p3Y;
        Fri,  3 Jun 2022 01:54:34 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.70]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4LDmCX3pgdz4x9QG; Fri,  3 Jun
        2022 01:54:32 +0000 (GMT)
X-AuditID: b6c32a47-573ff7000000272c-bc-629969d82301
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        6E.F4.10028.8D969926; Fri,  3 Jun 2022 10:54:32 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v2 0/5] Add support for Axis, ARTPEC-8 PCIe driver
Reply-To: wangseok.lee@samsung.com
Sender: Wangseok Lee <wangseok.lee@samsung.com>
From:   Wangseok Lee <wangseok.lee@samsung.com>
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
        Moon-Ki Jun <moonki.jun@samsung.com>,
        Sang Min Kim <hypmean.kim@samsung.com>,
        Dongjin Yang <dj76.yang@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220603015431epcms2p6203908cebe6a320854136559a32b54cb@epcms2p6>
Date:   Fri, 03 Jun 2022 10:54:31 +0900
X-CMS-MailID: 20220603015431epcms2p6203908cebe6a320854136559a32b54cb
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDJsWRmVeSWpSXmKPExsWy7bCmme6NzJlJBnsXiVssacqweHlI02L+
        kXOsFrtnLGeymDn1DLPF80OzmC0+tahaXHjaw2bxctY9NouGnt+sFkfefGS22H98JZPF5V1z
        2CzOzjvOZjFh1TcWize/X7BbnFucadG69wi7xc47J5gdhD3WzFvD6HF9XYDHgk2lHptWdbJ5
        PLkynclj85J6j74tqxg9jt/YzuTxeZNcAGdUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmB
        oa6hpYW5kkJeYm6qrZKLT4CuW2YO0D9KCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKU
        nALzAr3ixNzi0rx0vbzUEitDAwMjU6DChOyM4w0nmQumi1b0X5/K3MB4WKCLkZNDQsBEomnl
        F0YQW0hgB6PElOfeXYwcHLwCghJ/dwiDhIUFnCQ+LWxnhyhRktixZh4zRFxf4vqKblYQm01A
        V+Lf4pdsXYxcHCICZ5kkbt7dzgriMAvMYZG43vyBFWIZr8SM9qcsELa0xPblWxkhbA2JH8t6
        mSFsUYmbq9+yw9jvj82HqhGRaL13FqpGUOLBz91QcSmJBU8OQc2vltj/9zcThN3AKNF/PxXk
        GQmgS3dcNwYJ8wr4SiyYvhZsPIuAqsSWHW2sECUuEnd2aIOEmQXkJba/ncMMEmYW0JRYv0sf
        okJZ4sgtFpg/Gjb+ZkdnMwvwSXQc/gsX3zHvCdQtahLzVu5khhgjI7H1pf8ERqVZiGCehWTt
        LIS1CxiZVzGKpRYU56anFhsVGMMjNjk/dxMjOFlrue9gnPH2g94hRiYOxkOMEhzMSiK8Jbum
        JgnxpiRWVqUW5ccXleakFh9iNAX6dyKzlGhyPjBf5JXEG5pYGpiYmRmaG5kamCuJ83qlbEgU
        EkhPLEnNTk0tSC2C6WPi4JRqYJJ6LyOnLTJt6euWROkXT37aiqwt0FWyXqVr3XKG9e29oyZP
        z0eUqagsmXtjmuLpYu9dy1YEtzadd1ne4pObGH1l7rOfwTGzz2Vt3RpwZOZdFbOlpZs12YvM
        m57xL22Le7Q0nWFt3KPcAAG7S5vn6X3N+ymx4fHjaSzHllyOWlC3yN1k0T8TT40XGXprpryM
        +l9W8lsm/omtuX/VC8nPvAduT0t9H/dZTdZq5bnlUxNzvf1Op4QEskgzKpw7F+xhU8I21fLu
        e58HP7c6xaVolBsqzbqySdiw7Udgc4qai0sN45enIoGBZ/9sltCM1hN8adPZ+4Db7nCzZFLB
        +ZV/GH/nsu/+fWdOp0Pg+7D2g0osxRmJhlrMRcWJANKw5a5fBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220603015431epcms2p6203908cebe6a320854136559a32b54cb
References: <CGME20220603015431epcms2p6203908cebe6a320854136559a32b54cb@epcms2p6>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This v2 patchset is improvement several review comments received from patchset v1.

Main changes since v1 [1]:
-'make dt_binding_check' result improvement
-Add the missing property list
-improvement review comment of Krzysztof on driver code
-change folder name of phy driver to axis from artpec

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
  MAINTAINERS: Add maintainer for Axis ARTPEC-8 PCIe PHY driver

 .../bindings/pci/axis,artpec8-pcie-ep.yaml         | 108 +++
 .../devicetree/bindings/pci/axis,artpec8-pcie.yaml | 123 +++
 .../bindings/phy/axis,artpec8-pcie-phy.yaml        |  70 ++
 MAINTAINERS                                        |   2 +
 drivers/pci/controller/dwc/Kconfig                 |  31 +
 drivers/pci/controller/dwc/Makefile                |   1 +
 drivers/pci/controller/dwc/pcie-artpec8.c          | 864 +++++++++++++++++++++
 drivers/phy/Kconfig                                |   1 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/axis/Kconfig                           |   9 +
 drivers/phy/axis/Makefile                          |   2 +
 drivers/phy/axis/phy-artpec8-pcie.c                | 806 +++++++++++++++++++
 12 files changed, 2018 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/axis,artpec8-pcie-ep.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/axis,artpec8-pcie.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/axis,artpec8-pcie-phy.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-artpec8.c
 create mode 100644 drivers/phy/axis/Kconfig
 create mode 100644 drivers/phy/axis/Makefile
 create mode 100644 drivers/phy/axis/phy-artpec8-pcie.c

-- 
2.9.5
