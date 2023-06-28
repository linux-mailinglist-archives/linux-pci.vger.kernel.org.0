Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506317410D2
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jun 2023 14:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjF1MRA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Jun 2023 08:17:00 -0400
Received: from mail-mw2nam12on2065.outbound.protection.outlook.com ([40.107.244.65]:63688
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230115AbjF1MQ7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Jun 2023 08:16:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fnUL7xKqRSeun9DS2La2UKVB7en7Rms112rvpoKNdUPXm2UDrM97b3j5wuRoKXtMmE5GBUTbgwkT+PXHksRaXXBCpI1f/AIsZkNUckHbaSxCF2CIbq1nBy4IsYLE41F3Ehov5S8Mkys69qVTfsahjdElBV2TgylXsvixDAtD9Usluc1v5q98XZQlqQlktsLRpPVIPhMrXFUCvgzH+RIglOzG8vWvymYK7PrjJx5gIESRn4Z3T/pM0McOZ7K1jRMmq+QA4XrKTI6A/sPDC0wg9KCEs8ZDU7OVv2grJ4aCw9nNIiOoD1HiDE3AJPbi+TFE/vd/ZxOFXFs0Z6UqFUMVVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5hUiZKURoXWL/s7/B9Yut/KcsdiQcQSoz7XywJm2iP0=;
 b=oDQy0EG8ollGSK+QxUmGu7Gsp7nNJsLSJlgsHRWp7K8cmvqHVf7Tt8pP43h9gLrzgKy3MnO15xir/JlpyMEH0FrnRcjP5W0+FqVO5pWWnS2ixstGTGdOlVpFa51O0217Sh+QOlnb7YtT+hV2GRxk+7ey2IalXyCmZoxH2jtoCU/X3I8xiktfoL+KoKSu9hsVoqMsbWdo16cLu1i164CZgkEV+NJidEsQjwF9sAwPdkXUlk/8UHtCRvx0Rl3N/Pjgr/ggl/uwW3wLeqAbPix3ExTRgqAHd9kw47ahGyoo1+tHGe+dDt4pJgVznV1koZCeYEE72xR2qIUxn+vwRymVNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5hUiZKURoXWL/s7/B9Yut/KcsdiQcQSoz7XywJm2iP0=;
 b=3baCTvOUB9TnQt7+hD+BpkGAiTmMUqAQBiSyyzLCFU4FNoKAZDNRUMjLivsMDXKZ1BKVslhFKx/MfdFmIbmmUSJWnoAGd+h8qIjuU+Wyn7t7J4fkyU++66Gfa1AoMpV+OQoHYbbMcRwq7/NiPZUebA6hyNmRaNnJTW7dIRtkx2M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB7305.namprd12.prod.outlook.com (2603:10b6:510:209::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.47; Wed, 28 Jun
 2023 12:16:53 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70%5]) with mapi id 15.20.6521.026; Wed, 28 Jun 2023
 12:16:52 +0000
Message-ID: <5a5f7511-74e0-39a2-3b3f-864e3f2e957d@amd.com>
Date:   Wed, 28 Jun 2023 07:16:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] PCI/ASPM: Add back L1 PM Substate save and restore
Content-Language: en-US
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Thomas Witt <thomas@witt.link>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Michael Bottini <michael.a.bottini@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Tasev Nikola <tasev.stefanoska@skynet.be>,
        Mark Enriquez <enriquezmark36@gmail.com>,
        Thomas Witt <kernel@witt.link>,
        Koba Ko <koba.ko@canonical.com>, linux-pci@vger.kernel.org
References: <20230627100447.GC14638@black.fi.intel.com>
 <20230627204124.GA366188@bhelgaas>
 <20230628064637.GF14638@black.fi.intel.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230628064637.GF14638@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR16CA0071.namprd16.prod.outlook.com
 (2603:10b6:805:ca::48) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB7305:EE_
X-MS-Office365-Filtering-Correlation-Id: 34939b28-36d8-42d4-4292-08db77d18e89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f6Mgcwc6jjAuAcy0scziaZZPq6Gpos65Dc+fKtJytC5YFoXRfRz+99ALzc+FGxk4P570hYqlgx8u7SnC0qxacLKRX4+Pj1ed20DySEvL1lXSsuaNkvQUd9yzvtYtMxadSxHeel0UkItL3PFqPb19cyl+9eP3Ry7UpCPWXs7G9EIlYEQOviRX+qTja02VXlnjrLQ8wmetGUjCBrjpp+1Beaig8okdtOhAIO0GFI7AL8iZ0Hau5V6H1HjT9a+Pyn7TmAJDoVed9xRGFTOnzqMZukOrfn/5e5o0X8XrXtwJhrootNRoYqJtAqfrNdUfO983YV9KQiyF2rOKnq5n9IZ4mIXRryp5W3I5836plvv2PKVMISsJyeVmz+aQqAO2JGt+Y6lOT8F6bLuKx4muY1UVmRS8sQfGz+ZSnOlnh/HTCY17zAE+iqXIOCDjQg0PzsrbDZnel5HDehSEPFLgz7P4Qk0/q7In4B/E1g9cHRte3vhUXnqhBM4UVeR32g+MBm0HArqvIFTo3JOOP0nCMuMfaBRfILWu20c1kQvOWtfLMBkBDBoyxB8vPjircc9j+QUontFG2AOaCkMNhvV6GkJO9ABbMbMX28DHeOPWBrAAWU//dHH9vV3SvGZbHfNiPxKW6MFhFVlxIzxpUqkV3v99TTCYqxwVa3e8xukyK2yY471eSBX2uxgvum/nyw7vKZUj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(39860400002)(346002)(396003)(451199021)(31686004)(6666004)(54906003)(478600001)(6486002)(110136005)(83380400001)(2616005)(31696002)(36756003)(86362001)(186003)(66946007)(966005)(41300700001)(6512007)(2906002)(6506007)(66476007)(38100700002)(53546011)(66556008)(316002)(5660300002)(8676002)(4326008)(7416002)(8936002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RE4xV1lReHBSRDFuMzZUaHRzZTNkU2ZvUEJFNmwzK3l0KzZyaGp3KzhVTzgx?=
 =?utf-8?B?TUgxNnB1TTVWY2RGM3JaOGpLRTdaVFN3ZHdqVHBWem1RaVZQNDlraUhKU2F5?=
 =?utf-8?B?MW9lNEpqMkJoWFB5Zk1sVVNYNVBnWEphaHhGVUE3WU9TNEpvRHRpWFlESlNI?=
 =?utf-8?B?QlZRUHRyRnduUVdydEFDWVZoTlM0NWxlUkhDNFpsTTNIN2tiQjFpWlZ6Nzhp?=
 =?utf-8?B?aXFXampPNTFaQjJjT012a3BxYkExNVhERFc0d0xJKzlSRzVDSWZ4MlJEQSt4?=
 =?utf-8?B?WndLd2duNHZWaStTVXRaNHVZdUxTaklkY3FYOUg2SDRyNmVXSnRsS3pjZnB6?=
 =?utf-8?B?S2s4ek9obHNQaExoNmF3dmpxUTZjbU42R25YMHdjMHRhYzBOOTE5QVZiaDVW?=
 =?utf-8?B?aHlxa3pXblpUajNJWnVpWjFCdmpDVVhlWW5YcTBpWFdGT3VidEhTRGk4eE92?=
 =?utf-8?B?ZUpLUEFTVHpnV1YzTzdRK3E3R2EwREViMWZQcWhGZkhvQk9TR21jUTczZEpR?=
 =?utf-8?B?MjkzcWRQZUxLR2ZGR0daa2ZVamxCRlVGNjlXNWJFNGlTa1ZqcFQ2d2U3VUVM?=
 =?utf-8?B?NUlkd0dqK0xkUEl2NG1YN2Z5TGFYQ0w2NC9SUldKTkZXdys4YWVWOEM0elJk?=
 =?utf-8?B?SjhhT0NQZk9PWHF3TU9iU2NRV25KNVdONHVSd1BFOXYwdEJack5GUGc2Rndw?=
 =?utf-8?B?YzRuSlphb2xpYkdzaXlCMXpWUjI5WUh0RnUrV3JrbnpQWWVya1NUZGRSeG5Q?=
 =?utf-8?B?aHc2b0xiU1hBNnJVUjJHT2I1bDBGRm9qVGExaFl0cVZSWTRwN2l1TkZvdWdB?=
 =?utf-8?B?aEd2c1N6dHhMYWRmS1IvbjNWbzBIWGZvL0c2RFZkNHA3d295OW5jbkIwcHMw?=
 =?utf-8?B?Vm0xbmZDK1NTTHh5c3NlV2VyUGpUVHBYWHZuczhjdFN1eHdXRlNVTUMzK015?=
 =?utf-8?B?VTF5Q0JQTTVCL0ZmcCt3eVFTVTBEazNZcEdkdFoybWtLVDRvSnpYNnppdTBX?=
 =?utf-8?B?ekthYTZrNVh1WTl2RVZuM3hRRkI0N1R6dTJqUXMyUmJoZ0NXaDhkK1QwRzFl?=
 =?utf-8?B?Kzh1bG9kYW1jNHVnY0UydDhncUlQdWMwb0FMZFQ1WWhxWmIvUnkvMnUvVHlv?=
 =?utf-8?B?V3BSK2MyY205bkdVNDQ0akNEaEUwR2RpYWt1Tmh2aCtRZDY1Nnlzb3hiZ2Zs?=
 =?utf-8?B?ZTZGWnZNem91TDh5R3ViRHhVczJXSWkzdjFLMlFTMkw1ZkJrcm05ZWFRMkRo?=
 =?utf-8?B?d0tXS3J2Q0sxQTh5MGxscU5maEtKd3pqZnpLSUdQalkwemptVkdZSm9EeW16?=
 =?utf-8?B?aDl4WlFsTThtQ0dyZmw2UzFJZEV6T1BuRzdnOVBtZm1nRWpFeGN5ZkpBbitN?=
 =?utf-8?B?Sll4cUpqWXM0LzhKWGtzTU9rM2xteHFDK09xTmVqdUdlZmVRTDVYZU5kamNh?=
 =?utf-8?B?eUovbk9TVUNPdlVleEpXeFNhMzZjd04xVFZLQUxWbEsxakVSRXBsU2FBcmlt?=
 =?utf-8?B?bi9XN2NkT0IxM05OZERna0N5djlhWFRvYUwxOG9kTzBiMXFGVFBMVmtaTU9K?=
 =?utf-8?B?dFhpNkhKcU9FYlJteGlVYU56SURwa0dTMC90dEMzajFLOFZSNHI4Mmlnc0xT?=
 =?utf-8?B?L3Z3MTZ0VEF0QkRtekhoTjJVYWxWQUkwUFRxMFJZV1VGZE94RDFqdUVMZU9F?=
 =?utf-8?B?UXova09IdUFIRmUyZ1dwdnUydHZ0QXl1cGFZQmVKV0ZkaithNkF6aW10cmw4?=
 =?utf-8?B?Ym1NRndiTFF6UU5zVDh5WUh5eG42dnBRRE1Rcnl3M3V6Vm1oNGF2RVNOTmU4?=
 =?utf-8?B?dGlSWk1veDhla0QybEtuZ0hYQTEyWVZhM1RXWXNzRFEzdnJqVzR6emwrUm1u?=
 =?utf-8?B?MlVFUXhGUXoyc3BhKzhvenh5VUdtTTJlcFlNOGRzakRVU09lbFpVNE1Mb0RV?=
 =?utf-8?B?RVVhWTBGcmhKZVgxR2pLM0ZHMlhDM3ZqWW1YMlVOdkU2RG1Nb212bmdNUktj?=
 =?utf-8?B?V21zK0xjWVF6dGpRekEyQzQ2ZC82aWI1OVpwYU5VM2JPTTh0Qzk5a2h1TkVD?=
 =?utf-8?B?Tnp1REVMNCtkUm00RUxmWDFxYkgrUm1DbkNsOUExZDJzSTZGREVKWTAzckFF?=
 =?utf-8?B?Y2R5b1gxanpXYWYwOEZ6MkxPOFRzSmZad1Fpd1RuUktaa3VFOFNGVlpRcUJR?=
 =?utf-8?B?TFE9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34939b28-36d8-42d4-4292-08db77d18e89
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 12:16:52.8426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZiqhU0wbEpxLkCFRAss+BsXaAE9Hwf+AI3MXnfe1yb2ZREQDp9tp08hV0TQaMfQ9XvKXNcbJ5GYCuKKp4Jztiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7305
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 6/28/23 01:46, Mika Westerberg wrote:
> Hi Bjorn,
> 
> On Tue, Jun 27, 2023 at 03:41:24PM -0500, Bjorn Helgaas wrote:
>> On Tue, Jun 27, 2023 at 01:04:47PM +0300, Mika Westerberg wrote:
>>> On Tue, Jun 27, 2023 at 11:53:33AM +0200, Thomas Witt wrote:
>>>> On 27/06/2023 08:24, Mika Westerberg wrote:
>>>>> Commit a7152be79b62 ("Revert "PCI/ASPM: Save L1 PM Substates Capability
>>>>> for suspend/resume"") reverted saving and restoring of ASPM L1 Substates
>>>>> due to a regression that caused resume from suspend to fail on certain
>>>>> systems. However, we never added this capability back and this is now
>>>>> causing systems fail to enter low power CPU states, drawing more power
>>>>> from the battery.
>>>>
>>>> Hello Mika,
>>>>
>>>> I am sorry, but your patch (applied on top of master) triggers the exact
>>>> same behaviour I described in
>>>> <https://bugzilla.kernel.org/show_bug.cgi?id=216877> (nvme and wifi become
>>>> unavailable during suspend/resume)
>>>
>>> Thanks for testing! Can you provide the output of dmidecode from that
>>> system? We can add it to the denylist as well to avoid the issue on your
>>> system.
>>
>> To me this says we don't completely understand the mechanism of the
>> failure.  If BIOS made L1SS work initially, Linux should be able to
>> make it work again after suspend/resume.
>>
>> If we can identify an actual hardware or firmware defect, it makes
>> good sense to add a quirk or denylist.  But I'll push back a little if
>> it's just "there's some problem we don't understand on this system, so
>> avoid it."
> 
> Fair enough.
> 
> I've looked at the Thomas' system dmesg that he attached to the bugzilla
> and he has mem_sleep_default=deep in the kernel command line. There is
> no such option in the mainline kernel but I suppose this makes systemd
> (or some initscript) to write "deep" to /sys/power/mem_sleep, thus
> forcing S3 instead of the default the ACPI tables suggest, which
> probably is S0ix (Intel low power state which does not involve BIOS).

JFYI actually it is a mainline kernel parameter.

Reference the documentation here:
https://www.kernel.org/doc/html/v6.4/admin-guide/kernel-parameters.html?highlight=mem_sleep_default

> 
> So when forcing S3 this means the system suspend and resume is done
> through the BIOS who is supposed to enable wakes and program the devices
> accordingly during and after S3 before the OS is given back the control,
> it might very well be that it already did something for the L1
> configuration here before Linux (with this patch) reconfigured them and
> this is causing the problem.
> 
> @Thomas, is there any particular reason you have this option in the
> command line? There is possibility that S3 is not even fully validated
> if the system advertises S0 low power sleep instead.
> 

