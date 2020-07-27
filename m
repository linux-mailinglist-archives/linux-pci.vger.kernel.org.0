Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 528A422E5B5
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jul 2020 08:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgG0GGr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Jul 2020 02:06:47 -0400
Received: from mail-eopbgr140047.outbound.protection.outlook.com ([40.107.14.47]:26819
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726006AbgG0GGr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Jul 2020 02:06:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nXd3gZsZKCGrA5CfMe9T3BSQeOVtPzH4Q7zsZuIsDP+bMOHNzg9MBIXPELO6tMa6FOybNFqxhECia85C4yEpESjp0IrIcETSG8lo6bYyAz2IhEd+scCHiN8Izqa1tKfImk6vtpweb7wd2yxwAwb6T8U5OdOozuBgWTf/U11Vj6/FDzwtrMcorWxHNyHOJhHOzuWejxo2QsiwxPjcHiFXR6hxH3N3B94wi5rzZQXPXA64hhr2BFXWMI1s67Jqiqx5kf6OHtBhKqYlC82xF6EIpK7eMhpB+ELxT0D9oVNmX/YYhhriFkjCvGs6UJ3em04xCpqF3fzMkeDMkQESEk32Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jNvW2qTuF4aE4LkQCQ2hJfXnIVgc8asWAPzIS9/P7zk=;
 b=LFHSD/xRJ2S92R/x7vlQ59loL246LFByw+/KspXgYg19v5P1+y3Bhb/XCpV7lc2wH9ZjdPn28UpZShTYx3z+4snXKQ1gDvEOfxifUNe/7yDRF7Mtm8vaj2dUE3V9BMqHyLvXS+PzSuMFBLRXfEEAUf5bfwEdvvaujO/IT0U+ILhFdDTHaf9Mu+k24WZsfcE9xZysOZYDXnAsvV8AU6EH57GT1Ivxspuob8X7oyhCP+Y56GI+iLdrwcpBH3CayTbzSa9YDKg0GilsL73jsR+/pvTnh6RRLZCBPoV1/OeCD0UOPbAiSoU73MNU/stcVJwfjYFh/VMvH0hJMqvPtoYQLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jNvW2qTuF4aE4LkQCQ2hJfXnIVgc8asWAPzIS9/P7zk=;
 b=cVauxZpUAT2LFk/Er4V1k280r2EMpv00CO4iR+CtOPpsNWuMawoY4TkMrHl8Ai+surtN53/RZrJjB5FujSbx7wQw+q3bq7o0rPla7wjd9sHGofLIfiOVlOwVHLpUceRU/O7Ywq4sFq8W94nlzMq+2m1mbWHKfne2HntVZ9WE4+k=
Received: from DB7PR04MB4986.eurprd04.prod.outlook.com (20.176.232.217) by
 DB8PR04MB5915.eurprd04.prod.outlook.com (20.179.8.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.27; Mon, 27 Jul 2020 06:06:42 +0000
Received: from DB7PR04MB4986.eurprd04.prod.outlook.com
 ([fe80::d133:55be:7303:108e]) by DB7PR04MB4986.eurprd04.prod.outlook.com
 ([fe80::d133:55be:7303:108e%6]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 06:06:42 +0000
From:   Makarand Pawagi <makarand.pawagi@nxp.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Marc Zyngier <maz@kernel.org>,
        "Diana Madalina Craciun (OSS)" <diana.craciun@oss.nxp.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: RE: [EXT] Re: [PATCH v2 03/12] ACPI/IORT: Make iort_msi_map_rid() PCI
 agnostic
Thread-Topic: [EXT] Re: [PATCH v2 03/12] ACPI/IORT: Make iort_msi_map_rid()
 PCI agnostic
Thread-Index: AQHWX298bSg8yHsFOE2/uTwYuRCOF6ka+P4w
Date:   Mon, 27 Jul 2020 06:06:42 +0000
Message-ID: <DB7PR04MB49860EBCE5D8917C94030A76EB720@DB7PR04MB4986.eurprd04.prod.outlook.com>
References: <20200619082013.13661-4-lorenzo.pieralisi@arm.com>
 <20200721145903.GA1117934@bjorn-Precision-5520>
In-Reply-To: <20200721145903.GA1117934@bjorn-Precision-5520>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [122.169.218.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 14fa8626-098c-4fc9-9e93-08d831f33be1
x-ms-traffictypediagnostic: DB8PR04MB5915:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB5915E998E339BF2482F76523EB720@DB8PR04MB5915.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a+junAj7+5ZMFMjakO18mQv4ofJfdSq3LPyXrg8SbrxbJ4VOZVjyt4UaMH8l+ou1Atf2CThVG2ELNLkrLi/N0A1iUI2Om9sfSIcIIOIkwHwkGYE03BJwy66SWkbPFZOLMOpKLaAi1i5uSWC3CAR0jqbFJy3ZJqA57RiJdDeKyuD7otCnyNF+ROJLGvJ56wXF35Aw3z+vbq/9ottmd3LS4PWr5LfdqDD5LsyCJg4DkAs6j9j9RbxNqO5kt6oxHe5Xth/o6S+y+DjtnUiZvL1DRuzagw4JHEPcO1zoeGBFwInS5R3WoLvqVi4wrNfPBVTAXlQFdusDW1+TK6Mnxlgg+w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4986.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(396003)(346002)(136003)(376002)(66476007)(7416002)(8936002)(66446008)(64756008)(66556008)(66946007)(26005)(9686003)(186003)(55016002)(76116006)(8676002)(52536014)(83380400001)(316002)(54906003)(6506007)(110136005)(53546011)(33656002)(71200400001)(44832011)(5660300002)(478600001)(7696005)(2906002)(86362001)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: K2I9U87w65oILDkjhzIH5X4VQ+OUnBjHo+4QFxlt64wwzQFs/4w27zPWdoaqF1DJzgZ6/7lpCy6tJfZUu4t1pqZQBVFmKBgMLzyy/Oct8cprJ+AGR6BctGTql5rNLTuOxiIFo/Zzv2D8mm9sF53IFHgEQjucJ5z2zJBVwPZeclFIF94PWgmT0bgm/WUiR2LQW9hJmbo72wwr26N9NaolDPxRKe6BRNcNgNmE/WNHV9zAXGpwY4TWKlQBmJcbkrZcVcQDjCg0q67h+uJN3UjcgBiyrVEdXC8rGHcdPei4p+ynTHNo2Is/yBXEdW65Qbo/feGsDoUqLrw2DDvM4ZcbYMK47gg87vSR2ddCtw73vQMzSvpTak/XchABgjmd0kJb+h7BF81lVanDmvAaNEaTtvsXAhc1nBkX+Da+/EcleTeGqRbIjzPT5LM7r8l2iDmC46EJapaUCyiCqOrd5ccVzf5zJ1lmyc/r2OgF2+nr+sgiCQiSvwl8dQM2RIDoA8zK
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4986.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14fa8626-098c-4fc9-9e93-08d831f33be1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2020 06:06:42.3051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V6rquBw+A2Jtwcq3oXcjw79bU2Y92lMTtO6m7Lm0ZALjlvLXiLcfjVllefi16LvpuVw98oumP/Iwt9pCFC7nEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5915
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Tuesday, July 21, 2020 8:29 PM
> To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org; Will Deacon <will@kernel.org>;
> Hanjun Guo <guohanjun@huawei.com>; Bjorn Helgaas
> <bhelgaas@google.com>; Sudeep Holla <sudeep.holla@arm.com>; Catalin
> Marinas <catalin.marinas@arm.com>; Robin Murphy <robin.murphy@arm.com>;
> Rafael J. Wysocki <rjw@rjwysocki.net>; iommu@lists.linux-foundation.org;
> linux-acpi@vger.kernel.org; devicetree@vger.kernel.org; linux-
> pci@vger.kernel.org; Rob Herring <robh+dt@kernel.org>; Joerg Roedel
> <joro@8bytes.org>; Marc Zyngier <maz@kernel.org>; Makarand Pawagi
> <makarand.pawagi@nxp.com>; Diana Madalina Craciun (OSS)
> <diana.craciun@oss.nxp.com>; Laurentiu Tudor <laurentiu.tudor@nxp.com>
> Subject: [EXT] Re: [PATCH v2 03/12] ACPI/IORT: Make iort_msi_map_rid() PC=
I
> agnostic
>=20
> Caution: EXT Email
>=20
> On Fri, Jun 19, 2020 at 09:20:04AM +0100, Lorenzo Pieralisi wrote:
> > There is nothing PCI specific in iort_msi_map_rid().
> >
> > Rename the function using a bus protocol agnostic name,
> > iort_msi_map_id(), and convert current callers to it.
> >
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Hanjun Guo <guohanjun@huawei.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>=20
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>=20
> Sorry I missed this!
[Makarand Pawagi]=20
Thanks Bjorn, Hi Rafael can you also finalize your review?
>=20
> > ---
> >  drivers/acpi/arm64/iort.c | 12 ++++++------
> >  drivers/pci/msi.c         |  2 +-
> >  include/linux/acpi_iort.h |  6 +++---
> >  3 files changed, 10 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> > index 902e2aaca946..53f9ef515089 100644
> > --- a/drivers/acpi/arm64/iort.c
> > +++ b/drivers/acpi/arm64/iort.c
> > @@ -568,22 +568,22 @@ static struct acpi_iort_node
> > *iort_find_dev_node(struct device *dev)  }
> >
> >  /**
> > - * iort_msi_map_rid() - Map a MSI requester ID for a device
> > + * iort_msi_map_id() - Map a MSI input ID for a device
> >   * @dev: The device for which the mapping is to be done.
> > - * @req_id: The device requester ID.
> > + * @input_id: The device input ID.
> >   *
> > - * Returns: mapped MSI RID on success, input requester ID otherwise
> > + * Returns: mapped MSI ID on success, input ID otherwise
> >   */
> > -u32 iort_msi_map_rid(struct device *dev, u32 req_id)
> > +u32 iort_msi_map_id(struct device *dev, u32 input_id)
> >  {
> >       struct acpi_iort_node *node;
> >       u32 dev_id;
> >
> >       node =3D iort_find_dev_node(dev);
> >       if (!node)
> > -             return req_id;
> > +             return input_id;
> >
> > -     iort_node_map_id(node, req_id, &dev_id, IORT_MSI_TYPE);
> > +     iort_node_map_id(node, input_id, &dev_id, IORT_MSI_TYPE);
> >       return dev_id;
> >  }
> >
> > diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c index
> > 74a91f52ecc0..77f48b95e277 100644
> > --- a/drivers/pci/msi.c
> > +++ b/drivers/pci/msi.c
> > @@ -1536,7 +1536,7 @@ u32 pci_msi_domain_get_msi_rid(struct irq_domain
> > *domain, struct pci_dev *pdev)
> >
> >       of_node =3D irq_domain_get_of_node(domain);
> >       rid =3D of_node ? of_msi_map_rid(&pdev->dev, of_node, rid) :
> > -                     iort_msi_map_rid(&pdev->dev, rid);
> > +                     iort_msi_map_id(&pdev->dev, rid);
> >
> >       return rid;
> >  }
> > diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
> > index 08ec6bd2297f..e51425e083da 100644
> > --- a/include/linux/acpi_iort.h
> > +++ b/include/linux/acpi_iort.h
> > @@ -28,7 +28,7 @@ void iort_deregister_domain_token(int trans_id);
> > struct fwnode_handle *iort_find_domain_token(int trans_id);  #ifdef
> > CONFIG_ACPI_IORT  void acpi_iort_init(void);
> > -u32 iort_msi_map_rid(struct device *dev, u32 req_id);
> > +u32 iort_msi_map_id(struct device *dev, u32 id);
> >  struct irq_domain *iort_get_device_domain(struct device *dev, u32 id,
> >                                         enum irq_domain_bus_token
> > bus_token);  void acpi_configure_pmsi_domain(struct device *dev); @@
> > -39,8 +39,8 @@ const struct iommu_ops *iort_iommu_configure(struct
> > device *dev);  int iort_iommu_msi_get_resv_regions(struct device *dev,
> > struct list_head *head);  #else  static inline void
> > acpi_iort_init(void) { } -static inline u32 iort_msi_map_rid(struct
> > device *dev, u32 req_id) -{ return req_id; }
> > +static inline u32 iort_msi_map_id(struct device *dev, u32 id) {
> > +return id; }
> >  static inline struct irq_domain *iort_get_device_domain(
> >       struct device *dev, u32 id, enum irq_domain_bus_token bus_token)
> > { return NULL; }
> > --
> > 2.26.1
> >
