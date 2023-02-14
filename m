Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69F26966B4
	for <lists+linux-pci@lfdr.de>; Tue, 14 Feb 2023 15:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233173AbjBNO0R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 09:26:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbjBNO0N (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 09:26:13 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2BB2A16E
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 06:26:04 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230214140645epoutp018e8fad3eca2820880dbde2db1a81419c~DtgH7Gk2D1360813608epoutp01m
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 14:06:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230214140645epoutp018e8fad3eca2820880dbde2db1a81419c~DtgH7Gk2D1360813608epoutp01m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1676383605;
        bh=kPWMNQWjS6SF6VWeK5pULwfmzkzmPni0cKHjY437eXA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D09AFWkCacU04lmAxcYwb7Xc0pLwQ8jHfnOrxwF09q8l38MlQmPxm4kH2c4PRsijs
         dBqAX6K+xHjaAAa9WAf/4VN6dBT9Qd2dr31Rxii3+hk/30dFzwFYOrCDnIMzGIr9VF
         rXfj3L7/zw5bLtXBpvcDad0KblTg9IfHb/x/0rC4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230214140645epcas5p3d268c031ebdfbf2585009aa99dd3b833~DtgHQADcE1511815118epcas5p3p;
        Tue, 14 Feb 2023 14:06:45 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4PGNLB6bB6z4x9Pr; Tue, 14 Feb
        2023 14:06:42 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        96.FF.55678.2759BE36; Tue, 14 Feb 2023 23:06:42 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230214121404epcas5p3bfa6af0151b7f319d418f7c0dbed7c5a~Dr9vJjIzu2572325723epcas5p3W;
        Tue, 14 Feb 2023 12:14:04 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230214121404epsmtrp1d07f41a848e4f7e523d73e21e63c92d8~Dr9vIqte-1733117331epsmtrp1Y;
        Tue, 14 Feb 2023 12:14:04 +0000 (GMT)
X-AuditID: b6c32a4a-6a3ff7000000d97e-00-63eb95729cb0
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        DE.EA.17995.C0B7BE36; Tue, 14 Feb 2023 21:14:04 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230214121402epsmtip191e934de5270483bae4b5119e07abd9d~Dr9sjJ5Fi2380623806epsmtip1t;
        Tue, 14 Feb 2023 12:14:01 +0000 (GMT)
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
Subject: [PATCH 01/16] dt-bindings: PCI: Rename Exynos PCIe binding to
 Samsung PCIe
Date:   Tue, 14 Feb 2023 17:43:18 +0530
Message-Id: <20230214121333.1837-2-shradha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230214121333.1837-1-shradha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTe1BUVRzH59y73L2oW9eFxgNOuF3HFBpg13gcSMAmcC7SNMw4jA0ztl2X
        G0ssu8veXRWrCQoweWvACsPDATSBBPeCQIBFaJEPqOGVmowwomIQLUJkgEPL7lL/fX6/3/d3
        fo9zDolLewlPMklr5AxaVkMTG0RtV713+RpKplXyZ/NyNF7VRqC6z9So+tqACypvqwRobnlA
        hC4slIlRwdQEjtLzll2Q8GDUBQ11VhCov6qPQGd+/hZDmSuZIpT5wwkRunhtTIxqLi+I0Wp3
        hxitmK0ilH/1E9QilOB73ZkZ4W8x8035mJg5K5gYoeEkwdwb7SaY2YEBMTM5bMaYlrpPGcts
        B8bUpM8RTEFrA2DmBa/YTfHJe9Qcm8AZZJxWpUtI0iaG0TEHlG8pA4PkCl9FCAqmZVo2hQuj
        I9+O9d2XpLGNScuOsBqTzRXL8jztH77HoDMZOZlaxxvDaE6foNEH6P14NoU3aRP9tJwxVCGX
        7w60Cd9PVv9hHib030uOLZy7C9LB0MYc4EpCKgDeqc3Ac8AGUkp1AVjZl+k0ngKY+/CR05gH
        sOb8I7CeMlNRJ1pjKdUJ4KrF3yHKwmD2QCOxFiAoH5jxV4492526i8En8xPiNQOnbgDYM3VF
        vKZyo+Lg9HgpvsYiagdsbxq1+yVUCHzaU485ym2DjZd67BpXKhRmZgn2UyF1m4T3l7IIhygS
        rjYtOvtzg7/3tYod7AmfFGY7ORHWt5zBHayBiy11zgIRsGe4wjYPaevOGzZ3+jvcL8OSG012
        CU69APOXJ51yCeyoWuftcOF5t8jBHrDqxyEXBzOwrngWONaSD2Bb8SBWBLzK/y9xFoAG4MHp
        +ZREjg/U79ZyR/+7N5UuRQD2x+yzvwNMjFv9egFGgl4ASZx2l7g9nFJJJQls2nHOoFMaTBqO
        7wWBtgWewj1fUulsv0FrVCoCQuQBQUFBASGvBynoLZKdYddVUiqRNXLJHKfnDOt5GOnqmY65
        uREHH5cUtkFL1rFb3eX8Vkttu+S3dHPai4w7StVc2T646PF55S/7Ngrer04srVjndz4n4u4f
        3nGQsfic3ptNjhQfArEgPpu+rQp+sxHfguXV939ICxE1BUciqZgTpf6p4aqPZFmv9SlbN6Mv
        2neRsf2EVxd7fUYZN1H7Z+93h1JxqWnTUHizPK1lqejel10xs0Pn4dHWqNIH1pGchcdfXbzw
        brQs7tc3yt75qXDOryk0w3vsZvRK2ddRSTKpejrCo3YuV9mqjjBbBI+onA+qD1s7rfvfezYT
        sbU5erTzn3Ncc/adkeDB6rzcV05+7Hcc23ZLFmi51BN/U3p5kjy1WkSLeDWr8MENPPsvGnbc
        clUEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJLMWRmVeSWpSXmKPExsWy7bCSnC5P9etkgxXzdSwezNvGZrGkKcNi
        /pFzrBazts1ltPj4+xyLxYovM9kt+l48ZLZo6PnNarHp8TVWi8u75rBZnJ13nM1ixvl9TBYt
        f1pYLFqOtrNYrD1yl91i0dYv7Bb/9+xgt/gz/QOLRe/hWovNm6YyO4h4vNn0nd1j56y77B4L
        NpV6bFrVyeZx59oeNo93586xezy5Mp3JY/OSeo+N73YweSxq+Mjm0bdlFaPH501yATxRXDYp
        qTmZZalF+nYJXBlvp19hKzjIW/Fl6S3GBsbL3F2MnBwSAiYSb+YsYeli5OIQEtjBKLGh8zgj
        REJS4vPFdUwQtrDEyn/P2SGKmpkkzh84C5ZgE9CSaPzaxQySEBF4xSRxeM8MMIdZ4AKjxK2D
        3ewgVcICwRLvdj1hAbFZBFQltq+7BhbnFbCU+HRgJdQKeYnVGw4wg9icAlYSLa2bwGwhoJpZ
        v1YxTmDkW8DIsIpRMrWgODc9t9iwwCgvtVyvODG3uDQvXS85P3cTIzh2tLR2MO5Z9UHvECMT
        B+MhRgkOZiURXuGnL5KFeFMSK6tSi/Lji0pzUosPMUpzsCiJ817oOhkvJJCeWJKanZpakFoE
        k2Xi4JRqYCqt5p0Xe+zylHNf+mRjxFgcVGfLxEQdOVO/ZY/eU8f5b/6rpps1O702ODmbK5jl
        8TrNHXv/f5hpncdU3h25bN72g/I3TuS99wg6Mafj0a0XRc9uXv5avvDQq/8H1p53runNLT53
        /sH0yesEbPpU09917bp/wmtSbNuTxBlXTC/aeN2667f030Gl01VhJ9xZ6yJiApwE014VzK2y
        a7lzYW9s0dVf6ypNpM4Zuh75d3hTxEelFQ+k2RaavH98dsGje2mhZ4sa1b+UfS4yTTjAafIg
        WYhJ0tJTqlWpr4a/9GPSPD+1XWem2LksCr+wzcj1zda5VTFyVUZvJHtz2qt+HjK6XTzHMOOF
        tOjM6C3LNy1TYinOSDTUYi4qTgQABx/DIAwDAAA=
X-CMS-MailID: 20230214121404epcas5p3bfa6af0151b7f319d418f7c0dbed7c5a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230214121404epcas5p3bfa6af0151b7f319d418f7c0dbed7c5a
References: <20230214121333.1837-1-shradha.t@samsung.com>
        <CGME20230214121404epcas5p3bfa6af0151b7f319d418f7c0dbed7c5a@epcas5p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The current DT bindings is being used for Exynos5433 SoC only.
In order to extend this binding for all SoCs manufactured by
Samsung using DWC PCIe controller, renaming this file to a more
generic name.

Signed-off-by: Shradha Todi <shradha.t@samsung.com>
---
 .../pci/{samsung,exynos-pcie.yaml => samsung,pcie.yaml}     | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
 rename Documentation/devicetree/bindings/pci/{samsung,exynos-pcie.yaml => samsung,pcie.yaml} (93%)

diff --git a/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml b/Documentation/devicetree/bindings/pci/samsung,pcie.yaml
similarity index 93%
rename from Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
rename to Documentation/devicetree/bindings/pci/samsung,pcie.yaml
index f20ed7e709f7..6cd36d9ccba0 100644
--- a/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/samsung,pcie.yaml
@@ -1,17 +1,17 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/pci/samsung,exynos-pcie.yaml#
+$id: http://devicetree.org/schemas/pci/samsung,pcie.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Samsung SoC series PCIe Host Controller
+title: Samsung SoC series PCIe Controller
 
 maintainers:
   - Marek Szyprowski <m.szyprowski@samsung.com>
   - Jaehoon Chung <jh80.chung@samsung.com>
 
 description: |+
-  Exynos5433 SoC PCIe host controller is based on the Synopsys DesignWare
+  Samsung SoC PCIe controller is based on the Synopsys DesignWare
   PCIe IP and thus inherits all the common properties defined in
   snps,dw-pcie.yaml.
 
-- 
2.17.1

