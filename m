Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C95C61A55D
	for <lists+linux-pci@lfdr.de>; Sat,  5 Nov 2022 00:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiKDXIx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Nov 2022 19:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiKDXIw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Nov 2022 19:08:52 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6369A1B1
        for <linux-pci@vger.kernel.org>; Fri,  4 Nov 2022 16:08:50 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A4Kj7cI014044;
        Fri, 4 Nov 2022 23:08:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 to : from : subject : content-type : content-transfer-encoding :
 mime-version; s=corp-2022-7-12;
 bh=x0pdTs38fpGrjAX3zlBZorUk3do/cAPYqdBASmMoifs=;
 b=e6ZoeDKA6n0ntsSKhXF1Lsb7fElS92+7/etJdmZjCmNOG9Nlp3UNKFlbRse+CfezqdbL
 5B6qeh1dBV+UfXYC7V0/o2GEvpCgKrzZ1c9YWQvDATO/2cQ9j4GBeOElPuARC28cVS1l
 ECik1Rc8w6/bhwDf7rdXBidKx5lYmve5A5J/sBmoH/ga8jT91P+Ms3vsUNdd4O/LP2dj
 fwvxjLMz7LAu1pBuTpf4IEtBaFx1HQJutJj9sfPPbvFx1ndoSz+x3Eaps8g+n7cNMh3T
 QRV/EXhQ3pzyHwnKP2hTEO4LkDxRPt6rDJnP43z8dwsARc24VfNDXtCah3zKKE9HSXjv 4A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgts1hgkg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Nov 2022 23:08:47 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A4Jx30H029754;
        Fri, 4 Nov 2022 23:08:38 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2049.outbound.protection.outlook.com [104.47.51.49])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kmpr9a13x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Nov 2022 23:08:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZYuG809JGgetd9ZaJVH2iFbZTpBgJtSrHi29QhC5vYtmCYIivkqXLvFzDpehVE7o3MptxPm0uYVXu/PNS9p27qg2HSOg8SxkQkxLkvFPZgo3LTDVwebN8u6hj7p6tGkGIw0JDZRrHO3+Rjd2EhgWF6MNeFRZVcvWPiPa0NlGTX89ev0YKHKFc+3S0CRyLnam5ccD/RTApyQvM0bCQ1O04HlA3tgXG8P51kIRevk080CMnWrUTAaBnd1gcbPKA96el5fZTHGs9Y8Kd7xwO/xO8h2qtUmSpL73tx+kIGypHzhhbhkOhx6qIXpX8DMzffdUnQ3mIlDj7T1U74knbEuw7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x0pdTs38fpGrjAX3zlBZorUk3do/cAPYqdBASmMoifs=;
 b=GQwsEpzvnUFGMoy7Ij9DpLQeIu18KngR2oz6OmvhERytHhzT4psaYuuWN5SjXdECooLBzXO8sZv4Ei7fLCxJ6Qa8p6Xkxzj0IYIdXWQyPGoVeV0/w8Vqp3n5EUKVLV8qzns+9Y0I2ODPnleYoiz/yX621HQk5yGfg8nDMnaVyr21bJdrduvzKDsEW6qMNIe82fy79LaFUcavRSQXyvFkCiRofxxSKhk8aVnS3UrgJQutbTsrbuJzksTxUYEX2yAtzX2APCZHq6z47O3vl/EQQD1LXQhq+ckFIjrrHgANWk5kZA4J9Yp4fveiIQ3Z5oawKD2LmgkFflF4f+9Ujr2qlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0pdTs38fpGrjAX3zlBZorUk3do/cAPYqdBASmMoifs=;
 b=L0/C2lziuLzhhgqQNSgZpptIfwQgjTlZ2D66mwUIVnFEXkU7wXXLj76qGckHQM06dMX1XrjAD/VX+hyHRsgN9GT0svWBG2mwj+PG/ETTxHbLs0VRvPFiUbw3gqBKxmSxOkgtqEv1Kj/ADl+koRfaEWqdQfGkCdqfW3lYysQrBy8=
Received: from MN2PR10MB4093.namprd10.prod.outlook.com (2603:10b6:208:114::25)
 by SJ0PR10MB4527.namprd10.prod.outlook.com (2603:10b6:a03:2d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 4 Nov
 2022 23:08:37 +0000
Received: from MN2PR10MB4093.namprd10.prod.outlook.com
 ([fe80::d672:d1d5:8e9:dd15]) by MN2PR10MB4093.namprd10.prod.outlook.com
 ([fe80::d672:d1d5:8e9:dd15%4]) with mapi id 15.20.5791.022; Fri, 4 Nov 2022
 23:08:36 +0000
Message-ID: <e0a2c30b-7741-4a89-1f7a-aa5eb7c5e4e3@oracle.com>
Date:   Fri, 4 Nov 2022 19:08:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
To:     linux-pci@vger.kernel.org, helgaas@kernel.org
Content-Language: en-US
From:   James Puthukattukaran <james.puthukattukaran@oracle.com>
Subject: sysfs interface to force power off
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR06CA0026.namprd06.prod.outlook.com
 (2603:10b6:208:23d::31) To MN2PR10MB4093.namprd10.prod.outlook.com
 (2603:10b6:208:114::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4093:EE_|SJ0PR10MB4527:EE_
X-MS-Office365-Filtering-Correlation-Id: d3d25bc1-b889-4ddd-6042-08dabeb98088
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k9xtv3HIeAygkdYkuAXySOtk+XBd+wacexczCqFdtF4ssGVujWlfY/0vj31kZMUxYxkj1LVzDLmGNPI0EwFrsIxBtpIi8yn9uMaOKC6TvO5Ch9zAD67I8ffkOq4+9a0QQatXjZEYmqgi1hciJGu0q/YFV6EQzITc96o9GJ7edUmgGe4dAoqMQwkxp3o0J/+/jwdCtux51fyns9G06t+0t4Qsf6LzgoT3ta5lezD6LlFOrahHyBz5DTHAe1Ix6JE29xpYDIuDH7Fiqk8qlN/040ZBcWqWr+KWl8IvwovtV1N/ulQfUsR5xFfHT3DtsXMjS3b4++7HWCUPCFmJZQr493+zlOT5CtiJE6aEAnLmBPCB++H57UQC5V/Ndl9mDKnnpeXwdsWKpEib16pX7Jtz89yvPrwObl+1zqR9xRVMi33aex8A5s3q0MUHUg2lv1RerRHxmiucwdRq0rAWj3Q2wKmbowIOhyQF0RK6DLJxYvsRzXkbNINjppdy2o3wu++QpJ6JB6YEEAj670NstnnL3U8bW33H9g3NP4+xT/TcNlz4sux10zQ73ASDsyPCQm36DfuKQBKYPerafU1v1MmnsTy4cX2k9NMwEjiVWsfxMHcy+nDiFaUCE72/Gypjobh55wQyANje0c+pKfQSTPRHZyZnqseQhgaTwZ92TT8RfHRqDEQ4is3aXNVy2dI5Z9Fth8CgZKqLw2+aufkvSNWAGAlEEfIsAV6Jd0xa/FPTOSzJmg3dK5KoA105atlD9fwr38PZXxMs8zJkqp9sWcDs03iT4Id/sXxeTAGwjajufkM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4093.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(396003)(346002)(39860400002)(376002)(451199015)(31686004)(478600001)(8936002)(26005)(41300700001)(5660300002)(6512007)(6486002)(83380400001)(2906002)(31696002)(2616005)(38100700002)(316002)(86362001)(36756003)(8676002)(66476007)(44832011)(66556008)(6506007)(66946007)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0lOUzNGUUpLQUxjSElqK0RsRXdBMUNLaTg3aytTMDN2L3F0aHJFK3dIWm40?=
 =?utf-8?B?alhaUk9ZY085R2E2TmEwdUxGdVU3VmJPWnNnQXZXTFp3cnhHQnhFL0hBVS9z?=
 =?utf-8?B?Q2JUKzh2M1lhVm5yZVM2WDB6ZmYvU3BqeFRzSkFiaXNORTdCRW1IVW41ajNG?=
 =?utf-8?B?RW9hRmNrN2pyb1ViUlNHZk9LemRyaUZEU2hhclM1dEMwdklkL01PUjhTYXRk?=
 =?utf-8?B?U0JCeUNMNVMzS05ydWNQcTF3Yjl4NjZJUTArbjRoTmlNRWNzYXhOVU1YSzRj?=
 =?utf-8?B?RlZTZkM5V3NUWjllVUFacCtoZDFpM21MYzVCTHpscUhqbEFuWGVlU1ovdVFL?=
 =?utf-8?B?bDdiRkkrZGIwSTA4TVNTWW9PbkZvVzhSVUljUWlKcEV2QmQ5RENBb2pQNTkx?=
 =?utf-8?B?S3Z0STc1MDA4c0JlSUVKT2RhWG85T2FpSzMwMjJ2eGZ5TjRLRE5IdmNkRDJW?=
 =?utf-8?B?MCtsUGRtdk9aaitTNFE0Mk15NFV6RnlpU3ZkSmxQSkpLNjVia280bmxNR29m?=
 =?utf-8?B?NlFrTkQ4QXZTVmRXNGEyWFpyb3FTZzZQNUg3U0JiQU9FK2JHdWg0akNXY2pX?=
 =?utf-8?B?aE5VeEJTakIzb0s1SEY4eWR3YVlVdGRzckRmNWZWYVVPZFZXb2c4TCtDc1Rm?=
 =?utf-8?B?Tzk3Q3d2LzlBTitQeHd2YmMrYnZ5WThTRGdMcGdCL3hDQ25xNWFTczMyY1Vt?=
 =?utf-8?B?ZjE3UGFhWk1GSW9UL2RRNzFvcHptMnZSNGdvTUJ5NFcrME5keTE5Z2JZSkhp?=
 =?utf-8?B?d3o2T2JuUjFuYUxFYzlWNTA2bkR0c0RZa2lPSEsvdE9WRTQvUXJvRTFGOFZQ?=
 =?utf-8?B?Wkp5Wmc1ZTNUZ0dYVk1kRUVRd0xxeHd3NDlJZnpPNTNoTFR6eFZkNVYvN1JY?=
 =?utf-8?B?MWxHQ2pmVlRneTlpRFhJQ0tHcWVJTE52V0FHWXI2YTBwdjNNZHNtemt4RVZO?=
 =?utf-8?B?TW5nTDlNQ2JDWFJhaHhNdFdpWXBDcVhDRGlocVk4bk4raXoxTnp3SVF3bXNl?=
 =?utf-8?B?OHQ5NnpuMzB4Mzg0WjVJa2NIdnNtbFkvS0xkNktCdFhUMHQxNThlK3VQZGhQ?=
 =?utf-8?B?YWVhbk9XR1lOTFJmUE9maGhDRGUyZTNHU1JNSXBCUkFFSFZxb0FYWmNCMm1k?=
 =?utf-8?B?SFRxbjVaeDY5M0lGaDVJNkNycUIxbmRDbzlXdWV3ZmQ4OTREUkZrdXhhVVBW?=
 =?utf-8?B?aVJPUURaemdPODZuUkJrcEg5UGJaVTg5V01YTmx0a2Ixa3RPck0wbDZWZVd0?=
 =?utf-8?B?YldXQ3NEOHJSRlNkNTNHdm5DUktjNCtjc2hvclFCQ1VOZWgvYXVZK055U0Rs?=
 =?utf-8?B?QnlnNmNjdGhYWHZ2RkpOSTU0bW5TK1FXWWFhL3dJOC82Q2JkMlkyRyt5UHhN?=
 =?utf-8?B?QTY0ZDhxay9XSUZjTjVNTFlXMkdQZC91SW1PTGlsb3lmSTMxZzBPWTZ4SWl0?=
 =?utf-8?B?MDVpeXVLNUFPYUc2VzlQbGEzeVFTVER6Q1RXMzlTVzR0QkwxL2xGTERpdGkv?=
 =?utf-8?B?M3loZGg5dVRnTWZ0aTh6QVpmcXR3SktyZm9KRUhMVnFZUEdhb2ZMUlhrVHB3?=
 =?utf-8?B?RldiNUQxREUxQWNQWjM4UWQ5NSsxSHdWaHlaMkExZmhxR2cwMjIwZ1U3eGlI?=
 =?utf-8?B?UTlIT3dCdC9yTG9jU2ZHYS9CM1VlQTBVOTZwU1dIWWp6a0d0S2JUR2U4MVVp?=
 =?utf-8?B?dTZrRWJ5TkxMd1FOMk0vU1Rva3habzN5VFBvRHlHWGwvUjh1Wm1PRE5VK0Vr?=
 =?utf-8?B?WU81UmZicW91TVlSVXpTeE1VUzJ6emZia3p1czhqSkEvc1hyL2JIdjgvUEEx?=
 =?utf-8?B?UnVDcVQ5ZkNwYzNVRm94SEI0Y0I1OGh6dVRWVW9HTE12S01sZS9xd2JSbS85?=
 =?utf-8?B?S3I5SGtLU3dnM1l1b29GNG1ySFoxdXZvMGRaeElBS0ZnR0U1WGhZQmlIN1VN?=
 =?utf-8?B?UXBkRDBVSjBtSHczZlJHRkhBZmEybjl5S3BxNk5KK2JnWWZzY3BsUkRnNndD?=
 =?utf-8?B?ZHMxTllIbjBwZ2FyT0xDYXU3dndWMHIyZ0hlR0szRm0vUkswUGNPakczUWNo?=
 =?utf-8?B?T09WU3psWTIyeUFEc2RLa2Y4a3F5Q0drR1EyYmZEOUdydTQwcnBremRPaTRj?=
 =?utf-8?B?RVg4WTZFdXQxcjhDa0M5WnNzcUYxNDg2OFhEUnFzTHJXVURxbmNwQUk5eWpO?=
 =?utf-8?Q?Cf1l0ip2fAk7EyXJGbbAXt8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3d25bc1-b889-4ddd-6042-08dabeb98088
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4093.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 23:08:36.7869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TsABq5kQFKRyXxxCBg/AV2w8rk0qcKQJylchzdVJNU3ekzYF+DmkRdgyLfbsfJcgeLyYM3p96vPib4CxLqdI0vIMe0HkjsER37cr8+nV4KL4JUypJWVzweQCoc5+9xpx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4527
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-04_12,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 adultscore=0 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211040142
X-Proofpoint-GUID: CwBPDfFeRQ_jrwB28IX11bBRRUeA7IjP
X-Proofpoint-ORIG-GUID: CwBPDfFeRQ_jrwB28IX11bBRRUeA7IjP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Looking to solve a problem where we have nvme drives that are hung in the field and we are not sure of the root cause but the working theory is that the controller is "bad" and not responding properly to commands. The nvme driver times out on outstanding IO requests and as part of recovery, attempts to reset the controller and reinitialize the device. The reset controller also hangs like here --   

ernel:info: [10419813.132341] Workqueue: nvme-reset-wq nvme_reset_work [nvme]
kernel:warning: [10419813.132342] Call Trace:
kernel:warning: [10419813.132345]  __schedule+0x2bc/0x89b
kernel:warning: [10419813.132348]  schedule+0x36/0x7c
kernel:warning: [10419813.132351]  blk_mq_freeze_queue_wait+0x4b/0xaa
kernel:warning: [10419813.132353]  ? remove_wait_queue+0x60/0x60
kernel:warning: [10419813.132359]  nvme_wait_freeze+0x33/0x50 [nvme_core]
kernel:warning: [10419813.132362]  nvme_reset_work+0x802/0xd84 [nvme]
kernel:warning: [10419813.132364]  ? __switch_to_asm+0x40/0x62
kernel:warning: [10419813.132365]  ? __switch_to_asm+0x34/0x62
kernel:warning: [10419813.132367]  ? __switch_to+0x9b/0x505
kernel:warning: [10419813.132368]  ? __switch_to_asm+0x40/0x62
kernel:warning: [10419813.132370]  ? __switch_to_asm+0x40/0x62
kernel:warning: [10419813.132372]  process_one_work+0x169/0x399
kernel:warning: [10419813.132374]  worker_thread+0x4d/0x3e5
kernel:warning: [10419813.132377]  kthread+0x105/0x138
kernel:warning: [10419813.132379]  ? rescuer_thread+0x380/0x375
kernel:warning: [10419813.132380]  ? kthread_bind+0x20/0x15
kernel:warning: [10419813.132382]  ret_from_fork+0x24/0x49
...

So, I tried to hot power off the device via "echo 0 > /sys/bus/pci/slots/X/power" -- the thread also hangs waiting for the nvme reset thread to finish (like so) -- 


kernel:warning: [10419813.158116]  __schedule+0x2bc/0x89b
kernel:warning: [10419813.158119]  schedule+0x36/0x7c
kernel:warning: [10419813.158122]  schedule_timeout+0x1f6/0x31f
kernel:warning: [10419813.158124]  ? sched_clock_cpu+0x11/0xa5
kernel:warning: [10419813.158126]  ? try_to_wake_up+0x59/0x505
kernel:warning: [10419813.158130]  wait_for_completion+0x12b/0x18a
kernel:warning: [10419813.158132]  ? wake_up_q+0x80/0x73
kernel:warning: [10419813.158134]  flush_work+0x122/0x1a7
kernel:warning: [10419813.158137]  ? wake_up_worker+0x30/0x2b
kernel:warning: [10419813.158141]  nvme_remove+0x71/0x100 [nvme]
kernel:warning: [10419813.158146]  pci_device_remove+0x3e/0xb6
kernel:warning: [10419813.158149]  device_release_driver_internal+0x134/0x1eb
kernel:warning: [10419813.158151]  device_release_driver+0x12/0x14
kernel:warning: [10419813.158155]  pci_stop_bus_device+0x7c/0x96
kernel:warning: [10419813.158158]  pci_stop_bus_device+0x39/0x96
kernel:warning: [10419813.158164]  pci_stop_and_remove_bus_device+0x12/0x1d
kernel:warning: [10419813.158167]  pciehp_unconfigure_device+0x7a/0x1d7
kernel:warning: [10419813.158169]  pciehp_disable_slot+0x52/0xca
kernel:warning: [10419813.158171]  pciehp_sysfs_disable_slot+0x67/0x112
kernel:warning: [10419813.158174]  disable_slot+0x12/0x14
kernel:warning: [10419813.158175]  power_write_file+0x6e/0xf8
kernel:warning: [10419813.158179]  pci_slot_attr_store+0x24/0x2e
kernel:warning: [10419813.158180]  sysfs_kf_write+0x3f/0x46
kernel:warning: [10419813.158182]  kernfs_fop_write+0x124/0x1a3
kernel:warning: [10419813.158184]  __vfs_write+0x3a/0x16d
kernel:warning: [10419813.158187]  ? audit_filter_syscall+0x33/0xce
kernel:warning: [10419813.158189]  vfs_write+0xb2/0x1a1

Is there a way to force power off the device instead of the "graceful" approach? Obviously, we don't want to reset the system and don't have physical access to the device.  

Would it make sense to create a "force power off" in /sys/bus/pci/slots/X which basically 
a) Sets completion timeout mask (CTO) (for outstanding IO requests not causing a fatal error due to CTOs; not an issue for DPCs I would think)
b) power off the slot 
c) enable CTO mask
d) unconfigure the device via pciehp_unconfigure_device

Any help here appreciated! 
thanks
James


