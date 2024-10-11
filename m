Return-Path: <linux-pci+bounces-14256-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFE5999B8A
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 06:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D185B219DD
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 04:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE951F4FC7;
	Fri, 11 Oct 2024 04:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iKUFMHkG"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2055.outbound.protection.outlook.com [40.107.21.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5822FB2;
	Fri, 11 Oct 2024 04:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728619919; cv=fail; b=TAid92prgST18/CAFUhke94zbss47o3O0RuLO0Whs+mem5TqPfJ31lyo5eXQtai1tPKdWbUeX/G1+UG2OUXXD7BmOdgY/FtHeMJrh0hjNk4x0B37Px4siIgyQhyFBjk+DIjG5zvgcNAQvJwIGWSpXAN9oU4Q+sZROlM+H2x4gfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728619919; c=relaxed/simple;
	bh=OuSIsMbVmLdEvMdnnCcMjuXnyr3U/J/KOLaVmgXwMTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JHWJhMZbl/yHBCvPWNnIUWA7FcnPe0O9YBdAoWAPNYFa4TSALpJ5OAx9tcTg3ELoee8qpqYHie4OtvBhJYdnCnZj1WJkFfplE8jrXmCLN5XpJZuVZQYLG+mT9zEJhMl/vUAciBWmegMKxzUuyyFEr1Pd56H40VpBZpCMtsiGWOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iKUFMHkG; arc=fail smtp.client-ip=40.107.21.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AbW8Pl0/nz+oAXDpm2C8580cp6KsnfKSaDJJLhhnU3U8SxtaX5jIU9U1ZaPDU0q5oT5LXjf3BC0OrYx6ITUQGGr6LTeNyAcdz4YsQm3tqFR4sxiN2fKSHspDoXkEobu5gyL6o3Jv3hYgQQo065FMp0HPkCLNvda0asVKhIl3zXNmDIDrLVjLY6YvYz8dkiMXm6Bb/CWeQ746AV946NDQQgAmSgSOl2dFr7usdM/0ux3xTBVnvq94STakFgCd8Knx3aDcEMl1D8Kvw6RHsrfeSQrkKVcVKhvjfl/Abngarfgu6s2VwB//LJ2/kfoVTnElePts9WAC9ZK7lNfvgUqi7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5sWIp/+qoqigJJPDdaEAWyc5vzlMijj0MwZnZHoL96Y=;
 b=rhxRb/TeSMpvCV8nsfkDwwjf8EZdeq0KEpnWN3lCz0U6gz8p3qbIq64AjT7Q0VRyRUkT3UDS3K26gnu9VZ2Gy7GwZ3MUliEwiJBf7KdFhOhV1uWr7kuYwZKGZx9NxWrD6UpQaNoeML15KBsLJYom0+5cmBphoJ2ZgO/BQehIjGeXX85NJl1+RYgVIIV8r3mbC1dPT09oFi8KcEYlY02Uu5v5FeDVF4K+QaGuVRTyVZLMLJcz44PSLjt85CVsNs8keg99fmqxCTj2xiTMD7TmN+yIez96IzufuKMQM8v5h3ETjfRRw5wbqBUFqQiDIBQ8HNHhe1PswSSmOJmO1FWcIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5sWIp/+qoqigJJPDdaEAWyc5vzlMijj0MwZnZHoL96Y=;
 b=iKUFMHkGOnl0opRceD07iOxuNYFGVbhH0wY75E5KsXa+2y5eizfdKdWTTytQlOKphRAL15Yn7tmXTc5/CONTXMRQ+VgKKGfGBTaUUXp/M8tjmFbV7aMRo1TpuY+JpZ3r5dc5SeaTys8jYTPHiqAnKi7NEmeNjkmTl+3exJ2kI9CLf31yS9oIq4mDM8QV3C0E5ZEPifoJVzmOmzMLViU3yReAYd5d/4YbwQcG6e62XCRYZ3vEMESF0gD20UwQY8NQ1opuzU6jQ75xn5kwFVegrnRY2mpM1albd6fWprzM7njeR4bXhAhNtUghjx18w9SFvmqRPSGoAuw099DAW3Px1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7952.eurprd04.prod.outlook.com (2603:10a6:102:b8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.20; Fri, 11 Oct
 2024 04:11:52 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8048.013; Fri, 11 Oct 2024
 04:11:51 +0000
Date: Fri, 11 Oct 2024 00:11:42 -0400
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH net-next 10/11] net: enetc: add preliminary support for
 i.MX95 ENETC PF
Message-ID: <ZwilfpoFFHgcVr4K@lizhi-Precision-Tower-5810>
References: <20241009095116.147412-1-wei.fang@nxp.com>
 <20241009095116.147412-11-wei.fang@nxp.com>
 <ZwbANHg93hecW+7c@lizhi-Precision-Tower-5810>
 <PAXPR04MB85100EB2E98527FCC4BAF89B88782@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <ZwfxK+vm2HCXAKHG@lizhi-Precision-Tower-5810>
 <PAXPR04MB85102605C8B2FCE52783BD5288792@PAXPR04MB8510.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PAXPR04MB85102605C8B2FCE52783BD5288792@PAXPR04MB8510.eurprd04.prod.outlook.com>
X-ClientProxiedBy: SJ0PR03CA0225.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB7952:EE_
X-MS-Office365-Filtering-Correlation-Id: 01b8da0f-d2b6-402f-fd21-08dce9aad59a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VFRWNTR5bHh6clY4TVNEZlhCRS9QSzV2a0h6bnp5Rmc2Sk1QSDdvOTZ4ZXZ0?=
 =?utf-8?B?RVp5WEJMR2xNTmRxSlplaW1iVzhlWnZzMFpLSkNlNExpRzBPSFVhT2xteXFh?=
 =?utf-8?B?akplOFNMT2lTeGR6b24rOFV6RWdOaGpUU0Nsdld4aU8wY3lxeThUcFNxQ3Jm?=
 =?utf-8?B?Tmx2bGF6NVFRY3UzcGZSUDRYcXRpTWJibWY5cms3V0dWMXZ5RXdhQTFvMmRQ?=
 =?utf-8?B?RDBGb01WUGhQN1pqT1UrUVBJTG5VeGNzUy9TV1YrL0d5QUNJdnpublh6VjM4?=
 =?utf-8?B?YjY5MnJ1OGlXMkY2K0FSOUhONGp0UjlKR1R6Nk01TFlsb3JpUEJZbUhNYXVN?=
 =?utf-8?B?djdsdmNTMjA0cXgyN0xGdnJVWEEvUCswNm8vNlhtYjIxeFA3Rithayt1N0ZD?=
 =?utf-8?B?bHNSaTd0NnNuVldPdmtzRUJoUUFqb3ViR3NvUm1vY1lOMTJFQlRUMDNjbjQ2?=
 =?utf-8?B?NXQ3UjZpTUplcmZRUU9RaFFMNDdZWE1YbFBIdm5KRWxLVVZDR05PcHFsN3c1?=
 =?utf-8?B?SUo4QUQ0NTBOVWNQQzl1NGVpNkNBL2FsQVpVdUE3ZVJlTTVoUVp1eFpaK0pQ?=
 =?utf-8?B?L2E2WTh4QTRPU2VIMnVtRWZwQnA1RnBJZWtRMFlVVHQ2MUJNWGxMRFZqOHFy?=
 =?utf-8?B?eDdSQmRHa2RJUVU4ejlqa1pJelMxa2VDeU96RFFFR0lHSFlCNzBaT3hRakhx?=
 =?utf-8?B?MUFVVGVaS0hiT2w2R0lmREZEWWtHditlamJsZXlZc0NWVzU0ejVMQ2RTRU90?=
 =?utf-8?B?MkZQTGxub3RvZ0pQV0crYkp6ZGpzSndPalo2ZnFBQi9wRHlLTnh2RzNWZXpo?=
 =?utf-8?B?ek5FOWV6dG5QZjBpTUhhVHY1ckpKYnRXK3dsbkdBYjAvc2k2N1V4RHVheUhr?=
 =?utf-8?B?eUlsQVo5UG5XbDd2Rjl0WklSMDdEZVBMMUtGNE5seXFxVDNNNStPVlI4T2hy?=
 =?utf-8?B?Q1FmUnBoY1pIMytYZDVDVVY0SVpyZUE2bDdPbmU3T1pZUE9yVzE1clBGSnB4?=
 =?utf-8?B?RTVZT0piVjJxdDNsWkhhbllMTWJGOGhHU3JIMUxWUlBoNkliUGdZTWVxZXVm?=
 =?utf-8?B?N1VwTzUrejNXQk13ZW9rTXZ4VGRkaVc5VjFibjE0cC9YWFAwbjJtUXVNMXFY?=
 =?utf-8?B?N2NxVFM0QTQxRmFzRGo4dnpobzM5c3Rrc3ptMnhrUnMzaFN2SjE3Z1VkZExN?=
 =?utf-8?B?MUJkbUptcmpqRE1abmJGaUx0dk01SE9BdENydVB4Ym1XclhtazN4b2dwQi9H?=
 =?utf-8?B?QXhKWCt0c1FCWXFsVjQ0bFNVQTdmVEdEZ1A2dVlKT0ZuTlJ5TUhMQUtHNmlu?=
 =?utf-8?B?L1JwemdsamNmQng5VHhsM1hWclBnQWJydmZMd1dqeGRZbTZCQ3QrSVFzaFFN?=
 =?utf-8?B?czR3NVYvVisybG9WNENKNlBKUWIxV1RMZ3d1MU1tbFkvLzdFajBDdmxPcUZT?=
 =?utf-8?B?V1NGOWhPaU8ybWJuQlZIQ001blFrZEt5Wi9CZ21IZDhFMkJDRDVtcTh1bmx5?=
 =?utf-8?B?RW5ET1pnSVpYbVB2bFJER05ubkUwMGZiVE1nby9aU2I5V3RXaHRzRE11a0Rv?=
 =?utf-8?B?MW93QnVLdkRMV09HUjFZb1RrTUdRQ3N2Z2orTnJGelpXS1V2VkFVVGVSenlD?=
 =?utf-8?B?KzY2OWlVeXZ1VHNHdGJ0MlVHT3YwZjdndXJROEpMUHZZS21ySWZXaE9tWFd5?=
 =?utf-8?B?K01ZOWFrZFRjSjZmVW9zdlp6Z1F4aTlXRU1QWTVpWmh2VXZ5eDVrSUxZU3B6?=
 =?utf-8?B?RzFJMmdEK3VFSkd2OUJrODg1eVFuaFVhYzV5RFRNMnFwaVhheEhyWlQ1b094?=
 =?utf-8?B?aWsrSFFYSkEwZjF5TE1OUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dDBqd1VXcnNpUGpBU3dxeFczc1BGUkJzejZPcHk5TzU5TWVIY2pjd1Q3eEVC?=
 =?utf-8?B?QjBydE5PRFJ4d0swY3BmZExralBDV2VQWm41ZW5keExxb1hnSzVUUXlaSS80?=
 =?utf-8?B?blkwcS8vTmJrUUpMQTF5MHlwbnladnF0RCtSbElNcmdLQzhQWHlvREJ3c1RJ?=
 =?utf-8?B?NTZENlQyZ04xMVdOMVpFdUR3aHVjT2U4U0c2a1Yvd2Zod0xYWTZoYjV0eG9J?=
 =?utf-8?B?MUFuMzQ2UC9KR1g0WmZIemJ6U0h2RldxU2FKcllGTlpyM3NWUVFZbXJaVElJ?=
 =?utf-8?B?QSs1TVZBaTlLK3hpWGhUWUNxMGVONFQxdXhpdVVFbk55dkhPTkp5eEN3UWdW?=
 =?utf-8?B?dUJ2bUZwZmwrSDZSTENzZngzZnY0dVhmYjVIZUZyTklMZFFZUTV3TW9pOU1r?=
 =?utf-8?B?UnI5MGJNWmZld1U5Z1lTdkFDYjZMOUtuMm1VcGxIUWRycXE4UUQ0OHlQRkc4?=
 =?utf-8?B?UkhHYkQwL0FaM3pvd2JWL0thd3oydUJ0MjFUcEJNTTIyOEYrK2d6alYrL3cr?=
 =?utf-8?B?TEhsamRFa2xGNitxYmVINW1YQzhrc1pHQ2lpbllaMytrWU9qenR5T1RIYUlT?=
 =?utf-8?B?YjZJQVJmYjIwbkg2VGFsN3RlbWhCQnhneGRmNGlsb0xFQzBYR0ZuaHlPOFlK?=
 =?utf-8?B?TDBpK2FQQ2ZvNENHb2Y2T25mU2JvY3U1Ukxxbi9vMDZjRE1mSkhSaDBsZkZV?=
 =?utf-8?B?anNCOFMyeFZHQXlMOTJwOWtuVGtSTWJtZ2l1Q3UwVjZldlBYbEw4d3BGVlRh?=
 =?utf-8?B?WHVIZFpYWCt5TzlTeTFHTU4vRVBmYTNCbzZValRISzJWaGVObmtOb2RjUVNN?=
 =?utf-8?B?cXhpZFVYb0lTTzNKdC9mNnJDQXhyR0U5cmFiNzdwdlEwaEpTNXc0Yms0NE5Y?=
 =?utf-8?B?ZnFhNXZBUHpoTUo0WEZzeFpmRmJHcUkvbk0rSWYxRmp1K3E3cjN0Wjk4Z0ZW?=
 =?utf-8?B?SXU0SmlQWm1BUjNvY0t2VE9MSUM5cnRzcUNwRlhhZ3o4UDR4d04vTWlKSUZL?=
 =?utf-8?B?ZlpCSjJkMUdhWm9oUGxKWFM2NXdhUzZvdzl6UUtGWU9pZ2RpUENkWVpzOUR1?=
 =?utf-8?B?eXVpZUJ0WEZVVWJnS3J2K3MrQ3JZOTRuMlB2MXhlK282YlJXNGcyd0VmcU8z?=
 =?utf-8?B?MHZ3dm9Ba3MyLzc2YTVDTGl4VU13UW9ZRFpleVI2Y3FOWnYrRTFia0w0YTVY?=
 =?utf-8?B?dmhlUmJJZXdwNlBVWm9oNmtyYnYzR1J6YnU1WWZkSjJqRFZYSURkMWdGQUl0?=
 =?utf-8?B?T090WTA1ZnBFLys1WXN5QTk2dFJ4dEtXdnEyQ2JSRFUwOFhWS2lNOEVVMFZ0?=
 =?utf-8?B?d2dtbXBSVHNtMnhzYlVPMmh6Z212dktCYkFFZS91REJSQ2h1T3hKU1dWMncr?=
 =?utf-8?B?TmpPUktGbDUzVGxndGtDeDdrbHdJWndWVkxxUGdsTk8yWWJCaHQyc1gxRnpD?=
 =?utf-8?B?VkpNTXAvK1pvdXU2MHhuRkVqWWsvV1hQaktTRmkyRVVBclQyN3BTRlVpbU0y?=
 =?utf-8?B?QTJ5TzZHN0FKcGlMaTlRREV5Y28xaldMN1B2N1VLM0NjdzB4OEEwdU9wVmdj?=
 =?utf-8?B?V3d3WHcvbFZNazhGRGVVamFscWVneXNPV3MwdTdqeVUrRE5XdVpyRExtRGRL?=
 =?utf-8?B?WFVmaHEyc0lhVE9sQ0NYanZHSG1IeWdkWk1IYk81dWphR3hKK3RaRzk3Z0R3?=
 =?utf-8?B?UUtZaTIrQTBTTHVzb2VOMnV5Uk1uVHA2MndOSVhvU1JkaDg4Q3NmL1dOVFlY?=
 =?utf-8?B?aitGRFM4NmxJUnR0S3lLR1RpeURpQjc3THM0RkFXYlNnUGg2ZmExc0ZvRkgy?=
 =?utf-8?B?QkZ2L3c5SzlCTTltcWNFYnZyUkhEYSt6VGZyVVEyd0tLOUpIbE81aU1acWV4?=
 =?utf-8?B?N3F5VmkxdE9TWGhXZzNQZHFhOHRKTmQzN0ZCbHVHSWlLNHlLRW1pZFVGUmdn?=
 =?utf-8?B?YjhUREpiWGJKL29WK3labG9EeTJFRnFTQWtnOXZ3T3dNZ3RxK0gwNUtsQVl5?=
 =?utf-8?B?WWhLVzRtaThoS0xSUHRweDRQandqWlJIdVFrN1hLN1RzcnV6aUZLMTNFYklV?=
 =?utf-8?B?eFR6Ym9pcmI2U1ZRanFoQ3pUOENYSjJlWmFBVmk0cE01TUMxcmNzc3JrZkcv?=
 =?utf-8?Q?xD3s=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01b8da0f-d2b6-402f-fd21-08dce9aad59a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 04:11:51.8332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yOrzmW16QF4Hz+j2CAJcz31eURaUOsFSWa1afujsf0RcecQpJDDRAr6/Up7Ow27DRDojeN6UkN9HqnXMN5xHzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7952

On Fri, Oct 11, 2024 at 02:02:03AM +0000, Wei Fang wrote:
> > -----Original Message-----
> > From: Frank Li <frank.li@nxp.com>
> > Sent: 2024年10月10日 23:22
> > To: Wei Fang <wei.fang@nxp.com>
> > Cc: davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> > pabeni@redhat.com; robh@kernel.org; krzk+dt@kernel.org;
> > conor+dt@kernel.org; Vladimir Oltean <vladimir.oltean@nxp.com>; Claudiu
> > Manoil <claudiu.manoil@nxp.com>; Clark Wang <xiaoning.wang@nxp.com>;
> > christophe.leroy@csgroup.eu; linux@armlinux.org.uk; bhelgaas@google.com;
> > imx@lists.linux.dev; netdev@vger.kernel.org; devicetree@vger.kernel.org;
> > linux-kernel@vger.kernel.org; linux-pci@vger.kernel.org
> > Subject: Re: [PATCH net-next 10/11] net: enetc: add preliminary support for
> > i.MX95 ENETC PF
> >
> > On Thu, Oct 10, 2024 at 04:59:45AM +0000, Wei Fang wrote:
> > > > On Wed, Oct 09, 2024 at 05:51:15PM +0800, Wei Fang wrote:
> > > > > The i.MX95 ENETC has been upgraded to revision 4.1, which is very
> > > > > different from the LS1028A ENETC (revision 1.0) except for the SI
> > > > > part. Therefore, the fsl-enetc driver is incompatible with i.MX95
> > > > > ENETC PF. So we developed the nxp-enetc4 driver for i.MX95 ENETC
> > > >             So add new nxp-enetc4 driver for i.MX95 ENETC PF with
> > > > major revision 4.
> > > >
> > > > > PF, and this driver will be used to support the ENETC PF with
> > > > > major revision 4 in the future.
> > > > >
> > > > > diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h
> > > > b/drivers/net/ethernet/freescale/enetc/enetc.h
> > > > > index 97524dfa234c..7f1ea11c33a0 100644
> > > > > --- a/drivers/net/ethernet/freescale/enetc/enetc.h
> > > > > +++ b/drivers/net/ethernet/freescale/enetc/enetc.h
> > > > > @@ -14,6 +14,7 @@
> > > > >  #include <net/xdp.h>
> > > > >
> > > > >  #include "enetc_hw.h"
> > > > > +#include "enetc4_hw.h"
> > > > >
> > > > >  #define ENETC_SI_ALIGN	32
> > > > >
> > > > > +static inline bool is_enetc_rev1(struct enetc_si *si) {
> > > > > +	return si->pdev->revision == ENETC_REV1; }
> > > > > +
> > > > > +static inline bool is_enetc_rev4(struct enetc_si *si) {
> > > > > +	return si->pdev->revision == ENETC_REV4; }
> > > > > +
> > > >
> > > > Actually, I suggest you check features, instead of check version number.
> > > >
> > > This is mainly used to distinguish between ENETC v1 and ENETC v4 in
> > > the general interfaces. See enetc_ethtool.c.
> >
> > Suggest use flags, such as, IS_SUPPORT_ETHTOOL.
> >
> > otherwise, your check may become complex in future.
> >
> > If use flags, you just change id table in future.
>
> enetc_ethtool just is an example, I meant that the ENETCv4 and ENETCv1
> use some common drivers, like enect_pf_common, enetc-core, so different
> hardware versions have different logic, that's all.

My means is that avoid use v1\v2 to distingiush it and use supported
features in difference version for example:

ENETC_FEATURE_1, ENETC_FEATURE_2, ENETC_FEATURE_3, ENETC_FEATURE_4.

{ PCI_DEVICE(PCI_VENDOR_ID_NXP2, PCI_DEVICE_ID_NXP2_ENETC_PF)
  .driver_data = ENETC_FEATURE_1 |  ENETC_FEATURE_2 | ENETC_FEATURE_4
  PCI_DEVICE(....)
  .driver_data = ENETC_FEATURE_1 | ENETC_FEATURE_3,
  PCI_DEVICE(...)
  .driver_data = ENETC_FEATURE_4,
)

It will be easy to know the difference between difference version. Your if
check logic will be simple.

if (driver_data & ENETC_FEATURE_1)
  ....

otherwise
   if (vers == 1 || vers == 2 || ver == 5), which distribute to difference
places in whole code.

It is real hard to know hardware differences between version in future.

You can ref drivers/misc/pci_endpoint_test.c

Frank

>
> >
> > { PCI_DEVICE(PCI_VENDOR_ID_NXP2, PCI_DEVICE_ID_NXP2_ENETC_PF),
> >   .driver_data = IS_SUPPORT_ETHTOOL | .... },
> >
> > Frank
> > >
> > > > > diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> > > > b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> > > > > new file mode 100644
> > > > > index 000000000000..e38ade76260b
> > > > > --- /dev/null
> > > > > +++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> > > > > @@ -0,0 +1,761 @@
> > > > > +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> > > > > +/* Copyright 2024 NXP */
> > > > > +#include <linux/unaligned.h>
> > > > > +#include <linux/module.h>
> > > > > +#include <linux/of_net.h>
> > > > > +#include <linux/of_platform.h>
> > > > > +#include <linux/clk.h>
> > > > > +#include <linux/pinctrl/consumer.h> #include
> > > > > +<linux/fsl/netc_global.h>
> > > >
> > > > sort headers.
> > > >
> > >
> > > Sure
> > >
> > > > > +static int enetc4_pf_probe(struct pci_dev *pdev,
> > > > > +			   const struct pci_device_id *ent) {
> > > > > +	struct device *dev = &pdev->dev;
> > > > > +	struct enetc_si *si;
> > > > > +	struct enetc_pf *pf;
> > > > > +	int err;
> > > > > +
> > > > > +	err = enetc_pci_probe(pdev, KBUILD_MODNAME, sizeof(*pf));
> > > > > +	if (err) {
> > > > > +		dev_err(dev, "PCIe probing failed\n");
> > > > > +		return err;
> > > >
> > > > use dev_err_probe()
> > > >
> > >
> > > Okay
> > >
> > > > > +	}
> > > > > +
> > > > > +	/* si is the private data. */
> > > > > +	si = pci_get_drvdata(pdev);
> > > > > +	if (!si->hw.port || !si->hw.global) {
> > > > > +		err = -ENODEV;
> > > > > +		dev_err(dev, "Couldn't map PF only space!\n");
> > > > > +		goto err_enetc_pci_probe;
> > > > > +	}
> > > > > +
> > > > > +	err = enetc4_pf_struct_init(si);
> > > > > +	if (err)
> > > > > +		goto err_pf_struct_init;
> > > > > +
> > > > > +	pf = enetc_si_priv(si);
> > > > > +	err = enetc4_pf_init(pf);
> > > > > +	if (err)
> > > > > +		goto err_pf_init;
> > > > > +
> > > > > +	pinctrl_pm_select_default_state(dev);
> > > > > +	enetc_get_si_caps(si);
> > > > > +	err = enetc4_pf_netdev_create(si);
> > > > > +	if (err)
> > > > > +		goto err_netdev_create;
> > > > > +
> > > > > +	return 0;
> > > > > +
> > > > > +err_netdev_create:
> > > > > +err_pf_init:
> > > > > +err_pf_struct_init:
> > > > > +err_enetc_pci_probe:
> > > > > +	enetc_pci_remove(pdev);
> > > >
> > > > you can use devm_add_action_or_reset() to remove these goto labels.
> > > >
> > > Subsequent patches will have corresponding processing for these
> > > labels, so I don't want to add too many devm_add_action_or_reset ().

