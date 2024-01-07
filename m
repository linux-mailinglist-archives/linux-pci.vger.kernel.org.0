Return-Path: <linux-pci+bounces-1756-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F34782630C
	for <lists+linux-pci@lfdr.de>; Sun,  7 Jan 2024 06:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDBE31F22002
	for <lists+linux-pci@lfdr.de>; Sun,  7 Jan 2024 05:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA20F125A8;
	Sun,  7 Jan 2024 05:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Aq3aZvrL"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2082.outbound.protection.outlook.com [40.107.6.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EF8125A1;
	Sun,  7 Jan 2024 05:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DwjXm6vUjz0OvmzTFzdp0Iax5ONM7eQ3V0k/UVpyDXUE9Vw+0XPyIFwxIXt/lKR/1eyzoOtavOgXDmGyev9+sV82bGo9wZJPOYztX1sYzVK7LrlKStIgJAQrIrhVtonRk6GstffDq5lMy4FeJAJTc/mdC4s3dVbysfyWZpvtfBuHW+sH2A2JOimFlWkt2Ks/VlRsjrkpxhNKGh2/9jSn7R25yVxNQPp1xZXJN2KTy+hGD3b0gC9kXVMsSCSrhfPnEz3xKTodv0E1EZHdR8BI57xREb3P7xNB1Kv4nDDzcjPADkxTLfnJipGPq2v4RPDRoXPeM/m6t8lpdkuLaLc8yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zb7x7/gu/8kUxLZDhgtyr6ad8jt4crqwb3mbpZYlN2g=;
 b=nmWoIlgBMs39srwk1qJNYtw3IY8chLfG5Tv4Aj/jURKVe7JbCM6sEhsLK0zyVlmFVBAxe4z/os+oHfhg5NFH7/Awx3dew0f647TSrXRccwM2eo4sVHmft2IezZQZ8m5hTVAC0a1Pjauvh6ytmivCiZoIhBUHuWAjUYbEdSR3EKteseDzLdGGG+wGnT6v84EFTRr0oWwRJRFFfh6arJuz4y9BFYMBXvj/CkS06l/XFgvtsQ0XCdRniYSYG/5GXqnhDw1qEXPdfS1XqnxLAyPjeK4hKgdfs4qiKDhSv6fvSuff22DnPvIXkA11s3UKzF+x6QUhBPx6jPVwM5fL5xqVrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zb7x7/gu/8kUxLZDhgtyr6ad8jt4crqwb3mbpZYlN2g=;
 b=Aq3aZvrLPabF0T+F0CmQwupbQp34oP4uNcmG/m6DMBVMJlP6UK5X7sNf67a5Gzb2Vel0UGqQswuMzphNYghiRfxqePGIUwi1pjSBpK6jXBgbwUm397xZfVAd/Di5bOT1vSql067i+Ygn98o0wu7v4U0/qe+OR4Ik4oaCSDF+Jq0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com (2603:10a6:20b:23f::5)
 by AM8PR04MB8033.eurprd04.prod.outlook.com (2603:10a6:20b:234::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Sun, 7 Jan
 2024 05:38:20 +0000
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469]) by AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469%4]) with mapi id 15.20.7159.020; Sun, 7 Jan 2024
 05:38:20 +0000
Date: Sun, 7 Jan 2024 00:38:10 -0500
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: krzysztof.kozlowski@linaro.org, bhelgaas@google.com,
	conor+dt@kernel.org, devicetree@vger.kernel.org, festevam@gmail.com,
	helgaas@kernel.org, hongxing.zhu@nxp.com, imx@lists.linux.dev,
	kernel@pengutronix.de, krzysztof.kozlowski+dt@linaro.org,
	kw@linux.com, l.stach@pengutronix.de,
	linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	lpieralisi@kernel.org, robh@kernel.org, s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: Re: [PATCH v7 04/16] dt-bindings: imx6q-pcie: Add linux,pci-domain
 as required for iMX8MQ
Message-ID: <ZZo4wkHf4RE2O9UN@lizhi-Precision-Tower-5810>
References: <20231227182727.1747435-1-Frank.Li@nxp.com>
 <20231227182727.1747435-5-Frank.Li@nxp.com>
 <20240107031506.GC3416@thinkpad>
 <ZZos6LDk4NTfQHyU@lizhi-Precision-Tower-5810>
 <20240107051917.GG3416@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240107051917.GG3416@thinkpad>
X-ClientProxiedBy: SJ0PR03CA0361.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::6) To AS8PR04MB7511.eurprd04.prod.outlook.com
 (2603:10a6:20b:23f::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB7511:EE_|AM8PR04MB8033:EE_
X-MS-Office365-Filtering-Correlation-Id: e958b3d1-b204-450d-c9f3-08dc0f42db39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7aG7BzaT8onSl8AMuybMhiNedhvy8XrtI3PrGJH3omXY+fV+wUrymGSETV7b2L3+gks1YfP1hyzDpPMv4xnUp2dolrzNxmrpP0tCAg+PtDCtQ+9nx/7LihRB3MjsLD7+01+5IIQq7zCrZjd1+p9s9t0/4E8xZZw5jAjQQ4NOkQ0IcjYh5Zl3IruLFZHike16Z2joRVnITva+ilFCNM9GXMDw5untvM0ldpIqFpjdb7gqikaSyk8YYuke4P5bs3CMqkMs1CnAQIf1nBjh/9c/bxnzEORuKi+U9kMZfv/tHL7hZ7gYuIlVruDWB6G/J0alXwU5zHZ1R4yr3yk0sQB8iVysLl+4FuIWKneDXaYDTWh9oKL/dHbBtiMIgFNLwAx50qFpKYpybT3bqHORvG4GWvhxvTbA2xWdkY+vH9RKkae5TCS5RyQ6kNdLij6iJBAkvJQvdK+26/o6nw9MAqvA0rvbY4+48hX39hHhjbYXb86n/5GP32GAYPNvNxt74qFz4Se/2y/TrfZRn4nFsxynAvmdK27pQnoshO/jbjT/WeYuRNKVo3uh+eD000G+zBVUiy7pMbKb7Xti6DCXf+gC0O6nkrUPawHsZL4v3D1n7X+i9OTFQWA3h/ozROxveBF9F2XUizZIsiakUiH2XucHbsVPvpoyN0wWt3IHMeqFYbbh2xH6HNw0X9oZ7n/vOFlO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB7511.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(396003)(39860400002)(376002)(346002)(136003)(230173577357003)(230273577357003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(52116002)(6506007)(6512007)(9686003)(83380400001)(26005)(41300700001)(33716001)(6486002)(86362001)(4326008)(316002)(8676002)(8936002)(7416002)(5660300002)(2906002)(66946007)(66556008)(6916009)(66476007)(38350700005)(6666004)(478600001)(38100700002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ck54a3lQbkozMjlJL1g3M1pvWEl6N3V6UmdCYWhzRUp5K1NIdGk0cU5QRjhq?=
 =?utf-8?B?WEVRUHRMK2RlUzhSSndUR0RlbDZqTCtCWGxZdnI2UVY2U2lzekYxQ3YyUXh1?=
 =?utf-8?B?cWJ3N29EdmZPTHhFLzJsNU9UMDlWL1RSMmtkYmxpZy9CaUhZQ2p3NVovVlpH?=
 =?utf-8?B?bGxReWVQNVpOV25FeGVITkczZ1haRkZocFZidTZCME1tR29YQ05qOEx3d3No?=
 =?utf-8?B?OVlSVFZtUXFSdjB2cVZlamJpdUFBRHVzVnQ3VityVlFyQ2pjRWVUdWRPd05S?=
 =?utf-8?B?bzJMbDY1Y21tdmhmNlZ5VTErSGptQjNVTTFaOU0vaUREUFdqT3Z6Nit1bW9r?=
 =?utf-8?B?ZFpHdE44Y2dyU3Z1RlNCWnJNMHNYQ0tGR3JHQ0lCRlh3bXJuMUx3SlIrN2NM?=
 =?utf-8?B?SG1xNzhHQ2tycGFJN0wwRHFjSGN3YzR6WUJ2VU13T013Q3B5Qy9MSllJMndZ?=
 =?utf-8?B?ZDFkOHFuU01EK1o4bFRXUXRqWnNvY0pxQ29EeHMvMUNWV3YyZHE2a1UxeE5P?=
 =?utf-8?B?NWtTV3poK0RrUkdxa1ZqWVlBbGZQamhaSzU4bHVFMk8wamw3Nk13UTRjUXhq?=
 =?utf-8?B?YkF6b3NDak5BZkJHQk5uSHJaUlZNSUJ4Ry9CalhNeU1IU2lZTVFoMDBZZUZZ?=
 =?utf-8?B?RHFUaUdrSUpGOVZ6VzJvRjJQa2dmRTFjcjFrWFQzWHJFdnloSmNYbEkwaVl2?=
 =?utf-8?B?VEpwU0NXMjNoc3luc1ljM2g3cUhzU1FPNGlKbVh0cjkxUmo3cHBSWkRVNk9l?=
 =?utf-8?B?QVVCeDlQZEp0MWl1MW5hcmhHUXltNXN3YStvK1FsYkhJUzdWU1VWWkNhQi9D?=
 =?utf-8?B?b09odWZKVStGR1VWQUF2RXk2M2NGWFpHOTVITk5uL2Y1SFF2cE9lUldGNktU?=
 =?utf-8?B?WDhseGM5RWlxcWpvQ29NU0E4QXpubkpMQ2F5Q0NnZmxGOXVBT3luM2FpWEdC?=
 =?utf-8?B?N0RRLytjdWtUUEhhTGxhNy9tNHpsUWNiaTQwSGM4ZjVqS0F6RVFvanV2SVpx?=
 =?utf-8?B?bzBpMUc4OUxrUzI0RzJHMzNLbDg3YU15VW85dm9iOWMxNXJsc1o4amFkOTFi?=
 =?utf-8?B?NnRTakJXSENSZkFpTTZnY2V3RG1XZkFna0ZhVXVhdGszbWlYMFZaRXBTaEJD?=
 =?utf-8?B?NGlkaWpFaEMzcmVwMHJlWWtIS0pFNG9iMFA5ZGRySjhwS09YNmEzY20vS1RX?=
 =?utf-8?B?RVpRdzRya051UHFTR2ZlZWJ5cFVkdVdVUGs1RE91cXhCL2xCb1ZIREUza0dm?=
 =?utf-8?B?eThKTnp1eldKbkZEc29kUjRxK1M1UEdDcXVpZFUwUERFSnh4cm4yWEkyeWZR?=
 =?utf-8?B?b0ZpQnFXZ3dYYmpnV0kxZXNYSHNLV1VzUmFIV1hMc1E2QkdydWEzckFQNzBF?=
 =?utf-8?B?Z2tpbW9NOEFHNHNCNWhWVmhaKy9nUWtEeFdRa1FiN2NJZ0RPLytXL0pNdmMz?=
 =?utf-8?B?RDY4TFRHZmhqYlEwQnM2Z2dSTThFZjF0QUFaRk5Ha3pzRjFMNUJlNllZMHBu?=
 =?utf-8?B?eXZrckxENWMyRTlQNlgvV0ovRUJhOGJ2alhRZWk2US93Qkk3b0FiV3NOZkFy?=
 =?utf-8?B?aWRFam9ST1RCSmtoekdkS0g0WCtyZnNxTlFYRUFlTEp1MFJBejcvME5acWZ0?=
 =?utf-8?B?L0xUTTFidThTSzcrcDFzSTAycnJPWG1nNVlSOHZjT2Z6bjNKMzUxTzBOYXk4?=
 =?utf-8?B?dHd0T3RqWHhCaHdaekoxYUNRTmZ2RHBwbzl4cjl5ZStvRzNIMEJ5MG92SnRn?=
 =?utf-8?B?Q29FUERaMTVIRk96bjhFYTdSWlhxRURQRmEvempQYmpzejA4QWhoT0hZNzlG?=
 =?utf-8?B?Z0dzNFdKUmp0bXozenhudzlnM3VwZmZiWm01L1p0ZTg4RkFyZWFEWHIxVzJC?=
 =?utf-8?B?NGRQbVlzZ1lBMHlDWWMwSXRoTTdjSk5HQXJnb3FibWhLMDJOQmhnSGRXRVRT?=
 =?utf-8?B?TGF4YkxJbFZTN1ZXeElyREFiek93N0lCcGxpREcyNUwySFJLRjl2MnpOZC9j?=
 =?utf-8?B?Y0JidUUzelBTTlNCZGRtY3cwVEVxM2hKaVBhaWYzb1VoaXEvQXRTTmV5aDRt?=
 =?utf-8?B?eGlsQjJZUTdQWTFXN05jODVvZ2QrM1FldWdtalpVdEdDbXVjeDRPMXJYQWZm?=
 =?utf-8?Q?pfWM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e958b3d1-b204-450d-c9f3-08dc0f42db39
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB7511.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2024 05:38:20.1284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bkPq1XZ0/YCMSFCSGNyhGyT/kqKyiL4Ph94GSE97VN1biP4zfeq4BL9/EQF5q85VpX99gNEpPYXAXCY1Bxm0BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8033

On Sun, Jan 07, 2024 at 10:49:17AM +0530, Manivannan Sadhasivam wrote:
> On Sat, Jan 06, 2024 at 11:47:36PM -0500, Frank Li wrote:
> > On Sun, Jan 07, 2024 at 08:45:06AM +0530, Manivannan Sadhasivam wrote:
> > > On Wed, Dec 27, 2023 at 01:27:15PM -0500, Frank Li wrote:
> > > > iMX8MQ have two pci controllers. Adds "linux,pci-domain" as required
> > > > proptery for iMX8MQ to indicate pci controller index.
> > > > 
> > > 
> > > property
> > > 
> > > > This adjustment paves the way for eliminating the hardcoded check on the
> > > > base register for acquiring the controller_id.
> > > > 
> > > > 	...
> > > > 	if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
> > > > 		imx6_pcie->controller_id = 1;
> > > > 	...
> > > > 
> > > > The controller_id is crucial and utilized for certain register bit
> > > > positions. It must align precisely with the controller index in the SoC.
> > > > An auto-incremented ID don't fit this case. The DTS or fuse configurations
> > > > may deactivate specific PCI controllers.
> > > > 
> > > 
> > > You cannot change the binding for the sake of driver. But you can make this
> > > change in other way. See below...
> > > 
> > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > ---
> > > > 
> > > > Notes:
> > > >     Change from v5 to v6
> > > >     - rework commit message to explain why need required and why auto increase
> > > >     id not work
> > > >     
> > > >     Change from v4 to v5
> > > >     - new patch at v5
> > > > 
> > > >  .../bindings/pci/fsl,imx6q-pcie-common.yaml           | 11 +++++++++++
> > > >  1 file changed, 11 insertions(+)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
> > > > index d91b639ae7ae7..8f39b4e6e8491 100644
> > > > --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
> > > > +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
> > > > @@ -265,6 +265,17 @@ allOf:
> > > >              - const: apps
> > > >              - const: turnoff
> > > >  
> > > > +  - if:
> > > > +      properties:
> > > > +        compatible:
> > > > +          contains:
> > > > +            enum:
> > > > +              - fsl,imx8mq-pcie
> > > > +              - fsl,imx8mq-pcie-ep
> > > 
> > > "linux,pci-domain" is a generic property. So you cannot make it required only
> > > for certain SoCs. 
> > 
> > Sorry, why not? there are many generic property.
> > 
> 
> It doesn't make sense to make it required only for specific SoCs since it is not
> specific to any SoC. You can make it required for all.

More than 2 controller need require "linux,pci-domain".

> 
> > > But you can make it so for all SoCs. This way, the drivers
> > > can also rely on it.
> > > 
> > > Now, you should get rid of the commit message about driver internals:
> > 
> > Not all dts already added "linux,pci-domain" yet. If required for all SOCs,
> > it will cause dtb check warnings.
> > 
> 
> You can safely add this property to all DTS. Nothing will break.

Yes, but it will be off topic of this patch serial.

I can submit new patches for this later. After all dts changed, then I
remove this conditional check.

This patch serial is already quite big, (17 patches).

And I don't want to involve new DTB check warning.

Frank

> 
> - Mani
> 
> > Frank
> > > 
> > > > This adjustment paves the way for eliminating the hardcoded check on the
> > > > base register for acquiring the controller_id.
> > > > 
> > > >       ...
> > > >       if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
> > > >               imx6_pcie->controller_id = 1;
> > > >       ...
> > > > 
> > > > The controller_id is crucial and utilized for certain register bit
> > > > positions. It must align precisely with the controller index in the SoC.
> > > > An auto-incremented ID don't fit this case. The DTS or fuse configurations
> > > > may deactivate specific PCI controllers.
> > > > 
> > > 
> > > - Mani
> > > 
> > > > +    then:
> > > > +      required:
> > > > +        - linux,pci-domain
> > > > +
> > > >  additionalProperties: true
> > > >  
> > > >  ...
> > > > -- 
> > > > 2.34.1
> > > > 
> > > 
> > > -- 
> > > மணிவண்ணன் சதாசிவம்
> 
> -- 
> மணிவண்ணன் சதாசிவம்

