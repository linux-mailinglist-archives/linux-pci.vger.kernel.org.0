Return-Path: <linux-pci+bounces-14682-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DF09A113A
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 20:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 852F3285EAF
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 18:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2B216DEAC;
	Wed, 16 Oct 2024 18:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qcArPhKc"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B965F14A09E;
	Wed, 16 Oct 2024 18:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729102064; cv=fail; b=r7ZZZCsp4Jers39bAtwXNm6JS17nQS1Ti6myPxpK04XhSVH7kb2EYmIySGaCZy/ut/bu6rSvb79L68sqcPeZzOOrtXCGv2sqaernKY55Ne0DlZ7LSL4IEUiFC81QgXgAf2y8brjFUK03LKvTU14GWPuvIy2O8tnfECaU6+pe4Bg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729102064; c=relaxed/simple;
	bh=Y+ZqjkgfQqFwvhaxqJNE7mTfn4uJwn6Yo1xtN/6MUcw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nXWhUtvGfAsWb+SmdU0wzTV3hzvM73JhqNzCtubSGRlUiU0PRQ1pCzvgTmQdX0Q4RB5eXsYOefcHv7f0la0mIAKxzi7uTpQIegNhi/yphO/3OMmLab5h5RLOYRwefnNSaW6v0fGtwhQ0inO3zD7llCzI2v2eNHsvLRfqu31IFbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qcArPhKc; arc=fail smtp.client-ip=40.107.92.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sdfGd4ZLGMiHpXso3lFvOyEJaG+lUHMvnWa96BdMeJkof0wN6ktVw6+sBx2C2Q6riy0oBCZQv3lYaVf6qqGyuV06ENMPnh/0UO4Mq2gR8NfNuuhEMBOVISLeUk6HZPOVDlx/R6BLNazn5JVbrU+W4nyTZu0EHMA0PNt0ipazdaRkGaGNTnDoRC2zlEffvxykCJ+ZgKfdwvgV6azGnopiiAbAKKwhYBYoxoPFDKy7sq1lu0FqZbFnPCWLLuCgjhfOD1z+GEOvsSPg5y8d1I3gebrh5JmpDtfbON38R2RNQ9qzpAHXViJhGC/uxdLdAk59yYFqNX2p6UgrVdYvToeCGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pzbvv4FBt7e41u5jlBOSUq1jEgvV/jW/zYV/xAzS3eA=;
 b=trnEf6Z4JwBl03C5yFI3Oi+MXGfgX6RyHbMmwMxWYmF+T8yPxIDznLOvCm8ScDXElulTAeoszozZOfvgpboToMVFOvKfMWOiowB0nYExXLDN3dfgOb5efT9V3ec+KNA6JW2u0EZrOFlC6J5k+maaU2xvU2ZmJyJelFNws6lbsXhW63XJB66tGqDS7r8QDkDWh3NO2DPLZGyz7jL2ozEfpJAtWIlBCm83lmw6Thru6SNPaZ3TJq2kKi+PZDnNC0bBMuysVf8f7g/+jSBaX8/96BF4aXNB/aJTwlKbbnPL40iCYZX1rvjqr0EX2WWJBBYwZwVmIOmRVZ05toxUxDms9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pzbvv4FBt7e41u5jlBOSUq1jEgvV/jW/zYV/xAzS3eA=;
 b=qcArPhKc2mwlQscpV1gcXpTSkQq4hIvGQOVICzTiI1/4gYCBWxE7L2klnjNKKszkYcRUxXvl7iduv955KNt9kE2oDRHLZ+1zHJDfQi8zh8uWL3d3FkcC8id8m2HZlCu2B+LguYR0n2YXkylLxA5W9z9ZrMswkH6T6YNZ+j3pz5I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 DM6PR12MB4236.namprd12.prod.outlook.com (2603:10b6:5:212::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.18; Wed, 16 Oct 2024 18:07:39 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%6]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 18:07:39 +0000
Message-ID: <ac5f05ec-5017-4ac7-b238-b90585e7a5bc@amd.com>
Date: Wed, 16 Oct 2024 13:07:37 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/15] cxl/aer/pci: Add CXL PCIe port uncorrectable error
 recovery in AER service driver
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: ming4.li@intel.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, dave@stgolabs.net,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 oohall@gmail.com, Benjamin.Cheatham@amd.com, rrichter@amd.com,
 nathan.fontenot@amd.com, smita.koralahallichannabasappa@amd.com
References: <20241008221657.1130181-1-terry.bowman@amd.com>
 <20241008221657.1130181-8-terry.bowman@amd.com>
 <20241016175426.0000411e@Huawei.com>
From: Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <20241016175426.0000411e@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0207.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::32) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|DM6PR12MB4236:EE_
X-MS-Office365-Filtering-Correlation-Id: b8b4c610-66bc-41fe-50e8-08dcee0d6bdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WC9saVN4NzRrTE1GYTRRQ0pqUTl4Y0pJUlI1RFZZbEtCcU1HUkFKRGlUOWp0?=
 =?utf-8?B?YXlWRDJtLzFWekswQWlBcDloc0poOFZMYXplS0RJUFIwQ3c2R1J2M0RpUDJ5?=
 =?utf-8?B?Z2dSeU40akZzazJ1cGxwczhjM0RKOEtrTzdBeFg4dExtM2QzanlJOFhBOUlD?=
 =?utf-8?B?ZElaTHYxQVFKWitnQjRhZVRkcHhuWUxQQ25IWmlUNVBnUG0xWk9VWVpheGVz?=
 =?utf-8?B?enBqWHl2dllNbjN6aTJKV2o5MkZtaXM5SDBnNUpralIyZ2VYZ3FObE1WZ3E5?=
 =?utf-8?B?YTUyUWcybitEbzNhVndSZWxDcU4rY3k2UFpSQ2dUNUEycUVzTWE3cDR5OS81?=
 =?utf-8?B?aWJKT1hKeWNIVmhJdGRVTFRrN05QWWdVUEk0VFNVRUhEcTg0anFNUEkraDV6?=
 =?utf-8?B?bDFFSDRqRWE3aHJYWEVrU21pUThwRGJwMTI5bXFpbUV3RXBwVHdLTGpscCtL?=
 =?utf-8?B?TWRsZ3ZnclJRN3NESkMvVGlicVN6Ui9aVjFlZzErRFdUTzJFUnVKRExoMVJ1?=
 =?utf-8?B?UC9zTDQxWGJMYlhVeWsxZ0ZLSkE4d05mWXU4ZjVEaVJ6THpCdGhFc3ZTS20x?=
 =?utf-8?B?bG1FbmQzWVNRTjdqc0d0T3Z2dG5uYlpYcVJ6dFNZMmZ5KzNOL2V1ZGhScVBz?=
 =?utf-8?B?aHQ1SlJlNGFVcU9zNjZrYkplNWhVaXZmdjVhV3hhT1dHcHpQNHljL2xsUUtn?=
 =?utf-8?B?eG9ZQmpHZngxVEd5VUFwS3pWQ0xkU1RyU2tlZm1tWUtOcThnSVIvY0I5WFV2?=
 =?utf-8?B?Zm9nbDVPa1hEb2RuTitEZVBzb1VtaFl5U05ZVUpmb3I0K2JQVVhYY3N3NUMx?=
 =?utf-8?B?eFAvaXJzcFg4RUhIREUwK0I3eTJPb0k5M09KTDVvTUVFNWdPbng0K0h4V0RL?=
 =?utf-8?B?ZVo0aG0xeldOMjZaUFZuMFV5N1V1aUlHMTlvYWNrWHNHdGx5djQ3V0NXUzI5?=
 =?utf-8?B?N1FKL1lGd0ZXS1NkUFFSK2pNWkhSNlI0cjVvRUJwK2RudURlMVR3RmpuOUZa?=
 =?utf-8?B?cFpMdXpscjFhTFlCUHdRUGp5Q21Kb1NjWUFXRDVCaHFzK0Evc0puN2IrSy85?=
 =?utf-8?B?MkZoYjEvSTJ2NWhTZVBOKytPOHRCZENDdHQxWFUrN25iS2E4ZkxIc3FJOFc5?=
 =?utf-8?B?VmxKc1JGVU41akYyT1VQVmd6eUNJa2RRTlRaMDQxNXFuSzdRWnk5ekhUa3Bs?=
 =?utf-8?B?dDlUczkyeko1UnJwSjBVQjc1WXYzSlFMT09WYXljVUVGaXdUcG9BSFU5WlZK?=
 =?utf-8?B?ZitqMlVxQjNyUHU3cUViSnFFWFJQNnNveUZ5MlUxbDh3VU4zZ01MV2xIamZm?=
 =?utf-8?B?VWd0NXRNM25ZMjI5b0JjQ3JHQ3NXWkRFMm9Uc1NydzRSWlNVSHhoT0gxWDZw?=
 =?utf-8?B?M2dpZlFPSG1uUUk0OUtCeEdkbHdVMWdLQUN4QjlUUVZZQ0c3L3N1MGorSFlL?=
 =?utf-8?B?dndtRXQrQmJPbllQaTYxRUt5Qk1WZ2djV1V2OERaWHJuY1A5eGVXaE1rTGZ4?=
 =?utf-8?B?aEVZVlQxQ0ErbXJ5WUhib2dZM3FZZ2EwNUVVNlNyVUQ4TnJ5N0FzQUZvaklI?=
 =?utf-8?B?NVI0MjBmTkhMaXVkbVBGcnE3ZnJUTUp5Z05Ld2lqV21FNlpBbll2dnNPOXg5?=
 =?utf-8?B?VFFoeHo1bzJNM08zSk1DOWQ0Z0ZoTVRvaC96cmxkaDhHc0xsVWIyWktIL3F3?=
 =?utf-8?B?ZDRqVmpkT2pNblVWbHpyN096eFc4K3JPRzdrRklQYWE2VlN2d0FVTDhRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cEVxN1NicmI3YmlrWTRjYTAxMUtDUWdkU0lVb0ltc1JzdkZMakNFTHpiSi9x?=
 =?utf-8?B?N1BnYWFRZDJXVHM1K2I1VitncUtTSlFDdjlnUXBBdVdZTjh0cnFTOGZTNWk0?=
 =?utf-8?B?UnFEMmZVd1lFSWg2REY4UVZXQkNEY0srdTc3bTVYaWdXMjdPT1dXbmRhc1FF?=
 =?utf-8?B?Z3NaREo5NzBvTkl5cldmc0xaZnhHbXF1REJuZ0NISmRIaGZYd3VPMjJPdmZ6?=
 =?utf-8?B?K0ZXbFBsZDdrbGRYd0ZtejYwNjd5bE9jeFg0aWJYdEd5a1JoemJzcDdVNytZ?=
 =?utf-8?B?ajh6a0JCYzdCamh5SjMxYW1iQ1Z2UmtKR0Ixa0hHSUxQNUduUlpuRDg0eHp6?=
 =?utf-8?B?NGFKSFBUc0RNQ1Z0c3AxeWpZQ09BQnBCVU45eHpEVU85WEFNMU96ekpJZmFH?=
 =?utf-8?B?MG5FRmc1dGNTcHFrWm1BZVZZcFVvN201TUlFNnYzR3lGei9rYTRZRWpnYmU2?=
 =?utf-8?B?cjJHNnY0c1RBZVdFeTdmUExKK3RUN1ZFR1QvZnNscE5rdGw1dHE2eVVVRGN4?=
 =?utf-8?B?NWdocDhyTkpYTFRpRUlVSmloUzRndkM5cVpvQWRNcWNLR1RwbW9yTU1KUEVF?=
 =?utf-8?B?cnRGNjQzQXZxRmtaVGlFcUttUmZEbGVsZGtGMmY1TDdLbUtmQzZleDYvVUtG?=
 =?utf-8?B?Q1dCWUZEcU8wclZmajNWQ0dOSlVyZTFsMmIyamRDNnU5NVJVaFJtZXFEUCtK?=
 =?utf-8?B?cXZZZ2F6ekFxYTRsTWVvMkU4WjhkaXdUNkZmNFNBQktuU0FZWThaYXdteTRj?=
 =?utf-8?B?OTVrNHc4MG1LTkxhcFFRTXlDeTVqUXducXc4RXRTa09ZOVkvRnpjeURNNDcy?=
 =?utf-8?B?TzNkYzJSQUZ0ekw4SUUxRlFPTjB2SUpqdXk3WXVWbm9yM1RsYS91U0hkeUVq?=
 =?utf-8?B?VVIwcUZ3a1hZbUZNVlZTRHNJNVQvdU9BdWJGQ1hIL3FlV2tlbytnQlovbnVQ?=
 =?utf-8?B?Z0NNTnRWQWFqR2xhalp2VXJ1dkVWeDFVQnNsdlNGZFpiYjhadnJ4RmhudlBq?=
 =?utf-8?B?QlluVVlQR1piSGxPVTFrclZNcmdPRVlRTHhPMTZQNnZZcTJvdDhKVWdud0Iw?=
 =?utf-8?B?TDBWeG52TVgrOENxNnozdEVML3d2bUpkL2d6S0xpd0hpSFNqa1dmMEtrTUpk?=
 =?utf-8?B?c0lvQzl6dCtqN2RnK0ZYWGEyR1kxM3liQ1hlWmZFbU95VFNSR0pIbDJlc2xk?=
 =?utf-8?B?ZkxGcW11QlR3bHpleFowSzlyaE9SUE8vMFlrczVaREFxTHRhSVZ0RnkxaXdm?=
 =?utf-8?B?NEhJYTBXWlVwOTVIaG0yTWxPYUxmSjVrT003c0huSG85Rk1nRFpZbXFMd2lD?=
 =?utf-8?B?bTFzRlFLNWJFUlNaV3dOalF6bEM5eFYwclFvR1JwTEllSUpxdEhxeHR5ckRr?=
 =?utf-8?B?ckJxWCtsT1pZQklxWVRKOHQzbkJLaFNISjJsYzhQRklKeGJVTTdoS3U3MzZv?=
 =?utf-8?B?MkR5Uk51NGhhU0ZTcDB6WGFDaFA3ZzFoSS9XTWpSYVhEY3YySkIwMWhNdDhi?=
 =?utf-8?B?eEp4am1VdG1uTzV4NnYwOXZvMzZvRHNmWkg0ZEhwUC9DRVpmVER2V1RhNUtj?=
 =?utf-8?B?YTB5TUIyNy9Uczhhd1FZbW5NMkZBSStaekVZRlA0UDRjMm5SNnhFdHZIOVhr?=
 =?utf-8?B?TlZ4cDBuL3ozTnJZaVBFVXhRemN0ZUFPa29OVWV1UzQ0cEZPdFA5VkZZeDBp?=
 =?utf-8?B?Syt5VDZILzRCQkZBOElQYzhyZWYxa3hvOXNWYnFnZFdrLzlpVkEvWVFJM2wy?=
 =?utf-8?B?Y1pZUitXWlJYMHdIZmJOcTEvWHhBMVlCb1Z2aHU5bjlYZ0ZjOFNoekE4eWxn?=
 =?utf-8?B?YzlmSFFUZklGTEZLSkFpU0pHV0xKT2RPT1ovc0FZdE8yVzRLU1JEcTBWTSs4?=
 =?utf-8?B?aTB3a0tsUk1sU3VFeXM1MDg4dkNESUhTVU15NjlzWlFrR3kwKys5Y0xPN0Ev?=
 =?utf-8?B?VTVDVGN5M3QvWGNVQStsd1hTaExNYWxId05vVzV2MEZEb0RhRi9zTUd1dTRN?=
 =?utf-8?B?cGhHVUNMVnVMSWhQeVNLWmtMZkprV2R2U2FwdFhnZnhGWVpYUnVvbkxsTFAx?=
 =?utf-8?B?anFyUzVCMlR6eGpFUWtxSDB1aHhqQnBDTDlHSEVHWVJjMW9SM3BENWE4dFd0?=
 =?utf-8?Q?a/UDNLBhw17dFQ4AoU9uRld98?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8b4c610-66bc-41fe-50e8-08dcee0d6bdd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 18:07:39.3034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4vgj+3HOaiGnkL7D////TASB/hrT5fn+skCJz0YJePVGZE5DqnfvCPagYauxGVjC6uid8I+uMj/UiMdgGpxdsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4236

Hi Jonathan,

On 10/16/24 11:54, Jonathan Cameron wrote:
> On Tue, 8 Oct 2024 17:16:49 -0500
> Terry Bowman <terry.bowman@amd.com> wrote:
> 
>> The current pcie_do_recovery() handles device recovery as result of
>> uncorrectable errors (UCE). But, CXL port devices require unique
>> recovery handling.
>>
>> Create a cxl_do_recovery() function parallel to pcie_do_recovery(). Add CXL
>> specific handling to the new recovery function.
>>
>> The CXL port UCE recovery must invoke the AER service driver's CXL port
>> UCE callback. This is different than the standard pcie_do_recovery()
>> recovery that calls the pci_driver::err_handler UCE handler instead.
>>
>> Treat all CXL PCIe port UCE errors as fatal and call kernel panic to
>> "recover" the error. A panic is called instead of attempting recovery
>> to avoid potential system corruption.
>>
>> The uncorrectable support added here will be used to complete CXL PCIe
>> port error handling in the future.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> 
> Hi Terry,
> 
> I'm a little bothered by the subtle difference in the bus walks
> in here vs the existing cases. If we need them, comments needed
> to explain why.
> 

Yes, I will add more details in the commit message about "why".
I added explanation following your below comment.

> If we are going to have separate handling, see if you can share
> a lot more of the code by factoring out common functions for
> the pci and cxl handling with callbacks to handle the differences.
> 

Dan requested separate paths for the PCIe and CXL recovery. The intent,
as I understand, is to isolate the handling of PCIe and CXL protocol 
errors. This is to create 2 different classes of protocol errors.

> I've managed to get my head around this code a few times in the past
> (I think!) and really don't fancy having two subtle variants to
> consider next time we get a bug :( The RC_EC additions hurt my head.
> 
> Jonathan

Right, the UCE recovery logic is not straightforward. The code can  be 
refactored to take advantage of reuse. I'm interested in your thoughts 
after I have provided some responses here.

> 
>>  static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
>> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
>> index 31090770fffc..de12f2eb19ef 100644
>> --- a/drivers/pci/pcie/err.c
>> +++ b/drivers/pci/pcie/err.c
>> @@ -86,6 +86,63 @@ static int report_error_detected(struct pci_dev *dev,
>>  	return 0;
>>  }
>>  
>> +static int cxl_report_error_detected(struct pci_dev *dev,
>> +				     pci_channel_state_t state,
>> +				     enum pci_ers_result *result)
>> +{
>> +	struct cxl_port_err_hndlrs *cxl_port_hndlrs;
>> +	struct pci_driver *pdrv;
>> +	pci_ers_result_t vote;
>> +
>> +	device_lock(&dev->dev);
>> +	cxl_port_hndlrs = find_cxl_port_hndlrs();
> 
> Can we refactor to have a common function under this and report_error_detected()?
> 

Sure, this can be refactored. 

The difference between cxl_report_error_detected() and report_error_detected() is the 
handlers that are called.

cxl_report_error_detected() calls the CXL driver's registered port error handler. 

report_error_recovery() calls the pcie_dev::err_handlers.

Let me know if I should refactor for common code here?


>> +	pdrv = dev->driver;
>> +	if (pci_dev_is_disconnected(dev)) {
>> +		vote = PCI_ERS_RESULT_DISCONNECT;
>> +	} else if (!pci_dev_set_io_state(dev, state)) {
>> +		pci_info(dev, "can't recover (state transition %u -> %u invalid)\n",
>> +			dev->error_state, state);
>> +		vote = PCI_ERS_RESULT_NONE;
>> +	} else if (!cxl_port_hndlrs || !cxl_port_hndlrs->error_detected) {
>> +		if (dev->hdr_type != PCI_HEADER_TYPE_BRIDGE) {
>> +			vote = PCI_ERS_RESULT_NO_AER_DRIVER;
>> +			pci_info(dev, "can't recover (no error_detected callback)\n");
>> +		} else {
>> +			vote = PCI_ERS_RESULT_NONE;
>> +		}
>> +	} else {
>> +		vote = cxl_port_hndlrs->error_detected(dev, state);
>> +	}
>> +	pci_uevent_ers(dev, vote);
>> +	*result = merge_result(*result, vote);
>> +	device_unlock(&dev->dev);
>> +	return 0;
>> +}
> 
>>  static int pci_pm_runtime_get_sync(struct pci_dev *pdev, void *data)
>>  {
>>  	pm_runtime_get_sync(&pdev->dev);
>> @@ -188,6 +245,28 @@ static void pci_walk_bridge(struct pci_dev *bridge,
>>  		cb(bridge, userdata);
>>  }
>>  
>> +/**
>> + * cxl_walk_bridge - walk bridges potentially AER affected
>> + * @bridge:	bridge which may be a Port, an RCEC, or an RCiEP
>> + * @cb:		callback to be called for each device found
>> + * @userdata:	arbitrary pointer to be passed to callback
>> + *
>> + * If the device provided is a bridge, walk the subordinate bus, including
>> + * the device itself and any bridged devices on buses under this bus.  Call
>> + * the provided callback on each device found.
>> + *
>> + * If the device provided has no subordinate bus, e.g., an RCEC or RCiEP,
>> + * call the callback on the device itself.
> only call the callback on the device itself.
> 
> (as you call it as stated above either way).
> 

Thanks. I will update the function header to include "only".

>> + */
>> +static void cxl_walk_bridge(struct pci_dev *bridge,
>> +			    int (*cb)(struct pci_dev *, void *),
>> +			    void *userdata)
>> +{
>> +	cb(bridge, userdata);
>> +	if (bridge->subordinate)
>> +		pci_walk_bus(bridge->subordinate, cb, userdata);
> The difference between this and pci_walk_bridge() is subtle and
> I'd like to avoid having both if we can.
> 

The cxl_walk_bridge() was added because pci_walk_bridge() does not report
CXL errors as needed. If the erroring device is a bridge then pci_walk_bridge() 
does not call report_error_detected() for the root port itself. If the bridge 
is a CXL root port then the CXL port error handler is not called. This has 2 
problems: 1. Error logging is not provided, 2. A result vote is not provided 
by the root port's CXL port handler.

>> +}
>> +
>>  pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>>  		pci_channel_state_t state,
>>  		pci_ers_result_t (*reset_subordinates)(struct pci_dev *pdev))
>> @@ -276,3 +355,74 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>>  
>>  	return status;
>>  }
>> +
>> +pci_ers_result_t cxl_do_recovery(struct pci_dev *bridge,
>> +				 pci_channel_state_t state,
>> +				 pci_ers_result_t (*reset_subordinates)(struct pci_dev *pdev))
>> +{
>> +	struct pci_host_bridge *host = pci_find_host_bridge(bridge->bus);
>> +	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
>> +	int type = pci_pcie_type(bridge);
>> +
>> +	if ((type != PCI_EXP_TYPE_ROOT_PORT) &&
>> +	    (type != PCI_EXP_TYPE_RC_EC) &&
>> +	    (type != PCI_EXP_TYPE_DOWNSTREAM) &&
>> +	    (type != PCI_EXP_TYPE_UPSTREAM)) {
>> +		pci_dbg(bridge, "Unsupported device type (%x)\n", type);
>> +		return status;
>> +	}
>> +
> 
> Would similar trick to in pcie_do_recovery work here for the upstream
> and downstream ports use pci_upstream_bridge() and for the others pass the dev into
> pci_walk_bridge()?
> 

Yes, that would be a good starting point to begin reuse refactoring.
I'm interested in getting yours and others feedback on the separation of the 
PCI and CXL protocol errors and how much separation is or not needed.


Regards,
Terry


