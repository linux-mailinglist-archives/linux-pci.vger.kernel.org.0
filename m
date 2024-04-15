Return-Path: <linux-pci+bounces-6290-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFAD8A5AAC
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 21:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E1A31F23C9F
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 19:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4785156F2B;
	Mon, 15 Apr 2024 19:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jjGjGV/x"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2070.outbound.protection.outlook.com [40.107.21.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D78156C41;
	Mon, 15 Apr 2024 19:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713209647; cv=fail; b=A66k8r5gj/M0FSp6LzpIGh60v9r6Y9GvVfjFxfLOGLkt6e3sCc7G91R38klSqUgrzWymmVco39+ATBeCklCWQ3VQzBgdgIx7/u0rJDyY9uwlfpAd+GofLuDFxsVa9o1RKW4Fk8Y2HfLu5BfFCEdFI7BD6AHSreHCcxR2SwPXbQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713209647; c=relaxed/simple;
	bh=iaMVhIlaxnDKrjo/B86UwmBA4lUHgRwjSU/hHDluay0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=RQUGpfEDrLgB9Vkbe7oeGQGbssxWzyraqV72jyDeL9Vq1wCG2UVneawz4NwvcHxXFv3nrFzT2Gpu9XM1HtZDz+/XEq8YxHuBclwg7FD0umFos80Risg3cj/mQbCyzbXzcE6JwxbaVqiurusTHVzuMViNjvZUCUBnweCmwpeujGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=jjGjGV/x; arc=fail smtp.client-ip=40.107.21.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rp+LmnqwXpe3Kz10UfEsEGY3M/BP/0LEsUiuFgoSieZylKJ3Jx28taxUGzrAEPs9lyGmOL9PJm3X/KV/qjYDDW+z9il52OA8pBwR0Ip+B4EK9rzb+pekKevWHeoH1sY99W8MFH8dLXBdjtkOnaPaRBsPrmtGTpYHlDpFlCCSmUWeGhRtOvyPNmWLZdsv0ZCO8DxSZHKbUeaacYEWbiiTOnWWj5jrSYwtfBXSI90xabmwhp6vXugRwG/oYahG9EvKwGSMxjuCrgmsuKvW5jAvgOf0fUGJzlmjzivpo3r1nAJxk2cLwVjSeAW2UChxSzPkorqP1j/f9ApVsxcWR1UNiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wqraZNkbMXJ8bdVBUWBtPeGCWP+ilAu0pVj9SSD+e7E=;
 b=KJW7dUmyfkCMH/NJXm1AIg9tNuu7ufeDntpuFh8dTHyVj6sN929SrLSSYKj6dCDOBFCXJ3UQATlApXsWxH1BMu3l1QM4R6wEHbyphMMds8DWM9dU+xeCoZivfkWTvJwYrmJjD6z/uP3OYDOYIoMeuT3NIdNnJ9TyA4IVkE0/cyfxhBouRhORW/SOc0q9lWo6CJJUoKcgkS9SviUiZp1kkRJAjJ+IFUQ9sI5lR4svIVvTTin1nfefD6SKvKdzT/XDWwzekabuYJQ3SWMxLZShFn+M9u9s7J7bLo2mNJDEIlpQdrwB+u4QkSms/DMdJut5wmJ3HM9o9qUd828xMBOBtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wqraZNkbMXJ8bdVBUWBtPeGCWP+ilAu0pVj9SSD+e7E=;
 b=jjGjGV/xVpxUKNrGc3Tw0WQtiqFOk8h/ErwRq7LFCaaCyB7mneDGCHmbw6yjNFJsPB70HIWDd86U9y9l1nCd+NsWcIQRTYDPkaa2+sGtE91zW5llpldefyt4BLAJaio0GlAZgDR+7CC8DAPDkLZwJImG6pfwPVMBec4j37e/oCc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA2PR04MB10279.eurprd04.prod.outlook.com (2603:10a6:102:406::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.43; Mon, 15 Apr
 2024 19:34:04 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 19:34:04 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 15 Apr 2024 15:33:27 -0400
Subject: [PATCH v6 3/5] PCI: dwc: Add outbound MSG TLPs support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240415-pme_msg-v6-3-56dad968ad3a@nxp.com>
References: <20240415-pme_msg-v6-0-56dad968ad3a@nxp.com>
In-Reply-To: <20240415-pme_msg-v6-0-56dad968ad3a@nxp.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Serge Semin <fancer.lancer@gmail.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713209628; l=2940;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Vx141tscxeq3VO/J2v1vu73YFB2QjcNfIuChtPapKMY=;
 b=I8T0zdscJFazCZ8U2IXx9zOstAk0Ehh4oNJIapRsZHp0rULNlNxD75K17v7J1vDuZn4wYikWF
 rzJyAXXLK6aCROrzlBCUyKdybzk3aDzHJMqrsCwF9EYJALFboOajbvW
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0102.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA2PR04MB10279:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c0f9ae1-caf8-4f4d-aeef-08dc5d830272
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eCYi5xD0QsdLlqpAA20H7n/WkgCdd1C3Dwk+WPWerwTIcGZSwIqGzEAP26egJul7jBsb2idk30SBQI1W4zgkPx+lBnPdyhu6PddNhFP9ViObFBToR76lqLz2pXh8Ted7VGivOA048KDjzuvH9+4/TVBPjUX7VY0Y8+hulFV2/4lu7BMekkpKqdiRIHFdfqhpwANi27tg+Lt2EHuUrDRkBbUmbGK+nkPG/CBgqgOTUvSfar603Xj0n1hElBXa1a6VLmcAD9FmjXiptxSOu9LABQtq1qXwlr5gHgHXxWp1CF9fe84y/OpfxD42EF6uUNdRH1gRd308ELZlstHn0Ca9uofG1+DX1+aD/W9qC6j1PTZ9Lu7KB3AT1+jzqRH/zH3gWLD882mJTCI9s6Vk80pmtvRsucShLmcKppPBM/zoZp7/VS86C1oQ0OoKKbQ0JhcnH/L1WM5Nh2SZIQ9vAcyZ21FwpkGYB6OEYQikLc3axaTOnvITUSGwOviIgo24F/y7N5BjGhXlfs0NoAEfiIqY0luJ+K8lDEGX9kYnDhVwxhucCsEVemwkpQckaSVxq+BefF1/CSMC+x1KfG6n6UfJ/S00hD2Vwn7fMLJTURVk2PQKXZpf0y9X48teT54TFGMcHDwRaHEix3LqF3ziF0MHjxdU8xDONrGB2vd9GfP9T7uk5ZbNbL7mq3xESHA5fYDJOdTEywSorLjfFx+fYpqeFxOCGd4DEAh3w8BW4Yg3KR4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(7416005)(52116005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmtGY2JWWTZhS1NTYVFvUFJHVzNXMHgxeWtSblo0WTNuM09wbTM1eFM5NG91?=
 =?utf-8?B?UEdqZVNLbkJMaytvNko0b2VzQ0MvczJtUnd5RXBodURNVVIySTY0MzRZMFNl?=
 =?utf-8?B?WjhKTGhwV3ZqN2daQUFvY3QvclUvSStqNTVmTVI1clVKVmljTG1aOXpFZlpJ?=
 =?utf-8?B?MHFVdXRremF1OFZITEpSb2sxVm5QTm5XSU82OTFlb3dhQStIYjRBemtGUkRt?=
 =?utf-8?B?K1J5a3NJVVhvS1NZdFRUVW5SVXp1bGxXcGxqQldlM2plTi9XWk9CZVArUGZZ?=
 =?utf-8?B?QVFTZm40U0VIMXdVTUo0YVRmd3VuMjFoYnE5U2RPbVFwZXVsVlRoc2xsUE00?=
 =?utf-8?B?KzNpL3pvSTk2Njh0NGJCNUw4TjEwcjhMcFphUWNvUnZVdWdLNXlnMEN2ZzN3?=
 =?utf-8?B?VVdOVDZVZ25tbmFnSHFqaFNWSERzT2h4Q1J0NmJ5TG00V3VKZHh0ZVlaTVJ4?=
 =?utf-8?B?Nk5JeXNHQ1dvRWFtYWpVSWZZYlR4S1ZwNHdZNDFuU3RlT3lVOWRBMUZob1Bq?=
 =?utf-8?B?SXNUd3RwVnIzU2gvcHNva0pEbk95Q29PQXhNQVFHazJFM0t0SXdtdzZFaFJO?=
 =?utf-8?B?OGtYZ1BsZUlUZ0x0ZWRRRFlJdGtqNlFkczY4bnJQWXBqRFRQUnJOSlI5NDA1?=
 =?utf-8?B?elJPcjBZTFRzMjY5OVV2UDRnSHRTSkU2VzIzdVFUTWk3VktBQjAwb0Z6NFV6?=
 =?utf-8?B?L3BpZUlMV1BNSnBRNjZaVzBCd0FrVmxGOWJZVmNOaDZuSjRrS05iRXZyT2Ri?=
 =?utf-8?B?SW92NHVIUDcxblJIY0FybUcwNDVOeUpPZlNUOThHRnNWQ21sT0duUlUzeE5K?=
 =?utf-8?B?dXNnVE9Ra2cwVUJGTit1SS9xTUpzWDNrZk5VQ0doeW9vbUJESERUd1RaQXZo?=
 =?utf-8?B?akc3bHlRM21iaDlMN0oyb3VoWWYvL2E0ZitBbWFyQlQveXRkNm1PL0hmeWIw?=
 =?utf-8?B?TjBoWm5CbEZQZ3I1VkpHTlh6YzFGQ1k4Y3NwUFVDU0p6TDZ4NVppalNIWDV3?=
 =?utf-8?B?WTA4TzdzdUJheTdlTzdId2pBemhYWTFLdHB6Vko2bnd3d1VLMGMvd0tWaWtj?=
 =?utf-8?B?dTd4NmM4aGNHM0pkV2Z2TVhDS3AvVWh1bjFPYklBM2sraHZLYVMvU3BYL2dm?=
 =?utf-8?B?OUlnSy9ranlVZmNuUTdHdnVtYnE4VHRHcWhOaVBJV2UvZ0twN1g1U1RMeHgz?=
 =?utf-8?B?U3dnMEorMmFKRXVuMHJwS25tWm1OVm85ZityQVJ1UDY3cGMxc3FLY25aNDJE?=
 =?utf-8?B?TWtJUW5YYWV5RnhYNXlJWUl6NEhlQXFuVTlORUh2Z2pDTWRBN3ZrcXhLS0M2?=
 =?utf-8?B?ckcxOHV6RzJwYjAyUDdEem82b3BoNnYxeWN3cTFSejVzNDlycU1ER1FyaCt1?=
 =?utf-8?B?VjhpTmZGSXlacSsyamk1RU5JVWNLdCtQZTZGRXppVFpnTWQyQTIreGRESS9r?=
 =?utf-8?B?bXhPM3lIZ21ENE9pamZxaWNTS0pMd2VZQ2dJY0FlRVUwbVlsRjl4NVhxWkxF?=
 =?utf-8?B?MC83cHJ3MHR2RHJPMEs1dUp0eFBldERRcElRbmgzT2I3eVgra3FqekhQbCtp?=
 =?utf-8?B?WFNxOU9IL1hJNFBMdEdLS0FkM2FmZlQ2WmVONGlWdCtMMWpiTER5dHY3Sy80?=
 =?utf-8?B?MlB1MjdyUFFGbkNLNGVtODUzYVhtaExVWnRqVG9VWHhUY2hEVjNpK2hXQ2w3?=
 =?utf-8?B?ZVpkT3ArWnFxd1JFT3FORWpSOUpsd3lsNGs3UjEyR1M5cDhQejVQMXh4MitI?=
 =?utf-8?B?QjZoRkdGY3diU2VnVHdOcm82MDg5QkEwc08rZmVOM0RRZWRjSVhaNGFKejN4?=
 =?utf-8?B?VEIzQ1BqdEVmeklqNXpEMGlINTN6NkloS0c3THcwWHFRWXIzV203bXdEbnU5?=
 =?utf-8?B?MkhuMWlXOG5vVnp1UzYvT0pZdWxLYVE0RWNQUmVDc0hMUXFmcWdlUFdpczdK?=
 =?utf-8?B?blRqbGFraXEzZDR6RVpzQVE2dDQ0MFk3bmR6NVkyVnlmRXdxZWpJU0Z6ek5j?=
 =?utf-8?B?MFVWUkZLRXVhRFpacWNhMkFQOVdYUWFHM0lBcFRFQ0pYZmd5bmRiek9mUGd1?=
 =?utf-8?B?aVVJdGlqbHVYSWxrNCtac3g1UElZdGVXeHVtUnlyNGJOR2FtU3F1Q25nRnhv?=
 =?utf-8?Q?KPFQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c0f9ae1-caf8-4f4d-aeef-08dc5d830272
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 19:34:04.3890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Iax4aiSNHthBHPCXNxmUu58H+MPk+VdcFa5uAPm07shOhUIcqA8CwYK4nurz5Arr0Fyn7IMF+lkYi7zUBIKMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10279

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Add "code" and "routing" into struct dw_pcie_ob_atu_cfg for triggering
INTx IRQs by iATU in the PCIe endpoint mode in near the future.
PCIE_ATU_INHIBIT_PAYLOAD is set to issue TLP type of Msg instead of
MsgD. So, this implementation supports the data-less messages only
for now.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 9 +++++++--
 drivers/pci/controller/dwc/pcie-designware.h | 4 ++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index df2575ec5f44c..ba909fade9db1 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -499,7 +499,7 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
 	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_UPPER_TARGET,
 			      upper_32_bits(atu->pci_addr));
 
-	val = atu->type | PCIE_ATU_FUNC_NUM(atu->func_no);
+	val = atu->type | atu->routing | PCIE_ATU_FUNC_NUM(atu->func_no);
 	if (upper_32_bits(limit_addr) > upper_32_bits(cpu_addr) &&
 	    dw_pcie_ver_is_ge(pci, 460A))
 		val |= PCIE_ATU_INCREASE_REGION_SIZE;
@@ -507,7 +507,12 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
 		val = dw_pcie_enable_ecrc(val);
 	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL1, val);
 
-	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL2, PCIE_ATU_ENABLE);
+	val = PCIE_ATU_ENABLE;
+	if (atu->type == PCIE_ATU_TYPE_MSG) {
+		/* The data-less messages only for now */
+		val |= PCIE_ATU_INHIBIT_PAYLOAD | atu->code;
+	}
+	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL2, val);
 
 	/*
 	 * Make sure ATU enable takes effect before any subsequent config
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index d21db82e586d5..703b50bc5e0f1 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -148,11 +148,13 @@
 #define PCIE_ATU_TYPE_IO		0x2
 #define PCIE_ATU_TYPE_CFG0		0x4
 #define PCIE_ATU_TYPE_CFG1		0x5
+#define PCIE_ATU_TYPE_MSG		0x10
 #define PCIE_ATU_TD			BIT(8)
 #define PCIE_ATU_FUNC_NUM(pf)           ((pf) << 20)
 #define PCIE_ATU_REGION_CTRL2		0x004
 #define PCIE_ATU_ENABLE			BIT(31)
 #define PCIE_ATU_BAR_MODE_ENABLE	BIT(30)
+#define PCIE_ATU_INHIBIT_PAYLOAD	BIT(22)
 #define PCIE_ATU_FUNC_NUM_MATCH_EN      BIT(19)
 #define PCIE_ATU_LOWER_BASE		0x008
 #define PCIE_ATU_UPPER_BASE		0x00C
@@ -303,6 +305,8 @@ struct dw_pcie_ob_atu_cfg {
 	int index;
 	int type;
 	u8 func_no;
+	u8 code;
+	u8 routing;
 	u64 cpu_addr;
 	u64 pci_addr;
 	u64 size;

-- 
2.34.1


