Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1F1529A5A3
	for <lists+linux-pci@lfdr.de>; Tue, 27 Oct 2020 08:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507918AbgJ0HlY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Oct 2020 03:41:24 -0400
Received: from mail-vi1eur05on2073.outbound.protection.outlook.com ([40.107.21.73]:52062
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2507915AbgJ0HlY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Oct 2020 03:41:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IdWElrXDmpQFoaco0m0UMCnEmctd1bd4PoEePTk0JSNpk5yromOAxNldMu37CCK2ZIgpti9GpZPrJwdql2wY3gsmIwvD3x+LLhdrDl6pMi2vdpg9i4hxEsYg+gGXONxZyV4H4RdgjeUf7UWJcBXJ3o5d0Wn3K4vFpEDmTPvpBgKpbBLqaEufYHw6+PCK5DgaTlavXhj6fn3OT19NSuj2Ffn2ZcjnqUzrUhwZKsvYOI5yXr3ZLItJk4KN714/laINz0uLroQW4IEkc+svLyYeKp89pDhvzkV8B4xGnic7PR/hgZ86m2nDhaS9xTGYmGR0RfHD0MkuzS5vE4rrU6GlGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNHXEGy2yAClFxnnxK27LPkHhQdirPb8SHOBfrSxyN8=;
 b=fA8cRL/HovhCNeAGajAdM9n6cJ7/OMoKT42812FJjvVVviQm4AaHQGBjsdqO3bNocYd/uWUxbAkPDdCnKHk/Qz91E/7qKrSQrFn5rWGAbpMq57aHAk9totudA+EKEeibENS4MHE0OiAJJn/6FoRMo0GRJD8CrWsy3vnyo6Utgn2JvBw6smADkBK6saBBdM/0FbzNRQZVnO/ipBQZ1dJwv+t5q7SCNK1zSXoSvrlcyEEX/OzMM3S96UuXY625lUgtE5YY5IcJ7H+n2ZpaspAg86iwt9CP20VXu1zm9R47K6ZohP5UJ7IJzikjUxmI4/H0FBSdKwR6rijAEhYrwNmhNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNHXEGy2yAClFxnnxK27LPkHhQdirPb8SHOBfrSxyN8=;
 b=QHWa/QCV0mYQ9zNLIMiUkJwJAgXL+tlEkRsprF6vJUlYFDSbyDE3xqm1ZgN72IWWX69lzbnp0tpJ05AH/onXpCMXTONmTLdJKKLhO7OPmvIDWKYci+PpMM+j/XgVSNLQW5EsduuAjCv+ijqOKIL5uzGoVDUPm2iZOhWH1iwsfgk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27)
 by HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.27; Tue, 27 Oct
 2020 07:40:31 +0000
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::f882:7106:de07:1e1e]) by HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::f882:7106:de07:1e1e%4]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 07:40:31 +0000
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lorenzo.pieralisi@arm.com, robh+dt@kernel.org, bhelgaas@google.com,
        shawnguo@kernel.org, leoyang.li@nxp.com,
        gustavo.pimentel@synopsys.com
Cc:     minghuan.Lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv2 1/7] PCI: dwc: Fix a bug of the case dw_pci->ops is NULL
Date:   Tue, 27 Oct 2020 15:29:55 +0800
Message-Id: <20201027073001.41808-2-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201027073001.41808-1-Zhiqiang.Hou@nxp.com>
References: <20201027073001.41808-1-Zhiqiang.Hou@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.73]
X-ClientProxiedBy: SGAP274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::14)
 To HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.73) by SGAP274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Tue, 27 Oct 2020 07:39:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6eaf557c-4359-4ed3-5895-08d87a4b7340
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3371:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0402MB3371A3D264B5372C09DAB91684160@HE1PR0402MB3371.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SN55S+tQ5kvCT8+DOuLgOZfkACA+j/oS5WsPGJuocsFJVBqfVAQETxQZtkE3eje3vrjuk9IMEZsByol52xBpEFuHxoQpg6kCSVWa9bJrOjPWPNHlnMBKl7A3KzOXfO5smHbvp0xrJl4eT6Czgg1P+STPkC7QqQGucrtbZ36qmBPJk4FT+IVLztACU6nv7Apqt9ZwHKEFoIisppKqjksWLZYhaPPf82xHzm6ovQ4DnPuRpzyHNPaLfw77Io6gbhD64B3Q/4Gz4oDKH/pdlTaCZnHwjO8OwT75kqItfRZmyJhjGEb18EM78f9CsxpVCMFyPFEZIdcapcds63l8sYlOR764x+vPyoWQ3Z4yI5C8h/JRptTHxn8jpu26bWGjs8NLnI7iITf2D0KLndY0cspuIQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3371.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(1076003)(8676002)(5660300002)(86362001)(2906002)(186003)(8936002)(6666004)(4326008)(16526019)(6506007)(26005)(316002)(52116002)(2616005)(36756003)(956004)(69590400008)(6486002)(6512007)(478600001)(83380400001)(66556008)(66476007)(66946007)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: hcm7Ul3kfTUBEhXGfVzaVLi8l6i8ncnbD2Vt7ONS7uUPPQiQ7Snw7h3D9UZdWGPQUyXproUxjxhk94qc+wss0nuM3JzfPcmu16UlPDMoBPwYk4+r1UFdq/z4C8oxtBUTZeKUn1K5FJ28dk/QEvGOXQOWijEdmMRZ3cGG4ue9jrgMaSVsBNvvR1rIdoJzxGo8AeCLbSktCtGQpIpDefSjildnDQ3J6kSvgaDREy86l+9C0UDh++JLpfnylodpMUAm8uUSaF9nkWF3KhsSw6wrueVvVddxNkCZj1l+MgnVOtXVEDiWTd1K1azbq5xnHRKH9ptYma18XFbjPq9HkBDPIurVVhVgQqZwoQXQkf99uCCA89eP+n9NA9v1Nthmyxa52dxi7YCUCuv97FyTPbECuM+R3blreBYwMiUqeRbRXa/ADm8zFmR/Hk8BdrzKirVmFoGb4sHRf+rFpq7dXe6lfCiJ20NR+ipZlgQLk4YFg3t/AJYCKBMLJMKG1RT66zQUqPbhWwjGVPb+YlpOYboOyT8vBzs90/SDvUuLacA4GD6dQiWf1LHdWRyi+KiFHKghd5B0PpuD1z9q8H+QoRbn7pW9uH9thmYHRas0Qie7X/59HbGEwCkItVurbcILaIg9lXo23F4QspkmzOsAqr5Wxw==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eaf557c-4359-4ed3-5895-08d87a4b7340
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3371.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 07:39:35.1615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AcmWZNwpZLAw2uXMSlnPGOh3RIzeEEp0K9BoJExg7cT92+/5qrWZhEwVWO3k3u72px87zm4SzSPQ+IIokCHNtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3371
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

The dw_pci->ops may be a NULL, and fix it by adding one more check.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
V2:
 - Rebased the patch against the latest code.

 drivers/pci/controller/dwc/pcie-designware.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index c2dea8fc97c8..7a5024450c4d 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -141,7 +141,7 @@ u32 dw_pcie_read_dbi(struct dw_pcie *pci, u32 reg, size_t size)
 	int ret;
 	u32 val;
 
-	if (pci->ops->read_dbi)
+	if (pci->ops && pci->ops->read_dbi)
 		return pci->ops->read_dbi(pci, pci->dbi_base, reg, size);
 
 	ret = dw_pcie_read(pci->dbi_base + reg, size, &val);
@@ -156,7 +156,7 @@ void dw_pcie_write_dbi(struct dw_pcie *pci, u32 reg, size_t size, u32 val)
 {
 	int ret;
 
-	if (pci->ops->write_dbi) {
+	if (pci->ops && pci->ops->write_dbi) {
 		pci->ops->write_dbi(pci, pci->dbi_base, reg, size, val);
 		return;
 	}
@@ -171,7 +171,7 @@ void dw_pcie_write_dbi2(struct dw_pcie *pci, u32 reg, size_t size, u32 val)
 {
 	int ret;
 
-	if (pci->ops->write_dbi2) {
+	if (pci->ops && pci->ops->write_dbi2) {
 		pci->ops->write_dbi2(pci, pci->dbi_base2, reg, size, val);
 		return;
 	}
@@ -186,7 +186,7 @@ static u32 dw_pcie_readl_atu(struct dw_pcie *pci, u32 reg)
 	int ret;
 	u32 val;
 
-	if (pci->ops->read_dbi)
+	if (pci->ops && pci->ops->read_dbi)
 		return pci->ops->read_dbi(pci, pci->atu_base, reg, 4);
 
 	ret = dw_pcie_read(pci->atu_base + reg, 4, &val);
@@ -200,7 +200,7 @@ static void dw_pcie_writel_atu(struct dw_pcie *pci, u32 reg, u32 val)
 {
 	int ret;
 
-	if (pci->ops->write_dbi) {
+	if (pci->ops && pci->ops->write_dbi) {
 		pci->ops->write_dbi(pci, pci->atu_base, reg, 4, val);
 		return;
 	}
@@ -271,7 +271,7 @@ static void __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
 {
 	u32 retries, val;
 
-	if (pci->ops->cpu_addr_fixup)
+	if (pci->ops && pci->ops->cpu_addr_fixup)
 		cpu_addr = pci->ops->cpu_addr_fixup(pci, cpu_addr);
 
 	if (pci->iatu_unroll_enabled) {
@@ -479,7 +479,7 @@ int dw_pcie_link_up(struct dw_pcie *pci)
 {
 	u32 val;
 
-	if (pci->ops->link_up)
+	if (pci->ops && pci->ops->link_up)
 		return pci->ops->link_up(pci);
 
 	val = readl(pci->dbi_base + PCIE_PORT_DEBUG1);
-- 
2.17.1

