Return-Path: <linux-pci+bounces-6187-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7418A333E
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 18:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A0EA281FD6
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 16:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D21148FEB;
	Fri, 12 Apr 2024 16:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ntpXF88l"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2087.outbound.protection.outlook.com [40.107.8.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6169814900A;
	Fri, 12 Apr 2024 16:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712938150; cv=fail; b=lYnnC/ymbXX/x0wRFoO7ucvsU2hIeQQuz4LTP5FJg9OfE95luqjIobSuFhfXeaxiGAXgDzKwwyqcliwbFlfYivEUdUbmItSMX2uYCje7LhFexid+5DdhUOq48dUDRaOxOzS5VlUVXxp0841uPMs3xBbwg2Z6m/94rTdHS74v5kI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712938150; c=relaxed/simple;
	bh=14QaVJp1PZG1/XG0XoWT//cMaejeB36UdS94KQbcBsE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=L4Jo+aElbJIHE+0A9nB5gZ6WoWsv6kr5OJ8g/Ktk53jkr21LaYXBe9YVIVCoKtGaZ0WqMLqKiEIPErDcok3rmE3+oggEK4Jypx+clYHO0GpTD24Z3M4ZOBHkjkQlA4JZHgYSoTKLkULOFrIEPVn7Qs/kdBREtbX2xoau7Ajbr6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ntpXF88l; arc=fail smtp.client-ip=40.107.8.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VRSjJLZKhWP5mM0XNCbEqbj96v5ZY994OR6hG0g3HoyY3fZl/euuAuyl6YHlpEW6r9NM5q66+4WlT706I9iN6ZR6qCDpsgP9V5J7jacM2QBZcR6fGlENVLguHA0poXKoOtA1b+/HMHkd/o2Hx3CE2LqRpGv1Pptd3zKt+90Gi4mS2rVSb3KuQz2UPl14z9vuC9tZz+Gn0dva0e+Bn1z7Ocw5p4r/2UnOaYEgllUvsUAo3ObcmooYSxjlzX0m2SFoTqOSyM8o630r/7VCS412YlmGQNQb/ICiosV50RlDNsRKijCGQXpeKUA2MkDzIrumrTTDInUvUpg9hsCw2KeyWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4D3g1yKn1DkeyVV3av44X1Wyra+mTLKgpM+gTzeXlmM=;
 b=JNOLhXTQScj7GujJLUCsyfoKV9T5XG04S/JQxMzFyn7czfEX4opIJftt5zB3Fk713ZnvPMcNmw+EAWGOtj6ZCjW+uli90llMHePCXIewj9zrOIW4QoTFshZJrHAHkUnMrCojPL2tjCWnP/CED2JigKYNNum6okq1V7iY8hz9jXT67yS+bTEjjqBwciw4WAS6vFDUyisvJYN3wDsVNwJrhtDGFQhQEo64fkq/usFFhF3Upv5NdX1Ez8OOCZr4rP0HR/cMqmONiXx3NG21Ye3Z/Xji3O09fAvepsBn4HQvabkcX1bsINgJegh4lwHzi9gS8OlbeFOIv8zHe2hOwMxhBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4D3g1yKn1DkeyVV3av44X1Wyra+mTLKgpM+gTzeXlmM=;
 b=ntpXF88lOD+kq6aNwFmnIj/w+LjIJUWTrvRyvM150MFXeDLeWZu/FDTytstPA6tkDbmERkhzhGTwB1+Usl+3xOJfKkVPnfQiYxLpNMYPxneZhbnqVcA4POK7jYlaQ4rL1IUopR8ndClXd82O/6aSUWUwVpacVew4IcPosdf70ek=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB9462.eurprd04.prod.outlook.com (2603:10a6:102:2aa::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 16:09:03 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7409.055; Fri, 12 Apr 2024
 16:09:02 +0000
From: Frank Li <Frank.Li@nxp.com>
To: cassel@kernel.org
Cc: Frank.li@nxp.com,
	bhelgaas@google.com,
	gustavo.pimentel@synopsys.com,
	helgaas@kernel.org,
	imx@lists.linux.dev,
	jdmason@kudzu.us,
	jingoohan1@gmail.com,
	kw@linux.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lpieralisi@kernel.org,
	mani@kernel.org,
	robh@kernel.org
Subject: [PATCH v4 1/1] PCI: dwc: Fix index 0 incorrectly being interpreted as a free ATU slot
Date: Fri, 12 Apr 2024 12:08:41 -0400
Message-Id: <20240412160841.925927-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0036.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::11) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB9462:EE_
X-MS-Office365-Filtering-Correlation-Id: 470e145d-9b64-4b30-f9c2-08dc5b0ade87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lMff4ase7yGBkRL8B4k5EY8riQ9pug83NfyWv/WKzgEW+tPaiO34Ji66aFCvtY+XAlkm60KB1nXORddzgQfa59priCzMWmixvoZ0u2MW+NLjw36OgYaLlbEmZl0IJDXaJyDkby5ipKt12WnBR3RK2mvMwbsFD5ws7w/AayvBTJ6j4n7DLq6HZ7DrAKZE6Rrq0Bh1t5dDz5Yx8d5VibLsqtGEO5G1jIHMxCjA8tugONVG6uygKhEEhDsiNGhdBA5UfP2Tjg3n599jypBOuSTFMAvmHfIlww27zOGeyA1Dr1MKyjX90xJAhxJkRUlGerk9DoSn3r6tncIp9tnVAKdnoICjydllh0DdLWqASU3bTX3MZqG0vSC1Y8+zIqiMw7qQVleXqjgtei0eghMakykjTnutIYvDkNRWlDENxVVtzKSsvuKkXsZgPtRluj35YQ9ohWiSGj+jwzA2xh3K2jfg1P0F5xcRqTyrGjdRRjjTeEP7/YNjzTwyJnGGVmRvYcCYGRLGcFhOcSIY0qpEx+ZzG3WsbAm45X0K2LQ/nze0zi+Y+OrBx/ZtzkaZ8N7wzTGJmqIL8lFSmmjWVqsH/FzUI9iGWqVY1IFAkWfe4jxmtjEboKBWPE5pXeeKPfZ+Pe6e/zg8Ov/WCAWyEIsTjVsnYO6uKwLjfZllWnOVa6ZV7Jo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(52116005)(7416005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ptMG9Uq2yShwzBpoL8f17tzE1qfxdC/qPC358hKCU9F9EDOr/f8sfpcTAvL1?=
 =?us-ascii?Q?xYAQ7QVhwqa7pvc9Ay33Lm4uC7dMRS0UKB309Ikb5PXRZ3AXCMbBl7KdtM2L?=
 =?us-ascii?Q?n2aWFFzXwa9AY9xrDpIK2BF55cnSU90LWHlYb71rL3qgwHLSYCae8R818viB?=
 =?us-ascii?Q?5/RzAQICD55j+J+ll/6cntTPz4yMRyskqqUDTiXoRFvAxv1fYBqFoxXsxR2V?=
 =?us-ascii?Q?F6fs6uDP4cN6pyUjwksoaj8SwbTBiCXGnwqHuopQktthEXsS1foksvNqrou7?=
 =?us-ascii?Q?xCTpDw9ugk1SwXMP4Hc2Fnrd7cYTev75V3DRY2eQaABQHk+Tg8CEURmOSev1?=
 =?us-ascii?Q?Md0CXEsY4cNnDV91pZ7RT0lzaqZgDmNJWuvUI6ono5hSeSRnwJq9eHwdgNz6?=
 =?us-ascii?Q?nf24KLDoyXPsyCcBipV3qfeh0vmuGXjJXAJa8iTkKmW5ZwnbTfzNxJWL8JoC?=
 =?us-ascii?Q?G05SXiBDLyq1LR3KAbTMwzEgKytL8f6YJ12zatb/ZhLhA28GSoTtpVuVZgBP?=
 =?us-ascii?Q?uKbQ1sNzOkuL4r1NoxJj2sOnPq7VYLCOZRDZJF9Im5nXf9U26XfL1SeU1rm9?=
 =?us-ascii?Q?kO+bsZMhweCeoCJFYO7WIPIz8ZyB0SV2N0JfycsYITTdaT120cRocEawQO/S?=
 =?us-ascii?Q?R1XkGRH/9ZPXWnXkCsr0ZF+vGysZxTTqUidNiQtcqre+eYDukGK7dxEchbW2?=
 =?us-ascii?Q?O0RECqph225JNlOz/gT2R81LimZatqc7dmRKWYKrVu1UlyjJwtcqqnPWTyc0?=
 =?us-ascii?Q?3OiWCqFRo/h1s5WaSromGWxvN5IegiCqzrjSuNGXk1xbEZimvJqizeCBLqiI?=
 =?us-ascii?Q?j0CyrSaNolxewtKUw2XsuioTRcXqtSHKgA7dziqHkYUX3Jg+j4GLSgTVwKnO?=
 =?us-ascii?Q?hv3xNpazdaDCV2m0n8fXo0Sdjv3oIII66YKgpVZMIX54UOsil3USK2jVaSQl?=
 =?us-ascii?Q?pqFkQ2bIb0w4IAOkF1fOtt1PJFQJPiCHYuCmmYMpW0ICbL5V4kbt18KndYSD?=
 =?us-ascii?Q?24hkutWWI0I+BPd0N1HwC4jn2GELLH4eQGmWkbDkrLCj3aFM6AWqMsRFA0oH?=
 =?us-ascii?Q?fC3iWZlp1Troryf4x4YdhtLrCDHzqKqwJfmdGe97EbjsJkT+5eAfyZwENHs3?=
 =?us-ascii?Q?p8JoWqfuFKgIxDywJYlHNlfLKGpG3cb6LebnZzkoZ83ugegJUdRrB4kXgS+s?=
 =?us-ascii?Q?ugdtqINAjdKYTH+NdkeWmxI7uIN3bidtBvmyTbRPxhyDVkMToy/M+sFPSgQZ?=
 =?us-ascii?Q?xwFg7NOu0WytXVTR0kUsS3LgooI0jVgh1VDsxiw812tEyLaC77kt4Wd6raAs?=
 =?us-ascii?Q?XZo+3dPaOGgN3iE7AWhM4kpkE/o5YLOEU+OH6uVikcvTiOds5kYbCSzYRa+I?=
 =?us-ascii?Q?JzXLfWeCcN00mBrsQKudbKgbeAU6Sjoerb6UsAfOKKmw8cDXKaWM8wlng23u?=
 =?us-ascii?Q?B2miOPXGGHQPgPA5gCIFEywBAVzDRzBT2ZW6DgC1yIl0E420AAYmo3oYXXh7?=
 =?us-ascii?Q?0ogbaBjnMtoZuGY0XCYYlinGoqXRdcvPujhALoUfITyRVBSPNbzGq8oQqNvk?=
 =?us-ascii?Q?KWag2ygmbG5CO0Cs9j0wUIslly9whARf3VM2dBq7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 470e145d-9b64-4b30-f9c2-08dc5b0ade87
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 16:09:02.2243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +oZOkwLLiDVHg08QTcRkU6RH+dtVSHH1bR6hRezXytCG11jXzhKTnvtFJFzmzO+CvlMU0NorlpJpc5ZFwXxeQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9462

When PERST# assert and deassert happens on the PERST# supported platforms,
the both iATU0 and iATU6 will map inbound window to BAR0. DMA will access
to the area that was previously allocated (iATU0) for BAR0, instead of the
new area (iATU6) for BAR0.

Right now, we dodge the bullet because both iATU0 and iATU6 should
currently translate inbound accesses to BAR0 to the same allocated memory
area. However, having two separate inbound mappings for the same BAR is a
disaster waiting to happen.

The mapping between PCI BAR and iATU inbound window are maintained in the
dw_pcie_ep::bar_to_atu[] array. While allocating a new inbound iATU map for
a BAR, dw_pcie_ep_inbound_atu() API will first check for the availability
of the existing mapping in the array and if it is not found (i.e., value in
the array indexed by the BAR is found to be 0), then it will allocate a new
map value using find_first_zero_bit().

The issue here is, the existing logic failed to consider the fact that the
map value '0' is a valid value for BAR0. Because, find_first_zero_bit()
will return '0' as the map value for BAR0 (note that it returns the first
zero bit position).

Due to this, when PERST# assert + deassert happens on the PERST# supported
platforms, the inbound window allocation restarts from BAR0 and the
existing logic to find the BAR mapping will return '6' for BAR0 instead of
'0' due to the fact that it considers '0' as an invalid map value.

So fix this issue by always incrementing the map value before assigning to
bar_to_atu[] array and then decrementing it while fetching. This will make
sure that the map value '0' always represents the invalid mapping."

Reported-by: Niklas Cassel <Niklas.Cassel@wdc.com>
Closes: https://lore.kernel.org/linux-pci/ZXsRp+Lzg3x%2Fnhk3@x1-carbon/
Tested-by: Niklas Cassel <niklas.cassel@wdc.com>
Fixes: 4284c88fff0e ("PCI: designware-ep: Allow pci_epc_set_bar() update inbound map address")
Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v3 to v4
    - commit message add "Right now, we dodge..."
    - Add Reviewed-by: Manivannan Sadhasivam
    
    Change from v2 to v3
    - Add impact in commit message
    - Add mani's detail description
    - Fix Closes link
    
    Change from v1 to v2
    - update subject
    - use free_win + 1 solution
    - still leave MAX_IATU_IN as 256. I am not sure if there are platfrom have
    256 ATU. Suppose it only use max 6 in current EP framework.
    - @Niklas, can you help test it. My platform become unstable today.

 drivers/pci/controller/dwc/pcie-designware-ep.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 5befed2dc02b7..ba932bafdb230 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -139,7 +139,7 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
 	if (!ep->bar_to_atu[bar])
 		free_win = find_first_zero_bit(ep->ib_window_map, pci->num_ib_windows);
 	else
-		free_win = ep->bar_to_atu[bar];
+		free_win = ep->bar_to_atu[bar] - 1;
 
 	if (free_win >= pci->num_ib_windows) {
 		dev_err(pci->dev, "No free inbound window\n");
@@ -153,7 +153,11 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
 		return ret;
 	}
 
-	ep->bar_to_atu[bar] = free_win;
+	/*
+	 * Always increment free_win before assignment, since value 0 is used to identify
+	 * unallocated mapping.
+	 */
+	ep->bar_to_atu[bar] = free_win + 1;
 	set_bit(free_win, ep->ib_window_map);
 
 	return 0;
@@ -190,7 +194,10 @@ static void dw_pcie_ep_clear_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	enum pci_barno bar = epf_bar->barno;
-	u32 atu_index = ep->bar_to_atu[bar];
+	u32 atu_index = ep->bar_to_atu[bar] - 1;
+
+	if (!ep->bar_to_atu[bar])
+		return;
 
 	__dw_pcie_ep_reset_bar(pci, func_no, bar, epf_bar->flags);
 
-- 
2.34.1


