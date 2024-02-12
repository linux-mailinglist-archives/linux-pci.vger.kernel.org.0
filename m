Return-Path: <linux-pci+bounces-3339-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E76F850FC7
	for <lists+linux-pci@lfdr.de>; Mon, 12 Feb 2024 10:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C37351C20983
	for <lists+linux-pci@lfdr.de>; Mon, 12 Feb 2024 09:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55CF17583;
	Mon, 12 Feb 2024 09:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Qn7wraA9"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2075.outbound.protection.outlook.com [40.107.100.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EAD12B7F;
	Mon, 12 Feb 2024 09:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707730306; cv=fail; b=b4yPrWopSYxl1exa/vl4/LpL2jU3XnM51672pbjdYFb2un1wnFpVHAwpsMFqZ2idQDYtchY1C94Hsj6TzaHcNZTuv8Q9cbnmwnkia5Bi59JhcjZYQzpOIKgv4AdkjR3zzhbcYwNRr83YJWoRteu1gSgdKXpZ6dDGj/LexHJmYrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707730306; c=relaxed/simple;
	bh=bCwwky8DbPNrilXEdi6hE7Klf8hjIv/wwLLlGgpidX4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XgLHYjiULPXeMtS3X5XKydlSCgs+9lZl3xzAACzjJOWB1SqlgHaO5DOrmsqyeONW5pi6ZPqqdZJRi7kOMVCAOe7upzFpMroge1j3FXy3ekMMV/Ke9DR4U5uXqVQB5BOGr5gxSlEPLhgvjrtbDvp9sgR/qNre3oSlRyCPH3tyATg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Qn7wraA9 reason="signature verification failed"; arc=fail smtp.client-ip=40.107.100.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GbahxiJJQOLnbKcyq/vkaQcVOIHpZ5dMfI0mxadTiai0fMD5ncpnqkdmPT6Ximj7gUa3tZYe4T5nkB1PVlni5U12W+R+KaoUe8FAdc/Q50G7Jf06nrF2Zm4MrBx+WRNCMjd2RiZcgGdDT3NGKq6YkLfOKAn5YNz29+p40C7sVnLpSee8uBIBbJsC6cQAawU1dqboPKP3nyLA7fKC1rv8Rure/A27dnjLK36d4HN3oMfc8RkEKT3X7020nWpkkEFyiiqtbqf6A+RWEczwjF0JhcXNsDMDMA++S5nTUYvmbIJgQGCeo2L6CBoJXINkCnnlH6TvyuDwmdDlb12YXLtTkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0NpkApAH/LHwZOpuZK/ysAWy0bbJaV8IyhlPCsHL+bQ=;
 b=S92uBW5cYJlaAy1vjBj4lXreNu0byHMkRuNbld+EjCTlNnx0HTk0WXQ3jKI3U4k3gRnx9fiqFu2dsjWLJnGFAphb4Eos0/4YGVPcdVG24u6zhIRkqvwf53gO0yAaVcNNOpMZ6K0L32H3+Gf7zgCLhAggcYCR3rFhwvb9xMzaDkPUodlI8ihkwgblXFjdgALhAlWfo4/FhY/0QsQeUL4xAKT2Hfu5xMtywAPs6kLtD2YfzU3YK1AGPwC3Trh7t1hN/PT+EBMszkmba2GwRovbu1ZAbGkgtisJ8IV2SfODONfc8+tJwvCdoYXE9/KajriG8X/upOwAMPaf9EPhht2CmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0NpkApAH/LHwZOpuZK/ysAWy0bbJaV8IyhlPCsHL+bQ=;
 b=Qn7wraA97DL9SqUJHezCsmTNHVircU6gp2UgKTpIzrK4BUtKMfJC7rTGwpXUBruOXo3sdpBLLcVPpdCJ2B/Yk3WojvULPUSXzR8Bsp7HcdfzUZTQjUFTX0xzpPREwdNjmc7QBC4+3dcin9uOICLqKGXjyLd+5QyCXreThGKBPHBeUz8+OItO+Cpx/KmQXph1qbwN78RHpSOaDUgfjoNpYf9wiGyLFy1V68yAsM4yxZezpQtc7uga9EGFSXEL9zRKE3sFFWPvoK4easiJ3YWdRgkZOSwG9rcuoMFi+NLJ82wQqbpCiJIxKO87LUzvXjlEcvYEmoYlyNUeL/AX57TDdA==
Received: from DS7PR03CA0291.namprd03.prod.outlook.com (2603:10b6:5:3ad::26)
 by MW4PR12MB7213.namprd12.prod.outlook.com (2603:10b6:303:22a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.23; Mon, 12 Feb
 2024 09:31:41 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:5:3ad:cafe::3b) by DS7PR03CA0291.outlook.office365.com
 (2603:10b6:5:3ad::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.38 via Frontend
 Transport; Mon, 12 Feb 2024 09:31:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.16 via Frontend Transport; Mon, 12 Feb 2024 09:31:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 12 Feb
 2024 01:31:27 -0800
Received: from localhost (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 12 Feb
 2024 01:31:26 -0800
Date: Mon, 12 Feb 2024 11:31:22 +0200
From: Leon Romanovsky <leonro@nvidia.com>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
CC: Jim Harris <jim.harris@samsung.com>, Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Jason
 Gunthorpe" <jgg@nvidia.com>, Alex Williamson <alex.williamson@redhat.com>,
	"pierre.cregut@orange.com" <pierre.cregut@orange.com>
Subject: Re: [PATCH v2 1/2] PCI/IOV: Revert "PCI/IOV: Serialize sysfs
 sriov_numvfs reads vs writes"
Message-ID: <20240212093122.GA16050@unreal>
References: <170752254154.1693615.9176696143128338408.stgit@bgt-140510-bm01.eng.stellus.in>
 <CGME20240209235213uscas1p2e8de2bdf05e6e7cba51bd41ddb42a8e4@uscas1p2.samsung.com>
 <170752273224.1693615.11371097645648272257.stgit@bgt-140510-bm01.eng.stellus.in>
 <10d63412-583b-4647-bb5c-4113a466324e@linux.intel.com>
 <20240211084844.GA805332@unreal>
 <fbe4efac-2ce3-443c-9b49-de207e4ba82f@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fbe4efac-2ce3-443c-9b49-de207e4ba82f@linux.intel.com>
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|MW4PR12MB7213:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b0bbd90-a4a7-45ed-7689-08dc2bad6af0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QRqiZrlwHAJ4eNxHVC2bTT3wOgOhm0gPgPOdA+MqO5CJYXYUBSsyTB7W6DUtlTUcCgwMKVlTSJBt4BjB8Jq8Jq+c1FB/dKf76G/xg4kAUzRSqLpvldSBwqvGMgspxTIKXNnE68EYAORg5E9f9UinlZ8Zs5/oOBZdcCYATzPZM0I40wUyL49RfVl+rhe/js0Ob+XCN/T7O+bWajCDniwQIVBjZoGBFlz4Sji4bLuHPPkWnxVxjO+LEJ+mBu1WltiKKc5ps5fcMtQSCsZbutjp9W0APl7PKageC8CLSpZug2Vb+iAuPzBSFk97rnwwWgmnNyMUO9pgdjpxDvM356iO7cWkEIl03K2xXWj0FKLsegLfCxLG2+CEwchGj5CEkADlImpL9gBI+xUQehevh7hZ1d64/faf7k+iV5Ov4TJb9/8Tk972pFQ+JvMlxOkBeetot+ijrWngFc7aiWry4djm28OVEBAOnaFcpaQ+YxJuva7FYAcacxDEemLSZfGDs0TlP1CZ1B4YTxp+zvdEIY4qEKTBcpjUav26dDsvEP9n63s5NqS+ZWovtbFfFDtJJeFe3gcYF9lUdHMKv2VC+lNBj8PDg+rdRDUop2tqbgrz8NjuWzmuafSPefMI88Nbu0nE4hQ1mvqRteJS6XEj8WQ8EQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(7916004)(346002)(136003)(396003)(376002)(39860400002)(230922051799003)(82310400011)(186009)(451199024)(64100799003)(1800799012)(40470700004)(36840700001)(46966006)(966005)(1076003)(478600001)(6666004)(426003)(336012)(26005)(16526019)(53546011)(83380400001)(9686003)(2906002)(316002)(8676002)(6916009)(70206006)(54906003)(70586007)(5660300002)(8936002)(4326008)(33656002)(7636003)(82740400003)(356005)(86362001)(41300700001)(33716001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 09:31:40.1842
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b0bbd90-a4a7-45ed-7689-08dc2bad6af0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7213

On Sun, Feb 11, 2024 at 11:15:44AM -0800, Kuppuswamy Sathyanarayanan wrote:
> 
> On 2/11/24 12:48 AM, Leon Romanovsky wrote:
> > On Fri, Feb 09, 2024 at 07:20:28PM -0800, Kuppuswamy Sathyanarayanan wrote:
> >> On 2/9/24 3:52 PM, Jim Harris wrote:
> >>> If an SR-IOV enabled device is held by vfio, and the device is removed,
> >>> vfio will hold device lock and notify userspace of the removal. If
> >>> userspace reads the sriov_numvfs sysfs entry, that thread will be blocked
> >>> since sriov_numvfs_show() also tries to acquire the device lock. If that
> >>> same thread is responsible for releasing the device to vfio, it results in
> >>> a deadlock.
> >>>
> >>> The proper way to detect a change to the num_VFs value is to listen for a
> >>> sysfs event, not to add a device_lock() on the attribute _show() in the
> >>> kernel.
> >> Since you are reverting a commit that synchronizes SysFS read
> >> /write, please add some comments about why it is not an
> >> issue anymore.
> > It was never an issue, the idea that sysfs read and write should be serialized by kernel
> > is not correct by definition. 
> 
> What:           /sys/bus/pci/devices/.../sriov_numvfs
> Date:           November 2012
> Contact:        Donald Dutile <ddutile@redhat.com>
> Description:
>                 This file appears when a physical PCIe device supports SR-IOV.
>                 Userspace applications can read and write to this file to
>                 determine and control the enablement or disablement of Virtual
>                 Functions (VFs) on the physical function (PF). A read of this
>                 file will return the number of VFs that are enabled on this PF.
> 
> I am not very clear about the user of this SysFs. But, as per above description,
> this sysfs seems to controls the number of VFs. A typical usage is to allow user
> to write a value and then read to check the enabled/disabled number of VMs,
> right?

No, typical usage is to write a value and observe spawned VFs. The read from
sysfs is allowed for completeness and performed in sequence with write. Any
attempt to read and write in parallel is prone to races by definition as
they are not controlled by the kernel.

> 
> If you are not synchronizing, then the value returned may not reflect the actual
> number of enabled / disabled VFs. So wont this change affect the existing user
> of this SysFS.

No, it won't. Users were supposed to synchronize their read and write
before calling sysfs. If they didn't do it, they already have broken code.

Please read original discussion pointed by Jim.

Thanks

> 
> >
> > Thanks
> >
> >>> This reverts commit 35ff867b76576e32f34c698ccd11343f7d616204.
> >>> Revert had a small conflict, the sprintf() is now changed to sysfs_emit().
> >>>
> >>> Link: https://lore.kernel.org/linux-pci/ZXJI5+f8bUelVXqu@ubuntu/
> >>> Suggested-by: Leon Romanovsky <leonro@nvidia.com>
> >>> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> >>> Signed-off-by: Jim Harris <jim.harris@samsung.com>
> >>> ---
> >>>  drivers/pci/iov.c |    8 +-------
> >>>  1 file changed, 1 insertion(+), 7 deletions(-)
> >>>
> >>> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> >>> index aaa33e8dc4c9..0ca20cd518d5 100644
> >>> --- a/drivers/pci/iov.c
> >>> +++ b/drivers/pci/iov.c
> >>> @@ -395,14 +395,8 @@ static ssize_t sriov_numvfs_show(struct device *dev,
> >>>  				 char *buf)
> >>>  {
> >>>  	struct pci_dev *pdev = to_pci_dev(dev);
> >>> -	u16 num_vfs;
> >>> -
> >>> -	/* Serialize vs sriov_numvfs_store() so readers see valid num_VFs */
> >>> -	device_lock(&pdev->dev);
> >>> -	num_vfs = pdev->sriov->num_VFs;
> >>> -	device_unlock(&pdev->dev);
> >>>  
> >>> -	return sysfs_emit(buf, "%u\n", num_vfs);
> >>> +	return sysfs_emit(buf, "%u\n", pdev->sriov->num_VFs);
> >>>  }
> >>>  
> >>>  /*
> >>>
> >> -- 
> >> Sathyanarayanan Kuppuswamy
> >> Linux Kernel Developer
> >>
> -- 
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer
> 
> 

