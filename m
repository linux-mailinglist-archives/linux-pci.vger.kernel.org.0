Return-Path: <linux-pci+bounces-1706-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0722E825281
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jan 2024 11:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2078286673
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jan 2024 10:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DFD2510D;
	Fri,  5 Jan 2024 10:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="nNkMQNQD"
X-Original-To: linux-pci@vger.kernel.org
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2098.outbound.protection.outlook.com [40.107.113.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6182CCB2;
	Fri,  5 Jan 2024 10:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b+hrewaEMoFZ803zY7gxePf5OsKAF8QmKsiJPC21jnznsMqcKjd0lWWUruP2sS08uc2s6RgZn29Cz1Utt1/KYQ2g7utBRM59Qnc5q9tYrq3NIczzIHolf2Tp8825Zr1Md4d8HwrNCEFUzHfFk6BoZw3uBlV3WVi62Bvp3gDIULXHPOiiuVoKM/nX3ChJO/Q2I/2uOwK412ItJDrdQ2zJLdRcq3UXkFMGARijuOfA9QES5xWw0mlZJP/uAqbocvrgjxSe7WfxcuHGmUWRFs9HEtu8bgtYevpDP7CbGLz+ffTdz3qlltWAZMbZHE6vHS1lGPRBVkqFEsQOVTE7IyIPFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vC+GLa6gABNipsO1TeHtcKW46xdoSIpIcOt5Gt1S86s=;
 b=Nb5vUKjz6ClvfCRioDdqPhZP1dglWXZVxfYmculk71XvU7AvhQ5bFYErKKro8yjW4IkpSaKr39Vb4v4hkCTWAP/C1xAlLqeBTRKR4ccq7wNnQJWB/DZZR/2LfD4h18d9eBfFJZsKgovjjnv8+JftsiKeyOGkHVwn/pXF6jTRRrloJl8eqs9RWUkVRVWzVtJ8/0itX2P6cM5sla/HBklMJmO5QuqVqu801foOl9iYozOmJgj+JKqE/qQ/8gctOf3mqC6+K4Yikbgg99cbidgCLH0MLnau+wljdeLO7TxRpVcem7t8YfEpuv5y/We8bnv57bCRVq8WLcVupemu149TtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vC+GLa6gABNipsO1TeHtcKW46xdoSIpIcOt5Gt1S86s=;
 b=nNkMQNQD+6/KTm99S0RoisvGG5D2b787ulQgVuMVs0i64RKkWr9gUbykQiv3bBQIAMzhRxBeBLa/RsFduYQN2GLFhe7Su4L2CJCG+s7mmqLwUfikGkvrARBAOuuwL6gYqblRW4nOBo85OizAk7rfB3TOKYWFRgmbjjhDoJJ36F8=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by OS3PR01MB7993.jpnprd01.prod.outlook.com
 (2603:1096:604:162::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.10; Fri, 5 Jan
 2024 10:59:04 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::43bc:a2d0:a5a:9870]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::43bc:a2d0:a5a:9870%3]) with mapi id 15.20.7181.009; Fri, 5 Jan 2024
 10:59:04 +0000
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: Serge Semin <fancer.lancer@gmail.com>,
	=?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Manivannan
 Sadhasivam <mani@kernel.org>
CC: "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com"
	<kw@linux.com>, "robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
	"mani@kernel.org" <mani@kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v4 0/6] PCI: controllers: tidy code up
Thread-Topic: [PATCH v4 0/6] PCI: controllers: tidy code up
Thread-Index: AQHaMwbKcxJp/gf9MEupTc95qiYVULCyShaAgBjaDqA=
Date: Fri, 5 Jan 2024 10:59:04 +0000
Message-ID:
 <TYBPR01MB534178CDECD712FE68F8A446D8662@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20231220053829.1921187-1-yoshihiro.shimoda.uh@renesas.com>
 <fgnz47aqndjyn2y4u7jhdbdagtarwaasiekajavmxolpmsdu74@plhasdd5z55b>
In-Reply-To: <fgnz47aqndjyn2y4u7jhdbdagtarwaasiekajavmxolpmsdu74@plhasdd5z55b>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|OS3PR01MB7993:EE_
x-ms-office365-filtering-correlation-id: 980e1442-2e8c-4b84-c912-08dc0ddd54f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 WR9FyYRKdWY8/qSjKIY2DBilBtsjJq9KnVL5BaU6diYP1muG0NCmPJmvytlIA2PntFC7eWzxnpR/wdvji8UG2zl6LZ61jkU1K+qbMM0I/3p6p7dX6lhd5imutwmc5309fAN/huwpNMtbeU1oSX3fV8eWPEwTE021zBaqPpAqMLUPBp2jpOxNdmSuxmvZs/stAt1S4rPLnDpl47ZV3hmgHkrAMSG+FlIeDc4w5phPcgqxwT9SIGUvZKTFBDRRf/08KFA7zunZYo7SSDEX3Tn0KVIj5rpNjLOIriU9ppl+1+QPZVJMUtYrror+bq1RNF1muauLTbciy9DS/or7LaFyTVWg9gyBTHRFzxmaS5hMpWioz+rA/GuVmVm2uq7uosXBK3P0Ej8rrHhZM7YUBp3/eRpS7lYNoJFFlcjk5jBdG3FM03JjfOEvUEIOcga4tH3lObrQ51gWAwKKGg+n4XNjGKaqfQjvLtRIF7SFryNLq2zcFuSfLYghhETUriAMEf3GwmrTe6chZ+L6ejAe4Op94nKWlyxyT02zoEP2/mvc54NUmF6bpwSZ6eKARw1BPIUNElzVBKq7TQMo/wbg7w2XyS8h17QnPBMp/o2zfler0Yc+fezdjMPY7SBxjJLwRqR7YOqb6CwJBxjqlS17rdeBew==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(396003)(136003)(39860400002)(230922051799003)(230273577357003)(230173577357003)(1800799012)(451199024)(186009)(64100799003)(26005)(83380400001)(6506007)(9686003)(7696005)(71200400001)(122000001)(38100700002)(5660300002)(7416002)(52536014)(41300700001)(2906002)(478600001)(966005)(110136005)(4326008)(76116006)(8936002)(8676002)(316002)(54906003)(66446008)(64756008)(66556008)(66476007)(66946007)(86362001)(33656002)(38070700009)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?JysMaWC2jCl8BQ9cCeJzKAI9Bmyc7LgyspuYB8dyY5t/TbI6en85HrYjnk?=
 =?iso-8859-2?Q?kTCpXN3Z/eBD3JiVxuFrfAabmlRBU4aek0uOOGdK6SLtfuHV/oUGsuc+oV?=
 =?iso-8859-2?Q?OUia6mp5HtofQTMqDm8vBS+dt2BsTF2agcqvFgdmpqZMYjHlVLlZi3w0AJ?=
 =?iso-8859-2?Q?YfkmbKdx8xqDjCvUA4hlU/ty/HAabZ0zaEmLfXkohqeK4kIFAIhpm/kUom?=
 =?iso-8859-2?Q?gZzGn2SrRhrxb94oIMP6qqTsaFk5JYRILrGlQxQiQkgYxuSXjoBpXp1/ej?=
 =?iso-8859-2?Q?cqHu+r2a5GSZ6v4UoPg5C1MHVtAcFzdjgy7rD1KB0zAQluHZlM8hABvNcO?=
 =?iso-8859-2?Q?N7vx2l8QO+rR5tqwLSz1uKTanmXmJPbiR4A9je8kHILAiAK/VreYJwB5Ew?=
 =?iso-8859-2?Q?vT+UYKcXAwLwTQTf5aVFSD+JkBStrRgjh6o8aXALgameCe8Mr2qYj/3X+9?=
 =?iso-8859-2?Q?3nORvHbO9jb/L2TjGRCtN5FkmgEAxhgeZOrmoMs0/BLe/bfKCe92TxL7o4?=
 =?iso-8859-2?Q?7VFtDPTuGbYyN5QUtrLpfV7VAVIvHPgFyaPj8ITismYVFLgQ/HYhxRrI7G?=
 =?iso-8859-2?Q?hfSOH2WB8bUmkiF9DDsGsoGjA1XDwym5ltT8UdnfBRHfErX55yJuTZILJo?=
 =?iso-8859-2?Q?+i7bnKeUTPyeDuVHTkaAve0qPTE+lBcyb25GVnFACsOmg+Zqc7gAdHbH5z?=
 =?iso-8859-2?Q?ZShkyOR3T7MNjooDzdE4VmCBQxslGoPoQz3aYp4BTtQLp4tQyOcdVmX+E1?=
 =?iso-8859-2?Q?ooCoa6LeBhFZR3uKjCsPKzwyfVNzji8+G7fpeyRbTKp9cHMEpjpu5ChDBN?=
 =?iso-8859-2?Q?8RmHg2UJWBE1sPmbUzNeXT0PKDsh2EXgeUq4ctmjqaZI1nXA84f6VodZpv?=
 =?iso-8859-2?Q?bpdqyMhAcWaEAYxLjuWxdcAlJ5j8KgXFkxv9UhzXTCMO4pRICffloH7E/K?=
 =?iso-8859-2?Q?Q2tpPgUUvTGF2X1aIcWnuRSYAY/oTW/vhGvGJKeTEL8KeDv01CVeHPvZHu?=
 =?iso-8859-2?Q?osChvp7pv7fOyxQuiVyLrY/eryTIRQ7TjXf5nPzMPrqr2K/R9TxtGoNaLJ?=
 =?iso-8859-2?Q?f/WmqQCCvVYag5B1JDo9fqoWHIjV/aVgvvxOImDHPDOsRrV11vxfnJLQto?=
 =?iso-8859-2?Q?RNdYAyyYxcsF0ARJTvS0lYuN07XVptvM9PJ1LSMAsf63IZI/gL/syz2RgC?=
 =?iso-8859-2?Q?1O5/vnNhOJ4TQ+1Q00DXHjupPWVV6f3//RYjF4AweHF715KguKrZ5Lr1uG?=
 =?iso-8859-2?Q?yNDcYVSlt0zdbax5cgvHipqQVlGUQqBBmuJNuz3XI3JhQYp9igLxw/NkW9?=
 =?iso-8859-2?Q?UsjbCfzifWufQR+GX83qVj/7fktf15YVRWfm9Y4W/l29b8eBc6qJsRSvAm?=
 =?iso-8859-2?Q?xwinN38TeR9bXlokHN0j3PrRQb81AFA02UaMrX1SVye5UFmxt/jdYuAaw1?=
 =?iso-8859-2?Q?BrMNHtawJRHpSBP+BuXTg9XFlGNY75TNMCszpo+5V0qVO9WVxjVGIsPZ2i?=
 =?iso-8859-2?Q?wVWB0EHLss4FO+u6dMCTcnoMOb0IC+ruWM/SzGBKYRf2430D73CTd89kZ5?=
 =?iso-8859-2?Q?086Ia8mu7OyXKygXrUWAjVsWDA3fmQwkgps0z/UzexgnncNV7hJAUSgkR9?=
 =?iso-8859-2?Q?eQENI24ze0sTJysXtmETFadVue+eMi8HNO6PP1iadgulro9fCl+tKkRg?=
 =?iso-8859-2?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 980e1442-2e8c-4b84-c912-08dc0ddd54f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2024 10:59:04.3648
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y9Cf/cS4bOAEyQA0cI3k0Oc6HUCUz7m5AOcBmMynLBbgSnuvpJhiLpL0c9JF33kZchabozejAgO2mnmG87MqvLx8BQG0TMtlQI/9O/AEv3LGBIPf5hIoe0eVFtEe5S9L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7993

Hi,

> From: Serge Semin, Sent: Thursday, December 21, 2023 12:21 AM
>=20
> Hi Krzysztof, Lorenzo, Bjorn, Mani
>=20
> On Wed, Dec 20, 2023 at 02:38:23PM +0900, Yoshihiro Shimoda wrote:
> > This patch series tidies the code of PCIe dwc controllers and some
> > controllers up.
> >
> > Changes from v3:
> > https://lore.kernel.org/linux-pci/20231215022955.3574063-1-yoshihiro.sh=
imoda.uh@renesas.com/
> >  - Based on the latest pci.git / next branch. So, I modified the patch =
1/6
> >    for pci-layerscape.c.
> >  - Add Reviewed-by tag in the patch 4/6.
> >  - Fix locations of read/write accessors by grouped for readability in
> >    the patch 4/6.
>=20
> The series has got all the Mani's acks. The last nitpick was fixed in
> v4. No more comments at least from my side. What about merging it in
> (before merge window v6.8 is opened)?

Serge, thank you for your comment.

Hi Krzysztof, Lorenzo, Bjorn, Mani,

Would you apply this patch series into pci.git / next branch?
I confirmed that the patch series could be applied on the latest pci.git / =
next branch
by using the following git-pw command:
$ git-pw --server https://patchwork.kernel.org/api/1.1 --project linux-pci =
series apply 811670

Best regards,
Yoshihiro Shimoda


> -Serge(y)
>=20
> >
> > Changes from v2:
> >
<snip URL>
> >  - Based on the latest pci.git / next branch.
> >  - Add Suggestion-by and Reviewed-by tags.
> >  - Move read/write accessors to the header file in the patch 4/6.
> >  - Revise the commit description in the patch 5/6.
> >
> > Changes from v1:
> >
<snip URL>
> >  - Based on the latest pci.git / next branch.
> >  - Add a new patch to drop host prefix of members from dw_pcie_host_ops
> >    in the patch 1/6.
> >  - Add Reviewed-by tag in the patch 3/6.
> >  - Drop unneeded local variable in the patch 4/6.
> >  - Add new patches to resolve issues of clang warnings in the patch [56=
]/6.
> >
> > Justin Stitt (1):
> >   PCI: iproc: fix -Wvoid-pointer-to-enum-cast warning
> >
> > Yoshihiro Shimoda (5):
> >   PCI: dwc: Drop host prefix from struct dw_pcie_host_ops
> >   PCI: dwc: Rename to .init in struct dw_pcie_ep_ops
> >   PCI: dwc: Rename to .get_dbi_offset in struct dw_pcie_ep_ops
> >   PCI: dwc: Add dw_pcie_ep_{read,write}_dbi[2] helpers
> >   PCI: rcar-gen4: fix -Wvoid-pointer-to-enum-cast warning
> >
> >  drivers/pci/controller/dwc/pci-dra7xx.c       |   4 +-
> >  drivers/pci/controller/dwc/pci-exynos.c       |   2 +-
> >  drivers/pci/controller/dwc/pci-imx6.c         |   6 +-
> >  drivers/pci/controller/dwc/pci-keystone.c     |   8 +-
> >  .../pci/controller/dwc/pci-layerscape-ep.c    |   7 +-
> >  drivers/pci/controller/dwc/pci-layerscape.c   |   6 +-
> >  drivers/pci/controller/dwc/pci-meson.c        |   2 +-
> >  drivers/pci/controller/dwc/pcie-al.c          |   2 +-
> >  drivers/pci/controller/dwc/pcie-armada8k.c    |   2 +-
> >  drivers/pci/controller/dwc/pcie-artpec6.c     |   4 +-
> >  drivers/pci/controller/dwc/pcie-bt1.c         |   4 +-
> >  .../pci/controller/dwc/pcie-designware-ep.c   | 188 ++++++------------
> >  .../pci/controller/dwc/pcie-designware-host.c |  30 +--
> >  .../pci/controller/dwc/pcie-designware-plat.c |   2 +-
> >  drivers/pci/controller/dwc/pcie-designware.h  | 105 +++++++++-
> >  drivers/pci/controller/dwc/pcie-dw-rockchip.c |   2 +-
> >  drivers/pci/controller/dwc/pcie-fu740.c       |   2 +-
> >  drivers/pci/controller/dwc/pcie-histb.c       |   2 +-
> >  drivers/pci/controller/dwc/pcie-intel-gw.c    |   2 +-
> >  drivers/pci/controller/dwc/pcie-keembay.c     |   2 +-
> >  drivers/pci/controller/dwc/pcie-kirin.c       |   2 +-
> >  drivers/pci/controller/dwc/pcie-qcom-ep.c     |   2 +-
> >  drivers/pci/controller/dwc/pcie-qcom.c        |   6 +-
> >  drivers/pci/controller/dwc/pcie-rcar-gen4.c   |  12 +-
> >  drivers/pci/controller/dwc/pcie-spear13xx.c   |   2 +-
> >  drivers/pci/controller/dwc/pcie-tegra194.c    |   2 +-
> >  drivers/pci/controller/dwc/pcie-uniphier-ep.c |   2 +-
> >  drivers/pci/controller/dwc/pcie-uniphier.c    |   2 +-
> >  drivers/pci/controller/dwc/pcie-visconti.c    |   2 +-
> >  drivers/pci/controller/pcie-iproc-platform.c  |   2 +-
> >  30 files changed, 222 insertions(+), 194 deletions(-)
> >
> > --
> > 2.25.1
> >
> >

