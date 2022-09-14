Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAC45B8739
	for <lists+linux-pci@lfdr.de>; Wed, 14 Sep 2022 13:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiINL0C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Sep 2022 07:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiINL0B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Sep 2022 07:26:01 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2053.outbound.protection.outlook.com [40.107.102.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980C675FCB;
        Wed, 14 Sep 2022 04:26:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bNZ92pdizNFUe6zoCqyA2A4heEGhnNWe10caAQaUrgzUYT3xn3sFb9Ei4t+1y8DccDbLp09fmzWHcQ3ZxOTNt8gkU7r6E16/FbO0xzEXDHWFwRV/7QB36CESaebYid4TT0TzXMFx6+U1/+STSNgdDOSAS2Aq2qAuk6Rb7F80VfZ6iTAX5tS1g7leZEJlGjDy4moinDjJD9OrblnybeuKnZbPyQpky3gg4alA7ckR7fWxy1tKe2ad8iccoMuv/zejZHSCe6AmemGRsj+6hEfxt8ynQ+aS3DTT7reAs7LRgD7LAuA5DRc9GhDkmDzekrwFhLTde341+twrg5PB/LzW5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a4K9iY7WkeVZGXA93WAo9CGxlDmZlYA4xb8wQHELC7g=;
 b=eohJOerr5MOcSgwg5cULXDV7qqzGN751imyHbU8KohVy1MuUUly34tGac7AzGpJcoISxn4/kdVLH7vy4/EDFuiRlBxj93G/Y5Vtq3AzF7uAdwypi1eW0D8os//NvZLyHZNEZUiW4uf66Szffydt8uNL10amX6WWtPGaER16aWvScyNwRWIW+FAz46a9YDa08RxogYjotHusrJeNVT86PhlKLRkzlldxUGxRx4fV3PKpKQ4KzIxuuNbb82mhmXWksQ0b9qSnGGAJ1fV1+E3q0XWZddPPT6ARaBElBk5Ax87AGIxKnQ8fH8GMmQ7DvhDqijgyN+HXlnih85cKxWQaAuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4K9iY7WkeVZGXA93WAo9CGxlDmZlYA4xb8wQHELC7g=;
 b=FkmQH4A9LYIV2ChGLR2DHRDtzT7qGZepdNAdploAsokAW9uRLz/JkLt0IhGKraSvXM+e+6HbvbDZFQ/oaoKZ/U72IRx8rth1OMlf+AL8eZY8sSCyg4tiZiUmpLomU7y8doA0pLfcQBauZ0vAF2wxLo9fJf0buUGRWxM4xDt3cLG+ncwoKBshekFymrK4yu3dQlhOw08DbNDEXNnI8/tuVfab2l0PGUenDufJkFMY42zUByH0hS92EaZ/qOro5DQpgwVdMHXXztvx7HK8DOgQLaOX/6WndH0TKxRdHtwyvXsIKHBj9cXxwQv9CJL3XQnxqKeNXCzcb7m8P/bq3b9eZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 MW3PR12MB4588.namprd12.prod.outlook.com (2603:10b6:303:2e::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.23; Wed, 14 Sep 2022 11:25:58 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::7090:22ef:abb3:ae9f]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::7090:22ef:abb3:ae9f%7]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 11:25:58 +0000
Message-ID: <5ffe3dfa-28a5-a5fc-0ae2-28927c39dc03@nvidia.com>
Date:   Wed, 14 Sep 2022 12:25:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V1] PCI: dwc: Use dev_info for PCIe link down event
 logging
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Vidya Sagar <vidyas@nvidia.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, lpieralisi@kernel.org,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        treding@nvidia.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <b1c243b0-2e6e-3254-eff0-a5276020a320@nvidia.com>
 <20220913200746.GA619956@bhelgaas> <20220914062411.GD16459@workstation>
 <29b39edd-10ab-b679-f270-67b0b406ca2f@nvidia.com>
 <20220914111857.GF16459@workstation>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20220914111857.GF16459@workstation>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0451.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::31) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|MW3PR12MB4588:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c530cfe-5745-4c29-5672-08da9643e5a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: visAXcF2sPRA2aiTc4Nu2+Hiu0Htt1paY7a4Oga91haS2htp94rfzNwFRK6lDgA7pCYKuKWp+EkaYS0jFEZIh1ZTUoFP90cUFOoy8RKujXV2gcIvpYElgCwjeeQubF/FwaKNc6/52xl/+9b2ypqzRlP7ulrBSokYMLE8lYyYMWKBpGTsJJ7l8RCq6NyqbHNVP71nP2TZS9oPVoKCpdYu37klcVgkCfemZdAlAEdsFxdWzwtXZ7LHoxphmPFLb3JqvCeMtnSqwpj/nuHJOecoN/yC55VYAE4biCh76SLAUYrtLUEMgOdSqSpWZQC080zUlXerINgawRjm8cqAE4Ckwp7Jv6JH23Ay1+JUgnCoCLa00PQJaawELqQagM6C5tYJQl9JhP2s+956dXI8LsZrh5QHJd2Qnw9esWyvIZPIT5A/jJY8qEP7aMcIu5GR0bq3V+actTCfHZq+fEcRVCHtuyZ77bb5yhAwMoM43n1BigkeO3JRP/N4fBFbeOeSbHQ56JaxmRDBFGSvj7qTtlrQnuUlZ8mejdm+IkYc5NpA8EnZdbPs+sO7u5qJDmlC1U6AVfpmMj53j2c0zVUL32pr69sWgzOg0wGXFw+o3RsZSGwZu2UowTj2YyMFmi/JnmaBz5bFJqRqnEzxNzlNXlIMM61sPXQWnPgrK/qKapmCH37wvbH3fdtMX4ZjA6gMFngpRybPMkxH3mNz6AsFf77U6+vbDUOd1x7/t+bVNqJErq2IR8Vfj0Fkun1pnO8bTG9O8fvBAyNIlf2JusE2If7uOB2ryN/VYxqOVrJlHHkwbyM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(136003)(346002)(39860400002)(396003)(451199015)(6512007)(2616005)(186003)(31686004)(41300700001)(6666004)(38100700002)(8936002)(66556008)(8676002)(7416002)(4326008)(5660300002)(66946007)(66476007)(36756003)(86362001)(31696002)(83380400001)(2906002)(110136005)(478600001)(6486002)(6506007)(53546011)(6636002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTFBTEg4N2g2WTg1Y2I1cjVTa1ZwTlBaeVA2cjY1S1J6OVg1LzlGMnQ3cVVN?=
 =?utf-8?B?UTlKOGlUNmUrOCtNM0pMNHFoQ1o4ejFsTEwxN3QzNDN2TUhUTkJ4dHJqRU1y?=
 =?utf-8?B?MWNrK0JnL3lDV3YxSUxVT2drL2QrY0lTQ3FsdG9uUDkzNlZEN2x6V2tQRGcw?=
 =?utf-8?B?RVo4ZnlIajdZcjdkQzdFMGpGcjRZQjNxcklkU1JSR3EvSzJQOTJhVW1wTm5k?=
 =?utf-8?B?SWlBUUhpbjVjdWNNZy9JNXNDVG5OaExyTnR2Nm1MSUVDenNGYS96ZGEvSVhq?=
 =?utf-8?B?N0U1USt2akpiemJHZ2pIUkJQeWIwSlpaTEoremtucXRsQUtwbVlVZTJ3VHZF?=
 =?utf-8?B?aDVZWitXTWJpeXYvYWpZWWVGbUxrcnlVdWFUNW0xcEJ0bTY1eG1xQzlDOEtC?=
 =?utf-8?B?YTNwUTZSR3d5d3Jmb1dsZDNGWk5CRmxBL1ZrNDI4NHNDS3JSYXZuOThleGM4?=
 =?utf-8?B?aGY4M1pCYURvcEt5YVFmQlc4cXdEVUdSTUV3R3hOaXJRdENPQThSOEpGY0lp?=
 =?utf-8?B?ampNbzNCbnZOYnE1ZEgrSjNMNVVGd25zOVNsdXJkZDNCZ1NTZU5kc3ZGaVg2?=
 =?utf-8?B?amhBSml0cFZVbjFWdSs3MEVjTGEzNWRUVGtlWmVOd1p0ZUNPSHJSVkgvSG96?=
 =?utf-8?B?b2hEVTVGeTF5MXJkVzlCWVhIWDBLNkxmck5XNmdwQk9RQVk0NEFhbjRtaEhF?=
 =?utf-8?B?STEzdUhmbWYzRlZLbkJ5ZkhqanBkckNULy81aTdOaTlCK3VmVlUrbXhQTThT?=
 =?utf-8?B?S1hmby8yS3c5MjYzcGxDWWJtSGorZ24wcjNueEY0ZkFZcnAyQUJOS3lRRUpn?=
 =?utf-8?B?UjlsUlJab0o0b3VHOGp5eVJPcTh3T3FBaU9LcUFCZXVHNGZQNVRRL3RiV2M1?=
 =?utf-8?B?eWVHVG1IS2RwMzRJYkRrc0c4OUt3SER4QVlzYVdmMEJncmVhOEVya3FjVGVY?=
 =?utf-8?B?NE5TdllHUWUvWG5sanAybCtGWEpPMDN4TE9EQzlpajhPa0hJYTRtSlFQUlRL?=
 =?utf-8?B?T1UzdTgwdGptdzdaaVhQdmFpdWZjeG1MRWRCa0Q0amI2ZFJCZHVXWFNhUS9W?=
 =?utf-8?B?djJPMkNTRTU3TUNrd0QxQlR0d3BleDZOTU14VStkUSs5REVmWE9BMnJjTDhC?=
 =?utf-8?B?ZkVVM3ZhWWczbXZmRDBZOWlxeGVhM1pmdFFoK0FoS096T01nU1dzallkZWdv?=
 =?utf-8?B?b245SjYwQ29hdVZGdVp1TXRld01SbU1qSjJub1JoU0lwWVBBQ1FjUnFTcFQ2?=
 =?utf-8?B?WlJoSWx2WjlwUHZQWjRNRzVtSDBOWjJqN1JYQk04eDZaSWtObVNKOE14VGZj?=
 =?utf-8?B?M1lOMmJvZGFCOTFVVEI0RjJneHJEZ0JDSTNRMEpNaldQNm1qek5vbDNDWnNy?=
 =?utf-8?B?VktJVGdjWXRCbUtrdGZGaXB1N1E2V1VreVJyazJVdTRaMEJkNjJnUUl0N0Rl?=
 =?utf-8?B?YkRCOEtJbGZzbjhnSnpWbjVxelNEWXFLQ0EySHZpRUV1VFdhY3RuQ2VSQ2Ir?=
 =?utf-8?B?Qmx2L2h0VWFCT3NBcGN6ZXpMeCsyZ3ZJS245Y3cvUVF6SUdnTmc4dlg3bm9t?=
 =?utf-8?B?eXg0K0tDNmFVTVNLWU9JY2JCUWZkZzRBdXJaaDJQaG5VY0xHblgrcTVPbHZ5?=
 =?utf-8?B?amNTVStKbUN3cXZxdmNkR0dTeWc0MjZwS29hSHQvVmxwbG8wcW14Qy90ekF4?=
 =?utf-8?B?ZGFmMWRZeDlDcTFUR1VVL040VGZESjZnWnNFbmFlcG4yYXlVSlhtd2tYWlBD?=
 =?utf-8?B?TUtmTVRSc3cvSmg5MEhrekZ2OVlYempIZ2tpWHZqdVdNeUJFaHJIZlJ5ODNL?=
 =?utf-8?B?a0VDZUllNVhXczJGU1hza0x0UTBtSjJYQmVxYVVOTXZ2RFk4azQyZHFjL000?=
 =?utf-8?B?SWtFc3FVSWw2cEc0dEhMVi8xRHJWb0k4QlNwdDloTFpIdFhJZTRhd0hYVjVi?=
 =?utf-8?B?QzMwcnNlS0VLM1BRWTJKS2F6ckVRL3BzbEVsVXQ2VGxJdmpaUTlOdWhHWVVk?=
 =?utf-8?B?OUFtZDBlZmdlRkU4eEhpbEMyTDRzelE5YXFxVTZEUDE4cTRoaVB1U2dKcURB?=
 =?utf-8?B?SUdoRkN6VUt4azFpUU1zVm1OYVdJYzhZY0RDUlNZQkp6NS9MRjlRUVJxc0VT?=
 =?utf-8?B?YWpzSlR1MHp0eERmWFZMTDRzRytweDNIQ1V6UFgxTUVLNkFSNERnYWpqeGly?=
 =?utf-8?B?bEhuTGVMc0UwMzArUXE1VTNxYy9aMktROHpyaEt3YzVJL29vcVVJUUI1SDl4?=
 =?utf-8?B?YURPNzZGaHNDQ0ZqbmdFSFJZSWN3PT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c530cfe-5745-4c29-5672-08da9643e5a0
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 11:25:58.8311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kEZ60473a+vhHrjnj/5tUWOK47rKWhFGzO+Y15zSdsqoJvhypj4CYWKvJmVn/PPwgzNX0MTu1wM5NLSLbEctrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4588
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 14/09/2022 12:18, Manivannan Sadhasivam wrote:
> On Wed, Sep 14, 2022 at 04:32:10PM +0530, Vidya Sagar wrote:
>> Agree with Mani.
>> Not all form factors support PRSNT pin (Ex:- M.2 Key-M form factor) and even
>> if the slot form factor supports PRSNT, it is not mandatory to have a GPIO
>> routed to the PRSNT pin of the slot.
> 
> Right.
> 
>> Also, since these are development platforms, we wouldn't want to keep
>> changing a controller's status in the DT, instead want to know the device's
>> presence/absence (by way of link up) looking at the log.
>> In my honest opinion, I don't think the absence of a device in the slot
>> should be treated as an error.
>>
> 
> As I mentioned earlier, timeout can happen due to an issue with PHY layer
> also. In those cases, "dev_err()" is relevant.
> 
> And I also agree that absence of the device should not be treated as an
> error. But my question is, if you know that the slot is going to be
> empty always, why cannot you just disable it in dts?

I really don't think that makes sense from a usability perspective. You 
want to allow users to connect PCI cards and for them to work without 
having to update the DTB. I have plenty of open PCI slots on my PC and I 
would be a bit upset if someone told me I need to update the PC firmware 
each time I wanted to use a new slot.

Jon

-- 
nvpublic
