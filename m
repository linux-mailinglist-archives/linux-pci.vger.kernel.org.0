Return-Path: <linux-pci+bounces-5326-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 196A488FB13
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 10:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B5852920DF
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 09:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36EA7D3E5;
	Thu, 28 Mar 2024 09:19:08 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2114.outbound.protection.partner.outlook.cn [139.219.146.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B477C0B7;
	Thu, 28 Mar 2024 09:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711617548; cv=fail; b=Wej1CUHDrGv9+yp/R9ioldsbG4LXjyAQdTB/id2rt+ZEI+gvO9CEqNxsOk+ChqcclBpj5/xXOpy7QDtXK6dkI5+xHpTSVBaLBhqmz/PwEGQdRLb71nzpHUk/fLxfEM1JWeYaAdaV9zhOCtuySpdn2/0C9Wohhff0SiEwCoS4LTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711617548; c=relaxed/simple;
	bh=uG3O8dUKV/QjhNt5lJDMPRKzxxDT134aACSPlqopLnM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J9PIKY61yWIkt9RFyBYFJA3ldUjxOnyIafFd+RM1WrFRiyHnW1eqazdxXXHeEwryvj4X3dJYPxjB+O+j8Xdu+DWtL8P56mvZJz67OsJyD2YgPNgN2MIh47mA58X328K3C6Nwjg+KSKHAPb8ZBhA3ADIxE1/XYg8m2hwB+Ayidkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DRie1ElbU+KE517CM5J2TUblm00+JeCWhYWODvzDKSLye0oxrYDF2H9kzFvpfRozdy6pz7kAf+gxpWQpyLdeYBWuEuDwdUya2LNYrGtk8h+i7A4vzGhgpKMTaCICxzul+tJOcshhiIVZgeoO6LPYW0wN6+yDGKa2L4WfQedK/dC6r9AO5qFkFrc/aLIj213n4MnhwDkjznvkIcomEMa4Nv5+M2crbbBDtOCFBN2UodApFNIAFL/vTzWv9J1MBNSU6iIvai0eCRw+JkvhsTggUKChMkZkmPlQxH1f81THC6OP/Ps18ah2zc4t/kwJzw5MXx70BXo4mTP6tvta3cBvMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mmti4Mzosy+9FFE0EDrNRmDgW0khnDOK1Vefu3r0lh8=;
 b=l0/BflHbgl32la2uVngkWE7shnq7mx5i96Gylr91tc39V8ceHDF+3pSjd/WaT04kp00CW6hfpGZ/jsHS8VM3yyPcIvsihLnVkb0N4n5U/mi/GpdttyJfp1HK3CIIcKFrQ36X4H1i8+jR0ZPV4OwiMVtzE5pdB549c1PMyDBsgKnI405mbivY/CdZJvi8G2K9nePHs4kEt/POqhQnTgetIXTHqsATIoRoNIVqexQ9yi6twGjJSVMgd6q8qRLnRNHvYNtbhHjthM5Un9kD48+r/YL8klIalYoCpvTj8ZS6Cw64VXFeP8ZHO/UpaOBcDGz7XdNuzbnnLULG8loSer+5iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0496.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 09:18:50 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::c738:9e6b:f92e:8bb9]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::c738:9e6b:f92e:8bb9%6])
 with mapi id 15.20.7409.031; Thu, 28 Mar 2024 09:18:49 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Conor Dooley <conor@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
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
Subject: [PATCH v16 06/22] PCI: microchip: Move PCIe host data structures to plda-pcie.h
Date: Thu, 28 Mar 2024 17:18:19 +0800
Message-Id: <20240328091835.14797-7-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240328091835.14797-1-minda.chen@starfivetech.com>
References: <20240328091835.14797-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0020.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::16) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0496:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a4f727a-0627-446f-de7b-08dc4f081445
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	448CbUJaU/XAo9u0vVgaF7L2/pBSfW6f4x2+6q4B6jNwpDPUYaN4EdGuy2cJvZ+TJ0keS/WE94mlpdAxPGPisyxROXNVERoVEcS6B9HOIhUjkhOvv88hVkCjG3Z7EfWaIeRwoSLyIaFwcx86EtTpzTgBZxtirZkuB55xaaxmC/PEgRnJrxwFtgVYIOTXL4+fAXDuq9dOLQUnVzZR7QT5yeOyMM0A+BdanN73ed45UFbvlGISCWIy4oBcUjHOYm3L5gfBEVud19h2Qa1g5vr2GuQmYqLgltPp6FTd4psnKYbF8qrJMMqaPbtR5UuGuH7PgHT8AdL4kvKMYITYmsa1ZQdVY++wGNgKHy8JyUPdQWKWVqNHurBaUJLW+c3EbjOIq9Vru3IP+c4dgnenBhPtwy2lLPpaAFl37JCl/YGrzU+r/fKhXvF4sZ6cGrbiGK6bX70k4yjE9DP5u8ScC+94PLoOOtPR/wDXOzJGcM6+QibAeVvWm+oGuBurCXZei6TD6gVMSOpEqJlOv9ttcYUYzQ/OZuJgHsIrhTpDgb7gX/869+CeiMciRrLh40J2vUfYW6LESKrz992pncTj0qXT8niNyNjO+Zxol71JzaSEhBiZdhcYKJHY9h6yMyAhjusl
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(7416005)(41320700004)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hgXTPnRT1AzoRipI1ba2InjmOoYd2Id318iqgJKcy0LlyAw+J+5Izdeuf0+b?=
 =?us-ascii?Q?Pr+/MCUOVkA59lRJmmwsus0/sj/lO6BQFk5iPe5YKSAosuiAZapn0sL/Kf6D?=
 =?us-ascii?Q?g3vrYaHrGBFiVV8GViyMUlU7rCG7cwYUIuhNI0Nn11mM2anOHYGgD0D4bJRu?=
 =?us-ascii?Q?iCF9B2i0GPIOZbr+8PxRt+t3MG/tFQRSs/JJzVwaByYKSOWRK9AhyjTaXaGa?=
 =?us-ascii?Q?A5vtTtSuLRvmqYkdVDLb7jxoBtgCrtyQwE9MglVwQnCxMgIbMWxYaSEOkGh0?=
 =?us-ascii?Q?KOjIWW78voBUurP9LXZ+zUKJ5WAxowYO1zH462bYP4bezh1t+sSB6Kqtm0tX?=
 =?us-ascii?Q?wYqZseyw7cCz1FGUzCrdY+pcaaOMqyHaagd9c0lQdDJ7YjU0bZLboyOlMIXT?=
 =?us-ascii?Q?6bgiA5umh5hjZMWbGG7ljHS0v2uKKNHIfPYdLhwx2r0Wv96ax77JJkRO79AA?=
 =?us-ascii?Q?9GgT3isuABwy6oIZswXe6dVLoe5lxOBRAMGob61VUXGgSAlyjydJw3V3ynXk?=
 =?us-ascii?Q?PbGL3T5OIl4Nw2FrPkSfdQnMqxQhuvwMk9LYqfoZ5tA3jK1aouqVhv+gNWxe?=
 =?us-ascii?Q?s/b7mHgJoxRm3G+K8GD6bSFrJ/c45uUfoT3az/1Ns/nVHvVcKT+uYZCZKVLc?=
 =?us-ascii?Q?hdmq5K/ngFZSOE/20RMpVSo+Yb0uIHg+cOlgDrxsIA9PcPOVFY7wa09jYf/d?=
 =?us-ascii?Q?UlSUiVk9cKuRVHAO6rm8EOPDPod9PnbsEPCn5UcsJ8kPg2qqnduU2zzjItL+?=
 =?us-ascii?Q?RGMV/sJU5JHbKNBYJTZ32mOlDaBeo+9NSrFnWpwirG9j33Km8tZhLajqZVqA?=
 =?us-ascii?Q?zM1KzTvxKhgVKI/0bEfWcPn82SONyhFnAN42PfpYOOEboP+3w3EJRITqReyP?=
 =?us-ascii?Q?nYPbGqbe7L+HNn0m3l1K+ZyvzrWJ6ktJuinmFtq+TUIVcXqF4Z7zWJGeppNk?=
 =?us-ascii?Q?Mk/f/y9b2meVztp3RcKwjPg4VaowHcae3SH0rdp498QDh8V+SI1pX94Gw/tG?=
 =?us-ascii?Q?9FU0rp3uN3ThUTe+zea5WBNhpX8N0DmuF8LKwh4UyhEuZwWqwONkT7wSVVWm?=
 =?us-ascii?Q?ZrmLPqFC+MLMrexZoWsS+AIe85rXXiGx2/gmgsLgDzsibrCQKLHNoYcWHNQT?=
 =?us-ascii?Q?coTTFARcdX1DNTHGqWnCzWrEe4GuMhltVXKgCk6RFaFFhYEqqyfLhqJowmIj?=
 =?us-ascii?Q?gMGi2T9L5GUKdiDhYxTaGIHWV/TpSW4BD/dnfPgk4xpUhGyTkAGwbt1aH/Qh?=
 =?us-ascii?Q?aWaVSm7QSrwZ0ofoQ6kgkndFe82Lq3XXkfh3SACsjrUpGkMP5xF3nwsaE+OD?=
 =?us-ascii?Q?oh6zfH2jbvZHSmtbjRYP50eT4lfJcCVoB+GXYAd5sY4Fzx+s9Ye+xpMp1PSx?=
 =?us-ascii?Q?Yd4GiB51Fd48Lrj3mQ3RkPdXTBl1oQrlr2kG4ROnWIGc04FVSaO4LbanaIIy?=
 =?us-ascii?Q?iXpc1vQ9xXa8AIkwx7E+mlbX/isQFaGgnJpIcp3utYjJUqkugl60pefx1NmC?=
 =?us-ascii?Q?idwISF4zeH5TXflN44R4UexotCQlflhjIBWU/WTejuvzuMeVcYWEtt7SuoKT?=
 =?us-ascii?Q?DvBnWCyhLmQWhAOsyMbO2uppPs7HNhZcuvc2Gqdy6p/x2bv4D7jA5UEHS6u6?=
 =?us-ascii?Q?nA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a4f727a-0627-446f-de7b-08dc4f081445
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 09:18:49.9299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LCHQ2sJHbI/lT7eo2ROwhPuuYZ+Sxfs29NJD+imxzLfPJMh+gkZZJnHXBaiI++zLXXOxQAyJa0ojj/it/a8ib8kjDUGET09inyxbr8o65Zk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0496

Move the common data structures definition to head file becauce these two
data structures can be re-used.

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
index 65e0f3b72184..9ca66916c609 100644
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
 
 #define PLDA_MAX_EVENT_NUM			(PLDA_NUM_DMA_EVENTS + PLDA_INT_EVENT_NUM)
 
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


