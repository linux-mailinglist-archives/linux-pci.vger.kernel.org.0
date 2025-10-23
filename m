Return-Path: <linux-pci+bounces-39206-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6DBC03997
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 23:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 402651AA2871
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 21:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3368D2D6E6D;
	Thu, 23 Oct 2025 21:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ETGdnLst"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011033.outbound.protection.outlook.com [40.107.208.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3E329993D;
	Thu, 23 Oct 2025 21:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761255845; cv=fail; b=tKNMZIrHsaCKwisQWkGUV1Qw52vOarSJe3tzGAItDgcBtrvUQgueh36yoZZtmc2udOARUKwYL+hdTxXRbD2HsvbiHMW2ZQ4rNfA11zgsSZteMZzrbLqH+1zG5V2obf9gjFVUQV/5Yxwzes1ihWuSf6+p4RRzBJ2t35t1H83/HSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761255845; c=relaxed/simple;
	bh=K2sJWUjFTvDjfNolsR5F76o1kfR9Gm3Jc5klOXcNbP8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EcbRIrFA5/EuzMdmfQlq0+lWQg+17KZm7moyv1ozPbYrXfhLYrgz7ZgZdT36hAttAQGe72JWDz1NTzS/PPZMmnFSzKTP8xAQizixQaivM6fkNL5cV7EdzwevxfAmUqrT9ZYzEbgBYGAYxfemC8eUWhTFoOomRvj/nl6r++SQUac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ETGdnLst; arc=fail smtp.client-ip=40.107.208.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dDl4pH9Udr7V3w1N/ob6/Fhoh8EuAYcWGJztZe+zV4oo2icEL3E+rmSZR6RQksN9Dsc5I5CjQ/d0TCmHu+3CQhVR/rnd1uQaJfqhZz0u+lCHMQzFrGhGz6QiNbFbGA4oVUneIWhBTSPdEwA4PRFPKGgPTslrb1fkdfRZZuJkq9R3GV5/v6j6idQB3L3Gp4GyyG0+lzWcG9G1mvlCJFEF6GIXWKi49YQ7hE+fA6/2U+Z8XeZDxqOaaUwtbw7usm7QKIyTm/Mfwfnb9wchjFCyMjT5f5SEd2ufSG6HXW517MAvGwOn0fb60W6Y4ahVlq0TtPXkES+7EMZ65O+IOaqEJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kppuE2Rvth3HVjNpKDhqijzuiTQWm51yeiLxyLi5LTk=;
 b=na4/L/wJCebfHjzyTvOnzmxvBDGkTmXHK3eGav6BSIIIPHzu8jH/VJifRST/2Del6T8yVYwOrBBtBIW+/m/ONiUmZmIa616CVIMMDb+xxwCpB5IFndQD7t/F7bux10OrUcQRKJVqOpxbDBhBPr3DTAOmoTnQPyMhfJ3mnJJ46Cpzf5AE1GhshM5Qi29rwDFrDGXMyOiOdQTCjqpykm+GwNG6/q2AfNBdh4w+SerNkZAJ48E+93Sx3MO2ppvGImDOA7aRWe5LGGKcYaPGK9icAvJeVtWcN0QzFAm4Xf2ll5fYGs9enDow9DDTRGbEEK0CjTtcAZOc+L8nh6fYkm1ziA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kppuE2Rvth3HVjNpKDhqijzuiTQWm51yeiLxyLi5LTk=;
 b=ETGdnLstTgW+qeKGtQ/RgYz2sASmSzithr3G526T/Qe66ENsglWzPI1ouFf3ua+xSsMyLzNzZ8gz0eTmEnv0HpUaafmvDUC6XATTbtFFyffK4lqHjkmS/lCFDmpLYCmGpVFvvylBMbwTlC7gJaW11v+IBvpXKhSX+sYrcse8zrw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN0PR12MB5860.namprd12.prod.outlook.com (2603:10b6:208:37b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 21:43:56 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 21:43:56 +0000
Message-ID: <eda226f9-2441-4fe9-8530-8dafc6f58ce9@amd.com>
Date: Thu, 23 Oct 2025 16:43:52 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/12] x86/amd_nb: Use topology info to get AMD node
 count
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Michal Pecio <michal.pecio@gmail.com>, Shyam-sundar.S-k@amd.com,
 bhelgaas@google.com, hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
 jdelvare@suse.com, linux-edac@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux@roeck-us.net,
 naveenkrishna.chatradhi@amd.com, platform-driver-x86@vger.kernel.org,
 suma.hegde@amd.com, tony.luck@intel.com, x86@kernel.org
References: <20251022133901.GB7243@yaz-khff2.amd.com>
 <20251022173831.671843f4.michal.pecio@gmail.com>
 <20251022160904.GA174761@yaz-khff2.amd.com>
 <20251022181856.0e3cfc92.michal.pecio@gmail.com>
 <20251023135935.GA619807@yaz-khff2.amd.com>
 <20251023170107.0cc70bad.michal.pecio@gmail.com>
 <20251023160906.GA730672@yaz-khff2.amd.com>
 <5764e711-4c3f-4476-9ecb-1f7643e3b60d@amd.com>
 <20251023190644.114bf9f8.michal.pecio@gmail.com>
 <945b3be6-3392-4104-aac1-35d460e40cbb@amd.com>
 <20251023182506.GA796848@yaz-khff2.amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20251023182506.GA796848@yaz-khff2.amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:806:20::16) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN0PR12MB5860:EE_
X-MS-Office365-Filtering-Correlation-Id: 81787dfe-c240-42a6-46c6-08de127d444e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U0hIK2pZZkpSRmtVdlBrZkhSSG9GQkJYWGpSZWJ2ZWxxeGxFSUxlMFUreEl6?=
 =?utf-8?B?UVhrZFJyakhCZzA5Y01GM2NDdHp2Rk5uRUN4TzIrVWI0UkRJVlpTLy9RWG5T?=
 =?utf-8?B?K3M4TTA4WE41bjlXWUt1RldzaVNGSjdjK2FoS2d2ZWF6Rm5ubzBZTFRMbzlP?=
 =?utf-8?B?SmNnZzVTQTlqeW5aRExuRk9tZW11ZnFycHprQ0xYeWNUWXRpcEhoT0VlVGVh?=
 =?utf-8?B?T1V0M1ptcEdyRUJsNXRGcGJ1QnY1c3ZqZjV2WE9YNWF5TWVRTFFYaHlMbFVC?=
 =?utf-8?B?QTY3cHRmTENFajAyblRBaWY2QVpIeEJvZlBZM2w3MDdXNXRPbGxuOFVyc3U0?=
 =?utf-8?B?dkRVdFFxSC9jZnNhak9VSTJpVFJXd05Ib0NPZGxEekd2am5WeXk5bGloNEhw?=
 =?utf-8?B?RGJFaldKZ0IrMTMzUy9MbXBIYi9IY0lrRG9oeWZqNERLOFI2VWsvNG0zZnJh?=
 =?utf-8?B?RlRaL002MkdpQ0c1b05BdGY5Qk5PRTNlcGlmMTNYR2luQzdZSU0rU2lmakJh?=
 =?utf-8?B?aEM1amMrV2dlMVViNEhKMFRRM0ZSczJrV3Z5T256aTd3ZHplT3BUVk5HZ0hW?=
 =?utf-8?B?dXBqc21NNm1WampmSmwva3pxZmI3STg3MXUvK3Z4cXpNeVk0bDhxU3NJSUt4?=
 =?utf-8?B?VDJaNDNlV01IWVgvRDNBcmFMWVR6c2wrZnJQeDQyZzJMa2dFSzFSSGk3SWU1?=
 =?utf-8?B?MWFSZDVYcllCeHFmVWl2L2FZbWYraWNqYWVWcWNiQW43Y2ZFdTZ1N3hyM0RW?=
 =?utf-8?B?VlZRRFFCRDZWaGwyQVJpRnJzSU1tTWJjaHZvSklwZXVrVXJTQ0Y5K2dKM2dD?=
 =?utf-8?B?L2taejVGSzRTQ0FpaE9pM0ttME9PeG9SSjV4V0dTdE1kdWtFdjF4aHcwVGho?=
 =?utf-8?B?cnI1YlRENDMvdFN1OG5CaTN0RjQyYzJDTFVNMGNjbXBTMm9HdEVHYStiUzdi?=
 =?utf-8?B?NGdsRkNmeVh0REh0RUpCNmlySUFZdXErWUx4Z0J3V3kxcWJ0KzJWek0za3J5?=
 =?utf-8?B?OUhGZ1VYbnkvQ3VqVmZrdEJhWjJKcGx6MzdNdndaZ2tQREFXTFNTeTNWZEt4?=
 =?utf-8?B?Zy9JNWE1S3dubEZrUlZ5OFhPSys2WFcwVVgxc0dQU29HTnJoSEdxOCs3d05q?=
 =?utf-8?B?aFUwOU1WQnFUL25SWjJPTkwyVXJhUitSRXY4Ym5xemM1S2xMMlhWd0F4ZExT?=
 =?utf-8?B?eTAwcnQwM2ZRaStYcHhDNU1DZkhST3RIclRBM09jOUhWODNoZEtZVlJOOG9r?=
 =?utf-8?B?TjBNMFBKcWt2UjVzY0NpcmRIRVBUemV6M2lLcGpKbDdFeStaMUVEZUw3V2w4?=
 =?utf-8?B?YzdreHdnMWtMdEd6Q2xvM2p5VWhRTXN2eXVnL3dsRnExUEhMSXI3d25TZVl4?=
 =?utf-8?B?My9OZmoyNEtUVXJ1bVZQd0JwdmVCUGJwcHpMSnFkNmVXM2d2K0xDNkZpUm1U?=
 =?utf-8?B?S3BhZVE3OStpZi8vYUtQQ212Ym1CSjA3Q0N2aVVwdFpJSU9CeXFEZ0NDYll0?=
 =?utf-8?B?eS8yVmw0dUJzZTZYYmEyRDl3c2srdXRhZlVyOFppeDhxTzM2VTdCOXdvK2dk?=
 =?utf-8?B?Nit5NWZBSWJYQnZnVElwY2JPTys3YnVDRU1LZjV3ZlNQWHYrQXlSUXJlQWhq?=
 =?utf-8?B?bG5CMkJ5bjVLZThReHc1dGFkWlZ2RmErM0w5Qno1SU1OVHdsS2dsbVpJSHds?=
 =?utf-8?B?RmdCUkM1VFYzU0wzWEl5NlR0RUZXdk1hMGF5MjBsRHgxd0JhaWxoZTRteVdY?=
 =?utf-8?B?UUNuM24xVHh0ck9GZW9tbEczK1lEcTB3eGkyM1lKTUlkdFE3eDIwNXpSZk9s?=
 =?utf-8?B?clE1L1FXeUxIend6SmRndi96ZmFmV3VzMG9ZckFXTFZUZzhTZU0vSUR6UjBi?=
 =?utf-8?B?dE9SaXo5TElIelZZQTJ3WmFwUDA2aVVUVkd4KzdSZGd0N1BPOXFUU1lqNVNL?=
 =?utf-8?Q?zpfdBZ4BYb93RYaGqLBu/DoXcbF/EFrW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGtOWWRiRi84OXo1RzByRnN1c25XUEdEVmNlTE12SldxdWFPZlV3SnNLVldL?=
 =?utf-8?B?UVBTQWZtNitNZEJvQ1VMYWQvYUVxNEZ6SXNTbEY4ZHJuZ1hhR2RLdXJVc2th?=
 =?utf-8?B?U2dPa0ZQb0dZa0FWUlFweEFoa2phcDFGNmliMzQzNDRabEV3VmtnOHZ6NFRh?=
 =?utf-8?B?R2QyMXlBcVVranI1TXd1MGNUNEt1d1RyRlNQcnhuTmk5UHhKTDFGWjVGUWh5?=
 =?utf-8?B?QjRaSVJLVDVUeE9UQTMrNDM2Z0VoZGRIUDZRYnBXKzB3bmlyNjJqMGdmUW85?=
 =?utf-8?B?R25VQTZUcHJXMmdRYUdFUWZjVGM0SEZENXB3am10bzFpMUFoZ3E1dVNYK1Jz?=
 =?utf-8?B?d0RzNzZVL1hWWlVQemNsMkVDNmd6dXVsRFJGejdIT0YzcUk3TDVaT211eE9I?=
 =?utf-8?B?OWlIR0VQTDU4V3lFVnh3cHFFWTg4MVJ1WFhIZG1tSmJFcHBtMjRtaWdwd01R?=
 =?utf-8?B?ZkRYWGE5TmF0WFhLVEJ1Nng2SzJiOWJycEJaaTU2WGVQNlRwYmwwWThSK1VH?=
 =?utf-8?B?NWtpWWh3SjNTeXFlR0pJU0hJZG05UjRWanE3Mkt3OGFvLzN6ZU5YMG9aLzBv?=
 =?utf-8?B?UEp4V2RVT1JJTlVHc2tuemxqUzNtTmRWdkNhRTlpeXJEMkRaL205L0lCeTRX?=
 =?utf-8?B?MHlyWFIzNk1XUXhyQ3hRZUYzVFI1a2xNSGt6OGo0TndDSkhmblpJZGF2VW5F?=
 =?utf-8?B?UlBxZ2JkMXNJRmFqdk1PK3IzeVE5cnJCOG1ZRVhPVEFMRTJNYnV6RlpBNzlG?=
 =?utf-8?B?WWJBVWFEOG4zYVFVTngzYy9IZGtHZFpaNndIWlpZem11aStFNGFWeHEwRFMz?=
 =?utf-8?B?QVVhNTRiZDhsRHVEM3BkeVRsVDBDaWNLV2MrYWY4OU81Z0JDd1licTlCb1Bs?=
 =?utf-8?B?Z214RzNUblBoUkJFY1lCQ1V3MERWajc4WGk2dVRnNDFFS1orcldWKzhJU2tL?=
 =?utf-8?B?eTc4bDJlR1BiMEtZTlNmN1crNm5IUmZ4YWlOQU9NWHNkaUc2TXlTY3N5TmRD?=
 =?utf-8?B?eGt4K2s5V1pNejRLeXZwQVMvQUVtU250RGtrV0gwRDFic3hRN0pkQUpucU5W?=
 =?utf-8?B?Uy9maVdXcHBObERUcDNnb3QwdVd3ZDRjVllQdkRCNmNzUUN2NFBVay9HLy9T?=
 =?utf-8?B?NmEyV0VGdGwybS9QbVkyVWNSZTNyWjV4b2hZWlFjVWhlY1c3bW9hcVZqdTdS?=
 =?utf-8?B?bHlROTRRL2RhNUkvOXI1bklxc2FSdWkveXdFQnFqNVBaN0xkWmIybVRudVU3?=
 =?utf-8?B?dXpmRHJVd0s4TEFra1hMNDZwdENidzFTRVZtcVpWbnJQT1NTT1lwTkh4emhw?=
 =?utf-8?B?RW1IMjI3RmJCaEFJbWZ2VThOb2lhTUVVR0hBRGxTTERSMXFTTlNlSDRVUGZC?=
 =?utf-8?B?YmdJNmFudmY2OWh0aWI4Z2JCa1ByYVY2eDloeGRXOGNsQnlwOG1ieDVSNWpQ?=
 =?utf-8?B?bWx0eG9CSHVOengvakNCSXJ2ck0rMXUxVEVXVW4wanJ4WHlvQjZFS0NPSUJm?=
 =?utf-8?B?VGVpcUN2TFFIZHFjR0tIUVZpOExGN29tNERWbE43dGxEU0I0Mm1Ba0tkUXNr?=
 =?utf-8?B?dm04U2ZmN01ldUNmbkxlOVpWVGpxaVNZQU96MTFQQk1IRHVjb2lNWTlpMVdI?=
 =?utf-8?B?eVY0aEVzT2pSVVJpa1IySEhzOXJoT1ZRaVR3RENreHlWZi92Ym9DdE9pRUhT?=
 =?utf-8?B?T0FYYUZ6QWJTS1dtMGYrU2VwZ0hiWDVGMVF6eXdQZU1XSGF2d0RBK2d2d1B5?=
 =?utf-8?B?aGd0TjVtUTk5MUtlcVE2T2x0R0EzK0RHY0ZuVVlQRUd3cDBCNlFvQk5LY2I4?=
 =?utf-8?B?TkFweWtLU2UxcjgzaDFhWStBSlhEZkJrV2ZvaEVJU2s2K1hHV3o1bHpSNUQz?=
 =?utf-8?B?QlQrUmkza1QzQ2tDMEtFUjlRV0VYMzVpNWJLWk5sYU5BNG9UbzlKdWt3MDZB?=
 =?utf-8?B?VmZpT05mWU5aSTdLNWtORVFlZU9vVk1QYmNCT21tci94akxERmkzeXhzNWNv?=
 =?utf-8?B?eXI1UmZJUlpuSHRlemRxeHh0c2dmajlQaExYMlVrYlhkWjNQb3FMSVlYQWdJ?=
 =?utf-8?B?WnF0NzZyZE1Ma3pJdE1qdXB5WWpZMFM5Nk5CR2M4clMvakhhWVEvYlMvSEhz?=
 =?utf-8?Q?ADPRiwCAiE5uRoLPnxWEd/TTp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81787dfe-c240-42a6-46c6-08de127d444e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 21:43:56.1665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qnjQ9NWgfMwjf2IkT3IkNKprcKMfO/1mWFhkp1q4eXWbLXZoeBk3sPEpFSolCTrOHG1t+ba6x5zdRZy2IZ4ayw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5860



On 10/23/2025 1:25 PM, Yazen Ghannam wrote:
> On Thu, Oct 23, 2025 at 12:12:50PM -0500, Mario Limonciello wrote:
>> On 10/23/25 12:06 PM, Michal Pecio wrote:
>>> On Thu, 23 Oct 2025 11:22:29 -0500, Mario Limonciello wrote:
>>>> As this is an ancient BIOS this reminds me of some related commits:
>>>>
>>>> aa06e20f1be6 ("x86/ACPI: Don't add CPUs that are not online capable")
>>>> a74fabfbd1b70 ("x86/ACPI/boot: Use FADT version to check support for
>>>> online capable")
>>>>
>>>> Does reverting that second one help?
>>>
>>> Not sure if it's worth trying? My BIOS predates the ACPI 6.3 spec by
>>> several years and (if I understand correctly) MADT revision is 1.
>>>
>>> It seems Yazen guessed right: they list 6 APICs and mark absent ones
>>> as not enabled. But I don't think we can assume any ACPI 6.3 flags to
>>> be valid here.
>>>
>>> I wonder if some quick check could recognize those consumer CPUs and
>>> simply ignore hotplug there? AFAIK it was never a thing on AM3.
>>>
>>> Michal
>>
>> Oh if the MADT revision is that old, then yeah reverting won't do anything
>> here.
>>
> 
> I think this commit is interesting:
> fed8d8773b8e ("x86/acpi/boot: Correct acpi_is_processor_usable() check")
> 

Yeah; the reason for that appears to be a virtualization use case.  I'd 
be tempted to revert that and add an extra virtualization check instead.

