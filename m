Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E614759820F
	for <lists+linux-pci@lfdr.de>; Thu, 18 Aug 2022 13:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244243AbiHRLQU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Aug 2022 07:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237435AbiHRLQR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Aug 2022 07:16:17 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97FDAB068;
        Thu, 18 Aug 2022 04:16:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PjwqA+nrV7kfVE3n6U3gvq4jL/LqAbzxotmNRnq3qvrnXBXpSPqW2J4PEuOaXobHrJtuxOnmVu1VHWZSZ9RN79ajusU4xo7vgpZnflKGrC85WRQczbPDpQcZZONwpPjwnu623Ckk2aGcloZ2EwfNEG/Wn38VxlA7AaBv3LBt6tmRxoJTAwIknhNr8oCR9N+CFt17DrVr3AM+8s9yVF+z28MXXP1gMcnPKZbIxxQzZZ0S5oIPzCreRlBCG0BApSb2kd549yTQNmxh84y88pz/5YMwFBnsE+tUI4FtTDVUXHmGewAEVytWaGVrdUPXxoK4Lyeq4TNMGGh5wO5yxEbtww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AUbb/7U/5Ut3Nwa1ws8VdLRkf1FHYeons3iAq/+1fhc=;
 b=F+zuXkT352FwE2E6tFCe+Pi5REGdw3zqONGWqak99q8QcppbzCcVDi41NoIOJgX8zOWng6Oah4Zlni+78x2+S/fH+UO57iH+D/fNWKTsutQ9somfvIrEYh3JCINNuGAkHjsqa0PtmApCqUOhdp5iKIM7OGmo+aUdnwAnIEi3I/Eu9LnruT+p0oVyw2CPtz8gcN9zKCTKBfT+tZSA8Y+E32QogNFAJ9PTgV3CqpfzwZ6xyedniCtBvi/afHH80akDbfsnWS6MREMxvK+Nez7zRN+oJMz18+5CITVj4qQNM/PN5c1sK0s3Nd9PTCh9omrt7iTYUeLYmD79s6UksmoBbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AUbb/7U/5Ut3Nwa1ws8VdLRkf1FHYeons3iAq/+1fhc=;
 b=0lhL1+3+TGWDp/3tZ8X3W3VZ2f2EmdenaqcWnTuYv6o4lXV9M0/Lg5y84gZW5elknuLADuzJlHtkW8LBjH867Tjaohb7GyZ+alyk9c+Fwrb9JZv/dMXHAC5triz8mptd6sugT1BsgYdnYTeYpLqtWIWC3IPPPQVoumN8PBWHqNI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SN6PR12MB2831.namprd12.prod.outlook.com (2603:10b6:805:ec::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.19; Thu, 18 Aug
 2022 11:16:12 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39%2]) with mapi id 15.20.5504.020; Thu, 18 Aug 2022
 11:16:12 +0000
Message-ID: <597a9fec-1aca-9877-ffc8-886424b17311@amd.com>
Date:   Thu, 18 Aug 2022 13:16:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/3] PCI: Expose resource resizing through sysfs
Content-Language: en-US
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        linux-kernel@vger.kernel.org
References: <166067824399.1885802.12557332818208187324.stgit@omen>
 <a15fe381-1f41-2c92-2ef1-0b4eb30a5142@amd.com>
 <20220817080202.1a0c29cf.alex.williamson@redhat.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220817080202.1a0c29cf.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR06CA0703.eurprd06.prod.outlook.com
 (2603:10a6:20b:49f::15) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99aa3cd0-70d1-48df-aedd-08da810b0eb6
X-MS-TrafficTypeDiagnostic: SN6PR12MB2831:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jlhrFh0AJBJmM4f/slhWKZnJfuxwrLmCP+G/riQMTs8BS5QxHxHhWaxtfZaERbO5qtANxEDeUsC7mIvEumyQbPav92HpjpFv1XMdYgWmZkbK7Zky+7QdNAQTKkqPbhbHzUKhp0zSvC7R95Di3q2/XA7teEX2hbPlNEEvBL8ZHbWLOGEfTokuHQNFip3pcvj6CEDb/45UKBJceqlAEMqevJHDfFezY3Q2fpWChH4ykD5Wfo/Qe7B40cxGUwfn2cGjgDTIz85pz62o+jbBzw1lVIpinMW85qVtdp+bf8g/d/FKirbbmsTRHgfueedA8MIvXTDy+1nGM768J4ARwSmPIF+NLcH4XBmh0iTeDMa08kcKpCjh5ilPGQuM3z93Bq8Q/tPg03RVxw9imX6Jhs16RbhsJlM5gKCIyL/OmHFKdQIiSXXjQMK2Z7vGU6onLvQ1L7J/kgUeV2iujnCQm0HoYx3Zsk1KCRYmV6N1XmnNBcTJphCbKywe894bH8c681mVmaFawlQJ8I02h8LkOTLFz4Vx04an+HxCVPickZ1tafcRzhaiw24ixjaq0pqN+yrJrp7o15eWPmbXYX8V1lPeGZfUBfidnH4l61cvA94LDYgLpFtfE7Rj7z34XlBD+SxJIb/alFZQt2xeEFIfFZwK6zeFAVZq4EOZmBuIvX+QGz/bcsQ0R0lnA4GJ0jo6jwNUjkbs98jfF+0dGHoBWiOm1U4IupcnTssC4eJ6tAe/EFOzDzYZaVaHUmWZhEg0A+j6PiWzo+GZGcEF2nPAeXPfxQ38OOMcSrGX5VvyXLH4coM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3587.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(26005)(6512007)(38100700002)(6666004)(2906002)(6506007)(66574015)(186003)(83380400001)(4326008)(66476007)(31686004)(66556008)(8676002)(36756003)(66946007)(478600001)(6486002)(6916009)(316002)(31696002)(86362001)(41300700001)(8936002)(2616005)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEJOaFlFbzNKTjM0ZnJnYkpOZzFpc2FRaWdHcTFCRGJhVzVHZ0loend5eCta?=
 =?utf-8?B?RlQ1ODEwUVROTFRpSnJwTWtleW0vdDdZVnJwdURyR21mVGJKZkJJY1JONUVU?=
 =?utf-8?B?dFUzeUNXR0tUTEd6Y05EUHBnTnN0UGFjOTZmYXlrRlRQMkRYc0Z5RXlwNzVN?=
 =?utf-8?B?MEl4cFBTYTN5RHlFbFdZbVZMTmRhaUU4SFN2d1FTWlhFTzF5ZUZVM1MxU2pR?=
 =?utf-8?B?RVMxUVYvY2Q3RjFjb1NpMEwxZGJjeGZxRmd3bk53b0FRVE15bWw0b1BXNW5w?=
 =?utf-8?B?b2twTHMzWjBTNTNzQ0JPbnhkRUhsQlM0N1lHWEEvU2R3SEdNemJUTVF6clNr?=
 =?utf-8?B?VEZlb1BDQmI5RU9RVGl5WFRqL0tTamZEajRIVDliOEdxa0RhanNwNGJuaUt2?=
 =?utf-8?B?YW42YUZ4SHdMVSs4TkNVV3lCZ05mcWxFUzEvV3U5bDdQTmtTaXR3dWYzeUF1?=
 =?utf-8?B?SzhzcWtsQjU3a1phcEE5NTNwMWlBTW44NW1yQXlXckVSZU4ycnFwNUZkSzdu?=
 =?utf-8?B?a2d4ZWhDcC91ZnNHeFhoeTN4allka2ZQN3NlWFdCclpiM3JBZndQcG4yaThE?=
 =?utf-8?B?dWR3WHZSbnVuWGlGbXNnbUJHdG5hblN0MWZQZVZoUDBpZFNSYjhyWitOV2Uz?=
 =?utf-8?B?Wm5SOXBPMEtHWnZwM3BhWGVnMkR2VzE5ZGk0Zmo0VFZyb1dEMjdPdDJRaVow?=
 =?utf-8?B?VmxPeWh6RzJNY05ETVJ6VmxyRCs2SVBWcWk5bElTMHlhd1ZJbTRWaGtIY0Ix?=
 =?utf-8?B?YWt5Y2pvbUVJSGJEbko3RE05bnBoVlV1QTdmdkYyWTArVEJ6YW5RNUR1RWtU?=
 =?utf-8?B?YTBHN250Y0JocWFpMVlDZ0JUOXRyRXVVanpJWjF1QlBSNDZBblJtN1BIWmFv?=
 =?utf-8?B?bVlkd28wc0paSExmc2lNaFh6eGlES3M3V2x0UDc2TnVScnUvMGkzWFFFdFVG?=
 =?utf-8?B?TXo5cVpIWEd6c2JWb3AzcCsyeHVLQ0NPaUdKZldFSDI5ZGlNNkI0Rm9MWmEr?=
 =?utf-8?B?YThyM252UEh6ano2OUpBdGFjRmxPaVRsWWgzY1JqTnF3QlF4bVR3NUUvZEZv?=
 =?utf-8?B?bncxQkxZeGhCM1lxRE52WDRkZVpZMjdyd3E4M0dIWlNTUm5wYlBGT2I3QW9U?=
 =?utf-8?B?N0p4RUdFRVd6YjJaUlVEYWZOSnNzRnEydFZrY2xnUXBIN1M4TUtrTDlpWTU5?=
 =?utf-8?B?aFg1anRxS0tiNGhCelBBd1BDQ1d4R2s4K0JJbHIyN0N4NFhyc2F1WTRzSDh0?=
 =?utf-8?B?SDN6YU9rVXlmT1VHd3diSTZRejUvSEZTaHl4SlJMcTE4N2FUY0t1VXZJSmdO?=
 =?utf-8?B?MXJ5S21xQjBzNlhkZmNDMVc5MVdsRTN0NEFrbFFsUjJHNzZZaHFwQ1V3MEFR?=
 =?utf-8?B?cTNOejNNay9LWHFhamQrL05iZVVsTmNjSTBHUWU3ZC80OWZuNlZSZVBDakda?=
 =?utf-8?B?dCt0SU9Gd0xUWUpNc1c2QjU1U2R0K3VPSWlBUDFxNmI0VXd1MFFRUlFZVnhy?=
 =?utf-8?B?TFlURWxBQ0JVeldhYzVtclpTbFUwZW9rOElicmxYRU83OGRzc3BjWWlvbWhY?=
 =?utf-8?B?Tnc3cm1jbWFFcFRQbThXR2ZlckpnWTF2OEJDS09rVExYdTRPNVlmSjdNZDJZ?=
 =?utf-8?B?QXpHaEFMODRHUmwxSWVNRkFhRFp1UDNQWDdJMFZ2RmszQ2pISVVrOUczTUVp?=
 =?utf-8?B?SnZsRFhabUpVTllnOVFCZVRuL296eVN0Rkd6UFl6TlhUaktOZ3dzTktKZTFq?=
 =?utf-8?B?ajYxQUcyUjFYUnorN3ViQnk4ZlF2V0RId2txaGpodVdCSEdlbkdKams2Y1Vn?=
 =?utf-8?B?akJZYzM0K1l3eDI5WWk5S2hTenZEUDZpeTgrbUxOTTEvNCtlREI4NDRTMTV3?=
 =?utf-8?B?TTNKRDNwOC81THRTaTRDSm5aQXdFN1hJenUzcW5hQjFtWHpsWGJMZG1QVmJB?=
 =?utf-8?B?VFhLTy9pNnVWak04Y3QzcEErc1ozV3QxUVR0K3Q2MEFwNXdjcWc5bTc0WE1W?=
 =?utf-8?B?RkdvRCtTQTFMbVg0UExmQVY5SGtRSXliNmwra2N2Sm84eXhSbW1wY3F2ZTM3?=
 =?utf-8?B?R3FNcjZ3QVAzNWNDSGFPYVFHT0lWSjBaYTBwKzJzclBxMkpOclhHMVRRb3NM?=
 =?utf-8?Q?Ub3TBBD80Xu2NH2jDT08oM5JQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99aa3cd0-70d1-48df-aedd-08da810b0eb6
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 11:16:11.9698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jUts8N9ITKQugNc8J3PRsak6z7STdvBGCLJ//xUhCo0MvLvxjeSJOl9Va1SbKsVC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2831
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 17.08.22 um 16:02 schrieb Alex Williamson:
> On Wed, 17 Aug 2022 12:10:44 +0200
> Christian König <christian.koenig@amd.com> wrote:
>
>> Am 16.08.22 um 21:39 schrieb Alex Williamson:
>>> We have a couple graphics drivers making use of PCIe Resizable BARs
>>> now, but I've been trying to figure out how we can make use of such
>>> features for devices assigned to a VM.  This is a proposal for a
>>> rather basic interface in sysfs such that we have the ability to
>>> pre-enable larger BARs before we bind devices to vfio-pci and
>>> attach them to a VM.
>> Ah, yes please.
>>
>> I was considering doing this myself just for testing while adding the
>> rebar support for the GFX drivers, but then just implementing it on the
>> GFX side was simpler.
>>
>> I would just add a warning that resizing BARs can easily crash the
>> system even when no driver directly claimed the resource or PCIe device.
>>
>> It literally took me weeks to figure out that I need to kick out the EFI
>> framebuffer driver before trying to resize the BAR or otherwise I just
>> get a hung system.
> Good point, I think maybe we can avoid crashing the system though if we
> use the new aperture support to remove conflicting drivers from all VGA
> class devices, similar to d17378062079 ("vfio/pci: Remove console
> drivers").  A note in the ABI documentation about removing console
> drivers from the device when resizing resources would definitely be in
> order.
>
>>> Along the way I found a double-free in the error path of creating
>>> resource attributes, that can certainly be pulled separately (1/).
>>>
>>> I'm using an RTX6000 for testing, which unexpectedly only supports
>>> REBAR with smaller than default sizes, which led me to question
>>> why we have such heavy requirements for shrinking resources (2/).
>> Oh, that's easy. You got tons of ARM boards with less than 512MiB of
>> address space per root PCIe complex.
>>
>> If you want to get a GPU working on those you need to decrease the
>> BAR size or otherwise you won't be able to fit 256MiB VRAM BAR +
>> register BAR into the same hole for the PCIe root complex.
>>
>> An alternative explanation is that at least AMD produced some boards
>> with a messed up resize configuration word. But on those you only got
>> 256MiB, 512MiB and 1GiB potential BAR sizes IIRC.
> An aspect of shrinking BARs that maybe I'm not giving enough
> consideration to is that we might be shrinking a BAR on one device in
> order to release MMIO space from a bridge aperture, that we might then
> use to expand a BAR elsewhere.  The RTX6000 case only frees a rather
> modest amount of MMIO space, but I could imagine more substantial
> configurations.  Maybe this justifies resizing the bridge aperture even
> in the shrinking case?

That was the original idea why I've kept that in there, yes.

But I never really seen a case where that really mattered.

So far making BARs smaller was something only the BIOS does.

Christian.

>
>> Anyway, with an appropriate warning added to the sysfs documentation
>> the patch #2 and #3 are Acked-by: Christian König
>> <christian.koenig@amd.com>
> Thanks!
>
> Alex
>

