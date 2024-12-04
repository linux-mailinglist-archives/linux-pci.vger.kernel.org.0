Return-Path: <linux-pci+bounces-17720-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B14DC9E490F
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 00:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18902188261C
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 23:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC46206F3E;
	Wed,  4 Dec 2024 23:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Zp97eLNS"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2047.outbound.protection.outlook.com [40.107.241.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE0120D518;
	Wed,  4 Dec 2024 23:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733354803; cv=fail; b=s2a2GWwXyWEHKZWu76hj1WCvF54oHhJImC6nr4FMV5usSgXzeiM/z33j7ZoZ6BzQgQ77k200H1Pk01If0/7F6Yyrbsdg/iZscwkzNMqibm1aeU2duAxVXtsa/8gpwj+s1U3o1nIf6Nwgx5B4msxruExPjNOzy56fe3NprDtWhRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733354803; c=relaxed/simple;
	bh=pWGytAB8s6gen2m9ZI1DoOIIZFW+6li87luByAgV91Y=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=hXA2BX8BWphTJUykzwfCnyRTXTOTotEUT8+5UbuVJSiN28y8zQyL3Tbp6cPZ/1G2dDrkdlJeRWJ7urtm1nTVDiJOTxYc5qnHo/7pcZGtcqd0+fSTTkvAXrrfiuC91WznE7F8/B7WpgBA6nukXMlK9olT8+QqZTguYpQNa9eSOY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Zp97eLNS; arc=fail smtp.client-ip=40.107.241.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AyhGzTJRNW6n8NWyZF++imZUKwLgyRK57H++io1GP3JMDaCmOvNPv8+aNUbznTWGHNdPXIOdqN13g6jGjwoYkBcghL30dsckmPvO0hj67dCe9YgdRuvm6G2sMcM2coIVTPqY8isEHcynj3FG1p+xdnCmJuMk1spEQywjq83w+uHsBg0P+LEQR16mOKXWVaAlQnea/mSsyDjGwPEQU7hHRQDWaklnSIGUW2ZM9HnhE2I4jidNb4Ok9WQgxJdCs6aXBjy8XZR3bljewJyR1gZ9ZB/EmdRpe0mJBzSq9GvNyA13nyujbAvG1SHFtdMYogOURCypAu8Y9E8LTBE2yWHpaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6DCmePda4j/FCA9JotgJUo0sd4sEBON3NlxWMdS/rIo=;
 b=XcnJJ34TPds38JCC5CCeNVKj4qgputRU15cHPRaQ7pnM45dLHlNemSrx6nBNSc+5uxjdgbkRsllgdyrS4ayrO3cTjMAgSq6Z7MRBijLClKcMEbevbaYc9/U37NfTbc9G3Xyt+C0j9/uRSEmdL6b5MDYDGKPxEojQqQF1CMMclceu65X3aftaiGUsIuyydot9JAyv7pqO7fMbTQ/wEvnT49glospQFU8oJ41qYuO23mBKDh61zrqZnd8UA57iqfbPoqzl79KUhOAYiAhAVJMCm3cox4q0Y7VU58WvgxMa4pIIiiWqfTH88gmXqG1AGBnfxd12xjNFtgg/J7cXO43Jkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6DCmePda4j/FCA9JotgJUo0sd4sEBON3NlxWMdS/rIo=;
 b=Zp97eLNSyXPxWOQhW3uIPM1CIVCnSHL14rpwjQ8ciMez/m5Pk++DQpAQCzxhGK/blE3GTknicFZUND1sFthZRl//Krd5oT4mP/44zoY8E7rGgv82ICImIK6H+DwfT+CI+8tvh39Guynh1iumthupRFV2VuqgqN+LSXXmLAxMEBWkKUifLCYZJfOYkpYgylynAOgrFqjGWg0LRw2U8FYeAqqo4aYJlEE/wb/A2xJq0Z+dmJcgYylOGmm5LIxRxLCc6XiK8yMxT8KqnD1Oosnk0YjzALR39JtjPPlaaaHaEwoxCEjlR09EfrpvETjXEn+n46W560GJ1VS2Qd1HZje9HQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB11006.eurprd04.prod.outlook.com (2603:10a6:10:58a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Wed, 4 Dec
 2024 23:26:40 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8230.010; Wed, 4 Dec 2024
 23:26:40 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 04 Dec 2024 18:25:56 -0500
Subject: [PATCH v10 6/7] misc: pci_endpoint_test: Add doorbell test case
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241204-ep-msi-v10-6-87c378dbcd6d@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733354770; l=5981;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=pWGytAB8s6gen2m9ZI1DoOIIZFW+6li87luByAgV91Y=;
 b=5rC2pv9kTDOCXRUuBnJG0kYZKRpOSswYd299MJQeMbL9vqqitFjrREKzfTN4XKIyaJjD2UoFj
 gA0SxTaGa/zCgdRVDBCucNL67JFMysGxCXpCjTtQFpse4NTKqXKbTNn
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
X-MS-Office365-Filtering-Correlation-Id: 6794e5a7-2f72-49b9-58c8-08dd14bb1b1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|7416014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z2NzQWNMSmdJRnBIWXBKNE9vbWI5ZFNPcWNKd0sxVlc1R3NQQVMwVTB4SVhm?=
 =?utf-8?B?SGordmNmSzl2WDFQZi9FVU9WN0tVWTVEYlBNTW5xdlVMMlk1SHltZXBiQ3VN?=
 =?utf-8?B?ejJQUFRBbzVDTHRCQXJxZUNtYUVQakNlaWNtK1VHRFFOTzlZSnFnOXoyQ1JL?=
 =?utf-8?B?akZLTjRFb3I5S2IzdFFFNVhjdlExYWVvTXhmbExZSngyNkhzL3BQQUpxKzlq?=
 =?utf-8?B?aE80QVRwK1V5QzJyMFhXTkY5ZUk4cU5aWTJROHBTOTFUbEJoNWpBdGRYd1B2?=
 =?utf-8?B?eCtkaEh3Z1dJY1QrZ0lrdjd1cGg0M0NBRUV0R0l2UzFIMWowcmpuNVkrV2F2?=
 =?utf-8?B?Q28rcjNENGRDTkhISjNLN04rU0IyRzNDL3VIQXNoZE00aW5aVFRFR2pselFR?=
 =?utf-8?B?Rzd6YTkwQi9pQVlPSzFoMDNSdEhzWHdvOEpBM2VqZ2lZY3h4aitaN1ZTV2NN?=
 =?utf-8?B?RWlKa21hcTFSVExCTCthdU1PNCtXTEFKTk1QSzR3czB5TnFLQmRGN0dmWVp0?=
 =?utf-8?B?WGNPeFdLOGZaM0c4ZVM2UkxRY05HTFFFclE2MGo3Ris0dzV5eCs1clljdzJ5?=
 =?utf-8?B?ZHdmM3lCem51cFJ6S01PYVFwS1Jpak04Smxhck1WV3UyeXh1MmdlT2lGWFRR?=
 =?utf-8?B?TituWnZJV3JjYSsza3JiWWgxWVZHZDVyemNOemJydHJxWEk1MGN3Qkt4akVz?=
 =?utf-8?B?YURPQ1pSUW9PaXRhd1R1TnNWS1d4Q0tZTVVPei9pRW5GL0o0RC9LSFNCYUpK?=
 =?utf-8?B?V29kZU1Oa1FsV1Rlb2tSWXBTM2tVeC9lQVVxQkNKNXVYWEM3UGlGSEVmQzFF?=
 =?utf-8?B?NHBHa1JZZ3BmUC81SCtiWDUvdjQ4Z0N3OEFEcEpBNC9NbXY4dUpwRFpRdnM2?=
 =?utf-8?B?dU5xK3ZGbXY1MmRCZlU5Nmk5V016WngzN0dDQzFmanBQa1l5dWF6N3ZkbFFk?=
 =?utf-8?B?QXlGVExFRDl3d2NoWG41R3lpRERmL0cvNHVHR090VnpZRW5BckQ3K2NOZlNu?=
 =?utf-8?B?MmNnREZjQ3ExQnM0V2UyRmxmRW5rMG5yN0JMcDZOVVFHU3dPNU9BUDFjNk5l?=
 =?utf-8?B?NTE5eEF4YmE2WWQ0RG9MRFVCay9VNHkrYXB1MFYvbXhCYjBRZDhQMm10ZUtl?=
 =?utf-8?B?TUNEUzJFY1lXbURvYlBNZ2VwbEY5dEhRWFhBdTRhM3hudGpiMSszbXlOTVdQ?=
 =?utf-8?B?SjlkMW9yU3phUlVGbi8rdC9hcm1IeERxUUNpWmVLNVcvZmRyUHlHK1hDQTJJ?=
 =?utf-8?B?L0owVjdIZmh0OW84OVJlSnVQRGl4cE1seHpWZlNUMzVDUksrZmtEOWtyeTUx?=
 =?utf-8?B?T1QyVTl1dUxoM1E4MlpYTi96dkZVUkozQlZZdHdDMDJkOW42QVFiZTBDdEE3?=
 =?utf-8?B?NmJ1V2NjOXdmNGJHMGs5RUt3SGNjLy9Keks5NXIyUmg4emtBMkZzbDd4R21X?=
 =?utf-8?B?V2poQ29DNVhCWnl6Y2hSTFFIdkdjU2lLRkk0eWFYT0VjYVlqSGxTQnJvT1cz?=
 =?utf-8?B?d1NUcWw3OWtQazlPZEt2V2gyR3ZEUldHRE5YZkhPTmtTSERhQnF5Q2tub3ky?=
 =?utf-8?B?Rk1zTnowQ3U4eS9MUk1KMVJ5bUk4aS9Rd1d0UXpxU2lPdVVSbDJMM1JtSlBa?=
 =?utf-8?B?MTJPUHFiQ2MvUUVoWGxEdVFnZmI4UjdSV004bTNXaWdxcEFXSVN3amdObWpU?=
 =?utf-8?B?VUpZUERQYVE5ZVFQQ1lMblRZdG5JdTRXUmlmd2VvRG0zajdzdkJTQkxaVjFv?=
 =?utf-8?B?aTZ3RlJhdDU4bk5lTHVLVTduUzk5bjJRVW1hWE1mbmdVN2RvT3p3eHEwRGdV?=
 =?utf-8?B?TkFQYXRKQWRRS0lhVnJVRmlqN3FoZkZQeGJQOXIyMTV1S0Z5NjI4ZVVqYnlN?=
 =?utf-8?B?NVQreTNZbjBDdHhNbVNpRDFRUFQvUWdyVUNOWkoxLytDWElvZSt2NHhPYkQx?=
 =?utf-8?Q?cnk32wajH9w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QTJ6QXBFang5SloxanYxMy9lMDF5c0tjWUtWRTd4T09NbEJNdG5NYkEyaXhn?=
 =?utf-8?B?SkZHYVpvVnVpV3UwUnVIWGVyWmovZSt5RmsxY2ZrYTg5SUJsMm5qaGZIaXA3?=
 =?utf-8?B?aHdlSG9Ycm03KzlleS85b1kzRUFCSCtMVndlOXIySzhLRVlEQlg4MnJVOVpr?=
 =?utf-8?B?WkN6aXZBWExhK2pXUEMvMzdDdHRYWFg1bzBkWjVxa3FoNktFYUQ4QkNLSjRt?=
 =?utf-8?B?akN4dVBIWmxJankzcktoY3J5NWZVeXJ2YytoTkRRQ3RKM0YrdTl2R1VoUDdz?=
 =?utf-8?B?MjNLVFBSUEZVN3k3YmJRb3U2UnVSZEk4SlcxWjVkTDNFNHdod3RWZzdyNFAz?=
 =?utf-8?B?YUlFVTRhUU1hTVkwVnRRQVN3bzlvcDZ0UkplNUZDUCtwMExLTlArQ1laV0ZH?=
 =?utf-8?B?UzhQWkxjRWhYYk9YdVZlS3FSeUp2eGVRbUNFaE9maG9laU1nVXljV2JTdnow?=
 =?utf-8?B?VkdCVTRXTyt4RHp6RXlnUG5ZWFVzNmExclkvdmlFTG9mNUdWaXplcUZjcWFR?=
 =?utf-8?B?cGZTWm51a1YvME5nS253TkFwVC92N1VsU0dlaklVTFFJSkJSRGdFU2N4VmMy?=
 =?utf-8?B?azNyMlNhT3F2QVdOWThCZVZuTkpXdmtPUSs5cVRKOS80U216VVRMV3BQODRV?=
 =?utf-8?B?RjhoQlhGWHltM3NMNThlb0dkczlXcXlrUlQ4YkFJVVdOeVZGajdIcEc2bHhW?=
 =?utf-8?B?S1pCQUI5Zzc5c0RQQmRYUUUva1ZiMi9OL290S1hnRytPemt1TS9Qd3NaOWZw?=
 =?utf-8?B?S3c4MzNoM0p6WjdWaG5JcGpDMFBIRWNaeDV3bDI5bWNhNGp0Yjh4NEJ5OUFQ?=
 =?utf-8?B?dmJRZjh5cVErVS9KMXNVVEhrckY3elV0bEVNL0EvMnp3eEl5SlpUYlJKclkx?=
 =?utf-8?B?YjVZaFgvY0JoMENBNzl5ZTJyMzV0NVh2SnVaZXVEdmhMMm1NaVVCQjNaNjZ5?=
 =?utf-8?B?OU1KUmRKaDZXeGNENFNDUGp4dWZjRlZUYjIxWVZ4VVBqYUhrR0pINHBBaEpl?=
 =?utf-8?B?Sk1SNWhyWkEwVkZxV3J4Yks0QjJWS3lPbU9uVUZMUEdJME8vUjJhUStZV0hm?=
 =?utf-8?B?cG9sM0RrVndreEZKTlpDU3NObFFnbThCRXFJL0d3b1U2ZXM0OVYxSTBPRU01?=
 =?utf-8?B?TkNDalB4VGhsTGJvQTEvbDdOUUZzWkdhZjEvUmE2VDRwaGNoc2UyZWlzYkE4?=
 =?utf-8?B?ZUR3ZUV3dzVLTVBRTnpSVGhrU0ZGQVRORUtqOFZYZTBtSzBLd1VwdTJlbmJW?=
 =?utf-8?B?UnFOWk5oelFqRUJBQzgzUmxFM1RQbW9ObkEwTU91SlhHN2JvTDJRMGNTOCtj?=
 =?utf-8?B?S0dORXBxemNYWEFLY0E2S3o0Q2FHMTRaa0s5MEtMYzh0VEUzV2N3WnU1TFhJ?=
 =?utf-8?B?L0JRV1BXT0NRcVd6cUI3TFNVbXl4SVd1ZExwcmdDVE9qLzlocGtZay9XOUR2?=
 =?utf-8?B?WTZQNkUyMXdPWDV1OWtDbU5jdHd0bEpzblVuYnlnMitmVnVjeDU3U2VuTnpB?=
 =?utf-8?B?Z285ajVVT2NiQVkrZFY0VVczbTFROGhyV28zY3NCWGpBQ0c5bmJPSkg4QmFr?=
 =?utf-8?B?RzEvNlJwZkQ0VkxnT2pFbG9SU2d6QnRMMjNRVVIrdmhRSHR5NHR0VWxrS1pK?=
 =?utf-8?B?UHNmRy9GSERBRWpSNlJZNzlUMGtZU240eGhOSG15WC8vWVNPR3lzaTAxNldY?=
 =?utf-8?B?MGhhcStsOWhPdEpUU1pmNnNLVE9rZHBFeWo1L3Z4anZqTnVDcENqd05YQlF5?=
 =?utf-8?B?RG9jWThLOGZNeU9ubDRrQmNOTzZlYmRRelY5VWcyU054SWVqZjR6ejNjeHo2?=
 =?utf-8?B?dnFYMHJhczhjWGdkaDgySUtyM0RqQW1XbC8wTTFSWDFtYVU5c3FOQlJnWE91?=
 =?utf-8?B?d0RZNlpuMCtjVlVGNHhGRUNaTGdTRWdYSGplK3ZDbENoUWdpNlpUK25ZMXJk?=
 =?utf-8?B?ZjhsZEYrMUtvd2tYdUR3L2luTFc2MEc3RVpDeEpoV3VkNWpFc1l6TEpmdFZZ?=
 =?utf-8?B?SjlqOU9Wa1AvMk8rZXA5VE1ucUU5WTdndy9Fem9DbnhNTVczQ1NCMW1UM0JT?=
 =?utf-8?B?Ri9CcnBwU3FDTmZPV1NGWkEzOGJyNzBFVnhJYmtIQ2kydzhiaU8vR3lGUjZG?=
 =?utf-8?Q?L76k8IL2sv6gWpx5f+rV8KHi6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6794e5a7-2f72-49b9-58c8-08dd14bb1b1a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 23:26:40.3544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i0ADLOkgSHiZJG/qfPHKn/HySjQZBD33Y791ExtrgXUhMyqUzvhpD+zlciOHeqmOLZfTHKn3B8CbCH3rZ+Tiyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11006

Add three registers: PCIE_ENDPOINT_TEST_DB_BAR, PCIE_ENDPOINT_TEST_DB_ADDR,
and PCIE_ENDPOINT_TEST_DB_DATA.

Trigger the doorbell by writing data from PCI_ENDPOINT_TEST_DB_DATA to the
address provided by PCI_ENDPOINT_TEST_DB_OFFSET and wait for endpoint
feedback.

Add two command to COMMAND_ENABLE_DOORBELL and COMMAND_DISABLE_DOORBELL
to enable EP side's doorbell support and avoid compatible problem, which
host side driver miss-match with endpoint side function driver. See below
table:

		Host side new driver	Host side old driver
EP: new driver		S			F
EP: old driver		F			F

S: If EP side support MSI, 'pcitest -B' return success.
   If EP side doesn't support MSI, the same to 'F'.

F: 'pcitest -B' return failure, other case as usual.

Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v9 to v10
- none

Change from v8 to v9
- change PCITEST_DOORBELL to 0xa

Change form v6 to v8
- none

Change from v5 to v6
- %s/PCI_ENDPOINT_TEST_DB_ADDR/PCI_ENDPOINT_TEST_DB_OFFSET/g

Change from v4 to v5
- remove unused varible
- add irq_type at pci_endpoint_test_doorbell();

change from v3 to v4
- Add COMMAND_ENABLE_DOORBELL and COMMAND_DISABLE_DOORBELL.
- Remove new DID requirement.
---
 drivers/misc/pci_endpoint_test.c | 80 ++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/pcitest.h     |  1 +
 2 files changed, 81 insertions(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 3aaaf47fa4ee2..b3f36b6ba8ba2 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -42,6 +42,8 @@
 #define COMMAND_READ				BIT(3)
 #define COMMAND_WRITE				BIT(4)
 #define COMMAND_COPY				BIT(5)
+#define COMMAND_ENABLE_DOORBELL			BIT(6)
+#define COMMAND_DISABLE_DOORBELL		BIT(7)
 
 #define PCI_ENDPOINT_TEST_STATUS		0x8
 #define STATUS_READ_SUCCESS			BIT(0)
@@ -53,6 +55,11 @@
 #define STATUS_IRQ_RAISED			BIT(6)
 #define STATUS_SRC_ADDR_INVALID			BIT(7)
 #define STATUS_DST_ADDR_INVALID			BIT(8)
+#define STATUS_DOORBELL_SUCCESS			BIT(9)
+#define STATUS_DOORBELL_ENABLE_SUCCESS		BIT(10)
+#define STATUS_DOORBELL_ENABLE_FAIL		BIT(11)
+#define STATUS_DOORBELL_DISABLE_SUCCESS		BIT(12)
+#define STATUS_DOORBELL_DISABLE_FAIL		BIT(13)
 
 #define PCI_ENDPOINT_TEST_LOWER_SRC_ADDR	0x0c
 #define PCI_ENDPOINT_TEST_UPPER_SRC_ADDR	0x10
@@ -67,6 +74,10 @@
 #define PCI_ENDPOINT_TEST_IRQ_NUMBER		0x28
 
 #define PCI_ENDPOINT_TEST_FLAGS			0x2c
+#define PCI_ENDPOINT_TEST_DB_BAR		0x30
+#define PCI_ENDPOINT_TEST_DB_OFFSET		0x34
+#define PCI_ENDPOINT_TEST_DB_DATA		0x38
+
 #define FLAG_USE_DMA				BIT(0)
 
 #define PCI_DEVICE_ID_TI_AM654			0xb00c
@@ -108,6 +119,7 @@ enum pci_barno {
 	BAR_3,
 	BAR_4,
 	BAR_5,
+	NO_BAR = -1,
 };
 
 struct pci_endpoint_test {
@@ -746,6 +758,71 @@ static bool pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
 	return false;
 }
 
+static bool pci_endpoint_test_doorbell(struct pci_endpoint_test *test)
+{
+	struct pci_dev *pdev = test->pdev;
+	struct device *dev = &pdev->dev;
+	int irq_type = test->irq_type;
+	enum pci_barno bar;
+	u32 data, status;
+	u32 addr;
+
+	if (irq_type < IRQ_TYPE_INTX || irq_type > IRQ_TYPE_MSIX) {
+		dev_err(dev, "Invalid IRQ type option\n");
+		return false;
+	}
+
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
+				 COMMAND_ENABLE_DOORBELL);
+
+	wait_for_completion_timeout(&test->irq_raised, msecs_to_jiffies(1000));
+
+	status = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
+	if (status & STATUS_DOORBELL_ENABLE_FAIL) {
+		dev_err(dev, "Failed to enable doorbell\n");
+		return false;
+	}
+
+	data = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_DATA);
+	addr = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_OFFSET);
+	bar = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_BAR);
+
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
+
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_STATUS, 0);
+
+	bar = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_BAR);
+
+	writel(data, test->bar[bar] + addr);
+
+	wait_for_completion_timeout(&test->irq_raised, msecs_to_jiffies(1000));
+
+	status = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
+
+	if (!(status & STATUS_DOORBELL_SUCCESS))
+		dev_err(dev, "Endpoint have not received Doorbell\n");
+
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
+				 COMMAND_DISABLE_DOORBELL);
+
+	wait_for_completion_timeout(&test->irq_raised, msecs_to_jiffies(1000));
+
+	status |= pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
+
+	if (status & STATUS_DOORBELL_DISABLE_FAIL) {
+		dev_err(dev, "Failed to disable doorbell\n");
+		return false;
+	}
+
+	if (!(status & STATUS_DOORBELL_SUCCESS))
+		return false;
+
+	return true;
+}
+
 static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
 				    unsigned long arg)
 {
@@ -793,6 +870,9 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
 	case PCITEST_CLEAR_IRQ:
 		ret = pci_endpoint_test_clear_irq(test);
 		break;
+	case PCITEST_DOORBELL:
+		ret = pci_endpoint_test_doorbell(test);
+		break;
 	}
 
 ret:
diff --git a/include/uapi/linux/pcitest.h b/include/uapi/linux/pcitest.h
index 94b46b043b536..b82e7f2ed937d 100644
--- a/include/uapi/linux/pcitest.h
+++ b/include/uapi/linux/pcitest.h
@@ -20,6 +20,7 @@
 #define PCITEST_MSIX		_IOW('P', 0x7, int)
 #define PCITEST_SET_IRQTYPE	_IOW('P', 0x8, int)
 #define PCITEST_GET_IRQTYPE	_IO('P', 0x9)
+#define PCITEST_DOORBELL	_IO('P', 0xa)
 #define PCITEST_CLEAR_IRQ	_IO('P', 0x10)
 
 #define PCITEST_FLAGS_USE_DMA	0x00000001

-- 
2.34.1


