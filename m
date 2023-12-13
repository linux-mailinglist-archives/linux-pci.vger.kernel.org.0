Return-Path: <linux-pci+bounces-880-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2168117BE
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 16:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DB4028610D
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 15:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932343A28B;
	Wed, 13 Dec 2023 15:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CnSHmD3E"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2084.outbound.protection.outlook.com [40.107.22.84])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDC4B2;
	Wed, 13 Dec 2023 07:39:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C+n/U7U5a5RalC6rHN2rt1bwFbFCVPWlVT8IN/qTt7UBTttirqx3a1iYJ2Es8db1ewO9/JD2mLTS3XERqLX+BsMnk/AMZ8JthXas7cccdMekwlGL3REm6QB+1yJWJUsQU57nWaG8zkVt0CWeoAF8yNHwxttTq8GT8YNwg0KtaTLP/RRUUGGs4+vwEAxQFY+DMz6vjeVs5KuBCyxGCSw4Xegiyc08BOXzveeHK0P/NOyonkXV/tRPC7UYDcmFhQGfqUw8o2V7R8j/exZT5+B4nQy+YU0ZAh23KzmJI5QNzubA9KlYsUIqRdhJ963dd7MaXxezc1sL8D4OlHKam3HV9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RheBhCGdzPOd5sggcYITOIZ0TR1XH6/G+bcE72jzgvA=;
 b=jOTHyES9B1mcRiq+gcv/yD1Gaouy+ndlcI+GH2EdamZNh5quyhmqWielukcdZg2SPRx/1wpk91O5CGUkLg8Z3160MBMCesxtKLv+x3zvMV0sD5OSXsJg/kUVUOejridgcn717h9KEfjk8BsulpnjmNhr0bc/+m6Nqgw2V/xrMDqY/Gxchz5PwLr4tc7reZO8EeY/yOI18eBeDvAIHcbAUEcfXunqfCiy5qbMwnLdCnBM6c8mAyaVSNsFhfeuknSxnM5wx5SEHUy1EFIQfxtV10ZuHkHuhf2aRbeBWJY+U0vZLmKwG8gjHXlBDvJVZnX6UweJFiwsdxt6gl0PZ1BNIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RheBhCGdzPOd5sggcYITOIZ0TR1XH6/G+bcE72jzgvA=;
 b=CnSHmD3EZdfdWTMdWeudqhuhcgPM/hCoNvIOSxpib6sQYfkN1O8ifUmiQS88BEh4bUXvU/DUks/VxvGxj9rIQ/YAP3hMiOMeLZl9azc+CK/+vh5LcdGy0CAxQpWmBPKn9jonXiHyvwyYcSudONqe838SC6WU3/7hS4l4TsQySGE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB8829.eurprd04.prod.outlook.com (2603:10a6:102:20c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Wed, 13 Dec
 2023 15:39:31 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%6]) with mapi id 15.20.7068.033; Wed, 13 Dec 2023
 15:39:31 +0000
Date: Wed, 13 Dec 2023 10:39:20 -0500
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
Message-ID: <ZXnQKBnweCT+si6/@lizhi-Precision-Tower-5810>
References: <20231211215842.134823-1-Frank.Li@nxp.com>
 <20231211215842.134823-9-Frank.Li@nxp.com>
 <20231212224426.GA2948988-robh@kernel.org>
 <ZXjsq2QtFa2V0BAl@lizhi-Precision-Tower-5810>
 <20231213143615.GA1093782-robh@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213143615.GA1093782-robh@kernel.org>
X-ClientProxiedBy: BYAPR02CA0043.namprd02.prod.outlook.com
 (2603:10b6:a03:54::20) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB8829:EE_
X-MS-Office365-Filtering-Correlation-Id: 23757cac-2bc8-4765-0fbe-08dbfbf1b1db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RynaWRZt9e+k2yRcFRbeAhC0KMXomI/64/yq8CKWa5MF5nxit1MCf7VjgHATbPe3uUOm20B094NkvI+4MtQESdBh/eWhDDCb+r0i79yBgACKvb2+vnVPRAr1+sAiJFZHcXPTlpdn4ux+jT44h2ul0lTzUWVOAT+u/MAm0uFVL6nF9zkOK04cl0qgyjivZ51kM2SPnv5loGHTjCH+SduFQZHQV/h0xhyrm/WPVTgKAn0/Y9gylSva37G3AhxDs/J2saO4sPhbWP0WYuBIxx0ToCX57TLZaDsmyUpH1Y3gj+RdT9SIWW/imZB8zCmagonOfwoCsCxgFLshp3wyHUxwBZysmE5aFRWXJoxmj0V814duQuXaJS/3IoUGKtgX0DB73JtdgC2kb7rzNofqg8ySm87df32NlygqeHsCF5BGU/xTw1x2QnxmYrmaeHrtEmcvJ6/qyjvgmHACgr64x3gHN/uEEZ+xb7KfoAjc10yh/yMoEjKA01APPSD2UnWpdV7LZMdcWFBfAYWIwmzH3JO3GbpPyGJ3nV9bfKx/CgXTzoctU4x8av8K53blxsvH4eR/ZTA+NXKNDpgON0WEbJPtjTbSPhdgylV9IL4vqfmbmcb/AOiA9WySMCuF48wHMZY2kADyomrqG0IjiNOfknM+oA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(396003)(136003)(366004)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(5660300002)(7416002)(2906002)(8936002)(4326008)(8676002)(316002)(66946007)(6916009)(66476007)(66556008)(38100700002)(41300700001)(6506007)(6666004)(52116002)(86362001)(33716001)(478600001)(38350700005)(83380400001)(6486002)(6512007)(26005)(9686003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BQLvgPqVnwCgkGPtqRlMXVTTDrESy3X9VXCQUe42wJ/z2SfjmJv5N7awvpLq?=
 =?us-ascii?Q?jExdGSnqxxl80wUVAvGjjArvflR5TkZCAdpuQJHsLzi1wLxE6H3QEgAf0zjn?=
 =?us-ascii?Q?68FgUS6N1XuPxOb+pQRGNf6K/nhkURzx86yOBRFXbagGaiqIOkG7wjMpfG7v?=
 =?us-ascii?Q?EF/BAdq1uk8EARZpknv3louooSxEuAF78uXW01EcSznnv5dy7eVJzrUo7m8E?=
 =?us-ascii?Q?kvmNcWb4lzV/IvE8frLXu+aH3gXlaKcpeFBtFPDLb5vx2eKByGk/jE5IOH+U?=
 =?us-ascii?Q?FfkALrkS++iE/y6JKjmCo0OMr/X8UYOV5aMEpLYbnENNq2to+vgBxBvcXXlY?=
 =?us-ascii?Q?Zr0kGysvpxSDo6RmuaUy+GgtaBekzV41q8qrtbFoIqWii2MsfoUw3YsQTA38?=
 =?us-ascii?Q?zdPHT4+4Wlg6JblsM91ZBNfz1b/1uZSwGv4hcJaaMcsso3FvpeZKRgW2Gs5A?=
 =?us-ascii?Q?qQuMRmeymlGn6a4c5RoF4/u0bCXLnMnGbuta2ksXUc/7cQNT5PyigjrVfAx7?=
 =?us-ascii?Q?b7Dwm7y9Hif7eFK+/++sDIH+JEe1TpF/c1pxvyszkVRaFSgLPC2PhROaBMBs?=
 =?us-ascii?Q?BvA+wf46WGDlP89yyAn9A3rwuM9M71doaKW/DFrgaKxHuCUFfivHTm4ObQV9?=
 =?us-ascii?Q?fLgkGlXXN2yuWS1YZB2+Xuzy2kAEqOQ3XQhELogQwyBI9q94/K64dgUnrbE7?=
 =?us-ascii?Q?fl1a0VKFPRERVGFVYWp9pk/ViAiGjwvQ4MCtuqn+wfu0w9j+7Ey/fJIeSW7F?=
 =?us-ascii?Q?rUXrKo5lxBBtAMcLan2yNtmuU1E5j3hdtnlzE5G0kXFWabGaEysClpdQ+5X/?=
 =?us-ascii?Q?IM+crlhZ28SaNDM1afWo/SlLgEqohsVidmuO67sbuiu/JGY4CjDvyTuJUGt8?=
 =?us-ascii?Q?WPiv4to7S9HarrfjNIYs88AzxeJGs4nT7wRJtVZZe7iUozHSI7Rc6UOR+QLN?=
 =?us-ascii?Q?05cZv/4WhnecGh6hcUb2yURPMWu6kpGYLT4EqIFVbCMubi87BRFQGMNKqj+N?=
 =?us-ascii?Q?J4No1eWcwn23nbnotLOMf56cCRDHhjeuCnxHwxRiQ6zl2uFwRNvKpZG5Hf24?=
 =?us-ascii?Q?xB330vAWmsFHZEo5F10z57UO1E+7VgrjVmQRBnT4OvYPgZZQjVbaJamlgNWf?=
 =?us-ascii?Q?CVUff9QjsJAAdR8qmvU+cnVE523ZKXYQRNnf8tAkqk9bgHcdGTfrlCsLX/ex?=
 =?us-ascii?Q?2Uy89kxhyR/Eh9GDE/C21xqKHqyMCQx3NHXmTEl9g+ZJr+9Rm4EfoZcy34oE?=
 =?us-ascii?Q?Mw/PWwkdh4Kxcky2BUOd+SbofFZGhLItadYK20ljp82UZmPE/rE4429QCY6f?=
 =?us-ascii?Q?XBuj/jwrz00++1xbpV+K0R5KhrZsoMiHrWsPUnu9a7op4t04HDTMs4ThZdB/?=
 =?us-ascii?Q?2DVTD5GVT4hHX8lQyMCvwqPPa38Q9vRLYCPVFIjB1Mtsgha4cF17cGISSdVH?=
 =?us-ascii?Q?m58EvXujHKNRN8DFB9Sf3BvcGXdlSQ/o+4xgtxQuW71sO7V6h0hInbFuaFmW?=
 =?us-ascii?Q?sqdpBeQ0yg0YcAyf9X3M4L/v8QVqyjZjmtDjO3BmWQUmh1IK9qgh9bP9v2ud?=
 =?us-ascii?Q?5rbgHAnU0PIM3mokjPE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23757cac-2bc8-4765-0fbe-08dbfbf1b1db
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 15:39:30.0914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bRgkBwFIpZfUMh73VzUOv7XGAm2PrJr/5R/oMFL+nRF4L+opRMnmtGc6r/V45jL6ylh6ufUkeZillFfqU5YCYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8829

On Wed, Dec 13, 2023 at 08:36:15AM -0600, Rob Herring wrote:
> On Tue, Dec 12, 2023 at 06:28:43PM -0500, Frank Li wrote:
> > On Tue, Dec 12, 2023 at 04:44:26PM -0600, Rob Herring wrote:
> > > On Mon, Dec 11, 2023 at 04:58:37PM -0500, Frank Li wrote:
> > > > From: Richard Zhu <hongxing.zhu@nxp.com>
> > > > 
> > > > Add i.MX95 PCIe "fsl,imx95-pcie" compatible string.
> > > > Add "atu" and "serdes" to reg-names.
> > > > 
> > > > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > > > ---
> > > > 
> > > > Notes:
> > > >     Change from v2 to v3
> > > >     - Remove krzy's ACK tag
> > > >     - Add condition check for imx95, which required more reg-names then old
> > > >     platform, so need Krzy review again,
> > > >     
> > > >     Change from v1 to v2
> > > >     - add Krzy's ACK tag
> > > > 
> > > >  .../bindings/pci/fsl,imx6q-pcie.yaml           | 18 ++++++++++++++++++
> > > >  1 file changed, 18 insertions(+)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> > > > index 81bbb8728f0f9..b8fcf8258f031 100644
> > > > --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> > > > +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> > > > @@ -29,6 +29,7 @@ properties:
> > > >        - fsl,imx8mq-pcie
> > > >        - fsl,imx8mm-pcie
> > > >        - fsl,imx8mp-pcie
> > > > +      - fsl,imx95-pcie
> > > >  
> > > >    reg:
> > > >      items:
> > > > @@ -90,6 +91,22 @@ required:
> > > >  allOf:
> > > >    - $ref: /schemas/pci/snps,dw-pcie.yaml#
> > > >    - $ref: /schemas/pci/fsl,imx6q-pcie-common.yaml#
> > > > +  - if:
> > > > +      properties:
> > > > +        compatible:
> > > > +          enum:
> > > > +            - fsl,imx95-pcie
> > > > +    then:
> > > > +      properties:
> > > > +        reg:
> > > > +          minItems: 4
> > > > +        reg-names:
> > > > +          items:
> > > > +            - const: dbi
> > > > +            - const: serdes
> > > 
> > > Did you test this? It should fail because 'serdes' would need to be 
> > > added to snps,dw-pcie.yaml.
> > 
> > I run "make dt_binding_check DT_SCHEMA_FILES=/pci/", no error report.
> 
> Only because you have no example. What about your actual .dts?

I see. 95 is quite new. Still have not good base yet.
I may just take take care this session.

> 
> > And PCIe function can work.
> > 
> > > 
> > > Is this really not a separate phy block?
> > 
> > This is misc block, which included phy and also include some registers
> > about SID for each PCI devices. I plan do it later.
> 
> Sounds like it should be a separate node and use the phy binding. Do it 
> correctly from the start, not later. Later is an ABI break.

Actually, I considerred phy binding. The major problem is LUT (look up
table) for MSI and SMMU. LUT need be config according to some PCI device
information. I have not find good hook for that at PHY driver.

> 
> What is SID?

Stream ID, each device master have SID, which pass to IOMMU and GIC ITS.

Frank

> 
> Rob

