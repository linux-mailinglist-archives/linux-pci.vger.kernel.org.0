Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C1C62C94D
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 20:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233852AbiKPTyc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 14:54:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbiKPTyb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 14:54:31 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E2E61769;
        Wed, 16 Nov 2022 11:54:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IPhovM9GvDDIG+iRhUcPAmhSzo74+skNiUMrAM+g/19+N29Uu5EFHwYwbGTiQePeoM7wZGZxadxq4uXxizb8vr+RZclmJ+C9dpibAYaiKhKAenC7fwy631ylCIsq8bh6i5YqH7KzvLnmPmkqKdB1TsdRTCnU03h7taxQ4nUSxcM0XJGc8y8c/uv0p+NmGUZJ1ukePiVP5kiG9G/mA+hvLLn2wyKXHDyLix8qMBKmUQ1Jt3smCrUcmCwFtYmU75SD7BUStfraJV0CcLm7Bi25hEgN8P0IZQrmhnX7Zu8Z2ojy33/9rc9HCZsTo57PO4XFwV1o/lY2CXq2oHGLEDOgtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tzqmjcRguA27rrLeP1FHEd/VSEVE3ewQ41jhOfAjhXA=;
 b=E5t949qkfrCWSKEt9zNsp6J7T/YyTPiBFhiloEW9BId9zPY71os4eN5TTCjT0wmpAD4NJoxmNcV1HjLF0C/d1SfUzPScgIIXNBw7X/rH9SIuGrq4PfsIuIMhSIa4TP5U6CE5aa8eR+8e48Znf6XZgWeA2XTmPxnxvMyTLNMNFJg5cH71GsTV3TBdwN1aI7mNE+U3gC1+q1gofIuvuTSFokZCtaMAY4coct0hsvVgtK8zgcfsch8D+gLYie9cGq8Ypp+9OjmVDAIo7IbQVCCWNVaHb6u1iD3nSatAmVAggEtQBIJyoicm031/DasenB4qsHXpQpG8JnYJZY2DDdP26A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tzqmjcRguA27rrLeP1FHEd/VSEVE3ewQ41jhOfAjhXA=;
 b=XJXDdcEuvhCc/xhTnRX924vB1+7f51V1QI4Rw1F9/lnK6D9Dhf7lRdpwBpkTca4NecffK5/jxo+34u6FYol+nHlcWZDdxODdRIUOgQWBX11XaG27HmPOvD6gLYSAX7aVe8Mh+4ovhPS4bkI0ukg4M33l6K7yfrSLRsnTiaKa324S93YhxM1b6Pts6jeU58tSq/ZACEPNdNHeSgzvZ8+YTUR/O0H7oGSvvmnTxfSSaLf2YivCsDa+lsVKgBjSwuSJ9mkRVKjxJYgCDEygFAIHkODmFmRPwU8HYvukTW/JGXBMhvr6zUIoxO3Cbqcl7OhfPebVdIgjRnOR8dy0v8M22Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL1PR12MB5335.namprd12.prod.outlook.com (2603:10b6:208:317::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Wed, 16 Nov
 2022 19:54:28 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 19:54:28 +0000
Date:   Wed, 16 Nov 2022 15:54:27 -0400
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
Subject: Re: [patch 27/33] genirq/msi: Provide constants for PCI/IMS support
Message-ID: <Y3U/8/0p66cG4tjk@nvidia.com>
References: <20221111133158.196269823@linutronix.de>
 <20221111135206.800062166@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111135206.800062166@linutronix.de>
X-ClientProxiedBy: MN2PR13CA0009.namprd13.prod.outlook.com
 (2603:10b6:208:160::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL1PR12MB5335:EE_
X-MS-Office365-Filtering-Correlation-Id: ca0362bf-f5b1-45cd-c97f-08dac80c5f01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pl0lNkM6vstBfoda6uV2H17blh3VhVkc+8lQC6HvR5Fu8MgihXVttIXd8dhDNrp5kShFlSqZ/Ot3ty2uXNe2Vue4bJVShQCQW6ZOlzv89oFdBTHYpLVo+Gs3yKl53SQFmUKHHDfRNZyNRMmppAZuoklcmhVcIYMxAEPrsX1CiEKf/bS0WDqv+9UGCceFF+ifw63e2KR3cwY8BXnpVPblK7LKmiuseZcOdldTVO8FNxFWhURFdpvsZRbPBJ6HQtYPSpkS+pSU7T10IKpOBJCdMaj97yUnSlUxwrR7Y4KT/g+tPvE2kuc0M72X21uu9NSZWASrCF1v9EMXuv5+8bkp3imC7RTCvQqTchASPVhpfQWfUHXMFTanyyfQtjOGAnRqp9wB7ke9ZNBr740r4B+PTosYSlr39aK1ik2vTjZCSIK59vDokQgZD7C6I8/F8z8Iw+sgMpVgyJidANszYGyiRNZnfetf5RDhNIbbZ5Urc7/BcCiAU10h/yn7pGsUYyrHSYBQqx2nvva+AaZThjM65f523CsnxkAfgAnevwRgq7B+Vq8gZKrHLahNFdQBqrrluduU5AVBaeYsJq6wXtRJ1SFL4f2anHZc3ZP2D9JZDLROtrrxpjZXj/7pAfk2ZjEPrgWK4pOBqnBv69PDKlj5U7z6JsNTnh3jVZP3GUa3kkIxKy5TbU1DGh4hJ3ZOpfJGoCFy6Q69Yf2aseo0hnlDYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(366004)(39860400002)(136003)(396003)(451199015)(6916009)(478600001)(36756003)(8936002)(7416002)(5660300002)(83380400001)(6486002)(38100700002)(86362001)(186003)(6506007)(26005)(6512007)(316002)(54906003)(2906002)(2616005)(66476007)(8676002)(41300700001)(66946007)(66556008)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Nkb8/foDsU0qWpLEDwfB5gTAIQtkKJ6bYpryqDE2XWBbbG1bK7G53npLr82I?=
 =?us-ascii?Q?K1DoViFw+eLz2bruMOk92iEorHBGS0PU4tfBpkjS4NKRJCb3OG3AI7JX63hd?=
 =?us-ascii?Q?8aADTeZHaVA81O/kfY4a9NslmIGPazIFtUlkRRsCh0ol2L9UINqCtfnIofoE?=
 =?us-ascii?Q?Tq3J4tVl0hhgR8Q2zwm4xWp8fVZPjagD9fUzX9n3mtOT9Rs9VSQw4Tg/Gu9U?=
 =?us-ascii?Q?zZmcmoqQEZh1vOoXUx5vpAtAqLgg++VUdpjS5jIY7ex2gCfhCRu+maSbgxcC?=
 =?us-ascii?Q?y+SV/1sjDgVMg2dK/y/+oINFrtWCSIFGurVlzUiKz50j8ttbYYz/QNx67JP6?=
 =?us-ascii?Q?FQrf0hzWqz9Ee0KXrDQ2GN42BtcvcFaXfzixxI8ZrSZGJ28yGM5CqXY0adrR?=
 =?us-ascii?Q?kIvGv987nL5Ysq2rKYHxQM41REeQUmuwgkdeCQfUT7V1xTiZDQiUNEtP31fy?=
 =?us-ascii?Q?7S/3tGXuG8nv0QQZVxF/NA8WfiyTIy214yztaY2/R6VDs82sn2RAI2fB6qKK?=
 =?us-ascii?Q?bci6tVWnOg6Rx51U6LQ3JaM3u3azt3YUpNvXjwtAYQeHkQP+SakvErVljcFC?=
 =?us-ascii?Q?l4hfLMb9RYxv9wtsFMLqFq7IlqOqhXDo3IqpqJ6gtOLOQ2iL+W55/ErqK7W4?=
 =?us-ascii?Q?3OJg1mHU5K7xXq+CPeiOqwQqQ4dnjBE4VwGO/zFSY8eqRp8mRLxTXqsEW+vU?=
 =?us-ascii?Q?OmqhInyhyg4OifMJTno5rzPf2DVulQdpIeGASnYYIlZD6GrAIvgLhO49kZPX?=
 =?us-ascii?Q?GOmE/ENcb0yW7OI/huljDOe/lYwC5dVwWl5QQchIV/fmzqoenq9jjJBTPJp5?=
 =?us-ascii?Q?ucCyaN8b8X2SKvYxUh0FtN49VSel0P54ArVncbD2t0S6A4PlkeA7Jbl5rE8/?=
 =?us-ascii?Q?ODbP0SwD8Z1DeDtfM4ddiLFYDjdNL6A4LrPgJL2fHuL52Ph0bpTOSPhymoSe?=
 =?us-ascii?Q?nZaT1xITHlxTklZb+j9aG1ck4TxT2XQQiGbjkSeYTsRAjmCrOQ1gujpWgsKt?=
 =?us-ascii?Q?GotOrFfkoJtDe1kdFl91U1OStCguqXghnirft1iQouICKWkieXF9UWdUBlDm?=
 =?us-ascii?Q?xvy7765nxFaYgcrRnUtk6X3g6iw1nPpM4Km6rMi4trScsRl9qiJkJPNBj0GM?=
 =?us-ascii?Q?Jkw6D9rodFGKpmiGvJZ3xFECYvWao5rP9GZfB5qMRZuo891ZFlsdxGxKwOt+?=
 =?us-ascii?Q?cr8nf9UtQtRusxYxoD430r+MYGh5JdfUjEXOUZgyBO3CpEmdsn10f4WO/dV+?=
 =?us-ascii?Q?TzfpyXBfQKC7+wpRk4bdoSDRGb0SBXcijs/cQ6xTpNrXDfO95cc1IMovA39z?=
 =?us-ascii?Q?6rOI8aYf5aOn9RLUwqXHFm47F4nIzixyV/8R7xG+q88WpdrA2CEN8qb5olpn?=
 =?us-ascii?Q?XAA2eE/DFKTD6yPbE/cPed84972K2Q8PLhD9K6A3AvCWQaBZm/egl/qTH+N2?=
 =?us-ascii?Q?t+0NFnNBH6kXBUqjFTYSM+t+KS6xl+gZpefS9ifQV+iaTB5cJAfX8pOsEYDN?=
 =?us-ascii?Q?zUd4FTAU3SOc8Yf2SwufuO830DpGChwnzlPdAQvMtWWDftW8T5BLbPNdHd5W?=
 =?us-ascii?Q?1dUroLgaFcfk+1eeo8Dho3uysaH7gl34a1Mcqowj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca0362bf-f5b1-45cd-c97f-08dac80c5f01
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 19:54:28.8117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ahw8xQnmPHhEExGyd1gjG3sXbLfDrRvN2gMuhD/ELPrZJ0al8gNN29qr+2Tqdeef
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5335
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 11, 2022 at 02:58:54PM +0100, Thomas Gleixner wrote:
> Provide the necessary constants for PCI/IMS support:
> 
>   - A new bus token for MSI irqdomain identification
>   - A MSI feature flag for the MSI irqdomains to signal support
>   - A secondary domain id
> 
> The latter expands the device internal domain pointer storage array from 1
> to 2 entries. That extra pointer is mostly unused today, but the
> alternative solutions would not be free either and would introduce more
> complexity all over the place. Trade the 8bytes for simplicity.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  include/linux/irqdomain_defs.h |    1 +
>  include/linux/msi.h            |    2 ++
>  include/linux/msi_api.h        |    1 +
>  3 files changed, 4 insertions(+)
> 
> --- a/include/linux/irqdomain_defs.h
> +++ b/include/linux/irqdomain_defs.h
> @@ -25,6 +25,7 @@ enum irq_domain_bus_token {
>  	DOMAIN_BUS_PCI_DEVICE_MSIX,
>  	DOMAIN_BUS_DMAR,
>  	DOMAIN_BUS_AMDVI,
> +	DOMAIN_BUS_PCI_DEVICE_IMS,

I don't think we should call this IMS.. GENERIC maybe?

Things that can support IMS should really, IMHO, just not check for
PCI MSI/MSIX and effectively support everything. They don't override
the write_msg, and they don't care how the message is programmed.

> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -525,6 +525,8 @@ enum {
>  	MSI_FLAG_MSIX_CONTIGUOUS	= (1 << 19),
>  	/* PCI/MSI-X vectors can be dynamically allocated/freed post MSI-X enable */
>  	MSI_FLAG_PCI_MSIX_ALLOC_DYN	= (1 << 20),
> +	/* Support for PCI/IMS */
> +	MSI_FLAG_PCI_IMS		= (1 << 21),

Maybe for legacy reasons it is too complicated, but it would be so
much clearer of the special case of "I only know how to support PCI
MSI and PCI MSI-X" was called out as a special flag, and the more
general case of "any write_msg is fine by me" was left behind.

I feel like when the device domain is created in the first place the
parent domain(s) should be able to reject the creation if the
requested child domain is not one it supports. Eg the hypervisor
interactions checks if the child domain is PCI MSI or PCI MSI-X and
rejects otherwise, because that is the only thing the hypervisor knows
how to work with.

If we did that perhaps we don't even need a flag or further checks?

Jason
