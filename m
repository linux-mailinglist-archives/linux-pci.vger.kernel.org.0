Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5974B478BA2
	for <lists+linux-pci@lfdr.de>; Fri, 17 Dec 2021 13:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236409AbhLQMqC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Dec 2021 07:46:02 -0500
Received: from mail-dm6nam10on2082.outbound.protection.outlook.com ([40.107.93.82]:34657
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236407AbhLQMqB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 17 Dec 2021 07:46:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bPucTfzaUbGzWPmHOR3iT4wLL7nooCpn7ULr2jxK97MdjYfp1RomOxSQV0fi0mW9upYxX2NKJttI5DcvxzP3Ybwgn46p3Es4Sicmce4aKCrZ+rbx1pmnkJskKGZjxnSKh56EGpwYA4FKKGLgRmYKI9Dt104YheuZd5MQOjSphh0HQ8kNBtkRQRxE8WIyeb79hefv1aMuyPXR7VF4zdmUhxRlDwGYuYOb19S+lI7nAbEUPn4zVcM1ZIxdY6BT7/rix2reujuMwxPaHiUVnUA2JUhaTkev1Ep5BNdfMW4GEMBAkj9EdNdjTlZAR0L6z2k3AKoaLbaLydQzGL4E3H5dZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v4RmMdDPzi3jUhuVl8RVG6sivpJkq1d9Zc5I0/laCio=;
 b=JOWG54oZtTjw8b5wnVn6wSIV6Fa/gOP6yWMuEC2/9aKGmtPUm/HIOM8mQ6H97B7JJWBnLzOw2mC9sd6NIcd/LTRJwzsZRpk2i/ayh7AH1ecYPc/ZN81YLOPfil+gBkuWiVdIeIOAOHBQtZCrxnCNaPkWEqIJPGg3AHVTdnt9ZPQc1ES+aibE7n/gN+zLkklIx09ZKu3u+TkcT0w0j+mcf1bPi0/yjuBUgubTUolOH7GnAf+pChQXJ8H6UgmrHOC2sIoxjTZ+7bGXvF/fkfiXrP7FJWlYFOMVqKbbVvLa7h4qrG6ZHCiyOd5RMjGScxeouZEi0A7DLDePlGU/sJnYag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4RmMdDPzi3jUhuVl8RVG6sivpJkq1d9Zc5I0/laCio=;
 b=04OxLI5cSCpsPoIlgilPJmLKHkO2dV+YNQUS23YCn3H7IrrK3BmWKwZDjfL4A8ux3sUsHfAHEMTzKpDkd9sUnHjyGu6vdJcWj+dYmcIAxIJfTuZXe/mcwvFmRNGemHwqa+m4Znj9ZnUCTnr1jlML69Cdm4muOFe+aD1bpd3fSRQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com (10.174.101.14) by
 MW2PR12MB2554.namprd12.prod.outlook.com (52.132.177.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.13; Fri, 17 Dec 2021 12:45:56 +0000
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::d16c:a6d5:5d2e:f9d4]) by MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::d16c:a6d5:5d2e:f9d4%12]) with mapi id 15.20.4801.017; Fri, 17 Dec
 2021 12:45:55 +0000
Subject: Re: [PATCH 2/2] PCI: Don't fail BAR resize if nothing is reassigned
To:     =?UTF-8?Q?Micha=c5=82_Winiarski?= <michal.winiarski@intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        "Michael J . Ruhl" <michael.j.ruhl@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
References: <20211215141626.3090807-1-michal.winiarski@intel.com>
 <20211215141626.3090807-3-michal.winiarski@intel.com>
 <60ff4820-5dd9-bb3b-9baa-55ac53c0646c@amd.com>
 <7a82ddb8-5cb9-aeb8-df20-9f0e2c6fccaa@intel.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <cecdf77a-4588-e625-90c5-c4f4b937b184@amd.com>
Date:   Fri, 17 Dec 2021 13:45:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <7a82ddb8-5cb9-aeb8-df20-9f0e2c6fccaa@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AS9PR06CA0096.eurprd06.prod.outlook.com
 (2603:10a6:20b:465::25) To MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4fdc090-c204-4ddf-6b35-08d9c15b2ab1
X-MS-TrafficTypeDiagnostic: MW2PR12MB2554:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB2554132090BC14938516BB8983789@MW2PR12MB2554.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 85QxfopfeEu2hinkvdTtwIca2nfQ/nIji68YHBp963MoI4sEmZSS9RIvJX6hcQZ58K/arq7NuRtzwL2g9LKLn5eCc+FJcI51JOdFLkWrzJB29jOH8BSnn7Rev8XcmZMlhpH8jgPLa0AczF5Sodx4VcJGSem0O/79TXVQ+9XyUZTTBa9X15MqjhD5Y3FC6lNnm2aBm5+bnfPptYk90vOHGnEOJnsk14QfWDEsITvbLJM9HUDUlSahpVHwsqG4hJxToNSLFbK9xDDrfIkIQknZlOLB560Sawa9sueSkBe8+YGNFYyoNz9QYOoXuikl8HgMcvxOulCwgYtK7C6dEHlVWCChjLku8cpYIbRBGrS/s34jjWVrC/cpNrNMHmaYO5FvtMs86TMtREhDqibsNj7/bw0dxZ+aSpSJ7d6W9PIl7b7Y/teuBSn+KbmbRsuVXNMJeFz/acXjtj29D5viWkIfhboRRrqFgKIYJ6ms/5ySJrRtH07XsrqyY26/2AN3FN4J6rvh+KE/yA4WhJBtmMMO9a6pxcHXN8Nxa+1pJujmf/h2/051vDyA0ycsNMYvsVH/kIJgd3kQeA5AO3WuqeAXgSGJbGshP+gsUKzR0cyE5awEDytH3K329wrNnopt6/KrO2re4MWD8aMsiiu1AthukR1cCvoqc/fTXbNfiUZxUajMZMH4TWtyXW8198glDN+QvtA/DmbRNCFzlRZKnEV6S+9PiJzlQnsqnnN0TOK4Tag=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1201MB0192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(5660300002)(186003)(31696002)(38100700002)(36756003)(66946007)(6486002)(2616005)(66556008)(66476007)(4326008)(316002)(8936002)(6666004)(66574015)(86362001)(83380400001)(110136005)(31686004)(54906003)(6512007)(53546011)(8676002)(6506007)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3JrcXFtR1V1T0FzUVdaTmdOWjBNQmZZQk1Za1A5bGRTRjFzR25haVN6SUFu?=
 =?utf-8?B?aDREQ25Xbm5mTDV6a3huWmJLcXcvTko3SGVPS1FIREVZdEZFYmVaNjNNbFM2?=
 =?utf-8?B?UjJaTmpqYWdIa0lxQWl5d2N6R1ZmbTBuOC9wV251ZmNta3BBV3FqNnNxYlYv?=
 =?utf-8?B?Q3RFWHpnS0xRNU8rWDJZMk1GeFFCdGdtRHo2aGZVdGc5cVBXaHlTY05VdVRw?=
 =?utf-8?B?bjJmaDRIZ1NtL2lCcmpMaDlsWXEyYkpnQXp0U3hnSUpZVkJhM3o2NjdSNGU0?=
 =?utf-8?B?MlhhbTNTZGpObWFwVjIvOVY4by9KbTZkbS9lUXBkTDk2QmszWEN2R1VqMmlU?=
 =?utf-8?B?OTc2bldTWkNXN056WiszbDVpaEg4eUNiU2p2TFZvelBZR01YT1NyVHdNMU91?=
 =?utf-8?B?TG9QNnlHL0NmWVNUZS9uelUycmd6bzJoMlFNUXN2WmNEV1NoWG1wZ2E5czNh?=
 =?utf-8?B?UmVnOTFEWkJkaHQvZE5yMGpwRFgxNGRKeXJMeEU4RjFYL2xCWml1Y2s1WnJR?=
 =?utf-8?B?eEJiL05FZitKeTlxUDN1VjlNT0hWMkZ2L3NVeHZwZlVTWjBZWnpQZW5BcGZ1?=
 =?utf-8?B?ekVvU1Fwa05qTUhqMDVCVzl2cGd4Z1h6c1JYMGVRUUtzMjhHTW43ZUovcVVa?=
 =?utf-8?B?YWdTQWdkUUZrdXFhV1I0a05kRHRENzZoSTk3WnVqUVJIL05haGw3L2xqOG1u?=
 =?utf-8?B?L0pEcEZvaXN0RUlpNEZ0alN2TndqeTlFOHJ5cDdXcHdpRmg2Uk9vZnlNK3No?=
 =?utf-8?B?TjRxRDl3UG1HMHpQMlVPM3RjZFZxWllyOXIyYjdMSVI4b2hDUDFlY1lwV0lF?=
 =?utf-8?B?ZWcwMzdwNW4xakFzTy8veFo0eEU3TWVLRjd4MStCdk1OYUhCMXJ2L1JzN2tB?=
 =?utf-8?B?NlBZbXRqTzBJM0JyQWx1NEJkeUloNVFocnUvWTdjOExteHNRUXp1MENuQmpq?=
 =?utf-8?B?ZXprSllxZHlmVU54UHo0UFJBSG1GSWxyRks1R2U2M3ZRckNIQW45QlJkUVZk?=
 =?utf-8?B?MkV2RDBGVS9uQnd4M08zME5JMG9aYjIwdSswUU90Tk05cHdpKzlEUFpobWdt?=
 =?utf-8?B?bDRuT3QwRXhIU1N3Uzk1LzNpTzdCMWEyV3B3dWpsU2NCMmR0THdjOFNVek9U?=
 =?utf-8?B?V2VacWQ4MXI3UU9iSFZpWU50bWlLRkdHVjROSW5HV2UwdGtuZWRhYlJydWkx?=
 =?utf-8?B?UWhiK2sxdXFFS3BYRXRUUU5OalRRWUErOXA5b1pCQmhSSnczcENxY3l3ZW9i?=
 =?utf-8?B?NkNUblY5WXJ4SzhRNlUzbG41UFFFMys3ZWg5cnlDeWFtMjdsVy8xWmkxSHBY?=
 =?utf-8?B?VUpvdmFJYXJkaExFSlJBTmhUdEcrQlR1TTZSaVB3eEhJcjFZc29tS0FNRkFr?=
 =?utf-8?B?YWREMkIzMzkxaFpvdGNGNnBHQWVxQWN4NkMrRmR3cWxQNmFKcmVFMkJKRitN?=
 =?utf-8?B?a0t5SGM3WEpmUDE5THNmVm1JRXc4N0xkTlNmWkh4ZDZYQ0NYRDZtMXg3cHN1?=
 =?utf-8?B?SEJ2VnR1VlRiR0FOWHJrd3RhM0RMVS85VWVucm84VVpyK2U4MXpBaUlKd0ZN?=
 =?utf-8?B?R1pkRDZKK1RlY0VmZjhyOXVFaDVpbzZFdjFodkJVbTRqVE92YVRlSWcvdE9m?=
 =?utf-8?B?QWVXSFJzZDREbHAzUEkwVkdnYVBySy9hbWhQTU1OREFIZ2J2aFNTb1huRUZI?=
 =?utf-8?B?aVZzTDVoZENQWlZtVzg2MEFObGtHTzNnbFFMR2hhSk9kdmF2YU9rbExWc3JE?=
 =?utf-8?B?Ny9KaTQvL1NHUzBjaVd0TDRoYnM3d29uWklqV3dQVUY2dnEvR28ybkt1dUwz?=
 =?utf-8?B?ZzhrVnZNU09RR1RCZnNKNnlyVEdxT0lWbml0VTZCVk9xam84Z0ZLYnM3WEIx?=
 =?utf-8?B?UnVhS1pLVVRZL0xMWHdqdkdaU05XMjlDRVUwcEQ3d2RKRndUaDVFWmtnWWIz?=
 =?utf-8?B?QWhTc2xncVVnMzZTSmRXSG9qaGRHWDJla2djcmoya0Nhd2VJa2R2bkVtN1Jw?=
 =?utf-8?B?RDZHekxQcnp2T1ZvbDU2M0V1Y0VVYk9QTzVEMHArOTZPRERRTUN1bGQ0K0Nl?=
 =?utf-8?B?ZXlsUmd1V0oya3lPRXNJTDNlMmlsYlV6SDVoeFc4bW15YVkySHRFSmNZdVhU?=
 =?utf-8?B?Z2REQk1jVmp1NS80QTRXaitsa1h0eXFpN1JRS3I0NnhUQ1RhYW5ZQys2STdB?=
 =?utf-8?Q?XjT799fpdOpU3kMXCbRemAo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4fdc090-c204-4ddf-6b35-08d9c15b2ab1
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB0192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 12:45:55.4709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wBaIXF/EpOfzAYjy+7W1jRLnjM+o89dBCVqsg6MI4nBPEXKPk9O7jrn+8cn+7cZe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2554
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 17.12.21 um 12:23 schrieb Michał Winiarski:
> On 16.12.2021 08:12, Christian König wrote:
>> Am 15.12.21 um 15:16 schrieb Michał Winiarski:
>>> When pci_reassign_bridge_resources returns -ENOENT, it means that no
>>> resources needed to be "moved". This can happen when the resource was
>>> resized to be smaller, and it's completely fine - there's no need to 
>>> treat
>>> this as an error and go back to the original BAR size.
>>
>> Well that doesn't make much sense as far as I can see.
>>
>> Drivers mandatory need to call pci_release_resource() on all 
>> resources which might need to move for a resize, including the one 
>> which is about to be resized.
>
> Since IOV BARs have their own memory-decoding enabled bit, which is 
> usually tied to the lifetime of virtual functions, the PF driver could 
> do IOV BAR resize during its lifetime (without releasing its own 
> resources).

I know, but that is totally irrelevant. See below.

>> When you get -ENOENT from pci_reassign_bridge_resources() it just 
>> means that the function was not able to do it's work because the 
>> driver failed to release it's resources before the resize.
>>
>> Technically we could indeed skip this step if the new size is smaller 
>> than the old size, but then the question is why would somebody resize 
>> in the first place? The freed up address space is not usable if you 
>> don't do this.
>
> With regular BAR, the size of MMIO resource is equal to bar_size.
> With IOV BAR, the size of MMIO resource is equal to iov_bar_size * 
> total_vfs.
>
> It means that the driver could use the pci_resize_resource in two 
> ways, it could just call it like for the native BAR - overall MMIO 
> resource is going to grow, or it could limit its total_vfs (overall 
> MMIO resource is going to shrink, but from VF perspective, its 
> individual BAR is going to be larger).
> [SNIP]

> No changes in resource size, we started with 4G and we end up with 4G 
> after resize (but those 2 VFs can now use 2G BAR).
>
> Does that make sense?

Well no, I already had a good understanding of what you are doing here. 
But that still doesn't really fit what the function is supposed to be doing.

See even when you reduce the number of virtual functions and increase 
the BAR of the remaining functions you previously *must* manually 
release some of the BARs. And even if it's just the VF BAR.

So there is either something wrong in your driver code using this or we 
have an implementation error in the handling of VF BARs in the resize 
function (which is certainly possible).

Regards,
Christian.

>
> Thanks
> -Michał
>
>>
>> Regards,
>> Christian.
>>
>>>
>>> Signed-off-by: Michał Winiarski <michal.winiarski@intel.com>
>>> ---
>>>   drivers/pci/setup-res.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
>>> index 1946e52e7678a..5de5129055e0a 100644
>>> --- a/drivers/pci/setup-res.c
>>> +++ b/drivers/pci/setup-res.c
>>> @@ -484,7 +484,7 @@ int pci_resize_resource(struct pci_dev *dev, int 
>>> resno, int size)
>>>       /* Check if the new config works by trying to assign 
>>> everything. */
>>>       if (dev->bus->self) {
>>>           ret = pci_reassign_bridge_resources(dev->bus->self, 
>>> res->flags);
>>> -        if (ret)
>>> +        if (ret && ret != -ENOENT)
>>>               goto error_resize;
>>>       }
>>>       return 0;
>>
>

