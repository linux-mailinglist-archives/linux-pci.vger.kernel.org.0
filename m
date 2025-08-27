Return-Path: <linux-pci+bounces-34914-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 588F2B3828C
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 14:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13BA217A517
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 12:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC6C2BD5B0;
	Wed, 27 Aug 2025 12:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hwpcEN4G"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28214214228
	for <linux-pci@vger.kernel.org>; Wed, 27 Aug 2025 12:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756298371; cv=fail; b=X3yYUyKzW9SwGkJBVk3ioYOeONGqqaxxsyfgn4RNkIi0z8U2mXu45opxphWmpGwltuGDMWnPINrjy78mbzqWMFo/MhJpx/u0sTrTKjhmzAevTp/5m/VBk/Rrnt21QDuELv/50ApPYINgpGjnNhWQM+VfyKLq/60TV5tAhkUUW7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756298371; c=relaxed/simple;
	bh=EidfTxuNw/Zxh9sQGZ50Monj5jL0+b/uDs941uBQB3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lIQzvG4bCiTV2HrGwDtONa2H6LdN8qeE1A2bR4gpHFjz5l1a/PVi2Jk0TUpcfFmM7JC5lvQobCR48sf8Kteu33SaDe7bXBGuoskFmv0dQ3GhopXqbO9D2mw6gCMXvNnl4vE7fPkjqExx8kA29x+vxWEEVog8bi7W1fDioqv69tw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hwpcEN4G; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lF4KTVtRBQ2jgHN9jv9DaowNDeCVj0wjVP53FCi3Z3Z8ero9o+nVThWJZyxpPeeavj4/ifmkQnE39Z6qUKhNfHJ6RKtMlOumoCfk2hGWcY2pY52FemUGBqJj8ijILqRkt4MPJAO1v1XSOxC5Uy9FII2eLdObylOTtWkUtyZw2adXdagqT8Kh/gVoXc1yLijPFWJUP4K4FYBneado/gWsxbjZIzsLbO8/K58q9QTY7PV9pP8KBKAOUrUTTwtx+tY7DAab521vGmVMrqiopzANrvP3yw8IpnQz8bsp+Q1TJ87rkUScjsFEYXQ2wE18zGoSZUwZprdkPw7cjPX+YPE8AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xCg8MIGdU26kKM8KkweELsVub87LsGS3PkVMc0vy6TE=;
 b=ZlEyvgeDPxKGGDLVGWOe7PEKTWT+yHSFHFwyDuEQxxdCWwBYmO7yEooU4xfE4w8/cLqbG6IY4ydZoH6pyr/PP9KeUH+dwXfRblosE3/bhQf4pIRPAFQmbWmJSxogWSBqS8fi7+OzZ2Y/hVFcO1VpqdryC/7cO2RiaKvEIarK/bkqugeuNZingY7wwylr5NKZZqaPS+Yd/PGwNqVYlHA275V4dEKI7fP43afZ2zUZG1l6GWhSU8OYVikYnunF/rFqIJKj2yi35gutlZUW5qprKvSgpKOyNKHY9DjuDgSRVkIv/y+/d+NzBEg2Xh2jkl/sGruA1nYT7VCgFkMWO8fXTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xCg8MIGdU26kKM8KkweELsVub87LsGS3PkVMc0vy6TE=;
 b=hwpcEN4GwyiNAFZhhmoNI5e8kmVBniZBncArgJ0wuUqF3NB4e3W8DnxTcPn91gm2gcnWV62ZfpXFoQwStYPz6HKbXO1/O86SWXZo0xDcdoeps7fnAM5hVDltdwE4zjlHDBRypBt6JSToKSYbDuL5OB72sHdwW7OGc/eCNJ/rvAjQlrVE0GbLAK9KJ0J/miofguSMWmB8vNEnHBqRcK5sqIRBWv0mS6LQ3gcthkvn75XSybqXjv45ASKiy3W8gBi3i0gfNzzMn4e2gvkE85JKDiYXB8o6GnMloe2fPunLOx0PcBmybvC1aqqWVNUt4tTTChn0vmyl2oUfG18BxhU3Uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH8PR12MB6745.namprd12.prod.outlook.com (2603:10b6:510:1c0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 27 Aug
 2025 12:39:25 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 12:39:25 +0000
Date: Wed, 27 Aug 2025 09:39:24 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
	gregkh@linuxfoundation.org, bhelgaas@google.com,
	yilun.xu@linux.intel.com, aneesh.kumar@kernel.org, aik@amd.com
Subject: Re: [PATCH 6/7] samples/devsec: Introduce a "Device Security TSM"
 sample driver
Message-ID: <20250827123924.GA2186489@nvidia.com>
References: <20250827035259.1356758-1-dan.j.williams@intel.com>
 <20250827035259.1356758-7-dan.j.williams@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827035259.1356758-7-dan.j.williams@intel.com>
X-ClientProxiedBy: DM6PR10CA0005.namprd10.prod.outlook.com
 (2603:10b6:5:60::18) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH8PR12MB6745:EE_
X-MS-Office365-Filtering-Correlation-Id: 48ab627a-b924-487a-a930-08dde566c1aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jI+u3bFH4LmYP9gPwfinbIRYRnDQg9yUCm1NTpGKaAc7hOa/HXRBm6JqA/Hv?=
 =?us-ascii?Q?/QsgBT+STjaxfD/Yl+wQE+SOjNfme1MUlTdOQgInvTp9jsULaM+AmuMVY7Y8?=
 =?us-ascii?Q?6xasBlk61Sfdfdc79X5curD2J+gqnFQ10RB2Hz8YuQnghKghbSIk26O5hD8p?=
 =?us-ascii?Q?jIxUL4La7bfYRdbAK89wnFE76bUGHb7hLksajuFoI4QqzysXHRrQgRPoa68n?=
 =?us-ascii?Q?hJru+jXvUCiMHLRlVLWrOOaGhHRBgLAlXocezJwSAfU70zcUavDClznosKO4?=
 =?us-ascii?Q?sqomRoZK5367ofuCdoFoP9DhFEpJrEhyKgdc4gEYDf6RrklDcXYVYJxSdzB6?=
 =?us-ascii?Q?nWeQhN6uPjlFXdnscD306lRAK4nDuGZYjR3PK42Y8nGmWhouzXbvWqaLNWgD?=
 =?us-ascii?Q?VXSMcNPdGtkAu4X2Zh2U3sOAtBbt4XB9oUAWEBlZkp35tt80OwWBsQN0EHIs?=
 =?us-ascii?Q?2pI1hFqrBrKk2bwo/73lrGCee+5rwchcgij1gCvCxgiNrj2jkBHp1TOIKdOx?=
 =?us-ascii?Q?otSBLxDNQvkntYWJzBkj4DahkgXY/cE3E06fmjCuk//Ea8oiePXRastdFcJU?=
 =?us-ascii?Q?+FkokG40Gvug4Gy+c9+PbNa/TRjhm405jXhde2i0ZA7hHWvbmMWwKEFiMurx?=
 =?us-ascii?Q?qI8/VM7lseao2z6pL8aJ4RciS0m0wwsNeS4Lrai54iCl6Lmo85Y+3khVRKUm?=
 =?us-ascii?Q?tBCrYFqMivNr5OSp6qHT0h5J5199hnXFtRzfMJdTAHQ8IUt48dVr0WqIG13P?=
 =?us-ascii?Q?XzkH/gbbreiUUXUbI3o9i9FeG4W8YZW58g/BuVd4D3EewjRlc/7vcPovC/89?=
 =?us-ascii?Q?pubPiJIJMBv3swh16i/oyMctcNuxh7a3WHxSlDQvmHyUXd2iJshJA51PcSoB?=
 =?us-ascii?Q?qoQjkKmWNutruQy4/xWAGlzREkm7VLvgt39RuKjw75d6OnKa0oaoh0IJAl4Y?=
 =?us-ascii?Q?1Au4IHiqrDYRji+QKU2o0Oz70rEjSYvOuL6SB0OoKrRNWxkc9xWcwZ09r8ZH?=
 =?us-ascii?Q?VtAOXD68kbrPeGm+uh1ct+kZufK8ng3nXSWeb4r2s5DsM8QM5fs6DteAFoVZ?=
 =?us-ascii?Q?eKC55SstTrcvkgaVpQvZA4TZJRqNd5FDoi31PLeBA4rM+rkXjsGIBAqPPBtW?=
 =?us-ascii?Q?+blpnHPUi7yZm9pXXQt8pEi94BLjvz3lyk4gOHWuAGdSeZpc0AWJQm4vEf5s?=
 =?us-ascii?Q?WfsjE2SvbHYeln3N3DHpKx1zJxZ3Pn2LPed+aRJAUwqvE0MUtbn53Nyhq+Ee?=
 =?us-ascii?Q?aO+Z9PE20KwHA96rh09vJA6zYEWkiEDIOnR0oySOPaY1wBAOdI60ORRVPAc5?=
 =?us-ascii?Q?FYfJW0MxAAsrcWpHj8pS4DBm+m+/4Fi6wjx/GJFGR7BBaXEOWai2JIGnuX/+?=
 =?us-ascii?Q?8RWDizPHAQZP2HUbJlJAQXIxAOcPg784Kv4rvXkNXawFhUPCMCAHNBgP6c+3?=
 =?us-ascii?Q?oDCv/fjFsss=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DSBVn6zCyo9SdUDDQ1BXegyzCKsbavbXPhkDv/fJuZXv89q/RKeID/Q1O64g?=
 =?us-ascii?Q?mJo7/BQh8f29qz9qX0QCcIxg8ajjNufHcY5m4huW3Peq470WJTK1ck9BO+yp?=
 =?us-ascii?Q?Y1tCmXYKqXQgNqaGfbphbNZ6h3QSVpz3wRphEH2srjMFLgnn6gNawHS4+Ode?=
 =?us-ascii?Q?OOGzL6eco742SU2dqGJVtwVYxX0lo9S4aEc1wlLkAI4QxJZxg+PD/IB5KfsC?=
 =?us-ascii?Q?6SAfSxfAT3DmmOh0LcKisWemO8wjf/rk5bdjNYwqnSZJmhNfQ/Wjk/tDjrjv?=
 =?us-ascii?Q?MFbTeOa8PGUx5ayaFL5Ty83m8lJjGQGvWC29Asyt10qDsf/vmhsm9PicRoho?=
 =?us-ascii?Q?TnHQ6VTXHkKb32+7jBxc4zC1XX8xXmRY3cDaeFNM7ohaDElVSi8i16n9jhut?=
 =?us-ascii?Q?Nvwp7hMYSAIbE7hKwE9YvRPpznKsqMIxm9BRxuCzisIYsTtCwJ7oIhStQK+S?=
 =?us-ascii?Q?3ZhiYjvIuC9L6hNX/UElVlqqxEJr6Q8VmFf56rW9FDV6qw0+yZqUxi8eUbqJ?=
 =?us-ascii?Q?iHHwAJG5bBtxtkVmFg+jNohZSYpVI63dGOkt/LpoYl6zOIzTwmzo8QVIw2+F?=
 =?us-ascii?Q?IIzzUnJd4LodT685u5rs+gOrLp+EYAds4DujM0+Cbwtse6dtI2dWM1tSlDBP?=
 =?us-ascii?Q?2s40VnlkA8J4BOJjkhBararoJsVRWQx3kUuiCIFwfTpQ3TR2KLmBF56NUVRR?=
 =?us-ascii?Q?+tbPlChNUoVGGm/TWtGwR8hQrg1qdoe/Gqv8r3IJSFzlikf69ogjZI1exMBy?=
 =?us-ascii?Q?G1jJ0nt0VNv7pC5CEg7M4/XCa/yCzHK3acZb35dxCpXwOta2n+vzkGgr3iYj?=
 =?us-ascii?Q?fjjH/sv90QPYI9X10LMv84eYgY1t8aJJyctTZ0+Usi8mW2pqwc6BULstMhox?=
 =?us-ascii?Q?cA54mIS/8UQQDVQndLfU7HmCKiFJdtU74Ur++lQHQr+/0qJklvptCPYvz4mE?=
 =?us-ascii?Q?vJZYpwK6VZXckssBUcDp9serLXRjbBZL9gZnJ3rIPDgb2s6nIRAYPm/yy2U1?=
 =?us-ascii?Q?kTpSA7+yhhj743qcuY1MPW+oFJywRSFi583l9MxzIDDrA1QKoxs17TiONyAf?=
 =?us-ascii?Q?SwTvjX20c4FiarXWYO69kh29iNiwIvWaICD1lZ1jFJuC9ukM35mj4LYFgd4U?=
 =?us-ascii?Q?juHXDccgNpRToDizBpxqUEjm9QUSadkBpPGdGY7RsUNOryUlvFGQDArvt5Xl?=
 =?us-ascii?Q?H0FAbBQO2nUkAvKhGbX0UtxKWUtBhfhLNftKID2M6+9bltq8XUzdY6S6tST6?=
 =?us-ascii?Q?tgzyW2hskiwOldNloNFy331akFhz80mCClZf64HMUJuEHG1uKJHbToUkieC3?=
 =?us-ascii?Q?FsIDMzHhzZvRW5E879kK0VSOqGYukGJhmuDrBjJDP1JXkI7OefCJQtIA1HD2?=
 =?us-ascii?Q?t3iuoxi+LiiBEt3NuNlNMqae8hH2QCqmjQypuQRwbekfkFIItpZ8gNVmzSDo?=
 =?us-ascii?Q?C3rb4+Vi+loAwplZg2MSsvQaIAKfmaHdJxzlCgdW7Z3WdAu8QWD6G0fMLgE3?=
 =?us-ascii?Q?99QxlLYP3ObUBCHLrS5tNQeYzguDrGoYhmpGH1epUup2RHAGNpAebwNpej3b?=
 =?us-ascii?Q?G6CberHTY+9a2JrIgrmWAzFopU9mVwJibQmNuGEX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48ab627a-b924-487a-a930-08dde566c1aa
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 12:39:25.7249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pEPvRmmaL0E0CAfP6qUrctZuSQAm5+kCYQr3yhnXmdwqmZ2FF3qA5Iq65IkoB5PC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6745

On Tue, Aug 26, 2025 at 08:52:58PM -0700, Dan Williams wrote:
> +static int devsec_pci_probe(struct pci_dev *pdev,
> +			    const struct pci_device_id *id)
> +{
> +	void __iomem *base;
> +	int rc;
> +
> +	rc = pcim_enable_device(pdev);
> +	if (rc)
> +		return dev_err_probe(&pdev->dev, rc, "enable failed\n");
> +
> +	base = pcim_iomap_region(pdev, 0, KBUILD_MODNAME);
> +	if (IS_ERR(base))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(base),
> +				     "iomap failed\n");
> +
> +	rc = device_cc_probe(&pdev->dev);
> +	if (rc)
> +		return rc;

I really don't understand what the proposal is here?

device_cc_probe() doesn't save anything, doesn't this just get into an
endless loop of EPROBE_DEFER? Usually the kernel will retry these
things during booting?

How does userspace accept through the sysfs retrigger probing?

As we discussed in the prior chain we need to have a policy decision
before auto-binding drivers at all in a CC environment, I don't see
that in the code though the cover letter talked about it??

How does the kernel/userspace tell the difference between drivers that
want this early binding and those that don't?

Can you write out the whole flow from a userspace perspective in one
of the commit messages?

This also disables BME, we talked about that a lot, the commit
messages didn't seem to describe what solution was settled on here?

Jason

