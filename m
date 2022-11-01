Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB3E6145B0
	for <lists+linux-pci@lfdr.de>; Tue,  1 Nov 2022 09:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiKAI2M (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Nov 2022 04:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiKAI2I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Nov 2022 04:28:08 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A9F183B2
        for <linux-pci@vger.kernel.org>; Tue,  1 Nov 2022 01:28:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l6PdQdjOa6h1tZU/EbJ8+mhiD7reXK8/7QZSK7AjCNy0QaY9Vqf9K7FEuw174V89+FJL5uTE0KIvZ0Z89F4yIQZ3WyN9oJLLTqmPedtASbP+IIF+i3vQa16+y/xUYBqnjAAbCMFI/IaROj1iiknXoIQwcCrtyiwCQAm1ITp3n412m47zI/rsLFjJY+a6XYttatGUTVhqxCcZnsg4MS+3DdtWPVeDGk90SOCQtTn7fKSESBDo+GlsZR+n/J4KbCIegDr6bBK5rPS8NdGbql3RazOmVyfplIX12OoPUwzVA5G1PdSh4viSOUhX+5YCWvW9QqcH5dYg5OhoDKQu2Ri8Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QcB7ioqbbnfSy2XJzRnaP8suqqESwaU2iiTa+sqtDPw=;
 b=XLrKcANCnLPvGF0nu6GUe8JDHYKKhuHbr0xa3DOlWZAui2fsYxxK/cWvn/AexoXKEo5eOFIA9ciqGNqzeH4JHACCRRb1/dS3L4GbUMRnvPW7MOjpJGNBPl9aj33dKLhWy+kn7NbgMf7HW7CE1rHUu5XeMKXLKDDqYdYh95sUPXZDpB9zWGiy82GtdFsYneMU4m7bOHl8KSKc0uurOkeBrdBpTCRUdixkLGuAMrTZmSw5Tw6SDiKJH5pAEQ80Movq/birYd+1OUUQs5Hqz7VhEq3tf/Avtadrf4sFT39iQROCmbeogJaWI7yLdD3fU0/sdwSF53pv7le63DBc0qSHUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QcB7ioqbbnfSy2XJzRnaP8suqqESwaU2iiTa+sqtDPw=;
 b=Gmpren2JlK217e6iy/bu59D3lKbq3hRIPAXo/kk2hF0QnymUGeS4Cx9NGMmXaEEwn5JKvxndCFRghvKpvRmko116UJT5iYPJoTyC6yr8j6GxOrK44v1gbX1yo88XRh8lctrjiwbeitfddEu+diJp805Gt4n/j4cklZvXM3ZMJYSMZMkIkZWNw8li762BZ6Rh2a5SoxUPwclRsr/X+feRxi7aoL10ExOjm8mDt92lUyWqVEW2r+l0BFzLRJOF2aykOpVN6/gCE4DOeyCASd5B1ajOJKZ85lLhscN0gCeLThB7A5VaVm+dVP+PUHnqR5Cry/TPfJKwuq7WEBax1h1uJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB2900.namprd12.prod.outlook.com (2603:10b6:408:69::18)
 by PH7PR12MB6586.namprd12.prod.outlook.com (2603:10b6:510:212::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Tue, 1 Nov
 2022 08:28:03 +0000
Received: from BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::2e44:5abb:8e9e:a72e]) by BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::2e44:5abb:8e9e:a72e%3]) with mapi id 15.20.5769.021; Tue, 1 Nov 2022
 08:28:03 +0000
Message-ID: <41c536dd-99c4-9fa5-39cc-2aea5b5e015b@nvidia.com>
Date:   Tue, 1 Nov 2022 13:57:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 1/1] PCI: dwc: reduce log severity level if no link came
 up
Content-Language: en-US
To:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     linux-pci@vger.kernel.org
References: <20221101081844.265264-1-alexander.stein@ew.tq-group.com>
From:   Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <20221101081844.265264-1-alexander.stein@ew.tq-group.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXP287CA0018.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::33) To BN8PR12MB2900.namprd12.prod.outlook.com
 (2603:10b6:408:69::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB2900:EE_|PH7PR12MB6586:EE_
X-MS-Office365-Filtering-Correlation-Id: ff5797a1-a577-4556-52cd-08dabbe2fe58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q+URdoQ3ByabHDnAbWfaSya55qrbdPYBrgcXRXtZY1v63tPP1IEMvYcI8tsA2V9fdGbJ9AHBdEKBhsxviF4RAzPGqkYLsLWjrvbHVIK7vATAmNqB9DFrSkt23bgyLAfIyVTgln2tZUdPqmAjMYGTKI5Y9lOnu0nz/dY8DTZ4jql1hevd99+yUMOqhFaQh9xNAtZOT5pgi3FQTq7razVEKW9NYEeabY6SNnaiWp25+LkUEgTpOtUwTUdDqH1Paaj+JpWIdOtqvIjXt1Uc462HhB3fwSmBx9BW61THTSfWEBVPm4XZ+L6QpaSAIDfd/vsfDVJRadniUzGwqYiDT/gz6KQhxZuMNa/mRZw7GSSHb8he/uOmKo9KsWvCvMgxDe96R89OkCdX99uAEkolb5oj9owCAjUlGnik6unMKXjcn6YoA1vQEzcumqAWhCAGq286okmvsBAs91ck/zj6TK4/aMq6n8S51J5Pc2mqiwiclYOxdL8B6De1BjES4igDB/Vo1KPs19DVp/mYMCyNuFVFnXcG1SJAU8cWqKTMwUcQ/sduYeGECyGtOgLOJYE/4fzPC7hKbTJ4XEGYiruzeIJOgp6OhCmDtYY5IQT6wkjFqKGg//7dXY2gDRPZ6yzcpPjAtzGeYi6dTPUVpMNygL8XGUXSQApjjz0j9nnHOVhzubU+T2rjmz5gGhHNqTvYxWOvmV2Ww2wyONmIaufbFqvqQJsLowijZlcozKZpTIuFelYELO/qM8p5EeXfn6f2slRL4GAKn6J6mk4X05eov1ibvhgA5bqHnCx+Xv2E/cxqfWK4V1sW/CdeJGd0TV35i8WBZWbPvxusC6UzrLm0GpFLAtPPA6k8dz8iS9PDkEK1f+QwDAwJBnJNqaU9rwTVPWa2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(136003)(396003)(366004)(451199015)(36756003)(26005)(6512007)(66476007)(66556008)(6506007)(53546011)(83380400001)(8676002)(2616005)(316002)(4326008)(110136005)(38100700002)(2906002)(66946007)(8936002)(31696002)(186003)(86362001)(5660300002)(31686004)(6486002)(6666004)(966005)(41300700001)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDhRenpnKzVoWnZ4VmQxTTRhVFdTRm5yZ2VFeU5ES0xiUFB5dnNTamY1MDB2?=
 =?utf-8?B?Ymw1eFhFWXQ2Q0pqazRNaGdLREY0anoxWjhWQXcvckIzK05xeDVnWnBmOERE?=
 =?utf-8?B?QzBHUHViZTFDbTZnTzl3eHI2d0trU3pSR2c3OUhQSGp3U3hvVWN5cEJsbjFG?=
 =?utf-8?B?RjBkaUU4TUFjbWk2dWJhem5BQ2QxMWtPVTEzVlQ3NTlaM2h1b1dWYzhBWlE5?=
 =?utf-8?B?VkIvOEVvVFAwVVRaNFZXdkN2emVZaFkrY3NjR0c2TmRJNnZ0Y3d1K1JRRDRL?=
 =?utf-8?B?dW1jSEZqYkpMYUcwWDNTUTUwNTBoYjh0K2xjdGNGcUd1ZFdGdFBGRENvZndh?=
 =?utf-8?B?czhvN2ZhNCs3VTNPdytybmVNSk9WNTRVVVpjeitoUEVpekJ5QXl2bVJVb2l3?=
 =?utf-8?B?ZzVNQlhJTERnSTZRTGVSc0pLdVR5cXRPMEFsclpiSmk3R2QwY1pJbCtIY1BM?=
 =?utf-8?B?T0NXVnBlcEpSY0ZnV1d3d3hjY1dveFV2VnZhM3p1RjBqR29WTXZ1dkM5M3Ni?=
 =?utf-8?B?RmE3dmNGOTJWc3NRZ3ZwTnhpRStCR1VSMW5nTFl6MW5kMEE1QkJ4TUFRaEI0?=
 =?utf-8?B?TXQyaDVhK1NNQnA0endnUWJ3WmExM3FiSFVNalIrUFR2SmIwZUlzU1JOR2gr?=
 =?utf-8?B?YnVGTDNJM1pwKzdXdEd1OHRmRGNYVVlPTDRPQmhrdUs1VnZlNzFVMUtiZzg4?=
 =?utf-8?B?SE5IU3ZIb1IzWVVOalN2Vjd4YVJhMjUzUTBrTUdmME5IY05NbWVETEVLU3VK?=
 =?utf-8?B?bFBRVEVuOWVXK2NQTlNFeHE1TG01bThiK0pDdmc1cmF5MVBqVmVoMTJUZW8v?=
 =?utf-8?B?MTd1c2dCd3NhdGI1dDkyWTlQd0toS0FoZDNCWTFobyt6ZXp2UDJoK2dObm8z?=
 =?utf-8?B?ODhQcTc5amlIUlFkd25ycWhpWFRDVlNsNTRCZzhJajhEdmhtSXl0WnRtbGw3?=
 =?utf-8?B?dnBHWS9KMFJxejcrZXk0T1hFRm02ZTg3VEFCQi85V3BVNktIb0YrdWgzVVBB?=
 =?utf-8?B?VWFqZnA3T3piRmE5NGlCYmZaU2s5MU9la2UyaVF4KzNWcDZYNEtrR2p2Ukt5?=
 =?utf-8?B?OXI5VFRWUTFIZ0szeG5RVnc1WTVwK3B4Uyt0QUd3YkEzd3ZnSThMYWpyU3dV?=
 =?utf-8?B?aVZpaCtoRkNQS2FyaC94RmJXNnYzdCtLV240WHA3WGozZzFkM2t3dnpUd2pP?=
 =?utf-8?B?YUE3M0VvbXpjS1doK3h3Mnd6RWlIc3J0NkZnY204OVAxb0VZTDRvMmZtRUxK?=
 =?utf-8?B?SkhLZ25ncVd6RlUxdDcxV0Q2dDUrbGg0N0hONjl5QUV1SlBBSk9POXF4TE9D?=
 =?utf-8?B?djRMNGoxaDBwVnlXT3MyWFpna2sySnFrbjB1dW1EdkhHem1FbHMxL2dqM25s?=
 =?utf-8?B?TDN1QzJtQy8rYkJ0RGFxVVh0RXdnMzVKdVFpREdpYmUvaVBnWVF3R0VGWG10?=
 =?utf-8?B?ekxuY0hnb0VQY3BWalFmRXoveEZYcG9MK0ZzOU5vSmFJRWNqZGtJbldBVWRJ?=
 =?utf-8?B?S0VoT295L0J3Z1lHdnJjaUcxSVZlTmhLWk1vWWtGRzRLVkc2RXBNLzlha0hz?=
 =?utf-8?B?NXZQcWV6b3hYYitTYXcrR3lkZ2ZleU5TZmQ4Y2VBVDI0cGVlU1l6TjlnL2tU?=
 =?utf-8?B?SWhWbEltbHJ6ODJWTVBVdkp5aHlsOTZ2Q1VmeXpuUEF2V0tRcVdrSzh4Q0Qw?=
 =?utf-8?B?RW9HTGgreGpOM0l2UzFkM0VwZk9MVDJ4UWk2dVVpbEdvcDc1NmxjaUhCOFdC?=
 =?utf-8?B?bFpEVTNkOGtwSEwzSEh1djFTS0NoaWlTUVF4cGU1NkE1eTNnVjZobTZVUHlD?=
 =?utf-8?B?THROOVRINUVWYUhRSk1Yb1JtZlFLbGdFZVdnYjBZcjFCSjIwbHQ4bmFZaDZx?=
 =?utf-8?B?MEZkcXE2U0sxT2R5UzRTQkFoR0x2UHMrckkrMmFKNVlmMnNEeGk3N2NDRzI3?=
 =?utf-8?B?a3BWc1RER1RWaFc4SUhvb2lNNy9FV1p1cWlNb1FBN3pzKzNjRHRkdndBcW9V?=
 =?utf-8?B?d1k2U2FzRmU3RzJBc1pmczg1ektFdS9temtNaUxvU3JNdTEvWjBLU3J3RGYx?=
 =?utf-8?B?bi82QVUzb2RWcnl3aFFuOXVUOGk2UmNhN3ZNS1FBSkQxczlWTHhCemd1US9J?=
 =?utf-8?Q?x0ytzKVWSAk6iLCGBhnk75d2c?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff5797a1-a577-4556-52cd-08dabbe2fe58
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 08:28:03.1800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CwQobvFiw+B1pOXv2zjKpWV6O3UCXMu2Z1Me77j8ii8mPClSWUIkKerldZnCGt7S+9lIR9uy6vWp/3RWmj09VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6586
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Alexander,
Thanks for the patch, but, we already have a patch for it here

https://patchwork.kernel.org/project/linux-pci/patch/20220913101237.4337-1-vidyas@nvidia.com/

and discussion is going on there.

Thanks,
Vidya Sagar

On 11/1/2022 1:48 PM, Alexander Stein wrote:
> External email: Use caution opening links or attachments
> 
> 
> Commit 14c4ad125cf9 ("PCI: dwc: Log link speed and width if it comes up")
> changed the severity from info to error. If no device is attached this
> error always is recorded which is not an error in this case.
> 
> Fixes: 14c4ad125cf9 ("PCI: dwc: Log link speed and width if it comes up")
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>   drivers/pci/controller/dwc/pcie-designware.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 9e4d96e5a3f5a..432aead68d1fd 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -448,7 +448,7 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
>          }
> 
>          if (retries >= LINK_WAIT_MAX_RETRIES) {
> -               dev_err(pci->dev, "Phy link never came up\n");
> +               dev_info(pci->dev, "Phy link never came up\n");
>                  return -ETIMEDOUT;
>          }
> 
> --
> 2.34.1
> 
