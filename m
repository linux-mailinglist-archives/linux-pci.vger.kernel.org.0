Return-Path: <linux-pci+bounces-15008-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C04B9AA320
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 15:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C257AB225B1
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 13:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D491537D9;
	Tue, 22 Oct 2024 13:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="urP4GamE"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A84C13B2A4;
	Tue, 22 Oct 2024 13:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729603790; cv=fail; b=XXVKT+fuIofZO+dqjLl495djRpPTM8s7zS35QVt668JkeW/+hUxrov1M5eKWyCyeaYyBjO6DSG5GWsBa0dBAgtyJ4T1+8ce5pxnjf4eAHObJjumC8qCYysPWoulB+M/r5xH8k8IY+ajMvFTHzhqv6mbPEXm3gn2MuXdA9qgzhFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729603790; c=relaxed/simple;
	bh=YvrwEJ2rbSLeM5qQxcsCXlhrWARrCEv/DEsekNJkAr8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=unlnCp5ZWGxYOkqJXGE4OeCJK5D/6Uhz3uX2snu3vh7qdn5uP0n1CfI34r0NQV8mTjJZk5ZhH5BBzs1F/65lOTbOfaj/yoUe0elD6nIuerZhFCs4kshaAZa30rNaJyrosLO61AkhMIXWKQVXHCJdz2jeDEHLIYXDAnq2KonB5/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=urP4GamE; arc=fail smtp.client-ip=40.107.94.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ioizTDmKnkccifQc3fz/aCrQ44zw2t6pGmbUGRRGkoQ/QI7x/NPSj8/rOT+cxARbvPnr5MXyhbj+K8fUPRaptOZMiCEdfGSWu1cW3iG6mk9UqkLqdsvY5PECz2HgQVBc8SDGhDlRl23QTAzZ0C1SH5na/8jqsR1Vl3lLyWr0VU8CcV50aoeZFYdIwE15eF/c9dbmRojyaNXqZoAHUNwMKPUGIrNE52rc3kSuB6dOvyNctw5IE0USDvov0iKaVdzeg/uz/EGEbK3ME96T6hwiptbpwhK+PjkQ1hevIRBwbe0gAWLQSeneKgaawLZ3x14OPvwQ1pOfyaw3DRnxxsll3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bs0NPTuhjq+rZTVnHkahNkFStuzYPFWVR4sMrSOfVb4=;
 b=MUEOtvA9TfvRPypJe8GBsnzKdo2mZO8ulLNTMdS5OVUwM5ONAQxBGVKuvwKyjqlwnDg2spiD77FuAd/SM0N9c8LnTsg0IwX8raZNnDLHIVzj2nCoCpmtWRvll2yoYu0O8VomnJc24H/2Nk3hyoJI9zSOr9YEdFSq9L9mxH/nOIv5Z4qgSHCRkA3kxnWAoMLoeECbCfznTH4ABv6R4D1aZ8CtMOElJ4f0u6l2Tb2Utv8TF7nJj7FcHc2DOdzXoFSxMG34sQ6+oZrH4MMtBDwvqknOHG+df/7eyDkHq8xBV55jBoQS/KdJnTn2k4zQjF6WQIMu0/MEoGGQw0jr2oB5oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bs0NPTuhjq+rZTVnHkahNkFStuzYPFWVR4sMrSOfVb4=;
 b=urP4GamEvA3cuZCl2ut8FlY94uC+f8N3Bzc34vrkk8OizhWOIjVv+NDdrXwJTNNUJICE+Y8/u7bOAoaYKJ4xecu/32OR2WqDgVdFZgmnUr7e1rb+gGObrrSjP7AMnNryKf9FuviPlcOPcNzOoZJZDIcbH27oReU9Xz5aEkY+ga8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 MW5PR12MB5597.namprd12.prod.outlook.com (2603:10b6:303:192::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.16; Tue, 22 Oct 2024 13:29:45 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%6]) with mapi id 15.20.8093.014; Tue, 22 Oct 2024
 13:29:45 +0000
Message-ID: <aaec3243-afb3-4021-a91a-a868595ffa69@amd.com>
Date: Tue, 22 Oct 2024 08:29:43 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/15] Enable CXL PCIe port protocol error handling and
 logging
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, ming4.li@intel.com,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, dave@stgolabs.net, jonathan.cameron@huawei.com,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 bhelgaas@google.com, mahesh@linux.ibm.com, oohall@gmail.com,
 Benjamin.Cheatham@amd.com, rrichter@amd.com, nathan.fontenot@amd.com,
 smita.koralahallichannabasappa@amd.com
References: <20241008221657.1130181-1-terry.bowman@amd.com>
 <671703521fd1f_2312294e3@dwillia2-xfh.jf.intel.com.notmuch>
From: Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <671703521fd1f_2312294e3@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR18CA0017.namprd18.prod.outlook.com
 (2603:10b6:806:f3::34) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|MW5PR12MB5597:EE_
X-MS-Office365-Filtering-Correlation-Id: 1de912e1-bd64-4809-0394-08dcf29d9804
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NmtCM3VsUE9uVHNYeG9MUGh1azFSNG9YWjh6L3FSUVREc2FWN0FBbEJDWFh6?=
 =?utf-8?B?WnU5OHlzQTVJZUI5YzlxZCt4QWxRUFJQVHNjWE5kblNhcFN5U1g4MG9IN1pQ?=
 =?utf-8?B?aStKZEJPaitQUGtqUWRLUlRSRk82bWxxWVBlbWE0cWNMVVEvNmdaZlBCRTNH?=
 =?utf-8?B?UkhtYUU4ME1xcmJVeWVodkk2VmErWUlFbjRxZFNLeWRPN2p1SzRGTmVLTEQy?=
 =?utf-8?B?ZlRnNE1vaWhNUXMzdzBicnhBK2ZGS2hweWwxa3JSWGJqTTRYUmdkZ2Q5QTZh?=
 =?utf-8?B?dGFWT1A4VEVLTmtPSi9ic3pTL1F5M2RIWWJJYnVwSmdpYjJsTi9MVjJhdnV5?=
 =?utf-8?B?dXR1QWxwNmJhTHdVVU04dVhSWGppNmhNbW5wMkdlZEdaMURaSE9scWlNUXlB?=
 =?utf-8?B?Nk5URldMRm95V0lGeFM2V3hxMUJldmxHT0c4OVI3WHExaThEVU5pazNHSGxh?=
 =?utf-8?B?K1hKN3RhZVJudGpKcDI5TndYZHVHM0xVZnZxaTAzNC92YlNuSnp5am9PMGxD?=
 =?utf-8?B?MSs3TkxQNEdLVktCQ1NQZzMxeWoyZUl2bE1vYXhQT1J3bGNaeDh2enh0azdy?=
 =?utf-8?B?eXY4alhTaFFDSVh1YklGWjk5U3RvWnplT0F6aFN0blVtczZYeFFtbVVRc0hM?=
 =?utf-8?B?a3MyWHE1bHhhQWw2Um05OGxlbXJuUDJONzNJVm1hRUtEUmlpMGtyekhZa2Vn?=
 =?utf-8?B?WGpBNW1BSURQeDQxZDRpWEZLYW80WWRvcWJqTENjZEJ2bHkzWjhFOCswTHZO?=
 =?utf-8?B?UEl0aENiTVk4c0hRc2pHVVNSb0VkMjg4cDdTZ3pKM1JUZ3VQV0RKMjVldWhK?=
 =?utf-8?B?VkpLN1ZodFBiWi9zd2NGVUw5U1p6dGlzQTR4SWZHTFhjbWNlYTQvR3FRZ0o5?=
 =?utf-8?B?Z3pRR2g4ekkrTUQ5SVFDKzdpZXJRZ3ltN0NBakt0NnFaeVR1cSs1ZEZYQ3Ax?=
 =?utf-8?B?ZXVGbXZvZVluWS82UlVuMHRTOXRXai9EWkhKV04xT05SeVFkSkdCblh3cExu?=
 =?utf-8?B?R25lOG1IdDdyazFwS2NXR2puUk5JUnNNazMyYmJOZGdneno3NFZJOWxTOWVn?=
 =?utf-8?B?a2tLdGJyUjV4R2pqMkRtS0Rxcjl2bXdidXo1UWMxcGNGcnYvOUFHT0pmVjM2?=
 =?utf-8?B?UmZmK0hLamhYd1ZNN3ZpN1NQQnAyTmhHUE1PWjhQaDZHWlY5RmtzUi9vSEJt?=
 =?utf-8?B?b0tHQmNvbklkbmRjUThXZUNZbHJ3elpBS3lFajJyN1J3ODRxRzcwRmN1MkJJ?=
 =?utf-8?B?V1FVelEwWnpPODFpOXZyaXBldlhyeVJ5YmtBRDhtVVdLQkxweHRBbGl6UlYw?=
 =?utf-8?B?UjI2cEFVZGk2ZnZFQ0J5TEVma0RRVWVEbHpQUHBxTm9HN2J2YVNjVzFPVVZJ?=
 =?utf-8?B?ckFOZ0o4WmMybWdtZTZJbFl3YU5iYVM0V3BJVU9kbFI1U2tsRUlkSTI5QURx?=
 =?utf-8?B?MUIzektHODBybFJYeUZBREp2c0h3bzZNY240YVFHQmczd2FzUGpWYVhlNlh2?=
 =?utf-8?B?dlpRZTlhQkdOL3QzMVI3ME53amRwQ05rdHo2SC9kUEloVGFUM2M4VDIvVU5K?=
 =?utf-8?B?SlA5RmEzOHFQL0tZSVpwQ0dsRktEOUlJWG9VV1RpdzFTS2djbG4wWnladWdt?=
 =?utf-8?B?dHVSNmRheFplT0JYdVdWWkdNWm1SbkFRNW55MTlYUXJNR092VVVrRjg1c0VZ?=
 =?utf-8?B?enRUV24xOEltQ3ZUNWFVY0YwL0lqblV5TnJnbmhqeTZkUUJnU3dlYys3NWxT?=
 =?utf-8?B?SXFnbDZtSG10MlpKVnM2R0RUM2hjVG9DL0d6Sy9DWndTUXVNeDFNUENBcWZB?=
 =?utf-8?Q?aIAItwV+Z/GYLNE8LaPcvj5SqlmSDS0c6RbJU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VG9WbzYra3E0N3htV1NTRFoxN0N3WmswOUEyME9BUnRQam96a2ZrTVJMM2Zp?=
 =?utf-8?B?VjV6Sk9zbEE2NWszUmNqVDA2LzZQMmFITjF4MGxxTElWNGNXMGJSMFh6NGRn?=
 =?utf-8?B?b0ZrbzdTQWlLRDdwQTJNSXZjVDBYaHVzY1d1dkY3VHVxZzdrK2psNHl5d2dO?=
 =?utf-8?B?WEkzaFhoaGlFMkU0VnlubGttRU9YNDhqTStsM2tvandncHQxNUxmRnVwZGxB?=
 =?utf-8?B?VTJSSXJCZC8weGFiL05JbzhHU2RXNDM3VWl5T1FuZlVYdmE0ZVhyUzBzeUJl?=
 =?utf-8?B?YnRJS1VLNWRHVzFlcFgxUVJ0ZmpOeGFqS0pKcjlpdFNuMlNsQmloNkk5OHlP?=
 =?utf-8?B?ZHVwUkpnOWpoWHJHdVFCbnYrMlJBUUE0KzF6cVlMaUNSZmE3RmhmNjd4cU5Z?=
 =?utf-8?B?eW1aZHZ1OEdCNC81RDdtSHpRTjdnbjF5d1pBQ0VlalhiNi84MFgwUzc3Z2xy?=
 =?utf-8?B?RGI3UFNSSXdZUHlOME1OMzUwWjgxaEJxZ0dlbDdsRTU5TjFtZDRrK0tkWXEx?=
 =?utf-8?B?bWoxUlRQSkZDcG8vcm5MMk1hNTY3dTByVXJhY09lWWM2TnE4Yzcwa3JvZHVi?=
 =?utf-8?B?aTVEMmtuZ0pwQ0RUczhjYXZpR0R4SHhGS3grc0xWWGRmdWlkOXFSdUN0Qjdo?=
 =?utf-8?B?ZlY1TUxEblpsMEJxVGZlY2xiZUQzZjBDay9VUytSbXlaOFNpY0hHZDJpNXNZ?=
 =?utf-8?B?RUpweUVtMm5YWTQ0bnZNUmYvS0dZc1RGL0cwdS9lR0tiS2I5c0V2MVBMOTIw?=
 =?utf-8?B?K1lxU1p2ZzcvaVdIaU1yUS9qaVVsMDdubmZoUmtObmhhMHZRb0ZEQzJiZXEv?=
 =?utf-8?B?WDB3YWsrT2FxWWRmaHMweFgzSURwZlJ5ODh4ZTIrUlJTQkt2U0kzb2xFUVZ1?=
 =?utf-8?B?RzRwR2QxRUo5NlB2VkV0b2FyMkYyejdBNVcrcDlIZ0t6d0V3Vk1XcFdkalVa?=
 =?utf-8?B?QWh1bUpLU1E4ZHR2RDFoZHowTCttQy9KVDQ5a0xTcDRhUm0vM2J0dE1OWVQ5?=
 =?utf-8?B?eUV3T2tvZWxxS3hmem00UHZrenQ2MWZQZ1ArVjBROW9qekxSaDFxeGpLZ1Rv?=
 =?utf-8?B?YW5ZY1UzZUx1ZmVhQVh0LzhodC9TVmEvbTJUaG1zb3d2OEZENlFUREo3WWg2?=
 =?utf-8?B?S09LdVQ1KzBqR1hDOFZWZkNhdGF5eWFnZHVmTWZ1MmQ2ekpOZmJ2MjlFcnIx?=
 =?utf-8?B?aWNMelZqeGcwbmpIcHNRTXpaYjF2K21CcEhXb0JmTThDWE1GSS94WFhlRzBL?=
 =?utf-8?B?UUx3aWo1eGJUcHFmaExoQ0prUjB5QXliOS9ZZVJKYytTcTZlY3JmTjhaZ0RO?=
 =?utf-8?B?M0xoZVNkTStPQ0JPMU43RXVxNEl3eFVUTjFic1BvazFIeVU2UjRhaThuL29r?=
 =?utf-8?B?dlJOOTdJUEluNWxNYWhLL1BKLzFoZEFNbW42SnJzaHlWNjBzTk5UUHFEN1Yv?=
 =?utf-8?B?eGlGa1lnSFg0NVR3UnVaVFFnenZ3ODU5Ukw0QzdKTStyRUk4N2tsc3NEeS9N?=
 =?utf-8?B?WXduYXRQMllWUVB5dThvbVNOOFhGTmUxYXhyUHlYankwaXB1Q213d2hGRjda?=
 =?utf-8?B?ZWFiUTdwTEJ0aFN6enhFUEphditzcmxOSGNMZDBVQ0hpNmNtVjM2aldYM25B?=
 =?utf-8?B?N0Uyc1RYTkh0bk8xcTNpNDVqQVJUMzc2Y1R4cmx4NE9HRk00UDRCSEtYYzd0?=
 =?utf-8?B?cGd2aUo2NWlpdlYyNU8vK2RRb2diRDBmc3M2Q3prNWlDRTBUWGlsbTJCVW5w?=
 =?utf-8?B?TTRCRmZaWi8yUGxtSXdCNjJxNTFjOTZ3TUFDOG9PUnMrVXJ6R2Mxd3VhSi9v?=
 =?utf-8?B?d3kzZU9MZmMzYkR6V0ZnR1ExVUNlWnMybUFaRFVKem1OVThKTUVYT1BjYlJW?=
 =?utf-8?B?OUE4SWh0V0RyN2RhU01FcUpkdjFzbVlOd2V2bWNpYzV0OXB4aS9ucC9qYWM5?=
 =?utf-8?B?S3h1OUg2L0REMHJsZ1h5eGkrcVpxNDhBODIxaEZodGlLa3hEK1hWTEpkMlgv?=
 =?utf-8?B?K3hIOTZReVdNRXN2MDBJZlg3aGlwU2hvZXpUOUxRWG05S215UzhzVk1VVCtF?=
 =?utf-8?B?UTRBL2NsbzNrOTdib2cxTklQWUdwM0RPbzg3SFVteFEyTW9WdEs0RkpaN29V?=
 =?utf-8?Q?bxbpjN2t++vkaiArX9KBy82HW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1de912e1-bd64-4809-0394-08dcf29d9804
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 13:29:45.6152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /SQxZJBXWyTjXi2t5Ix9NYveqhs3Z45htdewxbE7qFoOpwwSfAsfJ9q5vyaU2kgN6e3MF/+9U9s+UdvOhCu8dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5597

Hi Dan,

On 10/21/24 20:43, Dan Williams wrote:
> Terry Bowman wrote:
> [..]
>> Testing:
>>
>> Below are test results for this patchset. This is using Qemu with a root
>> port (0c:00.0), upstream switch port (0d:00.0),and downstream switch port
>> (0e:00.0).
>>
>> This was tested using aer-inject updated to support CE and UCE internal
>> error injection. CXL RAS was set using a test patch (not upstreamed).
> 
> Thanks for these test outputs!
> 
>>
>>     Root port UCE:
>>     root@tbowman-cxl:~/aer-inject# ./root-uce-inject.sh
>>     [   27.318920] pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0c:00.0
>>     [   27.320164] pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0c:00.0
>>     [   27.321518] pcieport 0000:0c:00.0: PCIe Bus Error: severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
>>     [   27.322483] pcieport 0000:0c:00.0:   device [8086:7075] error status/mask=00400000/02000000
>>     [   27.323243] pcieport 0000:0c:00.0:    [22] UncorrIntErr
>>     [   27.325584] aer_event: 0000:0c:00.0 PCIe Bus Error: severity=Fatal, Uncorrectable Internal Error, TLP Header=Not available
> 
> It strikes that by this point the code knows that it is a "CXL Bus"
> error and no longer a "PCIe Bus" error. Given the divergent  responses
> to Fatal errors based on bus I think it would help to clarify that the
> kernel is panicking due to "CXL Bus", not "PCIe Bus" errors.
> 
>>     [   27.325584]
>>     [   27.327171] cxl_port_aer_uncorrectable_error: device=0000:0c:00.0 host=pci0000:0c status: 'Memory Address Parity Error'
> 
> ...i.e. someone may not notice that this is "cxl" reference in the
> backtrace.

Good idea. I'll add logic to print 'CXL' bus in the case of a CXL erroring device.

Regards,
Terry

