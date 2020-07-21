Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1299B22779A
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jul 2020 06:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725764AbgGUE2g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jul 2020 00:28:36 -0400
Received: from mail-db8eur05on2069.outbound.protection.outlook.com ([40.107.20.69]:15205
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725294AbgGUE2f (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 21 Jul 2020 00:28:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gFQVcQyaWvsUG44XdSChW2yUXoo+b9mZbXnsvI90K6Ie/HbmdqIWWnN92qY5yuoEP71ETYMCJaeeCxiiod8A3N2Zk2MPC1ZTCeAst35p0kHz8rKGcOj6AthtFokM0voSHgRk7sr/mTp18rTsQl7gjkAKPHGt0J27irrOj/eBxqFYOvafogyfaDR+MXr1qhvuRCf4uVax8ZirRbq88FV3mnNkLUureJeIs6rOsO34KndID4fguw7TadWlLx/VPyeciN5py0lvdGDum9OXzCHxinsz2P/Hao/iOi3dvkAtoTYgg/Z9S92c178xlq9pQKhkxME/4QpgPQk+YQJtxoNwDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HA5z3Mh8DZD1o3ypG13EfIrFK75pKfsvj81iTyYA0uE=;
 b=IpR5Cs4A4+GgKWGu3o6MnmmsLyXCqvCwchPw0wTLzeFgcCZ5CXifclov0+1mO+Crocu/tl2QSzD2sjutbGT9QAXbBJzewoHZQtRgW9YDrD0puF6F+6dEoRhOvNDz8A2xJ1sC9+t+zIo0gQaDLsCJZ7iI6d8J8RdeBUiFHBjXA7cemeyt4/XxbLJlrEmmmlXk9O64jQbhx69JaD/eP5DSES5yA2b64mbmMRYbLdd83P1PZwcVPAh1PcyFtTBhDKagUtuSfEFgfKhlSBZ4JeFE0VCCuip4U8GKRp0VsmW43jbKiQJBexU2mrEgaxdx3jmGyVHdHC87AdqatfgdJR1YOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HA5z3Mh8DZD1o3ypG13EfIrFK75pKfsvj81iTyYA0uE=;
 b=JIZ/YbX11YKI7lnTVgJPwYPI5QfMs3WP+ZXCn8N/N6j6aRP3Q8P6jDTCH7/z2V/aP04tHlP8Uuao/03kOSZTXG+aaZBmxwidvq6TEerrDf3yJbORX+FHJHSjGW5Q+5lvVU1/I5RYE/togi+Gyv6Od6LiKJ4ciau9aydpIFAuSaA=
Received: from DB7PR04MB4986.eurprd04.prod.outlook.com (2603:10a6:10:13::25)
 by DB7PR04MB5353.eurprd04.prod.outlook.com (2603:10a6:10:84::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18; Tue, 21 Jul
 2020 04:28:30 +0000
Received: from DB7PR04MB4986.eurprd04.prod.outlook.com
 ([fe80::d133:55be:7303:108e]) by DB7PR04MB4986.eurprd04.prod.outlook.com
 ([fe80::d133:55be:7303:108e%6]) with mapi id 15.20.3195.026; Tue, 21 Jul 2020
 04:28:29 +0000
From:   Makarand Pawagi <makarand.pawagi@nxp.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>
CC:     Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Diana Madalina Craciun (OSS)" <diana.craciun@oss.nxp.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: RE: [EXT] Re: [PATCH v2 00/12] ACPI/OF: Upgrade MSI/IOMMU ID mapping
 APIs
Thread-Topic: [EXT] Re: [PATCH v2 00/12] ACPI/OF: Upgrade MSI/IOMMU ID mapping
 APIs
Thread-Index: AQHWXrZ8RLWPWILym0mae/lq5iihW6kRcNYw
Date:   Tue, 21 Jul 2020 04:28:29 +0000
Message-ID: <DB7PR04MB49868304D142BEC5044A6FCEEB780@DB7PR04MB4986.eurprd04.prod.outlook.com>
References: <20200521130008.8266-1-lorenzo.pieralisi@arm.com>
 <20200619082013.13661-1-lorenzo.pieralisi@arm.com>
 <20200720165442.GA19658@e121166-lin.cambridge.arm.com>
In-Reply-To: <20200720165442.GA19658@e121166-lin.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [122.169.237.208]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 123854ce-bdd9-4a7c-cac9-08d82d2e8539
x-ms-traffictypediagnostic: DB7PR04MB5353:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB53538029CD6C72063DF8F0A4EB780@DB7PR04MB5353.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mkULBl8xYEDomk0nozHEbT/9MOoma0nZuYy96M37RqBosKbDSW8rpkafwoOGzBYrUlveawsci/M9CScqpCQS/ekiYcFGlXRbBAfYZtJnWQvqd493ooabEZfGMSZLhrU9J+HoCjV7+9E2T8Vf7/34+yekd7GXMO8nAnxMd3nJhEp7bwmePvSebzee+OO3tr7c1ZZpuDoNGitRHKwQ/8nkWlJ+Obix5rLo0bpsQ1aiKzzFUmenJKo2Dom0+50S0Ry8jb7BIbX2Aaqhd3/wv/jz5h6U3NeR07Ony/FTBFNhgwS27jTAP1bfd2prkBkH5+0VZQe0gtt9/gFL22jBKmikD+t3nj9Z2LPMCkEsK1I05T1IZpUT9xqqAbeZdC7NciGY/v6qvQb5sm10r7SO6ZOiMw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4986.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(396003)(39860400002)(366004)(346002)(52536014)(83080400001)(2906002)(33656002)(5660300002)(86362001)(55016002)(8936002)(316002)(9686003)(7416002)(66946007)(478600001)(45080400002)(6506007)(66476007)(66556008)(64756008)(66446008)(7696005)(76116006)(966005)(53546011)(44832011)(186003)(26005)(8676002)(110136005)(54906003)(71200400001)(4326008)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: pKZvw4+u3w09yWUFv/SSjcRyMIUy0qcVnZ8sF7qrd0GmTBecc9Xsj5Trcvg846FiXx1mf4e6VWl01SvE8toCFzXK8GHpBpzdYUvxb0iT85ybJshcGB1LfjjUDO9EFEu8xB/2WkKzwu7vDByoI2buEZgavOermftozTfIEAENcrjMmkjP0eoBRi3+D9M9l7VMuaEYQ81TpXnMcvXwWgMfc3OwpUqc1YpUdC5TVFrpoNrEPbZlOpRKQ//63RrB5H6Mn8LujtQTvb5FGGIWc/8ioV4toplXZSM9s18iQgjVa1s7Nj53ZmL77d8gPtEM7rEMTvKvNfvdQbPqouQbqr5qfXNzQlz4YqVNGhV5T95UUSl56nPfgZH4fESeVPEROyTemrnk71+rlpeAWUSWBME59k3dyBPPHaMOB95lg3H2UzF4MOnUT9iyyODqTiweZI7EkpkL3EvVJqaJ3LRQl8dibUKpmNyJXI2+89N6sxO2Cl3QJnpgF8eQwSab1j6xlT18
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4986.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 123854ce-bdd9-4a7c-cac9-08d82d2e8539
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2020 04:28:29.5100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uz4ZcIjaZ+im9vI6/52cBnomZ5tPGZgLZwKivBRBu0Ttytb4dDfAwOresDdSkBoBSqI2YuvR2BItBMR5o0CLag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5353
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Sent: Monday, July 20, 2020 10:25 PM
> To: linux-arm-kernel@lists.infradead.org; Rob Herring <robh+dt@kernel.org=
>;
> Rafael J. Wysocki <rjw@rjwysocki.net>; Bjorn Helgaas <bhelgaas@google.com=
>;
> Catalin Marinas <catalin.marinas@arm.com>; Will Deacon <will@kernel.org>;
> joro@8bytes.org
> Cc: Hanjun Guo <guohanjun@huawei.com>; Sudeep Holla
> <sudeep.holla@arm.com>; Robin Murphy <robin.murphy@arm.com>; Marc
> Zyngier <maz@kernel.org>; iommu@lists.linux-foundation.org; linux-
> acpi@vger.kernel.org; devicetree@vger.kernel.org; linux-pci@vger.kernel.o=
rg;
> Makarand Pawagi <makarand.pawagi@nxp.com>; Diana Madalina Craciun (OSS)
> <diana.craciun@oss.nxp.com>; Laurentiu Tudor <laurentiu.tudor@nxp.com>
> Subject: [EXT] Re: [PATCH v2 00/12] ACPI/OF: Upgrade MSI/IOMMU ID mapping
> APIs
>=20
> Caution: EXT Email
>=20
> On Fri, Jun 19, 2020 at 09:20:01AM +0100, Lorenzo Pieralisi wrote:
> > This series is a v2 of a previous posting:
> >
> > v1 -> v2
> >
> > - Removed _rid() wrappers
> > - Fixed !CONFIG_ACPI compilation issue
> > - Converted of_pci_iommu_init() to use of_iommu_configure_dev_id()
> >
> > v1:
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flor=
e
> > .kernel.org%2Flinux-arm-kernel%2F20200521130008.8266-1-lorenzo.pierali
> >
> si%40arm.com%2F&amp;data=3D02%7C01%7Cmakarand.pawagi%40nxp.com%7C
> da7bade
> >
> c592846a1478808d82ccd9eb1%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%
> 7C1%7
> >
> C637308608924853281&amp;sdata=3DZoP3e2Q5Ijkz%2FtsGfgu9MYkmKXSHQExs5
> J64Sb
> > h51YA%3D&amp;reserved=3D0
> >
> > Original cover letter
> > ---------------------
> >
> > Firmware bindings provided in the ACPI IORT table[1] and device tree
> > bindings define rules to carry out input/output ID mappings - ie
> > retrieving an IOMMU/MSI controller input ID for a device with a given
> > ID.
> >
> > At the moment these firmware bindings are used exclusively for PCI
> > devices and their requester ID to IOMMU/MSI id mapping but there is
> > nothing PCI specific in the ACPI and devicetree bindings that prevent
> > the firmware and kernel from using the firmware bindings to traslate
> > device IDs for any bus that requires its devices to carry out
> > input/output id translations.
> >
> > The Freescale FSL bus is an example whereby the input/output ID
> > translation kernel code put in place for PCI can be reused for devices
> > attached to the bus that are not PCI devices.
> >
> > This series updates the kernel code to make the MSI/IOMMU input/output
> > ID translation PCI agnostic and apply the resulting changes to the
> > device ID space provided by the Freescale FSL bus.
> >
> > [1]
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Finfo=
c
> >
> enter.arm.com%2Fhelp%2Ftopic%2Fcom.arm.doc.den0049d%2FDEN0049D_IO_
> Rema
> >
> pping_Table.pdf&amp;data=3D02%7C01%7Cmakarand.pawagi%40nxp.com%7Cda
> 7bade
> >
> c592846a1478808d82ccd9eb1%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%
> 7C1%7
> >
> C637308608924853281&amp;sdata=3DRzpIo4AfAFsi2pdEuY%2FbnPAyase5cSmFIr5
> 2SX
> > aOrTg%3D&amp;reserved=3D0
> >
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: "Joerg Roedel <joro@8bytes.org>
> > Cc: Hanjun Guo <guohanjun@huawei.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Marc Zyngier <maz@kernel.org>
> >
> > Diana Craciun (2):
> >   of/irq: make of_msi_map_get_device_domain() bus agnostic
> >   bus/fsl-mc: Refactor the MSI domain creation in the DPRC driver
> >
> > Laurentiu Tudor (1):
> >   dt-bindings: arm: fsl: Add msi-map device-tree binding for fsl-mc
> > bus
> >
> > Lorenzo Pieralisi (8):
> >   ACPI/IORT: Make iort_match_node_callback walk the ACPI namespace for
> >     NC
> >   ACPI/IORT: Make iort_get_device_domain IRQ domain agnostic
> >   ACPI/IORT: Make iort_msi_map_rid() PCI agnostic
> >   ACPI/IORT: Remove useless PCI bus walk
> >   ACPI/IORT: Add an input ID to acpi_dma_configure()
> >   of/iommu: Make of_map_rid() PCI agnostic
> >   of/device: Add input id to of_dma_configure()
> >   of/irq: Make of_msi_map_rid() PCI bus agnostic
> >
> > Makarand Pawagi (1):
> >   bus: fsl-mc: Add ACPI support for fsl-mc
> >
> >  .../devicetree/bindings/misc/fsl,qoriq-mc.txt |  50 +++++++-
> >  drivers/acpi/arm64/iort.c                     | 108 ++++++++++++------
> >  drivers/acpi/scan.c                           |   8 +-
> >  drivers/bus/fsl-mc/dprc-driver.c              |  31 ++---
> >  drivers/bus/fsl-mc/fsl-mc-bus.c               |  79 +++++++++----
> >  drivers/bus/fsl-mc/fsl-mc-msi.c               |  36 ++++--
> >  drivers/bus/fsl-mc/fsl-mc-private.h           |   6 +-
> >  drivers/iommu/of_iommu.c                      |  81 +++++++------
> >  drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c   | 105 ++++++++++++++---
> >  drivers/of/base.c                             |  42 +++----
> >  drivers/of/device.c                           |   8 +-
> >  drivers/of/irq.c                              |  34 +++---
> >  drivers/pci/msi.c                             |   9 +-
> >  include/acpi/acpi_bus.h                       |   9 +-
> >  include/linux/acpi.h                          |   7 ++
> >  include/linux/acpi_iort.h                     |  20 ++--
> >  include/linux/of.h                            |   4 +-
> >  include/linux/of_device.h                     |  16 ++-
> >  include/linux/of_iommu.h                      |   6 +-
> >  include/linux/of_irq.h                        |  13 ++-
> >  20 files changed, 451 insertions(+), 221 deletions(-)
>=20
> Hi guys,
>=20
> I think this series is ready for upstream (there are two ACKs missing fro=
m Rafael
> on patch (5) and Bjorn on patch (3) - I asked for them), it touches lots =
of
> subsystems so I am not really sure what's the best way to pull it, more s=
o given
> that it is also late in the cycle (I do think it is best to merge it via =
a single tree, it
> does not make sense to split it up in my opinion).
>=20
> Please let me know.
>=20
Hi Lorenzo, I too find it suitable to merge it as a whole.
Hi Rafael, Bjorn, Can you finalize your review for patch-5 and patch-3?=20


> Thanks,
> Lorenzo
