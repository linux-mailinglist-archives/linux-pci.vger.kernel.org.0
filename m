Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99FF6966C9
	for <lists+linux-pci@lfdr.de>; Tue, 14 Feb 2023 15:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbjBNO0s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 09:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233165AbjBNO0a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 09:26:30 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE082A98B
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 06:26:20 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230214140840epoutp0332e4b234d682b69fce2f63bcae78da80~Dthy1QIkd1771117711epoutp036
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 14:08:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230214140840epoutp0332e4b234d682b69fce2f63bcae78da80~Dthy1QIkd1771117711epoutp036
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1676383720;
        bh=P4o2RODWrzpC0VraKdmaU2+Wsu5NhyyDqSjcT9MD770=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=shPIJ6HfaiRYa62FMQH15a1LJXvKnpxUUElYD28PB2mXMcYRmQizTFdrdR5M3Rfi2
         RuWQB1pJcAtKAY+9I7+zv4NNTwQSlgSDGFM/pRL47pXW/ilaLfnq1AAtzWABsxKgPr
         x6w2tT9d80Ng/h2EBpngnCF4DEJH4a30dx+NvjnQ=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20230214140839epcas5p2a33f397fd00d4b08838b0012423c31f1~DthyBc6L72728027280epcas5p2-;
        Tue, 14 Feb 2023 14:08:39 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4PGNNQ1VV0z4x9Pv; Tue, 14 Feb
        2023 14:08:38 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        88.79.10528.6E59BE36; Tue, 14 Feb 2023 23:08:38 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230214121424epcas5p38e74b52a2d94a32b82a093c7e0a12499~Dr_BbpmeK2572325723epcas5p3B;
        Tue, 14 Feb 2023 12:14:24 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230214121424epsmtrp114f31489629691cd65e62d91d8f2a18d~Dr_Bas2u41843918439epsmtrp1E;
        Tue, 14 Feb 2023 12:14:24 +0000 (GMT)
X-AuditID: b6c32a49-e75fa70000012920-47-63eb95e62dff
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        98.FA.17995.02B7BE36; Tue, 14 Feb 2023 21:14:24 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230214121421epsmtip11cc3c41c0c08218d174e751e42f73cba~Dr9_oUh8v2436024360epsmtip1j;
        Tue, 14 Feb 2023 12:14:21 +0000 (GMT)
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
Subject: [PATCH 05/16] dt-bindings: PCI: Rename the term elbi to appl
Date:   Tue, 14 Feb 2023 17:43:22 +0530
Message-Id: <20230214121333.1837-6-shradha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230214121333.1837-1-shradha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAJsWRmVeSWpSXmKPExsWy7bCmuu6zqa+TDf4cY7d4MG8bm8WSpgyL
        +UfOsVrM2jaX0eLj73MsFiu+zGS36HvxkNmioec3q8Wmx9dYLS7vmsNmcXbecTaLGef3MVm0
        /GlhsWg52s5isfbIXXaLRVu/sFv837OD3eLP9A8sFr2Hay02b5rK7CDi8WbTd3aPnbPusnss
        2FTqsWlVJ5vHnWt72DzenTvH7vHkynQmj81L6j02vtvB5LGo4SObR9+WVYwenzfJBfBEZdtk
        pCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAL2ppFCWmFMK
        FApILC5W0rezKcovLUlVyMgvLrFVSi1IySkwKdArTswtLs1L18tLLbEyNDAwMgUqTMjOuNLf
        yFywnbNiwwK7BsZj7F2MnBwSAiYS285cZu1i5OIQEtjNKHFmxQYmCOcTo0TjtYNsEM5nRomt
        P6cwwbS0/J7BDpHYxShx+dEPZginlUni/6c5bCBVbAJaEo1fu8ASIgK3mCRefn4I1sIscIpR
        4sCLvWDrhQVcJa7fXMEMYrMIqEqsP7EELM4rYCmxYud1qH3yEqs3HACr4RSwkmhp3cQMEb/A
        IbG/KRvCdpG4Pmsh1EvCEq+Ob4GypSRe9rdB2ekSKzfPgOrNkfi2eQnUfHuJA1fmsHQxcgAd
        pymxfpc+RFhWYuqpdWAlzAJ8Er2/n0CV80rsmAdjK0t8+buHBcKWlJh3DBSSILaHRMfHfrAa
        IYFeRonW96ITGOVmIWxYwMi4ilEytaA4Nz212LTAMC+1HB5ryfm5mxjBSVnLcwfj3Qcf9A4x
        MnEwHmKU4GBWEuEVfvoiWYg3JbGyKrUoP76oNCe1+BCjKTD4JjJLiSbnA/NCXkm8oYmlgYmZ
        mZmJpbGZoZI4r7rtyWQhgfTEktTs1NSC1CKYPiYOTqkGJjGTL1u1s1mf2xzfvL1h17uwU4m7
        k/9WnvYUjvqf832Nnd+ka63lsxZu6H5xLu3c/Ef1bt3b4qctl/2UYDvp6bKVF3vMjr01uVSZ
        8EaQa04rxxXfWTbFi1S/eeef85+rqaGds0l10+JJ2zTbfzpX5V3w0Io6u5z/ekYsw+ns+d+D
        uZeHOreq1Lsuf5/k8/mLiFQ3R6XXFKN+hYCJGYycsz+rL86Z9CDlyZLNlqdF97cc4A4t/iTR
        u7Gon+VweFnMP6MT3DwZdw2r3plN8+dMLt2ZMH0eG9ezTtXWaWeq773z2CH7zNO375PvjCvr
        sk+Z7f/2eMZlLavziV0hT/+X8O+5dbjHx9Rd8ePzzJUlykosxRmJhlrMRcWJABqBLptTBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBLMWRmVeSWpSXmKPExsWy7bCSnK5C9etkg9mfhSwezNvGZrGkKcNi
        /pFzrBazts1ltPj4+xyLxYovM9kt+l48ZLZo6PnNarHp8TVWi8u75rBZnJ13nM1ixvl9TBYt
        f1pYLFqOtrNYrD1yl91i0dYv7Bb/9+xgt/gz/QOLRe/hWovNm6YyO4h4vNn0nd1j56y77B4L
        NpV6bFrVyeZx59oeNo93586xezy5Mp3JY/OSeo+N73YweSxq+Mjm0bdlFaPH501yATxRXDYp
        qTmZZalF+nYJXBlX+huZC7ZzVmxYYNfAeIy9i5GTQ0LARKLl9wwgm4tDSGAHo8SS1YfZIBKS
        Ep8vrmOCsIUlVv57DlXUzCRx+dV1FpAEm4CWROPXLmaQhIjAKyaJw3tmgDnMAhcYJW4d7Abb
        ISzgKnH95gpmEJtFQFVi/YklYHFeAUuJFTuvQ62Ql1i94QBYDaeAlURL6yYwWwioZtavVYwT
        GPkWMDKsYpRMLSjOTc8tNiwwykst1ytOzC0uzUvXS87P3cQIjhwtrR2Me1Z90DvEyMTBeIhR
        goNZSYRX+OmLZCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8F7pOxgsJpCeWpGanphakFsFkmTg4
        pRqY6n94zPzw/Ifsr4+a5vcbnM/7cDs1feJy17x0+29d8w2JL8IVezR/NtctuCVUbyrsvW1m
        fqH0DLkWwfji67+X3TtVvuSB96In/LzPZVo6ZYUmXSrquNqlbyRQZLd+9flVnvef29bpfbqf
        b7b1sTvf7+1lHFy1t1ytsxZH9HkJHzluOHGeyL2F+p4aXypbg92WGDCwxf6Q3qI2Yz6Li/qH
        BeJMW9WL3gaaPLa9uOffe8Mpgn+s+JY/VNsQ9+/2Z48bT0PbqiaUMG/LiDewST7d9W5riKR0
        4to7a2f2szufu27EV7PjKnPVlR7JJb1LWx7vz+jjVjn7ed3a7s33WL3jt7rK/s6OzHsbKiyw
        jM9ZiaU4I9FQi7moOBEAJbfJ/QsDAAA=
X-CMS-MailID: 20230214121424epcas5p38e74b52a2d94a32b82a093c7e0a12499
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230214121424epcas5p38e74b52a2d94a32b82a093c7e0a12499
References: <20230214121333.1837-1-shradha.t@samsung.com>
        <CGME20230214121424epcas5p38e74b52a2d94a32b82a093c7e0a12499@epcas5p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DT uses the name elbi in reg-names for application logic
registers which is a wrong nomenclature. This patch fixes
the same.

This commit shouldn't be applied without changes
"arm64: dts: Rename the term elbi to appl" and
"PCI: samsung: Rename the term elbi to appl"

Signed-off-by: Shradha Todi <shradha.t@samsung.com>
---
 Documentation/devicetree/bindings/pci/samsung,pcie.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/samsung,pcie.yaml b/Documentation/devicetree/bindings/pci/samsung,pcie.yaml
index 6cd36d9ccba0..9c58c4d1f6a7 100644
--- a/Documentation/devicetree/bindings/pci/samsung,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/samsung,pcie.yaml
@@ -25,13 +25,13 @@ properties:
   reg:
     items:
       - description: Data Bus Interface (DBI) registers.
-      - description: External Local Bus interface (ELBI) registers.
+      - description: Controller's application logic registers.
       - description: PCIe configuration space region.
 
   reg-names:
     items:
       - const: dbi
-      - const: elbi
+      - const: appl
       - const: config
 
   interrupts:
-- 
2.17.1

