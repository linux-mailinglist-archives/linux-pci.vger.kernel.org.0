Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D508456C601
	for <lists+linux-pci@lfdr.de>; Sat,  9 Jul 2022 04:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiGICeH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Jul 2022 22:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiGICeG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Jul 2022 22:34:06 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2068.outbound.protection.outlook.com [40.107.101.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96916140E2;
        Fri,  8 Jul 2022 19:34:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BvEIEIY1E62mFlGKZ8AREtUVkC5XG6y8rLLbJt+SZq0ZYVMC1Hy9ptAAN3bhg4YShFNgvJGKKae4L7ou4bTnkh7Yfscba4GtpSIG3EL/kNw7cl7f2OgXf/qJ6kpYF5W5rJU8yb+uVMAbvTe71tdfUbN4QMwmn3pmY9oeTX5GqpfRIxhwys1ArgOxNmbzNwSv56RqqJkXK+NL9TqfeNTtfvN6YipDXkQ9bj+vnkseP4vtU2K9f2nGbvVXMF4unmK/jaFXcRdx3cZwfP8vnyGggQXLAIiT4XfYSz1LlURNOGgPUtErJRDtGtdaZpiQt1dcJqijVl9l5z2UWCQ7x1TGPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EBOw7e2YvnMhp+67t7BJHebeE83EZWwLV2DuCqUz4zc=;
 b=OAtbOxDSEJHZj5spsmYWDH86sVmyN9v16KrnpGr1svXjLVItHLdbB5gqLUKn//b47ZBj22KSESQglmbU5BKpLnUesmusK5pP+/VLUOdZTVToN0L+rUcR4L12yKnwzoIFHFEu+SxOI2mQtQpxsdHDFYc1EEUTur2AHeq59A9Ujqm+pNSwzpDsrNG8WrnDtXO/bxwkU3gMgEb9sNZjmKLczBtmetdRkk7DfOJ4AAOKuOktImDK+jlNDnP6EN75kvEPTs6+7ILimyZx/hc+POHDW4JcfKLnt9N0CT/FS0QPadVuEU4Xsyn5e7i1l/mdOJ1G5O/PzbMBbsYtUM2cafQR2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EBOw7e2YvnMhp+67t7BJHebeE83EZWwLV2DuCqUz4zc=;
 b=Pd8GXOJNfGx8X7rOl+qPwfF9b4bIH0/nH/ro9i3JPS+azjyaPoy9gT46f1wb4GiRAXiHZtQZ89eORobhgMgPjR/P4YDt9Ed/eGnOnrdVW6i7LAbaddBD10v2T7KN1NvabRKZ0s3eZnkufsooRzgp6eXTG5g2+lDiP3locSOMeks2iPX104Fjmw6aY6XPACMOYMsggR4kYokS7DDv26SNXo4cVm5oFincafasEKPj3Qo01l0FZu/KtW+tTtmCF3bvF98fLupz86Em+QNhZ8SBhpPD1B8JeRVZPIY4cOxAx1JcN0K29NIvAK7bCvm38BNBo+caTuHq8SPo6WpUGvlg0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB2900.namprd12.prod.outlook.com (2603:10b6:408:69::18)
 by MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Sat, 9 Jul
 2022 02:33:58 +0000
Received: from BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::3904:2c16:b3b7:c5f3]) by BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::3904:2c16:b3b7:c5f3%5]) with mapi id 15.20.5395.022; Sat, 9 Jul 2022
 02:33:58 +0000
Message-ID: <afc9cd15-a895-792f-3f49-1dca3694b0f3@nvidia.com>
Date:   Sat, 9 Jul 2022 08:03:45 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V4 3/9] dt-bindings: PCI: tegra234: Add schema for
 tegra234 endpoint mode
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     kthota@nvidia.com, sagar.tv@gmail.com, lpieralisi@kernel.org,
        bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
        kishon@ti.com, robh+dt@kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, jonathanh@nvidia.com,
        gustavo.pimentel@synopsys.com, linux-tegra@vger.kernel.org,
        thierry.reding@gmail.com, mmaddireddy@nvidia.com,
        jingoohan1@gmail.com, kw@linux.com, linux-kernel@vger.kernel.org
References: <20220707081301.29961-1-vidyas@nvidia.com>
 <20220707081301.29961-4-vidyas@nvidia.com>
 <1657196871.476299.1454231.nullmailer@robh.at.kernel.org>
From:   Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <1657196871.476299.1454231.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0109.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:1::25) To BN8PR12MB2900.namprd12.prod.outlook.com
 (2603:10b6:408:69::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c71f9681-6009-42d8-0448-08da61537988
X-MS-TrafficTypeDiagnostic: MN2PR12MB3823:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eEiIT7SRKwqlwKzB4Q91sLtghxu4PblWAdDdjd6upHq0OpusQ6OnPHRJYPqd+tQg79nzTcfaYi7i30w8PeuXtg3wAyv7nK9fEdU7b1MpIjXN7lGDOErOsX3XRG8a/qw+K3623qESZYVfkMeNV8lqlFqQj8/v7Nqy11YKJUXYYMmHZScch/Q6GLKl5oPa67TXpnAQChos+FFEvnhnGtc0TsynuerZMork+cqRVRusXpedmiYY9GHZVghmGjy90wR4UphtaKdIqGMMyWmhHBg9COcXG4IcMhlVQcNmTaPGiLzbrR6FTRTQgkT1wweqaeTAX1tK9tHUc7Wf4VUNxMh0uIAmtx9EDhCyjTRDAfB7+fIhOhSPAoLUNdmabJrVqlPHsbB0m77AygJ9TH3fXyTn2s66oQY8JdlPFsfu2g0ypeJl7UNjkMRBRsCCI2nFh8CQ1pu0O6PhMNy9bdkUwU4YP9JbOGNfbFP/0Xf0lpDwmW5c4jcHLMs42Z30df9CkejwpyQFpJd2rVbtfN5JVNYE5tfChRPiKDW9zKXx0/Z3vHwK2IxEslB51kMq2xLm0uNlw/xMlp+1u5xQCdiMtwDoLXMjtaJArkaZO8nz+eBTT3cJiLnq6AAcwHhXBO74l7xFiYdOXMyF+BilR7cddT7q+ISkf1LKveLo4P654F1ay1qoYLy9uBxh31AnG3kceTlEye5j+iG9TXGzz6LLBtZayX/kN6Qe9vs1vmfsVMPvuE9pffnIJXoLIZvUBJa1WO7EDGvepaxIBISTcisFsz0t4648J2wfrQBayk8IJE1spYC7YWn6alGv4r6uiyH46SJLyP2iYTzZyQ3ezIGFKJUNiGepwJUKM3JTFjOW4EiFBOur/Ks0yQoXUXphPYWOU4nj9vqNA+B67cWVenNJQ9cjLtptFSF2cEwnLJyFQxiQR30=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(396003)(376002)(39860400002)(136003)(38100700002)(66556008)(66476007)(5660300002)(6666004)(6506007)(53546011)(8676002)(41300700001)(66946007)(186003)(6486002)(4326008)(316002)(86362001)(31686004)(6512007)(478600001)(36756003)(2616005)(7416002)(966005)(83380400001)(26005)(31696002)(8936002)(2906002)(6916009)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEZEdmNQT0oyaXgyeWRpMVFpU29pR3pZeGhhNHNHWTZaaXMwTUlYWjlZKysy?=
 =?utf-8?B?bFcyYm43NHZ3Vm1XM3A5eitSaWZNc2dwcEhnNDZ2Q2JIQjIySDhBZVhhT0lh?=
 =?utf-8?B?d2Mzd1NNaXByU2d2U3RJTFhaYmNmZndjd2psQVp1aWpLd2YwdFlWdHM4ME03?=
 =?utf-8?B?ZmhYSWtJYjBlNDJQbThNV3BuSVpWdHVlYnB3blFodm0zanYvMlNTMktGNDlB?=
 =?utf-8?B?eUpyTkdHcjR5RU1FcDlCbWtmMll4dSsyRnlRZklYR3FHMmxwMWU0WjhyVjNO?=
 =?utf-8?B?K2tsSlV5aHEzV2h2a0M3aVE1T1lJTkxCbE1VallOczcyYW9mTUJZdXRpMUNk?=
 =?utf-8?B?bFJOOHl0cG1hUjl5N3RKRWJpVzNIbFlIM1VqbW1wYlh6VmJvVnZCb1BvL3pq?=
 =?utf-8?B?NTZmMEZiV1dsUUNFUi90UWVwQ0tDZ1ZjNVJHOFVsYWpFMEhyNGFSOXE5V3lm?=
 =?utf-8?B?c3lWZEg2Nzg0Q3g2RjA2bWZ5ZzVFYStrRFppbEJoa1Jsc0M2U0FSaGZweXJL?=
 =?utf-8?B?RzhhNWV3Z2dKd3VnV2U2OFE3THZlWnBPS0ZPekdqS3B4OE1nM2JlUHRJQmUw?=
 =?utf-8?B?dk91bFBDTkRaaXhDbGRod1RFL2czN0ZMTEU3WnluMTlsM0FJTmdWd2drRmlE?=
 =?utf-8?B?UndkeXA5NDJIQUJPdkw0enVPdWV3WVdCeW5HeWpJcmNiZHdGbi9zV1NCeitT?=
 =?utf-8?B?ei9MWkRGYUVPQUdQMHRXQVU0MklkYWwxbTl4ZGJmeW1lbXlYczhIekJpZTlY?=
 =?utf-8?B?YzdtYXlSV1VUQklSdDRCTnNPUi9Yc2R2TzRmcGg5RVRkZVNITUhHNXY2U2xW?=
 =?utf-8?B?bk1xazlBRzl4VnhuQThHcVo5TmZEdjBCY0R0bE5haGJLemV5YzhHTlY2ZTha?=
 =?utf-8?B?TG1qcTNFV09tQUowMktJM0FOWmZFaldmQmN1UjdteVV0aGJhQnoyMVRuRnRt?=
 =?utf-8?B?VllTdjBGbEhwaS9kMHlsSTkycjE2NnRMc3I4UUdnQVBRYXBiTmtXMHYvbU0r?=
 =?utf-8?B?WmVkOVh5c0NjQm9iWVVmbXQwU0d5WWNLckk3Z2xuUVFwTlhud1NtN0lvU200?=
 =?utf-8?B?MjBMZU42TWpNMW9FN0t1ai80Y2FVRm5JVElJMHRWQ01JV3lUd0JzZ3VxMDhX?=
 =?utf-8?B?UGcydjhGU3lCcG9qTjgydWg1K2dNVElUY1k3M2tXcDhESVE2aUszL1d2UUlB?=
 =?utf-8?B?bVFBK3Vram5ybXRYOVJDbnZhRWUvdDVyaHdHRDJNRVlWK0d3eklQTmRJL2tX?=
 =?utf-8?B?dU1kdUlQcGxlZnRLM3BVRVlYekVMeVh1UmF6Z0xvejg0TnR6SDZHRTIrdGQ5?=
 =?utf-8?B?aXI3NG9icGI5bDNUSkNoanJtNnJlajIzTEVJWUtlU25tdy8xQlBCQ2ErMVAw?=
 =?utf-8?B?b3BFaVROempaSEZFeEpGc1c4OUFoSjN3Rjk1ZE51YVBwdzh5V29XTFBVcGg4?=
 =?utf-8?B?SktVU2RnN3hGcWg1SHdVQXFBZjl3R29SV0ZLWlZBVzR2RlUyQnNLMi9rMUc5?=
 =?utf-8?B?YUNIZzc5SFhmdXZ5ZjBXWk5menJzelZJVmRFOFoxUlZOMFdhWEloYmFFOHpu?=
 =?utf-8?B?MUZCcjRaYnV2SmRoU2IrRjVMWFAzUVF0Lzg5YisxRnNOQ2Q0Q2ZGK0Fub0Vl?=
 =?utf-8?B?NU8ySHl6VjZwRk55ZmFheC9Md0tPYnRMN0g1dkl3Tm5scW9KdVhCNWQ4K1NL?=
 =?utf-8?B?U3hvSzBjcHJaSXVnN0FHSjl3OXN6ckR1ZmVjUy9Fdndndkd0Y2RYNG1vWXBs?=
 =?utf-8?B?RE9NMXhVL3pQUnoveUUyWmk2Y204Y3J2V3VUNTRDSzlCOS9LVUdWM1dRYzlr?=
 =?utf-8?B?QVlmeGxNZThxK2hDeVk2c2VCcGREYnJid0E4T2MxcmFCVHFrVW10UEJZY2Uw?=
 =?utf-8?B?SEFPL3BuTkVQdmFBdWYrRjFMMU50UERSeEJSWVhGaDIra0lBM0F0REhndC9M?=
 =?utf-8?B?S202ZWF0VDQwc3d5ZVlERVZqYjdPYUl5aDRMYktrTVFNSlRJbWpuU3laeXRI?=
 =?utf-8?B?RFk1Z1J0SEtNQTVtQk9mM083SkV0d3dFZHg5TXRoUWtPUVZvN3EwWnh2QW9O?=
 =?utf-8?B?VkRjZE93K200bG9zYUtqeDNydG8vcXRXSWhscnMvUlFqUS9wME5LN3k3eGQ4?=
 =?utf-8?Q?oNkNfANhQWE/ERbrJfXY2HH7o?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c71f9681-6009-42d8-0448-08da61537988
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2022 02:33:57.9233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wHsHDYwNhmvr9MHRwY/14+sK50VylWkpI1Aim+amY8MrifBH0CJ/B6PcesHt2DG1xEVgntkkhQ1CNOaW1g57vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3823
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 7/7/2022 5:57 PM, Rob Herring wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Thu, 07 Jul 2022 13:42:55 +0530, Vidya Sagar wrote:
>> Add support for PCIe controllers that operate in the endpoint mode
>> in tegra234 chipset.
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ---
>> V4:
>> * Rebased on top of previous patch
>>
>> V3:
>> * New patch in this series
>>
>>   .../bindings/pci/nvidia,tegra194-pcie-ep.yaml | 123 +++++++++++++++++-
>>   1 file changed, 117 insertions(+), 6 deletions(-)
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.example.dtb: pcie-ep@141a0000: Unevaluated properties are not allowed ('nvidia,enable-ext-refclk' was unexpected)
>          From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/patch/
> 
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit.

I did run 'make dt_binding_check' before sending the patches for review 
and didn't observe any issue. Just to make sure that I observe the same 
issue locally, I updated dtschema and gave DT_CHECKER_FLAGS=-m and yet 
didn't observe the tool reporting any issue.
FWIW, I think I missed adding the documentation for 
'nvidia,enable-ext-refclk' property. I'll add it and send again, but 
before that, I would like to see if my change addresses the issue 
correctly and also there are no other issues. Could you please help me 
with why I'm not observing the issue locally?

FWIW, Here is the output I get with V4 patch.

vidya@vidya-virtual-machine:~/x/linux-next$ make DT_CHECKER_FLAGS=-m
dt_binding_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml

    LINT    Documentation/devicetree/bindings
    CHKDT   Documentation/devicetree/bindings/processed-schema.json
    SCHEMA  Documentation/devicetree/bindings/processed-schema.json
/home/vidya/x/linux-next/Documentation/devicetree/bindings/display/tegra/nvidia,tegra124-sor.yaml:
ignoring, error in schema: allOf: 1: if: not: properties
    DTEX
Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.example.dts
    DTC
Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.example.dtb
    CHECK
Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.example.dtb
vidya@vidya-virtual-machine:~/x/linux-next$

Thanks,
Vidya Sagar

> 
