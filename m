Return-Path: <linux-pci+bounces-42930-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 022BDCB4EB5
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 07:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 678FC3001634
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 06:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0759D2877E9;
	Thu, 11 Dec 2025 06:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Bfg41c21"
X-Original-To: linux-pci@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013033.outbound.protection.outlook.com [40.107.162.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC642299928;
	Thu, 11 Dec 2025 06:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765435746; cv=fail; b=mSf45UPOzQDqndtyytNpBfiluILwOZVADNk1iEnO3yfP0+kasf6VQ2vAB8FQgcaQhklZduIPi5lbN9DxaTuWNDnSg6LrH7IaqQ1z1xP/DBZ5Ghftz0P1xFzbnk6YzjXN8knZrsVeX1Id1Yo9ec9eoudWSBhCJhmhfpk6fPHBSRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765435746; c=relaxed/simple;
	bh=HLJ1UslZwatMbbECQckNxT32NTA4Tyzzy6m5HV9NyFg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TsfTXRPhO4qH1OEOsrnavq55LbR9DzU2G04zE8bleLVzS333NOyKZEwCRbN2CniBuPCI3IcHEBSDd0wkL/671AvbWODbLRIGUkIE8Jdva17S54G6Wd7TMSPvKMAvnTW/PPIZ3DO4Y3aWxXf84ZQTMeK5TmqVvjvoSizLGeUqOEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Bfg41c21; arc=fail smtp.client-ip=40.107.162.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O2rmp5RpqA6NQ6tzpIH+2F+Pn4TnfqYa8iohjRYiL1v5bh9zL7QTIqkdWsXB90PUGscQEXB937qLA03LaDUmoc+TFQ1yE4unA89iqpxQXLuqPL/Oh62i3KQ95wlmun4J6KqqkmoTl2B41DUbteweBIMlbvnxYW+KWEBZaLfhwF6AQEts8U1JlAVudKn7GMohIyvk3aUOdRA+a6hN8t7LZ2wpc1raKxsfnrUhxT8+fxtGp+i3Ew/bBtvjjvo+ggJW48qlzuonqExDkkFP3tnhnOa4Wm2UyJnqmqkEZqwjhqPGmUPAHq3R0lrhv7SwBtNzz4ATS2zRu7OLTXmY3Gotjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xxZozv0F3QKY3YkQ/IRGi9I3HQYjF4mDsiiwcH9e/uU=;
 b=W00jM3InigNvvot7m6kZLZhWHWJ9XLP7VFGfx1bOzTHrahIQecSB3HsjPLkr4yxY8ji1nhcRRCjwMoh+O0wH7XZjHsRs2lU4mdT+1FkGetKi118L/6vSf29wuGGC6stfeY00l6MZ2gmYvKbIKTzlSpZCuBYrxT5ReGBV0x9C6mT+H1F1XFZLTAS6T+NsxjslhlQnaAkTqBOh+xBz746yIIPZ/aOI00cvbEjOA6gX9a5mbm7pm8Gqu7vdVk0ptg0doVuN7RfTUycI8aeOWEXym6PUN85m+K+AtKcvJMTHLQEvWDlo9Yfc8vlgS1pzLz3lOI16UcOmuwfPD53R2UlrSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xxZozv0F3QKY3YkQ/IRGi9I3HQYjF4mDsiiwcH9e/uU=;
 b=Bfg41c219TOF11O+U4GO7DCtT+EKc3yDkjRFBFKte4/umYSk73jyXSGu6luTPk53WnLFmWuUHN1Y/U/4SyzMHlVPS8q8sHFpftLO4fAiR0wYPGqxaE2uRl9YewT9ZFjODJL8RAMcpQv21ly6gdkatRvA7NtNCrYcZB3uDbah/zVvIdxrlaUsmjvxtq03tdftgI1+/oUSnmaHqsHR8/FQdb/0NOzZmiLZ8N3OAPzmGXajFiwcAG8QNVhVdfgu3VLULj9SIvHsV/toqXSnIDsJVnG2CHdA7CJqvfqVwEjrXQhGrqVzCTzbmY7mWzf7aUgdViv77hUD8pzAiMA6SJ2Znw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by GV4PR04MB11944.eurprd04.prod.outlook.com (2603:10a6:150:2ec::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Thu, 11 Dec
 2025 06:49:02 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%7]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 06:49:01 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	bhelgaas@google.com,
	frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v10 1/4] dt-bindings: PCI: dwc: Add external reference clock input
Date: Thu, 11 Dec 2025 14:48:18 +0800
Message-Id: <20251211064821.2707001-2-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20251211064821.2707001-1-hongxing.zhu@nxp.com>
References: <20251211064821.2707001-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0009.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::18) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|GV4PR04MB11944:EE_
X-MS-Office365-Filtering-Correlation-Id: 042af198-f2d9-4a69-083b-08de38815e0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|7416014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ox8nSb5w9OF2zh38Yv86fhdzFvvsktxia/bxEsbUA5vQw3KIay9HqnL0Qr+S?=
 =?us-ascii?Q?O8ikT877w8bet2nqV+c2NI+MQTaSuNqc/O6aDqpZrVtZczpkLdOMmi3DEhSY?=
 =?us-ascii?Q?+9Q7HFKBeBvg0453L+VCe2Y7lVvgJJ6oPZXAPp8m9RcJVUH3kC8qhZ+C2Hri?=
 =?us-ascii?Q?VGJGGKFPmCjC7lCboNmU8UEfaKmyrA7ql1VRqIcyasNpWREAm2Xv86YMFkWz?=
 =?us-ascii?Q?prBtWhayyGVMs9Ik1eMMwiuaOdmIhOZIKKr3jJgH/op5dZheWLe9ww/nMz4V?=
 =?us-ascii?Q?KvApKDUu4oG1ZA4qnv5eaYc7m/6DN3jNFsO/DKV1OrKYaiPNKjIfSD7A8ScZ?=
 =?us-ascii?Q?I2+8g2L9Mht6mujkcc09pqG00IyG89m/NV6IQwejSCK1QeKhlewKxWr9523J?=
 =?us-ascii?Q?xlLRjdLgjQVVipeANqZaR6OqByecQltmL9ejnCUGTAJpCWWsmFssFTh5hRnJ?=
 =?us-ascii?Q?73yzGftZlDNBYfMfCjrGBb1Ipm1H+nbOQvw/XABFoq+FBIn7F5YOCrDrx/9Q?=
 =?us-ascii?Q?jb/Z710qQR7xxymCfNASVg1WSPs357Bs4I+gNrC0Mp0la7QZNk9MNDhT9ycp?=
 =?us-ascii?Q?DKMNytD7l77GadWGhBXprnmBmY7AtNL1qQ7HvzZYDM4NxdbUgHpbm38fstA+?=
 =?us-ascii?Q?yqPX+m7eUsyMYIgA4GFjJvXXej4VqZx8OsYdh9l5TZvA3szWT7GwP7DEhRnK?=
 =?us-ascii?Q?dl8rOKjjW1TCYr0CUuPcWLmPvkHoLbrAtUKmUXRNBsY1LtOhEHuveb9fAv4X?=
 =?us-ascii?Q?B823UP0eU4NlrUOH92o4xsp6489SkLTRhGS7c/hqDEE6wrYhU3efRzfFKlf6?=
 =?us-ascii?Q?VQNxv+7yCgnphGmU7NXt0UE5K0zHoq6aEo5S0XUAWUkZDgWJFn/E3g+AGNpu?=
 =?us-ascii?Q?r9bHM8oIKYSYTSYI9ERbhGdhcyeQsYmrzYENFzul8h8+wrf+f7B0nSgq94Do?=
 =?us-ascii?Q?ChMi4OUyjEEruV3TJAa9Ysl7fo//WSkSRIYHBsdP35HphhUzM4dZ94fW2Bh+?=
 =?us-ascii?Q?7rZghgqPGNIBkv4CJEF95hJQeo1lnkYJ0d6Qe/JRuHOrHw9rKKa8vY8tgpDb?=
 =?us-ascii?Q?BXcFCtoLXdM5uB1oHSMkhATYgdtHT34QES+UEG8re0eVOXiqtS64ILl83aHB?=
 =?us-ascii?Q?X53VifRoO1yXeKeXssSWCf8P44UcrspD1XvMlfaMb1XoPpDv/aV4oZ63biTR?=
 =?us-ascii?Q?DzvqF7afSLEqD7rvXDQlMHXAKSVS8zZrgCdyMFce11VgTGS5JJxI9wLwz8iW?=
 =?us-ascii?Q?8+nE2sAYmLmCmQp60S/ZEwsVhDVJZ7w7sr0N1ytEmpb+0yJjaoTIHBDvBTic?=
 =?us-ascii?Q?oibhYxjonPq1tMgsP8M8ooOKTukAUaascqzj5LqS69S/f7baRhh/GFo8hZVR?=
 =?us-ascii?Q?B4/h/tKMbPSjhkuY+ttIZnKr1V/M/mwhG4dJ1Q+4o7/NwrbLPHw1NO1ggPLK?=
 =?us-ascii?Q?D8QEFCwYupSPm7AG0z1CMQLr9cqMsv9Rz+NBLSxpeMtUGekbFMLbJA/Oj1TU?=
 =?us-ascii?Q?DY4b6+sy3GOmDh7nr95h50O4hBjjngWdddWCZjpQbktG+bHEjG+DC1x/ZA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g+/Jhb/K70JtIRtbtoJOQmgFYFSkrtm5yNOYzcEDgIs35CF4rA5sWO6TGUGY?=
 =?us-ascii?Q?pIZ5Ed4Rd/cl3KtTwxc5MdVTR9JdBeMINs7qSrW1yA3Eee36mDIcnkgEfxva?=
 =?us-ascii?Q?j5XrRmPSmLOP2E7RDht0ax5KXCNHwdezT59Szj0uVAetdhoCUgz54Ke2gXVI?=
 =?us-ascii?Q?mQRQa7jl4hsBwCOIArLWh+8t1ZRzugGRgKcVGOC/PMughUo5w2ioBEYkBkou?=
 =?us-ascii?Q?a+y0HYdE1MyevbbbFJKTgWyB1wFvrTuLMQ+mjskK28PI1HNEwA+2DBgPrrIO?=
 =?us-ascii?Q?6P9RfDN4xb9v3CW7YgAdd53GA5ElMNecVo4EHYR9GUH+y5BniwVkUY40XccU?=
 =?us-ascii?Q?5EoGitCLlSqTalqurtUxQKCM55PM9khhBsoJ7I+F/hFSkLOCAVelEXNtEaYR?=
 =?us-ascii?Q?mAWclztkkuL5235Ys+UqMzil7cJGIBF9KSeGIEQadt5upxa6/tcexTyLVhtV?=
 =?us-ascii?Q?ZS41P64yzpcZbD+gA4muM4HD9G4ujE6g07dJKbHEfs0nCLWao6o8BKGaGjJ1?=
 =?us-ascii?Q?hHWWUyifiH0nksBdKo1PGIrnRH66/ZeA4sBfMZXBUSMaJfgWlGBsMWZIwg5M?=
 =?us-ascii?Q?foaFOQo8EGG6AFOgwUgwmg9rsos6Xc3SUcPna9nJTgJJpoDRBWziq2CZ1R6K?=
 =?us-ascii?Q?bnphU3b1/S7sCImvu+YoDMLsUa3Uk/+Nms9OPECli3NqwUS41OjB+1+E8d3m?=
 =?us-ascii?Q?fw7lPvGFgW9HwSK2/DAv/nYlU+ft+zOSP/P+dwu3kZLqkaWF1xbqwkYKuw9p?=
 =?us-ascii?Q?Pj0xsyij0eW9FfGfgQpKVsTPOQzP8wMgS/5F/yPCAMlN+ztDPQe3tzyr8Esy?=
 =?us-ascii?Q?1dNpQGD+4DOK4ekdYR4Qk5Q5RZJz6kyxO6NAj/TzeemCb2CEN///J92gdZg5?=
 =?us-ascii?Q?i9lWgH7yhI0N8iheqnhjmUfHRiI7vMeAyHy4EV12cZxw6k8FwyyK43sulLGT?=
 =?us-ascii?Q?mmQwneQQF61sgk0W9iy2w1xmsxLgRf1xQZkte4i+pBn+yrN6Zll9lFqixCh7?=
 =?us-ascii?Q?QJGFTE5iTHo3nMKEVfdEFM9YiM0G60wCgu7x09bQ4hQRm677GIxmhwZ9Ddl3?=
 =?us-ascii?Q?hjSgxC9MuFIKHdyztF0jCNPru/w2JZ8GriMI49mvKyova3cp0+EIdAivJJ7b?=
 =?us-ascii?Q?u3I0LTWbdgh8TdQll0Zf4ymeIxZvJTX3+usGRrRl+uF61on6noxCSibXJjNU?=
 =?us-ascii?Q?SgzH0gelrAYsG4jk2QDKhVxkKP/lBEGKPEAGc/0kcqvB/8AN4geSVOajByPV?=
 =?us-ascii?Q?3ysxsbgJ+uFu5SvRxdRwD+AXM0zPqKU8ikTVxAX2twltRSWhL5MfZfU56FIV?=
 =?us-ascii?Q?WvTxkQjpS9/i0cleJWxTU9lpCxCvPA00fSHdUSEBsA8Dellp5BlCVGY2cfVZ?=
 =?us-ascii?Q?lH4PvsEnTSpIGfbhUQ6YcfGgQ2qxcZd4xvzJfzhaGMBaFJycHblBAaozlBd8?=
 =?us-ascii?Q?TvFQlvqAt4levxWjB9V8FV9wPCyhQnGWZ1ZcsNX0vrvDk4S294ci38ElLGvr?=
 =?us-ascii?Q?IBNx2yfmMntNMx7cWJEaeyQK0ZfCXYgt3CwvbzmcjV/AHRnLg8ku0gYCaN6F?=
 =?us-ascii?Q?09aRRhVMA1/eDXDCxRDse+iWT+LtBTcmgX+ug0/F?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 042af198-f2d9-4a69-083b-08de38815e0f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 06:49:01.5924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CEs/c/m0WdQ9R9UvusduRsu+pjDZSLGluSzW5plPKklMKl3/aPGWBx1tPcJt+HetTvFeErTRlIefk/vTSYmQOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11944

Add external reference clock input "extref" for a reference clock that
comes from external crystal oscillator.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../devicetree/bindings/pci/snps,dw-pcie-common.yaml        | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
index 34594972d8dbe..0134a759185ec 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
@@ -105,6 +105,12 @@ properties:
             define it with this name (for instance pipe, core and aux can
             be connected to a single source of the periodic signal).
           const: ref
+        - description:
+            Some dwc wrappers (like i.MX95 PCIes) have two reference clock
+            inputs, one from an internal PLL, the other from an off-chip crystal
+            oscillator. If present, 'extref' refers to a reference clock from
+            an external oscillator.
+          const: extref
         - description:
             Clock for the PHY registers interface. Originally this is
             a PHY-viewport-based interface, but some platform may have
-- 
2.37.1


