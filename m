Return-Path: <linux-pci+bounces-14953-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF459A9095
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2024 22:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 799F51F22B58
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2024 20:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60431DC753;
	Mon, 21 Oct 2024 20:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="k8btsaze"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2074.outbound.protection.outlook.com [40.107.21.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7089A1EEE0;
	Mon, 21 Oct 2024 20:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729541273; cv=fail; b=L2Cqp1Oi0M7MC+TfcVBId6B/qq8fwD/lxFPNi7Ac8qRJoNY8mgpaVLCP+1BTHHyLsgh7aoaoFlPTOb/BjViLRenzxTkolJh25rnUCla+MiAyT5xonK8Hp/Hr9SRht9pTNlnB8YLJUo+puN+pM5i1bqXluAuoAoxahKhhIDcxCjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729541273; c=relaxed/simple;
	bh=nxmlKKktgJQuKvwhQMNqP2zCjka70p3RF9P2ZtAYFnU=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=lXzLp3EuDWrDAC0pLqfZKsBiBFL/Jhtk/0hKgjUE3dx/GX7fD48kBBNZDJPOEhEjnEmaoHNx6o7MOvwpwbWuxuTE3pI9GkdWmPKoXXV7HRDm8ZYAkkJ8yWPlMiuuO1yLLmxaoBthr2cUP6XaCr78ZKPv8tsTsg6jz1lmAet3xho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=k8btsaze; arc=fail smtp.client-ip=40.107.21.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W9SiqD4KpS6u8cbND6qNT+cXpEUz2EdSy9+xjK1VvCiXkPudWt36Xf4Frner5kW3gjc/cbnxJwE8ScS6jjkhVW7UbuquBgVDnE6OBZLT/NEihz8zzqIezu0h9fos0SAutnPAFc6ASqBsLilo9oqQqiHvqNM86s3JDWR1h+BtyS+qvHPL53artK2IsZxkj4fC63FQKS67hpuQRyyM51JjYYM+TWG+ehUzF4lOX9FBEB74f0+nrzdpCpTSqWd1sUOF4SMdTkD6xFT+6+oGx6qX54tDBvjMgGDl/9X7c3Itz2IaLA0v4uls93i5DlvOR+kroNz18rDWe403N9LI89RXUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5fEWc7NTQ8dD78qg8+4JleeTiPSVRqxVRC7mZeXjLbM=;
 b=t9pYo3w6wdAiaERytpe8r4Q/vgLPLVt5rkvTo8Lbtdi5ZN0Nnm4n7Z+6+UrKXuINPLg00PxKw2w1glmKP8HqEZWZfokw7mx94+g58G9hpNbTro57r4MhHrmKhTU841tnPgtmCth7ICRgXahTANqCEygAoYFXCSsVVAjbSzaSEm8W0NCepGr1JBxgfstF9uPlJQ6ltVbO5WJjJWuVp70Y6JIg+XRGHfrz+Yifc8AM6pxHqtdfgsltFA7Hi2iIeYCV96TEamBX6KaHtNPNy9noihBCet26j/9DbJe2M3qcGRAFkI1nl5sYC/TKSoYuXyjFSzJJcLR4Gc3NxiJ4gGEk2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5fEWc7NTQ8dD78qg8+4JleeTiPSVRqxVRC7mZeXjLbM=;
 b=k8btsazeaBBkMEwWmG4E6FUrbw3+BsOvEd0SOW56JWsfoMzUCyVubTdKbVYJ5tkqkuJr4e9REbEUXCRGSorF3mTJRedNwqeYib9CmfZDGiGML+pCCmMPEZ8XDICZukd0/MRhUj4f2KlwXwM0N8IhZXHmtENQwzpzB/cdh1kFy/E6acyjNGEpt5GgWTeiFMWFJdf5rQgjLyZQe+Vtl/NVzR4Qkj/8CLCTusDfXs8kP+6dqOqZAm9qC7nqeOSnRtWsUeZFAg92aKx2m+ntam7dV9lqrY3WW9TmLNvRJSAynkMhCxb4FgTMVZK2jLy3yKLl13XSHSg1z1pc0imRaKqwvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM0PR04MB6882.eurprd04.prod.outlook.com (2603:10a6:208:184::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 20:07:48 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.024; Mon, 21 Oct 2024
 20:07:48 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v3 0/4] PCI: ep: dwc/imx6: Add bus address support for PCI
 endpoint devices
Date: Mon, 21 Oct 2024 16:07:35 -0400
Message-Id: <20241021-pcie_ep_range-v3-0-b13526eb0089@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAIe0FmcC/12MwQ6CMBAFf8Xs2Zp2W4R68j+MIdAu0oPQtKbBE
 P7dQmI0HOe9zMwQKTiKcDnMECi56MYhgzwewPTN8CDmbGZAjoprUTFvHNXk67CdyhSmIMk5CQ3
 Z8YE6N2292z1z7+JrDO8tn8S6fkt6V0qCcdZK0vaMZcXb8jpM/mTGJ6ydhH8uyr2L2S0ri9Qoq
 azufu6yLB9UH+Pj5AAAAA==
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Abraham I <kishon@kernel.org>, 
 Saravana Kannan <saravanak@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
 Jesper Nilsson <jesper.nilsson@axis.com>, 
 Richard Zhu <hongxing.zhu@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@axis.com, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>, Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729541264; l=5759;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=nxmlKKktgJQuKvwhQMNqP2zCjka70p3RF9P2ZtAYFnU=;
 b=TfAhvijDd13TZFdtLAmTEPL9XotdYEeQqbCIJGbPJDj5p1m+7EMa0kEmjnj0z0Z9TVAMK5+64
 RjOc4H7rUIWC4UV6bU5yXYd84l02QOUEXOKMV6wc8mznR82khJLVwXo
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA9PR13CA0071.namprd13.prod.outlook.com
 (2603:10b6:806:23::16) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM0PR04MB6882:EE_
X-MS-Office365-Filtering-Correlation-Id: 13fbbabc-01f2-4e17-4095-08dcf20c08c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YlNPOHd1cHJNNTMyU0dIWWwwd1k2ZkJ5R0g0NVRqQUZSdVIzYVVsUHJPRWQ4?=
 =?utf-8?B?bTMwZHpYT0hCSlF4NkdRMEc2bi9jT3BYZnl1aDM3RkhLODBqZDc0TVZBdC9X?=
 =?utf-8?B?M1hOWVNBYzlHUFJqbU82NGhuamQyRTlqSWsxTWZaMnRTY0VRS1c1dmxILzhK?=
 =?utf-8?B?bUxZTmhNS0JScHpsemtJYjJHOTFWZkpmb2U5L0pWVUltdGVSMFdzK2dPVjkx?=
 =?utf-8?B?VEZ2YzRMY05GcUFyZXdNVTJQbk9KZmFTWVFCSUtoRWM0aUxTekJZRUpNY08w?=
 =?utf-8?B?UlB4NHlkaytDK3JwUENFZkxSZGV6dUUwSGNQdVFKVjRNRnB3Y0hTQ1VmY0ow?=
 =?utf-8?B?anRMaUpaa3Zib3lScldhTStIaEdiUENHRnE0bGx5T0dJb3pFcFlwdE5SdEJW?=
 =?utf-8?B?QTMyZklMc1FnVkoreU5HN2hYVmtSVTFZeXAzWkE0QlJjYVZZaHhBMHluU25s?=
 =?utf-8?B?Qk1yV0R6QXI1M2VCdytvTm1HeCtDbnVpaXptS0xIZXJHMzRkdlJseHNQS09Z?=
 =?utf-8?B?Qm1CelA0U1BTZk1aT2F6VThuNTBDZ3JlUTBISEFucVdXWkFsU1RJNzRkR2Fw?=
 =?utf-8?B?NkFQWVFpdkRpQ2kwVXFva0ZhcTIrQ2JaMFBUcm84ZW1hcmJCaUFtenBuSWZZ?=
 =?utf-8?B?dk13NE9xWEdPcUFOaDk3OWErZU0xZTUrczJyUEZmWkd3VGhjTW80UkVXTFAw?=
 =?utf-8?B?VnpGYmxlYXVjcDAxYkN4UW5DT0NzaUd6SlZPdWpnY3c4N2R1aXlWUUZNVGEr?=
 =?utf-8?B?cEtoRjZuR1VKd29LbTNtYXRFUzBsYzV6TVJzTWhPK2pKaEl6QTVJbDZLOWNn?=
 =?utf-8?B?TGZqMW94VEk0WGhmb1I2dU13V05IdC8xdTdsMzZnUXBDUElCRmRhT2plTGha?=
 =?utf-8?B?K21ZS0FiWG9VbnhDY1VZOTZoTFJpUGp4UFM1bzg0T2Fvcm40SjU5d1ZndWVy?=
 =?utf-8?B?S0V4aW5aQldSeHBMV2pKTUdtNW9PblVJcXBkdVZscVZOaWduUGpNazRLdXFV?=
 =?utf-8?B?UEJQOURlYWJhOFJZZVpFczFkZkJJQU1Hb2VBRU9TeXFtenpnaEhsdjdPN3pH?=
 =?utf-8?B?Y1diWlpoS1N5UUpXQlBpeUU4TEVuR0ZlMG9zb2pkcEwyZnhhWk0wMHlwTEV6?=
 =?utf-8?B?YjR4V3NxdmRMV0pQTVdSeFliNzJCZjZPSG9zS0xyc0dJcWh1MzZtT0txLzQ0?=
 =?utf-8?B?VGhORjRFUTJMSkczZnprSXNGN211WHdkdTlnRlJ0RzY3UTllbWlyQnFUcEo0?=
 =?utf-8?B?Z3VGVzI1dFA2T2hyaXVCOW9tNkFJMFNsMllIOTVyTW1HMCs1MXdHVEM4K3dG?=
 =?utf-8?B?QlpwUGxKS0tHQjY1U1Q1OFpoK08xOVBrM1RsOThrc0FNMVFXQ1hjM0dqZjZa?=
 =?utf-8?B?eHFJdkxpWjhpVElZekVneHhmUmlIMEdSLzhSY3h3ZGFoWFN5b1QxdEduT2Zt?=
 =?utf-8?B?RkU0NXd0Y1JDZmxIdzhpdDlXS2V1b3JCT2dOTklUUE5XMVh0aHg0TXg1bHF3?=
 =?utf-8?B?dDk5dnVOclUrRlRQTzFOMXhycFgyWHROZDBqSzBkYWtKNjR0Y1M2SUJUNzVn?=
 =?utf-8?B?QngwN3k5dGlsNGpTZzVIcXNwWHBNd3g4ZEllanhHY0V4dlE3c1c4WXZDcGlK?=
 =?utf-8?B?Y2lqbXBTNEVCdEhCRjFPTnA3blNNbEJmR0V0QmRHVWtabWRlc0Zya3dHd05R?=
 =?utf-8?B?K2s5WGswLzBOWUtOb2hLSDdWdXF6L0M5b0IwNXhKMVZoZ2lka1Jta1ZtRnpR?=
 =?utf-8?B?dS9KSUVWVm1Ob3lTLzlsa2VpQ0VORkZCdUlES0xjS2t0NU12Z01aeDdmbmJ1?=
 =?utf-8?B?RHFldFV6dXBQcDJGdTk1NzViY0ZkaGZWaG10aWV6VVk0d1RONVViaHlqbXdH?=
 =?utf-8?Q?TE5dCZblFp2/L?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SFlFVFVDcHIyaGJ4SjRDNkhKVExWTkJObXorRHlTY3I5MTF5NUkvMWNjbjRk?=
 =?utf-8?B?M0pldm1Ha1Z3WXVZSW5XOXpTSlczVmtla2Jhc2dEUXZaZlJSdlJJZXNkcHlO?=
 =?utf-8?B?K1g0VGZOUTRzWWRCOG9ITjlVN2FIWW9MV0U5Wm9UMjBNdXhLaGt4RmlXeVR1?=
 =?utf-8?B?eWpkNCtQamFTWGZubDUvMkc5NUxsZHFMK3VieXVFUmF6enQxSVFUdEd4NTdF?=
 =?utf-8?B?Yk95R05UZWlCZm1vdEhKdkZxQ28xbzFMblQ2QUoveFUrSnJZdjJZK3JuOU9a?=
 =?utf-8?B?dU80ZFNQSnJiMjh5cllRL2diOCtUNnNFMVd3NGhHaUVicEh4SmxYV1BEWFdK?=
 =?utf-8?B?VCtkbXh4M1hFM0Yrbkt5QXVodnFva1c3VjF5UHNabG56K0FmTVhSSURWMHB3?=
 =?utf-8?B?RGYrcmxPWDZZak9oR2owUndlaUFnYUhWRzRHbVJsM2ZyVmtPODJqOWdnU2VN?=
 =?utf-8?B?TnNHVmZsRW1lUnl4Z3NsU2VtMmg5VHRzaW9oelZuNmZKVmlseEtZeW1QNzFJ?=
 =?utf-8?B?SXp0elF4ZVN2cS9KKzk1Tmg0SnBaRkRobVBXVWhJZlRnVzNHMkEvRkdsL3pm?=
 =?utf-8?B?bFRaWXpyVi9DZ29adXZnQ1hGT0dBbU1lMXpWR2FUektNL1M1WnRwNWd5eXNu?=
 =?utf-8?B?TjhKbEpwbmRYWWd2Y0V1NjhIMGcvM1MyYUp6aVAwWjIvcHMrZ0pmb1FrdXJk?=
 =?utf-8?B?a04wTTVCT1VadHdCblNzMFJVMnY4MytRaE5iMm9tSlVyNTFUMHNwQjd4a3FL?=
 =?utf-8?B?Qy92eUJBdXdLbU5DdVFPK1MvQkpHUnozaERtNkdkUXh4Q0tkNUdKaEZjOFZp?=
 =?utf-8?B?UjgwUWgvdFhyYjNkU1RSWEhtKy9vRU5DalpiN0Q2bWZJZ3FWN20zTFBDQVhv?=
 =?utf-8?B?Q2FtMzk3ZEVFeDNaSk1JYTRVRUtEYjAyWW4wT3NDYkMxYk5OMnk0U2k4d01r?=
 =?utf-8?B?d2JEUDlDeE1va3hzKzNLZlMxRmtPMUU0MStKZEs3NEtyTTJyamhIaTV0Z3Zl?=
 =?utf-8?B?RmZ5NGh5aVl4c0hLQnY0TVFwQWdobGhtMmhuTGxZRWlyc3dGaklqYVM1akh1?=
 =?utf-8?B?Ui8wazRpZFBLY1NOeFdYVW1qdm1tWitncm5MVThhWk5Fb29rQmNSK2dkMjZ1?=
 =?utf-8?B?aEx6UDlkZ1FQU0ZJYVROeFNramJSRkgvOFVkOC9DWDExclhWL0dsOUd6c1A0?=
 =?utf-8?B?OUlqRWpoYmRVd2tIM0xDdXdlN2V1dTNMM1hIMU4wTWlsUmQ0TDUwZktWdzY0?=
 =?utf-8?B?NC8xMkhSOG1pNHZyUUhqaXZOcEQ2ZjJyby8zdFE0aWF2a21FTmJUeVUrNTQ4?=
 =?utf-8?B?eU02L2RDNnVLM3JwT09kM1IzcFRQQXAxNEpNNXBGS01WUnFTRmpwVTNwN1p5?=
 =?utf-8?B?dVg4blQ4MU5XcEdiZ0xhaU5qWFAvdFZKTHF4RHVOeTZYamRyaEJ0RlVDV1Yy?=
 =?utf-8?B?bkg1WGExR1U4c01DalFjcEJIaWIzR3BaWklwbVc0bGFkWXdVTU1LVlJPRFRW?=
 =?utf-8?B?Rk5URzBSdlM2bHNBYVhjL0pLcFJrOTBxL3g4dlQ5a2M2QUlBblJGZm9maGxq?=
 =?utf-8?B?OVFwR3NnVk1qUEo5dUNzdVUybjdMWVhUK29qdlJGNFRaZ1BzWk5PZzhqckdO?=
 =?utf-8?B?Rm5kc0I1N1N3K3NyODZnMEZLRFdmZXBDWjZuWUsrajdJRURwZzVvTnRCMENH?=
 =?utf-8?B?UmVueEphcU5hZDNYOTEvZ0QzYnZZenp5TWxvTWdZVVNQS2sxNEJFMzRHcVcz?=
 =?utf-8?B?NWc3SHZ4eWZuODlyd3p0U25WdWxSVmRobmZuU2JqRFNzK0ZzbE5iTEpkQy96?=
 =?utf-8?B?WFlCK2U3ZE1IaUlCNzJxWVRNWDQyeVlDQ0QyL3NTOXRLTG1nZnZ0cXpWbCtP?=
 =?utf-8?B?enZsVE5ibHE3MXU4ZldvZDNueTNSa1ZHdWpYbFVISUpoNko2K0oyZlhqd0ow?=
 =?utf-8?B?STF0NnYvQzBnNHQ0allRbkk4dnpTR0I3a2xrTEdsR0V6UnhHOEQxSit6WkFL?=
 =?utf-8?B?QWRLZDZtclE5ZnEvMWFIeWtyVG8ydURsNWF3RkV4Y2FzVTIza011c24xQnM5?=
 =?utf-8?B?OGFiTEVybTdiLzBYdzlsZ0Q1Y0FzZDlEaUIvajFVK0lrVW4xUXcyb2p0M28r?=
 =?utf-8?Q?IcVEUp5KXwudRiygg92yrMWmL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13fbbabc-01f2-4e17-4095-08dcf20c08c6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 20:07:48.1283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JAnHow/gq7pUyiFfsM2ChcQKvsCkGhBlwwTPBUmbTl7/PPa+2VmPB8G9lGPfwBd82PmXKjlUfcCva2oBGUGEnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6882

Endpoint          Root complex
                             ┌───────┐        ┌─────────┐
               ┌─────┐       │ EP    │        │         │      ┌─────┐
               │     │       │ Ctrl  │        │         │      │ CPU │
               │ DDR │       │       │        │ ┌────┐  │      └──┬──┘
               │     │◄──────┼─ATU ◄─┼────────┼─┤BarN│◄─┼─────────┘
               │     │       │       │        │ └────┘  │ Outbound Transfer
               └─────┘       │       │        │         │
                             │       │        │         │
                             │       │        │         │
                             │       │        │         │ Inbound Transfer
                             │       │        │         │      ┌──▼──┐
              ┌───────┐      │       │        │ ┌───────┼─────►│DDR  │
              │       │ outbound Transfer*    │ │       │      └─────┘
   ┌─────┐    │ Bus   ┼─────►│ ATU  ─┬────────┼─┘       │
   │     │    │ Fabric│Bus   │       │ PCI Addr         │
   │ CPU ├───►│       │Addr  │       │ 0xA000_0000      │
   │     │CPU │       │0x8000_0000   │        │         │
   └─────┘Addr└───────┘      │       │        │         │
          0x7000_0000        └───────┘        └─────────┘

Add `bus_addr_base` to configure the outbound window address for CPU write.
The BUS fabric generally passes the same address to the PCIe EP controller,
but some BUS fabrics convert the address before sending it to the PCIe EP
controller.

Above diagram, CPU write data to outbound windows address 0x7000_0000,
Bus fabric convert it to 0x8000_0000. ATU should use BUS address
0x8000_0000 as input address and convert to PCI address 0xA000_0000.

Previously, `cpu_addr_fixup()` was used to handle address conversion. Now,
the device tree provides this information, preferring a common method.

bus@5f000000 {
	compatible = "simple-bus";
	ranges = <0x80000000 0x0 0x70000000 0x10000000>;

	pcie-ep@5f010000 {
		reg = <0x5f010000 0x00010000>,
		      <0x80000000 0x10000000>;
		reg-names = "dbi", "addr_space";
		...
	};
	...
};

'ranges' in bus@5f000000 descript how address convert from CPU address
to BUS address.

Use `of_property_read_reg()` to obtain the BUS address and set it to the
ATU correctly, eliminating the need for vendor-specific cpu_addr_fixup().

The 1st patch implement above method in dwc common driver.
The 2nd patch update imx6's binding doc to add fsl,imx8q-pcie-ep.
The 3rd patch fix a pci-mx6's a bug
The 4th patch enable pci ep function.

The imx8q's dts is usptreaming, the pcie-ep part is below.

hsio_subsys: bus@5f000000 {
        compatible = "simple-bus";
        #address-cells = <1>;
        #size-cells = <1>;
        /* Only supports up to 32bits DMA, map all possible DDR as inbound ranges */
        dma-ranges = <0x80000000 0 0x80000000 0x80000000>;
        ranges = <0x5f000000 0x0 0x5f000000 0x01000000>,
                 <0x80000000 0x0 0x70000000 0x10000000>;

	pcieb_ep: pcie-ep@5f010000 {
                compatible = "fsl,imx8q-pcie-ep";
                reg = <0x5f010000 0x00010000>,
                      <0x80000000 0x10000000>;
                reg-names = "dbi", "addr_space";
                num-lanes = <1>;
                interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
                interrupt-names = "dma";
                clocks = <&pcieb_lpcg IMX_LPCG_CLK_6>,
                         <&pcieb_lpcg IMX_LPCG_CLK_4>,
                         <&pcieb_lpcg IMX_LPCG_CLK_5>;
                clock-names = "dbi", "mstr", "slv";
                power-domains = <&pd IMX_SC_R_PCIE_B>;
                fsl,max-link-speed = <3>;
                num-ib-windows = <6>;
                num-ob-windows = <6>;
        };
};

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v3:
- Add mani' review tag for patch 3,4
- Add varible using_dtbus_info to control use bus range information instead
cpu_address_fixup().
- Link to v2: https://lore.kernel.org/r/20240923-pcie_ep_range-v2-0-78d2ea434d9f@nxp.com

Changes in v2:
- Totally rewrite with difference method. 'range' should in bus node
instead pcie-ep node because address convert happen at bus fabric. Needn't
add 'range' property at pci-ep node.
- Link to v1: https://lore.kernel.org/r/20240919-pcie_ep_range-v1-0-b3e9d62780b7@nxp.com

---
Frank Li (4):
      PCI: dwc: ep: Add bus_addr_base for outbound window
      dt-bindings: PCI: fsl,imx6q-pcie-ep: Add compatible string fsl,imx8q-pcie-ep
      PCI: imx6: Pass correct sub mode when calling phy_set_mode_ext()
      PCI: imx6: Add i.MX8Q PCIe Endpoint (EP) support

 .../devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml | 38 +++++++++++++++++++++-
 drivers/pci/controller/dwc/pci-imx6.c              | 26 ++++++++++++++-
 drivers/pci/controller/dwc/pcie-designware-ep.c    | 14 +++++++-
 drivers/pci/controller/dwc/pcie-designware.h       |  9 +++++
 4 files changed, 84 insertions(+), 3 deletions(-)
---
base-commit: afb15ca28055352101286046c1f9f01fdaa1ace1
change-id: 20240918-pcie_ep_range-4c5c5e300e19

Best regards,
---
Frank Li <Frank.Li@nxp.com>


