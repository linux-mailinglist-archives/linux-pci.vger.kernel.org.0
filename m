Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 246F435A363
	for <lists+linux-pci@lfdr.de>; Fri,  9 Apr 2021 18:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbhDIQac (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Apr 2021 12:30:32 -0400
Received: from mail-bn7nam10on2063.outbound.protection.outlook.com ([40.107.92.63]:29088
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231402AbhDIQab (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Apr 2021 12:30:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GrduL5qejiE5QmHatG+MYrFoZNr3r7ZeO7T2Gx2FUjvUdQOQH25KbAx8THAyMxBON61vfW8imR5jjNT/gESDDrA5Pz1iIZz1z1CnuVtP5NQNY9m57QZau5Mpkr7m0lTWb+9qoqpEKEC01WjtS+Xle/HnhjQ+0XTS7zvsk4RwgmpcwQ9Jbrm1lDqb0IvFvI9iC8+ml9q73QzrrTvBZ7kB2L/JhLDvRGVcuy1hO6Nfd9Aj6eU0TQDszat8J9M+clH0KJHtZDtMhuXNMN9ccy3d+6UFr5qyx7HmgeLsvLr17sPAJmEXXU7sjjsBRSE+A7JIrktbHw1MSqZCq16Tq9Sing==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/oh+YMK7guFuWO6N9kludC/9awNGZ2XC7rf8Ztit4ic=;
 b=JpItIqlsKEoEf3zux9BeVb+kSRhSwlgR6r+kppIN6SXKWUnXMzInpM0sKuu/9quUDleaP9utf6tNYQ44wGILUp8ZQ0F+suTtgD23EG10TSUyd6nHyHXxEivxTxkNYCGd87/dsVCaLP+82dzt27P61VhpvqrUN94tfFl5hYI/x7N1Ku8XZpDsvGYVnvxuqw/HQ5Esr5JMU3mGyUEyIhEbTXEkpUcAzSBLMBmFElTmiiSOzzDXchPMO8plIRG36qMgxhWSU+QBNYNgfdY1kjLsdQFeffzBLp/Zusj6HGWMnm71o2USUj/+e8BsMm9eIYxa2SCxu1oODh/urMHKFMOk3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/oh+YMK7guFuWO6N9kludC/9awNGZ2XC7rf8Ztit4ic=;
 b=PHIAFB1xeTic37NgdEIPuqxKyZ2WWArkcOf7Dj+RV8pWYT+ekFGwn5iCK2CvVr1lEXini8mAOhy8ifHBPNJzw5D3bNtoonjybnICk7u0FwXN2V0g27LFHWHprLz7ZWVvexf6w3ej2uO8E9CrfMrGb+FMHqS+54QyxupM5+xtzyg=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4358.namprd12.prod.outlook.com (2603:10b6:208:24f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Fri, 9 Apr
 2021 16:30:16 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4020.017; Fri, 9 Apr 2021
 16:30:16 +0000
Subject: Re: Are back to back PCIe BAR allocations supported by Linux?
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Cc:     Sergei Miroshnichenko <s.miroshnichenko@yadro.com>,
        Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
        Bjorn Helgaas <helgaas@kernel.org>
References: <30b3cc23-75db-a2f7-cf1d-e02182db8be3@amd.com>
Message-ID: <b8c36df9-b0bb-08b7-518e-d3768e4707be@amd.com>
Date:   Fri, 9 Apr 2021 18:30:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <30b3cc23-75db-a2f7-cf1d-e02182db8be3@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:38d3:2905:48d2:92b1]
X-ClientProxiedBy: PR2P264CA0042.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:101:1::30) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:38d3:2905:48d2:92b1] (2a02:908:1252:fb60:38d3:2905:48d2:92b1) by PR2P264CA0042.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101:1::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Fri, 9 Apr 2021 16:30:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 996ab96b-94a9-4041-b2b1-08d8fb74c1d5
X-MS-TrafficTypeDiagnostic: MN2PR12MB4358:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB435833A15C4E5B337EE06AE683739@MN2PR12MB4358.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IGZHG9yPbhFzdGmGnq8h36hiPf9Fukky17jDnc8kylqOqDaqL3NpOYrnDW7B8FBJn0/9QVJVjz78obAswlWmNSihpU4n6qjSzN9jfCH0RGBIHHQ791JJ8OfVuE7YxSzqn2ri5cPsTFxdfDqAx68kLSUaz23Hpt87l6Iunva8p8B/fpi4049zbfsaPiBJeYDP/udgSGci1Ef1dJRerVTFmE1O3zk3LmmaMTO5wbMpE1AsEsA9fBtELa1bOmq2GA31dmk4GbcjdQj11b5bk7ftw1W4TQjdBQZGy+FDzeyNW9RslKOfdN4bobfJPDPDRZyLoPe0MD75ZDQfPFMBzwwfSgd8dLnrEbc0CsUwJb0F0KaabYjwZDV1WPvMdTnQeKYdXPCYBoJyfuP07A8gw/blsGlUPPiHnnMpcD7XvsfjZbsg19hd2x2jvN+g+KpKO716bVwqm2UZkSBTVpsLuS0+djrwbOJ4YL4iKMshdffgFmybOPHDdKGXWgP6loL9vG0FZ+7tW3xaDZ13FZ433GmRFNHARwKQcQtvZRSxHqL43TVj4xmeBYtjiebXV4g2hjGK7ctCAjhh0BqI5dIHi0JFcdJUy59w6TWyd9xm/dd3cwWFHZlQ7MreG5nq2YcwXZm58vHi9U8e/i/pIu9bKvf6OQmBxiCPNzMCN5RRQYec+UICZVWUkfP98EWAxRpi73SpdnTY8PTQ6c+9H295l6DoO9/sin3H+1CzX7fDK+PxC9A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(366004)(396003)(376002)(346002)(66556008)(66476007)(38100700001)(6666004)(8676002)(6916009)(52116002)(66946007)(316002)(31696002)(86362001)(54906003)(2616005)(5660300002)(186003)(4326008)(31686004)(16526019)(2906002)(66574015)(478600001)(6486002)(8936002)(83380400001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Y2ErQ3N5azJNL3drdWJKejZGQU4rTHliaDVNUzlRbnZKMnB6bDh4N3ZOQk1o?=
 =?utf-8?B?SGVYMGVBNDF6YVprK3FFbVJKZFNBZ0NiR251NFpxTU1WNmNrZEZjUGJHcUdm?=
 =?utf-8?B?aEVsK0lTcEQyaTgxWE9UWkpRK1ZRYXltc2xXZExwbjNUc1Q3eGdVaGxMMGl3?=
 =?utf-8?B?Zjc2U2lwUC96Tkk5bm1KaEdncFR0dVFNZDVZWEpPd2Q3TC8vOEFreS9Jc2VW?=
 =?utf-8?B?Zk9hcnI4ZjBENC81T2ZqUHgvT29qUG5NdmJ6SmpWZDRjNHpzZmpHSjRjUXFi?=
 =?utf-8?B?MGdqRjd4bk8rU1ozQVBYODlnczg3K1crVHBGNzgwdi91aHBtU0tvRm1JaGpX?=
 =?utf-8?B?aVI0cGptQVVkdkhGTkFNL3lVdmlHK0I2SnI1ZkVweXlLc1UwdUZCVEdPcjlN?=
 =?utf-8?B?T2t1WWpnay9qcXBWWjIyaTZ5RTJjWTNRN1N4UU8xWWJ2djlKTWxERWNscnB2?=
 =?utf-8?B?dmlXa29QOEtJeERob0VPZUVnUnFTUjlPTGM1UUFpeFoyUks1Sytpa1VVY3VZ?=
 =?utf-8?B?L1JpUzcxQkVoUTNpR3RYbUZQaGdmWFRaMHdtNllWOXNHVWFnTjVYdDV5Tnc5?=
 =?utf-8?B?UHNSTC9ONUhJcE1mVzczcEgxWER1UjVCczR2ODF3citOdmhKSVN1Q2h5ditC?=
 =?utf-8?B?LzQ5MCsvTCtxcmU4QUpRc3VtQ29BT2hDT242aVBOMDRVVlY3SW91K2EwcEZt?=
 =?utf-8?B?UzB3UnhET2IrRUJpMUs5cHVneUphYW5XVzQ3YWtrRmQvSHg1bnN5L093ODNx?=
 =?utf-8?B?OElWVHB0VkVQVXJJdDdrc3lxemNuNHdsNmVsTVVJUytZbnBXT0hkaHdiVWwx?=
 =?utf-8?B?K2o0djE0cjFVQ1NQYWhVamxSRllYSisyZC9KSnZNMFl1cTVvSlh6MkpqNmp5?=
 =?utf-8?B?WEhhQWZ6alJUOFVPZmFzbEtQeWI1MDlkL3NMQi9wWVgraEdkRTc1QUFyd3Fm?=
 =?utf-8?B?cVM5TUNuZmhWeWFwdVlHdW9xVWY2b1Jva0QrK2JXQm1LbFFMVEkvVC9QUWRu?=
 =?utf-8?B?L2ZFY1BLMFJwZEhET0VJMXZkOVcrM2hqa0REVzNhMWk0cVZsSGNKRTgxNEYz?=
 =?utf-8?B?YWVjeXV2b3RMV3BsT0Vwc3V3bHlFZFg1Q3lJdnluNHJ0K1dEbHA3WmhSTTNR?=
 =?utf-8?B?aUI0ZU8rcDNObWNKV1FxNXYyd1lNYVJhem5WUUo4T1VsTE1NemNrOERuVm9k?=
 =?utf-8?B?NEJUYjUyNHpHT2lTTWhYNDgxRHVRcW9uYy93ejRaUytQNFpRQXZFTDNXTm9M?=
 =?utf-8?B?UlJ2ZHd6a2hDWm1jZEtoY3ptYkplbEJYYmRsbHpvZFpRU2R6QjRCK0xoVzVD?=
 =?utf-8?B?Um45Y2FaaHp1MkRoclVoWFZDTW5oTTk0Z2FkWDEzanh3R0VBQndtc0R5VEMw?=
 =?utf-8?B?UGcwQWdVYmdpdGs0NytyQUlrYk9SZVRZREltMVM4aDdHZkJtcEtaMlM1Z1Bp?=
 =?utf-8?B?TnJQZUJqWnhXZ1g3MXVKUGhVMzRla3ZkSlI1WWxYbnhMQ3J4SzJ2RHpkL3RR?=
 =?utf-8?B?TlJvNGFEN3l2MklwcWhVRzBBZnN6U09qdGx0Zzg4cGwzeSt5dWNiN3Vqd2lY?=
 =?utf-8?B?a2t3K1Y0S1VnSjNPZ2ZsWmFWRTVqVW5vbFJYZDMrcTF3Tnc0TytKR0VmYjMr?=
 =?utf-8?B?QndQaitqZ0pNZTB0UE9KSXgrZ3UzVlQ2emtKamQxNlozSzJvTHRvNE0wMGFQ?=
 =?utf-8?B?Y1ZYZXduVWNMemRhMnZiSGtBZmdZTUJvdXl6TWZ5Y1FGVnJ1N3B0ZDlPQmlP?=
 =?utf-8?B?eWMybDIzNjZVRFFHTmk4SHF2cWErTmtkSm5QWlV4Rkg5VWRQcGdEOG52QU85?=
 =?utf-8?B?OFVobGkrSzlqL2JraTYzYVZValZ1bms5L3h1RkJ6b1lHTTQ1ZDF6SnJkYk5E?=
 =?utf-8?Q?Omi8pw+rC899s?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 996ab96b-94a9-4041-b2b1-08d8fb74c1d5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2021 16:30:16.4198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TZbmGDtjX8dfrbarfLEgsDINjX0ODbDS3ZkZXBZL/NT1slJRZ1iEmnhuEOr4aKpS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4358
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Ping?

Am 01.04.21 um 14:03 schrieb Christian König:
> Hello everyone,
>
> we recently had a bug report of a system which works fine when a PCIe 
> hotplug device is connected on boot, but fails to initialize if those 
> device are disconnected and then reconnected again.
>
> During investigation I've found that Linux isn't able to assign the 
> BARs of the device correctly while reconnecting. The problem seems to 
> be that the Linux PCI code doesn't seem to use back to back BAR 
> allocations.
>
> Now what's back to back BAR allocation? Let's assume you have two 
> devices with a 256MiB BAR and a 2MiB BAR each behind a common upstream 
> bridge.
>
> The configuration Linux seems to use is the following:
> Device A - 256MiB BAR
> Device A -     2MiB BAR
> Padding     254MiB
> Device B - 256MiB BAR
> Device B -     2MIB BAR
>
> With padding this results in at least 770MiB address space requirement 
> for the common upstream bridge, with alignment this is probably more 
> like 1GiB.
>
> The BIOS on the other hand seems to be capable of configuring the BARs 
> like this:
>
> Device A - 256MiB BAR
> Device A -     2MiB BAR
> Padding     252MiB
> Device B -     2MIB BAR
> Device B - 256MiB BAR
>
> The result is that you only need 768MiB address space for the upstream 
> bridge which then perfectly fits into what is assigned for hotplug here.
>
> Is that already supported by the Linux PCIe code? If yes then how? 
> I've tried to read a bit into the BAR allocation code, but it is kind 
> of hard to understand.
>
> Regards,
> Christian.

