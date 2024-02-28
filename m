Return-Path: <linux-pci+bounces-4200-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C94186B7CF
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 20:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 191131F266E8
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 19:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51C071ECB;
	Wed, 28 Feb 2024 19:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dhro6FdH"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2077.outbound.protection.outlook.com [40.107.8.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BC440843;
	Wed, 28 Feb 2024 19:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709147022; cv=fail; b=Kok7hP0S+aMqGwi3BAQf3YJirXlCTLwF4iadxXUcXUZcxDLgrocA8IG0rYvhjbay3SWF/V+jE+7pddJMBJ/ztrXvOjbb+sy+Fu0o1ublrpWabFPmikakt92drZ0o4pjIVhastSfcJUet1qfAoY9EcVG96PZhIj7UHgVfUcXZ7lI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709147022; c=relaxed/simple;
	bh=1mSQ0qSdbafYDA/kluh9wXcAQuKk/Re/NOPUG4jpsmk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=gsYLsVqlcYweBNzUQORP5i1RR5DnK3FENO9QlSndqyxluwt0ualCI1KBben/VfrsCzA043zE0Yxr4AlRj48DDlE+YKrNCeY/75ZX/nyFEhkFbtecOl3CaDfxjdLO1GsHZUJfwHDKJk58ToGINftFa8Xp/7bkb8yB8Z+2wcBZVYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=dhro6FdH; arc=fail smtp.client-ip=40.107.8.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S8aPCZQEdSfk6Qkbnb6/t5H/ufbfPm4RnmrXMm0u+VFD/oKFjFCnuSNpcT26elnQsvNR09i4Ne80ywOl5QuTyFSshL90MQlDmaRnlsxHyNanupL9iWrchBm5yeP+oCbLv2ujOldcUK03SslfgJkdCKF1TuiPonIiI1275Y2z1qKutNViyxAPda1C48/LnOlD3wcHpqFZPtxmKoH6lKKFhWiiHL8rr5rloSptQF+glQLzVvV9heVOLVTg2U6O4rEnUUCThKOt6kq5Plfjdd9WjzuAakiyOs78ObkHMA/sLahN/RerZ4m7OGMQwF22i885w45MKvewp/Ym3DcT7ffIBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BkdlxnsqUOt42fCfOoakK4R+X04CpK2e17EWNipAHkw=;
 b=XGJbI0FzCkt2pNbyutEVVhm8ebqXX9bgx24aX9M6CKSYW3CEmv7+1+N/4t4fIzzCX7Y68XdKWHe9Xi/i2UYM6Pq8KK+sj+30RQB/oKHJicsBmOE58kT41L+xQ5WXhj9+POWpicWOa5QYUgkDHNg+GSwgclcWrNe68cG4o2+FPIp4p4cGT1STO63xWvRZo2gUwcoxkl1oYfwZh/8djJqrEr7C7AUjOmJ5GyNAtNW3jDkhfPxKzG0zV42C4mnoKUY2/Qj4qP+3ER5lYn7Ey3gpqI6wenD7FEWXeGn7+rrpNvbSkbMy1eu1eCQBR0Vqv2CPWLExYudgBWvXM7s2yQ3u/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BkdlxnsqUOt42fCfOoakK4R+X04CpK2e17EWNipAHkw=;
 b=dhro6FdHlPuBPiRXJN7jwCURlA0wrj8kgxbeAVDWErDwmlXFcr5P88HsCCB/vRXHiz51JbT57itKyQ7GLYlQ0sVZEEemjEM+h1mdpTblIdU7l/KKw3fzSh8tHlDH/CnbNmvfyDwRKclLCGF81Ug99K41YjsneHdD0M0S1TG15sA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8370.eurprd04.prod.outlook.com (2603:10a6:20b:3b1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 19:03:37 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Wed, 28 Feb 2024
 19:03:37 +0000
From: Frank Li <Frank.Li@nxp.com>
To: helgaas@kernel.org
Cc: Frank.Li@nxp.com,
	bhelgaas@google.com,
	conor+dt@kernel.org,
	conor@kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	krzysztof.kozlowski+dt@linaro.org,
	kw@linux.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lpieralisi@kernel.org,
	robh@kernel.org
Subject: [PATCH v5 0/5] dt-bindings: pci: layerscape-pci: Convert to yaml format
Date: Wed, 28 Feb 2024 14:03:16 -0500
Message-Id: <20240228190321.580846-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0165.namprd05.prod.outlook.com
 (2603:10b6:a03:339::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8370:EE_
X-MS-Office365-Filtering-Correlation-Id: 61284c6f-890f-4c28-50c5-08dc388ff83d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	X///cYIqUVvMZtfVN47dqIJDXKZyEBShLmIPMV2m/f/2IBeXqBtnmn9hOrgfrX1efarIhnYBdy+/68uLRk5co0ftsgnsC50Ld1gUloXzxJVhfCZE4HL1Qq3kZY8T84ToKb5bPD2pAN93VXfELwSYjLwQ7TWfBiEjoQ83qOXIW8EInZJIbXnMT2SKgrJz1i5xrvXg3x2GNckltNnL9bMRLs7I6CmMrPnf7yUSR3R6ivvPAoq3VqLALgH1IM0KqRE8Mk5TnhxR32Zy/ZP7Ym2VGcYfSssy4SpV2Ov2t9jpYynIIwx+9b2X3t3xnX33mAdd9dk0w2w+HSqPvyLc5LxHBbHll5+sNxhUh7ob1kJlJHE9WqEQkPDjtntKDNL5QlrWdpUVvaqJQ0leo1hJe9VGMuIt8Cd2PbuPap8nt+txlO6/o6PFSerXqYOkZrzNBqiLbFsldDeqzBR2roYafU3GEC33zOsJn96qvaVvlbT3uBbIMIbFhoMUP0v585qY4l00WRkjY8C9td7YqEIReZbLReFDVO+4mhrPlrvCnIP/bVHVrbQbuGoVcP5dd8SS/SKQTAT4AiewzS2ewmrL3tn61oKEP2ELQ6CXfj8rsMpcAiwrkNqgwy/WOKJ2eGjlALxCaA3NoGjqqoBwrrgqRj9LtOOZ1xFL7d8a3fjJYcShBtBMIfaQQFr1u9yFQlgZLRyng9mLKqH3p8Nxha0O6xXGHS3bygVq9AXJaaLfjp+WG/U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Hf2Nlla4aKr0qaQ4mVq65AYW53cBQYjHNuRbQVf5DzJam3sEPyXMjbyOdfqo?=
 =?us-ascii?Q?N0Qgx52ASJP4EYN8WRFdRocsbz1kC/KlQlFqodHDshzrD7LWdG0F4WusTgzO?=
 =?us-ascii?Q?MGlj5ajm/hXg39CSknXJ1KXvxb7ic1jQQYpbFgAgNJUqBVOd7Bh7PcQZhs/B?=
 =?us-ascii?Q?V3YcefdGYyeniXRN9ZWrbO/CMiBpmbqqlnFeBiGGG+WR8BcHnxaVr3u/eQuk?=
 =?us-ascii?Q?3mWrvkNgA4XcnQFOi4H8W2mzbJWhhWZEQd16+1lHxmPkZR26Imw0sFgDmq92?=
 =?us-ascii?Q?N0SWPAlhYOAGoi5knslYBNuziO5lxVA6/+QxCkSmk4Ye/2Pzlnm8oXcz6ebc?=
 =?us-ascii?Q?jff/c+ZQ33eHOHFuT/qdUBa8cJjuAgIZDvLlgyaSUHlgT6RuXNhlB5ajrLEY?=
 =?us-ascii?Q?cQuCrfvcLdak6pAv44YxKgeHyXdXL8JSqz//DIqnWvD4ZiZWO6432Nwffutw?=
 =?us-ascii?Q?1llzAY5LxKivodoP40U3Ul6Ik+1A/NxOzDYaJAb2uvM0GZsohM59a9ZFUoLS?=
 =?us-ascii?Q?reb/mVgVDUTzdPcZCYW9ve0FjaPPLAaX4fa3UJIYAZshto5Pf7zMDlyQd38+?=
 =?us-ascii?Q?WBhv0Q+GqKUUP4iebSwW8ly8q0A3RwZeGl8WTdlkBGG8BtSVDZTvJ4FA/K8E?=
 =?us-ascii?Q?qK24NPYoA3XbBOBM3PEA7hoa1jp27NkHG+inSNNOCklRQ1ItJn/JgQv4rR5u?=
 =?us-ascii?Q?VXEouv88vKP3os4r6Ld+P/9AqQipVi9J73+19ya93wT9Jx5/aE4S67P1ChUo?=
 =?us-ascii?Q?wv0ALoBs7pv0xqpJKWIL8XufxejBxZpnyv5arKuikTbiYdIcrDacByZLNvRc?=
 =?us-ascii?Q?/Kt85D+Lb8BDhN49xfnuKLDXE4Rcdn/I2Dvw5146oHr6H8LL7Dzuh2F9a60y?=
 =?us-ascii?Q?IbA043afRgQaLymIEkEPhGZQGKpISf3Ji1t7cyfhUZCZ7KT9+apXE3uS8Z/t?=
 =?us-ascii?Q?fbzLdOAoXi5BUaW1Ct4KfSE4Dj2lTAehbAiwMrTyLrDKeeBb5E6veEKyy36x?=
 =?us-ascii?Q?7vlVhrkOEiU8A5EsdsIA9X0nvCPTv4pncBc2XmHis1fxmbYkCY4y0L+wN9F+?=
 =?us-ascii?Q?C5W/13kbgay97Y8A4yrOyxmP3BZzP3gWaXi3Fk0r06U7YxQoVX1BmIiM1JaP?=
 =?us-ascii?Q?K2eiAAuDwvcRSwVh8bue4pdyhFcOnqh2pT7Qtbiu+L9i8/cfMnMHESIovwm9?=
 =?us-ascii?Q?PhAHNawj9hBBcwhxZDmrM4erYzjN+VcnntzdQbJMvm+f7S6R4dFmqWNyX/kV?=
 =?us-ascii?Q?vDrptyS/ruOlg6wJ8oqFc/ToRS3aaQbwAlGVL6tz7an6TJK9adVJSTD/vBaD?=
 =?us-ascii?Q?kh7FQrJObNO8HKHlP4hW2SI6Gfg3jhkLU+bYMzG/e4/k7ONHyOvi5cGIDSu2?=
 =?us-ascii?Q?iTcAiHGHIgMLEMPydDsjLvafvvWq/lNOhbR22GoJCNg2awEskLkRlfvxldz+?=
 =?us-ascii?Q?WHyPG1ruNDWafqV/mXBhSPKSL3N/JBeppzf0jA1GLCX+Q8Khjl52sekjFcMa?=
 =?us-ascii?Q?Nh5/IecvJCAwhya3JCak1rWYWHfJsoNfXvIpeDZEfgQGc8PkCvXl4TYkyCdU?=
 =?us-ascii?Q?NlbGbnWHpabJm2ZdcFo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61284c6f-890f-4c28-50c5-08dc388ff83d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 19:03:37.7646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /fM4kvXAsKPtOTQvLz7Yn5eOv14QFedXfBMlvTUfm2RnPvyRBouD9OKxcL8dLPazX+Jaj7ifaHRStuulFDDr6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8370

Change from
    Change from v4 to v5
    - split 5 patch.
    - create one base patch, which the same as original txt.
    - two patch fix for RC.
    - two patch fix for EP.

    Change from v3 to v4
    - remove ep label
    - remove status="disabled"
    - remove deprecated property
    - fixed irq max-numbers
    - because dts still use "reg" instead "dbi", to avoid dtb check warning,
    not referernece to snps,dwc-pcie yet.

    Change from v2 to v3
    - update commit message, show change compare txt file
    - add failback compatible fsl,ls-pcie-ep.
    - add commit message about 'addr_space' and 'config'.

    Change from v1 to v2
    - remove '|-'
    - dma-coherent: true
    - add interrupts and interrupt-names at before Allof
    - remove ref to snps,pcie*.yaml, some reg-names are not aligned with in
    drivers
    - Add an example for pcie-ep

Frank Li (5):
  dt-bindings: pci: layerscape-pci: Convert to yaml format
  dt-bindings: pci: layerscape-pci: Add snps,dw-pcie.yaml reference
  dt-bindings: pci: layerscape-pci: Remove 'fsl,pcie-scfg' and
    'dma-coherence' from required
  dt-bindings: pci: layerscape-pci-ep: Add snps,dw-pcie-ep.yaml
    reference
  dt-bindings: pci: layerscape-pci-ep: Remove 'fsl,pcie-scfg' and
    'dma-coherence' from required

 .../bindings/pci/fsl,layerscape-pcie-ep.yaml  |  91 +++++++++
 .../bindings/pci/fsl,layerscape-pcie.yaml     | 173 ++++++++++++++++++
 .../bindings/pci/layerscape-pci.txt           |  79 --------
 3 files changed, 264 insertions(+), 79 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/layerscape-pci.txt

-- 
2.34.1


