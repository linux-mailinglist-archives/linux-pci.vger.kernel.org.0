Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE53062C88B
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 19:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbiKPS6P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 13:58:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239127AbiKPS5w (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 13:57:52 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6F160D3;
        Wed, 16 Nov 2022 10:57:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aAI1pRSgginA5FDIyv/YzR2tCpNtLd1444U+k5Ntayo9pRsSG3XLmRQuyVH6S4zPrOs2pHmiM/q9FPLgy6u/l6SXMkfKgYt05DSqfkBFhkkkqloU6Hoxt+D1pdcpBIezdp0eERcbtvhV3hBSkcwrcyTJrer7H6NW7CEpqw2aNHURAdksDNCCLS/vZBAXokLtj6O9Qq5zfjcvb5USqolm7B2TQdXTXyhGa9SK/oYx2UYIGVMaVRo2uIfWlMxxkORjM9lXxBx16//enobCe4CBfHteHZQWxLtF20/Kobgfya4mxPqGKPTmYs84h39Es0a7Y5ilm3dV/sVf3W1Sbkxneg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7LxBuo9gpan23KxhEqhqZ3OStvyWdRRUk9xlz5pZs+s=;
 b=JmbIE5MD8LRQCJ5wSNXOab7q9dlb4wXf0hF3k0yKEQ1tv/YJRDe5Ybh1bMEYb5dZQufXGrcDvQTzOOmH7E7rKhDNwXdJ8h6Llr9hL7I3HBn9wxnIBKkcu16/H341dBlZINpjcBHLjSzssuibN1Um525iuASVMBN3FPFE3ASX9wk3XyEs46lqaqIWgrrIfTFOS5A2GqIyBoJ4N6WWeYu9H/cG5tYy7Brt3w0xS8/bILSXHCCoOYO6wcNx/eghAZQ5MUVaOYT5vlC2JoewNO1WHpNQNcdi4UYa4pr3C6trN6ciGHUGVXO1UGkqKmER+ZgVpryLP+/7Pv6gQjdWIxeoLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7LxBuo9gpan23KxhEqhqZ3OStvyWdRRUk9xlz5pZs+s=;
 b=ME9rt6fE9dHVvOHuHrmeTEzcF+sx68MCZrYucj2BtghHoON7o7wA09vBj4dxpk9MH5VsxMISqSQzCx1UlS9OkwWd17p8STgDkXKF3H+4ko87/zfO7GurbNHn5rLQWs6cdx/teCljuIAQ1utPeeTPIndCLBopd04qNqIhRRISrUO7iMZ7Y/K8P7Ll249TIn1/btS/K+9V3X6Hm1UDDh7niHRigSoMiIoVmbfUuK5ZooS3aXOovdg/myhxgfdDms2cmjHsxOcoM6As4l7GSEvB3aiQXt2Cd+8rk/BC6fhxUdSze771RhYVj+USWfRzjPVCsXe7qKhK4gIwZUYbmbQSuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB5853.namprd12.prod.outlook.com (2603:10b6:510:1d4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Wed, 16 Nov
 2022 18:57:37 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 18:57:37 +0000
Date:   Wed, 16 Nov 2022 14:57:34 -0400
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
Subject: Re: [patch 02/33] genirq/msi: Provide struct msi_parent_ops
Message-ID: <Y3Uynk6brtNVFUH7@nvidia.com>
References: <20221111133158.196269823@linutronix.de>
 <20221111135205.368911521@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111135205.368911521@linutronix.de>
X-ClientProxiedBy: BYAPR06CA0065.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::42) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB5853:EE_
X-MS-Office365-Filtering-Correlation-Id: 5eba28e3-a699-4eb0-f905-08dac8046d6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZxheUkwrsNlclpzzaPwWukGC711cc5BhEoX1uLVQojEkytOStI3vZ6kv5nuGs5VN/8OPRpw96/GUvgU5mHc7dIMTW+S9rlJrGggdJAsWqClp+FCLT4sSkoDlNs85ht+Ut4Ef0N8uk3dbPpwIdweJU2GM5xIdVAmSIJJLAHhv3//NoglobSGtNqbDQQ6LN7eZeQOveGjUJ9t/PFfbYk4XnB64sYPNXQTOxCt54ccdeXtmtQ1l5T7vN87yLlKsQiWEivnPjW3Iu/H0Q57iUhF5ecuA3DiGNwtwH/24NGz7tFXNdUiRcnA0hf5TjAOBHBO1bwValNPm9Evbq8VswMhluvrIWLAUbErA6IGph/qbWMFUqq8G9px4EpQEOR/es/qh3zxxvySYHVPTofbXSQugFT5wo9HD5JT2SGuYzJaM5ok/PtxOU6waingmvpA/BYQ8qN/M4FBrRNg3hW7NmnMti/H4jY0qDh8//xCB89EQ9YGHO7f2DjUerKBxdphCWn/vSnbOmLiji1LJu8H6mqwYG62HSrd3DFI/olDjXKVpYC0Fs07VM2jh+G+Lgwa+szEGDmqcC7bS65+4n0d7iwWTkBw4BBMtce9+B6jmH8vTl/AHtTZYGY+DmiTYkY+k1XM3QYaPZzP7MC+qYTkic4e/7h6VMohEJeAZ/765uzxSQ8/OIU7zt5S+CQNoYvw7CXqO8ZOOXMtHG8pIqCta+mx80w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(451199015)(6666004)(478600001)(6486002)(66556008)(66476007)(66946007)(26005)(8676002)(6512007)(54906003)(6506007)(6916009)(316002)(36756003)(41300700001)(4326008)(186003)(8936002)(5660300002)(7416002)(2616005)(83380400001)(2906002)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xHTEXpAQ4W/LnMqWZLIhzXViZu5ByC0F20TdGoZJYtETKgU1S/TPLFEGuQp2?=
 =?us-ascii?Q?CoMCbsB9Q0pHqYrkajgEDNdSXhcgW05yRUdlso7AEjRf2cGAr8n3sznnDn/g?=
 =?us-ascii?Q?oDryC/sZrdcOhm2h7wz5HAuLVHUZwmrLMfAinudLO5qlVb8Xjvrx3UDBGnOB?=
 =?us-ascii?Q?QfIokxBggvQR3vF+/bz/6jXjk6qY+DCE0+iItmjWAjSCnw7+gL70FNj+llkE?=
 =?us-ascii?Q?Ck6DJvQnjzPGdWgbtMTnrGbSYmoGyaMDoXqXI/1GdWIIOz/Co8h2bYGiyZbJ?=
 =?us-ascii?Q?FxtrC+XiAWGE+Jx3I8unzRc5csdN2xYNaDE+36qeOwIvsvkMhqe5xaiv7Prg?=
 =?us-ascii?Q?LUqWPBUyqda1N3YKpBqsVdYuwvAIoCJ4mwBDwGpO2vg/5RGCXpnMzSbVAB3C?=
 =?us-ascii?Q?In919kIpbTnx+0Lxw8IdtjptErkeZX7XEYmN8Sf/73tSpT98xcyr+0iT3Dcy?=
 =?us-ascii?Q?G+yPXebGTgNxWzDJSaGeP4FNKXfrxIAfuKAnji1W5ZS2O7ViAsXrT2egcRxh?=
 =?us-ascii?Q?yO9Nv0VclzOij2S3IAvNznkqqZDeCM2pkFxgt4Rn2tq7UJC+3hHe19hGmsO2?=
 =?us-ascii?Q?OeHL9fG7qN+2xxSPa7QwZhVF7QBjg3rxYKwqHQOS5ghums9ZWU1uA6fbBn1l?=
 =?us-ascii?Q?pVfZoZTzut9AcbEaeM9aESCQcGVq9Q7hGcjbiNC94SJjxMqOoDAcxI3RrTmP?=
 =?us-ascii?Q?LXI+mJzo5ezHitrSh+ElTKC0U0bnFikmSdUy8KZOR6mhP9gMpmPbsDVOgO3C?=
 =?us-ascii?Q?mJPIqxqgEmhczCkrV9XPN0X9lMkZPbGnIcNNYb8blKTvXs7fWFe8hnIeB0og?=
 =?us-ascii?Q?x0rk6ENtLiqbOXcBSyaOGMQr3SkNimSiS6BPimRu9nHZ6cE2PlQg5H7CH4Vz?=
 =?us-ascii?Q?DaZnuLkjA/wH+6AcNyRZkWxzhnEAqcDw5CX0I43JClwdFs7wsYpO9SS2nunS?=
 =?us-ascii?Q?2N0cGu0TGjP4rwdp55lmT0gJ/VFiMJiCsguO5E7m2rXw7Uj1r1zaM+486Chp?=
 =?us-ascii?Q?sPuExPuPVTaFWQ2AWqvDN435qdrhyO3KMtCO3IzpToSM46uPnu/aYfNq6kso?=
 =?us-ascii?Q?CX5h9PMIIw3OEk8JNrn61/O5vQoVjBzFNYQBRyZBb+s5/oATS3d/Ta9Tzo3G?=
 =?us-ascii?Q?5r/oV7tzpyT66P4ZNfnD67a8ZE2u6iAFT3mucmSdyWWSx4eUMp0F38KYV7X2?=
 =?us-ascii?Q?MvhrA5aQ3wFbEyaOQHEtHegByohxJzC17NWKm7YIVMCeQCJ0/u+MRNCvo3yJ?=
 =?us-ascii?Q?UeCv/7AG+0goZ7fwI7xz3pTuNdBJsOhdLAoOo36fZl3yZ4uUSvZkugvMpdej?=
 =?us-ascii?Q?pu6iyAKY9L7ZvS5z7ajWh+1KqlfZGss91/1KS7e+HmAYVakXWol3L99dtNIb?=
 =?us-ascii?Q?CoS6jEnHxBOAIVlqRFh6iBLlftcTmF6OGQoCnB1X/UZ4TB4rwiRHUVqbe49d?=
 =?us-ascii?Q?tsil1v2Y8kLSlzYZpust1kLIsCLHbEV+LsH6GrHEGQxDvprZqp2Wlkzy8lBN?=
 =?us-ascii?Q?xeMT4cJqKMpQY1Dm25x+ayJquQeVqlVQwFEb9Y61eLoLDQF1i6Hxw9jkVBmt?=
 =?us-ascii?Q?7jTq1hDIWBSwBXr7XW5Z+FtuYuOyrSJVAvv6bP0a?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eba28e3-a699-4eb0-f905-08dac8046d6a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 18:57:37.1247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +e1CNq28ZGN2cWwJ9MQZx380cKh22MQ5RgWyVirTXEGFKNOGpOUnRSbxq7aXzwJQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5853
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 11, 2022 at 02:58:14PM +0100, Thomas Gleixner wrote:
> +/**
> + * msi_parent_init_dev_msi_info - Delegate initialization of device MSI info to parent domain
> + * @dev:		The device for which the domain should be created
> + * @domain:		The domain which delegates
> + * @real_parent:	The real parent domain of the to be initialized MSI domain
> + * @info:		The MSI domain info to initialize
> + *
> + * Return: true on success, false otherwise
> + *
> + * This is the most complex problem of per device MSI domains and the
> + * underlying interrupt domain hierarchy:
> + *
> + * The device domain to be initialized requests the broadest feature set
> + * possible and the underlying domain hierarchy puts restrictions on it.
> + *
> + * That's working perfectly fine for a strict parent->device model, but it
> + * falls apart with a root_parent->real_parent->device chain because the

This language hurt my brain :)

> +bool msi_parent_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
> +				  struct irq_domain *real_parent, struct msi_domain_info *info)

'real_parent' is global IRQ_DOMAIN_FLAG_MSI_PARENT of the dev for
which we are constructing a msi_domain_info to create a child aka
IRQ_DOMAIN_FLAG_MSI_DEVICE?

'domain' is the current step in the hierarchy as we walk up the ops
pointers?

Maybe:

@child_info: The MSI domain info of the IRQ_DOMAIN_FLAG_MSI_DEVICE
             domain to be created
@parent_domain: The IRQ_DOMAIN_FLAG_MSI_PARENT domain for the child to
                be created
@domain: The domain in the hierarchy this op is being called on

And perhaps it would be a bit clearer to put the parent_domain inside
the msi_domain_info, which is basically acting as an argument bundle
for a future allocation call?

Jason
