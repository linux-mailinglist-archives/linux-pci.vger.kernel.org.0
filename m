Return-Path: <linux-pci+bounces-3407-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C14938538E2
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 18:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78A322836D6
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 17:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933B9604A3;
	Tue, 13 Feb 2024 17:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jfXKY+K9"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992825FF17;
	Tue, 13 Feb 2024 17:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707846393; cv=fail; b=UOWWxhCpmumc9QzX4eb9fWaRMv+trHL8JooWlTgP1qR30ZjXkFETANGd0P3WQkK4jCCjjO47dvBBd9MSxezJwBTYHZNL6VAJsRTgTu7QG8HidHoYgZgU995bV0xSEu6DQ8shMd289DGJfAtyUYp+X78YwrE41Rt935viIflojgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707846393; c=relaxed/simple;
	bh=pduI9+U7Cy+BJrYsL1795pTnB2oy9zimdkURSPnCiHc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q4vIkfEama+/6B6OyObtfhMlwtXHdu4M6c8jODZLwIyXyDyIvyWdwaxbeyqx6EzFHdv+RlFwJqCHzcsv5mfcnaSG6BcYelBhB0TrnQAEOG30ehUVk1/5ET8MnoAfV5htKb7QDNPKRChUMlWVppO1VAvgyuAa2GqbtsJeTbhqtZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jfXKY+K9; arc=fail smtp.client-ip=40.107.244.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NjgzeFRhBUbUEDxaBwv7Su3ujB2EdcTtwB/R0l8raGDP+Ja8viR1U/XT/tkq1af3noLdD//z7ykS2Ei6XMEneHMYRy2qN4o4oiY7ca9e2NtvsymMc//IjgF4kW06miu5XzPtnkVBa8JTiIVScwjbCK33S6+SMyGgftFc9+1YIGropMYDEfU/MadauvFhPXSLXl16G/trb/8iOxddAO9xkK+GQel5/H/G56cO+KcymZa+dBvzPaoXndijxb76CFo8blb/22f3rlyDmSAMIw3KTC8BeOdvcpcW8pbUQYkf0cj6UwOhPaPqPIz2Lb/4630suuRhvXr4/T3ph7h98kXn/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/4+d0G50eTQOumPM+c75urbaA7ObmJGFZcI1TqOkf0=;
 b=Rw3Q28y2NnPAZc0OQj7v7EUIL9GydfCAC/Olq2W9Cp0qLHWouuTyr6CjeYuKlAbdywT6TED4p6It3xH+OJzuft7tkycYwigWMWvYTvhBZR2PTnuqKzAksI4OIDuiNJjVG/QKJx31kVLNKCRVPGWQzoo9/rnuJbXdzB4uPAhjspJzcYbgCCi+cBkzcsAQW+6nMi6+B/51MNoB6eXyOy3RaBxTWLJYOv1ZTBp0bnP+3SqV0JH6Np842ZLGzMpLEtZVVHmP8cDNKx2wQ7BrPqy5OykrEzg3JSUscrlxva6mXTwEk7jWUwtcCvHysSc2UXzp11X8TqIY7QmFAecN2OYNLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/4+d0G50eTQOumPM+c75urbaA7ObmJGFZcI1TqOkf0=;
 b=jfXKY+K95jrN28ENnZ/W8bAEJsuTbh+QMGi3oFvukYk0zDtBfzIpI5JL4XWqV5Mx8s5F0zpxxbrTpifOuSB7AE9BzM7rKWIoada1szKC2o3Gss+lQBhdCw0rqd2HQuEx3fsO4wcgm0vo5hEN2lE+9Q2n/GSs+YzK9lEz4SAYg350pmzWAqX1sv8a1XtPc9UImHUnoAxWwoumYtfVlEpdCfOBfHb5xcFiWhq/uOYGClyLCM8mWwpDncm7W7DHQOBO91BnV8ibVixq4f0IwBNX86m8CDi8X1k7XEwCDY6g75RrDdYiR++FOLGEdQuStMNpGoTka6ly4YVc+RMHxAIqRA==
Received: from MN2PR20CA0046.namprd20.prod.outlook.com (2603:10b6:208:235::15)
 by SN7PR12MB6714.namprd12.prod.outlook.com (2603:10b6:806:272::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Tue, 13 Feb
 2024 17:46:26 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:208:235:cafe::e3) by MN2PR20CA0046.outlook.office365.com
 (2603:10b6:208:235::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39 via Frontend
 Transport; Tue, 13 Feb 2024 17:46:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Tue, 13 Feb 2024 17:46:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 13 Feb
 2024 09:46:06 -0800
Received: from localhost (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 13 Feb
 2024 09:46:05 -0800
Date: Tue, 13 Feb 2024 19:46:02 +0200
From: Leon Romanovsky <leonro@nvidia.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Jim Harris <jim.harris@samsung.com>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Jason Gunthorpe
	<jgg@nvidia.com>, Alex Williamson <alex.williamson@redhat.com>, Pierre
 =?iso-8859-1?Q?Cr=E9gut?= <pierre.cregut@orange.com>
Subject: Re: [PATCH v2 1/2] PCI/IOV: Revert "PCI/IOV: Serialize sysfs
 sriov_numvfs reads vs writes"
Message-ID: <20240213174602.GD52640@unreal>
References: <20240213073450.GA52640@unreal>
 <20240213155954.GA1210633@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240213155954.GA1210633@bhelgaas>
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|SN7PR12MB6714:EE_
X-MS-Office365-Filtering-Correlation-Id: 94bbc317-627a-4640-d65c-08dc2cbbb39c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tyw3Bcaz2cWlW7Sqw+czjRQvpw5eMrOeQWGiIssTZzquAJOq5i2wWnoX7PCWYj7NG0kaBZmZLdoAcoUXImiDhpDrBJs5PBI4iC3SgxImxWjbl8+iVrkQ1spbkMXClPa5SWRTMMXvZHf2Al2o9miAiCtfXuGOqYGjvrB+F5fJbI/DVwgH+bzGB0HaX4Z8qkrFi+AsJWaTBtkvVHpF+9FMF21lebi+O7kZwdwD+ezyS32HQs+gZKURFSMEcj2bhObf6pLkeL0vFr0nMiAE7zytkZw2Sq3A7kjmLnwpN21jSF3Tbox7lEKbe4H1oNJakCS5euW7ev1QAo01g4nZD5ELwfXpKHITDrLvETuOza/38e4GqNF6Qh2Y9vPg9vEjxhVckbS9u6ZglIjDfF9UXAif4Llm68+U+ckWuRwyPRosvi93myHnh0UYh2X1sTcQiFXzgfIcudNeBa6ACeAxT6pXMN2Hcsqna5N+ip3esWbD0NeyIc5vybumTnT7l3ffa16sIiUvC6frkwwUgPeEvM8pLGYzHH4jQWbYy2sytMnBbYWv5mSJTBPpZHBmctwrxku7ttGjepWwnYDmZX7WI/REWJYvl61IovZUEQtKtgAJEReqV4IyN9htMmzSnof5MdvKdRcEqlccpaXJBnpCYHrh2g==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(7916004)(39860400002)(346002)(376002)(396003)(136003)(230922051799003)(230273577357003)(1800799012)(186009)(82310400011)(64100799003)(451199024)(40470700004)(36840700001)(46966006)(426003)(16526019)(26005)(1076003)(41300700001)(4326008)(70206006)(53546011)(6916009)(8936002)(70586007)(83380400001)(8676002)(478600001)(9686003)(966005)(6666004)(316002)(54906003)(33656002)(7636003)(82740400003)(356005)(86362001)(336012)(2906002)(33716001)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 17:46:26.1643
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94bbc317-627a-4640-d65c-08dc2cbbb39c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6714

On Tue, Feb 13, 2024 at 09:59:54AM -0600, Bjorn Helgaas wrote:
> On Tue, Feb 13, 2024 at 09:34:50AM +0200, Leon Romanovsky wrote:
> > On Mon, Feb 12, 2024 at 02:27:14PM -0600, Bjorn Helgaas wrote:
> > > On Sun, Feb 11, 2024 at 10:48:44AM +0200, Leon Romanovsky wrote:
> > > > On Fri, Feb 09, 2024 at 07:20:28PM -0800, Kuppuswamy Sathyanarayanan wrote:
> > > > > On 2/9/24 3:52 PM, Jim Harris wrote:
> > > > > > If an SR-IOV enabled device is held by vfio, and the device
> > > > > > is removed, vfio will hold device lock and notify userspace
> > > > > > of the removal. If userspace reads the sriov_numvfs sysfs
> > > > > > entry, that thread will be blocked since sriov_numvfs_show()
> > > > > > also tries to acquire the device lock. If that same thread
> > > > > > is responsible for releasing the device to vfio, it results
> > > > > > in a deadlock.
> > > > > >
> > > > > > The proper way to detect a change to the num_VFs value is to
> > > > > > listen for a sysfs event, not to add a device_lock() on the
> > > > > > attribute _show() in the kernel.
> > > 
> > > The lock was not about detecting a change; Pierre did this:
> > > 
> > >   ip monitor dev ${DEVICE} | grep --line-buffered "^${id}:" | while read line; do \
> > >     cat ${path}/device/sriov_numvfs; \
> > > 
> > > which I assume works by listening for sysfs events.  
> > 
> > It is not, "ip monitor ..." listens to netlink events emitted by
> > netdev core and not sysfs events. Sysfs events are not involved in
> > this case.
> 
> Thanks for correcting my hasty assumption!
> 
> > > The problem was that after the event occurred, the sriov_numvfs
> > > read got a stale value (see https://bugzilla.kernel.org/show_bug.cgi?id=202991).
> > 
> > Yes, and it is outcome of such cross-subsytem involvement, which
> > is racy by definition. Someone can come with even simpler example of why
> > locking sysfs read and write is not a good idea. 
> > 
> > For example, let's consider the following scenario with two CPUs and
> > locks on sysfs read and write:
> > 
> >  CPU1					CPU2
> >  echo 1 > ${path}/device/sriov_numvfs
> > 		 context_switch ->
> >  					cat ${path}/device/sriov_numvfs
> > 					lock
> > 					return 0
> > 					unlock
> > 		context_switch <-
> >  lock
> >  set 1
> >  unlock
> > 
> >  CPU1					CPU2
> >  echo 1 > ${path}/device/sriov_numvfs
> >  lock
> >  set 1
> >  unlock
> > 		 context_switch ->
> >  					cat ${path}/device/sriov_numvfs
> > 					lock
> > 					return 1
> > 					unlock
> > 
> > So same scenario will return different values if user doesn't protect
> > such case with external to the kernel lock.
> > 
> > But if we return back to Pierre report and if you want to provide
> > completely bullet proof solution to solve cross-subsystem interaction,
> > you will need to prohibit device probe till sriov_numvfs update is completed.
> > However, it is overkill for something that is not a real issue.
> 
> Pierre wanted to detect the configuration change and learn the new
> num_vfs, which seems like a reasonable thing to do.  Is there a way to
> do both via netlink or some other mechanism?

Please pay attention that Pierre listened to specific netdevice and not
to something general. After patch #2 in Jim's series, he will be able to
rely on "udevadm monitor" instead of "ip monitor".

> 
> > > So I would drop this sentence because I don't think it accurately
> > > reflects the reason for 35ff867b7657.
> > > 
> > > > > Since you are reverting a commit that synchronizes SysFS read
> > > > > /write, please add some comments about why it is not an
> > > > > issue anymore.
> > > > 
> > > > It was never an issue, the idea that sysfs read and write should be
> > > > serialized by kernel is not correct by definition. 
> > > 
> > > I think it *was* an issue.  The behavior Pierre observed at was
> > > clearly wrong, 
> > 
> > I disagree with this sentence. 
> > 
> > > and we added 35ff867b7657 ("PCI/IOV: Serialize sysfs
> > > sriov_numvfs reads vs writes") to resolve it.
> > > 
> > > We should try to avoid reintroducing the problem, so I think we should
> > > probably squash these two patches and describe it as a deadlock fix
> > > instead of dismissing 35ff867b7657 as being based on false premises.
> > > 
> > > It would be awesome if you had time to verify that these patches also
> > > resolve the problem you saw, Pierre.
> > 
> > They won't resolve his problem, because he is not listening to sysfs
> > events, but rely on something from netdev side.
> 
> I guess that means that if we apply this revert, the problem Pierre
> reported will return.  Obviously the deadlock is more important than
> the inconsistency Pierre observed, but from the user's point of view
> this will look like a regression.
> 
> Maybe listening to netlink and then looking at sysfs isn't the
> "correct" way to do this, but I don't want to just casually break
> existing user code.  If we do contemplate doing the revert, at the
> very least we should include specific details about what the user code
> *should* do instead, at the level of the actual commands to use
> instead of "ip monitor dev; cat ${path}/device/sriov_numvfs".

udevadm monitor will do the trick.

Another possible solution is to refactor the code to make sure that
.probe on VFs happens only after sriov_numvfs is updated.

Thanks

> 
> Bjorn
> 

