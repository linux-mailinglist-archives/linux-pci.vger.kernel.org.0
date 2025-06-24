Return-Path: <linux-pci+bounces-30534-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39575AE6E61
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 20:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F7A2168B8D
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 18:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDF22E62BF;
	Tue, 24 Jun 2025 18:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IH6Ew/0i"
X-Original-To: linux-pci@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013037.outbound.protection.outlook.com [40.107.162.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5912E6D04
	for <linux-pci@vger.kernel.org>; Tue, 24 Jun 2025 18:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750788769; cv=fail; b=Q1/G9pAmY2nJOEEaC2zWYgaR21iTvVG88YlBzMPByUyLt+OT9c4BlbRNjGKZOAxO8KZQjO3IHRksdm4V9veYzWXqnMx2yUvueviR2i+6ERltvw4U9TgyZzg1jjcaPWmNTjA5i+EkAtOraqrZt5pmrDflx2NhkgBeFpCNxpWPGFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750788769; c=relaxed/simple;
	bh=mTvIZmNqKnuXDG1rO1uBtG/i0xMhZYUAbwsHrIKSLQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=d9pT5ShTyPY1umncuYytPegaoISjgQccsBtPs1gV2vzy5dgN6wXDokv0IJN+ZFfQIW2LMcKhAaaBMMQkNdQS7jsQHPdsBqT2ZBUFAmHIp/Nh+NwolpcfQ/n8PtoVJPj/9+vZf4okZEOy19GMkMvagT395KlgMCXEbzy4BY3PrRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IH6Ew/0i; arc=fail smtp.client-ip=40.107.162.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EUbNqWu8w5KTGs/EqGCDMOlc0RzAxuuzZz4jNpmtbEMAdZDJr/+wpMtjnIMmdppHVaiHs1bQ8caOrUZwdD9UJzjxISntaAMFv/7CP0AzdkiCCNaahYq6aKhrrfRdNzFHWbil/FAv9J6J3qxZ0xg759vcSPgjX3VAbKoKk1rcP+/7TMmXzO1c4rvt3VTN5i0eLiu+LzkrMcSjnlZ2Aa/Du8vrBvWfNh5Vk92V3KsoSX5pH9DAntwfa6CYrqCn1vmzKqbs1DnMKg248af304VW0PPxHtale3746NO+nQxACIbGinAPTwiQSoFIL/X7IK2JsqMS7h4K24QMNncRKcCZLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fUVNMkn9aK7hF5VfxUCgtTerLkD1DxfBri1KYMKAV1Y=;
 b=AWoP9xfZX8Zlc7OA8udvH7O1fBNfiF9iWu7FjrTPfHTNmmXlLT3cnTh0RT65teNOzfzmCO+J/K/Zu7rHaeeUZhqfjdK6i6VZpPFZRYUmAQF4kjBBgctHRgQfdMNbans6KkMSd1hPkCEbqLLjE3dnsT06FX1QtqH4fPtUZTmJNlDiD8SICHWhbzakNMjVRY84ZMXoIuKoCCEq3xDb3jbD7asmsiiUug3+wzL6x5K1Y45Blt7XJ1uLhNCKYtm/Q/AT2CaO3sBPnESQVTR2pHXVLosdqgsZSANGTOA3HER8jmIwA/YtWG1UcMBEGxYD/3a24p0WrWdk6pIlk0ZeBPBI2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUVNMkn9aK7hF5VfxUCgtTerLkD1DxfBri1KYMKAV1Y=;
 b=IH6Ew/0iXRUOV84rYZk1UB3EwVbZeYUOlsyggR1al0cDgiRnYDOZayZMsxIZ6p/bSjjYTmzezwOimfIssJbSEXFZlwMYc2nltZlg7sXz7J2hamFWA4uTq72xlRiLNljEcvtog88Ud3BCnpZZ/uGtDvVTicikLGru/wQV+1QXfruK+UU0fp3iQSUbkq1AwRsHnrm99YaWmgcY527ue7WNg3/e/YprjyW4GZlKkU15gMe1X7GaWBT/LH5VCTaKmd8BdA0+4UrWA9v8KzsWWW9Tl7mj4dRqnmPUKPc4yUHwFnEjnXLKXxsZqX7hGnXgFJJNMlCt0lo0MxIRWkW8DnqYyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAWPR04MB9837.eurprd04.prod.outlook.com (2603:10a6:102:385::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Tue, 24 Jun
 2025 18:12:45 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8880.015; Tue, 24 Jun 2025
 18:12:45 +0000
Date: Tue, 24 Jun 2025 14:12:41 -0400
From: Frank Li <Frank.li@nxp.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-pci@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v2 1/2] PCI: endpoint: Fix configfs group list head
 handling
Message-ID: <aFrqmaV/wwx4X8/7@lizhi-Precision-Tower-5810>
References: <20250624081949.289664-1-dlemoal@kernel.org>
 <20250624081949.289664-2-dlemoal@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624081949.289664-2-dlemoal@kernel.org>
X-ClientProxiedBy: AS4PR09CA0029.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAWPR04MB9837:EE_
X-MS-Office365-Filtering-Correlation-Id: 271e5eac-77ea-450f-ef84-08ddb34ab7df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?82Ir5QZItAXKGalMJ2nlUorDrJ8XZyKMDiVZzsc0PXhdgCXu6nfCMWt82eTt?=
 =?us-ascii?Q?OoaVaQG4RoW7NT2gj16IpFqGgd3T9Jyi9cFv5OKVaS9Q9ExteJ9c1vuVYWMi?=
 =?us-ascii?Q?qRyIakDd87GdFCB2CDbPf714SY7OrY8klPqRaZlX5HNyP+5nmV/386nPa2K9?=
 =?us-ascii?Q?P1B9uaskfQW8DjEtzfyH62A2IClfa88tr11B5rKl1j43qnl3HsrVnKY3zs7M?=
 =?us-ascii?Q?GMektr8oTWuI3HVLg8NF6L8y386n/CHxDH4r0vCxJmcym+WcveNIRtRzc55E?=
 =?us-ascii?Q?oe4AvqHqAOMMQ87d2UZXAt11IEC8CUB4J0qBu8bJ+ipsMg0U3poaecTCp+Ys?=
 =?us-ascii?Q?SHPvcHa5Ac35MTCmOHltrhBjIxyrkNeS2a7z2r9Bf15EbKh//o8j8r9mjjzi?=
 =?us-ascii?Q?0eBhR84OBV+MGGwNhyyFuosPzrK9Cao1dJvnQwbsteV4+dtlyLTu5Nb3HTu4?=
 =?us-ascii?Q?2cTEJEbVHQ984zi0V0njQQ8quTmNkbkMpQVPJ2DoqAWMtqIZympB3iEbFJTq?=
 =?us-ascii?Q?eyeOaKBX88jtgswS+kWB9uZxKvKKmtci5qLkm0T28+opVP7xxFj45Y+TUiqH?=
 =?us-ascii?Q?oP2axCTHCeuuFmz6fDyfC2+jRNmvVrnJWWO4ldiL33o7MH7I0pvNKwaCvDzx?=
 =?us-ascii?Q?dctZGx7DhxxlHwS1vveOe6eU5F/smrVQEG53oLDyO3maIz18Gn+IaWybrxHi?=
 =?us-ascii?Q?VCS6tc77gpWXIbCJpgEfYRPgdMYLK7llXcenI0FH2L+qU70aULp4ohkK+d4n?=
 =?us-ascii?Q?+UCPNn0syLBuyAp0/OI8/ovZvFC75yskQGmr5HuUX6WXSDOqrppvhdcc8kSt?=
 =?us-ascii?Q?n2CfDjUG41Qf9p8k7ZsQZNtEjZUz32LaGpmc9uF/3KDlW/BJCmsakhdYxT1B?=
 =?us-ascii?Q?vCiqZfJRf3/KqvjLhzS1FBUPZE0s7IGfR1XQruOYAAzx0q0Dz7eN/MecaElC?=
 =?us-ascii?Q?Y/9STYzNSOyc6w0KV6h/1Wkn6yXSWQX37pnMCxDxigdEdMHVLHwY3wc4wVF1?=
 =?us-ascii?Q?MRLfhVqoK0uP7Ju6NJenmHC5HQ/FGEMVU9lnM2tODS0N9SCVAl0aNe2UtG9q?=
 =?us-ascii?Q?UKkLxfz+zg0K8cxuT4s5zHsw7YUHYrdID6fT5TXK3bD/NyAn22nrRZQVoe0q?=
 =?us-ascii?Q?Qv6lm5ZCNAhpjWsMm2bDkluDOrnLjOha1aiBNTC8X4Hr1ySIoHCF21AByejD?=
 =?us-ascii?Q?eD11EOpofN5J2tEOH2I6GjkDm7/t+oG66eSR6xNfIWy2X3IQMDFEWXekrh30?=
 =?us-ascii?Q?q9iuDnf6sKXdjIYhsjVF+qMwK+C166wNUD/uVqmN1WCoJTzlV67qS4VA1Fuw?=
 =?us-ascii?Q?oCo5naBl4vPzeN2u8nOuKh56XM429volwaDPizZXON63BFOEHU79aDI2nX86?=
 =?us-ascii?Q?z9D+j/2z2LUI++cIJ0+KMQlEuv0mxOFXrzxN2rdhzG6hP4+beqD9udyOL+R/?=
 =?us-ascii?Q?wWwmpV9H9g1Y23nRjWKUHUGhnJQyqq3q8vQHAQdIIoeR/IeiqGi4mQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RvTWPxf1ENxd++wSdzVmggqEu31FF2BUs7bNqmpTraZGtCIaq2OLQ0tkk7i9?=
 =?us-ascii?Q?2ZqtivrGhjjpFG6yYQJFynGlskqObmxw7tlxtZblSY37Rj+yMd0LV5xdxom6?=
 =?us-ascii?Q?0uUjhLLKrXLBg3cbGEWAVaC3ySxs7dqkjeYCAyInVJTdQQgHcNFKPomRhWWF?=
 =?us-ascii?Q?LxofS4lFgxaVCIps91eDAvW/9+0QZn6OmBSn4lvV30f42ZTd2fFiL4+ZANTh?=
 =?us-ascii?Q?G6FgCzOABsFqqWa/QxDnjzuCLh2/YfoH6FZZyEb2+xD36leV/c0diNjv7kvS?=
 =?us-ascii?Q?jSvHNdUVFU7ExrA8td12b5xAJM9Q3e61ufTFNv/9SKgI9M/lzN8Nxlsp700U?=
 =?us-ascii?Q?Kb2lZLdza0dMXxXhF9oJjERmVJqaILbNG+7SZEOvChE2TybcMBu3jkPvHeYR?=
 =?us-ascii?Q?AaK/dp87Fdrn3WNwbImF894L46B4vbEY8S77MrDzffZfqQ1LpPRLMj9x3xOe?=
 =?us-ascii?Q?oXPcO/3hIS7tWMQcX6qpWcSHzzqXXbLOF6Dr9QWMOMdMCl3Gzgc5secXSLR/?=
 =?us-ascii?Q?+kBASr+A7PI/Rgcx50EbCiNz+NlhMHSgBsAyYzlRxWukIytrsiWiyepYIj6f?=
 =?us-ascii?Q?TxQFHUYsOssMVPKqzex2EFX7sDiNG5aGHzOCt3IdYPWO8oD9PyuWMdej8jfM?=
 =?us-ascii?Q?OEw08zNGUknN8kTOw99TrT1viYT7gk9NdfTu/w/KQf74D7L+puxNQWOViQvO?=
 =?us-ascii?Q?YFAGJY9xpG+GP4lFl4C8Dm9aaGZm0vGSglkz/AhHK73290fL63f2mRrLoAHD?=
 =?us-ascii?Q?kWRIJ15NhidcO3gGt431OvnkidxwxFXKaIuGTTH7zs0YtCUfeThVzqYhJ256?=
 =?us-ascii?Q?Wy3MoaK3I+1AlU2s0qJL9HHRUfrSWzprlXWzCkZZIOD+hrG9Xq1A+/IAaXfT?=
 =?us-ascii?Q?r9M9QmOIf46ZWG3Y/dLNaj1EtFy/7qJGXxV+GWzdt0FZSxXHVx+entaBusOc?=
 =?us-ascii?Q?4rU/MnVcT2ZEx1yJv/vab6XQGSYq4izfozNSLcsLJIZk0sgwi0/TpYi5CdnE?=
 =?us-ascii?Q?2QWMFNznWtixiJ/wIFBVSELptCraBo2acNK2p7mFM9er4XNaGsT9KUHVjbtb?=
 =?us-ascii?Q?PCtpjwude7mSUlWuxu2LUbQ+LnWDaP9nT3OQwUe+YkerazqGv6reANY1SsqH?=
 =?us-ascii?Q?clD8f/NQlsvAmL6puwenX1fZIMRWBqeAUtWPV3cz9qa7TBIZXp9A2HQCf/Zf?=
 =?us-ascii?Q?caPybWd4Lk14c1MwptsyugBEtE6TaHIT2appqm6JKF430obspoHhfWL9Bj1n?=
 =?us-ascii?Q?8artLANqhwMuxddCluEa/wyldVO0974wSBo3QzXzdkQQtRA8lpd6SUPkqR4s?=
 =?us-ascii?Q?8y2sFF5on1w1+DLMas+sZgC++NVwi+PpNiVYCoNFGnN2Dr/0h6spIaSa8BMa?=
 =?us-ascii?Q?Vvt6S8h/JzLnSidrVjIccz8FAO5x6/L1jVVIdKayl4+6dWNW5nqBqGnsWoju?=
 =?us-ascii?Q?UoyXuk6kNbKTWvX0EJbZ6gmmK98b73p7I4XyXN379ac4JG3RBtZdm7yyDykM?=
 =?us-ascii?Q?QtJilmlf1C6Zi62I++pjGuhb4qAv0Z9vhGgL1QllePMommSbAx5Ol0p9SqRC?=
 =?us-ascii?Q?md3pKvhfkpYqaRvMDP4WpdwfEiJo4JLHa+xdgxu6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 271e5eac-77ea-450f-ef84-08ddb34ab7df
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 18:12:45.2260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aLE9kZklgcIRuCzy+xReJlybKeWmIPJU/ALD0eEWeIs9Ktawm0mlZHnoxuk3+97j4YMg/OCzkxuvvyUTv0oQSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9837

On Tue, Jun 24, 2025 at 05:19:48PM +0900, Damien Le Moal wrote:
> Doing a list_del() on the epf_group field of struct pci_epf_driver in
> pci_epf_remove_cfs() is not correct as this field is a list head, not
> a list entry. This list_del() call triggers a KASAN warning when an
> endpoint function driver which has a configfs attribute group is torn
> down:
>
> ==================================================================
> BUG: KASAN: slab-use-after-free in pci_epf_remove_cfs+0x17c/0x198
> Write of size 8 at addr ffff00010f4a0d80 by task rmmod/319
>
> CPU: 3 UID: 0 PID: 319 Comm: rmmod Not tainted 6.16.0-rc2 #1 NONE
> Hardware name: Radxa ROCK 5B (DT)
> Call trace:
> show_stack+0x2c/0x84 (C)
> dump_stack_lvl+0x70/0x98
> print_report+0x17c/0x538
> kasan_report+0xb8/0x190
> __asan_report_store8_noabort+0x20/0x2c
> pci_epf_remove_cfs+0x17c/0x198
> pci_epf_unregister_driver+0x18/0x30
> nvmet_pci_epf_cleanup_module+0x24/0x30 [nvmet_pci_epf]
> __arm64_sys_delete_module+0x264/0x424
> invoke_syscall+0x70/0x260
> el0_svc_common.constprop.0+0xac/0x230
> do_el0_svc+0x40/0x58
> el0_svc+0x48/0xdc
> el0t_64_sync_handler+0x10c/0x138
> el0t_64_sync+0x198/0x19c
> ...
>
> Remove this incorrect list_del() call from pci_epf_remove_cfs().
>
> Fixes: ef1433f717a2 ("PCI: endpoint: Create configfs entry for each pci_epf_device_id table entry")
> Cc: stable@vger.kernel.org
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/endpoint/pci-epf-core.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> index 577a9e490115..defc6aecfdef 100644
> --- a/drivers/pci/endpoint/pci-epf-core.c
> +++ b/drivers/pci/endpoint/pci-epf-core.c
> @@ -338,7 +338,6 @@ static void pci_epf_remove_cfs(struct pci_epf_driver *driver)
>  	mutex_lock(&pci_epf_mutex);
>  	list_for_each_entry_safe(group, tmp, &driver->epf_group, group_entry)
>  		pci_ep_cfs_remove_epf_group(group);
> -	list_del(&driver->epf_group);
>  	mutex_unlock(&pci_epf_mutex);
>  }
>
> --
> 2.49.0
>

