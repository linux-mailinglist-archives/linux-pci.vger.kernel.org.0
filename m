Return-Path: <linux-pci+bounces-2667-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D2583FB92
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 02:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B39BA2827C4
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 01:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18565EEDB;
	Mon, 29 Jan 2024 01:02:09 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2063.outbound.protection.partner.outlook.cn [139.219.17.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D09DDF46;
	Mon, 29 Jan 2024 01:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706490129; cv=fail; b=OkwhLaNWtdftmw79nLhrhSG8r/Dlz308upiESUFAeTgttihhExDSvJEuWvq57gVajP8UAlth+khKgvdhkem761wgHO3E8PuKzn+AuVmI/hmbDBlBZ0NnBh7O/TUa+hq2yS5xBDGnw9Gsjbj+KVvxbEG6BGdxnUr3mjWJd4Ff9Ag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706490129; c=relaxed/simple;
	bh=GQ7qXJo5MKWyH40Ex3HVziIEH7KxJvBXh0pR8GnF8Zc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SkceXI3jS4Je9umO2pOijQUfPkxPP4fdlQMw2VEcDaYiC/wGvD9bs3fI07zd7aCQJSaaaqmzpcqn3ghHfsZdV2ZQsO6xLkiMNbl3/DkW5uDxSvnZi2Fn8rlsKGB3WgWOVWfQmUAXuR9CRxLYfF0eI7GwBRNODmM8n+0igSsW+S4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WxrF9/9m2PB/gfjwka9TrQLwkT+ORyx9gmq3b7O4ZvCXDgMzEkZf8Ogt7A1IgsxnqOFWYS+kjuESXALV2A+UVB4YsEEk4FTMipztzLt3l6M/JuadPaSPs+MATH3FfGCH0a1FpfyYEBrwPtpPiq1qbTTcPvpAnn8AmWo9jMVZUzEoWccQwOkJroSDn3ElQRCH2mrHEXRJwcsgwVKknDpsbF9DKLk/wUV8znj0yxj/PVLM20CtFAxD7JBtQTYV7NiWlAPZcthZ51CdkkwTOmpcPhJw4g/y94zqa3FmRzV2GbNddABzPXB3WZ1SuUAQJVKFEB/EDE4dFchqz6cPWh269w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qP2Vis3RtKbGjNEiaOaeGcLrec2A0EyTP5CqIfMTsdw=;
 b=mx0gLEWqaUHP8XDwaELUGun7f4JMflc5Gn1vCZeNuzbBUVGymGwkk1CVxmzYieFrxDZPrGaTY4xXrgiOg7fsLJHsu7Cav9h91eOxFfhb82o2xGMVp71Kc9uMogsegkq8QsC0W6bfG/SvaZ7r6Ole/q8Eym4Im1hf8b65GWjSRIMNBl+jBVD2X24eoBruwLzP5VyhiSJPvZqmJwhS170ttKw892bpJkezl3Z0rELiyYUGv9FyTDxxaIzzfMKoINjOJa0HI/gMePKGzw3loL3TDLNse+bwEaTqDEb6wRwivMrAi8lkErpp2eTTnGxUMJluC2a4DCPOxZcRuXmYssFN8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12) by BJXPR01MB0552.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:13::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Mon, 29 Jan
 2024 01:01:56 +0000
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 ([fe80::1ea1:19d5:efef:6fc6]) by
 BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn ([fe80::1ea1:19d5:efef:6fc6%4])
 with mapi id 15.20.7228.029; Mon, 29 Jan 2024 01:01:56 +0000
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
Subject: [PATCH v14,RESEND 20/22] PCI: Add PCIE_RESET_CONFIG_DEVICE_WAIT_MS waiting time value
Date: Mon, 29 Jan 2024 09:01:40 +0800
Message-Id: <20240129010142.3732-5-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240129010142.3732-1-minda.chen@starfivetech.com>
References: <20240129010142.3732-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: SH0PR01CA0003.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::15) To BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJXPR01MB0855:EE_|BJXPR01MB0552:EE_
X-MS-Office365-Filtering-Correlation-Id: 88dc84b8-79df-4977-42c5-08dc2065e3e6
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YbHjR+sc7i34CpQ2zI2ZOAe0s3hjmz+e+hym6hw8WnZJ9et21ToxdIUOoaK/yL9EqRKUml1VEXAMBvqwkN/1pHkqeNtaOnW7OVpDiL1bkQylEjm80YUgqMX074Du1kYXmGo8FCidG2fh4EqTPOO2rwFy75I+X8/eK8VYTDr/s+GN3apYFySaV5mjpMzbU8TLxcTlvCikTZIn5zyyILROebmZrID3iN2/tYP8FaIEvp4+NBON5sBwACFrvPP9ocxLoOcRBVSxQIvkCu/tlmL92qzcRMekUcOsf+Tovu/g9+nlShZV8X+uiLJM6bsT6V9t/sL5zHe2izqcbkRzzAAKWnJOrrShTfeYIMr2gSP9VXgsVJT2OyPg3QgnL6Q0YxfdVWu0R8QmimcwIqZB6kWwi7U2ktvy5ExtLrj0VUq/bN//p2+xVBt6kWdcqEABdPQVzuPKIZ9rRX0eHP/2HaaKwoT69xVEM6M+57hfVbXFgCKmej7ki2w+uACHUtFCHxGotbY4NGgimuo0+GC9nX2d9lt9fBqwBhirlJ1PADOJ00JTgEMO2NNpfrUXI02Cn4fU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(39830400003)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(107886003)(2616005)(1076003)(41300700001)(26005)(41320700001)(40180700001)(40160700002)(38350700005)(508600001)(6666004)(83380400001)(54906003)(52116002)(36756003)(38100700002)(2906002)(66476007)(5660300002)(8936002)(86362001)(66946007)(110136005)(44832011)(4326008)(7416002)(8676002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IeHav3IBZf61OPSEXfVIzu7GPdrxrHMeFan3o4SWQbw+9KUfgaSDgFPZc8B5?=
 =?us-ascii?Q?XwP2x7igWuQUIbG00Wip6ZuKftOty4+L1h+tsz2EG9ka1Sy+gpfyt7DuVUlD?=
 =?us-ascii?Q?LFCXi2KWuFxfZj9WP1tSaLSnuS+PqY8gc4HhoLHkrlcmoDvM9KiUtPstGQxA?=
 =?us-ascii?Q?XYk892DVmckMQy7IrCHHRt3b9zoY0Iq6g5CulO4D1cdMFXPlfl4G9mJI65Ip?=
 =?us-ascii?Q?BtJjZ6Xomp3vvT+S7kIAJAijEPLyOLnh12WBvlvq2eIEDYXalSrEGXSfcmBv?=
 =?us-ascii?Q?d1k3as6xn1D0dpupdfnD3gFH7IT91cdEOgrzC7Yi1jH+B9vWWT5XPjQRUGiy?=
 =?us-ascii?Q?tRHtnorhVdptLzBfM+9/7oartHFLongQkdIbwhawLmSWx+IDJUZLHSueDelr?=
 =?us-ascii?Q?rdnW6d1sULeQEWUaI5/7DXwPDXWyv9TnORX0SExziJjwWMkJApUByCRHdo5l?=
 =?us-ascii?Q?N4x3xUyQoc+adg4EmKeoRbf+mWkddht/HdpdqgHWQDODbksljpoCRVf1VdxM?=
 =?us-ascii?Q?e4kzg1p++K0EWsRXrGfjGohDn8yo2jIfmyTgZRFzO3L/wVOXamRX2KPTplP/?=
 =?us-ascii?Q?ckZxQUCFOXxxiRLFFMGC7kfDGdSWVZZr2b/fk+86tPz5q2jVG3KsKaRRNWzw?=
 =?us-ascii?Q?66y7HCz+yFLARbVmh8EalYXCt3p9hPicOhpV4pkCt9d4nfKj4Cqai3eaSAQh?=
 =?us-ascii?Q?NSJyAAqe/VMjR/PExNCdElAtNmh7Qtzp1J9lqHhfEmt08GoHvmwN5Hch/jW6?=
 =?us-ascii?Q?WQ8nXgA8HcIKj2gPQCAsmOpWWhGWj5hKliD5q+ydm5Beuhg2wp/C9Wm5GTC5?=
 =?us-ascii?Q?zwAGXK/G6RuxFwmkI4JxO2UFncrYezsFOfHY0ZTh95RPFocEaaVmzG4hZp0i?=
 =?us-ascii?Q?0j69tKI6Acn9OnDKFEdMXYapTcGlIVKiap2XNjaOwSrTyJ7dQcq3zAsP3EhF?=
 =?us-ascii?Q?gXZTmPYkAuX5y3QH8omoA160CXf92OcPTEmh225SIDTxfNx5NVdkFMdbNP5X?=
 =?us-ascii?Q?fWRLR076bA43B4DYQCTQZ5YZYjahjyCMgMxFM2WAHu3Dfdi0KOVdUdw6njnt?=
 =?us-ascii?Q?3pwCThTqTIbcRcUZBA+W0f4R9t6aAHn588OmC64eAdkQZj8Fb6n11MPcPHRv?=
 =?us-ascii?Q?t9vKmLzPygpKuqnJWwRPF8+MQfm5xST9FXvi9WOlGlt8JQq2BEDjKsxPqsTf?=
 =?us-ascii?Q?HogUB8C7xsHyXFc0SPLCQO+bAlbcTmMSJuCfx59qxEz/WqFdcnBA9a2XLtsF?=
 =?us-ascii?Q?z3g74LoFQYEFmN9sAdQBrj1MG6T6Is/SUMfzQKF1A6/Rmv4XQ+ONybGT87eh?=
 =?us-ascii?Q?9aHi/wfP5xeZ3x6goHozBoeVYyR6tjNu5UZALKYZ3LxVYmu/pFU2npuPiVMQ?=
 =?us-ascii?Q?Y/OGjriwSdJA7Yb2/GejFYK1c+GK0s8WkX1xmd15yyfVyEAMk//7zMyXLutK?=
 =?us-ascii?Q?22pfH49D2Mn4ZlaJYgF6VeuwLKAWskHJ+qKN/ZwjqaA9iL4Oj4sqQ4MCDMg2?=
 =?us-ascii?Q?N6vHdWe5N6gr2F1zCT5IHnzXfd/4XOsDoDXI3RWiodQma0EButr1fl0uE951?=
 =?us-ascii?Q?mH3zjNfDBWhN7a6QOKUvj4bqmbb1WZiwluXB5cmFir88sDQJNJwikGasi1ZG?=
 =?us-ascii?Q?jQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88dc84b8-79df-4977-42c5-08dc2065e3e6
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 01:01:56.8445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OgZjEArD8s2KbjCFBFyjnKTjIVnRr6DMyOIkFOCUER0gqZ4Mf0M7ticWh6F8VDVWpRg6ylE5vPUSsKtsLW5zNeX4dgdlbIpfD2stVpBVcjs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0552

From: Kevin Xie <kevin.xie@starfivetech.com>

Add the PCIE_RESET_CONFIG_DEVICE_WAIT_MS macro to define the minimum
waiting time between exit from a conventional reset and sending the
first configuration request to the device.

As described in PCI base specification r6.0, section 6.6.1 <Conventional
Reset>, there are two different use cases of the value:

   - "With a Downstream Port that does not support Link speeds greater
     than 5.0 GT/s, software must wait a minimum of 100 ms following exit
     from a Conventional Reset before sending a Configuration Request to
     the device immediately below that Port."

   - "With a Downstream Port that supports Link speeds greater than
     5.0 GT/s, software must wait a minimum of 100 ms after Link training
     completes before sending a Configuration Request to the device
     immediately below that Port."

Signed-off-by: Kevin Xie <kevin.xie@starfivetech.com>
Reviewed-by: Mason Huo <mason.huo@starfivetech.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 2336a8d1edab..bd38b3a69d8b 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -22,6 +22,22 @@
  */
 #define PCIE_PME_TO_L2_TIMEOUT_US	10000
 
+/*
+ * As described in PCI base specification r6.0, section 6.6.1 <Conventional
+ * Reset>, there are two different use cases of the value:
+ *
+ * - "With a Downstream Port that does not support Link speeds greater
+ *    than 5.0 GT/s, software must wait a minimum of 100 ms following exit
+ *    from a Conventional Reset before sending a Configuration Request to
+ *    the device immediately below that Port."
+ *
+ * - "With a Downstream Port that supports Link speeds greater than
+ *    5.0 GT/s, software must wait a minimum of 100 ms after Link training
+ *    completes before sending a Configuration Request to the device
+ *    immediately below that Port."
+ */
+#define PCIE_RESET_CONFIG_DEVICE_WAIT_MS	100
+
 extern const unsigned char pcie_link_speed[];
 extern bool pci_early_dump;
 
-- 
2.17.1


