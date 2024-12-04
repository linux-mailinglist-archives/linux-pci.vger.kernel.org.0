Return-Path: <linux-pci+bounces-17721-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1546B9E490D
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 00:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9163116A4A4
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 23:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BA52066E7;
	Wed,  4 Dec 2024 23:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mFuJBvSg"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2073.outbound.protection.outlook.com [40.107.249.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C6520DD62;
	Wed,  4 Dec 2024 23:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733354809; cv=fail; b=rmd07JO4VRiwNdeonvPe58IHo+tfVU2DIASNSPnV1ncXH+A/yGk86uVPjowNhuqb7bxlPNs74gwSCC1wMAQnhRoJ9Rz/QdedI/cyvJbifTB887s0EoIDlikNJn55C2Z5SPzo6KVenedwTjoJqg4ZjN1nP9GAApy4UrjpawnYNe0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733354809; c=relaxed/simple;
	bh=S6bUkKC71zBJp7IHbO4GuG6uvgNe6M508NIE6GRsW9U=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=M5G5rNcX8gOG5S2HvKTLBpEdEAvRAOvXW+SVwRP1Uz7bAUY5+p3+LvLOmRID3EUE+XcIEupDDZ9uHZutRdfHm/PJySiINtnQi83UnerwAr4Z+n+115LCt0pU5YyyJ9PnOWEU8dsDioFKPSdFmRYDnu8AvrZp6d1dLAzhr1nKlFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mFuJBvSg; arc=fail smtp.client-ip=40.107.249.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=caMJczLnsUTAUiirobbhocAhN1XwLZLKJn1LJoaNVct9jXeebETNtopdgDmOC82vNiyatK/9EigJurlHhDIvyq2FXPXdhY6ag8ddkbqe1ZdFGCc12rvoWiAp7X5h4Syfg7uZIl/UeUeIEDzSkCYhy/wquLL2MCy7+6KAPRliFL9ZkgxCJCzRBfQo3zCV8C/tjnTcrPvUQs/1/dRXNdi+C3TlUeHEP+mzbPhmVyzUItkZpKn9MLTiIXml0y/bqmLZtU83VifglrV+KU75vYeYAtals0wl4uZHz6TXkhqhKk4aVdh9HVqTbQL+qeEwPljH+Q1Wz7KZfDGRv8WxwvLfjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Ys0D8TZScX3vVPXKbIFuvzXjgAAPGsX81zM8YBV0jM=;
 b=cejqwZFs463dNcGRmw/tnZ7GPIEiTtDnjISFCm9xR2SUphnjMbPUnNp35eUNdtlTb6Trt9q7jzG703TYz1JyckBXV1ufZ8L7rVMf/NOsk5i4trDOt9+hQ+Mw8/53wADPb7CBF1sKfMHXDRgncdMlYKwmkuckjgOF/VADb9G7rtAar8ZRjy4R16wdM9urUN9fSi6LiD4LqCbRa2G+0+DWRHoCEdQKz06tkczDZrnYc2rwZubWEaSxZcijrJIEgCylSZZt6zjG1JQ0o7FaVL7U/q+lctfAJ3WlPUGYyk49q12yXZOubt1c3zBnLC+MdFAMNpwJXgvPPvFq/YCKAqQXvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Ys0D8TZScX3vVPXKbIFuvzXjgAAPGsX81zM8YBV0jM=;
 b=mFuJBvSgEi0F+ia2DIqDu5LMCTfuPaQWWpLUjxYe4P/W0ZIAp7R8FJWgNQgu77zqdqPKDAhbO/9jdPVqfRchX51tZ2HTvfwtIm/7QJ2l1s3kZpwBKT+4F/rtpDsN/Z6BHA7rWgfDs+/QFE+5qFOQaUOphkk3b9TmjCmrV77L/P/ISAUwte5KpFGmT2UDMBjyd03Hnsbfq2SRrWmXM8arf9m5S+zXETkIrdj/sHA9vfEtddzzuC2jUmYq6YjG38O3q4xmXjLb1bWQj5oDV8obnIBa/NdjJA+rM9gXMBYOMVScMIXHz9eABjOqjLarPcDhNm/W/wnDDJwnzv7Zrry11g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB11006.eurprd04.prod.outlook.com (2603:10a6:10:58a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Wed, 4 Dec
 2024 23:26:44 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8230.010; Wed, 4 Dec 2024
 23:26:44 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 04 Dec 2024 18:25:57 -0500
Subject: [PATCH v10 7/7] tools: PCI: Add 'B' option for test doorbell
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241204-ep-msi-v10-7-87c378dbcd6d@nxp.com>
References: <20241204-ep-msi-v10-0-87c378dbcd6d@nxp.com>
In-Reply-To: <20241204-ep-msi-v10-0-87c378dbcd6d@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733354770; l=1851;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=S6bUkKC71zBJp7IHbO4GuG6uvgNe6M508NIE6GRsW9U=;
 b=Av0cwUAZ3wAmQ8emQS5UbRcsGHW/DB1qBp2bj7ATNfb/vDkTin/deOgTOOxuGwL0vmvcfn5FE
 snon6iLIiUFAQIq+SR4H298z2XhbYkCkTIBmwu02Blx2C2Sde8unj/K
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0031.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::6) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU4PR04MB11006:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a1e17f6-cb89-4185-b49d-08dd14bb1db2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|7416014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MWYxeERXbGtVYVZ6eDJGRkxjRHBGQXF0THpqNDhyUG9VWlBVVzJpNG9JcHdG?=
 =?utf-8?B?QUo3dFdFbzkvem5jWHpQcWl0dUl3VlJ2b1U5UFQ3T2xrTjkvajBZZFNuenJH?=
 =?utf-8?B?dyt6c1ZNRTNOV09YdkIrNUlPNG1JQ3Nxc1lpVmxiZUREbHQ1VnBOeFU5R1hz?=
 =?utf-8?B?NmQyTlpHMGhiMEMwZTlOWDYzUFNpczFkZHFDTG9TbXZxR0VBSEdLcVROUkVu?=
 =?utf-8?B?SUtpc0lzY2krOFdZWStEYlVtMDRPb0dGYVdHbWFyMlhHaEl6eWlRYmQ4Sjlx?=
 =?utf-8?B?WkNvckRhT2Z4ZnJoUUdhSmZzUkhFY3FDdmEreE1YMiswVWI5a1d4VU9HY081?=
 =?utf-8?B?TG1Sa3pIU2EzcTgwb2Evc0s3ZTN0UkkzanZHMmFNTGI5LzlNek93Vm93cWxI?=
 =?utf-8?B?M2g5QXdQVGhYdHExSVJscnp2azNmZEpxRnlhWmFkWFI5WW1ma0FZS2lGOW5h?=
 =?utf-8?B?QUgyMDJnTWI5YlRVSEErSncweDByWFZJUWVIYzJ4SmFpN1phV1R0REZGTjFC?=
 =?utf-8?B?WlFML2pPZ21DM0pVZXFkeFgvQ0ZCUDNPU3plSVFYak9pVDBjVVpDMzZHVVdq?=
 =?utf-8?B?MGtTVnplV3NvdXdwbGJsM1pIN0lyL0toOHhDOEQzR1J1bGlmSG9XVVRpbDBs?=
 =?utf-8?B?S2M1YnlaNko3R2loOW15R1BEa3prcmNYQWJ3TDEvcHlaU0xqKzFGYXNDazZP?=
 =?utf-8?B?QTdpRzNkNXhDUDVOZ0VmcEVxcVlwcXhnbzBDQWFlTFhoNTNlL2RSUThJSHcx?=
 =?utf-8?B?cDcwNHVldTRUVkRYVFMyaTlWY3I3dUszV3Z2MmlIcFhnWnNsMTRaa1ZjWS9r?=
 =?utf-8?B?UjgzN0diaVI5Q2pMdDhEK3AyQWNwU1FEaEdvODh3M2RiYjltdFVRR0JybjI4?=
 =?utf-8?B?L0tMS2xVMXM0TDltTENHZDhxa3lPNmRHZ1B6RVJ6L1RKWjFCZFRsK0x5ZUEr?=
 =?utf-8?B?UkwzRXRaSzhCc0ZOcVlyZ1VDTXFyL1pmSU53enZFdVBjSXZScDV1ZkdvZEM4?=
 =?utf-8?B?dG01QVlENENiRXBBMjlST1ZGejRYTCtnMXJ2cTRFNGFlSWx6bjBPSWtVckND?=
 =?utf-8?B?bnhUcXZkc1VPVS82Y2NKQWJBNjluVllKOUhTbkRnWTF6YXhXOWRGcEdYQzgr?=
 =?utf-8?B?MHFzL0V4Vng0eHlGNlcyZVdHZWFZdHhEL0N6SmcyMmhVMGFuUmNMSkZkY05E?=
 =?utf-8?B?SnkvUlJudGtYWU1IbWNEeXc1SVhhcG1uOGtidUs0UDg0bjlqaCsrL2ZOSlpt?=
 =?utf-8?B?VUdDTWJtVUVBL3pVTUp4STltNkxLTEtWS3lvVGdQR09lQjRyY29RY1J0dTlO?=
 =?utf-8?B?M1pqN0Y5QjNIKzloeCsxTmF1eDg0TFVKSW92bTRiaUxBV0xXRU1rS3lZdjUw?=
 =?utf-8?B?WVJVSVVsWUh3cGEvZ09JU21Dd3A3dnk2Q3AreWNabnNGWDJValRTSEd2NHV2?=
 =?utf-8?B?UFRTTXNGM0tyREtUUW9IbC9vUTg2NDQ4cEJya24vSXZ6RFRmMUozNlB2MlRN?=
 =?utf-8?B?WnFXLzVYcC9BVy9QcHZFR29vNWE1TC84dnVFdjlxSlBwM0ErbEhteGZrckFm?=
 =?utf-8?B?T3pDMVZRb3V1eVN2cWt2SHBrZWU5QWlOTjYvNVpoeklOVUluYWVwQkV1NllD?=
 =?utf-8?B?MW1SVlcvR3AreHhKSkRkQ3RabHJ5N0xmZ2hmS3pid1FKS25HQWczbFl5dHlt?=
 =?utf-8?B?NGQ2U1hLekFQSm1NT3pqWjZUbUgxWEE3UTE3eUhNa09nc2lwWjJWMXcvK3dR?=
 =?utf-8?B?RGR1RUVNYlhCaitGdjdwQXJFdnoxU2MvRzN2bUdxck5ZL1B0TU1VeW00eWhn?=
 =?utf-8?B?NEl2dXlVSU81bmZ0TzZuazVPbktoWHBIcmdRaXlsMW1Wbi96WldIdnFvb0E4?=
 =?utf-8?B?M3dXa05NeFduMHRXZHljRTQyRzhBdm93WHArTUVHWFJqa1VhYmJWeUxYeWJB?=
 =?utf-8?Q?4SQmtoYylWk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmlzL1V6d1hTMEJCMGcwQkU2RHdDMDZNWkpadmV4STc3cklnTWtxdDl1dXlE?=
 =?utf-8?B?bWJhR2FXcWFIQzQxZFlLQzhDTGdaa0ZxTkJlNk1TWHE0anQyd1J3aUdDSkVq?=
 =?utf-8?B?UDI0T1lUcldEMXJsNmE4aVlWenpiR1o2QUlhaTB3UXExZ05RU1dRUlJCTTk4?=
 =?utf-8?B?Y1ltdHNhTktBZ3orbTdrTUxPdU9MTXhaZkJkTTJVUXRyODNpeERzS0pBeEN6?=
 =?utf-8?B?ckNrNHdSenVXVXZzY2JTL3AzTGlkcWQ3TUZLem9MeG1mL2ltL3dQa0t1WlJP?=
 =?utf-8?B?eEN6RzFvMjZ4VTE0QkdaNHMzQStCdC84NGFaZmdkVHgzTHBSNW5IRVNDdDVq?=
 =?utf-8?B?T09rZXV1Vmtvc1g5ZmVXWmVoZUpaMDVCZ3U5ZmhxaGtEcmRxK2tRYW5wUm1Q?=
 =?utf-8?B?a3hna1VXNmVtM2JVL3NJUjJ4elg1SGYxbmJlamFnVE43VEZqcWtYUDNXdjQy?=
 =?utf-8?B?MGYwZ29VeU5pbmU2bzV3NVR5VFZ5d1pReGlWYkdscGlyS000SGMwNmVscXRZ?=
 =?utf-8?B?SWFzVmpKMldsMjZPSElSS3ZwL3V2bW5Bakp1QTRtL0JzOFhjbHRhUExldG9L?=
 =?utf-8?B?bDdGWE9UU01YZDBVdm84VnNiVHJxSzdzamw5UEdTcUZhK29ZQUJoanExQnFv?=
 =?utf-8?B?THc0bjZNcE5hUzNKQUlJNVZMUENrUmFRVy9yeG42QkxQZWhpN2w4Ui9uQ0Ur?=
 =?utf-8?B?NVd6QlovQm5BK2ViVlQ0cG1ZNEd4Rm9YQmVab3d1aUdVSi8yR3JWSGVXaStU?=
 =?utf-8?B?SXZUZlJxbDZUdFVQUWpPQmxqa2tCMUhYQ0E1K3o4QmlUcHByWTFIYjZEV29M?=
 =?utf-8?B?NEV5VGFhU0tja21sMEhLdmVRMm85SnYraVFlZTRGYjFFYUlZcjZ2Vzh6cXlN?=
 =?utf-8?B?VVI3eGZUcDZEeVFkZFFMNEZPNDZGREcwbkVrWEhRUitjQ0YzVXVGdENOVUJE?=
 =?utf-8?B?R2taUTZaL2NObDMwMmQxWlUwaGZ3dElqYk0ybVJ1bWlDd1VHRWI0TE92bHZl?=
 =?utf-8?B?eGhSUGVFZnd3Qnc1MHllTXVFcWh3V1lMbGtydzJLeGY0WkU1KzE5TjJDOGQ3?=
 =?utf-8?B?SjFKME9VWkNRdlhjSHBrTnZsUnVEWVVxT3lCbEVaa1g3bG12RDk0YnN3R0w1?=
 =?utf-8?B?LzRNekdRQ2QwU29QN3pxZ0xKUEdXNU1ZbjdyRlBZZEJncURkcWVzL2UzTHZl?=
 =?utf-8?B?ckU5MTB3aGtybWhPUVVHQnhMMkpSeW9HblVGaW8zcWIwbmZGMU02OFB1SXFk?=
 =?utf-8?B?WG5DaDJXL2FpTjJud1k4V2xaa2EzajYzY0hEbStaeEhMQWRCck8vTzhNTmtt?=
 =?utf-8?B?b0pUc0FXVERqVlFkOFRSWTJxc05ra1lvZXo0NENkY21BM0c1dTBrT2pFbHg2?=
 =?utf-8?B?Z0lmOGx5WUJKS3lwQ2V0cHlsUllQZnk0ZHhlV3U1VVJ2SVhUOGZianFrRldM?=
 =?utf-8?B?QzlGVVp6dHBzMGNPTWsrS2xEL0hhWWdESG1ka2ZWRGxNbTNNUVdYNXBMdTlW?=
 =?utf-8?B?Qmo4MTVtQ0ZEclYyT3Q5Q1huS1k5T1RUL2F6OUlzaWRjUm9tMGRTdUE5ZVJU?=
 =?utf-8?B?T3R4MkR6Vzg2VHJvY0ZkYm8vQi9NT2RjUW5GbTB5dXNvV3FCU0Y0djg1QUlx?=
 =?utf-8?B?bERvQkt1Zyt4OVRJVzAyTTRxdE1JMXU3SlBBVGhnYTVoVHNqNGxnbisrRXVS?=
 =?utf-8?B?VHVhVzQzaU5YM0pvQ280U1c0WTZTSXBTYVRzUUhycFoyMTVZcVBmR1ZrR293?=
 =?utf-8?B?bmZWN2RDQlpHNkVFbVJ4Um5kSmJWNzJPZnYyaVRSVEd2b3VhNXRQOVRrV0U5?=
 =?utf-8?B?Uk5CUW84c0pnWGZOVDNDOTlMWWJsckpDSXR1S3ErZ3dWenJka3VZVisxNyt6?=
 =?utf-8?B?MkY3cXRmbjJldEVOOGJUMUs2SjR1ajNaUjJkNlJLeWVJNG1qVm5TbC85UHNB?=
 =?utf-8?B?a1BXckprWE9YR3pRRXJocUJTN0pkWk9qQ2xIZWJiRUZBRXp6U2tKeFNFS1VN?=
 =?utf-8?B?R1duMlJsZzcxVDREMVliSGMxNmJBdW5iOGNXNGN4YTFSZUdIOVlBNzdQZ2xn?=
 =?utf-8?B?YlpjaTNnUGdaT1ZXQzFER0lhVHhhVUxsdThaWWtIUk5Ec0loZXJQMUt4UXBk?=
 =?utf-8?Q?TMgI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a1e17f6-cb89-4185-b49d-08dd14bb1db2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 23:26:44.6967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SkcPZyQLhaitxai/QZRCz1JwvR7AiGWruKLhexrHT3oy8vdo2Utsp+ye9vpg27p+Zsmi9wL/FIjKlbz+w0Mg/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11006

Add doorbell test support.

Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v3 to v10
- none
---
 tools/pci/pcitest.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
index 7b530d838d408..fcff0224a3381 100644
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


