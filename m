Return-Path: <linux-pci+bounces-1327-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 453E581D7DC
	for <lists+linux-pci@lfdr.de>; Sun, 24 Dec 2023 05:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F831282818
	for <lists+linux-pci@lfdr.de>; Sun, 24 Dec 2023 04:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B28A38;
	Sun, 24 Dec 2023 04:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pXz+eo58"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2088.outbound.protection.outlook.com [40.107.7.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969CC15C2;
	Sun, 24 Dec 2023 04:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IajbxSymr8lkMkCsW7j5kS0U6/il18g07KGVEIN+pHb8YNe1Hbn1oXlAX9ZA4iTtS2QTKlR8YTPz69X83dQH7VRn0ZzjxwOl19lcOudFynody0aMwUR1CUKZw16zAH56aeJsZU55twyABkP4uwqAKnafq+Nigzyj8tj6gouLvaoq9+PF5X3jnqdP5U25rQJ6Xm/CcfHfYIQi9LpEh9EE97tXx0i+a3z0f8o215oliDjAwVdb8R/r8mvP6njS6278mDTvFIuEeYu6OrCaa+CSnc5oWKNCwT9e6/2RVEZN9BExpjRoGeSJrpXj2g3P4c3I2OzTmnPZXw+09ei/FoeTQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EDb2C0dNn7gGf9TIfkCl/VuGOTqp9V8CVClT7pE7WME=;
 b=VLC3vhZAdAWmmpOiQy0iNLWtYOLAoyzZ9Tf/hmPqTe6/Ru/++sI6qVKBm5i/d9z4gWmrjEF8X9mLX4DlK6QAVgIctzQ/f/f7aL8MzUwZbAT9s7AqokO0T27q1JzuqbLwZoKTwAW/lFUy0Jbu7uW79vZSVmVMYHZuk1MYAXGFaAHTT+bkg8jzRTg5WQoFebECnR4J5taHQjEumNWV8K0QyYDbXCub5+FULLmKle1JeC5ewwRkwGdQP4eOUNdlkzzUGiX8QJnszHIzzJUmB6p9acHtyX3l3ew4v20/jK9rklK5i5tBJdUbRfUZIFRW6RlzYf4QBLUIxErubDuicRIZKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDb2C0dNn7gGf9TIfkCl/VuGOTqp9V8CVClT7pE7WME=;
 b=pXz+eo581PS287L0AKy43kZ9nNhuVkkOpwIT904bTcykm3VuEm34J7RgIUW5xjMS4YXYR4tGOoJuqzTs0rxF6qUZbNAfV8UyTFmvofhbogQFLq0EO3z7nh8OiJlom5GnsW1ShiHZ6+iuZehOziEKbsXinFmb6mb5Mm3Ozz67KxQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM7PR04MB6774.eurprd04.prod.outlook.com (2603:10a6:20b:104::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.24; Sun, 24 Dec
 2023 04:47:24 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.023; Sun, 24 Dec 2023
 04:47:24 +0000
Date: Sat, 23 Dec 2023 23:47:14 -0500
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: manivannan.sadhasivam@linaro.org, bhelgaas@google.com,
	conor+dt@kernel.org, devicetree@vger.kernel.org, festevam@gmail.com,
	helgaas@kernel.org, hongxing.zhu@nxp.com, imx@lists.linux.dev,
	kernel@pengutronix.de, krzysztof.kozlowski+dt@linaro.org,
	kw@linux.com, l.stach@pengutronix.de,
	linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	lpieralisi@kernel.org, robh@kernel.org, s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: Re: [PATCH v5 15/16] dt-bindings: imx6q-pcie: Add iMX95 pcie
 endpoint compatible string
Message-ID: <ZYe30jb7dxRxQ3hr@lizhi-Precision-Tower-5810>
References: <20231220213615.1561528-1-Frank.Li@nxp.com>
 <20231220213615.1561528-16-Frank.Li@nxp.com>
 <8fb359da-2d35-4cea-8a62-199fde1d9a29@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fb359da-2d35-4cea-8a62-199fde1d9a29@linaro.org>
X-ClientProxiedBy: BY5PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::27) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM7PR04MB6774:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b156127-1199-4a5d-c285-08dc043b6c45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MF4Iw5Hw9P3gYKFAeYUqNnXRuvdLI4r+P4iahX49pmJDNDmtp2Qj9gSX0BOF5BSLKTjuVMJiQUSi+Td3XvsDZkc0HKHduJLu0fNHbgkdsU39R0awxTHF+jtKGqcPxGbdduq6XKzgcZHe91sL+V3IvryHLiSjUmOe7A2FDDNGTyjjg1dbkJ3S1oLh+Cb/z+2DPDHbQOoUcki1Q69qbIWn7p0bYrbaQCycR9xrjCznf3FR1EXgsJg5EWAbQ6mMLvXf4EJXzKTFDwsH8s0bEp1CERhPZOyxUWjTlk3CP500FioIy+FvqWPFkELL71ecpSEXal7rjIBnggHNQ9X3Y4/UnBWveMdNZEcIIANt9qHXokgD85Cz96Rp8PVxk9LzA0uo7z3WClVmEnWDSYyBq99qO50a9xSaeroqZqF/oN3dVO7psDxNxAmR+ogCBaaVAgk1KI27+DdaJ2+WNMNA3lfgo7oBfKHDL5+t7hFFJ+1TJS4LNxv0YZpxZFpNjas/kZa2640lqr2ZicssdNDqMcz1uChXzN92sEedUlQzG0Hy6qmI3K+ifAtaISU7U2DcL646EEbd6ZPJMcJ4q/kkCSlVnpR7+IdBvP/dtDenYE3dpKXuFsmDktoDL7zZyfMg5v/t3uH2Ne5NY+XYy6COTWhMDA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(396003)(39850400004)(346002)(376002)(136003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(6666004)(6486002)(478600001)(2906002)(8936002)(5660300002)(7416002)(52116002)(6916009)(66946007)(66556008)(66476007)(8676002)(38350700005)(53546011)(4326008)(9686003)(6506007)(6512007)(316002)(83380400001)(86362001)(26005)(41300700001)(33716001)(38100700002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3xr9G7fJbtI6OG4TbHZ+uzYHE1CGzfSoWgY6wFAxHnS3hD+vNJIuV7EnbR8i?=
 =?us-ascii?Q?ze19JicI6EBd7bM5dJp4jE1TKwnjUG9U2beYS1eTAHzheKiKQ56mJG/0bGD9?=
 =?us-ascii?Q?wXtOwVJeauzCL9Rqu/EjctSbb97FuHTB3XQrFLyW/o45V/iT7mr6bclFC9Yg?=
 =?us-ascii?Q?Ei6liPZtr2IXdCBB5aHwp3VC8sST8qM7feJuFcIV6X3V+b1YOy1aX43InJae?=
 =?us-ascii?Q?g+iLJMPtG9f+cLWPbbFAv82MfVa/I0iEoAjeIGXoyqiCal6RGGhvCSB2Vtnt?=
 =?us-ascii?Q?fozmbpn50IKE9X38HIR8FlJWDVgzcqTJ4cvR1QdFij9CFmdoM2YKwXhT9F0q?=
 =?us-ascii?Q?9V8aiMFDjuy2exOrIK32szrjo/ec5lDvvS3C1cMqCTJ5V2GF/3FDrupTmlJa?=
 =?us-ascii?Q?MlLuBByRJDzUR5TPyokmr1SY4riB7IRYib3yIJG6iCUikSCfmVSUk7Kfxp9O?=
 =?us-ascii?Q?9tJyQ4+Z18Xmsfh6CAcrYj2cat4i1ayjTXy971dr/Wkk5CadZT5jYZ0+dwlS?=
 =?us-ascii?Q?ttikBsB1bbvQtaDh7Sr+7rw766xVn3J/9B8YD/v2nSBjiXA7KY+YwP6fAnum?=
 =?us-ascii?Q?ISm4q8f3oFXrXhaeeGZCbSLgQI963TB0YvpVuE8nLPVmAqDzTSfr8R4uGZGQ?=
 =?us-ascii?Q?OzRdVERWvLGlWojAN9uqMbZ5px6jrmc/WSQdj3t4wULcapnuFjHEUATyyqrb?=
 =?us-ascii?Q?jIr9W4yRORDlP+6w+YWz0GaS83NrS3kJBpP+/ypSD2HhNnDenSy4i3fmUgY4?=
 =?us-ascii?Q?Rs7yeMil9Wt6A0iDM0kVYCegNrgkhM+mvHFJteZSxh830lAc5Mnucou7ll9T?=
 =?us-ascii?Q?iHfg+TPL1GJloGIH5zAM99W4cURgJxWozz/0gnTzhuACKJqvdGUQnvRSKRKs?=
 =?us-ascii?Q?1LFcJjC8m0FIXpEYM+x8SFypGj1WT1xtOtlK6rrRCfvLgp0OTWIi914Jnmzl?=
 =?us-ascii?Q?92JfPKQOrcq0FRfnwoQFsi3ItVrJnlwES7yOMN5rfYh/bsKelBXpWf23c1Eh?=
 =?us-ascii?Q?/6AEj+woTEImHg6mnhddykMp1g6yIU9cgLVIBF/poLlvFGv3LGbSYL1ypKIP?=
 =?us-ascii?Q?VrMvGWnbEYuDdSpanQloDqgw6S7MAkakZbm6VU1MaK4+GGuzaLVGJy7avcm6?=
 =?us-ascii?Q?RZBqPX66ZhvrONJWAb2amQuwheIcVbx3QMwr8RwfuLXe6bYEtKLNi42hylq1?=
 =?us-ascii?Q?c2bCEBtn9EKhf58lGUXFLse1V84wH+mfxTf4pulZpukI23XgCF6PnCWGaJjg?=
 =?us-ascii?Q?QqeS2d/RWl1DnO5JtGtwZv3U17/qKXAD57WmIFVWKgDVLHREFWUetG9Hz2hf?=
 =?us-ascii?Q?RIFvFvPtiSMHZ0lYAgB8bO9u5h2WNzbGK6DFnw8oUSdrd8f7Hs0aoJHnr6Sw?=
 =?us-ascii?Q?xK4UsL46gAM60qgYBD8NSWHyN97W6RZ7qb3FCKBDuKzJykI+nNAmu7ffCVg+?=
 =?us-ascii?Q?Xt1mNc6Jw0RPpR590f8tfEaXAvFdirsHel0w/9k+U4ZvRCFOI/ovRTCG0OUu?=
 =?us-ascii?Q?FR4rX2fzsYDWzzcSF/zTdtqu0nI5CqU+XmujKtZ6+3H5h/v40iFB0MYr1OoB?=
 =?us-ascii?Q?TBGEE4N30lgyUtzeiFZaMzrQFhzKhb0loXpqgCkW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b156127-1199-4a5d-c285-08dc043b6c45
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2023 04:47:24.7890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VObbYEXpaC+UyLXBKd3rk1tuJIRNUOhmCYRNYvZ8S/fYIo0ga2/L/wC36UW13ZpukhTcvcaeCQy35L/x0RKaBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6774

On Sat, Dec 23, 2023 at 07:44:30PM +0100, Krzysztof Kozlowski wrote:
> On 20/12/2023 22:36, Frank Li wrote:
> > Add i.MX95 PCIe "fsl,imx95-pcie-ep" compatible string.
> > Add reg-name: "atu", "dbi2", "dma" and "serdes".
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > 
> > Notes:
> >     Change from v1 to v3
> >     - new patches at v3
> > 
> >  .../bindings/pci/fsl,imx6q-pcie-ep.yaml       | 52 ++++++++++++++++---
> >  1 file changed, 44 insertions(+), 8 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
> > index ee155ed5f1811..be9ea77ce8548 100644
> > --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
> > +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
> > @@ -22,14 +22,7 @@ properties:
> >        - fsl,imx8mm-pcie-ep
> >        - fsl,imx8mq-pcie-ep
> >        - fsl,imx8mp-pcie-ep
> > -
> > -  reg:
> > -    minItems: 2
> > -
> > -  reg-names:
> > -    items:
> > -      - const: dbi
> > -      - const: addr_space
> 
> No, why? Entries should be defined top-level. If you remove them here,
> where are they defined (in which schema)?

See: pci/snps,dw-pcie.yaml

> 
> 
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          enum:
> > +            - fsl,imx95-pcie-ep
> > +    then:
> > +      properties:
> > +        linux,pci-domain: true
> 
> Why? It is allowed already.

Sorry, I suppose it should be required. I will fix it.

> 
> 
> Best regards,
> Krzysztof
> 

