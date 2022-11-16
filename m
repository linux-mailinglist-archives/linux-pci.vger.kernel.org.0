Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC6D62C7B4
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 19:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233487AbiKPSgN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 13:36:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiKPSgM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 13:36:12 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6984859852;
        Wed, 16 Nov 2022 10:36:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IhdRwdAdrjdaZXkzD9qSnWilhS6c1pqsfEETMQe4r/OkZ5anHbds9USQXzL3X1bfhVMTsNDjF1JhNTrb4fi12hapNOJa3avb4A78Tt3amolr3YhbHOTx1OUOuhnoLyEeLqhoxX89+KzAaR18XSyOmNARAWjrD6B57obHBcmQTRstTebexZr8jzeA9n4TsbCHUJsUJ/3ob0pGG3PXU8RRLsbcgT8ilPveSsj27dMiiI8zMIy7k8Gad10cjp/mTbvmd1OlNvHXm3ncn0OTsHK0uIK5Toq9tDonKsy5EbDl6NWGEpgPujnUlnyH93gi3QMfEHp+pwVPkLc2cpUgeJ585A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LeRDIjwpWSbsYkrA48+yUpsNab03tLjmosf6nqKBqw4=;
 b=cJiEXgcEMi/W+vW995pYxO61QRlm6PP2rgF1HH0nwfYZmlno3TRJRSl+GV4lOVG60H1elOrqiHvzwsu1PjtMPsfueHSGZUcNzZRYUCUTVF9C45jlcifuyaADli3Kr/13QZEyIyvelffYL7P0nV+c5IO9n5wVcHcjr7Ax3LE7X5+iqglCfO3pdOq4AxwsiwWnp1k1ZskmjgCx+mJ60iKDJ31Ol3d0oVCSWoomF3tbAl3u22wO3+KlmOLWH0ZMiZcfVrXyLFOGPNZmrzy/i2kC9NbG2UseoFrofpVw2Y7Mb15eObPBcMicEC8B24w7ERlviiAeqcx/ZzDUKQRnVu+2Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LeRDIjwpWSbsYkrA48+yUpsNab03tLjmosf6nqKBqw4=;
 b=FAMfmhvZqg1D7+tEkxRXjwwM2uwpnvVhXNgFrPwW7iQ+j1KGLvMsIU5fyTR/MGPu7sbDR9Oeuit/a30BNQIV6IujdIDZRrkA0VhLPTQsJs8533jrfETcAUwm1uFLIgiwWMWpA85wcJdx3xtSos40MYDFakyKIgvWE0I3RM0/KxcX7RRqLHxsnF8d0ZA1KKpR75VnN1tZaEAZRG5kWW+JzgzVC6SCjPmHfjG5uVhZ3sFz2dUwGV58oNwer23QiApU7+AMvARainv1yQatvcEyjuily5ZM1Uui9smibKdFEoprH2BnV6gfNka4g6oa97gqh1lJQdMTwY7TGmm/1Pg2Ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW4PR12MB7431.namprd12.prod.outlook.com (2603:10b6:303:225::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Wed, 16 Nov
 2022 18:36:09 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 18:36:08 +0000
Date:   Wed, 16 Nov 2022 14:36:05 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [patch 08/20] genirq/msi: Make MSI descriptor iterators device
 domain aware
Message-ID: <Y3UtlTwIka6n0RuT@nvidia.com>
References: <20221111131813.914374272@linutronix.de>
 <20221111132706.500733944@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111132706.500733944@linutronix.de>
X-ClientProxiedBy: SJ0PR05CA0095.namprd05.prod.outlook.com
 (2603:10b6:a03:334::10) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW4PR12MB7431:EE_
X-MS-Office365-Filtering-Correlation-Id: ba09517e-1320-40f7-8466-08dac8016d71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0AydNw8JPUC8pyR3S1R/lE06APe0TazFCS7lvMfpBJryjKBFL2/6MATxBZPCTiK2ZI/Uv47Bn1J21v3qCXAmm20BEe7Bqr7DI4pK5TrD2IaU9+RzGoKZ+XD2Npq9jUPxJhrUgnXMFH73Nvv55CVphjQth4V718N2Z9J80rpKeOeoQxKJ4ak+/okq2aNICmaMBqY0SUnDkC9+M0dmIx1DcINOsgSI9B2wIZ2xSSTX3tSpR6XVAw3ECk/Ap+X0tLRBGdL6jwgEX610brtDx1lInnRsMd1VdkOLlf+xqtHZh32j3HODK7rEyWAQCuL+MXarrbBONlgw2mrFhI/nW4cr0lGfgIaajOca5ooYeWAlTTV8R7ZLP6pRZGKV3jmsfc4UJ6ngMjK5oEpMCdC0qBnnT56NescSBSeTToiieIOMqiMSx45UAKUU64ON+rAPaVriQudbslBDGrixQkpBvYYn+0on7n4OMiJjIFqlAIrRIu3OyTJ5O+i05PLbmNkwwb8ywPLahKZkS2R7jXes0ZpdVS942VMzIl1UUz1BanROczC54m5xJCix2PkF2VcwmFBVCortXI33L/rYDqWXIXomGPidSkXzZd21pFrQZfvdUa9wyujsGNFwHx3ibgHpVum2Ggrv3OtYcXGesXMLk+LZ1+cDKzyrmvtpzF4mtgXFJqgDw6mxYqz1c8mWWSWcwTF2sLtKLII+kElPvU12nMcSWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(396003)(39860400002)(366004)(376002)(451199015)(2906002)(36756003)(4326008)(66946007)(8936002)(5660300002)(7416002)(38100700002)(8676002)(83380400001)(6506007)(54906003)(6916009)(66556008)(41300700001)(66476007)(316002)(86362001)(478600001)(6666004)(186003)(6486002)(26005)(6512007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rSq3xpATKlbggA1STQs11Rvt5xFhWUhs8fLyFuweN29KTuV2lRSrIvPWrPcD?=
 =?us-ascii?Q?bZj7MaaMAu13f/jhhpd1XnvB8Bujb3ufUVEgpqEobr1/XjUBb7+cukK0hNEx?=
 =?us-ascii?Q?gdOlzcxIl/Xt0E4sb9a+H9fSVBOZ1Jr8DiAi620g1Xm6/LJ7V/zNFg58H6+R?=
 =?us-ascii?Q?BpxIz7D2ySsHvMnl6FPm8YBjFcOMusemr9r9drPbmMoqYSrZZOI2tRpFsx7r?=
 =?us-ascii?Q?nkbuyUn/pijAjWOEZNjMF8ig9fdVHVIDU8CweZFV1rnOWuS5o85Ml4ZaJ3hp?=
 =?us-ascii?Q?/yQ+0tEhuiRZEj6Scm0lAgF/PdrjZ1EDQatVgP454ylumKIj6WyWOkwTmoe/?=
 =?us-ascii?Q?VMsbu0Y7Yvq6VH1AFQIAKDpAHPsYbtVdh/S+C9JyiFxUL/JMAObtvX1DxiOD?=
 =?us-ascii?Q?SfGV48t2Wrj/3a0Lz+siT6XLwI8MEHXoLxttu/HYoovj8Rkyf2gkXhLXFbWS?=
 =?us-ascii?Q?bf4EatdiWTkaBaNXSJz7zGoGjxrowfCpDde2h+LaZMqFtdtgMBWKGpsDjU8a?=
 =?us-ascii?Q?/63MbC1dDhsPkFS8lZh2tJM0JwqWSsPDEucd56OmkTe/WGb5RiXaG4aEzBgr?=
 =?us-ascii?Q?+TP/e7VfaGELz9v4JIeJZkrF8UGD3uSEMBz1geK03wmKmAIVlWSTHlULPbpf?=
 =?us-ascii?Q?M+4fY9BtsZv7JpXpoT8gfGdeQX14xLxjj+lc0zPs3IdrX+os53r1ha/63OyJ?=
 =?us-ascii?Q?WFKqMH4XM0ASHVrGuXD9yNU590AM3gbcp7ujX38Rxh24uFp26de8l3nQ5jJ8?=
 =?us-ascii?Q?l4/YXLsK326VgmMAonLue4Yf1YHE+N6OIu0AnYqRLtaSAav0S+o8a4H80WUS?=
 =?us-ascii?Q?7nwNJRLd8NoNFpYg6s8QAkB/kEZC2KS6GeRyqxQLLStxBW96rOBP6UcUk/B7?=
 =?us-ascii?Q?Ek4BU8clTOJiCZ3XSx5vzPNOx4wAZYFSnTIWhw2C4w6e72HdUKvyraTqv7vD?=
 =?us-ascii?Q?gEgBi8BKEUO6qoKmfItn1JnIDsJDmNjuMtB2/bbrtPh9+v7tBX+gOjDsloyt?=
 =?us-ascii?Q?Lxnn994rnnx1ELXJDYTVpcTsKwpQBSOEV6KwRC4Pc7eCxgV5CM/39Karb/3Y?=
 =?us-ascii?Q?BUKEKJnUbO8BZVS3n6iXZDT9YIUdG416/xWYDWuVzbihorr6C5PqsDOhByl1?=
 =?us-ascii?Q?q8fSmDiNL7SfRgrH2IDgO7kIeH3uFSItSKZ5+NYewqJu+PnkefMB84u7X/N3?=
 =?us-ascii?Q?P5qtK37cJ4BhwoPsugpwOx4hwMCR2YR4JHqiC7hfq4hUN59PS5csAKgmWFWy?=
 =?us-ascii?Q?xs1xya57/o8cbPzZ2BPha+vwp7JWTspRH6MaWGp7M8g56DhjSbjMSTTXoy26?=
 =?us-ascii?Q?zUOdFsZIBVtFXtIuJFPw8XUXV6l9t9+VJmqFVRA/pAb6fHIyfR0id2IhBgjW?=
 =?us-ascii?Q?0SoJCXEGfPOIga90AEFqmwqFibu31AL/P8390FWQbUk4DAdWdZXjcuTgllw5?=
 =?us-ascii?Q?hasDqgrFbZ3DOO7rgNK9+rJt8yyzb/ByHYiaGbnr3EdpDPabvt9UYlf+rmXk?=
 =?us-ascii?Q?9jH7B31KKyYu4EN8RZC5Xh/bE5ofG44I3Vtp/47hcirTs9sTqkJL6pcO6ULQ?=
 =?us-ascii?Q?GS5He+FxGDtsgIT5gHtxfkPPBTlplZpMhLx2SnxN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba09517e-1320-40f7-8466-08dac8016d71
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 18:36:08.5044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ej+kdpjGroHFyUUOKiwPeXwoXEdDVGbQws+NJCh3RGuzy6uqPiauUwgA3MCejHdC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7431
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 11, 2022 at 02:56:50PM +0100, Thomas Gleixner wrote:
> To support multiple MSI interrupt domains per device it is necessary to
> segment the xarray MSI descriptor storage. Each domain gets up to
> MSI_MAX_INDEX entries.

This kinds of suggests that the new per-device MSI domains should hold
this storage instead of per-device xarray?

I suppose the reason to avoid this is because alot of the driver
facing API is now built on vector index numbers that index this
xarray?

But on the other hand can we just say drivers using multiple domains
are "new" and they should use some new style pointer based interface
so we don't have to have arrays of things?

At least, I'd like to understand a bit better the motivation for using
a domain ID instead of a pointer.

It feels like we are baking in several hard coded limits with this
choice

> +static int msi_get_domain_base_index(struct device *dev, unsigned int domid)
> +{
> +	lockdep_assert_held(&dev->msi.data->mutex);
> +
> +	if (WARN_ON_ONCE(domid >= MSI_MAX_DEVICE_IRQDOMAINS))
> +		return -ENODEV;
> +
> +	if (WARN_ON_ONCE(!dev->msi.data->__irqdomains[domid]))
> +		return -ENODEV;
> +
> +	return domid * MSI_XA_DOMAIN_SIZE;
> +}
> +
> +
>  /**

Extra new line

Jason
