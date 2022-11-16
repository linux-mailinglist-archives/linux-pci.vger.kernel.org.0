Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57FE362C8F4
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 20:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbiKPT2u (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 14:28:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234355AbiKPT2M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 14:28:12 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B4F61B8A;
        Wed, 16 Nov 2022 11:28:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kIt3OiMF9imSPiLgPS9PdFj2AgdOdWeMDURY9FD3aAv5m88iUJJtoRTGrSgG04tPxIoei8JRQaglz9wvFh1lVHTj2UFZFX3DpgGSLDYPj5W4n2lU1VtC2QHXBOl6nfHJCcy8IvN8LHWqW0oDT/zJXOSVV+vLX1ItIy65bBH4eeRhnPy/i+0csW6i/qEu0ItT9wYt2KMpp5YDN6ILyLzuPcfPTpavf/smxr6IVHoXwPwMMgoZtDYynZWJrpAemJeabt14yQVDB24/xj1bjc5GaAOacN1Q2zjqNXKf5z+VAcK/UnQ/LpYNL2e+Z7muMwO8RHCIcGFVRjkCKtHKr14kDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NCeMiV59uKsC6wANGYbddbo12LyYsEJfAjjmIqJ1rTQ=;
 b=iXw4RO2V7OLVxw5Wd/QpJW2n/9B5XqK3n+vIzrUkMvCOA5muRMK7QuUwcs6tqTGHCS97ljts4PrXjbqe8uvw4NAnLY+SlcjcXVIN1SbOZDWspQjKKks04LAR9ZAOy4f3hHzIvX7D/5KC7J6Sptbk3Pc6Z0Q7rBBu/lahejbvfUNEyW2VEw8BipnkZkSe5nKTVtrujvm0jPaxwvDwbFUCU81M1eoBsUulwOJvzN6FpiS3L7oRCb2rDp+80rSq81cxAasphhhUfQEYeTRQ0GqAIp1AF+CseJnqtcFUe2IQDSf3C6W1Vh1nVMBDdMXfUhgjaC+I0dn5PXBtXFgBpswEcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCeMiV59uKsC6wANGYbddbo12LyYsEJfAjjmIqJ1rTQ=;
 b=M65mTkTodAov5wZiCQXhOZCd6U9tFyzEHJInL20d4G67GHJep+eSJoDBGbeqVJhZKkaB1CK3BnYaW8hNTqE31kOLMIRcodfFFtB6HSptXne00YbEnU1Sy0Nqw0EIarhvK5s5CRJ2WBRenWdvLMqBpgeDCMjewpcVa8N+aVtB5i5bw3QQJz61f8tgrIvmRmi99fykNMs8BAOWUsTFf1JU5i3nCW/DbBHnKvYhvIld4KRS2gFNHn7qB+6egQVBocSKcinvvG9ReptHbxNzvaNDr/l+U2T+bljaw8HHDpvV9R9W4Pnp0a6u5VIqx+BWhMltk/tZ569eAlb9UU4gB0B8Ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6458.namprd12.prod.outlook.com (2603:10b6:208:3aa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Wed, 16 Nov
 2022 19:28:09 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 19:28:09 +0000
Date:   Wed, 16 Nov 2022 15:28:07 -0400
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
Subject: Re: [patch 19/33] genirq/msi: Provide msi_desc::msi_data
Message-ID: <Y3U5xwujkZvI0TEN@nvidia.com>
References: <20221111133158.196269823@linutronix.de>
 <20221111135206.346985384@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111135206.346985384@linutronix.de>
X-ClientProxiedBy: YT1PR01CA0046.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::15) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6458:EE_
X-MS-Office365-Filtering-Correlation-Id: 65af350a-d8ce-470e-588c-08dac808b18b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CXh6NkB7wYax+28VoqcnWaXi/J6/VADRoQY1Fdf8Dubyty4G6gw35XekDMny7tDiaMEErM0iPtt2xew86BF2XVVqCQ0qw7jaiIPq0kMjPSik8L7jhX3mQ0Tz9aNMcOwgcbTKzbZzpoxVF5t2ONnVK2QG4u+zK+FYzXBqdHNJguuw8uO6dD40B3kDs1EeEL/K467ks6A8o3kqGwQ508ARmny5bYns7qlo4wGviaIuP5AxPAYeDL/Zfc3BqjCc87fy3I+RSUiaEr/mP4gT/RkEPQicT/tE0/UdrEWucW1oslGBjoN4xAAiduEXJfCc51geBbpIX/axLPzyl5NtNhwLxukWb8oo+BwVixdfng38onEXChG5A782dgofQoLp0cTDwCUIW32Vrpj3c81Bt6Osq/fCdmndYsIuiYgVgrkIMbf0w7jwbayuVBzWtSOHxW4P7h9wzUTvw1/m430S0nCBJ35B13Zfk0X4DKQSNJe/l0x89H5O4W+4llOp/u7jsYOSDSh+hRKR7eQOWabfOHOlxrt3qWaNKVg1rWqzVCSqBi3j4R1kumkQ12PdDXvGSYYM29WDoumIwWaVWLqWHV3zaP7+P4Sn0YM7X5qFPcd/p6AFnGknwPLbEPvptP74CKF468g/3E4Fk+0EJ0s/eFWfsTgKsJZbhBfrHogx+B7r8jXYBvbpjyH6Hy4wNBqb3RRE7rKeol9iktO7KaJD15We+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(376002)(136003)(366004)(346002)(451199015)(86362001)(38100700002)(2906002)(7416002)(8936002)(4326008)(8676002)(41300700001)(66476007)(5660300002)(66946007)(6512007)(26005)(6506007)(54906003)(186003)(6916009)(478600001)(66556008)(316002)(6486002)(2616005)(36756003)(66899015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6Ar4BO+megp0FcbkEw2OlfNPsho8/1L3J0yUsc+J11SMu1M5A1NhVLWBFpNn?=
 =?us-ascii?Q?AKrg9WkmGxl9vqp4GMaxQHGraYiEOI9x0aGN7PQCZDHjybCGU9RjAW6lMVdu?=
 =?us-ascii?Q?Lq5PsPGhTnVhy0WKmKSXOrAEsi1BvPWc22xwnch7J7IfiuGG+StSoGUEF7IA?=
 =?us-ascii?Q?wbOW05tHyGQeGDsZRWP0XQgicn2RG6OS3RW5E3Wfy5xMacSXwm4C1fd38koh?=
 =?us-ascii?Q?JFPPeJioxY07NF98NP+pUWNytv9z/oiz1PAMzGlNoP4/nYPFQP8SZMeAUAJR?=
 =?us-ascii?Q?drzrVV3lEMms4DoKrtCHL6rFm8j2+miiau1RCWe3G1u/DuTYofIylRPKI4Yf?=
 =?us-ascii?Q?W1OG7VqSuG5zvhIldnk/JYPy6We18XspWJeHqZGh0Demai4YgBdI6bwkGeXW?=
 =?us-ascii?Q?TlvqMa1Z3mpX6+xEARauoVCBAah2dngKb2UOZHc5UFhpoDagOaYL2PDd1x0A?=
 =?us-ascii?Q?lvzD/YlIEUo2zZYkpZXSafcVOuHs1exaf0A0RBHsD6joooIO0N5ahHhoBWze?=
 =?us-ascii?Q?QFn9qfYagY4jK2Zv5rQ7FbSrau1nHgwK7ALacKzdPV4T+jiL1HWn+VgNSAPo?=
 =?us-ascii?Q?j6oFJcs6iaDnssXbfk6wEONzTyytf5+ChuM0dBVT72fQOM3yK3ey19kz2A1X?=
 =?us-ascii?Q?sCmhkLKD+p282GAB+ANIfu3QQid+sRshjCXQqOAwo2ZzdMvTtN4cbwWCUJ+H?=
 =?us-ascii?Q?QAmYs2ZxvaBgWhR1dO0KwV6gzYE4WHIAezYf36XT1eZe2aQ9jZFzV0MTQnSH?=
 =?us-ascii?Q?C8GbOJstWINhpcKzSzlxNyk0eH8CtH/3qY7W0yGA6V1tB1lBbDVuq3BYplQO?=
 =?us-ascii?Q?/q9EBqBdEhdbidDv0K0MwFgzIAu0QkHfsp4PT7C82k9g3eHFmU2sPAydljd7?=
 =?us-ascii?Q?0N20zqyNdC/P2l++IbcwdDVfbSRoKdVK0u4Bhcx5JK/8yaBOrJjlIh8k166X?=
 =?us-ascii?Q?HtnoMOLwBuiQHjmu6t8IsTPl90NPVTpVh5i9qEqmWNjFCgQZxhJDEVusrstw?=
 =?us-ascii?Q?b6jiWZgAClrJrRb08LDQp8dnNRKvxob85BZ90nsPlRWsMK4WrLYttMBayu6D?=
 =?us-ascii?Q?7BZJzvk3QpX7lJ0ro99tAZIX6+c60SeSs70dzcE08ITy0WZW2IyC2uhaTmXB?=
 =?us-ascii?Q?5OEGn7gLK9j36dZcpBOJWxBLHtjIP3NYbQDVIrAI9ROhZNt8ddeHZfdeqnGL?=
 =?us-ascii?Q?KsWnqk8xaENVGSMdpfb8b7DzYqRVfTqhLBiM5PoYq4EQVeaskFt9dlMskp4G?=
 =?us-ascii?Q?Wr03gccewDFo5Mk2VUTJcfcAqpC1106mP39YGgDfInT2/t6/owF2UtBbkA9K?=
 =?us-ascii?Q?NXNcOeghYWQBDu3x8TQf2dLUL0EtLvlZuhCevWSNEXNuGuL+jTTa74k+nV4+?=
 =?us-ascii?Q?Ijwm90QDrz3SW4n8CiyecTCUDmscg4diM+LP9G3A6FZdqIgOko/U5yWFMEsv?=
 =?us-ascii?Q?rMfRxx+TDdgCO1p4TNX/ubKTRjQpyPsgGvqDh2PhFyQ3kTWZrm4Ux9qLfCSI?=
 =?us-ascii?Q?KmT88zRrviginNdAnrKhstWDYMiAIawx+6sjn4YDnVrZe2GQ6dS17anAgmIa?=
 =?us-ascii?Q?eHGOxjKfAtOvhZYgqtp9TzEn11lkJN2QymMzZwVB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65af350a-d8ce-470e-588c-08dac808b18b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 19:28:09.2370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ubr9LO2gd9UYrv5RNOgnSQJYx/3PUaQHepr67XeiodD0Qw03tXxIOpWQb6baknew
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6458
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 11, 2022 at 02:58:41PM +0100, Thomas Gleixner wrote:

> +/**
> + * struct msi_desc_data - Generic MSI descriptor data
> + * @iobase:     Pointer to the IOMEM base adress for interrupt callbacks
> + * @cookie:	Device cookie provided at allocation time
> + *
> + * The content of this data is implementation defined, e.g. PCI/IMS
> + * implementations will define the meaning of the data.
> + */
> +struct msi_desc_data {
> +	void			__iomem *iobase;
> +	union msi_dev_cookie	cookie;
> +};

It would be nice to see the pci_msi_desc converted to a domain
specific storage as well.

Maybe could be written

struct msi_desc {
   u64 domain_data[2];
}

struct pci_msi_desc {
		u32 msi_mask;
		u8	multiple	: 3;
		u8	multi_cap	: 3;
		u8	can_mask	: 1;
		u8	is_64		: 1;
		u8	mask_pos;
		u16 default_irq;
}
static_assert(sizeof(struct pci_msi_desc) <= sizeof(((struct msi_desc *)0)->domain_data));

struct pci_msix_desc {
		u32 msix_ctrl;
		u8	multiple	: 3;
		u8	multi_cap	: 3;
		u8	can_mask	: 1;
		u8	is_64		: 1;
		u16 default_irq;
		void __iomem *mask_base;
}
static_assert(sizeof(struct pci_msix_desc) <= sizeof(((struct msi_desc *)0)->domain_data));

ideally hidden in the pci code with some irq_chip facing export API to
snoop in the bits a few places need

We've used 128 bits for the PCI descriptor, we might as well like
everyone have all 128 bits for whatever they want to do

Jason
