Return-Path: <linux-pci+bounces-926-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D23AC812554
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 03:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D0F61F21A05
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 02:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FFC391;
	Thu, 14 Dec 2023 02:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="ITxv6O4r"
X-Original-To: linux-pci@vger.kernel.org
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2130.outbound.protection.outlook.com [40.107.114.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCC6E8;
	Wed, 13 Dec 2023 18:35:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BT6+m6kSkWz0nnYHwrgP0gjTlxWdltRnQki4x3lkmU3eVQRhmAXGhB/G9lAFkBAhZq4hXS1yiYjr4kF43ltfWSdbjC3NmthWN4i1/Ylf+ZQJ/YzIGIo/oo9YDx2k9BKSeMyAD72Oh3GCQGDYeFljccSQsTfyIV/DEpuKiY9BI+RXHvjKa/ZWUSMcYGTrHAYcwxdjqNBT0mCitMVAgM6qXfoqK+TeMPzhChBOejZTOhISRChJl4yL6YFq7cr0+MfkAl14eea/EbzqH0Z8b76Wn06lNWC1w1vePbqALVLUbEmGqThu9TsbBpA85Fjvd+yNdfYUHfuZmBZrjur2eU74CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jkuu6ZnnNLzBTo8RwttMfNCaBesgKJLovxnP3khaj24=;
 b=LoFyB2C2pctDkhUuE9RAp0yNfbDrmzW2UIKvCyH0NuQhlvipFFhYQ/lwCSzZFJU7Hy01jH2HXhA4t14x6OrC2hmO3g3Om1LoXhw78XoU3n3YMQ/g4rDM9vpSUbEo+RpFwEQf13fHJbA5p7dWZMgktHLqZ/9VIQtHJclQTb7NwLvqO2pIg6+mdSbApSFgoHNxv3KBviqy7x/XflR+5tX+Kz8n7551uII2qJoGnE7f3lEIHcugoevMLHhHifD5wwOzQ5utuyCU3QuaGP84j1aGU267RtvwdYXcAwyy7/7ApOpyBe7FNn7L66Ypfblu8eRlKEjgmNyZ7CIaQPVpii6Eng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jkuu6ZnnNLzBTo8RwttMfNCaBesgKJLovxnP3khaj24=;
 b=ITxv6O4rLnwL4zEFdzpu0YtEP6cr30JSdfqpHt1/wRiyHCeOFHzEF6o8n5TfY3LoXSIsAB+8iyZIN4lMMX75lGWtARgIvSUajs05iWdsgu1IN0y04WJXEAik5tb18Nn/7JsqEHFJdpvfPFZpAQqSvIKLUiUnCOHrea57iAb/zls=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYCPR01MB6143.jpnprd01.prod.outlook.com
 (2603:1096:400:4b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.8; Thu, 14 Dec
 2023 02:35:56 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::50f5:eb2b:710a:b7c7]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::50f5:eb2b:710a:b7c7%7]) with mapi id 15.20.7113.008; Thu, 14 Dec 2023
 02:35:56 +0000
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com"
	<kw@linux.com>, "robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
	"mani@kernel.org" <mani@kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v2 0/6] PCI: controllers: tidy code up
Thread-Topic: [PATCH v2 0/6] PCI: controllers: tidy code up
Thread-Index: AQHaFr8c7F9KjBCkD0OuoYfB8iOexbCoPaMg
Date: Thu, 14 Dec 2023 02:35:56 +0000
Message-ID:
 <TYBPR01MB5341F846948DB6CFECA62187D88CA@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20231114055456.2231990-1-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <20231114055456.2231990-1-yoshihiro.shimoda.uh@renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYCPR01MB6143:EE_
x-ms-office365-filtering-correlation-id: f6931fb4-f99e-405e-ed2a-08dbfc4d665d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 TDosnTtCFyC0pOJc78ogTlhJOsNE7Pbthmw2/NP1UmM6F+MUlep41Je0BvzMwuyndFK4T0FSTOp/xHq1I9oB3Qg0ZZeaoEbIb/rD5Qm3rcZBUnVCaT+24JlRFvI2tkAysvQ6KJgVj6sYmYNS5VRAPQUXYZ1LDV6dL6Fl1s1qoouPi0Mj4jG+U2anjGfhglrHnUr8VGayKBuEBVJ4VPysYRdUCdO2OcYlSzv7eopga5SIjeYdPnbFn+ELfz9s8CSU7I6j6XEz0fslMATTlmuXZX0siNKZIj5B6xyUHkrvrQv7gYRzNW89wE2HyeB0Q0/BFfghfp9hY/kpPZNOJ8Kex0SyyHXgJZMYJQzy94H3A4FbxP19cuQiDglQKlLfXa6mzEEq19A8snFTXvdF2Z/MgZzo+/LLfq180leciHXDja7lohTpp+Z8BMFG5O6wgXN2l1AywhCMGB+PLWZGMXVmuv0qOUUAUWs0KCYLA3TC+ZC6hPXU/IDYxZ4QxFcioMubssEOK6IQ3ADdZOy0bE/XRPW6+y0W9rCS5TvPsxd7mA8utiqAo61zDQM4dGKBjRac8+PsUxNPJd50rgCUWE8dtZq2Rlosz/lgVscaStLZ7Tt5D3RHnTye+eJDg/Mq5zIaj0aapqEgBpDdwnma3DpWeg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(376002)(366004)(39860400002)(230922051799003)(230173577357003)(230273577357003)(186009)(1800799012)(451199024)(64100799003)(38070700009)(55016003)(110136005)(76116006)(66946007)(66476007)(38100700002)(122000001)(33656002)(86362001)(66556008)(6506007)(66446008)(26005)(83380400001)(7696005)(9686003)(2906002)(966005)(54906003)(316002)(64756008)(478600001)(71200400001)(5660300002)(8936002)(8676002)(4326008)(41300700001)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8OY8KReh1Zh+W2rQRh19Pgz2djzqCn6SUDja2jR/z1OHpZn1MtHck0HggtK2?=
 =?us-ascii?Q?/0UdhLY1FSt82ZCWlH889ZZS1RjXRCo2l4p2kzUBqN+SbzYyemSDeqwnI+qK?=
 =?us-ascii?Q?B9QeDmFBJB9aHdfo4YLYb8zll+pCb5+63uZDCp/tCcWgAcsfcgXXXYso1LKH?=
 =?us-ascii?Q?kPT4cz/jq+zUx+qTtrKFUELUCW25USVQNYBVef8bS2tqPYxl0QeeKLD9wMf7?=
 =?us-ascii?Q?kbCZtwQ/4mTTqiVvscfgXWOj1iJYGCpOduftkl/Y+2CULAx8zkkGLPV3aZCa?=
 =?us-ascii?Q?HV3X3QfRAwlvacCy++feJqmqP5j4aBMpvEHmjSG70ff5ZciBUii26zoHFZXO?=
 =?us-ascii?Q?lNoHz+mGam1JlzrmFZaqSyBb7rcVzUTMd3yagB6aYTCqWMjePMG8UbG7ce3d?=
 =?us-ascii?Q?Nrlk12JE1oxba8GL0E10GMDAAcw42c9FGzy5triUI6R56Sj4hm8wmxuKscnr?=
 =?us-ascii?Q?OTX+i0WwxdtDf06s38Qt/2Gnh0SUl1BKPowS4KvkQLCYhg+IGUVOfiJz0J99?=
 =?us-ascii?Q?CXz/M4EiJFaidGpl4hmNDbfRcO7DrsyrrIGcdtspXP+1KeCpY3o00d3LmVe8?=
 =?us-ascii?Q?73IwcfIWZJRGj8p0c8w9onWHuqLeCGoU1vDpaZ/9/lI+zQiBYdU2t1o8s3Wu?=
 =?us-ascii?Q?kz19XF1lhSLeo/fkdR+Wr2RbH3L4opj4Ff90QR0+AZ2+xU0w336mlINf4yuK?=
 =?us-ascii?Q?uqljeOKiWtHZIM8kvRNs9efimXAsYCr7nj1d2CwnE+AZ0+YjxHla2dFlGwGA?=
 =?us-ascii?Q?9mLUO4QllT6dgQzpUVsPQfyJx0a3Kmp0qcZTsKe4jIG4nVUyShvCW00uZ4K8?=
 =?us-ascii?Q?evTVNLIx0Qes0JNHNswsX/38W5KyvVJU/Wr+Kj5nf6P2UENnSjbdnjR/ExkZ?=
 =?us-ascii?Q?h0H7UeXq7acAJS+sj+cSzS4qXJtWqKuChomheZrybaPUVJ3rz0cRKJlVtAIN?=
 =?us-ascii?Q?yJZck7HKRMs+3TEswrhRPAR0MvPIyhYGWVqs1FAzXdo8brX69cy1VngoeAZP?=
 =?us-ascii?Q?gAJZfWI7ZCmBqPAmD5IPatwhg1aDdht60w3YFKVKzeztwMt8OgKi0kmYlNRX?=
 =?us-ascii?Q?JW98B5vovaF4MIDli50L0PYkWLWhL10KLIrzZr/SJtP/HkjFWiU50zZnN6En?=
 =?us-ascii?Q?1CPr2DQq6zOf0iM5ytfPTaoANNIAzdAUdXBIHxhhRYsnGZv2TqaxoDdHy+Dv?=
 =?us-ascii?Q?0CqjyT0RNhnT66bG2hlThM/7crcZ3Es0TZpTL5+DJS5PKJKZ5Tw8wtzO9Zf9?=
 =?us-ascii?Q?tuB2ghTrq1ZmcNj7yQ/8BtoFIIw1nKRlqNhJddSbMN8+WkJL7Zd3n3VLydj/?=
 =?us-ascii?Q?8wKW6jQMBfn/Off3eXInw+ULaja2MY0BmXqPphLbH5us5yXtLj3v3Vwq8p6j?=
 =?us-ascii?Q?1hO4URqGZJNrsrk33huBihKQlIVuKGmOKdcqAcwy2y596ptuGBwOVhIniCU8?=
 =?us-ascii?Q?SgbPubiEJuGg5wOVphLRLl4rWfPFiKXjhZ4YUFlbWAHTqQsUtTfahpsIrnJl?=
 =?us-ascii?Q?geAkUNSWA05WDHRFUi4znQa+d2a/oN+gFje3CgkrBB3Yboddsdb2mtzDgVGg?=
 =?us-ascii?Q?n32oD26FlxoAkwMK9+jivbQrR6Nf2igsQ/IfIz8QcclP6BsATi3AAR1/CqZp?=
 =?us-ascii?Q?IHjQK8kFJKeB9h4qGFP4Ojg=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6931fb4-f99e-405e-ed2a-08dbfc4d665d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2023 02:35:56.2836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YjxlZ02M3c9bFTP5EjKgowVAgb2ZqqX7AYmPaeBIf1AD6wLTWqkSMpROk6bHyveDKW0W0uV++NLFems8n/QZm7UN59q+WasKqoqDnmUTwknPItd7oKqtFttBZAHeACpa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6143

Hello PCIe maintainers,

> From: Yoshihiro Shimoda, Sent: Tuesday, November 14, 2023 2:55 PM
>=20
> This patch series tidies the code of PCIe dwc controllers and some
> controllers up.
>=20
> Changes from v1:
> https://lore.kernel.org/linux-pci/20231113013300.2132152-1-yoshihiro.shim=
oda.uh@renesas.com/
>  - Based on the latest pci.git / next branch.
>  - Add a new patch to drop host prefix of members from dw_pcie_host_ops
>    in the patch 1/6.
>  - Add Reviewed-by tag in the patch 3/6.
>  - Drop unneeded local variable in the patch 4/6.
>  - Add new patches to resolve issues of clang warnings in the patch [56]/=
6.
>=20
> Justin Stitt (1):
>   PCI: iproc: fix -Wvoid-pointer-to-enum-cast warning
>=20
> Yoshihiro Shimoda (5):
>   PCI: dwc: Drop host prefix from struct dw_pcie_host_ops
>   PCI: dwc: Rename to .init in struct dw_pcie_ep_ops
>   PCI: dwc: Rename to .get_dbi_offset in struct dw_pcie_ep_ops
>   PCI: dwc: Add dw_pcie_ep_{read,write}_dbi[2] helpers
>   PCI: rcar-gen4: fix -Wvoid-pointer-to-enum-cast warning

According to the patchwork [1], all patches have Reviewed-by tags.
So, I think the patches are acceptable for upstream, but what do you think?
I confirmed that the patches can be applied into the latest pci.git / next =
branch.

[1]
https://patchwork.kernel.org/project/linux-pci/list/?series=3D800901

Best regards,
Yoshihiro Shimoda

>  drivers/pci/controller/dwc/pci-dra7xx.c       |   4 +-
>  drivers/pci/controller/dwc/pci-exynos.c       |   2 +-
>  drivers/pci/controller/dwc/pci-imx6.c         |   6 +-
>  drivers/pci/controller/dwc/pci-keystone.c     |   8 +-
>  .../pci/controller/dwc/pci-layerscape-ep.c    |   7 +-
>  drivers/pci/controller/dwc/pci-layerscape.c   |   2 +-
>  drivers/pci/controller/dwc/pci-meson.c        |   2 +-
>  drivers/pci/controller/dwc/pcie-al.c          |   2 +-
>  drivers/pci/controller/dwc/pcie-armada8k.c    |   2 +-
>  drivers/pci/controller/dwc/pcie-artpec6.c     |   4 +-
>  drivers/pci/controller/dwc/pcie-bt1.c         |   4 +-
>  .../pci/controller/dwc/pcie-designware-ep.c   | 249 ++++++++++--------
>  .../pci/controller/dwc/pcie-designware-host.c |  30 +--
>  .../pci/controller/dwc/pcie-designware-plat.c |   2 +-
>  drivers/pci/controller/dwc/pcie-designware.h  |  12 +-
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c |   2 +-
>  drivers/pci/controller/dwc/pcie-fu740.c       |   2 +-
>  drivers/pci/controller/dwc/pcie-histb.c       |   2 +-
>  drivers/pci/controller/dwc/pcie-intel-gw.c    |   2 +-
>  drivers/pci/controller/dwc/pcie-keembay.c     |   2 +-
>  drivers/pci/controller/dwc/pcie-kirin.c       |   2 +-
>  drivers/pci/controller/dwc/pcie-qcom-ep.c     |   2 +-
>  drivers/pci/controller/dwc/pcie-qcom.c        |   6 +-
>  drivers/pci/controller/dwc/pcie-rcar-gen4.c   |  12 +-
>  drivers/pci/controller/dwc/pcie-spear13xx.c   |   2 +-
>  drivers/pci/controller/dwc/pcie-tegra194.c    |   2 +-
>  drivers/pci/controller/dwc/pcie-uniphier-ep.c |   2 +-
>  drivers/pci/controller/dwc/pcie-uniphier.c    |   2 +-
>  drivers/pci/controller/dwc/pcie-visconti.c    |   2 +-
>  drivers/pci/controller/pcie-iproc-platform.c  |   2 +-
>  30 files changed, 203 insertions(+), 177 deletions(-)
>=20
> --
> 2.34.1


