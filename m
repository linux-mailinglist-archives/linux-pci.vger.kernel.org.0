Return-Path: <linux-pci+bounces-35161-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18132B3C59E
	for <lists+linux-pci@lfdr.de>; Sat, 30 Aug 2025 01:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB8733A889E
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 23:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F64B26B2AD;
	Fri, 29 Aug 2025 23:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LH5Oo+2h"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7125B225417
	for <linux-pci@vger.kernel.org>; Fri, 29 Aug 2025 23:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756510504; cv=fail; b=cRezl7MdDC6KC4myllmYSuU6407c7yjYOksfTupS49CebAtfObEsjP0RuDhKfbgD/hmSvxlLtTLhE3nZGW2C40wp7V28bYOGOkHT2no4TolezdoxTjXBcY7MZ9LSRuSOdobzW12eHVjMDxv22jtVRdbfnAo9MqmGWVLjAjDKtYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756510504; c=relaxed/simple;
	bh=lOB1BI25XuWZvJUgxfZaiD2Lv97uEvOqeTX9WZCdQaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=t1NbsfRwrkUuBqdLOlWapC4dZPF7DY+T+HsSDyki5B1F0ollcAdFG5mLOnrsx+jq15gByUGARHNT+nQ6KmiUW5fkRZkQ5LzRfRAY0iz0cW6/BegWY5xSVrvA+MpueGGf68JpK9osRpVY30PcL2e4Tf/u9G/EM4CBoQVu+GowdP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LH5Oo+2h; arc=fail smtp.client-ip=40.107.236.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wtwFReymfXAHQw2BRN76hLU6ut93M0PAk0TgLgqzZNE3+RzPctOFYPmqXqUzsHHNudKtSEb2NyGPwLg2y3aTDqTZFlB8lfmk7gv3tRJcLUd66L5skYFSLRB2OPOKjyRCLXgQh7BmqJCHhLlmZ7X8VMcT8pCW3Ek2hMDQ8i3rOLnLCY1EFNCFo0dSDhOVkhGuckw7AOgiwUSurm0PL3XQSsv9PlsXjG/u/Io2XzFccheIMepnr/4StWBRfGq6VO3RQq2w6uzRYS2TztZeMoTu73tfqeo66HpgZJg+3uovhnNl9rPxYfzm3njEnOpF8+rdmGI2LdvIfTmtsyW/vEdjBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IC/a4ETOqXY12ocx1Bqhom8VqJrLZcHpAdx5kx3RXQE=;
 b=JetCOqtqtx+4m28r7UNyJfWYbfPZHimZOZbj/P3OkyFP4bteRakr6Z1ZRht/E0K0lN7mFD0aB0x4q9nuyNEG6a/NExgYBtV23l7UCdviz4F+2VmcEvbczJUVWa/nrsZoIbfhBt1tJYZmX9ZmwxqjMpsi8gGaWTiq7YUbnU5yiKMzGG7hrlump5SL3mk0k2MbuKPsAeRFHyfAcT8IfX9Vct49zWhejx5rTaNLB6aQnhZ2rx7qJB06R26luo8wOunQY+CjHWypIkEsKjD+sUZvuR01mSnV4zpjDio7W7X2+PQQkeMVo0ZNM2SGoLYBbUdT4MlB6wuL3pS5cdGUdq1PQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IC/a4ETOqXY12ocx1Bqhom8VqJrLZcHpAdx5kx3RXQE=;
 b=LH5Oo+2hfu1b3yRydKjhYi6L0WiEHS7HaM4ffGSDPLOvL6SQdlQ+NgGUAUsijQCwWQQQKSG2qsFiY4C4Vq3okG2/ZIdNXrKPfDs8XzIULapgdtI7UtzSaMCeHtTvFCAylUY8eJn/KHCW+fuK++HGt8gEF33fjaPIBhJtmjJ6B0lfzYAkmmgOBCOfJ1llTcIVW6DEhFa//prJ1aoXKmhVAb3Hj8pbPlX4oHILifJVUnh8xYjcVuweH6xFedH1Y1sVXOZcZmkQsb6kbNZfACS4clus82T/mm9IQX22/ScszdUDD02tAU2GbuoqMCQsDwoId9bJGmfa3BI9FBHVw1izbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM6PR12MB4465.namprd12.prod.outlook.com (2603:10b6:5:28f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Fri, 29 Aug
 2025 23:34:55 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9073.021; Fri, 29 Aug 2025
 23:34:55 +0000
Date: Fri, 29 Aug 2025 20:34:53 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: dan.j.williams@intel.com
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
	gregkh@linuxfoundation.org, bhelgaas@google.com,
	yilun.xu@linux.intel.com, aneesh.kumar@kernel.org, aik@amd.com
Subject: Re: [PATCH 6/7] samples/devsec: Introduce a "Device Security TSM"
 sample driver
Message-ID: <20250829233453.GJ79520@nvidia.com>
References: <20250827035259.1356758-1-dan.j.williams@intel.com>
 <20250827035259.1356758-7-dan.j.williams@intel.com>
 <20250827123924.GA2186489@nvidia.com>
 <68b0cc4632fc5_75db10074@dwillia2-mobl4.notmuch>
 <20250829160217.GL7333@nvidia.com>
 <68b206c9e3f43_75db100e4@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68b206c9e3f43_75db100e4@dwillia2-mobl4.notmuch>
X-ClientProxiedBy: BN0PR08CA0006.namprd08.prod.outlook.com
 (2603:10b6:408:142::26) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM6PR12MB4465:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a972797-1852-47ae-66f8-08dde754a875
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Sc48oTvBlIawnnAzInjBbFh4QC4UWh0sg57d29t62I0wHXlphwGDtnEN8Z8P?=
 =?us-ascii?Q?w2+WhTvkzcpaAP2tqHDKCXHKle/MzDCPvuhCtR/mocIhB7nS8BlA7k74uaGe?=
 =?us-ascii?Q?XM8fVUyGLnPeg6vm1n95DBNSJiRzU24n0bn0+dDA5DTS1ASDbUFAJr+jQ3PD?=
 =?us-ascii?Q?AE/m3A5PJN5p97ykk9bmlpybv8cJ662bcRw2POIyxFSqBSX05D1ARj87opA/?=
 =?us-ascii?Q?IycmT29/U0iju2Sn12Sy+SoxE6vPIDbPxW5lcp/OV2fA8WFlnLZ5ERjVJM1g?=
 =?us-ascii?Q?uvNE+KI0rkqsjXd9tMEVclHCy+la2j/xMvbpDK6OXV8zacWjjmiIDBvjYjKl?=
 =?us-ascii?Q?8OvvgqczAcm/mlWp0d4tk4anha33U1u32O7h/X9ba5bEXR4e/vMCxaCFRMV/?=
 =?us-ascii?Q?/SgWqqd8+aAo5fKwCWlJ/Mmr2WiNzwgk1CoWGjvD1jILsEeeEI2/Dzu9bQBN?=
 =?us-ascii?Q?IcsRyBv0Ergz8ObBU0pHPRFoL+zQEpkoP2BgMwr5q/WSjYrCuUahjHk3Ph8c?=
 =?us-ascii?Q?r//mcdB3Rra+R6zR8FmOowkVs8z8QIThblbbAaddbJzx5zLVlnUmDie9FmcF?=
 =?us-ascii?Q?UmP0iYIrQnvfTumO1VUf+fPthtNhgWB1wumGWu8iXhTsfK3aVJZGtduO3MBK?=
 =?us-ascii?Q?DW3Z+VnExuB+awBP52AOScwMtYFc6gAmcOS/fYu3J4AuT0mz/RtKmAcQoSvX?=
 =?us-ascii?Q?4CYG5SeEdO6rs0lWeACiiwWVbnHzWbLsK2w+5LBHoiBGwpgLButP6zWqWVJr?=
 =?us-ascii?Q?OIgsJ/Bt4jtMSfMXMrhjHJzpVd2iscm/MIrV2Ibc1HZkWm59Av4ln9/arhyI?=
 =?us-ascii?Q?cUMP0V3/sgiuiMQzLnubnQugZfHZUtA490eIm3NBuSC9xd0ZizLzJ/bAvR+U?=
 =?us-ascii?Q?HosXKbM+Do4kA3Jrj+yg2BklaTJYmT+Q972SmdYiS8H4d/xpnaKIcYposMqB?=
 =?us-ascii?Q?l7GTpkBwvd7ztSeDl6/c+2hkRjvVaS36W9GAodeDvGhEwWIN+gR1PtV6AYiN?=
 =?us-ascii?Q?qnxXPeMhYNlvrLdW1tP2juEst8iuCqM27D3RnWIHG+6yZwBn5WtsXcptRPYW?=
 =?us-ascii?Q?Jnp2z2RkhK91RnniMHHbv+RNp9Sz0td+L2w8yp01GiNI/RaZ80sph64lsAaW?=
 =?us-ascii?Q?1sLW344hqviTOEGKnU+X1fQ/QGlegTEpd/S824JVzQFRN4RipVQNfCMUsOGj?=
 =?us-ascii?Q?+Nj9wZ4/855FO5IFNIZYyVw3qwoJK6HrQxU/Egii9KQYpGHNOj3JRmss/WMZ?=
 =?us-ascii?Q?fZ2KUyNkhw6fuUDYXgRugg4buJqUyrw2xSZSmfMnQkpRLmj5vy6lbKR1vTVN?=
 =?us-ascii?Q?fDJ2m0iHbkcNJvMfAtDAQ0Viox5HFGRfEci7pPjzZ+/BU/juHddpvThk3hC6?=
 =?us-ascii?Q?S9OJRKiNhkGoYMbUraLG6o/AGU1jIjJEVtHyqQ0Ue0633GY+OCY7+Ke8UyAn?=
 =?us-ascii?Q?L7psgvbPk5M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Dyz+lvMFLlAa5oXcpkdqVhjNDGcwZ0QzA/pu5HC4GUvAN+q2BTBFu0gOXsfM?=
 =?us-ascii?Q?KA7jcv6xggL1H+IXP8GJRqaecN7CYtCjg4sS6FFVYmDCVMlV/lKlT7fRe7wJ?=
 =?us-ascii?Q?5NkoOFtriBvv56NJlH8oqRuckxVsl9Zquftn2D3qENtOlSXsj9btCONnRL8f?=
 =?us-ascii?Q?fdh6tJU41ybUAAy2pSMNWOi3eDW0XvvxESYrdv2EigMBvCAh53kVuau76QU2?=
 =?us-ascii?Q?0FYQjZ9NtO6N4qqRPPiQjWz6PBmYWSHcM6dutZ9U3erQcCx9S91lygJiouJ1?=
 =?us-ascii?Q?rZp6GiXFRdaogYkcZqdkX9PISdXrjuLm1pTtUWuLhDyRsE9pE2fgqvSaB/We?=
 =?us-ascii?Q?HVQ2DgoOHEKX1On0ZUn5JPvc/N0hUOzfkUaRZimNZVDw0hwsiAWk4CyjdtpU?=
 =?us-ascii?Q?AMMaZubmBVuGiKRKiREm88aycmZ86S3Rj/gWKbjyA9wj6B0Lj6Bq9We8k+QF?=
 =?us-ascii?Q?kIiNk3APmJtj/8BtgHJRAy6cJM+X0899bd01E1yfjIlAQDuvOafb875SVH9/?=
 =?us-ascii?Q?cXdrx/5du5n/qt4YPR4zi1rXwFiD5TvoBYCW5v1AUI14EgorzAm/abRecADh?=
 =?us-ascii?Q?T9QtT24G3WIfhYKP/XvAHvKxuVF32NosKNSGvDs/+T/YRp5XRlaDGZ7h3hEa?=
 =?us-ascii?Q?NMJDjqJvlDNwb/woq3fowwGRRTRyIQIyc6nXv+c6mlgxstNvVtsa/mdngS9D?=
 =?us-ascii?Q?v1y52I4565kYM43XOqWzTHKviat2J71qKH//O0MYhNCFLR/KQBKvlvdO65ZV?=
 =?us-ascii?Q?NbUc7ARy/juGa//jTCkW2I/jbF0/Iiyo+qkPo97rkFRKA+Sr0Vax3L5UGKWz?=
 =?us-ascii?Q?/WYLsikMprZbzYEd07aJtu8LMX44f/su0Gbmf94VBjD0Q7t4AYy69yStbGDP?=
 =?us-ascii?Q?fmA+u2vfwem7aZypURgTqtxH7T4wLcg0g4zhHitNxUSvzOm3dvhptQzQ1A0i?=
 =?us-ascii?Q?jz6UfWT1opyxB6Iic7cb6qDare2KigLfage73uQ29/pV0TSPukA/o0BqYJz/?=
 =?us-ascii?Q?iHF73DG0upNJowi8x9h2mctofR4RGcJtBpT5roG1LZS+X0x/ntTdbGVB1045?=
 =?us-ascii?Q?7/Z18EP2DMZggwoF+SlDpYKZ1doIErpAIYWY8jqgpOO/KlxrX7adPDl7wyQM?=
 =?us-ascii?Q?0fD/uFZJDiMjInd17h728+ZOEegL1mi4UPTRSakVTogTGd/eSquflHOdxSja?=
 =?us-ascii?Q?w3fuaXadqQI8H5DIfO1gNuoPLIixUyH3Wa9YurWNaGYeb0zvsdiouWCaeao2?=
 =?us-ascii?Q?Ig2ftKFjwkPIHsGfct+36/3HY3bLlS4vRxwrMdC1M62XORb1Gqckfx08OB8F?=
 =?us-ascii?Q?IuImmA1gJ5s9L27BHerhsykvayJDLFSsks1bbwoMGBAr/m5pstsREVcQTBom?=
 =?us-ascii?Q?CiZ1la+t9PeWxHVZ7yFufkfH8oRBai6U6sExj8GnPOHLUcug8gqKoyX0Djz8?=
 =?us-ascii?Q?E1AxYsIfYy5Rn5+vGiMmyYSW4SPB6vGDDn5sYqrvlpuYjrEoqWp7VgnghyVC?=
 =?us-ascii?Q?Xlq/GObOinctUDDPSnnCHkOF3P7ZFa3yILpAclVrv/8w+Hk0+W1Uc1XAevrL?=
 =?us-ascii?Q?HUpdBGjeEvb+86+uuI2/rf4CsUwc258Iy7WlnYe/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a972797-1852-47ae-66f8-08dde754a875
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 23:34:54.9844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tgnykLX5KKxIkS90V8uhAbCP6FYbYcjMCboRRGfI3nBHDZAN+lZqRyIWfCMfkwY1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4465

On Fri, Aug 29, 2025 at 01:00:09PM -0700, dan.j.williams@intel.com wrote:
> Jason Gunthorpe wrote:
> > On Thu, Aug 28, 2025 at 02:38:14PM -0700, dan.j.williams@intel.com wrote:
> > > > device_cc_probe() doesn't save anything, doesn't this just get into an
> > > > endless loop of EPROBE_DEFER? Usually the kernel will retry these
> > > > things during booting?
> > > 
> > > Hmm, no, deferred probing retriggers after a one-time boot timeout
> > > (extended by driver registration events) and after any device
> > > successfully completes probe.
> > 
> > So it is not "endless" but it is also not "single probe then wait till
> > accept". I'm not keen on using this mechanism, I think the things
> > people want to do in the T=0 mode are going to be time consuming and
> > repeatedly doing that time consuming step is not a good idea.
> 
> It would only ever run multiple times if the driver is built-in or
> loaded early, which is also mitigated by disabling autoprobe like you
> have below. So that problem is manageable.

There can be many tdisp devices loading after boot so it could be many
times while all the booting happens. I'm imagining around 8-15 TDISP
devices as what we may see in some real systems.

> In the past this idea has been met with "but but typical distro kernels
> have lots of built-in drivers that *may* be unsafe", and the answer is
> "yes, a VM image with a CC aware / specific kernel config is a
> requirement".

Yeah, possibly that is where this is going. Or at least someone on the
distro side is well teed up to propose some kind of pre-initrd
mechanism to mitigate this down the road and get back to single kernel
build.

> >    Maybe we also need a small kernel change to allow userspace to make
> >    drivers_autoprobe false for all future busses too.
> 
> I do think we need a mechanism to say, "no more dynamic device
> enumeration", but a coarse and future promise "no autoprobe of any bus"
> I fear is going to have a long tail of problems especially with design
> patterns like "faux_device" and "auxiliary_device".

For the moment I would probably just have userspace special case
those and automatically run the userspace probing sequence.

> As far as I understand, these CC environments do not immediately have
> secrets to protect at launch. Also, not sure how many are ready to
> validate the launch state of the TVM that early. 

It is not about secrets, it is about protecting the integrity of the
kernel - the software you intend to load secrets into. mlx5 is a 300k
LOC driver. I fully believe that an attacker prentending to be the
device can attack the driver and insert hostile code into the kernel
using this driver.

As such an attack would escape measurement it is completely
invisible. The only prevntion is to control what parts of the kernel
the VMM side can reach to attack by denying driver binding.

If the kernel now running hostile code gets secrets released the
hostile kernel code can ex-filtrate them back to the VMM.

It is the same argument we see MS making about secure boot, you have
to take steps to ensure that unmeasured code is never injected into
the system before you complete the boot and release the secrets.

From this view point any compromise that allows unmeasured code into
the boot chain is a security issue.

The same argument is made for T=1 devices.. I imagine an attack where
the VM accepts a T=1 device, and it instantly DMAs all over the kernel
and effectively makes itself invisible to the verifier. Hopefully this
is prevented by measurements made by the TSM, but IDK, seems scary.

However, I know there are alternative views. For instance that CC VM
users should just trust the CSP, trust their boot flow, trust their
provided VM kernels, trust their verfiers, and if you are already
agreeing to that trust then defending against a hostile VMM is silly.

IMHO I don't know where the industry will end up, I see people on both
sides of this debate pushing for their perspective. I'd like the
kernel to be happy with a userspace that wants to trust the VMM and a
userspace that is untrusting and very paranoid.

> I think it is more a case of allow everything by default to start
> (whatever is in ACPI, and T=0 PCI devices). Later the relying party
> either says "no, you have enumerated devices that should not be
> there", or "yes, launch state looks good, lock device topology,
> proceed with the performance enhancement of converting some PCI
> TDISP devices to T=1 operation, here are your secrets".

This is really the above "we trust the VMM" sort of view point, and
from a kernel perspective I think it is fine so long as userspace is
the one making the decision to work like that. I don't want to see the
kernel force the weakest security option onto the userspace.

IMHO the minimal issue here is what should the kernel do with a T=0
device that has TDISP capability..

We don't really want the kernel to autobind a driver in T=0 mode, that
is wasteful if we are going to unbind it, lock/run and then bind it
again.

So, IMHO, the bare minimum would be for the kernel to disable auto
binding for TDISP capable devices only and shoot out a udev event
signaling that userspace has to bind the device instead.

Let udev take it from there, and udev can then do whatever dance we
define.

Then we can have everything from a minimal security posture to a very
tight drivers_autoprobe situation, based on what userspace wants to
do.

> >      mlx5 is allowed to bind to a RUN device after measuring and
> >      verifying it, and never otherwise.
> 
> ...and if userspace binds mlx5 pre-RUN that is not the kernel's problem.
> I state that explicitly not for you, but because of the rejection of the
> "device filter" in-kernel mechanism previously.

Right. I am stating the system level goal, expecting that userspace is
in control and conforming to it. The kernel just has to not bypass the
policy choices userspace is making.

> >    Basically userspace policy is entirely in control if a device is
> >    "accepted" by the ccVM or not. The kernel won't auto bind
> >    a driver to a physical device. It would be driven off of
> >    uevents, I guess through new CC focused features in udev.
> 
> Yes, the only quibble is whether that "kernel won't bind" is more a
> "userspace shall lock and validate device topology" at a certain point
> in the boot flow. Userspace may need to be prepared for some unaccepted
> devices to bind before that point.

My argument is "lock and validate" is a fine option, but kernel should
be designed to allow the more secure option of "approve every single
driver bind". Userspace can pick, but kernel should be desigend to do
both.

> The kernel problems to solve are "accepted" flag and maybe documenting
> to driver writers / udev developers strategies to handle the "prepare"
> problem.

Yes, and maybe some small less-critical kernel items:

 - modules.alias includes the driver name
 - A way to default off drivers_autoprobe
 - A way for userspace to tell which busses are discovered from
   HW vs internal to the kernel (aux, fuax)
 - ccprepare_ drivers
 - A way to restrict built in drivers at initrd creation time

But I think each of these topics can be its own independent thing, and
I would send them along side RFC patches for udev if that is how
things are going to go.

> For RAS I do still like the property of a driver that will field errors
> also having everything it needs to take a device from reset back to the
> ready-to-accept state. That can be solved later, and maybe the outcome 
> is "cc_prepare" is incompatible with "recovery".

Yeah, probably.

> > Sure, I think you shold drop this patch from this series and have this
> > series focus only on creating an accepted struct device environment
> > that a driver can bind to and operate.
> 
> You mean drop the device_cc_probe() piece. The rest of patch is starting
> the work of a "accepted struct device environment" with a single flag
> that MMIO and DMA infrastructure can reference.

Yes, sorry, I forgot which patch this was: :)
 
> It is trivial for a driver to open code EPROBE_DEFER so
> device_cc_probe() is not putting any burden on the kernel besides
> documentation, but I will drop it for now.

Sort of, it also establishes a kind of uAPI that I think is best
avoided until things are a bit more mature..

Jason

