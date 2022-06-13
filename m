Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0E0548142
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jun 2022 10:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238444AbiFMICt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jun 2022 04:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239014AbiFMIC0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jun 2022 04:02:26 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AA2BBC;
        Mon, 13 Jun 2022 01:02:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FMH0dW6p847t+5v6O0R9NWcEGRbD8GG7Dc/S0dD/kzFxWHRlx/1njMQDsi8auWaowONiHlucxoXStAGcdDG33vUacxAPQ9b178pZjAKwvDCkBq3zFqvpvDOOS2N9L87KxKOfo52YEqOb6xxCQG7y2VcDReVd8V54utB/A/gjCbKqtaEERBGxZ46K5YRj/oZkrfnMIDhPvln0i3iqoVZBiqm8pb8wcOBj6pTP2eWAaPBdtKqGV120Yvp/YjyInzs8X/fK2XUHK3QpkWapsIt0zF/CzbBS3ml2b1Ijv8lZDmkuqZsd/R1NAVgx1Ql/7U8IfFUzitFjReQG1Z32bIHLog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tErt4+11mi2B8bzKvlv5RAq1+z9jC7EyTqyqLEhCxZs=;
 b=nXtHR46HLwZ72sLDktK31H+pGIUt5xgJWUpMrGQevDe83JjYTnZ1hnHqf2RVr+LghCR4qxYEDqbvJ3AcumIdP87Y6BLMr3fPjQka8O1vbAZb2jYO08SY3/tme/7ErNPM/ZTXwlQZIGqfENQF6yImsVEC63l05ZGdSbTxMQrlokr1elny6SqZ2zcF2TtWZl8VPuQkDGrnWOWdNngIDnS8eu7zh2jVSr5HoASqjEIIO4aG8PqHgiCswvjNvrW1SnGiWkRCDqfLXqEqsFb3djEeSNZ9cNRYgCFwi+tk5wlI2EiGwxgpLGAAel1R0x2V9lexhsz3v6eJD6Vp4yS0vRVWpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tErt4+11mi2B8bzKvlv5RAq1+z9jC7EyTqyqLEhCxZs=;
 b=OtRGePgyBe/Gy1v52CxoDt174ZiISZlwbW83NrOqTKchpQdkH47jhgslAfRioFOMo2d2rX9MPOGIa/xKTbBYjuEnRgIEu54b5P6q7tUw0lRINaOX9Fnt8hV5+qTmF5jMt4tNaohunxg+HAtuvPZ+Wr9W0XyHTCpgOnbYL/3LOUYaMs/nktgpbqaCB9qPcSwodxXd/ShfUR9e0RvaqUlO3BUxZa8LO0Ldu2XdOSVmALzKYX2GPgP/RukdFLvAqgVHZIOuReAxVGQjvvzySluqpzvWkqjTkiSy6OAXyKnYN627FhggDfQ3RkVCGvnN+/Uoid8JvQF+WloBqxl8Z7+hQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB2900.namprd12.prod.outlook.com (2603:10b6:408:69::18)
 by DM6PR12MB3051.namprd12.prod.outlook.com (2603:10b6:5:119::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.14; Mon, 13 Jun
 2022 08:02:24 +0000
Received: from BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::d0a7:164b:8ea0:b670]) by BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::d0a7:164b:8ea0:b670%7]) with mapi id 15.20.5332.020; Mon, 13 Jun 2022
 08:02:23 +0000
Message-ID: <ded0e4f1-ed94-7518-f190-ed7aff1bc832@nvidia.com>
Date:   Mon, 13 Jun 2022 13:32:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v4 06/18] PCI: dwc: Enable CDM-check independently from
 the num_lanes value
Content-Language: en-US
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Thierry Reding <treding@nvidia.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220610082535.12802-1-Sergey.Semin@baikalelectronics.ru>
 <20220610082535.12802-7-Sergey.Semin@baikalelectronics.ru>
From:   Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <20220610082535.12802-7-Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXPR0101CA0063.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:e::25) To BN8PR12MB2900.namprd12.prod.outlook.com
 (2603:10b6:408:69::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9540bedd-87bb-4dc5-7d7a-08da4d130c4c
X-MS-TrafficTypeDiagnostic: DM6PR12MB3051:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3051F3DE9222E699AFCC6670B8AB9@DM6PR12MB3051.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N/UBOvCUJvjWsAVRkdpO+jpl7nf0xa+Dx5vNKg3mU4wK96yxmuFv9suufwVHfCkAj0fQmO1ybHCjbaDRs6mSmU/B4ok3QOivxoGm5IWtKnegc5WH/nzjY06GTGrP14Si/VwMcIFYiewHBATGubHvZQqa6/VlKOP7DRcayuY/8ZyRyye1pugu1W6XYTma/yKhkVPqepSEBjECq1lEdkzVZMslTWSQmhXmq4Hm1gbKDJgDPDYDELrkGMgc8X9is5ixFXyAfSn56OmTqL/yRJPpcSEj7No0obonpt7W1qLjF62pQt6Uloqz9yo/p62pMDpgU9IyxAkmNoDKBQKIcjLCLuuPVhV/iw+ZEj85MjavxcNE8TQSOmUEbNiIrfU3Iejnknb2kW4cCCosF9qI0G7bljDrsl8j+/BB1BPcAWE3BpMe4VWG8HAtxGaH253ZF2uxu5goDM+KY1We3Qy+nS9TGZFqmkOUgaKkOGFvAJ1InekKMIQYXO4imeyI0sZqvxEYp4YFlKmfv20xDzqUlXl9eWmgs+oKwvQjqSU/Z3dd3ctBI1myWhg/xZWKKNUNpcpirpfT4ZYlxm+5gmKfaa8IQWrRf2+w1XW595cTdKxThDVGWBcm5dSINoof2ng74PwTnQihOH8CMUxFDtfTi6yHZ7Nd0WCy46M4XSSEMFezze5sx7MGk/KTb8NcPscHtSon7KYkRdgdIqvthZ77H5w+EVtKQxZs6Gj/+shCLk+6h00=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(31686004)(2616005)(54906003)(2906002)(6636002)(83380400001)(26005)(110136005)(316002)(36756003)(186003)(6512007)(6506007)(4326008)(8676002)(53546011)(66556008)(66946007)(31696002)(66476007)(86362001)(6666004)(508600001)(8936002)(38100700002)(7416002)(5660300002)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WklJaTR2ZmlITTJGWXZrTTJianVKQnNLOUkvWjdlMVVPZGpnZjFMZDlqajZ3?=
 =?utf-8?B?Z05URytNTkt4RlAwd0VRdnZBcm93UHMzMFg2UHgvZ2FPMWhsZ3RzbWR4cElU?=
 =?utf-8?B?K3lwM3RsVDNCNE1EOC9vN29kVWdxdG9LU2tGTmNKSCtvbUVFeXN5UWhnZW9w?=
 =?utf-8?B?NTUzVTl1dy9hc2IzRFBLS0FkVWdlTmRVaGhCTjNRTk9VNFhzaWg3R29RVnhX?=
 =?utf-8?B?MnVLY3lUWjFuQ1JEdnB6TjBvMElPVmk0MW5oUDJ5dWZ1ZzNqZkxZR2VJVC9G?=
 =?utf-8?B?NjFzRGRNZHBhTVFMWUs5N1NDS2FDa3hESDZDcGxlK2VtOTNpSFJsVEhPSlpI?=
 =?utf-8?B?UkJlWTNsU1dUSC9ZQ3hXYWNXMFg5TlRqMmp1cHErTjJFNU5yR042TFl0MGJF?=
 =?utf-8?B?NDBXUk8zYmplb2d5emJKdFhIQjkzdWVOSktkbUowRlFGN29nVzUyRnFrck45?=
 =?utf-8?B?ZmRKdnlqSWp6QUkvNWhVcytKU3pCR3dUcXJvZWRlQ0Y0czVORi9ZeE9rSDFw?=
 =?utf-8?B?RmNKYURaR3R5YUtydkR4Mnk3TVV0RUM0NXQ0RmNERW9kY1ZkOWh0blN6MnZH?=
 =?utf-8?B?M1RLQ0l5NjN5eXc4T2VTNEREaXJnRWw0VFJWWW8yNjBrd2RaUlNNYzAzRDV5?=
 =?utf-8?B?MGxoRTdmOElTbTFtdFd3eVZjY2lqSjdXUzJrai9sczMrVXdYSktDS2tDTDRZ?=
 =?utf-8?B?bjJIWlUyc3ZDTnJTd2Q2cjd0Y2Q2RTJpZ1hXN0kxd1hWMWJ5cHV5bFpvWk45?=
 =?utf-8?B?M3FNR0h3MXZodHQxbm1sSU5Scnd1MkhVWTlVRTdkZzFlaFgwNGZsVVpWbTZP?=
 =?utf-8?B?UFdpeE02UXFDUjRXS3hOWG9YWk9vQ2QyeVhnZ1MxM3VvVW9yd3U4WHJ1OTZh?=
 =?utf-8?B?Njl5ZG8zNzd0Y2Nsd0lwMU9UTER3QVEyQld6dVd6VkJpMm1pU3dYYzJ1RjZM?=
 =?utf-8?B?bFY1YmVoVVhpMUNPQmNrQnNuS1RqUmxiMEtJSkg1NHBwL3lBY2x6ck50K0hV?=
 =?utf-8?B?ekx4ZDc0K3VPYW9XSVBnNlY4ZERZdjhheVNhQlhUYndWbUZWcTVOelRUaElY?=
 =?utf-8?B?cTg3YWNHSmNmUDJrblI2L1VHaDBrVzBySWJoVXkybW50WkdWeUREY1EwZ0Mz?=
 =?utf-8?B?eGt5Zm5IQVVwcnJTM0RQUUcyYk9ERE5pNW1lMkl3VU0zelFuODA0QndBcHN3?=
 =?utf-8?B?T21pakl3L3NueEgyMWpIcW9keFdOQ2tjUE1lVFR1NjlSWWtpWkt2SjE0SlJo?=
 =?utf-8?B?K3FnTE5UTG1Vd2RwRTRaNnZuZ242bjY0UzYyYmNVV2E0MnovYWpvb1ZtUmQw?=
 =?utf-8?B?UkR0a0svdDIzci80cGJ5M1NBNHhIeHAzZWMrWVk1U1F1Q3RnZkRWZVJSbDkz?=
 =?utf-8?B?ZVcrbERYSEE5ODdmZTFBREhQckppc3ZRTnpvSU9IUUs0cWpXak1JbjhBY0x2?=
 =?utf-8?B?WTdDQXU0cWZRNE1lVGZXZXRTVGV6NXQ1UXQyNGhwL1I5R2RKNmF1T2dVMis2?=
 =?utf-8?B?WWs0Z0Jzc2NDMmdsMER4ek4yRFA2RHdsRXphQ055a2tUd0dMZG1meTZzYnJ4?=
 =?utf-8?B?eE5NTG90WElnSGwrZjVxMjVVeDZpa1FBNFBIQlJYbG5ldnk3SjdoaDdycHY1?=
 =?utf-8?B?SnQwWmo3a25KMDJEMDlKOEo0QloyQ1NCb2t1VDRXaTAxSEhsNkh6aXByMG9j?=
 =?utf-8?B?SGVDZ1lmdWdWL09jaG1TczlJVlFQKzQ3a2xRYWVNSnNHbm9VZHlocXVDZEs5?=
 =?utf-8?B?bGZYQjNoYjd1REJvS3Zid2YzMU8rUkNmTDIvSVEvekc1V0kvNWZKaG5ySFpR?=
 =?utf-8?B?bUM0d1RwK3J4cytyakcydWk4TlJ2b1UyUG5ReFZERUZQZmhBRDQ2MHkzUE9K?=
 =?utf-8?B?MzYxd0ZEeDJyalV3d3dML3Z1WWpUSE15NllRWkpQczlIZmlPQkJ6bVk3bklo?=
 =?utf-8?B?QUxDTC9QeFNINTdMa1RHQm03ek1FakJnb1ROUWNPTGdvaTJBeWlPVy9YeEtO?=
 =?utf-8?B?NXM0YnJ1djZNNVZHdmtmK3l1TEdud0ovQXFNTEQ0eGxJWDhEZGxrUHIraUdU?=
 =?utf-8?B?MFQ0UnlTNlZWVGxXVWszdFlhQ3NodjA5S0ZhaFVYcjRrbWpzb05GeFl5TUpn?=
 =?utf-8?B?c1d0OGt4VEN6UmZkbHY3VmJMOWkzTkVNbFMxK2VqT1h6NEFUbjMzQ2ljcjJH?=
 =?utf-8?B?ZjNLMThmVjVsNmNhU2hEcjUrb3RFR1BWb1h1Q3VEQzJscC8yNjUzWEp6dDBh?=
 =?utf-8?B?Z3QrbE9VMmtGVmw1K1RMSUhkcEhsR2NIRFVLRGVGK0Q4a3hzaEdLWFh4UUFD?=
 =?utf-8?B?bkp5end4TzY0T2Jzd2VLMEM1SjBocHU0UFVCSHMxSnBNSTdsMDFXdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9540bedd-87bb-4dc5-7d7a-08da4d130c4c
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 08:02:23.5840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GoFausHBtz0ZHtZPLgZG4cNnz0jUtTqzip9MyjdUeiYjJj6mCqsEq0oenoDvsevb+x+JIa3bBF51cnloY+OTGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3051
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thanks for pushing this change.

Reviewed-by: Vidya Sagar <vidyas@nvidia.com>

On 6/10/2022 1:55 PM, Serge Semin wrote:
> External email: Use caution opening links or attachments
> 
> 
> Currently the embedded CDM IOs consistency check-engine is enabled only if
> the num_lanes field of dw_pcie structure is set to non-zero value. It's
> definitely wrong since the CDM checking has nothing to do with the PCIe
> lanes settings, while that feature will be left disabled for the platforms
> which expect it being enabled and prefer keeping the default lanes setup.
> Let's fix that by enabling the CDM-check feature before the num_lanes
> parameter is handled.
> 
> Fixes: 07f123def73e ("PCI: dwc: Add support to enable CDM register check")
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Changelog v4:
> - This is a new patch created on v4 lap of the series.
> ---
>   drivers/pci/controller/dwc/pcie-designware.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 347251bf87d0..5848cc520b52 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -740,6 +740,13 @@ void dw_pcie_setup(struct dw_pcie *pci)
>          val |= PORT_LINK_DLL_LINK_EN;
>          dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, val);
> 
> +       if (of_property_read_bool(np, "snps,enable-cdm-check")) {
> +               val = dw_pcie_readl_dbi(pci, PCIE_PL_CHK_REG_CONTROL_STATUS);
> +               val |= PCIE_PL_CHK_REG_CHK_REG_CONTINUOUS |
> +                      PCIE_PL_CHK_REG_CHK_REG_START;
> +               dw_pcie_writel_dbi(pci, PCIE_PL_CHK_REG_CONTROL_STATUS, val);
> +       }
> +
>          of_property_read_u32(np, "num-lanes", &pci->num_lanes);
>          if (!pci->num_lanes) {
>                  dev_dbg(pci->dev, "Using h/w default number of lanes\n");
> @@ -786,11 +793,4 @@ void dw_pcie_setup(struct dw_pcie *pci)
>                  break;
>          }
>          dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
> -
> -       if (of_property_read_bool(np, "snps,enable-cdm-check")) {
> -               val = dw_pcie_readl_dbi(pci, PCIE_PL_CHK_REG_CONTROL_STATUS);
> -               val |= PCIE_PL_CHK_REG_CHK_REG_CONTINUOUS |
> -                      PCIE_PL_CHK_REG_CHK_REG_START;
> -               dw_pcie_writel_dbi(pci, PCIE_PL_CHK_REG_CONTROL_STATUS, val);
> -       }
>   }
> --
> 2.35.1
> 
