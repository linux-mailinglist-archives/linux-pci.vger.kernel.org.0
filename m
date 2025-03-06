Return-Path: <linux-pci+bounces-23060-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC9DA54C95
	for <lists+linux-pci@lfdr.de>; Thu,  6 Mar 2025 14:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AB28170AB1
	for <lists+linux-pci@lfdr.de>; Thu,  6 Mar 2025 13:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486551E4AE;
	Thu,  6 Mar 2025 13:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="H3pDfzg4"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F7033FD;
	Thu,  6 Mar 2025 13:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741269022; cv=fail; b=B/h3BEg0a6z/veCi7t9xH1LdanxsLTaNh3zlyn4sZsbjYoVTa8UMCpixXdTkrl6IqBe3m6kAhvLXIqEQGzJnJCeFjLTPyV9KEkM32WxQ9qrCHDawDvG433vW20ITlgMfvIjqe3HL6Al2pWyXLFw0uMtr2yxzN93xAr3txrehPY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741269022; c=relaxed/simple;
	bh=UJD4m+AdgZ/ao2Eq9Ig+r1yVYPP0JkzAWV8BxR5zrwI=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NDYZvC9fGxAck4H8VooSF25elm5lVPUuWl57MQrEeszsEbqeneZY2mWXqIZuj+mCMQvqT+qij2Wx7KCtXCacuoTpFHDfrw9YgwCoDfimfnEMAJgwV+dmpyqN9w3RMZ4JXJgFr5l/aKGpCLpYm4xCGftbaaDyHDMCYJDkyf0mCz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=H3pDfzg4; arc=fail smtp.client-ip=40.107.220.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D74lcYaAXLOMXqDwlqlNpDHlSbsqL0CJCiNayvdUXt2uMz40tMKXAFD+V63rDO30QXW4vMEAeuSr4VcKWXR9Qt2MPLi85Yit5sXB1t9bSU+6Pfg+h2faRfZAWMuDbbusiaLz7McNYQ2kLRv16WfjxpIVYYF0kHBNLjgaVdsTpmvYbvuS83hfuyV54M9GjO47AlEef6tCMYfR/8jFhaeKYyAUc44pDMnRjhUvvuL+2eEBTBQF7QqpQKchr3SI6lZU/TnBgIYFqcOJAqIvUiF3na32m64tVxn7y0aAai2oWXSk2el44bnoLSUlZCBcAn61FN8vMCrUvGMtPKylU+byxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJD4m+AdgZ/ao2Eq9Ig+r1yVYPP0JkzAWV8BxR5zrwI=;
 b=vBv4tMdNeX96BhMAXl3UMyyGu6ScK7nwz/EI9dvk1/PrkLzhdz+9Zw3g3WZQXLGYKzAaa1f8UKhf3Fhps64Kc01w4Q9bHY+hkVwTiH/5evNPgo7w6ETVnjETV/Bsi7YVQzQJHap1FQ7VvKYAamoko5sbZpRpT+NWDyg98kD1RmqP8OTljJ4NQl8PSccJmMDTUOiv5kM7yh9YCFrxweIzLdDJKArZxHkoTYx1AEyK1i9+eOmTBEiYsGJCw1IJzbUa0PL9lXcK8pIcApy9UOkgWxbhi8yeiZiJa0/kbfsxgvnaAKjSHFU61w2IJptJrwMkJfIzuTgH5McSlLHKfp0Rqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJD4m+AdgZ/ao2Eq9Ig+r1yVYPP0JkzAWV8BxR5zrwI=;
 b=H3pDfzg4fq3EqKL2WM1FnPLHs18E2GIknTpso1mjv/dBZKQBZAjL9xHwr/obxeKDhrZ2p3P4kHbAryYB00eKy4WLSv0COIiiWJzMjGerHGp6ZmxW7/kxCLfI3WX5lU5wZO3VqkfO7+Cpq29jigMBFcw3m2DlbDD7EinsQlyoYHQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 DM6PR12MB4043.namprd12.prod.outlook.com (2603:10b6:5:216::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.19; Thu, 6 Mar 2025 13:50:17 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%3]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 13:50:16 +0000
Message-ID: <bb5883b9-8b32-45f9-863a-0df1c9243fdd@amd.com>
Date: Thu, 6 Mar 2025 07:50:12 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 12/17] cxl/pci: Add error handler for CXL PCIe Port RAS
 errors
To: Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 nifan.cxl@gmail.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 oohall@gmail.com, Benjamin.Cheatham@amd.com, rrichter@amd.com,
 nathan.fontenot@amd.com, Smita.KoralahalliChannabasappa@amd.com,
 lukas@wunner.de, ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com
References: <20250211192444.2292833-1-terry.bowman@amd.com>
 <20250211192444.2292833-13-terry.bowman@amd.com>
 <67c7994bd79b1_1327329455@iweiny-mobl.notmuch>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <67c7994bd79b1_1327329455@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0039.namprd11.prod.outlook.com
 (2603:10b6:806:d0::14) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|DM6PR12MB4043:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f972339-b4b7-42a2-697d-08dd5cb5d3a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aTg4N0VnQjZUdTcvekxSUmF0WlYvZS85UVBQMmRxOUFBTnBrUmlFQnRETjNj?=
 =?utf-8?B?Y0lGRSsxaE1sSHh3OHp5VTVqQzhuazVSdERIVXBtYWlqVzNvUkhZU0VsSVRn?=
 =?utf-8?B?d0dLOHFWU2FGV1Zlc05jRDBocUJlc2pibWhtYXpCbDVyK3VsdWJJVTZCaHRm?=
 =?utf-8?B?anJnQVJnSk1TYk1taEZja09MRFAxQVE5bTBCc2ZZektvYVhtVUExUEV3Wjd5?=
 =?utf-8?B?cXBzK0t4NUFuci8rOEVSb2JZYVpwVFk5MEtDZW9YNzQ1ZUwzTnl5N1Fvc2pS?=
 =?utf-8?B?K3FvWkliOFgxMHJRVGx4a3F5UEJnR0EvTEJXUStPUTdVL1pDVXZCbTY3cUp4?=
 =?utf-8?B?UHNnQ2Q3eVRFdDMzY3VFTjJoVXhEOWU4bHB6bFkra0ZWaEo3NldqenJ2VkhQ?=
 =?utf-8?B?bTU2L2tLb2s3U043UlNwbEJSNWYwKzF1TzViVUgyS09PcDVlcjluL1Y1bjhK?=
 =?utf-8?B?eDZOckhKNWMxUUVsOUN1V0U5M1Q4Wkhsa2RXVkVacnB1THR0WlNOU1dYUk1B?=
 =?utf-8?B?b0U3aFRIYk5Nb0JJS1hyN3Y1TG81bGVQV0tLd1B6UDFyZThLOVBzR0g4cWcz?=
 =?utf-8?B?L25KR2tCMzNRK3ZjNGRMWEZJSFdUWkw2ZlpVREhxYnpZaTdtamFsSW5GMFQx?=
 =?utf-8?B?STlEMW95VEdrRDU4YnpGczNuOTQ4bE43QkU0Mk1nVGsyUnM1c1U1M1I1dE5Y?=
 =?utf-8?B?SVY1OWtNUjMvcjdCMGo0Nm9pLy96U2NadmdTMVFQVlhHZWNJdzl6N3BCUzVj?=
 =?utf-8?B?Z0tmWS9PNTJVM0ltejBWL09uQmtRTU5jUGFNb09HWlFabU01ZlV5V1ZZWFVV?=
 =?utf-8?B?ZTVHaU9NYzhFS1ExTEVNT3JiV1JrL3BXUW1JdEttTTBoYU56WFVDNThkQXRp?=
 =?utf-8?B?ZzNNcFNxQ1E1aEx5RVg4RWpQSnllVUxOeHNMZEZFVG9NUmVOYytvOHI2Tm1B?=
 =?utf-8?B?Vnd1bUZIU2FsOHBSK2pkdTVHQjNTUkF1MUh5MUtyb2hKVncxQ3k3bHp2cis3?=
 =?utf-8?B?SjNuSDdocDlMWU1oRC9YdUdTZUlSVjlnSTM5alU5aXcwMTMxSUlpUGtFWWcw?=
 =?utf-8?B?OEtGVC83c3R6WDlzbVBkVlYwT0E4QzFlVFNGYzRwRURzc2k0UzdPRkd3VG5B?=
 =?utf-8?B?dSt0MWlMYjdZRkV3amNFLzJnRkhzVkFwVDJHWXdmZXk2c0J2dmJXdkp4cVBl?=
 =?utf-8?B?dDJoaVBaYlF3bU9PMllKNytNZTNSbFZWRXdyRGlHM1NFUllYMGhQbUlnNlR0?=
 =?utf-8?B?ZzdRQ0pLWjJieEtJY1ZYOTk1YU9Zd3A5NDYyY3RQWHZFYUhJRmNoSU9pQWpL?=
 =?utf-8?B?WVp6cG1yd1lJZm90c0hqN0FnNnBrdFJDN1FpR2pvSDMyVWlxUytFbHdWbGJF?=
 =?utf-8?B?YzFJdGh6bDdkNi95TlQ4OTNydUlZQWhLZXBzZHdodjFoSVR1M2hIbUhBRUpx?=
 =?utf-8?B?ZkNCcW80akpYK1h0cEVTMDJEMFdNUUREV0F4QzhEYnV0V3l6bGJKdExZbGtn?=
 =?utf-8?B?cW0rQkRhZzlqQWwwNnBzS3Jvb3I0UUNuVkVVb3BkZFc1VExSTHpMNXQ3V2l3?=
 =?utf-8?B?NVJzeE1sR1cvMEtqTHFJTUdUQlBNQmRsVXZxRDdMZUgzRU5NS09nL29yY013?=
 =?utf-8?B?WThmQVFEK255U0YzaVFOSmFveE5YMjZWYUdCK0gxOERHRndrVG91SlRNazQ3?=
 =?utf-8?B?ejB0SVI1OENScC9BYWx3WDhucmFqYmhEVGFEWS9hWER0UjlpK2tqYklTR2tO?=
 =?utf-8?B?aGtybmVHLzV5bHZsMG1ZM1NBVnZpVEN4VENWMUdaVmd3em9WdnJETitJTXZ1?=
 =?utf-8?B?YmRWQkxRNm9xRmFOZFo5d1R1RXNHNWZqb0dMaThwTW9aaEM1bWRka2JNVUdF?=
 =?utf-8?B?M2h4b3VSelBGQm9YdDQrRGRVMU9VNUFnanlkcUxQSFVoY3F4TGEzbkk5eURS?=
 =?utf-8?Q?4rdngT8VhS0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NkhYeFNlUURXd1UyV1hyUzFCazdRZU9ibWh0UkNJcHo0cmkwSlQ4NndYT0lX?=
 =?utf-8?B?SFZweDRQWkxWTGxaNklBempsRUgwYkxWRXh4YWk1d201bERUMnpFM1BadjVh?=
 =?utf-8?B?dEZIS0gzWXJkUTZmVFRJWG5PczA3K1RJemV1WjRDZUxJUisyZ0JKYVd2UExH?=
 =?utf-8?B?N2FjNHZWdXNLcm0zdU5XUVp4Qkk2aU82emRmWi92bXRRLzlXM09ydmVQQUNG?=
 =?utf-8?B?V2IwQzZDYnFMbmsrc0UvVWlWNmV3ZnZ2WWZOdUtTYWRaL21rTWwxYmZ3NXRK?=
 =?utf-8?B?QWpTdmQ5WE1GQTY4R0s2WmQ5K0VJdXcyWFV4RldoUjRrU2RlTDNhdlA5ZU9i?=
 =?utf-8?B?R3NjSFhFLzBrbUcrTEhrWG9TQTRqaWliWXJTOXU2cTc0WDdyRUladi9KcWFT?=
 =?utf-8?B?ODJ3aWR5UmdqQzlNY3lRekk5QzJDSWViMEpwSmFYTFYvTmtoTjhJKzRmcGk0?=
 =?utf-8?B?NmhNY1Fic1FXakdBU3l1S3JWM0Y0TFE5czh2ZXFjYnYxalBZV3U3clJHdFY0?=
 =?utf-8?B?YUlacURLSHhaQjRxcGtEVmRiUmZtZFRJdWNHcTY3dlZmOVlNaDZkZFd5bjBZ?=
 =?utf-8?B?bFRMT3BOZnhXOEFSOW9qcWR3MmhOcGNxMkJ4TmFMNEkvS0VySW94LzM4Skw0?=
 =?utf-8?B?c3RDdWRiU05pc2dHVUtaNlFwcEFhRDFlbFJqMk1mL25nOFRPOS96MytMWHlx?=
 =?utf-8?B?ZXpjSWJwcEJiNGZ2QWhuU0ZvNDlicEtBNlhWZ3I1bnRjNVltdXVHVitpNmNa?=
 =?utf-8?B?UDZubkFTeDBaYStTTUpwTTNrcC9ISFBFcGx3ckxqbWdxdngreENhbnhGWFp5?=
 =?utf-8?B?Snh5N2JJb3UwbXAzeEx6cHZEbFZlMWxBdUczSnNEc3liVUI2dzVnanhtWjNX?=
 =?utf-8?B?NW5tNzhZeEI4NGJicm1LTTJFdVYwM0ZPdUZtSGxHdzkrU2VibWoyeTRzdFNk?=
 =?utf-8?B?NEdaVG0yZkhoTWZydWM2QTRxazQzWWxVWUVOaDEzVFRzTm5haDdMZ2s0VVU5?=
 =?utf-8?B?a1VKSkF0N2tjdzYvb29ydHZwV1R0enZmTzRBMzNpZ1NDNzhsZy83MlFCVjV2?=
 =?utf-8?B?MVpKWldlc1NYSS8xb1lYRVRwYndzRHlWaTF6K1d1YXZlcnpDdFpjNUV2S0RM?=
 =?utf-8?B?RG9zZ3ZvTnJvdWRhcnR5clJ5dXVBZitPemdNQlNnaGJuaHpjdC9RR2w3bGU0?=
 =?utf-8?B?aUJ3UjF3YWsraVJ6MGt4c0hLWEVPUGIrNFJPbzI4L0h5dng2SGllOUk5MFIw?=
 =?utf-8?B?aGZkRURFVWJmQ1J6eGdyRkNvMm9yRzBwR0ZHMk9lR2RLbmdBYmZ4cnkwaTVi?=
 =?utf-8?B?RGF3SlBjVzBKR3crZDBKbHJsdHFtRnRZUml5b2ZULy9tcWdsRDJ6SWhKdmxp?=
 =?utf-8?B?RjQ2MWNDQWYwcUZmcyt2Q2Fyd0Z5SXAvemxydXd5UTQzN3dVamFNWFkzNElu?=
 =?utf-8?B?QWZnV2V1NG9KN001UXdiLzdaeXlOd2NaazJBYnhRL2taYkRqWXNITVdjS1Er?=
 =?utf-8?B?MlVsMHAwWEVod01aN3JVYjVhSWZVSVNBWGhFZWp5MnJ4aEx0SnB0MXhwdlFF?=
 =?utf-8?B?MFVJVU5HTHJrWURBcENnczhmMkhKcGcxT1FSeHlNc1VSQjdLMTJXNDdKcWZR?=
 =?utf-8?B?WXptQkZlOHRYOXBQcWFjMG0wb2tFalhJczlaSDFFMmNweGZTQnR4NHU4Z3Nz?=
 =?utf-8?B?TE1PVUpiV1ZPMEFyQjVKTWxROFgzN0ZKUktWRU84OXpFWHVSaFBQM0FBWXNh?=
 =?utf-8?B?TjZ0bE1iekZoaFJyWVhYckZYQUxXWFlwL2dQSDVDZVFmSUpJWlBmK21IbWxj?=
 =?utf-8?B?VjJQRXJEcDVRcmhTeXI0ck1XYlhZUUQ2NVlldjJnNUFTVUpJSFNZY0J1VWp5?=
 =?utf-8?B?ZUtqWU15emtGMUpzTjVPSVpaV0dzZWIxaUI0UzBmYktYd0IxU1pwMnE4a1h6?=
 =?utf-8?B?MndhMFpyOW45c0t5WE5LTktiVHpYdTdjNDNVRTVOTHJwY1ZpMHlYWjFxMzVv?=
 =?utf-8?B?aEZ1QXFDNmJWVDgxalRoUEYzWi9GR2FnbFhOUEE1d2FQNjYxSWxJV2ViUnJh?=
 =?utf-8?B?SlVBcGRlUmhaLzJjTzQ2Y29Fa01qbkxsRjdycjBoSi9XS0J1NFcvZ202c0hz?=
 =?utf-8?Q?YBBF8IZx9fzkZC2ro6ejczHrY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f972339-b4b7-42a2-697d-08dd5cb5d3a0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 13:50:16.8418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: prIBMsPq7oNuT9Bxk0UWqs0eZJ5np+629a6GLnu19Nirg/gxhIv0Bu2VtMVp+FYbyMiQjTWwLs3iWSbqDnp4yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4043



On 3/4/2025 6:22 PM, Ira Weiny wrote:
> Terry Bowman wrote:
>> Introduce correctable and uncorrectable (UCE) CXL PCIe Port Protocol Error
>> handlers.
>>
>> The handlers will be called with a 'struct pci_dev' parameter
>> indicating the CXL Port device requiring handling. The CXL PCIe Port
>> device's underlying 'struct device' will match the port device in the
>> CXL topology.
>>
>> Use the PCIe Port's device object to find the matching CXL Upstream Switch
>> Port, CXL Downstream Switch Port, or CXL Root Port in the CXL topology. The
>> matching CXL Port device should contain a cached reference to the RAS
>> register block. The cached RAS block will be used in handling the error.
>>
>> Invoke the existing __cxl_handle_ras() or __cxl_handle_cor_ras() using
>> a reference to the RAS registers as a parameter. These functions will use
>> the RAS register reference to indicate an error and clear the device's RAS
>> status.
>>
>> Update __cxl_handle_ras() to return PCI_ERS_RESULT_PANIC in the case
>> an error is present in the RAS status. Otherwise, return
>> PCI_ERS_RESULT_NONE.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> [snip]
>
>> +
>> +static void cxl_port_cor_error_detected(struct pci_dev *pdev)
> This causes a build error in this patch because it is defined but not used
> until later.
>
> Might be worth deferring to the future patch?
>
> Ira
Hi Ira,

Thanks. I moved the patchset to prevent the warning.

Terry




