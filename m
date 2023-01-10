Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB69664229
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jan 2023 14:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbjAJNpq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Jan 2023 08:45:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233819AbjAJNpp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Jan 2023 08:45:45 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2072.outbound.protection.outlook.com [40.107.100.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C6B19035;
        Tue, 10 Jan 2023 05:45:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QAtp8Hz3Xzm/dnPnpWdYQImPUphvasAUAg1ZiUGn20NGVN9di9CQehHMRFpb6Ecq41UGtp04w4VWzwNU6NXq2M5Zk8UeC9HP8hkok6f9ywcdSIBhP/IctHvesXfr1km5wdrSLZzYy3NrcFR0iA8oJb37mOghNtHkdFJoQjuXXpbm2YcvSfr5amkaxbIRN5I2EmMUNNd4HFSRQJlnJPXrnyOg97McRPJNJz/A9rtTgJ+ryRcCzXE5ijESr/togfWpy/usrTBgjNoIsNSCY8zAP7YhCoorZXkDo9MiP8NZg3zufvoLJDL34Q5DI1LdALNOApWSiCAHBa86DboY0i/quA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u2WbGihGi2AMiPg1WA6GqjHNNmI06w/MXCXer0v51og=;
 b=femRIRSK5vgawrBA8VLOtkdYgYB27WsGweFOKPCfu3M31/9InO4x0QbjaM4NYwmFZu7dldrMCGmjpV6akSLZvUcDRewHnWU2DaoSpYrA+EtfRKJZ+TpgvfNBcvn54qiuTRjfAjMXE+R2mrDHIZw+Um6fLjg5JiD9d7srejU+WvKeZcGCiPT8JzvccRRnulZhLaybq9hWuUpTMowWZwOI9tImBM0yPUe4fISkwjUmede2HJAIe93Gebb9sI/UsTguaj80r79m6zE31+xtZvsjSLMbaCBpguOYb+Yz5Hf0p/45AiV5ACTRxpX9RdxsaubdP/S7kWSs2QoUEgemgvpGww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u2WbGihGi2AMiPg1WA6GqjHNNmI06w/MXCXer0v51og=;
 b=cUaHpcThJOKndSuOwbFAyrhGyP41k3fHHLk6fT2XqOmtncv98xZPjtV/D1WCoB+Fu2WJ7GfDKAk58xZPJ0uCPSc/uXqqlb4erVUk/QHHNbjKkmguA709QHpqhD0pGrSKOvC+HtACGQdR94gsPVmlKaBCqlIPV6Fdo21thAzruO8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CY8PR12MB7515.namprd12.prod.outlook.com (2603:10b6:930:93::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 13:45:40 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::80d8:934f:caa7:67b0]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::80d8:934f:caa7:67b0%3]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 13:45:39 +0000
Message-ID: <2d1b2183-7e93-f8a5-3c74-8f66824bc8f2@amd.com>
Date:   Tue, 10 Jan 2023 14:45:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: =?UTF-8?Q?Re=3a_=5bregression=2c_bisected=2c_pci/iommu=5d_Bug=c2=a0?=
 =?UTF-8?Q?216865_-_Black_screen_when_amdgpu_started_during_6=2e2-rc1_boot_w?=
 =?UTF-8?Q?ith_AMD_IOMMU_enabled?=
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Baolu Lu <baolu.lu@linux.intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>
Cc:     Vasant Hegde <vasant.hegde@amd.com>,
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
 <Y71nZuF5wQp3eqmn@nvidia.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <Y71nZuF5wQp3eqmn@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0041.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::17) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|CY8PR12MB7515:EE_
X-MS-Office365-Filtering-Correlation-Id: 049972cb-e766-4fe0-665d-08daf310f5b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bad4By0LXk1OLOEvgsgik3sdS6g7R9P5yU4NZ47AbqNtUbUrVW6rcQuJJ0dfjI7ufOkLXH1yBplRiMPSJXmollzXkG6jV04v3eb6CVDMSOnk4KGyWhRfVjmv31FDRFOLlrLlfdz1hdT+p0N9+3Uqrv1H/qeENGJj/vSpO1En7dqOVushp666vxUdAWJ1lrsuWX+hqwhjRyzUq36dGAy+GWi4z0UlSr6yK4ozx/fcRq9/5Kp3l8pAwyPO5sVNkUD/r+1mc9W5yVGlRrV8R5/HolfD9E+fKHgADGzjYNpWP5B5iVQ3rJWh1zED09inzno/rKOb7AqPVPQxcHOrBxJHp2DHOo+cR883Hi4AtmyGvjh6eUNa448fxk/4Vsqm1ZJmUBrZiXD1Kx/MZ1az0vRiP0PT9IKrwJ6z2wX3a5ESxVEsX0r9J+oQGOFbb8lICzU7/Vv2FdIm6RD3e8fcY+71AmIKEnC6+PS8X90Xr6+KbIxhMEMDrayrtEwupBokd3NcO0c6AXEinN2ixz6xiCjEx0kAh1GhAUsVoZ1JRDFS0d2euOkHIxLHRQK22u5MtuZEJ97889lW1uT55lmIFJ7IKZvSNhexXourZhv4mNDrse/aO3WQ5cZ6FCz+Cnbr5fgsNGHyEd0HdUKEArADe5a6InUp9gjr8Vky2raLMF+QOSEeZYL3S7BesBhIBdKfCS/AkzVCTwVIHjONTAaQVJ3wAVgNp048zRB86dU0F+UFoVGadjQbFfz/rj0aO8NTRs+EyRBDZE3vvnGGRs/IOTnLXVt80qHK9pMakndS3Ah8+Zr9n3yDiWu7dlhoDem19sMC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3587.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(346002)(376002)(366004)(396003)(451199015)(66556008)(31686004)(7416002)(2906002)(5660300002)(36756003)(8936002)(6666004)(41300700001)(66946007)(66476007)(316002)(4326008)(6636002)(54906003)(110136005)(53546011)(6486002)(6506007)(478600001)(26005)(186003)(6512007)(2616005)(45080400002)(966005)(31696002)(86362001)(83380400001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmY3RS9UZHVqNzJ1TVhTMGxSZDRJUDJDTWliMDlXcE1KcVR5b3dON2tteEZr?=
 =?utf-8?B?M2hoVEE2Q001SGcvQ1BLQ1IybjEwdXRnUDNoSG1UdStwcC9VcTE5YXd6WWtS?=
 =?utf-8?B?Tk9SNTF6VkdnWEo3NTd2bHdTb2tYM09wdWliakZMd0pNdkhTazNENktTZGhN?=
 =?utf-8?B?ZXFlTDJibXhWaEVmMzltSVQrMzlPcjg2czdDY1RCcFFCK2Uwd0QvekNQTVp5?=
 =?utf-8?B?VmxveW8wR0xXZFZVRWdlMEs0ci85eXlPV2hZRXR2d1ZCOC93aGx2UW1CZmt4?=
 =?utf-8?B?MVQ0UFJHdSt1dUZOMnZxVFo2UUt3VkFtbHlrQitPWDFKck5Yb3BSdm92WW8y?=
 =?utf-8?B?UjQ3aEpybWJaMVF3bkZYdGlrb3ZCcjgxdTI1UHJVeExsWW9pZnVwYXcyZ3NW?=
 =?utf-8?B?ZW8xR0hDTUZnemtzS200dktzdlAvbldzLzVlRDhkendWUFhzQVRkbzJoUmYr?=
 =?utf-8?B?NjFuTWlsc0dTU1RoNEVMNFhBZjRKcXNUbWkvRzRxdGhUVDZwU0Z5YlA4Yk1J?=
 =?utf-8?B?UEx1TjBrTU16YTJtZ2FURnJDSjRvUUJxU0dndjliazhzVWgrS3VnWDQrZGZy?=
 =?utf-8?B?aUloMHo1YnhHakNpMUtOODNEVWRndFNqM1B4cWk1TTR5NXEzL1NZQy9CVlVa?=
 =?utf-8?B?eVJONFdBNHl2TW5GVDFlYnBZZ0xXd3oxQ29rcVJRbzZTS1ZvU3Z3akZRL3h2?=
 =?utf-8?B?aVgrb0t2YkRidVZjSjVDejFrcDY0dXlYU0lpRGZPcFROdmo0Mk40aCs1OXFY?=
 =?utf-8?B?SU9ka2tZWm5KeEh1cEh4enRLUU9MUVpHcHlsV1dBTEtxbVR3ZFRJTlFaTXlo?=
 =?utf-8?B?ZWZxYy9kWGVJOVg5SHh3R2toY3hwWE92UXhIcDQ0UWdMbXlxZTJUZUR2ckVx?=
 =?utf-8?B?U2QyNi9YdWx3Tll1czd2ZkRoNFNxdUx5SVFFd2NIZ3E3NjVaWDVMM1ZEbStL?=
 =?utf-8?B?NUFzTFFiUnlYaFNVSlp3RmVSTm5LS2tHOW1IMkZObUgycE04WXZ4TCsybmhn?=
 =?utf-8?B?d1hXUkJuMnZxVnNiUWNMR2ppckVoWmhXbTd0amQxQXBjNklGbCtDbGN1R0tu?=
 =?utf-8?B?cGExK0pxRnhGa0hNaStsQzZmQjhLakRtNEhaa3FXdnFvQ0RxR1BlbTkwZGpV?=
 =?utf-8?B?VXNMd3lkVWduaTFRZEJWV0Z4MVJBbVhxS3RhRlhvQXUvY2RvbHMzZVJxbC9D?=
 =?utf-8?B?akpYSUE1UXpURzBoV1NIanVJNGxubjRJellCSW0xNkc5ZXpDYU5wL0JKb2hj?=
 =?utf-8?B?NVVyVTFiSithbmE2d1l1blRhcE1BcDRZeTU0b1NNdzhzUzJReUU4dmt5V0ZT?=
 =?utf-8?B?UFcxV3Y4b0Q4WWdEdHA4Y2lxUytuWjRrTGV5aUEzK21mZ2lYaFk1bTE3K3pO?=
 =?utf-8?B?YzdYazVxdWxaTlYzVEcvTmJnMGVKMTlsQ0hNYlNSa3lEckFjeXdZK3E0Y1ZV?=
 =?utf-8?B?Z0hIMnVmV2VaTlNLeE40QmZuTURJSllVdm40ZERlZWo1QjVrdkR0Yk5XOEJn?=
 =?utf-8?B?czZOREg0TGhVV29MMFNsbUxwdWR5TndsOGx1QzZNMk1naFFWN1dobzdTSktk?=
 =?utf-8?B?MGpmWHJwV1dDelhibHpGMGZ1T2xPeVNMS09xWVZzR0pJM2p5bW56WkdwOHlZ?=
 =?utf-8?B?Um1xWkcrai9HQmJjd09iWjhTYXJ6Wm03cFo0TVVGV2RWRU4rN3JHYWYwVGxm?=
 =?utf-8?B?MitYNWtwZHQ5RXJkNU9HNExVRks2bTJLRGdRWjkwQkx5WnQ1SncwOEttaGY1?=
 =?utf-8?B?YzhFazliZlNwRWVnNFkwRFlSZDRDdnFPM0RGcWs0VUZEUG5iUTFVa2orcSsw?=
 =?utf-8?B?VVJuZlBFUEYraHdYUTJ6SVlMcVg1enVidmowUnFNeHBQYUNOWVJGY1BSekFm?=
 =?utf-8?B?aDBZekxFNGpwNE9GVkRYS015VXJuMmdGaytkWE5rd1p6NWJFL1Q1RktsSVM0?=
 =?utf-8?B?UXZVWnlVaWFuaVhneU1Dc1VTQjNrQnZPdHllMWFpM3hHVzdYeFdJZ0RkNDJZ?=
 =?utf-8?B?cmlKd3o2TWEralVCbURpY2QreGpHdklGMjA4QWJ1VjI4U2F5WFBVOEVHMXZy?=
 =?utf-8?B?OU8wM2lYNGJiYUdjMEpIZmR0YWtUMVVRV3Ruek9IRWo1NkdnTVdvdnEyNWlJ?=
 =?utf-8?Q?PII0Nl/z4oPRDDlmUmZbyT1Sv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 049972cb-e766-4fe0-665d-08daf310f5b7
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 13:45:39.6309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CaHREv+1z8c5tFVWYDua4sVNDMBKfLJu/GvaUo3BcQEVal8L7bNEagvAj1Z2Qobj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7515
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 10.01.23 um 14:25 schrieb Jason Gunthorpe:
> On Tue, Jan 10, 2023 at 01:48:39PM +0800, Baolu Lu wrote:
>> On 2023/1/6 22:14, Jason Gunthorpe wrote:
>>> On Thu, Jan 05, 2023 at 03:57:28PM +0530, Vasant Hegde wrote:
>>>> Matt,
>>>>
>>>> On 1/5/2023 6:39 AM, Matt Fagnani wrote:
>>>>> I built 6.2-rc2 with the patch applied. The same black screen problem happened
>>>>> with 6.2-rc2 with the patch. I tried to use early kdump with 6.2-rc2 with the
>>>>> patch twice by panicking the kernel with sysrq+alt+c after the black screen
>>>>> happened. The system rebooted after about 10-20 seconds both times, but no kdump
>>>>> and dmesg files were saved in /var/crash. I'm attaching the lspci -vvv output as
>>>>> requested.
>>>>>
>>>> Thanks for testing. As mentioned earlier I was not expecting this patch to fix
>>>> the black screen issue. It should fix kernel warnings and IOMMU page fault
>>>> related call traces. By any chance do you have the kernel boot logs?
>>>>
>>>>
>>>> @Baolu,
>>>>     Looking into lspci output, it doesn't list ACS feature for Graphics card. So
>>>> with your fix it didn't enable PASID and hence it failed to boot.
>>> The ACS checks being done are feature of the path not the end point or
>>> root port.
>>>
>>> If we are expecting ACS on the end port then it is just a bug in how
>>> the test was written.. The test should be a NOP because there are no
>>> switches in this topology.
>>>
>>> Looking at it, this seems to just be because pci_enable_pasid is
>>> calling pci_acs_path_enabled wrong, the only other user is here:
>>>
>>> 	for (bus = pdev->bus; !pci_is_root_bus(bus); bus = bus->parent) {
>>> 		if (!bus->self)
>>> 			continue;
>>>
>>> 		if (pci_acs_path_enabled(bus->self, NULL, REQ_ACS_FLAGS))
>>> 			break;
>>>
>>> 		pdev = bus->self;
>>>
>>> 		group = iommu_group_get(&pdev->dev);
>>> 		if (group)
>>> 			return group;
>>> 	}
>>>
>>> And notice it is calling it on pdev->bus not on pdev itself which
>>> naturally excludes the end point from the ACS validation.
>>>
>>> So try something like:
>>>
>>> 	if (!pci_acs_path_enabled(pdev->bus->self, NULL, PCI_ACS_RR | PCI_ACS_UF))
>>>
>>> (and probably need to check for null ?)
>> Hi Matt,
>>
>> Do you mind helping to test below change? No other change needed.
>>
>> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
>> index f9cc2e10b676..48f34cc996e4 100644
>> --- a/drivers/pci/ats.c
>> +++ b/drivers/pci/ats.c
>> @@ -382,8 +382,15 @@ int pci_enable_pasid(struct pci_dev *pdev, int
>> features)
>>          if (!pasid)
>>                  return -EINVAL;
>>
>> -       if (!pci_acs_path_enabled(pdev, NULL, PCI_ACS_RR | PCI_ACS_UF))
>> -               return -EINVAL;
>> +       if (pdev->multifunction) {
>> +               if (!pci_acs_path_enabled(pdev, NULL, PCI_ACS_RR |
>> PCI_ACS_UF))
>> +                       return -EINVAL;
> The AMD device is multi-function according to the lspci, and we
> already know that 'pci_acs_path_enabled' will fail on it because that
> is the problem..
>
> Actually, I remember it is supposed to be like this:
>
>   https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flinux-iommu%2FYgpb6CxmTdUHiN50%408bytes.org%2F&data=05%7C01%7Cchristian.koenig%40amd.com%7Cb45e8c5a24394d66ae2908daf30e3802%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638089539666187724%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=vf9QsDFqp9s1NUxuP5iMsQJn1R0K9tVRTImTR6uZWAE%3D&reserved=0
>
> The GPU and sound device are considered non-isolated by the group
> code, presumably because of the missing ACS caps.
>
> So, if I remember the issue, PCIe says that MemWr/Rd are routed
> according to their address and ignore the PASID header.
>
> A multifunction device is permitted to loop back DMAs one function
> issues that match a MMIO BAR of another function. eg the GPU could DMA
> to an MMIO address that overlaps the sound device and the function
> will deliver the MMIO to the sound device not the host bridge even
> though it is PASID tagged.
>
> This is what get_pci_function_alias_group() is looking for.
>
> Multifunction devices that do not do that are supposed to set the ACS
> RR|UF bits and get_pci_function_alias_group()/etc are supposed to
> succeed.
>
> Thus - the PCI information is telling us that the AMD GPU device does
> not support PASID because it may be looping back the MMIO to the other
> functions on the device and thus creating an unacceptable hole in the
> PASID address space.
>
> So - we need AMD to comment on which of these describes their GPU device:
>
>   1) Is the issue that the PCI Caps are incorrect on this device and
>   there is no loopback? Thus we should fix it with a quirk to correct
>   the caps which will naturally split the iommu group too.
>
>   2) Is the device broken and loops back PASID DMAs and we are
>   legimiate and correct in blocking PASID? So far AMD just got lucky
>   that no user had a SVA that overlaps with MMIO? Seems unlikely
>
>   3) Is the device odd in that it doesn't loop back PASID tagged DMAs,
>   but does loop untagged? I would say this is non-compliant and PCI
>   provides no way to describe this. But we should again quirk it to
>   allow the PASID to be enabled but keep the group separated.

Mhm, I don't have a Kabini at hand but I have a Raven and there I see on 
the GPU:

     Capabilities: [2a0 v1] Access Control Services
         ACSCap:    SrcValid- TransBlk- ReqRedir- CmpltRedir- 
UpstreamFwd- EgressCtrl- DirectTrans-
         ACSCtl:    SrcValid- TransBlk- ReqRedir- CmpltRedir- 
UpstreamFwd- EgressCtrl- DirectTrans-

     Capabilities: [2b0 v1] Address Translation Service (ATS)
         ATSCap:    Invalidate Queue Depth: 00
         ATSCtl:    Enable+, Smallest Translation Unit: 00

On the bridge:

     Capabilities: [2a0 v1] Access Control Services
         ACSCap:    SrcValid+ TransBlk+ ReqRedir- CmpltRedir- 
UpstreamFwd- EgressCtrl- DirectTrans-
         ACSCtl:    SrcValid+ TransBlk- ReqRedir- CmpltRedir- 
UpstreamFwd- EgressCtrl- DirectTrans-

And I'm like 99% sure that Kabini/Wani should be identical to that.

Since this is a device integrated in the CPU it could be that the 
ACS/ATS functionalities are controlled by the BIOS and can be 
enabled/disabled there. But this should always enable/disable both.

Regards,
Christian.

>
> Alex/Christian/Pan - can you please find out? The HW is:
>
> 00:01.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Wani [Radeon R5/R6/R7 Graphics] (rev ca) (prog-if 00 [VGA controller])
> 	DeviceName: ATI EG BROADWAY
> 	Subsystem: Hewlett-Packard Company Device 8332
> 00:01.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Kabini HDMI/DP Audio
> 	Subsystem: Hewlett-Packard Company Device 8332
>
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fall%2F223ee6d6-70ea-1d53-8bc2-2d22201d8dde%40bell.net%2F&data=05%7C01%7Cchristian.koenig%40amd.com%7Cb45e8c5a24394d66ae2908daf30e3802%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638089539666187724%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=TMB3pXS0eUKPZhcRCvUIxzvJvPYosvv3ofrFKZx7b%2FI%3D&reserved=0
>
>> +       } else {
>> +               if (!pdev->bus->self ||
>> +                   !pci_acs_path_enabled(pdev->bus->self, NULL,
>> +                                         PCI_ACS_RR | PCI_ACS_UF))
>> +                       return -EINVAL;
>> +       }
> Why would these be exclusive? Both the path and endpoint needs to be
> checked
>
> Jason

