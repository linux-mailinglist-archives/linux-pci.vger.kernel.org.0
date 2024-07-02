Return-Path: <linux-pci+bounces-9594-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB1992428C
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 17:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7A591F22F4F
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 15:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98A81BC082;
	Tue,  2 Jul 2024 15:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nIxCWrUy"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2073.outbound.protection.outlook.com [40.107.249.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795651BC07E;
	Tue,  2 Jul 2024 15:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719934644; cv=fail; b=XM9ove1nXkOSfL53nNDxYvxWjswuaRJHnyzOBfHpR3HmevU7JhSDU8tQUBrkAaGOAdRRN7u+EhULKvh+175sI61wpub0WVP3Xb2fBBcX1b6HEIKYtq2MSjAOiIcO4ryd3XdIXMkiRpuzl8iZceTT1JXF0Rw9qncp4uxDldeYsQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719934644; c=relaxed/simple;
	bh=TacrWxbI3B3P3vnjvvK0eAQtGLix/nOMQNx0ZHYXKac=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=IMFVyDAFFMc+VaqkDnIlAxpxlh/Y4U6FWzH4YnuRAD5gHwUO77dNXmCNTkHGauzPDRtfQeCqIM/VARB2VxtxsuuCED3BIx21IVVYXN2Ul/KEuFL/Nv7OEAWxwM2BRRtNrWS7hFxlCgfDAzsVt+xoUH1gjkdgvAfuxB3hUTPcQuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=nIxCWrUy; arc=fail smtp.client-ip=40.107.249.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YZ4OyaZ8XKXCk2QJ+SShWxBUE/rXQ3gz7ch4K7/FpXwenU/ejkuqeJP2Lxq3VG+TIz7HlmYUfLNH1wvYubydZUJ3ETwAZHZAW3yw4Ho2aFCUKrxOeIu2BHeXyvDOHuEsIaLGJyrE9p+ol8+MRNmivmjuLJTh0sMTpNMIS9ZBX2bT/i04LX6SNGxoaCIW/KE53qGc/B01KjgeHmO6iJuVJFB/R/mr7o6Cw+yscyTZDHvnWgVST1hR6U5RCAp5ezUwkBTpZ5/W2UV7bYvouvZfMTxO7dtDjmqORJmbb0sxBt2Z1TRZqyFnLIUJakJaOJgDnOlDWje86X2IOOl6btqVLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zz19bP4AKUCCv0Y+VhNIKjER2f2QHY3lZ1550breOZc=;
 b=NWbTVRUoUrjEEndJLxRy/sCTT54AOfWRn8lGv81izwKe2L2Ysi6ZPd2ryIdxxSyhbzpCKRxDsG+rlwF0I1gEQ+CD9G3m6xj4ZROFzOXrroxsW+0cr7P5ZwSN1cr/dnkCMc0YcL7EBpdpLJNKKe2MyxAY1eZ7TxDx845kvy0pKU+RfZyR+cOg+1J12H3ubChiwTI+BlfBvKEZ8YpzONYMWGvrkK3hg0hNqqPig5sfORZZjDzxPbThtJDAqvEhXeBzFx/cWinMm5MhMHmu2pWkB+jKtVOIel2gOHkSSa3h+fTVsvzJYjdEnzXC+Mtw7aO7pu3ra+MuDdpUdkE6RjMFww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zz19bP4AKUCCv0Y+VhNIKjER2f2QHY3lZ1550breOZc=;
 b=nIxCWrUyIAl+Px+s6mZpIcXwI5aEsfwemNAe3A2aEYYHlTzQfPmwk4swRKhn2Ns83QfcUG0UTsQfUONJUpx38T6jNHKzDWanyhvzR4lcQPGyc4KpW28AY3epYmt+CqA7PMJMqhjbwF4/C9hnTC5FNOmZ1AD9oe908l7hDu3hBP8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8179.eurprd04.prod.outlook.com (2603:10a6:20b:3b5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.28; Tue, 2 Jul
 2024 15:37:19 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7719.029; Tue, 2 Jul 2024
 15:37:19 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Will Deacon <will@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pci@vger.kernel.org (open list:PCI DRIVER FOR GENERIC OF HOSTS),
	linux-arm-kernel@lists.infradead.org (moderated list:PCI DRIVER FOR GENERIC OF HOSTS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] dt-bindings: PCI: host-generic-pci: Increase maxItems to 8 of ranges
Date: Tue,  2 Jul 2024 11:37:02 -0400
Message-Id: <20240702153702.3827386-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0002.namprd07.prod.outlook.com
 (2603:10b6:a03:505::25) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8179:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f0f84a1-1b2e-43a9-26b3-08dc9aacdb94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?em79OnpPAvg+ZZ5hZidiasTDnUsMKFEXg2966WawN1C9WYqxK0yMsIY1BvNt?=
 =?us-ascii?Q?bp3a4AyFEQwFDT09UgK6tkK/9IusXhLOIOwvkx16aULdPbTPAEfL6QiQHxCV?=
 =?us-ascii?Q?rqfYq/XmsXXAFpKR7GwMMtGU/szZWj9GQ+AcnFZc30PEuyRvD2cDWPbjFY3e?=
 =?us-ascii?Q?tlaGYcLKRHfl1NfhW0FbKY3V0Ow74qKFddBk2/ihWNI5VHkKKbKTJxrKYa6d?=
 =?us-ascii?Q?eOH0kUGYtN2AXWtNCfiMoAjBPEySaeykfMOprbVvqVAfvnjV3WFUykV7Tyu9?=
 =?us-ascii?Q?VLWcbaj2AE2/PFSBP6rlQ/ASklr4Azz7KkEGH2oei4aUhPILnsIep6R6/VLp?=
 =?us-ascii?Q?MHBGvB4nwgF02QxE56EuKtWXayJfSwYXzMleLqejaEYbi1JpStr71nRI+AiP?=
 =?us-ascii?Q?gXajBWd7pa5Y0O32pFXuS8M1GGIZb7B/jWESs0R0pVUJAb2g7WTYGujmg7hl?=
 =?us-ascii?Q?7RuQ5Fmb/aQgsQhaAYfzY8DxDe9wOiFrkCSpzVvDo2YqY3PbLPxD+t5fC4sG?=
 =?us-ascii?Q?bLwZpHwYwo/3b+RDziuDwu1GRTosMTXauxnfojdXUh1icHMk/+yZXO5G6Fa0?=
 =?us-ascii?Q?KxgsBCAePgTkX5At9jgFghmv+VoWaBdrpzFf5O8cVOs2tt5y2ftBLV+1d8ai?=
 =?us-ascii?Q?CdHQWecFw8mxKy3fIJFwOpmVS2jPvcukZQQ0k0GJUDlv76pzNZ6pE7uMKVb2?=
 =?us-ascii?Q?A4XBSojGGnDczcrI9XxValDC0a6d9m+57PxdzTRK2Ro4OLXv4jP9yuD2Bdu5?=
 =?us-ascii?Q?xVG0OCsJrOnYxMa0kskcbGdtXMPekjoGJPH3ii6hxNdPBFfhUeHAF/gIg68o?=
 =?us-ascii?Q?E1fUWMr7gdgtHtZG3IKK2SmQvPOVNOTWMUznKGblfLQr4NwLepcDTYRouzih?=
 =?us-ascii?Q?zDTO7o+slpUqz/DfOh9x5zhed8E5v95Qk/qkUFS3T2vqsnPdMR8d/x4CRoaO?=
 =?us-ascii?Q?vIcGm8OIRUVRWN7ujiWT4GJEkOiGVwj0z5/Ha5o0djeO4Pk0sHTe81A1X9p9?=
 =?us-ascii?Q?ojPuSySRlhSbGW/sekrTSmKdG6BN4vYCmKw2WJrEnweEMsRUMjhnVqVqCGfv?=
 =?us-ascii?Q?JWlx3p3csuqEp0FgYQlcTXeeEHiLsDPg/OVI8zpJkIE126ElnAJXR3vY1dy2?=
 =?us-ascii?Q?xCHAMX9Pfd9+eHIraWGRWesgGpWo0LdnKcShx4FbxKOuNl+pwCA0+7z2nEJ7?=
 =?us-ascii?Q?Y7LTKsuc/FcdefLxvT9ukEn9LXWEWFks0aNkZKqDXnR4bOtXEUcgywpn1mTd?=
 =?us-ascii?Q?vsC81E1LxBN6aNffG5m4PSF/EbFC82lJ0qe/UfgNd/CuYlAtDsLknT2q5WyQ?=
 =?us-ascii?Q?CEu1aeOCJwVNEXigta2YoEq2JAyEnuBdyidntXzZ1vq0HCNBmGP/4JfpbXAD?=
 =?us-ascii?Q?4HAPWbRLPD4Bcda8vdpQWiJjT0II?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?76V6o3ab5xGlMC0kkCX7AlnfhGMWT1SthSyVOHsTy8zFts7IMRIcgvbKJMTn?=
 =?us-ascii?Q?5dvY8zmj38Ccv1DEu0jpwhjQErYmNWQSKLlFwyYMI2ypvimT61og31k9XGJ4?=
 =?us-ascii?Q?4CXkZzFzcdA3ukcomshB9rO6GoCChfYzXhAcnfPOkfp1o+o64l23fx4lGKwy?=
 =?us-ascii?Q?5uGhQwsVcFaLUx8GXI9MQ5sxyyBcqDRDuKwpqcIDwiNpXlgD5ul66bFxER2Q?=
 =?us-ascii?Q?mK2rwdgrF+xf+qkTTRPEvuYoQGuiMn03QYoWH07BZdzPbqsHNSBt32qRXBKn?=
 =?us-ascii?Q?V62j1K+qPw9w997D9Rf1iaEjhgA/V4c46dEMjCwcStxmyzCsp12s3JQFSLNP?=
 =?us-ascii?Q?gokudAf/bFjKnZowu8rTUjrq8AVS05XGYuB12XKJ1j70aJd8jTOksHsWc9IE?=
 =?us-ascii?Q?ik1zqY1xg+Wb6KHg98htV4gXYjrXOcYQ4KQz+qkBgiPF5wwnADjvNVhRmuqY?=
 =?us-ascii?Q?z8S22KfLIggpFMpvHbjzPvyS8PqQXjUsi6lk5q2p5MbslgkvvqkbkfmaJySx?=
 =?us-ascii?Q?48FquAH2T8ye/uobL2+uTxSd/vmRKYcymlOtUm7SPulnb3oJ9yGQ+28zJVA1?=
 =?us-ascii?Q?wZnZBGOqIRWCXsPmfl2NuoZ4zEd0+8YuBGsl50eRoh5qy7oRLU6Gv0pa3Af7?=
 =?us-ascii?Q?hUVfHolLuEzqJ7jZqvdcBYiLfqXV/ZA7SmNo7hjk1WN6CKz42OR+L1Y8NJyA?=
 =?us-ascii?Q?GioZIx+pvSJCztnwC092UPzZANSYDMNtByPxx10PgUX4aElEDWjoZFH/uITo?=
 =?us-ascii?Q?M5voB03e4SfqR51bpvk8cAPWAN3zzdYXP62sqYBASQKRhSYgDnCwLw9Pi+Gp?=
 =?us-ascii?Q?AnLTNObbK/09R525ntSyEhYF1udb67PICKELUi4/ZvY0NDprGH0/qWXcXRFo?=
 =?us-ascii?Q?OuiHQUiAGmGwUHSY5bTKkuYJFOIqU0PNNQMIr/6UkJ55ck17La5do88vGaKJ?=
 =?us-ascii?Q?lYj51qgCuIed+0r65nnMbCaTw47epS1EyVrtSNajvivEmTlTLUnJKkYEbD2h?=
 =?us-ascii?Q?CZeNe26TMvpnxrBM5dyh98+l3pOfK9icqHO8LQsZpGE6ztuTT9ugklz67i7C?=
 =?us-ascii?Q?hi1mu2qK1d59oUy/ro8MrLtGg4oSmNonuOmPBTr181OrHYoHeqOq9qGEm+pG?=
 =?us-ascii?Q?RzHHrKNuI0SOvIzUhiw6oCJOxvEeOo579FL6R404vMeYdLDu1ck+N2yIKyP/?=
 =?us-ascii?Q?W9sKClECc6x9YIPig+ZSlxGP279sw3fK8K3FjAxftTCpPwRx9z/cpqD8jD24?=
 =?us-ascii?Q?EnPG4U49bQKcv7q6c3gKdb28x08bWuIPRVlzcLHwU9SOvkms66VIeGI5m0hH?=
 =?us-ascii?Q?dn/6GHa2udI4e7Gv1CZVO5hVUZykb+TqO1Vvck+tSs2flVj2Zb7XdV6Iks3K?=
 =?us-ascii?Q?Sxwjl05KeoZNNNp7D1PMfuKhuv/7eCnud7DlPsUIBK1AQAUuiHYkOxbzkYjW?=
 =?us-ascii?Q?XSFAmDEPkP/8np+dNdilQweqsvCtjfnsC8A6lKumV/4IBGLVOHTLkPgo7kT1?=
 =?us-ascii?Q?ru/Yb4+OMSyQus4+2GfzncxfZRyyhEnE7TyWAG/X7Kbwcgb6XuOf0JD6jOyV?=
 =?us-ascii?Q?pwKEETemnoM3efGHB0wQQ1VwsXBKAknpQ4CPpFLC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f0f84a1-1b2e-43a9-26b3-08dc9aacdb94
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 15:37:19.2626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +jq+CqolMdyCM7MilN1ebMlO2KZHTtmPuWex+6m90msux3kRbmSmzi/goCISCXUwCmcAlcV9I5ceWFyNRK95mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8179

IEEE Std 1275-1994 is Inactive-Withdrawn Standard according to
https://standards.ieee.org/ieee/1275/1932/.

"require at least one non-prefetchable memory and One or both of
prefetchable Memory and IO Space may also be provided". But it does not
limit maximum ranges number is 3.

Inscrease maximum to 8 because freescale ls1028 and iMX95 use more than
3 ranges.

Fix below CHECK_DTBS warning.
arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dtb: pcie@1f0000000: ranges: [[2181038080, 1, 4160749568, 1, 4160749568, 0, 1441792], [3254779904, 1, 4162191360, 1, 4162191360, 0, 458752], [2181038080, 1, 4162650112, 1, 4162650112, 0, 131072], [3254779904, 1, 4162781184, 1, 4162781184, 0, 131072], [2181038080, 1, 4162912256, 1, 4162912256, 0, 131072], [3254779904, 1, 4163043328, 1, 4163043328, 0, 131072], [2181038080, 1, 4227858432, 1, 4227858432, 0, 4194304]] is too long

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/pci/host-generic-pci.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/host-generic-pci.yaml b/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
index 3484e0b4b412e..506eed7f6c63d 100644
--- a/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
+++ b/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
@@ -103,7 +103,7 @@ properties:
       definition of non-prefetchable memory. One or both of prefetchable Memory
       and IO Space may also be provided.
     minItems: 1
-    maxItems: 3
+    maxItems: 8
 
   dma-coherent: true
   iommu-map: true
-- 
2.34.1


