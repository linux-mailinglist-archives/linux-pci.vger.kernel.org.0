Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E522577FDE3
	for <lists+linux-pci@lfdr.de>; Thu, 17 Aug 2023 20:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354201AbjHQScI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Aug 2023 14:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354440AbjHQSbl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Aug 2023 14:31:41 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737ADCD;
        Thu, 17 Aug 2023 11:31:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TQdLXx4I5LeXjkoQmeQ+KYVsuj1ONk/0k0Nppz2pcFoSKyqWlDklDuDu0d7C/IGUivg7F385gm7zKpkA8UhSd4CaCS2AxujY7nRvDMU1hfjWNHtFmCVeHpZtvfZR4Wm9Jdts4Ehj5JND/Ai3uN8UbMWbckWKKtnRVi64KCUVfRS74cQSY13YPIHmzMU8kOZWkqsisxKxgkh7QUfJv8UqHIs1aHZ9o9vqLLNvuSO2WTiqUGPPPnES69sY6+JF4UEceT7AtO5oR5vn7ROSzL4eSFJx+nSkFUT2olxzFnwQO8+2ApixgEVlHJ/XZ1duZd8wU1k/KWCqEER5ME4+NOMd6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C5q5tOX5q8ziD59BehzbMSkwgb5RwtISLNUyMaJmThc=;
 b=U6nF128txw2Y38HviOmm6vK78BAFawo38Bn3EUGewZV6+Yy4WVaCAsfUeBJg1Fs+wuoF3RHYmb6VkJgswSztNkg1mVy5ut/l+AUnkBoif7/sL9V7jcDXjMPKkw6obVYMIRj5h61cEWewixCYAUG7zx+hWCWG0V6iCoeWMpfJBKuYL26UsfRCKXHCmudnPXJz09CQ1Drl5J6VUI+JUlRg0bJITNwcLya6/4egvlkJgkDTDiT+erlAyLjQF+85PmMYr56NZDCHuItAoPvQ3LIqXrhNT19IIOJyViKDIMM2JzvZBfOcJ5xSaqxaTxIecF5oMX8Pr5PwpzdUfiIl9yUGgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C5q5tOX5q8ziD59BehzbMSkwgb5RwtISLNUyMaJmThc=;
 b=PKJ+YqawOde9Pm7CurNvRokXL6iai+X8lDCYwWTbE7yU75EA4cLctZvJ6/p1yFoDcOi4AzqykA+zQ4NIUHRE0AdS7Ge9nGOoC1Y9qzCPvhIV9WasqihIGyiG/lb6uY+8VkbRu7d7O3UIsqpoAn02A5YOf2Z3wrsDeiC78x6TIes=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH3PR12MB7666.namprd12.prod.outlook.com (2603:10b6:610:152::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Thu, 17 Aug
 2023 18:31:38 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6678.029; Thu, 17 Aug 2023
 18:31:38 +0000
Message-ID: <4ac4ee07-9328-415f-a4e8-30dfd9c10fee@amd.com>
Date:   Thu, 17 Aug 2023 13:31:35 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 9/9] PCI: ACPI: Use device constraints to decide PCI
 target state fallback policy
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Iain Lane <iain@orangesquash.org.uk>,
        Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>
References: <20230816223831.GA291481@bhelgaas>
 <6a91a3e1-61a2-4f33-ae01-ea4b5ad24ec6@amd.com>
 <CAJZ5v0i46b2th2iATB-Zsfhexcva8h_KAxYtUsGDHS_3zXnn-Q@mail.gmail.com>
Content-Language: en-US
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0i46b2th2iATB-Zsfhexcva8h_KAxYtUsGDHS_3zXnn-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0128.namprd11.prod.outlook.com
 (2603:10b6:806:131::13) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH3PR12MB7666:EE_
X-MS-Office365-Filtering-Correlation-Id: b2a774ce-d0a4-4253-de8b-08db9f5031a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OTJN6CLmmxC3w7AQ4PFEPynIeEzQVq0gR6YmMYoaMMp26d3yansRnR9Sxo39OIVGBtjBBWZpVU64+Vx7vTbpnS7Z9KFFX4KPBTftl+P7Q/ZhEmicbYthDhCmlGEPuXL/RNV+ddbkGNink9vZiu9MnlSPItJ7Yf6l4sFQAahxf3Bm7eJci1h7qRH8aHAC6p/eeGwmLqAqZ8tC8xq+yngIrBrIC8lESjAjYC0rSEL4x4XG1R4kMzcy/nH0no3yNsF8hVokTLUF9tgrvX1zmlyu6/IBoXkurPtzei0Xhm2Rl2deQjQZ2Y7jACx5eUAjl6B2jgGVAxbwyVFvNwfW2v2F8mauUDF9wrrhpF2tetkwkHLALCcOb578YgyVrReRU0qpsKqXF174Lmm0DAcLQ1cW+E78Oz26ma6+TsqHHrbqmjVGwkoIUeJzW0aNg53oW0Mp4++Ytxl7VnOeshUftoz+5XEdaC+0nqiQt1rEnUjROijs7Wb/5NGbEKI6Vu941MVnU+sfdjD/jo2KYlO9wKVoeasU3MqARA1NofxWgn2wNHEuma/Evvx3A126a9aplf3cO7B9Q451hhKwCXeuLh3iaWSkZuDFmZIF42TyfWk6ANwXigW+Dmu5eol8B7bK6ghbSbM3Vl509kZqoMZ9BBPoNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(396003)(366004)(136003)(451199024)(186009)(1800799009)(316002)(54906003)(66946007)(66476007)(66556008)(31686004)(6916009)(5660300002)(41300700001)(38100700002)(8676002)(8936002)(4326008)(26005)(2906002)(31696002)(4744005)(83380400001)(478600001)(86362001)(36756003)(6512007)(6666004)(6506007)(6486002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTZkSFcyb2hnbU80UnBtRmpWSjhMbkZHYWVhWjUrTnJxaGZuZEVHWU9wOUV0?=
 =?utf-8?B?SjlNZlhsZ1dvQUpaTEhPQmYrdE9EZ2dRb0h0WS9ZbkM2NTBGSWQvTjBuTG1K?=
 =?utf-8?B?dU12eEN4WnNzQnlMa3V4M2JjQWtsSUNMNEgrVWN5YmhBS3ptQ0lmanNMbEpB?=
 =?utf-8?B?dGRjUVpEaElzbFJYMGgzOW16MkxFOWdjZlZsbHRWYXdNc3NmTXRoOTVPTnBK?=
 =?utf-8?B?c0FCQVpzMm9ZYm1qUlBlL1JrTFR6VlRjN2FaZERhQnVjcXNKOWcxdU9yQWNL?=
 =?utf-8?B?MmdpQmlob3ZzTGJPY2E5ZWhyQVVRc0s2WE1VV1Z3L2Z0WjBKaTMwQ1cwY2or?=
 =?utf-8?B?bmFmcnNsT0o0TTc2SXdFNFcrV0h6SnBZWVJxNkFSbzhkMXFiL1dzZERlcDM2?=
 =?utf-8?B?b21sUmgrUlpxMkRIREV2ZXczM0lNWVoyVUV6emxZZVpmcG1USjlKTGZ1eFQ4?=
 =?utf-8?B?UkVOSGpGdnlVN2RyNnVVckVJRDBEaFZWSEJVZHBvSXNnUWdoYVJnRHhqbkZG?=
 =?utf-8?B?VXNBY0xaVk1vK0lWQmcweDNUSCtZTWIya1Rhb0dRdUlhcVRiS0I2QmZRZ2Zm?=
 =?utf-8?B?UlgzS2ZXL2IvS1piUjZ6Uk14aVkrZzNGSytzUnJ5Zlh5ZlN5VVZwVlNncE53?=
 =?utf-8?B?NWxVczVXeXFpWko3MnpNUDVFcUNRTE1oc0xaM081aHpra0FVeDNNWHROUEIz?=
 =?utf-8?B?TmRTdjlRcnZHb3IvT1ZyYkN0WDcwR0xmcU50TCtYQVd4WktkcXNMcTI1Sjlp?=
 =?utf-8?B?RzZHanBvNWZUVnlWSXEzSXBIRHlGMDFENVNhdnFBSm52Uk5rc0I0U0xGbVRm?=
 =?utf-8?B?UFY0NXNrRTFlTFZxNG9IQW04TCs2NnJLa0ZvcDgyWFU5YUVvY2dvbkJxRis2?=
 =?utf-8?B?aHhCOXRUbkhPemxqWS85bDNqSitwakhhdXY1UlBvUVhQdzFqbEJQcFg4TWlI?=
 =?utf-8?B?eGNiRGtzTkRHcTRVcm96SVpZRC9rRk5NM1FYdE1BdVdyK2N4Z2tSQVJLMU5K?=
 =?utf-8?B?MVpTdlJZZ2JsTFJOMjNoRFpkOE05VTZsYzM1aTc2dTZPMU5mdUh2OUMxMVVP?=
 =?utf-8?B?dDBCVjJVcWNKdkQ2MU43SnVFVERDZWNLRmtJSHJrOXluRG9yQzBLdHJidENo?=
 =?utf-8?B?RFhZeEoxSGhzaDZmMEk3K3hJZXd2ZUc5NXBLVWIzU1Z4Zkp0OFpqMkkwOXRt?=
 =?utf-8?B?ejRGMWFWckQwUUJSRU85SW1aMjREVkptRUxlb1d4Ukt1NlhFbFBsNnZCQi83?=
 =?utf-8?B?NWhQbVdUT1lHUkdMcHdvdjlEU0VEOEJ3VFJmMmpaQjI3L3EyMDZ5ZjhHcmNi?=
 =?utf-8?B?ZU41WTZwT3hXT3dLVzdSWDRmNjE3SkN4Q2dLeGFjZ2VLRFdmZndKRG1kTTI1?=
 =?utf-8?B?dTk5L2JDWW5odllzUldtRzdGR0ZaOTF1SjkwSUNkN0pTWU5HQ3A1UnRXa1A4?=
 =?utf-8?B?Mkdhbk00L2UzcVBOUGpoSWhMUGNjekFaMTlQWUNzWnNzdU1jUDUwL1Z2QXQv?=
 =?utf-8?B?Q3FhYmpXTDQrN2xqVkIvdmpPN3Z3VFlCOElwK0VJVy93Y2grbzJybGdKZ05I?=
 =?utf-8?B?YkhmYnFaaFFYS0R3MTRFSHR2WXB1ZXZ5WWhIQS8yZk41a1JBTERWeXFCbmNH?=
 =?utf-8?B?N0xRVWdNazJQV01UTU04dnBFVjlOaGJTVmtkK0JGNlJOdlRleEo1OGFKUUMw?=
 =?utf-8?B?VDZSc215akZCNThvRHR0dU9EaXFsS0hEbWN1TFJkR2lwTjkxbnRHSjZnblA5?=
 =?utf-8?B?RzQ0RDgwNjltVEhnM2VKTUVWdUhTVTRFTkVNR2dad1hROUtQTTcrUXVHbXRi?=
 =?utf-8?B?cGRvVlV6MGxDK0xiZ2tJekg1K0xkRm1WdE5sbUh4U1NDaTE2MG5rUVB3bjJp?=
 =?utf-8?B?V21zd0tkUnhtMUdxcGNaMUVkdTJpQ09zYmRIbmRrNml3UDJTdSt3b29WRllv?=
 =?utf-8?B?M3NBNUFCZE8wZUdGbEVLZU9CVy92enk1cXZvRDBUT0c3T1JMV1dld2VOeitk?=
 =?utf-8?B?eWRlTFNmVTNiMG1ldVc5RU1iellVRm9aWUQ4N3hiQ1RVTDZHK1hPbHBqN1FR?=
 =?utf-8?B?L2hlVWU0Qk5OS3Avb2ZCcnh1aGl6MFE0S0hRZEF6a0N6WlF1QUx2OTEvbkll?=
 =?utf-8?Q?6RHol0Rrt6O4m5yTPWux+ZJCC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2a774ce-d0a4-4253-de8b-08db9f5031a3
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 18:31:38.3771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aOySXcpSKsYKzyl75d85pDbS7+dGrXDZXH+Sfrs9dh7vrTbNdEregoqskym3VJvzE5RC5r9pCbxW/ifSVOiHpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7666
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


>> I was intentionally trying to leave the actual problem out of the commit
>> from your earlier feedback and just put it in the cover letter.
>>
>> But if it's better to keep in the commit message I'll return those details.
> 
> It is.
> 
> If you make a change in order to address a specific problem, that
> problem needs to be described in the changelog of the patch making
> that change.
> 
> Anything else is more or less confusing IMO.

Thanks. I'll write up a new commit message for v13 once I have some 
feedback on the approach of 'v11' vs the 'approach of 'v12'.
