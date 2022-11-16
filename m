Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A45FD62C8D9
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 20:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233740AbiKPTSX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 14:18:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233559AbiKPTSU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 14:18:20 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20816554ED;
        Wed, 16 Nov 2022 11:18:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c5yn54IHAUbaws4WYyQwF0e7WwQLCqPInoBo37tgey5bncMYJIuxCh/Jc0lqSqQ2JbEtpYSGVKzdrAYi1BGwJXibCIDQIPpA6nPH/DMMGZgj9uiXZarg33+lVN+vpl65rk4iDKpVtWJzhgTr5gi22S5zfSIfWRUDPry7w6wczGjZ5/k2tc99Pch2Fbz4ajmi88dQk4FcEveMnYD9JwyXwFqEbvIdCzsrXs+rcY5HdYF0zZilMr9AIaLVhAoHKhPRRmus9OzISYKzLwf40zJ5H+iivJiJjK1iCSNBpQjq5P2vpg7suOtRUv2X0ZuYhzbKHYpFjXeGoIo6eSGLme7SYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5yMnwRQ1UARMUELDEK6pJJoXxoXQGVPncpm8DUfVUW8=;
 b=b6oRcXH38xYnaYD1uV/jlJvSmUOHul95/3ogESZHOG4J4NGCrH5pDL1lVtUqdC+60utr4HpVccLLBRsIuM3swMBCTDctxSe9eb/TWbPWu0N1BWxGSLYeDSV38mG8KCXGD9f2N9MkR+yR7V09lQmqUaDYZ4xrvOmEwdm+6G3Gk3Kj4xut88nbfxjIuFZaMRkMu+01KPpJGh2Sz2l+3thJgUkZov5gY7K7ssYj54z5guw6wMSHsmKMptsB1/ZlSGPjgwu064Iw/X88KL7b5vWOSwHVbifb2HZKH6CPu8aT1MxYo27QtXDQXHOUfdKO4sa7mMFkFsrsclEe3yCfePmqDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5yMnwRQ1UARMUELDEK6pJJoXxoXQGVPncpm8DUfVUW8=;
 b=nvOSi3D1IzwqSdAYOwaDvjfuYUPyw5oknloZNAotjH5CsjzK1vLKvhDR76/DUJAaWVHqEwUtOlLYAQ7boby+0jnLRqZ2r7vwK9hBUnEZA4zP8e3LbO8adXoByenNlTPFFPWso270KKmBIwxKTopS+YyRQJxTPCoD4C0QiDxLPhfORWuGA1N4HTT5Fue6MjinTQaVtd/DgKg7vdS6uzU0jEJP4Vi13FBVVzOHeRLGdKRm81D+yY7J5zQhMdW1TPkczC9mpr/89cVo8qLOHGS0cHOgR5xhQAP2k0Eja+H1cOrVCDrBq720Pa/iHCjup9wgMDbZXzzK54GNGFmkGC9EWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB6885.namprd12.prod.outlook.com (2603:10b6:806:263::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Wed, 16 Nov
 2022 19:18:17 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 19:18:17 +0000
Date:   Wed, 16 Nov 2022 15:18:13 -0400
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
Subject: Re: [patch 13/33] x86/apic/vector: Provide MSI parent domain
Message-ID: <Y3U3dQhVCYF0on6v@nvidia.com>
References: <20221111133158.196269823@linutronix.de>
 <20221111135206.007864377@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111135206.007864377@linutronix.de>
X-ClientProxiedBy: SJ0PR05CA0097.namprd05.prod.outlook.com
 (2603:10b6:a03:334::12) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB6885:EE_
X-MS-Office365-Filtering-Correlation-Id: 68832f0c-da19-4f57-646f-08dac80750e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BOdQ1Ntchl4TNRgBqxfXG43gXN4Nczoo3PWdIaHwBluYjumZ7BQk8fUpNAh3xfzfLJKPpyV4k9PcQE4PN1018VZOqqD4L4ldFi0Xlr/byW2ZDpWAZxsSu/8xSAxfbuYT2i7TPA3ZgbEyIyog4WZqRCREVuztd9o4fDCwhJQcqBtNrQiOkzhNbiu/JfDYpzs8q2rGaboIUsCn1iE1pQ768bxUOK/cJXWhqpgKTiK8Un2N/4J2XIYPWcpJpMq1Jg1mhiALguG/duX7cNT7hzjkK574KoaGTOadbaF+J47HIFXoswLrysZYcWbtjC2D6RQ3q9OLy4EJRaRsdNOjVZclX/TN56u5sD+hizNRon1guvOx6PuSPIuEhbps0zXPq09UJXQc5RNNKzsRsPf9hW2geHn3IFrSxv6B7XgrGokB3ySA59LPNjNArI8e+Q/qW63C3xeD3Gz1NrkcPrp1/AmX7JKpQHPpHn7Z8TcGBUGl485mvrlx35FYAojgNfWG6rKRyvA1DKaZ+g7c11/qbqAQ5zg1kuhnyp7gXOE405K2rKsjDo/vyKZfN+J2JYK5akbAemAlmHI20DS3QQDvMHypDNDBTRNEfC3tCS8InADLLaQUaZCJ8T1jQspc39fU3uxA8tuR3hak1nBB7wMqQDGoniOb9AJWVNpB3efiYy02TFk3+wWaexu/InMh714s29Hne8gsMM5hiYfJzxRXebY8hg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(376002)(39860400002)(346002)(396003)(451199015)(2906002)(66476007)(66946007)(6916009)(316002)(66556008)(5660300002)(36756003)(8936002)(86362001)(7416002)(54906003)(4326008)(41300700001)(38100700002)(8676002)(6506007)(6486002)(6666004)(6512007)(26005)(186003)(2616005)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XgiSsCPq9XRSyvDxOHog/qWhW0j+f3xZwSYBtEM+hwg/MrNWPwJ3NpHVySwr?=
 =?us-ascii?Q?s1cvfAaaF5jBsiYdSY8PelGIv+GvpAyBcCOaon1lVnexD3L5BFirVlXs7AAs?=
 =?us-ascii?Q?drH4cowci9La5jQg99Nptl9FdJ921+0QCOtqEqpvBBQj5kUXXqy7MDFwJ9sk?=
 =?us-ascii?Q?CAjd/JWx2LIrHTV4aO3tQ5iWG/RbxX8uT0oM77XD2fXX+C6AcL49N3qcVUk4?=
 =?us-ascii?Q?XQI/t/uITfScuxd8kIVwovikarNZ9bq9jWuodsBmKM2Dr62Jbl7wXuKKjKid?=
 =?us-ascii?Q?WDqzPZs5k628YRG8/VFDbrslCde/xmoEUlrzbCPKMg9kVXiv1kmesr8brcMY?=
 =?us-ascii?Q?CLzaN7/plFDex4KwowCQtPR78kkuqtHyL9Sfgjxqkz19lelIRruYR3gle6AZ?=
 =?us-ascii?Q?gcaNckGIBlLCuj/Vrj6gkzTBwVMEObeC8ULq+aWIKNi8qbrTDI4C4h+W5koF?=
 =?us-ascii?Q?0Qav11NyjrQ0szhyEWMmnPHGUT06WDTtpafxGvOmqdX47H84vmalHx/TOeAR?=
 =?us-ascii?Q?57GcaU5qSuC3zam6ov0mgLAcx/6EoTRNgzYeYtFiVMPTXUP3jhTFQPE6TP10?=
 =?us-ascii?Q?ZAG7eeWdDoAirqPt7HuC6h2Dw9ex/7yqliD+/iR1zYopAUJcNfoqj1kVYf3n?=
 =?us-ascii?Q?T2caLiOdnb7DGvM6wbUD/ma9ql5bypNsxpGwyopYzFn2XsMFYko42Y+KGHAt?=
 =?us-ascii?Q?VEs4fHlglHR9a7OZKF71MMqBiiGqzg8h3+DZQpNq4fxoeJRUxgXK20Zdoxi/?=
 =?us-ascii?Q?zJreJWg3KyXB52kJR8kDV4V8oMrU0QK3LcWhdxUxZtFqG/vMDA/NVUOI5dj1?=
 =?us-ascii?Q?3lMWz9TRLrmSuud91/QZMsVf3aRLoxxYItlwGZFiVZn1CxWLgp910i87K1B4?=
 =?us-ascii?Q?Hf5BoxouuwJU8BOfMj6XRo3MClMDFjtoBo/iaT6UD+RnnNrTdsnCO3MCw366?=
 =?us-ascii?Q?LwPdjRuKWEc+Q2PNlrC7D5mK0RDbJBF2A6CMBda0owncQWYqeTPyEcmzt6K4?=
 =?us-ascii?Q?/sj8Zu6JTbCISz7WXnhw7+iweYpgrM+1mcZvdIGi9VAxLijJ0QR6bxSMbIt9?=
 =?us-ascii?Q?DTduZxphC9ZGueaxV6eQ5RJaRnwvy44HVTC9ifFpYT+qXU4GTcj91/uuCU/0?=
 =?us-ascii?Q?VQWgvrRaTW3lW27xRdiwa182QYmuUcF2u+F8BeO5VJStJB3ECfekIGyBi29U?=
 =?us-ascii?Q?9hRWz+5YkfKLp9qLXNnfqCZuW5D19NuNmFVwVE7CBNCkLV0CaKL4Yff9gbft?=
 =?us-ascii?Q?MEnxIAN6xSplwUQcXEwITB3OX1uxpwOW1J3V0DzuQIVy85tK/qic+bFJS7vc?=
 =?us-ascii?Q?gg+yTpWbsgFHzPKQiOZLmYQTV1j7Y/Hn2NO3KuOaei9R9fCoShswGdxZaGsx?=
 =?us-ascii?Q?XvMPWtNKZFEDVv+6rLVr02uAXin2aPwdOm9/BUj2UsqAIxQGOtVqdkOQRfN8?=
 =?us-ascii?Q?E1hTzASf/vtm2LxQ5xNXSUxBCJsOoEr1TmKsAW96PD97x91+fJr9YkQWNvCp?=
 =?us-ascii?Q?tufi9hgYBpspvYEF120rpyBcPfS7W1C15Hy/K6UW7J7iEwPzcdbnNTnWCncP?=
 =?us-ascii?Q?WQjYQ9v4jK8JzvDceHI3aPSyjBfdFxDX5SNZ6Ae7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68832f0c-da19-4f57-646f-08dac80750e1
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 19:18:17.5183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vFwGaVka1JwG0H5HbG1dIkBCL2CFeaBDDWj8zaqq0lzH4IJiDHGYmBxKV+IghIjb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6885
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 11, 2022 at 02:58:31PM +0100, Thomas Gleixner wrote:

> +/**
> + * x86_vector_init_dev_msi_info - Domain info setup for MSI domains
> + * @dev:		The device for which the domain should be created
> + * @domain:		The (root) domain providing this callback
> + * @real_parent:	The real parent domain of the to initialize domain
> + * @info:		The domain info for the to initialize domain
> + *
> + * This function is to be used for all types of MSI domains above the x86
> + * vector domain and any intermediates. The domain specific functionality
> + * is determined via the @real_parent.
> + */
> +static bool x86_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
> +				  struct irq_domain *real_parent, struct msi_domain_info *info)
> +{
> +	const struct msi_parent_ops *pops = real_parent->msi_parent_ops;
> +
> +	/* MSI parent domain specific settings */
> +	switch (real_parent->bus_token) {
> +	case DOMAIN_BUS_ANY:
> +		/* Only the vector domain can have the ANY token */
> +		if (WARN_ON_ONCE(domain != real_parent))
> +			return false;
> +		info->chip->irq_set_affinity = msi_set_affinity;
> +		/* See msi_set_affinity() for the gory details */
> +		info->flags |= MSI_FLAG_NOMASK_QUIRK;
> +		break;
> +	default:
> +		WARN_ON_ONCE(1);
> +		return false;
> +	}
> +
> +	/* Is the target supported? */
> +	switch(info->bus_token) {
> +	case DOMAIN_BUS_PCI_DEVICE_MSI:
> +	case DOMAIN_BUS_PCI_DEVICE_MSIX:
> +		break;
> +	default:
> +		WARN_ON_ONCE(1);
> +		return false;

Why does x86 care how the vector is ultimately programmed into the
device?

The leaking of the MSI programming model into the irq implementations
seems like there is still a troubled modularity.

I understand that some implementations rely on a hypercall/trap or
whatever and must know MSI vs MSI-X, but I'm surprised to see this
here.

Jason
