Return-Path: <linux-pci+bounces-5334-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B51D88FB2E
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 10:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19C131F238CC
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 09:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261BB8003D;
	Thu, 28 Mar 2024 09:19:18 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2136.outbound.protection.partner.outlook.cn [139.219.146.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607EB64CD1;
	Thu, 28 Mar 2024 09:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711617558; cv=fail; b=mpqD7Lebc/uT8U7KuKzBGD3Ec5Fkz/dQUivsITuQfF6haWmAi5Mu4q6pvMJ6Hhb9YyHscQ6L3buPh8zmoTnWrVtvRhGCIUFZwoSOHy6eWQtP+gP+u6cGRJ1qk3zsHx/aR5h1cx3zafJKXoz9L3/bkIVn7qcW2Wyn2xxjkXt7TxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711617558; c=relaxed/simple;
	bh=S25O1HoWNeWNiqFDZO63Zv/uRdgCr6uWNHaRg5r2qqI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZTC3LIMtp32EiWLcTPFOewm3AhE63viX4dvEo9J7y7cac2IjFDbHWdZi7pL4wuKJKvY+dRxE3SYsWvi5PLjVYocKDvZHAtrqn8EVZk46+V2MaazvlREfkXE0Rez3GtrI3qsKLjlOyskAAUZlu54g3B6ie8iGFEBSdfYEA4Ns8nc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EoxRkjCvIu1n9KtB2/RqjhZECcEICUKX3eNjL2RY4yCJR+9+3xJe3A8OdogUFe2WYN4MkQ+rJaX/dWIgObCJuegXHxlrhZ7cAQO+5D3BCdqUAvh4QqKt9PYvAVv7WXF8BiZ93MeEPFud3Lqw/txPQDIp2P8Glhz66jl1FePJBj9OzgCBH/GWsKJPWJEWOt3mMZNjzoLNb8clLPFIWiy27V3tedLk+npzMGgJLT9fc+MQ8ul+xCwz8VTtiOa1VwCCzNQ5gynIRyGU+MhYZ2KvimTwc9Pob/z4WmL+vVoXp1Dk1q8070k+6RPhs6k2V8nrHpSt3GohmNYl6/DvfR4vLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mQuC3rsd+2sb++ex1jnAa+/IUKOgIbgvPVL0ck2ZXgc=;
 b=cv1/Ecr4Sv2Xhm5qnc9f5RUPPKSwSM0qp1g3B2d25o3rXdCNgGjMIFO+ZM9zbnGXPgv3n9aj9QVlMSSt5rrbgUvIhKml6QIO7HJe+p7pbgysUnr+mufbr9mZKc4mg/h08MyiAKLfjOUxcYxnIW9cOKgbHt7LT8QTIvQ8xRG/AlpO3/TFevm80i3/QBQPa2nlaSAznrE83tVHYnpxK4u/o3KwGai9am+ImiCqGLUUoODJvl4QPUfJXpNHnn06lctLx/CZpnerNKSm8fguaYxAL5mVZ/Qz+Vsj80cgWi6n6LtoTmmFYqvoq++0X7ktWH8jAltMKkGItVAgBNYcJpWrBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0559.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 09:19:04 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::c738:9e6b:f92e:8bb9]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::c738:9e6b:f92e:8bb9%6])
 with mapi id 15.20.7409.031; Thu, 28 Mar 2024 09:19:04 +0000
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
Subject: [PATCH v16 20/22] PCI: Add PCIE_RESET_CONFIG_DEVICE_WAIT_MS waiting time value
Date: Thu, 28 Mar 2024 17:18:33 +0800
Message-Id: <20240328091835.14797-21-minda.chen@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: fa28561d-cd0b-4b65-0e69-08dc4f081cae
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2gUd2/SzxeuUgHbloQBpwODNL/SgQE+ChvkFZlQZxkW0+kzjb5w91Msx9Cs6Q23wManAfg2VdT7ysK5ojR4YdcB1fNFuvuDSPM+Tlt8fkfLjvrrWKCxaFRvpgvZxZeKjCBjaeXMuj0wpR4rYYnfECQwsvrM36ko9o0gxX9ip3J/7HBVDnCpX+azTzI2Clegd3AC+I76jCWqH/Zb+sO0DP5KefMWQEoL0UDqS/caWhkyynCSx1MoFSHDQ9vTe750TO+XJ953TvobBH3hJm1/Q5g526fXCxJqFRLqtbOPh/LT0wOTzCvLYDBM9eO6lsAW+oq7oUMnVZw53vqcMQrTT+IpdKHu1hOvaEk74Pb1gW44cpU0QG3DEM//Yr0vEqigM9KF/gND0y/icqfTjRCrUX7ndxhhV4/SLGUlQyOA3B9HVTFFwOp5fPvVZxLPSxbkEXW1csyTjyj0oFGVLX5ZkvYUE96hUsUO0vWhPcCItS7w9M2fvQ2PsS65YIN3LtwjvqEckF84rqYB1qJO19tPNNKE/6nEhT97TQMoZ0nTvZIcLX4TfcGkR6lmN5JQgmJE5biHuRl51K6SgzPoEhlHbG1mEauJLNKEF5K3mzA0djQPhMahz6U/ELBsoaquhnDE3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(41320700004)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Xyt6Q+zsPBrJvS6qSArb1hSxxbfY5CUcgTIOir+yKzdatiBWr8r3k78iIg+c?=
 =?us-ascii?Q?IF3NIKrocq7ApI98FsfJtG3rRhNXappq5alwkmLBnCLkQ5u2xfApezXxN45k?=
 =?us-ascii?Q?1GV2RtA5v2bont0wbnu5TiRbwCBKg+wDygqKwoy1w3Ngr90IbuWlEOG/2ZaV?=
 =?us-ascii?Q?+MPeUE/H9chB03llcxJFNJ+1z2unYOrq9/YllNZCUHIXz17uqcazB5mqh/0j?=
 =?us-ascii?Q?/acCR9tZhq2OPniHK2wbIKQ7Gx4b8p96DZkISvfoI+woUIKbqWMdQKWi3YS8?=
 =?us-ascii?Q?YI3we+POWkphN1EUuwf0j4OypkZia0vd7kdYNGZ18gYxtwkBHuS0CbmHuTE7?=
 =?us-ascii?Q?/zEPGgmR+wV5bVzdhFSTTOPgCkzE4+kK6kDcg9NKFlg0dpConuyLOIPlMnQa?=
 =?us-ascii?Q?E4BazEro7bJAoARShmxWQtfRPCFkATXI3Ff/9dmPLtNfKvLuh+xTONshgTvl?=
 =?us-ascii?Q?4OqZzIw+qv/SMxmJyRiOg2iF5ks4KmP06whHq1W2ypLNYmYjFlfQnrB1m0M7?=
 =?us-ascii?Q?wTagA4yVWvo8TDzCXQRcQx7OPaEfo30W83ha8mWXhJs5VrA9q0P3OKY/9C1d?=
 =?us-ascii?Q?KllmqN9SvBUOi/woOg38wLjE+9OZEtk3N0Lm3Rqtu/PF0ulBkrWhgBnyHeMR?=
 =?us-ascii?Q?FpIdW1GIxTjg7ZC3VLErSg/by7ei9NTj3KXV3GWmAQpTEZtdXJl9ovem70wp?=
 =?us-ascii?Q?0klAoYOc6smBOzqdzAtQcTf9cTogwSNa0MueHURiVSzRp+z+FqStoqtWnF9b?=
 =?us-ascii?Q?HV38oBZmXOQhcY2a4jbSkb5YS9go9ZUQgJuY0lwYe6O7UXqi8toH6e9zJ/hJ?=
 =?us-ascii?Q?VvPiEMFQ3g177qPdRRhNcAkS3RdSeH5Gf26nx+6woHej8jRTJshQkRZSBafj?=
 =?us-ascii?Q?X6C54irAa//CU0xMTasciSbk4sXx5KzMYo6tkOteHWC+zjO6z+2I2fTjy5HY?=
 =?us-ascii?Q?Nb6Z7p8TSZUhtCHvJrB/SyrtU24YEVwUgvjTjOUL8r75wpA2sypb6s+cLBva?=
 =?us-ascii?Q?n4RS+eT/mJwXrQRrzXTiie0ue2XkqKaNmc3E8qqlmU5G6RhVFkj0FnBbN1xP?=
 =?us-ascii?Q?thNI5DeG5ko+6jNgORVfnZZ0CfRAXZAL9eeRyQpllVCN/TIuA8Kr/heecJ9u?=
 =?us-ascii?Q?5nuCtTrl0ctfvKo0ZkXuL0WQ+m5I8+9P2YYNYFGKHab+4EKWyIkXMLrmbfY8?=
 =?us-ascii?Q?E3QhZpKLLPFV4ODGxxOA+v85s8KwmdKF3Lz011Eeg1iNAIAwMIFu/RgSJoXO?=
 =?us-ascii?Q?YmWvvxISXz0PlmlcH/hxXGiZ+VHBI4yyZQVzmISP6ZBbmE8wDG2UEz+K9kNs?=
 =?us-ascii?Q?w+nce4m3M2KXuL29yabgRyVCaE5ab67rE8hHSEUB7jkpFhZ/GWSWLOuROUEI?=
 =?us-ascii?Q?hC93xEsUDbl5RiIau3ML+VQFsP5wPes7rlP5ZOyYSEgKZyCQXl249BeCLTW6?=
 =?us-ascii?Q?QgEKRG6jp3i9vZi/T9+kZUso9leke9I0XFCOLj5MRDsGwtcWGAuEC6cgsZ4W?=
 =?us-ascii?Q?5mtHhMng9MPkKt73IOsPnmIR7sN4tdUaJQEIGfw/KNPcNB1TFDDh4UZKyd2/?=
 =?us-ascii?Q?lKa1J7hha1rdXsVDvc/Ijynt0dQ6PQN6wWzQSxmlFwCw2sycTCYT45j977yh?=
 =?us-ascii?Q?ug=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa28561d-cd0b-4b65-0e69-08dc4f081cae
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 09:19:04.0399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mT4IaNHihzqZr0YFm7I6Ika7qeEmUX436O01daXl8Gp2CfWjkcuftyDn4T131NAc2yCrrJGB9Pt0sFC1cV872YXiRJNroRpOJne4u0A2JC8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0559

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
index 17fed1846847..6fa59d6aa063 100644
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


