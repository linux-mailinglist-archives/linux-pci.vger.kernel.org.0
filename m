Return-Path: <linux-pci+bounces-9729-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6179263A4
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 16:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3154D1C2169D
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 14:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F9D17BB1E;
	Wed,  3 Jul 2024 14:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KmLy5Nlm"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCE815ECC6;
	Wed,  3 Jul 2024 14:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720017754; cv=fail; b=Laby1QxULVOy2buC8YHpkmcOVSueFlpY9IIpIiuVME2y6TM//UWfZRT7tML+W28RoZX32fksJ2CXUORbLNxxfAvq/VCgkwieQ3NLiRGR4EQwaCtRIsJFA1yndWRH2dw0Hu/CJZyChuP+fbgQvpZPXf9SzuTN8ipqef5pnmbMeEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720017754; c=relaxed/simple;
	bh=f7ZJeRADllGIDpM2GHENDn4CtIvbThy6KSVfBfffQMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=R++VSIIe8Wb2B+oWUPZmEw4FskqFyn/ytff/7ODC5Y/GZ23yQFGBjSBtdIvcUSPpIVfL6A3Zqb8RjohEGzmRabIkmH182S/sQ6oVa3gc9x2eCj7HSVmTtBBOYQURjmmUPA8lAzqukP/3FfpMNDSOVIZqLSSfmZ2SucxKjwaY9k4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KmLy5Nlm; arc=fail smtp.client-ip=40.107.223.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U4OoYgQsG4YjhuUrgXcKAPojDmIvFnfDKor5w7jFR6k0/RpW51ftdUkpuugcsz8z2QN/qB6/avI0QluHq5OzMkvXxCDxkcIB+g/7gl9lH7SYxO/Dzd6o1lTqzz0lpvelVEGAMrW7W7k9AA7R6ql4fhm7lfMouxmO0oI40Iqcg8YYvbDq6shStMfWL5zjiXx7jnkw2SLFiPaNktnN1Mjqjlakvb8UTCTAA7D/QReItd4YtySTEhYkMcnZcxaInFfRkaQe/McO+cdO692GCkLEhYwLS2JE9Von+Gd9rQoC0P0ZCSJl2KSkDllEpdrLDJtI8FKWzroYVvA2YfANSTerqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fqwOjsn4Qk86KXssOgIrmd3ORxpmUS3dNtsdqwbaG08=;
 b=kkAYUw5P7IPZWSwMunm5p9JlLpNzDsKETtkyAlHxHR1wlTetf2XKzFWJ9PIqpPSK1H3QcZpO0MzW0UX/85aKSbkR+fpHtzTf4oaK8RMtJai2+xpCcRigknpbauitpQXdRJBiI8ZXo4/VqDn3aCLcPP6WYafq8VFH31NUYTGSn6V4tDjcdpZWV2GkKo39Q237KYvr1MpwxC5wgRQrJE0wq4JQbQddSolRaoEofmOddx8tA3jlMYQGLY92EmVjrjR2WVn6eS4MDr3OSS3iQ+Hz6oDpJOCDMosYt4+2DCVliUPN1g9LB/BDonWdaP/y8+XJS2oVIc5k6JcLmYSrlOqjag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqwOjsn4Qk86KXssOgIrmd3ORxpmUS3dNtsdqwbaG08=;
 b=KmLy5NlmoNHsn2uCj736fg6/JardTrM70bfWbpZa8KaOF//o/ZosIEI/Mo2m8g8BCOZ7odUKMKvB65k1B5lK9Q9Vj2DRLX75ztB26FUYR3TJgll3bFMzTrJGKqBKCEcdaXourzplsexjvAlcdR1aVgtXsUQDS9Jr80K7DEQCXlQq70/y7wgen5OZSb6y0ucSmw47lgZqtHFTSwcWw3qJPVk16w0bM86KUwLvOLnICOPFvSctkvczTzxn+J8EJhwNMNFJ/1kdfuogrLXaNXprCL8NCEf9a1dGNy1IsA0p+kMxqmfoAaUyjg0XMpZ+dUWpGPFjhtIClXm+e9J+lph6Xg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by CH2PR12MB4039.namprd12.prod.outlook.com (2603:10b6:610:a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Wed, 3 Jul
 2024 14:42:27 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::9ec8:2099:689a:b41f]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::9ec8:2099:689a:b41f%5]) with mapi id 15.20.7719.036; Wed, 3 Jul 2024
 14:42:27 +0000
Date: Wed, 3 Jul 2024 17:42:05 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, helgaas@kernel.org
Cc: Petr Machata <petrm@nvidia.com>, mlxsw@nvidia.com,
	linux-pci@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] mlxsw: pci: Lock configuration space of
 upstream bridge during reset
Message-ID: <ZoVjPb_OwbKh7kHu@shredder.lan>
References: <cover.1719849427.git.petrm@nvidia.com>
 <b2090f454fbde67d47c6204e0c127a07fdeb8ca1.1719849427.git.petrm@nvidia.com>
 <79ee5354-1d70-4059-aa9d-9d9ffa18689a@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79ee5354-1d70-4059-aa9d-9d9ffa18689a@intel.com>
X-ClientProxiedBy: LO4P123CA0165.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::8) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|CH2PR12MB4039:EE_
X-MS-Office365-Filtering-Correlation-Id: 5022029f-948c-4cd5-9856-08dc9b6e5c29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J9rBeG7yLvsN5acvgr5vT/w3LWefzN1BVvQoFE+xIqFnKQZFMY0sI3DfpyQm?=
 =?us-ascii?Q?tmiZM3XfS4h+lPgZgNAeLBlIPYynpQeC5lmlYSiSBoV5b6KbHG3MVTefp+wr?=
 =?us-ascii?Q?0KgI1PEGqVjcC/rVzO5t+QCijWvMORJZDb8/17Xk6DAYdWlEW3SgrzIF4aZ2?=
 =?us-ascii?Q?9dMtTlMj84H6KACI4EbHwCVS42z0wplwAsCmmxwEcEpF8smv8Ws8WBboisXC?=
 =?us-ascii?Q?bgA4SIKY2l2RMSAA6A274nTQbQctLrCDqXg7G8mrQx7sPPP8N9xmjczZ3kWt?=
 =?us-ascii?Q?Unv9AfLvcNOCy0DCiBENhRX+pMU8rp5adTHD+1Q/E7L7Qc5ljAV4aoVCoYF0?=
 =?us-ascii?Q?P/q+OnQ7w3a4By+q5Vk0ryATllrrQ+hSxrMl5QpbcMTmJBzwR/PFC1Ty+j21?=
 =?us-ascii?Q?Rv1G8KPqVocjyJ+j8wFdrgV/goWEG4lYoNLMRHx0NupTnsphYbvualcI8d7f?=
 =?us-ascii?Q?H5IbwrOMZiMNjnqURTCrpa+znRU+Hnkjnr5tSil4vhhzg19P3U/7AmK6HWz5?=
 =?us-ascii?Q?WILpdlcrUpV5RwLrLWNOz6TwxYYYb29IJ5IFD087sKWMKkozQ4kA6MndrZmf?=
 =?us-ascii?Q?STOb8Csk4gWBLrxOE3yCWS06MnGYrC6sAgZrEx0beNWcT6HBVNL1/r61Zmxh?=
 =?us-ascii?Q?L/T4jMpZol4ZeFvHY3UcPjauuw3+4SSVKfw9nq039Vl+zXSTvOvAKE/uD/Fc?=
 =?us-ascii?Q?gc/7V42xhu7xMBbaLk28U5h3aUoa1fHgHj0zdw7Fps0rG/GkP0V6hn/NUUAb?=
 =?us-ascii?Q?cWfYE+/kl2u6kwr1fAGoemoDIoxISIJW61SnkIBBiMTLqcUigj3bB3PLwNxh?=
 =?us-ascii?Q?EU9eJYq/PWtOAmy9bYrvfrEZrdDTkOZY6uerwVqLpt50ccp9XpwJVPHnV2ig?=
 =?us-ascii?Q?WLfmzG2HeHETI9Rf4xkq7k2OAQd+dZXW60LDRETvMXmmertiJ2Ud3OCTlmIA?=
 =?us-ascii?Q?cC5EJOlo8jVhuqpOlW0vCtZjzvUw8yZkxYNRA4A2saAXTDjSeJGq4n01ivq/?=
 =?us-ascii?Q?kHUtiXCWpJmjfJcswkGErclf4Nra4rgQb56J1nTbWW/Tx3emltDLjYLsDdX+?=
 =?us-ascii?Q?ZJeTaYednX2q+YpB8htpUq2dVnIkODjOBNIZPn1XS4r2Zp7zON789wBHP8dy?=
 =?us-ascii?Q?sdg8kROe8VG1TSo6Q829aWyxk+9Ws/PGVclnx/9AnFPsgVQOLEc2KqT5LXR6?=
 =?us-ascii?Q?DI7m5HgYqA7W/Huq9eRbG/K01r/iCbyYpO/vJA+ovx5H8+HgeMCtb4zY3pzq?=
 =?us-ascii?Q?cGnvYrAUyPhnZxtMMntl4hJgO6ivAuBHt1CttmmdU1fChCPQUFbDkTdGJ0lo?=
 =?us-ascii?Q?L7ckvyzNUVDP9rRYKtJnq/VPYV/LjqIMTmg4j07VtAR6LMevOZKLe3G27tSh?=
 =?us-ascii?Q?9dwXSqo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gHwy/D2irqQxJMXIoxtgPOp3PgnTFfYds+qg0nUL0aqJsfteep1eoyC45ouG?=
 =?us-ascii?Q?giJAPepAzT7coGhauowE8goyOZr4EAogH4N9sa0ULV8vsKYFiGJ84riuvXa9?=
 =?us-ascii?Q?Zi7MBaXSlQUsGWsh/3ABJIL5f5IFsPNphi4mOX6iou+VFuYmgk2d6cXiEo0M?=
 =?us-ascii?Q?rwkLfuQX4rIrV8iiBUwu/UGzsIu+eMU/5kzO5ROM9xRwEMDgu373mhFMNEpz?=
 =?us-ascii?Q?aB0KHBwcCH/Vv+z272WrbbIbrF6DOnCBaySbHMSbVJlIXqpqo0tXPLvr0xLN?=
 =?us-ascii?Q?JJ12QsyJaF3Pi4c8BXCZBqecLoTZXt7Si3Apz7MPTKwR08BtR2A9GwUvGU8N?=
 =?us-ascii?Q?XDB5maeo+OprxKgv/gUfaPVonFMVPC2HdDjvhdCwFwqqAjxRIaIOJPtpvnS3?=
 =?us-ascii?Q?aVvljJvqmPZfplxU1DT29XVde4sewdYdOnRGhQ36xHbrDRZZWUg5gDowlYBa?=
 =?us-ascii?Q?H+yCvfCPkK+o9mnHzQqkusUumTF18RwKfxwKDFPWUMDVZQP1h+zRR7faBBTC?=
 =?us-ascii?Q?zTZTFy1FZizwlDigY0VdaW9tTV/eilKvomH+OBNWigoI1fWNTvMGrOIzidxh?=
 =?us-ascii?Q?LqSdzUWvjJlcBl+VuIl3On63NbdidQe6gfb4qP9N25ZAT3n97Ik0PH5bk/mn?=
 =?us-ascii?Q?1w1fquP8S7b9nlUuDh9l5I/RZFWZNvU5QIa39krqRC2LqoycTcgF8pCyZiO+?=
 =?us-ascii?Q?epl/9OZ/2coJs0MRCnYKKj8HTxz1RLIUVLKRBWt8C6ffSiFaqu/CViL3/AyU?=
 =?us-ascii?Q?H3CCUNtC2cM8hUp57/RO52a7xVGItzMtb0o09YD1YdOguJzUwXc+FwqmZtCp?=
 =?us-ascii?Q?BrXJ+/heClPhnjCb1vJPPryX5ortSTMyJrHWD9AFZ8W93uWrlRAlO3uZ2hgV?=
 =?us-ascii?Q?dH14BO7nIiWCMBnIXzL5LD/Mk1fZsWFaziQXpXnPw7xmmT3LqbZnFbHbnRva?=
 =?us-ascii?Q?bhNDukOuAvKitCv5vqsysZt7xJA2o0DJcHQx0G7tKwcp8t0jY6f9WlSI4cSJ?=
 =?us-ascii?Q?JrlOWyK5pN+IEpITdfLLg/GQZoeyvvNR9k3QgjrmhVe0gsa+efWjrT6U49JL?=
 =?us-ascii?Q?Q2MVvdbDQYF0c4aDA/eNyx4Xgp90MOBbZbSTWxVO9McwroRrlKbjdaYtWHXY?=
 =?us-ascii?Q?W+RjOKhKaWyTReRmu03Jj6+amXolkpn8j7k/wfikAqXPFBjohYQZCOW/kDUH?=
 =?us-ascii?Q?BZsqVsnJV5ZSKlog1O2OKnFzlVFZzn1+zqy20Lf9Z3zXjZfNPIAn8wa9hCpe?=
 =?us-ascii?Q?fkvxj++ds+6u6bjgWJQqyA8ugMKgBr9KXNLkKu7THHrBn95EqNQetKbU00Ix?=
 =?us-ascii?Q?6Ifzo2/MK5F6g3SIGI9hHW1UfoNwnyWfiEeIkmLIifsc++hn0eX2ULXBKlbd?=
 =?us-ascii?Q?vy6wrwyXJChyD2B8Yf+PHDgSU4UgroZraiuIq/Pk4JPOy6jKspN9BOuPdnIM?=
 =?us-ascii?Q?c5S08OzdHATpe8drhwMWx8RJ7Adzj9hXMhKZYqKE7uM69OErMp52lkZZa3++?=
 =?us-ascii?Q?iy3JL33Lywvyg5AMglMsGJdA6hrzUzRbzD9irMZC154Hi8HaqgcfmR9Eq3wr?=
 =?us-ascii?Q?sInJ5vWh9RWdzEgoC6/TFPvgBooE41A702dGvjNJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5022029f-948c-4cd5-9856-08dc9b6e5c29
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 14:42:27.6866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SzzaumycEoL2eUIafjclZkUaVh36IoFuCsHgbuFWOzFNtnqt82igqGt2iIHBciakefpcWAD+Recu6VJTan0zNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4039

On Tue, Jul 02, 2024 at 09:35:50AM +0200, Przemek Kitszel wrote:
> On 7/1/24 18:41, Petr Machata wrote:
> > From: Ido Schimmel <idosch@nvidia.com>
> > 
> > The driver triggers a "Secondary Bus Reset" (SBR) by calling
> > __pci_reset_function_locked() which asserts the SBR bit in the "Bridge
> > Control Register" in the configuration space of the upstream bridge for
> > 2ms. This is done without locking the configuration space of the
> > upstream bridge port, allowing user space to access it concurrently.
> 
> This means your patch is a bugfix.
> 
> > 
> > Linux 6.11 will start warning about such unlocked resets [1][2]:
> > 
> > pcieport 0000:00:01.0: unlocked secondary bus reset via: pci_reset_bus_function+0x51c/0x6a0
> > 
> > Avoid the warning by locking the configuration space of the upstream
> > bridge prior to the reset and unlocking it afterwards.
> 
> You are not avoiding the warning but protecting concurrent access,
> please add a Fixes tag.

The patch that added the missing lock in PCI core was posted without a
Fixes tag and merged as part of the 6.10 PR. See commit 7e89efc6e9e4
("PCI: Lock upstream bridge for pci_reset_function()").

I don't see a good reason for root to poke in the configuration space of
the upstream bridge during SBR, but AFAICT the worst that can happen is
that reset will fail and while it is a bug, it is not a regression.

Bjorn, do you see a reason to post this as a fix?

Thanks

> 
> > 
> > [1] https://lore.kernel.org/all/171711746953.1628941.4692125082286867825.stgit@dwillia2-xfh.jf.intel.com/
> > [2] https://lore.kernel.org/all/20240531213150.GA610983@bhelgaas/
> > 
> > Cc: linux-pci@vger.kernel.org
> > Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> > Signed-off-by: Petr Machata <petrm@nvidia.com>

