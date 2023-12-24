Return-Path: <linux-pci+bounces-1324-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5F381D7C8
	for <lists+linux-pci@lfdr.de>; Sun, 24 Dec 2023 05:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A3531F21965
	for <lists+linux-pci@lfdr.de>; Sun, 24 Dec 2023 04:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F54BA56;
	Sun, 24 Dec 2023 04:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Kv+SFNt0"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2083.outbound.protection.outlook.com [40.107.14.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622B0EBD;
	Sun, 24 Dec 2023 04:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AaZGeqa19Nb4YSeyv9fgIKG6OwVJ1sBBvahMydRC2tP1UXQaLq6xTY40z7urP0JaioW+L8RqjFksv5O83GV+mw7psuN2kZYU0JyoKoNZOKkvCxAVKzIkSX529U81cYXNaY0qBozZAS17QF2/hyhrgbRiINv2h1KxnPsTW6PKGw5HZe3kjPgPjnISaaFabuu/j2Cpp983VXmOfHJfcTxlUGjIRBbZXbcLbzb3Nh4DZM04z9v8L/CPZHQuxoNNk0eziSWfPZNKUCWYT24iHoniLA9gvZolovG7HhXrXZhS1rVbG6lCpELFeW01HFI9eT3f0TU4eaWoqtbJn2EJr8Rd9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I5jXEoUeKp0quf2CFmVSfpZEN0b2h/xCJc6OkbF8xWg=;
 b=AWWFUincNSbv2qZoZy1Z29Z6EzFrZQg5rayqad4JsV0ffMeHpbmfIjhTABALgXG0nLah673f0Yw/9l1y7QhrkkG59XBTxA5TzwqkgHXA3YyB5qY2+4J/5/9KMztktF7ejuCgU1fHr2faR4eqnqf2evfOJX1IeXMcS0vj9eiA9pvMRqoeiuwhV9lSqBruxjXyA1+So43mtkWUFX88I8qsDUQzYBXEHwBEzFu5nzkOsO9xmmzTN0yY8qRm1U0rvWCD2Nj29R3yoW6/41QpIzMZl9LDHVrmtCmMcNze2TcQfrkqnSYf7IlUWE7iIqXt/tjX58Gfx7S2A+oRzHJSpf6tjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5jXEoUeKp0quf2CFmVSfpZEN0b2h/xCJc6OkbF8xWg=;
 b=Kv+SFNt0HOJjAAy4+whBU0pJ2OUZKwoRXL1YvifQulPIoOKMP144BkCOwf9Pm95LEc+Cwjg5JzHvmZhgWNESGjtZ0oAtqjGHVC43O8xlVURYM+tNWoUNbQDc9PTodsWwYYcfcm+OYyMezMbfoHgykudQety7j+hjzpjOs0nV0YE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM8PR04MB7409.eurprd04.prod.outlook.com (2603:10a6:20b:1c5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.24; Sun, 24 Dec
 2023 04:29:28 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.023; Sun, 24 Dec 2023
 04:29:28 +0000
Date: Sat, 23 Dec 2023 23:29:17 -0500
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
Subject: Re: [PATCH v5 04/16] dt-bindings: imx6q-pcie: Add linux,pci-domain
 as required for iMX8MQ
Message-ID: <ZYeznY7gXM+zoQeB@lizhi-Precision-Tower-5810>
References: <20231220213615.1561528-1-Frank.Li@nxp.com>
 <20231220213615.1561528-5-Frank.Li@nxp.com>
 <f6d9a333-3259-4dc6-bdc7-23ffa26e590b@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6d9a333-3259-4dc6-bdc7-23ffa26e590b@linaro.org>
X-ClientProxiedBy: SJ0PR03CA0381.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::26) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM8PR04MB7409:EE_
X-MS-Office365-Filtering-Correlation-Id: ce26321e-9543-435e-5069-08dc0438ea5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jykr3X9NI+OEfopbRAPQMY4OZ84axbpljZSK6jZTAcax1UUQyMNhzmyStuR+gAD9DKxJ2cdcH5TIsEYHDoEMbu/7IZW2cWeBP1ow7bXTZ35N2cnFjGB0bUpnTrc7KD3Vna1Wun5th+1LeXlECko9ZHuqHedPUzi+pHASJ4wmwj+OGRvW+t97MCAoneQ5fBMhe5Xx0h2LX5jKwRDV2XDBTvWEcxgmhe0HN+Pv1KnCAux6zU2yvvs3UKQTNNL1PZg2Y9ql6n/6yxC7ovDCcATyX/91hKzDVCw3MFMeLxUfQdbMCTXypJxHIKhzKHpc3bl1+5l1zfjpi+0Qe75dG345TuGo44zwZm+uTQKN1kb4pZG7mXrW0iKA1p0TZPfFpjj3SznBuvBPN2GXpI89n1egcDQ4gYMy75GihQXENHyD+87mwcSe9SS3GLkFLWBMhHQq/v5BsVddrZmzXBAS+aksBgmEfg6dntljdESLweSmRZJvBectvXfki9DSR9Z3Or5pAsW0y7g0Z4dsTEE9Qy7dl21/vQ5HTiUzl2AhXAQ/OlGFFjiTsRP0npj+LiUUvfvoNGdi8joDPh1V2xq+7QUk0VEcRbTNJ4P7YXdsrLnpwCrf9/G4qpb5nS8TbzRwl4KhRgnMbs/hN/+loT9U6Yh6U7c3pJJ1Y5OU/V2nghgDoSg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(136003)(376002)(366004)(39860400002)(396003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(6506007)(26005)(9686003)(6666004)(6512007)(53546011)(52116002)(86362001)(38350700005)(38100700002)(5660300002)(7416002)(8936002)(8676002)(4326008)(66476007)(66946007)(6916009)(66556008)(6486002)(41300700001)(33716001)(4744005)(2906002)(316002)(478600001)(32563001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sPyjzwDZBqd6+hzD9YDWxk7LZLuwi/pmF1GvlFhit95DG51b20bzwfafDhhs?=
 =?us-ascii?Q?l2FBV33NMG+qc061wKQ5TJ6B03HYr9xNlShABJMLDm0nUpUGxT1R8oqDV1n6?=
 =?us-ascii?Q?gnbTItjI6IQU5hbdQxwfkvjRynXH1oCy1Q+2robM8KA85s+ot3A+h4kOpFy8?=
 =?us-ascii?Q?vvnX6fmtZVnOQFolwVr+P7ylSButP1LYloHlBAAAkc4DoLVGD0OdMiq/+Pir?=
 =?us-ascii?Q?QyXlPy0xstP/moskBZ01ZLHpmdiqddN2igkI69aE63mSdrYwopRicrUWE+ek?=
 =?us-ascii?Q?BBHK8oV5b/CccCbdeCZ5sE03Ud1oRut16jBMZ7pAxD55zj9+bltQE8vMXLmT?=
 =?us-ascii?Q?leInPW9/IikpnQgJCfr3kt5chtPDO+GDKGtk3HtUKka1g1g9rGoHtSCcbrC/?=
 =?us-ascii?Q?rtyQGEMlJTT8WhISfhkRg51cnvxyjKCDhvf/80jE+xL6tWV8x8/ALbRYPME5?=
 =?us-ascii?Q?Fx7S5+bZ5mQmRdOgCJUF3BIf+MrqW580Ualslh8LfVlaC4K2HiGOOtOC3oCx?=
 =?us-ascii?Q?01UG2wpHnG2OjNO0or5qI5+FpeX+tRPZeR2EKTR968HbvGe3l4LwHxC/rWEk?=
 =?us-ascii?Q?S7qpyde77oxato1PiSGg8nP6XCqjMumN3ktPhLGzyJ7BZadB3gH+cyNSenzb?=
 =?us-ascii?Q?RPElHEZ0pcTgWunmSEMl16z4JB2v/vje5vz42HGyyhkVPNtvPFW+/dwVuRsi?=
 =?us-ascii?Q?T/SBUBxNCOZzHvh1JE7IIcvp+YeBCg2CrVt+C6RbR5rcYqVb9dc3HDncuvYh?=
 =?us-ascii?Q?xs6/lUepJEma2EjMvH7DR7HIDy3rQERmYHA3Q4C2Os1k99KczEOco4/qUe8I?=
 =?us-ascii?Q?WRhT29mZhfCXLfhc97/Rhi5T2ycJbVTizWSK4un25WsEzTvZ1LTnWSjihoHA?=
 =?us-ascii?Q?DxPmfJNzHvqREBDXXTBuIGzce4paTZ0oIJIxEIXRXq/KfXuyfxvPHI8x0oRq?=
 =?us-ascii?Q?ys5L5LbroAmE5YAl9YOruQKIh5+wDXO6O7VQFyXJP2UZBuy2STdNGNg1d69q?=
 =?us-ascii?Q?hB1eYp9b53ZWTiaf2QdLNSrm/6MHVLESW7WXWCAce6r3OC03gY1djgkZogF5?=
 =?us-ascii?Q?y9OeUnRfR3IlFwHOA31c/i8WpsKPi9Ac10svb7jnTyw7w7dQLqULpMEJEtbY?=
 =?us-ascii?Q?PxIv3hnW+2CBPMF5nld83VwDRU9lSevA9craF1yv3o19C9mx0onrRLMAwczN?=
 =?us-ascii?Q?byYG7RlpASeFNjL7Y0vOHvgAYy3AZ3wETERaaNCk9uqaLYE72QY1PED6d6I8?=
 =?us-ascii?Q?UtC02/3TBVibW8NlJHxjP07D9zBPpShngmgDX9W6qkc+QuPRChigXECb5Z6X?=
 =?us-ascii?Q?eXqM72FPXWCYLgDJymAtjbndjiyagfmV3DIYuPekpeKTZtSQe1sugdr+U90n?=
 =?us-ascii?Q?Dka3nnXy4CKf38RQxz3V+qWWqTZfebp0uQGXXxfNDX8LOC0HAM5SrWo+uGmD?=
 =?us-ascii?Q?BbYgFLPo5luaItr8vF6/MYnrVTUJIUZ2jkUfejido5fLFpx4AYxH4/Vk+Xm4?=
 =?us-ascii?Q?FnSKPR8TzMBqn5Q/axtPwj74Fje4YXHkmGeDYGsuc1iA0Y744CN2m4eBLRt0?=
 =?us-ascii?Q?8YXxdB2gZUqNxIVy6Fg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce26321e-9543-435e-5069-08dc0438ea5c
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2023 04:29:27.8850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XbmO6ALhJB0z7gQ6Fcl1ahxq25xex6prN/FPp/HwoOPYX6wduSjAJ9td5xSF2tcmd4iRB6vsIqGo3F+RkJx9Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7409

On Sat, Dec 23, 2023 at 07:40:28PM +0100, Krzysztof Kozlowski wrote:
> On 20/12/2023 22:36, Frank Li wrote:
> > iMX8MQ have two pci controllers. Adds "linux,pci-domain" as required
> > proptery for iMX8MQ to indicate pci controller index.
> 
> 
> Why it has to be required? Everything will work fine if skipped.
> Otherwise please provide reason why it must be *required*.

Next patch will use "linux,pci-domain" as PCI slot ID, instead compared
with hard code register address.

The below code will be removed.

-		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
-			imx6_pcie->controller_id = 1;


when there are more than 2 controller, this compare logic will become
complex. 

So after next patch, "linux,pci-domain" will be required.

Frank

> 
> Best regards,
> Krzysztof
> 

