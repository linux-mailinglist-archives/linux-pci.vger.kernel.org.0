Return-Path: <linux-pci+bounces-18183-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A6A9ED7FE
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 22:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 999D9188BF4C
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 21:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF26237FF6;
	Wed, 11 Dec 2024 20:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="k4Uczbtz"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2049.outbound.protection.outlook.com [40.107.105.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEEF237FCB;
	Wed, 11 Dec 2024 20:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733950685; cv=fail; b=etfvDxg1jEHsTbkq4S9N/YZceqVGjiuCL2u7MwTrsW30N/e0jwl5yqEqk7UpSpLrGm0FjIlqi6apKpMW6rBj2PWBFtLypiiYBI3asp5AtgZwiX52iangKE8qmQlptT/lhjRkcHY/xtZI8ZjMvAtKoAPez43ErIAtS2xXwtTUms0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733950685; c=relaxed/simple;
	bh=9MukYG83d9aOMQcFVfHOi1d9Wyi9uvJG5YjZivBzTwY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=s8Pa8aPwJHo64QwY6zxLrr3tWg0JJ24CfyC6yQ20cVSgOAgFnQGg5zzxyXqbTmyMP53Np0Lb4gWUlb1juFQE4WvM7HyiCYqjHZZ/CMvmaEIaTdd6WeWclyZgPxRJLpyJG87D5qxSHju+7W2R+lvz8SsIfTXFa1+MjvSxmqkpOXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=k4Uczbtz; arc=fail smtp.client-ip=40.107.105.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CgebTg1x7Qh3Ks2Pn/T45WngaC0EoinTlC0ZeVcYR6RZhOZHazoSVdsKemKEXvNfAUVA8ZlR2h8nE/qufWsI5oFowG/XeF8Fki2C9x9UuMT9zfgNbsVtcz1zk4+tPECP9lvqTb4ZcOjVBs3SEVHb6g3nqOXmMvNgBHdR25VJL1jqVKcnN1oMMoE4KovAO7D8Kok/172whRF/Ywq98yfJHluDXs0GOk9jrOHfDZLYtWMm1V1v6c/HyNSMh4RO7LTQdOFHbJQa3z6rPgroRaZtXpouyhu3ha2eW0+Vxv5bcaSuKx5SDiUpAbvP+ZoEMg0LGGqkOgH4XPEHyImC+vn3Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8rHiESil2o4GbVOYFQ7zKfqjJLUUmLHnPeQkTukgKiA=;
 b=mPi97jM5rQPQNlkZD9evyAcuGOBxBN4SAv3v6khQbiTQQdJNPCT4tyM0JSdhP6YzKKI+dMaiiMA1KE8s/rFB5nTWPvfD3bztSZeYMcFr/wTkIK5PsgFzXSMXAiGwHVsoDJoeid+EazzazazrY/M6+KDEj0RQVZGyqy7YNSu3AWURDq8tM/pHA2QJrIHJWiK3G3PP+JdWl/zups3wBihSPOhHzWZf3qCX3So1sWWZKZ4hIXbu1RUsn2IF3ngI+STNOXzn3/fwHJnzOROURjIVSkcx8zVRh9IDRDbwq7YE4w+N5n6Er5/H6YSikkGq/HvCSgKl3R8pU1x1Vul4AdcNxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8rHiESil2o4GbVOYFQ7zKfqjJLUUmLHnPeQkTukgKiA=;
 b=k4UczbtzKHIZL4xBCfilESkWLAkrGJS/dceN1TH0ZbbgpHrj4V/UqYFtmXA3p0ApYzskETtYJhZ5KRq0Uj52ecI3svFXC/j9/i9/47ZfpGS/dllcfdmrpRl6fj2/2WCSKiRREc8c3B4112BjDZksHnN12NT0vjzBa16x9B2F9HG2KDxM0eKLr0WXB1vmASYraGb3PnCpXfTkTLr7CylKVh6DzMCbKmPgVh4kVBrzWlYiM29C/jyPbbFOFTfiKPp37F3VczFMd5HVwgvBVQxAqwB52+dx7LqgmPEavCX8LS2KOqT9P5whCenG3EixanKJUuD5QNYSgVT/cwzpMxXTZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM0PR04MB7139.eurprd04.prod.outlook.com (2603:10a6:208:19d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Wed, 11 Dec
 2024 20:58:00 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8230.010; Wed, 11 Dec 2024
 20:58:00 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 11 Dec 2024 15:57:31 -0500
Subject: [PATCH v12 3/9] irqdomain: Add IRQ_DOMAIN_FLAG_MSI_IMMUTABLE and
 irq_domain_is_msi_immutable()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-ep-msi-v12-3-33d4532fa520@nxp.com>
References: <20241211-ep-msi-v12-0-33d4532fa520@nxp.com>
In-Reply-To: <20241211-ep-msi-v12-0-33d4532fa520@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733950663; l=1853;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=9MukYG83d9aOMQcFVfHOi1d9Wyi9uvJG5YjZivBzTwY=;
 b=Fb3dWhQjs0wMRJeR9Rgmc45PlhjuOYIJ98UBQhBCRcCQwpCXcrxFdvXuy5IhZ7UCjV+3pggm4
 1hN/K69HGbzDZAhCIqalLf9rskSXVUh53UX25n8DdMf5TublZOJTE38
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR01CA0037.prod.exchangelabs.com (2603:10b6:a03:94::14)
 To PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM0PR04MB7139:EE_
X-MS-Office365-Filtering-Correlation-Id: b5c96464-778e-4563-e086-08dd1a267f84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|7416014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U2F5NWpjeUdNRGViUTd2bDRKOXNBVldRNlhtWFpLNGM0aHprbEpZYzUxbFdy?=
 =?utf-8?B?YThPRkVCb01Id2ZXaEJwb09FcTE0dnpZUHRXcldyRXRWTU1tYzdNZlZMaG9l?=
 =?utf-8?B?bU5keEVUU1F6b1F1bkxFQ0w5eHRDOFVUT3VDQnpMRVh6M0J5dHJHYjYwaWVs?=
 =?utf-8?B?cE1ZR3NwY0s4RlA5a1JrZGtmNkR1eGZ2aVJlZmxqbEx0Ynk1VGd1aWlMdTRa?=
 =?utf-8?B?aEg4Z0N6ZTllOHRzb3VqMnhKaWFPb0V0UHFiT3JlMzJmRW9qM3p1Uzdsa2Vx?=
 =?utf-8?B?TUo3YVp2WjFjL0ZiR2x4Vkh4Ti9ndXFleDhqWHc2ZUZ2d3JzVUM2eFRQYnZF?=
 =?utf-8?B?WFp2VHd4MVZKSytlc1hpYkxadHFnZk4vek1Jb3dubXVYSndJQ1JVYk1SQ2xy?=
 =?utf-8?B?aXVoaTFJYVNxZGJsM2dHa2NTb0dBYkxtcjFoUGxIZUcvbE15WCtjK0Qra21G?=
 =?utf-8?B?YzNhMkRkMVZsZVM2TUhEc0EzU2dHd3k1eW1HM3Fub2pIREJJcTNPaUtQZDMx?=
 =?utf-8?B?RG0vOEh3dkJlSGpjbk02YldaVE1tZTF3ZHdzTzZlRFZKTmw5WjA2TkkwaWpC?=
 =?utf-8?B?cE5hQ3A2WnJzdmVoWis3MS9KdGNTNlptZis1WjNzRGROYlcrSFA1RzV6aXRX?=
 =?utf-8?B?bjAwSkYrNmJDMkF3Tmk2U1VyT1BaZEVLQkVkYlp6VnFjSlYyQTFUMUJ1NVJR?=
 =?utf-8?B?NXcxOW05eDZnYlBDTFFGOTF6dXJZSWU0WTZiOFUxSHNad2VVMFljV09GWFov?=
 =?utf-8?B?RFl0T2FiZUk0M2RzUGE0U0Q5aXFvUzJrMm4yZ05vbDBhMmUxSFNxOVRGTklI?=
 =?utf-8?B?NzhxcEE3TzAwSEg5QXE4eFNzMFNyRkFiUFJxTHRVTWRtSmtVbTJkNzBOaFNR?=
 =?utf-8?B?RUo2bGhORzc0ejFNMVFwY3h2UkJwejBoQ2hDS0RzczEyVjdmTzVLOU02UnAv?=
 =?utf-8?B?K3F5VUlJeTY3dXU2WnNPVlFFNFlWaUs5SkdtWW5XNTNGc3RHZmtpYU1TM056?=
 =?utf-8?B?WlJFMjNDeGxhR3pScUM1d1VGODZFaGI3UzRibTRJTzlRSnFSbFVSK0JSbGg1?=
 =?utf-8?B?cVFmazgwQ0o4TzVKWmZtdnAxOHA3WUhqcXVyTUJLZm4wZE43QW1pdVd3UXM3?=
 =?utf-8?B?eVN1dXVCWDhPYzl2c1JUSTdocHQ2cUFubmVzK1pja2d4UE42ODVvQiszOUNE?=
 =?utf-8?B?YW1sRytaUEN6TE01bm4rY3VDMjlkeEwwdFBSZlQ3ZjQwNDJIUVRKK2MxY2tK?=
 =?utf-8?B?aEtiUy8xeUJ4TGZaTElYQmg4SmFDODUrRUM1dDNwREpwY3FQeEdpeEFIYThG?=
 =?utf-8?B?Zm4zMldtd09wUm9nQ2RKbkRoUXVTTVQ2Y2RpREVDdkNORzF6ZE9IUHN5NVlj?=
 =?utf-8?B?elc0TXMvekFEMzhtQ3crV2p0bGprMU4xYmE0RW9keHhnUmx6MTd3cDNvS3gy?=
 =?utf-8?B?Yk81MElGVWNZekI4TXFHOFNLSDBTKythUVJXUUgwek5oOGdTUjNJZ0ZhT211?=
 =?utf-8?B?MCtLRmE1alJTY0s4SndCd3ltNmo2QTM5RjBYZVRqVG95M0VWTnp1YlFhcWVS?=
 =?utf-8?B?enhNL0lLYnYrZTZPS2FNNEpMSnVrNEIxNThjbHZNRXVQVW9DQ0lPYmMyWjFI?=
 =?utf-8?B?alBUUm80dEpjT1k5aGZXbXZvbERQVVpEeElha3dWbzBkNEpjMVlBMTZMUUFE?=
 =?utf-8?B?bG4wakkyNmZ6Nk5hZzR4cUY1bkdYV2FhSFlacnJEblpCZUJBdU5ramVUdDI5?=
 =?utf-8?B?OUJGZEpiWVVwK05lUnVMUWF4TGxwZTJqS0F3K25Ob1dEbWRtZ01aYy9YQUdY?=
 =?utf-8?B?OFNkeUd6WnphVjN6L0lEWFh5cnZ6Z1YrTnUvK1NqUEZhOEV1WEtqMCtPNDBq?=
 =?utf-8?B?blUzYXBmYXJzenVWRnpDLytQRlJVTEc4enJYYUNhWmZTajZyOGx5M0F3M3JC?=
 =?utf-8?Q?2lyVut+w5jI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(7416014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ellHMGV4eXBtVFdnNy9NdjB5bmVQcjhTemI3djNsMHlNZXgrYTFKTHkvTHB5?=
 =?utf-8?B?YjVXM2lzN01tZU1iZWRmS1ZrTzBKbGFrZnlFVkhHZE9Bbit0WG5UN2hETlMw?=
 =?utf-8?B?SEVNUnlQc2s0V1E3Qk9HbUdBYmJQQTBJOXhkK3dzWkFWYm9nbDNVVjFGWngz?=
 =?utf-8?B?M0tsR2FiTUV2bFU3TFdHMEp3dnBJb2ZUNmNTeStYNEtiM1lQcWh2UVo3SUR4?=
 =?utf-8?B?L05sRkhhZEt3bVFWdVNPbzhZdmw2eXFPenF1UVZPVndoM3dRRElYWmFEUzIx?=
 =?utf-8?B?MlpSNktlTkpKMmpVNTAveGFrdFJibVJqWVhMdFFsNk9DNU9oZzhYQWFGNU1O?=
 =?utf-8?B?WCtIVzZIWDNXbHlpUU0xTEVETXpRdjhjN0FFMk1wcDczOUszOG5uTERydXJy?=
 =?utf-8?B?blhVMzBZUmM4WEJlL0o1VFZadUZGUUJYSytYTkhlaFNvSWswR0VXRjdwOC9M?=
 =?utf-8?B?OUI3UzhQUVl1YVIvR3lVQXZVaGtqbmZldEVHMk5iVW9na0VjRGZqZFRPR3Rp?=
 =?utf-8?B?VEJlekdSaFVFcmZ6ZWl1Um4yS1U4bEg2eEV4YkpOS2NBQ2xCTDQ4cFF3M2FU?=
 =?utf-8?B?REtYMGFGdlMvd0lBVGxUaGtickhnSytxNG12OVZVMk1kN2VYdzd6eWcrQlc0?=
 =?utf-8?B?Y0xVaU5OUU1GdkRrN0ZSMm5Vem9MajZ6YlFSQndXZXRXRjNLN0lITmJEZXVw?=
 =?utf-8?B?TGVUZE9DSmFsaEJvQWtjb3Z1SUNqakhvdUVaY1l5RXIwNVEwK1N1a1gzRWRl?=
 =?utf-8?B?UUlKeUtFZ29OYWxBUjBiT3prd3J6TFRTaTZveWcyOVJSOUV2Ym5EeEFjSm9V?=
 =?utf-8?B?d2tHcG5VSGdHQmxKN0ZHbkZFMkRLeVgvSHVvUG92NnZkdkppeVVIT2RwNUFE?=
 =?utf-8?B?dnRNTk00M2Z6dXE2dTZYSnZwaFBuYm5oQ1JONkxyZFdWQmhnc0w3OUJubzNk?=
 =?utf-8?B?WEpab3pZejd3eTVOQ1VUSGdhQ1FpcEI2U2J0ZURTU3UvYWxuMUNlaDEzdTYy?=
 =?utf-8?B?OE82ZHZ2UCtlYUE5L1ltN3FQL0lvMmZZcVZSQ1B0RlI2bHAzTlYyR3EzZFpN?=
 =?utf-8?B?UXpYMDdOaW96SU1QSGlnYWhFUFRrbmk0TWVXUTVleDVkT2JxNUd2amFJTmVy?=
 =?utf-8?B?dHVlWEJXdG1mQi94NmxHUU0yNEhHeHROZzZkV01UNlRxY3BUNERBbEw5NWh4?=
 =?utf-8?B?ODMrRVhtRTA0RGN6WEtOSVlaSHg4NWRxRXBHWXFHNHhVNzRaOXhUQVNoRE15?=
 =?utf-8?B?amFrb3YzaTh0N0lNblc5YTZzM1ZFY0o3MUhjcTVBYkEwT0R2SjNPU2tsbFU1?=
 =?utf-8?B?MDFiTEVHMGFuOWFVOWJNTkJqU2kyUmdpS2F4Y0hNZ040eW9CQmswZk9TcDNu?=
 =?utf-8?B?VnJtcFBxbjUxVytZeG1lUVBUMzFhd2IzWWdIUE51ZkRUYnhxK21WZTQyRmZy?=
 =?utf-8?B?Q2d2cnFodk40WjBTUDRqcWZXWFNwNGU1VE40R3FSQmYwWUd4c3VGekp6L1hZ?=
 =?utf-8?B?TnA4L3JXS2ptSWN5aCttYmZ3bnQ5YlZIQnI5TnFEOTc5bXlIeHNaTHA1ZG53?=
 =?utf-8?B?b0RPYktEaTF2cUllcWI4QUlWSnBmN1k4VkZHWHd1dUhkQVBEK2xzNUFWT0hQ?=
 =?utf-8?B?T3hLWnhTNktaV0ZXbHZPVjF2ZmZkdDUrT2lXbkFPQVVleG1FVnRLUlhlYjhI?=
 =?utf-8?B?bUJSUnQxNzU0RnVkRFliRlhoSCswN2hKWFNkb3h2MWRjSjc1azBFdXBVSEpl?=
 =?utf-8?B?bi90L29YdUpUTVBKZHA1V3NQTExJdmN0NlZYc1dXWmovM3U3MEVXUzJieVRa?=
 =?utf-8?B?YzB1aUtlMTZHeks4Q3JYYW5KZnNLOGRxbFZvNExQRXFLcjd6NXpLTE5YQmh5?=
 =?utf-8?B?TFJWU0RmUHdRR1QyNU1RVE9rT2hCYjk1Z1dDNGNNdjBkSUlvK244M2dvS3FO?=
 =?utf-8?B?aEdWdG4waG9HU0FlNGxpWUNqV1A3SFQ0b0ZLb3Uxd0R3SzdTMUlUWU9qOFNB?=
 =?utf-8?B?Q0lSMnVnRGFTdDY0Y2pSdXpTUDV0NVd6a2w3cHpDVnR2R29naThObVM2OUZF?=
 =?utf-8?B?TEh2NmJxNHI2NDVjeW1tWXJobVVOUlJITDFmQkZOYnhWZ3JaNmtBL092Nzkz?=
 =?utf-8?Q?aUQx8Q4A5vBVR5OIzYa8dCFAl?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5c96464-778e-4563-e086-08dd1a267f84
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 20:58:00.8211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1lOlnrQ6Rew14b5qaCep7jMOVKiOcCji09xhkIV2XiM6h7iMlb564UYTqyHFerdhtPvD4BsoiwLaUJ/jhP6H8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7139

Add the flag IRQ_DOMAIN_FLAG_MSI_IMMUTABLE and the API function
irq_domain_is_msi_immutable() to check if the MSI controller retains an
immutable address/data pair during irq_set_affinity().

Ensure compatibility with MSI users like PCIe Endpoint Doorbell, which
require the address/data pair to remain unchanged after setup. Use this
function to verify if the MSI controller is immutable.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v11 to v12
- change to IRQ_DOMAIN_FLAG_MSI_IMMUTABLE to minimized the code change.

Thomas Gleixner:
	I move IRQ_DOMAIN_FLAG_MSI_IMMUTABLE to irqdomain.h to simplify
helper function's implement. But I am not sure if it is reasonable.

	If you have any concern, let me know.
---
 include/linux/irqdomain.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index e432b6a12a32f..e63652604b621 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -231,6 +231,9 @@ enum {
 	/* Irq domain must destroy generic chips when removed */
 	IRQ_DOMAIN_FLAG_DESTROY_GC	= (1 << 10),
 
+	/* Address and data pair is mutable when irq_set_affinity() */
+	IRQ_DOMAIN_FLAG_MSI_IMMUTABLE	= (1 << 11),
+
 	/*
 	 * Flags starting from IRQ_DOMAIN_FLAG_NONCORE are reserved
 	 * for implementation specific purposes and ignored by the
@@ -692,6 +695,11 @@ static inline bool irq_domain_is_msi_device(struct irq_domain *domain)
 	return domain->flags & IRQ_DOMAIN_FLAG_MSI_DEVICE;
 }
 
+static inline bool irq_domain_is_msi_immutable(struct irq_domain *domain)
+{
+	return domain->flags & IRQ_DOMAIN_FLAG_MSI_IMMUTABLE;
+}
+
 #else	/* CONFIG_IRQ_DOMAIN_HIERARCHY */
 static inline int irq_domain_alloc_irqs(struct irq_domain *domain,
 			unsigned int nr_irqs, int node, void *arg)

-- 
2.34.1


