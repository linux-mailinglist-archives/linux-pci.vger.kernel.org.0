Return-Path: <linux-pci+bounces-39086-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E4DBFF7E9
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 09:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6C1BE35634D
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 07:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98B32D63E2;
	Thu, 23 Oct 2025 07:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Noypwj+/"
X-Original-To: linux-pci@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010051.outbound.protection.outlook.com [52.101.228.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FFC2C11D6;
	Thu, 23 Oct 2025 07:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203894; cv=fail; b=lkTiqPpaS8tZE1SRZ9GiF3G1ZSGLzhLgGMJa08XAOXRiDeOvgkiW2D+pFV4OrxhZmc80oB3E4LHhvIfdPURsLnYSEBXATtfB914vMpDn03rRiTpg7EszhL1L7m9Kw5T5WyFhd5YvxNx1499DYyDBoIgwUfWdc7oI0+Wb28qSlrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203894; c=relaxed/simple;
	bh=iu+hNJUTbDQc4TV3NTF41UAqmH1y7aV4oGLrUD9JQ4U=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=TLQZGupXyxv8XWYxHPvcooowOCheGkg6GxJk2Jvr7FTavmu8jYQIdp1fimkWzttzFgD3HO0DXuLiw6TEMyO8GDXb++qltbCy8nYd3ubpX4lHWSn8plwWVUXsEXimTuhVXlMZ5uI6CCS+vjB74h22lbcZKA44w6oitBjBj/urqqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Noypwj+/; arc=fail smtp.client-ip=52.101.228.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aS7ke5+W+5OHlD+IILpPjiqWrDnj7974KngBMIEARKZ+qIXD7R0CgGQVP1fazwQ/RJnV7mIbhUQ76Wsate53Q/Z1G6jU/fgpEZUgpkTuV+ARSYHByX7e5LT+xl9jThvvpd4S+c6R/NRuKwEnaikAM+eDOXCCR2tfOg/VFjrcXh8Qssu8Gm9n2VsD2Yha32j7hNDVOPNMJRlycJwIcHTWDP+w+Nd4dHKPx56Ogh9a6666a19MfTCwoqxY1+1jMoVD3+Zgec1AE93F8ZJJfPhGpZeCnF+OXEvemlgmQ944azaT9rRr9Bu2iwkSXYInXxkV+F8ISsCSOwpljtX/8TNa+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=55w74kw+17yZTCLnXHer7LAFH08XZa0X1L5kUpqNqWE=;
 b=sMC/+tIwpr+fA0QgdLG/e1cASRM8v0u1qo89qnTyj1A4kPqNrF0SouLsGEpSYmqNdcasrks3mrG8KBx/kXOuXx7+O/JcVvOH9G4HgbtuOJ8G1eGl2AjXYW6kxy1Xo66MuRIVG5Bjka2ONBS4SzfmrUkLgXF5t40Zwrerrmj5KZ7Hf8KypEgga2fIZE6/EanteAYpgMtGKJ1Q+Ww0gJDGtCSCS0arKLko+RfD7HQ0sBRXmtR5Gd7qkRgKD+Zk6JBz27IrE5wkXxe1EuG1gTzezV7+1hOXzBne0V5a04JpPk32F7nKDNshuqeOqJyrtJ16m+pjHH6mVJSMzBiB62Ww2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=55w74kw+17yZTCLnXHer7LAFH08XZa0X1L5kUpqNqWE=;
 b=Noypwj+/IzPBtw5+7YKETir8eDBPsfBlbXcFIvZ5aH1TZ0jmvy6oyqqpK5EAYyQ4k88ZdTRxGAqXVjWa0/mrtQzz1xtEG8WIcx3/1wNBd7kvY+NsABqsPa+XszrvwlgJ6mUqUR7/Cm/jzJNOZ2C26r/5tq772ovbDZTPp0cnQ4A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:10d::7)
 by TY7P286MB5387.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:1f3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 07:18:07 +0000
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a]) by OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a%5]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 07:18:06 +0000
From: Koichiro Den <den@valinux.co.jp>
To: ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	mani@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	jbrunet@baylibre.com,
	Frank.Li@nxp.com,
	lpieralisi@kernel.org,
	yebin10@huawei.com,
	geert+renesas@glider.be,
	arnd@arndb.de
Subject: [PATCH 0/6] PCI: endpoint/NTB: Harden vNTB resource management
Date: Thu, 23 Oct 2025 16:17:51 +0900
Message-ID: <20251023071757.901181-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0044.jpnprd01.prod.outlook.com
 (2603:1096:405:372::17) To OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:10d::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0979:EE_|TY7P286MB5387:EE_
X-MS-Office365-Filtering-Correlation-Id: abf9687c-739b-40b8-fd77-08de12044ff2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R33qGgJUcJl8Oi8f9EVGcpb+g2CXHYukLMLeLmC/EUR9aKDA7akT55OeSl6S?=
 =?us-ascii?Q?N1AwLOfzAK9wb5aMrZFdtXabyelQpxWZlHB7Mak2pBWxxCiSfBSLtWWA+QNj?=
 =?us-ascii?Q?I1EnEL5HIZxqIWrmLYR5uDeB8DkigXsQNYw4OKzWbL1+0iLEwtxqfLtTOk1R?=
 =?us-ascii?Q?prBYU9OFw697x3z5WjDwhiXfVPE7c5VEJec3GzCe2YSPJIlrxZckmZJ7MlW4?=
 =?us-ascii?Q?AQCNbXIkJ6tTOhCRV7fO2smrAkD4HZTsqio/NQsrcS7OVCjXXTw8DPQWNCAi?=
 =?us-ascii?Q?OvlQ9tcmiCBsiakJA1vBo8cZAYdwXIR4IVd46AfgRGARmoSNkzaXStSMZBMy?=
 =?us-ascii?Q?8y94GFvilQTBhnyrADnu41oqNAK2/SkFSglYAboPEodiH4Y32zlID09KmaOu?=
 =?us-ascii?Q?tIe9Mx0vM0kAnN+WXmTX4xAw3qmH2saVd50OeaNBHkJL/u2k2AhJ8aynbS2j?=
 =?us-ascii?Q?uhx8eQC5MgSybV/sAshX5HOvJ4R23Do3lCWGqts2Zr+kq8zyM11BeZYJoqMn?=
 =?us-ascii?Q?y8HJw0IQH3vf4u9Mef6I89nuBIBkoR9HNaX6DqCEyOxJuihc8YfnyZarB8s3?=
 =?us-ascii?Q?5qqZJnHonboiN7TGeGColfD9nf4PYv+nox/LtTsCNM59HXfa0zNRuCHGXGj6?=
 =?us-ascii?Q?dScq8ASZJ2MalPmQha59xJHO8AF1YH8kanOjYLK8v2xuf3RLjHteYMZY+Gjg?=
 =?us-ascii?Q?KvAyBiruHJMqqydqjS+E69refrcTQmZBzqZuGSTlKZ/ATU/auuQujEejecVM?=
 =?us-ascii?Q?s5nJRlXR7xaN/SEP7Lz7dDE+SIn0thdlBH6KPzjm/uxFXBm8UFI7kMiZny6t?=
 =?us-ascii?Q?fDG8ouD4yF4ZkeDOl6POI3u9r+OL2Pa6W1XvbZlfiXxvd4HeeGbE+Zk8Rrnk?=
 =?us-ascii?Q?DSdquLyKOQ4YZaXCBNGOLWUL55DR8i3UWk+D3SBB7WyZo6as5MgAkO91KtK3?=
 =?us-ascii?Q?AZ48Yf7cpJnqRKcwESQStmAx5kOgS7OG/CnC+ylvbkyGiM7cMIn9C177EsL/?=
 =?us-ascii?Q?mWPAkEIkbbnLeH15aQpb5OEZ4Lcat11rBBAmZ9BWfwwZ0CYTWZn9nUWznYef?=
 =?us-ascii?Q?hUTDlubaEm/F+9LiO6389NUMpy69HxuYP9nDKqYe8Yqo0MNglUdcoRJ1KAOZ?=
 =?us-ascii?Q?sW80V9kOeuvJRapAa5X9PwLjl2uJfgDOiaZsUvW+9syxMYbXRq2MLjJKD5Nl?=
 =?us-ascii?Q?7Agv9IfAreaif6mvz+ck8dRrNeS2W1YxA3AWQnbCUGNySVCc3EVO+51t9Mrj?=
 =?us-ascii?Q?mUs62p79GC4sBXczMOM5pjtHj/OtOqTSqdMS+nuMXg49IRcCnoNH0RH8tY7H?=
 =?us-ascii?Q?nVq8hWBIqQTWQKyzoLpmpqgYOcH+P7P6C7In3TibfGNpdmUw/q3buUbDapm3?=
 =?us-ascii?Q?4jp1Td/6CMuE18FVWpy1Wjfyjxi+ggFD8Dd8YtQzaQt+Rzv+a1c465DjN52e?=
 =?us-ascii?Q?InTbPrDgjxgp0SMxk+9BFIcZsezDNFf0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v1x+zfeLlyheZc8Ml5DOijld/SNzCpXrVwa02PjszgiiMVA/G+fTvrFYOsfh?=
 =?us-ascii?Q?SfULKZRLWHsNbhJvq0RG7m091NFyLzFw74JYaWRARXXeh+7l96HdzLGUUU3Q?=
 =?us-ascii?Q?pBlYLHSWy2IqKm7dUZk2vW/naXKK2AguKivQpoENFG3OjlrtG2MhCqkX6Wfx?=
 =?us-ascii?Q?yrlGrbLdYcj6GoXhuufVNRpI6TW0XGYN4X+Dd4z6EJPUH0VHFXdB/ZLZWRSb?=
 =?us-ascii?Q?vq6AHJxp4SfT1i/sTLqhANU78gz6xxbENK45SbdnjEb25pk13U+eQo6mBq6I?=
 =?us-ascii?Q?yKlbRo/1vsRNm00PT6aGeNLvbEVeGdXi14EBg26XEfQcBp26XoM6Pr/mgeN4?=
 =?us-ascii?Q?hcvjHbWmQmIHmdFzZPfpXXhdt2ifBz80mO/WOPb/HCNQh3Mzl6JBdEV2LXpf?=
 =?us-ascii?Q?YM7LISjjNshr+NrNPKf56Twj0KPrt2S7RCQGeBS0rTPyiCyc7FF1Cu2Xi9EN?=
 =?us-ascii?Q?Me+p20DxfmiUeUf/khvYq9NDoH+e9vkvPY/wRP+BWcRcM+DlhATOsV/3n/6+?=
 =?us-ascii?Q?BKtyit65vH253JPeD++xy9MRIvpNjMPJsd5al3YoOa6A/iUw6IEsCzZy0lCJ?=
 =?us-ascii?Q?idmd+cCzdZW5zzzeyo2lo0qqFT74eOpBPAaHams5DTtZFH0nqeHiSGDMjQPj?=
 =?us-ascii?Q?FMsRlJjQgynvStcj0qmWKeoK7UO+PNh6Pkj3odPCpXjU+7nt59MoxtvhXYJI?=
 =?us-ascii?Q?7js/v5jCvyXfdVKquFzsQT2az5gF1K5kRH6nDyxv6q+nAYXM5SE6L33clzu+?=
 =?us-ascii?Q?LUTiQ3oU7ZxMdgoXD5iM7s6xIDsXa3CxauE3RDw2ig8mMg+YJuoap/ZI9q0I?=
 =?us-ascii?Q?/cFxD91U6qy2ICqT2JtWN624GHgN7HLdGhsxVGEKgqTN3bab1r0I+yZav9hN?=
 =?us-ascii?Q?tTmqV1Yeab592zguBAuyhUvsdc7aTzgEENgpU4BrtHDjcTAWRj1GRFJtoozc?=
 =?us-ascii?Q?24yMkQL0xn0CddV2+b/JoeXLJn8blPYYAXOJL/D44dDCGbG9A7Qxmeb2D3F9?=
 =?us-ascii?Q?G/8SA6xz/jCPlo8C2cSZxsj5rMABYCCKqR6tgOs4DEPPhXp5JFqT9nAy6Kdi?=
 =?us-ascii?Q?iRktz37ntICdvAvL09lpsAihOZN3c8DnWCrKhMwfk9T0Z0KYLcvwoiw9VhU6?=
 =?us-ascii?Q?OqpmdXs2E/HYeGZNoQf4ss3Wtm0I6Xf/XOFWrhHsOHGAok1v499cvy8qD+Uv?=
 =?us-ascii?Q?HB5SnIElCVUoXDcEofK2AmgJCQGmS2t/JfBLk333K1tUVB/dH5OuKMzx8e0H?=
 =?us-ascii?Q?C8uuXN47Sm1LFh/iQTX3JVBXASyjhOz+1rB5eOz4QMSk+CPEvN1eGaELdCi/?=
 =?us-ascii?Q?AMTSbNT3LVZu0wZcsGPJcVqkLZWlAtEBZx652UGq0wpkGVBnrT7xiZjnYntl?=
 =?us-ascii?Q?meyBZ72ZZD4d8ucGKWNBWq/aw0qN34CvfiaFnAtu55Stmpgvj9EWGnYdApeo?=
 =?us-ascii?Q?TPkDDylMDDEs38FDF+YSb44hfVPZYLFmbHT+ctxTKgebIUQvWaQG333e2gU4?=
 =?us-ascii?Q?e7M0IsQ8jG/JmImhMGR7JOYW6+2r6g+oivtxtWxpC0qHIaQzXlZJ/VJ8ZRSt?=
 =?us-ascii?Q?AY7HJiwd1nx2KK2XAVrrgda94UxcKaEOmnjgkFqkg8I45cFMH1dKMZiXBZ3a?=
 =?us-ascii?Q?/E0ysSmbMhV8/lDdQmJjH8I=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: abf9687c-739b-40b8-fd77-08de12044ff2
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 07:18:06.8258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GeHOjhFdWteZfDqC9s/+GEloMoti0se5wNMhwrAiAKf2g4SO36D9ru7j7LFgYKFuqllFs74l7I17MR9+5V7uOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB5387

The vNTB endpoint function (pci-epf-vntb) can be configured and reconfigured
through configfs (link/unlink functions, start/stop the controller, update
parameters). In practice, several pitfalls present: double-unmapping when two
windows share a BAR, wrong parameter order in .drop_link leading to wrong
object lookups, duplicate EPC teardown that leads to oopses, a work item
running after resources were torn down, and inability to re-link/restart
fundamentally because ntb_dev was embedded and the vPCI bus teardown was
incomplete.

This series addresses those issues and hardens resource management across NTB
EPF and PCI EP core:

- Avoid double iounmap when PEER_SPAD and CONFIG share the same BAR.
- Fix configfs .drop_link parameter order so the correct groups are used during
  unlink.
- Remove duplicate EPC resource teardown in both pci-epf-vntb and pci-epf-ntb,
  avoiding crashes on .allow_link failures and during .drop_link.
- Stop the delayed cmd_handler work before clearing BARs/doorbells.
- Manage ntb_dev as a devm-managed allocation and implement .remove() in the
  vNTB PCI driver. Switch to pci_scan_root_bus().

With these changes, the controller can now be stopped, a function unlinked,
configfs settings updated, and the controller re-linked and restarted
without rebooting the endpoint, as long as the underlying pci_epc_ops
.stop() is non-destructive and .start() restores normal operation.

Patches 1-5 carry Fixes tags and are candidates for stable. Patch 6 is a
behavioral improvement that completes lifetime management for relink/restart
scenarios.


Koichiro Den (6):
  NTB: epf: Avoid pci_iounmap() with offset when PEER_SPAD and CONFIG
    share BAR
  PCI: endpoint: Fix parameter order for .drop_link
  PCI: endpoint: pci-epf-vntb: Remove duplicate resource teardown
  PCI: endpoint: pci-epf-ntb: Remove duplicate resource teardown
  NTB: epf: vntb: Stop cmd_andler work in epf_ntb_epc_cleanup
  PCI: endpoint: pci-epf-vntb: Manage ntb_dev lifetime and fix vpci bus
    teardown

 drivers/ntb/hw/epf/ntb_hw_epf.c               |  3 +-
 drivers/pci/endpoint/functions/pci-epf-ntb.c  | 56 +-----------
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 86 ++++++++++++-------
 drivers/pci/endpoint/pci-ep-cfs.c             |  8 +-
 4 files changed, 62 insertions(+), 91 deletions(-)

-- 
2.48.1


