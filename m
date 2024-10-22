Return-Path: <linux-pci+bounces-14981-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F36D69A995D
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 08:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64C2D1F21A10
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 06:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E92B16E886;
	Tue, 22 Oct 2024 06:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nIVNQD/p"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2079.outbound.protection.outlook.com [40.107.22.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD21F146A63;
	Tue, 22 Oct 2024 06:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729577307; cv=fail; b=aQoigechxo+4X5gAA5+WDiF3B/pVXaRDni72R6KKH49WGbSSFNrP/LWhWrcfnwJC9wZTgGo2g1RT5mKnSUodoQtbEa9epLBziLH6THtrREWG1rj+45FWA+tawhA+TO4Bf1hsLbv416RVBcGROQKIFuKIkepLQueUop2cqkIImj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729577307; c=relaxed/simple;
	bh=DoD/+DRhWoCgEEbX9Bjh3rSRO/QmRhvbnky5/Odm3qQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T/c7Kk5JggbglaIrwigDo7PWMRZAPRf0ESPG8a2iOxrs7uV+NliQUV1HPwEQqeSGTt+l7rPHm9OEiYZKBV342+Wm6Z8sKMgzHOroiwo9y1F4gVqIstOZAutbHBeqzYuKBUapVb3XbOXisUnX5t2ISfv+yh/mc7H80a8+SLaREnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nIVNQD/p; arc=fail smtp.client-ip=40.107.22.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R3K3OAOqBechTwdMEFqSEnkxw66nnisuGGU00aQxuzxSMo05FH9c3WBalU2OtiY9vPn+q6SiiHx500VbZnvNozHzjkoD+K3U1BA3STglFBGSPKTbIXGYjy23R5xd9IfIIrDJbH8gbElqIfZal2eX6tQ1StsWVLiZD9rH0MgjoAkFpAeTC8Nw4Wwuk3IjJ6dQBpbcn8dDuCYfifsOSWX907QDt6j09bTPYhZik8v6bfT5qsXp11ipxtMXdTs+l+cpvYkSyWLIfIKF0NtAXW3VoX27BsrVlxtJg7KaYPZd4yT6p1DnjgEprNOZ1ybPgMLzHcpZwyS8kSb6j6wh81+Z8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UdIP+YzCOs0RDLbVuiRZ6PtwrGXMvUFyWugQy6EygBA=;
 b=mfujOEgjIoec4lYqSYVojJGGN3Zt++kQs1/5i0dpcuwk7+r9OzTvg6rfZ83IFXT+JtG69hllIN97y8WfAim5uU836xFT+oV/l00cvrUduhp9O+ht4TamJqHkwWFkBqX5Lz9ge8MWSG46xbRBB44MU/NOQ5HBgr8a4yH7NQ3z9YT9DMofQlMrbnNhxqcbSzMNxNhCp1PCYnFVfIIK/lT5tvvf85BXuRwvgUXh77mp4/HjhZsGfMeqG3zaY/qWM9aLBw3OMjJFfmBMl901N2jOgnoJN6Jg+lM62p1gzMxSFPtEklOkcT0LII8xHxwkrQZ22AZIGawhhMPPTIaSX9jq4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UdIP+YzCOs0RDLbVuiRZ6PtwrGXMvUFyWugQy6EygBA=;
 b=nIVNQD/pKm7oSafwWiSj/7M3TKLGrYPdVK98Bo/sylXMW9QELEzP5RokhYSN7Z7IUfjjMdXMggyjoqpkN90u9qJ5J5849oMOt4j1TV0UjAjuJRyAsjXe4zkjceLaorhuV0IktXpWFZgsbGEGJrfQKx5GWo9elVsDssOmUNSncpL+4LPLOlRVm4owVmL5mviaTFKz0MOU7dBuj49+dFT8Opzk5wcTH+bxfVo0nbesOBHwuR0jOJq/G3ikjI3LP901Ere+tljA0bEDaYbZxYbwYzFUCqbhfrOMYwGlKVJsBvgafWbOb5BHu2nvnVG6MfZO+500+iTTvpMqF4pm0TKCfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA1PR04MB10178.eurprd04.prod.outlook.com (2603:10a6:102:463::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 06:08:23 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 06:08:23 +0000
From: Wei Fang <wei.fang@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	vladimir.oltean@nxp.com,
	claudiu.manoil@nxp.com,
	xiaoning.wang@nxp.com,
	Frank.Li@nxp.com,
	christophe.leroy@csgroup.eu,
	linux@armlinux.org.uk,
	bhelgaas@google.com,
	horms@kernel.org
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	alexander.stein@ew.tq-group.com
Subject: [PATCH v4 net-next 09/13] net: enetc: add i.MX95 EMDIO support
Date: Tue, 22 Oct 2024 13:52:19 +0800
Message-Id: <20241022055223.382277-10-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241022055223.382277-1-wei.fang@nxp.com>
References: <20241022055223.382277-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:3:18::32) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA1PR04MB10178:EE_
X-MS-Office365-Filtering-Correlation-Id: 203062f8-8914-45f3-6abf-08dcf25fef2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Xsll7LqMgbGTlveAkL+IZ0VRtfoFl12brEugq6PKwTy/cEX0D7IelTbYyz/u?=
 =?us-ascii?Q?tBiczQD+/NlDhTXKkcuJV8I3t02ApyvtmVK3+U+JwSr756pT4SWh/9eKyz/u?=
 =?us-ascii?Q?zfH0gl+EypKk8ZeYtX6lF0O7mHWCLshqEbB5JOOpAS7ka4jlmpRAtgfZJ0/Y?=
 =?us-ascii?Q?VlkwxdtO8LKKfYm0PmhDsmufYqdiRixS4ghDcJ3CalNGBRhh+bHf2Jbq5uq3?=
 =?us-ascii?Q?UKjwrGNy4RFYYeS/vHnyyeiDtDK4VjgusJxzu1TmV8G3AjzMQxSr7wiGqPxR?=
 =?us-ascii?Q?o0PvE9SdJBjtlsFXDt9xNof6338RIaZ0mQXumfx8agsnTSBtNUODfhkdnXEa?=
 =?us-ascii?Q?kI8nFfZykMV/3+5ak+uTNDV7MA3phUBwItdGFCxinolMWeZYLcKGcBnrFaC/?=
 =?us-ascii?Q?4rTW6bAZCZvmiL0IAqqVoYh1S7Qr1hJIHUwHz11DtXi0FAauSAW2aweQcAyz?=
 =?us-ascii?Q?ed4bnvDuK0l4H9k9RQTvFNVgKIZ0I2sV6nFhOW5C+LmmVITts5QKezbLQiqG?=
 =?us-ascii?Q?dCAwwZSegaP8pV2AOf28i08S2vh+SXIt2H+RnYH2VbPU7JN4FvEJDgv87zQv?=
 =?us-ascii?Q?mnYxxR4fF5OyLAJ83sP9J+MKjIPBJtIQ0oa7PsZ8z6JqPOvoNsOR0ddr5bHd?=
 =?us-ascii?Q?VEMic244gQ4iLralFrCEPUk2fkE7hyQxFU/IGXigLFfK2kDfRxdAM7EYUci2?=
 =?us-ascii?Q?+1wz8tmm9awre6u00y/85SYM782TCuUT902RRQRqSSHETxv23h9Rjp4uIMaZ?=
 =?us-ascii?Q?4E8xE3Q4m3u2QsFZDOsWdIXfkA2LFgpEmXeCBPduRu9VTSiCQltUKIUK/87D?=
 =?us-ascii?Q?XEjmArNJp2qqyL0BYnYukSnu04HqFjCxgQdJC3hJG/0m4FP3qqVkjxomXZ9m?=
 =?us-ascii?Q?8ylEUiqeEcU2zZUIFIXEjdvTDFrwJEwyDAWHG9rujhjmKlwQqnkz7LtFA8i3?=
 =?us-ascii?Q?YG8AY8dtm5zlmnIJ6ktwzvZqlbwZFyaZYlFBBxZc0JM+aj1tO8zoUqHbn232?=
 =?us-ascii?Q?6VrGBF7wtpyekgb9rl51Lt5lavUq3pSW3GUh2vjtXuAMG5h6f96ao+TOAOuX?=
 =?us-ascii?Q?7nLF67DCuW9+ywfm/6MlV4VhSn3F4KQJ4Rv8LzyC6qxxMWwdpOdh/2VZGCNA?=
 =?us-ascii?Q?f4OwiKVMAhQ8EG8QEouywKzoAjH4df8BTocdCDx0byZY4/HzWu1jkgdizxYX?=
 =?us-ascii?Q?IqZow4s6rsU3qYS8x5PxMv3ybIdsbYEkIas0iPo/QyvsMENYau7R54XU9hrn?=
 =?us-ascii?Q?S8LRdsIf156nVh1isJ1OJ14EFzUIrWSVFBC/bv9a0Z0/vIPwhHekhBE/OJSF?=
 =?us-ascii?Q?ZfjhlO1yUJY+LBdZdomSkGLhijoN4VH5JpzsCv82OB/ood1idyJf+fzn6fNJ?=
 =?us-ascii?Q?gvQG4miiKAvq3VCGGXn3UDfx8XM3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5PkWd/gucDp9Ryl7awxwZWfrmjUonfCtYOfSeesX0F82yX9hp9BjqYOAxrqn?=
 =?us-ascii?Q?Cnqr3ElK2BpwqumlOPCaFlkTQfvUbnoh1VBRDZtgw5BW5x7zC67sknWnoE2l?=
 =?us-ascii?Q?mvMGzjHvBQbrzFmdMhLENJqdOX2bNjU7Sb1h85l2xg6t0yMz2EpzEZ9+9x0V?=
 =?us-ascii?Q?9kPZe9qtKUspiIFQUxK9rCBBhEj8/eWpzf0RhtbFjYGPHJbYeCtD8k1zFRXU?=
 =?us-ascii?Q?tkFPSvLh+f95HOPmkkLjZla7DtzaRL+lJCy/0e4J7JSMahpkFcyCW40g2VMp?=
 =?us-ascii?Q?6Y7HfNRMiDRNYzNhzdvcY0N+FDUTGQk9XWZEXoO7NKv+9AZWG/A1nna9F6Wc?=
 =?us-ascii?Q?sqv4FbH+BlkikLu7wmwPopWNTsAaDN9SOKEA5HO55d1fDcTZHGIMBpxZSWkr?=
 =?us-ascii?Q?3sDbD5MEyPsSV1VFkjcm+ovowIeo5TYeTVyIb97nLKqErsofEfkYbUaKwzvF?=
 =?us-ascii?Q?jRDkhTBN0NNUOAk72qn9fZwdr128pWrHzPA8Bfi6V0x+t1EBf/dxZ3dlXLs+?=
 =?us-ascii?Q?lYnw6oPuFQAUloDwfs3bDDfWYsgY4ORzEJ8vBhcYMQIPLa5YOCUH6b/dq6tT?=
 =?us-ascii?Q?s32xkLcXENrR9cEGVDD43P0A7CS9qWU19TDboe2JrvSqkHRUWfUNhQCHax7/?=
 =?us-ascii?Q?2VpqanmRGcdrNcujOfH/+H6AONT36RAH0BEHXzsyrpWx25rXvV1Up7gv577o?=
 =?us-ascii?Q?B9EC4cAwoZC9otA7GSEH+wnnMAqueAm2JW2lRn2Mp0X34VFeAK7+Td03+m2w?=
 =?us-ascii?Q?LGgP9YadTNAm22wiXWX3XcGdkkBVkniARdHhkY5jDObGdrJbK1c7thFswSjN?=
 =?us-ascii?Q?EpsGcM7/ur4hmQUW+I4Cxi3HHuO2F1bM4Hylnq11GZVMXbVBUjGLZF2zRvmG?=
 =?us-ascii?Q?q218uyD6f8lsX+DxBLHCWeZuwHYvDPOJ4dhmxMguwBxVROppBuUl0Cych6qU?=
 =?us-ascii?Q?/VAzjbrK5Xy49mrDWcV4cCI5Qyw/W0A1AC/x6eHFJGboTjgUprNbiz1YfKns?=
 =?us-ascii?Q?mVc2CjSJlzxrK6+27IJ4W8d1XoOB0DfliYdjsQfrlEtgCTtX4dOu3vpZHaMi?=
 =?us-ascii?Q?YgtS+473m0rgwEbTd2ubZFt6OJc1utjvI7xbdvsVwlV7JZ78pvLOCKOhsd2g?=
 =?us-ascii?Q?2qX32zoo87rIM2qtNjxuBN7KWzAzQsCIjSOox+Tg+L8d+4B3iwS3q62Nt6E3?=
 =?us-ascii?Q?3JIvzqnHngmc0iz9RyEpfPFGU/DzI4/gyrvV2vhXebl7ppn75pI2fJDvpk/u?=
 =?us-ascii?Q?ReoECMNAEsI6AxXk0RiAPnIkAJOj3fwIy8kd5PV5mzbiNOvWJ3u5Qksc675P?=
 =?us-ascii?Q?uX6PkVDh7aJKEXDfSvFUJ6OPjBnEe0RP/TZGncsCGgYN67fVnGRSfuT24zcz?=
 =?us-ascii?Q?LwVSodJIOsGWPZBobQs/3r2QK9flAfSRDKQGw614TuvpMTGOxncvEMrDdPlr?=
 =?us-ascii?Q?ZVCvj6RNivCt/5qhgBHffW+FZ7fR4mLwYaSOAGE6RKpd/sS5X5BhBtjAOcVm?=
 =?us-ascii?Q?+SA5FC/wd24qGJpvuOIG0Fz/HyNqGIQMUqWnbu2GHULJQr0ry5hNCpWw9yHF?=
 =?us-ascii?Q?IR7mB2R4+aC7Pe1RZ/8v8CBtpTTDEzkmOdV3RNb+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 203062f8-8914-45f3-6abf-08dcf25fef2d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 06:08:23.0917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XLrZm2HOnnguEUn5w3mnfDAP5eH6GksCFiojFjfnMdqDTlxfrbewAgA+WcmawmkUIN4y6x0YVrVFZYLHg0dqjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10178

The verdor ID and device ID of i.MX95 EMDIO are different from LS1028A
EMDIO, so add new vendor ID and device ID to pci_device_id table to
support i.MX95 EMDIO. And the i.MX95 EMDIO has two pins that need to be
controlled, namely MDC and MDIO.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
v2: no changes
v3: no changes
v4: no changes
---
 drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c b/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
index 2445e35a764a..9968a1e9b5ef 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
@@ -2,6 +2,7 @@
 /* Copyright 2019 NXP */
 #include <linux/fsl/enetc_mdio.h>
 #include <linux/of_mdio.h>
+#include <linux/pinctrl/consumer.h>
 #include "enetc_pf.h"
 
 #define ENETC_MDIO_DEV_ID	0xee01
@@ -71,6 +72,8 @@ static int enetc_pci_mdio_probe(struct pci_dev *pdev,
 		dev_info(&pdev->dev, "Enabled ERR050089 workaround\n");
 	}
 
+	pinctrl_pm_select_default_state(dev);
+
 	err = of_mdiobus_register(bus, dev->of_node);
 	if (err)
 		goto err_mdiobus_reg;
@@ -113,6 +116,7 @@ static void enetc_pci_mdio_remove(struct pci_dev *pdev)
 
 static const struct pci_device_id enetc_pci_mdio_id_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, ENETC_MDIO_DEV_ID) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NXP2, PCI_DEVICE_ID_NXP2_NETC_EMDIO) },
 	{ 0, } /* End of table. */
 };
 MODULE_DEVICE_TABLE(pci, enetc_pci_mdio_id_table);
-- 
2.34.1


