Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9763F6CC8C1
	for <lists+linux-pci@lfdr.de>; Tue, 28 Mar 2023 19:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjC1RDI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Mar 2023 13:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbjC1RDH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Mar 2023 13:03:07 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on20606.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8d::606])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3071F86A5;
        Tue, 28 Mar 2023 10:03:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MdyiGoHpkEZ6Qvh446N5I9XC2p1BSWk6y1KORKwJ418pRFujjlLLAbgjmevYd9BI0uoNy/a5EW7ZRBuNusqLmPQLjyOhp90uxZFTXIMyYNScVnHAUQ6H/2wXMZzgXCmWh+AMCRnpSaAW69lJbPRNgUp17MsrbAgS9b50wz/w7PAKUHb2eMCjFwKlx+q1YA5jcuaN+IjuJy9LSpUYMVuztnF+3zPUOwf+sWhQGcqK9ineo5tLJ+e9mURvmF8zormxQq8jUiFZ2Qqj0cJMqEtrs2miqqCFBPnCUy5mw0/O9j8O2RFL3ajwd+krVvPyUlxG9KG2oOPsHqLtqpRfcmVW+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7DZOZ33qAEmUL5Ll0k87h+43qGUqRKo/j4A4Nu1dlw=;
 b=TBD018XBlaGFy6yBo2Jmp4lID/HkluEYdS58rI1uAIMPqjKTLxPvIsMx5xM7EfVQAfF/ONTacci6mCaAaFwHPlqs7Y4TODdiIb1F4ausa2/RDw45aERCV/hHyWjJyfvJrTg0moOS5Wc7hsH49spT/lgW4c9uvGorQRc7TCvPj53853Z5KQHtiiKj8KNXYjEExhOyCwhYtDkQsYmjZAwpcndTSjWFzsGEN01kqGL0GxE85xi1zhj9L/pl2tfiRlJxYkmIe7ajIE6yMdvzG2UJhSoaARnsck+79r0fDDnQRokR8J2nfx8LD32exx/szkFZozX+6Smd6aOITETA7KoQ3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7DZOZ33qAEmUL5Ll0k87h+43qGUqRKo/j4A4Nu1dlw=;
 b=itFV/AGqvzKLQjUEYymln/thbgL38ejnZ9ETUMHWPAhIap0Rd8WMHj+54b1usZmLRUFEkrq5QoOnKX/vs7+5Oz8Tkz+uJfaCzK09Z9l+X576TwprO55/M0k3Fp5Qq81/S6mZUdyht8t6kxQxlsG361E+KnmBy89z5DRX767a9wyUPQkbvTf7mjTKvC9K+Hh2WEHv4cesIYg0E+WtTTiZ7u0Aqv/m2GCMnZwpZqrPIHJ7uIBYsm1ZjRiCw/gOcNOsGYmHPNmdJYeUtqFMMLB+FCJqDiFPBx6+wjZzlGVr1EwQkOdCezzLH3fxSDWcgWZCezn/2rXzMtvqW865snjPoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 MN6PR12MB8490.namprd12.prod.outlook.com (2603:10b6:208:470::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Tue, 28 Mar
 2023 17:02:55 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::abe1:c2f2:c4bb:ba78]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::abe1:c2f2:c4bb:ba78%2]) with mapi id 15.20.6222.033; Tue, 28 Mar 2023
 17:02:55 +0000
Message-ID: <9baff4c3-31ff-c19c-01fb-f438797da9ea@nvidia.com>
Date:   Tue, 28 Mar 2023 18:02:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] PCI: Assign PCI domain by ida_alloc()
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>
Cc:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Lunn <andrew@lunn.ch>,
        =?UTF-8?Q?Marek_Beh=c3=ban?= <marek.behun@nic.cz>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20220702204737.7719-1-pali@kernel.org>
 <20220714184130.5436-1-pali@kernel.org>
 <b529cb69-0602-9eed-fc02-2f068707a006@nvidia.com>
 <20230320205936.wd6pj3trljsduj5c@pali>
 <993ca7dc-1d39-6ae9-1033-838d81aeb076@nvidia.com>
 <3414723d-7d79-809f-e63f-35243d945b50@nvidia.com>
 <CAL_JsqJ+3j60WK0HSr0rFQYwPkMbs=ZW=mifd7ggeNQA8+iuaA@mail.gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <CAL_JsqJ+3j60WK0HSr0rFQYwPkMbs=ZW=mifd7ggeNQA8+iuaA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0390.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::17) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|MN6PR12MB8490:EE_
X-MS-Office365-Filtering-Correlation-Id: f4337476-1a51-4d95-0773-08db2fae4645
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cAGQl5oc7Aq1cfKl8znS8/AJ6rR9oLQ9OPbelg+YRNl6snvD7ZZB0BATI46ea5mnRbZJw0KzcgzRLhNDTp4XKoyIw4RW2acCJlhwgt3dquEUWsHnTWJnL3ss+I0u5u1TaGlNu7eBtHhtZghDkmaXtkTI0+qCZqyihRGWC9AVsHtbz5Ij2kCO7z53L/Gb5whdHtY9r1hxaQNBSgEf4RbYnDzY76oDqIMR4Wl0bsOJKSgIjboVEdJClGhaiyqQ/pZa4JJaoGl1PgcMzMTPai5WG92WUqEUIJkU3FCDKozRhQm7Oa3EJRRnDr3ow1NCxB4AGi1aT2hImHelpjhKFCNFGol1u3HnhrBJH8K4GDpyUfCInkuhMwwxRryQM8ybmsWCiYEPUtSH+Mygxha6vwEsOFefR3+nwb44+OtySahxQVQjAkhX7Y/KCCA/pigv3nAJh/HP5nZU8VW28b7LtYDOyRNLebGbpj8WHF+PuXjMQ8pCAVjQ4w8vzgMnQH2t85OIYNwYXsQHB1oXK+DDAEvkjGbBDUIiwO1BHvVIVNK6VRavNM4f/sTwVeSF6suiRliUTYGAvz+jIgFjxsQ8cOF2szNWBIRTJ5fWYfg6FKNyqCN2FF9qWPbIopti8UxSEMZhpEZCc/QTb3hGJL9a/6Vu6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(396003)(136003)(39860400002)(346002)(451199021)(38100700002)(26005)(53546011)(6666004)(36756003)(55236004)(6512007)(6506007)(186003)(6486002)(86362001)(54906003)(41300700001)(31686004)(2906002)(31696002)(8936002)(316002)(8676002)(5660300002)(66476007)(2616005)(66556008)(478600001)(4326008)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVVxam9STWJZYVZReE91NzIvWllibUxlSjdTd0ppZXBNK0NoVGVkM3RrTVho?=
 =?utf-8?B?ZGtldGxoQkQ5Nko4eG9Tc0RDMEZmYTRpckswWnZKZFRZbWVMYk9ITnFPNkI5?=
 =?utf-8?B?eHdYZC83Z1JsbWdMRVUvaEh2K1VuZGdrek10R3cvK0c0dmpCZzZld0dsaW5K?=
 =?utf-8?B?UmFBcFFsUEt4UFBoalBWbDlIbFB3K3JMeXdvSlhRNVVKQzhldjdsT256bGFs?=
 =?utf-8?B?cVhhYURsdGpobFNRR0F4Y2d6bm1EdzBwYmdwSVNaclpkVitpU0tnV3Nmb3Zt?=
 =?utf-8?B?dmJTSFZZQUx1QlU3OEZvYVdHME1XVXptcHpLcW5VczJtbEwrc2FSRVc1NDE1?=
 =?utf-8?B?cW9mRGhyWTVHVXY4TEVTZHZ3SXVuN3dRRFJtTTBYZ1BRa0REUGl4dTdSSjFv?=
 =?utf-8?B?dXVqYTJLNmZmMEtQRjJJVjFCcjZkVlJHTzBBYWtDZXg4ekpHZHFnTlNpeU5Z?=
 =?utf-8?B?bGhJRjE1cTdTUkJPTG9yT1RmM2I2cGhHemlaZjBRMmNNWFhmZ1RTM2htWHQ4?=
 =?utf-8?B?WkdRRFVMVHg5d291OHlYYmkweHJXL3BNakNlQmJ6RlhPQjlIUnJ1a3J2S3l4?=
 =?utf-8?B?ek9hSm9ickNhbnVqWm4wcUpaNlNSQmFDQWV3RmRoVEEzek1uWlk0SHpFUEgx?=
 =?utf-8?B?RTFvMjdlUTRXS0NHcnN6MS9mbkt5QTJVeTVYU3FGaVNCZit6cFRpN1NHRG9u?=
 =?utf-8?B?QlQ1RWtUb01kQ0dUUlhyTkVabHpRZzY3TXdvdXJYM3NrOSt2WStrcHkrVmJk?=
 =?utf-8?B?NVBUaFdxaDVUYjJRbDR2Y2gybnlXYzFDQU5HSlBkZDdqTi9uV0Z4WVFNTWVV?=
 =?utf-8?B?aTZBUzlycGZDYmtKZnZDK1lWRG5pMnkrbEZpNm9OaWdhK1NtNUQzdlR4NEhS?=
 =?utf-8?B?VHFoMDRGWW5FSzIwb2cyRUlvaFgyQTRqcHJ4M0hWZEljaVdVdXMxWW1yUXBi?=
 =?utf-8?B?U3JNRUFkZEdFUktYcmNTZWt5MG9ocFFOV0tRVFp5S2xCTjFWZGZTMmN1R2JU?=
 =?utf-8?B?MmVUSEtNNEt4ZlVJc0kvRDRrM21haGtYbGtRS3JEY0k3R21ZYk0zWlFMeXJo?=
 =?utf-8?B?Ujc3THQ1dlUzM2JkbnJ4RGFCeWlrVUVZUzBlcnFaYkN1Wi9qUUJzbXpXVGlC?=
 =?utf-8?B?aDRVcE5Ma1RGbjVXTDMrbjhZTHFGRENTRmNPY2Rxa0l0SDI5QXNqWFRxQVVm?=
 =?utf-8?B?cldHdjExTytwTy9iY2k4R29BQTcwMDZjOEZ3RWw2b242a1E0aSt2T2hXc0Z3?=
 =?utf-8?B?UXhPTUplU1I0RVp4TFlBTWxITFoyT2VGOGlEMnA5Wm1nTkxFMFc3NVh0VkJt?=
 =?utf-8?B?TEg0RllEUE5OQXlaV0FkYnR3OFM1dHFDRUVsbnYrWWdNMG5oanFYQ3lORkZE?=
 =?utf-8?B?clVmaUdsNzZBdktKc3NjRndrMkRoenc1dlVtSjBxL2tkTUNRU3djeVozbzB4?=
 =?utf-8?B?YXVNMmtOYU1ZR3ZEbjRycStNTEVqSXBkNjBxMEY0RlJBcm9NdWk3KzFVTy9t?=
 =?utf-8?B?S3ZwdDJKL0dzQzhlS3lsZXArWkkyS2ozUmc0Z0hNVlpTeGE3QzU4bWNteHpp?=
 =?utf-8?B?aVlSclhidWc5WG1vVlpCL0NVaE94dnFCYTVTMXNZZmpUeEdpaldiTUlOTjZ6?=
 =?utf-8?B?YVhzYUJ0bVN1b21WUDU4WmRQOWViK002aUFyRXJac21sZWpTci93WHVoU3hn?=
 =?utf-8?B?V1ZHVkljbFUvdEhVMTFJdC9xZVYyYVc4T0piNlQ4ZXZzOENkaTFDNjBBR2p0?=
 =?utf-8?B?UjBST0h2cmRZblRBRUFsY3BQb3F3eFc5dzRrOHlrRDF2ZytCOXBFamg5ZFpH?=
 =?utf-8?B?MGl1WXZRYlUzcDNvWE11TnQvQ0dtTXhKR24yL1JPTHNWWnB5YTdMS1dDTXJ6?=
 =?utf-8?B?RkdqMkUrUWplWnFnaVhQY1Fja3Q2bkRjZXdMYmp3Q3FoQnZ2cWRPRVpHS2dY?=
 =?utf-8?B?VDdaUVRkTDBzRXZVbk83VXd2bW1HTGdibFg4Y2M1N1FrYlIramUxRVp3aGhl?=
 =?utf-8?B?VCtBeCs2V0tHRVBJdEN3QmVJWkFyUFlJSURhVk9aQThNMlE3SHNUNTRxY2Vy?=
 =?utf-8?B?c0ZuTlZ6cGs0c2E1RXpqeE85V1dKcllOUkZhUzBxZUVPbDBNRUdaMDkvcEVu?=
 =?utf-8?Q?+jOtyeMxPrF3xOqT0mN0qWOBB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4337476-1a51-4d95-0773-08db2fae4645
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 17:02:55.6417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i3f1aSUStKkbcg3KHN2Afe4B6jceJdGWNEDkT2rYwEONKzjcDRxza0H4TkUhot8umvFNO+Qurg89uTBDcrg8CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8490
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 28/03/2023 14:31, Rob Herring wrote:

...

> Does this fix it?:
> 
> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> index 0145aef1b930..22d39e12b236 100644
> --- a/drivers/pci/remove.c
> +++ b/drivers/pci/remove.c
> @@ -157,8 +157,6 @@ void pci_remove_root_bus(struct pci_bus *bus)
>          list_for_each_entry_safe(child, tmp,
>                                   &bus->devices, bus_list)
>                  pci_remove_bus_device(child);
> -       pci_remove_bus(bus);
> -       host_bridge->bus = NULL;
> 
>   #ifdef CONFIG_PCI_DOMAINS_GENERIC
>          /* Release domain_nr if it was dynamically allocated */
> @@ -166,6 +164,9 @@ void pci_remove_root_bus(struct pci_bus *bus)
>                  pci_bus_release_domain_nr(bus, host_bridge->dev.parent);
>   #endif
> 
> +       pci_remove_bus(bus);
> +       host_bridge->bus = NULL;
> +
>          /* remove the host bridge */
>          device_del(&host_bridge->dev);
>   }


Yes that does fix it! I had been meaning to get back to this this week 
to figure out what is going on and so thanks for figuring this out.

If you plan to send a fix for this, please add my ...

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Cheers!
Jon

-- 
nvpublic
