Return-Path: <linux-pci+bounces-15483-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EA89B39F6
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 20:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 960681C21BAF
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 19:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33CD18FC7F;
	Mon, 28 Oct 2024 19:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RyRpOYmd"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2087.outbound.protection.outlook.com [40.107.22.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D091DFE30;
	Mon, 28 Oct 2024 19:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730142374; cv=fail; b=cTZsyHYdDzN6rQj2jEY9KRkYEZR8dd9/Ol+QE7MujOOE5HoN+ch0HVgUDNQMjK5oMDzIt+CtTMrHdCGTSTlSp+HpmTgo6uaqAQzggZWnE2hcKefWh8pqOmIaykS1JX61uRHL/pOJCQjw4KEsZpKJSlhsG1v5agziX3822ciuK14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730142374; c=relaxed/simple;
	bh=iuSQq7Mw93AFN7aqGRy3fNroxbvP+2q0TneS7rqN/TQ=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=P7K+7KZKH8Xhb3447t1KtZOI4rfu5XhmCAa7wYeaZ4Pxsq5S83bJfRtFrzGFlg1xi/lpmgJYDs85/IuanHBeaF3V3H0uXnwOWKrK0Xfae9xtC+lDrWJDkuNrWRatFs+kNKCP9JjKEAtjwyJXgmPr8lv774a7UH055NIElwh079w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RyRpOYmd; arc=fail smtp.client-ip=40.107.22.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EDgxOLDLRKKYZMKri3J1+bQgc7qmG+aQCHNa9oWzTjkjBHCQIKInQHpiFx2py+Pjvp4s0j40ERTkRA5TUVxIq01YpODILsahOA5pEri5Rm+akrL1akDmA+lMddzae2xckObVkCTt0BtFjTPKDAsPpEvMqDcjgYsJF/GQtKIq7fK85JVsZkzk711ZRApeLNwdnu7xKr5CJb4MYfnt+EahAXuJbcH44vw0vHcdmPqqUEKVV5B5aH92t6GTvl8m3V4u9MaARTQKTbYon5fCPBPABydcVKTs1Dc5VufCmYPGGGRvUO8w2g3IV6pvZDwH/Pys2BmS1j3siKgE6qi71N7xWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9tBRfIekk94DetId1/L6u4TFTEvgLVVmyFl3H+t/D4g=;
 b=dfRvTW6yO8kN6BXDURSpM29uRtsLfSNAsE/vkT2mntvMBmDMnLSolifTCdZ0twN4i0Zq8o1zq86EASIH3RKXpjvnvAN3KDayL/cLwSTnmNCR4kbl8aAtjQn88m0KgqIcVVSV7GnaNHLmTObr2a6elVpzo36FfuAT2KZzbUk5H6u+8wAb7Wf0EQh6eq6uhc3y8wUNkhZRBO331oTrQ7K72cVXrCwKXMNA6xSzYBw3ezLVuM1MC3rt2+7xrg3DKH8W59jn5KHBw+Q0Ph1BxhvVFZ7vERkDSisqzKFpZG0225GAMJKUDFQbyivwub2bTXV5IXCbPtKsy+oE/u4CgXDXTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9tBRfIekk94DetId1/L6u4TFTEvgLVVmyFl3H+t/D4g=;
 b=RyRpOYmdoS4dKhflw+8BW0/AxDqU6hWWbS1rHoFVrm6xOnohiZPsYnCbvqcShXxRgaZvoAUFe04zwDpzIncM5qCIwzD9Lcn0lJ+R4Xr5xCtZGYx2iJSdpHYyVOYzG0KSrJ5z4+VX8HCs5SuvdQinEjKz4Fc68HRJHiuTrAxDsrAkXH0QpXfQwYpEEjSoVohoO/UnVUJSyfZcyvWVBE3QbS/Bm/Ui4pQUKqZb6boUI1LElYkKIhkxkPhX/anNB7kwAfrscYMdny4W8DHmLQlJuXWxlKYOCIueKlMyKgRu7RFeVuR1Lv5I/5CgBX00agSkBtT+YvWNoTLqJnhGgC6pwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAWPR04MB9718.eurprd04.prod.outlook.com (2603:10a6:102:381::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 19:06:08 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8093.021; Mon, 28 Oct 2024
 19:06:08 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v6 0/7] PCI: dwc: opitimaze RC Host/EP pci_fixup_addr()
Date: Mon, 28 Oct 2024 15:05:54 -0400
Message-Id: <20241028-pci_fixup_addr-v6-0-ebebcd8fd4ff@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJLgH2cC/3XMQW7DIBCF4atErEs1wAzgrHqPqIpsGBoWtS3cW
 Kki370ki9aW1eWb0fffxcQl8ySOh7soPOcpD30d9uUgwqXtP1jmWLfQoBEajXIM+Zzy7Tqe2xi
 LbD1Zn5qu6wyKisbC9fsMnt7rvuTpayjfz/6sHtd/U7OSIMlFhW2jOGB662/jaxg+xSM06zW2O
 6wrZiSNhIpjwi02K2xgh03FHpgdGNIpuC3GX6wA/A5jxZqYNIAl14UtphVWtMNUceBIZIMn7eA
 PL8vyAwSUJQ+eAQAA
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Jingoo Han <jingoohan1@gmail.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, Richard Zhu <hongxing.zhu@nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730142363; l=7655;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=iuSQq7Mw93AFN7aqGRy3fNroxbvP+2q0TneS7rqN/TQ=;
 b=k3xeGYsLF59FTMWpMlu1AvT1woldZKo/77BcU9XanTNpsX7trI/H1vsd3f5YcAnAXbjfQDa0E
 EgApPByDTrLDpRJ5vlhhG6STZuuuxexx1y1JsoeOZ02pRJA7UhswFCy
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAWPR04MB9718:EE_
X-MS-Office365-Filtering-Correlation-Id: aecc68e7-bb46-485d-17f5-08dcf7839453
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d1YzR3ZSYUpVVDR1R2NDWUJZc0doNTF4RzFCVHhUdTY2a1hsc2tHYTVXUjlT?=
 =?utf-8?B?ZFlVRXlvMVhyTEhXWWNzbmEwVkhyZit0YnBsejBHUklVbDd4aXVJM3UrOUVh?=
 =?utf-8?B?RDdhN1NOb0gvaWQrdXFGRDNpbEhYQjlTTWgzNUVjNVlQdW9keGpzRTdmK2lj?=
 =?utf-8?B?TmRQM3VkeDFuRVI2aCswSWQzd3dIcXBBcUZQQ0cwSDhBUTYrMXExR3B0S2Fo?=
 =?utf-8?B?MFpMS1BBd0x4OWNXbWdSd09mRDdnVC9ZcGJtUlpHdWsvT2R0OFBaaGhIbzBz?=
 =?utf-8?B?alozT2NNUCthajQrY1EyNWljUWVYeThHd3ZjYk50TFlEaWIxbHd2aTVUZWxE?=
 =?utf-8?B?MlBlcHhEalZTc0dxQTY1b25iNzVZQTdWVWRuQ3d5MHZqNE00Z0FRdWVWZ2V4?=
 =?utf-8?B?anFUb2RBRGtZU2RIS1l6dWFIa2toZWE4YXNPNWRIMjlJLzdNZVdScXAvOVVa?=
 =?utf-8?B?dkFObDRIVkkvcXpBYnpWTWQxWW0vU3FweUsycVY1b1VOckdveWNoRlF1ckF4?=
 =?utf-8?B?RzErSW9JN0ZLZ1ZBVnF6V2pwT3VSWWxLOVNBWEpYNlltTkx5NE9iM0V5ZWJR?=
 =?utf-8?B?S090azVZWFRhdS8rZ0JLbEQxZVR6MkdvVWx3bnN5R2dkbkNWcjJnc3I0Nk54?=
 =?utf-8?B?ZWhPUEJLL3VZQ29OL01vMHVLemJHYXdUWHFGK3pTb2EyTk13TXJBYmllVEhL?=
 =?utf-8?B?SXRrZkhlK1o5NFJLK0JCdlh0Y2plMUU2WGV6TXBmTWpRZllXSnpFRldDeUpZ?=
 =?utf-8?B?K3I5bUpjVkxmNDYvcldtRVhHN2JxU2hibVI2OTBuV01KdWk1YmhuQnlDQUg2?=
 =?utf-8?B?REZBc3pxWnJIVXN4NWV5eU90YzJvRmN3SkFvbXprRHJsQjZ4T2pPODA1RWFY?=
 =?utf-8?B?QU1QQ1RYTTY5VU5ERlVqbUs2TkpDTWJyNko5cHVodTZMYzMwTjNZVzdOVkdN?=
 =?utf-8?B?d0ZwVEtGVCtEVVZMU3B5WFFBakZIcFBiQkFBckpjYWVMM1Q3YVRSRVgwQzhJ?=
 =?utf-8?B?ZlFKZXRaem1oTzJmQmhxeTJPWktDRG5BZjNMZmZxdVNoR0Z6UVIwRWNPMDBq?=
 =?utf-8?B?elJKZDFHQWJtYUFjV0djOWtxeHR2Y1AydGZQN2I4dFUrRlVSZUtVV01YTkhz?=
 =?utf-8?B?Rm1PYjFSTEQxTndKMXQzcjdJUmZDUG1lcndjOFI2cFp4VStNb2RiWG5tUjBj?=
 =?utf-8?B?Y1pkRGpNTEFLaElYUTdWZzdhSVNCcGJlVE1BLzcrNVNDMVV3Q2hUQmExdEx1?=
 =?utf-8?B?UUlGYWM0RGp3SDhGTVd0cmZYelgvc3RDVkl1NFlSMEhQMTRqb3BCNVhiakRr?=
 =?utf-8?B?WFM0ODA4Y2I0cGw2Y2RCRnFVN2FVRUViOXFHVjVQdGtOVEZmSGwrb1A5NHN5?=
 =?utf-8?B?WVcreVdhZ2NGZGwxY3doS25vTTdET3hzSVNBdGJpR0NqS1dtTUxnZEFDVTAx?=
 =?utf-8?B?SUo3Y2FtcjhqMC91WEtzWkxGQ1g4d1g3RldyZUc0NXB4dGVlQjRUdkhHcFlE?=
 =?utf-8?B?M3RmS2Y3RUxpTkY0VHFRS2M5dGVYZXZRWUphNVAvb1hFeHI5dGx3UlJubmhE?=
 =?utf-8?B?eWxMMDJ1d1JSdEVSeUNqMmNudm9maTREdVNQMFR1cVB5VTFOZDJTMkRVNTBK?=
 =?utf-8?B?emFZdTVFcU1UcTRFVWdXVTA5TzJ0UjFzeXVyNWtvaDZqcVZ4ZzdFeTNscC96?=
 =?utf-8?B?SjNQSlpVSXRVdWI0dUZJMFFBcjBaUnA5TldPS0NrazMzNUpGWElvNUNBYWxa?=
 =?utf-8?B?UmlsSTQxSHRGeEtyOXQ1TXcwck9CRk4yL1VNUDRLN1ZEVk85c0ZEWG91L3V1?=
 =?utf-8?B?Q2ZxTDU0TUFPR0pKQU8wSGJSOW4yNlVBZjQxLzFaQVNLTFEzMjVtNHZNK1ph?=
 =?utf-8?Q?ht1gcSA8EYBYi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MnRkV1ZWdWh4NnlEVjhzTGZKZDh6a2k1OUVWUGNYUkdDbGdOK25vbXRWU3dv?=
 =?utf-8?B?cG9CVWQrb0VpdGJ5WWdPVjlvNm5KR0V3bjdzd2R0NDlNZkVaUk5rRzdnQlZD?=
 =?utf-8?B?d0hpaUxzbjA3RHM5ZnY0K29xRktwSXlrZEJ5Zjh3V1RkQi8wTDJhcFdOd1Bl?=
 =?utf-8?B?U3llZEZlZzRVNzg4VXRCTVhDUzRGekRLTkczeUtMY0V6Y1dWNi9oYUVlb0xJ?=
 =?utf-8?B?MEVlOTB0K21XYlQ0MXVNME4rUTQwajVXUjZrR3hhdk9XVkxReCtsdG4wUnFN?=
 =?utf-8?B?TTZsR202dUx3V2crRzVjdVQ2bWtzMXNRR3gvUS91dFY3K3A2S0hmM3JqbXR1?=
 =?utf-8?B?TzdGNEdWNTV5ci82UmQ4NEZBc1RJQVVEajJVSVRaemxhLy9ZVldoekJTUkR1?=
 =?utf-8?B?VXBGU1gwSzhOTGErRmttcUorUVdsWHBCWXEvNkJhWGM5aCsrQzc3SjJuZDN5?=
 =?utf-8?B?QUdrZVA3V3VJZW1iYUU4NVVZZjhua3I4MUk5anMwSVBkZnVrckhuNkloS2Uv?=
 =?utf-8?B?eHdUS1lNS1cxUm9qMEtJa1ZxMzV6aTJFQ3BZbGVtOU9qV1lWT1BuUkVsRTNs?=
 =?utf-8?B?em9GRklxOEhWbStiMDVZTHN2eUhMTitpVnRjNFJpNi8zcDUrNjQvbmlCNzRt?=
 =?utf-8?B?MThzQ2h2ZlpKMFlGbkZHQ3B2ejM0M0NPZ2dZanVQYWRBUUQyd3k2bDgvOXIv?=
 =?utf-8?B?UUFaK2p0bUlFOFZybGZURTZnVjFkeUcvN3pVbUFjVkhGMFo4Nlg4TkIzY0N1?=
 =?utf-8?B?dENZSmtVODUwR3gwNVQ1UFcxZG5mdUlmcEJwZkVlb0JXWUFWQ0cxclZoQXJr?=
 =?utf-8?B?L1lLb0QvKzBlbGtYMFdxWXRXU1RwT002aVo1US9vMzh4OGY1ZHpKQkhINXNl?=
 =?utf-8?B?a2ZqTWoxM3poN2ZtY0RPNnZJUXZxVXZBV3BkS1JkZStHZFNidTlMeFcvekkz?=
 =?utf-8?B?Z3BXZmhoSVlLK29PTUpQbWk3WnBDV3F6T3JlSktrbThtNkF0clc3MVM2dlFa?=
 =?utf-8?B?UlZRL3BzSnNFRWFkT1VsejZnTVVkeU5SNGVDQ01vMDByeEpFOU4vV0trSmhw?=
 =?utf-8?B?aGhpcVl6MDZIVmxCNzd0QnVxMlNSYSs1ajlIN3creVZVYUpjaFFLWTRPVDdt?=
 =?utf-8?B?Zk13NXdSc3Y4OUdKS1FrZWs4MzlMd0F1L3ZvdFFBTlZZZFAvc0xJc21tdHRB?=
 =?utf-8?B?VkNCZzdQVVRtTzhnMm1RZzY5QjVhc0xXQzBNNVlzcFRlc2p4bUFobDI1K3pp?=
 =?utf-8?B?NVRsU2NnV3c4WFByZm9BTTNVcGFDejVGank2QlQwY1owTUdlcks3Vlc1SEdj?=
 =?utf-8?B?cEpZYXdnOUg1SURDQkZ1UlZIdkNKVVlENWNhQUZWbVZ0dVh6YVBHRnZZUzAw?=
 =?utf-8?B?OFZPUXVoMzd0QTVMeVVZakpKbWhnbGdkaXNZZit5RVNiUlNaVklQaFFaQ1R5?=
 =?utf-8?B?YllodlhIR0doYWNYQmpuc0VNdlgyYjBHNVRlYStzcmlQTnpqcVFNNHgzTFRM?=
 =?utf-8?B?OEZ4T21aRmtvUmt5Z1k5VzRDakQ0MjNDeXNhM3dLWWRYL1lORHFESmkwNFRZ?=
 =?utf-8?B?OVBndmU2OFJaajJ0QmJmNGdOMFVnaEI0ZitaMUk0dmVuVmx1MzBXVGFpVWkx?=
 =?utf-8?B?YVdvN2FXdFlYNzFVYnB6cmpta0N0WWgyWHQvekh4RzZDUTBWR3h6cWJxd3Vi?=
 =?utf-8?B?aGRUQUVNMzV3cy9iRmpkVU9mRjB6Y0tLQjRDMElwcXJkK2lacUtFdlJ6eTNF?=
 =?utf-8?B?T0pLNjJ4NkhlRW1tcC9Ya0dQdnVLZ0tYaG5xZzhvUVFWdlR4WDZPUVQvRmp0?=
 =?utf-8?B?T08yUXNpQzNuSjZOYlhKdEJiWFM5bW9nbGRHY1NDaXpURld3ak5VT3hqYlpQ?=
 =?utf-8?B?UVNCZG15d1lLbU90S3pUcUM4dXM0aUxEOStzTUNhbG5rY0JmWUorbHZKM2dx?=
 =?utf-8?B?NlpaUUl0S0RxMHJjdnZHcis5VG5FelEzNTZndFRxWlNjVDEvNTR5bnA0dmdY?=
 =?utf-8?B?VnhtQXF4TWszVDhGZmdHc2xOeENkWkZYVDlYWEV4RHpGaHhxYjJpU3FwcFhy?=
 =?utf-8?B?RjJlbTBaWFNnanFzYXB0aTZ3cnpmVU9Qci9PSTFPRkhBajd6bUVOSTlXb0o0?=
 =?utf-8?Q?3yTXZrlcrpE4DDeajZC9GVC1k?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aecc68e7-bb46-485d-17f5-08dcf7839453
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 19:06:08.2318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jS25ULJc/CVIQ8i85K7TDgba2v9U6biy2fixnzX+NU3R961s7GzMqLplMXadPwm7qtmMVkbYYSpJmgl5tZ7VVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9718

== RC side:

            ┌─────────┐                    ┌────────────┐
 ┌─────┐    │         │ IA: 0x8ff8_0000    │            │
 │ CPU ├───►│   ┌────►├─────────────────┐  │ PCI        │
 └─────┘    │   │     │ IA: 0x8ff0_0000 │  │            │
  CPU Addr  │   │  ┌─►├─────────────┐   │  │ Controller │
0x7ff8_0000─┼───┘  │  │             │   │  │            │
            │      │  │             │   │  │            │   PCI Addr
0x7ff0_0000─┼──────┘  │             │   └──► IOSpace   ─┼────────────►
            │         │             │      │            │    0
0x7000_0000─┼────────►├─────────┐   │      │            │
            └─────────┘         │   └──────► CfgSpace  ─┼────────────►
             BUS Fabric         │          │            │    0
                                │          │            │
                                └──────────► MemSpace  ─┼────────────►
                        IA: 0x8000_0000    │            │  0x8000_0000
                                           └────────────┘

Current dwc implimemnt, pci_fixup_addr() call back is needed when bus
fabric convert cpu address before send to PCIe controller.

    bus@5f000000 {
            compatible = "simple-bus";
            #address-cells = <1>;
            #size-cells = <1>;
            ranges = <0x80000000 0x0 0x70000000 0x10000000>;

            pcie@5f010000 {
                    compatible = "fsl,imx8q-pcie";
                    reg = <0x5f010000 0x10000>, <0x8ff00000 0x80000>;
                    reg-names = "dbi", "config";
                    #address-cells = <3>;
                    #size-cells = <2>;
                    device_type = "pci";
                    bus-range = <0x00 0xff>;
                    ranges = <0x81000000 0 0x00000000 0x8ff80000 0 0x00010000>,
                             <0x82000000 0 0x80000000 0x80000000 0 0x0ff00000>;
            ...
            };
    };

Device tree already can descript all address translate. Some hardware
driver implement fixup function by mask some bits of cpu address. Last
pci-imx6.c are little bit better by fetch memory resource's offset to do
fixup.

static u64 imx_pcie_cpu_addr_fixup(struct dw_pcie *pcie, u64 cpu_addr)
{
	...
	entry = resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
	return cpu_addr - entry->offset;
}

But it is not good by using IORESOURCE_MEM to fix up io/cfg address map
although address translate is the same as IORESOURCE_MEM.

This patches to fetch untranslate range information for PCIe controller
(pcie@5f010000: ranges). So current config ATU without cpu_fixup_addr().

== EP side:

                   Endpoint
  ┌───────────────────────────────────────────────┐
  │                             pcie-ep@5f010000  │
  │                             ┌────────────────┐│
  │                             │   Endpoint     ││
  │                             │   PCIe         ││
  │                             │   Controller   ││
  │           bus@5f000000      │                ││
  │           ┌──────────┐      │                ││
  │           │          │ Outbound Transfer     ││
  │┌─────┐    │  Bus     ┼─────►│ ATU  ──────────┬┬─────►
  ││     │    │  Fabric  │Bus   │                ││PCI Addr
  ││ CPU ├───►│          │Addr  │                ││0xA000_0000
  ││     │CPU │          │0x8000_0000            ││
  │└─────┘Addr└──────────┘      │                ││
  │       0x7000_0000           └────────────────┘│
  └───────────────────────────────────────────────┘

bus@5f000000 {
        compatible = "simple-bus";
        ranges = <0x80000000 0x0 0x70000000 0x10000000>;

        pcie-ep@5f010000 {
                reg = <0x5f010000 0x00010000>,
                      <0x80000000 0x10000000>;
                reg-names = "dbi", "addr_space";
                ...                ^^^^
        };
        ...
};

Add `bus_addr_base` to configure the outbound window address for CPU write.
The BUS fabric generally passes the same address to the PCIe EP controller,
but some BUS fabrics convert the address before sending it to the PCIe EP
controller.

Above diagram, CPU write data to outbound windows address 0x7000_0000,
Bus fabric convert it to 0x8000_0000. ATU should use BUS address
0x8000_0000 as input address and convert to PCI address 0xA000_0000.

Previously, `cpu_addr_fixup()` was used to handle address conversion. Now,
the device tree provides this information.

The both pave the road to eliminate ugle cpu_fixup_addr() callback function.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v6:
- merge RC and EP to one thread!
- Link to v5: https://lore.kernel.org/r/20241015-pci_fixup_addr-v5-0-ced556c85270@nxp.com

Changes in v5:
- update address order in diagram patches.
- remove confused 0x5f00_0000 range
- update patch1's commit message.
- Link to v4: https://lore.kernel.org/r/20241008-pci_fixup_addr-v4-0-25e5200657bc@nxp.com

Changes in v4:
- Improve commit message by add driver source code path.
- Link to v3: https://lore.kernel.org/r/20240930-pci_fixup_addr-v3-0-80ee70352fc7@nxp.com

Changes in v3:
- see each patch
- Link to v2: https://lore.kernel.org/r/20240926-pci_fixup_addr-v2-0-e4524541edf4@nxp.com

Changes in v2:
- see each patch
- Link to v1: https://lore.kernel.org/r/20240924-pci_fixup_addr-v1-0-57d14a91ec4f@nxp.com

---
Frank Li (7):
      of: address: Add parent_bus_addr to struct of_pci_range
      PCI: dwc: Using parent_bus_addr in of_range to eliminate cpu_addr_fixup()
      PCI: dwc: ep: Add bus_addr_base for outbound window
      PCI: imx6: Remove cpu_addr_fixup()
      dt-bindings: PCI: fsl,imx6q-pcie-ep: Add compatible string fsl,imx8q-pcie-ep
      PCI: imx6: Pass correct sub mode when calling phy_set_mode_ext()
      PCI: imx6: Add i.MX8Q PCIe Endpoint (EP) support

 .../devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml | 38 ++++++++++++++++-
 drivers/of/address.c                               |  2 +
 drivers/pci/controller/dwc/pci-imx6.c              | 46 ++++++++++----------
 drivers/pci/controller/dwc/pcie-designware-ep.c    | 21 +++++++++-
 drivers/pci/controller/dwc/pcie-designware-host.c  | 49 ++++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h       |  9 ++++
 include/linux/of_address.h                         |  1 +
 7 files changed, 143 insertions(+), 23 deletions(-)
---
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20240924-pci_fixup_addr-a8568f9bbb34

Best regards,
---
Frank Li <Frank.Li@nxp.com>


