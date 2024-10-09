Return-Path: <linux-pci+bounces-14097-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BA099715F
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 18:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 357A21C21FE8
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 16:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54DA1DE89F;
	Wed,  9 Oct 2024 16:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LKfAcw2L"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2078.outbound.protection.outlook.com [40.107.21.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FE8126C17;
	Wed,  9 Oct 2024 16:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728490815; cv=fail; b=Gc1XsP3Kl5wXk9oBEnuqpiD9eKNpNiA+8il/X/6FZTsLOH+mIDLcGPTn4S4opxRukPvHbxtZ1HMvHzI/2d6GRQSwdKtL/2n73EekHo2/RqbKaq/g35SrOwf0lNsA6yY3vLx/0ginAppTrQw4u7gt/AB4cuGJFM3W6czSE00c8BY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728490815; c=relaxed/simple;
	bh=qY5tFcFmNlfQ6Sb3KcizBrdgy2tivPxDW7tB4N+1zYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oYUGfJpMIeqZvAMdDMBiGfxOdMca45pp9Wcf7xMl9lSClHAXQ9gY9uLTnWtd88qpIkdWTJ6659VhOPQ00mDUJzcWtIB71KJw3LuMemQlCbMOeNW9iQenRltGcaoZPVzSraKUgRw9x4PY1mNlq3tlOP28wTv29++qn/Pmvy8Kyoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LKfAcw2L; arc=fail smtp.client-ip=40.107.21.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yxYAL7XvRPkkf72YM53H5MVEFmyV9jTbG3ogLhJikVVkiWTyIMXGR+BxI+ywbf/cc/CJFmzrv3N8VKTI1iy94dMg9eD6OIgBFlvmPQCN6bNMfyKwF98gc/7+d6ZyQgU31BVUzJ6ewT/+Q9h3XtCgo/U1y+nGDxA7eZM50QaxZ/BC4YrNTe39fjhykSKAdE9XckcIxAnn+SF6qxB4SpHKxIv2nKceoBlpgH0FjsolW/0U2g1M+kYMVtvHamxt7GXLeqlqirM/aa0cpPNxnwXEGlzozWFrD6Z+VMz5q1Ax2GEcrTlC1Q6ddItsTqTy8LBeMMSzrwtH2dPFNCE0L1+wWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fGyfYDafnG9mhTd18NjzbG9jD7M/QWwhO80OFPiRw3Q=;
 b=uM+EQZDBMKJYIDTK562FJtCnwwAt9pA8Bh8luNXE2sjOe4mtPlnRvqeEhuRWDbe8thh2vk89+Y4ZMHylBKkXPm6mQEfJ+lfnEjuRzrJaDbtbjwoohFbIfRc6pOVkpBlbp5fRHwKtbXXtKnWAdF2mgFwfpDU+JriAoHYycg66nAj9veuvELhBlBcwV9M3vjdF+V+1p3KSZb4yLPWvhJhONG22OXNcYdQVZxdl27kgQOHg4vCCKapu8FrCSPy+5WFpTVE58blXxtCv7gn6Ag6DJ0snsjRNbPlsgubprnDbTRM1wXLPmjdcMaxniD8Mp1HZKV9RB+cX62Bs6rXfKeizyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGyfYDafnG9mhTd18NjzbG9jD7M/QWwhO80OFPiRw3Q=;
 b=LKfAcw2LM58DuB5xFT8aeyzfairPMqWyrNIHkLj3wE8UxmBEBNBQXI1MLOwRBtQs/29fCYLup3wLwobUm8cK3YENWLKciGiZWZBIrRPjXDm2HjIQDfqL5253TPEN91Ed3R7UXEbWCzafy1fq2vNRQeya2mWFhZVEpC4Smx1a4j42/kCb5sBvHJginVbY9GJX0Ost95MbzWNrPikfDolu3TPs1/I6Gnru5xSw2ALohqFWsJ8bv4QzD5frsyiOyWT4upJD+qOGPLfUM6hV1M3lglqMA8ucgac+mhWqCZKtlnlBh7ovPsmYvKcI42qJjMab6Ln8MU8/J0JCx9dBO3/gOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB9962.eurprd04.prod.outlook.com (2603:10a6:10:4c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 16:20:09 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 16:20:09 +0000
Date: Wed, 9 Oct 2024 12:20:00 -0400
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: manivannan.sadhasivam@linaro.org, aisheng.dong@nxp.com,
	bhelgaas@google.com, devicetree@vger.kernel.org, festevam@gmail.com,
	imx@lists.linux.dev, jdmason@kudzu.us, kernel@pengutronix.de,
	kishon@kernel.org, kw@linux.com,
	linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	lorenzo.pieralisi@arm.com, lpieralisi@kernel.org, maz@kernel.org,
	s.hauer@pengutronix.de, shawnguo@kernel.org, tglx@linutronix.de,
	dlemoal@kernel.org
Subject: Re: [PATCH v2 0/5] Add RC-to-EP doorbell with platform MSI controller
Message-ID: <ZwatMEHAWOUQ8F0q@lizhi-Precision-Tower-5810>
References: <20230911220920.1817033-1-Frank.Li@nxp.com>
 <Zwao1x7m3MTT98NT@ryzen.lan>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zwao1x7m3MTT98NT@ryzen.lan>
X-ClientProxiedBy: BYAPR08CA0069.namprd08.prod.outlook.com
 (2603:10b6:a03:117::46) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB9962:EE_
X-MS-Office365-Filtering-Correlation-Id: 23b03541-1897-4cf7-387e-08dce87e3e96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bkRyMVlJVzh5NjBjTTN2WjY0SmV1eDJqYlR2MGF5ZWhxNmlkM3RiWmZxL0Ji?=
 =?utf-8?B?dEFrRE80NkVUYVJ4RllCMjNoUlVnOTQ4UEt0aW1qM0x0MEtCOXBwUGpjaVVJ?=
 =?utf-8?B?VlpXdXNqdGxhRTVFRDhGc3d0RlVDSXpUZ2ZwRDZJRTZ5L0JtdGVkOHZ4VkNE?=
 =?utf-8?B?UHhWSHlIbjRYWndQR2NHZUl0RmRkV214eHpYWUR0bWp3KzJISEt3aFp2OWkr?=
 =?utf-8?B?TDZ0a0hSVUtpOUlmTEVTUWxHK3dqNDR2NE5pdUpxU3VkTFpNdTJSeDY5cnZN?=
 =?utf-8?B?S0h6Z0IrWXlMZERkcHpObU9tYm9iVUs2TXVBVEl3NCttZzZhT043dUJWbGNY?=
 =?utf-8?B?YVpWazh3aWd4a015WGRrWUJYM3FUNWo0VThId0VZOUtJcUdPd1BhQ2pvNzJC?=
 =?utf-8?B?c1k1STNFTSs5NVdVdVh3d1JaTXhiY0U0d3VFb0xTMjNxaGhuNDM3Q21xTlhq?=
 =?utf-8?B?Z0dDamx4TE9oQy92YVBodWRtK2ZpbzErTU5CT3k2S2FRUlVBeUtNTll1aERU?=
 =?utf-8?B?WmlvbG9hY2R5M3RnQmJ2UXV1L2pHVVVDTEp5TlJzaGdPODhzaEh5ODhTT2l1?=
 =?utf-8?B?TkpjWWhZVkc4K0hGNWRnV0pKNElkMFk1aXhvbnlYdytYdXN2eU8yZ3ljR2l6?=
 =?utf-8?B?Vjd2MCtYdjFnZEJqbHZ3MGljRmxZV1ZHSksyK1NXNkttWU1WcVM0TDNMY2ZP?=
 =?utf-8?B?c0tlZ3k0THJvQkgxUlUyYllRcmIrVHV5VmFkenhuSFMvRm5vUUZhZUVMdnBa?=
 =?utf-8?B?OURhc2huT25GUmNhTzU5cVBjaVFQTkNLMXVRR3BVUUhxRzhtY3RzWlUvOXZ2?=
 =?utf-8?B?U1JMOUNmKzdZM09RMUhRbGJ0ejN2QjlXY1JUNndQSEF2QWx1eXRTWCs1MDM5?=
 =?utf-8?B?Q3RYbDI2a2JNQmg2KzdvYlVMNnUxMW15Q1dpYXNwSVowM1kxL0tqTmJKUmRh?=
 =?utf-8?B?Z0NmYmdPdXRrNDFId1laUzRkM1UrTHc3VE9mK1FuMExMeS8wa0dKSUw5NFpC?=
 =?utf-8?B?TlRUQU41cG9ycU8yMVNTQTk3ZGNiRXpOL3h4UVJYMlBlY1FBSi9heWl1WCtj?=
 =?utf-8?B?QjZaOWI0MTNwR1RsRzcyWER0ektkbCtqMW9DR1NlUnFTSTV5MVQrbTc4a1cz?=
 =?utf-8?B?ZFFSQXlHejVMODl3OVdDQWNmRlBnSXJoMVQ1ZG9WZkRqZmYvcHRNSWVGM0lT?=
 =?utf-8?B?WjI3RVMrN3kxZmNnVHp5eGdWa0Q3cEIycnR6N3pKUEtDOHRyaERBN3kram9r?=
 =?utf-8?B?REhzc3hyRHJnS25lTTJ1YUNzd09sYXRkZ25zc0hrUDZRRklocjBHemxXYnJa?=
 =?utf-8?B?dFdFOFJqTDRicWowNHU2NGQ5TFgzbVlpN0pnWTdSQ2pRKzZESUNQckphNkZ5?=
 =?utf-8?B?Z3NlL1JXakJyeTk1WmNvb29GRFcvVzhlNWdibnRRMkZ6K3hCMG9DdlNab1Ju?=
 =?utf-8?B?NUJranlBVUppZ1BjT25yU0pScjV2L0d3MUtkYlNoaEJMYXFidUd6cDZ5UzU4?=
 =?utf-8?B?SEU0SGZpY1IvbkJaZzhHWlZiOVNscHJkNk5pMDRoTExGVjZrVWsyeFlWcUN3?=
 =?utf-8?B?MW4xZjc2RFpza0ppUHZyRXAzT1huZ1N3ejlGbVNNOGFYVEkrSnFJdG9KVWdq?=
 =?utf-8?B?ajBWellhYlFCWkFGQkRLSTJYU0pDeW5MRitjM0N0YUNLdGtidUVybzdvZW1h?=
 =?utf-8?B?bFlzNHlQYitCTVE4T0ZRTEkwb1oxQmpPNTNwNitVQkZ2QjZ5MUYxZk9Ra1J3?=
 =?utf-8?B?d0wyZnFkRzdUL1FJQlJyYVBXYUdIbC9mMVZmdmhENTF1QjBhUXJ0SzFJVFFE?=
 =?utf-8?B?NTJxOWRvZ3BoeGRuMCtQQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L2FiLzBsaEdZRXdVL2YwVTcrZ2pDTVpld2w0V1B1Qndhb2ZDN0VJVXRzTDFP?=
 =?utf-8?B?NzhKa2lxT1JtbHRZQXdzR2t2KzQzMHphaE4vU0pYL0JBaTJVangyRWRYMUhh?=
 =?utf-8?B?K1B5d2Ftb2lTdlZhb3B3NFNNUTA3WXYvSmc4Vnl4UlNOT0hVWlF4V241YURx?=
 =?utf-8?B?cDF0alJNVEhubVhkdVNzZWxHdG54QkJoU2dTRkJodkVQWDdVaVR6VzZlcEJU?=
 =?utf-8?B?TnZLUWdPNWtodXVoYys5a0dkWU04S0M0WUpkSDFSMjlKRU9BUHlLU2thdThq?=
 =?utf-8?B?R1l1SDlRZkJuY3BsOG12MnpQd0s5ZmQ1QVRKTGJEMUpYQUJyYThtSk9OT3Rn?=
 =?utf-8?B?c1E1Zm1LVlBoNlNuSVVxTGtlNlNDZmNtaW1zQ1ZLdTlsVDlaOEZYNWJZY3o1?=
 =?utf-8?B?dHBKNWdzdFdJRXljR1p3dTFmeFh3YWREUnVTU2hKOUFhTi8rdUFpR3M1akIz?=
 =?utf-8?B?RlhyUDNGSDRtS2NjVkgyN0JxTEtCdCt0SXlUaklGZkxZWkMzNlRqL0pZNkQx?=
 =?utf-8?B?dGdwWWVKamxlYTN2aDJDN2hkc1hRRVBNbWpIWW1scTJtQ01QN1RFRE5ybktB?=
 =?utf-8?B?N3ZPdUs4T2YreWc1TzNlcmNRdE9FYVJNS1lLd0xKeEpTbUM0Yk5rLzE0ZGMv?=
 =?utf-8?B?Y1R6c0FZZGhhZUJkZkZ1NEErREZwTllVQ25LOXZteEx5bW9mekNLUU9tQlph?=
 =?utf-8?B?TTRLM3RORzJUWm9qOXJTSUNUTGNCazdoVVUzb2EzajhDYjF2eDZTNXREV3JY?=
 =?utf-8?B?S05rYkkwUE1sUldNd01ETm1VTkw2cy8veWNDL25BaUhaejFlWmVWcG1NUlNt?=
 =?utf-8?B?ekJUcUhRREFPRllKSTF3cElNTFNlNm16cUlzSERuRkFhT3lTTU9FUER6R1dF?=
 =?utf-8?B?cTFtNGkyODQzUjg0MVZTMEdTSktxNGR3Nk5VOTdOaEhOd1R3VXVFVEF1R3Mx?=
 =?utf-8?B?eXB1dUpGNVNnYkRkTFpxNjVFOFVUWGRQVFVSNk1jR0xmL2h2L2R3c3FWUkJl?=
 =?utf-8?B?b3IrNEdidU9HeWxLeDJXRTNQUERIdFpwd2dMRzZnNjIzWjZQS2FGYUpJckF2?=
 =?utf-8?B?bHRKVlQ0VTFIN2JzOHNCb0Y4a2lFL3NseERaZWR6TkRzODhMeUJVY3cvamNX?=
 =?utf-8?B?Smx1dFc0KzRsM0NZaHhDYll0Z1pWcnJ2dmdVd1JGK1F0NkRmRE9Scmo0YlpN?=
 =?utf-8?B?VzA1VkZCTVBNRmJzTlpOUUVOOFJ2SXgwY0tPV2JFN0FJQ2x0UnFpSzBZVlhG?=
 =?utf-8?B?ay96Y08wdGNPVDJyblBHaHAyMmlGaG5VRU9UWjJKU2RCMk5oTjAxZzdzODhV?=
 =?utf-8?B?Y0lDREdJOHdkbjJvQmVjeHVlcnhyUEpYdmw5UU5icSs3TUg2QWwrWE1tLy9E?=
 =?utf-8?B?WnJSTlBseEdKYmtodFhneEhSYTlPYWk2QmdPM1pNWUh3Zk10WGV1ZEV1SUpo?=
 =?utf-8?B?VjdDZkJNclYzT2g3NWVYYlAyRW5FWXhsSXpzdEs5Tk1naTZ0cXAyYk5qOU53?=
 =?utf-8?B?cFUwMG5Gd0hRdUhqZnpZZVQzd1J6aWVHcXBPOGp6T3psWVEvd1NQUEgwSTN5?=
 =?utf-8?B?NlhtZkVrcC9tL0I4Z3dMY2FZMEZ3ajFQdjlJWk5WVFlLTGZlNUFSRXN4RUZO?=
 =?utf-8?B?ZEE3aGhVSWl6OTI4VkQ4Q1FoZHNtTE8yOVFPOXhGZG9XZ2VoT29OOVRaS04x?=
 =?utf-8?B?Y3k0QTZ5ZFk3OThtMGllVFVRelhGcHgwcmtOWnZGSGZ4Qmp4WXdsMEpzQXlt?=
 =?utf-8?B?VzBNbm1CNzJFcGJ5eXRIRHJmVGJCbmM1d3VyYXg3bjhUN3F3NUhaVVFrTk9n?=
 =?utf-8?B?SjhqK3FCSVFZaDRJbTU1Wkl1ZjJ4OWFqRFVSaDNaL2JUYUJhQU9lb0YxVFk0?=
 =?utf-8?B?azhmZWlZYVA3cCtINGVSRjVnVThWZmkzblRvaGUzblRMY09GSlZralEremJJ?=
 =?utf-8?B?Q3ZzNjV0ZHhiU2xXT09RSDhyRWsvdENmUXV0Vm93QjE5VGZqcWJiRGp1SnNB?=
 =?utf-8?B?MjdJajg4eWZzc2NQSWhPZFY3K1RsOS9PczRoK0tFOHFPcDFRQUV4a3ZnQWFt?=
 =?utf-8?B?akFxQ0lTYVAyeDJvdmp5UnFtTWZadEdMQ3pKa3B3QWt3bmR5Mk5YSXpmT295?=
 =?utf-8?Q?GOGdw/mmzCqU5OnIr26SYv9ct?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23b03541-1897-4cf7-387e-08dce87e3e96
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 16:20:09.4036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XyVhjC9txDHfHtG8yFf0cd/6v6/7njd8BmAGypM9B3efn/tbgRUi+KcIgJWutZHp204ZQJ/ko3Gx1pHmq84aCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9962

On Wed, Oct 09, 2024 at 06:01:27PM +0200, Niklas Cassel wrote:
> On Mon, Sep 11, 2023 at 06:09:15PM -0400, Frank Li wrote:
> > ┌────────────┐   ┌───────────────────────────────────┐   ┌────────────────┐
> > │            │   │                                   │   │                │
> > │            │   │ PCI Endpoint                      │   │ PCI Host       │
> > │            │   │                                   │   │                │
> > │            │◄──┤ 1.platform_msi_domain_alloc_irqs()│   │                │
> > │            │   │                                   │   │                │
> > │ MSI        ├──►│ 2.write_msi_msg()                 ├──►├─BAR<n>         │
> > │ Controller │   │   update doorbell register address│   │                │
> > │            │   │   for BAR                         │   │                │
> > │            │   │                                   │   │ 3. Write BAR<n>│
> > │            │◄──┼───────────────────────────────────┼───┤                │
> > │            │   │                                   │   │                │
> > │            ├──►│ 4.Irq Handle                      │   │                │
> > │            │   │                                   │   │                │
> > │            │   │                                   │   │                │
> > └────────────┘   └───────────────────────────────────┘   └────────────────┘
> >
> > This patches based on old https://lore.kernel.org/imx/20221124055036.1630573-1-Frank.Li@nxp.com/
> >
> > Original patch only target to vntb driver. But actually it is common
> > method.
> >
> > This patches add new API to pci-epf-core, so any EP driver can use it.
> >
> > The key point is comments from Thomas Gleixner, who suggest use new
> > PCI/IMS. But arm platform change still not be merged yet.
> >
> > git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git devmsi-v2-arm
> >
> > So I still use existed method implement RC to EP doorbell.
> >
> > If Thomas Gleixner want to continue work on devmsi-v2-arm, I can help test
> > and update this patch.
> >
> > Change from v1 to v2
> > - Add missed patch for endpont/pci-epf-test.c
> > - Move alloc and free to epc driver from epf.
> > - Provide general help function for EPC driver to alloc platform msi irq.
> > - Fixed manivannan's comments.
> >
> > Frank Li (5):
> >   PCI: endpoint: Add RC-to-EP doorbell support using platform MSI
> >     controller
> >   PCI: dwc: add doorbell support by use MSI controller
> >   PCI: endpoint: pci-epf-test: add doorbell test
> >   misc: pci_endpoint_test: Add doorbell test case
> >   tools: PCI: Add 'B' option for test doorbell
> >
> >  drivers/misc/pci_endpoint_test.c              |  48 +++++
> >  .../pci/controller/dwc/pcie-designware-ep.c   |   2 +
> >  drivers/pci/endpoint/functions/pci-epf-test.c |  59 +++++-
> >  drivers/pci/endpoint/pci-epc-core.c           | 192 ++++++++++++++++++
> >  drivers/pci/endpoint/pci-epf-core.c           |  44 ++++
> >  include/linux/pci-epc.h                       |   6 +
> >  include/linux/pci-epf.h                       |   7 +
> >  include/uapi/linux/pcitest.h                  |   1 +
> >  tools/pci/pcitest.c                           |  16 +-
> >  9 files changed, 373 insertions(+), 2 deletions(-)
> >
> > --
> > 2.34.1
> >
>
> Hello Frank,
>
> Thank you for your work on this.
> This series is very interesting.
>
> As you probably know, IMS support was ripped out of the kernel a few
> months ago:
> b966b1102871 ("Revert "PCI/MSI: Provide IMS (Interrupt Message Store) support"")
>
> So this series seems as relevant as ever.
>
> Are you considering continuing work on this series any time soon?

Thank you reminder it. I forget it totally. I can respin it. I remember
there are issue that how to provent pcitest to test door bell bar.

Frank

>
>
> Kind regards,
> Niklas

