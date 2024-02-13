Return-Path: <linux-pci+bounces-3383-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD9A852A0B
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 08:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43146284285
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 07:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C29017596;
	Tue, 13 Feb 2024 07:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q0pS9386"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2042.outbound.protection.outlook.com [40.107.212.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E70017994;
	Tue, 13 Feb 2024 07:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707809713; cv=fail; b=ESEipskyj8R9f0IzXu2iG1kLHsW1M56jC0hMXkm5TNO7SYN61wBa9d5U+GHHy3TYu4GU05gmCChvAfXfts4HPpY2YMS/P+c2FAObKFLOMCb6ukJSjWO/7pe7PSOdU2527hMrbKA+LErfyn8y3FbYqyA9BjL0ufB4c5wTuE4MFTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707809713; c=relaxed/simple;
	bh=q8h2M52+m1fLAYKXxl4O0M02+IEwl2dnUFigIUY3zJ0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQSeJphUeTnKHbWPaGmUw0MGSuwaSgYfl9DJCYjXbJx98l+h13LEEvVtfnkcgEBzagMtw9ywckuvCsTwmu4N9tMp8A5KVyxqVa6Sw9PU1UW5aESinEUEeccEuGJmMXTiUl+F8SkXrVktisiZRjTnGsqv0iMJ4rTMuzIYdRYTVpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q0pS9386; arc=fail smtp.client-ip=40.107.212.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JWP4v7FmMytOcEB5DTlMqLp0iW0N6T7ZY2SnLzH7AooA2urfPFLenqkiHC7u2G5PCnvpVFqgqX+dV5siLWyaj6OPS4OOIPrd//ILCG8cD/xU2vEhaBK3QCAx/YZrS/0fI0vOyFS8puetR7dcNLjhAOEb+oX1hMlTUSHyPjctIgbRQSgsk9a7sBRz2VB4ferR2drUbtgJ0qAMl8VAAnm6x2iCemBqal6Jhl9Xj02qlVTQJ0k246mwjilORs3BG2iDxZRq05AaQPDygT5JQXw1Zu9w3+wsnxRU6KfZJc16END1EmuAY0Yp+B5OJw5gF0UlCkhMj3/tqvskV2kQ24matQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F1rYOjknjNlCV0IS7PK+kZwp43WWzTqbGXwQCLd1i80=;
 b=JuELDry7qXEqf95F1cjQTdt7v7ceoLtVWCf6xTPxanpNVaIhtGdb6uLm03UZfeteSqSeHE18QCREa9iUp0rkRH8a+F52R8QO/5zRPlT548hH4ZnpA9BDjmK2FDA1++Uyak7PC0kj7MmAlN02KEzu8/6/2+3h+zRLWdYu1Zrm3bA60nS9COT8PxhUwt9CEjiOH3HFXFC2z0fIqeTiww9yTIwosZXRsIlPeFH0oW1DQ03zkwWY0HMfqUP4C93ACurhBFHedTC3eD4woGghQ3DdLC5G3DDWqJanbLpm5VlO9fcxjzgkQAn4abJgMzF+ogQorfoSKap48wuTOs2a4yL8tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1rYOjknjNlCV0IS7PK+kZwp43WWzTqbGXwQCLd1i80=;
 b=Q0pS9386rGvpbDj6yPSpSAbH8kNwIYEOX4S1T1/ho1/zB3agxS4eg2GRooB3+ZtXCbF/rogk7oz0HJ6eMYEMsV8mx3OkWnMxCzYG+NcsrSjWmRHzyVuYeVFv3fSx0TmR3w4DwzkS8502ym6BY/AAm5/rO0OCgU7wvR04FOgMB+SbJzqCb0xmcxc2SSs3SCmJLgmKiYyw5bf2xYpCSw5+K72gCvXdhbM3keR3d4B6T48vZVm+NuUX3LqFu3j++XtjZ7R0VryMsMZMMRG1YgC9+Z9a0uSOhHqPIGOCWjWFgYE5zztZpXI5goZkS5tJnoCwV3KcN+FfHCUZcnrWYVTWdQ==
Received: from SJ0PR03CA0373.namprd03.prod.outlook.com (2603:10b6:a03:3a1::18)
 by DS7PR12MB6357.namprd12.prod.outlook.com (2603:10b6:8:96::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.11; Tue, 13 Feb
 2024 07:35:05 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::29) by SJ0PR03CA0373.outlook.office365.com
 (2603:10b6:a03:3a1::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39 via Frontend
 Transport; Tue, 13 Feb 2024 07:35:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Tue, 13 Feb 2024 07:35:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 12 Feb
 2024 23:34:54 -0800
Received: from localhost (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 12 Feb
 2024 23:34:53 -0800
Date: Tue, 13 Feb 2024 09:34:50 +0200
From: Leon Romanovsky <leonro@nvidia.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Jim Harris <jim.harris@samsung.com>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Jason Gunthorpe
	<jgg@nvidia.com>, Alex Williamson <alex.williamson@redhat.com>, Pierre
 =?iso-8859-1?Q?Cr=E9gut?= <pierre.cregut@orange.com>
Subject: Re: [PATCH v2 1/2] PCI/IOV: Revert "PCI/IOV: Serialize sysfs
 sriov_numvfs reads vs writes"
Message-ID: <20240213073450.GA52640@unreal>
References: <20240211084844.GA805332@unreal>
 <20240212202714.GA1142983@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240212202714.GA1142983@bhelgaas>
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|DS7PR12MB6357:EE_
X-MS-Office365-Filtering-Correlation-Id: 681286a3-456e-461d-e1e2-08dc2c664c14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TYw4fqj8Mfg8Sn4qJAd4QH4lTnSj2Wc3q7KAXqk63wUjHzgvHODwvhmYgrEg834iAG4V8Qx330hymYaYLvxqgaTxRlC0fIVIWXVfiez0GhLP5Ykm1/XwpAgHaThq4Eo1ZRXvBk5xxYdCO6EDLEGwV92qARwlQNgcERg9z2TavZIdEcg/C13KjFEURIP1DuJIbeQH4wjzcLR80Xp7r9yWyP5w/NS0y0dw0TQiExIWXiFgBDChlBduttuv2UOlfPtulOpfHN2SXf8I8oGgjaI9BXGVtwdmliduCeHwaz6kvRAnwMgUg3q846KKr4Em9hABnQ6apqYutCqpFR5MCue3AU1I3OIbfNhkesEPda4OJPfm1ASTqDYOHLQoN2LvpJWBFSjZT4vikIiBaB07HWJdzx2TA5iTK8oFnliT+I1+JJpBQLyTTF2tl4+ZDLRPH1ZCcdkvTXS5yDn0dPYCg/ZZtxZX0SxeL6BqISCFvndY9X+hzXfhIimAdkGvgVjDqQNxKECfck7fEAO0SG5HxqBgQMi/ThH3OJPouwTkAoJtQYFNlc1nnzmW5iDYokD0nd3UHrTQvRAPiJ+kGVRycrT8CdeU/bvLhZ3akMSmsg5Ox8rxnFMeKioXbvcyN+eX92CYx5aNPmHVIlBcyJWPHc5y5g==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(7916004)(136003)(376002)(39860400002)(396003)(346002)(230273577357003)(230922051799003)(1800799012)(64100799003)(82310400011)(186009)(451199024)(46966006)(36840700001)(40470700004)(53546011)(41300700001)(966005)(478600001)(5660300002)(33716001)(9686003)(54906003)(6916009)(26005)(426003)(336012)(2906002)(8936002)(1076003)(16526019)(82740400003)(7636003)(83380400001)(70586007)(316002)(8676002)(4326008)(70206006)(86362001)(356005)(33656002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 07:35:05.2616
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 681286a3-456e-461d-e1e2-08dc2c664c14
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6357

On Mon, Feb 12, 2024 at 02:27:14PM -0600, Bjorn Helgaas wrote:
> On Sun, Feb 11, 2024 at 10:48:44AM +0200, Leon Romanovsky wrote:
> > On Fri, Feb 09, 2024 at 07:20:28PM -0800, Kuppuswamy Sathyanarayanan wrote:
> > > On 2/9/24 3:52 PM, Jim Harris wrote:
> > > > If an SR-IOV enabled device is held by vfio, and the device is removed,
> > > > vfio will hold device lock and notify userspace of the removal. If
> > > > userspace reads the sriov_numvfs sysfs entry, that thread will be blocked
> > > > since sriov_numvfs_show() also tries to acquire the device lock. If that
> > > > same thread is responsible for releasing the device to vfio, it results in
> > > > a deadlock.
> > > >
> > > > The proper way to detect a change to the num_VFs value is to listen for a
> > > > sysfs event, not to add a device_lock() on the attribute _show() in the
> > > > kernel.
> 
> The lock was not about detecting a change; Pierre did this:
> 
>   ip monitor dev ${DEVICE} | grep --line-buffered "^${id}:" | while read line; do \
>     cat ${path}/device/sriov_numvfs; \
> 
> which I assume works by listening for sysfs events.  

It is not, "ip monitor ..." listens to netlink events emitted by netdev
core and not sysfs events. Sysfs events are not involved in this case.

> The problem was that after the event occurred, the sriov_numvfs
> read got a stale value (see https://bugzilla.kernel.org/show_bug.cgi?id=202991).

Yes, and it is outcome of such cross-subsytem involvement, which
is racy by definition. Someone can come with even simpler example of why
locking sysfs read and write is not a good idea. 

For example, let's consider the following scenario with two CPUs and
locks on sysfs read and write:

 CPU1					CPU2
 echo 1 > ${path}/device/sriov_numvfs
		 context_switch ->
 					cat ${path}/device/sriov_numvfs
					lock
					return 0
					unlock
		context_switch <-
 lock
 set 1
 unlock

 CPU1					CPU2
 echo 1 > ${path}/device/sriov_numvfs
 lock
 set 1
 unlock
		 context_switch ->
 					cat ${path}/device/sriov_numvfs
					lock
					return 1
					unlock

So same scenario will return different values if user doesn't protect
such case with external to the kernel lock.

But if we return back to Pierre report and if you want to provide
completely bullet proof solution to solve cross-subsystem interaction,
you will need to prohibit device probe till sriov_numvfs update is completed.
However, it is overkill for something that is not a real issue.

> 
> So I would drop this sentence because I don't think it accurately
> reflects the reason for 35ff867b7657.
> 
> > > Since you are reverting a commit that synchronizes SysFS read
> > > /write, please add some comments about why it is not an
> > > issue anymore.
> > 
> > It was never an issue, the idea that sysfs read and write should be
> > serialized by kernel is not correct by definition. 
> 
> I think it *was* an issue.  The behavior Pierre observed at was
> clearly wrong, 

I disagree with this sentence. 

> and we added 35ff867b7657 ("PCI/IOV: Serialize sysfs
> sriov_numvfs reads vs writes") to resolve it.
> 
> We should try to avoid reintroducing the problem, so I think we should
> probably squash these two patches and describe it as a deadlock fix
> instead of dismissing 35ff867b7657 as being based on false premises.
> 
> It would be awesome if you had time to verify that these patches also
> resolve the problem you saw, Pierre.

They won't resolve his problem, because he is not listening to sysfs events,
but rely on something from netdev side.

> 
> I think we should also add:
> 
>   Fixes: 35ff867b7657 ("PCI/IOV: Serialize sysfs sriov_numvfs reads vs writes")
> 
> as a trigger for backporting this to kernels that include
> 35ff867b7657.
> 
> Bjorn
> 
> > > > This reverts commit 35ff867b76576e32f34c698ccd11343f7d616204.
> > > > Revert had a small conflict, the sprintf() is now changed to sysfs_emit().
> > > >
> > > > Link: https://lore.kernel.org/linux-pci/ZXJI5+f8bUelVXqu@ubuntu/
> > > > Suggested-by: Leon Romanovsky <leonro@nvidia.com>
> > > > Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> > > > Signed-off-by: Jim Harris <jim.harris@samsung.com>
> > > > ---
> > > >  drivers/pci/iov.c |    8 +-------
> > > >  1 file changed, 1 insertion(+), 7 deletions(-)
> > > >
> > > > diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> > > > index aaa33e8dc4c9..0ca20cd518d5 100644
> > > > --- a/drivers/pci/iov.c
> > > > +++ b/drivers/pci/iov.c
> > > > @@ -395,14 +395,8 @@ static ssize_t sriov_numvfs_show(struct device *dev,
> > > >  				 char *buf)
> > > >  {
> > > >  	struct pci_dev *pdev = to_pci_dev(dev);
> > > > -	u16 num_vfs;
> > > > -
> > > > -	/* Serialize vs sriov_numvfs_store() so readers see valid num_VFs */
> > > > -	device_lock(&pdev->dev);
> > > > -	num_vfs = pdev->sriov->num_VFs;
> > > > -	device_unlock(&pdev->dev);
> > > >  
> > > > -	return sysfs_emit(buf, "%u\n", num_vfs);
> > > > +	return sysfs_emit(buf, "%u\n", pdev->sriov->num_VFs);
> > > >  }
> > > >  
> > > >  /*
> > > >
> > > -- 
> > > Sathyanarayanan Kuppuswamy
> > > Linux Kernel Developer
> > > 
> 

