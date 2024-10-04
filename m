Return-Path: <linux-pci+bounces-13806-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C5698FFB4
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 11:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D1961C22C0C
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 09:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4361494D4;
	Fri,  4 Oct 2024 09:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HmzwyBnJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8031D1482E5;
	Fri,  4 Oct 2024 09:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728033996; cv=fail; b=SAJHIPtEs3Gpk0SUvfAyXU0zVOYdRyC9ajrEByjILhVjiihdx3zzylqBOK7uzxQk7w9v1ZDEC+A8NR/Hp3h9VOI2h0k9AIYfIE+87tSp4LjkK2GiQoMzy1L486kAxNU8dWG3iDsO87q1RLw6DbWQp49AII52KOMJ1CcofPRSToM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728033996; c=relaxed/simple;
	bh=yojMJXqkCU4wSvoTVwp3xa5pALlHhF34lcj5hvxoWOI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QRJkyX6sUjw60aiGQSWopuyDv5DKBS8qGGK1R1rBMZqgS2SicFwp03wVj1P6l/wb5VIhogpfNj5+G8kRov7lpPJy7ceQMBZw+BV29JXSbGNXeXsoPa965JfBmmObSZD3aQDHh5PztNNiiVXEV6ku6DungJzvdlsuV6pPlSbfquU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HmzwyBnJ; arc=fail smtp.client-ip=40.107.243.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xd5mRL06D0ESKn29HZiO/CJPzxAap5uGLQMIeqSFnDq06q7wyVprap0gsrakVlJ1vX9MFhSWTIJlW8+xrdfOWy8l07DCfKvM9KDir8+kxif+kLwJH6Ek4CIFRpcx7GPO6EW+G/M53UX9R/kIwqCU9s6lpoAEEVlvn1r9uTrlZnBst2MJPAEraLkkj3j3O9FC6SN0kj44HO3xXW2hCOm6Az2RVcgsUjtl7vC7Qe0PFrjtlnKCvGD4FRaBSNcK2cUEOelh57do3kGTU1IMitsl6JD6SgKiEFwhYdxOUKJLcjnWHGkHOUWVpZ54WH8TbKBV8KYqolKi+2EUI3JvpaIgyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fqfZR3D71qAbDX+nn9jesATg0UR9ZMoayMBJkxWXQ5E=;
 b=KYyUiQFtAEjrkdyXYWnqq3uoWWQ2LNEe6VaMnHhjURa1ORkqT/4elswrdmVlczpnXuL4qT51l7F+Mo+LyvVEtfe3tJRCPiisw6JzrTrxfGn6oqUSPVBlS2A2GjEW1bUkHyXJbA5QqllkeSsgSEpHaf6A0mwvIoRhyUrhaC16ETBpuadz002PDbFNrdpJuGngp0zqfsTEbSyXykaoj1HfTlnOQ+iQAk/QfT8EptD/1YtjAv72bZ4VhxLOWemBS6Id1KM1q1sB3+SPuJQLPPRpfRO7lJwaVsTjrhOCI/HAs5d38y0TVp+5NpQKGNfadym7RkxBZ98Yr5V1qSkfiOyzrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqfZR3D71qAbDX+nn9jesATg0UR9ZMoayMBJkxWXQ5E=;
 b=HmzwyBnJpYfaSHmnLCZa4bY80RHmFvwMerR+qFmg5QJN7M/SYEWk+xGApkNlY8THlBAyuOfK+mBzqa84xeQxqOKox/U8vMqoqu6KcYMc59CrKbf9oEdh5HO0s7koJ0u1d8nA2uOquDgBbKA62o92TOdOBGec+YH03DLPPozSNasA9jgcjpFO5GTZ2m+hMY1QhWMGpvK0pn1r6h5Hup2bsDQAki5c4vTJ+0M3/n792lbs7eOEO10IKzA+S9HsN4PygCI/BrRSprumjpaSG82NW5NLUs9y4nau1wTtyE7NNTX2Ld2ml7gkPLlJvZe1wnJzLO1XxFlYF5m+PIIfxRmfBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB7914.namprd12.prod.outlook.com (2603:10b6:510:27d::13)
 by CY8PR12MB7561.namprd12.prod.outlook.com (2603:10b6:930:94::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Fri, 4 Oct
 2024 09:26:31 +0000
Received: from PH7PR12MB7914.namprd12.prod.outlook.com
 ([fe80::8998:fe5c:833c:f378]) by PH7PR12MB7914.namprd12.prod.outlook.com
 ([fe80::8998:fe5c:833c:f378%4]) with mapi id 15.20.8026.016; Fri, 4 Oct 2024
 09:26:31 +0000
Message-ID: <74f2c388-b622-4304-bbc9-2f1dceaef6c3@nvidia.com>
Date: Fri, 4 Oct 2024 17:26:25 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/PM: Put devices to low power state on shutdown
To: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, bhelgaas@google.com,
 mika.westerberg@linux.intel.com, linux-pci@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240911190516.GA644336@bhelgaas>
 <319e5419-3b12-4672-9f51-f90c5e142e29@amd.com>
 <fa504022-acb3-4930-b6b8-87a8dcb912c3@amd.com>
 <Zv9wDGp-7-lC8FhZ@acelan-precision5470>
Content-Language: en-US
From: Kai-Heng Feng <kaihengf@nvidia.com>
In-Reply-To: <Zv9wDGp-7-lC8FhZ@acelan-precision5470>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0023.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:a::7)
 To PH7PR12MB7914.namprd12.prod.outlook.com (2603:10b6:510:27d::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7914:EE_|CY8PR12MB7561:EE_
X-MS-Office365-Filtering-Correlation-Id: 21cb43ca-f0ea-4b82-54b0-08dce456a195
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ajNmTWFIdVR4SlFBUUNHUDJraE1pYXZqQnFFTkhhQjM1aVFWZ1RnaHU4eEdX?=
 =?utf-8?B?RTU2UDNEZEs2L0FHNXhrQWgxYTcwdnBJVVRxdU5BbGZMYnN1T3BWc0N0b2ln?=
 =?utf-8?B?eXFzZ2ZETG1GaFhSOVo0RTlPS3M1QWNxTlhGcndiVk1lMUJTeldFMkNhNTlO?=
 =?utf-8?B?M2RWd1JaMVVhSVlzTFV6Q0dBenhJbnRDVWFLcHlBaFFWOFVvbU83c0ovWEdN?=
 =?utf-8?B?R0NrbjZLc3ZYVTNhYkJwRk1wMmJ5VWJTc1JkNTZ0WnJFZnB3TVFIY1NhY0dl?=
 =?utf-8?B?YWxXYzRCZGhFaUxKWjdubk1WZjlxWVRxZlhBM3UycEdBM3BVMjdMejN3VDRI?=
 =?utf-8?B?SGpuT2Y3QzJ3UzVZSjNYR0NEWWJjdmQzS3F3RkVodWxuVHhqQWxTSi9oblhM?=
 =?utf-8?B?QW1TNldCVVNNU0p2RzE2TG13eGVVeGZmTFo3b1JLNGlWVEdVTUI2Q0N6V2lF?=
 =?utf-8?B?ZlRSbDNmNHpuV3Azc3h6SVF3Vjg5VnR4NnpPczhzNXIwdTdKQjNBbjY5Slp1?=
 =?utf-8?B?cmhDVWI0R0doS1FFWmJQUkJhYXlUNkFtaEwzSkU1bEhidm0rcnF5a3Fwb3Nh?=
 =?utf-8?B?MW41dWhGYVp3OVdZNzRhSEhrYnNPV1dhSS9lZVpuc294VUlMeGNvdWwrc092?=
 =?utf-8?B?ZGJhNGlSNWRBUENwTkY4NGV1ZTVsVGRpVTYzdFBqSiswVTFSdk9sWmtRWG1y?=
 =?utf-8?B?TStVdmE5dk41blcrL2kxVzVDTVFIOVM0Q2ZVc1VIS2FRSzJ4V1RwdUdXNEl0?=
 =?utf-8?B?Qzc5NisrVEN6dWpodEkydG9Zcm1TMWZHZnBHTWVXbnQxYWVkK2J6eDBqdDNJ?=
 =?utf-8?B?cFlGWFBsVFFEM0Fxc0oveElDWmdxNXJLb1NMV1Vtdml5YmhHQ0x6Nk1hYWc0?=
 =?utf-8?B?K21QUkdoK1ZoYmtWcDN5KzRlaWRUWFp4WHZ5S3JGeG93cUduSW93elFrTk5S?=
 =?utf-8?B?dC9lOUJETm5kTFUyb3dMWFB4S05weDM1UkRUMU10elUzd0tUcWJkTVAvVkVx?=
 =?utf-8?B?QS81N2tnNndZMTJPZnYyZnBObkVIVmpFVkZ3M2E1UVh3VGdvZ01QUkI2U1Vs?=
 =?utf-8?B?WVNvdGJ6ZUJwYUZyMTErUEpEbUpjVmt5RThNN2cxTUlkZnVyaEc1cjAyWW5V?=
 =?utf-8?B?NUQ1YkJ1NVpSdlo3VWZPNHNLcVRGM3Bod3Nqb1lPeVMyMStibHJPczYxMDdZ?=
 =?utf-8?B?Rkc3NG85TGl5aXdLQ3Z5YkVVNlpGazhyUjJOZ3VmVGxta01vRXZDM25UZ3lE?=
 =?utf-8?B?N1pYNWJQUzhXU3VvbVdxdFo3MlpVWjFhT2FMbTk1c3JySkhpb2xvQnVlcDRZ?=
 =?utf-8?B?WkhLbjExSW0vTVJybE1ZM1ZSUnJVYmJmeEJhczV4dkIwOFJzdnJuOEtKSE9V?=
 =?utf-8?B?eTF6YUJwcmdCMStiRGJnc2xuRGZnWXVVa0pma2tndGlnTTQzSVVNNzdJcUNv?=
 =?utf-8?B?Z3duZXVLVWR2Y2o0V0hqd1BLM0NTNzMyLzhFS3JvbWtjLzBKcmh4NXMxQ2RM?=
 =?utf-8?B?cU12VVEvMVRGN0RKNk9KNHNLUW5VOXEzajRoUXFUQVBXMHpIdm5Kd3lPZ0pH?=
 =?utf-8?B?N1grS1Z0RDQvZmp1eGxOTkM2OUVZZXlMNFdlMStaV0dVTmJaNWtjL0FhNTVS?=
 =?utf-8?B?TkdwQm9sVjM3QkdUOFg5ajBFWmhQZDRBL2t3emFXYUtaNnpaNDUyVGlheU9i?=
 =?utf-8?B?cGhaa1VLb1dPcWFUOWkvMEFaZVE1SHphZEdpSE1LeUhLN3BZRUZJcTlnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB7914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dnZUSVZueU93ZU1XV0xNbDhtSVZjY3FMbHVRZ1duWjhtd3NuWGc0Y1VHZ2Ja?=
 =?utf-8?B?cEM1S281R0NGRytlRVVBSktLL2YvN2IwdlVITTUyeFVHdy9aTmpGUjBPL2Nq?=
 =?utf-8?B?RU9OUmFISjVCNnMwaTNZdUdPSnBpTXhBTVZwSm5ac0NYaTFzS0FRSFVIMlZk?=
 =?utf-8?B?aDk1UUtrcVNuNDdWZG16Q3EwQmpzUk1IYUg5Y2F0cStnRXlMQW1FMjc3Mi9O?=
 =?utf-8?B?clZpYkp0YWxaemV1TjYxdHpqTG0wd3pBcjJZS2lGY0MvQmFxN3pGUEJ1YXpo?=
 =?utf-8?B?M1pxOVpOQ0lMOVVPV3BnMEtxQTNqRTY3bjMzYk1Ma0x2OVdyd0E5WTc0cXZC?=
 =?utf-8?B?NEtDKzY2WmgrY0RmbTJDdEo4NkJ0WHNOcjQwUmMvb3FuNjFzanFHWWtRZzFO?=
 =?utf-8?B?NjFIQmQ3TlhsWDRCcUdhbGZiR1c3V05sWDlzVnI4ckNDN3NTMlZPNzl1ZzNv?=
 =?utf-8?B?Y1F2TjFSdEJTQ1ZrMVRqNjIxTHB6aVhKcEt6cExraDcrSkhhSUUvWlFabVBs?=
 =?utf-8?B?TE5aTzNxOXA1T05XNXdoZDQ4OHZZQzhRTzhWNjRKRGgxeDBIRGpBUS9DS0FW?=
 =?utf-8?B?d21ZU2NYaFlmWDJ4MXdHbCtaaDdPTGM3RGhVUy84Y1pQelRFUG1Ta3pNQUZS?=
 =?utf-8?B?SmV3NE1EdzZ1cmFjNi9QbUV1MTFRTEtBSWVCcmpKb01JMithekpvTFVDcjRj?=
 =?utf-8?B?TCtSYTUxTWs2U05pdkxIdVFhWjZjdTFGMDFIdXIrMGJOUFRWWDdGc05RNGFE?=
 =?utf-8?B?UHdkeEpZUnJNWDc3NnJjeDZRaUF5Y0JiaDcxTUQ1U3FLd0hGbGZ4VnpmT25v?=
 =?utf-8?B?a20wWFlDZEFBRFR4dmRCSWJFSnZZZjFkVitCbjlHSVQ3Z2VxQjVXeUZFeTFa?=
 =?utf-8?B?cnBHeklGcm5oR3JqTzRTMllYSm1nMzFkRmlIRWFTQ0ZOZXFYK08ycGRlbUtp?=
 =?utf-8?B?L25IUmxsZVZJKytPUWVoMzhTNzVPNmhnRFFnT2JKU2lUS3NySVJDRHRNYjRW?=
 =?utf-8?B?THMyNG4zUU56WTR0azJZSWQ2RzczQzBvM0NVbVVvTENlZkplcTNPa1lMV0ts?=
 =?utf-8?B?ZmUvcmNqVXN4S2w4eGQ0UnhJbC9Ta1pGQWQ5UU9MbC9CUDJzM09kbE8zcWFB?=
 =?utf-8?B?d0paYXJnOUJHb0JhdWQ1QkZPajYyU3RkR0FGWjV5dEgxT3dwdjRxT2VMd3o3?=
 =?utf-8?B?TzBTNGVtVFRpVzlrb0kwMzRWbExMblMzcXJMUGt0UktOSWRkbktSRFFXMzQv?=
 =?utf-8?B?a1I3VWFhd3BKOXltM0dDNWhzdmphakVKQkhVZkc5MG93b2JOSGxPanlwbTBQ?=
 =?utf-8?B?d3NiYmovQXBiaUZTQUl3RkkxMnpoU1hrQ2xPbEI5clVRSkdIQ1NLdTA5MWgv?=
 =?utf-8?B?TDY3SnFDZjk2OXp1V2tLenBTcW4wdkhLbVhiQjJzQnlBL1lpOGJwYUliV2VV?=
 =?utf-8?B?T2RYSk8zb3ZsYU9QSnYrcjdKM0JSbS9nc3Z6TlJkcWwvblhwWmpEVXlXTGth?=
 =?utf-8?B?MUlFRlNENTA0WFFCamZ6U29xNU9vcnJIZVV0Yk1RaUZWand3UDlQak5IMXNV?=
 =?utf-8?B?OC9WNU4xT01pZzVqQkNOWi81aGxOdUNmL2ZsVjBURkp0d251L0ZBVzJWejNX?=
 =?utf-8?B?R2E4WGo0Y0xFSGJnM1kxSGNYM01xdkZIdGRQNTdNNW5TcURZR3NOYjRUVkRu?=
 =?utf-8?B?RVNFK0E5UEhrRDBpNitySTFtWUF5QzJJM2w2MWMrMkRkSTlqM1hyRzBZR3ly?=
 =?utf-8?B?ay9LL25qNko0Q0hBMWNMcU5pUEpESmtVaEV4MmlVNFp3Y1dwSFlWVTVzMThv?=
 =?utf-8?B?TE1LTEl4UVRSQmZlVHp4L1lOdW40a3o2L2ZvUStwcXViR21LVmVCRkVreXZs?=
 =?utf-8?B?bnJnMVU3NG9RMUsxRDgrS0lGN2ZUOC94dEZxbUN0QVlGdmVpUURrSXA3ay9k?=
 =?utf-8?B?MFh0WnkxMC9hbzdUb2Q2eUVLNnRYRkJxR3lOTVY0SWV0WGFFemE5b0VaZS9u?=
 =?utf-8?B?d21aalBraTU2dTVFdFZ3c0dHdkFEVjJGMmhNNHN3clA3Y3d0UFNGVjE4a3Jy?=
 =?utf-8?B?U050QTNzMjlrQ3FaMEJIUlFwcGU5UDFjYnlvbWxnTTFpa1lwSjB6MjY1QlAx?=
 =?utf-8?Q?cGG3CNYS92zo8RWc0zHx9+zBU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21cb43ca-f0ea-4b82-54b0-08dce456a195
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 09:26:31.0116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y8ddDab84BZ0nVTKEzsLNttkP1RToVSs3KLJMTBFLRsYvm9dkmsoeLLH4iHpz+7doCaLzrjwzhfdhFP5Sa6Jhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7561

On 2024/10/4 12:33 PM, Chia-Lin Kao (AceLan) wrote:
> On Wed, Sep 11, 2024 at 02:38:20PM -0500, Mario Limonciello wrote:
>> On 9/11/2024 14:16, Mario Limonciello wrote:
>>> On 9/11/2024 14:05, Bjorn Helgaas wrote:
>>>> On Fri, Jul 12, 2024 at 02:24:11PM +0800, Kai-Heng Feng wrote:
>>>>> Some laptops wake up after poweroff when HP Thunderbolt Dock G4 is
>>>>> connected.
>>>>>
>>>>> The following error message can be found during shutdown:
>>>>> pcieport 0000:00:1d.0: AER: Correctable error message received
>>>>> from 0000:09:04.0
>>>>> pcieport 0000:09:04.0: PCIe Bus Error: severity=Correctable,
>>>>> type=Data Link Layer, (Receiver ID)
>>>>> pcieport 0000:09:04.0:   device [8086:0b26] error
>>>>> status/mask=00000080/00002000
>>>>> pcieport 0000:09:04.0:    [ 7] BadDLLP
>>>>>
>>>>> Calling aer_remove() during shutdown can quiesce the error message,
>>>>> however the spurious wakeup still happens.
>>>>>
>>>>> The issue won't happen if the device is in D3 before system shutdown, so
>>>>> putting device to low power state before shutdown to solve the issue.
>>>>>
>>>>> I don't have a sniffer so this is purely guesswork, however I believe
>>>>> putting device to low power state it's the right thing to do.
>>>>
>>>> My objection here is that we don't have an explanation of why this
>>>> should matter or a pointer to any spec language about this situation,
>>>> so it feels a little bit random.
>>>>
>>>> I suppose the problem wouldn't happen if AER interrupts were disabled?
>>>> We already do disable them in aer_suspend(), but maybe that's not used
>>>> in the shutdown path?
>>>>
>>>> My understanding is that .shutdown() should turn off device interrupts
>>>> and stop DMA.  So maybe we need an aer_shutdown() that disables
>>>> interrupts?
>>>>
>>>
>>> IMO I see this commit as two problems with the same solution.
>>>
>>> I don't doubt that cleaning up AER interrupts in the shutdown path would
>>> help AER messages, but you really don't "want" devices to be in D0 when
>>> the system is "off" because even if the system is off some rails are
>>> still active and the device might still be powered.
>>>
>>> A powered device could cause interrupts (IE a spurious wakeup).
>>
>> It's a bit of a stretch, but ACPI 7.4.2.5 and 7.4.2.6 are the closest
>> corollary to a spec I can find.
>>
>> "Devices states are compatible with the current Power Resource states. In
>> other words, all devices are in the D3 state when the system state is S4."
>>
>> https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/07_Power_and_Performance_Mgmt/oem-supplied-system-level-control-methods.html
> Hi,
> 
> I'd like to revive this thread and support this description from the
> ACPI spec.
> 
> In ACPI 7.4.2.5, it states: "All devices are in the D3 state when the
> system state is S4," and in ACPI 7.4.2.6, it says: "The S5 state is
> similar to the S4 state except that OSPM does not save any context."
> 
> I believe this implies that devices should also be in D3 when the
> system is in S5.

Sorry for the belated response.

I think AceLan found a better explanation on why this patch is needed.

I can resend the patch with modified message if Bjorn agrees.

Kai-Heng

> 
>>
>>>
>>>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=219036
>>>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>>>> ---
>>>>>    drivers/pci/pci-driver.c | 8 ++++++++
>>>>>    1 file changed, 8 insertions(+)
>>>>>
>>>>> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
>>>>> index af2996d0d17f..4c6f66f3eb54 100644
>>>>> --- a/drivers/pci/pci-driver.c
>>>>> +++ b/drivers/pci/pci-driver.c
>>>>> @@ -510,6 +510,14 @@ static void pci_device_shutdown(struct device *dev)
>>>>>        if (drv && drv->shutdown)
>>>>>            drv->shutdown(pci_dev);
>>>>> +    /*
>>>>> +     * If driver already changed device's power state, it can mean the
>>>>> +     * wakeup setting is in place, or a workaround is used.
>>>>> Hence keep it
>>>>> +     * as is.
>>>>> +     */
>>>>> +    if (!kexec_in_progress && pci_dev->current_state == PCI_D0)
>>>>> +        pci_prepare_to_sleep(pci_dev);
>>>>> +
>>>>>        /*
>>>>>         * If this is a kexec reboot, turn off Bus Master bit on the
>>>>>         * device to tell it to not continue to do DMA. Don't touch
>>>>> -- 
>>>>> 2.43.0
>>>>>
>>>
>>


