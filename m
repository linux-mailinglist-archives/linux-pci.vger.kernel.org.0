Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985484ECD56
	for <lists+linux-pci@lfdr.de>; Wed, 30 Mar 2022 21:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbiC3TkY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Mar 2022 15:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbiC3TkW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Mar 2022 15:40:22 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C25636698;
        Wed, 30 Mar 2022 12:38:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2b44kX8LrDnLduOa5EeJXDkplaSJXM3Ied9cZV5r+ytt2oSfw9Jo1Q9NjnlcZQ/28d5v9lgGYK891qaZtCF8MCF30IlFd9ine7Qz/cbap1lI8pIow6ckPdV1oOLc2qOla/p/HlaO9YQ7dP6P05WLWsTYaeRmoDvpT5+NCyCn8J/9XBwkem9lS+kRAaZF/SCZfMoxBu6ySp143bBVpioa6YVgA2Dwyab9NODZshA78vbFJ2E52jwS6zLgS+4nEfQeq+4/x4JXys7fIzaNq9/yhRQHFFxXGQzX/eK/VVETx8YfDRbDFezE5qECHPbw99BCbyEUkxn8PCHhsoCVUGyVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=orXen4+r3YfH13Fw2sWMEi4hypMKE+MoHI6NNb9Fpmo=;
 b=SYoP6KHJLFXMTu/fMwtvHKlCY8qAW4LjgSanZ9v+3huT2GCICl7XwmmU3s+MHWgjKqeIY7PqoaabYWmMhfGzi0SOdt4D3JPVKuQe/wRHiNabCeTnezi434GlFsU0NcPBmW+trFeJyfmBt9Hh71RDXna3kE4vzI0rtCs5imaR7apQfFi25dHFHwbOGaeq9qz0sdGoRJD/nqlimz8URL7yaZygOwnGf/hrfoe7n+2JMi7BTxGn12GC3ox03KSMrbFwFiJ2Y+vOV6A4TK7J7Fx85Ugf1mMkAvA1ykLFH4UdG0cD8xFIzs7x6/KfYpIzTajqbUlQG89+XXuJ+fgs9uFHEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=orXen4+r3YfH13Fw2sWMEi4hypMKE+MoHI6NNb9Fpmo=;
 b=nRvk0ZH5wBzzUnFPdlueAYqKsDjQKjxREOaszxxsoQIbtJTp7Ov55EpbYKu5shon8HczWuHBA0uQYHT/XNOJ21ZALeZ2S8B5skd2kDxtthYIvo1Yu2fcMwgd/PReMXJWcvQcsg2i/y106KlaCtU6g9cd/6k0tvz8ARvqia7YSSHhkxWQ8mj5uzbJnkn1lMpo0RS6+v4CHZ9lQY2Cx6pXfgntzmpKqgMFbybtSfC+rmZR7YUMbiMuzxC70NOYnEE9SHlNA+AqduUxMpDpOo9ZC+vLCwFGvNlZ8B7pM6a8GCGOH7lisy0gMe5FRnrSTurbn9fzuGKjDZpCDi4yy43geQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM6PR12MB3148.namprd12.prod.outlook.com (2603:10b6:5:11c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.22; Wed, 30 Mar
 2022 19:38:34 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c%6]) with mapi id 15.20.5102.027; Wed, 30 Mar 2022
 19:38:34 +0000
Date:   Wed, 30 Mar 2022 16:38:32 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Shlomo Pongratz <shlomopongratz@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrew.maier@eideticom.com, bhelgaas@google.com,
        Shlomo Pongratz <shlomop@pliops.com>
Subject: Re: [PATCH V4 1/1] Intel Sky Lake-E host root ports check.
Message-ID: <20220330193832.GF2120790@nvidia.com>
References: <20220330153720.GF1716663@nvidia.com>
 <20220330191017.GA1700536@bhelgaas>
 <20220330191145.GE2120790@nvidia.com>
 <671cb318-5f4e-4372-d0ef-45be83bdf0b9@deltatee.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <671cb318-5f4e-4372-d0ef-45be83bdf0b9@deltatee.com>
X-ClientProxiedBy: MN2PR07CA0011.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::21) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2159fe5b-c28d-4fc2-5aba-08da1284e0b4
X-MS-TrafficTypeDiagnostic: DM6PR12MB3148:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB31480FE622685353550B26A5C21F9@DM6PR12MB3148.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9alOwSLYmOmBpQs984ZiISOGvfujlpdng48BKmw+kOaSVB83E3wApikdMJ6QuPl1nwmLCdsn0a1l/t+23ZsW008xX4mqSNHpEbiKPKgHDsc+K10wi6i37gqgusN3X6Ha0OutYFtxycbTjgDbXwM7s2whZkJfO6LsUKryZZnfjXa44yXBRdLR34S4L9jAti/5urOVcK293W5swlGx2AfWt4u0PQ/MEQ9t9lmgl7/ZgSwHXhwN3mPkoFE1r9/6bAjLzRhman6iJLaHltW5D1YFYBXpdkJFo+y6UhtQzkHKaUiu5OgqcitZ5E2+9WX3Cw8d0oAeRrR4ch6ZEJJkVRD7Dd3vXRnoAiVedPruylGZEJjknNkjcjTonlWAaWYAwAauyIWtWHLtJCOKcVtNeQVmlhakh9HL7zXk+FRER/0v1jPz52lEjRaD0zgRrMQoCM82Ou8VhQxiMC0MyefjtblDK+0lQS8BrPwd5ku37W0vx7yWK32cpA/ZzrwXcnj+oO2tW1OoUcJeVRNXpKpFihF2NBxmg1zZTO1eylHhUSovcmqLoHnApbFwQtBd2mpZ/ooqiqwCeFJnBfpeE4hSpaNEAONSbp7ERY4ySeRAZr1NQwDf4xc+alLeX8YH2Pu1RJcN3owDjzB/02OiLRUWYLJcSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(66476007)(66946007)(66556008)(83380400001)(2616005)(1076003)(33656002)(4326008)(2906002)(36756003)(508600001)(6486002)(4744005)(26005)(6512007)(6506007)(5660300002)(54906003)(6916009)(186003)(86362001)(316002)(8936002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ms8JsAHo1mbCZGsQf1A+hroUTGLn94iGTUzTPEHTvNPCXGy0B32G/pP3Uy2M?=
 =?us-ascii?Q?hGfp0cFT7hwpaJeIyWpflKZnKSxZociyRI60tIMDuGp7vc28txm9NkH1QE8n?=
 =?us-ascii?Q?CaTXzL9UkcrFgySbV90wrHa7TrQ6Nuh0BZTN0p5hi/HniYqvdoWRkJ8znOVK?=
 =?us-ascii?Q?mUTKTBo1jJN0zLR2Rnggq4Tu57UcnwEt20NKVRuJUkuVk4iY5f89pM1rpemn?=
 =?us-ascii?Q?tbsl9vKzQgOtvHWDSf1KE5P2tqJh9aX6RZ3l9prXUJRhhkOg0iclHjjjPP+n?=
 =?us-ascii?Q?QEVLbxX1TnonPcnwt3cSePL+Bu1eYsZ8MHgN19xnu4No+/s2vXNdhZfv8wRB?=
 =?us-ascii?Q?JmM6okL3qpRgIrXOILMfRmxZVsJt1k4mVz0ndHift+o34IRsnyx4pIO8qecs?=
 =?us-ascii?Q?cR92uUe/8Amoom1Rmc8w06Kw8M0sT9psuegOIFpmMcV9irre3obzxiJc0GPE?=
 =?us-ascii?Q?s7BL8Zljvqk8bJe3/Br4vHMCTsCg+TYKOeDcOgI9XlYFBm0cJDFt/pEXdhE2?=
 =?us-ascii?Q?PIs0VOsKnlcVgYG34T8utKUswg5xxw1K+xDpC1Kk270L0bJrcf0Kb3iKHxdK?=
 =?us-ascii?Q?R0A5RpCxRFaUM0UfGJcUCCWxW0aMq1BuTmCQU+Cac9JWRmAhs0tsag1ntd6i?=
 =?us-ascii?Q?wj3NHhmEicj9A3T1/xrwrOczIrrorrN8bekCSMK2MWSAH00wumKld1KN5G84?=
 =?us-ascii?Q?QdlvKMrWUzSwV329hGPZhtAGNEVjTJkqbL8w0AeR/UV9oTnl5Zqc4S3Oq2Tk?=
 =?us-ascii?Q?nZChZfbBKBPgKKhPvm0SQoEWawqSLZIkRGM0Y5vcqs64aU1dZq4qQch0cr9r?=
 =?us-ascii?Q?7IzMvUaM9qGYa/zIsuZ4uhrCA49iPEyoC0uoq3XQHq98MqNL5L34IZ0KaZII?=
 =?us-ascii?Q?UHFbhPCtf1Y/iTMFytd3OLUFu2R5PwQiyH5WgYdsglpGLkjRygXZwGH8aDk4?=
 =?us-ascii?Q?ha0N/GYUZw18H8k9d/ozSaudYoYunJSK/aCxeR8xLtA6+8JORnP30/rOrjpR?=
 =?us-ascii?Q?+gnACGVKImWZTWaakNSnwYwVFtnHglt3vjtvGj92mqsXMncbKKI/lnIucCt+?=
 =?us-ascii?Q?RovHnUPXd8r8x37gkfe0Dy1sRLlDIKSsrzGcNLPDbNNp9JkuhJgR7pX5CM07?=
 =?us-ascii?Q?88KOgUOCNFui8VYfRulN9pzxqZ9YPSlie5ECwHMCpaoRMerYhy1FP7tmylBc?=
 =?us-ascii?Q?r+7OmtasijpBjV93smy6oaklOXQgZXuG+xzVaX43oetHeh0ge7YN6p6zw8pa?=
 =?us-ascii?Q?8Yj/lg+UIpjzcGkOJY0BMBL4SnikXeybW/JZSfiDG2oAF+616dDnfB6klJWX?=
 =?us-ascii?Q?lwJKNkmiBIw7kuLOpEoGyJTuIxrkoIc9oDKWJHPLwHtCewYdGvtqmWyBHU3W?=
 =?us-ascii?Q?mRcJP0BI1NmeBp/lArP3SOwyqnuhOXxQBIPqgK5VI2LpYqS11NrAKWFNGECj?=
 =?us-ascii?Q?r8XUrG3b5kR3Xpe+20fyE8IApbZsi0RYSmy1Qb5+CpZ1oEzrSHmPeScz/dCl?=
 =?us-ascii?Q?ZzonmqNAYhWwCVo/bJZYhKEuHixUrzAAfP/wK6zXjYW239FhwB89k7BdFXEn?=
 =?us-ascii?Q?NFbG7+2KtJ+3R/PVJIHJwI5IAaCVlH9ct/dp1E+cp8gfJLKAcAh0cGnDA+hI?=
 =?us-ascii?Q?vU3qggCP8J4qfU+mFuGOCBojNG6MhaBexg8dxDVSYzBGs0mS0jsfAvFU9Q9l?=
 =?us-ascii?Q?3QIB3elKKZdtvBXaNf7Iy6+OzCZ4L4nMZC0AavdTvifCLg1MrInrJjUf0gRV?=
 =?us-ascii?Q?NS4eMHrW8Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2159fe5b-c28d-4fc2-5aba-08da1284e0b4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 19:38:34.3589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SXHP3+TG/Uz+EtLXjIUO4DPk0FCOWAix+s3yMZk3UMcBvoe+PU5cUsEam7I0bd0m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3148
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 30, 2022 at 01:36:25PM -0600, Logan Gunthorpe wrote:

> Checking simply for PCI_EXP_TYPE_ROOT_PORT instead of a zero devfn is
> probably a good idea, assuming it works for all existing systems. I'd
> expect it would be set for all the devices currently allowed.

I think if we find a PCI ID in the white list as we go up the PCI
hierarchy we should just declare success?

Does it matter if it is the top of the tree or if it is a root port or
host bridge? The IDs in this list only exist as part of SOCs, so
seeing them at all should confirm the whole SOC..

Jason
