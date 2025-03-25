Return-Path: <linux-pci+bounces-24712-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44024A70D00
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 23:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4073189CCCA
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 22:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2E2269816;
	Tue, 25 Mar 2025 22:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gyDsKAvQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D083E1DEFD7;
	Tue, 25 Mar 2025 22:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742942316; cv=fail; b=DDEbhXpPC/VKIWPh95HZqMg1mAYXFSJtJw/YuC1im5NUcj+lCaUenL4oXkn2uD/ja+CH1fWXXEPylqSWEFtV//acAjEY8zMfXRDqJWvzgZU5V7axBQUXOHaeDDe8peEwx5mX5MX45836oIEGGeJuUBeLrk26JS6SHsA3yVxt0tA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742942316; c=relaxed/simple;
	bh=jIRfNwx93BIKX24euHDAhng4UZOnfb4YAcAxkXd/nuA=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HWumVfDXcY34lSLxgZ42ERBidDTNLyzuN1QyBfy6C+Pbzq0EP6P6GlGZjX61ONzwHRDWBAuDUnjORLZj7CFfouMzjq8+rYK0lasq09KIApkx0eANIeqHLCTb7IqdqnBrA98/LpbKBSeJ3NJ9qXCzy66eO4Do6I77+bJqjhgxYBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=fail (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gyDsKAvQ reason="signature verification failed"; arc=fail smtp.client-ip=40.107.223.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zzd6sr/w1Sy2oi1qlugpzLKYQngVA3SGD6Ei98qBi0Du4/ZS2ZIt5FKOExRdWLSRWsvDbwP9u7VbjaijZ2sIWuhE+5m2TiWP+HpkBhSUF2Sl68yqMj4huSQIXFNKPmVvk8zEAPjiOloTJeBDC0SJ+v/pEfH/vRuTZfhO3sf9i/tdD3OXyBWcscrcw4uhGjmdHweXfD7j8zu2GO3lG/WH9RoLsOeyjvRpQuRkQm3hfaJtJOr+g9r6aalqJaDrUleCxsQ8kPaSrCugwHgO4mSx+WZjdTLArLy/3EH2Ib653yIAVG4WnlEuWvF9EOHGyzazjoglA8mKGRoR87UXDsBs2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cFTknCwEj4lQMXPooqOdtKCPu0v1//MkRbjqh7V3orM=;
 b=vVY1GwAUDhncQT0lBMj+H8q1nS1JBxGMpz5D4JskSU3wsxn9kbg07Ta17BMKQEJJvpF/Ga+ApX7JI2LykjdOSGFJQE7CdHIMKlcsSK4tFHa7kjyvXuv7UZy+4hTH6SIZHdKiFKgHoT0MvWOC7OOl8HzigdD6NBDEDbKyEQth89pu5uIoxUTOqIHyYj+Z1blAOX3fm22bqKk87urBIVC4pL8DdAxyHNeKAT5jWuUg2D84GZfgTBjpqJkw5/n9MDy5adJ/Yp74t/BMbqBXTN/1PeZOkfEWWXhHw9vDh4CbMO65dzBKu0YZyVdXCsgALCqTXVWfC56es5WYHSwZKP3A3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFTknCwEj4lQMXPooqOdtKCPu0v1//MkRbjqh7V3orM=;
 b=gyDsKAvQJtm6v1Rx6/Fmqa5Z2/nJyWye5O+BlYRWRmsFxiox2dsEsSvQWWW+dw9QjlmXpEaswF1VBu9eym7qmZyq+Os2hCgARBjWQhOSwaZ5u1FP7L3jGaVrQyr8qxl84n2EQ7slWgsjEsM6/I7Ur9kL7uJAk6YuMXgmQIUO2kI=
Received: from MN2PR08CA0029.namprd08.prod.outlook.com (2603:10b6:208:239::34)
 by CH3PR12MB7666.namprd12.prod.outlook.com (2603:10b6:610:152::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 22:38:29 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:208:239:cafe::d5) by MN2PR08CA0029.outlook.office365.com
 (2603:10b6:208:239::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Tue,
 25 Mar 2025 22:38:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.2 via Frontend Transport; Tue, 25 Mar 2025 22:38:29 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Mar
 2025 17:38:28 -0500
Date: Tue, 25 Mar 2025 17:37:52 -0500
From: Michael Roth <michael.roth@amd.com>
To: "Aithal, Srikanth" <sraithal@amd.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bhelgaas@google.com>, <sfr@canb.auug.org.au>,
	<syzkaller-bugs@googlegroups.com>, <linux-next@vger.kernel.org>, "Roger Pau
 Monne" <roger.pau@citrix.com>, Juergen Gross <jgross@suse.com>
Subject: Re: [syzbot] [pci?] linux-next test error: general protection fault
 in msix_capability_init
Message-ID: <20250325223752.f5tjazbpbblgppyz@amd.com>
Reply-To: <423b87d8-2ae3-48af-b368-657f1fbab88d@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|CH3PR12MB7666:EE_
X-MS-Office365-Filtering-Correlation-Id: b3d4155a-5261-4047-9d49-08dd6bedc3da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?ckNW0UhqRgqyuTnhv7ZBIYnvQWXw6rZPSbBAkRkJrMJV5oepalMiS57PRT?=
 =?iso-8859-1?Q?dYU+9a7JewgGf3/rE6H2OaEdNB8a9r2zk9Ft241BbmIFvGo+eyeRS42JmZ?=
 =?iso-8859-1?Q?3zv6j0fLNGh68Pj8K/UCuGRymv4a8149FglPQz0FTNJ1TT9NAtKZRjVuWs?=
 =?iso-8859-1?Q?ribhEu1lTglw/cjutb7pHKZhQYplo0WBkILYKtggfMxCHOlLRCnc9TpErv?=
 =?iso-8859-1?Q?geThbsU80opz08iNtXO2XTItVgDZ1WQTWDfglQ0k24lvuI9RtE3zsgi9ik?=
 =?iso-8859-1?Q?eBE3+M5G5g7EIQjZW/O1bIPRk0+o4ITQDhy/um3IJZmL7qemxcAcUKVXRP?=
 =?iso-8859-1?Q?0agOeOLXOOohX5iUQLZUgmVsABlLc/fjFtcMUCcP0zWGpVe0it5a8CTWdr?=
 =?iso-8859-1?Q?Y4tEVwXc+cGG8rTnp3Bak7KiX1SAQW0kaQR6nCVXQUKcsGPHUHgbNM2aft?=
 =?iso-8859-1?Q?zGWykYNjCGqRinGC/ZkU72TN5Dn8g/HtwB4fBnEX3kqjnQNwBow0SK/R7O?=
 =?iso-8859-1?Q?gjn2a+j0vAZhAAOEbwetr3XzwYvKQGd+az/r8icdByW/Yt1zgQPrTpwbTE?=
 =?iso-8859-1?Q?33QnfI0SkhsDqncZd4KnjVcAVD6usVZU7fktITyW/soZRErc8BMUJu8yDm?=
 =?iso-8859-1?Q?IJsCohaIaGaZ9MIf0YY5SxtgNvxoJV6tG7vJRcMLuurDQOauyHMJduMFiR?=
 =?iso-8859-1?Q?dpTY8FJvUFmq7BOnvGRUjm+3+ysVaH56zsQmiPUKPXh3UgT/Qy4Wf0NU+F?=
 =?iso-8859-1?Q?FQF27Km6QrSIYmfkiBw6P2AfZGG1y71LzScquX8g+0Fgo6EXYuDyhHLNZU?=
 =?iso-8859-1?Q?fRWq38EV7H9EsUUxXIywj3vMlpfvH0uMVs9rNLFG1BEnFmQG75ngH6UgHm?=
 =?iso-8859-1?Q?M2SocIKbz9X6MtIzy5kYl1VmNa3cUZF3a/ikaTcL61u6DZ4mh7UD/RmQA0?=
 =?iso-8859-1?Q?JT2pavErnIKFbGZUm9+curAwxJVYwLLCNM9JrWjXHCul4q/6T0Z4MbYgEq?=
 =?iso-8859-1?Q?VArvUAcLG0r/trBf8W3qHgzSOVZ7kxwGF1rezOVpOVfW6KD+EaW+3CgBBY?=
 =?iso-8859-1?Q?RdWMh3fSdzQpFoJCbweD/bnoWmsVQ+YeaL+oFZVAsdsSWh55ZXu8Och0zH?=
 =?iso-8859-1?Q?QhYaEDe1HCBixNb005NJVNIvwYhRiNmMjz3SDQaJ0YjjRfte+KPYNln3w0?=
 =?iso-8859-1?Q?pv2kymdwdysbcE4AqetZ8Do329dh+8AgETk3WTc+vWuadSgp+ngAmbA+BT?=
 =?iso-8859-1?Q?97MfZxI7+H/o9dq3iI8+R5/Dw0fM4bvck2mENHhtReEXIetRcdJa2ySYkm?=
 =?iso-8859-1?Q?kVfLpQJeONt88JtyxO2fAWRAjQxLfkNBczvwQDQYsL2q06NdCGSQ9hHwIk?=
 =?iso-8859-1?Q?p98NTigo46pi25eqLQupQ0/qhvPJU1o1YfvW+I4PWPP4eA4IBNtYY7aZwF?=
 =?iso-8859-1?Q?0nuI8gSRj0bjMsqbHhBA4eW96fsNVIA2zXNOk0ZUqFxChE6r219SkKVFk3?=
 =?iso-8859-1?Q?GP2Nh2KRGrFoTgTfg+vlh/q18BZ6uMkz3hEqU0Al3GyOM0jOl2jzerp4oD?=
 =?iso-8859-1?Q?h7DzHxBs4aXtAUklpv/ryE6OPRmQ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 22:38:29.3304
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3d4155a-5261-4047-9d49-08dd6bedc3da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7666

Also able to reproduce this trace on every boot with a basic KVM guest on an
EPYC Milan system using next-20250325 for both host/guest.

A bisect of commits to drivers/pci/msi seems to indicate the following commit
is the source of the regression:

  commit d9f2164238d814d119e8c979a3579d1199e271bb
  Author: Roger Pau Monne <roger.pau@citrix.com>
  Date:   Wed Feb 19 10:20:57 2025 +0100
  
      PCI/MSI: Convert pci_msi_ignore_mask to per MSI domain flag
      
      Setting pci_msi_ignore_mask inhibits the toggling of the mask bit for both
      MSI and MSI-X entries globally, regardless of the IRQ chip they are using.
      Only Xen sets the pci_msi_ignore_mask when routing physical interrupts over
      event channels, to prevent PCI code from attempting to toggle the maskbit,
      as it's Xen that controls the bit.
      
      However, the pci_msi_ignore_mask being global will affect devices that use
      MSI interrupts but are not routing those interrupts over event channels
      (not using the Xen pIRQ chip).  One example is devices behind a VMD PCI
      bridge.  In that scenario the VMD bridge configures MSI(-X) using the
      normal IRQ chip (the pIRQ one in the Xen case), and devices behind the
      bridge configure the MSI entries using indexes into the VMD bridge MSI
      table.  The VMD bridge then demultiplexes such interrupts and delivers to
      the destination device(s).  Having pci_msi_ignore_mask set in that scenario
      prevents (un)masking of MSI entries for devices behind the VMD bridge.
      
      Move the signaling of no entry masking into the MSI domain flags, as that
      allows setting it on a per-domain basis.  Set it for the Xen MSI domain
      that uses the pIRQ chip, while leaving it unset for the rest of the
      cases.
      
      Remove pci_msi_ignore_mask at once, since it was only used by Xen code, and
      with Xen dropping usage the variable is unneeded.
      
      This fixes using devices behind a VMD bridge on Xen PV hardware domains.
      
      Albeit Devices behind a VMD bridge are not known to Xen, that doesn't mean
      Linux cannot use them.  By inhibiting the usage of
      VMD_FEAT_CAN_BYPASS_MSI_REMAP and the removal of the pci_msi_ignore_mask
      bodge devices behind a VMD bridge do work fine when use from a Linux Xen
      hardware domain.  That's the whole point of the series.
      
      Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
      Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
      Acked-by: Juergen Gross <jgross@suse.com>
      Acked-by: Bjorn Helgaas <bhelgaas@google.com>
      Message-ID: <20250219092059.90850-4-roger.pau@citrix.com>
      Signed-off-by: Juergen Gross <jgross@suse.com>

Thanks,

Mike

