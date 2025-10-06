Return-Path: <linux-pci+bounces-37613-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB7DBBE0DD
	for <lists+linux-pci@lfdr.de>; Mon, 06 Oct 2025 14:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83F993BB75A
	for <lists+linux-pci@lfdr.de>; Mon,  6 Oct 2025 12:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3765D27E07E;
	Mon,  6 Oct 2025 12:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="heLLUgLK"
X-Original-To: linux-pci@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010046.outbound.protection.outlook.com [52.101.56.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708F927FB2D;
	Mon,  6 Oct 2025 12:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759754373; cv=fail; b=dxaFC8e7DMTYCjKon7ZrHDnuwO+X+4VBLyDXRIdXvzZX8DgOllLuAB9dst1XuzkiE7sMIBfhsfnmxmwknVdj+DHQv9EKL6jEsz32RNXHi+a3ji5pkE/QhIsxVKZeyLqAjcD+yO/r5XOiVHhhmEQ+JrznwlzUEM1iSg4RXIwVPvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759754373; c=relaxed/simple;
	bh=087ikd8H+bdvPuugxUwKGUV36a3K4xSyTyaI7X8ors8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SfXBZXQ2E596nFltRakIu3bR16leeQZvCJ3i8UqEXBlKayvANSfuQzVFhHo+s2eTCfLS0xbSVvncFh+JPtBRIVMW0sWyhwGdOuV0rNGnEBj3j0p0WUW+pO10UaGLJ8ezJ/4BPD3Ado7IEYeV5wDxhYK/+NSL9/FzSGt82ee8hb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=heLLUgLK; arc=fail smtp.client-ip=52.101.56.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DiDnLQiSqmopAXcuuXLgxQpFi0+GG1xkHroRV3pe6yFsqKwR1jkeGz/bm4t+rPt3v3ax1tv1RbE/9YnI5HN7FayfCoP3hKtA3fWj4UPDIKBlgMYmPCRhUi8KyPMv/U//8Fkg2HoF3zHIwqoHY6PAYDwkSS14YHfh8/0wbM3DaAklMIrgTuCE3xJw3kzRrLG7Bn+SqFYoSFDxfCcktVxBdX1sUttom28+UBkA+UFdln2J9eSTaVnqHrF8UkF/WP843lHW+wNBJuxSjRhYtC5iP9eMqTMepLIau2yWEgobWlZwV2OKUJFwyEb3UuqB59/lbZNIgnABjLH2F6WGmVzWWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=URTVXFld53GTnQdqySFtus1ZUVhjs6zvEzSyqybdr9w=;
 b=FlLm9EcA3va8DBEbJH8yFhVttB5T8XysrFg5y60r82Gi2GzIjz6L5n6byxrd5ClcWZoMUY82c9+7C1rkV5vdGVuZwVy/L1b7RRW9ZjMPtj1RycO05u0PGLg1XXJLRTKHSL9k5TSyOINxLER+YayXAeTjnrQN6PvDeLNgtumpXw43tvZU7M7KdoxCjAclDaIe6mhKP1L1KwWyBFFxuFRWummiTfmHCVKy79p6g8CdLqIhZD1Pt3AYopl/wyXQjqoeWHaMFcVgTHWYEpAY6VJ1ShA7+ClxPd66nbNcT8lto9ltVUcYGTsz/N8zJ0TekSbL6en0OkjKewB8Qj2N1REpEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=URTVXFld53GTnQdqySFtus1ZUVhjs6zvEzSyqybdr9w=;
 b=heLLUgLKKij8gLBUAt58zh4btlnq72rgum+Kb0Tqn4AuvHTiW4oV9op/zrSbceI+I5cLl7TM7rhNM7OzRmG3Nugizy52ubkvW8rKR6WoPojigFhvZdEswx9N29qnHsXeZL08eV9uYsMWhdHbbZHkLlMsYZPYogHadrz82kw/XZc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA0PR12MB7090.namprd12.prod.outlook.com (2603:10b6:806:2d5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 12:39:23 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 12:39:23 +0000
Message-ID: <232324a9-e82d-40b3-b88b-538947411a24@amd.com>
Date: Mon, 6 Oct 2025 14:39:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION 00/04] Crash during resume of pcie bridge
To: Bert Karwatzki <spasswolf@web.de>, linux-kernel@vger.kernel.org
Cc: linux-next@vger.kernel.org, linux-stable@vger.kernel.org,
 regressions@lists.linux.dev, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, Mario Limonciello <superm1@kernel.org>,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <20251006120944.7880-1-spasswolf@web.de>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251006120944.7880-1-spasswolf@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0307.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA0PR12MB7090:EE_
X-MS-Office365-Filtering-Correlation-Id: 0071bce3-c7bb-4ee5-2de6-08de04d56096
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TnZkVlVtK0h0WDNtYmk5eEN3RlRsTU83ejVpeldTa3JpWTFDbFlDZVBncGxh?=
 =?utf-8?B?a3FKcGVYaEVaT0RvNnoxQmg4QldKL1Z2RENtcnAxZGpPeDlwWkthaGRrT1Yy?=
 =?utf-8?B?L0QyS3h5TkhLS0hiK0tnckFNcUNSQTdweFRDR3BWcEFWQmUrVUNJNGZMZVUv?=
 =?utf-8?B?YTlocGZVUFQybGpibWtCQzMxQU10ck56QlpQclZXYjB1NUpwa0xlaXkvOE51?=
 =?utf-8?B?SVNYb045TTNuRnpOeHR5UkhhSUFFVmhIZDJKeEdpNnFiUzBzRklINllJSFRp?=
 =?utf-8?B?NU1hQUhNSlUxNUdyRWlGTkJBTlVZc01SMHQ5bjdXajh1MkQ4TklDY1FCM0pO?=
 =?utf-8?B?aDJMQ056SWNYckZrOExhbk16NDJJWWJRZTZQT2M3YVpBaTI5emw0NVpGQ2ZW?=
 =?utf-8?B?ZzZWR0crZXNlYWpNWnBBa1R5bCt0UHJJV0sxQlVrNXZRTkVzRGRxUUNIRzdF?=
 =?utf-8?B?QkRieXZLSkdGazJnL0hYRmhKZ1Z3QXRicWVYV2MvY2ZBTmE0L21xWWgvOFht?=
 =?utf-8?B?R2NEeFhjMW5hRzdNOUkzajVyN1JxUGtkRTVsdTRWSUExQjFEc1RMd1VKYkQy?=
 =?utf-8?B?SFMvNy9rbnpPaElZSGUzUEFudkppTlhhUFZDd3JxSm1ONlluR1VZMU5rWWhR?=
 =?utf-8?B?YU80TDdYclR1bDI3MXVlUWVnQWFsdXd1eVc3YVA3NHNoZGNMVHBWZ3BOTm5l?=
 =?utf-8?B?SnFnS25iUDlyWkprWWFXU1VDMUtMZkRMTHZ0UmY4bDFIb0hva1MwcU1zYkNF?=
 =?utf-8?B?K0IzRlRvekdQUWcwUGcrWFhmcGpaeENob0xDVWRRTHJmOG5rVGFhSDBzcWNh?=
 =?utf-8?B?OGxmVGp2Wk4ySFF3VmgwL1kxeWZRdXVESVRhVDRrem8yWS8vZ2FtaTFQd05U?=
 =?utf-8?B?VjBjczRtZWMzMENZeUs2U1pEUGFSVTluUWJNV0dQak93SExWak80ZlYzU1g5?=
 =?utf-8?B?TjBMMld4Q2NzTFluQ3VDYkZTTFo4K0l6UDc2SFhYMEZnY1VjaUV2OStmMXA3?=
 =?utf-8?B?ejc5c1EvMWNpOG44bEtFOTVrMWVoR2N1OGRHdFovRnptc3NmZm5JWmFqdDJw?=
 =?utf-8?B?MU5OTkhVeDRCZHFnS3gwRHFZNGl6SDkvT1kzblZWM3hoSGU0UjBYY04rblAw?=
 =?utf-8?B?cmpwZ29OQnNVOTZ1U29WTzRQWEhHYUh0MUVsWlFxY21BU3dTTGhXeFF6UVpm?=
 =?utf-8?B?c3RjOHI2dU8zdlVSOGlHTUZ1Zkora2NlRzhML1plZXU5UHlVNTB4V0MzRi9y?=
 =?utf-8?B?TzNOTjltK0djR1VTKzVwTDZLUG9hNkk2d2ZtRm14LzdHSk5zNHR3VFVJMi9k?=
 =?utf-8?B?R1RSU3RQKzRwd3ZwQndEWHhITGN6MS9WVENQenorR1JDRXQrNzIyTGUzWjY1?=
 =?utf-8?B?WHN4dmVMeE41ZzNiajJFNGdkZHBnTmcwZzduRzlSSVpaNUVLU21NQVBLeDd6?=
 =?utf-8?B?Z0JBRWZqQUxLZzk2cTZneUxQbEY1d0ptZC85TlNBZEVacHI4Ym5IVVVDSHNG?=
 =?utf-8?B?VlNxeEY2MWU3bUlCMUdGWUZZaHdQbDZza0Q4NGhaN0kyUFVkbjV6c0JWTFdS?=
 =?utf-8?B?ZGYxQm5hVDE4ckRpZkd4TERFYmQxYVM5UnN0ckZtV0RwTU5pRlVKOFlkTkJp?=
 =?utf-8?B?bkFQK1NJbHNac0ozMDFrd3dQaW00N0piaG5acjZEdEFSOHc0eitORFZlcmlO?=
 =?utf-8?B?MmN0ZTVMS0JqcUxRUmJTQXFzdlIwRksxTU9qL3pINmVlTmo5QlUyUVpIbnZU?=
 =?utf-8?B?ajl0Z2dQbVcyRUJzRTBJWThuc1h5SXZFSHppNkNPbDVGZWR0aWtJNldIdGVw?=
 =?utf-8?B?TFkreEpSdldmRjZ4Y3NDTDdnNlM4YVBvVFhxMHl5VmI5djAxQXZjWEtmRXkr?=
 =?utf-8?B?R0s5SWlyS0xYelVzNDBBd0Rha0swcVhmOXJPWHIrbUVmZ2tRSzNnR1JDdmpk?=
 =?utf-8?Q?+Z1rtCtNgBpwzQoEqfXfhikbxtPR8U9N?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUl1Wlp6RGJJTTJBdFVuNHZKUmJKcldiWmtGUzdzYkRLaGJOdHdERmJUMUJB?=
 =?utf-8?B?eW91Y01FWDVMNlFXZmNsVmtuaUswcEo0dkY1L1dvWTVtMitUOWlQZThaM2xk?=
 =?utf-8?B?S29JTlFZSTBOQmtJOG9wczExWGkzazZVMUo5SzF4NkxVREJ0c1NReVArYUZx?=
 =?utf-8?B?bW9ENGpROUhVU0VpVkZnNVQyS3hMN04rWGVWU0JsbTVoMm1pb3krdFBqR1lr?=
 =?utf-8?B?c0ZFRHFNOUZ0ZVk0bzNYOWU3M1pNbUM0TllwR3hwK3VzcGg2SlJDQTFDQ0hM?=
 =?utf-8?B?bUYxNVJNV0RRYzV3azYyMUJvYmNjdmEySng4WlBNZ09zaVVxeDF1OEt5N1hM?=
 =?utf-8?B?ZTd0SU5HazFSdGRhbWtUeHAxcTR3NHF5VkRxSlZqb0ZwYU93ZVJvaVJ5SGxL?=
 =?utf-8?B?OE5xRDVmS3RmZUZVc2pEa25sK3hiN05QWHBOYlhqdE1VM1NpVllzUStTY0Z3?=
 =?utf-8?B?em1QemtsQ1FFc21GNWxlNjZLSW1pajZ0dHR3Q1JNTzFQdFoxblhPdStBZXJI?=
 =?utf-8?B?ZnJWeUpmSnRPSDlkMXBxdElIeXl6QnIyRmJRek92SEJweTA5U0llOFhNZE0w?=
 =?utf-8?B?SmVNVVF0KzRrd0x3OXVaMWx1dGNWbnE0Y2VWSnZsZzFzajcwcVVYNkFRb0pa?=
 =?utf-8?B?aXdGYjhyOWtoQnNyLy81UnRoSGx3N0tuN0FiaGVGUU1aTkFFLzc0c0lYRlFG?=
 =?utf-8?B?N3ZENENTdWpTb0tHSGtnd2JyNm9UR0JXOHVVMnQxNlhZRStzT3htUW1RMkpH?=
 =?utf-8?B?Z093VHJPNGVnZjVRcWNRNGdac2RjbTNDYkVzUHJQMGE4bGUrMUo1ZEJBN2Jn?=
 =?utf-8?B?N1g2aHBTVUNhOHJGRm9NNmhQcnpOOWdSM0VYQ05GSzlzWjU5RGtiTXIwbHFU?=
 =?utf-8?B?VmNwc0xVVWJJOHlMK29RVmdiZHBFRnFuOGpnV1NndHkvMG9rQW0zelROMHhx?=
 =?utf-8?B?MWx1emVGTWhBSmRiNFZHVHRnMzNhTG55YjlFSmlxcmIzaWt4dXphOUlXQkJC?=
 =?utf-8?B?VHdhVTZ6TUc3RnVCWDhNdit2S3J4dDU3dGZYOVBKOVRpNHVIVi8vSzZ1QU4v?=
 =?utf-8?B?Q0c2TkM2ekwyNDVaNlRDUVJCbDJXZWtvaGpuSTdvdXhzZkhKR1RVN21ZZVho?=
 =?utf-8?B?ZkkzZ1UwV0VmckMyMkVUd056cHhGamllbURZa0F3RG0yMmpJL1psajE1eGJk?=
 =?utf-8?B?cFJTL1VYTytzRkhTbXJBdWRyblpHYVNKQXRCd29TcGpLZzRBcXJiT0c1clpG?=
 =?utf-8?B?S0xsdDljUXdzWkIwS1Zhbi9UelJqN3Nrdk5PWWdRMy8za3VrRzFFNVJMaHJy?=
 =?utf-8?B?SU5jOENuTVEybksxSis2V3N1Y0VLRW0xc254d0J5RXBETUlYRGVSdmtSWUZi?=
 =?utf-8?B?MTZIWVRUMTNuanJYNDdjVER5Rkd5UFBFUWJCTFNwK2hkNy8wbWtpeWhvejZC?=
 =?utf-8?B?RjRXQ2d0WnZ1YjN2VkFEWVcvbmhRLzhFd2hEUEpxaDNrTHhZQktzRFZjajhN?=
 =?utf-8?B?cUt1bVV4bmJ6VHJCQ2p5NlIvdThyRThGRExjYTlrOXE1Z3FUSjlSVERRczNZ?=
 =?utf-8?B?ajMwWDd3TEdoQTYzV0NzRXp1cXBLZmtUOHBiQWFBaU5qN0ZybDFURUsvWmM2?=
 =?utf-8?B?ekFYa3c5cEwySndRb0t6amF2UWt0dWhCY2xQeXRkZnBmQlZTRlBiS3poN0pS?=
 =?utf-8?B?U2piRTdvb0FMRjYyY2VFdnUwOFNYM1BVSW5JUjJscVg4VGNOL0l5eURKZ0pw?=
 =?utf-8?B?UVdKekllUnlYbThCVjlaSy8zWkVtUTQrcnhTenhiQUNjaFpjZENVWGYvMWV4?=
 =?utf-8?B?NW9rRkVLc3pyUTR3L1d3dTNEdlpaYVZJTnpCSUk3VzFZOEpEN1NCajcxaGNx?=
 =?utf-8?B?aWtZQnhLeUtGMXBLc0x5VEVJNTJrMHhEUC9SdjlQRDVsMm5uT0JNaVdQKzVG?=
 =?utf-8?B?U1hVeXZvZmhBQkp3bHVMRy84MXZyOXBxYnVBa0JqZ0JOejgrSmVPdk1wNUlW?=
 =?utf-8?B?K2UzOXdrZlREbHg4QmpsYzh0SHhoTjJaNnY3K3dBTklhemVjY0pQenY3STdI?=
 =?utf-8?B?bkc1NDhzVUFFdXNtZHFrYXl5eTVQMlppNmVjck1lWi8zc21kK3ZCNHUyV1V1?=
 =?utf-8?Q?HnPo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0071bce3-c7bb-4ee5-2de6-08de04d56096
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 12:39:23.1561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FDzFEA5V4ZpNypFKh4VJjfaFaWAd1FPqOzabnYnV4/DbXYiK7NETrjSRJ4iOxTsm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7090

On 06.10.25 14:09, Bert Karwatzki wrote:
> Since linux version v6.15 I experience random crashes on my MSI Alpha 15 Laptop
> running debian trixie (amd64). The first such crash happened about in the midth
> of june, and as there were no useful log messages and even using netconsole
> gave no useful message I suspected faulty hardware. So I ran memtest86+ and
> found a faulty address line and replaced the memory (unfortunately 64G to 16G).
> But the crashes occured again and so I did a thorough investigation.
> 
> The crashes occur after 30min to 33h (yes, hours) of uptime and consist of a
> sudden reboot after which the PCI bridge at 00:02.4 and the nvme device 
> connected to it are missing. If there's sound running during the crash then the
> first sign of the crash is the sound looping like a broken record for about 2s,
> after which the reboot happens. With the missing nvme device the reboot drops to
> a rescue shell. Using "shutdown -h now" from that shell and starting the laptop
> with the power button restores the missing PCI bridge and nvme device.

Oh well, it sounds like some PCIe device is dropping of the bus and taking it's upstream bridge with it.

> As the bisections were not succesfull I tried to monitor the crash using
> netconsole and CONFIG_ACPI_DEBUG and "acpi.debug_layer=0xf acpi.debug_level=0x107"
> as command line parameters. With this the last message on netconsole before
> the crash is usually:
> 
> [21465.639279] [    T251]    evmisc-0132 ev_queue_notify_reques: Dispatching Notify on [GPP0] (Device) Value 0x00 (Bus Check) Node 00000000f81f36b8

A full dump of that might be helpful. That sounds like the dGPU is powering up/down.

> 
> GPP0 is the ACPI name of this PCI bridge (at least that's my best guess):
> 
> 00:01.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Renoir PCIe GPP Bridge [1022:1633]
> 
> to which the discrete GPU is connected
> 
> 03:00.0 Display controller [0380]: Advanced Micro Devices, Inc. [AMD/ATI] Navi 23 [Radeon RX 6600/6600 XT/6600M] [1002:73ff] (rev c3)
> 
> via the pci express switch
> 
> 01:00.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 XL Upstream Port of PCI Express Switch [1002:1478] (rev c3)
> 02:00.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 XL Downstream Port of PCI Express Switch [1002:1479]
> 
> While the GUI (xfce on xorg) on my laptop runs on the built-in GPU the discrete 
> GPU usually wakes up quite often, e.g. when a window is opened or when scrolling down on youtube.

Yeah, that is a known issue and we are working on it.

Basically an application enumerates the possible render or video decode devices in the system and that wakes up the dGPU even when it isn't actually used.

> A somewhat reliable method to generate GPP0 notifies is putting on a youtube
> video and the periodically starting evolution with this script:
> 
> #!/bin/bash
> for i in {0..1000}
> do
> 	echo $i
> 	evolution &
> 	sleep 5
> 	killall evolution
> 	sleep 55
> done
> 
> This is also the method I used to test the debug kernel in the following mails.

To further narrow down the issue please run your laptop with amdgpu.runpm=0 on the kernel command line for a while and see if that is stable or not.

Thanks,
Christian.

> 
> Bert Karwatzki


