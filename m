Return-Path: <linux-pci+bounces-13390-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D68C97F108
	for <lists+linux-pci@lfdr.de>; Mon, 23 Sep 2024 21:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B095A1C21933
	for <lists+linux-pci@lfdr.de>; Mon, 23 Sep 2024 19:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296051A0723;
	Mon, 23 Sep 2024 19:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Dl8Sp3eR"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012042.outbound.protection.outlook.com [52.101.66.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1300F1A28D;
	Mon, 23 Sep 2024 19:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727118179; cv=fail; b=DunO1RnmejWxxF4km1jnyvp5XD6Zf84ByEpBYpKgKCGg4OLk2tq3MtiKBDXpIqY1FFSEYRjJOny0rlXg8cUTq48YxVjnjGvqnuy/5Ldul0edfIFdn697rZ7gO4HaLcFfZ26G7T11hBLSK0YXk6GxQpf9nOPi3efBIj+ICnBJcbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727118179; c=relaxed/simple;
	bh=XjyZDfDZr4tUcoJkNxYF5N5g2cHIakL56tkWfEe7zNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TI62XjfXfOYz+ljQmB9MoURtX23JK3OuBXV6Bp4dkrQKt8Ff8+5OFbadBlKqjQAGZHObn2funhNo+5lmfSr3rpKz4YWBafWW3ogjMi6yKVX/0JXmpIjptnUYaKevW6YifkOlXIsnJpZDNybTldrwfnw68FI/b3+3AKXImW4P/Cc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Dl8Sp3eR; arc=fail smtp.client-ip=52.101.66.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d2+jU179QFDV4teZz/JgXGLYAFmDCJZmrzE8yQliHE70ceOXKfcWAMw3YTD2eHmSl3c8psDYjDcK6RYXa/JQLJRkUDLNJo46nzGvdzXL7GHimFI0v5ZJgBMrA30jx/JgEvA0UuVYkdw5Y5nxU09pI2P/KJe6n1vpUkXN0dPj/QoWgTrljiLLoOGh3ueAq5vSL7RTXKRpvBNwqIVxHS9DIgU6/CIgatbsE0HLzASUXfgrGKMVQ7auofepJ07VQPe2f1Mi9hIhEPdL6ZuamzVvxfOt7c6bbho2uireBcMBeFPS0dkor+YStosCxIfZeEt7DjyDsI9eIDmxP/jP3iGYSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zTS/6W6X43czVK7zfHe5LWKIciV7oCuORcVTOQuHIng=;
 b=AwLHjc3gwWwiRPwxnSUL2gqMxTaYomK6+LuIYdS7RCKpkeGXORx/36vvMRZ0fLHsqn9ecJJEtErqSgSHvOJOY5i47KO6AoipydR5jh/xIPaCOF3+WidS7C6VuN+0RLJ6c0ZgMIRYSO0mavGWlLtKmwEZr8oPuXVgH63RyaKbs3GwjJoPkBU+QLQVzZTEDfXG0BQ0zH754yVjJWZQNpTo7b+nXYlVBA4UyH1PjAzUzBqaq6MGtieiZ9rPiNQh6xZMugLoDF1FyIN8WvMlIy9rnjABk5N3Af6Evq2BeLrc3AMkp0orKdyTTMNFVB8AFXSpfDr2+f1P8QIsVXPrDYTROw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTS/6W6X43czVK7zfHe5LWKIciV7oCuORcVTOQuHIng=;
 b=Dl8Sp3eRmRWEIAGgAkic0FapPyyRV91x/I9JnLCA3SZGM4FzGUZSRaMoCqpxcCXNBxGVtW4t6VAohCxdQpO5hpK1A4fke9hUpSNAMINabEhlbr2nnl6GU/XF+sTWcPXRHgqbw4bJiMSCuMewg21LFMBiwoiZiyZJo4+hLHBc2X3/fivuSqrcp+pPkZErmJlzryBxh6I2cCHT85Pm3BQMWqkObgU/3CDQklOth57EcXVjks25c2/JziZgWeWXfLzkZfcgOPV7PFmpBsq4hqbIowDv0d/4+U9qBmpNcnsCdIgKVjm8NYrZ3jt7mdgPzshosrVq14LSJZBR1Bu7T2bZsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU0PR04MB9562.eurprd04.prod.outlook.com (2603:10a6:10:321::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.24; Mon, 23 Sep
 2024 19:02:44 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 19:02:44 +0000
Date: Mon, 23 Sep 2024 15:02:33 -0400
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
Message-ID: <ZvG7SXfxhlu684OP@lizhi-Precision-Tower-5810>
References: <20240919-pcie_ep_range-v1-0-b3e9d62780b7@nxp.com>
 <CAL_JsqJ7Of-0H+qW-ts7cVkeK0+4BR5mxocx00eVFKHaLfj45Q@mail.gmail.com>
 <Zu8cGrPLbe/psU3m@lizhi-Precision-Tower-5810>
 <ZvGT4+UaPOmnGh4M@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZvGT4+UaPOmnGh4M@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: BY1P220CA0019.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::15) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU0PR04MB9562:EE_
X-MS-Office365-Filtering-Correlation-Id: a2ab82e0-58e6-4f11-8140-08dcdc024e2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N3NxV0VhLzg2SWh0VEVJck1nSFB4QjE0T1lLaVBsYlRENGh1WWp4NFFjNzJW?=
 =?utf-8?B?Nnl5OE45eFBWOVN0dDdaa0pwbEVjN1ByK0YvbUVvRFZHYTZlZFdQZnRhb3Zs?=
 =?utf-8?B?N2w5bXFEZUp4Vlo3S0VtME54cnNKb1RVTE96enhvSU01bXlqZ0xPK2FDUnY2?=
 =?utf-8?B?L2poZFJVVWUwQWhDUkp5U3A2em4yelkyYVludUpxaE00SVBJcVVRQlYxcy9n?=
 =?utf-8?B?ZVF5NXpDNkRoclhLclQ4eXpIU0pQZ3FFTVJMMmVIZm9hV2lYSnRmcXdTUkpo?=
 =?utf-8?B?dURRRDJwbUg2R2FZTnNlS2c5ZWRuZTAwaUMrNGhKMk5jaFVxbEVrQzZ4dk5s?=
 =?utf-8?B?YXdSUzlRSndqNE5VRWRIQWllVEluREl1aldUQkd5TFRVcks2Z01GYUpsNnpw?=
 =?utf-8?B?elNIY0tVQzgzVVFudWxkR1BxK1NTT0Q1T2gvRSs4bWpLajNIWlZOZWE1Mmk4?=
 =?utf-8?B?NE11WjRHb2h2ZS9XM2x6ZktuMEs4YnhWMndZYUFJWkhuenA2YnhHOTJJUTV5?=
 =?utf-8?B?Skp2YXBqYlhaaCtFMUQrWjdXZ0ZaSHpWY25oNWFtYnBnZlN0ZFkrY3FyelJD?=
 =?utf-8?B?TUJjMGRZWldzYlk5ajA5ZDZsVGkvemlrZU9oc0NERHVjMEVGNlBPajhmYkgr?=
 =?utf-8?B?UGMyQ1N4bFpJbHJxZDN1dVNUMUVhSndtcmxJTVM0Y3RVKzJTODlaMkU5TzNr?=
 =?utf-8?B?MzZrMTFqSy91OEhoUmN4UTJLNUFES1pmZHcwV3VXbFR6RTdFcmo4cjRBT0RE?=
 =?utf-8?B?ZWFZQ0Eybnc0YXcxRnpXaWFjSGFIejAwcTdQcnRIRnI0Y09tU2dNam9lRFZx?=
 =?utf-8?B?NGk4WGo5WWFnVW8wbWgzSkE5UTFYcTVBYlVKekpaVkJ2Y1lUNzE4YkdzcmVn?=
 =?utf-8?B?VTlyR2w0Nkc3Z2hHOWUwNGNJSGpQVi9nVjJteUV0Wkd5RzQydVBqZ25LMk52?=
 =?utf-8?B?elh0U2xaSDhodU5VVkZsRmhJQ0xnY21pWnRnSURaeUF2RnFRMkxoaVVIL1Zo?=
 =?utf-8?B?VGNhVjNDK25iSEtZTW5xV0pWZGJJV3hqSWxDeFoySWN3R0hjWkhKQTZtaTFR?=
 =?utf-8?B?ZFRVWDNHZU1VdWR2dDRoUDZtenZISDNSZWJmSHQ1MkY2QTJ3RXRhdzdtSDVp?=
 =?utf-8?B?ZWp1N1RRenFUR0QzTnFNaFRPci94U3ZrelhWZ3QyTGg1ajdFS25NVnkwMXRp?=
 =?utf-8?B?OFF4UkM4KzRJT0hSazJrY283eGpTT1pLdlVGOHRlbXFGSnpQVitzZHdJL3dx?=
 =?utf-8?B?bGZvdFlud0taU2EvN2JJOXpQM1JsN0l1RXlUeTZCb3llYm16UG5idEJvRHVv?=
 =?utf-8?B?azhoVFlWa09iRytSeWlPdkdQWVk3K2h5U1hhNStDeTVRUVQrN1dtL3V3cXJG?=
 =?utf-8?B?RkFiOGFEOWFmVEVhWnZzRTV6RWxZK2NWZTZqV21oMEJCYjVsOExmUHA5S085?=
 =?utf-8?B?Y0VsSnFZaFgzN1BydFNPOVB1UzM5UFFURDR6V2VnbGZCTnZOQkpwU0c3UE8r?=
 =?utf-8?B?a1luQk9BMEJmRzhJdGNiQ28rdGlYakJkSWJUbmJOeVlueFFmcmJrYldQTlBp?=
 =?utf-8?B?MkFQMHRxbHlKTHAzR3R0bDZVVmRGODErcjI0VEZQUTBDN0Rkb1RnNGJ4ckx0?=
 =?utf-8?B?d2lMWDJwOC9XRDhqa1JkamFSTXlaN3hRN3JNSy93dGNQdnlJQkF5V25hZjFi?=
 =?utf-8?B?bUdObnkwUlE0MUF2dXR6WW9Nd1IvTFF1UkVjc1dzQjREOUg3RUtSaU9BT1dE?=
 =?utf-8?B?QjMxNHBtN29SSGpodjdIVEkzdlA1VitJbWJ2UWt6Q2VPelQxa1gwL2JsY0Vy?=
 =?utf-8?Q?awDuYRNy3Zp1fIiEj6tEhPK4gXErFK89DztrU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L2VtOEEvU1loaXlpUkltTkJHT21sRkVTSTVrK256L01kczhhWDlZMzRwUGFV?=
 =?utf-8?B?NUZFK1RVdDVxeTh3MmlvUkhlMzRnbXNGa2U3NTJsMFdVRE1JdkovSmdkdVFF?=
 =?utf-8?B?TGR1ZnhTWjRuU2NWb3lwbUZpVUNtTDQ5dGtjTXc3ZFljZGZZeVBHUHZQaHRx?=
 =?utf-8?B?U3ZYS1dNR1VpTmpDQ1FrcGVMaXRENmc2M1FTQ1BZNG1jTXdyeEpYRTlmbjlJ?=
 =?utf-8?B?QitMRXZpNVJTZ1VUMTIwek5DOVlaMjZ0dWI5NzFqTHdtcW5NT090U3UyMFE4?=
 =?utf-8?B?VytEQXJPRFlpeGJrNVV5cStqQk4wOGJlSGhrUWh5K3dhWGIxbFRacmQrUXdh?=
 =?utf-8?B?aDlxREY2TzV0V1BTbXJyZXRVdnFhZGxReVlwSjcrY1RDQVJsUk5GMlBlMVcw?=
 =?utf-8?B?VkJmTTV1TTZIV3I4VUIzU3BFZDhKVFZ0TkJWWG16WlhPL1JpRms4bGp0dVZp?=
 =?utf-8?B?aFBSRTJCWmIzUVBXc2k0YVVZUEU0cm9za1VJNUhwc1Y5WmlET1Nxbml2MlVE?=
 =?utf-8?B?dHQ4RTZIOFRQQkw4dS9pUUZQQVBoeUdySENZL3RiQ3RXa1Budlo4cVkvMy9E?=
 =?utf-8?B?SVdDZjdOL1ZlWHdadWFhWktSMXdaWEh0VnNVemp3dVBlT0RHdE5qb01aVUNE?=
 =?utf-8?B?RjBYUkZHRzhpYUZQOXpsbTNHMXIyc3ZWMkJxMlFsdWllTG81Zjh3Q2dEQU95?=
 =?utf-8?B?TThIZlhmclJMQ3BJcXl6WXJFdjYvc2VoL3N5eFAxQXFwbW9ZZ21mTDdiSExX?=
 =?utf-8?B?NU1QT0tOWUxPQnh0TWVBNUJJL2ZESEplVHlIT3FGL0dnaUYxR1o5OUdkRGpD?=
 =?utf-8?B?MFJFWkVHUVlMNDZ5SGZCSFVrSUdld2IzUWYvbndYS1RnUVBNRWN0SDBLczRw?=
 =?utf-8?B?RGRjNHBWWjVWN2VXWGdlVVJ6WmtyRWppVEZTTEkwdlkrOFJNdjBzd2VOOW1j?=
 =?utf-8?B?anFsK3lQL0NwMmh2azNMbmFEWnFHS1IyUmNXOHkwbUNPa29odGNwUUEwakpY?=
 =?utf-8?B?eFpUcG5DT0Q3a1hoa3Qzc0xzMWgzSEJvUWVxd1o3N0FHS3VnVnRtZW9tZnB2?=
 =?utf-8?B?aFg3N3hJNFJqZE9rcjRodUlwOVJNZjdPS05RN005TWh6QjhxaEpiSXNDZTNj?=
 =?utf-8?B?RW9DOWEwT2lSRWFlY05LVllxblhIY3JqNWZzVmRlUmsvcHd0VzMzTFRuK05I?=
 =?utf-8?B?M3RqYnFUTnJmZ09VU2NSV1VWY0JYZVI5Y1phTnJQTVd3a1VCSFlMdE83LzdW?=
 =?utf-8?B?QnNlQi9tK0RNYXlzN3dRcXJDRHp4VzcwTlhNQ2F5RGZyRzhodk81T2h5Qks1?=
 =?utf-8?B?T2FycDNuSjM0ai9BMnNUTGl3Wk5kcmJEd3BUbmhQNDM2TVB4TFYyUStGenp3?=
 =?utf-8?B?aUY5OExpTkR5R0FUZWtXRXVZaWxZT1VsaEM0M3JlV0lqbkNEOEM5WjJVdEIz?=
 =?utf-8?B?RWVkQzZVRnAxVXZBdnZ1K3R6WXp3R3FXZzhOYTFiN2JYRGFkcFNpSFlMTko1?=
 =?utf-8?B?TitvZ3gxdks3Qnp5OGlxSFkxNTlET1VURFgyVS81Mjl4ckh6eVFPOHU2WjQ1?=
 =?utf-8?B?SU9oRUVuMnBNaC9qa0tHSnNqWERwL1NIakx2MFA4eEEzOGNVSlVnbFg2RDJx?=
 =?utf-8?B?NUxCOXlVZFZMUFk4MHZRaFJUbjV6ZUVIWHFjWHRmYkQzUDFyRkd0aDBLM0hR?=
 =?utf-8?B?TUJobzIxWm5XR1pLM3owYnkxdlZpQUEyMVFrUEZaSDEvQjFYano2QVRGSDRO?=
 =?utf-8?B?WWxZUytISnJvZHhNSS8xYSthamY1VWFYTEQ4cUZuNTRjenVkbHZYTEp3b0Yr?=
 =?utf-8?B?MmxRMnp0WUxMcHVDUGxkdzc3OXlVUUtvWkNJakFmQjI2ZHRCMDZEQW9PVDdr?=
 =?utf-8?B?RkNIa2czZnd2aTlGa3hxQUExSUVHY2kwblN6c2JrL2FHMm43QnBNNFdwbDJa?=
 =?utf-8?B?TUpqQW0va2ZHSFc2WjIxY3VZcTdFZzROMGI0RGFFVjFJVGtTRE9FOHdLbUZr?=
 =?utf-8?B?TE0vSElGQXI3M1dHcFpZQWpJbGIxU0luT01KQ2hHSStldDVKRzVoSGhpVDNH?=
 =?utf-8?B?aGNtRStia1ZhNit5bEdHdjZxcEZIRDV5Q0F1UGhmV2tmcjJFWGtWcEVaZUNJ?=
 =?utf-8?Q?P3eaTpfgaEQGSCJXr+ZM8GL6H?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2ab82e0-58e6-4f11-8140-08dcdc024e2f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 19:02:44.0462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FXwk8xzkzhYiVx34B6o4K/wvi65XSKAY6rym70RQZyj5t0lrXBIjNAnkXr13qd21aegjNY8UewqlJJeeV5+/Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9562

On Mon, Sep 23, 2024 at 12:14:27PM -0400, Frank Li wrote:
> On Sat, Sep 21, 2024 at 03:18:50PM -0400, Frank Li wrote:
> > On Sat, Sep 21, 2024 at 09:43:17AM -0500, Rob Herring wrote:
> > > On Thu, Sep 19, 2024 at 5:03 PM Frank Li <Frank.Li@nxp.com> wrote:
> > > >
> > > > The PCI bus device tree supports 'ranges' properties that indicate
> > > > how to convert PCI addresses to CPU addresses. Many PCI controllers
> > > > are dual-role controllers, supporting both Root Complex (RC) and
> > > > Endpoint (EP) modes. The EP side also needs similar information for
> > > > proper address translation.
> > > >
> > > > This commit introduces several changes to add 'ranges' support for
> > > > PCI endpoint devices:
> > > >
> > > > 1. **Modify of_address.c**: Add support for the new `device_type`
> > > >    "pci-ep", enabling it to parse 'ranges' using the same functions
> > > >    as for PCI devices.
> > > >
> > > > 2. **Update DesignWare PCIe EP driver**: Enhance the driver to
> > > >    support 'ranges' when 'addr_space' is missing, maintaining
> > > >    compatibility with existing drivers.
> > > >
> > > > 3. **Update binding documentation**: Modify the device tree bindings
> > > >    to include 'ranges' support and make 'addr_space' an optional
> > > >    entry in 'reg-names'.
> > > >
> > > > 4. **Add i.MX8QXP EP support**: Incorporate support for the
> > > >    i.MX8QXP PCIe EP in the driver.
> > > >
> > > > i.MX8QXP PCIe dts is upstreaming.  Below is pcie-ep part.
> > > >
> > > > pcieb_ep: pcie-ep@5f010000 {
> > > >                 compatible = "fsl,imx8q-pcie-ep";
> > > >                 reg = <0x5f010000 0x00010000>;
> > > >                 reg-names = "dbi";
> > > >                 #address-cells = <3>;
> > > >                 #size-cells = <2>;
> > > >                 device_type = "pci-ep";
> > > >                 ranges = <0x82000000 0 0x80000000 0x70000000 0 0x10000000>;
> > >
> > > How does a PCI endpoint set PCI addresses? Those get assigned by the
> > > PCI host system. They can't be static in DT.
> >
> > PCI address is set by other channel, such as RC write some place in bar0.
> >
> > It indicates EP side outbound windows mapping. See below detail.
> >
> >
> >                                   Endpoint          Root complex
> >                                  ┌───────┐        ┌─────────┐
> >                    ┌─────┐       │ EP    │        │         │      ┌─────┐
> >                    │     │       │ Ctrl  │        │         │      │ CPU │
> >                    │ DDR │       │       │        │ ┌────┐  │      └──┬──┘
> >                    │     │◄──────┼─ATU ◄─┼────────┼─┤BarN│◄─┼─────────┘
> >                    │     │       │       │        │ └────┘  │ Outbound Transfer
> >                    └─────┘       │       │        │         │
> >                                  │       │        │         │
> >                                  │       │        │         │
> >                                  │       │        │         │ Inbound Transfer
> >                                  │       │        │         │      ┌──▼──┐
> >                   ┌───────┐      │       │        │ ┌───────┼─────►│DDR  │
> >                   │       │ outbound Transfer*    │ │       │      └─────┘
> >        ┌─────┐    │ Bus   ┼─────►│ ATU  ─┬────────┼─┘       │
> >        │     │    │ Fabric│Bus   │       │ PCI Addr         │
> >        │ CPU ├───►│       │Addr  │       │ 0xA000_0000      │
> >        │     │CPU │       │0x8000_0000   │        │         │
> >        └─────┘Addr└───────┘      │       │        │         │
> >               0x7000_0000        └───────┘        └─────────┘
> >
> >
> > This ranges descript above diagram Endpoint outbound Transfer*'s
> > information. There are address space (previous use addr_space in reg-name)
> > indicate such informaiton, such as [0x7000_00000, 0xB000_0000] as PCI EP
> > outbound windows. when cpu write 0x7000_0000, data will write to EP ctrl,
> > the ATU in EP ctrl convert to PCI address such 0xA000,0000, then write
> > to RC's DDR>
> >
> > The PCI Addr 0xA000_0000 information was sent to EP driver by use other
> > channel, such as RC write it some place in Bar0.
> >
> > The 'range' here indicated EP side's outbound windows information. Most
> > system CPU address is the same as bus address. but in imx8q, it is
> > difference. Bus fabric convert 0x7000_0000 to 0x8000_00000.
> >
> > So need range indicate such address convertion.
> >
> > >
> > > If you need the PCI address, just read your BAR registers.
> > >
> > > In general, why do you need this when none of the other PCI endpoint
> > > drivers have needed this?
> >
> > Most system, the address is the same. Some system convert is simple, just
> > cut some high address bit, so their driver hardcode it. Maybe imx8QM have
> > first one, they have more than one controller and address map is not
> > such simple.
> >
> > We use customer dt property in downstream kernel, but I think common
> > solution should be better, other drivers can remove their hardcode in
> > future. And it will be more symmetry with PCI host side's property.
>
> I found a more simple the method, will post v2 soon.

V2 post at https://lore.kernel.org/imx/20240923-pcie_ep_range-v2-0-78d2ea434d9f@nxp.com/T/#t
, which more simple and reasonable.

Frank

>
> Frank
>
> >
> > Frank
> > >
> > > Rob

