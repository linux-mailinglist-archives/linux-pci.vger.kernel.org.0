Return-Path: <linux-pci+bounces-1326-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D1C81D7D8
	for <lists+linux-pci@lfdr.de>; Sun, 24 Dec 2023 05:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E423E1C20DD2
	for <lists+linux-pci@lfdr.de>; Sun, 24 Dec 2023 04:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49864A44;
	Sun, 24 Dec 2023 04:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Uajd+Lcv"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2070.outbound.protection.outlook.com [40.107.7.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4F5EBF;
	Sun, 24 Dec 2023 04:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YT5CctvT9ynfjdKUtpAGaPX6xEtGiAz9i8C8lkiV0MDItpq+83SHWNZ8g7tICqlzy/DAz67KsDyYXM+SCvMYgN1nG+AGQVmq9vLSSPKAo9iMThX0HFa7zyp6fg3hHrm8HYhiCII+1jRc3igxoAHh8D2qjLxhHIsRM4nl7VjXiWQoITYhqJ8Z5XhyskznCcCqDtrk5FmY0doL0LXcSiMQ43rk+xrToDHAPRnESUvkoGqHdvbi0ji9uFpIHXX50ccKN3ejEfj0THsDpp2tJ4aAW91v4lnbFWXUYmG5WnwkTb00HOJs47VakF8B3HlnAW+DcovretOuRNK9fzMSGOp9yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vdzmdRcSAvzt9+KIJ/z1fjiSfg+mwLjdAj8wVpHTNys=;
 b=YLmk9/Ng4X1EV3Mv0MVRKoeW1IzhU9GJDcxfuSpm+G2Xq+8IWONmn3gvUaNyf65vP5yY/6iF3Tv++kke6bidsB2O3Hw3pa8ovfJoQ6P7Jk16pnmMI72LKnaaSa4J/iQPpmg95Lu9+FrQtgxZ+034CXKdv1m0gjY/XS1ZH8vGJepdmCk4Nuc3YkTCGACyNND9U56p8lJJvCr8UINGCmhSC9d5jMXGvqqe4GYXNpHSQCJX9PBs1myQAOFY6TG96CuVFqOODMIDLKkCDRO9JaeV+ixdTiKkczpS4Lzaq3XNahjW5X6CaFIriEfUsByssB1pDZjvmOhWZmDsC1M85jDHoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vdzmdRcSAvzt9+KIJ/z1fjiSfg+mwLjdAj8wVpHTNys=;
 b=Uajd+LcvbYyDBam+Be8pRgjyGKKMLGECGEke1Z3xxGjSDM7a7GkVlNpY0fUGw2cNUUFINBLkcpBe0GnXjexcK6xXh8vL2cK+J23hUqQhbKJQTXR6Lik0FbqVOmt+4UxbprTIcWwiTSsxTucXs/41YALk3+YXAvRdU5R+Sf3nIjA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM7PR04MB6774.eurprd04.prod.outlook.com (2603:10a6:20b:104::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.24; Sun, 24 Dec
 2023 04:43:29 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.023; Sun, 24 Dec 2023
 04:43:29 +0000
Date: Sat, 23 Dec 2023 23:43:19 -0500
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
Subject: Re: [PATCH v5 09/16] dt-bindings: imx6q-pcie: Clean up irrationality
 clocks check
Message-ID: <ZYe252yFqKDsyfke@lizhi-Precision-Tower-5810>
References: <20231220213615.1561528-1-Frank.Li@nxp.com>
 <20231220213615.1561528-10-Frank.Li@nxp.com>
 <9efe017d-e887-4239-a4ca-ff8ffeb08aec@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9efe017d-e887-4239-a4ca-ff8ffeb08aec@linaro.org>
X-ClientProxiedBy: BY3PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::21) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM7PR04MB6774:EE_
X-MS-Office365-Filtering-Correlation-Id: a98393a6-917a-4115-0895-08dc043ae042
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Sgz1FHwEiIFdrQS+58IY60Da4jlQq2Xm2ttiu8lU03DceCUBEbWYLfuTiW3F8Hyo0FNg1Elk8NLnAcKTFVSL0Ds7elVAH1ITaDz2DB8l1N7f1dPAxeYSq08JcT6QkXSYkZDsNDctpdQ6QcIRWOIDVHqYhs86fmEkVUhVgHY/Xdq/Q7heFT7tutXJXY5qzuIIWs5t5KJ/otthiLloOWI1Mo2S24T4NrYpddHxUarxatNouEyjwfR2JnodzTnTuGugYpzuTpt1+BrBsGqDUlMs+5HURV6Mj1f6NWVDxQywTne9cO0kqloJcGoqMn3Q15YTzJkXadnScN5Y9iYkG7OIwUDS5IQE7/pFb/4g7meUGmC0/bn9//JCi479Ai1cF7mYUy2RYDka8vk6Hzv9wXg71BLw5dMxCKRoyYbF6Xh4GvG1thJQyD5kFusUAPOWcbM0DXvwVjOM2Ax+cyzo6W0v3BzJmebxit7fgBApqqy/WctncyHmFDULc+qKMUdiRR0wpv5hRMgzZW0Bbxy0qxw69+dprejE89S6iaTTLhmYEys5/YnL71MF54s163yCBuUK+x50gk+CSMERR0KzHDEBmuB6W/FgyG0q24sQtQjxoXsOU3+kdoQhZW/uN7sZ4G0AQf5I7DPjvx7UJKCSOmu0ZA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(396003)(39850400004)(346002)(376002)(136003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(6666004)(6486002)(478600001)(2906002)(8936002)(5660300002)(7416002)(52116002)(6916009)(66946007)(66556008)(66476007)(8676002)(38350700005)(53546011)(4326008)(9686003)(6506007)(6512007)(316002)(83380400001)(86362001)(26005)(41300700001)(33716001)(38100700002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4QUuLOqfyTEU9CyR2b16HbxhTsMtD8Bmv6aCr4xrsDzEDCuDzfWpAUeBrbZz?=
 =?us-ascii?Q?eJHboOdFKcIOpehTJnE2Z5itMqUXLDoj5z54tnCQF7ftojVHp7QUeNqK1zI0?=
 =?us-ascii?Q?NKYzoAPPJJXNTVykRElJ0UN7/OGgzKJy9q10YxJqBHX7ao//IYJkeZLbPR2V?=
 =?us-ascii?Q?hvF5rEtBOpEyFrhFx4+B7jr/DExWkjEvovXnjAJ+4cUhYarPWvGB3h9Khml8?=
 =?us-ascii?Q?2o0pcZaSyfmDRWkJpaVB0nY6ry3IHycOR+BRO4/elBkTGXsqpBZ1u40SAk58?=
 =?us-ascii?Q?Rjb89BA0RwdZba4Wwxx+TXfmCMwPp3hZPOTOcC3UprJl+c19YOn5xP9JQ1aN?=
 =?us-ascii?Q?Br1QiVgIWKOp4dFFSl9fcMabtV6Guz9Oyf1m7SidiNnfJ7AMj8LUOk8duDu/?=
 =?us-ascii?Q?wwQzdkgb3Gl2qimDm3Oo8KT07m/2sx3hDmXrIOVc3C2fHv94+I0kmkguisNS?=
 =?us-ascii?Q?mF3+B74fG3xoUG9AkAukEkgJJqeUaS0nqvjvnn9US7shAnImuPTVoNvtNq51?=
 =?us-ascii?Q?gDUYcPfgkWPZeoD8erZyKK0kR5USPDH6v0MzSYbnuLdsaJygIfEvVAmtd8vh?=
 =?us-ascii?Q?lCpJQZtVLf/ioAi1SONUyGKviy1VluNDjedTsp9BDXe7r/uu/t+VQ4JIL9uz?=
 =?us-ascii?Q?NIumh2rCLBnodtgxEO14yHnP26Cy7Fpnq5nrYnpjKzVBUnQxF5z1iO8dN2iB?=
 =?us-ascii?Q?keKovjUE7hYcYP0Cfbkf8oA5fZPpxE3XyyHYPoz+P5r5LZUNoJ11/1pImRoH?=
 =?us-ascii?Q?IQDiAbWra0yTbXGO7V1+XqiCx5HWj2U9AYphMCNSsflIw2U4a1Ka9UAEbk61?=
 =?us-ascii?Q?eL07qOGILqokHKh2Il9WcD10HQqbe4G1ONN3eo9cNMfQ7dGwmkCfgurVK0LD?=
 =?us-ascii?Q?W/s2a6sZGduvqNa3FE0hqXD7SqSC2y9P/ai9hDzIgPkdAAnbZvtEWs5MYaDn?=
 =?us-ascii?Q?l69GDfHD2fDHI3fHccRLFZUyXbAo1UZAXEfdVuW6gcucLP0BZxBFVxD/vLn5?=
 =?us-ascii?Q?FNa08tPY4FCMtMG6Y8ccOaAPFHvN8Hu3HuLR0QYdGrf+/twDWTDmlbZX5nVX?=
 =?us-ascii?Q?uIwJ0hk4cJJs2w4jcsHmwLPiMQt7lLRN8PwA6urX5qf0xnc6RjzaIr2xNLbD?=
 =?us-ascii?Q?qIprwas+GRKRA4flWgnIc+I3G0tPFK2g1aFgXyFYzwzycUIGCIlO+DwfBLOl?=
 =?us-ascii?Q?RCVwTQ0lPUowv/xT7Q3CLDTg1/yQY9Dbt60MED/jS3+rbthJSiufDewT2tdD?=
 =?us-ascii?Q?DVWZgAw6mtV4YeyaWH4UhgCjtaIk8xaPYw8BlO/tEZHVK5m5t6EJnsAvKX4d?=
 =?us-ascii?Q?vRlqYkW+y2xH4pRX/ndWeeAZdlpENM49Abs/hiCk5djdsbeor24dNhEHeBy+?=
 =?us-ascii?Q?ChYvVRX9mpvNbYL+ahJaEXEq0B0f638BC+3yOZCAeWBbY3dl0HRVehSrVCis?=
 =?us-ascii?Q?l8Yawug6bkrR6nmFbZoVf/U3FMdNU1xmx2UkNTt8QyYdwyaX/VfuHbE3wwtu?=
 =?us-ascii?Q?wVIBYYDxSBDjcUtKJMhfYrl3ElIFukAgtgRLbbkzdh81BGywu7IsSGTbmreR?=
 =?us-ascii?Q?5nKwGz/5pLF6W73nbZUKNRuR3UjmPWLGmTjB3nSG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a98393a6-917a-4115-0895-08dc043ae042
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2023 04:43:29.8376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: phhQ6gpGD4EyRCJQHqVvD45yzzJO/f0JG2reIRv6JSwFEJV8VBGz7sMyLMkqwq3ZQM2sM3M0tGgmjRoutuVeww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6774

On Sat, Dec 23, 2023 at 07:42:12PM +0100, Krzysztof Kozlowski wrote:
> On 20/12/2023 22:36, Frank Li wrote:
> > There are clocks and clock-names restriction for difference compatible
> > string. So needn't irrationality check again for clock's miniItems and
> > maxItems.
> 
> That's not really true. Other entry does not restrict clocks and leave
> items quite flexible. These entries should be combined so all
> constraints are fixed for all variants.

There are 7 compatible string at pci/fsl,imx6q-pcie.yaml 

- fsl,imx6q-pcie                                                     
      - fsl,imx6sx-pcie                                                    
      - fsl,imx6qp-pcie                                                    
      - fsl,imx7d-pcie                                                     
      - fsl,imx8mq-pcie                                                    
      - fsl,imx8mm-pcie                                                    
      - fsl,imx8mp-pcie                                                    
      - fsl,imx95-pcie                                                     
                      
All 7 compatible string have check

 - if:                                                                    
      properties:                                                          
        compatible:                                                        
          enum:                                                            
            - fsl,imx6sx-pcie
...
- if:                                                                    
      properties:                                                          
        compatible:                                                        
          enum:                                                            
            - fsl,imx8mq-pcie

...
- if:                                                                    
      properties:                                                          
        compatible:                                                        
          enum:                                                            
            - fsl,imx6q-pcie                                               
            - fsl,imx6qp-pcie                                              
            - fsl,imx7d-pcie
...
  - if:                                                                    
      properties:                                                          
        compatible:                                                        
          enum:                                                            
            - fsl,imx8mm-pcie                                              
            - fsl,imx8mp-pcie
...

This check was not necessary at all. 

> 
> Best regards,
> Krzysztof
> 

