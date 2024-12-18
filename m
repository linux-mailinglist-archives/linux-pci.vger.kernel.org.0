Return-Path: <linux-pci+bounces-18687-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02CD89F633C
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 11:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43336165E80
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 10:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D5D1991AA;
	Wed, 18 Dec 2024 10:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hI0g8cuW"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2078.outbound.protection.outlook.com [40.107.101.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E658148838
	for <linux-pci@vger.kernel.org>; Wed, 18 Dec 2024 10:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734518111; cv=fail; b=ZebHekkYdIfDBFsENViquRuyEqLCb0ahvkShQDqK2okDdIZ/wSlUX6godJ1gFMrB1A/LPjAA0VMaC+2BPcveEAsD+68tAsU/h31ZF2NHnCBtftJ3h0rwne7101so+DvyocjuV966RUeZoa2rzCYdxoCo+LadTEkkb2hGNZDjOs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734518111; c=relaxed/simple;
	bh=OUJCFn9ILUitgk9lE7a8CVE6VZPv/a9Hs1NGZicxdLA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r8/V9qMvlbfrs0PWfaCpPDY8iKe2NgEBh9s5VxfCzcSwVP+0PTU9tM/JxqsqWjMypApg9cWVpxDQ9QNtDtGu4RROLqOZxgul+akviRoXLq3Uih9IuegxPaEHURb6L2hhZt94/PQuaW4aPNN9pRYwgaDLz2IzCBOnuQSBSIRC2Y0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hI0g8cuW; arc=fail smtp.client-ip=40.107.101.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MesgwaxuCn43wsBNvIr11067a9EvmNbywyI9Tu4UnYMHg4iF3z4sL+WxQ0lpfx2lIL3IRwiS42yFXAqVImKotwvYHEJnwqin2O0N8OzZVQFvg3VjUIoE9+W0Zx9ncPmweMxYbGcc0y5fKjTblKINfD88XLKwbs8gABJawvHt+EKwsjjT/xwiLbiIZ+zPut5ehBm+6ucmz5U9oTPjjQ39VHTfzxhVW0g3qXaW3rvSUIg8XuNJZnTVwh9A8A1RwEkvaYFBVaLsSaitZ1fNsC6z1zzkKS14ThUopk+OEMgNfiMB8yKROdWBRqc2or1trhbREOnruioA6QUtHggXB03X4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MDX6jG+RQocwbR1buw8RiIrzF7NfyzrPcOlmD9EPwMQ=;
 b=B3uSRwF3/cCemeahML1rFizTpJUXD4ncIAGWW7GHBzT/eli1o5rvTCoQBw3j7kWIzloWo7qIikI56yWe3tlTVFnGaXyzTYfkpnCdCK61gmhyYDVutgLcoZ1FiWGzlZM7Bl2hiWPhlDN9gzBmRLiO40Y46V/5x9YbGndOIrrmH5HlDUfrxK4WzzRNwh6lVFPq/rpvzD7xVeV3MS85TMuBnN4O9Z591IiMt+bgGiQU03VJGSoUB3RkcDfVcpCdzMLbJP4HORQVd0rngqCazsR0PZiXj+MrPpgkIV1YxotfnxpgySPc8tGaaDJYCsfZF0IfvUrXi3wrcJzXdVI3Q5BcNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MDX6jG+RQocwbR1buw8RiIrzF7NfyzrPcOlmD9EPwMQ=;
 b=hI0g8cuWOyLbQTbFJzix/XgL04vK5G0J5iBDplo784gURd4p4k6s85W5RKLFmsVKxT5MbmZ7yEICqQNYnG3Icdxhwphlf3ZX3UoJcCev22zBnd7/0/ylZAGtm0i3KCxnWLSvwy7a8dn/UtPC4gYngli4fhprI9Ew5132atjJcD4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by SN7PR12MB7785.namprd12.prod.outlook.com (2603:10b6:806:346::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Wed, 18 Dec
 2024 10:35:07 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%7]) with mapi id 15.20.8272.005; Wed, 18 Dec 2024
 10:35:07 +0000
Message-ID: <babcac0d-af38-4268-a2c9-78c19984227d@amd.com>
Date: Wed, 18 Dec 2024 21:35:01 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 04/11] PCI/IDE: Selective Stream IDE enumeration
Content-Language: en-US
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org, gregkh@linuxfoundation.org
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <173343741936.1074769.17093052628585780785.stgit@dwillia2-xfh.jf.intel.com>
 <2e7f85ea-40ce-4b38-acd9-56c02718771c@amd.com>
 <Z1p9f6HHkjlOw5Fc@yilunxu-OptiPlex-7050>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <Z1p9f6HHkjlOw5Fc@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SY6PR01CA0107.ausprd01.prod.outlook.com
 (2603:10c6:10:111::22) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|SN7PR12MB7785:EE_
X-MS-Office365-Filtering-Correlation-Id: d8e6fb3e-9ffe-4852-5e6a-08dd1f4fa3c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZnJWNzIrRXFKMjQ5QjlWa1FQd3BGekpvY29vZFlQdW1rWStNclZYRjNrR0Nv?=
 =?utf-8?B?SkFEVzk3bHdwelZxaWxNTm00Q3E0U1RndzVhRjdUOHVsb3BaKzlvWE8yYmNT?=
 =?utf-8?B?NXZtakM0Z3JEazNGSEtxck0xZ2l5M2JwNEtHdmxob3hCWUNUSHZDMTgyVUtr?=
 =?utf-8?B?aHFkck0yTkRXVVAvNE5ndTVIYXlzWmdDR3l0Sk1SM055UU5vN3hEb1dqN0dB?=
 =?utf-8?B?djFBZGpqRzhQaWlldFMxMWFWOE12L2xIZHFqY3NUVXdleDBvaEtLR3BuaDFB?=
 =?utf-8?B?L0w5encwQnhGV3dWVXhUMFBjYXcwcjQzT2IrSHd2cHloV0dWQ1EwK3BFUXlT?=
 =?utf-8?B?SWJHRHlJMDdkaTJDVnUrNUNqQXpvZkdWeVZSckc3SXlpbGt5dm1NZDJ2ZVJQ?=
 =?utf-8?B?NkIraEF3NDlVZ2xvVzZYQjVWYzEydGNVbFpybkpuR2dBWkl2NUZpTlBZeGho?=
 =?utf-8?B?QkxNeVNFcll5NzJ2NmRJK0l0ZTNwb3ZodFIrWWhMWHFQRXFYS2VlS2FtRHN6?=
 =?utf-8?B?NWtYai9iQjY0L0pIblNGMlZ1N0FmV2lKZkt6TmJ4VTk5OWpLREMwN2NRcHoz?=
 =?utf-8?B?M1k0SUJwVnA1S2pSMFdHZUtvdXM3eXgyQ1Nvd2txRitOTVNvUk5VNzdSZm1J?=
 =?utf-8?B?SWluK0lSeGppT3B5UzdyUlN6ckZodUREUUdlOER6WTRuZW1BaGM3bC9ZcWtw?=
 =?utf-8?B?YlVPZ0ZwUTJHZXlLVHFiMWE2T3RLQ3N1SVd4RnpyWUZBeWduOTluckhSekNO?=
 =?utf-8?B?d0VXZWNBWFBSM2N2M0UxZXpMcHFjNmxhREZqK1hqMEhheWFwUXArV2hJS0Jn?=
 =?utf-8?B?a3JodGxvNGc5UTlFYzZTUmE0R3NVZURUU1praCsxOEE3M3hhTmtzeG1VSXJW?=
 =?utf-8?B?eFRVMGJqNkQwVTExdGFTemI1YTQ1cW16RkozNm5NUDM1eDdndWJycStka1BS?=
 =?utf-8?B?VGtoTVBpOXMxbTVoN3drQnpjL3R6QUp3czRrQk5jNFNIOXhkbUtZMXVvellI?=
 =?utf-8?B?cEtENVdSRHhMNVYxTnQxcTVNYVVKc1hBcGRLL2xyRjlveFl0b2JxUE43OWZm?=
 =?utf-8?B?M2ZxMHZBc0NJOHlZbGZ1YThWZmNJbm9vdWFCYzdwWGxLTmhlaVUyeXN2Qmlx?=
 =?utf-8?B?Qjg0eTlHcllkWGVFNlM0eitSbTRTaTVSQmVEb0ZPN1dSRk9FTU1tLzhYRHBm?=
 =?utf-8?B?T0NpaFE1eVdacEZsVk5UeXhzbG9YbGNJKzBTczQwaHMrdDVmOXV3aWxpUGNN?=
 =?utf-8?B?WlFCMEhMM3d2UFhHT2RzNFdUTy9HZUQ5eTliUStnbCtQNTlIRVZOcjdyVG5F?=
 =?utf-8?B?dFhjSWNsQTJ6bnBvaXBORlJ3Mm8zL0w3WEFYSXhZQktxUDUyVGpVUnFydjEv?=
 =?utf-8?B?eld3VXdjdVpKTnRybXNwWksxMjdNWkFvWGtpcXIxazhZUjZuMDVHNklYM3Y0?=
 =?utf-8?B?bjB1UENEVDQzVy9tcjJLZnhxWjc2TnF6SjBBQUNWVEhWcnZ5T0hkRkZXak41?=
 =?utf-8?B?OHJJZFBPalVJSko3SjJKTnMrcE1XdTJHMnJVQ0ZKb3lZKzUrekl4QWVNSVdz?=
 =?utf-8?B?Z2RwV1dSTnZjeEI0TGM5YzJYMy9QMGpTUW9qcGgySTlLWmltOGVXNUEvTmdp?=
 =?utf-8?B?VzNGZFUvcDlnL25yck44aFFFa2VMZHR3V1hlNktJY052SUFwQmVWUmdDWlN3?=
 =?utf-8?B?aXI1L0Q1TmJWSGpwaEg3UGxscjBzVDZuNTdYSUZsMGV4R2dGMGF0RDJxN1dX?=
 =?utf-8?B?b0UvZis1YzFsQ2RBd3NiOW5aTnJZRlR6cWZadnEyVUU3WnhEeCthc3piS1VH?=
 =?utf-8?B?QXZNWjk3VVZwZUFGV0dPdWsxZU4zZEk0b21YVVV2dWYwbGwxN2xUOFllenVJ?=
 =?utf-8?Q?OU6G450VXX7fg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YmNnUFNNR2YyalNGaUZZSmVNeXJteCtaOEpLTlZvRjlBOWhlUGYxZ1FRSmZ0?=
 =?utf-8?B?WEtIWHhLUkZpUlRrVTF1V3BqRWdqOEo4Z3ByWS8ybDQ0OEtMRHNFQzFoZkRR?=
 =?utf-8?B?ZEE4YmpwaWR0clJKcXVZYTY5UUcxTEszOVBZNEJ3emkwOVROYkhKQjF0clFo?=
 =?utf-8?B?MzdOazRKV2xWc3hqUk9UR1dnSFp6SnlKOXBxZnNUM1ArN0ZzS0pONWUydUJ4?=
 =?utf-8?B?em9Jdk13RDlMb1hsSFVKUE81Kys1WkFseWpJM0c2UnRQWStSUUd4M2FDM04x?=
 =?utf-8?B?S2tXN0loNzV2RVI4UEdiSWppUTd6ZXdwellZUWRpWjN3UVVzNDlPQmJWWkVK?=
 =?utf-8?B?QVFkZFA3cUJ0cURUNkNjUkJMUUgyWmczOFE3V0JrRWQ3MTVFaG03TTNkbVpT?=
 =?utf-8?B?SU40NUpKV3p4THR4NWtaUFhrODdxcVVuRnI0OXVNRENGSUlFc1RwVWM5SUlC?=
 =?utf-8?B?WXBTandjeEh5M2NaazN6dzE5ZmFwZjkzY25lT2JBT0JTVGh0NldCSDZKMWJk?=
 =?utf-8?B?WFV3bFRZSDQ4dkVGMDBaSTJXYUh3b1RyUW9maE5idE4valM1Z0cwWXU2ODBI?=
 =?utf-8?B?ODEyQlFHU3REckYySjFhaGNDNTZWVFRHV2ZoNTVreTJTR21kOU9QRGFiNmNs?=
 =?utf-8?B?eU9sVWluZGI5TElwOUMxLzdVaE5kSXVzcys0SFZBQnNnNURhdkhGVjM2dHNT?=
 =?utf-8?B?UFlIMGJNdGRNUmdOYmpvRnZxYUJ6VkZLWTVTUzd0cFNnbm1hdmZ0SGg0emR0?=
 =?utf-8?B?NWZKdDJSSnF6M2FGbUFOdEdDN2VtTXdhall3c3BGYjRnckx6TzF5QjVVZlN4?=
 =?utf-8?B?anFiUkZPdzBqeW9jaWovMk8yL2ZWYjRmZjJscGxjTEFpN09seEFSbjIwYjd0?=
 =?utf-8?B?bTl6czl1SEpCWUxoRTZqMFpIanRySWJnWWxiWWpnK3U0OTFWK1RqMTBHSmtn?=
 =?utf-8?B?YTlkWDFnMnl0bGhDRmxuRDhlU0dpVmRKTDA5M25udCtpSjFnNEkzTkxYUjZw?=
 =?utf-8?B?VDRoclJPaEVoeW41NmhvRFZQak90eVNMUlcyNlNJeUVqOWt2SSs2dGN6UGNj?=
 =?utf-8?B?NFg4bll3bDBkMmIyUkt4TEJlTEV2MXAwbE5Tb1ZjeUUvR2l6bnlWRmFuV3JD?=
 =?utf-8?B?c2pGaldLYmFGUEZiMlBOT0dvTE9WdEx3NUJsaEdtd2orY3BDMmZleTJrN1hM?=
 =?utf-8?B?UTRZYWZwb3lvaUFYT3dEVmYxalp4VENGYms4YjJmdkVja0lmZUlqZ2FGaUZy?=
 =?utf-8?B?dHVRRVR0dE1SSEJab2Y2S3FPTGlxdEhqSEYwamlweUVOUDU3S1pYZnlSMUdv?=
 =?utf-8?B?NStwSWZRazFBYnBHNyt0NU1sRGhOVUpDdEl6aWhQaXMvY1RXUE94TEl5aTVw?=
 =?utf-8?B?ckd5eTRVdUVQS2pMYWxJNWk1UzZQd2d0d1I0SmlkMDh4VkUrV09oQ2hSUURo?=
 =?utf-8?B?Q1h6ek1GL2cwL1M0MVBGTEtScHFVZlk5SXZLY0hRZFh1U2RTYmlCbDQrY2lk?=
 =?utf-8?B?bmczQ0NjTUErYzg1UzJFMzE3MjdNZVFscXFxWVpzcXd0bW54R0xSSTdmZ2ky?=
 =?utf-8?B?eHhoM0FoYkhETmh5cEl6dEYyWG1JM1Frbk83cnIxcnBlbFNIeW1oQXhhSS9s?=
 =?utf-8?B?R1hoNG9EYnRmT1BKSFVtNjI3ajY2TDFzeTVVcHcrZzV5SGk4SmMxb3N2UGpH?=
 =?utf-8?B?c09IdDdCdEEvd2dPUEZxaU8vQksvQTNZa2RZYkluUFdRa2tFcHdjcXJIcVlP?=
 =?utf-8?B?QzlhcHNBcjFEV0lpTzhuckdCbEVkdlpzU0VMTWxkK3RxM2J3MmxrTnJGTFQ0?=
 =?utf-8?B?Um5kMUduQUViYjZUWElvNVVLTHhVRVBVSkpVdWNHeWhsNkFnK3U0cm9ndHVx?=
 =?utf-8?B?eHpjZEZ4YlgyWGRtdy94RTMzUGgxODcxWG9tamhGYnZBU0M5NkNUWXlVKzBV?=
 =?utf-8?B?Y3FGY2UvT29IQjZUV1VpQzlmMUtobElDbHQwNUVZc1dUV0FFVTBxaWVXKy92?=
 =?utf-8?B?T3RsV1NRNjNTbitpVVA4ai85NFVRTXFrSmFiTmc4VEJaZUtBdXhJa042UTZW?=
 =?utf-8?B?aFp6SGZVSVRjMHhBajNkcW1XbnQ1dUZYNW4vcUU1MTNNVi81cWhxQ0tWU0JD?=
 =?utf-8?Q?/6QasRgJt4Lr4uP84wf8xt4Pj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8e6fb3e-9ffe-4852-5e6a-08dd1f4fa3c3
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 10:35:07.0263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sj+m0sj6G7TlxGcqWWi+DS4SNQpqtPNcKAjhYAW5Rrv9pLol7+kQGnzxs5TuTUtIE/TCawKeTH2AB2H5mdBrCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7785

On 12/12/24 17:06, Xu Yilun wrote:
>>> +/* Selective IDE Stream Capability Register */
>>> +#define  PCI_IDE_SEL_CAP		 0
>>> +#define  PCI_IDE_SEL_CAP_ASSOC_NUM(x)	 ((x) & 0xf) /* Address Association Register Blocks Number */
>>> +#define  PCI_IDE_SEL_CAP_ASSOC_MASK	 0xf
> 
> PCI_IDE_SEL_CAP_ASSOC_NUM_MASK is better?
> 
>>> +/* Selective IDE Stream Control Register */
>>> +#define  PCI_IDE_SEL_CTL		 4
>>> +#define   PCI_IDE_SEL_CTL_EN		 0x1	/* Selective IDE Stream Enable */
>>> +#define   PCI_IDE_SEL_CTL_TX_AGGR_NPR(x) (((x) >> 2) & 0x3) /* Tx Aggregation Mode NPR */
>>> +#define   PCI_IDE_SEL_CTL_TX_AGGR_PR(x)	 (((x) >> 4) & 0x3) /* Tx Aggregation Mode PR */
>>> +#define   PCI_IDE_SEL_CTL_TX_AGGR_CPL(x) (((x) >> 6) & 0x3) /* Tx Aggregation Mode CPL */
> 
> These fields are more likely to be written to the register than read
> out, so may need other definitions.
> 
> I think generally _XXX(x) Macros are less useful than _MASK because of
> FIELD_PREP/GET(), so maybe by default we define _MASK Macros and on
> demand define _XXX(x) Macros for all registers.
> 
>>> +#define   PCI_IDE_SEL_CTL_PCRC_EN	 0x100	/* PCRC Enable */
>>> +#define   PCI_IDE_SEL_CTL_CFG_EN	 0x200	/* Selective IDE for Configuration Requests */
>>> +#define   PCI_IDE_SEL_CTL_PART_ENC(x)	 (((x) >> 10) & 0xf)  /* Partial Header Encryption Mode */
>>> +#define   PCI_IDE_SEL_CTL_ALG(x)	 (((x) >> 14) & 0x1f) /* Selected Algorithm */
>>> +#define   PCI_IDE_SEL_CTL_TC(x)		 (((x) >> 19) & 0x7)  /* Traffic Class */
>>> +#define   PCI_IDE_SEL_CTL_DEFAULT	 0x400000 /* Default Stream */
>>> +#define   PCI_IDE_SEL_CTL_TEE_LIMITED	 (1 << 23) /* TEE-Limited Stream */
>>> +#define   PCI_IDE_SEL_CTL_ID_MASK	 0xff000000
>>> +#define   PCI_IDE_SEL_CTL_ID_MAX	 255
>>> +/* Selective IDE Stream Status Register */
>>> +#define  PCI_IDE_SEL_STS		 8
>>> +#define   PCI_IDE_SEL_STS_STATUS(x)	((x) & 0xf) /* Selective IDE Stream State */
>>> +#define   PCI_IDE_SEL_STS_RECVD_INTEGRITY_CHECK	0x80000000 /* Received Integrity Check Fail Msg */
>>> +/* IDE RID Association Register 1 */
>>> +#define  PCI_IDE_SEL_RID_1		 12
>>> +#define   PCI_IDE_SEL_RID_1_LIMIT_MASK	 0xffff00
>>> +/* IDE RID Association Register 2 */
>>> +#define  PCI_IDE_SEL_RID_2		 16
>>> +#define   PCI_IDE_SEL_RID_2_VALID	 0x1
>>> +#define   PCI_IDE_SEL_RID_2_BASE_MASK	 0x00ffff00
>>> +#define   PCI_IDE_SEL_RID_2_SEG_MASK	 0xff000000
>>> +/* Selective IDE Address Association Register Block, up to PCI_IDE_SEL_CAP_ASSOC_NUM */
>>> +#define  PCI_IDE_SEL_ADDR_1(x)		     (20 + (x) * 12)
>>> +#define   PCI_IDE_SEL_ADDR_1_VALID	     0x1
>>> +#define   PCI_IDE_SEL_ADDR_1_BASE_LOW_MASK   0x000fff0
>>
>> 0x000fff00 (missing a zero)
>>
>>> +#define   PCI_IDE_SEL_ADDR_1_BASE_LOW_SHIFT  20
>>> +#define   PCI_IDE_SEL_ADDR_1_LIMIT_LOW_MASK  0xfff0000
>>
>>
>> 0xfff00000
>>
>> 31:20 Memory Limit Lower – Corresponds to Address bits [31:20]. Address bits
>> [19:0] are implicitly F_FFFFh. RW
>> 19:8 Memory Base Lower – Corresponds to Address bits [31:20]. Address[19:0]
>> bits are implicitly 0_0000h.
>>
>>
>>> +#define   PCI_IDE_SEL_ADDR_1_LIMIT_LOW_SHIFT 20
> 
> I don't think _SHIFT MACRO is needed, also because of FIELD_PREP/GET().

(I saw your comment, just to clarify this bikeshedding :) )

PCI_IDE_SEL_ADDR_1_LIMIT_LOW_MASK applies to the source (which is 
"base") and PCI_IDE_SEL_ADDR_1_LIMIT_LOW_SHIFT applies to the result 
(which is "addr1").

May be
s/PCI_IDE_SEL_ADDR_1_LIMIT_LOW_MASK/PCI_IDE_SEL_LIMIT_LOW_MASK_FOR_ADDR_1/

or just to PCI_IDE_SEL_LIMIT_LOW_MASK

Thanks,


>>
>> I like mine better :) Shows in one place how addr_1 is made:
>>
>> #define  PCI_IDE_SEL_ADDR_1(v, base, limit) \
>> 	((FIELD_GET(0xfff00000, (limit))  << 20) | \
>> 	(FIELD_GET(0xfff00000, (base)) << 8) | \
>> 	((v) ? 1 : 0))
> 
> This Macro is useful for SEL_ADDR_1 but not generally useful for other
> registers like SEL_CTRL, which has far more fields to input. So I'd
> rather have only _MASK Macros here to make things simpler. This
> specific Macro for SEL_ADDR_1 could be put in like pci-ide.h if really
> needed.

> 
> Thanks,
> Yilun
> 
>>
>> Also, when something uses "SHIFT", I expect left shift (like, PAGE_SHIFT),
>> but this is right shift.
>>
>> Otherwise, looks good. Thanks,
>>
>>> +/* IDE Address Association Register 2 is "Memory Limit Upper" */
>>> +/* IDE Address Association Register 3 is "Memory Base Upper" */
>>> +#define  PCI_IDE_SEL_ADDR_2(x)		(24 + (x) * 12)
>>> +#define  PCI_IDE_SEL_ADDR_3(x)		(28 + (x) * 12)
>>> +
>>>    #endif /* LINUX_PCI_REGS_H */
>>>
>>
>> -- 
>> Alexey
>>
>>

-- 
Alexey


