Return-Path: <linux-pci+bounces-8997-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C56190F675
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 20:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB2AA28792D
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 18:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC62158DB4;
	Wed, 19 Jun 2024 18:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BI2a+L1E"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BC3158D96;
	Wed, 19 Jun 2024 18:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718822812; cv=fail; b=hLcDr2MA5JmQIptGWBI0VSrdnwyBmym+vNwbwWsKKColdTATR3Ww/E/i+F9nL9cMWb4avEAT/UP3obfqPd4q/2YFTyY++7MPy9esZhvzeA41Ez7XJCoKgVHJWR9MsmQiDmt3Wk0BTtmHcTUdcH1RpKWLdRetXTfkvXt+ob1raZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718822812; c=relaxed/simple;
	bh=UEVKuzMOTSIgMg75YyuTMpF7m+F5rMtiXuN27d5VDGY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AhkPZVjWiV6h1nFnUDrS4bS2UvckrtaRnNRm4XIE4HeK0jPpcVn1L3aHtk5RlknFXiZs/8e/hfCJucMtS7uceJv1wCvfxhL2Rae9l2GymtUy0kFBCCBbBt0EDDX7mi02+zeJmmwqRXqpXN5/Y97eseAbvsTYGXWTRWRJk9SgL00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BI2a+L1E; arc=fail smtp.client-ip=40.107.223.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GWYyVToVVO+fJJoQ9IGJI4+NrLye3Im5EPyQqJBducpK3ibKB5H7GWEE9iyKMjBglRbunvf+lcpkyGwNLHRt2V7y56YGd+C9PJuyhRnSNMNSmRMfOtrdermjwEnqIAdJfblyy9XRbdZHw2X47/iFBtZPgk3ox8HjdP8WrmSeaYAKmGcCT2iuKv5L8GcZXJSAGs90RqfZuZnayJXQJ603PB957fn5YM6LKoKwao7mNj1tEPaczn59gmwlnSc09YT9T9l8kS0pIcaXY0TL6/uSIFnt2G8FZO+8fgCOaRV77GX8/VYOVAPB87J9gR+rz8CkcVOR3C1Trv6+F5dglPbtnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=58xSmLYImsdZ6NEqFTyAXO6S5YrcdVwYPqJvixz7H8M=;
 b=ZiG5oi9r5WADEYZciIIVjAyqnQ+sE76kOT3EQ+AFWbGJVv6iCyM+hG+jy8M1Jey4M8uL9KQSWsWMbcW7UNCe3U45gbVP4aCCLbqnbNcbJ0PbrNB6/H1HoUSYwAB6alucLMNl5zaVfe6n2okYenZkP+AoQpPTEbecXy2A3Nq/ECBm4twKAQPVU5PG8pbaQmHKzlOOMVYugOkvM9r/nY4h7HlesMtNRzzGXNqTaVikFX/OJwSwLCN+7oMXSFbj8YJc0xQ/f78jgFnPy/9GeS/fTlUYC5f1oHplpaijm9Thh3vrHXXGTkQbl3XD8Agl4l2KpKZn+GAqmUl+jJTcVtegKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58xSmLYImsdZ6NEqFTyAXO6S5YrcdVwYPqJvixz7H8M=;
 b=BI2a+L1E40ULoULUI0DOqIr6rwOKaCGpjvsnLHkr2v2+/XPqheJ3/5h44BgcM5Z4aktnqlv4NJFIlxPStgYhp/COUFJ/VP89UOGgvmvnBXNX/WXCu5vrUY3HZuVd10VjTbqw3R+V88ePLh6A2crye3b72tEWb41Bb1tXe2zVXb8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW4PR12MB6729.namprd12.prod.outlook.com (2603:10b6:303:1ed::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Wed, 19 Jun
 2024 18:46:46 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.7677.030; Wed, 19 Jun 2024
 18:46:46 +0000
Message-ID: <cc2c3589-6121-4ea9-9778-945be006086e@amd.com>
Date: Wed, 19 Jun 2024 13:46:43 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] PCI: Verify functions currently in D3cold have
 entered D0
To: Markus Elfring <Markus.Elfring@web.de>, linux-pci@vger.kernel.org,
 linux-usb@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mathias Nyman <mathias.nyman@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Daniel Drake <drake@endlessos.org>,
 Gary Li <Gary.Li@amd.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
References: <20240613054204.5850-3-mario.limonciello@amd.com>
 <053f4c3b-6eb4-43cc-b424-e91c047c90d5@web.de>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <053f4c3b-6eb4-43cc-b424-e91c047c90d5@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR04CA0093.namprd04.prod.outlook.com
 (2603:10b6:805:f2::34) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW4PR12MB6729:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bf145ef-2626-4ed2-cd33-08dc90902ba8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|1800799021|376011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WXJzZ0RWWVVPck5xZVRHdngwKzl3OGd4eFpoaVdhcm56T21VbEhuZW1hTFl6?=
 =?utf-8?B?a1EzRE1MR21Qdi9VaTAxdWplZmhMd0FVNlBNNzErT0NjUTQrMXZUWG5ZL2Fq?=
 =?utf-8?B?aTJzaXF2UGxERy9YVEVPRldYYlBjbHlqVVM4a2hrcTVlNHNiMVFXNjZMRDZm?=
 =?utf-8?B?ZXZEOEFzTVJNRGVZdFF0TnUwVXdBOGVBR1N3M0Z6RU5vWXlIcHZLaHNEZnJP?=
 =?utf-8?B?dkFWUHl4U0RlQTVpekkzVlVQNVdyS1JlajhscVhSbnZXSHJaekFTT1QybVRy?=
 =?utf-8?B?ZFhDcjgzTCtmWVNaU1Vyd29IYk1xeWg4a2hPU1gvdWhrdE9zc2FZQWZZakZR?=
 =?utf-8?B?bjVLNEpFa05ZOW5BSXNhS04vc0hKK0xhUVRiR0V3eVhLV0FhRHdGRDBCSzhB?=
 =?utf-8?B?WGtwdWVaL0NDU1hVbzdBcGZTR093dytYZzk3WXA5U0VOMCtsZ2NVMlBaRGRo?=
 =?utf-8?B?VmRabW04eTZsc0hNOS9YL1FkWUdQdDZIVWhMa2xxUDdZMjdvTm4rbEJSREwy?=
 =?utf-8?B?WXl0d0NQV3VpVmhOdmR5Y0xLVkdTSjVERWhxa1FPcEV4c2l5anF0T28zRkpT?=
 =?utf-8?B?blNPWkk0cXBnWm1ndVBXZG5jN281WmtlL2QvaXJNRXNxYm9ZYjA1Yjgranh1?=
 =?utf-8?B?MmlkdWhKbTU5YUh3bDVBMi83NDhzZVhaZnhFOThFM3N3OEo0MC93NXV4SzZa?=
 =?utf-8?B?cjZBeFBJYThseHNpVERNZmtocEtBWUpmRTY1Syt2N2ZEWnVMbzBRY09POWpM?=
 =?utf-8?B?em1jQ1BMZjQ4alNoZ3RNQ2liRk1XUmdRTWJmRDR0QWJRbHBLRjA1czArNjU3?=
 =?utf-8?B?YWQ0R3M0M1FNMEZvdHZTazNnTFZ5c2grT1JVMjZLQms0NDBSVWJzbStaMkhY?=
 =?utf-8?B?NXFKYTgyblVCQXc2NFlVbTYvdGh4VTJIN1NjWUZ6K2lzSWx4ODZSNTc3eXRs?=
 =?utf-8?B?SnhGMXdVMGRSQ2xYTE45cWdSbnFGZ0RSVWd1aU5La2NoSzdJZXZpUEszbEJG?=
 =?utf-8?B?c1o5TWZoZWxRVC9DTm8vanhpVE9TL3F3aXc1UmdnNDR3Vk1lZXRMZXVqcjFa?=
 =?utf-8?B?bEFrL0Z2WDMrUVFjMmk2WFczWUU2VTlPWXpEUEFTcndHVTErZC9qd0l6ekRk?=
 =?utf-8?B?cXpKUG8xMkVKWVlSSnZvdmxvUk1lQkp4dEJCRW1kNGc1RVllRmxHSE14T0du?=
 =?utf-8?B?UG85VTB5bmorZnFYbEV6QS9FZGFuN1M2Ylc1ZVVSaGh3NDFCQUdOdU5ZS0tp?=
 =?utf-8?B?eDZNZVRHMjA4MGloMVovdUFpOGw5V3VDdVRBT1ZGSHhvSzlaTU1Bb1F3bkZl?=
 =?utf-8?B?V3VoUDdieHlsM09UK3lseDgyNUcwZHhsWUN3RDVIVk5XSFVud2ErQmlISHRz?=
 =?utf-8?B?ZEJXTTBTYVZDVTFSZWdEUllFdTFWcENCQzR2K2hRYjhpZ3RuUW9XWXgwa3FR?=
 =?utf-8?B?U1FRM1hHRjlrSzRNZUxxVXUvT2lyeTNwcWVvTE9TQVFkaFlSQno3dUluZ3JP?=
 =?utf-8?B?amdkZ084bzJlYmJDdzUzTlRrT094TXdqaWpaMitQU3FkdGNmMVR0TjRtR1NM?=
 =?utf-8?B?aDJNc09zSndOL2xOdEFBK0lOUkEvRnhnTHdieGRHdE96bnN6VDNiNWp1M096?=
 =?utf-8?B?MHJldzhiWlBodW1ZS3EwQUVvNER6ZUQ5cHB5VndMbDlULzZNVXJublh1Uzkr?=
 =?utf-8?B?NlYrL1g3cXA5UnlvWFNsTVpXeUNpZmdWbCtNbU5XMm5Fek9FZDkvMUl1cWd1?=
 =?utf-8?Q?l3kZ2f0KqyZkmkW2Zm3eo0XKjNsh7a2v+8+fGkl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(1800799021)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VFFCQi93SDFRenFUYkpxNnRTSGZweTl5OVA0SHkxWk9PYm9OckhrQ1VVOW1V?=
 =?utf-8?B?ZUZJTlpENXhMTU9NNUFRSWpLbkRRMUZncU5BVzI0cW84RVpkK3lhaERXa2Jt?=
 =?utf-8?B?K1orV2tldWEwRzB0bHVpeDFMUFF3R3pib08rUm1pK21IMFUwSTdyd2V6OG5j?=
 =?utf-8?B?ZStDZTF1dVJiNnAyUVNyNEVURDhFb1FVSXNjSk9rMzlkNjhKODZCOTZDQ1lL?=
 =?utf-8?B?T0ZGUU1od1M1Q0V0R0NtenpWU1lNaFZNVUozOE5XMjFBRVJZZGZuRDVqclg0?=
 =?utf-8?B?cEZ3aDBZNjd3UnZSdUdhUWNzN1pzakxFOEdnQUV0VTdNZytvWVN6YzNrYVpZ?=
 =?utf-8?B?MENEaVBsY0xwRkdxWDR3QThnbG1vNnVCRWV5RlJhS1dZVCtVS2dlS3NWdVlZ?=
 =?utf-8?B?MkpOMDRnb3FtUXk2NG9kRkcvWGROVERLSFhSWkN6UDlXaHNIcitNQWFLYk04?=
 =?utf-8?B?akY3UXErQTNBR0l0a3RINXZRclJPdG0yamZreVJjbFR6K1J2UndCcGdHbmpM?=
 =?utf-8?B?TmdHb282VE5wN3picnBKaVYvMENYZEFNQmZZaFFpVTAwTDlRZTk2eVVsTjRm?=
 =?utf-8?B?T05NMXcrQjBMcEJhNE8rR2NhdDdRL0oyNlRKbVZvRzdxSHlFUmdDQnNsQUNP?=
 =?utf-8?B?NUJucnkwRUZCOU54NHQ2T0MwN1F4UUFkb24xekVMU3FWdWM5TUVVMzdDT1gv?=
 =?utf-8?B?cmxTVERvbUhaVGdFMDhydmdZRkp5TVUyZmM5U09xcU1LQ3hOckl3TjhIdEhI?=
 =?utf-8?B?Umc5U3JaTEJQQ1ZXSW0zdjRjVGM3UnRwN3dPcVJ6U2p2cVMrZWxWamJWYnlR?=
 =?utf-8?B?TXJ3Wm1pazM2cW1WcU1SS3k5aHBFRHN1eW5NWFN3ZWh2Z3dHczBOZGxUVllR?=
 =?utf-8?B?d2lnV25KTG9wZTFIOEN4V0pyZGZoNUV3QzNFd0p3UkR1eFRIbUpGdks3VGxm?=
 =?utf-8?B?LzdTeGpLanFWRGUvYmdUangwN1E1azlsbkwyOVpTUVJpck4vWm5UQk14VHVs?=
 =?utf-8?B?Nnh1MllHYVRSbXRtTWFEczNJcXU3S09oMnVpZlMyYXJwRmZ2bmtacTF6QzNQ?=
 =?utf-8?B?eVdoL3B2VXpzSmVSenNZdnVLWDkxekdiRDBmdlh5SmczUytyK1BVTE0xQUVT?=
 =?utf-8?B?azdaVVhYNzkrMVd6MGg3VmZ5K3VLYThKdzRFR09VanlxMmpkTEpGU3k3clhU?=
 =?utf-8?B?bHFBSUFVUVJuNjlhL1E0dzZKU0UwQisrNFJ4U25PaHNYQ29QdmRZOUNLaHUz?=
 =?utf-8?B?cVpETHpNSStvZGpOMUY1YUIyUGVJUUJ1VWdicUM2NXl1QVhMejhlbmovNkZN?=
 =?utf-8?B?ZlJyV2hjV2VhS3J0c2FOUnozZ3ZxSVRtelgxRXZjL28vWUpoRmdkOTIxNW1O?=
 =?utf-8?B?Qm5qWDgzQW8xSXBjRWQvYnJTbENMRDlFZ1c4SW93WGFGN1RVY3h3UXNqQXJQ?=
 =?utf-8?B?ZnRQVENFcHk2WllvS096cGhRMGVzTEU3QXhpWFZKMGJxM25FN2VXK2Mvc0pC?=
 =?utf-8?B?UEhmaHlxMStEWUNVUzJwaU9xdzRkd2o1STNBTytOMjV1RUtsQVFucFl2NDhv?=
 =?utf-8?B?UXVPL0p4ZEdzeXEydlBSSHpMcm5zTy9WeHZkYzVmTE1ScWxjcHNiVzRncFFL?=
 =?utf-8?B?TUZEUFNlR3lkT2x0OUl2cEZlWEVVTkhCN0ZlRUxGNElvelMwWkJiMnNEM3lL?=
 =?utf-8?B?Mi9aN0F6YVdaSXZEeDlaRE1ScHZ4R0JXS3dyNVBBVkpYc1ZlSkk0dEpreVZ6?=
 =?utf-8?B?SzZvcTA0N2xIQTUwYVk2bzhhWjd6QStOakZtbk9Pa0FaMW5LUFluU0NQa0hk?=
 =?utf-8?B?WER5aGZabWxVeW9zWnhlUStHenlDd050bGgxQXZpaktZK2dHVlBkZzdEZVg5?=
 =?utf-8?B?aWozNlJXcWRxQmoyU3BELzVib0R0MTllaUxVUElSN1Q2Q2NBRnU4NDA2ZTVw?=
 =?utf-8?B?bWZRVklmeHl3QmxPZDNENHRDYTlZM0xkbU9pSXJQMElKRUJRY205b3VoSUx4?=
 =?utf-8?B?bndtaXg4aWZkNmVMaCtxYjc2MFVvYmxzY2VCckVhZ3RQWWJwdEE5LzM4WkZO?=
 =?utf-8?B?RmRxMnBISUFvVS9TYy9JQU43STd1dXJuQ3c5Q00zWnRoRXVpSmYxSENLOEcw?=
 =?utf-8?Q?Gu2N7+77oAu6XgBpxIPok6JJ2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bf145ef-2626-4ed2-cd33-08dc90902ba8
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 18:46:46.3338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0VHQhzH11eqcPV2B6ox8FO8zixIqrvAoqh6CcPRohIA5nFO+HPFVwTQ6/32zzGIaafyjmZIWL/R5Jk+8c49s5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6729

On 6/19/2024 13:45, Markus Elfring wrote:
> …
>> As PCIe r6.0 sec 5.8 specifies that the device will have gone
>> through a conventional reset it may take some time for the
>> device to be ready.
>>
>> Wait up to 1 sec as specified in PCIe r6.0 sec 6.6.1 for a device
>> in D3cold to return to D0.
> 
> Would you like to add the tag “Fixes” accordingly?
> 
> Regards,
> Markus

The first patch is a strong dependency for this to work, and if we don't
bring the first patch back automatically we shouldn't do this one.

