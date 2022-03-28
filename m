Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F2C4E8C0A
	for <lists+linux-pci@lfdr.de>; Mon, 28 Mar 2022 04:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237531AbiC1CZW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Mar 2022 22:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbiC1CZW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 27 Mar 2022 22:25:22 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B681CDFCE
        for <linux-pci@vger.kernel.org>; Sun, 27 Mar 2022 19:23:41 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220328022339epoutp01f925e322d0ef62295e49bef57a85e89f~gajBz2Wb20397203972epoutp010
        for <linux-pci@vger.kernel.org>; Mon, 28 Mar 2022 02:23:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220328022339epoutp01f925e322d0ef62295e49bef57a85e89f~gajBz2Wb20397203972epoutp010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1648434219;
        bh=hOTZTR5dORk5Mj3Tg+UwKsuDonZ1LUxnfvDJ0ZpWcKc=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=MK3+c4ySRbT/CRDqyL2/7JOqm8HQ9RpZUMQ3n4FANsNVMA2+uk95cuLGY/dDiKDFW
         6YGMXVu8KoSOZIk7x5WpmhZjGRR5T0+16mYizGjM1sbrZE7fFtM4jmyC7ABpXdIKit
         F3LKdqY2wm0r/4kz6xMYGWByhpQJX6IFAGIZmpHE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220328022339epcas2p1a224eda122aee0ab6a308ccd2200741f~gajBcvUBd1014510145epcas2p15;
        Mon, 28 Mar 2022 02:23:39 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.68]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4KRc205Knjz4x9QK; Mon, 28 Mar
        2022 02:23:36 +0000 (GMT)
X-AuditID: b6c32a47-81bff700000063c4-eb-62411c285293
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        7C.7E.25540.82C11426; Mon, 28 Mar 2022 11:23:36 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH 5/5] MAINTAINERS: Add maintainer for Axis ARTPEC-8 PCIe PHY
 driver
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
Message-ID: <20220328022336epcms2p558e5c1c4db4649272da25d6842450561@epcms2p5>
Date:   Mon, 28 Mar 2022 11:23:36 +0900
X-CMS-MailID: 20220328022336epcms2p558e5c1c4db4649272da25d6842450561
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMJsWRmVeSWpSXmKPExsWy7bCmqa6GjGOSwbpTGhZLmjIsXh7StJh/
        5ByrxfNDs5gtPrWoWlx42sNm8XLWPTaLhp7frBZH3nxktth/fCWTxeVdc9gszs47zmYxYdU3
        Fos3v1+wW5xbnGnRuvcIu8XOOyeYHQQ91sxbw+hxfV2Ax4JNpR6bVnWyeTy5Mp3JY/OSeo++
        LasYPY7f2M7k8XmTXABnVLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJu
        qq2Si0+ArltmDtAXSgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwC8wK94sTc4tK8
        dL281BIrQwMDI1OgwoTsjAmbVzIWzOSomPd+KXsD4z+2LkZODgkBE4nOf2uBbC4OIYEdjBJ7
        pt9h7mLk4OAVEJT4u0MYpEZYIESi6+tSVhBbSEBJYseaecwQcWuJT1Mus4DYbAKWEhdbHzKC
        zBEROMskcfPudlYQh1ngNrPE/OfvWSC28UrMaH8KZUtLbF++lRHC1pD4sayXGcIWlbi5+i07
        jP3+2HyoGhGJ1ntnoWoEJR783A0Vl5JY8OQQK4RdLbH/728mCLuBUaL/firIMxIC+hI7rhuD
        hHkFfCWevVgMNp5FQFXi9MwjTBAlLhK/dqaBhJkF5CW2v50DDgZmAU2J9bv0ISqUJY7cgvuj
        YeNvdnQ2swCfRMfhv3DxHfOeQN2iJjFv5U5miDEyEltf+k9gVJqFCOZZSNbOQli7gJF5FaNY
        akFxbnpqsVGBMTxmk/NzNzGCU7OW+w7GGW8/6B1iZOJgPMQowcGsJMIre9Y+SYg3JbGyKrUo
        P76oNCe1+BCjKdC/E5mlRJPzgdkhryTe0MTSwMTMzNDcyNTAXEmc1ytlQ6KQQHpiSWp2ampB
        ahFMHxMHp1QDk7P7rd2mllZCtkdlnqVKHvu1LoFd5fEXz5yO8CMym7JMblnVP9pdej/W9MIt
        /zjGuumh13p3ael+v6Am1fRgi23e/daw7m9LtDQCNt70ddUv79o6/WyUzGv+KxtPMEy9G6wQ
        5cEsrvl4Xu1xj7pJPzN8nVO1P1jfdn9QYfwkOyNwFsvujPptF/5EPVDguKjZqbr17HnbSxfX
        XQlVXrxHLnchU7LIjxAblbC6uQ3L+h/xnPzwh0XiRsmszsqtVdxXgv+qHZsVWWPaH3tqT5d/
        8J6gOXHJ8e6Loy6+b7d+M9sxLMz5xoWs17nLtiZzn+lfrc6Wftj7YW/cL79DwhlG2xSnCpVo
        vuu4+lI7xumtEktxRqKhFnNRcSIAAsMKHVYEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220328022336epcms2p558e5c1c4db4649272da25d6842450561
References: <CGME20220328022336epcms2p558e5c1c4db4649272da25d6842450561@epcms2p5>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
Lars Persson <lars.persson@axis.com> as Maintainer for these files.

ARTPEC-8 is the SoC platform of Axis Communications
and PCIe phy is designed based on Samsung PHY.

Signed-off-by: Wangseok Lee <wangseok.lee@samsung.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4cc47b2..6bbe336 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1862,12 +1862,14 @@ M:	Jesper Nilsson <jesper.nilsson@axis.com>
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
