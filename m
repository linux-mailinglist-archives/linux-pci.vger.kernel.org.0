Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486B869669C
	for <lists+linux-pci@lfdr.de>; Tue, 14 Feb 2023 15:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233371AbjBNOW2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 09:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233412AbjBNOWS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 09:22:18 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CD32B099
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 06:21:48 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230214141047epoutp045b48e633ecf667c2adf016682beaa066~DtjoinalV2242422424epoutp04M
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 14:10:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230214141047epoutp045b48e633ecf667c2adf016682beaa066~DtjoinalV2242422424epoutp04M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1676383847;
        bh=4+P3LcEWNHqtJXPXgDkBs88eaM7Lgag34FxKALksevo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WanGN2/9iGN7rYQCA/ZXar5mqWLcSZoOnV2fuGM7eaH/tPqkb0Qz0R7rhXEdHaOts
         54F0RWn2vRwuM2q7l4AaGzFFtARoImPeUhSmc0NWEw1TkmQ49jQy0Wnrc4u+tfCPLG
         wkNl15mmOyQ+XHxqvLR3QOMmAaFBbLddQzbIbVmA=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230214141046epcas5p11b05b957c72f6185b0a00c1437cd4743~Dtjn8mdIH1464814648epcas5p1n;
        Tue, 14 Feb 2023 14:10:46 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4PGNQr4fYqz4x9Pt; Tue, 14 Feb
        2023 14:10:44 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        75.99.10528.4669BE36; Tue, 14 Feb 2023 23:10:44 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20230214121444epcas5p16c5f7665fc9dee78cd427d976114e4f1~Dr_T2O9wW1714317143epcas5p1W;
        Tue, 14 Feb 2023 12:14:44 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230214121444epsmtrp2850fc3957b8b00c69884f37970c2b9ab~Dr_T1CEHh1888418884epsmtrp2o;
        Tue, 14 Feb 2023 12:14:44 +0000 (GMT)
X-AuditID: b6c32a49-c17ff70000012920-22-63eb96642f86
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6D.8E.05839.43B7BE36; Tue, 14 Feb 2023 21:14:44 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230214121441epsmtip16a4cfe37f004dab5520b727e5563a714~Dr_Q3t0xU2493824938epsmtip1T;
        Tue, 14 Feb 2023 12:14:40 +0000 (GMT)
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
Subject: [PATCH 10/16] dt-bindings: PCI: Add phy-names as required property
Date:   Tue, 14 Feb 2023 17:43:27 +0530
Message-Id: <20230214121333.1837-11-shradha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230214121333.1837-1-shradha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VTa0xbZRj26ynnHHCwY4HwrW6F1CkbGdBubT0Qihtu7OwWUSMxxARP2pO2
        o7f0ArploTNlaqUgsgnUjSEXdZCpazcsCKMBxrIpsAVCEMeEUQ1sE0FuysVZ2qL/nvd9n+e9
        fh+OcLpQLq7SmhiDllbz0TB2c9fOHYnyTx/JBGW/88ix6maUrH9PSV7s7gshHc0XADm70scm
        v5qvwsiSyXGEtBSvhJDOiaEQcqD1PEr2Vt9Eycr+6yzSumplk9Yb77PJy92jGFl7bR4jn7S5
        MXK1YoZN2rtOkS7nOWRvFPXYuYRRLY5RjKpxmiln44codW+oDaWm+/owyjtYwaJc9YXUlWk3
        i6q1zKJUydVGQM05eVmbcvLSlAwtZwxxjFamk6u0Cin/yOu5L+eKJQJhojCFfJEfp6U1jJS/
        /2hWYqZK7RuTH5dPq80+VxZtNPKT09MMOrOJiVPqjCYpn9HL1XqRPslIa4xmrSJJy5hShQLB
        brGP+HaessZ7H9MvY++UDVuABVxBbSAUh4QIuhxrmA2E4RziewAr3DYQMP4E0PakPRhZBLBl
        cSFkQzJ890c0EGgH8M7fTayAUcSCxRN2sM5CiQR4esGGrAeiiBEWnJob9+dCiNsAeibXE4fi
        kcQRuFxa5VewiefhhNXrbyucSIXXZqxYoF4sbPrWg6zjUJ/fWuT0Z4XEMA4H3T8jAdJ+2N3Z
        wQ7gSPjw5tWgmAvnptuDsyrgJVdlkK+Gi656VgC/BD2D531a3NfdTvhNa3LAvQ2eu/21n4IQ
        EdC+4g3Sw6G7egM/B+fX2oJlt8DqnoHgjijoWb0c3KQdQMfSGvIx4Dn+L1EDQCPYwuiNGgVj
        FOuFWqbgv8PJdBon8L/mhENuMDo2k9QJWDjoBBBH+FHhkb9OyjjhcvrdE4xBl2swqxljJxD7
        FliGcKNlOt930JpyhaIUgUgikYhS9kiE/JjweOktGYdQ0CYmj2H0jGFDx8JDuRZW1d58h6T4
        H2r7Baw8+hh7lrMtb3SsjieOO9jjkA8MYnN7cjIEq9OqzLdafjgY+oa09CwtKf+tJVpycsmg
        Of7FmWftHQ3zGcIzbdnyke96Y8o+T5B+6dn89HCMyxS/fA+vUDWkaDI3534UW2qeeu263cZb
        O/a47lbyRFiJNzW97KmLpwtOPjA92Lp8wI61p68M5f9StVtclMPpqO+J2vXwj7QdMcJ9KXeT
        txPd/dytsT+JRtUNdQXLr+y7JJLcz1itsUsrG57JfrU8+5PjIy9k3Ug8DEfOcmlGmRHxGRHx
        F9off7Q1/s6mhZrC3qLCzsJaS8YHB7yqR+Mn6k/1JOl5b+6aauKzjUpamIAYjPS/q5E0TlYE
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJLMWRmVeSWpSXmKPExsWy7bCSnK5J9etkgzVNHBYP5m1js1jSlGEx
        /8g5VotZ2+YyWnz8fY7FYsWXmewWfS8eMls09Pxmtdj0+BqrxeVdc9gszs47zmYx4/w+JouW
        Py0sFi1H21ks1h65y26xaOsXdov/e3awW/yZ/oHFovdwrcXmTVOZHUQ83mz6zu6xc9Zddo8F
        m0o9Nq3qZPO4c20Pm8e7c+fYPZ5cmc7ksXlJvcfGdzuYPBY1fGTz6NuyitHj8ya5AJ4oLpuU
        1JzMstQifbsErowFT+6xF/xir5h4o4GxgXEjWxcjJ4eEgInEjYtngGwuDiGB3YwSl+c0skAk
        JCU+X1zHBGELS6z895wdoqiZSaLt+ztmkASbgJZE49cuZpCEiMArJonDe2aAOcwCFxglbh3s
        ZgepEhbwlvjVP5MRxGYRUJV43PIEbDevgJXE1g8t7BAr5CVWbzgANpUTKN7SugnMFhKwlJj1
        axXjBEa+BYwMqxglUwuKc9Nziw0LDPNSy/WKE3OLS/PS9ZLzczcxgmNHS3MH4/ZVH/QOMTJx
        MB5ilOBgVhLhFX76IlmINyWxsiq1KD++qDQntfgQozQHi5I474Wuk/FCAumJJanZqakFqUUw
        WSYOTqkGpmpHsYBHnEs28qwr/dwvLTRzrtsLMYUixoup3vGTrk9gvx0is/Nq4dNe2b8Tq6zM
        XRWXKsoeSTN7e+vykoDz4tY3GreI5m1rXPhmjfaC3vYDVzmueDhyTD8hfvlMr5SP12rW0h0W
        VV/MdeU+5vnmzJvn+U7mwtei7r3d2uGl9ttlOz2q5XZtv+fcpbnw/gPGL3Ov+R/24I6xFXV9
        OP+yvszapf+YUrbc/SRacudewy3FhVM2sFY6Jr32bnF4orx/zgo1f+MlKx/zmsT8vzZd4vHd
        aT889sg67J11vpOPv6bI8PP290+nuz3L5IvjnXDVvu/ho+J75z+lLj6ze3fA9zn8Tt75Au/f
        fZ4Qw1e+REqJpTgj0VCLuag4EQA/2ovQDAMAAA==
X-CMS-MailID: 20230214121444epcas5p16c5f7665fc9dee78cd427d976114e4f1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230214121444epcas5p16c5f7665fc9dee78cd427d976114e4f1
References: <20230214121333.1837-1-shradha.t@samsung.com>
        <CGME20230214121444epcas5p16c5f7665fc9dee78cd427d976114e4f1@epcas5p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

To replace devm_of_phy_get with devm_phy_get to get the
PHY pointer using non DT version, we need to add phy-names
property in DT and make it a required property with const
value.

Signed-off-by: Shradha Todi <shradha.t@samsung.com>
---
 Documentation/devicetree/bindings/pci/samsung,pcie.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/samsung,pcie.yaml b/Documentation/devicetree/bindings/pci/samsung,pcie.yaml
index 9c58c4d1f6a7..11feff9d6526 100644
--- a/Documentation/devicetree/bindings/pci/samsung,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/samsung,pcie.yaml
@@ -50,6 +50,10 @@ properties:
   phys:
     maxItems: 1
 
+  phy-names:
+    items:
+      - const: pcie_phy
+
   vdd10-supply:
     description:
       Phandle to a regulator that provides 1.0V power to the PCIe block.
@@ -81,6 +85,7 @@ required:
   - clocks
   - clock-names
   - phys
+  - phy-names
   - vdd10-supply
   - vdd18-supply
 
-- 
2.17.1

