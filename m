Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D8C57B0EE
	for <lists+linux-pci@lfdr.de>; Wed, 20 Jul 2022 08:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239421AbiGTGS3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Jul 2022 02:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239484AbiGTGSZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jul 2022 02:18:25 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C77E63912
        for <linux-pci@vger.kernel.org>; Tue, 19 Jul 2022 23:18:23 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220720061821epoutp02bfcae081b2cd9eccac75ad78b00d275e~DdSfA-dOE0903909039epoutp02x
        for <linux-pci@vger.kernel.org>; Wed, 20 Jul 2022 06:18:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220720061821epoutp02bfcae081b2cd9eccac75ad78b00d275e~DdSfA-dOE0903909039epoutp02x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1658297901;
        bh=3r2pbWvirGByjB+v0MQEPuj3WAwHhq1rsruPh5OW+3I=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=tRScmwnc3RsmnI9WiqsCNaML+bzCREY00i9aJP81URn5xQweklWuryzGnv6HYPIiM
         D8LjouROTQJh2yQX390el9rTIrQgl2pp3WH21LAqpWic6c3/7U3wiutn84iefKtHGx
         2iOkJEZfdHyAUCHkjDnaoTAJ6y6EVCXigXv0lJlA=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220720061820epcas2p25cfc6bf201ff238eda734135791994be~DdSdvZjyH2579125791epcas2p25;
        Wed, 20 Jul 2022 06:18:20 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.68]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4LnlrC3Qm4z4x9Q9; Wed, 20 Jul
        2022 06:18:19 +0000 (GMT)
X-AuditID: b6c32a47-5f7ff700000025aa-ba-62d79e2b3363
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        63.9E.09642.B2E97D26; Wed, 20 Jul 2022 15:18:19 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v4 5/5] MAINTAINERS: Add Axis ARTPEC-8 PCIe PHY maintainers
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
        Yeeun Kim <yeeun119.kim@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20220720055108epcms2p563c65b3de6333ccbc68386aa2471a800@epcms2p5>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220720061818epcms2p55e9dc4d71232cc37bef0fd1ff525ded5@epcms2p5>
Date:   Wed, 20 Jul 2022 15:18:18 +0900
X-CMS-MailID: 20220720061818epcms2p55e9dc4d71232cc37bef0fd1ff525ded5
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAJsWRmVeSWpSXmKPExsWy7bCmma72vOtJBp3nxS2WNGVYvDykaTH/
        yDlWi90zljNZzJx6htni+aFZzBafWlQtLjztYbN4Oesem0VDz29WiyNvPjJb7D++ksni8q45
        bBZn5x1ns5iw6huLxZvfL9gtzi3OtGjde4TdYuedE8wWv7b+YXIQ8Vgzbw2jx/V1AR4LNpV6
        bFrVyebx5Mp0Jo/NS+o9+rasYvQ4fmM7k8fnTXIBnFHZNhmpiSmpRQqpecn5KZl56bZK3sHx
        zvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlATykplCXmlAKFAhKLi5X07WyK8ktLUhUy8otL
        bJVSC1JyCswL9IoTc4tL89L18lJLrAwNDIxMgQoTsjNWzDvBUtDDVfH78S+2BsZ7HF2MHBwS
        AiYSdzaFdjFycggJ7GCU+LbWGyTMKyAo8XeHMEhYWMBb4tPlZnaIEiWJHWvmMUPE9SWur+hm
        BbHZBHQl/i1+yQZiiwh8ZpW4vkewi5GLg1lgAaPE/t/7GEESEgK8EjPan7JA2NIS25dvZQTZ
        xSngJ/G2zQEirCHxY1kvM4QtKnFz9Vt2GPv9sflQY0QkWu+dhaoRlHjwczdUXEpiwZNDrBB2
        tcT+v7+ZIOwGRon++6kQ3+pL7LhuDBLmFfCVuDLzJNgYFgFViRk3lkCNcZG4vf4d2BhmAXmJ
        7W/nMIO0MgtoSqzfpQ8xRVniyC0WmJ8aNv5mR2czC/BJdBz+CxffMe8J1DFqEvNW7mSewKg8
        CxHMs5DsmoWwawEj8ypGsdSC4tz01GKjAmN4vCbn525iBCdtLfcdjDPeftA7xMjEwXiIUYKD
        WUmE92nh9SQh3pTEyqrUovz4otKc1OJDjKZAX05klhJNzgfmjbySeEMTSwMTMzNDcyNTA3Ml
        cV6vlA2JQgLpiSWp2ampBalFMH1MHJxSDUy+fuvKt95YuPDQ98kW27e/kxR4mGUZ3yod9+xw
        PffR6JiQiEXK+9OjWq5bi3ec1xV5N22BekrW2ieO7b3PHm3aU+TMIvWa6fe6vDfl1Uc2qoR5
        H3mivj9YYGpiUVCYxy8jQ4ZjC1JqbaMLp0r39y93753wlT9J5ne5gGrEy82XLu7jXW3714WL
        I99Lea9F+vOD+/baGhmePPi/+OHP4gkre/vs71dl9b0SKrM8uC1xmcjPZEeVoiePsueaXYt+
        ZqNryy5Z83/OzL9sM44tzJn0NGSPj9YWjx7PvGjRnonu65vvqCQyCF9cznXDYdOtIqYv7tY7
        kjy6lF9nFxRNDTWNspl55d6VzG6p2zptIUosxRmJhlrMRcWJADNwa7JjBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220720055108epcms2p563c65b3de6333ccbc68386aa2471a800
References: <20220720055108epcms2p563c65b3de6333ccbc68386aa2471a800@epcms2p5>
        <CGME20220720055108epcms2p563c65b3de6333ccbc68386aa2471a800@epcms2p5>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add maintainer for Axis ARTPEC-8 PCIe PHY. Add Jesper Nilsson
<jesper.nilsson@axis.com> and Lars Persson <lars.persson@axis.com>
as maintainer for these files. ARTPEC-8 is the SoC platform of Axis
Communications and PCIe PHY is designed based on Samsung PHY.

Signed-off-by: Wangseok Lee <wangseok.lee@samsung.com>
---
v3->v4 :
-Add axis,artpec8-pcie.yaml and axis,artpec8-pcie-ep.yaml
-Change file path to axis from artpec
---
 MAINTAINERS | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 264e7a7..e4a0635 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1897,12 +1897,16 @@ M:	Jesper Nilsson <jesper.nilsson@axis.com>
 M:	Lars Persson <lars.persson@axis.com>
 L:	linux-arm-kernel@axis.com
 S:	Maintained
+F:	Documentation/devicetree/bindings/pci/axis,artpec8-pcie-ep.yaml
+F:	Documentation/devicetree/bindings/pci/axis,artpec8-pcie.yaml
+F:	Documentation/devicetree/bindings/phy/axis,artpec8-pcie-phy.yaml
 F:	Documentation/devicetree/bindings/pinctrl/axis,artpec6-pinctrl.txt
 F:	arch/arm/boot/dts/artpec6*
 F:	arch/arm/mach-artpec
 F:	drivers/clk/axis
 F:	drivers/crypto/axis
 F:	drivers/mmc/host/usdhi6rol0.c
+F:	drivers/phy/axis/phy-artpec*
 F:	drivers/pinctrl/pinctrl-artpec*
 
 ARM/ASPEED I2C DRIVER
-- 
2.9.5
