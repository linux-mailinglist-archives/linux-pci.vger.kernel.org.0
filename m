Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C0B675A0C
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jan 2023 17:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjATQdN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Jan 2023 11:33:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjATQdE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Jan 2023 11:33:04 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C57CAD3D;
        Fri, 20 Jan 2023 08:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674232342; x=1705768342;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YjNkfHk7wUa3R7nqackvtKUJJtFqYokd7NEkX4S2Ljs=;
  b=GCYj62axmgpLdnTrk2skvRdBniCPgvVhUgf00vTwZOts6T85q5ovFAat
   IlFT6OeIr9CvQoKzUPwk9X3Pf7OXBR9mz4U8x6RxdfryxDhoAtVYzA8bf
   DQ6DQtR8JCfGokp3Mgq4+yZ7KIXpFPyxAu3kE97lwFZ1UgV2+mrt2C/MQ
   t68h38u+gZHZfAPl+S6L8gDkiKOls2cId8Y6D4RpdB4f5i11l/00TScq+
   IUUniYJtlU37UomsEURI2fbzUEPtb+ZcOidTwWBIYAR8ZJaUEfhflxz/A
   It/xNjY8qCAuHnXpsE0iqfRxBfcpVb4tZrkgVwoCboOaBowcgsmkILWXe
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="390125134"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="390125134"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 08:29:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="662590477"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="662590477"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 20 Jan 2023 08:29:01 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 20 Jan 2023 08:29:01 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 20 Jan 2023 08:29:00 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 20 Jan 2023 08:29:00 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 20 Jan 2023 08:29:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K854xRGt40nn6gm07sch7VeMDDOS8Ll8Jd0XO3wwoG+vg3v1n+cgeOxbFZVJUZmt9DVh1XrnO3taMULsbFE+XFEOE5sp2VGYSQF6PTzdbjbk9Mzb54sk5eumKu2d//N1bae9jDszKsQQ6G4FQcM9hz7RIzl3Ou2l3WrgYAORuqORIeP4h4Ncg6AbNfL/zAh82SD7kO7VWV78KiA5EzC9FL+HFfTjM6uVlvKBhjLWaK228J91wyPDo+sMdkb3iGIw6UdOFDOQarpZnefcK6Y7xABgJzYaRQ+5nsiAJsYbaLDaM+MVLyPkHIG5COlF4nkuwc6p7/RXnhEf6V09vY1hug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WomJW0lsqxwrlP1ZCtuWWquswgwcCALRVllJdEczBvU=;
 b=oFY91KR0ziPRfTmS7lh82eQK+z6x8fQ6jGqqSawVvvbUOlt8IpC7xq1ho2nGjlfls+GXWXW8FGtMz54FZgfbjMg0MfrsMJ7o3w9bSCa6IbZE1XpoFO7TcVlka3pmC9xw1SnjVuSCFrMRQiSuy1S5MhJ+ILiO34E7RNU8LfQ41HlUrLaEUNi3ei0egYObHPhxeQUlIs0QbmLBBNCj6IpPhSL0Ho0K7hYbLILborTR/vXQn1iZ2XSpqR+xg3C5ecDi8YrqRFAbBjw8156YwDdmgMd/7/sFZSZgT1znNNC+bRVwktbk/JFmP5FYVgXD5myDgv8/3DRh265R3XqvKmitXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM5PR11MB1899.namprd11.prod.outlook.com (2603:10b6:3:10b::14)
 by DS0PR11MB7335.namprd11.prod.outlook.com (2603:10b6:8:11e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.27; Fri, 20 Jan
 2023 16:28:57 +0000
Received: from DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::d151:74c0:20d6:d5fc]) by DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::d151:74c0:20d6:d5fc%6]) with mapi id 15.20.6002.027; Fri, 20 Jan 2023
 16:28:57 +0000
Message-ID: <a896be81-e482-9d52-ece5-a2ef28822072@intel.com>
Date:   Fri, 20 Jan 2023 08:28:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH v1 00/12] add FPGA hotplug manager driver
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>,
        Tianfei Zhang <tianfei.zhang@intel.com>
CC:     <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-fpga@vger.kernel.org>, <lukas@wunner.de>,
        <kabel@kernel.org>, <mani@kernel.org>, <pali@kernel.org>,
        <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <trix@redhat.com>, <jgg@ziepe.ca>, <ira.weiny@intel.com>,
        <andriy.shevchenko@linux.intel.com>, <dan.j.williams@intel.com>,
        <keescook@chromium.org>, <rafael@kernel.org>, <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>, <ilpo.jarvinen@linux.intel.com>,
        <lee@kernel.org>, <matthew.gerlach@linux.intel.com>
References: <20230119013602.607466-1-tianfei.zhang@intel.com>
 <Y8lGxqjuLS8NfJtg@kroah.com>
From:   Russ Weight <russell.h.weight@intel.com>
In-Reply-To: <Y8lGxqjuLS8NfJtg@kroah.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0381.namprd04.prod.outlook.com
 (2603:10b6:303:81::26) To DM5PR11MB1899.namprd11.prod.outlook.com
 (2603:10b6:3:10b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR11MB1899:EE_|DS0PR11MB7335:EE_
X-MS-Office365-Filtering-Correlation-Id: 7719baf4-8a52-4313-211c-08dafb036d8c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0zW8T5NO9j3Urkn1nZwxQqwhH9S6MScoZSpsJxcJ9m/Bu1xBfcANHR/lrdpheqLg7iqixEDokvMRU4BTAAiWB1HJE6S5N7n6p8Nlb9MSJLyEdqAyMVTcYxwMKn8bDM4DkUNCLMWBqkVf+n6IP1Iij4pcwMIU61J4Xa+YKWtzEV6NyMRWALQ3G/+YRa/OZ58LTsLcgPBoasatsTEmwpPJg7ri0YB7kYexQXRTbXeeRVu52C5rrZDWXvlJTVBmZhUqxTYiF1CFEa3OOWPGNO3xivrrc5gvZSi5vT4lPBNEufqmHLzJ9ssU9bNy1PsH2jauP5L1nM4PIaD/GGmPj5jx/fdrNNwTxjribS3uFUSac/gWEw5TdLUj28jpZz/UozwGoWVKEL0Zl0kvmTT5omfiUP10uGp2mB+zxjJnmsprIIm9cpmM4lfarp6EQ33EY6d7+gw5cf7nTjqEizoxddDi+bBJN95RLSMY77jLxzykNCCn7XWWw+Xnew/XUDqiWjckYUdEqi/vJa1Lg5CnTjVJ/xuKO/Vu7qonLy1f9WSlstLc5vYmhGYZremDLwAJjXBgFMctlrfbzBKWUCkED2o+Zxza8/M1Xsn3FrcAkG34wrSOYbsFfPHtkmUduM090ljJR9++28BQs2zSSXQV5T5j4mRbj1rNy0CfzUNQoMBXJAbVIGALf7YlVnKbH820QHG0lo6Gsvgca4uORnOtncsvGkI4tGbKlP4yRF9BP9Bss7g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1899.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(376002)(366004)(39860400002)(136003)(451199015)(186003)(2906002)(26005)(6512007)(110136005)(6506007)(2616005)(6636002)(6486002)(478600001)(316002)(36756003)(53546011)(6666004)(38100700002)(31696002)(82960400001)(86362001)(83380400001)(41300700001)(4326008)(7416002)(31686004)(8936002)(5660300002)(66946007)(66556008)(66476007)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3NkUUtXc0U1SU5vRDBFbnk2K050Q09Md1h5SHM3eEFlRDFCM043S0h1cmVn?=
 =?utf-8?B?N01TeDJ6ZVRJUkkwcEYzeUpSd1FtMDE5ak9BaHl2ODVsS2xnWGE2TzNJQlhZ?=
 =?utf-8?B?ZUoxREYrQWRDNDFuZ3dTeFNnVDB3MndlQU5ydVV3RDVIY04rVlFodXJBOC80?=
 =?utf-8?B?eDZINlI2WlBGRXVsa0NocGRLTm5jcHpHL3hyZy9Ed2ZwTWlwcjlLeE13WjNl?=
 =?utf-8?B?VFUrZlZNWFZST3h3Mm8wWUZtTm5JSnhnMWhaRVJZbXlqODhPcnVtakxhbllz?=
 =?utf-8?B?eDAxUGxGc0tnZHJGQWVMcnpwc2Q5QkFrNjlSTnRDNTd1YUg1ck12N0d5SjdC?=
 =?utf-8?B?bWJkNGJHLzNBbHpXM3pkbXRXYnd4MlAxTGlIZHF0OGNiRk5XY3J4MTMrNjJn?=
 =?utf-8?B?Tk9zbGpOa1pMayt0dGJRTVBuTG1RbFpmdEZpeTM5aVZCRXFSRUxDbG9mdGpj?=
 =?utf-8?B?QWxjSGpYUk8zTjBxZ09EVENoQzdHUVRsZUhjdit1c1BTcTJneWdmTmxQcTNi?=
 =?utf-8?B?RVB3c1RORlhqeXZNWnFsdlVMYTFXRElMWnYxRk1uZmRJV1V2MmdQS015SnNC?=
 =?utf-8?B?OXdSajFna3F2TWJWRitvNDRLSm5hUmtyUlZZaUt1aStGbE5jK3RsTWROeGE4?=
 =?utf-8?B?UVhOaHRKY2ViSjJSVERuVGtQcmRVWWR3OEFBcG82dXJlVWtjcjFZRzNiUWZp?=
 =?utf-8?B?N09KWkRxZGY1U2h3bHRrSDR2QzFrYVdHZTM1cGdtVkYxRVR3ZnA3K004S3JE?=
 =?utf-8?B?SzY1bnMyRFllek1sbXdUU1FySWVEelVoQU5YRFJDUzdzWjlDaEpXOWdPQWQ5?=
 =?utf-8?B?NHpIN1c2c08zM2xjcHhoUXRrV3JHZXBWaUc0K1FJdCs3T2RIR2VGMEZIbGtJ?=
 =?utf-8?B?TWtFUitLamk2U3ZMRHltRG9uRy83K1dJN1N1QXdBR0s4Z3N3blVHUktKalVN?=
 =?utf-8?B?SE9XdkdrcERxRTlXNklTeWl0OTBpRkxFdHFzbS9CY0dkZkU1TlBkM0NmbWk5?=
 =?utf-8?B?dVhsSFpBVFNGbmQ4Z09FT3hpRUdqVjRsdElTcTU0N243ZC93RDFjRzlqb0d2?=
 =?utf-8?B?SERNNXNiWXJpRnNERDlQVFkwQk5wTksrQ0VrSkhBQ2YvS09Udmo2WGtXWjNG?=
 =?utf-8?B?dktySndZUEg3R2twTVVVUWp4LzhsdUZjSEZlcVRvTzdxYWdKRlk2aGMwekxy?=
 =?utf-8?B?b2tSZy9qNzVHMmhqWnpTbWpJeGs5djdoWmo2T2IrUjBvTFl4Y3ZFUXl5NGEz?=
 =?utf-8?B?cEFwTU5BNUowQlNmbzdURUFKbUpMUnoyY3cwbEVyZnlwb0JtbElmWklzR0I1?=
 =?utf-8?B?V0ZVdDJ2VStRbWFYQS9mZWtkcjgwVkt4ZHZxUllNSkhTamVIbzExV2ZlaklG?=
 =?utf-8?B?c3hXSXNBdlpPQjVvUlhKTDM3K21yRnBRT1czSm5heEZYU0crQkpBOStMOVYv?=
 =?utf-8?B?dGVTR3V2eVhLaElYb251dTdGNzBMaWl0L2lsb0VrWEhIYWN4TmZwT0luRXg1?=
 =?utf-8?B?VDlkK2svajFYRUlvN0pKcGdxMEt6ZFJmS1dxZ3A0bGJoTEg0Z2tpWk9VZjBT?=
 =?utf-8?B?S3Z1a1NFY2dQQmdCTzBDM1NDb0JvbnBiZFJPS296Z0JiSDRnbUR6YXhXZmJV?=
 =?utf-8?B?Y2M5ejllR2lZeXVaMlltaENUN0RRODJIV2pad005Wmlrb3RZQUZFdFNXL0xF?=
 =?utf-8?B?ZVZJQTJOdmliZVFmbTRrd24xU21aR1dEM3JGenl1NVNDY0J4TElsOEVEM2JR?=
 =?utf-8?B?eGl2MkJzcVA4SEcyTDZid242NTJvNUhDMmpjMEZCMjh3Ui9aN28xYlVCKzRz?=
 =?utf-8?B?TUZKQmZnd0VPd01rWjJ6MkdQL3VSNm91dEdqZkF5SW9vb3pnZHk0ZzVSdXA5?=
 =?utf-8?B?bHJiakc4K0gzTjZFY2FoOTZQdVFOMDFZeFUxQVRDRTVzcDJ5Z1EzVVJkZGlz?=
 =?utf-8?B?WjVzZ3NyZTh3V2FYRTJIWFJlM2VnT2NQMVFlajlTOTBGNkI2Z3pCM2xBR2pQ?=
 =?utf-8?B?MVlWZkJSY1JmeTh5VmVlZkE0NXpiTFFYVERNZ2xKakQ4L1Y2M2hIeU5oTDEv?=
 =?utf-8?B?R3RjbVFRN2VNQ1BURlhSL2VGK09KM0RyM3VVT2g1b1R4U2JDUForV3BrTjRC?=
 =?utf-8?B?eVd1dHBKQmxFMmlZTk1pTUZUNWZsa1dVVitDUlpUTkdmU1BXbHFGRmlZZzZZ?=
 =?utf-8?B?bkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7719baf4-8a52-4313-211c-08dafb036d8c
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1899.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 16:28:57.0532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: toIRzUiPUibJuQtJQ+kb6JVBVluedXzCX8X2JLrW75FJJ7zKH0WOnEOH2uNAKrO5WkjvGfkFVoSFBraV+U5y440XTbJrS2Dd9YFyhSH6Rk0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7335
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 1/19/23 05:33, Greg KH wrote:
> On Wed, Jan 18, 2023 at 08:35:50PM -0500, Tianfei Zhang wrote:
>> This patchset introduces the FPGA hotplug manager (fpgahp) driver which 
>> has been verified on the Intel N3000 card.
>>
>> When a PCIe-based FPGA card is reprogrammed, it temporarily disappears
>> from the PCIe bus. This needs to be managed to avoid PCIe errors and to
>> reprobe the device after reprogramming.
>>
>> To change the FPGA image, the kernel burns a new image into the flash on
>> the card, and then triggers the card BMC to load the new image into FPGA.
>> A new FPGA hotplug manager driver is introduced that leverages the PCIe
>> hotplug framework to trigger and manage the update of the FPGA image,
>> including the disappearance and reappearance of the card on the PCIe bus.
>> The fpgahp driver uses APIs from the pciehp driver. Two new operation
>> callbacks are defined in hotplug_slot_ops:
>>
>>   - available_images: Optional: available FPGA images
>>   - image_load: Optional: trigger the FPGA to load a new image
>>
>>
>> The process of reprogramming an FPGA card begins by removing all devices
>> associated with the card that are not required for the reprogramming of
>> the card. This includes PCIe devices (PFs and VFs) associated with the
>> card as well as any other types of devices (platform, etc.) defined within
>> the FPGA. The remaining devices are referred to here as "reserved" devices.
>> After triggering the update of the FPGA card, the reserved devices are also
>> removed.
>>
>> The complete process for reprogramming the FPGA are:
>>     1. remove all PFs and VFs except for PF0 (reserved).
>>     2. remove all non-reserved devices of PF0.
>>     3. trigger FPGA card to do the image update.
>>     4. disable the link of the hotplug bridge.
>>     5. remove all reserved devices under hotplug bridge.
>>     6. wait for image reload done via BMC, e.g. 10s.
>>     7. re-enable the link of hotplug bridge
>>     8. enumerate PCI devices below the hotplug bridge
>>
>> usage example:
>> [root@localhost]# cd /sys/bus/pci/slot/X-X/
>>
>> Get the available images.
>> [root@localhost 2-1]# cat available_images
>> bmc_factory bmc_user retimer_fw
>>
>> Load the request images for FPGA Card, for example load the BMC user image:
>> [root@localhost 2-1]# echo bmc_user > image_load
> Why is all of this tied into the pci hotplug code? Shouldn't it be
> specific to this one driver instead?  pci hotplug is for removing/adding
> PCI devices to the system, not messing with FPGA images.
>
> This feels like an abuse of the pci hotplug bus to me as this is NOT
> really a PCI hotplug bus at all, right?
While it is true that triggering an FPGA image-load does not involve
hotplug specific registers to be managed, the RTL that comprises
the PCIe interface will disappear and then reappear after the FPGA
is reprogrammed. When it reappears, it_could/_/have a different PCI
ID. The process of managing this event has a lot of similarity to a
PCIe hotplug event; there is a lot of existing PCIe hotplug related
code that could be leveraged.

As alternatives to the idea of creating a hotplug driver, we have
considered creating a new PCIe service driver specifically to
handle FPGA reprogramming, or modifying the existing hotplug
driver(s) to add FPGA support. We have also considered a separate
fpga-reload driver that would not be bound to a PCIe interface,
but would still leverage the PCIe code to manage the event. Do
any of these options sound preferable to creating an FPGA hotplug
driver?
>
> Or is it?  If so, then the slots should show up under the PCI device
> itself, not in /sys/bus/pci/slot/.  That location is there for old old
> stuff, we probably should move it one of these days as there's lots of
> special-cases in the driver core just because of that :(
>
> thanks,
>
> greg k-h

