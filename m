Return-Path: <linux-pci+bounces-4271-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F9F86D108
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 18:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44B951F262D2
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 17:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289D27580C;
	Thu, 29 Feb 2024 17:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SsiFGOR2"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2087.outbound.protection.outlook.com [40.107.241.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F67757FF;
	Thu, 29 Feb 2024 17:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709228623; cv=fail; b=hCNVY3kkkgZW5+rFias1dMP1P4yOVJKjSHL7lgSH1PYwhndyk/xc5MuBzw1jrEJsHO2jINoSBNYA+L/ZbcoO6ek2uHNq/Z7aKtAAdF9JPJT7gPP9Rws6sfW3m2LDEp87tv3poTozG2LUNEJ2cQWCNoZ/ytbj8d7M5aKkExnMVRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709228623; c=relaxed/simple;
	bh=maP21Ezm2/XfJ/tFu8fPZQk+xZexIjHWbTOIgxkzSO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KfaPkdW+WJqdDmt1sR8UPQFP731DOcvYb6pQVU/BrHfQcyw63pDobzspXa9PbRzy7iYVmlMfXRanqrgqfIROawB15i7jtQPeY1W8Sb9Qon0e1LF4GSQMwx65T1gA9/2ZyzaeNMXF2nGfWrE/lLEMUVe1jjWiFwmt9uo10FrPHW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=SsiFGOR2; arc=fail smtp.client-ip=40.107.241.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ab70ZCfOGeM2nb7hcN19ib/ZBUUBPpH1bJzQWRgTfLOPb77KZ4oZvUr+vhW/2teXGq8N8NRETUI5qbC0gro1I7mD3JGcmIlErvTDpchW0oYgSpXwbx/TnGt2sTCJLCZWJ6vJELEIteHwTMIQ59tOADqRgDxVReq1JvDjCt5Xml4F5AW6xMBx1wjr3SEJ/u8b+XiXlSeFy7EzaqGOjDroQwFuUS0T5/KLZqETTkKWsrWpqQ4qzABlM1umYxv+w8njUx82YRXtHiLAuGm/0ZoUKAQtzF8xdo/enoveEpv/vJ34ZsvmxjFXIKzCY0oMc5Bzf+/Kt9pbqFKXoD/upfBWBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pT/UC6dPamG5FpUFBEUauSWjzphMO9Y9Q1gJeC2YDmc=;
 b=POz4E5PBptNRd/4x6jVAF+8xY/BcQBgL+ifrrSFKmfdDiYBLqpljbUshppdkY4ka907f8rpoZ/qD6BkB07aCJ7ueVHmc2/rOBtwn0JRB14/J3bVHCiaRTffpkUVd0BQEkUdFC2yysuz3kxm4SgsUJ0IIrnx556L03tql9nlACjJU0BhoCBZuIelSoS+p2d+cC0lCBb5jsoJDX9UzL+88RHH8uqy8mEDFV0AFrNo6/YRD6pwdieregcKg2T2f9T3TRAmAhQ+V8peEgsncNBNkb9c+cQxdtniNfNIKVe151hbXAKeWoXf/jijFZ7DHYbLKaYkt0LPIGJswfLpxUQotWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pT/UC6dPamG5FpUFBEUauSWjzphMO9Y9Q1gJeC2YDmc=;
 b=SsiFGOR2ueCKqilWCErz/Ymnnw/B0rDOnX8tjbfZQNLqVQdXl4NvCf59CFluDZ9BCmx4Ef2Tj8Q772DCQFsuyO5qRjUh1iF8J8ZHgVuA+GIeMDlb0S9E7A9uYl9wn6dmZFnxgDqXf96mgx30H57qWOjuKw/e1jutWY3Z956jy6w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9431.eurprd04.prod.outlook.com (2603:10a6:20b:4d9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Thu, 29 Feb
 2024 17:43:37 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Thu, 29 Feb 2024
 17:43:37 +0000
Date: Thu, 29 Feb 2024 12:43:29 -0500
From: Frank Li <Frank.li@nxp.com>
To: Rob Herring <robh@kernel.org>
Cc: imx@lists.linux.dev, conor@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, kw@linux.com,
	linux-kernel@vger.kernel.org, conor+dt@kernel.org,
	linux-pci@vger.kernel.org, lpieralisi@kernel.org,
	helgaas@kernel.org, bhelgaas@google.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 1/5] dt-bindings: pci: layerscape-pci: Convert to yaml
 format
Message-ID: <ZeDCQezI2zj8bWBP@lizhi-Precision-Tower-5810>
References: <20240228190321.580846-1-Frank.Li@nxp.com>
 <20240228190321.580846-2-Frank.Li@nxp.com>
 <170915420970.759733.12998246565079147606.robh@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170915420970.759733.12998246565079147606.robh@kernel.org>
X-ClientProxiedBy: BYAPR21CA0024.namprd21.prod.outlook.com
 (2603:10b6:a03:114::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS1PR04MB9431:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fead627-d32d-4e24-d0c5-08dc394df596
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5W31R0xHCcCptFQDI8Im/it0Zc5OIUjj8SVZNxNsqF1u7Nc/sKOLw6nyrNYXn9KdVPUWkII6p/2zA1sw2/gx6iJU5VvhMK7b0s48TpEkYhtgpSu+1ra/yX+VX0sFwB2BUbkBiQO0WJWMNIE/yMl3csiyAy9IljPKChjKuYWToyvO0apXyBJA7/2LI5pdTfyG1bofB49ozIm1t6w4bVvMTCUDfafME9RGIFuOMMIGJ77eeuqITRhMeo/DyAPgeJqpwxM69R3U+TTqmVn59dFDEFHnnI+JTnA8gGbX9kkeoMPj5uEj3UZY6QUuMs0BMZMyQWQSt8rNOWLCh1NQ0gBf9w9ExfQ73RV/QodKdKAHo9dbtFCRQPQviz9W7Ic2SqA4ARDch8SThIHy3sZz8pePdwf7ktpKj7zXfpuYjFGCVSdQ51oCV46iMS2cfSg0GP7LBgL21aaqWMYGTW/3FMJNXFr8rWvkI6/0PabcGI11iW36/PQ0ASunewQxh7wsp4y5FoZDp3N4OcDUgh4PHJAyw8gjEiZ8H+GChAi4JKIw4nU1byG5Avt87F6cr+ZcpBhu02DP9aU5b1hwBFIzf+yRk4nSUeJQQP0UKqEI8AdFXXtUql71whwPmA4APHX3pXEKbBG+6XGMBWKZ8aOusqWBXeZbby4c4xAY12/igevSEsk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/u4Ledh7U+0H7dVOhMuY/waTD9OFUKOgLgbTVYXsAv2FE2nD1hiEVvB4dBfG?=
 =?us-ascii?Q?N3Edtx7BkUiuHlBfvfN0i0YfP+GF3e+cJx9oPbOaCaRbVGJ7qEXy8R0ldytg?=
 =?us-ascii?Q?L4iLmuZ3TBZ79tmw01fW6Aka2TBb/ls4VAD2T3ANIi6w0ZsquWz7orOcQMon?=
 =?us-ascii?Q?qu7GYuxFji2CFA1eG1cWqfm6ASH9SA23MSE7dc9cAf0Xe1tGPJ/+eMoMQTyI?=
 =?us-ascii?Q?ZW4AWIMeH12IApRFQ5t7PZ9Yl+qZJaExEOBHuWVu6EUnINw49uQ58PXxVlxI?=
 =?us-ascii?Q?7ZNhuWR0ZM4c6fij/KhOcFZynNqjfR5WfWUOgqLCbWATh8OTawns5a3ag5Nn?=
 =?us-ascii?Q?PBVVL+6UvTW/EBruyabmydFFh2H1dmPLptV6MWEiCU/FkdA6aMxn3NkSGBzY?=
 =?us-ascii?Q?UJr1X6kzG9U/5H3bnG32XQlt7cBpU+AH+qNfSQAFIWq18OZSQ2Xjh5AobDPc?=
 =?us-ascii?Q?VL9tks/RPHJjF+tBkxjHVwIn8onYpS6Vmfm8GCyHML3JtpbTB1tF1y2BMIqw?=
 =?us-ascii?Q?ImWC7pflmCD9iS0t83ks8H9ZFhowlKuDgoG/EuVlnUZ7cFJwxsIKNavjse0d?=
 =?us-ascii?Q?Lq2TmQIvRGrYfWCy3MMkIm8KJBQq1aW5a1AMLXH85Jn/TmlcirfUIG/bdkJR?=
 =?us-ascii?Q?q7xvJvtRhCJ8IvdDy/YNATONRmUYXMhLBY7VbXq09GhT82s8gofHszJu1nTd?=
 =?us-ascii?Q?/B7nGO5fNsXJs4ZBG/0feXWipehTGlTeenyNOCtcVP+RBEbkSuuIhPXF1AO4?=
 =?us-ascii?Q?zrLfIPSfYl+1fQnZSz0qCd6mODm97tpA6Fx3hWf6H/56n1c8dQuyN163xKv5?=
 =?us-ascii?Q?jEBoFmUTjAZuxX20GEJYxnzJQ9C5QVbbkS8TczB7Me0++cG5wIHLD+WneFmG?=
 =?us-ascii?Q?Qz9NZ56Q1H0fZ3D9Vu1cwFInPDXAWg7joMPlYGrE8EV/neU4IDqYrGBHHiC9?=
 =?us-ascii?Q?sp8j9qXELggm4xAcEqrWgIghJH9t3QL4LdaTFcdolWqyKWsK1tC1PBeWmIlA?=
 =?us-ascii?Q?tAZQeEHuh1nsdvNDdgpN9NG40s5bKX5hLUUehP3EHVCCH5KHY+uExRzDBHNb?=
 =?us-ascii?Q?ltol2xaIbImR1CH1E6KewQ6pmWTWVPKEl05KcZ9MSinS4YGoh1m5vMxQ9FX/?=
 =?us-ascii?Q?Ppe8p2+3azXVo/fELnSbz+AbyFXvL6WGpX1D0fRGejbBLUQdeXyxksFFO/7d?=
 =?us-ascii?Q?uZVvTo238WFqIiiu0sOgkCMEi69SWyRteHoRUudePpQa98W0OQvyDSd8G5Kf?=
 =?us-ascii?Q?Aa2OWxTLBfrMTlKLfr/7QdPWCdmBKlNBeW64zvZ9aTUR4OmVcY90Tp2ViBQr?=
 =?us-ascii?Q?QeEqPlwi1xk/hxCVLYnH7FtNM7Rrs3YCXuWOIvxmF7lmAEqoTxjDlHyPUd3t?=
 =?us-ascii?Q?y8mAH+7B38FdUG03K+XSJNdSqj7p/YOYosh5TlKu742zZiFnboCXD2mh2C3f?=
 =?us-ascii?Q?bVgHk/xJGnTO++EnjM9lH9v44LotHM9mvt6CHg3eWRoaPqnqoSS6mQCHsxiY?=
 =?us-ascii?Q?Zva99E5p4LRH/d2j4Wt8jZXEbjC7TP3Yi5r+L/oeMQ9IDs4gyNIhXhje4nL2?=
 =?us-ascii?Q?ArY5J8+5GWaxa9cufJ8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fead627-d32d-4e24-d0c5-08dc394df596
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 17:43:37.7877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3JbJg255O4DxxkfBwhICIY80OUXOLJF9+1DUkByDyvuVBJqMtZunSWRfF7clED9s6ZcyvIUl2cPnmuXhrxXd6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9431

On Wed, Feb 28, 2024 at 03:03:31PM -0600, Rob Herring wrote:
> 
> On Wed, 28 Feb 2024 14:03:17 -0500, Frank Li wrote:
> > Split layerscape-pci.txt into two yaml files: fsl,layerscape-pcie-ep.yaml
> > and fsl,layerscape-pcie.yaml.
> > yaml files contain the same content as the original txt file.
> > 
> > The subsequent commit will fix DTB_CHECK failure.
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  .../bindings/pci/fsl,layerscape-pcie-ep.yaml  |  89 +++++++++++++
> >  .../bindings/pci/fsl,layerscape-pcie.yaml     | 123 ++++++++++++++++++
> >  .../bindings/pci/layerscape-pci.txt           |  79 -----------
> >  3 files changed, 212 insertions(+), 79 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
> >  create mode 100644 Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/pci/layerscape-pci.txt
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):

Please omit these errors. Bjorn require create a identical version as
old txt file.

Origial txt will cause DTB_CHECK error. The problem will be fixed at next
patches.

> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.example.dtb: pcie@3400000: Unevaluated properties are not allowed ('#address-cells', '#interrupt-cells', '#size-cells', 'bus-range', 'device_type', 'interrupt-map', 'interrupt-map-mask', 'iommu-map', 'msi-parent', 'ranges', 'reg-names' were unexpected)
> 	from schema $id: http://devicetree.org/schemas/pci/fsl,layerscape-pcie.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.example.dtb: pcie@3400000: 'fsl,pcie-scfg' is a required property
> 	from schema $id: http://devicetree.org/schemas/pci/fsl,layerscape-pcie.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.example.dtb: pcie@3400000: 'dma-coherence' is a required property
> 	from schema $id: http://devicetree.org/schemas/pci/fsl,layerscape-pcie.yaml#
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240228190321.580846-2-Frank.Li@nxp.com
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
> 

