Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFA9526B541
	for <lists+linux-pci@lfdr.de>; Wed, 16 Sep 2020 01:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727371AbgIOXkr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Sep 2020 19:40:47 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:50217 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727363AbgIOXkR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Sep 2020 19:40:17 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f6150dc0000>; Wed, 16 Sep 2020 07:40:12 +0800
Received: from HKMAIL103.nvidia.com ([10.18.16.12])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Tue, 15 Sep 2020 16:40:12 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Tue, 15 Sep 2020 16:40:12 -0700
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 15 Sep
 2020 23:40:11 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 15 Sep 2020 23:40:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nfR97CnmhIc5XXwqRcD/A3pC8nRM90WP8hK8iWtyds9TLsCG7PDCIxV+OLSQnqjhJ8p9U594ydx8aKGzhpIrL5yvP1hMEHHtSZELp0ALuZTg+R3j80o+Q3GcQlezzRkUYWg8fTsXl3JXgErL4oMTwWNRb7d4++baKd3GkW+0RYzGBuES4D9FqeWlfcfjj3h9QJfRsIsFmadKMtumUZvwDzWYn2nPZ5F26ipOHz1ef8/rsg386CobSYfxaj8K4Y7CfZC1f+TuIZ1CHdB5fgfiPtI3dKKL1DsPJgn85VQbd/MscBGOGby/rPmX+FBaUdE3o9VDdZWc/FfOHKW9u40acg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVuz8wEZ1YEdLMl3zvuMowNDfNHGdYX4FQGfe9IsCGM=;
 b=NKKgG/1bbUCd/XhCk5St6CHyI9CER7xJKjS4uzpZKfcU/8np9OoETWf7LIxrvZmpx15EW/gG/PwP8Pw5IkZ0kb6X721A2dZRb5bPyDqh2Zfzz+JrOczXgV+yWS4z5w3onfc8uP+ZMpEEzlmYoxVtUX9trXI0Vr0ZurdS3bgShviB7l6M8dOCgHW/rCLymTHwRgcrGnXhzIL3eTLdJt29nqRDF0S9I+dnX01+tBcBpIR/d6heOjuplfos/nex+7/53/1RH7yLHggAVKxo7FPlGImDiNZ7upo4YPCcnOKtaAdMVL+b3K0hdrJBVRBCUpHfuEShQTknUSleNpi9tk9Z7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.crashing.org; dkim=none (message not signed)
 header.d=none;kernel.crashing.org; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3404.namprd12.prod.outlook.com (2603:10b6:5:3a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Tue, 15 Sep
 2020 23:40:09 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3391.011; Tue, 15 Sep 2020
 23:40:08 +0000
Date:   Tue, 15 Sep 2020 20:40:06 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Clint Sbisa <csbisa@amazon.com>, <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <will@kernel.org>,
        <catalin.marinas@arm.com>, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH] arm64: Enable PCI write-combine resources under sysfs
Message-ID: <20200915234006.GI1573713@nvidia.com>
References: <20200914141726.GA904879@nvidia.com>
 <20200914142406.k44zrnp2wdsandsp@amazon.com>
 <20200914143819.GC904879@nvidia.com>
 <375c478593945a416f3180c3773bcb5240d2e36c.camel@kernel.crashing.org>
 <1d6f2ceb8d3538c906a1fdb8cd3d4c74ccffa42e.camel@kernel.crashing.org>
 <20200914225740.GP904879@nvidia.com>
 <2b539df4c9ec703458e46da2fc879ee3b310b31c.camel@kernel.crashing.org>
 <20200915101831.GA2616@e121166-lin.cambridge.arm.com>
 <20200915110511.GQ904879@nvidia.com>
 <bcb95faafa72734478b942084a9d24a61ae9887f.camel@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <bcb95faafa72734478b942084a9d24a61ae9887f.camel@kernel.crashing.org>
X-ClientProxiedBy: YQBPR01CA0090.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::26) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YQBPR01CA0090.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:3::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.13 via Frontend Transport; Tue, 15 Sep 2020 23:40:08 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kIKYQ-006jFg-KY; Tue, 15 Sep 2020 20:40:06 -0300
X-Originating-IP: [206.223.160.26]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 684e5d95-d874-40ef-c130-08d859d0ae4c
X-MS-TrafficTypeDiagnostic: DM6PR12MB3404:
X-Microsoft-Antispam-PRVS: <DM6PR12MB34047E033602D19FD0B03FC8C2200@DM6PR12MB3404.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TxjrPnJruPbS7BmSpfXtA9RkZVpjBqdCx27Lt8H+vYXyfcG0JmiVYk13PvGWhBtIVCtD+qD+LnX2XIdJvMvZHx08ojfbOzglWiSXe8QNC1TwTxfsmsuS/hD3FYmSGXV1S7ttxnPyEjo2+1GAnUGfd0cTWWszAAJ4FF8UQ4nz0Y7OyzKccECU3SwrtSLV4jnyRdxQrvZXdF7+YKs6WPUg862KwwjJxYktkEJ58mgy1SgaevL0hsTfdRlY4ABzO43vnezKK//d/w5Pz+nP9UBjfUwPbPZo2WgiWCqw1hO5Nto6yajD5kgeXs/7+AN5yRr7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(366004)(136003)(39860400002)(346002)(9786002)(2616005)(186003)(9746002)(26005)(316002)(2906002)(478600001)(426003)(8936002)(4326008)(83380400001)(86362001)(5660300002)(66946007)(8676002)(33656002)(6916009)(66556008)(1076003)(36756003)(66476007)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: jnEtzEElrP3d7GYAzUre6TBs29hH+Rm8xpQ1CNdBkClG6Wbr0Ytiq1DpZjvauSszdDgLGooKWh6KhjzdoJEY1Me8fpVwHDQznhi4rn405cJNJXbhrtSlIq4UVwe2uW0L3P2tzzEFIOdTbCzEL1/RhchqfG9vaS3zUPQluEUjbSI6eejO5/c95eUlkSuyA7jTZt1spsgoFEMVzGz+yca2NVSQdmS4+z9vOSeXs0x+BeWuwfsmsI6PxlIq7Ifk/LQLTgTPBr+Mbpp7EjRB1B1gb3DONTAy8Z2jaUuI2jNqGec8GJL8wTk050PFAHavp+vzKt43m8DKdhyRxAbDsjBXxlJEYsuioL04fCaKLyJJmQpY9d1nJR4d0xdDp2T4X+wq11e8Ho38oGIzDe7jSaOlabMEJ7wK6nDDHx47u5a6hzDKHePnX+llK9XT75jovFUcj0ZEa2IlIvWwfcGAhFYIYZNMPKMagmeEYvunuCmHMm/Xwcbcy8qUnD1DD91+fkXuEy0ta8JODlCQosurqRpmtDxjsvnAQCINqvXQcuS06ImenX+xjncRHvE5hhvzi8MHOReZI/xFzemEBAOpv/PBuRX0T/4DPOnhlKg4P3RD2diKi71VIyvWcwyrqq2EUrSAk9XIHi8StsWWg9Al2E8kjA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 684e5d95-d874-40ef-c130-08d859d0ae4c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2020 23:40:08.8168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b8fnfTOVhu549wOc0qIEc1yIv7TFyqPLJrSlr5HMHqIm+toIPfxV2+rwXjeeoQQ7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3404
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600213212; bh=vVuz8wEZ1YEdLMl3zvuMowNDfNHGdYX4FQGfe9IsCGM=;
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
        b=FF6Hhmun+SDU++xslQ5+Sp5ASDgMNjpvddO5p/7XK5Hdw+AtT3tR1fO7+ne2M/GLB
         UdFEzx8Sc2esEJO1HWTz09uKOhEScVWUc5Tx84YtTX/1cnxwnv+5JpXLCgo8GGAFit
         LHuekdHKUS0TVeBdql51LUHNJaOE55fFUXVVfJjPfkGyiGiof73/jZg5KgRU65Cnwz
         NkM79E0lY2KVs/gMkliMs33Vg1caHfu5GACIDsu60eo+dv0yWmleVquOY4kI12USUm
         ZSkuEYknvVUHxcggTKLzxSXwRoQShul5eUeJUmOAfXKSO7a+//2wKvi118CeGMYu2z
         4jQ8I4MpDHbCg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 16, 2020 at 09:17:38AM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2020-09-15 at 08:05 -0300, Jason Gunthorpe wrote:
> > > To sum it up:
> > > 
> > > (1) RDMA drivers need a new mapping function/attribute to define their
> > >      message push model. Actually the message model is not necessarily related
> > >      to write combining a la x86, so we should probably come up with a better
> > >      and consistent naming. Enabling this patchset may trigger performance
> > >      regressions on mellanox drivers on arm64 - this ought to be
> > >      addressed.
> > 
> > It is pretty clear now that the certain ARM chips that don't do write
> > combining with pgprot_writecombine will performance regress if they
> > are running a certain uncommon Mellanox configuration. I suspect these
> > deployments are all running the out of tree patch for DEVICE_GRE
> > though.
> 
> I'm not sure I understand...
> 
> Today those ARM chips will not use pgprot_writecombine (at least not
> using that code path, they might still use it as the result of the
> other path in the driver that can enable it). 

Not quite, upstream kernel will never use WC on those
devices. DEVICE_GRE is not supported in upstream,
arch_can_pci_mmap_wc() is always false and the WC tester will always
fail.

> With the patch, those device will now use MT_DEVICE_NC.

Which doesn't do WC at all on some ARM implementations.
 
> Why would that be a regression ? 

Using the WC submission flow when it doesn't work costs something like
10% performance vs using the non-WC flow.

Like I said, the case where the driver can't self test probably
doesn't intersect with the ARM implementations that can't do write
combining, and if it did, the users probably run the out of tree
driver that has the hacky stuff to make it use DEVICE_GRE.

> BTW. Lorenzo, why don't we use MT_DEVICE_GRE for pgprot_writecombine ?
> Its not supported on some chips ?

It has alignment requirements drivers don't meet. We need a new
concept of "write combining and I promise to do aligned access"

> What on earth is pgprot_device() ? This is new ? On ARM it will be
> MT_DEVICE_nGnRE, so it allows posted write. It seems to match what
> ioremap does. Should then ioremap use it as well ?
> 
> But it's only ever used for PCI mmap. Why is it different from
> pgprot_noncached() which disables posted writes (nE) ?
> 
> Because a whole lot of drivers will use pgprot_noncached() explicitly
> in either mmap or vmap, with the expectation that it's somewhat the
> same as what ioremap does...

*boggle*

Only sysfs uses pci_mmap_resource_range() any other driver exposing
BAR pages, like VFIO dies not. Makes no sense at all it is different.

Delete the ill defined pgprot_device() ? Nobody has complained
something is wrong with VFIO in the 6 years since it was added...

Jason
