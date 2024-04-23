Return-Path: <linux-pci+bounces-6585-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F428AF4BF
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 18:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9307DB26045
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 16:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D83013D625;
	Tue, 23 Apr 2024 16:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cpSQZQMR"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2046.outbound.protection.outlook.com [40.107.96.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C719D13BC33;
	Tue, 23 Apr 2024 16:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713891584; cv=fail; b=P0MiM0DmJPNeJ+2ShOEm9wVSkM6pItqKEkNxOQGaTl06n70bm7W+EsqYCTFHebbcNtjHMrUpQR50NlzexHJRAqgRHWQUwvARxNgRlMjHImfz5cOfET6cZuqDvxPFBHPWvakipeccVyccDeJMg2i4EyjpZOXpQIvBcP8ZGwQ+cus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713891584; c=relaxed/simple;
	bh=3heiUpBJrGSdVUOM9m/duBlINpfoNmwvQ0O3Uq5srmk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MJLDmiyZjaYKqQs7udABOayShHvQcj7oVp2YVoPTKU6KODvaSriVOSSv0A5sZpdIbW12ZHKYW1RLbNzvEScBHE/t2I3PiFEPMa4qLLnUWP/L7IaB3C9IzG5+CUkZ3uP+MAtTyxQi/H7v6Sx2M0YN4aZirDEhp2v8MYmKIh6Uay0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cpSQZQMR; arc=fail smtp.client-ip=40.107.96.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kg/dRjEk8XL0zdtrXvLmGDGNlFgS4lzUOpBxN9pIswKMeISCMrefXyQ5MMp3HqyyeWw82W2kLLC+GKPWF5zDf9nSm57YLE9PpGdfR84J0OgT1KciQfdaN3YiUpb8FISk7wYS85e4FoRzKD3jGLz3KTwolVgIrgF3zOmaFeY8U+w0CT19JekIjUR2+S/PQrIAuo4oFHwKnGYVjlRTVKYFJwyegjSD9GMh76WVBxdO3YNK4KO2m6r6Lziyd126SviWqVBF2oTK8rROGiJ0oWtILjNUFuWO3RgMvYavVybepAfLB7HkyV9Njw2JihT3T3JIgxpdTHSzCC9ELXQ5MkpnCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+IpfIu7HRbtHwvn4/SJv0MBQMSw8rUNvS4Ta2UuRtD8=;
 b=nelugMzGM/nKggN2BR7qAH8kJXZTPGTtTaZso5Uc5fcXYtqVbFif4WdBBsj/tJzYgCxai+XwDsZ/EeqVtdfNP9TI1uepEAs0aCxkmSj4GFdlESt5jL+daV+TQgmewaIT8nkX6mdH9RBI/gtfVzUHuRr0Dw9lwzxaMBt5LnF1auWUgHdJ4yjS0opKMSKD4R7EuOQPRc6+DchqWR8ofllRQWK9tw9+Mjzo4zT+YynY23ZyNxxXLxZxWaY1XbEvTl1K8SL0tJ3i3ZrWEtCPg/Hf6O1pj3Y18yPeCTvQ0i3OET2z3MjBTAWSC8jmY81t4WqE4vxX0ieeWumctGrLkTl3Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+IpfIu7HRbtHwvn4/SJv0MBQMSw8rUNvS4Ta2UuRtD8=;
 b=cpSQZQMRKIIAEH0iAvbsRvO78fKaS6AKeYP+dOpbJNhL4n/Xsmb+IsQQEwLIFUXotYMxU4Zsd01uZN3L1Hhs913pYxVJQzJSoYl0A9w0+ruzEM962SfzBBwcUQbDXlG88DJ8AqQxpqFcoOt5TyX6EFxD528c5Fyz5eAixGDdrn8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SN7PR12MB8102.namprd12.prod.outlook.com (2603:10b6:806:359::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Tue, 23 Apr
 2024 16:59:39 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::d9b0:364f:335d:bb5b]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::d9b0:364f:335d:bb5b%4]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 16:59:39 +0000
Message-ID: <7197b2ce-f815-48a1-a78e-9e139de796b7@amd.com>
Date: Tue, 23 Apr 2024 11:59:36 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Esther Shimanovich <eshimanovich@chromium.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lukas Wunner <lukas@wunner.de>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Rajat Jain <rajatja@google.com>
References: <20240119102258.GE2543524@black.fi.intel.com>
 <03926c6c-43dc-4ec4-b5a0-eae57c17f507@amd.com>
 <20240123061820.GL2543524@black.fi.intel.com>
 <CA+Y6NJFMDcB7NV49r2WxFzcfgarRiWsWO0rEPwz43PKDiXk61g@mail.gmail.com>
 <CA+Y6NJGz6f8hE4kRDUTGgCj+jddUyHeD_8ocFBkARr7w90jmBw@mail.gmail.com>
 <20240416050353.GI112498@black.fi.intel.com>
 <CA+Y6NJF6+s5zUZeaWtagpMt8Qu0a1oE+3re3c6EsppH+ZsuMRQ@mail.gmail.com>
 <20240419044945.GR112498@black.fi.intel.com>
 <CA+Y6NJEpWpfPqHO6=Z1XFCXZDUq1+g6EFryB+Urq1=h0PhT+fg@mail.gmail.com>
 <7d68a112-0f48-46bf-9f6d-d99b88828761@amd.com>
 <20240423053312.GY112498@black.fi.intel.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240423053312.GY112498@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0160.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::6) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SN7PR12MB8102:EE_
X-MS-Office365-Filtering-Correlation-Id: 670f0e12-8aea-428f-29c5-08dc63b6c396
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eWV2ZW5oa3ZUbm9WZHVHRTcxZEJ1KzFNczF3SnV2UGVkVFFEUXNnR3d4am5O?=
 =?utf-8?B?dVR3WGlHSzFDeVgxOURzcEZnUHJCU1JwZk1sSDZibG9XWFpEeUljTnVNeFZV?=
 =?utf-8?B?TVhTVHl6TFVUMnBIZkJQcjl1cm05V3ArU2tPdVAvdUN0OVNsWHNPRVVjVFVi?=
 =?utf-8?B?M2JUMTZoMXhWUDdiTU96NDF2K0xwS25heFFEQi9PaDBtVEFRdVI1K0UzWXJY?=
 =?utf-8?B?K0w4bnB5TEJjN1JLZEpLM3hwbFlmSXYyb3dFSDRpc1hiSCtCRnRseXFteUx3?=
 =?utf-8?B?T3ZNem5mWWF4QkJLWXV2SEErdGtaVlIvamszT0JaczFPSkxGa1BXOUhobXF2?=
 =?utf-8?B?RThsank3M1pOMlYzR251UndlWkNoT21IT1Z0V0s4VGJaSXZwSXNyN1RUc2g2?=
 =?utf-8?B?UGNJSUJLbkJUS1o3TFdaeTdwM3I3aDlNWkVMK0s3QUZpNXZhR0tMMUhKbVVl?=
 =?utf-8?B?M2d0TkZOeGk3Z251cGtjbzZCQjlDSThsSXBkdHRXMkVLZkdzSUN3d1p6R1dY?=
 =?utf-8?B?V0dIbDlLdUVrWTBoQ2ZGUkhFYUZRMVhWcWxMZW5DbTUzQ3Fnc05keWZIKzFu?=
 =?utf-8?B?SVJZTnRmbFh5Qnk4ZU5SYzVNWW5BYnRYK3VrVTlvNTBSL2Z6aDZFRFpZRTlm?=
 =?utf-8?B?SDlzZDlyWWR3TzFzOE4zYjVXbnpucHVOQW43MVczU0hZTWxkcm53UTZtZktm?=
 =?utf-8?B?N0RUSlhnVm42aFB1ZTd5MXZ5Um9NZUhpc3kvV2hROWhjZldFbzNKWlhGT25s?=
 =?utf-8?B?aXBpejNsZW5HMURvdjNSb1lIMDBrUkRXSEpWS3NrK244MlhjMUtTRWpGOXlL?=
 =?utf-8?B?MTE2WFcyaHBqTDBQS1BvUnpHRHkwK1NVN081bS9CaHNwdG1pZ2dPYW82R2dD?=
 =?utf-8?B?RlJ3aGxpN2FSSTNacUhLRzlFZUE5NUxaRi9KeG9QL1Q1aEFGV3BlSXVpR09P?=
 =?utf-8?B?ZUNUZjVOUlVNTGs0VURSbVFxRFhzZUpSVG82T3I5TnJvZDRnSlJubzVZU2FZ?=
 =?utf-8?B?eG1DbUw1aUNUV0ltdjVOWlNoZktpSGV1ajZZTnc2VStRNGFNQjk0WHdyWmVs?=
 =?utf-8?B?Zkhjd1hucDNYTCtMUEd0SmxOZ0tveVJ2ZFBHblZXd00vVXhIbEdGeU9udmcv?=
 =?utf-8?B?WVFVbEJIZnhJWE5vMHVsZG95eTc2Y3Bmbm9RNUtRYTVjdk9zNjFhaGR3aHFu?=
 =?utf-8?B?bnBISUZONHJZWXdiUVp1OWZuWndvSUFpN1FpUWZSL1NqSEZ4SXg1NDFkRUdy?=
 =?utf-8?B?REdjbE9yZy9PalpWUFNUYXpjd01RZVMvUU40TEFjOWwvbGR3czhyN2N6MTcr?=
 =?utf-8?B?cjloV1JkN0xISzRSNi95b3p4MDJhcEwxaGM5WUpFTE5uR2o1U01pSE5SVy9w?=
 =?utf-8?B?TE5tR2hFVS9XalM4V2hHd0tIaDJPcEtIUUU4WkVtbGJJWll6ZE1CdE96NjVC?=
 =?utf-8?B?Ri9NOWV1Wml2MHBlNXFmU0ExWnNobHkrSGN4dlg2WThJdGU4WVpjQnZDT0E2?=
 =?utf-8?B?Rk93dW5PRkQ0MzF2V0RNaXIzbkpKZk0yVzFxbWV6ZnJHZWdiK1llN3pvQmpO?=
 =?utf-8?B?MnNGRTllanpyQmVwbnd4NzMxRzRJRGwzRXNWTTBzaDBKVTRCTzRZTnpwNnJj?=
 =?utf-8?B?NUM2NFhFeHBQZVVPZU9GSEp4dXZ2ZGdRL2xOYXhwTjdPZXBYN3loR2hNdzhS?=
 =?utf-8?B?SzdXMmFlUUtsdkFuczNSdFVrb0NpSEE0YlhMMWtpcFE0b1VKN3pzRWpnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Wk5nc2kzT1h2Y0JTQlIwZ0tnR2FXQnBWOGlRY052dHdyWTYyenk5ZU5kbllN?=
 =?utf-8?B?d2hYcmdtQS90WktDT0k0RU96aTA1NDJ0Y2pQMmRtYk8wK0JIVzZzb3A1VFBh?=
 =?utf-8?B?dEo3VzkybGFLZFNTTmpycTBZU3doMktoT0VQdk9NMlNybUpaeUFhY2xYQTJN?=
 =?utf-8?B?VUxFQUZEVEtsS3gvOUZxVXJlSUNIbzNTdnpubFZFWm1tRmtJYzdOelBFRVFw?=
 =?utf-8?B?L2RKL3RBSmNCUm16OGJtY2lVa1RZMDZ2ejNwL2lxbTlwbG5JMUFlNE11OWRy?=
 =?utf-8?B?cWIrWmlVZEtrMUdnYTJONjhKa2M4b3o4aDhBTW01MVZHUlZ0N0k4VGNmZ3c4?=
 =?utf-8?B?Qm91NHVIT2ZYdGxXdXhvSTcyaGlLWFFyeGtTYmN2emFzWHhYTC81cklWSDJL?=
 =?utf-8?B?S2Rhd3VUT3IwYzJHL2tCbjVmZno5TC8xZk1Ddi9jN1FiUDVFblhzdzRNa2k1?=
 =?utf-8?B?YUFBcGtiazU5MjZVOHpPNmdBZjY2b0RoMDV2cE1zSWMzV3krRy9wVXJvUUtj?=
 =?utf-8?B?L2E2U3NTRGdKdUVpazNHaTRxUENpUiszdU9mUmpsNDc0L3YwUm13ZTZVN0Y4?=
 =?utf-8?B?WGIxaG0wQmRESTQwQWIvblNvaXVnaHQrQytBTFNEZSthNGxJUXNXajI3bjR2?=
 =?utf-8?B?TDRtRUh1WGxZbHVBQjdHTnV1RVZFbnhGbVNiejk1Z2hDaXdPMkRUbUptS0sw?=
 =?utf-8?B?Y3pEMXdrWnhEa2Y2ZW1kRkFGUlZoZkQybTNZVHQ0TXdvdHhPUWFOYkxqNkpp?=
 =?utf-8?B?MFJBcnVmTmEyeFBCcVVJVVlmL00vdngyanQxNzFaZ3lIQVpGTHJ3bnplbDlR?=
 =?utf-8?B?SEdQQUNWNkJSNlg2aUlmeGRMdU10dTRXZTludlRLVmx3bWlDcWM2cytHeHkv?=
 =?utf-8?B?aWQ0U0tVNnQ5dkZ1S0RNUkpVMkpMMEEyVDBtWmFIcTFoOWxpWGl6YkxDT0U3?=
 =?utf-8?B?SXNCMlJqNXM3QlFWMWI5QlExL2tFYU9EamYrdG14Q0ZnUXB4NFFraU0rb3Vh?=
 =?utf-8?B?ZXdURE4rTXdPQW85ODhOZXVGVDU1MndjNkRTQkRMZ1UrbU1XZ1FVeHVVczZi?=
 =?utf-8?B?MFhFYzgwRU15UC9MYmZrWHp2cDRnTXNXREZGZU5UMWs4czd5Vy9jcG1WVlFN?=
 =?utf-8?B?MFNqRFVKbWk5UDJ0bFV2amRRYlUxQ2l6b2ZONlQ3VldHVDk5cTh6eDlqWDAx?=
 =?utf-8?B?d3h1dFVud0J5T25zRW43YjI3bHhnNUVaOGpDTTNRMWFGOS9FYjVQay95S3NT?=
 =?utf-8?B?TS9oU0c4MzlZeGhhVXYwU2drYnNqeHUrT01aTVJ6MFFiUzlzeXlMRHlZcDdp?=
 =?utf-8?B?RG9iWDdIY1FKaWF4VTZicnQwTy9EenlEQ2FqRCtiUkdZNHpIWTFYQTJocGhV?=
 =?utf-8?B?R3Zha3E1cUprTDFUTmpzdGl0V3hua0RIdGF2d0p5SXVMRlpOMDBqNTdXYzR6?=
 =?utf-8?B?azZXL2pNbWg3R3E1Z0VTS0g1QVdoRTh6WTJIQjBwTzl5bjcyeEowQ1J0S2ow?=
 =?utf-8?B?VzMyeFhiVlg1U2JpbmVkdFdBeW52SUh2amc3NnRhb1NXdC9nVjZjQkxSbCtk?=
 =?utf-8?B?WmMwUEd0WEUxa2l2UTdQQ0dXTVhWbUhmaDc3cktYVmFxUzF2bnMvakNDVmtK?=
 =?utf-8?B?MWk5RUdISlFnczViK1IvbjNMMlIxcjdDOFlYL1pwS1ZqYzlHMVBobUxxWjlr?=
 =?utf-8?B?blJraXdXbkE4S2RwK01ZK2JXazRrcm4vYWpWRU9oUHlKdTZROVZOU042cXlq?=
 =?utf-8?B?cWpNUVVlUHhZYTNWckxGMU5IUm5SY3BZWWpPUXozMzgyZ0NURkJqekhKbTJT?=
 =?utf-8?B?Z0ZPVDNCZEZGTlRyMVZaSWE1M1dLbXRzVFNJUTI0V2hHVzBEMm1hdURYcHlW?=
 =?utf-8?B?LzhiTnNnblFGUkM1QlFPR3ZaQ2RUUXZIYzBTSUE5R0Z6bTZhdEZYcmFEMlo5?=
 =?utf-8?B?Ky9qYWZjZkJFbTgxaWthTHBZT2NuR25YQXV1eFoxOFp3eWw4MmFhaHNFVkVn?=
 =?utf-8?B?RE81dVdlZFNiV0FHbTNnRmRHUExydEFzMFQrZmtiRlBxQmNLL05RSDU2cVZp?=
 =?utf-8?B?VHoxWDNHUHRQMmdxWkl4NktsejlhSVlmWTFFNVJkNTRVRFBrTlgzbFpwZWxT?=
 =?utf-8?Q?P/cNWUO38YCrsFIb6gkbg7038?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 670f0e12-8aea-428f-29c5-08dc63b6c396
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 16:59:39.7826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dsln2HEwKomur53jnc7TmxdhF7ZoAf/drc1NmCLz/E4KhUHE/P8rFInXoVewr/Uc1arpelo27IYAO+JTIfYksQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8102

On 4/23/2024 00:33, Mika Westerberg wrote:
> On Mon, Apr 22, 2024 at 02:21:18PM -0500, Mario Limonciello wrote:
>> On 4/22/2024 14:17, Esther Shimanovich wrote:
>>> Thanks for the explanation! I still don't fully understand how that
>>> would work for my use case.
>>>
>>> Perhaps it would be better for me to describe the case I am trying to
>>> protect against.
>>>
>>> To rehash, this quirk was written for devices with discrete
>>> Thunderbolt controllers.
>>>
>>> For example,
>>> CometLake_CPU -> AlpineRidge_Chip -> USB-C Port
>>> This device has the ExternalFacingPort property in ACPI.
>>> My quirk relabels the Alpine Ridge chip as "fixed" and
>>> external-facing, so that devices attached to the USB-C port could be
>>> labeled as "removable"
>>>
>>> Let's say we have a TigerLake CPU, which has integrated
>>> Thunderbolt/USB4 capabilities:
>>>
>>> TigerLake_ThunderboltCPU -> USB-C Port
>>> This device also has the ExternalFacingPort property in ACPI and lacks
>>> the usb4-host-interface property in the ACPI.
>>>
>>> My worry is that someone could take an Alpine Ridge Chip Thunderbolt
>>> Dock and attach it to the TigerLake CPU
>>>
>>> TigerLake_ThunderboltCPU -> USB-C Port -> AlpineRidge_Dock
>>>
>>> If that were to happen, this quirk would incorrectly label the Alpine
>>> Ridge Dock as "fixed" instead of "removable".
>>>
>>> My thinking was that we could prevent this scenario from occurring if
>>> we filtered this quirk not to apply on CPU's like Tiger Lake, with
>>> integrated Thunderbolt/USB4 capabilities.
>>>
>>> ExternalFacingPort is found both on the Comet Lake ACPI and also on
>>> the Tiger Lake ACPI. So I can't use that to distinguish between CPUs
>>> which don't have integrated Thunderbolt, like Comet Lake, and CPUs
>>> with integrated Thunderbolt, like Tiger Lake.
>>>
>>> I am looking for something that can tell me if the device's Root Port
>>> has the Thunderbolt controller upstream to it or not.
>>> Is there anything like that?
>>> Or perhaps should I add a check which compares the name of the
>>> device's CPU with a list of CPUs that this quirk can be applied to?
>>> Or is there some way I can identify the Thunderbolt controller, then
>>> determine if it's upstream or downstream from the root port?
>>> Or are Alpine Ridge docks not something to worry about at all?
>>
>> My thought was once you have a device as untrusted, everything else
>> connected to it should "also" be untrusted.
> 
> I think what you are looking for is that anything behind a PCIe tunnel
> should not have this applied. IIRC the AMD GPU or some code there were
> going to add identification of "virtual" links to the bandwidth
> calculation functionality.
> 
> @Mario, do you remember if this was done already and if that could maybe
> be re-used here?

Yeah there was a series that I worked on a few spins a while back 
specifically in the context of eGPUs to identify virtual links and take 
them out of bandwidth calculations.

It didn't get merged, I recall it got stalled on various feedback and I 
didn't dust it off because the series also did prompt discussions about 
the reasoning that amdgpu was doing this in the first place.  It turned 
out to be a bad assumption in the code and I instead made a change to 
amdgpu to not look at the whole topology but just the link partner 
(466a7d115326ece682c2b60d1c77d1d0b9010b4f if anyone is curious).

> 
> The other way I think is something like this:
> 
>    - If it does not have "usb4-host-interface" property (or behind a port
>      that has that). These are all tunneled (e.g virtual).
> 
>    - It is directly connected to a PCIe root port with
>      "ExternalFacingPort" and it has sibling device that is "Thunderbolt
>      NHI". This is because you can only have "NHI" on a host router
>      according to the USB4 spec.
> 
> I may be forgetting something though.


