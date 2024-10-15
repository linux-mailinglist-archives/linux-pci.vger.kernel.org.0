Return-Path: <linux-pci+bounces-14545-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4007299EC40
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 15:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 644CD1C2363D
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 13:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEF52296DF;
	Tue, 15 Oct 2024 13:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GTfraEZd"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2061.outbound.protection.outlook.com [40.107.20.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4582296C4;
	Tue, 15 Oct 2024 13:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728998063; cv=fail; b=bwqv9+e6tGvd1WDdpcUkUCOnfF+/kassabZqtuLRVwWd8vVJQLyxnYOfUkJ34TorR5YUocOnv53JZbCLuDcaesgplJxq5xlUIE50nD3KunHZhqsDJQP1G858N4TBjhaFY4WoX+m9CuNSKGlEu+APM9Tj5iw7OvZKDcPl/B/4f+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728998063; c=relaxed/simple;
	bh=pU2YNBmHM+U2yQDpWC3Rl0BuMrBjCvTVm1O43zOFO3g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LrO/jQcBGhKKblrWMwdFXLBGVRfuPAMJWNP6inJwba8F1gLQXziS0tFBhl/uHD0pU6zCLc34DF9/KX/FBq5vbA4ca8Szs2LAJcFjQRoE6007l6FifRmZzY5dEGZ59FfIFJVuaeWI4hUHxm8eCFLSmCi6lD3vVZnJ9w0Ft8M5BR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GTfraEZd; arc=fail smtp.client-ip=40.107.20.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lRPubp0QW8g072h8X3banPs8SzmtU+hhzHy6puEeNtUlwqftRsSFSZuOSTVFsxky6jI135JULMllbYhMo2+yWMK47dQarmDlcNdC5UQVtbx0FWalXDAKvzKL/Cxo3IDNwOBPA4zCd9xwIi1g7S6sfVPlJgKnXnFfbeIVlfn+US4pZMnt65yz97DxBMU+P1k+nylIOKI5K9YpvuHxyziAV4oB/r5cyTCra3jLlZpYfFXp+6p/HqfP/9RlUYbmgCEstvvuTtAX/k076+dGy/U7HVHY+hG3KZPqzpf/p6qt4eck6WXBrtC/I8ZUvgmjeteqbgAXc1JgUCrdaXHSk7grVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3End52Pxbygyt0TkRjAbFp67xxEV7s/gKNgMqwzW35o=;
 b=PMAIZbzeppMRAizUx/18/0ZgvV8mqNM1QhT5LZUGWXZisXFY89NgvSBwAqshyJSmMuJN9fHpm55TJeUBOLq1Bq8knMcAU6ZdORQnpXSA8Rz0B5BOa3VCTTSUOa4MYFUvgbE6H2/bCUfi6pyc0m/hbfceuNflWBfAtD2VoRYlVfOoaHF6bGy43HCSdK5XlAmpZAFQO1xLHdA3wAvCkpQGfUn5xPWaUAffwjsGJpELasqV1nOF+UVEdcUp0tQ3HaZg9fqEawnzpmqnhKKVpcwDFnhqusbCg7jrhpuXtv8eK9pIOVc1HSLqNFkUS95cCDUaIWYer+0diBdeWh6yt8eE/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3End52Pxbygyt0TkRjAbFp67xxEV7s/gKNgMqwzW35o=;
 b=GTfraEZddNEoZ88XaFcmTdvyYR76mbI3/U4XpXOr3smDFkoTEN0grpHTbuZvcAL0/yiv4lKsVJmhK8Mjn2gVlwPCAlhS1vs8eaf8dxEBYDSxtN4aPj7s3lgOXETw5aKfONBl4bq6Jw2mJRK7CswdwPLabCYVV016zEEWniz3hPJzNrnOlTZwtI+1zNIrr0bepCup/1THFXghLgNXF2KN9F4ze88iQa3TIZPskWE8oG9kbLb7EVP1SrudBy+aaIatlBan/cTrWqMuh/JKCb0E9jf3xmJLUvxsWWmsmyod5dQhzCWfoiYtUrKOdb1z4mWXHkxr2X8jyCCk5d6Uj1aYkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS5PR04MB9876.eurprd04.prod.outlook.com (2603:10a6:20b:678::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Tue, 15 Oct
 2024 13:14:18 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8026.019; Tue, 15 Oct 2024
 13:14:18 +0000
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
	linux-pci@vger.kernel.org
Subject: [PATCH v2 net-next 08/13] PCI: Add NXP NETC vendor ID and device IDs
Date: Tue, 15 Oct 2024 20:58:36 +0800
Message-Id: <20241015125841.1075560-9-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015125841.1075560-1-wei.fang@nxp.com>
References: <20241015125841.1075560-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::14) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AS5PR04MB9876:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b41275e-ad6d-4f5b-2452-08dced1b4693
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h4Ejup050IFQTt7nklzCQK9uMsbBDohREFMZNYxonXkB4dreWGt8v+BgIWnY?=
 =?us-ascii?Q?sAJja5qSguQWOzAP3Biny2tJ17/uRPxp4jEhfdfEueFDDapjuz7W7lJzfU4e?=
 =?us-ascii?Q?LgmjKrtUXy42PXbd6AcKIh4dHBWWTtMpNh7xmyzxZ3G2Ws48vs8GRG0I5r3b?=
 =?us-ascii?Q?QocoDQYW2srWLW0tgX+2TUDfAJ1q150XLLNj3GS8SS99XFDsqDYOvhRMIvQj?=
 =?us-ascii?Q?gBkH4WXJeA0tVJ3qLbGtDvk4TymSYHsxruDXEDq0vqGbEIzO7xbItPLzZNF6?=
 =?us-ascii?Q?IUCNWR9Hkcdrn+98SClu9kTFXX/7JXV6/izms6bRnmSMDnnD3xOTCSHCWGQ+?=
 =?us-ascii?Q?WKwQ+QltUGNPcMRNH2WjlTsEOv49+Cre/qBHJadynX/q8CrKs8cptLrou1/A?=
 =?us-ascii?Q?IPvybZXn19F9yV1KJZfmFoquCUrHH8vf4z32BH7EIXm3LwvksxfIM2fk/VTG?=
 =?us-ascii?Q?Yltyg7zjeeC6H14VKjZx7c14uP2y5jrkpv+NmI98TKohmA61MBQP9Ik3GnZ+?=
 =?us-ascii?Q?uJfRFz+O72LUTft2oxo2IZLtfRP0zqAs21nzQcGW5aOphHQGQmzKEVmqGc02?=
 =?us-ascii?Q?YCE0Y3VFIfU7HjNxMA2DdY4LELDpqSFmyEEaRth9WYNGQJNGAC52RezTuJzT?=
 =?us-ascii?Q?XQY5q4/JKZrFtm/HuKUC+Ugo6eXXBUzdATbmN00R7YlWp/exOs+rarjej8iQ?=
 =?us-ascii?Q?20U+w4avutuKJrexmF2+JZsN7uZ8YzEFe7SnWiQXb+bHFgNI7ozkVKj4RACS?=
 =?us-ascii?Q?X0+uHaM+oWaCYEYLhe+lPPGgjmXIBHPMiofH1OfTnwbFFUaDiRikSnPlk6yM?=
 =?us-ascii?Q?uuAKFV2j5K5G0G5K3WCehbRQIKOnsKkl0wZWkcTb+qQn6gMJdKyV5FJXBJRd?=
 =?us-ascii?Q?KvoA/J9lRde1z1CfL7cr9OvZrh3pKZRfs1abOxW/pJl2q/ukczV1X8Ug8djR?=
 =?us-ascii?Q?b/UowjVWiHklVZWR+7diPIZHMP+4xg7NgIjPS4U1rys46Q+dj7oYWe83KmBz?=
 =?us-ascii?Q?Zx95ppKN5a5hzzzklUGn8t3V18WeZVyy7oTK4DckB1UuLaW7s7GPwGpiywAa?=
 =?us-ascii?Q?t00rECYcaFHt71g19a3oZNDpQyTZmSH0vnG3ESco9Q8GvMH4cgEKrU2c6whw?=
 =?us-ascii?Q?+3obvECP6uYU3rLTuyKG3gaoFavoqSlQ3yIm9NdSutEZTJ43Nb83BLB7mXC0?=
 =?us-ascii?Q?2+1SJpAz6TMJsg5JxDn63lskMIcU5O0t2+a73+P6FyOi2iF1S4mkR/JQkrpu?=
 =?us-ascii?Q?KkxTSD/DX9WI8AnDabJmfTQnoT2ukCPHF4NhJEaKu8w5/Dme/hijQWUa+8W2?=
 =?us-ascii?Q?nkBWCTQ47fp3JmJ2HK8QJvVDCu5mK+z0RndybyfEVPbG2rbEirrQVsbHlSEy?=
 =?us-ascii?Q?0JNpGa8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W2DEqh286uvTgfebXL1JbdT6FSRNHAgHK88VvwODYOCbbmCGE3xNqJpxlpwL?=
 =?us-ascii?Q?DyyqWVNMetR1vra/2YcBstyNNUzW3uXRGHsBZxu/IuQwEI+vfuEmRwWMYeK2?=
 =?us-ascii?Q?kE0Wdn8eHj9A5im/l076i40QlKou6AgSMDwec3bTMiNI3trsK77a7yzitZyJ?=
 =?us-ascii?Q?lk3nZnk2QoAGzCZcMsonMCwlv9cAmtmotGfl8xIDa9bg13xoIBRXclqp1n0R?=
 =?us-ascii?Q?IA7GQbi5wh1OvJ5SKlfFO+9gWx5CIym7h2BIjvcKq/x6Kk2UNFdIsFAlTZjX?=
 =?us-ascii?Q?DX/S3FTMjYJm9jbHvKb6gS98Xz3Gdr3TKYUXcBc90eh1KmZoLocHAjs++2Cg?=
 =?us-ascii?Q?wgRdzm8pPAJjx44bmmAcRBYwE8M37gg3f2+2DW1Of1ePDkbjVogzJ+dhegEP?=
 =?us-ascii?Q?EyMaHbIfM2SlJXwwcQNuGw5e4snj9s35Y3jsEMjeGPactChgosXylJtRF2oB?=
 =?us-ascii?Q?KNrRxzlV+wpi6HJ4ztppzFxjhulsHp1AWhjIryBG/3+qhV1GS9P/DXCGg6Zx?=
 =?us-ascii?Q?c3CuInBf9VijRAsOSrXw/VQIP4fXgScYeyQH/GUbbwdffapX0EWHI4kugOED?=
 =?us-ascii?Q?r8C18cHq+6NTv4/VUiucORevHktHl5J5/waTR5Z3kWxYer0K3VYnvBY7M7Pl?=
 =?us-ascii?Q?XUYZBy3Xtej1taAqmVUcmNfu+2CAfPhYywAJFaZfIYyVUbz6lZ1y5Vo4DgE6?=
 =?us-ascii?Q?9vj7Stgb+QfSB2LQSu2+zZ840khOhxAo60ejURvSYmfl/qMhJLbM84zu2A/w?=
 =?us-ascii?Q?zQqRU9SE3YAlJn4x6xe5g0m7U15wMOohNvC2UucUHM7svfZy9wdCOHE69vGf?=
 =?us-ascii?Q?zKg1rWV+K5TSPUEnYQVrE8xrq3jODFBjVMl7kjMSIldDHx8u+liz2+S3ehu6?=
 =?us-ascii?Q?7rwYc1bZVp9xD2EXLx2aGzjG/LWNT+GBdmzVfHwiYsWJphiBoK1YbV9/NuBp?=
 =?us-ascii?Q?tLfv+eqC7db1x+vrZW2n41uFrJEFSYwUnbYeVTFPA/o2tG0dmOuWVUsOh1lw?=
 =?us-ascii?Q?FIB68eE5fpRcgLcBpfUT6BEhsihFUQo44oAFcaEU8l2AF0hS9BN7yoeqhrj6?=
 =?us-ascii?Q?vnWfohCCO+k8qlJBbv9S/SjW5iN5zAIn58A/Gik7Ow69P+2PWhMFF/zRNzli?=
 =?us-ascii?Q?Ml9kQEyRIpjM7Sq92RbL5OcblV7iSDV6IL/NdItlJKRpTqzINF17FCvm21wv?=
 =?us-ascii?Q?zlRtdZjqDsAVFEUtVE1GTR7EJJ1R/lPKvYFdEumtIqitmFtJtnKnLwdjv7rv?=
 =?us-ascii?Q?eaYKK0jXfze2Nal0Ncg5dDfXNG425xSVXszNmczkv4Y/UdiHCy/zebfNP3NZ?=
 =?us-ascii?Q?RTUgilVBGH29alTxXPGRIP4PMlvyub7kRrBgUNkhGhQXcu8/X4I9piLZOrQ7?=
 =?us-ascii?Q?V7Fd1CDtTJFw3C78AiEW0SpkLjYJpyMLdbsL/Sc3nwRm+2CqVZNS+uFHfTRR?=
 =?us-ascii?Q?VYBvVRXbDPerLjkzMcKUXPOgj/sQ7npC/sb6cmLYzginU6mZ5V3DlsGxHTi7?=
 =?us-ascii?Q?3EHhajLuBppQVdh5sTcRPj9ilbf13jlwwn9/2WdxUrZj7iHJPnpGlPeOL+D9?=
 =?us-ascii?Q?0lUTn7gGwhpV664F02GME1n3t8b6pgKrOGUVnIhE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b41275e-ad6d-4f5b-2452-08dced1b4693
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 13:14:18.6603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fPyD1b7/tIN7TbdeVQU9yFAHV9l00cWp0aSbTjEBlF0ufmJeFjo4bqcFQKTilNf0YTt/uSwhvvxKLLduGE48DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9876

NXP NETC is a multi-function RCiEP and it contains multiple functions,
such as EMDIO, PTP Timer, ENETC PF and VF. Therefore, add these device
IDs to pci_ids.h.

Below are the device IDs and corresponding drivers.
PCI_DEVICE_ID_NXP2_ENETC_PF: nxp-enetc4
PCI_DEVICE_ID_NXP2_NETC_EMDIO: fsl-enetc-mdio
PCI_DEVICE_ID_NXP2_NETC_TIMER: ptp_netc
PCI_DEVICE_ID_NXP2_ENETC_VF: fsl-enetc-vf

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
v2 changes: Refine the commit message.
---
 include/linux/pci_ids.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 4cf6aaed5f35..acd7ae774913 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1556,6 +1556,13 @@
 #define PCI_DEVICE_ID_PHILIPS_SAA7146	0x7146
 #define PCI_DEVICE_ID_PHILIPS_SAA9730	0x9730
 
+/* NXP has two vendor IDs, the other one is 0x1957 */
+#define PCI_VENDOR_ID_NXP2		PCI_VENDOR_ID_PHILIPS
+#define PCI_DEVICE_ID_NXP2_ENETC_PF	0xe101
+#define PCI_DEVICE_ID_NXP2_NETC_EMDIO	0xee00
+#define PCI_DEVICE_ID_NXP2_NETC_TIMER	0xee02
+#define PCI_DEVICE_ID_NXP2_ENETC_VF	0xef00
+
 #define PCI_VENDOR_ID_EICON		0x1133
 #define PCI_DEVICE_ID_EICON_DIVA20	0xe002
 #define PCI_DEVICE_ID_EICON_DIVA20_U	0xe004
-- 
2.34.1


