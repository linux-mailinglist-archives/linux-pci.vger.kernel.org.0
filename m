Return-Path: <linux-pci+bounces-14818-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 284E69A2946
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 18:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A36971F27504
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 16:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97BF1DEFE5;
	Thu, 17 Oct 2024 16:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UlBYLhmK"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17511DF72F;
	Thu, 17 Oct 2024 16:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729183361; cv=fail; b=k2HIZzfnk/LpJjWYpgtRNVoIr52XXGfFNepaoSpOTqb/DMfDYtq4s7BY5JHYmFC0+xPt92F+alNB9pLrKPae+fvR3zqseL+H5AREA3WwMQ5u2jFNZahOeqRshmzeyCD2Gbj4eMn9nd6UTwXhsHHXG+ImNGuEeV8QSiddwcd4BE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729183361; c=relaxed/simple;
	bh=2JnpQilfUiwyUsN1+eOJEQQ3O12OngQl2AAJUEoB59U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H1eo0PWHdyaqEP2Mua8DUpiniVpWZ+zBjsLLbdAC3Ue770Rr9mcnJ/UZIZMvNxT7hpxyVVjO7ztaNXm5r/mWQHY1G8Yv2XE6HYc9+vzNIi9V/jCRgdde4AbIXg41f7RBt9+2kIJILmYBcpGuhexTvsHBD2H29fQ+i8U5/BeDtIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UlBYLhmK; arc=fail smtp.client-ip=40.107.223.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h1RmfntUUwOT6a7flgowzJM/6W8sgxkoPcEYuWmfe3Xfhi/YyX59ep6lC2xapGOylNgjle0R6vMl726oybXLV5D32wkDZKAYS7dW8qtiTYxMMeG3TZj/bn+GA3DdCcP3+mTrSdGh/Iq+HGBLEgSqIbxgCPt2TO+FCrnwkkXtV50Lj5/YKrTgAmepcysiUxPHsfp7pimEzVBKu7+azXQQRsdurUVHYHv35CfQZg4UbNFNmKFZLei73C9+of8i6LX/meW3VR2u2Yr+xtNfGHiNSOZYwz2pWxmPMcwLv9kSl25R8yV33Z8QqEkvWbyh7TIb3fNnYLmA6MOit+ceA7sLtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZIARfJLoopyINeZB2L8xkCS8TKdu2uOGppZienCz4I=;
 b=DN0ZA4CvmeClvQJXAcrHed/dRSiGSa294KWEMkjCZsDhcltxgJZJBXBZ01XC7VYQwCNr4kX7mFCU4lujrmhZNPZc13zbdLLE3XEA8QbVUCFG2bLJZT+64Iarkb2JTe68FNQxOMcIAg+TSFJt6EDLv5uaFH/58iVN9uFNbO2+phMRMTNEVqofA8jt1aEevjh2epvtpX9Ofrxi7B0Hqd938vGZ54NNfX1+g0xsSub9Zy2Gc+8g0A6eVHXnLVmxEHrHxr7uCBcJ9Nv/anSrvA52kjbOHrtz1ab0Z7LRWycvmBa+Ukp0GL4R4ECS4Nuc5KTWhPbNwCSgi1hLGA2fgU+jKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZIARfJLoopyINeZB2L8xkCS8TKdu2uOGppZienCz4I=;
 b=UlBYLhmKhpSKpgd+QerbL3ZJ0hnmi4B/lACnikV21ARhByJI9wixjdF0q//QSVlLLbWM6zKM8SdjwjVDG9D5lfie1h7/gimbs5raEcf0W7rFvh8GUXT8142jcMq9tdXIKTvZpx6bsH2OyA/CNFRkIw4ROPRcOEnZy/fH52bVC0g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 SA1PR12MB6775.namprd12.prod.outlook.com (2603:10b6:806:25a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.31; Thu, 17 Oct
 2024 16:42:32 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%6]) with mapi id 15.20.8069.018; Thu, 17 Oct 2024
 16:42:31 +0000
Message-ID: <c40d024d-e06c-42e2-b5fc-299a8af8290b@amd.com>
Date: Thu, 17 Oct 2024 11:42:29 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/15] cxl/pci: Add error handler for CXL PCIe port RAS
 errors
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 Terry Bowman <terry.bowman@amd.com>
Cc: ming4.li@intel.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, dave@stgolabs.net,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 oohall@gmail.com, Benjamin.Cheatham@amd.com, rrichter@amd.com,
 nathan.fontenot@amd.com, smita.koralahallichannabasappa@amd.com
References: <20241008221657.1130181-1-terry.bowman@amd.com>
 <20241008221657.1130181-13-terry.bowman@amd.com>
 <20241017145702.00006e58@Huawei.com>
Content-Language: en-US
From: "Bowman, Terry" <kibowman@amd.com>
In-Reply-To: <20241017145702.00006e58@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR02CA0010.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::16) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|SA1PR12MB6775:EE_
X-MS-Office365-Filtering-Correlation-Id: 26aef17f-cc30-4007-88e4-08dceecab1ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U3lrYUFSbHlRcElBS3VtVkRwWGJnMTJQaklYVnNuem9weStySXM5NWdlRzJ1?=
 =?utf-8?B?UU9oMEVaeUIwUlllc3JTMlJXdnRsb2NGc3puZTVsSHBXQitGK25WTmU1clds?=
 =?utf-8?B?NDZKYmdGbWdVajkvYy9YRC9YeHYyZ3FBL096dUdtOUViWFp3R1paY3oyUk52?=
 =?utf-8?B?SThjcTkraTJHeXJ3N1BGUDNkUmNsQjlKYmhBRVFUZi9qdWNxWTcvc0VUdERX?=
 =?utf-8?B?SUpVNTAvUXlxaXE1ZExwWTNTVlhpLzlrZk9rY2w5cWhBUWVsOXJydnhXRXln?=
 =?utf-8?B?bW03Q0pzUDdJRzFWdWhyNEFZWkYwOW55eWZ1YnVVdkZXd2NjK2s3cDZrVmVn?=
 =?utf-8?B?Y016RjFsK3J2cVFkKzY0d3cwNVhLclJaU0s1UCtXbSsycWNKWVVjK1RHZ0dR?=
 =?utf-8?B?N0ZIZkJhM2lucDZLUEtoRmdRLzIwQWdkUndabjdsV1JmdzFmaVJ2enczMDZN?=
 =?utf-8?B?SENYOUMrTEdxU0JRR3JrWE9XRnZCejVSVUcrb2RDWjFsL011cmw0TnZQRGp2?=
 =?utf-8?B?OGRENHZFa0xLcGxORHlzSlNjRTlMUEE0NUR4bGY2cEovWGdFU1Q0dkJxbEsy?=
 =?utf-8?B?ZXJJc3dOeUVpTGZpSzNiRGVnekU0V04yRFMzcmg5MHltekVPM2loNkRraGV5?=
 =?utf-8?B?akt3cXZPVklBN3A2RlFzSy9DMXRaWlBJTDJ1T3VSNUdyaUt4ZHFjSVM4bkN5?=
 =?utf-8?B?SVNTLzZoR0IwOFNFWE1UcFdKbGRsOFdFdHphMGpVb29maHVJVUNSVForVkM0?=
 =?utf-8?B?cDFycmJVWkdsUzNKcTZmQVU0bDdzdXRDdXRYWEc4TkY5Y0Q5TlZWcXIyaGFx?=
 =?utf-8?B?aVNZd0cvMVZacTBBTHZYTkd2RFVveFp6a0N5YnhWQWttZXJ0eEgyUXRFc1lN?=
 =?utf-8?B?K2hJdDZ3V21VTVY5ZnVVeEplMng0Vlh5b3JoMXJHcmlLL1ZsQ2FweVdxa0Yr?=
 =?utf-8?B?RThVekExUTJFVzY4UmFBQmRMN0FxSzJodnJnRHlHZS9TNWtSZmdRM1NveWFy?=
 =?utf-8?B?WWFlR0VQQWc2SFBRTUhGemtnYVdjZ0I5YmQ0QnJweHNBdFR1c0lHZFpLK1Vv?=
 =?utf-8?B?SXF2VDdXd1N1NjFjNmVDcHBHSmdsc2VYMnUxNWwra3MvTlNEblR0UFozblhw?=
 =?utf-8?B?QndXR2R4MHdpT2lhNXV6NUdpTnpQYUJrek1DVmN6WTJIT2ZDNUszaEFVRng4?=
 =?utf-8?B?QnBoRWhHeVpzTHdKck41L3hvNDM2WGh6aWljeGRLOHc1RWM3Qnh1bERPb2NM?=
 =?utf-8?B?OUJtWFl0NnNsWkpGVkNJank3aGRtczNVOHFPS2lmWmdERGFqYUNVbGtDeTVR?=
 =?utf-8?B?bm01NTlUaWgrZ3JCanhraEd2QUhKMTlDNFJzU01QNmFtU3dSbzVzcnhnK3N5?=
 =?utf-8?B?c0F2SGlpY21xZkpuMzN5aTN3YWk3b08vZVlpQUZBelhrUHlIcmJRVi95djNL?=
 =?utf-8?B?OCtrbjNlYVd2UXFFNmR0eS9EK1Q2QnVwSW5iVmF4Umd1dDlBUzN4UFVhYVNp?=
 =?utf-8?B?ZUszakV1WUNDSk1jZlZMaGtMYmFKZGtWbzlTZ3pwRmJtRElPUDB2MktKeEoy?=
 =?utf-8?B?cHh0ei8yb2NMRzZTaDZiMUJmenB1YndINjRkcUZRQ0gveHQxeVhBOU5qZ0d6?=
 =?utf-8?B?NjF6TERqb2FrckNWZzJYc2wyRjNlQ05vTkpOcUhXRytpWVdmUTdIR2xqRnpX?=
 =?utf-8?B?bDVONjBXWENLWmdhK2JKTDNGcmNLMHp6VFpTeE5ZOGtIdzhkQkZJMHFWU0xw?=
 =?utf-8?Q?8AnJHNVL0SrqhSLvyIRNZbTjGsPRK6pqnWwnSKo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b1plYytaMVpiajhoMXVCS0MwblBLSi9TOVYzR1JPejY4TlhGL2xSdEZiWmM2?=
 =?utf-8?B?Y2h1SWVZV3VybHR3WDN1Y3diOU5UWGxxdDdSVC9udVRDZEtBUy9vZlAwVUl4?=
 =?utf-8?B?NzVMcUJScDg2RmhyN3d2L0QrZDZ1NmE4cWhOWm5mbngwak9WZG9LcXdQb1Zm?=
 =?utf-8?B?N2thVE1VNzBSUGFxeTdGKzJ0b3hYWk92OGQ4bG00RnVqL09tM0lqam1IenFn?=
 =?utf-8?B?OVdmM1NwOEF1RGhYR3JzT2JHYmVaNWRBSjA2UVJqaDhYOXZsOE9RQXUramNF?=
 =?utf-8?B?WU5vM3VCV3dPN00zYmE4aXZtN25EMzJ5THJxV3FsK1hQV3pIZXVnZlBaWVVi?=
 =?utf-8?B?b2VoK1kzckJMRWhLQTVtcEFyN05wYVFJQXVycHU5SXhEQ3JBTVVXKzVoS3Jr?=
 =?utf-8?B?NDViYkJWN1RkNk5xN21BR1ladDFTKzFMTEVIZ0gwUU1lNHJ2K3grUkcxMURt?=
 =?utf-8?B?OS9pcWl1WFBqUkNDQTBoNEkrd2laUnpFRUNZWnpCRGk5a0E2aU5oM1Vjb21X?=
 =?utf-8?B?SEFoSzVLUGNsS1hVZ29Wb05hZVQ3RElCNDZDbnBYdmZhRXMyRlZza3BFdFYv?=
 =?utf-8?B?Y0tmVENVVHMzZzlCakhUd0xEbkN4aFBzbk9RNXFrc1JEV3lnQng3VitVTDVu?=
 =?utf-8?B?WktKVVptcGZEVXZwR1duSDZmZE1nUm9NcTRQbXVVT1BNak5TYU95czVDTjVn?=
 =?utf-8?B?cUt6c2JlRTRoa1hHNGFFRjBUODRMN3NPNEV4WFBtdWF4a3JjYS9zcTNIYW5G?=
 =?utf-8?B?cW56TGVkMDBTWmlwNTRQSXphOVp1K282RE5Yekx2R1A1VTNGSDhQdlVGR3FN?=
 =?utf-8?B?OFM2SkhSUVVtSFFveDdDL1ZIa1MxSVIxUkJCWmY1MGxOUzJ6V20vSHIzUjdp?=
 =?utf-8?B?RWQ1N3hzK2FuNGVlVitUVVE5OFFZNnRqWTdoYU9iWjFrWVI2cEk4c2x4WUFN?=
 =?utf-8?B?L2VkRnRGaWVKdFFYdTR4dmM4a2Z1T1kycUtuUFNTSVVjelJxNmhWSThNY0J5?=
 =?utf-8?B?VkRzUnhlYmhrYllqY3dJNno5bVowNld3VUFpS3AwRDMzYW9lbm9JdTNCVTd5?=
 =?utf-8?B?Zm9yUUlaVnBDWFM2SlY3UW1YNWQrdnlwSXBVczk4clA5TDYvSXNuU3JseWFP?=
 =?utf-8?B?czY5d2dJWW5XYlhBYTZDZEJjKzN3QXliSXd3WkRsOGZnVGlzODN1OU1kSE13?=
 =?utf-8?B?cW5tMlVBTjZ1SXhxQmlDWG0vdUU0bXZxYTI2dndmZzNEa01ZNDVlL0RmSjhT?=
 =?utf-8?B?c2NMT0lMY3RTd24wYWFPODJTbVpqb25MSUwxQW9NZnhIOVJydTR5SGp0aFo1?=
 =?utf-8?B?bGRxTkN6S2laYlc0UjNlNTQ0WGROQkQwOFlwOXRGT0k1TmNTYXN6b2xXdWJL?=
 =?utf-8?B?cXFHd2J2MlpuWi84U0t6YS95UllNdmNYMnZZLzN4a09yVDl2a1FTeTdNeFpE?=
 =?utf-8?B?TkV3d2tEZVBydEhEVDIweE0rZExFOFZmSlRDUXlzdDJZSlJHVG02R29kN1ZD?=
 =?utf-8?B?N2RnalFMQmFvdjhRN0pJMjR1UGNhdUpCL1YxTHNPVWpERjFCcEZUbTh5VUtZ?=
 =?utf-8?B?bUVJWkFLcTdaRGNKZk1pMTNDMEVYUlVibUxiSWlzRy9sK1VVNUZRbkthQWtK?=
 =?utf-8?B?bUdFZklxUkhJRXd4cy9wbGRyQnBPajlnQ1dNanBoc0c2TkQ5UFRXY2JsV2V4?=
 =?utf-8?B?bWRTVFZPUWVPbnFQeEhjUUV0aVEwZGIrbzZhUlBrbW1mR0ZMaTI0eWlreFVU?=
 =?utf-8?B?UWlZNnJLUklRaTJUdjk1Ui9KM2gvZmdUK0R2bG9NMkJiSVR3ckhxbFphY1Fa?=
 =?utf-8?B?dGNqQW1mUVlXMW5EeTg5REJRZUxlTVNIUSs3TnNTdDBqMndnSk1iKy9pMW1x?=
 =?utf-8?B?aE5OdzZMcU1QL05oaFczQ0xKcVY2VFgxZGxRV2pZNDZ2VFRPQm1QdkJndGF6?=
 =?utf-8?B?clRNd0tDd2VGMkVuN0VjejY3SUxJK2RvcGlJWTBkSWNFRXBIQUQ0bVlwdGg0?=
 =?utf-8?B?RnlJd0p4ejFmeGQxR3gzeXd2ZTUyMjM2MHd2UG1SN2p5MWgrVUdMM2w5N3l3?=
 =?utf-8?B?a01heDZ6Z3FYQzY5dERhL2FOZUhsdzQyeGlEWVBnWlZUcXlDYlpmbFRSSjgz?=
 =?utf-8?Q?bCHs9InQNqH109Dwgir4jM7fn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26aef17f-cc30-4007-88e4-08dceecab1ee
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 16:42:31.7632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B5yK/vuaS/FVcq1aQVNf6wVJBQzwjfwRvDNY8wenpiFYFyYI7eBfjcop0Kp6/efJALAvQHEpSiJzfIJd5dB+bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6775

Hi Jonathan,

On 10/17/2024 8:57 AM, Jonathan Cameron wrote:
> On Tue, 8 Oct 2024 17:16:54 -0500
> Terry Bowman <terry.bowman@amd.com> wrote:
> 
>> The CXL drivers do not contain error handlers for CXL PCIe port
>> device protocol errors. These are needed in order to handle and log
>> RAS protocol errors.
>>
>> Add CXL PCIe port protocol error handlers to the CXL driver.
>>
>> Provide access to RAS registers for the specific CXL PCIe port types:
>> root port, upstream switch port, and downstream switch port.
>>
>> Also, register and unregister the CXL PCIe port error handlers with
>> the AER service driver using register_cxl_port_err_hndlrs() and
>> unregister_cxl_port_err_hndlrs(). Invoke the registration from
>> cxl_pci_driver_init() and the unregistration from cxl_pci_driver_exit().
>>
>> [1] CXL3.1 - 12.2.2 CXL Root Ports, Downstream Switch Ports, and
>>               Upstream Switch Ports
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> A few comments inline.
> 
> Jonathan
> 
>> ---
>>   drivers/cxl/core/pci.c | 83 ++++++++++++++++++++++++++++++++++++++++++
>>   drivers/cxl/cxl.h      |  5 +++
>>   drivers/cxl/pci.c      |  8 ++++
>>   3 files changed, 96 insertions(+)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index c3c82c051d73..7e3770f7a955 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -815,6 +815,89 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>>   	}
>>   }
>>   
>> +static int match_uport(struct device *dev, const void *data)
>> +{
>> +	struct device *uport_dev = (struct device *)data;
>> +	struct cxl_port *port;
>> +
>> +	if (!is_cxl_port(dev))
>> +		return 0;
>> +
>> +	port = to_cxl_port(dev);
>> +
>> +	return port->uport_dev == uport_dev;
>> +}
>> +
>> +static void __iomem *cxl_pci_port_ras(struct pci_dev *pdev)
>> +{
>> +	void __iomem *ras_base;
>> +	struct cxl_port *port;
>> +
>> +	if (!pdev)
>> +		return NULL;
> Why would this happen?  Seems an odd check to have so maybe a comment.
> 


This is called directly from cxl_port_err_detected() and cxl_cor_port_err_detected().
We moved the pdev validation check into cxl_pci_port_ras().


>> +
>> +	if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT) ||
>> +	    (pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM)) {
>> +		struct cxl_dport *dport;
>> +
>> +		port = find_cxl_port(&pdev->dev, &dport);
> Can in theory fail>> +		ras_base = dport ? dport->regs.ras : NULL;
>> +		put_device(&port->dev);
> If it fails this is a null pointer dereference.
> 
>> +		return ras_base;
>> +	} else if (pci_pcie_type(pdev) == PCI_EXP_TYPE_UPSTREAM) {
>> +		struct device *port_dev __free(put_device);
> 
> Should be combined with the next line. We want it to be hard for anyone
> to put code in between!
> 
>> +
>> +		port_dev = bus_find_device(&cxl_bus_type, NULL, &pdev->dev, match_uport);
>> +		if (!port_dev)
>> +			return NULL;
>> +
>> +		port = to_cxl_port(port_dev);
>> +		if (!port)
>> +			return NULL;
>> +
>> +		ras_base = port ? port->uport_regs.ras : NULL;
> 
> Given check above, port exists. Remove one of the two
> checks.
> 
>> +		return ras_base;
>> +	}
>> +
>> +	return NULL;
>> +}

I have v2 changed (not posted yet) to use the following at the top of the function for the
if and else blocks using 'port'. Is not needed for dport.

struct cxl_port *port __free(put_cxl_port) = NULL;

Regards,
Terry


