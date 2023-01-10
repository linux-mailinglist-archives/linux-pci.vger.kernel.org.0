Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6968D664293
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jan 2023 14:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238117AbjAJN5t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Jan 2023 08:57:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238256AbjAJN5Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Jan 2023 08:57:24 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B855F7C;
        Tue, 10 Jan 2023 05:57:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y6Wh/Lvpjdo/GRfnCUhn8UB55RRpRo9ZkDm1Gd9bxhZ97GgFJIUTo9WndWY6EcDl+UPYZ69OHnoMMacG3Dtw+HB0GvrX1W3/u79skeASsZr//p1h/vgtwcQbvl0AB9qVmO3i7VDXTCGy59u6pNQZMMt7UB4AJKp3I2ECPzjXPdRLTp661f13YFYAio65CPLoLJ7c6ofWg8vfF0cwUJpLB99Rb30HhddLpEeAFpw+KUvkvf/M3l78Y/ON8FfJ9zcBKDvv+4aV4alXcgO21ng0SCyFdGi+2W6u1drLcksAYSzEME1oyPenl6n9uWuP+BGWSZ8NnIt2IJQH5Y1HbxNDAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=86BC0K4zBQ6aW3HnB6zHL7huEUdX50TTr/Wyij3BrA4=;
 b=Xl7MBoZhk565hyQnhi+Y1QamXePZIXziHZDASunoG8vLVHrNLTeC+2UaAVdjXniI9t6R+ISmQmphPdN8xSb6S8qHetDr06DQ1VVbLgYxdI3Mndvfz5Ci3+pEaR7PC4nrDHxNRjM48TrhVdY2jWiHhzVkts3jN9EC/QuPggdGuMXrxf6EXo5ijNYC8pRcDn/SzcTXliDTBPbVyJ+cEILsBmqYuCCZOWRzCW4a6x6KK62iAjJALHqo3kH07GUh0/RIm9gkXV7FH+d2T1YxIs/u6ZrLzWqgllmnFt1uKml/XBZ4Mf1B2zxIGsOqnx/ucPTgP4sI9aaBEfcZR4k6lCdjAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86BC0K4zBQ6aW3HnB6zHL7huEUdX50TTr/Wyij3BrA4=;
 b=n5pAdNdl5a6BeiGt78ioIANXCE1DJFzn/fr/cuI/lg3n+QDpVIh+QdNcO7DyPeNf2ScZ2g9W84rOGbsn3B/cf3wfzDGbtaztpsjiY7TAMBuvU1DHWt/k1r4zktHzh7bc0KyFXVSLVIZMfdJq9PL62ERjL362O2NFYtM/04EFgQw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CY5PR12MB6347.namprd12.prod.outlook.com (2603:10b6:930:20::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 13:57:01 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::80d8:934f:caa7:67b0]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::80d8:934f:caa7:67b0%3]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 13:57:01 +0000
Message-ID: <35b0f7db-e248-18ed-3e26-3f9f4f14f8c4@amd.com>
Date:   Tue, 10 Jan 2023 14:56:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: =?UTF-8?Q?Re=3a_=5bregression=2c_bisected=2c_pci/iommu=5d_Bug=c2=a0?=
 =?UTF-8?Q?216865_-_Black_screen_when_amdgpu_started_during_6=2e2-rc1_boot_w?=
 =?UTF-8?Q?ith_AMD_IOMMU_enabled?=
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Baolu Lu <baolu.lu@linux.intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Matt Fagnani <matt.fagnani@bell.net>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Joerg Roedel <jroedel@suse.de>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        amd-gfx@lists.freedesktop.org
References: <15d0f9ff-2a56-b3e9-5b45-e6b23300ae3b@leemhuis.info>
 <5aa0e698-f715-0481-36e5-46505024ebc1@bell.net>
 <aea57c5f-2d20-c589-ad44-a63f1133a3db@linux.intel.com>
 <157c4ca4-370a-5d7e-fe32-c64d934f6979@amd.com>
 <223ee6d6-70ea-1d53-8bc2-2d22201d8dde@bell.net>
 <6fff9d10-f77f-e55a-9020-8a1bd34cf508@amd.com> <Y7gs0zYKp/VXACBi@nvidia.com>
 <f96b1cf3-6865-663d-f1cd-466a71519b08@linux.intel.com>
 <Y71nZuF5wQp3eqmn@nvidia.com> <2d1b2183-7e93-f8a5-3c74-8f66824bc8f2@amd.com>
 <Y71tTdm/f+uxsTKj@nvidia.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <Y71tTdm/f+uxsTKj@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0179.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::16) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|CY5PR12MB6347:EE_
X-MS-Office365-Filtering-Correlation-Id: 643ce604-84a2-4e68-70e6-08daf3128c01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: snYlZmKPl+56JVRi853hN+Sdr60Jp0sepMVey9UKZmGQh2bscacGMW4s+mK8mL3U8niT2V11glcV4lKWsdN2p8PUxFY4+Qw4bEjmRvHWpOGgVJdN2VY3oBzoGcysOVky+JUVQWYVD7GhJXGemc7AN34el3gvh+KX3Mm/E0zedUhc4VjzZM+HM1AcrB92abCixNOEjo6usKIT7+10KO4MvuJQXocjcq+D5yN1JZA12wjK810M/i/mF+Qh2QSbrTxpS235Dmlz01/imMeUPvic3t+rZWf5bITRAkkmeJrAfSCyAiOIZecePuETEtu8qbsQ0y9vnglRjADSnnvAvTMB+TJaf+28sd0axsYhpHtjdhRoPucITG/pOnoltRu9j+LlYltErOUR/ktIDg8dpEthxNMn0ISVcmV56IRuAZl/JmOTSQeJ6kEPLH4PHpBqMnAKRjmnYntohpI2ivgILEmntfsL+7eXQS4wQIJl5uOup8uEKb2w0SnEBzuRhkt74lkdmxFw2zn5cdY9cNu/ViiYdkYMHyTl/LezmlZl+FvWiF4Z0V8K4+xEBrJ+W2AySHBCwS39xGUUYIkoB6S1nX0K9WaT+ctWlqlTmMu8X1uOA97lsyjKTR0APBgiobGCjx6L3yDyAwsIgEgOmtLh5OyXA6UPozNt21JB8iGHsACX+tkRh9PWSN+uOjzl13RwhYUfrDoSHoKc+yZtyESR7deCa1L6pmgpvOIQel2aeZ0iErQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3587.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(451199015)(31686004)(4744005)(38100700002)(7416002)(5660300002)(8936002)(478600001)(6486002)(83380400001)(41300700001)(66556008)(66946007)(66476007)(6916009)(36756003)(4326008)(66574015)(86362001)(316002)(31696002)(2906002)(2616005)(54906003)(6666004)(6506007)(26005)(6512007)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUNwREJ1RThmRk10Z2VTb2Uzc1R1dVVwZUtFNlN2cUpnN0dwd0ZQSEh5VS9Z?=
 =?utf-8?B?R1Z0K1M3QW5zOU1BVUk3QXY2SEQyOHdOejU4WklvdnlTNlgrdEFRWG83ajdw?=
 =?utf-8?B?K2kvTmo4emo4MDdMOGduSWtzZVBubDZyUDVXcE45SnQ2bmtFR0hJZ09FcXVv?=
 =?utf-8?B?MVZQeXV6RTU1TW11VVFIMnVvOEc0OFhaT1p1dWM2NFd4WWV1QjJYZnR0ZUxY?=
 =?utf-8?B?bVVEbjNQUFFQSUw5b2pITmdNcU1iaFY0MHI1cVNsZnhRZHNidUkvT0QvS2No?=
 =?utf-8?B?b1hrajNveGdaUHZ4VkZwUGFoaUo3cThmWlRtQkV5b0tMSGJaUFMxci8vZmdX?=
 =?utf-8?B?T3FSRHZ2MS8wTlVmQ2hxdHIzU0EzbDhJdDBMaE50NFhESWJ1SzdsRGdFWWRJ?=
 =?utf-8?B?VzdWY0FUMFJIWURreGFmbWx5NStvT3FYKytaMVQwS1FvRFQ0dlFIQmlJVElS?=
 =?utf-8?B?YzNBUmxoN0ZOd2s4ZTZvMnRoRk5hclY3bUtsM1JMMkd1Yk5HdHNOem9VV05r?=
 =?utf-8?B?Q1ZUSElzaiticE9FK2ZkdDVnY2hUeENoU1BHb3A0VzhiQ2JDeTZnY0FUbnFC?=
 =?utf-8?B?YnZxQTVMM1dDN054RVEwQlNpQmllRzRCSEYrVys2T1RaT0ptOVNCcjZzeloz?=
 =?utf-8?B?b0VFRWhkbU5iRWErVUV4RlBJKzB3L3UyRTl0OE1ubDlxU3k2S3VBNUFlR2th?=
 =?utf-8?B?N0hITVMyVzZFV0d0bVJ1eE1GTlB0OTNncVNwRHVVa0Q2NzUxSkJwREJ4bkgx?=
 =?utf-8?B?U3FZS3E1T25tZnRIMlNDcXVIM1llRUpQOTM2U3Rhem5QMjRuWUlScTF1Mk1B?=
 =?utf-8?B?NGpDYkhtKytyREhHbjZZL2Y5cWllb3lhRndEM1k2VzVHL0dweVFabFBUaW4y?=
 =?utf-8?B?YXVSK2w5eVh2bmdzdXpRdmpJbkVBdWRnUVM2SXNBSklPemRFMjRGZlVMTTAy?=
 =?utf-8?B?V1l3TFZuckVTeGdQeVFXL1BUMTk5MGJjblVnVVhQem5OT2JWczd6cHpOcTdO?=
 =?utf-8?B?bWV4SHZINGQ2b1FBNWNhR2xXWEw5Qm1jTVNuZHQyYzlMK2xTeXdrMklubUpk?=
 =?utf-8?B?T2ZkTEVqeURHOSt4c00rcEM5WURMa1VRU3lxbW5IdExFSjFrYkhqSnEzR0hO?=
 =?utf-8?B?YmlReWc1Q1R0dW5KNVVKM0psOE1PREprdVNXL2pYTVEyZ2NGWHcwd04wVUJW?=
 =?utf-8?B?WHdGY3EveGFBaUYzVzNxcGlhRXBzc2FObHJWMnJZVXdkQzEzallJMFNNam5h?=
 =?utf-8?B?TVBaYUVIeWk4c29jdlhsVnFvTUZuZUhQYWtMNnJ6TDRIMllTNzZsRm5wN1Y1?=
 =?utf-8?B?ZjBOeE1KREdVS0ZtTFp4c1ozejBGTXd5QzhkdElPdE9FdThXc3g0NkRmMWNT?=
 =?utf-8?B?bGpVYkRPaFg1MytBWmZHbjBlVXV1bEpYUG5tQkx1U3h3YnVhempZN3U4bUZn?=
 =?utf-8?B?ZXN3TGhxcFpkUWF1SHNaL0FRelk5RVQrNXRhNHV0L1daWUl5dVcrTkNITUVQ?=
 =?utf-8?B?ZHJRNllXK3lYRnpaU04xQjdIVzFuZE52RFRjYkU3U2QwQXdnWVlqd1BWUDNM?=
 =?utf-8?B?a25aR3p3WHRxSCtxazVESnFvL0JsbDRpZS91NDhZM3BYZ2Foa1NlWGZOYVNp?=
 =?utf-8?B?blJFZmc4UTh2bHhkVWxrTWZmeEwzZUxkVWthQ2NuZXQzelhCeXZWSHVUWFRo?=
 =?utf-8?B?WkswUEdaenNxQlVoRFpnT1RoRUN4Q29wbm9ERWxPeUVPeTduenR3bXNjaFlD?=
 =?utf-8?B?V0JaejNYcTc3aHlWeEJmaWVpZW53RWFTSzlwSWZOeHpsZjJ2aHg0QXIrd08z?=
 =?utf-8?B?L3FpTFdDMmVvczdiMCtueldjVGYwbnNmNlQ5UmRWVWYxZUZoZUlSTzZKMkZa?=
 =?utf-8?B?QVNMKzBZcHpNL3ljVWR6aWR1UkNzaHUxT3VkRWhPYmtjV2RpSVBVaW5rcjdK?=
 =?utf-8?B?ZzZXUk95UzNoSXhxUmxoNXU4ZEkwMU5PVEQ3MnFxU0dqTXc1bG96TzZqWnZ5?=
 =?utf-8?B?cVlWWEZZTzExZFFmVitoK2RnUXlXeWthQmlHdzVYZEpEY3VEYlRnZ0VkMUpq?=
 =?utf-8?B?WDJnelFvLzJNNGFQbVVuQnJNRW9Wc3UzS3Q2bmtzdDZOUTFjcG52NGJsR0or?=
 =?utf-8?Q?5mXuHPK51QLulBo/aLPS+D4HI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 643ce604-84a2-4e68-70e6-08daf3128c01
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 13:57:01.2555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RJA3QMTy7JvIJhoVxcwm/p/5LndcpmntESgcfYNnUF6/71ePGjrgbb1WwyqQJwnM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6347
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 10.01.23 um 14:51 schrieb Jason Gunthorpe:
> On Tue, Jan 10, 2023 at 02:45:30PM +0100, Christian König wrote:
>
>> Since this is a device integrated in the CPU it could be that the ACS/ATS
>> functionalities are controlled by the BIOS and can be enabled/disabled
>> there. But this should always enable/disable both.
> This sounds like a GPU driver bug then, it should tolerate PASID being
> unavailable because of BIOS issues/whatever and not black screen on
> boot?

Yeah, potentially. Could I get a full "sudo lspci -vvvv -s $bus_id" + 
dmesg of that device?

Thanks,
Christian.

>
> Jason

