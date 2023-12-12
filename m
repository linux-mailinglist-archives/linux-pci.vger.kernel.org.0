Return-Path: <linux-pci+bounces-826-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B086B80FB63
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 00:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AF05281F58
	for <lists+linux-pci@lfdr.de>; Tue, 12 Dec 2023 23:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C0764CE3;
	Tue, 12 Dec 2023 23:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BF1k8+qw"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2076.outbound.protection.outlook.com [40.107.6.76])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B22E9A;
	Tue, 12 Dec 2023 15:28:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qo9KXdERokuN7g40RUS71KbJu6D8RF0fgKDWZ1uO7asIOY+OD9S0kt0FsXgvJV48laBR+vWPvXjz2A2qF2M+0Lpm0FJnqs5sdh9hNvXvPh3/e71xughgksrbz92nzqw4T8AVrUZS+dR1DFY+RH7zxUWHrp63DXUpqNd8vqrYSBOOJJde2PqKdSw/O1tfFMwMPPBaV8kXbwOsW+WWy8odXQ7Njizs8c0uQGhLTVIKHaguYZxGI2LdWsKwBp3ONttTd1+GSbAEnWeYFuPxpNCOW8YQpdei7ZrsGg7VFIYs32xHYbktyL6oiB9FJEQ2J+rKMdNGSvmCaNy1oi/o+/MjGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iPxBrbr9Yc1aDgrnpWdn48nkjZoaWGeaY/1PKHUiXbI=;
 b=QFFwKpk1WYTwqzVg5aYNXXcKAz0qgmeol2M0Rrvvf+yTXhgW3kvWcFMwJYHcij284Q7MYM+H+FW+75V2FTBGUg/Pj7PJrvXr02Lxsa9IvxGXsiBHyI+9E9e/OZ98uhbK6lkNZMk+5mP9hNXMS7vbSz4CgKNuPykXPbsaA1sXGqzFH0D/eSRd2+7Tay6OHWgGVAXOkp0jRZsNdl/jsuaGcKfYKFB9bgxIXu15cRvhgJ/qaV/R9qX/DCjspOCQ0M5itL8JbFOOSnf7blpXFyG3p7cpD90vUPlBgTWh9TMLCeYc4Vq5uvL/caemkS8YCTzCh2L892ri8jpXhLBqRMQzkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iPxBrbr9Yc1aDgrnpWdn48nkjZoaWGeaY/1PKHUiXbI=;
 b=BF1k8+qwVQttnyBmCucQdq9/HN5RBFx7QO2gxFo7OO+rkA1QMfhCRugbGkliws9wVNxdA0kEfwOhxNPtyZczvlrOYd2vZQ94BeX1+PB7O0/FXixlIs2bWGUEPG6l/GKeUFMEWhmYpbn+pAd+i20+9jjaDwUrwy50q/ITGQMJilw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DUZPR04MB9848.eurprd04.prod.outlook.com (2603:10a6:10:4dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 23:28:53 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%6]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 23:28:53 +0000
Date: Tue, 12 Dec 2023 18:28:43 -0500
From: Frank Li <Frank.li@nxp.com>
To: Rob Herring <robh@kernel.org>
Cc: bhelgaas@google.com, conor+dt@kernel.org, devicetree@vger.kernel.org,
	festevam@gmail.com, helgaas@kernel.org, hongxing.zhu@nxp.com,
	imx@lists.linux.dev, kernel@pengutronix.de,
	krzysztof.kozlowski+dt@linaro.org, kw@linux.com,
	l.stach@pengutronix.de, linux-arm-kernel@lists.infradead.org,
	linux-imx@nxp.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org, s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: Re: [PATCH v3 08/13] dt-bindings: imx6q-pcie: Add imx95 pcie
 compatible string
Message-ID: <ZXjsq2QtFa2V0BAl@lizhi-Precision-Tower-5810>
References: <20231211215842.134823-1-Frank.Li@nxp.com>
 <20231211215842.134823-9-Frank.Li@nxp.com>
 <20231212224426.GA2948988-robh@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212224426.GA2948988-robh@kernel.org>
X-ClientProxiedBy: BYAPR08CA0029.namprd08.prod.outlook.com
 (2603:10b6:a03:100::42) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DUZPR04MB9848:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b174819-107f-4ddc-68cb-08dbfb6a1a59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	g0WueD8zidrn7MHLIpsQ2/ybN0F1/X6s87O7A1W6kUTouGWn4JQAvL3E7BoM06eajmg5EVMKaW3et2HczUuuAcTJL1mMLGDq5uSqoNT6k2WFgG4209D1DSQrTjQlhDt5o2HshBPXQRJdTx+7sHd9dLRv6WmRye3SgG+pz/epVxeZ0u2cjZlRO7ClzyW+FVDq4Fd7dskfBTVBOWHtHRU/UgrdZO4UMugvpCZ33HbJRUzFXrxFrlptgEYqtP7/SgnNddoLey0A2BJn7xSB8YXaNxU1Jp7h8UwBpdY36WdBkEme7eUtAudYtcpzAG7f0Xgy/m/AA9I8mTC1KiQG9YeXbkqqlxzk+0RhBbBfMlrX98u46AF8iEKSdKYKqfDyK9efs6mgsaPbgti+V76KoQPbEi2/I6lmkQzzryaefaAhF/EmkSBnJLSbbjeusVDeoSTXRRA1VPS2ivED/7BciHCTxE1d1h5FKscg1AlG9gnwVG0PmyKgPaG6xXojNjhLCz4ivDVDJ5S+Cd2bmLixKph8nE4nEypXqGn7ixwmjWQnsk8O46j97L+GuZApiHq2F2LNE/pjPx7YAKIieY7OSBBqEHii4lBhydwMU4t7UCCBxpQGLtyx9wpm3ZcTkd3GPUQjd1govn8vWULXp8lOQFSccQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(39860400002)(376002)(346002)(366004)(396003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(83380400001)(52116002)(6512007)(6506007)(9686003)(38100700002)(66946007)(5660300002)(4326008)(8936002)(41300700001)(7416002)(2906002)(6486002)(33716001)(8676002)(478600001)(316002)(6666004)(66476007)(6916009)(86362001)(38350700005)(66556008)(26005)(66899024)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dPl8odxPDjhxMaVIs8uOWcM5HgowgT4xkw3mE/gEAxOxnxOxkTKRPL4vowsv?=
 =?us-ascii?Q?F3IThEw8Z268+HquyQd4Xej5TjgBGM+9/dEgn5CteMKscioxa/iNCT9SoE5X?=
 =?us-ascii?Q?XRkiwjdQuUEnqqL32olCPNSR3onMAl8licWC0ozm1Z5h/aRkvKR/od84ut/3?=
 =?us-ascii?Q?a+Inj83aOY2k0TQKr6ihs4cvguErUln/FSPmBUSEqdS++jObdNJYnyhR07ze?=
 =?us-ascii?Q?/Zr6JM+KFY/wFSWAnoub/mWYPdC2pQwMSw4M3PLu4RyZd6L9AZZis9ANKhCT?=
 =?us-ascii?Q?KOmwNkJ45GY7U5lQGOEDTsG0qYwim+Peo6dbiH8j2HcNEUnZdfmYgOBqNwmj?=
 =?us-ascii?Q?NnLrezBsX3NZYjNhF/ysRQoSiCGCmCse7CNAAJ3JRjyJf1SEpyMphKoEbPUF?=
 =?us-ascii?Q?qqwadoDjJrhCA7i2I/TsRWhVyGop/GI/uEiGMHKbwfYgIMX7DFwnottcSjg9?=
 =?us-ascii?Q?tKgWcdvMPDwtPBQdkNvvJqAE5aPTJPNpVO16pCOx4Jcxi/1bMcz/Dj5QIj7N?=
 =?us-ascii?Q?7SkxB//LzVfKNnFQ3Kbpdk8pyByiETcWn3+J6wzhB6QKZIgvEysG11GFwxAn?=
 =?us-ascii?Q?QBmPg9y3Y+z4d/+TZqabV4MCHTHWxjfmAHmkIuA3weasi9sC7VmPcJEO9VWD?=
 =?us-ascii?Q?C7cUWahtSE/somBG3/qtDvLqLDSDhA3vCGKPT2G7E9DbH//6IVLC9KEqtnm2?=
 =?us-ascii?Q?8l6QdkRV77S4yR8iVIqrsOOEAYIgB9R9q41DI8GlcaRE802aC+6tRXXWV3mS?=
 =?us-ascii?Q?NOCUvEQ/T6fvVbaXhd0+kWSv+MZ8cDW6A+YH6aUxNIYt0RdIsOfOKFJmJmUp?=
 =?us-ascii?Q?Kjx4hASfoHWsHQyo3jFqZJOVPxenWwHny8UH/7YNGSFcpLIay6DtKwPXWCq7?=
 =?us-ascii?Q?EGTplxESEK58q5AslYe32UcRi14/+lnk1AWi8f215ryQgwiYvK6b8QE0aohK?=
 =?us-ascii?Q?XURZkAYUxkfpR0KlU4PE6pJG6eQ0d7bne1RJ9PRWPPTHMNrZJ8DumOCkW7Vk?=
 =?us-ascii?Q?Jn9hN6DPd3gZGZhoPDAaf4q9ig7rmwX2Aqvx+xtxJ4wKhUn4qlsnM54tkRag?=
 =?us-ascii?Q?FDAOpYQqNTDjUeWefaET208GTKteH+xMSSJBmc2yuG1d9coUyn7nw2rUX3Uz?=
 =?us-ascii?Q?5tJ2i1qlhtEacO6Dqy38EAqK3XCqh5NNw7jTxVby7mpoJsTSZMJn4mEcC0PP?=
 =?us-ascii?Q?3tcsx2C3JIJgB/QKTGRVk3sZb+tptIjXeSO0RqKXbt/LEgfBMSJi8UlBC8jC?=
 =?us-ascii?Q?ins6bqp5jcIwDgugnorgvG6K8KcPKN0FQvYcJ3Y4DAIyCCEkIunvhwVXqyCL?=
 =?us-ascii?Q?JEXSI9GXWv1NpyqiKuQa7sJpf0ZGj3Sry1nSt51pc8R84szzO5qJ+qw23bv7?=
 =?us-ascii?Q?URUO8ctYftFtHeXGHR1VXtqBSFduiqkTjzLbcMjErdEr/CJm0kk+lNiiQ2dK?=
 =?us-ascii?Q?UrZwcJ97gE6u2HJ0cL95sV0VqLki1FiLKFMm8sgWY4okVtB+k1SnuNvVXgfT?=
 =?us-ascii?Q?zcKhxWqQffIr8DmpWDPCfndePpahYTAGGQBVfKBttzI0OZ4E9nBWVMPfDf2U?=
 =?us-ascii?Q?q82yLSuNrj+3QTiLpcUHI1TLBd1OjgW91HM1WaMz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b174819-107f-4ddc-68cb-08dbfb6a1a59
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 23:28:53.1470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NY1Pypbn01ymZX5aR+/iKdbmid5E9vm1cm6bkzN77QNDVmK00rE7gzihj9HOpVK7xS0z8wk3aJgzze6PIjECVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9848

On Tue, Dec 12, 2023 at 04:44:26PM -0600, Rob Herring wrote:
> On Mon, Dec 11, 2023 at 04:58:37PM -0500, Frank Li wrote:
> > From: Richard Zhu <hongxing.zhu@nxp.com>
> > 
> > Add i.MX95 PCIe "fsl,imx95-pcie" compatible string.
> > Add "atu" and "serdes" to reg-names.
> > 
> > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > ---
> > 
> > Notes:
> >     Change from v2 to v3
> >     - Remove krzy's ACK tag
> >     - Add condition check for imx95, which required more reg-names then old
> >     platform, so need Krzy review again,
> >     
> >     Change from v1 to v2
> >     - add Krzy's ACK tag
> > 
> >  .../bindings/pci/fsl,imx6q-pcie.yaml           | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> > index 81bbb8728f0f9..b8fcf8258f031 100644
> > --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> > +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> > @@ -29,6 +29,7 @@ properties:
> >        - fsl,imx8mq-pcie
> >        - fsl,imx8mm-pcie
> >        - fsl,imx8mp-pcie
> > +      - fsl,imx95-pcie
> >  
> >    reg:
> >      items:
> > @@ -90,6 +91,22 @@ required:
> >  allOf:
> >    - $ref: /schemas/pci/snps,dw-pcie.yaml#
> >    - $ref: /schemas/pci/fsl,imx6q-pcie-common.yaml#
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          enum:
> > +            - fsl,imx95-pcie
> > +    then:
> > +      properties:
> > +        reg:
> > +          minItems: 4
> > +        reg-names:
> > +          items:
> > +            - const: dbi
> > +            - const: serdes
> 
> Did you test this? It should fail because 'serdes' would need to be 
> added to snps,dw-pcie.yaml.

I run "make dt_binding_check DT_SCHEMA_FILES=/pci/", no error report.
And PCIe function can work.

> 
> Is this really not a separate phy block?

This is misc block, which included phy and also include some registers
about SID for each PCI devices. I plan do it later.


> A separate node would be 
> ideal. If not, there's already a 'phy' name you can use here. We don't 
> want more random names.

Chip reference manual call it as 'serdes'. If there are already similar
name, I can reuse it.

> 
> Rob

