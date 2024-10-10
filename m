Return-Path: <linux-pci+bounces-14199-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5462E998CC2
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 18:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA2BFB24F7B
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 15:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828611CB527;
	Thu, 10 Oct 2024 15:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kEzY9akY"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010030.outbound.protection.outlook.com [52.101.69.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B1E1BD018;
	Thu, 10 Oct 2024 15:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728573428; cv=fail; b=dmGWjoicqFxdGZNBrLYC1naEemXESCk7adezMEIcpSoul+RX/oRku2lzP2gMSKEr8zxGU3GJx847x3UD0HSh9XkeeH62Mwa8yyI6AYVg6XcGphx+o2Fkz75AR0Ltq1MZPFcLdTickg681AVYUzovXELlhYkJVKQ58lmevi90gFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728573428; c=relaxed/simple;
	bh=XvwyvA6OzojE/AmbQPe7sRl+OT/SBLMwCzJm/luCZL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JzszUAfJnktHHvhBqoVEBV30By7ULgTrnZenWwNzKHASGm9gU4xeGbRmB/G25kNcYOnGJdzKv74WdRYT+q4ka3gKz2pVCRBQepVoddL4Or0dh5MXE+3Zv+c9d1xOnmi1HWHQhh/GKU6/4PwjU/TUjwh+DobYLs+AdcCFyKKwdFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kEzY9akY; arc=fail smtp.client-ip=52.101.69.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xhh5DR79dH0Shg3JeYzbZQoqtR9dDen+RLjduHTrrPqcd31Wcw+w7YVxV0jALStyjyz8VBdn/Jk75oVDiPjWDd5jE6B1E2IghHd10QU6hthxwNfjzpQu3I4EVpsb1hQcfPauIbDvS9kLYZYY3+KBcR2rG7ZjZOP0NeimAnuT4ctLHsslOYDR8MOjF/Ln8v+twx0bAfkKkE1MPDsQh5sMX7KGecenz8jQskSYb7zeob7dOrdkM7SeVGLC4xnarsxWQXHmHG9whYheAj6C3PqXCazui55saHgXv/Cn9X8vIO2fi7TJNsgenLiJbyPZAVBWodJIJD40SqVaUrfRUgfukQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NtU7CjRY67FMsM5BgRClCXEz/XD0N4xPPipguSChTM8=;
 b=ud+IXFsS1pVc4Jl44xHMxOB8ZMiWeaHlNGXpdIqsNo9hjJziFohQ5BsSAc6UcuwFUu1K4h5IboN/8MB90x7aEVz2stdhf94wbYP6+PV223Ivgih/UghpYAKz/67MTfSubCsbF7bWcoHddGPUocV4DdZ8mArNuNfM5BSBSgvEve3vQcHyNkFORV6rs76K23svM/uQWmZkBmHIsRKpsibx6XvtQeKc4BZAkGGlJS/46PwhuUtMj+odhis6/LgD9kYOalaq84+Q9f2VFwYAC20IzFoyi2HaCnGHylnK9SssMjMx5erm65UXRET5w4I5/nJyayTzT59mY6I9F25Yz1vBPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NtU7CjRY67FMsM5BgRClCXEz/XD0N4xPPipguSChTM8=;
 b=kEzY9akY4E1Zl4Sm8lTaPgCXmsabg+O9kdMAaNI0uDXgqIwp0g1KVokcdSHTH8+9FsltPgRpkKCMHhNAiecSuCb8Rw4IHr0PFKhg64NPf2a15JymLA0DybUBvNUIfcQ4UayST/RanhHP6MPPP8xdibEVToGMt1RZgCs5D0cfmAfF6HA3d68Fq9BM3WjichgMRtNDOGUVjGm5bYjCqA0H6pGEcHznLxLpzx35fyYU8ThHwVR/DOZ+HFo39EOFkndCd7x5R5Og8eF8X9vCQTmsuSo4D8lXepeoF5i9jbjFqpi2Jwn/W+P2+A0yDMZI1rMPPpUaE9qgAsmzu3N5ifWOUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7655.eurprd04.prod.outlook.com (2603:10a6:20b:292::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Thu, 10 Oct
 2024 15:17:01 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8048.013; Thu, 10 Oct 2024
 15:17:01 +0000
Date: Thu, 10 Oct 2024 11:16:50 -0400
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: Rob Herring <robh@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
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
Subject: Re: [PATCH net-next 02/11] dt-bindings: net: add i.MX95 ENETC support
Message-ID: <Zwfv4if3mWPLStb/@lizhi-Precision-Tower-5810>
References: <20241009095116.147412-1-wei.fang@nxp.com>
 <20241009095116.147412-3-wei.fang@nxp.com>
 <ZwavhfKthzaOR2R9@lizhi-Precision-Tower-5810>
 <20241009205304.GA615678-robh@kernel.org>
 <PAXPR04MB8510E8B2938E88DB022648F588782@PAXPR04MB8510.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PAXPR04MB8510E8B2938E88DB022648F588782@PAXPR04MB8510.eurprd04.prod.outlook.com>
X-ClientProxiedBy: BY3PR10CA0011.namprd10.prod.outlook.com
 (2603:10b6:a03:255::16) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7655:EE_
X-MS-Office365-Filtering-Correlation-Id: 137f2a21-fba6-421e-2ff2-08dce93e9712
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V2gxYTVZejRvUWJLQnBDVEdxYXNCV21UN0J6RjdxN1Uzdm9BK3F4aHJnaHdY?=
 =?utf-8?B?ZU9wZmJjQ3BGWmw2aFV1a013NzVmeXI0RWp5dG5SbFJTOHp2N2NUN0o2YlB1?=
 =?utf-8?B?RXBqNjc1Sm5OR2l5QWtoZ3hPWDRtSkYwa3JQNFBxczhzNDdqNWtwUzBoOWVL?=
 =?utf-8?B?bU5aWFYxcVorK2dFTHlNdGMwaVZ0Q3JrZnFOV1JyUlRBWjArRlRVT21jTnQr?=
 =?utf-8?B?RkNqRUs0TzM5WnkvVUNseFl1cWNTSmUwSDB2ZGFja0REVkRkVk9mV09UUkdO?=
 =?utf-8?B?RGlnZUZ2T3laY3VlVXU5Ly9KMldQeFBvN2tnRGQ3R0tpanRVOGpFTkI0aWo0?=
 =?utf-8?B?VkVWbHhQcWNOTlgvNE5lUm83bHhCYjNPdTBYZHVYWmRFRWFLc09aTy8reUZB?=
 =?utf-8?B?REJsaXhHZDFoV1d6aVBtNWo2KzB5VzJrdFh6U3VOYVEzZGpHRXAwOFVrZEZU?=
 =?utf-8?B?YmpFNHRzSStNUTIvYVUrYmZEbGVhSmtJTTU3R2c3MDRoTzNrZzVYYUEwaVZk?=
 =?utf-8?B?cFAzWXFJUWZTVmNzSHZyY1FPMWxhWUZ5NTZzOUwvR3V2SVE5STZXcUEzcGQ1?=
 =?utf-8?B?SVE4aWVnZFRZaHBTRk9lTTZ4eWlYbWhyc3p3UEhmVXB2aTgrVVdaMkp4Q21H?=
 =?utf-8?B?anhOb1BNaWxzL01mWWxZS25MRU5WMEhzdkNRSnZBa3hHKzZ5c2VGdG82K2I1?=
 =?utf-8?B?QjlId0I5WkNQeUE3VXVsUTlNbUViTDdNcUg2K1Rzc2krZUpIckU4cU1zdUF6?=
 =?utf-8?B?UUljK2d3WmFhN2VWN1h6alpHNDRBR0tmbDBOcWNhQnE5dTI2Q255NFhzbDJt?=
 =?utf-8?B?Q3c2Y0s4M2xEQ2o2azVyQzV6cXRXK3lGY0o2aEd6WnE5SlpqcGkvbEY1T3Bp?=
 =?utf-8?B?TzdreU5PV3dQTjlsRDliTE4raUxGa2E3Vm84MXRQQkxROXA2MzJNendReTIz?=
 =?utf-8?B?RmQwNHl2R09iTHFtRnFzU0xPMktRYTBrWWhxWG9kdXM4bmJ2TXpEQ2dTT3Vl?=
 =?utf-8?B?T0c5TnliQnBQS2RmcG9QMUo0WFJGQ2x4N3k2b2x4dnZKTlluUDhlczVFQzdz?=
 =?utf-8?B?TVlJb2IyenVBbEVZUmlKYzJjeHFEeE82WkZTakVyT3pCQVQxUUFwN0xNZldF?=
 =?utf-8?B?RVRidStQN1hVVHprcklaMk10S3N1L0wwOVFnaXdaUW5ZOTdxbTdUYTUxMDVY?=
 =?utf-8?B?cmdKeVUwY3ZIV3dzbDF3Q0Z6ek9BMm14aUJvS3hYWi9iaHdmcmQ0WldZM3dt?=
 =?utf-8?B?MUVzSTRNa3gwYmdicUpDY1czdVd6ZXNGZmNkdWRhOFB0RHQ0RGFsWjRNMW1G?=
 =?utf-8?B?Q2Q5bThOTGVkTGpTUXh0SlJWZVJvL09icm1QUXdjUllsMVdHUUl3bmovRU9Y?=
 =?utf-8?B?TkVLS1pQS3dMdlBnTWwxOFhvNGMrYUhnNWdWU0JDQWhzYXBpTTRWRUtqUGZn?=
 =?utf-8?B?U2Q3Ky9aOFVzbExrb0w4SlpRbXFSakoxZGlJNFk1VDZqTi9ZM21FamgvR21Y?=
 =?utf-8?B?RjVuZzlMOUI1d0p6eHpnK01kT3JaYWRlZjR5ekhzak5KQ0dwanlrRGpiNUhn?=
 =?utf-8?B?MzlRT2FtT20xaWExaFRHQUVRTVpGVEpLSlFubWt0Wm42RWRkYmx0OVYrU3RP?=
 =?utf-8?B?OUNZVFBpVmk1OG4wMjVETWRmWlpYYmF3YjkveFNiVGhySXlTemFRZ3BXamEr?=
 =?utf-8?B?TkV6MUlLSnl0N2taOS9mcnlCQzhwc1dXczBGVlpZaG5nMEkzTkg3WmJUNmdu?=
 =?utf-8?B?Q21iOEFWSjVkOEhvWG9DWlkyUzdTMFRsdnBTandBSk5BQ3pxQVNzcURsWGdO?=
 =?utf-8?B?RCtuZXJhMUJXZ2ptRnJnUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXZRRTBVNnlIY2RGVnRaWFNleXVDQjRGNUdDZW44c3R5czVrU2xYalZPdUti?=
 =?utf-8?B?NExrNTRaS1NDTVFMUUNIdGpJeG1BZU8rUW5NR0ppOTNXc1RUY2xaeE1ReUJn?=
 =?utf-8?B?bGNwekhsY3pUa1J4Y3hxemRueU1LSTIwMFR2cTBEbzd2SWtOWjNEdHlCTFJV?=
 =?utf-8?B?aStvYjg3NnV2MzA2aXVFYlIwYXp4UGRUTG9Ia0xpbmZ6anhZd0E2QWtBVXZH?=
 =?utf-8?B?RG1sTTVxMkpZVkpvbHRiWWZZUTE4aFZQTDk1cVhsT3JqNk1xeUpnRUNGbXpt?=
 =?utf-8?B?ZnZIUFZWdng3L0RzQ084d05MLzlXcGhvUW1iSlNWTkVoaERwU1dleldvM2Jy?=
 =?utf-8?B?cFVxQlBsUHZWd0JMRVduYTNRWEoxUXpnTjg5SmlWNzJETlJxdHg5cFpURzd4?=
 =?utf-8?B?V3I3STd0RE9McjFjbHd3cU5DRDg3aVl1d2IyMzczYnBJd2lLWmxhSUR6RW9y?=
 =?utf-8?B?bkFLTThaaGdFTjkvMWNFdnlURlhoRFVGNWtodDZUNm13VFkza1N3YU5XamlH?=
 =?utf-8?B?MDdLTUN2K3hLSmN1VCtablUydkZYMHkvZDVzYWV5Ui9JV01UelpsR3B1a1Rx?=
 =?utf-8?B?T3h1azgzSEJsK2RHekR3NkYvTFptUVRQdFN0VmozWFNndFE5cXRsVTBzNnll?=
 =?utf-8?B?d0YzSzBka0pzS2pjNEV1N3hLcDBjVEZXaWVJdCtBQVBsT2pOK2RSQnN1MUhi?=
 =?utf-8?B?R1pJOXd4SFBnMGF0SWcwUVY3RCtpRGxBaXplcCt0WDQxT29LUXloN3lFZEll?=
 =?utf-8?B?cEJZRUovK1RlSFo4czBUVCs4b2Rvem5qemdNaGxZU0R5L1lRaWkwWjV3S1NN?=
 =?utf-8?B?a1ovbGRDMGs1ZUZFbFFNVk1XbFdNR1lpVW9OVGhGZDhlR0ZBMjV4ZTd2eFNL?=
 =?utf-8?B?ckNZbHZNY0ozZ3U1NUJjdkFWRFdZajlYVkdFSjRTZU55LzVaQzlNQVZqNnoz?=
 =?utf-8?B?OHdoL2FJRDAydjV3dnJFaFJzUitFVmI4b2c4cEtmMWRMaU5WREI1c1ZVc2Uy?=
 =?utf-8?B?ZlhjdHZCWVNjVUEvYXllWnhvblBON1FUNEF5b0tGM3F0aUFSblJ4U2d6c2M3?=
 =?utf-8?B?aHpZNUFiUC9jWW83ZXFJWW50ZndDeWExbGcyc0NPQWdsMERIcVUrMk5HV1ZJ?=
 =?utf-8?B?emVTSU1hR25zZW10S1oxSStLRzAvSk84UnBnWjVlNlFLd0FNK0xWQzRqRG5z?=
 =?utf-8?B?emN5ZkJsOGtONVV4aWxPZEJnTWIvL1l5Mll5N3RTMVhzc1FwVkd5Y1UxM25L?=
 =?utf-8?B?NU5aZCtaUEF6VHIrR1NKSmlXU3J6S2tENkRzZ3NsdkxTZGhLdFVFTVE0RWpS?=
 =?utf-8?B?VEl5TzNnQ0QvbEhYRkZnTUR2SXBkejVsQ0I5cjF0TFdDb1NiYTlyUStySFRC?=
 =?utf-8?B?VmcxMEdHdWh0WGwyamx5eHc1bWVVVENpa2pwbDdQeUtVbkF0QmRXV0wyTTcv?=
 =?utf-8?B?Z1pBYUhhMEYvKzEyZ2gwYjFHZFNSaEFqcXh6UUNvWlRNQmYyTTZRMEpxb1Jv?=
 =?utf-8?B?ZFQwTVNuMXB6OFFmZTJ5UVZmMVFQQktqUFlCZmhXaXdKK3FRc29QUHdjdXRB?=
 =?utf-8?B?VkVUaDdMaDdyNnZEZ2oxZjVScVgvOU1UR0FtZWp0Wi9YZHJRVDJZblBXRWU4?=
 =?utf-8?B?OWJYSEs5OWU4d1c3TW1sSTZKYkduSUp1bDJqZnZUeElpVnBKbWY5N2Ztdzhx?=
 =?utf-8?B?SGlGYW4zdVkvQ2ZzY2I5SzRkUS9aYVJDSUtqYStjS3cxbG9YdCtxZWhXL2VG?=
 =?utf-8?B?SmkzMHVOMXd4blh2c29RMEtlMGl1SXNGRGFzdW5ub2hxaEluQ096MEhlVEFW?=
 =?utf-8?B?b3k1engrdkM4R3VhYzdEREROVmJFdW83eXR2a0k5eTI3TFEvWkhnS1orUWFF?=
 =?utf-8?B?SWJUK1FEeEVwcWVkbWx1M2hKcWtMNGx5UVd4TDZsVXUxaVdyNGZaVTRhY1E3?=
 =?utf-8?B?Y2MzMmtZQWNRd041L0c4bko4bGNtYkVCeHRBTmFFMEhwSUZVbm1uNEZyQ2tY?=
 =?utf-8?B?TmVZYU9WUW9nODUzVTNvSHQ0Z3dVamJNOHJBZEptL0s1UVEzNG8rMmtkN200?=
 =?utf-8?B?YTlHSEdDY0xEVUtnd3p2Y2JXR2FncWdzblVxTTBkRGlWMS9ydXhFd3A3MnZE?=
 =?utf-8?Q?e/D8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 137f2a21-fba6-421e-2ff2-08dce93e9712
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 15:17:01.3416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SX6MaQZTFAQog3uuetevynOCpaL7a4dFQug3n+JWDo15NSxqdgc2QLGFaEt+rl42Idh+jO8IA6tkhfq8KyGYgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7655

On Thu, Oct 10, 2024 at 02:14:50AM +0000, Wei Fang wrote:
> > -----Original Message-----
> > From: Rob Herring <robh@kernel.org>
> > Sent: 2024年10月10日 4:53
> > To: Frank Li <frank.li@nxp.com>
> > Cc: Wei Fang <wei.fang@nxp.com>; davem@davemloft.net;
> > edumazet@google.com; kuba@kernel.org; pabeni@redhat.com;
> > krzk+dt@kernel.org; conor+dt@kernel.org; Vladimir Oltean
> > <vladimir.oltean@nxp.com>; Claudiu Manoil <claudiu.manoil@nxp.com>; Clark
> > Wang <xiaoning.wang@nxp.com>; christophe.leroy@csgroup.eu;
> > linux@armlinux.org.uk; bhelgaas@google.com; imx@lists.linux.dev;
> > netdev@vger.kernel.org; devicetree@vger.kernel.org;
> > linux-kernel@vger.kernel.org; linux-pci@vger.kernel.org
> > Subject: Re: [PATCH net-next 02/11] dt-bindings: net: add i.MX95 ENETC support
> >
> > On Wed, Oct 09, 2024 at 12:29:57PM -0400, Frank Li wrote:
> > > On Wed, Oct 09, 2024 at 05:51:07PM +0800, Wei Fang wrote:
> > > > The ENETC of i.MX95 has been upgraded to revision 4.1, and the vendor
> > > > ID and device ID have also changed, so add the new compatible strings
> > > > for i.MX95 ENETC. In addition, i.MX95 supports configuration of RGMII
> > > > or RMII reference clock.
> > > >
> > > > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > > > ---
> > > >  .../devicetree/bindings/net/fsl,enetc.yaml    | 23 +++++++++++++++----
> > > >  1 file changed, 19 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> > b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> > > > index e152c93998fe..1a6685bb7230 100644
> > > > --- a/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> > > > +++ b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> > > > @@ -20,14 +20,29 @@ maintainers:
> > > >
> > > >  properties:
> > > >    compatible:
> > > > -    items:
> > > > -      - enum:
> > > > -          - pci1957,e100
> > > > -      - const: fsl,enetc
> > > > +    oneOf:
> > > > +      - items:
> > > > +          - enum:
> > > > +              - pci1957,e100
> > > > +          - const: fsl,enetc
> > > > +      - items:
> > > > +          - const: pci1131,e101
> > > > +      - items:
> > > > +          - enum:
> > > > +              - nxp,imx95-enetc
> > > > +          - const: pci1131,e101
> > >
> > >     oneOf:
> > >       - items:
> > >           - enum:
> > >               - pci1957,e100
> > >           - const: fsl,enetc
> > >       - items:
> > >           - const: pci1131,e101
> > >           - enum:
> > >               - nxp,imx95-enetc
> >
> > const.
> >
> > Or maybe just drop it. Hopefully the PCI ID changes with each chip. If
> > not, we kind of have the compatibles backwards.
>
> I am pretty sure that the device ID will not change in later chips unless
> the functionality of the ENETC is different.

It is quite weird for PCIe devices. Device ID, at least Reversion ID should
change. At least, I have not see use "nxp,imx95-enetc" at driver code.

Frank

> >
> > >           minItems: 1
> >
> > Then why have the fallback?

