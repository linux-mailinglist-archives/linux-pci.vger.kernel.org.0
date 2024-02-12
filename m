Return-Path: <linux-pci+bounces-3349-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE418517F8
	for <lists+linux-pci@lfdr.de>; Mon, 12 Feb 2024 16:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 407EC1C21E8C
	for <lists+linux-pci@lfdr.de>; Mon, 12 Feb 2024 15:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B2C3BB46;
	Mon, 12 Feb 2024 15:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oIsZtXhl"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7522E18646;
	Mon, 12 Feb 2024 15:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707751823; cv=fail; b=BraeQekzNtIarU1axNinR0aHjm0CmRlKcz2UsckPyQVriCvsZcJFdl4u5et8nVAjVfml2u2tZqSjCuIe/RBEzO447/g2rt/SsBmijUCW9AaRSHhBjMyJ3lp938ttkXk1qANizGf/cQ9V6olcLSzYsyGclyrJV/fHbUVcZEaWigk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707751823; c=relaxed/simple;
	bh=XDdWQU2iP2UUnBQfVwYq3sNSHEsNlD57WE5bXUnAzms=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTCqQmlXigmD0JV6N/k3wghz4TUkpmzdLMJJNi6ky2JoYIwUezUBjLj0nngkjCl2H4Niv7Po9h48otPSiMBafqbrtWoDdxttt/XReek5JbsNUFpBThoApQAWgnDiq29KQCqMKXfGqo1z1OoXVQwLlCB94AGy6XLLcZXQHgGzyf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oIsZtXhl; arc=fail smtp.client-ip=40.107.92.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NF1E0TY64LwaRbZe2eTT2ys7V3SiFUOkG1RbUKhklp8sCdDd1CL5v3DMMYZsXuhZVAgTQPWA3XSrdGXZa16VpgI2d6CqsAwbPvwn/aqGyh+34fSItFlG5IDTKQ78wIZtiSUmBBpVZXFHRaANEEsNPeeAofAAIzBX5fHvxLBSRJDH4wgRRd1MYiDiqQiG+J3m4cQW16rGsKGS8uDGf5u51Hx+//miBLQjY9vD+32KrL17FcdY/RXdO8hksoyIrx2ZK7CSMXKeyAGpcI2mPM6T05A5oxSH4x1m/FeM2Vh9Wi/NWDu64gJbi6VP/88G4ItCMfkH73fQ/A6rTAvNBj3w2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3JbtACg+KAFE6HG4u6aqwWH+75dMx9px6VOTU2Hj3M=;
 b=nbaChD0xn/2tn/OsJ1myDs+YxqfCo/pWqQksYKNUcX4qv4WWLzTCZgPTqfsH+Ii1FCnreShihOtMywSPCag+kw2PMSjdtEt+DnDFzA0Juo8+81ulFbiE9sNGRqMTydwoohlRhoSH+lb1jYCKpQvuURj0P5Z/q1gX8rCWzSqjpiUBJZ/hvpzOa5zMiDSy94ho2lSnpPWgQ4DNuL0FM0OmVqWFQXs8yHXN3E0Lk7k4XICtSmF2yc9l0lH/whTRlGYTYOOf8PDv3Ux5Z5P3kKNaGbhvTxDSixKyjoUyJH2DZDV+a+T16tmwR87kGfyP2r/vSyUhOU/umq1iUQ0W4t5nFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3JbtACg+KAFE6HG4u6aqwWH+75dMx9px6VOTU2Hj3M=;
 b=oIsZtXhltFELo7NDTgoY2ZJAcrAjTj35qJsuF5RQBAKeematwNECQ8a3ggtMXtnamrBEPPc+MkWgySYS8O3hUSTVLvreD1IacHkHP/kS74lSUm7iJ9LK+ybbxcqUx61rlS3JQBqrOmpTxWtPn7EUTLKSltnrKjKsPuk6zSMc7PnaaD1sXAFMylcZro/91lZTuF1VaN42JNq2xAkjCSlRnuSsCY9JRpoWkQwvK3PVSNlKDn5vgU3z91XQopIla8nfgfjcOP+GZlfwcrLtKK1jJ3UcN5DfcBIWY+NJ2EKuxOtk6nWqD9/anLypnLAhnTTxP9uWHSyxdhg0RLxMI0/N5Q==
Received: from CY5PR15CA0108.namprd15.prod.outlook.com (2603:10b6:930:7::24)
 by CH0PR12MB5138.namprd12.prod.outlook.com (2603:10b6:610:bd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.24; Mon, 12 Feb
 2024 15:30:18 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:930:7:cafe::64) by CY5PR15CA0108.outlook.office365.com
 (2603:10b6:930:7::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39 via Frontend
 Transport; Mon, 12 Feb 2024 15:30:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Mon, 12 Feb 2024 15:30:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 12 Feb
 2024 07:30:03 -0800
Received: from localhost (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 12 Feb
 2024 07:30:02 -0800
Date: Mon, 12 Feb 2024 17:29:59 +0200
From: Leon Romanovsky <leonro@nvidia.com>
To: Keith Busch <kbusch@kernel.org>
CC: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Jim Harris <jim.harris@samsung.com>, Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Jason
 Gunthorpe" <jgg@nvidia.com>, Alex Williamson <alex.williamson@redhat.com>,
	"pierre.cregut@orange.com" <pierre.cregut@orange.com>
Subject: Re: [PATCH v2 2/2] pci/iov: fix kobject_uevent() ordering in
 sriov_enable()
Message-ID: <20240212152959.GB16050@unreal>
References: <170752254154.1693615.9176696143128338408.stgit@bgt-140510-bm01.eng.stellus.in>
 <CGME20240209235218uscas1p2d0978af6623037fa1b9358a2ad2320c5@uscas1p2.samsung.com>
 <170752273749.1693615.1293677023514112939.stgit@bgt-140510-bm01.eng.stellus.in>
 <d9c89ad1-990d-4a4c-a16d-27d978673e57@linux.intel.com>
 <Zco2pmQWR49V9Imw@kbusch-mbp.mynextlight.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zco2pmQWR49V9Imw@kbusch-mbp.mynextlight.net>
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|CH0PR12MB5138:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c7f1d84-2ae5-4d7a-cf32-08dc2bdf8471
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6r00wW0JdY2d4vT1nfR4ZMPa4gzaBWriGDkkYE0Y1CU+sMc1DQ2CiT78PpJmlE4TrtCoGlX7ZSYIvS3wqk7Cy05OQiB75BHKrV9VuWXpws6h3Wonlv97fTFvu5GcjHHu/JHPtEFAsPuH78JiOPCbnkgPtntsKimg/20nz+LzDMNrAU4h1pgg+rq6pQ8BBVqCL0RrgwoKgk2pVKiPAoNDDqapbDT8X1FZDmJp3YX4sw56hH4D+eIsRlE1uw7JtFSYMaOFHO06IU6jMjkEfUQhN422DZQ75+u/lhn45bRxHPwdJll7OFWbKi7/bNqYmNAZOPSHptF8Nk4hqpr4UsYrRLQt0PI6gPusamWrnHirfWunCnC5aN0b6eKXjMQkcWuQWZtUQoVguwv33tQ93e4M5Cmxc9k4e5S52tIS2r1psLpfvklgHAduAyWfpVsd5jfrDxrkBa0ocqkIfRBRKACA8glPYi+9/mIzIR5svUfIltW0ZFGx9tMtoiaGtYNKYsQ2KoS87u/TTqm2jfunJfCI48LqrqwTmNkIualnitw/c2wn8ZlyCDVY5dzBasv6skVmaV3JaFuBe01aGjJQJ0kR8GvuKvkd7FVFxrFVGM3zZqY=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(7916004)(4636009)(346002)(136003)(376002)(396003)(39860400002)(230922051799003)(82310400011)(451199024)(64100799003)(186009)(1800799012)(46966006)(40470700004)(36840700001)(1076003)(41300700001)(83380400001)(16526019)(26005)(336012)(82740400003)(7636003)(356005)(426003)(4744005)(4326008)(6916009)(5660300002)(70206006)(8936002)(8676002)(70586007)(2906002)(478600001)(53546011)(9686003)(6666004)(316002)(54906003)(86362001)(33656002)(33716001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 15:30:17.8114
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c7f1d84-2ae5-4d7a-cf32-08dc2bdf8471
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5138

On Mon, Feb 12, 2024 at 08:17:58AM -0700, Keith Busch wrote:
> On Fri, Feb 09, 2024 at 07:22:17PM -0800, Kuppuswamy Sathyanarayanan wrote:
> > On 2/9/24 3:52 PM, Jim Harris wrote:
> > > @@ -677,8 +677,8 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
> > >  	if (rc)
> > >  		goto err_pcibios;
> > >  
> > > -	kobject_uevent(&dev->dev.kobj, KOBJ_CHANGE);
> > >  	iov->num_VFs = nr_virtfn;
> > > +	kobject_uevent(&dev->dev.kobj, KOBJ_CHANGE);
> 
> Since it's accessed unlocked now, I *think* this wants appropriate
> barriers to ensure the order is observed the same on all CPUs. Something
> like 'smp_store_release(&iov->num_VFs, nr_virtfn)' for writing it, and
> use 'smp_load_acquire()' on the read-side.

It is unlocked only for sysfs read. IMHO it is overkill to use stores
for this case.

Thanks

> 

