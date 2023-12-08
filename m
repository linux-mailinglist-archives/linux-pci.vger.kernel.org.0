Return-Path: <linux-pci+bounces-649-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D40809EF3
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 10:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 138D61C209FC
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 09:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3926211731;
	Fri,  8 Dec 2023 09:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YGLaoYCW"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2081.outbound.protection.outlook.com [40.107.247.81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E1E1703;
	Fri,  8 Dec 2023 01:14:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PlJ7IX+XTS9TQLwHfCOmmcxW/01b8D8RRHMU0mzt6RdV+WRj20MIZ4x8cZL/a/yOQwywhVfdqfROBJd3ywNxi5vDboaGRf4Cr7gw7lJpoDEQDmLDAs5nKvSKsX1QAuewGWfozEa48uttGFb5GFGQtEWJkZ6gI/hDXjABwh1jeXSXDnO7cg7nZBwWrdmrto1l3kOSrb5q5jMhHrlxcrRDGMsdj9wjUnBucOfoqs6E6qxDvjk4neN/eylzueZuYwzOmxt04gW47HzVzMdhZ6PyJVqZUR+os6yPEqlme3yyusfrhNiUNgy8MKDtPwmW2okiPZi0i2xAqVRMW7HqryPTEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+kC1w1bXoFTBQGGU4j5WpDm8ytNSiedyJ89xDQ9f0gU=;
 b=OxMF6/Wyem/6x/STGYFwsmjL2Zhz+tZu3g92mJjzW2ylqNZp6rSrMtWZAM01mXasgnXYVkLO3ZlGzQnxw8DgOuVtyKzn7xVK/ewP4yK+JA4FISZmf1m/8Kj4OoKfBtbP99Yj1kgRDZDRFijpzhYd57JLmXj3JHmaEyF3eNKhFqV5ku5KllD8KHsDRAmclZppeKw88ViX9kUavACCenFFWo7yguGTDS2zUDMo2yeD+U96p23yekEuX6n2EE5HfNnHaEMBvwaUYg43ghf/QDmBRIuBB/VSXwfcNl+OPW0iExMW1cRvEf+BwJ9CY0tT0oceiSKIZAskyoTyZQWTkz2xYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+kC1w1bXoFTBQGGU4j5WpDm8ytNSiedyJ89xDQ9f0gU=;
 b=YGLaoYCWOsvseLPfAGnIpdh+M68IYMmLFJCGU2HDYPoZUjfRTi6+OyPqqgdrudUj0rBGHJJf0JUKx8/I+T8j0j7gIi4g9px0U97yWuV05tLIsPudRQxSR1MyuB5h+XwXCeDTb8xFQQ0CpO3/ohKngbJmU5xmAe3ZIYFf6WjGPDU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AM8PR04MB7284.eurprd04.prod.outlook.com (2603:10a6:20b:1dc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Fri, 8 Dec
 2023 09:14:11 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::3627:208e:4d62:1e2a]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::3627:208e:4d62:1e2a%6]) with mapi id 15.20.7068.028; Fri, 8 Dec 2023
 09:14:11 +0000
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
Subject: [PATCH 0/4] PCI: imx6: Add pci host wakeup support
Date: Fri,  8 Dec 2023 17:13:51 +0800
Message-Id: <20231208091355.1417292-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|AM8PR04MB7284:EE_
X-MS-Office365-Filtering-Correlation-Id: b65f4cc2-151d-40a7-1488-08dbf7ce0a76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZrXe8j2kBqzXrDliF+KkSy+aN8+GW7qBWkYK50FpDMliEng+VeOiOqffXoJMtBqFxqWdv0wDufRPIxNCgp9YntiG42H19EwHjEIspmo0njutYaKyeqqTE28QrOFDKA4vO/hzXyRiCV3Du+Y40KlGEMC5d7wu4pX3aJREvSGEQ4VdBIPAdfwYdbjCj/z91AhfdLfs+rIRMQG/R8oybXHbDjHfjoxuaWAlOc6YRL+sfqUbweNR5eybcIJJQxdiumTnjvYf7d/XZ2kBYB5zePLWIiErGUSyQpO7LsYyIUyFWfVesa6LUCoRJz9xdLidEncdIyouUlgLirGFzyM7q2SSwMP3E+3skpGybOcOHyfnfK/KeMXjGG7ijTELMliqd2z0EAqJP7kbWt/5+PkQGR7ZMckkKRkLb628AEilyNz+KtzhM6xmSir7xM2WYCNvZ1frizf+Jp9jIecWUFvF0e9zGE5qUKJEH8azxml53BZ0G6vo/WMICBKBZ2JyH39muUjrrL5sleQiuuN+oQQa47OOP0Kmahpd6ztqCpK4NE317j4FaLPyQA/UGUqPKYckJy/2EitPc/DFTaorkhKLUe8MvmtMjflEiRDMumxXzO/0bMPEzTs5WKTnEtq8hiyY+DepIHxv+251ur0JJ0mgAfCKhQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(396003)(136003)(366004)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(8936002)(1076003)(26005)(2616005)(52116002)(6506007)(6512007)(5660300002)(6666004)(4326008)(44832011)(41300700001)(2906002)(7416002)(4744005)(6486002)(478600001)(316002)(66946007)(66476007)(66556008)(8676002)(86362001)(36756003)(38100700002)(38350700005)(921008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GnJpyv1C38bbYEaiLEqdQSlEENAEJCBxDrVLaSmHhNuHSNoaNCH1s2xlsxyo?=
 =?us-ascii?Q?9oUJn/u5O1B02RacfdqR0sxxkU0ucVxITOff5b+2X55xjsRLwBaGqlDGz8sq?=
 =?us-ascii?Q?Cv3rOu3P9ZiIeMIlgO8+yQ/KwhufmikGtBKL6K/wZ6gf6iYpro6TzhRqivOL?=
 =?us-ascii?Q?hlCISVPvHH/5S2XWkDXhJdNwhmoA5V/0qMTchqRVPICU8riIJ611SuYal5Vy?=
 =?us-ascii?Q?tT/DB1NYYVlTJITUJSDWQ2ZiZdOALqkHeK70DtQNOiNFRN6oXGksocs3DPpZ?=
 =?us-ascii?Q?R1YOkCOKChv7/4NnW2vyzb+Z6ufmJQdmR8m9LMTT+gw/KUkhI6liyO3ZsYyj?=
 =?us-ascii?Q?ItagF2uxKztytGm+O28ZbJGdPz9/KUGPvCzc6DOkJngbeQYrJyr74gVaA5fS?=
 =?us-ascii?Q?2PLWhyHfaIYzsnBaBpjdGh4mPmE0GAywCJIAqmGabnM1+vTGK4ig9p2rJzER?=
 =?us-ascii?Q?8olxhIJ8FXTXuKAfjDCnL58+cNs809LIieVi9n6t5JbdUMne/fCXGREUQeTP?=
 =?us-ascii?Q?H+DzQAE+kS3ytfdKAIkpW1swmYJMlJyk0+HGt/OD5zuo8/PLEMIo0NQ0S4Wi?=
 =?us-ascii?Q?ID6i43ysmhPEzuAbEysPpWUC6kwWJ+hSMsn84IYxluM3YTZKeucYHqe8hji3?=
 =?us-ascii?Q?fnOnp+N1mQuq1L/58KSzzoAdBpCjQeiubOO4Vy2rWm2DF6+dGKjWsW0swxth?=
 =?us-ascii?Q?uobRt/CV0YLdN+fA/WfzhvhCH3JgXWtwHYUt+3720YbQ62RXNH4NTuSC7/d8?=
 =?us-ascii?Q?EgB0Xgko15MSwdQpcu8EnSEeXxHYCVOu3F7K+VYrbE0WtflhaLH+zSOb4Qf5?=
 =?us-ascii?Q?bcDwvyZVnHWlvxKaICbx+hD934ogdw6D9CIrGIIXp6gS6ixH3Mf+m3rM9Ybc?=
 =?us-ascii?Q?/MK4tZaSx6pyL6habTuRdzq0em0dKhYhx/kQe4a79d5gZEF5y/90YcyM5pKA?=
 =?us-ascii?Q?hwPTadh2uiBvWmPpXC7ERCw4NBU9Ji46zDcvb5Jx3GvFSaWFNSjPNxETjasS?=
 =?us-ascii?Q?HKtbcPAx+CdDWPfxfd01W9fVDZjZK34lzWgdrXf7bdlwZqbJ+5QwksVKXNU8?=
 =?us-ascii?Q?Z5cKL+/tTqRlqMoBPfmVmzg6A7qfEArHBG9TIvqyNzsWdw4nHDAUX7w1NGMc?=
 =?us-ascii?Q?4xX8MaGhCin9VPOI2/hL7aapR9RBB6u1dxV/rG8giPlp/m9+b62ZcQRwd+OT?=
 =?us-ascii?Q?wWzu0PKHa1LusEIPEPT1XOUckVQT27/YNMTi3ob9nRKhzTJxOTLCwZfsWOsi?=
 =?us-ascii?Q?6B9EPb7QUAGhIRC/vBv+Nsu0dcR7NZJiFYO/sAqFVB2Tf8LfRikBhxWrEGuW?=
 =?us-ascii?Q?M9hkCJkae6YwgCVCl/3cBxMuEtwebvlHSjvujiH09uEyd608i+cEAwj2fxy5?=
 =?us-ascii?Q?es1doFlwL9Tk/ZVmoM+JeO7KBsjQKlQUVDv/gmr/8dosbSSO11xPtrwfBsZ7?=
 =?us-ascii?Q?4SxRdgWIrhoNApSWkJwrDaKTfLScRzZdgdKmZsFCxC/QxYWKWzXOsIoBov+D?=
 =?us-ascii?Q?6wJnOkXCUPF+WMJglh3f6+kGatfhmEHASGfSc1VTQa/u1CC5eM5rZ2wqGavw?=
 =?us-ascii?Q?VEV4o22D/6ZlZoDwuduCYtrbslp3310Ni44a+E51?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b65f4cc2-151d-40a7-1488-08dbf7ce0a76
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 09:14:11.7758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WbXpigSOQiwUpSvARZV3Bfg6weBLAZZ6RYzOMChG0TSPzKth7eS+fKe9xxgLA69qXRKpZkjyY90U+4LDTc+hHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7284

Add pci host wakeup feature for imx platforms. The host wake pin is a
standard feature in the PCIe bus specification, so we can add this
property under PCI dts node to support the host gpio wakeup feature.

Example of configuring the corresponding dts property under the PCI node:
    host-wake-gpio = <&gpio5 21 GPIO_ACTIVE_LOW>;

Sherry Sun (4):
  PCI: imx6: Add pci host wakeup support on imx platforms.
  dt-bindings: imx6q-pcie: Add host-wake-gpio property
  arm64: dts: imx8mp-evk: add host-wake-gpio property for pci bus
  arm64: dts: imx8mq-evk: add host-wake-gpio property for pci bus

 .../bindings/pci/fsl,imx6q-pcie.yaml          |  4 ++
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts  |  2 +
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts  |  2 +
 drivers/pci/controller/dwc/pci-imx6.c         | 69 +++++++++++++++++++
 4 files changed, 77 insertions(+)

-- 
2.34.1


