Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 579272EBCCC
	for <lists+linux-pci@lfdr.de>; Wed,  6 Jan 2021 11:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbhAFKxF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Jan 2021 05:53:05 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:15195 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbhAFKxE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Jan 2021 05:53:04 -0500
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210106105222epoutp0441697165c7a636c9d67c306cf2497974~Xnx3E9kVy1218812188epoutp04B
        for <linux-pci@vger.kernel.org>; Wed,  6 Jan 2021 10:52:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210106105222epoutp0441697165c7a636c9d67c306cf2497974~Xnx3E9kVy1218812188epoutp04B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1609930342;
        bh=cIQaJtOHcRr1hOe5xiVBlUoUJ8Ww27E+DGEh1wg5s0w=;
        h=From:To:Cc:Subject:Date:References:From;
        b=vO2Qhi556UH+atPlMVmdPlnj7FaIU94HGt7jj9QmJo/nToyUscV70MlDVLp68phFl
         qbV9N0O2TCs5tZKJ/RUbyZsKvrLJQe50amWcyDARemb2dwv3CmtgqjDeGFQ6FYM0fE
         31Eu0f///ywRj8OuEMG+rTpUzZzAcRtY9AqwpK6c=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20210106105221epcas5p48a32f6f1dc6ee99192e215d63f93c0aa~Xnx2hcvx60440204402epcas5p4g;
        Wed,  6 Jan 2021 10:52:21 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        65.BA.50652.56695FF5; Wed,  6 Jan 2021 19:52:21 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20210106105019epcas5p377bdbff5cd9e14e5107ccbf2b87b5754~XnwFRXjgH1840318403epcas5p3f;
        Wed,  6 Jan 2021 10:50:19 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210106105019epsmtrp1e13e77c8d196083fe8a6e040c0b4add7~XnwFQgSvS0573305733epsmtrp1T;
        Wed,  6 Jan 2021 10:50:19 +0000 (GMT)
X-AuditID: b6c32a4a-6b3ff7000000c5dc-f3-5ff596653c29
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        35.27.08745.BE595FF5; Wed,  6 Jan 2021 19:50:19 +0900 (KST)
Received: from ubuntu.sa.corp.samsungelectronics.net (unknown
        [107.108.83.125]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210106105017epsmtip1fc9990cda5e1491abc9900f9c68816ed~XnwDHoFCs3243232432epsmtip1q;
        Wed,  6 Jan 2021 10:50:17 +0000 (GMT)
From:   Shradha Todi <shradha.t@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        robh@kernel.org, lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        pankaj.dubey@samsung.com, sriram.dash@samsung.com,
        niyas.ahmed@samsung.com, p.rajanbabu@samsung.com,
        l.mehra@samsung.com, hari.tv@samsung.com,
        Shradha Todi <shradha.t@samsung.com>
Subject: [PATCH v2] PCI: dwc: Add upper limit address for outbound iATU
Date:   Wed,  6 Jan 2021 16:20:10 +0530
Message-Id: <1609930210-19227-1-git-send-email-shradha.t@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkleLIzCtJLcpLzFFi42LZdlhTXTd12td4g8OXhC2WNGVY7LrbwW7x
        cdpKJosVX2ayW9x5foPR4vKuOWwWZ+cdZ7N48/sFu8WTKY9YLY5uDLZYtPULu8X/PTvYLXoP
        11rcWM/uwOexZt4aRo+ds+6yeyzYVOqxaVUnm0ffllWMHlv2f2b0+LxJLoA9issmJTUnsyy1
        SN8ugStjwr4W9oI3ghVdb16xNjBO5+9i5OSQEDCRmLlwHlsXIxeHkMBuRok5T39BOZ8YJT5N
        /ckM4XxmlJi0exUzTMuKmZdZIBK7GCV2tm2BclqYJD5eucoIUsUmoCXR+LULrENEwFricPsW
        sLnMAluZJM4uXsgGkhAWcJfY9uo0WAOLgKrEn/ZJ7CA2r4CrxNoJs5gg1slJ3DzXCXaHhMBb
        don757dC3eEi8fHNS1YIW1ji1fEt7BC2lMTL/jYoO19i6oWnQOdxANkVEst76iDC9hIHrswB
        CzMLaEqs36UPEZaVmHpqHdhaZgE+id7fT6BO4JXYMQ/GVpb48ncPC4QtKTHv2GWoCzwkFn89
        ABYXEoiVmLL+L+sERtlZCBsWMDKuYpRMLSjOTU8tNi0wykst1ytOzC0uzUvXS87P3cQITiVa
        XjsYHz74oHeIkYmD8RCjBAezkgivxbEv8UK8KYmVValF+fFFpTmpxYcYpTlYlMR5dxg8iBcS
        SE8sSc1OTS1ILYLJMnFwSjUwrdkmuGznJXP/OLnffHVPNO4eP9TW8m1C0+1/a918b8yvUL2r
        E75JXv/tEbbu6MPsepYnm1l2beDu7ebTMcpRzc/Zt2ZPzFvvrwWi9cWZMYv4n8s27WgMNMi/
        bxyju3zJWrazvAU8xxV2hUxs/yYq4z5p0/Emm+r1H7rrLrnssrrBtGlnwGbe596sLWfS689I
        NtraSBl1Lw15zrxD/IvwOu4Y0dmHlaeu/rldd0fDxOCHZ++wh530a/xh2Wc75Wo9e2gpl1Hz
        81VTjutqN6ic9a4QNPX9v3Tx8jMrW+Jsk1YmN/Cs8H7VsuGWhOldma+LPZKOrnz/NaZsm+7y
        d9zNsccbT2aGqCw8uU9ko66lEktxRqKhFnNRcSIAU5ASFJQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBLMWRmVeSWpSXmKPExsWy7bCSnO7rqV/jDU49U7VY0pRhsetuB7vF
        x2krmSxWfJnJbnHn+Q1Gi8u75rBZnJ13nM3ize8X7BZPpjxitTi6Mdhi0dYv7Bb/9+xgt+g9
        XGtxYz27A5/HmnlrGD12zrrL7rFgU6nHplWdbB59W1YxemzZ/5nR4/MmuQD2KC6blNSczLLU
        In27BK6MCfta2AveCFZ0vXnF2sA4nb+LkZNDQsBEYsXMyyxdjFwcQgI7GCXmnrnIBpGQlPh8
        cR0ThC0ssfLfc3aIoiYmiVOtjWAJNgEticavXcwgtoiArcT9R5NZQYqYBQ4zSXzsfwiWEBZw
        l9j26jQjiM0ioCrxp30SO4jNK+AqsXbCLKgNchI3z3UyT2DkWcDIsIpRMrWgODc9t9iwwCgv
        tVyvODG3uDQvXS85P3cTIzgwtbR2MO5Z9UHvECMTB+MhRgkOZiURXotjX+KFeFMSK6tSi/Lj
        i0pzUosPMUpzsCiJ817oOhkvJJCeWJKanZpakFoEk2Xi4JRqYDLul/r7Qyg5eWWqIGd17z61
        Rt8Vn8J/vVcq3rPyF8PXZ6cfTFycwLX/+Q2++S//ak3eJ3WpdtX+7zercp34W7gK42pcdsxl
        /M10ka29sHjV2R38pn+/SGkWqAcnv2cMMtm1NrF+f/IHwXOvdRfPL3t4s8RsUeSxw0oRiRpu
        6d3Busp/NR483N/Nuf3tqsauV9UPwkW+r/dZu1zozELVzDytPoXdVk8Wn4/lE15x0OvGUpkb
        phcmpNwt0fxix+R43+78vtJP+QuqDTuLI058SPe8O9sp9fOr6KMiYU+42p9wJLzri3l4M0FO
        7w7L+3N3f8ZLbMhnkc2y3+9wXzfGpEB/jWLS+788gsdT/SNrniixFGckGmoxFxUnAgD2cGq3
        uwIAAA==
X-CMS-MailID: 20210106105019epcas5p377bdbff5cd9e14e5107ccbf2b87b5754
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210106105019epcas5p377bdbff5cd9e14e5107ccbf2b87b5754
References: <CGME20210106105019epcas5p377bdbff5cd9e14e5107ccbf2b87b5754@epcas5p3.samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The size parameter is unsigned long type which can accept size > 4GB. In
that case, the upper limit address must be programmed. Add support to
program the upper limit address and set INCREASE_REGION_SIZE in case size >
4GB.

Signed-off-by: Shradha Todi <shradha.t@samsung.com>
---
v1: https://lkml.org/lkml/2020/12/20/187
v2:
   Addressed Rob's review comment and added PCI version check condition to
   avoid writing to reserved registers.

 drivers/pci/controller/dwc/pcie-designware.c | 9 +++++++--
 drivers/pci/controller/dwc/pcie-designware.h | 1 +
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 74590c7..1d62ca9 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -290,12 +290,17 @@ static void __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
 			   upper_32_bits(cpu_addr));
 	dw_pcie_writel_dbi(pci, PCIE_ATU_LIMIT,
 			   lower_32_bits(cpu_addr + size - 1));
+	if (pci->version >= 0x460A)
+		dw_pcie_writel_dbi(pci, PCIE_ATU_UPPER_LIMIT,
+				   upper_32_bits(cpu_addr + size - 1));
 	dw_pcie_writel_dbi(pci, PCIE_ATU_LOWER_TARGET,
 			   lower_32_bits(pci_addr));
 	dw_pcie_writel_dbi(pci, PCIE_ATU_UPPER_TARGET,
 			   upper_32_bits(pci_addr));
-	dw_pcie_writel_dbi(pci, PCIE_ATU_CR1, type |
-			   PCIE_ATU_FUNC_NUM(func_no));
+	val = type | PCIE_ATU_FUNC_NUM(func_no);
+	val = ((upper_32_bits(size - 1)) && (pci->version >= 0x460A)) ?
+		val | PCIE_ATU_INCREASE_REGION_SIZE : val;
+	dw_pcie_writel_dbi(pci, PCIE_ATU_CR1, val);
 	dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, PCIE_ATU_ENABLE);
 
 	/*
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 8b905a2..7da79eb 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -102,6 +102,7 @@
 #define PCIE_ATU_DEV(x)			FIELD_PREP(GENMASK(23, 19), x)
 #define PCIE_ATU_FUNC(x)		FIELD_PREP(GENMASK(18, 16), x)
 #define PCIE_ATU_UPPER_TARGET		0x91C
+#define PCIE_ATU_UPPER_LIMIT		0x924
 
 #define PCIE_MISC_CONTROL_1_OFF		0x8BC
 #define PCIE_DBI_RO_WR_EN		BIT(0)
-- 
2.7.4

