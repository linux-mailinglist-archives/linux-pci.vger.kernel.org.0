Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE7E265581
	for <lists+linux-pci@lfdr.de>; Fri, 11 Sep 2020 01:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725275AbgIJX3u (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Sep 2020 19:29:50 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:21470 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725290AbgIJX3r (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Sep 2020 19:29:47 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f5ab6e70000>; Fri, 11 Sep 2020 07:29:43 +0800
Received: from HKMAIL102.nvidia.com ([10.18.16.11])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Thu, 10 Sep 2020 16:29:43 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Thu, 10 Sep 2020 16:29:43 -0700
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 10 Sep
 2020 23:29:42 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 10 Sep 2020 23:29:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lEUXzyL69GsM8o6pdzF2S6i2+bRbLqm4/YnDcvRRX+iGVMYU5eVQQxYYKsIPAuC+jGTRxEaJ3gdSeSkgwvnDvBn8CUC7eLqc6OEF33psPqWZkoAPe9mXrnHMRUzqPccaKDC6qGLdf2Y3Y2KYeFUbH8n4bTnXF1QVwNUx+EiPJSDznoXtqqfXkykXopI9auKAMw+oPTRBB+xR4H6JKfgzRzfo9uLWReZtQhngv20s9X1kLhNecSGlOnBvg2f8qnMTn04ccbGzhxE+u4o3zyjNvQhUkPbQRGkEFLdnRnKsOLjWIw+5wuj7NBAGHFfIt+wpc/xHwc1xs+kuENuVHK966Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qbge0rVnqWvNd+sUc1X1r13bcqgspX6WhEmGgIukYaU=;
 b=N1GIKd8PfT7r56fU14t7+Vk6ox9tVGbEemII2NvOAw6aI9v7dbBOGI8WLOtHopirlvOJgdG0awv9cOyrM6yJFNqD9ez8zE8plFUZv2mxu/Sa+wl1yLsuL/LP+/tD7XVI5EdXlfoyRr3R6dUXYA+gTaqDR/N1tYAcD4Wk0is0NappUOVBCSbpcFqC7H+xrY1ourljB3U3EsqF+pQDQov7oduLns65W+oGVwgtQhrrBpsTW5DKeTh8XcrdXkRSCQ5PgD+ZsxdOtpDW9PSrV3GkXYd5MvVx3khy7cd4Jvn6Xigj/3rZtqtQoiMXGiOnDLo5qZpmJz6fH+laFMteMDl02w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.crashing.org; dkim=none (message not signed)
 header.d=none;kernel.crashing.org; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1339.namprd12.prod.outlook.com (2603:10b6:3:70::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 10 Sep
 2020 23:29:40 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3370.016; Thu, 10 Sep 2020
 23:29:40 +0000
Date:   Thu, 10 Sep 2020 20:29:38 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Clint Sbisa <csbisa@amazon.com>, <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <will@kernel.org>,
        <catalin.marinas@arm.com>, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH] arm64: Enable PCI write-combine resources under sysfs
Message-ID: <20200910232938.GJ904879@nvidia.com>
References: <20200902142922.xc4x6m33unkzewuh@amazon.com>
 <20200902164702.GA30611@e121166-lin.cambridge.arm.com>
 <edae1eeb0da578d941cfa5ad550eb0a0eda5f98e.camel@kernel.crashing.org>
 <20200903110844.GB11284@e121166-lin.cambridge.arm.com>
 <28d333afc73bd854390f8c39691a735040ba5b39.camel@kernel.crashing.org>
 <20200910094600.GA22840@e121166-lin.cambridge.arm.com>
 <20200910123758.GC904879@nvidia.com>
 <20200910151721.GA25809@e121166-lin.cambridge.arm.com>
 <20200910171033.GG904879@nvidia.com>
 <44acc22377958a57c738f5139c5b5df2841c2544.camel@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <44acc22377958a57c738f5139c5b5df2841c2544.camel@kernel.crashing.org>
X-ClientProxiedBy: MN2PR07CA0026.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::36) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR07CA0026.namprd07.prod.outlook.com (2603:10b6:208:1a0::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 23:29:39 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kGW0Y-004dMS-Ue; Thu, 10 Sep 2020 20:29:38 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86d3c991-0ae7-41eb-7dc7-08d855e16397
X-MS-TrafficTypeDiagnostic: DM5PR12MB1339:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1339E4C5E65F613840BC96FDC2270@DM5PR12MB1339.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d3nJ+McnDll3guEfqX6xjGO+4KsrjWcys7jJeRxZwBYGwEUkXfBS2OuiAC3X36cP/82AMZpEGYGYUk6Jvnd3uiXt/NMvL/VGbP9q2BPKnvciLsEnNqXeDFLGabmrEzi8lHy/GbEJ7wmsJaRpUD43gN3mftRNfmZccR6W4qKB3iCG1TjHFENWSLweVio/aSv3bnIcLt+9i2yvpktE0Y50F7bECy/ER0q1CR2QNAkGBAD9PcK4ntaDchNaVcQrih8ZlOyMrA3WPhqk3rHT3VWzhx/zIydWgoZukDTU7V5MISG+OfVU6Uqhe0VIGpEcNiTruHZKCYhqaylZ5DbgQJeh0kWNeolYTItw14KA5S85F2jEjFunBq7B+02+KN2INjjU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(396003)(39860400002)(136003)(33656002)(478600001)(66946007)(54906003)(26005)(9746002)(83380400001)(6916009)(66556008)(86362001)(9786002)(66476007)(36756003)(5660300002)(8936002)(186003)(1076003)(4326008)(316002)(2616005)(426003)(2906002)(8676002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: bElW6AAf5OgfktZ8+6vGs0RF5Bt6Ozn1I0r8cMU7IsHUJ6J4FDYTp9zn/8G4XKTpNUUjNaUca5rRHFqiC/956Zj6fIl/k2ocuXtnx0kGT7HYe/B7uw9HNDV1dst3jznhDrbV2X6QvP3qg8q9pk2PsCqzeRLccpAB6P/7kBHAZCQ2pOYdsIApGsOxwgSM/pSFfdBGAaQWMTbebfn/t/lZUirMUcThR4iTQWqwi8R5qwzfMEiBRqJTmJVtf75Z92uT+TqZrbAa9jN/c2JSQEuglz8kmKpL5s0051ZeTrB5NrxMEBHK25ip4dYZNMGdFIrkr+f50sg00QXp4X6+reX7tK8sm1Y5LH/ajan1VSSvHQAXhm0SIeu9vqzpAEKQjU1yZ027EF3clVo0moxiPK0IqbDNgc2dvwI4ZadgF+y5gKqylsPh+VT0lOlcKwCeJ99t0H2EKK8/RMFP3Vafi4XRduNU0W55xLOjVISNrMnaTMAgcekTn73zwrF+nfCYIHlsudB6UH6sLN+awR5CcqhR3jRwFnSm9t9fFHIWDeoBu93zoZYL8Z8IXJmapWdZiS0FoWvFkhxjagXBCXrmKBNhgz4zmAGvwJYm7psV0RBzBTkEHbqnMEZ2kw/+7eXUsWa+sAwuf5ptZ6zzUI2fJXVbwQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 86d3c991-0ae7-41eb-7dc7-08d855e16397
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 23:29:40.1559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6tULZlzqmjVsJoR3h5mluoMqxR1PBelKZJLwmgralUal7lB/YB5SIokT0THNGAtl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1339
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599780584; bh=Qbge0rVnqWvNd+sUc1X1r13bcqgspX6WhEmGgIukYaU=;
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
        b=RGeCakC/vm3j1lGVc0QsHjNhlxLL2gR4k5Xp7Xih5V0wRu/E7L3jfbzjuTAhfGC3o
         sFn7WizIBbY7BsmMESWwoIqWg+sVCjqVmfLZfVF0HeGo2S8Qpz1MAbmW4wWuhxtYE3
         DmghrCQLA4zd1RDZJ8D5bHVuhr4Xk+gM/UF6+zHOHOyXdun6WfctItNst70WTGiHLc
         I6s84loPj2TV2OpzCFwjcsNdGDDHOrbpK5UmyV7ZU/qwjf8K/OGsvP/kelTxx0s+nc
         QEp5I2evFlGfKK4Q4Xrsaq31r/Ylc5w87cNKhapxmDGO+5I4yep3ub5H1i+dOrdL9H
         HU+98aBGVIQOg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 11, 2020 at 07:46:47AM +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2020-09-10 at 14:10 -0300, Jason Gunthorpe wrote:
> > Can you explain what this actually does on ARM? 
> > 
> > Can it ever speculate loads across page boundaries, or speculate
> > loads
> > that never exist in the program? ie will we get random unpredicable
> > MemRds?
> 
> Probably, at least on powerpc you will as well, that's the only way to
> get write combine.

If I remove the PROT_READ in the user space mmap will it block it?

Read TLPs are not harmful but I suspect they would cause an
undesirable random performance anomaly.

> > Does it/could it "combine writes"?
> 
> I assume so for ARM, definitely for powerpc.

Various IBM PPC chips I know work, we do test that.

> > > That's why I looped you in - that's what worries me about
> > > "enabling"
> > > arch_can_pci_mmap_wc() on arm64. If we enable it and we have perf
> > > regressions that's not OK.
> > > 
> > > Or we *can* enable arch_can_pci_mmap_wc() but force the mellanox
> > > driver (or more broadly all drivers following this message push
> > > semantics) to use "something else" for WC detection.
> > 
> > arch_can_pci_mmap_wc() really only controls the sysfs resource file
> > and it seems very unclear who in userspace uses that these days.
> 
> dpdk under some circumstances afaik.

And something gross for DMA then? Not sure dpdk is useful without
DMA. Why not use CONFIG_VFIO_NOIOMMU for such a non-secure thing?
 
> > vfio is now the right way to do that stuff. I don't see an obvious
> > way to get WC memory in VFIO though...
> 
> Which would be a performance issue on a number of things I suppose...

Almost nothing uses pci_iomap_wc(), so I'd be surpried if userspace
DPDK was an important user when an in-kernel driver for the same HW
doesn't use it?

Jason
