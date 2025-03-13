Return-Path: <linux-pci+bounces-23648-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6C2A5F88B
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 15:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6767519C52E6
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 14:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8118B26981A;
	Thu, 13 Mar 2025 14:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="T80oYpon"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2071.outbound.protection.outlook.com [40.107.104.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB99269828;
	Thu, 13 Mar 2025 14:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741876361; cv=fail; b=eajHW8Xd/jKq/1T3bUSRiARPhPN2Rwkip6BwMBlmC4+C76VKyC2BwVSYWeNnQl4BBLPEzWyByhpeb7kN7e7xIfcR3aRdRKHGjf1ffw+B35b15FkO8R2DcxBKE7hxxDPu8r5NH6RN6WqG/x6WvdgZK17tWMjqsFw/a+eHZaiVGj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741876361; c=relaxed/simple;
	bh=4V5PmmtmU0/sbaHqOFUDNhyLVQWF8CLZ9+5TrVq1r+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QvyVkaF4bfmgt5K8z2uKvJ8XQTUgkpzF9mvyJEMHeFfKtQhirEqKGF1N9MZHdeN/zaMOp49WN49g2sQOj5FRi74MgjzVbnnlMZdQL5LJCDScd2xRRCnn254jQrJdTXzytGF9DMXzWCNbPEICbUcA2jpqFd6YsdA2mvnIAPdR1Qk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=T80oYpon; arc=fail smtp.client-ip=40.107.104.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZUsbCbQY+eLlArzWrhbOYx7cWflhkOtM0or9ZUDBihYbGwLT8wocuRexMRmBTfMvX7IfWGwFBP+ZGik/cngtf+HQ1cOitzfiGc3rWXiqMjQKYWT5bhFbExXvnxq7wtC34p5tV9xkFnxMsEJ9/hhScTMWFikxauULfldYv7siEGWwBj2tKzVQo0gzt3jOoWWa1oXZDj9QVJAd1hGjHZMRqFrv0u1APurLqEKstXmmna1wXMiFws+7ZaCsvfoP0pCBbidhncea/tDrer96qiM/UGrus+rL9OseF4JWR1E/tiLuz+a1TIMfOeG6OypiHf/NSoPaRYm45i3S1FEtgDL28A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZJkgQI94KfeDVRYPUVT8yYEAms0TrowHW+1jxb91tg=;
 b=lQudJF2WQuLdZYIlwT+sBs382Ih6qejP6wpK1paKeUUtyopuOzXRSLuU2S35uTJGuDEp+vvNVkxqmLYgJSLPU64fQzNV+a3V9dWLth2hP4pwCa7TrRj4JeciZHFAcCDWB55svlkoMUEMbFFATkg2A/ruslHFZkjy++EaK9wwJldnwrj1oMnaOzLRPpbhEktPgdwShu/eheP486GJwIC9dt8EmROlJL7M6sgP0unR5PEXuepEWYKTp9MZ2GUU9/0VVvfwNFWKp302xPHtjC/yxVZVW9bVWwCwqrwKOBqb+csgAw/D7b2r8wDUYttyyhap7XiZcyE0a2GQHj2MEplflg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZJkgQI94KfeDVRYPUVT8yYEAms0TrowHW+1jxb91tg=;
 b=T80oYponAa8M+M5vWHyIBrv6DRyQO4GBOj783+UHytBxSTb81lXOWvM86VWeebY7QgduJcnxxpOVu+khDbDoRZ+GaRcEPD+OCmDs+PSwm00jnC3NzTunHbfXTkh5NBFR4befl6wGKw7/CZPp6oLtCmOIjoUZ4Zn0xRKrsO8fZZTypF4bbSpeBXwXO+I8HU13YcyNOuBgJnC7dXQpFkeUgwo+MVRJx2XiAIgA5kldRE0Y/423ij/4oeg+X+0j6XzIwPnUNadNdG7pfWzQR2QTiEb4q7sHbAy2ginbLSTNDqlTjorL4lmQFsMrr6xopNzHELNUFcBwPtS6h8b0l5apqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI2PR04MB10644.eurprd04.prod.outlook.com (2603:10a6:800:276::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 14:32:33 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 14:32:32 +0000
Date: Thu, 13 Mar 2025 10:32:20 -0400
From: Frank Li <Frank.li@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v10 08/10] PCI: dwc: Print warning message when
 cpu_addr_fixup() exists
Message-ID: <Z9LsdEmMiRvRopKS@lizhi-Precision-Tower-5810>
References: <20250310-pci_fixup_addr-v10-8-409dafc950d1@nxp.com>
 <20250312220424.GA711004@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312220424.GA711004@bhelgaas>
X-ClientProxiedBy: SJ0PR05CA0040.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::15) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI2PR04MB10644:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d548534-ba28-4bc5-3055-08dd623be3aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?USwjK23cv/I3s5kEGT8chTvD9Lbi5MqxqOkRBdCFNaO7dgAi3lXbtPhQWuef?=
 =?us-ascii?Q?0byMJwiIfA2EqvIXbT0soPpAF3tR2E0n5i9mEeoaRMc73zAUX/jLoqRZwsNa?=
 =?us-ascii?Q?EH7Bftb9/3bxZocOHSsFRyb4cl4HZ1vhN6Cwk7r7+hB8Va9xB8SMiBw+Zvjf?=
 =?us-ascii?Q?s8YEOj4xGuT+qAQGN/KGZNx9k5dyk7dVVxiboC+tVVJ0C/SadmTft1ea+LQ3?=
 =?us-ascii?Q?7jVpF7xDpLS9lcAaX5sDFklvQw7KN1k+aBzpzP0pKe5IPxsV3hx76tq3NXEO?=
 =?us-ascii?Q?5SJ8n4ceRFyDpSS0XM7XHORsSaxDc9y3ICGeRRsoOJlExi41halUIlSCGeZW?=
 =?us-ascii?Q?l+zcrwOZB+80NVltCs4kpwx0BaWq5Cys5SVzgcD6JgrxQzlRM1bAbieKYjnb?=
 =?us-ascii?Q?PMYPdz08ZDXKbO4VxggsFHjOSd1/WRVH6tBaBw9WqDD9NcmhSxZkMtBlBH0S?=
 =?us-ascii?Q?a6nIgiBC2hn0L/tXmX3djM4AE6WLVNmVeaxeswBi89ZX7uWnT6fACUjgsyUp?=
 =?us-ascii?Q?Xf6KB1aigEZmAm8jJJVJAvM5WveztleGtsrphnQbn1hAAARsQzbPz1sZg3z2?=
 =?us-ascii?Q?DZ+oVVcSJkkbQDoGaLRLV+/KDvAWiFgH3n1PmNTJjhVvmtvGFrEp1676vNQA?=
 =?us-ascii?Q?NuLz8s5LBt5OjnF452RNKTYHO+Q+v6dlA2v9Qx1+An3QZTU0fVTiw9FmXSGl?=
 =?us-ascii?Q?1vHBjThy1xHYyWAeETcqvgsyN8LQcBP68wYX0nQAIPUX0ryNoqscl8p5anig?=
 =?us-ascii?Q?xOa4Bxn7xZsQ4iuTNedZg9XObZ4VEOozAC2lzQ9aEsmfoF6oGH8te+1rYW2K?=
 =?us-ascii?Q?FvbU7oGaQpoyfpxcKq32IkAy7e0LOwKRgDjn4ta8m+0WICbFD8S2rkzSEUCn?=
 =?us-ascii?Q?A/JgdC3Oqf9jFR3o8kL6fbOXEZvUWX3nHgB5oeEXCTGOAjSUbRmNlh/B46kO?=
 =?us-ascii?Q?mkZJPzloPuNq22k/sXa5U7OvmLDPVyJ+Z125mnj7FBe37103GLWdR+ufntU+?=
 =?us-ascii?Q?QLnfJ/ZtFWexpcpGXFIFHArr8gkBWW2PalxS8UpIkZlH8tyGszA32f4WiI28?=
 =?us-ascii?Q?oUMGC23a0Jkk5REQXfKrLBDIeXtLVIiUf5cQD60SMbqUYLBrETVfuu8xPgkB?=
 =?us-ascii?Q?AA3Mem/fHMewzDFV1Mn9LAO/BLR9J1LTTBzoGZNLz8bfPE8jfbENRRwo3/Q1?=
 =?us-ascii?Q?BrtEfAc58RAnlkGpHVM4Uc8t2kafpYFgrQktHprPRYXV4v6h3rtSYq3S3bUH?=
 =?us-ascii?Q?yQoi/OZQdCpBR/TZMg1Ie6UQDM3b/BGCEoY884T+cgnDvZW0c30HnsS1/Sj4?=
 =?us-ascii?Q?2X60G2gc4ZDFismAwken0N08P9NvvPlV9rtib2nq4eNxnCiQjcKQsaP0yVLo?=
 =?us-ascii?Q?SeSLruUMMuOy1v86fs32Y1uH6Tgnt7IS2UEvJknEqWZbrEj5UvwQ+ap/fg85?=
 =?us-ascii?Q?vCjshWEQxl4lnpin/bCdTL2t9YmJxoU9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XjJYgjtX9r9/mPdegIQeEaV+I2Bx0L+buPIYJVwPBCdksA7nMTwhpLoSGpWC?=
 =?us-ascii?Q?mHI9mG/bzhLSUwZh5Udui0B8KXBGgxNQCA/w0iVBHG0Cr0qeutLC93Ay7G17?=
 =?us-ascii?Q?+sOuE4H8AiXJf/1y9KvycqMmHV3OBkqd95iIZng7uanf4BqgoTlkDhKkSpdJ?=
 =?us-ascii?Q?6i/bQ3fhqwzgvs2s2OVA3tFjgTtQOJ05v1v1iD9Xe1VTwdmtcVWbIC2xK94O?=
 =?us-ascii?Q?wJm3SM8s+3Iiso6nzAF+cdBS8PdV+WluhyCXAzjsuRu+BIlTuYVf3MKq92R8?=
 =?us-ascii?Q?NhCNUgGkOBfj7enhXfnlR5T7pvYbLh+3HIIGjc+eQiw78QxLiEgmSUvewF8Y?=
 =?us-ascii?Q?e5kS1Yq93pUGv00bbWt7YyUl/rHMbnM++zdFY3OYf8U0UbBN3oK0hJZVcb2Z?=
 =?us-ascii?Q?D2m6qpTZJlnh3tlxXCn22LxM5JLH9hF6wulBnOoqW9LgJ08KRlBjldRmw2Nc?=
 =?us-ascii?Q?ujQlTj3doFNyrTGzg+PJbpUpo+VWOTarnVFd7a5Blp13DSN6vhYqqxPDkOeE?=
 =?us-ascii?Q?lpT63mkM7uK5ldkbfidLMGBlu4dTkbLbZlpwiVmkvMbN0jO0LMRs43ATs/N0?=
 =?us-ascii?Q?oOGVR1iCtWBzYMs/z3tOA2FHgQN+hD/PHbv+bkXU1N/FxunbVKQ8nMCKShNy?=
 =?us-ascii?Q?geeVu97fZhL1/R1ATiqK26jOrIbF0Xp2sCrs5yAbsjTODqSTA1mw5jw3Wd99?=
 =?us-ascii?Q?6FCtNV8VEao2Ox9tauyAckbyq19ywvZ1bJkY7Tq+MeczZEvfNQsZDEtbHmL6?=
 =?us-ascii?Q?/260mPYFT+FnbV097T3jXGKetTRiGIKxzyLrjnjCli2lUDApz+xG8ii/OSyR?=
 =?us-ascii?Q?XkDtcwKXv7fo77QRszsVR7EcaPQnLAs0lpv4zE1VB9tZXVAB6fKRp1OywvaA?=
 =?us-ascii?Q?I4DQWy3HajYaJMZQZSsXTsUR5A8OxIqFCA32Z6jpghwn1rxdKMSR/EEduVrp?=
 =?us-ascii?Q?Y6fblr5eONEUZZLN5vupaWHKSyltJEm3brGcm9kqRmWy5rxFy/LDDc2n34n7?=
 =?us-ascii?Q?nq1lB3a5H4UTxT4vnAN14Eo7ibrvjODlnKmmoalnV8i4A7ElQ06wzviPjmhA?=
 =?us-ascii?Q?pU6loSHQ2QY5wBDB9jEu0JCHlH9Kgy2tw2+XoEWP4RDg44Z6hpfkYufxrBhj?=
 =?us-ascii?Q?YqyT4CFux7zUsdFD+b0a2mWONYGl064FnlcmlP6YzKsVYWrYxnzhafKjz9Lj?=
 =?us-ascii?Q?9LyObx699W/i0smeInjc4bFtqlO2gaQfcIwrGyO6XRRiB8BdVSnHoUR6BQYm?=
 =?us-ascii?Q?FG9VM2NHspcwNeYBgP/wRktXW7oiRCA93+FfZ3W6FN4Zr72+ZAyjr5i7ABUx?=
 =?us-ascii?Q?ZOTpAnHHqNEScYVCWOCOVF7GqzmsnL5Ma8qkGhLk70YHFD39L35tG3KHqaX1?=
 =?us-ascii?Q?/IlT9FeKNVaPbZHv3BASKBG/o3jV5KLSSHIBp5eX3pe74NdukRh8Bdh33veM?=
 =?us-ascii?Q?jWT1JaPhkA6Jj5uN2XnzMKpNomQ2bNBD1vbXRVNaNowdNt5fYwK6UtHMzOxY?=
 =?us-ascii?Q?h3D3t7Rn3dfleEIdMntgElukFHMqBUbczzoDhJ3agp5NaUcPDyVU/a416OZP?=
 =?us-ascii?Q?HsXuZocJudkMNnLjCjw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d548534-ba28-4bc5-3055-08dd623be3aa
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 14:32:32.0645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W90c+4ie2EGXgKTIZJcDk6dDIl6fEb3arVgcN1arLID1oBAZwDbaI56pXbXhO4SEkgef9dVfB2S/R0Bj2q1U+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10644

On Wed, Mar 12, 2025 at 05:04:24PM -0500, Bjorn Helgaas wrote:
> On Mon, Mar 10, 2025 at 04:16:46PM -0400, Frank Li wrote:
> > If the parent 'ranges' property in DT correctly describes the address
> > translation, the cpu_addr_fixup() callback is not needed. Print a warning
> > message to inform users to correct their DT files.
>
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -1125,6 +1125,8 @@ int dw_pcie_init_parent_bus_offset(struct dw_pcie *pci, const char *reg_name,
> >
> >  	fixup = pci->ops->cpu_addr_fixup;
> >  	if (fixup) {
> > +		dev_warn_once(pci->dev, "cpu_addr_fixup() usage detected. Please fix DT!\n");
>
> I don't think we need this.  The mere presence of .cpu_addr_fixup()
> doesn't tell us the DT is broken.  When we have .cpu_addr_fixup(), the
> DT is only broken if DT tells us something different than
> .cpu_addr_fixup() tells us.  And we already warn about that in the
> "reg_addr != fixup_addr" case.

It is encourage people to fix dts first and remove .cpu_addr_fixup().
Most case below "...redundant" is not printed at all at most case, even
there are .cpu_addr_fixup().

>
> > +
> >  		fixup_addr = fixup(pci, cpu_phy_addr);
> >  		if (reg_addr == fixup_addr) {
> >  			dev_info(dev, "%#010llx %s reg[%d] == %#010llx; %ps is redundant\n",
>
> This message is really just a hint that DT is fine and
> .cpu_addr_fixup() is redundant but harmless.  If you want a dev_warn()
> here to encourage people to remove .cpu_addr_fixup(), I'm fine with
> that.

It is encourage people remove .cpu_addr_fixup() because dts already fixed.

>
> Seems like "dev_warn()" would be enough, probably no need for
> "dev_warn_once()" since we should only run this once per controller
> anyway, so I don't think we'll get spammed with messages.

