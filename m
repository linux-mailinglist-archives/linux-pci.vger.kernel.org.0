Return-Path: <linux-pci+bounces-19349-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF210A02DD5
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2025 17:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 045841882C14
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2025 16:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967231DEFE9;
	Mon,  6 Jan 2025 16:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EMZ5ffRA"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA391DE3CA;
	Mon,  6 Jan 2025 16:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736181084; cv=fail; b=SCsi7k70hJdSbigyuAdFx7Rq4XyoWpGKO7Wan09EOkBZqgJ54Hx4I5xSrFbIiqCRVIi1/SEZzsbD3M64acCk+tgES7lM4eKw9nO6UywVyNW51gIcU9XU0tguiE6pZYyWFAk5s0aP93WTZV93NafxVqkpZ3AXSXFUH1Yt9Tbn5vY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736181084; c=relaxed/simple;
	bh=q0fU/O6BtQsbINSkGLtZPgGtx5L8ts5VkvMkLyAx4lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FYDqXZO4Bp8VVQ6GjO/nrS2mOtVMni3iopiKmrjRdUeukCFiljlEXVLWOavVsJSkYRJ8X7VWRuxjTznJjgGiCBKYgy9Ppa/zxur8m4/JcUx4xBMuMrvkIzlSmSGbgIc+1lVawS3+UD90Do5KK6jmtjN3SxQQYSTvBnvqsc4uQBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EMZ5ffRA; arc=fail smtp.client-ip=40.107.223.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hOiQcdNw0sHS3ygRR/bF8Qu/DV2t22qQoUMfIcZVo90xng+NxkTkyw5OwDlav4s0qnvPh6RHFNdM04D+o+2bufb5j9bH3LjBI/TRyE5KUYjuq6KF4/ky7S/YttxSe5O4Y5BmvbDrdSUMHun9Ri8Jqrbn9sW9ueytgeTw3AgJ99UJd4Oy+Jlr4lcLjjpgLxrBp6Y7Zknri411hTfqj2kt0r8ACAnpnNcsHQYWK+IntnF/rTLieUN4GlREH8Nez+kILUIqo+EhyND1mDF2iU79VC7AY9kNQv+ymD7NhtBtG9uolvI+4cPprSp5Jvfx9LZPmEpKG5Lhz+4uHovqqzW62Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hf5W/A2IBTZ7FjenXPxmMewW2zeRgru3rxJNx/oX4Zc=;
 b=FDR0wp1iq5F9WVMJTyA86IQv3owYhqJ1sN5n0addH/MeZnx2QnN3R2nwZgDWm37j1uyJQ5mHZEu0qhfjDAcXLdrcz/EiQTqnGUCHLlkKNckyXUYqNw0YPxd4RJEyCFScmmU1/oVdEJk6pHKypsnG82j94BdUm+vRGLd2fYYsKt7485sAIPuEPC6VfKu6aurrLP3rKmv0qP2++3EJJFIErp2t2AvU3y5tHZCY2B+D49mxAC/1L6iwABTLFGp60IyV3wTxutldXAXOPO8U8W+qFhxdFom/PsV/V9+Zb5lbF9hAYht192zzS4SgPngvqBx1PAVLms2U8PfyF27Nzt2fQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hf5W/A2IBTZ7FjenXPxmMewW2zeRgru3rxJNx/oX4Zc=;
 b=EMZ5ffRAIriFA3gjMgjmDKdnoQG2BrDG+xlcshaiaJ/04u/CgkaX5FjT2EUO0A0Tk4p1LIOJaYLtGdMHaEVRSkKpYVKtS2ccYDjls97MBSHPLLjhUAVOmPS3JDET4QYJxCT+c9R+Y7RIEEL9Gl5Vqi0mY3yZTFb6prRvR9cW3bI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 DM6PR12MB4121.namprd12.prod.outlook.com (2603:10b6:5:220::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.18; Mon, 6 Jan 2025 16:31:13 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%6]) with mapi id 15.20.8314.015; Mon, 6 Jan 2025
 16:31:13 +0000
Date: Mon, 6 Jan 2025 11:31:04 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, Tony Luck <tony.luck@intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Clemens Ladisch <clemens@ladisch.de>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>,
	Suma Hegde <suma.hegde@amd.com>, linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-hwmon@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2 00/16] AMD NB and SMN rework
Message-ID: <20250106163104.GA664169@yaz-khff2.amd.com>
References: <20241206161210.163701-1-yazen.ghannam@amd.com>
 <20250103214925.GJZ3hbZb5xEQ2wltln@fat_crate.local>
 <20250106153839.GA631754@yaz-khff2.amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250106153839.GA631754@yaz-khff2.amd.com>
X-ClientProxiedBy: BN0PR04CA0164.namprd04.prod.outlook.com
 (2603:10b6:408:eb::19) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|DM6PR12MB4121:EE_
X-MS-Office365-Filtering-Correlation-Id: 498112f7-5379-4082-c137-08dd2e6f893f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?meZ+NV3BdlJcI8umwdNXzj8YvEYaY9422UEuwR458ZKKgqjrZlgCuKHrF9Bv?=
 =?us-ascii?Q?gxQi5rxhZZpCNaHLhZ7hcl+fP5e61lbKt8D++8LdSnwQ9eCcL6VlGF+/j6CW?=
 =?us-ascii?Q?/CakJbG+hAaBYHs5viCr023iSkSpRiT73td4Wl1IZQQeeyNAYBi9Jm1a7PVM?=
 =?us-ascii?Q?Z4/f6o1WUnPfcFxlVQuKVEfkTSq2fIXfgZ59YNbh7ybaOikHPaoYoPkOPjvk?=
 =?us-ascii?Q?th9clhUxv1MTiqudGRBWtXRj6SHPqKegEjxOrL3Ab/PNIs0U+UNdFbK5RhBr?=
 =?us-ascii?Q?YCOUbCgZKViWnAjeCtguQZJ8QXA4u0QdfHUnV9GSC0VvJq0PljCZQmJ49sFN?=
 =?us-ascii?Q?zztn4OTcWH2INHZn8RtZh8t1+d2H9RY4mkPhSTic5eQ/Y33q4o/cnjyt/LiZ?=
 =?us-ascii?Q?bF8ta1dQz3VFIiVqVMx8bztGMVLcuqvPIIwv8V3DJex/8ZqJQ51WUPQET/SX?=
 =?us-ascii?Q?imrc+IPyjSFWZKY+TLH2jv5HR2PyN9Xp19Mm4lwol1r7DG3x+nGgj0gy+PTv?=
 =?us-ascii?Q?O9vd70wITWhP3lVtSI7C//UM8tNS1UR/VVqDUj7iaUAEJRZWXWD+iJJ14Mp0?=
 =?us-ascii?Q?XreOEAhNLgxRK461AkP3SiZsMXEY4xV3b8n9rdKpRpMUu1N0+YCRRs3+mBi1?=
 =?us-ascii?Q?DxCm+iFqPB5ZC1FDcaI/aOCLzaY3Zo3VoQCW9ah9wWH6pFDG5VXpFVmAPseD?=
 =?us-ascii?Q?DHcc3tB5NLLqcggfJa1JBtoV1JvEWA8SzVzF4WKXQHbQi2N1PRo1pTGJD8KP?=
 =?us-ascii?Q?Oi3IBseNNIE6x3nladixPfp854JndaJqhQrcJZVhtEJf7CJ9378TytUgo9NI?=
 =?us-ascii?Q?ZhBl3cmVf2FuXtgAr51GS5KpDW7768hLvov8WtmIsqQjTghe4PjB3tPiPXrC?=
 =?us-ascii?Q?3wlNbWtjPJ5QuKMddJiw0k5yMlwRoNMCUbxY7R7x1Voi2W4Ia+OYcbOY0Mis?=
 =?us-ascii?Q?quSjBEoq7hK1QLqt1QpO0wU4FJvhds+YSDKZhVF0wxMPsKPsHsnbV0/6Geng?=
 =?us-ascii?Q?0Mnl+91ytvitMMOWuPYmJt/2sdWIqBuHVWCHm/tM7QqOctbk/+7EpAj5Yno9?=
 =?us-ascii?Q?MDcRpa6fLGGNF35MrfydubMp4ypSJZ82ajXZTkf6XxsLOIYCzoWxV+QhUtoK?=
 =?us-ascii?Q?9EIqOJpgWDhGpBvzcAOVo6bsFT8PK8MwgKqn+ubGrUoBND21K+V3uqYCn5tW?=
 =?us-ascii?Q?zr+fignAVaAAMze1qUPa/rQh40xiZW40OkxVFk4XrjW8KrMLlYojNsf9BLM0?=
 =?us-ascii?Q?7bq5znxI0JAuBrKXW5UOdxUrhxCMRtwSBDR33F1NBANlM5q4Lb3HiGnj3kS2?=
 =?us-ascii?Q?qdp5DWNKIKWu/qyS8H8GgeqVBRrup4DtSmfeT3kdFcaTqcQtbGdVkMzuCzR8?=
 =?us-ascii?Q?DpetFy38JkZaRFO4TFjHNSl/+jFM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/CETOBoFUH+6fsaWkIh2kbA7TsoZPi/Ek8T5Gt9rcX8R+1+p7vSgEyPY3Sv6?=
 =?us-ascii?Q?OWBxd/fqJRRqtVLfBZpj8N0aFY4rMTlzXNPKN06CRL7XaOy2la8Kv87we5xw?=
 =?us-ascii?Q?7KhGA2ra8gabr/L6dzEslev2sYt+uHNNa+0c1sEB/gD5d+eWveezuofHQTaI?=
 =?us-ascii?Q?m3yRogzKB1kGPqiJj7OlujFJ8F1rvcOrUq9C1Y7Qt7aepjf4esFp0LHLY4/W?=
 =?us-ascii?Q?1l6PacOw5hR4ZyGCqhkOZ6xDh0jVq03PjwKWlEDUFF/4dEFudk9cp7QCscEB?=
 =?us-ascii?Q?sCRD/PsXXctcO4d1926FX3rqFesoV9iLjaz9cHCS8DlePLWUQAducaLB5lec?=
 =?us-ascii?Q?0v7PkjitWfuc5SuPSGgMEd2N5Uk1ovCL+4T/Em/rhsNjEgGKvLoYf9Ey/Zd8?=
 =?us-ascii?Q?AO1tQa/q5tXqhyr9ED6OWKUWR2nM93MPhh8xuuSi0ZNr/oJ67n9Os7mrr6kB?=
 =?us-ascii?Q?g6r7honOVwccIVJC4ejMoKwP+/E88xLGEEHyGlNUUYhGhBH14M/8CEZeNe99?=
 =?us-ascii?Q?24D0PZmNrFsKkW7DyBa9hA+huRiQh2BzxPnAz7jzEwIrf+Ij/WUk+EoEPB93?=
 =?us-ascii?Q?Ah1Yj4DqyKiO4kTdVLaCxU75kjc1k+Xni43Rv6nWutja3UBwkt+o5jqfHaP8?=
 =?us-ascii?Q?1f7oMHFla33D7h7aymxekAaJFAtXAnJroK92ZFAljouu7ELQ68eLUQ+Hn9fR?=
 =?us-ascii?Q?nRuEtOnlXc1bIg4gOC52nYduBLRbyS1sx5LmxzHfExM6EP1797kXov5pjzlB?=
 =?us-ascii?Q?cju0fdqynd/uMVZtmhOQkywralTqwSARDbg4Y//LUaHEQoX0wNDINNPR/X/d?=
 =?us-ascii?Q?hcLkVUFecPQVJIHAEiYqjkmri73gbyBun0gicggiAfO1wnZ5LUcE6349gKVP?=
 =?us-ascii?Q?e/GvxGxjq0fucrPxpnqVRCp+H0ZlpTdLfWd+jsqnyDexITEiC9ENfv880xS3?=
 =?us-ascii?Q?YmmgPbWTYPckBdX/65H9+2DydRBDh7+E7HpjcJkeH2dT31ZgdtXHlz6cUngD?=
 =?us-ascii?Q?WiuuJLEtmHZg7B4EKnN+BSKNGgKA/2erCG8WmFQ3QXY4hMaVUOPjGAMPwzP2?=
 =?us-ascii?Q?i6tklxMwcisG0HfM/CJF6kqawvAyAdBqrEu9Niv3qTMacJE+c/M4bzhwwvJj?=
 =?us-ascii?Q?BlgqlM+ODHc7vXmnkcR7gTyWnOdy3wih597JTPbxhdpkbhjFfUNHtU40Z6i/?=
 =?us-ascii?Q?tHt7uw1jgDsPI4oM3Erhz4h0G7RPd56Q5TrjzMgVhuyr3IveJK+KtgVY5wvu?=
 =?us-ascii?Q?+uCr0rkY+p8WC5bmaDpZsoRvtIoaE3rOGsJ/hFC1+ExOu/gW7ar0W1b8MuPx?=
 =?us-ascii?Q?byDEZ6wQ/BlERKbpY47W9r9vk5R2BVyyIa3vUSolNaJKSX2VVeMPE7iHfCBn?=
 =?us-ascii?Q?yGjEwh2AqJs78akqI5yRvAk0EjHg36+7tFaYMMn5qdnL8PuSsFMb4h2Uuavx?=
 =?us-ascii?Q?VRoEZABGwh6RfCMsv71Lcg5HZpFCiPxfSgK3GdvYPMAJVBmv/vsk2RxWZKxk?=
 =?us-ascii?Q?MkUEeSyZgvQhoc5OCxktcEiodXSJ1U0YLvQ+0wB0pIh/mq3ufGQLAseB/REv?=
 =?us-ascii?Q?uK7qMGvNBhbVzMFSfua+8g7UT/4zO8x+A+WLLPGr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 498112f7-5379-4082-c137-08dd2e6f893f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 16:31:13.8379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g3Mrdr5PZGYkUEJcx1JIVwtSNyp1Fc3chdMnCS3tYrtHDUQX9y1ZcJY3GyOUZFlRd5skq5Lu/J0HW+nGImikbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4121

On Mon, Jan 06, 2025 at 10:38:45AM -0500, Yazen Ghannam wrote:
> On Fri, Jan 03, 2025 at 10:49:25PM +0100, Borislav Petkov wrote:
> > On Fri, Dec 06, 2024 at 04:11:53PM +0000, Yazen Ghannam wrote:
> > > Hi all,
> > > 
> > > The theme of this set is decoupling the "AMD node" concept from the
> > > legacy northbridge support.
> > > 
> > > Additionally, AMD System Management Network (SMN) access code is
> > > decoupled and expanded too.
> > > 
> > > Patches 1-3 begin reducing the scope of AMD_NB.
> > > 
> > > Patches 4-9 begin moving generic AMD node support out of AMD_NB.
> > > 
> > > Patches 10-13 move SMN support out of AMD_NB and do some refactoring.
> > > 
> > > Patch 14 has HSMP reuse SMN functionality.
> > > 
> > > Patches 15-16 address userspace access to SMN.
> > 
> > So I took the first patch and then booting the first 13 with the intention to
> > queue them while the remaining three are still being discussed, is causing the
> > below in my guest.
> > 
> > .config is attached, I've pushed the branch here too, if you wanna test with
> > it:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/log/?h=tip-x86-misc
> > 
> > [    0.897060] cirrus 0000:00:01.0: [drm] fb0: cirrusdrmfb frame buffer device
> > [    0.900310] BUG: kernel NULL pointer dereference, address: 00000000000000c4
> > [    0.902551] #PF: supervisor read access in kernel mode
> > [    0.904096] #PF: error_code(0x0000) - not-present page
> > [    0.904268] PGD 0 P4D 0 
> > [    0.904268] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
> > [    0.904268] CPU: 0 UID: 0 PID: 20 Comm: cpuhp/0 Not tainted 6.13.0-rc1+ #1
> > [    0.904268] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 2023.11-8 02/21/2024
> > [    0.904268] RIP: 0010:pci_read_config_dword+0x9/0x40
> > [    0.904268] Code: 00 00 e9 8a f9 57 00 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 <8b> 87 c4 00 00 00 48 89 d1 83 f8 03 74 10 8b 47 38 48 8b 7f 10 89
> > [    0.904268] RSP: 0018:ffffc9000012fcd8 EFLAGS: 00010246
> > [    0.904268] RAX: 0000000000000000 RBX: ffff88800d296640 RCX: 000000000000003f
> > [    0.904268] RDX: ffffc9000012fce4 RSI: 00000000000001c4 RDI: 0000000000000000
> > [    0.904268] RBP: ffffc9000012fd60 R08: 0000000000000040 R09: 0000000000000010
> > [    0.904268] R10: ffff88800daa1eb0 R11: fffffffffff8dc6f R12: 0000000040000163
> > [    0.904268] R13: ffffc9000012fd60 R14: 0000000000000000 R15: ffff88807d62fc90
> > [    0.904268] FS:  0000000000000000(0000) GS:ffff88807d600000(0000) knlGS:0000000000000000
> > [    0.904268] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [    0.904268] CR2: 00000000000000c4 CR3: 0000000002c1a000 CR4: 00000000003506f0
> > [    0.904268] Call Trace:
> > [    0.904268]  <TASK>
> > [    0.904268]  ? __die+0x31/0x80
> > [    0.904268]  ? page_fault_oops+0x15d/0x4f0
> > [    0.904268]  ? srso_return_thunk+0x5/0x5f
> > [    0.904268]  ? ttwu_queue_wakelist+0xf7/0x100
> > [    0.904268]  ? exc_page_fault+0x78/0x150
> > [    0.904268]  ? asm_exc_page_fault+0x26/0x30
> > [    0.904268]  ? pci_read_config_dword+0x9/0x40
> > [    0.904268]  ? srso_return_thunk+0x5/0x5f
> > [    0.904268]  amd_init_l3_cache.part.0+0x6a/0x110
> > [    0.904268]  cpuid4_cache_lookup_regs+0xcf/0x2a0
> > [    0.904268]  populate_cache_leaves+0x6f/0x530
> > [    0.904268]  ? srso_return_thunk+0x5/0x5f
> > [    0.904268]  ? dl_server_stop+0x2f/0x40
> > [    0.904268]  ? srso_return_thunk+0x5/0x5f
> > [    0.904268]  detect_cache_attributes+0x97/0x330
> > [    0.904268]  ? __pfx_cacheinfo_cpu_online+0x10/0x10
> > [    0.904268]  cacheinfo_cpu_online+0x22/0x250
> > [    0.904268]  ? srso_return_thunk+0x5/0x5f
> > [    0.904268]  ? __pfx_cacheinfo_cpu_online+0x10/0x10
> > [    0.904268]  cpuhp_invoke_callback+0x10f/0x480
> > [    0.904268]  ? try_to_wake_up+0x23b/0x540
> > [    0.904268]  cpuhp_thread_fun+0xd4/0x160
> > [    0.904268]  smpboot_thread_fn+0xdd/0x1f0
> > [    0.904268]  ? __pfx_smpboot_thread_fn+0x10/0x10
> > [    0.904268]  kthread+0xca/0xf0
> > [    0.904268]  ? __pfx_kthread+0x10/0x10
> > [    0.904268]  ret_from_fork+0x50/0x60
> > [    0.904268]  ? __pfx_kthread+0x10/0x10
> > [    0.904268]  ret_from_fork_asm+0x1a/0x30
> > [    0.904268]  </TASK>
> > [    0.904268] Modules linked in:
> > [    0.904268] CR2: 00000000000000c4
> > [    0.904268] ---[ end trace 0000000000000000 ]---
> > [    0.904268] RIP: 0010:pci_read_config_dword+0x9/0x40
> > [    0.904268] Code: 00 00 e9 8a f9 57 00 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 <8b> 87 c4 00 00 00 48 89 d1 83 f8 03 74 10 8b 47 38 48 8b 7f 10 89
> > [    0.988792] RSP: 0018:ffffc9000012fcd8 EFLAGS: 00010246
> > [    0.988792] RAX: 0000000000000000 RBX: ffff88800d296640 RCX: 000000000000003f
> > [    0.988792] RDX: ffffc9000012fce4 RSI: 00000000000001c4 RDI: 0000000000000000
> > [    0.988792] RBP: ffffc9000012fd60 R08: 0000000000000040 R09: 0000000000000010
> > [    0.992761] R10: ffff88800daa1eb0 R11: fffffffffff8dc6f R12: 0000000040000163
> > [    0.992761] R13: ffffc9000012fd60 R14: 0000000000000000 R15: ffff88807d62fc90
> > [    0.992761] FS:  0000000000000000(0000) GS:ffff88807d600000(0000) knlGS:0000000000000000
> > [    0.996772] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [    0.996772] CR2: 00000000000000c4 CR3: 0000000002c1a000 CR4: 00000000003506f0
> > [    0.996772] note: cpuhp/0[20] exited with irqs disabled
> > [    1.680874] tsc: Refined TSC clocksource calibration: 3700.028 MHz
> > [    1.683128] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x6aaae08e541, max_idle_ns: 881590514464 ns
> > [    1.688137] clocksource: Switched to clocksource tsc
> > 
> > 
> 
> Can you please share the guest parameters?
> 

I was able to reproduce it. The patch below seems to fix the issue.

There's a comment in the function that this code is not for virtualized
environments. Also, the "L3 in Northbridge" design doesn't apply to Zen
systems.

I'll keep looking at this to get a better understanding. My first
thought is that this was silently handled before, because the AMD_NB
code operated on PCI IDs. And these wouldn't be exposed to guests, so
the northbridge data structures wouldn't be initialized.

Specifically, I think we now have a non-zero number of northbridges,
since using the topology info rather than counting PCI devices.

In any case, I think it's better to have explicit checks.

Thanks,
Yazen

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 392d09c936d6..93d993a6a1df 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -595,6 +595,12 @@ static void amd_init_l3_cache(struct _cpuid4_info_regs *this_leaf, int index)
 	if (index < 3)
 		return;
 
+	if (cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
+		return;
+
+	if (cpu_feature_enabled(X86_FEATURE_ZEN))
+		return;
+
 	node = topology_amd_node_id(smp_processor_id());
 	this_leaf->nb = node_to_amd_nb(node);
 	if (this_leaf->nb && !this_leaf->nb->l3_cache.indices)

