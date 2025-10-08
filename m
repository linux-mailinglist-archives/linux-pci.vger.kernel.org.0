Return-Path: <linux-pci+bounces-37744-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB614BC6F1B
	for <lists+linux-pci@lfdr.de>; Thu, 09 Oct 2025 01:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1C503C3E8C
	for <lists+linux-pci@lfdr.de>; Wed,  8 Oct 2025 23:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C6B259C80;
	Wed,  8 Oct 2025 23:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=llnl.gov header.i=@llnl.gov header.b="H/jIiMdI";
	dkim=pass (1024-bit key) header.d=doellnl.onmicrosoft.com header.i=@doellnl.onmicrosoft.com header.b="H4Y2txTr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0f-00379502.gpphosted.com (mx0f-00379502.gpphosted.com [67.231.155.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E92A204F8B;
	Wed,  8 Oct 2025 23:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.155.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759967346; cv=fail; b=VjSXj+dHxsnA11L/UqSDuDr2IduOdg/mPuUwG8X0/2f5DM88v0asH4UzML0bvmAqmpt/sJ0KqkxNlpLEwhpqTiXHu5y5zrhx+TTlGdDVrA15MzOW4+DHiiAeGjE9tc42RT0UWrcN0dcjsRmczK7J3nMXTGUkPfe6Y4zNc2+tkWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759967346; c=relaxed/simple;
	bh=9m5Wg8XBtVkGwPlk4u5H2s/c9zObku3ESFNh+Oibtx4=;
	h=Message-ID:Date:From:Subject:To:Cc:Content-Type:MIME-Version; b=RwRXehUqiSvlXITZHifMaeMGl5S+rsNQnLwLxc4omVfKwhs3b/HEyeEw5s8pF/jQ14kmaU/A9629Py/RKE/KoMsA6mz4q+yt7ygTj3rC2tJnzhO1+0aSTtu9s0fCJF5Tdzd1vUxHsZWyVWs/kBnohRaMWhzXzAoncBNWAXQhReM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=llnl.gov; spf=pass smtp.mailfrom=llnl.gov; dkim=pass (2048-bit key) header.d=llnl.gov header.i=@llnl.gov header.b=H/jIiMdI; dkim=pass (1024-bit key) header.d=doellnl.onmicrosoft.com header.i=@doellnl.onmicrosoft.com header.b=H4Y2txTr; arc=fail smtp.client-ip=67.231.155.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=llnl.gov
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=llnl.gov
Received: from pps.filterd (m0218362.ppops.net [127.0.0.1])
	by mx0f-00379502.gpphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 598H9f0G005515;
	Wed, 8 Oct 2025 16:48:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=llnl.gov; h=message-id : date :
 from : subject : to : cc : content-type : content-transfer-encoding :
 mime-version; s=02022021-podllnl;
 bh=2PN0GDAJoz3NLi2NhpsY4KoOue1YQ0Yhz8H4TdQuqMQ=;
 b=H/jIiMdILM2uLnthKacA3lma+jKfRp2VsEGUvkZcaEOJdXB4qGfyP4jMS8XxW0sfsgXz
 BE32bEBukNBIgGnDfXXpwWqDmR9Az6g3MZhzekba+MKsDZfrfIr8dV4HK68Zc0BNojzD
 rKlh9JYIyDPeHvvVKKaqM9FPwFFfhZxig6L9eAiugMpAE5qaxWQQE1W0dwyzcAd6vWvt
 DB+hLG+2XnmjWDe9kxa3rSuA1a4gqaIOLLFLl1MLif7jI/JNF24+MYebhu4JVyn5dZQ5
 GpdiQAI41G9uJewQicEHwSf7Vmt3qqwAommL/ACKr2pmPxJtioS1f52lhcB9gVmlliH0 aA== 
Received: from ch1pr09cu001.outbound.protection.outlook.com (mail-northcentralusazon11011017.outbound.protection.outlook.com [40.107.199.17])
	by mx0f-00379502.gpphosted.com (PPS) with ESMTPS id 49nv42guj8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Oct 2025 16:48:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tkl8EiGU9rJaW7RNr29fe5faeGBaC+JHGNtXkjD54oxMrI7xsvvbf+9stkjFwrAskqb1pP/EgR+RDc5x3gKBfDy7FdGO1tVrG9s0JZhcM7GOePNJh1XoRh51FbM4XhSiOFj2At2VXh1bz28DvAqzJd7IlwpMPLsHIg21JNSBq/GvhZ3ZWD1LkbapZNT5XrWrj9rt8JfCyRrDtm99JmqGRxNpB3k0eSmAC+iU0Y+cri0l7+8lcU1t2L3sb8pG5WE4/MU88HaseiEY6qDtDDWWOEU3Q0dAvzWN1HJZc3zFsrDunPd5NesBKRaYXN0IAAPCCNtT/VQmjRFiYQNGh880zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2PN0GDAJoz3NLi2NhpsY4KoOue1YQ0Yhz8H4TdQuqMQ=;
 b=OegXwZksL+8eU1JxAS/pVxzrwwJvY6Q6EG9Lq8UfXU9lpko9sADt3ZRD1An/o0Lbiq5tobu4Y6DfGfFK0LuQZiMq5foLlzUxXYWBpYJHB+svey6IpSlBYxIrgGQMr85XJ0nv6p46xZjXG76DD2sP1b2z0n0/QE/pTI5kFsZ20VpSGhV1iGPDUPST65JUvEsByCPZxE8JqAqyvxvHhK7RjXk68mAska32t5d9qQSNHW3Bi3ObHEKvhIdShuQR/tRzcdv33PtqjC4gbkGWrZAU3fRDJTpURC+YAEYHKQ18NnERD/WQuSZoLhP4Mq9sNOlbGR2S5YxELwCaq1JD0wz2XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=llnl.gov; dmarc=pass action=none header.from=llnl.gov;
 dkim=pass header.d=llnl.gov; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=doellnl.onmicrosoft.com; s=selector1-doellnl-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PN0GDAJoz3NLi2NhpsY4KoOue1YQ0Yhz8H4TdQuqMQ=;
 b=H4Y2txTrMHR9vWtdZAg4gvXmgsN/14qYedYJC9uWUepbfMeBF0hHUhhAzINDqnnoFaW6KjU67I43xWVcdx2n/Va9FBDk+mHhE+eNV65vBaXfk6wzBE7aY9CkeR+KSJi0h9oNrWNgnt5MUzoJlCe6TXyBk+TkZ9ITyy2+FI1Y/ew=
Received: from SA1PR09MB11481.namprd09.prod.outlook.com (2603:10b6:806:372::6)
 by DS0PR09MB10530.namprd09.prod.outlook.com (2603:10b6:8:174::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Wed, 8 Oct
 2025 23:48:25 +0000
Received: from SA1PR09MB11481.namprd09.prod.outlook.com
 ([fe80::f6b3:25b7:844a:6d8a]) by SA1PR09MB11481.namprd09.prod.outlook.com
 ([fe80::f6b3:25b7:844a:6d8a%5]) with mapi id 15.20.9203.009; Wed, 8 Oct 2025
 23:48:25 +0000
Message-ID: <d485bd74-e49d-4c89-b986-1b45c93e7975@llnl.gov>
Date: Wed, 8 Oct 2025 16:48:22 -0700
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Tony Hutter <hutter2@llnl.gov>
Subject: [PATCH v6] Introduce Cray ClusterStor E1000 NVMe slot LED driver
To: Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>
Cc: corey@minyard.net, alok.a.tiwari@oracle.com,
        mariusz.tkaczyk@linux.intel.com, minyard@acm.org,
        linux-pci@vger.kernel.org, openipmi-developer@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0120.namprd03.prod.outlook.com
 (2603:10b6:a03:333::35) To SA1PR09MB11481.namprd09.prod.outlook.com
 (2603:10b6:806:372::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR09MB11481:EE_|DS0PR09MB10530:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c6d3510-b6bf-45d6-8222-08de06c52bdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|19092799006|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dzF6OEY3eXg4K3pNVWE3UFhwU3hDYVpPVzd2bjJvWmQ4WnN1R0JvZVhHbHAz?=
 =?utf-8?B?WjFXUVpmeUV1Wkw0bFRKajlHL0dNQWdNaUd4bnE3bi9iNzdUeFBiYzlZazNC?=
 =?utf-8?B?SkV6bFJGUzlUVTRnZ2FneTFsZGZLeHdlQWZLTkg0MHpUSlZUTEQ2bGplclpn?=
 =?utf-8?B?OUNzQnZIemlFSHN2Q1JQNWQrSGdMNFN0S1Y4OWZ4dzV5RWZkMmlRMk44NnFR?=
 =?utf-8?B?Z1g0RHRRUTFvUTRPZ1hlV0k3NTRZM2xjdDFWZm1xVmM1RmdCZUtDTVQ0OFdo?=
 =?utf-8?B?QUFYb1REUkFFUEY1eVBTNlhCdVRHVkdDRDZQRE5EOGY4THQ2RFFtcmlZSTY4?=
 =?utf-8?B?QTBWMVlBTlFiTDQ2cE1IQjNqL0NjQ3VXMnFsdXZaSzFaU3NDd1NiOEh4OXRl?=
 =?utf-8?B?cE1kRzYvUGs2UXR3OUp6RHNwWU94amRoYWpoMjBXYklweVBRTHlBdHAwbEM3?=
 =?utf-8?B?bkxNMVI2WHg5TTFZKyttVEdpWlZQY1oyZUtVeUM1UGpMNE1VMytYREVXK2pm?=
 =?utf-8?B?YVhmTVVkMTNjTGQwbm11SmZrR3UyMDBpU1krdkRJTE5iemFpbklISVluZVBn?=
 =?utf-8?B?SGg4dURhT1VCbWsrWTBjTzBYWURDNXpZRWxjM0d3NlpId0g3cHlFNzlIVXU0?=
 =?utf-8?B?Yjg0UkFIdUhmY1E5eEhOanhjc0ZJRDN2ZWFWZGpScGhRVUgrRWV3ZFJOdmZG?=
 =?utf-8?B?bTFueFJIRVV0V1k3S3VmbWp2U2k1SnVDNTR1T2cwempYbWVBVzk5cEU2ZGlV?=
 =?utf-8?B?ZnNUbUdEQjNFSTFxY21LbjhVeXJ5THZiQjQvblhtNFlLVU9MQ3FrWmNscUhW?=
 =?utf-8?B?T0IzSHllU2xiWHhBc05lM3R1bGVWeG5PNUk2S1dkYUVCZTJua05tcEJWR3pX?=
 =?utf-8?B?cFRIb1ZrYnRhRWducVdQa1haVXlORndYY0dKcjJFVmxkZWR6VllVbzhmTms1?=
 =?utf-8?B?VEVLTEI3WXFtWHlndzdKenVnMWQ3ZlV6TFF6VDV1TTIxa1hZVDhhWXdmcVNS?=
 =?utf-8?B?TUVXWmhIUFdBZTU4YTM1cnF2RzF4U0NBZGlRUis0azk0VFlQV1RSVXNqbjls?=
 =?utf-8?B?czd3TGRQQVJ5eEhtV1pQYUlERCs1WXRVbUF0UVVHNVI1ZlMzajhuaHJ1WTFm?=
 =?utf-8?B?QktET1dqUTg4YVVGNGZxTXcyRmtWenZWQlpIdUZBYVdrVHlyMm9zd1VFOUE3?=
 =?utf-8?B?M0JRUUxmZHdEaHp1Z0o2SlVUdC9FTFlqU0FiQTg3a1lkaHNaYVlBZ1lheWhL?=
 =?utf-8?B?MGhmYjB3L3dkTDZUT0dBc0NReE45MjVqc0RKSXhqMmxNRWpiZ1lwT3EvWHh5?=
 =?utf-8?B?dFRseDBISVBZT1Y5Znc1MGsweU15S21Mb0plUENGSndpSjJ4VEdaNExpT1BJ?=
 =?utf-8?B?TEFqNHNVVDhWYTc0YzNxdlRaZ2xuSzVJS1dKMzRlczhvNmZlTDNVcHc2ZWZj?=
 =?utf-8?B?d3RJaVdMSDJyNHUyRlZRU3VLak5tdmFKejdVZ1ExdnFuVSt6VUZ1UHpDUys3?=
 =?utf-8?B?bW5BemtOcEVyMDNldGEwMzRacUw4WGVtRTZRNWZiTDVoUG5Ud1gvRkZYdit4?=
 =?utf-8?B?WHN4WkpkeUczK2d0WkV6YzFZa1VYbWNrTlhNRDVqd0hRdGRGNW9jRXRvZ1h2?=
 =?utf-8?B?QzNLbThzTkxSY2tPK0ljakF3Zks3aWhDMk51Q1A1L1I5UnFTckxIR3hIWVFX?=
 =?utf-8?B?Sk8vUHVwMzNWUC9Ta0g1TDEyRE9YRW1KcVZnNmlwYjJuRkN2dGdrQzZsUDc4?=
 =?utf-8?B?U2hncUhNaTk3b2tWT01aWndwZUZ6T01Uc2lnSnYzUW43cHRwNnJOYU13Rnc0?=
 =?utf-8?B?OHd2WllmR3FCOVNyelVodWU4V0tGcWtXUmVxU3Z4SFA0YVJpc2RFRjhvL0sy?=
 =?utf-8?B?UE05djBQaFZqRUk5OXZ1bWtqc1dSTWx3czJLTmJYWW9FSlN4NHF6bnlUd2NR?=
 =?utf-8?Q?/xz42p7Kq3eclyYzdJdpV+2UGzw6pmyI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR09MB11481.namprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T3cyZDd0cmlxdlNlYVg5UVFMVmZHOXFOR1BJUGRlMWs2OEJrMllSc0t3UHJo?=
 =?utf-8?B?WnZCQ1pPM055SllQOEdaMzZpRHFUVzVxZFRNaUVDZVZzNDRjUDNYdEtZc21a?=
 =?utf-8?B?MVJDU3JiZXVjTmFlaDExZkE4UVdNMjY5dFpkRWMzaGk4dzFVcGorZTJmdVlN?=
 =?utf-8?B?aEVGNFZIOWFnWE1MRGRXUnBFRnQ5MElmY04rQWZRYUVPcTVBNWhvWW8wdytB?=
 =?utf-8?B?dENaMTlTbkNXNVZURWhtVVNjekRxWDg1bXpSeUxJa2YvU3BXeUpTKzhQMkdW?=
 =?utf-8?B?azF1eE9nVC9UVmVvMWluWCtNa0Z4S2xxSEhSQ0xVZWxnSzIwRkMreG5Ha1JJ?=
 =?utf-8?B?MGxQeFJ6KzlPNnZqcVpxL3FmYUZUTWlFUFl2NHh1SjNrL0llVERUaVVXU0RJ?=
 =?utf-8?B?cFVvcVh0ZDhRZFlHOW85VmlvUzBjWmFpNytQajJKbHNHZ09NUHhWbllaa0pz?=
 =?utf-8?B?Wmw5K1ZWbThnWW5DL1hWZ1pPY3NNTE8vVW1RQWVMRGljNkZ0QmhzY1hUZENj?=
 =?utf-8?B?c1phakNNb2g1WTYwUHAzY212TlAzRGhCSk5uT1N1WTViZlZZKzVnM2RjUE9x?=
 =?utf-8?B?dDZKTXpNMW9mSDd3TlJ5czJBanF2bTRQQTVDSWNqNjVHdWtWNzd4Vms3c0JQ?=
 =?utf-8?B?R3hnUXpSRzJ0eitVNVMwUG42cHVBb21iWU1ycVpGdUkxdjVIVTV0Zkl2NHVT?=
 =?utf-8?B?bk1LS0JhclUzNlBwNEUxQ3hXUmFyT1FackRUbHdnTG9yM2FTRGM1eUVoNCs5?=
 =?utf-8?B?Q1RuMkRpazVQRHd2dGhid3FkYXc0ck9kTXFObEs4emxnQ2pVbzZOZFhLU2FQ?=
 =?utf-8?B?dXIrUnBUYWhHNThwTXFNS2g0cHZGTmhIcm14T25wek9UOWNTWDA2T0pCekJq?=
 =?utf-8?B?c3FxRytxbEV0enpMcVVIOXhSenp5Tm1XMXRIUmE0cEd6dmlSdlAxMWRpTlh5?=
 =?utf-8?B?NGNqaUh0emxidEVEcm5odFVrejdGNXE0MkpTTTRaakRSYjlFNCtQSGpGcWlZ?=
 =?utf-8?B?QUpHRHhkeVFoTFExcjllVkJxbzdrbHBWU3pGajJQTkJnbTF6UnBUdml2aG9P?=
 =?utf-8?B?eVdRRk01NXRtTXVOTnhWbzgxNGFZWW5nRGx2aGxWNnFBQVZtNk9YaENUZ1lZ?=
 =?utf-8?B?cnhTN0xvK2ZqYjdESG11UTBPdU5xOHpOamZWbjdPcFZjSlpnYXBERzVuNzV1?=
 =?utf-8?B?djFTUkZ5dkVHMUswOGdPSGxKWWdLSUpPbFNNRGZmOW56a3J5bCsvbUsrTHV5?=
 =?utf-8?B?dTMrMVlPVDRPRkh1LzIzL0ZZRmRveXoxeE92dlZCU0RKMHhQQy9obk85YStF?=
 =?utf-8?B?QUlBR0RtMWJlc044amo3RjRvMTZKQnpBTDBVZGllUmhSWnZNSk9uRVVMSHBx?=
 =?utf-8?B?cjR0eW9vY0Eyd1cvMFNJaEJtcFRtNUZFKzMxK2g2WTNGRldLV3BIRWlodlYz?=
 =?utf-8?B?NitTbmVxUFJYV25iTWNHQ1I3emtTNnRiYXZMSi9wV25WTEd3d3ByMktmUDRh?=
 =?utf-8?B?VW1mVDZRODExWi9PbTlqcVFpblRYSm0xaCtaeVltK09ES1phTzRWSDRKa0t4?=
 =?utf-8?B?aFdyM01SQ2lkVGdNK0tXQTZpNEVFNm5SaUloQkNBZTdFT3d2M1JKa0F2dHlX?=
 =?utf-8?B?NlFCYlVsZExmSzh2Tk13N3RZbnVMOHBhQmpET2k4QS9neXlwMmVZTXBBMERT?=
 =?utf-8?B?aG04Tnp0ZzlpL3lTbExtcFFUcnM2WGhCQklXRVZvcnVRRVNTbXJIdWtJdHVN?=
 =?utf-8?B?UG1GU2QxcFRnSDNoTHRpd1lRSWlUOXNJMy9USDdLLzRTNCtyUldOU2VxcW9X?=
 =?utf-8?B?MXpzbTBiS29WRGpIaGtZSzJFMytGb25saUVBWGNGK2RWVW1QWlVYZTl3bzMv?=
 =?utf-8?B?T3RnQm4wTXZqQnRvb1ZNTGk4QmwvUXRKRXJyTzVwNVhhWXJWTEFXYnJqeGtK?=
 =?utf-8?B?SDBObXIrS3lGWGViM0tXMUhTZmlQdlNMSFpsZExMOEN6Mlc3bkprZkd2YjZx?=
 =?utf-8?B?UDJBNmc3ZE1aR0xlQ3BBcktyaDdVVlB5RHoyRHpEaG81eHEwL2NWSkdxSFJS?=
 =?utf-8?B?RktRSTVLeTBNOTNiVGxESDludCtlQXRXSERJSitUSFhYQmxDYnpvaEwyS3ht?=
 =?utf-8?Q?IJNfQCxaaJPoIfoClCMk77/dQ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	d7Yn2CjosehcuABzAkwJytZGZZPUogC6nBliKVIMxrcetxjr7N4Z39Ujna7bUDbYsc4K/D9u5tEnozEoF20aoGqDtwjfVIu3/hP5+uRYElljIOU/p8bJMHZjGMDVT9rhkCWO7B/oLIfDwX9MomFVMygMyt1zwDrOQGFZvAAq+TEbdDVUFCCU1tmIyEkilU4jtZh5zPv8FXF6bTKRMq5mfLx3v04U3w5MQirFnOUb1RwknrTL6oMzx/IXybeijy9uFdyWSTqSGMFO72sgxaS7wwSiueq+FjcurKU7Iz8okrCIPem2uIAxsR2wH3Jr+iRfCdpGr1deJtccRLUUVXBRe/wp2Tv6Mgo/usYogjlTGy1HiYuHJyWwF3nJqdMWHrwnoqgLVM5a3/FH0NwHLWYYjY+ozTy1dXCc2S1YZ0aQTmdRUxTAzSYo19vYa91KeXyzFTholeHOlnCOZqoiAsjGI9Wy4gX/C3smv3qHzm4Yg+fr3enLhA/wwtDjZW6SqNUMzfHeP3G/lRqErDpOcVWtQlkkJO4QhqvKP8w8g1kG+yfggO8vX5joaSvla6OEqmoKgA8UKY/22FI3XcptVV/GEg9/Ss7EdkOvNa9FA1kZ7XS+8XFD/NEKGxSkg1teY7MjGp6Dpe8IyN80V2VTl5GgAA==
X-OriginatorOrg: llnl.gov
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c6d3510-b6bf-45d6-8222-08de06c52bdc
X-MS-Exchange-CrossTenant-AuthSource: SA1PR09MB11481.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 23:48:25.0263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a722dec9-ae4e-4ae3-9d75-fd66e2680a63
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR09MB10530
X-Proofpoint-ORIG-GUID: rDllO0XNkDRMggeGZJ6pVE18Msu5UaEl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDE2NSBTYWx0ZWRfXzTOavHjwpfAd kdOaz+/ojW/0FLp0UF7K/8zVAzAlytsH6MqO5RO51+OKwicys2s1LwIcZOR3RzJc4WdevFc93fb WPZV9erTAEfiXXzWKwKQyCyRLUsuvhu866sPK/UIe80yTFL7RmtanApwn0x4rOocSMaZQPYg1hR
 +rURYA6odO1HZVnlXZQofpU7qjTkLrw9kRsrwYufhyI6IPZiunYjE7yhWKn3m+PY2eWwNAl5rBk LmuDRlIM9vqbCQh6GXKhcmjyWodPNGtXs52x68gQIsx5yt/eWNcY/ha3zX/SDNtDjb8z7DFoTcM fHHXoY8gx+lP307tIRrGJTymdxnwQq58XvTm1BCYSiMZyhgGrHl9NkgQnvIM2OQo2S+XWRoC0Pn net0qcao
X-Proofpoint-GUID: rDllO0XNkDRMggeGZJ6pVE18Msu5UaEl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_08,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 bulkscore=0 adultscore=0
 clxscore=1011 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510080165

Add driver to control the NVMe slot LEDs on the Cray ClusterStor E1000.
The driver provides hotplug attention status callbacks for the 24 NVMe
slots on the E1000.  This allows users to access the E1000's locate and
fault LEDs via the normal /sys/bus/pci/slots/<slot>/attention sysfs
entries.  This driver uses IPMI to communicate with the E1000 controller
to toggle the LEDs.

Signed-off-by: Tony Hutter <hutter2@llnl.gov>
---
Changes in v6:
 - Change some dev_info_ratelimited() calls to dev_info().
 - Don't call craye1k_init() if pcie_port_service_register() fails.
 - Fix stray indent in #define CRAYE1K_POST_CMD_WAIT_MS

Changes in v5:
 - Removed unnecessary ipmi_smi.h #include.
 - Added WARN_ON() to craye1k_do_message() to sanity check that craye1k->lock
   is held.
 - Added additional comments for when craye1k->lock should be held.

Changes in v4:
 - Fix typo in Kconfig: "is it" ->  "it is"
 - Rename some #defines to CRAYE1K_SUBCMD_*
 - Use IS_ERR() check in craye1k_debugfs_init()
 - Return -EIO instead of -EINVAL when LED value check fails

Changes in v3:
 - Add 'attention' values in Documentation/ABI/testing/sysfs-bus-pci.
 - Remove ACPI_PCI_SLOT dependency.
 - Cleanup craye1k_do_message() error checking.
 - Skip unneeded memcpy() on failure in __craye1k_do_command().
 - Merge craye1k_do_command_and_netfn() code into craye1k_do_command().
 - Make craye1k_is_primary() return boolean.
 - Return negative error code on failure in craye1k_set_primary().

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
---
 Documentation/ABI/testing/sysfs-bus-pci |  21 +
 MAINTAINERS                             |   5 +
 drivers/pci/hotplug/Kconfig             |  10 +
 drivers/pci/hotplug/Makefile            |   3 +
 drivers/pci/hotplug/pciehp.h            |   7 +
 drivers/pci/hotplug/pciehp_core.c       |  17 +-
 drivers/pci/hotplug/pciehp_craye1k.c    | 671 ++++++++++++++++++++++++
 7 files changed, 733 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pci/hotplug/pciehp_craye1k.c

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index 92debe879ffb..4c9350b11a17 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -231,6 +231,27 @@ Description:
 		    - scXX contains the device subclass;
 		    - iXX contains the device class programming interface.
 
+What:		/sys/bus/pci/slots/.../attention
+Date:		February 2025
+Contact:	linux-pci@vger.kernel.org
+Description:
+		The attention attribute is used to read or write the attention
+		status for an enclosure slot.  This is often used to set the
+		slot LED value on a NVMe storage enclosure.
+
+		Common values:
+		0 = OFF
+		1 = ON
+		2 = blink (ampere, ibmphp, pciehp, rpaphp, shpchp)
+
+		Using the pciehp_craye1k extensions:
+		0 = fault LED OFF, locate LED OFF
+		1 = fault LED ON,  locate LED OFF
+		2 = fault LED OFF, locate LED ON
+		3 = fault LED ON,  locate LED ON
+
+		Other values are no-op, OFF, or ON depending on the driver.
+
 What:		/sys/bus/pci/slots/.../module
 Date:		June 2009
 Contact:	linux-pci@vger.kernel.org
diff --git a/MAINTAINERS b/MAINTAINERS
index b45db73e55df..0077befd022a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6531,6 +6531,11 @@ S:	Maintained
 F:	Documentation/filesystems/cramfs.rst
 F:	fs/cramfs/
 
+CRAY CLUSTERSTOR E1000 NVME SLOT LED DRIVER EXTENSIONS
+M:	Tony Hutter <hutter2@llnl.gov>
+S:	Maintained
+F:	drivers/pci/hotplug/pciehp_craye1k.c
+
 CRC LIBRARY
 M:	Eric Biggers <ebiggers@kernel.org>
 R:	Ard Biesheuvel <ardb@kernel.org>
diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
index 3207860b52e4..8994bffe04c1 100644
--- a/drivers/pci/hotplug/Kconfig
+++ b/drivers/pci/hotplug/Kconfig
@@ -183,4 +183,14 @@ config HOTPLUG_PCI_S390
 
 	  When in doubt, say Y.
 
+config HOTPLUG_PCI_PCIE_CRAY_E1000
+	bool "PCIe Hotplug extensions for Cray ClusterStor E1000"
+	depends on HOTPLUG_PCI_PCIE && IPMI_HANDLER=y
+	help
+	  Say Y here if you have a Cray ClusterStor E1000 and want to control
+	  your NVMe slot LEDs.  Without this driver it is not possible
+	  to control the fault and locate LEDs on the E1000's 24 NVMe slots.
+
+	  When in doubt, say N.
+
 endif # HOTPLUG_PCI
diff --git a/drivers/pci/hotplug/Makefile b/drivers/pci/hotplug/Makefile
index 40aaf31fe338..82a1f0592d0a 100644
--- a/drivers/pci/hotplug/Makefile
+++ b/drivers/pci/hotplug/Makefile
@@ -66,6 +66,9 @@ pciehp-objs		:=	pciehp_core.o	\
 				pciehp_ctrl.o	\
 				pciehp_pci.o	\
 				pciehp_hpc.o
+ifdef CONFIG_HOTPLUG_PCI_PCIE_CRAY_E1000
+pciehp-objs		+=	pciehp_craye1k.o
+endif
 
 shpchp-objs		:=	shpchp_core.o	\
 				shpchp_ctrl.o	\
diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index debc79b0adfb..f4c09a110a07 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -199,6 +199,13 @@ int pciehp_get_raw_indicator_status(struct hotplug_slot *h_slot, u8 *status);
 
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
index f59baa912970..2113c52604ec 100644
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
@@ -376,8 +383,16 @@ int __init pcie_hp_init(void)
 
 	retval = pcie_port_service_register(&hpdriver_portdrv);
 	pr_debug("pcie_port_service_register = %d\n", retval);
-	if (retval)
+	if (retval) {
 		pr_debug("Failure to register service\n");
+		return retval;
+	}
+
+#ifdef CONFIG_HOTPLUG_PCI_PCIE_CRAY_E1000
+	retval = craye1k_init();
+	if (retval)
+		pr_debug("Failure to register Cray E1000 extensions");
+#endif
 
 	return retval;
 }
diff --git a/drivers/pci/hotplug/pciehp_craye1k.c b/drivers/pci/hotplug/pciehp_craye1k.c
new file mode 100644
index 000000000000..8e70b7dc6c65
--- /dev/null
+++ b/drivers/pci/hotplug/pciehp_craye1k.c
@@ -0,0 +1,671 @@
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
+#define CRAYE1K_SUBCMD_GET_LED		0x0
+#define CRAYE1K_SUBCMD_SET_LED		0x1
+#define CRAYE1K_SUBCMD_SET_PRIMARY	0x1
+
+/*
+ * Milliseconds to wait after get/set LED command.  200ms value found though
+ * experimentation
+ */
+#define CRAYE1K_POST_CMD_WAIT_MS	200
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
+	if (IS_ERR(parent))
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
+		dev_err(dev, "Unable to register IPMI user, iface %d\n",
+			craye1k->iface);
+		kfree(craye1k);
+		dev_set_drvdata(dev, NULL);
+		return;
+	}
+
+	craye1k_global = craye1k;
+
+	craye1k->parent = craye1k_debugfs_init(craye1k);
+	if (!craye1k->parent)
+		dev_warn(dev, "Cannot create debugfs");
+
+	dev_info(dev, "Cray ClusterStor E1000 slot LEDs registered");
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
+		dev_err_ratelimited(craye1k->dev, "ipmi_validate_addr() = %d\n",
+				    rc);
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
+	struct completion *read_complete = &craye1k->read_complete;
+	unsigned long tout = msecs_to_jiffies(craye1k->completion_timeout_ms);
+
+	WARN_ON(!mutex_is_locked(&craye1k->lock));
+
+	rc = craye1k_send_message(craye1k);
+	if (rc)
+		return rc;
+
+	rc = wait_for_completion_killable_timeout(read_complete, tout);
+	if (rc == 0) {
+		/* timed out */
+		craye1k->completion_timeout++;
+		return -ETIME;
+	}
+
+	return 0;
+}
+
+/*
+ * __craye1k_do_command() - Do an IPMI command
+ *
+ * Send a command with optional data bytes, and read back response bytes.
+ *
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
+	if (rc == 0)
+		memcpy(recv_data, craye1k->rx_msg_data, recv_data_len);
+
+	return rc;
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
+	int rc;
+
+	rc = __craye1k_do_command(craye1k, CRAYE1K_CMD_NETFN, cmd, send_data,
+				  send_data_len, NULL, 0);
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
+ * __craye1k_set_primary() - Tell the BMC we want to be the primary server
+ *
+ * An E1000 board has two physical servers on it.  In order to set a slot
+ * NVMe LED, this server needs to first tell the BMC that it's the primary
+ * server.
+ *
+ * Context: craye1k->lock is already held.
+ * Returns: 0 on success, non-zero on error.
+ */
+static int __craye1k_set_primary(struct craye1k *craye1k)
+{
+	u8 bytes[2] = {CRAYE1K_SUBCMD_SET_PRIMARY, 1};	/* set primary to 1 */
+
+	craye1k->set_primary++;
+	return craye1k_do_command(craye1k, CRAYE1K_CMD_PRIMARY, bytes, 2);
+}
+
+/*
+ * craye1k_is_primary() - Are we the primary server?
+ *
+ * Context: craye1k->lock is already held.
+ * Returns: true if we are the primary server, false otherwise.
+ */
+static bool craye1k_is_primary(struct craye1k *craye1k)
+{
+	u8 byte = 0;
+	int rc;
+
+	/* Response byte is 0x1 on success */
+	rc = craye1k_do_command(craye1k, CRAYE1K_CMD_PRIMARY, &byte, 1);
+	craye1k->check_primary++;
+	if (rc == 0x1)
+		return true;   /* success */
+
+	craye1k->check_primary_failed++;
+	return false;   /* We are not the primary server node */
+}
+
+/*
+ * craye1k_set_primary() - Attempt to set ourselves as the primary server
+ *
+ * Context: craye1k->lock is already held.
+ * Returns: 0 on success, -1 otherwise.
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
+		return -1;	/* error */
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
+		return -1;	/* never reported that it's primary */
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
+ * Context: craye1k->lock is already held.
+ * Returns: slot value on success, -1 on failure.
+ */
+static int craye1k_get_slot_led(struct craye1k *craye1k, unsigned char slot,
+				bool is_locate_led)
+{
+	u8 bytes[2];
+	u8 cmd;
+
+	bytes[0] = CRAYE1K_SUBCMD_GET_LED;
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
+ * Context: craye1k->lock is already held.
+ * Returns: 0 on success, non-zero on failure.
+ */
+static int craye1k_set_slot_led(struct craye1k *craye1k, unsigned char slot,
+				unsigned char is_locate_led,
+				unsigned char value)
+{
+	u8 bytes[3];
+	u8 cmd;
+
+	bytes[0] = CRAYE1K_SUBCMD_SET_LED;
+	bytes[1] = slot;
+	bytes[2] = value;
+
+	cmd = is_locate_led ? CRAYE1K_CMD_LOCATE_LED : CRAYE1K_CMD_FAULT_LED;
+
+	return craye1k_do_command(craye1k, cmd, bytes, 3);
+}
+
+/*
+ * __craye1k_get_attention_status() - Get LED value
+ *
+ * Context: craye1k->lock is already held.
+ * Returns: 0 on success, -EIO on failure.
+ */
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
+		return -EIO;
+	}
+	msleep(CRAYE1K_POST_CMD_WAIT_MS);
+
+	fault = craye1k_get_slot_led(craye1k, slot, false);
+	if (fault == -1) {
+		craye1k->get_led_failed++;
+		return -EIO;
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
2.43.7

