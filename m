Return-Path: <linux-pci+bounces-1015-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D622F813B75
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 21:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B9902830DB
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 20:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99705208BD;
	Thu, 14 Dec 2023 20:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NK7OQyqH";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="fGBcyAsm"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27178675CD
	for <linux-pci@vger.kernel.org>; Thu, 14 Dec 2023 20:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1702585468; x=1734121468;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6Msb+ctXjg+CLmyHhFayhkHNwbUPZWjgvhKcWq2hZUY=;
  b=NK7OQyqHozQRFMDxUs+rFaIsqXSLmTM13haxJcnMMS0NkQT2oI3V27lq
   toGWb93L1ByN6vqeP4k4W5hgkN3B/g2131av/xnu5wUHip41EicUIEdE1
   lumdu8sbx6Dw9rPhFA/4wkkBebYzvHQjer8JBRDhLCB3/G+nO6OK1Zb9P
   JORZNh/fyn4wpGXUOmulBvLf9h0Rgf+lxc2Sv9Ws62P1SmnMGudY9RUKC
   9u4tyh98d9tqa7j51SVm78E5ReIBKNtZKfkT2sRKg3Gipe54Jz38qV6es
   75d3k7x8NCufpetmQAOL5KvIOfxkWR2Zfb7Z3/tLawOOx+LcB+mkjmsdb
   w==;
X-CSE-ConnectionGUID: BTtHMM6eTrmEKIumBA93Qw==
X-CSE-MsgGUID: 7u3Dwn5ySqOIpXBmc3s87A==
X-IronPort-AV: E=Sophos;i="6.04,276,1695657600"; 
   d="scan'208";a="4855385"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
  by ob1.hgst.iphmx.com with ESMTP; 15 Dec 2023 04:23:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GccXy/fvNYlXbkOV1efLe8oSBRpEqbRgaKmJ+Vph4qx3inje2WBpmRDqAkLF+Q85Krz56AMbXXLxBkklb7wMmXOc+dImpaOiErOdUStXdi9kpwtnK52aD925U6av5OjdfezMtkp2LCNKYWIj/ly/45wv5LIzi/MwtTfrS7Yk9gwhwl5Y5S7FBSlsnciD2HAHv7Bheaqc8JOq0NKFCepkLXaLREWDS0/Q7W+cZIOwjuHLmdbSYlNCQI5b/OvVZ22F4pKDmL2fZCVB/TgA0/rVFun/Ij3p9xCwkg8MTsnNjl+Ga3IMhhwmakL1dO8iV4+QqzR8elgH7VyO2xJeoMSS/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3yuplDu8+aTdKpp2ie3JDrsmPEjj7oPTVzhpThYfpoA=;
 b=VhCwrjd+jAiKzLhD6YtsUVD4Scyxjy3ujGSBNFj087guWVmsDP9zTR83Tt/3P5nzmHEGf5BXvN6mRzQvfWD0dlEXi3mK97htzwzXyPa/j8z6aHsZoy6x/4bR5mSY7POHJKP3fLMZnMQnrbE43Uj1yBfdfpHaFy4WOY6XDPiAPwweYHawEiGf2uvSvBQz73iuXvY0WHehF3X0AK0Zp8zgYV2cW1DtMtg3QgiyaszyQ5W1Qe9k6ydSa8fRh6UCZlKgSAlc4YqwwdY4co62tJev76q76vEeGMBKtdKWi5HxdZYyq1R/g/Rkvdw9euGnyeTWuxFuOo4eTVDWJtbVcERH0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3yuplDu8+aTdKpp2ie3JDrsmPEjj7oPTVzhpThYfpoA=;
 b=fGBcyAsmQwElsIFsy4SAXVmYGrltmgS2rSpQppEnsTFidNhntIT9toBVbJOceZpuBQJrP373rHfIGALNI9Nz2PPOWP+jWCJ482EdvOWTC3oVkqDE95oaqdpaHW32IcwwnxjW8/ulOmrqF2fCQLlRGOnZuj4wkueduAojWoyIhxs=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by BY5PR04MB7105.namprd04.prod.outlook.com (2603:10b6:a03:222::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 20:23:14 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ffca:609a:2e2:8fa0]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ffca:609a:2e2:8fa0%4]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 20:23:14 +0000
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
Thread-Index: AQHaLpoq6KpaLC8u+Emi7PiHDdomg7Co5ImAgABU+gA=
Date: Thu, 14 Dec 2023 20:23:14 +0000
Message-ID: <ZXtkMC1ZjsgHMRvT@x1-carbon>
References: <20220222162355.32369-1-Frank.Li@nxp.com>
 <20220222162355.32369-2-Frank.Li@nxp.com> <ZXsRp+Lzg3x/nhk3@x1-carbon>
 <ZXsc57whj/3e/+zq@lizhi-Precision-Tower-5810>
In-Reply-To: <ZXsc57whj/3e/+zq@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|BY5PR04MB7105:EE_
x-ms-office365-filtering-correlation-id: dcf304a0-3169-4666-b07a-08dbfce2800a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 61b9Ttdm6Ikm5IAAXaPGBwr1VZRujDvCKT2BaeLdv2eS/sq6xWd4J0LJTK13lQ3s8odDvn1UOvzYK8wW/VOWl9unYkrDkpPVE1rGA5asuTQw9z5OqGrQgyc+N08iVEQnfEsxiYoubGNf27LTT1kVE4lTAfEdKBIZxLJiK6hZ9eaE+121zKnySmsaZNX9FNUJxbuF1f1fD9zXWJBMEMhF7+MB1kuNNij9gkYkQdDfO+zOzWZFwql4h5t43pKIS0otZp1HuztEfEEE3z2/mm4u1y7nVbamLVCGhQ9IpjZRZvCz/n5lzot5/x1+TKEQDm6rbQJKlfb/SwhKfhuUDdCiQGVgri3nIbjrl+ruFf9CMDnFEeeohwXrvitFNW2sg3LUkXWoaqvUaMVMI6nfdoH9Hg6dxDYNkiiSsBEPn7LH5I4jQ5C+PvUAPRnHyYZ7m+jd/CqdLmTKJlr5xO/2nTQcMjIE5RP18j9Uq/5yDroF9EzMPkSUK7peinC7juR2zslmW3bjrBLeA2gyB+0vCxhROJbFc0b+1IIa1JzLza6i0jvPexYlWwkwSppcq8mALRN0bdaTXVKa0NGrRPRZTbEMdHcIq40iZh6FV/u7ZcIl2KvWrZKDTeC5546/DWCHG/uQ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(376002)(366004)(136003)(346002)(396003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(76116006)(26005)(6506007)(6512007)(5660300002)(71200400001)(9686003)(4326008)(83380400001)(15650500001)(7416002)(33716001)(41300700001)(2906002)(478600001)(316002)(6486002)(8676002)(6916009)(8936002)(66556008)(91956017)(64756008)(66476007)(66446008)(54906003)(66946007)(82960400001)(86362001)(38100700002)(122000001)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?5dZhF1EkOE3xHyGPvEZbZxUZQccrzMBBZk1SzcItvDCtwGwhnozt05EHsnUH?=
 =?us-ascii?Q?hCrlXD5/R39wbbW1RLtaEUytFDR0gGlY4BcPpyXkJ8+bCxBIphsY9OFUhT/M?=
 =?us-ascii?Q?iZs3HUB2OGQk0ykb/lZz4tBKtYGt4yUhDcHXUrBoLnjWkdYr9rDIHy+u570C?=
 =?us-ascii?Q?b9QBJQkQ3B96VyV4LKxatzAC+HccqLn1EN+XILDIIdCZ1ZjccFrR18aSPWVi?=
 =?us-ascii?Q?vkCnuAJTgEQcEP5/a7gbaFZBUze5BIUs5Jjl0/cxfSc4rSUFdDeyzt2wd0iU?=
 =?us-ascii?Q?pehRwISFctxysJ4EmkScOutTj+f93DxTteLP9RgbPZPyBqMPfFuji64ZOO+S?=
 =?us-ascii?Q?Bzx7c38uBXxescVNkXSc9Ny+15V+EE5YDDnQqT0c/lPKHoFbdN4X1nc2pjC/?=
 =?us-ascii?Q?GSfzC+jAgcOwPjJ5b90gMSqTZqTlm9qprBUyyiyaWShxjyY5v/NqFLaQc/zR?=
 =?us-ascii?Q?ThNxdElXnP5ELK8kiSBJVU1Ia5im9z9kLjrecBdbgpJfT6nwyXXoe6i+kbRW?=
 =?us-ascii?Q?6shFsV3+yiKR7c/G2BJl+X+77Unsh7rUfZiFHLERok9bzRIMScsXvNLDbdri?=
 =?us-ascii?Q?EtLlV5dz4lWZBLyDenHaybytorehm2HB843yQKugMneci0fBXsuSxT6xWWHT?=
 =?us-ascii?Q?CWEjaruIuGgbD1utksm677+oOT8FYXyX6ecO949p5PQjrbOFlxs4ijBgcPcC?=
 =?us-ascii?Q?/ZRETEbqVqxmRsDk20BhsWn1Ei8h0Y2fQ93lR2KGAlc/71Jl+CbPsfwtl+zU?=
 =?us-ascii?Q?Du/MScfsvO0VE1R8PnCs+sb4IN3auj3nOeJ8tPEn+prf5djWbFT84BrdzOql?=
 =?us-ascii?Q?ZrLy0QL2wc9S3pB4IlC9Mta/XOq3aAjmcZT3bqlB6+/zS5hwWxys1hJ4p4sp?=
 =?us-ascii?Q?Htx6cwk91FJKPBQsQMwkYV4OrTf7XKzCAsHER/OWqkuDUrYdSnkWhOt4Xs7O?=
 =?us-ascii?Q?m8xvDKSz4c4COU1Kf8ddom/D1FHWH6upp5pAIPlT04ipbkm2B99EKKn1lskx?=
 =?us-ascii?Q?U3okFNdyYhtvlCHnBHproPG9u2xaehEw8+rHnx16Tq679Pro7RN3WEN8AAo2?=
 =?us-ascii?Q?3J3KYFA2FiZ1EDQgUIF2iy5zVJIul4fUUbV2QlkPk1KML8YF2hlm59fWhtQa?=
 =?us-ascii?Q?SWJ+oPy4s6BM92WP3I7BxnWxol2JKPZm0Vjpayd8g2bIWAJo9e0rvgx96Iut?=
 =?us-ascii?Q?gpehqJiEJJQ3MN48bvIryuMOvtB1ds3cagTT+mkJ4mK+BvnNcnxNP7RuoFSo?=
 =?us-ascii?Q?eV4z4MuT76ROFypTZbimd3KvWGb+Pb+MlAt+t9rNw8+8CiBB1hO/aeTowi+m?=
 =?us-ascii?Q?5ikeheW+fuG2vEjv4MkTopcZuedgLXzT5VqSACF9bvHqf9ap/qHObp6Exw4g?=
 =?us-ascii?Q?IycXs3jH5KOrXhvDYozbrGciJQTpwd/hAJJZdmSpOeb918abYn4zedqi8h9z?=
 =?us-ascii?Q?pt0ncVDohi6XcsbXbnVBFMQmYIVkhgiostyUaBHpEl9NuYRehrVXZAikgQZQ?=
 =?us-ascii?Q?lYIb1m4zc9hZ2i+0VU/+BE9T821FBrWc27habzPQ1KOVFYqT2NlMvsYzjoqr?=
 =?us-ascii?Q?mhotOQZT8CcXHUu74G2qszYyoC2wrTMoJvpDDHiynVKyG9ziHpw498qwM/gM?=
 =?us-ascii?Q?GA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A65CA985BD23074DBC06DDC00EF75012@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9fxM8HbjRdSSp8RmjkB0+JnAOJ5sAoe6U4vQ9PNbYWXaDa5PHT5BSEYav/DHeBLTh5yAPnVF1Ldj/OisbceVGZXOxb8i6RxZq8P0FOUoD1RU33/P6wi/DyD3EL2wpQH9QPB44vbr7T+/3H8UR+LYaluQwJTy61rDoH6cQc6AIsC/sh9RVzaU28fPTynAwELotetSB9Z2E6ISEdEcitUb8fwDXrd5ky2Ug3U1hbmSNE9sjm/c8Ks0mLDcjJ+zDo8+jlZrXo6qE2lj+6BCKSjr1mFmf9cvQzTZ4CjXCmR+n1I8IhxJdEwxJY1HgF9SefmVoAhfNILCf7D0rzow/IBHQ5L5shEhbnhLft/4iJoCThrINJdg+J8EmvHyFrA0lq5q9PQR18vLBlHXvwC29mhH10Rg2mSbvXJUwOayBinr0+bkSol8tCk+ssqHa/+18JdiWQ2hEKB6uMaXKJA71X7YSPbv00a7qfgsCE6wrIl814dhf3GXO5MVM8ydTeB3vo9XKmQOCIwIhnnGk4X2fqWCc0akxhhsI2N8Ujuc12ceH21olQOEHdKj9EjNtaAfVnWw5ZZJqmioOWS/39v3/ICM44s49r6Amv6ND1491JjgxNmRPHdG3dBPEkWrM1J+AI6K
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcf304a0-3169-4666-b07a-08dbfce2800a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2023 20:23:14.3843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2dR0e33TqOYDxaJX0PXN2MwO3LpONDoK3BvtWPy0z+icN0665nPRpO4c3ZC6RJPfScz9gQ43RKRYmkRMqmAZFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7105

On Thu, Dec 14, 2023 at 10:19:03AM -0500, Frank Li wrote:
> On Thu, Dec 14, 2023 at 02:31:04PM +0000, Niklas Cassel wrote:
> > Hello Frank,
> >=20
> > On Tue, Feb 22, 2022 at 10:23:52AM -0600, Frank Li wrote:
> > > ntb_mw_set_trans() will set memory map window after endpoint function
> > > driver bind. The inbound map address need be updated dynamically when
> > > using NTB by PCIe Root Port and PCIe Endpoint connection.
> > >=20
> > > Checking if iatu already assigned to the BAR, if yes, using assigned =
iatu
> > > number to update inbound address map and skip set BAR's register.
> > >=20
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >=20
> > > Change from V1:
> > >  - improve commit message
> > >=20
> > >  drivers/pci/controller/dwc/pcie-designware-ep.c | 10 +++++++++-
> > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/driver=
s/pci/controller/dwc/pcie-designware-ep.c
> > > index 998b698f40858..cad5d9ea7cc6c 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > @@ -161,7 +161,11 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie=
_ep *ep, u8 func_no,
> > >  	u32 free_win;
> > >  	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
> > > =20
> > > -	free_win =3D find_first_zero_bit(ep->ib_window_map, pci->num_ib_win=
dows);
> >=20
> > find_first_zero_bit() can return 0, representing bit 0,
> > which is a perfectly valid return value.
> >=20
> > > +	if (!ep->bar_to_atu[bar])
> >=20
> > so this check is not correct.
> >=20
>=20
> Please sent out your fixed patch. If want to me fix it, please tell me
> reproduce steps.

Reproduce steps are simple:
1) Add debug messages to dw_pcie_ep_inbound_atu() to see the iATU index for
each BAR.
2) Boot an EP platform with a core_init_notifier.
3) Boot the RC.
4) Reboot the RC, which will assert + deassert PERST, and will call
   pci_epc_init_notify(), which will call .core_init (pci_epf_test_core_ini=
t())
   which will set the BARs.


In step 3) BAR0 will use iATU0.

In step 4) BAR0 will use iATU6 instead of iATU0.
There is no reason for this, as it should really reuse the same
iATU index as before, just like all the other BARs do.
(This is because of find_first_zero_bit() misusage.)


I could send out my patch, but from inspecting the code, it looks like:

> > > + if (ep->epf_bar[bar])
> > > +         return 0;

from dw_pcie_ep_set_bar(), also needs to be dropped, so that the iATU
settings will be re-written for platforms with core_init_notifiers.

Right now, for a platform with a core_init_notifier, if you run
pci_endpoint_test + reboot the RC (so that PERST is asserted + deasserted),
and then run pci_endpoint_test again, then I'm quite sure that
pci_endpoint_test will not pass the second time (because iATU settings
were not rewritten after reset).

It would be nice if Mani or Vidya could confirm this.


I guess that you added this statement for some reason, so I assume
that we can't just drop this line without breaking something else.

I guess one option would be modify dw_pcie_ep_init_notify() to call
dw_pcie_ep_clear_bar() on all non-NULL BARs stored in ep->epf_bar[],
before calling pci_epc_init_notify(). That way the second .core_init
(pci_epf_test_core_init()) call will use write the settings, because
ep->epf_bar[] will be empty, so the "write the settings only the first
time" approach will then also work for core_init_notifier platforms.


Kind regards,
Niklas=

