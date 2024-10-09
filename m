Return-Path: <linux-pci+bounces-14075-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7129966A0
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 12:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C718B27F52
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 10:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE7719342A;
	Wed,  9 Oct 2024 10:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ft1aZ0DZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010041.outbound.protection.outlook.com [52.101.69.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0FE192D9C;
	Wed,  9 Oct 2024 10:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728468441; cv=fail; b=PjPmUpjh61PRPRV+214hVkBi1JLEBk70gjZsokxcfuswMPjBHn4IAVOHNwRogW/lfv/2KOVV3pLQq6Dtph8zjDoDUztsxti2/hj3zXhVtubeOuOHy+EIYy1LOyCJlNtaQmtZzEXtySqMgwv8SW3E7XKZ8HXFWnmkM2zlC05Y3N8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728468441; c=relaxed/simple;
	bh=weSCN9zG7iBIp6zrkmqLo7QdDUNzCWe8o4NV1naB9cw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oH1hP9BOqlhgRAI/h9S5ggamojFAJ+kkhZPWCKQO0XqULX7jE6hPNJJR2W9XPM8/JjXEekHgDgJIvvCDVYiXmOFxHQSQ6Rz2Ae6wN2kIwCS7QNfupZnfConxHgtZY2xOjnjocIEZ8UfzpbODu5K7Z32LBhpb2iuWBaRsMfNjPtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ft1aZ0DZ; arc=fail smtp.client-ip=52.101.69.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q1/LqTZrXPWplfLPLZEcimsMYMeJUMcDSEVJExOBFAoVp2ftD8qmusNl2B0iRVK6eys1KaqeLF2kpZFPREsW6/rPWuuGKAEi8aR/PrhVmplApqSEjlwQWqdxATs+icTIJ9rzcI7YtY4nATVDC9gZxfCU0NkiGK2iXZ0+NLTVyoUwFGbdD9gb8HMAJ86z7OxXM0vamstpIxYmt5UNdjFGWSmbK23kZK7PBv0HAshqT4qkT5AW0q+vffoCBMlyrJLBtVoxm+f//JGuW05YQrTnWXZIu6mjVaFIgQLVwSPEgPn5cnrmY0cU2ut+MMKSbwdB8uqmZwmA61b9qysDw4Ajbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ouYYEcN7jMGRej2v2Wseaqn3H1P7s68N2zSaFdvODm4=;
 b=LRbj6HE1ZGOCFGkaOL6yb1h1olLaO1OcNw+nXswJryYh7Y3+/mWm8jV6mhmIRHn8MwPonLIlL7RzXY74fOYxQAHjl0fLigFaf6chqv/EJB9th/OuNgHwtJp9kAbDEMaL2dRtsDaW8BKoCKe/r8vhIy4bFYcQln5RUxcqJSfKKLF+p1nL+YSI+PzV8UN7HXhwtTlk7YI5ZUb02O25Ku1+P/HoKjEtWK66QMQPwbgAHnAoEETTJKK+63lBoEQcOulTKSDF3DH46sgDma5CvIhjmOW59VSZeuPL3sN9X01zTl7Kqsq7bcBgKTbosJ2/YNqkGjfAXefWoSNw36De9xETkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ouYYEcN7jMGRej2v2Wseaqn3H1P7s68N2zSaFdvODm4=;
 b=ft1aZ0DZHPiEt9gpVJ0VT7tKe9PIfCGQLNT3clUsmo8jDR8MXJhrOrOd0xjBOTGp5Gx+CDijkVGOuEoojqaD7usXN7EfTQluucvenS/Mu6eKSFT7tn1qHFQHzFcNx/lN9Cc4LF5jUJxN6YmwXlsuMTJT2+6QJA21y+FcYh2YwJvq9dXoveMB67dcV6P/dM4InIZMpaM2z3tEqhi62RkKFZ2OG0vt7/pAAm4100P6/jiiG2R4/gFcdjt75KrmCCwfBuPhvWAr9YmM/3VjjPwtKbxVgIVVfB5/3NWmmPlcOwxNfCYRBmtK31luM6c6Koi+57x+1bhBP5vnn8QEqhabcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GV1PR04MB10154.eurprd04.prod.outlook.com (2603:10a6:150:1ac::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 10:07:18 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8026.019; Wed, 9 Oct 2024
 10:07:18 +0000
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
	bhelgaas@google.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH net-next 11/11] MAINTAINERS: update ENETC driver files and maintainers
Date: Wed,  9 Oct 2024 17:51:16 +0800
Message-Id: <20241009095116.147412-12-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241009095116.147412-1-wei.fang@nxp.com>
References: <20241009095116.147412-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0175.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::31) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|GV1PR04MB10154:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d3b6281-b50c-4f04-d1fa-08dce84a285b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|7416014|376014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OaV2M3rVNzb3uGu0w2uCB2EZSjn4foNHSHxysDATLJ/BODMOHkwRiau/QY/O?=
 =?us-ascii?Q?jHl1mRrsycTAfP2q8fEXuTm2LV6TjQDzJf+ZgT4mBRa9oUnLcPll3MVu/WTI?=
 =?us-ascii?Q?sysGPjgS/jXRAfDDthgCooFIWZzDaObo2q1TezaC9hWEa3WltgAXZi98AITM?=
 =?us-ascii?Q?6+wSbs8iqNpMR97hxMfZI/I7GJ46tvdIbigohLnNtMezVoW/InW28Mijhc7l?=
 =?us-ascii?Q?DtdGrU4wDvTn5DySBcC6ArQoznOZJTN4TUIAL6/i5bLlsPzjPVTiYxvS/T6U?=
 =?us-ascii?Q?5d3BA3ywikMj1r1AvVkBXIj0lCe3GTsuPz2QBho8SWV+lcIAQgXoc6/tvUT0?=
 =?us-ascii?Q?vZDkxA4/Oqa5ne7xhQh8EmtkNanNA8XdrtBslFe0nfjubJ9J7yVadYfQhLlB?=
 =?us-ascii?Q?YHlsDsZMTNUebnx1ATiuw/HNnRMI0hXmL6bQh/BNxhxF/W9aHPl2XfIclp5B?=
 =?us-ascii?Q?24/Yry7iBFlhUE7MxqIHidoriu4FxhL5eIIEqk2xOMqJeDH0s8WtliMZYgf2?=
 =?us-ascii?Q?YmHWJdBMm8xkAywaKxvGh5N8zs3z79e3uDtyyhDO/s3kZQ0QyDzqahFP95+S?=
 =?us-ascii?Q?RaZHOQhQaKTvKuDii+rqIRsAske8NDzGUiiYohJDqZUNRT/Dk1Kt4OeM/LB9?=
 =?us-ascii?Q?+VZW2iYMFbg0PcfzLTEflxSvNw3ATrA9+WkxeJMBHm7SVBV85IOSBfCTVjiU?=
 =?us-ascii?Q?PhvWHvfZPEAg8M5OcpQuNQtTyEWXJMCydlPaVvu1j/cutG49FlvLKbgQBlIF?=
 =?us-ascii?Q?efYUdfXkKlzl5MywLcGCbvOzqAXB5dp//U+5JbxSN5uKsbavXkEMXqp5gtb1?=
 =?us-ascii?Q?0a8sousabcZgU/il51tUEK15CrI0+XHS9G93AKgE2PIQnxBNbF1OV1ek/Bgs?=
 =?us-ascii?Q?38LOZQNNMFEQ8Q+LktG4haiZGOXNMm7uxRAsAfKafV5dkvFj8HQJzc3T+emh?=
 =?us-ascii?Q?A+mXJWxoWaR4Knd543YFzugN1oh4mjjMtG4Im1h/6iEU7KV5aoWgoJ/WAkmh?=
 =?us-ascii?Q?FONqYexW03Mq4cGSBBf6fxAFR0yA5S6lB9UNiqvAJqvD0/Gey+2h9TA2+C3C?=
 =?us-ascii?Q?G7UwXhO+B/pUI4FWTkUa8+tZozAl141R8Z/qwy2nzSF3zzV/VDvwjc3hs2/N?=
 =?us-ascii?Q?npibEU+Vg85aNt2D+rRFS9FrJ9MN9wRhtoGlMQOlLXuoL0LfVjaJfruqvx7a?=
 =?us-ascii?Q?DYSVMkE0D04lncM5z5T1ghHNIYvkHYIsEEsNeEf+4WChT0JH9CKEM7CWjme7?=
 =?us-ascii?Q?1ONUXvInVx4MDnCbhqsdHmmgexLD59HhlJMzuk0N2K7Lx/0ak/z9v4T/DOab?=
 =?us-ascii?Q?faxzsF2E/hALEExknEncarqBtjGsXvEyl/V73SyQriiix5APm79qpjH5EJu1?=
 =?us-ascii?Q?z3pCFRY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(7416014)(376014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OWFp0Jfh14S/dQryiFz19fdUCaI3HOt3qtJj51mUcDcKOO1xcMIF1F3Y+BK8?=
 =?us-ascii?Q?nTIie/21X/fZQysuOEZeu5S9zpflQfAqZlljCoBy0OWUTtVGhEhDNenRKZoZ?=
 =?us-ascii?Q?Sn6y4GdmpC8nZUmV2Wlqyd8udb+c+h0VfIe5vTDoyiFVc1XnkXcwlPCWsowW?=
 =?us-ascii?Q?zCR0+pTcurF7ScvIsmkzvmtHWjZj3AqiHWAgS6IbQ0SGdrM6t36j78YAEipU?=
 =?us-ascii?Q?Id6ypzesqFyNPJxqnOMU2VdVqcETOmPPYxtJCbQmbhYUzYZoniDyM+cLHtoD?=
 =?us-ascii?Q?HOholtkuKo3hxkJ84uebz5pHWiGtxkRhnQ2ViHhWFEYPh08vvQkgpN6qU8GK?=
 =?us-ascii?Q?Q/fhbk5bFbu094MbqCEzehFdi8kIWGovg3B66FxCT9thyWIhIpoMhnDfwG1F?=
 =?us-ascii?Q?a25Q6cjnrQzl+NVB72Uns8vlVcWfNsQa38phJd0Vy+8Oq7IJp8MW+3ryjxQj?=
 =?us-ascii?Q?MdW3JcWRxW9d10sbVVgzbC69AaZzhqTtD0qVBHhF78ZOmSmpuiYjJfV1DLx8?=
 =?us-ascii?Q?s9fpRZW1IJKR1vI6f4OWNO6cwzp2BAMHK7b2/4kiUAXyV+Afg9BDVERtsHHf?=
 =?us-ascii?Q?GY4iuvpcJzbwkCqEevFPknN/xFU4yAa/fVxVwnswg1LKih9upFkyEnwwUhus?=
 =?us-ascii?Q?2b3pf9GUjy/3ExVvG9iWE2o+tu6afGCz8cNPsqiMTUP3AA4zq4R/HVHf7SWT?=
 =?us-ascii?Q?Ew03IJoIuEVJK3reCdyBjyJyC2io7OTKMQ/wHXdBAOTzqwtUI/19jf2Dzxxg?=
 =?us-ascii?Q?/8Vn0uTFg3SafRqkMvDyFJPjy/DARs12XU9GoKgdqGMuJ1yorbHGlfupoGnA?=
 =?us-ascii?Q?mGwME6iR+LuDKdhuLyU6d++hmpC5+a+1Xjw0342AWiFINNTneCHOUEjDeJKf?=
 =?us-ascii?Q?AYR69OZb4hfHITEW7/Rz9bD/opeg1C1ByX+YKM9l8o3TKk+zQNLCQyDFQoR2?=
 =?us-ascii?Q?Qz6NV+KVOfCpwp0A6Ak+E3yBup4naRIYZlBFv7u5zPBkgHAFysZHhYURBMT7?=
 =?us-ascii?Q?gTjHGn+DZ3bOt4ak3TOoAeXT/z/SfetPJziLEkH/jLmOzwylPoQj8yT13Fkv?=
 =?us-ascii?Q?0l0FDAC5fcfR//FHagMTU9NjhJr7nYeMXLg6SMOCG9AmZEHjJ8W7wyPrLbqx?=
 =?us-ascii?Q?cN8H9sQPoUAoC7IXBJJkk7PNcXDzqd8Cv9BnIpa9x5agDE+A5JJH64MmXlGm?=
 =?us-ascii?Q?Q++MyE+FkljGWvhXcMLHSqnTOvLacx2PHLG3ZQ24qka9Sge7rLhx9mL5Hn+u?=
 =?us-ascii?Q?duIgMFOqLe7qcEXj+AAA95QdEIexrkOne1fdYeAUNoUlfzVClY+nXbKwRamz?=
 =?us-ascii?Q?m1GUJYko07CMwddgz/pRMdW6EdM1Klq46c5oZJHAb+haIlHeHw7hUx2j13XP?=
 =?us-ascii?Q?iusu2W0P4sPkJADMg4WgL1MwjXMVvuMbB5n6k7WOSzDyUg/Euy+lwELSPFES?=
 =?us-ascii?Q?001GAYCk5hECKs6xdccH2+7qsnc8tCLQfIpkra4JPsHLD0FMqXcRVjtYlZ6z?=
 =?us-ascii?Q?rxoIsa5Kp1YhkEBQpJW0nbNlxgJqluXluAb42VPp1iUxGMpnXSKNneO4KPP0?=
 =?us-ascii?Q?N/XE87Ex0gjqR54HheYC0V0ZyRy416H8tR9rthJs?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d3b6281-b50c-4f04-d1fa-08dce84a285b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 10:07:18.4864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F2PxH42ktUYjBDeYIfs2Ae4vWYgxEeTiHG0nii3sdn/uzHOz4NG+Qz4LWAAaLZZI1wVl/+59u6XDhHIO4dED8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10154

Add related YAML documentation and header files. Also, add maintainers
from the i.MX side as ENETC starts to be used on i.MX platforms.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index af635dc60cfe..355b81b642a9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9015,9 +9015,18 @@ F:	drivers/dma/fsl-edma*.*
 FREESCALE ENETC ETHERNET DRIVERS
 M:	Claudiu Manoil <claudiu.manoil@nxp.com>
 M:	Vladimir Oltean <vladimir.oltean@nxp.com>
+M:	Wei Fang <wei.fang@nxp.com>
+M:	Clark Wang <xiaoning.wang@nxp.com>
+L:	imx@lists.linux.dev
 L:	netdev@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/net/fsl,enetc-ierb.yaml
+F:	Documentation/devicetree/bindings/net/fsl,enetc-mdio.yaml
+F:	Documentation/devicetree/bindings/net/fsl,enetc.yaml
+F:	Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml
 F:	drivers/net/ethernet/freescale/enetc/
+F:	include/linux/fsl/enetc_mdio.h
+F:	include/linux/fsl/netc_global.h
 
 FREESCALE eTSEC ETHERNET DRIVER (GIANFAR)
 M:	Claudiu Manoil <claudiu.manoil@nxp.com>
-- 
2.34.1


