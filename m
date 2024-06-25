Return-Path: <linux-pci+bounces-9256-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB6491732A
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 23:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D49A0282D3E
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 21:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484FD17E47B;
	Tue, 25 Jun 2024 21:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MlyZ4N0P"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2043.outbound.protection.outlook.com [40.107.104.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E091149003;
	Tue, 25 Jun 2024 21:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719350292; cv=fail; b=nG/cAP7ZZUlIlwlzD9HuGaGsUFO7MY0l4kZtlsVHpCzXyrpXrwz9rxDoI09pVfkoQQR5EWORB4rFe8goPxW7o4nqLiXMNzJP7ghuGNNMhH50jhqB3yRCd/8FqmRekiAOy/KeA114rjYgYifAhXThFQgYUVzBgDlH4vBPJi+Us5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719350292; c=relaxed/simple;
	bh=nCCLwtBYQx3c7UJfcwwMSlH5XTHYyKBA+4kL57jDYtc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=SvuJMNDX8+fdO9sMUkCigAE+7TTgRltVampos1upYuU5uE3iiFrSilLqTjlUNFafpqB2MXV/1iQtKk0pQUdui4mdNGrZ4krqa4/0Z/gsBs16RJ6cs6aYs4RR4g6EDCXbXKlecRHi5HpnmcWIfcHAKbsYrOH4b/a4RyArorlY4qs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=MlyZ4N0P; arc=fail smtp.client-ip=40.107.104.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ixiVYQMh7vTqhqzrhWFMJP42TffWxm45r8RTxK1hIvye/7NGTPVvUvjdHXR2pDeTAcRismzeZbc5icTg5ki6BnJd56Q7sAmJgwLn1V+XUoaZqXikOUQ/KfioSfcXzT36WJeHQCxK38TG4rWNTPVZFRcw3EGIxU7PLvDVap4ddxGX9EOLyfPmu+JjFbVAUfZFz/j2H2rk9+LJ9viON2buJBuV1alAq9E8P2UOcJqSKGF03jo6N6cT0B/Cn70KjRoiW3MOhHr6Jm/JmbYZRSzY0vtkNBTfj1wjvTJLeepR/s1ceefTDVOCIGOGtu/m1S9F3tUzNSLepcmnhjv5G1XNkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZfCc4y7nVpDJAoud6gt1KGOcKHmWc8fhbkc8NFhmcqg=;
 b=Ng6vF7wjZe0xO/5fTuIO8t7r2/HahIvjfGmfXvqb6vngvF6LJWpIh8Lhr17nxrU9mWJl4InbIP5ehRO349BUyt3lP3NMLDjcpkSUzvvKWdQH9LgzRIdV/AHslIYzkR4RaDSzhVCqAb1Ub0sOBnW7c5biqV6XstFbc3bK8+x1pLFv8a6yoiLdFNU+UMxGLr0Ep94Z+hl7RTnAWg43uEjYkrygBYv8LaspbihMwdPcigfafH8O2oPB8Xoo6lxi3oabGv/KOk5JTHm+RR5vH2bukyh0o+eB+4o9IF4WjoxFzZeDIrd1X/7IXPHgpeGXTfYb3SgAKAMlymPsMHnpeyMn8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZfCc4y7nVpDJAoud6gt1KGOcKHmWc8fhbkc8NFhmcqg=;
 b=MlyZ4N0PROEL7wErupSKeuDCkW3mld9NucxC95a6VmYBimHqgJE9PV3GJHIbJkbQA2YHCqzZ3eJwTKJz/fChER4YKtnbO6YLCSbgU5I/BzveVinxKrLEO50cmyw+FKcQnZ1PDgER+gbOJivRFSWoyIM4v2D40QKr77Mc8MR19bI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7978.eurprd04.prod.outlook.com (2603:10a6:10:1e9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 21:18:04 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 21:18:04 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/2] dt-bindings: PCI: layerscape-pci: Fix property 'fsl,pcie-scfg' type
Date: Tue, 25 Jun 2024 17:17:46 -0400
Message-Id: <20240625211748.4041882-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0089.namprd05.prod.outlook.com
 (2603:10b6:a03:332::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7978:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b1e956d-acc2-447e-d005-08dc955c4cc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|1800799022|366014|7416012|376012|52116012|38350700012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gV4yu7qF/KQ1FG36klpkqUO/TjmsKu7lmkEThSZ+ddDRHCNAaXU1drrhYmff?=
 =?us-ascii?Q?1x9q8VYv6amcGI5FJYKCZnzap8k2T9Su38QtzR3yYim6P3jh78xAA5efF+SF?=
 =?us-ascii?Q?gE0c1zvUQ8kvNq/720Vj8VTeO6sNags6EeIVax65YB//BvoiYKIfT8kC0nvX?=
 =?us-ascii?Q?sp9wnUQlUvAreaPdxYsD8TGK3L4CGBKNjI7cn/PiSaoPWOEGYdwlsBEX4hWr?=
 =?us-ascii?Q?y8WuTSA27EzL6MtPAtiGNNMLvGQnArPIY5RLug6qja39jBwvnVlYbaUGYhsL?=
 =?us-ascii?Q?x9pjs2GWp78u0BHHkqiwn8nymUvWZ8aTU8quxyxDUA4tbJCNCdx8cICh/SS4?=
 =?us-ascii?Q?N/CMLbouOggpK9r6zSQe+DPYS3DtmpKO8nQEuvn4UBELVEPyTG2nmACPzolN?=
 =?us-ascii?Q?gGIDYuLCQ91MTTMerNobmv8jM8Wv2C9y9vUj0CRaCWNR3uL1PdRawMXDLbgd?=
 =?us-ascii?Q?3XXqxL54qPGxcNn+gOTkd1Q6w3cKicQ0JtQ4uNbK2msjtmBDuQ/XyNsvmAZQ?=
 =?us-ascii?Q?uvoWi90OfcBtOnfPG/BYlCeeW7Ov9IykC8WCUWP0RWi2PbtNJ7oxqwC2GicW?=
 =?us-ascii?Q?H21dYomVUbJHgT3/+8FyMItjl7XABzQuB4YuKfe3kY/RIWIU18iLK4902fMh?=
 =?us-ascii?Q?r1K0VqzmCrJVUJWVVNilp4Utd0sbM5jAyojWHdI5gwmxW/oh1QfbnZtypEac?=
 =?us-ascii?Q?10CbXgOdCkTWdcs7GNBX1bnOIViiHa4nQsWOhSaNUTuj8naA4scZZeKxVUO1?=
 =?us-ascii?Q?RKQUXUp49xyJXZlBuW3E2pj3ebKrHuAifXsnfMoc6Eukp8GpyDt8/zGqTZEW?=
 =?us-ascii?Q?a7ETDFhUGo1VB0LUWQOqScNIcX0lD+iTD6Na3d88EPGq0H8uwkdNSH0sw/rX?=
 =?us-ascii?Q?o8MLVuUS+aAIFhvkzrJButdfePw4MdHr9U9mllJc+CwfHGl9BGRd4k34qCUN?=
 =?us-ascii?Q?gFgrMYUUWd3cNxEt03KAryZLR+ApxzLeEvDdPwyo6mgP5eVZn/VJ2GoYvycV?=
 =?us-ascii?Q?6HhDzqKViNgw2dA1wq86YP4ZZOcz/P9GuJiwj/pTgHYJMX1YwaPYV9M6cMvF?=
 =?us-ascii?Q?nKjScsYSq27yjM0SSX5RsD82S/iuoi7XEiXRNUjBj9viw2cXqOVaiYl//qSH?=
 =?us-ascii?Q?v4wLv20U58uBNXBuG4JPGqq4JB6nqf9A9linO60kqilRtMJ57PLLDX3kQY0U?=
 =?us-ascii?Q?lORpJersNSjyeE125sdWNOLaLTIiM5maAbCey/qnmmgDQqZeuQVX6aT5Sc1h?=
 =?us-ascii?Q?B59Q7sTc/PkAbcQehbsBHrCWcgKi8s6/0u8pVMXEgGHHUS4ymd50IAFo+TUi?=
 =?us-ascii?Q?EoNbWy6D4o3o815aNAkRcXa540fQwFhqJslmRghD1GDNgttFWp35KqP1LZix?=
 =?us-ascii?Q?xE3wUBs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(1800799022)(366014)(7416012)(376012)(52116012)(38350700012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VACKRL2YQB/WCh54g0+eL4cEFuvQBoIw2Qvl66NIsOjIJ7wa2J4dd1Y4h11w?=
 =?us-ascii?Q?vGJBjNaL0g8LexHqZqAR4ZKfYH/RWcQJ2J2jXP8upSZZNMte15Bz5IdlJoPA?=
 =?us-ascii?Q?7aan8eDcCycBbt86+h2yHTJ7UXPOM0oUxKTpxNQ2+vebMjqcfWINfGo6mXr3?=
 =?us-ascii?Q?x0HyGjjyth39cQf/pA5au6UI4xK9PG+HV88Lz3MSfYh+lwqA3HozwLIil2MO?=
 =?us-ascii?Q?AoTb9NaLBCnnM1hBENw+fGTdDJWW57g+hf4Vn0l3iFp0gw0VMLxTiq+m0Gs2?=
 =?us-ascii?Q?tai+4/LGrX2U0QTmnlc/5shAhuEp+BZvuxKmTh++C9DfdRaFcnq4x4rwhYxf?=
 =?us-ascii?Q?Hyk7+USKsb73BayKe0mv4MwsaELuJkMs8IVLJidsE+4RS2HGZtZs7sNLVrb3?=
 =?us-ascii?Q?IXXW6X89Cl/h2gg/R+5Odc+RyiB8VDwCDaCNR48ID8m3SSITKs+ULB0m247u?=
 =?us-ascii?Q?6zyHIfGXesK0Nz2ya0Nj0dYuslZR57FCOWfrEKQ+XvOh+JGcEdOEMYacMR3E?=
 =?us-ascii?Q?z2yI6KZ/ItaT1fPiPTSaQB6DQI/ismSA7AJylXjbWdoUuJm8PXg5IJxQFhV1?=
 =?us-ascii?Q?fwBmqEyb/2ggyoLemqvOQF9SluJ8xCvK0lEwJGXGlNmlBopT7Z7qgW25gvrd?=
 =?us-ascii?Q?nmyLH5nATqDGWzxLULgXq0GzpCvs2crWd+MdIcHZ190hXhsZ1aNMCKc0LJz6?=
 =?us-ascii?Q?1OIn/Cz3vT2/Oq2Vsu5ajhqBw9m4NmqMGbpVAqyIQTp4oJVwtOShjyXChrW4?=
 =?us-ascii?Q?Hq0ftFLK8tYVBn5wDHFQ7OvDRS9SdmBkDydjmFUVwT/7tlD/6vyDgGiVh9Ge?=
 =?us-ascii?Q?rq2ojkj80t+3PeydFNa4TGozYNLyqQ8zAyJtbuTluSW4W5ALkdjNcqY/feo9?=
 =?us-ascii?Q?7x0AIrzqKbetvqNAwp12SDNATTxe/PtHveUuGLgrPPjtDOk6tL0/7DnxE8iT?=
 =?us-ascii?Q?phquLPnTbV2qow10dAmvjFDPV6IKLZLzRWs7Km78BD94xL8O2PNqia77tWn1?=
 =?us-ascii?Q?xVcfeOnMeOCwMRB6hrbKnqDtdLp9dXNlJmfNE8X62gHc6SRPU1Ecxs3bkq87?=
 =?us-ascii?Q?UtLws/ttBT6xpAPGKo7upa08G0pNn2HvEa+m8T4hpjYsYa1aVmh4T1Q0rbE9?=
 =?us-ascii?Q?nxSN94TkEwJ04mapXJ/HlvrB50GZwXSd9Ypbo0cL6IAI075Z+G1oQHcxEJkf?=
 =?us-ascii?Q?8SvYbatTqwesBcOyLUN+3SjosVSeS8QhIc7LkCt5ffHTanzn76QA8/Kl4+7E?=
 =?us-ascii?Q?PUCV5y72mExPIju0TnXPezsUkWKj98YjS9qDpqjLVgX2m878Esz8PvTrFUXa?=
 =?us-ascii?Q?Qb3vUjacBixh8MvJwmAycgxbgt0BpMHtagBzaF0UXnK1CftYUrv0e21+N21H?=
 =?us-ascii?Q?7TUOOBmLY4lLn98okUEMhJ4FIjJgRqI/NJAsGMVIoFjghxE5kHbXMKK4o4KQ?=
 =?us-ascii?Q?FLAOHlVyfwq1xJHncAEGHSI49TpsmCnmQ8vSfQ/NSkQ1kC7BEJEbyaNYPNgU?=
 =?us-ascii?Q?W8braXwRvXGTKT967ZONRd/U6zKBWiSNfJ8cy3xmf6Ax6e7ozRhVhVF9hTtk?=
 =?us-ascii?Q?pp6C2VnGZM3ng6dx4IT34orBd3nJSPpSKQwpB5KW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b1e956d-acc2-447e-d005-08dc955c4cc0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 21:18:03.9843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x5zjTtnOi6HDI8nJe1uC5d+bRwlVs9GA6pwRfegyTTZ61bhk4fb7Qku8MyLHwGhxSG64I+GkezpsqL0pVCob1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7978

fsl,pcie-scfg actually need an argument when there are more than one PCIe
instances. Change it to phandle-array and use items to descript each field
means.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../devicetree/bindings/pci/fsl,layerscape-pcie.yaml      | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
index 793986c5af7ff..679c2989de7a2 100644
--- a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
@@ -43,10 +43,16 @@ properties:
       - const: config
 
   fsl,pcie-scfg:
-    $ref: /schemas/types.yaml#/definitions/phandle
+    $ref: /schemas/types.yaml#/definitions/phandle-array
     description: A phandle to the SCFG device node. The second entry is the
       physical PCIe controller index starting from '0'. This is used to get
       SCFG PEXN registers.
+    items:
+      items:
+        - description: A phandle to the SCFG device node
+        - description: PCIe controller index starting from '0'
+      minItems: 1
+    maxItems: 1
 
   big-endian:
     $ref: /schemas/types.yaml#/definitions/flag
-- 
2.34.1


