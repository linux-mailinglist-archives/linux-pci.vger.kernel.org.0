Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380BD5F97F0
	for <lists+linux-pci@lfdr.de>; Mon, 10 Oct 2022 07:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbiJJFwA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Oct 2022 01:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiJJFv7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Oct 2022 01:51:59 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B521C912;
        Sun,  9 Oct 2022 22:51:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TAkqwrEdnXxiCCdtetMlwYsoukEP0IUm6hqozbI205LmSYyCOH/aC0AJOulID4p/+wi3F5aENrFn/AYVl9P6wv+mUesGRdph13L6FjuFyKZ69dnLF3S6BqfWpbyXBQ7LpVSEJV7glkrII/5C53EjbLZSkQJUAk4Kz5SoyV0Pge6JOq3IuIOEDcdtHjCmL7UPz3CLPxfJg+eTqxNgKyH95FBMEES5BRRHxSkgs+QXC/dLkIH4fP3yVA4ch0mbt6yL2rYuE7KGlkfMAtlDarBz1mvyfHze3TEi7x4Dh8Z3GDZ17clCrGnyoY7SRzG4eTshevGhzf241zbsb7EO+mmn5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FHAB0FoN/A2i+amFABhM4YoLq3Ie8Fuvgc5L99YVeks=;
 b=lPDoSn4FtXm05XamVIQSkBsBsgwENH47RY1QuD2L+xDhUgb7mRg33jTZzYlS49zILA6JS70D/AdEOq+QJ6yOhLUUQ0hgrIWtIifDiq9Of3wwKktSYQrFry2oAcK+WpI9v8m5htMa9egoEsE1+Ni/zC1G6SrEhqtZhYiYF/Yrk0+YeAwyyC8ZI9gqzPsUp9NXSXN6D6BDRFEFHeL2Fc04Mg6drbMrMhPLLFde8iTmvLPWa71OZWhCwoqraoMQhm8hX44vwws7Q67PretG07c4zO3aHm42F6XGwIF7x1D4wSwR3JMHEyKkGTwTW6OooAeKCgIh/W9ClZPZTdwzUPARFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FHAB0FoN/A2i+amFABhM4YoLq3Ie8Fuvgc5L99YVeks=;
 b=DCvpFNirarnDODRkj8B6r6Ug3ncLct10kQucd+FDZzK6xOeT4IFpCCAgKk6iyCXeT/Ur6oPUYoCD+LWKnyY2CGIDsQX06zIaNXOtTbSb9tm+Lkr/hyO9OiyaZoaMM8FdASQLlxiBJJmbAMlFjNieBqROO5zNj3XEk82o1XfUCxE76RK0BMZGuST6DhzvqDlgF2O5D7zBG5CVRE+wUjdTWRlSssXplTlOvANrTmcR3lxX/1QZZxEe7uh5bRQ8M4SVS+Wp68/XCT4ZbGiEVEZTDnjMP1eFOi1HkaOY5uFTYjbVdV0k2udcxXKdKP7aZ08ZXQPTOoscqDwx3Bl2jlIctA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB2900.namprd12.prod.outlook.com (2603:10b6:408:69::18)
 by SN7PR12MB6672.namprd12.prod.outlook.com (2603:10b6:806:26c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Mon, 10 Oct
 2022 05:51:56 +0000
Received: from BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::d9ae:c30e:ce3d:9cb3]) by BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::d9ae:c30e:ce3d:9cb3%7]) with mapi id 15.20.5676.031; Mon, 10 Oct 2022
 05:51:56 +0000
Message-ID: <29e9a0ac-3424-51f0-71bd-b67f64dad648@nvidia.com>
Date:   Mon, 10 Oct 2022 11:21:42 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V2] PCI: dwc: Fix n_fts[] array overrun
Content-Language: en-US
To:     lpieralisi@kernel.org
Cc:     Rob Herring <robh@kernel.org>, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, kw@linux.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20220919143123.28250-1-vidyas@nvidia.com>
 <20220926111923.22487-1-vidyas@nvidia.com>
 <CAL_JsqJ1qLC7zEL=hhgvsdimgcxxkPhN9LCJy3DnYZ8K8LJkLQ@mail.gmail.com>
From:   Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <CAL_JsqJ1qLC7zEL=hhgvsdimgcxxkPhN9LCJy3DnYZ8K8LJkLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0051.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::9) To BN8PR12MB2900.namprd12.prod.outlook.com
 (2603:10b6:408:69::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB2900:EE_|SN7PR12MB6672:EE_
X-MS-Office365-Filtering-Correlation-Id: d44ee345-993f-4974-02e7-08daaa8389f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K4AnnnDsWafyBaPSsHeAYBMzH6fytEgcIWsKdV/siM+YZ+aYDoQCM9Kq7jrZbYKF1fN9Koi/f03GZykCjEje5jBOpBAH5MrTRMJWukkwHF/8+vMMGRGPXoN9zUPrrCse4tIqzOpbTF810xEv76K4Daz4tP/mNJpWpaxJOQZUuWhmhWdwQnYhSgEbQQ9GVPclnHdHSRo4p3U1oOocpHzIswkI8TrbRQJ7wn9mq1n053R0YHln5ZA/UCjz/pGuxFMpBs6T4kCfToQpNWxe4pbXr1HmRLL5d1+S3YtYRNdiLbu77nbFWS6zcd9tL1UpyEd5Zl2w5IkMns/JEgNAcO/23Ru//tjaIa4jeVx2AADDPvZYd3ITzZXeWX3AkQwGB0pJbDus8NPWoQFjznAI/gN0jdSuDmetkvU2GCg/dwwbunHTqOqgtQYd4Q9Pi2vqu7gYf3NovlLfSVw0FCa1XeTfmuoYp6OTgFTu8/L30WxXkoXakEZP8mYbi9pQXkeBOaFARoTt1MGNk+uAEcIoeXKfjAx5D30xxvY5PpxCefsmj/Pb6kurTo5d4xJJL1hyk2kUDMwzODTUfypJ2R1l37oJOLPxvHjKJ5rnBz6WpfxZjyC8lHVcdhr4wmHCIo44j2bwr5cKuVOQccvA1XdK5xbaR60k2E1/0Xy37ZZZgdlg+pOx92AEpnZKtHHLU++tq4xoDUtOGsqaAPuU7u5TWOYqdqPZ/gI05dckpLV41DYO2GUs7GshlqpdJieQnN26o2R1n3grl5Ikt30GgYq9mVdj9+M2AdQ07ztRpfySVSfFum4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(396003)(366004)(39860400002)(346002)(451199015)(83380400001)(2616005)(31686004)(38100700002)(2906002)(4744005)(186003)(6666004)(8936002)(26005)(6512007)(6486002)(5660300002)(316002)(478600001)(31696002)(6916009)(66476007)(41300700001)(4326008)(66556008)(66946007)(8676002)(86362001)(36756003)(53546011)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2k1Z0hQLzJaNnFhcGxjclhYZFQrOFNMNVRmZEJXc3dYNDNyalFYbnJHT29Q?=
 =?utf-8?B?aXJyR1FJY1lZN3NHY2p4VytYMmtrZzJTa1BDQ3AwYVg5L0h3WXdzZDNzbUlC?=
 =?utf-8?B?L1ZBNXFUQ2NqbXpDREt1anhsLzdtdTZLVzZRZE1TV3VNdUJwbFZiQjJQeDBK?=
 =?utf-8?B?bTFzandaRDdnY1pVaC82a0RzMWYzbWRNL3NLNFV2YjNOd1I0eTI0bjRhMjNB?=
 =?utf-8?B?dU9RZkk4Ymdxa0t3cVEzN29Sb1pDTTk3RmUxSkJsSUpLWW1oQ2JZQ0NHZU5p?=
 =?utf-8?B?YUxtdk9sV2lNOEFTcDFCRXFqTDJtTHpTMG1uQnVtdmEyT0xTU3o2cWZreE1l?=
 =?utf-8?B?SCtMTzQzNnQzMEFEMW9tSzdQMnZOS2ZGeUdCaWd6RG15Zk1MeUtQV0tDZHVl?=
 =?utf-8?B?Y21ndXYxNmRrTlBrU2pFZnFCK2FyUENocHhGcHlqSGl6Q205ZTdWMU1TY25h?=
 =?utf-8?B?a1VDeW1jOHFkL0hHWERGQ3lWOURPYkJSWDNhclptYXBpdUZicG9ZRnZHaTNL?=
 =?utf-8?B?bjlVTndGWTBUMlRwSC93bC92b3RMRnpxNmhSS01rRnRxbCs3N1dQQVI0S0Va?=
 =?utf-8?B?NHZCL2NHTXpRa2NkM0QzS3ZCNzRkZHFOTEo2M0JsUi9GNzdUVFdyRzhuaExX?=
 =?utf-8?B?RTh2eGdRSStwWm9CWjFnbkZaUmM0QjRVVGNuSmMvWGo2UzMySHcxU3BXNHdC?=
 =?utf-8?B?MStNcTgrVkxhUWJsdUd4VjdlQThWdExuYmFJK1h3cHljTnpkQjRZUlp6dlZ5?=
 =?utf-8?B?cEZGOWtMbi9mV040dGIzaHVRbW52R1FLNUZrdVZqK2t4RzBEUWJDT3pQZUhp?=
 =?utf-8?B?cUplQWtQMlNwelZkMDNISEtQSmxsUnpqWEQvaUhXa21RZGhOMEUvRWdCZWRq?=
 =?utf-8?B?bGl5ZnVGVVBsQ05LanhSUEhlejZURFJVMHpGSHRBUzlUdFNzVTZCaU9vY3ps?=
 =?utf-8?B?UVBTc0gzcitmUVVLcjJDamlCL0J6bWZvSTBoWW9UMUtCRWsyZC9mK25vUGla?=
 =?utf-8?B?SVdObXdHaHJOMzlkRjd6enBuZ1dLRTFaSjdQWkttR2xXb1NjNzM5alFWVllM?=
 =?utf-8?B?bEVxbmtKRXVsU3FWVitEc0pzTTd1TDZ1a2pYUG9pcWpLWVJSTmFpTGNCU2hX?=
 =?utf-8?B?ZXRjT0RyNk5LeXovaDkzUG1ZazQ0OWRyY2VpSS9ZYjZ5YlJteldvcHJYWlQy?=
 =?utf-8?B?MG01UEFtWlZSTkp0LzNRYm9HQUhqZ2ZhbTZteTNPeXMyWUpYR2RQOEd6TnJm?=
 =?utf-8?B?SVJNMnYxaENLbGFLN0RuK0VhWGNpaHkyM1daWWVNTHpoaDdsM3FMOEg3eDdW?=
 =?utf-8?B?dUZHYitwQ0RkK1o3Z1hpM29QL1ZiNzFwWHFWNm04M1Jub0VGaTVYaW5HUGNj?=
 =?utf-8?B?cG9vYXJPeGQ0QzdPSnNrTHVVd001QzhFdE8xVnBHNUduN3dKWkI0L20vV2Rt?=
 =?utf-8?B?NzZmbTNVOTR0dGcyaXJpZmRIYmpBODZ4Um9ZU05CZTBrMHRsKzBrZVhPS0RO?=
 =?utf-8?B?eVlNd0Y2dzZMR3Y2UzBienhBZFl1Ly9JNTJlSWNqVWJ4SkwzeDF4c1lJWUlI?=
 =?utf-8?B?UDl1UXJFMVVBa2V3UFhYTlNsRms1T2wva3AwOThyeUZIdE1PZDM4MkNzUnN2?=
 =?utf-8?B?RnJpeTQzR1ZyR1dBUGZJWFZBZXpFclFPTWtLRUFPcWNuMEFCaWN6WDZKS1hX?=
 =?utf-8?B?SDMrcllEam1iY0gyTEExNUkyM3U2b3R1a3VFajJ1d2ZLMVJON3Mwem8vNW5V?=
 =?utf-8?B?MGh0aExqWnJoTnQrb1k5UXpKZ21iMlhBenRTenI0RXJxbXBmMzlNdWE1SFpX?=
 =?utf-8?B?U3FPR0s4K0wvNW9TME5SeUE0N2VPQ2hvcHNIS3Q2ZDdPUE5FTm4xS3FscXNI?=
 =?utf-8?B?U2J2T1ZvaDZmczJTOGphdUZFbGVFQ2Z4TEdCYkxaQUd2R2pDaXg4dGNzZ1Vm?=
 =?utf-8?B?TERwODFVbFdmWUxqTWY2N0RKR1lrVHJGNlgxSHJiRGpQVHZLN1EvaklYZFFr?=
 =?utf-8?B?V2pSZlpxYnJDUC96cWhrTE9aZ0YrTkJFdUZnU0NyY2YxbU1YbUhYalByaklu?=
 =?utf-8?B?Qk43QzJ5MGN1SUJ5bm15VkNtSzI3Q0ZrZmJjWVVGb0hKeTZpOEtZQjFMeHVY?=
 =?utf-8?Q?4udhakRFinK9uDxv6/ciOMRtC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d44ee345-993f-4974-02e7-08daaa8389f4
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 05:51:56.1847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8gn8vJ3X8qdA2tN91vF+CWcehuSd5HPZdhs2c9bMatJvvvvqV0Sn1EiCHKueL6IDA9+OHKBEvknIhrgbxEoqyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6672
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,
Do you have any further comments for this patch?

Thanks,
Vidya Sagar

On 10/5/2022 3:20 AM, Rob Herring wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Mon, Sep 26, 2022 at 6:19 AM Vidya Sagar <vidyas@nvidia.com> wrote:
>>
>> commit aeaa0bfe89654 ("PCI: dwc: Move N_FTS setup to common setup")
>> incorrectly uses pci->link_gen in deriving the index to the
>> n_fts[] array also introducing the issue of accessing beyond the
>> boundaries of array for greater than Gen-2 speeds. This change fixes
>> that issue.
>>
>> Fixes: aeaa0bfe8965 ("PCI: dwc: Move N_FTS setup to common setup")
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> Acked-by: Jingoo Han <jingoohan1@gmail.com>
>> ---
>> V2:
>> * Addressed review comments from Bjorn
>> * Added "Acked-by: Jingoo Han <jingoohan1@gmail.com>"
>>
>>   drivers/pci/controller/dwc/pcie-designware.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 
