Return-Path: <linux-pci+bounces-6438-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5912B8A9E54
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 17:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EABF2819A1
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 15:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9A316C69E;
	Thu, 18 Apr 2024 15:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="E/41eod0"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2083.outbound.protection.outlook.com [40.107.22.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B9C168B06;
	Thu, 18 Apr 2024 15:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713454048; cv=fail; b=CrgTyploqaAkdw74x+3eX4+jBAwsx1fPkzdNOvk+QKT2iu/GIjo936YFaqx3bpdiJ05XvJnQOKjpElOwtwKeE+EODl+Bzm0MAki3nZyT4T4iOni9u3jPk4AjoKHeje2im1uE2mWBMu4hbUEgMNpXejuH5A74dCJlbYUelDSsvT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713454048; c=relaxed/simple;
	bh=8IBrLEzLA2NWsh+kkCj4G5LuUbSNvDYKvbkUPkQDCY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cUlVfTw5uiUYVVYiez6SwqN0cJgIiJYEB6w+kzj+FGuOOhzRzYwMzxmZounxu1z+TE41sIKQJsI21+qlzrnIYifPhltEs5K7EgO1ocUSeAEjXBEgEYUyLUcY1snbL/cFuecgHJ6awI2DQUSL2C9od9tA6ZnNkx5zKiOCh1YiZZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=E/41eod0; arc=fail smtp.client-ip=40.107.22.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bLa2CADdC/L3Q6mJ0WJFO5jaBrwNFCa48hl9HYowJZ1NvywikvnZ4/HXMgfXQtHPuLb/aY4Up4cnnpWRc6ldf0QqhRAdiT/f4LuiIRx1MfDhmJXMJdhbDyDFKK8gGdrxxZG07D/L7BiJ0YArvjDPf40QhXwfNuWjAldzvxZK/fOXO7V0eBP8Q2NUQLKpnQEhjHOyXAd00hL7J4R4jdvralQGmJ8RR+LhXvSKKxE1u6xyvkWl/7LgzCpPZik1YVqcSQJZ5PNkCpePKl9sHVgtWeNQZj/YZpHuB2hKjs1EexdixTxYGknDPIdyTHHxwqbSgTdw3FAjsHLtH3tZ7I/Q9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ARzQQ0+PPDylLEMddtpk4fHDw6Bklw6jGQmYRy8MGGY=;
 b=mAKX4/U2BZg3SegqGwFYls7PYC4Wu9C8Oo3nX+wNgyUZFMhXkW+A+VjBrj3dHMDcp3whxQ87UjjlU4hGmLT3+0O0ehkV52ABt3huu/a2IVUYnsz70Bbk972KsPx/wF2y6RNhu70mpJRxRxpE3NFb0+ZWat2FmjFAYgJa1cV8jRRwgFqt0E0zIF5kh6dlKe2JXaqH4BmvM7KEXu7i57sPJAXCqvVX6jQu1uY/2dY1IVDMc+WIhVq2QpJLuCUJBlFume2gvz4/HIk+nto4ttyi6BNgX7WIkj4cM38XGaX7zmWliTyXSZsjVcEyn+WPtAs/M7mkkNFgxdUCcAxRFiCj0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ARzQQ0+PPDylLEMddtpk4fHDw6Bklw6jGQmYRy8MGGY=;
 b=E/41eod0XNGth9Ys598Gd7uEH1CHlGWihBZklkKrodrvpz8N4nwY4x9x+SrZLw381OYEShlJmOGiifX9Eg8uWPVhbNWOlHYY0mb/hdHpHoYBwTKbKduc09I8hzKRmtuoh/WrfwMfRXIpT91NCtBu8mrf+yak3/sOzkHgrM4+pp0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS4PR04MB9716.eurprd04.prod.outlook.com (2603:10a6:20b:4fa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Thu, 18 Apr
 2024 15:27:22 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 15:27:22 +0000
Date: Thu, 18 Apr 2024 11:27:14 -0400
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v7 5/5] PCI: dwc: Add generic MSG TLP support for sending
 PME_Turn_Off when system suspend
Message-ID: <ZiE70u/EZLmoPz7d@lizhi-Precision-Tower-5810>
References: <20240417-pme_msg-v7-0-9c6208cda90f@nxp.com>
 <20240417-pme_msg-v7-5-9c6208cda90f@nxp.com>
 <20240418063058.GE2861@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240418063058.GE2861@thinkpad>
X-ClientProxiedBy: BYAPR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::42) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS4PR04MB9716:EE_
X-MS-Office365-Filtering-Correlation-Id: 886f7ea7-f470-4c69-eff0-08dc5fbc0b16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NrRWTqGAZEIfjVAHZ80ZxnjoPVIpIdG3/P2VFKzTGeXWZwm3g0jeiM4lWZt0H8e1Y7B/ybxnRvRjg5BnjlqDS2kZ1ceSrVCUS4f00+pCqPvAsHHK4j9WHiGwg08LwgMNN9tCDbwDRZ0eTOlKLHKt2TwZuMMI5j3kxF63H8LsO7yudmGe1A5+Y5oeuys/oZtiC9FRSoTyUpOA9ZM8yKtYtX/QF9cpt8KhGRD5MAjE9ixIcZHSNpb7cS5Yir1sBBjIwX+1iFupCI/le7o+7Lr4tjYpAC2pGWMXQv6jj9yovzScTDDOR2VRIsH2mVTcP+2RPt+RKoK9MtTB9IUDrvZ252AyYasonhZiYadB4O1siIDRt3digs3BdUW6l7ttyIorXbA6urK6lmDzZ6wOd24avUsiETuKgCCo/Lh2by/avX/xhdHgEvGz/5IYQxnsSoKQLwQPW3qaSl8f1krmI0RTovBBtsQx6LENqUQRF9kP3B12Qsgb4PaJXsz+zGcJrgokKz0Z88BxZDTm+w8Jk4v4CC60/FH8hdcE3konhAtFpNcvZfwDmrdkaEaj+OqRmvL0A+LOFZAqasqOfwdKGjePUjyzfJKH6IbzW2Y5EIX+tJ87zHIetKbl2X9ZmvkrKOxe0GF78Dbph+vRjo5pbGlPX/c4N9ixlAsMHp5bq+ntMNW1IIp7jurgZC5egFXwIXwSfyQEchAKZOc368aFIH2PLwMUsd8cAKFwb28OmTivyKQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(52116005)(376005)(7416005)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?enNXdHZObkJIZVpVajQ0T3RYb3JadkZ5ZUtWRHRodlJBK05CWGtOekd6V1Js?=
 =?utf-8?B?SDBwN1l1YWtyUVNXV0Qzc20zVHAxTVdNczZtS2VrbTdOTElWYzVHNXpyWjd0?=
 =?utf-8?B?aEU2dm1yV3lHbHhOWS9YTzZOZy9XS2VHZ0pMcGlaYU93MUtYUXZqa0FEUklP?=
 =?utf-8?B?VDY5QXgyL2U0dUR1ZDlibFBBUEVBclJBSWpyNTlHaDhDNlNOdG1mY1ByVGsx?=
 =?utf-8?B?cnFHMFJCVFNHc2dUMndNb3NjelRXTytGSWZaOTRJMCtibEQ2T0UzQlM1YWpm?=
 =?utf-8?B?YmwvMVRBYzJuNklmVGw4TVlGcmQ0akZHa2FlZGtDMHdQR3N4RnNGVGZFL2c1?=
 =?utf-8?B?dXR4UHgxSGlaZjFHY2JhOHJGSzNuV0dJU0JOa2l3eVNZd3BFbGRUZUsxNWMx?=
 =?utf-8?B?ZU1BOTZJSlpOT3d2Ni91eURWZS9TMlQ3Q2RzcDFqdS9iWGxHcUtXdlF0MDJt?=
 =?utf-8?B?RThGVnFXNnhPL3hWeHRCeFVtL0tQREhMNHh3Y3FDTGxieiswcXUrWnQydG9v?=
 =?utf-8?B?eFBqZGk1aFhRa2FJNmVLRmFXREh6amRVWnB6cGxTdUJZWkVyMnlmdGFIMHg3?=
 =?utf-8?B?V29GbUNsa3drU0tCZHVqZU12K0UvY3hVTCtrQTU5WFA1UmtxUG9RVWxNSHp2?=
 =?utf-8?B?QjdIdXBMSi9sMXF6NFRVVUxVMmhNN3I0RkJWbnU4ajRpNVpyd1NLaTl0Rmw1?=
 =?utf-8?B?YytjbGdSdmpTSjYwWkw5REVvS1BjTVd3Z0tSbUNScU4wM0Z2ckRicW5Rb2Z0?=
 =?utf-8?B?dEJqU1RuRzBveXE3WUZkRk43MC81Y1p3S3RlUGk3bHBjQ3JBR2phb2Nqb05T?=
 =?utf-8?B?aStkVkUyNTVtY3Jsd1FQdkZHT2JJSXgzVTZ1WkorQUFFcmFQTHN1VHpURXFl?=
 =?utf-8?B?Q1RBQks3aG96WStMdk9id2xwQjM0Tm5DYnJqRnlHdWdGcG1YZHF1azNCOWdI?=
 =?utf-8?B?MEdDcnFhRFgxczRRdENiUVBrdGRHUnBpa0lvRlFoVUswOXc0ajRmQ0hVR2hI?=
 =?utf-8?B?eVZhR25iQXVIR2IwS0d6ckpaLzhmalE5Z2JCMFQ4dStzLzUwYkxjWXJDdUlZ?=
 =?utf-8?B?VkNSbjdmd3pBM0hiSng4MlAxSlhEeW44QkNWV0Q2MzhybkxlVmtrWjRQeGhN?=
 =?utf-8?B?K01BZE4vbS9EaHpWcW5aUmhXQ3VwN2w4OWpRY2I4MXlVazlZUUFyRlg1RWJI?=
 =?utf-8?B?ZDQ2WFp6L2t3dFFkbzJGNnNqRG9MODIwSlFFMmFkTEU0bVIxcFI0UWlYUUl5?=
 =?utf-8?B?VndtdElFT0JEOHhMYzFqRzVEYjhBb3R1YWpjR3F2SEJrWHluSVo3TVpsYzEz?=
 =?utf-8?B?akNjWHRiaGFHYnFQM21DbmlOMUN2ZXRhWmtiMDdJanpJU0lBaXV0WFpBZHRT?=
 =?utf-8?B?T0xDbUIvQnF3UGRJR2UzQTJqclF5SHNCV2NVeXFHQUNta2M1L2hPVThlUUFr?=
 =?utf-8?B?UWc5dnZyOVc3d2kxSUtzbjRhRzI2aG93b1RQdTYrS2VuQi9VbnVIcEFyQVpQ?=
 =?utf-8?B?dHMxWXBkb29WZ2NIbU9TWjRMb2p4czVQOVhyQ05wdmttZkd2cTBWZit1YSt5?=
 =?utf-8?B?QzRlNC83ay9waU8zS1lpUjlYbit0dDBQcGJlWEpkK2RLVW1LczBnZ0Zqa3hk?=
 =?utf-8?B?K3RESWpDT3VOK3kxWHdrWG1mR1pMcjdzKzZYeVJoR2dQZVd2VXUwcjhYUlE1?=
 =?utf-8?B?WWFvMjdESHc3NllUc2xDaGJwNlh6VlVobjVpYUpLSWhKYUFsNDN4N2NzaXh1?=
 =?utf-8?B?NGtsdWM2b3I1Sy9qR2F3M3ZTalp1Q1Q1ckw0QysreWZGMDdkWk53bldpcjV3?=
 =?utf-8?B?TnlraCs4TUV2LzY2UUVqUGowcmkyUHFaMkxDQ3Y1Q0h6bU51VVBNQUJsTkxu?=
 =?utf-8?B?S1p3THNXYjF5Y3llR0xKbytDWkJOY2V0Q0N0VkFDaGliR1J6dG9McEc1UnN6?=
 =?utf-8?B?VFpEc2JaRjdKZ01NNmlJWktNR1pudHNpK1gzelZWRXFLbTJ5b0taL2w5eER3?=
 =?utf-8?B?WlNiSzBvSWxRZ1B2NFVkVFVpWEcyOHIrZmcrZkVlNElIK1hJMkVWL1pUdy9i?=
 =?utf-8?B?U2d3dGExUlI5ckxGRXpUT3VJNWcxRWRIUHgvQWhLR0lOeC80bnFlL1YvbFFp?=
 =?utf-8?Q?9aldAFws43VPLvYqvSVwyg1qQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 886f7ea7-f470-4c69-eff0-08dc5fbc0b16
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 15:27:22.5964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ln5yGhnAFeNcPy/5IKoVuKvsqFTSj9D1vGV6wGtLurLFwFPzxoIvg22aqdB7URPZar8DOXOrwRM1Hiw8C7KiyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9716

On Thu, Apr 18, 2024 at 12:00:58PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Apr 17, 2024 at 12:59:43PM -0400, Frank Li wrote:
> > Instead of relying on the vendor specific implementations to send the
> > PME_Turn_Off message, let's introduce a generic way of sending the message
> > using the MSG TLP.
> > 
> > This is achieved by reserving a region for MSG TLP of size
> > 'pci->region_align', at the end of the first IORESOURCE_MEM window of the
> > host bridge. And then sending the PME_Turn_Off message during system
> > suspend with the help of iATU.
> > 
> > The reason for reserving the MSG TLP region at the end of the
> > IORESOURCE_MEM is to avoid generating holes in between. Because, when the
> > region is allocated using allocate_resource(), memory will be allocated
> > from the start of the window. Later, if memory gets allocated for an
> > endpoint of size bigger than 'region_align', there will be a hole between
> > MSG TLP region and endpoint memory.
> > 
> > It should be noted that this generic implementation is optional for the
> > glue drivers and can be overridden by a custom 'pme_turn_off' callback.
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware-host.c | 102 ++++++++++++++++++++--
> >  drivers/pci/controller/dwc/pcie-designware.h      |   3 +
> >  2 files changed, 100 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > index 3a9cb4be22ab2..f57805b21ef53 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -398,6 +398,34 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
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
> > +		/*
> > +		 * Allocate MSG TLP region of size 'region_align' at the end of
> > +		 * the host bridge window.
> > +		 */
> > +		res->start = win->res->end - pci->region_align + 1;
> > +		res->end = win->res->end;
> > +		res->name = "msg";
> > +		res->flags = win->res->flags | IORESOURCE_BUSY;
> > +
> > +		if (!request_resource(win->res, res))
> > +			pp->msg_res = res;
> > +		else
> > +			devm_kfree(pci->dev, res);
> 
> You still haven't resolved my earlier comment:
> 
> "You are explicitly freeing 'msg_res' everywhere. So either drop devm_ or rely
> on devm to free the memory."


Sorry, I miss understand you talk about devm_request_resource. omit the
devm_free here.

let me remove devm_kfree here. 

Frank

> 
> - Mani
> 
> > +	}
> > +}
> > +
> >  int dw_pcie_host_init(struct dw_pcie_rp *pp)
> >  {
> >  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > @@ -484,6 +512,18 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
> >  
> >  	dw_pcie_iatu_detect(pci);
> >  
> > +	/*
> > +	 * Allocate the resource for MSG TLP before programming the iATU
> > +	 * outbound window in dw_pcie_setup_rc(). Since the allocation depends
> > +	 * on the value of 'region_align', this has to be done after
> > +	 * dw_pcie_iatu_detect().
> > +	 *
> > +	 * Glue drivers need to set 'use_atu_msg' before dw_pcie_host_init() to
> > +	 * make use of the generic MSG TLP implementation.
> > +	 */
> > +	if (pp->use_atu_msg)
> > +		dw_pcie_host_request_msg_tlp_res(pp);
> > +
> >  	ret = dw_pcie_edma_detect(pci);
> >  	if (ret)
> >  		goto err_free_msi;
> > @@ -541,6 +581,11 @@ void dw_pcie_host_deinit(struct dw_pcie_rp *pp)
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
> > @@ -700,7 +745,13 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
> >  		atu.type = PCIE_ATU_TYPE_MEM;
> >  		atu.cpu_addr = entry->res->start;
> >  		atu.pci_addr = entry->res->start - entry->offset;
> > -		atu.size = resource_size(entry->res);
> > +
> > +		/* Adjust iATU size if MSG TLP region was allocated before */
> > +		if (pp->msg_res && pp->msg_res->parent == entry->res)
> > +			atu.size = resource_size(entry->res) -
> > +					resource_size(pp->msg_res);
> > +		else
> > +			atu.size = resource_size(entry->res);
> >  
> >  		ret = dw_pcie_prog_outbound_atu(pci, &atu);
> >  		if (ret) {
> > @@ -733,6 +784,8 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
> >  		dev_warn(pci->dev, "Ranges exceed outbound iATU size (%d)\n",
> >  			 pci->num_ob_windows);
> >  
> > +	pp->msg_atu_index = i;
> > +
> >  	i = 0;
> >  	resource_list_for_each_entry(entry, &pp->bridge->dma_ranges) {
> >  		if (resource_type(entry->res) != IORESOURCE_MEM)
> > @@ -838,11 +891,47 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
> >  }
> >  EXPORT_SYMBOL_GPL(dw_pcie_setup_rc);
> >  
> > +static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
> > +{
> > +	struct dw_pcie_ob_atu_cfg atu = { 0 };
> > +	void __iomem *mem;
> > +	int ret;
> > +
> > +	if (pci->num_ob_windows <= pci->pp.msg_atu_index)
> > +		return -ENOSPC;
> > +
> > +	if (!pci->pp.msg_res)
> > +		return -ENOSPC;
> > +
> > +	atu.code = PCIE_MSG_CODE_PME_TURN_OFF;
> > +	atu.routing = PCIE_MSG_TYPE_R_BC;
> > +	atu.type = PCIE_ATU_TYPE_MSG;
> > +	atu.size = resource_size(pci->pp.msg_res);
> > +	atu.index = pci->pp.msg_atu_index;
> > +
> > +	atu.cpu_addr = pci->pp.msg_res->start;
> > +
> > +	ret = dw_pcie_prog_outbound_atu(pci, &atu);
> > +	if (ret)
> > +		return ret;
> > +
> > +	mem = ioremap(atu.cpu_addr, pci->region_align);
> > +	if (!mem)
> > +		return -ENOMEM;
> > +
> > +	/* A dummy write is converted to a Msg TLP */
> > +	writel(0, mem);
> > +
> > +	iounmap(mem);
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
> > @@ -854,10 +943,13 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
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
> > index 703b50bc5e0f1..dca5de4c6e877 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -341,6 +341,9 @@ struct dw_pcie_rp {
> >  	struct pci_host_bridge  *bridge;
> >  	raw_spinlock_t		lock;
> >  	DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
> > +	bool			use_atu_msg;
> > +	int			msg_atu_index;
> > +	struct resource		*msg_res;
> >  };
> >  
> >  struct dw_pcie_ep_ops {
> > 
> > -- 
> > 2.34.1
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்

