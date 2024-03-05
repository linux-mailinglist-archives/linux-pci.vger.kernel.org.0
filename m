Return-Path: <linux-pci+bounces-4525-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BB88722AB
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 16:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20278285FB3
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 15:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351C18613F;
	Tue,  5 Mar 2024 15:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="H0OaTWwX"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2068.outbound.protection.outlook.com [40.107.104.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD201272BA;
	Tue,  5 Mar 2024 15:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709652348; cv=fail; b=fqTn+gjvQ6wxjEBhZFTeZBHVhgnicEF6uKip1u48nVgGge2HQyjHSf+wDp9g3JiTrxmOCESZNjgPpVUfVP8w1t0TYWaUWsshIMA+q8PRKGcdP9+13aR3BeEBu0x7X8gKkqrLYsNtj5I8awyGtdHyGY8q+MF4P/2afZymw1mKEWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709652348; c=relaxed/simple;
	bh=Scj/oC08TsrH291VU2nlcWgGwkM8l6wRJByIYeK4KNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p9I2V+/ZvIiW4HKYXkeLWftyEsvk7eewuwPVPCMb7mnuovoXfwdmDkVVCsoIn9jZM2m1cqglglSJIu/oCUB8djZPNCm5i//nbcZuBndZCfjSnSoKjj1dJ1hR+lPmgpJczDvQ46wRT6M3hnrvbYkSgUW2r4T0OWH/1t/ip9/tH2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=H0OaTWwX; arc=fail smtp.client-ip=40.107.104.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kykX96bGoLGJzjAjXB04lq9jVXF8hbXDSV2XHmg4TH4jKvZM/QU1fyjr9HNS6HX1y9S2wacOITKg+gBMHVR7pNTo15rHKyO45ujA/Hm/XlsexSlMqZ/PDxUoJpAkOWm8e5XK3CDsuDtzW+JjtyGOYAvl03uKY/dQbNT6MyILdtbD0zjYgG9VP8sHWglnPV+T7gF7QOSWMkT1lAs9n12+TjbAaCSRdePNr5jbYlrGoja7a34iPX4vZIPXxrgRIp/c6ys/KUnKTgi9DU5nG1hYjamaexgtxYOzG+/u1iNfnmOTEExqNQ/Sjy19+4E4rPevBNhkTZ+25ji+6YroN/BK0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Lu3Yq3WHP9lBduZQx5T0rJBjZnXhQSjas2i17+EXb4=;
 b=Pgk9JepzWFahjQuPWOJ+s4xt4Q/wKMUhgzEeLnrDvJeNLGXRQPcOFgA/ROJKr0m99hGvnYlsT8ScOCR9lyOyEjnCBNb4L/HfTDklydYs29ZYlLN9MKAR96nAYrOnMgCFxl3QABn0mupPbhcX50y1AYP7toa6XNQ794owvhSoMxFBV3O+79P2uloY0/qr+RTpWm6tzm76SQzV6moCLVZzIxU2eQyY0m0dfrlkI1SfUakcUwsL+LiM8Y/Nl+8vwtDIjpMiOIsurN18G98vpoWqdKFvZRS4j1YVomi+ugAsSq8TBtLV3H0mJB5Si2nlkljuyqmxipp0FKFiCwRiNDdh7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Lu3Yq3WHP9lBduZQx5T0rJBjZnXhQSjas2i17+EXb4=;
 b=H0OaTWwX76Ty4R9VeyTgIH0KJS7ylexYDDUzsm85ueSdHH5/+bPLM+1GcgiBgvdHy04Huv+G0H/GRKdGo7oByBMxvOYYzAHX8mTaO6Dpg9ueNPheKh9ns5YecyVNzvI5tDMcp+33uK66YYQLiXWL7Jf5VBE3vYHVfSkG7DUYUDg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7944.eurprd04.prod.outlook.com (2603:10a6:20b:28a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 15:25:41 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 15:25:41 +0000
Date: Tue, 5 Mar 2024 10:25:32 -0500
From: Frank Li <Frank.li@nxp.com>
To: Rob Herring <robh@kernel.org>
Cc: conor@kernel.org, bhelgaas@google.com, conor+dt@kernel.org,
	devicetree@vger.kernel.org, helgaas@kernel.org, imx@lists.linux.dev,
	krzysztof.kozlowski+dt@linaro.org, kw@linux.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	lpieralisi@kernel.org
Subject: Re: [PATCH v6 1/3] dt-bindings: pci: layerscape-pci: Convert to yaml
 format
Message-ID: <Zec5bAedt9n580xU@lizhi-Precision-Tower-5810>
References: <20240301162741.765524-1-Frank.Li@nxp.com>
 <20240301162741.765524-2-Frank.Li@nxp.com>
 <20240304173204.GA777171-robh@kernel.org>
 <ZeYJHLpHb0UGv8S+@lizhi-Precision-Tower-5810>
 <20240305144636.GB3310214-robh@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305144636.GB3310214-robh@kernel.org>
X-ClientProxiedBy: BYAPR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::22) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7944:EE_
X-MS-Office365-Filtering-Correlation-Id: b950ffb4-1c4b-4b17-3927-08dc3d2884bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ot7FQfErFEPZxxJKq/VgpXy68QRdESYZNmPV0wN9C815Ppocj2nim4v83sIdi9/6HlgL9LmVUrrulVTUutAaA3tdl8qzThuNr162xcfQSw8Fz4rhh6J5uYa0KYcFNI7Koj4wxVgH7EVvao+w0ngo56g3hUsPYlqpC4VWhKOB4o+vrzKVgg+EB/5M260P7kywlMQ1hmLLGSVrhQppGf3YSPidkzQ2Bppi5e2zDdQmTMaiVMDIkIBS9pRJlpZrlWcZb/e4dnVTKduQKH1rxl+jAGDZjKrMeX1pRrD+bsTuXrqQGuDEqB25xDkpFafm5TRFnXcZIwY+V7NgF/HvkD85wahvS8MFe6HalKtY1yNXla57bbxvIC2jJWheRHhCsoKKQchCvKzb0kncoJ3Lm3rZDnK0jSK0sIHOVptosxA89FkmeFAiwRcEwYPnzbo/+/aiR/RM1W688usNAkVIcP7KCeFgnXK8pPGN7MXhgH+LvA90ae0ONKD/u0nmozXoTSX01a7I/CrP91et2Sd93I/942gulw2SrlmxPbzhzkVd9bBWkE9CHM0bELfTJQFIfgfJ5whttTAy5WrTVYeP8LhYQPpAIhX1BR4f6NjHRcQVsXgb9HMVClN87IQ/brK6n1sZRQht6hxMHuBSGLrZkxYlKe/nqukeRQK5tS7YTBbML9I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?99Yx80RZO/fNAznenL0CPE3O6qAcbKzqY8NKCVp1fypXDith95d2PosoZllj?=
 =?us-ascii?Q?GwerhoH+aUZ8u596pYOZMqEIi/nQ7n3pSgsXO2yD6e1E/nz4yTVg04ueuK0R?=
 =?us-ascii?Q?nhTk9MMhRel7KPIFW9c1CbYMR3/vwUz0MtYT3JGttlLvbcT4u0YHQhUg5p7C?=
 =?us-ascii?Q?chtrkQY8DzPS1zSF3lFYOU2f8oMLY5tQnTNsQgeWyJjzKY6M76Mi0MXjiBgS?=
 =?us-ascii?Q?hyC5AVxFrc2jbwIxoL7IPrLdV0SmR1Wc69FkNSA9MIEW8SAXlOUVFRzH8NQk?=
 =?us-ascii?Q?qFdb2mYyBaXFOYyAHNaP9aWnf4q1Gd2kGx2QbtGC3KTrbbkGRkgdq52LlC67?=
 =?us-ascii?Q?rDt4jexwnxi63godxRhtojX0gT1e5WPNyScz10xgpypdOG+sKqbX9Kja3hMZ?=
 =?us-ascii?Q?za7TtghPbdiO8GgtrvLRGzFfJgenHa+0L180D1cOSUE5Ohq7UHBF0/A297nX?=
 =?us-ascii?Q?j0i6tXgP/0p/9SEGbM4jEq9EYE98z3FZkreHI9FEpmAxmoJZKImtT8b6wJYk?=
 =?us-ascii?Q?rEeY57IBtmUofjl4OfS5Rqya++t3D5BkqK/E3Lsd+3DfDY9/CLZ1+uDWK3b4?=
 =?us-ascii?Q?IX7hU7v6QgjJ4neZ8ComSvdAUeQWtWYZ5zJHj1yEvOcKAwm+DwJnvqJgyJFV?=
 =?us-ascii?Q?kojlcVQsGLmvy4SpMkOZkuJUbT49fUJKVLnsOh3DbLNfYGzYCQZQQsatF9tk?=
 =?us-ascii?Q?ngiypiIcbvuB3bde+NB0n4VTPsKCqtRaXwIMRY/kCMN/pbEY31l+5yMNFTJ2?=
 =?us-ascii?Q?u0AIZZkmZm0G/dUfP6AMjlO16AK3xhWDqnRxAFTFWbL+3bmYaRJuxCysjmY4?=
 =?us-ascii?Q?+merz0hkThv6gi7euu7VBkI8U6jjFCRK8qZjZOVuYzXFDflgKnbCUV0HFaMf?=
 =?us-ascii?Q?OPihOHkuUqkkp0Zx5J9CjuZxb8vP3OfGjOri13ujFrwe6Dy4YqjyCLTcOLvs?=
 =?us-ascii?Q?kZFsgijqAX6ujYRHr+rC7NtnRJE5pQ/ipUCq8wBQX3ZoOCbt1RkV/UCytac5?=
 =?us-ascii?Q?b8rYJw5PEMMn7IieeXDhbM817Q1u2V4l1lASN4GIAKnce4+Db2mW4NaXIlrM?=
 =?us-ascii?Q?3O+0At56MM6X7O0rrCBvF3LiQ+NTaFIjqNk54MH6gnSitM+8FMNSddcWwc9j?=
 =?us-ascii?Q?4XzLb3DMbg/HV67fXnyqjvueZAvh2RonZHkCMvjggVKcRDHHRpukw/tDqcOh?=
 =?us-ascii?Q?1tUfTAjpN9IVJ7S6cvyLmK+dE/mB3TbJvKjZhxp0sG6kS9+R0zEK0jhPrI+x?=
 =?us-ascii?Q?Q3tQLUdazAADFoy1cD0AIPytXZhnBGj4TEQprOINh0Z/BXFpTN7cwvGRyXeC?=
 =?us-ascii?Q?LHbTXv9Fx6jiaNynMGJbKx0KllUDmlQOF7JoxvN/8o4DKfqzegGDAqOE9C7G?=
 =?us-ascii?Q?Q0f8WEWB+DC8vsu5dJmSqAe2/hYSnLDGbZTcAzdfJIeAK/sU89lG9J6Da29v?=
 =?us-ascii?Q?SXIHk1m3zPqrcxtDqFkk1jmQPUdg5JmFsVw8cByxl/KgUESkhPJVdAAMtp8P?=
 =?us-ascii?Q?ArC4OeSLqnJk5cRi1gbfKObt9oSmlhLnJ+V5RwrHpvPl4RILwmzYFXnYoXFK?=
 =?us-ascii?Q?NT1BcRzjm4KFYf/+ueM2+lVUbxGlCVU/K5SyXchX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b950ffb4-1c4b-4b17-3927-08dc3d2884bb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 15:25:41.5618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DalP+UZ09NAGfC2HRHgVE8BDPWF5q1lhqcRJHTk0XtAbholXH4BC8jZARisDaB1bmaCnBFDnM4KuKvPwhiAz1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7944

On Tue, Mar 05, 2024 at 08:46:36AM -0600, Rob Herring wrote:
> On Mon, Mar 04, 2024 at 12:47:08PM -0500, Frank Li wrote:
> > On Mon, Mar 04, 2024 at 11:32:04AM -0600, Rob Herring wrote:
> > > On Fri, Mar 01, 2024 at 11:27:39AM -0500, Frank Li wrote:
> > > > Split layerscape-pci.txt into two yaml files: fsl,layerscape-pcie-ep.yaml
> > > > and fsl,layerscape-pcie.yaml.
> > > > yaml files contain the same content as the original txt file.
> > > > 
> > > > Do below changes to pass dtb_binding check:
> > > > - Remove dma-coherent and fsl,pcie-scfg because not every SOC need it.
> > > 
> > > You mean 'remove from required' right? Because they are still here.
> > > 
> > > > - Set unevaluatedProperties to true in fsl,layerscape-pcie.yaml.
> > > 
> > > Sorry, but that's not acceptable either. You need the $ref's in this 
> > > patch.
> > 
> > 
> > Rob:
> > 
> > If I squash this 3 patches, it will match most your comments. And will back
> > to my previous v3's patches, 
> > https://lore.kernel.org/imx/20240214194145.2669744-1-Frank.Li@nxp.com/
> 
> Plus our review comments I hope...
> 
> > 
> > Bjorn Helgaas suggest split to patches:
> > https://lore.kernel.org/imx/20240226210842.GA211190@bhelgaas/
> > 
> > First one will be equal to origial txt, then add change base on that.
> > 
> > I need a clear direction before I continue on this.
> 
> Bjorn's suggestion doesn't work. I think it was confused in that you 
> said you were 'adding' things. You aren't adding things, just fixing 
> things to make the validation pass.
> 
> If you want to split things, you could add reg and/or interrupt names to 
> the common schema first. And then add Layerscape schemas. But don't add 
> things you turn around and remove in the very next patch. I think 
> Krzysztof told you the very same thing.

@Bjorn:
	Do you agree squash these 3 patches?  I don't want to split again.
I prefer focus on the real value things. It is not difficult to review at
one patches. Origianl txt actaully relately simple. 

Frank

> 
> Rob

