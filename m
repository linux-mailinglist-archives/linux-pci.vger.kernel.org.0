Return-Path: <linux-pci+bounces-5331-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB53388FB25
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 10:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0973F1C20E16
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 09:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156D77F49C;
	Thu, 28 Mar 2024 09:19:15 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2091.outbound.protection.partner.outlook.cn [139.219.146.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4800C7EF02;
	Thu, 28 Mar 2024 09:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711617555; cv=fail; b=GjqYScZAVMSZk6cQ15dvCm8xXem5NoUoe5Rs86eR7TCafq2mYsewC0zNqz0d9fRoSazKAyE9VCq2bdtNFxQUhWcnWG7Fs+8yEZOwIhn80eLv2nfVCswQQiBiCBXu597/Uk/832QockBgVGv30rwPotv6pk9naSyfQqGrtT50G0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711617555; c=relaxed/simple;
	bh=XbMLnGPr5OBqbh93HvQzXgOBeg1vYpKPC7MBOBuc8Xw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pK7P6cVkuOiNu9FLQf9I/aROVyclwqZJ5gLWndaWTkd1iYbpPaTM67ykxb2K3o5AMW7dMnhKqEULEKAfhwGUXixoneag2Pv5OTMjW1n2w2c56VfGEUbYEMNI0SuisH1BBf7K6hkfuZtrN5QJssQiqiCC+s5Izq3PsUNIQBg0gxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PrSepQpN4opVeF1rOD46G5/83Bv7lOnzHG7vpLbdhqny7446IN9SvBw07Z49ONEEdek+75Cpu2LR6wS+5sJab6hugLSP/4EUxTP/his1HTzOO3V63/oSX9IfiUIrU32pG8xGrVp5qCF6P8j9Dg78f/AKM+QVsbBFPqzYSxu/IufbNOX3R03ozNwygyWrjdLjPNaYkGMv3hfAtWzMUglX1s/L9tZHGF9eDbko/KtFCAtsYJLdg261+mN/DymEZPuSI+UpmYmlh9H4gG1WK+iyCtb9E7uqGCrSYJaKP9SZQMwgWHjcY98Mc9I9qrEUvLbuVC1tkpTLRC42nQQ6LdJDLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pQYnRzgxovFl7xfimnJKAB/d4LfDLVgqCHac1Hq3w/w=;
 b=KWO75eC0za749YWoYBVcHQwBy9hUUx0QlriFJvr/IpepR5OLsyxEE9oPywLJJtbeK3LMqWNpkYYSjbbUjjtaZZW0vWXaryygIMQFT9e/Qqp9HzH/hwD1ZIPfMnXlIYymcqyfBWa6NoBIuqV8hhQjKUS/29g6JqbSGZWq3BrXv/kLX+i/VoM/5Rnh0Zmlf2qNv6ccLlY+2V9NauXM1QYr/0Utw+ZUcNR4YG0gzMbD/RwJw3Dgy3zCWZXmVvNzrJXWNE9tbsFXvPye0i/Tz4zumlEnoemBxoz3JTZMk/wVhvD5uzMvHSWZfNL6m240vCmUD7IBu9+EIOKQYpWR59vRzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0559.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 09:19:01 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::c738:9e6b:f92e:8bb9]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::c738:9e6b:f92e:8bb9%6])
 with mapi id 15.20.7409.031; Thu, 28 Mar 2024 09:19:01 +0000
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
Subject: [PATCH v16 17/22] PCI: plda: Add event bitmap field to struct plda_pcie_rp
Date: Thu, 28 Mar 2024 17:18:30 +0800
Message-Id: <20240328091835.14797-18-minda.chen@starfivetech.com>
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
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0559:EE_
X-MS-Office365-Filtering-Correlation-Id: 445ab9f0-8715-4448-ce72-08dc4f081ae7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LFrwNV9G7r3bH8mdxWrN2c4nxtkXeQwqwQkUdQg/rsoxJs1qWOKzhPrtTXsbxjWXvbJh96scV3QXKAJTvgkNq4o6YlOmsC/V9JTpAvS9hUCEDtRuRN9NoMOfsegvQ03abhmph/Mwa3DTHb7qstuicMZl3GSU/5I83031wZ+acbF/ef5aKnIKw5/g18nvLXWv8GwT091fGa5dUs2Hw5edcxWpHDzEnonDMgTp6X3ODy5Yk3GAwrJau1DXYHZorAM3dkwdDFEejzpwWFt4bUp30+Jn2D4se3QoDG4Ydhrhb4zSOvUsB4CHfdnClTR58yuiftLanQd+m3Qusa1+roZx51SM97DJsRBIVZ2rVzu36vVu9Rtq7ET5aOwdAAAnBARLUcxWUBcMu3AS9yy3qbo4wCd5hXFwsFQ7fS74HjJnQWCObKZokp4XxhV7oz6RLP3EbMrY4dNZa7ged2qh97L2dThKjY/NCYUCkj3X8u5II/XbYkk6xWyKG+bFHbYb50i8kL+C9PeWv6kjRDdnpexgr4smARhjXGrm4bQnWcdEO8yhntj/5VP88GQ3Awg9K11xwI9E9kuLhdojkqYxlZOaFVuu9anqcdpGx4d7nfyAqaCDqyZpcSGsiY8Qab8lWj8T
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(41320700004)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?co3SV48NyqBhJP1EuNn6z2TAOGrrkH0eDOl4gm3+s2Ovmjkp8X7o1NqNu/4y?=
 =?us-ascii?Q?NK44wKBeG6p5p7MPZQ7PByv5yfW2YM9ijFci/VF7DbgiYfkytyQzLQ3UXOYl?=
 =?us-ascii?Q?IXqMzGKwaOKY32ORwWQxmxZ/rwHFT3WX3nWgGye+g005x+VRVjSNilIxH/RD?=
 =?us-ascii?Q?gTRWYabN3+YcqCLcxKeO1STIvHX7umiTjUcHOZqfpiOi0hve6kuHHrcKlmSQ?=
 =?us-ascii?Q?F386gYq1UheITDPnO5DH3/fWddg2cXhDQy7xOWCVpUenCr98G0WRnHXpPVI6?=
 =?us-ascii?Q?WchcsBOUctt5PZA8BL8eUl5Intbekf+k0uTu0pnbTiXpj9pFqdwxygNedtk4?=
 =?us-ascii?Q?trxKh8QKThTh5CfZ1YJ1TZ7+dkgp1mc7oFAAwycVsKZlS13Oyo47BR5EVOL4?=
 =?us-ascii?Q?g/PZn7+CQA3I0kHX55xcRH/oeZt13H0yty+spgAeuFN7SC+KoYIQXJYNVenH?=
 =?us-ascii?Q?WoQZFcSW5Z2nnPKw9zN1NWzQkwcH0JE0LCsiu5V0FsFaLvNQHWGBSM8L3IlK?=
 =?us-ascii?Q?vxmUfY3LKJ2ncb3+ooAap2wn5L+7mUjl1kx0avOxX25U3uaeGvt/ZRV5We4V?=
 =?us-ascii?Q?x/OzHMTIxJqxM27mwZZrFiC6MzKNYoU7tUudvw3bFdd0LOefgIGzeanp+LYh?=
 =?us-ascii?Q?9fuwGTd7nJX2Z4qJ5i4uxH1XotgI4ZN5qylyq+raOx64pIuMWdDXXz0YUQxh?=
 =?us-ascii?Q?VnRGq97gYK7s67yNpbYPCpEA2Hin0sZospH2FV4ApOBaOjNFUacJqzhiVkNU?=
 =?us-ascii?Q?fX1iLTirmzpiX0bXyeqT9wZcGB/r4/LaipXdpCioRyKJ4/tRwkHNuStmH9Lf?=
 =?us-ascii?Q?BzRDz4orNQGYl0GrF5h1NlvW+rQk2JJZbMiy5L+jvusb6pihTYQyfvprGUEj?=
 =?us-ascii?Q?I12SaEiwOj9UzSkGLbi52/mj/CGLB7gF79p7+pZU/hKnmMic8hm55VRoD+iC?=
 =?us-ascii?Q?sVba4Fzx7dSrL7jpKAd/Z6laIp03O1cHcfde57/Zgxv22HLynKOKTUdBLsso?=
 =?us-ascii?Q?zzBxnFkeerOwqgUL7l1adol9/Ld9XdwCiIPLwo3PyTt2KNGQhv9l4GOWcKr3?=
 =?us-ascii?Q?jO2vw968k6LDRYmv1wn++6hvHwiV5Ej1YC/DeoDVaoVuQoUrZzQelX1fkY+a?=
 =?us-ascii?Q?0KI4mO/Ts2lIQVB3/chO3G3j+suexUI8VPckaXqEYYNC8Oq1tcLS2gnm5Krq?=
 =?us-ascii?Q?TM81fWfQfD7DhAufQyJA0Es2MMGRIwl5wjpxTkW2uN2fhlNyXMmchwsVGGTB?=
 =?us-ascii?Q?7juiKp9xo8n09iFAGlQgesTCdwIx6JwPHTQ0WY4SHSXchiEfi5yZAxUB6FBK?=
 =?us-ascii?Q?H+8OSrmcZRF1/4Jx6KgtcdcI4GxL//pYwfXJ/otwwLHAcoAJeUqj0c+FXj64?=
 =?us-ascii?Q?6YSK/oA+un+ga0qPpDEBp8WrF6rNT/k4SipNxBpHjqpqrAPfBtYaweorQ5uz?=
 =?us-ascii?Q?sIFUO/4KAbYkoy0osPdQ2YAlTXMfM0ncZ8QjVFEwDkR7kodfAzzYLOoMxQfm?=
 =?us-ascii?Q?EvmyQ+05zqHgalPcS7RfC854JM/KfOC51O6FCHFdGtSgTsHL7K3NOe68YNC3?=
 =?us-ascii?Q?YAXLdwynBUT6XbbVa1xQapHb99Fsbze5C6b/BdeOxTVYvdDNWH+xRu+o758/?=
 =?us-ascii?Q?9g=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 445ab9f0-8715-4448-ce72-08dc4f081ae7
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 09:19:01.0705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TkqVPJJR+bgUukJx7rXKeKr4jWQZjMmifurDk01S6s2+cHF66fBkoUhDl0EfxWhHsJWAnYcm94MG4Hxlx+9K3koLBsR8Jg6DMFYLMQtWOT4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0559

PLDA DMA interrupts are not all implemented, The non-implemented
interrupts should be masked. So add a bitmap field to mask the non-
implemented interrupts.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 drivers/pci/controller/plda/pcie-microchip-host.c | 1 +
 drivers/pci/controller/plda/pcie-plda-host.c      | 6 ++++--
 drivers/pci/controller/plda/pcie-plda.h           | 1 +
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
index 105964306b71..48f60a04b740 100644
--- a/drivers/pci/controller/plda/pcie-microchip-host.c
+++ b/drivers/pci/controller/plda/pcie-microchip-host.c
@@ -636,6 +636,7 @@ static int mc_platform_init(struct pci_config_window *cfg)
 
 	port->plda.event_ops = &mc_event_ops;
 	port->plda.event_irq_chip = &mc_event_irq_chip;
+	port->plda.events_bitmap = GENMASK(NUM_EVENTS - 1, 0);
 
 	/* Address translation is up; safe to enable interrupts */
 	ret = plda_init_interrupts(pdev, &port->plda, &mc_event);
diff --git a/drivers/pci/controller/plda/pcie-plda-host.c b/drivers/pci/controller/plda/pcie-plda-host.c
index 98c51e594efe..a040e7e5492f 100644
--- a/drivers/pci/controller/plda/pcie-plda-host.c
+++ b/drivers/pci/controller/plda/pcie-plda-host.c
@@ -290,6 +290,7 @@ static void plda_handle_event(struct irq_desc *desc)
 
 	events = port->event_ops->get_events(port);
 
+	events &= port->events_bitmap;
 	for_each_set_bit(bit, &events, port->num_events)
 		generic_handle_domain_irq(port->event_domain, bit);
 
@@ -420,8 +421,9 @@ int plda_init_interrupts(struct platform_device *pdev,
 {
 	struct device *dev = &pdev->dev;
 	int irq;
-	int i, intx_irq, msi_irq, event_irq;
+	int intx_irq, msi_irq, event_irq;
 	int ret;
+	u32 i;
 
 	if (!port->event_ops)
 		port->event_ops = &plda_event_ops;
@@ -439,7 +441,7 @@ int plda_init_interrupts(struct platform_device *pdev,
 	if (irq < 0)
 		return -ENODEV;
 
-	for (i = 0; i < port->num_events; i++) {
+	for_each_set_bit(i, &port->events_bitmap, port->num_events) {
 		event_irq = irq_create_mapping(port->event_domain, i);
 		if (!event_irq) {
 			dev_err(dev, "failed to map hwirq %d\n", i);
diff --git a/drivers/pci/controller/plda/pcie-plda.h b/drivers/pci/controller/plda/pcie-plda.h
index eb9e6f304985..c3d8c141e44d 100644
--- a/drivers/pci/controller/plda/pcie-plda.h
+++ b/drivers/pci/controller/plda/pcie-plda.h
@@ -160,6 +160,7 @@ struct plda_pcie_rp {
 	const struct plda_event_ops *event_ops;
 	const struct irq_chip *event_irq_chip;
 	void __iomem *bridge_addr;
+	unsigned long events_bitmap;
 	int num_events;
 };
 
-- 
2.17.1


