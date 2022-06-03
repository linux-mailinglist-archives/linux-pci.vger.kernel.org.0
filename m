Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D08553C34C
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jun 2022 04:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbiFCCn4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Jun 2022 22:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiFCCnz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jun 2022 22:43:55 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7948631DEC
        for <linux-pci@vger.kernel.org>; Thu,  2 Jun 2022 19:43:52 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220603024351epoutp01b9e93a207e2ea3e0ffc13f7900ccb323~0-Cx0tbRL1856518565epoutp01s
        for <linux-pci@vger.kernel.org>; Fri,  3 Jun 2022 02:43:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220603024351epoutp01b9e93a207e2ea3e0ffc13f7900ccb323~0-Cx0tbRL1856518565epoutp01s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1654224231;
        bh=xGD0aaO2qyPPbOAOGaZYEnVMOmOX5jr0Q2SBdx4lNTM=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=L4a0frKiPsLHTh7P0mDTOERKnnhSNv2n8dC0PYObnoUv2MgqT//EQx2oEesZn4qgc
         A5UbJRqDAWRFxUZlP9BDHPodQAoKZbyb0hSvFitJwsqUPbtWOmBL+jqJ+hQCbVSAek
         kHXtY7p3/soIa6OyiYWZmBl9STNyeqsJYIS5aWbo=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220603024349epcas2p3b3a713e5f9cf5248e4e3d1304c162191~0-Cwxa_8Q1867018670epcas2p3o;
        Fri,  3 Jun 2022 02:43:49 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.102]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4LDnJN2MP7z4x9Q8; Fri,  3 Jun
        2022 02:43:48 +0000 (GMT)
X-AuditID: b6c32a47-573ff7000000272c-4d-62997564780d
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        1F.99.10028.46579926; Fri,  3 Jun 2022 11:43:48 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v2 5/5] MAINTAINERS: Add maintainer for Axis ARTPEC-8 PCIe
 PHY driver
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
In-Reply-To: <20220603015431epcms2p6203908cebe6a320854136559a32b54cb@epcms2p6>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220603024347epcms2p48d01596e10b251bec077581a6c609c48@epcms2p4>
Date:   Fri, 03 Jun 2022 11:43:47 +0900
X-CMS-MailID: 20220603024347epcms2p48d01596e10b251bec077581a6c609c48
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLJsWRmVeSWpSXmKPExsWy7bCmuW5K6cwkgz/3uC2WNGVYvDykaTH/
        yDlWi90zljNZzJx6htni+aFZzBafWlQtLjztYbN4Oesem0VDz29WiyNvPjJb7D++ksni8q45
        bBZn5x1ns5iw6huLxZvfL9gtzi3OtGjde4TdYuedE8wOwh5r5q1h9Li+LsBjwaZSj02rOtk8
        nlyZzuSxeUm9R9+WVYwex29sZ/L4vEkugDMq2yYjNTEltUghNS85PyUzL91WyTs43jne1MzA
        UNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6B8lhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFK
        ToF5gV5xYm5xaV66Xl5qiZWhgYGRKVBhQnbGrfbZjAUzOSrOPTJvYPzH1sXIwSEhYCLRPLOq
        i5GLQ0hgB6PElVk97CBxXgFBib87hLsYOTmEBcIlfjQ+YAexhQSUJHasmccMEdeXuL6imxXE
        ZhPQlfi3+CUbyBwRgbNMEjfvbmcFcZgF5rBIXG/+AFYlIcArMaP9KQuELS2xfflWRhCbU8BP
        4tyXLjaIuIbEj2W9zBC2qMTN1W/ZYez3x+YzQtgiEq33zkLVCEo8+LkbKi4lseDJIahd1RL7
        //5mgrAbGCX676dCPKwvseO6MUiYV8BXYt2MqWDlLAKqEtffLIY6wUXiT9NusFZmAXmJ7W/n
        MIO0MgtoSqzfpQ8xRVniyC0WmKcaNv5mR2czC/BJdBz+CxffMe8J1DFqEvNW7mSewKg8CxHQ
        s5DsmoWwawEj8ypGsdSC4tz01GKjAmN4zCbn525iBKdrLfcdjDPeftA7xMjEwXiIUYKDWUmE
        t2TX1CQh3pTEyqrUovz4otKc1OJDjKZAX05klhJNzgdmjLySeEMTSwMTMzNDcyNTA3MlcV6v
        lA2JQgLpiSWp2ampBalFMH1MHJxSDUw6klMfcCe9/DCHg8uF+Xnmhny3670K9000U88INn0P
        6Q16dFhXVCt+lXOIqzvHrODTq7m5p2p9mySYc7LT+e2bPxIndkh9P3btzC0VXSdfjoOOU+Oz
        lm+QO19wyG1x/HfXzOfT3z6fwGLIHGMW1rI+bcMept5DL6P3RfCLzffT1ma8Jvvyjfg8hSnX
        rq/+lae00TuBZ1t6cPzUxJpsrtWhVhPfNzIqp2QlbNj287zZhfhpO1za7/pk6DR/7dnilxJy
        +ldQUuqPjXf83l5g36t8Wyh0VeQhHqesttsqT98/175kkHfgbkJHabjGkndRh9dprChkLYhT
        aji8M59f5UTgxDMv/Wykl4vYuUZs+aDEUpyRaKjFXFScCABmhRjWYAQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220603015431epcms2p6203908cebe6a320854136559a32b54cb
References: <20220603015431epcms2p6203908cebe6a320854136559a32b54cb@epcms2p6>
        <CGME20220603015431epcms2p6203908cebe6a320854136559a32b54cb@epcms2p4>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add maintainer for Axis ARTPEC-8 PCIe PHY.

Add Jesper Nilsson <jesper.nilsson@axis.com> and
Lars Persson <lars.persson@axis.com> as Maintainer for these files.

ARTPEC-8 is the SoC platform of Axis Communications
and PCIe phy is designed based on Samsung PHY.

Signed-off-by: Wangseok Lee <wangseok.lee@samsung.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d4d4aa2..cd6f75b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1864,12 +1864,14 @@ M:	Jesper Nilsson <jesper.nilsson@axis.com>
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
