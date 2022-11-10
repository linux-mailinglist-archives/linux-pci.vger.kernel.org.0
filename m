Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A09F624AD6
	for <lists+linux-pci@lfdr.de>; Thu, 10 Nov 2022 20:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbiKJTne (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Nov 2022 14:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiKJTnc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Nov 2022 14:43:32 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2071.outbound.protection.outlook.com [40.107.102.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252C01124;
        Thu, 10 Nov 2022 11:43:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQ8s7Bbgc7p6FKnBLcoy1DvqF86b01l2N95kMob447gWSMu2b21qe5IC95+8MiwFpdZpS/cctlnJ/EhHZq2pVYRNXxq977aW5exW3cQzGuq1rc16ArcHSpoquw8wAhfs0EYb+qbDJOwbjRBoSXHFBHALkOjX5y6yNHevRcT6r2X8BW+1Xqe3ol/9tfNTfxjdC9fURjM5G9bvmj1KrTC4sjuXF9hhd92eS2VT64m00TJJDnN9jyc2woqsDIZiCejKf6Z4+59DVetlWdRdLU4EEy9cySAkq7K38BSNaGm4JY2P6VvkgRKrqfMNVXK3/rHY6fiqe5RAJ6ioIcOfB1XovA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZBsxG9szuV5AbDuzTYHyqBHOMcS0TWMIuniJfh1/po=;
 b=noB6I32wbnbWVLzNUFOBemigvPoyaoeAXbqjiBGABm6gnpEc+zEoziM8iU/pH+6WXf5voxZegR6V+0qZWxUWpCd48gDB9g2KdbavPsSo9Pt+9mUM2svGRlC3fUssCckAbYyjd1zLnCNb3WlM94Pc0l7EKZqHxBtJAMHszTHI+rR8UWtOr9TD4Wkuhi9SX2Gsskrkel6UkgwVsxlLGuUb7XONY9i1gB8JCt8lJHsHQ0JH+fHfxsIX0nt4blqB8ZQ8v1MIIOh9hwmukCb1irgYfeRx8IQodQkkgNgjohbISJ32jBTZh3P9kcbdWRE76KTxU59Pi2X1MhwFG3My+/tyPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZBsxG9szuV5AbDuzTYHyqBHOMcS0TWMIuniJfh1/po=;
 b=dim03moakWdaEGVi0MzBalYEquW+dFk+KDSXKmJ8Xm25Xs0PIBh4RNOCnrfTWRCxZca1H7h/YJMFCn7vTv5fS96gNQwzUmVNtfdfl8io9kp2uqEJ9B4hkeFzwiYW5eI71KQY2ge0BcYK8HAQmO192p2nHsPQ6S6Z0BdNKSu/IXo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 MN0PR12MB6272.namprd12.prod.outlook.com (2603:10b6:208:3c0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Thu, 10 Nov
 2022 19:43:27 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::6b84:1aa9:19fe:71a1]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::6b84:1aa9:19fe:71a1%8]) with mapi id 15.20.5791.026; Thu, 10 Nov 2022
 19:43:27 +0000
Message-ID: <52116d0b-90a1-41c7-5b3c-622fdabf788e@amd.com>
Date:   Thu, 10 Nov 2022 13:43:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3 9/9] cxl/acpi: Set ACPI's CXL _OSC to indicate CXL1.1
 support
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Robert Richter <rrichter@amd.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
References: <20221109233558.GA581582@bhelgaas>
Content-Language: en-US
From:   Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <20221109233558.GA581582@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0315.namprd03.prod.outlook.com
 (2603:10b6:610:118::15) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|MN0PR12MB6272:EE_
X-MS-Office365-Filtering-Correlation-Id: a7273f33-ffd6-42a5-f1a9-08dac353d672
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7U0Ib5bh88AqXOQqwLmtZxjMn++FDNQ1pC9TpRhO+Ojg8YlLiM5TO7X80iyWLk1TbcpFQL6331EnRmKBqRUPuakGvx2kIrqjfO6yKjPixdQveaT2vc7r1giAzaip8bGDMNEhaaY7NlT+iSRrqlkHpM3BSPfLvkVJdJp40cNBaTNIHonySffTVPHzIVp06CUZWHfg8nuBCjtlDpDjHn+nRVGsuL20iDEumfb8A8f6GjWy0J3VqO2hJsRHCmT6nBxyNg2pKbH+INOOjrIkj27H9h4aYfBIrN7JIhUcZhc+77FEXOxHy1J8ZeS4BQOP0UCBLz22ZzeSYccUh7SGfwwOn2tRu95P2iK+LKL59sn/GgacxYPCuxCiaeMM0AaXWShiW2AEDO/DhRd75vv4i8QzFnqdq2ikJuyTM0yVVX6fz5zt7frP5cvl0VSCWl0Z1fvmYB+yViAqFpy+63dNd1s8D2VCqnqUbRt5890bFAjuRcMUSPre2LVbIitFkb3oTCFyGGp3hbQUohm+fx2uHxvbLYF02QjdTgtTOm8vKql6njkYRP8HFS/86rz9DY2JMH9Tcx2Rvi8wt7L5Pt+JK1QnkA41AHFkrE6tyco1lZ0wWS3tBbpNMeUbfyyD29rulDKfhtbszt6eZ2vT0xMhNEYYRtkqYK26AH2jHZQuHNlDpEFQHc1WT+z2zYavfSvVRgObVkaVJ+X1DESKEIfI+AyYAO7FPfpdw0MdgsuS1OThFjc/5vEYnshYji4iqCOBgrj8PCwCqGeAI+HVhVTcHAluMPM/dMZyqwzq8eZweK6+kXg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(39860400002)(136003)(396003)(376002)(451199015)(53546011)(2616005)(110136005)(186003)(316002)(8676002)(66946007)(6636002)(6486002)(4326008)(54906003)(26005)(6506007)(38100700002)(6512007)(478600001)(66476007)(66556008)(7416002)(41300700001)(2906002)(5660300002)(83380400001)(31686004)(36756003)(31696002)(86362001)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2lISjFVUTZ1bHdxbFYwQ2xqL2l4Y1VMTE5aNVhNTmRxcmp5K3ZBMDhOTmVU?=
 =?utf-8?B?VFNzNFBIRWNoME5IU2dobW5aZkdQT05RenZabkVMWmRiczRjWmkrMWRvS0FS?=
 =?utf-8?B?ajF1SzFyaWcxQ3BUWXkvZGdEVFdqZHJ5OVNLKzg0emY2WFQ5TVFsdmlrVlVy?=
 =?utf-8?B?eXNPT3daU0FMbDFReWh3WG50c2Y0d2htNThaWmZlZWE0bkVtT0N0TU50Q0tl?=
 =?utf-8?B?L0YrUCtBbjVDYmJBUDltTlYwVURhcm9vcXRKbXM2ZHlHUEZVbnllSTUzMlQ4?=
 =?utf-8?B?aGhtNkxoTDJlUmszdTdqNHpPQzNNWTN4K1ZUc1RGNkRKQU9FVWFQZG1mMGZM?=
 =?utf-8?B?VGNVZEFSU1BIWTRJeE56NHMrdi95THlNUWlKb3NuZnRzNFZCckJmeEFaUEQ0?=
 =?utf-8?B?NXpYSnh0ckJnd0lGMU5rWDFCR2tuRTdmQ2E2YXEremZsZ2JTUFIwK3RJWDdG?=
 =?utf-8?B?QXN4U0hBdjJVNkVXTTdvcVRJVWZZRjExRGNNSGFQSDZEN0l6N3Q4Tkw5QTI5?=
 =?utf-8?B?cFNOM0RvQ3JDb0srbFZkV3NaS0FjSGpGblFHWUEvbzRsNHFPck8vWlhORjkz?=
 =?utf-8?B?eUdoQ3drdXFzOVdHMUZQaC8vellHTyszRHBPOXhpQmRmQ3liUjNFT2c5Ynp3?=
 =?utf-8?B?QTdsVHZkTFU5bU1FbUFFUVZ4V1RaZy9haThWV0kyV1FTTDRwaUNyUjQ4R0k5?=
 =?utf-8?B?eGY5MWxHNTJaWFUwZkwxRDRieThPMHFWRW5NOHpuc2RxYUY5bWdQa01mU0xh?=
 =?utf-8?B?NncxeExNY0wvcFFFc2tYbkU0Nk1uVHF3alFJTzRJZU9IN25TNmdkeGQ5d3BB?=
 =?utf-8?B?MUdUU3BuZHhWRlNnNzFyVlpRMVoxMXFTVmtieVc1ZTVsZWZTNnpGdVo2TnJw?=
 =?utf-8?B?R0Y2dkkwWDZQdTdQYjNzM3EzZWFvWkRXWm1ZTy9OdS9YOHQySEs1YU1iTlZX?=
 =?utf-8?B?VmQ0U3oxbCtNYWh6SFIvSG4xVVdmWllVRHFEYk0xRUMzUld1R3o1dm1BdENH?=
 =?utf-8?B?N09GU1loY0xQV1dQNlM4NUpIbjdzOEFOaWU1dldkaVJodEMrYk4vRzRhTGhn?=
 =?utf-8?B?S1NzcnF5VmhVK0NGQkwweWVRQzRveStDUFJtRHZEM3BkUEdhRFI5cWpHdFNl?=
 =?utf-8?B?cStTNFNucVI4RDNZK0ZRT0drd1llWTI3TGhJSkZsSHQxRVZ6YnBpYWFOU2Rh?=
 =?utf-8?B?MGppMnh6N0tSNGxOQ0lRbjNsY0xVRWc5cG9YU1RBak04M1I1WEZCKzlQOXRC?=
 =?utf-8?B?Mm9RRHJueVpnU2wxUnJ4NVl5R0c4UTdDWDB2Y2F2VytxNnVHZzFqZS8wQXRy?=
 =?utf-8?B?NEViUDNHNlVUbGNDUEVjK0VOMFBkS29qS01PQUZ3M1BDTEV5b2RHV0dsVk03?=
 =?utf-8?B?WWYvS2JuU29OVkM3SFJUOUN6QXBzc2Frb0g4dUsvTW1NaU5IbW5IY2hwRlpQ?=
 =?utf-8?B?c0xwbnVYZjIvZXlyZzZhTGtOZmdzbkptQkhDc2RRUG9BOU0veFhjdUpPb1lp?=
 =?utf-8?B?L3BlK0FHSWtlRnZtajJpQ0tlV2tKWHpYRGZ4VkU2WWVJblRTYUxLOUJscW44?=
 =?utf-8?B?SlNZNWtPbUdoYzdQSXh2NlJGZFNoWnVzcmJiSEFFYUhtQTkzQWF0WDA2UXlQ?=
 =?utf-8?B?aktPVGt3Q1BuS0Qrb1lWYzU4YTZxN0pHTE9wUU9aZERRYk4yWFNyMjRveHRr?=
 =?utf-8?B?SWlYRC9xQzRCa1h5Y3A5VW04d1IzVkFFMkQxNTFHaE1iYllPK1pRcC9FR0RN?=
 =?utf-8?B?S3NDSVMwajhyZ3N5OUZ4YVBuUHdPNTR1V1NPeHZRbHo1eGROclF5VC9PaVlX?=
 =?utf-8?B?VHljZjYxbWVQR0FJa1ZoU0o0NERUUE43RnVTUnZmNU1wSlN2bTJ6VnNBOHFm?=
 =?utf-8?B?Z1JjYnplYXRyTU1Pd1lJbmZndXgzcGJBWlhSclBTLzRqdEc5dTZPU0dXRHBw?=
 =?utf-8?B?M1dyNzF1aHhIbWE2WDhRbVBRSlNzbnpvWU8yeHczblNGVFoyaUEvb0M1aC8x?=
 =?utf-8?B?dHhZdlVlV1RRaHRWUFlyVmVrUVV5K2xCNWZJaXRTZEMrbVJTVzlXcmZQMWZh?=
 =?utf-8?B?dDZ1bGtVQ3Z1UjJmcG1wZ1JhczVmdm5uY1VXSzR2dEZjSDdnZHdXUlQ3b2sr?=
 =?utf-8?Q?VeuVZQtMehcKVQWrv8E9i7TBN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7273f33-ffd6-42a5-f1a9-08dac353d672
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 19:43:27.6561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hwpHdNPp0ZAwOoXpytecFVEBaQqj/Pn6YUI7lBmBaRyXlipIqSRTvJOxu80vxJ7eu02OvibQwwmbveKsbjpn/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6272
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 11/9/22 17:35, Bjorn Helgaas wrote:
> On Wed, Nov 09, 2022 at 11:40:59AM +0100, Robert Richter wrote:
>> From: Terry Bowman <terry.bowman@amd.com>
>>
>> ACPI includes a CXL _OSC support procedure to communicate the available
>> CXL support to FW. The CXL support _OSC includes a field to indicate
>> CXL1.1 RCH RCD support. The OS sets this bit to 1 if it supports access
>> to RCD and RCH Port registers.[1] FW can potentially change it's operation
> 
> s/it's/its/
> 

Ok, will fix.

>> depending on the _OSC support setting reported by the OS.
>>
>> The ACPI driver does not currently set the ACPI _OSC support to indicate
>> CXL1.1 RCD RCH support. Change the capability reported to include CXL1.1.
> 
> Eight instances of "support" above seems like it might be more than
> necessary.
> 
> I don't know the history, but OSC_CXL_1_1_PORT_REG_ACCESS_SUPPORT and
> OSC_CXL_2_0_PORT_DEV_REG_ACCESS_SUPPORT seem like sort of weird names
> since they don't match the spec at all ("RCD and RCH Port Register
> Access Supported" and "CXL VH Register Access Supported").
> 

I'll reword to not excessively reuse 'support'. Thanks for point out.

Regards,
Terry

>> [1] CXL3.0 Table 9-26 'Interpretation of CXL _OSC Support Field'
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Signed-off-by: Robert Richter <rrichter@amd.com>
>> ---
>>  drivers/acpi/pci_root.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
>> index c8385ef54c37..094a59b216ae 100644
>> --- a/drivers/acpi/pci_root.c
>> +++ b/drivers/acpi/pci_root.c
>> @@ -492,6 +492,7 @@ static u32 calculate_cxl_support(void)
>>  	u32 support;
>>  
>>  	support = OSC_CXL_2_0_PORT_DEV_REG_ACCESS_SUPPORT;
>> +	support |= OSC_CXL_1_1_PORT_REG_ACCESS_SUPPORT;
>>  	if (pci_aer_available())
>>  		support |= OSC_CXL_PROTOCOL_ERR_REPORTING_SUPPORT;
>>  	if (IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
>> -- 
>> 2.30.2
>>
