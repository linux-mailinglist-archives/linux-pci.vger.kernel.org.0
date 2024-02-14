Return-Path: <linux-pci+bounces-3431-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3672854353
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 08:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88BAB28DC6B
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 07:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E515E111B0;
	Wed, 14 Feb 2024 07:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZSJLOksw"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D335125A1;
	Wed, 14 Feb 2024 07:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707894996; cv=fail; b=tXzpj0Ni21iZewMRKXReeblrQ12V4omtRx3t77c7GBHCGIoyrCLuVMKM8F0T5BYv9xieY4wQJlr9B9L40aKa6eU0oTSoM0os8wpBvTEMR7Yy0gNn+SqtSpq9vKq3c3+hZ97o63Q6QiWi9+4qM+G9dijBto2RL32lqkUeWV/h8Ks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707894996; c=relaxed/simple;
	bh=FRvFWm+32/7VfGTiGL1SS0wdxc0F5za7gy39FMQfDVA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rhMEsk7IWB1cMA0YSNG1BOhqP9ZIjiXkbFl24am+1FrwuCwZPfBGxfN73dr+nRxrVrJ2RfxxQI1+PB4DAxgFQ2kkUPoo+BoHXLC5HnMOd2q7Qe7b1wwdtGjCpAspdZSF6QDF5Z3duFpy5dNfTKh9VoCoYOYLME0+MZ0UNSN/eZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZSJLOksw; arc=fail smtp.client-ip=40.107.220.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LAOkrtw61oEoiL6oZqjS7UMUjk8VOF7NX+Q0S2HpYlbrs9CMTumMQfwEK1AVVoD3egEBOtSTBNdZ8GYBPnTm4UbQuVAaZ4OR1rlzj8/dwh6IU8lENvd0ktG/Gltv6ME8qUzb2uNP8cVoveIHVqjrHV+NyZw1cVYEDg5JFKS9rnLJbqknP4pH/R6vTI26KiHy+73bYN1NnRdYa1U84/LilHUCJ3EOqYIuTeI9WYuxBZYL1n70WMXIKUCWQ+y7qytF7BeZPDJnXinVvsydCqNGmP+fLucGdgT4l7/ofLI+l3fBmCJjqxTMp6nDO/x8+bkfT8WEgL5trQ7C08jRsmDm/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EQWRPhiIkoqYl5+sKcYtVTtC2mmq1Qd+g+Ut0N32HEs=;
 b=hqfFmO9OcncFeFt5jO3KrhEF7m0vwvCiDa9px/BKXqh6dc9rWMGuOvpb7JQHjPO9iGXAkXZrGU1oK36y3eEykGz08pv5CASZyNaexb4XkrGjFfsmAQmD7N/NRst8QSHodlzGmdhDWqyCfhfBLFcYUIS1/dA9hbFAVLMfVLeKohwdvsMNYWsSflSwrnp0mWsd0c/SjPjp8w00aM9yvhjijD2Mvm4a4+EyG7Psx9y/IjZngX/N9BdgmI2KQL3ccOlQoBo+QdQKkKmWwr2LNpyiB3KXm1TYg+trBnbp+YiOfMhJ7Hv8oNY25jEWWiIT4M7+dfqsJ5bAOLYtCuCNXtt4FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQWRPhiIkoqYl5+sKcYtVTtC2mmq1Qd+g+Ut0N32HEs=;
 b=ZSJLOksw7V/F95/nRNcV9dVkgX6OjaoQy2GTMN4CsUVPUnXMhVPpsUbaPM2n3Dn8AKOIM32nMyFW55pmY7IIYkDxiWlxXXm3cbeNpmWrJpNQuMbZVAhCxOx/EN+/p0Jmq8p11SKqieUdb3MxKEbRkDa2D/n3IJ4W4GMSbDUQG5UFPwx1y//AbF07VhMQYagh3FpXLskfOTdpimfNTI87d9UhhEfAP8qpfDI45/0nzaA5IpREhD6yaNxB20fASY52mOdtMUbvyfTxZI1iHef8jUiojMbqu5jz/EwZcJ0/Y+DYv8b2gSvOlw1zYvOQPJ8HqIJhVaw0WWhz7uCEuFBLSQ==
Received: from DS7PR07CA0013.namprd07.prod.outlook.com (2603:10b6:5:3af::19)
 by DM6PR12MB4562.namprd12.prod.outlook.com (2603:10b6:5:2aa::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Wed, 14 Feb
 2024 07:16:32 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:3af:cafe::6f) by DS7PR07CA0013.outlook.office365.com
 (2603:10b6:5:3af::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.40 via Frontend
 Transport; Wed, 14 Feb 2024 07:16:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Wed, 14 Feb 2024 07:16:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 13 Feb
 2024 23:16:22 -0800
Received: from localhost (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 13 Feb
 2024 23:16:21 -0800
Date: Wed, 14 Feb 2024 09:16:18 +0200
From: Leon Romanovsky <leonro@nvidia.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Jim Harris <jim.harris@samsung.com>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Jason Gunthorpe
	<jgg@nvidia.com>, Alex Williamson <alex.williamson@redhat.com>, Pierre
 =?iso-8859-1?Q?Cr=E9gut?= <pierre.cregut@orange.com>
Subject: Re: [PATCH v2 1/2] PCI/IOV: Revert "PCI/IOV: Serialize sysfs
 sriov_numvfs reads vs writes"
Message-ID: <20240214071618.GE52640@unreal>
References: <20240213174602.GD52640@unreal>
 <20240213194556.GA1219770@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240213194556.GA1219770@bhelgaas>
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|DM6PR12MB4562:EE_
X-MS-Office365-Filtering-Correlation-Id: 70244199-0eb7-469f-4898-08dc2d2cdf00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	J00g+ZXaF3v1ZaOKWro3GjU5NThcTWcYu44y/ZlOYg2Hoz/aQpuG7MoIPeA7WLFbzD/bbbr5i4pjh+fxIVPQkdfxHXrj+jQLFA5F1n0QuL2AY86JS5VO6Bkptw3J7NcRps1kE6LJAYpnpM8PXdl8p1sc4+P269wCOjSfMyw6bcNnYUM4aZ9EFFjkA4zg5zCkCO/NuznL1gXkkX0KnqTrhZRhfy+IG6AOq5zX3pMrzt4kJ5H7mVh2pKCLyip1r5ummu9IxP5smtaGUVfUq5ajq/ZsvuYSmBaJxWnDg2Bfl6j+7gIu/ebMsfiivhIS8zf4e5dO3hZQI8vVtfb3KRMEYlS2Wpb7wv8aTOaynnMMQ/wGIE6vDUIc8wA+YIR88whbo/88X8YvRb6jzpsp9VM2Dy06uvyFDq0LnganbyZFDtIGI4ha51zHQfCgTLu2fzSqs9Fq6IfqJavN/WaaRZIIrduS1C7wnLhX4qL9KLY28nwYTz4pYC0AYiVmJKMlBQsfAJoMHtuCL4n1DUSSbrmtdKpeTjGsVlR2awKtHItHbU4s2xR09iJusfzZVxFVidGny4sUeCjSkCYueI/IX+ydnTWffJqsqS5HW/KdhkLFNT0=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(7916004)(346002)(396003)(376002)(136003)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(82310400011)(186009)(46966006)(40470700004)(36840700001)(2906002)(5660300002)(33716001)(9686003)(6666004)(478600001)(1076003)(7636003)(356005)(82740400003)(33656002)(426003)(336012)(16526019)(83380400001)(26005)(86362001)(8936002)(8676002)(4326008)(6916009)(70206006)(54906003)(70586007)(316002)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 07:16:32.1354
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70244199-0eb7-469f-4898-08dc2d2cdf00
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4562

On Tue, Feb 13, 2024 at 01:45:56PM -0600, Bjorn Helgaas wrote:
> On Tue, Feb 13, 2024 at 07:46:02PM +0200, Leon Romanovsky wrote:
> > On Tue, Feb 13, 2024 at 09:59:54AM -0600, Bjorn Helgaas wrote:
> > ...
> 
> > > I guess that means that if we apply this revert, the problem Pierre
> > > reported will return.  Obviously the deadlock is more important than
> > > the inconsistency Pierre observed, but from the user's point of view
> > > this will look like a regression.
> > > 
> > > Maybe listening to netlink and then looking at sysfs isn't the
> > > "correct" way to do this, but I don't want to just casually break
> > > existing user code.  If we do contemplate doing the revert, at the
> > > very least we should include specific details about what the user code
> > > *should* do instead, at the level of the actual commands to use
> > > instead of "ip monitor dev; cat ${path}/device/sriov_numvfs".
> > 
> > udevadm monitor will do the trick.
> > 
> > Another possible solution is to refactor the code to make sure that
> > .probe on VFs happens only after sriov_numvfs is updated.
> 
> I like the idea of refactoring it so as to preserve the existing
> ordering while also fixing the deadlock.

I think something like this will be enough (not tested). It will et the number of VFs
before we make VFs visible to probe:

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index aaa33e8dc4c9..0cdfaae80594 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -679,12 +679,14 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 	msleep(100);
 	pci_cfg_access_unlock(dev);
 
+	iov->num_VFs = nr_virtfn;
 	rc = sriov_add_vfs(dev, initial);
-	if (rc)
+	if (rc) {
+		iov->num_VFs = 0;
 		goto err_pcibios;
+	}
 
 	kobject_uevent(&dev->dev.kobj, KOBJ_CHANGE);
-	iov->num_VFs = nr_virtfn;
 
 	return 0;
 

