Return-Path: <linux-pci+bounces-27294-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA94AACCD2
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 20:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86A3B4C0522
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 18:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9EA28642D;
	Tue,  6 May 2025 18:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qsPDIfNe"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7EE286412;
	Tue,  6 May 2025 18:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746554916; cv=fail; b=ZgOoZx1Y3kxDNOv8vn7nMDIbDnT9hIB/LHft8B6+UdRx76X3Rcz//5KdwXMBshqUE6SuTdyVMI64kinWET872W/4Os2k4zOb23R0Eqtr65K7nnkKjKv7p4jjOPAJC7Uw4KXtTWsOPI0IbOzWQ2csIGeoySQW4qLBmxk3xQBYEmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746554916; c=relaxed/simple;
	bh=/HwML/JxAE/gvASWBQwUMr1jXMixtjRV3dDoH9d9pBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sPVyMTj4moLSj07jPfeHEx0Nkm91wenZSaktjF6gOyDkcxAIqkbpCTGbDXjSSP8a6UyN2+IxQGFUpLUoVw8gdKmP8+9yY4xtVNaWue7cp3rGMUo0yW+g0b/GBh93bA3X6mOchgxsb5y1nJ9e2Dsv6luZRlkNS0d7hNnxqZzDm0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qsPDIfNe; arc=fail smtp.client-ip=40.107.220.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TnNdBy/riKGKGdznEEL2hNNIVtsaewxLbQxOXhM+ZK3E/q0O3Xr9sHS3TIFiev9AvtSh8xio6EviAjZP/h7bHqlewnREbWEN2nhqxK0jPNck6uW/DOrkhBQJJiw6veUqNdVsubzwxXrA8JeWJ6tVSDsWxVXf1SjKZMw/kR9KltcckSsFmWkDliNgerEmpmfnFRHxprbBQXms2nzbgUXywGMW7CbvdDevqmbweUCL3OxSHLUFR+oW/o2nzPRgoPLoyUJ/bWB+lEULLonuMHrnMFU9pIYjdodG2BlrQ/m62f+tkLw9wQagGrG5f0Nydg20KOriuSgDBP2id7lwfIiPNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWnJxlUNrsM2HrPgg+Qz36ndGgvHD4M7rJUPdnschBs=;
 b=a+h/sWDC61FmMt1eLRhH4dN6fOfIsV6CPFEbMTDlzu/qBXg3a6e2FsjBD8M2Z5lmhf8o4Ikq7DnU8H/tKGudWVoIH5PZJdNuqbOfO6GJ+khb0fF3kP/0Ncw1qbraK02Teu0wqgvrnuFkrM4EnPv2E6Pa+arsIpOrGykuK2opyG8ECDfwAwBJp60e9N4z0NyBICz4b60D5uJ/p61m4IASq6j3awIifVKI3uA+VgRoSgQkB8vyJGO8ZnrS8ugEuYs4d3KHBMC4tHej513uEwNXcdyOY6BaBcvj87/pu92T6357ZDe15ixERr1GRx/BXtWsbif4bGBtw85aTDLHJcCoWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWnJxlUNrsM2HrPgg+Qz36ndGgvHD4M7rJUPdnschBs=;
 b=qsPDIfNeY/Ihqb/ChzQzM+v89Nu6E8jAtow1GSNLeQ8nyezxS+F7nHG8PKIxLqkLxRq9FpCCjMz+VsGPJVbg7PfZpA8vblX5SjPMZyN0Y9nSfGtehgcvRuQG+3uoYCYTgTszSND9OG/eGJQgcuDVcihIOBekqFpspzyUO5FTmY+dPoIVMNDoP0jAfIkxCHkkB9AmDncHdJH6uMw7XM2MLRDuZJpS/gqVNYRZd56qj5fHdien/IoP+qBEulhrJAOl0BfEfbRjfwyM0YgHVviqLIIsIcABcQAe02XyHde84VgipJcIefn1EiMNjFZxdl3Pn1qhhXYX4h1fYboJtLssRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM3PR12MB9414.namprd12.prod.outlook.com (2603:10b6:0:47::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 18:08:21 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8699.026; Tue, 6 May 2025
 18:08:21 +0000
Date: Tue, 6 May 2025 15:08:20 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Tushar Dave <tdave@nvidia.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	kevin.tian@intel.com, yi.l.liu@intel.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 rc] iommu: Skip PASID validation for devices without
 PASID capability
Message-ID: <20250506180820.GB2260709@nvidia.com>
References: <20250505211524.1001511-1-tdave@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505211524.1001511-1-tdave@nvidia.com>
X-ClientProxiedBy: BN9PR03CA0201.namprd03.prod.outlook.com
 (2603:10b6:408:f9::26) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM3PR12MB9414:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cc7fc0c-91fd-4ffa-b7e4-08dd8cc8fc8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?50wHQdbVWLArce6N2kWIdaDokJCC7mCbdzh9Rjy60Yu0xHmKf+N+kfFMRlVe?=
 =?us-ascii?Q?ea37eJA4+EB2vJYxX7sgoL/YbPSY/bK3cyC3jd1UrxJ+Zp8uvRaNMtHZb5y7?=
 =?us-ascii?Q?RPglLQwrxiCi+BQwDE29NJGwiLwQirfbYGkQsX1SO1AHkOqhJS3D3ltEOUgu?=
 =?us-ascii?Q?/2cAwfXxLiTkeunEOSUNMIH2sdqvtO4TyiojMBFe/xWinvKr8f6EQj5Ho1ZO?=
 =?us-ascii?Q?4H35z9fDSe27nx27Bplfwoufic1PXLFugn4tcYdKM7CSblZ0U8wrVFOHZYh+?=
 =?us-ascii?Q?xC17IWOcpkVGa2BrZlF7la6TdruVVq0E3tYcm/UGzEA9UAVkakHThZ8eXYj5?=
 =?us-ascii?Q?pUQGecLjfd8K8hHpHeUBogiyXIrBsp6F0W2byhp5XpZv6qAFllZtyO9/YNJF?=
 =?us-ascii?Q?F1pigB63fACoUGOkToOKC4BPcHwq9TnSkAcAhC5zY1uIwo5VftjBFmC6IB2Q?=
 =?us-ascii?Q?flzMpEiQE3scUrZypvJMBaxi7KtA/a+MwdSfSAerFL7isLpOFOFBW646WPyK?=
 =?us-ascii?Q?CsuMotZ7r9ik+/B8u1wq3rU3nBgUyFewk0w22JX8THxPBVJcdqb53g8v4nwZ?=
 =?us-ascii?Q?eKo17kLf1ypcbWd03SVU2uid5pgIEdhDNcJFzTEMLjnpf+Oe8iDam8yOY0MK?=
 =?us-ascii?Q?ZO2yPlMONREqGpeZVnSKvzu3Vq7C8mduk0gHiTbZ0Y+mOIljFfPejjFBLqOp?=
 =?us-ascii?Q?34/PjljnFoVMsmLeCRd6iWl5GxBjshXVl8KAR7ME4uL5Mlpwht4tcB74PHtv?=
 =?us-ascii?Q?TerRmJLUi1SXvnp4AaY00MKd+eHYpVL2kLx85W1/TQPxU6Y+Md3GVvrC9mId?=
 =?us-ascii?Q?xf1QGTpsMAIobzvId51h812rLPb1zF1XJcFpt2/DcEnkMNF02WLvVK+S12sO?=
 =?us-ascii?Q?P2Yt/ESXbCGQWVQgRiM3GslM+QCOeKq3DdWpogj95HmG/36k/2o9igaVBJYu?=
 =?us-ascii?Q?XTaKI9hFFZsIB7fxyOmzJSey4aHMFG+Qkh6UWOL1fLtmmE9gr38tmcVCt/Fq?=
 =?us-ascii?Q?3moRTsvn1Be493KkuMfKPCVpPUPN0gJTaEc4MvmWgq4T2fKiywHI5E2fSzUD?=
 =?us-ascii?Q?we67Vd/byixiQXV/YXtEpeUAYcv44/9/Z72pmXpjY4bTvNii39IakVx0yX7+?=
 =?us-ascii?Q?maVOWvqOvtM5JUAW3Ivc++QXNWtvzVDP7uV6gQJFuah1z4cQCs7ZQHeuKbfL?=
 =?us-ascii?Q?dLyxD7UBJeLrO4PV4C499OP5X/zWReKqqqu3C7o4nxGpsR6oelHjr+9dTGEX?=
 =?us-ascii?Q?9yf0ygeAuV33GFpnhaqAgVI7SA+nisfJ1NfngwWu2TYzLWNNgqjnOqxJkm5R?=
 =?us-ascii?Q?hW7q0+MCgilrJBmxPLLQqdsPJgINBloDlBBypIZ4/jyJPIW5al4ccxucClkI?=
 =?us-ascii?Q?hP5O3kMlF0MvbxpqX32emzEEdwy3NBF0PFW5EkLufSxgxIMPya0ACtWOFVS4?=
 =?us-ascii?Q?vuB3A55AdQY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SVYh9/MnwpR4pVD+kGGvQo7IsPJTRXxJejvD3a9WW+3dYKfydK88OUzEmnT6?=
 =?us-ascii?Q?1UESFxRXDypzL5GZgV9jfdZiXMnh5k+BJYw20XrpeWYNV2n9/MGRh58AhJDF?=
 =?us-ascii?Q?3v4cW5SyVnLJicV5EORyfUxAC/T1UZP0eBa9o2kqqTjSyim7O5pnteM85Oq+?=
 =?us-ascii?Q?OU9Q6zRG94pmXBt4t5pkVzFt112epQNyDwErhvGdjMnFpPwrfl161fcoNoQ1?=
 =?us-ascii?Q?/rE+1oeLasYkjfHMleqmAVsLjz8FeaDqIuSzMF+G+XAIh+pxL2rNMqo2YdZV?=
 =?us-ascii?Q?uewCF4mcFXtrVKeeEnvQf3bQQ4+Sp2LRvHFUWORetvye0tBIin+XNwtXX6qA?=
 =?us-ascii?Q?80gKSlY0j/GdUistf9siMbgH56igJRlJXtgk6V6W872j9tsZqbuqLtmrzYb9?=
 =?us-ascii?Q?vFqkr0mjdRfi4B4k1+S046eqbGSlmkifC34bxRU5dYDTwQDgX5RynLU/jYR8?=
 =?us-ascii?Q?TZW/Ba7TDsxXy4GnFEedtmmIutIy40AxPNR0/yOB/v6LF9ux0RjIlaW14aE7?=
 =?us-ascii?Q?5o62h5avM9dwlkX3H0X1C5P13YvPRJE2Xd4VDZYptHc8g3IPqd+2UEbw1r2h?=
 =?us-ascii?Q?nx9pVBUJ8F8SNHMNv20fXd/bbaAGWi4cBPcPd4AvnCuB5lci7Ypl9hl6ONUK?=
 =?us-ascii?Q?MxWZb5bNxADn32plgfXp67iWGjhGlcs+YjiNVidiBEH2XjLOWY0oXIkb7hGC?=
 =?us-ascii?Q?MOLeiCI1JrqOHgeB5JdAGUa1EWXNCeT8ZUaJFN0gg1svlV8ESwp5e29YypP0?=
 =?us-ascii?Q?eEP6pyTqPA4nVUjYZLCbSDQbJFt2mPj5VGuqM2vRQj51iT5PActU+mMICshM?=
 =?us-ascii?Q?DVEsU9y6E1ItyniuKSEm4GyaFYDmU/WlASI9Hmo8tyPv1C5j8d4eIMrgJhPl?=
 =?us-ascii?Q?FIkisqoQAsOZwjdaqr7odQRUxQLhUorXz1fLaORpBEBzCOav7Az2BYcDPnNs?=
 =?us-ascii?Q?I2991ZGvtbMkXhJwEvGMaKF/JspNFgykjO1sKLJRlw8aq4eYY65E7GPADFOg?=
 =?us-ascii?Q?QXxPNj2/3YwFfNHfb9ZlkBjiwknku9xkr6L4nUH1v6yAddroUY4RNYM3nr0x?=
 =?us-ascii?Q?YzMgFKvRTkA9ES8xsQSHFG9z61B9fEWUeuzDP20ou5L0Xt3h/94DpIPxGc/m?=
 =?us-ascii?Q?ZhnB6Neeisc/Pz+VjIUu7orIPOZ9ZMskGvD8+E3/WQP8frtwu3SxvazIyzAk?=
 =?us-ascii?Q?lK0s2cXwDdL1LB8pth2yMT3BNKQgOTwnDvPNmGGQaChTFdzUo9NNHuj4mUby?=
 =?us-ascii?Q?fSTm0gI42LjRzlAvt5yr75kN/4rgHAl3bfvGq/mTzLpVBmUCQ9pZnqQInr/1?=
 =?us-ascii?Q?YLHXM9xwkOI+6hynZ95c+Ro/6iPAtEfn5AAHFFzyDXhSPF8RzIuyoPRrDrSU?=
 =?us-ascii?Q?yamsOPADpdj7a9JorOPzmg/H7v9w1cJcbHNLR+BXg/np3O6PJ39L415OflIY?=
 =?us-ascii?Q?f9VNa9QskVo40OLYGtDmMvDDMuPl3b5v2GvPBDk0fKObc350o6xR2h7Puwtn?=
 =?us-ascii?Q?DNamMKi4MFrwwEGXNE+y+h6OVAAeHeXfwdRQX58EbFN3KnsJVwMpNS09HYy6?=
 =?us-ascii?Q?ra2B/1TwOkajzZsd4hbLyqFVMrMubxGgtgXWeWH1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cc7fc0c-91fd-4ffa-b7e4-08dd8cc8fc8b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 18:08:21.6492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cgXYMLCqq/tbGkZn4ongDN4sX3jpvuQnjXuLQ8IuTlLXiAnPf0e1SL3bUHHhTXIT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9414

On Mon, May 05, 2025 at 02:15:24PM -0700, Tushar Dave wrote:
> Generally PASID support requires ACS settings that usually create
> single device groups, but there are some niche cases where we can get
> multi-device groups and still have working PASID support. The primary
> issue is that PCI switches are not required to treat PASID tagged TLPs
> specially so appropriate ACS settings are required to route all TLPs to
> the host bridge if PASID is going to work properly.
> 
> pci_enable_pasid() does check that each device that will use PASID has
> the proper ACS settings to achieve this routing.
> 
> However, no-PASID devices can be combined with PASID capable devices
> within the same topology using non-uniform ACS settings. In this case
> the no-PASID devices may not have strict route to host ACS flags and
> end up being grouped with the PASID devices.
> 
> This configuration fails to allow use of the PASID within the iommu
> core code which wrongly checks if the no-PASID device supports PASID.
> 
> Fix this by ignoring no-PASID devices during the PASID validation. They
> will never issue a PASID TLP anyhow so they can be ignored.
> 
> Fixes: c404f55c26fc ("iommu: Validate the PASID in iommu_attach_device_pasid()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tushar Dave <tdave@nvidia.com>
> ---
> 
> changes in v3:
> - addressed review comment from Vasant.
> 
>  drivers/iommu/iommu.c | 27 +++++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

