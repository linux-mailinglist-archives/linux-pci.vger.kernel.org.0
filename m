Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45C6D462847
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 00:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbhK2Xez (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Nov 2021 18:34:55 -0500
Received: from mail-mw2nam10on2049.outbound.protection.outlook.com ([40.107.94.49]:53455
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229558AbhK2Xey (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Nov 2021 18:34:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gVbC7+8ClrqWAYdS/veFfz10RCOyHjhf+eQi8gNtV+4UpmtNcz8eqtKx+icP/53mvAZ4gy6C4y6GPiRUGg2JQq4qjGeZVW0V7FRYH1eMZtE58jUyobaReY3qwPApcV+wIScKw0e1T7gxkLgPhsdXcynMGbwv5uMlAxWkm4szA+iKOkP8JpW6pvoe1ZtYy8QMMfIhr5NMnqt6CZ1DiMO934CK82pXGzWbSlUyyIaKSlKf4e1WDeIX7oeo591ekB+UCN06cs3lIg6JvBrrasSDyz448oQV8JHKYOKAcbU/bLfc0k3cqCd/KV4/OTBQJTTUwd2oePGAaj19rk9fNi8BaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nyxPtnkcQL0uIg9OAMxMzlMr1aPsQv2mJYOr1PS9ewM=;
 b=j0zqQHwfJ9GiwHOytIEZ3r7ulK8+4f8dZ7ZnBkjfBrXm2FCsYMXMR/uo6l9TQDflBonKCYPT1ueg1WTBe4rRF8NEVROU9dp2ElemvsmbARyjr3iofFtjWiiXZbDibIXD18NG8mUibfj+P3VG/WXl3VU6wy6273VsCqUGPVt6Anr8635/dtwnuiXu8EtNmabNEVh5xEfSJLRa5GsD7j/mBbIdjuRKzdhUmmCsiO9L/uRG1XeTdEVysNHB/syWX06E5+SKhwg1rHsNG9I21iUBtKJskgtw2/cOu3j5qexxgrU4iZsmGxUnTbn0sOFmHaP/o11qVbkdQKzEXWQZTZS3fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nyxPtnkcQL0uIg9OAMxMzlMr1aPsQv2mJYOr1PS9ewM=;
 b=BPxRiq2YDhH2QDEmIjdNk+HWzak27A2Hs4ncGSPwMj2Yc0GMOdhktgS33q3UjbGkbRFqdbL4Fxdv9zvyQ0zmYOPQ0QQ4mr6J7Lcmy0GMDarzXlITXQhwYqtJIRgk1j5aITqGOi51IhEpJWK0Cz31GooLjIcrMAE5ktKJ/KycMGYaDLx/d9sGB8t8mEIPBFk0MymiE16LBsNdVfHJZ0vkzmCscsL19fsHvV6FtHZQfai3kfxfQfz6UN6HtT+zGJQlew5IZeOn9GdeKAwUEPBLgeZxt4h/TxZE4cBWYqAsKpcc5gyGkj7eO+LkzA6k+d1hKbhY28jD9ZZ5rwtiPmAPyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5191.namprd12.prod.outlook.com (2603:10b6:208:318::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Mon, 29 Nov
 2021 23:31:35 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909%8]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 23:31:35 +0000
Date:   Mon, 29 Nov 2021 19:31:33 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
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
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
Message-ID: <20211129233133.GA4670@nvidia.com>
References: <20211126230957.239391799@linutronix.de>
 <20211126232735.547996838@linutronix.de>
 <7daba0e2-73a3-4980-c3a5-a71f6b597b22@deltatee.com>
 <874k7ueldt.ffs@tglx>
 <6ba084d6-2b26-7c86-4526-8fcd3d921dfd@deltatee.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ba084d6-2b26-7c86-4526-8fcd3d921dfd@deltatee.com>
X-ClientProxiedBy: BLAPR03CA0110.namprd03.prod.outlook.com
 (2603:10b6:208:32a::25) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BLAPR03CA0110.namprd03.prod.outlook.com (2603:10b6:208:32a::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend Transport; Mon, 29 Nov 2021 23:31:34 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mrq7R-004kPs-9f; Mon, 29 Nov 2021 19:31:33 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a120248d-c303-4c37-2baf-08d9b39061dc
X-MS-TrafficTypeDiagnostic: BL1PR12MB5191:
X-Microsoft-Antispam-PRVS: <BL1PR12MB519143820A0AABA3DF4B591FC2669@BL1PR12MB5191.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yy/GrBVA+5qtPbF/ctJMtFSTY4k11w2t/QwmigajP8r4jZxAB31+SXLZmq0pTMN+dRt4CwF37OO4Ge6pi4mAQFrBJjvm95YvZy+eJvUpLyrtDK0JCWVP1D4o1SiB5tRxfqS8UEIXak2fYQHd1dvOPvb7SNoybhsFNoquiYujxbgBy9HykWBJp4jOgKcoOa7ueJcOWgaJV9PJK/x4H4iGSHKWPZufU3Cc/oe83GZCKeRVRGXukwi5CqE8lQNGhvkPE/0PdbfKRCrRnhbA34xbl2r2zY59+AyG8HuZFRyyzcIoipB1AIZv6RrGb3v5MOgiVLC6DB7Nf40yJMFuWqpAEO5YCutEyF1yy3ZM9hiLqHPgRFLbuBfdVQ8m+fKuTm+KtX/DR0rxYIzZ6VeR4gvEqWumVgX7a3/Pzfsm9x6ZnUA9CeY1Wk37jAk+Zf/bDZ8gyz4N6YvhC/Et+Dh03lrPULJog0PV+RiaiWw+Iv3nnihDLj1OjmBhJGHzywLIpzQFdz6058ajYA7mlBIYtUBDy56ELBZRITexvSt11YtGyoEo2cbn7+GH+GV5aV8SnRw/nEn5moVUfGI568xMK/oLi5DLF72y5HQsIrVNs+VtJN0VogTJwqumS6r1mL2wv8s0Uw09t6Jv8B+9pShZ4zhzcw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(36756003)(426003)(6916009)(8676002)(1076003)(66946007)(2616005)(5660300002)(26005)(7416002)(2906002)(66476007)(83380400001)(66556008)(33656002)(38100700002)(4326008)(8936002)(86362001)(9786002)(9746002)(54906003)(316002)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d8zmZsrlevrOyId2WsxDhY8ZQyvEEmffio4ibRhoF49elGiDkrUTEk9ELLtz?=
 =?us-ascii?Q?94M0UpQqdFK7fyPr1TXCxZodb62l8jzhxPpAuy3RQOMY9NW+w6/9dV5RePzT?=
 =?us-ascii?Q?XVUjPC/4OpR9KyzJZ/KNdvh/LG2O8a3WcihresxeXFRONt0v1wY8I563aA8s?=
 =?us-ascii?Q?Vh7Pi0/gS15oNmz/toxMOjnO8K5NAfLWMyu3AfzKT6o/rV0uou+kYDpP258h?=
 =?us-ascii?Q?04DLXAzZleEIHq1lNldM8OJONR13fjJBgjdCTnhKMCil7oeZWJ4TSsTwMl5t?=
 =?us-ascii?Q?WK6whG9NajHudHXZR20n8Nhcf68OXACRSh27f8C7WJJ6oti969D6gDxktxXg?=
 =?us-ascii?Q?J0g0ecGuF4K36EPZ+l1l1LvBZMb4VBwaiYm9hnh03fgP/tEDrH12rD1YYpLr?=
 =?us-ascii?Q?8W9bKk5pSyLMmQUyvfIhL0/eoUBJmtm3EIiU49nD9kyojCHSUTg30MP9Phd7?=
 =?us-ascii?Q?Y5BWFZcVYXsk84o7lFunjVVynuoE167agf1Nyxs1D4zhPCEXCVOiFqwFTI3u?=
 =?us-ascii?Q?Cisv43lqhW18SM6tp9twWF3QwaYLK8VtCtXgr7UkJDjyqMko1zUDM2Z0W9M+?=
 =?us-ascii?Q?V1O/NoYNx1HMdnSapkEURWHmbrmthDvUSzZevrNY9GX9ZAGyyKFzoEri3ewU?=
 =?us-ascii?Q?YhaW8HNcfh+wm3xtbnN9J9EcO4id0Ksq9NG9Z2vR7MNgRrttlbHveoV4e8LC?=
 =?us-ascii?Q?XENrVKo8Fg8D8Twg056dHxlM2K4z4tgeLdKd+daFHxfuxh0I259l+q34ksVX?=
 =?us-ascii?Q?ukfiAmHhv2C3/6GYlX70AjDpHU38f50U7hovaWFhLmNpfNWou6UG+NpKosYU?=
 =?us-ascii?Q?XQsArJl9M4IOsc7InKb4RytaKNybkdSQw8krIbAYwAfHl8sfYB3TgP0KqVD/?=
 =?us-ascii?Q?probtVtyRYDjfbK+cT+3zz/1o3aAOUziLS2fH95LQ0Qqm8gdqwHIAlX1LCDH?=
 =?us-ascii?Q?5gxDP+XliD6zi00gwf88Y1k3JuMcohKctRzoJn2sxTcOBtT9SBzpvt3HUyak?=
 =?us-ascii?Q?vRY9YonuHUWL4HgQ+Y5uoDKXIH82kj3Qizlo1ATYM5bseKtnBnH6FNA8U2sS?=
 =?us-ascii?Q?dHv1z0CT3D5yWbfGhrYL1EGpPYB+OUoODd32mI1zxJIGpW1XquoOAlYcoLko?=
 =?us-ascii?Q?tUJjsO7NhFeeptBehBbipADoXZvVYB+nSZWQrdwbO2Ic3nIQKbGXesAJloa2?=
 =?us-ascii?Q?LemTMpsz20KcjiKe4vdxlE+uIzNPkUNN7i8gCTt4uZPFfCmkfeD7kBIJjEvc?=
 =?us-ascii?Q?NQYpMXRcNowTgNkWx0gK4AJbSlXyGjKReiAfq/67AoCmsSG1m80reydi5M/C?=
 =?us-ascii?Q?tQWxNn3qPi53fMIlgWAjhziO/6bSuWkJvN6SBfWvN40kb4gsxAqr6Fqwcn4X?=
 =?us-ascii?Q?QpCXUCXJXFSXlCestZUzpFpB5WOl1KmpSP8Mz7VvbXcwWDdVlXzKCbPrsUCP?=
 =?us-ascii?Q?igbR8G9c1jwQRvdBO4rmfvYZ4Pvsl/C4hyUWHbYlBvX+/1rtyXrtx3lqKr4n?=
 =?us-ascii?Q?0AdlMN7FtDH99Gp+wHdLOZpPL5tQSbg2AaKx5L6nHO2kWdhnOw8Y+XnnRI8F?=
 =?us-ascii?Q?XTl3zg9bHxz0phabpf4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a120248d-c303-4c37-2baf-08d9b39061dc
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 23:31:34.9182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GzI8/mSkYXICL2FAC4r6xn6fLgB0CyPpVBssGoN/KdITybX902bHKRE/skhT9anU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5191
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 29, 2021 at 03:27:20PM -0700, Logan Gunthorpe wrote:

> In most cases, the NTB code needs more interrupts than the hardware
> actually provides for in its MSI-X table. That's what PCI_IRQ_VIRTUAL is
> for: it allows the driver to request more interrupts than the hardware
> advertises (ie. pci_msix_vec_count()). These extra interrupts are
> created, but get flagged with msi_attrib.is_virtual which ensures
> functions that program the MSI-X table don't try to write past the end
> of the hardware's table.

AFAICT what you've described is what Intel is calling IMS in other
contexts.

IMS is fundamentally a way to control MSI interrupt descriptors that
are not accessed through PCI SIG compliant means. In this case the NTB
driver has to do its magic to relay the addr/data pairs to the real
MSI storage in the hidden devices.

PCI_IRQ_VIRTUAL should probably be fully replaced by the new dynamic
APIs in the fullness of time..

> Existing NTB hardware does already have what's called a doorbell which
> provides the same functionally as the above technique. However, existing
> hardware implementations of doorbells have significant latency and thus
> slow down performance substantially. Implementing the MSI interrupts as
> described above increased the performance of ntb_transport by more than
> three times[1].

Does the doorbell scheme allow as many interrupts?

Jason
