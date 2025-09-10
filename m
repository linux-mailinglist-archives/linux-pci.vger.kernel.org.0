Return-Path: <linux-pci+bounces-35820-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22397B51B97
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 17:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B735A161EC0
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 15:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C27314B95;
	Wed, 10 Sep 2025 15:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="27ZXeLUg"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BBF5464E;
	Wed, 10 Sep 2025 15:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757517988; cv=fail; b=kQy3L7qNPKfKvKxpibuyOIQ2qjD1S/NX8PLgtOAcfb7+edVjO3jVrGngZAFJ3LXbJJn98SOKERGI3FHbz877lSEOszdQAOYPSPHTj9z7IgY3adB7Oooml2bh3EnIGpBaVldyJkKqn78U4vlRV2Bu7ETUIY7jvs74nZ+tsERAKj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757517988; c=relaxed/simple;
	bh=cWjOgEfduPZLXo0iAI2iMFAl0t+Yr7zj2TdhkAWPhlw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EkPbLWrYhWsjUokm+nfenk1ww55pMqBpXNyTBs2dUmF4bRS1UgzGAo0H/ejsFlnefcTkRziCrYc+gpEuyXqNUGoY8jy1Bxe8og4T7eU6hX2Zdyi2fW952vfCeUtcAFmurJVs4ArNBsSJXqcFFJtX+NYuCSO9Bf5Cf/6mzL6iWTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=27ZXeLUg; arc=fail smtp.client-ip=40.107.237.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gaz13mfSLOMQhXHvxfR2wYsqlaw0QE8S3xArfsn0C62xvpUPs32pJUtCce+ricQtbtV213IncHnUjb0DOnxEQgPDghBeP+rjX9rZ4kf6etZ4JsxIQd8/tVLiQGXM+H7ygrQGLthQaJsG58MtMUz5AEoAsE4xrzcSkA5tsAvsps8Sieh4NFOnFJt1PEXEQ6kPE/4e4i2oOcqC2YxnHXIQIAYIrs5huiyfnOvYjAlZOGIhcLTILqjjkIVM4jmlcU53YwO8lkfvOG513mB2X8zyn6KHM4BzNZo7EA+x6JP6N9jGyHU92xMLNdVB2IYzXkXAPUtUeaDpdk61ydpi3UT4sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kC7TWwTHSc59eKoCBlPE2Lmceyij5yTwTblh/h/CjRk=;
 b=m1oOnn4+xycea6aJuEx0BcGc6crEJuVNX36Lhijskb3g3Jdc+X/H50awcSH+wxNWWf+2Q5Xm4pg7HycgVpAg5kYle9ihR86fQqd+7JFRPaPt+GsxhxiIqJXSgxwqYP2ORz7BFYWv/BR+ppOZfjvdHECSdz//Ga6t3mYb7P7L3zEmEbA72dVsQxqk2OAluM8EKpK3P/PV8b6eVqfTI+jAHEGGqgprxSKALQRe1YXh15nCfmq10yqusrx0joXT1hMwFIYVXcvI0Wv57WUoQMSEAYp140JFM4JsYin6hmu1FR7FVCulju5DwWlb6mC229IA6Xys7JKcGSREb7FauyVrag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kC7TWwTHSc59eKoCBlPE2Lmceyij5yTwTblh/h/CjRk=;
 b=27ZXeLUg/DdO7RZ82/Sd3Ph7soCqx3HYo8ZxcLbyJEsCaTj2ZyO1tR4uYdqSTGT6D6aiOA8xXh+DIvIb54xACWhtyy+HmI+ZH8pCg3EB8J+PcBTXL/2rjYhfi/z1Rb3BcqYR5rTw9ijjQ8YLJ1CC8/cCQ2rEbbwdHNipGWWwBzg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 SJ2PR12MB8846.namprd12.prod.outlook.com (2603:10b6:a03:549::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 15:26:23 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 15:26:23 +0000
Message-ID: <910f6bda-4f18-47a9-9150-8489685c857d@amd.com>
Date: Wed, 10 Sep 2025 10:26:19 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 09/23] PCI/AER: Report CXL or PCIe bus error type in
 trace logging
To: Lukas Wunner <lukas@wunner.de>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, dan.j.williams@intel.com, bhelgaas@google.com,
 shiju.jose@huawei.com, ming.li@zohomail.com,
 Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
 dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250827013539.903682-1-terry.bowman@amd.com>
 <20250827013539.903682-10-terry.bowman@amd.com> <aK6101l5vMZA3MUs@wunner.de>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <aK6101l5vMZA3MUs@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR05CA0018.namprd05.prod.outlook.com
 (2603:10b6:805:de::31) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|SJ2PR12MB8846:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c673499-dcbd-4d04-9aa8-08ddf07e665b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RysyNXhoeE5SMnhnaE9hZ3hBWFRHa1FwdzU2UEJuWEdnZzJpNVhmUVFmVHUr?=
 =?utf-8?B?aTEwTThIdWE5KzVHdlNLcUwxdURLOFBBSmNmYUY2SGZYa3gvVUt0M3VxODVF?=
 =?utf-8?B?WnhOZnNiWnBkMUROZEVYWThWKzdTSnJvbFljdndETTdWRENzWmxORlJuTWZp?=
 =?utf-8?B?MFl3Ymgxd3Y4cFF5U1NFU25JNG40TWQxTjI4STZOdFIvMnB2WWxVMU5nelVa?=
 =?utf-8?B?V2pxT0NNNUFCR2g5Y1R2R0h6U0prLzFmODhsU29qZ2VUZWpGNG1DckhrUEhR?=
 =?utf-8?B?d3U1RThTMHZFM2JveTJrTjFaampCTGkxTnp6MHBJclM5KzNnRExlbDdSWGtJ?=
 =?utf-8?B?Y1FidGJhTmF4NXduSEtPcFFVdHFJTzUzM28rL0hvS0pSR2RlVEQ3M3U5Q3RL?=
 =?utf-8?B?ekhtSTdsNDdLMTdpZUJjcEQrSWJwL2RNVEFjWVB5QUFGYUtEUE9WVStHUHly?=
 =?utf-8?B?OWdyYTMwc05PTFdoQy8rZ3FyYkhXcFV3Um52TXB0UnA1eWw0ZUdpcVMyK05z?=
 =?utf-8?B?NXVjRFE3dC8zVXF1QUk2UjE2Tmh5WDdYUFVPZHNCR0g1UUJFa0d0akZRU3Vr?=
 =?utf-8?B?djJJcVEzWUJDaFlmMmd2Mkg4bGpwZFo4S2p0SlQ4dkppOUxjcHJRMWg0Vkc1?=
 =?utf-8?B?c0VXbWlqTUM4N0xMa3kxSjUyMjVHTXpzeHErdXJjRU1ScEZhWWx1QzVzbGVT?=
 =?utf-8?B?TG11QzVRTUZDaWVsK2hrbHVIM09PUFlpVjNYbXVCMzVBZTZRTVpaaWdMaEZw?=
 =?utf-8?B?bE4zb1BkYWNlbUZNeG5WUmk0VWxLYWN0QmlhSnZDR0hrVG5zaHN2aHBrVzJu?=
 =?utf-8?B?c2kybWFVV243MkV4QXRvKzJyeCszUmpOQWo0dTB1NzFJbklQTFNjcVU5elNG?=
 =?utf-8?B?N1dCeEg2a2o4K3R2TTdISjNuZ0Rtb2R2L0JtR1RUbE9HZzNhbnlHdjhRQ3ZE?=
 =?utf-8?B?MmdNanBlaEpmSWZPbElSRzdtZXlSZGxTcDhId1RSUWwxRmJoSkRZSytBbDRs?=
 =?utf-8?B?cFJLZHM0aGZLR2ZJUzlsUTlscU5ra1NIaFBuK0haMnBZRm5mVitabnFlNWo0?=
 =?utf-8?B?K1V3RlowR2JmT2hNZS96YkdkZ015cGx3T0o1M0FxTFU5WDhRanh6bC9vRGt2?=
 =?utf-8?B?ZkdSMmFEMVZjN1RISm9yLzJGU2RuQ3pLMURYL2pTdU5wNTdDUm1lbEdXUllk?=
 =?utf-8?B?OUFBaW5NR1lEY1dGSlVxSW1kVnE0RnVvY1JidzBubHZqMDdQaGl4OURMMXBF?=
 =?utf-8?B?aytmQlBxbzJldkNUbFkxNGkzRDFsQmo1cmd1dVlrd0M3V1BWU1FXUHdDUkF3?=
 =?utf-8?B?YWJVWk5vY01XVXNkMkNzcmdPUXFMWGVGYUcxbXh3dm1UZVNubnI5STZJT2U5?=
 =?utf-8?B?akRGdFNjTjFFQnFFTWU0aVVsSDZXUkxIcUsvNUtkalM4R0xRc1Bjd3JoQUdW?=
 =?utf-8?B?bFdWVmRENmtjc1U0bVJET25WQVdlemRxb1R1Vk5MRWtvNkhDN0s2Mk0wekps?=
 =?utf-8?B?cUNRRWRxdjd3cUpzMHBnaUVhTGQvRmg5TWxYQ09DakVqQlhUQ1N5RnFmWmZa?=
 =?utf-8?B?bWhOUmVYRTdFcDcwUEp1OG9MakdLZTh6TXg0eXV2UlY2VklmazBGeDZOM1E2?=
 =?utf-8?B?Z3Erc0FFcnFEOVFMRW1RdzhYVzhESjk0UnhRTFdUM0JBRUR6cXZKV2pVUW5L?=
 =?utf-8?B?dkFqdTBFeVN6NmttVDUvSVVweWFsTGxwQmNIQmRzWjFQYVU0UkdxV3NWOUFi?=
 =?utf-8?B?TEkyZWtxMXhVMWszWEQyckZhcUM2T2NwZ05tc1J4d0hZMzVCQkxnRDBVQlRr?=
 =?utf-8?B?ZVhKK0NxQkJ1dERDMWFlcVpXcytTd2Q1K0M4a0R6TzhuU2lSdmM0WGNxd0pN?=
 =?utf-8?B?aWtNVjkxQytWbGtJNFd3N1U0SjZOc2puZVIxUW5nSjZzQXEvbDA3REVOYmFH?=
 =?utf-8?Q?5XyScqggr5g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z1oxM2djTiswTEIvT3NJOW5BWVkvVGdsb3dnVnFPL3U1OWJUWUhFTmFyWnJ4?=
 =?utf-8?B?SVRTTmNTRVh3RlBIbWZnRUxpc3MxemlleUFlYXc5WCtFUVBCODJpSVhtalpx?=
 =?utf-8?B?Y2c2eVBTOHRjR2RvY05ubWFWUmtQNllZMm55clNDMEJwamtsc3Qwc3FKOEgv?=
 =?utf-8?B?RGdnYVhwQmFOSEJvTWgzbG1YbzUyYW1JTEJjbVNZeXI4QjZyOXZpWTFGMEM1?=
 =?utf-8?B?Qk5kY2hZa3U0aFMyU0VNMEZLVlRId3dQR016NFZBdWZDcVd6RmlKczllK2tX?=
 =?utf-8?B?dkpZL2JNYjVSOE5EU1RIWUhUVDhtU2tOKzdFWFpwK0lmenhzTitqNTFhVll1?=
 =?utf-8?B?bXZ1NlU3MzZYOEdqZmJIUFl2RE5WRGRXcVViY0pDZ1hpbm5tL241Rk9JODNY?=
 =?utf-8?B?V2pIeThwMzRaNFNXbkpiV002VmtlYnBES2RCTG83L2dGeC8rc000VTgvNGlk?=
 =?utf-8?B?Z2ZYank2K051My9tT3EwK1hEeHZuZG1KVU0zVllyNUZaZjhrOTFuVkpwUDRV?=
 =?utf-8?B?cWJkY1pCYnh4VEx3T01nVTI5dzdBeE5wcHBQOTBML0VOMHRDMStEdnYvcXR6?=
 =?utf-8?B?cWYvWWFmZzBMMnV0UnFxY0RlSUJTZjdDWjJQMmJCdkRVWjRldXJKcHdPMWJ1?=
 =?utf-8?B?M041THA2clRxREpFOFE1MTQ0UjU5Nm1PMTZkdDQxWjR4WW1aMENSWnhhbUlC?=
 =?utf-8?B?TWt2akp1VnFoUXZPQmZ3RXVMbkh5bmVHMG1DdDlhNnVFTzdJaVFjQTVRZGl6?=
 =?utf-8?B?TWF3VmwxaS9MNUVQNnZFbm1EWU9pb2JlZU9DQU5VRmdFMWRvT2NkWVp1VFBk?=
 =?utf-8?B?dXNPV2xCMXJKcE5FSFpNaUFBbmJQVUc4d1l4dFkyWXVObW9MVkJyUmhGUzdH?=
 =?utf-8?B?SC9md1hMVlcyUlIwZFhjK25SRm9BSmZSOWtrM05pSUdhdjl1OVJRVXJIR3E4?=
 =?utf-8?B?OXhoRE1oWGVjTmRXd29vVEljREhkSk1sTjR2dGp2SlNlYmJJNFdNRFdQb2xa?=
 =?utf-8?B?Tk9OeXh1VTdUdVJnMy9KTXk2alRuVTJqK3JRUFo3YzZjd0Y0ZGIrdk1TMkRT?=
 =?utf-8?B?Zm9QajNzN3hmV0tOdndNam9Gb2wwRC9BRHY4ZHd6dHhTOThjYlNIQjViN3cx?=
 =?utf-8?B?elZvNTViR0VFd2ZsaC95ZTM2THR2WUs2VXNZTnBlQVo3aW9XNVJOVGNFK2tp?=
 =?utf-8?B?clBBWXpHZGpjYzYxZS9NSzZGQkFPaUViYVdVY3NvU3ZNRTJ3NUIzU1psMjgz?=
 =?utf-8?B?TWVGd0FiQm5LTm8xOWRBRU45bGM2ejJTZG1xNzkrU2U3Y01EQkJ2VUpnRzl3?=
 =?utf-8?B?TDNXTms0S2I3QWRJWG5iVG13d2RHMXlTRy9zclpQek50UnVYc3dMOTRpR2JO?=
 =?utf-8?B?MzUvUjV5Z1VxNmVkTlAwdE1CVCtPT0RNd2hHVC9MNmU0NXJtWnd2UVg5eE5T?=
 =?utf-8?B?Q29aSG9hbnI0b1oycVRKTnM0UkMvZU1YZnUyN2tjQklpUUVuN0tKbHJZRHlX?=
 =?utf-8?B?WUF1Q1BwMm5VN1Y2V3VuNkJsVkYwUVJ1S3pjTitBS3N0aXVVY29VZTFmUkIy?=
 =?utf-8?B?S0dEZERpOSs3OUZ6N3QxeG9XakZxZzBKRlRYcXd5S3JPOTRsRW12bWsxb0Jj?=
 =?utf-8?B?L0xwTW5LRm9ncHlrZ2hMTklNMlBPSERWaFNjUzZaWEs2Q0ZtR1pLTi9KT0tB?=
 =?utf-8?B?eEpZVjVTeHk4bm9HUGd1cWhVOEJHYzRTM2JiUU9xbFRaam5NQlVZTVgvejJB?=
 =?utf-8?B?VEdNemthRys0TGNGODd1ZmpGYzMzaGFINTVVMzNSUE9meW9tOFNhdUtaM0xa?=
 =?utf-8?B?bjJXRzdERVM0VGp4Q09YSjVnc1RiREdBMUNqT09kR3REUmh2c0EyWFRVUzRj?=
 =?utf-8?B?ZnljZ2NxbSthQnpRcUh5bTg1MFc3S2tjS0dRb3JMUFozdXN4UE5oM09DR0ZD?=
 =?utf-8?B?N3FEOHlHa0RiRURtZExtckVvbnpvTllWWFMybEhURVgrYXZvenFwVk90S1ZQ?=
 =?utf-8?B?djczRTZTWmRwc2hSSEFkQXJMVEUzcms1K0V2UWl6dk51Z3VyaENBczhueVRW?=
 =?utf-8?B?Wi9jZGlvY0VNNVBNVjZxdEJaUE5VVWxnT3NTVlYvQ0ZreGhkVmFkY0VRNUhG?=
 =?utf-8?Q?RuIFN77OaANCNwe/woJokrUvV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c673499-dcbd-4d04-9aa8-08ddf07e665b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 15:26:23.3373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hg2vR4eei2LB2orM5hrNezwkhWZXDXuDzEx3yyyqI4eccC1MDFUydoV8k7DFHE8aAqzu1Zy/p6v3x60t5NdrRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8846



On 8/27/2025 2:37 AM, Lukas Wunner wrote:
> On Tue, Aug 26, 2025 at 08:35:24PM -0500, Terry Bowman wrote:
>> The AER service driver and aer_event tracing currently log 'PCIe Bus Type'
>> for all errors. Update the driver and aer_event tracing to log 'CXL Bus
>> Type' for CXL device errors.
>>
>> This requires the AER can identify and distinguish between PCIe errors and
>> CXL errors.
>>
>> Introduce boolean 'is_cxl' to 'struct aer_err_info'. Add assignment in
>> aer_get_device_error_info() and pci_print_aer().
>>
>> Update the aer_event trace routine to accept a bus type string parameter.
> aer_print_error() has a pointer to the struct pci_dev and you've added
> an is_cxl bit to that struct in the preceding patch.
>
> Is there a reason why you can't just use that dev->is_cxl bit, in lieu of
> adding another is_cxl bit to struct aer_err_info?
>
> If so, please document it in a code comment or at least in the commit
> message.  If there isn't, please use dev->is_cxl.
>
> Thanks,
>
> Lukas
Hi Lukas,

The addition of 'is_cxl' member to 'struct aer_err_info' was requested by Dan Williams
during v7 review:
https://lore.kernel.org/linux-cxl/67abe1903a8ed_2d1e2942f@dwillia2-xfh.jf.intel.com.notmuch/

My understanding is the change was requested to encapsulate the bus error 
type with the actual AER status. This is helpful when considering the 
actual device bus state can change between capturing the AER status and 
handling/logging. An example is a training HW error. Caching the 'is_cxl' will allow 
the drivers to properly identify the error bus type for further logging and 
handling.

Hopefully Dan will add his thoughts here.

Regards,
Terry


