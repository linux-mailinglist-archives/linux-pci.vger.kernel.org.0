Return-Path: <linux-pci+bounces-40960-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D0633C510FD
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 09:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3B2284F3AA6
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 08:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE172F3C12;
	Wed, 12 Nov 2025 08:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="ngzOWlR9"
X-Original-To: linux-pci@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012049.outbound.protection.outlook.com [40.93.195.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AE52ECD34;
	Wed, 12 Nov 2025 08:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762934790; cv=fail; b=pbqC5bClRgnWIHuDPTW0NcmBzppGYepb/WyjZsdmPekg8qkEj5rCI3t1gfSHRqreaIGRqdqfo/beYTa7bnGwwJKfI66b1j4B+fD9kcbswb0FZWOUft64nTxw/ift1IfIfZisGgeyfVkc9lTh/CWcWahdAhQiKA6L0NFhzxFvCYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762934790; c=relaxed/simple;
	bh=kxUmm4RdxRTfTor7IQDVEhkOgwHaPZnqSLzEweE+H80=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QGCXTA7UlfuHrst5n3ed0YRdA4EwRMWqAzXhzdj0qct3lRh11L4UYIC/CmA1dDwzG9UaswT1wUWoCj4qNs+e6b+Xb2aaZokMS2mfTU9iSduawAMD7jXqdwfmmVDi8+IVw/gZYF25uDBoML/U4zXxMG3fM3Ix1IKfa7n0SrqFLzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=ngzOWlR9; arc=fail smtp.client-ip=40.93.195.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZouAj7AhL/BkBx4cdt/c/JJ/Ncqv5WcHHKCP0X5bUUk0AZHUJQIiiAecbHuOcVdvdfYsUXR2uwYGbnZaljdvKLCDuC7BSXOj+1+3NRr4ItSnrdfgDRI0XE01bpEpeCHyJYvyQTQ9ohoL1IqnU0862M5dpUUL7+m5Sa8io+uRmwb/3RNGH9PiAJtFTtK8ZJnG6BcG3ysW3UwmDCw1pxbLWZZ4dI6cnwEOSJOn6haNtWL/BJuan3N9rbJbYvi5mK/WwkawvAJ+GT5PM4FlLJ72AcCnho+y7k7T4Kj3dXlCvT5mHb7JDmAtHiTAdiB1l7c0eOSveTyYQADEI1pbWR1t8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LKYmegH3ykHGiWV1hZKmrDw3+XreT4d7ug60Uik8NjY=;
 b=zBXoC7ZiMa9ElI40t/wL59FujROvSr/vsVSUbHU8DMATZafQl1xzqIGwCY7ZvhjwIlIni/tg3cmfXxPLKSebpcBj6vqHeMpcDCJkRJU/giUEV8FkHIgOiS+80kts2q+TPpObOmCi204guKF429dGJWTKRz3Zj1TpENjWHwwAca73evg85WHjlHAqS3rqdq/s32v1i3Fb1KCvxTjG/dImT2Pn4cCmassW+bAudYvvyvYUoIM2e6NYBtVtNlrrDjy8nF/5GS7jYt2f4kIStmADApoTWKRUNTNCiTnccjkhrzO6/nXwNyrES5K4vcdXPZCCEsKKX/sN1euGydvC2Pt7uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LKYmegH3ykHGiWV1hZKmrDw3+XreT4d7ug60Uik8NjY=;
 b=ngzOWlR9HHenRcNT4vNyCG0iWzBW5wOfCf4vgi/9z+VmAry9jxiKcxAuofHbuxnRYyAG/0ggp2W1TwxZtnN1TBX9LCxs0yrDoPt2QAHhBo3ip3n6C6oElWIbyCF1OPJcAqFvmhRwjKrHixsea2IG+WeKuFQtjdwpmqShxUPvHQRZri+1Zb6k/Ouon1A6Tv3PYWy4PwK5lEbfjR1qWugV1zYAvmHglc1lb8KvzocMlCRHAfgcVydpHxtKFgkWNB/1DtIivQ3SjXrJUGwgCZ3W0SroOQeonZ383dr7D7KUGq+UW4QruJItm4n88WyE34lBenhgZaMuLsdGSoQrf+YFTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA1PR03MB6498.namprd03.prod.outlook.com (2603:10b6:806:1c5::7)
 by DM4PR03MB7000.namprd03.prod.outlook.com (2603:10b6:8:48::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 08:06:25 +0000
Received: from SA1PR03MB6498.namprd03.prod.outlook.com
 ([fe80::feea:da58:faeb:9ebc]) by SA1PR03MB6498.namprd03.prod.outlook.com
 ([fe80::feea:da58:faeb:9ebc%4]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 08:06:24 +0000
Message-ID: <e940eae5-16bb-46e1-83aa-47c6ff747083@altera.com>
Date: Wed, 12 Nov 2025 13:36:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/2] PCI: Configure Root Port MPS during host probing
To: Hans Zhang <18255117159@163.com>, lpieralisi@kernel.org,
 kwilczynski@kernel.org, bhelgaas@google.com, helgaas@kernel.org,
 heiko@sntech.de, mani@kernel.org, yue.wang@Amlogic.com
Cc: pali@kernel.org, neil.armstrong@linaro.org, robh@kernel.org,
 jingoohan1@gmail.com, khilman@baylibre.com, jbrunet@baylibre.com,
 martin.blumenstingl@googlemail.com, cassel@kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-rockchip@lists.infradead.org
References: <20251104165125.174168-1-18255117159@163.com>
Content-Language: en-US
From: Mahesh Vaidya <mahesh.vaidya@altera.com>
In-Reply-To: <20251104165125.174168-1-18255117159@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0070.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b7::10) To SA1PR03MB6498.namprd03.prod.outlook.com
 (2603:10b6:806:1c5::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR03MB6498:EE_|DM4PR03MB7000:EE_
X-MS-Office365-Filtering-Correlation-Id: 55c0c3a0-5d68-48a4-a02d-08de21c25f1e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TFRFRG5aY3JHOEZTMFlxZ3YxQTFNYlM2Vy9iaFh5MFhaNlkwWTNEWFduVlds?=
 =?utf-8?B?ZndNS0Z3VEh3MDdYK1dqcTA2aC85QWE4OHlUTS9HN3pwSmdpT2F1eHRIM0Ru?=
 =?utf-8?B?N1JCR2JpOXRLRjhISlpSeXdZejZ4VmlENHFncW9sRStqMVZBL0ZjenNnb3Fq?=
 =?utf-8?B?WjlKUHJjNDdJWGQ5Qm95ZHdRUjc4TTVDUlRmb0tGSUh5MUV6akkwOVZxUDRW?=
 =?utf-8?B?VnJNdXBoVmM0SHNXTElDQU9OVWZUdmk2eU1SaEZVYWJpbDFOeTJYSTA3OTJX?=
 =?utf-8?B?RGh1WlBzOE1YSEFlbzdCeSt3UkZVTTlWQzBxeHF5OGNEVFhsZkhqeTNLbHJK?=
 =?utf-8?B?WkpBWFlqSEJST0VqcDB4UWhVN2JQam00QVh0Sk9ldUQvcWR3Y3A3NXhlWnBT?=
 =?utf-8?B?OVJNdkJVcEQ2UWk3SGY5OWhiaEoyb0lUcmRIS2JvT0VuZkJyeFRpaUg0OWRk?=
 =?utf-8?B?RWZIOWRIY0oyTC9kVllpdDBJQkhUcGYvZmFsL0I4OEhkbTV4NUZIS0c1MTcz?=
 =?utf-8?B?R21kNjd1ZVh2ME1sLzJsQ3pHYUNoOVNZNXdMOTF6cW1yUDJTRGlFUjNBOGl1?=
 =?utf-8?B?MjVmL0VSQzRxTit6MWQvZW5yRWZxZ29Xazl0NHA3ejJYeDlWeE81VSs2akJr?=
 =?utf-8?B?Qm10OUtreHF1RFJQVUNhMG40NmhtdE9CaVZhMHVrWW5QUElabktLZWhXa201?=
 =?utf-8?B?UCtYWFYzV3pkWHIwUW1Xa0ZzdHVvbndZVlpDbTAxOC83ejNxR1JpMTY0ZUJo?=
 =?utf-8?B?c0pPK1ptUWhLakNrRm1HT3FNSVl3S2NCcUEycytpV21BSmtDY2hzaFhmRDly?=
 =?utf-8?B?NG9kRy9oMy9iNERKMVVqK0NDd0o5WXdiK0FEdXJ5QUhMdlc2YlVTbU53Zy9X?=
 =?utf-8?B?bThJVVVZWDErMzFTcWZkUzRMSmZVSjhYWGZrc3NxeURuNDRPWFFZWnZNSGU3?=
 =?utf-8?B?MExjMW5NTUdheEdKc09wejdiUXRPeVBCZHNyQ1B0TnRDeThZdXRxeGhRTlNO?=
 =?utf-8?B?cXdmZUZRckxQUDBEeXhZbEdiOGNqOUdiMS9ERngrZzU5L2hIS3BaU2xieFZL?=
 =?utf-8?B?c25SUEZjQ2YvRUhmTVpTSnBXYjc3UlNYUXJDMkNUUWFVOXR4S1h5elJpd3Vh?=
 =?utf-8?B?bEErdEUxdE1SY2d4N3pZdkF6dCsweXdLN3FreEFDUzA0T2lzQlZrUHFYL2J0?=
 =?utf-8?B?RmxyTzNXWjFBTkdWUXA4MkZEc2d4d2s0dDJ1V21vcURpcEExT3pMVml0clZq?=
 =?utf-8?B?eG9tSHBjZHJFU0ZiMi9FcnpSUHByYzN2R1NMS3hHMWtEZTlvbmcvOGlXWUNN?=
 =?utf-8?B?N1F6czdVSUI2YkZ2L1ordjdwUmcvMFJzTFo0TFV4ZWptTTYxNjg2c0ZPM3ZM?=
 =?utf-8?B?NFpGc1c5WDc2SlRod1RBVTVaL1g0bG5GeGxkb3pHeFFuNWwrb1lrLzNJejFo?=
 =?utf-8?B?TEZYallHU1Bsa2RmWnBaMzBFL2pPbFdCcnlOb0VXVTVTSjdVYnNkR3BvdFpU?=
 =?utf-8?B?cVltYTYwZ3hoRjF1TXErN0RkWkVxbnJTaTFNRFBwODhEYnQ2NlVieG13cC8r?=
 =?utf-8?B?K2JOZXV5M0JRV2NSd1U3a0lDdGRzQTlsSkUxN3dJMSt3dVpUK3hzQXhaVFBs?=
 =?utf-8?B?eWxTcTh6aGZ1Wk93am1oOFl1NlhFYzVka2E2V01EUXJKdmNpWStvMEJtTkZU?=
 =?utf-8?B?bGJwV3hMU0hSU3lBeVErRFVmTWN1OEg1eHk2UGJmN2ZPRldjWXRCTWg4ZytJ?=
 =?utf-8?B?bHMwMzdrdy96SHdzczlkUHFMT2dmTzRxenI5OEJweGxWa1hjb3loY0h3SUlG?=
 =?utf-8?B?cVlGUXA5YTg0dnFrRVpseGRNR2EvZTU5eW9jMnZSTU5tamt4TmpSdDhOVmNK?=
 =?utf-8?B?Z0JMVjQ4YW5qaFVHR2l2OVNUM0NpaklFNmtuZk5oVWRuYUVBMCtBZHhZUm5q?=
 =?utf-8?Q?g0P5lv7C+yNNPkEg1ILEZEk06OZFDG5N?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR03MB6498.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NHdzYVBISWxjY2NlcThnOGVxcmJHWXhVdVhXZ2hNdTlCUThPWTBmUmFKdDYw?=
 =?utf-8?B?Ti8wdzVmU3UrcGVSZFFtaFBqUnFsVG5laXFqVlI1V1EwbHpQcE81L0JwK2NW?=
 =?utf-8?B?ZkRGOCtQTUY2UEVRbVh6QWZnOStEOTBuTUNnanpyaysvOS9xMmZ4Mm9Ed0la?=
 =?utf-8?B?UkJTTnB6QmpRMTBlaGM4SVJZTVp5L0dYUzJ5aGdhM2E4ZVdUS0Roa1htZFZl?=
 =?utf-8?B?MitoWkExWWhZRkhiTkxqZHhqbXZOQnFub1J3TWlnQjQwU0tLZDBFOVBzQ1lJ?=
 =?utf-8?B?VWFxblBmRno2bFNYZkdqNzVMaytEZmtwM2M5dVNHSG5nTkx4TTZIUENTZHE1?=
 =?utf-8?B?d1NrUW9Bam50WVhRQ3B4aCtZZ3ZvM2Mzalp5UVF0cW1zWEtLd3ZhcGdPUGlt?=
 =?utf-8?B?djA0bVRQTVBFSjFhU1FrSG9MaEZpUm9IbDduRTVvelZsQ3FkazJQZ0dBRVpR?=
 =?utf-8?B?N0FuV3l3REJhaFVBVkU0YXNoSFgvYURuRGhvQnlBMENiWEdDY2hDRkQ5NTNV?=
 =?utf-8?B?ODhXS1BsZWpneitMSnc2YlFZQ3dyT3phSXNaWnNhQWFXbU93aGYxVThycFI4?=
 =?utf-8?B?UVdsV00wWWtMcXk0ZkZqWmpVUCs4c2VMY0VKNjFkdTNJdy8wNEY0L2szczgv?=
 =?utf-8?B?QWJjMEhwQldOc1VwRytHRzlabnIzazBVelhjTmJaVy9BTHNkUGJoVzYwckxx?=
 =?utf-8?B?Mnl0cHpCc21YNVVwL3Y3dzZzSmR1d3p3MjJKaWxkWExzZnhWdkdOQlA5dU9R?=
 =?utf-8?B?d2RCc2k4WWNweTU5ODNzZlhkOVZxWVdyL04xM2RLY2dBb0ZGZzZvVUZ4QUlX?=
 =?utf-8?B?K21iUnNVbTNqMCtqQ1RlRVNKdlpWaHkyVE9aUUNWaTJrZmdqUGRKM2pITDVp?=
 =?utf-8?B?SE1qY3FoeGxhU3QzSFFvSWhQZmVpbmh6MnBLKzNGOTV3bUdwV2I1cHpXQk5z?=
 =?utf-8?B?U3grL0s1WlVlUGYvQWVWUDY0NDR1Mm1hdjVDdFZNVzJuWVhSU3REQXFTWDA4?=
 =?utf-8?B?KzRYUEtES3NyRHl1ZzdPM2tXS3IzcytIeGFOMXlEUWtRMytWSjRPSjdUaUE4?=
 =?utf-8?B?U2VsRnQvN0h4aU4zOUQzRjJjckdhR2RuSlRwOERJSzNLdG5JeTZFU25HcWFS?=
 =?utf-8?B?d2ZrSUlYRmJKOUNGVThNTExoSmMvS3Y4bzZNQ2RrY1NxRVVWakFxN3VTZ2Rq?=
 =?utf-8?B?VU5JVlYwb2syY1YzTzVQVExTVmZ3UXhYRzV4bEs2L1FoSnh6c0lkYzFscXNQ?=
 =?utf-8?B?NldCZklVc3R3TWFHVTBWOEJXREhrZ2tKV1BzeUZ3SUpaZ3lLeEU0dEdQQzNs?=
 =?utf-8?B?Y2NlYVRITHJxQXZXOVpWWHJaTkxldzFJLzZpRk42L29vSlVGZ2E3LzF5citl?=
 =?utf-8?B?UkVvQklEeXpQRmtFS20yY1g2R0Y2T09xSWl3ZGNxMWFnNVFNOGhubjVsTnJL?=
 =?utf-8?B?LzhVZjdUNmpnazNKNW9wN1gzOHlrSFFEbmZhZm80eWpxSG5CdlVQUlZuakRj?=
 =?utf-8?B?UGpLVi9RY1IyL3RJalA1clY3bEROVHRRZXV5MUx3MVZDeUk3Z3NmazZYY09K?=
 =?utf-8?B?eHJ0dUNYNTVMTi9sRUUrWXhGdE0yUkh3UTdVYW5MSnMwZzlidEZoeEpGNzR6?=
 =?utf-8?B?TGZiaHBkck94Zll1UjlpYXVmekFlcnVrelhiOTFHdDJJK3B3V1Zqb1FDMGtj?=
 =?utf-8?B?MDBXRTVnWkpremtBUmFjVGVMalNvamlvbXdRanNOa2xhVjczVzE3WldYRjIv?=
 =?utf-8?B?YzkrVTZIZDlJNk94L1BVMFNNdTB6MU9JMlVSNW14YXNBb1liMm1UQmtKNjlE?=
 =?utf-8?B?RktvdXF6YkxKWnJzWDAyczhvd3FabC9KY1JvWVlaWUdGcWN5ZlVUSW10K1ZT?=
 =?utf-8?B?cURLdytiQWJRMmxaM3BKbFRMNjNJbUZlRWp5Z2w2Q2xhRG1HclJNUjhZbWhK?=
 =?utf-8?B?QWpHV1RQUjlqelpHYVFFQ1NlaWpDd3pXeVAzWTZBSGxsUmV5ZG9XYWdXaFpB?=
 =?utf-8?B?bjN2Tld2RGxEVENYUVcvYXNib2JXQ3FnZk9KVWJlL0JuWmNBTHlnaXl2WHUr?=
 =?utf-8?B?elBYTWd6M1BCWkF4VGRFSlN6VllKRk1vSFdPa1R5bjg5WUQrTkR1SkQ4amVo?=
 =?utf-8?B?RVpoK1h4dFVLZEwwSzU0VG5NdGJIbkZuOUc4T0x6UkgyeXBzMTU2QXlqYzlM?=
 =?utf-8?B?OFE9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55c0c3a0-5d68-48a4-a02d-08de21c25f1e
X-MS-Exchange-CrossTenant-AuthSource: SA1PR03MB6498.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 08:06:24.4441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ATzkl0ezhRH1rKwHFVjR6VvB2DeXAHGSVnh9bP9gySdrum6KjFHRLjh8ZSDLbIBMQylD0+piduR/16+6hgd8/w9M3WwfgKyOH7Nvu6GEXeQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB7000


On 04-11-2025 22:21, Hans Zhang wrote:
> Current PCIe initialization exhibits a key optimization gap: Root Ports
> may operate with non-optimal Maximum Payload Size (MPS) settings. While
> downstream device configuration is handled during bus enumeration, Root
> Port MPS values inherited from firmware or hardware defaults often fail
> to utilize the full capabilities supported by controller hardware. This
> results in suboptimal data transfer efficiency throughout the PCIe
> hierarchy.
>
> This patch series addresses this by:
>
> 1.  Core PCI enhancement (Patch 1):
> - Proactively configures Root Port MPS during host controller probing
> - Sets initial MPS to hardware maximum (128 << dev->pcie_mpss)
> - Conditional on PCIe bus tuning being enabled (PCIE_BUS_TUNE_OFF unset)
> - Maintains backward compatibility via PCIE_BUS_TUNE_OFF check
> - Preserves standard MPS negotiation during downstream enumeration
>
> 2.  Driver cleanup (Patch 2):
> - Removes redundant MPS configuration from Meson PCIe controller driver
> - Functionality is now centralized in PCI core
> - Simplifies driver maintenance long-term
>
> ---
> Changes for v6:
> - Modify the commit message and comments. (Bjorn)
> - Patch 1/2 code logic: Add !bridge check to configure MPS only for Root Ports
>    without an upstream bridge (root bridges), avoiding incorrect handling of
>    non-root-bridge Root Ports (Niklas).
Tested this patch series on Agilex 7.

Tested-by: Mahesh Vaidya <mahesh.vaidya@altera.com>

>
> Changes for v5:
> https://patchwork.kernel.org/project/linux-pci/patch/20250620155507.1022099-1-18255117159@163.com/
>
> - Use pcie_set_mps directly instead of pcie_write_mps.
> - The patch 1 commit message were modified.
>
> Changes for v4:
> https://patchwork.kernel.org/project/linux-pci/patch/20250510155607.390687-1-18255117159@163.com/
>
> - The patch [v4 1/2] add a comment to explain why it was done this way.
> - The patch [v4 2/2] have not been modified.
> - Drop patch [v3 3/3]. The Maintainer of the pci-aardvark.c file suggests
>    that this patch cannot be submitted. In addition, Mani also suggests
>    dropping this patch until this series of issues is resolved.
>
> Changes for v3:
> https://patchwork.kernel.org/project/linux-pci/patch/20250506173439.292460-1-18255117159@163.com/
>
> - The new split is patch 2/3 and 3/3.
> - Modify the patch 1/3 according to Niklas' suggestion.
>
> Changes for v2:
> https://patchwork.kernel.org/project/linux-pci/patch/20250425095708.32662-1-18255117159@163.com/
>
> - According to the Maintainer's suggestion, limit the setting of MPS
>    changes to platforms with controller drivers.
> - Delete the MPS code set by the SOC manufacturer.
> ---
>
> Hans Zhang (2):
>    PCI: Configure Root Port MPS during host probing
>    PCI: dwc: Remove redundant MPS configuration
>
>   drivers/pci/controller/dwc/pci-meson.c | 17 -----------------
>   drivers/pci/probe.c                    | 12 ++++++++++++
>   2 files changed, 12 insertions(+), 17 deletions(-)
>
>
> base-commit: 691d401c7e0e5ea34ac6f8151bc0696db1b2500a

