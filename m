Return-Path: <linux-pci+bounces-29792-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27758AD977D
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 23:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB20517FBBE
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 21:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E00719D08F;
	Fri, 13 Jun 2025 21:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q7/Xi4Ut"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2082.outbound.protection.outlook.com [40.107.212.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290AE22F164
	for <linux-pci@vger.kernel.org>; Fri, 13 Jun 2025 21:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749851251; cv=fail; b=bkbyLBXozDpQTbSgYXRWxKL4Snp6qZ1yYuS6XUzdnmLmIO74yJrSkkhq4Qpz6XwoMO964vxWsqg2v4WVdNt1EVL866hslsHBFZEho0CF5mcBFWTK36YAn1hbOj5WQ0FcxbLLJ4vMYRULsbAvfzFk4WqAYcQIkkeqmPLYEEmjUTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749851251; c=relaxed/simple;
	bh=2kNleFYw8es/S8bnYcru2qWAX68AYe6cXaoey8I43xI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UqSOv536AcVfBmId1vgn6jo400R8j4tBgLtJTFoobpmrEqGklCifjCwFTsgR5XmigY3ZFC7K+egDZekoVUAcRXMAGsE2zAkPiIA3d8Q4acikbxk22iIqJzI/VWg8EniInXbrK0JWA04O5IAeyZBRh+JqPg06oyLUylog7Nt/j/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q7/Xi4Ut; arc=fail smtp.client-ip=40.107.212.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XzLhwhc+0b/Di23/sT3pkhU1T9X0EB7RQoL8yLBjd2kHdPyoDVo5pP2LeFi9+WoSR1U8Byw835JZhQ1Ky1PTLw0DLDHXb3IXMF1+vGitwOP1apMCbcBNG9lyQGIrXJYr40HZiZAtIQkuTPd69jW3e5PeG4WN7yCqG3bzBy5ZNkWTilQE6p+62mYpUIItl7hrG5kNNwCzDXnYEyavzcZrD6c2bOI7B0yuVT9XFMBWGO1sCZ1vhHJ+TYF6anEh9VEoQhasrdbaAFQMZ1nUqZHIx6Bgzg0FtX7xxP5rimJr/Y+Mimx672VV1l61rMyYD87rx6uW7ljrV5qJ44XE4SbwMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fak5CdltbzkaOzSdnqA6495tUSgL4HncDrY09i6kwpY=;
 b=OjPm9wglb+dooWahleSSs1IEP6OZn9xcOIIxfqFw2Z14VVbBAqekXGBq1GnJuCDBLET3yEky5D0u9Y7Uwmn759GrVtDt/09FC8RTDY1tpG1dwcNf499//fbFMN1PtF3w8T8HgSg+0zLnKDyFuT93+DTi8hq6WXjJbRotnmBT0IbUx+19587jtohbaE4nWMv+WcQGdGypuRDThdEsHdZ0Z/6M6eWw6rtNDBS3UrDwF+A2D1XFlfne2uLundMMRebji3oSwd4CTvv/3mPCGz3CuCc47UsSih3lgssXxIoNll++xMsOmi2EkH3gtOScLObBWEjA2Y7nw/gGk4hZETloHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fak5CdltbzkaOzSdnqA6495tUSgL4HncDrY09i6kwpY=;
 b=q7/Xi4Uti4nGAkTL/rxsNq42ThKBbgzn9lOIjGvFCE+ncl1SWFmUzg+SE/5qe+2hbrtL/gY189KKdF4Lx54pi/kTU2HCDjdngGcVM5jwb7sHiUHyglkY4tonwHt0i9Jih7xBPWhmO89RoUjmKVXlWZ1iQNcS7WfD0mnqmQvIYZEbi/i03xbRZ7hQnjSfuty7QOYDYxo6paiyT8CZzoCaIsXgHTNAisJl6elqU2T1O3Nk/NVG7U7IL43duzRDR3FNimAML/qwCNjzfqEB3H9ida83l9gBcEoPseFiXCtvSwcLR3H8SxDinwCTg3HhX5cGSdZefBWlr1Gdh8P1K9nb7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8422.namprd12.prod.outlook.com (2603:10b6:208:3de::8)
 by BY5PR12MB4083.namprd12.prod.outlook.com (2603:10b6:a03:20d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Fri, 13 Jun
 2025 21:47:23 +0000
Received: from IA0PR12MB8422.namprd12.prod.outlook.com
 ([fe80::50d8:c62d:5338:5650]) by IA0PR12MB8422.namprd12.prod.outlook.com
 ([fe80::50d8:c62d:5338:5650%5]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 21:47:23 +0000
Date: Fri, 13 Jun 2025 16:47:20 -0500
From: Daniel Dadap <ddadap@nvidia.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	mario.limonciello@amd.com, bhelgaas@google.com,
	Thomas Zimmermann <tzimmermann@suse.de>, linux-pci@vger.kernel.org,
	Hans de Goede <hansg@kernel.org>
Subject: Re: [PATCH] PCI/VGA: Look at all PCI display devices in VGA arbiter
Message-ID: <aEycaB9Hq5ZLMVaO@ddadap-lakeline.nvidia.com>
References: <20250613203130.GA974345@bhelgaas>
 <5ae2fa88-7144-4dd3-9ac6-58f155b2bc36@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ae2fa88-7144-4dd3-9ac6-58f155b2bc36@kernel.org>
X-ClientProxiedBy: DSZP220CA0005.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:5:280::12) To IA0PR12MB8422.namprd12.prod.outlook.com
 (2603:10b6:208:3de::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8422:EE_|BY5PR12MB4083:EE_
X-MS-Office365-Filtering-Correlation-Id: 61b5ee14-1f39-4e1b-4bca-08ddaac3e168
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Vei0KSZuZ0OnLgUwc7L7GOIvvNyuhp1of6NibGwH/Ob4GFLaRdEYB4agLCJ1?=
 =?us-ascii?Q?WCUSdL9ljAgprf/kviBM8Nb8qdWJsbTqgEeSgp5Ljmp6QZGKoKVbtAKWF8v6?=
 =?us-ascii?Q?ho0d9ZWVmNCYkxj+Ljo7bsoFyQTVcZZpUJeJ5up0vCU96ABlUezoJkWw/nFX?=
 =?us-ascii?Q?9MqIHtSZw4g+VszSckJAloqdx1Q1QV9oMaQt4Cu2ckphgByELjEUHDPU5wsU?=
 =?us-ascii?Q?7c3h3h/SH56nzyA8Bg2UM027EMwE7bkv5EsOxoPdfC8p+PHvqUAvXsMqgWgo?=
 =?us-ascii?Q?LsWt0PwHyXQnekZExrBxJNt6TBOpJzb4hQl+MJ1K3eO2xoIh2KD5u8DmzML4?=
 =?us-ascii?Q?za805MUbnRf8P4nustL5ibLU+8U4FyK+AhkLLeF/jl6YFpuYFUaWOuPDWJN3?=
 =?us-ascii?Q?ePprBI98AsJzY88WuBkUBkRN018Fda2eRP0E7tByiDMOyLZ0O+kj6+40Dvfa?=
 =?us-ascii?Q?fXC/IoE07y9CEx8J4kQgFkQL3C+iFQW4LNmiGcy6PbXNV99YnfwJuGD5f54c?=
 =?us-ascii?Q?dRjKKxZjB2f4Va1LQa3E+KMjJW9joVyAE7dx1Tl8Rwruu9H2fAROBYbN3CjT?=
 =?us-ascii?Q?n5tHdVJTMm5BczGJzsPYkBNytj5GmfOqNrPI4q318d/9ZYcqb0bqEKdiyCK1?=
 =?us-ascii?Q?Bo2pgQZnlTV3zvGL/5mg5zp/w+eAn9L6qsv8qY+uWGTaz5TUcpR6iCVsdCHN?=
 =?us-ascii?Q?MJAMZX/00JdSjZPMF5myCFkD8OjOpqewRa8qKgsXqPcff5n6yNBcdR7KFkTX?=
 =?us-ascii?Q?ty2C3CZyl7wdHBaLHSwU+AP9A5lYGFgkWp5OM4x0qh93z5+UyCtvbdlqvoDn?=
 =?us-ascii?Q?COebMHhR4j863B8/VeETqmXIp/awkAGgu9jive1WEo+a/qTDdQW+onnTS9yp?=
 =?us-ascii?Q?JNBbXNEKW29uDSZt+qNUnRju+gkdQYqbjBtvGHMNX2B8OYRiMeeP8smFbgEz?=
 =?us-ascii?Q?pa0CG+C6o0V1UAu860y3rj9WbDTpY7oX8qN+Ho7Dzdj1c1irQlCMDmyPGgrj?=
 =?us-ascii?Q?ClwatTH97YXiVnF2hhJDJWKpAGO0/kWBsoUm695N4bAbQBU5c18XewTyEJrF?=
 =?us-ascii?Q?N3ZGsVWTIv8sG20KaLhLZmPa6XjZKa/yALb6yrQKQck5kraZLCWeloFzbXyK?=
 =?us-ascii?Q?ifE7biMFA6RfQWgLvbUK6ZaLrLZEomK4d6zvHMHihzt4IAwrDIHmvnw9MCYa?=
 =?us-ascii?Q?jZhRWL+YPIab8p1ujTlwXCDspkXIoGrUiK+nqhDI7julCBLHEue06BOu5I3c?=
 =?us-ascii?Q?dC4wqStCPSasBMlbdLr64fyS6LqF0ciP8eFsJNlCVLaJSrAroWt/4TYjyBwS?=
 =?us-ascii?Q?2A+PfXwe8qgV620BWfFr/oCJbHmXS9FHQFZ3HLInpbZ/Irhw0sAEpWEat7AK?=
 =?us-ascii?Q?gaLUDInWodW37LvR8exe8xIYcB4YOxiC67YkTI1DF0BUvlyIEkQDFl+tCor7?=
 =?us-ascii?Q?zFaRwrEovwE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8422.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yLOQ35OjVy7VWUEAdlktSIUKyomUd8Jf09zawXGnz461GsBIWpD0CMrC2Xb0?=
 =?us-ascii?Q?VPSqDGGgyjzaIBk7Zei7JaHG5pD6IADOEK13nUdSn0wvYT6RFP5d+cWyMZ/B?=
 =?us-ascii?Q?1fOQlWkvRPaihgjPrZ1+d517NNbJN/6Md8LlH0fgqpY6R13YAnx05wBwItym?=
 =?us-ascii?Q?kT2i0tYJaK1ckTREkPiGgaixDij0gBNHwvLwU4trEyBbASSUuI+CJT0Ccd5p?=
 =?us-ascii?Q?AEP+etMRGhNJMhqaIYFe4veqxHTvo6Ip48uImcXhd5K+X6oBPR1v4hATGjlq?=
 =?us-ascii?Q?Gy2g7msNaG4v6VtzrN44Lz/hABiDHAnl8zWUv+tzUZllWCJCcA1/98wv7UNJ?=
 =?us-ascii?Q?2IiNFT7Z4nU7+AY3b1PRBFXCAPpDym8TwLrLB/au5oyp58UYHpnqtdWbEQmb?=
 =?us-ascii?Q?5uSYH94h5yGA+3T7YaIfJeR3FazR6c+HKRVochi+FND+V7YenEdMw1eiHvfq?=
 =?us-ascii?Q?sh7PZ1inRq/IyDMNZ/iOLqWhaC74EFqN7UcUbqh4xD3fQ/UuCPxBeMZzRWmc?=
 =?us-ascii?Q?/eivQIEcquPHHTyT94tDK72CpoBGl8spxEmaplTBWu6W1d4MeVpLzXUbGfLQ?=
 =?us-ascii?Q?/DkEZYB8cSuyKyjuIMW0GqzsbJMRABOg2vy7gkOoP7iDil5W7Ul45V8gzoq3?=
 =?us-ascii?Q?ymzgeEVjYtwjJyCWHo2sguL+mQ66B1Jx7knhSoe+1r8j2cjldyGwu7qxQR+l?=
 =?us-ascii?Q?DR7mvQmul0xYABe+0ssB+gv6yYMSvQW4KdR3D21UT6xcqFdTvXabbLLtYFB+?=
 =?us-ascii?Q?+WJ71Z1wT02YKBFwMqFmLmtNukM9H3dsb5VfWY+F/HlulP5UvY2bhQldBpJF?=
 =?us-ascii?Q?duyMrAM/ZBM4rXzFS4ONjcUiafvw9hslhHFaJVa/FUueaoxyVGNQjSL1zoMX?=
 =?us-ascii?Q?xl8lUTCJcS+aVpl2wuXwXsW0hOApYXawXZQOhRh8KLtieMICAiKqJYd1APdh?=
 =?us-ascii?Q?o7HUwW36u6VeH3fB5CqhQG2hNM371YQDViyuYo+9ZePaqFySUkY23AknUmSa?=
 =?us-ascii?Q?WiGngDUZGIElkQo32usTwFt/lTATHQt1srM28fkmB3hUpLzH0Hn38/FaIeBy?=
 =?us-ascii?Q?8ygvoJQ3rAcpn8w5tPDcovVBjQixJGpKGmBGMN/+xyUcX705oLw5L3tQ0YPN?=
 =?us-ascii?Q?PgJ2z/VSkMo0GGsq36JYpm5Mu3Yjh5PmTN90VuZYGZb4LudjaRZ34MgSnNQg?=
 =?us-ascii?Q?cwNDrQdB1dHB8DVUqXV4mJQb52uvpm1993mr2v7j4osALoEeWbPvz6D6xZX6?=
 =?us-ascii?Q?B60MQQnj436jYJgSD6rdLrBHGnsw5lPTQ659nsZyv24XStXXbavXpUMSxqbj?=
 =?us-ascii?Q?yzY2EbWtedYIz6jtW47L39r9CXDxGX9wOsfoMm8Vmo1TLf9get1vzmIypCPp?=
 =?us-ascii?Q?1fR/WGkU4sOIldepsBk49AJTy3cCs3XOwG4fWXHYn8U37sHeazWTPNAx9N3N?=
 =?us-ascii?Q?6p3Cveu56hMGJfch7a5x6P0jQ2tEfyzm1ZGz1FlAaV9lp0t98r/018lTPO6p?=
 =?us-ascii?Q?LDZFKPULzaFHtMZkzZbWX+kkQyQ1p+wzpxgpFeIj1rx0lBhnwXwuS1NX6Fax?=
 =?us-ascii?Q?2vDbTc5S6UVN0gCNCgaDxKbUGk2Twhs1M1tZzmwi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61b5ee14-1f39-4e1b-4bca-08ddaac3e168
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8422.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 21:47:23.5587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mUvEwXCcTOGfjozK9hbZvXe8kyeY6S5ZOU6wGbdmGS2aXmd21MkZrCSX9V3dvy1g/YsqbOnNOzqUb13zJvzDaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4083

Hi Mario!

On Fri, Jun 13, 2025 at 03:56:03PM -0500, Mario Limonciello wrote:
> +Daniel Dadap from NV
> +Hans
> 
> Here's the whole thread for you guys for context.
> https://lore.kernel.org/linux-pci/20250613203130.GA974345@bhelgaas/T/#m7f7bbc3f048f43e698fec4cccc9e5a3bad6ee645
> 
> On 6/13/2025 3:31 PM, Bjorn Helgaas wrote:
> > On Fri, Jun 13, 2025 at 02:31:10PM -0500, Mario Limonciello wrote:
> > > On 6/13/2025 2:07 PM, Bjorn Helgaas wrote:
> > > > On Thu, Jun 12, 2025 at 10:12:14PM -0500, Mario Limonciello wrote:
> > > > > From: Mario Limonciello <mario.limonciello@amd.com>
> > > > > 
> > > > > On an A+N mobile system the APU is not being selected by some desktop
> > > > > environments for any rendering tasks. This is because the neither GPU
> > > > > is being treated as "boot_vga" but that is what some environments use
> > > > > to select a GPU [1].
> > > > 
> > > > What is "A+N" and "APU"?
> > > 
> > > A+N is meant to refer to an AMD APU + NVIDIA dGPU.
> > > APU is an SoC that contains a lot more IP than just x86 cores.  In this
> > > context it contains both integrated graphics and display IP.
> > 
> > So I guess "APU is not being selected" refers to the AMD APU?
> 
> Yeah that's right.
> 
> > 
> > > > I didn't quite follow the second sentence.  I guess you're saying some
> > > > userspace environments use the "boot_vga" sysfs file to select a GPU?
> > > > And on this A+N system, neither device has the file?
> > > 
> > > Yeah.  Specifically this problem happens in Xorg that the library it uses
> > > (libpciaccess) looks for a boot_vga file.  That file isn't found on either
> > > GPU and so Xorg picks the first GPU it finds in the PCI heirarchy which
> > > happens to be the NVIDIA GPU.
> > > 
> > > > > The VGA arbiter driver only looks at devices that report as PCI display
> > > > > VGA class devices. Neither GPU on the system is a display VGA class
> > > > > device:
> > > > > 
> > > > > c5:00.0 3D controller: NVIDIA Corporation Device 2db9 (rev a1)
> > > > > c6:00.0 Display controller: Advanced Micro Devices, Inc. [AMD/ATI] Device 150e (rev d1)
> > > > > 
> > > > > So neither device gets the boot_vga sysfs file. The vga_is_boot_device()
> > > > > function already has some handling for integrated GPUs by looking at the
> > > > > ACPI HID entries, so if all PCI display class devices are looked at it
> > > > > actually can detect properly with this device ordering.  However if there
> > > > > is a different ordering it could flag the wrong device.
> > > > > 
> > > > > Modify the VGA arbiter code and matching sysfs file entries to examine all
> > > > > PCI display class devices. After every device is added to the arbiter list
> > > > > make a pass on all devices and explicitly check whether one is integrated.
> > > > > 
> > > > > This will cause all GPUs to gain a `boot_vga` file, but the correct device
> > > > > (APU in this case) will now show `1` and the incorrect device shows `0`.
> > > > > Userspace then picks the right device as well.
> > > > 
> > > > What determines whether the APU is the "correct" device?
> > > 
> > > In this context is the one that is physically connected to the eDP panel.
> > > When the "wrong" one is selected then it is used for rendering.
> > 
> > How does the code figure out which is connected to the eDP panel?  I
> > didn't see anything in the patch that I can relate to this.  This
> > needs to be something people who are not AMD and NVIDIA experts can
> > figure out in five years.
> 
> In this case we're using the vga_arb_integrated_gpu() to tell which GPU has
> ACPI_VIDEO_HID added to it.  That is; it's a proxy from ACPI.
> 

Ideally we'd be able to actually query which GPU is connected to the panel
at the time we're making this determination, but I don't think there's a
uniform way to do this at the moment. Selecting the integrated GPU seems
like a reasonable heuristic, since I'm not aware of any systems where the
internal panel defaults to dGPU connection, since that would defeat the
purpose of having a hybrid GPU system in the first place, but theoretically
it is possible. It does seem like this may cause a behavior change if a
system has the dGPU exposed as a VGA controller and the iGPU exposed as a
3D controller (as opposed to them both being 3D or both being VGA), but I
have never seen such a system, and would be highly skeptical of how the
GPUs were labeled if I did. Such a behavior change would most likely be for
the better. It may be worth expanding the comment that says we're checking
for an iGPU to justify the reason for using it as a heuristic.

> > 
> > It feels like we're fixing a point problem and next month's system
> > might have the opposite issue, and we won't know how to make both
> > systems work.
> 
> Actually quite the contrary.  I wrote this patch for a Strix A+N system from
> 2025, but I just got a bug report at drm/amd that is showing very high power
> consumption on an A+N system from 2023.
> 
> I'm still waiting for further details from the reporter (including testing
> this patch) but I want to call out a few things:
> 
> * It was on Ubuntu - which is known to have code to default to Xorg when it
> sees NVIDIA.
> * In that case the N GPU comes first on the PCI hierarchy (just like this
> one).
> * The NVIDIA GPU never goes into a low power state.
> * That case has both the integrated GPU and NVIDIA GPU as "VGA" devices.
> 
> So I feel it's actually a really good litmus test for the logic introduced
> in this patch.
> 
> If you would like to look more on it:
> https://gitlab.freedesktop.org/drm/amd/-/issues/4303
>

Indeed, I just left a comment on this issue after you directed my attention
to it, with some suggested experiments. My expectation is that on this
system the iGPU should be driving the panel by default when it's in dynamic
mode. Assuming that's so, the dGPU should be able to runtime suspend while
idle, as long as it's been configured to do so. If power usage still looks
high after confirming that the iGPU is driving the panel and the dGPU is
configured to runtime suspend, then maybe there's a bug preventing it from
runtime suspending, but hopefully it's just a configuration issue.
 
> > 
> > > Without this patch the net outcome ends up being that the APU display
> > > hardware drives the eDP but the desktop is rendered using the N dGPU. There
> > > is a lot of latency in doing it this way, and worse off the N dGPU stays
> > > powered on at all times.  It never enters into runtime PM.
> > 
> > > > > +{
> > > > > +	struct pci_dev *candidate = vga_default_device();
> > > > > +	struct vga_device *vgadev;
> > > > > +
> > > > > +	list_for_each_entry(vgadev, &vga_list, list) {
> > > > > +		if (vga_is_boot_device(vgadev)) {
> > > > > +			/* check if one is an integrated GPU, use that if so */
> > > > > +			if (candidate) {
> > > > > +				if (vga_arb_integrated_gpu(&candidate->dev))
> > > > > +					break;
> > > > > +				if (vga_arb_integrated_gpu(&vgadev->pdev->dev)) {
> > > > > +					candidate = vgadev->pdev;
> > > > > +					break;
> > > > > +				}
> > > > > +			} else
> > > > > +				candidate = vgadev->pdev;
> > > > > +		}
> > > > > +	}
> > > > > +
> > > > > +	if (candidate)
> > > > > +		vga_set_default_device(candidate);
> > > > > +}
> > > > 
> > > > It looks like this is related to the integrated GPU code in
> > > > vga_is_boot_device().  Can this be done by updating the logic there,
> > > > so it's more clear what change this patch makes?
> > > > 
> > > > It seems like this patch would change the selection in a way that
> > > > makes some of the vga_is_boot_device() comments obsolete.  E.g., "We
> > > > select the default VGA device in this order"?  Or "we use the *last*
> > > > [integrated GPU] because that was the previous behavior"?
> > > > 
> > > > The end of vga_is_boot_device() mentions non-legacy (non-VGA) devices,
> > > > but I don't remember now how we ever got there because
> > > > vga_arb_device_init() and pci_notify() only call
> > > > vga_arbiter_add_pci_device() for VGA devices.
> > > 
> > > Sure I'll review the comments and update.  As for moving the logic I didn't
> > > see an obvious way to do this.  This code is "tie-breaker" code in the case
> > > that two GPUs are otherwise ranked equally.
> > 
> > How do we break the tie?  I guess we use the first one we find?
> 
> My expectation is that only one will be given the HID ACPI_VIDEO_HID by
> ACPI; that is vga_arb_integrated_gpu() should only return for one of them.
>

Yeah, it is not as good of a tie breaker as an actual direct query for
connectedness, but like I said I don't think we have a way to do that.
It's a very good heuristic though IMHO.
 
> > 
> > The comment in vga_is_boot_device() says we expect only a single
> > integrated GPU, but I guess this system breaks that assumption?
> 
> No; only the integrated GPU in the APU has ACPI_VIDEO_HID.
> 
> > 
> > And in the absence of other clues, vga_is_boot_device() decides that
> > every integrated GPU it finds should be the default, so the last one
> > wins?  But now we want the first one to win?
> 
> Hopefully you see exactly why I don't see a way to do this without a tie
> breaker round.  vga_is_boot_device() looks for things that it thinks are
> "better" and will mark one as the default device based on heuristics.
> 
> Now that we're looking at more devices (display devices) there are more
> things that will meet those heuristics and thus we need a second pass.
> 
> > 
> > > > > -	while ((pdev =
> > > > > -		pci_get_subsys(PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
> > > > > -			       PCI_ANY_ID, pdev)) != NULL) {
> > > > > -		if (pci_is_vga(pdev))
> > > > > -			vga_arbiter_add_pci_device(pdev);
> > > > > -	}
> > > > > +	while ((pdev = pci_get_base_class(PCI_BASE_CLASS_DISPLAY, pdev)))
> > > > > +		vga_arbiter_add_pci_device(pdev);
> > > > 
> > > > I guess pci_get_base_class(PCI_BASE_CLASS_DISPLAY) is sort of a source
> > > > code optimization and this one-line change would be equivalent?
> > > > 
> > > >     -		if (pci_is_vga(pdev))
> > > >     +		if (pci_is_display(pdev))
> > > >     			vga_arbiter_add_pci_device(pdev);
> > > > 
> > > > If so, I think I prefer the one-liner because then everything in this
> > > > file would use pci_is_display() and we wouldn't have to figure out the
> > > > equivalent-ness of pci_get_base_class(PCI_BASE_CLASS_DISPLAY).
> > > 
> > > pci_get_base_class() is a search function.  It only really makes sense for
> > > iterating.
> > 
> > Right I'm saying that if you do this:
> > 
> >          while ((pdev =
> >                  pci_get_subsys(PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
> >                                 PCI_ANY_ID, pdev)) != NULL) {
> >                  if (pci_is_display(pdev))
> >                          vga_arbiter_add_pci_device(pdev);
> >          }
> > 
> > the patch is a bit smaller and we don't have to look up
> > pci_get_base_class() and confirm that it returns things for which
> > pci_is_display() is true.  That's just a little more analysis.
> > 
> > Bjorn
> 
> Got it; will KISS.
> 

