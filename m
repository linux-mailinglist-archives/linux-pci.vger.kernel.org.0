Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3F603885C3
	for <lists+linux-pci@lfdr.de>; Wed, 19 May 2021 05:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353189AbhESDzT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 May 2021 23:55:19 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:39209 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237627AbhESDzT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 May 2021 23:55:19 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210519035358epoutp0413bd3d2c7e6ea40ffd380cd73c1d2f57~AW3h44pwv1474814748epoutp048
        for <linux-pci@vger.kernel.org>; Wed, 19 May 2021 03:53:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210519035358epoutp0413bd3d2c7e6ea40ffd380cd73c1d2f57~AW3h44pwv1474814748epoutp048
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1621396438;
        bh=DkL/RNypVRnpj1rq8HK+kpyWCfg14Y7RS0ntrvJocnw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bo3IgZlYVc6AcAXqROFpiSvHD4MRMDX5YxfA7+uEWs2X6anIxOTHfOQkCgc1qn+Q8
         V0aUa46eTx7TjWiGH0hbmx4zxDpb6UN0v4PQ0kXnZSJFt6LkkwwCSoYw2QkvPQ9dgE
         EfJFgzvigT/zhh16eRsplObizukkaxsQzW5sgtMk=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20210519035357epcas5p2f1fd7ffba16419371c3c36e93f116866~AW3gnioN32980329803epcas5p2L;
        Wed, 19 May 2021 03:53:57 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        16.B1.09606.5DB84A06; Wed, 19 May 2021 12:53:57 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20210518173819epcas5p1ea10c2748b4bb0687184ff04a7a76796~AOd-H27W21003110031epcas5p1T;
        Tue, 18 May 2021 17:38:19 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210518173819epsmtrp1f767aa8278be07f4f5d01e714d671be7~AOd-HAaJS2817428174epsmtrp1I;
        Tue, 18 May 2021 17:38:19 +0000 (GMT)
X-AuditID: b6c32a49-bdbff70000002586-18-60a48bd579a3
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        3D.D8.08637.A8BF3A06; Wed, 19 May 2021 02:38:19 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210518173817epsmtip178c225587a5bdc7b96eebb76feed1c62~AOd9Ug2I32408724087epsmtip1E;
        Tue, 18 May 2021 17:38:17 +0000 (GMT)
From:   Shradha Todi <shradha.t@samsung.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, bhelgaas@google.com,
        pankaj.dubey@samsung.com, p.rajanbabu@samsung.com,
        hari.tv@samsung.com, niyas.ahmed@samsung.com, l.mehra@samsung.com,
        Shradha Todi <shradha.t@samsung.com>
Subject: [PATCH 1/3] PCI: dwc: Add support for vendor specific capability
 search
Date:   Tue, 18 May 2021 23:16:16 +0530
Message-Id: <20210518174618.42089-2-shradha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210518174618.42089-1-shradha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkleLIzCtJLcpLzFFi42LZdlhTQ/dq95IEg2d/RS2WNGVY7LrbwW7x
        cdpKJosVX2ayW9x5foPR4vKuOWwWZ+cdZ7N48/sFu8WTKY9YLY5uDLZYtPULu8X/PTvYLXoP
        1zrweqyZt4bRY+esu+weCzaVemxa1cnm0bdlFaPHlv2fGT0+b5ILYI/isklJzcksSy3St0vg
        yji54gpjwWKBiuM981gbGD/xdjFyckgImEjcnLCMpYuRi0NIYDejxIT+14wQzidGiZ3nL7FB
        ON8YJb7fXMcE07Jgaic7iC0ksJdR4sqSEIiiFiaJmZsfMYMk2AS0JBq/doHZIgLWEg2vVrGC
        FDELzGGS+H9sEQtIQlggSGLRyudgU1kEVCWeL13MCmLzClhJbF5wmRlim7zE6g0HwGxOoEGr
        23YwgwySEPjLLnFt2nKoIheJ7lvnoc4Tlnh1fAs7hC0l8bK/DcrOl5h64SnQYg4gu0JieU8d
        RNhe4sCVOWBhZgFNifW79CHCshJTT0E8zCzAJ9H7+wnUdF6JHfNgbGWJL3/3sEDYkhLzjl1m
        hbA9JD7c+MkOCZQ+Ron1h+exT2CUm4WwYgEj4ypGydSC4tz01GLTAsO81HK94sTc4tK8dL3k
        /NxNjODUouW5g/Hugw96hxiZOBgPMUpwMCuJ8G73XpwgxJuSWFmVWpQfX1Sak1p8iFGag0VJ
        nHfFw8kJQgLpiSWp2ampBalFMFkmDk6pBqZMN/XnDvs2dBe9i++8FH/twuyrFRxxOjuSbS7t
        mdA0UfzJPqY9ugo7a96frv8lKGcyw2TL1HlHLlczbu0xzb59/Hi8qaRnm9sskTsbO1f+v53Q
        fcLgdoGNc0R73s8wybdxadzzLWdPNuquNJTqELOVr5/ycP8dt01NxfMFT9XdN+SPW9PSsLzn
        TYycUsu58IQHhZ+Erlt5iTjHmQamzbgVt2Gmjncc02T3S4dut5+L77hjq5tdJvT32T+9yMwu
        xV/T4xv7CnyUPfonV2Tbc3e7myhaqbw2E7XlXFZ98O2ckvaHgq1TW1NOxG5aV1q5Qmn5mhlS
        8u4Jf/0ttzIt/c3m+4tLYJX95ITb+jd/KbEUZyQaajEXFScCAGTl90ecAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFLMWRmVeSWpSXmKPExsWy7bCSnG7378UJBgebmC2WNGVY7LrbwW7x
        cdpKJosVX2ayW9x5foPR4vKuOWwWZ+cdZ7N48/sFu8WTKY9YLY5uDLZYtPULu8X/PTvYLXoP
        1zrweqyZt4bRY+esu+weCzaVemxa1cnm0bdlFaPHlv2fGT0+b5ILYI/isklJzcksSy3St0vg
        yji54gpjwWKBiuM981gbGD/xdjFyckgImEgsmNrJDmILCexmlJh20x0iLinx+eI6JghbWGLl
        v+dANVxANU1MEl9PdYE1sAloSTR+7WIGsUUEbCUa/nYwgxQxC6xgkmg7M5kFJCEsECDxZWUb
        WAOLgKrE86WLWUFsXgEric0LLjNDbJCXWL3hAJjNKWAtsbptB5DNAbTNSuL/nbIJjHwLGBlW
        MUqmFhTnpucWGxYY5qWW6xUn5haX5qXrJefnbmIEB6+W5g7G7as+6B1iZOJgPMQowcGsJMK7
        3XtxghBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeC10n44UE0hNLUrNTUwtSi2CyTBycUg1MU+6s
        6nAOMjv02UbT+OQS2fNZxbavg/epS/jV/vCf/frpwqLfyS7/+e7q3zfWlJW5qfFrp/zzbwlM
        92suROawTavJ+bvD2tu+d8nLrzMb3ujVu+h4XL14Z6fGM66lj1iWHM/f8Ud7zbxiR31e+ydR
        Tu8stYVT8ruMb3AmREivbJy16cnvGmP+ycvai+VnTV///kEm48UN64ziGsuTD9/sN1Mvyuyy
        D392q/v6/ku9rxf+bztzUmO/WaXD9ymuofyz33wztg1aKinTMXmXkNXfkHfelwu2av71+L+v
        1N21StCj5fA20XkhH/N+F8xgexstUti61kqivOmK5PyfYnMqhWrMp2vdCOFfbjO/fM1yJZbi
        jERDLeai4kQAICr2uM0CAAA=
X-CMS-MailID: 20210518173819epcas5p1ea10c2748b4bb0687184ff04a7a76796
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210518173819epcas5p1ea10c2748b4bb0687184ff04a7a76796
References: <20210518174618.42089-1-shradha.t@samsung.com>
        <CGME20210518173819epcas5p1ea10c2748b4bb0687184ff04a7a76796@epcas5p1.samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add vendor specific extended configuration space capability search API
using struct dw_pcie pointer for DW controllers.

Signed-off-by: Shradha Todi <shradha.t@samsung.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 16 ++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h |  4 ++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index a945f0c0e73d..348f6f696976 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -90,6 +90,22 @@ static u16 dw_pcie_find_next_ext_capability(struct dw_pcie *pci, u16 start,
 	return 0;
 }
 
+u16 dw_pcie_find_vsec_capability(struct dw_pcie *pci, u8 vsec_cap)
+{
+	u16 vsec = 0;
+	u32 header;
+
+	while ((vsec = dw_pcie_find_next_ext_capability(pci, vsec,
+					PCI_EXT_CAP_ID_VNDR))) {
+		header = dw_pcie_readl_dbi(pci, vsec + PCI_VNDR_HEADER);
+		if (PCI_VNDR_HEADER_ID(header) == vsec_cap)
+			return vsec;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dw_pcie_find_vsec_capability);
+
 u16 dw_pcie_find_ext_capability(struct dw_pcie *pci, u8 cap)
 {
 	return dw_pcie_find_next_ext_capability(pci, 0, cap);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 7d6e9b7576be..307525aaa063 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -155,6 +155,9 @@
 #define MAX_IATU_IN			256
 #define MAX_IATU_OUT			256
 
+/* Synopsys Vendor specific data */
+#define DW_PCIE_RAS_CAP_ID		0x2
+
 struct pcie_port;
 struct dw_pcie;
 struct dw_pcie_ep;
@@ -284,6 +287,7 @@ struct dw_pcie {
 
 u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap);
 u16 dw_pcie_find_ext_capability(struct dw_pcie *pci, u8 cap);
+u16 dw_pcie_find_vsec_capability(struct dw_pcie *pci, u8 vsec_cap);
 
 int dw_pcie_read(void __iomem *addr, int size, u32 *val);
 int dw_pcie_write(void __iomem *addr, int size, u32 val);
-- 
2.17.1

