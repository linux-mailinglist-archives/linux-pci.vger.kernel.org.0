Return-Path: <linux-pci+bounces-7464-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F5E8C5A1A
	for <lists+linux-pci@lfdr.de>; Tue, 14 May 2024 19:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20FEF1C21379
	for <lists+linux-pci@lfdr.de>; Tue, 14 May 2024 17:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6510217F389;
	Tue, 14 May 2024 17:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P9A9RIGX"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF93D17EBBD
	for <linux-pci@vger.kernel.org>; Tue, 14 May 2024 17:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715706849; cv=fail; b=Nx/8m9QOURnqt4DINPjwnbcWvFf0PKvSwQJlIAU0skwflG8MUjumVogZ3szd/oTR2hZ+KX1UVV3aNQErVyBh/nEoCcu1UWzUYDwxuhivgNdUnCbNh1st5nq5466kjiZUM5t0lgi5AhZAHtM7rdt1uDe/Cj/V8CgXCQvk2StW9B4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715706849; c=relaxed/simple;
	bh=vl89+L7sE94M9RrOMnwEogSmaoRFQMBIjlWNIBQ2mVM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NqIEnkeL2XSIXpb3UfiSCwtezgl1t2qLnEEDY0q07AwO8vnuQNby/GCnEKj5yr9oTjpMnFPniLM/3OyrUNuRD3uT8B3+tH0mvg88Z+bX2WmEQvQjUvXzgScpX2p3HrNAwondhaqKkMg9BTO++WlCOIKcoQPLZDrNl3xThpdyvd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P9A9RIGX; arc=fail smtp.client-ip=40.107.236.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OTFGq3pGvlUASunNvqlZuKDjtjRqYWwjUIQTPeaVKtasugdHcIvLKCq92DNieYEP+jGB6oqu+H/Oftl0vvzbSADB1YIWoZ0rxNQZdmFNMSBjMcJryjpbCs2eD9VCVQF4V0YTUfFdL8jVuK58EPD1Xznx3RwdbVQ0dZa1HLfNlOLFnpa8DDO+kkz9EYCtGk60LOJUlWswkcsoywmuNGez9OfGiihJSjv9KuR4+QT/OY73d6f7AQEiyGhzkcNIUlisMFqiF9HNTHvT3i9qmbJxQshovv39GqepJcP9I9/yXvLEzG6hEpUooU+Uz81eEswrl1WgCYS1ugIEHWtEKoB+RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=byFYWsS+d8tJrIqWWjJqcR63yJqDST4wd6kmHf+CTlQ=;
 b=hSok2sVsPfoKQ8nGO5ei5D/GjReH46p5hQhBP0M8ltAMl4jRMuHlboqIvPVwAeGmEJ6424bM447sfryOU/BQOD/u5vGKzPO/WzO+ewenKb8DqvS/bATUAiYlUTk9szM7WP2WwsKS/vcBlzwb5+zytDWQWQXXHjxOZREEuJiAB4Xscr39y6pBoPzsCUl3LxyFAhQnEjTTqaSFZhrUcKzC1/EgYDd+0Xo0cfObA+Pa3UuPaOFeXJwS7z3YqMpuulF/kgUtf7VnPFmRrMiNCPvYqXJW5EU3NAjsnOJlb36/hE4b3JRtliPx1LUbw9Fjn3g3L/wLoUNEkJ1bOP2xZejrtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=byFYWsS+d8tJrIqWWjJqcR63yJqDST4wd6kmHf+CTlQ=;
 b=P9A9RIGXOjjVK3+8AzYJXy/HrV0TokmwvemSu9jbnmCfP6sa9BnxwHTmK1h/BuBVPMRwTMTJjyn1SfpFE/wocxbBRM8JJDijU3gWPccTlzKcO5kcfirfVaZxxz9QqUliAa8vJIlEKGlFAb31f3BhmlWVhemghU6KBL7V1MXUMF6ClmvHi/jwTi8pCh7Z9srWS4Xa7aAap44Tto8+10dzRFyCpExzPx3TYYbMxVek3jguTkm13INXFZHyeOl0i0T45+ZBT/4IvAp8e1B4y9mI6QrIGKIHY3y5pSekcVVG4XugnKBhxDZyzbV/Cac+CooP9uaIZtxoLXrwquwovqBJng==
Received: from CY8P220CA0045.NAMP220.PROD.OUTLOOK.COM (2603:10b6:930:47::18)
 by DM6PR12MB4139.namprd12.prod.outlook.com (2603:10b6:5:214::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 17:14:04 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:930:47:cafe::1d) by CY8P220CA0045.outlook.office365.com
 (2603:10b6:930:47::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.26 via Frontend
 Transport; Tue, 14 May 2024 17:14:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.21 via Frontend Transport; Tue, 14 May 2024 17:14:03 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 14 May
 2024 10:13:45 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 14 May 2024 10:13:44 -0700
Received: from localhost (10.127.8.9) by mail.nvidia.com (10.126.190.180) with
 Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 14 May 2024
 10:13:42 -0700
Date: Tue, 14 May 2024 20:13:42 +0300
From: Zhi Wang <zhiw@nvidia.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
CC: Dan Williams <dan.j.williams@intel.com>, Alexey Kardashevskiy
	<aik@amd.com>, <linux-coco@lists.linux.dev>, Wu Hao <hao.wu@intel.com>, Yilun
 Xu <yilun.xu@intel.com>, Lukas Wunner <lukas@wunner.de>, Samuel Ortiz
	<sameo@rivosinc.com>, Bjorn Helgaas <bhelgaas@google.com>,
	<kevin.tian@intel.com>, <gregkh@linuxfoundation.org>,
	<linux-pci@vger.kernel.org>, <zhiwang@kernel.org>
Subject: Re: [RFC PATCH v2 5/6] PCI/TSM: Authenticate devices via platform
 TSM
Message-ID: <20240514195340.0000596e.zhiw@nvidia.com>
In-Reply-To: <ZjnqZRPaijFxO9rh@yilunxu-OptiPlex-7050>
References: <171291190324.3532867.13480405752065082171.stgit@dwillia2-xfh.jf.intel.com>
	<171291193308.3532867.129739584130889725.stgit@dwillia2-xfh.jf.intel.com>
	<fc201452-080e-4942-b5a0-0c64d023ac6b@amd.com>
	<662c69eb6dbf1_b6e0294d1@dwillia2-mobl3.amr.corp.intel.com.notmuch>
	<ZjnqZRPaijFxO9rh@yilunxu-OptiPlex-7050>
Organization: NVIDIA
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|DM6PR12MB4139:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e9ec678-edd6-43d6-f000-08dc74394176
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|376005|7416005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HHtpl+5+LmNOeSU6H4MswxPd3ADxA1Pu1l/uPNlZOi6h0zysCzgR4wCY2QMl?=
 =?us-ascii?Q?wYJa8uoWxhjYSguhw4tv+UroXBF+zFq4D3v3lxByVhG7Jwuxiq7bj76QmgJP?=
 =?us-ascii?Q?k3vHUU9ddrs6nwAPiNc2kUeBcWCcq+ftlKE2y0DU/KWasTa0Q0RwPbmS5T4x?=
 =?us-ascii?Q?mWwR3Uf7V8MnypaVZHKWyZt/hoALp70uRtDYgK98yYVUyRuNNTtLUUG7UDFf?=
 =?us-ascii?Q?uHLUU1TEtXwaONVY2dpu28RJWcM0wjtSzGU5ybboWqylmqHlHqzRzCIUlTV7?=
 =?us-ascii?Q?r7jubxHXShNFxV9zxkiYtI/KpGQescivABNTyzeC7pASrgYf2Uxtal7FrL6h?=
 =?us-ascii?Q?iUwrYEZrCmLofWSXBmsBZiZrFUa10KZN83qLtHbMzrPEq11YpKAwY0THecGo?=
 =?us-ascii?Q?xcSeDj0Fn71gPlPdaz1+srx5CxwXGrfH2H/nm1aHz21Hzum73L94lwiQC5h5?=
 =?us-ascii?Q?xs7JVhW4GSj89S3mj4Y++BonbB+DpkF+597wMMa9pFXg4JGaFhdSoWMQMEO1?=
 =?us-ascii?Q?+S+lU7qbQLXe51N+YhGcU41RwcQ70Ynwzd90Z4uPLd3l2QdAk/gLdy8uApX4?=
 =?us-ascii?Q?XIoDGLIEXp12DTnyhjZan3Nn5xOoWXJeXal/9uKuwCfFknzC+KtlmbCIEO+M?=
 =?us-ascii?Q?lVzYqnMtlBi426Hh9vkImC5gkth5TcG6FpdawUU+W5W5+hRB9DoeF44FxU3J?=
 =?us-ascii?Q?HlcQluPdaGyxxcnDFlstHqxNs5lb5pptc/BBQ2FIfigNrpJmNTx70rL4DElJ?=
 =?us-ascii?Q?v+u+I6WSRnnfRSdfsNLoOe7mMjv1F8wL3VvzG7iJuC8IuVQdI00P/Gzxrgtx?=
 =?us-ascii?Q?3Yrz6wqTL6uabk7Q/nCAY1qfhWk6ZXqOvFymSNEaDnQMaYP9i8WqG1Ddj/sv?=
 =?us-ascii?Q?yH8sOL2Td7rAJlNbecJSBmvZ9J+Eeuh/AITBxXdUUaLuc44cEVYbP4B5sWuA?=
 =?us-ascii?Q?3hJJPJr7o5JILbYZRXMyyGlT47DKh4Z3RFGLSEt64xEMc3cVCpRqbZUX4XhS?=
 =?us-ascii?Q?u3M9z1l6A0DrmOVj5snYwkeCOcXncfLX2apaNdbLtlUs6DsRecJTZSXmWrzH?=
 =?us-ascii?Q?fdUJTfoRAXEJDF4A+6VnXPcs6i/ZQS2lycrs/T+qfDia3/813wYyU8K9fLkC?=
 =?us-ascii?Q?wdizKcKm6sb0K5ly8R4PLpoNOLuI9EPMxBBPsqapToZEUike3hDWdYtGJh0J?=
 =?us-ascii?Q?jUrC1U4qoGV/641gn0QGoCiFguSiXeLzaCFk4fpHOShc+OGjaNIcHeBBi/4h?=
 =?us-ascii?Q?y/cd5L3YJ4F06QseUdhH99SlXDMTIgq+UG00Dj2/0kzuzEkHSC1xHzaRpKth?=
 =?us-ascii?Q?FsUkngP7u8RNKSU9Iqm3F9/KoM1cr4/zEhRS47WwT+fKcthog8DRut68hlNU?=
 =?us-ascii?Q?9CB5Qj3KRARqLDY+Nfx2jOSxptie?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(376005)(7416005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 17:14:03.9102
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e9ec678-edd6-43d6-f000-08dc74394176
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4139

On Tue, 7 May 2024 16:46:29 +0800
Xu Yilun <yilun.xu@linux.intel.com> wrote:

> > > > +
> > > > +/* collect TSM capable devices to rendezvous with the tsm
> > > > driver */ +static DEFINE_XARRAY(pci_tsm_devs);
> > > 
> > > imho either this or pci_dev::tsm is enough but not necessarily
> > > both.
> > 
> > You mean:
> > 
> > s/pci_tsm_devs/tsm_devs/
> > 
> > ?
> 
> I don't think the concern is just a renaming. My understanding is, we
> already have a struct pci_tsm embedded in struct pci_dev, we could
> loop and find all TSM capable devices by:
> 
> 	for_each_pci_dev(pdev) {
> 		if (pdev->tsm)
> 			pci_tsm_add/del(pdev);
> 	}
> 
> A dedicated list for TSM capable devices seems not necessary.
> 
> But my concern is about VFs.  VFs are as well TSM capable but not
> applicable for tsm_ops->exec(TSM_EXEC_CONNECT), maybe not applicable
> for tsm_ops->add() either.  One way to distinguish PF/VFs is we only
> collect PFs in pci_tsm_devs, but all TSM capable devices have
> valid pci_dev::tsm pointer.
> 
> TSM capable devices in Guest should not been collected in pci_tsm_devs
> either.

What is the plan for the TSM capable devices in the guest?

My current understanding is there would be host TSM driver and guest
TSM driver, or a vendor TSM driver will have a host mode and a guest
mode due to its nature to understand if it is running in host or a
guest. They will be plugged into the same framework here. 

If that is the case, the TSM driver should step in and decide if a
PF/VF can be managed(added) according to its mode. Maybe TSM driver
should also indicate what tdi_verbs it supports. E.g. in the guest
mode, it tells CONNECT is not available but the device can be managed
by the TSM driver.

Thanks,
Zhi.

> 
> Thanks,
> Yilun
> 


