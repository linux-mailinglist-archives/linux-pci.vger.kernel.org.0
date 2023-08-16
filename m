Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5661677EBEB
	for <lists+linux-pci@lfdr.de>; Wed, 16 Aug 2023 23:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346527AbjHPVeD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Aug 2023 17:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346590AbjHPVeC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Aug 2023 17:34:02 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61C6FD;
        Wed, 16 Aug 2023 14:34:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WLbQLxLCWJ9slX4l3pvDmM+0u5LgxDaZYe37U0szf8pqQ3eAeb2tGxoJM5hpSpe60+Eg6pIEgttowvqXG7qJl7MfqEXjUeBLOT58njv2GvC14w9qnyYX92V+Saa2uTeFN4LQwVb9EWsP+s2f8nDcqQVBZ28M84r5OzpWDaBc1IvC3rGKRgHI3srSozIMbNiF+Q5c+WAgYyqxMF3UfZ3lQcCKHdDWGT3fcoiOEYlac3nynTjjsvSrxhIgBoOHnULN0l74sPcsd6lTvHFt9HqqInvRI9KS87C9kvwJBZhBP9Fn/SQxPZGiQzaSpmzTkgLDgGiJwQWbak3rFMNiz5zNXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kBbt//63QnlMnso/nXIoZnVY8ZTn1suhSZi6nH0ikKE=;
 b=MwfeG9IKiW8EqKutzehXScF9o6Rz+ahDgX53tYPIsxiU2B4MGVqjyxv8/p2oJi2Yu5Vb6yXOsRm7kagWeySCs45UApu5nijObO2qz39yylHAKbXjzVvMjLTuHJlq4YChx2F3qXKaL1z6THpJTWL7OeU2WSrShpxWWqSRyztZ5KxuwFHO4b8Du8arMXirTNv5Ll+h1TuohMWdiOjw1cq3/4Z5fIh6tltujIbJPinOQAZ4Dae5AHSGmZbmlueFbC02/Ev4yq3PsHSl17ZUwk+VH9J7PTgV6j3wLmKIn6vpQKNLSWr7w82gw69HES7HRDfb9KhL3AmukTDIfjPDOuvICA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBbt//63QnlMnso/nXIoZnVY8ZTn1suhSZi6nH0ikKE=;
 b=y96od/Qx/9xNEhfH14gARFEuGyX6jnK9PquuR1ulWKAd+hn/qExmIg1kYGzXfAwV8VUjCIwPV02MeqldCaMVbShN9RQx15bKtfOdUjunklcAlNeiczFUrFIw2mAT8iONV2cut2qcmc3bZqxGjMW86r5GJG3UOER5FnTY6290neg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by PH8PR12MB7278.namprd12.prod.outlook.com (2603:10b6:510:222::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 21:33:58 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::54fc:703:94d8:4241]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::54fc:703:94d8:4241%4]) with mapi id 15.20.6678.029; Wed, 16 Aug 2023
 21:33:58 +0000
Message-ID: <674e6ba8-1e91-3e27-357b-c86252a1f71c@amd.com>
Date:   Wed, 16 Aug 2023 14:33:56 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 1/3] cxl/pci: Fix appropriate checking for _OSC while
 handling CXL RAS registers
Content-Language: en-US
To:     Dave Jiang <dave.jiang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cxl@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        oohall@gmail.com, Lukas Wunner <lukas@wunner.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Terry Bowman <terry.bowman@amd.com>,
        Robert Richter <rrichter@amd.com>
References: <20230803230129.127590-1-Smita.KoralahalliChannabasappa@amd.com>
 <20230803230129.127590-2-Smita.KoralahalliChannabasappa@amd.com>
 <20230804130929.00007dfb@Huawei.com>
 <5547a005-a492-9996-2d60-6919c3a6cc05@intel.com>
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <5547a005-a492-9996-2d60-6919c3a6cc05@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0110.namprd05.prod.outlook.com
 (2603:10b6:a03:334::25) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:EE_|PH8PR12MB7278:EE_
X-MS-Office365-Filtering-Correlation-Id: b4b43120-dc66-415f-d752-08db9ea07fae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GIqM9jVnpTAPQXQkWXmKTixFAiygWQsXASwjmuVL7iD4qLn1fC7LsjAuimpBRLViACs96GPr9OlM/EsE2yU3vIAhgz0mTnfIQuSi/VsWsDTOxiEo5cYQiWEDOtVxEnm4LhWWcDsSUrKWQHvoVnlNx5NoRqYKNNga0RJId/UnoapVjV4E8TFCfc36bmB6fbjnc7Awv0N+c8qKpaFPpx+ZELqv+eSMdipXAT3pQ7PYGZc/5cVxtisi80dcDCQPzD/8B7ddpr7nk8+mtOIdp1Exni7wILXgV8a9j5QGe1ul+HDEIpFg2P66LmyToEZ7qX90ud2m60hs24vtrN9k50DIiISVec58RN7mJCNy7gRK3a8yZk1ZjbHbk6KMT37HiT7ETwgLDD9tpkjEQ8sGS5gzkE4rZITdT1Ixb3ON+l/tVOVpaLJju70IJP9u0Q0udPQ1ystNjapndaWL9k6pnijNhyJmIO5epvJlZVTa+nPLN0bIewTJ0it9D3cOvSsUMjMA1Ih7hs5mQqPybTW00F9feliAA8HHrddTqh8O3vgUaMKGdH0rvKuGavLOarvS5HfUCAAfj7o+WVOXiUXqv0/Rpugad/zMD4JnsTNwP4wQJM1IsNPt/2GIFIJoZ25kQJBgEyOItZaubhGjYSCniJY4oQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(376002)(39860400002)(1800799009)(451199024)(186009)(2906002)(83380400001)(7416002)(86362001)(478600001)(36756003)(6506007)(6486002)(2616005)(6512007)(53546011)(31696002)(26005)(966005)(5660300002)(41300700001)(54906003)(316002)(66946007)(66556008)(66476007)(110136005)(31686004)(8676002)(8936002)(4326008)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U096b25aQWJkcVltYjVjYVprYk9KaW1ON04zOU5tbFIxcnI3Ukc3aVo0ak5W?=
 =?utf-8?B?RGY0cnlra2NlaUcyTlExbXk5cnl4QTBDZlV1N2pZKzYwVzduVHUvQTFkY29o?=
 =?utf-8?B?bVpYTVl1TFhwMFd6Tm9taXU1bTd5UDhnMGI4OGlGelIyNXZQdkFXa2I1dTRN?=
 =?utf-8?B?V25kQjN2K21iZnE3elhRT0VRdHFZOEdEQ0I5WlNUOU5tclhlQUdWOGdPY2s0?=
 =?utf-8?B?UStyMmp6MkI5VkFUL3psSmtaWHJGY2krcy8zM0l4YW1qTUZRMHlOalFWK3k3?=
 =?utf-8?B?UTFMeXNSWldWdmw1WDdPOTFWeFpiYnl5emlJM29GUldndVlET203QU55WFM1?=
 =?utf-8?B?TFF4TjE3c0lWUjhLd2NkSnc2ZjJhOG8ybGl4N0JCU3ptWGJ2YTE1S2JHaFRw?=
 =?utf-8?B?N1NsQmNVU0VibzcyQmp4U0JzQm42emdXK1gzd09CT3gxUGNjbDlZVmN4YWRv?=
 =?utf-8?B?YlM4ZSttcXlKQWlLYlBJTEN1amNTamZPMmMvalk5L04xMUh3aURBUlNFdlpv?=
 =?utf-8?B?eElycGhKM0V4akJ1R3lCcmhjMXNwL0Z2ODJvcjBZR2tVL0V1ZGZTM3hmMXRX?=
 =?utf-8?B?Q0dYR1BLVC9qR0tZUUJDa1JmdDZ3bm84NTQ4LzJrYTZGM2diRHVyQjFVcVVt?=
 =?utf-8?B?a2MxS3BKUVh1SjlCY0ZvM1JGSFF0T1VKbHRHaGU0MkcxM3kxM2NGbzkxSzlx?=
 =?utf-8?B?U0lMaW5XN1JNeklEeG4wdE1QWTlOUVNhODZidWVQSVY0M1hjZmJKTHVYM2xm?=
 =?utf-8?B?OTVJZnBUeDhqMTU0M1UvYlBaS0IzTkY0TWxxVHFuNVB5R1psUVF3UnhjV3pL?=
 =?utf-8?B?YkN4dHBCMlhjUFk3WGtaKytRUGVKeDRjOHJLTDZKUlZPaU1yUnpaS1kwSlZ5?=
 =?utf-8?B?bHdvcVNJc2RES2w4T0F0aStYb2x3MjFWcHdCdDF2OVRweWd3NVhndFBSZ01N?=
 =?utf-8?B?bHQzdmU0RUNXOUE3OFJzNU5QNkNaSFRScVAwZHhTaGYzMXkxKzZCTkI5YVFS?=
 =?utf-8?B?cTRJaFp6MmdKYnVqcWp5ODdlSmFpVklKTkx6NkEwMk5SVkJxYS9UZDdLbm5n?=
 =?utf-8?B?ei9hL2hKVi8zYmtNQk5HT2hHV29jUHdWYWc3ejhUb3VyWG1xdkFhT2ptRFJP?=
 =?utf-8?B?dmtybWFpYmFucmlVVUdiMFJyaWJodEh1THRra25oMStnaG55bWJEekNzcmR5?=
 =?utf-8?B?MGZBV0d6a3J3MndmVzdUZEVzK3dZMDIwbGhJam9FamM5NkduTXBkRytvMzlP?=
 =?utf-8?B?RzFLc2VPeCtucTNZYlBnYlZiK1pCMVVzWUVVRUduTnc2SmZYYzAycWUwam9h?=
 =?utf-8?B?c1pwV3RQMTFuWWlWOFMrd2xmUzRIYjdJQkNvUGdZNmNDaDdQQ0xwV2xwdXFU?=
 =?utf-8?B?ejdwVHoxWUVRSTF5eERjWEcxNWRmWUdwNC95TzZwZWpiY0swMlE4ci9RRVpr?=
 =?utf-8?B?NUEzYkY2WGlVRlNoM2F2dFdMVzBmbFlIOWQzUTAxdWI3bDQwcTJmeGYzb3Rs?=
 =?utf-8?B?QXdJUUtnMVFQOVJyeWZmRE5iT1B5d3pZMEZaSlBrd1JkN0Q0SWF0U01jZnVD?=
 =?utf-8?B?WG9GTkRRS1NOZHZrSllXa3BjVEw3NzB5L2l3SkJXOWkyU1l4K2Fhb3BxaDln?=
 =?utf-8?B?ays5bmhxQTgwL29JQisvOTY0OXIxVUhjeDErQW1KUzRhOEFoRmc4M0NLMWdB?=
 =?utf-8?B?R21LSnRacmpSQlY5QTl0bUMrdUdReUxrS2lQZWY3TWI3OWtaemd4Zml2em1B?=
 =?utf-8?B?UldTa2p2c1RINWwweU8vbGsrckxZZkJSSlNadXFTVTcxSWo4ZDRBY214MGx0?=
 =?utf-8?B?Vml2NlRQUGtmazZNNFpVeWpzSHpraUh4aFJ3SCs3RVl5RHVPeHl4cDFPTnV4?=
 =?utf-8?B?bUJhVjQ1VDZTVVUxLzVoZEFEbnZNVzVHdytXbjlrYWNmaXMzT0tIaWQ3dkkr?=
 =?utf-8?B?L0JLbUVpNlpldVlJVE42ZW1tYnBiWXZSWGpvVlFESUJXR3haOXZpQkYyd1pm?=
 =?utf-8?B?U2sxWkF5eG5VbjEveDhIWGc5QmdHUUdTcUI3b0Z0OEM1Y2UrajYySzZFWVBa?=
 =?utf-8?B?YWUzNFdPVlI4RU5wUHpVSTFiT0ppaXd1Tzh2ZjNqbGlFNDhzOHhIN3cweDRz?=
 =?utf-8?Q?y5nzb4KyvNCdtCa5Y/ejdR7yG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4b43120-dc66-415f-d752-08db9ea07fae
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 21:33:57.8939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G5Dfs8bbqB/M2f9Jh4pmaQu6uw7/RMdO3fiCfJqZb6riLkE5nlbv0FvxbMNNc4z4/A62FcyeR/G/MNz3zn0WGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7278
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 8/16/2023 11:06 AM, Dave Jiang wrote:
> 
> 
> On 8/4/23 05:09, Jonathan Cameron wrote:
>> On Thu, 3 Aug 2023 23:01:27 +0000
>> Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com> wrote:
>>
>>> According to Section 9.17.2, Table 9-26 of CXL Specification [1], owner
>>> of AER should also own CXL Protocol Error Management as there is no
>>> explicit control of CXL Protocol error. And the CXL RAS Cap registers
>>> reported on Protocol errors should check for AER _OSC rather than CXL
>>> Memory Error Reporting Control _OSC.
>>>
>>> The CXL Memory Error Reporting Control _OSC specifically highlights
>>> handling Memory Error Logging and Signaling Enhancements. These kinds of
>>> errors are reported through a device's mailbox and can be managed
>>> independently from CXL Protocol Errors.
>>>
>>> This change fixes handling and reporting CXL Protocol Errors and RAS
>>> registers natively with native AER and FW-First CXL Memory Error 
>>> Reporting
>>> Control.
>>>
>>> [1] Compute Express Link (CXL) Specification, Revision 3.1, Aug 1 2022.
>>>
>>> Fixes: 248529edc86f ("cxl: add RAS status unmasking for CXL")
>>> Signed-off-by: Smita Koralahalli 
>>> <Smita.KoralahalliChannabasappa@amd.com>
>>> Reviewed-by: Robert Richter <rrichter@amd.com>
>>
>> I'd be tempted to add a comment on why this returns 0 rather than an
>> error.  I think that makes sense but it isn't immediately obvious from
>> the local context.
>>
>> Otherwise LGTM
>>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Echo Jonathan's comment.
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Yes, and Dan is probably against returning error code.
https://lore.kernel.org/all/64d1b3e78629f_5ea6e2944@dwillia2-xfh.jf.intel.com.notmuch/

But I think returning zero is required as we don't want to interfere 
with cxl device access when operating in native cxl memory error 
reporting. Returning error code will basically fail cxl_pci_probe() and 
thus fail to create a cxl device node.

I was thinking a single line comment as: "Return zero to not block the 
communication with the cxl device when in native memory error reporting 
mode".

Agree? Or anything more that needs to be added?

Thanks,
Smita
> 
>>
>>
>>> ---
>>> v2:
>>>     Added fixes tag.
>>>     Included what the patch fixes in commit message.
>>> v3:
>>>     Added "Reviewed-by" tag.
>>> ---
>>>   drivers/cxl/pci.c | 6 +++---
>>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>>> index 1cb1494c28fe..2323169b6e5f 100644
>>> --- a/drivers/cxl/pci.c
>>> +++ b/drivers/cxl/pci.c
>>> @@ -541,9 +541,9 @@ static int cxl_pci_ras_unmask(struct pci_dev *pdev)
>>>           return 0;
>>>       }
>>> -    /* BIOS has CXL error control */
>>> -    if (!host_bridge->native_cxl_error)
>>> -        return -ENXIO;
>>> +    /* BIOS has PCIe AER error control */
>>> +    if (!host_bridge->native_aer)
>>> +        return 0;
>>>       rc = pcie_capability_read_word(pdev, PCI_EXP_DEVCTL, &cap);
>>>       if (rc)
>>

