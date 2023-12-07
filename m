Return-Path: <linux-pci+bounces-632-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A096B809184
	for <lists+linux-pci@lfdr.de>; Thu,  7 Dec 2023 20:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30865B20D0D
	for <lists+linux-pci@lfdr.de>; Thu,  7 Dec 2023 19:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032A94F88D;
	Thu,  7 Dec 2023 19:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZTnXADX/"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2054.outbound.protection.outlook.com [40.107.104.54])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1135D10E3;
	Thu,  7 Dec 2023 11:35:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bca5vfpsY0vogu10hNFyuK20NNLIzDZWlDbU/VsTtCNnBhRABeeUUJfZoBoMQcMzxDi3LrcnQ0ebTfwl+K8D/scniEZsmAWP6lnrsHYWrj5TO3DEajAew8SwyQagam87PEgLVOzjVQ6Cco9CdehSRI1V7VNjdC9xChFsOj2R5sfXo9ivQ/wbkFshDYWXWM4Dt9OSusT8oHHsHmkojdtWyaLPMez+/q4Oj5MCREF1FoaVf9p7Ckh6RNZeM9sNsp8HpqDO8sKoMzw4YKR2UWe9dNaAjzWuYTEo2sbLc2Sqp5eAoi9qv9wZa9NNHnUAR4qiizhNx6BJYCg9Q6LOk219Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ISoeuM5qc9C6CwkUoT+MeGLOPLvC3YYCBpts0PS+AF0=;
 b=gvA/oL9Jm/nNAQhP44wAfX5OId0sUWj/VkSdkcRj8/49kzLnwlsIV/2vXiiWdbAKghNMAZb1XzqlMySdNFQAlB1BUzB4iedBfo4R6idbsEb6eu86ZeCAWlKx3D/TR4OsfhMpQWRY/D+tVcsq9cfjVZmaKd2aWVenPWCIw73lkA8CRQZCrvV7Nz2AOw8liLc3tCGdq7fy1mip/KdjwRM1YwXaV4yNR10eeoXhNoU9aDjnIv0cWs3Ofs8E+GGNzsJ5dKvOIMbw1xO/sRa9BYwUjqIvl84JX01UEhovmI7trB0zLBbGbkO77S77VBRiJFhDTh9OsCQYpkuVCxsitqW/Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ISoeuM5qc9C6CwkUoT+MeGLOPLvC3YYCBpts0PS+AF0=;
 b=ZTnXADX/DrHcXkCMZUqLC5HuvcfMFHfweBxfRk43g99y0s3I/OiXL+z/2njdeFOfEupOibG+SKenovsyOFnWozfhTLKGsR6WmBX6Nsk8hqhKUXgZoTqFEn2UN4wD32iBMsocH2reW1ZJa7EV/5Ncc0Y9Xyhh0biDaXyzMoJtWNg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DU0PR04MB9635.eurprd04.prod.outlook.com (2603:10a6:10:31f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 19:35:33 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%6]) with mapi id 15.20.7068.026; Thu, 7 Dec 2023
 19:35:33 +0000
From: Frank Li <Frank.Li@nxp.com>
To: helgaas@kernel.org,
	manivannan.sadhasivam@linaro.org
Cc: Frank.li@nxp.com,
	bhelgaas@google.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	festevam@gmail.com,
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
	robh@kernel.org,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: [PATCH v2 8/9] dt-bindings: imx6q-pcie: Add imx95 pcie compatible string
Date: Thu,  7 Dec 2023 14:34:29 -0500
Message-Id: <20231207193430.431994-9-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231207193430.431994-1-Frank.Li@nxp.com>
References: <20231207193430.431994-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0348.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::23) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DU0PR04MB9635:EE_
X-MS-Office365-Filtering-Correlation-Id: 384ca9bc-840f-4028-3b60-08dbf75bad62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/uv7rhXhyXYwgxiEd5QejdvrWjJXK8K0rirFRHzYr8Zibk9tQh37hbOQkY1hktPwvxHd8tObDZJz6WQA872EI4AKNotXPJNQniXDRXXSfRCeEkXsaD+w3QnXvrD4QvZeeIyCiJdYMPD8Au7cKdgTgpbqYerZW9ufGh7fjYOjoTmRzFR9FaAJsgIC9DVv33NoCvlsKxmLJ/ZhCYGcFKc22nQ1vaf2E3uGS2xjlTVZT4RheeEKk7irQBGvP3TQTebdXKskqDR+uTQ2BxIeSezdQ/JNWXiwnkyK9jp8vWbX4rtkh/8vjAttOMumkzwQUPKS+C2oX3NwFGdUfH+9U1IncPKiPVD2ZKD9NwO29wuDkW1umVXNe06y++OnJhgmpxZ/r3NMZoE6iyEC6esS6CHgixx5Z3/6grCEK/MrhiLHglxkrpaRH3k2xNHGX1gtmzqs3IECL1WwcLD4KOYlMHxLwUu2eHpbGVDbCihe4XStmFYcNiWSRLJMn2WAKXiNCO1LHDRQchWLj7VTXKFxTe8Va4o9axGpadmusnJBOwE4zVR41jZGv9jGhNU0Bn3TWWMudkqkjOsucfmn2qK9twiUq83fSl5MSC76Ijd3R1YlTbsgXvdhdGU4x9Mjf5iFDPF2M+ANZrxNo5Ejy5mAre3faw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(136003)(39860400002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(52116002)(6512007)(38100700002)(66556008)(66476007)(66946007)(316002)(6666004)(6486002)(1076003)(2616005)(26005)(6506007)(478600001)(8936002)(8676002)(4326008)(4744005)(2906002)(7416002)(5660300002)(86362001)(41300700001)(36756003)(38350700005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v2xmZDUcgMaKTpXh0S1H7Ly9kY2lkCHNQ2Vw9IfNQGUogLRV/Jqf8GqULIps?=
 =?us-ascii?Q?NyLynd2YS0C7zKgPV2R/ruN5hwd3eigVxeMxl7AtlikY0IKg7cljfSI9xl1g?=
 =?us-ascii?Q?rnWkjigZ/tdZPAqN7E4/Sr0Jy9h7kwrnb79JMbTqODyu4z0Kq9V7CTiR1H4C?=
 =?us-ascii?Q?OiCbMEoV/Q98Kh1ZVvmJK6XuBExBT7RaRVPf3J8qT4OC27kpGVlmtYy3NLNY?=
 =?us-ascii?Q?tTNGqUiphBcmgfmGKefD0DxRbeaCDrgD/Q8VAa/lT69CrT4735zgbFQnjkaf?=
 =?us-ascii?Q?u19zusqbSWJeju2dU/cdpBKcnloevzvZ8WODxiX2pYOKXucWsZro+DDm7Q7N?=
 =?us-ascii?Q?KJ300uLaDO5cw9rPgZ0T4f765zWHNXDEWwue+Vo0RDWwKoCuQ19uy9xa3ETg?=
 =?us-ascii?Q?JEIzIjT0PYwO3YbbJIS7DepXxrqgVHdq55gnMPVeVri8tFkT1fmIq2SPNCUO?=
 =?us-ascii?Q?e7m7lMUms5s+cdoPFZ1k9Nlsf/3dCIA4YxxeuPAsnWd+1I/ptISdxy5/GwJ6?=
 =?us-ascii?Q?T4e5Gx3kKNLRxkALuzJo6zWxUQPETX5G8reJknQ8aW1aKxP4nILYi9/JDu4h?=
 =?us-ascii?Q?gBtDjpb88/R++HB12hkyZrsCu0T4/g+X+/WeEa0IpzY1WYFosp9iqmhf7/vR?=
 =?us-ascii?Q?80Y4KiOjMmJiY+fejNdKzkkzlNKm90BD9/SLQDHNVJQugDpwVOfw0SdoQF+D?=
 =?us-ascii?Q?V1OPgMRa2V32H3w8NWqCyL2nGMG+bcoR2lGwhnEzWzNpiDJPWpI9hbftEuD4?=
 =?us-ascii?Q?ij8GOFTuUB8AkK8xeU35xWqLe2hHf6HAbRk4ZIkoBhkjDkCa2vCFPQLqTd4y?=
 =?us-ascii?Q?mrfUDOfzBmxLQjf2DpdXqAZLSa+vkDbdf48HENfMmt2zRlbIM7eJoi8+5msu?=
 =?us-ascii?Q?bKb87+S9c0KWhK3O3Xk/Ss5pp8UDZvxxSw2Ha2DWRa9au6Ndk96pnDKB/1p8?=
 =?us-ascii?Q?gZsxKuRYW6NePjj7ylLjU2/byacEu5msnLbEStkDsgX63wzEmo1MHjKsd2Ff?=
 =?us-ascii?Q?eXHGOem/Mf1MWJ6IXjc9WK8lz7m8rglj52PBKZnxqW9Ntb6bXJrZd5mnWG6n?=
 =?us-ascii?Q?p+8D/bXBoEoxokWwaWL1ACGqWRV3iT3T8pSjBAOw80xs8v8U58wjDHp26Sfu?=
 =?us-ascii?Q?qFT01p9vuxZT7/xvNBJLBRL9wjqdTb58FpfUn6kriEr2cCdj+TaS0XVJF05E?=
 =?us-ascii?Q?QnsLuP4jDIDT23HOjCYtyyWNizkG/HVa5A3D12PCD6Evxb2bIfjgiLT4cweJ?=
 =?us-ascii?Q?apOnp1Ydj9Ka7Mn7TsrEe00EFwlCvigdlZJEg9N+Ltn3Y4jEb/oV2jROt3Ei?=
 =?us-ascii?Q?8uQhvuRnv5b7luXFMS123xmnYjG2eoTOl028pFMiZtyrnXZcc/neioy9Fg8z?=
 =?us-ascii?Q?xh/nVLY/4othyCwEbxvEB6uLNAoz33Ho/1yhLe9ymwwHPTmP/8ZhRxA0H1TD?=
 =?us-ascii?Q?NmcGpv/PPhWL6g2Rvaboq2JKyN/2l5QWj6CfvYzXJ/c1IYH8cyougfXSReGh?=
 =?us-ascii?Q?DhvTaFM4OaZfYkxuCW10EojJBS5j5Z5yYDhnbp7g8GpuesZ5wJ3HJ8lvn23Y?=
 =?us-ascii?Q?+bFrs+Hlg5rF+dtt43Y=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 384ca9bc-840f-4028-3b60-08dbf75bad62
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 19:35:32.9215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZCSpRMYOmxiciyYwFgHVFvg9tUs9P3kCy+ldi9cnMTqofbljQT3m1m+gz6s5l47XMfpBv6YtOrrHGSyrNF5dtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9635

From: Richard Zhu <hongxing.zhu@nxp.com>

Add i.MX95 PCIe "fsl,imx95-pcie" compatible string.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---

Notes:
    Change from v1 to v2
    - add Krzy's ACK tag

 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
index 81bbb8728f0f9..7233357678431 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
@@ -29,6 +29,7 @@ properties:
       - fsl,imx8mq-pcie
       - fsl,imx8mm-pcie
       - fsl,imx8mp-pcie
+      - fsl,imx95-pcie
 
   reg:
     items:
-- 
2.34.1


