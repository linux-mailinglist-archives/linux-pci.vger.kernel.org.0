Return-Path: <linux-pci+bounces-10552-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D22937928
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jul 2024 16:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 603731F22EDD
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jul 2024 14:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0861E871;
	Fri, 19 Jul 2024 14:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zZOyX8bc"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55C41DFCF;
	Fri, 19 Jul 2024 14:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721399292; cv=fail; b=TNGBTnw4udCwUg+GctSZ5xmvEdws8j7ZbN2StXBReIXloOyGggpiFyZzol2LUr/QevhEQQ0vm0Uzl5qxpbyMZj3xLaEG76+BnrYbh7+U8qCNWFzQM8xCMG5N+PxaHy07R1mewAkQgbtK24+Ba+yf9NI/DAccvHCqwdwTJA6gOBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721399292; c=relaxed/simple;
	bh=LoQWXQy3dKOs3dXQWMR5x/Rf9VnMpQhj9lbOXNorMsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=izlxnGr8eIZ48dpvSZhlQwp4DrztUqcFmRWzx54+fai3QdoNPzevMJDJAFmlK33E2rmuwEYQaqy+rB6nycqu8qLunWJ/2bmvN5a7YvEIgLwA/whZPErss6ca6qMWynC7s5uky6BFvP7EvaOJBpQTT3QhloK+tAW6iqcsrRCBuBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zZOyX8bc; arc=fail smtp.client-ip=40.107.223.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kroVVRxv3Vpl+V9hAb7eTsCInfTtBGm1eGZNGeasv1InECWhfsIbDBmiNAybNRny6+IyYv4EkzBOy90Vm7akWAxXo56ne+BU2hlsl1bu0ov/q8SrKIUCSMJOPIkeVTn7HRPRnPsvO0o3eyymZT6S87qjsH5YSyEMe8znn5F+GTmyreIpj/4VxlwHgetcPhrM7glO6OC0KTSA72nk5QsTiQnAMl6UuuVJqM1WAVfHAdoufyb+JLqXLTdqm/+VKpXHmEpXZbhiyAIOubqKpQEG4P7Qv0rTCDux0iT+N6JZ7IQMzwyrFeM4+RAcSVMV6GbsqcQxZi8WtAKfmI24fcQvvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gTvOV/0X0ZOdXWW6g01BSe7G+lM3b1Wm9iEIyWe1dwQ=;
 b=e+c/R0rjOxsBmqhJkzv/pBUF1NfeuZoE7x1N2/Eml5ixPRTMTwsXvOJtGSuu7ZbnBPVP2JruPdy+oFrVexVjdDTtYz+RuCtMN72CfJBUxDjjck49OM7dAP1pSJrJDWfxRhEw9Ub2Bh9N0r68PmkMOPMxGMIJeSiKpnlYhUUBsshvn1YI9U28PCd5b/X6dby7wQ1COMnw6YLDVZuej45g0eumxewyUQAFB9dkZsh2x7oLsgOtH2UER1NFaklxhDFtGFl1NkgYyTHsJKWHKpBEqmQ0gwqODtgZ8E0N1C5VSrshwdVenWIx8aSBzHyKFoDYvnO42hohTJDVLZOaaC+33g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gTvOV/0X0ZOdXWW6g01BSe7G+lM3b1Wm9iEIyWe1dwQ=;
 b=zZOyX8bcEzH4wqKSO4Nqamj/gd8X7uAD/8W1iGWWX4Aw2v99LUqLRs7D97BMWyDHuZ7HOLJsjvQ8iZCS6Ny3b8CSFmzna+yLFTINPhjVJ+uEwxaPD4ZAU8e7+S3pdhQ2b9prjNuMiz72OfuYJfhXltLqJfHlQaXSETmC5jB9hWE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by LV8PR12MB9405.namprd12.prod.outlook.com (2603:10b6:408:1fa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Fri, 19 Jul
 2024 14:28:07 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3%6]) with mapi id 15.20.7784.017; Fri, 19 Jul 2024
 14:28:07 +0000
Date: Fri, 19 Jul 2024 10:28:03 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Bjorn Helgaas <helgaas@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Anvin <hpa@zytor.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Muralidhara M K <muralidhara.mk@amd.com>,
	Avadhut Naik <Avadhut.Naik@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v1] x86/amd_nb: Add new PCI IDs for AMD family 0x1a model
 60h
Message-ID: <20240719142803.GB17507@yaz-khff2.amd.com>
References: <20240718171342.GA575689@bhelgaas>
 <95ea23bf-b628-4fdb-a4ef-0029f9df2ec2@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95ea23bf-b628-4fdb-a4ef-0029f9df2ec2@amd.com>
X-ClientProxiedBy: BL1PR13CA0429.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::14) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|LV8PR12MB9405:EE_
X-MS-Office365-Filtering-Correlation-Id: 53ae5e89-35b5-4a24-ead7-08dca7ff0214
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SP2dTSxuNywTrL2q4yvRavyx7mnXNCxhyj1WUgeSKN6GNKm5kkFzQMEsr+2D?=
 =?us-ascii?Q?FiES1Xs5LllAwETxdnb9IEBaQNTyzsolzUCeTQ70QeltyypD9d3YQ0Q1QIVW?=
 =?us-ascii?Q?5sKWQJItv3ZLaFrD0ErKTnHyDtNdPPLz7hS+Amgi28oSeale8PXZ5XZCiZqK?=
 =?us-ascii?Q?JpifGWspM3wFqC4M/hxRxfo7iHx9RlBWCoGhXK8LwmWgee1mB61eCZFa2LQm?=
 =?us-ascii?Q?XFQwjFSNmIuuqjQLQoe2PqWO49dMw0a2kx2LKcAFdPAoxonFFhWK3zdmil17?=
 =?us-ascii?Q?nTgUw6Z/wLe2wxEKnXCdtzomDy/VDj74bFNDKqmaMHh6y5LRRNkjdVwe1Kv+?=
 =?us-ascii?Q?XlCqM2zgY2oxLk6tyBVyH7lyyE7hY83cCcnJ3rnCL3gQt4M98vEAFmP0Fk1/?=
 =?us-ascii?Q?rcG9erXqqbvT2P9cEFmF8BAI6RFbb75gKGYGpo0c0D6UzTpGIs9c7k5ngTi6?=
 =?us-ascii?Q?NAhdPT8kyfYkRk/8gR4OK78rbHQUZ7LQUxZCUm2Zd+B2/8cCbZaFjMAxpqD5?=
 =?us-ascii?Q?Qik1cZdxIXW7Vpw2DHxUD41rh82biAGGCoStwdr1SKpIjgt4ZaeAyTwPQCSv?=
 =?us-ascii?Q?Zeq5MfdeBJ15znAqhf/bPe08WTQFUGYkbywHRf4EJnl2rRsU6Ml3EKkqmDtW?=
 =?us-ascii?Q?Sddj3PXzM0Qvo360z5RhJoviRX2DlGlPUeI6WFnKWr6qYl2+4Y3tT/mL6D1l?=
 =?us-ascii?Q?NEQKg/qhTYW5yt84vKG/d3Yn0xu7oOGdTkxigduCQelQD2M0yrIc94B+Z9Ug?=
 =?us-ascii?Q?qo+8kVSrxgoMYuoAuxTyEZlJkmipL4IbrUDgMdWkZV9u1wjaAxMTb/zJPrQ1?=
 =?us-ascii?Q?qv0J3FAMh+1OMEMDNh4X9xYBjFY30ieK4z0mhbuF0Id8AuVqjVRMDGQN1JL9?=
 =?us-ascii?Q?Lk9tZRdBwlqGdAxzLyr1Yb4R0q3TGd2fZEQrMQUqxGUJOoQC8W81Ab64aVWE?=
 =?us-ascii?Q?mA2cIu0xlUqfxTfiWB5X7CSrXgsIEORM8/5ve8fvz3LqrGx1J9r8xuL11/qM?=
 =?us-ascii?Q?h6Pki0srPl7t/FEira5nFXZeL2afhxUJmf2/X0ycbKh5DymoPgabJbxD72IH?=
 =?us-ascii?Q?hDpH5GbR95dQC/JqlAhy85KZIRRJNlgJ5tvC1HUy2mfpBUfMUj9lo+FKx2wx?=
 =?us-ascii?Q?8iAnHzXlLHweZUoFxiNp3cpFl7iUSUmmN5OZAl1zA7iac2ZQU9SPMxF/mQ5X?=
 =?us-ascii?Q?QsyveyWUBijGx4OPNssLx95kwK85NNFJre1Kqvhv7cM/X1xbYfZWXGW5/rRa?=
 =?us-ascii?Q?0aLCvrXMA7GZDzixNbm8ZrVKHar+5f3CBj3p3gW1nLD+h8Coigm3t3AKUXMt?=
 =?us-ascii?Q?Q3gAIDkbsDWU9CRyApuGizM260oI81FKgxiJqyHjxMk2Dg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ja/XiXhGhm97AFmyVTf/x8bnSw4nxrNhRlqTlNsxXXQaogkSCcYhtBP4Rbcd?=
 =?us-ascii?Q?PejyON5yhwqulh4cVRJq2pcQB+iYbBrtg1+vxF2aWYuAhFpgdJTVLIhNjx9r?=
 =?us-ascii?Q?EOnroouoS3nd/DCq5Ws/LnhceK2CDstMuYq8M6NjyGFZShofcZbViUyiwpkN?=
 =?us-ascii?Q?EZaUseb/CcAuv24UDsYG6EDRgi1K5m83lZLJXl00St1c8/OSEGjybQ4VycpB?=
 =?us-ascii?Q?QWqrZQcqphh8+kcgIy7zCDCk0AbeZxBqctM3CH3467cgqJ8DFp9WSAP/u9jn?=
 =?us-ascii?Q?Hn0tfZY8RMeKopTezzjFyBflEKohDk+538G0r5vdIOuYF+wHFuekW00txFeb?=
 =?us-ascii?Q?ld42wT9pKZTYzY+D82cZrjjl8uaKG+caHfBQi8+dgP3W5Wjt3NGNNtjvNQ2n?=
 =?us-ascii?Q?vUoeAhrj+dosz7vnnjaO7FpvwbqExChZ6USrTE/WiI0rlUBAqOlVE5CTlMIq?=
 =?us-ascii?Q?G/Xuu+sJeJZtxmvbuHaxsR2jDgdaytzq3MMFC8dnth5Wllwbplv6M9gHZhhF?=
 =?us-ascii?Q?WyIhIxkeg4Q1TXAerBDqAG7dKj6qjUCHVrwQO0P8a6dK5Dg83rG0LJl2hLBi?=
 =?us-ascii?Q?jCY1eMyfDjZ71QQefNfGe92tV74vn4S42X5vD+GnAY4oU+T87bX/1MtG7pzU?=
 =?us-ascii?Q?FtZLdGuhf37nBcTmSNXspc9TxPy4t3/z+7hhyvA57t+oxgNJaJMrp9+1rUCJ?=
 =?us-ascii?Q?BteqwI6x7Je4lr9qgv8SPLEWKjO1cFhmxfwxGNC5PKSU+EehMHtz887pylZl?=
 =?us-ascii?Q?XgChxsbinCkvr9SSgh6at5/UxlBvNzM1STDx/dVHmjaUT4B8Vqa6Uuqbk6x8?=
 =?us-ascii?Q?YITEdhOgZEEOuY4me1njXmWUy/U+TUsFdCKFXm8rRsH/SQ/3SreZjEHLUpVV?=
 =?us-ascii?Q?5pauozpd4x6Z50xELGFlYHRhHGl2h1g9nkMK7ACdHaiJShiJSxmA2Gwz312W?=
 =?us-ascii?Q?8rQAjMyrQIwkRIdA/fRmynvoE5o6o9v7jcH6gCuOu48zeM++oa4N5VpfP4/+?=
 =?us-ascii?Q?AQhUaKpqeCgyEUrIXAXjifoPHr5nQad8LdG/YBDqF+LoUpdQ8XPVe6e6I3r+?=
 =?us-ascii?Q?pBFY5skXsKFxLjPVt0crQvjuGThDuAg7TcvdGEISxzR/GwRHiY/5bg8rc5o+?=
 =?us-ascii?Q?z9pQmXKvAF5KFdY3Dq7J5W8xkpZohdmvCegkkRxF+IQgVcHj7JdtyOfxqH5w?=
 =?us-ascii?Q?3fRkDUhsqWFSDt0YAAJlu32N9RRvCbLxBktxm3hZBmk47ih8hAVRkDz9hCki?=
 =?us-ascii?Q?HpSiN4JA5MRsc90zKZ8z5Z/KO2Jqcw/5RbrB06OHginIOYy29H6yXHdMgPj8?=
 =?us-ascii?Q?vYihvRUFiYKwAvqhusOdYE833AcVlb99nXiLprNcvKORz++jUW9hbOSAemsP?=
 =?us-ascii?Q?cMCr72otkVUTQwsY1rbdcxD+zzcikmAbWxF0Kky9Q9hftJgtNvBX1ZSgu+N7?=
 =?us-ascii?Q?t4oMBBIfyuHyKY3LKtg+LzcR3qq+Nd/QMIXw/7dcQ/vebWBqZmPSIFSkSVXt?=
 =?us-ascii?Q?OhJ59WYeko784kWrq3lIvNzEwBTqu7BFdwlLpAo2ShcaJRzbdGJOJ253sjAe?=
 =?us-ascii?Q?WSB9Wfm9rC7FFv7Ha+Up+JLkvJqqz9n1HJA0vKsT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53ae5e89-35b5-4a24-ead7-08dca7ff0214
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 14:28:07.4806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sy3YEhgtZMxX8FnnxRN+XwfmCVaFHUVMo7q1zXWu0v5cebGsCvKXAtSDzwePkYg4CT4Pj5tkfS1LlT4upyI3mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9405

On Thu, Jul 18, 2024 at 11:37:31PM +0530, Shyam Sundar S K wrote:
> 
> 
> On 7/18/2024 22:43, Bjorn Helgaas wrote:
> > On Thu, Jul 18, 2024 at 07:32:58PM +0530, Shyam Sundar S K wrote:
> >> Add the new PCI Device IDs to the root IDs and misc ids list to support
> >> new generation of AMD 1Ah family 60h Models of processors.
> >>
> >> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> >> ---
> >> (As the amd_nb functions are used by PMC and PMF drivers, without these IDs
> >> being present AMD PMF/PMC probe shall fail.)
> > 
> > Is there any plan for making this generic so a kernel update is not
> > needed?  Obviously the *functionality* is not changed by this patch,
> > so having to add a device ID for every new processor just makes work
> > for distros and users.
> 
> Regarding AMD processors, there are numerous PCI IDs defined in the
> PPRs/BKDG. I'm not sure if there's a generic way to address this
> without a kernel update.
>

One of our colleagues is working on a possible solution. It'll likely
use device types and class codes so we don't need to add individual PCI
IDs for each new product.

Thanks,
Yazen

