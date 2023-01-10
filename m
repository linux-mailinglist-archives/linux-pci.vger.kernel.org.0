Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC99A66441B
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jan 2023 16:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238229AbjAJPHD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Jan 2023 10:07:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238146AbjAJPGi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Jan 2023 10:06:38 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100F6B89;
        Tue, 10 Jan 2023 07:05:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F0DhWPUu3LEwfO/EdLhiQT9djnZep3/IKdg7phS3b0PBqL2VAi/4V+X2wFYWqCB474KoQxUBEnnS0FJRXF2m1giNTcSPNM4LKZE4y1Xq8e7jNu9kmHAxFvpfRQmfpNrK3NvhAcp8mezvdqvN8KXvpIEIVVnbDa4MPESB019ddqxFh2hqUi88tUoPbSwujy5oph7dWtfPOZHgxkRRvM2tN62ESLlFXeby/C2lMX6q7MectLIPJ4i5wwIxW8dxDZlb+GtaV8PiJCPiAQEm7TgWxrI7DzZUkprYYX3lNUi1dKa0TltpSOZWcuPFxoidgFoDWCrhessmwyyjni3nuJ+M/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aGyK7eviv/pvmxlwFqzRnAykeyjcBJGEPl1j9WLkVmE=;
 b=mI72yagQO+vx6QFSi1fNXe6inWqKbpyMTOlObsqpjLWNxZJF7w6HyAYEGISB8Ha2ZkYGYGTAKSbowDB52myf+2kDDB50YiIxd7/Zp2resP4mw6/o+I50Hc6COPHCTTwKEN0kAq8i+uCaPXJsNER1LPn/PGAH8pzIazanf+0oZEYnqtYN4v+pYAaXIMTWWAjXt28QnC3yt1zH3sq1UBU8H9T5PLR4yV7v4RWXFb502F6IZkmj418z8y34lgZSx0BXgxmapTJ77QXSnqMeHAo75BH+dj+eSK4aqissZVUjGGwKHlMVOKuPpEV50O61CGG/mTbtFmMA/u2V/x4pscO6fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGyK7eviv/pvmxlwFqzRnAykeyjcBJGEPl1j9WLkVmE=;
 b=1G5SeBsiaYO+Ve5lT/OKxSNFAKvOKirYdxx0kwltOjojBgospg9C8gIsCgxyS0yMz7ygWh+vvDhLSK3sPAvkBVk4kqix5TSmaVfvbHBABacyED5BWERn65FCBk8Wn42aH1jB6VjUDKOhD2AmGx+XGiq1NzmPGp9fi1/P90lnmlM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MW4PR12MB6898.namprd12.prod.outlook.com (2603:10b6:303:207::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 15:05:47 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::c3f5:aede:fa4d:5411]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::c3f5:aede:fa4d:5411%5]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 15:05:47 +0000
Message-ID: <fa99d96e-6897-850a-8a46-98b03696e0bb@amd.com>
Date:   Tue, 10 Jan 2023 10:05:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: =?UTF-8?Q?Re=3a_=5bregression=2c_bisected=2c_pci/iommu=5d_Bug=c2=a0?=
 =?UTF-8?Q?216865_-_Black_screen_when_amdgpu_started_during_6=2e2-rc1_boot_w?=
 =?UTF-8?Q?ith_AMD_IOMMU_enabled?=
Content-Language: en-US
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Baolu Lu <baolu.lu@linux.intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>
Cc:     Joerg Roedel <jroedel@suse.de>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Vasant Hegde <vasant.hegde@amd.com>,
        amd-gfx@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Matt Fagnani <matt.fagnani@bell.net>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <15d0f9ff-2a56-b3e9-5b45-e6b23300ae3b@leemhuis.info>
 <5aa0e698-f715-0481-36e5-46505024ebc1@bell.net>
 <aea57c5f-2d20-c589-ad44-a63f1133a3db@linux.intel.com>
 <157c4ca4-370a-5d7e-fe32-c64d934f6979@amd.com>
 <223ee6d6-70ea-1d53-8bc2-2d22201d8dde@bell.net>
 <6fff9d10-f77f-e55a-9020-8a1bd34cf508@amd.com> <Y7gs0zYKp/VXACBi@nvidia.com>
 <f96b1cf3-6865-663d-f1cd-466a71519b08@linux.intel.com>
 <Y71nZuF5wQp3eqmn@nvidia.com> <2d1b2183-7e93-f8a5-3c74-8f66824bc8f2@amd.com>
From:   Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <2d1b2183-7e93-f8a5-3c74-8f66824bc8f2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0022.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::30)
 To BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MW4PR12MB6898:EE_
X-MS-Office365-Filtering-Correlation-Id: 9be46c15-e4ed-4131-75c4-08daf31c271c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: erz3D66Pj48rV+kUJ9Hm7XWgtMuy0OCtI6HvhfE3/zuxov992V+dfRYwm7IxgtxRqeDXkiAI9R4gFIQ7t6R8Gm19APRsHQATeGPgqKvdf6Cm3aGl13CACtPd07PiTaqgZcn6/TahvoWQYkbC9YzVyS6bbKeUbp9ci9WvoizcbjLnljv40ztvrYAVofJoqPdPiWW0DmrP3/jKrHIP7xE4TIACDS+UGvHW00dDKCNuhsTu35Yg85Wt3HHmqVdGWHGY8Yj/zyZGhS/boZCloKXwmXejiULt6+Xa441o6p8s9oR6kHiz7+732ngRRlfIgc4B4+183FRm7pGYc52thIDHO04V9tBuN52WE8RqQ3hD5UPufDqDtb5+hLwyZ1O0C8Gr/QW0gqAbGtz/BeULSBSRcTpFaGEylR+/vW+ZKaYmbsLh6Y+IBS/2MP4+ZbxFHFU60o5LSnAZ7wKdik5B+lM3v+QPYq1eLkeGExTAVEINZTgZiR7kQkSYO2fNOvn/hZFHU1QrNW67nUQauL3XXWvTdM/oeSNtbRcRhaQ5a7p666q/FE9zmNKqiws0j1C1uwu03S60/Ta3hPlfPfYlJhtFXKkafmPtUnmlPB/uxD4EKvaP2cp1KUadLHKQpReDzQYLygElNIykYM1Ch2XTQIPVVc147LL15u6KgzDTSMZDgMg04Q7ELdrHL5mZtosQVbJMNDho1O7zdk32fq3pgItlSmRmZ5jQfHirTqsMLsgVyHk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5115.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(366004)(376002)(136003)(346002)(451199015)(31696002)(4744005)(2906002)(44832011)(41300700001)(8936002)(7416002)(5660300002)(186003)(478600001)(6666004)(38100700002)(6486002)(6506007)(6512007)(2616005)(66476007)(4326008)(316002)(26005)(54906003)(66946007)(110136005)(66556008)(86362001)(6636002)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MG91SmhQcTdzQzZ0NHJXUnphdkZFSnlSNzdDRnlDeTUzSzZZVHdtamx0TTVK?=
 =?utf-8?B?bjdhdkx2Qll5MnJ1bmZlUm02ZUQxbk9pdk9yZHZVMUFEMlYrMmx4Ly9PN2JB?=
 =?utf-8?B?RitmU0IzWnZqU3FraVhOMTFvb1R0U2ZzNVB5bzh5N3FrTGpnTTFIOEZqQnkw?=
 =?utf-8?B?NUV6MldTaDBtekY4THA4enp3SDFWVnl0MjB4T3NHZzZlTEpIM3FkSjNvQ1hu?=
 =?utf-8?B?SXpkRy9VaGFKUnBCY1ZvazhNaEl0RGdaR3ozeG9YZTI3NVdoSkZWc3h1TnQ3?=
 =?utf-8?B?c0I4TGZLbURSdUFta1I3YUR2TDZOS2tYTHU4cDMzNHZUZnBxWmhnMlFDZGZ6?=
 =?utf-8?B?YzRnNDZlNlh3UDlYTWU1MXE5Z0tGR3BHNS9Ra2Y4Y2FBVmhJaCtZYmo3eUdH?=
 =?utf-8?B?TU1Tcit4aVhaSzFkbDJvbkdCYVBJOXo3eHJ0UjlOTHBXNERsd0xuZDNKTVpk?=
 =?utf-8?B?c011REt2ZnMreExuQ3hnRHNjWlBUMzNHNlZnd29Kd0loUEN4TmNIYXFkcUJN?=
 =?utf-8?B?cUEzMllJdVJiZ0p6U0tGOVZ5SmFoV0Z1VDlXd0t6R2djZXFLalY0QmgxN0hs?=
 =?utf-8?B?Yjc2WTFBdXFCQU9GMHMyOENETXBGa0FYVmFHejJZL2UxUHJjd2prQzIwQXB0?=
 =?utf-8?B?WWtFenhKQXVlRHNPWkNyRWhCRDVyWkxMY1MrMEVkT1NETmhYR1o0Zlh1YmxY?=
 =?utf-8?B?TithZElHTmFYNTB1UklUSnN2Q2ZkRlJ4MHRUaE9yL2YrT0Q3cWZSTGdOeEly?=
 =?utf-8?B?NDVVQnR0ako1eGIvNVF5WkpRV3lLRjY2d3htVEZROFNheFlqWS9icFRQb2xj?=
 =?utf-8?B?bVJIU29WT21OMklTQWxZUnNDdkMxWDFBVFQrb3F3OTZ4eTE1NXJoNmQvSE5x?=
 =?utf-8?B?amJQQm1SWEszWGVEQzA1VUgrK1JBZXR1c3BLLzZyWlN6TVdJRWI0OUpUT3dJ?=
 =?utf-8?B?cjZBSE1BOHZYdHZvaWZmYmVMQ2pQaWFnUlhTbzFEM1N1aGR6SHlKUzdKeklm?=
 =?utf-8?B?cW9oRjhlTlZwSDJFdlFBVzl2Q2FyS3k4cVk0RDdPNGlVSUdSQUhBdkIyWCtw?=
 =?utf-8?B?ZmNWbytkZ3NVZENUMytTUWJPNEtFekdWZVNyWVhFZ3hJQzZFc2hGV3h1Sm0w?=
 =?utf-8?B?N3NjMGlKa2EzY3VwVmc2U1JLL2FaVXlIRlY5SGl6Y2QxSFlLUzkvbG9vWVBS?=
 =?utf-8?B?OHE5OHppOFNYMzg2MUxwYlY1bDJLTDhIQkt2c1NCT28wbXRuZVBSTUpydkZR?=
 =?utf-8?B?L2ZVeHJiQjRVaXFLL204REhvME1hU0xaREVLcUkzQ3E1UnB5c2M4UEYrRDNP?=
 =?utf-8?B?cXFNUFk4NmJnREhGU0JQZ2FJdkcwTFFRbUJFZUpqblpoTHpySTFwQkx2YmtH?=
 =?utf-8?B?aG10NFowdk5KUlU0M3VJQnVXdngvUzh3d2NjV0o4Q0plNVphaW5ITlhFek01?=
 =?utf-8?B?bjZpY3NrNEcvWmhoak1MMVZJWHVBQXM3eGJhQjh6b1orSGVqYmo3MldTNHpU?=
 =?utf-8?B?Y3pRa1dRK0hjcGpJMEdadGI2czdaRXhZeUFXcU9RSjBkTHNiNjI1d3RKcGFK?=
 =?utf-8?B?YWYwaCtiNE8rR0plZjk5NUpSR25NdE9oRmhZeEY0M0pxL0o2VGV1WW0yUW8v?=
 =?utf-8?B?UjgxdUJEelVkMzZySlM5WmRwQ3hOMUFsamRPNlJNeFlXUFBXOGlyQWVpeWo4?=
 =?utf-8?B?eHZMRDFsZEp4WVFhYkhhbXBsYUNmbW1kS3hKYnRCVm1rMWZKbDVlNHMwV05q?=
 =?utf-8?B?SkpvZ21HQmtkMVV3ODhUWG9PTStLVWxlc2xSM3RCOVpaanArbHhHUW44cVc2?=
 =?utf-8?B?QXNncFBQZUJyaWg4L0czUGs2QWRXRzN2Q1dEUzdRc0FQUEpUckJ5dExmWXo4?=
 =?utf-8?B?YUtuamdDbVFFZU9WYk5QZlRURFU5R3JjeTA3SHhwa29TR2dOL0FpL0hjQnMy?=
 =?utf-8?B?NFoxeC9OeDZrT2xWVmVHcGtuR20zdXdnRWsxbE1FSkFvY2RrMUZ2eXkrbmtK?=
 =?utf-8?B?K0szSTdQZ2dJRUZRYXpYSXg0YXR2SnFndGgydElncEY0cEUzR0lRcDJqRjFq?=
 =?utf-8?B?NUJkQnc3UU1lN2haZ2ZkdDdoL1R4ZFE5OHQwUlVaRnovdDJackFLSVYzeHc0?=
 =?utf-8?Q?IrZQHj9bkBVwP6Gjq9/l969lW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9be46c15-e4ed-4131-75c4-08daf31c271c
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 15:05:46.8875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GUuUFnyuPC+2buuD0HVrz0A8yY+Ye4shJhHnXmxQtv6qRXDGnPejrnX1UiU4p7hvKuRM3mAetqoEri73voGuCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6898
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 2023-01-10 um 08:45 schrieb Christian König:
> And I'm like 99% sure that Kabini/Wani should be identical to that. 

Kabini is not supported by KFD. There should be no calls to 
amd_iommu_... functions on Kabini, at least not from kfd_iommu.c. And 
I'm not aware of any other callers in amdgpu.ko.

Regards,
   Felix


