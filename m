Return-Path: <linux-pci+bounces-10240-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D7E9309BA
	for <lists+linux-pci@lfdr.de>; Sun, 14 Jul 2024 13:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AC6D281A5F
	for <lists+linux-pci@lfdr.de>; Sun, 14 Jul 2024 11:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D33349659;
	Sun, 14 Jul 2024 11:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="thT45u0x"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDDE6E611;
	Sun, 14 Jul 2024 11:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720956618; cv=fail; b=WiKqhimdWh3ibXQ3YCLp9cW1aFI0FrXs2NIUhgTGd075cm0yw5fICVfjkNlXj8GneZH7tkxCQSDZ75xQwgzek6xEnDRfFbqXN7pAywxf/0VobO5RSPIceV08+je1dn6dypc+FYFZHRjRUafEvZEwJj93p0N7m6l9KzZPUnBv17M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720956618; c=relaxed/simple;
	bh=KYaavHOmEHqoTAfCAxaL2Apx5kWKCbpWL0JgFrb0wtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Pi+d5D8Ih14U0GTKfKnmPL1ykoZDbu0ueAr5jzwitghJr5uKxlGMEJ9L7uGRxeFLGlfde4bAHSbvUMAxyP64erJxi1IIHptXeGehwh6IrrvgkPHqC1e0uzKsHtcMhrBXKOCJtoYJAHHaTl+1e9Kgvma2LD2keo7KvPJxPcmmq4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=thT45u0x; arc=fail smtp.client-ip=40.107.243.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=epf2XT46DPymI8NQ98+QVIAVptO3hCvBsypTOCpw+8cdSVV/eYKx2AQDVq5J7Hi+Yl9JmILI5spasw1q+9KDmR7R9axubhyA8wFVFUVeMMEZvMgxnDVaeFPDnJS85WFd2ZcHzq0zbGj2YNnC8yMAM8rz8MXuyt38PXmpkXC6btA6Q/y1/czKcU7efGK54gKJmNsaGQPBrT8iaHEI6szohhDBR5XxqRfqMoqcXdfy88MPqLdGQe/nNGmTebtR4nlAEnDQGcsP/ch8PuKfkVkmAt1g/F45PuuoanCWBKBsu0Lbw+VoNE1zpF27I/wWOOO2W8HIsUcVLc1G8f7D5yDQOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gdsHyOc5LbaEsXYtDPGp0P9cdm22CimS5BQnApEo/L8=;
 b=x36AL2YfJ40mRleRtCkQWnRkehgJa7Xsk4dvNFNMCeqilJzo0jMoZuVK1P3e/gSf6UGYBfJe9HmDYmCCxoi4lOmk9IzrRgzbu4JJ3jvlwQUQ03iMGyIU9dmqHBhULMsTpFDT5gQNV96jAk4Ma+ENF/gJ8s3onQWjFzuQYPSPLsfcM0WMfUIVPdGENrq/5ZgDiypg0+mIrMp3k4WneMvjcDCt6FL12ydSPc7DpIn4kGAI3vZyQYEfFuE0KlfjeoR7dXWWVk+kJ594gFQmjWG+vnhont+wCRxd7gxVruOrwksp6tyjME0+D9Sif0d+x+V1tnaG4jWD9yDu49rS7O5AjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gdsHyOc5LbaEsXYtDPGp0P9cdm22CimS5BQnApEo/L8=;
 b=thT45u0xxbUuTxI8uERJsEDZ7Ttg3oqOhDCkbYPa+IiaKTj1W6aVorfFCqcITAYfEDwahOvONzasqB1HPpdpM8yq1bMjn2ZgptFgVFMPc+R/SL5+sjA1Px3zW21AQPU+7z6rWzaetlSpd06qZm6d+K6Fjtee9EQFbCRJI+yuQVWbA1egN7YxE2WwoSKyHQ97qdEtgVB7+60ChgYklxCN849Pb2shTzkY9sdMfBE4p0BJE3zCP2LbXc0WqsxsNp03/Je/nwRX6Xb8Bs+hTPMnruUDYZeTHhXrJl36gZYptuJO96kMvikGtUWhEvZuTPG0jA4Zek8EQqMLRA/kCWUqLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by DS0PR12MB9059.namprd12.prod.outlook.com (2603:10b6:8:c5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Sun, 14 Jul
 2024 11:30:13 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::9ec8:2099:689a:b41f]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::9ec8:2099:689a:b41f%5]) with mapi id 15.20.7762.025; Sun, 14 Jul 2024
 11:30:13 +0000
Date: Sun, 14 Jul 2024 14:29:55 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Petr Machata <petrm@nvidia.com>, mlxsw@nvidia.com,
	linux-pci@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH net-next 3/3] mlxsw: pci: Lock configuration space of
 upstream bridge during reset
Message-ID: <ZpO2p7XFtoUmwChj@shredder.mtl.com>
References: <ZoVjPb_OwbKh7kHu@shredder.lan>
 <20240712212157.GA339030@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712212157.GA339030@bhelgaas>
X-ClientProxiedBy: LNXP265CA0023.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::35) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|DS0PR12MB9059:EE_
X-MS-Office365-Filtering-Correlation-Id: f5de7bb2-c16a-4008-a955-08dca3f853cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7rxpRu/jmH/YYeG36fXKRzxwczigiNYov4sRqScpeQ//wOR7+6aL0ROosuai?=
 =?us-ascii?Q?vQ7in8WCbKXnnbbYOOiyhy5b+FEvgbrdgZaXQjn/sJXOFXfgMkxYTUi8Rzo2?=
 =?us-ascii?Q?AuGaS3FZTnroerqYtF9KUNy+29IC2bk/yc7axrYKJHL/gBITu+idUBustH1j?=
 =?us-ascii?Q?0HENsVqHLMCxlm2dT7tdLasVY89sDgrd0mq0c0g+HjfVRJuY78UIphF6Gijo?=
 =?us-ascii?Q?ZIxAAkloPEKHV4KyfzkVP2q1G0M6vHUG2DyjguUIhH3sbHFv5u5LPRdRaFP7?=
 =?us-ascii?Q?MhPfwtwsWFZjRHCmidR25ZoV7EKFFGw9nwJ927KuSOU9LCg2qAZJ3qnYwLYm?=
 =?us-ascii?Q?SAfyUCECkCztUOOrmXTLmsMzczWh8nNhHzGFfeYCyCC0WROTnwMNQvjXVepr?=
 =?us-ascii?Q?rngIMgwnnV58ydUIkH7xHdWSaZmIKVUFJpBAIrARFFqTCdH3TDHRCnmU+tZ+?=
 =?us-ascii?Q?/UaGhW4nINzjMQE4NMEzCaOjWVNFJiH18s984Jwb3+FWmrxnrOuaPQbQNPE2?=
 =?us-ascii?Q?FzXYMCFKWA5AMTq/9U2BbZMrlss85DdjUSBOJxk5FB6lX+heO9dLiZ5H5TV2?=
 =?us-ascii?Q?K4SIqs3pQHopsk+sG20N0yYob9bNhyTJirA2s1oIR2AxPohVFudbpKMt5Ry7?=
 =?us-ascii?Q?M6Udl9F13p6l8LgfYoEOHy+lLKNlUBlm9pwlKRc2EL//JCVb6Fdh84qF9h+l?=
 =?us-ascii?Q?bXN/pgzk+ROR5dAW3uxs7jGT3son3Ab5lZmL00DR4ENu4Rn6jq9jnuGZNo4T?=
 =?us-ascii?Q?enPM3EJ8b/eUDFbCee1XTm1AgSn1qym2Zq37jpZRfP7dy+4fMNizFQP1fon5?=
 =?us-ascii?Q?kMzx1VjMbL5hTse2XSr/56RFOB9oW+q4M2A/pmfY/djvIL6BNMcg3YyORLFD?=
 =?us-ascii?Q?wrfwMg9UrrlWubGs3/Vo0voHyyBDtpkiMAuMowL5B88V7hIxNzjsCzjedjvd?=
 =?us-ascii?Q?HPpEMGcK1L4hJZNLsITj4VDIZSFz5Q72RBlq1zY/tZytE3SYL3bNyUNCVi7a?=
 =?us-ascii?Q?0d96Vp6OZ1N1iauIaJaZVs+uv30nJdvNX/H714n9R/OImYU7mHhmoBNQBwMv?=
 =?us-ascii?Q?MlbYFyl3tX4whB1l3oK6Ko/CF6c2GGpHE89oL4z8W43E1WVkB97hkoOf+dhH?=
 =?us-ascii?Q?wX+7xJqVKbtEHDfY1AcT970io5VnfbMYTMm6Zw9KuwoeR8zn1eWZtNlUWvbe?=
 =?us-ascii?Q?TMOMBLgjk7KkaY6l5fZTh5c/q3gokvDQRWThv71yLGOEIGvoK9YhEnaLxU0e?=
 =?us-ascii?Q?TPNM7if3P+H11lkzO1ddeLN25KHkjYQshCjiLMNKdtsyFt7NxpxSgsnmxOVC?=
 =?us-ascii?Q?Snnl7A+JhnDtPotN8Z6GbGqYd84AEM+en6+4FRXIw2DWpOIchTERu+Md6HV3?=
 =?us-ascii?Q?Kpic20g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KahMRvMsEdCsXZPKWekH6hiyJoxLRJdHcXbhzJM1EZQXBQeG2pb1qtpAWVYx?=
 =?us-ascii?Q?TMhhoZj7czUxMw7gSW4oFePbNh3qHW2vn2TCGwmSUe8Eow2GOBpIOUTKYwUa?=
 =?us-ascii?Q?+ZvaSw/83RLh+ALyaFACkpvLBJgHQgY5lBX7L4tBWPaxCdMenOdYe62QYJ7w?=
 =?us-ascii?Q?GT9zQ8bbl1mbU6ADPUxHAaKw1Xhqhkkem4RfR8EbccWy8uMAYX5jtPEZc9uP?=
 =?us-ascii?Q?pX2llThLLS8LB0B1hXx9tF1Km/zaJtC5eEtDJ3FPXJQD66W9YjXI57MTlwvl?=
 =?us-ascii?Q?Uq3ueGW4YmRy5oHh6gOudOi7ac+JiWT0it91ktqJk2dNQQgRfuQwDvhMMo1p?=
 =?us-ascii?Q?jaVPuD9N/rHEmewCx/ICIwuwZBDp//v0IeY1Ma9qS23CfCzsUccRCqFCEzQq?=
 =?us-ascii?Q?g6dzN1J55OoyvNc3OM9xmJPzE2TQiubdJeo9fpu8lgTYuF9CpcP2YtGgpVKJ?=
 =?us-ascii?Q?FqJN5k+PgrnqsU/+rSqb134o14l2zQhOU0HvLwfbTD/Un5YjMpZinc8H9hwv?=
 =?us-ascii?Q?Rq08cR0H6oN1f7ERkz6t97SatHr1Pqf7OSGJK4K8KCzWtNIUq2+NN51MwSWg?=
 =?us-ascii?Q?BnRFjNBs6DQLXjI5A6v72+tcUQ1eihR9CBGsE5/M8ItmMRHrZTf4OC+yZrCO?=
 =?us-ascii?Q?leMIvQFtGM4EcJ0o8Ddtc6OdDDsRT+hHfX3cR7WehywFpPeAwFOBcGh0TJ4+?=
 =?us-ascii?Q?9D1gWSIDjVxnSSiUrBhdM8UgJo78usCMallH1uHHxZhim3y9HjlIZ/2VaL52?=
 =?us-ascii?Q?Olh4cTQJsTArKSg8tEwNmmCkQgntbvXlE8zkEnTf3R5Oo7Eh+sX7Z1QCUbxK?=
 =?us-ascii?Q?rO1SCo4aPVsEh/qoURYpEkTSs/R/59EskiPaijxck7Hgks+jlqdb+sOD5v4B?=
 =?us-ascii?Q?QJc2W8aXFuz8QmMoXXdZszxXCXqDKQ7gHu+kz6300uR3S+wexR0kr4VqJHDs?=
 =?us-ascii?Q?QLwT5bMKuEc2Ssf3k+SN26bo0dEAi15PPf1jKrRGkPVcIu9jKz5hGfCP7TOv?=
 =?us-ascii?Q?SET4BtKO82koDE/CUWV0VRM1lAO9coWV08SZNGqXPmysAbdkhretSAjEfR8U?=
 =?us-ascii?Q?7X4qBYQl2V/EOVthmbFcrT2YO+bLMR49400XPsoB1S3ZnuvfjhlxaP/KPdvd?=
 =?us-ascii?Q?ZSbVCjY2wxwbPUeZN7OrH9YgcPvROwaENuEPueWUjiXwU3LUZcqTIku7fVpC?=
 =?us-ascii?Q?E7MIWVnMxuzN+5SLLJFdNQZc0s0oGvHcwwHsls0tQ35aHS+HYjpR+k3avWGa?=
 =?us-ascii?Q?0P1XV2QAsLYFrcp95GTr7IXMKUsLFK/rkxyPdqBOQQSFcEE5N2A/p6hGcRuu?=
 =?us-ascii?Q?NmjN03RFr9xcA5YHUv24BAlS7KcQZI94Cw+rRHp1J/vDpRHKzBA59C3OTcKu?=
 =?us-ascii?Q?+ANNjqNstchfjiSjf+7yJl7fkWRBC6X5/5AcDpnMa64Ce2C1V1T9G5JzZGXe?=
 =?us-ascii?Q?/70J2DN3ywDKNp2jWlfbG03x36IgoYtMdJ0VVRvoBFPb/ZnAkgANw2x0Wgvh?=
 =?us-ascii?Q?5bUgEAKeI/nNzjAMHiJ6KI4RBeXBXAyChGSgTfqDi3iYNN71R1tKNGM7SGBr?=
 =?us-ascii?Q?WDgVDvMPPAXJAmfoapIbNO3HQkkVgGIEsIJttXTZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5de7bb2-c16a-4008-a955-08dca3f853cd
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2024 11:30:13.3905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hpXNjn23SHtWSeNFnccW4CFWGL4JdgUlKh0fZf2HmsmPkSSLW3Bn8ckLzGKgbwGFTC1RwqUcgSe2gFcDMKSmKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9059

Hi Bjorn,

On Fri, Jul 12, 2024 at 04:21:57PM -0500, Bjorn Helgaas wrote:
> [+cc Dan]
> 
> On Wed, Jul 03, 2024 at 05:42:05PM +0300, Ido Schimmel wrote:
> > On Tue, Jul 02, 2024 at 09:35:50AM +0200, Przemek Kitszel wrote:
> > > On 7/1/24 18:41, Petr Machata wrote:
> > > > From: Ido Schimmel <idosch@nvidia.com>
> > > > 
> > > > The driver triggers a "Secondary Bus Reset" (SBR) by calling
> > > > __pci_reset_function_locked() which asserts the SBR bit in the "Bridge
> > > > Control Register" in the configuration space of the upstream bridge for
> > > > 2ms. This is done without locking the configuration space of the
> > > > upstream bridge port, allowing user space to access it concurrently.
> > > 
> > > This means your patch is a bugfix.
> > > 
> > > > Linux 6.11 will start warning about such unlocked resets [1][2]:
> > > > 
> > > > pcieport 0000:00:01.0: unlocked secondary bus reset via: pci_reset_bus_function+0x51c/0x6a0
> > > > 
> > > > Avoid the warning by locking the configuration space of the upstream
> > > > bridge prior to the reset and unlocking it afterwards.
> > > 
> > > You are not avoiding the warning but protecting concurrent access,
> > > please add a Fixes tag.
> > 
> > The patch that added the missing lock in PCI core was posted without a
> > Fixes tag and merged as part of the 6.10 PR. See commit 7e89efc6e9e4
> > ("PCI: Lock upstream bridge for pci_reset_function()").
> > 
> > I don't see a good reason for root to poke in the configuration space of
> > the upstream bridge during SBR, but AFAICT the worst that can happen is
> > that reset will fail and while it is a bug, it is not a regression.
> > 
> > Bjorn, do you see a reason to post this as a fix?
> 
> Sorry, I was on vacation and missed this when I returned.
> 
> mlxsw is one of the few users of __pci_reset_function_locked().
> Others are liquidio (octeon), VFIO, and Xen.
> 
> You need __pci_reset_function_locked() if you're already holding the
> device mutex, i.e., device_lock(&pdev->dev).  I looked at the
> mlxsw_pci_reset_at_pci_disable() path, and didn't see where it holds
> that device lock, but I probably missed it.

It is locked. There is device_lock_assert(&pdev->dev) before the call to
__pci_reset_function_locked(pdev) to make sure this is the case.

> The usual pci_reset_function() path, which would be preferable if you
> can use it, does basically this:
> 
>   pci_dev_lock(bridge)
>     device_lock(&bridge->dev)
>     pci_cfg_access_lock(bridge)
>   pci_dev_lock(pdev)
>     device_lock(&pdev->dev)
>     pci_cfg_access_lock(pdev)
>   pci_dev_save_and_disable(dev)
>   __pci_reset_function_locked(pdev)
> 
> This patch adds pci_cfg_access_lock(bridge), but doesn't acquire the
> device_lock for the bridge.
> 
> It looks like you always reset the device at mlxsw_pci_probe()-time,
> which is quite unusual in the first place, but I suppose there's some
> good reason for it.

The driver resets the device to bring it to a known and clean state.
Older devices can be reset using a firmware command, but current
generation requires a PCI reset.

> If you can use pci_reset_function() directly (or avoid the reset
> altogether), it would be far preferable and would avoid potential
> issues like the warning here.

We couldn't use pci_reset_function() even if we didn't reset during
probe. Another call path that triggers the reset is "devlink reload"
which holds the devlink instance lock. Trying to acquire the device lock
while holding the devlink instance lock would result in lock inversion.
We modified devlink to acquire the device lock before the instance lock
so that we could call PCI APIs with the device lock held. See:

https://lore.kernel.org/netdev/20231017074257.3389177-1-idosch@nvidia.com/

