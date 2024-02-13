Return-Path: <linux-pci+bounces-3384-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0452C852A2C
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 08:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E7741F21315
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 07:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B996317590;
	Tue, 13 Feb 2024 07:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dk6OjSQX"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C6A1B273;
	Tue, 13 Feb 2024 07:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707809851; cv=fail; b=peMwbSvFT0PIvg6wOtWsyhmLDoHXLnlpRxw1NBQnmqQgxNgUxpauQimKIMibKGlbsbnEoVD+Fy0e6Mwlx72H2rf5dMnk8RiI7WJUyI1CpOlJ6Hp/1Ho+NOCXmrUJImC/wJ+o6ECOxwEyJWHYAEVOC4oCnh937Ou4+wIfP1CO2mY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707809851; c=relaxed/simple;
	bh=Kme8aidH6A3t+soUtbe14Wa/gaE/Ui8i4OzrPIPT0SQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O7xxmW9GjGGW78awyrrkzA9OxAQ6vMKtxAc0iGjtty62PbuOYyi14LrdyVhhC5iLJbX99Hp/yHz0UYnvAZS4KJo0S6NdU92RWqV1DmQRjrNXGcGXDwBH71tG8miW722aXSU1qrASLLsf95BLsigA3g1zZiuoseM9tCU+wYVklrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dk6OjSQX; arc=fail smtp.client-ip=40.107.243.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CeMeePzcXLoDwveem+kTU0AefGbtNzjsBG+9zNS9TipskO/pqeZZKweexjN6EbHaRExtHewLj4Kne6s4Zx49F+W/etrKTrV9DX1ySycLSMeAZT2i7fEnO1WG59DftmJXofIJGBFL0D0z0fVfqwWZx3sVy/6E9XU7B0TARIiwwxsE/vEW4Xc7JEEDP2x/toNrOIL2KkBbz6eICoc2a+bwnj+mKicImO6j6X02l6PNle5ku6Wza2ghK4rUYj2olrDGw9OA5NT95+bbosZrWxn9bzvHy6ykk68pezsC906g9N9XOurd2fRWRYTcM/R+hcwTvrowBkwAwJIpN8rJrtWuOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gJYFO1abpJ3r5GHADZ0UfiffW8DMBHrupKJS8+PyB+M=;
 b=TuWOXkNeLytXqh3KkAvRuUI53AO3MUb4z4Tbq8U7ue/yz/OS44AWJDFy5d8FCCNeSZ+HPgwLvX5uRQuc3+b882T39FGlyQsoIzOohxeHcU7OpeRX0s3ljjv2WWITbIxibhPsBFoHRFAL6ULaqbATLB/WXqvzC0cHQ9dAic+7QevadA8I4/uDQyi9Og+0Bn9xMVZw7BU71F0P/5Cqr+P+fS6WM4fMpf+f0bB8d+wY3vkQd4Fyc+xHzy/mLJItunVsGZ+8RuLTzMOrAMxLiv4Y0dcqFOJ3nqalHahNhY2Tm8nqhc9b+9XTWqqaqWvrpxJmYlOfuJpnMJmXWzsAl9A9cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=samsung.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJYFO1abpJ3r5GHADZ0UfiffW8DMBHrupKJS8+PyB+M=;
 b=dk6OjSQXjflCnHFQpOfryW817uehNnVGd7f3v3twX+TBQyzDhdpuURlBE0TsGVgPXvjUClKEYwdM04fuR7eemuvUR2uujLFfcbt2/DcVSo3/qvLe8qNhkIKU7cr2Xmi4Y4yHOsl1pH5DssFCbq3QU2GvT6eea+7AlczjwJzDkwv/5DTcy4g+C47DBrUyETKh2Bh5hiPwD4jxBRRwVMewcIxuIYJMYuEUnSPBbPHKCF9fcsuKOC0xW6mCYi746t8m5BwuhrtJ8yHsISiueCdMqMhuptsMb0AOb7w2YMvbMHzYNAOjB5yWnYh9s5cTU0vJw4ZTvymy9cNMcVKW2QN5bQ==
Received: from PH7PR10CA0013.namprd10.prod.outlook.com (2603:10b6:510:23d::9)
 by LV2PR12MB6013.namprd12.prod.outlook.com (2603:10b6:408:171::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Tue, 13 Feb
 2024 07:37:26 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:510:23d:cafe::c) by PH7PR10CA0013.outlook.office365.com
 (2603:10b6:510:23d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39 via Frontend
 Transport; Tue, 13 Feb 2024 07:37:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Tue, 13 Feb 2024 07:37:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 12 Feb
 2024 23:37:15 -0800
Received: from localhost (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 12 Feb
 2024 23:37:14 -0800
Date: Tue, 13 Feb 2024 09:37:10 +0200
From: Leon Romanovsky <leonro@nvidia.com>
To: Jim Harris <jim.harris@samsung.com>
CC: Bjorn Helgaas <helgaas@kernel.org>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, Bjorn Helgaas
	<bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, "Alex
 Williamson" <alex.williamson@redhat.com>, Pierre =?iso-8859-1?Q?Cr=E9gut?=
	<pierre.cregut@orange.com>
Subject: Re: [PATCH v2 1/2] PCI/IOV: Revert "PCI/IOV: Serialize sysfs
 sriov_numvfs reads vs writes"
Message-ID: <20240213073710.GB52640@unreal>
References: <20240211084844.GA805332@unreal>
 <20240212202714.GA1142983@bhelgaas>
 <CGME20240212225904uscas1p19a3d7743607a0abe3627fb8c4829f27b@uscas1p1.samsung.com>
 <ZcqitnWTh+zQ+H4p@ubuntu>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZcqitnWTh+zQ+H4p@ubuntu>
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|LV2PR12MB6013:EE_
X-MS-Office365-Filtering-Correlation-Id: 1790257f-4982-4586-e115-08dc2c66a02f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	isb5+qX+FBo6bhlTk3KwJOnXb/rBrQmvn4L/HWE65DlhbjX9Yo6u0kjBeCl4sMZDM6Gb3CrtcX8x+ia99dPyOM4svrOEL0uacclZtuU1J23rS1J1F7fO0lB7E3YF8IJrLU/ESYEmdax44ZGO5lpSqOAk1gqi4SE+G2cfQ3AURkofNsUxq0YjCHX3hDsXNc1XfxG5Otr7GOnxEa3GYi9KnkIbIvF+/EjgoIeyH8uzRIy29MhDmDeAp5IJhL97fwE0M/sNnWOusg6KhSOngfVczloX5LRJSM6T7H+KOMAO67hrjh8shJaD/wx6CpwDpT/ADEU5nLdgAO516idfYDQSO1bd7IvdSJNUJgRkwqmOeqqXA857WC6pypkw2AiccMTPWoQknEnUgU3gwzfU0WOUtyx4OtHAZ9pDdNWGbhU88o+15bxeedv2Jw4dwtXgSPFSCs/9ngtf+RkCO7bS5moMILmdxBB3SSXwkqNgcpcHosaTQbkXprIa83Nep/tbOGE4puby0sfVhGXVPTDETJCwv5SLNS2HLVC+yFioVG9BSYnw9vrQiqlx1ZZiGaDp6Be6ssoPzePcVXGxoYuh1x8aZleWw2lYRjFOLQty8Cp/pxpd3VsyKn8Of72kKhccJkqP1XdVi1kzG3aYYwtXgdaNhIPQLEdPEVlEQLr6+FBz+26T235V3mN6EEBFpyUQPe6q
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(7916004)(396003)(136003)(39860400002)(346002)(376002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(82310400011)(46966006)(36840700001)(40470700004)(82740400003)(7636003)(356005)(16526019)(41300700001)(86362001)(33716001)(83380400001)(5660300002)(2906002)(70206006)(426003)(336012)(54906003)(8936002)(4326008)(8676002)(70586007)(6916009)(1076003)(316002)(478600001)(966005)(53546011)(9686003)(6666004)(26005)(33656002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 07:37:26.3984
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1790257f-4982-4586-e115-08dc2c66a02f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6013

On Mon, Feb 12, 2024 at 10:59:03PM +0000, Jim Harris wrote:
> On Mon, Feb 12, 2024 at 02:27:14PM -0600, Bjorn Helgaas wrote:
> > On Sun, Feb 11, 2024 at 10:48:44AM +0200, Leon Romanovsky wrote:
> > > On Fri, Feb 09, 2024 at 07:20:28PM -0800, Kuppuswamy Sathyanarayanan wrote:
> > > > On 2/9/24 3:52 PM, Jim Harris wrote:
> > > > > If an SR-IOV enabled device is held by vfio, and the device is removed,
> > > > > vfio will hold device lock and notify userspace of the removal. If
> > > > > userspace reads the sriov_numvfs sysfs entry, that thread will be blocked
> > > > > since sriov_numvfs_show() also tries to acquire the device lock. If that
> > > > > same thread is responsible for releasing the device to vfio, it results in
> > > > > a deadlock.
> > > > >
> > > > > The proper way to detect a change to the num_VFs value is to listen for a
> > > > > sysfs event, not to add a device_lock() on the attribute _show() in the
> > > > > kernel.
> > 
> > The lock was not about detecting a change; Pierre did this:
> > 
> >   ip monitor dev ${DEVICE} | grep --line-buffered "^${id}:" | while read line; do \
> >     cat ${path}/device/sriov_numvfs; \
> > 
> > which I assume works by listening for sysfs events.  The problem was
> > that after the event occurred, the sriov_numvfs read got a stale value
> > (see https://bugzilla.kernel.org/show_bug.cgi?id=202991).
> 
> I don't think 'ip monitor dev' listens for any sysfs events. Or at least if
> I have this running and write values to sriov_numvfs, I don't see any
> output.
> 
> It looks like the original bug report was against v5.0 (matching by dates
> and the patch file attached). In that code, we have:
> 
>     kobject_uevent(&dev->dev.kobj, KOBJ_CHANGE);
>     iov->num_VFs = nr_virtfn;
> 
> which is identical to how the code looks today. Is it possible that
> userspace could react to this uevent and read the stale num_VFs before
> iov->num_VFs gets written here? I mean, theoretically it's possible, but
> from the bug report it seems like the scenario Pierre was facing was
> 100% reproducible.
> 
> It would be great if we could get input from Pierre on this. It isn't clear
> to me from the bug report what exactly is updating the sriov_numvfs sysfs
> entry, and what is triggering that update.
> 
> We could also revisit my original suggestion, which was to use a
> discrete lock just for this sysfs entry, rather than overloading the
> device lock. That probably has lower risk of introducing an unintended
> regression.

The idea that lock issues are need to be solved by adding more locks
doesn't sound good to me.

Thanks

> 
> https://lore.kernel.org/linux-pci/ZXNNQkXzluoyeguu@bgt-140510-bm01.eng.stellus.in/
> 
> > 
> > So I would drop this sentence because I don't think it accurately
> > reflects the reason for 35ff867b7657.
> > 
> > > > Since you are reverting a commit that synchronizes SysFS read
> > > > /write, please add some comments about why it is not an
> > > > issue anymore.
> > > 
> > > It was never an issue, the idea that sysfs read and write should be
> > > serialized by kernel is not correct by definition. 
> > 
> > I think it *was* an issue.  The behavior Pierre observed at was
> > clearly wrong, and we added 35ff867b7657 ("PCI/IOV: Serialize sysfs
> > sriov_numvfs reads vs writes") to resolve it.
> > 
> > We should try to avoid reintroducing the problem, so I think we should
> > probably squash these two patches and describe it as a deadlock fix
> > instead of dismissing 35ff867b7657 as being based on false premises.
> > 
> > It would be awesome if you had time to verify that these patches also
> > resolve the problem you saw, Pierre.
> > 
> > I think we should also add:
> > 
> >   Fixes: 35ff867b7657 ("PCI/IOV: Serialize sysfs sriov_numvfs reads vs writes")
> > 
> > as a trigger for backporting this to kernels that include
> > 35ff867b7657.
> > 
> > Bjorn
> > 
> > > > > This reverts commit 35ff867b76576e32f34c698ccd11343f7d616204.
> > > > > Revert had a small conflict, the sprintf() is now changed to sysfs_emit().
> > > > >
> > > > > Link: https://lore.kernel.org/linux-pci/ZXJI5+f8bUelVXqu@ubuntu/
> > > > > Suggested-by: Leon Romanovsky <leonro@nvidia.com>
> > > > > Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> > > > > Signed-off-by: Jim Harris <jim.harris@samsung.com>
> > > > > ---
> > > > >  drivers/pci/iov.c |    8 +-------
> > > > >  1 file changed, 1 insertion(+), 7 deletions(-)
> > > > >
> > > > > diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> > > > > index aaa33e8dc4c9..0ca20cd518d5 100644
> > > > > --- a/drivers/pci/iov.c
> > > > > +++ b/drivers/pci/iov.c
> > > > > @@ -395,14 +395,8 @@ static ssize_t sriov_numvfs_show(struct device *dev,
> > > > >  				 char *buf)
> > > > >  {
> > > > >  	struct pci_dev *pdev = to_pci_dev(dev);
> > > > > -	u16 num_vfs;
> > > > > -
> > > > > -	/* Serialize vs sriov_numvfs_store() so readers see valid num_VFs */
> > > > > -	device_lock(&pdev->dev);
> > > > > -	num_vfs = pdev->sriov->num_VFs;
> > > > > -	device_unlock(&pdev->dev);
> > > > >  
> > > > > -	return sysfs_emit(buf, "%u\n", num_vfs);
> > > > > +	return sysfs_emit(buf, "%u\n", pdev->sriov->num_VFs);
> > > > >  }
> > > > >  
> > > > >  /*
> > > > >
> > > > -- 
> > > > Sathyanarayanan Kuppuswamy
> > > > Linux Kernel Developer
> > > > 

