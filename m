Return-Path: <linux-pci+bounces-1813-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 313F3827004
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 14:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AC4A1C22520
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 13:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D3A44C87;
	Mon,  8 Jan 2024 13:39:58 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2088.outbound.protection.partner.outlook.cn [139.219.146.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919BA44C83;
	Mon,  8 Jan 2024 13:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GKGkb5Ph6xG7WPkzUdNNvg/PRKxvjOTQQIoQVCVJJ2FZ3MjIGv8WNo2gRq7JEY3m7D3r6BXtqfoUG2qfTMXwAREsd8eQ0+qcMiyi7xGqnA2idL2m9/e4R0GFoNPYOckiVwsIVQAkp3U4CmE/xtqXPO5FATcMCHbWx+Hz6S967R2xiuPKHp2p71kDKYO110jF3PQYBG23TNT7rE54UgAKaG5VRMeS9aCSlSqcysTXgtB5ZxhG/bDKDfr/IOnOMuiRoJLfuY+64mG3rY3TQUvFcGpb6AHn1+CPzUW89SAsgLLgFGISclLdWEXwc3RuX8MZl/hCENnsu9SaBn0HU9Q8dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VXXtaYWxPM3l50fI5furwsMZGzPDogGyg6F7i2V3hkY=;
 b=Q84sYDOtqnCpzqZ5X99uIw7JjlzlBo21bqi77tWdci2+6O+Qm5vfpq3mxo9CYKvkcST4GZP+pq0MkdsZL7XtNnQRasHzkv75537l3q+TNKpbQ/j4cWbG6WyVzkLw+XSza5PQNPJkQ4gYWknpsDNRaoWQ1aA7Ws5PHv8qYsuzRmaRpBvinGEJFrK07uNo0AxCS6xJ94GPQiNq8Jjayjsvsrq+dCxpktnGwJLG1ztJ5PnM9rGxhRdReOhuGf5rUcDT9y58Y4iKvrBO9bD5aJyE56e4EfCGGC1JSm+QXu02Z8884huy2vH58+U1ls7LzBrstbjbLPCK/KVSf0lUNOd+iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0797.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.32; Mon, 8 Jan
 2024 11:06:34 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::e6aa:baea:fd8c:4cd2]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::e6aa:baea:fd8c:4cd2%7])
 with mapi id 15.20.7135.032; Mon, 8 Jan 2024 11:06:34 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Conor Dooley <conor@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Mason Huo <mason.huo@starfivetech.com>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Kevin Xie <kevin.xie@starfivetech.com>,
	Minda Chen <minda.chen@starfivetech.com>
Subject: [PATCH v14 06/22] PCI: microchip: Move PCIe host data structures to plda-pcie.h
Date: Mon,  8 Jan 2024 19:05:56 +0800
Message-Id: <20240108110612.19048-7-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240108110612.19048-1-minda.chen@starfivetech.com>
References: <20240108110612.19048-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0014.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:5::19) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0797:EE_
X-MS-Office365-Filtering-Correlation-Id: f531cc61-3368-4f45-a6a0-08dc1039e041
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	w/Pl5HjmTUrcIdKsZguWYYaPeyhS7N8bh5GibwCttgbmIDSHxWvz9Szch7Bw0MALMsfiAAZW7vWni+wf9lt59ZCUURwH+xsEoEJn69ooV7mt2wiCMCLfC2Tm7sLRg70bl71+ZtAbr27NwSm0AhCa3ilk9kF+UXchqoqwXA4tA/7+9ZAXRs+gd7K3cghvUbL30y53JxBp0dHRVGUYDkjWnvmqfK9BVRWQtU1QFiyKJcF7VcENq3jxVe0btBRaUXU8UaoHNIt3j68kdaPfDNZvDX7a59+cVVrcs3DwswcifZaahAydLqcCZ14Cerl7HRAAIla7NhP4Ncd5sQXxDPTiqQJz+SD/PZMcC9Ti+gg1Pp500yIIbeeeSO7ojPrUNBOAAkl85bRileiCTgVqp4sB61/LOi/C7rjvYOeHq9Q1X0KR5Q3rIaVH9ncZv5EOS0ucB5FaM9RbK7qMZOxoKgn3tfuucc5ejBXnsUBzPP5c/GzfIMiXitv6tsWN2yJwYMPVeNuLwh+R1aIEjerugbeyQN72bz2cyhXgGhU83947tIlccfuGv+kJxrnqzr89RsEm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(39830400003)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(8936002)(41320700001)(1076003)(107886003)(26005)(2616005)(83380400001)(44832011)(8676002)(4326008)(86362001)(52116002)(508600001)(66476007)(6666004)(66946007)(66556008)(54906003)(110136005)(40160700002)(38100700002)(38350700005)(2906002)(5660300002)(7416002)(40180700001)(41300700001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TG+6TgETj91dIeuMPJNMn8JnnKo0yqf38mQB9kc9koaMbSwKe9WJR3aNpSLM?=
 =?us-ascii?Q?d+Of9lyuyVYljbSHSOLC4Nb7N03ooiQyViGjoI5RA2HpJlSkAh2Q+MvVVb2z?=
 =?us-ascii?Q?MCKP8qWDfAXCleGoQL2LHrtqh2Vs7DNrSjU1mYQuRzIkjEXeZMvbsrAg3Bh8?=
 =?us-ascii?Q?tUvn7kdpbNI5tUrwTm4Jrf33L40bKkL/dWNscn69+i94ce2V8ykqM/kJi0Q9?=
 =?us-ascii?Q?UEp577et98NqpABHkU3tvX+O0iZp5vYgKr5I0xUghUPukYXiWkY2xgLg0sZ2?=
 =?us-ascii?Q?K41cJGOctnqoPyag68yJZoUF+pJejaTWgmfwig2X7M9irsfzo+2BFg1Axag6?=
 =?us-ascii?Q?7VRiwebPd7LjE7X3hD0SUQWuxa0oEK2BASBRE9Wf+8L1n25qVjwoddkR/eMB?=
 =?us-ascii?Q?mjrEO05kjPmWWX6zUUsMnqxUr/lLszMAA2T0BIUVQq+X7lX2nF9/nIWvphih?=
 =?us-ascii?Q?SM63IKXLRnepMGt/NmONe/tIuToIShyDDzAHS8Pm+K+nkXsUIu0NF/OCrvsm?=
 =?us-ascii?Q?aHlGtC4z+5+B3xzSebRdVqqd18WNaa8dQgNAdmDT4SYhQ+vMzXBuGoWJ32ze?=
 =?us-ascii?Q?oHeKpTs9bHKM0TrYoXCGpiuONXZPPdhjDnPRrfKgXcy8p4ZCdN0lxMqEcTIc?=
 =?us-ascii?Q?jJ+A+1H4uortL2mdWPRD2/BNrSkevcDkZvs9EXKr6SyaOHwoFW0F7rw9R3ZL?=
 =?us-ascii?Q?g/Ph84oSLATz4FReehhIS07CMJgVxmuTLKbkYyK17jurIYK8k+WxmAiJEmbN?=
 =?us-ascii?Q?C2s4HdgVs7WVE87/kmwUhUS1BgBUOjZsmudZu1rGth+5mJ3HoJyWg84g3rgb?=
 =?us-ascii?Q?bpDZY65hec0jaxcQLjsyfUKsAyLh3D9qZ55RuKMQ3aHGkfcqkMk4UiVnYWf+?=
 =?us-ascii?Q?qFdrAITVFNYOP2d0UOmfjA0Jx971TFwN70fVlxfsyJS8S4VgHIxN5QOCTSBT?=
 =?us-ascii?Q?BsFP9hdebtNNzAGzK6Xv5BSptdy2I8pe41KACZMcDEabWIpn+uzzf1QtBOXF?=
 =?us-ascii?Q?NcYT9/dO8M/2Be52rnHVPfy3Vslt62Pf420kQc27TGSYZcxUKqYy1WKm+0p2?=
 =?us-ascii?Q?gtQreVDW8CK/vaauGwdzdzm3VOsee+zDU5v2G3kk94mZrdV+jKDMD0yLztSL?=
 =?us-ascii?Q?IO6ybiPD0k+KXX6Zwi6OG6iOosv2kPzUEbhU9PC12wM1qG1GHp3IRig4RXNu?=
 =?us-ascii?Q?/X077KSGFiggr6QoDdwQAG1jCG5MvfRvAUE8ZkFyJAtzWtyVjKAuhNG7Kl//?=
 =?us-ascii?Q?guL9VVQB0tPZRJVUiVfSAwtybpyIC9yFK83QCkCjQBQlpmMmCS20G46qzRqK?=
 =?us-ascii?Q?ZjBFAenMOJtFCuEq97d6xtgur7THFyNW+uerS30NWBjX6XnJadcpO0SUaGLL?=
 =?us-ascii?Q?tbTAxqPBekdvIRTcHmEsIRTKTXO5C5bM3YkxsBGf2BSebC5RI9zETNSCJrEE?=
 =?us-ascii?Q?WkoiCgm8C9/jl7is6WK/gVSbdMZlwJ2u7Q0POCtI1ApNYi21BqrX53d6vyrN?=
 =?us-ascii?Q?0b8S/k+lSm3uIvK98pNbz2BTtS5LO1akUyY0BtRZYXvVELqNmD3ngjnsGBV4?=
 =?us-ascii?Q?uQHZKtUfw+tuM9uzz9r9Xe6421ExEtSPOMhougvHuQOnd5hES4Li8DW7FzD4?=
 =?us-ascii?Q?Ig=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f531cc61-3368-4f45-a6a0-08dc1039e041
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 11:06:34.2687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +NNgNxdOfRSIdxqGK0U38oL4/g0OI5mzsjxuDSJF2uV5vtjDNR6vWLdKC4RYpxIOuWl50dthkVDVonOFZVYl95d7jlLFILEIvXycqU+vKGE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0797

Move the common data structures definition to head file for these two data
structures can be re-used.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../pci/controller/plda/pcie-microchip-host.c | 20 ------------------
 drivers/pci/controller/plda/pcie-plda.h       | 21 +++++++++++++++++++
 2 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
index df0736f688ce..a554a56cc0e8 100644
--- a/drivers/pci/controller/plda/pcie-microchip-host.c
+++ b/drivers/pci/controller/plda/pcie-microchip-host.c
@@ -21,9 +21,6 @@
 #include "../../pci.h"
 #include "pcie-plda.h"
 
-/* Number of MSI IRQs */
-#define PLDA_MAX_NUM_MSI_IRQS			32
-
 /* PCIe Bridge Phy and Controller Phy offsets */
 #define MC_PCIE1_BRIDGE_ADDR			0x00008000u
 #define MC_PCIE1_CTRL_ADDR			0x0000a000u
@@ -179,23 +176,6 @@ struct event_map {
 	u32 event_bit;
 };
 
-struct plda_msi {
-	struct mutex lock;		/* Protect used bitmap */
-	struct irq_domain *msi_domain;
-	struct irq_domain *dev_domain;
-	u32 num_vectors;
-	u64 vector_phy;
-	DECLARE_BITMAP(used, PLDA_MAX_NUM_MSI_IRQS);
-};
-
-struct plda_pcie_rp {
-	struct device *dev;
-	struct irq_domain *intx_domain;
-	struct irq_domain *event_domain;
-	raw_spinlock_t lock;
-	struct plda_msi msi;
-	void __iomem *bridge_addr;
-};
 
 struct mc_pcie {
 	struct plda_pcie_rp plda;
diff --git a/drivers/pci/controller/plda/pcie-plda.h b/drivers/pci/controller/plda/pcie-plda.h
index cad3a98d967e..7bec6a470758 100644
--- a/drivers/pci/controller/plda/pcie-plda.h
+++ b/drivers/pci/controller/plda/pcie-plda.h
@@ -6,6 +6,9 @@
 #ifndef _PCIE_PLDA_H
 #define _PCIE_PLDA_H
 
+/* Number of MSI IRQs */
+#define PLDA_MAX_NUM_MSI_IRQS			32
+
 /* PCIe Bridge Phy Regs */
 #define PCIE_PCI_IRQ_DW0			0xa8
 #define  MSIX_CAP_MASK				BIT(31)
@@ -105,4 +108,22 @@ enum plda_int_event {
 
 #define PLDA_MAX_INT_NUM			(PLDA_NUM_DMA_EVENTS + PLDA_INT_EVENT_NUM)
 
+struct plda_msi {
+	struct mutex lock;		/* Protect used bitmap */
+	struct irq_domain *msi_domain;
+	struct irq_domain *dev_domain;
+	u32 num_vectors;
+	u64 vector_phy;
+	DECLARE_BITMAP(used, PLDA_MAX_NUM_MSI_IRQS);
+};
+
+struct plda_pcie_rp {
+	struct device *dev;
+	struct irq_domain *intx_domain;
+	struct irq_domain *event_domain;
+	raw_spinlock_t lock;
+	struct plda_msi msi;
+	void __iomem *bridge_addr;
+};
+
 #endif
-- 
2.17.1


