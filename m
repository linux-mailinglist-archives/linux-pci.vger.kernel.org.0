Return-Path: <linux-pci+bounces-651-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B12809EFA
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 10:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2633728180F
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 09:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CC21173F;
	Fri,  8 Dec 2023 09:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="q5PFFkIf"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2087.outbound.protection.outlook.com [40.107.8.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18F6172E;
	Fri,  8 Dec 2023 01:14:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NjmVfdl93EzKm2/X2YVcm0gwWTchtrcdrAxB/pBUzzENJJCUqdPBZhGZPfu94FvH3rHhEVz1L+BD8VDqdyajq5xHBR0kAItdyswTelqK02homOL7iE7hBylkJQjlyLRKg2cz0uVVf05gijJ3C5+X17Xc1OYBDsYDRBye+zu0NtcPKHTV3aQmAVCv+patDkHczpN3IzxzR5BRZQ4vF90Hrm0nED5wnDU63rAcuZnI9s7gBT1nc3ti0wqVCox3Xei5Ar/b6LCmvb+C1YrsxRKe6Bo+X2r1UgVlFMmMQgBmxJvdcRKmZ+qwKrEJ7NE+OhxBdmrlYoC26uErVqzrK5rMvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PvhYMbdHsfjbcSdTf0vVjjCWEz5ru10GC5wL8RXiYE4=;
 b=D9HYthtlPTep/jLUGJClaGtg9G5tLrDAeXdANTf8YPXC27u6NnK4LXB8/m6TR2/jkOaCwr6dVS3MM/k8U9a18ybtPyXJdSk5j7KxSBjdite3pDs2amKP8J19dHnxEEJt13q2rztf+ydBOcNmFUkgXmtm6LDhfa1SRVNEwqjp+nsf4daDV/3YU8GQetbYQw44XLkR6KqvGY67wgjGRJkp786vi1gHmF398Z+QMdBsDtpgpgAdoFDnlVcwhGOBBodOx2p7NerLSUOVytEmKQdJH+cBQMAD48GtZ7P34g6g+Cd+GMuXL1llibb5Rfoox8cTK9EoUa3GbVrLKTL1YfwSfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PvhYMbdHsfjbcSdTf0vVjjCWEz5ru10GC5wL8RXiYE4=;
 b=q5PFFkIfbJb030mDDYDSgtCT0hlbKzGTCE8W196KlGZ2TiuAURkklp73uGChML/NDVnTAO8AdBN7NeCVLXpqwwj7fOsUCMSjN9AN+JnDuAe6Qv+i32puzBYcTGGvlx+umK1nnKCAViE4lpRgagS6yYAF2eDvlwQ/bGuilBtcZmg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by DU2PR04MB8646.eurprd04.prod.outlook.com (2603:10a6:10:2dd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Fri, 8 Dec
 2023 09:14:26 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::3627:208e:4d62:1e2a]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::3627:208e:4d62:1e2a%6]) with mapi id 15.20.7068.028; Fri, 8 Dec 2023
 09:14:26 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: hongxing.zhu@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-imx@nxp.com,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] dt-bindings: imx6q-pcie: Add host-wake-gpio property
Date: Fri,  8 Dec 2023 17:13:53 +0800
Message-Id: <20231208091355.1417292-3-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208091355.1417292-1-sherry.sun@nxp.com>
References: <20231208091355.1417292-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0006.apcprd06.prod.outlook.com
 (2603:1096:4:186::19) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|DU2PR04MB8646:EE_
X-MS-Office365-Filtering-Correlation-Id: af42ab9a-ce2e-42f4-6df0-08dbf7ce131f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	khFxdF1IaUxcVz+1nnpC5f7QvLyWXGvTTG/PNQZeM2HTmglDxEzo5xGwZAOIGTnUSJg4S7KfbPAExCqo1BRe63G9EVrB7B20X/Yec1FLJjbGH/tz2o09JeVAyFNUhNEWVGuiPfBYy5lj4qHPRmE2zwPNQrAK7F1G5XGbzyelXQ0pTN+O3yPaUZiQV+JNOZNmbwQ9GavorAQWKKYf3MeWVNNmB3LqHy2pZanqejYqHuACWnh1i5orWfzm4HJvbG13m9wJpkvLWUAlVibj75C1GfAREG19OpQ9GL8HSAKDJT2G9S92/RFa2heo63lrJJPak87CnmV7G7lcp/nXCLjDk6rJfyo9Wq4vAJOQ3+nWcv+8jJxRN6wPDVlmr6krqdDx/1YU2e6nMLdLMWPqSAyq5iIZgNNEHfiTaafeQ74zO3FWNIg7XeRmJBA5RYZ5E/Wg+cT4yKocOA4d2WoZSRQYuV35M5KxksXdeqKFu8DrM/W+g8rLRZYqpVaCgJTkPcmKqxkngpnFxfbtpXB7SnC/ipbwpSgFa2DYZ5myQPObU4orXyJd8jvcLVcxksobrie5QR5fMJdfDGCU2b7/9wCv+gPw9hXamc6RZ/Ru1QtoiVwibkWhmrqbRU5ySMmEKInMJmze7e7SV8Nz2tQrqucjqXn+Ot9kvZHrSLMT+0qxmsI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(376002)(346002)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(38350700005)(921008)(41300700001)(36756003)(5660300002)(4744005)(7416002)(44832011)(86362001)(2906002)(478600001)(6512007)(6506007)(52116002)(6486002)(6666004)(26005)(1076003)(38100700002)(2616005)(8936002)(4326008)(8676002)(66556008)(66476007)(66946007)(316002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iN/g8kFpxQZ8QXlXJHua7YxkLVCEPRdIr7nx8xXQm+UYHI4IDPTp5m3Wr3IP?=
 =?us-ascii?Q?gTbI0LPj5inUxbPXFFFPC53cxo31rnqgG1ApJFq6ReP5KPhIFEjngRO/Un+Z?=
 =?us-ascii?Q?BxSNlnsEjfAWdcAZVcpMaYjjmejBuR41V6RH9GJg68coSEH+u+KugfqV3KPk?=
 =?us-ascii?Q?TVMFb7RYUoelPRChQ0BcQUJBLJaDsbH5Rq1ytjn49hf5IXEuIGhINHubi4KN?=
 =?us-ascii?Q?YhvdngPNwYX2iUNPbT06rccyQXhVc+heXsII3XBAbdX7PVVAeZ62lprwfnK0?=
 =?us-ascii?Q?LtzS/UjuT/kkzcCZqu8JYY+eRWbmKbpY0Bp/8gD/dcuRy8FDusN1QZC7ESbl?=
 =?us-ascii?Q?cfBSzwGrlfOoRjc1FZV0vfrpLAtoQlDiC6LUKXIOsQb/VUTCcG1CrZDqW7pm?=
 =?us-ascii?Q?Tqmx29/Vcj2ydMAYUz1m0y4de99y0e2jB5H6DpXJrL9EGC82oR+0VvevBoxB?=
 =?us-ascii?Q?gGHQqqARsQU/8nQWrMJIfnH66xNjNhhDgMi6CWPlkNaGTsfCMGFB9EXvvlNm?=
 =?us-ascii?Q?hDMWpr3ji8M8imKcH0Fi2KKqvLLQr725TA7N/+dQQRm24eM9yjyHKACHoQub?=
 =?us-ascii?Q?Sh46tnkQUNlNtk+CUeEtQ1Twb5qxVIUDKxYti8Nx47Sz2dtLjJDV8Nyf5/Vz?=
 =?us-ascii?Q?Dqla1osgy1KMBPsasLxJQxn2RUyYJz1jPtfKaJ82gHVimI+qMztI8mUPOVIU?=
 =?us-ascii?Q?xZ1BPRYZRay1cGAiisrnCUYln2RKbyuEHv8I6JpjTgwOD6suZz/2emfH9WXC?=
 =?us-ascii?Q?XM4va872h5nJGjJQca5Os2dBiOe+vAMz3IyyAUyRYNTHK4cZxXu8WvK37alD?=
 =?us-ascii?Q?YtpVjkcp/Q/iqTlRLBlNpAIQaYvIiWKGZFX0LT8JPWvPjXD4E4Rrrw0mAGWd?=
 =?us-ascii?Q?zXSSyZVIX1HhdhBsigQWKudq1ku6dDPO3ytBBcQgheCIFGE0DBdqC3+al18k?=
 =?us-ascii?Q?hqmaM5vReSK70k3ZN35XQOh05lZOJvJozB6ZFdbkrDTfOUWHDaNPzP5AMMRd?=
 =?us-ascii?Q?lVgFfE9hBKfAjkzmmaBT7sVKQ+NPIchjJHOYtI+pTJw39TCzK+yn/svrKm4Z?=
 =?us-ascii?Q?wklDxS6+X6fz13H8TbaXdISPuG5YWTL+z7cKw5deTFOG1VUEn4SwRNMlfVyV?=
 =?us-ascii?Q?O6zQiOUJURGYwO2+TasJ2L0JmkwTehYWkyPP9pvE+ct64u5wWxQguLkrN/u0?=
 =?us-ascii?Q?/klZy9tMXbN5n9tH2rS963EPXf7pbABZCqd/RXg/ZHx7lRLfRsSEkyD+JW0U?=
 =?us-ascii?Q?DBZrJOiWoesgJd2FyyFsngQsPlWUIk5O6unBoLJ59QSF0Sex3yIkjuWxLfmb?=
 =?us-ascii?Q?iekVyYS6ZpfM4QealGsh3XqNQsKONDbiplQqbkKjiM8MqfxShWpeW3plQ3tr?=
 =?us-ascii?Q?s4b4MCk8o4C5KO4j2zWVcQSoKWKGC3xDuT9ZxVk1jYpV/qX4JnHZmcRMc7th?=
 =?us-ascii?Q?dkXjzAnFeuI43PiZt6SlVEFFHDJgjWI3i0FezwPzVYCVvfMDLAcwEfaQKU48?=
 =?us-ascii?Q?8dnU6M0guiYRv5l4l4BP3JQtaCwoNMBQiYfoVl79qrknneQBZsivId4+FYEc?=
 =?us-ascii?Q?tjWQeMiDSgSHBNkgn+Y8v6+b47r0TguVzGSjKn+q?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af42ab9a-ce2e-42f4-6df0-08dbf7ce131f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 09:14:26.2137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 68A/KkcauGMc36BJgbOhoOwJZJrRtliBSE7DsMhVDERo2jjZAX6iYmmEeCUnl3/O2t3Y9eWKfi0NyT6/wEsiPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8646

Add host-wake-gpio property that can be used to wakeup the host
processor.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
Reviewed-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
index 81bbb8728f0f..944f0f961809 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
@@ -72,6 +72,10 @@ properties:
       L=operation state) (optional required).
     type: boolean
 
+  host-wake-gpio:
+    description: Should specify the GPIO for controlling the PCI bus device
+      wake signal, used to wakeup the host processor. Default to active-low.
+
 required:
   - compatible
   - reg
-- 
2.34.1


