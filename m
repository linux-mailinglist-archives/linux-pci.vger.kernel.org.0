Return-Path: <linux-pci+bounces-1312-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A813381D1FE
	for <lists+linux-pci@lfdr.de>; Sat, 23 Dec 2023 04:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16D7E1F22270
	for <lists+linux-pci@lfdr.de>; Sat, 23 Dec 2023 03:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19982ED9;
	Sat, 23 Dec 2023 03:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RaxqIynx"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2055.outbound.protection.outlook.com [40.107.20.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428586FB8;
	Sat, 23 Dec 2023 03:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VJEouVaW/3yZ2ZbtTnh4WRrDb8tLC3ABCxAlNWvd4UlWgv/SxNpyLLB0fGTnzpNFRJx6872Fot112glhyMILYh9lzJ75pMQthqYcfTV6emO8MVSg0ELAR4ZPdyHWJpq1CxkybFYyyyOaN9gpPm3JvIRM5KNxxgY3i6Yw6lk2SNaf9i7wqs2mjBtKvnsGwQJLhQpRxHNAWj3b6UFYt8P68RlbxzqqpgYMuHJcBBcT5t5XpX3PYTbx1vW6h1IEKEPcXmL+eZQe2oyi5j9JdjzTEjsRDAapEaXqxBB28ANGqKYAyUivHhP8AWXzADTlp/tqlFP1Pop4MIAvREgeTY6tfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZT/a5vZCrH+yEldwRsCXtlub15nn2nh/OlZCz//oCg8=;
 b=Vlg37X59z6bgbYZDVLrUmF9WzKkouEHZWbviIHW9oAZn9y2unMjlGIP55/Iyha7IH3UJ0s8mB33kYjem+IkHtwHVroz7Gl+s6ofc0bDHVmSSxvx7sxTCmou9Yaweu3Xq2XX9tjFSN9Ggd5j+ESE3Z0AminAiGU54LwSuYPwf7Jb0TO9dfAvM8kSjC/rB3Iioke9V7zGW0nInZv5j/e960k1KWPpW1DK493bmRYaVwf1JcoeQDU3UQpVAna8A7buPoqhZZ4u4Vj2fBPOIJT6r9fP2o9S+zfXm+iOQVuZcp2eoQLlCOpUvvptKdAOpe90b1m2kVumZ2L+Fwk6sTs/Rgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZT/a5vZCrH+yEldwRsCXtlub15nn2nh/OlZCz//oCg8=;
 b=RaxqIynxCrnRHNkuupB76/gIFRgB49sQVCVn1st4tYwr0Y1m/COFjiQCJ5pFaJ4RvfgC+dsC/rgKIYQl0JNLE1ioyo/DkBROR1Xhr5mdE7/t6qC6COp/GxpMQWgo1aPMzwk8PU/3EHCB7mOTP7pWr9N5mgVBJqzJMJBUWjNjDc8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM9PR04MB8164.eurprd04.prod.outlook.com (2603:10a6:20b:3ea::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.22; Sat, 23 Dec
 2023 03:46:38 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.019; Sat, 23 Dec 2023
 03:46:38 +0000
Date: Fri, 22 Dec 2023 22:46:29 -0500
From: Frank Li <Frank.li@nxp.com>
To: Rob Herring <robh@kernel.org>
Cc: manivannan.sadhasivam@linaro.org, bhelgaas@google.com,
	conor+dt@kernel.org, devicetree@vger.kernel.org, festevam@gmail.com,
	helgaas@kernel.org, hongxing.zhu@nxp.com, imx@lists.linux.dev,
	kernel@pengutronix.de, krzysztof.kozlowski+dt@linaro.org,
	krzysztof.kozlowski@linaro.org, kw@linux.com,
	l.stach@pengutronix.de, linux-arm-kernel@lists.infradead.org,
	linux-imx@nxp.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, lpieralisi@kernel.org,
	s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: Re: [PATCH v5 10/16] dt-bindings: imx6q-pcie: remove reg and reg-name
Message-ID: <ZYZYFYBr23OtTtrd@lizhi-Precision-Tower-5810>
References: <20231220213615.1561528-1-Frank.Li@nxp.com>
 <20231220213615.1561528-11-Frank.Li@nxp.com>
 <20231221225033.GA228866-robh@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221225033.GA228866-robh@kernel.org>
X-ClientProxiedBy: BY5PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::28) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM9PR04MB8164:EE_
X-MS-Office365-Filtering-Correlation-Id: 280edc93-9fcf-4f6e-c3e2-08dc0369c48d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RocFqHCi0pyWA2YTsI7GuR91aT9ZUYurfHjyCDWHYkL9jY5VDbpUAEdJq3i+7xYAlW0SWvbDfi4pPI8xqQvYuIDZ7j6Xi5INoewBHNRUyHBDkAK3xFxsb+lXCujZI4x8Li4KH/LiVSiZ/2sbJ5w5lp+ErZgx3tZYmt+E+O/kTzV4gC5mkymG1W9CJ3IntWlG2+9RkvKsd9FrG9vpMpiuHr3dTf/0U1Lk5IDxTH9fg6Omle2YBcd3dGJXgxHHMZguY96cVO3onDrlkA/eFUpl2KZxUCBJ4d762ZkeALYiNqANKvW2qjs50riF5E+phxLLgc8ZffIXcB7piOBZeRTA9t81a5epO+3jqMrL2j7byQW1TApxpIgR6Re8n0C36CUgK3uDZU6YTPHZKU5pfGaxZPn+w52hCMCkgxUvV/mAyub5FdPy85h48jvRvGyr+TqUdfHOCDWv93pDvDprpCvT10No0LZ3RPp0AQTAYYvKNMfCf9zUg1sypmfn94vIcZOqHpzlSawb5xHBfQwkIHX15r8gnhdnVJ6e4L5hDsa7PCBg2Giaja6ZdJ+laJF70L5o+IUds8VqaxaQZHxLcMB0WvmbV9hM/FgnAKpjtbYYanburex8ibLW/vLciWfypd6ajjDMQ0Oa6/4u/1Zabeus9A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(136003)(376002)(366004)(346002)(39860400002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(4326008)(83380400001)(33716001)(316002)(6486002)(478600001)(6916009)(66556008)(66476007)(66946007)(26005)(6666004)(6506007)(6512007)(9686003)(52116002)(8936002)(8676002)(41300700001)(2906002)(38350700005)(86362001)(5660300002)(38100700002)(7416002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iXMzy2150oXTCBPBkd71DeabY2gcawD2U2dhRLqLPLLYptmQiNBkMdDFfblp?=
 =?us-ascii?Q?8eunLG0obRPpuwuuveDZFLBjd1AGwnqiuHHC4e4rxLsDcBb5xt2flIDyA7x8?=
 =?us-ascii?Q?hOqQEfjF+61kE1RQGyeAMiiFvZRdaimeAKVHeInKkbBRG9mC4EnHc4YM5F91?=
 =?us-ascii?Q?Kaf88qa6ebxqb7ipMPVtKfr9U2cuA7efQK5lATkASU9zAMKdSOVUDqWpYF2E?=
 =?us-ascii?Q?7yVQebyJqCF9DRuxKEI1211s8TtL1B0w0zLQwWug0M7AWIPfDC/bD41eLRbu?=
 =?us-ascii?Q?E+WJGMOK+l9/8ObUIHsSpAe0ZjCJnnfTy0AF1B48I5NVBplS/MC0PRfdBpjg?=
 =?us-ascii?Q?nasCYDCBa3r96G3jDmGokCYIMDYIlV/v/o0XUwy6PKfKcBruXLoXP7ixyNUj?=
 =?us-ascii?Q?YN+oCVSWP3Tml7rS0dPsyamPXZ+Y3FuIbpgXH3WVWRsL1dPzeCCcMwJGbKne?=
 =?us-ascii?Q?OigbHeGj2Bp2ZdOjfR0by/rw5uEwXs9/XCvzDJ9s4yjIwFDhL4bzWm6mIjrU?=
 =?us-ascii?Q?DEI2DUWaVi/vIZzQBswr4I0g4fd/F+GqorylNvUwJ16PErNbXy7idx0yrt6Y?=
 =?us-ascii?Q?sHeRJh29oCObR8y57Qr0AP0bkJGxb4eM77v/5uYSfYTw2OexniBttfOP38ZD?=
 =?us-ascii?Q?dF7LtHqxjiq/NXQFSBUmIKNKl2b9W6kkNMtZCPtqPdGiH97wTRunkuSfuFv6?=
 =?us-ascii?Q?d7/OVTzeMSrfXXyF4DnR0lEq+BXyzCE9y0vUO+bSyz7YwLApYhoNEELvDbq2?=
 =?us-ascii?Q?hF02aW1u7+bNgtyyd1rn5CSlCIoYCXkpth2ro0PWU/5xR6Qty0jQ1Rqr1Vlj?=
 =?us-ascii?Q?arguyE3BKjIl/nLrnFFx/jE+nncUDZxjMGswHRicHPV5l1KLWNOqEyy/hJB6?=
 =?us-ascii?Q?usLpVbB4IR2vm1mtPJwKJK1IhTVZp6C01psbQTwzFGrsHeJxRgjmKPvbK760?=
 =?us-ascii?Q?N010g/0nIUHW3PNv8eljIWnroZw+Px3coiJJaEW+XK/ZD2CokZKsUgzbBFK3?=
 =?us-ascii?Q?pdt8VdDAa5EHoCq4IwHUi+djzFPXCpm/11vLA2N67vD6dk3W/DSxl/RYZIG3?=
 =?us-ascii?Q?nJ6eGOeTMjQ10DuQFPVTsbir/Qrb+dVSEbIidyp/0K3qIZ7dd3khMKGNBb+H?=
 =?us-ascii?Q?lw6tUjB8RjDQAXmXLWGEWNlmovqpaaaShrEfQXZ1xBKeXT5hW+0te0Qnk4qR?=
 =?us-ascii?Q?JObm4xbZd9C2SEcjC+LEBFCnF39nMlMAP5KIUzSi5PeVxuPZZ3c1UARo7TUd?=
 =?us-ascii?Q?eNBNXxGOJDpJaLuNuvzL4mJVq567m8ahm35e4aGVdYYixWwNyVPGZBGGy646?=
 =?us-ascii?Q?qZ+TR/4jwX34zXmppicJUlXOGmRSvAjV/jtpPofUhHDy3y6/K58YUPeGkVNp?=
 =?us-ascii?Q?NC8GqHN4m3v6Gk5cnTieooJOgE0b8xEP3G9EW7PzDWv1fBVEuE0wCk5x2J+/?=
 =?us-ascii?Q?fgNdhOzZ0jgHQTIozD5AE2q+8umyZ2c7qgblocNyT+nntSUDL+l1MYyqPhoO?=
 =?us-ascii?Q?RB5+QvVkpY4PVczmfGjU0rqCUcvpVDfSD4vruJu493urzuM0Hgz2fAz+b1Kc?=
 =?us-ascii?Q?f+fpCTR/AUC2dA/XLhE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 280edc93-9fcf-4f6e-c3e2-08dc0369c48d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2023 03:46:38.7585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vf0Z7BgXI+CuifQNBUs0W2lKG8mlw6ap9BiJ9PF20wcOF509DA+H4zOmJBxU1REZw5esZRR4qtdJZ5NqVK2T9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8164

On Thu, Dec 21, 2023 at 04:50:33PM -0600, Rob Herring wrote:
> On Wed, Dec 20, 2023 at 04:36:09PM -0500, Frank Li wrote:
> > snps,dw-pcie.yaml already have reg and reg-name information. Needn't
> > duplciate here.
> > 
> > Acked-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > 
> > Notes:
> >     Change from v4 to v5
> >     - add Rob's Acked
> 
> Err, that was intended for patch 9, not this one. This patch should be 
> dropped.

Sorry, will correct it.

Actually I want to move it under Allof

if compatiable string (A, B, C...)
then
	reg-names:
		-const: dbi
		-const: config

Differece SOC have difference reg-names required list. If split it, it
will be easy when add new SOC. Needn't change two place.

Let me update at next version.


> 
> >     Change from v1 to v4:
> >     - new patch at v4
> > 
> >  .../devicetree/bindings/pci/fsl,imx6q-pcie.yaml        | 10 ----------
> >  1 file changed, 10 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> > index 81bbb8728f0f9..f20d4f0e3cb6c 100644
> > --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> > +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> > @@ -30,16 +30,6 @@ properties:
> >        - fsl,imx8mm-pcie
> >        - fsl,imx8mp-pcie
> >  
> > -  reg:
> > -    items:
> > -      - description: Data Bus Interface (DBI) registers.
> > -      - description: PCIe configuration space region.
> > -
> > -  reg-names:
> > -    items:
> > -      - const: dbi
> > -      - const: config
> > -
> >    clocks:
> >      minItems: 3
> >      items:
> > -- 
> > 2.34.1
> > 

