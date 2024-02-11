Return-Path: <linux-pci+bounces-3330-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6EA850836
	for <lists+linux-pci@lfdr.de>; Sun, 11 Feb 2024 09:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B88B3282463
	for <lists+linux-pci@lfdr.de>; Sun, 11 Feb 2024 08:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ABED168B7;
	Sun, 11 Feb 2024 08:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LerMc7i5"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2064.outbound.protection.outlook.com [40.107.100.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6366C59140;
	Sun, 11 Feb 2024 08:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707641337; cv=fail; b=U7p78TUGufehfamDbEIORVlbGeFexk35VMbNX7r4Z87uZcyL2Qi9bc/s+rnbw3brjNxCE3LgJnWva7F+6ijpQxQjlMqVYDmLVi/zL0pG9blfzjPBZay7Ombkw8UZBpZ2jvnZkfAAdEPwtHwh91DlU2jyfz7wFIxjr7ketVyJUmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707641337; c=relaxed/simple;
	bh=X4sic8qAOw70RautjOZ+W2Z7iwWMIM4utAfVEldPb0k=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cqIV4xKydyqxq9Wx7IPeNKjMhJZfhtOkEf0QDZhuph3om/l9sCYjHz5djagYUeFFdxbACwG8bCFVl2WyfLiSbEh7vyVn8NMfjmyZPjQ/axnA1eHnaaDsjZh9gAkwZZwyiV6tQAHNY5vE3+C2kCi+UXiKGCwo0iexwRW6n/RHMqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LerMc7i5; arc=fail smtp.client-ip=40.107.100.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LoSt8RDxElcbw2s8zBvkaEiNtozpVY3yUWxSV2Z9Vk/6f0Hjt87AXzWabvUN4CR/2ezK/zEfsbeivx9kYAJJeJWIpN4aEcV0kZI4k9Jz7cqKexjZFkLrydQMPnUwgzw1HtC//GFjl9z3gvlQuMe+jqT/HL9VrN0rjmfXwRJaetb9fnuBrc+KjCCMaYMoCOxgjBF3Kizh9Py9W/k8szXTedmDIX+i6QGfP0U9wP+5Kp37XdYj6p47enl8gexylRu9RR0X/I/bfEvSmxQH4Hx/g9dMHPl+qEMkTm+OWRg9QMbIblC13LKySt2luftJKjlUEBBKhaBgWjt+k+PoshFYkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7e4npBLGVA3lwCcxSXKsA1owcidzo39ZnbGGEBvFoqg=;
 b=SfccOz/8vE2alT/VjcfYDJh5sPTWb2KOr6iOZxo4+RlyqnKxTHvAr1BdBBGqmk7dnZaJ5qJjo1Bc8v69CF/r8Qwt+8rEnPWLx89ZmuuyQg9ICnSa4gszvImMiagrr0Ln0BIHaJb9oQ1z9XQjNHTrv8vFKt6ys+MIByMOzlSPKkL1GzTJ2lvvMNFJL42/GQqLIJimOEPIEzi5TW3EsYyvFHIxM8hCBqmfJbVWGcvbgzFgyoXw0/saSQnxfotsxzu9Fvsfh2s/4HHbX4blCWCV7LObcVjJAp8H8q/bm7GhMMsjDAP6eZ7CITl0lCm2kfMDd/MYEGHWHCuZnD46WtCCPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7e4npBLGVA3lwCcxSXKsA1owcidzo39ZnbGGEBvFoqg=;
 b=LerMc7i5ZlkN2dM6X+T8g2oT7tpimoziaeKWnfH7/UXNwTpTZUdMwc3z3baoATRSKuBM9/MBb2E8H1Uo79i6/DAEzdLi6KkAoRa73vZOUDxX99Qe0S01tFq+5clWITyR9hbIA3IwS617SUhVqRayKzLSz8HChzco53M3PwYR5HvoWogcs4xvOTHXXhGXBYVsYDwvu02gsW+/vc/k3Q3rPqbtf8roPY2IczvN2bf7HH5MbUyaeocux05XMPE8R0w1EhbEEVfO3PHZJ9Gmyr+KyCt2R7CWTgmpoHWWJEXKDVsBxE/uvKGI4wLjNM0bOcDQTzV/VzD/7Tr7CXvOan8WzA==
Received: from DS7PR03CA0014.namprd03.prod.outlook.com (2603:10b6:5:3b8::19)
 by DS7PR12MB8419.namprd12.prod.outlook.com (2603:10b6:8:e9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.13; Sun, 11 Feb
 2024 08:48:51 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:5:3b8:cafe::3e) by DS7PR03CA0014.outlook.office365.com
 (2603:10b6:5:3b8::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.35 via Frontend
 Transport; Sun, 11 Feb 2024 08:48:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.82) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Sun, 11 Feb 2024 08:48:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 11 Feb
 2024 00:48:48 -0800
Received: from localhost (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Sun, 11 Feb
 2024 00:48:47 -0800
Date: Sun, 11 Feb 2024 10:48:44 +0200
From: Leon Romanovsky <leonro@nvidia.com>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
CC: Jim Harris <jim.harris@samsung.com>, Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Jason
 Gunthorpe" <jgg@nvidia.com>, Alex Williamson <alex.williamson@redhat.com>,
	"pierre.cregut@orange.com" <pierre.cregut@orange.com>
Subject: Re: [PATCH v2 1/2] PCI/IOV: Revert "PCI/IOV: Serialize sysfs
 sriov_numvfs reads vs writes"
Message-ID: <20240211084844.GA805332@unreal>
References: <170752254154.1693615.9176696143128338408.stgit@bgt-140510-bm01.eng.stellus.in>
 <CGME20240209235213uscas1p2e8de2bdf05e6e7cba51bd41ddb42a8e4@uscas1p2.samsung.com>
 <170752273224.1693615.11371097645648272257.stgit@bgt-140510-bm01.eng.stellus.in>
 <10d63412-583b-4647-bb5c-4113a466324e@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <10d63412-583b-4647-bb5c-4113a466324e@linux.intel.com>
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|DS7PR12MB8419:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e37bd36-723c-4dae-62d9-08dc2ade4561
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NNBCgLUVYJq/Qo57H2a3Fkd+coZgOmc2Bjd9RPkVq/8MEhAjvwhqBVq6IW1N6zsCTd82BLVzcp2AN2efsGXyEPDCyty0sYISdmveRDmqxkuk9RWgKs/SXFUslwaHwtEE8uclJuT3nWZCLEESaoYOxijgufqg10cGGfO9p1DRbUQQ2H0ul+L4pwh5IFGN3C45b/sezc1qmvBklRQo2kn5cZGbS2IIsgFEbOdr4/hyulfuagY2qj/zBHVyJUQKAwoCTOuSVPOOyT63edyBCzULGDa7V9poCjnpXga8YoFl48Kc1YEKfbSXkULWYpWRUDsNy5cNQEyZArfStO2obJYS/uWirqrCorYmAIKaRK2Xz5aG8DcZSbpqg4EBxWjuwfg5ps8EZSVjJ7aJonrE232n5Za1ePUK2h/xPeJMcMKP7UJ/mXGAW62/Y3wI4XIfDAj0Qhy+h1cwR8fL1NVSn+SaXDGrT9NHDP/PRxyf1y5nct/H59rEvXHmWQlsSPTwhJ6LBkWvG5c6iNR5N9cLgcd+R6jpk9APYjMDY2o37x+5lCUehMMKke/Vu5kr3jVefgjZYLxuai9Ln2998ZbyyNNbhCW5prD6NH2aMPAtya893uSBezfpp5cxPqNdJdgTuXX3TWmEmEGRHf9XcX+AIvyFSA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(7916004)(4636009)(346002)(39860400002)(136003)(396003)(376002)(230922051799003)(1800799012)(82310400011)(186009)(64100799003)(451199024)(40470700004)(46966006)(36840700001)(2906002)(33716001)(8676002)(4326008)(8936002)(5660300002)(336012)(16526019)(426003)(83380400001)(6916009)(26005)(82740400003)(33656002)(1076003)(356005)(7636003)(86362001)(70586007)(54906003)(70206006)(53546011)(316002)(6666004)(478600001)(966005)(9686003)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2024 08:48:51.3478
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e37bd36-723c-4dae-62d9-08dc2ade4561
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8419

On Fri, Feb 09, 2024 at 07:20:28PM -0800, Kuppuswamy Sathyanarayanan wrote:
> 
> On 2/9/24 3:52 PM, Jim Harris wrote:
> > If an SR-IOV enabled device is held by vfio, and the device is removed,
> > vfio will hold device lock and notify userspace of the removal. If
> > userspace reads the sriov_numvfs sysfs entry, that thread will be blocked
> > since sriov_numvfs_show() also tries to acquire the device lock. If that
> > same thread is responsible for releasing the device to vfio, it results in
> > a deadlock.
> >
> > The proper way to detect a change to the num_VFs value is to listen for a
> > sysfs event, not to add a device_lock() on the attribute _show() in the
> > kernel.
> 
> Since you are reverting a commit that synchronizes SysFS read
> /write, please add some comments about why it is not an
> issue anymore.

It was never an issue, the idea that sysfs read and write should be serialized by kernel
is not correct by definition. 

Thanks

> 
> >
> > This reverts commit 35ff867b76576e32f34c698ccd11343f7d616204.
> > Revert had a small conflict, the sprintf() is now changed to sysfs_emit().
> >
> > Link: https://lore.kernel.org/linux-pci/ZXJI5+f8bUelVXqu@ubuntu/
> > Suggested-by: Leon Romanovsky <leonro@nvidia.com>
> > Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> > Signed-off-by: Jim Harris <jim.harris@samsung.com>
> > ---
> >  drivers/pci/iov.c |    8 +-------
> >  1 file changed, 1 insertion(+), 7 deletions(-)
> >
> > diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> > index aaa33e8dc4c9..0ca20cd518d5 100644
> > --- a/drivers/pci/iov.c
> > +++ b/drivers/pci/iov.c
> > @@ -395,14 +395,8 @@ static ssize_t sriov_numvfs_show(struct device *dev,
> >  				 char *buf)
> >  {
> >  	struct pci_dev *pdev = to_pci_dev(dev);
> > -	u16 num_vfs;
> > -
> > -	/* Serialize vs sriov_numvfs_store() so readers see valid num_VFs */
> > -	device_lock(&pdev->dev);
> > -	num_vfs = pdev->sriov->num_VFs;
> > -	device_unlock(&pdev->dev);
> >  
> > -	return sysfs_emit(buf, "%u\n", num_vfs);
> > +	return sysfs_emit(buf, "%u\n", pdev->sriov->num_VFs);
> >  }
> >  
> >  /*
> >
> -- 
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer
> 

