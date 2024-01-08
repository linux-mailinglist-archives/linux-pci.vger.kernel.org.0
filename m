Return-Path: <linux-pci+bounces-1814-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34397827008
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 14:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2FD02836EE
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 13:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1ED44C89;
	Mon,  8 Jan 2024 13:40:19 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2089.outbound.protection.partner.outlook.cn [139.219.146.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AB544C8D;
	Mon,  8 Jan 2024 13:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b7S/yH5ofnUibDxx4aetjwq5fpHYBXvQe1l07zae+lEVRlFIyiqI1uEJYW0oZx7MxI/o8itOW4gkeuIs/6P36gwlHKnoTE6nGPC0Fx/KGwXKX3XX/bdI78hvEuROSTK92ogsSiHO5YZlcQdsEfPWZlBC6z8HXL9daAyQ32C6VQEIuAXF4A49E/CSqK/iA9gs9qd9rL6McuHAfYdbVsdbxVXfDTUAsUm/+19Yy3nt2BKtlJ/U9HaEMQlUPG5BraXvjdOHu2fTOWgJRPXhK4u9ykA3AuvVVE/F2ebZUgZOsIyId/AwBQmwve1K/bBGLPU5JY35+jex2K1r9re44HhXxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H1L2zCinMaKZ61leC9g0xpthGdFxAFSQ7l+a9Zn1/VQ=;
 b=bbqixbJzxBdoyVWW9AJa6mcPHO8DLYo0Yf/2yy/Yh76JuUigcFx8gh5e0k1mVTcKFjMjI2UXwWmaGOHrXLKkHY/EScxaG3jqAzN0IDawLp96DKvagjmCVSdTosUqeGreUbGJjZvyQ4XCGkiTXwqbNVpiv4U5+m8W5+lCX2ZpJ+5hKu0FqpN7ihVb+9TrYl1bUMwyXGNUTlYKEuYx775I+NUJSk7IGqcyEvJcyU+g5x18DGoabRxSPTyU2QJfxEW0lB/CWnJdrs3wBDSOxCtXa+8Rdfuyajjps86z8qm5VfFCS5aGXzELQppd6V8f2sLJDH3FZr5zPdsGTVy2TGVTvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0797.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.32; Mon, 8 Jan
 2024 11:06:38 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::e6aa:baea:fd8c:4cd2]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::e6aa:baea:fd8c:4cd2%7])
 with mapi id 15.20.7135.032; Mon, 8 Jan 2024 11:06:38 +0000
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
Subject: [PATCH v14 08/22] PCI: microchip: Change the argument of plda_pcie_setup_iomems()
Date: Mon,  8 Jan 2024 19:05:58 +0800
Message-Id: <20240108110612.19048-9-minda.chen@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 85a1babd-467a-44a9-a6b7-08dc1039e295
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lqApmGxLXWnlSVfl4w2R8KyOgqza8qlFmj1qrjukCYWfxbanHlUY8mYASdc2Lmbjrg3QMuk8by+eQiPHL/iyaL8hpkmetAs+eXXehocwO7TFUTO9WARdwsjiY2YY48Ph2jp/Ioyte3PGje0wVhwx3GdGZ7hRWucyo1e/kdtLn/0l9W76eyLhxr7JHtQ/Ll7UtghMzr6ylaTaifEWBdWKMxOb5LFZDese76OFrpRMy/BH+Kj6qmj1JahBzXzER+64ORabBe7G77aq/+7Sa2CUApvgVyePrmcI5EGORT/Qzjqk7QujJ97ggbbfe37s4lfoSAVY9aNkA1MzNqyPWB8P+ZmgYpxytZwDcQ2gUg4HcHGxrppH3nGiX86GSG7wRH+ukbbCvOo7AxoiuRDMn6jD0CIqqB0n2ys9MZSr/Nag/fKvZ87A3QCn3Xw/aDfsYvZ6TxWAaP+D50QbunVBrWaxk7iRvzcVolxALG8NaDsdZVja4PnhlfyHOMSdda3NW1uZS0gdbzwvzGf8gfW2re3CsCUX7YITsPAs/sEZMArrbXRT3pU29o6Y+OK4WaeTI9J/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(39830400003)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(8936002)(41320700001)(1076003)(107886003)(26005)(2616005)(83380400001)(44832011)(8676002)(4326008)(86362001)(52116002)(508600001)(66476007)(6666004)(66946007)(66556008)(54906003)(110136005)(40160700002)(38100700002)(38350700005)(2906002)(5660300002)(7416002)(40180700001)(41300700001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Lun/eo3MEVjzpcU+1qQJPXUk/LHhiIFlfgnvun1a8eeARf0B4Gn8OvQlDYc1?=
 =?us-ascii?Q?03szhJ1VVTK1z08WiVUls8nixYcXBEA4X5eFjngvQ3o1xdtc87KjB7sz0rSV?=
 =?us-ascii?Q?ZzUYHblKVn3cB4/wdois/k5IamrOfh09OyLLS1jNhMSj9UP/fL5p/UkQdlPQ?=
 =?us-ascii?Q?iVoHoqM/wwGWbGY1fuu13s7+n4+BMiPNr5a8pXhJK9dxuCoduKU3LdwYpnlF?=
 =?us-ascii?Q?7Ej8vQoPWeY+PLEv56e5rckoE2q+ppsoyrQWUGlUazt9tBY3gZgz1Py5Vj2w?=
 =?us-ascii?Q?0j1Q6wgObKrGbIodc9fDvwIaSOYYw7Pfvv1hpNiaAIucfNTuCFh5yaEjwTzh?=
 =?us-ascii?Q?hhka+/NflRNxeQ8yyCAYf2ktCk0f0We7j5iMsfOaRXX3QJrCV6uyx5H9Hpjr?=
 =?us-ascii?Q?JyojUNrt95H9ya5hyFbPJljLF0F8IdegcIGu/QfcT3I2cLn31Pmb6GsLUfgl?=
 =?us-ascii?Q?y0+ogiMK/zHBs6Qw5TYbLbHC9chJjcGHUBm3pxN4XYAFNvl6Qy2AOt3WGYFw?=
 =?us-ascii?Q?oUsARjo8UfBjm1UhDYm42fvFcU9pot9FxG7aw7xePE7qEzG05ZqWeKmmJPJt?=
 =?us-ascii?Q?jfmudXPzwcF/Z63Q6ZSyNfnn3uezyJHhMyk8n3k6FPBtBaPhcl7ivcjvBwW2?=
 =?us-ascii?Q?fRTcqWeU9+9iRBV4hPn/S6wHOO6IDoCDzB1W6gYyNvb/vZPXdpkK1vLE56JY?=
 =?us-ascii?Q?oZJD4tqNe7/hMDeA6B0oDt83XWMg39Bv0V+j+TGBgP/ludk7++Ok01wm1Q+X?=
 =?us-ascii?Q?jDD+aVkMrTNp9adB7C2qEPKW6zr+SN6G+iTl4wzTweDrloZKqZ31jWAQwZdG?=
 =?us-ascii?Q?RDgvR50D1Ud3Z9ZygJ1FANv2mzKPzor8qCaZhRr4TxDd0kji0Vz+Qdaotumi?=
 =?us-ascii?Q?dd1hVtAFMc4uxUCKY9ttX+lWkaJDWoB3xqm/ca1zYk6ftU2O4mbApIrIyrfP?=
 =?us-ascii?Q?0skUdmcqdIrI3CcIikAQQkGqLTq5CD30cmpn5+hZ/SIExk2Du+yeptby2XRr?=
 =?us-ascii?Q?RwgIrORjpOtXGk5m2H/uzjQmO+/i2ttdlpVI3FJhSktNC1zbQRr3esztyH94?=
 =?us-ascii?Q?kLCbyL8C56Fr4oZaJBDMcXw5r2px0kZ3oVqWpFNb1n+9TSNhKy5cT5zGc7NA?=
 =?us-ascii?Q?1j2ezqlCDpRDbCnpeRczX34H5g5g8eA0OTD5yXToQ+5we0D/y5qRI09D0Yt2?=
 =?us-ascii?Q?Qa/SFm8D7SNNsmhJidOtcwL2/PjiAjOf/5CBXEXI4diswKfYLSTni90vFk0j?=
 =?us-ascii?Q?ZQeNx1Z1HotHlA8bxao/CoscZe2q3lJz8SwahAdI11hVC5pBNGncWm2NYGeo?=
 =?us-ascii?Q?hQsF7kMFc6jqqequnlUgHf4IlLFrGcv/ZFJpz60/p9/EbtLFlpwWFI+vm5Ac?=
 =?us-ascii?Q?yWZIt5GMsf/YJEe8UBu11EzWUBqH8Cfs2mFExnqd2uZbe/CKjE4YaFxcTTZR?=
 =?us-ascii?Q?b/+IMLSa1VpRY9cr1uuJxI5oastAWMvhtTJZ9V6+JmAtmhYjKZY/3ZpXPrBW?=
 =?us-ascii?Q?UpJlTMjc10W2dSefzQt6/H4MSVL0heRgPxn0VcEOEynpMTx5T+RLGfrOWUvJ?=
 =?us-ascii?Q?iO6tpabZxg1d4QDON/byr9dzfBq4SvJMuo4xjruclyZs+meQodaZO+pKJRDG?=
 =?us-ascii?Q?AQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85a1babd-467a-44a9-a6b7-08dc1039e295
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 11:06:38.1278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r4RgA0aNN2ayus94RNdHAZ7pmffkjX5wZfEcrvaoPLa4NqKorSt/KX/++vLwKxBoSYbSoJGCI+AbgB9co1WvqhhWKRsL0vre/r6s2ma/fzk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0797

If other vendor do not select PCI_HOST_COMMON, the driver data is not
struct pci_host_bridge.

Move calling platform_get_drvdata() to mc_platform_init().

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/pci/controller/plda/pcie-microchip-host.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
index 9b367927cd32..805870aed61d 100644
--- a/drivers/pci/controller/plda/pcie-microchip-host.c
+++ b/drivers/pci/controller/plda/pcie-microchip-host.c
@@ -876,11 +876,10 @@ static void plda_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
 	writel(0, bridge_base_addr + ATR0_PCIE_WIN0_SRC_ADDR);
 }
 
-static int plda_pcie_setup_iomems(struct platform_device *pdev,
+static int plda_pcie_setup_iomems(struct pci_host_bridge *bridge,
 				  struct plda_pcie_rp *port)
 {
 	void __iomem *bridge_base_addr = port->bridge_addr;
-	struct pci_host_bridge *bridge = platform_get_drvdata(pdev);
 	struct resource_entry *entry;
 	u64 pci_addr;
 	u32 index = 1;
@@ -1018,6 +1017,7 @@ static int mc_platform_init(struct pci_config_window *cfg)
 {
 	struct device *dev = cfg->parent;
 	struct platform_device *pdev = to_platform_device(dev);
+	struct pci_host_bridge *bridge = platform_get_drvdata(pdev);
 	void __iomem *bridge_base_addr =
 		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
 	int ret;
@@ -1031,7 +1031,7 @@ static int mc_platform_init(struct pci_config_window *cfg)
 	mc_pcie_enable_msi(port, cfg->win);
 
 	/* Configure non-config space outbound ranges */
-	ret = plda_pcie_setup_iomems(pdev, &port->plda);
+	ret = plda_pcie_setup_iomems(bridge, &port->plda);
 	if (ret)
 		return ret;
 
-- 
2.17.1


