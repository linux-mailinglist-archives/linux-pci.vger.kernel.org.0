Return-Path: <linux-pci+bounces-845-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 844FE810D63
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 10:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14CF71F2116F
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 09:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E0D200CC;
	Wed, 13 Dec 2023 09:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="swa4J2vY"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2071.outbound.protection.outlook.com [40.107.247.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DA2D0;
	Wed, 13 Dec 2023 01:28:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R4sQCQTFSXJGCgcQbo/GYg5tZvohC/dU1/FUTDriypbL9MZ1tWn7eJAlE0XwQA/pxxa7GyeH3x020WjMvjJOTmBO2IQY+PL7VJwva07zpgUlZNPAM8z9btnjR83tQGVKtKhaajFfbYcR6nEcrJumV9Mrfq5RaK8cCEFO1vr5eluYLV2mW/eZ56vK1NgOrffl3MApsnEAmi6qEfgso+XWs2zgAES1yHgK5RRvYDIuOsS9vXHxFmbqvDy8mmSFUS5yl3gY0mvai8uv0G+cwvHKNzN5m++0DFcLt2Hj763IswFIz7AUFOueNUeBnYqFHVedK6g1mj69MWGBpkv7RIea+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TphY7wMCZvNGp+zlmJnQqys49yXoeznDKZlafgTDtfc=;
 b=gIhx0kmveTMqXDXMxxDPNIyUxr5zIkkPxXLGyDR8TvDjKi6aFnzK+oI/hvw7DTdCwyLmHMKZGCw1qIFtQhVnVFGCgWy432m4tI094O4IdS6GCxMtfgUVZpGRihqVBM+Tk4KovhSyQw2MFdc5XqNf1ieFf46EKMAhEMI98gzL43lI6up/lSyMuWX0Z8dbnSIblKn2q0LMozDVrWi2i3X5+dXPmiJJ+c+jCiktdXU0wpDxQmUWY78f1ncs5Twv2edjX9e7ZJou02hJyfbw7ofs6Wnv0P8IKy7zLD76V4AGwmIeZWVm/yjBQNaBXndfslc7x3PO2qparfy/aFr9OJzzqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TphY7wMCZvNGp+zlmJnQqys49yXoeznDKZlafgTDtfc=;
 b=swa4J2vYEkY+izxlMjGsx+ql0G7LAwRvfgNPamF0BFxaPwsef2ut2NWzHG6cou1VFxvCu4HZyyizF7+IlEhRqV4AtV2oSbnI2Nb7eYcFv+Ch5inOlMt7H/bcHDcV25hqGvtm81uCwYtcLF/2r3mafmX5E7UI4kfmS0zCLm34oKk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by PA4PR04MB7933.eurprd04.prod.outlook.com (2603:10a6:102:b9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Wed, 13 Dec
 2023 09:28:30 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::3627:208e:4d62:1e2a]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::3627:208e:4d62:1e2a%7]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 09:28:30 +0000
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
Subject: [PATCH V2 0/4] PCI: imx6: Add pci host wakeup support
Date: Wed, 13 Dec 2023 17:28:46 +0800
Message-Id: <20231213092850.1706042-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0021.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::8)
 To AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|PA4PR04MB7933:EE_
X-MS-Office365-Filtering-Correlation-Id: ef79a381-a0cd-4174-f7fe-08dbfbbdde57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	grxh4vLVMeuDnhgCbKmEry4Prn0vsfUDkuLEnYIuWU/nI8s3Lhn3lpe5/7LbSC1tEVN0hnVMGtwXRPNBGBN62kW/FW8ilezxPb8R2ShB2kcV/0t0VGyiARxwbl+yCsoKWTmdbO9RN7zF+da2ocrE0Q6Td+m8IlzeRSnALqyZU2eUhdaPQ/QfCcTJj3RgfqPh3FOkGpPr76HM06yM2rH35Sqz+C28J89YEHxodlcbUt57668xWZNGDnR06sE35b0iRGguMrfrpcOF+NCEx63R2BBM431YjlLmLsR3Rc7bJlfjzNN5aboJkNDx9SeM4uWDwkiz4n7ODZ8Ent2OzycdN9hF41o37IJkaJE01fFg2KN/Py/oHt/8RaJxmDiHjh2xBtPWJ5Y/YKyJmPuwYNUzo4dB9GwTpBt1UmIWbXNOZ7TPE1oHuaAbRu5CoZRXGcL/6Td76xtOz4YEZXJXER+Jb15NryqV6eFIknvkUoWt+kMv20QLxd+VR7iyI59BXHwRkqkQJW64G5qctf+PAR7jPbyn/lU4kmVXtrP4LxoSeEqIRi29CANyBe2XreoNg4urZpx37pWWFUd/22Ha6fTDbCyMIZMEwxewU3Riiq95IPWoDxAqPiaEHsi2HK0aLFRdnBdCcYdDrV5SVQa0bzFAew==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(346002)(136003)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(41300700001)(2906002)(316002)(7416002)(5660300002)(8676002)(44832011)(4326008)(66946007)(66476007)(66556008)(36756003)(921008)(86362001)(38350700005)(8936002)(6486002)(38100700002)(2616005)(6506007)(6512007)(478600001)(52116002)(6666004)(1076003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zZJnJq5nUTQht/6K8pRgPIvhZmT/bW3oXktqtQ5iVfCvwVAMOED/LlVEhmQW?=
 =?us-ascii?Q?AEgN5kRlVUsiJ5al/9oI5o6hg3oyzDr51E7tJWV/62Dt06r87CB+30uxeS8g?=
 =?us-ascii?Q?sWHF/A8mI8EypcVCnnTqvZ6BIS+QUDA1F1CJ41Ee2Z3OrWBnVz8hjUg9NcZz?=
 =?us-ascii?Q?D/Egzi/1KnWvyB5DWzVWxJJZOcTBCXkTkW5xDDdEFwYBNdCesxD9lihEeb6x?=
 =?us-ascii?Q?t1zCXN1XZr9pI4gA/Vnhh4xztsQ4inOY3CFRQSkwoSfIH+maeyAFVSfwHT7G?=
 =?us-ascii?Q?WU0Heva10FDkDqwy8aLexP7xoDzMjeIlOdK6ihXbKq/atoNS4uPlwx0eO06q?=
 =?us-ascii?Q?780VKsLHti2di422wIRIBP0oU4mxC03EZ0yRnxSA6SBoraNE0oJKPxdCW7Le?=
 =?us-ascii?Q?+120MkupChA9/REKB1anEFgnYYGOoBwaVnWskjL1TkwRq8KLnlyY3umQaBvM?=
 =?us-ascii?Q?F0wy2UaFWtMbAIhcknnW35l8RXYVQYy6bFVG4MzLjcOz+a0X0z75a5afgrlx?=
 =?us-ascii?Q?nEGbwxhMcmZVTDJDU7WlLOySW+yixkuK7E5hcdrFcKpH4H4gj5k81jg3Pprg?=
 =?us-ascii?Q?9FY8LP74VjC/NAVMzbwMKS8OaEACNXWtbG70SKwGLjt916xxfz4Eqd0qFSUc?=
 =?us-ascii?Q?3VoXgtys2uNk7tjImN+2P/MsELcttFNRJU/k5zvJF1VWtdCpsD/8Mb0QWuPs?=
 =?us-ascii?Q?Wp8td3T/XXP4M/en3BAjwUTBYuhghTmtQSr0dKd/pXV6s0WsSZ+s8pE0uag4?=
 =?us-ascii?Q?tgfFsJA2kLSJ+3tfXct4verylkFKUOuuLoKJklPYmtDEQjmlmWwcRv2OA33z?=
 =?us-ascii?Q?OJzLccVXJqa+kUspV+I0sB9gxrxvgR4IH2Ul1sIhFJ0q6PPGvEYqqPR0Lv/2?=
 =?us-ascii?Q?sKYe8BTSwroAFtqelIXK5e9ttagthnoXbH737EH2fLtdcUdp5B9WGsZyX+qv?=
 =?us-ascii?Q?hs0XrbKQwnyK8FU+VYmIKcObJ/RdzvNK4vC8t1LfWPV0qAMWnp0bS2a2vsD5?=
 =?us-ascii?Q?74FCkewcBWA/Z9ijwZcZ0gUYjhqzIxeXRJVWUza34uR7U1RgfpdF89Li5Bhh?=
 =?us-ascii?Q?dw1rer/QBG/d0Vkj+vzLVk6/wp1xP7QkwZJbGAOkRMX+nUUVarPEfqAcASOK?=
 =?us-ascii?Q?HE2Niy6xfgmEKXtXURZhool+CRK/Yg2wKqqsROPKj73ws2Ggn5hgRZ7QToey?=
 =?us-ascii?Q?ju9cvfPbJ1hzyjwCfbkf/Aa8aCWkX1yaJfxLqkW3CMKqnj1n+nf3HyOKVVw7?=
 =?us-ascii?Q?nqaaA1kFPxj24ZHiWY+y4FuF5lyg/F9g4spZU9bO7mssVCTdJB90BsHQtAt7?=
 =?us-ascii?Q?6eI/ilGeRfapKiTKgdxZ7gOQfUC8weRrjhpShUIlREGlf/aM9ahGSWFo1k5F?=
 =?us-ascii?Q?pnNTzl8DlLi9wR2ucGGmxVyrJQpfinjsvmpQ6XkrppKp4FlI89GxzJwbg57r?=
 =?us-ascii?Q?AXl9D26NQZE6dJ+1HzSvyKG0cySvczeZDaRM5ffO8Jv+faXodpXxqeBH/JpA?=
 =?us-ascii?Q?eDz3dm7i34x3wWCrhURdRE5Qhd6cZlrBu9bXYTsqC23PmqVk5E27nrwxj3sa?=
 =?us-ascii?Q?w3bEz6CKQi3iubYScq2gLucOLZkMvdinV/V0X7I+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef79a381-a0cd-4174-f7fe-08dbfbbdde57
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 09:28:30.8309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s/Zoyu9lAXbjtHQ9f4riHJfJAPpRRva/oPdAzupb0J2drORuYtomz1Ebo8iMoul/FXtJylDkrKeJ3LNVGq6F3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7933

Add pci host wakeup feature for imx platforms. The host wake pin is a
standard feature in the PCIe bus specification, so we can add this
property under PCI dts node to support the host gpio wakeup feature.

Example of configuring the corresponding dts property under the PCI node:
    wake-gpios = <&gpio5 21 GPIO_ACTIVE_LOW>;

---
changes in V2:
1. Rename host-wake-gpio property to wake-gpios.
2. Improve the wake-gpios property description in the dt-binding doc to avoid
confusion.
3. Remove unnecessary debugging info in host_wake_irq_handler().
4. Remove unnecessary imx6_pcie->host_wake_irq = -1 resetting in error paths.
5. Use dev_err_probe() to simplify error path code.
---

Sherry Sun (4):
  PCI: imx6: Add pci host wakeup support on imx platforms.
  dt-bindings: imx6q-pcie: Add wake-gpios property
  arm64: dts: imx8mp-evk: add wake-gpios property for pci bus
  arm64: dts: imx8mq-evk: add wake-gpios property for pci bus

 .../bindings/pci/fsl,imx6q-pcie.yaml          |  6 ++
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts  |  2 +
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts  |  2 +
 drivers/pci/controller/dwc/pci-imx6.c         | 60 +++++++++++++++++++
 4 files changed, 70 insertions(+)

-- 
2.34.1


