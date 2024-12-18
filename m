Return-Path: <linux-pci+bounces-18728-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59EC19F707E
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 00:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86C5616BAEF
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 23:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476E91A0AE1;
	Wed, 18 Dec 2024 23:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IEP1bSVK"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2046.outbound.protection.outlook.com [40.107.22.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A9317A586;
	Wed, 18 Dec 2024 23:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734563350; cv=fail; b=Glmy3dlSuOvB0nK3TeuCDLuvFRQoB9RdnzPcGWD9ShCiJphnlw79psYiKl97DIB17v8fkck9XHlEtKzwJhWbZgOt9HLRG/Ej8Ro/+Qc3evdP1LMN0mlZb1Y8+9ihC5MG7bLMHQUKA3TbdGvjre3j2X5sBPfuJiHq2Het40C2L+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734563350; c=relaxed/simple;
	bh=d3r3SBSPHJPR6mr4+o2/VcTEYo8LAIHnJR3CtSmnb0M=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=a/k8iTFcllw8bLpTxN7b0+uN5tAAbV0P4pDK52l//ZSdfK11MNq+HCbP1hLMIEFnsW8QsTRLKSxF8AO7X6wL9PAHBEbNsWd2/rOJEEPXr9+T9q5W9q6bWHG0/oilDRCAtrEc27rtIyPwYs0D2KMRU46g23CjMNTgW0RgdqlHOzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IEP1bSVK; arc=fail smtp.client-ip=40.107.22.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fvt8Fh2EYeZ9ecc7BU7GnUHhCHMrAYeFseJmCgBsbAI7ll5Cv5aAPv+r6Cw8Piyi7OkKpjRFaXQazm+4vsYBpJ+z54Gk00+/5Mvbtlv/Nv3epzpdqX9Z59muPIpnZWmxpz/CcLjYqvdNVDPfrdOX5RRNgJE6L7twgjp+IBq8gzbul7PgZnxZMqbZ4x6MCtcdHiKJbZGohtepoWY0EKZAv96Re7rjnWAAoYcR2Zs4/q2iKUA+OMrio373OsK49cV71sxfTBflJC+jO74G6V256TNBE7cCKZMqw2MssOn5Wr6VAPp3IyWoXP0NZ1zXbL3t6QWBy/bXUBKz17yt5pHRMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pvh3HQn4F1mqbxQuw2ZdzdEMcN6uLN5sN7763d3nzKo=;
 b=X/EKvPAytpbgaNRijpHuRcJCDEgRYX+1Bf0H1fou8sVfF5f0NGIwG5S7wC3Ls7nzlV3zndcf7jSaaVay2uoKyoQa1ms+XTI1bXBzxTjmdoDTg4OajkL2Kw/RQi3O5BRQV12Ip/QOiSFGzgEId1aiQbHa3iguSjjmgYrFZF3TOF2kB5kyog5EEeh0lR56bthO7PpKYxKp/ydekjfkObUz21PCnac7IEIH49rlQ0LR109ytMpiLgG64J0ZwdpaRNAq8dhmP1IoAZBlvolRKHV50wTSRiwSz8m4wQDBSNe6sCafKEv8nodO2nGi3QUNirF1ez7Q4foZLE5iUdA5wsZOWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pvh3HQn4F1mqbxQuw2ZdzdEMcN6uLN5sN7763d3nzKo=;
 b=IEP1bSVKW+NKFbQe31afBMB/nrozD9M9am9sqZJ1GNP4olHubYKxXzXgt4J3i4XAR9TA4mrkTNLV3sYLgr/Jw551/onhGHv1WM6r7ENWJVHzO8/pl2hYvs8NK56GV6vszpV9bFZKzPRUKDF7660/2ILuBwJifbw4xjj2ZHiAppGm2f8P5afOtENHVtCUu6OK2TtADeRb4eG9RCLrgSozEyqXNBVC8m15f9kCgEY0p5TDqpDraTEgr5bLs5qWrOF+x4vmAVrbKKeB6uRl6K/puk/Ur5MTMv0khzFMS5lVq7isXEe0xMdcRMtckjpHy/TSv5hUwBsCPVwxqjaZ4C2IAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB9939.eurprd04.prod.outlook.com (2603:10a6:10:4c4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Wed, 18 Dec
 2024 23:09:03 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8272.005; Wed, 18 Dec 2024
 23:09:03 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v13 0/9] PCI: EP: Add RC-to-EP doorbell with platform MSI
 controller
Date: Wed, 18 Dec 2024 18:08:35 -0500
Message-Id: <20241218-ep-msi-v13-0-646e2192dc24@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPNVY2cC/13RO27DMAwG4KsEmquCFPXs1HsUHfRsNCQx7MJIE
 eTulQPEljOS0PeDIm9symPNE/s43NiY5zrVy7kVSG8HFo/+/JN5Ta3BBAiJgMDzwE9T5TbI6AN
 RwJBZezyMudTrI+nru9XHOv1exr9H8ExL9xmhnhEzceAxp2idRx3Rf56vw3u8nNgSMMsOEa5IN
 mTQJC+Sc0HYPVIbQrArUg15lE5hhARg9kh3CMWKdENSFWeEyBTFy3imR3JFpqEkfTTel5BE3CP
 bI70i25AuWLQtJWEIe+Q2JIBW5JY/aUghUkGV0h4h9Gqbr10QuDWRjG0y6VeGPXMbw2XtkmTxl
 pwJr0x0DLdjtW0CJ0pSkSheCdjY/X7/B3yPBbd+AgAA
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Anup Patel <apatel@ventanamicro.com>, 
 Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org, 
 jdmason@kudzu.us, linux-arm-kernel@lists.infradead.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734563338; l=9426;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=d3r3SBSPHJPR6mr4+o2/VcTEYo8LAIHnJR3CtSmnb0M=;
 b=bjQ3amKtxVLteI32qaSg6Rbv2JYYI5NTslKj9YSK0oHEbBIv29dZLTXybrgI93osPXj5EzJJW
 0UX7R/7rSmpBYmgu0b+6M//fFZ+12iF1Dq8U4WQwiT5Iy5hXIvBs4Ir
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0075.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB9939:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b9f55ad-746d-4b6b-ca16-08dd1fb8f6d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S3JXUVd4c2R2SEVYNWtNTDVxaDBIUmpLMW0vRDZUV0tCREZ1Q3J6ZnBaUEJl?=
 =?utf-8?B?Y2pmaTJ3cGZDVDZZZTUyU2k1THRaL3hkQm8zMHJ1TkFmbWxxT1JrRjBrQTdx?=
 =?utf-8?B?NmRMYytaNjdSdGMxUTZISzYwdnFvalZTajlMc2x1eUZSVUhHWUNEOTVvM1kr?=
 =?utf-8?B?ZXp2QTZMU0VuazlOM0NYVHQ1SjBoSGs1bEZOdWQ2UjVEQXRDNE9RRWpPcFgz?=
 =?utf-8?B?SnMzT2hvU2VSazIyaXlrdmN3b2JWaE9JTGgyZnJSbmJQZW5KTTUwTUYrQ0ZZ?=
 =?utf-8?B?YWsyVjRmZWJUTXJJSmN3MTVvZlVBWllwN3pYeFhTOFhoNEp2UGxQeDg4MTlR?=
 =?utf-8?B?UEtTTWtuMVNsOHZXZXdsZzRyVVdQR1gyMEpFallJaXlnNlEvL242R3VIVEFr?=
 =?utf-8?B?Y2JGcVQyK3d5RFk3UThHSS91WFRVSVdpbkJVUGZ5Z3J5NW5sNG10VU5PcWV5?=
 =?utf-8?B?OVJ0dkJlNWJtRE13VzR6R29QNEpUcHNuYmlwaHdLKzVwMThGRFc1Qmw3ZUpF?=
 =?utf-8?B?eURlNzV5blBQZS82UVZSVzM3cWNsSlhzWVVXSlhSTm9sYjdRRVF5d2I0RGNZ?=
 =?utf-8?B?Rk9NN2NucFlYZGpKRW9nd1VGOE9CZ3l3N0FIMmlFKzk0YVltNWFKSlNNR3Qw?=
 =?utf-8?B?dUtpTDJYRzZQa2JIYUx0WEp1Rkp5MzBvaW9BRzNSYXVkbFRaaTF0SDk5NUk2?=
 =?utf-8?B?cW1TUGdwVjJNSzJLUHNJUEdIcm9sL3NqbWs3cmkzcmZwaDdPaDczb3BOVUxt?=
 =?utf-8?B?R0tZZ0VFc216RS8zbm5ZNmd6SUlHZm1HR2ZXaVBTWXJWeFI4YTVsTTl3ak1j?=
 =?utf-8?B?bXdNL0xiZzBML2I4OEZiSkl2RGFza1NaS1crVFgzbGVyN3lXL3pZUnpORjJD?=
 =?utf-8?B?WEtFTGdyUngyeFh4UFpET3g2b2IwbTlDdHgzV0ZmaGhkRWtSWkNqSXhPMnNo?=
 =?utf-8?B?SkFiMEVXTXhCUU01ZWhmQTFDWFh0MEZuOEc3bkRSMEpLT3pOMGw1WGc0ZVhY?=
 =?utf-8?B?S0JaUFl5NGVSdUdMZmxZYk9ZQTYrOFV2clJVNk4zaktaaG5RU3V2UjdHSG5G?=
 =?utf-8?B?UUIwWEd4b0N3THMzS3FhKytMV3pJTXJ4c0M4NHgxZTM2bDNITERORm9pQUwr?=
 =?utf-8?B?TE9RWVJIUmFid05FWXhKd1RLdjVZODRHVTNrTGJSM2g0RUxlL3d6dFJoQ2U1?=
 =?utf-8?B?d3ZVSkRrMzVJZHU1N0dZR0h5c3JLRHhaN2ZJODg1THNkRFQ3TS9WQ3FqcWRO?=
 =?utf-8?B?UXFMaEhiYkZ1N3BuUU5CZ2gyMlloVG8wUERFQStzOEZQSjFyaHNnUWNaNlNq?=
 =?utf-8?B?SDBERlJxckdJMmNSR0FJVjQ2WmFEa2VCTmU1UDNNbW5mam0wRkM0Z05jZ25t?=
 =?utf-8?B?VXU2UVpIbzlVNTZkbGJKYnBQcXJJaDArQU1LRGtNalQyVlVhNVZWaG1PUkJ3?=
 =?utf-8?B?azBrRW5CeGVIelBocUNpeHN2UWxiN3I3TytyajUzbWx2TUlFa2tOcnRZWTNk?=
 =?utf-8?B?clNVYTd6SHZ1RUI3NEJJamxaenRvVjBuR0FJd0h1bnRFeVhramg2Q2xtUkdu?=
 =?utf-8?B?NnFnY24wWGpKajIwTWdFbnlXVEY3UkkvQkg1Nm95UW84dW1NYkpUSGdyT0Q2?=
 =?utf-8?B?N1IvaEhiNlNOcmZlMlZkTlNCM0VkblZURDRaMDE1Q0trQ1NwMGpQZnhvdS9X?=
 =?utf-8?B?NDdkUkdJMkxpSFZNazFRYkxtRm9iVEgyRitqREQ3d3ZjSHJYRkVZWlZVNVJy?=
 =?utf-8?B?TnNNWElVRjRuYmFtUm5KRGd3RFRRd3RhMUtwOUdwd0hWNTZYNjNlanUvOGhV?=
 =?utf-8?B?VElSd3p0NGNhOVVCYkdBV3FTVDhPZ0VFSlV2ZnRxN05YaEdFaVZlZFlMcmZp?=
 =?utf-8?B?NVJZOHgxWlhESGJCQTh6RmxOSTdpTmFxTUlNcy9SbGJmTUVha3lBRVhHTUFu?=
 =?utf-8?B?NU9MaG81bkFxV24rTDAxejRCK0ExU085TkQzZWxCQURndmp1eTJCZDJVY3Rz?=
 =?utf-8?B?WFJCN1lvQ3l3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QXhES3lkSEliWUU1akJsVldxeHptdW5yWVVtL2tPLzZqbE1iUXkvZVN4VGRH?=
 =?utf-8?B?R01EWVJtK0Uzdi9wZCtDeHljUS83N1o5VkNKZzJScnFRMUZZeFhHR1lZb1k4?=
 =?utf-8?B?K1hzenFEbWc1dFRLclJDMzFQQVJXSVNxLzN4TjZMU3FPTmxvWHRoTnFqYnRU?=
 =?utf-8?B?Q2Z5VjdqWGNXd05uR2djOWN3a3hHejBiRDFENWhIVURvZ1lRS29seEVyaldz?=
 =?utf-8?B?Z1oya0lIYVBrK2I5SjZhQkV1dzVWbGpQa1B0dmdBS3g1RE1YdzNaMnhUNVNG?=
 =?utf-8?B?TWlFclliYmpWblBEckxTeXkvQjYvbkNzM3FwdVprOVJ0am5JMGUyMENMdDJm?=
 =?utf-8?B?dGR3WU1UQjVhS0pISC8reHl4V0R1QTJRK0s1K2t3NlpWdFhWcDU4akxDK1ht?=
 =?utf-8?B?QXBiTDJmaE5KMWRZK3l3TjNkSXYyeUZTUENSM2Z5amhiYndRTk5IMm1EM2Fw?=
 =?utf-8?B?Y3E4c09uN2lEdVF4SkNnQVd4V0ZWbU9LSHZLR2pHR0tjQm53MUpNTnlWZVND?=
 =?utf-8?B?bVNGWHVvWEQyRHRZaThvc2xJSW9HbEg3STBZbldMSGR5M0g3dFZmYmRYMHV6?=
 =?utf-8?B?VGxjNi9ndGZycnd1ODZMS3FUSXlYRDlRYzFBK3pjcHdqTnNjQldzVS9JdXB5?=
 =?utf-8?B?Y2N2NzNCY0dneUhyb25aQnUzQkZPYzZtSStVMFcxL3VvZW9TbkRJQkI1dklO?=
 =?utf-8?B?bWtpcjhiWDQraS8wWG5CbFg5aSttZHU0bEd1aHJNVzZERm5jYkJSSHVzSzF3?=
 =?utf-8?B?YXBRc3hrY2ZxNTF2WDJKQlQ0Z1NEMXFpcFlhTlFNVWEzbHVSN0o0Tk0yVmd4?=
 =?utf-8?B?U2JDUUIvVmxEblJxR1ZPdEFwVDJGVUY2cW96c1FUUDlSRnNtblJvR2dlL0ww?=
 =?utf-8?B?WW51YzNBNDEvbVNDQjQyMXJGc1Z4MksvSEV3Z2NLaDg2Zzl4Y2YwSk1MbWkx?=
 =?utf-8?B?dS96bGZsVVhCS1NYdGQ3dVE5RmlnSnF1R1U5a0xDT2drcTcyOFdsQUlUSk1P?=
 =?utf-8?B?UmxCZW4yRTBtUnlyWHZVbGJwK1AyZ3dVT3Fqa0krL0pvOUp1VndiV0tFcnc3?=
 =?utf-8?B?Nnk1S0pmTkhIY1FlblZ4QjNtVEVRaEF4eVRTemVEL3VoZWhNcEtYZ24zMzZP?=
 =?utf-8?B?RTM1VlBiZUxkS2NLR2hBd1YrY1J3OFJsQzlEWGtuRG1ub08yRVRWTEdxN1l6?=
 =?utf-8?B?UlhOUUpWNmdFNUhYbFBFTSsxaEliMkUyRHFPbm1WcW4zK2xkaXk3QUV6a2R3?=
 =?utf-8?B?a3J0NVVTaVd0WXlXc0hIbEhGR0w2cnBhL0tFK0F1eGRwUjN0ZXh4VFBHbWFS?=
 =?utf-8?B?RDgvckorWjlSaDY3YmY2eFF4eU95VXIxTHpkc1JqNEhoby9PRlVBYVJHYzVi?=
 =?utf-8?B?WG8wNFVzajNONTJ5bnJKTG5BUEpkK3B5dW5yTjdiYWZhc2txQWpqS2d1UHlZ?=
 =?utf-8?B?M1Q3RTRKRFRtY0NHSXVXK3lJTTNjK3NQWTFYZ2djRDJyaU92YVVsckVzWWtx?=
 =?utf-8?B?ODJaM0U4dUNBT3BzNHMyZUhueUpiQXNBTU54enJFTm5FVFBQQ09iOHBRNmJt?=
 =?utf-8?B?Ukh5cHFpVHFOUjNmL09VcDAyaFhtUFdENjZuRU9pY0tuOFVsakN2Z0VhZTZ2?=
 =?utf-8?B?eHJEVGtzcWU1d1Z6djJ2Z2JPZEw0WTJwQTNJeVdHWUNqclNPQTJlQmVkZzF0?=
 =?utf-8?B?OGc1SkxQTmVpTE1pdjhuLzdtejQ1dUQ0WFhVV1FwTncrY2xCNUFPZE5GUFhL?=
 =?utf-8?B?eDZQVTA1NDNvSVZlSW9Rek5uN1hWZWZsdWR5amNNdEZiK2R1WGlLNlZ5VVp5?=
 =?utf-8?B?MHVGMncrSnplUlZMODJhZXhpRnRCcTJmc29jMG14RExJaWFvOGVLOHFveTAr?=
 =?utf-8?B?dm0zTW5pY1FnQktLakRRbVV5NXNtSERsbkpMSEhZTEE2amJiMVlkQzJ5elpW?=
 =?utf-8?B?d3NyVGZNdEh3c2dZTkhCUmx4OGU4cGNqODQ3ZmlMQ1gwRzc2c01nMThVeVZR?=
 =?utf-8?B?aXk4aTVWekR0YTliVlJvMVRNNWlQczNQZEtLdjVxYkRGakljSVZnd1hZWWRF?=
 =?utf-8?B?TDd2dmFCelh4bFRDWVdpRURJOWlHTzBWNXdackh4a2xpb05VRWV5WUVveWNy?=
 =?utf-8?Q?GfRA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b9f55ad-746d-4b6b-ca16-08dd1fb8f6d7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 23:09:03.3529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PilMQAp8ctjAEBzo2uBCe5+IGX14rAlxArkTSHsgCfR9exbzIRhTlmrxi+LkSChVRwWmYRuzmAgt0DfGS34u8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9939

┌────────────┐   ┌───────────────────────────────────┐   ┌────────────────┐
│            │   │                                   │   │                │
│            │   │ PCI Endpoint                      │   │ PCI Host       │
│            │   │                                   │   │                │
│            │◄──┤ 1.platform_msi_domain_alloc_irqs()│   │                │
│            │   │                                   │   │                │
│ MSI        ├──►│ 2.write_msi_msg()                 ├──►├─BAR<n>         │
│ Controller │   │   update doorbell register address│   │                │
│            │   │   for BAR                         │   │                │
│            │   │                                   │   │ 3. Write BAR<n>│
│            │◄──┼───────────────────────────────────┼───┤                │
│            │   │                                   │   │                │
│            ├──►│ 4.Irq Handle                      │   │                │
│            │   │                                   │   │                │
│            │   │                                   │   │                │
└────────────┘   └───────────────────────────────────┘   └────────────────┘

This patches based on old https://lore.kernel.org/imx/20221124055036.1630573-1-Frank.Li@nxp.com/

Original patch only target to vntb driver. But actually it is common
method.

This patches add new API to pci-epf-core, so any EP driver can use it.

Previous v2 discussion here.
https://lore.kernel.org/imx/20230911220920.1817033-1-Frank.Li@nxp.com/

Changes in v13:
- Change to use DOMAIN_BUS_PCI_DEVICE_EP_MSI
- Change request id as  func | vfunc << 3
- Remove IRQ_DOMAIN_MSI_IMMUTABLE

Thomas Gleixner:

I hope capture all your points in review comments. If missed, let me know.

- Link to v12: https://lore.kernel.org/r/20241211-ep-msi-v12-0-33d4532fa520@nxp.com

Changes in v12:
- Change to use IRQ_DOMAIN_MSI_IMMUTABLE and add help function
irq_domain_msi_is_immuatble().
- split PCI: endpoint: pci-ep-msi: Add MSI address/data pair mutable check to 3 patches
- Link to v11: https://lore.kernel.org/r/20241209-ep-msi-v11-0-7434fa8397bd@nxp.com

Changes in v11:
- Change to use MSI_FLAG_MSG_IMMUTABLE
- Link to v10: https://lore.kernel.org/r/20241204-ep-msi-v10-0-87c378dbcd6d@nxp.com

Changes in v10:

Thomas Gleixner:
	There are big change in pci-ep-msi.c. I am sure if go on the
corrent path. The key improvement is remove only 1 function devices's
limitation.

	I use new patch for imutable check, which relative additional
feature compared to base enablement patch.

- Remove patch Add msi_remove_device_irq_domain() in platform_device_msi_free_irqs_all()
- Add new patch irqchip/gic-v3-its: Avoid overwriting msi_prepare callback if provided by msi_domain_info
- Remove only support 1 endpoint function limiation.
- Create one MSI domain for each endpoint function devices.
- Use "msi-map" in pci ep controler node, instead of of msi-parent. first
argument is
	(func_no << 8 | vfunc_no)

- Link to v9: https://lore.kernel.org/r/20241203-ep-msi-v9-0-a60dbc3f15dd@nxp.com

Changes in v9
- Add patch platform-msi: Add msi_remove_device_irq_domain() in platform_device_msi_free_irqs_all()
- Remove patch PCI: endpoint: Add pci_epc_get_fn() API for customizable filtering
- Remove API pci_epf_align_inbound_addr_lo_hi
- Move doorbell_alloc in to doorbell_enable function.
- Link to v8: https://lore.kernel.org/r/20241116-ep-msi-v8-0-6f1f68ffd1bb@nxp.com

Changes in v8:
- update helper function name to pci_epf_align_inbound_addr()
- Link to v7: https://lore.kernel.org/r/20241114-ep-msi-v7-0-d4ac7aafbd2c@nxp.com

Changes in v7:
- Add helper function pci_epf_align_addr();
- Link to v6: https://lore.kernel.org/r/20241112-ep-msi-v6-0-45f9722e3c2a@nxp.com

Changes in v6:
- change doorbell_addr to doorbell_offset
- use round_down()
- add Niklas's test by tag
- rebase to pci/endpoint
- Link to v5: https://lore.kernel.org/r/20241108-ep-msi-v5-0-a14951c0d007@nxp.com

Changes in v5:
- Move request_irq to epf test function driver for more flexiable user case
- Add fixed size bar handler
- Some minor improvememtn to see each patches's changelog.
- Link to v4: https://lore.kernel.org/r/20241031-ep-msi-v4-0-717da2d99b28@nxp.com

Changes in v4:
- Remove patch genirq/msi: Add cleanup guard define for msi_lock_descs()/msi_unlock_descs()
- Use new method to avoid compatible problem.
  Add new command DOORBELL_ENABLE and DOORBELL_DISABLE.
  pcitest -B send DOORBELL_ENABLE first, EP test function driver try to
remap one of BAR_N (except test register bar) to ITS MSI MMIO space. Old
driver don't support new command, so failure return, not side effect.
  After test, DOORBELL_DISABLE command send out to recover original map, so
pcitest bar test can pass as normal.
- Other detail change see each patches's change log
- Link to v3: https://lore.kernel.org/r/20241015-ep-msi-v3-0-cedc89a16c1a@nxp.com

Change from v2 to v3
- Fixed manivannan's comments
- Move common part to pci-ep-msi.c and pci-ep-msi.h
- rebase to 6.12-rc1
- use RevID to distingiush old version

mkdir /sys/kernel/config/pci_ep/functions/pci_epf_test/func1
echo 16 > /sys/kernel/config/pci_ep/functions/pci_epf_test/func1/msi_interrupts
echo 0x080c > /sys/kernel/config/pci_ep/functions/pci_epf_test/func1/deviceid
echo 0x1957 > /sys/kernel/config/pci_ep/functions/pci_epf_test/func1/vendorid
echo 1 > /sys/kernel/config/pci_ep/functions/pci_epf_test/func1/revid
^^^^^^ to enable platform msi support.
ln -s /sys/kernel/config/pci_ep/functions/pci_epf_test/func1 /sys/kernel/config/pci_ep/controllers/4c380000.pcie-ep

- use new device ID, which identify support doorbell to avoid broken
compatility.

    Enable doorbell support only for PCI_DEVICE_ID_IMX8_DB, while other devices
    keep the same behavior as before.

           EP side             RC with old driver      RC with new driver
    PCI_DEVICE_ID_IMX8_DB          no probe              doorbell enabled
    Other device ID             doorbell disabled*       doorbell disabled*

    * Behavior remains unchanged.

Change from v1 to v2
- Add missed patch for endpont/pci-epf-test.c
- Move alloc and free to epc driver from epf.
- Provide general help function for EPC driver to alloc platform msi irq.
- Fixed manivannan's comments.

To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krzysztof Wilczyński <kw@linux.com>
To: Kishon Vijay Abraham I <kishon@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
To: Arnd Bergmann <arnd@arndb.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: imx@lists.linux.dev
Cc: Niklas Cassel <cassel@kernel.org>
Cc: dlemoal@kernel.org
Cc: jdmason@kudzu.us
To: Rafael J. Wysocki <rafael@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
To: Anup Patel <apatel@ventanamicro.com>
To: Kishon Vijay Abraham I <kishon@kernel.org>
To: Marc Zyngier <maz@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arm-kernel@lists.infradead.org

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (9):
      genirq/msi: Provide DOMAIN_BUS_PLATFORM_PCI_EP_MSI
      PCI: EP: Add helper function pci_epf_msi_domain_get_msi_rid()
      irqchip/gic-v3-its: Add helper function its_pmsi_prepare_devid()
      irqchip/gic-v3-its: Add DOMAIN_BUS_DEVICE_PCI_EP_MSI support
      PCI: endpoint: Add RC-to-EP doorbell support using platform MSI controller
      PCI: endpoint: Add pci_epf_align_inbound_addr() helper for address alignment
      PCI: endpoint: pci-epf-test: Add doorbell test support
      misc: pci_endpoint_test: Add doorbell test case
      tools: PCI: Add 'B' option for test doorbell

 drivers/irqchip/irq-gic-v3-its-msi-parent.c   |  49 ++++++---
 drivers/irqchip/irq-msi-lib.c                 |   4 +
 drivers/irqchip/irq-msi-lib.h                 |   6 ++
 drivers/misc/pci_endpoint_test.c              |  80 +++++++++++++++
 drivers/pci/endpoint/Makefile                 |   2 +-
 drivers/pci/endpoint/functions/pci-epf-test.c | 132 ++++++++++++++++++++++++
 drivers/pci/endpoint/pci-ep-msi.c             | 140 ++++++++++++++++++++++++++
 drivers/pci/endpoint/pci-epf-core.c           |  44 ++++++++
 include/linux/irqdomain_defs.h                |   2 +
 include/linux/pci-ep-msi.h                    |  26 +++++
 include/linux/pci-epf.h                       |  19 ++++
 include/uapi/linux/pcitest.h                  |   1 +
 tools/pci/pcitest.c                           |  16 ++-
 13 files changed, 507 insertions(+), 14 deletions(-)
---
base-commit: fb32deaabac5c9ac8e555fad420113348cea8bc2
change-id: 20241010-ep-msi-8b4cab33b1be

Best regards,
---
Frank Li <Frank.Li@nxp.com>


