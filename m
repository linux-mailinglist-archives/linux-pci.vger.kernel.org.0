Return-Path: <linux-pci+bounces-5319-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1712688FAFE
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 10:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6721CB26FB6
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 09:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762F7657A9;
	Thu, 28 Mar 2024 09:19:02 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2111.outbound.protection.partner.outlook.cn [139.219.146.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E4662172;
	Thu, 28 Mar 2024 09:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711617542; cv=fail; b=HLGbx/EfIUrYU9//lcLFvLY1rFTbKL4WSEozvC3ueIVfhQfoqPbuo/6Z4wHACEr6lvIVe0CebyI+wOB/VoXjRZA+fg25oJo0us5lbDosfAbJ0GOHCiyO9bojFLbMKN/ZJsFsdRtRxFR8C6gBYqnluCl3rrx3NARLSJe7e4/M1xo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711617542; c=relaxed/simple;
	bh=6IWs/9L5/U7olRhCkLt+mH+c3E5Xoo0SyzW6LQLbL8c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mk8/lEPpH1blpUuxf1aTF6E+5wGdEVNqBBwez2uWHdhSZ0zvS4iPc9cUW4qXQVstHi9XiE5X1Kml0bUSRgEL9u1bEpm2xtQOEike6AjWgPGVP3xlROODgDJq4+AkhQ5+P9qcl9L86wwhzNMOkjwTe96AKQqRAh8ZHeL0vYKnz5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HydTu+bZdUz3Uu3F6OztMJ0h2TCNBYujhlJV/0YXKqrd1fG2ZzZ+gfnQA7XFcXTO6iBmhjLu7Mgbevv7Qoxk0iPRgNEaVmrDsiSty6l2lC29J3pW0WW4Ax6RdAl/eJN81SVsnaaBciPUQJfWpzhzFw0IAyeFiG9dQpFDdb3A/4EkqAlOKz/JZZsTAeQAcR6FsoV4iQ6C6hd2BR5xqrHwL59pTBatJJnWcpkmiPUhHybpbQm91Cjrz58xX66TQXY+5PML3XmDumSjPlxi2OJOvAZN+sRv444glywb40ifVqdgZip4p2NUtfKYKWcP1eO39SlwSfiABzNAAq34e04h7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H1L2zCinMaKZ61leC9g0xpthGdFxAFSQ7l+a9Zn1/VQ=;
 b=CraZKrZ0Mk9gA4YzBLdL1FGRLxiUJxmf8qq/5X/3XO8l5K36/H19k2Mf6WLzig/WB3iMTTjgUR+hoNKzwQ2lZvQ/BPBwKQObLSKxyqL0pFI3rUSntSWELha4h1QrA1fD5tgjGmB97sRSmXDHEHAPjIAmIr431IuNSpo9zoy7HaOp9w3DqKK/9GcgwAK5WtYV917eZRCqngw67Wmau7MqvGKBYHCsgwsosZviMs5niTrOP7wshW7uLDmjYE4ODjReI3X+mqQ6SdVknnQOc1iMTsChFUv52UYGy+wmo5Rv9Vr+f52jlNHsF33pWpmnKoIhQfk4v6n/lT1cVJlMzKmtQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0526.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 09:18:52 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::c738:9e6b:f92e:8bb9]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::c738:9e6b:f92e:8bb9%6])
 with mapi id 15.20.7409.031; Thu, 28 Mar 2024 09:18:51 +0000
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
Subject: [PATCH v16 08/22] PCI: microchip: Change the argument of plda_pcie_setup_iomems()
Date: Thu, 28 Mar 2024 17:18:21 +0800
Message-Id: <20240328091835.14797-9-minda.chen@starfivetech.com>
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
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0526:EE_
X-MS-Office365-Filtering-Correlation-Id: a799fe66-961b-4faf-0bdc-08dc4f081574
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bwPtdAsNgZ1sN9vUeHuO+tHvoenBQkLfKt3HlKaBVsfC9tuonXwvgvsWHePz+GVEPRAL/cDJZDrkxd4bcmpWOVaYyKxufl8iwJTBCVTWShzQMOe6dYqw79SNSwJEDvVTDWZEFBLnvFexXmuBXQrf5FK2esREKh+deaBRZl4jCER/CP3bX/DgEbdRsRulybD9V4VXJRsfBWWwHi4hR1jVbEPj7rwPsgwWcB+iRJY/31hBb4nJL5J/P3pqeCqeo6hRL5PziRqVs6ci2AkF/7AKuYlIWVxNfTjrr9hlWJ+5YZu329hlba0BbQNsDJtkdRZqIsQfl5BtgCEuClznnALDkI/WjTwtwpZ0qmaT6P/i2aO+8Vdxu5DYknVMwnLoM5gHWy6FWRsNEKpEhsGM8EXN9hu5WtNa6GGGe27DJYadfjKXa6nkyl8pipdF/IcFn8HnNQqnsIo10ILoJcWLnxM/HWc9QHz5YANrqgJG+gEMdAyVaPI6BzWx10xUGgNzGtNieA4n/slbYqBMUZsOj94fTV4UNq3q79diUbtgf/lj/CoE+cjdXuxx521uxaOsZsQx3F8b6diDdZpciyz3zMYXOZpc6YBMIoGe/olMbG0x7k4rKpLVE7eAr1iqdd8QQHqM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(7416005)(366007)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9NCVQsxXx2ZlvoXDBFI3IVJnJMSBGZAF3/Q28bghvk8UOM4i28WkU604Li8t?=
 =?us-ascii?Q?ZRwat5+kar/Z+dnnHaqunEI5fyo+YdNKdXAdFo7L6NGYfx9vm7kMnI0RUhtX?=
 =?us-ascii?Q?kiqT4Gp0Git2bOdXIIOqGX903Y98+lj0mFZ+nJ0XE3KuZUgtibM/8bwwHnen?=
 =?us-ascii?Q?ln/5yZdQhIZ/4B1ybPuuIFLQ/D7qWUupfqthObxx8ORrdpNpDHfbwvqDbXHo?=
 =?us-ascii?Q?lztx36G3M6m8iocWZCqJLIcSkgtDE0Ugsevs3SDLuil11+CJVUMNR7X6e1rR?=
 =?us-ascii?Q?5XxHRZRrXsmeQsGEV3O4DkDgkBPdpL/RPJCkrXv3aoU0mHiic0WmvaSFW64/?=
 =?us-ascii?Q?7motZ0D/OQz4VpZGBe0WjqQ0eW7mm/C8vX5gxcMhsXPJkZZoJzM7/Ncflr7A?=
 =?us-ascii?Q?4i8fvR/Gl6Pk+gZ48LXOgTMPGPD437L92j/ErErBtZsEthUUWEGhPVxrHVib?=
 =?us-ascii?Q?Mqj+nOXVxQCd0Sc4DYTo9v+rGOtQpvM6lPvKykzbSj09CH9tCXT2eEYvTTUx?=
 =?us-ascii?Q?K/CPzAgR/9Lx/wgz0qrWxSJzDX5tnMUkn9wfDbirP9o3FMVTBjVCW3I+7joA?=
 =?us-ascii?Q?3fGaIuYoEM3FVjS1gl0ORAakFUQO44lMp0Xs1IQiQro720DgaNKqLyYlCbBj?=
 =?us-ascii?Q?wLumI+GDbbKdlMqGisixktNiDFED/ac7GL5ukfVNpPF0K7/SU2qdvrW489W6?=
 =?us-ascii?Q?aATr52TAIj+N7Sjc0eYEnBmzRfSrXOp/RwRvgvM6M21Wm1AbR0H8HdMHXj6b?=
 =?us-ascii?Q?wLh3a8fzLmgwGJD6rfeGYVAU+IuAcQAVDVEyuQwG7DTNvxCE5i++RbGrR4FD?=
 =?us-ascii?Q?cpOfF6tUKxcEJJB57GYDpPU4DM2eQB/NA58oqH3PHTXiJttZ5LSmkQ53pwGL?=
 =?us-ascii?Q?/cczhoGOV1SX608I0NYnkWe90OMNh8ufRTC2IPtAfSIk3wqgQmE5PJug0pEy?=
 =?us-ascii?Q?jbo3WmeX4sOShijodHYCFFPLpq/6mkjG3OzKTxeAeKHBhn/3S1b/YBGid2s1?=
 =?us-ascii?Q?dYZ8cgotLHk3iVeNu0NnVn/AANXdK8XETMMgeqnBOT0klUVS2Nq85/IsNKyP?=
 =?us-ascii?Q?NVKtv9yCyKstIcCjaC5GWjnj381kuXOghQEEJlta092/pIGnDu+usP3fZtk+?=
 =?us-ascii?Q?xaaxzDvGRge92myZYfgUIGiC01qJXlqWzZZIgvfLM9lniHBOFx1C7CXiO6N4?=
 =?us-ascii?Q?MPLoJDKLRiZwv58yUGULdIE5DzJOQFmf6+dy75DdC8NTNyQhfLi9xde4aCa0?=
 =?us-ascii?Q?YACnysHgu2C2h/QnmT/VYAued9bz1SXu2DTq/iG8TvJiFAHDJiH3mVpaVRaf?=
 =?us-ascii?Q?8fEk8erlBpSacvT4GTx8+oPf5xGlyv/ZBk0UFxbTrXYRUa8u8WnM/fQ76U/B?=
 =?us-ascii?Q?axwHOqiPeC3zNnIU3TKEr1myHGru3XnVX2AjkECg+s6TtqW1Ly5s1UUA99tz?=
 =?us-ascii?Q?Hgi28RS6Pjw2Ic9On2qXIX0u0xXiOYdzqiwE4HbJ39V2dwL3PqkNUrpLl/4m?=
 =?us-ascii?Q?6zkvgO62mOLu8Unoo10pJ7WqcIYP4Io8I7eG0SzUBqEwZmFZGX5KEtpgDibN?=
 =?us-ascii?Q?f8D77rolYXi824OcOjVl3ov43Wv+QRFPdaIEsotf0OqYrwDoPkf2mKACbDro?=
 =?us-ascii?Q?Pg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a799fe66-961b-4faf-0bdc-08dc4f081574
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 09:18:51.8929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KAE3gcVPpFEC36fq/pLvgu54l+aoAyq0rdJhOiW0MdAuvI5iNlrTURRgs76pg7Umu5Ixrh1PW5xOoyKFreUW9N1xd3gqWdtsaaaB8UHH+8U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0526

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


