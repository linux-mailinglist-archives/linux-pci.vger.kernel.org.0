Return-Path: <linux-pci+bounces-17959-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2821A9E9D77
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 18:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1223280DB1
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 17:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4101BEF75;
	Mon,  9 Dec 2024 17:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PsMwRGOk"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2041.outbound.protection.outlook.com [40.107.241.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3AB1BEF70;
	Mon,  9 Dec 2024 17:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733766545; cv=fail; b=TGQThFgAcdtBRoQ9aUCUU6psnsQMJ09VZ8o0vjNX6Z/97nH+NK7/HO9VCZcYI+GX8xH6JsfeW0aUeqNWptKmc81WqyIS2o87lfcaQzWwdkWlM7JCnBTmUrtinmY2Iuw9Dy2V2EKuvTYGo6uzY5z9IeOTkGJ2kPs3EhLaeVaeZuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733766545; c=relaxed/simple;
	bh=PaYILZ+ZM1f1lH5TRWB+Pf5dVKwn8b6IHDryYNsxWvI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=aIIkT7h+Z4MXvpXNKcPQ1lr2h7XdLnFiUrOnlEHGW1SNOjjIIu7o+v+bLgL5u4EAV7OmdutWhGa7Ntiy5k6q6V9LWqsH3RWhYUz1Ynz5XU7W80P39xYvDl5T86XKCXpy5LDL7OVG4+hqr2318oEwieTxyO3yY8CF++c3FLPsQUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PsMwRGOk; arc=fail smtp.client-ip=40.107.241.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gts5lNCnXEkR1dUU9G9136D7OELkg0V0yYB8mxZEz6lllMqHYRZoNnbX1ucN3Ok2YBKfy5oRz3zdaF5wLZYGIE4E34Ii7vmDLdB9JBI93GO+NtPQGRimdLQbR1VYHkhie3/JO5lYb9N+W9AfXqYRIqnEXzbK/1TGWrlgZmz5J9wyjhTbgJtwJNSq8N/vKxnY2VvKMXnPC3pEetirKdPBL7F01ptpQZSSMdMFYC6bQuuwG7hNNYqfQtBs7NPS6aqsojn8FCONn1R0SoGsNqS9wHxtz/SshLbNyN7KeXj1iqqOmob9r97khk2znDfbpheS9Fr5287KIYthqKCh9oVJdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K5FPaZ3LayiFO3rfW5JsISxtSjCShLWFdWQKWv27vnM=;
 b=Tk88tRihZB0txaf2OpQO+0pAjg20iZd+Qu5yYJil7wJW3c99nz7+yTJRBImqebwJZqUZGvOB/iRd0D+mGWqDpSzzdMkhepjwTv23kKeTyTxG05VnDeWo8ALEb14qmW4fuACq85ONszbB0Ow9+AtZgHbtH8Vd+9XGSreLPLLhbR7YiR9dwWa8dsIGENkKurB9CVfrZE6eDLVpULBFkl3nPcraea/7ITZnqhDT4DLI4tGCSeiy617Pok0OsyXkqANjRRjkSSBp7VV7USAq6Y3kHsJHQbn9oB05g2iQZC/cn1PuFX41GhQcEgA597yrbx2NDHEl9E3B7xF8UppkFDpjaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5FPaZ3LayiFO3rfW5JsISxtSjCShLWFdWQKWv27vnM=;
 b=PsMwRGOkTaukH1ZMQFe96M8LsQ3NQTwx34wJozrD9pmYYRNVYGQqBo2SxD53jGDbmKxgkzamT6JxrCVz/7XYJGNP/fMd425BmqOSjR5aO+Bb1gziLTvUdcjQmvvgu2auTp5fy6PSRXvBelBWyog1KSsv4aK1Sb+lH1/H2G+rFfZxOgIQ6JiUkberEDPlTUe2YfJeufcJ8tSil1fss6ri4FFj6niAXqAcbXeY6c2khDAzzDKI+QKAoe4qk9/TmLP4hzd3vV2FRoqbauWnWCFc3FSDILHpohwkqeDWtaZoXwtXixJIlBOaYt/u7Qt7Id1vQoh2cqDRvTJRRxYf7+tmxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB11017.eurprd04.prod.outlook.com (2603:10a6:150:21c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 17:49:00 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 17:49:00 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 09 Dec 2024 12:48:19 -0500
Subject: [PATCH v11 6/7] misc: pci_endpoint_test: Add doorbell test case
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-ep-msi-v11-6-7434fa8397bd@nxp.com>
References: <20241209-ep-msi-v11-0-7434fa8397bd@nxp.com>
In-Reply-To: <20241209-ep-msi-v11-0-7434fa8397bd@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733766511; l=5981;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=PaYILZ+ZM1f1lH5TRWB+Pf5dVKwn8b6IHDryYNsxWvI=;
 b=6YkXa9efyhaPyEHdEfk/UPRrGP1U4en1a2QrC7PsgIw0Z/YNaRO82kfvV9ikJWCZk3sY4N0+D
 Vxp0bukLLIQBv5UpWDaMZvCtPkstjtAlQLWTqRtZSkFqO+Dbk9xmCJ6
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR17CA0070.namprd17.prod.outlook.com
 (2603:10b6:a03:167::47) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB11017:EE_
X-MS-Office365-Filtering-Correlation-Id: 93ef8d64-4353-47c9-4ed5-08dd1879c379
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S3FnY0MxbUFTVi9vaEtNMjRrbkhmbDArV0hLRUgrcGdRYUVLMC9xNWV1UlNu?=
 =?utf-8?B?aE5aTEtpSWZGU1VmdE5JUjhwa2dZTUIxeUdUYTJNMTBIa2lRek1lc2Q2ZHNl?=
 =?utf-8?B?dlljazJOVjZCTjhWVFpMRnQzYTNHOTJYTytNQjB5enorazhMaGY5d2o0WTZj?=
 =?utf-8?B?clZpYnJHNTIwdGhwSmpNbWpZMC9KeGxueEN1bkxHWmlnTFI1dmZKVkFVc0Iy?=
 =?utf-8?B?Zms1SGFDc0N4Q1ZFNXpXdTNtSnd6ZjBPenl5OWFsdDJ4andoUVVOQU5Nd2ND?=
 =?utf-8?B?eW12TmJOaW43cEJWd1FxYjVqZUpQRXBuNVd3K3ZZTmJRUCtROTBqYUxaM2xP?=
 =?utf-8?B?azlSWkhHekdJcmt2VWQ5VXNTcnlkeExveVA0VGNTdEVNRDVmUk5scW90MGVM?=
 =?utf-8?B?T09aeWdPTmZDMWp4dTVEZHIwczcxcjE2THNFQVRSc3NJUjRsV0VsVjhyUXpq?=
 =?utf-8?B?VjF4MDdHTFUzRTNpN0lNRkpUSlRGa09RMUlVMjBiQklGcGFrK0Z4YkV4cU1S?=
 =?utf-8?B?dzV5T0V2L1FlWGJRSm9QKzNVQjdJVVZMT2NjUm5DMWZremtTcThWQ1l2ZHNq?=
 =?utf-8?B?S1lSaTd5VjM4Z2hXTllHTUQrbUtPTG51bWxWNlRLUW9zeHkrMEZ4T2E4cU8r?=
 =?utf-8?B?YzBMRGtraVRUOVQrWTIzTTJzclJpZGt1QlpGSnltRmVKVU12SUlGYXNsK0Fl?=
 =?utf-8?B?M3RxeVVhaHpteDhYZ0dYRzJMYXByWlh4Q0YwV1VTMGhjRTEzQmR6UlY0MmRs?=
 =?utf-8?B?aVpEUkpnV2JnemVrVkRHY3lGa0NMOFAxRzRFckhtQkZxdC9QdGhQdHpVdXZq?=
 =?utf-8?B?WEhFQUJtOHJmcFo4RFZTaWN4SDdGUGZDdWtLandNWm1McEwzbmxrK2tzMkVi?=
 =?utf-8?B?cDRXUnlMTDlRa3ovNkVWbUtBVS9keXRkUGd6bkt3N3owZTdRamR2TUJ5aEx6?=
 =?utf-8?B?cTFQaHVScllCMlRSeHBkdlMwMlhmclRBaHlRZWk5VWk1QkR4V3hTb2Y2bk16?=
 =?utf-8?B?QXdNdGJoRlNGUjljVFB5bU5aaGVHNFhYblNlWkVXNXlFRm1zU1cvZ3FNYmJQ?=
 =?utf-8?B?LzdTWURuQmJEWEdJYWFja0F4T25vWmhYcHFkV0lLQk45TmFzaEJGTUFGRll1?=
 =?utf-8?B?N1hkMzcvSUQrMEVpVjNsT2RSKzlpMmtDczkySFFGb0k5aDBKdjhNR21tdGVp?=
 =?utf-8?B?S3E1ZVpzMGQ4Wm8wVTRZSkpLTCsrQjgwSkovZmtxTThSaXMzOXJCdlFVbStZ?=
 =?utf-8?B?QTJ1NEhHLzcycE5QN2tXWDE4d1BpL0F3dXBSK2pEYytEWTZodnVBNy9xS2xW?=
 =?utf-8?B?b2xkUlduWStVWC9RWWFRbkJ6Qks2VFBxYi9lank5SW5BVTZETHBSbEtFVUpw?=
 =?utf-8?B?TXJGUWJrbE03OXV5VE81T0dqVkxPbFZqOTVsektnUzJta2RPM1lFWHAxRDRK?=
 =?utf-8?B?MlFyZHF0eG9GRGMvRHlXc0VuNDdJaVJPUGxUK0RUTi84ajdqbzNJbU9aRTVw?=
 =?utf-8?B?dG13UHpUcWFSdEZJRlBHU1AzbzF0WHdzQU4wRENweG5wWXh4UTBDUVlTVkpG?=
 =?utf-8?B?M2kyb3dYRmd4Y2ZwRXF3eTAwS2ZnNG1keXlqOXllQk1lTzZjM2xhVFczS1M0?=
 =?utf-8?B?dVgxNDdrYVEzR3JnQlczSFE4YkUzOVFvNWR1dituV1M1dlpoNWxUbXlXL0pr?=
 =?utf-8?B?cExBeHZJWTUxN2Rvb1F6ZHpWVm41Wit3M3pBWHl3YnExK0NDanRpMSttSDY3?=
 =?utf-8?B?SEN1QXNhdXNTR3BUVkR1Y2haQ1ozQW5iZk5LdDhkYWVVWjhSbDVNdlU1bUJl?=
 =?utf-8?B?TXZYOVNMYUN5TGN5NURGSlZUV3RwYkwzOFlsTEtEZXpxMVg5bmhaYkU5ZmdN?=
 =?utf-8?B?aUtKMzUwM1NxZEZKV1hxLzY5aEgxYjdqd09uNVBwL1RJU1hiZXVEREZ2Z2JP?=
 =?utf-8?Q?DnX+2cSbpaI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2NrblI5aHVINks3M0o1U2lBS1Z6allKSG9HN0JkYllpQ2xkc1l2cHZRd2Rr?=
 =?utf-8?B?L04zNFRzTjVFV1I2MDU2RHRlMnM4aGllRFplVnlpalRuN1dNVzVIYW5zWWlZ?=
 =?utf-8?B?Wml0dHRLaW9KekVzWXJ0blNWZDJZakIreDB0eWR4RnErc3NZS1IxZ3FoSW1H?=
 =?utf-8?B?Tk9OWUJkTXNISFdHbXRhQTZLd1hjaFFTeDBJeW52ZGtGQUtqa1RoKzJvQXk1?=
 =?utf-8?B?OGtaYTNFeURiOGdEZC9UblhxQ0VRMmVlUGUrYlVUVVlIZC9DOEU1UTJRbFFJ?=
 =?utf-8?B?Rm1qeldyZWtzVUc3d3FIZlM2NmtRT1pud1MycVB4WEpMNmNPQmwxbGt5eDdu?=
 =?utf-8?B?RTU5eHVDTkUyY3F3NTVpWjNYeDRvYS90bVVoRWFIeHl2QWgzemtLYThUQ1JF?=
 =?utf-8?B?OFVtcEhNdWkyT2ErRDZMTTUwU3BxNHBLUk5MU1phZW52QzZXME9YU3p2VXp3?=
 =?utf-8?B?NGExZVNncXNrRzFsem1vNU8rZ3Nrb2VSZmlqWUY3TVhkWnJMZFdUTGxDZ2Jq?=
 =?utf-8?B?R1RzVEhRZTlGbWZncmlDcnRJWUMzbUZFaGRtUFVMZG1MMHpST0haTENZVmk5?=
 =?utf-8?B?bG5GUm0ybHQ4QytUVzBkNm1hNmc2LzdGOGdnUXQ2UkU0b1Q3azh5N1hQNVpn?=
 =?utf-8?B?M08yMWVVWExQbVd4bkt0dGt0akd0c3dKK1NZU1JNTEhpZUM3a0ZKNTZGYm1C?=
 =?utf-8?B?ZXVnMmtqN3Y1MEpuZlVHUmNFYUdnMzFKVWk1VDdWZ3VWRFMwTlFJMlJadFE4?=
 =?utf-8?B?TlRKc29Nd1lUTFAzK21qWjhMcHNwVDF3Nmc0ZkxjWkJmQkVTVXRJTTIvVWox?=
 =?utf-8?B?eUtSU2tRK2cwU1pxVTR0SloreWUvRElhZFRVSCtVamFCK1AvOEJkT1JSalNQ?=
 =?utf-8?B?d2orOVZkYmd5Tm9leG1xZjE5VVRxSENXMG4yeWR4RStML2VoWVJ6YjVMQy9G?=
 =?utf-8?B?cnU4NDM2d3FwL1RwZkhWWjdVRU8zeXJndzJLOGR6NmpJNHRFK0ZsQ3VRUHg3?=
 =?utf-8?B?M2NlSDFJRy9LU0dpZEZuWTkzWjhyTUthTkZRUlYrQXowK2NGdlhUcFJlSk90?=
 =?utf-8?B?Q0FpNVNKZmtmT0N4b3B2K1R5QlJyUW40TGRuMFR3M3p3LzVMVi95VERoZVR5?=
 =?utf-8?B?K1NUVkpHaTZPV3phNHpxN3VWZFpPRFRTNkQ2RDM5c0szc2JERkxWa1pRYmU3?=
 =?utf-8?B?MS9hQzEzZUpNbEtLdGNEUjhmVlMwNTl1M2Fmekkya1YvbzZ3SFNYZFJwcGFk?=
 =?utf-8?B?dWx6eWlmUktRZXhpSzFNbTU1dGQ1cktrL0tmYXpJckIvQ1JDZnMvVTUwK0g4?=
 =?utf-8?B?b2VuZCthSjBOVWFwQ2Q1NGtnYlJHbnkwcG51TUVSQ3RGV2ZISUpoVHdzMVlZ?=
 =?utf-8?B?ajRxQ0ZOSkcwYUR3emtpZUN2S0tXVFEzdWpIZzZMdENOMjhObEExWVpwSkRT?=
 =?utf-8?B?ZjVEbGZaRGVoeUppSjVDQVRpalA2MGxuM0F0UXBsWG5ENWh1OVlQUy9TRSt5?=
 =?utf-8?B?aDY4aGJwSTcrOVM4aXpjWlFCUURwTng4TWQ0U2s1UEp6MERQT01VZ3VQOStp?=
 =?utf-8?B?NGlKVkIxUmw0UUtwQVQ4ZmkvNjJOMFJjcXE1eUNDZDJ6amRnWWJmRTdpc0U0?=
 =?utf-8?B?SERBL3FiRnhLL2lEZnBaNnoxbFNOaUtqVk1aYjNyREhIU0ZueUZxSTNxc3E5?=
 =?utf-8?B?djRkL3B3S0dhcHNzUFY3WjZUdytNTUJSWGViYjFzVDNkdnUvVUtKU01lQURR?=
 =?utf-8?B?djJ6WkYwQUdNZTl5K0k4K09Sd0hYS0pJMWZieFhNWkJDS0ZEc0JwK0trNiti?=
 =?utf-8?B?OGgxbm5qSlIwT3o1TzFNM1JsdW5IRGMzbHhrU0VFVWQzaENhZlo3ZklSaHlt?=
 =?utf-8?B?WnNlakcyeGl0ajdudFVSMVNSdHBNNEVYVjhXbThoZStHZlVFelpLeDcvb2tj?=
 =?utf-8?B?WWV0dGtLNzdkZ0VIck4yZ05HRzc4K3Bhb1puYjV2ZUxBdExFYjEweTkzcjM2?=
 =?utf-8?B?QlNIS3VyRlU2VVNDQmxUbkdVOW80K0xvZ1MrTVYxVWkzYk8rN25VZE1EaUN3?=
 =?utf-8?B?aWtmcWhIVHYzbDFQb2NaS0owSkkxbDhpd3dTNUkySHhJRDc4R2drS3N6aXNP?=
 =?utf-8?Q?fu1tJCRLhofGm44AcRwOmdS+e?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93ef8d64-4353-47c9-4ed5-08dd1879c379
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 17:49:00.7013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jzosXSegx4n4avDop9h0qMf9tGQZphrbd1JEZ56yoRfkWTPSPQs+5KhI483cHerdfwQBY31y3NPZpv0J3EMWwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11017

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
Change from v9 to v11
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


