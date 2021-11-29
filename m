Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C18C646176A
	for <lists+linux-pci@lfdr.de>; Mon, 29 Nov 2021 15:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345723AbhK2OGd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Nov 2021 09:06:33 -0500
Received: from mail-dm6nam10on2045.outbound.protection.outlook.com ([40.107.93.45]:52225
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240565AbhK2OEc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Nov 2021 09:04:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZfBWquzF5z+giefT0qPGkA1Ye4oHffX57jWMjLoF1AEDPOigfLzJCMsUZecJVRlaquLwqOWugNKA+H3PQH/3lyHbrMLnQ4sPYkj6Kw6F8WkrF1NasNRoYtVUWF6Jv3AzRuxaDydUHhsG9iKaN6gsPvIAdJTFAo7qHTbTiGdIWGCifWev7NHrxlUJuAyvPJW893RTlAfz4Cqre2GsKj13EuC7yTTqpKXelZCT1BY/iWeCi/MHKo3iPHa4L+mXWhVBaFpj4dXelWlHNlLUIUAjDYfiieCkWH24ndeQyeY/bJ4HC2gpoTQZjhmIr+maqkOkfo/hkN2QrnQuWAC2QXTUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gtZ7/6rERXVBWwFK1G/0JKo8mkcRKpDbqSkSr2C9Ld8=;
 b=CSS9nnlvWQLESvZCzULXuJPu6VCw8XUucr7GLZXCWwlVfBsVXfg77KWI9xxd0/sClzTwXaLdUOwKKGUTNEvSM3xzAR0rPxMYQxJccj3rwPoFaIuZz0KtMSDmtY5nq88+Hii0hlDx0FmgBL5oe+RTEvpwC2uxx1mBWyAzX0Z6syKJtvuLTdUxNouthCfCP/cpIYPhtZH7/OtTs5sthXXP8XuTNGK2nVEm17X3tc3AJOgLfZHBc5nkfroZQZxAF7DaFj5sqcQ1cdMJyo6EjsuYpHFdNnRAUHL6nr8ccwV3yS/aUrlu32jVfDShyVDbvmar6/Z0hMHcK1cI0HidB92YwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gtZ7/6rERXVBWwFK1G/0JKo8mkcRKpDbqSkSr2C9Ld8=;
 b=ApjIiL4j1y2aew2o9DW0zruBx8QtDxwdX14H96aBR2nUdG3xYuHNu2NATaDlKxDGAjDgidYiLjP4SCiXxVPwoV7cM63s9ZhHrQKdwf5TxB6fPGJBbhUQU+bkbxOWmpVfvyP3c9zXzZqRLusVE05AblKtLEDZo3Rp5Myzv9+06tIiDwIfl44BiNJHz720fe9YOA6z2NzjoSxQCzKcGP6kD8aQ5rOAhaDaeNsQ4bB6vUdi+6AmnIS5jRe2sxAWrf+uqX77vZ8BrXhlRsFv2bMETHmOi1ER91Bw8l9vgge9cJBgm9xz9Y99yLYS0tBmrKlhnzd46+MDeX3JkGR0xZAC1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5553.namprd12.prod.outlook.com (2603:10b6:208:1c9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.21; Mon, 29 Nov
 2021 14:01:13 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909%8]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 14:01:13 +0000
Date:   Mon, 29 Nov 2021 10:01:12 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
Subject: Re: [patch 04/32] genirq/msi: Provide a set of advanced MSI
 accessors and iterators
Message-ID: <20211129140112.GX4670@nvidia.com>
References: <877dcsf5l5.ffs@tglx>
 <87o863e2j0.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o863e2j0.ffs@tglx>
X-ClientProxiedBy: BL1PR13CA0346.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::21) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL1PR13CA0346.namprd13.prod.outlook.com (2603:10b6:208:2c6::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.10 via Frontend Transport; Mon, 29 Nov 2021 14:01:13 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mrhDU-004G0l-Nk; Mon, 29 Nov 2021 10:01:12 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d361b82-cf23-4eec-84a9-08d9b340b461
X-MS-TrafficTypeDiagnostic: BL0PR12MB5553:
X-Microsoft-Antispam-PRVS: <BL0PR12MB5553FCFA0651492A6C248B3CC2669@BL0PR12MB5553.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pOhZ8/B8mvHRvie2yoL7bRupIh/v2jC+zdwG7Kyy2iBvpcICnN+dLffoa/ks81ByvNNAi72nQBK9uHQr8GGrxFy+E7QATI4BEunuJQ/2gIsthl9HS0mOsTsew662MSPGU/oMfAd7c3gdy5ttUX/xyVEeFgiuFMD5dWheReofcKeHYrUdujwOsk2AmnO2vf9Vqkrz8qdZHhOJ3uMdLU1AEpA7QAhZnIdXVPVPvnnEm8vrVuYTz+uFrD7S4E82tj8UmwXg1vT7zqqAgSNYulKMcOdkWtuCHnYgIDgZSNRYyAEIx8EyQ10Ifu9aLnBY/6wlehIyjUZlcYdjzY8C4BHSg7AO3+QyU0LCSbjtsbUsKWDceyZvu7oW+EknfnBdtYKxlC2CrNsCvbfmPQvO+snJ3sxcnaOfxlpZeshxLZfM1ksyrPEUWub3XXbCyuKk8u6kYobEJBZk25FCBTVshDsxqUq4XxPDK6FWSNMaMOTIwWlCFqTiuGAle7e/jr2VU40LxwF8IySa2w8V8OdHWHCD8QxtpbG6nrq1JSA+yjPT37X4uePABvEFJq+cScsqyfJ5aRLgria4Ig1sHDkhgF+zOTrl5z2AvfWpMbsOIJBlD/wROpRHIqa2Xy+Keo/1Vg8NBwJngaY8ViR/MiSMMpU1RQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(86362001)(5660300002)(33656002)(8676002)(36756003)(9746002)(38100700002)(9786002)(508600001)(66556008)(2616005)(83380400001)(6916009)(2906002)(4326008)(1076003)(26005)(54906003)(7416002)(66946007)(186003)(316002)(426003)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lZomaS9M4PAj2iOczNch1wJPqcPJcysC2OPM2YqHOr76fKbgXoivR5pHNTnX?=
 =?us-ascii?Q?mAlC/KcRRiu9gd5toh3wcyScjhIYNcWyFJHRKv6idyaq3oSRGWDYV64s+8eT?=
 =?us-ascii?Q?TIo8YkZthVLVd9Ghb0ax5FLscQMZgjvkbGjQdAOgTprmOpqKfB+LgkrdcOTi?=
 =?us-ascii?Q?VOH3p7rWptvLAB58HRTHohROfRZXt2Wfum1/rFxWGsctaThRI7vEQ1eoooJ1?=
 =?us-ascii?Q?WI6uMSPx4WjFprCvNfgctzR7nVkvCVxDvSLZlQRqLjP7Y2lnExj5fC1MG6yT?=
 =?us-ascii?Q?6gwynyvTdB9sV6Z9QRFP3zQGll42XOzabTM8x3gk+GAIvzJL6uO8I0kOoM1h?=
 =?us-ascii?Q?RcpxT737/FDXpcLPCmiN8eYG5U3mkDPG5UQoEMTPAFi1KekrUMDKaKJdamyl?=
 =?us-ascii?Q?Jg5UjBVQj4PBfm8epCRSpXwV+0soZLZ20QpFceuNNzEXJtF7KTraEMgWTpN8?=
 =?us-ascii?Q?WyCPiNnFGyopohKvjalUjE0rwuAbaJh403SV0QSt8PCM/zPUyaitPxBBCH4H?=
 =?us-ascii?Q?m6R1c7qDMpPKBKgA3zMTa5mun2fwCuFRlqCoava2D/VG4Ne56f+xUdEdqNSj?=
 =?us-ascii?Q?o+vXbecvTS56AIClaVG4O5hAP+gFEehEDCo8YMAC6E0HX4KeIr/xc7XCgqzN?=
 =?us-ascii?Q?UYBvmXBRnS4n2vXDhEWkRstfEPztmu/c/NbXeha2jrG6iNJPT/bJPFexqa97?=
 =?us-ascii?Q?0tOf6Xm0boMBZ2SRv99t+2YGgEWFbAv649ecv77GBzE32EhWKkeq53wkW6PH?=
 =?us-ascii?Q?dQm5UCwH+fmyK49Uym8HcR1g4bx2lsU0gcOhNh2o5ZO4FK4d1z1YYtzNMuY9?=
 =?us-ascii?Q?K3Estd2wAKNCoYA4Cva/zlmjqZI6J8DWbevxh0HBlOXp4SrfrYhCtai5PJ+q?=
 =?us-ascii?Q?78Y4bG7soMK+9ztP1YfrGSILYDXUKGNc+ap+fchpSjEST4XCr8pxY1nyt9Zi?=
 =?us-ascii?Q?C3Jf4PQttITfjMLhORfQMo9YbolG+3B9AwBPXRawqJ++L+jEYWnVQPsXqQG6?=
 =?us-ascii?Q?wFa4GKF7l7AVaQJ602z82AVa833Qo/2lEc2BjkB1SzYW7CwP7ySpnsg8+KQV?=
 =?us-ascii?Q?X/nAC4UCxmhOv+rXvcEhl2Vu3tI6mOUxZKYa9ymZ014Tqurw4oKVlZIYuZ5P?=
 =?us-ascii?Q?stu1ZkwsLSgcCzlntNoRbYWjzjGk5ETsRfJxHT+uZqvmTz03D5dLITDCxuFy?=
 =?us-ascii?Q?BypheOe6zAbMSapA5dGW6uuSwiSF7jMyrO3qxy9368dAxyFwbrzXl++pocoQ?=
 =?us-ascii?Q?S8U0XkMPjZxEJQJMeAqxy8fpXZGttm0Ff1LtXHCaCCd5GxEX4NuPVkK3Dk4P?=
 =?us-ascii?Q?vrabxTKt+8V9zU8XqtSVs2yEYGgYOx4/SyzkFYmdfDgI1L0SP6L9urvuw/HY?=
 =?us-ascii?Q?f6YfkFyxF3LH0gXO0e8kDQJcXSEV3JQAEv7g3GJ2PjpgKGP2o/LuPEYvtuZe?=
 =?us-ascii?Q?ieEiqYUf3WkrFTWuEqHPN0SEpIuNAztODv4bz9Dj/dHVYW4MQ8hLX0DfoFDH?=
 =?us-ascii?Q?Tgs568zQ9qKwrotc7YhznStzYO/s4+R5ncKD1awCJfInsTTF652ZldWtdzmh?=
 =?us-ascii?Q?UDGwBTsEoTr02EySFfs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d361b82-cf23-4eec-84a9-08d9b340b461
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 14:01:13.7116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4CpNfmPv578wse+S75EO4zvDcoD0csQQyZPM+4/QZ55QPHGq5tblPB3vDBfWq66h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5553
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 29, 2021 at 10:26:11AM +0100, Thomas Gleixner wrote:
> Jason,
> 
> On Sun, Nov 28 2021 at 20:22, Thomas Gleixner wrote:
> > On Sat, Nov 27 2021 at 21:00, Jason Gunthorpe wrote:
> >> On Sat, Nov 27, 2021 at 02:22:33AM +0100, Thomas Gleixner wrote:
> >> I understand why that isn't desirable at this patch where the storage
> >> would have to be a list_head pointer, but still, seems like an odd
> >> place to end up at the end of the series.
> >>
> >> eg add index here unused and then the last patch uses it instead of
> >> __iter_idx.
> >
> > TBH, didn't think about doing just that. OTH, given the experience of
> > looking at the creative mess people create, this was probably also a
> > vain attempt to make it harder in the future.
> >
> >> Also, I don't understand why filter was stored in the dev and not
> >> passed into msi_next_desc() in the macro here?
> >
> > No real reason. I probably just stored it along with the rest. Lemme try
> > that index approach.
> 
> After looking at all the call sites again, there is no real usage for
> this local index variable.
> 
> If anything needs the index of a descriptor then it's available in the
> descriptor itself. That won't change because the low level message write
> code needs the index too and the only accessible storage there is
> msi_desc.

Oh, that makes it simpler, just use the current desc->index as the
input to the xa_for_each_start() and then there should be no need of
hidden state?

> What for? The usage sites should not have to care about the storage
> details of a facility they are using.

Generally for_each things shouldn't have hidden state that prevents
them from being nested. It is just an unexpected design pattern..

Jason
