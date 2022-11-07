Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377F36200E6
	for <lists+linux-pci@lfdr.de>; Mon,  7 Nov 2022 22:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbiKGVSg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Nov 2022 16:18:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233580AbiKGVSH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Nov 2022 16:18:07 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF8D2E9D1
        for <linux-pci@vger.kernel.org>; Mon,  7 Nov 2022 13:15:04 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A7JNrQm004083;
        Mon, 7 Nov 2022 21:14:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=LI7O5rjEPC9z/rUjg6NFGWuV1lv4HYqyPlSYIcMQMDQ=;
 b=M+5rASwCRTE3XBJVoy5xps51aW/JiGNk09XJhN9WG6+Tp+cIV/++Y9f3voBhbaylCfpK
 CEsGudUKSsmlPvAYe0lZDCETTTPNW+mU1Jk9YYHdO+TK+nc4+cbHkA9ZKozdU0dRqemi
 VommS611WnjKk5vLI8oWlMmvksWYa3V/46IwvXX1HY4C1/GuJkjAKaXZP93rBj5r79+0
 Uoq1WT9Kb2zKjB2PemEIS42rl8H9R/73Ha/BySNqlWVzMytONOuBDUm5w2u1v3ne162s
 /D0QvUI6F/y8VkVb68Za1x1ejKg7OEr5k9c50bqBzOAwLZPCC/f7Nz9JGmGHJ2nG3G4L 7w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kngkw5bet-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Nov 2022 21:14:58 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A7Io863010724;
        Mon, 7 Nov 2022 21:14:58 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcyn0me5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Nov 2022 21:14:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GAYxchNUP0feaegsLcTMVwK/Z31Gg2P+hxlwizjgrS9JydGGlvlm1/yqNjihUqHolDElMAhpgfBpfogp8sYqiI/utrr5vujLkZSrwbySwuGAGST8y0VAud3Zrsm5EmrAM4sAyIh2jBc0YqLbw/CIARIWJo6bvyLOhTOhMixKYQIaRcGPZF0zDLJBwy7K5rC7E1P57iS0Si6kbj4QUJu9zsLZhjhj3afvIznHxRMxRoRHBgex6gockqr1PiZLRIM/H5uLP8KuMCccqLeT1nrjjcdYBEcn3jhS0NkOZR9fHGp7ETWZEKo1btack+J2CZEkm+eIAZnSVC79kanQxOvaoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LI7O5rjEPC9z/rUjg6NFGWuV1lv4HYqyPlSYIcMQMDQ=;
 b=J1Oqabn6ktjlw7ZkV4q/BxMMYm3L0iXg81Cjy2i08NXqQt6hCuonEcsTLuAOL5rpKkf0ymIBaevEC3Een0nUT+cV/qik70WcxxeEYacqaYKff2ibrb5v4qfGonmlrbULaSGKALLxi1ZwlZUOjEXC+mYe5GH4y6KlUFD1QDicFQr9rdnuYITno2/JS1iqzhkYBt2aZLnnjAgOUWQSkjiOmjUq/Z5Cxp+EwdjgUUxq179ISSmfHYRC6/hFPfTuJUMhHhO56Cyrf434QiGSLavhLlqvgWxikIGweCrEbpMQbEFxdU49mAtU8wbCAuBB0E3GBakhQAVm56IRaI114AV22g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LI7O5rjEPC9z/rUjg6NFGWuV1lv4HYqyPlSYIcMQMDQ=;
 b=dQx8M7S/W0/vGw5Esj76XwF19W2KvO4obVOrZxutnFsF/z5uwg4uCKjv+lwAYZCoHvwyUQFAAnEDpqZKuJK0gz1chQ0Sf/ISEab9fYIlg9t+1v0q7d2b1bh5/bLBQBEsrdLyOj3iVRgK7/QJjuAEqDpC4ilGDdCi/fPtPw1PfaI=
Received: from MN2PR10MB4093.namprd10.prod.outlook.com (2603:10b6:208:114::25)
 by SA2PR10MB4635.namprd10.prod.outlook.com (2603:10b6:806:fb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 21:14:55 +0000
Received: from MN2PR10MB4093.namprd10.prod.outlook.com
 ([fe80::d672:d1d5:8e9:dd15]) by MN2PR10MB4093.namprd10.prod.outlook.com
 ([fe80::d672:d1d5:8e9:dd15%4]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 21:14:55 +0000
Message-ID: <0081d0f6-871f-3d07-1af7-0e8e41f5d983@oracle.com>
Date:   Mon, 7 Nov 2022 16:14:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [External] : Re: sysfs interface to force power off
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-pci@vger.kernel.org
References: <20221107204129.GA417338@bhelgaas>
From:   James Puthukattukaran <james.puthukattukaran@oracle.com>
In-Reply-To: <20221107204129.GA417338@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0321.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::26) To MN2PR10MB4093.namprd10.prod.outlook.com
 (2603:10b6:208:114::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4093:EE_|SA2PR10MB4635:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cd8635d-8c1f-4afe-bc27-08dac1051e76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UByrQx7naUrJgr8xJlUX+svpe66DJwQWGHknbIlZqTli5hfILAGVKuGU+p36QPqsuqDtcoDxnjeBPz0ka3oYbg9az6TB8VMdqagri5A8zg+hm6QsS/V10KDl2/vdV/bIjFdG69dj/9o5L0juiLov8s3E5eFaWaHfvMdHbCdgkG1NhctOybMhbsbGtdhMDOUg2EaDLpafQmKZkuEkbpsmia1RZ7I/hxYLzFtrHIpcYYUK9/fGjRhpDY8e9QV8xGvP+6TpoozsGgqyGRt9QSZ+Yf6bER0FceWKoN9ul7/bZfIz5LiSvx/+E0/ei0woSgUnF6IZTtKbVElSC9TcEJrhyGwq1RZ4N9YJhtNrE7h5F4od3gxgqThzQ0i8z1xmeytYqOVVE8E2OInzFmdSqmid1EmOj89zm5IgSL8P0+NctzlBL49c5tCpDtNCcCmpr4Rcrphx5fu9n7jJti8hsmsYDa/ug+02OeF85FMkAv9g+dlv9YjKS8/dvk9FVSIVovzEF/aJLk5Ng2BDSuLr7xSv3QHwXotLqepCq+Cj6qdJae4/uNWW4ASo7F5b+26M1rWJq8QECkqD0b03h9m93/e0gMw7hXBX2WN04fjSRu+VikA4ewPTNuCjlQtcy2NS3MY2dNhV/2pcyEUanUFN9K5Vq7w2hIfLVLzdYn76pOvYurkfXcS5eFLCGMu5otCIfrqYzCNM9O8qpJAYfRvlvYT94oPydxKfYplhZXpIHJ4UW8CItEr0zd5NTogPhJb6iDyjoyvwqzRvd8s3XWw+GnDEzoOQeijpVNwlU+ZDy66aJWs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4093.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(366004)(136003)(39860400002)(376002)(451199015)(26005)(5660300002)(6512007)(6506007)(53546011)(478600001)(31696002)(83380400001)(316002)(6916009)(2906002)(86362001)(44832011)(6486002)(38100700002)(36756003)(8936002)(54906003)(4326008)(66946007)(8676002)(186003)(2616005)(31686004)(41300700001)(66556008)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmRrUXRjMnk2QlVzUzZuU3NIaXl5bGViRHU5TUJhL2drZXdxNWJRSkFGaHpj?=
 =?utf-8?B?djIwVjFhRVhoUExCOXk0alc4c1dGWWRTU0FqMlVTUXZXdURDOHRQVWZCRW1u?=
 =?utf-8?B?SSs0eldyZ2RlYXpHb0ljc1dkTWN1Q2xObCt4Skx3bWVrZFlSYUVYZDYrU2ti?=
 =?utf-8?B?RmNEVlJEbW1nZVJGUmlmRWtmb0NSdE92MnNtSkJKSCtIK1ZoYkRGVUQzQitv?=
 =?utf-8?B?U3ZacjcrM3BoeTA5SjA3TG9RNkFXS3liQkZYb0RNeHRNQkE0YWp5SmVvdm9y?=
 =?utf-8?B?V2dvQm1zOHZsOUVMRWRoQzFZOHpibGptZENaclJsWDhEVzFvRGFCelNnMmo2?=
 =?utf-8?B?V29Lc3RFd0JTaEtQSHprVGQ4VldIMGwxazBTNEJvN2hndTROMGxReS80VTly?=
 =?utf-8?B?THBBL04zNmVlekxjUnoxMUhCZHdvZjVHckJ3R0JOUWo1bTQreUQ5dnBhR0Q4?=
 =?utf-8?B?enR5djFPNWZ2SmUzYlUrVlptczAvbzhNSGZLVm9OVUhDb0FHb0pqdkUzZFZx?=
 =?utf-8?B?czRsTTRJNUl4TEZFdk9hRC9xUHlHMnlIeVlDOE5TdytjZkFieERLZkFMc00v?=
 =?utf-8?B?N3F0WWQzbUIvVW5HTXhySGRCNWF2enlUU2ZFcThFem5kNzJWODdIMEJvUmVK?=
 =?utf-8?B?R1VuOU9kK3lqdkV5V1pOZnBBejVtd21sTFpYWXQ2K1JSalhsQTNjZFhyQlZU?=
 =?utf-8?B?UWdOdWVrVmFpd3hWeDQrVFBCSUR5ekF6aEoxQ1lDYmsxbXhTeXFVcVJhVVVK?=
 =?utf-8?B?eVNQWU9vSW5OdEtxQUdnS0x2b2ZCWFBMMC9mY1lnaFVicVBxNnBXcTZFa0FW?=
 =?utf-8?B?NTllK1I5d2ZyVXVuNW9XeDlra2RvaWNNU2ZiY3ZCTys2d2s1Z2xGQ0FXUkN3?=
 =?utf-8?B?THpFS3I5aFM3aG5IMXp3clYwaGxBTTJ3bVVzTzNyY1dGQXJIN0VNdEpNYVNw?=
 =?utf-8?B?T0pRKzZGVUdxNTF6cWZEYVdlYmV6RXNKNW9OazRZVGhUVmIzVFhDQTgzUDUz?=
 =?utf-8?B?RVlBeVlPV2xReTRPbkRBQ3V3ZnVKclBiSlFvK3dLSkk2V1Z4YlptTWlwSDJl?=
 =?utf-8?B?aHdJd2gxbkNCa2pIYVVXSWdBT0ZZTHVVRHM1SUNPU3ZvUFhGWjg4OGduazls?=
 =?utf-8?B?b3ViVDYzK3NnNDZMUzVDRktQNEtLTFpFemdSdVFqNEYvNmowN2NRV0hUQ01H?=
 =?utf-8?B?WG9Mb0cvK3lmMUw3azRMVTJ2RkI1bkFNOVArUWlNcE5WNnd3U0FDaFp0Y1g0?=
 =?utf-8?B?M1RCb3loU243MHczRHVoeGRIWGtDOXpLaVlCcVVuUGxHZm5QbnJMNVVWREhO?=
 =?utf-8?B?QTFVbUwwL2RWSWp6S0JmNVNOTi9EL2ZZcXlYNUdPMS9KWCtPWXVYR095NEFC?=
 =?utf-8?B?c2VML3gvYlc1TUc2STFLU2dLa3VMNHIvRUNDN1pWbU1kVklQZjBQam1uUkNp?=
 =?utf-8?B?YWwwdlRSWVRKRzF4T2RvYWtqMFFpOVdTVU4xUU01QURGUzBTR1FuRTJ2RFpY?=
 =?utf-8?B?QWN4c1RsUUlWSjlnNzRGeXZSVzdtcnI0d1Z0eG1STFlxaFA5Ly9jdmVrRG1h?=
 =?utf-8?B?V2J5UmhCNkhMNUFGOE9BK1NnVzFNVTQzdm9sNDJRL2lYV2VlaHZhR29VQ3R0?=
 =?utf-8?B?dFhNem1PUCtMT1VKc3Ewc3YzbGlrc1ZQUHZ3Uk56REVmNUdNQ0pMUnNQK1Z5?=
 =?utf-8?B?NFQ1a0t5SlZQMXRwRnBHeXNZNkhRUEEwM0J1RVRYYitBZFBSbzB3a2RSQ3JV?=
 =?utf-8?B?bVRVUllMdXM1YnJFZWNpc0RGWFRzU0lRUzBHMFJvSktKL04zY09OVXBvTWZG?=
 =?utf-8?B?TzZLSXptbnZuTy91UU5Qc3Q4T0JTT0JjZXdWUG1sMWpFcWdpd3JqV1BlNlU5?=
 =?utf-8?B?T2trMWdHS0szNHJhMnhHV1ViSWhvc2VINEhCZU9wVXlFa05EMGJLMXlCU3JN?=
 =?utf-8?B?c0NZUkJyS2YxK0w2eUVVWDBXc0JuRkpqM1NpZ3B4S0NNSWFTVEFJWTQ0NHJ0?=
 =?utf-8?B?YTA2Y3c0eHdqK1U4OS9PaU9zVGVyVCtDSEMyV29PbnFucjJkU3FrTjYwVUk2?=
 =?utf-8?B?WWtCZXp3cjV4UmVZQ054TGtRdmxmbWMzbVR2L1h1bTRBTVQwZm5VTUIzNWJS?=
 =?utf-8?B?alJqYlh5WFFkend2bXVyc3VIMHAxVXJJd2pLSVpKL1d1QWpDSzJ1TDJlRjM2?=
 =?utf-8?Q?BaO5dr0fGEUdw4SXbUcQ4iU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cd8635d-8c1f-4afe-bc27-08dac1051e76
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4093.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 21:14:55.7847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z/nQjC/cb2cWLKV8EcEGBlFk+KYbwVf81C9VoPZelVvtLM4pikMrzMNa7cH0466+IwN/N/3MCFURcWfc05MZgaGK9whRZWcgO+h6JA9r09VJs3ib5wJMB1LO1laHZKxu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4635
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 malwarescore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211070164
X-Proofpoint-GUID: iO0Yrk64Aeo_d4G8FbxLN3fE6cpbGZIg
X-Proofpoint-ORIG-GUID: iO0Yrk64Aeo_d4G8FbxLN3fE6cpbGZIg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 11/7/22 15:41, Bjorn Helgaas wrote:
> [+cc Lukas, Hans]
> 
> On Fri, Nov 04, 2022 at 07:08:34PM -0400, James Puthukattukaran wrote:
>> Looking to solve a problem where we have nvme drives that are hung
>> in the field and we are not sure of the root cause but the working
>> theory is that the controller is "bad" and not responding properly
>> to commands. The nvme driver times out on outstanding IO requests
>> and as part of recovery, attempts to reset the controller and
>> reinitialize the device. The reset controller also hangs like here
>> --   
>>
>> ernel:info: [10419813.132341] Workqueue: nvme-reset-wq nvme_reset_work [nvme]
>> kernel:warning: [10419813.132342] Call Trace:
>> kernel:warning: [10419813.132345]  __schedule+0x2bc/0x89b
>> kernel:warning: [10419813.132348]  schedule+0x36/0x7c
>> kernel:warning: [10419813.132351]  blk_mq_freeze_queue_wait+0x4b/0xaa
>> kernel:warning: [10419813.132353]  ? remove_wait_queue+0x60/0x60
>> kernel:warning: [10419813.132359]  nvme_wait_freeze+0x33/0x50 [nvme_core]
>> kernel:warning: [10419813.132362]  nvme_reset_work+0x802/0xd84 [nvme]
>> kernel:warning: [10419813.132364]  ? __switch_to_asm+0x40/0x62
>> kernel:warning: [10419813.132365]  ? __switch_to_asm+0x34/0x62
>> kernel:warning: [10419813.132367]  ? __switch_to+0x9b/0x505
>> kernel:warning: [10419813.132368]  ? __switch_to_asm+0x40/0x62
>> kernel:warning: [10419813.132370]  ? __switch_to_asm+0x40/0x62
>> kernel:warning: [10419813.132372]  process_one_work+0x169/0x399
>> kernel:warning: [10419813.132374]  worker_thread+0x4d/0x3e5
>> kernel:warning: [10419813.132377]  kthread+0x105/0x138
>> kernel:warning: [10419813.132379]  ? rescuer_thread+0x380/0x375
>> kernel:warning: [10419813.132380]  ? kthread_bind+0x20/0x15
>> kernel:warning: [10419813.132382]  ret_from_fork+0x24/0x49
>> ...
>>
>> So, I tried to hot power off the device via
>> "echo 0 > /sys/bus/pci/slots/X/power" -- the thread also hangs
>> waiting for the nvme reset thread to finish (like so) -- 
> 
> Looks like this "power" sysfs file could use some documentation.  I
> couldn't find anything in Documentation/ABI/testing/ that seems to
> cover it.
> 
>> kernel:warning: [10419813.158116]  __schedule+0x2bc/0x89b
>> kernel:warning: [10419813.158119]  schedule+0x36/0x7c
>> kernel:warning: [10419813.158122]  schedule_timeout+0x1f6/0x31f
>> kernel:warning: [10419813.158124]  ? sched_clock_cpu+0x11/0xa5
>> kernel:warning: [10419813.158126]  ? try_to_wake_up+0x59/0x505
>> kernel:warning: [10419813.158130]  wait_for_completion+0x12b/0x18a
>> kernel:warning: [10419813.158132]  ? wake_up_q+0x80/0x73
>> kernel:warning: [10419813.158134]  flush_work+0x122/0x1a7
>> kernel:warning: [10419813.158137]  ? wake_up_worker+0x30/0x2b
>> kernel:warning: [10419813.158141]  nvme_remove+0x71/0x100 [nvme]
>> kernel:warning: [10419813.158146]  pci_device_remove+0x3e/0xb6
>> kernel:warning: [10419813.158149]  device_release_driver_internal+0x134/0x1eb
>> kernel:warning: [10419813.158151]  device_release_driver+0x12/0x14
>> kernel:warning: [10419813.158155]  pci_stop_bus_device+0x7c/0x96
>> kernel:warning: [10419813.158158]  pci_stop_bus_device+0x39/0x96
>> kernel:warning: [10419813.158164]  pci_stop_and_remove_bus_device+0x12/0x1d
>> kernel:warning: [10419813.158167]  pciehp_unconfigure_device+0x7a/0x1d7
>> kernel:warning: [10419813.158169]  pciehp_disable_slot+0x52/0xca
>> kernel:warning: [10419813.158171]  pciehp_sysfs_disable_slot+0x67/0x112
>> kernel:warning: [10419813.158174]  disable_slot+0x12/0x14
>> kernel:warning: [10419813.158175]  power_write_file+0x6e/0xf8
>> kernel:warning: [10419813.158179]  pci_slot_attr_store+0x24/0x2e
>> kernel:warning: [10419813.158180]  sysfs_kf_write+0x3f/0x46
>> kernel:warning: [10419813.158182]  kernfs_fop_write+0x124/0x1a3
>> kernel:warning: [10419813.158184]  __vfs_write+0x3a/0x16d
>> kernel:warning: [10419813.158187]  ? audit_filter_syscall+0x33/0xce
>> kernel:warning: [10419813.158189]  vfs_write+0xb2/0x1a1
>>
>> Is there a way to force power off the device instead of the
>> "graceful" approach? Obviously, we don't want to reset the system
>> and don't have physical access to the device.  
>>
>> Would it make sense to create a "force power off" in
>> /sys/bus/pci/slots/X which basically 
> 
>> a) Sets completion timeout mask (CTO) (for outstanding IO requests
>>    not causing a fatal error due to CTOs; not an issue for DPCs I
>>    would think)
>> b) power off the slot 
>> c) enable CTO mask
>> d) unconfigure the device via pciehp_unconfigure_device
> 
> So I assume the existing sysfs slot "power" interface would do what
> you want except that nvme_remove() hangs?
> 
> There might be some improvement to make in nvme_remove(); maybe it
> doesn't correctly detect I/O errors or something.

There is a path to disable the controller and that code ran but did not help. I checked wit the nvme folks and Keith mentioned that there might be an issue with the nvme queue management. Unfortunately, we can't try newer kernels in the field. So, looking for a way to just "shut off the device" when we have scenarios like this where we can't untangle the mess. 
> But maybe there's *also* a case to be made for an interface like you
> suggest.  Lukas, Hans, any reaction to this?
>> Bjorn

I have a patch that I've tested out assuming this makes  approach makes sense. 
thanks
James


