Return-Path: <linux-pci+bounces-4062-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39ED18683EF
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 23:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90CF7B22DDA
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 22:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA4E13540F;
	Mon, 26 Feb 2024 22:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pB0zWoJT"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2088.outbound.protection.outlook.com [40.107.7.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00547132C09;
	Mon, 26 Feb 2024 22:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708987425; cv=fail; b=G9EvhiEj19nBpo6wGg6GqdTfn7LH/AXjacJAO6grt2f73juAgA2UAg9Hd9h48Zhn3hR1kkc0iviX4L4zH16Rb+eIScOIZ76qUE/2kR7HgZgd1SKBEUviSYFFujrMSn2n4/sACjbEY66xgyQpDVUz6utEuVnVjSjxSN5h2mwk/ng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708987425; c=relaxed/simple;
	bh=deYARtl2lE5NIICYKVYdvZvlfvRG/uIYYrWCTs/s2P8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MbY44vtPk7dzZYmjr0M5PLsVXJn5IMoknNDI14XQoITHTOuzmzw3b9/1WuatkSSgXWfttwGfzuOk9NUfbgxQTpjz48Xo0EVU1NU5eaexsd6XHeIx9NC5ZNzEZp1jMKgz5mT1O+S1Stypmf0hsqoVmHo1IiVu5pLpHv4cq4KyyDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=pB0zWoJT; arc=fail smtp.client-ip=40.107.7.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BdOfRNZJeLSyCnA7ofTGdlGmUpDfjKKOr9b5n/Ml36x18blZIocjmslgYyfhbOEBebvMby7jtNx8wgPD9xxjrHjXlmDJV6Xoo5n9kC6wWYb3kr+Qa54mW+v6Vaf7bL16v2ggfgpKTD5YJVqr6pGFAYkZ1JXiJXzvXwdLjRP6XgH3PA6Drcq3eoCV3S5TSnxelyazMJQEKsJw7pDL6l/ySj2qd3fbaOyEnofcohyC9+VcXnRwAUnG3iviW8erdOkCd1WkzkISzb3VVq4K3pV4SNtunaC0/JfaV3qpfUQ6F3MvMO5DLlXognH6g7qndE/lPkZDFEMRfkPuUcC7//oBlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IguNcd9cBakN5IvXfCy4kTOqo5PQmEY0JF6qDxepBCU=;
 b=VEIJIY2zhOvvDPosxxaR24WLlO5hgAsEvjDvxvSx/+6uFhLhSL9h3OJeOk6ohONaMGfc7bGiKti1qHVJ6faeyCzXlQKwP8V8vo9fyLPjrg+wvnxFsJOX0tGCgsr/YIvrdzZpgwN16hKPD/uV06dj9P0ng8HE8xCljvyTdhl25YLU6Y3FwmjP4ZFqUnDwFB11nK3tSBGn1Rbr3ap1wme+IH1ugK+KPDz/XRUFJjiQQJoPmlPtOvcQtazCFCPQFtoEWpFdDiWtrQ/ZfI6s4OAjO37r91kVG0TwmhnV0Ct4sH1j44/FvUnSfp7hdKe63Bp7pQhgu0BoJUl1YXocuS6muQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IguNcd9cBakN5IvXfCy4kTOqo5PQmEY0JF6qDxepBCU=;
 b=pB0zWoJT/5iBP9Oy94ltyPuyyqJ6ARhmCq7xOgAls8S8DwVnqTeNEgFxY73TeDvr3+KuHUXhu+t676nW6gBPzkvQ8uaI9sfN3SrjAhyobys+4Su8WCDqvWzD41TXPyqVJetB73OwCV5hbUvKtRjlHADG/GbFqdCaTcYy4hbeVDg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA2PR04MB10124.eurprd04.prod.outlook.com (2603:10a6:102:407::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Mon, 26 Feb
 2024 22:43:38 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.032; Mon, 26 Feb 2024
 22:43:37 +0000
Date: Mon, 26 Feb 2024 17:43:29 -0500
From: Frank Li <Frank.li@nxp.com>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 5/5] PCI: dwc: Add common send PME_Turn_Off message
 method
Message-ID: <Zd0UERil+A2LgSot@lizhi-Precision-Tower-5810>
References: <20240213-pme_msg-v4-0-e2acd4d7a292@nxp.com>
 <20240213-pme_msg-v4-5-e2acd4d7a292@nxp.com>
 <erja6zkhstoaverqtadnqj3nsyluh3sealibpujqmea4pndiuv@icihj7cby2l7>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <erja6zkhstoaverqtadnqj3nsyluh3sealibpujqmea4pndiuv@icihj7cby2l7>
X-ClientProxiedBy: SJ0PR03CA0247.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::12) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA2PR04MB10124:EE_
X-MS-Office365-Filtering-Correlation-Id: 70e87c9a-2aa6-46b9-d40b-08dc371c5f26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0XEiqFWgwWoYNghG7zXt3MwHNe/Pwgp00L2sUSO1aIY0sLnCzu2gX7zYdBaQGckPejsfa1v29t03E1heDOBcTIqohDNmooeeJo58FLVVTlXZbbIi+ZqeWJQzJ9L7qQ+5fg9S7SZVJVVImNtbXbnkvvZUoEEYG3ycBmgscdJ3a8L9Ki1zJzJpLMpBCda6HV/DEvAZczM4zPG3MPxZZUtYTKGVCRAqW/RkBVdORwkidFkswyvlsd0c4cIl/LDc1/JSE6JWIFVGohS84xmJuKmHY4knoIwLPMyr76RibiBU0i7XAeQ+oPdRz7s0Y07vfdteUMDFaQNLJLZOIcfXzCj5lPptzJR/n9qTl+9XPHNZZbkIgliACnl491w2StgtWrE9aBJuTmiv4XhRpA+iZh36MDaXP5szOLfFIa+k7qg5Xjlg4DYLIWlcqlC0WqT0Iygj/Ukhs9+OisR+mEP6aOGzTidl/ijTn5J6C0ZjcSY39FjqR0Z7jW3zTbC2LHf8cEyEPcKZThfp533+sIOtAiNAgG2YiDainlCRpKN8WGZmpBF5RBUJTISBALmyI7iyVEjgHTEIF/s8dhCCTiYM4K9aU49ly5PWEaI4le+5hjgblq0BAWHxGAvzxEt9ZkZNdLagSvqVXjv8iXq52nUAlZVvLgi6fy7d42/COTv/sOfxrn1KG7KexZ/IVwYXkAZUyMT/dJ+AHXN/CE+oUNwehRffaQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CjujWD17mDT3va+RpvOmPP+M0O8KqbVwJNQKJSvE9VcW8A75yXSjUSRCCTHI?=
 =?us-ascii?Q?MtzMJWO8SXrPtdUGTm6iRXTx3WD6XPWEvygU0zmniw6XAiDqU5mlZk48DBKu?=
 =?us-ascii?Q?6P2ib2lIMdhLHV5O88YnpkkVRTs0c4L0aDrE8K4KIZnfRji1fySrQzjlvEPh?=
 =?us-ascii?Q?ShlEb4rQSB1oQt7wZNnJ17BtdbC4i4kfweZnehGlMMqv6Kjfs7v9benmKZVO?=
 =?us-ascii?Q?S7+pby7Lavtv8q+fH1HUjzhpaB8mBqh/RMBmTTieY4mWOsLFuSK1grAKqY2Y?=
 =?us-ascii?Q?WxRCCjcmfcBlTRRVinVrS/PjwkrWowsCQe6clPK1rsJdUUUbpPA8U9qN1jSU?=
 =?us-ascii?Q?JkVr1OECDA91sGZRO/XnkOKOlGqHfkFi5mx4onbkwzbYGkDBDL/s3h1FE95x?=
 =?us-ascii?Q?KZZBnSV/Cg+l9rd6Dqcvhzz2Gl5NTthFXdQ89wDtkDmLS1bHiBnAqWkNo0DF?=
 =?us-ascii?Q?nha0Rt1lGZC95Tnz28loZ4kclU/mqAFcJwmB94/eBjbfqS+OQtHLtoHu5o58?=
 =?us-ascii?Q?2NUj8NaV87yBzUeYjPikuWV7eiNFJtdr1cE5TVS/WaaLHs4TaM25IH6fNYSD?=
 =?us-ascii?Q?nq34XmGi02s29zr0GzGIqszcimx+Sq4/lQYeeKRldir7E7Zz6qwZB5Q5qz6L?=
 =?us-ascii?Q?iH68yNNw2zESK9+9NI55ERj+LSW5Um1vOskQCLMwYQnSGE+nn+rgCoGGsSRt?=
 =?us-ascii?Q?LsmKRqv6blA2pO9Z0nASH0S9e0ls37JW3dvmaUbNZIo1cohQeMSnO4xk3epX?=
 =?us-ascii?Q?bI4AT2Hq4oCfKpSAGMAQQipAuVUnUX9r/xZ6dYfT3FV2Rx+iDM5RcSf/xo5R?=
 =?us-ascii?Q?2exmXXuvmSxMv9SxKGso6nJDHc8Pa0Zde9k+weOxOBsiG/S/6QXRSlZfXOBh?=
 =?us-ascii?Q?rg+6zCOlaoJor6v2ckFh7ezkMQY+95WMHSvTY6qlN4vXGqtlsZjSrvztK9aE?=
 =?us-ascii?Q?2wsN9GoS5sevSYWzJUo2ZcUDxeJUOuDvoto5S6GhwCIkrubKaOyUs9+kr4e2?=
 =?us-ascii?Q?+1OtZde3TwZZ5EFdzqTgyO+sJiF58cBEUD3+ISGPiahJEPFEI484wmujHfBz?=
 =?us-ascii?Q?DrPVtB5snR602/f1LAyXoZQocdTATRZp6aurK4NSPm+RJN1D6ODN7pRFAGG6?=
 =?us-ascii?Q?s1jWCYxwfedTs1NcK3/Am4DrD1UpcUqcBPoeJMpDkTAfCZdDqD+es3aRPoXP?=
 =?us-ascii?Q?fTJzoPCxiM7ABJKYMesBq020Uq7RSt4L7k9gT/I4D4YJ6K4DiGn5cPHdz9lC?=
 =?us-ascii?Q?CToCCGweLqRlROylU0ONLyvZexKurum7lPtRroUXpC3+QIsY/AsP/LtPx6H7?=
 =?us-ascii?Q?0lJLrmesqJTLVx4tOVFrcnfx+1tE4zOAV5ExcakOeadmjE1vRXIuQEdkTNNG?=
 =?us-ascii?Q?x6HMW0Hias9Tmy8EHqHi14Sx+HHCGEkicp90Kqme9Xpdj2jTiRDuC1GW6rZT?=
 =?us-ascii?Q?5ad+vbjeLgOmjztZRQjGqwbspi99AeFGldFxKqgzkZQh38kwO25ZzDqr+r79?=
 =?us-ascii?Q?IhpWPz6cjOygRsAtqNLVWBx2A5RNFXhBg/k8f++i4j1CNmJgm9ArkKaOXeGh?=
 =?us-ascii?Q?/vJxZvagbhVeqGqO64Q=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70e87c9a-2aa6-46b9-d40b-08dc371c5f26
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 22:43:37.6077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /i8rLgmnWXwf2nfkX7wjrw/iCT2gGMNnw4fDAR+fMmVsixCnG0vpHz/RBmku6PeEP2ZCKb0LFhvPAWPltd7jxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10124

On Tue, Feb 27, 2024 at 12:52:45AM +0300, Serge Semin wrote:
> On Tue, Feb 13, 2024 at 04:50:26PM -0500, Frank Li wrote:
> > Reserve space at end of first IORESOURCE_MEM window as message TLP MMIO
> > window. This space's size is 'region_align'.
> > 
> > Set outbound ATU map memory write to send PCI message. So one MMIO write
> > can trigger a PCI message, such as PME_Turn_Off.
> > 
> > Add common dwc_pme_turn_off() function.
> > 
> > Call dwc_pme_turn_off() to send out PME_Turn_Off message in general
> > dw_pcie_suspend_noirq() if there are not platform callback pme_turn_off()
> > exist.
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware-host.c | 93 ++++++++++++++++++++++-
> >  drivers/pci/controller/dwc/pcie-designware.h      |  2 +
> >  2 files changed, 91 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > index 267687ab33cbc..5e83756492462 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -393,6 +393,31 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
> >  	return 0;
> >  }
> >  
> > +static void dw_pcie_host_request_msg_tlp_res(struct dw_pcie_rp *pp)
> > +{
> > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > +	struct resource_entry *win;
> > +	struct resource *res;
> > +
> > +	win = resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
> > +	if (win) {
> > +		res = devm_kzalloc(pci->dev, sizeof(*res), GFP_KERNEL);
> > +		if (!res)
> > +			return;
> > +
> > +		/* Reserve last region_align block as message TLP space */
> > +		res->start = win->res->end - pci->region_align + 1;
> > +		res->end = win->res->end;
> > +		res->name = "msg";
> > +		res->flags = win->res->flags | IORESOURCE_BUSY;
> > +
> > +		if (!request_resource(win->res, res))
> > +			pp->msg_res = res;
> > +		else
> > +			devm_kfree(pci->dev, res);
> > +	}
> > +}
> > +
> >  int dw_pcie_host_init(struct dw_pcie_rp *pp)
> >  {
> >  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > @@ -479,6 +504,9 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
> >  
> >  	dw_pcie_iatu_detect(pci);
> >  
> 
> > +	/* Need call after dw_pcie_iatu_detect() before dw_pcie_setup_rc() */
> > +	dw_pcie_host_request_msg_tlp_res(pp);
> 
> This may cause regressions for instance if the outbound memory window
> is small and is fully dedicated for some device like VGA/GPU/etc.

There are host memory map windows, which are quite big. It will be too
small if only because one page size windows less.

Look like it is impossible to dedicated to one device, all pcie devices
(VGA/GPU) should go through standard pcie probe flow, the bar will be
allocated from bridge windows space.

> 
> Why not to use a new ranges-based mapping as we discussed earlier:
> https://lore.kernel.org/linux-pci/20240214061412.GB4618@thinkpad/
> ?

If driver can auto alloc from known range, why need static defined in dts
files.

static alloc can't resolve small outbound memory windows problem. It may
disable this feature. 

> 
> I know it might be troublesome but still it would be much better
> and more portable across various platforms.
> 
> Bjorn, Lorenzo, Krzysztofm Rob could you please follow the link above
> and give your opinion about the solution suggested there?
> 
> -Serge(y)
> 
> > +
> >  	ret = dw_pcie_edma_detect(pci);
> >  	if (ret)
> >  		goto err_free_msi;
> > @@ -536,6 +564,11 @@ void dw_pcie_host_deinit(struct dw_pcie_rp *pp)
> >  
> >  	dw_pcie_edma_remove(pci);
> >  
> > +	if (pp->msg_res) {
> > +		release_resource(pp->msg_res);
> > +		devm_kfree(pci->dev, pp->msg_res);
> > +	}
> > +
> >  	if (pp->has_msi_ctrl)
> >  		dw_pcie_free_msi(pp);
> >  
> > @@ -697,6 +730,10 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
> >  		atu.pci_addr = entry->res->start - entry->offset;
> >  		atu.size = resource_size(entry->res);
> >  
> > +		/* MSG TLB window resource reserve at one of end of IORESOURCE_MEM resource */
> > +		if (pp->msg_res && pp->msg_res->parent == entry->res)
> > +			atu.size -= resource_size(pp->msg_res);
> > +
> >  		ret = dw_pcie_prog_outbound_atu(pci, &atu);
> >  		if (ret) {
> >  			dev_err(pci->dev, "Failed to set MEM range %pr\n",
> > @@ -728,6 +765,8 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
> >  		dev_warn(pci->dev, "Ranges exceed outbound iATU size (%d)\n",
> >  			 pci->num_ob_windows);
> >  
> > +	pp->msg_atu_index = i;
> > +
> >  	i = 0;
> >  	resource_list_for_each_entry(entry, &pp->bridge->dma_ranges) {
> >  		if (resource_type(entry->res) != IORESOURCE_MEM)
> > @@ -833,11 +872,54 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
> >  }
> >  EXPORT_SYMBOL_GPL(dw_pcie_setup_rc);
> >  
> > +/* Using message outbound ATU to send out PME_Turn_Off message for dwc PCIe controller */
> > +static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
> > +{
> > +	struct dw_pcie_ob_atu_cfg atu = { 0 };
> > +	void __iomem *m;
> > +	int ret;
> > +
> > +	if (pci->num_ob_windows <= pci->pp.msg_atu_index)
> > +		return -EINVAL;
> > +
> > +	if (!pci->pp.msg_res)
> > +		return -EINVAL;
> > +
> > +	atu.code = PCIE_MSG_CODE_PME_TURN_OFF;
> > +	atu.routing = PCIE_MSG_TYPE_R_BC;
> > +	atu.type = PCIE_ATU_TYPE_MSG;
> > +	atu.size = resource_size(pci->pp.msg_res);
> > +	atu.index = pci->pp.msg_atu_index;
> > +
> > +	if (!atu.size) {
> > +		dev_dbg(pci->dev,
> > +			"atu memory map windows is zero, please check 'msg' reg in dts\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	atu.cpu_addr = pci->pp.msg_res->start;
> > +
> > +	ret = dw_pcie_prog_outbound_atu(pci, &atu);
> > +	if (ret)
> > +		return ret;
> > +
> > +	m = ioremap(atu.cpu_addr, pci->region_align);
> > +	if (!m)
> > +		return -ENOMEM;
> > +
> > +	/* A dummy write is converted to a Msg TLP */
> > +	writel(0, m);
> > +
> > +	iounmap(m);
> > +
> > +	return 0;
> > +}
> > +
> >  int dw_pcie_suspend_noirq(struct dw_pcie *pci)
> >  {
> >  	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> >  	u32 val;
> > -	int ret;
> > +	int ret = 0;
> >  
> >  	/*
> >  	 * If L1SS is supported, then do not put the link into L2 as some
> > @@ -849,10 +931,13 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
> >  	if (dw_pcie_get_ltssm(pci) <= DW_PCIE_LTSSM_DETECT_ACT)
> >  		return 0;
> >  
> > -	if (!pci->pp.ops->pme_turn_off)
> > -		return 0;
> > +	if (pci->pp.ops->pme_turn_off)
> > +		pci->pp.ops->pme_turn_off(&pci->pp);
> > +	else
> > +		ret = dw_pcie_pme_turn_off(pci);
> >  
> > -	pci->pp.ops->pme_turn_off(&pci->pp);
> > +	if (ret)
> > +		return ret;
> >  
> >  	ret = read_poll_timeout(dw_pcie_get_ltssm, val, val == DW_PCIE_LTSSM_L2_IDLE,
> >  				PCIE_PME_TO_L2_TIMEOUT_US/10,
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > index 703b50bc5e0f1..9e6076aa4c850 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -341,6 +341,8 @@ struct dw_pcie_rp {
> >  	struct pci_host_bridge  *bridge;
> >  	raw_spinlock_t		lock;
> >  	DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
> > +	int			msg_atu_index;
> > +	struct resource		*msg_res;
> >  };
> >  
> >  struct dw_pcie_ep_ops {
> > 
> > -- 
> > 2.34.1
> > 
> > 

