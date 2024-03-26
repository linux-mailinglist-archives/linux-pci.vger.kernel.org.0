Return-Path: <linux-pci+bounces-5182-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 855BA88C4BD
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 15:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6D36B2436C
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 14:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D927B136982;
	Tue, 26 Mar 2024 14:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Jnxfms+S"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2097.outbound.protection.outlook.com [40.107.8.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DEE12C7EA;
	Tue, 26 Mar 2024 14:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711462138; cv=fail; b=tXP4HLRgw7Bvtxu7ASFQ8KxWj5gS8jNaeg8aKWrFlWPyFCNDtDKjRDtJdv1fNbLdnbYZTgB5AkNTza2ICSUIKPAAYHzHYTyd3yNbOe1teafwkj1QY4EIwRw0BN+zsT2Huf19hJuPCSuDLvijIIe4qaQNXSwBGIYCb9/uzqoeM6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711462138; c=relaxed/simple;
	bh=bhqn8mwHkjW8bXgzsfXsHu4b3FAChZJzvQ98BnjjElY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nzMYUrGPIM1cBCKahWgkRwnkPyrpN+rhRGut+rzHsH5a2yleAKBeXUCFQ78qzgax8U240Pq0nr8VKVqr+By3gD6/bHoOTuHpeZBSQiekUmGwFQzAt9q1UHnOq5SjwvivZNy1JAeT5KmR0/ugNxb4ubhec1w8EYsGTzLuIW+NzAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Jnxfms+S; arc=fail smtp.client-ip=40.107.8.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JJDG+ZJcqeJ57FKHWeiyMhJDonpfGyBHDQtCSVEyQPTShJNEc2CpR82jz7WFO6knflY1/NibeoG86cuiGQxMijjZ0NZRZvIvBIiZcqDRlKYqhvAF4Dr59ETisuFb8zgufTCIr3DB4znsyNbGX3rBvhsYXjUBdEXHKV2mT/I9MRpFT9KDK4xNySdDX9csggzq0+KUEZvB6uPwahIZ6w5g6OlblXTxwFhFKQySuInb8rTJNIW1ZqQiP8rgNEe9b6RB5LFcpsuR1LgqaKuYnLruy8pm+W0Zol5CAi5tvutR2bMu9o8jgaeSEFUPVJrttTDI9LnK8bI7x0m132hMXLi49w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HrEx+sFThkFol1/TOMmkTzcizhR8cM+bYPvNy+L2IZ4=;
 b=Xl11kPSCeEg5MdXB6fsHOVP076QN+tILnYIMT43re67VKbhsweZV+S1x/fvfQzWjClN/cx/47ghhGQuESoTG43L1HefKZkJfHr05mxvkVhh7CwPlbpt+GBS7cR9hunoDkfDwZxVvsE/MqO6T+MejK0yVzxf4q26qHcToaszIfOF2PV/xeAl79rEY/u1jsU+AdtkJXVQkzvJCbxB5ljTtp14AmuoUo/rDtAcK93a/puTuNAnVaiWiNJF1SfqvhmjnTe5KrBGkrnL8Krb4VdlX/iiWGB30hRvgPpU1+gBXxr/6fpTb7r8uAzIwN9/5ID00HuusN7H1U5LI+/Hd1Aoqyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HrEx+sFThkFol1/TOMmkTzcizhR8cM+bYPvNy+L2IZ4=;
 b=Jnxfms+S2redX69wvhw1Qwteqz0e8HJ+NBu1mWSYchNqLy/wGSOy5PoQVAjqMb2o609WlFYORTThhywd2GKKaXzAjrXhTkdL6smRrKnyy+oyIhbWwLeOp/73AXfnlpmExFDHSNskUA28WDJlz/zDQzl77T3oU/r/KCfkPvlLSK4=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8408.eurprd04.prod.outlook.com (2603:10a6:102:1c9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Tue, 26 Mar
 2024 14:08:49 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.028; Tue, 26 Mar 2024
 14:08:48 +0000
Date: Tue, 26 Mar 2024 10:08:40 -0400
From: Frank Li <Frank.li@nxp.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
	"mani@kernel.org" <mani@kernel.org>,
	"marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v2 6/6] misc: pci_endpoint_test: Add Device ID for R-Car
 V4H PCIe controller
Message-ID: <ZgLW6CGYfUW6Uskz@lizhi-Precision-Tower-5810>
References: <20240326024540.2336155-1-yoshihiro.shimoda.uh@renesas.com>
 <20240326024540.2336155-7-yoshihiro.shimoda.uh@renesas.com>
 <ZgI/IGe2L0rJ8SSF@lizhi-Precision-Tower-5810>
 <TYCPR01MB1104072DA4D6B3DF120A10D0AD8352@TYCPR01MB11040.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYCPR01MB1104072DA4D6B3DF120A10D0AD8352@TYCPR01MB11040.jpnprd01.prod.outlook.com>
X-ClientProxiedBy: SJ0PR03CA0206.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::31) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8408:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pBkoSK+sTjTNkKTB8xasjaaH/2jcbw+3PexEAosAi48JXFSxfm8O078pR1m549JVXB4BYOrHdht4G8m4ihKfKFZdrthj54sG7bQ8FYKGrPFQ5DS32B60MOVBmvFZiNIv1oOk+tg0SkcQIvbrHzjDM14fVdfYzGjjhUoO7qgWyh8BE7qfogIfe+F3TjX1TXPJt36XUqykHoztXK6vzngD1qe4j9bc/QcKeXDLTwhvtYBrevONRFv96t2/WOxj+0h46uUqFlWPLjvqkVLYEvVcwezXy4YqWlCm9QmykrauvLYwapE3IW7Lh5Zeg7yYTAIJUN6vzXRxyRcQZirKnv068P1Ry0CxGz0PUfHJAqIKSYaVRajak3DguY5NyxVj1hWF5h4ob7gMkEJMLRET1hKOUXp1wRt+Snp0hosRR+qqKWb5JEA842HV5K9fQWPLqlmCX4Enwa7rIksd90818xb6f1lXG1q3cIe8LI19GXGIkLfT71wGS+Z1dAhNdYTix8MPg2laK+5tdeCDgmlcYKtsL0AGIBJh7qwI/wrlrciZhlJtC+rSH1zIr8Jf23ztr42YYbBKGVPFoI8dDJh+FyGamP+JTMz2z4nlg19/ZCNPL47vcxh1GabwrNuhGM+8+G2r07SIm8vQsexvyPC7+r0lSKlOlHDH25RgOTXva+WylXGf/pW2kCLiR5jnIiAhOJyVTYrPQdt4YX4MwWFXCdbwSo4fpoHiZSjCd+rn+burf9k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PVgiMa8t+9xgeFSDoV5+0bh2Km5HEbe+r4keZEuwBA/3J94zKqXrZjzIcuR0?=
 =?us-ascii?Q?W7JBfS8nNA1BKmfZntum7/T9/8Bz3uD2Rwov+bsfcNZ9SnAFZIBStV528Cfg?=
 =?us-ascii?Q?oopMEAL84OwLWyWsLHhPrltE3CUuUTFouoBKhuyYrwIowcP/5HgSRUgOE6+u?=
 =?us-ascii?Q?nccuTxHtZdDqBQbVVvgnHgHQzLvnWyM/SzHlwIcDplGD1sAeJR1OY14dojQe?=
 =?us-ascii?Q?wDFnO44VQdAwOEbXh1foStpYAvYAXlUJuZ1oDzuhtELEYYTCOKu0eSppnwhb?=
 =?us-ascii?Q?DN4qeH83zkZlMXF9zqJIwLrR+ewTxAAlIYs0VIQmhRsCHYMUqybe4f4MPR91?=
 =?us-ascii?Q?c90HeBC7cJ36go+AaWaZ2uD4hHeiVuXIE4NOy18rPTpQlew8FDwtimDM6Vf7?=
 =?us-ascii?Q?hqvybtDJAVWTjXSPjoi7j+nOBg/3FkAOKOKE890zSG6cIzPR6WLa1pD6fTlQ?=
 =?us-ascii?Q?QkNeJHCCMsI5w0APqXZmUqj5tgvq09r8bbX/CcN6uVIwxiBiQ7mlQMhuH4fI?=
 =?us-ascii?Q?Cr3LgsdOYfhOCvsm5B25j4ZwOzA54gD6bKGzeYWMMe9ZInss9XpzjC+feo0K?=
 =?us-ascii?Q?3AbMIXkhvN6hb4c0Kknz0h+w8bu+Fk3nYmpVYxhu5wBy20GAKrnnHlSRFgaV?=
 =?us-ascii?Q?vbgf32gD8F7R9OzG2Mqnk6uUmISU6Mn6LrvN2z46yLT8KrSpMHfzb6UmmoLT?=
 =?us-ascii?Q?hEdgM8xq3HotS9Ry75PrqgCawrY8dR2MdukicKTOl8x3hAj72sAC4qh1gjrH?=
 =?us-ascii?Q?XGRiKbrHRowP7QjWhMyIZTbycLcXxG/vVwT+vaj6H+oqDvRyJQDWu5G4EQv6?=
 =?us-ascii?Q?cYf29L2eHTmKHRu3h7KoXxDcBrEGjjelgwFxv6aOckux1XbrSBd9vTyKQ37u?=
 =?us-ascii?Q?SZk0rjkeRQ3b9R/1x+ynqSxUfx+Ruo4UHImfEWi054wN32DESy/kkuovTHfM?=
 =?us-ascii?Q?91wVtrj2hZxDrWUECrVkzU5f6tt1y89p4w2aSIYIYYKwFTI/UyQ1IpF02j6+?=
 =?us-ascii?Q?5NI8Rm7aRlFkp0Sd7c6CMbyOly0KPn9qVqbj5Le13QRTiKQiIvxpjCWAD+yJ?=
 =?us-ascii?Q?te5a6CmzVfi58KpuogKME2BoXWTwl+xCZXuF/huVp2jLKl0YjWMPx0Yof8tB?=
 =?us-ascii?Q?EGjLB9mGUHYnaOkZ+bRudk4zH1h70AFfrw87P9lL7OUt3O+8qTUhoXDSZiph?=
 =?us-ascii?Q?Y5ydnqyf8SqwXL3F79PFZMuxPqOtPwwAL3YKjMxg9n1FpXlp6ShZl9gqCB0e?=
 =?us-ascii?Q?1rhNcrLjMvZ5EPzkmtOIV/wZ1a79XdYA4f+a8OZnMBUQcROeQtQGtAihU/qt?=
 =?us-ascii?Q?3H/6C/F9GWvGBN3LAQ5KNrXebQBOeJOT3cFQaKajaDf2yiBGpi+X2fQ/PkM0?=
 =?us-ascii?Q?pGSdtZR7VjGmTcG35dDAZY1Yb5Cc1mRq+byNg26CPlAOJuEO3Dlg1dKOLgP8?=
 =?us-ascii?Q?6Mq+J0TDu8MT1vp9jkFoXxEcOAyixD6pdqwNGhUtOStuiZ28KEP2eiDiXUIj?=
 =?us-ascii?Q?16NX+0IFqu4bWA1u7fv+vdl3llwgj+8PrbWm5qHSk29SrtPGviiHkIqSoZUF?=
 =?us-ascii?Q?efubfsnWQaCmHrgQEZlwW601DUdnyiBv8n88BJde?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72962483-59bc-49d8-957b-08dc4d9e4201
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 14:08:48.8327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sUNTs5iqYPq8cTgs5QElMEXcMT0T1wbXq3paQ6K5qmRyMiKa+y8+CX1+07tWRCS19vwCjjeR2NRWrcU8qGD+eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8408

On Tue, Mar 26, 2024 at 05:47:23AM +0000, Yoshihiro Shimoda wrote:
> Hi Frank,
> 
> > From: Frank Li, Sent: Tuesday, March 26, 2024 12:21 PM
>  
> > On Tue, Mar 26, 2024 at 11:45:40AM +0900, Yoshihiro Shimoda wrote:
> > > Add Renesas R8A779G0 in pci_device_id table so that pci-epf-test
> > > can be used for testing PCIe EP on R-Car V4H.
> > >
> > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > ---
> > >  drivers/misc/pci_endpoint_test.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> > > index c38a6083f0a7..2fa3c6473c7d 100644
> > > --- a/drivers/misc/pci_endpoint_test.c
> > > +++ b/drivers/misc/pci_endpoint_test.c
> > > @@ -83,6 +83,7 @@
> > >  #define PCI_DEVICE_ID_RENESAS_R8A774C0		0x002d
> > >  #define PCI_DEVICE_ID_RENESAS_R8A774E1		0x0025
> > >  #define PCI_DEVICE_ID_RENESAS_R8A779F0		0x0031
> > > +#define PCI_DEVICE_ID_RENESAS_R8A779G0		0x0030
> > >
> > >  static DEFINE_IDA(pci_endpoint_test_ida);
> > >
> > > @@ -1005,6 +1006,9 @@ static const struct pci_device_id pci_endpoint_test_tbl[] = {
> > >  	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A779F0),
> > >  	  .driver_data = (kernel_ulong_t)&default_data,
> > >  	},
> > > +	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A779G0),
> > > +	  .driver_data = (kernel_ulong_t)&default_data,
> > > +	},
> > 
> > You use default_data, why need new device_id? I think you can use 0x0031
> > to do test.
> 
> I thought we can add a new device_id freely like other devices.
> Since the PCIe controller's endpoint mode can configure the device id,
> I can use 0x0031 to do test though.
> 
> If such a reusable entry exists, is adding a new device id into the driver prohibited?

I just think it is not necessary. This list will become longer and longer.
And difference device id can't help us at all. 

We should use difference production as difference functions, or difference
configuration.  Such as usb gadget product id, we use 0x4545 for all mass
storage. 

Using difference devices id for difference function, such as 0x31 for
ep_test 0x30 for virtual net, 0x29 for virtual console ...

Or using difference devices id indicate some features. For example, use
0x30 means support write to EP MSI ITS to trigger irq.

Donate a device_id to more valuable things.

Frank

> 
> Best regards,
> Yoshihiro Shimoda
> 
> > Frank
> > 
> > >  	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_J721E),
> > >  	  .driver_data = (kernel_ulong_t)&j721e_data,
> > >  	},
> > > --
> > > 2.25.1
> > >

