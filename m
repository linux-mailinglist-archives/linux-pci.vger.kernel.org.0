Return-Path: <linux-pci+bounces-18156-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6409ED0F5
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 17:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3004D188648E
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 16:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5869D1D9665;
	Wed, 11 Dec 2024 16:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3tH5r9rT"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF331D934C;
	Wed, 11 Dec 2024 16:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733933646; cv=fail; b=G4a2SIeh55fdZiIPY+yI8R47Fqt1o4MFPDReoPYxd+LEPkNLTDnjvuvd7j0EbUFRN6w7ts3bjPIpuFJO0PjaxoTHY9lWq7vHn71VgIpVtnvhYqFHddykeMKEPQGAZkuRw4E9bjq2QpnA9Re94frdCxhRv6TEDR5IgtvNjhryl9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733933646; c=relaxed/simple;
	bh=3rIEiYUSgPpIrboPketHQCUcAbZPWkLNFgZAkilyHVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JEeVw60f/QZ1CQTzOTf/WiDZkW+syjWMHGTNbUq4FLVzMaBr4Igl3fvwxV4SPS190ujkK7UL8pKv+1PJMRE77ByC0FlSp2kECOyCBxhs8GXkq83UIr5N+aKCEj1b4+JfwemJ22lzNsZIzVwOHiFqf6qTHS8xFvwwmhOwsfecyAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=fail (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3tH5r9rT reason="signature verification failed"; arc=fail smtp.client-ip=40.107.237.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H7xecdvpUqR8n2IUJjxfLxVp5i6A9JFAMS1XVKK1mppwuWoyy/aIrtwitxsG3tuncCbDsRLASw/BLy+0CJI4JwQJ3H3r4+IjqC6AsdY3HddLmGRDRsQjYgNuncmv9MGp41w9MnnQ5cwyVAepP+KBauclVWBa3g9/1cIluPC/vgrOiTL6MQNRmii1vQW89fjgjL1300ZmtAiFnoncwwGd0xDeE+pcykWo+uxjlROFo65ivGWgB+54LU9t1kQGy8a+E8NhdEcZmPWehpJh3jI7coQcnrACc4Atp77Ssz/IaFnolA51FeZOJ1c/i0l2VPa2FQyLljgW+xhJ8R6O2g8MuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xEtKxEZMfAbg7jIbl+c2V2PQ6sj8WtPE31AyO6JqvFs=;
 b=QiuBCR3Ly4n2a+0thSWkdkYd29jyDEGSjLL4lX9QeC9LKeKp4nFTGB63r2/kErewQWf0HZw3TNchp+CnKSHOGhP0qgIADdDymFXWwT0rdvqQEA17amYwLGkERSMIL4xbMEWQSaCM8B2bA7j1kIMDGRwLEcHGFLvwEdNPQwgduQ5sO5FLWCfSg40iOH9ue2vetzXb+TmfVh7lyl2OftwpbmZ8w9ee+2+TpvnLUttiAwJdkZXKkZxJPK2YGz78AAUMaY+yl1zIZpBut5DOoURh/piKdIYW0rCe6MXKzoqxki8rqfB4lfS2EHOngvkl9o37xT1gKhTKQz0twrrbQq2Txg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xEtKxEZMfAbg7jIbl+c2V2PQ6sj8WtPE31AyO6JqvFs=;
 b=3tH5r9rTpNkJjARRgI7iQiBkGlVB13Mr/yp9k6fkHhAR/89MExfPVgX0PB5hsWcne/Jo1C7JGZv+xrB6hOYqFXlgfFuggwVFzVRE2m45QNuN/bS4PDdvwiYT0jpLkyNm2rT5L5StdCxBuReTi8mAN4QnCj4YIvuFgUKQkxl52KE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 CH3PR12MB8850.namprd12.prod.outlook.com (2603:10b6:610:167::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.22; Wed, 11 Dec
 2024 16:14:00 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%6]) with mapi id 15.20.8230.016; Wed, 11 Dec 2024
 16:13:57 +0000
Date: Wed, 11 Dec 2024 11:13:46 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: x86@kernel.org, Tony Luck <tony.luck@intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Clemens Ladisch <clemens@ladisch.de>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>,
	Suma Hegde <suma.hegde@amd.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-edac@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-hwmon@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2 14/16] x86/amd_node, platform/x86/amd/hsmp: Have HSMP
 use SMN through AMD_NODE
Message-ID: <20241211161346.GC1923270@yaz-khff2.amd.com>
References: <20241206161210.163701-1-yazen.ghannam@amd.com>
 <20241206161210.163701-15-yazen.ghannam@amd.com>
 <af6ecea1-1be2-6882-2c74-24ffbd26ba03@linux.intel.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <af6ecea1-1be2-6882-2c74-24ffbd26ba03@linux.intel.com>
X-ClientProxiedBy: MN2PR08CA0016.namprd08.prod.outlook.com
 (2603:10b6:208:239::21) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|CH3PR12MB8850:EE_
X-MS-Office365-Filtering-Correlation-Id: cafc727c-bdfd-48be-7dd9-08dd19fed0ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?9ioiW8HQrIF68IN8SiqSw1w+8SaT5bWTiKVdHFIkDYhSET3I6bn8hspbhL?=
 =?iso-8859-1?Q?ZM5x1V+HGi+arq9d0LfluvVJR0hY18DrRdMWbSI9mYzSuBU4oad6/ueEtP?=
 =?iso-8859-1?Q?ZgMD6F0pmaSrpdkRAHHFK/2Blxx5ldIr5rDOruPfXTdSsU96DbRYtsBSlf?=
 =?iso-8859-1?Q?0wQ7N54O7y2q/Kuhz+RHjKbtQQlFsDwXeesNp5brFFUgPY/KTM2+XYkZZ8?=
 =?iso-8859-1?Q?yEnNWWnZqvZLNV/76PB8H/Lu0iWpUH0yVFJHPf2GWoxiJJ5xDjwQpYSIm6?=
 =?iso-8859-1?Q?kJ6uiD0q0wi0g3ef6JA4UNpuFvIK4vSsnPDNHKF2x0W6+PODXo4Pi5qUA6?=
 =?iso-8859-1?Q?UByBYee98maQ9hJqUzdufJxQuTeNr/3uMYD0Qcs8twWPDWqFqfjpLLYLNL?=
 =?iso-8859-1?Q?ciFbTiy/XhAVHg6fspl8fEy0mV7lLZnLshDHFZAcaeWixWcE6gMQxoRkAs?=
 =?iso-8859-1?Q?M5JPGpTgSiJ+ZplOT8UjAArFPN2Co5Kw3XTPCGTSsY7/Bhf5jkD/deBGJ1?=
 =?iso-8859-1?Q?31vmAHPzM8nJo+XZvizGqmg0erVqWDtSOQ357EG99jM3V1aXgMDQHrkcC8?=
 =?iso-8859-1?Q?aAiiZ49Ew5VjVVGRm6Z9bBmEdUe9UtYsNzHHY2sBrUxxYWNlnhcs9k4maL?=
 =?iso-8859-1?Q?MjJzkn8XCYrpRYyXl8xCoRJVtuB/h6pZRAxdA6yF/YLmVxVSYI+MT/aChF?=
 =?iso-8859-1?Q?MdTwk8JnBP/BEfp3QQTD8iTZVpWMSXlSwoL99NQ5qNDtkwtpPTpMkZO7nk?=
 =?iso-8859-1?Q?yWEqkThCwi8z4PD1k7A2elQM+hkWMfkKc1LpTr44QZnexpXmqABOLg7Tqn?=
 =?iso-8859-1?Q?1C89D8mmjyW6CPCNcGbiQfiTqkR9C4hY0MjtaYBkO6ROTVCcCc8oRPEBKr?=
 =?iso-8859-1?Q?lSN3CDEdNJD0XYTmfLzbTCNgl9T2bdpt4FTGtlwI3GISXgZA4CE4bvRgy6?=
 =?iso-8859-1?Q?noE7AsflGwt1VMVurDSWd60MBRdvacHFMAIFCocCsRb+HRQC86jb371d1Q?=
 =?iso-8859-1?Q?OXgmQoa9C1gbell0FWVvf546IxQs1QFFMB0zAg3l4aku9H6rEY+shJBtUh?=
 =?iso-8859-1?Q?MQyBzhjblQIGcaAAnOYBg2ACEWxMqpE+emHbXTy51N88i865E8y1WHGQIC?=
 =?iso-8859-1?Q?jlEjYVaG7R7WBz19EJdE7r/uk5Xs1mG5TQ8DUmUJnirfRIMUYkrIMmqKaG?=
 =?iso-8859-1?Q?xyBqSSdIXGXZe+qu8En7t5uG4DotWsLFZWWnAIsv5xItjhtOAvg7gyFuof?=
 =?iso-8859-1?Q?MejoHCATxsZLaW0d8lyM8pEeYLWBNcncKm6v+0MnNcOIQCuFQUdM9MULmq?=
 =?iso-8859-1?Q?+JPBrgHxrqOkKDZYNG83ZJ7CYoBZG4XyaOzBeULTyPHJp/XZcNWOzLexpS?=
 =?iso-8859-1?Q?Mnb6PgtAAVLhRSpQANEu94fBFzFu6frw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?mJcMAVMUkVmdV/St7OvSYHMRCEp+wgPmKz7miPYkyV4GSlvUomOEbTvLLj?=
 =?iso-8859-1?Q?qMKtSlV9odEaG9/vvhenGfqjw+i6AvhK38iYZJQvvP1CEqm/xAudqo+ew6?=
 =?iso-8859-1?Q?T+DHx1HYxVCFZbdIbWB1A5SykG7EmjVw3gxYO6Kf0qZhwoddXmqW+WRhMT?=
 =?iso-8859-1?Q?voVxUPtqcwAjaMRQMh8uNln/KKMdc5llATRh09ANyCJK3KpPsusT6L0pBK?=
 =?iso-8859-1?Q?bOP0Dk+aoKIElk6jg3CYRhaN3/PKUtuKEZiim3B76lBMI3WonMoPyhOcV5?=
 =?iso-8859-1?Q?3vrBQptz7VpWGZUFNCut0gnx241oeu0Mld7guDtQyRcAcuR124rUAR78fv?=
 =?iso-8859-1?Q?X2ZuxheDHAniVGaA6rTM0uJU1T1tVMLkSMxRT0ThI6FuUaxql2Yh2YUV8B?=
 =?iso-8859-1?Q?uNCBahrYggOiBvXwIK3d4QW5dVdMtxhb/MeQArzyu76bOSUjRNc5Do3wQ9?=
 =?iso-8859-1?Q?Djt3xrlHnlwXtYEj65R4DolbauE+68jeho/YSnTqlZTgeOVOaSgO28w2PC?=
 =?iso-8859-1?Q?ScxaCsoSmpWFzCt8+B1XcEh4ViX4crrIpzxArC4zv330J49YUceHbEHKq0?=
 =?iso-8859-1?Q?zz+tLeq43Q4moTglaWOBY/LI6aRST8iQTp+AtoadhdBjNDbaINOH1Xks27?=
 =?iso-8859-1?Q?4GZXuYJzK2p6TMWB5/jVaVh3Pgjx+dMsikWyX9CovCjKFWrDVUBSm6sxoh?=
 =?iso-8859-1?Q?Jy8XFE3vVVrWi6m0VN0u4+EFhuGlOkFczWjgg4y/rkVo8CQuwvk0uf5F6i?=
 =?iso-8859-1?Q?B+S0/MpWMpkwQhJ6nIe2rkju/ET3ROXN87lVFJrS7QlbebGPM8EOvkwHX+?=
 =?iso-8859-1?Q?fLVrcZwGEzpW8V4jQVIbEIZvFl/bGEaoPaRk9dUGw1S5azRjbVUT7BVmEC?=
 =?iso-8859-1?Q?seHXy5zHhDO4KCY122Cj1dJVAhfTx2jYcnO9QSo4HLqt84caKVkTQ5Knc0?=
 =?iso-8859-1?Q?6TVpT5xYaBWIhotDdimyoC8vLQ+UHzhYRvNTmQDi/g7enWhdf7Z+v6blV/?=
 =?iso-8859-1?Q?mjAcXxBVNgsUzAsre+BGKJbSEQTzKkaDX/ZXq2AgGx9adkZfcO31y07d4t?=
 =?iso-8859-1?Q?BMqrsrGAQN/ox7gLSLDm4lXUaGmH3dZxb7sGnyu3gmh86aR+SLCL4BDKGs?=
 =?iso-8859-1?Q?8+WHgxzgNf3oFw4I9spOPdTX1MQqq3//uW6dsF8RQbSE6JAbBnPUwd8dTg?=
 =?iso-8859-1?Q?OhthFjiiCSH4Oo4ugRKOLFHplTExIPBdFXfNRUz4w1NnJInWlZEt0GEJ6l?=
 =?iso-8859-1?Q?GOwqz8pyIjoINJ+qPKEAJybtZ+ytYOzt0JILnjoLVkrEtTfdpwtCyWxQmd?=
 =?iso-8859-1?Q?9+dCE+T4O6idTtPwOLZKfmOOhx0ArvfVG0ChgwfBo4AyTCAGPiHbUldda7?=
 =?iso-8859-1?Q?mJRBrNpzeSuoqjcsmT6NNZl1dxG8nBPeVpwyURXhORYLeiTepGVv/9EvQy?=
 =?iso-8859-1?Q?W1mbBSbRREmwv/lCVmk9hspUbsNBfFJcq7qQLzZA/O/bjjCNliNS2e1p+s?=
 =?iso-8859-1?Q?d/XVqqQ8/fyTH+tgDImztrU8c0UyPOQeVoxkXdcP1tXhjW905eBPgsMPli?=
 =?iso-8859-1?Q?KRHhRSLBqvrorW0OW1ckb0M29E79hE4tvhhH/i8ICGqV5zkYMSgahWuXnz?=
 =?iso-8859-1?Q?lkMe2oefw9hqwDjqASaSnbEPaSLeV6wu0+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cafc727c-bdfd-48be-7dd9-08dd19fed0ea
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 16:13:57.5955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F8z3px5d8aHmI5AqmDJySco+gdy0v5c4sry5POjBSpCZ/PN9y27BYG5bxqI+8K3VWkC/Fdzo0AUThHa3LQC31Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8850

On Mon, Dec 09, 2024 at 03:32:02PM +0200, Ilpo Järvinen wrote:
> On Fri, 6 Dec 2024, Yazen Ghannam wrote:

[...]

> > --- a/drivers/platform/x86/amd/hsmp/acpi.c
> > +++ b/drivers/platform/x86/amd/hsmp/acpi.c
> > @@ -10,7 +10,6 @@
> >  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> >  
> >  #include <asm/amd_hsmp.h>
> > -#include <asm/amd_nb.h>
> >  
> >  #include <linux/acpi.h>
> >  #include <linux/device.h>
> > @@ -24,6 +23,8 @@
> >  
> >  #include <uapi/asm-generic/errno-base.h>
> >  
> > +#include <asm/amd_node.h>
> > +
> >  #include "hsmp.h"
> >  
> >  #define DRIVER_NAME		"amd_hsmp"
> > @@ -321,8 +322,8 @@ static int hsmp_acpi_probe(struct platform_device *pdev)
> >  		return -ENOMEM;
> >  
> >  	if (!hsmp_pdev->is_probed) {
> > -		hsmp_pdev->num_sockets = amd_nb_num();
> > -		if (hsmp_pdev->num_sockets == 0 || hsmp_pdev->num_sockets > MAX_AMD_SOCKETS)
> > +		hsmp_pdev->num_sockets = amd_num_nodes();
> > +		if (hsmp_pdev->num_sockets == 0 || hsmp_pdev->num_sockets > MAX_AMD_NUM_NODES)
> 
> Hi,
> 
> Now that this define moves outside of hsmp files, it would be useful to 
> add static_assert() and a comment next to the attributes which are always
> created for 0-7 sockets. That way, it can be detected on the build time if 
> the define changes and more entires would need to be added there.
> 
> Other than that, this seemed okay.
>

Okay, will do.

Thanks,
Yazen

