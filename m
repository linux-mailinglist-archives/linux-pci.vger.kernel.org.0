Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABE0126994A
	for <lists+linux-pci@lfdr.de>; Tue, 15 Sep 2020 00:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbgINW5w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Sep 2020 18:57:52 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:12388 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgINW5u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Sep 2020 18:57:50 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f5ff55f0000>; Mon, 14 Sep 2020 15:57:35 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 14 Sep 2020 15:57:48 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 14 Sep 2020 15:57:48 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 14 Sep
 2020 22:57:43 +0000
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.53) by
 HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 14 Sep 2020 22:57:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DzJJ2MuTa6Fan+voO31tFp/fyF3Q4HIH6WmSITV11HXzhk2P6u+JThawG6nSvmPzWLWYnrhNPGOyKTyj46VFpEbOVyNqn9uadnLgp5i6fIXhfsMjRsFJyYS7krZEntZKlpnDK9vJvKQ1StrQh0JsU5gWZlNWVPKwgh8ba9GJXdaUArQa07xVvAQj85HSVBxvrjXnln3+w8ayTdA89iSzjfg8FCCzKSW4ang0fb6sjJsH9HpZGeVi5aIlOQfm+HH3dTnnBYKyIeNNXypT+uHamnD3IfuxGtvsYTJoykQiMLnZ4c2BeyT4f3mepZ98YMXRucNJEh6BLTBmYIUHnEm3xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ndCZ9heAVa2vm6L29QmuwTAxMLAHd4yKc0UxZ9RTug0=;
 b=DzEd44M3grjvkejDxghYjFXkRmluXwJLkvkXLwrnI9OFLiSTbWM8bX/PWfDPTmqZYFN4g6xEESwaYi9YxXfT599/mvyaQnDRdEm/5KM9nKPSVFzYQszXsMP74SY3cji6OJyPG7BmHQd3ahoTZdH76RUAqs0s3q/MKRR6sDCBAgSKVDTYHmXPjqApyJCpn683BOM+yknr6IGTshr0HSNuVse0CgfwKg4eSvJs8p/muLCSi4qbMF5fpxfqK4CApO9alAIwaF9W9iGKCxIZC0OlfdB9S7W9Z2EawP3HkBgvYtwwIvFiLcSPEuxvQeGLt1rKyZT3hiz5UlWhN/pp7T8ehw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.crashing.org; dkim=none (message not signed)
 header.d=none;kernel.crashing.org; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1241.namprd12.prod.outlook.com (2603:10b6:3:72::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Mon, 14 Sep
 2020 22:57:42 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 22:57:42 +0000
Date:   Mon, 14 Sep 2020 19:57:40 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC:     Clint Sbisa <csbisa@amazon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <will@kernel.org>,
        <catalin.marinas@arm.com>, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH] arm64: Enable PCI write-combine resources under sysfs
Message-ID: <20200914225740.GP904879@nvidia.com>
References: <20200910171033.GG904879@nvidia.com>
 <44acc22377958a57c738f5139c5b5df2841c2544.camel@kernel.crashing.org>
 <20200910232938.GJ904879@nvidia.com>
 <3110e00a1f4df7b7359ba4f2b7f86a35aa47405e.camel@kernel.crashing.org>
 <20200911214225.hml2wbbq2rofn4re@amazon.com>
 <20200914141726.GA904879@nvidia.com>
 <20200914142406.k44zrnp2wdsandsp@amazon.com>
 <20200914143819.GC904879@nvidia.com>
 <375c478593945a416f3180c3773bcb5240d2e36c.camel@kernel.crashing.org>
 <1d6f2ceb8d3538c906a1fdb8cd3d4c74ccffa42e.camel@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1d6f2ceb8d3538c906a1fdb8cd3d4c74ccffa42e.camel@kernel.crashing.org>
X-ClientProxiedBy: YT1PR01CA0077.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::16) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YT1PR01CA0077.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.19 via Frontend Transport; Mon, 14 Sep 2020 22:57:42 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kHxPo-006H6h-HG; Mon, 14 Sep 2020 19:57:40 -0300
X-Originating-IP: [206.223.160.26]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a5d29f7-d072-41b6-df7d-08d85901961f
X-MS-TrafficTypeDiagnostic: DM5PR12MB1241:
X-Microsoft-Antispam-PRVS: <DM5PR12MB124117A0E14A6FA94BBD6CDEC2230@DM5PR12MB1241.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2/V58Z1VmI0yt/uR2vGh0EoPB3lWDg9tiHxo6Kas0wvBjBnEEg5uFDlaMBzIk6J6MBKB1H3swN/bTJa6X83BQ4uj1IclhGP0QOa+nDAn3ODqfWUzipmTe0+2bFwHFMqHF0pxeIL0pgMlsM6mme6SM3MtU+GcHgV3wnyi/mEojceKQhBhJwQicU1vuq6AnG+b1QoLd1ZaAGMGCRWDogcX4ysfR3n5uYzgWC3QtV5BA8RF5VKZfxujrS+PBIZ1m+9MOtEFQTbhLqsn60573hVxqmZKwAb/4sqNXXjeQoK28wVOwXlLff+2bRUft80If7qPs18hFBZa84cnvZ04mcZdsNAhwIRqa9dfTjae1Sf4NQWE1dNIP9atFiZxmZnVEOCW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(4326008)(316002)(86362001)(54906003)(2616005)(478600001)(6916009)(33656002)(9746002)(9786002)(66946007)(426003)(83380400001)(4744005)(2906002)(8676002)(36756003)(8936002)(5660300002)(66556008)(66476007)(186003)(26005)(1076003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: lM+UhX346u0AT71D97x9iBWv3nTeml49J5bcFIaASymjSup0XbD4VFXG0RUTSNNY+p5io+vDyEYKf/Y6q87bILiMm79H3pdN1WTn+S9AFQ4mMsFfbR//xOoy5UZpeF55XAvOsoHtIlsn4YJO8yZ724EpTH8vSI/AhklnlRyldj4QECN+2tpmW5HNNFIGYY+lRY+o5oWQc2kdA7yVaN9GdesIzEzsHG7EtZrGdUhYxU5LWYR+CwJLZbFePiu/REMKHepoOJjWs1IEx5QEdqoTXqZeKYBOXK1WbI9/VTOKREmvXgi4/nOKSjohnsH/CrJYmJwIklTla1mUxuUqvRVAvZ4DMXZ6kx2zU1QXJENogA2l5j48aRFSXfbhKV1/Utu+Q07yXRoPftqnkoyryNwzYY33AisLp8XHVu/qrKdjCOPYvusR2BdieZgcLMMMeIZb1TJOgd45OQWWODbKvveXnPXoSjERPKnPp7rfX4A0GNrVCNT6RdTV7nZrI51yJxVGEuLD/yUvQmfRuSXrb8lx6gIrM/JXhvlpld0W2nKus+eqQxdwqz41jip7JMSZHjHoSR3aexy9ObCzGxMPEXHMO0JS6vCsaYteRF2OD7jGPuggkby8R29PHN7mxlBkmLMl1XvyOrVHtCdAl4X8W/kQ/g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a5d29f7-d072-41b6-df7d-08d85901961f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2020 22:57:42.4094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6kB0MSpJwJoezgpPVJI6nxEAmLu2nplhv2B4X7F7RS96uThGBxbhVP66ZoA68UYS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1241
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600124255; bh=ndCZ9heAVa2vm6L29QmuwTAxMLAHd4yKc0UxZ9RTug0=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-MS-Exchange-SenderADCheck:
         X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
         X-Forefront-Antispam-Report:X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=WsHwRrL00VNGjlqgWc/XLDyiQZGV+/ZRCbNDjzo+X5TWhqqOPSoii6soYBiJ15HX5
         SN5oHvJkymy5eACjEspz/VvQSLt2KJXInEPPPDQJxMudauHeRLDnPcDtfRKnMKvGMU
         6CJj2V4WtlxHcZDouzqUmraaLhFYuNhJn6P93yGhIgLRmAe1RHBsKEg7TeZHYjaz1j
         xTQZwzZ3EkOG8URBsYhi8Xs9wJ1tyUkOF2mW6lepgEtsVFeUVZxWm07W+J6QorjJGS
         BeqZQSfL6Ow46yBrlcyQBtylWwdNrSwglh1wY6RL5n+ZfKX5lYgvZ4vgKGTldZhl/u
         LMgddwrc8zY3w==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 15, 2020 at 08:00:27AM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2020-09-15 at 07:42 +1000, Benjamin Herrenschmidt wrote:
> > 
> > > which is back to my original question, how do you do DMA using
> > > /sys/xx/resources? Why not use VFIO like everything else?
> > 
> > Note: All this doesnt' change the fact that sys/xx/resources_wc
> > exists
> > for other archs and I see no reasons so far not to have it on ARM...
> 
> Also... it looks like VFIO also doesn't provide a way to do WC yet
> unfortunately :-(

Yes, but if the driving reason for this patch is because a VFIO user
like EFA DPDK is trying to work around VFIO limitations, then I'd say
the VFIO mmap should be amended, and not so much worring about sysfs.

While there is no reason for ARM to not show the sysfs, it really
should never be used. Modern kernels in secure boot don't even show
it, for instance.

Jason
