Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1760BAEA4E
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2019 14:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392145AbfIJMZY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Sep 2019 08:25:24 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:17356 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392007AbfIJMZY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Sep 2019 08:25:24 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190910122521epoutp02aede90776b50ab0262b9cf3eb06e25f3~DE04tWvUX3168231682epoutp02L
        for <linux-pci@vger.kernel.org>; Tue, 10 Sep 2019 12:25:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190910122521epoutp02aede90776b50ab0262b9cf3eb06e25f3~DE04tWvUX3168231682epoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1568118321;
        bh=ENoo0m1X18Vj3JVZ1WPFeFwISs1ZdRMWK1NqeYShs1Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hdbv8mQZewKHtrfUSvdwPTVbEoWDAH3Q5kCYR1Ksrae4+FK8MzLzt9SjoY7zEL2gw
         qXC6Kt1fKJeEEjr3trm+Pne9haJi4Qua6ysPoJIomh8OCl+bW3F9O5+OVo86awg+UB
         bQhut3JE5Z8qbsJ/Mfl5OCGj+zpnnA+YDAnL80i0=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20190910122520epcas5p21ab5a5698efbca737be7aa7d1ef56c58~DE03zYg_r0710407104epcas5p2E;
        Tue, 10 Sep 2019 12:25:20 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2C.F1.04429.036977D5; Tue, 10 Sep 2019 21:25:20 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20190910122520epcas5p1faeb16f7c38ee057ce93783a637e6bf4~DE03f-C7J2157221572epcas5p1-;
        Tue, 10 Sep 2019 12:25:20 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190910122520epsmtrp1ccbdaeaf3162eac4489becab9e07f17c~DE03fVSwY1251612516epsmtrp1O;
        Tue, 10 Sep 2019 12:25:20 +0000 (GMT)
X-AuditID: b6c32a4a-63dff7000000114d-f8-5d7796302ede
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        55.97.03638.036977D5; Tue, 10 Sep 2019 21:25:20 +0900 (KST)
Received: from ubuntu.sa.corp.samsungelectronics.net (unknown
        [107.108.83.125]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190910122518epsmtip286b1af9ec46a93801941d17c73064c35~DE016fcL60912709127epsmtip2K;
        Tue, 10 Sep 2019 12:25:18 +0000 (GMT)
From:   Pankaj Dubey <pankaj.dubey@samsung.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        Anvesh Salveru <anvesh.s@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>
Subject: [PATCH 2/2] PCI: dwc: Add support to disable equalization phase 2
 and 3
Date:   Tue, 10 Sep 2019 17:55:02 +0530
Message-Id: <1568118302-10505-2-git-send-email-pankaj.dubey@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568118302-10505-1-git-send-email-pankaj.dubey@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSa0hTYRjm2znbOQ6Xh6n4tkpilKTgLQoOFBUkeLqIFUGQrVp5cNI2x+ac
        BoKlzAtmpikoU7wra2pNE51athrDcjPUsAhLyW4miimtEGftIv17nve5vC8fH4kJl3ERma7M
        ZNVKqVzM4+N9zyMjo+OqdZK4ktl9tMPSyKVbbstoy0wRQXes1RD0pMXAox31dh69uP6NoJse
        rxHHSMZUb0LMQO0MwTSYtUxZrxExvU9XEbNqDj/Du8g/nMrK07NYdeyRq3yZ+345rrIHZTeY
        J4k81CMoQQEkUAegaqUGlSA+KaQGEVQNuzg+8hNB69Ic4SO/EEw79MRWxOlwcn3CMII/lRP+
        fAEH8h/ZMI+LR0XD/HKdF4dQhyBvwehNYJ4l7nuT/whJBlPnYNN42ePBqb2gr57hebCAYuDh
        s3r/tnB45yz29gRQJ2CtoxDz9ABl4sHYdJPflAA9rw1+HAwL9l4/FsH3u1tnZ8Dv5gp/uABB
        pb2O6xOOwsiUAfcchFGR0G2J9YwxahvcWZ/neMZACaBIL/S5I8D1dQzz4Z0wl9/K8WEG2tsm
        /M9lQNDjLuWWo121/1sbEDKi7axKo0hjNQdV+5WsLkYjVWi0yrSY6xkKM/J+g6iT/ajNedqK
        KBKJAwWzep1EyJVmaXIUVgQkJg4RTJdpJUJBqjTnJqvOuKLWylmNFe0gcXGYoIL75pKQSpNm
        sjdYVsWqt1QOGSDKQ1UpzOepa6PNF5Ytr9oH3ibdEi3FS/pGSuM2jjeOjSdtWKtD3SubexJ4
        UKyzMfTQC3lnv41bOJr/5CPKdeHGwJeZEbnuLsb2fr3GQGgJY6wstP3Hl5bBRTi7Ue4OItju
        T6bCB47ZcXz1gyjRlZIt2Z08dB5PP6XsTEzuChPjGpk0PgpTa6R/AQ8YL5oCAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLLMWRmVeSWpSXmKPExsWy7bCSvK7BtPJYg42dYhZndy1ktVjSlGGx
        624Hu8WKLzPZLS7vmsNmcXbecTaLN79fsFss2vqF3YHDY828NYweO2fdZfdYsKnUo2/LKkaP
        Lfs/M3p83iQXwBbFZZOSmpNZllqkb5fAlfFvygSWguP8FQs2XWZvYNzM28XIySEhYCJx7uw5
        1i5GLg4hgd2MEu/W9bFCJGQkJq9eAWULS6z895wdoqiJSWJd9yZGkASbgK7Ek/dzmUFsEQFb
        iYa/HcwgRcwCBxklrizdxwSSEBYIkJi44gELiM0ioCrRNu0uG4jNK+AhseHgPHaIDXISN891
        gg3iFPCU+LKiHcwWAqrZeuMM0wRGvgWMDKsYJVMLinPTc4sNC4zyUsv1ihNzi0vz0vWS83M3
        MYIDUUtrB+OJE/GHGAU4GJV4eB+0lccKsSaWFVfmHmKU4GBWEuG93lcaK8SbklhZlVqUH19U
        mpNafIhRmoNFSZxXPv9YpJBAemJJanZqakFqEUyWiYNTqoHR7YilZFznxXsqL2uXXan9ufLr
        k7Tvbnr/stMYLsW2/mRbxcx+eFNlSMf3ozxxHptNvp3cPu0bk8ScgEzVGasnMFsEvJjMx+Pf
        Ziykmel7uGOP+LFiu4qYxEO+Crd31Sg8/N39seeQQP+9NzL/XMwnrXuqtsUlcn2N5bkrPxzN
        pIU+r3RZWaSjxFKckWioxVxUnAgAvZpz20ACAAA=
X-CMS-MailID: 20190910122520epcas5p1faeb16f7c38ee057ce93783a637e6bf4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20190910122520epcas5p1faeb16f7c38ee057ce93783a637e6bf4
References: <1568118302-10505-1-git-send-email-pankaj.dubey@samsung.com>
        <CGME20190910122520epcas5p1faeb16f7c38ee057ce93783a637e6bf4@epcas5p1.samsung.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Anvesh Salveru <anvesh.s@samsung.com>

In some platforms, PCIe PHY may have issues which will prevent linkup
to happen in GEN3 or high speed. In case equalization fails, link will
fallback to GEN1.

Designware controller gives flexibility to disable GEN3 equalization
completely or only phase 2 and 3.

Platform drivers can disable equalization phase 2 and 3, by setting
dwc_pci_quirk flag DWC_EQUALIZATION_DISABLE.

Signed-off-by: Anvesh Salveru <anvesh.s@samsung.com>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 3 +++
 drivers/pci/controller/dwc/pcie-designware.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index bf82091..97a8268 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -472,5 +472,8 @@ void dw_pcie_setup(struct dw_pcie *pci)
 	if (pci->dwc_pci_quirk & DWC_EQUALIZATION_DISABLE)
 		val |= PORT_LOGIC_GEN3_EQ_DISABLE;
 
+	if (pci->dwc_pci_quirk & DWC_EQ_PHASE_2_3_DISABLE)
+		val |= PORT_LOGIC_GEN3_EQ_PHASE_2_3_DISABLE;
+
 	dw_pcie_writel_dbi(pci, PCIE_PORT_GEN3_RELATED, val);
 }
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index a1453c5..b541508 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -31,6 +31,7 @@
 
 /* Parameters for PCIe Quirks */
 #define DWC_EQUALIZATION_DISABLE	0x1
+#define DWC_EQ_PHASE_2_3_DISABLE	0x2
 
 /* Synopsys-specific PCIe configuration registers */
 #define PCIE_PORT_LINK_CONTROL		0x710
@@ -65,6 +66,7 @@
 
 #define PCIE_PORT_GEN3_RELATED		0x890
 #define PORT_LOGIC_GEN3_EQ_DISABLE	BIT(16)
+#define PORT_LOGIC_GEN3_EQ_PHASE_2_3_DISABLE	BIT(9)
 
 #define PCIE_ATU_VIEWPORT		0x900
 #define PCIE_ATU_REGION_INBOUND		BIT(31)
-- 
2.7.4

