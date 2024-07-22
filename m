Return-Path: <linux-pci+bounces-10614-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6F29391E9
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jul 2024 17:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92849B216B5
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jul 2024 15:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A65416CD18;
	Mon, 22 Jul 2024 15:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EnKuZaJI"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BD616E867;
	Mon, 22 Jul 2024 15:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721662708; cv=fail; b=V8/MnPrpUf5W43rFrpm+QDYisJ+eVjQTJaIir+9NP0QOuzwINelZviYXjyjuHJHpxFwZy2h57z8dJtz54rHB/K+Bq3yCVf6r9YcmfFvpesldavswZufbiDu15zhYVUo8ypxihDHKjW5P99sqEGipBjrG/h3mxowexRCkmiAIt3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721662708; c=relaxed/simple;
	bh=Hz4M3YZ64YiVSfSAGBOTXqxFFjqDNnEHscwSmPgKNKY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N7eikB/brRSvHSOkIelPw1pY7s/2QJrqTCIgdX2r3PemXgAf0HuvlPQHT52m+V5+j9cxc6rkSueZO3ujVdIs71MoxhTKR6q5aMjVcCMo1AkMln2kFIgC8vBPsc+FZ85oBF6u8KcCzUdMKt3/1gA4Dj1U3Y28ywApAUkd7g4SJ2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EnKuZaJI; arc=fail smtp.client-ip=40.107.94.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g6JnrlTXczsMmZqdttw6U9jJLjh3cVYid8eAYGY+HVt25QsZpNQMgla43S4L0ac87lRfOt1/01Uof5PnFrcJ5yNXMmkQoKuD+Yl39CXXJ0VjKs7uYHpFiGcJdcI3jLzHyRLAgCNxRPOUmEgsHHzx+6Jrfv6pwku0uZTeN9o1RD8z+iI8GNVqZIpw6Ykitz1uTa6TUa1aYrgIpCB0urGypsYdLvf2kJX/A3iUL+pxvVUTDjVT/usbZEpSsdm+y/2DJqcn93S+6DcXaHlEmVBsDeF067oPEUefj4E18/TF9JggqTAlhq1C+wNBewL06Vg+of1xqAm4qUVsQtkwaxn7rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FvUblSXLKKV12PebTfmxceusgQRkuzmv8iHC+rEr5u0=;
 b=dHF7vlP69GI8OGCvFqGYIG6nE5DU+tX0ARVCl4l7iXtjdT+k3XXUoMtWFGH829gmjeRHb/iFVzGv4NZsaFUCSoubLRjzC/qQPrMLWa7/qhvPDDFQX/KPwRX60LBNf7MNDSrq2DMTTO77HeI14sFy2P0kWV7wv3vX9/RGNVQb72Rhv+mPDcCim0rUDA1R32pq0zKf1Eq/K30BzYaUFC9uc7d5f8RUD4jW90uOhTpObn05lVV1eW47RVe/1dIXI3DUuDbDVwBfMHfvmJ5PfPqj0bINojQMqt2/Wox+kktm2SupWlkcBbw5+ZFX/gwfNvXjyJ1KOLy/DoJ7tPcoUTKrCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FvUblSXLKKV12PebTfmxceusgQRkuzmv8iHC+rEr5u0=;
 b=EnKuZaJIUyfOcX5Sroc8m1YXnuRFOP9DA6w2/BPk9xo6u4JjFNYFS/XKIhLyCI8GyeHAJfYZoMk/VK0BvGAYmA6s6Y0kyHBgby7zveKZomKvYOEvFPNPVH6IYQHIksv4NnURDHfeei7k0S0EdNAPqnI87hunxCeYSXkkjSOCUrA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4877.namprd12.prod.outlook.com (2603:10b6:5:1bb::24)
 by BL3PR12MB6617.namprd12.prod.outlook.com (2603:10b6:208:38c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Mon, 22 Jul
 2024 15:38:23 +0000
Received: from DM6PR12MB4877.namprd12.prod.outlook.com
 ([fe80::92ad:22ff:bff2:d475]) by DM6PR12MB4877.namprd12.prod.outlook.com
 ([fe80::92ad:22ff:bff2:d475%4]) with mapi id 15.20.7784.016; Mon, 22 Jul 2024
 15:38:22 +0000
Message-ID: <04af4272-015f-461a-84f9-c6afcd30bf82@amd.com>
Date: Mon, 22 Jul 2024 10:38:19 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 00/10] PCIe TPH and cache direct injection support
To: David Wei <dw@davidwei.uk>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Jonathan.Cameron@Huawei.com, helgaas@kernel.org, corbet@lwn.net,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, alex.williamson@redhat.com, gospo@broadcom.com,
 michael.chan@broadcom.com, ajit.khaparde@broadcom.com,
 somnath.kotur@broadcom.com, andrew.gospodarek@broadcom.com,
 manoj.panicker2@amd.com, Eric.VanTassell@amd.com, vadim.fedorenko@linux.dev,
 horms@kernel.org, bagasdotme@gmail.com, bhelgaas@google.com
References: <20240717205511.2541693-1-wei.huang2@amd.com>
 <6b8e2001-7f4a-40aa-a760-a4c709675fb6@davidwei.uk>
Content-Language: en-US
From: Wei Huang <wei.huang2@amd.com>
In-Reply-To: <6b8e2001-7f4a-40aa-a760-a4c709675fb6@davidwei.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0132.namprd11.prod.outlook.com
 (2603:10b6:806:131::17) To DM6PR12MB4877.namprd12.prod.outlook.com
 (2603:10b6:5:1bb::24)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4877:EE_|BL3PR12MB6617:EE_
X-MS-Office365-Filtering-Correlation-Id: fa79e9d9-92b2-42f2-3989-08dcaa6451d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y1paSkpaNDNjaDZ5SFVxOHl5eVBBcmF0V1pLQ1BXcHF2TG1tcTU4V1JDbWhj?=
 =?utf-8?B?aXdoK3E2TmZoaUZHUFRQanRWM1NxUmlHZ0M2aGFYRDZGckNKVjV0RTFKVXNt?=
 =?utf-8?B?UURKV3pDSlNXTkhoakNRSUVrY3BOS2JaTi9FOWtTMDZMVnFKT1Qxb1FMYTFh?=
 =?utf-8?B?L2RqUmdUTzlCS2ZJNXNxUWd1dG16aWJSVEovSnZxc1dwcFRwQndOU2ZrM1ZW?=
 =?utf-8?B?RnEvS0NyU05nV3RwaWNYenVWSDAwUkp6NVlKajlCYXVlaitnRWpBa3NlcDA1?=
 =?utf-8?B?Tnl3ZjFsWmxvVlZ1VkJtY3NhaGhGbmRDaFROaG5MU2h5NFh5TmZSQzgwSGhG?=
 =?utf-8?B?UTlPMG41VlRqblJaQi9yekFXaE1qT1VndDcrR1dUb1pjendjdTh3bzAvUjlM?=
 =?utf-8?B?VWE1RjRhNmZFUHhVaHUwdnJzVWJQRWJlMURBYzM1RGJoK1JNWDQwbFI2bklE?=
 =?utf-8?B?NzJuNU4wWHRFd1kyUURhaWw3ZDF0ang2V0JGUDIyYlRlL3o5aGlsbElMQXh5?=
 =?utf-8?B?VmNlQ2JnVkhZNnVPRUVuS2IrVU84MTkxdzd2a2dxTGwzNzN3VTk5aER1WWZH?=
 =?utf-8?B?L2JxMW5oREhNOHhMalF1blVWa1g3WGh0QkIrKzNFdThKSlFBNXhkRi9jdFBT?=
 =?utf-8?B?SlUrbzFvQ0x3Vm14VTAxZUQyRk9mWWxDb1NQQjNXSkM0YjFjNXpyLzRvZWVE?=
 =?utf-8?B?bzV4TUp4UEhMdnF6Zk5iOXBlcEdYbVhIb0dnM3FFRGpScThucGFKdEZwL096?=
 =?utf-8?B?Z0x2YUNGSnV6RXhHcS9KUVZaVXJqNWw3UEFHdEx4bXladk1ldUMySHdmb3RL?=
 =?utf-8?B?elN1QzZaSkhOanF1SmUyMllEbk5kOEZPQXZyZGhBVDhFZ0pCV2JHUHE0NGhN?=
 =?utf-8?B?Z0FGWkMvT01lVEFxRWNpOU5oZlVpcmZVU2NCaC9lY1R2bDEvZGdrV3RtWXFy?=
 =?utf-8?B?RWlmYm9SY3NQTHNmTXNNVzE5RXprMnZXRzgxNWQ4ZUFkQjMwSjR6Zm1MRVBp?=
 =?utf-8?B?V2g2UEFjN1IxanNRTEdkNWllVy92UzAvREc3NjZlYStnbC9EZUlsRUU2QUVk?=
 =?utf-8?B?UHFPUkU1NmZ2QXNXaDNQWFZmS24rOUFMVzhJNTRLdUNPUzhaZHk4WTFKRWRl?=
 =?utf-8?B?T0s4L0pwblllVGl1bFcwVnpGTEkxWmRTYlhkem1nWXhDa1dkNWRZM3N6cTYy?=
 =?utf-8?B?Uk1pWnkzQjdYaEZyd2pmdVdaZTZqK0pJekhISVpIaE9ac1I3M1hCK2IweTJI?=
 =?utf-8?B?WWNiM1pWNExDSDNDMXkwRFNzWklYSE5vbWhsdmRDRTNXa2FPVmdIUWREelhG?=
 =?utf-8?B?Ujg0a1pJUzFJVGFDVXN6ak80K0I2UmJCUHphUEtNcllDT3Y3a3F1bTVKd2Q5?=
 =?utf-8?B?a0lvZU1ONzZwakRxWkI0ZGhFUXNXVDNneTE4WGRlak9uY1pyZnlveE9kVWc1?=
 =?utf-8?B?VzBuRXQ0eU14aXRJS3NDelRibDVicWIzbUtSSml2dTlET2JQL0FaT01YWURZ?=
 =?utf-8?B?cTIrcUhKSlFXNDJjc1hwYjVJME5XY3pIbGF6MDdzUGxWcjNBTFhKZjRxL1BT?=
 =?utf-8?B?WlhkcGsrSnJEaXZjOXBrR0d6TWxvRFlQNitRc2Vzc2FRQTlGd2drWktCcExQ?=
 =?utf-8?B?Ujk3eE5EZDFOSXEwZ0pkV2g0UU4xYlpPVVhmUGMzNjdBQ0VBVS9XcWdweHRE?=
 =?utf-8?B?M2JhdG1zakVIWEkwMXZTWm5vbUxsbDB3enJSSlFVTEZrSkV5akNaVGE4UEFs?=
 =?utf-8?B?d1daVithZHhZZ1M3VUJ3akNIQXdVaTRMRGVTK1dkeDVmcCtjaFVyVTNIY0pZ?=
 =?utf-8?B?RlJCQ3U1YW45aVRJNlFDdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4877.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2paUWhzZ0FDc2pFbCsvT1Y1eEltNmFUaTZDK1A3dENOdFpZam5GSGtiMnpE?=
 =?utf-8?B?aEU1T2tpblRMeFVJUGNHdmttRFhhdldreWk0elFpck9oRXhldXZnNUFlUFM2?=
 =?utf-8?B?TFNjZGN6VVlMNCt4dFJacmFRZUZTM2EwNWZSd0NRTmdLR2x3M0w0c3BUczVG?=
 =?utf-8?B?VDVicUhpdjhTZndaY29IK1hLRTRraENxSXgybWFWb1JaTFExNE1zRTExcGlJ?=
 =?utf-8?B?aFZWZlVwanNZeENkRWZjSTJ5R05tbmhqNitYR1lWSGxXSzMxVEY0KzluM3Zh?=
 =?utf-8?B?U0F6ZkdJOW0xTGJTVjlaUU9ES3BVc2VMbEpKMzFXTVBtcUpvMEVHV0ZxeHpB?=
 =?utf-8?B?Y1A1UitlSUZBRW1jVVp3aStycXRXMktsSHZNc216cE11SmduLzZ0M3lwdGJO?=
 =?utf-8?B?M2h5RmVYalpWSklGRmNTOFE2eVFnbis2aVZPZ0xvbDlqNWUxd1llRXZ5ZW1x?=
 =?utf-8?B?TDNCeXZERGNIWG1aZXU4Q2ZaOHlVa05JQ0MwOWovd0ZGUGRtQzcrZjdockdX?=
 =?utf-8?B?U1pJaitGa2VpUk5rZjk1NG0vMy9EOVBqTzRUa1lVTWxUUm5Wa3NJTmRMMHc5?=
 =?utf-8?B?WW9zUE4ydmFKcmZPaHZWcGsvUFJoYjU0akpIWHpjcTNIWElrSlpxQjBrajVL?=
 =?utf-8?B?Yk1QSFNOeUhUZjY5OVJpOFVxOStITDhCamdpdjFKVXNXdllNSVhqUUdRL0d4?=
 =?utf-8?B?VkcySWRHV1I4bDFlWFNmekpORVJ4RHg1MktXTFRNUXhpaEloY1pwYyt6N1BB?=
 =?utf-8?B?ZXlZbkd1YXdPRWRKQTRXRzRXSHJRc1JpTGJDMmd6bkpHT1Ewam1yZDFLQ3BR?=
 =?utf-8?B?eUpVTEtUYmRKYk9VNVV5ODRwdThnakNjMXg0ajhMbTRiM093T0pLNzlmNkxE?=
 =?utf-8?B?N08zQ3J6Y2pzOGRvSXF3MUFYRStPYUlpZmRJS1JuNUpScHpTTnAyOTVRVGlw?=
 =?utf-8?B?OTd0K0pUL0ZBSnFQYWEvY1RYQlJWWWdja3F5UDBsSTVXMzdBQ0ZCdlVFV2FG?=
 =?utf-8?B?VnpPeldndm44THRXZGFrY2RoMWF0ekxWb29XSTAwNWhoWWhQT1lMb3FOUGhl?=
 =?utf-8?B?Wk1KSDZHaCsycGl2a1A3bGNNaCtSd0duMjFpcWplY0R5U0R4NmhCT2tNWm0r?=
 =?utf-8?B?UUs3dnZMUzlSVEFjSWppaHBVV2RKVnhXTXdUUjhvL2JMQm5YVmZ3Q0JrSnlN?=
 =?utf-8?B?eExZUUZrWThxU0o3L2hUanVyZlZBcStpT3k0TTVCOUJkdWxPaEo0dGxyS3Nx?=
 =?utf-8?B?Um5CUnVpWk5MeHdodTk4WWhob1pjenVRT05YcWJybEFmSW5RSnYveG15djBz?=
 =?utf-8?B?ZTJ4SWMwUGd5anlJRHdZcytvclE1a2ZqRUx5dGdkK1B3SUx1alA0RlB4Tklm?=
 =?utf-8?B?Y3Fibk1BYmgvRVVQM0lTdnNPUnVVM21qbnRDeFpLSVZ5WW9RWTNNYTJhR2tP?=
 =?utf-8?B?WWFkNzdKN0Z4WGhpQTdUMlB3V1NYODVVNGFFOUVoQXBuazVrenBwTnhUeXhC?=
 =?utf-8?B?UzVkaGd1WExZakI3ZDJpVmFYeTk3dUR4S0hTZGJFZXZMeFJ0ZG41YzFYQTUr?=
 =?utf-8?B?Q2VOYUhzUXJuQmJaNGQzeFlHVU9YZURibmVqcy9OR01namZRQ2c3dDBiZ2FN?=
 =?utf-8?B?cWdzNmR6SG03OXBaM3Rjd3VkWHFLZCtTZlNFYy8wamZyYWxZaFc5dVNic2Fy?=
 =?utf-8?B?aVhOREFuam81ZG40NlNlU2tqRGsyTTA5M0ovOHJKSVJ1dTYvR1RoV1ZjaEo2?=
 =?utf-8?B?VncrbDZDM2tWb0xQdDVncXQ1dXJ1QVJnU1A0L2I3WUE4UmdTb0xrVkNpQVF5?=
 =?utf-8?B?V1RKNFNZSlU2U1hTT09LWkJOTElFcm13UWVLdzMxY2RCeWdtSnoxQTRMY3My?=
 =?utf-8?B?RmYweGdOUXlCR09BVWV1ZFM1Vm1NaVBGaWk1M05KNjI2UmhmQVl6ck9IUTJB?=
 =?utf-8?B?VWN3dzBWa0tabDR1eTF5djRMMlg1V0toL3ZjRHl3a3BPbjJFRkdRZnhyZHNQ?=
 =?utf-8?B?RXh1T0tVRituU3V6MXFhcWE4K01OWEhrQUU4aFJCSDBSSGV2QjlNY2FIbllw?=
 =?utf-8?B?cVcrTzZ3UkxOU3dQUnc2K24wQnFTbXVacjZwS1F3UnNrYW1nc3F0Q1dPT21X?=
 =?utf-8?Q?WwgD9juH1jqnqVr6o4CJ+cHna?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa79e9d9-92b2-42f2-3989-08dcaa6451d0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4877.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 15:38:22.7548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u6W0riYE/cH6Ob1xYLryLPmRKIvAJA9x0j2U1v1yHWHyThnIu3fVdfxPx2/99Rt1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6617



On 7/20/24 14:25, David Wei wrote:
> On 2024-07-17 13:55, Wei Huang wrote:
>> Hi All,
>>
>> TPH (TLP Processing Hints) is a PCIe feature that allows endpoint devices to
>> provide optimization hints for requests that target memory space. These hints,
>> in a format called steering tag (ST), are provided in the requester's TLP
>> headers and allow the system hardware, including the Root Complex, to
>> optimize the utilization of platform resources for the requests.
>>
>> Upcoming AMD hardware implement a new Cache Injection feature that leverages
>> TPH. Cache Injection allows PCIe endpoints to inject I/O Coherent DMA writes
>> directly into an L2 within the CCX (core complex) closest to the CPU core that
>> will consume it. This technology is aimed at applications requiring high
>> performance and low latency, such as networking and storage applications.
> 
> This sounds very exciting Wei and it's good to see bnxt support. When
> you say 'upcoming AMD hardware' are you able to share exactly which? I
> would like to try this out.

I can't specify which server platforms yet. But you can find this
feature in either BIOS options or decode it from ACPI DSDT table (search
UUID e5c937d0-3553-4d7a-9117-ea4d19c3434d, Func 0x0F).


