Return-Path: <linux-pci+bounces-4471-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2DF870A29
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 20:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B96DFB2440A
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 19:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460FD7993F;
	Mon,  4 Mar 2024 19:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GVU5coQF"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2046.outbound.protection.outlook.com [40.107.241.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FAF78B64;
	Mon,  4 Mar 2024 19:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709579458; cv=fail; b=Yti689bGHeouYeW2jh3Al3hopmTrIJbpOXvh3hrL3AUxz49pAmFwGMQC/dgwLdac1C6D+ZSw7UvvDxFFfCdBbM2fmNsZ+ve5OF443mv22qFJBxHC739rgxE/yZwX673CheRw8Z42q3MhybOhK9/JMUWgxTEickVaZz1Xd1nLERU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709579458; c=relaxed/simple;
	bh=6+qRhp/NeveD6YSVuDHYHOj/dwoz+KAZEPb6uY46or4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gY6vPndn9IdpAMAgRP7Y5hH4lGI8L+DCEVEKQteEeI2REmwlqCbWJ6tYtyG7Kw8NNJNpj3kB+DHpTCN26u4foi8I5tnEYncL6dNYlOrXnoPyvC0t+50VmuzVkvwD1kk0nKShCEu4G+UAS6qqHOHXyhoNL2hdqPn/r5UdsQKtbmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=GVU5coQF; arc=fail smtp.client-ip=40.107.241.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NgeREYIGNerZYu0rTvrMxg7a1bc8eMUb3sU7B2GLfzFSx8EiDS4o21CW7tKZypmaeTT5u4LFSXUUhFxe5CKji8Ry60ZpZKK/eOvddxByUxMGmIquVvIyxRKo8azdOGt0Gz6uoe47QCqrwL1bvcoFiwEh7QQbKIuwrQRn1XKclZl7Y1ZVl+yPY/TARejMYTW06bI9bUWqPJ76OsglnkC9lzlnG2VFMwg3iYWRRDnDmHfnC82e1lCCMq6df1TldsJ23m4q6bJ2zwq4CgBqAwBdtJptigBMebnPAtCkCZInVLa93nBqH0BNCADo9GzO1Wr2aOAJwlZXgD0gsRiGwRT9Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KHSM9zsBiC0QQBthF32eKc209XXWp6eGz9qyyHYHfCU=;
 b=dctbScjnxm1HRramlSFLI/LNQrfhzI2PAh+en3KfNDGDIrtNGaTHdVh6abq58mPmhjCkySucotnv9E/MTgrg4yB60DoDa9BDAkhA1TnP9QroNPsvHvtjJcb2fuF67yMDLZVXQGto0FjLjkNfV4hgn6+cDDcPS4dKMMkhFxrckRmoCoiXlmGwHeqCI2gbkfN5rCwtlI31UTgKDnIpco7OLWGUSngx5QMr/IAmNt6ygbPvm08XRpRzVjXXuC5pn3d1z2YegW/2UeSlFe3keoyKOd7V3nOtA0asFPhICRJFxFRURQjCGlsWVUVMhg/1Rfkc648iPqRNgSqdXEh7/ybMBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KHSM9zsBiC0QQBthF32eKc209XXWp6eGz9qyyHYHfCU=;
 b=GVU5coQF8Vpq3JPypd6XVCoYrQsKS49x2VTZIOpsgAH0AVsL8jZyJ3hQaUp+xrGU4xKQskBkgyySTRut10UBmoBu+wYlPNE2VBtqR2lt/NQEb1vduE9S7Nm7EjRk+gTZFeVpqafPukYAKYyWl+22PoLM/E1rjjTtQ+OhxEPlB78=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9357.eurprd04.prod.outlook.com (2603:10a6:20b:4dd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.37; Mon, 4 Mar
 2024 19:10:53 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7339.033; Mon, 4 Mar 2024
 19:10:53 +0000
Date: Mon, 4 Mar 2024 14:10:45 -0500
From: Frank Li <Frank.li@nxp.com>
To: Rob Herring <robh@kernel.org>
Cc: conor@kernel.org, bhelgaas@google.com, conor+dt@kernel.org,
	devicetree@vger.kernel.org, helgaas@kernel.org, imx@lists.linux.dev,
	krzysztof.kozlowski+dt@linaro.org, kw@linux.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	lpieralisi@kernel.org
Subject: Re: [PATCH v6 2/3] dt-bindings: pci: layerscape-pci: Add
 snps,dw-pcie.yaml reference
Message-ID: <ZeYctf4ftmp21fqK@lizhi-Precision-Tower-5810>
References: <20240301162741.765524-1-Frank.Li@nxp.com>
 <20240301162741.765524-3-Frank.Li@nxp.com>
 <20240304181758.GA803086-robh@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304181758.GA803086-robh@kernel.org>
X-ClientProxiedBy: BY3PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::11) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS1PR04MB9357:EE_
X-MS-Office365-Filtering-Correlation-Id: bb12f016-2b26-40d9-361f-08dc3c7ecfbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wPKr8+7xm6POHpqDsDAGbDsJnjHdGSpnxBv44ajPCfs1EUDbd8y3T66asxCkqqM0vDBU5tBOyT4U4bl9TUelq0BreldJAF4mYixNNcUieNQCnr+a76qiEDHXIY0JqmQsc826IHbBvRYkIPVEWPJqAT/vGFpWr2gm5OUbpham85A9sMJ+Pu6XOSLnO7Vv2hN/k1UFbgwSQOl2PkSMAOrESBD0K77qdtw9Y1DREEfDT/IlS1f5o+D/kafxHcXJ77Y0tvAxikxOlPbixXqNe2J5seZ4R2joBmGBRL/qEnjF7fE+Vtsbm3Psw7ArZD0d8dmu/78CF3ss4VQtY6yst0YSQ3AhI0XRvrc8QEHSd8LN4OPxdID3RaTwRn45yC+j0ILgP6NIwTj4e51Lwzw27V41oeN/AVz4AKMrV5Bevc1/bL+iDzWVlPUk+QlmkSVmlZNACdJ/pW1jkIdpQmeWhHVBBCCEFYAv57R3U3VMteiTGC8L9M1GiN2Glr8xcUY7GfCpcQ+9vbFkuPm3JnbLCD7hK4YphCSdIgCjSIHxp3rDLvJWIZ1ZyPCQ8YW/qwWcm6lmvtQN9lyE5BXBBDjuh6c1e90Iw74LA0sLlmsXv8ecvM0zIz3Voho1crNiU8sRV2iModJnRDEgjKoiLK+StbwdiJLojBWL6XHuElufzBSQmSA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7tnGlzB4pKYAIX0zpvxtSLEtC0w4jTkmk+GTdkwsSYqdMRYZHKA3tE0ubsg7?=
 =?us-ascii?Q?+vNlFjLCagERIwcBU60G+1VQNqbzsklUxDsBTdVrVIbfch/PlUpB8lY7xF6T?=
 =?us-ascii?Q?AP0F0SQpLs4utK2DnB7iNeg0+hbsg4WRnrcnlTU8BpHy6zKHUFl2tjyPOS4S?=
 =?us-ascii?Q?P21BdQ/rYHOWAbSe37TT+U4/C6ZboakOU9wNrm0FQ+peZ1HYt1fBYlngxXnY?=
 =?us-ascii?Q?fOlEQUt8Tn58N69Zw/Qv7MCZY4D4ov5uVVBLR+CBjPOdVJ1977QZcR/J4XJ0?=
 =?us-ascii?Q?DlU3oE4h6nievDnSBbdvI+ZfsL2E6I3Xaei9VH2+aAggWOahnzTcoSPRTZBQ?=
 =?us-ascii?Q?WXD6MRBS8oImYtmfHbff92sJJj5zab2OIHLiaUr1ZqlIRcEJRmDJ6T2cVdHb?=
 =?us-ascii?Q?/5qawqu5NRqm1g+wYukcAsGMJvwqoHfJfQMPgZo71dF73WF9paXKiQy1sIzS?=
 =?us-ascii?Q?Uf0375+iRKtp8FPG8HMk69ct9pTHc9tRfHfwKUzoc7icgeJPe1AIcMGnTL+o?=
 =?us-ascii?Q?afJJbSvdyTepB+204robfI6L29coXKtU77ia8reuPrJvSFP7aC9gfBLiWr57?=
 =?us-ascii?Q?nlvO0vXPFzL7JoNPlebBaJHGHX56koA8H5PVnUtsEfj9NCm9qeCNmABWFfTo?=
 =?us-ascii?Q?9BWF/SuvMdju1G5RoNqXecYgyDA28FAdDcpFnPXD5TzOyG4S9/SaVDTByK5Y?=
 =?us-ascii?Q?k0ztqVNKwD93OS/7ufuzPxFu9pgExCj3wKa0XQQRlBmt4jtKLbsw/ReNfgxp?=
 =?us-ascii?Q?N32A3lhjyVU0WJGGn1sBmEQbG0TAgnxJfqs6+kCqKaGTq1HvEysvtwaqRAIM?=
 =?us-ascii?Q?1RPL8kF6kc2MrEs75Dy2z77Do8A1tqHlIAixWWHJ8Xp3oM9h/tJigdpaHykU?=
 =?us-ascii?Q?2IyQcImjZ7qB5uDWaVyQrEfQVAZqyrS0iy3fWedmVqwxxeQ6v9IBcahv260L?=
 =?us-ascii?Q?s9XR/CYtIcbJdcKd74l57j4jrSTscKwHGg8n+XRHo3kUBrntF62JvdzTKP3D?=
 =?us-ascii?Q?rXA+OuyiahwDt8UIt09oiLlMGn/iMBq75pUZ6ZIRq6wmxRB37hd5mfjgYF3a?=
 =?us-ascii?Q?QLvWzU4jlfgaGucYvARlxb8I9U3822+IE8MDisoZMw/6T/y82gtGOAKS29t2?=
 =?us-ascii?Q?KvDlbO74+g8uL9ChGf5ufrqpZSBKpUjf0bKuQ+7bzZEjzd44cilPJMO+X/TF?=
 =?us-ascii?Q?i6HPH7v8RYY2Q0uCwZnRPTFF/0d6g9OfGzpaAAsW79jVAM6ymvkbAmDQEcn9?=
 =?us-ascii?Q?VATljYeDCIIfkcJRT8aXIQWWv78HgFIxviNxtVXglHPOvW5R00/7Ru15whKr?=
 =?us-ascii?Q?vox791R2jCofQRI9X+3DURV8FUErFvAzoGxqx+TlCVkiTHfJAg/kVvBxC5F5?=
 =?us-ascii?Q?3GAVacpEGddMAOsgRoEft/4lB2+MY8JFlLhunDTjpz9igvsZD7vEwOpniiKv?=
 =?us-ascii?Q?CD63uxRbCnDB98o9EuWAbJLXzvBSMtrbcuL6uawpLJxKHhyHqwwhm6+VsejP?=
 =?us-ascii?Q?U9ercH3ggIOuJrkkus/AhQt9/EEIXNqnd2rCG1FU8pov+2d6ZVWQ/l14dzsK?=
 =?us-ascii?Q?68E2RAWN1Qt3ArR63NEmwg34Ilsqo5pydisSPiTO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb12f016-2b26-40d9-361f-08dc3c7ecfbe
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 19:10:53.0745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iEtlsCVAg/0Wpnpk2ySzBQDNVK7Fp32X8JfJC9JDT+6pWzk3KB9W+pEBbaSfgDtGU8Ao1W8Yq25CdteiTfPgtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9357

On Mon, Mar 04, 2024 at 12:17:58PM -0600, Rob Herring wrote:
> On Fri, Mar 01, 2024 at 11:27:40AM -0500, Frank Li wrote:
> > Add snps,dw-pcie.yaml reference. Clean up all context that already exist in
> > snps,dw-pcie.yaml. Update interrupt-names requirement for difference
> > compatible string.
> > 
> > Set 'unevaluatedProperties' back to 'false'.
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  .../bindings/pci/fsl,layerscape-pcie.yaml     | 104 +++++++++++++-----
> >  1 file changed, 78 insertions(+), 26 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
> > index 3f2d058701d22..137cc17933a4b 100644
> > --- a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
> > +++ b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
> > @@ -11,7 +11,6 @@ maintainers:
> >  
> >  description:
> >    This PCIe RC controller is based on the Synopsys DesignWare PCIe IP
> > -  and thus inherits all the common properties defined in snps,dw-pcie.yaml.
> >  
> >    This controller derives its clocks from the Reset Configuration Word (RCW)
> >    which is used to describe the PLL settings at the time of chip-reset.
> > @@ -36,31 +35,18 @@ properties:
> >        - fsl,lx2160a-pcie
> >  
> >    reg:
> > -    description: base addresses and lengths of the PCIe controller register blocks.
> > +    maxItems: 2
> > +
> > +  reg-names:
> > +    maxItems: 2
> 
> Need to define what the entries are. You change 'regs' to 'dbi' in the 
> example. Was that an error in the example or are you planning on 
> changing it in dts files? Besides the latter being an ABI change, I 
> don't think you want to change dts files for platforms which are pretty 
> stable.

It is on my plan.
https://lore.kernel.org/linux-pci/20240229194559.709182-1-Frank.Li@nxp.com/

Need change driver first, then change dts. 

It still need maintainance, even it is stable.

Frank 

> 
> >    interrupts:
> > -    description: A list of interrupt outputs of the controller. Must contain an
> > -      entry for each entry in the interrupt-names property.
> > +    minItems: 1
> > +    maxItems: 3
> >  
> >    interrupt-names:
> >      minItems: 1
> >      maxItems: 3
> > -    description: It could include the following entries.
> > -    items:
> > -      oneOf:
> > -        - description:
> > -            Used for interrupt line which reports AER events when
> > -            non MSI/MSI-X/INTx mode is used.
> > -          const: aer
> > -        - description:
> > -            Used for interrupt line which reports PME events when
> > -            non MSI/MSI-X/INTx mode is used.
> > -          const: pme
> > -        - description:
> > -            Used for SoCs(like ls2080a, lx2160a, ls2080a, ls2088a, ls1088a)
> > -            which has a single interrupt line for miscellaneous controller
> > -            events(could include AER and PME events).
> > -          const: intr
> >  
> >    fsl,pcie-scfg:
> >      $ref: /schemas/types.yaml#/definitions/phandle
> > @@ -69,23 +55,88 @@ properties:
> >        The second entry is the physical PCIe controller index starting from '0'.
> >        This is used to get SCFG PEXN registers
> >  
> > -  dma-coherent:
> > -    description: Indicates that the hardware IP block can ensure the coherency
> > -      of the data transferred from/to the IP block. This can avoid the software
> > -      cache flush/invalid actions, and improve the performance significantly
> > +  dma-coherent: true
> 
> No need to list.
> 
> > +
> > +  msi-parent: true
> > +
> > +  iommu-map: true
> >  
> >    big-endian:
> >      $ref: /schemas/types.yaml#/definitions/flag
> >      description: If the PEX_LUT and PF register block is in big-endian, specify
> >        this property.
> >  
> > -unevaluatedProperties: true
> > +unevaluatedProperties: false
> >  
> >  required:
> >    - compatible
> >    - reg
> >    - interrupt-names
> >  
> > +allOf:
> > +  - $ref: /schemas/pci/pci-bus.yaml#
> 
> That's already referenced in the common schema.
> 
> > +  - $ref: /schemas/pci/snps,dw-pcie.yaml#
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          enum:
> > +            - fsl,lx2160a-pcie
> > +    then:
> > +      properties:
> > +        interrupts:
> > +          maxItems: 3
> 
> max is already 3.
> 
> minItems: 3
> 
> > +        interrupt-names:
> > +          items:
> > +            - const: pme
> > +            - const: aer
> > +            - const: intr
> 
> I guess since you figured out the ordering here, you should keep them 
> despite what I said in the first patch.
> 
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          enum:
> > +            - fsl,ls1028a-pcie
> > +            - fsl,ls1046a-pcie
> > +            - fsl,ls1043a-pcie
> > +            - fsl,ls1012a-pcie
> > +    then:
> > +      properties:
> > +        interrupts:
> > +          maxItems: 2
> 
> minItems: 2
> maxItems: 2
> 
> > +        interrupt-names:
> > +          items:
> > +            - const: pme
> > +            - const: aer
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          enum:
> > +            - fsl,ls2080a-pcie
> > +            - fsl,ls2085a-pcie
> > +            - fsl,ls2088a-pcie
> > +            - fsl,ls1021a-pcie
> > +    then:
> > +      properties:
> > +        interrupts:
> > +          maxItems: 1
> > +        interrupt-names:
> > +          items:
> > +            - const: intr
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          enum:
> > +            - fsl,ls1088a-pcie
> > +    then:
> > +      properties:
> > +        interrupts:
> > +          maxItems: 1
> > +        interrupt-names:
> > +          items:
> > +            - const: aer
> > +
> >  examples:
> >    - |
> >      #include <dt-bindings/interrupt-controller/arm-gic.h>
> > @@ -98,7 +149,7 @@ examples:
> >          compatible = "fsl,ls1088a-pcie";
> >          reg = <0x00 0x03400000 0x0 0x00100000>, /* controller registers */
> >              <0x20 0x00000000 0x0 0x00002000>; /* configuration space */
> > -        reg-names = "regs", "config";
> > +        reg-names = "dbi", "config";
> >          interrupts = <0 108 IRQ_TYPE_LEVEL_HIGH>; /* aer interrupt */
> >          interrupt-names = "aer";
> >          #address-cells = <3>;
> > @@ -116,6 +167,7 @@ examples:
> >                          <0000 0 0 3 &gic 0 0 0 111 IRQ_TYPE_LEVEL_HIGH>,
> >                          <0000 0 0 4 &gic 0 0 0 112 IRQ_TYPE_LEVEL_HIGH>;
> >          iommu-map = <0 &smmu 0 1>; /* Fixed-up by bootloader */
> > +        msi-map = <0 &its 0 1>; /* Fixed-up by bootloader */
> >        };
> >      };
> >  ...
> > -- 
> > 2.34.1
> > 

