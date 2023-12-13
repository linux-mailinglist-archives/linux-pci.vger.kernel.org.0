Return-Path: <linux-pci+bounces-842-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA8A810C1E
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 09:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9B68281371
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 08:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4091CFA9;
	Wed, 13 Dec 2023 08:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KYGSYbOB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TTAAJL/v"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03EEDC;
	Wed, 13 Dec 2023 00:12:47 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BD7Dwvk012098;
	Wed, 13 Dec 2023 08:12:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=ykxNS763kCf8W6IHhQAFlS8cLHMUM2tmhFD0SdRc6Oo=;
 b=KYGSYbOBxQbDqvEkP00GivEvafquwJpTmc1dxCOu+e9YLmOb/asnuD+shTAH+M/ziO5C
 WjG6s3Fl6giDRPGZPAbHcb1r5LIRr8BvmLZFEUDKC48M89PpmjW3Rt4BrCGBd1aPaGA+
 D7uSozlTeZgPowSlGHsEKVh+p0SXgN5nLg2eL4/uLo70enQBovL1pJcPUQNXesckn3e2
 dTdMDISAg8cZ46JKv6BMBBHoub9dR2sbiMdS9nh67lTTwU+CMZShayzfGHb8k3iNwe6G
 tkwj7McCYh2Q+qhrIGVI46mvZps/MAH6apcux5ruSHzcZo1HdxRbfkEiEEJ+uQyc/qwH 0Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uwgn3nvg9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Dec 2023 08:12:25 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BD6K53e003138;
	Wed, 13 Dec 2023 08:12:25 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep7vw7k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Dec 2023 08:12:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E8kJYlOq/+sVUn8lANlROehyh9A1o3PzUhAGOaOfCRjuqsahCzfwxZEoqyp9cpWyKVQ1P5XmDi9fqyra8mwrUwm5slMgk9NXf5aIBLacepe0AFZ0bJ72fAPBLMiSW2Rv1NIaXS2R6xBDW9X3U1XmBXdWb/i6We5p9oiXe1tRtdMZCYe9satSv2Cnvr0RCJpxnsLXlvxtkevKvx3MtNUeu1BEegkLrHtzDWlgBESrRSUByyIfyOlVRgTh3JnA043NlyuuDmZqjv/KoLOsSlbeCJSsOkhcwLiCAeJkdxNjlW0BqDXb8zCX9lycHRNLXcEm3dIbx3VwzlJViIS+IwngOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ykxNS763kCf8W6IHhQAFlS8cLHMUM2tmhFD0SdRc6Oo=;
 b=bx5lWn3k/fFyW16NORA/hTG47uxGuvLIwrc4YODPxQQpuiD55aSu17UssPNSgZsF3TaC2bIaZWeJzy14vGq8jWVwtt52DhbZWfKxRGYhFXJvVPG7kdpW+GcVkVVX2Z6cc8giXXamY+EqxgRWV/0mGxhCr4EVv9nczp20sTuB5bfdpnXdA6ANV1/e0OM+5YraNKzud3SzW5Be355Q8eTA9ztBXsB9w98gbNi08xlbF9o9KCrjICf8nNolzZ/FRGO/llD0C9KNNVSt8aPxe/D9/zED9eMNF6+j0z26Jnb79QBijpgJ9ZSXNLjUX5esDNQq2fNz8gEe2apsW43cZf4LzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ykxNS763kCf8W6IHhQAFlS8cLHMUM2tmhFD0SdRc6Oo=;
 b=TTAAJL/vcuwLuWWP4Q51lWQm1yS9kCTB+n497q4bjfAPHMEdD07Lf86xrYsZXNXc+Wwz1mcrw10XPOkp9gG16lB3Vcp/xgtmCe+4+Y+avskcthzeKd0xJ4ZdPC6jj0iEKemmhpCBg0ftnknpMf0xdRtZpPvCnR8wfNGHi34IfVU=
Received: from BYAPR10MB2663.namprd10.prod.outlook.com (2603:10b6:a02:a9::20)
 by BN0PR10MB5096.namprd10.prod.outlook.com (2603:10b6:408:117::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 08:12:22 +0000
Received: from BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::dec8:8ef8:62b0:7777]) by BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::dec8:8ef8:62b0:7777%4]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 08:12:21 +0000
Message-ID: <d0308a65-4e78-5386-126c-9a7115d345b8@oracle.com>
Date: Wed, 13 Dec 2023 00:12:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC 0/2] PCI: acpiphp: workaround race between hotplug and
 SCSI_SCAN_ASYNC job
To: Igor Mammedov <imammedo@redhat.com>
Cc: linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, mst@redhat.com,
        rafael@kernel.org, lenb@kernel.org, bhelgaas@google.com,
        mika.westerberg@linux.intel.com, boris.ostrovsky@oracle.com,
        joe.jin@oracle.com, stable@vger.kernel.org,
        Fiona Ebner
 <f.ebner@proxmox.com>,
        Thomas Lamprecht <t.lamprecht@proxmox.com>,
        linux-kernel@vger.kernel.org
References: <20231213003614.1648343-1-imammedo@redhat.com>
Content-Language: en-US
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <20231213003614.1648343-1-imammedo@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0344.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::19) To BYAPR10MB2663.namprd10.prod.outlook.com
 (2603:10b6:a02:a9::20)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2663:EE_|BN0PR10MB5096:EE_
X-MS-Office365-Filtering-Correlation-Id: 7da02f98-4f42-4dc4-0958-08dbfbb33b38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	L4eh/RV7A1j/pcapBzMi507+40HQdeQeDc0K5BHf42EVbS/AqMETWcIgiXghXRJW2eF6fIUG+rMtzD1O89g9P4kHqiqTSRRSVuF5U/UxsG69UdoGGU9q/mD3k6tJ86IRiTgLt2+55CM/cHPQyTiiyrNCnt7azKrd8CxIHDetJQb9gQYiJPmVfsPszdM+7NBhjANZs82MtExd+ALm/CijcEesX6fhH5gYXmTzJrz3PiQjCiQ4D35tEwev/zIi4CyKd9F4w95wpClz+HKXOi6LcYR8yc6DSTYw6mq9Ewxk6VEjZ6u64qkzso56qGjZon00vhiAlxaLCz8cZ5aBryUneY33Do1rTtEkq4iakMksaFejFaABYzgQC0h4/gz267+/uR0E4SfJF4uu6EdcpQd3Gi7uJ2yqrN7HOxEFJb5Hui3+4l8gyoBOzvZ+r3EKrP13fqJUc3HITtUVHm7XF4Gjc1MaWdQDS6Zb8AQ0JSeGRva6A2OovJ+x1sdORgwV37M57j41DylmOGsMzPDEI8BH/4YGrK+KsI+ZgNDeu8+W4moXiwOUKypbvk9rmbWqRv/RAB6LV5zzAc+wfUouxZGcfnqlSjjoX4vI3lWZEwfVTB9l0rtkl3iPA3qiRB3KpU3TOaWrjINvb8uDu1gLAKx4CQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2663.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(39860400002)(376002)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(66556008)(66476007)(66946007)(36756003)(86362001)(31696002)(38100700002)(6512007)(83380400001)(44832011)(53546011)(2616005)(6506007)(6486002)(966005)(6666004)(7416002)(2906002)(54906003)(6916009)(316002)(478600001)(4326008)(5660300002)(8936002)(41300700001)(8676002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?K05sM1JIbkVHT3lTcEdWS0dCZ2Z1UmRlcys5OEp4SlZhWXI0UEZMc3ZRazY3?=
 =?utf-8?B?ZGZuRkgrZE1SZDRDNGtWYTRQNDhYNDN2TzgrK3F4a21hOGExNVVuZy9oaE0z?=
 =?utf-8?B?Y3NxWXpsM09DanNzMnMwelpSN0s5TmEzNTlxaFA1Mk5QN25RdGRhaW54WlhR?=
 =?utf-8?B?L2JvUWRNSHlQdWxUeEhPRlYxOHVtaDl0bCtrckl5bjJsdzJaYWJoam5MZUtt?=
 =?utf-8?B?Q0kyaWVMMDRyT21hUnV1T1VtS0lOeThsQmhMSXdiK1ZQa3czOUsrVjEzd0xT?=
 =?utf-8?B?ZW5NVEZOY2tHUThuQmsybGd5NVJ4ckc0ZnJYVWZxT2c1c0xnS3d5OWxTZ1ZO?=
 =?utf-8?B?UGFEMW93N09zZXd5ajFpVUo5ajBMRm1aNVVxd1EyTWp5OTZWTmIwWjQ0YjIv?=
 =?utf-8?B?dVVWZFo4VEY1Rzc5U29JUC9VVmJxTVF0eCtrZ3owWHQza2hKTmYzbzdIcFpr?=
 =?utf-8?B?S0hYUHo0WnNFK2M1RzljR1RRU0pXd3dHancrWnNkcm51QTFxbjZScVdvMjcy?=
 =?utf-8?B?TERWZ1pPTDFNN2RsT1pGdGM5K3l0ZlZURGRubEUrY3BKYktRUlVPZk8vMFcy?=
 =?utf-8?B?aWdsbUIyb3JMakJsWCtTT3JOUkFWL0xJOHZuOFJwY1JQQUcxT1lxY0plQlc0?=
 =?utf-8?B?VVhabG9GbFd0bkpmNWlvdDlvNE11ME9UL3JsVFpBUXUrenN1OU92U0FtOW0w?=
 =?utf-8?B?WXJGTVVCeG9hUWVDN3lkQ0xFckowa2VsNzN3WWRqWGx6eEpPSnJKMFdXT2RY?=
 =?utf-8?B?RXBDYXhudWQzc0Ftc2Z0dEdFTXdXeXNzK2FXWlFhbFBXdWZSQ3diSTBKNGdC?=
 =?utf-8?B?eDNJQmk1MUIrNWxpc0tpSnJaOGJkWHgvb1NrcDgveHphWmNScXBqODVUU2lC?=
 =?utf-8?B?WUpCdEdaVnc0SmxaRGNQdEQxbE9BRzh5dit6SHpQSGZ4eTVxODNWcHd0Mjho?=
 =?utf-8?B?R2FxaHhpUFlIRXIxbnF0bzU2NENCVkpoZS84TmZ0N1JqeEVvcmJBMnJjN1I2?=
 =?utf-8?B?SFBLK3RWMElUV01oUTVuREltOWY2dFRCMU1QZ1czOHlpQzQyM2tXdXpKYmlG?=
 =?utf-8?B?S2Q3dkZTRHpyQWhJSFpTc0dLZitUYTk0NlJuVlBiUXVoZHJtWXdJOEdBN3F2?=
 =?utf-8?B?UXdVN25EMzVQUkxld2xjSVo3QTl4OFJxZi9ZVzBNVnlhbmhuOFM2RWYwNWxM?=
 =?utf-8?B?YWZSTFMxSEtEcVdMZXBRRlJYN2lyT29XNGpVZG9DdGp2N1dzU3oxdHdTVHlm?=
 =?utf-8?B?ZTFQa292TnFrQ0RoKzQxRGIxLzFQRlhkOTRDOVd0RDRRby9nd3Z3bUc5Qjdq?=
 =?utf-8?B?MHNqUk04ZlZSZWhqWkFLOHNYTDVEL1RsR2JLbGlDT2RYVFppNWN0aVNoYitU?=
 =?utf-8?B?cnV5aDNBSEUvUzdROGJ0aHZLaExhRTdxTURzTmt2b2ZudytCMDk5bHlkSUJl?=
 =?utf-8?B?NTlhRWZLb015QTVWT0hiZlovUmxpOWVlTGdKVVE3MVRxTDNWL0VtVDdMSHY3?=
 =?utf-8?B?RzRXQ00yeXFISzJZQ0NpaHdYNHMvRE1uSzBGbFVkOGlaaG1mL3lPVEJFQWMr?=
 =?utf-8?B?bTFDMkRvVEl5OWMrMnhhTTdCeFdLSTdaeWJtS1NENkNUdEFNTFRlQXhidzEr?=
 =?utf-8?B?Y3dRZTRaVmhHb2pRYXljQ3g2alBQWDV2bEJidmVzU2VWTjBuU084UU1lZEdG?=
 =?utf-8?B?VHBJQnp3bUtGUTd2QXJLU1l6MkREUGx5UG9UVlYxT2ZROWxvbGtUL1VKVk9X?=
 =?utf-8?B?Rkt6dmV6bWU0NU5WQ1ZzbTUxYlBlLzdpaWR3eG9KMVdtcDYwN0hPcTBaZS9k?=
 =?utf-8?B?c1d3TVpPRGo4bTVqUERoTmRsTjF3UjZTa2Yxb1JOb0xIaHVyZldWS0V5VnZr?=
 =?utf-8?B?MlM1OE1pY2RBUmFmNG9POFM1RXY0emQxc0w4UWRhK3VFQUJxSzZBOXRjZUwz?=
 =?utf-8?B?MDc4U21NbHNsSzlEblNzU2hVZ1pHK09GL3dmVlVzRWhEdU1xTGtwakQ1RDNS?=
 =?utf-8?B?MXlLWUd6b01zN09qRlNnSk5ZZkdVc3lheWFFWDloU2NPdmNDdjFwQ0x1M2Q0?=
 =?utf-8?B?ZUphQ2lENCtCa1FZay9GWnJ2NDN1L2tGU24zcDloNEJSNEg5YXpEU1FaM1hI?=
 =?utf-8?B?YlZ1bCtCSjVGbm9vTk5JbHB4ZEt3dzZVYlMyMGxyNzlleDhla2NLa3BuZDVB?=
 =?utf-8?B?N0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	kcfu8Oc+ICJv6L5BAb2CWw7OYEP2QH5bJUP5M5+IU1XncNzqwzAJ9Bf27lnUkz/zzWlFVyJw7psXwwCFVe7+ElEJVQelk/Rb244N2J2M+8C20jxFHZc44yy0BE8zePWY8VDeBdrqTjA4nGWyHby2Rg5UPLL0KFTSyT4dtH/DiDO5G/scHR+dS4rvyluABlTxcIk2nHxiBP31399Qt7XyV889ZI1A7UnKcoyPJucB3gkw3cuO8ulEMsrZ8WQ00DIJwzTvj3xnjdC6iVLvCZlKRjQPvWcqQrsD20XbJq5nj9ASHjmPzT3dqLmfKHWsqL8DINSozi3enWUzxL0uFE0B253hktLRUXRdoT/wgsM5p2rNJr0z+WFh2BK2Hygt3P922+Q1fQOAVQlpmNPzxQroN+uAkRRJtjsv2+NLulXVb/2QS1gDEXlwnY6uaPvmeUGXY9x475qOngANzrVc8kos5mTPc/zldgcjMni2MGz0hoGSnt8u/szPSP2JU9nWLHp/uHbXMpMiA/tykMXJZbazrqLy5VMe/sYY1/tNDs9i0+DXlUjGCcHOVCiAEPJQJ9YUwTskoKAqTn/tgCeisoS9Zpyc12h06sAjyYmcPUJklys=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7da02f98-4f42-4dc4-0958-08dbfbb33b38
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2663.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 08:12:21.7028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JHSV1DhBagqXqiuw6FzJrls99BbKrZirwsn3SjTyu0Tfxi42o8tvZko6g05Rsj44DUTSpUfehzGt5et1C5Xfdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5096
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-12_14,2023-12-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312130058
X-Proofpoint-ORIG-GUID: zCbbgquTicLXERNd4GUEt6MOhX_B5FJp
X-Proofpoint-GUID: zCbbgquTicLXERNd4GUEt6MOhX_B5FJp

Hi Igor,

I am not able to reproduce the issue any longer with the two patches on
top of the mainline linux.

Thank you very much!

Dongli Zhang

On 12/12/23 16:36, Igor Mammedov wrote:
> Hacks to mask a race between HBA scan job and bridge re-configuration(s)
> during hotplug. 
> 
> I don't like it a bit but it something that could be done quickly
> and solves problems that were reported.
> 
> Other options to discuss/possibly more invasive:
>  1: make sure pci_assign_unassigned_bridge_resources() doesn't reconfigure
>     bridge if it's not necessary.
>  2. make SCSI_SCAN_ASYNC job wait till hotplug is finished for all slots on
>     the bridge or somehow restart the job if it fails
>  3. any other ideas?
> 
> 
> 1st reported: https://urldefense.com/v3/__https://lore.kernel.org/r/9eb669c0-d8f2-431d-a700-6da13053ae54@proxmox.com__;!!ACWV5N9M2RV99hQ!ORo96Nh22kv1Yj0pazd3c692djoLbWscgouJoyVG1c1CNQnYz-H7nPM7RIp8N-0qQjScZ7BgORR_Lm4oMGMl$ 
> 
> CC: Dongli Zhang <dongli.zhang@oracle.com>
> CC: linux-acpi@vger.kernel.org
> CC: linux-pci@vger.kernel.org
> CC: imammedo@redhat.com
> CC: mst@redhat.com
> CC: rafael@kernel.org
> CC: lenb@kernel.org
> CC: bhelgaas@google.com
> CC: mika.westerberg@linux.intel.com
> CC: boris.ostrovsky@oracle.com
> CC: joe.jin@oracle.com
> CC: stable@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> CC: Fiona Ebner <f.ebner@proxmox.com>
> CC: Thomas Lamprecht <t.lamprecht@proxmox.com>
> 
> Igor Mammedov (2):
>   PCI: acpiphp: enable slot only if it hasn't been enabled already
>   PCI: acpiphp: slowdown hotplug if hotplugging multiple devices at a
>     time
> 
>  drivers/pci/hotplug/acpiphp_glue.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 

