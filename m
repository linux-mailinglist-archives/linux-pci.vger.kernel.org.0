Return-Path: <linux-pci+bounces-44246-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA89DD00B88
	for <lists+linux-pci@lfdr.de>; Thu, 08 Jan 2026 03:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0927E30136EB
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jan 2026 02:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591B120A5F3;
	Thu,  8 Jan 2026 02:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="GM5lzWFN"
X-Original-To: linux-pci@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020127.outbound.protection.outlook.com [52.101.229.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6D2275AFD;
	Thu,  8 Jan 2026 02:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767840523; cv=fail; b=dWi5KzKc/qxVLiuFwUmbUMNw1ukIPeAZmy0TcRx1CNvSoEz2UmNYHQqceJDKtSW1hECfO8eL+FaIgNSgvie+kj3Gf1Aliox/3c2cp4Ao2ixQIff53yLa0x1/XFtw3E/vOkRtO4tLPAX7B7s94tRQVR8MiBDm1bFJsbXVEwNITbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767840523; c=relaxed/simple;
	bh=lBxEeLs4kIYENx6ZzblPYZyjrzeDuMz8x3SdkdtPo+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YjQJJmDksmo8iO/r/ViTdDZBuXzpWMv1M6Z2JWAW4hdL6HyTSZBHM/TncZ1Tm+n7NxqVTQkJtWACArZaS0WJTi9CjuW50DAEoxA294746YDQdAjRfHlhRMuUV/8OKRAKcW8YZjp+Py5i07ar6/hYe98ZgwmjmALzHN07+Pl6yIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=GM5lzWFN; arc=fail smtp.client-ip=52.101.229.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eHhhnnPvsrSNGrRqHWXGT/91rRIH2iHXTO17q/BoVZIRHXJNFFudSv8WoiI9h6Mu7eL+tSVV2akTY+8pzHbq05adnDSx0sbcdIISrccU6onvCDEAiHxwnfnHomcpO+HECWj79CB+5vuMUSitY6kygFTlhmuwT0fk3aVR30I1FGSjHeOAuyqpdquUpk16GLIewaEySy/Ux0zkk2yTZhulgySuxF5SPrK7MzrFoK0WfBZ/nPHYVXboR/96rlhIBmEtDiVsysD+9cJerRxjqBpqvV5xscdDWW63PMqZqnNKmWKJBeJimOlIzGN72Sc8pWOpjG4kLv6p86bgmX3YW84kIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tFOcBlRt6Gh7brG/TxqedfgZ5CIsMyv4dA0yNjDymkA=;
 b=OSV2JlvtrNXycpjfxNv/tdmcQfNBnJybE9YaQd/VSwu2dM3sn79XDZE9HvafJjyy/eGzZd5AnjwoH5/vJh+6mrAmccWD46IAE96T80hPRlJG8IEK0E1OYjIPTuEkfbtfk8fy0dltuVJP5YeuvoJgAeVZPc3SjvJCIhlsQfBJXlIoXthOj9ja80rXFH46zy1g/nHcEM/2s8NRiQMKrUD0YxipgoEHEU9cwDI3QZdb7UBZBzROmqyvOYn0VhWPfH9WxjgBwf0exG6OP1P9LJtLFDY7uPefPp/EmYYpvWLsSR5qfTFLos3ztTN+b4KbLgLgPa5pPT4pVvQ76dV93A+H1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tFOcBlRt6Gh7brG/TxqedfgZ5CIsMyv4dA0yNjDymkA=;
 b=GM5lzWFN/GfT2Oo2dtbhmuZXGwDmGrdJDf0roKgXKfUwguRfhIV6D/hJV4RALDg5R/Iyu9ehn/aRtc6K8Oh1yWZCKVUHeKfoPUmvKo+BYD9OIga2nDYrTnqJ2XdKU1EZmApdoIyiRjBakmekd0VZKxMHkxfRU7FsfEH04M9vDJo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYCP286MB2688.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:247::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 02:48:35 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 02:48:35 +0000
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
Subject: [PATCH v3 2/2] PCI: dwc: ep: Support BAR subrange inbound mapping via Address Match Mode iATU
Date: Thu,  8 Jan 2026 11:48:29 +0900
Message-ID: <20260108024829.2255501-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260108024829.2255501-1-den@valinux.co.jp>
References: <20260108024829.2255501-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0079.jpnprd01.prod.outlook.com
 (2603:1096:405:36c::14) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYCP286MB2688:EE_
X-MS-Office365-Filtering-Correlation-Id: b5c53c05-2a33-49a1-4f23-08de4e606b5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AdQmML9RfoHT1vfKr+H8L1yeoznNviNNYZTE2oXDoA1OHabTh15WsqpeEp0d?=
 =?us-ascii?Q?CHasd16Z/MIZ8JKpfawlA2R48PJHlbe44Atpz1pTMj2GxrJ35vZOQJ+s3siH?=
 =?us-ascii?Q?kCsMvZBzu4bY/j4iB1En3DlbOcZdjw48V/ru0Ob//U4B09rFgT9GPnK1/mSf?=
 =?us-ascii?Q?L216+HcrtC7kG4ZaziTcib1yIqHWjePGeISyIjVjHHD7TZtS2BHUOHdHDVfX?=
 =?us-ascii?Q?SiCEitwwoOaVNKHd4Jzds4Yg4ePb7FlI3tZV/12sjDA/BkoEYi/6h6MJ5Oiv?=
 =?us-ascii?Q?sWRZn1D8VGnuhNQptGKImZJcYrC7+AFCT1GN1aVDoIYRUw7yMvogOqrMG1BR?=
 =?us-ascii?Q?wiXP/lvfw5N4BHNER7AGwXQ+lTfSLp8MVhe78sb6PRtrqhDtGrFHl12qay3x?=
 =?us-ascii?Q?xXZfdKT2dSkSODNhs6pOqJ78bF+02F09CLCTLhU3WFGBnrVbxlGf5OY6bwM3?=
 =?us-ascii?Q?wVpMxuJ5CYssinvjWoMZDW3acLaiz5HB5QzqqoWHmNWNshRP850c2tqk93+s?=
 =?us-ascii?Q?C2CtrubHtOaUzPrNWT0tLNsFLLL8EvylBbCI5IBfSXffesSJ66q4RLy/M80A?=
 =?us-ascii?Q?+U7HJ7xDOl7+m686pf2Q+kclR4DAaxVEQNgUZb5+kAa5zodSHThgmq4KB+84?=
 =?us-ascii?Q?d96M9oKINcKPt8yccXiaR5FymHiPrjhZzXsSGKX3w8b8F5dQyq6GPVcZ2Wvu?=
 =?us-ascii?Q?qrfD01aN+sGEcW9J57Obja35nSiVWDu0Xq//pfXZQGG6EHnjLACYqYM1UBWR?=
 =?us-ascii?Q?vLHhcaYUNdDR6L6BmHSRbfaUpgF7dY83SbZ24uVDrAaIs9sl9vGYFIjJEftM?=
 =?us-ascii?Q?0pzszhyV4bsEuyKP/DCRdOf2Lpq4U+ScPK9S19YBuv0EscKGd3ZRq6/oEW2F?=
 =?us-ascii?Q?4GPUVnbzgLGDmCjj74UG3rpnbdQVwFarLAQVvtTYamZ0NWfR8FLAtkvOQe7A?=
 =?us-ascii?Q?meahd/t5pSPgdxriJrE9GFlpG9Ra6N4yq/sB88G8CaozQt4vLRSmNlzjbE0g?=
 =?us-ascii?Q?t9UtOPwpGVMN6k+6KgjX/03uA1xqHZe2ShX+e30+dolN4S5R+YgjqLlIHo+Y?=
 =?us-ascii?Q?Mva0Ls4tHZXxHXLWuYJ297IFA3bzHuR0EkRIZSt2M2Mk3i9c02n2+HVEN65l?=
 =?us-ascii?Q?ilHDiQFO6B8RzvZIznPj0WZdhff7RNHfatC7a0YHZGPukDRfRUT/AK5kfuzO?=
 =?us-ascii?Q?X25u1dat1avggDij/qA7YMkMR0MeOdgb20OKwfv3JgwAsYAasQL6OdK+yN3g?=
 =?us-ascii?Q?U7AQXUF9XBX3VhgN2DKNoMWkEHzXzmCIYNhBAJSjuV3Pwqo0SDzvnDIu/k1f?=
 =?us-ascii?Q?IJZ51mjQbEgwlqCXNsJbMD34gIv2Nx+YaSK3+dUw8O4KU5llJFkQpDkgyJz1?=
 =?us-ascii?Q?U6xwjBs0qoF1jAKsQPQtGaFkGfCtpOlprQkgpkx6rx+bzJ8X2u6e3lZuvcKg?=
 =?us-ascii?Q?+nysVn17+qB2Qt0dj5V0s15Im6duw+88?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kKwdqyBKN4dZQmHpdFvFB1ocGyy86TXw5/dn3wKLFG/xG07tkbSWJv0WOzvx?=
 =?us-ascii?Q?1NNSNEvo4mrIjeQbnz0JRBly+CIHD/nI+6/+vDi9ZlIEFL4MPZRDxShq+SAI?=
 =?us-ascii?Q?6njPSQaeuMEynadIdzo/vu2jAffkY9I053fGk41+jxi2Pfona+fgL+zaCfpr?=
 =?us-ascii?Q?Mis98V4cwg8zZSyt9TdTNwn6PBSV5YAab5nZb0zUFIgtPwZ58zXv8T3jwJgI?=
 =?us-ascii?Q?35Rsv2ek5NENfH8Ei50vvxh81zdLmpgkQM8fLdA+kxhEh03fg0M2J06Utdi6?=
 =?us-ascii?Q?2H1vkeKtED3S43VrHWpcSJmiBn5TpWmgz6oYSVGIQUfKKYBwqhBX8YpvHlDC?=
 =?us-ascii?Q?xzUFeCmpfWEwjPZfxtJtGBstObpxCF0bP7LwOGemPJcn13xKvwOXIqU6hIO+?=
 =?us-ascii?Q?1LAOMxctt7cfKl2SvwjCUZzEp4CnIXNCY0sFXV8ANYM9hkQFHb4YFQyUFdJ6?=
 =?us-ascii?Q?RKy+rZMnNXRMYwQ0pxacf1vQB4vM1yeyNAAHhM75NbNfimIB41KvAVZ3yNTH?=
 =?us-ascii?Q?fYlsAjHEXnKN6QjIxnNomvCzo0EwCsZ0H6A/IjtBMKt8z4CXAZ9xhZ9LBrcd?=
 =?us-ascii?Q?17QhX9z/+qWKJYn9N1klyO60K9IRfLqLH9fe19kUDhbnZDPDx6viF7fG/vN+?=
 =?us-ascii?Q?5vMWg0FtmI7cTbfY1aVq8/YaTYiiURky8t6XRxmBVNDlNYumKsjqUNh/jZGJ?=
 =?us-ascii?Q?WX6SVwaW2XGtVF3Ets3RxRX62v59e5z3RliBCl8ZO1QUQqGFBDY5LZlBB4bb?=
 =?us-ascii?Q?Svtr3/k2cLN5SZbTWiCLoY3RadzFEYO9rL7T3T3s7ks2qDfz55rUX5PdcNDI?=
 =?us-ascii?Q?qfKvlMQzO4X0znDu9k3rT375Z8Wn3mrjok+8uMsG07iWmLoFyyF5HIx9DInT?=
 =?us-ascii?Q?9p4goCKU3MQwPMUV341pU3fZ65juEF8WfzWXYEcPmPau4hYOkG7ajb6cNDwm?=
 =?us-ascii?Q?jI3LiYjNocZ1qtep2UinqXelFJHUPMt04/+I4pGztBqqgpfUZgbOeUyQPIiD?=
 =?us-ascii?Q?xRJsVtuDrQ4YnTkEs/YYDi5KE6ec8G5ti7JzIj3LBPoQsrIwBPApeMvIqxrQ?=
 =?us-ascii?Q?slVUxN/jh2tuyuKV/H/VGyMD//F/hF1pmbSxgAwaKGe7kj4tZBhT2eJZ+Khu?=
 =?us-ascii?Q?/8ykFpWFLArdFF+4OEPrCUnhl/8zM70TNMD2SPzttbDejuqGlS1BzjiatY8o?=
 =?us-ascii?Q?JS3ZL9DKhtP58dAoGUIjuxDvMH0IWob7pbTbvdNfoFv/uWKVh1hCD7raLP5I?=
 =?us-ascii?Q?JRC9soiz0M5zmamT5VV8buFjL8zm8hSnohJ62fHuW5aaco1ZqwSkWZ6I+Khv?=
 =?us-ascii?Q?xtxSZVKB6R9FhNmLMxTh6UTwuah2fM8YQJmRQCDdmvomlLGfmCf6bfgyb1Mc?=
 =?us-ascii?Q?Z1sDwfycSKnsfWrbgmtQXBUDmiKparyCFGe0+V23xxhOrmelq5LbQzhVEmSX?=
 =?us-ascii?Q?SoPcC8qB+LboviH8mKWWjhc68E7PyBZVBKHipD13XxrR9FvN8+t4W+Rvaimq?=
 =?us-ascii?Q?+pEMmYjwAJoGdLOCNdXCc1kSjUmAYy02YAZq+zCqOd8wL0ooMcc4QgOeaMOt?=
 =?us-ascii?Q?FagQ1VR6LwpsFHjrKwnqgLt1rzjrIc7zX9jETRbHLrHyJWfMqzgYT5rnkInj?=
 =?us-ascii?Q?ZpdGYqTEKCETBs13E9QrlaivfBrBw4H6q6R8eGVxV3364Pjm1cExGcxzSIsg?=
 =?us-ascii?Q?VilzmCAuMJvK4dTASzIS84PfhsKpvHphaNNt6jJ5qzag8EjwsduxZL1pBWUT?=
 =?us-ascii?Q?LyJ6TnxhLWiu3vH1I6SvOkYvs6OI4aktjSmWp3Z2zYEyMKxiEGdo?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: b5c53c05-2a33-49a1-4f23-08de4e606b5b
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 02:48:35.8676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r5eXypOLLZTPIBm9Nld6PltYzsyj0/kyju+CHGa6aaRm1sXF8uaUvG5l7Y799tXPD8ckhqNv7hk5mmhq8uYg/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2688

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
 .../pci/controller/dwc/pcie-designware-ep.c   | 234 +++++++++++++++++-
 drivers/pci/controller/dwc/pcie-designware.h  |   2 +
 2 files changed, 225 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 1195d401df19..a830c91a5849 100644
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
+/* Bar Match Mode inbound iATU mapping */
+static int dw_pcie_ep_ib_atu_bar(struct dw_pcie_ep *ep, u8 func_no, int type,
+				 dma_addr_t parent_bus_addr, enum pci_barno bar,
+				 size_t size)
 {
 	int ret;
 	u32 free_win;
@@ -174,6 +177,208 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
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
@@ -204,17 +409,15 @@ static void dw_pcie_ep_clear_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
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
@@ -408,10 +611,17 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
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
 
@@ -1120,6 +1330,8 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
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


