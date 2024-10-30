Return-Path: <linux-pci+bounces-15572-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E61D9B5F60
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 10:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17561283EF2
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 09:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFD21E260C;
	Wed, 30 Oct 2024 09:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PEOhniym"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2055.outbound.protection.outlook.com [40.107.247.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321921E47BF;
	Wed, 30 Oct 2024 09:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730282105; cv=fail; b=fyhb/+CsYKQpOeVHAQ4i2SWeHvrfon5VK1Q91tVpOnLtCR0RVM+OPKQnFypAQMJLmgBLx9jp9qkpU1ue0T71PQYBcy5+qImarCMd9tFOBa9AdySqZn7ZWOogs6a3U0FxA3J+4Ju+9bwpWN+EKJ+CmP5iqlH12tsIT3JiL7ne0po=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730282105; c=relaxed/simple;
	bh=N27vAl0VQkmk/pthLh7J4jKGbNZqaHwAFvpq/UlPCt8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Lvvnv7I2HJIOiydxx23KWdQ/dQaszGsVDXQuBRbuppzyUeVGZNqFhDo/lkAMRBSXx8UMovJ4F9Lu9tiQdto9re59qcxw4QuxM0OtvQun1OB8n1+BSv+IGG4VQ7i8BjE2aiNoj6mEPcQPjA1qgKgkUqDntsmDNLb/Ix1d5Rnj69U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PEOhniym; arc=fail smtp.client-ip=40.107.247.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wPYfF/A49DlOVSiiLqPv7WfdbMx+Kxlpmf92onLa5CULqjgtROln3Ukz0q9+Hg2IpqgIDqB7I9Ka4aq8iwZKWgmMcGm9WcpUkbufHiU40VR5GxfXmXYbRy7BkCXTVLrbj343Ve9vjSRp5TYrS3G2l8y6E9vuvlNu2YRpMgE/02/H6WJVoajd4aWPhFqTIObi0mqirJDH60YMmHV2JLnhpFmbcjPObXx84GMInMlKxhi7UriP+WYJVOF+EkQPjrL90ThO+QW/CcMZNENrqtc0QUFThmBBoVwPUGh8f4tdVWSVNGNS3JAvx1YDRTUU7eQ5wmcnLJNqE8J24n50E86qrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f3gtJW+qT2QgAKXpLuB/j4jIp2NDFcfKLtK+lYc/el0=;
 b=avw1iYnkbswcbh1+V1aDtBPGGNv5mYhNFRSjv3+nMzOulj5NgaqL8vioPpIaTsovlUHN9QQRKvZv8TvwGQ7NLcwxSA38ruUv3TYgJ+jEpFpHUYpf+wQTFVTdlAa2NC1eS2AhQJZyp/PvGzMSTyElQRvatYiwVsEln7u3aUgpEayQ0jiwBp9Xl7QswRNiHHDp36exQWveEFxQiCQTb1AlLgUGPW4Bsm+d+i3nuGLDLjFQWnmcuYmGoU3G6nnO/RjaziO39sEO/oLm1cu1WmyW99QwMzMtWXNExAOQnTT+ZwRfwj6Tumi5cSnIosnj6X6frmT2ePtxUBOCu1pflWOtEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f3gtJW+qT2QgAKXpLuB/j4jIp2NDFcfKLtK+lYc/el0=;
 b=PEOhniymQHEeJbPBgnESvdd8fRTEzdb/LNLtWdFEgfPJhxIlXYla0XqIrRVHQ9oHfSNrFayJUpClpPS74Zgvw5diWpBp4ixCgGbduzV9FQVWshDkNxaY0YSwdhJpkMrJE1Yz6DQuvLpMl6/ohlc43hIjiZn0xLoLuk3V9Xgvo2W/9GAT7DEOBk8tO/Xxiiyh2ZtMJGXLSof4Xh7rD4lPUwy8fhD3wnO3ZxgiaOqSvWaUBRBFnyKCFi/B4pQTsZnTaejyA/RLgrYz3d8giN3DHnA/qqJ7kYEI6wTYqPzOML5ZofOmqNuEA+lKCnolBZq+DcowGgML3T+kOHDFkP8ICQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA2PR04MB10347.eurprd04.prod.outlook.com (2603:10a6:102:424::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 09:55:00 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 09:55:00 +0000
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
Subject: [PATCH v6 net-next 03/12] dt-bindings: net: add bindings for NETC blocks control
Date: Wed, 30 Oct 2024 17:39:14 +0800
Message-Id: <20241030093924.1251343-4-wei.fang@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA2PR04MB10347:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c0f6698-595f-400d-2f14-08dcf8c8eb38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|7416014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D7bJjb3xQIyZon1ZjC85oo9Df2hDJFEdQHfofatILyWsy3STfm/41pM4sABR?=
 =?us-ascii?Q?eA+tYuz2Q5EQjXW5tasrJzgCewplOYIBzXQERduIo626uRTAUV/8Yf8ZGddw?=
 =?us-ascii?Q?xYHYvCPLq+yMiEuyDRAF5HEK0V1nW4Wmoh5wBcVFaEYwBJj3hCA0WOSwWwRl?=
 =?us-ascii?Q?vpi1j40tbNCQhBCYOOHsTsqWM1ccB48KN1NwN3cuxgHagusAUTAqPDmUT+VU?=
 =?us-ascii?Q?Gcs7xyChjtljRktHFd0ooF0wnML4spD+ijI+d8MkjIe/3EligQD4ogzBrHnc?=
 =?us-ascii?Q?F+mCYK9Mveg5GF8XzSawsqRyESffYFbjpBdKw06rHQr5FlV7skmBWxXl4mZD?=
 =?us-ascii?Q?DfDbd3pGNfB34fRWZGbKNwE/CsXDHTwG+GTOo/cWMj525hcug3RpVRyPErJz?=
 =?us-ascii?Q?3ufZMtjNKpyJF4Jntvaf5SJq5w1IKZ/n9GvlVtbh4Vp46R6bEkkelKpzmQhK?=
 =?us-ascii?Q?2h3KeE/tQ/xP+18Y/4vkfOxU4dinUwUf/oGtceb5a/5Ze46M4GesHOx2WDYB?=
 =?us-ascii?Q?FlQc8oa17sbPZcEqfaCQ2ldWm+6hnpq02LPVwWwqjpHEX3LfMGo0opFagYwe?=
 =?us-ascii?Q?UHEwiK6tvTD1deY0rHmKM3jJ8WRtk0rdeu/5BihHxtW0QDqg2jbCcyoXbil6?=
 =?us-ascii?Q?S6Ydw5R077kyfSLKJLS5jdjoKTOZppubaH33Jo0oXgzhRpy5Ss33gdEAiGut?=
 =?us-ascii?Q?RJAgWWYbfyWAfggJ0abuUeXEilYxtCvBKB12P58iEYjlI8/xUOsj6j5lWDnZ?=
 =?us-ascii?Q?BHG5ZYYPJfpzD4hKvIYubdn52uuxnK2qJPbyQC00IJ+oRFKoU0n8C3GwSkDG?=
 =?us-ascii?Q?boC8qiXouIg5exiPtsdDIcOJ+il2Pb1CENhCqq58ZJrFY504GPDjjlf1BTnV?=
 =?us-ascii?Q?38fEan1++3zRxrv/OkOZyc7EXjWJkQwYGU4loJw9eV/RODAzRD3sTpff+XB+?=
 =?us-ascii?Q?LfPkS45dFuZByLIMF7+0GQ86Ki0k1v8xLOitQfA9S6QhcpMDkdPyYNiz/NId?=
 =?us-ascii?Q?j82IHi2pcWyPMUb6RGlsYWR191+GNzbFdmafVFWAIGIugArj4tPI/BzoxLn/?=
 =?us-ascii?Q?xtYImUUtf5Jm5c2QJV31BIEuMl4PG/RBUTlXoTQ8mTWKa3gnCwu6wCeCIrBW?=
 =?us-ascii?Q?yCx8njqT9A/8v+KD0ppEmCaYovQWX8McGnlT90PpPsdzwkKs57Fv75gvJy3D?=
 =?us-ascii?Q?qwpi7epbrnZkpbJ7UaJPou9mfxiGP4dnZYbqWFyEk5peErB8YMhNJHgJ/PXq?=
 =?us-ascii?Q?f7IVHJGglcjQeQvi1LDulAQXYWTAMlpTV0k9zi5W/WMCFvGksOL1GbDBcdSO?=
 =?us-ascii?Q?Ekko1ZMtbVItnq2T8RUOSd7lcrWGeQJ7u9KlFIIr3DOYaQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D8MlbnQmyruiGqN4d/+1e6iHzlHlhCVgOAM7rrpreiktYSm0P15HCEy9LDkN?=
 =?us-ascii?Q?gj28gwnrIYNJv5DsGJNWaYf9e6cHMehYQZ/4Jd39+4VvmAG0ny9F9ZZcsIsS?=
 =?us-ascii?Q?w7MS7NCNC8zPCZYs7N6elVUiiwJPSyeUajsblm0Ba7VlMgx6rIKOGLLlnuVO?=
 =?us-ascii?Q?xyU3hHd0cKTFKR6PEOpOmY177oyaOUjfY65mg6MYE3+vLgbik07l7agqhlfX?=
 =?us-ascii?Q?TfQN0aHAn8MYoQb6tDCkXlpFVuzRvnIh4zqAbScw0bDa7WSeJPvgWRhNM8lT?=
 =?us-ascii?Q?eOK72nEGG3NVWgxOM/V5dNVpa5tFXYXmhxZwC7X+cPL361GWQ0ex71o3dstu?=
 =?us-ascii?Q?ucgHtmCuHeFTEjgnW/8BWh8mCpwxg0pcmUMreT0/W7RekbulaCbJL+WQ6nKg?=
 =?us-ascii?Q?Hun8RKFGj/2tq/bdTTtlNs0QHjBif6aBLs53tT9xorGEU47Qc3Dqz0V0eeSi?=
 =?us-ascii?Q?N9GO/R4gcuLBIzL/8s7Ih8yrv0dQXJ1rPd2UlT2QK71oK+rnyGzp+2nQOwiw?=
 =?us-ascii?Q?3997z69A1F6d9S12PYinK1nOoR9xebhbwDHtvBljugpCtihg9We024m59F4z?=
 =?us-ascii?Q?9dLFUWAC5OUM2bnx9gH9yJ7LJJnsuRxyiZs+dJpWfW85iAPyZDStcDQPx7g0?=
 =?us-ascii?Q?jkWXB2P3A2wOpbJPTakgwLLKMUbcpAJK8DwxiFnu/tMLNc3SMLrdREbRU3Lh?=
 =?us-ascii?Q?suOSAJaMTNYqZ2x+4+dGFHDcKqZmAGzIkp7/NZ3NMOc7eWDFzTT0RkTwMTYU?=
 =?us-ascii?Q?sMTM9hLU50d7QhuLwxuntyveDi22cMwCnaWTpQR5ewMLmsF164IH/GYUCXfS?=
 =?us-ascii?Q?M2hYXW9vATT5sGpZcRgDepqLb2tW7TT6+MKZS9wY+eiGBa2+63GjjVXFLqNY?=
 =?us-ascii?Q?BPJD9T/KbkWoNx71N5a1TN1HIzHLUUKvpOvlZFzJET59uIrKCnRpuYZonT1l?=
 =?us-ascii?Q?Q7c0iTGqhpybSMEFUjQf9GrOLsCRA2Plr0kO08HXIZK6nNSvNS+mvVtGaM32?=
 =?us-ascii?Q?BGMoBIbpHd7BPn/wI7t7C1QOmxH7Rhm4CcsFq6x9UKhfBf2657s3nkwtkHTe?=
 =?us-ascii?Q?eWfSZAUdcxqqHnEUwHrW/eDvQMn2I3KwF8AGNcW5zlX1mqrxhROch4iO9yQX?=
 =?us-ascii?Q?OYB3zaLlZkq1i9VB+OyFb7CKBWvGozdIxfDe1lvAggU2SL6YRqTCfi7jysy3?=
 =?us-ascii?Q?7e9dayl9S3s90S2DQmBOIL+t6zsiOLrmco2w0+Nnyiprv1lFvC39bjW8Cm1T?=
 =?us-ascii?Q?C+pH9B8iuN87k2tSBeBGGfIXEED8HjsNctaVbKlFCPQuuEk/UemItPRW8j9P?=
 =?us-ascii?Q?aI841JznV2uYgfr3azOhdFAnS9xJp/RLY3V62n4RTZkpuWgyprz7QV4vV/on?=
 =?us-ascii?Q?kmh+iCRDckUWlZ6AHkKzv2I8nKTY8xaUtUcn6+AaUJRveFoLIAmdUpVhGg0J?=
 =?us-ascii?Q?o1hGbNDiwp/+W8xNE8IONb5J7Dgev5Y0p9kX8zsevDffTlul91MngADNLgyA?=
 =?us-ascii?Q?Y/1/FmqkdguBMP8+aXbU7OWpK95fY4c589YMODUq2avuwY06dnRQLbpU1cHb?=
 =?us-ascii?Q?YTkGDg8wFaK96uzgJ/G1BOZ1gt0TM2MNDlBq/Lez?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c0f6698-595f-400d-2f14-08dcf8c8eb38
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 09:55:00.5315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aUGR9GWs6C76YUXPb185sMdOREoWCGpxYlGsL8p57yekqWlUAM3L5+6k3Hz8h04N2PzTmWTjJ3rsvYdCzFTx4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10347

Add bindings for NXP NETC blocks control. Usually, NETC has 2 blocks of
64KB registers, integrated endpoint register block (IERB) and privileged
register block (PRB). IERB is used for pre-boot initialization for all
NETC devices, such as ENETC, Timer, EMDIO and so on. And PRB controls
global reset and global error handling for NETC. Moreover, for the i.MX
platform, there is also a NETCMIX block for link configuration, such as
MII protocol, PCS protocol, etc.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
v6: no changes
---
 .../bindings/net/nxp,netc-blk-ctrl.yaml       | 104 ++++++++++++++++++
 1 file changed, 104 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml

diff --git a/Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml b/Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml
new file mode 100644
index 000000000000..97389fd5dbbf
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml
@@ -0,0 +1,104 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/nxp,netc-blk-ctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NETC Blocks Control
+
+description:
+  Usually, NETC has 2 blocks of 64KB registers, integrated endpoint register
+  block (IERB) and privileged register block (PRB). IERB is used for pre-boot
+  initialization for all NETC devices, such as ENETC, Timer, EMIDO and so on.
+  And PRB controls global reset and global error handling for NETC. Moreover,
+  for the i.MX platform, there is also a NETCMIX block for link configuration,
+  such as MII protocol, PCS protocol, etc.
+
+maintainers:
+  - Wei Fang <wei.fang@nxp.com>
+  - Clark Wang <xiaoning.wang@nxp.com>
+
+properties:
+  compatible:
+    enum:
+      - nxp,imx95-netc-blk-ctrl
+
+  reg:
+    maxItems: 3
+
+  reg-names:
+    items:
+      - const: ierb
+      - const: prb
+      - const: netcmix
+
+  "#address-cells":
+    const: 2
+
+  "#size-cells":
+    const: 2
+
+  ranges: true
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: ipg
+
+  power-domains:
+    maxItems: 1
+
+patternProperties:
+  "^pcie@[0-9a-f]+$":
+    $ref: /schemas/pci/host-generic-pci.yaml#
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - "#address-cells"
+  - "#size-cells"
+  - ranges
+
+additionalProperties: false
+
+examples:
+  - |
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        system-controller@4cde0000 {
+            compatible = "nxp,imx95-netc-blk-ctrl";
+            reg = <0x0 0x4cde0000 0x0 0x10000>,
+                  <0x0 0x4cdf0000 0x0 0x10000>,
+                  <0x0 0x4c81000c 0x0 0x18>;
+            reg-names = "ierb", "prb", "netcmix";
+            #address-cells = <2>;
+            #size-cells = <2>;
+            ranges;
+            clocks = <&scmi_clk 98>;
+            clock-names = "ipg";
+            power-domains = <&scmi_devpd 18>;
+
+            pcie@4cb00000 {
+                compatible = "pci-host-ecam-generic";
+                reg = <0x0 0x4cb00000 0x0 0x100000>;
+                #address-cells = <3>;
+                #size-cells = <2>;
+                device_type = "pci";
+                bus-range = <0x1 0x1>;
+                ranges = <0x82000000 0x0 0x4cce0000  0x0 0x4cce0000  0x0 0x20000
+                          0xc2000000 0x0 0x4cd10000  0x0 0x4cd10000  0x0 0x10000>;
+
+                mdio@0,0 {
+                    compatible = "pci1131,ee00";
+                    reg = <0x010000 0 0 0 0>;
+                    #address-cells = <1>;
+                    #size-cells = <0>;
+                };
+            };
+        };
+    };
-- 
2.34.1


