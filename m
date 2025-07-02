Return-Path: <linux-pci+bounces-31294-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF659AF5F84
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 19:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60E7A4A3589
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 17:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2042F50A4;
	Wed,  2 Jul 2025 17:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EOSbtmdY"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596DD1A2622;
	Wed,  2 Jul 2025 17:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751476211; cv=fail; b=U/wqAnOoa/vIem5UXg8CGVLzsCvFp8iaMjq1uSK1l0YYMVS3AZ6soRzWe4R1O8tvZSjUno25TAIiPGKOy4rzcYkC9DE+yezLvj0w8Xq+T6TVJLaz1H/xv4KUPkWIDEkJ5RrHTQmcwYNZR7yRtaxOl2Ez8nl5wryTpP/Cl913d8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751476211; c=relaxed/simple;
	bh=bWfS4Gw7F3H/aJxBfXhn0Kj2jy9qCp37PYVT5MwnDTw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BFYA1Mu4U81Hzi/yvfI6iZylBnytH2+qGo8cJWz1dZ1L+6U3WsTbC9975mtm+G3vuh4RLESdMkPgwm4MPEgKwJ16H37FGgTxGZQ//O8pQfwiA/NAClzSP7qWGk5dMEGlmM2+NMufklR1MtGpzsx0a6MHcF2lGw17IDbaIJHUFGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EOSbtmdY; arc=fail smtp.client-ip=40.107.244.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B4Yd6VxzTY8D5Zet/dgR8n2gLhuuykrB10nLH5VzYjs8poT1LnT49MVWAUOoahwar0pIFiyucUb7kCStB5Jv2QJnBPCoVpiI6n01onEbaepwln/jGFbZDmnqJhqdSLqt7FkTJw/BhCmB3wJ0/FBMTTcJuMloF7dhQF5A+wHc37epqzC8jVTrEAOW0RXJcVIwUj7rtxWpMNdKGCzDtUNiZyekZUix+bUT5Bs9wMtae+EIC9clHGkaCjVkW1nANtB789QJrAkavecnggP/cEI34ayc6s+T0cFPhJcTiFyWRMKHgCQGMDtrm8b02KxwLdQ5fhRbTMM94INFx1RYpREcMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+8dqDtli5/WPWZmoCGRhax6oNwO3P3C81ZNgQL84wys=;
 b=n4ryR7po5efqKNI9+pEFrgqHsit28BvWXbCazIpLE+5L2U818Ous4GE/o5NgmrubBYhnj/b6pYCmZN3oCDpvbl3Rm9l3vKxtdkZWENYacM2lyBBwVaiwNtBzzkTa3LLJOqkUJ4L/cS06DOzDiAkKO/4FHznnoKZEhLtbLMBBy3kARoVCmvej3GGbkzXMxWLQeyeK2xrKwg4P7prjRIBaKugtSLakYZowrefEk4Pr6Hp0E7ypRoaReIJz/1x6Xp/bX3YghnKMobuSJYr+UVSDlEd4cnPFFL9KnXcxTQrsaJRCcSmfCcqA5Uc+bj4gJl4ZqGD4WaVRfdOQx/nFEL2Oqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+8dqDtli5/WPWZmoCGRhax6oNwO3P3C81ZNgQL84wys=;
 b=EOSbtmdYZzzwJARlSax1vmLMsKuKS8W9guvEcr8H6vSNz0cZHZSfUL2EnQgNr+Ii7+ZMMnJ1UKtXKAbFwN3JR2uAhFEcavWRyZ1cAntfQbCIcXHkxIqUsQLIg1DoBZZslNjUKasaCMErBFYXWTJMFwDLjZs3OZqfNNVndLrHCbg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 SN7PR12MB7451.namprd12.prod.outlook.com (2603:10b6:806:29b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 17:10:06 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8880.027; Wed, 2 Jul 2025
 17:10:06 +0000
Message-ID: <bba3dd37-09a2-4cb2-93a2-9be97f455331@amd.com>
Date: Wed, 2 Jul 2025 12:10:03 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 05/17] CXL/AER: Introduce kfifo for forwarding CXL
 errors
To: Dave Jiang <dave.jiang@intel.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250626224252.1415009-1-terry.bowman@amd.com>
 <20250626224252.1415009-6-terry.bowman@amd.com>
 <f6ce1309-5c80-4778-ac8c-b4c0450995a2@intel.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <f6ce1309-5c80-4778-ac8c-b4c0450995a2@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0100.namprd12.prod.outlook.com
 (2603:10b6:802:21::35) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|SN7PR12MB7451:EE_
X-MS-Office365-Filtering-Correlation-Id: 711ed9cd-a2f3-4f71-f6d2-08ddb98b4abc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d2plb1JQa1QycHRMRmRZYnBvT0xkYVJnYlNKOXgwU3pZeC96NUZTNE0wM2Ny?=
 =?utf-8?B?YTZGZCtHcHVQcEFFNlhNRXJMcVNxS05jeTJzbWd6RWZvQVF4MWJ5eFlFdTN5?=
 =?utf-8?B?a1NrWnlLVFdCeGxCTkU5c0gvYmJ5MnZ0VWI5M0VRWFJKblR1dXE2RGkwc21m?=
 =?utf-8?B?QWRCa2VVSFNIZW5TSG9JY2RLNGNrR2hrY20xMXdOOElyQjFYZUxNV1lNZGR3?=
 =?utf-8?B?SURrYkVXU2VYNGk4RkpOdkxJUkZmaGkvb0FUckJIU3E2aTEvVVAyVm5HOVha?=
 =?utf-8?B?V2ZqK1B3RXJjKzZIUjZlbU9OMWZFMFBBNTZBNTZwWWE3anhWektraVdLbEJ5?=
 =?utf-8?B?c1NoWS9jZmRWTE52ZDNrYjB6UGxaRWUvcjNGQXA2UFF1bkJqemEySzdDWlY0?=
 =?utf-8?B?MnRLZEJmeXJMUUxoNC9iRldodWRIQmJaUHp0N0FqL1ovRC9lc3JHUkhFenh3?=
 =?utf-8?B?aWVQY21idnYvdXR6N0UyaHdHN0c5aUt1MWQzN0RWdExDaXFZL0xadk1FaDF2?=
 =?utf-8?B?dkYySGhxRmY2aUcrNFdBZlRBNFprYWloYkVqT2Rhb1MxeGM0TzZweUduLzJU?=
 =?utf-8?B?TUV1bVFVcTZ5Z0pENjJtWXRiSFRnSmxCV0VSSE1KeGIyVDR1Mys4K3pKQksy?=
 =?utf-8?B?bHlxcS9sRGtxZ1JiVHUvM1Rncm8wV21CZXNOZkVFWlQ5SXRhR0dtQnVyZitz?=
 =?utf-8?B?dHFoNkdwN2h5eittSUlNamVTRkRvR1dqT0hPUUtLVXUwYkhpM2U0bHRVZUpi?=
 =?utf-8?B?ZGlnblFkV2lJdDJRODJ6SkhkNUxhTzlmZWhtWFNPSFZXcTFPOTg5SFNGeTZR?=
 =?utf-8?B?Q3BQOWlicXA1OWIramVUOEdKU2lZT2RVbGMvbjA0Q0Z1Q1FkaG95R0s0T05y?=
 =?utf-8?B?aEpoRU5GUjJHK0MrZEtZT2FoM2d0RFowS3d6bGlta2RyN056ZDRMdlJJbXhQ?=
 =?utf-8?B?ZGFtSkJNZ0QrRVhSM29Ibk82RDQ4MGhqc1NMQlFhb3RuRGtSMmZhSjQ2UGNW?=
 =?utf-8?B?RkhQVWRjcHdyOUhndjFrRkV1Zm5CRWhBdFJJS2VEMlZ3bmpENjFyaEpPVWZl?=
 =?utf-8?B?NXM2eDEyNTlxVE9qNEFIWnJlNnJ3Wkw2bjlRa01JNndqd3c1ZWczd1RleWJr?=
 =?utf-8?B?ZGZabnA0ZlVwM2tmalJlK1ZHZTQzWFlWS0RWYllUOEwwWEsrbEtNSVo1Wnl0?=
 =?utf-8?B?YXIrbFZQak8zMjBQR2ZqRExtQzR0eHN2aGhHYnY2dUNhT09yUTZ5NGVTazlN?=
 =?utf-8?B?U0VjeHVTcFpab0tqOGdOeWtpNGdzd2E2bUdsYk9uRnBWQmtQVDBVSXlwb0gx?=
 =?utf-8?B?dXZoa0M2R3hzWTVFa0FEamdCRmpzY0tmMHVHQzV2Wmp4b2tyeXpjQUV3ZkxU?=
 =?utf-8?B?eW91WTA4SmFrWi9BYlIvNTYxd2o5YllYRWhsQllLWDdHVDhqMUc5SDhRZlho?=
 =?utf-8?B?cHZjNjRleVR4OWJMNGdJcVVJVUp3V2VmcnBzU0NyMVBDNVlGa2VtVXBZNmhz?=
 =?utf-8?B?UTd3MVdpWFRJR01mcW9vYTdvZFNtV2JUcUtsY1FkN3BTeUpBVDBmTzVWdkRz?=
 =?utf-8?B?T0loZlhPbFFIZGJVSlhmOHlPTFowUHZxeThId1FrdDRYSlJvcUtsdk5kYXJU?=
 =?utf-8?B?K241UTFQTVJnVk5vNnhTWjV5Vk9pMStmM2VxWjNzMWZBcVNRQXp1KzV2SzUz?=
 =?utf-8?B?VjlXV21FU2d3MGc3TjVrMEMrdE5XUWlvczRlTU51WXdCTWptTUttVjdmNXJz?=
 =?utf-8?B?OTVkKzFpcWpwVHhEUUM5NTArUlY1MHVtdUx2SFVlZ2dWR2pKNEFjUDBSQzhC?=
 =?utf-8?B?aEwreGJRWG1uVlg3K1BlRkZXM0Jvb0NKN04rK3RNVjMwTjFIb2dKUnorMS9T?=
 =?utf-8?B?MFMwR3BzNVpCa0NXUnNHdm5DSkUybElKQ0ltYS91SzNmcE8zcmFFWGlMTmJK?=
 =?utf-8?B?bWFYWGs2WFc5aGdhcE5RWGtUcHJXaTV4YktPODJqRXorbFptOUVndy9qYVNZ?=
 =?utf-8?B?SFdVWU01V3ZnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZnJrMW5NWnlsb3V2UWVqSHJwSkEvaUNsQ1h0M05QMmNsbWQ5Wkt1RS9BVFhq?=
 =?utf-8?B?QUlubFJVM0Z3U2wxQUtVdGJIZFBOcUJSSGdSK2s4VWRmK0kzNnNINmlUekZB?=
 =?utf-8?B?MnBGZ0JjaW03UWN6WG1KTTNQd1RWTXpOaVU0WE5Rbm9Vd1ljdzVKMnZ1QmV3?=
 =?utf-8?B?K3FMTnBTWTF2UFN6d2JxYlB6OHFrZVRuOWQyNVA0VVFubFNGemlXalRWQzVL?=
 =?utf-8?B?S3dvSld6emJrQldhbVYrdWU0UExMMVlaOEczTnhVTGNVS0ZUMksvUGErTzEw?=
 =?utf-8?B?TlFkVjl5bUpqbzFlb0NDZlFqOHBTcFIvNk9XREtrN2U5SGtuQzVvWXVJcjFC?=
 =?utf-8?B?V1FuYkI1RWJ4MzFud2U0eXRERkVFWEdQODI4dVNhdzhKdkJlOWMzUjh1aStD?=
 =?utf-8?B?UTZWQUZFMjVvVlhGZEs1dEZwVDJJZFA2VjZ4ZkozWlh1N1FhTzhxZ0M4UUZF?=
 =?utf-8?B?V3c5TklBa1pHN3pKTy9YeUNrUC9yQnJtdk1WUXBMOWNLeGs3d0NjelZHNGJt?=
 =?utf-8?B?M1lxRXYrcmxYRWVCM2lzeXdZNVJscmtTU2dTbW5mdkNlcTRRZGVQRXpldGpM?=
 =?utf-8?B?TDhIb0N1SjhJVGJVdSt1ZllRQ05STnVUTUliK1lDRTg5RUlaaGplend4dGI1?=
 =?utf-8?B?SW45TWRXSlBpNGpIL2NYc2U5ZE12U1BrcHE2bklwMjgyUTZyNk5weXIxam1Y?=
 =?utf-8?B?VHBNb20zdWFISGZ1a1RqdWs1c1k5L0lRMmxmNlhLNHJ1K1EwWVhFby8vaDhn?=
 =?utf-8?B?R0ZWMUI3ZjVlbFF3TnpGdFV2Um9BMlo4VVBLSERYU1FoSENwK1YrVDNSc0JH?=
 =?utf-8?B?WVM3cWxFM2N1V0h6QSs1RVpveDc3M3lwc1ZFakJtMHlCamNSNlFnMkh3d2l0?=
 =?utf-8?B?RnR5U2RWdTdyaTAvZGJ3OHlhNm5lamg2cUw2Nm1GNTFlMTV5MW9qbkxBWnRK?=
 =?utf-8?B?NlFqQThBRDRFWktid0hBck1lTmpzZkpZbVhsOGd2UG1TZVcwYkJHYmswUkNP?=
 =?utf-8?B?NUNtZitnczFnU2JybW8xTWF4dmkvTUNXUU9QTnQ5RUZWSHZUWkI2bEg1akZZ?=
 =?utf-8?B?YkJEM0k4aCtUOVVDQWlqdU5hSDRobzl2TSttbHIyVG14NTNuQ1drb09xMEti?=
 =?utf-8?B?UUZDcVdwM0RHNGNxekZOUmx0aFkwaGRPUGNOaWRSQms0UTdSeEwrTHVIaTZv?=
 =?utf-8?B?RFl4eHR0UzZXS0F2Q0Q5VDFiYkxJMVhYa29jSlRZT0IrdXgzbWJCV2xPMjli?=
 =?utf-8?B?UUVoanA4d0dpb2huTTV4elh3VzlTbHo4cndGT3Q0ZEJIRG83L012c24vUERi?=
 =?utf-8?B?OWVqZ1c4YmNJY250cGx5ZmVYeXlSallBTWpqbmIvUlh3R2JmMGVWOU5WZU5F?=
 =?utf-8?B?Ui9GRDluVS9POS9EZG9LeE5WWEtXRDZkZlV0NU9rZWV5czdKMHYwMVgwbG1F?=
 =?utf-8?B?WFFqdUJzb3FqTTkxVjRqRzE5MGR2c3pFRFA1d0hSblVQdXNZVmJ2TWk0RndI?=
 =?utf-8?B?OTB0RndpOHhLMVNac2RyMW56Z25qL0wzTnJ1MnlqR2w1a1UrcWRndmNLSk5q?=
 =?utf-8?B?Zzh1d1NiQkIyeGZUM05ZUnpqZ0lFcDZKYlV2eEd4SjVkQ3Z5R3EyTWx5YTFv?=
 =?utf-8?B?MW05amxTeXhOMzdGaGN2ajNWS2ZJUWZIdEN2ZjBNbmhTaStSS2MyWmc4RElW?=
 =?utf-8?B?K3pwb0dqSVVpZGhTalREQmFJdnhMQnBzbDRRbCtLeHhRNzEreDFsYmZNdW9t?=
 =?utf-8?B?ZllSQWRPWWppSWJhdDkyNWI1bmlpN1hDcnRSN0I5NlFOUnZIUkdMU29YSnlK?=
 =?utf-8?B?VDI2Ny9YTmgvb0dvZlpjLy9TWU5sbWlsN0sxNVhRczNKdmxIaHFmdTVYY01j?=
 =?utf-8?B?VWZDS0lDZ01GNndtSWhFNCsvd1Z1Y3o1UjZUUnh2OGlGK1BnNWwwNzFqdTdI?=
 =?utf-8?B?c3RXdDd1ZURBN0MrcDFCK3RVeHVVMjBxWkxOVE1PblBEdTU3bEw0T2JUSU1t?=
 =?utf-8?B?TFhYSUJhcm91OXhLUm8vVGhvUXhlVGNZSjBtTnQxK1R4QU1seGN0TzhhWXE3?=
 =?utf-8?B?RktFQ0k1OGVWWkE5c2xvL0JkSmRsUjQyRXFzK0w3Rm5zczN6MnpZVVZ4eVdt?=
 =?utf-8?Q?V0Rd1pS5zRvvcYzDQDaGHFI9X?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 711ed9cd-a2f3-4f71-f6d2-08ddb98b4abc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 17:10:06.6388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Q3bau/FF4/l6hfoII48neG+ezmb9HRJiBRmflAFcY8D3XCTSY+U7AgiUvGuB821pyOxoUqIXYPKsRY5uiGrsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7451



On 7/1/2025 4:53 PM, Dave Jiang wrote:
>
> On 6/26/25 3:42 PM, Terry Bowman wrote:
>> CXL error handling will soon be moved from the AER driver into the CXL
>> driver. This requires a notification mechanism for the AER driver to share
>> the AER interrupt with the CXL driver. The notification will be used
>> as an indication for the CXL drivers to handle and log the CXL RAS errors.
>>
>> First, introduce cxl/core/native_ras.c to contain changes for the CXL
>> driver's RAS native handling. This as an alternative to dropping the
>> changes into existing cxl/core/ras.c file with purpose to avoid #ifdefs.
>> Introduce CXL Kconfig CXL_NATIVE_RAS, dependent on PCIEAER_CXL, to
>> conditionally compile the new file.
>>
>> Add a kfifo work queue to be used by the AER driver and CXL driver. The AER
>> driver will be the sole kfifo producer adding work and the cxl_core will be
>> the sole kfifo consumer removing work. Add the boilerplate kfifo support.
>>
>> Add CXL work queue handler registration functions in the AER driver. Export
>> the functions allowing CXL driver to access. Implement registration
>> functions for the CXL driver to assign or clear the work handler function.
>>
>> Introduce 'struct cxl_proto_err_info' to serve as the kfifo work data. This
>> will contain the erring device's PCI SBDF details used to rediscover the
>> device after the CXL driver dequeues the kfifo work. The device rediscovery
>> will be introduced along with the CXL handling in future patches.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> ---
>>  drivers/cxl/Kconfig           | 14 ++++++++
>>  drivers/cxl/core/Makefile     |  1 +
>>  drivers/cxl/core/core.h       |  8 +++++
>>  drivers/cxl/core/native_ras.c | 26 +++++++++++++++
> With the addition of a new file to cxl_core, can you please also fix up tools/testing/cxl/Kbuild?
>
> DJ
Hi Dave,

Yes, I'll update the CXL test's Kbuild.

-Terry

>>  drivers/cxl/core/port.c       |  2 ++
>>  drivers/cxl/core/ras.c        |  1 +
>>  drivers/cxl/cxlpci.h          |  1 +
>>  drivers/pci/pci.h             |  4 +++
>>  drivers/pci/pcie/aer.c        |  7 ++--
>>  drivers/pci/pcie/cxl_aer.c    | 60 +++++++++++++++++++++++++++++++++++
>>  include/linux/aer.h           | 31 ++++++++++++++++++
>>  11 files changed, 153 insertions(+), 2 deletions(-)
>>  create mode 100644 drivers/cxl/core/native_ras.c
>>
>> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
>> index 48b7314afdb8..57274de54a45 100644
>> --- a/drivers/cxl/Kconfig
>> +++ b/drivers/cxl/Kconfig
>> @@ -233,4 +233,18 @@ config CXL_MCE
>>  	def_bool y
>>  	depends on X86_MCE && MEMORY_FAILURE
>>  
>> +config CXL_NATIVE_RAS
>> +	bool "CXL: Enable CXL RAS native handling"
>> +	depends on PCIEAER_CXL
>> +	default CXL_BUS
>> +	help
>> +	  Enable native CXL RAS protocol error handling and logging in the CXL
>> +	  drivers. This functionality relies on the AER service driver being
>> +	  enabled, as the AER interrupt is used to inform the operating system
>> +	  of CXL RAS protocol errors. The platform must be configured to
>> +	  utilize AER reporting for interrupts.
>> +
>> +	  If unsure, or if this kernel is meant for production environments,
>> +	  say Y.
>> +
>>  endif
>> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
>> index 79e2ef81fde8..16f5832e5cc4 100644
>> --- a/drivers/cxl/core/Makefile
>> +++ b/drivers/cxl/core/Makefile
>> @@ -21,3 +21,4 @@ cxl_core-$(CONFIG_CXL_REGION) += region.o
>>  cxl_core-$(CONFIG_CXL_MCE) += mce.o
>>  cxl_core-$(CONFIG_CXL_FEATURES) += features.o
>>  cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += edac.o
>> +cxl_core-$(CONFIG_CXL_NATIVE_RAS) += native_ras.o
>> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
>> index 29b61828a847..4c08bb92e2f9 100644
>> --- a/drivers/cxl/core/core.h
>> +++ b/drivers/cxl/core/core.h
>> @@ -123,6 +123,14 @@ int cxl_gpf_port_setup(struct cxl_dport *dport);
>>  int cxl_acpi_get_extended_linear_cache_size(struct resource *backing_res,
>>  					    int nid, resource_size_t *size);
>>  
>> +#ifdef CONFIG_PCIEAER_CXL
>> +void cxl_native_ras_init(void);
>> +void cxl_native_ras_exit(void);
>> +#else
>> +static inline void cxl_native_ras_init(void) { };
>> +static inline void cxl_native_ras_exit(void) { };
>> +#endif
>> +
>>  #ifdef CONFIG_CXL_FEATURES
>>  struct cxl_feat_entry *
>>  cxl_feature_info(struct cxl_features_state *cxlfs, const uuid_t *uuid);
>> diff --git a/drivers/cxl/core/native_ras.c b/drivers/cxl/core/native_ras.c
>> new file mode 100644
>> index 000000000000..011815ddaae3
>> --- /dev/null
>> +++ b/drivers/cxl/core/native_ras.c
>> @@ -0,0 +1,26 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/* Copyright(c) 2025 AMD Corporation. All rights reserved. */
>> +
>> +#include <linux/pci.h>
>> +#include <linux/aer.h>
>> +#include <cxl/event.h>
>> +#include <cxlmem.h>
>> +#include <core/core.h>
>> +
>> +static void cxl_proto_err_work_fn(struct work_struct *work)
>> +{
>> +}
>> +
>> +static struct work_struct cxl_proto_err_work;
>> +static DECLARE_WORK(cxl_proto_err_work, cxl_proto_err_work_fn);
>> +
>> +void cxl_native_ras_init(void)
>> +{
>> +	cxl_register_proto_err_work(&cxl_proto_err_work);
>> +}
>> +
>> +void cxl_native_ras_exit(void)
>> +{
>> +	cxl_unregister_proto_err_work();
>> +	cancel_work_sync(&cxl_proto_err_work);
>> +}
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index eb46c6764d20..8e8f21197c86 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -2345,6 +2345,8 @@ static __init int cxl_core_init(void)
>>  	if (rc)
>>  		goto err_ras;
>>  
>> +	cxl_native_ras_init();
>> +
>>  	return 0;
>>  
>>  err_ras:
>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>> index 485a831695c7..962dc94fed8c 100644
>> --- a/drivers/cxl/core/ras.c
>> +++ b/drivers/cxl/core/ras.c
>> @@ -5,6 +5,7 @@
>>  #include <linux/aer.h>
>>  #include <cxl/event.h>
>>  #include <cxlmem.h>
>> +#include <cxlpci.h>
>>  #include "trace.h"
>>  
>>  static void cxl_cper_trace_corr_port_prot_err(struct pci_dev *pdev,
>> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
>> index 54e219b0049e..6f1396ef7b77 100644
>> --- a/drivers/cxl/cxlpci.h
>> +++ b/drivers/cxl/cxlpci.h
>> @@ -4,6 +4,7 @@
>>  #define __CXL_PCI_H__
>>  #include <linux/pci.h>
>>  #include "cxl.h"
>> +#include "linux/aer.h"
>>  
>>  #define CXL_MEMORY_PROGIF	0x10
>>  
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index 91b583cf18eb..29c11c7136d3 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -1032,9 +1032,13 @@ static inline void pci_restore_aer_state(struct pci_dev *dev) { }
>>  #ifdef CONFIG_PCIEAER_CXL
>>  void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info);
>>  void cxl_rch_enable_rcec(struct pci_dev *rcec);
>> +bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info);
>> +void forward_cxl_error(struct pci_dev *pdev, struct aer_err_info *aer_err_info);
>>  #else
>>  static inline void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info) { }
>>  static inline void cxl_rch_enable_rcec(struct pci_dev *rcec) { }
>> +static inline bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info) { return false; }
>> +static inline void forward_cxl_error(struct pci_dev *pdev, struct aer_err_info *aer_err_info) { }
>>  #endif
>>  
>>  #ifdef CONFIG_ACPI
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index 0b4d721980ef..8417a49c71f2 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -1130,8 +1130,11 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>>  
>>  static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
>>  {
>> -	cxl_rch_handle_error(dev, info);
>> -	pci_aer_handle_error(dev, info);
>> +	if (is_cxl_error(dev, info))
>> +		forward_cxl_error(dev, info);
>> +	else
>> +		pci_aer_handle_error(dev, info);
>> +
>>  	pci_dev_put(dev);
>>  }
>>  
>> diff --git a/drivers/pci/pcie/cxl_aer.c b/drivers/pci/pcie/cxl_aer.c
>> index b2ea14f70055..846ab55d747c 100644
>> --- a/drivers/pci/pcie/cxl_aer.c
>> +++ b/drivers/pci/pcie/cxl_aer.c
>> @@ -3,8 +3,11 @@
>>  
>>  #include <linux/pci.h>
>>  #include <linux/aer.h>
>> +#include <linux/kfifo.h>
>>  #include "../pci.h"
>>  
>> +#define CXL_ERROR_SOURCES_MAX          128
>> +
>>  /**
>>   * pci_aer_unmask_internal_errors - unmask internal errors
>>   * @dev: pointer to the pci_dev data structure
>> @@ -64,6 +67,19 @@ static bool is_internal_error(struct aer_err_info *info)
>>  	return info->status & PCI_ERR_UNC_INTN;
>>  }
>>  
>> +bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info)
>> +{
>> +	if (!info || !info->is_cxl)
>> +		return false;
>> +
>> +	/* Only CXL Endpoints are currently supported */
>> +	if ((pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT) &&
>> +	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_EC))
>> +		return false;
>> +
>> +	return is_internal_error(info);
>> +}
>> +
>>  static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
>>  {
>>  	struct aer_err_info *info = (struct aer_err_info *)data;
>> @@ -136,3 +152,47 @@ void cxl_rch_enable_rcec(struct pci_dev *rcec)
>>  	pci_info(rcec, "CXL: Internal errors unmasked");
>>  }
>>  
>> +static DEFINE_KFIFO(cxl_proto_err_fifo, struct cxl_proto_err_work_data,
>> +		    CXL_ERROR_SOURCES_MAX);
>> +static DEFINE_SPINLOCK(cxl_proto_err_fifo_lock);
>> +struct work_struct *cxl_proto_err_work;
>> +
>> +void cxl_register_proto_err_work(struct work_struct *work)
>> +{
>> +	guard(spinlock)(&cxl_proto_err_fifo_lock);
>> +	cxl_proto_err_work = work;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_register_proto_err_work, "CXL");
>> +
>> +void cxl_unregister_proto_err_work(void)
>> +{
>> +	guard(spinlock)(&cxl_proto_err_fifo_lock);
>> +	cxl_proto_err_work = NULL;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_unregister_proto_err_work, "CXL");
>> +
>> +int cxl_proto_err_kfifo_get(struct cxl_proto_err_work_data *wd)
>> +{
>> +	return kfifo_get(&cxl_proto_err_fifo, wd);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_proto_err_kfifo_get, "CXL");
>> +
>> +void forward_cxl_error(struct pci_dev *pdev, struct aer_err_info *aer_err_info)
>> +{
>> +	struct cxl_proto_err_work_data wd;
>> +
>> +	wd.err_info = (struct cxl_proto_error_info) {
>> +		.severity = aer_err_info->severity,
>> +		.devfn = pdev->devfn,
>> +		.bus = pdev->bus->number,
>> +		.segment = pci_domain_nr(pdev->bus)
>> +	};
>> +
>> +	if (!kfifo_put(&cxl_proto_err_fifo, wd)) {
>> +		dev_err_ratelimited(&pdev->dev, "CXL kfifo overflow\n");
>> +		return;
>> +	}
>> +
>> +	schedule_work(cxl_proto_err_work);
>> +}
>> +
>> diff --git a/include/linux/aer.h b/include/linux/aer.h
>> index 02940be66324..24c3d9e18ad5 100644
>> --- a/include/linux/aer.h
>> +++ b/include/linux/aer.h
>> @@ -10,6 +10,7 @@
>>  
>>  #include <linux/errno.h>
>>  #include <linux/types.h>
>> +#include <linux/workqueue_types.h>
>>  
>>  #define AER_NONFATAL			0
>>  #define AER_FATAL			1
>> @@ -53,6 +54,26 @@ struct aer_capability_regs {
>>  	u16 uncor_err_source;
>>  };
>>  
>> +/**
>> + * struct cxl_proto_err_info - Error information used in CXL error handling
>> + * @severity: AER severity
>> + * @function: Device's PCI function
>> + * @device: Device's PCI device
>> + * @bus: Device's PCI bus
>> + * @segment: Device's PCI segment
>> + */
>> +struct cxl_proto_error_info {
>> +	int severity;
>> +
>> +	u8 devfn;
>> +	u8 bus;
>> +	u16 segment;
>> +};
>> +
>> +struct cxl_proto_err_work_data {
>> +	struct cxl_proto_error_info err_info;
>> +};
>> +
>>  #if defined(CONFIG_PCIEAER)
>>  int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
>>  int pcie_aer_is_native(struct pci_dev *dev);
>> @@ -64,6 +85,16 @@ static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>>  static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
>>  #endif
>>  
>> +#if defined(CONFIG_PCIEAER_CXL)
>> +void cxl_register_proto_err_work(struct work_struct *work);
>> +void cxl_unregister_proto_err_work(void);
>> +int cxl_proto_err_kfifo_get(struct cxl_proto_err_work_data *wd);
>> +#else
>> +static inline void cxl_register_proto_err_work(struct work_struct *work) { }
>> +static inline void cxl_unregister_proto_err_work(void) { }
>> +static inline int cxl_proto_err_kfifo_get(struct cxl_proto_err_work_data *wd) { return 0; }
>> +#endif
>> +
>>  void pci_print_aer(struct pci_dev *dev, int aer_severity,
>>  		    struct aer_capability_regs *aer);
>>  int cper_severity_to_aer(int cper_severity);


