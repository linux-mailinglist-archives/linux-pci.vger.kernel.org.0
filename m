Return-Path: <linux-pci+bounces-3687-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC3885968A
	for <lists+linux-pci@lfdr.de>; Sun, 18 Feb 2024 11:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6D99B2132B
	for <lists+linux-pci@lfdr.de>; Sun, 18 Feb 2024 10:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1BF4C3AF;
	Sun, 18 Feb 2024 10:55:47 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2115.outbound.protection.partner.outlook.cn [139.219.17.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471984F210;
	Sun, 18 Feb 2024 10:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708253747; cv=fail; b=gsc8fnqsaeGoAE+uSAirmPUpgfQCwnwHQBrtvkFa1m63rN8UvnKWB6Vdro3MMP6va3AuQLstDpv/YjfQUpNWITvJs5Se+Vcbyx1TuuhPb9yYLvd2x/oAjGY7RVJmdZu2CTRJKi73iFKKvyx48UWTOfE6sLH1Psc32B3vVD15EYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708253747; c=relaxed/simple;
	bh=BBYnptWQIjFtcUllo2fZRW0ZqwaT8YAxJA0EoTd48OI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VMaZwvzZeHe39yX0a6FCpS6hDBiyzxn7du4uhi/+n2cjtniKjD4xEIpgeEHj1+h1nddLyMcmi307sOetdHDt8reEfF92OFR1lQ9xFuHJ3tm25NZeY+1EygRvXyZIwiX3nJPCR9AmlCWH4mOVP0tjhS1gInr91xup59CdD0ZaPGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ooi8HT1DC0XrO8v0HoAF6V+Si6YjyKMZrOIh3UVFfu5UTJA2Z3kcM3eApyqPyDpk0gLxzWde13JdvmgYYCgtcg5BHpA/AVTKbxzQKqL0n13LMFvb9OeHeDXd3RzDUFypjvXX6i9An3imRwTZYXrDYJnaiRT3iwdkSQVhfvprGhddmWehweyQOHTnCfOhyAl0x18pYN5cHeNe52Xqk+7s+uBYoiFj546vEwEqguSKSaEaVGspBkuBKH0LASzulTtfrkhwOMo7/BUPRpILpE6G8vj7znEARsxT20qxLwBt7fbmzLDl1KtyWT7uUc3RhOF8jX0gKj8oiHN0Wg0GxSTrMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=loSF85QfSFsTWg1Z4YTdJt2rwA9n7SE/EKB3f4Wn2eA=;
 b=Ah4+AiASrc8j4dQDgoE76SD6UkqRgRajJYL1J4Lu+IMsR9rjHDs+tDLxwd4Lom02z3DxDC8xRAtO7Rig5DQcsYmN6xJuOX4/8vGTEouAkzu7igMXWwsvwnyGmWjbWCqELhqPEx3J3OpIxX0sO3KT30OApUTEf0MvtQg0cKBCSUiDMr6yCI54jOkuUA5ECklPDFyRqed+vEr87HyjxCpxskj8WghQ1Jy/jmA/Totfm5SEjicx8L3QvyWWkl9lHzh/VhUDybeTdcgWEdaOG+u9dEQU4fIRRv32FwlNUUtoNejjwC/WipPch/zAslzzdJADTNKWLtB7Bcxc0I2cq1KZ7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0765.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.46; Sun, 18 Feb
 2024 10:17:47 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::5a5a:fa59:15fd:63dc]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::5a5a:fa59:15fd:63dc%3])
 with mapi id 15.20.7249.051; Sun, 18 Feb 2024 10:17:47 +0000
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
Subject: [PATCH v15 13/23] PCI: microchip: Add INTx and MSI event num to struct plda_event
Date: Sun, 18 Feb 2024 18:17:32 +0800
Message-Id: <20240218101732.113397-12-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240218101732.113397-1-minda.chen@starfivetech.com>
References: <20240218101732.113397-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0022.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::31) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0765:EE_
X-MS-Office365-Filtering-Correlation-Id: 167f5ee1-297f-44c8-8978-08dc306adade
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VEQRJ56M2ulyu/tIthpjsVSlpTDpYLnThb2gz8lWAvuI+YFagjjhw8iZxDEFl2tww/6z7jMHHDWVK8sB18qulkML0xYy3VZIATiXZ9bi8zLdBYL39XzKxHT+IwnUhR77oOem49INcftzGxUwo42jRW98wMrZjzPbnMHNh4QUfzKex+f47DlQt9CBj4KgYIrurqLdwawGSjzyX7GgYns9gobV6srKTo4bIvQybdzaFs5XDa649W7Brg1cECJRtDaHzrbcHo+BTfebu2Ar8MpDKNeuIEA/TfwqSMeZ2nqxeo2E15NZOspLPDaZ7anB38CX1uey4JJnmF7p5k17MH7510TTGPZP599Bv2W1sMjmLrhBU8hsF9CZhoxHZYx5a74EGtAhrT08ifFmizlERXTt0ZOh2HEFoPuBJUr+OajZO3ibLMaRsaWuGa2i6bzGl3ysotaKxuiCkCP8dZdbxlRhqQVRf2RSsHQOUo21l5cwYM98cl3QckmCBpGgNOVHXhmItAA32o7K+rGM4JQqKYihsTEZdEKhTAQM6FrF8/ZwjjNLIoX24bvBGYhL3eDcezRt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(39830400003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(2906002)(5660300002)(7416002)(44832011)(41320700001)(26005)(1076003)(6666004)(8936002)(66556008)(66476007)(4326008)(66946007)(107886003)(41300700001)(2616005)(83380400001)(8676002)(40180700001)(38350700005)(52116002)(508600001)(110136005)(54906003)(38100700002)(86362001)(36756003)(40160700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FmwKvm/zcNzg66q5lR43oIABZpZzRo0o7rbq1vZtHlR3bkmXtvFMillV5Wo0?=
 =?us-ascii?Q?YjYOhEgucWMiSkTDVpqXLLIPlebAiK9WRcVfZ4kZGZzIwDVhaL4ByxUo7u0K?=
 =?us-ascii?Q?CNoIcZ12QH3edcmvoWaFvkEpijIbbHYM8JF19TbHGPuW4oFJsTvQi0eY1yDP?=
 =?us-ascii?Q?08scMtUCkvtJtXlY2NVXK7A+qfkmXetcMOop4wi20ZvnPI3gnZIvA6eRENB+?=
 =?us-ascii?Q?pJRUJyciyXkJb8CHPjWbGmm822MrIIs6NkKKqeu8TzZ3jcnBYwiBTo5+Q6eH?=
 =?us-ascii?Q?Mab0cy+rmXozw/yVxlMaqpsXdVPI5IlDvamcyarnraf9KPBD0KYcbzqRxZy/?=
 =?us-ascii?Q?ZE3dsPi0P6qn37E5HdiNkPiBJQxwi0AC4lA/lU3XJONwRwnLzP0SK6PPOE0T?=
 =?us-ascii?Q?rW/uV1SHn/OaqrOJrbYZ1p+FHN1++gaefJOZhvF5LlkTqjvS4GwhtH4u6bYg?=
 =?us-ascii?Q?q6IUehpdF52Rz3JsxibKcnJ/xYr5EX03yZmHoSjqVX5SOPgCiQ/NUOtQK4lx?=
 =?us-ascii?Q?FtuN0MtKsDHjBUx468MsWZGKwB/dk327V2RSJzdgYqUJ/wWJifA8p4IgVyqW?=
 =?us-ascii?Q?q1HSctzEQUmBNP3o7u/Xfrg+mbwiTocet+5Ra8E3w5/4SmNIR0u4JQfPPWq8?=
 =?us-ascii?Q?ySW8Jf23LsoqON9py7DfMEwnEdjl1dHIgbXAeMjQHGKIAoHK1U+WGeuvdAVN?=
 =?us-ascii?Q?edWDVYqz66P7XZgRfwjbuhPJxHomPExtqpjPfs7uXtkWNGm0bhi3lJEtwxGY?=
 =?us-ascii?Q?8fPez0sRxehnCna6KIDFsUnqy7C6z+V/uVeSk4IFa3CNjDqz6vxaOooNwgg6?=
 =?us-ascii?Q?0ENRN+SZ/RX4eEHLx+4BYxclKxtEOKOse2IN+tg3jl3vQzelBk/ldsXcDDb/?=
 =?us-ascii?Q?vN5j5BR2xtKIAAomCIViMiXO2NuLIoi/iMGtfL6mt/nVxBwPPv82lgE8OdT9?=
 =?us-ascii?Q?MK5Yd9ACmH76beZf82g5wcFFqsuDGCzz74jD+laXF5BcjGTQcTZhFr5+WPPx?=
 =?us-ascii?Q?8l/J6j7z2AD3FshvyOcJXI5/DWZAgs8hpyXQxbx24/4QOzQHulYUShl7HhHc?=
 =?us-ascii?Q?IhcmOOJrOigDeQgVacrWTJZ3F1hdi5+Q8oMTt87w053Vi0Oc3YL89Dlt098K?=
 =?us-ascii?Q?kQfXAmjD21UonLebh1NBZ27i6B31/M8FwNtQFOP4N709D1h/UxHO71JlcbS9?=
 =?us-ascii?Q?Ev9jCnz87D02NIgNeuQBL1PG07rYvzcPuu5N+LY2ZZ54oDVFXcBaGl4F9r5k?=
 =?us-ascii?Q?zm0JpqWO0R5NLrwFAh78PIW7+i4GDQYLJf9XbMT+slLuy+n7gWSojZiZAHwl?=
 =?us-ascii?Q?hCUuU0o+IC1jbJJikokCDlE2HAwKqkXop4ceF3DmGk4wEQ4/ElFLWzfOVyKd?=
 =?us-ascii?Q?aHRFfrsEAJx4j8LlO/ncuEDi4L1FCb5zXNttRCRvaKeP7+oqlFGTV4Ewbscm?=
 =?us-ascii?Q?83ajcc1v7G+MX2pbAtLlFRnVcGRO9lrkEZvi2XBARGFM45pGdnhDn15c/7UP?=
 =?us-ascii?Q?RcBQSfwb2wjqa7DKDiK3ReD+TzqciK1y3KTkpqOeUjuD1bywOS5c8XHs7LT+?=
 =?us-ascii?Q?gZJF7z8kxRxUwtDh/4LWRtMq37Wms9Tg3E6dj+tNsVzBjxzz2gSOpMxQ6mj0?=
 =?us-ascii?Q?pw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 167f5ee1-297f-44c8-8978-08dc306adade
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2024 10:17:47.7640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WMOH0Mjuif8ftVQ7hPbQZyLEwdnfU7J0HyOboyGHY8HosDVvrEvKXYFE+H9lgBzw3CvAt5ODiYyCvTOeC8ltMuoIf4wCKxF6u4fhk7TDAqQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0765

The INTx and MSI interrupt event num is different in Microchip and
StarFive platform.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/pci/controller/plda/pcie-microchip-host.c | 6 ++++--
 drivers/pci/controller/plda/pcie-plda.h           | 2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
index bf5ce33ee275..8a51d3aa7e88 100644
--- a/drivers/pci/controller/plda/pcie-microchip-host.c
+++ b/drivers/pci/controller/plda/pcie-microchip-host.c
@@ -817,6 +817,8 @@ static int mc_request_event_irq(struct plda_pcie_rp *plda, int event_irq,
 
 static const struct plda_event mc_event = {
 	.request_event_irq = mc_request_event_irq,
+	.intx_event        = EVENT_LOCAL_PM_MSI_INT_INTX,
+	.msi_event         = EVENT_LOCAL_PM_MSI_INT_MSI,
 };
 
 static int plda_pcie_init_irq_domains(struct plda_pcie_rp *port)
@@ -960,7 +962,7 @@ static int plda_init_interrupts(struct platform_device *pdev,
 	}
 
 	intx_irq = irq_create_mapping(port->event_domain,
-				      EVENT_LOCAL_PM_MSI_INT_INTX);
+				      event->intx_event);
 	if (!intx_irq) {
 		dev_err(dev, "failed to map INTx interrupt\n");
 		return -ENXIO;
@@ -970,7 +972,7 @@ static int plda_init_interrupts(struct platform_device *pdev,
 	irq_set_chained_handler_and_data(intx_irq, plda_handle_intx, port);
 
 	msi_irq = irq_create_mapping(port->event_domain,
-				     EVENT_LOCAL_PM_MSI_INT_MSI);
+				     event->msi_event);
 	if (!msi_irq)
 		return -ENXIO;
 
diff --git a/drivers/pci/controller/plda/pcie-plda.h b/drivers/pci/controller/plda/pcie-plda.h
index 935686bba837..89172ce18237 100644
--- a/drivers/pci/controller/plda/pcie-plda.h
+++ b/drivers/pci/controller/plda/pcie-plda.h
@@ -130,6 +130,8 @@ struct plda_pcie_rp {
 struct plda_event {
 	int (*request_event_irq)(struct plda_pcie_rp *pcie,
 				 int event_irq, int event);
+	int intx_event;
+	int msi_event;
 };
 
 void plda_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
-- 
2.17.1


