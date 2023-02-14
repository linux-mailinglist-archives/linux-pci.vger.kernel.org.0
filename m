Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1C969658C
	for <lists+linux-pci@lfdr.de>; Tue, 14 Feb 2023 14:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbjBNN6o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 08:58:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbjBNN6n (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 08:58:43 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D3026CDD;
        Tue, 14 Feb 2023 05:58:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XVNokHsWoPs0PVbWrhxNbhDPRX2zAaCi22VKGo+qhVn8kbBaVKPJPQ8On4Fo6/ynXjkJmoevTZSvRzYRKuppwTHkmy19MYiyRhs056PFDbePgE9eb4zLMkVcUvChoP3KCoiqwoPJkQhkPpkOCHCDkc+JSWpnXDcL+hzaG6gWDkm80IztruGixJrmI6quN0PZrZRsDfHMRwIAWzfMQhU9CUhS30BOdZk0Ejb6JYs4akZLB6qCZXY1LQKdWsxaj78+Z2TSaysXKOnffzK64RkosXYozcnXhOR4Mr31LGQv+l6OmKLhbvXTk7XPPoiZ3KqmUBolZkEPO63765zEYWY9pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uyd5fCSxYUD1RCVtiDE+eZuKz1HSRSzE0Rx2wFcb10k=;
 b=ODk8XNcKzSCgb0jJU2yzF0KpGtVJxIB1Jjah18a+KwsJHS1fGcTaShKPxMxNMtNgOJ3rAByhbMObaD8vx8R5o5V30+FtK4wE3g7IOXjFOLjbXBoo2JJA2dKdlHDGKXlInpYDQ+/I150PrfhFcZDVS/xmPNw1k5M+OZBYJvJSIhrI8KqPGwATzZPfO/yN3o99wcaQ34yLCGcKcjuGZC/1Zckjjz3f/c7DIFLt0seMkK6zqabxRFpWhk3YvI0M5DRATcwIZxwTKDLtw8KUFH41AurXWVqcSsWXvfcqGDxBQYy2mJOGdeWz5InzCSgugjPokuPMDCNUTBSvaqSJvjzghQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uyd5fCSxYUD1RCVtiDE+eZuKz1HSRSzE0Rx2wFcb10k=;
 b=MH0W9XHQ2uWpeXIgsb6q1m07E0x16lOuc0Lno4AgQWEzjI5WajXVwqmGoMEMEjcw7NPRCXv6eKIc43iIIlYFlITU8BD3n1839A3+d9ZBTWNSzQmI744cSIAdM2d2q6Qv4O/mI3oXNwqUhSfa1h783D0yKKKypM7gw5YWsPThJSWuFL9/F00npFO5m7NnipJNwI/2LI7cZHuMtYQdydu6YdNNH3blzcaOuROSf+HODUJg/EtnKB/me87BqG/lu4WS2ZZYsSDzyrNYODe7UjSWykVbJGbTNAyj6Ob8IVMKCRNS9nGZ0XQG+B/V5wBBhV1yPu6z0Alh8m9YpW+9/dZqtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB2900.namprd12.prod.outlook.com (2603:10b6:408:69::18)
 by DS7PR12MB5958.namprd12.prod.outlook.com (2603:10b6:8:7d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 13:58:17 +0000
Received: from BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::4c18:dc36:558c:1478]) by BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::4c18:dc36:558c:1478%7]) with mapi id 15.20.6086.019; Tue, 14 Feb 2023
 13:58:16 +0000
Message-ID: <ccc4b7fe-db07-cddb-2d0b-b6a89d7b1155@nvidia.com>
Date:   Tue, 14 Feb 2023 19:27:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH V5 0/3] PCI: designware-ep: Fix DBI access before core
 init
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, Sergey.Semin@baikalelectronics.ru,
        dmitry.baryshkov@linaro.org, linmq006@gmail.com,
        ffclaire1224@gmail.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20221013175712.7539-1-vidyas@nvidia.com>
 <20230214130329.GC4981@thinkpad>
Content-Language: en-US
From:   Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <20230214130329.GC4981@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0001.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::14) To BN8PR12MB2900.namprd12.prod.outlook.com
 (2603:10b6:408:69::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB2900:EE_|DS7PR12MB5958:EE_
X-MS-Office365-Filtering-Correlation-Id: 75cf8e45-89dc-49cb-f243-08db0e9384e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gkh0v6lAnoy097QolGYGMkXZ/Rc9XYc9Wv1OlErBDeR1czMeQCUb1fyqt7ULaBtQdYqe6PIzDOFMkh0pH73X1B7rN1oTSXQmucmAQsQoV1xU5KJfK4Fh9azXG5sM/sG5HFaNd2z7d05MYQD5gPQGb3RObW4MPDhsMn/BpOYaxgXQE6f7Pf5SYCyH0+8aNUhHbXanNdUR5Uk9jdGoWwNHYiKL4+pWWLiV2XQG5c0KjKCUu4jLYlpOvjOUh0P24MLoYILj+K9eQnyoned6AGY/sCZm0dXxwV4g5ASgQKjSTHqQiCpFm4nphVeWMFLjwaeR3h62meYwnXzjzZJt2RUELlbbjFiKmzbdsW5ACaJI5TYMnDWdKKqwD+DOD8hteVKWxknRjRBjA1ZOOLPsP82BdQDNG9PXEuiCRtUroLnK3muGN+pv1oJmyAY8E1uqppeEjuk3h46DV9Jby398CHMruKIf3/0U5M1mkKpgQhzPS0b0D9JPs0Ox363SPdJSpWr53E22c79tKBb7uNDAdvOOj+HuQeLz8PjEjYBSpSsJiy4gnONsmegvQ+cpwVH7RKa5roKrecPGGhPBwaQHGh2airywhO8cveM2bwodmIRZ7iCSGcHTd6nQut8D8oR07rrUsweJ3FHo6pU4d09Ody/ET0HZWDriFO0Gs42ThIisqjgcMj4zBBidELdirBAeRmUEhOCcGW3KY/FhzoUAP0i8/XH+QjYaer4sbYnQbEs5XD0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(346002)(396003)(366004)(39860400002)(451199018)(8936002)(66556008)(66946007)(66476007)(6916009)(8676002)(4326008)(41300700001)(5660300002)(316002)(2616005)(86362001)(7416002)(83380400001)(478600001)(2906002)(31696002)(31686004)(6486002)(6666004)(53546011)(26005)(186003)(6506007)(6512007)(38100700002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2lUOU1od0VPd243d0QwclJDTnJJM2laMmhOSFN4WmpvZzAwTW14SWowWVc0?=
 =?utf-8?B?bjF1cjJieWFaS3d6ajJCMFdreDlEN29STElBNnpQbkkyK29GeDl5amVrazVa?=
 =?utf-8?B?akI0ZEJ1TWxZWkFTN2pCY09FZmcvb3psVzBvQVc2Qk1zVEtpVy9oT1BIME10?=
 =?utf-8?B?YURWdC9jcXMzRlpKeW5ORExXV1lkUWRhTnNRRWhGZ2RJR25iTFdhSDB2TUc0?=
 =?utf-8?B?K0hnZ2RkUkpHNkVGN1JtTHUrYWhWV3J5bHZKNTcrVnRmVFBKOEJoWFR4T2x1?=
 =?utf-8?B?UTNuNnZDNnFXYTkzd0FnWkZwTVhUUEFremIyeVF5azU3aHl6Z1cvbXBaRTdi?=
 =?utf-8?B?U0NkY1o1cE1HTnVvMHFmK1g0MUp5WEY2Y08wbmR5L3NlaVhPM1ZFRDJrbkdh?=
 =?utf-8?B?emRIbGFFV2JnUTlTNmF0WVhxKzBwN2p5eERpQjFJMXNxRHBCbEtZVTRXdHJY?=
 =?utf-8?B?OFUyamF6Smg5VW9pZnd3NGxwRVR5bWhMTTV4Z2RPUEJPN1NBL2xqTXpvcE40?=
 =?utf-8?B?bE9ZYkdTMFd4ajZnM0FMNTNmMjI3VWhwNnF3WUVjWFU3dzVkQ250ejk5QUNO?=
 =?utf-8?B?dVQ2bzA1eE9laHJlR1RPZnVjaDE5elJWRWQ0UDE1Nk5vOVZQOHA1UmgxOUZB?=
 =?utf-8?B?WXREbmdSV3IrT3UyOGRXV2VFWFU3SThFcU0vZmtSMWFuTWJ0aGhNTjhIdU9s?=
 =?utf-8?B?YkpzdFM1bHMwdktHK3pHT1FSMkVpb0dNTkxPRlY0allXTk04YnpDam80dXA4?=
 =?utf-8?B?NWtzZGhhbTBWa1Z3b0x6TmlwZnNDajI3TkNVcmFndk1TN3R2RFFET2tiRTZ4?=
 =?utf-8?B?OXM1UUlGUERVWUkzcUp5K0IyNysySHB1Ulphd2hJMjFqZkMrOXFLSnZZY0FZ?=
 =?utf-8?B?V0lBS2pLM1I3YUcxd1kzY2p0QU4xOUVreVppeWgwK1JwV2JBL3F6U1g1KzVS?=
 =?utf-8?B?Mi9KYTJac0RTdm45VEdZVVhnZEtxWjN3MHFtZ28vNVVkUXl2RGpBMnJESkpx?=
 =?utf-8?B?V1A4UzhpdDdUNzFjeEQ0YTVtYnRrVTF1K1J0OVI1MnI2TjdOZGxWeitwZW9z?=
 =?utf-8?B?UGFXVHNkWGpIRkVXUFFadE1xYlBpcis0M2pyaFBTQ3hNQ01STkN6ZFRadnJ0?=
 =?utf-8?B?aFJwQ2F0alcyaVFoNnZ5NnpEQldJZitiTkZacjFxekVtN2xTVjA4c05lWGhp?=
 =?utf-8?B?WUV2SSsvTG0vdXVwa1NzYzhaL2xQMGlqaW1HYXZGRi9UdldOeldLRXpMRXZh?=
 =?utf-8?B?ME1QMzBxb1B0ZUkyZWFmRUlvaWh4V1BjS1VBYlBCUko0TXBzTFJLUTBUeW9O?=
 =?utf-8?B?U2xwUHZ6QW41aUdhbk5oS2JRUVgvZEw4bGEzTnJxaWU2MEJsajlUKzE1SlZT?=
 =?utf-8?B?Y3pSQ1V3bE1pck9xby94Y20ybDEvSVV6R1FZc2k2WEdUUUdZb2dTT1h4TXBs?=
 =?utf-8?B?aE5wbW5jYmVzZnRKUmFObDVHQWxZZFM2aThLNjM2Ylg2SThqdFRqMm5yVTgr?=
 =?utf-8?B?Yk8zaVZxMEpFUEFJLzFoMEU4T3krdUFvNHR2eWNaNnpTM0pkeEJkcEtTankx?=
 =?utf-8?B?bVVjeHZlQUxNdUdiTUZwbkRuUlJBc0dTeGFPRTh0ZmtRWkRqYlhYTzZTZUdG?=
 =?utf-8?B?MWFxZjJGUW0wYXhkRCtVZ1lwV2o4ODRYREM2dEdyYUFHbGpjdUlHZUUrSWxa?=
 =?utf-8?B?Smg5cVV0OHA1ZjdHTHFNY1RFQ0lnaWoxMWl0cVJvSXRWa1lGaE1CVHlpWEpE?=
 =?utf-8?B?UEVpMysyYitnRCtmdGQ3dklvSFFSRkJrZGp0UlNRSXBLek9SQmRSTEpaaGNh?=
 =?utf-8?B?aTBRMUowUEtSYkdsVGtYWXdZVVVVMTkzMVVTR1ZKTUFnZHY2UVlXLzBDQkZM?=
 =?utf-8?B?OXhabTE5TGxzM3Fub3grZzFjNCtiOEpHMk1wK0lpMUZOdDZ3VzBVRHFXRVBn?=
 =?utf-8?B?cjVXZ3c2anFraWtjZWU1bE9vYWxIUmlKcU5yRlBKNjN0eUFDVFZ4RDNBVzJw?=
 =?utf-8?B?akR4THg3QWlkKytrZ29MbWVaSTNGekthb2c5RTUxSGhaT2NTYXRDTVNGazM0?=
 =?utf-8?B?cko2UEpoQmMxVEJENnJqVFFCMCtwSEhwaFV4S1EyQnRsa2t6UGp4UUEwYUFr?=
 =?utf-8?Q?5li46E02cJTYsaXa0vfuXqx3K?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75cf8e45-89dc-49cb-f243-08db0e9384e6
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 13:58:16.7171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tzfQi2OMQK3EeU/pSXnm5pIM6L4jmbiwsrmErusVCOoEfb9zVnQzx4sjWAb3zbWwVPUjJ03OmuOpqWYXkcME2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5958
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2/14/2023 6:33 PM, Manivannan Sadhasivam wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Thu, Oct 13, 2022 at 11:27:09PM +0530, Vidya Sagar wrote:
>> This series attempts to fix the issue with core register (Ex:- DBI) accesses
>> causing system hang issues in platforms where there is a dependency on the
>> availability of PCIe Reference clock from the host for their core
>> initialization.
>> This series is verified on Tegra194 & Tegra234 platforms.
>>
>> Manivannan, could you please verify on qcom platforms?
>>
> 
> Vidya, any plan to respin this series? The EPC rework series is now merged for
> v6.3.

Yes. I'll send an updated series soon.
Currently, I'm observing some regression with linux-next on Tegra 
platform for endpoint mode. I'll post the patches as soon as that is 
resolved.

Thanks,
Vidya Sagar

> 
> Thanks,
> Mani
> 
>> V5:
>> * Addressed review comments from Bjorn
>> * Changed dw_pcie_ep_init_complete() to dw_pcie_ep_init_late()
>> * Skipped memory allocation if done already. This is to avoid freeing and then
>>    allocating again during PERST# toggles from the host.
>>
>> V4:
>> * Addressed review comments from Bjorn and Manivannan
>> * Added .ep_init_late() ops
>> * Added patches to refactor code in qcom and tegra platforms
>>
>> Vidya Sagar (3):
>>    PCI: designware-ep: Fix DBI access before core init
>>    PCI: qcom-ep: Refactor EP initialization completion
>>    PCI: tegra194: Refactor EP initialization completion
>>
>>   .../pci/controller/dwc/pcie-designware-ep.c   | 125 +++++++++++-------
>>   drivers/pci/controller/dwc/pcie-designware.h  |  10 +-
>>   drivers/pci/controller/dwc/pcie-qcom-ep.c     |  27 ++--
>>   drivers/pci/controller/dwc/pcie-tegra194.c    |   4 +-
>>   4 files changed, 97 insertions(+), 69 deletions(-)
>>
>> --
>> 2.17.1
>>
> 
> --
> மணிவண்ணன் சதாசிவம்
