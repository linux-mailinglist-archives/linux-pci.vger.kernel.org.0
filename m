Return-Path: <linux-pci+bounces-1089-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0210281589A
	for <lists+linux-pci@lfdr.de>; Sat, 16 Dec 2023 11:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4382028623D
	for <lists+linux-pci@lfdr.de>; Sat, 16 Dec 2023 10:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FF2134D9;
	Sat, 16 Dec 2023 10:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KwAg/cE8";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="wIqHBK4y"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F5C12E57
	for <linux-pci@vger.kernel.org>; Sat, 16 Dec 2023 10:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1702721492; x=1734257492;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=jr88BG8pj9vJDBiDPqvthAeYfULc5XQeVMJxnByFk+c=;
  b=KwAg/cE8ELBtWqnv1tvvApjWaN+uQMqENP0WnLDPut7a9Q6doctdH7Lg
   Btr3eryNVouJ1PIbLt4Ek8YMpGKUpn27laoHcRlxCLP1QwOrycVchKqJA
   U/c/9RH3VaETs1a54VaIsJp6Qx3sBiCidjFJ6vRsQVG3Fte4NS3QEVvT7
   rfvxBhdMw5zujInTG+KKrWWKqFibdN4u66Hs1Iv8/Yxda9xDJymsnNw7w
   SFjSL/Zx85E+y5rDyMirDnEZI7WUyesZnxri6L3mnOcFLgIaOsM1xa50z
   DrpjzHB7qtyfjb4k4RDGJht55V0aPgG7c3cE0QizNUfluY1mcG3oABEtz
   w==;
X-CSE-ConnectionGUID: 494rLkoGSW+hRZbGtoGfdQ==
X-CSE-MsgGUID: 8KxkwV4QQ6iwY152TRS63Q==
X-IronPort-AV: E=Sophos;i="6.04,281,1695657600"; 
   d="scan'208";a="4985249"
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
  by ob1.hgst.iphmx.com with ESMTP; 16 Dec 2023 18:11:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F2/ug9+/KCve1YS46fNjyi/pLx5y+4L9v8ci0MhguKa1jDnO6d+D5lstFmWYi0/f25205sXKAAe2Cp+oF9dRWqBLWI8KpFNfPn8xZD/9KH0sgKJg56Ye5/GSsuG+yv0cFBtahhQhILJBIdoVr68Y6FZThERe1C73+QX1gkOgtoqP6xAD1zx9BF3DnPwXxJLdLJJ3B2LrBS/lNTxBQgs0c8nOG9igeCPGGfLQUcU5rTlQRuUVyKNqXdFnvx6Ufr+bajeV4HBBmUSWDDGXVhNgszJfCXCNegb+LJXYKYgxEjeK42QhRBSHbf6rYulHYres8lxA8N10w/wf/4GIOy1Wvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ByZtv420aUlYpb4XeDB6nX+X9dHEgGWAFhJ02fJyGi8=;
 b=Optd7tybAEsElSPsoAmAbWeNoFQNzTXgWibq1+lkEdbi/x3vWz9GGNmoqayamPVP44yGPLoY466BjazDCMmNaugZKfbreZFwg/ZqNzlPvJa2W4oqzge1St7VZ59GjgAPsQwIZh/RmXZVh12yLIbL/+41gK0WCecZ7aJHW4mUynUw1BjrY11Jctor8AT1wqQetFKECbHbdAPA7VL9GP2YvJaTHoZJW9J+TDtneR4NasFKgyww+nT5E4BcS1oOO67iUTcdRrzgJ9gaceG342ZiWWwgdi85LBY0JDlaM5HsqJ+M8cJ6R1+phV1vZvNFTjtmbRYhBlMRioJb9CGBGBVjsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ByZtv420aUlYpb4XeDB6nX+X9dHEgGWAFhJ02fJyGi8=;
 b=wIqHBK4yWMyT80+6RWf7YbqCPuH8vmbIagtfNn+P0qPHDtoZX67J4onTHSM1aKDNDkUk6O9xACVwDAMoTFDbH+zUcWi7KgF92Hmr/7aWHimCRYd0qd1Wb/HzmXD5F3WymBnGERILjyyk2TSdMfoCmkbcWazmAVq6kSXRvLySA7c=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by IA0PR04MB9035.namprd04.prod.outlook.com (2603:10b6:208:48a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Sat, 16 Dec
 2023 10:11:20 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ffca:609a:2e2:8fa0]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ffca:609a:2e2:8fa0%4]) with mapi id 15.20.7091.030; Sat, 16 Dec 2023
 10:11:20 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Frank Li <Frank.li@nxp.com>
CC: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Vidya Sagar
	<vidyas@nvidia.com>, "helgaas@kernel.org" <helgaas@kernel.org>,
	"kishon@ti.com" <kishon@ti.com>, "lorenzo.pieralisi@arm.com"
	<lorenzo.pieralisi@arm.com>, "kw@linux.com" <kw@linux.com>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
	"lznuaa@gmail.com" <lznuaa@gmail.com>, "hongxing.zhu@nxp.com"
	<hongxing.zhu@nxp.com>, "jdmason@kudzu.us" <jdmason@kudzu.us>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>, "allenbh@gmail.com"
	<allenbh@gmail.com>, "linux-ntb@googlegroups.com"
	<linux-ntb@googlegroups.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] PCI: designware-ep: Allow pci_epc_set_bar() update
 inbound map address
Thread-Topic: [PATCH v2 1/4] PCI: designware-ep: Allow pci_epc_set_bar()
 update inbound map address
Thread-Index: AQHaLpoq6KpaLC8u+Emi7PiHDdomg7Co5ImAgABU+gCAAAhAgIAAChAAgAJnZAA=
Date: Sat, 16 Dec 2023 10:11:19 +0000
Message-ID: <ZX13xhBm3RmshqgD@x1-carbon>
References: <20220222162355.32369-1-Frank.Li@nxp.com>
 <20220222162355.32369-2-Frank.Li@nxp.com> <ZXsRp+Lzg3x/nhk3@x1-carbon>
 <ZXsc57whj/3e/+zq@lizhi-Precision-Tower-5810> <ZXtkMC1ZjsgHMRvT@x1-carbon>
 <ZXtrG40SR81YAR6a@lizhi-Precision-Tower-5810>
 <ZXtzjIIl5oabviZI@lizhi-Precision-Tower-5810>
In-Reply-To: <ZXtzjIIl5oabviZI@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|IA0PR04MB9035:EE_
x-ms-office365-filtering-correlation-id: e965d929-3550-4e51-ba6d-08dbfe1f5967
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 8QiSFDStHWBcS5E+qBkzpP4VEAhyBbYpnfErTRb5Y3AqjHtXeuhcI6e3jBJcn4+/rEgZuBt6fnwfI+sZSJ4MLJGGoecc8ANReoSaFGwSn+Yrbq2B7jn3Q6Ij3idEd+CicXqgdQRdzh0NcUG6CYPAe13/9dmDDfsDZ7SYYZs9DxpTu/mccTP22zd99QtG67YGT8nQQXXcFJwrl7Mz0eHbfCmSKZcu7dlUK9iJY4nTazMIs+Rgsi4758zFMtP1aOmtNBiD/a9ZNcYyaWsecOwJ/Va8wVPHSMjaiZHmb7kY1U7CgHE4nSe55yyeDh5kdAUO2wcn3JH3lmb3gKdcqIHxI+dpIMrnNLf6X2edZ7GqhF1yLpgMA2UdFHXn358Q9keQqJgO1qDnoTryE5tGusTKesyp7vlgsgki+s6UN1aauf92CqarWch1kR8t5RVsMoJMYB0rl2hO0gkVHw11+YcDZbSGrOZKVpQ0pXIo9R+NqJ3QpAfe7x9ACrFe/XBrr4v3Q8gKUg40qiLbiHN69dS65dO8OhnNZ4AoVQnN72HwwOBFaNLEES4+P8qxv+DnndT3ya7oFzYunRWFHQ3Kv2+pwswm0Is8bEta6H7dhXrulkE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(39860400002)(366004)(396003)(136003)(376002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(26005)(6506007)(6512007)(5660300002)(83380400001)(7416002)(4326008)(2906002)(54906003)(91956017)(33716001)(41300700001)(478600001)(966005)(64756008)(8936002)(76116006)(316002)(6916009)(66946007)(66446008)(66476007)(66556008)(6486002)(8676002)(71200400001)(9686003)(82960400001)(122000001)(38100700002)(86362001)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?CubDycGvnkui/WF6Mycivauxtcqps4RFF6sGlR0ONw1+q6PvqViBmGSQUri8?=
 =?us-ascii?Q?00FCV6NqP43Gl6QDeb4D0TApahMEsAGSIT20im18lPuek72DbR9uv5y4PY6N?=
 =?us-ascii?Q?AEupZRjKRhjLwHrK3aUUUuSb+8W23LmhqUAKsUOE0kjY0h/OfhNFDbOZx/bB?=
 =?us-ascii?Q?sFiGd3yBcEq0lYEDXDSZa3eRhhv/xL5haB29lbreYvQ566zaf455OSB9kE5w?=
 =?us-ascii?Q?YZM6Zk+zTsNU+21Zqwtm00asskSAmYxcqwNBZaGiLlz3zUl3zZ3aMwRQnjbo?=
 =?us-ascii?Q?tCiVgUYr/m/DTMQOVMab38BpDRkTK8QGtIFU+0a6S+tUpE4mWQzJqCf1TyzO?=
 =?us-ascii?Q?lfFghDoOllWkc5sETeDVvY20FUi4ROJImcHVnTTXczT9Gzmao3pQdOCXyPfc?=
 =?us-ascii?Q?w63+o0DK3yWM3mKokOZXFGkoBJaqynax/1EWxyGeBxnmMm1Td7RUYPjBPgwc?=
 =?us-ascii?Q?Oa9G/pWvz95EA5Qi1KYcZnD2GFptvJpQXx8VwGMyAr7UB4MqCxQlC4Dq20oS?=
 =?us-ascii?Q?toehrnfxCXwpEKR6F+u1VpMu/E53n51NakVNRisdoow7IqmOH4nmesekZdqJ?=
 =?us-ascii?Q?+ukjKJxiCK+xRP+qRlEI7ZgbsZrtMcZKnsZ3oQXM33ucy3E9+cYXm+bBdb60?=
 =?us-ascii?Q?TednF8XL3iQly9ZCNNfldZQquzuCTNjpks/9OkbDWm+1e2QXR8S5voBteAnm?=
 =?us-ascii?Q?ftiyUlybPMSivrGYI5hmUFI4TrtXdc9mYpQErdEzq+qGorIltGoUL46NvLM8?=
 =?us-ascii?Q?DwPMudZMiwejBuhWMUMNFVTa8R/WkVz0Jk+ZmX5Oq6SBowjNS9SawGPWPpAa?=
 =?us-ascii?Q?fpCCJaGH17ZqLlP0CQZBu477nYSMx7YtBOXluy6l5PzXddGvvLylfm3H8QiK?=
 =?us-ascii?Q?s/0Dw3auI1X11phLrnPXVRwrKi+XZwTF7UuW4MN0t14NYVTeZE3cM1JdLC/t?=
 =?us-ascii?Q?fXVWZtXKkH2TU+sorpj8E/2uAMMSAqThH0QsZn1a4YN+Z5b7NsaE0sEbs5zk?=
 =?us-ascii?Q?+8ASztz1pwfuf/8l6DzS6Wvfvdp+csNHngSraG/MPytrKIedVQrrNykVvUoa?=
 =?us-ascii?Q?hE0A7bvR9AxwfjWmZAKMlYfMRDP1wNXExzIszvxlZmBGkaoBcQsnq501EMeB?=
 =?us-ascii?Q?S1G1SrMBVw7fn5MIIYylmLxC5wvHeKwpuvqKuBKf74Ex8TBdRR/hmJOpycK+?=
 =?us-ascii?Q?HrZZXEXTJg1MZ13cpKHlfbTjLd6/5TcD071+ABlIg0E8LekWIy3S1pMf7irc?=
 =?us-ascii?Q?MY5YRcjt9eyM2CZUdCTQYaXEr3Dmzi9rmtRtiXjTKtwYqFTsOdogokUVkrSv?=
 =?us-ascii?Q?nW4yjklA6k1HRWJhGX2B9Zq8nHFfSIDCNSA95yv/kQSnnsJnFOoCcZu+sGG0?=
 =?us-ascii?Q?np83It5tiM5xJCkjH9DoyYosbUiIOTD8olHrJeBKmhcZ/8gTUElz2U44tnV0?=
 =?us-ascii?Q?BoiFt+ygTWkFYVKkjeSi5h7gMh5RIAagees3CPOsSIO/IlrYxNaMq624L2tL?=
 =?us-ascii?Q?PzIAoxPjjQRD0HvgPZTrIGhG/3OK6E+jiUSPMd9W7BujigN8iQzC7pjQOu+v?=
 =?us-ascii?Q?MwPKRjerhlprEvNa2dwzgPUfWmXFE7H1HiCHS46BlBdwzsaWg+qCMNbONS8s?=
 =?us-ascii?Q?aw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <32E8D0F7A8AC164E883CC91B8DC5093E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BY3UDewBI+pYGYc2GrIyYoQ6ckuKf2UBkuQeWzlJUo/BFHyWUjeGDIcgmaQEShVI8SDfiubh7N3uwwE/c88MxSHevxWniTgymNFqfKfGc1Fb3silJ52vj0WIlre8pLdExQQ4NA98Y8rgjPx/VsnmMhpIt/mUAocnuBDOb2DZanTVLERaKfl7D9kofINlsBu+UEtReHh7iqbZLb7AIvXaaKxQjrTTl4EN+Ze5SxR29CmkTtq3f9oNSsIKn1Ppb5Uv2Z2ZkzzK4b7i9m9/2/b1ERRDGRICAGUdvmWTOBCIrq75kk1bpZSrUrVcXdRSV5PQlkevKrG+g9yHw78qNamz6hrLUEFMMKKBMqGDp5Cw3dVCC+SxTnf2UOb93T4hqqeI58r7J8bCb9GBGuUKgdZapDMJ8uag0T5nAdGrsMGYuRfKbrD+5elfvUIHz4E5yDPyZvSPBFZpRU5c1E+DsppaErBEI1DGGXP1ZvmxZANRbW5yix+Ae3WQ1Q1Ry5gWE7WO9Dh63m0eIDXd+awMtElkHyymoEb8a90sbBp8sv765PBl3MqI6QM2l+NxLo94ZJnD9ynrpfG4pUfTUiq+rAsCQdeSqBfqv8q715gYOhr6GejcHvJh3T1l2qwp0YEJFFqy
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e965d929-3550-4e51-ba6d-08dbfe1f5967
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2023 10:11:20.0294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dw/vcvUaReB2dJ7wFodQXDRfRXPFKWhCS6R4jX/ErJqtwygAdUnD+NXfj1pReBc7+2HGwsFAQ1b+wsshSfIraw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR04MB9035

On Thu, Dec 14, 2023 at 04:28:44PM -0500, Frank Li wrote:
>=20

(snip)

> Does below change fix your problem?

It is basically the same fix as I sent out earlier in this thread,
but yes, it does solve 1 out of 2 problems introduced by the patch
in $subject, so:

Tested-by: Niklas Cassel <niklas.cassel@wdc.com>

> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pc=
i/controller/dwc/pcie-designware-ep.c
> index f6207989fc6ad..2868d44649ef7 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -177,7 +177,7 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *=
ep, u8 func_no, int type,
>         if (!ep->bar_to_atu[bar])
>                 free_win =3D find_first_zero_bit(ep->ib_window_map, pci->=
num_ib_windows);
>         else
> -               free_win =3D ep->bar_to_atu[bar];
> +               free_win =3D ep->bar_to_atu[bar] - 1;
> =20
>         if (free_win >=3D pci->num_ib_windows) {
>                 dev_err(pci->dev, "No free inbound window\n");
> @@ -191,7 +191,7 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *=
ep, u8 func_no, int type,
>                 return ret;
>         }
> =20
> -       ep->bar_to_atu[bar] =3D free_win;
> +       ep->bar_to_atu[bar] =3D free_win + 1;
>         set_bit(free_win, ep->ib_window_map);
> =20
>         return 0;
> @@ -228,7 +228,7 @@ static void dw_pcie_ep_clear_bar(struct pci_epc *epc,=
 u8 func_no, u8 vfunc_no,
>         struct dw_pcie_ep *ep =3D epc_get_drvdata(epc);
>         struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
>         enum pci_barno bar =3D epf_bar->barno;
> -       u32 atu_index =3D ep->bar_to_atu[bar];
> +       u32 atu_index =3D ep->bar_to_atu[bar] - 1;

You probably want to add a:

if (!ep->bar_to_atu[bar])
	return;

here, so that dw_pcie_ep_clear_bar() will never try to use -1 as index.
(E.g. if clear_bar() is called twice on the same BAR.)

> =20
>         __dw_pcie_ep_reset_bar(pci, func_no, bar, epf_bar->flags);
>=20

(snip)

> > > from dw_pcie_ep_set_bar(), also needs to be dropped, so that the iATU
> > > settings will be re-written for platforms with core_init_notifiers.
> > >=20
> > > Right now, for a platform with a core_init_notifier, if you run
> > > pci_endpoint_test + reboot the RC (so that PERST is asserted + deasse=
rted),
> > > and then run pci_endpoint_test again, then I'm quite sure that
> > > pci_endpoint_test will not pass the second time (because iATU setting=
s
> > > were not rewritten after reset).
> > >=20
> > > It would be nice if Mani or Vidya could confirm this.

So problem 2 out of 2 introduced by the patch in $subject is that
DWC drivers with a .core_init_notifier, will perform a reset_control_assert=
()
to reset the core (which will reset both sticky and non-sticky registers),
which means that the early return in dw_pcie_ep_set_bar():
https://github.com/torvalds/linux/blob/v6.7-rc5/drivers/pci/controller/dwc/=
pcie-designware-ep.c#L268-L269

while returning after the iATU settings have been written,
it will return before:

	dw_pcie_writel_dbi2(pci, reg_dbi2, lower_32_bits(size - 1));
	dw_pcie_writel_dbi(pci, reg, flags);

Which means that, for drivers with a .core_init_notifier, BARx_REG and
BARx_MASK registers will not be written. This means that they will have
reset values for these registers, which means that e.g. the BAR_SIZE
(which is defined by BARx_MASK) might be incorrect for these platforms
because this function returns early.

I will not send a fix for this problem, I will leave that to you, or Mani,
or Vidya, and hope that people are happy that I simply reported this issue.


Here is my suggested solution in case anyone wants to take a stab at it:

> > > I guess one option would be modify dw_pcie_ep_init_notify() to call
> > > dw_pcie_ep_clear_bar() on all non-NULL BARs stored in ep->epf_bar[],
> > > before calling pci_epc_init_notify(). That way the second .core_init
> > > (pci_epf_test_core_init()) call will use write the settings, because
> > > ep->epf_bar[] will be empty, so the "write the settings only the firs=
t
> > > time" approach will then also work for core_init_notifier platforms.


Kind regards,
Niklas=

