Return-Path: <linux-pci+bounces-13339-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E854697DE80
	for <lists+linux-pci@lfdr.de>; Sat, 21 Sep 2024 21:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41B49B20D82
	for <lists+linux-pci@lfdr.de>; Sat, 21 Sep 2024 19:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9631D3F9EC;
	Sat, 21 Sep 2024 19:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Nk5v3wG9"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011028.outbound.protection.outlook.com [52.101.65.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A84A1392;
	Sat, 21 Sep 2024 19:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726946350; cv=fail; b=ATNOLU4+hcWShjSTOnBMYS44tA288DrME1J23utjAqfU7rroRUn8uQ7NhLQMqKgI1njosW9W71sbTGjCOqFGk37JEZd00XHeDFf/gBSmUjyHsQUHhLixgO8+gXpxrEtTT6cMyImJ2mnxcnsIiX5BUTG/1P+vN9PHKWmK6wHlTI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726946350; c=relaxed/simple;
	bh=AvgOki1xUhGQrStiba3J79o87Y7e+wprk4arQo9qB5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dH4oCRVEq96TEF09clxNqyebbobbwmKjw77e7jTxKTPRJlAldS0am2oS8Vc2QJtF/W3TX8x6j8fHsGsMkPRYFGIt2U3DPdkDcY3J+aQX9muZh46o8Ze6nQU5LY8TPbdWrvAcacCRJnkc/gEC1RZVRIyXlhUY/kw8vn/mZenRLaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Nk5v3wG9; arc=fail smtp.client-ip=52.101.65.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MKONb9U8qXiL8zMWl5nGOq50W1B5SLyZ7BimGWl5WgF/ELdCj7u/8iKfprAXBRjDn/ZVSE8eu53XNUVsb70bJ7Ctik7MaphrAVtYMACHmmo/wgYv3jnOTmXVXNo8NZUBMA1XqdtpsgYW1JRtANJ1Zyagq2r0wHlwQV3WIhfui3g1SfuWXYeV8nCCI3MKGiPxRIl0H/6iXEiCuS1mXtc+q5DGZvEtSG+OjV/JwU+LcSnRMDB2IYrzZsXirTLDya7xzJfbXEZj59WBrjkJLAV+gOvzO+Qr58n8381J07to4Y8L/kmCH8Og4u26AL9A5F0NGIX6++qNCIGNA6Clv/+voQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/Jc8mdQgh6vL3Uimk7pq8HUetXmYPfbV4B/toV1cQ4=;
 b=TPRPn7g1MStM3UQUCtkzXFhASsXTb5IA/OmZFzgnPPU964tIveQIuUCOkwEje764LiEJQwUHs6H4A4fMrITUya0VhNGovLelSQRqqQsdWhFy9FH4qdaOz6N7DYe3IOHeT9iu69LHQ5fZsEO5d5YDWBYJ0vr87f/fNvlxBFLDivCN/l2qXk8j76afcaJHFN/qL3JhQZHfFxWBN5awz7YMbEZr4eG49KXVDgh0usXBbw/JKMB26tOsqLrYV8ChVVPQ7uhLtn7FtkcMs8TT3UsX/KCjOZ2gMQU23Sg+Vykw7DAY32Ubbi3jvzxEVbYO5DLmYcFfw0H+opoCUdj91sd4qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/Jc8mdQgh6vL3Uimk7pq8HUetXmYPfbV4B/toV1cQ4=;
 b=Nk5v3wG9H7T9mNP1s7RXO0Fw0e/jpmrIvyz9IDMVyXA4//l+QssFmq6R2x+8Fwow6XJR+6iuDmhi0TvXlWyip+v+sfdgm2Ty4zHyJqvoDd/ePFKUI/0z5q7I34SGcN+kboblpOpRpRygGVf8yLEqzBT6AwJ2vbVc7tjkV7B0wNh18nAyO/Yqcyvg+c2V2o7ruloaAo7tDNPFYz12YfrMv6tZmcoC+GY2zbpnkAa7ROvx2fyZlNUtbvteeFnOxMuHh9zZbAQZu+dxhUDEAe76OKGwfWMlk/oiq+lzx5Zcb7MpqyzZ2sjILF95X/wW2JaRhlpu85IOV7XWAqOrlprhFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI2PR04MB11073.eurprd04.prod.outlook.com (2603:10a6:800:26e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.21; Sat, 21 Sep
 2024 19:19:03 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7982.018; Sat, 21 Sep 2024
 19:19:03 +0000
Date: Sat, 21 Sep 2024 15:18:50 -0400
From: Frank Li <Frank.li@nxp.com>
To: Rob Herring <robh@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Abraham I <kishon@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@axis.com, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: Re: [PATCH 0/9] PCI-EP: Add 'ranges' support for PCI endpoint devices
Message-ID: <Zu8cGrPLbe/psU3m@lizhi-Precision-Tower-5810>
References: <20240919-pcie_ep_range-v1-0-b3e9d62780b7@nxp.com>
 <CAL_JsqJ7Of-0H+qW-ts7cVkeK0+4BR5mxocx00eVFKHaLfj45Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqJ7Of-0H+qW-ts7cVkeK0+4BR5mxocx00eVFKHaLfj45Q@mail.gmail.com>
X-ClientProxiedBy: BY3PR10CA0013.namprd10.prod.outlook.com
 (2603:10b6:a03:255::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI2PR04MB11073:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ca5277e-4c16-46cc-f708-08dcda724107
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NjlOV2lNeVJ1OE5KNHpURFl5SHhjOURxRnNHUm9vKzJYb3RnaEJMbGdLN3Vh?=
 =?utf-8?B?R29XOENZOXIzeXlrdzJ3enVyUkZSemlxY2xlcmVWR0dlMnRJVCtDa2dnSEZk?=
 =?utf-8?B?Sm13cW1TMDFsM3EzTWg0TytUTnFiQk9CZEM4R2gvUENYVDNNUTAyUGxLZEgr?=
 =?utf-8?B?N3g1SXVTZzVYaUdJa1RtVm1vTHVJV3dkcm0zZW93RDFMYnkwQ0RNdzhaRTRQ?=
 =?utf-8?B?ZFBUWXBobnRTQnpkYmxlMEp6RGVvTFd4dHFoYmZEVkhjcjZDRkpSWVFFY2ph?=
 =?utf-8?B?R2UwaW9pcFBtdndKdWV0T2hQNUlEY05lNkFnNEdMVW15dnBiVkk5VXUxNWFX?=
 =?utf-8?B?SzBlTVEwU3dMQVh5TmdRNmE5a2ZIRGpCUVdFd2QxY2xzbzhyMEdMM3l5THF2?=
 =?utf-8?B?TXo5aWhXS3JXV1k0azJDNU9RUFRON2N5SEt0YTBIOG1xRW40Tld1T1d6S0FJ?=
 =?utf-8?B?NzhzQ2pUQVQrdFlHcnhmZVJDMkYrMHhncjRIUDRKbXhmVWdyamhMaDlDZkw2?=
 =?utf-8?B?alc4QzJxN3g5YUt5SUZJZm90b3BFOTNVZFBCSTFzTVNJSlBVZDNnaDVpdVNr?=
 =?utf-8?B?endtc1k2N3hac2o3YzA4OUMzQmVsajMyT09JUUhKVVJOUnRjeHo1Z2VoMGE2?=
 =?utf-8?B?eTJ1MWJNVTUvMzNvS2RETTJHeVk5S25ZMjBoY2tnSWtYTWRuZE5pSVlidG1J?=
 =?utf-8?B?WXVUZnZwU2E0clBwaDNLQlVwSmMyK1ovRXVNdWRCVjJaY0t1aFQ5VHNrblVN?=
 =?utf-8?B?S1B5eHo4eklMQWtEZUdnQ0c1R3dEbnNkOGQ2THFmWDF4dEd2cDlTYkRudEdK?=
 =?utf-8?B?MUxqN0R4Vmx2SCt1bWI2YVN2aDdXaEZ1akJDU3JDRHN3N2ptYmlGUC90bmdu?=
 =?utf-8?B?MVBXOWVaQ1dKN2xtbDRsaFRPYVJtejRZUUVpYjJFbzZMS0hjZHZFTUpMT0hJ?=
 =?utf-8?B?ZkxjZTk0Z0VXS2xjeHM4a2lJNkhiL1IwYTRaa2xkazhpaForRmJUUzRoVWJN?=
 =?utf-8?B?WU1zckNaN3lFcVg2elJUam5yZlAwMklaZ0Z4VDVTemc5VmNnUVBneDhSOHND?=
 =?utf-8?B?Tm1GSTI5VXhmdzRoVUZrTCtiSHY2cDA0K25DK3IyUzRuVERLUk5WQVdJV3dz?=
 =?utf-8?B?akFXV2d0VjNtYnhhanlnTVN3eTVVUW8xVjNQQTJSTFJ4N3BkYURSNmI0REJO?=
 =?utf-8?B?V1F5elA2UmtVM2lMcW52a2dDaWhmWDZjNE5KTVNpY2crNGFBSCsyUk14TEcw?=
 =?utf-8?B?QjJ5K3M4eVFPdmsyNTZrd1pleGcxTmI0NHVtLyttM1cwbGxsKzJ5aVgrT29z?=
 =?utf-8?B?Y3FRYlhzdUd3YTRSMm5iZ1pUZDE5QmU5TDVKOWhsM1BqRTc1R2Y5VE1Qd2Jx?=
 =?utf-8?B?eXBrajVIdmtKU0lxUnBGejFYaHlubEdma1ErZy9UY1huOEhVZkpnaXczRm5q?=
 =?utf-8?B?YUhJY2VwYnIyYlFtL0xKUTFLbkdDVkNPZW95ZXR5bTlQa2hiblJCbjRwRERo?=
 =?utf-8?B?ZzJNVmVJNkZnc1Z0Q1oyd2RJS29MSWRhbnNaanFDRWV4MUxFazV0Z0RqMzJC?=
 =?utf-8?B?dEZiSUdNclZKNnNnSWF4VkkweW5nb2dNeEU0MlBlSG5Bcm11dHpWcEN3WUZa?=
 =?utf-8?B?ZVpDdk85NHdEcUVBSGFhK3ZDRGZYVzZUWVd0bWQ1Y1hORk1tWVRqRjQ5YUt5?=
 =?utf-8?B?dVlHZVBLSGZSSVltckpYT0NsR0dKZCtKTmR6VCtqcmRLOFdaT1phc05HVEpJ?=
 =?utf-8?B?Y0VId2hsS0dVcVpvbWYweGVhbVNqQ2hSOTdnVWVpWFBpejh2WFRqSUFHZUt1?=
 =?utf-8?B?bHFxaVpQRU9RVC9jVmNvSkNyYStnQ01YUG1sdmUwVE9YVzYxUFNhSGRRcUpq?=
 =?utf-8?B?alpTbW1ydnVFay9vZUNVSlRFeW14dmI3RmVlZzQrV0F5WVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SGNzbzlidnBWYTFzL3Y0a1hTcHpqZVh5a2ZmTUVla3VBcjY0YlN1S3N3REtR?=
 =?utf-8?B?REJHb3R0T2tueHRZQy9ZbXJoMWdMczNlNmJoZW9ERkxIenVXOWw1cjc0YTVG?=
 =?utf-8?B?SU84K2ZoVzhiTXh6UGZVSU5GY0svNVBURUIyZUlLVW5lMUxSV2JqYlpNam0r?=
 =?utf-8?B?QnBVVzdJZDg2aWtQcjhsQkkxVURxZE9CVkZvdDdRekluOEgvcDdwcTl6SGwx?=
 =?utf-8?B?WXd3STBjQVBsaTF0OHRqK1ZvR1NubGVXQ0tzeFVhZitlcndZQWJQcVFKNnB2?=
 =?utf-8?B?V3JnYTZlOGk3Tmg4cG9SQzlGVmg4NlZsdWUwOEs1MGh3RzBFQ0xGRUk1Y29n?=
 =?utf-8?B?Y0VTZzI1WlNBU1l2bVNXdWRBMnFSTWJTMGZXNldTeldSWkJuVTMzQzRha0lM?=
 =?utf-8?B?ZDdaUjdYbUtzeWpIWGllM0hsem81cHJIZEFrWE9ySUc3SVFRTFNDL3RyeXhm?=
 =?utf-8?B?WVMyOU00cm9pYWg2bG5nekZQbUo4cUlteDJzLzI1TDZSNHhMTkpRc0c5VzYx?=
 =?utf-8?B?TXZNak1qbVQvNTljTnJ3R20rOE9NT2FKeTVJNWRTcXNieWh5ZFcyeFpuRzNH?=
 =?utf-8?B?SS9NczU4Y2dNRHdQWUt6bmhGb2RSVkxvWDZyQ3l3R3hpaTN0NGQ1WDFhdExr?=
 =?utf-8?B?U25yMi80NHpsM3hXbDErTDE3RktHVVBlTXphY01Fay9TN1NJUmFnVk1KR3V4?=
 =?utf-8?B?N0htSlo0dlpoTWxqOE5WSS9ZSlpBZmMvTXAxRmlXL2lvbXpWU3BlVHY0T25J?=
 =?utf-8?B?R081U0V1STBIQ2NLelVCQzJrQm1hWi9nekVHMW92YjBxbHdTSG40VG5TMEZ2?=
 =?utf-8?B?Y1IxSVFHUDU1MVhDN0VLSzc0ZmpOUTBjelRERUdKOU9mOEpDVEN3cHFGYXRB?=
 =?utf-8?B?ckFDNkJ0aEYrUjJUcC9md3NsMXR4ZEFLZWgwMG9UY0FXRDFqK1l2eXdqM1F0?=
 =?utf-8?B?OERQQmFnZXlEK2t2MEZsRFJBSEk4TjdYSnQ5REF2UlZJc2orTStqcXlkKytE?=
 =?utf-8?B?ckpzU3dBWTcvajBVL1l4NGE5SUdmVHk5dkVWRXR0dDBaSDNnRVowS2RCZkFJ?=
 =?utf-8?B?bVFXL3gxbzRQUmt6QTNwRjNGTFVzQ3NaTVlyWGdLU3Z2cGxxMFBma0VyVjJi?=
 =?utf-8?B?c1NaNVZ3MGdmNjV0QVQ5UUpQUzZuWjZ2NzE3dHR6cVpHa3JCc3VCclhKUENX?=
 =?utf-8?B?eGFUNGE0UEIxYVBlcUg0VTBCWTF0SUk5WkJVQ3VPMSt5cEZ2TkRGNkdZQkdp?=
 =?utf-8?B?TitIM0Y4WjRoTDhWYzZ3QmZiRFc3M20rUEk5Z1dqTnNPMUlKWHVrVjYybnhK?=
 =?utf-8?B?MXhld0pBbE4yYUoyQ1B0V3JOdnYvVFA4QlBLS0xMSW5Xcnk2MEkwVEpISmlv?=
 =?utf-8?B?RzNTYmx1dUw0ck5LU0d0WEdBUlE0WVVoRUtvTGVuUkRlbXh3WXdHeThHdVEw?=
 =?utf-8?B?dTQ0TzdJL21OTEt5OUcya3l0RlNPd1VPNnhLWkVNVmY1UDZKOE5PdmN1cnBq?=
 =?utf-8?B?eWNqbHlpNG05K0ZjYlJzSm9JSHIrbVdNNzhEbXE5Q3laRSs3ZDg1V1QvWmdO?=
 =?utf-8?B?bWRNbml4c3lrelY4a3JWNUlGckQ2Szh2K1ZVQUdjdkZsUXpQeVlqb3ZjelJK?=
 =?utf-8?B?a2Qxb1ZQZ3hVZGR4L3RjTFI0STlKeGkxUEcwQTZJaHFNNklwRDVDQmRjMnd1?=
 =?utf-8?B?Y2FSaHVVZDIxaEhNM1Y4V2hDQU1Rd29ucFA4ZHl5WHFXend0MUdpcWpVTWlY?=
 =?utf-8?B?cGVXN2EwTnlhaVpPUEdOdUw4ZFVsVldwa3FURlhtUWlFa280TTFjblNFVm1k?=
 =?utf-8?B?UUZUaG5UZHh2S3EvVy9jRG9NOVFkcnV1V1ZFWkdMd3VNQTc5dElnZ2thaVdQ?=
 =?utf-8?B?MG5LQnBaelM4RElDdG5KOEpGNGFSU3ptQkFQQ25LL2s1M080ZnY3N05zSm1W?=
 =?utf-8?B?cEFDT2dkOXpDd2RSaXh4MjBuL0tpYXltRUlwdkNxZkFwTmc4TFFOY1BmSjd4?=
 =?utf-8?B?UXpzZEtkSStySE5hcXY3QzZrUGJuWGdBR0JPTkxuRHFzaFBTMzRSSHpobkJp?=
 =?utf-8?B?aU9rNHF6UjJqa1NnSnVPTTBNbzhLZmk0RDk5aFNLSUs1eEVEQzl1UVRrRWs1?=
 =?utf-8?Q?Mv7lXek5hFnMvhoyw8Y9MQx+G?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca5277e-4c16-46cc-f708-08dcda724107
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2024 19:19:03.3936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d9O8dN1u5NPLtPcJfJR3uuhIKLqTiAg1lqjsPofjOM3BItc4UN1X+HJM6ue56XgeFpJjxZS0wAoiAAr07lz4xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11073

On Sat, Sep 21, 2024 at 09:43:17AM -0500, Rob Herring wrote:
> On Thu, Sep 19, 2024 at 5:03 PM Frank Li <Frank.Li@nxp.com> wrote:
> >
> > The PCI bus device tree supports 'ranges' properties that indicate
> > how to convert PCI addresses to CPU addresses. Many PCI controllers
> > are dual-role controllers, supporting both Root Complex (RC) and
> > Endpoint (EP) modes. The EP side also needs similar information for
> > proper address translation.
> >
> > This commit introduces several changes to add 'ranges' support for
> > PCI endpoint devices:
> >
> > 1. **Modify of_address.c**: Add support for the new `device_type`
> >    "pci-ep", enabling it to parse 'ranges' using the same functions
> >    as for PCI devices.
> >
> > 2. **Update DesignWare PCIe EP driver**: Enhance the driver to
> >    support 'ranges' when 'addr_space' is missing, maintaining
> >    compatibility with existing drivers.
> >
> > 3. **Update binding documentation**: Modify the device tree bindings
> >    to include 'ranges' support and make 'addr_space' an optional
> >    entry in 'reg-names'.
> >
> > 4. **Add i.MX8QXP EP support**: Incorporate support for the
> >    i.MX8QXP PCIe EP in the driver.
> >
> > i.MX8QXP PCIe dts is upstreaming.  Below is pcie-ep part.
> >
> > pcieb_ep: pcie-ep@5f010000 {
> >                 compatible = "fsl,imx8q-pcie-ep";
> >                 reg = <0x5f010000 0x00010000>;
> >                 reg-names = "dbi";
> >                 #address-cells = <3>;
> >                 #size-cells = <2>;
> >                 device_type = "pci-ep";
> >                 ranges = <0x82000000 0 0x80000000 0x70000000 0 0x10000000>;
>
> How does a PCI endpoint set PCI addresses? Those get assigned by the
> PCI host system. They can't be static in DT.

PCI address is set by other channel, such as RC write some place in bar0.

It indicates EP side outbound windows mapping. See below detail.


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


This ranges descript above diagram Endpoint outbound Transfer*'s
information. There are address space (previous use addr_space in reg-name)
indicate such informaiton, such as [0x7000_00000, 0xB000_0000] as PCI EP
outbound windows. when cpu write 0x7000_0000, data will write to EP ctrl,
the ATU in EP ctrl convert to PCI address such 0xA000,0000, then write
to RC's DDR>

The PCI Addr 0xA000_0000 information was sent to EP driver by use other
channel, such as RC write it some place in Bar0.

The 'range' here indicated EP side's outbound windows information. Most
system CPU address is the same as bus address. but in imx8q, it is
difference. Bus fabric convert 0x7000_0000 to 0x8000_00000.

So need range indicate such address convertion.

>
> If you need the PCI address, just read your BAR registers.
>
> In general, why do you need this when none of the other PCI endpoint
> drivers have needed this?

Most system, the address is the same. Some system convert is simple, just
cut some high address bit, so their driver hardcode it. Maybe imx8QM have
first one, they have more than one controller and address map is not
such simple.

We use customer dt property in downstream kernel, but I think common
solution should be better, other drivers can remove their hardcode in
future. And it will be more symmetry with PCI host side's property.

Frank
>
> Rob

