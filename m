Return-Path: <linux-pci+bounces-1793-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDA2826C45
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 12:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4EB71F21FA4
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 11:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B362714A89;
	Mon,  8 Jan 2024 11:10:20 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2050.outbound.protection.partner.outlook.cn [139.219.146.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A9514ABA;
	Mon,  8 Jan 2024 11:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WYQBUgEQ0VRnJUy+VUYvbz/90fFMBMNyWkHRvWtcYMpAcDNeGQFLtUsKb2+A+gNCMYvw2OHzakhLwNYxIrAnZoLZHovQZEjlBGd/zqr1KIKzIOfbOAZJJfSCSk/eJh9sKe6G++TSr9MQSPeVR8VYprdL9eSpd0y2cw5xiR2tWXOnNnETX6v11Baql+QyGGJ6mtCRNR1SvAlRxSvJgyS4baRGVg8LqILcZpmlM2eQjqrhzvoV+bU3Jfn2aI973McbHbkmOZqJ7JDHIjEocmAbN/tUSuPjB53+ZN39z3vtcGblospRA5ryMSsseMGMEdOzJw8EIKo1V4ZmYIDcviG8iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rk7I7qrzmKI1l/EnFZ3e3e32keUVuOOU9pJsxnUoF98=;
 b=IfLLApPUaHJzEHxEhUji8xXP8icyHYIFPBvpkRo4c0bSzWvXYplczuyI5m/ElY94qcbztulVaDDwp5ySQgCkRdrELRYCfU7++9/hIT59nMPeRmOIoPPL6rkYaIOfSZQ0VhkNkERzA2L2u9f5glchWtdDLz2ryG09rMZfjWjWTAJGbmfEgoQjf9YSachdc2bnhDfZyaOQPDZ/t4fsSW8EhJBEYw7+d5Y5l8NcXmyaGXXVICM6iYNJYIkZhuTrnPd8AW1SltDoxBXKUPU1dr1Mvx3hUd87BBSmtdVXo8MzfV5MnEgyPfQE/mtRBaDhI2SMg+QvBh5MCG9qS1RMWfFWIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0797.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.32; Mon, 8 Jan
 2024 11:07:01 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::e6aa:baea:fd8c:4cd2]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::e6aa:baea:fd8c:4cd2%7])
 with mapi id 15.20.7135.032; Mon, 8 Jan 2024 11:07:01 +0000
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
Subject: [PATCH v14 20/22] PCI: Add PCIE_RESET_CONFIG_DEVICE_WAIT_MS waiting time value
Date: Mon,  8 Jan 2024 19:06:10 +0800
Message-Id: <20240108110612.19048-21-minda.chen@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: c41f4676-138d-417d-e107-08dc1039f0a7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yEpwQKZcTzsksPNn2w9h01LlRRzpEQd6tKMBfojLcLvrkCAYijI1gUENONjYtf5cFY1q4ptr6Lw+uAAThokUXkNCoqwxgjZsOx6e1L7Pdkp0CEODZxtUi0T6MHyxBbZcn9ZnXgYsnGxUx/M14ZANq3mXiC+Jmrkqb/6RfG4eR8ZNBRMd8/sxIaj+NcqLbU43hCLR5L/WQw4cM7MidGsuPIHKNWcFsjrl6AhMQnnBPoUcuqlDTL/y+Kj2Zr5dQWVb2KZjqsLvHSzaxqi0rBOHJLJMr8yvKIvDTurimrAUWOH7YYuSgb03Nu1Ij6W3q29SsjYk95F33SVS/yJathFBRbN0/fnFjwAB1763lo7XSX8Q4aatywxC6qTUgJxnNPbatf0WIG8HwuQoeA/PtyksRioVzAohiGltNwINKUdJ0pmlgAaPcoQq92r0jRu+HvuXFQVN8mQTjoyN8ywGt9mJXrbHQUjIrvye4tsDlnvJPH2O+RaxzmAaYVQA7CHOq7s6NZeRbY4JSBygXBvMznvBHIFvbtOe/6kAs6vM/dmxzoAstnvmFPxSrbVWs7UhiXNi
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(39830400003)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(8936002)(41320700001)(1076003)(107886003)(26005)(2616005)(83380400001)(44832011)(8676002)(4326008)(86362001)(52116002)(508600001)(66476007)(6666004)(66946007)(66556008)(54906003)(110136005)(40160700002)(38100700002)(38350700005)(2906002)(5660300002)(7416002)(40180700001)(41300700001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?je5Z9Y5AyTlaN25nO+PfGa1ZdN51/92SBR/EWZXp+CSLzsQ+xZTKYLQQmjXb?=
 =?us-ascii?Q?jjq/NSKQEEJMQonb707SRUwS8xabFwVwfkd0/y1Ngps50Mt6X+SdyMKzxjTh?=
 =?us-ascii?Q?YnzPuNnXmIETCvjpAjkvnpja86GjSwbwnFruSxe+UdZy5HBNpQ+IF1Ewulk4?=
 =?us-ascii?Q?u7WAsm+FXJXk9ovKtnFkIAZae6nesuQCwi/z+GEtBP/UYeZhlqoq6Mqf6huF?=
 =?us-ascii?Q?wMTI6j7ur0ubGzGvo31wLxmfUMls8sZjpo59/JZAEiT4NH21zSMMvZBMXOkE?=
 =?us-ascii?Q?HaLiooW3KJC2HDazE6iemfOt0g4SOOI6mEt4aqV2Ndh4x5gngwyj1RRnf5MN?=
 =?us-ascii?Q?xXgcaaJ3kAei1jR/qevSXYko5+BvChWCMq3T6Wu0mFOrzrwbduEY06IoLvcR?=
 =?us-ascii?Q?gzH4ih6IMg//yZQZ8A0RgCeCkxaOZuxYYZcWUtRJhxrCrwWBybYxIM/W8C6A?=
 =?us-ascii?Q?B1CCAIECPmqiGPNiJlTb6Nk+vd0LYUXCj2EfVUXYy38mClKPjq87JP0W8CmZ?=
 =?us-ascii?Q?vjGSat23R7RIxNv2SyVWwC3bjnTqmhKODEcerfWdbPvkpOE/QhDPB5GYdMMp?=
 =?us-ascii?Q?Js5kNAMQKI4sYpStwbR5eHfRVg6zIB2ihZGfPBeuTpB7bnXRJ6ZhH2qGVKNo?=
 =?us-ascii?Q?aGH7OkY2fPrq0cYCQUjcSct+aQCL3XFjGUXzO6lB/ba1MdPA8jbf9LO8fzF5?=
 =?us-ascii?Q?hLLGNCmoDTjhWogujNoKqgjL0uRAHAiL8txUcwJTjuXT+jD9z5jWP3EiysKQ?=
 =?us-ascii?Q?7O+sBoDr3IOTaR8kcN48Yc5ny8BUkJ3uE95Mnh5RLh3vEPmNvgPJh8oiD62w?=
 =?us-ascii?Q?BtS3Mt481mjTK+uBTl496UfjqAvGwUFMy/kno90SgAFDf135J9u7L/nU9UjI?=
 =?us-ascii?Q?LZaYINGXQemIRY6Rh7gvvF4AohCw33+y8NYCllaCjS0R8SsyGDlHuV9wWK9q?=
 =?us-ascii?Q?/eVJsZ89B/yD8kJvd00pArPqrKz923zH20z/96c2aKEUqBWn7c4rP5O2cNTS?=
 =?us-ascii?Q?mNhJGaa0RGRxb2jp/rmm0e5uT1WufBKwpCzgXP85dS07P6dfbUpjtpHSnJZk?=
 =?us-ascii?Q?L7/1uNQ2ZfwQRfNQGWzul+Q7RTgI1V9nG3mNt1LDi7tgAiLZRZqRfFMvbbwg?=
 =?us-ascii?Q?i5nuDFoKtfugVqDMBeCh592FiF5yeJ9V+BQxdvC1hWJ9CDhDIQJwzbaoRcpX?=
 =?us-ascii?Q?dNiv04FHmuoIzCC40Gphgtm7fHZdKY4zoLDB5jPoqSRwScMQMPdy5cHXTEM4?=
 =?us-ascii?Q?DqfWdMnOD99w9D/YFshrfj4kckv2ztPMhc+BxeM7ojGgkMEm+BdUpfSOYt/T?=
 =?us-ascii?Q?rIU6deRiWTC1kDz2oI1l6RvbwjSDsk/Dc25WhdCeti4/EVE+Z4MUoM82swpC?=
 =?us-ascii?Q?m5o1tJYjAUk6OuQKtSZCSamL+RNBZi/CfWCE84xmy9ItZ+LHvNoNQvchc6Un?=
 =?us-ascii?Q?yth9b8zI6QtU2LZxXjSAOWf/CK51a8CP2gmpkf7UfwtDVii7A4nFHcIccuA8?=
 =?us-ascii?Q?TYIhqCh6s8uouaasr9xDCwzSB0hACAD06oPAZqq9vWa9qPMcEg+q0UsTiBgd?=
 =?us-ascii?Q?Vw0nEfwEHjVJdDb9xYTvX20WOKdVWOxzoXeNH8BquYWZgC59iihulk+BqeFS?=
 =?us-ascii?Q?rQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c41f4676-138d-417d-e107-08dc1039f0a7
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 11:07:01.7931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 49OUmuFZt+eC2Q2JgObT9k4JA1LdP1QMbBs41tyIQH9bGqW9//cNJ2GvdOx9ZRW4m7JosuRVQzWgQOUxtg+59Ejce/91M7im7OiPNYhXx+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0797

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
index f43873049d52..6990146e14e3 100644
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


