Return-Path: <linux-pci+bounces-1111-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0484B815D8D
	for <lists+linux-pci@lfdr.de>; Sun, 17 Dec 2023 06:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 847291F22453
	for <lists+linux-pci@lfdr.de>; Sun, 17 Dec 2023 05:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE929EDD;
	Sun, 17 Dec 2023 05:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rz/zbAYH"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2056.outbound.protection.outlook.com [40.107.247.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F26DDB2;
	Sun, 17 Dec 2023 05:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JVjgXvvOzOOGyuQiqxjUL/uDuGVswYR4zp1/0ysNgV7XwZjTfcsJeh5arRUxFWn3/oRAy/SM+cQKRgx8wGZfZK2yPpDQovrkOThdJDmJLA8Q8GtRmqT1Nn2BrIOjS7MJ4LsmFn7JgLOh1ErkhHxO77OUAy7opmJX/+fPpn5tgdE7DcI9iHzQqr0KB4uU/UInPOX76X6YCUOOcb0eJHDf8bMCFPYebjORK2Si35slYhqMSYfuG/82XJlPKSxewWtnRcfTiVeE+sYbD9oNv7uYt1CwZPc9pzJwJe4RiB72HCeNCNRHWC8nfqpkIoknx0Jsh5ZGIgzalLaupPkLnzsBPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SmtgByDRNPfCKKNXh0SEj3Kr+Ca6Bx85HwWLkF4eGss=;
 b=g8IV1bRT7BV0dS9JDH8XtpgGm/Xc3KWAi4NZmZaMeozodcAsgKbDV32wMvFeHYIyfCjM7uWjGn9kuRhzg+SbwKQr06YSIqd2j7LMctM0p221V0856Yz3j2l8QsIr2m5VrFhw82TkkMD+DtOys4dVSVj9OzAYFMb3ohs0NIxLBJEy4QZ+p3l11UJ+rSBxncPRR+nX9oZB7h4msQ4so7Sa9FLtm9mN7Wi21UTkyLNf3GlYq01ip1jDAW33HowpggkZknvPYY+Nx2o7Oc9/2b1vOdVaYv4FRyUn8q/7UBP3iUrmxS51ty26P3WTKzOxlqJ3XKylHXhVJCwltC1joHVutg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SmtgByDRNPfCKKNXh0SEj3Kr+Ca6Bx85HwWLkF4eGss=;
 b=rz/zbAYHq2ccJW6InY0DWkKAwyZvepW+6iRJwKgKno8KxjcMUgYPpgf/HhqocvncIYpwSWhXkGOFkLIPT/pfl2mUXFhGUK491x1YUHsg5/ae9RO2BRhAigftALH8xExctfS8JXDE4DVrmzoBpaVjF2M4Ylz4gReL4zT6QlrCjMc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB8174.eurprd04.prod.outlook.com (2603:10a6:102:1c4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.36; Sun, 17 Dec
 2023 05:13:21 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7091.034; Sun, 17 Dec 2023
 05:13:21 +0000
From: Frank Li <Frank.Li@nxp.com>
To: krzysztof.kozlowski@linaro.org
Cc: Frank.li@nxp.com,
	bhelgaas@google.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	festevam@gmail.com,
	helgaas@kernel.org,
	hongxing.zhu@nxp.com,
	imx@lists.linux.dev,
	kernel@pengutronix.de,
	krzysztof.kozlowski+dt@linaro.org,
	kw@linux.com,
	l.stach@pengutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-imx@nxp.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: [PATCH v4 09/15] dt-bindings: imx6q-pcie: remove reg and reg-name
Date: Sun, 17 Dec 2023 00:12:04 -0500
Message-Id: <20231217051210.754832-10-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231217051210.754832-1-Frank.Li@nxp.com>
References: <20231217051210.754832-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0007.namprd04.prod.outlook.com
 (2603:10b6:a03:40::20) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB8174:EE_
X-MS-Office365-Filtering-Correlation-Id: ab871466-296a-4938-f6e3-08dbfebee30f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xBlrV3iWyt2j8b2cp8mw4koMgxisZfWxjDWNbMUfq3oTpVJ31lOQ9/PD2Uj6i8aEQkryDkcc0N9qqm1KVKDad4wbvTCzWUlOVYotpNzbhAFeR2I/jeDWVqxt3MfuEWruaARO7dKPVfL0eZ3QqhDY3pDWCkGslg4wuCJLZ2EtHWu7/V3ZeF9XGhhbajfNakcVOXROb9S+KwVnE2Fj8Z/8nXmS3cRJwK7ihRPs9f6FMpWM3G7K/lDn7lWYBwcpvLuoYU/FHIDdIOVM24Sbe1aYSDhDAUPcr3G2toHfV+eD9FdThgN5j9UDCs8zP/S2e0kYHJMRyHtqK025HXFAyKCylUY+xOcsyakY4pjPDNuyw9R2UmU+ZTYMi1tGko8mFhn2hApQTHDCEqAQemuu3pU4N/VvDQghlqcOa8LvYvpqe+N1uZIx3xOZSQaOvRhZ5tVYmAAvLjimliHc4DgiHR72aTwA/Wy8+9Dd6JIvyDZVCptWFvyS5myicCT+lsSUHkzYnXDfuw6MGVLtifYgbAAIIMs/LysUVdfNPQkSuRTuiBdNGlHpE4W0hT1VXCGD7l55vNAtnLm1Il2jogfs6QzKOKSDJpjg1ysyaH7tGHHv4ploUwfa/yL0bpbjCPAC3uQKveuBMJX1y635VR5Wd9KqWQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(136003)(396003)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(38350700005)(86362001)(36756003)(38100700002)(83380400001)(26005)(52116002)(2616005)(1076003)(478600001)(6486002)(2906002)(66476007)(66556008)(6916009)(6666004)(6512007)(6506007)(4326008)(8936002)(8676002)(66946007)(316002)(41300700001)(7416002)(4744005)(5660300002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WbirPrrsYWG/G3zyQ21NBA4df2GFlsz7IfHmiHJNlJUHhL1X/HlRGu4OIJAb?=
 =?us-ascii?Q?IAimvuLhu09ckDnLxWScfVlBjvQpkWLH7sYY0/v11U8lF71BiTf2YcGR3OWx?=
 =?us-ascii?Q?ghxgxhvhOFQ5F5uLN1Lsz5AcjBZmx+afPUTOnkAH7mWc2+CN2HnsQfyYpK57?=
 =?us-ascii?Q?ow8VzxWX2QlWouyKBEs3xX/RcpOIYTlT2VvrEMaSYYxHoXHceWJ400LSnKS/?=
 =?us-ascii?Q?yCJfZGRdyrDjCj4Pya0TxOoqoMxhHDfqOxtxFgDwKlG1eR/E6dfFzjW0uHxw?=
 =?us-ascii?Q?K28+xgjkDP1UlDux86cFW566zs4pDM/3t9FN2l+erta/UtcgoE37IhYC3lJ3?=
 =?us-ascii?Q?YzgLVtEr/6hUU6V18bS/Un4i2zxXLQX6IMqkjp73ZggqZjS7lt0ql/nw4c0M?=
 =?us-ascii?Q?88qlJKAPHtoEp8gdeSwmwyeV8sewVd4cWOXvVhffw+uwzVE3dGgUQ+JBefEM?=
 =?us-ascii?Q?zFGypycbB8f2w/+U8RSkjxCDC6yl5rIi4bWcplpW5QCNahpsN0xw3S1mYCqP?=
 =?us-ascii?Q?qbq/gpJ3WHzgBx2YzRaC0W6o024wn9ki/Xoim7nGBmEvPJ0mK4DvaaSjFNvK?=
 =?us-ascii?Q?wOLk1BcRHcfsl8tAfhar3xKfiUNr/v74Bly8ChcZ5FwvVOUFJJ/K5wLZHxWf?=
 =?us-ascii?Q?ijF3C8BIgYV+jRNtysNcHgLA8gZamSyoYRv9zpKKaykfZ/YaGjFFEIwsWLxV?=
 =?us-ascii?Q?WsEHEaAEa+IdyW4NYpLQRBfUpFoPRqZZn+StWIb0RgX25/3YtgQqXVwtO2XZ?=
 =?us-ascii?Q?P3v9WiHdW5mqVMJNFdG8s/+NmTTmz6P0Dwf9MwNn55OKhdePsyNqC9FvnZYa?=
 =?us-ascii?Q?BwNkVAptyu14Ew6xHUzYfSgJI/coBXNVpJXi0doKBzYlR4a77C++aMqZNUxf?=
 =?us-ascii?Q?LNHUawARk8z5dOuTKd6sLN94T2gO6LGc2dAIApTjU3RYRlUTCY2buFrCgDoX?=
 =?us-ascii?Q?5xY91YemCG+7kRsm0buUDqxss83J5FyxXp50BYXuVesiXBzsZ5+nMm1adzf+?=
 =?us-ascii?Q?PQmLOBzIDbgZV8q4gYRb2jNMsW/bbmHIPdQ2BajpNqAEH8VHqt/rX9WVro8b?=
 =?us-ascii?Q?k6ic8SHuGaPMB5BRUAQke060VjylLylL71YRg+hERqHXcPcfd7xEPi4yI8lm?=
 =?us-ascii?Q?FzWT4Xivv+6sQBJROj9bJbBrkhq+KwnVWA5lmOhXXyn+iFXK74zNJIza2/N4?=
 =?us-ascii?Q?bcImSDyWUElEO+JTSjGc9J4uiU+ORHnc5ZA9jrZZy0VeWsbSebKpK7BoukW/?=
 =?us-ascii?Q?EaKC9sRIcE/D3BP94GHulfbOPFQrs5Oh8IOL0DKgYEfmYiZessTB/tWHCiRq?=
 =?us-ascii?Q?YfINp1cJinDHTY8JlFD0ypQYTidiez7OuYQqk4hM4NO8g9B+boqXK4fJSd8Q?=
 =?us-ascii?Q?DwRCxukroZjWQdhTOS4TVlPqryTea5eUQ+OEqScTcn9X1co1yRXXB/ANB16a?=
 =?us-ascii?Q?7yVMi6d8ZTlOeLHC1AlWPEUX8uiQF8+DEVBW9hy81o7AVcm2ORLiI3JznJvD?=
 =?us-ascii?Q?gsv586a8bVSLCYmopV5iErF0WYanfoGB0BaDlS8gudcyDl9D2I6JJAMBx5lv?=
 =?us-ascii?Q?KeDbph05wmaNCCcn4wY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab871466-296a-4938-f6e3-08dbfebee30f
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2023 05:13:21.2849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8JK1SL0F+WSGKzaxEvKGZEuIsvo9CY+ZnIxCn3Kowsv6WFivennJ+pDdR2z7LlvtTBzjkIjfi7K1ybSsjvFxxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8174

snps,dw-pcie.yaml already have reg and reg-name information. Needn't
duplciate here.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v1 to v4:
    - new patch at v4

 .../devicetree/bindings/pci/fsl,imx6q-pcie.yaml        | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
index 81bbb8728f0f9..f20d4f0e3cb6c 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
@@ -30,16 +30,6 @@ properties:
       - fsl,imx8mm-pcie
       - fsl,imx8mp-pcie
 
-  reg:
-    items:
-      - description: Data Bus Interface (DBI) registers.
-      - description: PCIe configuration space region.
-
-  reg-names:
-    items:
-      - const: dbi
-      - const: config
-
   clocks:
     minItems: 3
     items:
-- 
2.34.1


