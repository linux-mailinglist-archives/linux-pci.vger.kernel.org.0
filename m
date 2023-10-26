Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739E37D8736
	for <lists+linux-pci@lfdr.de>; Thu, 26 Oct 2023 19:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjJZRGW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Oct 2023 13:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjJZRGV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Oct 2023 13:06:21 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23DF91;
        Thu, 26 Oct 2023 10:06:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M1DLRhxq1rqhva+3yCIcByyVbsmjsvSgTk3x2suEH9LCr3aOCNXsuq78OOC2K1kKdTlkdAfLtw5IqR3v6EEmVhJn7gA1GUvqLtkgPiFn2BhULSG568qNkofM2O4p/iv6QjmwhtaJ9hNmhrh7Ys+ObUXwS57lyPsqWjlpFLIj1fdfAdqbuTrNg0LJKVQkfFu4ZgD7as+BnY0ssXbnskafVxzp7Xui76n6HdqZkUTmIyljNNdDtDs518b1exbrqhVAF1i/3hj4vsaGB4ynKsNlDh1umMiEeeYhk/s8f3Ix3VlWFmE7gzh123GwPzxA+9SThj5GAkrr8C94ErmV/gMrIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t4tnXTmg1/GulLAYcnFUERiY2GVgV+G8VEM2WEuoxZ8=;
 b=ZyqimstnhegGm/3EusXavEQj9BGAsjRng7jYVN+3+AixwY5gCGpjkwXgZPJRTDlPjl8W0ZIGdIp3hn1p6agp/ixXa6TXNUX+zfb/sE1oaePUCWPHikvvfudFpR7oOjd1XWjnE5tCOmp3uFtwVVZxDLbM0XLyrHZX0W2cWeXOKlzq7QZ99p7S8si+pNXVPf5mJiQHVK/NkvKKMx5nMxKFvgD6RMWZrTAFbrkAaurCBGx2Z72+o5QqK1tALPMgt12Hmw8t1tFrHv9KHf/14VXBC78dBb3D6PuYw408k8GuODBt9Y4I6FECzC10sQHCA1YdToKDLdLtxy7wrZiHmSBRLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4tnXTmg1/GulLAYcnFUERiY2GVgV+G8VEM2WEuoxZ8=;
 b=nrXiv/ndNPh22sKSHY8wx1gpRDcevc/fquPH1/PbCge2ukzeW0Ag1c34RYW/QK2u/jqWyiCn4+VeSnjC43VffK0CiVd7xHtsq+g90pZ7aohBNKO3lgnlHWtPg3QY8HTTCK1YMdSjYyrlb0hLF+ImcC2uKdQWVt4KgOs+r+5kH1U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Thu, 26 Oct
 2023 17:06:15 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%4]) with mapi id 15.20.6907.022; Thu, 26 Oct 2023
 17:06:15 +0000
Message-ID: <b992caec-68f9-4ad0-afe3-99f83d73232d@amd.com>
Date:   Thu, 26 Oct 2023 12:06:13 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Add support for drivers to decide bridge D3 policy
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
References: <20231025020546.504-1-mario.limonciello@amd.com>
 <5735975.DvuYhMxLoT@kreacher>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <5735975.DvuYhMxLoT@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR21CA0028.namprd21.prod.outlook.com
 (2603:10b6:5:174::38) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|LV3PR12MB9404:EE_
X-MS-Office365-Filtering-Correlation-Id: f1aeef79-6089-4395-d386-08dbd645dd46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 72NL4YOgVWbsLk/xaJLiOfkzqwq8vyJRduLrkmssjPlqBIBVOgJBw/He9XJiWbByU8ibKMIb1i+quNW1BlD297sdx16Jy+OLxwMyiTz0iF3tqw33lSDEe7VkAMJ9XzVbF/clbOfRWfUiD49Sl32XeZCgPTfxvKVVJ0+VSVzxzT67aNogJw0b5zKBe6OHOo6B8Mc/ukZ+IvLvpIuqkgpKSYHouQRnF/6uhHxAFjxWP5YQd6mczi6jyHC11ASk6Ee8uIJuQgMThbnOZaXWDxSYPE7we3q9F2nyGxE0HekzohGOli5LVARylqhtEk+kboaotrtt6KFDNeyOpiZf6Rml4bNKywN8L88p6zYBftJhNMOLxjrWcbmg+XfPVKtSCR3Teoatp49DuZmJzO1tQgdku+eLjf9qu9tbkmbICExGQDrnvwCCu6gMLxNNBKR0BecQPZa9wg18X1lYftFchzHxXanO9FEPjB5IG4L7JL8ka1taku7to4bLS6lfoooGZWfTj3CQfyqu1nfnmPWJ9ukbDcGB8MFT4JirGbZlpG6dd0s1Tkopsjz0qLvLFK8ciaRcGOmr2Dptwg6sWVMxSed0Q9goe32klGm2ZImehSS5YTkyP7NJqDv9r4LJPEykyd+IYBDQu9pjBRz1xnnKBh4vCi4zza3+bUiP8H3fWHn5p9UEgtq2etUtVV5gw7ovIv9K
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(376002)(366004)(396003)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(2906002)(38100700002)(5660300002)(83380400001)(44832011)(41300700001)(31686004)(26005)(4326008)(2616005)(8676002)(8936002)(6512007)(316002)(966005)(54906003)(66556008)(66476007)(6486002)(66946007)(53546011)(86362001)(478600001)(36756003)(110136005)(6506007)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R00zNW90cmQyemZWcU9PZm1UdVNUNGhoUlNzYWFNaDRjZDR3NDJ3SnFkbFlR?=
 =?utf-8?B?bk9UN2grenZuM2FSU0RnbWpPa3REMEdrZFNidGVjMVZwMDNOcExmNlYxV25m?=
 =?utf-8?B?NXVSYkwwS2o1QlhUTlFkOWk1TFdaNUFmQ1pCNVdROHZieGJFT1RHcllrQ0VY?=
 =?utf-8?B?RlVFQkZ0MWROSnF1aFZaUDh6d3k2NWZBVk8rTUxUK3A4YXBmUlduWUpVT01C?=
 =?utf-8?B?dEhGNlRBajRPdVVYbWMwQ3BNdytRWDQzVm9xMjBzYXZSRWI1Y0JvcWFRN0VJ?=
 =?utf-8?B?T2hzT3lHWlZRY1J5YTBxSCtjNnZwZ2E2UWxnbWhYRjVSVlhYa09UUHVENGhQ?=
 =?utf-8?B?cHRKV1F1WkVONGFTQXk2Y0hNM0lSVlNaQ0xwNTZ5QklWVUNUNThRUG5mbU5H?=
 =?utf-8?B?NEZWUlFPaFRYTlJybUpJN2NPVFMwakRUR21yeHArQXRoRjhxRWJydW14dFBr?=
 =?utf-8?B?UHFnN21HeEN5MGlBZFUzQ1NsWkF4NHA4MDhEb240Mkl1S3ZiMk91TTdHSStW?=
 =?utf-8?B?VjJVODVrTk1NakRmeHpMOGg4am9jelU0TXUydXFEbk01U3h5YWhMS0dRN1hZ?=
 =?utf-8?B?emNndmFQVytaQ2tVZnIwWkk4bE0waXRDRXRlTzFnczYwS05jQWhhbmlaNURS?=
 =?utf-8?B?YnNoNGpmcnBoZjJWeG1RMndnL0llWTRiRjFWSFZyOVBDNkV1NnBqZ0ZoMVUz?=
 =?utf-8?B?blkzYzdmSGRXbXZzRWhSeHJBZnVzQjZKT2pFRkUxMWRjSi9WdlBXMS9YRmt4?=
 =?utf-8?B?dDd4bW1pMFdvTWlCVmtXY3QwV3h0TVpVVXRoZS95L0VZSU1CcHpybmx2S0hY?=
 =?utf-8?B?cTBUUHNmRzNqRzNOcU50bDN4aTBBeGl2K3dTd05TM0hlU0JCQ1VadHhiSmd0?=
 =?utf-8?B?WTlyelBSUk5hZTVBY29xTnJFb3dZWkFzZU43aGVpb3BDeXpUTVlXcy9Fa0RN?=
 =?utf-8?B?bDFnQThKRVdFZjZlVC9SbHRnankyR1pGakQ1aVVaalk5MkJCTXp1dHZqN0VJ?=
 =?utf-8?B?QWUyWDhEZ0FIMVhIb0N5STYvVW9ldjF2aVEwSkVQdVZJb25HTytZbjQveHlS?=
 =?utf-8?B?anVwODFqUER5VldWVkJ5Q0J0THV5dHduSng2U29rK29LWld2bEpwNjIzR3Vu?=
 =?utf-8?B?REFSRXQ5ZjRieGVMSFA5dklBTjdFc29tdWdsWWNLYmlxTzRWL2paR3VQNkNo?=
 =?utf-8?B?Z0lKS012MWNzUUJvNEE4Z09vTGttYVlpQVFIMVVRSTJFbWJ1VDBwc0w2N25T?=
 =?utf-8?B?dk5YL3ZKMjNnSm1kcjJVMVZ6NWVRd3JOa3NxNGJCeGhlV3BkbjRsbVgzSEt0?=
 =?utf-8?B?ZlNFY3huUEdGdTdCbzd4amlOYlVHcTllMHRYcUUvKzVheHJ3WmNtcW93Ynlw?=
 =?utf-8?B?M3dSYnVWNHNEMXBuU0NTRnE1Z1pWeFpNS1BFWnNMQjMvQkhPR2Uvem5YSmJB?=
 =?utf-8?B?TTJOd2pYcFFpbHNGSWVaMFNFVWVlb041ZDVkZmJ2eHNaZDNWbFlXZld0SWZ1?=
 =?utf-8?B?RVNZQVVMSDBDK09pRnEzRzM1Z3QvTDVnb0didTFNNUQzQktWTkNUQTlKbWxD?=
 =?utf-8?B?c0hrcTVDTkJvS3p3K1ZmZS9iMy9vQmJIbnlQQ1h6NUVzbSs3bkRLK0NRdVFN?=
 =?utf-8?B?K09YUXFOaldxdEZRNWJrNGtVVVFkTGdlZ0tYb1V4ekgyQ3V5MkN4eHh0dkxR?=
 =?utf-8?B?QmNkUExrcmVQd3pjMXBVb050V3drbWZqeVdqZXBrUVlDOCtZUVMrbFQweDJh?=
 =?utf-8?B?bjFUZ2RQQWRiU1duSWl4VlQvcHRpMk5ZWE1BK3gwaXZIb3dqVTBweWd3NFBo?=
 =?utf-8?B?YUNqZGI5U1krMjJ4Qlk1NzFCQmtiU24rY3MydEpuU1ZtMFZhdWtvTktqRUt4?=
 =?utf-8?B?Vlc5Y0tUQldhcVB3cW9rb3JVV0llNmRyQVFYWlNmN0d5L2pwcFdad05EcGdM?=
 =?utf-8?B?a3BWdHFjekcvN3dYVCtQNTZjN3R3SFZMNjZjSTdFVHgvTnRvZ2ZQOUVlUWpL?=
 =?utf-8?B?OUQ1bXBzMmxEV01WMi9QSmRUM1VwQTQwTk5pSVVjSUhmUEtoRDhCdTRHcW1P?=
 =?utf-8?B?S2dzYlR4L3EwOHRmVndjZzQwRkxReGFZRDR5TmdmMDFDUnNkSUE2Ujk4dlM1?=
 =?utf-8?Q?guBwDFpTLS3gmjvcq0SRRH8ZE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1aeef79-6089-4395-d386-08dbd645dd46
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 17:06:15.7872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m4ZvrUmdC/e+MYm57skTmunoTivu+7aa1nHdZKkhD6nk4M58Utx9/dff7onivzJXbig5tIBdewG3W+gdpBkigQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9404
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/26/2023 12:04, Rafael J. Wysocki wrote:
> On Wednesday, October 25, 2023 4:05:42 AM CEST Mario Limonciello wrote:
>> The policy for whether PCI bridges are allowed to select D3 is dictated
>> by empirical results that are enumerated into pci_bridge_d3_possible().
>>
>> In Windows this behaves differently in that Windows internal policy is
>> not used for devices when a power engine plugin driver provided by the
>> SOC vendor is installed.  This driver is used to decide the policy in
>> those cases.
>>
>> This series implements a system that lets drivers register such a policy
>> control as well. It isn't activated for any SOCs by default.
>>
>> This is heavily leveraged from the work in [1]
>>
>> [1] https://lore.kernel.org/platform-driver-x86/20230906184354.45846-1-mario.limonciello@amd.com/
>>
>> RFC v1->PATCH v1
>>   * Simplify the logic, use pci_d3cold_enable()/pci_d3cold_disable() functions
>>   * Roll https://lore.kernel.org/linux-pci/20231004144731.158342-1-mario.limonciello@amd.com/ into series
>>   * Updates for some typos
>>   * Re-order series.  Patches 1 and 2 can potentially apply to PCI tree, 3 and 4 to platform-x86 tree.
>>
>> Mario Limonciello (4):
>>    PCI: Make d3cold_allowed sysfs attribute read only
>>    PCI: Refresh root ports in pci_bridge_d3_update()
>>    ACPI: x86: s2idle: Export symbol for fetching constraints for module
>>      use
>>    platform/x86/amd: pmc: Add support for using constraints to decide D3
>>      policy
>>
>>   Documentation/ABI/testing/sysfs-bus-pci |  4 +-
>>   drivers/acpi/x86/s2idle.c               |  1 +
>>   drivers/pci/pci-acpi.c                  |  2 +-
>>   drivers/pci/pci-sysfs.c                 | 14 +-----
>>   drivers/pci/pci.c                       | 12 ++++--
>>   drivers/platform/x86/amd/pmc/pmc.c      | 57 +++++++++++++++++++++++++
>>   include/linux/pci.h                     |  1 -
>>   7 files changed, 72 insertions(+), 19 deletions(-)
> 
> Any chance to CC this series to linux-pm and linux-acpi?
> 
> 
> 
> 

Sure if it needs to spin again I'll send it to those lists as well.

Here's a lore link for you for now though if you want to respond to the 
other patches.

https://lore.kernel.org/platform-driver-x86/0cd6648d-21f1-445d-95f6-20f580bbcfd1@amd.com/T/
