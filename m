Return-Path: <linux-pci+bounces-13251-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEDC97A8B4
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2024 23:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D78E81C21180
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2024 21:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D86413EFFB;
	Mon, 16 Sep 2024 21:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YoFNN2lx"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9855313CFB6;
	Mon, 16 Sep 2024 21:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726521912; cv=fail; b=VbPqy2jbR9gY9fphEi0hlT8qUYhqbxXlqv+4jD01IBlX5AcUEc+XePJtJ8cUGY23lr5K1M4q8mZEyN62cRM2lomEon0nBDw5st5UEvkl2H7KFo9EEQR9rFTr5lCXKkWYEd/bx5ytYEXlNU3zAIWQl2zz+5kmKoYNJHIYfewz/6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726521912; c=relaxed/simple;
	bh=VFRz0n0Z9bPQ7xp/4dB6hTff72waOSnWSQrdwzN1ZpA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HUeoPmusnzoqhU6W8HoUzBLx6ZPUxnZpxNrtpeetUx6Mj3LndqYD7bmaqxa8nijPmsQGE+tyDx6dArEA5nlg7sxpxLhb95k05r7Hfge16mYnvAbFG3iWMiXLG9BusCU6GT3i6mjmaTH91yLSKgFP7GjeMO2GeMlk4KamUMgP9F4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YoFNN2lx; arc=fail smtp.client-ip=40.107.92.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B/RJtVG3QwL0cacLKa15BvuPPgUvenzV7NxHvZSBYwt+lKeRxoo/cGTYhS8JMMgzjE94XAj18oPZaNoRf6YLFoPIl1X97QYbhQSpBbq0KqNeFmsDmrgs1W6Q7a/YzVC7JEKXC/Z3SEFS8op/I+FALlCz2Hs/dWRnPC9wjaHJ6S9MTeoZOlKZHHSstAo6hITYOJFkwzisu8FfG3Boxnp5DDJbvBTn4abY44wYKKw3sM+f2AABpTsmCtHJCF5Ug5qfr4XlZ6fHvGKWc/xMIX+5rfdoQP2Je3c9IXLAGBQNu4yLENAFcWyYyaDHKYW7fhDWJIuTgle/7MPwruO4eZRffA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VnFgFWPqrh7XZ5/7JxUuQeJ0oNh4Lx6cYs1POpmWcYw=;
 b=S9n1mfUJzAlIvq2oMl4/d4LrRsmMuoYvb1veuoCU3mSRguOCHuO7VR1CIPaFvvevmwa0Ms7JFwjUpc74xir5hWLZL0i4OzXRXIchaIfBTem4xcJB1+3wbdwf/RMg6U+DVZVhiTNU9zhM4c7uXaMNrXMKuH7ehHlx33b+UjEVV+IcibaKKuEs/UvucQFRUpSKdQ6sA0dCu8utfM5m/FB/k+rA3ekam1c9iZ/oK0PoRsC7qcm7h2mTw2FaOR8Mjpf+AWZT4G0BCKVQqRWiFvQkn4mKoPZsb9DpkLkVHR8PhuEssD0v1aWCLBfUl/5z7Jmm6JcS9hYrlqVy2YD4e0V+NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VnFgFWPqrh7XZ5/7JxUuQeJ0oNh4Lx6cYs1POpmWcYw=;
 b=YoFNN2lx/hjjDx2FIcgGGrhJPZ8uxTM37WMALa9iJ8yM7q0fXviJqEM+t82517uz/Aw1FllE9wrU0mVONQfn5eFpiZL8pncha+PMhdTZoNFTgTxnCnaI9oPabuqN0V+RaP8ICD1rNRY25AJj9Oz1k75Qtjwy1M2L8QExny7520U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4877.namprd12.prod.outlook.com (2603:10b6:5:1bb::24)
 by SA0PR12MB4399.namprd12.prod.outlook.com (2603:10b6:806:98::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Mon, 16 Sep
 2024 21:25:07 +0000
Received: from DM6PR12MB4877.namprd12.prod.outlook.com
 ([fe80::92ad:22ff:bff2:d475]) by DM6PR12MB4877.namprd12.prod.outlook.com
 ([fe80::92ad:22ff:bff2:d475%5]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 21:25:07 +0000
Message-ID: <69110d07-4d6a-4b7f-9ee1-65959ebd6de7@amd.com>
Date: Mon, 16 Sep 2024 16:25:03 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 4/5] bnxt_en: Add TPH support in BNXT driver
To: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, netdev@vger.kernel.org
Cc: Jonathan.Cameron@Huawei.com, helgaas@kernel.org, corbet@lwn.net,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, alex.williamson@redhat.com, gospo@broadcom.com,
 michael.chan@broadcom.com, ajit.khaparde@broadcom.com,
 somnath.kotur@broadcom.com, andrew.gospodarek@broadcom.com,
 manoj.panicker2@amd.com, Eric.VanTassell@amd.com, vadim.fedorenko@linux.dev,
 horms@kernel.org, bagasdotme@gmail.com, bhelgaas@google.com,
 lukas@wunner.de, paul.e.luse@intel.com, jing2.liu@intel.com
References: <20240916205103.3882081-1-wei.huang2@amd.com>
 <20240916205103.3882081-5-wei.huang2@amd.com>
From: Wei Huang <wei.huang2@amd.com>
Content-Language: en-US
In-Reply-To: <20240916205103.3882081-5-wei.huang2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P220CA0028.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::33) To DM6PR12MB4877.namprd12.prod.outlook.com
 (2603:10b6:5:1bb::24)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4877:EE_|SA0PR12MB4399:EE_
X-MS-Office365-Filtering-Correlation-Id: ee26a355-9afa-47fd-94b7-08dcd69609a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TXFXMEhOdnAzWnd3KzFVNlFpLy9qK1g3QzMyOTYyNE12MUxUcENZdFlTdDF6?=
 =?utf-8?B?L3F0VnpLdGMzaitoVXR6QlZpc21ZS1hOYUhTdElRMEJWdXk5OVdlQWN1c2h2?=
 =?utf-8?B?QUZPbnNaVDF0TmhKeHFpWnhEci92elJsRHErZnIxUkQxSitSTEpFQTZmVm1q?=
 =?utf-8?B?TE4ydlFmdmFPR083WFJDRU4wKzdOQmlMaGZZR1IrUlRXcWtmTkR2aGg2ZEJN?=
 =?utf-8?B?d0QrbHVPMU9mZDIrZlFBcHJuY2wraWE2N0dIZkppcFhMTmZlamV2VTNQbmxP?=
 =?utf-8?B?aTV0aUlKa3p0K2Ftblg3Skx2OUdzMlRBbXJ2QWRqWDRtVjYzZWFUbmV3SkN5?=
 =?utf-8?B?UjFiMWNYaEVuNmU5aVFaOHVUeFhSam14SjBmUEFGajNxNXhNQjIvY3hrV1gr?=
 =?utf-8?B?ZFl2UUxHOTJrSHlPTC8yYUpMNjhIdlFRUlJaL09jNWgxMWZ0TWRaNUM2d1JS?=
 =?utf-8?B?aWxvMlNMUi9yK2luYlIyMGR6T0laeEJlWHlic3BkTmJwV1h1TjhYYW1SbVRT?=
 =?utf-8?B?WGExZjFTSVBlVlJFTzlwL1VxK2xxaEF4Z2lxcVprc2hLZmZ0T3dkNlNxMXJq?=
 =?utf-8?B?Y3R6WkMycXBEUFhlOUorUkY1OCtUZGY2Y0Z0d0pqUUo3aHQxRTZIN24wa3Zl?=
 =?utf-8?B?NHZOaVZvQ2xJWllDN3JvWmdiUUhONDFTSWl0UkkwemhjZ1JIUHdVNm5uT3NK?=
 =?utf-8?B?TG1ISnZwTFFiZU5vZFZ5SkxHNjQ1NG83T3NRZDNDZzY1eHJJQUg0WWtHQ0Fo?=
 =?utf-8?B?RWYveU1DTmlTK0xua1VBQ25TQVR0QVA5QjYvMCs1U2tMQTMzVWRBZFJnOVQx?=
 =?utf-8?B?Qk5Vc2gzbElPK1p3U0FteTlzY2hJREpWNkd0N292VUZ1YUR3YjljTWVrYVhI?=
 =?utf-8?B?OGNXb0pZaWVwSUUzclRWbzZqeko1NjJrQTJGYzhNK3o0bGdwVHRHN2VpTHIr?=
 =?utf-8?B?cE1sNm15V1V0KzdKWE43ZDBpcUZKcW5wbUVDSnAzS1pNT1pJRDRSczZ5a3I3?=
 =?utf-8?B?VFlDTHp6MWlRcHFMZjJueE5WeW9PTFJkakx0b2dXcFZDaHR4TFFSeHJUNC9R?=
 =?utf-8?B?bjc5TE5WU1ZCanN0SXg0bEVSL1UwNkh6VUFUbDRhUG5HUTMvSnNQb1VkYTVn?=
 =?utf-8?B?TytOOUxHSWxqRGhicFpoSGUrc3VRelRmdTF1VkxpeW1iUG05RFRLbkMrK3Zt?=
 =?utf-8?B?LzVzTEFHcU5jeE0rMXpkUWpZK1AxQVNWUWNNdGozKzQwNGJnU0pTMk5zV29N?=
 =?utf-8?B?eDZLV1BscW82OHorYXVXUWhIaHlwVGVHbEoxUE1CMFJPNVRVQlpOQVI1bGZW?=
 =?utf-8?B?ZVJaTHZ1d1hTaHJoaHkxMlF1SHJhQUt5Q2RrakJtVU92cUg0LzJGdWZCaWRD?=
 =?utf-8?B?L1JmZkdGY3VWZksrcGU1Snd5M2crTzlxczN6ZzViYnBHR3laNkpEVmNuMkxX?=
 =?utf-8?B?TXIrc0ViOEs3NTdtNDFJUUZDQWl2cGhQNzZvT29ZNlYwRnZLK3h4eEMwa05U?=
 =?utf-8?B?QTJsL3dOYXQzM2EwMVh0RFRQNVl6MkR5WTJHaXNaZDh0VmtaSlpQUTgzd2Zw?=
 =?utf-8?B?NnlIVjdQQTVodSttMHRQbTRKczZuZHVYNkJvMGxrQ1FoUXBJR2ZDQ0ptb3ds?=
 =?utf-8?B?ZUl3SnFTQnVJV0czQ3R0UEZyWXcxMGVYMG5XVUl5UUJDMllWYlQxdG5xTHJC?=
 =?utf-8?B?cUQ4OWRjbHFSMWZuRVVDaWRSODdhUGpjOThqNjRKUFdpcGVCNzBCZU9qcnZz?=
 =?utf-8?B?MndxTFZlMUZpRkJybng1MVdhS0hhUmQxc0l0aHBaOVFGNVN5TGhrMytmMlgz?=
 =?utf-8?B?T2hFcWZ1ZmlGeEtmZkx1UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4877.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RU9NRlpBampwcEp4U0NrWlNSS3l6UXlDWis3bjhqalZSUXkza2FEL09wNHpS?=
 =?utf-8?B?UjIxTkV2amhaWE9KS0RhV2dxUHIvK1hVQ0o0Q0wrN1pJZ2hlakU0eUJYdkZP?=
 =?utf-8?B?dFltb3YyeXEyNjBrZzNhOW13NUhPSW1RN1p5akNLb2dxejZxZWwveDYrYVpQ?=
 =?utf-8?B?RjFIOXJzYUxWMkowaUtTeXZWYTRGaXoyWnUrZmdkODlFYXV2SUdKM3p6K0ky?=
 =?utf-8?B?bVRTblFqWUViRmZXOW9pVFh6NkJLcm5YNHRmem1GcHJ1bHF4YlZhaytUTjZj?=
 =?utf-8?B?SkRDejFCMmNVeEwyVkZwNG1ZZWg4ZmYydXlIUUwrMzREVE9NTzVObmdnTnhQ?=
 =?utf-8?B?L20zOXJRR1lnU0UvNkxJbDNBcVRkU1ZxYjU3aWtRaFQxa28reVNhTDZtZS93?=
 =?utf-8?B?WjU0VFp2dG0vSmZOUGtiZEtxaTdnRnJ5SmJmUCsvNUwvLzNnQUIyN2xxUmNU?=
 =?utf-8?B?MTBRbGllazVHNmZJU2xtRXBweFdvT1BCVGVIUmt5U3h1QytKZDBTbWUrQ1dy?=
 =?utf-8?B?VkVBMVMxNThEZGpIZEJBTzZLUngvNkpmcWozY2RmZTV5WktFRUNQSEFpSW9I?=
 =?utf-8?B?bEdsUXJTNVhjeTIwZHVDRktiU3VBWkdQYmFpZXV6UGJJaWxVaXpxN3JrcURz?=
 =?utf-8?B?dlhFcG51aXVQeHBQejVSUWs3MnpZYzU5MUdhMHMyZWFlaGpUNUs2NnQvNXhW?=
 =?utf-8?B?M2xCQzE2azVjcTVvSUc1cnNIazkvU2xnWDZQc05zem1yV2dIMkx0ZWNKS3Zn?=
 =?utf-8?B?QzBscjJ4MVlyY2x3eFlwdzMzYnNhT2xTY1pwSDdyTTNLMGcvVFdJY2xlZ3dk?=
 =?utf-8?B?RGJpM2lSWWZXdE1FOXY2Nkhod1pwdXhyZkZjQ1B1ZlVBdWtLdWVzaXduMTF6?=
 =?utf-8?B?dTRteVRmQ1VqdWNPUTlyZkhWTys5cGpZVTA1d0hCK0gvem1wWDZlTFNJdlBF?=
 =?utf-8?B?aDhkMEt5alVZazVSQUdyb29kYXlWaXFndkk1VzBhWWkzRCswRDBhM2w1V3BM?=
 =?utf-8?B?bStDYUdyR3ZJNUptWW9NN1ZReEl6N0xQVVJuSmJYc3JOdFc5RHdhNGcyMkZp?=
 =?utf-8?B?ckhaRHJmUDRzSno5R21reWtncXQvRU03b3FrSjBNbm5BN3Z4ME1GdGhCSmwx?=
 =?utf-8?B?WWpjcXpUcDNOWmp3cDN0aDU2MFhaWDdtRFplRndGTjZ1dGttTVJtY2VGZ2Nn?=
 =?utf-8?B?YWs1djNTTmNSMFE5K2ZuVSsyb3B1UWVkL2t5eVBNRTZVR0dNaEprbWVoR3Z0?=
 =?utf-8?B?WXJhYVRzNGsra0VLYXhoanU3SU5jc0QyLzZkWDlhT04wMkRFeDZSL3BHeUxy?=
 =?utf-8?B?dGgzVllibURBaVA0VThNVFJiOHBWZnlOV2hTYW5yZHVvWEJYREFGS1pHOFQz?=
 =?utf-8?B?L01oNG4vMFAvUEgxL09BaEtNbUhHSWd1ZXZLUjcwcDFiN3BOditJcHpHVHNR?=
 =?utf-8?B?ZjhDQUdUWnRnV2Y3eHNiam96UkxjVkFKNlhDTzlhQlBucFNhYi9oYmpLT0dB?=
 =?utf-8?B?dnQvUkM4elA3Rk1UcU12azVYR3BmT1pTL0JZWWg3TGsrOU9SL1lhS21EVEFZ?=
 =?utf-8?B?TlRXRGFJaTdZNDU4R1NNa0E3Tm96M21rUW4xN09VNVJDUm9MNkQ1YzlKRElV?=
 =?utf-8?B?d1V2MWwrOTMrT0xwNUQrY1hWMXFRSWh4VjNrYlZLc1NSMW9oU3QxTkQrcjBH?=
 =?utf-8?B?dzN6d1U4NWgyckNyUlRtSkVmR090My9vaTZyZWJvbHBMd2VqTnNMVmlTcStE?=
 =?utf-8?B?WGlRcUNpdXFuVXBsRUJaYStkVVV6ZzdOUis5TlJ4dEl5bjRnQ1hQL3YxRjcr?=
 =?utf-8?B?ZnhxTWdld2lRMENGSjFRUFRybTJpa1ZEVUtLUFh0bFAwY1NRbEN3SHZWT21R?=
 =?utf-8?B?RDkzbS9VUnltVDhnRllYVGUxaGU1YUlSUGRudUl0dmFNOGhSbkpUR3pyOFgw?=
 =?utf-8?B?MXRGVkJZVSsrb3BtSjlBT2JsSjN2ME1CeVY5M0o5UzdMUzM4aU9RSW9OUkFY?=
 =?utf-8?B?c3RaSnF2dU8yUEw3YithMzVjLzBPaDVwenRib1krc0JjOW91N2VsZjI3SWM4?=
 =?utf-8?B?MTlJU2NGN2k4SmxpN2JWM0N2OWJVNG5hWG9raGJKMEUxV1U2S0FBaGlSOGZI?=
 =?utf-8?Q?ygkT1/9vQHZWZqHhBClIbiSTr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee26a355-9afa-47fd-94b7-08dcd69609a7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4877.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 21:25:07.6401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v4Om4qlDWx+2zRKeNPM6E3M6IM1JBY9nh4AewFIOosiqLm5v1R5nltU4TiWGhepd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4399

Hi Bjorn,

This patch can not be compiled directly on pci.git tree because it uses 
netdev_rx_queue_restart() per Broadcom's suggestion. This function was 
just merged to netdev last week.

How could we resolve this double depedency issue? Can you take the first 
three TPH patches after review and I will send the rest via netdev?

Thanks,
-Wei

On 9/16/24 3:51 PM, Wei Huang wrote:
> From: Manoj Panicker <manoj.panicker2@amd.com>
> 
> Implement TPH support in Broadcom BNXT device driver. The driver uses TPH
> functions to retrieve and configure the device's Steering Tags when its
> interrupt affinity is being changed. With appropriate firmware, we see
> sustancial memory bandwidth savings and other benefits using real network
> benchmarks.
> 
> Co-developed-by: Somnath Kotur <somnath.kotur@broadcom.com>
> Signed-off-by: Somnath Kotur <somnath.kotur@broadcom.com>
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Manoj Panicker <manoj.panicker2@amd.com>
> Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> ---
>   drivers/net/ethernet/broadcom/bnxt/bnxt.c | 85 +++++++++++++++++++++++
>   drivers/net/ethernet/broadcom/bnxt/bnxt.h |  7 ++
>   net/core/netdev_rx_queue.c                |  1 +
>   3 files changed, 93 insertions(+)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 6e422e24750a..ea0bd25d1efb 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -55,6 +55,8 @@
>   #include <net/page_pool/helpers.h>
>   #include <linux/align.h>
>   #include <net/netdev_queues.h>
> +#include <net/netdev_rx_queue.h>
> +#include <linux/pci-tph.h>
>   
>   #include "bnxt_hsi.h"
>   #include "bnxt.h"
> @@ -10865,6 +10867,63 @@ int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init)
>   	return 0;
>   }
>   
> +static void __bnxt_irq_affinity_notify(struct irq_affinity_notify *notify,
> +				       const cpumask_t *mask)
> +{
> +	struct bnxt_rx_ring_info *rxr;
> +	struct bnxt_irq *irq;
> +	u16 tag;
> +	int err;
> +
> +	irq = container_of(notify, struct bnxt_irq, affinity_notify);
> +	cpumask_copy(irq->cpu_mask, mask);
> +
> +	if (pcie_tph_get_cpu_st(irq->bp->pdev, TPH_MEM_TYPE_VM,
> +				cpumask_first(irq->cpu_mask), &tag))
> +		return;
> +
> +	if (pcie_tph_set_st_entry(irq->bp->pdev, irq->msix_nr, tag))
> +		return;
> +
> +	if (netif_running(irq->bp->dev)) {
> +		rxr = &irq->bp->rx_ring[irq->ring_nr];
> +		rtnl_lock();
> +		err = netdev_rx_queue_restart(irq->bp->dev, irq->ring_nr);
> +		if (err)
> +			netdev_err(irq->bp->dev,
> +				   "rx queue restart failed: err=%d\n", err);
> +		rtnl_unlock();
> +	}
> +}
> +
> +static void __bnxt_irq_affinity_release(struct kref __always_unused *ref)
> +{
> +}
> +
> +static void bnxt_release_irq_notifier(struct bnxt_irq *irq)
> +{
> +	irq_set_affinity_notifier(irq->vector, NULL);
> +}
> +
> +static void bnxt_register_irq_notifier(struct bnxt *bp, struct bnxt_irq *irq)
> +{
> +	struct irq_affinity_notify *notify;
> +
> +	/* Nothing to do if TPH is not enabled */
> +	if (!bp->tph_mode)
> +		return;
> +
> +	irq->bp = bp;
> +
> +	/* Register IRQ affinity notifier */
> +	notify = &irq->affinity_notify;
> +	notify->irq = irq->vector;
> +	notify->notify = __bnxt_irq_affinity_notify;
> +	notify->release = __bnxt_irq_affinity_release;
> +
> +	irq_set_affinity_notifier(irq->vector, notify);
> +}
> +
>   static void bnxt_free_irq(struct bnxt *bp)
>   {
>   	struct bnxt_irq *irq;
> @@ -10887,11 +10946,18 @@ static void bnxt_free_irq(struct bnxt *bp)
>   				free_cpumask_var(irq->cpu_mask);
>   				irq->have_cpumask = 0;
>   			}
> +
> +			bnxt_release_irq_notifier(irq);
> +
>   			free_irq(irq->vector, bp->bnapi[i]);
>   		}
>   
>   		irq->requested = 0;
>   	}
> +
> +	/* Disable TPH support */
> +	pcie_disable_tph(bp->pdev);
> +	bp->tph_mode = 0;
>   }
>   
>   static int bnxt_request_irq(struct bnxt *bp)
> @@ -10911,6 +10977,12 @@ static int bnxt_request_irq(struct bnxt *bp)
>   #ifdef CONFIG_RFS_ACCEL
>   	rmap = bp->dev->rx_cpu_rmap;
>   #endif
> +
> +	/* Enable TPH support as part of IRQ request */
> +	rc = pcie_enable_tph(bp->pdev, PCI_TPH_ST_IV_MODE);
> +	if (!rc)
> +		bp->tph_mode = PCI_TPH_ST_IV_MODE;
> +
>   	for (i = 0, j = 0; i < bp->cp_nr_rings; i++) {
>   		int map_idx = bnxt_cp_num_to_irq_num(bp, i);
>   		struct bnxt_irq *irq = &bp->irq_tbl[map_idx];
> @@ -10934,8 +11006,11 @@ static int bnxt_request_irq(struct bnxt *bp)
>   
>   		if (zalloc_cpumask_var(&irq->cpu_mask, GFP_KERNEL)) {
>   			int numa_node = dev_to_node(&bp->pdev->dev);
> +			u16 tag;
>   
>   			irq->have_cpumask = 1;
> +			irq->msix_nr = map_idx;
> +			irq->ring_nr = i;
>   			cpumask_set_cpu(cpumask_local_spread(i, numa_node),
>   					irq->cpu_mask);
>   			rc = irq_set_affinity_hint(irq->vector, irq->cpu_mask);
> @@ -10945,6 +11020,16 @@ static int bnxt_request_irq(struct bnxt *bp)
>   					    irq->vector);
>   				break;
>   			}
> +
> +			bnxt_register_irq_notifier(bp, irq);
> +
> +			/* Init ST table entry */
> +			if (pcie_tph_get_cpu_st(irq->bp->pdev, TPH_MEM_TYPE_VM,
> +						cpumask_first(irq->cpu_mask),
> +						&tag))
> +				continue;
> +
> +			pcie_tph_set_st_entry(irq->bp->pdev, irq->msix_nr, tag);
>   		}
>   	}
>   	return rc;
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> index 69231e85140b..641d25646367 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> @@ -1227,6 +1227,11 @@ struct bnxt_irq {
>   	u8		have_cpumask:1;
>   	char		name[IFNAMSIZ + BNXT_IRQ_NAME_EXTRA];
>   	cpumask_var_t	cpu_mask;
> +
> +	struct bnxt	*bp;
> +	int		msix_nr;
> +	int		ring_nr;
> +	struct irq_affinity_notify affinity_notify;
>   };
>   
>   #define HWRM_RING_ALLOC_TX	0x1
> @@ -2183,6 +2188,8 @@ struct bnxt {
>   	struct net_device	*dev;
>   	struct pci_dev		*pdev;
>   
> +	u8			tph_mode;
> +
>   	atomic_t		intr_sem;
>   
>   	u32			flags;
> diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
> index e217a5838c87..10e95d7b6892 100644
> --- a/net/core/netdev_rx_queue.c
> +++ b/net/core/netdev_rx_queue.c
> @@ -79,3 +79,4 @@ int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
>   
>   	return err;
>   }
> +EXPORT_SYMBOL_GPL(netdev_rx_queue_restart);

