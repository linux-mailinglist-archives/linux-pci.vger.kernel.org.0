Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC898696685
	for <lists+linux-pci@lfdr.de>; Tue, 14 Feb 2023 15:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjBNOV3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 09:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjBNOVZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 09:21:25 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2FD2A9A6
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 06:21:09 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230214140901epoutp022d4376b9a94747f21dca97a2bec21218~DtiGUPRsu0915809158epoutp02W
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 14:09:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230214140901epoutp022d4376b9a94747f21dca97a2bec21218~DtiGUPRsu0915809158epoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1676383741;
        bh=FtyaHDtSUU/5LX0AKMY1M0E99WuJ7+NX0KOgQ1B829c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gDhgh2+11b/mU2GhbdR1pRYt/YIbxHWWVX91SQfE0uq8KcfacKoAvFFzyn9E1GDZd
         JXkibV/l+PFNkycOD/HQCndG4rX9NKXNrDsFblfpuw2E4czv64uwLJSGj9SdChD9y0
         oeo8xVMmGvjEBHeLPmpq4OU/U+aYhLGOi9FOmyoI=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230214140900epcas5p3e52df60e235c903ff8bdb82f43ee7f2e~DtiFWQBo_2972429724epcas5p3g;
        Tue, 14 Feb 2023 14:09:00 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4PGNNp6s2Rz4x9Pp; Tue, 14 Feb
        2023 14:08:58 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        55.68.06765.AF59BE36; Tue, 14 Feb 2023 23:08:58 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230214121428epcas5p3d91e877e62a78008d2b0d6066efea059~Dr_FPX-FA2572325723epcas5p3K;
        Tue, 14 Feb 2023 12:14:28 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230214121428epsmtrp1c101c1be933254e023baebcdba5d17d8~Dr_FOZZP_1843918439epsmtrp1J;
        Tue, 14 Feb 2023 12:14:28 +0000 (GMT)
X-AuditID: b6c32a4b-20fff70000011a6d-a8-63eb95fa01e7
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        17.8E.05839.42B7BE36; Tue, 14 Feb 2023 21:14:28 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230214121425epsmtip1837bf30f8b9641c1a91e0ec137968c60~Dr_CVAQ6I1886618866epsmtip1h;
        Tue, 14 Feb 2023 12:14:25 +0000 (GMT)
From:   Shradha Todi <shradha.t@samsung.com>
To:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
        alim.akhtar@samsung.com, jingoohan1@gmail.com,
        Sergey.Semin@baikalelectronics.ru, lukas.bulwahn@gmail.com,
        hongxing.zhu@nxp.com, tglx@linutronix.de, m.szyprowski@samsung.com,
        jh80.chung@samsung.co, pankaj.dubey@samsung.com
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shradha Todi <shradha.t@samsung.com>
Subject: [PATCH 06/16] arm64: dts: exynos: Rename the term elbi to appl
Date:   Tue, 14 Feb 2023 17:43:23 +0530
Message-Id: <20230214121333.1837-7-shradha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230214121333.1837-1-shradha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAJsWRmVeSWpSXmKPExsWy7bCmpu6vqa+TDfbvMLV4MG8bm8WSpgyL
        +UfOsVrM2jaX0eLj73MsFiu+zGS36HvxkNmioec3q8Wmx9dYLS7vmsNmcXbecTaLGef3MVm0
        /GlhsWg52s5isfbIXXaLRVu/sFv837OD3eLP9A8sFr2Hay02b5rK7CDi8WbTd3aPnbPusnss
        2FTqsWlVJ5vHnWt72DzenTvH7vHkynQmj81L6j02vtvB5LGo4SObR9+WVYwenzfJBfBEZdtk
        pCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAL2ppFCWmFMK
        FApILC5W0rezKcovLUlVyMgvLrFVSi1IySkwKdArTswtLs1L18tLLbEyNDAwMgUqTMjO+Pb3
        D3PBT/aKy2/uszUwHmXrYuTkkBAwkdhweD2QzcUhJLCbUeLSpFfsEM4nRon5n1ZAZb4xStxf
        /pwZpuXQ+U6oqr2MEj86F0A5rUwSq47tZwWpYhPQkmj82sUMkhARuMUk8fLzQ7AqZoFTjBIH
        XuwFcjg4hAXcJY4cVgJpYBFQlbjXuhdsBa+ApcTGlldQF8pLrN5wACzOKWAl0dK6CeqMGxwS
        H07wgIyREHCRmD3VHSIsLPHq+BZ2CFtK4mV/G5SdLrFy8wyo1hyJb5uXMEHY9hIHrsxhARnD
        LKApsX6XPkRYVmLqqXVgJcwCfBK9v59AlfNK7JgHYytLfPm7hwXClpSYd+wyK4TtIfFl3mZG
        SJj0MkpsvXKIdQKj3CyEFQsYGVcxSqYWFOempxabFhjnpZbDYy05P3cTIzgpa3nvYHz04IPe
        IUYmDsZDjBIczEoivMJPXyQL8aYkVlalFuXHF5XmpBYfYjQFBt9EZinR5HxgXsgriTc0sTQw
        MTMzM7E0NjNUEudVtz2ZLCSQnliSmp2aWpBaBNPHxMEp1cDkZOskI+CUNu9BgcOJo8eLPP6q
        uf3VZfzLHNUwIUOq9WYTy7qYFzWeTwu+dxXEHG+KnJWW/2+qfpPi4d9H+Nk9bigprN0qvWhF
        g21d5tkrO/0KvLPiJu98IHQnOHle9mWDLDWeZ6VH+xZ8nsEgu/TOwosX14bz57GVJwTtdnM1
        LNgm/cQhQDjsfJMHwys+v/X+mpO/aT35el7lXvvdu/3Td1rmRnWc1m1bEi8yf/1Vu5XZR39s
        eczra5dTofxFRTjwoPVz07UT8w9Y/T+Z0Lhv0Qn7vr5b2y5xyiaV/9GSl2ScPrtkm3B9tnpC
        S8stmV0PnGZ4y0+6c+R31x3t11oPXx8xe/Mp1urLkXPXdnsosRRnJBpqMRcVJwIAMRPSAFME
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBLMWRmVeSWpSXmKPExsWy7bCSnK5K9etkg7cbpCwezNvGZrGkKcNi
        /pFzrBazts1ltPj4+xyLxYovM9kt+l48ZLZo6PnNarHp8TVWi8u75rBZnJ13nM1ixvl9TBYt
        f1pYLFqOtrNYrD1yl91i0dYv7Bb/9+xgt/gz/QOLRe/hWovNm6YyO4h4vNn0nd1j56y77B4L
        NpV6bFrVyeZx59oeNo93586xezy5Mp3JY/OSeo+N73YweSxq+Mjm0bdlFaPH501yATxRXDYp
        qTmZZalF+nYJXBnf/v5hLvjJXnH5zX22BsajbF2MnBwSAiYSh853sncxcnEICexmlFg18y4z
        REJS4vPFdUwQtrDEyn/PoYqamSR2ti1jB0mwCWhJNH7tYgZJiAi8YpI4vGcGmMMscIFR4tbB
        bqAqDg5hAXeJI4eVQBpYBFQl7rXuBdvAK2ApsbHlFdQZ8hKrNxwAi3MKWEm0tG4Cs4WAamb9
        WsU4gZFvASPDKkbJ1ILi3PTcYsMCw7zUcr3ixNzi0rx0veT83E2M4MjR0tzBuH3VB71DjEwc
        jIcYJTiYlUR4hZ++SBbiTUmsrEotyo8vKs1JLT7EKM3BoiTOe6HrZLyQQHpiSWp2ampBahFM
        lomDU6qBSdeVaba53n97AYtUm+ls4vabpum/j7qfMnlZy91ZvvMnTFnyaFLaZ2eHRW9VXA/9
        0tNrl1K+9GJW1WItsQ88LyTufY/RDNFT3zlXdGach/F6C77vuz037G3P5qp83nB7mYXGtA+t
        Wq/TeRZGp0/WcmowWvZBgFna1PpB/7/qVVKTn8Q0LzxwbfrVs+6P+m/O47Q16OOz0liY7r30
        2YGjduahJjsYZS7Pj2w4l26/K6DDcs3i2lSx6B2vj+mdnlh2W/Ng/Zfr8z7UOX3LCpd549hq
        /c//UFXY8knnhJqaGapX3TqUW3o4ROyl+MneLTfSWh8d7f6xcMbkXXz7X2/o0Hv1O3BC0aea
        M6xPT7pN+q3EUpyRaKjFXFScCAAXo6RbCwMAAA==
X-CMS-MailID: 20230214121428epcas5p3d91e877e62a78008d2b0d6066efea059
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230214121428epcas5p3d91e877e62a78008d2b0d6066efea059
References: <20230214121333.1837-1-shradha.t@samsung.com>
        <CGME20230214121428epcas5p3d91e877e62a78008d2b0d6066efea059@epcas5p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DT uses the name elbi in reg-names for application logic
registers which is a wrong nomenclature. This patch fixes
the same.

This commit shouldn't be applied without changes
"dt-bindings: PCI: Rename the term elbi to appl" and
"PCI: samsung: Rename the term elbi to appl"

Signed-off-by: Shradha Todi <shradha.t@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index 5519a80576c5..96b216099594 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -1944,7 +1944,7 @@
 			compatible = "samsung,exynos5433-pcie";
 			reg = <0x15700000 0x1000>, <0x156b0000 0x1000>,
 			      <0x0c000000 0x1000>;
-			reg-names = "dbi", "elbi", "config";
+			reg-names = "dbi", "appl", "config";
 			#address-cells = <3>;
 			#size-cells = <2>;
 			#interrupt-cells = <1>;
-- 
2.17.1

