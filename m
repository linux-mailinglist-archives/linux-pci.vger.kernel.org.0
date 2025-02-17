Return-Path: <linux-pci+bounces-21636-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0DEA388D3
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 17:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2E1E3A3153
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 16:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9406D81E;
	Mon, 17 Feb 2025 16:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MSdM5X4k"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2070.outbound.protection.outlook.com [40.107.96.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87FB42A8B
	for <linux-pci@vger.kernel.org>; Mon, 17 Feb 2025 16:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739808278; cv=fail; b=OxtP0HnHtvzLBCoeGzNR/ZkRfrWqIGUm9KRn/+CBmFCos1F95pYBOWsYP6ny/xuianhuVUkp0NizYO2jaDDH4TTkTDr6GxrjMJryKVg9YKWozIEdYh3+4zf5SCI72XUIsQl/8oBmb4MbXhccNnpOCL/+aD8fT1768UTIjrajLN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739808278; c=relaxed/simple;
	bh=9JQN1oOf7TUAyFbgceJX8qvcYo17O2sY1Wh1dLNDfv8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OgYuwuhmrxMFZIryjWjsgD8CiBtbMNXyK2ekQR2BFb5mhMDgXFXqQxsuADARHw01raFW1eJVezWvZcPOkd1kr/j+/w8T0OS6KsAmBejQBdcLp5i37I0q0WkUQtrmAUlCLXVxYzuJzbU5JWIibPhYXOZrx7ywLCjrTqldEfMaAmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MSdM5X4k; arc=fail smtp.client-ip=40.107.96.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MUte1MU9+Hvobk/1eEzYjevQtD3bI14bA8+jHJ4Iwvf2VGSBwIUSv59j3JY/5EFZO/I2CNSmS4f8Ho/Y8pIZ0LdOiq7B7DWOr/KzEInuWgy2V+2W26bPiylgFQ4fVa4nipdPsMDfOxrfbESpEWpg0AdyTTfRKony81XxGEtM1i4jWHofBZXgM1+MtwVn/5A2RCrfmY4CYrW35Tz/sClILp74mNUjOgpIugEgl/ygSYS8RS7KKJfI+wC5KQqbHMHyxRPTYh+UnaOwvS1ugtP0xuS8GL5VjkQpSETwW/Czo1i/3ywzxw2DwuWkiwmufEecDJrW0XFoYVd1760xKn1osA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zUwWBrWCF7HL3TEWYF0zjn6K7XSn5tBXJRZXr7eWbdM=;
 b=DYg2+Fv7g98rZJrRQJE6Ja7sEl2p4xyki/4pad26FNxMGWbKtbfL5qP4R0d73sKiYbryNgkkNPKqO/Hie4GoPOd819IxC491Fl4wYoXPYVhTafqwVLoNy438G2PjOJLqLe40ribAj4lyxkXV5BAVI3WoG7UHazpSY1hIx/M3TEG8ZNuhFqQEKeOROn6Z30t/fTCd5DWU2qmfndqQsYZK3KroYMKaIgIL7IBWG2gVVD3Hj9zywwD3COrPwls4hrcaBHhTVeEYzl6OHzSDOQAbl8I/HiR1X8oWBbNZdQ5qiKT9aslu71ciwInPTHy786fhG4G9qvYu6iq8onNCfnPX5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zUwWBrWCF7HL3TEWYF0zjn6K7XSn5tBXJRZXr7eWbdM=;
 b=MSdM5X4k8gUtWrTT0Dx8u6hEu4QUjqHbml1gl7T0NQeDxwlWYBmOp2RdQzqpOGSdtfu9QvkyMnhWPE/es4i0KUgsaDA0AaXPrQD1yVa9bshol2KPdqQxOeARFamD2t6pgDgoD48WO3/ZKCNm+126SCSTwbE32vD4ADQrDa98JQk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH3PR12MB8459.namprd12.prod.outlook.com (2603:10b6:610:139::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.20; Mon, 17 Feb
 2025 16:04:32 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 16:04:32 +0000
Message-ID: <a2645312-0903-4fa9-9735-7f2a77986cb8@amd.com>
Date: Mon, 17 Feb 2025 10:04:30 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: fix Sapphire PCI rebar quirk
To: Alex Deucher <alexdeucher@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, bhelgaas@google.com,
 linux-pci@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Nirmoy Das <nirmoy.aiemd@gmail.com>
References: <20250217151053.420882-1-alexander.deucher@amd.com>
 <1654fb6c-e0e8-4dde-8554-7058cf73503d@amd.com>
 <CADnq5_NUEuMFsd__w1eGBWALxcQwtX7sa2Sn53vDjaxrqNuhPQ@mail.gmail.com>
 <CADnq5_NEhv-E9ZxHvxhBtFb_cBkPqMfu-nsQfEknO30tNBjA2Q@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CADnq5_NEhv-E9ZxHvxhBtFb_cBkPqMfu-nsQfEknO30tNBjA2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH3PR12MB8459:EE_
X-MS-Office365-Filtering-Correlation-Id: 0348d068-d039-445f-9a2f-08dd4f6cc3d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OVFVbk5XRWRFS0lYSjdoalJHeElGcFl2MUhkV1A0bHdhUWpDVEdGNHB0RFFH?=
 =?utf-8?B?dXhrc0dPMmF5SkZOWW1jME1PNUJwREZCNWh0QWZtWkVRQnRXYWtSZitNQnR5?=
 =?utf-8?B?ZnlLVndaQkozU2RkVFhZNko2enRDcEFaNGdCZWl0UWVWdFUwODBKbHVGZFR0?=
 =?utf-8?B?WmVFazVxcUgwZlZsbmYzL3AraHppL1hzUW9qVlRwdFpwNVo1UnNDMDQxNk1R?=
 =?utf-8?B?a3JVRy9YdmRwTEthNzNRanZsS3FUdDA2RENmV0E5bkxxM0pPUGo4ZnVvbE1O?=
 =?utf-8?B?dzJjNC9WK0ZKcGV5WGZWMDJwM05IR3dSQ0c1UTVMUS9wTzk1SjVkcjM5N3Aw?=
 =?utf-8?B?SkZOWFBqM0U0WWgySjBGRi9wc3NzTkJEdlJLOXEwVGdsK1ExaHoyY0VsZjlB?=
 =?utf-8?B?WHpKcGdTMGVNN3JnNUhWelhZSzRTaDhyZm1nTkliVFhETmhxQU1weHZsRWU3?=
 =?utf-8?B?a1dFWHNFWlFzUFVIWEYzM1Q3SDUvQkNjWEI5SE84NHM2Q1VIU3I2dVFSVm12?=
 =?utf-8?B?UDFFaFBpQ0dqQUE3SElGajNiNWxSUnAxV0VZTWVLdEFiRmlZOXErSm5sSUpa?=
 =?utf-8?B?Rng1YzNVUHBCdnZLY3QrNGVncFJzQXZNelBmYXpQUEVvMUtSNmUwZFZzS0ZK?=
 =?utf-8?B?SkZBVEdpalNWMDVLUjNmSGJtRlN2VFFPRm93NE5XYU9ISWE4NWNKcUN1VlBq?=
 =?utf-8?B?VlQ2TUpCbGllenpvYitoMTlXaDcxYXJETk5SSkFxTS8wd2JmVHIweFA4dnBX?=
 =?utf-8?B?bS9MSndlSk56Qnk5Skx6NkNtT2FzcmtiY3ZUb3Y4MEEzK1NJVm00NkNMbVpp?=
 =?utf-8?B?RW1HRXlhNzdNRC8zNjdFM3JwYzhyK2VrZE91N1AzVjBPb09lRjFPNG1uWXE2?=
 =?utf-8?B?K1FYMDBrUzNEY3Q4RnhkdXUyQkEyMll3QmppUWR2UGtTRW50dDhBLzAwTSs3?=
 =?utf-8?B?SS9lc3FobjFCYVg0T2RzeE5aYVFmc3ZBRmR3VndtYmJ2YmJZa2JHcEdTTU5J?=
 =?utf-8?B?SVR2b05YSjJMbUJMY3MrclFkaWYybkRGbG1qNGtpcWswWlg1bDAzU3V1MnVW?=
 =?utf-8?B?ekUyZGVFbFNweWk4QkR4clZreE5RNWx6cjB4MHFNVDlQYjZsdWZINXlISzhL?=
 =?utf-8?B?aVh5Ri91eWNiOTM3NEo1ZHpmdUJVa1cwczQwZnBydk9VTk5NZm9JemdtVzZo?=
 =?utf-8?B?bFhlY1NzRExDbS9OWDVFd3Q0am9vWkpTUGtJbmVmbDNxL2FCYjR6eEFiZ3FF?=
 =?utf-8?B?aEJ5VTNTbW1pbzgzUFhLZU5OdEF3anBKaWs4ZDlGZXcvc0tTblgwWHRabmpl?=
 =?utf-8?B?SVlWYml4QnI5Z1NEalgxckF1VThCNnVLTWt5V0ZNQk9qYkVCeXE1VTJES0l3?=
 =?utf-8?B?SE1BaXpvRTZUTm9ldFNXSExacE1IMEthK2d0WDFPNHJ2SVA5cERFVUZyYXVV?=
 =?utf-8?B?RENhSTZ2SjNoRi9hRCt3elNTZ1BFdWJwYjhGdllkL2NLalhzdzUyYVlzZUlp?=
 =?utf-8?B?SWJIU2NXbHRreEpCeFNxbHVFNTREMEx3cldpc0UyMTFwMk1zdjloZy9BTSs5?=
 =?utf-8?B?R1E1NG5Uekc0M25tbE9YMTU0cFcrSjZpNUVoTFFrRUd0MGcwQ3JOTEROdHV2?=
 =?utf-8?B?S1IrRHNpK3NvcXNKYnFEZU9SVHVuN0N0Tkw5azZ2VzJJNWlZUFRVVDczbk9U?=
 =?utf-8?B?d3RKNHVEZ2J6SmExN3ZUQXBFbTdoU0h3ZUNheXdSRklxSkZBVDExdFNVQlFD?=
 =?utf-8?B?a3J0V0Y1bDVrSmp3NEc2RTk2d0ZjNnFuU0hWVWlwNTdnbzVucG1yS1lwNjIz?=
 =?utf-8?B?WU40NjVqQWhORkNvZXFkdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MzJrMmRVZ2JMc3cxYTc0VTFIS3R2elQxWTF3MURvZCtmUFl4bXQvbStUVFc5?=
 =?utf-8?B?aGFra2grdktnM2lWV1M5ZlJMc3R0cXRVSHAzVWY5bmFGSnNSWTBrVUJYSGw2?=
 =?utf-8?B?dnltK3NjaTV2c2pnWmxGczc3d0g1R1hBMWI1cVBmTHR3VGwxSGp4a3NlUUV1?=
 =?utf-8?B?a3NibklvQXp3NXZRSGVTMVJrYUl1UnAxNmdWSDFSTTB6SXBuWmJCelRmOU00?=
 =?utf-8?B?ZXUwcWlSYjNhSHgwSzdVT3RFL1NuQmhIbi9vZ2t2S1luTHhyWXcrMXlsNzQy?=
 =?utf-8?B?cWJXTmJPRkhRaEpPT05kbTZ0Qkl4M1I5ZW5KWVZDVVVFSEM4OXgxQ3BveGxB?=
 =?utf-8?B?UGlyK3ZtajNhRENmOFkwWHFuVmlYWkJackd0Wk5aZkQ3bWRDR0l5N0ZrWFNX?=
 =?utf-8?B?eURSWkNRMUhsUy9oNTU3MXAzU3QzY2hWb1NCQXhFVDhHaXNWeU5lZEQ3R3ph?=
 =?utf-8?B?c08zMjFob2dHd2N5ckxNdVZiLzlzTHNmK2xTS0EvYnlvQWdtcS9WMS9zMjNh?=
 =?utf-8?B?MXlaS0pvcEFmcThKV2k5cDRWbklrUjc4M01CWmIzTmhPdEc2dTY3NmIrTW1I?=
 =?utf-8?B?SW9oazJUaThJNVpLVG5jK29PdmEyTURjRmlBQ1Mzb2Y2STZtdmttSmU1VXpP?=
 =?utf-8?B?eGN3RlhPc0J4QzdwUkt0TFA4K2xZbEhmaGdsUEUrdVc2Z1BMMVp4ODlNVmFM?=
 =?utf-8?B?TXFkblN4Sm9lb2dUcnkwckdVSVlnbURmM3ljMFNKV3lvNXJ0bndIcXhhTWZC?=
 =?utf-8?B?SDZsd3pic0FtN2FUWE5lS05zRW16V3F1VC8wTndTTWpkbjcza0NPMDkwM1JX?=
 =?utf-8?B?TWs1SlExbDkvNUxQc2JNMFNKRHAyekE2a2VoQlVKNkVGdGVQZHMwcTRSbnI0?=
 =?utf-8?B?OGp2eHVuOGQ1SkZxZTdWa01xdGh0TVNuSjZqeXlDSXQvL3k1aE84K1owRWFK?=
 =?utf-8?B?eWh4VWV3VWYvNzIyWlozUi8rSXF2SjFrbjJFc1dldWRMQkV5MzgxV3JyMk83?=
 =?utf-8?B?UDc3MFc2YVY2SzRTV0xFOVczcjAzQ0hNcjErRzJyQTh4dEQzTm02RTZxVlBD?=
 =?utf-8?B?Qis1QUVBb1I4aW91a2xJMFJuSEtYSGJtTFdEOERtakx0SVFJL3M4UWRybmVp?=
 =?utf-8?B?ZkdleS9BK1hoaHQ2VGpYWFlIOFFpQWhvR2JvbkIrMXFvOTFZakxvMHpORURR?=
 =?utf-8?B?VzNadWtZbEdPcXZNUW5PaWdXTFdKb00rVGpvK0RuaVZBR0ZEbEFjcWl0Mkhp?=
 =?utf-8?B?L25Wd1pjcWFYclg1UDNaZC9WaHNmMU5FVjNmTzlDMktxK2RVQlcvRVdQT3Vq?=
 =?utf-8?B?eEI1Sld5RGlZTXh5cEdvajlPTGhqeFVCaUluSlZOR3JTaS9vTHFLZ1ZEaWpF?=
 =?utf-8?B?cGZSaHRqNFRIVTFXdVR3Y0I1anhJZldyMTBseHJaOHY1ZFcxVmV6SWpGOStq?=
 =?utf-8?B?TWVVYlpveEg2QmszelRjQTIraWZnbjBTOGx2cm1GemRtd3VpcGVzR0RkTVNQ?=
 =?utf-8?B?VDJmSzV1TVFvemdLanVvdVhYV1JJakdwSXB4Yld0d050QzBRaVB6cGN2d3lq?=
 =?utf-8?B?YWZyRmR4L1o4ck1CSjFDdVIxcXlwYVZDRnM4QzlLU1AyRTY3NUgwc05qMGVN?=
 =?utf-8?B?MERXdTJqRGJsVjdSVHUyRHMySDRQQWx4ZU85VUduQUdBUTVQMElNRkpwc3VP?=
 =?utf-8?B?Z0U0NjBCeWkwWll2cTZDSGk4REptUXFYSGF2VndyVnE4cVVYY0dtb3FmOVM3?=
 =?utf-8?B?VDFocTRyZk5VQ2lzRmkvRGRFWE5Yb05sRFdnMW5WSU1oQ2hiby9VeGUrL2pn?=
 =?utf-8?B?U2dsSnUrRGZkSGZCbFI0cEJGS0tvekVlYWJ4cktwWHNxNTlFVGEvZWxuNUpo?=
 =?utf-8?B?V3J2M3BFNVBBa2R5RkltUzJzNW9zSDFxblVKdFdmemZzZlRYVE5TNzQzbVN2?=
 =?utf-8?B?eTh2UzFJUXM4ZlhJb3IxbWVqVWNSVnhPeWs2d0xFaVhPQzlCNi8wd05KMzRy?=
 =?utf-8?B?K0VDc1lLY2NhUVhzNzhGdHFkSjlkVlZFdjNxK3RKbFJxZ3E4NU9SYmluS2hn?=
 =?utf-8?B?U3R0SlNGZjEzSlp1RHNjYU5UM1RpZ3hqSnhtZm9jS1lqTzJRNHNwTFpzTVc4?=
 =?utf-8?Q?65CiGW97QlbZtGNuP6SOinSuw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0348d068-d039-445f-9a2f-08dd4f6cc3d7
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 16:04:32.0427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WEQ9deZD45JzT56ZDEeA1PnBRaYUhdIt2u5rMfEBTJV530Gv/MsCKf6eXufML64WrIVUFMbSt5cWvbugFjaqsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8459

On 2/17/2025 10:00, Alex Deucher wrote:
> On Mon, Feb 17, 2025 at 10:45 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>>
>> On Mon, Feb 17, 2025 at 10:38 AM Christian König
>> <christian.koenig@amd.com> wrote:
>>>
>>> Am 17.02.25 um 16:10 schrieb Alex Deucher:
>>>> There was a quirk added to add a workaround for a Sapphire
>>>> RX 5600 XT Pulse.  However, the quirk only checks the vendor
>>>> ids and not the subsystem ids.  The quirk really should
>>>> have checked the subsystem vendor and device ids as now
>>>> this quirk gets applied to all RX 5600 and it seems to
>>>> cause problems on some Dell laptops.  Add a subsystem vendor
>>>> id check to limit the quirk to Sapphire boards.
>>>
>>> That's not correct. The issue is present on all RX 5600 boards, not just the Sapphire ones.
>>
>> I suppose the alternative would be to disable resizing on the
>> problematic DELL systems only.
> 
> How about this attached patch instead?

JFYI Typo in the commit message:

s,casused,caused,

> 
> Alex
> 
>>
>>>
>>> The problems with the Dell laptops are most likely the general instability of the RX 5600 again which this quirk just make more obvious because of the performance improvement.
>>>
>>> Do you have a specific bug report for the Dell laptops?
>>>
>>> Regards,
>>> Christian.
>>>
>>>>
>>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/1707
>>
>> ^^^ this bug report
>>
>> Alex
>>
>>
>>>> Fixes: 907830b0fc9e ("PCI: Add a REBAR size quirk for Sapphire RX 5600 XT Pulse")
>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>> Cc: Christian König <christian.koenig@amd.com>
>>>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>>>> Cc: Nirmoy Das <nirmoy.aiemd@gmail.com>
>>>> ---
>>>>   drivers/pci/pci.c | 1 +
>>>>   1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>>> index 225a6cd2e9ca3..dec917636974e 100644
>>>> --- a/drivers/pci/pci.c
>>>> +++ b/drivers/pci/pci.c
>>>> @@ -3766,6 +3766,7 @@ u32 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar)
>>>>
>>>>        /* Sapphire RX 5600 XT Pulse has an invalid cap dword for BAR 0 */
>>>>        if (pdev->vendor == PCI_VENDOR_ID_ATI && pdev->device == 0x731f &&
>>>> +         pdev->subsystem_vendor == 0x1da2 &&
>>>
>>>
>>>
>>>
>>>>            bar == 0 && cap == 0x700)
>>>>                return 0x3f00;
>>>>
>>>


