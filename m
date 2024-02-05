Return-Path: <linux-pci+bounces-3102-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2625C84A0F0
	for <lists+linux-pci@lfdr.de>; Mon,  5 Feb 2024 18:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1015283A08
	for <lists+linux-pci@lfdr.de>; Mon,  5 Feb 2024 17:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CCA44C82;
	Mon,  5 Feb 2024 17:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PSGAmS8p"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2058.outbound.protection.outlook.com [40.107.105.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117614CE17;
	Mon,  5 Feb 2024 17:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707154484; cv=fail; b=UiprrKcOXt/6f5my5yUa3hmMxDieoaC5LreWi6VVs8WR8isO8/mi51B5fYyDRqpARAaXPh0dV37kZUEh9+OHm6qKkRdWl6wPGJkSk6s8wM1W4Czk/CW6wp8O9fyQdFydy6y6BTc3VLXBU/ibAPHuwww4DRAPNy8NiZRanUBQGoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707154484; c=relaxed/simple;
	bh=ScTy0K4MQ+5/neKteBFZcAyY3Cy1DUs22TiBOkS+Rv8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mpk+9iabWh3TAhLUWG0uZ/B6rqvs4x8FNpOyiKy8A7/6+IUzSNeib6w57a9qpArHp09p9QM50LDgSXlYeNTu+4mklJ+SbvbhxMbl6uT83Te7xIeTovcTuGUODox6UV/mq+s2ENOjuRM7sFDIGxOtSV6IUYvzPVoNmfvl1ybHavc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=PSGAmS8p; arc=fail smtp.client-ip=40.107.105.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EtvCjfOjoCpSDPJ1gXIU0LuifBbqw9hTO8kIIK4K5hio0Q6L9rzAsQ1D287v24K1C5tVTeohJ9W/IjURpMi1tBK6tTUeJgjIycS2E49oybZLH23TP70S6xKz7lY4CbFGoouuM0Bc73k7oN1agzrZ45O4TPcoAvant56YUwa4eFvPkgWGi44RirPnBi7UfBWu1wsKHIxGB+TEgHBSpJj8aj22oJ3a7qXgXJWiE5Bm5jDe+KaydmHQmc9FNxwt6R171CujnrcQF0wrgSpq2/TbU4fzaAABGYvK9TSBLOKQPL5vDVAHm1+35NFZX6J+xB2x+vSpoXGvs+ILnrcSq0JyiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FVX7YF2nnMsn4TCg5IFrEsxcSGDvsICvYhMpzGmBmJU=;
 b=hdwHJmoqqs0Z36DZSMG7yGAJ0T6+d4if/Kp3S8pABn9ex6AZGs4Mdpo0jVJhz1W3uLlE+2GVXXnx+MC1+zXSXFFGBNwG8uUy/sN8pFBnSfwR76oTaf180BctFBllc29YrXqydIVTikNd3axnZUDIDJbZywP27hMKnZ5hrhsWI1VDXiyBtNf55qH02GgIX/+7yDmHzIK29ijxiP1EgT5Q+yVrIvQej7U1Oy8tEwsNQNICTEzuFyAO5jK74yA9o1KMSLertgvKwzCUEkr/D8eDP+Dakoldw61kvgjIVLS2k5w2hVMaiZWapr3QeHM5VVUiSDi4gO5U01lBs0XkpSkdDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FVX7YF2nnMsn4TCg5IFrEsxcSGDvsICvYhMpzGmBmJU=;
 b=PSGAmS8pIWPfmcy5/v31x7N4lpjWO6G8FSYkZQaHHgSA5COZ3hb1FwqZVa2JlIl4giGLZhCxyptaZSeELepahwkDVHaKNw1MRInsVOsKvfTIgBwkz3Es2gs6khAmnILfI7NpgiQs3SACbQOwJMHZ6hIZ0XZ+HGFyPVbdfZ/VTrg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7733.eurprd04.prod.outlook.com (2603:10a6:20b:288::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 17:34:39 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 17:34:39 +0000
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
Subject: [PATCH v10 09/14] dt-bindings: imx6q-pcie: Add imx95 pcie compatible string
Date: Mon,  5 Feb 2024 12:33:30 -0500
Message-Id: <20240205173335.1120469-10-Frank.Li@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7733:EE_
X-MS-Office365-Filtering-Correlation-Id: 99c7b619-183a-43c3-76b1-08dc2670badf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DO8bclSyb7aQalDUzUn0Juys025mJUe5QY2Ljp1pxoXp3nubsea2yvpzWxsmqWkKvd/fItzxGt2hOLLv7nhpWkfV+5u8EXr77gNiRmf6LNyDPNIO6anRZLmXrUqlI5/VfhDKe0ttVXDY+GDX9LjK45UhPOLN37HKVNG/5bgd2Jyiwe1w1BiBDWO+fMglOr4H7w6EMmbQAcNri94cY32CWkhjz38y8b9LfYaF1XhtIEBPUMu2uUzEjclso52XEWDCdwb5BXB8bp3YW0soMIDAKs2KOtTokerDVuc5ygVLLH96N5oFYtSAE3vkSGWpdUKfXf/J+pTYiuZuKLctOjW8yhoOBUiNy4jKebaN3rlOKiJ5Ymcv/Iz7Bsyv+dJvPspiCk7rI78I1EBRKLeY7u1ap2HP351htNKuGz0UuXF8gkpLihkgtgeMTPBpsFPe/knq/kIajbWDrblSSveZiBtCxf4CFJJYTeYwK3TOO1cv08LUM4uX504mKdg8N+WrH/M1xqWHhC+sZjCBFdbjmgb4kvlG3hQ9qHqLN6dtQdrLNBZ28rJOXNpVPNh760MXr0aNp9z03nTOLFUSaWKrkmXJLqPsFD0Rnz7UNTs3FO+9aJOdB28K0+8JJNJR68ZXEiGM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(39860400002)(346002)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(38100700002)(41300700001)(66556008)(66946007)(6666004)(1076003)(478600001)(6486002)(6512007)(52116002)(6506007)(2616005)(2906002)(26005)(4326008)(8676002)(6916009)(316002)(8936002)(86362001)(7416002)(66476007)(5660300002)(83380400001)(36756003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WFlBlEx/65XoxJDNKnsvCrsPmTfSLaoNOIzN741CGuSKYA3agU2XZeHahMIZ?=
 =?us-ascii?Q?ybixf1h8eF72OSuKdPOvd521/1CH9mzLRyCxWdn6Q1RK5/sVvb2VPHSFrG1a?=
 =?us-ascii?Q?D8fUxG21dAns8tau8Fx+vz4olhTYGdSSaNeno7KIgHuzrcYmemwrrm7v5KDj?=
 =?us-ascii?Q?j/RFLV0ThGoATp9fiFqEZrfz4CAsOF17gTwr7RytGxvuwfYwT90OiqtWA7y9?=
 =?us-ascii?Q?V7FChdWqsDsVg1UDtQm+7h5G9qhkOi6KTbbj2Lbrla4reagDc8vyVNjhjRyT?=
 =?us-ascii?Q?pVRQQTcc9u0IArT8Vil7jsvi1EJNc4vpZ/zwVZkHEGwfaMRdZ+Li4ff9z/7w?=
 =?us-ascii?Q?HKWs2ZDa0K4tlWXO9aJBMXZAQyO0/844WOUzqc3003sWvwNoz5kbH7Hk8i+L?=
 =?us-ascii?Q?thhLcIuZ+NTQU9xeRXGq4oVjDYPhIuwMc/ZfhoWnlJuM2tDzFKY1962DN6HQ?=
 =?us-ascii?Q?2h6piIBLh4TluRrg0vAGsb6XF0Mc0hYrRH5WGc6gGWwCMmVlD7s+Ric+Skc+?=
 =?us-ascii?Q?uPyI7i7sqz13cJgM+/AXSjFQB/KlRwhyaRMZ87NyTV7zaFKDqeZHWiXM88E3?=
 =?us-ascii?Q?P/NH6/F6SktjIjkIZrU1tuXW0kekivhKM3/gV2wvySJsgICaLIPB9E70Hb9F?=
 =?us-ascii?Q?BoM6GS9b9f34C9qBMsSY+IzmJUdeejKKjM4aNug+7g+7vBJtFtEVn6JAJ8t2?=
 =?us-ascii?Q?fqb37g6c7plkLgO9JW3L/bXmmjxwa9vjhCv6KFwU2FMHeed10BPkLUePJun9?=
 =?us-ascii?Q?2BPwmtB4s51xfHerj8xOJ7j4Ipx8rqXwKaDOEKG+EWsLF+yZrhC9KsqjEbbe?=
 =?us-ascii?Q?T6p0rFXa9KFel/tkLr9isPYWB5bzmwCXmW8anwfvxIfjXMFduHdgQKsMxyw9?=
 =?us-ascii?Q?D4ZBJDCtDQ3EMx2ypNBDQbjI3Jm/7K8QZWs9qFilwayGXesGQDIQGZvng1lM?=
 =?us-ascii?Q?CSaK6YuVwIhkGMO1wWvJG/HK5uW9BLt6cAMHoQlglj+ECXhZFuqZ+zS+ejVI?=
 =?us-ascii?Q?0cvU9yTXjBzUaqlASaAoj9iOoRTZF6ASqzmTA4lLiqwmubp9EF3mn2RzaLhz?=
 =?us-ascii?Q?KQ3qM0gf63KBb7rKsu1C2p+gmGClPoSDHcb/BmryrC4YDTqm3T+iW0AF9XWZ?=
 =?us-ascii?Q?mhf6SuQgieVAXU6XesrvHwvMo54eDXrKKp/lumCvfQ/Kv+GDEyw/DOU6e4tS?=
 =?us-ascii?Q?Q6u7lPgdvpdka+vKfAC6Cg0fIjRBVCeBXZq5bOYUncat59X4HJNY0T0uy1l9?=
 =?us-ascii?Q?XMAe19D4H7/Y8vzxQCN4Qq49oyUW53DC4Nz97GkObrZZjMoCIpre3aGqDwyH?=
 =?us-ascii?Q?jB0CiGEGONA+t+L9ZMeU7GYhwuKXChmk6iJwt3KjkAnAL+52ZfjleQ7cHVXI?=
 =?us-ascii?Q?RSBz/0Q/IxRavIboKWLlyCinGlPOqGHm9292CuARgIU2qxPoWucOAeJQAMhr?=
 =?us-ascii?Q?IfotFXYpqcEufAJd1OeVSBaUUQqP00LkjrbqJHaI7eRC7GcRXSdl9G4OCy6e?=
 =?us-ascii?Q?so5hfBMIn04h6UC6oMEf+QtFZCmSdmg4OnIS4JHncXY2652mvwMx4Fmza8UM?=
 =?us-ascii?Q?o7h4ZUDuCjABK3Es7L1x/KgepHQJ4/t2TSxnp+2x?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99c7b619-183a-43c3-76b1-08dc2670badf
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 17:34:39.4607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rCR6qpGaLU3e2sSr6UN9jDCMa/j90l81n07H4UlERDPbqT/6tdaV/FSnnrDqgt/G55Zd8cHsKipH5SSdavtQEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7733

From: Richard Zhu <hongxing.zhu@nxp.com>

Add i.MX95 PCIe "fsl,imx95-pcie" compatible string.
Add "atu" and "app" to reg-names.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v8 to v9
    - Added rob's review tag
    Change from v7 to v8
    -none
    Change from v6 to v7
    - Added my sign off
    
    Change from v5 to v6
    - move atu and app after config
    
    Change from v2 to v3
    - Remove krzy's ACK tag
    - Add condition check for imx95, which required more reg-names then old
    platform, so need Krzy review again,
    
    Change from v1 to v2
    - add Krzy's ACK tag

 .../bindings/pci/fsl,imx6q-pcie-common.yaml   |  1 +
 .../bindings/pci/fsl,imx6q-pcie.yaml          | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
index 0c50487a3866d..a8b34f58f8f49 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
@@ -207,6 +207,7 @@ allOf:
                 - fsl,imx6sx-pcie
                 - fsl,imx6q-pcie
                 - fsl,imx6qp-pcie
+                - fsl,imx95-pcie
                 - fsl,imx6sx-pcie-ep
                 - fsl,imx6q-pcie-ep
                 - fsl,imx6qp-pcie-ep
diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
index eeca6b7b540f9..8b8d77b1154b5 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
@@ -29,6 +29,7 @@ properties:
       - fsl,imx8mq-pcie
       - fsl,imx8mm-pcie
       - fsl,imx8mp-pcie
+      - fsl,imx95-pcie
 
   clocks:
     minItems: 3
@@ -100,6 +101,23 @@ allOf:
             - const: dbi
             - const: config
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - fsl,imx95-pcie
+    then:
+      properties:
+        reg:
+          minItems: 4
+          maxItems: 4
+        reg-names:
+          items:
+            - const: dbi
+            - const: config
+            - const: atu
+            - const: app
+
   - if:
       properties:
         compatible:
@@ -121,6 +139,7 @@ allOf:
         compatible:
           enum:
             - fsl,imx8mq-pcie
+            - fsl,imx95-pcie
     then:
       properties:
         clocks:
-- 
2.34.1


