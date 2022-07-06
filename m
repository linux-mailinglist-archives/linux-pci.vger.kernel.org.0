Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411E856844D
	for <lists+linux-pci@lfdr.de>; Wed,  6 Jul 2022 11:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbiGFJyi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Jul 2022 05:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbiGFJxy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Jul 2022 05:53:54 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2083.outbound.protection.outlook.com [40.107.102.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3E3B06;
        Wed,  6 Jul 2022 02:53:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SvnP4iI1jgmbqFigfypy+z+XvFn08IZigTaxDTaYLJkhZ1A3C3/y9mMcBk9tiR2TbA507pLstpSj6DfxXDp6DdZ/uu7wnxSZCMdDFR/+exlzETUdBVT9h3tvI6H/y83xwXjRvJSo5akBw4IvPq3ICS9DMFOeLBwnZ1LAHxi7qc51f8SH+FWye8WNsWyyrKiuHQrUncWs9ZGyU8ws3latyPHqtwEUMGbiKhbOXkZmjA6O+clkjNoJ0bgVeC2Kn76VHClXCTjcJ8QZjB1yOgBPQMW3g8ZCq6igS/XhunKe+sjtOTdOuwJCDBtB1G/DR3jXTNapFnGdRgmbucFBdT3CBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=14BvA8WAC1uIjq4hCELTnBIx21MENQnb9syJ5YtMyfw=;
 b=AyC8hzAe8sC6BMR6kWLZAMVPq/+q3Khr9FXR46R5ZoSvQgAdIVwx2NSp+Y4niW849F9x0z5u5lTiINOPTUpFQ/h6FrWnvUoJir+Ya+TnWfmDRi2LbsSGNvSTQMGyErywYi992/jDacYT9PEM6oZucEI7fR1FnXG3oMdBEeoHiB2y1OXqHXqvO0pwUabmg/hFikpj/fizuu8Tiv9OlYdEgUTUEr+7PpPZ1x7QSwE5HKZBuJojxdrTLCYQybLCOtF0SqpMDe/4Sb0ny9ANe6/c9W0x9YmXrzhgttPSWeLrNvOZTdyptuDSTHiBsZWSi7dvnpggjf30las424+TBE4xoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14BvA8WAC1uIjq4hCELTnBIx21MENQnb9syJ5YtMyfw=;
 b=XLdTEdJLkCLpW5i6+o7iMl2T9O33lOFjN2AgnrHWW0/xFNHXyZcLuGb6yXv7ZjsEbAOv18Z+RE11QrhI+is5Vgr6DFzOB2UwZAh4lv/nPc0K9JU5+mtn4TZxO04Agxh3X0SWKHEMKCWGNBxf5I/AQlRoGbUZFn6r+Uwe037EuNzaULug9FOzwQWZY+orKCuJH5BntXY+nq4fejpU3v/u1FBfSY5XIhHd2RIAkPv2ViyUynY8k8FIXLQi40NNwPJaIznq1hA1MxNMDR1+0Z4EffEEHmoAavA25g+NeCllB1LFvAcOSK3AVfXjI8Gqv5J9OoESYY+CjTgkdexsJ7KvpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB2900.namprd12.prod.outlook.com (2603:10b6:408:69::18)
 by MN2PR12MB3102.namprd12.prod.outlook.com (2603:10b6:208:c6::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Wed, 6 Jul
 2022 09:53:20 +0000
Received: from BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::3904:2c16:b3b7:c5f3]) by BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::3904:2c16:b3b7:c5f3%5]) with mapi id 15.20.5395.022; Wed, 6 Jul 2022
 09:53:20 +0000
Message-ID: <e971a557-3387-efcf-87ec-983b998c5e93@nvidia.com>
Date:   Wed, 6 Jul 2022 15:23:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V3 02/11] dt-bindings: pci: tegra: Convert to json-schema
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, kishon@ti.com,
        vkoul@kernel.org, kw@linux.com, krzk@kernel.org,
        p.zabel@pengutronix.de, mperttunen@nvidia.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com,
        Thierry Reding <treding@nvidia.com>
References: <20220629060435.25297-1-vidyas@nvidia.com>
 <20220629060435.25297-3-vidyas@nvidia.com>
 <20220630210449.GA3283899-robh@kernel.org>
From:   Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <20220630210449.GA3283899-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXPR0101CA0033.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:d::19) To BN8PR12MB2900.namprd12.prod.outlook.com
 (2603:10b6:408:69::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef29198f-1059-47c2-1583-08da5f355b92
X-MS-TrafficTypeDiagnostic: MN2PR12MB3102:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZGdyVkJFclpLR0xSUGFCWjJxb3gzQ1k0bzNBa0I1bnE2NDUrVXRWbXFGN0U2?=
 =?utf-8?B?Z0NIdEFVbWFGSTRPOTY4NW5mWmN0TkhVdkszQmltUnE4OFZwS2NLcVZLV1dY?=
 =?utf-8?B?T2ZRYW5tbEc0YkZlWWZWcytocGIyaEx5Q3A2UXgzMmRQWnMxRGt3RStjMWJ1?=
 =?utf-8?B?QytoZUdxVEVsMy9RSG0yb2dnNmVvWjMwamMvYzArUkZYU2x3MThyOGxjTzUw?=
 =?utf-8?B?QW1TWXNrb2gxdXJLam45OU95cXl5MDhHMEgzaTQ4dk1ISGNMT2tOb2NzMlNF?=
 =?utf-8?B?bi9Wb0lqdnZCeXVGM0hLN2NYUXJ2OXZtVDVtbm1LbDVjRGdTSGM3K3NsSW9Y?=
 =?utf-8?B?V3pDenQ2WVFYcm9DRmx4RlRUYU1WRkdXUGg5Z3YwZjk3SU5TVnB6dXFCNytS?=
 =?utf-8?B?RE14RU9WcGhZL2dRWVB2Y25yMnQ3Tis4eTl2enNOYUxvdTlMTEVHVzAxQUVh?=
 =?utf-8?B?NGJBWE5lcXJic0hjMEQvUWtkcHB2RG50cExsbkdudVVjdlVYVWN4ZWg1RklK?=
 =?utf-8?B?VmplQ2o0VitTQ3VLL012eHNuSkFZaXdNRW9iOWxIbG5tclZ4TGVQSy9hWHNq?=
 =?utf-8?B?eGp1ZkI1Y3hXZ21IRnFPK1pBVTZHS0pUaUFydVhkcG9aU05abGNHRjRxbWM1?=
 =?utf-8?B?V0pmWHRmNFhnQ3h2MkZ3eUR5TlF3ZWoycGFWTXU5QUxCMGprN09EbXlKWXJL?=
 =?utf-8?B?MTdBTVZEQlFNZnZIWkM3ZkUzaFhlVUMvYWtYZjZNN2xsVThiK3JXeW1zRmF0?=
 =?utf-8?B?MTc1TiszZlpTd042SjZDd3Z0WENYR2ZQWXBicDBFWVRYWHdiUnhQNE9mQ3dO?=
 =?utf-8?B?SzZ4aEtIZWh0Ukt2M3RZWWtjRlZhK21hc05pYzhtejdQM3YvZ2ZCUXlDcjNv?=
 =?utf-8?B?dkxlRzBiaUVLTFRwOEJNUUpZdHE3QjlBcm8vYWl0MXJmKyszTmUxbFBYRjNs?=
 =?utf-8?B?Q0QrVmg1aUd0U0tGM092aVRxOG5ienI2Z2o5dks3eERGY1JIekdyUEl6RE1E?=
 =?utf-8?B?OXFrV2RhelErYThHaTRTRXUxTlZYcFJ3Mmtrd09tWmFCd0JFdnRzL1dpdnhy?=
 =?utf-8?B?Z0VzTU1TcDNUQkhabjhrWVZ5VlF4RFRXaUxRTGFuUUdBcVI1cGpYTjYxLzhw?=
 =?utf-8?B?WHA0czJub2pzRmZGL3NreUtRb01sbTJ0K3g3ZGkvbzlUUW4zdEErVmVCSWRU?=
 =?utf-8?B?U3hLVE1UdzBXTVJ4dldOYk9VYTFHYlRmL1ZTdWYwSUdpZ1NwY3R3RVU1enEz?=
 =?utf-8?B?T3VKTTFuZDZ2enNGQ1lpR1ZibUV4V2JkMUVGN01kTDgwc1ArUUF1dUVLRllJ?=
 =?utf-8?Q?qIkGXxOAVQPyA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(346002)(39860400002)(136003)(396003)(66946007)(83380400001)(2906002)(36756003)(31686004)(8676002)(66556008)(66476007)(2616005)(6506007)(4326008)(186003)(6666004)(107886003)(38100700002)(316002)(6486002)(30864003)(6512007)(26005)(966005)(7416002)(478600001)(41300700001)(6916009)(8936002)(53546011)(31696002)(86362001)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TklGTEFYeDhDQlFjSmdoWHdRaHltS0JrTGRrVGFwUjN4RTJ2ejdlMmtoUU51?=
 =?utf-8?B?Z0MrS0IxeXBDNTJTOVJsZ2tpMmVjWk5wZ2ltZzB4ZU1XbkZSYUp6cERuWXFE?=
 =?utf-8?B?WUN4dC9tMnRRVVc0TGdLbzM3OTB3bkZYQlBPdnphNHgrMjJQVisxVGZsNHVJ?=
 =?utf-8?B?TmFCZ3dNLzRwazJuOTVaZUk4dXJuVXlpR3RYWjFubFA2UDRCSnJRWkdSWEVN?=
 =?utf-8?B?NFp3cTNRV1F1U1hubzJuTHRXREUxZHhDQ3JzOXd0NnI1enZHd3dKS25Id0Ey?=
 =?utf-8?B?aGM0MjdYbXdwWUlMUkhrb3B5WVRhTGgrTEJxaHRYQkJxU3BLWU50amwzVkVR?=
 =?utf-8?B?MjJPRzB4b2djUCtlTTFnc1c3QXM4VWZsOVA3dk1LdHJKWFRPRHBMKzk5UGFV?=
 =?utf-8?B?N3RLcVlaUHRETkM0endTZFJCd1JRcnJBNDdqdHlmS2t3bjd2L2RMaHgxWllW?=
 =?utf-8?B?aDNNbjJuZ1BHM1dzbjgrRjNaN2FnNFZDWmFjeWdQaHM1OTZUenZRVUNjdHR5?=
 =?utf-8?B?N0g4ZlJ4Q1gvRkhXdjd2UkZ6eWd6clhZbm1rWDdlSThBY0pIMEd0VHZVS1BC?=
 =?utf-8?B?VjFZTGFKdXdSQmF5Q3lYRHBNMDF3YytPRjczSWlTUXpUTDUzanl0eEg2R0tD?=
 =?utf-8?B?dXdPQmwwY214US8xREpHV0N1Sk9nRUowSHUvMW1xdENubVlSdStydkU5TklM?=
 =?utf-8?B?TytXZjRpZmJBUkhzbTh0d1g2N2RUc1FOOVlBUmY5YWtRUTFoMjVBYk1tQ0Va?=
 =?utf-8?B?Nkl6UzVjVnVPamRtWXczUWZLNSsxQ01SUTYzUWQ4ZUdxbldkUWxYelpKVlFO?=
 =?utf-8?B?VnJSMHdpaXNTMEhUTjdpS1JZL1VmMGh5Umk2M3dyVTAyYjBpOTBQdmxGbHJC?=
 =?utf-8?B?UWZia0d5Rzc5OGNYOG9RT0V3TG84TURQWU1GYWozTWc4VnhsaEk0RjRvY2gx?=
 =?utf-8?B?cnZ4RWpsbGtoZGxBL0NiaytXSVAvNnZ2Y2EzZ1c5OWhVNWxNd0NlWHNrZ2lW?=
 =?utf-8?B?eW54aXRZaVN2UlJBVmJMemFxRGlqM3dTeWxOajdmQXNiVGtQVkRHRXhSMW5Z?=
 =?utf-8?B?WXJteXlZWEMyL3hNejVkQjdjZ2xMWkcwNnRHVjFJNUp1eG9sMzlDV0VGVDdX?=
 =?utf-8?B?U0lwRDNGOWpBQmIya0F1eFNvNFFBbW1DMk5hazlYU0ltUTdDNUJ3L2N3OFNz?=
 =?utf-8?B?U21iWWlrcVVqSitqY1h5dkliVVdSd1p0eDhURitFZis2YUtaMzBieWNSdW5L?=
 =?utf-8?B?M0FZOTJpTW45NVBMRkYzVGUvVW9VUzNCUTZTMEJsOStyWGxUZTVnaDdEVUFo?=
 =?utf-8?B?d3g3TnhtajhvTmJjRi9WdGhLckdhbUllVDZRaE85bU9rK2hsTVMza1UzMmVy?=
 =?utf-8?B?VzQxSlNoTHgraThJYTVpakI1QTBab3ZiRkxyRjVQUGRQc290U3VDRTlSbnJ1?=
 =?utf-8?B?Qjcrd1NtK04vRzhKVDFVcU9relZoQ24vRTZjMGdERWhkbVRHMTV4U00vWVZ3?=
 =?utf-8?B?RS9oSmtvZXRCejRQVUtPSGh3cXJFTmJCRWRpU2liYXRSVXZuRERoSUZKNmQr?=
 =?utf-8?B?eHRNT0U4dHkreUhpZ2dFalJFSjBTVHFOb1haOVU4UEtkQ3ExdFBHWEdIdlRB?=
 =?utf-8?B?OW5wc09wSi9yYlRWRFgrbjdwRVdvRk1uYy9SQXJtS2NZRTNJdGcvdlBHUGtl?=
 =?utf-8?B?Y0JkcllibUdzZG5laC9KVWp3K2l6eE1pWVlLcHJRYit0bFFNR010Zkt2c3FM?=
 =?utf-8?B?STBDWU5xTkdyVFcwR3o0c3BVVUhOVEd2bVB0bVVZdHFta2g4MkEyK0g1VzFJ?=
 =?utf-8?B?Z3ZDc3p4NFhUVkg2UW5kSmRudVpoWDZLT3NKbmFrVFY4UUlXSmk2aDVZdXkw?=
 =?utf-8?B?cGhrTTB0Rmc1MUFYQ2IwT1M2MjZXNzZPYVVHMWtUaE5LaEVtaFRWd1MrZW42?=
 =?utf-8?B?ZUVBV2VqS3JHZ2s3eGovam02a24xVzJicHMvM3ZNelA3SUZ1Z0QrZXVHc2k5?=
 =?utf-8?B?MHdFdlhPcXA2TkpZU0ZTR1BiVERJSXZFTVAydnNPV1pteW9lRFVyZDN3QkNP?=
 =?utf-8?B?eTVxMktYQWZlOGJJUWVzSVpZK0Uwem11cFNHQTBwbTdtWU04RnJHZU45VkNP?=
 =?utf-8?Q?GkPbO1MJUJyY9ERdSr+TEf8QT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef29198f-1059-47c2-1583-08da5f355b92
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 09:53:20.3989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /HURo6/ctDL6KtbgyZi66fgeSnQPDsrmzPxFwEoom0uqB3HBk5rldK+1fZMTM/akJB5xKKij3pO/iCrST6lLKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3102
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



On 7/1/2022 2:34 AM, Rob Herring wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Wed, Jun 29, 2022 at 11:34:26AM +0530, Vidya Sagar wrote:
>> From: Thierry Reding <treding@nvidia.com>
>>
>> Convert the Tegra194 PCIe bindings from the free-form text format to
>> json-schema.
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> Signed-off-by: Thierry Reding <treding@nvidia.com>
>> ---
>> V3:
>> * New patch in this series. Added as part of addressing Rob's review
>>    comment to convert the existing .txt file to .yaml schema
>>
>>   .../bindings/pci/nvidia,tegra194-pcie-ep.yaml | 239 ++++++++++++++++
>>   .../bindings/pci/nvidia,tegra194-pcie.txt     | 245 -----------------
>>   .../bindings/pci/nvidia,tegra194-pcie.yaml    | 254 ++++++++++++++++++
>>   .../devicetree/bindings/pci/snps,dw-pcie.yaml |   2 +-
>>   4 files changed, 494 insertions(+), 246 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml
>>   delete mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
>>   create mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml
>> new file mode 100644
>> index 000000000000..4f7cb7fe378e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml
>> @@ -0,0 +1,239 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/pci/nvidia,tegra194-pcie-ep.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: NVIDIA Tegra194 (and later) PCIe endpoint controller (Synopsys DesignWare Core based)
>> +
>> +maintainers:
>> +  - Thierry Reding <thierry.reding@gmail.com>
>> +  - Jon Hunter <jonathanh@nvidia.com>
>> +  - Vidya Sagar <vidyas@nvidia.com>
>> +
>> +description: |
>> +  This PCIe controller is based on the Synopsis Designware PCIe IP and thus inherits all the common
> 
> Wrap lines at 80 unless there's a benefit to a longer line.
> 
>> +  properties defined in snps,dw-pcie-ep.yaml. Some of the controller instances are dual mode where
>> +  in they can work either in root port mode or endpoint mode but one at a time.
>> +
>> +  On Tegra194, controllers C0, C4 and C5 support endpoint mode.
>> +
>> +  Note: On Tegra194's P2972-0000 platform, only C5 controller can be enabled to operate in the
>> +  endpoint mode because of the way the platform is designed.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - nvidia,tegra194-pcie-ep
>> +
>> +  reg:
>> +    items:
>> +      - description: controller's application logic registers
>> +      - description: iATU and DMA registers. This is where the iATU (internal Address Translation
>> +          Unit) registers of the PCIe core are made available for software access.
>> +      - description: The aperture where the root port's own configuration registers are available.
>> +      - description: Aperture used to map the remote root-complex' address space.
>> +
>> +  reg-names:
>> +    items:
>> +      - const: appl
>> +      - const: atu_dma
>> +      - const: dbi
>> +      - const: addr_space
>> +
>> +  interrupts:
>> +    items:
>> +      - description: controller interrupt
> 
> Just 'maxItems: 1' is enough.
> 
>> +
>> +  interrupt-names:
>> +    items:
>> +      - const: intr
>> +
>> +  clocks:
>> +    items:
>> +      - description: module clock
>> +
>> +  clock-names:
>> +    items:
>> +      - const: core
>> +
>> +  resets:
>> +    items:
>> +      - description: APB bus interface reset
>> +      - description: module reset
>> +
>> +  reset-names:
>> +    items:
>> +      - const: apb
>> +      - const: core
>> +
>> +  reset-gpios:
>> +    description: Must contain a phandle to a GPIO controller followed by GPIO that is being used as
>> +      PERST input signal. Please refer to pci.txt document.
>> +
>> +  phys:
>> +    minItems: 1
>> +    maxItems: 16
> 
> One per lane?
> 
>> +
>> +  phy-names:
>> +    minItems: 1
>> +    maxItems: 16
>> +    items:
>> +      pattern: "^p2u-[0-9]+$"
>> +
>> +  power-domains:
>> +    description: |
>> +      A phandle to the node that controls power to the respective PCIe controller and a specifier
>> +      name for the PCIe controller. Following are the specifiers for the different PCIe
>> +      controllers:
>> +
>> +        - TEGRA194_POWER_DOMAIN_PCIEX8B: C0
>> +        - TEGRA194_POWER_DOMAIN_PCIEX1A: C1
>> +        - TEGRA194_POWER_DOMAIN_PCIEX1A: C2
>> +        - TEGRA194_POWER_DOMAIN_PCIEX1A: C3
>> +        - TEGRA194_POWER_DOMAIN_PCIEX4A: C4
>> +        - TEGRA194_POWER_DOMAIN_PCIEX8A: C5
>> +
>> +      these specifiers are defined in "include/dt-bindings/power/tegra194-powergate.h" file.
>> +
>> +  interconnects:
>> +    items:
>> +      - description: memory read client
>> +      - description: memory write client
>> +
>> +  interconnect-names:
>> +    items:
>> +      - const: dma-mem # read
>> +      - const: write
>> +
>> +  dma-coherent: true
>> +
>> +  num-ib-windows:
>> +    description: number of inbound address translation windows
>> +    maxItems: 1
>> +    deprecated: true
>> +
>> +  num-ob-windows:
>> +    description: number of outbound address translation windows
>> +    maxItems: 1
>> +    deprecated: true
>> +
>> +  nvidia,bpmp:
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +    description: |
>> +      Must contain a pair of phandle to BPMP controller node followed by controller ID. Following
>> +      are the controller IDs for each controller:
>> +
>> +        0: C0
>> +        1: C1
>> +        2: C2
>> +        3: C3
>> +        4: C4
>> +        5: C5
>> +    items:
>> +      - items:
>> +          - minimum: 0
>> +            maximum: 0xffffffff
> 
> That's already the limit. Just a description is fine.
> 
>> +          - enum: [ 0, 1, 2, 3, 4, 5 ]
> 
> maximum: 5

Setting the maximum to '5' is resulting in the following error.

pcie-ep@141a0000: nvidia,bpmp:0:0: 4294967295 is greater than the 
maximum of 5

Could you please help me understand why I'm seeing this error?

Thanks,
Vidya Sagar

> 
>> +
>> +  nvidia,aspm-cmrt-us:
>> +    description: Common Mode Restore Time for proper operation of ASPM to be specified in
>> +      microseconds
>> +
>> +  nvidia,aspm-pwr-on-t-us:
>> +    description: Power On time for proper operation of ASPM to be specified in microseconds
>> +
>> +  nvidia,aspm-l0s-entrance-latency-us:
>> +    description: ASPM L0s entrance latency to be specified in microseconds
>> +
>> +  vddio-pex-ctl-supply:
>> +    description: A phandle to the regulator supply for PCIe side band signals.
>> +
>> +  nvidia,refclk-select-gpios:
>> +    description: Must contain a phandle to a GPIO controller followed by GPIO that is being used to
> 
> Don't need generic description of the GPIO binding.
> 
>> +      enable REFCLK to controller from host
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> 
> Already has a type.
> 
>> +
>> +allOf:
>> +  - $ref: "/schemas/pci/pci-ep.yaml#"
>> +
>> +unevaluatedProperties: false
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - reg-names
>> +  - num-ib-windows
>> +  - num-ob-windows
>> +  - interrupts
>> +  - interrupt-names
>> +  - clocks
>> +  - clock-names
>> +  - resets
>> +  - reset-names
>> +  - power-domains
>> +  - reset-gpios
>> +  - num-lanes
>> +  - phys
>> +  - phy-names
>> +  - nvidia,bpmp
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/tegra194-clock.h>
>> +    #include <dt-bindings/gpio/tegra194-gpio.h>
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/power/tegra194-powergate.h>
>> +    #include <dt-bindings/reset/tegra194-reset.h>
>> +
>> +    bus@0 {
>> +        #address-cells = <2>;
>> +        #size-cells = <2>;
>> +        ranges = <0x0 0x0 0x0 0x8 0x0>;
>> +
>> +        pcie-ep@141a0000 {
>> +            compatible = "nvidia,tegra194-pcie-ep";
>> +            reg = <0x00 0x141a0000 0x0 0x00020000>, /* appl registers (128K)      */
>> +                  <0x00 0x3a040000 0x0 0x00040000>, /* iATU_DMA reg space (256K)  */
>> +                  <0x00 0x3a080000 0x0 0x00040000>, /* DBI reg space (256K)       */
>> +                  <0x1c 0x00000000 0x4 0x00000000>; /* Address Space (16G)        */
>> +            reg-names = "appl", "atu_dma", "dbi", "addr_space";
>> +            interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
>> +            interrupt-names = "intr";
>> +
>> +            clocks = <&bpmp TEGRA194_CLK_PEX1_CORE_5>;
>> +            clock-names = "core";
>> +
>> +            resets = <&bpmp TEGRA194_RESET_PEX1_CORE_5_APB>,
>> +                     <&bpmp TEGRA194_RESET_PEX1_CORE_5>;
>> +            reset-names = "apb", "core";
>> +
>> +            power-domains = <&bpmp TEGRA194_POWER_DOMAIN_PCIEX8A>;
>> +            pinctrl-names = "default";
>> +            pinctrl-0 = <&clkreq_c5_bi_dir_state>;
>> +
>> +            nvidia,bpmp = <&bpmp 5>;
>> +
>> +            nvidia,aspm-cmrt-us = <60>;
>> +            nvidia,aspm-pwr-on-t-us = <20>;
>> +            nvidia,aspm-l0s-entrance-latency-us = <3>;
>> +
>> +            vddio-pex-ctl-supply = <&vdd_1v8ao>;
>> +
>> +            reset-gpios = <&gpio TEGRA194_MAIN_GPIO(GG, 1) GPIO_ACTIVE_LOW>;
>> +
>> +            nvidia,refclk-select-gpios = <&gpio_aon TEGRA194_AON_GPIO(AA, 5)
>> +                                          GPIO_ACTIVE_HIGH>;
>> +
>> +            num-lanes = <8>;
>> +            num-ib-windows = <2>;
>> +            num-ob-windows = <8>;
>> +
>> +            phys = <&p2u_nvhs_0>, <&p2u_nvhs_1>, <&p2u_nvhs_2>,
>> +                   <&p2u_nvhs_3>, <&p2u_nvhs_4>, <&p2u_nvhs_5>,
>> +                   <&p2u_nvhs_6>, <&p2u_nvhs_7>;
>> +
>> +            phy-names = "p2u-0", "p2u-1", "p2u-2", "p2u-3", "p2u-4",
>> +                        "p2u-5", "p2u-6", "p2u-7";
>> +        };
>> +    };
>> diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
>> deleted file mode 100644
>> index 8e4f9bfb316d..000000000000
>> --- a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
>> +++ /dev/null
>> @@ -1,245 +0,0 @@
>> -NVIDIA Tegra PCIe controller (Synopsys DesignWare Core based)
>> -
>> -This PCIe controller is based on the Synopsis Designware PCIe IP
>> -and thus inherits all the common properties defined in snps,dw-pcie.yaml and
>> -snps,dw-pcie-ep.yaml.
>> -Some of the controller instances are dual mode where in they can work either
>> -in root port mode or endpoint mode but one at a time.
>> -
>> -Required properties:
>> -- power-domains: A phandle to the node that controls power to the respective
>> -  PCIe controller and a specifier name for the PCIe controller. Following are
>> -  the specifiers for the different PCIe controllers
>> -    TEGRA194_POWER_DOMAIN_PCIEX8B: C0
>> -    TEGRA194_POWER_DOMAIN_PCIEX1A: C1
>> -    TEGRA194_POWER_DOMAIN_PCIEX1A: C2
>> -    TEGRA194_POWER_DOMAIN_PCIEX1A: C3
>> -    TEGRA194_POWER_DOMAIN_PCIEX4A: C4
>> -    TEGRA194_POWER_DOMAIN_PCIEX8A: C5
>> -  these specifiers are defined in
>> -  "include/dt-bindings/power/tegra194-powergate.h" file.
>> -- reg: A list of physical base address and length pairs for each set of
>> -  controller registers. Must contain an entry for each entry in the reg-names
>> -  property.
>> -- reg-names: Must include the following entries:
>> -  "appl": Controller's application logic registers
>> -  "config": As per the definition in snps,dw-pcie.yaml
>> -  "atu_dma": iATU and DMA registers. This is where the iATU (internal Address
>> -             Translation Unit) registers of the PCIe core are made available
>> -             for SW access.
>> -  "dbi": The aperture where root port's own configuration registers are
>> -         available
>> -- interrupts: A list of interrupt outputs of the controller. Must contain an
>> -  entry for each entry in the interrupt-names property.
>> -- interrupt-names: Must include the following entries:
>> -  "intr": The Tegra interrupt that is asserted for controller interrupts
>> -- clocks: Must contain an entry for each entry in clock-names.
>> -  See ../clocks/clock-bindings.txt for details.
>> -- clock-names: Must include the following entries:
>> -  - core
>> -- resets: Must contain an entry for each entry in reset-names.
>> -  See ../reset/reset.txt for details.
>> -- reset-names: Must include the following entries:
>> -  - apb
>> -  - core
>> -- phys: Must contain a phandle to P2U PHY for each entry in phy-names.
>> -- phy-names: Must include an entry for each active lane.
>> -  "p2u-N": where N ranges from 0 to one less than the total number of lanes
>> -- nvidia,bpmp: Must contain a pair of phandle to BPMP controller node followed
>> -  by controller-id. Following are the controller ids for each controller.
>> -    0: C0
>> -    1: C1
>> -    2: C2
>> -    3: C3
>> -    4: C4
>> -    5: C5
>> -- vddio-pex-ctl-supply: Regulator supply for PCIe side band signals
>> -
>> -RC mode:
>> -- compatible: Tegra19x must contain  "nvidia,tegra194-pcie"
>> -- device_type: Must be "pci" for RC mode
>> -- interrupt-names: Must include the following entries:
>> -  "msi": The Tegra interrupt that is asserted when an MSI is received
>> -- bus-range: Range of bus numbers associated with this controller
>> -- #address-cells: Address representation for root ports (must be 3)
>> -  - cell 0 specifies the bus and device numbers of the root port:
>> -    [23:16]: bus number
>> -    [15:11]: device number
>> -  - cell 1 denotes the upper 32 address bits and should be 0
>> -  - cell 2 contains the lower 32 address bits and is used to translate to the
>> -    CPU address space
>> -- #size-cells: Size representation for root ports (must be 2)
>> -- ranges: Describes the translation of addresses for root ports and standard
>> -  PCI regions. The entries must be 7 cells each, where the first three cells
>> -  correspond to the address as described for the #address-cells property
>> -  above, the fourth and fifth cells are for the physical CPU address to
>> -  translate to and the sixth and seventh cells are as described for the
>> -  #size-cells property above.
>> -  - Entries setup the mapping for the standard I/O, memory and
>> -    prefetchable PCI regions. The first cell determines the type of region
>> -    that is setup:
>> -    - 0x81000000: I/O memory region
>> -    - 0x82000000: non-prefetchable memory region
>> -    - 0xc2000000: prefetchable memory region
>> -  Please refer to the standard PCI bus binding document for a more detailed
>> -  explanation.
>> -- #interrupt-cells: Size representation for interrupts (must be 1)
>> -- interrupt-map-mask and interrupt-map: Standard PCI IRQ mapping properties
>> -  Please refer to the standard PCI bus binding document for a more detailed
>> -  explanation.
>> -
>> -EP mode:
>> -In Tegra194, Only controllers C0, C4 & C5 support EP mode.
>> -- compatible: Tegra19x must contain "nvidia,tegra194-pcie-ep"
>> -- reg-names: Must include the following entries:
>> -  "addr_space": Used to map remote RC address space
>> -- reset-gpios: Must contain a phandle to a GPIO controller followed by
>> -  GPIO that is being used as PERST input signal. Please refer to pci.txt
>> -  document.
>> -
>> -Optional properties:
>> -- pinctrl-names: A list of pinctrl state names.
>> -  It is mandatory for C5 controller and optional for other controllers.
>> -  - "default": Configures PCIe I/O for proper operation.
>> -- pinctrl-0: phandle for the 'default' state of pin configuration.
>> -  It is mandatory for C5 controller and optional for other controllers.
>> -- supports-clkreq: Refer to Documentation/devicetree/bindings/pci/pci.txt
>> -- nvidia,update-fc-fixup: This is a boolean property and needs to be present to
>> -    improve performance when a platform is designed in such a way that it
>> -    satisfies at least one of the following conditions thereby enabling root
>> -    port to exchange optimum number of FC (Flow Control) credits with
>> -    downstream devices
>> -    1. If C0/C4/C5 run at x1/x2 link widths (irrespective of speed and MPS)
>> -    2. If C0/C1/C2/C3/C4/C5 operate at their respective max link widths and
>> -       a) speed is Gen-2 and MPS is 256B
>> -       b) speed is >= Gen-3 with any MPS
>> -- nvidia,aspm-cmrt-us: Common Mode Restore Time for proper operation of ASPM
>> -   to be specified in microseconds
>> -- nvidia,aspm-pwr-on-t-us: Power On time for proper operation of ASPM to be
>> -   specified in microseconds
>> -- nvidia,aspm-l0s-entrance-latency-us: ASPM L0s entrance latency to be
>> -   specified in microseconds
>> -
>> -RC mode:
>> -- vpcie3v3-supply: A phandle to the regulator node that supplies 3.3V to the slot
>> -  if the platform has one such slot. (Ex:- x16 slot owned by C5 controller
>> -  in p2972-0000 platform).
>> -- vpcie12v-supply: A phandle to the regulator node that supplies 12V to the slot
>> -  if the platform has one such slot. (Ex:- x16 slot owned by C5 controller
>> -  in p2972-0000 platform).
>> -
>> -EP mode:
>> -- nvidia,refclk-select-gpios: Must contain a phandle to a GPIO controller
>> -  followed by GPIO that is being used to enable REFCLK to controller from host
>> -
>> -NOTE:- On Tegra194's P2972-0000 platform, only C5 controller can be enabled to
>> -operate in the endpoint mode because of the way the platform is designed.
>> -
>> -Examples:
>> -=========
>> -
>> -Tegra194 RC mode:
>> ------------------
>> -
>> -     pcie@14180000 {
>> -             compatible = "nvidia,tegra194-pcie";
>> -             power-domains = <&bpmp TEGRA194_POWER_DOMAIN_PCIEX8B>;
>> -             reg = <0x00 0x14180000 0x0 0x00020000   /* appl registers (128K)      */
>> -                    0x00 0x38000000 0x0 0x00040000   /* configuration space (256K) */
>> -                    0x00 0x38040000 0x0 0x00040000>; /* iATU_DMA reg space (256K)  */
>> -             reg-names = "appl", "config", "atu_dma";
>> -
>> -             #address-cells = <3>;
>> -             #size-cells = <2>;
>> -             device_type = "pci";
>> -             num-lanes = <8>;
>> -             linux,pci-domain = <0>;
>> -
>> -             pinctrl-names = "default";
>> -             pinctrl-0 = <&pex_rst_c5_out_state>, <&clkreq_c5_bi_dir_state>;
>> -
>> -             clocks = <&bpmp TEGRA194_CLK_PEX0_CORE_0>;
>> -             clock-names = "core";
>> -
>> -             resets = <&bpmp TEGRA194_RESET_PEX0_CORE_0_APB>,
>> -                      <&bpmp TEGRA194_RESET_PEX0_CORE_0>;
>> -             reset-names = "apb", "core";
>> -
>> -             interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,  /* controller interrupt */
>> -                          <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;  /* MSI interrupt */
>> -             interrupt-names = "intr", "msi";
>> -
>> -             #interrupt-cells = <1>;
>> -             interrupt-map-mask = <0 0 0 0>;
>> -             interrupt-map = <0 0 0 0 &gic GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
>> -
>> -             nvidia,bpmp = <&bpmp 0>;
>> -
>> -             supports-clkreq;
>> -             nvidia,aspm-cmrt-us = <60>;
>> -             nvidia,aspm-pwr-on-t-us = <20>;
>> -             nvidia,aspm-l0s-entrance-latency-us = <3>;
>> -
>> -             bus-range = <0x0 0xff>;
>> -             ranges = <0x81000000 0x0  0x38100000 0x0  0x38100000 0x0 0x00100000    /* downstream I/O (1MB) */
>> -                       0x82000000 0x0  0x38200000 0x0  0x38200000 0x0 0x01E00000    /* non-prefetchable memory (30MB) */
>> -                       0xc2000000 0x18 0x00000000 0x18 0x00000000 0x4 0x00000000>;  /* prefetchable memory (16GB) */
>> -
>> -             vddio-pex-ctl-supply = <&vdd_1v8ao>;
>> -             vpcie3v3-supply = <&vdd_3v3_pcie>;
>> -             vpcie12v-supply = <&vdd_12v_pcie>;
>> -
>> -             phys = <&p2u_hsio_2>, <&p2u_hsio_3>, <&p2u_hsio_4>,
>> -                    <&p2u_hsio_5>;
>> -             phy-names = "p2u-0", "p2u-1", "p2u-2", "p2u-3";
>> -     };
>> -
>> -Tegra194 EP mode:
>> ------------------
>> -
>> -     pcie-ep@141a0000 {
>> -             compatible = "nvidia,tegra194-pcie-ep", "snps,dw-pcie-ep";
>> -             power-domains = <&bpmp TEGRA194_POWER_DOMAIN_PCIEX8A>;
>> -             reg = <0x00 0x141a0000 0x0 0x00020000   /* appl registers (128K)      */
>> -                    0x00 0x3a040000 0x0 0x00040000   /* iATU_DMA reg space (256K)  */
>> -                    0x00 0x3a080000 0x0 0x00040000   /* DBI reg space (256K)       */
>> -                    0x1c 0x00000000 0x4 0x00000000>; /* Address Space (16G)        */
>> -             reg-names = "appl", "atu_dma", "dbi", "addr_space";
>> -
>> -             num-lanes = <8>;
>> -             num-ib-windows = <2>;
>> -             num-ob-windows = <8>;
>> -
>> -             pinctrl-names = "default";
>> -             pinctrl-0 = <&clkreq_c5_bi_dir_state>;
>> -
>> -             clocks = <&bpmp TEGRA194_CLK_PEX1_CORE_5>;
>> -             clock-names = "core";
>> -
>> -             resets = <&bpmp TEGRA194_RESET_PEX1_CORE_5_APB>,
>> -                      <&bpmp TEGRA194_RESET_PEX1_CORE_5>;
>> -             reset-names = "apb", "core";
>> -
>> -             interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;  /* controller interrupt */
>> -             interrupt-names = "intr";
>> -
>> -             nvidia,bpmp = <&bpmp 5>;
>> -
>> -             nvidia,aspm-cmrt-us = <60>;
>> -             nvidia,aspm-pwr-on-t-us = <20>;
>> -             nvidia,aspm-l0s-entrance-latency-us = <3>;
>> -
>> -             vddio-pex-ctl-supply = <&vdd_1v8ao>;
>> -
>> -             reset-gpios = <&gpio TEGRA194_MAIN_GPIO(GG, 1) GPIO_ACTIVE_LOW>;
>> -
>> -             nvidia,refclk-select-gpios = <&gpio_aon TEGRA194_AON_GPIO(AA, 5)
>> -                                           GPIO_ACTIVE_HIGH>;
>> -
>> -             phys = <&p2u_nvhs_0>, <&p2u_nvhs_1>, <&p2u_nvhs_2>,
>> -                    <&p2u_nvhs_3>, <&p2u_nvhs_4>, <&p2u_nvhs_5>,
>> -                    <&p2u_nvhs_6>, <&p2u_nvhs_7>;
>> -
>> -             phy-names = "p2u-0", "p2u-1", "p2u-2", "p2u-3", "p2u-4",
>> -                         "p2u-5", "p2u-6", "p2u-7";
>> -     };
>> diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
>> new file mode 100644
>> index 000000000000..4a49dddf33bb
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
>> @@ -0,0 +1,254 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/pci/nvidia,tegra194-pcie.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: NVIDIA Tegra194 (and later) PCIe controller (Synopsys DesignWare Core based)
>> +
>> +maintainers:
>> +  - Thierry Reding <thierry.reding@gmail.com>
>> +  - Jon Hunter <jonathanh@nvidia.com>
>> +  - Vidya Sagar <vidyas@nvidia.com>
>> +
>> +description: |
>> +  This PCIe controller is based on the Synopsis Designware PCIe IP and thus inherits all the common
>> +  properties defined in snps,dw-pcie.yaml. Some of the controller instances are dual mode where in
>> +  they can work either in root port mode or endpoint mode but one at a time.
>> +
>> +  See nvidia,tegra194-pcie-ep.yaml for details on the endpoint mode device tree bindings.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - nvidia,tegra194-pcie
>> +
>> +  reg:
>> +    items:
>> +      - description: controller's application logic registers
>> +      - description: configuration registers
>> +      - description: iATU and DMA registers. This is where the iATU (internal Address Translation
>> +          Unit) registers of the PCIe core are made available for software access.
>> +      - description: The aperture where the root port's own configuration registers are available.
>> +
>> +  reg-names:
>> +    items:
>> +      - const: appl
>> +      - const: config
>> +      - const: atu_dma
>> +      - const: dbi
>> +
>> +  interrupts:
>> +    items:
>> +      - description: controller interrupt
>> +      - description: MSI interrupt
>> +
>> +  interrupt-names:
>> +    items:
>> +      - const: intr
>> +      - const: msi
>> +
>> +  clocks:
>> +    items:
>> +      - description: module clock
>> +
>> +  clock-names:
>> +    items:
>> +      - const: core
>> +
>> +  resets:
>> +    items:
>> +      - description: APB bus interface reset
>> +      - description: module reset
>> +
>> +  reset-names:
>> +    items:
>> +      - const: apb
>> +      - const: core
>> +
>> +  phys:
>> +    minItems: 1
>> +    maxItems: 16
>> +
>> +  phy-names:
>> +    minItems: 1
>> +    maxItems: 16
>> +    items:
>> +      pattern: "^p2u-[0-9]+$"
>> +
>> +  power-domains:
>> +    description: |
>> +      A phandle to the node that controls power to the respective PCIe controller and a specifier
>> +      name for the PCIe controller. Following are the specifiers for the different PCIe
>> +      controllers:
>> +
>> +        - TEGRA194_POWER_DOMAIN_PCIEX8B: C0
>> +        - TEGRA194_POWER_DOMAIN_PCIEX1A: C1
>> +        - TEGRA194_POWER_DOMAIN_PCIEX1A: C2
>> +        - TEGRA194_POWER_DOMAIN_PCIEX1A: C3
>> +        - TEGRA194_POWER_DOMAIN_PCIEX4A: C4
>> +        - TEGRA194_POWER_DOMAIN_PCIEX8A: C5
>> +
>> +      these specifiers are defined in "include/dt-bindings/power/tegra194-powergate.h" file.
>> +
>> +  interconnects:
>> +    items:
>> +      - description: memory read client
>> +      - description: memory write client
>> +
>> +  interconnect-names:
>> +    items:
>> +      - const: dma-mem # read
>> +      - const: write
>> +
>> +  dma-coherent: true
>> +
>> +  supports-clkreq:
>> +    description: see pci.txt for details
>> +
>> +  nvidia,bpmp:
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +    description: |
>> +      Must contain a pair of phandle to BPMP controller node followed by controller ID. Following
>> +      are the controller IDs for each controller:
>> +
>> +        0: C0
>> +        1: C1
>> +        2: C2
>> +        3: C3
>> +        4: C4
>> +        5: C5
>> +    items:
>> +      - items:
>> +          - minimum: 0
>> +            maximum: 0xffffffff
>> +          - enum: [ 0, 1, 2, 3, 4, 5 ]
>> +
>> +  nvidia,update-fc-fixup:
>> +    description: |
>> +      This is a boolean property and needs to be present to improve performance when a platform is
>> +      designed in such a way that it satisfies at least one of the following conditions thereby
>> +      enabling root port to exchange optimum number of FC (Flow Control) credits with downstream
>> +      devices:
>> +
>> +        1. If C0/C4/C5 run at x1/x2 link widths (irrespective of speed and MPS)
>> +        2. If C0/C1/C2/C3/C4/C5 operate at their respective max link widths and
>> +          a) speed is Gen-2 and MPS is 256B
>> +          b) speed is >= Gen-3 with any MPS
>> +
>> +    $ref: /schemas/types.yaml#/definitions/flag
>> +
>> +  nvidia,aspm-cmrt-us:
>> +    description: Common Mode Restore Time for proper operation of ASPM to be specified in
>> +      microseconds
>> +
>> +  nvidia,aspm-pwr-on-t-us:
>> +    description: Power On time for proper operation of ASPM to be specified in microseconds
>> +
>> +  nvidia,aspm-l0s-entrance-latency-us:
>> +    description: ASPM L0s entrance latency to be specified in microseconds
>> +
>> +  vddio-pex-ctl-supply:
>> +    description: A phandle to the regulator supply for PCIe side band signals.
>> +
>> +  vpcie3v3-supply:
>> +    description: A phandle to the regulator node that supplies 3.3V to the slot if the platform has
>> +      one such slot. (Ex:- x16 slot owned by C5 controller in p2972-0000 platform).
>> +
>> +  vpcie12v-supply:
>> +    description: A phandle to the regulator node that supplies 12V to the slot if the platform has
>> +      one such slot. (Ex:- x16 slot owned by C5 controller in p2972-0000 platform).
>> +
>> +allOf:
>> +  - $ref: "/schemas/pci/pci-bus.yaml#"
>> +  - $ref: "/schemas/pci/snps,dw-pcie.yaml#"
>> +
>> +unevaluatedProperties: false
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - reg-names
>> +  - interrupts
>> +  - interrupt-names
>> +  - interrupt-map
>> +  - interrupt-map-mask
>> +  - clocks
>> +  - clock-names
>> +  - resets
>> +  - reset-names
>> +  - power-domains
>> +  - bus-range
>> +  - ranges
>> +  - vddio-pex-ctl-supply
>> +  - num-lanes
>> +  - phys
>> +  - phy-names
>> +  - nvidia,bpmp
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/tegra194-clock.h>
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/power/tegra194-powergate.h>
>> +    #include <dt-bindings/reset/tegra194-reset.h>
>> +
>> +    bus@0 {
>> +        #address-cells = <2>;
>> +        #size-cells = <2>;
>> +        ranges = <0x0 0x0 0x0 0x8 0x0>;
>> +
>> +        pcie@14180000 {
>> +            compatible = "nvidia,tegra194-pcie";
>> +            power-domains = <&bpmp TEGRA194_POWER_DOMAIN_PCIEX8B>;
>> +            reg = <0x0 0x14180000 0x0 0x00020000>, /* appl registers (128K)      */
>> +                  <0x0 0x38000000 0x0 0x00040000>, /* configuration space (256K) */
>> +                  <0x0 0x38040000 0x0 0x00040000>, /* iATU_DMA reg space (256K)  */
>> +                  <0x0 0x38080000 0x0 0x00040000>; /* DBI reg space (256K)       */
>> +            reg-names = "appl", "config", "atu_dma", "dbi";
>> +
>> +            #address-cells = <3>;
>> +            #size-cells = <2>;
>> +            device_type = "pci";
>> +            num-lanes = <8>;
>> +            linux,pci-domain = <0>;
>> +
>> +            pinctrl-names = "default";
>> +            pinctrl-0 = <&pex_rst_c5_out_state>, <&clkreq_c5_bi_dir_state>;
>> +
>> +            clocks = <&bpmp TEGRA194_CLK_PEX0_CORE_0>;
>> +            clock-names = "core";
>> +
>> +            resets = <&bpmp TEGRA194_RESET_PEX0_CORE_0_APB>,
>> +                     <&bpmp TEGRA194_RESET_PEX0_CORE_0>;
>> +            reset-names = "apb", "core";
>> +
>> +            interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>, /* controller interrupt */
>> +                         <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>; /* MSI interrupt */
>> +            interrupt-names = "intr", "msi";
>> +
>> +            #interrupt-cells = <1>;
>> +            interrupt-map-mask = <0 0 0 0>;
>> +            interrupt-map = <0 0 0 0 &gic GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
>> +
>> +            nvidia,bpmp = <&bpmp 0>;
>> +
>> +            supports-clkreq;
>> +            nvidia,aspm-cmrt-us = <60>;
>> +            nvidia,aspm-pwr-on-t-us = <20>;
>> +            nvidia,aspm-l0s-entrance-latency-us = <3>;
>> +
>> +            bus-range = <0x0 0xff>;
>> +            ranges = <0x81000000 0x0  0x38100000 0x0  0x38100000 0x0 0x00100000>, /* downstream I/O */
>> +                     <0x82000000 0x0  0x38200000 0x0  0x38200000 0x0 0x01e00000>, /* non-prefetch memory */
>> +                     <0xc2000000 0x18 0x00000000 0x18 0x00000000 0x4 0x00000000>; /* prefetchable memory */
>> +
>> +            vddio-pex-ctl-supply = <&vdd_1v8ao>;
>> +            vpcie3v3-supply = <&vdd_3v3_pcie>;
>> +            vpcie12v-supply = <&vdd_12v_pcie>;
>> +
>> +            phys = <&p2u_hsio_2>, <&p2u_hsio_3>, <&p2u_hsio_4>,
>> +                   <&p2u_hsio_5>;
>> +            phy-names = "p2u-0", "p2u-1", "p2u-2", "p2u-3";
>> +        };
>> +    };
>> diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
>> index c90e5e2d25f6..7e0bf941fbfe 100644
>> --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
>> +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
>> @@ -35,7 +35,7 @@ properties:
>>       maxItems: 5
>>       items:
>>         enum: [ dbi, dbi2, config, atu, app, elbi, mgmt, ctrl, parf, cfg, link,
>> -              ulreg, smu, mpu, apb, phy ]
>> +              ulreg, smu, mpu, apb, phy, appl, atu_dma ]
>>
>>     num-lanes:
>>       description: |
>> --
>> 2.17.1
>>
>>
