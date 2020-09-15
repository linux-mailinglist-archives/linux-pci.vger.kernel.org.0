Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47F8D26A3ED
	for <lists+linux-pci@lfdr.de>; Tue, 15 Sep 2020 13:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgIOLM3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Sep 2020 07:12:29 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:41426 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726106AbgIOLLl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Sep 2020 07:11:41 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f609fef0000>; Tue, 15 Sep 2020 19:05:19 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Tue, 15 Sep 2020 04:05:19 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Tue, 15 Sep 2020 04:05:19 -0700
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 15 Sep
 2020 11:05:16 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 15 Sep 2020 11:05:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jh/WA0iOcRemT5uM/GRCY5YKPDmoEi6rGnL220Kp/VhJy+mJB2Wm4qpSZlTSxZx/vLwS7jwLsIfIMy8th7xz9VDfzs0HJjaibUG8kHUS/yg6AyVxqUDIor6a8n1Wex7ReA0jZQaNMc3g2+v52kdE8nbVNCAf14y/Gih5VqitJ7SNAMYk5EjzsnO4rObCg1/s14vBoNlB1wAZ7pu0Sjbe8IL3uuI+wLz6kODNDXYbeqJHmRR6rUnQZ7D74/2/9YgdlHftmZ3sN13N4u76if7+eFLoL+5ME9fNrLMfqAmSnO52O1lS9rO0lzwcL6b78d+YDjXSSCfXxEmGPrESMkjo9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2YuQpftYF3fsnm0wOg0Bqr9PWu+I4uSHeh0QukVJiCE=;
 b=Irm+dhdP9qh1PZvwnH5s96gYDL3QXnnPCQH6Z4MkopIqslKEJClZFBN6Aolxy//CJIC+/6kkEzoD+0KL8i0MaQxyjh46Jp2MFIzIn3/qeUmcWAd9lDZLPG9JaYDOQqfCTQR4p4KqLdfd0h3rCvIpxDgMGi4ySWjpjnk1YcDmQTE2uH//hY5E5g2cyuWSfRjHXP1L0wmxvUnd00SJwxGnr03jRRsEDYhE4zbUTIQf6XItS/bUUMzDM467T6OBoNlVjThGiByVgtzzuQdbVkX9BGGQ9OJR7kk1jVAI9DsPjiJT94foqiGjQUBBfNrvPlA96dUpHH4qFuQaRDRflyvjnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1754.namprd12.prod.outlook.com (2603:10b6:3:10f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Tue, 15 Sep
 2020 11:05:13 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3391.011; Tue, 15 Sep 2020
 11:05:13 +0000
Date:   Tue, 15 Sep 2020 08:05:11 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Clint Sbisa <csbisa@amazon.com>, <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <will@kernel.org>,
        <catalin.marinas@arm.com>, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH] arm64: Enable PCI write-combine resources under sysfs
Message-ID: <20200915110511.GQ904879@nvidia.com>
References: <3110e00a1f4df7b7359ba4f2b7f86a35aa47405e.camel@kernel.crashing.org>
 <20200911214225.hml2wbbq2rofn4re@amazon.com>
 <20200914141726.GA904879@nvidia.com>
 <20200914142406.k44zrnp2wdsandsp@amazon.com>
 <20200914143819.GC904879@nvidia.com>
 <375c478593945a416f3180c3773bcb5240d2e36c.camel@kernel.crashing.org>
 <1d6f2ceb8d3538c906a1fdb8cd3d4c74ccffa42e.camel@kernel.crashing.org>
 <20200914225740.GP904879@nvidia.com>
 <2b539df4c9ec703458e46da2fc879ee3b310b31c.camel@kernel.crashing.org>
 <20200915101831.GA2616@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200915101831.GA2616@e121166-lin.cambridge.arm.com>
X-ClientProxiedBy: QB1PR01CA0007.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:2d::20) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by QB1PR01CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:2d::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend Transport; Tue, 15 Sep 2020 11:05:13 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kI8lr-006PkE-1t; Tue, 15 Sep 2020 08:05:11 -0300
X-Originating-IP: [206.223.160.26]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57321c1f-cdbe-4a9f-b614-08d85967384b
X-MS-TrafficTypeDiagnostic: DM5PR12MB1754:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1754C2B83A033ED44BAFE251C2200@DM5PR12MB1754.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bp35rmLzKrTFPBsLEhg2FOTJjd19SsZjMXVzuHqapfskcwPduQmXRCHLP6N3PuzCuAxDickaOVWmScccqMtuZCf04rQnO2sgWuB0BwAu1OeJjNlcHOV8ExNZ1tn3hFX1kx0u8/osYlbBL3UZFTVdruOXlGa5NvhoU6nZSDM9RqqQgfK98fQsQLugYMx5n/W1iyZ7e5MkOTEfp/X2TVWQP2OUUz8TFZb0DHplDsZSP2N7ELXngPRE/zTawJBHeHT2KUpo2FetAcZ63qjjetrvwdTw8FKhcpEjcct6UkHhJM8FO99E7+Lg4H9Dwvykmytll+hcxGYyNqDtt05aCey73jH8L4d1AYPGsWOfdsKbGQE639md/PTBnAOOkslOFCcc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(396003)(376002)(39860400002)(66556008)(2616005)(86362001)(2906002)(36756003)(9746002)(5660300002)(9786002)(6916009)(426003)(478600001)(54906003)(8936002)(66476007)(33656002)(1076003)(66946007)(186003)(8676002)(26005)(4326008)(83380400001)(316002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Gx2P4VQQ5FWJgx5OLTjljGsdcIrO9Vcny/oT0h9hGxEJl6JHiNU4FXn4D5xdR2u4B1xZ5m6y9HJBtE113OxBdxvi3UzWts3FNigxYQ8Vm7bLoyCwp7Qt0R5u6VVwhf1O56rG4eKiGBpGnGwE26V79tOZXKcbHFlEkSnfZ74wCt5kCtLi736q0NEdi4+TcoTunbbG1mEU6ipGCs5xFI4z9HZ6MBocfcEVDzBqrYM3X1oh5OyKEt0/ldlHCPc9ziegMzkHldrroLx2jCsPm+urRATN6AXFloyJt5AuKuy2xttDBCYflV+BlEjgNdLv2nGFZTUVeqG94bVH6/T96nlKbtblnqAPJWzwn2LAcorG/71NoZjR4ZDUEUcz6RHNtAmdtSiL76AXgVTMT+XbwumZK26LQjKPly9yYGAvFBK86oLtggEoZeFtahWdWlhALiYjWQ725HSfyv6Gtmujgl0TyetJDjlEIl7wpd6G8ZGJlF9x7/pVKmXEXSAqSx2IpnZa1f919O7fHmoemcXwutUZgu7h67dx1sMw4jXlQed+1U85AMAPZ9EEuOTrVVtSmZxdqdMRcgdkhiSYsoEQ4a1OW4U6YgRUIheblCz2+iokNzoSlgQgKUlYlyVXyzY66Yb6j9a47VNTcQPOsaY67DSN8w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 57321c1f-cdbe-4a9f-b614-08d85967384b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2020 11:05:13.7332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OrdPrd2TxxdPJDqRWlyhijOBPqt8ik7eC8v9BEOnKzr5duj5oKvotRHZEyRMZjtz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1754
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600167919; bh=2YuQpftYF3fsnm0wOg0Bqr9PWu+I4uSHeh0QukVJiCE=;
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
        b=kd2AHSJjUhIByl9Zbylyp3F9fg4gcja8JqnjbCBXqFdt0RhFEtvI22+OLVQ8e2YvX
         pySsToKj3/eJkBguZ/NcGRfbsg4pFlyBPwXkq6dtmg9/EuImyKG/h+fJeN2SWemtWb
         k5B1JNmnYowRjuO0xWxjk92rVMUs/z3wSLSZJmxNB1fLV1rtmw3grbWNMnyX8OeoXK
         EJZNAnlPaMlOSAtBlmdNu8FUcoaRUkl0sZ2tyi8fljnmUSci5+kheu3ugSOEArDJ1+
         ublKxA5o3ALZQDTFEw2FzvqOUUaJLEunxsWQmZbZXqq2RT6o9Q/Qb0dio3QYWGS/vD
         H/qScbCT1hgUQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 15, 2020 at 11:18:31AM +0100, Lorenzo Pieralisi wrote:
> On Tue, Sep 15, 2020 at 09:25:57AM +1000, Benjamin Herrenschmidt wrote:
> > On Mon, 2020-09-14 at 19:57 -0300, Jason Gunthorpe wrote:
> > > On Tue, Sep 15, 2020 at 08:00:27AM +1000, Benjamin Herrenschmidt wrote:
> > > > On Tue, 2020-09-15 at 07:42 +1000, Benjamin Herrenschmidt wrote:
> > > > > 
> > > > > > which is back to my original question, how do you do DMA using
> > > > > > /sys/xx/resources? Why not use VFIO like everything else?
> > > > > 
> > > > > Note: All this doesnt' change the fact that sys/xx/resources_wc
> > > > > exists
> > > > > for other archs and I see no reasons so far not to have it on ARM...
> > > > 
> > > > Also... it looks like VFIO also doesn't provide a way to do WC yet
> > > > unfortunately :-(
> > > 
> > > Yes, but if the driving reason for this patch is because a VFIO user
> > > like EFA DPDK is trying to work around VFIO limitations, then I'd say
> > > the VFIO mmap should be amended, and not so much worring about sysfs.
> > 
> > I don't think the two are exclusive.
> > 
> > > While there is no reason for ARM to not show the sysfs, it really
> > > should never be used. Modern kernels in secure boot don't even show
> > > it, for instance.
> > 
> > It's useful for random things, I've used it quite a bit in a previous
> > life for things like in-lab hw testing etc...  There's tooling out
> > there, esp. in the more 'embedded' side of thing that uses this, I
> > don't see a good reason not to provide the same level of functionality.
> > 
> > So Lorenzo, imho, we should merge the patch.
> 
> To sum it up:
> 
> (1) RDMA drivers need a new mapping function/attribute to define their
>     message push model. Actually the message model is not necessarily related
>     to write combining a la x86, so we should probably come up with a better
>     and consistent naming. Enabling this patchset may trigger performance
>     regressions on mellanox drivers on arm64 - this ought to be
>     addressed.

It is pretty clear now that the certain ARM chips that don't do write
combining with pgprot_writecombine will performance regress if they
are running a certain uncommon Mellanox configuration. I suspect these
deployments are all running the out of tree patch for DEVICE_GRE
though.

So, I wouldn't worry about it - but would prefer to see ARM folks
advance some proposal to accommodate those chips that need DEVICE_GRE.

Jason
