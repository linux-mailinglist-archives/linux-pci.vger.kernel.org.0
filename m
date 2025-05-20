Return-Path: <linux-pci+bounces-28106-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE43ABD938
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 15:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A0D91665E0
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 13:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C655242913;
	Tue, 20 May 2025 13:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SrUi+LWH"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A35A2417E0;
	Tue, 20 May 2025 13:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747747287; cv=fail; b=lytdwlcCCAN1HDoLL0o6RgQ6z9tfkIkGXvBI0gvtqgXvlxAKjM6v0mvgNJt81y0FF6WqPwkM/bUfk74mGTt2kNt32t8e5/iA2+uZuPmPq1yCV9lp6DlNNcFL4V0bfFVp1oeDFJ/4m6ika0RUKTSEumbpA+orCuUV+BNNe2ud7Zg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747747287; c=relaxed/simple;
	bh=P68thtv+av1r/2uZmRZk/T95x0zYKp4kmPzOsYTNbiM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bfpSRWgjJ61sZbaNUwgUgFPb1d61CHW4ozT7Z+GK++L4oLH44aZUDJqxF2u4y5zF34STlxSqCvQGhhTBH6NWXBhtBbjK5ZJV3NGBmHgIkLTANi2yegkj6QReALsC+b+HWxGJDThds5Sd4ZTF0QW8OzOP0pnp4lXnAqTXje8Vh7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SrUi+LWH; arc=fail smtp.client-ip=40.107.244.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GO3MzwnOoCmQRhxH1oboo08onwy1BEkyTqNK0lIRBam3OzzPBAXSAgycPx5IyK/KF7aj88D2tKXEUnEUTTiYuIezD4x+sUqsI4CWpuioD1i32LUzQ1dtwN8AyTw1Jsf3+V9VdeYC4EYW7zVKkKVy2KXi+/OK14J4CNCiaUGE4IAwV0DJNXd+NRXaG5MojtIE33sxy5C18kV+mj+AYqmBrZUGbKgBHj5KOzRwnyKm/ouDsUqReB6whRkg3yzssu4uS2QewKs2lo+vBxUTthlLucA51StLBlVx1PnG9Qf/bqRSKMmEGCZa66Zl8qzL/VRXW36rRBSW1i/IrfwDwJ3B5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJurNi5CTQl568r0oMFoW6JFdDL7hZueMHgLEzp2Wo0=;
 b=zIKkiw4ICefdEvW11ZuQGX8hFnSfe+lqwJa/vrLKU8V8FdD8pHsNkoWsYq0mV74E1R6C2MHpAg+E3aeJKxjqnRjGgkYOfjFAsTrITEqqQmwRbGijKEGLlAT3goqYj/DO5NwiwCg679EoofUDgtIR+VgDZSmwTte8SwwTc6vuZlJxxbeHM+Z6gsAn8/xDQjTeQPzKaC+4UXh/YDYanolScfTy7p/1RLNkz0jsjawkvZ56E9nKO3mUpnUdPNniQfMZyyyDTiaqm4+XOc50drvlF9/1mFc885ksdixt/SuED9K6BE7PCXMu+0VUDzEGqkt7nWtnv8X9kJAZzXQhsoFKuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJurNi5CTQl568r0oMFoW6JFdDL7hZueMHgLEzp2Wo0=;
 b=SrUi+LWH3vhgQlVMqrqYYL7FbMcBWnrvmwKb9/Osxd5MzeBUq1sr2g3UWJNIMIg/wljfpJLH5m27NHE2CGPyf9dgBwgEhuQ8aIiQI0+PhIyya7glfEtxbBhjZY0mWzHFLkDFjVT1W5lDOruNHyip8oDuwrXNZsX1pNEOHOYocEo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 DS5PPF884E1ABEC.namprd12.prod.outlook.com (2603:10b6:f:fc00::658) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Tue, 20 May
 2025 13:21:22 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%7]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 13:21:21 +0000
Message-ID: <46c962de-a691-4e67-9af6-5765225633ae@amd.com>
Date: Tue, 20 May 2025 08:21:18 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/16] cxl/aer: AER service driver forwards CXL error
 to CXL driver
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, nifan.cxl@gmail.com, dave@stgolabs.net,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
 ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com,
 terry.bowman@amd.com
References: <20250327014717.2988633-1-terry.bowman@amd.com>
 <20250327014717.2988633-5-terry.bowman@amd.com>
 <20250423160443.00006ee0@huawei.com>
 <e473fbc9-8b46-4e76-8653-98b84f6b93a6@amd.com>
 <20250425141849.00003c92@huawei.com>
 <8042c08a-42f0-49d5-b619-26bfc8e6f853@amd.com>
 <20250520120446.000022b2@huawei.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20250520120446.000022b2@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR06CA0029.namprd06.prod.outlook.com
 (2603:10b6:8:54::29) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|DS5PPF884E1ABEC:EE_
X-MS-Office365-Filtering-Correlation-Id: 4312842c-83b8-4bd3-78ad-08dd97a13646
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZzF5cDhleVRmSDBDR1Jpc3EwRks0UWRoNG0zNVM1Q1BZUHYwN0N1M0Zvb1Uv?=
 =?utf-8?B?Tys0b2tJQzAvVEhud2FpdDQxemV2b2E2ZlE5UzJDYTN4TU1qSmRwdzhTY3FY?=
 =?utf-8?B?RzRWQTI5QkpXWWlrQk0wQmlsTWhJak5IbDdyb0ZtalZvb3Rwc2UyalhraGtB?=
 =?utf-8?B?Z2NaVHpDd0Y3U0M1QVFvdTZ5ZkpGL1hza1JhaDZFYXNoK0RZV0FtbWdWc2Fv?=
 =?utf-8?B?TkpENks1NHpIckZKOC9uTnhPOURiSjBuNDF4TzE2WitEQnRHS0xqamZyQlRC?=
 =?utf-8?B?dVFHaWdOU1BDeHk4VWM5WEY3bEg3Y3BmcGlsVjVlZkNwM3daeTJvSFdKenY1?=
 =?utf-8?B?c2RlaXdXOWE2a01OUVhxVVB3K3d1bkhKSEJxMjk1bGFXemVsZ2RyNTJTYUFC?=
 =?utf-8?B?TXBrUW91RnNoMzlSZWtqMkthU01VNFRjOHNoUitvekxlNi9rMnFCRWQ3bEhE?=
 =?utf-8?B?QjVxU1g1Um9uenVUUjFDSkt1UGNZbXI5dnNRRldiQk1vOGJTUFlHeTV4eFZM?=
 =?utf-8?B?Ujh6ZnpqeUQ4dWkrNjloTjkxbmVRUkVmd0dIb202TStNQzZOYjlrTGZ1UnFX?=
 =?utf-8?B?NVMrS1hlQWRZa1NxNmVjUXJvSnAzVyttT21MenZvK0YvdjlJM0NuVE1kRENM?=
 =?utf-8?B?OTFiSDBJVURkN0dPTjZycDBHakVVWjk3eTh6OWpuSjhYa3Y3WTB5YU15c2Jr?=
 =?utf-8?B?anlYUWNyanNhZDcrcllCY1lhSkdCMVM2eFFjUnJma2grYWVhMFpjeXBNeGRs?=
 =?utf-8?B?Ti8vVmRQRVRpNXlBMmMrVmF2OVBEOW43amdPaHViNVd2MmY4eVhBVnR5NHBC?=
 =?utf-8?B?elB2aDVBS0swbDFYa0xCZ1A3eWpEZmNPTjZmUEoyUWNIRjB0WlFkelh0TWE2?=
 =?utf-8?B?N3B0c3JCNDBydVlmSURNZE91U1ZvMTFDL2N6SmpMR2JxMEZqRGtiTVZTTExR?=
 =?utf-8?B?QVExbHVxU1FyODlvVk5GaHd4UVNkcjNIV3BteG82SkpJZXVqMHJzenI4Vit1?=
 =?utf-8?B?K2JXRXZwS2dWaHNZTGVERlA3RlYvR1kvS29Jd2NBc1FMSEZhVGx6SmYrdjEw?=
 =?utf-8?B?aXJmak4wdGtHeTFTK0ZIYk1XeWtsUWYrWUFsUGFBelJtMzBaMEc4WjV5WjhC?=
 =?utf-8?B?dHBnaXR4c3NxN1VqeXF6eldLSGVWc2VhQjdCUVJqclhkaUtUQ29ydG1UZWFp?=
 =?utf-8?B?TW9acDRDcW54WWMzNWYvQzk0blgzMWFWODJuVEJyMktucEJ5OVdNc1MwZC9o?=
 =?utf-8?B?WDhIYTBENHRmNzNMNW1mVE9zNFBsYk9nRi9uS3ZCaXErM29OYUNnY2VPYjBy?=
 =?utf-8?B?T0ZxVFBVK1kvcW44a1JwRVV4V1AweFlCR3kvWDBuT2g3U1ZxR2RIeUtYVE9r?=
 =?utf-8?B?OFBweWo1c0V4QWhwcndoUGxrdzFYeXhhREV3U3ZJMTdxelpOTjdLc3pZeGNT?=
 =?utf-8?B?ZHFNVGJoeUg4REFGcHpqMnR1Z05ad09walJWTldvUVNmR08yNWFjNDVmcnZY?=
 =?utf-8?B?M3FsL0daY3AvVjYweVRCTGh3MDRxbGcxM1prZTh4QmlZaE9mL0JJL3J0eGJj?=
 =?utf-8?B?QTJLY09IT3pucnB6SGw0S05sMlJQWjM5OStVU2tVRTI4NDc3V2xOOGxKWWRZ?=
 =?utf-8?B?VWRUVnVXbnE1WFNXVUJTQUZYaVFVc1dZWGVhNVRBUFZheUc2OUR5VVg1c0dD?=
 =?utf-8?B?TjZoVHRPQ3lYK0pEbDUyNEFrZVBJNi83VUJsMTkzUU9RUHpXcm1xbm5CaGdM?=
 =?utf-8?B?RzA4cVE0T2NaQXVZbmM5VnhNd0I0Q05mUWZoYll6OHRJZ2ZnWnIyazZBUnJh?=
 =?utf-8?B?cHkyQ0Z1VjQrRkdSR3Ixd2ZDblBJNFkrV1hUdHRDTGxPVnA4Wmk2eGpqdkZ2?=
 =?utf-8?B?M3VkR1pLdGtkNklJWHhJeHRySmVoYnMwOWpNVy9xL09Wajg5SklNcEh3NHZt?=
 =?utf-8?Q?5fUCe2Zoxc8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUdkUk5EY3ZPMXd1Rk4wc2dUUWpVaXNaYmx2VHhOTDNVZlE3YlBNY2FVWkt2?=
 =?utf-8?B?cGY3a2ZpNncwV1ZqMTBXV090b0JUMnZ1TGZTaWNjRS9hbmtDUzRHa0R5UWRQ?=
 =?utf-8?B?S0Z0eDdFd1NuQnErWWs1eElFbGJpV2dDeG5TOGRMK1ZtVFliYnc3cGk2T0g5?=
 =?utf-8?B?Wjl2RlYzVlh3RVpZRUhJUWU2OXhqYWt6TEM1Tlc2VmVHWkNoMzZDckdRTmlF?=
 =?utf-8?B?VmVTVVVhNG82M0FadnpqWnR5YnAwbklaaXhkWU9IcXl1K0xlSVp2SC9OUXUy?=
 =?utf-8?B?b2JGc3BKRFFDVlJJMmFhd0Uxckwzelcyd3FvdUNEWm54akh3dHJSTnU0SmZ4?=
 =?utf-8?B?ZFRFVmZ1cmR3eGMrVEF0azREQ28wa3d1NU02VmVoNGxENStxWG8yRmdNUVhZ?=
 =?utf-8?B?OElHV1BCb0t1eHJiZVVGM1MxenlOcU0zOEFaczBhNGd4d1ZscVM0eGR0d3ls?=
 =?utf-8?B?b3lsOFc3TnV5cTB6eHRUSFJXQm1yREJhRmxRdmZnb3RibDMwZnJYUEF1YkNC?=
 =?utf-8?B?L1NScGxhSEwzUzNqSEdNYWJUMXFTM21uVnpQQkVoK1ZrQjVDcGtYbkxIS3dW?=
 =?utf-8?B?R3Y4dm5HQUtxa0FOcUZIYW1mUitnVWpERkdGZFhpY0RiclltbnRVUHZrYjVq?=
 =?utf-8?B?SDZJRlBUZzdlSmVFRWJDZVZXR1hycHlSTTRZTHZMOXFlMjJwd3lIcGlBUTV5?=
 =?utf-8?B?eS9YTHdRdXN2eUpuZGVCVmhkb3dDT0E2RzU3MlZDYmRpNEVUeW5EUWFORUl0?=
 =?utf-8?B?UUhmaGpaNG5RalpwTStLTy9salpVd1J0ODlDTnhLSHlTZjl2Mm5ma29UV1c5?=
 =?utf-8?B?K3BoUzdWZUNEcnRXZHZES3Z6ZVVVKzJjOVR2MEdkeGJKcUw1R1ZHZVBVbkZL?=
 =?utf-8?B?M2cxK1A0QnpycVA5OTBSVElHY1F3eCt2WThxRkFLdG9VSlNBL0svekNOMGVn?=
 =?utf-8?B?ekE0UlhHd0RveSs3YjB3WUJGdlh6UXJDZ2srOWxxZ2N3T244cHM2NTQvNHJQ?=
 =?utf-8?B?dVRMeE9oUE5SckpxRHhydmNkeCthT091aG05Z1Q3aGlVcDlzWUlvOXNJTWEr?=
 =?utf-8?B?WVhPUFEwOUMzUnNWNzNJMlhLYTNaWXBYK0ZOR2VtVTZhMUlpbkRUSW5yT0M5?=
 =?utf-8?B?cnBGNHMyVEhEaU4zSG1DeFpOOUVVSEZud21VYXlkR2piN3JhK0s4RFJzWFl2?=
 =?utf-8?B?NWQ4OEVLc3FoaVVEWmJZSGpBenpMQ0l2L0hOWkZTQmozYkdRTGQyUlNXNStV?=
 =?utf-8?B?VWdvdUdPbGVqNGRETC90VVhBY1laL20vWFpMTjJqbXBKVDc2QXFPeTVGeUlF?=
 =?utf-8?B?WDlCdUFoa2NXZUNYS2krMVRZVktUNFJQRGNtbXNidFdVYWk2eXpjM1Z1bGxW?=
 =?utf-8?B?YjVPM1dFQjdNZ0poN3hzRnZ3ZnpwVk8xQXRnUWpaSUFTZ0NCaGlMWnhKei91?=
 =?utf-8?B?VDEwbjR1YUZJTEdNWnlhV0xPeGlodTVucERhNy9zajJDcEZGTlpoK0Y1VW8r?=
 =?utf-8?B?NHVFZ3o4YTRTRUpqTktxbkZiMStnNDRGZHg0eU5KQmV3UkJ6M3ZRSnF1VS9L?=
 =?utf-8?B?R240L2dkOGQwZ2F4dy83WDJTQnlta0dUWXhPSHFyd1hzazNuQXBaZmdmWlhS?=
 =?utf-8?B?MmRjQnV2K1RhTktlcXM3UWlFZWZ0ZkdIWWI0ZHd3K1hZbzNlQ1lzRUE0aTlu?=
 =?utf-8?B?czJKWGRUZkZ0VUloaTFRbnpUYUxWNWJLZGVFbzNzNHFZNEx1N0ZtNjdrMUlU?=
 =?utf-8?B?V3loSmdKTS93bVNNU2ZDSTlNRm4reWN5bURua2RFSVNrNTBtOGdDMThTQ1JK?=
 =?utf-8?B?cmxCVVBLTWhUZ1BzT0JIaU1BWXh0dU5nSE0xOXNWclA1akgxWUorNCtHNVIy?=
 =?utf-8?B?cm5hOU1nWGZhOXNOYVYxRWJOQ1gxN2lLcjFNdlBYZGhBeDR3NUFWYllJVmJD?=
 =?utf-8?B?QUgzRHZyM2IvVXVCWWt5cVREcGkrc2lTSlUydFZhU0JNdlMyVjVHMHhIVEtM?=
 =?utf-8?B?SWt2WWh6bjdpRndKQlhmOXNXc2laL0hhdGVHQVYvV1BpYmZSZXVBKzA1R1lS?=
 =?utf-8?B?VTBBNmRwdG1sM0l1ekNqT0tQZU8xUDJnUmVQWGpzbUU1M0NEdE1LQmRRVjNj?=
 =?utf-8?Q?GzWgyV2lm0kgFqhmvT4Uve7Gd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4312842c-83b8-4bd3-78ad-08dd97a13646
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 13:21:21.7426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: stJYWdSyZfrqLcno8L1GT797EkrjV0AqbqDrNJxF+TC0pFOFCg19xx7yBw8RKETfufquom4VNn0xmotGLYQwmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF884E1ABEC



On 5/20/2025 6:04 AM, Jonathan Cameron wrote:
> On Thu, 15 May 2025 16:52:15 -0500
> "Bowman, Terry" <terry.bowman@amd.com> wrote:
>
>> On 4/25/2025 8:18 AM, Jonathan Cameron wrote:
>>> On Thu, 24 Apr 2025 09:17:45 -0500
>>> "Bowman, Terry" <terry.bowman@amd.com> wrote:
>>>  
>>>> On 4/23/2025 10:04 AM, Jonathan Cameron wrote:  
>>>>> On Wed, 26 Mar 2025 20:47:05 -0500
>>>>> Terry Bowman <terry.bowman@amd.com> wrote:
>>>>>    
>>>>>> The AER service driver includes a CXL-specific kfifo, intended to forward
>>>>>> CXL errors to the CXL driver. However, the forwarding functionality is
>>>>>> currently unimplemented. Update the AER driver to enable error forwarding
>>>>>> to the CXL driver.
>>>>>>
>>>>>> Modify the AER service driver's handle_error_source(), which is called from
>>>>>> process_aer_err_devices(), to distinguish between PCIe and CXL errors.
>>>>>>
>>>>>> Rename and update is_internal_error() to is_cxl_error(). Ensuring it
>>>>>> checks both the 'struct aer_info::is_cxl' flag and the AER internal error
>>>>>> masks.
>>>>>>
>>>>>> If the error is a standard PCIe error then continue calling pcie_aer_handle_error()
>>>>>> as done in the current AER driver.
>>>>>>
>>>>>> If the error is a CXL-related error then forward it to the CXL driver for
>>>>>> handling using the kfifo mechanism.
>>>>>>
>>>>>> Introduce a new function forward_cxl_error(), which constructs a CXL
>>>>>> protocol error context using cxl_create_prot_err_info(). This context is
>>>>>> then passed to the CXL driver via kfifo using a 'struct work_struct'.
>>>>>>
>>>>>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>    
>>>>> Hi Terry,
>>>>>
>>>>> Finally got back to this.  I'm not following how some of the reference
>>>>> counting in here is working.  It might be fine but there is a lot
>>>>> taking then dropping device references - some of which are taken again later.
>>>>>    
>>>>>> @@ -1082,10 +1094,44 @@ static void cxl_rch_enable_rcec(struct pci_dev *rcec)
>>>>>>  	pci_info(rcec, "CXL: Internal errors unmasked");
>>>>>>  }
>>>>>>  
>>>>>> +static void forward_cxl_error(struct pci_dev *_pdev, struct aer_err_info *info)
>>>>>> +{
>>>>>> +	int severity = info->severity;    
>>>>> So far this variable isn't really justified.  Maybe it makes sense later in the
>>>>> series?    
>>>> This is used below in call to cxl_create_prot_err_info().  
>>> Sure, but why not just do
>>>
>>> if (cxl_create_prot_error_info(pdev, info->severity, &wd.err_info)) {
>>>
>>> There isn't anything modifying info->severity in between so that local
>>> variable is just padding out the code to no real benefit.
>>>
>>>  
>>>>>> +		pci_err(pdev, "Failed to create CXL protocol error information");
>>>>>> +		return;
>>>>>> +	}
>>>>>> +
>>>>>> +	struct device *cxl_dev __free(put_device) = get_device(err_info->dev);    
>>>>> Also this one.  A reference was acquired and dropped in cxl_create_prot_err_info()
>>>>> followed by retaking it here.  How do we know it is still about by this call
>>>>> and once we pull it off the kfifo later?    
>>>> Yes, this is a problem I realized after sending the series.
>>>>
>>>> The device reference incr could be changed for all the devices to the non-cleanup
>>>> variety. Then would add the reference incr in the caller after calling cxl_create_prot_err_info().
>>>> I need to look at the other calls to to cxl_create_prot_err_info() as well.
>>>>
>>>> In addition, I think we should consider adding the CXL RAS status into the struct cxl_prot_err_info.
>>>> This would eliminate the need for further accesses to the CXL device after being dequeued from the
>>>> fifo. Thoughts?  
>>> That sounds like a reasonable solution to me.
>>>
>>> Jonathan  
>> Hi Jonathan,
> Hi Terry,
>
> Sorry for delay - travel etc...
>
>> Is it sufficient to rely on correctly implemented reference counting implementation instead
>> of caching the RAS status I mentioned earlier?
>>
>> I have the next revision coded to 'get' the CXL erring device's reference count in the AER
>> driver before enqueuing in the kfifo and then added a reference count 'put' in the CXL driver
>> after dequeuing and handling/logging. This is an alternative to what I mentioned earlier reading
>> the RAS status and caching it. One more question: is it OK to implement the get and put (of
>> the same object) in different drivers?
> It's definitely unusual.  If there is anything similar to point at I'd be happier than
> this 'innovation' showing up here first. 
>
>> If we need to read and cache the RAS status before the kfifo enqueue there will be some other
>> details to work through.
> This still smells like the cleaner solution to me, but depends on those details..
>
> Jonathan

In this case I believe we will need to move the CE handling (RAS status reading and clearing) before
the kfifo enqueue. I think this is necessary because CXL errors may continue to be received and we
don't want their status's combined when reading or clearing. I can refactor cxl_handle_ras()/
cxl_handle_cor_ras() to return the RAS status value and remove the trace logging (to instead be
called after kfifo dequeue).

This leaves the UCE case. It's worth mentioning the UCE flow is different than the the CE case
because it uses the top-bottom traversal starting at the erring device. Correct me if I'm wrong
this would be handled before the kfifo as well. The handling and logging in the UCE case are
baked together. The UCE flow would therefore need to include the trace logging during handling.

Another flow is the PCI EP errors. The PCIe EP CE and UCE handlers remain and can call the
the refactored cxl_handle_ras()/cxl_handle_cor_ras() and then trace log afterwards. This is no
issue.

This leaves only CE trace logging to be called after the kfifo dequeue. This is what doesn't
feel right and wanted to draw attention to.

All this to say: very little work will be done after the kfifo dequeue. Most of the work in
the kfifo implementation would be before the kfifo enqueuing in the CXL create_prot_error_info()
callback. I am concerned the balance of work done before and after the kfifo enqueue/dequeue
will be very asymmetric with little value provided from the kfifo.

-Terry


