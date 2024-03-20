Return-Path: <linux-pci+bounces-4963-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE95881353
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 15:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 330AC1F22D6B
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 14:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53F043179;
	Wed, 20 Mar 2024 14:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cLkUBHR0"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2053.outbound.protection.outlook.com [40.107.249.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9388482C1;
	Wed, 20 Mar 2024 14:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710944997; cv=fail; b=VrPCt75ScUagnNitkQQLXjfDRlAhjD6zb9PtfynCwYstl3WmY4fsgsOD+YE7N6gDuz2Z7RE5Q1guvO5MgqmymFSI7JayTrdGazJw8nIm4M/ffsCzRhf5OP+DQScvjAu62jjvUHHp1rLo8fLjzEnbRQsALPv63hr2H75NZ1eHaS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710944997; c=relaxed/simple;
	bh=i5XwtktC0FPQNxT5wPoyqotBBwNAAWZlWS630MiptWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=M5xIYMvt1Uyrkl7K7y6yTChsPXdBL8uC6HQcRW2UCIJ/A4785eiLfjTrD0yULt54qbb0dgsYF572jW8Dxv+CJHUGzwjgMNN+0ufnd961PQOSiml7b3V4rjugVYDgAUK2sMnzV4bQeoeUGHt1VPBf3NIuN2K7OG197VIHxMwP8xY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=cLkUBHR0; arc=fail smtp.client-ip=40.107.249.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YBDQ77oc1HcXMN3v29i1da4P42e3IPx7+szzQA5LXzI1offK6FLfaP3+CNSt/z8oCsWBEPdyG9zgUG2fwKdqcE2VsEmw/eqivEdDjFWsKDw/sjoy5T84QB7+O91V9l7d64qRZqbrRWW9clqGAzRMqZklhmFofYfgRAVGVq9K7yRNwqi+cD3xTJIxao+SJ9/mKEaSz4Qb7JvKxaxpCRSwj2EmTO/WU5bJMhT/ltGcJK2m3QH/YWxOJR7kKJdGS6UWf/ahLDEJLBBFP2KC44HKpQhDTk8aQ4fARwojLl77MUvKeRhRFSAGMW9Ly4ZzG6CWtR39jK47DnQNTwmfgQl3Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rdJAhrancm6lhETOvDNNgyeFu25wpNqvu6S6YnPpz1c=;
 b=OmsTq87WGfUZE+J8SFdu92WMy+RflUDsakyJmlJNuLTLJ88roEbAxvVEqCN9i8lhfjriFL+V3qUhgOGHJIeqVONM0C6z6RiKzVZ++oeINIc1WCSuCqAV5ysHdqWpu4zR08avY1nuel8Jv4pxXzpMVXOp174Sv87FmjVAf4uzXYGdmnpEl8cTxeHgKqJYkgCg+z1B0kU0l2w2lWFJxciTMRMXAgWRnsJ2C069rpnQw7LSYajHOZT5ssYSU3WKngCrvjWWlKoPKUEbmhjnxlCdMUrIOoun7MNTPYYfABHwtV84AjDAdHPgD8cDEr/xU/H+m+1Sk/U10Up/tiTZg7PwkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdJAhrancm6lhETOvDNNgyeFu25wpNqvu6S6YnPpz1c=;
 b=cLkUBHR0sT5hIfx08eV1kbcPreZahgDc1dW/9lzWz+xeDDQXKff0rYIfNyVza6hb5J6397EW9M46qNM5ArSibbp7/thtdpskcnH5jQoiBXedQPPhSq3dE+IiidCWuU1e9TrRRyCgIzpzRG1nd9LWEDZavo6ZuK+zVui6+/71tPg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8145.eurprd04.prod.outlook.com (2603:10a6:20b:3e1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.31; Wed, 20 Mar
 2024 14:29:53 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 14:29:53 +0000
Date: Wed, 20 Mar 2024 10:29:42 -0400
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: mani@kernel.org, kw@linux.com, niklas.cassel@wdc.com,
	bhelgaas@google.com, gustavo.pimentel@synopsys.com,
	imx@lists.linux.dev, jdmason@kudzu.us, jingoohan1@gmail.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	lpieralisi@kernel.org, robh@kernel.org
Subject: Re: [PATCH v2 1/1] PCI: dwc: Fix index 0 incorrectly being
 interpreted as a free ATU slot
Message-ID: <Zfry1kaYgg2OBvQL@lizhi-Precision-Tower-5810>
References: <20240304224616.1238966-1-Frank.Li@nxp.com>
 <ZfGJUDoGnFXKBoG0@ryzen>
 <Zfqj-mvpG442eyt2@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zfqj-mvpG442eyt2@ryzen>
X-ClientProxiedBy: BYAPR07CA0063.namprd07.prod.outlook.com
 (2603:10b6:a03:60::40) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8145:EE_
X-MS-Office365-Filtering-Correlation-Id: 09aec101-754d-4c2f-3adb-08dc48ea353f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xBXj0qmkf7F0zeY4RZ7IZinyX3leIWz2GpL4WIl4MYk9gsL9Xe0U4QqVmJROq+rKdJbn5O8JQYMeq/alA/slPKgIZUOhFhmaRGo8CCIgHXjXE2evn96wPTQ9gegFPlm8c3ODAF9inSpjsqg4T40oR+5u+6b0qtP9/CiOQuJpyc2AeBO3E26UyFOHQwSp/opew/l9BpfGBPxTQhFwyU0paxYy7eQzTJ9pWqA2+5lzIpX1nuiZG4226EK+Th78HeS3ijZRCwzoAiLrj+jQlrjZ8VUuqAtVvaXyy2FrJJ8EaeodsaG18Tn5LE3Jn23h8w7UtWxnLcH3QUXtJLTIdRbyZSazzOQkV443jIYh8/9ASupTE2uggiqnepGJKKM8Mq93YkqKCf9TZc0VyWdA6OsG+5yqoz/r67GhjVu6iY1NXxDi1huchhtXyARgJKASve05I5ckzqymg8hTaX6KwK83AsiN2cnAFPWpMaAuCqfu4zEgfjP0AWo5cXjdMAlMiK9AiPr/SdhzFlThdlTV7WGYC0cyfPiP4lTF2oH2zB97Iqp8xx1jO1l3rbb3xhnSndORQdvO7Ua96NEXF/ajsVimjXednedKRNVwUcJKAMmWLGolkpJXbBC1igI6emTrNKXAH+PyEODMuY0waIx6+smt172AtTa1ZfHQnpwVCIQKK08=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(52116005)(7416005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SxkR1hEnemM6uR7tR1AcnL894jx+Y/xX66XsIBrhD/nydS3V+Omw5qTEhqXy?=
 =?us-ascii?Q?J3ZA1u3n0O445IUMX9GcQrLlV6Ic4M2In79Z7bB5Gvf6XU1oUDi6pdJRtHbU?=
 =?us-ascii?Q?M9gEuOM8P4WDAFf+W4VWJddrQPP7GWdWuP58qZDlxoxvPm4xtRYjOWGKdfRF?=
 =?us-ascii?Q?Fz3R573F0cv/JMoUDguq6fL3jc3lCDP/NKldPsQsGnSmglj2vrt7sPdFJJFU?=
 =?us-ascii?Q?FjGqE+0eV9ZfNVfpi1bo8s+kBTgxor2Q+x0qekH0rGIBzrt9Oi3JSSqjDc7N?=
 =?us-ascii?Q?b915CJ7Mu+akevOQbgmhJqR5+mHh/LYeWA6LdzGub1fp/T7DHldU+etB4jCp?=
 =?us-ascii?Q?DN1aZaJfy3qFQIl3XsfJnRqEqV+Q5NbALLKPEc7qwiiUwxDcIgTwm/h0/7cz?=
 =?us-ascii?Q?6MsleHJiLqNLLM6pFNJSWnFvHF3DtQ/ftxrDHbYzFFhBv7k5ea6u4UvJxTB5?=
 =?us-ascii?Q?UJ0Q4aMnNFnHWofQvai+pqLGhs4tKZ7MO+cSt1k7n4PTlos9aWT1Tr/+DD8p?=
 =?us-ascii?Q?tdONL1Sl8wTO9Uu+52EGFcDMQK/9HTCv97FRHjffRUFzSjgYag1q9v/YGGq7?=
 =?us-ascii?Q?JYb5Pkq5sEk1HSmi0p5a8cmor9gygBZcECWw6zlT18Ezjx6V2y5huFcVZrGe?=
 =?us-ascii?Q?5ZbAXlnLQxQPcLuUtKcSGLVQo2/UTykAh/tbIVX4wfwLe4yVjrPOFwf+l/to?=
 =?us-ascii?Q?fc2Ty+wW7IGaRH9EoDHfBKMgoCqlZgCkpzQ13NEYl9ILbt5v7sWEaNZ7bQL6?=
 =?us-ascii?Q?ymXThl+puGvCGb3QrfZNSogY1aFOET8LfdCLx4otMrXoZFDXzuCgt9FoO5ml?=
 =?us-ascii?Q?KbX5qkJ1ITeCu3lv5v1xqHGvG1ViBi7HiepOM6cBbiBSczsg402ssLYt7vFu?=
 =?us-ascii?Q?LcKiDLITdR8K0MVlaWA9aFBW928Vb198d53SreYwJychJuqoNVA7lknhmFKE?=
 =?us-ascii?Q?tii9r3gEXhxDUTMh1hyLg+HbL5ytP4dEQgPcBZs24+pxyEdOpfRdvmY9YYLi?=
 =?us-ascii?Q?ZxOoMzy4i8Y4BegEUNgyA91c13rXrIByoRG3eTfczbWRK1KF77EGdPVnZ6Sf?=
 =?us-ascii?Q?YK/pND8KKQ69UI2I15x1G+UO5AhmZbJqTd/m3o0CaNNXwKuF7Kt+j60D2qO2?=
 =?us-ascii?Q?vZcza139KhbA1puMLlSsiwKO+FCIykPZe4Mdb6w5tfzbO/rLSP61+R5BKXW5?=
 =?us-ascii?Q?srse4F0ZkwspXTvXRw+NwTpEe/ok+MI23cE75o8KjRqoeyozH1dxc7dY2Am3?=
 =?us-ascii?Q?YXB8YD4uti39iKzAlIn7QuP8/hcaiPV+2vd7LqbNA8a5LMDstSkWkSymWT3R?=
 =?us-ascii?Q?Y5FdTfal8YAzSvxD2b54ox/wVHELtlkz+TovY86nIL7s/nBXU+lEo/oKl1C2?=
 =?us-ascii?Q?I9KyiLmvQxvrV68LqcZKhb3StXvWrkSSLgyg4z54/VC/2rMjR4VkACKEzCdA?=
 =?us-ascii?Q?+iZkfaE/wVXrt4+Fyt9tWTeVDw3yeIqoUghsuMdypb5AkMjPORurMHCKFS3V?=
 =?us-ascii?Q?jlKoXD3a1Fa72l+ctFdHEAE1ET9uy3HHcNg1mFiE5oIiIFP+qQ6ZSYnUsJYL?=
 =?us-ascii?Q?ekvsOfBJhROQTWbuItKmOKaSggMrDzrHIESASTWt?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09aec101-754d-4c2f-3adb-08dc48ea353f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 14:29:53.3634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ph0yRNbor3S5e9nY+7U7LWjdi9GWZjfGKFP5fd2O5jIMU0+ZsS/diayqjEsOMgCEJ40UMWHLv3oksTe2CdJXZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8145

On Wed, Mar 20, 2024 at 09:53:14AM +0100, Niklas Cassel wrote:
> On Wed, Mar 13, 2024 at 12:09:04PM +0100, Niklas Cassel wrote:
> > On Mon, Mar 04, 2024 at 05:46:16PM -0500, Frank Li wrote:
> > > dw_pcie_ep_inbound_atu()
> > > {
> > > 	...
> > > 	if (!ep->bar_to_atu[bar])
> > > 		free_win = find_first_zero_bit(ep->ib_window_map, pci->num_ib_windows);
> > > 	else
> > > 		free_win = ep->bar_to_atu[bar];
> > > 	...
> > > }
> > > 
> > > The atu index 0 is valid case for atu number. The find_first_zero_bit()
> > > will return 6 when second time call into this function if atu is 0. Suppose
> > > it should use branch 'free_win = ep->bar_to_atu[bar]'.
> > > 
> > > Change 'bar_to_atu' to free_win + 1. Initialize bar_to_atu as 0 to indicate
> > > it have not allocate atu to the bar.
> > > 
> > > Reported-by: Niklas Cassel <Niklas.Cassel@wdc.com>
> > > Closes: https://lore.kernel.org/linux-pci/ZXt2A+Fusfz3luQV@x1-carbon/T/#u
> > > Fixes: 4284c88fff0e ("PCI: designware-ep: Allow pci_epc_set_bar() update inbound map address")
> > > Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > 
> > Any chance of this fix being picked up?
> 
> Gentle ping.

Now it is v6.9 merge windows. You'd better ping two weeks after linus
create v6.9-rc1 tag.

Frank

> 
> 
> Kind regards,
> Niklas

