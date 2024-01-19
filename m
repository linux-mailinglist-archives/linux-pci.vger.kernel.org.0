Return-Path: <linux-pci+bounces-2387-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A8D832DE1
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 18:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6959C1C23ACF
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 17:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089DB5A0EB;
	Fri, 19 Jan 2024 17:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Xmb7Koed"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2069.outbound.protection.outlook.com [40.107.22.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F5B5A0E7;
	Fri, 19 Jan 2024 17:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705684378; cv=fail; b=gYUEat03yKw/zEDvMFSkLeuSp3z7i/2dP3zPt7H9NjMzJu4Cf9KNozEJQKkQ/hEf/1hPZpdQccCFcqlu263TuqEvMox7c9WUoy8QxzkAzGvso34SKlstIUwpwFzc3fAhIWqDCJ8CJcqkIyzILcDfFSwZ8CwlARP0xsSmjZQlxNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705684378; c=relaxed/simple;
	bh=WJ5hOwlLxUPz7ccFbQPSmigIZUPyDV2CuXDIcdOUnYo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OhT7yVB/Xefxs/cnZpqaIWVO1b7tZyVphQBvuh9cRZLOwwTVOZnUKFreftSjOyalB1rfdH9WXfjPAhcP3vzcbnD1B0XB5UCjuHUbJ6woo9PnlVsS3KJo1yoKmBvh9YiF4kZL8DQfoov5wlMEpaFrYfzpKyvHd/OoGc4hnEbhZFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Xmb7Koed; arc=fail smtp.client-ip=40.107.22.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jvj3VoymqojQz2LkV3WIUQo98+I1Yst0h1GvsMEq6RPTPcRYvaRI/aHDXpnYxH/w4e0/Z2Iljjl3LyGPORv1xzkr+dxfoEcYnfCkteMGunNEPOMA3fwQjLxEKB4oXI+2jOL+FGqmo1xArN6E63lHAXR3WxgLFOfOP7n5ZWAdhhOFxl1riysNRuwDW9oAM84M8cfpqZpjuPDVuVQ2E6P6c1RdAEs8F+f9Q8CrLAFOTVxyRKZlK61sqvvd0SJ9sRKLGFWwf7ovNxn5GF7ki4QY+uGzb2HtvCgL11ufa0gtG2Tv3uSyqEz9WSzxxWoFNmvwj2ZW6ZFYhU76nDNGsjfExQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UfflFd8vpq3ncG4cTELEUBRFQTZj//N1JoxgD6tVczk=;
 b=OhF/ajJgvqSE04iowbESpSJggRuQTjaNzbKrwSEF8ga/utKSsMgEh3dbrKu0GwQY6pCiTN05JqilYGhsZT/46Yl/1Hi9cjmrYMYzURzTB7Ye7Uuz5tCNEY4cNwBnqQ1KXnuB4mtVn1jt7E18OYBpab0bnRqHM3E7LSaompD34D9BSq/AWebRlr04ZolJnAkBXCXJJjtILScS/uBzmwlHPC1QSGFkEqJGo/LgDn9rY0JLufgyMzVLIOYusaW/20UmdxcWsxogWAwWl8V97o3HqwiQR6+MdfKoTz/82oRy4bff+wJLCyCrMlW0nxA3h0lRf9mpoQmWuvqzsVYClZB88g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UfflFd8vpq3ncG4cTELEUBRFQTZj//N1JoxgD6tVczk=;
 b=Xmb7KoedurPLNDNvAFyKBW1hbWoXY5GVJ67EjsZY1vPvN7+ENKLr6CdW8LPXAoCAKwpfzcK1LbJsO2SVQwqe/XYCYmCg0U76g+6S96xBA7xUAElDkKEbJXSorLOwqw5n1GDPrCmH45TuCkj0dcMr7OZYYehWR1XFA8F4K0I4TA8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB9688.eurprd04.prod.outlook.com (2603:10a6:102:271::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 17:12:49 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9%4]) with mapi id 15.20.7202.020; Fri, 19 Jan 2024
 17:12:49 +0000
From: Frank Li <Frank.Li@nxp.com>
To: manivannan.sadhasivam@linaro.org
Cc: Frank.Li@nxp.com,
	bhelgaas@google.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	festevam@gmail.com,
	helgaas@kernel.org,
	hongxing.zhu@nxp.com,
	imx@lists.linux.dev,
	kernel@pengutronix.de,
	krzysztof.kozlowski+dt@linaro.org,
	krzysztof.kozlowski@linaro.org,
	kw@linux.com,
	l.stach@pengutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-imx@nxp.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lpieralisi@kernel.org,
	robh@kernel.org,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: [PATCH v9 13/16] PCI: imx6: Clean up get addr_space code
Date: Fri, 19 Jan 2024 12:11:19 -0500
Message-Id: <20240119171122.3057511-14-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240119171122.3057511-1-Frank.Li@nxp.com>
References: <20240119171122.3057511-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0023.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::36) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB9688:EE_
X-MS-Office365-Filtering-Correlation-Id: f29ea169-680b-4a2a-3fcd-08dc1911dd06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ofu3pYIKhLbZTp0lIgLQlNJZCXD0I8/OgwoK7UJRfVd6jVmSKINhTfp7QWW/keOEBIBPydOqLyYHdT0aw1Gk7Wd5XnQb4cW44NZO5yU/FrDGzPY7U3xiije3+xM7GGfUiJzcH7e3G9TIcKcOQ+j9UI52487fktUF+MiecOnf5v4OMgc0gdaRfdi5RRwCWn5Iq1AyO/fcD6rh0+kX15yAWiiO2ehzcXWRIpS2UK9ulRVnqzuHM4vUlzTc6lFlssDvP71J8prEVqFNy/aH8pNDQKaqzMCB3Ucbw75zGZmQWl8hfuoVpE7W1Y7twexhKF9MAmy0wKrL7L1AxC2UygT3P7cbB4mO+8R09HT6FvNHw34XxOV3gDXN7r4nP/5xDn4Eklf/wAvMPhiCMUY87eTF7IqVhEIFnl67dDPZW91VoqCtLD8gwgIhnTQOyBmoZF8+V6gQV0R7xmC4oveN86d38hOLSjGjpmYX7Stb493IbNScZ64Llz+tzqlXkEyWPB1xf/cgMGoHUN31gXXVZXczruI1PnSnRvuoWOHhL2fzKglmem7eW0k5tQkd1SxcLPhVcRopOMVACTK3GkG4YpAHtzOvfpEBzybozMNUs6xq7t2gA4+TlSU6DcJdT7xt+A6A
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(396003)(39860400002)(346002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(38100700002)(6666004)(41300700001)(6486002)(478600001)(6506007)(52116002)(26005)(83380400001)(2616005)(6512007)(86362001)(6916009)(316002)(2906002)(7416002)(36756003)(8936002)(4326008)(8676002)(66946007)(38350700005)(66556008)(66476007)(5660300002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eHenKUmT2pgslIH4BlWv2dVS+fsKbeEzAfcyWTOxA1eA2eNxAghKH9HW8PVi?=
 =?us-ascii?Q?FJuNZvTrPvg1+/J119ZQZTJqHoz1/nQ8cfv7W3Oi1suf2+iMWC7GswmoSnAS?=
 =?us-ascii?Q?kZ68U8YpSKkf0iONyw5YPgKL8CYeIFsbIftvbtJsz9pVJxNqfPfcTTDODI5b?=
 =?us-ascii?Q?6nUNU1u62BCP6/mM0C78M3PSMo0/k0jh1+TQ3zwR4hqhog/U/m4kqA183ksJ?=
 =?us-ascii?Q?EXyr42RewMt4oIkD9pLiHIoZSzqVuAZtiCCot7rvfNTNCz6nXcNWEVUpa9Om?=
 =?us-ascii?Q?gmL2RThMj8+EvRFz+omAWsmj4h2vWKfV4Qfe6g/RUNdZ+pmcSqn5vXbohMDM?=
 =?us-ascii?Q?p8WDNKXYtBu5iUv/xGTqTzMOGKmlMi2HNsdxKsMwJzv/GQsvfXOHbgItKIvp?=
 =?us-ascii?Q?aONjE0XNU9zaCMX7YnhOI6lT8z9Gc+SVj/yBTnXA5kYJWIoSmJ1kr9quTB9L?=
 =?us-ascii?Q?6dozXVye/V8ud4ZgIKKQM5DoF35/mi2e5Pt5ZAK6KtLgOH/GJWXGYA99u+pn?=
 =?us-ascii?Q?gwjVKsnQHaNQ3qqNK/sRAj/1hSo7esyE6z9Li78QP98eOOq0bt4peeGBdNCS?=
 =?us-ascii?Q?3dXdpXd0rZVxbALYJTIFAA8/xeQ8FjGX7MkNKh9qJSHetk6NVSuAEkb1Oylh?=
 =?us-ascii?Q?DbvS1YOjsOAwE2yPoatMR8PIpqnsOd60BqAvTlM7pXxKBl/MILWcV3HdYOdG?=
 =?us-ascii?Q?luFofR17DROqSRFI0m3fKtEyM3frYauh+RAMuYMrTaIA1grqgBkVu/ccvgzy?=
 =?us-ascii?Q?OXz+Tj2PunJd9bWa8xf9KTL7cSn9PniV9kDnkVc6tvF1u6CxS5a+YVsy7AkW?=
 =?us-ascii?Q?sbB/gkOwpgKfDeZjMSQ0mVs4dTXrBvxTVgIKZlQcRyXZ68DdqHOx7ltnyXPb?=
 =?us-ascii?Q?UU2pslRoKMLqmbWhWTvscRiSSOvVa5GhvXl1SeNfF9NQkZXMY9tkl3VzSRW0?=
 =?us-ascii?Q?1/Z5Uz5miVZh4AYIJ7tvNOC2BoftdCp7kNTSdZUNOJsG3tDyFu7xFLtxh1z/?=
 =?us-ascii?Q?AGur4bJbMueBeLKUe/eDUoiKlS1YEtmtHn09Fx3slvdeHR3Pg5OxPDRnn+kH?=
 =?us-ascii?Q?RP5+ijOc5pji6Qht1KTV/SiLTEIO/jNCcZO4RM3KTZaKOz3j0ajuOd6SEtEN?=
 =?us-ascii?Q?9ERUDGIw+zJXuv2hQkugs4lt9jIUx+5QRvQ85rQAjrw4ulGiM59fRxE2wVmk?=
 =?us-ascii?Q?G9X9eyqVLlcftsZSVZSUNMN9q4kS8DWIxkWOAEQ4tuMHUpOLH1VGcjoZluK3?=
 =?us-ascii?Q?MKaMRyLz6Tsd2nMgpewzLY6Rce24BnDuSVA86QnIgY06jTrToe/QR+VUziGG?=
 =?us-ascii?Q?sBdJbDWs/AKWwAN6Xq7Ym7jlXSGeQnIiMQyiL9xah9sZ16uV8YU3T9TKcsH+?=
 =?us-ascii?Q?er+/Wj0BtRmjoBUztBijrsQvXj1DgZm84IJu7y+8sfAOFV740H520U4otOMD?=
 =?us-ascii?Q?o1S6jo0ZKx28iA0qxfko8rR9FLIAdb49la/i+2Y7SEF3pOn2csY38pOCMQ3j?=
 =?us-ascii?Q?Zyus/Yg+/vamqkpfUU+TfvVp3gm2ZYPnnq5nqL62sZfNpJh3cbJSdVmicWgY?=
 =?us-ascii?Q?go2KpoDJ0jTjLquenCo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f29ea169-680b-4a2a-3fcd-08dc1911dd06
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 17:12:49.4238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YHj+Sv53KtWDIgEzoKSN7ylHVlMDLSKnCyuumjelN9m02UhaMmPjrDeL1o+tEzywz6flSpb5ukKL2qxJcSJ2zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9688

Since the dw_pcie_ep_init() function is already fetching the 'addr_space'
region, no need to do the same in this driver.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v7 to v8
    - update commit message
    - Add Manivannan Sadhasivam's review tag
    Change from v4 to v7
    - none
    Change from v1 to v3
    - new patches

 drivers/pci/controller/dwc/pci-imx6.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 1cfa5f14f18f3..139ed618bfccc 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1067,7 +1067,6 @@ static int imx6_add_pcie_ep(struct imx6_pcie *imx6_pcie,
 	int ret;
 	unsigned int pcie_dbi2_offset;
 	struct dw_pcie_ep *ep;
-	struct resource *res;
 	struct dw_pcie *pci = imx6_pcie->pci;
 	struct dw_pcie_rp *pp = &pci->pp;
 	struct device *dev = pci->dev;
@@ -1086,14 +1085,8 @@ static int imx6_add_pcie_ep(struct imx6_pcie *imx6_pcie,
 		pcie_dbi2_offset = SZ_4K;
 		break;
 	}
-	pci->dbi_base2 = pci->dbi_base + pcie_dbi2_offset;
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "addr_space");
-	if (!res)
-		return -EINVAL;
 
-	ep->phys_base = res->start;
-	ep->addr_size = resource_size(res);
-	ep->page_size = SZ_64K;
+	pci->dbi_base2 = pci->dbi_base + pcie_dbi2_offset;
 
 	ret = dw_pcie_ep_init(ep);
 	if (ret) {
-- 
2.34.1


