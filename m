Return-Path: <linux-pci+bounces-13391-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1177797F19B
	for <lists+linux-pci@lfdr.de>; Mon, 23 Sep 2024 22:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7CC91F2245A
	for <lists+linux-pci@lfdr.de>; Mon, 23 Sep 2024 20:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4821A0AF5;
	Mon, 23 Sep 2024 20:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Y8LIJTNg"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69BF36126;
	Mon, 23 Sep 2024 20:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727122623; cv=fail; b=HwH33nxR3Cg5PuJtOoqQwwtLwbR+RbaiJrcJS3F60zZMn4v7qAbcI11Ihha+xWud6ffIUNa/70zRj2NAiMLZbF71rn+mRGf7F3/hW4RXL8cYvtDAQ+409AK0J7qq+MGLex6OZnslNnVYe+jq//LtcPRAvkKLhqWglUbYSlsJ/Z8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727122623; c=relaxed/simple;
	bh=ggpgxZDdb5tE7T8e+y5U8bRhUYjQqQDygVJnPOi3kQI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kO0wOnBj6xbJHQpz3KNAYcDIvGD6GaarqMvcsWoc6ViqsDInLyZzaUu9ZluwVKXOoO8C/8tgwwu/Tw2IPBwvxjZ932Q3BFillhcHdXrM2QSH6Ez+799CFBFeLCpOaJ9LYlXqD0a0YELKFny7oyqkKYmdXZ2nd9ftWSPWJTnDczo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Y8LIJTNg; arc=fail smtp.client-ip=40.107.220.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oNsYKfn30mKn8MbSZ3jrNSJZKYwMnozFThz5bpahWqjjkKB9+3/nhejID2gfpYwxtNciD47Vjn1AeW1svIgZZi0CYstKaNK6SVyAHN6KJ6EQL+To0G7vwwirpXhFBLQAm3bUO+QasaFW+7a64bSNDqcaZqD+KPNtCEn3ELPT96lMAY3DiF7XXFFNtmvUxgOEan2sKOcJbIqAAP6tV0V29oTSY8cterovE2Jp9iQ+R39EhfAI+Igp7pFJI1TXWpOOvwJHh5ByV9jXlNY3sazzc8XdgS6kHu4dBu+84UthLKQ7FHIyjX/niHMfC/UafLVhr6ibdteF2xStUs//m8CQeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UVk4gIndQEfiqBiila3Rs5eyIqOcLmLnHBUSX56VbDk=;
 b=v8ukkZ6zU311jvjJxWHvXnwSIDeOgKaJqIxyVK/+CfmDSCKTWRE8bO02RMMbSUpTL/wdP/uPkqmeTRJeEmCpxL84dfILzYY1vP3dZQ2t/WLzYxpFuNhdwi4n2RnvJEkWUgAgpPlBMtGNtx9Bm+l0Twl2WHIyOvsonebC42PiBfGanf15EyzgHzBv6oCFbMrCyyjaXlIoITXIkx0jFT6wnSQkDCkbDD+d2rX7dGwtgWnqbajwctWjsKN39+siPv0BGi/qJ78Nrlh1I25ffPUWeWUmt/SmtlbZ6C9p+gNXUqkWwUW6Rmzm2vC2e3DODemVCK/mJ6eBfnBydQROrOGCSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVk4gIndQEfiqBiila3Rs5eyIqOcLmLnHBUSX56VbDk=;
 b=Y8LIJTNg7QWHg+BCIQEsSvvPLaM5OtNhF1/ruEAY7vcvFkuMQbEDw0lPrXUi/VRITfmyR0unpx6QnTh3JBIVns/JMs9z5E0X70uVbDxbmmJEKuuBaf+3YbsPxAr8lb+gaMB3aHNHNcT3SzYiCmKQfJgP3/bKKcsxhPYlIMKazM0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4877.namprd12.prod.outlook.com (2603:10b6:5:1bb::24)
 by SJ2PR12MB8159.namprd12.prod.outlook.com (2603:10b6:a03:4f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 20:16:59 +0000
Received: from DM6PR12MB4877.namprd12.prod.outlook.com
 ([fe80::92ad:22ff:bff2:d475]) by DM6PR12MB4877.namprd12.prod.outlook.com
 ([fe80::92ad:22ff:bff2:d475%3]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 20:16:58 +0000
Message-ID: <c0fd8b1a-d97e-4219-9f14-5de5e313a5da@amd.com>
Date: Mon, 23 Sep 2024 15:16:55 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 4/5] bnxt_en: Add TPH support in BNXT driver
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, netdev@vger.kernel.org,
 Jonathan.Cameron@huawei.com, helgaas@kernel.org, corbet@lwn.net,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, alex.williamson@redhat.com, gospo@broadcom.com,
 michael.chan@broadcom.com, ajit.khaparde@broadcom.com,
 somnath.kotur@broadcom.com, andrew.gospodarek@broadcom.com,
 manoj.panicker2@amd.com, Eric.VanTassell@amd.com, vadim.fedorenko@linux.dev,
 horms@kernel.org, bagasdotme@gmail.com, bhelgaas@google.com,
 paul.e.luse@intel.com, jing2.liu@intel.com
References: <20240916205103.3882081-1-wei.huang2@amd.com>
 <20240916205103.3882081-5-wei.huang2@amd.com>
 <69110d07-4d6a-4b7f-9ee1-65959ebd6de7@amd.com> <ZvEX0vPIpwGPZgGR@wunner.de>
From: Wei Huang <wei.huang2@amd.com>
Content-Language: en-US
In-Reply-To: <ZvEX0vPIpwGPZgGR@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P221CA0014.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::19) To DM6PR12MB4877.namprd12.prod.outlook.com
 (2603:10b6:5:1bb::24)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4877:EE_|SJ2PR12MB8159:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a880ef4-7cfc-4f25-027c-08dcdc0cad4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K2JVUVhnSzlvQzRua0lqSHdaM2laWUYrL2M5WWxjK2VrbVZlVjQ1dG9UdmF2?=
 =?utf-8?B?aUl3YjhZQjdocVRuSU9iUHFpMmZ1aEltU2IzRU9id3ozNnIwbXVpbjZJWmFt?=
 =?utf-8?B?N3R6TE5KcWtCM25pZjdNbmNaN0lxZFMwSG1XaHVQbWY1WXZuQjNHUjVwY1hx?=
 =?utf-8?B?V0hkQ1U4amJob0ZXZG8wdzQwWVQxRDdISkd4M1psS2xBbjRGWHdtaW5mNzhM?=
 =?utf-8?B?ekt0dFlkUDU3MGFTcVl3OGd1S0NKYmtUV1BaQWwwdU1qYkZ1YXNBY2xZY1Z3?=
 =?utf-8?B?aUtHWHRZWUhjMzdlWW44eFhqSGczb2ZPMUd0YVYybS9BVjBwVVdhWkhCTm1z?=
 =?utf-8?B?VnFvSXR3Ukk2RlB1RWNiRlJJUnBDT3NCRjA4K01nU0w4YmRVdkc0RVYwdjBP?=
 =?utf-8?B?RUFHYkVHaW92N2JVUDU4WHdxbVB5RWZWWEhBZkx6WWpaWmd6ZHg0ZlJhbE11?=
 =?utf-8?B?cm9YdEh6d3Zua3JqTnlLWkNhSTQ3WmlLb3EyOFg3Ui9DUDFyWklzR3l6NVdq?=
 =?utf-8?B?MEtjVVVnOW1mY3Q4ZG5ZNzVkT1ozc1VtL2NNazJ2R1ZobXFIWkVKZU1tY2tW?=
 =?utf-8?B?MWFhY1Jobm04dUozNVk3cVArYmJyVEVRWEJUWVFCclRxeVBoeXZUNlNSR3NH?=
 =?utf-8?B?UnpKT0FPT2tpWm9kcElvR2EzQVJQZHhQL0ZTQ3BKK3JBOElyZXpoNG9DdDFT?=
 =?utf-8?B?b0ZjbVJhSENyTVBaMVlHTisyZjdjV20yT2lKZnNTWVdSSEQyQUNHbForUXFp?=
 =?utf-8?B?aDVDazVTdUpvTUhueC9ldFJEUlFHeS9pRHRuTy93QUxTSG1nMjE3TFNBSW95?=
 =?utf-8?B?WWlteStld2RITHorMmw3bWZ4anpIN0RIQWc5YVF6OWpWTEl2M1U0K3MwbUM3?=
 =?utf-8?B?Y3JCVE4rN1cwd2dMS3pIc3htODFxRkZVa1VWR3VJTmJHUGVxUnRzc1lIcVN4?=
 =?utf-8?B?VE5kWHJ6RDdzdUhkb3ZIZzFFNjJFWGFxSWxIY3dtVUJxZzFUeC9QVzNpb3Zx?=
 =?utf-8?B?WDcyaXl2U0orRisvNllvZHFWZUFPR3ExUG5HSVM1d29NOXBpcmxRTEpXMFhJ?=
 =?utf-8?B?Y2lXT3l3Q3l6dFlUN21qalUvRWt2RytFbkQzaHdzR3ZhZ0d6a25yeHZ2QUlF?=
 =?utf-8?B?djJUN0Y3YlRlem14bjNmK1R3NE5wMDlzcGttZXErd1pqRy9lbXZFODQwRW9S?=
 =?utf-8?B?UHZXOG5uc2lvT01mT3ZwdkJWbCtTY2dFR3FvSUsvYWZLMmhGNkJlaXo2bVBY?=
 =?utf-8?B?bkdKOEZsbklNZzl4dXlJTVRxZnRZWjAyWGVsTGZDUzYyd21Cd1dydlZCUHdh?=
 =?utf-8?B?Tk9YRE9DUzVGN3U4V1FrSzdtWWhxaWp5NjZGUE53OEp6UTdmRGp5OWp0UGZh?=
 =?utf-8?B?S3Q3dllPdWNPMCtxRXAxYnphc3B4YjlJdkV1dDVpTEhhRy9DYjlCb1RMUmRZ?=
 =?utf-8?B?RVcwaTJ6NnprWUlvN2VtcTc5VkhaZUtuLytqWmtEVGJ4NCtUTWJacytHY29m?=
 =?utf-8?B?Z0ZObkhJQUxFQ1VoTytGcWZNeTVQOWNjb01nUllibCtNWDNleHZPSjVNbmhY?=
 =?utf-8?B?VXdJMTl0bHo5QjlFV0NiaEl5cXFBUWZMOHA5Q2dlTzg5d09IU3ByQlB4Mm5F?=
 =?utf-8?B?RlVhYVpUWlc3TlRnczhxTW10MVJyU0RaSUZMVzdRVlljczhvS1Y0Q3MxY1lm?=
 =?utf-8?B?eDJJT3dGK05Wa01hZXR5aTZGL3IrakpuMUViRHlQaXpLOURvRUVwWlpORWNY?=
 =?utf-8?B?UDdkemJRODA0MjBkN2ozM0pVcEF0VHArZVVBWnBpdmF6cG5HMGpQZHJWa3RI?=
 =?utf-8?B?dTRBd0I2WlVkN3NtczNidz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4877.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHBCQVJPY2JjZXZXRWZtQURPTENyRFkrbFM0azhSS1FJMUkvRU1jVlJ2TjNH?=
 =?utf-8?B?NXlDckl3V0VDMFh2cmZDSWNXd0FFVDBmcTRLK1cxNEF0aHExK1EzbUh0c3Fh?=
 =?utf-8?B?WG1sQ3VtWWYwRUxmVUxyc2JSUmZTclVtQmZPMTMzOHdBZHZ2bG9YWWxiODFy?=
 =?utf-8?B?emJ0ZlV2bUpVVENwYUQzQlFCYS9vbENQejhMQ1NBMXBXeGR0ckVLQmNWTXdt?=
 =?utf-8?B?QTlaUkl5cWVPUEFZekk2QjhOczVCRldJM1NzRzVSa0ExMnBCa2szaGpUNVRZ?=
 =?utf-8?B?SHU1VndybGFkZFVIZEZoYjZta2g1dkpwZVNuME15NnhIdnYxaSs1aG5JSG91?=
 =?utf-8?B?N1E5ZzRGK2RWdTNNN2hzaUgxS25IZERZN2xhN1QrNGYwVWsrdUdLMWZ5cHU0?=
 =?utf-8?B?akU4R0thVnhwWXViRDhQVUp6R0Jlc01yM2RxdlJjSjdSVnZ6REUwK3RtWExI?=
 =?utf-8?B?b0E3Zk55bWVINHFsY2UxRWUrWXorMitWN2ZydUFMNzZOcElYNlJva3l3TURq?=
 =?utf-8?B?UVVScjJrQkpsOHM4ZmZoWDczSlZLdnBwalg3ZHJIT0hhcXorUWgyREFDTHMr?=
 =?utf-8?B?aFBpQ2NxMU1MNUJOeXIzM1piZUJhYXpYc1Rzdm9pVkFrT2dMbGlzNGZqNzJi?=
 =?utf-8?B?RWhxcmJFQ2FDeDdwS0ZzeUo5YTNYU1dPMW42aGFjbHM4V05LMzUzZlhYamcx?=
 =?utf-8?B?QklaN2N4VzB5eTJ3TEJDa3g3aGtoc1RLa0xZeVBFRiszUDZMbjBaODZWL0Zm?=
 =?utf-8?B?dWhNV29wZTRWMHN0aFFLNmZnR2VaYzNsZGVraWJ5bjZHUDVDdnVDU3hySnZB?=
 =?utf-8?B?RjY0RUdNTVNIRTdCbVl3V1VxYnlZNVM3eTU0aDl6QmhPTDUzNVUxTW5MQncv?=
 =?utf-8?B?SXpBWTcwMmRwL0NHdGZDaTc3Q0huUmU4enM5NnJuNmJEcjUrUjl0bkRObTZN?=
 =?utf-8?B?c09jUXhYSjVqMUlnS2xYb3FTckEyd1UvQ3NmVmJSTFdUZHJLdTJIQy9Dbnh4?=
 =?utf-8?B?OEEzZXV2LzRvc0VVanpKMGpKUlZVRTE0V3BJS0JxUHNobTk4UTBPbFdOZ2E5?=
 =?utf-8?B?UllxZWwyUGJ1R3hralIwbHpQMGJZellBUjNrNFZML0JlNnFYUVhSRHZRQU55?=
 =?utf-8?B?ZlF4QVZVNlVvQmhua2NGNTRTSlpEa0JjQnJBNFZoVHRGOS9XWFRmZktIdW5P?=
 =?utf-8?B?ajJpRGRyU0lSNU9TeFZOS00zc25HV1lXRHVaL2l1MnZXOHduQUd3ZExncDBt?=
 =?utf-8?B?R2VUd1pNOXpTUFNKNzdLVVE0cWFMK2djNjdtRFlMZFFXMk9RR2NjczI2SDd0?=
 =?utf-8?B?MGJ4cnVwZ2hnQVZ3WlF3bFJYRjh5UUlGSXZWVktNeWw4UysyVlNNSVdQM3No?=
 =?utf-8?B?MWw0RjNtOWpkRmtpWjB6c0FqdHBJd1FVUStlZEkwbU1hNnVWdW0xY1NkdzVF?=
 =?utf-8?B?a3Q1czdxaG5JN3EwOGVxajFubzMwVUNsVzJ5RUdnNW5uOERMUmliSkM4OHl6?=
 =?utf-8?B?SEkrUWU0R3FDU0tVdDFMNTFzNGRoMTZvK2FMclg4Z2dQckgya25oSSt6MW5V?=
 =?utf-8?B?dk9BUElBbktvdjJOSm1QOXlTZS9CL2orb21lem1UdjF0Q1VybEpEU2VuNXJw?=
 =?utf-8?B?NTRMYTVuZyttandsVllhWDc2bHBra1ZNaVBQTXk5eWhzMnNBSno4U3hsQld1?=
 =?utf-8?B?WjBveWFRclJPL3ZmUjY2cm1NYzFlRlJ2eUZ4RXVUVzNOZzUreVh5bGJiYjVr?=
 =?utf-8?B?ZUFCelBXZXpjMWdUUGZveS9DVnJPaXdvUVVpQk9OSld1djdsL0pORFVsM3cv?=
 =?utf-8?B?SEhNUjA3TFBQWDg1cDQrTGtBTitPZnFwOFkvdTBtVFRWdWRKWktFdVltOHlw?=
 =?utf-8?B?TUZvTWdoQ3daZE5LdEJ1dXBDWnlwaFdHa21MTjdOd2NFS0o3NUU4UzVEMCtk?=
 =?utf-8?B?M3dDYVB1NEZtUG1LU0RDZWd5cEMwWlRvRjdFVTFnaDd6SEE4VC9LNk81ZHFO?=
 =?utf-8?B?RE5sR1BJRGZFOUJ4TnhldEZYSUxxSmcyeGRGdzRFTVBzYzFyZTlDKzdvZ2U1?=
 =?utf-8?B?WUlOSWtDbDlMWGJZdjl2RWhVemNvRHdlbGQvU3M1cUhJNWV6dEZLUHNwWVRs?=
 =?utf-8?Q?MB90=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a880ef4-7cfc-4f25-027c-08dcdc0cad4b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4877.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 20:16:58.8700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nt8E3JmUKLIp3t6kXNDYTIZLm25qfoeXcfXbFL6iPJGSjaVK0NIjM8Q+oNyVsEKh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8159



On 9/23/24 2:25 AM, Lukas Wunner wrote:
> On Mon, Sep 16, 2024 at 04:25:03PM -0500, Wei Huang wrote:
>> This patch can not be compiled directly on pci.git tree because it uses
>> netdev_rx_queue_restart() per Broadcom's suggestion. This function was just
>> merged to netdev last week.
>>
>> How could we resolve this double depedency issue? Can you take the first
>> three TPH patches after review and I will send the rest via netdev?
> 
> Just rebase this series on v6.12-rc1 when it is tagged this Sunday
> and resubmit.  pci.git is usually based on the latest rc1 release.

Thanks for the advice - will do it as suggested.

> 
> Thanks,
> 
> Lukas


