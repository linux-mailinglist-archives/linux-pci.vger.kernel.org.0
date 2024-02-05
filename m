Return-Path: <linux-pci+bounces-3106-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EF184A0FD
	for <lists+linux-pci@lfdr.de>; Mon,  5 Feb 2024 18:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10DC71C2234C
	for <lists+linux-pci@lfdr.de>; Mon,  5 Feb 2024 17:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F8F446BC;
	Mon,  5 Feb 2024 17:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="B6IbmLVI"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2042.outbound.protection.outlook.com [40.107.20.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5EF4F601;
	Mon,  5 Feb 2024 17:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707154503; cv=fail; b=kg5sCwUsaLgCJ/K3K1tvPZKV3dnqP70NSYpi6RHMDkO9mTfLORxyjKBVZKPmKDP+c2xFglvtXXT/3M10OKXpimCYCz8qUBjOhVcJSScikUfjPMKMbuFgX14xr/aGMZIxhE78G11o+TPNqZyRm8jBR6nje6swd1wrR3pQXbyia74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707154503; c=relaxed/simple;
	bh=iFUxdRN3L2SpjQUZm4S3F5xYleOwOVtp+4PH2WmXswQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rw6ct+rPU2s8ArYg+M9JLizvH5+9lPcDivHbHWPHgl3ZzZFdBGE/uoDNFJxhc2bPjfACwRbURi0yupJXDN88RIEah128O0nyc5kR4fXBT8i+dpAFSfQsZWSCAjylS30uuorq/ZtoB0ORZ4AEtq1gpj8nRnFddnS+RHOJ99vbZiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=B6IbmLVI; arc=fail smtp.client-ip=40.107.20.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KIHsDHW+8oa7agmwqRB+FEEIdag7DBydt5EJtFyg3OxYHl9h9f+o/GEaFe8CmAN1m3g82a7ICNStIMDc8DJwzGUvLAUMJG6ZvOL3ieFxvZ1cFAjOb8OPCTfVfRv+sYabBUXknkFgaV3dPPJ48O9oJRjne2ifIAIrmCKgsdKLTu1E2A2cp+xAKl0cCbr93XQ4sIYTDbMgtyFv25YQO0do0WHh1EeTFzR2ZAX16FFYVL8IEJHLMfgkr+TxmjZyzkBFeYwBs4okNkmy50Tb6vtDOLZ0GPZq6Posd2YzikG6vXpCkntOT/kDn5hnp2dUyJ+KqAkgYwTNdHTKREuSVn8xTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rhNl3Hork5CmF1omBkGsnHlaO2lfUl4S/hnuftb6GaE=;
 b=c6BP2WtJpfTDNBRtpTqD+6Xs5Ysco78egNAngl+ms6DipTE54SbE1S78ZJmfbL2mvTXRdVRZMNuv8hmccCuXa4TeJL6PK/Jfnrb2MnQbWdAuTpAKLLryco49Rky4QhAQiARh3KsI6hKqoLbkMChGpsMn4N6t86tWEqpKmSRFGxLaXXDEblUPFDPfKjcNS240q/tynG8IiXJw9XpPSRDfB0GPwUQEAEKVHmPG1bgnR7PrMcAi+t1lJjxW6JyhbD24oyHW6TMEyKXI95A8CVVqoQ60yMO/Er/lotUFhLXP4uWJsDcnxp1kWFNybETQOzb8pMx22grOc8WWlRVVLzZECQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rhNl3Hork5CmF1omBkGsnHlaO2lfUl4S/hnuftb6GaE=;
 b=B6IbmLVI/i14vLQiFNWD+IVh47eYxzQpEgGdHaQZJfucC6fctnOtbrBjC3oE3pOdf8pn9pHek3n/NfH/ag2PIKKlNwM++0iI1kA6jQqmriyWCmpgW/w7hHnthvTyhVYY24EzdTNNWK2oVHFbDM3UNvUfj/LHMS78VrLcg4FbUKQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB7080.eurprd04.prod.outlook.com (2603:10a6:20b:11b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 17:34:59 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 17:34:59 +0000
From: Frank Li <Frank.Li@nxp.com>
To: lpieralisi@kernel.org
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
	krzysztof.kozlowski@linaro.org,
	kw@linux.com,
	l.stach@pengutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-imx@nxp.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: [PATCH v10 13/14] dt-bindings: imx6q-pcie: Add iMX95 pcie endpoint compatible string
Date: Mon,  5 Feb 2024 12:33:34 -0500
Message-Id: <20240205173335.1120469-14-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205173335.1120469-1-Frank.Li@nxp.com>
References: <20240205173335.1120469-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0041.namprd07.prod.outlook.com
 (2603:10b6:a03:60::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB7080:EE_
X-MS-Office365-Filtering-Correlation-Id: fbe7cd01-26b4-4fea-ab2d-08dc2670c69f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UaVzZTXEoIEl127RXvqrazPiO268a2RqOzvzzZ6cw2AL1aB8AwEfj5fDOr5chHEWUrhBpQ2bWWHmjqXvDTPcVuv6V+1vXcjgpLurDi/KKLp2NRV7lDf4D0+2iNhTWPRUvce48ipvkxd5FCXNdlX+TCK/jQXGeP59gqDUsSN2XRiPExENn6Qj/AVA+r961VqixkAiPuqI+0siezFX7uPJthVVjq1I+XZIwtpbrnNq2+pCnBc7PHHD1XgzXbhzRwuwCbFKbtVn8FkqNQLBXkG0ObEGkRFe2OlsOgzYt1mjpYItx45njyx83Hxe1Egt4QhYZMObdSF8ZRcfjsmHyb21BXbxWZUPdl67gapQ3g18dBtF31/n1ocGQq2tt/qDesi1+z/tFhlsWViy8dSVMGtwCq0aosvT8N7RKPrwKSg7ARKTbGvWaHSM1rjy/PKILx3AH1qF4jX8DUABL9UPuc0os/Lq8aKXxl+z5Y643SOAPQoxD50opGnvcFNDiqQcllLYumr4/kl5Vz0CYp0GYpUix+fADo4B7HNChJWFdYHRY49Mn36a8Kx/EoTBBkW81pSx5PNSfj3NDgAGXCA+1ccKlbq+AojnYYjX9/VPDVc17Y44s/+f+Quv0DmnxQpJeOna
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(366004)(396003)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(8676002)(38100700002)(41300700001)(1076003)(2616005)(66946007)(478600001)(6666004)(6512007)(52116002)(6506007)(66476007)(2906002)(6486002)(4326008)(8936002)(6916009)(316002)(26005)(66556008)(7416002)(86362001)(5660300002)(83380400001)(38350700005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0Vfp+RrEt7uGbQLhMgzZ/rB4BqEyNOF5Xbi0VaLuRo5UPk8/fcFRr3xr2Qmh?=
 =?us-ascii?Q?vIYAtETSy0hjbgkNPGKYZGlWaeA36lTtlAgsbC5Rjv0BOCzxOWNHau9HMq1V?=
 =?us-ascii?Q?8uMxOsk4lhLf7cVMdNcWo8tV/0eAlHyJqExK1lq2AxKZouyVFpNBjKQauy7b?=
 =?us-ascii?Q?TlusmFXcUerVwgEmFIS7xdYmKDlp68dOLCTQ1GjW6XV5+7xnPdDnJdXtGdKI?=
 =?us-ascii?Q?nP599QLi87P3BgTaVp8K9D2gwlBhp5ilptH0Lh0IdG+tAYd6oH/Gj+DETKgw?=
 =?us-ascii?Q?7qEGYUUD4GkM5IEX8F3c3ZDOFOsvD0lQzehvpjFg3DlbQfzBxtu1Iox16kKc?=
 =?us-ascii?Q?LD8GMgdcdnB9N9QlpZbSCiCdyrFNfhfmsyrbv10gAVQrLFqJZFAnlgob/lf/?=
 =?us-ascii?Q?RLlwAcvTWV1cbyaWhyrkjO1uCKLu/N/WZATm4DXbd2d2H/XOp/y7yjlQe5vS?=
 =?us-ascii?Q?t3wxcAGQntM08fpQlSaUeaBuG23CzVn152SzIvU1hZLCXfRCcfYtwGhctz0v?=
 =?us-ascii?Q?Re5I6cZhEdcbh7OAWBusZwV0GbveqU/ARsbrUn8BVvq+Ddzcsagd71Huy8iL?=
 =?us-ascii?Q?pcAJxSyHiXY9qMMUWl/D3PVZ59n8fiNjyO6/czAcyvIzlmpAVT+arg1VDn6F?=
 =?us-ascii?Q?Ps00z6u296EL6hlySmJUlBO4j2KmtonlDxO5xGnvbmNZ8vZv40NCWxAjxYML?=
 =?us-ascii?Q?OGfuUC0VqHS3VDwbK4ojlDySQaAzS90o8DNc+Rc7wB5b6qNy5vxxSgNdXbCf?=
 =?us-ascii?Q?PXW4WV7/8L7N8GGuehGlEihTKr+1JyCKVHCHpkoFnC2rKHV8Uwdg6aafC79Z?=
 =?us-ascii?Q?d5dKYLprZafi9f9lKdN8yoFOF2f5B7DjK1qIAczHvQbOjCz2c2vtcGWXIUvl?=
 =?us-ascii?Q?RD4uqgD4bq1yETg6a97y4JXp1ga1HLhcJLxs8irCg6MD0iqWxVY6Lqf0JUL6?=
 =?us-ascii?Q?G2Z2sfiaS3+GqHKowrc1ViMc7lFm9R0rIhE8DkBRcKcjxnoEnt2eUwKEApyW?=
 =?us-ascii?Q?2uxh0vhu00TrTVpvLetrEyjfXHw+r9luYM0nGVmrSAhYVaJRx7pv1GxE4mAt?=
 =?us-ascii?Q?wHhlk5Z/DjfInGeHdRS82pc5YWV+ek1vsOoM2Ctl5lEqjU0gPX3YD8IUmjp/?=
 =?us-ascii?Q?tBs/mWlWU/4DPaz39W7EqKlPicYufrpWJBDHaYhAAJw/daUUG/YpLUjzPnwj?=
 =?us-ascii?Q?Rx99GcAigEXEnJvPfWd4groLPmbY0bEVZ0Un1jgngCnUsvxqDapZncj4KMkE?=
 =?us-ascii?Q?wnm82bkfFEJlBRMT+t7NJgdXM/45nTNJxxzucgvJPv2n7aknwYiHSN+rdvBk?=
 =?us-ascii?Q?to48AKo0VOL39zMjaknSkcX2XFG+NUzBjkW0BoswePeTH7Mtek2zNuPpgnZX?=
 =?us-ascii?Q?nFf1kYRUqd1cOCMV+v9DkwO4N/NE+rkt1GWg3SkeYhN0tMhnpGJmt7LHq5WB?=
 =?us-ascii?Q?uZ421Jl/NVykLGI7Uovxf5svN9AIM59keXsf/X3v3fBS1spn2LhXSxzlGcI7?=
 =?us-ascii?Q?vXmipgksAWda23bGJvWIMDtBQ+Bi42b018FVgzgF7RSWQbBu+yaioniQXT4R?=
 =?us-ascii?Q?BZKnsMON2lDluxlBCWqRu3wlRS1AlgTVYtetRutk?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbe7cd01-26b4-4fea-ab2d-08dc2670c69f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 17:34:59.1917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RVJndsaWrTXE0+jgYAGWCmamGuWriLC+E7Go0E2wePUuYA5r222x86ZhHGXR/jJXI7GPFDxtoxYoF2eWxVATrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7080

Add i.MX95 PCIe "fsl,imx95-pcie-ep" compatible string.
Add reg-name: "atu", "dbi2", "dma" and "app".

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v9 to v10
    - remove "pci-domain" part
    Change from v8 to v9
    - add rob's review tag
    Change from v3 to v8
    - none
    Change from v1 to v3
    - new patches at v3

 .../bindings/pci/fsl,imx6q-pcie-ep.yaml       | 46 +++++++++++++++----
 1 file changed, 38 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
index ee155ed5f1811..a06f75df8458a 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
@@ -22,14 +22,7 @@ properties:
       - fsl,imx8mm-pcie-ep
       - fsl,imx8mq-pcie-ep
       - fsl,imx8mp-pcie-ep
-
-  reg:
-    minItems: 2
-
-  reg-names:
-    items:
-      - const: dbi
-      - const: addr_space
+      - fsl,imx95-pcie-ep
 
   clocks:
     minItems: 3
@@ -62,11 +55,48 @@ required:
 allOf:
   - $ref: /schemas/pci/snps,dw-pcie-ep.yaml#
   - $ref: /schemas/pci/fsl,imx6q-pcie-common.yaml#
+  - if:
+      properties:
+        compatible:
+          enum:
+            - fsl,imx8mm-pcie-ep
+            - fsl,imx8mq-pcie-ep
+            - fsl,imx8mp-pcie-ep
+    then:
+      properties:
+        reg:
+          minItems: 2
+          maxItems: 2
+        reg-names:
+          items:
+            - const: dbi
+            - const: addr_space
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - fsl,imx95-pcie-ep
+    then:
+      properties:
+        reg:
+          minItems: 6
+          maxItems: 6
+        reg-names:
+          items:
+            - const: dbi
+            - const: atu
+            - const: dbi2
+            - const: app
+            - const: dma
+            - const: addr_space
+
   - if:
       properties:
         compatible:
           enum:
             - fsl,imx8mq-pcie-ep
+            - fsl,imx95-pcie-ep
     then:
       properties:
         clocks:
-- 
2.34.1


