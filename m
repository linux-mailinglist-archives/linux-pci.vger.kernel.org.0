Return-Path: <linux-pci+bounces-1746-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 639EF8262E5
	for <lists+linux-pci@lfdr.de>; Sun,  7 Jan 2024 05:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA0D1B21BA3
	for <lists+linux-pci@lfdr.de>; Sun,  7 Jan 2024 04:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49D511CBB;
	Sun,  7 Jan 2024 04:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ppo8SZj6"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2052.outbound.protection.outlook.com [40.107.7.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C1111C8B;
	Sun,  7 Jan 2024 04:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AsWTOP63BQL83mUgRboSv4mxfD2F3lEsnFJx+RY7M5FazwcbujULKUfSaVyiKxnoxJaC0Dy1KVpZYZQmlvlClgou+syo6qflIHpMk8BJipUKzMBLI4ErTZOgXEMmxKY6XzwIuDNjGBT3BwbwCyCjI67E/uHfZPDtFbhu0Zo7U8IoizafC/NCJ8m9pzCmqtyLZTlz7PffayRDsbflGqX90m3M23TnrVMsUiLncsIUW+6/Gwn/YfLGPDqTC+l7w/wEosUGHfDXEZtZZfzO3tsvizMIyGROCJ7zO9aEH5mwlVUAb1t/5FMdO8cL61xSPZZGWcqZZ0/c6jfEoEYuZ+F6Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lah4of7i259VvGLz3f31uFgrjVuGLjjRoQWwOvCZsc0=;
 b=kdAgZY14pbGPRCJ7L1TLfy/GBD/RzwF1MtWX3PLJ6Gskdgafov6ORk0VPX/qNT7FwV3AngA48y4MX+bca6TKR1mu3Ak/mNpJzEHEazYW40KtQ3X6uQOaCIAsEwfPumIROtPGwlfZnZ+C4TJzQ6cXW4PfU4ldHr9b+Juzx/vKFp/V4L4G9rv/DwS3CUgfg4een06z1PWPWwxwPyhKTYOXSZTGRaRDeaWDUj4vnftSR9FuLFfjG8sRftWWs9ROYmHghI9+cmIyFIN/IyBiy2pxpuN78w19lLv+p8ypx+W8HU2AvaAp7ZwXLh+JH9Yo4mzOqpNGdQUJMrhfmf21vgYPig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lah4of7i259VvGLz3f31uFgrjVuGLjjRoQWwOvCZsc0=;
 b=ppo8SZj6uzDUi8p46M8104jOn/IcKW5KTBu50rSt3JMc5eURbCrbY9VQHQ+p+kvWuuiFzTWA1ixu6L55DkRSf1StFCpMKRmW2lZC9teuwuUxo8iD7hhs3wXpifXflba1Drwh8hluNaZG6VyMDKpKKBwOfADr8CfNRLbyLwUzOM4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com (2603:10a6:20b:23f::5)
 by AM8PR04MB7363.eurprd04.prod.outlook.com (2603:10a6:20b:1c7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.20; Sun, 7 Jan
 2024 04:47:47 +0000
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469]) by AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469%4]) with mapi id 15.20.7159.020; Sun, 7 Jan 2024
 04:47:47 +0000
Date: Sat, 6 Jan 2024 23:47:36 -0500
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
Message-ID: <ZZos6LDk4NTfQHyU@lizhi-Precision-Tower-5810>
References: <20231227182727.1747435-1-Frank.Li@nxp.com>
 <20231227182727.1747435-5-Frank.Li@nxp.com>
 <20240107031506.GC3416@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240107031506.GC3416@thinkpad>
X-ClientProxiedBy: SJ0PR03CA0094.namprd03.prod.outlook.com
 (2603:10b6:a03:333::9) To AS8PR04MB7511.eurprd04.prod.outlook.com
 (2603:10a6:20b:23f::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB7511:EE_|AM8PR04MB7363:EE_
X-MS-Office365-Filtering-Correlation-Id: 27d23a14-ef46-4a94-733f-08dc0f3bcb90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	H/WV4bO9AFRrQLp8GH/r7uDW7ody62cc0NkHTO9CQ9qews6EjYsh3QsSPkqICaDPu0deZxvwZvUW7pMn2kxGiBpfgUbXfNRQigB036/FjTGxNfPDkjf/P1I3eEdf41fnCZ+Wqp8mzUqLqGBja17C3Wj1uufpUQaEhi5zStESLEYtveyOhKHvSctGnxZwy+xTz8zdg8U+WPidBf7OkAI2BkP4AfCBbVVBGpyEALbvkoQXEdyy/eT293LYm5DQkrApI+rGmspbNa7M7mZIqAENpnek3bb5wQyNH+8VRwIzcO56CBGVxK3EZxc10FYN6qGp8u4on9Hh8F9lo/pzh5vylNePtaClU0Vgk19j7hVEBbdd9AnTicmKA81UApqH2pbWRh+qb1DIk2BfyQnHKUVg5o9Ntj2i2oDGy2wxDNjV7WqC4O3qNeNRGP5kOaYzbxj5WR3RAvdX4CFVvf88SDuSlqgls8ugccxQ8MchxRmVY4zG7HA4ZdCGYjMSzjXCw0MfU8ZQ9cOv2SHKKMkohY8+6dpLAsnZnViGkNc+vycVE+Xzm0Gzeq8eZKwThpI0F6Vqn0IpawG+U1vo0k/cVeSq+X9h2oXisO4cKu1e829MuhhfbnKCu/JkgXnCafKXE+29pkh+QrFsUU4mSG4641x3o10I+RF+TyPXEL337cWjCJ7Bl+wz4QtZARrzugFTSkl3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB7511.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(396003)(376002)(346002)(136003)(366004)(230273577357003)(230173577357003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(33716001)(8676002)(8936002)(316002)(6916009)(5660300002)(4326008)(83380400001)(478600001)(9686003)(6506007)(6512007)(6666004)(52116002)(26005)(66946007)(66556008)(66476007)(38350700005)(6486002)(41300700001)(38100700002)(7416002)(2906002)(86362001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TExNU0Q3VVFCcFFaSkpCYmpybUdIV09JOGhuWUdzVmp6KzVzdE9oajFDbXJY?=
 =?utf-8?B?LzF4R2VzUmNqREhGSFBLanVzWjI3S2tMYWFnV3JGa2tOakROSHRsNXlwWjlE?=
 =?utf-8?B?aVprVFE2eGxEUGU2bkEzR3MxS1J3UkRtaXNuRHVtbzZJczNaU3NGYnZDRGF4?=
 =?utf-8?B?VmJLbXpIZWxvbVk3TFUrREkyMW4wQkxpN2xpcFQxMW1OVVJEWmtUdU93RUJi?=
 =?utf-8?B?M1hUNmQ1cDduN3ZSTlBMRUEyRHRCeFZwczBmTWcvR0lISDE3YXJjVk95M2ls?=
 =?utf-8?B?VUxUVHQ5UUpmZHNnQ0JqN2xxRkVkV0hkcTZQV2taSVMzcFY5Vm1wWlRGckV1?=
 =?utf-8?B?SHlIMGdYVWcvcks4VDlkK3hKWGxSaFN1djc0eEloaTA2ZkU1dGFINzBjdkY2?=
 =?utf-8?B?UE9henYzSU1BSThZT0ZnZVVXaEU0OWlsazFiREN5b05zSm1IdGI1ckdtQytX?=
 =?utf-8?B?QlhPUi9aY0ZmcUtZUk11UzU4c0g1TS9sWmtJb2RlVHdNclNvTFhkTWNwd1kv?=
 =?utf-8?B?T3lFQVZmS0p1YVlLSGc5K1ZTYVg5ZGEwZnVYcWl1L01CN2k0MGZsUDhkODRM?=
 =?utf-8?B?VVNTOWxlcWdsNFpMSWtnTzNQNWxKMWtDZitHVDlHSzAxUHNYdkY0TVZobDRj?=
 =?utf-8?B?UTdDM2NSVU9Pc042bjlpcGpDNUFqTVdzaktpYWZRaDRkWmFpVndtOWY0T0dH?=
 =?utf-8?B?b1hDdk9oVVJwWDdOUENEYUtzTWUrVDJWbmpMUUV4VHJjWlJYTkpZT3NTUkR2?=
 =?utf-8?B?SytqUlpaSmljN21SVVNaODFvZXlCbkk2dzBzUUpvd2FYMVp5Um8rbm5hN1dH?=
 =?utf-8?B?SlVaZzJONjgzeWRSNkZtS0hkRXJwdE1idFlvNi9Lc09TWW1kQWtQRkFqZmtj?=
 =?utf-8?B?ZFY4MzR5SHpJUjNwL095QjJnWjhEMGR6S1hyVEhkY29LYXJoempLVU9pcVJl?=
 =?utf-8?B?SmRrN0VJREN0eHBiQkhRR1R1NlhmZGVzWGoxSTJjN0hLK3o1ZTROTDRSNDRi?=
 =?utf-8?B?WUJFTWhrMWxzT2hNWnRodjUxZU4xRURBNmJFcjd5SFV3VFVlZnBsdVBOM3hT?=
 =?utf-8?B?cm4xaVgxQzl6TkMxU0NJU1FlNWJQOGJqSmFORzJqV0tpN3hCZFhoWVhNc3dE?=
 =?utf-8?B?cUZuZjNPYlNic3dvbHdaTkVGalYwU2N6SWcvYm12aWhOeW04R2NHTTZQTnVX?=
 =?utf-8?B?a000YlU0UGVndDBXamJONFIycnE3RlRLTFFBUUF3TmJyR0o1cmhvd3Rjd093?=
 =?utf-8?B?emk0NXZPeG1jVlJ6djNGeThTOW16bVJpNUpyN3RrUkQ1cURsRmlnbDhrOXNl?=
 =?utf-8?B?eE5CTVdBSG5YQUR0LzFJaVA5OEQ0c3FaZDVuRHNXK1VtRVlRNnZ3SzI2OEI3?=
 =?utf-8?B?RzluMm1hOURpL1JEa05nNnBVMXVpQUl0cExHSHA2TTFHV1Y4b0pRWUZDT2Vq?=
 =?utf-8?B?N3ppMU9wYjhIbTJnUmdmVHIzQ1liamwvTXJkek9tbEpBL3g1Q3hINlRteklL?=
 =?utf-8?B?ZW5DdzdjbmZHUUhOTnFvdW9QMzIwZWlKT1ovdGZTZjJWTGlBYkhtZ1lXVDBJ?=
 =?utf-8?B?NFdPZGZoOElNNFVwVTVVSTVBOWt1bTMvK3NNS2dKaWpWcEFMV2tGTnk4SjFT?=
 =?utf-8?B?Ykh4RUFLb3BOMUFzNTZGbUNBVmltSlp4Z1F5K2d6SU5BaXBwcHZqR3VraFkw?=
 =?utf-8?B?SnprUEN0Wm9VZHVieXVoUTI0ZHIrZU40QWk0aDQwVnp2dlpzNzJRWW5VM0dj?=
 =?utf-8?B?T3VkODZsaXRmYzJIay9vTmZHM2FGR3QyY0R2RDlEVjYwYUV1WlFhdHNvK1pn?=
 =?utf-8?B?UHFubGE2ZTZFME9KNlRyWnl6SWdlcFFqWXE3dVdXblcyUU5jWjB1dXNGYnkz?=
 =?utf-8?B?MUYxQXVlQTczWkduWk5QU2ZKdnlYbGhiZ1ZEWWl5WU14N3llOHZxK20xYTRt?=
 =?utf-8?B?L0RLRUxhWWs1dmpUTEpSUzdFS1dpTFpSYmovUjFwWkF5MGN2N2QyOE1abWlz?=
 =?utf-8?B?QkxZTFltb1cwWVJQKzVWbXpRQ1RmMjMxNUJVWnFlMnNHR0RySzJPTWRYU2I4?=
 =?utf-8?B?VjVIZ1pLR2p1SlFRMnRLeVpkRlp3bXo5RjJWSjNYUkpaSlkvYmJIdXpVSjNB?=
 =?utf-8?Q?s5Z8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27d23a14-ef46-4a94-733f-08dc0f3bcb90
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB7511.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2024 04:47:47.4312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zn1MvnIXNkWyhceYvtx16711qu/ieXyZ69VkEw/pmfVwdbbWAf8E+Yr/QhGmRXaZF4vTlo4PLv+qDUFYMCB/gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7363

On Sun, Jan 07, 2024 at 08:45:06AM +0530, Manivannan Sadhasivam wrote:
> On Wed, Dec 27, 2023 at 01:27:15PM -0500, Frank Li wrote:
> > iMX8MQ have two pci controllers. Adds "linux,pci-domain" as required
> > proptery for iMX8MQ to indicate pci controller index.
> > 
> 
> property
> 
> > This adjustment paves the way for eliminating the hardcoded check on the
> > base register for acquiring the controller_id.
> > 
> > 	...
> > 	if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
> > 		imx6_pcie->controller_id = 1;
> > 	...
> > 
> > The controller_id is crucial and utilized for certain register bit
> > positions. It must align precisely with the controller index in the SoC.
> > An auto-incremented ID don't fit this case. The DTS or fuse configurations
> > may deactivate specific PCI controllers.
> > 
> 
> You cannot change the binding for the sake of driver. But you can make this
> change in other way. See below...
> 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > 
> > Notes:
> >     Change from v5 to v6
> >     - rework commit message to explain why need required and why auto increase
> >     id not work
> >     
> >     Change from v4 to v5
> >     - new patch at v5
> > 
> >  .../bindings/pci/fsl,imx6q-pcie-common.yaml           | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
> > index d91b639ae7ae7..8f39b4e6e8491 100644
> > --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
> > +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
> > @@ -265,6 +265,17 @@ allOf:
> >              - const: apps
> >              - const: turnoff
> >  
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - fsl,imx8mq-pcie
> > +              - fsl,imx8mq-pcie-ep
> 
> "linux,pci-domain" is a generic property. So you cannot make it required only
> for certain SoCs. 

Sorry, why not? there are many generic property.

> But you can make it so for all SoCs. This way, the drivers
> can also rely on it.
> 
> Now, you should get rid of the commit message about driver internals:

Not all dts already added "linux,pci-domain" yet. If required for all SOCs,
it will cause dtb check warnings.

Frank
> 
> > This adjustment paves the way for eliminating the hardcoded check on the
> > base register for acquiring the controller_id.
> > 
> >       ...
> >       if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
> >               imx6_pcie->controller_id = 1;
> >       ...
> > 
> > The controller_id is crucial and utilized for certain register bit
> > positions. It must align precisely with the controller index in the SoC.
> > An auto-incremented ID don't fit this case. The DTS or fuse configurations
> > may deactivate specific PCI controllers.
> > 
> 
> - Mani
> 
> > +    then:
> > +      required:
> > +        - linux,pci-domain
> > +
> >  additionalProperties: true
> >  
> >  ...
> > -- 
> > 2.34.1
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்

