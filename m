Return-Path: <linux-pci+bounces-16352-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 794E69C25BF
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 20:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D9E328299A
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 19:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6541C1F13;
	Fri,  8 Nov 2024 19:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="auyPESZV"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2054.outbound.protection.outlook.com [40.107.22.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39241C1F10;
	Fri,  8 Nov 2024 19:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731095032; cv=fail; b=N7TrieuE0EGhBlQ/Gg9+Ut/4bGkHbxM/xm9dRGAPDcfoExIu4WVvqeYSJOiwvc48KG1ya5lFSBXoF0zhpGRQ+liMSPW8b2X6TiWUJwI65hryyiO7ppzbEjLiAnMd4hPw8vFTrMDbum8yUsIc+hMoHKnewWNiRqV9FRlwXm2aW7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731095032; c=relaxed/simple;
	bh=ntXiaH4l2kp/wWKknwkD8PPeio91jKJpNZWJm8X7L2s=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=S9LfbAmaV/DeB2Cj7aUKSeVO9wR5WdINvz6mXVOoxcOAHj2ssMfKM13MjHhuO5ASCUINrdZM8uA4GDLg+Ls+dPnb2r2KVymsQgyf11gmL09ThXCdJ8BSxDWDHfvLSJRD6VAov6z7BS+74i28X/I6BRZY5ZDd1QqEGHEyCFOr7hc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=auyPESZV; arc=fail smtp.client-ip=40.107.22.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dSSJYdy90T9dgDdu/R9a4nZvQRJxyTPGk43NnX4R0tW3YE9XJESYpGt7MDkto9hLUsCP5V3y4wkQXOm+IsjT+xo5kShMySbOCceeFNbYCEGpcyOOeSkvfHSxpqGrFISum3yfTFOiRhZCxT+TB8kADi+vH64zxjuFwDTcNr2OuqqzYJJZ/GugglskPHDRy07nd5KkWKUyjdyVFjDuh+Xrl2nV0jTeWBKRGMLK4R/PlYEhhE7dYOXKTVypzdwtYMbqH3IHEPRQ7urwF8yvoNg+k6YaD2BD1kyogMvZKwJiZ4N28KpQqSxkeTOvjRi7gE/HUdjMZOJ2WrPqV4LVhE8ISA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bAA7p7B3ly7BYYc6jadPjFBJhEgAzZ6m3MyFJkUrKUs=;
 b=DKD8qAQWCCMfpQG6wNCSgv5+mewSZuV71R/sxt5q1yfYUqJyW/vKe1WNWrdOVF7rSHWLZYqu62OSd8xCrxOr+LOZodYwDYb+gRpGUb3ABdG0STIZJhoHtVR3yAC7ZLwqCh7DA3gKu5PEyMFN5frvTprXnel3tSQ1MmA8o3eVells1mJokgoC8xcppOjwWaXRTiuyJML05g/GPeJmqDeyH+aa1aPmwDlD1HhH/oPRf0i+oJNYm7LZ3Ni+S/rebQz66CaCyEGfRrMqzIXaJ+zFihsiVyxo/37HrvGGmvw4KuRcwZLAwKvjlqWXyNatX/47QDy9kic+Rj55xc4yCrtwnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bAA7p7B3ly7BYYc6jadPjFBJhEgAzZ6m3MyFJkUrKUs=;
 b=auyPESZVY5EwoXhMBIrjnQV04SDmV1Yv7SXfe0mcRUWkVJxfZrk+oMUo3Rvbuyi7VqqoasZ4GGJy316UJhq6S18KDQ599gGDH5QuZcvcUJWJiD92xDET1Oe6ZzjvKuhUaLJE/LZ4XvLRRhnsrcB5eaApcW6zk2AYYPtk1PehylRuYZgruLoBNHb8UloKPkr46thGjFsrbDXX1tKiC3tdkISdnvUDMWK2rT9Zi6fZmlfqVurN15JOsxiUpnTIwFV25Tk3LVDhtIhQNKrwtdJd/rwsQQ6KfOORoJXhy2ePThUfjm9idJtmGiaM72MrCqXl3C51DmiFxylrFbjaqfN/bQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8669.eurprd04.prod.outlook.com (2603:10a6:102:21c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Fri, 8 Nov
 2024 19:43:45 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.021; Fri, 8 Nov 2024
 19:43:45 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v5 0/5] PCI: EP: Add RC-to-EP doorbell with platform MSI
 controller
Date: Fri, 08 Nov 2024 14:43:27 -0500
Message-Id: <20241108-ep-msi-v5-0-a14951c0d007@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAN9pLmcC/02MSQ7CMBAEvxLNGSOP7ZDlxD8QBy8D8SGLbGQFR
 fk7TqQAx2p11QKRgqcIbbFAoOSjH4cM5akA2+nhScy7zCC4UMiRM5pYHz2rjbLaSGnQEOTzFOj
 h5z10u2fufHyN4b13k9zWI1EeiSQZZ5acrRuNF4v6OszT2Y49bIGk/iSJX0llqcLKaeGaxoj6J
 63r+gFJjzgXzwAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731095022; l=6249;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=ntXiaH4l2kp/wWKknwkD8PPeio91jKJpNZWJm8X7L2s=;
 b=2LmAv7zvFlwI+4kDE/tLxeBnzRUEP+VIZvrrCAyKdGd01k0OFygy7A4BhhlD9v0Y7/7zjqnaP
 RY6o8xOkIAEAvM7JV8dj48rHIioy+DTECKJjyKPxB2BD4ZRpQypPwgS
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY1P220CA0026.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8669:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dc7c340-e10c-4747-e765-08dd002da872
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N1diSlliaDQ1dXVJTWpCMmhKdjc2NnRrMVlvN1NnejFPcDRUWVJMaGFyMkIr?=
 =?utf-8?B?bWNEbEZDbXJyWEhqZi9taG5qTjc0bEhsR0gwWWJWWTFxNXdTcGZ5bWY4YUZC?=
 =?utf-8?B?R1RXMS9hRlZvQzR0VHN3WGk3RW84cnViZjZwWit6WGVESXBEUlRLQjI3VkVY?=
 =?utf-8?B?UjRKMUJ0ZUYrWEQzV0FaQ25GMjI5ZXNMUUNqVTdIYVZwN2JrUHdEaGhiWVBv?=
 =?utf-8?B?cXBYekFFd2FMcXBVdHBTU2N6WEQwYXprS2Fna05rQzYzU25DSmx0Z2J1bHBQ?=
 =?utf-8?B?cStTNVJKeFNFbjFQU1kxOCtBVGYzam1sNCtsdEdZWkNBVVZCSGduMDg4ZE5T?=
 =?utf-8?B?Vm45N2RVbTJobmsxQXM1c2Naa3p5aUF5VWR4SzRPNzdJSzBhL2Q3eDBSWUE5?=
 =?utf-8?B?OXZoNURFbFdFalljTCtnUGxQOWhZdEI4SzR6UHlYZ0FWdHJMcUtjYVZpU29Q?=
 =?utf-8?B?YWtIRFpxVUZRSjFxZG5aUGtLM2tSeVVwWWNvRXc5Tmx0UmM4SlRrRjdDSmhF?=
 =?utf-8?B?VTJDbjluT1FST1ZZamhrVFdNaFpjci9YRXJRdjZEUTlDOFRaUGNUZCtFaEt2?=
 =?utf-8?B?ejBRNFh0aGw2VzlKTlJVVW03MzVPZXcyKzRsUWpwdHpSWHFlTlRydjN4UzVt?=
 =?utf-8?B?bzZFWkk2YUoybUU3SGJUd0FSMWJlQndhZTJhV3FydXhYUkpZS09nQ1lQd2Ru?=
 =?utf-8?B?V3d5MmF1aFFSTUFDOFRuNEJIWEtseEJRL0pzd1ZYKy9CSlNIcnBpNXE0bXVI?=
 =?utf-8?B?VHZNNzIxeS90MWprdm1xTHo3SXNTdFdPN2pGWm8ycHp2dzBJNGppTW00aDBx?=
 =?utf-8?B?eWI4YzV2QmU1djZabmFWaWxRMC9LZmxvVlY3QWdoeDY3Q0R0RE5yM2RvM2l1?=
 =?utf-8?B?WDB1Y2laRVBZU2M0VjJ0TDgvL0wzTExBUnFJdjhIT3ZOeVJYaFViVzdqL1pa?=
 =?utf-8?B?YlNlRnhrTEkzeHhtczFGYWpKSnhDdm50bTg5UmVSZ0pibDVWZ3Zoc2FNSUJ0?=
 =?utf-8?B?M0t2bGhxeitaZnRkWXpMOE5NWGsxckh3VjZ4QTdhYkI2NFFrM3FhZERWVzha?=
 =?utf-8?B?aENIb0hWOFl1VnpsUHE1TjllWDlrajJEOHBVT0t4azdEcU1NbmFNSHBaWVRI?=
 =?utf-8?B?TFZhRUhZWVZwbDc2bm9RUDZnV084QlRlazNSRXNIZFdCYWJMRTdFSDhIRFho?=
 =?utf-8?B?ckw5czhUSzE4SW9FaGh3bmhxTXlWYTB0dzQ2Zy9CQ1lIbHhTd0ZtNHhWMHNR?=
 =?utf-8?B?bWZEZi91UFo0WTRCTkhUUDNvSmtENjdoMlhiSXBYYTVJL05EWGtjU1MrR0F6?=
 =?utf-8?B?STNKOUlOcTNWb0lDL0U1aU5UOTRoMFZORW9yamw4QTlKS1hkblJYSG9kYVNZ?=
 =?utf-8?B?VlBWR2x4VTZ2TFhzbzJNc2NYUU14M3dTelFnMFNxZC9MY0ZhS0ZDa1ZoTjl0?=
 =?utf-8?B?VnZtY0xONXdJSHRHSWdXbGx4RXl3c1BzUGhYb1BudzdVSkdOUHdYTWxiWnZV?=
 =?utf-8?B?NXcwYzN4dFlnUDRVZHgwejhlTkkwZEtrZnBrT3Z0MXdsVkk0dGUyZkdOUGxy?=
 =?utf-8?B?Z25abDVaS2k1SG1WZTFXUWgwTy93N0JhbXNwUzdrY3pWYU43Ulo3MmRqeC9F?=
 =?utf-8?B?Ym5Qayt2YUdKK003T2RZV092bjVOS3ZacTdYNGZadkZ3dURGVDRVeVIxVlBD?=
 =?utf-8?B?bmxpOWxVdG1lL1VocmN6bmtZRTJGOHdDUHB0bDZPdFd3WDM1UVYyMkNDeDdS?=
 =?utf-8?B?ZEtQRHg3UkhYMURkSFNodForbTU0aHJsT3FUVjh0aDdIazZYeHMwV09qZWE1?=
 =?utf-8?B?SjltMldvMW1xYllEdDRib3IySFFGSFNQUy9wbVFuVWlnVlFTdEliOTFKNWI1?=
 =?utf-8?Q?+oTsX2MZEJrFj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S01XV1pDYldBYXV0b1NIR2Q0Q2FZc2g0Q2M5ajdLS3hqN2RFeEZUUU5SS3dl?=
 =?utf-8?B?T3hKUjhhN2EyR2dXZVg5Ti91dlpNaEkwWmluQWtpNjRKNkNmZ2swTEt6M09L?=
 =?utf-8?B?WDZBQUJHTmVsNVEyc3UvcFNVY2h6SDVXL2x5S3k0VnRDajJxRDB6bFpoM2dJ?=
 =?utf-8?B?MlZOSnNrV2kzdG01QUxUZVM4bjg0NUUzK0Y3dGV4VVd5L2FJSk5aa3ozd3Ar?=
 =?utf-8?B?L1hiMU1rMUx0U3hSZUZURktwVWczZGc3YXR3WkxyUFhNT2gyWFB1RUtVWFZj?=
 =?utf-8?B?SERsRnUvOVRsSWJwSUttZ0tPR2xOWXVFcEl4TGdZcUxISGdmTUF5eElMUU1W?=
 =?utf-8?B?U1Jmb2pxTFpiSzNYR0hLVWRycm14d0I5UHBBVExpMndvbllhcEIwcU4vYXBi?=
 =?utf-8?B?em13V0syeDY4cVl3a2RDN2lwOTc5OGZYL3FPcWlocTZGa2NLS205KzZCYVcr?=
 =?utf-8?B?UXhMalFILzVoS1BZOXQ3cWVyNWgrSXYyU0ZvQVcvWmN3azhvUkV0cHlDQkpx?=
 =?utf-8?B?bGQzd0hHdUZWZHhTWXlDYmVxcGdSNkhYYWpwYWN0cEFrVGljZ2o1N1N5L3lE?=
 =?utf-8?B?VTN3SThER1dGVXJyVmZEdDhCMW05UEV3Z0lUSVBSSDBwbjRWNFA3STdpNnE2?=
 =?utf-8?B?bGhxRmt0MldheUVoTWlpbWs5VUJMRnZjbXQ5d0VnUExYSzhzSnhvckkxYmxu?=
 =?utf-8?B?dHVPSXhDekFHNWw5cXdDQTBHUjlsNGNCaXVJalU3NEd5eTRTSG8xTVUwbHJt?=
 =?utf-8?B?ZndtalZQS0ZpSyttaGFvRFNueUx6aWNpS0p0ZkNQQlI2YzNRTU1IUUlSbGty?=
 =?utf-8?B?RjJxKzRXWXNiZlhjL0VxRit5cHdmMFRtcmpaNWljZENvd0lBcUpQR0Q5SU9E?=
 =?utf-8?B?SllxYm1VMHIyUDViWEpJSElDRVJOTkhlcFlxa0pnRjRTd1ArVndOcW8zUjV3?=
 =?utf-8?B?ZnJINjFTMlM3ZFNlOXBNYVlvL00rZG05cDQvc0RPYzVjSnVUdnJhZ3c3MVI1?=
 =?utf-8?B?MitOd0RQRWt5VTZQb1NiV2dpTVVDcWpaUGs2NVRjd1JXZlRjNTNMVXZTZ1lB?=
 =?utf-8?B?a1ZWWWVyMkFFeTJtL2ljaWFiTU5TVHN3TmhJb2VZVy9CZU92VEhKaW52SkNj?=
 =?utf-8?B?RTVvQlN0L2RNNGpacjZRdE5DRXhlM2hTZG92QlV4cWdmRk54ZTlZR2lwNTYz?=
 =?utf-8?B?VjBrYTFsQWJsZEJqaXI3REd1VlEwOWlBeG9TeDBOYmRoWEdVeE9abUJUeVNx?=
 =?utf-8?B?akd3T0ZGR3dCWTJJMnpCZEhVM0tTc3ZtZ3E4YUFhbTZPN2JEZXByY081TzZs?=
 =?utf-8?B?eWJTd2RyK1Ayb002T3NRZFlqOVNGSWZlNDdzWTJkV0VSTDBQU1k4Q3hzOWR0?=
 =?utf-8?B?dnpxRkdiNXN4RVN0VVNRbjRYT00yeklXOGo3MnlEbE1DMWlHUnVvNjRsc1lH?=
 =?utf-8?B?ZmFvRENJTzQ3N2twODhaUjRpNkY5M0t0ZjVCNzU4dkdsTFhlMzEwYTFMM0dR?=
 =?utf-8?B?dUZQeWFmVUw3SkhIWUY1NkN2dnYyRGxEb2FwT25xUmh0cTF6ejIyMkc3YXl5?=
 =?utf-8?B?SlFGSDlkL0h0OFZOQzNtcCtkTHFQSFNUMG85VW1IVEdJUUtYQllsQm9ObzN1?=
 =?utf-8?B?UzJRbHJOM1pqbkRYK3dPdGJDVkxVc3JaR3lPbC9aTC93L3psaENzb1BnNlJS?=
 =?utf-8?B?VkNpRGo1dzE4aFN4TkJDQVc3dHVaVElNV2NrN3Y5R3l2QXE0TEljcVNtMkJN?=
 =?utf-8?B?eHRENWVsQlM5QW9Gek5SVHJYaGhXdEIwM203YTFCODVrenRoRVdMbmlSVllI?=
 =?utf-8?B?Yno3Q3pPVUJjZ2o4QnlVMHRPOHFWSm41V1hKZzYwVWhhUk9vL3RSOENxaXY1?=
 =?utf-8?B?WHZFNkNrMXRWelA2QUVYOXh0WHkyWDUzOE5JeUh3WGpqQkZrRmZzVlZzQTdx?=
 =?utf-8?B?ckNUTmN3WUIzQVJ3MmdrYjlIMVIzUWhobDNpTXN0RVF2aVFpK1NzMVg4WVFT?=
 =?utf-8?B?ZVBnYmx3NDIyR1oybzFBTUFwVzlja0NpUEFieGoxRDhIRjFNMDhFOStQWXV5?=
 =?utf-8?B?eWpvRnNIWGVMbFRvYTh4b3FOZDlaWHFYa2pQbndoOE5aNlVGNWhsL0Ryd0Vz?=
 =?utf-8?Q?1LeuYOW7DK+JglcR3OKJMCOTY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dc7c340-e10c-4747-e765-08dd002da872
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 19:43:45.6916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4O9o6GdKL6A3NZJXUxuIlN3pIGu0Y29p+D2E18ZAzcrTIH+loDOpTPyFBIcCGztVXffd6siW11JiKPAW5v/Eqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8669

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
Cc: cassel@kernel.org
Cc: dlemoal@kernel.org
Cc: maz@kernel.org
Cc: tglx@linutronix.de
Cc: jdmason@kudzu.us

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (5):
      PCI: endpoint: Add pci_epc_get_fn() API for customizable filtering
      PCI: endpoint: Add RC-to-EP doorbell support using platform MSI controller
      PCI: endpoint: pci-epf-test: Add doorbell test support
      misc: pci_endpoint_test: Add doorbell test case
      tools: PCI: Add 'B' option for test doorbell

 drivers/misc/pci_endpoint_test.c              |  71 ++++++++++++++
 drivers/pci/endpoint/Makefile                 |   2 +-
 drivers/pci/endpoint/functions/pci-epf-test.c | 129 ++++++++++++++++++++++++++
 drivers/pci/endpoint/pci-ep-msi.c             |  99 ++++++++++++++++++++
 drivers/pci/endpoint/pci-epc-core.c           |  23 ++++-
 include/linux/pci-ep-msi.h                    |  15 +++
 include/linux/pci-epc.h                       |   2 +
 include/linux/pci-epf.h                       |  16 ++++
 include/uapi/linux/pcitest.h                  |   1 +
 tools/pci/pcitest.c                           |  16 +++-
 10 files changed, 370 insertions(+), 4 deletions(-)
---
base-commit: f231847d7f5a171be4566099f654521606b3ec37
change-id: 20241010-ep-msi-8b4cab33b1be

Best regards,
---
Frank Li <Frank.Li@nxp.com>


