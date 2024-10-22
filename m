Return-Path: <linux-pci+bounces-14978-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1B89A9950
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 08:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F1801C23235
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 06:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965A91514F6;
	Tue, 22 Oct 2024 06:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JPDMHrjs"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2069.outbound.protection.outlook.com [40.107.22.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1E4145B22;
	Tue, 22 Oct 2024 06:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729577290; cv=fail; b=m0MIHe7lAg8h0S4CipeGspcd7xNWb7i/zhwZMsgEI1r5BYycoHpsszb7+7j8jQv0Tp5aP7wZtNUprWo4TP00uexaz8XY5FIJULoBoXMeSM3MqMGOt7u8mKKidUptcqbdkzPeX/acm7FGk6340EQ+iuGfSzLaeb6Hn97gsx6cVvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729577290; c=relaxed/simple;
	bh=OJi986vdpBH0nvj70921/t4I7HSORCZ2X3m0tBljJFs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fqexc8bnT4W/2nA94yh0k/Glaco2+I7/ZG+YmQIFEwQcDQAEHvHP5C1DGcobgCpKkAubT6b65DlmVIUM95bvxDaj3ttf8aFAP1v4w6dgPhtawH2TJZFApX8ucGmBlmhqUYMoIBL/x1JMv0YaZoQjxiOKRLAeKyy+KcCVJPtELYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JPDMHrjs; arc=fail smtp.client-ip=40.107.22.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FuGkokiAnj3iAgbZrj554XsSgP9lSnmBj/FLPXwKAxXcPZdTf8hR8aYLCYJGLNF4xAQZU+TYcL7916oYD/xDxTn5IFNIx2Zg0P6+TwVCYkpbLT7xxvswazPeUlfFuNw7YSOzGqjdn8WMA4MEHInOuI8me0fLUft6TyTOO088hLoOrrcX4rbyC5/cT7mB83oYPmfI79D/1CE0jHQ3iOOYM5rSzNXZjoBBEvnR7Vy8D+nfkCwSoMcgYzSYT3MvyOGdSHY8SizE2l3RsyCda8yygYdM0DMipvvIvtfD07+CcQLjRHusq0TuLNHnepCYCw8kJ4rbn0mp+KQ8ZgHD4CM/SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=accKu+9+eH11zX2CtBkofZOVTrsYyhbRegzoPtBBawY=;
 b=I51eckq51V9NPQnmnJocYVR5nRku/I5Qb9ECLcKNAeXs/MDfJGsP8Ip1IiE0QezDl+irqh4JuOn2C62AvUKWk/Kv0dzi52jxE0EHp6hf5AbbAtitEKLa1Io17TnlstIbm6+0u253FprDsSa5xZdp2X4/o8cUa9Hp7L6ZfscASkQ6uS8I9eykC5uYmfqtvo59sXk9QUbr5+L4B9bvVKm8Q14JKe8NTjekav9vaQrY62TNfKQ6KhIbgb4ImG2SvohGJPQR4YzaCAT2NZHINQwDjOmFzy78pGgo+9HpCDQa1TTsBsIIbujEdBDHzl5mM1qQXTD9lxl6RGifB7m7aUMiSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=accKu+9+eH11zX2CtBkofZOVTrsYyhbRegzoPtBBawY=;
 b=JPDMHrjsr6wSWM5vsrnRgRiLBqEQZc+fe48FO4swJBhLnLayerQj0JmJKxABVQa+y0Mn3FMAeCZu1l/N58DFp218tEJvHZFVAqUN6Hbp7nBrARsKO5yApdFtonmK2GHvftqMiu6t07EoAUQH/KyW1DXQAwmw+sQsQfDCGjeT0b4t/SQE7oDtPCCWcUlWTuNwySfYwfBweFiGNR9AgtYXIkmiBNUP7qU6CD1121jmyXi27tTGI+80nsFcLvrcB2cVVcMQnNx3qbcHUH4lVCE4Btl7HIw8P8CQIdOQQXhX+DNH8fsLwxmBEjI+8sK90DepVUSBGwiAEr9L4MIrArqsUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA1PR04MB10178.eurprd04.prod.outlook.com (2603:10a6:102:463::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 06:08:03 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 06:08:03 +0000
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
Subject: [PATCH v4 net-next 06/13] net: enetc: build enetc_pf_common.c as a separate module
Date: Tue, 22 Oct 2024 13:52:16 +0800
Message-Id: <20241022055223.382277-7-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4b15ab1e-eab9-4985-3200-08dcf25fe399
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ghpbk5hkQVSgwWGc9azBCC4DjwG+rRju4hos0Al43QayHxbliIkYXYwaAF9j?=
 =?us-ascii?Q?pfpg6r13ZS0/zWuM9NGGunceleQH0/YYC+oU93YKaoMu7ovBo+xve7ZOTMxf?=
 =?us-ascii?Q?7BIqtloV60kGmvg54RbUKPdA+eWb/nahJiPpZHdKI4d5jrLTrlXADPVAmkxg?=
 =?us-ascii?Q?toYQEU7KbH8F7D5BCAswtl0SnPlKSR5T7K4OnpV+/I0w2H7Or1/AZylt2O4y?=
 =?us-ascii?Q?sXGqXlRdtLqgkgOm9HyLf8qDz3ji7JZXpJHQPaHtJTiO4Kuex+p1ZmbyqYkq?=
 =?us-ascii?Q?7HBgg928ttIlsT4LT+huQMkWJi6Hfgq0qzp6HtR7/35LxcyocSRw+S1owxZd?=
 =?us-ascii?Q?uSwouwmZ7pI8mZ67r97M5QwkohMpNZZgTN5AM8U+f7429g7R+tYMjzU/ZDel?=
 =?us-ascii?Q?6BQPFr2pO3i9GQy+izQ5Xjz5hRp2JzHn6gQGgRXvpfOPZVKJR6q0KZVzPS5Q?=
 =?us-ascii?Q?n7CNrDAwN4aCXYjuZn4hzkWXhXoTd2i5V3d7zqSZFvl/ZjjbSDwRGRQDLsWu?=
 =?us-ascii?Q?Q0VbANvZsU0rNrKQNB52jZJu5veJwJl6ZNn02xape/wYcWFAN3v8k9cgCkG4?=
 =?us-ascii?Q?h3FIcnQdL8estXrYuQv8KlJyO5yiHC61t6wVZpgyum4cJsEWx/aNxnl8bP/d?=
 =?us-ascii?Q?x0q9cXaFPMi+CQkMY3jlNjgVdaalBdvY6ZFrhz+ggh0rIB0KlATStqfRsIC9?=
 =?us-ascii?Q?utTlC4M7Lzw5sQ1XntEY4g+8CwnjzcgG88PI8WcDS8K/eWF5NMtJHcslhJ5W?=
 =?us-ascii?Q?NoB/7jyN3nz8jqe9jtDLyueBlOUA5OZmUZQmFtUWOqwGwq/CF4+FUciO/Zww?=
 =?us-ascii?Q?iMucRacXv8uEh9rvu1nSySqKWBSQtCed+qIEyYdggY2shPihkBJhy9GbD8CM?=
 =?us-ascii?Q?T1lIgQD3nSHulSocOWntc5rvSXhLS1Iz+Bw35Sz6QiwvjbsKY+9R+Rz+PoO0?=
 =?us-ascii?Q?FjCj3OAASWLFhphAQxgmD2WptZrbYOPahbO2rI8Rk7Eb3jOdA/7HIfSeGqcV?=
 =?us-ascii?Q?gNhRyCCdl7R0HC8kMEPcK2PYLMNibzk6WxRrFhdVvTtAz9/k1XeiMmYV3BH/?=
 =?us-ascii?Q?gYneNowkHhdjadooy2POXLKzOQ6LvpFUQLGWeK38uBMpvC5nYCrncs8dp7Jl?=
 =?us-ascii?Q?G6K0gvAN+OlTE151nIi2Lv/7f67Y+e9+ZYflGqs3yN0gMfibUdxeKXdKu8Ks?=
 =?us-ascii?Q?NIRDpbS98GlDEPrcx2bIh4bGIlo533/ldmy+5eWDShPJ7yOWGof4//RWUioW?=
 =?us-ascii?Q?3O4VeXndex5xLOLSAI7o+DJwElbUAoUJJDl1Ng8fpagbffWqpkKmIkR7cat4?=
 =?us-ascii?Q?ioCzXTCWkVsxlz3RJBrvoPzVLpIQr+Fg7lQQnl17Jg0fZHkswqviWIYaAzmW?=
 =?us-ascii?Q?/Jwt0+UnzOGEX3rcWYe+2NPPhHO0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j7+sLjbdNEat684fQPZI59GddEnuvdtJET8RgeFDeDodO3TIoMlOvYRvtAJL?=
 =?us-ascii?Q?cAoaAMhNQ7tqhdQ8v8WqyAcpOoCJyXqgzUhaptogNwFIHzpshnpO+mwSBF39?=
 =?us-ascii?Q?EvJEP3bYtONV+DF6G8+5Fd4RMH+bAdjTn1jiwPV7AgGQ0v/7xlBZWGF12gSr?=
 =?us-ascii?Q?6oh/175RIAoDxaUXVlH2ULiu5XVgLwzu38mmt1Vz4Djs/Cwam3HgdhGK1kbX?=
 =?us-ascii?Q?QvCiE1KvErWfMW3Lc5YRb3BuBE0G7DYUO+/EQy04yivwEH7iw6eIkXZnnQAI?=
 =?us-ascii?Q?ENNntpzOYnHkmUhaecAFApSJk3RWXDASzv3MRTPUxuve2xl8uQXg1XfZcqZo?=
 =?us-ascii?Q?wOLacX1w1B1mDcJJyLkHh/elXk4m2v9sYs2crfN/iotgLQ6xSxctCBjECnRZ?=
 =?us-ascii?Q?pL7Nvuhyq8569fB29qBotLhwWxVmJLHfH47OFGuJDF28ZlNC5xutYLwjNOfF?=
 =?us-ascii?Q?5BerHaqBIBaWM5QObckvWy29o4feodSpVZir6L7Q6wuKuF93BKsdCKcuQrvm?=
 =?us-ascii?Q?gnv94RT56yFJ+pHa9ofNyk5Gml2NFO8REM1GgT52n1b4M4HkmbVCBsDpv1x6?=
 =?us-ascii?Q?E1lewxopFBAafYy6X4BOVEV6cJ/MoNJgdAVfLEpAjlkNUKhMjEcP5jjlgFHa?=
 =?us-ascii?Q?9yYenVfQxk8DqWx3fBh+SOT8mEe6f47rjdIBHJfE47J9uavS0rS2ZhD5bdWl?=
 =?us-ascii?Q?C1m5wm6AAF9GKd02pYeT6WHkKMkk34als/PEBUr2IJyN3Qesm6Ew9IneJ9CW?=
 =?us-ascii?Q?lvlaJZiXHBMNMPhILdMVKtkG/ylFR5u2rZWXZu9UNW+esLOzQ5dwzrxeo680?=
 =?us-ascii?Q?KK7ZLmlKAoohylbXn+nHlej2nE6nxFKZrOfmt3+wOBz3F7LjepvRdvVociyH?=
 =?us-ascii?Q?dJSMMrtcC+RH4yUzat2guRBwOlx+NKVoJuHj0LofRrTcjZEIWCc/0lDiP7VV?=
 =?us-ascii?Q?MRcWIX51OCuoqwOu9WOdN9nlK17/VgcnPBOuIVwqJboVB1F9U+VeHgpDK6z6?=
 =?us-ascii?Q?48xNwAfdXGfXDuAEYMiBVIUgBh+WhmRGkN6q/HbSc7hbp6RlwdjWWbdaJsnG?=
 =?us-ascii?Q?oAa0f7eab5m9t90bwrW3zi7vdyviBv0yhjl228Hi1uEz+h3FrXz7gj0WnTNu?=
 =?us-ascii?Q?IHflEJd1AqMbBolzBgD9LBxit08stM2amWHedCNpEVh3jRP7lNyz/z/FQR0Y?=
 =?us-ascii?Q?0CaXzUd+LUdXqg9yymcCr62+YF8cb45vs2DA0D8QIGPI4SsaT9K9lx/qHi18?=
 =?us-ascii?Q?eCV+HiI0OPgk5pmoq8/IdGCEn/tw5eQikYMaYeSiT/XZkxMbZKLhkTm9i2Z1?=
 =?us-ascii?Q?N8N8uGv+Khlwj6Xa31+KLUETfUkLn6492D8f0QwTeZ+EBqVgINYrSyB9Jiy7?=
 =?us-ascii?Q?sXGyiMMr67VKYX99S8wBdco0wSkpHsQbIKWeYxB7Dmjuucl2fY/hf/kJF5jo?=
 =?us-ascii?Q?A6DQQTeNde7tXzPaW0lmfpVADEOSZrTWT6FUxB7cxy3CcgygiAM2YwzqutLG?=
 =?us-ascii?Q?7ubys37wS6HVANzlQjZHs+Y/NDLAjo7iXShddZDnFQxxM3cp3JrCdynjWaAp?=
 =?us-ascii?Q?HLnJI0PkaVVl0sMbAH0lyf0Xg3kF8NFjmJiKzriN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b15ab1e-eab9-4985-3200-08dcf25fe399
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 06:08:03.8404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Icg/UEzWmoi2gVuxtHOFVifJsOBH4aYM12mUlESyDmv67eIPHgey3/7OaS/V7cAbLToSIulU6IlUCoW59kzUlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10178

Compile enetc_pf_common.c as a standalone module to allow shared usage
between ENETC v1 and v4 PF drivers. Add struct enetc_pf_ops to register
different hardware operation interfaces for both ENETC v1 and v4 PF
drivers.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
v2 changes:
This patch is separated from v1 patch 5 ("net: enetc: add enetc-pf-common
driver support"), only the changes to compile enetc_pf_common.c into a
separated driver are kept.
v3 changes:
Refactor the commit message.
v4 changes: Remove the input prompt of CONFIG_NXP_ENETC_PF_COMMON.
---
 drivers/net/ethernet/freescale/enetc/Kconfig  |  9 ++++
 drivers/net/ethernet/freescale/enetc/Makefile |  5 +-
 .../net/ethernet/freescale/enetc/enetc_pf.c   | 26 ++++++++--
 .../net/ethernet/freescale/enetc/enetc_pf.h   | 21 ++++++--
 .../freescale/enetc/enetc_pf_common.c         | 50 ++++++++++++++++---
 5 files changed, 96 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/Kconfig b/drivers/net/ethernet/freescale/enetc/Kconfig
index 51d80ea959d4..e1b151a98b41 100644
--- a/drivers/net/ethernet/freescale/enetc/Kconfig
+++ b/drivers/net/ethernet/freescale/enetc/Kconfig
@@ -7,6 +7,14 @@ config FSL_ENETC_CORE
 
 	  If compiled as module (M), the module name is fsl-enetc-core.
 
+config NXP_ENETC_PF_COMMON
+	tristate
+	help
+	  This module supports common functionality between drivers of
+	  different versions of NXP ENETC PF controllers.
+
+	  If compiled as module (M), the module name is nxp-enetc-pf-common.
+
 config FSL_ENETC
 	tristate "ENETC PF driver"
 	depends on PCI_MSI
@@ -14,6 +22,7 @@ config FSL_ENETC
 	select FSL_ENETC_CORE
 	select FSL_ENETC_IERB
 	select FSL_ENETC_MDIO
+	select NXP_ENETC_PF_COMMON
 	select PHYLINK
 	select PCS_LYNX
 	select DIMLIB
diff --git a/drivers/net/ethernet/freescale/enetc/Makefile b/drivers/net/ethernet/freescale/enetc/Makefile
index 8f4d8e9c37a0..ebe232673ed4 100644
--- a/drivers/net/ethernet/freescale/enetc/Makefile
+++ b/drivers/net/ethernet/freescale/enetc/Makefile
@@ -3,8 +3,11 @@
 obj-$(CONFIG_FSL_ENETC_CORE) += fsl-enetc-core.o
 fsl-enetc-core-y := enetc.o enetc_cbdr.o enetc_ethtool.o
 
+obj-$(CONFIG_NXP_ENETC_PF_COMMON) += nxp-enetc-pf-common.o
+nxp-enetc-pf-common-y := enetc_pf_common.o
+
 obj-$(CONFIG_FSL_ENETC) += fsl-enetc.o
-fsl-enetc-y := enetc_pf.o enetc_pf_common.o
+fsl-enetc-y := enetc_pf.o
 fsl-enetc-$(CONFIG_PCI_IOV) += enetc_msg.o
 fsl-enetc-$(CONFIG_FSL_ENETC_QOS) += enetc_qos.o
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index 3cdd149056f9..7522316ddfea 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -11,7 +11,7 @@
 
 #define ENETC_DRV_NAME_STR "ENETC PF driver"
 
-void enetc_pf_get_primary_mac_addr(struct enetc_hw *hw, int si, u8 *addr)
+static void enetc_pf_get_primary_mac_addr(struct enetc_hw *hw, int si, u8 *addr)
 {
 	u32 upper = __raw_readl(hw->port + ENETC_PSIPMAR0(si));
 	u16 lower = __raw_readw(hw->port + ENETC_PSIPMAR1(si));
@@ -20,8 +20,8 @@ void enetc_pf_get_primary_mac_addr(struct enetc_hw *hw, int si, u8 *addr)
 	put_unaligned_le16(lower, addr + 4);
 }
 
-void enetc_pf_set_primary_mac_addr(struct enetc_hw *hw, int si,
-				   const u8 *addr)
+static void enetc_pf_set_primary_mac_addr(struct enetc_hw *hw, int si,
+					  const u8 *addr)
 {
 	u32 upper = get_unaligned_le32(addr);
 	u16 lower = get_unaligned_le16(addr + 4);
@@ -30,6 +30,17 @@ void enetc_pf_set_primary_mac_addr(struct enetc_hw *hw, int si,
 	__raw_writew(lower, hw->port + ENETC_PSIPMAR1(si));
 }
 
+static struct phylink_pcs *enetc_pf_create_pcs(struct enetc_pf *pf,
+					       struct mii_bus *bus)
+{
+	return lynx_pcs_create_mdiodev(bus, 0);
+}
+
+static void enetc_pf_destroy_pcs(struct phylink_pcs *pcs)
+{
+	lynx_pcs_destroy(pcs);
+}
+
 static void enetc_set_vlan_promisc(struct enetc_hw *hw, char si_map)
 {
 	u32 val = enetc_port_rd(hw, ENETC_PSIPVMR);
@@ -970,6 +981,14 @@ static void enetc_psi_destroy(struct pci_dev *pdev)
 	enetc_pci_remove(pdev);
 }
 
+static const struct enetc_pf_ops enetc_pf_ops = {
+	.set_si_primary_mac = enetc_pf_set_primary_mac_addr,
+	.get_si_primary_mac = enetc_pf_get_primary_mac_addr,
+	.create_pcs = enetc_pf_create_pcs,
+	.destroy_pcs = enetc_pf_destroy_pcs,
+	.enable_psfp = enetc_psfp_enable,
+};
+
 static int enetc_pf_probe(struct pci_dev *pdev,
 			  const struct pci_device_id *ent)
 {
@@ -997,6 +1016,7 @@ static int enetc_pf_probe(struct pci_dev *pdev,
 	pf = enetc_si_priv(si);
 	pf->si = si;
 	pf->total_vfs = pci_sriov_get_totalvfs(pdev);
+	enetc_pf_ops_register(pf, &enetc_pf_ops);
 
 	err = enetc_setup_mac_addresses(node, pf);
 	if (err)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
index 92a26b09cf57..39db9d5c2e50 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
@@ -28,6 +28,16 @@ struct enetc_vf_state {
 	enum enetc_vf_flags flags;
 };
 
+struct enetc_pf;
+
+struct enetc_pf_ops {
+	void (*set_si_primary_mac)(struct enetc_hw *hw, int si, const u8 *addr);
+	void (*get_si_primary_mac)(struct enetc_hw *hw, int si, u8 *addr);
+	struct phylink_pcs *(*create_pcs)(struct enetc_pf *pf, struct mii_bus *bus);
+	void (*destroy_pcs)(struct phylink_pcs *pcs);
+	int (*enable_psfp)(struct enetc_ndev_priv *priv);
+};
+
 struct enetc_pf {
 	struct enetc_si *si;
 	int num_vfs; /* number of active VFs, after sriov_init */
@@ -50,6 +60,8 @@ struct enetc_pf {
 
 	phy_interface_t if_mode;
 	struct phylink_config phylink_config;
+
+	const struct enetc_pf_ops *ops;
 };
 
 #define phylink_to_enetc_pf(config) \
@@ -59,9 +71,6 @@ int enetc_msg_psi_init(struct enetc_pf *pf);
 void enetc_msg_psi_free(struct enetc_pf *pf);
 void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int mbox_id, u16 *status);
 
-void enetc_pf_get_primary_mac_addr(struct enetc_hw *hw, int si, u8 *addr);
-void enetc_pf_set_primary_mac_addr(struct enetc_hw *hw, int si,
-				   const u8 *addr);
 int enetc_pf_set_mac_addr(struct net_device *ndev, void *addr);
 int enetc_setup_mac_addresses(struct device_node *np, struct enetc_pf *pf);
 void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
@@ -71,3 +80,9 @@ void enetc_mdiobus_destroy(struct enetc_pf *pf);
 int enetc_phylink_create(struct enetc_ndev_priv *priv, struct device_node *node,
 			 const struct phylink_mac_ops *ops);
 void enetc_phylink_destroy(struct enetc_ndev_priv *priv);
+
+static inline void enetc_pf_ops_register(struct enetc_pf *pf,
+					 const struct enetc_pf_ops *ops)
+{
+	pf->ops = ops;
+}
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index bce81a4f6f88..94690ed92e3f 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -8,19 +8,37 @@
 
 #include "enetc_pf.h"
 
+static int enetc_set_si_hw_addr(struct enetc_pf *pf, int si, u8 *mac_addr)
+{
+	struct enetc_hw *hw = &pf->si->hw;
+
+	if (pf->ops->set_si_primary_mac)
+		pf->ops->set_si_primary_mac(hw, si, mac_addr);
+	else
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
 int enetc_pf_set_mac_addr(struct net_device *ndev, void *addr)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
+	struct enetc_pf *pf = enetc_si_priv(priv->si);
 	struct sockaddr *saddr = addr;
+	int err;
 
 	if (!is_valid_ether_addr(saddr->sa_data))
 		return -EADDRNOTAVAIL;
 
+	err = enetc_set_si_hw_addr(pf, 0, saddr->sa_data);
+	if (err)
+		return err;
+
 	eth_hw_addr_set(ndev, saddr->sa_data);
-	enetc_pf_set_primary_mac_addr(&priv->si->hw, 0, saddr->sa_data);
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(enetc_pf_set_mac_addr);
 
 static int enetc_setup_mac_address(struct device_node *np, struct enetc_pf *pf,
 				   int si)
@@ -38,8 +56,8 @@ static int enetc_setup_mac_address(struct device_node *np, struct enetc_pf *pf,
 	}
 
 	/* (2) bootloader supplied MAC address */
-	if (is_zero_ether_addr(mac_addr))
-		enetc_pf_get_primary_mac_addr(hw, si, mac_addr);
+	if (is_zero_ether_addr(mac_addr) && pf->ops->get_si_primary_mac)
+		pf->ops->get_si_primary_mac(hw, si, mac_addr);
 
 	/* (3) choose a random one */
 	if (is_zero_ether_addr(mac_addr)) {
@@ -48,7 +66,9 @@ static int enetc_setup_mac_address(struct device_node *np, struct enetc_pf *pf,
 			 si, mac_addr);
 	}
 
-	enetc_pf_set_primary_mac_addr(hw, si, mac_addr);
+	err = enetc_set_si_hw_addr(pf, si, mac_addr);
+	if (err)
+		return err;
 
 	return 0;
 }
@@ -70,11 +90,13 @@ int enetc_setup_mac_addresses(struct device_node *np, struct enetc_pf *pf)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(enetc_setup_mac_addresses);
 
 void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 			   const struct net_device_ops *ndev_ops)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
+	struct enetc_pf *pf = enetc_si_priv(si);
 
 	SET_NETDEV_DEV(ndev, &si->pdev->dev);
 	priv->ndev = ndev;
@@ -107,7 +129,8 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 			     NETDEV_XDP_ACT_NDO_XMIT | NETDEV_XDP_ACT_RX_SG |
 			     NETDEV_XDP_ACT_NDO_XMIT_SG;
 
-	if (si->hw_features & ENETC_SI_F_PSFP && !enetc_psfp_enable(priv)) {
+	if (si->hw_features & ENETC_SI_F_PSFP && pf->ops->enable_psfp &&
+	    !pf->ops->enable_psfp(priv)) {
 		priv->active_offloads |= ENETC_F_QCI;
 		ndev->features |= NETIF_F_HW_TC;
 		ndev->hw_features |= NETIF_F_HW_TC;
@@ -116,6 +139,7 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 	/* pick up primary MAC address from SI */
 	enetc_load_primary_mac_addr(&si->hw, ndev);
 }
+EXPORT_SYMBOL_GPL(enetc_pf_netdev_setup);
 
 static int enetc_mdio_probe(struct enetc_pf *pf, struct device_node *np)
 {
@@ -162,6 +186,9 @@ static int enetc_imdio_create(struct enetc_pf *pf)
 	struct mii_bus *bus;
 	int err;
 
+	if (!pf->ops->create_pcs)
+		return -EOPNOTSUPP;
+
 	bus = mdiobus_alloc_size(sizeof(*mdio_priv));
 	if (!bus)
 		return -ENOMEM;
@@ -184,7 +211,7 @@ static int enetc_imdio_create(struct enetc_pf *pf)
 		goto free_mdio_bus;
 	}
 
-	phylink_pcs = lynx_pcs_create_mdiodev(bus, 0);
+	phylink_pcs = pf->ops->create_pcs(pf, bus);
 	if (IS_ERR(phylink_pcs)) {
 		err = PTR_ERR(phylink_pcs);
 		dev_err(dev, "cannot create lynx pcs (%d)\n", err);
@@ -205,8 +232,8 @@ static int enetc_imdio_create(struct enetc_pf *pf)
 
 static void enetc_imdio_remove(struct enetc_pf *pf)
 {
-	if (pf->pcs)
-		lynx_pcs_destroy(pf->pcs);
+	if (pf->pcs && pf->ops->destroy_pcs)
+		pf->ops->destroy_pcs(pf->pcs);
 
 	if (pf->imdio) {
 		mdiobus_unregister(pf->imdio);
@@ -246,12 +273,14 @@ int enetc_mdiobus_create(struct enetc_pf *pf, struct device_node *node)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(enetc_mdiobus_create);
 
 void enetc_mdiobus_destroy(struct enetc_pf *pf)
 {
 	enetc_mdio_remove(pf);
 	enetc_imdio_remove(pf);
 }
+EXPORT_SYMBOL_GPL(enetc_mdiobus_destroy);
 
 int enetc_phylink_create(struct enetc_ndev_priv *priv, struct device_node *node,
 			 const struct phylink_mac_ops *ops)
@@ -288,8 +317,13 @@ int enetc_phylink_create(struct enetc_ndev_priv *priv, struct device_node *node,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(enetc_phylink_create);
 
 void enetc_phylink_destroy(struct enetc_ndev_priv *priv)
 {
 	phylink_destroy(priv->phylink);
 }
+EXPORT_SYMBOL_GPL(enetc_phylink_destroy);
+
+MODULE_DESCRIPTION("NXP ENETC PF common functionality driver");
+MODULE_LICENSE("Dual BSD/GPL");
-- 
2.34.1


