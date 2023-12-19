Return-Path: <linux-pci+bounces-1166-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD18E818501
	for <lists+linux-pci@lfdr.de>; Tue, 19 Dec 2023 11:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55660284B38
	for <lists+linux-pci@lfdr.de>; Tue, 19 Dec 2023 10:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF78514012;
	Tue, 19 Dec 2023 10:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gPLTIvYw";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="v9PWKRBf"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5FD1426E;
	Tue, 19 Dec 2023 10:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1702980440; x=1734516440;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FwNSrYNDp3EZgEgq2byC0/cKMnuX/aBixwaZ6KXumII=;
  b=gPLTIvYwyF8Bzqe9B6M9ogIP08sCf8A3nWRwKPbbpsXtWZ+AoNETALQE
   IDQiVXYLE31OwSLKNInuRYD4UC6RWPqk1CeCpX1U7t+fU5hnkHf8+Y9HG
   q7Ti/E19cPpaG5+usdXI2TombMuON0KapPyzRbbAkCt/lKdvewtwvCIXs
   iYvCHKhf46/qso0jvYJ0c/aBPgVIosh1qNf9XZ5BbD1JiYrEeVgu2o2mN
   snBQHd1WAmZ5VP2d4bOiUIX4bQvYN3C+ARXmEb+J4pYhKJQ2S0w2Sb84+
   2eBNjv77hE/q+X6maFkzEN4TfN2y5X2UmwtUhFhfzEMTgvorVQH0B6CfJ
   Q==;
X-CSE-ConnectionGUID: SoIitZF8RPebYcRPbRryoA==
X-CSE-MsgGUID: XAYvESOXSxyunUpmHELhQQ==
X-IronPort-AV: E=Sophos;i="6.04,287,1695657600"; 
   d="scan'208";a="5283314"
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
  by ob1.hgst.iphmx.com with ESMTP; 19 Dec 2023 18:07:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eurn+AOxPmoeuEAhi372pt7qhPezXA0+Q/2rnY3xFcdiXWVSL7wFfb/KE+3vtdSGLv3Yro9OJlFVk6ekoiNGb1JBbhmiRAMadGtx4muuQUINphebL4fSZGCXAT3S6LW2pqNMlvOjcltS/9WN9o+dtXksrZT/66eJcZRuMh3JKX6BHCWTZMu/Qhf1UWNSxSTtgrfSUNWmxbOi/VCzo/4KhOMgw9kcIE0t3HBLL6EN/STMc9+9h/ZD+q+Se+f6sDQ6YXiCtLe/am/dE9SG5cJHCVXgk1ItDsdXiKWcFtrmQBxNxpgK3JVSsV7g8WePnIt12vGOT/yrGRQCtOrMtcdjYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bqTFixvZ9YUqmyfAxqX6jlrMUmGZOTbSRi08VGuuuHw=;
 b=U4eowX0RDS0HB9sb/pPQMaaVLpKq1QAlqqYSskHUUbliY0L4iKFnOdLXEcGBVjjcgh6wypOPqQi1tqAHYlmY7Xx21FD9lPPNLaLPp89R3Mn3ZMbhNJ8YRtnFCx80UFVpl0xv/QPPv6/Xboj9YBGtQSM0BTY9Zd02a2Sr1/UFcTvcGA2d2S25xdihl3bP7p69kECt6wSabHnd0llEMFR8EVSt7T7MkhHDZ315RZLMu4bHXIfN3ReYNYTc9dgfjgvMrkE7XIXKguioz02p1M088pCCdn5ii7lCtJuWqdt3a3ZiBm8Ob3C55Ypvk43NM6e/hBjfOJ1O07ds+yWjdKpYvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bqTFixvZ9YUqmyfAxqX6jlrMUmGZOTbSRi08VGuuuHw=;
 b=v9PWKRBfQFAcepRVJSWKVoJ/7HTsosMeHvgiC6kn4ccTe5R9Bo997khKl1jKGlOg1+BYt7nnzKNyTzjc63nWhQD8ofKe0TQHRz215nI4AdWs9wZsgWUWo8sAVR/G+wsetb+bbQtsqrxC3Q51ZRgzL/MA1qub4Hzwffps7WvysXw=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by CH0PR04MB8146.namprd04.prod.outlook.com (2603:10b6:610:f9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 10:07:15 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ffca:609a:2e2:8fa0]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ffca:609a:2e2:8fa0%4]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 10:07:15 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Frank Li <Frank.Li@nxp.com>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, Jingoo Han
	<jingoohan1@gmail.com>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?=
	<kw@linux.com>, Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, Jon Mason <jdmason@kudzu.us>, "open list:PCI DRIVER
 FOR SYNOPSYS DESIGNWARE" <linux-pci@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] PCI: dwc: Fix BAR0 wrong map to iATU6 after root
 complex reinit endpoint
Thread-Topic: [PATCH 1/1] PCI: dwc: Fix BAR0 wrong map to iATU6 after root
 complex reinit endpoint
Thread-Index: AQHaMja1NResTHTkFE6//FhBs62b57CwYdiA
Date: Tue, 19 Dec 2023 10:07:14 +0000
Message-ID: <ZYFrUWM7JXdv7rtb@x1-carbon>
References: <20231219044844.1195294-1-Frank.Li@nxp.com>
In-Reply-To: <20231219044844.1195294-1-Frank.Li@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|CH0PR04MB8146:EE_
x-ms-office365-filtering-correlation-id: 7f69a505-1d93-4e40-7909-08dc007a4666
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ID5EjBjum3IcYss4eyD+bPrFK6KoAZSvka41RMD+pxW0YXI39f5SifcUj5417BFM+A/oRZnRWQ5pVElUWT1aNvGYtX+yIypG+roHGayu5+WJiwhhx7Cks8QMihX1wYSQS9L/9UHG57r0Nus7ORJjMhGDRmRZqWoTbowQuaQ1L6zjwIHYQHGlG1bp4GSQD3T6VUeGgyBFA6edOhRN/wsOA9W9gKW1vaE2y2JIzHyiAdwVf9o5+r9vrggKDshBs/oRTn5JX7bb/omf50HEbTQ7k7TigSRJSVPVZHymgWs7MHRAedv+IXAbd/OeSmrT2FXqxhvLV9yxeiVkxykyiJoQc2IaiLHht5/O6hPcgtTKNPSZk61mkzGM0gxl2cEdNsTEasmWSblZsB7adkAd6ph2XqMP75c5CCgjlxaQ/cDYtsXCF3u4tYtC4r4tOPHML0GZqZmb7go+DCWIH01EXdMiFGRezi1dL+pFo0ts3ud60IRfGppm6/tOLzrGy7JUHVUVFHDxrGv/iWizt8vu6lGs/kot5uIKk0pd8CWhtYKXSzNEOGCb3aHydkTJC6EURRiE2X6AqLzX1zGDh40Nq2Qz5cnWE1Of/qzBr7hX+wMrUPQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(396003)(376002)(39860400002)(136003)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(122000001)(83380400001)(26005)(33716001)(71200400001)(38100700002)(8676002)(8936002)(7416002)(41300700001)(5660300002)(2906002)(66946007)(6486002)(9686003)(66476007)(966005)(66556008)(4326008)(6512007)(6506007)(54906003)(64756008)(66446008)(316002)(6916009)(478600001)(91956017)(86362001)(82960400001)(76116006)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?lq17y/CvXwu31OaRQH0Xm0o3XyQJkEtemqNPDdiK0BOmG9OuHmbdyAuPl0?=
 =?iso-8859-2?Q?kMku7Fp4dpFRjjNtYwK5W0TJ/6pkNE1l5PTZoXaWvGueEn3zPyYN2Hmjat?=
 =?iso-8859-2?Q?tnLeIi2Sqik46BgyofRI90geLDxjnzi85EPRqOOweVRYwQXN7ri0JSHZJ5?=
 =?iso-8859-2?Q?Q9T6clmgOJGtLkmOJdaKONDsBGWpc6jYJPjs9ozVYUibHYuIopGSQ7cj/w?=
 =?iso-8859-2?Q?NDQn6qCwhu06QKo7ZVJ5Xs7VP/dAJVd0gny6IeP7BFkQpttxS9ft2hkOEL?=
 =?iso-8859-2?Q?AnEkDd1ESChUyXhSW7xQXW44ALqG2MgFGqrysbEEHMnXT/1H51qAzi75I+?=
 =?iso-8859-2?Q?2M1Xsy1i0v936xMiCKlVXQWe/boKtqyZa4BNX4MnXYb67OZFZ10m/la+5i?=
 =?iso-8859-2?Q?e1ZfczlV42aznrYY3sgoZ8uDi1+SLB25tjaseOo95JvgKR8E5ThLDWbOrP?=
 =?iso-8859-2?Q?8ouxHpa8aW5sGP2NjNnLk8PNaaABUrN4bTP54GufoVyXRM9Va6FhqscNBs?=
 =?iso-8859-2?Q?iynvy5y2j1IFKWPM0NDrQiVar+AAupTS6UiptP5/1n20fAK/gw555ugn9z?=
 =?iso-8859-2?Q?fnBGtmwZHghnymk+9yIwE0Eb9t8eq0GajlpkuTzTjlNBW3WEXzCvq4N6/a?=
 =?iso-8859-2?Q?FWYe2RR0U120DwwiJK/qdQdXd5OplcReXZ5GSg5HqunRnF0YlYH1DX2qkK?=
 =?iso-8859-2?Q?BllhJivxBFQPRSCC3MSq7SyvP+lUax3X6Lk4STrn02xdl6ccWpDtguiLnE?=
 =?iso-8859-2?Q?9Ry2t6H0pxYo8hVhpncZS0ibs3o6G292/j/bxFkVMnzyFqYi5FvV3KHmgp?=
 =?iso-8859-2?Q?leflY1Bl0EXCqd5od2SQzG+kffogXwfWJdGD5bgYD+K+XelEpKnb0sEZMl?=
 =?iso-8859-2?Q?IeWPrsCkB5q2WYCKKtUQU4Xqm05QvNo8x4L6Vpa0IefcNX/1a1cP2hlx4U?=
 =?iso-8859-2?Q?QIKsuYvAEK77lJeCH2f28m6xT1xWX7nXfFAITc8JMCXxDFISf07BkEDqFc?=
 =?iso-8859-2?Q?E/GY1serqsPIX7o0G6DIRYfKMLabEfDL+eixERpkSJ0n1eAopFmHst+wj5?=
 =?iso-8859-2?Q?oBeUhWm1wFNvRumY3D1Bi4XN7q10o5dWt4PpfOanPaGht0IZRHI2qOXdfq?=
 =?iso-8859-2?Q?hEPVpgyWFLmYilHKi8YFIa4Rk8KK7ckPw+5KQDjS5qR56M+Hn3JQ6pB08t?=
 =?iso-8859-2?Q?t85BM/Az2pqITHIux6n1czp2/CHBa+JkCY8x8mP8E0vObpgIB/NrZNmqNj?=
 =?iso-8859-2?Q?+CGYvoGTKpLXjL36LpBkfY6bsUafsQxG6ufvcWJuh3iLoJfIxDCvSoC557?=
 =?iso-8859-2?Q?mUY5ld/LkUW7KwO+gm4KLRVuCdkX6SS5MwGghqfbD9EPreDcZfrVuPDeJC?=
 =?iso-8859-2?Q?gO+RFnkA3RxLWlFPbuFdi+C9wm0kr+PYJEp96a2MeI8wCWr1P3upJ3wDwj?=
 =?iso-8859-2?Q?8vq4w1vR22M6JVLePq5KzrvV7UMpkmDwxNwn4nFshf9sKSJ+fzMZ9yy87n?=
 =?iso-8859-2?Q?6NVbnVrVnYnyVCpjZLcnywJOkpPrfNpqOI1Pp0hjMCaUbzEgFpSfV6Y8mO?=
 =?iso-8859-2?Q?HyqmSXJpZ8ux3CPeE162fB/JHwAJHQFKt4yNfnm6SrNC0/gC3u1GTtieEh?=
 =?iso-8859-2?Q?rj7SuYTij878cKyuPN/JhqMfadMRVJmENxlbBBb3Wyp8EP3mvtzneJOw?=
 =?iso-8859-2?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-ID: <6881691CDDF3234095C38A50E78BC478@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	crJXQ1CQj3JSD/4tyYzoW15+xmUg0rZ3Jyf5FkDe7/UZNJNBeUf0sBmyyhKp+Gyn7a+XUFp7Br+1wOe1V+/x8rKtlbreLNyu/KPaiR3e6tg8FzR1+rrQSxAm6j/fFMBrBRp2oOco0sCaXMJeThCVJEDg580cxwaPrneR1y68BLlLK1YaiNUCYy3DcERGtX/OGXtsl3LlpcujQPEEAhr7bEfqxDTwfZv7DhJNfdeB4oX0OhZ3tMQ2WKA1+7w1Mf5+dTiiIfVfgDpJBGrRiMSyYO8sLs63lhWXFz9IB6iv6uaMt53TWpVPDhOjFowJJ67PbPwJjxT5sxpnw1Ry8bEreKZKO6O3H9gD5t39SjC0Nj49pxgvkjGDdfe02POpnJ0nhJOYTJlDsOPh+NA269RDOqEsBsX5EhSo/x62W8gRNpto2+j9pk7mkztrrAAPP6vq+WwboA9WsK1qL+IpU4PPmDyV9IF6XGUaiZybcSE1x3owt5ycOl30ASI3AJqiWxOxg364B3b71OoGpP7MuL5AdU4ETBOYgHcYiPB78qH5pwvXV1BuW4bOORjwFCXRskQyhMbDo6tmA56jyIgIgoMy9DwNtvKoQ7oGu9P/qhn+OR3x0RNDGYt06X944VQTLAbW
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f69a505-1d93-4e40-7909-08dc007a4666
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2023 10:07:14.6779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rL+jqYcni5qWQ5KehKkz87swRtdlcM1PbrGZiAHlRXr0mzMAm4m1r8gRR3ZiBnJ4dhL3kQK+ayX8PVmoMq6yqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8146

On Mon, Dec 18, 2023 at 11:48:43PM -0500, Frank Li wrote:
> dw_pcie_ep_inbound_atu()
> {
> 	...
> 	if (!ep->bar_to_atu[bar])
> 		free_win =3D find_first_zero_bit(ep->ib_window_map, pci->num_ib_windows=
);
> 	else
> 		free_win =3D ep->bar_to_atu[bar];
> 	...
> }
>=20
> The atu index 0 is valid case for atu number. The find_first_zero_bit()
> will return 6 when second time call into this function if atu is 0. Suppo=
se
> it should use branch 'free_win =3D ep->bar_to_atu[bar]'.
>=20
> Change 'bar_to_atu' to s8. Initialize bar_to_atu as -1 to indicate it hav=
e
> not allocate atu to the bar.
>=20
> Reported-by: Niklas Cassel <Niklas.Cassel@wdc.com>
> Close: https://lore.kernel.org/linux-pci/ZXt2A+Fusfz3luQV@x1-carbon/T/#u
> Fixes: 4284c88fff0e ("PCI: designware-ep: Allow pci_epc_set_bar() update =
inbound map address")
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>=20
> Notes:
>     @Niklas:
>     	I have not test your case. I should be equal to previous's fix in
>     mail list.

Hello Frank,

Thank you for sending a proper fix for this!

Personally, I slightly prefer your fix that saves the iatu index + 1, and
keeps 0 to mean unused. That way, you don't need the memset, and you don't
need to change the type to signed, but either way is fine by me, so:

Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>

>=20
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 11 ++++++++---
>  drivers/pci/controller/dwc/pcie-designware.h    |  2 +-
>  2 files changed, 9 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pc=
i/controller/dwc/pcie-designware-ep.c
> index f6207989fc6ad..0ff5cd64f49b0 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -174,7 +174,7 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *=
ep, u8 func_no, int type,
>  	u32 free_win;
>  	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
> =20
> -	if (!ep->bar_to_atu[bar])
> +	if (ep->bar_to_atu[bar] < 0)
>  		free_win =3D find_first_zero_bit(ep->ib_window_map, pci->num_ib_window=
s);
>  	else
>  		free_win =3D ep->bar_to_atu[bar];
> @@ -228,14 +228,17 @@ static void dw_pcie_ep_clear_bar(struct pci_epc *ep=
c, u8 func_no, u8 vfunc_no,
>  	struct dw_pcie_ep *ep =3D epc_get_drvdata(epc);
>  	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
>  	enum pci_barno bar =3D epf_bar->barno;
> -	u32 atu_index =3D ep->bar_to_atu[bar];
> +	s8 atu_index =3D ep->bar_to_atu[bar];
> +
> +	if (atu_index < 0)
> +		return;
> =20
>  	__dw_pcie_ep_reset_bar(pci, func_no, bar, epf_bar->flags);
> =20
>  	dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_IB, atu_index);
>  	clear_bit(atu_index, ep->ib_window_map);
>  	ep->epf_bar[bar] =3D NULL;
> -	ep->bar_to_atu[bar] =3D 0;
> +	ep->bar_to_atu[bar] =3D -1;
>  }
> =20
>  static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_=
no,
> @@ -767,6 +770,8 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  		return -ENOMEM;
>  	ep->outbound_addr =3D addr;
> =20
> +	memset(ep->bar_to_atu, -1, sizeof(ep->bar_to_atu));
> +
>  	epc =3D devm_pci_epc_create(dev, &epc_ops);
>  	if (IS_ERR(epc)) {
>  		dev_err(dev, "Failed to create epc device\n");
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/c=
ontroller/dwc/pcie-designware.h
> index 55ff76e3d3846..5879907c5cf25 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -362,7 +362,7 @@ struct dw_pcie_ep {
>  	phys_addr_t		phys_base;
>  	size_t			addr_size;
>  	size_t			page_size;
> -	u8			bar_to_atu[PCI_STD_NUM_BARS];
> +	s8			bar_to_atu[PCI_STD_NUM_BARS];
>  	phys_addr_t		*outbound_addr;
>  	unsigned long		*ib_window_map;
>  	unsigned long		*ob_window_map;
> --=20
> 2.34.1
> =

