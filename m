Return-Path: <linux-pci+bounces-12759-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F8A96C1E0
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 17:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86A7A1F221D7
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 15:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0361DC753;
	Wed,  4 Sep 2024 15:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IJf2t6GV"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2041.outbound.protection.outlook.com [40.107.20.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C231DB55A;
	Wed,  4 Sep 2024 15:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725462777; cv=fail; b=IGd42paP83cbhZZV+d3ZLqQSS2FjuPoiy/8csTcH9GzwxHtMgQeWBBhOjkYuENNApCimeOR9EOcl9kR0I6ueVjxtkTzgMUPABJoJ8amrKUrMOyR7XzfXhMnjdQIH5P3GXms+7KozHit3aeAENHkECJGmscVHxtQGql6TMWEQVXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725462777; c=relaxed/simple;
	bh=epEbF3Gr6R2y7I/YkBPIEH/LSWCN9qaixfIXszXX0mY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RHtbz2FEMtTXmAJjrGzLnYsq0t+ED4r5oNTmRQXgESXstgBdHG9YPDuM+fjXURBVeozdM7VYY8SdSbXtMbN1c66hvKAdtjLZcdhJNt4tky+YcFET5CAia0we5AA8rrWWQROAVWWoZK3tPsKTcVg6h7vPvYfvqlXXrcxgNhsgcy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IJf2t6GV; arc=fail smtp.client-ip=40.107.20.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zFnqH0qFAJNGq0JTJC6C32Btj6MvTuJcJrj6thkkWj85iF8/0Az1sc/01SCWfK5EBC8YbUcjqwCtv5iy9QlVIirqjut3LDgYEBlMq+blzmeOHnXBSt+zsbUgruhiCnZtj71a9Y7zJarViEbptJw0OHKAU6qOyr8rTY356BnKkJdeE5E/mskDCMnGjCK37GfX0phDzCtys0dfkXFfUE40IT8OlO0VgALfyAPcK69DissQ94/TG0HivuinyNs5xORiaXyvknb8SMNL4SfhxJjBMqLIvPGLKbG7YW4yxByaNDfXnYkJ+zxT0lQJY8/hbQBuh+XEwtboz4eMq8wt2apTOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dPzadCqqY1iXsqHztctyhG9pXnNilKSwSBav3donhqU=;
 b=QrZfU7YzO9vgMuqc2NxAtS/LZYmeHwiO/0dpe+xb2tDhn0K8zXCCgOPzipNog20pWYt5UlywaqJyI7xngVuXBxP9b3HKqS6JEfpTeDQfTKLpaPpG82T21vDJdKZXnYfNslLo6eMgeXXRlVA3GWga8avn8H81a9Ld+C4682ZdPtuLBzycI1JeRzjplvv0VnwVI+Hgn2XpATXV0eFgyuSdOBKU3QWqfxFemGqY4lUihT+0zD9mOVYmmF6zEFqW49NJdjyczsVXVAPZP2Kyo0HckzBA83rICnicakVFunbowDyuKP+AAi0k+5CvxtOTlQ68ENJlOWz9v/ed/k7rk/4UuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPzadCqqY1iXsqHztctyhG9pXnNilKSwSBav3donhqU=;
 b=IJf2t6GV9SEqBAw91EIbRMfS6NbF8639vRS6l/OaODnQDSk3eRrCLFjA3NQn6s/5CJCOSMD9PgmnTyrkHw1M9SFjA4VLzu8HzwEDm5WBcrRRBAb1JsAGIC7Op7A1umHxbk//9uMKuTdMWVT7coe2PlCynHXAJUPAroPSxStRKS6PNiTdk8PN7aTRgkXWg/EdzPQJ74IQLlVqfeVyNh+IOZumKfbkk1TrXXRgxMOeJg/4+1AVHPg/subBR/w3krVudtFrROZtsLiBs+vk2bkrJxYX4w1Dr5Wzz8+JyRpmAknjWsv1DmZbDssUxY8BFo4Hyn2kn5W9xhijfFSZUFm74Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8242.eurprd04.prod.outlook.com (2603:10a6:20b:3ee::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 15:12:53 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 15:12:53 +0000
Date: Wed, 4 Sep 2024 11:12:45 -0400
From: Frank Li <Frank.li@nxp.com>
To: "Rob Herring (Arm)" <robh@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v3 1/1] dt-bindings: PCI: layerscape-pci: Fix property
 'fsl,pcie-scfg' type
Message-ID: <Zth47VkyAvkJ6Y2y@lizhi-Precision-Tower-5810>
References: <20240701221612.2112668-1-Frank.Li@nxp.com>
 <172468828846.439237.5196709203960217370.robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <172468828846.439237.5196709203960217370.robh@kernel.org>
X-ClientProxiedBy: SJ0PR03CA0066.namprd03.prod.outlook.com
 (2603:10b6:a03:331::11) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8242:EE_
X-MS-Office365-Filtering-Correlation-Id: 779ff972-9253-49a1-f48a-08dcccf40c3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bk5DUXRCei9xcnh4d0NOOVh4QmNQd0l3bUp0K2JRd1hlTXFFakdtWFJUVklX?=
 =?utf-8?B?TE90YUpzRXR4ZnhkUFNsOTJ0UG1LRHFGU08ySG9sdFRUbGdxWUlXYmIvekdh?=
 =?utf-8?B?Vnc3NWlySGpIRFRVbjB5YVRGV0ExWjVZTW44bDFKODZoWmZPKzFaZGpyNG05?=
 =?utf-8?B?NmhtQXJQb3JvVTFaMkUxb2Ivay9XaGFlT0xrWlJYV0U2YlpQYUxBOGlRK29r?=
 =?utf-8?B?dUovdWJCUk9xQW5wRzd6dVFiZlpHdjZQYi82L0txZFpuYnZCRmhKYUQ5TnpQ?=
 =?utf-8?B?ellUdGVmQi9vNHZ0d2FGRVArc2NSWlZyNTk1ek9FTWdrbmNWcE0rM1FqRjBi?=
 =?utf-8?B?VG85MksraHZ1R25rNVZGNXFSNU1IelFLOEF1M1phNElGYm1VanZlZnllaWN5?=
 =?utf-8?B?YVVFcmJnMzBVeVQ2VVBJOElsWFdzMzlWWUFsaWdValE4RFlRdFpJY1NnVGdt?=
 =?utf-8?B?eDI1d0djR21zVzQrT3ErUWpmUWZQdWthbEpBNkVmakZWQzh4YjB0UXRmQ05p?=
 =?utf-8?B?ZHh4bmFkTFdrbWlUMVZUazBxZHIrOUR2QXJZOVFteU9sbm9Kc21iN1VTeVBv?=
 =?utf-8?B?ZDVMaHBWSms1am5iWkVIajkyZ1NFT3J6cUtOTGcrMzlWN0xKQkYxaXE3eTJ5?=
 =?utf-8?B?b0kzdk5LWHU2VGkwVVNvQ2U2dk1zb3R5aXhhdHJVWHVtdGNHZStsbmthZWtj?=
 =?utf-8?B?UmNJMHV6cW9sQ1FwUFl5eVhmNlFWQUNaNCtDSmwvTzUxeGFqY21NZkhMS3Zr?=
 =?utf-8?B?RnBDWTU1cGJvZFRXVTl1cjROS1hwSTRSbDJvL0pnbFpZYU1HeEZ4NlJpTTBL?=
 =?utf-8?B?aDcxUkR3QnhRRUxhaytZTWNZSDBsbGVhK0pDcWZyTU02T2FhOXRxNk4xL2lz?=
 =?utf-8?B?QWYwVHpzZnpZKytKOXoyM2g1WlRoUGVLV0ZBS3o1NS9paUNOczJBSjROeU9j?=
 =?utf-8?B?L2tPeXpwNWt4VGFzOTMzandrRlVOdnVLeHpRTkVoeGcyS2ZXMW13RStIRnlW?=
 =?utf-8?B?N0ZNS0RQczRkS2NTTjBhbW5yRy83NkJJcklKREJta01VM01wVVhhZ0pwWWVI?=
 =?utf-8?B?VVN2YkZaUmdWNVRyWlBqaDZWbWY4U0prS25Fc05pc21QOHZBVFRReFRlUG0y?=
 =?utf-8?B?ZmVkcnprMlRqaGVGMW5DaHJLMHpMM08yK0M5bFl4cnFITmhiS0gzSC9VSWQz?=
 =?utf-8?B?Q1Z1SE5TYzc4VGloTEVGWGRGVzhBb1Zwa0I3ZjRhdUc2c0V1WWQ2cXU3NlpY?=
 =?utf-8?B?MVlLVTVvbkNwMlFzSHo4Z0JUc2trWUxiaGgyOUducDF4YmZJY010M0JFS2li?=
 =?utf-8?B?ZWp5K0FzT2lHSDJzdnpDVjhoUEMvSXRmVGNXdnJJMEwyanFLVGRqL2VITnZP?=
 =?utf-8?B?MUh4Z1E2MXc5WTFibTdyMlFQYkl0QThJUUlrUUNaMkJJVmVHa3hxWVQrbGJ5?=
 =?utf-8?B?d0EybGpNV3FOV3NHMUQyZzdCcHZ6YktPZ1cyTStHYlRUVVpCNWlpUjk1VTla?=
 =?utf-8?B?T0hMUWh5YjYwK2ptOG9qek54Uk51Q0xsSFB0YUp0V2pmcnQwMUN6UjJoTFpT?=
 =?utf-8?B?TGx4a3h0SDE2RktBdWtpdlBkVEw4eXZzQnJUcW52SmJaS0puMS9hZ2NyVWRm?=
 =?utf-8?B?MmVsNExUY2pUV3c3N0RncUYrYnBTbUhNLzY4WXRtWHdUNjQvb0VpN1N0Q1lI?=
 =?utf-8?B?K3I4YnRBTTRLbmZYbkVTZ2xGU2lJVVk5T29LeUZ5elgwTlJzTDdObWNBcTQx?=
 =?utf-8?B?OVc3eWgwakVPdHBvMDQ0N1dTVk1RWFFIcjl0ckRTQjM4QkZjNmM5ZTFMS3BQ?=
 =?utf-8?Q?PUcka0CcIssycOB57JaC1hY7dkzLUoFwqgE+4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGpNU0JlYVlxOGNkem9LRVNvYUNqVHRrNnIvSDRFUHVkYzQyNHcvSGtVQVhE?=
 =?utf-8?B?NloycjBwSzVmdEJhSUlXcFVCMlErektoQUV4SDdPRUx2U1hZalpCYUdMWmxU?=
 =?utf-8?B?RGZjV0o2TU5FRHN3L1RDbFRRaUQyYlJydERFS3MrczNRdDFDN0ZlWFBYbGRr?=
 =?utf-8?B?OFNQbE4wV3pFcEcrM3B0OFlVcCtzb3ZLKzJBSEUrS0w1bURKcWFtRER5eGpZ?=
 =?utf-8?B?WFJ1eVUvYno5N3JmTGdWTUpmUGlSUHdpcnJNOUN3aTN5Y1JESlA5L3hScXlj?=
 =?utf-8?B?Q1BrTTdQNUdRbTB3NTY0Q2RRSThneldCYW5OMW9UbGw3VjZ0dVNsOTRRYW0r?=
 =?utf-8?B?aVpqNURBbVF1V3FXNkVtTkZMaUhLN01IcjA2WXBKVGVwUGN0b3Nqc05BbzVG?=
 =?utf-8?B?eHUxeGFqeXhJaHZGSEtLQ2h5b0k4VlV3SEp4SkVwZHR5YmdGRmJ6cytkTFpq?=
 =?utf-8?B?dk5SMndOQTJPNG9JSzNLNFpZakxvYUZiT2x0VWpuUllPRW5kM29aQVZET0kr?=
 =?utf-8?B?bFJKanRTMjB5Qzg5S1M2bXlsY0pBa0V6d2l6T3pBeVVxOHdnSjBwQkVtbHRY?=
 =?utf-8?B?cUhGaHJBcWZHbEp0TXU3V2YvM2tpTHlGZEVtdGtMWTRzTit2ZWNNVkxsSmtz?=
 =?utf-8?B?R2dMdEoyOXh4S2RTeXZUcmNWODkyd2p2Y2ZSeFE4U0ZnWHpHSmpIMDFrV2pU?=
 =?utf-8?B?UG92eExKcEFUdFk1aUJQL3Y5aStiVGM5cG56K0ZDQ056T3pCWWgrcGhRU1dJ?=
 =?utf-8?B?OGZ5d2ZkcWZqdWp2b2VBVEVFZUdreDdwdWVkWHd6d1ExRis1K0hUbi9sNjBV?=
 =?utf-8?B?NmV3VFJaUTFaVTlHcU40QUFtRGdIOHNzY01KczhMczlUNVdOQ04xTXZBZkpW?=
 =?utf-8?B?RXZ0WCtqdjl0WTR5RGFZbVczMDNTREUvNmlQbTAyNmc1LzhSRWFMKzlvcTQ0?=
 =?utf-8?B?c0NZdWJnNlBDTWYrWDNDVGtmUWUzK3M3cEVVMW1sSFoxeCtqNG40OTVzdUdV?=
 =?utf-8?B?QUJpK2lCM3E4S1p0ajFHS0Vvd2daQXRPT0QvWjFHLy9CUm5EMTlSaXMzbGlu?=
 =?utf-8?B?ZjNZMVg0K1NOZE9rUmhZUjgya09qN0Y2bm1XZlJncHdaTlI1cmpHK3ExbG5j?=
 =?utf-8?B?NmY4WWllNWViVGNuNUZJUDNNellGQ1h6cnJsVjdma1NZeTU0Z2FadzZZOWE1?=
 =?utf-8?B?UFJ6SEhCR21nSW8xb3RBK2YxWTJBQ2RGaXF1aTNUYkpuWGxSNm9Sb040cjNs?=
 =?utf-8?B?bUNNTmF4WStrYTErbEsrbGhZSCtDZXVORXlCSUFBV3F0bXhpOS9jbURYZzN3?=
 =?utf-8?B?RWlFKzNkc3g2Vzc4UGl4TUN5TVhKdEE4ZnhhVEVGM1REWnhOYkx5T2ZmZm9H?=
 =?utf-8?B?czhGVjFrYklKc25UOXh4MlFxQ2hRQ3hLUFNxekN5bURTUFdXcVprSXoyWXc3?=
 =?utf-8?B?WkV1dTc2NWpQczFXejkrOXA0bVFFZnZlQkh5M1IrNFFoY1g3VS8vT3pzM3ho?=
 =?utf-8?B?NW03d0d2N1d3NnQ4dnViaTgrcHVneE9HOU9UaSsycHhOMjJEUlNUNXNjb1Fu?=
 =?utf-8?B?dGQrNEV5TUlIWndhbjkxYWNSVnptOVM3U0JSQXJORXFhN01EY1lvejZVTGNS?=
 =?utf-8?B?TWdVbWgrWFhjamMvcURHNVFBRkQ5ekFwZ21XT1NXc1VYRVA3aW9SMjB2RzNa?=
 =?utf-8?B?Rjlodm8xajhNSHNCeUtHb0N0UzliWlI1dkFIMW85WEVsbE1yOHo3MXhldXNO?=
 =?utf-8?B?Q0FxNTB3dHhUWGM2V1pYR1BuYVlDeThxMmxnakhVVklGVnpoaGk2TUEycnNr?=
 =?utf-8?B?blNoelhBeEZWQWhLdWVGeGYzMjVVbStMSjlXMVpQWnVYdTJMNUpObjZ4elZz?=
 =?utf-8?B?bGdYcGgvclJrVEk1SUdUYUtTWExsdjk2V3lRMFJDdE01ZkRBS2JOZEtOUE5W?=
 =?utf-8?B?dDNkd3NiNDNTeUNJUVJBbnp6MXNhSE9MeW1qbFlRc3R6NThoWUJRTC8vS0Rh?=
 =?utf-8?B?UUVVVW4wOVh4UkFUNlptOWMzcERNWjdjTHVGTWN6MUNMK3VHa2xYRTUzVitv?=
 =?utf-8?B?L0grekJFeTV2eDZMN1BhWlB6Wk1KSWFCd0dqOXhVWnRRSDVQRU94ZEVjK2tW?=
 =?utf-8?Q?4BS4h2pd4bPwp+PRvPSOfVD0c?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 779ff972-9253-49a1-f48a-08dcccf40c3f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 15:12:53.0376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qxSaKBBbKjwKqj6H2ejkYjcOCMkgFSpQq44LGuLhdmTlf4GbZxSmvocrXXU8MUiOh8M60gbEuRBanMY7ZTyUtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8242

On Mon, Aug 26, 2024 at 11:05:58AM -0500, Rob Herring (Arm) wrote:
>
> On Mon, 01 Jul 2024 18:16:12 -0400, Frank Li wrote:
> > fsl,pcie-scfg actually need an argument when there are more than one PCIe
> > instances. Change it to phandle-array and use items to describe each field
> > means.
> >
> > Fix below warning.
> >
> > arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dtb: pcie@3400000: fsl,pcie-scfg:0: [22, 0] is too long
> >         from schema $id: http://devicetree.org/schemas/pci/fsl,layerscape-pcie.yaml#
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > Change form v2 to v3
> > - remove minItems because all dts use one argument.
> > Change from v1 to v2
> > - update commit message.
> > ---
> >  .../devicetree/bindings/pci/fsl,layerscape-pcie.yaml       | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
>
> It's been 2 months and no response to multiple pings, so I applied it.

Krzysztof Wilczyński:

	Rob said he already picked this patch. I am not sure if cause
conflict if you also picked.

https://lore.kernel.org/linux-pci/20240904150338.GD3032973@rocinante/T/#t
"	Applied to dt-bindings, thank you!

[1/1] dt-bindings: PCI: layerscape-pci: Change property 'fsl,pcie-scfg' type
      https://git.kernel.org/pci/pci/c/f66b63ef10d6

	Krzysztof"


Frank

>
> Rob

