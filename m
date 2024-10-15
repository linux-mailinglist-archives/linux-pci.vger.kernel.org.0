Return-Path: <linux-pci+bounces-14597-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D50F99FAF8
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 00:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1A7C281198
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 22:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6866E1B0F3C;
	Tue, 15 Oct 2024 22:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KYtdnDXi"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010038.outbound.protection.outlook.com [52.101.69.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F181F80C9;
	Tue, 15 Oct 2024 22:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729030104; cv=fail; b=uxI/J0Z4r5HfjavCa+HVxqe574YnX1qsrq1/PipLWQ3AdOlArrZQ877KA/nRANODPdyeS1nwC3EZIERf+gWHKYuZjQiKQeocoXFeOsSOaybe+xK831WWybcHzdUmxRcYTzWL1MZk/wSf1f3iHgEZH/KohA8RWHE3PMLAa2Xptz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729030104; c=relaxed/simple;
	bh=oLfeRG2JJa/EVak0ZqRbgfNgEQ6xhDK04ybgk4QBnh0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=cLrrJ36LvMGMaaNTZZXXaFAV/pOHD/bXkEgTGscFeju7fbIoRnJr4eJYEaGQEuQkzWyUvrJp146eQIjh88N/xlEQVPqiaMqdP7PRwee/95C0AAs7S0EORWyMWtolZYJoAw6srkqe5TH+zClUJkWPvIHOOTfLagCvQhm27cXezoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KYtdnDXi; arc=fail smtp.client-ip=52.101.69.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s8WBViq283QXcCinzg3aplHWoRzFUnl8i3FDBhYiPtKAA9xSSxhDdmjI6DIyF7iXNpjo5MRPjpzMp8fqHSyxYspk0LnzTRM4fYBTr4IEQObc5Zo3Z5dVH4X87XtnaaVCA1mkbmcRdQCl+Z/WjnSeMuHZVI97dd68hTDUNAz8Xy39jCGt5noXY4tcAitreTSlHQw5VKqS+WXZ611lQuks8BkhppqLFg+rhCptvZ1b5sgDHOi0J5HxHoHYaQETpCiKzcbPZqbmFYuwp9g2MCdmrGsXweXdje6P8PU+aM2XBQ/jFHTeLx+Fz7qG4wXV/Yq71ubF4KtGtsN4I1or74GRqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HRw0nM+ngMAE6u8ALv623oDL1F1mp7li7piBbTWnJ98=;
 b=w4A3a/zZKuEeGeqz8d/W1Qx4TIbXkAtMNpBOtpd6BPzNhWiN+NEDxoT2vmZui3/cYGqify9UMilIvC3NZLV7//+vCAsvKVhS8q3KRVjcTIPKookdoDE1Ag8EggZ/Zj9YUuFdSsBftCL+ftni5kXZtg4C9Bfv78TV8kVLwyrKAIUoTk0aIJCGxMz3IbpUg0FpHjRLpgfwUCSuYKEGN4RjncaV3ayRL98bPPRElWBwi7t/n3KTn8q04mmwnJOKMJoH4lOUuPPA1sp2ad4mozlkbKHC1IUs0XDaqnYpxaEQcYtMg9RfP+gQeXoPxcZEo4DUP3xU4EtvpqdpaVe8UUEdJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HRw0nM+ngMAE6u8ALv623oDL1F1mp7li7piBbTWnJ98=;
 b=KYtdnDXiQaRnKJ9eb98BnsnQx/tg7iTwqStAs+4LOCVuFjsog2VSuR+2P2AwUSWtjdAqmECPATtx8I/NWWbbFU1tmGavZQKfKjaLhhKeggCQSRqJ4BARj0LGAFJICqBpYku6nKGl0976/AI/k3aYBGVhT1LXyXYV5vL68LVkQ6nfQuZPhOVnNEpo+Bv79rbX4EZ03kqpLIpTaqvJwFrB9KZmrk9uZ7+e9Duo/ypvKqFApgqG7DHsFET221fTOfPng0LyNSsdIoyC1KtJVTPMo819spBEd5Cmv69tDvuLPGyzORKxbVmRpQrEIwZyzPZYh0DnG0LTq3fe23zryhGNAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7788.eurprd04.prod.outlook.com (2603:10a6:10:1e4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 22:08:21 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.016; Tue, 15 Oct 2024
 22:08:21 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 15 Oct 2024 18:07:19 -0400
Subject: [PATCH v3 6/6] tools: PCI: Add 'B' option for test doorbell
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241015-ep-msi-v3-6-cedc89a16c1a@nxp.com>
References: <20241015-ep-msi-v3-0-cedc89a16c1a@nxp.com>
In-Reply-To: <20241015-ep-msi-v3-0-cedc89a16c1a@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org, 
 maz@kernel.org, tglx@linutronix.de, jdmason@kudzu.us, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729030073; l=1769;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=oLfeRG2JJa/EVak0ZqRbgfNgEQ6xhDK04ybgk4QBnh0=;
 b=ggtUqSjG0x79ltLdbRziV+1fQMtLGonP7mytNXC8zbANXa9FirOFw5AzTBQStHed8I7eXFU4x
 3OLE48THL6dDKyaXkJxOOuEoKxuWLFFdAQrxKVHBU+4XNxPUlWck2K4
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0059.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7788:EE_
X-MS-Office365-Filtering-Correlation-Id: c910bd8f-30d0-47f0-522d-08dced65e172
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TjR4RlFvWUxBSkx0bEZRSGhPU21JY01FamxJSXNuek9iRXpmSG5xOFdLRTY5?=
 =?utf-8?B?QldTdml6N2RiZVhwd21yWkt5RU9JM2V6TURjWHQrdWlUcFFwZmtoeEV4SllR?=
 =?utf-8?B?aWZnMXpqTVZGZjMxL25xTnVOZGVPMTlUVitNdEpacnNsQzg5cEVqOWpXNDVl?=
 =?utf-8?B?c3l2U3d6OWcvZVJhWUVMSEJoNVgvS3A2Qjc2NHB4dXlDRHFSRlo2am1iTGo0?=
 =?utf-8?B?MUVuYlF1UEZxN1FFV0tkL3dmZXl1WEJYUnhMQmtKM3UxZUZtMkc3VnU1NUxB?=
 =?utf-8?B?c0dqenFmbkg1aFBBcXlXTVFqdXpZbnFHOHJ3S21iUTdreEhrODRpUzczSDhs?=
 =?utf-8?B?cTI4czJ2anlEcEpSUU55YWtuSHBlTUhvWis2a2s0TSt0Y0tXa3pySHF1TS95?=
 =?utf-8?B?QTZFa0VOZ1JHV3oybHFvbmo1QzczMzVRM1VXRHJwOXFRbXJQQm1BbGpMamNl?=
 =?utf-8?B?M3VxdXNJWG5QRUwrMjc0VU1Oa1I4QWRtZG11bUhDT3hvcTF5bUUybVlOVGNN?=
 =?utf-8?B?WVMzRmYzWUhUMzJWdzFtZFMvb2xhSXNTd1pMSVhuUERQaXF3R3d5dWdtYUs2?=
 =?utf-8?B?WTdCcTB5N2loQnBMT3Vjc1AyQW5pOG9KdEpQR1M5czJPU0xCWkpEbXRNYXEy?=
 =?utf-8?B?Mm4yOHlaOTY3MkNHQnczdmZhdGFEc3Rtc1hxMUJwSXVBWnZxL0ZnYWU4aXhJ?=
 =?utf-8?B?VCt6TUppZGZiS2UwbHNrUm5QbEN4bW1iV1FUa0xhY09QNWp6ZFZwcmdPOHFT?=
 =?utf-8?B?aG9SZnI1bXIwMkJGUHJmZWFIc2JKc29lZXkvRHpOa3FmcC9vY3M5RXpsa1RV?=
 =?utf-8?B?Yi9JalYyMStwQzFmdVIzMzBvMnp4eEFCUHlETEZlK3hkdU0vaWRsN3hlUkFM?=
 =?utf-8?B?QVc1MmZSeWpCMUNROStRY2NDUGwzb1I3QlFhSG5IaUNDRDRYZUV6WC9NNExC?=
 =?utf-8?B?NUtvdnRuOHd5dFBrWTk1cCtINHp3YkVrVWMwc1pNK000cERQeDJqM3ozUGt4?=
 =?utf-8?B?UStDMWpXcTdRa3hWZWtUWDBaRUNvemphK1hoUmJ0djJ5b25EVTZRVlRWTlBX?=
 =?utf-8?B?NGlhTGRWRVQrb0hoTkxxUDRpbnFZZStqZmxyelRTT09ESWZ4OTR5SmZMZzJS?=
 =?utf-8?B?cHNjT0ZHakdSNDJtdW5COGZoTUlab2I5V3JEeWVoUVdsTm5rUUFIYTRJYVJz?=
 =?utf-8?B?QTZQZFMzS25FVlc5S2RkdkR0RTJrZlp2K01LOS9BdllyVGQxdEVUcFlHT3E1?=
 =?utf-8?B?WWc5L3dNbUtWT1p2U0EzZjA3aHFwcDVkMEd0TE9kb2FHR2NxMU9DVTNSaUxE?=
 =?utf-8?B?Zkc2Nmtza2wwWm9KV1hWNWZSV1hmNE1BQitiWWk1QjN0b2JFeW15cUgySVpE?=
 =?utf-8?B?U0lKQm9tWUY3WDZYTVpZSjd6QkcxeVNYU3lSNHBhaE1WNjVVSlVuNXQ0N0ph?=
 =?utf-8?B?MWFDdTVjbjNleFhEbGJLd1NqMWxLS1JRWk5MUEk3empRR2t0NHp4ME1UN1p0?=
 =?utf-8?B?TmxkQ2s2bGI0c1I4WFdjRGR1dGRrYVFWRHVnQnZyRmNzWlY1Qlg5Uzd5NXhS?=
 =?utf-8?B?eTVqay9QOWJCNDRUNWVZOXNPbFBaVTdtYngrUjJPanIyUnZGVEcwbC9nc2xN?=
 =?utf-8?B?RU9iZkpKTnhWS3BTRTVZOW5rbXJtMGJKaGlFZWRVODR1dVl3Z2NQOHhNQ3M1?=
 =?utf-8?B?TkJoUk5DbjVVNlJWVzVpVU8ydmVjWGs2QUVIN3dFVWkvTHFGemF3S05qKzhp?=
 =?utf-8?B?SXlZaEJjYnJWSDJCdXQ5WCtqSXozVGFRc3RLa0ROZGNySmVkZWludXpZRStE?=
 =?utf-8?B?UzN1WGJwaU80elVUMUh1dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z3B3bUwvcWxtQ0tYdFZLMHpvVGJ4b2JUV1lzT0o4U2UrVXIxVU5PYUR5SXds?=
 =?utf-8?B?bWZhaVpJTmpzOVFrYzdMT2J3WXVrekJ2cllJbUJuaVJxRmJ6U2N3SENMb1B3?=
 =?utf-8?B?NE4xNWxrTjEycG5MK2ZsQ3JqOU5IR29uTVY3bWw5N3dFL1MyU1V6Z3N6cmJo?=
 =?utf-8?B?anJscGVTT1cxNjFMWUl4R1dpOUdjVXNNemt6SUc1ekUxRFlTc01BZ29YNzln?=
 =?utf-8?B?U0ZhbTVkeTloUkZGZDlnYnJhOVlQYVJ5Q0pYVkw0bXpQL1JZV1pZOHc1NGt4?=
 =?utf-8?B?Vk4vbThZWlJSakhzM3FxcHNqVXhwQjBJcm80NVBZNC9DMXVDWDdjNk1Kb1FZ?=
 =?utf-8?B?MDVaYTJsNEIrN21DcjJLa0tlaHh4OURzOUJEb3ZrcW1zaTRYMzlGNGpwTXdI?=
 =?utf-8?B?N2lEdGk2QXpNOUNIU2NQY0Z5YzhuR1paVzJPTEFhbHFZcEpXd25ZMlpSclY5?=
 =?utf-8?B?WlRlbmprVVR3QkkzY1NNVGdzNzExbHNENk9ENEcwRTV5ZzQ0dzZzWVM3WXd0?=
 =?utf-8?B?bVpsZ2FQdDVkNG9hOVRIOUgvaSttYkNhdjlvZ3Z5enZMZnRQMks0bXpsYlhX?=
 =?utf-8?B?aGRJTkQ2R1J5YWFVR1hwZXg4YW5wb2tnUHhWcElMaEZhS1NGUldEcFZaTTc3?=
 =?utf-8?B?VENFd01OSkhFNTJiTmkvUWl4YjA3anMvVFAvQUFIOFR1L2lzWXN0MkRyOUpz?=
 =?utf-8?B?RHFlc1IwbE9VV3RBbnZHN290TmpjVEh6a09IaHhOZ1Q3eExkQjJMSXRCVHdZ?=
 =?utf-8?B?STZtNnA0MzNoeTFaclBOYnV3RnNrU1l5OFRsNlB0cEtyRWkyVGd1dHYvazRE?=
 =?utf-8?B?TTQ4YjI4VmRRSDZPZkNMRm5FeWs4TnpqNTl0WGwyWjd0aFcxOVJTN1RscUs5?=
 =?utf-8?B?eG1adGk0TXowSjhCaTEyY3NVaE1LUEtPTDc3RENZUWhzQSt1dXZlWEJ3TjJW?=
 =?utf-8?B?VWFVSmJBcWw1S0Z3SmxKanppN1JsS21GTEFGZkJrQ0xiWlRoeXZLQnN2b0wr?=
 =?utf-8?B?WEVXb3dXY25rK2dpaVRocjQrOFBZYVNmdUFBNmpvS21ROEUwQ2h2dGxHSk5t?=
 =?utf-8?B?azByZk5IamxPRStlZi9tRjlQbUpoNFhQZFdWNzA2Zlg2WnU3NGRPMGFpVUdn?=
 =?utf-8?B?NGoydHNrRkw4QjU4d3YwYU9vZVdZay9vd0JJOWM3MEpwTStDbzIzeDRlYUFl?=
 =?utf-8?B?bzBBTklndDBDUWE5bUhON0pVNzBxSXV1NVFnUUFCZ2xldmR1cFhxa0w2QlNp?=
 =?utf-8?B?Y0VNQWg0VnBhZW4rTlRzZi85ZUJ6QnFQeFRUbDJ1b1FTT3NZa2RidzVzM0dK?=
 =?utf-8?B?NURvTm5kcm5JRkIyb0lONEZHOUdqT1g0cXBpenIzUUhyRHdrcXdXNzc2N1F5?=
 =?utf-8?B?YW1ucFZoNlBIUFRrMlAzK0k1U3RRdXVQRENZeVNvd0hpcUFVYWw3SHM4QU9S?=
 =?utf-8?B?QWtLb1hjUTBZbDQyS1RLRVFKYmtHRHNkME0rUjJFQ25FdTJVV1NaQ0lDWWNy?=
 =?utf-8?B?MlQyelVNeEo1NHNkcGN2T1VpUWxabFJHeHJsaFFaUC9od0w0dWErNXB0Ymtp?=
 =?utf-8?B?U1I0Q0R6b3MyQk1ZSGR4ZlZybHlHOWovaGVzTTVjNjFFTFNBeVJyTWQ5UVVo?=
 =?utf-8?B?ZXh6V1JvaGhQcWZJelpMZ0dNTHhIeitYZ0poMlhNT3IyN0NFOXlxQWpNb2F4?=
 =?utf-8?B?cWRTWmorTm5aclozcGs4YzZHTVpRK0NrWEJzZlhVVy9FTU9tZ3J1NmlLTFlr?=
 =?utf-8?B?SUdtallwbm1NYndaWXNWZFBUMnJYTXp6bnY2SE96OFpmNHo1M0ZPZnEzQ3Jm?=
 =?utf-8?B?MnhMaE4vanhESUdVNEZnVEoreTZwMFNRdVV6bWx0enlyQTBsTGtSL045aDZU?=
 =?utf-8?B?a0JKNXpoTTBIM0I4YzlOVWhIajFKaTlhbHRSbjdrTUEvM2ZtNnBaYitLTHVp?=
 =?utf-8?B?N2lKbDczdlhFenZOSTA4aXNuWVhTeWpuL0JOVmdFSmNyYi9FenlCNUlMNzlY?=
 =?utf-8?B?NzZLWlc0ZEhEWXVCcG9xRVZqUHo3REszVWwxYUdPKzNJU1A0RlMwT0ZlUC9Q?=
 =?utf-8?B?MnFSZnN4TkpNcUx0dXVNRUh3Nkg4MWN4YnUvUGw3YTFHNm5lYTFSV1RmeS9N?=
 =?utf-8?Q?42YY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c910bd8f-30d0-47f0-522d-08dced65e172
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 22:08:21.0568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AQhKV8F1fCrWYN3UEyX2/sm+pn1RkrqftuCWNcMDAkQqoIhbYRrQlocwHyFweNArQobKSIJNG/XEeAWtxYYAwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7788

Add doorbell test support.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 tools/pci/pcitest.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
index 470258009ddc2..bbe26ebbfd945 100644
--- a/tools/pci/pcitest.c
+++ b/tools/pci/pcitest.c
@@ -34,6 +34,7 @@ struct pci_test {
 	bool		copy;
 	unsigned long	size;
 	bool		use_dma;
+	bool		doorbell;
 };
 
 static int run_test(struct pci_test *test)
@@ -147,6 +148,15 @@ static int run_test(struct pci_test *test)
 			fprintf(stdout, "%s\n", result[ret]);
 	}
 
+	if (test->doorbell) {
+		ret = ioctl(fd, PCITEST_DOORBELL, 0);
+		fprintf(stdout, "Ringing doorbell on the EP\t\t");
+		if (ret < 0)
+			fprintf(stdout, "TEST FAILED\n");
+		else
+			fprintf(stdout, "%s\n", result[ret]);
+	}
+
 	fflush(stdout);
 	close(fd);
 	return (ret < 0) ? ret : 1 - ret; /* return 0 if test succeeded */
@@ -172,7 +182,7 @@ int main(int argc, char **argv)
 	/* set default endpoint device */
 	test->device = "/dev/pci-endpoint-test.0";
 
-	while ((c = getopt(argc, argv, "D:b:m:x:i:deIlhrwcs:")) != EOF)
+	while ((c = getopt(argc, argv, "D:b:m:x:i:BdeIlhrwcs:")) != EOF)
 	switch (c) {
 	case 'D':
 		test->device = optarg;
@@ -222,6 +232,9 @@ int main(int argc, char **argv)
 	case 'd':
 		test->use_dma = true;
 		continue;
+	case 'B':
+		test->doorbell = true;
+		continue;
 	case 'h':
 	default:
 usage:
@@ -241,6 +254,7 @@ int main(int argc, char **argv)
 			"\t-w			Write buffer test\n"
 			"\t-c			Copy buffer test\n"
 			"\t-s <size>		Size of buffer {default: 100KB}\n"
+			"\t-B			Doorbell test\n"
 			"\t-h			Print this help message\n",
 			argv[0]);
 		return -EINVAL;

-- 
2.34.1


