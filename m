Return-Path: <linux-pci+bounces-5548-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B28D78956E4
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 16:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D552A1C22190
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 14:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FC81332BA;
	Tue,  2 Apr 2024 14:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="s2mao6s+"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2126.outbound.protection.outlook.com [40.107.22.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE7412BF3A;
	Tue,  2 Apr 2024 14:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712068473; cv=fail; b=JcMCEhjwAdWUtebb/YjDHTDSbYYhyhyOTHfHsZGtts4+WKEFhzSJCs7ZHLH0wD64khWt0k6H6Lyqc9T05dRe+5WlEkXMdcm/O6eMwFEJ4dPEvmJfM2bcmx+JD7J2C/5ldpNpiYyUVnbiJRQpooR2dVciiUF1RPWfmLBOxjs5r8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712068473; c=relaxed/simple;
	bh=Zkat84ae4D6SJKi9k9YgxhUo2QzbOldgU2Uww6OuZ8w=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=cpo3OKGfmGQX52VH3FRG0K5NQFNp11YmgGzdY8bWYmqlP0v8oRkCn02nwVd1uNthqV2rx4u9/YUGlm6jMl797H20YBK1w/51cmzq0mVnth3BKxT8CmBUBDyl7tRXQ7DBhUVDvky31QONsnAQq+zC2ZovL9iv9n/ieOVaDk+/mac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=s2mao6s+; arc=fail smtp.client-ip=40.107.22.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LNdZJRby9zoUKj6k95n3aDInG9kIW01diZkNv0PIQPqEkOWglyHL/lNef8ZChqz6qOA65OZ1SO/fTWjd/bPyH/PYv8yXIerhK3ohWee9xE0VYXMooPX0Y03fBO5cDjAExMbFYC+9FPnmotq7p6UOqIffbRB0ODXVCfjs6G2KqsZl7FZKU1ilQrcIb8dZ7IHHb31KQyBv6pLSvO+xxaeN7Rt1a+sSU3ZDq0QQOXId3q6NK7oADRpAG8vzsZJZRmyxdMXKVQc5WtPGQD+wgbsoiu6ujOOzGbvC9Sog/PpK7oAsr5mmet8jDtZZqxjWRPb3vYkB7dzJ/yZ1+QAgnhThXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MMvuhnK89TFLqeVqTbSme4IZrMraiLpWEPVOPWW1QQE=;
 b=mpMOmHz7oONOtv9EM7eujh/y+/YOz/mob6swI86mt4JImHEA4XwI7hbdgV/93CPUlbM0ccP8G3MnO83DfUruQHRsYEFtcqMWJLu4t1XdYw9iPHp7r32caLCac9ucRXcuxXTT2gYfXB0eSytKXIt0eXDkfAityLGjvnatVwKsFNvCj4CXYfntbPy9HbWwRvVng/LFwNGDrxGnH4iwNdzj4Xo7PeUMnivlxRBffAAoDQRc6B5PAGScAXj+nc5RjJ5/bkkFOcFQU8XAQSgmT2svIYcXofID1wpqZu/GsEmy+irVYrjTD86+JvR1lUl/lZWczKvHsdYdPMnphYbeiKeM7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MMvuhnK89TFLqeVqTbSme4IZrMraiLpWEPVOPWW1QQE=;
 b=s2mao6s+TNzgO1DprVi1Hf40gwGcT61FOTl/WH1lgHgMcKsyewNplHb19JqvrRqwCEcANFiU7Mx1bsVqE8ISoru1IF39v+nmL3fxc1N68lH/N6hVTyfWoVqv66m1RvwYleluSs3SIzZXwlgHF0bXgzeG8bMfXQNcg/q+ejoYZwk=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8926.eurprd04.prod.outlook.com (2603:10a6:102:20d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 14:34:28 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 14:34:28 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 02 Apr 2024 10:33:42 -0400
Subject: [PATCH v3 06/11] PCI: imx: Simplify switch-case logic by involve
 set_ref_clk callback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240402-pci2_upstream-v3-6-803414bdb430@nxp.com>
References: <20240402-pci2_upstream-v3-0-803414bdb430@nxp.com>
In-Reply-To: <20240402-pci2_upstream-v3-0-803414bdb430@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, devicetree@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712068432; l=8518;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Zkat84ae4D6SJKi9k9YgxhUo2QzbOldgU2Uww6OuZ8w=;
 b=shQ8QZKR8yRWA88UqsG+XTX+cBOG+AdO6vSvuEjsbquiPESZYMJHF2vB11UR7YZbGsW1vOT4s
 n/IOsEsqO14DI81quZJva1IMwp+i6iBjPiFsAMLpgk2+QH/aF5k6GA7
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH7PR17CA0011.namprd17.prod.outlook.com
 (2603:10b6:510:324::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8926:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XSTfYK74N/rtFJkI2ez7Jm9zfSyaaD/8+SVpyMeRlRABuq9najvxX36IUYqrXCVEK24lpVWQBpjCqJf3/84YnPe2WloisY9MtUcEMcrefRuTKJrMxLHl53Am5CJ9L5kn9w36y7OuGXkthHibbzVaiTpMiy03yocmqG+aoqomaRcEwuxsqPwtYkOVZsbNTxK8Sc2Ymp9qszpbZxmW07roVb4dkeRDvsyZ3T5PMAU7RFW8h0EiSh1sNE9PIKhcmExOVnHx30/q1/Qa3FmR6Y7tFobLKDZF89nEwQCgeIPJm2ThfoS1DDt64AuqsCrUySy+2lO2XdFaCVKzO/C2dUtBPUiZdsD4we++danEtF51M3sOmcfzvfkjBBc+k+kkiFmYBd0UxgbYD9mBC8lvU8bhEDz+lGv8+bqNy3ZPEdnKUi6wWDo+oW8flQHN0VXnhIFpKyhkfHqo/5+/PlNXSoF7c/SQ2Fef0knHjj6Z/T+rJPtg7wAB3JX8apOyqTwohx7emlWZ75DMYWezszlV3EEg9LqBljtn0mFrsm+KX5Bu9WLGx10G6DCxV8WbNOasmsFBZmO4Q/hzeKqQEz5r3TkPPycLzXtErYtqiFN+I7p33kkSejC4kWMl3AvOpmIBdFzeYc0zFzzW12cA6O0B2EBlkGbT0bijAYOAxKsmWOMJAqdmM94zbT0G824iR3QqB9ir5b9ffmbaaMX+7xziUGP21RWX3Uf+uQuCoi3HFd++oAs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(376005)(366007)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1ZGZHN4dEZ2c01lcXRwSEhjMzNJWXlmL0xid1JLbDl3Z242RHl4M2pWWDBR?=
 =?utf-8?B?NS81VlZDemxnYlRUQkZLaVBRRXBzdFdVdS9KTlN1QXpJaUZxdmxQVEl4Wlh4?=
 =?utf-8?B?WHM0THl0VlFpVGFQTkppczdFVWNUVjRjT1JoRytpUXhFYnp5RE9ZRTJnZ2VV?=
 =?utf-8?B?Z2dRNXpDdVVSUGdRbWlZUVZUaFRHNktHWnZ4b3QvQ1BZUVgrbkw0MG03bmt3?=
 =?utf-8?B?R2Q3bGp6SXZoS29uMjB3MFNkTFB5ZTRDSVNwa1BiMVg2WkZ4Tll2blkzSWlY?=
 =?utf-8?B?WjNDQ1hmMXJiMFo1b1M5U3RNTFdsa0JPQmsxcndoVnZETWZMeTJqRjIvdXdK?=
 =?utf-8?B?Y0RYRitUWUQyMUNvRGtja1VJR0lJZHhCdW1zY2xXNW4vc255aUZWTnp6T2g4?=
 =?utf-8?B?TUUxbmNFWHBxdmNSUDlyVlovSWF6VHpjUDRRemdBVEFYcVJET2NIS2ZsdW5j?=
 =?utf-8?B?eDY1dC9CcDlkd25LbzVwZXhWMnNUaWlYUEtFbjFldm8renhvaXFDWDdkQ1NE?=
 =?utf-8?B?ZmY3VXBLUVJpQ1JybUNraTBNUTlodVFVQW5oOWZLTXUyWm1mV1ZsQnArYjVK?=
 =?utf-8?B?TGg3YzhHd2w5a0lhQzA5SERQWktHOURVdFo0aFJqZFAzSVFNdkwwNEE0enUv?=
 =?utf-8?B?NEtocVQwUkRacTZXMnhJUlNzdkxpMG9vRjIrL1RndkVIeTVWMFFVdEpLcEVI?=
 =?utf-8?B?dm9lR2ZaQ09BMVY5bk1hTU1RTEc4VndwRlF5RERvTFJ2QTBXZzUvZUgyZnRB?=
 =?utf-8?B?RDY0SDJ3T2NoZlN4YkhYU1RCYjN0aG5SNlBTeVRqY3pIdHQ4SE5ac2ZBUDVI?=
 =?utf-8?B?OUJSdEFGM2lwQUx0T3N2VjBreGQxbitDdHFtTDJ2c3FPSkVYMHQ3ZDRZdGd0?=
 =?utf-8?B?RGlNdVp6K3NvdEVQcHZqM0twYjBkamVuVlQ5em9RQnduYS9LT1ZORVg0TThm?=
 =?utf-8?B?S3pMRlNEajFsMHJmd3pMQThwWDVRN2FpZnZycTRzU1pSWWhvTENuNUt5VFNE?=
 =?utf-8?B?TVRjN01hYkl6QXNMY0tHb2cxMzNDaG1scVgxa290L2pIQTBnUEtvWFRBQkM2?=
 =?utf-8?B?UjBWd3ljSjl0V05XbGxlRytLWXlxaUdpMTZ2SVU4dE1Wb3VMM1BIVDNwblV4?=
 =?utf-8?B?a25JSmFUVElqMG1YVmNCR3ZDQmswMytFZE4vVnJJUHhPcnFCY3liOWc3UWgy?=
 =?utf-8?B?SzlTenVqbGlwWkxkSnBwQTE5djhUV2ltbWVXcWNrcEIybGlHOVpQSjA3OXpK?=
 =?utf-8?B?R3ZoOHhTWFpWNUJpYWh6REtUNHkrUnV0alRCa3g0YUQzOHh5N1NPUDBZZ1A1?=
 =?utf-8?B?eG5xSnJlbmFWcFF1MTJpUHdwWFJlVDl4bW5nQmpEalBpZ05pUjkyWTQ1TGRO?=
 =?utf-8?B?U002ZE5TSGx3bk1Rdm5CWE1oell4Nmo5eXdCRGhmMGVWZjJPK1lBTWxvZXk2?=
 =?utf-8?B?WWhwaFJUSS9aZHJ1NnExSjVXWjJ4cXd6UzR1alpVODd5NUhjZDM4U1d6Nmha?=
 =?utf-8?B?MytBR2M1RmJPWmJycjhKV3oxQVFESkNtSjdveHFzc3RpTVgvdkE0N0t5OVEz?=
 =?utf-8?B?VGdiM2RtYkVPbTA1akFSbGVQcTNwRTVVcW9ZRDBuUUY1c0FuL1ZnczA2WmpZ?=
 =?utf-8?B?c1RMZjBncUFNMVU3MUZ3U3FBb1RJY25RNDlaQXhkMnJTZHRwSzFpcnhVT3lI?=
 =?utf-8?B?cGNyTUx2cE00YloxaWJBS2E3Yml1MlRPandwZ2tpaGNRR2tiNjQwaWtpQmZY?=
 =?utf-8?B?VktVMVNnSzhsSkZObDNzQlJjS0xaWFd3U0RydXMxbzJXc3VhS3NjaFk5bGFE?=
 =?utf-8?B?LzVtdnV2RjdDK0NybC9CenpOYXhYcU9lRFAyZ3U2cytEbXNtT0RwKzRMbmZk?=
 =?utf-8?B?aGsvZXRyb2x6RUcyMURZRkd2VlMwemhHb0ZkdldCM2U3dW5NT2JZdnM2azJu?=
 =?utf-8?B?VGNRQ0Q3RnhaVzFwY2xsWnF4S1hQeXV5RDZ4enM2bzNRRktnNXQ0T2NaRkpp?=
 =?utf-8?B?RFVzYkVtY2xCTG5tRTE1RE91L011WnNhVlhzWHR6TkQ1bVhPY29pOGcrbUtL?=
 =?utf-8?B?aCt6MXZSMVdQWk5wN0pXeng3aXZuOHBUcDdpb01GRmhucERJbzBwY0ErV2J3?=
 =?utf-8?Q?/uzI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1c0610f-578e-4831-7608-08dc5322005d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 14:34:28.1311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SMhYZraARkPrZK5ndgrV2EskqctmhilG8hNeRpTKbetHxFEbIG7FXQCJ8s/vA7g9fjItza8slk9fXrxRD2DW7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8926

Instead of using the switch case statement to enable/disable the reference
clock handled by this driver itself, let's introduce a new callback
set_ref_clk() and define it for platforms that require it. This simplifies
the code.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pcie-imx.c | 119 ++++++++++++++++------------------
 1 file changed, 55 insertions(+), 64 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-imx.c b/drivers/pci/controller/dwc/pcie-imx.c
index e93070d60df52..77dae5c3f7057 100644
--- a/drivers/pci/controller/dwc/pcie-imx.c
+++ b/drivers/pci/controller/dwc/pcie-imx.c
@@ -103,6 +103,7 @@ struct imx_pcie_drvdata {
 	const u32 mode_mask[IMX_PCIE_MAX_INSTANCES];
 	const struct pci_epc_features *epc_features;
 	int (*init_phy)(struct imx_pcie *pcie);
+	int (*set_ref_clk)(struct imx_pcie *pcie, bool enable);
 };
 
 struct imx_pcie {
@@ -585,77 +586,54 @@ static int imx_pcie_attach_pd(struct device *dev)
 	return 0;
 }
 
-static int imx_pcie_enable_ref_clk(struct imx_pcie *imx_pcie)
+static int imx6sx_pcie_set_ref_clk(struct imx_pcie *imx_pcie, bool enable)
 {
-	unsigned int offset;
-	int ret = 0;
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12, IMX6SX_GPR12_PCIE_TEST_POWERDOWN,
+			   enable ? 0 : IMX6SX_GPR12_PCIE_TEST_POWERDOWN);
 
-	switch (imx_pcie->drvdata->variant) {
-	case IMX6SX:
-		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
-				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN, 0);
-		break;
-	case IMX6QP:
-	case IMX6Q:
+	return 0;
+}
+
+static int imx6q_pcie_set_ref_clk(struct imx_pcie *imx_pcie, bool enable)
+{
+	if (enable) {
 		/* power up core phy and enable ref clock */
-		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
-				   IMX6Q_GPR1_PCIE_TEST_PD, 0 << 18);
+		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_TEST_PD, 0);
 		/*
-		 * the async reset input need ref clock to sync internally,
-		 * when the ref clock comes after reset, internal synced
-		 * reset time is too short, cannot meet the requirement.
-		 * add one ~10us delay here.
+		 * the async reset input need ref clock to sync internally, when the ref clock comes
+		 * after reset, internal synced reset time is too short, cannot meet the
+		 * requirement.add one ~10us delay here.
 		 */
 		usleep_range(10, 100);
 		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
-				   IMX6Q_GPR1_PCIE_REF_CLK_EN, 1 << 16);
-		break;
-	case IMX7D:
-	case IMX95:
-	case IMX95_EP:
-		break;
-	case IMX8MM:
-	case IMX8MM_EP:
-	case IMX8MQ:
-	case IMX8MQ_EP:
-	case IMX8MP:
-	case IMX8MP_EP:
-		offset = imx_pcie_grp_offset(imx_pcie);
-		/*
-		 * Set the over ride low and enabled
-		 * make sure that REF_CLK is turned on.
-		 */
-		regmap_update_bits(imx_pcie->iomuxc_gpr, offset,
-				   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE,
-				   0);
-		regmap_update_bits(imx_pcie->iomuxc_gpr, offset,
-				   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN,
-				   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN);
-		break;
+				   IMX6Q_GPR1_PCIE_REF_CLK_EN, IMX6Q_GPR1_PCIE_REF_CLK_EN);
+	} else {
+		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
+				   IMX6Q_GPR1_PCIE_REF_CLK_EN, 0);
+		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
+				   IMX6Q_GPR1_PCIE_TEST_PD, IMX6Q_GPR1_PCIE_TEST_PD);
 	}
 
-	return ret;
+	return 0;
 }
 
-static void imx_pcie_disable_ref_clk(struct imx_pcie *imx_pcie)
+static int imx8mm_pcie_set_ref_clk(struct imx_pcie *imx_pcie, bool enable)
 {
-	switch (imx_pcie->drvdata->variant) {
-	case IMX6QP:
-	case IMX6Q:
-		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
-				IMX6Q_GPR1_PCIE_REF_CLK_EN, 0);
-		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
-				IMX6Q_GPR1_PCIE_TEST_PD,
-				IMX6Q_GPR1_PCIE_TEST_PD);
-		break;
-	case IMX7D:
-		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
-				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
-				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
-		break;
-	default:
-		break;
-	}
+	int offset = imx_pcie_grp_offset(imx_pcie);
+
+	/* Set the over ride low and enabled make sure that REF_CLK is turned on.*/
+	regmap_update_bits(imx_pcie->iomuxc_gpr, offset, IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE,
+			   enable ? 0 : IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE);
+	regmap_update_bits(imx_pcie->iomuxc_gpr, offset, IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN,
+			   enable ? IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN :  0);
+	return 0;
+}
+
+static int imx7d_pcie_set_ref_clk(struct imx_pcie *imx_pcie, bool enable)
+{
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12, IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
+			    enable ? 0 : IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
+	return 0;
 }
 
 static int imx_pcie_clk_enable(struct imx_pcie *imx_pcie)
@@ -668,10 +646,12 @@ static int imx_pcie_clk_enable(struct imx_pcie *imx_pcie)
 	if (ret)
 		return ret;
 
-	ret = imx_pcie_enable_ref_clk(imx_pcie);
-	if (ret) {
-		dev_err(dev, "unable to enable pcie ref clock\n");
-		goto err_ref_clk;
+	if (imx_pcie->drvdata->set_ref_clk) {
+		ret = imx_pcie->drvdata->set_ref_clk(imx_pcie, true);
+		if (ret) {
+			dev_err(dev, "unable to enable pcie ref clock\n");
+			goto err_ref_clk;
+		}
 	}
 
 	/* allow the clocks to stabilize */
@@ -686,7 +666,8 @@ static int imx_pcie_clk_enable(struct imx_pcie *imx_pcie)
 
 static void imx_pcie_clk_disable(struct imx_pcie *imx_pcie)
 {
-	imx_pcie_disable_ref_clk(imx_pcie);
+	if (imx_pcie->drvdata->set_ref_clk)
+		imx_pcie->drvdata->set_ref_clk(imx_pcie, false);
 	clk_bulk_disable_unprepare(imx_pcie->drvdata->clks_cnt, imx_pcie->clks);
 }
 
@@ -1465,6 +1446,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.init_phy = imx_pcie_init_phy,
+		.set_ref_clk = imx6q_pcie_set_ref_clk,
 	},
 	[IMX6SX] = {
 		.variant = IMX6SX,
@@ -1479,6 +1461,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.init_phy = imx6sx_pcie_init_phy,
+		.set_ref_clk = imx6sx_pcie_set_ref_clk,
 	},
 	[IMX6QP] = {
 		.variant = IMX6QP,
@@ -1494,6 +1477,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.init_phy = imx_pcie_init_phy,
+		.set_ref_clk = imx6q_pcie_set_ref_clk,
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
@@ -1506,6 +1490,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.init_phy = imx7d_pcie_init_phy,
+		.set_ref_clk = imx7d_pcie_set_ref_clk,
 	},
 	[IMX8MQ] = {
 		.variant = IMX8MQ,
@@ -1519,6 +1504,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[1] = IOMUXC_GPR12,
 		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
 		.init_phy = imx8mq_pcie_init_phy,
+		.set_ref_clk = imx8mm_pcie_set_ref_clk,
 	},
 	[IMX8MM] = {
 		.variant = IMX8MM,
@@ -1530,6 +1516,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.set_ref_clk = imx8mm_pcie_set_ref_clk,
 	},
 	[IMX8MP] = {
 		.variant = IMX8MP,
@@ -1541,6 +1528,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.set_ref_clk = imx8mm_pcie_set_ref_clk,
 	},
 	[IMX95] = {
 		.variant = IMX95,
@@ -1567,6 +1555,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
 		.epc_features = &imx8m_pcie_epc_features,
 		.init_phy = imx8mq_pcie_init_phy,
+		.set_ref_clk = imx8mm_pcie_set_ref_clk,
 	},
 	[IMX8MM_EP] = {
 		.variant = IMX8MM_EP,
@@ -1579,6 +1568,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.epc_features = &imx8m_pcie_epc_features,
+		.set_ref_clk = imx8mm_pcie_set_ref_clk,
 	},
 	[IMX8MP_EP] = {
 		.variant = IMX8MP_EP,
@@ -1591,6 +1581,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.epc_features = &imx8m_pcie_epc_features,
+		.set_ref_clk = imx8mm_pcie_set_ref_clk,
 	},
 	[IMX95_EP] = {
 		.variant = IMX95_EP,

-- 
2.34.1


