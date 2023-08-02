Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B691176D025
	for <lists+linux-pci@lfdr.de>; Wed,  2 Aug 2023 16:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233854AbjHBOfp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Aug 2023 10:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbjHBOfo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Aug 2023 10:35:44 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD221BE4;
        Wed,  2 Aug 2023 07:35:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LTZsCBEfdJ+XzlBKdX3AacWBU9LJYV3QysPyteIBl8tKWMX5ApQGCRDIGc0h5RZSm6hsF9a7/jP5Nh6Mdl1o0VuACFzRuhZrX6TxRfqe+rtP8Xsg5LCSmNdZrtexCtwZhqp7eeyoZBZSJMAFzLsdKXv63UKhCqubWTmu7tjBS9s5OdJQ3MLrrfhojh/idGKmNXd7hW5u2ofw/qpM3iKCU8/t6be6dxfI0rVjKzLX6ODUyKIUh9n3jTDJSlvL7eiQYBxqDXvb7J/+QPgA3EEXQgqCDiAW/vrBI+93Oz4PaWx+2tozaduJGJlkgq3P5kJJkfqldYX6mGBrgz8qNsjnNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A5P88ER48pgHUxXnjT/ApVn2tANidrEBK/hF1LZQczA=;
 b=GC3ggZFE7HlHGVfdotpdlhAOPLfNc6XZGklSS0X2i7WSA9vrybqRlnJ8qxzZOPsfStEVjS5qs4dHRoHNeveDorUWwTopi9Yw3RoP2a8We302sbCBleVM9Qm9dvchzLwRaq2isbhKsi60l6JyScpWBFPnRIURl6nHW7+LOTHW6t7SDfWXgxXnfrSfWVrE5mqx5AuQxUF5HM/Y2vg6u1S+mEwfHQTWwqoBFrjiXJiBnqCKRQCv52tQUZP8pnWYhOESls2beC0loH+Zmh5aeBUwnZz+cCFHrh+XPAr75io2aD1evsUfFxAzR7SXtyiXINTZ2Wg6ooYgRLpWfDlrV76plQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A5P88ER48pgHUxXnjT/ApVn2tANidrEBK/hF1LZQczA=;
 b=1SWa+6ZudYYtDSC9nCaB4jCJns38AiqyuMYQfXNBHwZ8FbS5SHbp5kmX+dfyOwLB2bF4+yBgQstRGQvlviYHOzp03ZHBwqaE9Ec+bGDH92OuN+cnJCUJBPCE8U8qiKDSJlcZiUqqen2zNDtJNggaR0k+E72x2HshK/Lt8c6mlbQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ0PR12MB8614.namprd12.prod.outlook.com (2603:10b6:a03:47d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 14:35:38 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 14:35:37 +0000
Message-ID: <0fa90fa4-af41-52c1-0e6f-3ce6a84fa461@amd.com>
Date:   Wed, 2 Aug 2023 09:35:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 2/2] PCI: Don't put non-power manageable PCIe root
 ports into D3
Content-Language: en-US
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, Iain Lane <iain@orangesquash.org.uk>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <b82a50eb-8182-84ca-5b24-dbe8870fa871@amd.com>
 <CAJZ5v0i6PviqW7u3i8hmvSCvR_VHqP-mWRy3Da8Ev_1vi9qBQA@mail.gmail.com>
 <a309e3fe-b1f9-e269-cb97-8af87c8d483b@amd.com>
 <CAJZ5v0jvxrDMR6YHFpYZ4yYpp82-3TtrH==SMRFtUMJsv7=i=g@mail.gmail.com>
 <37b005d5-68fb-f8dd-67e2-c953d677fca2@amd.com>
 <8298c01c-abec-914b-0542-459f38c635fe@amd.com>
 <CAJZ5v0i3g0JujMwikB8niRZ93hXJZqWtjrCjbaDmkMLUbMmwMA@mail.gmail.com>
 <d1b2cf1b-de5f-6c2e-c8dc-fdf60cd0882d@amd.com>
 <20230802052601.GM14638@black.fi.intel.com>
 <e82ec662-22d9-b331-0880-886bd28624eb@amd.com>
 <20230802143142.GS14638@black.fi.intel.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230802143142.GS14638@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0103.namprd12.prod.outlook.com
 (2603:10b6:802:21::38) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ0PR12MB8614:EE_
X-MS-Office365-Filtering-Correlation-Id: 9be3c4a4-98e1-450e-1367-08db9365bd28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a+Sop5JiULublI4ckdzwN4fOZsNF8cto9TNxBBYBJgWiRTCXyhf01RhVgOMR6fR+BoDzhndsN69Z4NNnAWluNF+l+WHKt5HlpTJxN+dSbdGfTWYbTx+uMpcGIUCwKOlMdTHCw5C+gLrqaX3l0R3lZ1nt4Gzy5kJJpoVyw6smkBF3CzMwBBvRSQaOqiwAftObkLcjmgdFJFUr/oqw1t8LntwQCg0G6qtR5aPoR+cfPNiDJ5zwtScfD9fpLzyxqhwivrVAFrDzjf9Y/6bdidOrwagS9B/ldW5rgOzcyNXInKvMsUcbvR2QiZB+ogUAUe49GsyyLmdDOCli89PKV8/tM4M9d4ENB9FJyFCpe7qP7fpbBnvONIiN+jIHxl37aP2LiVWVMcGDL9hWHL0fxpJfBQCKWWiMxmSH+6j5ozSHSu20GHlAWJ1pvy/MEWkUqo680QruK/rC3h8T/z1Om11P6dPpjNyp0yrsdG2a+qdamIlbUvafeD3bsRPzsfaiAW/g+MCdfbAcHKMPu8LJ6/ZPJQWSwxBBOjVj/YnAiGAb5xl9qDEHgyDWm7/tBb0+KAeH5V+cDJe/stWeVhcn2qlL1E9KfJfiVG22PQVMxgKvMyY13ts2XeQtn7s6YDWILGMz/8iEG77M9GqA0Nsb0PR5nw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(366004)(136003)(396003)(376002)(451199021)(7416002)(5660300002)(41300700001)(83380400001)(2616005)(38100700002)(316002)(186003)(8676002)(8936002)(6506007)(53546011)(26005)(31686004)(4326008)(6916009)(86362001)(66946007)(66476007)(66556008)(2906002)(6512007)(966005)(6486002)(31696002)(36756003)(478600001)(54906003)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1laQkpPVnFMU21FdUN6TjZqc1Nad2FGQWRqSE1FMDFUdDE2TWI4QzFVT2Iz?=
 =?utf-8?B?Q3Y1WFZBSGgzdzkvZXJLK3Iwb1lXdDNNSnM0YlgvYXpwMVFHL293WFNyaWpO?=
 =?utf-8?B?R1c0ckw3SmtmWDFSa1FhVG9ndG5icndQUVpzWWtvdlNyclBUdkl6SEtzUlR5?=
 =?utf-8?B?OUNnTUoybFBRRjNlbXd3MFNqVFRick8wZm5TR3VVTWhDTjlrdmVRYjJUVGlS?=
 =?utf-8?B?T0dxb3BhNDJtaUJZZE1PNU5SaitDdFVpOGFoT3U4OHBRYkpzVmtiVFVlSmZI?=
 =?utf-8?B?K3ZpTHA0Z1dlOVRzUmVnQ0NSMG9GcmdnRUs1VllQeVdYMkVLYzNQRkoyTVVr?=
 =?utf-8?B?V1draU9OTDRzV05wNUJOZDFLSG5wK2MrZzh4aVFvekhGa3BJYkZ2dGEyekJD?=
 =?utf-8?B?VUx5UWx2M0N3Z3E0RDRUQzhIY2hOSGx3SHBzUGR4NkJRMW00bERLVnFoNkFl?=
 =?utf-8?B?QVlGTFdGZG5zRzVzTklHemt3WmJIK21mTWRUdk12OTk2RWlHa0gwc0ZCckdi?=
 =?utf-8?B?d1l5SHNobnArOTBPSGhzNmZsNWtBZzhkN2Z1QlV2SlpvSUJjYWVYYUpha0ds?=
 =?utf-8?B?dzJIcnRmSkMrajAwQnJrUVZtU2xld21hK0FtSWVXN1doMytrVk0za0xYbVJH?=
 =?utf-8?B?ckpKZmRjM2RIUFl1RjAwQVZSRmJ2eWtxN1ZFcVlWbktlYnJiMTIxeG5nbW44?=
 =?utf-8?B?Q0s1cmhmVFBFQWUvbTZKNm9MYTkybzBsMEpzVUtsZ2lmL1Z3QXlua05CRy84?=
 =?utf-8?B?L2REeUtPRmpsN29NOHhRQjVpaHRaS0xWUWxCVjJIazlKL3NneVhUbmdBRXI4?=
 =?utf-8?B?em5ObHNzR1BuRHNzbTVCeitpQ2tjWHpnb05GdjVWUGV5WlNDZ1VuQzJ0b0lV?=
 =?utf-8?B?eDM2ckI3ajBUQS9LTldHQnlmQmtJQklPcStNcFUwWG1IRGFaQldaaHRyTU44?=
 =?utf-8?B?ZlNYd0RWQlZHMmtHbnBPOU1XYjJIdmcva250SDFvWUJ0MTdCNTNEV2p1c2pU?=
 =?utf-8?B?emFncUZIYmtsckZjeFRBTy95aXZrWDNqSDlvL2F3dmR5WTc2WVdTdkRIRU9k?=
 =?utf-8?B?aFFwb3pmN2M1MWRpUngzM1crV29tdVhOSFYzTHo5eTF0VHY0eWd4Zk5BUlRz?=
 =?utf-8?B?LzBjaGFiQjJ2cHcwZnNJdUp6UjZwUmJoM0V1T0s5aUJoSTcwQWkrVHdQaVJn?=
 =?utf-8?B?a3hoM2Q3Zld3QTFLbTdDYTlydXpQSjByQllwQjhaV05TWVpYbjBkb24yYWg4?=
 =?utf-8?B?RU9vNE8rR3N5MThDMDZuenAxczVxV2xlS3U0dzl5VndlZ201Vml0VFhvblpC?=
 =?utf-8?B?SHE4QVFZV09WNFFRcURoZWV3ZERhS0hsQXhlenpUZ1VoUlJmNVJyeTVuYlJ2?=
 =?utf-8?B?eTFrYXgxRHUvUDZEeHVxMjE2VkhBV1ZmQnV1cGp3dVFaYm85K0VaRzYyRE90?=
 =?utf-8?B?SHZJM20vV2luYW82U1ZWOWR3QVVSUlFLalZ6cDRmaFRnZ0QxbEhUT2ZEWVZT?=
 =?utf-8?B?eUpXZEM2OHU5b3VQWnBIWWpjbGJOdnd3cDR4SVhYNDZNMDdoTUhxTkRxUlZu?=
 =?utf-8?B?blY3MlhmTlZVWjdRK2FvU0N4OHRsdjRTVXBJNGlVb1d1d0huckJDQnd3UG5p?=
 =?utf-8?B?TFkyb2JadkFrWEl1alJhVk84QitxcjhqNjB0WVJmV0RUVWRvWUJMcFFiZTFN?=
 =?utf-8?B?ZWN2NlA3em5Wbng4TWt3akdOWStHUk9rMC9jSjdKbUFoSVBpRm45Y20rL0tB?=
 =?utf-8?B?T3E1b3EzL2lCUUJyWVV1QTFNanZMNElvZUVpYnZkMVFEcnN6cE5CTUZvalV6?=
 =?utf-8?B?OGRYZXRQWFNseEczK2xITFBLNWZvaERCOExXdnkrZW5mKzR2eFNiWnVYdHlj?=
 =?utf-8?B?Ly9sRCtEU3FVZ0VtT0lLSkNWSTEyRjR1YlRwVU03c3M0aHFPZzFRUXkyOHBK?=
 =?utf-8?B?VGFvT280NjVSU3czY1RITE1YZkUxOHE5Y0hDOHFUU3pKYnloMFRYWDVvSDBN?=
 =?utf-8?B?OWljdVRvNWthbE1yVDE1cnBYRHNiRHdmSVRxWDJSUEI4SUZqU1ZNdmtUVkxy?=
 =?utf-8?B?R0hUSVFOcVNwRDdISGRaMytabXJUMHlraHN3dHZFWDEvYlZxbmNKc25HWXhC?=
 =?utf-8?Q?vEaLa4D+BRpeFsUqNX0+hbAM4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9be3c4a4-98e1-450e-1367-08db9365bd28
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 14:35:37.9094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4cumBxTe4Jzh3YP2Fnry7uqjin7d5yrfbliU+YLhXnnty5TitkKorEoF9EfMyFoTUhnqcoMd7kU6+z4WjIiNbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8614
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 8/2/23 09:31, Mika Westerberg wrote:
> Hi,
> 
> On Wed, Aug 02, 2023 at 09:10:38AM -0500, Mario Limonciello wrote:
>>
>>
>> On 8/2/23 00:26, Mika Westerberg wrote:
>>> Hi Mario,
>>>
>>> On Tue, Aug 01, 2023 at 10:17:11PM -0500, Mario Limonciello wrote:
>>>>> Consequently, platform_pci_bridge_d3() will return false and the only
>>>>> thing that may allow the port to go into D0 is the dmi_get_bios_year()
>>>>> check at the end of pci_bridge_d3_possible().
>>>>>
>>>>> However, that was added, because there are Intel platforms on which
>>>>> Root Ports need to be programmed into D3hot on suspend (which allows
>>>>> the whole platform to reduce power significantly) and there are no
>>>>> ACPI device power management objects associated with them (Mika should
>>>>> know the gory details related to this).  It looks like under Windows
>>>>> the additional power reduction would not be possible on those systems,
>>>>> but that would be a problem, wouldn't it?
>>>>>
>>>>
>>>> I've been thinking on this today, and I at least have a hypothesis about
>>>> this behavior.  Perhaps Windows is actually utilizing enabled PEP
>>>> constraints to enforce what state device should be put into over Modern
>>>> Standby cycles in the absence of ACPI objects.
>>>>
>>>> In the case of one of my problematic system the PEP constraints for the root
>>>> port are:
>>>>
>>>> Package (0x04)
>>>> {
>>>> 	0x00,
>>>> 	"\\_SB.PCI0.GP17",
>>>> 	0x00,
>>>> 	0x00
>>>> },
>>>>
>>>> That first 0x00 means the constraint isn't actually enabled for the root
>>>> port.
>>>>
>>>> Mika,
>>>>
>>>> Could you get an acpidump from one of these problematic Intel systems so we
>>>> can check the PEP constraints to see if this theory works? Or maybe you have
>>>> some other ideas why this is different?
>>>
>>> The patch adding this was merged in 2016 and unfortunately I don't have
>>> any of the ACPI dumps from them available anymore (and do not recall the
>>> details either). I think these were Apollo Lake-P based systems with the
>>> initial runtime D3cold and S0ix support at the time.
>>
>>
>> I scoured the web looking for acpidumps a bit an Apollo Lake system and came
>> across this random bug report:
>>
>> https://bugzilla.redhat.com/show_bug.cgi?id=1591307
>>
>> "Intel(R) Celeron(R) CPU N3450 @ 1.10GHz (family: 0x6, model: 0x5c,
>> stepping: 0x9)"
>>
>> I looked at the acpidump, and I notice:
>>
>> Low Power S0 Idle (V5) : 0
>>
>> That means that Windows wouldn't actually be putting it into Modern Standby
>> at suspend but would rather use S3.
> 
> Same goes for Linux AFAICT. The ones needed this actually used S0ix so
> the bit should definitely be set.

OK.

> 
>> Considering that result, could we perhaps adjust the check to:
>>
>> if ((c->x86_vendor == X86_VENDOR_INTEL) && !(acpi_gbl_FADT.flags &
>> ACPI_FADT_LOW_POWER_S0))
>>
>> Or could we quirk the PCI root ports from Apollo Lake to opt into D3?
> 
> It is not just Apollo Lake, but all "modern" systems as well (sorry if
> this was unclear). Apollo Lake just was the first one that needed this.
> We also have the Low Power S0 Idle bit set in recent systems too.

Ah got it; I misunderstood it as Apollo Lake was the only one that 
needed it.

So modern systems that set the bit in the FADT, do they also lack _S0W 
and _S0D on the root ports?

Does my PEP constraints theory hold steam at all?
