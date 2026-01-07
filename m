Return-Path: <linux-pci+bounces-44137-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D1152CFBECD
	for <lists+linux-pci@lfdr.de>; Wed, 07 Jan 2026 05:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9859830537A7
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jan 2026 04:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8804B19D065;
	Wed,  7 Jan 2026 04:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="uJ8dlJvJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021080.outbound.protection.outlook.com [52.101.125.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCD3233149;
	Wed,  7 Jan 2026 04:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767759253; cv=fail; b=RNx69BCGsKUVt32kMANDhx7dqXZpMm+R+40KNh4ULM8GEcXMGJh4tShcinHx7bcW5WkBJBiy6piza9oB1dTs9/4Bh7XWxxqt4VXGmiQAOs5mJ24xnJX5+32p6oIGz7iQ864DHp/uTjDAYIA1xx2bMMCqrTiE6CR7UvZuhDPh14w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767759253; c=relaxed/simple;
	bh=VRLdqARKTmm1154rm97f0FAnJ3Hw4Fm/u39e9n6aD1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fIuI2Z7+crV5UrFQuKp/StHEuX/TyFgiKtHc8AMHphumzYDi1k35zt07qgrAm9x4sxgGBqR/eqPX+7aoXcIgSBF7041pyeUKNl49tYRy8n4hCkWnwCj7AWTqtaUmtRcO73fnYh1WBrAUImb6TG+wAyiLcjpynoiSjgJz7WtrMlg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=uJ8dlJvJ; arc=fail smtp.client-ip=52.101.125.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fFJoEcDnwwqV80lDxfHklusWtAwoVTZl1WAlZk0yPhudwudB14X4d5RbN+3TIB0QJIl4QNsR7MMgBnxwgYOVRMlF3+2cBJClAk/+OFOyTLk5rjFVvF2ixSkGsk0okiDuVImpbGxPxE530K0NCsSIq5G2G+Rxzef8zGkPuSzGVdU6E60G7lnn2zb5SQqxyalaFP+jnItxTLqOEnHZvSrJqJGbZ8NS97ogzFsUshx9DXdg90uzWuEo9TXfdIB+M18+y622H1UHppkz/+dN8c/942SLePbaG54OR31pCzwIpJUO1QVCiluzIE/iMtdDVmv5rneOMgnrhYfID+Oiyq/k/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0sSvMhNGZeG1afDQZyRaMDeJvnKmNmbdauaVlEucMXM=;
 b=R5ElJlN/+EeAS6F1puoLAbWT5ODGGzpN8kgsdHEcLvLtbQjGwkJf5xEg+YQCBECwUugDCyYV7lxYuhztj5T0ZtlvHyo8/aqMjfNmxFMMxJ4owK9X7HodZYztnXBnC/r06I9x6QGsGF7qcJw1D7BaH9hv2Yq6S6b38mLFShapyCwjRX9Lch7hTlCTFX0jbOLTyTJUSkyL2STzuj3wrMIabWMJk9SchpugapWBA+58esaG6XRT3b7dDHKu7h0QyxJskPBCKJK3Azh1mge0OP5bMHEsMUAAuX3p86rKCLPEhDzKi0Arqj5BMMmhf+cb4qkg8NwtL4MvcfEbE9S51Eeh6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0sSvMhNGZeG1afDQZyRaMDeJvnKmNmbdauaVlEucMXM=;
 b=uJ8dlJvJpcakMlfUDzJCrAeFMHZoy9PnBUbl5k11WBS3+8QuHOdRUm39Cxmwb5voRbkoI7sZ3JPd4JbhsNmVI3CtfeHclCAouA4ZeOr+wKluZ+PT0UeN8sa71cr8+nGqQ5USTsCBknrLgD6PjZxyl34540GxO+V8pnJIbhyPnaI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSCP286MB5904.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:3e9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 04:14:02 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 04:14:02 +0000
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
Subject: [PATCH v2 2/2] PCI: dwc: ep: Support BAR subrange inbound mapping via address-match iATU
Date: Wed,  7 Jan 2026 13:13:58 +0900
Message-ID: <20260107041358.1986701-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260107041358.1986701-1-den@valinux.co.jp>
References: <20260107041358.1986701-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0128.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::20) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSCP286MB5904:EE_
X-MS-Office365-Filtering-Correlation-Id: 168b7287-ce30-4e0d-27d3-08de4da330de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?socQb+0hxiM2BHlpbg8UA/8eOAUZ4Ep24Dy2OBaIku8cxJBX4kdF/9DZMA+2?=
 =?us-ascii?Q?zfO0afFF8PigPIms+tTDP6nYMcsYWomeLJkDWRwbXech6g4JE0dZujvgVNQV?=
 =?us-ascii?Q?rjf2XlCuUL+GTIGsqujbLhs3glAtq3ON0jmf3cNeCzycrIY8jSWy5QT64VxJ?=
 =?us-ascii?Q?SCokeflGEfucUfYwf2qBg84iU9Uk2Cyzr8k4wLE0t2DmyO74gyl7n80x7qDI?=
 =?us-ascii?Q?x1CiBBQogF0e31v+Z/9v92eGvaLbEzc846M83es5Rr0BrALOBelOVe9aoFUp?=
 =?us-ascii?Q?wULVk3R4Zvhpg1gav0bnKEYpUlryRfWxHRw2cM+vCfOWmTJy9ivRp6s8wiKJ?=
 =?us-ascii?Q?GmESqCCSG2As1OVF2F05k2Uh3jaYePMXuQbGXMHOWr5LBGGAKgSPmykhq0jg?=
 =?us-ascii?Q?/FEyL3kjtcBI5auNgzx7/oA5t37rqi2rWiBOXAR3vXs+sEqT2ubIYuHbCTiQ?=
 =?us-ascii?Q?iN538RAb0mq20uOtcN1Wl0rPf3i49jtmPQKS1FT5BD8knSGCcqGcWcdOcUZ8?=
 =?us-ascii?Q?DHcWIaDqhBW0l1M1UBE93blH0DUPCejbgE6VKvVQwIlVPN068wpgZgZQweUV?=
 =?us-ascii?Q?rovDU/hE1zLRSzDukGBmgU9R1Kumq3HFiFiic2YAY4UeYg48kLrCL7yAd7pZ?=
 =?us-ascii?Q?NFhCQJLPB+I5qhjzz8dmJVZJEHbYMz+zImPBsNOmml4JcS4RjiL11gVyQPQq?=
 =?us-ascii?Q?0a6K+h/xeNIA6nBDSpY1S7oG45VGn9YM7D+raIdEfSWMv6Qn+ePwgKm+61hY?=
 =?us-ascii?Q?fWtNYKPwgaxCCRwfid81cdlbvAvNGPfxXz8CPpm4Wfkks9kOf4+NeddiHGDA?=
 =?us-ascii?Q?E7lXRbeqrnpkLorBuw47AXaxAG8uQksD31KFCD0rZjwi5HxmvLPF7tRfWoT3?=
 =?us-ascii?Q?BBmI8pQCrvfCrCHjecU58kYwWNCf7gKdTochL1p6UwW1RXkwnnUEGzKgSgry?=
 =?us-ascii?Q?nZ5mL72tMYm3dQsjzFOBFociyrinT4KlzXAlsAgbLyqCGlDkI5mkHwd+fHSs?=
 =?us-ascii?Q?GgYuWY9QWJ8a9U53QCJvrPh0m4sLgDbodEmQPnPqIFWJcWn3XpfYoGye+lIv?=
 =?us-ascii?Q?LzT9783dfCqglr7ZS33ipII5ByDabx9o+NJ4eys5i0ta/iW87mL3j4JgnrPo?=
 =?us-ascii?Q?5E9hB7bd9NbLL3ShE+fA89gnGizJ/j/UhLHGnYtbtXEKTepRph1psW0dY0xW?=
 =?us-ascii?Q?/rv6KYPqWSRSYKx1tZ2HiFJv6UJTzwbnj3mKIRmvzs9k818l6ifK1PWMjn1C?=
 =?us-ascii?Q?5bqtkQGn5Yglt0NaJfuxFoqMVmLz/RKNr3KMXVIpjH//trNxiG92VTmeQj6N?=
 =?us-ascii?Q?KNrAACL77NmCChzzGvx7xrZnctRO1/CmwkNFBOjOENpvSBjTQ94vM2N6EFjJ?=
 =?us-ascii?Q?KdktC9qfcHf7/Y0FKPKMq3XVQVD/WQJQ4dEb6gLub71elTrTf6+mEVftr7Iw?=
 =?us-ascii?Q?NplNUlJwaN3Q1wtoxIrJAYQe3M4uN1Nt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+O/FAKAz64IGWRuV8n/fhVazqLQo6mQdD1uSTRLYpjN9rDJoD5C4prfBihSS?=
 =?us-ascii?Q?shcM2lD93lz3sHXRBOue72S7if+RxTe5RoNNCSQfIN3lIY+l9WQgBpKG17bW?=
 =?us-ascii?Q?dHPdv9nlJCkPYNkdUDsIgtt49hXxvfAppium3K33k/HIzraRK0dqK8gcV+ma?=
 =?us-ascii?Q?DnzPE+vpJSvS1kBVy9g2nywSy9YvQQFLH6dlPukgD6hhOtST1Eos31bZIl7w?=
 =?us-ascii?Q?IC+2tflrqFcwQlfD+YY7WbaSEQIRV96ZRinCz3Hh/iWyPL1NrG7zCFvo9y+b?=
 =?us-ascii?Q?+FGqI4HyjgisUMtqOwkY7fTwEWKWOWt2dQT8+PBfCUwz5dm+0c3Ri92shPS6?=
 =?us-ascii?Q?AVHcn2gbYy0FRgD+9NLeo44ahOmydPCtfBdPGm4sdswXOv32bLgUZcGOt3km?=
 =?us-ascii?Q?8UU8ia10r3RN3H78sYSeAXqRO2P/5l9/oC29umMGmzoAZdMt3jGbK4/8CJaL?=
 =?us-ascii?Q?QTKr0cS6nSDRGIBIIDiQHomDgPuE1cCim4s4XR6NpIs2i5uQsf2nI0db/Jve?=
 =?us-ascii?Q?n+j8X9OntY4yOv/XfGDaIYGM83Qcbgq2YWqLwlybTrS9vgrkmqVTgdAtx8Uy?=
 =?us-ascii?Q?Wswh0Zz4k+Yw7LVc+3p8HyV0DLMLersxt7tLREK7ESb/3a+Rgxyauc79nXBo?=
 =?us-ascii?Q?wV1B2z4fJukyGY+Fgp/NMuy9kl4g+8hzoexcY7Dr6phL+XpS/0PPvKiHgVr/?=
 =?us-ascii?Q?ojQH00kZlXBIuakH/LqSnXXf9c28iTnn+HyXnio/0d8sxH2VQQFPnHDQTfwB?=
 =?us-ascii?Q?HguB1ZlMFe9L4rabFGKIFh1D7StSFB+HwdUTBLEg/LRicLX5ZeD2Na1BEaDF?=
 =?us-ascii?Q?HfrDAKI/1sTpjBojEM63AmPEJ+5GJjN+EDQ0UzqaGoERCfVW2EGQq3Btl2VU?=
 =?us-ascii?Q?+u/5ilVvG4R2U5v2K6iqWportnokEGFv7hLvNywpVum6sbygFpnSdZECoJwf?=
 =?us-ascii?Q?Pr/FR88fI7ZlW6RiVnTtTaCj6lFCh7DRUCZtnNQvdyGAxGPJG1s9O+jQNZxw?=
 =?us-ascii?Q?b5WmVKbevtDv6fn6+sKv1y0Ezf+j9LhsitoHpGZW81yAZ1/kNWWrpcp8bKx6?=
 =?us-ascii?Q?YF+1P+uRVvmoMJkuO5PYfXE7syDGdqLgniZ+d0/Zk9PicN6PZImCqeyz+LQa?=
 =?us-ascii?Q?0ntPmCJ3LfabnVdnQNAXTS5si3zPilvKchuUcYxHYaeG7T74JA3sK6EoKm30?=
 =?us-ascii?Q?QjECp8H6q72EWCUSNRDE9Vu6s3DLamGqRu+M2D17pB/qqB0hsIyJu6wQYR+N?=
 =?us-ascii?Q?KfqZMqvwtt2c8SCrwGBM3EQGTLKoayKhqgTJMn8+KaCSTQx+SoIsoeaTN8Vu?=
 =?us-ascii?Q?eJa1U2ZxgfsDq8N7SR5UirnpZsEdcrdKnKu/AYsRyH3wK6VHQywGF2MDFsD7?=
 =?us-ascii?Q?HTlZB9PBTnX6yfjmVDpKadAOfELYuZDELGaPKLrqAbtxlfnVu1NLuisEdwjD?=
 =?us-ascii?Q?z6U1A+shM/y9k79WbxTzg4lMI6vEyhsrHOvaui9MPO6xZ4cADK4/PpPBhjUQ?=
 =?us-ascii?Q?eWWNPPlAG2RG5HlRCgmyypuzAFn4PvZ77zdlWkz4y2jioO38UIWqsbTcUwJq?=
 =?us-ascii?Q?wn9aNOvcPZbjvce8E22xIQVM+F7G4awGar4Fee9gBhla/E/dG/Xg9gGtNAsS?=
 =?us-ascii?Q?PuJAmPZ2B0U/SAFAlrVwmfztkirUiWhXlASV3hd1pN89F+OVsbboG/g6mcCt?=
 =?us-ascii?Q?F70XEfgwxKE7//kyRISoug0MtnNLLnW6EjShEJHeeAbzBBk3o2wviFsNLkfo?=
 =?us-ascii?Q?iBtItcc8MFNVmKX0jOfIink/lW8ttjAFH8FOZPgcwi9BcWtZUtxv?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 168b7287-ce30-4e0d-27d3-08de4da330de
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 04:14:02.8812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NMMknrA4WWkPRvyrpP9oHexpcNFqatcrGE6M9bR7p20X/uZvGbtCUJDi/t5fFT1QKuo67Wt6lluLVtYE6PtxSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB5904

Extend dw_pcie_ep_set_bar() to support inbound mappings for BAR
subranges using Address Match Mode IB iATU.

Rename the existing BAR-match helper to dw_pcie_ep_ib_atu_bar() and
introduce dw_pcie_ep_ib_atu_addr() for Address Match Mode. When
use_submap is set, read the assigned BAR base address and program one
inbound iATU window per subrange. Validate the submap array before
programming:
- each subrange is aligned to pci->region_align
- subranges cover the whole BAR (no gaps and no overlaps)

Track address-match mappings and tear them down on clear_bar() and on
set_bar() error paths to avoid leaving half-programmed state or untranslated
BAR holes.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 .../pci/controller/dwc/pcie-designware-ep.c   | 255 +++++++++++++++++-
 drivers/pci/controller/dwc/pcie-designware.h  |   2 +
 2 files changed, 246 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 1195d401df19..466f416694dd 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -8,8 +8,10 @@
 
 #include <linux/align.h>
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/sort.h>
 
 #include "pcie-designware.h"
 #include <linux/pci-epc.h>
@@ -139,9 +141,10 @@ static int dw_pcie_ep_write_header(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	return 0;
 }
 
-static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
-				  dma_addr_t parent_bus_addr, enum pci_barno bar,
-				  size_t size)
+/* Bar match mode inbound iATU mapping */
+static int dw_pcie_ep_ib_atu_bar(struct dw_pcie_ep *ep, u8 func_no, int type,
+				 dma_addr_t parent_bus_addr, enum pci_barno bar,
+				 size_t size)
 {
 	int ret;
 	u32 free_win;
@@ -174,6 +177,229 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
 	return 0;
 }
 
+/* Inbound mapping bookkeeping for address-match mode */
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
+	/* Tear down the BAR match-mode mapping, if any. */
+	if (ep->bar_to_atu[bar]) {
+		atu_index = ep->bar_to_atu[bar] - 1;
+		dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_IB, atu_index);
+		clear_bit(atu_index, ep->ib_window_map);
+		ep->bar_to_atu[bar] = 0;
+	}
+
+	/* Tear down all address match-mode mappings, if any */
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
+static int dw_pcie_ep_submap_offset_cmp(const void *a, const void *b)
+{
+	const struct pci_epf_bar_submap *sa = a;
+	const struct pci_epf_bar_submap *sb = b;
+
+	if (sa->offset < sb->offset)
+		return -1;
+	if (sa->offset > sb->offset)
+		return 1;
+	return 0;
+}
+
+static int dw_pcie_ep_validate_submap(struct dw_pcie_ep *ep,
+				      struct pci_epf_bar_submap *smap,
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
+		off = smap[i].offset;
+		size = smap[i].size;
+
+		if (!size)
+			return -EINVAL;
+
+		if (!IS_ALIGNED(size, align) || !IS_ALIGNED(off, align))
+			return -EINVAL;
+
+		if (!IS_ALIGNED(smap[i].phys_addr, align))
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
+/* Address Match Mode IB iATU mapping */
+static int dw_pcie_ep_ib_atu_addr(struct dw_pcie_ep *ep, u8 func_no, int type,
+				  const struct pci_epf_bar *epf_bar)
+{
+	struct pci_epf_bar_submap *submap = epf_bar->submap;
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
+	/* Work on a sorted copy */
+	struct pci_epf_bar_submap *smap __free(kfree) = kcalloc(
+				epf_bar->num_submap, sizeof(*smap), GFP_KERNEL);
+	if (!smap)
+		return -ENOMEM;
+
+	memcpy(smap, submap, epf_bar->num_submap * sizeof(*smap));
+	sort(smap, epf_bar->num_submap, sizeof(*smap),
+	     dw_pcie_ep_submap_offset_cmp, NULL);
+
+	ret = dw_pcie_ep_validate_submap(ep, smap, epf_bar->num_submap, epf_bar->size);
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
+		off = smap[i].offset;
+		size = smap[i].size;
+		parent_bus_addr = smap[i].phys_addr;
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
@@ -204,17 +430,15 @@ static void dw_pcie_ep_clear_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
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
@@ -408,10 +632,17 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
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
 
@@ -1120,6 +1351,8 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
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


