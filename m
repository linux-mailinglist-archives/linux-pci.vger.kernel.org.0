Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 389E926C3C3
	for <lists+linux-pci@lfdr.de>; Wed, 16 Sep 2020 16:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbgIPOgA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Sep 2020 10:36:00 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:11750 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgIPOfy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Sep 2020 10:35:54 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f621dc00001>; Wed, 16 Sep 2020 07:14:25 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 16 Sep 2020 07:14:38 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 16 Sep 2020 07:14:38 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 16 Sep
 2020 14:14:36 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 16 Sep 2020 14:14:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N394Xk1Yn3dHwDq4hApzOkBUcupQ/zRpkn5RU9JTNBbM30jmb2MEpAQXG+BzXjNYuwFkCCrEfzCVNksFShoeESUqG+BD7NHVrqFYBq9BniDaCN1lVMYWeWPkIOmo6BaLdE6xQk5tsitm/NxaY6ChxgscmXfKNfilueMqVCYukVoCNAmfg5ntGzcs4EJ21ZpqjThJM3NW/G4uc7fURoWdDODOJ/QZ2CUe0FHryP+MNSNe32RYGeH62uOaCmYEOuvnkmuyNDWU5oWQsOWl0EXYWOeGLRL7k2DhpzC/6LcM3ulT3pq5zbGX6aMo1t8pHALoAGgbAR7bwVsk3bpr6XwFQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQMBb9bJO1g2V5oHhomNIv/B8DWazX+WrchF3NzDhoE=;
 b=RhepQZzowGRJPlz16NJgi4XULRyMnOmkDGldwaLL4CmheNE+O50Y3ca4+U2LxTWaXcQmAcMmlYXuj0/QNeZw/oYo9Yj2EUCtRzeubDSRoYfWgn6NlOrKD+kaJ72kMbwOROwmyHRbrQD5+ZMFlfgEUUIbiR5TgQg+sJdFpMuhVH/nowWwliIKME2NbnZmvHOaIQw4LyPtWW2Ivrus5TIV3g1XrLEcickJ6R3yITkMjWc1Im77kalj+nqNwdEaZvDsWvfdW6j0V3mEfZvfQ2lgGntY9GbPF+zQ3zv1D1UY66V5blR4FBmR/WDblhnts8/r8uUAvPfh6d76QL2I55ONAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1147.namprd12.prod.outlook.com (2603:10b6:3:79::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Wed, 16 Sep
 2020 14:14:35 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3391.011; Wed, 16 Sep 2020
 14:14:35 +0000
Date:   Wed, 16 Sep 2020 11:14:34 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Clint Sbisa <csbisa@amazon.com>, <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <will@kernel.org>,
        <catalin.marinas@arm.com>, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH] arm64: Enable PCI write-combine resources under sysfs
Message-ID: <20200916141434.GB3699@nvidia.com>
References: <1d6f2ceb8d3538c906a1fdb8cd3d4c74ccffa42e.camel@kernel.crashing.org>
 <20200914225740.GP904879@nvidia.com>
 <2b539df4c9ec703458e46da2fc879ee3b310b31c.camel@kernel.crashing.org>
 <20200915101831.GA2616@e121166-lin.cambridge.arm.com>
 <20200915110511.GQ904879@nvidia.com>
 <bcb95faafa72734478b942084a9d24a61ae9887f.camel@kernel.crashing.org>
 <20200915234006.GI1573713@nvidia.com>
 <701012f288231d0d0733bf1c2c8fdbd9caa074fd.camel@kernel.crashing.org>
 <20200916121226.GN1573713@nvidia.com>
 <20200916140914.GA20770@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200916140914.GA20770@e121166-lin.cambridge.arm.com>
X-ClientProxiedBy: MN2PR11CA0027.namprd11.prod.outlook.com
 (2603:10b6:208:23b::32) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR11CA0027.namprd11.prod.outlook.com (2603:10b6:208:23b::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14 via Frontend Transport; Wed, 16 Sep 2020 14:14:35 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kIYCg-0002oS-6q; Wed, 16 Sep 2020 11:14:34 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b2cbc9a-cf56-49ed-4efd-08d85a4ad704
X-MS-TrafficTypeDiagnostic: DM5PR12MB1147:
X-Microsoft-Antispam-PRVS: <DM5PR12MB11478D875809770B0DCB5EB7C2210@DM5PR12MB1147.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nQRFPnjAFP+HzFLbE7vbjDekz8NzPuvokltisxuJr7VAhbMBynIUH/TUYHIy+zKmwNbfoJJxqNAK/s7WShTtwBD2L3OFVQeuqr+zYatWnI0y5/yBx6jL4sUnpbdNcvrg70LDybRJLp96PHp1cPaOkDe9LcA5YurdqBttjKUQ5yNnx4ryzvkkvLUqrvOtmFeMXJbMuMkb555MWJ9BtoHjGb8610ysY7DVjQRbyt2oy2RES8a5IXyKsdQT+cnAdDTwtOZeQIIIvmLNA8uEEbiiZGq6u16jUJQuwjI3O1TF4cqfBYfkkACSeI2UwhPy2YW/drijn07Pi4PUnXM9iwkMp3FOkTnN0Jzi0OoV8P5jdbU5N7OWN3mhPF2AYDdI3jl/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(376002)(396003)(366004)(2906002)(4744005)(66476007)(66946007)(1076003)(478600001)(66556008)(186003)(5660300002)(316002)(426003)(26005)(2616005)(54906003)(86362001)(36756003)(8936002)(8676002)(6916009)(4326008)(33656002)(9786002)(9746002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: JoNGNXoZLU7TNnsRhruUWJMCKfbwzJG2rzHSEuJyKjRDUpVpZUCNN65jBuTU4GVwWJ7vHwqAIO5dzLsirUykuB+KgECu2mI7WFIaESftVXCp5LfqS3U6+q7zXMEZzzduxtbHNlaWvR6S2+Ew2DEmcAx6f69seMRK4C+kmW/7HtDvOKWctuFeYGiBrH8whbEgaGv8neOaegQcC1zAy8vb3j9HNekXD4zURYGb0V4Vyy/X2jE+NFYC6o0q8AxiEIHs9INyynkuJy2+LTIWGlwxZST4EMo40Gc/HlVmVSv5XD9oX2VaBd7jjtuy71qtvb62cYAs3AogVrRecduI6oXkXtdC4aOxzk5piujqWH79cbpI23gpKrIpaogvUSf0lOS2TJmawLQ1H9tSWXvYFUnDQJie9A95Z9K0oK0oe4w1IrfwX7fz9SPbxkgUeouHpvrX14CevH4vBrLyuYo8bUlhSpr3uHGsH0raCW3pMcueqEfLlRPoaHRkh3/XtF7k2WDfss2Wpy8jI1n6KHEwwFNTxFOCPWpk1cZdeV2+0DxTpU18eoVt7H9//Is/3DDP93rF8vFER/lGeQau8sO/chEBWXtcaJyp51qerMXiBkss7cELc42enNpoaNWR+I5IekEODAvdC9IJe/CmJ5z75sqshA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b2cbc9a-cf56-49ed-4efd-08d85a4ad704
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 14:14:35.6117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W7zYp1SCIow0R3eW1femwqsKKhYx0bCk/JPzkYwkQh9cdYFPCzQ/xfjrrXAnpzgy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1147
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600265665; bh=oQMBb9bJO1g2V5oHhomNIv/B8DWazX+WrchF3NzDhoE=;
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
        b=ACL76l5Sd+BUoUsluY8/i3UoNS+cGFH3Rj0s/mLLJabx7s05Vd5XgM7k2IZwPuUZ1
         vm+dE7TxcBQBL5vdfQKT7QCu2YvRtsZRw7YmrW2WTpl/F90xDo1jvphYFJA6QZi0K/
         Z6MKAeYMyrITjy+f73/nzCE2a8FB+MxuU93VDKPt+9TYXQLMLGnvLbPxem8R5rD0BU
         Dhyuh7BwhqQL2/f401h1T0hAw3CIoYBDJpybTj3CVoISovgdWpInOnIGPmHst8b5dv
         eFXOAREwITIdhqk2RyLH62twitajMtKowgcAVS4WLJ5/rPsKgf0lSNHrlQf/u+CaCi
         vBobbffutILpw==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 16, 2020 at 03:09:14PM +0100, Lorenzo Pieralisi wrote:
> On Wed, Sep 16, 2020 at 09:12:26AM -0300, Jason Gunthorpe wrote:
> 
> [...]
> 
> > > You mean the driver uses a different path to the HW which ahs that
> > > overhead, not that MMIOs have that overhead right ?
> > 
> > The different path has overhead of doing extra useless MMIOs because
> > they don't combine
> 
> For my own information, this is IB user space driver code, correct ?

Yes, maybe DPDK too

> It tries to mmap buffer as WC and if it succeeds write into it in an
> optimized fashion (that is just pure overhead on platforms where
> normal NC memory - ie WC on arm64 - does not do what the
> _architecture_ defines it should).

Right, pure overhead if large PCI-E TLPs are not delivered to the
device.

Jason
