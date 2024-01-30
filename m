Return-Path: <linux-pci+bounces-2750-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF1A8417CB
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 01:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EAD81F240FC
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 00:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407AA1E893;
	Tue, 30 Jan 2024 00:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="AygNgtCW"
X-Original-To: linux-pci@vger.kernel.org
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2097.outbound.protection.outlook.com [40.107.113.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DB41E502;
	Tue, 30 Jan 2024 00:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.113.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706575618; cv=fail; b=ZZ/JVgQMyj1U63tMVb1qUwYgrACSfhCFknqQcoC6Ig0I7zszzeZBlcdv6kk3Qit0T68kbfi7f2rhEevMKphf12/fToerz6DHYMkYORtT2olsU6yY3lVjlJkUAt+UwBrSPUxuRKC3JmUyc6IspnfR5aYs9vZVhdrAMMdJRLQ9SDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706575618; c=relaxed/simple;
	bh=vwQs7LYOzXzFgtX1/z0MqoSIagBXaSVCttjGeXlQ+hQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mq/JSyhroV7L7eV81iXUKLtCMraf19ZR9PnQ8UDqqOGuzn0AIeoJHFcqVpDgTnc6IOROgntY+KnFUTgpkuh8x8az1lcJ0A7U4x1raxf7q+nXK7CCBmmDFTGgA5mbVg8q32df2bZWlrOz/8w+OS1Rad0NUpzrDOyLVl7s7D5nYCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=AygNgtCW; arc=fail smtp.client-ip=40.107.113.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dg88hXUxYjcSlO7jfrxF9jsnD5aFvc2+QtBXqPHQx30P/BYJcOGXPMzHW8vSKyFiiTALLtpgNrXZ+Zie/9Bl7aMw/x/dH7dXDL/6B3yBlCCRaZE7OhB7vEWSUwUOpMALofHFx2RFH1KmbWQg7WO4n7REUfLfxM/8bV8ecA/A0F+qVAf6vvhWJc3oWBR67S3fKLAVfIxFWvpcLmDsj2g8wFVUF74d4BXN7B07qHwu9qdVyQZwWvlwuwIFsR+8hjcOHiiicwvtQEZAEdDz0yEOHe3oddMHo//ZdHri+XKLN4aniaFoocHGh4xGDmB3KoUz4gyvHqUUdJfVHRmb4neIZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QdkSqBkuokiGOKpeDYG3iGV7UhSBYBBzbEu2Vf+VxvM=;
 b=gnb3f7UtaEpk4tWIkPJDPRr6AhP62vxKJJkouGqDTysQ5fQqqq0GJtN7WZXRYTN0SPcmK+VuVYgIx1KNtDVnNd0yAkXJBC0POnB9X8Vu6Rlg6TrDRX8/dC9KJnrSL5OTn1XXVPB+1MTl/zuc8VylxXc3DmA5ZM4oK3Js0I9aJZGz/fr+M+/77yPjwJLFXL0nQb6n3500ReYHABOStuzaQJIR9rMvqIS3UMt25pUqtTKL0BCP8cKj008v9cOYxG6sZoUdWwErKBAU4/3HGKivgDaFjkAf/68zUQDFrXphpvgWeFPeDd6a0aTUepN1X7Ko1EWzw4Y0Eh0fZZFB56Cd3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QdkSqBkuokiGOKpeDYG3iGV7UhSBYBBzbEu2Vf+VxvM=;
 b=AygNgtCWGGf5QBMe077NNWBxIhIW+vFPDEL41mpQyCQih6GqcauwFJRWoEUtsYQGnSiUEYjJT/mkt2duze0hwqktpLiIfTaWGzGZOEbxOCcJXNnhvdO9CNtkCfy0S8FxrbtMiKIOdFeTWInVQAuaMEfZRppZZU7iFOHfEtnKB4w=
Received: from OSZPR01MB8611.jpnprd01.prod.outlook.com (2603:1096:604:18e::7)
 by TY3PR01MB10402.jpnprd01.prod.outlook.com (2603:1096:400:253::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Tue, 30 Jan
 2024 00:46:50 +0000
Received: from OSZPR01MB8611.jpnprd01.prod.outlook.com
 ([fe80::bb56:7a5f:9ec4:27e7]) by OSZPR01MB8611.jpnprd01.prod.outlook.com
 ([fe80::bb56:7a5f:9ec4:27e7%3]) with mapi id 15.20.7249.017; Tue, 30 Jan 2024
 00:46:50 +0000
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: Frank Li <Frank.li@nxp.com>
CC: "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "kishon@kernel.org"
	<kishon@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "marek.vasut+renesas@gmail.com"
	<marek.vasut+renesas@gmail.com>, "fancer.lancer@gmail.com"
	<fancer.lancer@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v20 02/19] PCI: dwc: Change arguments of
 dw_pcie_prog_outbound_atu()
Thread-Topic: [PATCH v20 02/19] PCI: dwc: Change arguments of
 dw_pcie_prog_outbound_atu()
Thread-Index: AQHZ1zcOgOrVa94Q1UyCE5iBYX2OYbDyWmcAgAAhozA=
Date: Tue, 30 Jan 2024 00:46:50 +0000
Message-ID:
 <OSZPR01MB861111631AEBD1353E085EB3D87D2@OSZPR01MB8611.jpnprd01.prod.outlook.com>
References: <20230825093219.2685912-1-yoshihiro.shimoda.uh@renesas.com>
 <20230825093219.2685912-3-yoshihiro.shimoda.uh@renesas.com>
 <ZbgpzPjS7Jhe8fq5@lizhi-Precision-Tower-5810>
In-Reply-To: <ZbgpzPjS7Jhe8fq5@lizhi-Precision-Tower-5810>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8611:EE_|TY3PR01MB10402:EE_
x-ms-office365-filtering-correlation-id: e15361c5-c3c0-47ad-ea2b-08dc212cf1eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 OKfkCGT88twcOpO36ezClHP6ORRyjUiBUZSR3SDNg/vsr/Emsb0quQgcssFF6O+Vzr08eONqlm1MitGMs3mf5BXEu6SSbemu9QbPadihU1U9oCEm/pWd1kbDgLk++3q3CmviYQeIggwDAu9Spf7Ut1kslxZNNmDwa3O3y/E6DK//ixS9rdn2uI3hoC/V+B0Uv3JVvaU0ocYS3ZNRkVcAWJ+xkmkVKuSiQhH9VPwQPF09DZOrX/Uf1Ttiu1ubKwtEZz1JNbO0ulb5DbcoX3l1nWvb4JnoSvceB+aM57vr1WA7FOZQdp/B1/Cwchjw3P5bdL+tdh/TPxlD1R2tyJdm1Z3rYm4lPYS0uySregbLTzV055Sez40SUZXP6xkmbaGTeHgcbyQyfI9Jfsc/chyCMGS6SlOT9UTnQWIT3l/7IxHkWbKwCgdscSBfNu/1bTc0FGkR9HiSwIlrUSmSChkvlB8z6w20apIwDbii3ldzqRKFWdYmEHZb9BZa3QpBrkefum8YiU6KRgjqp9KWtfgMRLRh29sVcUdvONZlaDV44i0UoC/V1SmFtH9OqdkxsENLZGC7bdkXq7pwVjVjLjHLNMclI6aeR3oleglxPXJ2JWU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8611.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(366004)(39860400002)(136003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(26005)(41300700001)(55016003)(66446008)(966005)(9686003)(64756008)(38070700009)(316002)(6916009)(54906003)(478600001)(6506007)(55236004)(7696005)(45080400002)(71200400001)(66946007)(83380400001)(66476007)(38100700002)(122000001)(76116006)(66556008)(5660300002)(30864003)(7416002)(86362001)(33656002)(4326008)(8676002)(8936002)(52536014)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?JJxnOqki/ckim6B+Kcauo9Kv1PokImGf9CVsR0oR7j4JRrbD6BpOSevDuJ1T?=
 =?us-ascii?Q?t6ChQ1qTBMy3gfzwjhWo/PtoMAz3vLYZt3XijQXRaxztIilqs2LIgbtGb8sL?=
 =?us-ascii?Q?pzbK+tbL8naZbTnCzIETPz5xXkSWqjsRHwLj3KH3IYsx+b/ist7LGeeaRuQW?=
 =?us-ascii?Q?1KvliMT9vI0xvV8gQLqCJwckn84Je7yy153aZD+fFYGE4NLTgS+12v8oMPgJ?=
 =?us-ascii?Q?3Np8W76nRI3shgZ+W0m4Z0szYhQnZdOQovzHWBM7TY88L7APFb9+1Ole9dbc?=
 =?us-ascii?Q?i9dTKIJqLtCQmx4iHZDm0JBKH/2L6kO1Trc2ifQ9QgFDwGhCtw1kbOPMWHxe?=
 =?us-ascii?Q?/VaoKuG1oCV2t6Mk93tCbSpm+XdgH0taOzOIMfsh6LoiBiutbxMqspkEVPu9?=
 =?us-ascii?Q?PBADvCkALTxaN562ZxeS96A/MNRwl2B3T10WCR/FjGQcx+vuJo/RJSTEmSb1?=
 =?us-ascii?Q?vLSwGbv/tq9jTwPNyph2kd7e7StF2hGfxNNoFh8ciyWIKE0kU20HIRkBbfoc?=
 =?us-ascii?Q?6/xN2vVueBy9i2057ALHEbyy7/q9iSA+bxcd4HdlcAvWn1elkHaD7tnntgKV?=
 =?us-ascii?Q?r2dwllFxd7JQ0FJGAUIVLReLE/FX/U6soAV5juSqSyq2iRp7vDYPhtDJcF1R?=
 =?us-ascii?Q?OXFD4jvYahfLC1shTcSib9pXhaDowaHaj2YBGO2u8lO6q2rAjQuyPLVjahFV?=
 =?us-ascii?Q?uKUh/EO0jSnKoS0QWQNgqoEj8kEHz7yLdRGG96jhMMiABxwrVt1Ag+EonbvR?=
 =?us-ascii?Q?e6/5uP3rMHkZHaE7XyBCaPLoAalfUxqk4vqdiQdrWxJkuevOBnnUAe1s0iqS?=
 =?us-ascii?Q?vKhNE4Evp5F5y1I5qdr3YRyn7sDYGbOYO4VmIkdqOpkoPkjLjoN5eJg9tdds?=
 =?us-ascii?Q?4ecP0PTXyvoU83h2VhMFcwM46RJykQBKSYI5BJ5bsrlqe9PYUauGyoyrb51N?=
 =?us-ascii?Q?8eorhIBt/cA8TOL1fjmaE4vhvUaBc2feYyBun3Uo/BKs7ldYj8pZKxahuNV4?=
 =?us-ascii?Q?tyx0DF6UVSISKZns6DKmphPITZ7Qt3lshXHSM9rSA5gYejQI0VjQeRRKxa3l?=
 =?us-ascii?Q?Xk/WGyNjijTUhKOgVV1F8LKvn+MgOWZ9wJe7bv/nYTh4DddCEI94Q9eP5xUC?=
 =?us-ascii?Q?GMdUcChB8l9j/PHQUbejJRWZl3dBKphFGUQr0w7eaqgUoVxVrw6SB5TVTIkY?=
 =?us-ascii?Q?wchB+zSAEoWIlzkd56M7FfZGrDIWfVQ+Ndn/1REdbRmvHjqpXVqGcwvXgK7U?=
 =?us-ascii?Q?9nadz1v95ALiIY1gzOo1kfCrtZDAw2NvoSpYldn/z/0O9vf6zsojOUnaQ7qS?=
 =?us-ascii?Q?sYcE8nsurFSwFRBk4mNjnkeMl0ZtE7EwIML4d4vQOkij2l9N20mvsCab2ie1?=
 =?us-ascii?Q?CeoElVYbkQDkojasLStpU0Q9OQAp2oPogULlGZb23yLhjH+GHW6M91hwIuK9?=
 =?us-ascii?Q?bnCoz2Bw3m53AH+WMupPhQNnJrW06jb9tYGskZER+bXzflHTVSLIOaN0o/KR?=
 =?us-ascii?Q?hlhQ1g11MBN4mMQfe1BmhnMCmxrhbdBMq2oYq1EdU8DrQXcIHUm6+kCp923q?=
 =?us-ascii?Q?Am+yvm3RMz33EYDkcOXRGxczX9wRXXZ5Ydi5iwOIGMdVnUU+xWwl+WahzJt9?=
 =?us-ascii?Q?1w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8611.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e15361c5-c3c0-47ad-ea2b-08dc212cf1eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 00:46:50.0700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UpUDQ31dhO54mHP7ZPMjk0pcc18S5hxct9A91yWnlLUrsgazEPTEJkI/TNtxEFH4qdzFWHFnCImiasZPVEQOgHco93HCJf+3BfxnvIde254lhtpsSMo/gWzJfbARCGCk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10402

> From: Frank Li, Sent: Tuesday, January 30, 2024 7:42 AM
>=20
> On Fri, Aug 25, 2023 at 06:32:02PM +0900, Yoshihiro Shimoda wrote:
> > This is a preparation before adding the Msg-type outbound iATU
> > mapping. The respective update will require two more arguments added
> > to __dw_pcie_prog_outbound_atu(). That will make the already
> > complicated function prototype even more hard to comprehend accepting
> > _eight_ arguments. In order to prevent that and keep the code
> > more-or-less readable all the outbound iATU-related arguments are
> > moved to the new config-structure: struct dw_pcie_ob_atu_cfg pointer
> > to which shall be passed to dw_pcie_prog_outbound_atu(). The structure
> > is supposed to be locally defined and populated with the outbound iATU
> > settings implied by the caller context.
> >
> > As a result of the denoted change there is no longer need in having
> > the two distinctive methods for the Host and End-point outbound iATU
> > setups since the corresponding code can directly call the
> > dw_pcie_prog_outbound_atu() method with the config-structure
> > populated. Thus dw_pcie_prog_ep_outbound_atu() is dropped.
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>=20
> Yoshihiro:
>=20
> 	I want to use this patch to send out PME message when suspend,
> which should be similar with raise INTx. Can I include your this patches =
in
> my PME enable patches list if your patch still not merge yet.

Sure!
This patch is not merged yet because INTx support requires framework modifi=
cation
and this INTx support is not mandatory for my environment [1].

[1]
https://lore.kernel.org/all/TYBPR01MB534141F4F7B419BFE473D9B5D8FAA@TYBPR01M=
B5341.jpnprd01.prod.outlook.com/

Best regards,
Yoshihiro Shimoda

> Frank
>=20
> > ---
> >  .../pci/controller/dwc/pcie-designware-ep.c   | 21 +++++---
> >  .../pci/controller/dwc/pcie-designware-host.c | 52 +++++++++++++------
> >  drivers/pci/controller/dwc/pcie-designware.c  | 49 ++++++-----------
> >  drivers/pci/controller/dwc/pcie-designware.h  | 15 ++++--
> >  4 files changed, 77 insertions(+), 60 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/=
pci/controller/dwc/pcie-designware-ep.c
> > index ab87ea3b0986..747d5bc07222 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > @@ -182,9 +182,8 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep=
 *ep, u8 func_no, int type,
> >  	return 0;
> >  }
> >
> > -static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep, u8 func_no,
> > -				   phys_addr_t phys_addr,
> > -				   u64 pci_addr, size_t size)
> > +static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep,
> > +				   struct dw_pcie_ob_atu_cfg *atu)
> >  {
> >  	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
> >  	u32 free_win;
> > @@ -196,13 +195,13 @@ static int dw_pcie_ep_outbound_atu(struct dw_pcie=
_ep *ep, u8 func_no,
> >  		return -EINVAL;
> >  	}
> >
> > -	ret =3D dw_pcie_prog_ep_outbound_atu(pci, func_no, free_win, PCIE_ATU=
_TYPE_MEM,
> > -					   phys_addr, pci_addr, size);
> > +	atu->index =3D free_win;
> > +	ret =3D dw_pcie_prog_outbound_atu(pci, atu);
> >  	if (ret)
> >  		return ret;
> >
> >  	set_bit(free_win, ep->ob_window_map);
> > -	ep->outbound_addr[free_win] =3D phys_addr;
> > +	ep->outbound_addr[free_win] =3D atu->cpu_addr;
> >
> >  	return 0;
> >  }
> > @@ -305,8 +304,14 @@ static int dw_pcie_ep_map_addr(struct pci_epc *epc=
, u8 func_no, u8 vfunc_no,
> >  	int ret;
> >  	struct dw_pcie_ep *ep =3D epc_get_drvdata(epc);
> >  	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
> > -
> > -	ret =3D dw_pcie_ep_outbound_atu(ep, func_no, addr, pci_addr, size);
> > +	struct dw_pcie_ob_atu_cfg atu =3D { 0 };
> > +
> > +	atu.func_no =3D func_no;
> > +	atu.type =3D PCIE_ATU_TYPE_MEM;
> > +	atu.cpu_addr =3D addr;
> > +	atu.pci_addr =3D pci_addr;
> > +	atu.size =3D size;
> > +	ret =3D dw_pcie_ep_outbound_atu(ep, &atu);
> >  	if (ret) {
> >  		dev_err(pci->dev, "Failed to enable address\n");
> >  		return ret;
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/driver=
s/pci/controller/dwc/pcie-designware-host.c
> > index 5c8cbc3afae4..01eff83c1f6d 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -551,6 +551,7 @@ static void __iomem *dw_pcie_other_conf_map_bus(str=
uct pci_bus *bus,
> >  {
> >  	struct dw_pcie_rp *pp =3D bus->sysdata;
> >  	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
> > +	struct dw_pcie_ob_atu_cfg atu =3D { 0 };
> >  	int type, ret;
> >  	u32 busdev;
> >
> > @@ -573,8 +574,12 @@ static void __iomem *dw_pcie_other_conf_map_bus(st=
ruct pci_bus *bus,
> >  	else
> >  		type =3D PCIE_ATU_TYPE_CFG1;
> >
> > -	ret =3D dw_pcie_prog_outbound_atu(pci, 0, type, pp->cfg0_base, busdev=
,
> > -					pp->cfg0_size);
> > +	atu.type =3D type;
> > +	atu.cpu_addr =3D pp->cfg0_base;
> > +	atu.pci_addr =3D busdev;
> > +	atu.size =3D pp->cfg0_size;
> > +
> > +	ret =3D dw_pcie_prog_outbound_atu(pci, &atu);
> >  	if (ret)
> >  		return NULL;
> >
> > @@ -586,6 +591,7 @@ static int dw_pcie_rd_other_conf(struct pci_bus *bu=
s, unsigned int devfn,
> >  {
> >  	struct dw_pcie_rp *pp =3D bus->sysdata;
> >  	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
> > +	struct dw_pcie_ob_atu_cfg atu =3D { 0 };
> >  	int ret;
> >
> >  	ret =3D pci_generic_config_read(bus, devfn, where, size, val);
> > @@ -593,9 +599,12 @@ static int dw_pcie_rd_other_conf(struct pci_bus *b=
us, unsigned int devfn,
> >  		return ret;
> >
> >  	if (pp->cfg0_io_shared) {
> > -		ret =3D dw_pcie_prog_outbound_atu(pci, 0, PCIE_ATU_TYPE_IO,
> > -						pp->io_base, pp->io_bus_addr,
> > -						pp->io_size);
> > +		atu.type =3D PCIE_ATU_TYPE_IO;
> > +		atu.cpu_addr =3D pp->io_base;
> > +		atu.pci_addr =3D pp->io_bus_addr;
> > +		atu.size =3D pp->io_size;
> > +
> > +		ret =3D dw_pcie_prog_outbound_atu(pci, &atu);
> >  		if (ret)
> >  			return PCIBIOS_SET_FAILED;
> >  	}
> > @@ -608,6 +617,7 @@ static int dw_pcie_wr_other_conf(struct pci_bus *bu=
s, unsigned int devfn,
> >  {
> >  	struct dw_pcie_rp *pp =3D bus->sysdata;
> >  	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
> > +	struct dw_pcie_ob_atu_cfg atu =3D { 0 };
> >  	int ret;
> >
> >  	ret =3D pci_generic_config_write(bus, devfn, where, size, val);
> > @@ -615,9 +625,12 @@ static int dw_pcie_wr_other_conf(struct pci_bus *b=
us, unsigned int devfn,
> >  		return ret;
> >
> >  	if (pp->cfg0_io_shared) {
> > -		ret =3D dw_pcie_prog_outbound_atu(pci, 0, PCIE_ATU_TYPE_IO,
> > -						pp->io_base, pp->io_bus_addr,
> > -						pp->io_size);
> > +		atu.type =3D PCIE_ATU_TYPE_IO;
> > +		atu.cpu_addr =3D pp->io_base;
> > +		atu.pci_addr =3D pp->io_bus_addr;
> > +		atu.size =3D pp->io_size;
> > +
> > +		ret =3D dw_pcie_prog_outbound_atu(pci, &atu);
> >  		if (ret)
> >  			return PCIBIOS_SET_FAILED;
> >  	}
> > @@ -652,6 +665,7 @@ static struct pci_ops dw_pcie_ops =3D {
> >  static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
> >  {
> >  	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
> > +	struct dw_pcie_ob_atu_cfg atu =3D { 0 };
> >  	struct resource_entry *entry;
> >  	int i, ret;
> >
> > @@ -679,10 +693,13 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *=
pp)
> >  		if (pci->num_ob_windows <=3D ++i)
> >  			break;
> >
> > -		ret =3D dw_pcie_prog_outbound_atu(pci, i, PCIE_ATU_TYPE_MEM,
> > -						entry->res->start,
> > -						entry->res->start - entry->offset,
> > -						resource_size(entry->res));
> > +		atu.index =3D i;
> > +		atu.type =3D PCIE_ATU_TYPE_MEM;
> > +		atu.cpu_addr =3D entry->res->start;
> > +		atu.pci_addr =3D entry->res->start - entry->offset;
> > +		atu.size =3D resource_size(entry->res);
> > +
> > +		ret =3D dw_pcie_prog_outbound_atu(pci, &atu);
> >  		if (ret) {
> >  			dev_err(pci->dev, "Failed to set MEM range %pr\n",
> >  				entry->res);
> > @@ -692,10 +709,13 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *=
pp)
> >
> >  	if (pp->io_size) {
> >  		if (pci->num_ob_windows > ++i) {
> > -			ret =3D dw_pcie_prog_outbound_atu(pci, i, PCIE_ATU_TYPE_IO,
> > -							pp->io_base,
> > -							pp->io_bus_addr,
> > -							pp->io_size);
> > +			atu.index =3D i;
> > +			atu.type =3D PCIE_ATU_TYPE_IO;
> > +			atu.cpu_addr =3D pp->io_base;
> > +			atu.pci_addr =3D pp->io_bus_addr;
> > +			atu.size =3D pp->io_size;
> > +
> > +			ret =3D dw_pcie_prog_outbound_atu(pci, &atu);
> >  			if (ret) {
> >  				dev_err(pci->dev, "Failed to set IO range %pr\n",
> >  					entry->res);
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci=
/controller/dwc/pcie-designware.c
> > index 2459f2a61b9b..49b785509576 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -464,56 +464,56 @@ static inline u32 dw_pcie_enable_ecrc(u32 val)
> >  	return val | PCIE_ATU_TD;
> >  }
> >
> > -static int __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no=
,
> > -				       int index, int type, u64 cpu_addr,
> > -				       u64 pci_addr, u64 size)
> > +int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
> > +			      const struct dw_pcie_ob_atu_cfg *atu)
> >  {
> > +	u64 cpu_addr =3D atu->cpu_addr;
> >  	u32 retries, val;
> >  	u64 limit_addr;
> >
> >  	if (pci->ops && pci->ops->cpu_addr_fixup)
> >  		cpu_addr =3D pci->ops->cpu_addr_fixup(pci, cpu_addr);
> >
> > -	limit_addr =3D cpu_addr + size - 1;
> > +	limit_addr =3D cpu_addr + atu->size - 1;
> >
> >  	if ((limit_addr & ~pci->region_limit) !=3D (cpu_addr & ~pci->region_l=
imit) ||
> >  	    !IS_ALIGNED(cpu_addr, pci->region_align) ||
> > -	    !IS_ALIGNED(pci_addr, pci->region_align) || !size) {
> > +	    !IS_ALIGNED(atu->pci_addr, pci->region_align) || !atu->size) {
> >  		return -EINVAL;
> >  	}
> >
> > -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_LOWER_BASE,
> > +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_LOWER_BASE,
> >  			      lower_32_bits(cpu_addr));
> > -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_UPPER_BASE,
> > +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_UPPER_BASE,
> >  			      upper_32_bits(cpu_addr));
> >
> > -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_LIMIT,
> > +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_LIMIT,
> >  			      lower_32_bits(limit_addr));
> >  	if (dw_pcie_ver_is_ge(pci, 460A))
> > -		dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_UPPER_LIMIT,
> > +		dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_UPPER_LIMIT,
> >  				      upper_32_bits(limit_addr));
> >
> > -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_LOWER_TARGET,
> > -			      lower_32_bits(pci_addr));
> > -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_UPPER_TARGET,
> > -			      upper_32_bits(pci_addr));
> > +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_LOWER_TARGET,
> > +			      lower_32_bits(atu->pci_addr));
> > +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_UPPER_TARGET,
> > +			      upper_32_bits(atu->pci_addr));
> >
> > -	val =3D type | PCIE_ATU_FUNC_NUM(func_no);
> > +	val =3D atu->type | PCIE_ATU_FUNC_NUM(atu->func_no);
> >  	if (upper_32_bits(limit_addr) > upper_32_bits(cpu_addr) &&
> >  	    dw_pcie_ver_is_ge(pci, 460A))
> >  		val |=3D PCIE_ATU_INCREASE_REGION_SIZE;
> >  	if (dw_pcie_ver_is(pci, 490A))
> >  		val =3D dw_pcie_enable_ecrc(val);
> > -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_REGION_CTRL1, val);
> > +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL1, val);
> >
> > -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_REGION_CTRL2, PCIE_ATU_ENA=
BLE);
> > +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL2, PCIE_AT=
U_ENABLE);
> >
> >  	/*
> >  	 * Make sure ATU enable takes effect before any subsequent config
> >  	 * and I/O accesses.
> >  	 */
> >  	for (retries =3D 0; retries < LINK_WAIT_MAX_IATU_RETRIES; retries++) =
{
> > -		val =3D dw_pcie_readl_atu_ob(pci, index, PCIE_ATU_REGION_CTRL2);
> > +		val =3D dw_pcie_readl_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL2)=
;
> >  		if (val & PCIE_ATU_ENABLE)
> >  			return 0;
> >
> > @@ -525,21 +525,6 @@ static int __dw_pcie_prog_outbound_atu(struct dw_p=
cie *pci, u8 func_no,
> >  	return -ETIMEDOUT;
> >  }
> >
> > -int dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type=
,
> > -			      u64 cpu_addr, u64 pci_addr, u64 size)
> > -{
> > -	return __dw_pcie_prog_outbound_atu(pci, 0, index, type,
> > -					   cpu_addr, pci_addr, size);
> > -}
> > -
> > -int dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int =
index,
> > -				 int type, u64 cpu_addr, u64 pci_addr,
> > -				 u64 size)
> > -{
> > -	return __dw_pcie_prog_outbound_atu(pci, func_no, index, type,
> > -					   cpu_addr, pci_addr, size);
> > -}
> > -
> >  static inline u32 dw_pcie_readl_atu_ib(struct dw_pcie *pci, u32 index,=
 u32 reg)
> >  {
> >  	return dw_pcie_readl_atu(pci, PCIE_ATU_REGION_DIR_IB, index, reg);
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci=
/controller/dwc/pcie-designware.h
> > index 755bcb406769..296c5b1ddc91 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -298,6 +298,15 @@ enum dw_pcie_ltssm {
> >  	DW_PCIE_LTSSM_UNKNOWN =3D 0xFFFFFFFF,
> >  };
> >
> > +struct dw_pcie_ob_atu_cfg {
> > +	int index;
> > +	int type;
> > +	u8 func_no;
> > +	u64 cpu_addr;
> > +	u64 pci_addr;
> > +	u64 size;
> > +};
> > +
> >  struct dw_pcie_host_ops {
> >  	int (*host_init)(struct dw_pcie_rp *pp);
> >  	void (*host_deinit)(struct dw_pcie_rp *pp);
> > @@ -429,10 +438,8 @@ void dw_pcie_write_dbi2(struct dw_pcie *pci, u32 r=
eg, size_t size, u32 val);
> >  int dw_pcie_link_up(struct dw_pcie *pci);
> >  void dw_pcie_upconfig_setup(struct dw_pcie *pci);
> >  int dw_pcie_wait_for_link(struct dw_pcie *pci);
> > -int dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type=
,
> > -			      u64 cpu_addr, u64 pci_addr, u64 size);
> > -int dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int =
index,
> > -				 int type, u64 cpu_addr, u64 pci_addr, u64 size);
> > +int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
> > +			      const struct dw_pcie_ob_atu_cfg *atu);
> >  int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int type,
> >  			     u64 cpu_addr, u64 pci_addr, u64 size);
> >  int dw_pcie_prog_ep_inbound_atu(struct dw_pcie *pci, u8 func_no, int i=
ndex,
> > --
> > 2.25.1
> >

