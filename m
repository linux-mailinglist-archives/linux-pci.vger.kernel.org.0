Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA5EB463F38
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 21:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343697AbhK3Ub0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Nov 2021 15:31:26 -0500
Received: from mail-bn1nam07on2069.outbound.protection.outlook.com ([40.107.212.69]:34950
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1343667AbhK3UbZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Nov 2021 15:31:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jOxUtZK7oQ62pFIZ7VhjQWrGKIrEeKZGIR96PESivHWluxu2FS6RNd/RyXJpPGy7k1T0wg+EYI3xKV7XDyeWKO0aKw+l1JyWCwQOakBUUKxZgquvTJ2IFCwpSJTG0DY4Sn0D7uEytcZIxrwFti3Vj4v6jOyTfxDmwYkMlVo2doPoIB3YQYHSIYDinw24Q9nuBXXZwD/tn9qGJQUO6Yi6h+xJyZEBQB5zmeM5QTWwhGnELoFjqolR9+OZaZVlO5qMieQirKgHPsChsGH33gll9Y4vf/8tjpAGI3RMkAh3ZCVfLz+mIrCM0RF/EQ3T/IXVhoACTd41nNAf+xS+wHfmdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6ZY5ACMuyUpQLU7ZfWCRPgdiyQKhG8NR8yudvtEaAU=;
 b=UQwj+S4BMWADsw6XEviddUOvKma79WQfybx5UJtoMAylF459JJ80bMVA3898bsn5sNsTo3d4LvuznDopvnc/cPaieCFxm4JjlDOxnksIKugrxDYd098EuYGN2KKKVlVB9JwEPzeBPs5CEuYBmDOlNf5f/smG6NWeRqbcvsxuiOuEIG3CUD02/PaeyWsg20fJ9XAXwyiphaw98BmR8XBFQvwSO5SfHtIAurmwFFk6Kpfegv263Thk1NKaoUnOTtxHID6wyN4oYk3ZZMO4nO/IeMaDkJX7t275oUiejuw+qqWk1bMFfsHfOChfFziKyxu0+TXa0IApr5e+PkCwRrdNiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6ZY5ACMuyUpQLU7ZfWCRPgdiyQKhG8NR8yudvtEaAU=;
 b=MhQn51FvGe+HJAklNYsGJsbQ4I5ovlJPZ85Iciobhf1vZSZKmcUB+X0TJxfClsmhT8Wm7cwstLQvX5SzsL52iL3tU5cnljf8F6CUafPm+2iKWoh1qeLdIufGKPwaoFpVi7cUvuge8nkYRSBiffpCG4a3wytSWxI550L5CNigOAqS4VV/jrdzWMw156q4CzG73N5VEO6Kgj/Tx3S6nfw0m0sBCoGJlOnTNitBq1oYeDwo7o8mJTYaD8D4YXDfvoTFULC+f5skx8QXFI2Nvfl9Em8QzblseyshEKxRcDQGiLT1Z1T465k+fkxHspL7qwo9UmKam5U0Z5uNxinTiuN8Eg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5240.namprd12.prod.outlook.com (2603:10b6:208:319::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Tue, 30 Nov
 2021 20:28:02 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909%8]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 20:28:01 +0000
Date:   Tue, 30 Nov 2021 16:28:00 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>, x86@kernel.org
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
Message-ID: <20211130202800.GE4670@nvidia.com>
References: <20211126230957.239391799@linutronix.de>
 <20211126232735.547996838@linutronix.de>
 <7daba0e2-73a3-4980-c3a5-a71f6b597b22@deltatee.com>
 <874k7ueldt.ffs@tglx>
 <6ba084d6-2b26-7c86-4526-8fcd3d921dfd@deltatee.com>
 <87ilwacwp8.ffs@tglx>
 <d6f13729-1b83-fa7d-3f0d-98d4e3f7a2aa@deltatee.com>
 <87v909bf2k.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v909bf2k.ffs@tglx>
X-ClientProxiedBy: BLAPR03CA0044.namprd03.prod.outlook.com
 (2603:10b6:208:32d::19) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BLAPR03CA0044.namprd03.prod.outlook.com (2603:10b6:208:32d::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend Transport; Tue, 30 Nov 2021 20:28:01 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1ms9jM-005jFG-3n; Tue, 30 Nov 2021 16:28:00 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63537dc7-528d-4a5b-5613-08d9b43fe7f2
X-MS-TrafficTypeDiagnostic: BL1PR12MB5240:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5240EA55F08A1291534E6C52C2679@BL1PR12MB5240.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OAh1PgjjJ7D7KKDTgunpFX7FRJxK3rvNLdVybeOeiLEyRoAzS7zF5tVgJ4gkSIDkDo34Gjv7zS6un+O50GIPTk2rRaxqQlzzoPoWJGzBjFnW0wsNdRiMy/TwMtVOyYLzMAep0x8ryj/VAPwANUK0HkBoBxuCPCmbpNeZfj8IF3vuf5B5ptfuf/8H4ALwLEjwFxhfSG5fPddHoJY/O1bd0VuFBWYF3ktkS2Fk3ItGIrckoo0963cJEipyg9/rycdyOvU3ONaSYHHQkSZQiP881ABrHaf1O4Z1/5ckMsW+XkI5vJQ5JzFyTet9QKFmplHQfpmkDpO5wv/4fT4aaj9TDJRhUv8UVHehuSXaI/jEcAcIHZfrUTn4ePn7rWpGkYOLZf/gEjDevu9hb96SliXAfypsqTDY2TxcT0Uk+YnhAMbN8378oBYeVzTRR08z1i6auZdzf+mx7b7NEQUOErfEw5N8Qmm/bm0WTodHgdqNfx5BeZHetXDyrSqbFBneclL4TsCGaexj9Ml7RLLpeFYS0167utUypmr8DMhrtUorTNV3CBhOmeHaLE1pEX5vuDQHU/JKpcy57Jq2eHg4siRKbmY7rhqmUM1nElD65VZQoXz82XJ5sJxpbcsw48B31ncPL6IyRrsfC+sUtXFuYpEL+na737z7LO52r7e6z6GZZAIMVGy8FMp9qfeDPut4qJSVH6BcmKzVFD9ULSI/fCFqHFc2Ji28I6PXElanp/7kbgU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(2616005)(4001150100001)(38100700002)(8676002)(53546011)(7416002)(8936002)(508600001)(1076003)(966005)(83380400001)(2906002)(426003)(33656002)(86362001)(9786002)(54906003)(9746002)(36756003)(26005)(186003)(4326008)(5660300002)(66556008)(66476007)(66946007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i79AMh5yCjE/aw1aYbeO9EILecIeHP50tYqPFWT4cJoGAqRRDousvpXnh02x?=
 =?us-ascii?Q?oQJhnYEdB7Xx5NzQxMcCi5SaJhhWh0TGVhNO0P8pXM1EXbzl2DioTavzdzR1?=
 =?us-ascii?Q?Bb6n2a8xBFDzQBZHFX19NQwgrx46ZSa7gPQnJqh9mQC39TXV49un12D4qtYF?=
 =?us-ascii?Q?yBdrtDxZ9lEcrUhGWkbIfTmVdWU1m53srtSz5OeQ2If5Anq/hY/8d1+DKj2O?=
 =?us-ascii?Q?CdS8LOsgFI0faiv70j8psDLbF9Keq9nXPxx+Fy4vou4PNmZ19eI90GKjKBLK?=
 =?us-ascii?Q?oCkujlL7CUlk/+Yu3UTSVaCCDGlyJAYsOWHpsCcJ35i3vu1o+a8Ss3mv+TmJ?=
 =?us-ascii?Q?KuIYxHnomJNfV65SeiFsNKn/qw+/dbNtJUs2TWD9C7j2a+suSoJ+DuJOcJXw?=
 =?us-ascii?Q?62oJ7XmxWrw3uPv8368xxWORlgISVr2yIYVvMAgBXAyTL23B0XlYQxbd7GRI?=
 =?us-ascii?Q?rUIU9tN/AOG3n9prkNU7cNWEQiKylYZ/faP7N1UUa72YH5M4XDxFIJlfBGlm?=
 =?us-ascii?Q?7Mg3i8VNyLiMMFhG0qdux+5vyW6H9ybPmnyBrgSrVFzx4YyIuvzv+cA2KH9Z?=
 =?us-ascii?Q?AKIc6NhnOHRDO3T7p1XN+V7qygIp0SjzJPdt+7IKYohle+2dN4+T/A58B2/1?=
 =?us-ascii?Q?h6lAw+qPWCvnBjBXZ1Z8Od4G/Z+6OXrgulZpm3JARYIrIAIDqc8j9Tdx1Yi+?=
 =?us-ascii?Q?BrLRRP5ki8VoRS9E2IK1SKSHspxf+DOd1gloWPk8JZ1km7Xh0rkOejcwpOXA?=
 =?us-ascii?Q?fP7YMYKKYei0sMWjx7ldaoC/vP8TS4JzejbzXHL7MREoGrNXdhRrnfEaKLxE?=
 =?us-ascii?Q?a+G5U+yVxnrxLBeQhKZD+yMCYvCfmAZXbk32rtPtdBBtftuFTcABQXee2MWf?=
 =?us-ascii?Q?5oYJOQCOO7NqQoPurc2mIOSTUQEic0G/y5ld7tbnbXlcexbgwSIzdnXzQVkK?=
 =?us-ascii?Q?tnVUZzP2SwmGFffMQlc/hmhnDx41iJhaD1glTSR7FMPafQPAiGrCTbrXvNIH?=
 =?us-ascii?Q?od9Ma2jXbk3LDEO+0BoOgCSwoJYO3U7H+E9LNzVY39rScJX73sbDdL8hkb41?=
 =?us-ascii?Q?iZLHJspvyHTBSwWVwgd6x68dVMt7OQXe5a+I5bwDIGUvKB69OBHzMMeUHlmn?=
 =?us-ascii?Q?KST+Ei7WlD8R56N28IEvd89dczffgwlyRPu1bycozPbhErBYtzu31KwNcFV+?=
 =?us-ascii?Q?kSi9d3AdCTkMnzvkZ41K0ViacuuOv6F5o8Hr7S7j+jxrdRdNamRv66BuncTf?=
 =?us-ascii?Q?AMq5eXyktQyLeq8j++JDFiBI1P1MWoVpjg0FOAu3UbFcIREhR517KRLC+pU7?=
 =?us-ascii?Q?4u3Y6wLfkUbG9lylaU5Ms9kmd3aXLrmisPlDzHE6JItpBEgd4VXr02NBwU7o?=
 =?us-ascii?Q?fHshWSGq6WToBZle/Yx6XYIgZyUF4ujx/JKKGCRjA0+UrQLMEyW+dUE/3REC?=
 =?us-ascii?Q?B+0P9j0RKELMGmrT9rMdXQpkiTyzADQdUEMo0brk6eg8P2cwUkGFObMsTJ+x?=
 =?us-ascii?Q?yXt11LeU/wCckQstLhjOnQncq5NZUWGV+FWj22u9Wa4i1O+DV/cPPH4QqE3M?=
 =?us-ascii?Q?DuT7jWRMz6UeVYNB3rI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63537dc7-528d-4a5b-5613-08d9b43fe7f2
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 20:28:01.8487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ucpqPuptML+MhNc9/6VfMxvzAvM6pnkO+/XxCtjpSbCVwp0jjQoK4ZDjGInrO+95
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5240
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 30, 2021 at 08:48:03PM +0100, Thomas Gleixner wrote:
> Logan,
> 
> On Tue, Nov 30 2021 at 12:21, Logan Gunthorpe wrote:
> > On 2021-11-29 5:29 p.m., Thomas Gleixner wrote:
> >> I'm way too tired to come up with a proper solution for that, but that
> >> PCI_IRQ_VIRTUAL has to die ASAP.
> >
> > I'm willing to volunteer a bit of my time to clean this up, but I'd need
> > a bit more direction on what a proper solution would look like. The MSI
> > domain code is far from well documented nor is it easy to understand.
> 
> Fair enough. I'm struggling with finding time to document that properly.
> 
> I've not yet made my mind up what the best way forward for this is, but
> I have a few ideas which I want to explore deeper.

I may have lost the plot in all of these patches, but I thought the
direction was moving toward the msi_domain_alloc_irqs() approach IDXD
demo'd here:

https://lore.kernel.org/kvm/162164243591.261970.3439987543338120797.stgit@djiang5-desk3.ch.intel.com/

I'd expect all the descriptor handling code in drivers/ntb/msi.c to
get wrapped in an irq_chip instead of inserting a single-use callback
to the pci core code's implementation:

void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
{
        if (entry->write_msi_msg)
                entry->write_msi_msg(entry, entry->write_msi_msg_data);

If this doesn't become an irq_chip what other way is there to properly
program the addr/data pair as drivers/ntb/msi.c is doing?

Jason
