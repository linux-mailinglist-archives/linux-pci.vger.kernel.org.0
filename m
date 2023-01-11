Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8232B665DC7
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jan 2023 15:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239334AbjAKOZj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Jan 2023 09:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239354AbjAKOY4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Jan 2023 09:24:56 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED701A202
        for <linux-pci@vger.kernel.org>; Wed, 11 Jan 2023 06:24:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CG++iB4ZpNh7CGmTB7pBI0eTVAKG0tIbjX3f3DomgzDWP9GEeVf9sK7+L9hG8UNax5HlPT5Wzl1Ayy0knKUMOUAe4o33DL9VdBngwxccEdvtjxqXO/FcXpm3IzSg9+poLir/qLLmInFT1b0YRgMRBtnAlpZJMJD0wqaG7Vymk+b7sWl2xgzjfPvK4H43fZ2csEHPiG+enUUrzd2WnWdEHVgLLGs/oIGoAwG6yELdUhAjsM2FSs0PzV2qyXrlGdV5l33rVQjgNsIcQ1p/Ahmq16+lVrSEElCZwO9LkQ3vyClsetH3S74spw84r9rNvX7kkGEK+P+21vRSjgMkwj5SMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fESHjcs4caVF2apVXfh8oORoplwtmKrohAJnVP18tFc=;
 b=lIxmTeRdWMo3T/cb4j5zVWgtm0kOC5rlvyeiIMvHwH9WkoXcia/RcXL7v1Jdq6/+jVZTux516fpb5knDyW4mndAjckKXAfOk21xNN71jkB6xHYx/cxF2wqRAZpaiLeC0QKMCw7NlqfwwQSCpR7mcX6hWMfSksogW3HB1G3iFOEQcMkkyomQNPP90JJoNk1DXAS1lxdl+VB4AaPpGuDvh2PM/l+QhhW2NZNB0ckvQCA9QBOk1WCHb9NItwNzznAXT+YE2KbVVPeA7CaJY0wwNIPzsvkFnuBAqiCkH9V/+2hvDOOWjPbqzvzrSDc/Ezks88FGyqwa5sncJXZTkHB6yJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fESHjcs4caVF2apVXfh8oORoplwtmKrohAJnVP18tFc=;
 b=tuS8zbZMy5+6NliM3Q9V1KuNM0nEYRMhxny8A5jgqu+epT+Jo4+izhm7vfgA6udb+Nd1/z/qDTxg1GgTluZndIfxcKKKSZA6nyTYo4pSENIG8EJniNb74+uF+srG7Y7UKFEDoG3K4B5Ph8+qPLaclBJDJw9Yi7ajJQ31MN6RwgQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DS7PR12MB5934.namprd12.prod.outlook.com (2603:10b6:8:7d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Wed, 11 Jan
 2023 14:24:53 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::80d8:934f:caa7:67b0]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::80d8:934f:caa7:67b0%3]) with mapi id 15.20.5986.018; Wed, 11 Jan 2023
 14:24:53 +0000
Message-ID: <6b0f54c0-4ee6-124c-fed8-307b434a86a9@amd.com>
Date:   Wed, 11 Jan 2023 15:24:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] PCI: revert "Enable PASID only when ACS RR & UF enabled
 on upstream path"
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Baolu Lu <baolu.lu@linux.intel.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
        linux-pci@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Tony Zhu <tony.zhu@intel.com>, Joerg Roedel <jroedel@suse.de>
References: <20230111085745.401710-1-christian.koenig@amd.com>
 <Y760hRDQbXRlc2Yz@nvidia.com> <0da0f213-5d6a-c692-b9f7-9babb40adc96@amd.com>
 <Y769WqrbEUPQ3pt7@nvidia.com>
 <38a7baf4-9b3b-154b-f764-fa8cfa600858@linux.intel.com>
 <Y77ETB282pVL9/x6@nvidia.com> <8c33f83b-3b8c-4714-b812-1e0627fd5537@amd.com>
 <Y77FuaSI8AV/i2cW@nvidia.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <Y77FuaSI8AV/i2cW@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FRYP281CA0008.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::18)
 To BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|DS7PR12MB5934:EE_
X-MS-Office365-Filtering-Correlation-Id: 54c04275-4c3b-44f8-aa61-08daf3df9b41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zXTQfNIQaipIy0Yy1RNyRXTocDHoMPM/yehv3vI5VJOM5RQdSeLqNmJWercxv/8jwBLI7ofM6oKwntoDf7KHsK4kj6LPjNaFCPleY6wQ92UO+9W4uotBBblwyVtJeqrGdjieD5dchnMpkh4sBWEahnP4KKBA2q7s5M3cBK0PeTWpIERZYIncKwNyKIeeP3jgFp2myIjw3NA8pEDS51j40O9dMa8QxVelAnJGjQ0SUY/vKDSXr6Eq/TdsChcUPz7pvjZ0yejUngsCVPovDHPG/QcevOm450xbiDaLM10pG0GHm7vOu8POvQi886LZh/Rsh9+AjNx0iZLBKLTWxiCbE3yzc9L9Wmn2zWl8IGyLHoesXeIouldGjkfF+AyRlNUNWExRa1OJVePesKjH+CO2zuiSgW31IPKwVu8AsQpV2vPyxQlldldgVi9vl7KoPfxjYg5/JeVXFbip8nA2Ctn7ZDyz+Xk4LrI8ZtBS7O6sZea7lZ4Ye4uYK1RtTCoJBWmRKN8KaL+Lrt/OQwj9voWtOsLJ27V0rHTDvsEzWW2hBCOF+1NKePkYJOwSEIabWXmV355PaSN6q8Z7/aB/MS+sqPiiuSUAmxBqhuTCviWUhdycsmVCX+6y21+ji+7RQnbBY+J2KLOUmJctAGRa58kRopEpq1qAZxIyKApKlxsxfHwdWAZyciagmjrG+ye9fdTVgKgxjF0O5iMpRAEHTamgxmYRR4lTAJ1Wh86ThlYNL6g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3587.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(396003)(136003)(376002)(366004)(451199015)(6666004)(6506007)(2906002)(36756003)(8676002)(4326008)(6916009)(53546011)(5660300002)(8936002)(31686004)(38100700002)(6512007)(66574015)(41300700001)(6486002)(478600001)(66476007)(66946007)(66556008)(186003)(86362001)(31696002)(2616005)(54906003)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFVrNTREMEhvMkV0N21EVE9veFZObjBURTh2a21pOWVKU2k2dzZsY2hRTVR1?=
 =?utf-8?B?YmJUOHRqbE1VZ1hrbW5KUG8zMGRMbWFwNFh2UmJXSmJ3azQ3cUgyNTlwVmJI?=
 =?utf-8?B?RTB0RE5NdmVMaVBtQis5eHZmTDd0aHNkOG5OVHFwQkF6VU9FMlhoZnlLT25u?=
 =?utf-8?B?bHM0SWIyeDZ3a3pZQnBrWWpOb0o4QThTQzVRRkVEbENyelhKdzF2UzhEcFAv?=
 =?utf-8?B?eDNTL0l1K0VFSHhFSW9Uc1ZVaGw5SjNkVlZEMFVuZG1YUTJUL1FjckkyRFpM?=
 =?utf-8?B?bEhhY2wwUUZQTXo3M2FadGg2VEdpdXJ2dGQxZDQ3eTdvNW1tSDdHQ2crT3dW?=
 =?utf-8?B?ZGxCMllWWEZsMDNIZGZIUFZlMno3RmJiNjdZdDFwSGdHUThmTlUrTnppMnZR?=
 =?utf-8?B?UmdTWlkvK3pRc25YejF2WDFDWGw3N1QrZzRxdG9jWk83WE1LdFpmdWsxT245?=
 =?utf-8?B?UVNYQ2p2L2ZaTkhWZnNRRlZadGc3Tk5uQUl0dFh4R3lsaFJpanl4d2VkbWJr?=
 =?utf-8?B?YVJpT1Y5SkZVeEVqd2RxVlRWUmZGalg2a3U3WlMxZVlScDU5ay90Tm8vTGpE?=
 =?utf-8?B?ck9IUGF4cWwzTVhXRkV4dnJiMDJWc003YmcwMytFdWUyd2NPQnJyUG5pRjE1?=
 =?utf-8?B?MGg2Sk1yc3FTMjQyYkxhQzNkem82amwrdEhIMlpDUWExMjNyK0tGbXdXOGVC?=
 =?utf-8?B?ZmpFQ3BZa0JPVXVmWXdPTXViN2RqV2VBdGpnWlZHMXgxakVRbEFPSnB4NWZy?=
 =?utf-8?B?RStqcElOSk5VUldsREpmNldCVW5NTUpYWjltOHpyS0I5MjVxelV1T0NteGtS?=
 =?utf-8?B?ZWlyU0h0RWROODlYSUtZRUgvdXVPajdJQzdRS2tzZ0hQWVZ0dXNFd2tOTFZW?=
 =?utf-8?B?RDh0NjNPV093UWV5czdxcXJVMXRGOFREWHpieFo0aHh5K0VkWkxtSWF2NE9F?=
 =?utf-8?B?WHphVEVqbkhCQTFGaGdoK2pyV0tNeTRZREYyeVp5T0dMWWhLUXphOFZxT1BC?=
 =?utf-8?B?WlB5MlR1T09WR1grd29PVXVVSGljUE8rbjVTSkZKUHRhdkJKOVc5UTBXSmlC?=
 =?utf-8?B?eG9qY1ZnY2t1aUNaaEVKNEVkR3FtWThRZlkxdEpTRmU2bzBvQWFNakxkTFNH?=
 =?utf-8?B?SlI0Z1FiclN5R2cya21XZmcrRU94NHBnRTVqM0ZqdVk4OUpReU5ISHlJcVJG?=
 =?utf-8?B?T2hncVQ5SURpcHNlYnJpZ0dsd0hqUGJjQnRBZVNiZHl2M2g4YkNES0hvTmV3?=
 =?utf-8?B?ZVhtMWhIeVE3U2hwaUtBblRtWXcxZ25KK2JuSFBnV2dKWG1GeThRcWZHaEo0?=
 =?utf-8?B?bEVjMmtjRmYrWXRKQVZBdVAyc2t4TXpERVJpV2xrc25ndmlacExBOGp3M3Q3?=
 =?utf-8?B?dDV5ZzZUYTlabk01TVBRRmhuN3ArL2x6ZmkzMW52bHp0V0JxNHdpREVrVVZC?=
 =?utf-8?B?QVMrTG00MG5ITlRFQllJT0ZxQlIwOE41akExZEVDcFJPUzJFa0NvMDZrSFpF?=
 =?utf-8?B?MUJTTFhUZUlVczdJS2ZSbFJJQ3g3eFJ5Vkp6TEFoSVpaU1BRUGZDdHpTNDJz?=
 =?utf-8?B?bUhLVHFsMUFmWkxtK2J4VXI4aUEvZVMydGtTa2xLYlhHVDliSDBuR1dhRDJ2?=
 =?utf-8?B?ek9YYkQwSEhWaHpRd29xNlU1ekZna1AvRy9FQy9hdjhJWDB0V3QxUTVWSmsv?=
 =?utf-8?B?MHg2cHVScEhOWWY2WHprNnJnRkRpaUpZcHdJSGZWNnBrVW9leWVTWGpYZ2g5?=
 =?utf-8?B?YmU3REQzZWczZ016NGl5U0VFTkxEdFI1TDQvakhOMGFtajliMmN4Ui9XYk5o?=
 =?utf-8?B?MUZrbUpGTnFvaExraVhNTUo0M293dGU1Q1lndTlkZCtSbXpxM2tSSnFseVNP?=
 =?utf-8?B?Sk1vdTJCQkVMZklINDVHNlZDTEZJY3dybXZEdUxPY29RazVPVDBOUHFxZ2tm?=
 =?utf-8?B?VmFJZnRMTG1nQzhvQzEycE9uMGt6VmhMN3QwSXZFSHYvZUduQktMNmVzaFA3?=
 =?utf-8?B?M0dXOGxEay9SNGVJVkVFQ2VpQUZ4RmNOenloY3NrVkRHQm5xNUZQWHJYbkk0?=
 =?utf-8?B?OXF5Vm5FMDRDTVd0UlJmYlprQnl0ZVNpWDNJMy96NUlKTHZIMDRXOGU3b0x3?=
 =?utf-8?B?TXlLNDZjbEJHWk02eVVCLzhWdi9BaHQ2TElTTGJETmtyR01pS05MMXlYZVdz?=
 =?utf-8?Q?7Y8f1HJBTp5R6EC1X6rJvPW9JCyabT4RmR0P7n0myBwF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54c04275-4c3b-44f8-aa61-08daf3df9b41
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 14:24:53.5468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q3VOS0JNtvzWbu8kLtq8npiZRUVEKZXB1AlhxdnmeWzSDapAKtfQ6VYg9JBee+dK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5934
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 11.01.23 um 15:20 schrieb Jason Gunthorpe:
> On Wed, Jan 11, 2023 at 03:17:03PM +0100, Christian König wrote:
>> Am 11.01.23 um 15:14 schrieb Jason Gunthorpe:
>>> On Wed, Jan 11, 2023 at 09:54:03PM +0800, Baolu Lu wrote:
>>>> On 2023/1/11 21:44, Jason Gunthorpe wrote:
>>>>>> iommu_enable_pci_caps() in the Intel IOMMU driver. This also does some
>>>>>> handling for ATS, so here we could check the info->ats_supported flag if ACS
>>>>>> needs to be checked or not.
>>>>> *groan*  this is seems wrong 🙁 Lu why are we doing this inside iommu
>>>>> drivers instead of in the device drivers to declare they want to use
>>>>> PASID?
>>>> Currently it's common to enable pasid in the IOMMU drivers, but device
>>>> driver has more knowledge of the device, hence it makes more sense to
>>>> move pci_enable_pasid() to the device driver.
>>> So, lets fix it that way.
>>>
>>> Add the flag to the pci_enable_pasid(), set the flag in the AMD
>>> IOMMU's special AMD GPU only path assuming the device will always use
>>> ATS
>> That will fix at least this the AMD use case.
>>
>>> Do not set the flag in the other iommu drivers
>> Don't we have other hardware which supports ATS as well and might run into
>> the same problem?
> As I said, I think we have only 1 user of the common PASID API and it
> was happy with things as-is, so I think for v6.2 we are fine.
>
> Honestly, not declaring ACS in a 'enterprise' multi-function device is
> already kind of sketchy/rare - even if ATS saves things for the PASID
> case.

Yeah, as I said I've checked a couple of different AMD hardware. And 
what I have available always has ACS, ATS, PRI and PASID enabled together.

That there is a Carizzo variant which enables ATS/PASID but not ACS is 
indeed a bit strange.

Christian.

>
> Jason

