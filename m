Return-Path: <linux-pci+bounces-13389-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF44097F0F7
	for <lists+linux-pci@lfdr.de>; Mon, 23 Sep 2024 21:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F5E6281D6C
	for <lists+linux-pci@lfdr.de>; Mon, 23 Sep 2024 19:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C86A1A2C0C;
	Mon, 23 Sep 2024 19:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dpSd2L0y"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011037.outbound.protection.outlook.com [52.101.70.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2E41A2632;
	Mon, 23 Sep 2024 19:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727118036; cv=fail; b=Zs/fDmrN+jY/w0DCRME/xqXqnvccnqbYLmeWZjLV0dqj8A3lSrRSXz1HHdwwzRil4Il8RaSDPc1xzSd8AFxVZ2gnITg8VrbC5bnCrhJpxuQSklVUqr1HIVJx2C2C6fcbF26tc+eVLA1bXKywhHqJXxw+e8Imm47l4fu154/h8nc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727118036; c=relaxed/simple;
	bh=HmHQZfq9L8UmM2u5lYQ3fG7uWgmbd7LJLFR4sCzXQBI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=lYk4sjucUnjddfmtPxXSJXirFAanXYQgs9SUDzMykDX2X7PWgnrtsMkdDrcqCCbSnKEplkwHU/EuAcrpWaZFd0UF5WXr5vxcROtI2E4jSisajM8YNXcU3lrnawQt91dZcr3E2HCzaisaM6mHK48HwHP/rGdLCys2RXkMU0XrhL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dpSd2L0y; arc=fail smtp.client-ip=52.101.70.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b/Mts+X+dQr8EZUMqbHFQu+/w5HxZMSXUfneDd88j0NmR5lV3sHoxJDPOgIaWTYgqvpMkiZ2GjNC1Zn+T8YxhoHHegx+d8Y4WGgc20WQAnTnXtfEs+7tdDu8EJSqeBrKpFTbad5xMCS2mfKeV0yK/WmL3FzTo7V32oiL9cLs1y1Qp2QbaQ3GR0uKYvlZMtEXtWO7Ah51mHmmsnk58+G/OAf+IXgx2M+QS8rU5G0isHOYnk6mirqqDNWZr8gw0Y7nVx3A5REptR3TYvaQT+E6v6VSgHoD2Nxg9I567aaiidX8zoinlTCJrWiawyphSN/rmKoGLJYdv7nF+ojbKpGa4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hNBQub/0c6XKxnoL1eJNqowuPC2/Be9FImQcc7+deUA=;
 b=huP+5l5392pzN7qkZYicB06bufmn10JtrStOlHir0hCcL2E+jJELPbwBHhkSlDe5RPQcazAaRGv799eEL5ceQXCmVgQ3qSWlegGhOxefHiQ7/L4tuiJAJttbHoLpFMnJnaO9wO7KCf9zIVYuoU5n9TBxeg8E6FKQkQQXOVCD/AQGB3pFTDTdDhQJ5ivr5czOHM3FV6ty7ZbydWbaDLuPEjJ8+rIqevaW16ngNdg5Rzcgr1yKjdCkrnFYwCL9dX6JKSSdPHzxRLQ5q9+DF+TtyDqVcp1PArlXl8dGS4x5IqRyQ0RS4xZvnDrNJ/xn1zJ5S3EAuBXFaFWOow7raGpewg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hNBQub/0c6XKxnoL1eJNqowuPC2/Be9FImQcc7+deUA=;
 b=dpSd2L0yLSH65GCbN1mlNDMmrDgdVUA5DIZIZCTWxRx9uUds2UF4IdfTtvu2ZYWxVt3qOLyLMBR/roLhJpTQGm7gE5PEG7WMHIgGfFs7Q5I2DRMLxiEXRio3xGQ1apXC3Ohf8og9FCBWMxjN3Claqr7ZD7tWLuQatXPkjH7E/iHzK0zeMSfdIkULkti68MBpxtHeW4Z1A3bNLn5sfAgBAM9BPDql2lrW5UIEiPkP4pi/SIsuYaAqTmQzWGNaB3teqk56U0owcQHMVkZoDtfaZdukPwlfJFw53GudVNZxOcOLqbWwYf2ECX3O0yrcBjS/ldJmNkaOjkvbFKsm4m3fJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU0PR04MB9562.eurprd04.prod.outlook.com (2603:10a6:10:321::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.24; Mon, 23 Sep
 2024 19:00:26 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 19:00:26 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 23 Sep 2024 14:59:22 -0400
Subject: [PATCH v2 4/4] PCI: imx6: Add i.MX8Q PCIe Endpoint (EP) support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240923-pcie_ep_range-v2-4-78d2ea434d9f@nxp.com>
References: <20240923-pcie_ep_range-v2-0-78d2ea434d9f@nxp.com>
In-Reply-To: <20240923-pcie_ep_range-v2-0-78d2ea434d9f@nxp.com>
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
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727117997; l=2309;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=HmHQZfq9L8UmM2u5lYQ3fG7uWgmbd7LJLFR4sCzXQBI=;
 b=BnflfNkgIwTmbgTStGai5DnLd9Tn+4c6USz+hjoFnoHbBCh+KqffAKh8tYUR0tLthX125iwHb
 /OQBnkp/KYCABs4BCn7J4f4MmG7hE4HRXGCGidZkQ687nj4j5Uq8X28
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0065.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU0PR04MB9562:EE_
X-MS-Office365-Filtering-Correlation-Id: fa589a06-aada-41d2-a397-08dcdc01fc68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Nm5TQy96TGJ1bTF6OE16NlVGYjJWOTNkMWtna3dBT1Rpd094dGhGMldrcHFB?=
 =?utf-8?B?OHR3N1VDMTliRlU1cmRMZkFIeENCM1Fra1Q5TUt2M0NDeE92UWdHN2h4MVc1?=
 =?utf-8?B?UVVxekliR1hWS2FxTmJQd0F4OWVrVnhkOVF2R2pkaDg0U0gwNkVtOGhlK3h5?=
 =?utf-8?B?czkvTXR5dVdQVk9jOEhiQWFMSXZiWFBkcUk2ODRmN1BEZ21LMXRIdTR6MFI0?=
 =?utf-8?B?VHpKWWF0NmdqKzRuRzRDSWpGQUYzcGU4QzhmKzVNb3puYkFuMWNld0hWNC9s?=
 =?utf-8?B?eW4zVXhEMnhVRkloZzRGWjh2a3o3WkMrNElzN3R2NHU3eFRqcGw2T21may9r?=
 =?utf-8?B?aXRpWGF2UUZ6OHQyM3k1VjNaNC84aFc4cCtCY1Fud3dFY0hCZndWUVgyaG1E?=
 =?utf-8?B?d0hHZmg2MWgyYjIrSTNJTnpEancvZTBUSVpCRFBtSElra1J5c1NRdDNLWEJk?=
 =?utf-8?B?ejFub0ViR0JpcHRMQmNnZGFyVWh2dStRRlNjQ2lEWm8zTDZDTmZNc0hVVkpJ?=
 =?utf-8?B?Mndnb3g1bHRhQmZudkJnRCt3ZW5TbFN3MXREZGRuZFdTL0tidWtlWTJsa05z?=
 =?utf-8?B?Y05DQ3lsemZSUDl5c3ExNDB2TzV4dmxFOXRQbXdMVzVNUlg5YTZGUXE1aFpI?=
 =?utf-8?B?WDRINzlLR2dOYldNbHcwbHR2aU9kUmVnSEdpTnE4TkcyMkd3VGltcEZtdkhE?=
 =?utf-8?B?cTdKZ1EyWnkyWC81ZU83SGYvbGJqcjBPTTFIZFlIWUxLNVV6VWsyYjFFbUlp?=
 =?utf-8?B?SmNPajFpN2lzTFhpVGkwU0xnSWZNb01SUmNjT0s1cDlpTFRXNGJneVFlTWxF?=
 =?utf-8?B?VW1SS0hKQjM4cCtiWVVlSTF3alFpZTR6a1JHUmdPaU9MY0pYNlpvUUVwNjhQ?=
 =?utf-8?B?ajZqdGVycEw2ZTB0Rkw3QjA3QW9MWi9ZVE92Vkd5WDRYbDVzUVNLcHdBWDd1?=
 =?utf-8?B?K25SbHlyeHRMQmV6Sno0UTFodHBFa0RVNmZFRDVyQXlTTjU1cWFrV1BnYndl?=
 =?utf-8?B?cUdtdkoyWVhjdm5ueTVLZ3NVRXBBRWFDQXRaWllFSjg2aG1NcEMwWllPVGsr?=
 =?utf-8?B?cTJ3aStSeTVsMDFmQnNPVmRLVnlJSGwrME9kTEFQTzdRekQzR3A5UlJCcVdy?=
 =?utf-8?B?NGJneFhCdFBoUit0ZS85L1dyMzNMbEFQeEtWLzQycSswQUt2VS9ETFlOa2dX?=
 =?utf-8?B?Sk1ia0RnUjFKVUVVZ0pCTlZyNGRsdCttZzQ5OEIybmpTZzQ3SVl4NzN0cU82?=
 =?utf-8?B?YTlTMVlkWTRFRitxMDRnWTJGb1NQRG5HUWlLeU5NeWV3cXVIemhSeDRJMjBK?=
 =?utf-8?B?OFlGTlo1L1JydGRVUlh2TlYvNlJNSkNkWXhDOHYwTDg3WU51Q3BhTEtXR01P?=
 =?utf-8?B?dlFIQW52YWkwR0pPK2dNUjR0TXdHUDRvbUx0bVBWMTdBdlFDVVZwWHF3eUYx?=
 =?utf-8?B?T3ExSk9CWXNyZ1J5RFcxSHJSRC84QWlRWHZSLzJMcU96dVNicitQaUN5SkdZ?=
 =?utf-8?B?dmtwMDljOFl2TDdHZ0RzY1Z6ODR4b29oYkx1RVpaclVkd2JKeUhMVHN2TU5j?=
 =?utf-8?B?UHFNd3RETTRhK1NXbzN6TDBxT0hyUHJ1cUQ0ZkViSVAzNk1MTUs5YW9EdjRO?=
 =?utf-8?B?S2p4QTRZRU51eHh2Rmw4clNDU2Rjai94SHh4dGtkTm0xL3owZEZrT0ZTWUgw?=
 =?utf-8?B?WTZTOTNkTTF5bTE0VzlLcE1IeGV3clFQSm91VW8zcnRUaGlqQk1pc1VyaExG?=
 =?utf-8?B?Y0JHSnJzclhJeEdrKzdpdTFrZGFlTDBMdVBhQk5GR0d2QnQyUWhwM2IzZjll?=
 =?utf-8?B?ME1TbXVOZlplZ0lXY1VPNWZLeGZRM2V6WlJaZHdxL0tjbmxRN2JwSUcxSVVN?=
 =?utf-8?B?NnM2dldFTW9kOUVyV0tTODVhRTloTVlsMTRjNi9leFBzdExjM2EzQTl6Y1JU?=
 =?utf-8?Q?LNa44dlyFdo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eHRFakIyVDJzN0d3UE1VbElRbStTOWc0UENLY25jdU02L3ZQdTNaMEwvRUJV?=
 =?utf-8?B?Q0lOSTFjRkFEM21qNUFka05YYmxucmVSM0JDYWVNYTFVNVZLUHkwV3AySTdQ?=
 =?utf-8?B?K1hVTGd3QmVFS05rNTZkOGJnMnhFOHk2dHU5OEd1aFBNeDNmdW5XQ2U1RG5B?=
 =?utf-8?B?NGNORUEzbzkrMTdsUGZadXdCc1h4b3VZT21KTGlZSHo5R1QzK0xwbmhRajZq?=
 =?utf-8?B?MkJjcGdrcjJ2eXZ5RFV2WUNXYVViN1Nna2tibzZEZlNzME9YSkpIVnV0Z2Vk?=
 =?utf-8?B?TktTSEphOWJPTE1WMXpPQUV0VHBqbVg5MUZGZ21Jd0RMUFhLb2wrNUJlazkw?=
 =?utf-8?B?SE43NDVLcnk4YXgvSEhjcy8yRkNSS0FDR1dhTnptQWdNa09LNW1XTnJqKzBp?=
 =?utf-8?B?dHVHU09hY1FIQlpJdzBwYVZhMlY5MkRDZVljZWNTVVoxaUxxNHY2QWNBSXVs?=
 =?utf-8?B?RXBVR2VhQyt3WE9NWHVzUnVqdFFidXlnVlNXNUF3aUhUMFIzSE9oSzdqWkNY?=
 =?utf-8?B?QnV6dWE0cEVMY2x5OGZYK3hwd2ZueENqRTd3bGx1U0M5UnBzL0N6R3pvUjlL?=
 =?utf-8?B?M1RNT3F2RVRlQmUrTXFXOTUwV2VqQ3VXV2p3aTZuQXpPRlNEYVRTY0tFNmtx?=
 =?utf-8?B?WU1XRU55dEcrekIzcit1VmRvQzI2WVN3WktDc3QzZld5NU15RzM4VHRnUHhL?=
 =?utf-8?B?SjdpNG5Ec0txNFBwbVpoc3pWRjg5ZlFmbXU3ZWNYb3huMmlKVDczVVN4dE01?=
 =?utf-8?B?blZ3OUZVL3pCc2tXVThvMEtYVDFqUnlmaUlHOXlFSTNFWWYvbXlCME1GU2cr?=
 =?utf-8?B?eEUyRWFXMEdlenMxcTg2aGpGbzF4M3I3b1lDVEF1TjJqSk4xWEwycjJMYmlO?=
 =?utf-8?B?MVVpcng4ZWY4YzBmWjR6YjdNWHp5K0R1c1RmUlM0OXo5RmpKUFllaXJORWV2?=
 =?utf-8?B?ck54cklTZXhtVSttektqeTNtRDkxK2kwaEwrbUxhQ2lOL3I2Mmdrd2puUFFP?=
 =?utf-8?B?OWdoc3dRTW5CbklMWjg4bU9jazRXYWFhczFkZ3d1bC80QTM2Tm9sV1BRN3B6?=
 =?utf-8?B?TnpNVTRzNWw3SmVFSnhnckwraTZyYTlvYmpyMVk0dm85eUY5S2I1aHdCeEhw?=
 =?utf-8?B?MWlDOGEwUWJSYkpGQTRFT2p5OUl1a24yVU5GREw0cWtSQ01nMXdlb05SWnhO?=
 =?utf-8?B?TzR5QUNrcVpKbzgrSEtLKzZ2cDEzeUo4ZlVZRjhLVkZ3MFVmd3hLQ29RRTN4?=
 =?utf-8?B?SmRqRjUzdUFWRlVhVEZyaTRMQUtyaDdicGZUNXZ3THFKSFZxeGRaclpDWnpv?=
 =?utf-8?B?LzVjcnpPNEJiQm14WHBDZTZHM2MySWt3ajlKUlZ0QWhTZmFhTjFsK01SbTJz?=
 =?utf-8?B?bzlDd3VlZ2E3d2xlQkxVdUR5WGdtR2E1YlBTMEtvZmxYREdjL1J1NFZ2ZTBa?=
 =?utf-8?B?QWZ5eVhreEYxdzBmQ1FxL3NrOWJTWEtQTG80MDBadGJqUXdzNkc1ZkhLeDQ3?=
 =?utf-8?B?M1JsT29DOFVyYlkwWHlZUmhQS0k3bFc0UVlPYVJxQVBBaTJzUFAzUUdIMXh0?=
 =?utf-8?B?c2VFaE05TzUwajF2N2t3a3k0bFNacnlhV1RWWUlqS2JnaWs5R0dFb3hJMW8x?=
 =?utf-8?B?UndsWU8xMFVNT2FXYXdHcUFzK3J3cXF0NnhicmJTNTZQdkM2SExORG13R0Fm?=
 =?utf-8?B?ZEVtQXh4bVRwREVlbEhEaVN4OEM4Mys2Z1NnNG5kNWw5am5lS2N6NjFMN3Bt?=
 =?utf-8?B?cjl1RGdtM2pVT0dYZjhRZFJHUnRqZ3FhUHFhQ2ZXZjdZZi82RHo2LzZ1ZjV0?=
 =?utf-8?B?SElXWmRTSUJRc29lZnN4R0NtWDBRbTZDb1VBaXhqUFVYbXBIeHByK0hmUUxn?=
 =?utf-8?B?RThObnk0TFJSN2xkUW0ya3hseUZxSmY5b1VramwyRUZRcXJDMHphTjM4SGlQ?=
 =?utf-8?B?clI2WXNQVW1CcmRmWmhTUWJMMmh3VDJwejdLOWhURGtmL0FzelIxUndURkRz?=
 =?utf-8?B?L21zZFdsT0J3ejRlY3VnN1pwdmRzSndDM0FsdWl3Y2NKN2lKVkpYVVhnWEtK?=
 =?utf-8?B?ci9hdk1NQ09rdXFCMDBCdG1Hb3h2R3RpSUQyRDhrZzlHcXpXbjVDRUdSNVV1?=
 =?utf-8?Q?j2HQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa589a06-aada-41d2-a397-08dcdc01fc68
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 19:00:26.8393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xg211o7gQLBjfzD0oLvSh51d9Le4VxCq4rZIir2pN+NzkxjgGdVE4e5IXesf5ikg3Ym0zETFN4YKjKE/bpGb3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9562

Add support for i.MX8Q series (i.MX8QM, i.MX8QXP, and i.MX8DXL) PCIe
Endpoint (EP). On i.MX8Q platforms, the PCI bus addresses differ from the
CPU addresses. The DesignWare (DWC) driver already handles this in the
common code.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index bdc2b372e6c13..1e58c24137e7f 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -70,6 +70,7 @@ enum imx_pcie_variants {
 	IMX8MQ_EP,
 	IMX8MM_EP,
 	IMX8MP_EP,
+	IMX8Q_EP,
 	IMX95_EP,
 };
 
@@ -1079,6 +1080,16 @@ static const struct pci_epc_features imx8m_pcie_epc_features = {
 	.align = SZ_64K,
 };
 
+static const struct pci_epc_features imx8q_pcie_epc_features = {
+	.linkup_notifier = false,
+	.msi_capable = true,
+	.msix_capable = false,
+	.bar[BAR_1] = { .type = BAR_RESERVED, },
+	.bar[BAR_3] = { .type = BAR_RESERVED, },
+	.bar[BAR_5] = { .type = BAR_RESERVED, },
+	.align = SZ_64K,
+};
+
 /*
  * BAR#	| Default BAR enable	| Default BAR Type	| Default BAR Size	| BAR Sizing Scheme
  * ================================================================================================
@@ -1645,6 +1656,14 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.epc_features = &imx8m_pcie_epc_features,
 		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
 	},
+	[IMX8Q_EP] = {
+		.variant = IMX8Q_EP,
+		.flags = IMX_PCIE_FLAG_HAS_PHYDRV,
+		.mode = DW_PCIE_EP_TYPE,
+		.epc_features = &imx8q_pcie_epc_features,
+		.clk_names = imx8q_clks,
+		.clks_cnt = ARRAY_SIZE(imx8q_clks),
+	},
 	[IMX95_EP] = {
 		.variant = IMX95_EP,
 		.flags = IMX_PCIE_FLAG_HAS_SERDES |
@@ -1674,6 +1693,7 @@ static const struct of_device_id imx_pcie_of_match[] = {
 	{ .compatible = "fsl,imx8mq-pcie-ep", .data = &drvdata[IMX8MQ_EP], },
 	{ .compatible = "fsl,imx8mm-pcie-ep", .data = &drvdata[IMX8MM_EP], },
 	{ .compatible = "fsl,imx8mp-pcie-ep", .data = &drvdata[IMX8MP_EP], },
+	{ .compatible = "fsl,imx8q-pcie-ep", .data = &drvdata[IMX8Q_EP], },
 	{ .compatible = "fsl,imx95-pcie-ep", .data = &drvdata[IMX95_EP], },
 	{},
 };

-- 
2.34.1


