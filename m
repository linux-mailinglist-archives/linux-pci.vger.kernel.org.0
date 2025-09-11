Return-Path: <linux-pci+bounces-35928-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F564B53AB3
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 19:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5BF2B4E1478
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 17:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88376304982;
	Thu, 11 Sep 2025 17:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hXvFDjtJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8FB362989;
	Thu, 11 Sep 2025 17:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757612912; cv=fail; b=PByHKWgvufPUEWM+iCG05G/g8+NIlUvw3zrY/tR3sou+paKEeXm5OczbpVZeMdZ4RnVMpU2B1wQG2ByEjNhKqRJ8ckdiKD8398B7tdKiufnDe2EWrU8H4pqcPb5u6+cHzdKKzw5v3DorgjwzzsiOyEtvu0o2CjVwJ+vyJ8XjOgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757612912; c=relaxed/simple;
	bh=V1ti6uEYqdegjZGCed6BKbGqq/QwZHY4Wq7Qtwn5Y3s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gwtDJ/nUKgCfyPHnDUao4Pp0foxkEDtbEj8wWQzArZgwi7kMxWW1Cx3xY43mXXGEo7+wFZF69v6cYbFucIdNGvcl45nWvL7txUttmmxI+glfmNwSDxhh77gy7BUjdQaRZwgnht4JeIcn0IEosaCGik15EdwKEZGz2xbw7Dn3HrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hXvFDjtJ; arc=fail smtp.client-ip=40.107.236.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BZ26WQryU67XzcAK9HhSH2reTaH9v1uHvUyrQOXe2eAzVD4TnWdsLx0gNIVXThv3R/LXMdoMhpnPu858Ak20dZsPQhkyRUaSBMksVe0hKBvs9b8rqH9weu07vqjBLRyAH2rqtfk9hDyAwZYSZfTG+9VMQ2C0SXiWSvV77WALDGJcgtXP9pFl1wbslWKbnXgdC1yjLPVrXpcC3o7KvV+5eoJzf8wkkHG5rAt4y1bGLxHaCw2ZW3Z682fkUlysFFtx1AZEzteFyRZtK5pB3ziRs4oZ4vfIzcQSo1u3tGnlrCRbtWYS0N36MGGq0Xq7mqO+Xnuu4Ax0tY2hSG26H888wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dUEIQ+5CVndCeS/FMo8DyzIaOHvSIjWNQnHXW+TqnoA=;
 b=MQOME/dKUAv7sZ5lUY2tGfadlrMZDbpNZ4S725c06/ydP7t78HKCyi8Qm5voj1kxhGEzPuaYgxLINWWmStiA1UYI0lvt2lqlmz5H/XTHc4jf9vDh/3yfmuZ0gAJeCiy14GKl151ciqbSQWNSUsijPTyDO5nGsMhFmypIqCwhLBFJNTUmowSOuxZZVw69yMmLvJ7r49pS5D5wqKihsqB8/8jh7Qe5gwCXyitmn+QZBCNvXOC1Z8ZgeQhiFJYThLxWEAWhCb4zM2CXnRChjbZ5qlglCQNk1pKiaDSJH256tjvF5eFuoQFJi799LUwW5Hgf48C7ld2+bARyRw8dYiDJ+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dUEIQ+5CVndCeS/FMo8DyzIaOHvSIjWNQnHXW+TqnoA=;
 b=hXvFDjtJi7QzaBzfanIAu0f1aJTqMzasg+JeT7843nPZi32HsReZ6OI6x4Cx+aHCD5avPmk7kP0mpLY00YdJAN23BccOGjq4Xl0nz9jeSW1UUsFH4BwNbzknb5nfrFLFOsDbxeUwngB5XTRvhUaP095vSGhBajX1RdbE20U1ZzQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 SN7PR12MB7810.namprd12.prod.outlook.com (2603:10b6:806:34c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 17:48:27 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 17:48:26 +0000
Message-ID: <ee9d1e0b-1583-4fd0-9598-753219957df1@amd.com>
Date: Thu, 11 Sep 2025 12:48:23 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 05/23] cxl: Move CXL driver RCH error handling into
 CONFIG_CXL_RCH_RAS conditional block
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: dave@stgolabs.net, dave.jiang@intel.com, alison.schofield@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250827013539.903682-1-terry.bowman@amd.com>
 <20250827013539.903682-6-terry.bowman@amd.com>
 <20250829163355.00004fda@huawei.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20250829163355.00004fda@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN1PR12CA0074.namprd12.prod.outlook.com
 (2603:10b6:802:20::45) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|SN7PR12MB7810:EE_
X-MS-Office365-Filtering-Correlation-Id: 44d2dd6e-f41f-4ee2-2beb-08ddf15b6924
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TjNINnRlWmVTdmRaRHFCZHJhV292a3ZhcnpUMTBWaHNnR1hXejYzeHRJVFlm?=
 =?utf-8?B?TWNXeUVWTGZXYWFwb2s3Q3U0VkNYamxmN0JLQzlRRE9COUdrVjFKNTNOVXFC?=
 =?utf-8?B?WXl6Wml3NGNLRkVRR2xvY3pRR09JMXJNUjk2T1Z1WFlFck9iQndaL1ZOaGJZ?=
 =?utf-8?B?Y2lWQmpHdE55dHdvanQveVNIQXhKK252aDc1VFNXTUZWdHJzM1FxWnJ0QmlT?=
 =?utf-8?B?UXQwbzRHSVVCSnBkNzhBeFJiUzhDODhRNC9xVG12NzVLSFNGN1VMQTRxUXNW?=
 =?utf-8?B?dldnMzFaTE9vV2Z1ck5vbGVHdGtlUytJdnZCZXV5d2hqY25LT1UyeWVXQ3ds?=
 =?utf-8?B?dWRwQzcwK3RSYWRnb0Irdy84Sk1nUDR6Z1JRYXhqWWoyUkZkY0srSGtyZnNU?=
 =?utf-8?B?Sm9ZRXp5NHMyQ3diKzVxYTVURGZtSVdVajFvbkFnVFNtbEs4bFg3c04wT2N3?=
 =?utf-8?B?WkRHMFNOZU51VGQ1VHhsYUk5aGMzMXJDeEFQSTJNSEpRRVlxOWxsSXYrUGhM?=
 =?utf-8?B?OEtzZko2ekZCeDRJM0MrdzlTQ0JDNkxTTlI5ZnR2cWVSVnNFejYvbTg4d3lh?=
 =?utf-8?B?eDVCeXY5U0RBQ2plNXVhMTZoRHB2dnl6YVRUdXd5K212OFBOQjM2QjZxMm1q?=
 =?utf-8?B?Q016eHF0S0VZZWF2b2l2MTRRamdBTzNjTCtKSm82MWd4d0VLcEZRTVlWRUk1?=
 =?utf-8?B?RFNma2ZtaUFzNDNKNGptL21vbUFLS3I4ckx0Y0J2VE1hU1o1Q3dHZ2pqeUR2?=
 =?utf-8?B?MDVsejRWOFJocFdiRFRhL3E0aTM5ajRzdC91eC9sQi92cDVBQ1FpUUFSV0s5?=
 =?utf-8?B?bU52M1VWamdpeGFXOXV6ZVZySGJIWXJweDhwUU9kSzJRNUVCaXpPU096Nzd5?=
 =?utf-8?B?dzJUbnN1dGF3aVArNDhoQ2I2T0ZIbmttaEt0dmxKOUJtckZTMHdDTlBLNWtU?=
 =?utf-8?B?eFlpRi9EWDcvYnFESG9DODRUZmtwck9SQ1htUHhQTmlIR3lxNVNlODVOZnVT?=
 =?utf-8?B?UFpWTHhkUU5la1dLcC9aOFBUaWZRendKaGhXcWE1WWJiWmkrRDBkWlkzeWJF?=
 =?utf-8?B?bWdsY3prWUJMMmFwdmtsT3hyQWtHVHQyRFlHSkNHcytYMDVOVTJNMU0vVVlT?=
 =?utf-8?B?WkxMRmlEV3V4ZFRTM2g0QmMxd1ViaW11QzNlTXA4YjFBZVJsYWFZNmdyYjlp?=
 =?utf-8?B?b2xzSEFJSmtHLytUTUVPRkUxQW5vUWV1Sk91SXU4RXdYTW1abmxDRFRGQ01T?=
 =?utf-8?B?TFFFN0pBRmMvN2V0Y3hqTVVvenpqZ1YvaUNON2JUeUVjN1dXL0lxaEdvOUtV?=
 =?utf-8?B?QXlMTHVHS1A0K0d6NVoyVncwbHVPUHQ5ZkhSZzR2b2xkdGg1SElmT1k2NWpN?=
 =?utf-8?B?Y0hOZUFQMTNtTzlmTmVZdUJEcXJNNmREckpoUi94QkV6RE8xUCtVUlgrb2RP?=
 =?utf-8?B?a3pjb1BJZ2YyYXlGNHliUFR5OVFVbFpULzlhWUFHSGduSXRGMUFvNHczbzdv?=
 =?utf-8?B?T0c1S3dkRER4VWg0dTRNaUVVYlZLK00vL1FZWHBxejA3ZWFpZ3BrRWpCVlFH?=
 =?utf-8?B?akY3a3hIYnBrWnVqWm83RmFnR09kU2tZVStUU2hRckhXdnJBWUZxdXNubEpX?=
 =?utf-8?B?MG85ZDMvSlNQOGxkN0NqL1ZmYWRrR3ZpT1JPM3JyWTMyNHFYeExBVC85N2tv?=
 =?utf-8?B?UnV0QmUvSzVzc3FMbGEvVEVqZWFndnpYVk5iSE0rTlFkeENkNVc2S3gyMXRG?=
 =?utf-8?B?bGlPUHFQd2VmMG80bTdVRjQ3T0hFWXd1blp2bGV4STdhZUs5QnhGY25aM2FL?=
 =?utf-8?B?TXYzRnQ0Tno3ZEVTZDlaK1ZIT2tYZjV1bzJFbHRaSGdTa0E1MElDTCtWcUZZ?=
 =?utf-8?B?dUVwTVdVMmg0R1dRL25ONXFxQkVCWFdCWHhibDJYZTl0aGwvbmMxNkNnN1ZO?=
 =?utf-8?Q?FMnWBz7J4Cc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TnFHUmF3czliZGNLdW9hS3BsazVIRHNFTURLdENHT3VXZHpSUDY2bXVYek5K?=
 =?utf-8?B?TC9ubkJQRi9PN0pmOUFkczJoNnIxK1ZPa3lnd1ZBVXFyYUdPSk9MTk1SZkk1?=
 =?utf-8?B?SzN4UzRVaWpUSzNCbFYwMzBOSjhkU1hIMDdqd2g3RmYvV0FmNUphVnlRRTlz?=
 =?utf-8?B?TERqWHNMRVRCMDgwZXRlUlpNcVh1KzN1UStuSFVwZ29Fbjc1WHk3bzZIYW9K?=
 =?utf-8?B?YUFWczM0QisyVnVCUUhWekR2Wkp1MlU1SEp6dWpESWRoZVhrRzMrYXNoV09j?=
 =?utf-8?B?T3pIMXh4QkRmcGk4S2N6UVhSQUcxUlIybGRtc3UwMFFqeFcrQ3lpTy90NTRH?=
 =?utf-8?B?d1F2N2o2S2sxZDNOYld1clErbTdVNFZhWUFRQ0FxN09VY1BMT3p2aFdNVE1E?=
 =?utf-8?B?QmtvVHhyR0VrUUpuSXJRcWt6d1dtdGl0NTRQOFBsUDFGR1lBeWNEMzNPWDhU?=
 =?utf-8?B?Y1YxWE4yRGRtNVI5ZnJZUkVqK2pVY3hFd1lhWHdIYWZHSHlOR0NVVWtqaTJU?=
 =?utf-8?B?M3IxNisrL3lTbGtOVWlUUUJzam15WlJtZ1ZacWFlYzkzcEFpN3VBRCtraVBu?=
 =?utf-8?B?OFFsVnJUamxqS3pscG0wT1lJOUYzeHBaS2dOMXlxTU1vbmVmZU03eUp5bkZ1?=
 =?utf-8?B?WWl6SWNUb3JyYXFzSzAzM1B2cWF4dzNwZTFEOFBpNU1lQ3R4Y0UxN1d1MmFz?=
 =?utf-8?B?V3ZiZ2NQRHVlT0RURUtJNXVrcUhVNHEvVDl5UGttK3l2dVRXeHo5QTBWaG1l?=
 =?utf-8?B?dnNmdGJNWWg1dmZyWXh3QmVDdWk1NjhJazFwd2hhUjI4MmgyK0dFWHFueHhQ?=
 =?utf-8?B?VHJzdkhFTHRmV2NlZm84TmMxK1Ryc3VYYW45RWxGQU5MQlJxSkxCcnUvejJB?=
 =?utf-8?B?ZHRGb0xvdkJYUTRKazA2Q0FSU3BSUkNpY3ZkWWk4UnRYRkh6eURDMmtZbmNy?=
 =?utf-8?B?L3dzeHhrb3JZZ1dOV0V0aFo0OG0zVHFkcGRaZWRTaWNEV0dHcndxeTRIbEwr?=
 =?utf-8?B?RjdyVlhnWXJoeXl0b1hiejE3R0tmMXdVMUVjcHZCYVJXcGhBbG8wNHFnSW5P?=
 =?utf-8?B?NytCY0RuN0oxSDlMSGRLN1JHZXNlSEgxd0tJbjk1YUUxTE41S2tKK05laEQv?=
 =?utf-8?B?OWMvalFwVXFaNDFIalFpUEJsZUZYajdLVGJxVE5HWVpSbU5tZ3ZGQ3MxZmx2?=
 =?utf-8?B?cjl2MG44cjVwbUk5UHVud3hCM3ltY1paMVVnS2x5bzdDSTBoY2NMU1JMM3FE?=
 =?utf-8?B?Z1puZnZVOTY0WHZaeFgweFp2SGM3OVV4R09iSmVQdUMyaFRJbmRnOHJ0U0c1?=
 =?utf-8?B?UHdtblFOb2FUSXJQZnNkbWZKZ2l6ZFRKazRzYnB3cmxlMHpaOXA3RlJrUVFj?=
 =?utf-8?B?b2h2US9pNVVaNlZqYnlUQ0JtVkNXZ3FuakNsOHBhMXpQbEJBZmFualVleUJs?=
 =?utf-8?B?diswNFNOekUzVVJ0Q01UTmY4c3EwNHQxcmdqcHQwRUlwNU5DbFJDMDIycFJX?=
 =?utf-8?B?Y251UnBISGRhdE02SjhLL0tsN1dBSUtiZ3g2ekc4UFpNV1phbDdzbzNXMkRw?=
 =?utf-8?B?SUQ2VE1uNWdpcHZ0RThhVUxrejZkQ2Mvem52ZlNVeGVmRjlTY20yekRsMXgy?=
 =?utf-8?B?NVR2NmpWMmRKK2RqZnhTM3l6dEdtTXpENkpva1lpOFN0T3dSYkJMVXc1dkdE?=
 =?utf-8?B?TS8zUHNWL1d0TjFTN1BEc0NKc2luSzA3Tm5sSTU2RGlqTk50bG5NVG5oT2Yw?=
 =?utf-8?B?b1BVT2JQSjZhRVRkMHpwNElxOXB6djRIL0c1MmV0N09VUWpDS3I2M1g2eHZh?=
 =?utf-8?B?NmpIR0NvWVB3MzNXMXBoR0FvdmkxcUFUeFVBUmNPTG9tV3o1NGtDSHhWMG9P?=
 =?utf-8?B?NG96R0FkVXpwTHFHSklNTzlNSFVXMFJIWm52bk9JZHhodUY4Rzd2OEt1MDBk?=
 =?utf-8?B?N01vM3RyQnFwcXhWRHpUSEJVdFpTbHRFcnZKQ0pjcktDMUVlaGNTMitVd2R2?=
 =?utf-8?B?bDk0dUhMYWw4VTdqNFRqTjdOTTEzQjJIQURLNzFQQUZKZ0lLVytSK21RQ0x5?=
 =?utf-8?B?WmRMQ0I3b1VHZUtMVmx5cEtzVi9nMlBOSFYwUzJwcXRDMGZ5U1c0MjlkMmZ1?=
 =?utf-8?Q?7OpFomvyT2cjlcs++uVsygVeh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44d2dd6e-f41f-4ee2-2beb-08ddf15b6924
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 17:48:26.6650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U7NsF4V+t0YF/oatERCQbv+lDI8rIatkDNl63Ma5pZvQSwzv9qvwkLFu1d47WokJPKe/wIJBgyV5Xk1TKxpkLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7810



On 8/29/2025 10:33 AM, Jonathan Cameron wrote:
> On Tue, 26 Aug 2025 20:35:20 -0500
> Terry Bowman <terry.bowman@amd.com> wrote:
>
>> Restricted CXL Host (RCH) protocol error handling uses a procedure distinct
>> from the CXL Virtual Hierarchy (VH) handling. This is because of the
>> differences in the RCH and VH topologies. Improve the maintainability and
>> add ability to enable/disable RCH handling.
>>
>> Move and combine the RCH handling code into a single block conditionally
>> compiled with the CONFIG_CXL_RCH_RAS kernel config.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>>
> How painful to move this to a ras_rch.c file and conditionally compile that?
>
> Would want to do that is some merged thing with patch 1 though, rather than
> moving at least some of the code twice.
>

I don't see an issue and the effort would be a simple rework of patch1 as you 
mentioned. But, it would drop the 'reviewed-by' sign-offs. Should we check with 
others about this too? 

Terry

>
>> ---
>> v10->v11:
>> - New patch
>> ---
>>  drivers/cxl/core/ras.c | 175 +++++++++++++++++++++--------------------
>>  1 file changed, 90 insertions(+), 85 deletions(-)
>>
>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>> index 0875ce8116ff..f42f9a255ef8 100644
>> --- a/drivers/cxl/core/ras.c
>> +++ b/drivers/cxl/core/ras.c
>> @@ -126,6 +126,7 @@ void cxl_ras_exit(void)
>>  	cancel_work_sync(&cxl_cper_prot_err_work);
>>  }
>>  
>> +#ifdef CONFIG_CXL_RCH_RAS
>>  static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
>>  {
>>  	resource_size_t aer_phys;
>> @@ -141,18 +142,6 @@ static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
>>  	}
>>  }
>>  
>> -static void cxl_dport_map_ras(struct cxl_dport *dport)
>> -{
>> -	struct cxl_register_map *map = &dport->reg_map;
>> -	struct device *dev = dport->dport_dev;
>> -
>> -	if (!map->component_map.ras.valid)
>> -		dev_dbg(dev, "RAS registers not found\n");
>> -	else if (cxl_map_component_regs(map, &dport->regs.component,
>> -					BIT(CXL_CM_CAP_CAP_ID_RAS)))
>> -		dev_dbg(dev, "Failed to map RAS capability.\n");
>> -}
>> -
>>  static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>>  {
>>  	void __iomem *aer_base = dport->regs.dport_aer;
>> @@ -177,6 +166,95 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>>  	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
>>  }
>>  
>> +/*
>> + * Copy the AER capability registers using 32 bit read accesses.
>> + * This is necessary because RCRB AER capability is MMIO mapped. Clear the
>> + * status after copying.
>> + *
>> + * @aer_base: base address of AER capability block in RCRB
>> + * @aer_regs: destination for copying AER capability
>> + */
>> +static bool cxl_rch_get_aer_info(void __iomem *aer_base,
>> +				 struct aer_capability_regs *aer_regs)
>> +{
>> +	int read_cnt = sizeof(struct aer_capability_regs) / sizeof(u32);
>> +	u32 *aer_regs_buf = (u32 *)aer_regs;
>> +	int n;
>> +
>> +	if (!aer_base)
>> +		return false;
>> +
>> +	/* Use readl() to guarantee 32-bit accesses */
>> +	for (n = 0; n < read_cnt; n++)
>> +		aer_regs_buf[n] = readl(aer_base + n * sizeof(u32));
>> +
>> +	writel(aer_regs->uncor_status, aer_base + PCI_ERR_UNCOR_STATUS);
>> +	writel(aer_regs->cor_status, aer_base + PCI_ERR_COR_STATUS);
>> +
>> +	return true;
>> +}
>> +
>> +/* Get AER severity. Return false if there is no error. */
>> +static bool cxl_rch_get_aer_severity(struct aer_capability_regs *aer_regs,
>> +				     int *severity)
>> +{
>> +	if (aer_regs->uncor_status & ~aer_regs->uncor_mask) {
>> +		if (aer_regs->uncor_status & PCI_ERR_ROOT_FATAL_RCV)
>> +			*severity = AER_FATAL;
>> +		else
>> +			*severity = AER_NONFATAL;
>> +		return true;
>> +	}
>> +
>> +	if (aer_regs->cor_status & ~aer_regs->cor_mask) {
>> +		*severity = AER_CORRECTABLE;
>> +		return true;
>> +	}
>> +
>> +	return false;
>> +}
>> +
>> +static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
>> +{
>> +	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>> +	struct aer_capability_regs aer_regs;
>> +	struct cxl_dport *dport;
>> +	int severity;
>> +
>> +	struct cxl_port *port __free(put_cxl_port) =
>> +		cxl_pci_find_port(pdev, &dport);
>> +	if (!port)
>> +		return;
>> +
>> +	if (!cxl_rch_get_aer_info(dport->regs.dport_aer, &aer_regs))
>> +		return;
>> +
>> +	if (!cxl_rch_get_aer_severity(&aer_regs, &severity))
>> +		return;
>> +
>> +	pci_print_aer(pdev, severity, &aer_regs);
>> +	if (severity == AER_CORRECTABLE)
>> +		cxl_handle_cor_ras(cxlds, dport->regs.ras);
>> +	else
>> +		cxl_handle_ras(cxlds, dport->regs.ras);
>> +}
>> +#else
>> +static inline void cxl_dport_map_rch_aer(struct cxl_dport *dport) { }
>> +static inline void cxl_disable_rch_root_ints(struct cxl_dport *dport) { }
>> +static inline void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds) { }
>> +#endif
>> +
>> +static void cxl_dport_map_ras(struct cxl_dport *dport)
>> +{
>> +	struct cxl_register_map *map = &dport->reg_map;
>> +	struct device *dev = dport->dport_dev;
>> +
>> +	if (!map->component_map.ras.valid)
>> +		dev_dbg(dev, "RAS registers not found\n");
>> +	else if (cxl_map_component_regs(map, &dport->regs.component,
>> +					BIT(CXL_CM_CAP_CAP_ID_RAS)))
>> +		dev_dbg(dev, "Failed to map RAS capability.\n");
>> +}
>>  
>>  /**
>>   * cxl_dport_init_ras_reporting - Setup CXL RAS report on this dport
>> @@ -270,79 +348,6 @@ static bool cxl_handle_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base)
>>  	return true;
>>  }
>>  
>> -/*
>> - * Copy the AER capability registers using 32 bit read accesses.
>> - * This is necessary because RCRB AER capability is MMIO mapped. Clear the
>> - * status after copying.
>> - *
>> - * @aer_base: base address of AER capability block in RCRB
>> - * @aer_regs: destination for copying AER capability
>> - */
>> -static bool cxl_rch_get_aer_info(void __iomem *aer_base,
>> -				 struct aer_capability_regs *aer_regs)
>> -{
>> -	int read_cnt = sizeof(struct aer_capability_regs) / sizeof(u32);
>> -	u32 *aer_regs_buf = (u32 *)aer_regs;
>> -	int n;
>> -
>> -	if (!aer_base)
>> -		return false;
>> -
>> -	/* Use readl() to guarantee 32-bit accesses */
>> -	for (n = 0; n < read_cnt; n++)
>> -		aer_regs_buf[n] = readl(aer_base + n * sizeof(u32));
>> -
>> -	writel(aer_regs->uncor_status, aer_base + PCI_ERR_UNCOR_STATUS);
>> -	writel(aer_regs->cor_status, aer_base + PCI_ERR_COR_STATUS);
>> -
>> -	return true;
>> -}
>> -
>> -/* Get AER severity. Return false if there is no error. */
>> -static bool cxl_rch_get_aer_severity(struct aer_capability_regs *aer_regs,
>> -				     int *severity)
>> -{
>> -	if (aer_regs->uncor_status & ~aer_regs->uncor_mask) {
>> -		if (aer_regs->uncor_status & PCI_ERR_ROOT_FATAL_RCV)
>> -			*severity = AER_FATAL;
>> -		else
>> -			*severity = AER_NONFATAL;
>> -		return true;
>> -	}
>> -
>> -	if (aer_regs->cor_status & ~aer_regs->cor_mask) {
>> -		*severity = AER_CORRECTABLE;
>> -		return true;
>> -	}
>> -
>> -	return false;
>> -}
>> -
>> -static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
>> -{
>> -	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>> -	struct aer_capability_regs aer_regs;
>> -	struct cxl_dport *dport;
>> -	int severity;
>> -
>> -	struct cxl_port *port __free(put_cxl_port) =
>> -		cxl_pci_find_port(pdev, &dport);
>> -	if (!port)
>> -		return;
>> -
>> -	if (!cxl_rch_get_aer_info(dport->regs.dport_aer, &aer_regs))
>> -		return;
>> -
>> -	if (!cxl_rch_get_aer_severity(&aer_regs, &severity))
>> -		return;
>> -
>> -	pci_print_aer(pdev, severity, &aer_regs);
>> -	if (severity == AER_CORRECTABLE)
>> -		cxl_handle_cor_ras(cxlds, dport->regs.ras);
>> -	else
>> -		cxl_handle_ras(cxlds, dport->regs.ras);
>> -}
>> -
>>  void cxl_cor_error_detected(struct pci_dev *pdev)
>>  {
>>  	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);


