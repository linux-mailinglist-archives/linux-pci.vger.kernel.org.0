Return-Path: <linux-pci+bounces-19341-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D6DA02B12
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2025 16:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B6973A59B7
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2025 15:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775F1166F1B;
	Mon,  6 Jan 2025 15:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="C7RfAviP"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8865C200A3;
	Mon,  6 Jan 2025 15:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736177933; cv=fail; b=oddDDF5f7HqL4IaD1II+dMElmT1ukOh1Cb1JbjFi1zUVIawVEjGDb+mgulxpmlsfq5xE1o31vRyhTiN/y56lHahd+LiWMN9A03DRwQyxNWhtxD6KhCh6rPuEZYAlwjhto0hqpBoF6nPIDovOVzNofXsDRzmMNF7HNxvObZ8zins=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736177933; c=relaxed/simple;
	bh=B0fTpYwBx4wLlExgdwWFeVDEw2CZczwMfiADLfyNiRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qYCWAUdyQ2S68v2eSzI64yEJz2uBRCDq+PW4SneoKmO8pHNAXviXhYoZ8EO788ZSEy3JwcfHoWEoIeI1Tkp+1VLT7VE5IsaIfP7xIWS3edbua6AcRSCHdoGWwQJwrSfYhoJXAWCVWOL96wSO5CcQuweMxB2E+/hho5GuXk97Tbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=C7RfAviP; arc=fail smtp.client-ip=40.107.220.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o0xtNLM8tbw+IPG6jP2KKwIx/I9P6tPzuUJooNSf6MWwWEgIbMwd6iGn6yFDEnWIzOajdIADkqbU0Pft4c5RAipCQnG7mCCyf439XU4CClbp6OvkY19POvY3greDXPRQ9MLcjX/1xo4vEUoo+huIvY/NWnb2ybIObw3udalO6Og9hdEnn5HDKIHyyVC5E9nPVuSGRpN20Mrw4pq6jx85YvVFIOBVsrODbWifaR5jpwCTNJnFvF7v95jebqDxiqQBLc11TkykNxNI/iSD2bKYbcl+J9Wl7Hp0vPjKNbZX+PzSOUIjcfuKtqDNEJoxUA0hEILswwmEvTF2f15ePUHauQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S0t3DxbBvqJrp8zNsDAuiTBmWsUhR67YyswaueDYtnM=;
 b=Au1VJq05cvI9bziItbLQ7h0SmJ7omurxioFJ8KlcdODJ4iFArhsESokwq8nTOZ9aqsWFWX6BsbIoUihB5w+y/UVUydeRr+lNVbT1bQN4YAJXrA1JyFfDSO3D+mTZbrZk8l99c9pP4pk/cjG/J4MbKOUl5XubcWfx0xx1YZLjxQSu5MwRqf701/oNbVpAqexFPGOCUPe/t1CXgBN/Hw170YqjTjwI9Nt/57/+1RFsEeQZLXUuABWn0GpJaZcwXAkUZB1uRLDMEVBqHOLz+e8fJ4E6eL6XZALLzlsxg8upkqFvxfSUG/R0TNoW8K4a+oviHJaclqo0ezWT0ebSzoowKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0t3DxbBvqJrp8zNsDAuiTBmWsUhR67YyswaueDYtnM=;
 b=C7RfAviPahXOGt7JymrzcT7w1DOjlqtyIehxhObW+CwjzV/QIdoOQe3n/GYCmWRRuRCExtJJfjOlC3XRxZ9ASf1I7pd5Oxr7HhLdCGhkwp5nsZqBoUc0upfFE/E8I5Ipe62EK5x1wv7fkZzIQ5eVluZt6fz/c3q0FxJ5vlIejhI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 LV2PR12MB5919.namprd12.prod.outlook.com (2603:10b6:408:173::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Mon, 6 Jan
 2025 15:38:44 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%6]) with mapi id 15.20.8314.015; Mon, 6 Jan 2025
 15:38:44 +0000
Date: Mon, 6 Jan 2025 10:38:39 -0500
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
Message-ID: <20250106153839.GA631754@yaz-khff2.amd.com>
References: <20241206161210.163701-1-yazen.ghannam@amd.com>
 <20250103214925.GJZ3hbZb5xEQ2wltln@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250103214925.GJZ3hbZb5xEQ2wltln@fat_crate.local>
X-ClientProxiedBy: BN9PR03CA0041.namprd03.prod.outlook.com
 (2603:10b6:408:fb::16) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|LV2PR12MB5919:EE_
X-MS-Office365-Filtering-Correlation-Id: e076ca1f-c20e-4f82-310c-08dd2e683445
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GVrskfW3Q+t0Ht2KGICsYWrQesSVIzwHPF2zMuZG9x0cHnzZyoTbpDIFh2XZ?=
 =?us-ascii?Q?NtNEj0VulcSvcnCtza6yvLuIXZ2cdHu6nZYDeSrE9AkeUsOOjN4noiM+GffQ?=
 =?us-ascii?Q?jY52lJgmVcQALF3XLkCZfC3MM7Ji+kkO0u+I7wX1SSelzxTY3ODArnYV0hkN?=
 =?us-ascii?Q?ib/8GWDDjk7EGM+2LwkxVuiYxuJv5ulNmulllKNjEIS6HW1FmHrAR5hayLEB?=
 =?us-ascii?Q?SmC6ORZkY17tJNa5GaYkJ1sZP9iKDg/p9olo8UzvSOD2A5Hm9mgJA4wK2iMo?=
 =?us-ascii?Q?bVb+IgiA/1t4h0vfy6cdrvLhOBO1aIhZXp8zxdyiHWWJztc+0nw9rM8VGIch?=
 =?us-ascii?Q?ZR56u6jl5rX1LfJKt0vYpPWmfnohmlNpW6TbZhf9ThydAJ2O28+j3ZBQBrvJ?=
 =?us-ascii?Q?0ll2Y2dHicyuId/owy2HdPPXJNyRDtuNp0tfquGehlkHIAvl3pPMYXK9Vh+D?=
 =?us-ascii?Q?WffGvyzIMPQO4P+tt17PNtpojhB8xZPL+Q0X2QAuAl1rx7Myp/Ecjdl1GhlW?=
 =?us-ascii?Q?t5Iqrxn9sDbFLJtOKkRUzbxQpSBH1eks+yk2WO0/uY3s/9jog6xtWFAsQkvL?=
 =?us-ascii?Q?XjM0ZNfL0InzxI5p0Wj9sm7zglWs+bRtfkgNrIFO+zUT0IQ4YGgvz2Q3nEax?=
 =?us-ascii?Q?GDV14iSZ7jlMQLdcAlyIh61PTcHMsWrrBu2vcHgbQaBZfJYU4gF+ydMmNTAZ?=
 =?us-ascii?Q?8++J/8cn9gJzzmJCc9E4NF57CBrw8P8GADcHdmFAhZjZoHOxnG7vzcYI7+xC?=
 =?us-ascii?Q?WQL4qxiVjS33stKHxm4xEbt7fWAZqDlFsxCo/DjPK2ZaH8VHiCaK3wXw/tSD?=
 =?us-ascii?Q?cc/5M2pOdcKHKgCp65rLUGEWs1Nho0EKRXQM7pBWqpXVlOTWc1jMo+9NLFJU?=
 =?us-ascii?Q?MgpQBsu9Q1b0BqbsQ/Go639LhV/736bjyZXX6gj1nmO8VF5M5xmzbF4cVRja?=
 =?us-ascii?Q?19ciLTG5ZQINaHAPi4NUaj29hneEKOuZstHh9vuK/HoAaIeU4sbid8rFcxqO?=
 =?us-ascii?Q?NUmVYTY7e3kvoUBUqSh4UfEk6r+p80tWuLX5R/DltiFNk+WoePC+wZ5fDvdv?=
 =?us-ascii?Q?ZOIkqiJ/FPb2BapI9FoHI1CEyvj6tQf/EYWd5txN2mJGNGuB1j/3tGtF/apS?=
 =?us-ascii?Q?OymWmhtxiIpQhJO6Tv0ZPlIoba/zvGaLiVPNmKH/np5SvT5QOdhM6qMhOfNw?=
 =?us-ascii?Q?WVBxPIY2kXm4Mz06ISLSnakuKJvm4SUp4httsVyeStyyYor7ulWmgYXfBFQ5?=
 =?us-ascii?Q?z6jIpDS1dEeDrjeaH8B7eX9T6yFfrANTTklc0TBlm8fljeQgyFEpB00ithb6?=
 =?us-ascii?Q?U8J8MmF/QkpDex1W+qz9OiG7vSeYgOvlNOX/bWtZgGNcbGpZ6Eonh8Hrynkd?=
 =?us-ascii?Q?TT3QcPAFA8VC8p/+Ol9zcoVj3P8V?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z53ACA9rmtwqQDbQCVIDpkSRxB2NQw7mdfw+ej6Y5F54eTqE7wf0ewDR6LNa?=
 =?us-ascii?Q?bOCianAOn6iozIyg4a+NuQlOnAwvBmgFRX3lw4Ir/j3KuCCOlG9yy1Ao1d/3?=
 =?us-ascii?Q?kz0IZWzD6VxgnCTJ+NFD4J9LaGrJK5IStvmzxxdCpoTBvKTMLUJaHZidv78o?=
 =?us-ascii?Q?tQ74fPadUHq4YojCrwoEjvnYQtjTUUMevQ2oU9NTdTFKHZzMmv3rVUDqGiEM?=
 =?us-ascii?Q?OCcM0XWF+Z3AwxQVk1aYeBZFlYjbl2WMHz+p1H379hvU6TMFLlrNeWN0RWBu?=
 =?us-ascii?Q?1L8zelrZY6VWoKNpeH8lsyCtlBUq1FPr0TrJoqFM901iK5kk3aEjEuOdMvCU?=
 =?us-ascii?Q?lQII2d0LVuuqFSMrHH0dZjk8fkOlLBnLTrT2GKyKfw+HQ9at6961Xt1vHv9F?=
 =?us-ascii?Q?LrNQGExShJ4BV3RD9EhzbR4DFyWYikwjSD4YRP2JvHYeiPd24VXumvKZer4b?=
 =?us-ascii?Q?GhrUMSACV4HiL6KOE5A04yAkeWKx+eEYUmCCY4IRoT5F7FGAzajPednIXPX6?=
 =?us-ascii?Q?2ndUhEW/S2vhVeR+vIEu5veQDk88S4ZauzfGXkjUE1G1Q4jcw9T6qQbVtHfB?=
 =?us-ascii?Q?h454Bbtmpjh6x1ILaYTzC8+dUN9DRPsCRaACTn1dPqncxUXBY5Pk2AgMQB/2?=
 =?us-ascii?Q?PJPiXFZypfDqKYDez5072JwDjpeYsMVhrBu/oohsXapcJNijslPNFsWvYNQs?=
 =?us-ascii?Q?VQDzqmAY6yreYmuxmMTER1BaHnVhYHrZk5Siyn65WDNwCyGjw6FBHlCFt9SM?=
 =?us-ascii?Q?wpyhkGGJsS7iq8IoO0Dslxn0bIXhrBSUL28DsadCJeI26Yj+5Gnw+Vejf73E?=
 =?us-ascii?Q?INNb3WE5wCSQrz9sw3+ifsjx/qiRf954hr40qzxkgE22OCKCjmf4tdlzf77L?=
 =?us-ascii?Q?xTSzOUfddU66btPgDQuHg0lP4+FegorhSdj04B/aqGPH1duXgWuwav8/nqFZ?=
 =?us-ascii?Q?wHDiaiK850y9SMxV1ED1Wnd/67TWyCOl/t3GDQDLLqZx5zqCLuZPqKvahyQ7?=
 =?us-ascii?Q?zeqzJO99JnYLmeyYWZmjMPimN2kOWHzvsb6Ga2R1kfnre0IDvxXp/r/wnP5N?=
 =?us-ascii?Q?Fhw4MqiLFRabnNDoKOTD2w/MoTeWrpppmOwi7xZ4UZNafn9It+WXRVkK/p6f?=
 =?us-ascii?Q?/sYS9dHXDttZQQGCzH8AbJbIEQZK/7oysegPeyTVci4QtJFOVxzAejkZhHxT?=
 =?us-ascii?Q?dJngzEDKMEoWoBf/GwopqSS9mEBnYDdcK7Caopko4LH4KA4B2lok2tq/WIq3?=
 =?us-ascii?Q?XOcOAadmNjXaEFb38BiAtmz8OYHNKUbtyjtLSR+Ko4tkwruzyQ1ZIHpssuUk?=
 =?us-ascii?Q?bubGiWDZBm2G/lo72epiXE424A6nCQxufs12mV/mt7nWX7qLQVtCSf/uRqP+?=
 =?us-ascii?Q?65tn8GrCPmHtnzXgYkdza/3vK7kEROma/wZ8oKFbplF92ruM6SE7DYl3ujSd?=
 =?us-ascii?Q?ZhkGJTXAQIXUS+G/XXb5KGAlFatnVf/oC2sMX5N+/tDFiDtGLSMmj8n5ydkb?=
 =?us-ascii?Q?MMPGhnqCH3AZBu7IV37wVdFfjOs0iAo3ENvK2Y6KQM3p1KMvbdmURmPIc/39?=
 =?us-ascii?Q?voVO+mbCcBqRWKn2wzYkzI2aJt4HPpFhBkf4LfFt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e076ca1f-c20e-4f82-310c-08dd2e683445
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 15:38:44.7784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GdlfFxMU3B7yCR+oNX41BNN63GvgdQteJ6F2isKknxrDKmjbqAUvRQeK2BtFqV0hSlddTTQahswUEXeetaMG5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5919

On Fri, Jan 03, 2025 at 10:49:25PM +0100, Borislav Petkov wrote:
> On Fri, Dec 06, 2024 at 04:11:53PM +0000, Yazen Ghannam wrote:
> > Hi all,
> > 
> > The theme of this set is decoupling the "AMD node" concept from the
> > legacy northbridge support.
> > 
> > Additionally, AMD System Management Network (SMN) access code is
> > decoupled and expanded too.
> > 
> > Patches 1-3 begin reducing the scope of AMD_NB.
> > 
> > Patches 4-9 begin moving generic AMD node support out of AMD_NB.
> > 
> > Patches 10-13 move SMN support out of AMD_NB and do some refactoring.
> > 
> > Patch 14 has HSMP reuse SMN functionality.
> > 
> > Patches 15-16 address userspace access to SMN.
> 
> So I took the first patch and then booting the first 13 with the intention to
> queue them while the remaining three are still being discussed, is causing the
> below in my guest.
> 
> .config is attached, I've pushed the branch here too, if you wanna test with
> it:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/log/?h=tip-x86-misc
> 
> [    0.897060] cirrus 0000:00:01.0: [drm] fb0: cirrusdrmfb frame buffer device
> [    0.900310] BUG: kernel NULL pointer dereference, address: 00000000000000c4
> [    0.902551] #PF: supervisor read access in kernel mode
> [    0.904096] #PF: error_code(0x0000) - not-present page
> [    0.904268] PGD 0 P4D 0 
> [    0.904268] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
> [    0.904268] CPU: 0 UID: 0 PID: 20 Comm: cpuhp/0 Not tainted 6.13.0-rc1+ #1
> [    0.904268] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 2023.11-8 02/21/2024
> [    0.904268] RIP: 0010:pci_read_config_dword+0x9/0x40
> [    0.904268] Code: 00 00 e9 8a f9 57 00 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 <8b> 87 c4 00 00 00 48 89 d1 83 f8 03 74 10 8b 47 38 48 8b 7f 10 89
> [    0.904268] RSP: 0018:ffffc9000012fcd8 EFLAGS: 00010246
> [    0.904268] RAX: 0000000000000000 RBX: ffff88800d296640 RCX: 000000000000003f
> [    0.904268] RDX: ffffc9000012fce4 RSI: 00000000000001c4 RDI: 0000000000000000
> [    0.904268] RBP: ffffc9000012fd60 R08: 0000000000000040 R09: 0000000000000010
> [    0.904268] R10: ffff88800daa1eb0 R11: fffffffffff8dc6f R12: 0000000040000163
> [    0.904268] R13: ffffc9000012fd60 R14: 0000000000000000 R15: ffff88807d62fc90
> [    0.904268] FS:  0000000000000000(0000) GS:ffff88807d600000(0000) knlGS:0000000000000000
> [    0.904268] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.904268] CR2: 00000000000000c4 CR3: 0000000002c1a000 CR4: 00000000003506f0
> [    0.904268] Call Trace:
> [    0.904268]  <TASK>
> [    0.904268]  ? __die+0x31/0x80
> [    0.904268]  ? page_fault_oops+0x15d/0x4f0
> [    0.904268]  ? srso_return_thunk+0x5/0x5f
> [    0.904268]  ? ttwu_queue_wakelist+0xf7/0x100
> [    0.904268]  ? exc_page_fault+0x78/0x150
> [    0.904268]  ? asm_exc_page_fault+0x26/0x30
> [    0.904268]  ? pci_read_config_dword+0x9/0x40
> [    0.904268]  ? srso_return_thunk+0x5/0x5f
> [    0.904268]  amd_init_l3_cache.part.0+0x6a/0x110
> [    0.904268]  cpuid4_cache_lookup_regs+0xcf/0x2a0
> [    0.904268]  populate_cache_leaves+0x6f/0x530
> [    0.904268]  ? srso_return_thunk+0x5/0x5f
> [    0.904268]  ? dl_server_stop+0x2f/0x40
> [    0.904268]  ? srso_return_thunk+0x5/0x5f
> [    0.904268]  detect_cache_attributes+0x97/0x330
> [    0.904268]  ? __pfx_cacheinfo_cpu_online+0x10/0x10
> [    0.904268]  cacheinfo_cpu_online+0x22/0x250
> [    0.904268]  ? srso_return_thunk+0x5/0x5f
> [    0.904268]  ? __pfx_cacheinfo_cpu_online+0x10/0x10
> [    0.904268]  cpuhp_invoke_callback+0x10f/0x480
> [    0.904268]  ? try_to_wake_up+0x23b/0x540
> [    0.904268]  cpuhp_thread_fun+0xd4/0x160
> [    0.904268]  smpboot_thread_fn+0xdd/0x1f0
> [    0.904268]  ? __pfx_smpboot_thread_fn+0x10/0x10
> [    0.904268]  kthread+0xca/0xf0
> [    0.904268]  ? __pfx_kthread+0x10/0x10
> [    0.904268]  ret_from_fork+0x50/0x60
> [    0.904268]  ? __pfx_kthread+0x10/0x10
> [    0.904268]  ret_from_fork_asm+0x1a/0x30
> [    0.904268]  </TASK>
> [    0.904268] Modules linked in:
> [    0.904268] CR2: 00000000000000c4
> [    0.904268] ---[ end trace 0000000000000000 ]---
> [    0.904268] RIP: 0010:pci_read_config_dword+0x9/0x40
> [    0.904268] Code: 00 00 e9 8a f9 57 00 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 <8b> 87 c4 00 00 00 48 89 d1 83 f8 03 74 10 8b 47 38 48 8b 7f 10 89
> [    0.988792] RSP: 0018:ffffc9000012fcd8 EFLAGS: 00010246
> [    0.988792] RAX: 0000000000000000 RBX: ffff88800d296640 RCX: 000000000000003f
> [    0.988792] RDX: ffffc9000012fce4 RSI: 00000000000001c4 RDI: 0000000000000000
> [    0.988792] RBP: ffffc9000012fd60 R08: 0000000000000040 R09: 0000000000000010
> [    0.992761] R10: ffff88800daa1eb0 R11: fffffffffff8dc6f R12: 0000000040000163
> [    0.992761] R13: ffffc9000012fd60 R14: 0000000000000000 R15: ffff88807d62fc90
> [    0.992761] FS:  0000000000000000(0000) GS:ffff88807d600000(0000) knlGS:0000000000000000
> [    0.996772] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.996772] CR2: 00000000000000c4 CR3: 0000000002c1a000 CR4: 00000000003506f0
> [    0.996772] note: cpuhp/0[20] exited with irqs disabled
> [    1.680874] tsc: Refined TSC clocksource calibration: 3700.028 MHz
> [    1.683128] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x6aaae08e541, max_idle_ns: 881590514464 ns
> [    1.688137] clocksource: Switched to clocksource tsc
> 
> 

Can you please share the guest parameters?

Thanks,
Yazen

