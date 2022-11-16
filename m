Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A6862C8CC
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 20:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiKPTNK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 14:13:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKPTNK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 14:13:10 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A333E089;
        Wed, 16 Nov 2022 11:13:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJF16SNJIb5jOeP5uVYn+wqNWmZv/cw/cYLjQtR1m6VGovi/UkCLwgK8H2+axiYpmSlyjhPw6wFZlU5x3FXX0J3KlSZr6O5hkkIzp2QdcaEqzqsCgI5I1Y/3glh4XrmBmpWUychOoFu4/MlZEwQuryua5rO6YkEmjrfWrS/4h+fz+hAk/ozuWjEX85qoHFBA34M3tj79y0vgZ0IZlNhtwjkwRIkfMe/uwZN+cHWJzIccpjxiWhJ0SNVk1N7xvdayMaT+D3hKaFS3oHi1JbhAnwhiz6/eSPOPC+s6yui3Zzv1ch7huaxUCjd/9SusaBuUN3ztAt/lDk1UVBjHflp4ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9xbSaWjEgbsgTjU0YvGrnI2r8rmTEG7YsreHD1+GA2Q=;
 b=fIMtT5wCX+CO15m/aiWDO7uQ9k2IZ+jgD97fzipU4dRBRgf000dFsYCPA3grDK5PlHMtb6Qyp3eDTV6nV8pxh2LNB2OOXbUKQz1DroapctmPbbrQSRoqPbWC2ck/NQPmOpRLc7QVCpCSotrMpf42a4KYgUAFgXTxchtOUb4NX3/JBwfFAyhwIElp9L1na66jj4oSLO07t+eowJFVQ5ySkdjqYrrGxnXss1E6v8cTuXqAapE5+20dIyUgfWac6hx86uBKvz2EaFtxNHGz9Xpi8rKsYf27tPBEwHr7Ssm6gEbXDy2hsZuTHy26GwwB1mcrZqEZ5aQfgHaiunpQrI8hYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9xbSaWjEgbsgTjU0YvGrnI2r8rmTEG7YsreHD1+GA2Q=;
 b=TgaXo3kD0Z5r4CKlMht1IaMvKla0951dRxm5DasenwSINJCswjaTZEQq8+km9XdBh3aZJo1osbZ+0LQQgKVJmx4y9I39oi58IkgYG94uNYzRI4ibVvBKRmxatBahlm+92SdJekVvfag7IFWnhInWLRAcsBChudvmnYWfJJncYT2o4SeWdZ0wER/pL+KRSIWo31v3CXgcQOrxDF5jVqMj9Xhs0WKMBi8Uxqmab6ZeqNfDslHCvl3EcQ3GUhOI6+elprZQPgOBBpd3uUwUnM/pUp207uZSf2QJIYHIYfzOuUMn6sz1+pwf1HxSr/tp/6me/141QTOFykAg71POYYaYtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB5915.namprd12.prod.outlook.com (2603:10b6:8:68::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Wed, 16 Nov
 2022 19:13:06 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 19:13:06 +0000
Date:   Wed, 16 Nov 2022 15:13:04 -0400
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
Subject: Re: [patch 12/33] PCI/MSI: Add support for per device MSI[X] domains
Message-ID: <Y3U2QFeoDB17kbIC@nvidia.com>
References: <20221111133158.196269823@linutronix.de>
 <20221111135205.951710169@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111135205.951710169@linutronix.de>
X-ClientProxiedBy: BYAPR07CA0023.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::36) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB5915:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e89fdaa-731e-4af4-2a05-08dac8069799
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j5lK0eC9cDbhx7zKJVcXv3MaPCFY5oyLG3rB02cAoZH8bpFDYojYUtuNKSDfhnzRVOSoX5UIkjuKZ95QybiFZzSBdkyOIs5rgAsgs5cNu0NGTUUhT8zT5xpOMqmNMXXMl8//2LrSS2K/yt0P/3IUN39mn1WHLcRJ1hD/kaOml3eN1L77Y8BdI+iP+C6TJjd8K3ZSv4P9rU4LF0wvANoxq0X00K/Tn0uS5RYkeeh4Ogrk8K6MD+CbRtL26/LwXQ86jFsDcP7hzTO668ZKO1yMadIsnqq5j0TK+CzcOVX5xB483LtICtjEm4K7jLL6V/cjR2u0NUSzfCLI663HDEVMmFMK3MrY4PHKGSwlVs6KWgkEqAr9o0nXpSzjFgyW7uFTWMlIwYn/hnRQv6xBOkYU0cWm16tELXFKZKp7u3Habm45RXYwD2PJaOoQFD0NLgw05G9b7PkhiTux7juI16TUIPzoa0hOdUE9g86wC9jpcdLhFB88Jvf3WhBlMmsVmZ6SyZumsUb27QCwmpZ/a2GdTuefWndl7qKDJ3Cx0BF9MYT0ai4ATXU0aaak8iN2H46QeLS2ErjaPerFy4njsCIQQtwlBSVTmoOqfA+6i1lL+JggMJcmWz+WV2SbmNWWuNVF0RLoLS6jpOnGI7MWli212HOuSC4Fsb7927WyV1x5MvZPX2suhianghQRQAtZlzp1ZVVxMbcoVb/5cnM6HDjSSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(346002)(396003)(366004)(451199015)(5660300002)(7416002)(8936002)(2906002)(41300700001)(54906003)(6916009)(4326008)(8676002)(66476007)(66556008)(36756003)(6486002)(478600001)(316002)(66946007)(2616005)(186003)(26005)(6512007)(86362001)(6506007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w/BObz/A9HBMVCyDRCkxi377mzHIz6K7moDgFef5fbbIMTr0UavhGRQKwQlx?=
 =?us-ascii?Q?kKHDeVLxLTjsy9EvO1PJ75yvV2f9wvAcgKr9TClxQm1EQM89u8ovCPYWDpfL?=
 =?us-ascii?Q?trJbvk4mWnyABFH+WzDiUyXtFaqbXe3JheT/TeJrwLdEERHWnX5efqGh5EqM?=
 =?us-ascii?Q?mj8WSlbDEIsdE/t3LkLESavif+koPvomkMiQoxk9j3AkAvvuyY2X1DsdX4hp?=
 =?us-ascii?Q?qAObs0EG7p105cnVaCrg+azTAWRvzfvC7wFjE8Ar+uUykcZIRK8QVFD2MDyB?=
 =?us-ascii?Q?mOPzxHO0VpdsDrC0054AKvICj9vJdyxeoMgiNlZdqT3JMujLQxjGqfAbyp/P?=
 =?us-ascii?Q?ChGlHQoIm4jisAoITIGrlKSSyXWtU1e1fUAnKkKq052447rMzhdkM9WZvYsN?=
 =?us-ascii?Q?/bl4Nm+2ug+ZF+id8D96d4vmEJk58gMS1UZa/USSVKQw07ELuiSnWapij7MB?=
 =?us-ascii?Q?7tiA2RpqfLw7TqVGVmjDY+LF/5m4pwBgjzCVuLnN/uecozwY73FyCndzF/Xf?=
 =?us-ascii?Q?8VU4hV2dfNSSFE2toKgLva374hnbG6jvCThKOsI93PPRyIgZHdNWXtPcP7wV?=
 =?us-ascii?Q?2Q5Lgr5i1sY4Tlk4tOA8849xP//qEb/OUuX+6YgeP2GRsakwTn6yY8UAit98?=
 =?us-ascii?Q?IF0xbPjrn2/QSyaO4YG/JzjseOTLRsaJ+2pFPwnpdd3P6hSAx66VgJzroU2b?=
 =?us-ascii?Q?E6clyFQJIvwDN0Yt6zlceC0xZkD2B9nK8r3z5M093TOs+HY4KcmSaJBTgwnP?=
 =?us-ascii?Q?ntABqwT9fMs4L2tsbCPqnAKsWgiJPm6JbpFv2DkHsN2EFYOiEer5HLXmbd7J?=
 =?us-ascii?Q?xeWiAoHGMVX8BRE9vihwBkDNFmIFzlw1WglaADvFxQiY5yjuky59p7sfEkcO?=
 =?us-ascii?Q?0hWLnzjddprn9pxs8k+S4NCmco/j0LbXbx7Vf5Pvjj0PiVTE+BhXH5SwMPUE?=
 =?us-ascii?Q?fo3PqM7MkAbc7Ivo7sZNGmgtByVI3cFsf9xaufcxDsy9B+jEGvusbqAS+67g?=
 =?us-ascii?Q?hARyo5gQT7zLCxv6tH633r0qfamNl8PHUTWBpzh2ilyB0D1eAd+44rzXSX6/?=
 =?us-ascii?Q?IZUkiSh1ZJsMUpl1DRb5eoKmSEyeO855y0NCLf2RbPILV3qVJNa8NCRE2jNL?=
 =?us-ascii?Q?yZf03hMg3h6Od+V7ZndfwXk+Cs5pHr26LqTOJf0Dl4dZHVCSgoqED/PIjWVX?=
 =?us-ascii?Q?YZ0CQhGiH3miu5k8jfyrp9xmgFDqzjgp8zj2pb5mjQ6dxfp6XvIOZOYviURw?=
 =?us-ascii?Q?Q1HnEXggcbTs3n2QCCfyW13kT6GlFh5uzewdhxPfxCZjw6AM7Ktq4LSPrQj0?=
 =?us-ascii?Q?M2zAhyWdvJHOoTKEEfgCLOqJaBvqyKPIVaY9Usn0IMgpPr9JuAHBlrnhLxN1?=
 =?us-ascii?Q?44EPsow0OP37In4Osh/TQbEsmsgbzJ+LFpzK1VlfJUqQ4fWb8YeVsM134Dlu?=
 =?us-ascii?Q?un0XGTaDoHdabZz0w3sL8rmVcMTVXQfEckskw0p1jQRtyzIk0xmsLFBxG5pK?=
 =?us-ascii?Q?nVV3TarZRDVtQ4Bc+WEeTp8P+YU+TBrR4B3TwuRlSgZNz9f6WFf/RI6xYeoS?=
 =?us-ascii?Q?3j1lm6AqTUL8Vqi50U9nsZ5kMQ8P/Wcs/D9h5oeY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e89fdaa-731e-4af4-2a05-08dac8069799
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 19:13:06.6665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6vGIYYa9V12oTcr8I2/bOPMCD5UDOAlsLh6XOiEboODxt2uu96Pek+H64CUMKo90
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5915
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 11, 2022 at 02:58:30PM +0100, Thomas Gleixner wrote:
> +static struct msi_domain_template pci_msi_template = {
> +	.chip = {
> +		.name			= "PCI-MSI",
> +		.irq_mask		= pci_mask_msi,
> +		.irq_unmask		= pci_unmask_msi,
> +		.irq_write_msi_msg	= pci_msi_domain_write_msg,
> +		.flags			= IRQCHIP_ONESHOT_SAFE,
> +	},
> +
> +	.ops = {
> +		.set_desc		= pci_device_domain_set_desc,
> +	},
> +
> +	.info = {
> +		.flags			= MSI_COMMON_FLAGS | MSI_FLAG_MULTI_PCI_MSI,
> +		.bus_token		= DOMAIN_BUS_PCI_DEVICE_MSI,
> +	},
> +};
> +
> +static void pci_mask_msix(struct irq_data *data)
> +{
> +	pci_msix_mask(irq_data_get_msi_desc(data));
> +}
> +
> +static void pci_unmask_msix(struct irq_data *data)
> +{
> +	pci_msix_unmask(irq_data_get_msi_desc(data));
> +}
> +
> +static struct msi_domain_template pci_msix_template = {
> +	.chip = {
> +		.name			= "PCI-MSIX",
> +		.irq_mask		= pci_mask_msix,
> +		.irq_unmask		= pci_unmask_msix,
> +		.irq_write_msi_msg	= pci_msi_domain_write_msg,
> +		.flags			= IRQCHIP_ONESHOT_SAFE,
> +	},
> +
> +	.ops = {
> +		.set_desc		= pci_device_domain_set_desc,
> +	},
> +
> +	.info = {
> +		.flags			= MSI_COMMON_FLAGS | MSI_FLAG_PCI_MSIX,
> +		.bus_token		= DOMAIN_BUS_PCI_DEVICE_MSIX,
> +	},
> +};

I like this splitting alot, it makes the whole thing make so much more
sense.

> +bool pci_setup_msi_device_domain(struct pci_dev *pdev)
> +{
> +	if (WARN_ON_ONCE(pdev->msix_enabled))
> +		return false;
> +
> +	if (pci_match_device_domain(pdev, DOMAIN_BUS_PCI_DEVICE_MSI))
> +		return true;
> +	if (pci_match_device_domain(pdev, DOMAIN_BUS_PCI_DEVICE_MSIX))
> +		msi_remove_device_irq_domain(&pdev->dev, MSI_DEFAULT_DOMAIN);
> +
> +	return pci_create_device_domain(pdev, &pci_msi_template, 1);

Hardwired to one 1? What about multi-msi?

Jason
