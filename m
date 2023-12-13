Return-Path: <linux-pci+bounces-847-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9690810D68
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 10:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DADE1F210E3
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 09:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC78D20329;
	Wed, 13 Dec 2023 09:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gtH7PFUW"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2069.outbound.protection.outlook.com [40.107.247.69])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40EB5BD;
	Wed, 13 Dec 2023 01:28:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fRD8Pap0XMA7QqomogdmgXa5TUfunQ8zliNgrkKMCDJqovhTW6W8s30K8gHh9aZh5pBLRu/CG2z5+tOsKesE2XRdZGKIQ4Zv0wJzu/BCEDVyW6lIFMO02Nv+96tXAeUu2IBapkWXhDeNQW86mc39jZuHA+PiF19V3xW3liC/iU5z8jmKi758f8qEh3aPc1ZZRWgRZgNk9M4qFCKZlLPp7F/QdQLWdwHYYiV+6HZLsE3+nw9+gjcK+xTDl9Z9ZlPpPSyFm/+dQcet/4vjEyN1e7yG1Uitoue4aWfvXoax4FIQ9EZvrPooR3NvmmJf1TIFxnS9x5eWGdbCc/5DLEhrlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VmziI9c+9olwG+IEupTevq784wLQApOj9mGzXsHbDBI=;
 b=GbbMd07640XzZwShKq9EXvwMTN91CffIFBSW5wU128ccfCaZZVhVGgSXN4ziBph3pHyEYtfuCuo1B7cJcJcaYJX8Yru71INOkdqmr6VMi3sskHOtco864qowSTMXeZMEPidhQNra15+RbW9W3YZ4Y3QyjMULLbXQcUScAfbNAH6/euEtQdbvGO8JnrXb898szt1O4d6WBpzEaYU4DCWGOMGk5zxzc/nVfmPPkA5dEM0VUEPPuSst4JQ0PbbNLO/twksbqkoettyiJ6etfa8NLSZA0LHnalt+P0JEWyhp8BlDPIWubhtDvKyF1ZOR/iBbBeebA4wVs0sESxMgeGzvYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmziI9c+9olwG+IEupTevq784wLQApOj9mGzXsHbDBI=;
 b=gtH7PFUWCorYWaeu8rYEy4kp6ezACYruWqNzdRNXtOtcoExIX+MI76cB7U5FC2ree2fUE1noy6GMwcVNiR5wZmiPHkLygi0tLkudhwBw+LT3FPm1VS5w764ntWsZuW6H1tvUemNQmjg0CKfEz6aNDsDMyNr3jZb0MzRT1PQT16s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by PA4PR04MB7933.eurprd04.prod.outlook.com (2603:10a6:102:b9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Wed, 13 Dec
 2023 09:28:43 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::3627:208e:4d62:1e2a]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::3627:208e:4d62:1e2a%7]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 09:28:43 +0000
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
Subject: [PATCH V2 2/4] dt-bindings: imx6q-pcie: Add wake-gpios property
Date: Wed, 13 Dec 2023 17:28:48 +0800
Message-Id: <20231213092850.1706042-3-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213092850.1706042-1-sherry.sun@nxp.com>
References: <20231213092850.1706042-1-sherry.sun@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1aa69ff6-d91c-4f4b-ed10-08dbfbbde650
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8YIW4D04Irgg2wH3Z0ONNA/sWV2DIMXwgyv7nQHW4aLbhizpdX1VvoqJ5z0TlQHdsVkkKaUSWf7lIXrjVNWAHQYVhkwREcZGUXWKTRdy/51I09uB2sCutUUPm8QfxGW/D2ItEHkwKinCB9qdi93s7/WFnMp1uHKhFCLdDGxw3qGIt+ikkLSsx/Gf22pUA12h2+d1OkUioPGR6o5Mv0HZe+yhPWJkf4voGjI97CHrsTAliS02boI8rQnIDumlJCDoM/Or8kB9bzpcPMz6LEk0P1J/C/qnQ1B+g5zFDOiDMQjlSXn/PfKjPMxF7GCdnDfgZaQ9SnB6nj7A64WSEGywgVJ+u9DgPdWyZfxCtpsVcl4SaV/oQJocC2YMpcfY9/bieUO1ep+XYzx5A6V2g7lIVDD2F9gPt6VmJWFk+zmi2r07PDRJdAAXvXoTlBhB8e19TJvfpym7cnGQiRC8PniFhvIYllFXj5Hy2VQDKJA/yNAbyKSXqSJkgek1U2FP+AUFFnHKOC7DQMiEe3vll6sVgFO7CH8SIVKYPRk3nHCFifQPlE0oqaITh9kWwTcu7r3o3CsMeaFM5+1G7JadEzkDphgPJ28H3fnDAxe/dzfwrbZO07bGuawZMzXfEG8KqP0WQkL1zso+VM2K9chGscMksNDKfm7MtsJD7L/TSFAKFdg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(346002)(136003)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(41300700001)(4744005)(2906002)(316002)(7416002)(5660300002)(8676002)(44832011)(4326008)(66946007)(66476007)(66556008)(36756003)(921008)(86362001)(38350700005)(8936002)(6486002)(38100700002)(2616005)(6506007)(6512007)(478600001)(52116002)(1076003)(26005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?symN7C4wHgwfK/enk84dhKTU+8Df5a2UhzkpuEK9BzrL7yhU3wekhwk49EGZ?=
 =?us-ascii?Q?Ofad+hfcdnXxOK3F1xYAD7wViFiXvt8CtfP7CDpbdSpOeZcL9XBzeS6QQCOG?=
 =?us-ascii?Q?cZ96hNPbcnLEvqwnrkC8V1z/Nno2qwGhub3L48aqWW78pVi1DSzfYLvx+wSW?=
 =?us-ascii?Q?6akZhZ6aBFH6hf+kJ11OOyKcBKW0yJ9kM34s8cBsZZ61BLmGmzUkhb62dLjn?=
 =?us-ascii?Q?sS23ib0CsN4ls0imvWDSXJWDZzvTj6k3UOKXoCb71lM/V+EhBszgH5ntCrx6?=
 =?us-ascii?Q?NEwGogICwMl5eyRZnKMu80MhvC9atc7rIsYjCKoUCdOgov0DBzxWTsIz16ii?=
 =?us-ascii?Q?IPO3D7E7alRAtfHwA35wBXCQ+8/85AiXfHFq+tSTmeJCHVuHbn/B1JO4gSbQ?=
 =?us-ascii?Q?Vyx7RJliGrLDv0qsh4ugOuTZCvm3barkPiesBGzu/UuBWcFiK4UFCcdkruH6?=
 =?us-ascii?Q?nXalcHdPdaxlNlP86OSABf1YcnYBI2SQUWTXrEOGxTzQyeyiarYO85haakn3?=
 =?us-ascii?Q?GdhwrsROTwv1ZWBOm+QHYuplvAUFXyXSJuladAnUstWBK4Oja+6SWe4OIdv+?=
 =?us-ascii?Q?t9lrZm6Sz3xKRB9JR8cZgclt0zBCEeaQZBLYDe8+/ARdvvqtIuakO2ZvZwrL?=
 =?us-ascii?Q?NL1a/Ir3HT0ePkr+G6TRSK4VOcpSTd9H5mDszyhBFKBVsw4IahvgsCBa9Qi8?=
 =?us-ascii?Q?+RPSNqdKU6MJc7EQyK2GfXtsmbYmClhQFsrYE+6muXnyeELs8NdvpeHhq0qK?=
 =?us-ascii?Q?qTxrPpi1A6FKCh8bTNyWmcosiddrqRv+2ymhItmW2+1/2YtdzQG8WjTBt+bF?=
 =?us-ascii?Q?0DWAKqIhZTrzcABXk2UPLl01mKVufk/FKqSJdvgyDEDj640RR2xPyLCiMBSv?=
 =?us-ascii?Q?IhHmx6eADY5HIIZAcSSK6YmEAohGfUT+388RKpigUsxTujDi8Ap2t/RYK31z?=
 =?us-ascii?Q?2a46cvRqgPID5UjLNrttam3czPxpt+JnBhwGRaeRvBtlI0dXW+zvg4e3CK41?=
 =?us-ascii?Q?22rqUXtEagi7dRNDG9LaZiaYe2lXDyVcPhya2ARvwn2ljniG1V3Ll6V2GHQY?=
 =?us-ascii?Q?5NZgB6Pr36fN/+Yv8PEVDo31Vzr2zRIOXAihY+Ipe8yej21wT8m60LgJmksC?=
 =?us-ascii?Q?GcsZHEJcvrrHGwT7GtFvB5+pTwE+fREnXejDlHNhjSJ8f9dTEBQ6dC6kqQt7?=
 =?us-ascii?Q?3geiagYacPdxDzv4ET+cJDY1wg0sKXOxeleruYrQfdkYHDJtFoyg7cwzqcot?=
 =?us-ascii?Q?vi2RWBf8MIj37MOvX+TDtG8EEK0WiEDy0Mh/sZ/HSjRzBF2dp+/AG7sQnz+5?=
 =?us-ascii?Q?NwhEhPOFFeGhPbZT27S+sfarup3EJAiIV98RFvb7M3cQ+I/N4/RZYYHetg2i?=
 =?us-ascii?Q?kMMT/DWyX1YrrKs2scf24C+/NFglgAAqe9PdssOcPPSrFjZo/Regh5LaZJxW?=
 =?us-ascii?Q?/iNYS7/nfRxdXFhe4I13EWyZDvqiUVzfyx7BBQSxh5iaEc9ib00ViI7mTfpm?=
 =?us-ascii?Q?c4GHKGkh/E4DKyJlRhVWexhl/NNfCWa1rFm0GdKt3lGpf3qa708hUOZK0/iJ?=
 =?us-ascii?Q?GLHXMV6Atpy+paJwuYaGLCBifvTCZpDLmUnbgnYJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aa69ff6-d91c-4f4b-ed10-08dbfbbde650
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 09:28:43.8044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JWbeG7hdqa/S0GbcR4O3GecotUXN+YK3CKrnrGbakInc/01xTbknhcW67RPkOzUH7FtzVzEfhrt5D+2JuECXJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7933

Add wake-gpios property that can be used to wakeup the host
processor.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
Reviewed-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
index 81bbb8728f0f..fba757d937e1 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
@@ -72,6 +72,12 @@ properties:
       L=operation state) (optional required).
     type: boolean
 
+  wake-gpios:
+    description: If present this property specifies WAKE# sideband signaling
+      to implement wakeup functionality. This is an input GPIO pin for the Root
+      Port mode here. Host drivers will wakeup the host using the IRQ
+      corresponding to the passed GPIO.
+
 required:
   - compatible
   - reg
-- 
2.34.1


