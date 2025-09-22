Return-Path: <linux-pci+bounces-36660-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD51BB911B5
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 14:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 707643BC384
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 12:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E74306B06;
	Mon, 22 Sep 2025 12:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mSdNmYT9"
X-Original-To: linux-pci@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011003.outbound.protection.outlook.com [52.101.62.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B1F288CA6
	for <linux-pci@vger.kernel.org>; Mon, 22 Sep 2025 12:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758544010; cv=fail; b=WFn8uUQPJ/RDlw951iROUEAaPDHPuzb8MHIMEsgPmd+xKgs4zfxykqTxPOOarKQDHnXmy0FzHvrMxBV/8REdkm8Iv7YBN6wYM8WCyoIKg/Gc6pbCIBfTwV6h2A2lxKjH0nZ1+jR+gMhavg10Ba80/Tv5kHQ7ezF8wNppAvCWVkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758544010; c=relaxed/simple;
	bh=CHi0D5eLauqPXcnr0Gk8F9lTgYtFM6zStaTPs9/c//8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KGRBJNVADqigl4OATxVzGxnhhjuD30KnKUCDCXtUtCaXVDms8VwbywTuF7+6KzFBTAxPIMMaJAqAL40mVgih3V6yA4RP0Rn18Co/qutbYDABIi94J4Me+3c0iW9iI1BTObvI2VWCj3Ab2XqKT442IrzK9KngiB5zJln9L1SAHSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mSdNmYT9; arc=fail smtp.client-ip=52.101.62.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y8uK9u1OGwBX/ka9E5arqLxnquRfkggLHVbFAm09eZIpyPmLzGVhO3dOi2UjGRxZ0AJwE4+tdpJXHDO9D+I5yjh5E5VPgU7c01oMvr4mV+sWIc0ipvKBiTuI/TgvzZqlVT17d3nAl/Eo7y3vtZ4yGFM4FhN1dv0oC/JhoElgiqan/Oq/DQTnEMmMmKvx4p4Kt9KQyHRQ82qd6KMvFPhSFo2ao0f9+EttYlV1IhjQyg26EdMHIZJ6AqHuT7mb0d/OjrLOfSsJtUfhGcjUilUoH7tLH/Ap/jlQSHcLD3Objg/wwHoZEHMediX/xe9qgFyRiyb/5glr2XVKCwtICoanwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zb5VST89gNS6OKystk9xqb231YuDtcn6/Bb4qFU7Wp8=;
 b=RUnu80x+SBKtQVfYSMs8/p8Wize8lSwcH7KWToETSkIoMt6O7Y8yGn9uHkZh2SaEvQ6eyc3ODXISzCqlirsNMjHd8Cl3G6eYpeJ7gN9Y8lD2CX0OWMEoukxa2JfKIjZOydwrFIm+ppew3DTloNdogzFPIMTSpqpL5L1mD7sy6kJO7CnKw8VfflkbWMr0yMWylROjNHxUL5DW6QlCMWZjoV435WvfRHV4KXthBxvW6+1BJS04eFaD3oibfX5oDazCSnQ865v1v+Z506J815UmiNGGTacS9CLUiS89Eal6svW/mBMBVUG8zmk1qu6qtrxq7yUXW7Iz52pPDB239flzSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zb5VST89gNS6OKystk9xqb231YuDtcn6/Bb4qFU7Wp8=;
 b=mSdNmYT9b11VDMm1O+5iKE1Q7VF0HYgmjK7NFqwlwR10O7P5gX8mXBM9LuVR1ZccVj1m3zROjC2jvBgxWRGNgNry8LBVKln5yTIsWgJUu88mzW2LOtp+O5sCeLZRdbtc3/u9bpEZIVdlVOI1yS95f6GQ6q7wbQFAafmgl3+peR4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by LV3PR12MB9354.namprd12.prod.outlook.com (2603:10b6:408:211::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 12:26:44 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%3]) with mapi id 15.20.9137.018; Mon, 22 Sep 2025
 12:26:44 +0000
Message-ID: <b99b2951-9f09-4f9d-a132-f05ab1f8928f@amd.com>
Date: Mon, 22 Sep 2025 22:26:37 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH resend v6 04/10] PCI/TSM: Authenticate devices via
 platform TSM
To: dan.j.williams@intel.com, linux-pci@vger.kernel.org,
 linux-coco@lists.linux.dev
Cc: gregkh@linuxfoundation.org, bhelgaas@google.com, lukas@wunner.de,
 Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun <yilun.xu@linux.intel.com>
References: <20250911235647.3248419-1-dan.j.williams@intel.com>
 <20250911235647.3248419-5-dan.j.williams@intel.com>
 <22cbe028-c1ad-456f-a046-12b4559394b4@amd.com>
 <68cdb9f271b46_2dc01001e@dwillia2-mobl4.notmuch>
From: Alexey Kardashevskiy <aik@amd.com>
Content-Language: en-US
In-Reply-To: <68cdb9f271b46_2dc01001e@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0016.apcprd04.prod.outlook.com
 (2603:1096:4:197::7) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|LV3PR12MB9354:EE_
X-MS-Office365-Filtering-Correlation-Id: e415c0f1-51c6-4620-33a8-08ddf9d34a78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cjRvdkNISWpLamVPbytWdXBXdVNGU2taMGJzOFFGdFI1WnRCVVE3aWV1dmFV?=
 =?utf-8?B?eGRwWEVHc3QrUXNWakJpRlpxTldFOGxZUnFMRWQ5cUJtekVRYzNMVWJrTFMr?=
 =?utf-8?B?eDh6NTY5bmpNNFRjRFk4WlFINDdMWmtnTm0wRFJCUUM0aDZRL3dyOVNYUFMy?=
 =?utf-8?B?dm4ySU8wK0kxYXlrQmNrYlNNZDJZd05DT2NUeU90RW5CVTRweXRrZnJoeXBT?=
 =?utf-8?B?SWVROFNETk0xRlJhUGtRTTk5VWNIYkxKZmZVbjhuNmQwM3dQT1hPQ2xvOXUw?=
 =?utf-8?B?ZmMvRVhnOXNYOWZTcHRUbi9zMTV2RE5DZzFnMlNGWDFsMWpwRUE5QlR3MllB?=
 =?utf-8?B?ZHEyQ0Jlc25CSlBHL3BYaW55Q2JDSG9hekdFQnFvdU9nZ0RtczM5OUI5YVJ2?=
 =?utf-8?B?NjVueUY4N1VJV2RmeENpWFRvQ3hKV0NsU3ZqaDFBT2dqa3lLQlJqRlJEWWhD?=
 =?utf-8?B?SWw3SUlvNlYxYjQzRHJZcDBzSW5ZV0ZYbzBaUjlaYkl3SkQ5TmdRdGZVeUNz?=
 =?utf-8?B?bzF3K3BLVXpHdTB5L215b0YwMG1NZUNJclJzY3EvdEFTUkdWQys4anY5RXNK?=
 =?utf-8?B?bGlwaWx2UXlMRG40Ukx5REFjaUUwVkxwb3N6c1l5TkhBU2tSNHRmYzkxRzNU?=
 =?utf-8?B?VWlXbjZIeFlWLzkrcTNKeXBYZkNpdWNHOTRXQjBLNHRObUhhc3lBZ2hFek8z?=
 =?utf-8?B?bExjaERjd25GUWoxZnRMMCtkOGZFVHBTQ2ZNcUtpUGtud0REcEs2UGdMNS9q?=
 =?utf-8?B?TnhkVEkwK3VnV01ieHdlWVZyYitvVFZDVTNVNHNTdko2QlRadUR3QnJ6RWtn?=
 =?utf-8?B?aXhlcTNOdXh3VTVGb0kxaVVVMU5BMHVNWXd3VmFPOWpSRHhsdW1uSXpNNjI0?=
 =?utf-8?B?Zkh6Qnc0aXJJVmxwSm9GaEhWVUZ6YmRYRCtGckhadmJrZnZiVkxjOWlXOFpk?=
 =?utf-8?B?Q3R5ZnhTZVdmUTBacTdrNzR4WGhhWFRrays5N09EZ0hCZ05sUThpckxqS0Ny?=
 =?utf-8?B?VjhpSW1Bdk12TXBEc1ZmYzhJYzJ5U042aWRZNTJRb1BXTU9STHBOQ3owcVhy?=
 =?utf-8?B?WTZJTW1jbXk2Y1cxMnZZVFRrMVlDT2hLL1lzS0xVVWNtVUVMdkk5RGkvZFhM?=
 =?utf-8?B?QnZtVm9WSWo4SzgvTTM0RVZUN0d6Rjc5VFU1SklkaW04NXY1MWEvWjJ6Qlg2?=
 =?utf-8?B?SmducmdwM3JyeG01VjFjMnBtd0h1V0ROdXR5NWZ1KzhNbnJtazM2N09NaVVL?=
 =?utf-8?B?cm9DUWQxY2ZodVNIb0Z0VTZSeldDd3VacTY5bWV2TFVSV3cyc2FxNVM4UC9n?=
 =?utf-8?B?T1cxVFJIT3pJWFM3VXNCQytTelpISVFYd3JMRzkya3AzcTdjQk1ibkZoRGpw?=
 =?utf-8?B?S3R0bmZEZjlrM3JiOXlnc0JiazlubXAxcFFLaHY2cG9VREw5SGxoWmNHbkpX?=
 =?utf-8?B?T1lIaE9rc0tqWDY0dTI5dDRJRnpCamVWem5KS1UycGs2bXI0VWtESm9ydTE3?=
 =?utf-8?B?cjJobTM0U0trRFJWczdhc0k0NGUwVDBNclRNUDJveFVVWlMybDhxYm1qVFBL?=
 =?utf-8?B?Z1RzRUUwTkFQeVJ0STJxZ01jSGVUT3cwaTcrWnZrRXlRZkpieC9lTmdmNVhK?=
 =?utf-8?B?amZWQWRQZUdMNEMrUXY3YmhNb2JsUjA2c3RZNXptVnVkN0hNTWp4Y3JTWjdm?=
 =?utf-8?B?cXI5OEpMVVUzb0p2aVU0S09jWTlqdC9ZRE1WbmVrcGpBcmNHc2xTVUdCMW9X?=
 =?utf-8?B?YnluR29jNUovcjd6MW5hZzBYNlpIUVR5SzlwRDFBbUZha2F3NnBzU0lGYndM?=
 =?utf-8?B?WHYvUTU3Vm0wMHkvZDJlNGREWS9QOVJyY3RxdE9RakNncUJnanYxNCt4NDdh?=
 =?utf-8?B?NTJhdWdKVjVtWHFCSGVSb2k1N09aanFOSlJDbndRWmRBY2ppUjdNS21iZGdV?=
 =?utf-8?Q?02+S8vYIuig=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZTYyNGkwaXJMbkZCUGRkbG0vR0VIUFZJQ0ZueldFYUphKy9jTmZlK0tTY2FE?=
 =?utf-8?B?NDJWOG5XQlhjd2Y3bWptOUJpMUdaZGVJYzQxR3kvUTV5TElJUHg0Mmp6Wk9Q?=
 =?utf-8?B?ZHlFOHBNRS8rSkI4RFVOcGVQeVZOMGV5czhUbHFDYmRhVUlNOHRFNnBaR1hU?=
 =?utf-8?B?dHBQNTRTVnZUbUR0K3V5QkRpTHpvT0tORXR1cUhkbmtXVjNBQVV5ZWM2cVo4?=
 =?utf-8?B?RkJOc2tMcm43bGZ4MVEzY0w0bTlBYTVWNDI0b1pWcGhIT0hoUDI1TlpocThi?=
 =?utf-8?B?YlF1TEIxMVZjUkJzcFhyelZVcDZCN0VsSkU1Ym1iUE1DLzVVSmhCN1hweVF5?=
 =?utf-8?B?UVRFY0I1OWswZ2FRbnBzSEtzTWcvMkVmbHpvdjk4M2RGOWxHdmtBY1Y4SXA5?=
 =?utf-8?B?OVQ1dTNEcjhoMTErMDJxS2RRb2FzYWJjKzFRaG44ZnVxM3VxeXFGcjZsMWVw?=
 =?utf-8?B?b0Nkanp0VVdwaUROQy9ES0Y3aWZIUldzRE4xZGpBcW1sdjRQRDFiaWh6M2NM?=
 =?utf-8?B?TnJzZWFzdnV2RmVrNWFqYWdwWkMrZURwdkJqL1RGL2k3d0RwcGdFMFppaG56?=
 =?utf-8?B?L3paa3hKbzZOeDh1dGFydXBKY1loUGx1MXdPdTd6RDRKbHRJK3dRSkpaL015?=
 =?utf-8?B?TEFweWF1L24weWlNM1BCRjNtdnNwbWRua1ZqRlVRU3k3VU9ndTJSOHRoMkRJ?=
 =?utf-8?B?ajRkcTdUVkFra2hoK1BuSitDaTZYZ3BadVgxcGhvcnl1SmFZRll2bjlNM1My?=
 =?utf-8?B?Q0pTc2oxZ0RkUTgxSVFqek5ML1R2eTZOYUsrOWZYa0pteGFielZ5ZERSZGRZ?=
 =?utf-8?B?WndWU3F3aEdiVTQybXg4MURtSVlsWTZYaEFwNFU2bmNBazUzcWI1aCtsaEx0?=
 =?utf-8?B?aEpTenlIOFVxL29iNVo2RU5Pd2dlQTBiTERBcFI0Um5hdUNvRHVLc0dnUGpX?=
 =?utf-8?B?L29sMzNXcEkzQUxYaGVDbWZWaFVsQm1ySjF5OW9ObnNFSy9CYW14OEVMQkds?=
 =?utf-8?B?eUwyNTVLSkFtZ29lS2pUZUVhNVFXQXNzZCtqQUpDOStweWhET0V0MHByWG5T?=
 =?utf-8?B?TjVPdmk5VWw3Y21POEJNTjBwTzdNb0lTaE90eHhyWkNXYnRGS3JyKzZCVHJJ?=
 =?utf-8?B?QmdRWlp1OVZSb3owcDVPTXFPNkdsV0hQbnZHWkcyTW1tM245UW5ZTkRaMTZH?=
 =?utf-8?B?KzdYL1FiR01vQ3l3SS9oNEU4TlV0NmdveEpINmhPaENPdVpURTdWTzJhU01u?=
 =?utf-8?B?Wno3dGdUcWRjUDRtWHVPTkdaYjhRZGVnZzJQZ3JFZzB6Qkp4V1ZmRUtwQVRa?=
 =?utf-8?B?U2huMkZ6MTNPQ0NjVWgwZUFNSm5EejlhOTRqb0Q1dGo3dmlBa3VTeFpyQXdI?=
 =?utf-8?B?Z093UEJUU01BZWVSL1Z4R3E0WFlQaCtYRFltbzFOS2VDOUFtNy8rQnFqaG9G?=
 =?utf-8?B?VzhXcHorcmhlQ2JLN0d6YTgyTHlpWElOTzdWcVFBZVEwSFdPSmxtR2p4Z01X?=
 =?utf-8?B?NGptSjFPWmM4UUNNMnZiYmhpSUZ4TEFWNXFkSGhIY09kWjBzWDZBazVYL0Vw?=
 =?utf-8?B?ZkVXLzBESTNXQTY0c0picURjK2JsSm5pZnpTblRkU2J5WWhBenRlQisxa3A4?=
 =?utf-8?B?MkFhM0grWU5EeTZtRk1VVWtFeGpwR3R3VVl2T3M4Q2NsdStBRFV4U1VYRHVv?=
 =?utf-8?B?UkpHbnNnSVdRZ2RHcC93cmE0dm9NaTY0clQrT2FlTTVucjlHWkNYT0hwS2tJ?=
 =?utf-8?B?eTJhOExVV2tFTGpmVGhSVmhXUlFmT05MM0RsWjlTaTRHb1VpUE5KU3F0OWJa?=
 =?utf-8?B?QkVsNkhCc3RpRGdHL2JrUmtsdklWamdRRyt1aUJmNHlQS0tSUGFGekJoSU9K?=
 =?utf-8?B?ZXcvK0M0ZFRhcEg2NWhHNU9XeU5aWWVobG43UnlwbzJweGdmRCtGOTdxb3Fm?=
 =?utf-8?B?Q0hHTEJuU3dZeUZsMld4YnZ2eWc2VWIxMWZ1TkM3bnBTNFE0UTJ3YTNYWkpU?=
 =?utf-8?B?UWNnSmpWU0kvbXN4aUNKb1RSbUE1R0NMUkRuemd3WEdxVEdyOVlMeDZTYWZX?=
 =?utf-8?B?dERSMzJ5SUkycUJyN1lGSSsvV043TFNiMlRaVEFGZWhHdXZ2VDZNaFhHV3k2?=
 =?utf-8?Q?ip2Ls1ynQAozllLsNhuAsYZct?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e415c0f1-51c6-4620-33a8-08ddf9d34a78
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 12:26:44.1268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UMqreRNe1pdRB+gRw2qX0deSia4GAiUvSfgNEOXm91MvJfkojFV5FyNw99KeQxSO9iZUCRFhN4pVIMPgT3K2iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9354



On 20/9/25 06:15, dan.j.williams@intel.com wrote:
> Alexey Kardashevskiy wrote:
>>
>>
>> On 12/9/25 09:56, Dan Williams wrote:
>>> The PCIe 7.0 specification, section 11, defines the Trusted Execution
>>> Environment (TEE) Device Interface Security Protocol (TDISP).  This
>>> protocol definition builds upon Component Measurement and Authentication
>>> (CMA), and link Integrity and Data Encryption (IDE). It adds support for
>>> assigning devices (PCI physical or virtual function) to a confidential VM
>>> such that the assigned device is enabled to access guest private memory
>>> protected by technologies like Intel TDX, AMD SEV-SNP, RISCV COVE, or ARM
>>> CCA.
>>>
>>> The "TSM" (TEE Security Manager) is a concept in the TDISP specification
>>> of an agent that mediates between a "DSM" (Device Security Manager) and
>>> system software in both a VMM and a confidential VM. A VMM uses TSM ABIs
>>> to setup link security and assign devices. A confidential VM uses TSM
>>> ABIs to transition an assigned device into the TDISP "RUN" state and
>>> validate its configuration. From a Linux perspective the TSM abstracts
>>> many of the details of TDISP, IDE, and CMA. Some of those details leak
>>> through at times, but for the most part TDISP is an internal
>>> implementation detail of the TSM.
>>>
>>> CONFIG_PCI_TSM adds an "authenticated" attribute and "tsm/" subdirectory
>>> to pci-sysfs. Consider that the TSM driver may itself be a PCI driver.
>>> Userspace can watch for the arrival of a "TSM" device,
>>> /sys/class/tsm/tsm0/uevent KOBJ_CHANGE, to know when the PCI core has
>>> initialized TSM services.
>>>
>>> The operations that can be executed against a PCI device are split into
>>> two mutually exclusive operation sets, "Link" and "Security" (struct
>>> pci_tsm_{link,security}_ops). The "Link" operations manage physical link
>>> security properties and communication with the device's Device Security
>>> Manager firmware. These are the host side operations in TDISP. The
>>> "Security" operations coordinate the security state of the assigned
>>> virtual device (TDI). These are the guest side operations in TDISP. Only
>>> link management operations are defined at this stage and placeholders
>>> provided for the security operations.
>>>
>>> The locking allows for multiple devices to be executing commands
>>> simultaneously, one outstanding command per-device and an rwsem
>>> synchronizes the implementation relative to TSM
>>> registration/unregistration events.
>>>
>>> Thanks to Wu Hao for his work on an early draft of this support.
>>>
>>> Cc: Lukas Wunner <lukas@wunner.de>
>>> Cc: Samuel Ortiz <sameo@rivosinc.com>
>>> Cc: Alexey Kardashevskiy <aik@amd.com>
>>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>>> Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
>>> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
>>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>>> ---
>>>    Documentation/ABI/testing/sysfs-bus-pci |  51 ++
>>>    Documentation/driver-api/pci/index.rst  |   1 +
>>>    Documentation/driver-api/pci/tsm.rst    |  12 +
L>>>    MAINTAINERS                             |   4 +-
>>>    drivers/pci/Kconfig                     |  15 +
>>>    drivers/pci/Makefile                    |   1 +
>>>    drivers/pci/doe.c                       |   2 -
>>>    drivers/pci/pci-sysfs.c                 |   4 +
>>>    drivers/pci/pci.h                       |  10 +
>>>    drivers/pci/probe.c                     |   3 +
>>>    drivers/pci/remove.c                    |   6 +
>>>    drivers/pci/tsm.c                       | 627 ++++++++++++++++++++++++
>>>    drivers/virt/coco/tsm-core.c            |  40 +-
>>>    include/linux/pci-doe.h                 |   4 +
>>>    include/linux/pci-tsm.h                 | 159 ++++++
>>>    include/linux/pci.h                     |   3 +
>>>    include/linux/tsm.h                     |  11 +-
>>>    include/uapi/linux/pci_regs.h           |   1 +
>>
>>
>> A suggestion: "git format-patch -O ~/orderfile ..." produces
>> nicer-to-review order of files especially where there are new
>> interfaces being added.
> 
> Not the first time I have heard this recommendation, finally
> implementing in my flow.
> 
>> ===
>> *.txt
>> configure
>> Kconfig*
>> *Makefile*
>> *.json
>> *.h
>> *.c
>> ===
> 
> Went with this ordering instead:
> 
> Kconfig
> */Kconfig
> */Kconfig.*
> Makefile
> */Makefile
> */Makefile.*
> scripts/*
> Documentation/*
> *.h
> *.S
> *.c
> tools/testing/*
> 
> ...stolen from Kees:
> 
> https://github.com/kees/kernel-tools/commit/909db155

oh this is better, I was so sure I don't need paths. TIL.

  
> [ .. scrolls past pages of uncommented context .. ]
> 
>> It is still a rather global thing. May I suggest this?
> 
> I am not too keen on this.
> 
> Yes, it is global, but less often used compared to @ops, and I do not
> want both @ops and @tsm_dev in @pci_tsm.

Why exactly?

> So the options are lookup @ops
> from @tsm_dev or lookup @tsm_dev from @ops. Given @ops is used more
> often that is how I came up with the current arrangement.

I am looking at:
https://github.com/AMDESE/linux-kvm/commit/9e3caf921ad6ddd6bd860ec307b986649322a618
and not really sure "more often" applies here.

And do we have to check now if tsm_dev passed in probe() is the same as the owner? I struggle to find any other _ops doing the same owner caching easily. Or merge struct pci_tsm_ops into struct tsm_dev to stop pretending that pci_tsm_ops is an interface, and then we won't even need that @owner. Dunno. Aneesh? :)

Thanks,


-- 
Alexey


