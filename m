Return-Path: <linux-pci+bounces-15581-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C199B5F8C
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 11:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9FFD1C21574
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 10:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0261EC016;
	Wed, 30 Oct 2024 09:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="E14YCLMh"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011005.outbound.protection.outlook.com [52.101.65.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866C41E9071;
	Wed, 30 Oct 2024 09:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730282163; cv=fail; b=lI394bATeziktDmBUnOxoxP6V2EN1x0iZRENOoDgnmsmMumqyJlRJSzCNc5rOrgDAS0EO6vkCv+M0QlcuATPsAePyR/0R5JRgibbgoHM+i7zvZLJo9IU8q0whh837CNCWMJAfPkTQMGw89xno8ZmTDhM9HUHvdHoDb1p/GZAsj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730282163; c=relaxed/simple;
	bh=pHlT8jL2EyTWjidj+y7k0/9mI3y1CeEQQQSc8BjP0ck=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=omdhV8Nz8SEalpSe4ciKCfKda3rgZ1OmjWSVkAnCqWLR5PLAdYBahmhah2+/gKc+013pGYZBTCCmUeUFxQM8OZCL3RFfdQ1h2oT/ogk1qsg70RtBqE8cP5VKyRDo3RHqQR/gxZqnZZ682U9b+OIAx9ZbRSYZygoDy24re1AD/cY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=E14YCLMh; arc=fail smtp.client-ip=52.101.65.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xyA/h//pnSPS22jIIbKC7DHy8/+o/J4bd5H2Qfo94N2FMxofWotuGXx2X6H/zP5aCvK4GiPnSLbEYdEkxnrIiw1HQq8VQimVRJxAHmclL+PRIrextcSA56PO7BT/1rDV7YIJoeP9cv+g155SzSa0BFBIdZwAK6w13Eh9A3yt1jaLbaH4vy9rNF0nos1d/p5Eebw7kFB+DrQyhttH7Hau9YapqmM7bNTCVXzEpxoe4Kj4wOIbeCxZnYCH2uy33rw17+McPIpUiHN9LTQ+KxmRZsv1Evx/CeYLBBpFH7AP4f7mcpGWPUkzWs4WZ752jMdxEWeCvlWlrbesBJsEvGLVcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7N44tyZPXUffv7eRlDVOVgDDUU4G9aDUtWTZGXJ5L9c=;
 b=pC/gn7yKlzB4sL5IAzvuziToPSKeZw2pg0JmzVfNpkRRF620WTH7oQoOLqBdKfAq4RXhgN4v46Lovtkd9NT9QVtJWlEEUfXEO612k/NxyT/SHal+Brg8nNDYhZ3S5qf0qvr4jlKMi6MqKuoCgh5whrFQgK3v8Y54ktW9+4sfXBPWY+qJPo+xv/QRZMsrgyUTqo0Zu1lrvODMO6uS7D3XZpSm7Tp/jwXZlVUBkOPSK3fRgB4t24zP1RDUBUCVmN3gby1HbP1pTocwLsqH+achLqpsER9apJgS8sQsVjF+Xl6XvjhQgbRjNxe805hrT+hr4lPoRxn1Ev+cHzXao7rPjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7N44tyZPXUffv7eRlDVOVgDDUU4G9aDUtWTZGXJ5L9c=;
 b=E14YCLMhE61EwRAqG/e/06Lsh87GVhrU696PEfY7eNM9tUAMkH/iWnzCPYSxVETd08pWubsaFyfDyD87Cdp5d1CUX5d36oAQJuWZUWA3SpiojIYo8sA+B3msIvrKp/FqnYXBl6+wggl55J1ptASjSE9HA578wmqjXUmhPi7aoJU7uEOvziwBOX+OouKfRnMUAcHY3/rfeat9uCNMO2Xlwy40NzvmVzXTxQZLZbyLdE0FtuarIFBG3V34mc+wDat2h3RAiv6t98KU/f1FIQsSP5gB2jevhWG1fM4vVbGRiKDs7BKDZTXZ3wbhVuSR+AcdqIEnFa4wYCVwWufuGV9SYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAXPR04MB8912.eurprd04.prod.outlook.com (2603:10a6:102:20f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Wed, 30 Oct
 2024 09:55:58 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 09:55:58 +0000
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
	horms@kernel.org
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	alexander.stein@ew.tq-group.com
Subject: [PATCH v6 net-next 12/12] MAINTAINERS: update ENETC driver files and maintainers
Date: Wed, 30 Oct 2024 17:39:23 +0800
Message-Id: <20241030093924.1251343-13-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241030093924.1251343-1-wei.fang@nxp.com>
References: <20241030093924.1251343-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::21)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PAXPR04MB8912:EE_
X-MS-Office365-Filtering-Correlation-Id: 111cdbc1-55db-4fb6-9a78-08dcf8c90d92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?drK8iwBUfLoqCyKaa/yE7wjj4LbFvLaUinxWbuJ3OOtrMFC1Fyju1lwsB4FQ?=
 =?us-ascii?Q?6qHiFvWtYwaN7QfHc01pUU4TR5C4pYYK8+tCsSea5oQkrs702JyS5buFLUzT?=
 =?us-ascii?Q?CgbHlzB8EthceC4RGfumJ83JSvcLR1FJli+IdguOipeB7fmnPxm9gXo6Jvi9?=
 =?us-ascii?Q?nfsS3ifKEP1vEOk6oGqjDgLDfa3daLIkDuZRaFxzRXIN2he47oIPYfWASyto?=
 =?us-ascii?Q?B0/BZFLuBK/AMe9xciKs2O0q4mAhLbIfpI2Vr+IAZVRE1R+gow6TE3xWXGfH?=
 =?us-ascii?Q?hzux1HDXZ0OsFWKwFBUpTVuUhA/QLZogdgCHjcblQniuNbDd3S8oE9i60R+y?=
 =?us-ascii?Q?igf44oL4HdFDXCq7JUCzdcAzZELi/9g0XO9LxfEaJl85WemlBKuirbj/vybC?=
 =?us-ascii?Q?QfKXwtSF5RqWAsT+ziYXc7FSKaXKxuiAaGZrgK6KQHr1/0u+9AdDwHOETaNM?=
 =?us-ascii?Q?GvuwfyaMN9VtO8lT8axwD7WLSZoLhj55rcPjKW5VOJ5S9IAw/2ptpPwXmmMp?=
 =?us-ascii?Q?4oJUfBme09txnh4ii0Nj+3RUYoSZd9Hgv96tPt1YEwv+t7SylJacg/p4nQfv?=
 =?us-ascii?Q?ufSUbhI9KBd1mQ9/+Nsy44rJkjwzEdxk/CRAeBUV55BX/C3+5BbYF8nWdFsh?=
 =?us-ascii?Q?wvcMZKHAocTJI+ih+L/r9oVJlH08NKxVb1ut4nbHuGwL0xvRH/BTtZwy4sba?=
 =?us-ascii?Q?tWVFQQ0IdJAUCuX7TMGLGNqnqYJBID8HMqNJEclNR8uZ6BvJi7qRHMJekKI8?=
 =?us-ascii?Q?zh5q59fj0HtjYxm2H4Xf9A/EEhdgxsK4m4iYeJWrxnnWPn7c0bi7Y4EdUtM6?=
 =?us-ascii?Q?WoNArPS0dvWSQ/QZ/iA0h9G6xKR5iy/oMCZXG9uOZiOh9ROLnDU8Rbfl7Hq4?=
 =?us-ascii?Q?9kQVlDvXS9mvWKUCDcj3yXZtCMTj8XU68br/WX3u3pnH39vvZ0cFLqntaTmj?=
 =?us-ascii?Q?R8zZyGL9FycV3IIJ26YsD20clhPIWkjomokjMuQ5ULj/ysg0RIeOuo6CdPO+?=
 =?us-ascii?Q?2WR4/wK0Vb5wrAww6HD1vQNXvBhlGDVVuMTXPCHzr5tr98rfb3go4aqUIf9O?=
 =?us-ascii?Q?MomIvHnpEDKTBTlQd1EubwxcfOb5DAQfSPfZEcSnzBuS/QwenPxIu1cAmpND?=
 =?us-ascii?Q?IUj02HMrYgZeMhG94Seje7KGekhUeTevldV75FYUNVYiHlsrU/5NRF3/ZwGd?=
 =?us-ascii?Q?8j3dWFzFMPgXOQYZAbo/WTOSXqmA1y0YybkxahWgiDECH9ce9cA6QFK505DY?=
 =?us-ascii?Q?OPq8yzCOAcCT/nYZFISe/0Kc0mMJaqECKOnMSg778qaX0Zmreu1z3HujfNPr?=
 =?us-ascii?Q?tj1CwayEK5Qxecj9Gs1kXlecDhIYR8WSoOxL5RNcckuxmon2+RMdCyik246Q?=
 =?us-ascii?Q?E3wKKkabjcxJj2CQBBuZFLfXu+rY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sF4R7J98vMw64bRtDEuJSV9Q7Fdcm3kJWebMIqHIElteOpEyOcjlbO1VjU0j?=
 =?us-ascii?Q?PQ7wQobJceOWO3SAwR5l/Mbf/ihyZTB8qARdYtZGCSY+jmwl/FAL7O8B054t?=
 =?us-ascii?Q?4gawd6HCz5k6laq0liqeyv+/O4pcv/xx8a+kDTzBSUQf87I0OQsJ4k98l7TY?=
 =?us-ascii?Q?kZ+0/mkaENZ/KEQXN1AuGamrG/vOSg7i7jRf18/uM2cGJpZenyE8qnNIB+5d?=
 =?us-ascii?Q?AvmLbOFW/aDDg0M7H1NP9iGI/JP5i5YpPZxP0/vGOi3O8+z4gEHZsb50WqCa?=
 =?us-ascii?Q?yRgbgp7t2QLpYq5UIa+NFKxoDLNZV8MwOIxyS8vNwJVSmuWX0soeeLQVw1lz?=
 =?us-ascii?Q?p+y06/MhKdk/dB1HJ2IDuKH1oLu7w0dM6t3ghq+wyC+jXlB8lho42RC/uERg?=
 =?us-ascii?Q?pdqNvDm9a94YxB9FCzyatlguh/rbXQ38/3QEaIPqt2jmrfFQII/2YRZTPELK?=
 =?us-ascii?Q?WGTMb+BYHpRprJbOq1eliM+TXEph3QpgCtCLYX33eOCMDf8dB49FU8f8F7pK?=
 =?us-ascii?Q?NwOPi7KvoWAN5a+xDGdUmhtN9rbU743eDR8vP4JnbWiIcKHL6XKh2ueUTmAt?=
 =?us-ascii?Q?JYW98Y2hTEVH2Btfol6avcf44ol4JngdOYwRhP8W3lDqWnWtoUpDlp8YzMZh?=
 =?us-ascii?Q?zXgaAi//W/9xK1S4uQlcBWBZ+7/oUTluq2fqduaFj4mFkbCDGtH5CXHXcbNs?=
 =?us-ascii?Q?mtSt4T3vt5cJCufrBwWE3KvXcTgga6dWyiKGBXs4IuvfdIO5oy8MEG2HRdVj?=
 =?us-ascii?Q?b5vAd8Ch8w1ZwqW+qLWtfGAUVKF3rJyA2XwGeBk3WL1kNivKMet8ncZrcPdv?=
 =?us-ascii?Q?9G82Jw5GjFZ3GRLFwSEP/j+I8FTM7m2sQh5edcx8pyR6/t4HnYc++Ewminzm?=
 =?us-ascii?Q?i/5Ij5hwlgpfAGquwb2P03Y/RZVAtOjPqTTFwHPh52gHRyG0AXOQgtiGqFu1?=
 =?us-ascii?Q?LxR/eMtthUkj5zwEtr8wCjj6cGdOmzAdWNtb7uXpR3foqA1j/B6UaVRl+EUl?=
 =?us-ascii?Q?RJ12loMRnGKmztNGRfH+aS0dcZy+3vBFjMKisNBbHHX4B1GUsUea+D9o9f6k?=
 =?us-ascii?Q?pyjDl1PdrsyTSrCr0g/WX0IADuPkWC5bSGRhxe0xh/pbMbv2nNX9PElzS2Dz?=
 =?us-ascii?Q?Sx+jj+vFlVcii5eeTZ4sbvzfF8Fy4rafr2xYeGVd7Z41pf4OWR9ZaYPAn8Lg?=
 =?us-ascii?Q?+O7Uz0eH9j0tQJI2PyO4BDwNRGkzKbv35VuMKR81CAusQ2TAbfbnmkZCkrdR?=
 =?us-ascii?Q?xmJjTmm4r9ftAf8jy28drBnDQQYN7NBa6MlnezYUtiZRwhUkEKUohEbbY0+e?=
 =?us-ascii?Q?EX71P578u3G/MjX69xsWmoVbhnS3nd2eANuKTG50I6ASiD+krnhpvFjxVsmu?=
 =?us-ascii?Q?p4qmxDm08TMFD2/jtQXE8FUH0iCgddLQqXRqkGS1uTrckzRSD9XJLorz+bKd?=
 =?us-ascii?Q?S5gKxmMX2LHSXlwq4OsKpQxEbpsxQEFOIX9pqzO2d089+YigW+X61wuj6gSN?=
 =?us-ascii?Q?K+ucuCZvM86sVCFKQrrv+VVFRGUglA1Q7n0x79l6Oe6Cz+/VRdgz3tsDn6it?=
 =?us-ascii?Q?sTpZmUx5X4PoOgM20Q359Cl+1fMbEX/+Bz0oBrOa?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 111cdbc1-55db-4fb6-9a78-08dcf8c90d92
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 09:55:58.3336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wvTIpyK0DleQqTPyQcTHoAJtZjU4knFQALAFij96XvZPnlVMmlOEdXhlM2s/RgGBRerFDvxF18IBEkC/QEA7LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8912

Add related YAML documentation and header files. Also, add maintainers
from the i.MX side as ENETC starts to be used on i.MX platforms.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
v6: no changes
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f39ab140710f..9ad6c9aa5941 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8996,9 +8996,16 @@ F:	drivers/dma/fsl-edma*.*
 FREESCALE ENETC ETHERNET DRIVERS
 M:	Claudiu Manoil <claudiu.manoil@nxp.com>
 M:	Vladimir Oltean <vladimir.oltean@nxp.com>
+M:	Wei Fang <wei.fang@nxp.com>
+M:	Clark Wang <xiaoning.wang@nxp.com>
+L:	imx@lists.linux.dev
 L:	netdev@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/net/fsl,enetc*.yaml
+F:	Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml
 F:	drivers/net/ethernet/freescale/enetc/
+F:	include/linux/fsl/enetc_mdio.h
+F:	include/linux/fsl/netc_global.h
 
 FREESCALE eTSEC ETHERNET DRIVER (GIANFAR)
 M:	Claudiu Manoil <claudiu.manoil@nxp.com>
-- 
2.34.1


