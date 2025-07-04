Return-Path: <linux-pci+bounces-31532-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D21AF96A9
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 17:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23F835420DE
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 15:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7391E8331;
	Fri,  4 Jul 2025 15:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RqrAiW1+"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2058.outbound.protection.outlook.com [40.107.102.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8EA14D29B;
	Fri,  4 Jul 2025 15:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751642586; cv=fail; b=dQz/iLhlx8apxDhVFKk3UwSm2Ud7mWmRF4O2/YBMdaxnZmZ0XhExChqw/nfkgJPWVySmtFGJe+Pr5PF9ZmoysZCKiBzT7ZWRipUY6tXGYZkfC//ZEf3q44ZGgpb8G2bglCSqtOWqjxSuXBPRVRaPKv6uxcJrt+RM2Ahf9pRLTqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751642586; c=relaxed/simple;
	bh=NCRRWjO3IHXJHPCKYrODqfPyrlAGRNQTPrLdL0GCE9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QBgrzhqFSG3KQ4EOVQGAMpZmY3vPYPq/jjC71ABjHjLKv4BSlzkrRGhHYZkBdFDS4QWv6eJnFFA4elqiV5IrxQrUW9DWb4uUxrhl8uIOhoUYgt+TTQQnMb//dhvmOaCV3vetiFuztcENPvP5XfTAT2epLki1VJAGt1di98FMmt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RqrAiW1+; arc=fail smtp.client-ip=40.107.102.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oSDy/ur3Zuuy4A6JVRcCIqnfi68sAQOs62yJoCClHmFc91QgVfEY1iJA5/dYofDTO3KvlOsq4c6azoo08XdWxyDH3XtJcn7nzTBj7/Kb6sVZmCUqFbLJRw2+jF+TwKmTHEPeFiUTHLksVbcAvHSFCHp8H0SUXDyvjWS0QNPa/aX/W8DwqRmv4dd5jziJBGfRijZJzremyq5H4oWuuxLSW1JQgj8pDhCFtMPH3fXv/AcXEMsFdqjF5OOevvtRDi0m9z4A6tSXcDUleDsPbLCQGzv6XcMZrLEo6eIe38HZMN9UArSbN2oRueK5ktLNxLVTlYE5woM+tu11PO0kCdZymg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/fQF3Ci6MdXVZJDBN/RPTt016Ze13Q8gzg2AR1DV8k=;
 b=ebZpzd3c5sFbY4UsmFICiWmshLIYUWBeLqTjHZbeFoCDdlxRUvkaMt7vxjsVcNNW5sZDQZNohDFGGa4GfwQVrNlpVeF+x2r2wyA2S+vatkIkrENaZd2NC3VUuBV86l5sth05H/nwOroVRoPyUwd623Tdtf2cCMomoK/s77Vqk6ip5zV8pCdE+RT8/43QMPVofpJG7imZ5x2V1Ajgbb+a2vqjcifKESaZsvwOj8OUxZWQoFS6R0Ihk8QAxDHzr5vbIq1autp6R/XGgaq8mg6EyyG8zIZ6LvWzOZr8JGOAaRbyd/IPhyJQ4xm12wovM8QXhlQk9Ru2WJ8fJDTfFAsa/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/fQF3Ci6MdXVZJDBN/RPTt016Ze13Q8gzg2AR1DV8k=;
 b=RqrAiW1+PD/SPwdvAIGS4kjKZc843uoEpCckxE6cy3NyxcOjOUIkzWiY2eMWMg5yfNEYfwWJYBVXZgPW1scjYDzSk9LD3cIxb8zwgBnIFJqEavJpAWhO6iX/1QNR/uVYcRkRMqOk8l5cDs9P8HXdYKHxeh0dWbVIrQioWWwsgZM/kQKZXVZhY4p/QsvG/uND4LZ0Fy6TuWmHp3qU2MiYCwT3u4hAKMMNJ8z/00O/u83wrXeoZ748EE1Yuptp/HSiOvZQRIYeNEv5tThwTsq6F6uuQeEVeaq02JT9QiTu5/WolhKlocS0x/ZneC8Frq3hjCxwiHqW0YHNWf1mdvUJpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH8PR12MB7205.namprd12.prod.outlook.com (2603:10b6:510:227::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.26; Fri, 4 Jul
 2025 15:23:01 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8880.030; Fri, 4 Jul 2025
 15:23:01 +0000
Date: Fri, 4 Jul 2025 12:22:58 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	rafael@kernel.org, lenb@kernel.org, bhelgaas@google.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	patches@lists.linux.dev, pjaroszynski@nvidia.com, vsethi@nvidia.com,
	helgaas@kernel.org, baolu.lu@linux.intel.com
Subject: Re: [PATCH RFC v2 1/4] iommu: Lock group->mutex in
 iommu_deferred_attach
Message-ID: <20250704152258.GL1410929@nvidia.com>
References: <cover.1751096303.git.nicolinc@nvidia.com>
 <98fc799d0cad52d6886ed1136e84a654b0065820.1751096303.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98fc799d0cad52d6886ed1136e84a654b0065820.1751096303.git.nicolinc@nvidia.com>
X-ClientProxiedBy: MN2PR11CA0016.namprd11.prod.outlook.com
 (2603:10b6:208:23b::21) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH8PR12MB7205:EE_
X-MS-Office365-Filtering-Correlation-Id: e5d25fc2-08d5-4720-0118-08ddbb0ea9df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OhUP0ixSJOcY/9gj4Rw6mzSxKaWAh7ZsAXnk4IP07GcTcgEqj0jAhxoR7Ks0?=
 =?us-ascii?Q?e9pJtuBbZZPuIo1UkePakGiI5Es+DKp8yM4bRFKa5LOifLxhsGqom/q7qF+H?=
 =?us-ascii?Q?NnHHlMIaCryrBXqkNukHrv5f7q/JjvYvoUSYRyat6W0umvTzhjNoZWzK+hEy?=
 =?us-ascii?Q?IMqqNkH43ARFtxOKCQ+Ix0L942PadvkUvwXfgSxQb7Jf9p+nLXm22bxwbzjk?=
 =?us-ascii?Q?VR+NJC0Iztgq/62L2pda9SGpCPo34bKc67Fw13zhn1zuk7uitZbqqiEiPQIB?=
 =?us-ascii?Q?vXMIXPxGDALf68h3gzY2AAN1B4DREP6U1nLR0mFoQ8Xb7sPFCyQ6a2Ew6wDh?=
 =?us-ascii?Q?vh6lQgr/yEDaynHh5yfk+ubdS4NXexMbMFjKnqiFNYrYDVZGj4Onu7Gf3t3D?=
 =?us-ascii?Q?GN9d1VK8rR94VjVC75lSn+nWxI/Uorei9QZd6LlH5elr6YUeJHqqa/J1bVuT?=
 =?us-ascii?Q?MNVawbUzeHsd2sT3SPVuY6PYTEYB7jaYKsgOoqeNyGkei1Q9XLCUEwx1N9PZ?=
 =?us-ascii?Q?xFiw1CMdKHTy5mmAhEQaWPkfF+cNpy+rmG7w0zf2CyD4d0IAQuLgi5PXnn2D?=
 =?us-ascii?Q?1HoJJfozAMdCSYNEeo5Pi37y5Z1T6Qfu9frpe4QD0kdE5tispqenhqvkOJjf?=
 =?us-ascii?Q?sprNoI26OWZQf6CK7qqOOOF7z2smIBlmUvr/gofF/7NnGeWW4TGyEKzXof00?=
 =?us-ascii?Q?h+x3vj5yM5wEfwWYSNPf/5G9xAhrGUM/UY+oGGVCzZPxDpsK2JMeS/GVd4Df?=
 =?us-ascii?Q?t1t0o3b9L5c99p8Qo+P8wQMDDEsOK5wAIfNeSNTxRVGB9jIdiZ5K2wtdg86Q?=
 =?us-ascii?Q?RFMYkHBIE9x1QnknwfPteiIU4iOoPfkLON0GAwIRg96BRPkB0FnY+9riw9Zb?=
 =?us-ascii?Q?WAYsvVe402+auif9V6OqhmksBxSnU6aBuGBM01Hxxld1Mhh8CJrhWbA192G7?=
 =?us-ascii?Q?IgPN0n0A78PazYx2kmzp4WYLwbkF4An3hRfY03kAyFVaiiiYOzWOEQwPIvxN?=
 =?us-ascii?Q?sidUDPCIPL8uRrkiDic0k2wEmIzg13Py8nLPDRimlIii6gM+PkCgQ3mCVntf?=
 =?us-ascii?Q?aCuEufU2Tqa7Om0fIsWr3K99mKVf4j7DM+DJ7HqxClYsJDfq1X/GFOYOjd3g?=
 =?us-ascii?Q?bJ8HHl6Y00isR0BB0pdXdOfB8Rwqa9I5l/0jJaCRPWRa4AwTMFSrJqWZKOlP?=
 =?us-ascii?Q?/HClvSa2GCGAkR+vjL8DOGZhGr+FCp07bjzHM4SGJ4Zirw/NpaqRNgk77i9o?=
 =?us-ascii?Q?eBswqzJME/6SYOo98mxk+tMBvnF1eJ5egxGfhMKT+cCDhW99JHVdjerqXAxn?=
 =?us-ascii?Q?yZwKCJH+hWDka8GsRQblswPXwwepQ0edTshoxnnnv6vVyugyPHFtU6K4QDUG?=
 =?us-ascii?Q?Qcf8hrxducb35qRjOnuHd+H0PzmmV9TGzhtSfxIWx8iTMCGuuTMpqsmE95wI?=
 =?us-ascii?Q?hcfaPUvKsEo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k+uxt2wlhPZ8UGXS5yYVGqAM0DvFgbQnIdv2QfISc7dCKEQxlBRdg3XzFW+r?=
 =?us-ascii?Q?MaeOS8So2V7hEW3oBpKBNyn20PmX5F5AjLSbF3xN4mY5znkbdATiyZxJEklw?=
 =?us-ascii?Q?jWeLB5LdTF9l8M8l21s60n2896AMRbpQ1Zzr25vi7dyXJbaXVtVp1M03rKaR?=
 =?us-ascii?Q?OPu9vqoO64R7f1OVH+d4NKILn3Ns7QQ5+H8sXPVpb9RYUZYk8J6DFdv5UC7K?=
 =?us-ascii?Q?cIWV4uzTnzowOFHemIQVf3TMRmORpD57LMTBi0NnQfErvb0dxfDohpcovC4Q?=
 =?us-ascii?Q?skZpcfBtWUa0Qtk+GdYmfevvtKVUPoyxo/N5dcZnhNMs+e2YTC5db7qa9sAg?=
 =?us-ascii?Q?4wYPqs2C/ycGSJYBSoLKN2mT8DT/xFBJ/ifyMfWkZhWcTrk8gVe5xvK/VQxM?=
 =?us-ascii?Q?8c1mrVs4V4i+JHWyMoj0KW7FWm2/G6K2DibmZbewphhEYz6TbGgTlJwVgHaq?=
 =?us-ascii?Q?G9i5ebe4j3STMXU5uiKMDH9J/1EDNn9V+SNA/3Re39Bx3lzHi2tC9EFEqdNf?=
 =?us-ascii?Q?+IxLmSrbaCbGxaMMEMB8BMUtBwcrwmtvI3iDPAb47qdXGvokzCDWOQxYZrBi?=
 =?us-ascii?Q?3YEqcJeSd4Eb0nxXMusBUom6/CMrMQ72uk0l33dhw/NTe8Iq/ubkY4O1+kJo?=
 =?us-ascii?Q?gPwi2GgnO7/M12efwhtDyqolsyBRrXtk2P2msw7lUbfD/uVweksxNrG6yqGn?=
 =?us-ascii?Q?qBC6/PSuZd0SHpmh1plWoE0qVE0s3L9StALNUSG6qMNUQAz1VnLdbFalteoz?=
 =?us-ascii?Q?MmqCPl+iAcw4X03UosxBZiSlQJRmX5VRe9uiTGfJEfoIHZ9LfkFssojh0NjT?=
 =?us-ascii?Q?kAr1g7IsL+n1yjTCHTrGiFdy7i3CajTvGPL8tFF+81WWq/Zi4hhHv+hbW0iZ?=
 =?us-ascii?Q?InTr7u3vEDvQSkSq3RLHIHVe4Bk7u+nTBXzRlO5SFsdRHBUsZTx9TGbqw+9k?=
 =?us-ascii?Q?PotuE5d0iK2InZOU2ODFlbNoPh6UJUzBAH3yVtYaWaSh0M4EhZi9+QMq4S9h?=
 =?us-ascii?Q?3wTmOaXl5T3SDWlUrhz8CnXqbRWu4uhuA7S9xBBhN8/6lqOv8rYzsdp7gTyE?=
 =?us-ascii?Q?8o866lDjHSGtoQA8jOhQhnO8ztunowMN9fuG6V2fALtLacw+2jhxmyeawCbz?=
 =?us-ascii?Q?t+c3EHTVLiXBfyQ/wv1D4Yx35QlGMhdG2xDZaYcyx4A4QT/KuJyCgKW7MuY0?=
 =?us-ascii?Q?ZI+p1cIOZVkRfM2/xZkyYobdA6utld8nCD9Qdpb4ZK+h36clRBXKPVdYJVr/?=
 =?us-ascii?Q?r1ByLUGZ9sL4crire3yWSL6Tj5i1kRQPeq8m9D0X2FrieFvdCCsZKpL5wkEL?=
 =?us-ascii?Q?q52MbZWmsogf8oYGGViQqEluBWw3nvonCCYqQ4uS21K5CaMAGoMi9CRvioNC?=
 =?us-ascii?Q?9UV7zJkzKkW3rKUuQTa3OJfwMaUjLgM80SkyHmg7kFh89vynl5B6yxuzwPLY?=
 =?us-ascii?Q?9BJNUvVQcun+hAalRfOEtqvvQnq0gHXZftRmmoDuzujRz//Wwh9jfywHob7t?=
 =?us-ascii?Q?yzab78XiqGUGP6qm6JOxh9gFpfr8aDv6USLs0A4ZAgpCcMOa8eaxy4pecx0/?=
 =?us-ascii?Q?gNz5dQHj1hImhmB5MbFbZOSvhHEFuDBJA/ojRJXL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5d25fc2-08d5-4720-0118-08ddbb0ea9df
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 15:23:01.4600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zqbg3/FRZ9ZmBbYKboK4duTH2F/xp8tP2ftl/ev+mcjKnylSonMJl06g+FJnQxj/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7205

On Sat, Jun 28, 2025 at 12:42:39AM -0700, Nicolin Chen wrote:
> The iommu_deferred_attach() is a runtime asynchronous function called by
> iommu-dma function, which will race against other attach functions if it
> accesses something in the dev->iommu_group.
> 
> Grab the lock to protect it like others who call __iommu_attach_device()
> as it will need to access dev->iommu_group.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/iommu.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

I vaugely recall seeing something like this before.

IIRC it can't actually race but there is no harm in taking the lock so
lockdep works reliably. It isn't fast path.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

