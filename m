Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCB362C6FE
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 18:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbiKPR5q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 12:57:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239021AbiKPR5a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 12:57:30 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E186F623BE;
        Wed, 16 Nov 2022 09:57:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y10kSdptDAZrEjlpzlkYJUIgomh2pEJ6poErjwTItPxeXxUB1iPtJejTFLTeE8Mtj38ZFdC4B4nVHtz1RHFtk1b1hl5FQmYPkyaDNbmvKi1MTSycjxgkQ04GurqYOsd3hhJkha9kJ5D6OpGUOcV9wBzmGG4Y1nU+k5fibRBkjmuyMV3M4rKwWElt7Q51GNO9aaKzY38bb8HdQF9Ju8ABARzcC5hwF6RUd1FBaidPLhxrqT4lIDHpCxdQBlA8j+RZ0pP4OxEdk72FF2Pt+YpxRwyIweOGZTmpBmBMIg1gL674Cb7PuAkMI64PIlXMCaS2zmlg9ugiINzEdg/LcWY6yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uzExPrmA6tmDc9VCsoh1Y4FTO3aAwq40x6WU3t6g5HQ=;
 b=f+bn0E75HDgcxMDEFUGgeCw/4ZMWNBQ92CdvIlF8de4Efavk1ImepYgbY7A33jhcp9MppwQOqllXTjXmCvHx5ADL1/1LsJI0/65RiWntAIcb++a2ekwWCFmQXyXPmCW83doUIqFw3T08Eqt1im34swNo4hmGfxiuM2uvPt9A4cOykAV5lsru2mWrwA7zA+RZD3+nGnc0lQFagx+5NFreBUeTIZ+DNJYRD1fzrdvcf7lAKCLTmfISy7vev3UdniCyT0mRo4AnKvD8/8XVXq8NdORtDiVQ0AKqPXGxq5l8d/8I40NHmro4eKdG1WkRc3A+4uCReyUBPbu6Iwg/HfvFWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uzExPrmA6tmDc9VCsoh1Y4FTO3aAwq40x6WU3t6g5HQ=;
 b=CG22D06lMPVvp+N3IuZFTbqS2LYh/zMAfVCprL8xGli71S1rAYWfAdHTTVCTHgc7HeO9zwYli1vPOptHezi/0Bw71OK99QUcBPXd/7jy/EsWphPF0V3JmEpzsDLdxd2tFCEb7We/8jG0w9I6QWz7hyxRQLwR1bGSbn8rloE+51orBnKrdxexLbObM35C4f2VpoX6bP48F95BdzQkPeU5+I22SwUdca/Nxi6BlmH9+Ww+ZQs8KoL2OSevEd8CdDFD9RBh7bMcQKQfREaRgFVpZv8JXOJ3czXJLBFnB+R+Ac6uVqy4UkKMgFLHpjc390Bm/nISnlUpaoCqkBIHUV5Q7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS7PR12MB6024.namprd12.prod.outlook.com (2603:10b6:8:84::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Wed, 16 Nov
 2022 17:57:27 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 17:57:27 +0000
Date:   Wed, 16 Nov 2022 13:57:25 -0400
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
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [patch 33/39] PCI/MSI: Sanitize MSI-X checks
Message-ID: <Y3UkhR1a4K0tZe6O@nvidia.com>
References: <20221111120501.026511281@linutronix.de>
 <20221111122015.516946468@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111122015.516946468@linutronix.de>
X-ClientProxiedBy: YT3PR01CA0032.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::31) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS7PR12MB6024:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e82a1af-094a-4e8d-5226-08dac7fc05ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OIiH29wRW4SgYrv0Vwz9neWaiD00PIa8SqBEw2j2Ekb7yrHpbnpuLv5VR/8RBqXg923gJmMmwqBpXB77qmhyGqGHd63X/AONsbANb03qwI7m/ucqYpJYMIzZxO2NHkR1gEPxJNQRwgNR+sB9ffvVWDUk6C4Dc6P5znCOjjhFAeuniCPt3nGPjVcWxLEsWmBK6DF8tiSEdKWEE0TwCQSqLRVOTXb85zRdYhXTbN5H/yJJWkeLZK5FndxrA+XW9o8hWG6ZwjA0dgZvN+uOm18xUJwNPziLZncLv87HDaQor9viS/AGb+GaFLY9r3/idRbpgADN1ERZzkiMbwIfodJtGNnYGz0elZmkaFI1DuR7hASpscjdzZnGKYvSaQ23v5juxGrNFP6ce85D5bLihJmeXKf5IN+PnOi/OUOUHkrhJvuObK2uOdbJox/ghvcLZxo3pfHFYmAjMTsJHdFNdx0oZirjeXXb3yVrqTlm3ggpSQgI+E47uIngRflPgi6++DLrfnte0/dtz6r2AEkWYzBZPlI3RvXCSltK8fgKgwy3PnzKm8/g2KjtT7OaZH3iDkRLwyDnFkFRKJ4HCBPcxfBCQCQFEaJQcD6J/I2F74Fb5sEsmtWlSRe4bKtqGauji05XTVYIG9Kj94MHzmM3EMKqXmyz29bKOtjX5E2vXjz/nRNi6rPrYPDj2npxWMRIV1YbVL7XDCXpqIBfHzvWttQMpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(346002)(366004)(136003)(451199015)(83380400001)(86362001)(38100700002)(4744005)(2906002)(41300700001)(5660300002)(7416002)(8936002)(6506007)(2616005)(478600001)(6512007)(26005)(186003)(66946007)(66476007)(66556008)(8676002)(316002)(4326008)(6486002)(6916009)(54906003)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LXVkSsxsXawRQDOhcdoFSuFtEB0StFwHWRacci+8/Yukax0xQIUPTQQqNE/j?=
 =?us-ascii?Q?iFhD6wjSa6PfXOZQth8RLl5b78BGLGn6h8SKsYsXrNGaVdFmGaJlVChZIbq+?=
 =?us-ascii?Q?LQ/8HY1S/vwvNuF7PuNYdWEzDrlusJRiwwGisOk2DdPbPhw5ET6sobUKkbXr?=
 =?us-ascii?Q?oRrEs6l0LEyV0RB1U/KZewrTrhMP/nIq8Des6PQ0EngjqoK68TkPX02qgo2r?=
 =?us-ascii?Q?HmESuJDcbivozH+9e84uLCM+82u+MdWSg2G7OTHWq82701lbAfjiukA0bN4S?=
 =?us-ascii?Q?FJ1eO2hmGn7UEo8gRS5XmMdLjO3Syr13WKpM3E1npK8e8eRILi2DE/lNCl73?=
 =?us-ascii?Q?XinzBH2y5swx8WCc3wadE15K6sL5yZRP7Jxg8PHHt6rZLeF9rpg3phH3K4dy?=
 =?us-ascii?Q?9HlVZQCYhRH4OOU4NU7PoOZAcCbqWTfwDWNwIS2gSOACWdE3RPIdWuMxrTWB?=
 =?us-ascii?Q?h7EkKo/ccQ6BiyOwvMRY0gH05hJDUMbpiQtw2+4Db6gI0tRleadReYsWyqWt?=
 =?us-ascii?Q?PRqfSq95n+5DWbf/nL0tOdFg8SFy6vEXdfVE7cQNVWan7vD7/mFi9+28QIhj?=
 =?us-ascii?Q?uTpjGGfjUBElOWXxUr4Vy90+aI7UcWcU8htvE5gRxwk4XCxvQMybNnzXLC+K?=
 =?us-ascii?Q?5cgq8dnhmZ5ySCVGAf8tNRlgjxI5y1vXHO06KeBkzE17r5nK+A+PuaEPjmyQ?=
 =?us-ascii?Q?t4BYELrrbgim51P+whFnWRcP/3EhFbEWLKDSOdq7TMzkPkYrC6Lv0+UlY4bb?=
 =?us-ascii?Q?kkIdG1HXrVXklRx98xLAIs1gELP+SE37eN96kZQt95SaGteTSQysoQ4h0rm5?=
 =?us-ascii?Q?Mf18eE0tZEP6d+iH3WZhUP5WdkfMVf9JHIttaOk1XQjI8h4k370KRduDjuFn?=
 =?us-ascii?Q?Nn1Sh33Ey6UC2MsqbB5QCmmWJ9fNLvLoWhzeHOEXryzhJkXFZqoE8yno+NgI?=
 =?us-ascii?Q?V3lGiyZb7OiEo+dtCppFbcJ9LmCW/CmmkqyVAnyn/VRNBWIMxEoptngFERoQ?=
 =?us-ascii?Q?cp2WvMJD1H5IVITOxUGZYzPmtRr062D7VaHXlK8yqckbVU7YpsqF5h1qH/xW?=
 =?us-ascii?Q?GiwQC+uwfpRThPa9q4BWKMoCrwnsLB14nW3FW2TYBHFy1Cm16KDOpejaOv/0?=
 =?us-ascii?Q?/boeBRVn06q7hpfq7I6suEvQfrvwTTnwwd+46rQMJs8X1UUMVmho4fBMyX1x?=
 =?us-ascii?Q?S8G4ZDHj2nDuyJSo1Vxsm+QuVr0kgeYLw7KdNLTA1ZEtN+4AOCSBMDxyGGQI?=
 =?us-ascii?Q?0EDrcbEPQQlAdYwOTD+QzUbn7gg4Y6p0X1+bLXJRCUnIBr1Hq37Ia7egyWG+?=
 =?us-ascii?Q?UGfCkLl0fDqhbFJ2FqBNvpx47n/mF3bYf/dbPGbi0W+M8TONDuk3piINcqSF?=
 =?us-ascii?Q?L4ZtawtyMC+kmjHUlfW5Ls/lPMVusVsXFEAk7UE0zuXeEWb3t7Km2QYHoXIt?=
 =?us-ascii?Q?936xUpuL/anrEetIGe14coaE5GM2SPFxLTiHUMeJcXYF5YbeJzaXDctOL1KW?=
 =?us-ascii?Q?Sr0CocNw/ioxImzFM6OcliW2MwdNsjmdGyV0cU/oDU2I6VltwBk4NV1vxStm?=
 =?us-ascii?Q?oommJ2r6dLbqNldIOT68HMhqJzmueN9/nklmXwFM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e82a1af-094a-4e8d-5226-08dac7fc05ef
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 17:57:27.3946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 91xFEbDjsHO9iivsIcgksGkp/NOg5Ai+zKypKy4F+cMdi+WIAokXpFq2/B38zMdb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6024
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 11, 2022 at 02:55:07PM +0100, Thomas Gleixner wrote:
> There is no point in doing the same sanity checks over and over in a loop
> during MSI-X enablement. Put them in front of the loop and return early
> when they fail.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  drivers/pci/msi/msi.c |   67 +++++++++++++++++++++++++-------------------------
>  1 file changed, 34 insertions(+), 33 deletions(-)

> +	/* PCI_IRQ_VIRTUAL is a horrible hack! */

New comment too :)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
