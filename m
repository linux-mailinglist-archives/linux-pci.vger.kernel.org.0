Return-Path: <linux-pci+bounces-12682-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EB996A56C
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 19:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27F3F1F252F9
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 17:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4141E18734B;
	Tue,  3 Sep 2024 17:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="L+5bfxLJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F893168D0;
	Tue,  3 Sep 2024 17:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725384669; cv=fail; b=OLsbj0zAbSvl7XJLtCQMQi44b758T0SvRMk2O3YUR4TaFZK7WwQys9O1is3palloo9DNiuqPt+ZH27ac5uktMzqx7z3nHSUxfByKPSfr6IU0LXB0cLjFzmLXLJ99zqvxs8P3/VwQEMIzUXX86uAUvftboHyP7GJdy4rs4vqNz8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725384669; c=relaxed/simple;
	bh=624gFzYGzVSk8Ra5KlkChQBo6QGajh9dFFv3hNFnTyg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A+bgFpH3+EglBM2JEI1fl7WO4toAzzd/NpT3qhtU8KGi7jJBW21vGfsF3X579xMvUMPeifYuDXH/VSja0e/mYhtX4PLBSGZNMqW3VtL3eYThPu5Rd7Bzcjh/tGIOdmdG7YEhv/47W+kRYaFsX3FO7izE8WyhYOPu+08fDnXCWqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=L+5bfxLJ; arc=fail smtp.client-ip=40.107.243.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=plICZRS2Ta3T+rwz0i2t5mYy8OUwNCT5lzKyp4TOH7NLeiSgjX86r60aelmgPiCo9686YHac9NogfCjmsefUj9RkmEbrwilxGuLxBrGHUITtbxfJ5ZfPVuA+55TQSmESOHFpFxCtKto/gSFYD83BWeQoP8Cs756sTn9xUr4QbBbz63mRx//POW4whz2MLAvavNPLlJNvE5XKQacFngAY0utDaxX35OMHU6BuFUiT9SL91cmsc5E+aRd9KW2yKkqAI5sfCO+51wei2jbEYkli2ULaxTJ0GH2bWSM3UijbEYQcGdeSw2w0zvma7H5GU+6RzwR1MXbfWXBUsRJV8ygKZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IWLfLSgvkukCw/64gACsG6yQRvDD5JL3YrhTUkpETJs=;
 b=FKQNY6vyGc7UXKftrJHF5GxrcPaAqJTzJA0dJFd3Mi1JZQCXHR/REuO4ZgHg1Tt/zZKAJYSn0zzPSPxcNxnJI/bTLVw3uGE6vcrTp3nQ/zH9Xm1RUPuFn+SqUwAdPCJcEqDzqYgXxm7VCeploslIPiOAqdeuvh50oBM6MODiDvxvFlVXxXjyMmUqU8XYFL6JN32Wju3YdnR+xdpcYaorY12yUNjOmYPGJxCSda4ucVUWZqNJy1Ryp6ba90NenwK5W1tRIUnMRLeb8sMXZsLZzJl8D22sM0VNF0cUPBGObxdm3OdzFcI67vk2Q+/aeJFV3Mc8xfzm9kKclgcqrMKHOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IWLfLSgvkukCw/64gACsG6yQRvDD5JL3YrhTUkpETJs=;
 b=L+5bfxLJWATKTB58cNDfUaKPu5b3zzV/9sumgzkGMHYFGliaiX/TWZb30P+0rOgMK2MeguG6JSF9+89ow6f/i6NIrEeltbttjURb0pYOZ6z+7McbhgC9fdLZnLysopdRBggDSwQqy5FSslUvJdC0QpNcym4diaUJS2euzgBgvyA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB6529.namprd12.prod.outlook.com (2603:10b6:208:3a6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 17:31:03 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 17:31:03 +0000
Message-ID: <bdc99602-7bb2-4026-8122-e92f894aca09@amd.com>
Date: Tue, 3 Sep 2024 12:31:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/5] PCI: Check PCI_PM_CTRL instead of PCI_COMMAND in
 pci_dev_wait()
To: Bjorn Helgaas <helgaas@kernel.org>, Gary Li <Gary.Li@amd.com>
Cc: Mario Limonciello <superm1@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Mathias Nyman
 <mathias.nyman@intel.com>, Mika Westerberg
 <mika.westerberg@linux.intel.com>,
 "open list : PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list : USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
 Daniel Drake <drake@endlessos.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20240903171157.GA254033@bhelgaas>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240903171157.GA254033@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0068.namprd11.prod.outlook.com
 (2603:10b6:806:d2::13) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA1PR12MB6529:EE_
X-MS-Office365-Filtering-Correlation-Id: e3a29124-84d6-4113-ace9-08dccc3e2f7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SFpMdk45b0tCbFVQcktKMjFzUkNtamkvNHFwTkZhZGM5d005U2MzbHBobFNJ?=
 =?utf-8?B?R0VOMFBHYmlhcUZIQk5KOUk2WGt1S1VJczd6ODBuQ01WZXJpeFZHZ3Bsdk5G?=
 =?utf-8?B?QnZFaWs0VDlNYnV1WmdZMTgzQ1d6eGh4SFNwbTZOSmRsNzFKRlNycFVqYWRj?=
 =?utf-8?B?NldHUkpra2NxVVlGQ0JvdDJ4R2hCaFJKSkZsSTZvWHIzZEhkd2tpeTBWZUZL?=
 =?utf-8?B?UDEvZHNBanNwd3BuL0hJd0QyQUpJelZ1d21wSzhubTNPQ1R4S1FkOTFKbjNK?=
 =?utf-8?B?UGh5NkZJeU1FL0thZjNyTzJkZ2tWMzloUitBSURsSkRCaXc3VEl2L25wUVgy?=
 =?utf-8?B?dDA4OHBkNUZOWldldFJwSDI0YVp2NFlOK2ROaE56SENmdnV3MDhlTW9iMDNY?=
 =?utf-8?B?WjE4aEhyL1ZJWUdCcEd1VWg5Ly9HQkVEM2lWWEk1a2dMcEFWeHBtRStBODA3?=
 =?utf-8?B?clJBWUFGTlJkUk52OGFLcDEvaHE2bVFqODNWMTZSdkY4ZzVtVzRtNDFEOUZt?=
 =?utf-8?B?dDZ3VEY0b0ZMajVEMWh6a0hxY3lRaytwdDJBb2tmM3Z5N3dURkJlSW96elFI?=
 =?utf-8?B?emZ5UUJHaEFRMlhmSno0SVB2M2ZsZEVBY2d3bERIdHRZLzBYMkVoZjVQM1hK?=
 =?utf-8?B?WnplTjB1bFlZbU9md2g5OWo4ZlVzQjZZNTQyWC8zVVRWQ1QvNklITUVkWU81?=
 =?utf-8?B?bnhtMklENmtCVFExTXVkWTNHVDlvK0JuMzdialdWdFpYZDIwQkFXNXkvR0RK?=
 =?utf-8?B?L1ZwUlJkWUFldi9STGZrYVBDNGdEUjZXQmI0cmxyRjY4S09uU1VJTVdxaEZq?=
 =?utf-8?B?WGZrWGhaWGM0YkpIR1VRajlEeUlPWlVOSWI2Y0owMGE0VGMyRnBXMW0zTEx6?=
 =?utf-8?B?K0FXQ3lzM0kxLzNXOUpxUHdFVklhaUJwTHRqQ0NTVXd6c1dPa0NnUmF1TXVX?=
 =?utf-8?B?NlYwbmhsV1g2cEthUFJtT2dIYmxhUFI2V296Z1NtT1ZWZWZEYVZVdEw1WGhT?=
 =?utf-8?B?cHpsTW5qWWIvYVR2bXJqQUhnSkZ4eVlMaVVhUC9zVEdRZThoVzVQUy9CdW1u?=
 =?utf-8?B?N0dzNERSTE45aEVRNXRqaXhTbStqQ2N3b1U5dkNhdTFDd2JXZ2lDaGYyUUdE?=
 =?utf-8?B?VWN6ZTdaTkFua3U3M1Riaklxc2xJaTFTVHgzY2R5cWNXTUJuZk1iTGZtdkdD?=
 =?utf-8?B?NXRRN0wxRjBpYWQ2eEdLNVUxQkFCODVQbkxBTkZ1bGIwa1NidHpUTmlqclcw?=
 =?utf-8?B?a0lMcnBzVUd0VHBiOUEvOWFXWURrTlNUMnlteUNaaEVnalBKbGIrMU5XL1g4?=
 =?utf-8?B?UUxmM2pCVXZINE1VdDFjZ2R0YUI3TmVEUVBRbmp0TDQyMDJtTHRscFZIeXRY?=
 =?utf-8?B?Z0NqQkJRZUFKd0hJNE11ZG93RDJIeFpOZ1hBMzg3dldlWW13UnVUYkpYMmtP?=
 =?utf-8?B?NHVHcG9YUjhwUjUxU0lCQ2hOTUQ2ZDJxMDdYT1N6T203Mndrd05IRWNnREVQ?=
 =?utf-8?B?SmJLa0psemRyUXNOL28zb0Z3cEJ3ZWkvb21iaWxmK3ZIUnFFam9xUnMrSTZ2?=
 =?utf-8?B?aGx4cFExdEhjd3FXdlIwZ0tOdTNXSTd1cGxrS0tBUVBud1pXVS9BZ2owbDA0?=
 =?utf-8?B?c0Q0aDhCZTY4MHQrYW8wOUVVQk80UStKbzJVaG5naTFkZmJmZGx2QlBSRXRL?=
 =?utf-8?B?c3c4UFpFWEJmK2xoTUVjMnN0Rjh4QnR3a3FISU5uZ0hORHFJNU5VZVVwTVpC?=
 =?utf-8?Q?+hlGjCaZWicNZGA9HE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VGJDaXd4UTdEbTBiU0JEZGwrZTIvdmFrSkZhVWRVMFl0amdTTVdwWkJpcHVS?=
 =?utf-8?B?dGhWK0E4djFxVEd5SVVUK1pLQXZ1MFI1Y21MK2tMSS9OeFR2a1doVi9xVTZM?=
 =?utf-8?B?dFM2QUNMbHRkNzNyNFNMODI1NThXdmtpc1dNUUJvMEFyRGlZYkk1M1FSZFd5?=
 =?utf-8?B?dUVlNjRCWTZZMnRTRmJ1b0FwVWNwM3pDaHJPS3lSYncwNGN3L2orQnYrVWFC?=
 =?utf-8?B?c2hxM095VC9WNGpSM0ttbnZMWnFQU1lDRExndi9FUmZ2UjkvSWVkcEt6MDdj?=
 =?utf-8?B?emozMFYyTlFaeENxdGxtek1WdERMTzYzTTI5Mnc2OVBRTENwZ0c4NVIyTTRw?=
 =?utf-8?B?dlRrMVZxV3M4MmFsN1FxNkxSUXVDaTdnZnduZ1FRTVo3ZnUremo3b0MrcFpP?=
 =?utf-8?B?clNkdDZDTFQyL3pRb3puREI3VkRjWXFRWmgzY3dmczlBYVNrREF6K1k2L29p?=
 =?utf-8?B?YVNHVEVxWXZScnVkSWl1SXdtOE9GZGVVcFVtRGUwdktWaTZkU1lHRW1idnB4?=
 =?utf-8?B?MzEzUW9ra1YyczkwS25hUFNFUEhxL1R4SVVHSGI1bW8yVHhCcGU3bSt6aXNa?=
 =?utf-8?B?M2NHTlBiSnZlWkhwQ2kwZTQrZkdPcndEU0R0TGdQdVYzT0lka2tvVStMWjBR?=
 =?utf-8?B?bW02bWVhcEdiTTdHdWZQYXdkQTRjZXhTUlE3bEpNemVUSFNybjBPaTI1UnY2?=
 =?utf-8?B?QTluT3NUVU9jNXVkbzdNRXBRV2JmUW5ydk1CdmVuSTZmeFp4QU10SHFGL0Fm?=
 =?utf-8?B?RDRxemZrUUE5QWlxT2ZGZ25YS3I0bE4vR21FKyswci9KRkxma2liZWJvVWtN?=
 =?utf-8?B?cFVyMDJxQ1NZcEZpZU03N3VmVTVKVlZLU3dqVFVnak5MZm4zMkQvZGkzdVlt?=
 =?utf-8?B?MVovNnludVdMYkt5SUdQb0FSYlFiODlDcldIQ1p3eFVTQUJST1J5anQxOFhN?=
 =?utf-8?B?NmZyc0Jvam5uQytMUHFPM3pTRi8xQlJUT2NkV0pEcWdvM1NSMGRPZTEzbWZ4?=
 =?utf-8?B?V0tOeFBJUUc4SldFdThIdE4rcWJ4bWxlZlVxU3VGQm1IOEQ3VDRqa3pkVVZv?=
 =?utf-8?B?bnYxNHdjN0JLQjBKQ2IrUG9UOW1tK0hXaDdSZFlsQ2JNNXQ5bXkrTHRuMVV0?=
 =?utf-8?B?R3FsRHg2ckxtVDMwak5tZWdKNEVTeEN0TFMzc3I5WWpvN3NWZU1PS0Y2VE1n?=
 =?utf-8?B?cjlSNERYLy92UUtHUklVczZucTJrQWF4UHVGZkl0N3Rnc1hBaTdNMDN0bnJW?=
 =?utf-8?B?dHZjbk9sSlF3VnVGMzZsbnBPb25WNytvUFpZdVpVaGd3a210UnhTNFpRandm?=
 =?utf-8?B?QVEyNi9hYlhaeEw1b1B0T2YwQlpTOFNtZ2ZESVpyYzluVytmK1U4Ym9Fa0do?=
 =?utf-8?B?S1hWcmMzWkNEL2NuSHVIdUM0R2RSRXBjaGd2UlhWMWlGMDBXNGVEam9rZ0ND?=
 =?utf-8?B?OEE4OWM4NjVXWElFRUdLRHEzMUwrMXo4UjF5bWdXaG1MajQzVlpaM21sRXc2?=
 =?utf-8?B?S2M5UU9UL3VpOWhMbzExWDJJMmtWbWVFQ3pmb3Rlbm5PQzRGVlFKRk9ad0l0?=
 =?utf-8?B?YnhSSDBacHFaM2RYdExpYVptZ3gwSk1qY1dSbjI5STJUdUlLWm5ZTk9QS0VS?=
 =?utf-8?B?RUJ2TWdQNCswbjVzdm50czY5ejE4UFp5cmtBMWNtOURkdk91SDRDR0doK3hN?=
 =?utf-8?B?MjNFbS91bFJwc1UrUy9veExsY3hJU3VDSE4vUUFhSzhrdTM4eGY1dFhnRFlY?=
 =?utf-8?B?Y2llMXBBOXBBUFRxZFplOEluWTV1K2poUXBRUFBpbEVtNDBGMTVvdTdwRElP?=
 =?utf-8?B?bmdZQ3E1cUpzM205L3lVa3RwSnBJZm1qYmpCWE9SZXFmWkl1Zk1wQkxrR1FM?=
 =?utf-8?B?MFpxNVg0TTZ5b21sUUc4Zm4zVG91Z081VVB3LzU1OFRoSDFWVk5ocWtJZWox?=
 =?utf-8?B?QnFucEZIRGpIYTFmbWFkMVBRYk1iUkxKcUpVc3JyRmUrZjlSSVVRa0g5WWdq?=
 =?utf-8?B?WkMrTXpnbCttZ0pHdGhsQ1gyTHFLaXlqMDR5SjFXdVdYR1BKTFpDRHJ5T2Jt?=
 =?utf-8?B?Y1dKV0lVNUphN0FzVFNlRU1TMTV1dEUwbWtub1pWSFZpZmF0Ykt0cmYzRENz?=
 =?utf-8?Q?GrvrOjhT2tXFKB8qAzFxH7C/Y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3a29124-84d6-4113-ace9-08dccc3e2f7a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 17:31:03.7591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hQFb0fZJNcPQ3PLItqqngv8OXe2DZlKj7Q+ruJQpuaHOLL11/AVE049gF1wYibL24ns3Ignh2Ic7IptQsjbXpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6529

On 9/3/2024 12:11, Bjorn Helgaas wrote:

<snip>

>>
>> I guess I reading between the lines you have an assumption that you
>> can't read the vendor ID from D3; which doesn't appear to be the
>> case from our testing.
> 
> A Vendor ID read of a device in D3hot should definitely work.
> Obviously if the device were in D3cold, we'd get no response at all,
> so the requester should log a UR error and fabricate ~0 data.
> 
> But if the device starts out in D3cold and we power it up, it should
> not go through D3hot.  The only legal transition from D3cold is to
> D0uninitialized (PCIe r6.0, sec 5.8).

Right.  The issue is it didn't finish getting into D3 at the time that 
we attempted to go to D0 though.  So all this extra time is basically 
waiting for the D0->D3 transition to finish followed by D3->D0uninitialized.

The best description I could offer is to call it an "aborted" D3.

> 
> OK, so with [1] and patch 3/5:
> 
>    1) Initially the device is in D0
> 
>    2) We put it in D3cold (using some ACPI method) because the
>    autosuspend delay expired (?)
> 
>    3) Plugging in the dock wakes up the device, so we power up the
>    device (via pci_power_up(), which again uses some ACPI method), and
>    it should transition to D0uninitialized
> 
>    4) With patch 3/5, pci_power_up() calls pci_dev_wait() because
>    dev->current_state == PCI_D3cold
> 
>    5) I *assume* RRS SV is enabled (lspci -vv of Root Port would
>    confirm this; maybe we should add a pci_dbg message about which
>    register we're polling).  If so, patch [1] means we should poll
>    Vendor ID until successful completion.
> 

Yup.
                 RootCap: CRSVisible+
                 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- 
PMEIntEna+ CRSVisible+

>    6) pci_dbg log should confirm the device is ready with a "ready %dms
>    after D3cold->D0" message, which would mean we got a successful
>    completion when reading Vendor ID
> 
>    7) For debugging purposes, it would be interesting to read and log
>    the PCI_PM_CTRL value here.  Per sec 2.3.1, the device is not
>    allowed to return RRS at this point since we already got a
>    successful completion.
> 

OK let me get a debug log with [1], 3/5, 6.11-rc6 and a message added 
about this value to share back.

>    8) The USB4 stack sees the device and assumes it is in D0, but it
>    seems to still be in D3cold.  What is this based on?  Is there a
>    config read that returns ~0 data when it shouldn't?
> 

Yes there is.  From earlier in the thread I have a [log] I shared.

The message emitted is from ring_interrupt_active():

"thunderbolt 0000:e5:00.5: interrupt for TX ring 0 is already enabled"

[log] https://gist.github.com/superm1/cb407766ab15f42f12a6fe9d1196f6fc

