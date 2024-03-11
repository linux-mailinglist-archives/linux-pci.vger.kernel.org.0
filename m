Return-Path: <linux-pci+bounces-4714-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F908779F2
	for <lists+linux-pci@lfdr.de>; Mon, 11 Mar 2024 04:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60426281807
	for <lists+linux-pci@lfdr.de>; Mon, 11 Mar 2024 03:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B14B110A;
	Mon, 11 Mar 2024 03:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ixl21rif"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2065.outbound.protection.outlook.com [40.107.104.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F6810E5;
	Mon, 11 Mar 2024 03:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710126517; cv=fail; b=KPUeCWazVHuTsmZhWf89WvaIYkF9gp76Z/wFaTKBLm47KZFIgdBZYgmye0a38bvJzBDsbJTboXfrMwne6H+rlimI/WgWoJEIKSCohn6EVtFr/45mZombNKwBBIPGFfedQQfHcRHHRc/4ZyebBROIjC911ywcXfrEPMBm1APwbQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710126517; c=relaxed/simple;
	bh=ZVdknrVOsb5ypImYOxua+RqbiXzpXOjMsDJDciOrMAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=e8YuTZWF4v4tmhvWOp4lyLC5TGIztXYCMFCZ9q6/RKeGPW4eQOU8faXezn1cvce307f4JMGWL8hQj65bSAle0/yCY/HkZstIKdJQcbwcMixxnhSUPii2kd81dsBe+7B8Rtke2VWqPrHPn5i/CMStul/4d1dwYfRbH5nTg7s3eDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ixl21rif; arc=fail smtp.client-ip=40.107.104.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GCX9m37cyW+aJz32TmHlt4NbnALfg3h7gP14xRoLMnvoWv9pfHTkeZqIQZVpCwZ18nXiZqCRrSHftD/HdzMpv8w3Kzp4tPEhj0ihdYnBdyHUcd3iOTIp8KbHVmwOuh4Dk7LLoVF77BHlNkjlvvw6A3cdYhmW4dPV0NbcVIfZijZ7I6ptQLx59l0BMkbglaRriOWMUwH0GW3pw03voFNiDVAtcl+Eb3PKJCbyARygrkAM0M82mZI7kCy8Mz2/e9NHyHTI8HQze12kkfGN99s6VO320vJL6PzN6A4P0IOV6PK8lAZ3JjQ95QpSOfFhL97BduEzCcr12HtJiv4XXty6zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VjmihL9bTx0Zp0eC1tF2pQDurkcnaIktkG/e4ain57c=;
 b=K7V1CuU1/eQOYJWyeGDsEfJ1o5roEk0P5C4l93VGtj7jlRDCDZg2xDDhiDhZkRroxb+2TNo/jLeEQqeeLTvexxVgPahjp0EQMIToWmBcna0w2PToSMHdMymnZOeIuX0Lyzx983rkXS2VaZ4LlcuRq7+BlYCWXo9f2eERYalHtdEUopEOUOeTg8PqHN4c7iK4SROPPbLgQQHlYKNO+TI/vIAXIxC9WqloBfkAmoM82qqdBFXbEKXCfZF470kIE+fOvjcKCiZ+z2j7YCVB0T8ZNRKcR5J/5l8ufymfX0lPdgfaGHkOd7x3lF6fzTzlliMENBd3NMt+wrPQVNbaM90q5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VjmihL9bTx0Zp0eC1tF2pQDurkcnaIktkG/e4ain57c=;
 b=ixl21rifbz7Wso7jfjMS4LtL2S2CO4qqTvUJo4+wiQZu2Xy3bYjO0edATfiNUCZMCjV9YomjS63oXTO4/TDKuHCZBxCeg2/BFOiT/Z5gKEnA6rJtP21Ipb3mllRbwQoKi2P0ns1etbnHpaGjfOGmVByO1ytjA1q45oXYj0ItAg0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7395.eurprd04.prod.outlook.com (2603:10a6:20b:1c4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 03:08:32 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7362.031; Mon, 11 Mar 2024
 03:08:31 +0000
Date: Sun, 10 Mar 2024 23:08:24 -0400
From: Frank Li <Frank.li@nxp.com>
To: Rob Herring <robh@kernel.org>, bhelgaas@google.com
Cc: conor@kernel.org, bhelgaas@google.com, conor+dt@kernel.org,
	devicetree@vger.kernel.org, helgaas@kernel.org, imx@lists.linux.dev,
	krzysztof.kozlowski+dt@linaro.org, kw@linux.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	lpieralisi@kernel.org
Subject: Re: [PATCH v6 1/3] dt-bindings: pci: layerscape-pci: Convert to yaml
 format
Message-ID: <Ze51qOjL3r0Y3Mqe@lizhi-Precision-Tower-5810>
References: <20240301162741.765524-1-Frank.Li@nxp.com>
 <20240301162741.765524-2-Frank.Li@nxp.com>
 <20240304173204.GA777171-robh@kernel.org>
 <ZeYJHLpHb0UGv8S+@lizhi-Precision-Tower-5810>
 <20240305144636.GB3310214-robh@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305144636.GB3310214-robh@kernel.org>
X-ClientProxiedBy: SJ0PR13CA0112.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7395:EE_
X-MS-Office365-Filtering-Correlation-Id: 737df0a9-8a1d-4c30-4f7a-08dc41788822
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qbaUXuiOoOZF4aGxmH6X+mYygSRIgKRbW7LxTljY6dpN47yWEBA3D2T3E7AWsRzR7qq5U0W2UlwQ6X+9pgIGqZp/X+ImT7IAui/yROiX3XvC37ci85S6oFpKDuwcDWzIX2XeAHV/PrIfSJG1I6qijGeyh/eUvpwjs+Siednh3mW9TOJxdycW49myCHKWZUw9cWGlciXkYZNKSAMdLOSQ1tRDVEc1XXWNWYE1Yw3WYlJDSVPJ/+2M7nKIDa2t7TGTy42b0Jt0d2PHOhCJwxfaRSSlCoBA/ChAkRTJejum/jotE49/udC7NbLP+BE/QlOOJzBXmnTTE8Rv6cbVucnNusAWsVwmO2EZ03AIM+h2DY+fIs/nZYb5Sww7L2jcTNEW4MbBgRvZ+AtQ4HxIr5P2iMT06WG8dgGiFQE+B4C1k4o0PWU+dlYy8Ymj0f+0N9Oh8hm+rJo+t8ObSoq/EhAL+BYxHIYUtOF4coKnoY/PdiIAfWghIOfEon8vbeUKXAW1ZareFsWDm1/YSyVkrKlAYoaGXLk7oeB9qIZGCj5H9Svex9RFC9MzxtN8bvmmT+xKK26zcYaoWslmclddpS09HbHcEwepDJrFYXWwfvIANS79GpWxQwSxnAP8GYlptO8wjBbwnDrB1veQvhDWy0GfvGR/5Maq54KUBsfAdRmo/dw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(376005)(7416005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yEzVKp4opL84OWI2smX8AgER+BDoF7zkqpzm0VdrFyUxXFJZ1fpNseCL/nI2?=
 =?us-ascii?Q?xPeEVSMBvkjFgEDERl+8+5oIk3k/5gKr1y/KWa0Ni+EspEgm19j1UvFvwO9k?=
 =?us-ascii?Q?ixHuEXAOU96Lr1LkIQWkAoOFd7Y2a660odC9lKF9uunNC0VLEI4Vw6Q1zmlW?=
 =?us-ascii?Q?K1fh5pYpetb06dtvsMv1JEhycYq2E1YXkSxmyPxiIlscKkgCh1AtUQ9cF+X6?=
 =?us-ascii?Q?pTzHsHH0XbSv3jKUfpWW6lpRr3kdQiV1rHo0HEJ20NtOrLypirqox2FFFLJR?=
 =?us-ascii?Q?kejLaFuyNsdX9brpP7UvTJJHFYUDT4Zg9kyfwDaLj4Thdols1f3UIp8JuOgl?=
 =?us-ascii?Q?YBRkSAD7vNNIqgSDKfL7XhBUECwuvG+cV60W0WHx0GdSizFsweXvtMOLKQUK?=
 =?us-ascii?Q?lNnVeQxrMz9eupZ+N1VWf/7jNk/3WBUlEn37jK8hF+OpjES8zrHCJ+eoPPNg?=
 =?us-ascii?Q?b/E6GWb1oseaD0C5DPUziidy3Mp2fz113LFf79ARPrL4qw3pqyIbkX1l6unq?=
 =?us-ascii?Q?D4nKPCLubpdTsVuAJL3C8nDWIHd7GiHuI3MJmQv1b9zr6QDk3KT/bHZZt1sU?=
 =?us-ascii?Q?+UGoZbk1z8+/eSRKkurfZ58bHZXLoFGhgvV7lLhNn0rl6wJ3KpVh/24SWCC+?=
 =?us-ascii?Q?0VMX3PbA3WQeh8sXSKZHoi3W5xEeI+L0n1hp8Qxde8ZJxrfnBHY0P3bU8eNv?=
 =?us-ascii?Q?pcmnHLyDYNvmD4ihcjAALxEadlEv0w32QZQhLerJqCxFzVSyZOfg88hF2nhc?=
 =?us-ascii?Q?THwyb0GqLI7mgUD2TfW/antcbg1QglKlAUAuNWkA4nUtfa8cHhwQ1fuHJlhY?=
 =?us-ascii?Q?lWWIwg0W19UjPOV1GE7hkrbvRTLQSR/WNboYcBeppz2Je/qsMdl7o+vmLrvm?=
 =?us-ascii?Q?JRFmmJUFcH5A/dk0df/O+6sQG8HO2w7wvzDxeQaBL+N7I+Iq/DhVZY2j4EYB?=
 =?us-ascii?Q?yHWaGWQIdeQ+U30MRx/18HQvFXU+EI4qsDfw/TVPgDo62I/9/ju2uvrNyHUN?=
 =?us-ascii?Q?V6GVqmr3Tsl28L42Z1L/+Ok7oZBjHi4CBfIPLbs5tBgBlpQK3DD5h/LZlzGz?=
 =?us-ascii?Q?em/r7zJjRr7ipUbVQgnjoYaeY1ZRUe97Jnjk3fApvEsHPiTR4qZHoyeAtMjZ?=
 =?us-ascii?Q?PHNfaCCEwsbayMDF+wM2+7XgE53eHmiZccWXYwCXYhUpS/9wwdtX+u2cWXcs?=
 =?us-ascii?Q?FPoblFAIq2xPLbQg5frH2wyYhA2jxQHfCQXRUcISUjcLnQOHdlcib1+82ThO?=
 =?us-ascii?Q?Yp2M+Uy4HgoIIv+Q+EPmBjUwbFJ6esSstDw4l3GqvFJ19FclDY2yJL46+Eyw?=
 =?us-ascii?Q?mfEPLtKBmp4ZROkB+FWoFoZph4dEyp0GvQ6f8Oe1SnLknlEaWzBlg3h2ykfV?=
 =?us-ascii?Q?vX6tv0Fu0rLY+hO4iK6gkFhhbzf/eTQO+MhISFz3XmsSUS57q0xJw/EB78Fz?=
 =?us-ascii?Q?SG0RWBPpE/wm50mMz6MRat5uTWEPOFtuOrjsCWsFMPO39eF7Ad3pk6Tan4rR?=
 =?us-ascii?Q?CMF9AiVApa4DyTA4oX8ZlEIrOPkpigx2orqQYOuiH0qbiy0DbbgwA6k+COfy?=
 =?us-ascii?Q?uGkrzzd0VWxZiiVX0e0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 737df0a9-8a1d-4c30-4f7a-08dc41788822
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 03:08:31.6708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cB50UeWtubYLBM35AGHs07cUSBYcGR76VJ62IuTjT3TWL+q2N/LH87U0ssGARBrbSjsFDni3HHzAdNypwfo98g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7395

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

   Do you agree on square 3 patch to one or others? All dt-binding scheme
have to pass dt_check. Rob and conor already take many time to review this
patches. 

Frank 


> 
> Rob

