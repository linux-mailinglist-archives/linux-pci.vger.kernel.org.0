Return-Path: <linux-pci+bounces-37634-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 362FABBF21A
	for <lists+linux-pci@lfdr.de>; Mon, 06 Oct 2025 21:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0F6594E1B15
	for <lists+linux-pci@lfdr.de>; Mon,  6 Oct 2025 19:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1F9221FAE;
	Mon,  6 Oct 2025 19:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="T8rw6g6c"
X-Original-To: linux-pci@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010049.outbound.protection.outlook.com [52.101.61.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D1634BA37;
	Mon,  6 Oct 2025 19:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759780776; cv=fail; b=N6XXdwRolh2W9O7N64/cIovcFRKNIztYd2skQyzNHhcf5NVu3uWKDzK7ODhPIqsxvq3mZ8GalR/eD9dwE09GynSBa8Ou4snSSUz9kmXVsulxEXVR+oH84FJ9Mf9QRd5rf2+pkkRkwEMuQhVMF2mmsKP2G1Vd+q0t0Jqv8wssx5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759780776; c=relaxed/simple;
	bh=MGhMhwtzntTHurJGp+YPfBZLYdCE7XGo8FU5/Wnqcag=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hQyjEP0vb/j4792Ibz7gaPmqB6I9qtLNVkn8V+aZblbH9YPVwL/z6oII9TZbwLhPSZPMfCDGIS9x0GGpb9DiKyH4oFL0Cp6+r/XrQbnYT3hkWm8E7QNSonUyypu8u1ifK3iK85v8UBQgM8TamluCTGkrO39ZMAk5YZAd3HFFYp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=T8rw6g6c; arc=fail smtp.client-ip=52.101.61.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l0N8oxhSwBEd1WczUczCA+oRvXTqKt352Nl0ahW+OYyzg9ReiaIOmu7eHVSbEPp9TDjSVrcfsngWZgx3SALYv3Ie5pmtF9aXRCNf1uk6gO73ETwmg4LBYRAZKpOXlBaiXqOZ/YAMb3bnVPeMlSFLouBBMY/vnccWuuoUmEn4E4Vx8Hri/HA4dV73vc7PHJ+gfP+WIgmAD4O4oRgBoNK5UqIpd1T0SdU0M3WTCjYcJFDZL7cW6b2rd3NHrmER7eIKmjWieaNAolWB8WvJbx5ezUNzjjKb+J5ulp2vqOSG1XrTC3+YnvoYkLSsHlpXTTIvjyZwu86vvBfCIA16ragI7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A/dWOE7rNrxY1ZZpHYqAZuWNOyY1YUfCvod4kLgDc1Q=;
 b=TVWksJXI3Pc12bfFckafTCM40f0Yx39wwnr6rNb2JluDqtqu4jLgoXFYPZ1ulXV/pnBFYTITtCiUkvR4UnYjDHtxikwUk4PZwK/MvGt8fnyW3NmvwFrKKKWPgzX+30U53UyMiUcM/GLKqN5IKkKCXQ1zsVibc6b+CjAUpph3od3sUU/OZwN7xxgiF8Tba6x9f+Xq/L4GzpfkeVQ47VP9LAtcIpTYj1nUreWEUC3kC+9kkGOyrggUqIVJkC5VoWaJeCF7Oo+KM/TeyyFooUVLFZGv4fGtH+rZITF64Tlrj80DCux8UncBnKtBs3EbvDrIuxzy9lvSFotTkGm9zfcVcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/dWOE7rNrxY1ZZpHYqAZuWNOyY1YUfCvod4kLgDc1Q=;
 b=T8rw6g6ccn5UsSHg+ufqNI77VULnukry7RpQTXrGG20OYjHnOueuzf6SwnVPFtvrcCNfImOZLmlmggWo4OKtdp52TNTU7QzIE2/H9t1ZpFO9Hb2rd4qMVydAYJHE0QU+TCLFQwXMNky4g7MGrYsOHYkRosSxL8bg5dCw3if1xqo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by CH3PR12MB8306.namprd12.prod.outlook.com (2603:10b6:610:12c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 19:59:20 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14%5]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 19:59:19 +0000
Message-ID: <16e5e21e-e4dc-4e8e-85a9-e2b236f1251c@amd.com>
Date: Mon, 6 Oct 2025 14:59:14 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 09/25] PCI/AER: Report CXL or PCIe bus error type in
 trace logging
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, dan.j.williams@intel.com, bhelgaas@google.com,
 shiju.jose@huawei.com, ming.li@zohomail.com,
 Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
 dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
 lukas@wunner.de, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com
References: <20250925223440.3539069-1-terry.bowman@amd.com>
 <20250925223440.3539069-10-terry.bowman@amd.com>
 <fd73dd2f-4988-423f-bceb-cd1a831a2a78@amd.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <fd73dd2f-4988-423f-bceb-cd1a831a2a78@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:208:32b::27) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|CH3PR12MB8306:EE_
X-MS-Office365-Filtering-Correlation-Id: b1e99782-74f2-41e5-c113-08de0512d5f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MGxoYmRwWkhhNk16eU5hdHNmRFdHeVpFZ0F6RVpDNEJaUHVnM3V0ZjBNbTRF?=
 =?utf-8?B?WldFQUViZlFKS0xrQmRQWnAxeU0xNy9tdWszVlN5aEFTLzZGVVJYeVo3cDlX?=
 =?utf-8?B?RWNTZDRPSUlTUEltR3dHV051aDl4RzVVRmJpTlpHanJPVE9vemMwYk00TkMv?=
 =?utf-8?B?aHRDVUJHVW5LSlVpb3dyMnJWZ3Z4QWJHY3BwZzdCY3Z4Qy9TQkJSbVZtNFJE?=
 =?utf-8?B?ZXpHL0lmUGFXeE5DVm15aFpPdFVlbWZEWURleEN2ZUx0ZkhCQ2hFK3ZkSDJS?=
 =?utf-8?B?WDZlL29UMXBnbkZqOTY2SGg5eDZ5VWdWeWhaSUpHSkVvbndBZFFZazNOSGcr?=
 =?utf-8?B?YVQzL0REczYzR1NtZWJWVlltZEFKV09yRGhSQjZKTUZCMzNOb3RQMGh0ajNp?=
 =?utf-8?B?UnFyZXpYb1NqRTllWExwb1dJVXpsUUZPRXBVNElqQ1JUNXFXbEQ3dVltYUF4?=
 =?utf-8?B?N05Va2RhNFR3ckVYZlY5YjFqM2EveWlONDF3ZnBpNnd4Qk5vM0JCaXlld1Ft?=
 =?utf-8?B?MmxJUnpvdHcrY1BLRzRIZythNWV6S1V3Yk1pb00rZ1AvSHhXOVM4emVTUDNt?=
 =?utf-8?B?SUNRbDFMYlNHN1ZCRlpBemFQQU1Cdk1QdzNwR3ZnNGY3QjB3VE9jR3dYRkls?=
 =?utf-8?B?bnArOE9Ia2htTmlrUGlFYmRDMVVhVGlUTk9ZYnlMRTZWbFNzSWhDUzBmbHdi?=
 =?utf-8?B?ZmdhdlhYUkxzYWNnRXZEc250a0RQaGFUbHlpQXl6NXZ3V1kzeVp3S2F1dC9O?=
 =?utf-8?B?aHlvR2xyMEFKU2tGTmdBbWNkQ2xKVHJTNEJZaElvNG5lSFd4V0NuQldXaXpk?=
 =?utf-8?B?QXE0REFjQ21OSlZ1YU9yb2Y5dzRNaWJwU0hLZnBuZVh5ZmtpMHFXU0pGTTBp?=
 =?utf-8?B?Uk5MN1luaGx6WlRKeHhMVzk3b3hZRzRiSkNQV0FhTUJXNXpTaVJIaWZuSzZz?=
 =?utf-8?B?SktucU5pUFdndGM0T2E0RkhhcmtrQ0VMK1lNLzBGeWRNeUUraXl2RjY5eWMy?=
 =?utf-8?B?d3FXb1dIQTJaOU5MK2E0eFFhdVVxblIra3dDOWRVWVczTDNvMHhPVEMzNCtn?=
 =?utf-8?B?SCtDQWpkeUdkQU5sR1JEY1YyTHJQbjBpZzJ4UmZpdHFIZkFyMGdMT1orTVVH?=
 =?utf-8?B?MmcwODJXeEMxckMvbEpWSXQxaERLWHl4M0VuMVRoWXU3WDJJeExOZjBubmpK?=
 =?utf-8?B?RmZRN0tDWW5ldHJCbFd3VFpCK004K3BvWk5EUktpV3FxRDY0eVRkMjh6dEFJ?=
 =?utf-8?B?Q01tNlduSU0zRUNyZkxiNXVJNnBCYjdSOGZRT21RQzhHSlVxTGxhMjBPbkU1?=
 =?utf-8?B?OWZrcnR1QURvVGVyczF4OEhXd2ZXUWgrRlZEQnJwZUZFSTNyNjZGRk9aK1dN?=
 =?utf-8?B?NlVSdzZ1eEl4bFBXUnMrOWlEVkRCMVlRekFvZjhTQjhhZWlidUJsNysrUjhR?=
 =?utf-8?B?ekxSQ0xSOXp3cks4TlBRSFlQRHVwYytJcXVKUkFlVktQeUNKbWxES2V4MTUv?=
 =?utf-8?B?eTB6N3puU0kvcmVhMFl0VlYzaTUxTEFMQlZCRkNpbDE3K1Vtc2RBN1RaUHI4?=
 =?utf-8?B?WnVnT1Rud1VtR2tZb2QyS0dRdlkxcVdRQUh5RkJZc205SWhUeFIxckU1ZDJl?=
 =?utf-8?B?alhUSStPVzFlSW0yWjlTNHd2K2k0V2N1TTF5dzkvVG1RSFVqVVlyRGM1Mk5L?=
 =?utf-8?B?QUd5MzJMSVJHT0V6aDA4YTNkNWhBZFJ0a2NkS20zQVVIcVgrZ1cyZjF6NXRn?=
 =?utf-8?B?TjI2MlZhMnI2N0ZSYkxMQy9xQVR3NWdPaWQvMjNGaHJERWFmR051SWJLRTlx?=
 =?utf-8?B?bnk0WFFXZ2NHc1VpaExPRkUyRU5WVlF4MEt0T0tXd29FTjZmcjIxeTZkTUpW?=
 =?utf-8?B?c0pvRjRZaHRzS2c1cEtlU21SWnQyaHdiUUZuZ3FjN1ZJVm9BdkFqYXJyU0R0?=
 =?utf-8?Q?cIGHhery85D4OdRjB+TfQwUVqTlqZdHI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUpEOXZyNktwbEE1L2dFcDYxekpyOE9SZW8wMkpTSEZYa3BkR1FFOU9UaHpk?=
 =?utf-8?B?MFVUcTlYZ2dWNDgyWk9IWHZ2cWQvMStUcUp0MHJrUVc4MDdVUUpYM2Q0eG1F?=
 =?utf-8?B?eGg1d0tCRmRDaVpYV21kWGtNdDdsc1Z5cmJPV3NzY285NEE5MkRJTFUrK0Jj?=
 =?utf-8?B?RGw5VkJOeTJMRXM1Wjl0Vm9LUVAvQ1FjbVljbVY1UjBjajJqa3N3SE10MkFG?=
 =?utf-8?B?UzBYdmM1UmN0eUs4U1VNL09yK1JXb0xWSllzSWp1MzFkYTJJa2gvV0F6NFc4?=
 =?utf-8?B?dmo1VlpzVVk2SHo4dWUwSWxkT1BtbGYwMW0vdFdQODhWSWgvelV1ZDZnMTE5?=
 =?utf-8?B?K3grdEhkekhLVUtYcFpQS3BvYXJ1YWdvcmtmNXJuNmlMa3ZUQk85c0N3QWQ3?=
 =?utf-8?B?c0JQTi9kaXU1WkIxSnVINUpmQmFVbjh4TjRBVFB5T05KeXIrWjRqTXZzOXZq?=
 =?utf-8?B?cTFZRHUxdHpqbytQTktkdGtRMWk1bndKdWZUbWgxeFpqbUdWSi9UQk9OWVZX?=
 =?utf-8?B?TForeU02VWlGc2FzcC9qOU8vblRybUFRZ2I0cTZnbXhNSDM3ZFNrSElFa1l5?=
 =?utf-8?B?SmtiRlFNRlM2VGFKanVxV1ROQlUyQXFSNE42bWF4aXpLOXlYaGEyOC9vYnd3?=
 =?utf-8?B?THpZekFuYnhxUWRzUTJjZ2daREFoWlZPTmhkMkVtelBOcXhNZVdLWXRIMDRM?=
 =?utf-8?B?MXo1dmw4QzlpUGY2ZTNFTjRzbkY4SGtyNUdlVWVRMWpjdVA5TllrR0RrN1dG?=
 =?utf-8?B?Si9UZ3pCNEhYMEJWWThNYUhXaUFqcW51YzN0Y1JzR21Tb1o2SjEzTnp5UzFx?=
 =?utf-8?B?RUdFcnV2Y3pOWVdwVjRWMkNMR2ZZbXErL24zWDNJRUVqSE1kcTVkTm1Nbnkv?=
 =?utf-8?B?WWxTWEZpeFRrN2lvblpFWTc3aDJMRVdkR2gxd085WXA1OEtpYUFQTE0xZ0VK?=
 =?utf-8?B?WE15eU5wOEV5NWRDVjRPZVJ1T0FJOXUwZTJTWVhNd1VwYm1KeENIREdsYkJy?=
 =?utf-8?B?cUdqWGdOeDRpaDUyMVZicmxZOG1KSEprZ2lBTCtoaXowU2xCK3NTWjF0UGkr?=
 =?utf-8?B?TWVUTFpZWDZ1c3dpWms0eko3MVhBY1hhL0RBMzZvZEtwUlRmNDBwMGIvSkJD?=
 =?utf-8?B?a3UyZEQ2U05VQjBvRE5LbWVMdTdiT25lQi83TnBEQkJvQ0Q4T052d0wvcG9M?=
 =?utf-8?B?N1hIaW9DSXF5bXkzbGdNbklINGpzTnMyUndHWWs4UUNkZitQLzlSZ3NDZkN5?=
 =?utf-8?B?Y0hwSUlQcDZOcHBaS1l4WG1GK3prLytYT3FhSDhvQU9DL2JNMm1QQUFKNm5L?=
 =?utf-8?B?SjlmWWJkOU5iUW9ZYVdnYnBKOEFrMWhPZi9pQVFOM0lDWUd5WVZCWU1lUlNF?=
 =?utf-8?B?OG53MTdlR00xN29pbHlJTUR6MVN4T21Wc3JlbU1MTDJHaEFxbk1UQzRrVHdR?=
 =?utf-8?B?UTIxZGhtY1Q2eU1YL2p2NjBNcWFISnk3aWhwWVBnenQvUk9BZW9YM0JEOGdZ?=
 =?utf-8?B?cjc0eHg5U3hXOEd3TS9xNWdMZ0NBODhmcVVSN2RRSDhhU2VuVmt1d3lEREdO?=
 =?utf-8?B?K2p5d0FYSkNFN3dsS2VaZTdDeDZubm5ZZ0lqQndHVFl6cm42QzExR3lKTnF1?=
 =?utf-8?B?ekhlOFh2MHBzRXZvUE5hZTFsLzJCVlFVVUl3Y2hkQ2ZwR1gwK3ZEV3V6ZmtW?=
 =?utf-8?B?a25KRmFYV0xqVytSTHh4N0k0QlRBb204TUVtTTdkdDFUcm1ad1BlalljT1ln?=
 =?utf-8?B?T2N6K0RWaU5RbEhPUE5Kek9WaEZyUm5najZFOURQeFRGOHZyU2hrS0xuS291?=
 =?utf-8?B?VzFNWGE1MVNVUXl6WnFtcDg2S3BwSy9LVkZrNUE4bUJCaDlla3NmVmE5WU1P?=
 =?utf-8?B?djVJcGljeG8zTXJXYyszZ2RhRjlHZ05SNGFPZTZ2VFM0NVB5SklCR3VTM05i?=
 =?utf-8?B?Y24wVCtIWS9WdWdLWkt2T2Z4ZWR4MlphNUlFQVp6Wm44dHBRTEJDbXo4OE90?=
 =?utf-8?B?bmdKaHpWQnBSV000RVJWRW5LUVhTSTNMQk10Z1ZURmg5UW4rbmM5b2RpTEg4?=
 =?utf-8?B?NENFUEk1UzFZMUFqUFJ3M1hqdGsxMTR6OXNpczRkY21rNGhDVHFHeFBIZWRi?=
 =?utf-8?Q?PHrj2dDTMKkFWTzIURmhTv63U?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1e99782-74f2-41e5-c113-08de0512d5f2
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 19:59:19.1969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oHVmOPtAQb+Scb9/x74Ao6QlLtbRf71/nGawL1g2aBLE8OB9LBw9viauFYv1oJHS28PQmRqeXJR/InwpFcUGYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8306



On 10/3/2025 3:11 PM, Cheatham, Benjamin wrote:
> [snip]
>
>> +/**
>> + * struct aer_err_info - AER Error Information
>> + * @dev: Devices reporting error
>> + * @ratelimit_print: Flag to log or not log the devices' error. 0=NotLog/1=Log
>> + * @error_devnum: Number of devices reporting an error
>> + * @level: printk level to use in logging
>> + * @id: Value from register PCI_ERR_ROOT_ERR_SRC
>> + * @severity: AER severity, 0-UNCOR Non-fatal, 1-UNCOR fatal, 2-COR
>> + * @root_ratelimit_print: Flag to log or not log the root's error. 0=NotLog/1=Log
>> + * @multi_error_valid: If multiple errors are reported
>> + * @first_error: First reported error
>> + * @is_cxl: Bus type error: 0-PCI Bus error, 1-CXL Bus error
>> + * @tlp_header_valid: Indicates if TLP field contains error information
>> + * @status: COR/UNCOR error status
>> + * @mask: COR/UNCOR mask
>> + * @tlp: Transaction packet information
>> + */
>>  struct aer_err_info {
>>  	struct pci_dev *dev[AER_MAX_MULTI_ERR_DEVICES];
>>  	int ratelimit_print[AER_MAX_MULTI_ERR_DEVICES];
>> @@ -621,7 +638,8 @@ struct aer_err_info {
>>  	unsigned int multi_error_valid:1;
>>  
>>  	unsigned int first_error:5;
>> -	unsigned int __pad2:2;
>> +	unsigned int __pad2:1;
>> +	bool is_cxl:1;                  /* CXL or PCI bus error? */
>>  	unsigned int tlp_header_valid:1;
>>  
>>  	unsigned int status;		/* COR/UNCOR Error Status */
> I'd get rid of the comments after the members since it's the exact same thing as the kernel
> doc above the struct.

Good idea.

>> @@ -632,6 +650,11 @@ struct aer_err_info {
>>  int aer_get_device_error_info(struct aer_err_info *info, int i);
>>  void aer_print_error(struct aer_err_info *info, int i);
>>  
>> +static inline const char *aer_err_bus(struct aer_err_info *info)
>> +{
>> +	return info->is_cxl ? "CXL" : "PCIe";
>> +}
>> +
>>  int pcie_read_tlp_log(struct pci_dev *dev, int where, int where2,
>>  		      unsigned int tlp_len, bool flit,
>>  		      struct pcie_tlp_log *log);
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index 6e5c9efe2920..befa73ace9bb 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -837,6 +837,7 @@ void aer_print_error(struct aer_err_info *info, int i)
>>  	struct pci_dev *dev;
>>  	int layer, agent, id;
>>  	const char *level = info->level;
>> +	const char *bus_type = aer_err_bus(info);
>>  
>>  	if (WARN_ON_ONCE(i >= AER_MAX_MULTI_ERR_DEVICES))
>>  		return;
>> @@ -845,23 +846,23 @@ void aer_print_error(struct aer_err_info *info, int i)
>>  	id = pci_dev_id(dev);
>>  
>>  	pci_dev_aer_stats_incr(dev, info);
>> -	trace_aer_event(pci_name(dev), (info->status & ~info->mask),
>> +	trace_aer_event(pci_name(dev), bus_type, (info->status & ~info->mask),
>>  			info->severity, info->tlp_header_valid, &info->tlp);
>>  
>>  	if (!info->ratelimit_print[i])
>>  		return;
>>  
>>  	if (!info->status) {
>> -		pci_err(dev, "PCIe Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
>> -			aer_error_severity_string[info->severity]);
>> +		pci_err(dev, "%s Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
>> +			bus_type, aer_error_severity_string[info->severity]);
>>  		goto out;
>>  	}
>>  
>>  	layer = AER_GET_LAYER_ERROR(info->severity, info->status);
>>  	agent = AER_GET_AGENT(info->severity, info->status);
>>  
>> -	aer_printk(level, dev, "PCIe Bus Error: severity=%s, type=%s, (%s)\n",
>> -		   aer_error_severity_string[info->severity],
>> +	aer_printk(level, dev, "%s Bus Error: severity=%s, type=%s, (%s)\n",
>> +		   bus_type, aer_error_severity_string[info->severity],
>>  		   aer_error_layer[layer], aer_agent_string[agent]);
>>  
>>  	aer_printk(level, dev, "  device [%04x:%04x] error status/mask=%08x/%08x\n",
>> @@ -895,6 +896,7 @@ EXPORT_SYMBOL_GPL(cper_severity_to_aer);
>>  void pci_print_aer(struct pci_dev *dev, int aer_severity,
>>  		   struct aer_capability_regs *aer)
>>  {
>> +	const char *bus_type;
>>  	int layer, agent, tlp_header_valid = 0;
>>  	u32 status, mask;
>>  	struct aer_err_info info = {
>> @@ -915,9 +917,12 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>>  
>>  	info.status = status;
>>  	info.mask = mask;
>> +	info.is_cxl = pcie_is_cxl(dev);
>> +
>> +	bus_type = aer_err_bus(&info);
>>  
>>  	pci_dev_aer_stats_incr(dev, &info);
>> -	trace_aer_event(pci_name(dev), (status & ~mask),
>> +	trace_aer_event(pci_name(dev), bus_type, (status & ~mask),
>>  			aer_severity, tlp_header_valid, &aer->header_log);
>>  
>>  	if (!aer_ratelimit(dev, info.severity))
>> @@ -1278,6 +1283,7 @@ int aer_get_device_error_info(struct aer_err_info *info, int i)
>>  	/* Must reset in this function */
>>  	info->status = 0;
>>  	info->tlp_header_valid = 0;
>> +	info->is_cxl = pcie_is_cxl(dev);
>>  
> So am I right in assuming every AER error that occurs while the link is trained
> as a CXL link will be reported as a CXL error? Sorry if this is a stupid question,
> but is it possible for a PCIe error to occur or does CXL.io just replace the PCIe
> protocol once the link is trained as CXL?

Correct. Any PCI bus protocol errors reported while CXL trained will be reported as 
CXL errors.

In your example a "PCIe error" will be detected as a CXL.io error and the AER driver
will log the extended AER register status. The device's CXL RAS will also be logged 
if it is a CXL bus error.

> If so, do we not care if the error is a PCIe-level error and just report it as
> a CXL error anyway?
We can't access CXL RAS if its not a CXL error and not a device.

> Sorry if you've already hashed all of this out, but I figured I'd ask just to make sure.
Terry

