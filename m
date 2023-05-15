Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 470F6703EED
	for <lists+linux-pci@lfdr.de>; Mon, 15 May 2023 22:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245336AbjEOU4b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 May 2023 16:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242991AbjEOU4a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 May 2023 16:56:30 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A230F9ECC;
        Mon, 15 May 2023 13:56:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=THkukpmu2OwePakKnb+YW4UHRluaVLon9nyButcZMlNn6h3z3Z9LQU1Rz+e238gcRPJLCbM9YE2B/pfKmQ+7PRHW3fRiv6CLo380U1JMjvUSsKHsQFM3T3jnG6BAARkL5mXnQjTOTIhQhZgc5Sz5W3Tqlwp5NuQwABvD7u3AbhJqx/DZAUyfcKkOCxvky5NjLTlDtrRisvrNLce6cVCFjyzzhPS8LE3bAwGAbABz/qOYZRZceevxVLQqxOVxo1CmvY1Q4l8pTUOKhgi9qrKZ49g1sxCABynB3tuEN0EAjRytiqwZzE1V+OHrAw1BeKfwZczlXcdq3NoHV7HOXf/tHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=40owDK9uoDhQ0EEjZdZfLTSPxtU3+qFdgnk8ypFEqYU=;
 b=WN7f+tShdN085rb3wXmjYf1ypiWqI5i4uQPBtrNT+Jtkfy1cEb25rbbGTl2rhMIreSX9xaYrW6Ta/brHk7riiXT41uffqCmOUN/JJ6hqhe8Zoa66OMeglHM+DfdOgPDqi2efZaZFEX/GHTVTtB4tPFRHFJjC/S5fkIS4j8LY7LOsHUyXyy8sitrtCyZj4Hz6B5MdMI8CgBMAWsV414dTVhHGTnkn6L8DglUewNmY+miTaE/ufx5pmwie/+TrLxVysPGi+1oKRCeKOvMHlX5eBNdL8WFcY+wQ9dXzMhEIL+yRwDozONR+Webrj7igQL4fBeMYkqCaMLGigomhSKHyaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40owDK9uoDhQ0EEjZdZfLTSPxtU3+qFdgnk8ypFEqYU=;
 b=NxUGlvCVcD6X3EWHcQ3lMjTlVeb2mjRIEc+rhzTJX99yyoyTs3dmlsChbhi1/Rn46k0S/zLfZuRB0AytN2/O+SBSvOcMa2Y4PS2v28TrEQTBUbORH2wzzX8Z0ZzXwUX8lXEE9ixvHBo5K4xOLWALMqnDWkFOF3/b5uKNrqOi6Sw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by CY8PR12MB8339.namprd12.prod.outlook.com (2603:10b6:930:7e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 20:56:27 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::8b48:9557:ef60:f7b4]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::8b48:9557:ef60:f7b4%3]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 20:56:27 +0000
Message-ID: <14ac1391-9ab9-d352-d3b1-ba6caae3d9df@amd.com>
Date:   Mon, 15 May 2023 13:56:25 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] PCI: pciehp: Add support for OS-First Hotplug and
 AER/DPC
Content-Language: en-US
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, oohall@gmail.com,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Fontenot Nathan <Nathan.Fontenot@amd.com>
References: <20221101000719.36828-1-Smita.KoralahalliChannabasappa@amd.com>
 <20221101000719.36828-2-Smita.KoralahalliChannabasappa@amd.com>
 <20221104101536.GA11363@wunner.de>
 <fba22d6b-c225-4b44-674b-2c62306135ed@amd.com>
 <20230510201937.GA11550@wunner.de> <20230511152326.GA16215@wunner.de>
 <579cb233-4827-2d03-56ad-1b807a189ba8@amd.com>
 <20230515193835.GA17526@wunner.de>
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <20230515193835.GA17526@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0290.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::25) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:EE_|CY8PR12MB8339:EE_
X-MS-Office365-Filtering-Correlation-Id: f7752140-1f08-4c13-241a-08db5586d99d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MDZx/toFbJpZZq5tKFtxgCHOYEnNEbwkv+dE2WkPejEWK+FvQpp34KPDCIxqiiLNYj+wiSUotUGtYEXzzKpejiO6bT0CqtWu3WZfiqmO1jMqS/En8RLXOr1xSGIEQMYa0JNCUV0f9bpNS9ylxg7o9rFbZZtEe8km+ZR5MZW7Oec1habZxS28G0RzE253u+A7JF9J8uSEoJrAEL3sA5uR01dKI0ordJNpPTWeqB8knC5b3Z+6gsPqpFTcXo1h5tfw6LzadUtxZv1CPsKgSZnV9ZnYGOkixvwgtAZbDj5LMsSBkpI4vTTJFxVtKW49qHZKC1+XD7e2+jEJsO89sfHz01Lmodburo2zXsEDyeTN9KnqejQQk/Uw6qMn098RW7pF4YYk2HG9wpV3MN6ygyHLdk4lpL6w1BaCWPiD9ubXtNov7qTEMBu35ThLJ8e9wCFr2zUT3SnMaEFnd+1L3SOtqRlRmacKvmJzLbzdflpiqH6dGnTbvCGzJnTbsoMrJAbp+C+tUr5LfAsP6opqOZ+1LNgSpRmBALxhE9kmlD2AsWDYYdTmHGLN213JhcrOV0y8ju5ucqU6gl0cL3HxHKc9yH7O9M1H88vY6fh34gyIfM5SRWuEXQssu+BImwaXw5qpqAsX2WxhcYxa6ezcdwaNTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39860400002)(346002)(136003)(376002)(451199021)(36756003)(86362001)(54906003)(316002)(66946007)(66476007)(66556008)(478600001)(6916009)(4326008)(6486002)(5660300002)(8676002)(8936002)(2906002)(38100700002)(41300700001)(31696002)(2616005)(6512007)(186003)(53546011)(6506007)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3RjcU5XZXlXcWE2RExjTDd1TTR1MmRCaVdLTkFYemJqb0VQNnBFRWlOVHZy?=
 =?utf-8?B?TVpHc2ZqSjJ5bStsTGJTRGllQTVvVDc2TkZhbnJpSWpXK0lSTi85dFRCZk8x?=
 =?utf-8?B?QWk0Um0rVE5DT3cyaGtFL2haaEtoN3d6MWsydnovaE5XMlFsOTZDc2Q4YmZM?=
 =?utf-8?B?dXJpTVlTS0svUnNrTWxCeUNWSDlGeEc1YWxYQmxDWEJxVHRBT3oxWlRXQmtF?=
 =?utf-8?B?TDArUGU4OGNGTGRQeFUzdlRWSFEvN1RhY2p4WVV5bHVQL3grMkxlZzNsMXBG?=
 =?utf-8?B?ZzZ6QjZyczZqYjgrem8zOHgzdU4zZHl4UGhsNkFaTmEzM0VycEp2WUtOOVZy?=
 =?utf-8?B?YVAydmNEa0xJNkd0VEtxTzJrcmRsVHlkK1o3cFBwT25GSURMMmtsL2hSaFpz?=
 =?utf-8?B?NE1La1Y3QyszWkZKUVRRc2Fxb3cwVXFqYVpGMTUrVmRNTXVCZFhFOGNndHph?=
 =?utf-8?B?VWc5M3FJNFJnR3l5dUF0Y09KVGk0ajFQOEpMRmhtdlg4WEQxdmMxbEwveDA1?=
 =?utf-8?B?b1hMOVp0Uy9Cam9QUmFNeTNmWFVDazZJUmZIWXJaU1Z1ZlMxSW9mcUFzczgr?=
 =?utf-8?B?SUFyMk9vbVRtaDVqcW9uVmxsYW1pNzVRMFhlRmRJZU4wVDFIRDFFL3dqZVNJ?=
 =?utf-8?B?Q3lGbmNydXg2QjQwdGFPc0JtYTRRL3JGV1BISjZ0b2xuKzZ0N2lkV2NQWXBo?=
 =?utf-8?B?NXVrSHJhVndJS3B0KyswcllNbUp2NmNwQjdRT1N2K0xka1ZIZmJ5bGRzOXp3?=
 =?utf-8?B?bXMzZThYZDByM1lRQVByQ0lOdFVmc24vMjk3VWFicFFJc2FOdkRhTUVEQzA2?=
 =?utf-8?B?bXJLZENVNHJGcVNwQjR4K0xKVE5JR3Mrby8xNmh3T1ZMSVJwZjFmT3hqYmU5?=
 =?utf-8?B?VTlyNGdDTGJrd0E2N0diYWU2SmJtWWx6SW1xcDk4bXNYRmthb0p0TkVlWW5G?=
 =?utf-8?B?YWRLdDJWUElRTzc0bUY5b3VHUitjVklrZ2RMZ1o2bzhLOVRlb3lJQkoxRzU2?=
 =?utf-8?B?ckd6ZCsvWlp3eWhUQUJ0QjhTODhXMTdWVm5GVVhuRXdCQkhtTEZrM0NkUjRF?=
 =?utf-8?B?RVQ2NE9XcVNMMmhaTllXV1JOZDA0MXFIa1ZpRjNXYXFFcXhzRUhQYnRCVUQy?=
 =?utf-8?B?MUV2d1ZuUkVPd2tTTytmcnVHT253TklmSG9Ea0YrYXZqejJldXdqdERHbVJy?=
 =?utf-8?B?SzdjeG5OL0lLaVlZTDhjeGpXQnpvR0tLeFZnZERvUC9CdnNQVHFBWjM4ZVdZ?=
 =?utf-8?B?UzZtUlROUE8zVjRoak9yU1ZQKzdCMnhObVdlWG1ad2tmVGR1eCtyemJocDBl?=
 =?utf-8?B?UmFGT1FNRTI2L1RlcW9OeXdKQ2tXNnNLOTVjTHFCUDZnNWtQbjI4d0dRWmdU?=
 =?utf-8?B?L2NnOXA5NzA4Z0pEN056TDZWREhnZmpnMDdGUk4zWU1kRnliTDZVR0F4V3Zz?=
 =?utf-8?B?MDEyaXlFMU9tNnJlWDhnc2lOeWkyRUFUYm1qeG00K3M3KzY1b2hhbVBCZzVL?=
 =?utf-8?B?VzM1YjhSNks0K3gzbTNPaGRsdnJHV1Y4Q2FQVDlTTVNaME9iVWNYL0FLT09J?=
 =?utf-8?B?Yko4TFBadjVLZFpjMHdROEEzZ1krN1l1c3hBcWVFQ1UyYll0M0FrcG5wNDFR?=
 =?utf-8?B?Uyt3ajhJdEdyZldJcFR2QnRqRlgwdVlPWW5MY2s0cmx2UzBpWmNtbkFVdHc5?=
 =?utf-8?B?N2p3aVUrRDVPaEYvMUcvMU1iK3llSnRJd0l6amJrQW9HRHVlTm1WS1loY3lQ?=
 =?utf-8?B?eVRBdmNpVHVOU0k5czgzTGozczlnR1hQQVVOa2JxWklPU0dTNUoxcEU5M3BM?=
 =?utf-8?B?QXplS2dQWGpBam94NmEzOVFNd2NRQ3VwNklPdUhCSEg0cTFsRHpQZDZ6OXE0?=
 =?utf-8?B?MkFTOFJ4NnhCMXpvaXpYU3k5RHhuSEUvczlDREJxUDJZN1NjYTh6OXBLSFlq?=
 =?utf-8?B?cXVZZCsvRXM1UmtMQmhBZm1MMlRCYW00Ty9xVzBiMEdmbGl6anhxQzJxYW9v?=
 =?utf-8?B?L2RvTzl0cEU0djRsVXNuSXd2ekVMSm52RElmcExBWTN2SWNidGFyemZDTWpv?=
 =?utf-8?B?L0xlR0xCeU55eEpSTjBMNGhjMzl4TG9vZTJWQTg5b29UaEVEa1lCRzIrUmxm?=
 =?utf-8?B?bXN2OW4zOXZ2Y3dWVjVBa2ZFbmRCdnRnU2tIenNTcUlpYWNqcU81UEdTc1Rk?=
 =?utf-8?Q?sh01Z7nILaEP3+QLpZAYIG8H+y7PhGqFm5UbZAX1RSMa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7752140-1f08-4c13-241a-08db5586d99d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 20:56:27.0367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0fXLnOTP4RvhlYbzLLuwDbPEj3ULYVxolMtt1mqEV5Mt8xVGalrJJ/RzNEUGGgcfdzl+GZY3sKp/J8GbHlJzvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8339
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 5/15/2023 12:38 PM, Lukas Wunner wrote:
> On Mon, May 15, 2023 at 12:20:42PM -0700, Smita Koralahalli wrote:
>> On 5/11/2023 8:23 AM, Lukas Wunner wrote:
>>> Subject: [PATCH] PCI: pciehp: Disable Surprise Down Error reporting
>>>
[...]
>>
>> I have logged in the status registers after the device is removed in
>> pciehp_handle_presence_or_link_change().
> [...]
>> Section 6.2.3.2.2 in PCIe Spec v6.0 has also mentioned that:
>> "If an individual error is masked when it is detected, its error status bit
>> is still affected, but no error reporting Message is sent to the Root
>> Complex, and the error is not recorded in the Header Log, TLP Prefix Log, or
>> First Error Pointer"..
> 
> Thanks for the thorough testing.  So the error is logged and next time
> a reporting message for a different error is sent to the Root Complex,
> that earlier Surprise Down Error will be seen and you'd get belated
> log messages for it, is that what you're saying?

Yes, thereby confusing user on a false error.
> 
> I guess I could amend the patch to let pciehp unconditionally clear
> the Surprise Down Error Status bit upon a DLLSC event.

OK. First, mask the uncorrected AER status register for surprise down 
during initialization and then clear all status registers 
unconditionally including DPC_RP_PIO and others inside 
pciehp_handle_presence_or_link_change()..?

Could I please know, why do you think masking surprise down during 
initialization would be a better approach than reading surprise down 
error status on a DPC event? Because in both approaches we should be 
however clearing status registers right?

> 
> Does the patch otherwise do what you want, i.e. no irritating messages
> and no extra delay incurred by AER/DPC handling?

no irritating messages and no delay as there is no DPC error logged now.

Thanks,
Smita
> 
> Thanks!
> 
> Lukas

