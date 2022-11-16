Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB9C62C6DE
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 18:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbiKPRwJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 12:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238806AbiKPRv6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 12:51:58 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6374460E9E;
        Wed, 16 Nov 2022 09:51:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oLJDZkCRT03wK/kgoKMvXC+ck2ChfQ7qD4rngKDFQAhmI3SHKzXi5bmvb8xBflCoKlTlLyr7jpkA5Pb3/JARk8AHB66egXOqIBd1Q+cyHG5uAnGl6YsTA5FynmK37ngN71aFdVONzvcH910DxOnnUStSKjP2enNb+vXKpr573xdlURwWwLjB5a2Uqcc7U82Tn6iFjhusaLgzbV4GUoPmPGpJA2d/xr6rwzn/AY5Ey6yfuVdKTGKCgcgUiVtqDjVDrIXRWKbsmkfD+9CK+G/cpxK7hm3oUt3qlQLMp+q+f7hVJjOZohPE5DL0GPApPguJrAljkroJrFZYLpWG0P/UZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TYiZSItDZmYlVEqzkkiUM9/BL48JRsHg4btGRFJd0io=;
 b=jtMp8Cf1fwlS1jcScWiCdTc4RjUG9BVpJl3JDAnvOLjjQYbEv1nkeM5FdnKqHXTxQg4+5Ez6LXBuTQgsqyHgYnCG0xwMpRf/akn1SBna7R+Ybuag9+oZ+yR+5E0pEh8j3mE9XaDCCxRVI54/k3P10I1JaqQm/mqTDwAuyKD++VeinEY6RLXtEDgXWr2TH9//m4xtPB2NlTwKTuwWw9P43V2jGElYB0wUK4a/GIBoz+Fr15dVsfsv3592ZQ5aW8mK/OK6iDlKWs+9hDXHURwvyFKMG/nBgWorMGQactqNqRzFu7MPcrmj3Ij5H5bHHr8PtEemIk+n7y6Khz9LW+gufw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TYiZSItDZmYlVEqzkkiUM9/BL48JRsHg4btGRFJd0io=;
 b=Hr8D9tFkvOK9Qxynh18pcjUG4NQEuQH4Tm3BYNvo4iqcp8+Be0BX+hlQi+2ZeDpAeJBzanUTcRS6UECuZH3F65lQ0G6pqiJCy/0AA42lhUBRJjjaVSkDpjeP/pXNy+Q29ToAjujXoyC0LYP5LGoV3V5Fa1KOVgk995Bbwp5A2cuCErmELwPL4DxnZf7Qs8f15uERuAYhG4AJly6xxyQ37hV2BbYvEobvIQahh7/VSqGZNkeKnsk+gWvUvLOdMpd3+GwdBtVbv7x6IuHmDc/8sMAJENvkfdOkRGLlYSMqlyUngadQ+Y6HSzvIqLj8I000LZxNC/rJ/tiR1c1Z8sFXfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB8145.namprd12.prod.outlook.com (2603:10b6:806:350::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Wed, 16 Nov
 2022 17:51:55 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 17:51:55 +0000
Date:   Wed, 16 Nov 2022 13:51:53 -0400
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
        Reinette Chatre <reinette.chatre@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [patch 13/39] PCI/MSI: Use msi_domain_info::bus_token
Message-ID: <Y3UjOc2XhwYSVVP1@nvidia.com>
References: <20221111120501.026511281@linutronix.de>
 <20221111122014.352437595@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111122014.352437595@linutronix.de>
X-ClientProxiedBy: YT1PR01CA0149.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::28) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB8145:EE_
X-MS-Office365-Filtering-Correlation-Id: 978a40cc-b82b-492f-a53d-08dac7fb3fdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +3MFoQvRujZ4lGKWaE0p+SKt1Wbto97otYBAyNxQnIK8HWKOOl9jaPVK9KREkSX409yF7aMMg5C3Gnsppjq9Wy4Tw9GkGv7Kvx7lB8Ul/NgrpAzaB21+AI5kdEya4MsPTa0bA8sxNi+CSwWKg4OS8sIJLDwFum+46ZdBCZhCclkdZWw8vG+8i9ot/CO3JTn1wm+/r+kiCSwjsjS8V08R0+KqZE/tN9I/JhoYsRBxWhXPHAa/GyXc/ldPTYtJ9t9FbXj+fGydJRJAoDeHXRZOT1euFVSfGHaE8BZ9ZiYKRZu8xINS2ZU/b3LdREj/oWyP7SC2FpKkiqNDgUwxk6cVbYDC8KRTUBauiGf1+YxvM2toehs1XNNXG20M9dZvNDGOy4ENQeIhQ2bR5MTnJHlFw6DGuSz34RRgrEdCFAahashXBkMrJ64FE01cNgjNCaWj2F87ZcCwSV+tNXti2lTqrsOrDPg0qhYI5dyseXPGfIavfThBhBHcO/OymE8m+KdPbhxQhm/Q7VBHIoN02DFyZybICQlgFtBTypCNAB0/MHNAw3odvTLGH/G6P2pUCxubTeC340uxRhdSoaBlMSAFIc4qWiguKBNtGdGRl7kiGI9ZNBnqv4U9FkJbrVptyBAHHGtxIjieOei+ZD9iduacCUE3UoHKofVhMMOa03gPw2nbh6h9f3T+7X0xZxKIBxhDTiRxDP7WqUuP3J0Ai1HqGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(376002)(366004)(136003)(39860400002)(451199015)(5660300002)(7416002)(41300700001)(2906002)(6486002)(66556008)(8676002)(66476007)(66946007)(316002)(4326008)(54906003)(6916009)(6506007)(86362001)(2616005)(6512007)(83380400001)(478600001)(186003)(26005)(8936002)(38100700002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MXMHJWzKTiQQBbWhqZypixbdW3TgpFj7lZwGaIy2dX6QSb60+OnYzUfSrHVD?=
 =?us-ascii?Q?MTdmkfxDmzHrcjgYb5dQv0HsuwaYvWLVZ+jBwKW1ocoC24qKSVbdn4U/Xo3+?=
 =?us-ascii?Q?rdYuFxluLr2zeTjxNj/LV7Sz8Sya6DBZRsHPQuEjedZHQfN040GqAhlc4YaS?=
 =?us-ascii?Q?r849OLvxQFFzvsu0alrDP1/HV2J2EKyrcQOGBA/+UAWd2XOWT6y4lBN5eJiY?=
 =?us-ascii?Q?5sDLI2pwhk5Opfp5f5SXU/ySHA4PaAyi6OHQoWi6B6r0mmfIq428asxEl93g?=
 =?us-ascii?Q?y26qAuqL1mMkFpK56ezvL6sOnrloYEbkezGm2LDcVqO8oqC+oqGDucNNIBES?=
 =?us-ascii?Q?THzxCjk4lhilYTZWY87TG1FQUVcoIoeM/epKHzMznDi4Fk9q2R8HqhMXUy4y?=
 =?us-ascii?Q?HDnqtqkvGk+AZcNb9xXPtnrnja/KwHhtcjKJbWlsQFlNR6CmTnOLHwF6OHv3?=
 =?us-ascii?Q?q8s/3wo04h6p+qC2An4oihFRtDkq4FyR1NI8ZraDhrzgIljZyVdlTjFNcHXs?=
 =?us-ascii?Q?2kqFBhi/+WTKnqSmfACdYeaUBxoh51DURbQJrKCiLrRVG9uOCBq1tiH1oAnf?=
 =?us-ascii?Q?PPW/t11VqyFvsl0dFk6h+8cz/P8MoamfGtx+5r+QzzTM2JUJL2kKZRp2KelA?=
 =?us-ascii?Q?N0S9Kuh1MY5/RrT5+c6uEZbRjsYobhhonhgjBOrIyou49fErZFkqgunPTUN2?=
 =?us-ascii?Q?hrEY+bpTPv9iz6T6CGoEK8d60n8L/0VPn83Uk+v+CAXIFPk+RwZtGjdQaZPv?=
 =?us-ascii?Q?OmgyYtirn13EJVGaFUOdoY6umS8dj6FZdK5NrJqIPCAiE1zJ79+XAU5piHrn?=
 =?us-ascii?Q?Q5E6B0MaZhcVRNfeeFZEc5/aKISlaH0xovEKa93Cb+p2HUI0fB7mA8ZSAcPb?=
 =?us-ascii?Q?FAvLSqZLiVpVWj76bWegZCz+GGkBnU4ZHAqSu7zmZ2DA/t5Bj61xlUGat1MA?=
 =?us-ascii?Q?4ZdNvWijgNbFRB78xdV55usk6VaMWFpZG7YWYow14YUJIq+zfzHFGabJLS8q?=
 =?us-ascii?Q?BRtI/DEor3TcqcuZxw/cLRiMktUNDp1Z2kNpg9T60RCez+djPxhRdiFALYeW?=
 =?us-ascii?Q?H78fTibMBb6XpDZU7goaOsp91so0biK/FBoGoaP5IZmQSzkPqbcfKDLzDLtm?=
 =?us-ascii?Q?Kc7rSpTXVpL9fiHAPSPcj7SKNk+u40EW3NMf3gPR9mDEN6drvkrLB0EC84x3?=
 =?us-ascii?Q?VyCvOtiN3feKqu0IXprFiCGY/9i3Ly+CiIODMXErH6/8LElA2GKsPHcqBkvQ?=
 =?us-ascii?Q?LOu9vOvXTA74Zzv9/STYQKa+G6CEMVUCdDEF1qu6RoRObxpZ2Tk58ugnSue1?=
 =?us-ascii?Q?UqBkNg7RTLh6LK018Smw2XmNvDfo/I2cmMzb68SWNjH5qwTioUAntAJ0lhoe?=
 =?us-ascii?Q?MBxF3LswSeURp/h8qX/YHhX19YtDKcXWMfKClpesTX1Z0HPJ40i1LPEBAwwJ?=
 =?us-ascii?Q?KHZOy+OBoq9TuOsaBhheS9QcjpXTWJy+WMpwKuU5SSLi4QFR6f7zlEr1PH9K?=
 =?us-ascii?Q?syXODUoRWXeTCEMv4kiLYB9CYVvaGJcHMk/lxNHzdUkpEI6aOlhqyEtTvc4+?=
 =?us-ascii?Q?GP0aSSBjrUEb3l1wt1QMjJ/2BNRhNGMuLj/x8zvw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 978a40cc-b82b-492f-a53d-08dac7fb3fdc
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 17:51:55.0833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sg3qSSctkzxuZN+RBe5ga3zmmucL5g4xD/SETlCldQEqIIj5vqJb1/0suqtNJsvt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8145
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 11, 2022 at 02:54:35PM +0100, Thomas Gleixner wrote:
> From: Ahmed S. Darwish <darwi@linutronix.de>
> 
> Set the bus token in the msi_domain_info structure and let the core code
> handle the update.
> 
> Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  drivers/pci/msi/irqdomain.c |   11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> --- a/drivers/pci/msi/irqdomain.c
> +++ b/drivers/pci/msi/irqdomain.c
> @@ -162,8 +162,6 @@ struct irq_domain *pci_msi_create_irq_do
>  					     struct msi_domain_info *info,
>  					     struct irq_domain *parent)
>  {
> -	struct irq_domain *domain;
> -
>  	if (WARN_ON(info->flags & MSI_FLAG_LEVEL_CAPABLE))
>  		info->flags &= ~MSI_FLAG_LEVEL_CAPABLE;
>  
> @@ -178,13 +176,10 @@ struct irq_domain *pci_msi_create_irq_do
>  
>  	/* PCI-MSI is oneshot-safe */
>  	info->chip->flags |= IRQCHIP_ONESHOT_SAFE;
> +	/* Let the core update the bus token */
> +	info->bus_token = DOMAIN_BUS_PCI_MSI;

comment seems a bit obvious

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Should the callers be updated to set this in their "struct
msi_domain_info" ?

Jason
