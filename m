Return-Path: <linux-pci+bounces-13398-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76887983A8A
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 02:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF72B283E35
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 00:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A710629;
	Tue, 24 Sep 2024 00:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=llnl.gov header.i=@llnl.gov header.b="F0fOCprM";
	dkim=pass (1024-bit key) header.d=doellnl.onmicrosoft.com header.i=@doellnl.onmicrosoft.com header.b="Ss6tMgkJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0f-00379502.gpphosted.com (mx0f-00379502.gpphosted.com [67.231.155.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6CE38C;
	Tue, 24 Sep 2024 00:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.155.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727136559; cv=fail; b=HcADUl1bjoZ1OevMRDtf8NSYCyU/Jsx1p7JswQg+h+/GLhYFe6Zo6tIxMiUPcMdSdXKwhVl5+tv5GGkjuAkhaVgyUdIFm3SsuJPs5uTLEvJPbXdBK+lI+WZSbepv24kDikFDZvSJggbGBe7779o7KCr80zk7KJzLyaAvcNI2Nc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727136559; c=relaxed/simple;
	bh=qBRSIJUpibUKDQYK0O4h5/7EM1ur+DFd7W2GIjnthIM=;
	h=Message-ID:Date:From:Subject:To:Cc:Content-Type:MIME-Version; b=LeLjiJFqEoNsq/9dYbvPjL26Aw1d8+80mYWxWFOWNTUkWkNVqyDPE6hy6f7Zx/csXzf2H6cxVq3PQdc5HrF3Mzp8MKjNR9z7bckLsGFRWjGfs1QZaUspB/l2dGuYOtxSBqwIXefuMi6EDWFBb6MTeQHML77YAX+TAfDvsDwKRNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=llnl.gov; spf=pass smtp.mailfrom=llnl.gov; dkim=pass (2048-bit key) header.d=llnl.gov header.i=@llnl.gov header.b=F0fOCprM; dkim=pass (1024-bit key) header.d=doellnl.onmicrosoft.com header.i=@doellnl.onmicrosoft.com header.b=Ss6tMgkJ; arc=fail smtp.client-ip=67.231.155.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=llnl.gov
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=llnl.gov
Received: from pps.filterd (m0422210.ppops.net [127.0.0.1])
	by mx0f-00379502.gpphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48NN7XNv016491;
	Mon, 23 Sep 2024 17:06:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=llnl.gov; h=message-id : date :
 from : subject : to : cc : content-type : content-transfer-encoding :
 mime-version; s=02022021-podllnl;
 bh=7c0irPOi9NGi2Ay7F/8w8ZZ1S736dq7ifNm8fjriH/8=;
 b=F0fOCprMStfmwmnRcEGYfGgVRJDvI4TOaxgAFtTVyVlx7y5IiB65Az+IycRaAJw7H9cS
 +H5T6GhQvxgIgIWr1FpK685Y01GaumJqYtZtcxeTRdCaY3OvxhdylpzcxcOOsDcECIXY
 a+aG6LUaVmFpsaJ0ad5PYOinGBycyoxyt8dm//OPBvN5xaUqlcEjbUnoMiE8IjY8e9qb
 DE6ax/c3PmlHEr2RevCcA9WiHvEkvAmpZLHQ7TWCvW56zqyrTXVlEz+NAJTLz03gOfwF
 JSTOxWvTQKb2wZ5ZOZMcfLdSWRNeYaK6j6zPazVOiz+lIaa1/TwfzQpKfeYVN108vnZY +A== 
Received: from sa9pr09cu002.outbound.protection.outlook.com (mail-southcentralusazlp17010022.outbound.protection.outlook.com [40.93.14.22])
	by mx0f-00379502.gpphosted.com (PPS) with ESMTPS id 41u6qqhq0y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Sep 2024 17:06:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gjFVi6Ui/s40RT98hYGfLbjkorQzrL0lRfOqdyRTHLlOP7Wk5I8WUeRPy7R6zHWMOdT9BdwDG9T0e6omYnV7Los+YrTiTNyH32KSPTt4BI/+7eJAjdx7PJTA1zNnT7YYVZhL5bvDy6hxE0UvIAvqnXoLtsdCDSwEPt3QFchPuvURaENnBx0H9WtcaSlOC1Gu+nnSC7f7vlnBppXl88VL3hVV6U70V10lUCi3UETTpiVNTI7Iu2J7ca8fEzoxLHp8mEPAUx6FSZWO9sGDj6bUeNutvPU3rqBq8/ltnoLqHgeI6uj1Ge35MNaVW6SjztTOAIplMYHcGc/P8H/1GeSgzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7c0irPOi9NGi2Ay7F/8w8ZZ1S736dq7ifNm8fjriH/8=;
 b=tc5IIrmxaPf8wZvzXCgDr+dXvg/oSMpMOYY/HCRPToPwcy/pN4eGC73dSpLN5k1k84OpGa/f9HbmeSPUXGouf9wZm3IYrhCHHUNYSLXlWBk1VIAgzlmHpll36SzSVLRcfVjbevJW9jrmKApJhCKOUFxoZNsdoAr/JuTY5at23Ap0vx0DpOxnUvq337xMZrW/YWyfhyl83HbXdqAUVcd/2sZIQ+rlItjM4EAI4k8qV+jfuzZFkrvlG/JZ32U9glTc5ePwZ0/knVW9c9Cqy2Mcdiuy9ZHfr+Jf1FUq0FHb43t2s0r1VMKUj8Wu+nd6UDmu6K5+1akAU/XQfqQ5oHNazQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=llnl.gov; dmarc=pass action=none header.from=llnl.gov;
 dkim=pass header.d=llnl.gov; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=doellnl.onmicrosoft.com; s=selector1-doellnl-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7c0irPOi9NGi2Ay7F/8w8ZZ1S736dq7ifNm8fjriH/8=;
 b=Ss6tMgkJMD5biq13moUjq2744QOb8+bgjEAtEUygp1k6AALO/9RB14O5txiWL6MS0FeIrUH31Esls8JbKZyA2OegAAd065CBNu+2z/3ILKldncIVt3cYM4LH1vNhqCluiLm2N1MHOnf8nLD3bob1+MF0KPi1KOHKnaIMvlSpT00=
Received: from BY3PR09MB8834.namprd09.prod.outlook.com (2603:10b6:a03:346::22)
 by SJ0PR09MB11459.namprd09.prod.outlook.com (2603:10b6:a03:510::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Tue, 24 Sep
 2024 00:06:07 +0000
Received: from BY3PR09MB8834.namprd09.prod.outlook.com
 ([fe80::9fcf:fc76:1d:f39]) by BY3PR09MB8834.namprd09.prod.outlook.com
 ([fe80::9fcf:fc76:1d:f39%3]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 00:06:07 +0000
Message-ID: <8f35eb96-3458-45d2-a31d-7813ae4e7260@llnl.gov>
Date: Mon, 23 Sep 2024 17:06:05 -0700
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Tony Hutter <hutter2@llnl.gov>
Subject: [PATCH v2] PCI: Introduce Cray ClusterStor E1000 NVMe slot LED driver
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
        mariusz.tkaczyk@linux.intel.com, minyard@acm.org
Cc: linux-pci@vger.kernel.org, openipmi-developer@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0122.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::7) To BY3PR09MB8834.namprd09.prod.outlook.com
 (2603:10b6:a03:346::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY3PR09MB8834:EE_|SJ0PR09MB11459:EE_
X-MS-Office365-Filtering-Correlation-Id: 87e408a0-3294-49e2-f814-08dcdc2caff9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V2Z2Vms2dC83T3d6NlViMk1UUHJ2eEJpWUlKSkdjNGphQzh2RG1YSWk3OGVB?=
 =?utf-8?B?SEdqb1R3MU5lV0pjTGtlNW9PYkgvWEd2YVhWT3FYMERzK2s3ZTJWeWptT1By?=
 =?utf-8?B?c2FqVmNienJnRHpLRWlWZ1RPU0NzZkNSYUFybzRyczhDb1lhTmtBckUvTk1p?=
 =?utf-8?B?a24rTndQNUxtZWM4R1k3VCswZCsybU9rdVIrTm9YdXlEWW9nMnN6YXVmdUg1?=
 =?utf-8?B?WHgzd0diRjZTVkJWOFlRTFVzakg5dERHWUF4bDNuTW1yRWdtYUJ3UnRIYTUv?=
 =?utf-8?B?cVpqMml1bVRhZis2WlllQzliWUVObDM4eGlZdElXUlRybHhjR0ZEOUgvK3RX?=
 =?utf-8?B?WjVpbTYvQ3NwZVdQL1pUTytVVld2UlpKaEEwZlY3NzQwNWo1cDBZVHhxWkxE?=
 =?utf-8?B?VURFaUxPRXlYTU9JRTN3cksxL0NSQXY4UjBINlFudjl2ZXZaTmJxRWJuUThL?=
 =?utf-8?B?M1A0ckdyZlpQZTN4ZTZKUWYralJVTytUSll6bTdsb0FyZUNaQzVyRkFzNGN5?=
 =?utf-8?B?WG9DUGVMUFEyZDhOTjRnYllXY2Nhd3ZoQ0lZNHFhdjg5Q1RQajBWdjh1WXBM?=
 =?utf-8?B?LzMxUUVpbWRFVUsvN0lpeTBTY0Jpb0V5MUxDdTJycEZrbFA2Q05BTk1jQklq?=
 =?utf-8?B?SEU4RmNIQ3g2alRHS3JVSUtIVUkxaU95UnE0OWdKc1VvajhVVjhOcUF1cDZw?=
 =?utf-8?B?cWs4SEo2M2dwREpydWRTK0xwQ0kzN2FZejhxeTlQVnAzNEhKenpVS0ExWUJJ?=
 =?utf-8?B?a0xEaUFJZGNqVzQxYzhsRU5PdE1BWHhnOGFqcWcyZ2ZQeUVnejFlcHVIOXhF?=
 =?utf-8?B?OW9DSm9iRk0xZWIzWUJrNHM3SEoxU2JIVG9KQXNIZStGNHIyMEFjSGE0Tmlh?=
 =?utf-8?B?c0ZRaTRGUjJMdERTeGRYME45VldnNVpKRXRzR0piakVidS81QWtWUWFlWVI0?=
 =?utf-8?B?Q0I5bEluTDZseXVKZzRpd3RhekxmbjdhM3FaNFgySEZZamFMVXp6OFE1ZlFL?=
 =?utf-8?B?WjVzM2paSWFGcDhtZ3AxRDB6Uk5lRUxzTFVkY2VyT3BsV2N5eDQxQUhRZENT?=
 =?utf-8?B?UGE4YWloalZBVEZiMElGOUtaZXlWeWU1R3FBSUtZakdZbENPL1htSXRxSzEv?=
 =?utf-8?B?VGlhWCtmeTIwTFQ4dGpBSmFZK2xoZEVnQU1XelFUVXdIUW5IRUNuUERRRlRw?=
 =?utf-8?B?OUdCNVNZbUpFbkUrNnZXQjBKcDBhUnNzVnJqYXptTmlGSllqMUZiUFdkS3V2?=
 =?utf-8?B?SHN6MHVFRUJTRHlvdjZVNTBqaWg0a253cmsvZCtnL1ZRbStDNUpwc1FIOUFy?=
 =?utf-8?B?ajNtbkh6YTdHRXJMUmpGNVRXd2xIZytuVnhORU1SRy9rVzl1S2VFakRmYldi?=
 =?utf-8?B?bTVadVRlV1FXSXcxdjJQS2FyMXZOd2lKaWpUU0NleXFKU2ZSSmI1djBnK3Nx?=
 =?utf-8?B?UmxVZWpUcXFJb3I4RkJhS0NjWThqQ05wOStGejAzU1UwNnJrdm9lOFU3QTRq?=
 =?utf-8?B?bmVGdFRHZ3JRVVhoOEtMWG5iWHlEbER6UVJYbFYzK011dUZpTXRnNkVkVlpQ?=
 =?utf-8?B?aFVjTnV0T3hobkF6ME40MTJoUzRQV2kxTi9NUDlrRzlWK0lkYmt3R1F4Z3ps?=
 =?utf-8?B?UnJkZzRrNVVKY01PVXFqMTZGS2RONU1PSW1xRHVNeHF0bytKQzR2UkJOZ2Iy?=
 =?utf-8?B?SHFIaUtXY2FaamFUMUlESVFpY3BHUjhqaXRVQTNWR0hwdWhKUzJlL3hRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR09MB8834.namprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emxvR2w0ek95QmRYc3JvcGY4YTg5bW83MDFnTVorR2lMWU5aam9PSXo3b1FQ?=
 =?utf-8?B?ajk0NUx6Z042cGt3anNocWREL3JSREVmRXlLT1d0Y1JEWHFkaVhGR2NPeTBx?=
 =?utf-8?B?SFlJK3Nvd2JJclBhcVNqc3ptMmt0MHhnSTZQaDJteXdzQzZ0dm9RMEo2dm10?=
 =?utf-8?B?V2JHMUp6WE9lNVh4UW1zWG4zM2ZBNi9NbnI0dGRwanJ0cDAyTG5GRjJGY1lM?=
 =?utf-8?B?Qkp3V045Q3VlMm8rYlM5aEh3ZS84bjRNWCthbkZWaHUweTlaT1NmR3FMYTFM?=
 =?utf-8?B?VkFTZVFXaFJsOThrN1BUOTgyVUNBeDNwZDZLYlA2RE80anZ6b0VRYUpva01l?=
 =?utf-8?B?VytGbmdGTHh4cDlmcGd1aXFscEs0eTZPUDJ2WjFEQ0F0N1lhK3NwN0hUZE1r?=
 =?utf-8?B?Z3NZQ1NmMkp3R3ZzOWpwelA3Y3l1QWEwbzUxblAxT2o5TW5ZRVA5QktxWVBy?=
 =?utf-8?B?b0U4MnVvcjAxQ3RXQlozakc4Qm51dGhMb25WMk9FZWdzVGZvV3Y3NEd0ZEpF?=
 =?utf-8?B?alhMUUFzTjdSQlFNU2xFZ1RMR1FQeWh5QzR0cmpvaHdQOE5udEs3Ni9rOUts?=
 =?utf-8?B?d0RXdk5aaVYzRlZXSmV6Qi81VXF5VDJ6Njh0R0dUYSs5VGtOckNhMGhSM2FJ?=
 =?utf-8?B?Z1hrczQ4MTlZNFdhR0Ntam9lSlYzSzQxQU9NSmdrU0pZZ2NaYmJOZnQ4QXYz?=
 =?utf-8?B?dXBISjVsSS8wZ2JwajhxbVB1NHdvWkhyK3I5bUJjblY3STk5QWQvQlFjYmgy?=
 =?utf-8?B?ckRraDBkaStGNFRxZnFLYTNsL1FFelNnWTNpbGJFVmp6RzRURVhwbWZrZVVv?=
 =?utf-8?B?YWtjSEZhSWduRU9DMnlCUnJuU2RFS3lnWm1YeXliR0FPcGVJZXpQVW0xVUNs?=
 =?utf-8?B?SFZZTlpjYW0veW1hV1BrN1RVRGwxTXhRc3dHbDJRb1hPNFJLekdFY09jbTh5?=
 =?utf-8?B?dlplSTBsSVp6Z1hKUHZ4Z2I2V0d0cjVGVWlWV2IyREhUT2cwRjVwLzczenZ4?=
 =?utf-8?B?dGlCVVRjOHplekg5Yk9wVm13NTIvdmRqMzNNbHoyeEUrc0Q0aHE5WitwUjVz?=
 =?utf-8?B?ak1XN21hSzYvNmE3QlI2YVhMVGQ5YTJ4ZFgwU0wzaUpSaHM0TmRycVRLWmVM?=
 =?utf-8?B?Um91M0VrdEh5ejZGSzVsVmR5aERJS0IxUnpjSnhWd2MrYjZJa1MxZi9SdjVr?=
 =?utf-8?B?RktuT3VRWW95T1FSRlluS3FNOTZVREpjU3JuTWEyT0tGVE43cDZnRmpqeEVB?=
 =?utf-8?B?WERzR21vdWRFSHcwWTRVcmZuV3p5NTdlQ3NST1Q4L2FlbUJsUDVkaEVLMDFs?=
 =?utf-8?B?Nm9TK0VueG5JYTRjaE5ORlFncTJ5NHZsbTdZVitWWTczeEF2TW9WWnVVVURQ?=
 =?utf-8?B?QTJoQ3k5ZFp1dkxLRzRrcXU4TENvV3dkMzQweTZxdS9pZW1jQmJjUVpwbTd5?=
 =?utf-8?B?d2p1cWUvR0EvK1JkS0pXeTZNSUkwQjlDb3h1QVdFUXlTdjBzRFhEOGJhYi9i?=
 =?utf-8?B?a2kvOFQrcmlaVUxpRU5xY1o1LzJuc1BuNzM0SFM1ZFZod0RDdFBXSUZ1UjJN?=
 =?utf-8?B?VXNNYWY3a3gzQ2V0MTZaUE43bFJEamdQenh2NVBNdS9KSFNveWF0UDFKZHFR?=
 =?utf-8?B?T25oSlRtaitTeWhIRncvWThqQ3B1N1RLUUVWMm9kck1NdG8xeG9aanY1ejBB?=
 =?utf-8?B?R2pQN0VzZTVsTCtwWFh2S28rYTUyOVBWd1FPOHNmVjU0aUpvY2RraXZtcG5V?=
 =?utf-8?B?NkxyeUVuNGFoeWdSeEhGSVljT1pwRDViRkRxZVAvS2pFMmRPVDBOOE5iVGE5?=
 =?utf-8?B?YWZDVmxON3lwcU1nQzNnUzlaWlQ2a29BTXA3MG5yV3VDR1hsT0ZCdGMvVDFu?=
 =?utf-8?B?V2NlMEpwRzcyZk1kV2I5bkNTczF6R3U3dFhacHQ0dTg1YjB3bnBFOXBLa0x6?=
 =?utf-8?B?bjF4eU14dkNndGxpc0t6NmgwWjhoVWxZQ0RHdUtBblZHR1pJNklJWEdoa3Bx?=
 =?utf-8?B?Wkc4cnRtMmtkenpNSWFnK3V2QkdLYyt6V085L3JMVC9ObllXb1JyOE5kellQ?=
 =?utf-8?B?eWhRYitQUkU3NWpRdDJZNWEvYzl3WG12RW5tczd0NjZnQm14ZERZYkJCelhD?=
 =?utf-8?Q?QjoVLv01L54hpWLuggoxYudrE?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KxjUfCtGAqDdw71up7Ow2RJ/LLK9fx1YPY/f9A/yeMVi3uiGXya6N/YiWWrlCUw9Paku6IzZMgkuj0ASYtdzBHZdDf2NQVI8/BqcZhJXaSEQyl/MNpwIGdOHq+Mog9PyyyyEGaP6vqqyMRialoidZSKvDQODZLBFJuZEuOH6rrQYxaL6cwVYmtVo6A4gadKnAJOLyM8ZKUHJvzbnird4Q5HtY1y7kmfHcfkU01j9O0bcUYOC6y23REtpITyXEm809GRHFK42L7fXj2Stu6rrQnR5x34HVbOwySv4KHOvJcnnQjxZ4+L5SBkeNFW4putccMtjXQ3WnsRLTPeb7roc8t5xonTGt65xU/dqIuTlg6n4chjCa0swDx1QKzNw4zT/SdFIPkaRQzbjR2HoS315WqqzxrXz7KkuKBYKGOBBYug8NGGUMOciQMvM/Xmpcc4L6iA1BAo27A+XHDCURR8tC3NHjFESp+JctbgMpNs14m/9KwtBgoTw7mMrV7lUqOtI43cTOFjiEmV/G+2kutZqYEOELetNoRwTyWY1Gs01xVNmYSUFTih79eBbGRrQCO7r3GeqBAGIkkVHhlQDjsiDzZjVfub1H7gFYY2A28z+SK0Bky5GNskzdckYbddQHJ9aIMwvXn9qjBNEtlGKp049/A==
X-OriginatorOrg: llnl.gov
X-MS-Exchange-CrossTenant-Network-Message-Id: 87e408a0-3294-49e2-f814-08dcdc2caff9
X-MS-Exchange-CrossTenant-AuthSource: BY3PR09MB8834.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 00:06:07.1493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a722dec9-ae4e-4ae3-9d75-fd66e2680a63
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR09MB11459
X-Proofpoint-ORIG-GUID: AnbvG4ImWy3nlPlalsavqKMyQI0LOlVZ
X-Proofpoint-GUID: AnbvG4ImWy3nlPlalsavqKMyQI0LOlVZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-23_15,2024-09-23_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 clxscore=1011 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409230172

Add driver to control the NVMe slot LEDs on the Cray ClusterStor E1000.
The driver provides hotplug attention status callbacks for the 24 NVMe
slots on the E1000.  This allows users to access the E1000's locate and
fault LEDs via the normal /sys/bus/pci/slots/<slot>/attention sysfs
entries.  This driver uses IPMI to communicate with the E1000 controller
to toggle the LEDs.

Changes in v2:
 - Integrated E1000 code into the pciehp driver as an built-in
   extention rather than as a standalone module.
 - Moved debug tunables and counters to debugfs.
 - Removed forward declarations.
 - Kept the /sys/bus/pci/slots/<slot>/attention interface rather
   than using NPEM/_DSM or led_classdev as suggested.  The "attention"
   interface is more beneficial for our site, since it allows us to
   control the NVMe slot LEDs agnostically across different enclosure
   vendors and kernel versions using the same scripts.  It is also
   nice to use the same /sys/bus/pci/slots/<slot>/ sysfs directory for
   both slot LED toggling ("attention") and slot power control
   ("power").

Signed-off-by: Tony Hutter <hutter2@llnl.gov>

---
 MAINTAINERS                          |   5 +
 drivers/pci/hotplug/Kconfig          |  10 +
 drivers/pci/hotplug/Makefile         |   3 +
 drivers/pci/hotplug/pciehp.h         |   7 +
 drivers/pci/hotplug/pciehp_core.c    |  12 +
 drivers/pci/hotplug/pciehp_craye1k.c | 677 +++++++++++++++++++++++++++
 6 files changed, 714 insertions(+)
 create mode 100644 drivers/pci/hotplug/pciehp_craye1k.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 42d2d950877c..4e6edb323754 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5928,6 +5928,11 @@ S:	Maintained
 F:	Documentation/filesystems/cramfs.rst
 F:	fs/cramfs/
 
+CRAY CLUSTERSTOR E1000 NVME SLOT LED DRIVER EXTENSIONS
+M:	Tony Hutter <hutter2@llnl.gov>
+S:	Maintained
+F:	drivers/pci/hotplug/pciehp_craye1k.c
+
 CREATIVE SB0540
 M:	Bastien Nocera <hadess@hadess.net>
 L:	linux-input@vger.kernel.org
diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
index 1472aef0fb81..6cd664be6b66 100644
--- a/drivers/pci/hotplug/Kconfig
+++ b/drivers/pci/hotplug/Kconfig
@@ -173,4 +173,14 @@ config HOTPLUG_PCI_S390
 
 	  When in doubt, say Y.
 
+config HOTPLUG_PCI_PCIE_CRAY_E1000
+	bool "PCIe Hotplug extensions for Cray ClusterStor E1000"
+	depends on ACPI_PCI_SLOT && HOTPLUG_PCI_PCIE && IPMI_HANDLER=y
+	help
+	  Say Y here if you have a Cray ClusterStor E1000 and want to control
+	  your NVMe slot LEDs.  Without this driver is it not possible
+	  to control the fault and locate LEDs on the E1000's 24 NVMe slots.
+
+	  When in doubt, say N.
+
 endif # HOTPLUG_PCI
diff --git a/drivers/pci/hotplug/Makefile b/drivers/pci/hotplug/Makefile
index 240c99517d5e..b3cb75ff2db2 100644
--- a/drivers/pci/hotplug/Makefile
+++ b/drivers/pci/hotplug/Makefile
@@ -65,6 +65,9 @@ pciehp-objs		:=	pciehp_core.o	\
 				pciehp_ctrl.o	\
 				pciehp_pci.o	\
 				pciehp_hpc.o
+ifdef CONFIG_HOTPLUG_PCI_PCIE_CRAY_E1000
+pciehp-objs		+=	pciehp_craye1k.o
+endif
 
 shpchp-objs		:=	shpchp_core.o	\
 				shpchp_ctrl.o	\
diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 273dd8c66f4e..ea68ae041547 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -198,6 +198,13 @@ int pciehp_get_raw_indicator_status(struct hotplug_slot *h_slot, u8 *status);
 
 int pciehp_slot_reset(struct pcie_device *dev);
 
+#ifdef CONFIG_HOTPLUG_PCI_PCIE_CRAY_E1000
+int craye1k_get_attention_status(struct hotplug_slot *hotplug_slot, u8 *status);
+int craye1k_set_attention_status(struct hotplug_slot *hotplug_slot, u8 status);
+bool is_craye1k_slot(struct controller *ctrl);
+int craye1k_init(void);
+#endif
+
 static inline const char *slot_name(struct controller *ctrl)
 {
 	return hotplug_slot_name(&ctrl->hotplug_slot);
diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index ff458e692fed..9a7a7b320810 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -73,6 +73,13 @@ static int init_slot(struct controller *ctrl)
 		ops->get_attention_status = pciehp_get_raw_indicator_status;
 		ops->set_attention_status = pciehp_set_raw_indicator_status;
 	}
+#ifdef CONFIG_HOTPLUG_PCI_PCIE_CRAY_E1000
+	if (is_craye1k_slot(ctrl)) {
+		/* slots 1-24 on Cray E1000s are controlled differently */
+		ops->get_attention_status = craye1k_get_attention_status;
+		ops->set_attention_status = craye1k_set_attention_status;
+	}
+#endif
 
 	/* register this slot with the hotplug pci core */
 	ctrl->hotplug_slot.ops = ops;
@@ -404,6 +411,11 @@ int __init pcie_hp_init(void)
 	pr_debug("pcie_port_service_register = %d\n", retval);
 	if (retval)
 		pr_debug("Failure to register service\n");
+#ifdef CONFIG_HOTPLUG_PCI_PCIE_CRAY_E1000
+	retval = craye1k_init();
+	if (retval)
+		pr_debug("Failure to register Cray E1000 extensions");
+#endif
 
 	return retval;
 }
diff --git a/drivers/pci/hotplug/pciehp_craye1k.c b/drivers/pci/hotplug/pciehp_craye1k.c
new file mode 100644
index 000000000000..9f44c7b35d03
--- /dev/null
+++ b/drivers/pci/hotplug/pciehp_craye1k.c
@@ -0,0 +1,677 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2022-2024 Lawrence Livermore National Security, LLC
+ */
+/*
+ * Cray ClusterStor E1000 hotplug slot LED driver extensions
+ *
+ * This driver controls the NVMe slot LEDs on the Cray ClusterStore E1000.
+ * It provides hotplug attention status callbacks for the 24 NVMe slots on
+ * the E1000.  This allows users to access the E1000's locate and fault
+ * LEDs via the normal /sys/bus/pci/slots/<slot>/attention sysfs entries.
+ * This driver uses IPMI to communicate with the E1000 controller to toggle
+ * the LEDs.
+ *
+ * This driver is based off of ibmpex.c
+ */
+
+#include <linux/debugfs.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/dmi.h>
+#include <linux/ipmi.h>
+#include <linux/ipmi_smi.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/pci_hotplug.h>
+#include <linux/random.h>
+#include "pciehp.h"
+
+/* Cray E1000 commands */
+#define CRAYE1K_CMD_NETFN       0x3c
+#define CRAYE1K_CMD_PRIMARY     0x33
+#define CRAYE1K_CMD_FAULT_LED   0x39
+#define CRAYE1K_CMD_LOCATE_LED  0x22
+
+/* Subcommands */
+#define CRAYE1K_GET_LED		0x0
+#define CRAYE1K_SET_LED		0x1
+#define CRAYE1K_SET_PRIMARY		0x1
+
+/*
+ * Milliseconds to wait after get/set LED command.  200ms value found though
+ * experimentation
+ */
+#define	CRAYE1K_POST_CMD_WAIT_MS	200
+
+struct craye1k {
+	struct device *dev;   /* BMC device */
+	struct mutex lock;
+	struct completion read_complete;
+	struct ipmi_addr address;
+	struct ipmi_user *user;
+	int iface;
+
+	long tx_msg_id;
+	struct kernel_ipmi_msg tx_msg;
+	unsigned char tx_msg_data[IPMI_MAX_MSG_LENGTH];
+	unsigned char rx_msg_data[IPMI_MAX_MSG_LENGTH];
+	unsigned long rx_msg_len;
+	unsigned char rx_result;	/* IPMI completion code */
+
+	/* Parent dir for all our debugfs entries */
+	struct dentry *parent;
+
+	/* debugfs stats */
+	u64 check_primary;
+	u64 check_primary_failed;
+	u64 was_already_primary;
+	u64 was_not_already_primary;
+	u64 set_primary;
+	u64 set_initial_primary_failed;
+	u64 set_primary_failed;
+	u64 set_led_locate_failed;
+	u64 set_led_fault_failed;
+	u64 set_led_readback_failed;
+	u64 set_led_failed;
+	u64 get_led_failed;
+	u64 completion_timeout;
+	u64 wrong_msgid;
+	u64 request_failed;
+
+	/* debugfs configuration options */
+
+	/* Print info on spurious IPMI messages */
+	bool print_errors;
+
+	/* Retries for kernel IPMI layer */
+	u32 ipmi_retries;
+
+	/* Timeout in ms for IPMI (0 = use IPMI default_retry_ms) */
+	u32 ipmi_timeout_ms;
+
+	/* Timeout in ms to wait for E1000 message completion */
+	u32 completion_timeout_ms;
+};
+
+/*
+ * Make our craye1k a global so get/set_attention_status() can access it.
+ * This is safe since there's only one node controller on the board, and so it's
+ * impossible to instantiate more than one craye1k.
+ */
+static struct craye1k *craye1k_global;
+
+/* Return parent dir dentry */
+static struct dentry *
+craye1k_debugfs_init(struct craye1k *craye1k)
+{
+	umode_t mode = 0644;
+	struct dentry *parent = debugfs_create_dir("pciehp_craye1k", NULL);
+
+	if (!parent)
+		return NULL;
+
+	debugfs_create_x64("check_primary", mode, parent,
+			   &craye1k->check_primary);
+	debugfs_create_x64("check_primary_failed", mode, parent,
+			   &craye1k->check_primary_failed);
+	debugfs_create_x64("was_already_primary", mode, parent,
+			   &craye1k->was_already_primary);
+	debugfs_create_x64("was_not_already_primary", mode, parent,
+			   &craye1k->was_not_already_primary);
+	debugfs_create_x64("set_primary", mode, parent,
+			   &craye1k->set_primary);
+	debugfs_create_x64("set_initial_primary_failed", mode, parent,
+			   &craye1k->set_initial_primary_failed);
+	debugfs_create_x64("set_primary_failed", mode, parent,
+			   &craye1k->set_primary_failed);
+	debugfs_create_x64("set_led_locate_failed", mode, parent,
+			   &craye1k->set_led_locate_failed);
+	debugfs_create_x64("set_led_fault_failed", mode, parent,
+			   &craye1k->set_led_fault_failed);
+	debugfs_create_x64("set_led_readback_failed", mode, parent,
+			   &craye1k->set_led_readback_failed);
+	debugfs_create_x64("set_led_failed", mode, parent,
+			   &craye1k->set_led_failed);
+	debugfs_create_x64("get_led_failed", mode, parent,
+			   &craye1k->get_led_failed);
+	debugfs_create_x64("completion_timeout", mode, parent,
+			   &craye1k->completion_timeout);
+	debugfs_create_x64("wrong_msgid", mode, parent,
+			   &craye1k->wrong_msgid);
+	debugfs_create_x64("request_failed", mode, parent,
+			   &craye1k->request_failed);
+
+	debugfs_create_x32("ipmi_retries", mode, parent,
+			   &craye1k->ipmi_retries);
+	debugfs_create_x32("ipmi_timeout_ms", mode, parent,
+			   &craye1k->ipmi_timeout_ms);
+	debugfs_create_x32("completion_timeout_ms", mode, parent,
+			   &craye1k->completion_timeout_ms);
+	debugfs_create_bool("print_errors", mode, parent,
+			    &craye1k->print_errors);
+
+	return parent;
+}
+
+/*
+ * craye1k_msg_handler() - IPMI message response handler
+ */
+static void craye1k_msg_handler(struct ipmi_recv_msg *msg, void *user_msg_data)
+{
+	struct craye1k *craye1k = user_msg_data;
+
+	if (msg->msgid != craye1k->tx_msg_id) {
+		craye1k->wrong_msgid++;
+		if (craye1k->print_errors) {
+			dev_warn_ratelimited(craye1k->dev, "rx msgid %d != %d",
+					     (int)msg->msgid,
+					     (int)craye1k->tx_msg_id);
+		}
+		ipmi_free_recv_msg(msg);
+		return;
+	}
+
+	/* Set rx_result to the IPMI completion code */
+	if (msg->msg.data_len > 0)
+		craye1k->rx_result = msg->msg.data[0];
+	else
+		craye1k->rx_result = IPMI_UNKNOWN_ERR_COMPLETION_CODE;
+
+	if (msg->msg.data_len > 1) {
+		/* Exclude completion code from data bytes */
+		craye1k->rx_msg_len = msg->msg.data_len - 1;
+		memcpy(craye1k->rx_msg_data, msg->msg.data + 1,
+		       craye1k->rx_msg_len);
+	} else {
+		craye1k->rx_msg_len = 0;
+	}
+
+	ipmi_free_recv_msg(msg);
+
+	complete(&craye1k->read_complete);
+}
+
+static const struct ipmi_user_hndl craye1k_user_hndl = {
+	.ipmi_recv_hndl = craye1k_msg_handler
+};
+
+static void craye1k_new_smi(int iface, struct device *dev)
+{
+	int rc;
+	struct craye1k *craye1k;
+
+	/* There's only one node controller so driver data should not be set */
+	WARN_ON(craye1k_global);
+
+	craye1k = kzalloc(sizeof(*craye1k), GFP_KERNEL);
+	if (!craye1k)
+		return;
+
+	craye1k->address.addr_type = IPMI_SYSTEM_INTERFACE_ADDR_TYPE;
+	craye1k->address.channel = IPMI_BMC_CHANNEL;
+	craye1k->iface = iface;
+	craye1k->dev = dev;
+	craye1k->tx_msg.data = craye1k->tx_msg_data;
+	craye1k->ipmi_retries = 4;
+	craye1k->ipmi_timeout_ms = 500;
+	craye1k->completion_timeout_ms = 300;
+
+	init_completion(&craye1k->read_complete);
+	mutex_init(&craye1k->lock);
+
+	dev_set_drvdata(dev, craye1k);
+
+	rc = ipmi_create_user(craye1k->iface, &craye1k_user_hndl, craye1k,
+			      &craye1k->user);
+	if (rc < 0) {
+		dev_err_ratelimited(dev,
+				    "Unable to register IPMI user, iface %d\n",
+				    craye1k->iface);
+		kfree(craye1k);
+		dev_set_drvdata(dev, NULL);
+		return;
+	}
+
+	craye1k_global = craye1k;
+
+	craye1k->parent = craye1k_debugfs_init(craye1k);
+	if (!craye1k->parent)
+		dev_warn_ratelimited(dev, "Cannot create debugfs");
+
+	dev_info_ratelimited(dev,
+			     "Cray ClusterStor E1000 slot LEDs registered");
+}
+
+static void craye1k_smi_gone(int iface)
+{
+	pr_warn("craye1k: Got unexpected smi_gone, iface=%d", iface);
+}
+
+static struct ipmi_smi_watcher craye1k_smi_watcher = {
+	.owner = THIS_MODULE,
+	.new_smi = craye1k_new_smi,
+	.smi_gone = craye1k_smi_gone
+};
+
+/*
+ * craye1k_send_message() - Send the message already setup in 'craye1k'
+ *
+ * Context: craye1k->lock is already held.
+ * Return: 0 on success, non-zero on error.
+ */
+static int craye1k_send_message(struct craye1k *craye1k)
+{
+	int rc;
+
+	rc = ipmi_validate_addr(&craye1k->address, sizeof(craye1k->address));
+	if (rc) {
+		dev_err_ratelimited(craye1k->dev, "validate_addr() = %d\n", rc);
+		return rc;
+	}
+
+	craye1k->tx_msg_id++;
+
+	rc = ipmi_request_settime(craye1k->user, &craye1k->address,
+				  craye1k->tx_msg_id, &craye1k->tx_msg, craye1k,
+				  0, craye1k->ipmi_retries,
+				  craye1k->ipmi_timeout_ms);
+
+	if (rc) {
+		craye1k->request_failed++;
+		return rc;
+	}
+
+	return 0;
+}
+
+/*
+ * craye1k_do_message() - Send the message in 'craye1k' and wait for a response
+ *
+ * Context: craye1k->lock is already held.
+ * Return: 0 on success, non-zero on error.
+ */
+static int craye1k_do_message(struct craye1k *craye1k)
+{
+	int rc;
+	long rc2;
+	struct completion *read_complete = &craye1k->read_complete;
+	unsigned long tout = msecs_to_jiffies(craye1k->completion_timeout_ms);
+
+	rc = craye1k_send_message(craye1k);
+	if (rc == 0) {
+		rc2 = wait_for_completion_killable_timeout(read_complete, tout);
+		if (rc2 == 0) {
+			craye1k->completion_timeout++;
+			rc = -ETIME;
+		}
+	}
+
+	if (craye1k->rx_result == IPMI_UNKNOWN_ERR_COMPLETION_CODE || rc2 <= 0)
+		rc = -1;
+
+	return rc;
+}
+
+/*
+ * __craye1k_do_command() - Do an IPMI command
+ *
+ * Send a command with optional data bytes, and read back response bytes.
+ * Context: craye1k->lock is already held.
+ * Returns: 0 on success, non-zero on error.
+ */
+static int __craye1k_do_command(struct craye1k *craye1k, u8 netfn, u8 cmd,
+				u8 *send_data, u8 send_data_len, u8 *recv_data,
+				u8 recv_data_len)
+{
+	int rc;
+
+	craye1k->tx_msg.netfn = netfn;
+	craye1k->tx_msg.cmd = cmd;
+
+	if (send_data) {
+		memcpy(&craye1k->tx_msg_data[0], send_data, send_data_len);
+		craye1k->tx_msg.data_len = send_data_len;
+	} else {
+		craye1k->tx_msg_data[0] = 0;
+		craye1k->tx_msg.data_len = 0;
+	}
+
+	rc = craye1k_do_message(craye1k);
+	memcpy(recv_data, craye1k->rx_msg_data, recv_data_len);
+
+	return rc;
+}
+
+/*
+ * craye1k_do_command_and_netfn() - Do IPMI command and return 1st data byte
+ *
+ * Do an IPMI command with the given netfn, cmd, and optional send payload
+ * bytes.
+ *
+ * Context: craye1k->lock is already held.
+ * Returns: the last byte from the response or 0 if response had no response
+ * data bytes, else -1 on error.
+ */
+static int craye1k_do_command_and_netfn(struct craye1k *craye1k, u8 netfn,
+					u8 cmd, u8 *send_data, u8 send_data_len)
+{
+	int rc;
+
+	rc = __craye1k_do_command(craye1k, netfn, cmd, send_data, send_data_len,
+				  NULL, 0);
+	if (rc != 0) {
+		/* Error attempting command */
+		return -1;
+	}
+
+	if (craye1k->tx_msg.data_len == 0)
+		return 0;
+
+	/* Return last received byte value */
+	return craye1k->rx_msg_data[craye1k->rx_msg_len - 1];
+}
+
+/*
+ * craye1k_do_command() - Do a Cray E1000 specific IPMI command.
+ * @cmd: Cray E1000 specific command
+ * @send_data:  Data to send after the command
+ * @send_data_len: Data length
+ *
+ * Context: craye1k->lock is already held.
+ * Returns: the last byte from the response or 0 if response had no response
+ * data bytes, else -1 on error.
+ */
+static int craye1k_do_command(struct craye1k *craye1k, u8 cmd, u8 *send_data,
+			      u8 send_data_len)
+{
+	return (craye1k_do_command_and_netfn(craye1k, CRAYE1K_CMD_NETFN, cmd,
+					     send_data, send_data_len));
+}
+
+/*
+ * __craye1k_set_primary() - Tell the BMC we want to be the primary server
+ *
+ * An E1000 board has two physical servers on it.  In order to set a slot
+ * NVMe LED, this server needs to first tell the BMC that it's the primary
+ * server.
+ *
+ * Returns: 0 on success, non-zero on error.
+ */
+static int __craye1k_set_primary(struct craye1k *craye1k)
+{
+	u8 bytes[2] = {CRAYE1K_SET_PRIMARY, 1};	/* set primary to 1 */
+
+	craye1k->set_primary++;
+	return craye1k_do_command(craye1k, CRAYE1K_CMD_PRIMARY, bytes, 2);
+}
+
+/*
+ * craye1k_is_primary() - Are we the primary server?
+ *
+ * Returns: 1 if we are the primary server, 0 otherwise.
+ */
+static int craye1k_is_primary(struct craye1k *craye1k)
+{
+	u8 byte = 0;
+	int rc;
+
+	/* Response byte is 0x1 on success */
+	rc = craye1k_do_command(craye1k, CRAYE1K_CMD_PRIMARY, &byte, 1);
+	craye1k->check_primary++;
+	if (rc == 0x1)
+		return 1;   /* success */
+
+	craye1k->check_primary_failed++;
+	return 0;   /* We are not the primary server node */
+}
+
+/*
+ * craye1k_set_primary() - Attempt to set ourselves as the primary server
+ *
+ * Returns: 0 on success, 1 otherwise.
+ */
+static int craye1k_set_primary(struct craye1k *craye1k)
+{
+	int tries = 10;
+
+	if (craye1k_is_primary(craye1k)) {
+		craye1k->was_already_primary++;
+		return 0;
+	}
+	craye1k->was_not_already_primary++;
+
+	/* delay found through experimentation */
+	msleep(300);
+
+	if (__craye1k_set_primary(craye1k) != 0) {
+		craye1k->set_initial_primary_failed++;
+		return 1;	/* error */
+	}
+
+	/*
+	 * It can take 2 to 3 seconds after setting primary for the controller
+	 * to report that it is the primary.
+	 */
+	while (tries--) {
+		msleep(500);
+		if (craye1k_is_primary(craye1k))
+			break;
+	}
+
+	if (tries == 0) {
+		craye1k->set_primary_failed++;
+		return 1;	/* never reported that it's primary */
+	}
+
+	/* Wait for primary switch to finish */
+	msleep(1500);
+
+	return 0;
+}
+
+/*
+ * craye1k_get_slot_led() - Get slot LED value
+ * @slot: Slot number (1-24)
+ * @is_locate_led: 0 = get fault LED value, 1 = get locate LED value
+ *
+ * Returns: slot value on success, -1 on failure.
+ */
+static int craye1k_get_slot_led(struct craye1k *craye1k, unsigned char slot,
+				bool is_locate_led)
+{
+	u8 bytes[2];
+	u8 cmd;
+
+	bytes[0] = CRAYE1K_GET_LED;
+	bytes[1] = slot;
+
+	cmd = is_locate_led ? CRAYE1K_CMD_LOCATE_LED : CRAYE1K_CMD_FAULT_LED;
+
+	return craye1k_do_command(craye1k, cmd, bytes, 2);
+}
+
+/*
+ * craye1k_set_slot_led() - Attempt to set the locate/fault LED to a value
+ * @slot: Slot number (1-24)
+ * @is_locate_led: 0 = use fault LED, 1 = use locate LED
+ * @value: Value to set (0 or 1)
+ *
+ * Check the LED value after calling this function to ensure it has been set
+ * properly.
+ *
+ * Returns: 0 on success, non-zero on failure.
+ */
+static int craye1k_set_slot_led(struct craye1k *craye1k, unsigned char slot,
+				unsigned char is_locate_led,
+				unsigned char value)
+{
+	u8 bytes[3];
+	u8 cmd;
+
+	bytes[0] = CRAYE1K_SET_LED;
+	bytes[1] = slot;
+	bytes[2] = value;
+
+	cmd = is_locate_led ? CRAYE1K_CMD_LOCATE_LED : CRAYE1K_CMD_FAULT_LED;
+
+	return craye1k_do_command(craye1k, cmd, bytes, 3);
+}
+
+static int __craye1k_get_attention_status(struct hotplug_slot *hotplug_slot,
+					  u8 *status, bool set_primary)
+{
+	unsigned char slot;
+	int locate, fault;
+	struct craye1k *craye1k;
+
+	craye1k = craye1k_global;
+	slot = PSN(to_ctrl(hotplug_slot));
+
+	if (set_primary) {
+		if (craye1k_set_primary(craye1k) != 0) {
+			craye1k->get_led_failed++;
+			return -EIO;
+		}
+	}
+
+	locate = craye1k_get_slot_led(craye1k, slot, true);
+	if (locate == -1) {
+		craye1k->get_led_failed++;
+		return -EINVAL;
+	}
+	msleep(CRAYE1K_POST_CMD_WAIT_MS);
+
+	fault = craye1k_get_slot_led(craye1k, slot, false);
+	if (fault == -1) {
+		craye1k->get_led_failed++;
+		return -EINVAL;
+	}
+	msleep(CRAYE1K_POST_CMD_WAIT_MS);
+
+	*status = locate << 1 | fault;
+
+	return 0;
+}
+
+int craye1k_get_attention_status(struct hotplug_slot *hotplug_slot,
+				 u8 *status)
+{
+	int rc;
+	struct craye1k *craye1k;
+
+	craye1k = craye1k_global;
+
+	if (mutex_lock_interruptible(&craye1k->lock) != 0)
+		return -EINTR;
+
+	rc =  __craye1k_get_attention_status(hotplug_slot, status, true);
+
+	mutex_unlock(&craye1k->lock);
+	return rc;
+}
+
+int craye1k_set_attention_status(struct hotplug_slot *hotplug_slot,
+				 u8 status)
+{
+	unsigned char slot;
+	int tries = 4;
+	int rc;
+	u8 new_status;
+	struct craye1k *craye1k;
+	bool locate, fault;
+
+	craye1k = craye1k_global;
+
+	slot = PSN(to_ctrl(hotplug_slot));
+
+	if (mutex_lock_interruptible(&craye1k->lock) != 0)
+		return -EINTR;
+
+	/* Retry to ensure all LEDs are set */
+	while (tries--) {
+		/*
+		 * The node must first set itself to be the primary node before
+		 * setting the slot LEDs (each board has two nodes, or
+		 * "servers" as they're called by the manufacturer).  This can
+		 * lead to contention if both nodes are trying to set the LEDs
+		 * at the same time.
+		 */
+		rc = craye1k_set_primary(craye1k);
+		if (rc != 0) {
+			/* Could not set as primary node.  Just retry again. */
+			continue;
+		}
+
+		/* Write value twice to increase success rate */
+		locate = (status & 0x2) >> 1;
+		craye1k_set_slot_led(craye1k, slot, 1, locate);
+		if (craye1k_set_slot_led(craye1k, slot, 1, locate) != 0) {
+			craye1k->set_led_locate_failed++;
+			continue;	/* fail, retry */
+		}
+
+		msleep(CRAYE1K_POST_CMD_WAIT_MS);
+
+		fault = status & 0x1;
+		craye1k_set_slot_led(craye1k, slot, 0, fault);
+		if (craye1k_set_slot_led(craye1k, slot, 0, fault) != 0) {
+			craye1k->set_led_fault_failed++;
+			continue;	/* fail, retry */
+		}
+
+		msleep(CRAYE1K_POST_CMD_WAIT_MS);
+
+		rc = __craye1k_get_attention_status(hotplug_slot, &new_status,
+						    false);
+
+		msleep(CRAYE1K_POST_CMD_WAIT_MS);
+
+		if (rc == 0 && new_status == status)
+			break;	/* success */
+
+		craye1k->set_led_readback_failed++;
+
+		/*
+		 * At this point we weren't successful in setting the LED and
+		 * need to try again.
+		 *
+		 * Do a random back-off to reduce contention with other server
+		 * node in the unlikely case that both server nodes are trying to
+		 * trying to set a LED at the same time.
+		 *
+		 * The 500ms minimum in the back-off reduced the chance of this
+		 * whole retry loop failing from 1 in 700 to none in 10000.
+		 */
+		msleep(500 + (get_random_long() % 500));
+	}
+	mutex_unlock(&craye1k->lock);
+	if (tries == 0) {
+		craye1k->set_led_failed++;
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static bool is_craye1k_board(void)
+{
+	return dmi_match(DMI_PRODUCT_NAME, "VSSEP1EC");
+}
+
+bool is_craye1k_slot(struct controller *ctrl)
+{
+	return (PSN(ctrl) >= 1 && PSN(ctrl) <= 24 && is_craye1k_board());
+}
+
+int craye1k_init(void)
+{
+	if (!is_craye1k_board())
+		return 0;
+
+	return ipmi_smi_watcher_register(&craye1k_smi_watcher);
+}
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Tony Hutter <hutter2@llnl.gov>");
+MODULE_DESCRIPTION("Cray E1000 NVMe Slot LED driver");
-- 
2.43.5

