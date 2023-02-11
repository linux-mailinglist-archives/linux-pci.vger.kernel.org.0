Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9E0692E76
	for <lists+linux-pci@lfdr.de>; Sat, 11 Feb 2023 06:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbjBKFGc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 11 Feb 2023 00:06:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBKFGb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 11 Feb 2023 00:06:31 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A0D7536E;
        Fri, 10 Feb 2023 21:06:28 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31B3bTp8004214;
        Sat, 11 Feb 2023 05:06:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=b/+l/ugBvHhnHCoOCQDPnigoZer6PNneqhiiawUqEJI=;
 b=mGB4T1yE2o7G5uV6h9tZoR/urEAMs9Po3J+sltuCyhTAhr7mBrvNva/bRyviH0oXmsyg
 iWRpzm023GhUFSiWvTrj5gF6qsPFRCbBUkcln8qZZpreYaIPZtU7xHbOeMKb62BcTCPF
 CNhi+bEWso2BV/J7u4ZixNH5JPwS21+ecWXW9IPKQSL6vtj63u+r2cIVr4fETuITQJ4+
 XBRxsyBnaoQQimwjftlVPqKDiK6Ee58hw498Z7eQ64wJklN3XN3gAbA+8KtD/4hYigze
 o/R/Q9QiHARD18qNvVwSDZu6gSmoVMnUHZahItL2WNrjepNqJYxDW6fRUcV76KmPeAsl 7g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np1ed83uk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 11 Feb 2023 05:06:07 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31B1XCco028875;
        Sat, 11 Feb 2023 05:06:06 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3np1f23nc0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 11 Feb 2023 05:06:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QmgUfLtvSSpW8XGoDiZQd2PDtZxP9Fsar30iPpFpMy0gxZhm5MZaeFJjbHCU9c6dJ6GNzk3jnC7NpxUATpM2kfXEz5aPlp+iuyVEhASQsLkkIxeJZG6KaCtOcHhBpbUTW091jZvCoDonnM0fxYYFp/CL6KwIbYt2mzWQ2CICZDgNd9JaAYKc3FhTtmFYVFLzfQM+voDA6vi39iXfq3fOgGpRvrLO5rjJatf9QWorpbUxfuQ3XhjQjDsQFL5pXk5mDgkW0D4zQ6OMQy/tPmQbO1Gp1gdZ97Rnd4xHOkKIAh0wo+6hp7HcDKKxz6+g2+fSgt4DjrIysw7wWLvquZMzXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/+l/ugBvHhnHCoOCQDPnigoZer6PNneqhiiawUqEJI=;
 b=B85/8Z8Y48/UITd6BPm2jk7H4aB3Q1HoSq/R8OC3AgSVoI0ULvJE4RWPN2LTIo2Mp+5vHngCKi+FzAwI2JBwRcQjH/Y7ZSB2RQ1v3fgrWQJaANYDM1PGDRtziKZQL3x/Ks4BDxvUO+T7w1XhIQ+Wl/J0h9EhlT6pOexN+NoSd2CT+DrzgGoZMmLQGVKnfyUIN4qjhihNv1ZPkoQL8cEakCUAODoTp/sEMQwPD/zrbJGDFGvfxFtvhtsttB3iQIraoipke/BHdPNsLXQmT4UsUoXDt06I3GrkIbxMxxnCSUxnBTCCcDbMx+h6+wGPZGVXoTdqF9aH7s5qxBIsgr+RFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/+l/ugBvHhnHCoOCQDPnigoZer6PNneqhiiawUqEJI=;
 b=OAfGRkvsT8MRE+aV8Jt3oYqCT4qsvsDMFrTCxVBmKxRC0ns0zjdYrvYfx0Tsl0TafQEJJwtDWvjb/e/6AHIHuQ7TajcLQv8s4ql2mFXoNLP6CYLzdC5WM76OfgICwR7TexLT5yjsgontheNv5llkKOSa9Nphzb6dlXxL9GA9LT8=
Received: from PH0PR10MB4581.namprd10.prod.outlook.com (2603:10b6:510:42::16)
 by SJ0PR10MB4557.namprd10.prod.outlook.com (2603:10b6:a03:2d4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.7; Sat, 11 Feb
 2023 05:06:04 +0000
Received: from PH0PR10MB4581.namprd10.prod.outlook.com
 ([fe80::9013:b768:5177:564a]) by PH0PR10MB4581.namprd10.prod.outlook.com
 ([fe80::9013:b768:5177:564a%5]) with mapi id 15.20.6111.008; Sat, 11 Feb 2023
 05:06:04 +0000
Message-ID: <5945f254-0581-093b-168d-8cf2c0a34eab@oracle.com>
Date:   Sat, 11 Feb 2023 10:35:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [External] : Re: [PATCH] PCI: Fix build error when CONFIG_PCI_MSI
 disabled
To:     Reinette Chatre <reinette.chatre@intel.com>, bhelgaas@google.com,
        nathan@kernel.org, ndesaulniers@google.com, trix@redhat.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, tglx@linutronix.de, kevin.tian@intel.com,
        darwi@linutronix.de
References: <158e40e1cfcfc58ae30ecb2bbfaf86e5bba7a1ef.1675978686.git.reinette.chatre@intel.com>
 <333dee5b-6710-998c-bf3f-2cb1d676a7da@oracle.com>
 <af294def-fff7-469c-b8c6-a245ba641c2c@intel.com>
Content-Language: en-US
From:   ALOK TIWARI <alok.a.tiwari@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <af294def-fff7-469c-b8c6-a245ba641c2c@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0010.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::19) To PH0PR10MB4581.namprd10.prod.outlook.com
 (2603:10b6:510:42::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4581:EE_|SJ0PR10MB4557:EE_
X-MS-Office365-Filtering-Correlation-Id: befd4fee-e226-4049-2ba2-08db0bedacf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lQReWnl756sYSCDT5t8lVu3bb2MOfsZ+XxLaohHJY0CRpcE5FQ8WVQrutW9bdSdFRrW5DjqM5Owj7KJPqqGsYlOEsOlM6WFWWiRZZOu2iFW3iqk9ECufsJfN6AjWQ4IW7YjmB8x3582jOLzRQlbzTxX8+U1iqc3CWHasGtdlkXc8pWT97iUFki3yHXBYCtmBx9oC+1kyWgt6363sFRv1q3XZtwnoOFVCo614UV6paL7iCtGj74uEK8fdnnfcJ/PCCSxOzZGOWSVc5kSCcfNIaQ3ysQvoFzcvSqkdNhD5JLo/9CeZErDvuejddKcbMRVce4y5Px5ai5W16wO/bG9PVQCzmB4aq7T51DutX5Yd/dKV1t3yCKXjcqNF2Mxnt21uYqFTR7scbUpJ2xTVZaau9+5LbeM+RfpqDAyal+OVylp4LfakQQvgPntv27JyB/+WBVTJSDAbiRYSqiia5gQEKQDsiJ1pUer3vyqGE4d6+7CjQtMVxaWdQhb6ShEqNxFM3uBzcCjm/DleoLFuqxWKFs8kvYRsG6sArGxMlYXePrtYQQJQ0oaANGXfljvyliJDA937+vxsor4Q+KWm6r8Pi7iYB/8i/yLHj9Rt20ncddr6X8/BEWK+a6WpaArDTc7zUmxi2BAU5t6DPvoGMMdhyg792TQvxSfVrY1tPafO2cWoVSVbAFajN1pJHMtEFDtMtjlmi+KMB3r7SUCgrRUz2GfedAiBCjolhVc3YHfMBxY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4581.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(346002)(136003)(39860400002)(366004)(396003)(451199018)(2906002)(31696002)(4744005)(2616005)(38100700002)(86362001)(4326008)(316002)(8936002)(66946007)(5660300002)(7416002)(66556008)(6506007)(66476007)(36756003)(41300700001)(6666004)(53546011)(6486002)(186003)(36916002)(6512007)(8676002)(26005)(478600001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGU2TWVjSUx5VDI5RzFFbmVKTzNKK011b25VZUNHVkJzUkhacFBIWGhwL1pE?=
 =?utf-8?B?M3JkV2ZmWVdHNFVoYTB0NGx6aDFlTlBNTXdaZXBkTHUwUzQ4ZXk1d1p1TVVi?=
 =?utf-8?B?TThFTERTZGMzSFNDSXFpbDhDSDV5TWlvakRFMlBVWjdHb0p4RGVBTXhCb0VK?=
 =?utf-8?B?WDlTRDA4L1dGV1ZXZC9Bc1F3SDZvSlIwYjd0di96dEJLdkdNNmRGL1ZhYlNu?=
 =?utf-8?B?aHFtMDBLWm0wQjNaMzJGUEcyTlVWTXROTzMwNFdNZDFmV205NVRscTliTURl?=
 =?utf-8?B?RDBxbzR0ejNsUVFBU1R2Y0NEUjJoRTlaY3MvREFTZS9sT25lV0xBaHkzSVN1?=
 =?utf-8?B?QnppUkVWdVdpQkVGY2pjQmErRnZYZVNadFZOREhVVHV4aHJBeDlraEFYenBh?=
 =?utf-8?B?ZmtOMTdVYSt3b1Y3cG5oeTlXL0ZmK2RZaXA1MEkvQU5BZ2pyeGNWQjVuK3ZE?=
 =?utf-8?B?SjRmNzEvUUx6MGtJNFBYRUdTQytSVkFkeW9DSGdkaDdZVUswZFd0aHVrTEpi?=
 =?utf-8?B?YlY3blNGSS9GYjhXd3JuVk1Fc3pheGxUUVp4RVN5dnNlaCszazVGSGlaaDl5?=
 =?utf-8?B?cExKQXlybkNiWTZ6OEt3cnh4U040bEFqSlhoWFAyMml4OUtLKzY4c2hrSGdn?=
 =?utf-8?B?VVdwbGJOTExrSHRJdGIzSzRtQkJhK1FUV09ZdEV3YSsxUFJtWmpoN2gvL1hv?=
 =?utf-8?B?dlVXK2VRbnBUYkhXSVVRNGlYU1U1NU9HQ25WTGhKZm41blRyaXFHMmV3UmtM?=
 =?utf-8?B?TFh5c24ybldlNUMwYmt6Zld4YWRRdmc0NjcyMzUxWmxjR1AxVUNKdlVVczc5?=
 =?utf-8?B?K0tlbUFlclNuNHJTUmo0ZXNYdkVnSEhQWlltTzdybmc3VHVHWk4rL2NlLzJM?=
 =?utf-8?B?bTVUUmpUb3YwSjc0RS9WQUdwMGY2MUwwRkRoT0hQaUZjdDRXVHRTWXJFaC9J?=
 =?utf-8?B?RVI5ZU5xWC96ZXVacTZtOVZVTjNDRE5OWW45dDhUM0NacHlPTkxXV0tFamZD?=
 =?utf-8?B?QjVZU0MrbGprTTVkMm90ck42a3Mrdmo0RlBwUk82eDZuS2QzVDk3M1RnV0R5?=
 =?utf-8?B?RmxTNSs0dHlucllmZEFKUXFJbHNDa2Vlc0dGNUZBY3dBVmw4SFFnWTZicUtt?=
 =?utf-8?B?RGNGazVqbjMrV2hXZndCR3I5UkZoWDRERmErZmtKZThvZjJEdWdMNk9DeE1J?=
 =?utf-8?B?Z2x2YS9ENkc4bXVuQm9rUnFUcndTZW8xL3p1S3BPcmc4K1M2NDVEaDMzN0hi?=
 =?utf-8?B?RmtJZjNYcTNjUEdMVjhlUUhQNXNWQnZvNWdrRUd3YjZoZ3VmSEZDYmZ3YkNR?=
 =?utf-8?B?ZlRUSTNSb094RFlFQ044bVlPcnNyQ3pIM0NjWFo4VjZEWVdFWEVHZkVOZkFH?=
 =?utf-8?B?eFhZeWdLRDlhMFVmbTVxZ3o1VEJRU2dKc25HZmVXR3l6V2xyTVoySjNiem5y?=
 =?utf-8?B?Q2tDK0p3RXU4ZXplRnYwbG12MlgyYWE3M2dLWm45ZFZoSTU4cVM0ZVAwekMz?=
 =?utf-8?B?bEovT1Y5d2hnMVhkSGZ2cWJHbGxIODNUKzBzOSt2aDVvOERCSVpIQkx2RGVy?=
 =?utf-8?B?WDllMmN6ZXBaUFRydGFZaWY3clJ1RVJzNnJZcmVFcm11eHJyQjgyeUF1MEI5?=
 =?utf-8?B?aGdpcGYwREZRZUphUUtLMTR5WjhYWGRaR1UzTVFTbHErZlZ2YS9lLzZLNG5R?=
 =?utf-8?B?NjYyZXE0VUJTWHEyU3lia0FJOElPL3FybmFuZWJQK3UzSFBydC9FMTdOd2Mx?=
 =?utf-8?B?OUNtMmptK3gwZDRaMmZlYmtrZ1NtMUxFVXUwc01UbDc1MXFTS1dkS2ZjTUha?=
 =?utf-8?B?YkVWNWxuOC9kN0RqdlI2RURRV0UwMlJNa0E0SHdDc1Z3Qldta0ltcDAycXZE?=
 =?utf-8?B?ZmxhVy9BWVoySXB2cllyZFJ1OUpJUFk2eklqYktXSmhnRXhaM2FSc1VpQ3Z5?=
 =?utf-8?B?N0pSUzRLaEdqSnViOEdIMGRlajFYL1VBUGMwMERJNlM4M0Z0TmxwRzRSR20x?=
 =?utf-8?B?czFsTDF0Y1NHSVpHV2lUR3ZFMHN4NjBVbzRBakxIMXZkVHlQTkZFS3pYdit0?=
 =?utf-8?B?SHE5S3luZzVWRkpFUnVIVnVzOG9KMExiSlNIQ1FVNmJGejhCTWExc0owWjdk?=
 =?utf-8?B?b0E3RW41Z0xXdVlGMExibHI3ZE4wbXVzWTlIODNQWFBmWlhlaC83WWE3Sm9T?=
 =?utf-8?B?VHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Y3YrNjdlWTNsY1FYemplTjd2M2ZsTExOMFNxVDNqZTkvVG1VZGJiMzZuQzA5?=
 =?utf-8?B?NThqS004L3JKWlNGMlpEVGVoWHBhRlNFaU5wZHZyN2JhRU96bklsZnIrMm9V?=
 =?utf-8?B?VHBld3hBQ0RrWERPeFVLNE04Z0hXd1IxbUIrcC8rVWhkMFFCT0g3UnQzeEdr?=
 =?utf-8?B?dHY0SUxoaU5URlBDMmxEaFROWTY4Q0ZvRXl0eWFVaVE0YUxJL1JHdjBvWFN6?=
 =?utf-8?B?bUQ3MFE3aXFPVFh3RlJrbXJyQjBvQ3BVbnhlVE5pOTc4aVJFUzh3YU9lNk5n?=
 =?utf-8?B?dzNLdEpuYVBLV1pnVWsvd1E0SkNsSU84NU5qNkY0bDNtUDNPNjAyVjVUNmg2?=
 =?utf-8?B?VlhEaXUzUzJzRXd3a2Z5SGt1Q1k1Z0tMa1pXRmU1Wmt2M09kYXYxb2pzYUpj?=
 =?utf-8?B?RTI1MDZpN1M4aXZiRU4xa2JETVZMcGxuRXV6cHVDS2JhL3o4UFFSU1RsbW5U?=
 =?utf-8?B?b1dCRWRKOXRPZHptcEQwYUZwOTRidTlIWVRkZ1Azb2xvWTBIVjRxSHpycEFI?=
 =?utf-8?B?bE84b0hpeWlLd3hBWjdMR3MybGV6NHFMMXJWVVB0dU5DTVpqb2hudGNkWlpU?=
 =?utf-8?B?T1NWTjMxWFVIajg0eDkyYmdxejVkL3ZmSnA5akhFRWRMYnN3dXBTMDEwNzZU?=
 =?utf-8?B?SS83NzNhWW9IUHF3Qk1JYmZTdnRDZ25BUkdDTGd0RlIzR2R3MDIybTNOSUts?=
 =?utf-8?B?cGdPSHZqSlI2czc4dGwyZE1GUWNPaWlSTjdvVXVzYjJscnEyWVUzVXh2V0I1?=
 =?utf-8?B?Y2V3MkRuNzdOYmt3OWZxNHhmTTdzZGpveHFTSFhnclp2OFAxSzVvc09RSnBZ?=
 =?utf-8?B?K2FQWmd0dDQraERIMXlEbWNRNFVYOUFBWk85VXFhV1BoVzFLd090QkdadUpU?=
 =?utf-8?B?bGU3ekdaNmJ6ZDVCcFI2WjhuSk9yUjUyQ1lsNFV6WTdTT0VNenNLbkZ6c25Q?=
 =?utf-8?B?eTJhMS9XeXBFVmhOazRvY05NdURueHZIMmROa0tqVWwyOGduZzllQUpXb3hn?=
 =?utf-8?B?empDUlQ2UmFUZGdjdTYvdWVWRDZMZ1V3dDFrNzl4N0xUZ0crQkliei85eFNE?=
 =?utf-8?B?dU12OExoaSsxdjVYcWkrb2gzTG9NT21MdzB1clNNZlBKUDNqM0pUYmMrNVFD?=
 =?utf-8?B?dm83bWNYL1JxVkZhVmkyV05MejRTWmMxTy9ud05pUm5KSTMzV1dNM1FxemFt?=
 =?utf-8?B?VldkTWk3cko4T3RvSTR3Z05CUWNBVC9UMEd2bllPNnFFbFJMbTFhRjNkUjRv?=
 =?utf-8?B?NXM1WlhKUHd1cmdqcGJuck8vdURBcWl5OGhzb1RPR2pJT3c2Zz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: befd4fee-e226-4049-2ba2-08db0bedacf8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4581.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2023 05:06:04.4687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bna674SXqM0YTAXaT3xEZkpHvmcXWz1J/2aQqncfDKzvMIipCk1dtVvsYx0LBFeNTB6j7XYqH3BqCets42t2yOXqbW6AMEfQyJW7t3QDivg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4557
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-11_02,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302110045
X-Proofpoint-GUID: Gb8gNu-mWBuASC-5_GcEubDq5O6ZRnp2
X-Proofpoint-ORIG-GUID: Gb8gNu-mWBuASC-5_GcEubDq5O6ZRnp2
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

if, new function going to part of #else case . that is absolutely fine.

but that is not present in given PATCH.

Thanks,

Alok

On 2/11/2023 2:42 AM, Reinette Chatre wrote:
> Hi Alok,
>
> On 2/10/2023 12:45 PM, ALOK TIWARI wrote:
>> shall we need to define this function under -> #ifndef CONFIG_PCI_MSI
>>
>> #ifndef CONFIG_PCI_MSI
>>
>> +static inline struct msi_map
>> +pci_msix_alloc_irq_at(struct pci_dev *dev, unsigned int index,
>> +              const struct irq_affinity_desc *affdesc)
>> +{
>> +    struct msi_map map = { .index = -ENOSYS };
>> +
>> +    return map;
>> +}
>> +
>> +static inline void pci_msix_free_irq(struct pci_dev *pdev, struct msi_map map)
>> +{
>> +}
>> +#endif
> No need. include/linux/pci.h already has those definitions.
>
> include/linux/pci.h already has:
>
> #ifdef CONFIG_PCI_MSI
>
> ...
>
> #else
>
> ...
> /*  new function definitions will be inserted here */
> ...
>
> #endif
>
>
> Reinette
