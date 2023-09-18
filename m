Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 072517A4BBD
	for <lists+linux-pci@lfdr.de>; Mon, 18 Sep 2023 17:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237619AbjIRPVm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Sep 2023 11:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237639AbjIRPVm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Sep 2023 11:21:42 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF18CE2
        for <linux-pci@vger.kernel.org>; Mon, 18 Sep 2023 08:19:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P07iZEn0pQap6YuGYZVR4vNWgKNuJDSo+3zYZ07bfAkURHeGPsQqzEz9Tlo2io/jSKW31gyp4PViN0pK0QYxCq50ImECkVUw0v5V9WilDGdlYei1IDCbntjVsRlt+6AXPe8IVnbAyvA7Rkk9UuVeMhbdfCcJCTS1dyWnw9CVgnYZJzxp2Lv2iAGN9HrYxNnUHvehIqBtOXctjqDDSr1DllrkFQ44yrp/t8v9aeqE52+4+gSrlFu3u2zY4IEOmmXDkmkimvKxu1ezeGFSYKIbqTUgH0BnCyAcSmVmcXeO/c3hKzbwyd2oT3g7rDcoQ0bnSRwxzZeK0bGEnGNOi2kQxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zHx83XkbZJtMrx+HBQFK28cFpx9eGqeW55gHRktPRjU=;
 b=DWLMrMa+OT3nF7AwrUa3ONUBDRA9JZhlA+eAgRbp1RwYkfdv0RJtxSPCfnitDYoiuM1LZe8mSYI13AArjJrfwqMLpdNPLKsH6E0oGkaX3F88GDJBGhSFpsWQOENoEz5xO4hht+rilkW7E2ZpPU1Tr9As0EWct4oT6ZiJ+z7zLnlfnJ8SThU8Eho3HAqElNSIxJqrFTzWcRsyKWFWhTGWGclrhlSkY1UIKtDOzXDhjixzonf1swXSF1koPBfmJGmsvmTbIxxiOv5vweffo+y1S0zKVI+7UDVJ46DFk3nEMrwMdy1VS6RtGuxLVwmI3IwAWxV/bHflPETf7Jo1ABdtSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHx83XkbZJtMrx+HBQFK28cFpx9eGqeW55gHRktPRjU=;
 b=XqpHNqKK4fRrZCtV6ROQTqgczmcT+uE/08IWrigIxOzAc6dupS7CYOmZESpmehKZvWGb44pIV50WwYnzzhz5COhb6zjYoAHZ47SUADVTA7Wr9QA4ndCOO5fKY/6jj786jyzR/FYPRVkT35nsrOPg39D1lRYmvag4Tpkx1ERch7I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) by
 DM4PR12MB6038.namprd12.prod.outlook.com (2603:10b6:8:ab::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.26; Mon, 18 Sep 2023 13:14:23 +0000
Received: from DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::44a:f414:7a0f:9dae]) by DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::44a:f414:7a0f:9dae%7]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 13:14:23 +0000
Message-ID: <fd432ea4-247a-49ca-88e6-c9f88485eb98@amd.com>
Date:   Mon, 18 Sep 2023 08:14:21 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/sysfs: Protect driver's D3cold preference from user
 space
Content-Language: en-US
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pci@vger.kernel.org
References: <b8a7f4af2b73f6b506ad8ddee59d747cbf834606.1695025365.git.lukas@wunner.de>
 <20230918130742.GU1599918@black.fi.intel.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230918130742.GU1599918@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::14) To DS7PR12MB6095.namprd12.prod.outlook.com
 (2603:10b6:8:9c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6095:EE_|DM4PR12MB6038:EE_
X-MS-Office365-Filtering-Correlation-Id: f1a5dbb1-f8fa-4b15-89db-08dbb8492d15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KtFwc56mzLRnK5ziDjtyPh3sX0MODlV/nY4sGDbQrvB/3IfkahG7IHxjFKHKB8d8G+8fg1kxohtRbRIghqKwprUek4cmpKaIa8z8zFszUWNCdw80UmRt/+o5tSja93to6WV+Bt8Pzu8/XkZ+ezloyxv0VM+inkogiPqeexCnfzy6R7H7aOrHNZ0JOpscBpHFCousOdWuZ8k6nYtbJuSh+gXE4nLMvVhCOw9qrjAVLGsZ6NM6NE54uEIOXYclpQGWNIZudtSLkODhp9uGyacXEZjdxUK9uN2Zce6rF1C4F4lljUJ40oXtFeLLsoCACpO7ICVjt4r/8byGRIAeMEFBpkebb9x2TeI6CVzDLWswW2FX4t2A/3P1ymEfxa7Csxgxa4iwnbzP0EWGgg/+wl1/d1ryApv+/JLauh/fJRvwWc3b0BX6dJiFWqzzzwyAVb+He0sAunBrkIrGG6NBL6j9uxl+fCZ6aZl+WM7BrJThRVJGpmyBsfLiILv1Nd/hKaU17IfVFve4JRl6z2TxFR38NlTZ4e3cJXNO/uCCBZYtWAcn7ZTpxWA/9IGYkQWOfKVudooEGjYLehYpMFtc+vYnCeoWB//BNX6pXNFigMXKtDLc8HIWSO3UPqX5i2QWXUAVJpIekKKoot0CcpJ6eamENRfdHuNrXhgTTymy9gqZ8GU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6095.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(396003)(376002)(39860400002)(1800799009)(186009)(451199024)(26005)(2616005)(8936002)(4326008)(8676002)(83380400001)(2906002)(36756003)(31696002)(5660300002)(44832011)(86362001)(53546011)(6506007)(6486002)(478600001)(31686004)(316002)(54906003)(6512007)(110136005)(66946007)(41300700001)(38100700002)(66556008)(66476007)(32563001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVhyWUhicnlqVkRNYnVZLzVJcTRuN1kwMGsydE9tMjF6OEdsUWhaN3BBNk1r?=
 =?utf-8?B?RFNMWFd3SWlla0hFRE93TTRtTVUvbmxLTjlhQVFMSVdZWXdkY0dHZ3ViMktN?=
 =?utf-8?B?dEdtSzlmb1VDa1ZqVVF0QmY3MWg3TEZjZmZ6K25IbDArR2t4WGNFNGQ5NGlV?=
 =?utf-8?B?aGhBWGQyaXl0QTN6K3hLYUs2cnhjaElNQ2I4b0NGUFdxOFNVSzVwczV0RUl4?=
 =?utf-8?B?d2FzWFYxQUhYby8xaklkVnVaOVY4Q2JWb0ZHR0ZzUW1UbXRHdU01a2VxTkc0?=
 =?utf-8?B?dEtwYVRiM216dkpCa0FlYStINlFGTWxyU3ZONE0rbXBzeWxacWQvbmtiNVRV?=
 =?utf-8?B?eW80RmlsanJBVDlid0V2Sldha2I2U2pKU2pRWXNxNEpYUkU1amdvcko3UlpZ?=
 =?utf-8?B?TitselhIWDBWaUl0citwMndUZmY2elRHU2xIZmErUkFQaG0wWkVjSTFkRXF0?=
 =?utf-8?B?R2ZHWGQzZnk4T1ZpcDJQNGtLVzN2Vjk5ZVpydEFiNE54dUtrdjZ3TkRialAy?=
 =?utf-8?B?Vzh6ZW9pSTc2SDJvd0R0M09rS3A2bWlzYjZEVUxJdkpKZyt0QjhzdXFkb1h1?=
 =?utf-8?B?VGpVSlZoVitsUDJycTFtT2NYcFhvV2tHTVBXT3hJMksvZGMwa2oyRVFrQUFB?=
 =?utf-8?B?TWFTQzJkZ1dyNTN0Uksrb3FMd1hBWHFSM3l1eWxpZ2JyMHlzUk5nTGwvZFpV?=
 =?utf-8?B?RmxSYVdCZWZUS1JBb0FqbmNLMlNBOG1NUHdzVUUvNjhjRnBlcDVRaC8wNXgz?=
 =?utf-8?B?SlRvbDVQcmYxakg1ckJ4SSsxTFhYSzJBN0x6aWxnNzZVazNEZUxta1JEL2tE?=
 =?utf-8?B?VmcwOTUxU1RDbSs1V3JRTE8yNWljK0x0UTlPSUFJU0h0UnJKcW9yRkI5b0wx?=
 =?utf-8?B?SFlFRUpoR2QvOFZkUUkxS2RFRmZzU1dERzB2T3A5aTFIM0V2UDRtUXNuTE4v?=
 =?utf-8?B?ZFd6c2o4YUVPaG80RFRqWFlMYk9hL2hFcGkydzdSOEJBSEVEQjBPa3FJMmFU?=
 =?utf-8?B?eHRoRUdyRS9pckprb0F0VlFHRVhRaFVuZ1JVbnp1QTloYVZtS05iYmpqcUJp?=
 =?utf-8?B?T2REbEpkNHA2VjJtbGlVT0FKUXFGRU9SNllpSWY3aWRXT3NxdVdUS095bENE?=
 =?utf-8?B?c01lUFl6enV5cExOQTdHZDRhbkhCZ3hUZ01GRldONXRmL1IyVEpoVVMybmJT?=
 =?utf-8?B?R2gwNnlweEJKM0ttUFRTTzVPMWxxclVZZ29BYnE1a1N3QndKNG1WYzBpQStH?=
 =?utf-8?B?Z2tza3JyQkNFU2ZxMDE2dHVXZ1phR29GaU1va2Z6dnBRNi9Idmx4ZEJSUk1n?=
 =?utf-8?B?cmc1Rm9GOGpOTHdZeHZxK2Jrc0xtMmhGSzNrRlpkeGFnbUlYTG5nalNNbkZi?=
 =?utf-8?B?T0ZRdHZBeWdZanRTODVFVGl2NmFOcklyLzNaUUhEd2Y2dlJXVjhsbnJEdlBO?=
 =?utf-8?B?S0ZjUzJra3BzYWFQcmxKUE1rN0tsQWhqdVQ2ZEZNcCs2UmtXZFVDekNyZTRG?=
 =?utf-8?B?UVpQSVQvd20vd1cydm1KVEJwZk5rM1FGY3Bib3FLMzN6L00zVVVOY2tBS3hn?=
 =?utf-8?B?bHZBUG1CVHVpc00weXhwUXBSRGtPRzVzZ3N6bDc5eWFweXRqRzdoQ2R4V1o5?=
 =?utf-8?B?VFQ3dnY3V1NkRTc4R1hmM2d1eTZocFYwS2pvcFluakJzZ2NseFR3Rk1ISndH?=
 =?utf-8?B?ck5nZEdZVytLME5mR1Z6UUwwaFRSSzNSOHphQmxsZ205OVhNN0htblpwZ3RS?=
 =?utf-8?B?U2tZQ1RuR3krdlQ3a3U4a1hjTnZRZFFNYUUrM0RjMlhFWWRUNW8zSFlIeFpG?=
 =?utf-8?B?VVQvYlpRd0pGRnRrazJYWmU2YklqUU11clVIVWdRSGpvV1paeURabGZQRlR1?=
 =?utf-8?B?Q0dFOTJ0M0JGU1ErbTJEMHJNQU9DWXgvd09jUnJwUlNSNTlWRm1WUVpwU1hU?=
 =?utf-8?B?UUlSUG5DaFdGelFRWGdnK3JJSEo2ZDh5eW5DbWpINDFiWDREMWJwbzhkWUFv?=
 =?utf-8?B?cWRvdGo1bEJTVm9JL0t0ZXhXVldPbVhwZE5BdVNjUEFMekRTN2NoZ3NaSk9P?=
 =?utf-8?B?QzcwWkExQ0dldGIzajB3RE1XRS9OMzZEek0xK01abTdiZEFaNWtRZGFrbWlV?=
 =?utf-8?Q?azaw7INhoYB8xwiyl0hhr4QVo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1a5dbb1-f8fa-4b15-89db-08dbb8492d15
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6095.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 13:14:23.3447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Z9wjNoF6APe7xK50nL6V8ymUMcSkTMLIwjyKhxhj06XBmJk7zQOlIGAl7DbsWkQdws8sCDlFc/DX8gG7wOx5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6038
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/18/2023 08:07, Mika Westerberg wrote:
> Hi Lukas,
> 
> On Mon, Sep 18, 2023 at 02:48:01PM +0200, Lukas Wunner wrote:
>> struct pci_dev contains two flags which govern whether the device may
>> suspend to D3cold:
>>
>> * no_d3cold provides an opt-out for drivers (e.g. if a device is known
>>    to not wake from D3cold)
>>
>> * d3cold_allowed provides an opt-out for user space (default is true,
>>    user space may set to false)
>>
>> Since commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend"),
>> the user space setting overwrites the driver setting.  Essentially user
>> space is trusted to know better than the driver whether D3cold is
>> working.
>>
>> That feels unsafe and wrong.  Assume that the change was introduced
>> inadvertently and do not overwrite no_d3cold when d3cold_allowed is
>> modified.  Instead, consider d3cold_allowed in addition to no_d3cold
>> when choosing a suspend state for the device.
>>
>> That way, user space may opt out of D3cold if the driver hasn't, but it
>> may no longer force an opt in if the driver has opted out.
> 
> Makes sense. I just wonder should the sysfs write fail from userspace
> perspective if the driver has opted out and userspace tries to force it?
> Or it does that already?

What's the history behind why userspace is allowed to opt a device out 
of D3cold in the first place?

It feels like it should have been a debugging only thing to me.
