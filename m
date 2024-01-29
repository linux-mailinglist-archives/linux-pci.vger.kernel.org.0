Return-Path: <linux-pci+bounces-2681-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AFA83FCC6
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 04:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE8CB281745
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 03:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA7C101EE;
	Mon, 29 Jan 2024 03:35:21 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2068.outbound.protection.partner.outlook.cn [139.219.17.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA98101C4;
	Mon, 29 Jan 2024 03:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706499321; cv=fail; b=pS9kaSEcRgYweZUTNapcU20rQNT+6XZX17KVR85R98BKvTsiNQhLsoqIj4xeKzJinnNiN4DhZxIITeoWtfMLpuQb2wHS65ryT00OA8bjDzjY2uw7caj7BBsaATqu/980SkKr2UUL4Uvq24ZcOG+sdczPIJhSxTI60Z1I4QUfXqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706499321; c=relaxed/simple;
	bh=Zr4mWUFXYvtyxcrmFpVmK+dYKLWMemI9hE1iMc5NAH8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o3whNROIjBOvsBTOfWBis3ibB/J0vXNFEcBcSltRSg1I4aplWIuJmHn3g5C8DQbtcoFr6laVFWrHOy3NbdHWexJMQjY7XziVgde1DTVgHUBGYhrScx5XLdqV5N5uej6bBZSw8sp+bjIDq8iO1x66XozENS2/TdjMt4AuGHEiMPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oLDWesBiLGFcXAoFBSjjsp7lVykU96eHn2KjfdB/WXMdkpBZ9C2EWubLDYA/0SRsrwecveyjg8BRyej8aul3z96Fy2FMXpG5JP/BJ7zilWDip2cRMAKWLvJEH0azlPD/lQuyb8XgDqrgawkBFZGbcWC+a1Go/LWEaMioSrEEI3aV2ZhWhOP39GHRa0N213JU0OS0/T3PqP/KXD1osm1NxsIthrzK7nEnML8rU/QrPqFfrBSiFbKoOXcIyA7yu0JxnKy6mC+/XckbjYtHaNJQ/zP3FldXoFjx6u4dS9dduEju5wVU8+2vabQ+MmwPx2eiILkz/B6MztHZBbgym35k+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vTje0ALVDFVTLXaFJ/d5aQDDyaSpWhyjgAzo6CfB/Hs=;
 b=hO70NpuufTFbjPzdUC1mvJsoaX9rmusgS3XmcJ3CjgO2xkxD5+JnACG/b/GU/nHcsd9Ue45Qm9ioFefuV1NWLI67YrSqGvHvytEmAe9rl5m3y6am6l79EbmefBK8AN7TA8lzluOAqvSU6sF2+7+R/B/Z4s5+WimLVNQ0qFsQdVVTTGnCdu/1vmtubJliY1myETTTp5OUL+7CqWOmCW+KkbeQ696xqe7jW7DpO+aEzUkXSfjY+iGUcqhbAOSrOUSyoQGiwUStH9QGcXHVeqCsi2pBhz4GmN4u02vh/EKThuoc61yidSOomRMul4LLgBjx39xZMTbN47cjA4KREYauQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12) by BJXPR01MB0630.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:14::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.28; Mon, 29 Jan
 2024 01:00:12 +0000
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 ([fe80::1ea1:19d5:efef:6fc6]) by
 BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn ([fe80::1ea1:19d5:efef:6fc6%4])
 with mapi id 15.20.7228.029; Mon, 29 Jan 2024 01:00:12 +0000
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
Subject: [PATCH v14,RESEND 06/22] PCI: microchip: Move PCIe host data structures to plda-pcie.h
Date: Mon, 29 Jan 2024 08:59:51 +0800
Message-Id: <20240129005958.3613-5-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240129005958.3613-1-minda.chen@starfivetech.com>
References: <20240129005958.3613-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0010.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::19) To BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJXPR01MB0855:EE_|BJXPR01MB0630:EE_
X-MS-Office365-Filtering-Correlation-Id: aa597cfc-697e-4027-d3ce-08dc2065a577
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RXXX1ZRZtH3joAuL7uIRfciliv5K1P4HOehVVMKv990OeKbNMc6Fa/eaf+DVw95YO4AARh4oHvzV2R5kKANRvHuyKkBOXdq/dsTOQ9dPOJwQPoK5vMoIIu3n02Q5Hr7L4xg0HyFED/Fh6C55XOpZ6twz+2q/3AH1UQwB6wQ4xzHPRtULtGtjN15lqz6xRzNRm7ds0TjHKsUofDaomoyBH9cn+L5c/1zjTZC0/PlqqnitSZwi5VuwryZcY4KyHcoW24uGlhCwABXhoWjQ1qz0hvfuobCwH6rXPuVauf124S04yW0EdZI1CEo/TBqhdVNYaOE5F83IZ1iuXbPCGu1ZbNPV7yp5sWq0D9XtI/K2fUoJmhhyeI7fLi7bta6UHwwaQLlH9A13NFM8QVDTyW/Tx4mS75tZ3lIOTb9Hv/tfyHbBnIlcskKXeYi3v1exie11/bsDFcg8Ie83/TTPGncaWDfR3qjtfzioLNO3QMyiLYqveS2B/cgFB02YWNy8GE6Gkb8vJHTWuWtHfnnZlYc7cTkzO2WOYRY8m1jd6QvyClqY92Q08jcoQRxUYWZtv1OT
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(136003)(39830400003)(396003)(346002)(366004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(83380400001)(41320700001)(40180700001)(86362001)(40160700002)(36756003)(38350700005)(1076003)(38100700002)(2616005)(26005)(107886003)(2906002)(52116002)(508600001)(6666004)(41300700001)(110136005)(66946007)(66556008)(66476007)(54906003)(5660300002)(8936002)(4326008)(44832011)(8676002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5RRHy8WLR3qxOlVn5Kfa60DJqFaPMsQt9nfbPPNE0cLnhoRXmo/IR6lOD91X?=
 =?us-ascii?Q?SLPqVVSL3sKfaGQ5BMKb4HuPMCRLE6JHI1aT58Kat0SL5IyJiAHyIq06bs8q?=
 =?us-ascii?Q?zNSENrlFeLfc1G9+2t659W/7Wy9bsc7Oc0GDPlA8R9bUEQTJQYQl1WVZUlpu?=
 =?us-ascii?Q?LHMZzeQLR6b9q5l3PchdfD6TV67BgFkds4S/KujsP6SSBoc36+QbOTp3QDdP?=
 =?us-ascii?Q?lkE4LULlYNpgaEk1An5WivZQ64fyNuJ2053zn0EtFYprpFUMP8WtQPqZOAQl?=
 =?us-ascii?Q?2NFmuz7wmAkpzVn5H52FJLkP5YcdFA1r7FcRIygXcGn+embujv3+kP7eGZD0?=
 =?us-ascii?Q?YH1NUkj+BTGpPeOBsEwHNHA14jlb/6UCGvA3MT0mgC6MbSZcZYhksquIBRlh?=
 =?us-ascii?Q?Jk4BRLUPhDh70S77gCEPeE6Eqysn1YMfbhba9oFwkG3pLXvRe72hNkiEaQ3I?=
 =?us-ascii?Q?PxLcGPWx0Zk6nqq2/Bl8W/m8SHKzguYwekXg2RBJ7LzlMHcbtRT996jGnJmj?=
 =?us-ascii?Q?uUmxuQDKpJWlo9Ns92tFeksGpB0DKoBJDX2diOJlPgIo30kRuReGv/03TmoS?=
 =?us-ascii?Q?YnKmc1xDoFn/ZB11UZ0rYHZljpY2Inqlh3jhcGEkyAv8qQQANXQCEY/7TeSY?=
 =?us-ascii?Q?5jUz/HMtpPihX9aLtcPF1wZ0BDYdi6IHEBeexX8f3d6z0GDvEeSH1sGp0ZEn?=
 =?us-ascii?Q?+9dh3A+O5uwT0YbGvg+nsSw0NPqaJdZDNBbaVlAI4Dmvco+iXtlWxtVSqC3n?=
 =?us-ascii?Q?8alL0na5pbqCnGUgxBg9pASnJ0LXHyUw79RSV4+8wJpiGvdttE3RA1LS9wRU?=
 =?us-ascii?Q?B96uiFCtvrY2skNcezIgdDyeH+NNdN9HDSrboY7Bzy5D2jmdRp3RWeBNrMuW?=
 =?us-ascii?Q?pCGCEZ1WuIQqaXu7ZCQ2CcFnNX1YGlej9qoqyL5RSd+9WbAMufXN6DA0xIz1?=
 =?us-ascii?Q?wvDaju4sLdHHF39+6LAGlwWfHTH9rNqPc9WuDoSEs/KVxwO6LVB4AVJj2AZD?=
 =?us-ascii?Q?t4E1zQRE2IksnNqkElRtpvOu1jjEeTicII3qnJU2yny9EpcseXljtADk1bvp?=
 =?us-ascii?Q?ur/gAYdNFTQBTh7vkyEwnEQvS0UgAPI9cBhN2dCPlcjtF8dMmSscQlpRIYAK?=
 =?us-ascii?Q?buPWwRh6dw4XY7bxQYPmX0FH1MlGkPuxILoDk8FOluQEchfeOY0AnHrkDxr1?=
 =?us-ascii?Q?a/24tGl8+xTao3Fj+dQuTUaY/s51qBXqwkSc5pC/kOXWIMzUt55svNC9Irsb?=
 =?us-ascii?Q?0iuUEr4TF74qOOEqopLgwsc1F1ILHCYaxaHSn7C+qCTr8OVD0HknmHdc5Pfo?=
 =?us-ascii?Q?4vh3LSY7OperURGzI+FGfXihT2ZzE7txoOvDdUifUW9CsZCbK/i8qYDHiMpw?=
 =?us-ascii?Q?6AV2lRrhSNLh76+CH8M9X8KNcAGgDFAYCCdfBOWmp9pEOhv3utRYuVCPYEHk?=
 =?us-ascii?Q?b0Goc4Udreqiwf0aVd9ZYkpJY6Vz3b8DJ8bwg8Ju6V6MHwJCGO4yIXobcK8h?=
 =?us-ascii?Q?bzVuAYXo1sRb1qZ+cvCEW6cODywzP7LAi2yXhahzqnhbM67pbdaf7+NtFFA3?=
 =?us-ascii?Q?IanOxRYaQFMoaVemSSsRSc12oTfrtWIQ9Kxykv1Is9gZvsiTK0OfjCsBCaj3?=
 =?us-ascii?Q?CA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa597cfc-697e-4027-d3ce-08dc2065a577
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 01:00:12.0778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DHAseEhrXm1zWUWC0jQKK1HLsE0WmO//avrYL4fB160hbJJGyL47Er8JohJocl9AN/wBTH3EOMVM7CBrk209hCvTbP5nIJ4OYHF+yeTr63c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0630

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


