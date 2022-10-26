Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37AEE60EAC1
	for <lists+linux-pci@lfdr.de>; Wed, 26 Oct 2022 23:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbiJZVUV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Oct 2022 17:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbiJZVUU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Oct 2022 17:20:20 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D60053D35;
        Wed, 26 Oct 2022 14:20:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/Rb1b40g662pcE/SOqlxQHr/oYw5oCQk+d8LV3OMuyqoW8vndSGB4rETe2wIZ9BveN5RHrBOy16UepsxJue2GMgOIOUHouO9472Npe3dRBvB4cV1mN4iUgZnHGYnK76at75wrrAHAguh6h7qXfdk/TdVv30n9NcivU156sCnzVmpJWbczuXIXu8OPzAOGyO8SK5Ruql/10wImMJWz67ZGeu38pve8pC1RpN3OmKeSdnvSFoQWNSsvAmjX8paDDYN3YJX+TivEbhEh0RvQSBA+fu777rXy87+HBZg62kLughlG4am33va+2LzBhZyIhasRxhh+DnMxiPKhVyY+vfCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EifrWoPEprlqCmpq19Fh8fV6Yp/5JdnqscwIQSf4Ggg=;
 b=mE/+HbnXkwJc7NMB+A258cSoEc4+xXOAsy4sdZz4rw8CNwndV24zynDxGZvYAhfEpE4sdxIo2eBMw/OXOwMEnH7dAPvaUfJFjDOLwJ7Def16O8yDl8wbubmenBNx2EfoGqT6FoxunnPU/jJzsTip5+vkX78qwMjuYHpaO7o+v7qtwqjFVBSYmG3uBU+CdLtZwr4hiaw5+MLg+rmDxzy7kvs8Up2PxzhzeNEKjBp0H3rezcKKUnMlrnyUtSqo9aCkQkzbmSR0aKKJFKncHO+/7xG/VFk944Rk+OJ0KF2uBmDf+O6aw9KA1pyeVtWxxL7dkEVSEByOVFUznqLo7qH13g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EifrWoPEprlqCmpq19Fh8fV6Yp/5JdnqscwIQSf4Ggg=;
 b=FfYRUOtTlH+v+pxRgzbGSBbwX+vNIuAD9jWYgM1xDZ0mJ+Iy2UPMsGQXL15MvDuf//nY+uM8vAJ0DPsrtjXHmqIh6nL87frswRVKoSZVhjjCek2TwjoMEHNhvWH4MMAswMPnBQA1ivHzRVStGzsUP72BxH7a5/7wT0S3z6MvU4c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4502.namprd12.prod.outlook.com (2603:10b6:208:263::20)
 by DS0PR12MB7512.namprd12.prod.outlook.com (2603:10b6:8:13a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Wed, 26 Oct
 2022 21:20:13 +0000
Received: from MN2PR12MB4502.namprd12.prod.outlook.com
 ([fe80::ff07:a59a:76b4:f06]) by MN2PR12MB4502.namprd12.prod.outlook.com
 ([fe80::ff07:a59a:76b4:f06%7]) with mapi id 15.20.5746.023; Wed, 26 Oct 2022
 21:20:13 +0000
Message-ID: <3e636a7d-85b9-6d6f-964f-f072438fa856@amd.com>
Date:   Wed, 26 Oct 2022 14:20:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH RFC 0/2] Generate device tree node for pci devicesgain,
Content-Language: en-US
To:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, Lizhi Hou <lizhi.hou@amd.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, helgaas@kernel.org, max.zhen@amd.com,
        larry.liu@amd.com, brian.xu@amd.com, stefano.stabellini@xilinx.com,
        trix@redhat.com,
        "Steen.Hegelund@microchip.com" <Steen.Hegelund@microchip.com>,
        "Horatiu.Vultur@microchip.com" <Horatiu.Vultur@microchip.com>,
        "Allan.Nielsen@microchip.com" <Allan.Nielsen@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
References: <1661809417-11370-1-git-send-email-lizhi.hou@amd.com>
 <1d9faa2e-e3fc-d104-c85f-4035233848d6@gmail.com>
 <ca35a14d-501d-265e-b196-a87e1e994cd0@amd.com>
 <78211af5-171c-ef4f-a8c2-17f63dc479bc@gmail.com>
 <20221010104210.68edf825@fixe.home>
 <0d571d21-507d-fcc5-bf58-d02f958de28a@gmail.com>
 <20221013100245.14c509ec@fixe.home>
 <c427fd85-3746-bf26-e4a3-9b2aa53f6572@gmail.com>
 <CAL_Jsq+aiJbrna6kpvb9k=KWUwMH-k8_Y_W1+HkJpHyGEee7NA@mail.gmail.com>
 <fbfb817c-6f09-32d0-fafc-7d37618e2886@gmail.com>
 <20221017091820.07144242@fixe.home>
From:   Sonal Santan <sonal.santan@amd.com>
In-Reply-To: <20221017091820.07144242@fixe.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH0PR07CA0052.namprd07.prod.outlook.com
 (2603:10b6:510:e::27) To MN2PR12MB4502.namprd12.prod.outlook.com
 (2603:10b6:208:263::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4502:EE_|DS0PR12MB7512:EE_
X-MS-Office365-Filtering-Correlation-Id: d0c22eb5-e749-45b0-663b-08dab797de98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5jXJa2LMpmDEQdTaCJQdtMpwA3L0jzyjzjEP1ro+l3beLP2WzxUhDkeQiaP2+YOqw91WaPm/sA51VW7ns/HKVNCEn0xzf7zfVeCCgkTJMjfQroC/E4gmzO79N9TfyoRQRj/7FEanG+1SVmVPz1SnEUSwC4pwT5D/WCaS0pdyMJdGw8kT5UyqRkwZO4gbyfv0D5LeSrWGyQSH94L3HCjF2JEPepcMi8hJ5koQAn2Le00mPxjIsjm5dteDMOR4uZSs8n16i8zZny+IxEyjcG9QWAbr/egKMNTfG5MJi1EyZl+udYdjKhkHyFQXq4AChRfPPvPC458Jcxl6TToRDCv6rMmk3C8DivEiX4JoBkMq3cw5HKvEdQeIP1BR1eflq3xvPo6eDnByvEAwg7S4WQ1zuG06jvn8JpvWE18LExoA4TXfbmCu3Pgy6UYW39IkKLcvQoA+fviNzL6KL+WNRPsOZs4iIwXmmRQkUxRywRjTOPl/KjL2gZ1uM62+QbxpWpBEe2O96NTfNYEK5sx5YYK3lDiRkJiGugIbKdvpVMahIUtX/nMNzxiKJeCsG2PFbDsh4Nq/RFoBrNXW09Oz8YK/Dy0mFXAV1g/5nFGjbEpS4BN5pqK5IygiuYPYNdw/L9d+W229AzcVI1DHUGUP97VdSIOi6I2Tu9we0kyVFVt+WSOXiKlcEu/9K0+xEb7ZJIBAWc+eF+QcvjBpV6EF7yiu5bhJTzhbPjzkCULTvXzgkeSRlF2QeIxD+BVJhjBYaCUkjUmHvBjM2vsEdPIbpkL8fuCrBN3R2sVfQsXSwoqKKwI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4502.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(136003)(346002)(376002)(366004)(451199015)(7416002)(2616005)(6506007)(86362001)(31686004)(66556008)(66946007)(66476007)(5660300002)(53546011)(186003)(83380400001)(66574015)(4326008)(44832011)(6486002)(478600001)(36756003)(8676002)(38100700002)(110136005)(41300700001)(31696002)(2906002)(54906003)(6666004)(8936002)(6512007)(26005)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3ZWaUNOWjJtU2pJd093VHk5Tmg5dzVaUVNBWGw0My9raHB4TFlzWThoV3BU?=
 =?utf-8?B?aXNxeVkzZExFbGgvYmRHd3VwMzByOGVvS3cwYy95OEV3Vldrem82UW4yNnUw?=
 =?utf-8?B?RXp6Ukt2NHJQajFQNk04NFltUFU2Rlh0TTNpNUhmbzM2djBZR0RLYkV2SDlr?=
 =?utf-8?B?M29WK2dPREgzVkhZOWcvV2VxQXhrVVNPRHFwSzM2dXhtSzZLZDVQdzh4VElt?=
 =?utf-8?B?OG5WSXVzTDRnY2JWQm1DSFlITzlGS25uUEx3UWhGYmdIbnZsTnJjaC9aeVNR?=
 =?utf-8?B?RnpURE1VZXk1NVdYaDN4dmNBVzNDRTJxYUtTWGdncVJkTkF5WmFLMDdWZzNa?=
 =?utf-8?B?bHN3dHRzbUJwTEJ0bThWbU9rdVRjNGY5WHF1Rklva3E2U2JRNXdIN0lCM1Y0?=
 =?utf-8?B?Z1hJR0lnM0d0L2FZSW9zdGcvOVNiM0dDZG4yblFaZTVlRlpESW5COXBveUxF?=
 =?utf-8?B?azZObkQ1dWxUSU1VNUg4RXE0dG15cFl4MXJwVWg1bnMvMi8xUitMTG9wazUr?=
 =?utf-8?B?NFpDWDVwQjR0SUJJUjlWZE9OVDM2SmVDU2F4MW8xbm94eGplUU9kMU5peHRG?=
 =?utf-8?B?aFROZlphSnRlWmIzL1dURXlzbXpvTDlaeGpweHRJSUNwM2l3WVNDdzAvb0Q2?=
 =?utf-8?B?eDdEcVprWnpRUGlXeEQxMXBabTZXdDVUMXFBNzMzZS95ZHBiT2NEamcxNzZq?=
 =?utf-8?B?UUxabFR6azJlYTY0VnFST05HVUp0TERIZzhXY1d1UC93UkM4bzExbXBOeGJY?=
 =?utf-8?B?S1dBWExuQmE5SGRFc29aWEVNL1l5SUFXWTB2aXpxcTdtYTIra2hndE5oTDdC?=
 =?utf-8?B?TTBwcnZQcjBKdS9oQWJOTWpWcUgxVUkxcUJJc2toZksvTUtocDVrNjY0Y0Z2?=
 =?utf-8?B?UG4yOFhXcXVPL2FVN1RJS082aWtEV1BlUitpdVgvb3pLc1I2Q0JWTFRqMDgz?=
 =?utf-8?B?NkgyWGpzN2hZQ25RTXAyQlFLeklEZThhdDZCTU9vRWpXZE5TZzZWVkNONDdq?=
 =?utf-8?B?WDI3RVl5T0ZTMFZFeUVxQWdKT25UeUlRcUpsTUQrZ0FLc2tNbk5vSGZmeXF2?=
 =?utf-8?B?c1U0aG9JcVkyb2w0SXhLM1lQTWloMUpVVnMwOWRHU2duWDBOcDFUbFVmeTJt?=
 =?utf-8?B?V0gwNzBIVGFaTXQ2MlprbmtSOVZHOU5IU3hxQ01OVEVrNXVlYkw2UUF4cjlI?=
 =?utf-8?B?NEtHWEU4RVplaWY3bi9naEhoVklqYWNsN1JRT21sbFBaVXNmZUx0MDJQWDhw?=
 =?utf-8?B?Nm1kb1FXZTFsOFlBQVZ3d25mUmNaVVc5NnhEQWlZWk9kSk5RMkQzV1RnbHJ4?=
 =?utf-8?B?Ly9jSHI5Tk4zdmpZbEFHQ0E3V0NFQTBJUmtPSm5RTnZmNTlpUFhxOXJqcWZE?=
 =?utf-8?B?cXd1eFJmeENqL1VDSzR5ZWx3SnN4ZGhIZFlyQzYwWnlNRGpRVkhUVzhqblZh?=
 =?utf-8?B?cXpmWnhTb0FLQm9SV2FzRmFqeThWTk55dGl2U1c3TGtsT0o4OW5yUGFPYmdR?=
 =?utf-8?B?WFJWd1ZKVVA5QkRwVFRIKzNvTUFyTmJ5RFh3a04vR1M0b25oTUpVRkMyUGxH?=
 =?utf-8?B?Vjk2ZDJiN0NpVnN3T2FYTXlTU21hRHllTGJCZTdvS1dIelFlWUcvdkZhQzNZ?=
 =?utf-8?B?Y2tkaHJ0V3dTVjV6T053b1JMMUJPYXhVSkdMNTZCMmcyWVdOSEM3YStZQldn?=
 =?utf-8?B?cVFKMURkVUczNVlOZ0lVTldBbjArVGtoMU8xTm9BeHVXZ0JVUEFuUUZzTmds?=
 =?utf-8?B?TmMxWWtSN29FbzdSUWZhdlhEa3pPUnIvN0FmWEpEU1dWN1gwYkpUdXlWS09T?=
 =?utf-8?B?Uzdib0cyY1Vjc2ZCODhKazFDRDRvbDlHZjQxWmw5QTgySlE2SkZSOTU2THFW?=
 =?utf-8?B?eXVoOXFqZWlnTVVJUFZLNDdRQlRJaW0vSTdueitraFJ2azRhaXE0QUhyQnFw?=
 =?utf-8?B?OXAzWW5hdERmQXZ5YmRyeWZMSlNFTFR2RXRMdWRwQWJKbWhkTDI0U0JtOXNh?=
 =?utf-8?B?c2cxc1QybkpPeFg1OXZtK1hhaTJlMjlEdFVzamphY1BtYlJBUmFsRStCMWFC?=
 =?utf-8?B?SHl2Z0g1eUhnWEwwZitDWFBFaWxTQTY3aTRRSjhNQnZHTVA4TUJJZTVxZDBz?=
 =?utf-8?Q?TDpQaASgZQHzdyE4scs6BpCiW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0c22eb5-e749-45b0-663b-08dab797de98
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4502.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 21:20:13.0070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fO7FM/EIgj2AYFESdJMOcBOPRsrpCxVJdZhSeeSjP7XQvkZEM9V0oWRGqBfgKFeo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7512
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/17/22 00:18, Clément Léger wrote:
> Le Fri, 14 Oct 2022 13:52:50 -0500,
> Frank Rowand <frowand.list@gmail.com> a écrit :
> 
>> On 10/14/22 12:33, Rob Herring wrote:
>>> On Thu, Oct 13, 2022 at 12:28 PM Frank Rowand <frowand.list@gmail.com> wrote:  
>>>>
>>>> On 10/13/22 03:02, Clément Léger wrote:  
>>>>> Le Thu, 13 Oct 2022 01:05:26 -0500,
>>>>> Frank Rowand <frowand.list@gmail.com> a écrit :
>>>>>  
>>>>>>> This would also require two different descriptions of the same card
>>>>>>> (for ACPI and device-tree) and would require the final user to create a
>>>>>>> specific overlay for its device based on the PCI slots the card is
>>>>>>> plugged in.  
>>>>>>
>>>>>> One of the many missing pieces of overlay support.  There have been several
>>>>>> discussion of how to describe a "socket" in a device tree that a device
>>>>>> could be plugged into, where a single device tree subtree .dtb could be
>>>>>> relocated to one or more different socket locations.  Thus in this
>>>>>> case a single overlay could be relocated to various PCI slots.
>>>>>>
>>>>>> I don't expect be getting involved in any future efforts around sockets
>>>>>> (see my following comment for why).
>>>>>>  
>>>>>>>
>>>>>>> The solution we proposed (Lizhi and I) allows to overcome these
>>>>>>> problems and is way easier to use. Fixing the potential bugs that might
>>>>>>> exists in the overlay layer seems a way better idea that just pushing  
>>>>>>
>>>>>> It is not potential bugs.  The current run time overlay implementation is
>>>>>> proof of concept quality and completeness.  It is not production ready.
>>>>>>
>>>>>> I got an opportunity for early retirement a couple of weeks ago.  My first
>>>>>> inclination was to continue the same level of device tree maintainership,
>>>>>> but I am quickly realizing that there are other activities that I would
>>>>>> like to devote my time and energy to.  I will continue to support Rob with
>>>>>> minor patch reviews and testing, and potentially finishing up some
>>>>>> improvements to unittest.  On the other hand, bringing run time overlay
>>>>>> support to product quality would be a major investment of my time that I
>>>>>> am not willing to continue.  
>>>>>
>>>>> Hi Frank,
>>>>>
>>>>> This explains your position on the overlay support and I can
>>>>> certainly understand it ! Regarding the fact that it would enter  
>>>>
>>>> No, my position on the technical aspects of overlay support is totally
>>>> unchanged.
>>>>
>>>> The only thing that has changed is that my time will not be available to
>>>> assist in future overlay related work.  The burden for this will fall
>>>> more on Rob than it has in the past.  
>>>
>>> s/Rob/someone that steps up to maintain the overlay code/
>>>   
>>>>> "production", the devices we are talking about are not really
>>>>> widespread yet? This would be a good opportunity to gather feedback
>>>>> early and improve the support gradually. We could probably even be able
>>>>> to support improvements in the overlay code if needed I guess.  
>>>>
>>>> That is avoiding my point about the current implementation being
>>>> proof of concept.  
>>>   
>>
>>
>>> I think it would be better to talk in terms of under what conditions
>>> the overlay support is adequate (for production) rather than a blanket
>>> statement that it is not-production ready.   
>>
>> I sort of agree.  Use of run time overlays has been narrowly supported
>> for use by a limited set of very cautious developers in a very constrained
>> usage.
> 
> As a first working point, could we potentially restrict drivers to only
> insert an overlay but not remove it ? It would be quite limited, but
> as you pointed out, the multiple load/unload (or FPGA reconfiguration)
> will only happen during development. Under "normal" condition, we could
> expect the FPGA to be configured once during the system runtime. The
> same goes for our PCI card which uses an existing SoC, we can probably
> assume that it is going to be plugged once for all during the system
> runtime.
> 
> This would limit the problems that might happen due to dynamic
> insertion/removal of the overlay.
> 
We would need "limited" overlay removal support to handle driver unload or device hotplug. Limited removal support will also be needed for Alveo use case in order to handle FPGA reconfiguration in production environment.

-Sonal
