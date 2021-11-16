Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8459F453CE9
	for <lists+linux-pci@lfdr.de>; Wed, 17 Nov 2021 00:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbhKPXz7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Nov 2021 18:55:59 -0500
Received: from mail-eopbgr20042.outbound.protection.outlook.com ([40.107.2.42]:4994
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231237AbhKPXz6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Nov 2021 18:55:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z8taJwqc/nqGvoIe4pGJBAUvOGj9a3xfZKz0nK9Od6kKrqj5038Ey+nFGwy96lOupoiqzT1LJkQo1yEr0YuJxv51DBaIrCrv/djLfmgkyV5seVZ/5b/tRz5rnEqx0S+meeyCvnl5F+eWohAlHJLZyNUMpxH7iE7GaoLFdWo1RfV+jq+TLoHMbdvYnTrEmvG4IEwoFb1JpLjixT8lpuh9H/KFbNJu5Q4dHkA/U7rMH9lKUTUNS0gr11T3tf1Lt7j2LzsK0CdWjRB5H/RbUu5oC6aCsW/O3jaHFgk+dLBYBwSsT6hMvyu2VI8YzCai/jmWBuPEruvMuPCIAD9gKAiSEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g+2eQ2O5eI+/L+lAv0jSKliIyMgMVmDvAkO0erFtfNQ=;
 b=k7GWOU62gL1LxVEHw4nbiDncw72Y0YPoBzjIfsAmD84U+kdOSD4vuwehzVj516onUkxM9OIa2oPyHm5hEubNjZnQzNFTxB5MRYsnvABABwDoQV0Toyog7e4xuaQNWXxf2iR58k+m6rzKIkwYrqn/47u5iGHIOj2oRt8NuaRohv5Yxdljuoo4MRX6+k3d0TvL+q2D+gf2OM//rETPXhPE4EODKUJBmz7kcxAIqyQbalkJMk7GeAQnTP3/iLzgJNdnSCBwcwsipEK+TDFv9l7uGlfIz8E1y9R2FhCwhGOU7WfRaSqqZXLc20KaQU8w7D3S9eEQX+fspAZBgF+ypOwAZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+2eQ2O5eI+/L+lAv0jSKliIyMgMVmDvAkO0erFtfNQ=;
 b=oqDrmzpG/362oxgduNE7N1dF5/9QlL/JW+aYR4ufQg2YDCXk+SDZbXSNK/UZI+KVO4MsHVqi9fzqdj59Gnt/cxaU8wZB6GD/I97GOYbcFu8oK5mvW/MHLZFvo1aOMAAOD7UCSnJKNuVfRSvL8cv3nnHTCeyvKJ+R1hJ9TpHkFDM=
Received: from AS8PR04MB8946.eurprd04.prod.outlook.com (2603:10a6:20b:42d::18)
 by AS1PR04MB9478.eurprd04.prod.outlook.com (2603:10a6:20b:4d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.25; Tue, 16 Nov
 2021 23:52:59 +0000
Received: from AS8PR04MB8946.eurprd04.prod.outlook.com
 ([fe80::60be:d568:a436:894b]) by AS8PR04MB8946.eurprd04.prod.outlook.com
 ([fe80::60be:d568:a436:894b%5]) with mapi id 15.20.4690.027; Tue, 16 Nov 2021
 23:52:58 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "Z.Q. Hou" <zhiqiang.hou@nxp.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "M.H. Lian" <minghuan.lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>
Subject: RE: [PATCHv5 0/6] PCI: layerscape: Add power management support
Thread-Topic: [PATCHv5 0/6] PCI: layerscape: Add power management support
Thread-Index: AQHX10VWylQVAE7D+0KkUdn+5xyozKwG2pZQ
Date:   Tue, 16 Nov 2021 23:52:58 +0000
Message-ID: <AS8PR04MB89468279B5E59F5CA33BEBDC8F999@AS8PR04MB8946.eurprd04.prod.outlook.com>
References: <CADRPPNRL8m+YawUJJe0MNLhRQ4NJROv4DVzP+rWTGeS6fCbDnQ@mail.gmail.com>
 <20211111214436.GA1352369@bhelgaas>
In-Reply-To: <20211111214436.GA1352369@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9d518fbc-1cd6-4ede-24f9-08d9a95c37ed
x-ms-traffictypediagnostic: AS1PR04MB9478:
x-microsoft-antispam-prvs: <AS1PR04MB94784ED5EB8E8852940F888D8F999@AS1PR04MB9478.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FEzIgZEOwuSaxnUGboluqqSxl+Vz41JcBGkhXUTLwxmUC/glmcUMSHH5Yvdx3u3zWXeYwAa+SlS0XofsQy47r2+vtVxS86Wn4/eCh/TMBvXEs+s5iUoC5xEOSyivNnAKmcFEjvFoK3LgHLYiJFIkXhqH9vC6foVvpWzSFHhBYSQIkinBZkHKYEwDUDgxF1QaWk87A37ekV1xtBrdxIlrKH9u/YYCB09o9g705zXf6gXUSTeueV0EE8Eo8MWxCfht5P81XurvuTGpehytt6eLfvpWCzlB5OphFocg39wdWrOvRzvuT5L6mgWQi2EV8z7FQ24zqupkANgoGpdkl8tmcI8aVlUNd2JuvDb1Mi/ntZXff1Z5BCMXpdotqrzWnJGmamjLF4OLA3hVxQbwKCYKRpaFg32a9L59Mob4NCSe4IExrXCB12APvSgUB5cWxg/ZLUHKlhI5o8QYfnJt3n1TENLSJ9j6wGHDJNuvZ6lMRD+cY/DBz9QdIiLg4mlLWLblsFbkH5EjIUfF/b5dvmsPts1/LkRkCGK72Nueis+N2PEHjRqJd3YuLiiK9898hkDdXpK/PJ5j9Oc0inF33IhpCgoyzMJMI+YCnLY8uWgWir6UFJ7t9iViAfjegD79t/FGO3lM7kspgnmVqb+Zx+LXbCCz9fZZ6Y+Rd9XjrYM90m2ZVSIr1EOWWdJNL2uQw7KyxmPkJ5RCmI6gXO3me3YiWw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8946.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(9686003)(52536014)(38100700002)(66556008)(71200400001)(66476007)(76116006)(122000001)(8676002)(66946007)(83380400001)(53546011)(6506007)(8936002)(55016002)(33656002)(7696005)(7416002)(316002)(4326008)(26005)(2906002)(38070700005)(186003)(5660300002)(64756008)(66446008)(54906003)(508600001)(86362001)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rS4e7TIAHWGuaxPuiTu38HLM0TDnQnl9ZQffb6YwgngDGiO6NQn1HErmkbWQ?=
 =?us-ascii?Q?grxtelgpOlWzSkdIP0z8WNZdSWPzTbDJrv6fgHfXuZQzli3DqjhS2H1yx5zS?=
 =?us-ascii?Q?R3q/CV3J8bfmOVSIO6+BPT61qud9d9uHRa8JyNrv0mFKTWkq62l1bGfLJ/hh?=
 =?us-ascii?Q?mkJY95EZt6YRxhE7AxxQ4etTMs8D9yAfw8igEHYiIYRhK2QQE4aMaP8bef3N?=
 =?us-ascii?Q?yMZk23Hnfd3Uf7AaV462iE+vaJUh1xaXrhvXFgiaR2LqZcctliDXBO0nX+EU?=
 =?us-ascii?Q?pLl2qkArlxtSMWlBkJgiWIqKhwNnUEJeV7HLIn7HPMYljUmctCeJ+kH34Nes?=
 =?us-ascii?Q?awe/cPOroP30hHR/bp/K9FB9nLiPn/cn9M4Vp0J2pKIRBRA3+9kyiPcfTdzx?=
 =?us-ascii?Q?iHJidtZTXXlCviStiCaJ1m5xbWUNw6R/4S3ysUQIx/aLrUojnKQgrfushshD?=
 =?us-ascii?Q?LyDq3kRqaWZX/qF3guchcIWSSOKkuuwXJRF+a/IHmwm5na27a+7xEepf+QRb?=
 =?us-ascii?Q?dbfqj1xETw1uZ1laL5uwy07pDgguk3vyxFWboI4LbKDFqdXtJSSrsrAH/AP5?=
 =?us-ascii?Q?7QAMdMXhzS0MvZQ75V9YJiw3U1HVgh5s5VSlJ3sLCcUWsSUJmM3BQvmL0gCy?=
 =?us-ascii?Q?VuZVtsS94SvuiUspsXYD5r+iur8F0FVLLm9SVEdGKy2sQowNc8bO5jTEZ/CT?=
 =?us-ascii?Q?XquqPFqhYykhBnRCkuKH7u/nGfWoyeXXnheV/CnMEq+0Ijvwj1jyRZhT53if?=
 =?us-ascii?Q?7XZw2DCuhBsnM3Iy9K10tc0U0b2oR9CuKDaivgxLRud/hKrY5BKkHG9B9d4Y?=
 =?us-ascii?Q?CB1ODtnTD7kNZRO09vUG1XZBwj6hgUKxBQpBMbBZIf9u7qEHwEVCD26xBVuG?=
 =?us-ascii?Q?IMCMJZoNxZjks5zcEEeW7Mnsld+ObxF2t3PdeBIMy1FfrMs8ixEZPl7Zgxuy?=
 =?us-ascii?Q?CGaInm8Q3mLAXYfufoC8KQCU/KmshYrGVNiclMPTKKfPaoEwMZbORZBJMFnl?=
 =?us-ascii?Q?AXesRSBd5un/kiPjbXgb1mPQLI44KbO3QlpumAZuMOxFeKF308uIHjdNOTCz?=
 =?us-ascii?Q?VrJBR+or266QJ5auVdP4s/6JgtrYk1IeXXzFWB42CIeaY3stmjwWObGSK7uf?=
 =?us-ascii?Q?S33aSRRz6h5SBn4Trm3cV2HJR/YdfOcX42dn1AtBDbJCY7Ozqq7Q5yaJBZYH?=
 =?us-ascii?Q?BMkglGdtGKfKj2PGZSqVNbLMBmWyCYbjEsEE8SE4a9qfCCoHVW7943KA7vi5?=
 =?us-ascii?Q?GqLdLJE8nqIpcgNufdgWx3nUpyJz9/ahhrGm0E1xmm64W8lmhKmNCDE1Pm6E?=
 =?us-ascii?Q?JyoCIkFe2XoZDybCVEwSNZgS0ZPM3m7nMF4CIjRDRD3cs4qCcD8qMAp0V+QK?=
 =?us-ascii?Q?jIttJuCCEOcqgGP9G4ztAtTyEaRoRQXx4b+vqYA+m9nXMvHW4uJ7cJ0fPXDl?=
 =?us-ascii?Q?iyE49ai3LDw0cUebV35/K7jqlvCnO6j7k+2CBqS9firTra6hn8fXjfsQotML?=
 =?us-ascii?Q?J8ZqjkghBhYR8gD+rD2V357gYsc+d3K/jmUDwSFW2Y+ubJwLjKqpZBVEKUNF?=
 =?us-ascii?Q?CfoQSAh7MGpl3SDbRkSn9JJugoBx6hca7WcDpVm/GfDgABsR9A+AepJno+If?=
 =?us-ascii?Q?4g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8946.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d518fbc-1cd6-4ede-24f9-08d9a95c37ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2021 23:52:58.8237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RdRH3NNjoM2anym6pTPp+eTPLOeN2SQRZMhYECcw2CMi3zPZjQnD01358VE5K2a3mUfcuGc+axETKD+ji4AKuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9478
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Thursday, November 11, 2021 3:45 PM
> To: Leo Li <leoyang.li@nxp.com>
> Cc: Z.Q. Hou <zhiqiang.hou@nxp.com>; linux-pci@vger.kernel.org; open
> list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
> <devicetree@vger.kernel.org>; lkml <linux-kernel@vger.kernel.org>;
> moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE <linux-arm-
> kernel@lists.infradead.org>; Lorenzo Pieralisi <lorenzo.pieralisi@arm.com=
>;
> Rob Herring <robh+dt@kernel.org>; Bjorn Helgaas <bhelgaas@google.com>;
> Shawn Guo <shawnguo@kernel.org>; gustavo.pimentel@synopsys.com;
> M.H. Lian <minghuan.lian@nxp.com>; Mingkai Hu <mingkai.hu@nxp.com>;
> Roy Zang <roy.zang@nxp.com>
> Subject: Re: [PATCHv5 0/6] PCI: layerscape: Add power management support
>=20
> On Thu, Nov 11, 2021 at 03:21:37PM -0600, Li Yang wrote:
> > On Wed, Apr 7, 2021 at 9:13 AM Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
> wrote:
> > >
> > > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > >
> > > This patch series is to add PCIe power management support for NXP
> > > Layerscape platforms.
> > >
> > > Hou Zhiqiang (6):
> > >   PCI: layerscape: Change to use the DWC common link-up check functio=
n
> > >   dt-bindings: pci: layerscape-pci: Add a optional property big-endia=
n
> > >   arm64: dts: layerscape: Add big-endian property for PCIe nodes
> > >   dt-bindings: pci: layerscape-pci: Update the description of SCFG
> > >     property
> > >   arm64: dts: ls1043a: Add SCFG phandle for PCIe nodes
> > >   PCI: layerscape: Add power management support
> > >
> > >  .../bindings/pci/layerscape-pci.txt           |   6 +-
> > >  .../arm64/boot/dts/freescale/fsl-ls1012a.dtsi |   1 +
> > >  .../arm64/boot/dts/freescale/fsl-ls1043a.dtsi |   6 +
> > >  .../arm64/boot/dts/freescale/fsl-ls1046a.dtsi |   3 +
> > >  drivers/pci/controller/dwc/pci-layerscape.c   | 450 ++++++++++++++--=
--
> > >  drivers/pci/controller/dwc/pcie-designware.h  |   1 +
> > >  6 files changed, 370 insertions(+), 97 deletions(-)
> >
> > Hi Bjorn,
> >
> > I don't see any feedback on this version.  Is there any chance that
> > the binding/driver changes can be picked up?
>=20
> Probably slipped through the cracks.  We're in the middle of the v5.16 me=
rge
> window right now.  After v5.16-rc1 is tagged (probably Nov 14), rebase yo=
ur
> series on top of that, incorporate Rob's reviewed-by, and repost it.  The=
n
> Lorenzo will see it and take a look.

Thanks Bjorn,

While we waiting for the repost and review for the driver change, the dt-bi=
nding
updates seems to be unrelated to the driver changes.  So probably they can =
be
applied separately to make the dts changes mergeable?

Regards,
Leo
