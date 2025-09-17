Return-Path: <linux-pci+bounces-36333-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C93E9B7C9FD
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 14:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAF5D1731D4
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 09:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91EF3090CF;
	Wed, 17 Sep 2025 09:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="a6BgjizY"
X-Original-To: linux-pci@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013021.outbound.protection.outlook.com [40.107.159.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1BA302761;
	Wed, 17 Sep 2025 09:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758101904; cv=fail; b=SRcJZpLfxkc+Tk1hZBk7kMkpwifkgAQgdAOY7rZ4P4vucyioOg7UkRHpEE25NXhNpkjJtMFAFMunzWV2zB7oi52vm0j6d5LUkJJa93nCr5lJJloGrQbCyL7TVbClrDR55FbQ4Jot0wzkjceOsBQkis2jq4xocp3Ym0KFOqdCCy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758101904; c=relaxed/simple;
	bh=h76dnce0lfx88aRGW9cL8i+8Vo7cHs0lRNR1mb0Hde4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=dzN8Qdma+bXyXPiyxgmE77LAPRfITFtflpRvbifGTfcGx1Zenv01fKpgPjWnQV+U1QrjF8iaHF30uy8JWti6rd7IDzPer3bOMjJUWANye6ziuQTc7DVe/qm59itJw2lP+/NCiQsyuMMilAUXAEUZn5zlEwpkxc0IEuErXq7lbzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=a6BgjizY; arc=fail smtp.client-ip=40.107.159.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JIhGQp0cyYoy4gm1pSVTy1lWHGsJXc6v867LTSnk+iCOKL9qX0mi78qvwzELgsEOwC21/MPZQWRkNT4/rZcMy+fCOeM38xozTFA4TEZ/bJl2BC44J4teqC4zpcXrVdT6Bm+W98bEJ2es45roDgLfaSjfu/R2zzfaSqElUfzJ4vMNtp7ucUydr559Nr09dp1/qWt08aQhRSP9ucEaN3YlWNDFGn9bGol8Qy6vcG39dBcd9M50CHZBj7ghIc6mqL7TZjmAF9SlcwKT1cerdDwa6zuykWOBQQZuVVFfWbcFYlxw3VFyVlhQfmaiUZTjWbFFiCIS6uRvgPVaZipGOU4q+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJOzMneJ+ZuplbPIph3Nyi96LOwaxZDcygQ2irRnq1c=;
 b=FwZMqaRrkSN5ECkdq7T6ICAnry8ZX4+pmg1jMgzcVJwbNetD0qkjT1fT7qctEtViX0VeDWoncoUQ/KGH+2Y8AJYpT5liMUg+vEtFcikxhaQkek32zMeqWdiHVmJKyOg/+Wt12nuEkPTj1fIRLfqw45gs2ber8RSOD0OREb/SqpB1QWUErtcL4K9iUrhpZuzZ0+u0F1allGdp2rWz7nhQj4z7PLR76FubzjpOn0Vp32G5TMYm5D/Skfu0QH4Ne/aoiA77VZ+alvHRpCBhG51m1ySESB5PyvP7c7s94SVNvkIFTzwjivr8+LY/aP7Layz03xiUlV/h0SS1OwCC4vyLRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJOzMneJ+ZuplbPIph3Nyi96LOwaxZDcygQ2irRnq1c=;
 b=a6BgjizYXgH4L1iwxcR7EsfjnwP0y5FGT3SBw3fofmonItpxL7sIMt7lmx1gGxvq1CACm4YmjlRfysS+524ohgi5poH/QQZdedIcCLDgaBNhTe1hfP1fczmNeWcJmqw29gFdC8pSXdOk2yw0e8vKdjnfw9pMrrS2qxbT3/wegjzgEG07TE92H2A/zrCtZUkpjSLXYyJyn3Xp88kn68aAQ5bXt6Cqhn8lzDsDLv63d5EnLqPPURaKIboH1UuDz2JC5MyJoaFSNmvQLEDoKxET6MwtInSerZW9xmnDs3IskrmBwKFCLo+/dx05XUNdzKlgFRo1a397ygVIdgZHQhtmRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by VI1PR04MB7102.eurprd04.prod.outlook.com (2603:10a6:800:124::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 09:38:17 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%3]) with mapi id 15.20.9137.012; Wed, 17 Sep 2025
 09:38:17 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
	jingoohan1@gmail.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] PCI: imx6: Add a method to handle CLKREQ# override
Date: Wed, 17 Sep 2025 17:37:49 +0800
Message-Id: <20250917093751.1520050-1-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0015.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:179::15) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|VI1PR04MB7102:EE_
X-MS-Office365-Filtering-Correlation-Id: aa05070a-86c7-4294-e021-08ddf5cdee4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|7416014|52116014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TUwlIQmyncjK9hgU+FYAH3gmFN31oigOQ4JD9NzjianiAFoUnnOozZYwvZ9y?=
 =?us-ascii?Q?jSU1zKFvtkt9wvcCE5XWf2paBTvWXEkH2eBAiTdgceL8wpAFRS/ndeAuSj58?=
 =?us-ascii?Q?omwolOkunXQIju5912winrdn2cVODEaqWG+aN8HMikKNeXcUbM+KguQGdjNg?=
 =?us-ascii?Q?k56RDu5/sPGwHQGrNBKZz59e2v4XxLFTJKDtbrrNhhE8RtL/vor6A8E1M5z+?=
 =?us-ascii?Q?RmpHNcLmD1SqH73Ny8il0bF4Dc9kORdVZJOp/klw4qQRZeeIUhkEV70CrdOp?=
 =?us-ascii?Q?ZREZLeZUKWOJtk77H4vrAHIIzkZhBYatqhfWCQdxB4NejvnkOQ4/buYgv3my?=
 =?us-ascii?Q?EzToRDvFjx8p86ijhGeQEmxm6SE4TjmXovkgNSFtatho7KBQYL6CXL3Mc9mj?=
 =?us-ascii?Q?JIXcyqH9h+hS1UQeqZtybcnSJcYyRnvbasccRsdY+Cyb0KEh/OmdOWFmz85v?=
 =?us-ascii?Q?yu0Dh92TWWx/vmRI8eljAmkxDgvpFHQdnSMSXGpilGRNbd+avltt228iO4pm?=
 =?us-ascii?Q?zEdNX2geJLFY+TcUnxGH8gx9hyr9JTmAi/YgXJ1FPQeRG5GdRrh1xfxipgT9?=
 =?us-ascii?Q?nTmr1RyXqBktFoGRBdraBbmCjoHb7dE7Be3o06UUgEqIT9M/nQKzLwcPLHa+?=
 =?us-ascii?Q?tLbZmcziAh22ZzjrQimBAUI/RJfy2w5bj8sQtoj2fz8Y3LR0ghYEpIrCdN0e?=
 =?us-ascii?Q?uLr0qWEmryXnm3I08mGJupaTE+CGCV4QAPxqjqCFDIDm/1Z0sCl5eCjgsSKh?=
 =?us-ascii?Q?t6L5vb2652CDbhYyE9uaeLFnqu6SSnePQmHUhQd3ZfgXhfAb2ZQbzpaBwVFY?=
 =?us-ascii?Q?34fwyVzND174fdV2NlIHAni918dyzFgHA9cbusOFnLSs3ApcHlzADdlwcmYT?=
 =?us-ascii?Q?3x+ZXoW5TaQVFe3NKvwwc3Y/Rstio1y7lD3l47LJeXD3kft+awDacQOBQD9I?=
 =?us-ascii?Q?vO4SezHbTFDJ9dw/Io4aeajn1MmC4OB3VdoKIxIZmiSycDRJ3IeF0Q6xvDbk?=
 =?us-ascii?Q?QG9Avg7o0ewi92cvJ/SMexR/PkEIPnVtwCyF+xM47x3HIcZmNH3Yxow5EmVM?=
 =?us-ascii?Q?JW8NMpP8IGUgqjfBykklWfgIX4FbiOcld0eivHDTECAvoBBLpSBQC+UoV6TY?=
 =?us-ascii?Q?nSKhCrslncjmsydsmyfaBOSy74G1EDPd/VrXsMD59GWke+zGX//bDUEiRk7p?=
 =?us-ascii?Q?rl6X5AWbu4n1u7PgpSsh/FT3cEAJ8voKqG+iUms7FdXuZD7C6e+eaYzVLhRx?=
 =?us-ascii?Q?7Hh+FvLcuhiwbY7/nUdbyUQpy4Dd49HdiRKy61X0j/Uy6IQ7vY5vJ4CaeHYH?=
 =?us-ascii?Q?sDf+WuC5+RjGpBbmeoARYVPAURpJ+t/g2cQPmHVKLaYG/KZ5XqO/4h+7daJW?=
 =?us-ascii?Q?W17iLFGIL97JXH5u5gh7+03dJ0hlHJSAkQLWqaNSGEd/mLJ8jkzSoDXGKbWP?=
 =?us-ascii?Q?jKUtXg/Cx11AP3PIkEFcQ5W6846fePhROcUFn667Rg4lh4hl6SMmF8q3aXFO?=
 =?us-ascii?Q?tKMUIMo3S4ILd2U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(7416014)(52116014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E3CloJYYWveBSZQWDzvwBWYdmwEJjnRUZHx/qPTm3XJe3uv6zxBQRHQwqgZ2?=
 =?us-ascii?Q?FQdYFxeYf0vfuJ6WwC8txfpVpbYQnCEsaIIE4Hji5y2Mx3JX6M15o+85PVge?=
 =?us-ascii?Q?Q2sApB6PrnlGOk6TvyngPSF+4sDY4p7XDbfoO1kHLuZt+RrDNlqQhJ09b8P+?=
 =?us-ascii?Q?xiOGZYhGsE8J3FFoAo6vGCj517rcKBGpk6H7DKvVSoT/pQMhZYjaeEHcLYAg?=
 =?us-ascii?Q?nMYmbmmI5lOFf/EctZtHgep0jBfyW55xmz465hvwq6rbQS53er9uROnEu8ag?=
 =?us-ascii?Q?FbAA7VKg9DEEt+lcJ2uFOtVSBRJndIVjbJ+SPDVpc5QlKuaHwtw0r3oEmKTc?=
 =?us-ascii?Q?pe6IIppMeN3HI7OEdT6Vt7VK6TqKadlCcT1BJE7RUv4d2VksnBbAEnKPwNWj?=
 =?us-ascii?Q?+RFF/V74db6DBf/UBLYi+cguZm3A49kj/cGElIZDPWUaYtquQ/bHCK1u+iIN?=
 =?us-ascii?Q?taVdF+tZ/B7EHKhYBfvkh8h4Rq+/yF8YOGWjr2cvoQUofYah5I9hWNcz+BJ/?=
 =?us-ascii?Q?yi4bMq3wX6E+2IQdtGlttRERWQfBUtnlIj0F3NEDPjnHYV4oMJw5pduBMOcm?=
 =?us-ascii?Q?Qh2Kq2EZqR7DqMpKEz1FpOr3ar+PxzRTThDI6UDJzqUIfYDKH/uOQRG1CBKm?=
 =?us-ascii?Q?7aA8Xy0WjaZPQHMeKzlJsxD/JB4XSymXold0dVrKtHNI+oUL32SOtrEBnY0n?=
 =?us-ascii?Q?gVTVhG2K5Ets1LP60W2s6aGoQ0ZfngrFKdUP0UxMdOKm5dW6yLLdbJSzUS+O?=
 =?us-ascii?Q?9Xx2No7URD21CrPij+mrnGI3u9pTtPY9o2zycDp0l7zEoOPpkq4e66Y35wi0?=
 =?us-ascii?Q?Ig2um7qGqySFzoU7AiDyxGTPfFmbSOOYEEdqM1IUc7jPADvoWCqURO9xQJcI?=
 =?us-ascii?Q?Ko4ZA+bjBnisNRxcvY/KS7wYwOjujQjg9IzO2oRX/pWkxeg/hgFBpEO4IUlD?=
 =?us-ascii?Q?VQpHbLYzd7FIIXJypAvmifyRM67DDHGOJ2qD8IKwNa2rnFVzalHdrrDdSMTH?=
 =?us-ascii?Q?iR89QZqPuM/MBkNIATfftbn/BFs5q1abtUXm5MQSywupGZkUWFW9hur3KrPR?=
 =?us-ascii?Q?GvUh+nJ4uerHhkEh2e7wCTqWhvOQpSjTOFcVkWDXsIHvVTx4ocC82q4gBEog?=
 =?us-ascii?Q?dwP1M3rpJnulgF/TivEZNf8ULu2jAaZ2k0fCWNlK6HG9gt/Y/e/hfhCOjmLr?=
 =?us-ascii?Q?oDqtbddMWVDlnBRiwxorOReAjYZNBLlWY84nbSp+EaruC1wf5dcA4eTltFR8?=
 =?us-ascii?Q?wAsAYA2lXTgVANMVEy/8NanF1qElv9mcE983RrA5GUWWLl3ym4Qr4tK3Q9FT?=
 =?us-ascii?Q?JQ86R8MEZ5MBJJeZexl0wZOxuhdtHwElDl69Xy/6+dLTzXGP/5fH4UR/XWYC?=
 =?us-ascii?Q?nlqMjbHs68TCX948dvYK3njVMmNhwpSFOXhlNv7zEoj2+ubfENX8ruu1pv6M?=
 =?us-ascii?Q?wT38XlGiZNAFnnzdUEwerFcSqh1qqT45EF7Fpr30v2chHvg6g0djY0d1RaHr?=
 =?us-ascii?Q?1LzvRgh1DMJkvxFtvzDpl4cqUk/sH86yzE6JhsEjlEn6kiau4xTsDGcYJBo1?=
 =?us-ascii?Q?1JXf71LJzAmQtVsc3Rj7lIagqzZDh7nFejHEy/Km?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa05070a-86c7-4294-e021-08ddf5cdee4a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 09:38:17.2782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Medwbs7buWQfVBT6xJVb3So/PFj8sUejwcNYZXHAIeJprBx+KKdeaxD1q4a0seZu59UrpVL1SmDFZ685vAdueQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7102

The CLKREQ# is an open drain, active low signal that is driven low by
the card to request reference clock.

But the CLKREQ# maybe reserved on some old device, compliant with CEM
r3.0 or before. Thus, this signal wouldn't be driven low by these old
devices.

Since the reference clock controlled by CLKREQ# may be required by i.MX
PCIe host too. To make sure this clock is ready even when the CLKREQ#
isn't driven low by the card(e.x old cards described above), force
CLKREQ# override active low for i.MX PCIe host during initialization.

The CLKREQ# override can be cleared safely when supports-clkreq is
present and PCIe link is up later. Because the CLKREQ# would be driven
low by the card in this case.

Main changes in v2:
- Update the commit message, and collect the reviewed-by tag.

[PATCH v2 1/2] PCI: dwc: Invoke post_init in dw_pcie_resume_noirq()
[PATCH v2 2/2] PCI: imx6: Add a method to handle CLKREQ# override

drivers/pci/controller/dwc/pci-imx6.c             | 35 +++++++++++++++++++++++++++++++++++
drivers/pci/controller/dwc/pcie-designware-host.c |  3 +++
2 files changed, 38 insertions(+)


