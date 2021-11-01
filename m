Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89EDD441FD4
	for <lists+linux-pci@lfdr.de>; Mon,  1 Nov 2021 19:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbhKASNE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Nov 2021 14:13:04 -0400
Received: from mail-bn1nam07on2059.outbound.protection.outlook.com ([40.107.212.59]:15330
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229990AbhKASKa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Nov 2021 14:10:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NX+VmcWZTts8e/zTRZBNeJY1x7SqtnCFoAxUynHngOrXNvAxoXrQbTztTBR5nsUOMTMiIlR1QZRRiVv2cxo0gP+k25k3fOmg+9o0VfCIS2oVQJ3qcRAv+dh+1bfxBVmde54MfiYC0PElHtc+SCLx2S0roOKxcC2ebTQUnFew8fFv7SxP3Uewhcn9TzVUTs8MmGdHaLV86Vdn76d5+V8z288n43/qD2rNMHEOdXc9vwIl92Qv4Zzn+2q0BLHbhHxl1YaJm0aB3S5av3C82MNUBFb+y1m7QWG8NYPXbzE+2obV3MxIGG7wQ/a3ozBJz9wDCuR1YXsHRat8E6srd79pzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AV+XNr2BNqjAGMI/ur+yX8ZAvineZp8Omn0riZyPAdY=;
 b=Y7gf1tm5H6cD5SwkK4yWvZADazTWRg1dX0ESVQ+rxV0kEi8vzhI6HrFJmNDmwTBed0My9xsmuMWMnWkDxcPxiqNe3JabVTbzUVvjfbtmHhwzEa4u8Q2PNwMRTfAOsqDaPVyUAScJFzxJPwWI5X8GaT+a+1jZ3N9KonrDQF9kfwYOyx6IX54Zso/Rf4k82PahFCtwLWOXmwZTP+d6dJG7izMbyKcrv5J1HPukSFDSxEUdYjmfFQEsB56WXEbioHTK3XDAaCj4txuzEgd9GoDAdQigDtNZeKs+RHwlFgdYqaEcJ8kvEuOfN0UeQo+mJi4So2TWFmW+vCi+iE8chFYpzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AV+XNr2BNqjAGMI/ur+yX8ZAvineZp8Omn0riZyPAdY=;
 b=G6xcHn3lzuRHAhJuy/rDrMHwkCcf7WYS5uMr1N2pMDN8Ld22RFUrKy+LZZJjHxVZK3cfzKpyJ/n5WEmDoC7M4bdqCDowp5KRmq3id49cJCy8/25FEBZaMv4c2VPYiPeM/OZQsgAvijGm5gsbTpgGNOCVQNj4qYORT8AJzAuedC8mZIHTczmgMbbdfvq+waSfOZQvO6rS9GME2VDawCiMtN62Y2mUvvIgVhudlOc/lG5ogYsApiFprgW/xKjuE+NpyfC3+MgGYZRuZnLirLBs52/bxRgJ8VhjqjtgxoNruQ0lvVOsASHBivfjRLBqkCSq8zDIZ+xJ1cGD1J4Od/tlLA==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5335.namprd12.prod.outlook.com (2603:10b6:208:317::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Mon, 1 Nov
 2021 18:07:33 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4649.019; Mon, 1 Nov 2021
 18:07:33 +0000
Date:   Mon, 1 Nov 2021 15:07:32 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Stefan Chulski <stefanc@marvell.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Stefan Roese <sr@denx.de>, Phil Sutter <phil@nwl.cc>,
        Mario Six <mario.six@gdsys.cc>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [EXT] Re: pci mvebu issue (memory controller)
Message-ID: <20211101180732.GA1153697@nvidia.com>
References: <20210219174406.2kioa4ikeippgwou@pali>
 <20210304182908.GA858065@bjorn-Precision-5520>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304182908.GA858065@bjorn-Precision-5520>
X-ClientProxiedBy: BL0PR1501CA0001.namprd15.prod.outlook.com
 (2603:10b6:207:17::14) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL0PR1501CA0001.namprd15.prod.outlook.com (2603:10b6:207:17::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.19 via Frontend Transport; Mon, 1 Nov 2021 18:07:33 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mhbiW-004qBg-Im; Mon, 01 Nov 2021 15:07:32 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e528513-5806-430a-3fe3-08d99d627a4b
X-MS-TrafficTypeDiagnostic: BL1PR12MB5335:
X-Microsoft-Antispam-PRVS: <BL1PR12MB53354C5C760E96419BC833F0C28A9@BL1PR12MB5335.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zIkqT+wgtTwy/AkaKCbvuZKdxi7KZCvtV392+C7txCtxkhR6+pa/tq5BGjRzKuwpJLTBIcCNVYKRCudoJzKAjuj86w6yheERMnNrNJD/LnMvG40b1XKXGrx2HH/ink2aSE0Np/Yu1lq0wANT1TzzvH//LNvztLqPeQ658HvBl3BIv6w+PXFy2b2o+wawiC1o/HxXV4A1EBeHRHb99g2BZ24yekqhs7daZ1cuzBnjeGxxpeoq4gbPP6u3cCXwLtHp6hVibRdAF/A9p0Gi0FtnDpvDeQGy+OLOjbn4MAT/9wjqQkcoKL7yYQpw7AUZRh1W6bZjVphvPtNNdqyHfNLpQJep3kQExwxyD7JQsqV1msOHnKMP6eT5bZok2OgMpyNThLQXFhy2firg+W9xtS5AiPRnAvPLzlvHxqvkUUssZEvrWko2ATDuERk0wavKOquY3dz9nlJMSX4ydJlB7iiV20AzPbsMloF4Sn/U/1N+O/ykl2+8C8Oy82CMIf4tgjoNs62xpI3BydyOrkYR3G8q260q1IziVDeDEX0TuXyiOaZs9COw9ghAZvLB6QHliK5Pf/JidxGQUQB6AfZzJA3B+6xCaLXU/6X14UEPB951IX70y7MooDNeLkbrnlwRRWKHslPvTIw6n518Zqmsf6DilQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(7416002)(83380400001)(33656002)(54906003)(2616005)(4326008)(86362001)(36756003)(26005)(6916009)(66556008)(66946007)(316002)(9746002)(9786002)(186003)(2906002)(508600001)(66476007)(4744005)(38100700002)(5660300002)(8936002)(1076003)(426003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JAGHBPngIgv7r2ojmT0ja9K79iXTlQEvZl26SRMKCDMVQZgbZTE6PoGTfVF1?=
 =?us-ascii?Q?isupCVWyENhFkuyKXWX4B1SnPJzS0znOtJEDE0sOtT5IvyPjLoXufFQYxzyo?=
 =?us-ascii?Q?+6BcfxuLr+JLYe4zJI4E1LRxZrpvbiRTpfgAlEizd3v4uO9sTMmZAh0S/V1e?=
 =?us-ascii?Q?YAUwuW8RN7MSkdC0LcxCJu+/EoyHAIt36hKP9obd8zl2iWAOyevfxI/uixsU?=
 =?us-ascii?Q?KrlOJXCyrx7GUF4xzCUgHLwQByigd7OIjTsT/RP3+U/6TXHvQJ6a8DDB6GK8?=
 =?us-ascii?Q?ypUs4rQopkq8LiGeHY76MDp6vE8rCcq2rjIZd0GRpACY3td3SfZt1VD4NWj9?=
 =?us-ascii?Q?lL+9Wd0Dg7lEOc1ECdq3vpyRbjxsW4f+2fJrKHLwZT1pMRrxLXKgy9hZ5UaU?=
 =?us-ascii?Q?dgygZpfK2RLgXJUuFug9/VX64Wnq9E2m2450amIJGRpXD/cMZ8bY6NoeJDAl?=
 =?us-ascii?Q?4nSUAz3u2XCENBki8ea6Zg+azECmyLMDpKKwdsiAs1n9y8bP+6xjSaZPoQLx?=
 =?us-ascii?Q?IOcSyws9UqyaqrOnmyK21gWobLZQng7o2fl801hfylfhZ2Daz51R2T1AFW/J?=
 =?us-ascii?Q?aCgVCi69LwrIJrGgnbgsX7BB+U4wHlSzjzN8jCfczdAawWGKII3Wz9ToEmOS?=
 =?us-ascii?Q?7m114MhKjBo5OlcVBXEbdTtnkHOBAG42dt0K0EI32FD5VXPZDBe5J3roQsMo?=
 =?us-ascii?Q?paYUOLPWon0daEqxQqtceRJtUyxOWWx/787fiAS2cmFNHFeLWROgJx+PBB6s?=
 =?us-ascii?Q?XRi0If18Cw/E/pCOkfkkmTnvX08DZyslVEzYQ9vXTJ0yK3Yln3Vl/TaGdsqp?=
 =?us-ascii?Q?0s/1dLLs3T/OUWcmTf2Z2ci3hldaBLFmWf6BWlUn1ukkBknHv8AgUNMQDcGw?=
 =?us-ascii?Q?UpGHpts7KJwc0m2w9tqjsIOT7TFyWJ0xu4JBmIZFWY2MNtsgC7m5j8wE07D9?=
 =?us-ascii?Q?Vx7HKOJoL4Vu6oXCgmY7hmJp4EldUKPX5k7JV28H4A5HEYhrSXQRixWz9plX?=
 =?us-ascii?Q?L+3/DmJ7JaTUOE6Kg7lG9LEWuXudU+hgvLq+dNWLafYVPUEWxeS1Qn20YiNZ?=
 =?us-ascii?Q?jR5NdD2LAURXmXrMB6z65VBqkJaTZbKnmb3ORrxahDMypNKqnnSAlJqA9GvE?=
 =?us-ascii?Q?JcdPpM6hPe4vKcW2qQmFKR0k51s9Ia9p6oaRJajy4IQqaCmBNxpc78dceVO/?=
 =?us-ascii?Q?ijUIzXhEo1PWAkBJClWIi3KB6CXL7oX2GPUP4J1NOAWvGw0ntU9lYRjBQRXT?=
 =?us-ascii?Q?gvHkmKeB0N8G7I/oNfBFbc3wLp2Z1uQVyfSXqC9RX7auFo7K9bKsAWnLkIpY?=
 =?us-ascii?Q?SsE6oOxOPfCiiUOlbK5/aNqWQ4PwfNZuxx2I8lcHIj5pKUCl2AUim1Z1rtwt?=
 =?us-ascii?Q?LqhV4N80P44k3nho/hskjjAtIDf2GX9SYFbQBi2b7Qy9IhOYuum+fsIcsNst?=
 =?us-ascii?Q?Ufds2kJyriWQ4hLcUORvbyCsE1XA6FueojvpMI4uuUlXDf2n7nVKpEcUPW3l?=
 =?us-ascii?Q?2Fs5bzMdCgouXkRqybe3iHn3E65OB/PKIdCfbT/wOEpF75v2QOKACEhrBYoK?=
 =?us-ascii?Q?TUQYa1vNRFxyl6EC+uE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e528513-5806-430a-3fe3-08d99d627a4b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2021 18:07:33.6979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: INJlA1DQ2yQgXlc8VmSv0ZLbMfFHqO1BRmvh+NPwiimKCBetiVSY/bO1XCkHGS53
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5335
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 04, 2021 at 12:29:08PM -0600, Bjorn Helgaas wrote:

> That's not much to go on.  Someone with more knowledge of the actual
> problem would have to weigh in on whether hiding a device is the best
> approach.

Since Pali asked..

The issue with this HW is the IP designers took an end port PCIe core
and glued it up to act as a root port without changing anything. This
is why it doesn't present a bridge config space. It is a *completely*
non compliant design.

The pci-mvebu host bridge driver is designged to fix this. It provides
a compliant PCI register view for a root port device using SW to
inspect config space operations and remaps the config space accesses
to their non-compliant positions within the SOC.

Hoping that the PCI core can directly drive this PCI device as a root
port without the above driver is just an endless sea of hacks.

Jason
