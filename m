Return-Path: <linux-pci+bounces-44251-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D71D00FC1
	for <lists+linux-pci@lfdr.de>; Thu, 08 Jan 2026 05:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 90C32300751B
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jan 2026 04:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0191A299A87;
	Thu,  8 Jan 2026 04:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Ll/Dwwh3"
X-Original-To: linux-pci@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020076.outbound.protection.outlook.com [52.101.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025A6299A84;
	Thu,  8 Jan 2026 04:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767847319; cv=fail; b=ru7XitwRyN4JzJ1zdywn00gm0i6z8YUderAljA1XLe5xCGz17OZkkia9hPBs+e/vn32y7mKMfVFNvrwHxtevWDjOK4ag2IVyjZWd6xRCBcMcVuybQwaCtyJQkYoAoVvI8Mhbg5VsC+jHagMbFNM2vG3TFLBGfSDXXaavKsX6/Ug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767847319; c=relaxed/simple;
	bh=uIOk4W35nQUU/BfnR2PZHqw+zYjCx5MgF2oDM+Zi5cY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=faZ6Jioc5CaV3P6l/ZMdY9d6LgRX5Ug9fSneav2uF0vdQp/SqGRCoGjdWeigoj8aYu3FtouQL7Z2oGBxjmebwqe9QWJhdqmyr0qA1wPTPmFFFzxJQOFyos+MOMOuHKJ0VcUwRSWxl42b0jcmLPPZgnHxjrME67SEjE0jbsaZnEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Ll/Dwwh3; arc=fail smtp.client-ip=52.101.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ppPtn1gZrpv42IQ4N/wD2+tvvFNAEWv2ieu1nBm3bz8Ux8oAgNHo9FMLRbPKmu95FeAUXXBndjIufszsgD7fL2DxLYQC3TABtL27JB8v5UUk9j5U29hoyNhdsPTotVwPst+R//T9C6MJ1EqtpX5qFLcosbryN6KJg1aobdes9V0sbPozR9SFx6o0o66uM+BI+4K3QfWaGXShnsV2ZkqP5vpvNaUBiX6HLUKJ/tQZWTZ86pMC7lCgLSiFKjkbRl3ymCd5Bb3TKNI7mG5+p4W71qyH5C3mBi2ya3QGOzlu5d9KKGeJEj6F+jt/q9sF9vPG3U9Mt8Whz6eXcIePup/r3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WcuMQu0ggLHN0vOLTxEAEjmC1Z8wAcNV8ONqZ8dGUyk=;
 b=bD2yol47HQzZJUHvFooucVulkXc3lRMs6sRsnqf5/Z3VQOn/k/jOEFjdmH4NujDB7zIhu+fVp6NpucZNkjzdkZUj3cSP+39Svid5HOFFeJJiC/F3PssWkfjLfM08zh8BVhrgvOeX9ltjFOcHAym57KGkx5NQeqeKrwq85X5SIOtXtnU2LPBoTBEa8jAHi/wACvNIMJZm86/1AbL+8hLIxlYNCa+/Ajs1ISiTbmfJQgmR/HTITExDgGxNVwxY6CuN9LWgOYjPIGiGfiTOaLRq3SQ9jskkgwnPU7hQyn/+0Otm9c3y8iP5/Pd43lLFVPzakTy5Qb0gSDUOQyChnYtELQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WcuMQu0ggLHN0vOLTxEAEjmC1Z8wAcNV8ONqZ8dGUyk=;
 b=Ll/Dwwh3rE7UyZ88EHocpMSEuLBmgKGA+qtaeMQN9L+X4Bmrf3WeHbA8W7GQa7vKmKxITlMmKa6BZGzi9oNGXr+iHXWsHGGckGL7nxdHgNtzfPCL9Amk/VeXmrm96NuNTbIC837KFafzA9he3RE1V/8pMusbvVo+o21oG4ea8m4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYWP286MB3545.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:394::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 04:41:54 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 04:41:54 +0000
From: Koichiro Den <den@valinux.co.jp>
To: jingoohan1@gmail.com,
	mani@kernel.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	cassel@kernel.org
Cc: Frank.Li@nxp.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] PCI: dwc: ep: Support BAR subrange inbound mapping via Address Match Mode iATU
Date: Thu,  8 Jan 2026 13:41:48 +0900
Message-ID: <20260108044148.2352800-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260108044148.2352800-1-den@valinux.co.jp>
References: <20260108044148.2352800-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0307.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b::15) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYWP286MB3545:EE_
X-MS-Office365-Filtering-Correlation-Id: ffb441e6-2ef4-483a-145f-08de4e703f7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+PK+2ttEhD9w+rytZ3Xj25QZ7cMOedmHWCTKBcaKaWP3b1osNe2Duaga3Uog?=
 =?us-ascii?Q?+v7C0Wqa9l/PyKsXl/9eb5I1c59neN3swlygzpY5bBpe4yj/MGgLR4TieOly?=
 =?us-ascii?Q?ERJIR4Y6Kn6s7iRU5axnXjrrMenlqZ1jPFwQBCI6o7BUtCnSyR2ufNge10M7?=
 =?us-ascii?Q?45qNirXkLqPvuXIcWscS/Mh0hikZ27B6C5OPi3qiw8xQCe+I2RUKLdVMimC+?=
 =?us-ascii?Q?eSpgYjO8dbtKWiNHOvtCAGzXqin13+w5T4zhloV4vW/67oXM/NsE/fMJLUnb?=
 =?us-ascii?Q?aVxwhrfuHNLHJHR2lfNtgsu7R8IFrWjYC/NkbpzCYQMlX1isT0PvXTEyJ/Og?=
 =?us-ascii?Q?q2YCOAc5EvGrDm1lEvW4PXqBDJdEQlb5FbFcNR3Hiq8jXK+yjZYQrCqCfaVn?=
 =?us-ascii?Q?yl52YzuDMJwdnAtrCmUKiXmmq9mhM5nm9hLpCiRm03bgCsVeJQ4uMxFHJJER?=
 =?us-ascii?Q?aTgony01PfH2XgwhZBTexfuKN+Hd4ieB2fp0V6/2wg7Czgrq7CbJiRwz3zUW?=
 =?us-ascii?Q?i/Qn2OyTXJZw3mCYt4cCndHfVSKYMddj7OB171ixzn+BHm7F1EJAmY149oKD?=
 =?us-ascii?Q?VV0DTAM5dY9tbFOdn2nr18Yu2eem+POTmo7Jxy5m87xjnADy2fcXfgWok5A1?=
 =?us-ascii?Q?f/fVMLp0BbS0nqgBRBN3yE1zV+M88XzA2CyXQ8t349uLoCuJSsVlY9uREtxO?=
 =?us-ascii?Q?U0kqCiyJQEOCw4a/y1BYvFXI6KoOkw2QG1oU8QuRYH9THJpUFkBx3G9axuNS?=
 =?us-ascii?Q?VMw2vmwK7E1M/cpLPfIEvnngmTrKKGb8ePhmMBivykqoHwBxtTK422SzBCfN?=
 =?us-ascii?Q?jWEpqNsLwvHjCkqXLnvTKM89AgMz4C7aQ4jqFTc5fo9nIkgyLMsgFYvDp2RK?=
 =?us-ascii?Q?uA3+Jm8kD5JGsIs1bC3v7t7sZmty+bgxfVMRLrQCQfa3NbTg88sL9fhbGRa2?=
 =?us-ascii?Q?uK+xK6kbIe38ZfMSdxySWgGbSp8UISO3FA0QbdN282my45aKK7YF3NRrZMpS?=
 =?us-ascii?Q?D3X5wOYS3G8uwJmrPlD20B3VR0L+2Aa3chMy44PrXPUa5r6VscsGdZ6SnqC9?=
 =?us-ascii?Q?lU6moLVvrOLRZRW6D02xjIIran70KuWgIC6Zfnaq/Ye87yZbtiqGEOd78RQ8?=
 =?us-ascii?Q?nTBQ2ncoHkDA9f4y6yLpsX2PCjFwKi3RM1EaaV/+Z+KQ2R67Iemo9NNwaB8t?=
 =?us-ascii?Q?ims5mNN+s0w06g7nD2xSIkrUO8WoMXkrS1xYXMG8MGIcsTglDFW49RhqNEZY?=
 =?us-ascii?Q?uQmRHuaTZFahI2+vYtqGDuoC+GNSxCDxAjWhdoQNts+dnfTuxMKlO8hZ++8I?=
 =?us-ascii?Q?Gi29P+deM5agk1zsj1jOVmn+R2AdxuBIvCiP/VrIKV2glNFV3GaCeL6+3rVd?=
 =?us-ascii?Q?ohu2koN3IqGI0AzZbjrxzxD3sfIoJaT8IGdY1GWT4lsGEp3QPEX1UjYu9pG3?=
 =?us-ascii?Q?i6hYlXHMLnBSj4y6K8+Nfxf2ydCeyMdF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sI9c4KmXGKQfhFPdv0BDKVT1Uw9BbdzWgvXM6Wz1JnbArbJsM4ztHXDkYqJH?=
 =?us-ascii?Q?viZL+oUGFq9UmyUEN8R7+wl2n1ir+G5Y8/ROMKlWiukBv1LlkujdirqQZFQA?=
 =?us-ascii?Q?/NSrj//L1qPEYYstGOUOa6/8YtWN3s0AH8Br+QJkzBzGvqSHtd6hlokNcYvd?=
 =?us-ascii?Q?y5BP7YorvcqXmHnuI4RQEHuB/Z9zAn8bXLesxCjtmFqPfsdF526dr3MTNSVn?=
 =?us-ascii?Q?0JF9Dqh59oyHjTw9mTbnIung4xT2FagHkI8BoLUPbKInkypDOq1X3zq1EMe7?=
 =?us-ascii?Q?uSxkuI4ObYVgtBRpPrrk3NbV5LF1qRZcaw0MTqWambacXb+I/6YhVSUtr5pN?=
 =?us-ascii?Q?ae3XYUUxIcGIl5RzO4alaP9H5H+GRuxDOzrKgV13D4BKb6a1B0nCbF1vkWku?=
 =?us-ascii?Q?Y5mfPX9JPUILy5MPnZoptw++TxmdaoBHE9kYLakmEAB71uYFKF5qE73VJAmz?=
 =?us-ascii?Q?Pg8p40oAY0wXv3k3OFUJPfx3FFKF5+Bjhk0vCd2YLzUYnN3HOy1y8LyajGPl?=
 =?us-ascii?Q?hlUmBUlgd+Ce2d4H2H0sfu/md4OgIuk4GOWx9aFVmo85+pCmsqVNeHB3/myO?=
 =?us-ascii?Q?0JpAY5SpqaY8zlKHaODP+e/5N9cdHJAFOc3OkxfLfeFKW8QAxd7ZmVg18rVF?=
 =?us-ascii?Q?FKVTVY4LSNag1GjJAMFEUP9WJATZw+TGbcFpRpnbmoV/x6YBTgmNfYpDXYoz?=
 =?us-ascii?Q?NrEMA4a2edB/akpFrBXPz/E5FwBqj0o8LKqgpBX7k0OIv8JtpBZ5aqh7iCPp?=
 =?us-ascii?Q?gmz4ZCFwowmqsWHojLo68w62Q57VYg7QNtFx/aOVE9IcIXPNF1f7Ypm51fYz?=
 =?us-ascii?Q?8XqZxtD/MosqbylB/YKVMQKi/CKl1Uw/XLy1tRfUH5I6S7qFTYJdONXfecve?=
 =?us-ascii?Q?rmQpQbZtiNTxJmTYNwsjSdXUqmh/+ZatPEO3MiduYkx3rrthiB36M6AIrPKd?=
 =?us-ascii?Q?g1abS/XRb7wfySYEXsMmUo0yy3jPgLilr/f1XuTTDrQBlWPwEkSOd4dm5eRg?=
 =?us-ascii?Q?WlJh9ZbpelybqPvrYZhSTbiMl7fZXepVf8aJZiUPc6OCeHkY0MmouepIUp3F?=
 =?us-ascii?Q?cGmS8M1dI70zwa/T5yORVZNhXchEKHP1X5RC2jA0L9VDIQ8U7SUL2e7scDAI?=
 =?us-ascii?Q?af0zC2f3jVOoqAP/B72gvEkw6ErOqSw+Z2ll3rKdyCwipT5tuNu05vpAJWG1?=
 =?us-ascii?Q?d0hokNkJyoV6ZDYIpKNf0T0n0/CVsGJnusUR1C4kZeVtj9N3gGDfyTYYgn1U?=
 =?us-ascii?Q?sxtpKCNLfHKqK6L8h9FazpnyfIiGetVvE3zsMzEvLkDzMItlEwdv0nO6noZR?=
 =?us-ascii?Q?/wR/OpHl1dEuBu4MtsnJT6VMi6XHBF+OXhmpLEbE2xj7vP0tEnQ4f9Cjyahm?=
 =?us-ascii?Q?r07W9b2p73gDly9r0r+MicJU4Br0IELsggawH2Vy1rZYtuW4UrmbXCqeDfQ2?=
 =?us-ascii?Q?XFcKYCTZe+0Dxzt5p+l9NveCGAosRlluEqwxXts8VFSKjOEQzlMXL47m9QdF?=
 =?us-ascii?Q?4c4/Doknf1mUSJx5Gbl9Nv3YYKrLGVSpMV4dIG0qrzXV12xshjrZwsPqo72C?=
 =?us-ascii?Q?8dp/SIjgzReQrQJ+mwldcdBOuHXoRUYJQXs2VtvMnHTLt3zNvezu6SEuKmUM?=
 =?us-ascii?Q?1cY4RUskVLVyXiIYJBYY4p3c4w7oeMXREbSvOZ++NE0MKe+ZVikcAjWO1Qbg?=
 =?us-ascii?Q?6zOo6FquK7nqEP5VtcXnwV3UV0G4Bm2poA/K5T2LpnbtUeXbSvkkyZbinqsl?=
 =?us-ascii?Q?PJdA+JsN2Ozsk3jysxqqCbJPYIg88Tmt7a/S6ArCgDwROgHniwFu?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: ffb441e6-2ef4-483a-145f-08de4e703f7e
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 04:41:54.2228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GeF9zQxOLV0mW98ZOgWiHc98OqIPTuTmQChXJurH6ZERJDEw0PW64NzqGiLfsUue4h0fOsEgSQLuqU6PiCj3SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB3545

Extend dw_pcie_ep_set_bar() to support inbound mappings for BAR
subranges using Address Match Mode IB iATU.

Rename the existing BAR-match helper into dw_pcie_ep_ib_atu_bar() and
introduce dw_pcie_ep_ib_atu_addr() for Address Match Mode. When
use_submap is set, read the assigned BAR base address and program one
inbound iATU window per subrange. Validate the submap array before
programming:
- each subrange is aligned to pci->region_align
- subranges cover the whole BAR (no gaps and no overlaps)
- subranges are sorted in ascending order by offset

Track Address Match Mode mappings and tear them down on clear_bar() and
on set_bar() error paths to avoid leaving half-programmed state or
untranslated BAR holes.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 .../pci/controller/dwc/pcie-designware-ep.c   | 232 +++++++++++++++++-
 drivers/pci/controller/dwc/pcie-designware.h  |   2 +
 2 files changed, 223 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 1195d401df19..d9f9ad7855b4 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -139,9 +139,10 @@ static int dw_pcie_ep_write_header(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	return 0;
 }
 
-static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
-				  dma_addr_t parent_bus_addr, enum pci_barno bar,
-				  size_t size)
+/* Bar Match Mode inbound iATU mapping */
+static int dw_pcie_ep_ib_atu_bar(struct dw_pcie_ep *ep, u8 func_no, int type,
+				 dma_addr_t parent_bus_addr, enum pci_barno bar,
+				 size_t size)
 {
 	int ret;
 	u32 free_win;
@@ -174,6 +175,208 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
 	return 0;
 }
 
+/* Inbound mapping bookkeeping for Address Match Mode */
+struct dw_pcie_ib_map {
+	struct list_head	list;
+	enum pci_barno		bar;
+	u64			pci_addr;
+	u64			parent_bus_addr;
+	u64			size;
+	u32			index;
+};
+
+static void dw_pcie_ep_clear_ib_maps(struct dw_pcie_ep *ep, enum pci_barno bar)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	struct dw_pcie_ib_map *m, *tmp;
+	struct device *dev = pci->dev;
+	u32 atu_index;
+
+	/* Tear down the BAR Match Mode mapping, if any. */
+	if (ep->bar_to_atu[bar]) {
+		atu_index = ep->bar_to_atu[bar] - 1;
+		dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_IB, atu_index);
+		clear_bit(atu_index, ep->ib_window_map);
+		ep->bar_to_atu[bar] = 0;
+	}
+
+	/* Tear down all Address Match Mode mappings, if any. */
+	guard(spinlock_irqsave)(&ep->ib_map_lock);
+	list_for_each_entry_safe(m, tmp, &ep->ib_map_list, list) {
+		if (m->bar != bar)
+			continue;
+		dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_IB, m->index);
+		clear_bit(m->index, ep->ib_window_map);
+		list_del(&m->list);
+		devm_kfree(dev, m);
+	}
+}
+
+static u64 dw_pcie_ep_read_bar_assigned(struct dw_pcie_ep *ep, u8 func_no,
+					enum pci_barno bar, int flags)
+{
+	u32 reg = PCI_BASE_ADDRESS_0 + (4 * bar);
+	u32 lo, hi;
+	u64 addr;
+
+	lo = dw_pcie_ep_readl_dbi(ep, func_no, reg);
+
+	if (flags & PCI_BASE_ADDRESS_SPACE)
+		return lo & PCI_BASE_ADDRESS_IO_MASK;
+
+	addr = lo & PCI_BASE_ADDRESS_MEM_MASK;
+	if (!(flags & PCI_BASE_ADDRESS_MEM_TYPE_64))
+		return addr;
+
+	hi = dw_pcie_ep_readl_dbi(ep, func_no, reg + 4);
+	return addr | ((u64)hi << 32);
+}
+
+static int dw_pcie_ep_validate_submap(struct dw_pcie_ep *ep,
+				      const struct pci_epf_bar_submap *submap,
+				      unsigned int num_submap, size_t bar_size)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	u32 align = pci->region_align;
+	size_t expected = 0;
+	size_t size, off;
+	unsigned int i;
+
+	if (!align || !IS_ALIGNED(bar_size, align))
+		return -EINVAL;
+
+	/*
+	 * The array is expected to be sorted by offset before calling this
+	 * helper. With sorted entries, we can enforce a strict, gapless
+	 * decomposition of the BAR:
+	 *  - each entry has a non-zero size
+	 *  - offset/size/phys_addr are aligned to pci->region_align
+	 *  - each entry lies within the BAR range
+	 *  - entries are contiguous (no overlaps, no holes)
+	 *  - the entries exactly cover the whole BAR
+	 *
+	 * Note: dw_pcie_prog_inbound_atu() also checks alignment for
+	 * offset/phys_addr, but validating up-front avoids partially
+	 * programming iATU windows in vain.
+	 */
+	for (i = 0; i < num_submap; i++) {
+		off = submap[i].offset;
+		size = submap[i].size;
+
+		if (!size)
+			return -EINVAL;
+
+		if (!IS_ALIGNED(size, align) || !IS_ALIGNED(off, align))
+			return -EINVAL;
+
+		if (!IS_ALIGNED(submap[i].phys_addr, align))
+			return -EINVAL;
+
+		if (off > bar_size || size > bar_size - off)
+			return -EINVAL;
+
+		/* Enforce contiguity (no overlaps, no holes). */
+		if (off != expected)
+			return -EINVAL;
+
+		expected += size;
+	}
+	if (expected != bar_size)
+		return -EINVAL;
+
+	return 0;
+}
+
+/* Address Match Mode inbound iATU mapping */
+static int dw_pcie_ep_ib_atu_addr(struct dw_pcie_ep *ep, u8 func_no, int type,
+				  const struct pci_epf_bar *epf_bar)
+{
+	const struct pci_epf_bar_submap *submap = epf_bar->submap;
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	enum pci_barno bar = epf_bar->barno;
+	struct device *dev = pci->dev;
+	u64 pci_addr, parent_bus_addr;
+	struct dw_pcie_ib_map *new;
+	u64 size, off, base;
+	unsigned long flags;
+	int free_win, ret;
+	unsigned int i;
+
+	if (!epf_bar->num_submap || !submap || !epf_bar->size)
+		return -EINVAL;
+
+	ret = dw_pcie_ep_validate_submap(ep, submap, epf_bar->num_submap,
+					 epf_bar->size);
+	if (ret)
+		return ret;
+
+	base = dw_pcie_ep_read_bar_assigned(ep, func_no, bar, epf_bar->flags);
+	if (!base) {
+		dev_err(dev,
+			"BAR%u not assigned, cannot set up sub-range mappings\n",
+			bar);
+		return -EINVAL;
+	}
+
+	/* Tear down any existing mappings before (re)programming. */
+	dw_pcie_ep_clear_ib_maps(ep, bar);
+
+	for (i = 0; i < epf_bar->num_submap; i++) {
+		off = submap[i].offset;
+		size = submap[i].size;
+		parent_bus_addr = submap[i].phys_addr;
+
+		if (off > (~0ULL) - base) {
+			ret = -EINVAL;
+			goto err;
+		}
+
+		pci_addr = base + off;
+
+		new = devm_kzalloc(dev, sizeof(*new), GFP_KERNEL);
+		if (!new) {
+			ret = -ENOMEM;
+			goto err;
+		}
+
+		spin_lock_irqsave(&ep->ib_map_lock, flags);
+
+		free_win = find_first_zero_bit(ep->ib_window_map,
+					       pci->num_ib_windows);
+		if (free_win >= pci->num_ib_windows) {
+			spin_unlock_irqrestore(&ep->ib_map_lock, flags);
+			devm_kfree(dev, new);
+			ret = -ENOSPC;
+			goto err;
+		}
+		set_bit(free_win, ep->ib_window_map);
+
+		new->bar = bar;
+		new->index = free_win;
+		new->pci_addr = pci_addr;
+		new->parent_bus_addr = parent_bus_addr;
+		new->size = size;
+		list_add_tail(&new->list, &ep->ib_map_list);
+
+		spin_unlock_irqrestore(&ep->ib_map_lock, flags);
+
+		ret = dw_pcie_prog_inbound_atu(pci, free_win, type,
+					       parent_bus_addr, pci_addr, size);
+		if (ret) {
+			spin_lock_irqsave(&ep->ib_map_lock, flags);
+			list_del(&new->list);
+			clear_bit(free_win, ep->ib_window_map);
+			spin_unlock_irqrestore(&ep->ib_map_lock, flags);
+			devm_kfree(dev, new);
+			goto err;
+		}
+	}
+	return 0;
+err:
+	dw_pcie_ep_clear_ib_maps(ep, bar);
+	return ret;
+}
+
 static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep,
 				   struct dw_pcie_ob_atu_cfg *atu)
 {
@@ -204,17 +407,15 @@ static void dw_pcie_ep_clear_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	enum pci_barno bar = epf_bar->barno;
-	u32 atu_index = ep->bar_to_atu[bar] - 1;
 
-	if (!ep->bar_to_atu[bar])
+	if (!ep->epf_bar[bar])
 		return;
 
 	__dw_pcie_ep_reset_bar(pci, func_no, bar, epf_bar->flags);
 
-	dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_IB, atu_index);
-	clear_bit(atu_index, ep->ib_window_map);
+	dw_pcie_ep_clear_ib_maps(ep, bar);
+
 	ep->epf_bar[bar] = NULL;
-	ep->bar_to_atu[bar] = 0;
 }
 
 static unsigned int dw_pcie_ep_get_rebar_offset(struct dw_pcie *pci,
@@ -408,10 +609,17 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	else
 		type = PCIE_ATU_TYPE_IO;
 
-	ret = dw_pcie_ep_inbound_atu(ep, func_no, type, epf_bar->phys_addr, bar,
-				     size);
-	if (ret)
+	if (epf_bar->use_submap)
+		ret = dw_pcie_ep_ib_atu_addr(ep, func_no, type, epf_bar);
+	else
+		ret = dw_pcie_ep_ib_atu_bar(ep, func_no, type,
+					    epf_bar->phys_addr, bar, size);
+
+	if (ret) {
+		if (epf_bar->use_submap)
+			dw_pcie_ep_clear_bar(epc, func_no, vfunc_no, epf_bar);
 		return ret;
+	}
 
 	ep->epf_bar[bar] = epf_bar;
 
@@ -1120,6 +1328,8 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	struct device *dev = pci->dev;
 
 	INIT_LIST_HEAD(&ep->func_list);
+	INIT_LIST_HEAD(&ep->ib_map_list);
+	spin_lock_init(&ep->ib_map_lock);
 	ep->msi_iatu_mapped = false;
 	ep->msi_msg_addr = 0;
 	ep->msi_map_size = 0;
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index f87c67a7a482..1ebe8a9ee139 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -479,6 +479,8 @@ struct dw_pcie_ep {
 	phys_addr_t		*outbound_addr;
 	unsigned long		*ib_window_map;
 	unsigned long		*ob_window_map;
+	struct list_head	ib_map_list;
+	spinlock_t		ib_map_lock;
 	void __iomem		*msi_mem;
 	phys_addr_t		msi_mem_phys;
 	struct pci_epf_bar	*epf_bar[PCI_STD_NUM_BARS];
-- 
2.51.0


