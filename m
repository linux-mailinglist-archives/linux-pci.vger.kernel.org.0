Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0BEC4EE1C0
	for <lists+linux-pci@lfdr.de>; Thu, 31 Mar 2022 21:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240735AbiCaTfN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 31 Mar 2022 15:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240654AbiCaTfK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Mar 2022 15:35:10 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2087.outbound.protection.outlook.com [40.107.96.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A788EB90;
        Thu, 31 Mar 2022 12:33:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dew7680S77FQsPsCMemx6+pcUPbRTHSR64QpDE1s1JQ1gqoqQIWnYC/N+SLIR9ALacbBxrkbeSZ1/PtPjB2L/WqEKyzU2Sf02asg7Fwmh8j+92GitT+VipqJ3srM6G2YmAP0bMaHtB+ZHMYhYflFwmui/uEsN5b2bCnJX4pxYAhf2E1LqsNtlPvHoyaZCbHS+eGL57iCe1yB6ySlWocc+nK7LiXCJd7gREx/+q+ZiRjqLFwsdj0pQUilSyXabNRAw8pHG75nFcjs289xctahcu68K2ArpYAc7zLe1m63QuqCDkdpHuTkFtLYbvgA9q3gd7e+TdaxVOZcvY+uBQHrcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/sFnGKai+X/ZwS5+AiLWjOCcW79LHlVL2xCJ2XlL6k=;
 b=SULNcm385YvFxMldHeU1NHxshlU3nS08hFg+0F8EdYzgwrlessXDvezOFJdJUlcJfrU/E0dmWtJCZ0hiLW4EyvjKTI2Yq4Yn89LEnqv9RjPDupHUkbKvj29mkxUmvG6eqTWedpZ15rHWBt9vgIerGEZbWCM8Ew/gDCA98vZiw7rGPpBhA+BEJFREmDSt3T6Ry7zr5RzCkEDYxh4FDtALb+qyBMmIqt2SWannULNmsu7vOfkMuov8gUCV9u1oT9fwWAQK0HY45uazuYY7Ri3Vhs80i9QOsT25tlNLkr86bY+XCu6vZVwCRjY67/r9RbYUlQvOtjgeFS+8wuO735/3lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/sFnGKai+X/ZwS5+AiLWjOCcW79LHlVL2xCJ2XlL6k=;
 b=GavvkEGeRd7TjK5Pu/0d89/wKl97obLggdNgGCOtuedomCb6+lkivME9abjB5HLrbJsQzHFnq1i7hQcGkm7KbMtGze8glTfYj0qXmASGdmI+v1mdXIvYGMf0t+C4hh6gQjv2HSQ0RgGHLkneO20b1So0hQNvd+NbKIMh9ydGnCE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by BYAPR12MB2856.namprd12.prod.outlook.com (2603:10b6:a03:136::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.21; Thu, 31 Mar
 2022 19:33:14 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::70d6:f6dd:3e14:3c2d]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::70d6:f6dd:3e14:3c2d%5]) with mapi id 15.20.5123.019; Thu, 31 Mar 2022
 19:33:14 +0000
Message-ID: <729648c2-6e2c-7076-b5a1-3155ce4fa924@amd.com>
Date:   Thu, 31 Mar 2022 14:33:12 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v5 1/2] PCI / ACPI: Assume `HotPlugSupportInD3` only if
 device can wake from D3
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        linux-pm@vger.kernel.org, Sanju.Mehta@amd.com,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
References: <20220331190446.GA12929@bhelgaas>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20220331190446.GA12929@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0102.namprd11.prod.outlook.com
 (2603:10b6:806:d1::17) To BL1PR12MB5157.namprd12.prod.outlook.com
 (2603:10b6:208:308::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bcb58f83-dba8-4550-a591-08da134d4c8a
X-MS-TrafficTypeDiagnostic: BYAPR12MB2856:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB28564ECFF1E851EDED42BB55E2E19@BYAPR12MB2856.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bGiPlAcj6QCvPNVxk7H6RLYd2X1kOlbbe1S++u3Hve9L2FvhlRBIxPe/JfCI8K3iuZRPvOHTZpDtSYngMSrQeQsgQ3UrhZi56zKQyNpGoFoFzMO9n7sB4ezzPxXz9NEW7VsC2nXddeOhQ2w2/FXQPoNeCM+oNB0bvPii08+swocGQXoMZthQVYXFfRiYBQHaosNMDJqBgG4sGQmgSzRRKu2xfQT8e0BdOmIB5BnLHnAXcwyWGIKB9wCcID5p0ObfPXfFdJKNvWx7o7H4B/hgCRsjjKlB4n9RKg+KhHXJ16Trrwi5SfEKFrfbAnuujtbmBnbVY9y8Gi3ZyAEyKMVF13dyBKHYVqGPb2UhB7x9waIO45rCOLC9YkS2pfpUJ4tIIffKZxXxxAhS0ecW8OvQ4PxoJigegGmIL78bXKLBlNc0V8GLo5VW+JUv8GMewsVo+B66I8YFVbiG2iW8PHYFJkH7MhnoEeMHZ51eJgAfuydV40WFGiOiYZgzgCtRFmLUPA4QgEdwFnlz1HjRaGzx8cr1yWmxyDsow/YPJV/hUUxJLCE+9jpIC5UhPXUPfzhdPSJJVYI7FRJTU7YNEYuVNSQycrj2Pf7rBwvNFmvpKKiVyALaDJvXBVH/EDxS+u//SFHbEATs5+Nx14OJlwKOtqL32H1gLEJ68TxgP4CWXwHjlm/zEOiOrmSI1dkeGmaYDddS72Y5Cxc2krYgVSCaI09/ojXVCyMm2Sycie9ak4pze4uHWNgpVvjKnqz71avq/eCIqEX4DOvaMazgGkTFRMx8P0HLIN+eYwT9dVtJYhYWZ8iM9w90CUs9wMe/tMFMPk3TLipf0MyK8c4PltUdnqhyFp4KssO71GRGuowKlIsONzLcZCsmBOK5TJUpDgmv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(6029001)(4636009)(366004)(2906002)(8676002)(66556008)(4326008)(38100700002)(8936002)(54906003)(6916009)(316002)(19627235002)(66476007)(5660300002)(66946007)(966005)(508600001)(83380400001)(6486002)(36756003)(31696002)(45080400002)(6512007)(2616005)(6506007)(53546011)(186003)(31686004)(86362001)(26005)(81973001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzZTYkpMMm14T3RjdjBPdTQrRElYS21FT1hvTE9vUVFFdVYwRVFzOXN2TnJV?=
 =?utf-8?B?MEVNcG5JWXg5em9hSFNLVjZVU2ViTlFKdFNIMzVkK0NGVm9sTlNyWll3K28x?=
 =?utf-8?B?V3JTSlF4RjFPTWRnYW9wN05LdDJmMW9aR09NZE1ybFNqeWVpQUxkTXd3WWdF?=
 =?utf-8?B?U1Zucno2VnRZRVZBM0FIZDE4UG9sRmNtY282aXh4UEY2M0JmVkxoSjJhVG82?=
 =?utf-8?B?SXVLZ1pPbUpudmJLdnQ5RktMSTZPdVRsb2ZaMWFlLzBjclNhYUtPeFQybnV6?=
 =?utf-8?B?NnVWdHFXS1FQc2NyVkU2M1FqRGZJbFA3NUJjUTZzODQvcHhaaWt4dVdDRWZl?=
 =?utf-8?B?VzQ0M1pNaFFCTFYzZG5SM3FaYmhmQlJrNG5oV2pCZGs1TTgrMWhnLzBqYWln?=
 =?utf-8?B?K3Q3V0FYZ2MyQVRQV29XVnUzRDVJU0hkMUVRYU1IODNYK1pCbklzaW0rcUlz?=
 =?utf-8?B?eXEydU1YdmNqdUlEZWUyVEptMnFmZkFWUzFOUHFMQzJQN2RxM2llRUFTZHh4?=
 =?utf-8?B?WDcxK2EyeFpTSXhnRGI1WHNIcGVGa3cwclZoV0tKR3NoVlQ3akpYVXF1T2NM?=
 =?utf-8?B?QkxnaHF3SUFkSWpxS0FadVNmbjRmaFdBbHFKODg2RlgyOEwwRnE1Zyt1VDR5?=
 =?utf-8?B?TC9ia1dmeldCNG05dXE1Y1pHbGd2a21idnVkM0owOHBXMDc3d2w4bWR6SE4r?=
 =?utf-8?B?QmI4TjJsQU9UNE9Gc3RUYTJxWEdzQnFRVFYrYWpkTUhDWGRnTmhUemZBNm01?=
 =?utf-8?B?QklDdnJpdTRtYk9yb0RVVUZtcU15RVFUZzFEUGxrQTBIYzNCMlBldEdTNWJi?=
 =?utf-8?B?N3JLWWFZRytzNFpscERXQVMzS0FlS3VXTUZTTUFHZ0NCOTY2cW1BRFlreHZp?=
 =?utf-8?B?RVREa0hzMkJnMEFIWENzREFLZlhJUU4rRVd5ZFM5ditiV29uRk5iS0Z3amQ4?=
 =?utf-8?B?b01yNGpmUTJ4bEdwZEF1ZE5uUGt5WUlWazJIL0tUTlRiWjhwM2pqeE9ZYXFr?=
 =?utf-8?B?SGxzMjZiWDhtTFJCTlpGNVRnUVZrMjNKYkg0VDJVMEJKSGg2cTlrV2VLMHJJ?=
 =?utf-8?B?S3h3ZnAvaWloYW9OWFg0c1JzT2t6eFZ5UXQ4UXYvZjJQZmZXMHFhQXNwcDln?=
 =?utf-8?B?SnB6QjB6OWptYXlWdFR3N1MzRDZmalVib2tzT2pKd3V2SDV0bW9kV2VZM0tE?=
 =?utf-8?B?UUtRSUVqL2JlaTkxSjQ1NXVwVDhjMWY5bGF5bVRLd2pDOUVEMW5tZE9janpW?=
 =?utf-8?B?WFNoVHV5N3lHQzUzRW4xTUV5NWlSYUlYVkVsOTRxZ2xJNG0xb3BJU2F3R2Qr?=
 =?utf-8?B?K1E0YU5BUkttWjZzZURQTm1lZGttMGJveWpLWWYyUkVqdlRkWEcrR2h5OXRq?=
 =?utf-8?B?QWpXWlJPMUZtRHRRellTcXJ2VzY5QVQ4NUc3MlpMeklEdVAyUXhWVUNob05B?=
 =?utf-8?B?VjRSazNLSTU3alJtbTV1TW5aL09uQWhTbjR6OXBjYlF1SkN6MFM3SCtIempn?=
 =?utf-8?B?dXc0d2FNc2IrOGdGWVlBanQzUnlhb2VvV0tOd2xLNE03ZUc2R3BnZUE4V3dR?=
 =?utf-8?B?RjloVmVEdG1kK1luK09IYVJaOTNSSE1oZXdLZDdLL0lXMTRUbjBpc1BqWElw?=
 =?utf-8?B?SmF4RUk0ekcxZWZpdlhyN0R3UUpIb0VlS2c3K1g1THIvbzFIbXpDS1VpNGhT?=
 =?utf-8?B?ZXJLN0k4S1Q3aFBac0htWHJ3bzRPNVM5cFpqSkJkSkpHUGZUS3ZlWDh1SjFR?=
 =?utf-8?B?Y2huanhBWjV3ZmZmNnBpTjJGWE1ranB0M3Nza2N0dXFIVGFkbnIwVXVCL0hw?=
 =?utf-8?B?MjdpZlprTCtWV3p5NDVXM1VwU2diZ050Tks5cHY3K0k4ZUw1SlNVRVBNb1lR?=
 =?utf-8?B?TXdFNGozZ0VqZC9Da3dzTVNwUHdoQ1VYQ1VqdFpmQ2ZHakF6cWFrYk14dDNF?=
 =?utf-8?B?TEdoQ243dmRwSk84RnJHMW9RMURRSko1UjhrRURScFp4N2haRFMzTzRHbktx?=
 =?utf-8?B?SjJLc1AvcnBKQXowZlZGcVp1c0MxaXhTQyt4WnJtMzNadlVsbWVGK2o5NDVL?=
 =?utf-8?B?YmZyNmE0TEU4VXV3YXFtcnVpWUVRdWNaRHp2aWFSSm8xRzN0UURrNDNLelBH?=
 =?utf-8?B?bWVmY2FXYnB6NytySmE3bWswL2xyVWQrK0pNcTVVUEtUL2xETDJjTGNnVDA2?=
 =?utf-8?B?NGQxWFhORTZCNEs1ZHRtem9YK1dpUEVkSzdsNDJ5MGxhMGljemJXWFkzZVpi?=
 =?utf-8?B?VjJwaHlFazVIQWpHWUF1VjI0elVQSlU3VGNYSUpQR1IzZ0kweDVBMW9CN0VK?=
 =?utf-8?B?dEpoa3BxMjlkV1J2Z3hlNTFTVFMycVRxZ2x1UjZJR2Y5ekhOQWJadz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcb58f83-dba8-4550-a591-08da134d4c8a
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 19:33:14.5328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7xFy+P4JYEKrLDgPRS9lv7inNHjOnfQzqaKUwlG8wb5arkGf2E62PNs3PtLq48/iHsN1+DesR1Mo004j6V4cqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2856
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/31/2022 14:04, Bjorn Helgaas wrote:
> [+cc Rafael, Mika, linux-pm]
> 
> On Mon, Mar 28, 2022 at 03:55:18PM -0500, Mario Limonciello wrote:
>> According to the Microsoft spec the _DSD `HotPlugSupportInD3` is
>> indicates the ability for a bridge to be able to wakeup from D3:
>>
>>    This ACPI object [HotPlugSupportInD3] enables the operating system
>>    to identify and power manage PCIe Root Ports that are capable of
>>    handling hot plug events while in D3 state.
>>
>> This however is static information in the ACPI table at BIOS compilation
>> time and on some platforms it's possible to configure the firmware at boot
>> up such that _S0W returns "0" indicating the inability to wake up the
>> device from D3 as explained in the ACPI specification:
>>
>>    7.3.20 _S0W (S0 Device Wake State)
>>
>>    This object evaluates to an integer that conveys to OSPM the deepest
>>    D-state supported by this device in the S0 system sleeping state
>>    where the device can wake itself.
>>
>> This mismatch may lead to being unable to enumerate devices behind the
>> hotplug bridge when a device is plugged in. To remedy these situations
>> that `HotPlugSupportInD3` is specified by _S0W returns 0, explicitly
>> check that the ACPI companion has returned _S0W greater than or equal
>> to 3 and the device has a GPE allowing the device to generate wakeup
>> signals handled by the platform in `acpi_pci_bridge_d3`.
> 
> acpi_pci_bridge_d3() currently depends only on HotPlugSupportInD3 for
> the Root Port.  This patch adds dependencies on _S0W (if it exists)
> and _PRW.  The _PRW connection is indirect; this patch tests
> device->wakeup.flags.valid, which is only set in this path:
> 
>    acpi_add_single_object
>      acpi_bus_get_wakeup_device_flags
>        if (!acpi_has_method(device->handle, "_PRW"))
> 	return;
>        acpi_bus_extract_wakeup_device_power_package
> 	acpi_evaluate_object("_PRW")
> 	if (package)
> 	  wakeup->gpe_device = ...
> 	  wakeup->gpe_number = ...
>        device->wakeup.flags.valid = acpi_wakeup_gpe_init(device);
> 
> So IIUC the proposed logic here is:
> 
>    - If Root Port has no _PRW, we can't put this device in D3 (this is
>      new).
> 
>    - If Root Port has _S0W that says wake is not supported in D3hot
>      (Linux sets OSC_SB_PR3_SUPPORT), we can't put this device in D3
>      (this is also new).
> 
>    - If Root Port has HotPlugSupportInD3, we can put this device in D3
>      (this is the existing behavior).

Correct.

> 
> Proposed text:
> 
>    acpi_pci_bridge_d3(dev) returns "true" if "dev" is a hotplug bridge
>    that can handle hotplug events while in D3.  Previously this meant:
> 
>      1) "dev" has a _PS0 or _PR0 method, or
> 
>      2) The Root Port above "dev" has a _DSD with a
>         "HotPlugSupportInD3" property with value 1.
> 
>    This did not consider_S0W, which tells us the deepest D-state from
>    which a device can wake itself (ACPI v6.4, sec 7.3.20).
> 
>    On some platforms, e.g., AMD Yellow Carp, firmware may supply
>    "HotPlugSupportInD3" even though _S0W tells us the device cannot
>    wake from D3hot.  With the previous code, these devices could be put
>    in D3hot and hotplugged devices would not be recognized.
> 
>    If _S0W exists and says the Root Port cannot wake itself from D3hot,
>    return "false" to indicate that "dev" cannot handle hotplug events
>    while in D3.
> 
>      1) "dev" has a _PS0 or _PR0 method, or
> 
>      2a) The Root Port above "dev" has _PRW and
> 
>      2b) If the Root Port above "dev" has _S0W, it can wake from D3hot or
>          D3cold and
> 
>      2c) The Root Port above "dev" has a _DSD with a
>          "HotPlugSupportInD3" property with value 1.

Very well, I'll incorporate into the commit message and scrap some of 
the old stuff.

> 
> The _S0W part makes sense to me.  The _PRW part hasn't been explained
> yet.  We didn't depend on it before, but we think it's safe to depend
> on it now?

An earlier version of this patch actually was only checking this rather 
than _S0W alone.  It was suggested that both should be checked together 
by Rafael.

https://lore.kernel.org/linux-pci/CAJZ5v0grj=vE1wGJpMxh-Hy7=ommfFUh5hw++nmQdLVxVtCSWw@mail.gmail.com/

FWIW at least some earlier versions Rafael and Mika both agreed towards 
that direction (and presumably weren't worried about existing systems 
that this code was used for).

> 
> In the commit log and comments, can we be more explicit about whether
> "D3" means "D3hot" or "D3cold"?

The check for _S0W return is looking for "3", so it's really D3hot "or" 
D3cold.  In the problematic case on Yellow Carp, it was D3hot.  I'll add 
this detail.


> 
>> Windows 10 and Windows 11 both will prevent the bridge from going in D3
>> when the firmware is configured this way and this changes aligns the
>> handling of the situation to be the same.
>>
>> Link: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fuefi.org%2Fhtmlspecs%2FACPI_Spec_6_4_html%2F07_Power_and_Performance_Mgmt%2Fdevice-power-management-objects.html%3Fhighlight%3Ds0w%23s0w-s0-device-wake-state&amp;data=04%7C01%7Cmario.limonciello%40amd.com%7Cdc09192c789f4da990f108da1349553d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637843502933651021%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=RxmXRsx7df1c1x%2FDqHNxG6iRpy798Aok%2Fl0vhs32D18%3D&amp;reserved=0
>> Link: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fdocs.microsoft.com%2Fen-us%2Fwindows-hardware%2Fdrivers%2Fpci%2Fdsd-for-pcie-root-ports%23identifying-pcie-root-ports-supporting-hot-plug-in-d3&amp;data=04%7C01%7Cmario.limonciello%40amd.com%7Cdc09192c789f4da990f108da1349553d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637843502933651021%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=DN%2FfHQTayYZHCDY1NC3cG%2ByrgImwMVMlMhGGcb2ozWk%3D&amp;reserved=0
>> Fixes: 26ad34d510a87 ("PCI / ACPI: Whitelist D3 for more PCIe hotplug ports")
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> v4-v5:
>>   * Don't fail if _S0W is missing
>>   drivers/pci/pci-acpi.c | 17 ++++++++++++++++-
>>   1 file changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
>> index 1f15ab7eabf8..91c165ea4346 100644
>> --- a/drivers/pci/pci-acpi.c
>> +++ b/drivers/pci/pci-acpi.c
>> @@ -977,6 +977,7 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
>>   	const union acpi_object *obj;
>>   	struct acpi_device *adev;
>>   	struct pci_dev *rpdev;
>> +	unsigned long long ret;
>>   
>>   	if (acpi_pci_disabled || !dev->is_hotplug_bridge)
>>   		return false;
>> @@ -1003,7 +1004,21 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
>>   				   ACPI_TYPE_INTEGER, &obj) < 0)
>>   		return false;
>>   
>> -	return obj->integer.value == 1;
>> +	if (!obj->integer.value)
>> +		return false;
>> +
>> +	/*
>> +	 * If 'HotPlugSupportInD3' is set, but wakeup is not actually supported,
>> +	 * the former cannot be trusted anyway, so validate it by verifying the
>> +	 * latter.
>> +	 */
>> +	if (!adev->wakeup.flags.valid)
>> +		return false;
>> +
>> +	if (ACPI_SUCCESS(acpi_evaluate_integer(adev->handle, "_S0W", NULL, &ret)))
>> +		return ret >= ACPI_STATE_D3_HOT;
> 
> I think it would make more sense to move the generic easy tests
> earlier, before acpi_dev_get_property(), since there's no need to look
> up the property if we might fail later.  E.g., something like the
> patch below, so it's:
> 
>    if (!adev->wakeup.flags.valid)
>      return false;
> 
>    status = acpi_evaluate_integer(adev->handle, "_S0W", NULL, &state);
>    if (ACPI_SUCCESS(status) && state < ACPI_STATE_D3_HOT)
>      return false;
> 
>    if (!acpi_dev_get_property(adev, "HotPlugSupportInD3",
>                               ACPI_TYPE_INTEGER, &obj) &&
>        obj->integer.value == 1)
>      return true;
> 
>    return false;
> >> +
>> +	return true;
>>   }
> 
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 1f15ab7eabf8..9959bfdc0746 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -974,9 +974,11 @@ bool acpi_pci_power_manageable(struct pci_dev *dev)
>   
>   bool acpi_pci_bridge_d3(struct pci_dev *dev)
>   {
> -	const union acpi_object *obj;
> -	struct acpi_device *adev;
>   	struct pci_dev *rpdev;
> +	struct acpi_device *adev;
> +	acpi_status status;
> +	unsigned long long state;
> +	const union acpi_object *obj;
>   
>   	if (acpi_pci_disabled || !dev->is_hotplug_bridge)
>   		return false;
> @@ -985,25 +987,37 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
>   	if (acpi_pci_power_manageable(dev))
>   		return true;
>   
> +	rpdev = pcie_find_root_port(dev);
> +	if (!rpdev)
> +		return false;
> +
> +	adev = ACPI_COMPANION(&rpdev->dev);
> +	if (!adev)
> +		return false;
> +
> +	/*
> +	 * If the bridge can't wake from D3hot, it can't signal hotplug
> +	 * events in D3hot.
> +	 */
> +	if (!adev->wakeup.flags.valid)
> +		return false;
> +
> +	status = acpi_evaluate_integer(adev->handle, "_S0W", NULL, &state);
> +	if (ACPI_SUCCESS(status) && state < ACPI_STATE_D3_HOT)
> +		return false;
> +
>   	/*
>   	 * The ACPI firmware will provide the device-specific properties through
>   	 * _DSD configuration object. Look for the 'HotPlugSupportInD3' property
>   	 * for the root port and if it is set we know the hierarchy behind it
>   	 * supports D3 just fine.
>   	 */
> -	rpdev = pcie_find_root_port(dev);
> -	if (!rpdev)
> -		return false;
> +	if (!acpi_dev_get_property(adev, "HotPlugSupportInD3",
> +				   ACPI_TYPE_INTEGER, &obj) &&
> +	    obj->integer.value == 1)
> +		return true;
>   
> -	adev = ACPI_COMPANION(&rpdev->dev);
> -	if (!adev)
> -		return false;
> -
> -	if (acpi_dev_get_property(adev, "HotPlugSupportInD3",
> -				   ACPI_TYPE_INTEGER, &obj) < 0)
> -		return false;
> -
> -	return obj->integer.value == 1;
> +	return false;
>   }
>   
>   int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)

Sure, I'll move them around.
