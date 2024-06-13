Return-Path: <linux-pci+bounces-8701-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2D5906385
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 07:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B3C31C21774
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 05:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CABF134414;
	Thu, 13 Jun 2024 05:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rU2U5Peu"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8BA44C86;
	Thu, 13 Jun 2024 05:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718257366; cv=fail; b=gsT4SwtGX0pIzL0wbnZoUaDRndHNZOJjKjrhkoREJn6MVQ/Q943SlWgFGEcjdFonEfsl74VcNQnkhIw78GcS0zw8lSW7fZhTaLoPA7yZG3GIGm9MMXpKBcXF8G/tWKDzWHsHN195SXBthQupBdtNeFKgQxRAk5JdI69belV5DDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718257366; c=relaxed/simple;
	bh=KR/rsYXcHWGeiFaXFNUZrhKN5ia0KhnrU9NhZb1Vnt4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m1t7I6/RrxIMCjy0hC07s7g+4ysk8MSRDfYAzNcat8UVrucddi0sCIUpbzpehrn87DNPCEHhzEcel+ymBe+1UxBLUsUOkU6CfaXJTyZcp+LqTzzZJVk9othZ48KzxtrYJ6M6quXQBoWTiQGSidW3UKgaUtlIAnqVtch1l/9bU6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rU2U5Peu; arc=fail smtp.client-ip=40.107.223.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OB7OmYI1teMk4+UpsjmtOLJLot867OuIKWzvQsUDCIb9NIO4jSzi3u7zBUgHOrcUGzs9FTnFFS9p5xTYIpqqgNdR2RP7LuJuJKtEDhN6l5lvXyP+DdkRkoK+cqV+g4DkuE5BHRLRmSdAXZmM4ZdmM6pTj7sW4Mb1KkLJwrLYpXAtmI7iTSBnintJYvuUBEM8QvDA7CNkDZo2AVNU227wlwRqK++ZWJTg7MkGDLVuG3rsfk0+3COgh45jtpY3re1Cgl102oHRmY6LvoSO3XbICxIz385bwaC6AUtYAxU43ItYfO1STlJeOqsmqKu0bLjmPZOx38JpPLz0XOPzP22d5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PAq2PJtkFW5xGDWEr6Rg7FxgRenDlGfbXWPfGIp5+8E=;
 b=PGSmLYIsxfmEi3i96NIrSe4s3QEvEK6QL/bSmPxku8uUMzvGLLBmnvKOXx/1gRBbbAbNkdhBQ26O+edhTkuzZzz5omDfT3ioaNns/i9IriGmFTUMJ/fEQLwtrOW8lSxXjhcmb2G3DdQjfirgG0HnEu70ZHiFel2WmgHQxKfD2abfSJdzgoIMGUUTlIiTQ0ACeQJu7TISTL75rA3zrBtraVQOyWiZNxGAiJZId1qy33EHk6HHLUh18gz8ggabcZbj8BzZimwATCI9bx+8ohUJw4ZmDf27g1O/0Ju/9feuXhM6UvbviviMJiIE6pBAQImMMRjpj6rLtk/BnWAlUfzBUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PAq2PJtkFW5xGDWEr6Rg7FxgRenDlGfbXWPfGIp5+8E=;
 b=rU2U5Peu/RjzGkqUas3eUdhPvbMppTr2Ww8HPR48aez6qVaxtCqVrXOpJi/IQzBYAmZ8mdq6fbptDE6KVqyVXqxgQ3scYijsEyVXtKhPEP3eRvHK4Wo08von6fAI5uYm4rIFxtlnuKL4ky8k7GDZdyVadn5qsKOCQxmBM2YGUFY=
Received: from PH7PR03CA0018.namprd03.prod.outlook.com (2603:10b6:510:339::15)
 by DM4PR12MB5865.namprd12.prod.outlook.com (2603:10b6:8:64::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Thu, 13 Jun
 2024 05:42:43 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:510:339:cafe::f0) by PH7PR03CA0018.outlook.office365.com
 (2603:10b6:510:339::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.21 via Frontend
 Transport; Thu, 13 Jun 2024 05:42:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 13 Jun 2024 05:42:42 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Jun
 2024 00:42:40 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Mathias Nyman
	<mathias.nyman@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>, "open list:USB XHCI DRIVER"
	<linux-usb@vger.kernel.org>, Daniel Drake <drake@endlessos.org>, Gary Li
	<Gary.Li@amd.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH 0/4] Verify devices transition from D3cold to D0
Date: Thu, 13 Jun 2024 00:42:00 -0500
Message-ID: <20240613054204.5850-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|DM4PR12MB5865:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a94e754-7b84-4878-dd98-08dc8b6ba519
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230034|376008|1800799018|82310400020|36860700007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jWeFbJtlOCj7691paLmIA9oV8tQcwI+ou+Xhsbp5W5ORHoCNkIA0FsmecaZY?=
 =?us-ascii?Q?aASId4nTf1R/C42NAr7y0iZh/0SNIyTuuz+xQ82pu6/IaaWMKt/7g4GlkAZK?=
 =?us-ascii?Q?eTKTpRpqtycXbY5pkZthLfbZzu6S2eX4oruvBba5SIkixQ+Jk7lJrqiKHbcg?=
 =?us-ascii?Q?YNFkD0XQisPRmh+MJflg7cwypwBhJHxFDoQdR4Reh28FE6bcIXM08/lNf51R?=
 =?us-ascii?Q?3vVMFza2YPSqBgBDAcvi9J+a6/RawKMbUR4tBduoSS4E7QRPMXf1DzkfktOv?=
 =?us-ascii?Q?hxvDc7+J3YDfmhTB3Ua7HM7S9jvi1T682gt0IsXY1D2QnsqNbAcIBEqu6MBS?=
 =?us-ascii?Q?vO3dal+epNUrfKMD8bK9f3QGJce0BX0zXr+ZCCHXj20nvEHE4j8r1kOJe7Cv?=
 =?us-ascii?Q?ynLofWfLM6h6H00da4cqLFCd+/GyzTMd5tnnmaJAdPHeES20iWKk7hid/7I6?=
 =?us-ascii?Q?4zyMocMccWjFVmW54DgSOk101qfzJ4gdzTLIxtKfW87FtnsN3g3lWmFTCyMq?=
 =?us-ascii?Q?8rJvb9Du5Kz0wVIzKYKKU+AOmzPjgkgA8kJp297TCTYuXHhhtBe1a452tttp?=
 =?us-ascii?Q?g+en1fpWoDr7pM1K4+2JQC7Dm0LvahFuv9agRrGvWdXJtXuV79ruH0u5SItM?=
 =?us-ascii?Q?OiduX3gqbKo28i7xciGvfLjfv6QWnaP7DVGpjEozf0/CJGel6mBNiAiTIAOE?=
 =?us-ascii?Q?r1kmt6cGra7V+Hg4jL6zIN8652xWnybD830SvxSBpw4AhYKUpRT9vfhSEDXR?=
 =?us-ascii?Q?XgDN3YElmVS7brRQk6JJYnxlTo2gZgksqmkt7IIeYcTYbECGJkmCds7/d58k?=
 =?us-ascii?Q?kNDSDGCk/CqBtJS+unYPvZVCS42hh1Ah4wAjU3V5bHVnhzF+njKX0fXUCK6M?=
 =?us-ascii?Q?cOZkq4ssScxSqcEkOGS6ND0wAbFfKy6Fi3PZ4Bgbe0mBb6r0fGNrSGUtv1OR?=
 =?us-ascii?Q?OaHqOpmULfbJrjbpZlXoX+58k6amh20IyU2mX7uyMA2OqaruD5NIGUVT+wI6?=
 =?us-ascii?Q?Ydj4jmrNr8zOJM2ZvWMaxJWM0HI5YVheTHT6UsU1LJqp312Bu7VcCQ/NRgtE?=
 =?us-ascii?Q?EScMfgSiMwc/AJ8e1WTF9MqmYrxYjoN4l8ozrLl0LvpHZltdIjsFudgnuw/F?=
 =?us-ascii?Q?v/tkDWN2tsa0wa0TcMMpiYtbVTkEkEZQq64WXfKUxYGeVZ3uP+ji7kkcxcqZ?=
 =?us-ascii?Q?1JIQOx5RQMAVEbWacfQApjUrUoXXi2rfhhWEHXkEzaUInty1KLW1rso5m6k3?=
 =?us-ascii?Q?FQ7mJ6cTmzeTEhZUJ2BBAZbb1sT0RYwzUEtEuYdlu9k0q/0I+fb9P/laL4id?=
 =?us-ascii?Q?Whf17zFeIl1HChlpktiEJKu31JTTGBhQjcX5pY7AsGr9oBLUYXqXTfKz7KYM?=
 =?us-ascii?Q?opa6Gth+iYxs1lWNAaP8k48djdEo0o/iS53YSs2g4E+lG8EaNA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230034)(376008)(1800799018)(82310400020)(36860700007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 05:42:42.4340
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a94e754-7b84-4878-dd98-08dc8b6ba519
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5865

Gary has reported that when a dock is plugged into a system at the same
time the autosuspend delay has tripped that the USB4 stack malfunctions.

Messages show up like this:

```
thunderbolt 0000:e5:00.6: ring_interrupt_active: interrupt for TX ring 0 is already enabled
```

Furthermore the USB4 router is non-functional at this point.

Those messages happen because the device is still in D3cold at the time
that the PCI core handed control back to the USB4 connection manager
(thunderbolt).

The issue is that it takes time for a device to enter D3cold and do a
conventional reset, and then more time for it to exit D3cold.

This appears not to be a new problem; previously there were very similar
reports from Ryzen XHCI controllers.  Quirks were added for those.
Furthermore; adding extra logging it's apparent that other PCI devices
in the system can take more than 10ms to recover from D3cold as well.

This series add a wait into pci_power_up() specifically for D3cold exit and
then drops the quirks that were previously used for the Ryzen XHCI controllers.

Mario Limonciello (4):
  PCI: Check PCI_PM_CTRL instead of PCI_COMMAND in pci_dev_wait()
  PCI: Verify functions currently in D3cold have entered D0
  PCI: Allow Ryzen XHCI controllers into D3cold and drop delays
  PCI: Drop Radeon quirk for Macbook Pro 8.2

 drivers/pci/pci.c           | 21 ++++++++++++++++-----
 drivers/pci/quirks.c        | 25 -------------------------
 drivers/usb/host/xhci-pci.c | 11 -----------
 3 files changed, 16 insertions(+), 41 deletions(-)

-- 
2.43.0


