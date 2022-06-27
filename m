Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D465555D0B8
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 15:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbiF0H74 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Jun 2022 03:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233268AbiF0H7y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Jun 2022 03:59:54 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188E3E46;
        Mon, 27 Jun 2022 00:59:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m9dzrQFWzQXEHdNnMu3mvxtwbXuwpyGSKCsG8JgYtRc2exg//JoshSBUO/362d0iF/X3X39bY1CdiDWs4wFcPztBCOwT+INmEeUN9UJJjHm9k8NY1wahncHEcriHTKiRca0r5io8H1njL1wu9p2XI+cNl1VHu+UZQmkv1fxGgSageHC/ebIc12q8PYahJaTIqUICv7GL5Mri5tbj63/7cXUEfYTaEccTwdWvS6SK3adzpGBkWUFkrWUMrQyQD3XOzQw1t4q4Lf+Jg9vBKrIBQWRpyvo/SprqhztxAopvJjHEBBBzYGkw9t1NCOuU37n+gSIkVvj/pzK+NCF6beLpIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pj2TPMKoFnwG7hRN5yUHBGCcB0zqLDhqRVBr7Ym7q/k=;
 b=muQ5mLo5qEqHpwWbIQ8Wud9L8erJhFf4fZe07lNL8l1ZXAsS1E7JKL2/jO2it4CQudkN2+CuPa4qw+S+JyGQMF8roDczCq72Jd0AvmDR/SvAil0QVoeE5YWOIksDOkAL4nejHKCzi5FS/jtjNAdGbwc31C0rxid3a8TScsvaSm94FHK3Bc1JNrKBA4y8VGngKtTZ0rQgIEzKIdGRFDObzu19T0v1Qjp30pL/LJo+xZmX+E13FbIs+LAyCwBH2K/kT14iD8IrLlX02FueXsjZhfthsvfFb42UxaFR3cbLcHCEmNbMeJZlqxQkS6SGh2cFVSB6GzkpyzuH44Rn5LDfZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pj2TPMKoFnwG7hRN5yUHBGCcB0zqLDhqRVBr7Ym7q/k=;
 b=c39zjN0yKp/6psV+JMl6KrkWRPCRhkDbIs/ZtEG4i/UEExrLmUy0wcWY3OGTiT6sY5cJjkbI72c3v3qfjV6c9g+D3sgMZtjVKmKEWjcY9VzTIZpC6V7bsUBSBv/OU2gCpY8o5bh2hK05DwtCPcWfzIvDW3FbXvdxZaWjQDyKJcPW/qqIgH56PyJFw557uZDt7DRB0D8uSyBjJHXl4KAYrLZ0ICDVR95oPgKD97ikzykB2K7yExKGsKU0jEphdCpqe1D9f2nX7Dm/Nmoh6PdUTej4JHXIpBJ42GN+WwMur7B/10kyyWi+ptUMes97/4vtKiWXDe49xsTNhxN3Jj3NrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB2900.namprd12.prod.outlook.com (2603:10b6:408:69::18)
 by MWHPR1201MB0143.namprd12.prod.outlook.com (2603:10b6:301:54::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Mon, 27 Jun
 2022 07:59:48 +0000
Received: from BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::3904:2c16:b3b7:c5f3]) by BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::3904:2c16:b3b7:c5f3%5]) with mapi id 15.20.5373.017; Mon, 27 Jun 2022
 07:59:47 +0000
Message-ID: <48b2c4c2-3032-a90b-07c1-f03b3a84df3a@nvidia.com>
Date:   Mon, 27 Jun 2022 13:29:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH RESEND v4 07/15] PCI: tegra194: Drop manual DW PCIe
 controller version setup
Content-Language: en-US
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <20220624143947.8991-1-Sergey.Semin@baikalelectronics.ru>
 <20220624143947.8991-8-Sergey.Semin@baikalelectronics.ru>
From:   Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <20220624143947.8991-8-Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0104.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::6) To BN8PR12MB2900.namprd12.prod.outlook.com
 (2603:10b6:408:69::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10724ea7-015e-4fb7-8277-08da581300ef
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0143:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K0FoQmhuNE5SRjZERjZzMm5VNlZCM2dKWnVud0NBVEEvckE4eDNJVnpRbG5k?=
 =?utf-8?B?djZ6OUJIc2E5WFN1emU3QkZrTFhDN1E0bjNQcnZYNUJVeWR5VWI4RHdsekcx?=
 =?utf-8?B?S1hGSGtlZG9mbGVGbDdRUFJQV05jWlJzeWRaMFVrazBldnBrZkc3bkNkVzRU?=
 =?utf-8?B?Qy83aUwyYVdlNHB1dXQxeFdvNkRIa2ZQWTcrc2VOcUh2cTdPYmFVcXNmRU9y?=
 =?utf-8?B?ZjZ6NmlucHBaRDNMU3piOHZ4N2JMODA1YnpTMzFjNGJ5dzRraHJUVjQ4Y3hI?=
 =?utf-8?B?czJqS1VsZHVTTXRObkU0RkpqTlJkM3REN1VjV1hnVjdmMjhEY0Frckw1TWFS?=
 =?utf-8?B?UVVPRWdsVnZxcG55OWt2Y1Z4RmptNmltdjJWdVdKK0wxb2ZGYmJ1NVdGYkpL?=
 =?utf-8?B?V2hQV2lRcDViSlJZc2ZpcGVIeGpHSW5QR1d3QzkrY2VVekJPYW0rWi9aRkw2?=
 =?utf-8?B?Tkt2cWVkazZySVQ4S0Zhb2hhN2MrNjd2dko1eFRSck1nU3p3Q2dsT0s5MnFE?=
 =?utf-8?B?eE4xTVJUT3FpUnpqZzRYU1pjR0llbjFRSzcyVXlLY3ZzYzV4RkpkVXRYMEdJ?=
 =?utf-8?B?aUpEMGNEZkdIMkd6ejd6MUpPUTNlK1ZsZzZFYlJnZHNlR3grb2phQkFta0RN?=
 =?utf-8?B?Nk43THhTck9KeFdVL013Z3JGRWhSMFN1Tno3RjZibXpLb1pqU2JpYzFSbmZW?=
 =?utf-8?B?LyszcStMMVhFamxZdUFlRVpUSTJYNmI4aU1Ec0ljYy9HMFdQWnc1QW5ValpE?=
 =?utf-8?B?ZWV6dWJjT0FES0ViQ1hOWXc1K0t1RzZnY1JLdkRsYmZRbnZ0ZkVxVVZSaWkz?=
 =?utf-8?B?Rlk4dHBmRTUzN1dVd1AwV1ZqTG83eStzSEt5VVVJYS8rUTFCSGROc1JkQVNR?=
 =?utf-8?B?dG5VSmZUTHFQdFhaKzRLenNxeXVoeEZIRHhMWjBUb09BT0ZDQ2x6Y1hmQmpn?=
 =?utf-8?B?UlBFcWtodkQyNjE2UmNYeU5jUzFKbUNIc3JwdGY3TVJJeEFGeWpzb1ozREwv?=
 =?utf-8?B?SHhxZHVrUE54NTFMb2VGcFZNRUNiNHZ3aSt5UjFjNm0zUzZrc2I4aklRUk94?=
 =?utf-8?B?RWIzeGVuOEgwVFQ3L3AwZ1JIckFBZHM4VTIrVjJnbERQZ00vSXV3NXFyOHI3?=
 =?utf-8?B?bHdMYjZKbzFIQ3JJYnplUmFCN25UeHQ1UiswYkwyWGNCTFNDLzEyV0IwTExB?=
 =?utf-8?B?U2xrbGYzdGswaW11blUzM0Y0b0l6SHdLNGJVNHpFOGJnaDJrck1VNVJGdUE4?=
 =?utf-8?B?WTZCK2ZrVVJIQ1RXS0tNdVhEOFdUa2V4MjJMdGRjV3dhdG5vdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(39860400002)(376002)(136003)(346002)(36756003)(6506007)(31696002)(6512007)(66556008)(316002)(7416002)(110136005)(66476007)(186003)(26005)(53546011)(2616005)(921005)(38100700002)(41300700001)(66946007)(6486002)(86362001)(478600001)(54906003)(8936002)(83380400001)(6666004)(6636002)(2906002)(5660300002)(8676002)(4326008)(966005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWdpUmRjSGU5U3owQVBGU2t3VG0zZFJRZGowMHQyRS9Xa3hHb1RIQ1ZTNTgr?=
 =?utf-8?B?MGttQ1VuUklWNDJmUWx3T2I0bTJ2L1FQS3ZFRTE5b2NzVkxXWXV2SzFwKzNO?=
 =?utf-8?B?R0o5VmRxbVVTNlN1aFh4cklJU2s1VTZKUFpaTkRJb1IvKzh4NjJiSVRyVHQz?=
 =?utf-8?B?dm5BRzdvbDZEMCtmdXkzNURWUEFoNHBjOGtlUUROblQrdFZ4amw0Ym91ZitB?=
 =?utf-8?B?aVR1ajVhYk43Y3pMTmlhODFmeXlYaVJGMVI3S1hOamJBY2tkN3p2VE43R0tG?=
 =?utf-8?B?SFZMWW9yL3Q2amVkL0plU1NmMGZQZ00vYk1MWU9OS2JGcldscklKYnpTT3hW?=
 =?utf-8?B?NlRsZVJrWnhqM0JiNjdrb0JhWjcwOGlnMUV5MjRuNFpucmZacTVCbkZKalhJ?=
 =?utf-8?B?M1o0aFpLRDRmOVR0RndtTVZLcGkrdGlDbitzZXc5TGh3OEF4UEIxS0NOQktz?=
 =?utf-8?B?NHNNYTJHU2ZnZTVodmVPQ0s3ZENudml0L0N3V0FqV0t2SG1OZzhGVVh2Vm9s?=
 =?utf-8?B?dVRaek81WlJXZDFUbkx0cGVUb0RYY2hqakRLYzVzWGtvY0dOSzcreTFaeE8z?=
 =?utf-8?B?OWJraG56WS8xUkdxNURJZXg5c2diYzlWSkFGeldzcm50ZVZBdnJKZzg2Qkdm?=
 =?utf-8?B?V3FuOGFXVFVEMkJQNTkrajh1d0hmaDJoNTNSS29yNW1HY2xwWlNIamwzUG5P?=
 =?utf-8?B?eStUN3AzakpDc1Fjd2FDaXplWlBwVkxMTW1jZ3NqWnA2djVncUJya2ZGZ2dq?=
 =?utf-8?B?QlJzSmV3bmoycld2N1Ewb2FvZ24zZkl3YnMyOWhSRjcrUXJwcDNENXhrUDVs?=
 =?utf-8?B?cXExUm40aXRHNkNWZi82Zit5SHVQd3V3MjNsdzcxaE1rVzl4aXJQWnp3RnNa?=
 =?utf-8?B?cnVZckhzRmxkTVJoSnAvOEhwNU5RdzJ4d1V2WTVDOGRJUjZoaktRMjE4eE94?=
 =?utf-8?B?KzBsZlF6N3ZpWUZRRHF0MG5iYVFBUlRqallkQ1Z3Q1NkMnJqWkJRdHcxZjBp?=
 =?utf-8?B?UklxZ280dmRpVE1kb0wxWS9VSnB6aThPcXlsS3RKNTBkakp2VGtXM1Q0MUxv?=
 =?utf-8?B?Y0twd01RNVduc091U2kxbC9wUWFUcGJCMm0vTXplVDBodHhJay9CVTVGQkJL?=
 =?utf-8?B?bkpLMEE1Y3ZQU3RhZFJ2U0dMK3dJR1BvdGlXUDFlbVUySnNwNklPdUJBNHd4?=
 =?utf-8?B?Rk1oRzFmckUzaGM1MkZzNlhtRnRJZ3BGOEtpYkV3QUR0bWhTTk9NTEsvdmN2?=
 =?utf-8?B?RkJ5cllhMFFvSzh4WHVtNkE1Yk5ZcVJJRDhMMTE5eE9rNUN2eUJjaWdjakN2?=
 =?utf-8?B?ZWYwZHMzMU9LQ0k1WE82eGpIVTViWUhudkdUWFNXcFdFV1VhblVHYmJjWmtt?=
 =?utf-8?B?M2Y3YmZoSkVsTWVVTHFjQkp2UWF0Wk9mZ1RuQllhcy8vYUZFd1JuRmV1cEN0?=
 =?utf-8?B?cDdmRWtYaE12NzlTY3M4NVBjbkRlSzJsOCtoQ1BLVEd4Q0UxZHJ0MFdQN3Zl?=
 =?utf-8?B?NXdwaHNkbVVuQXMyZnZCMWRZa1JpR0l6dGRMZ3doOFlVR1ZXdEFVUGtMNnNP?=
 =?utf-8?B?bndHVUQxTHhaYWxld3Q5Ly9tbmNldHdXclo4eURKTTlFQUlocjl0V0xnRkhy?=
 =?utf-8?B?ZUY2V1JWTEUzOElJZTh1ZGtPSGVicVFNMnZMcTZzcWhyZFlKdUdHWTZJeE82?=
 =?utf-8?B?MVFIYkNscFlRaTlYbjVadjkzdVNNNWIyYWVlZ3k1dzBydiswSDdEcEhPeXpH?=
 =?utf-8?B?bnpQVGw1ejUwcVJCSVMybzkyVjNvL0lJb0pVenpIcWRGRXBxd2Jkd21wK1ZF?=
 =?utf-8?B?MkcwanMyUFZzYVdKMW4wUkpycytzcHVOQmRlV2syM0NuVzhVQkIzVFcwRUZJ?=
 =?utf-8?B?WmFVV2wxT1BwakZPb1ZHcnluOTZrdHpEamdXZ1NKWEEyQUZhd0s2NVdVMW9k?=
 =?utf-8?B?a3ZlaFVoSTJjcXpaOEl2ZlhkQ09Ta3FjU0NSS2lWUm9Ub05LdU5hUEJINWNH?=
 =?utf-8?B?cFBZdUVicXVNaGpKZldjN25MeW0rSnBVdmdRbk5QZEcyeEZkR1RVRHZKMW9v?=
 =?utf-8?B?a3ROVzhYUXZiY2FGWU1GSDR3TUhEaWM2Q3N2RmdURTNmbnpSTHkyRTBnbjFo?=
 =?utf-8?Q?yFyX5ImNJBwOAdJRS57Jz5S/F?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10724ea7-015e-4fb7-8277-08da581300ef
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2022 07:59:47.2790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Omi5RNHpFtqOJSp9gkzKAQRMfBBFCX5xwgczzfJI9qIEZDXOurzEvKbCplgoIhT+zmAGk6zsxwXLEotHKmhRVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0143
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 6/24/2022 8:09 PM, Serge Semin wrote:
> External email: Use caution opening links or attachments
> 
> 
> Since the DW PCIe common code now supports the IP-core version
> auto-detection there is no point in manually setting the version up for the
> controllers newer than v4.70a. Seeing Tegra 194 PCIe Host and EP
> controllers are based on the DW PCIe v4.90a IP-core we can freely drop the
> dw_pcie.version field initialization.
> 
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Folks, I don't have Tegra 194 PCIe hw instance to test it out. Could you
> please make sure this patch doesn't brake anything?

Hi,
I tried to apply the series 
https://patchwork.kernel.org/project/linux-pci/list/?series=653624 on 
top of linux-next and ran into conflicts. Could you please tell me the 
minimum set of patches to be taken?

Thanks,
Vidya Sagar

> 
> Changelog v3:
> - This is a new patch create as a result of the discussion:
>    https://lore.kernel.org/linux-pci/20220503214638.1895-6-Sergey.Semin@baikalelectronics.ru/
> ---
>   drivers/pci/controller/dwc/pcie-tegra194.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index f24b30b7454f..e497e6de8d15 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -1979,7 +1979,6 @@ static int tegra194_pcie_probe(struct platform_device *pdev)
>          pci->ops = &tegra_dw_pcie_ops;
>          pci->n_fts[0] = N_FTS_VAL;
>          pci->n_fts[1] = FTS_VAL;
> -       pci->version = DW_PCIE_VER_490A;
> 
>          pp = &pci->pp;
>          pp->num_vectors = MAX_MSI_IRQS;
> --
> 2.35.1
> 
