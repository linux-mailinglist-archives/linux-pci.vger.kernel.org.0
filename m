Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A443345CA4
	for <lists+linux-pci@lfdr.de>; Tue, 23 Mar 2021 12:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbhCWLR6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Mar 2021 07:17:58 -0400
Received: from mail-mw2nam10on2040.outbound.protection.outlook.com ([40.107.94.40]:36094
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229452AbhCWLRv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Mar 2021 07:17:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MMVP/vecj5MjrXgLveHft1aKzCFrzR6l3MkpbcMzhd8kBEUtsV1OI3i4vbLsb45OnwshEZo1yeJ965VArnAfrxBDKjcGB4+xIMs2gdDk+mCUWzhZ58+6DOpnSSSh4wERHQes/aEp56P/Iy7SpGquAdeWV1ZO+W7QffRdXAvkGEaQU2oBvJG75CiufxzGNXKTSosMsl2wfK+nVMwAIWcrByznfDhIYsMthXqEVxrCDHgMiUvMmtu1iL8rZ1JHZkC9/DTZZiE/QucGLSlC6k8MkwFE6MTUo7OYXyO7F5uJMYzaQ+pRC7VHhGGT1qb6aKogIpOJRpjsLyOLd1IKDjyl3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wMJTYF8Xu/n7b9pN/SOOH39pkkFIdekPl3g9T+/myOk=;
 b=U2wZ1h3b+LbpqdlVIbnuQzpgdVH+CwgLfWDIDGTgrFidsA0gXaotNdmITHVOmfl9joHEjrzPBz5NO1OzTEzdPpeipdawoYI7YMBscslDSQU2vKoQZjZzHV+QrSfHsBKmcNTNtOoasugPrwYZBAsolFJ1xcVkdUQd3uwESOKg7QHU2S/nWYMG5Q60Z8BJ1BMiqDKIaeRvUSfwQPgm57d77I/qJlcoG3DXJl6cNt979+Rn/kUvDO/zndpqtQ5nuYqfpRq9emCy4lJRlulbQvvLWjnvEs20lQc3kKmg6owhijD+NlTH8+B1GrP8Tt4v+oeEgfj1H6zMhwaBSV0poOyvNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wMJTYF8Xu/n7b9pN/SOOH39pkkFIdekPl3g9T+/myOk=;
 b=a0wW16E3P+IsdNOCOcwqWT9il/5EYEtmOYBr7D4K4gGQ7x9gi1AIuVU/03C1aoBAI+MVIRtJ0dMHG9o9aNIQVhNJtrtccv1FamI6aWXJIwVd7ij+cQrsJDk1Gzfb47ATcFoJ7O8zJopLSdNKWnRzK8cuKOBbWLgVr0Z64YYiz4s=
Received: from BYAPR02MB5559.namprd02.prod.outlook.com (2603:10b6:a03:a1::18)
 by BY5PR02MB6961.namprd02.prod.outlook.com (2603:10b6:a03:23b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.25; Tue, 23 Mar
 2021 11:17:48 +0000
Received: from BYAPR02MB5559.namprd02.prod.outlook.com
 ([fe80::2418:b7d2:cbb:27f]) by BYAPR02MB5559.namprd02.prod.outlook.com
 ([fe80::2418:b7d2:cbb:27f%5]) with mapi id 15.20.3955.027; Tue, 23 Mar 2021
 11:17:48 +0000
From:   Bharat Kumar Gogada <bharatku@xilinx.com>
To:     Bharat Kumar Gogada <bharatku@xilinx.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
Subject: RE: [PATCH v3 1/2] PCI: xilinx-nwl: Enable coherent PCIe DMA traffic
 using CCI
Thread-Topic: [PATCH v3 1/2] PCI: xilinx-nwl: Enable coherent PCIe DMA traffic
 using CCI
Thread-Index: AQHXCPdf8/XRKTi3FEaC06+ar6fH8aqEsnBAgAzn4TA=
Date:   Tue, 23 Mar 2021 11:17:48 +0000
Message-ID: <BYAPR02MB55599675DC55C6F7568B6FA6A5649@BYAPR02MB5559.namprd02.prod.outlook.com>
References: <20210222084732.21521-1-bharat.kumar.gogada@xilinx.com>
 <BYAPR02MB55590903AD09A045B8A345BFA56C9@BYAPR02MB5559.namprd02.prod.outlook.com>
In-Reply-To: <BYAPR02MB55590903AD09A045B8A345BFA56C9@BYAPR02MB5559.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: xilinx.com; dkim=none (message not signed)
 header.d=none;xilinx.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9b3154ec-6477-4e21-bd4d-08d8eded4a75
x-ms-traffictypediagnostic: BY5PR02MB6961:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR02MB69615F3E6DCA0EB5068F09CBA5649@BY5PR02MB6961.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /4IhO2sbYe12ujZCp2IM19KbCiKl3L+emOPq0VXnqIk7DgqXB5h4a1XIznDOoGRk9HD42VjZjqpX4kctEquSm/u5+FL5P8ZzGju6tnN2IJZY7ZCUGXmqph1SRAOKGs3DaZLdLehWHdJIa/HKk2i5aSK9adkK3mRqfmTj81W2UDDpoSfiUlLNZqaeJ9jIOu65sA6BXmhoqQfSa7dpMWB67Q3sIeU7jW64xr/Zw3StwB01NtJ/o7mh/F88NohlqO60nAuVQLv9NhFYqRHTYtolKWsnYV8hwC2b18j+mlLENEa4dh6UVygc/r1S8o1bQ4gLQiU+eXfQ1+uHnkSnVO+HqpaxKfXhOa88t7/p7D71OrbK9qDwpG0bJPie7L2t+pHdwSh6s1+ts8TG6JesXNTzijD5GrG0mzpMs18E6WVLBzjdnB7LAo5ruQQ1LrzPTb1rGQJDz4unwtW4larDAlx3pVN50hecGHEOLgsolX4ZTIbxhynYwgR/OQ5YHCRjsng8gdC3CN23BPHhPux/xCjlD2nPvDDuu9dKQs/o8F87xQacoCYY4kx6kKfW2n9Gd1mifZnzCr98r2s4LfUHD5eYlSwEE/l4HXRwg3PTC2/pvN+kvvik6VE/Ijss801jdckodZ3+gOR43pI4eyP2duVKG2DcPfsuvbLVLkR7/30zgPBbBltLZzYRMrlaUDO5yMPtLG7XFY30vih0TfQG7N3UevB7bWDsMqLtEb0gUMY8NUOt7FU8tsBa0hgws9zgW8UO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB5559.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39850400004)(366004)(376002)(346002)(136003)(83380400001)(6506007)(7696005)(86362001)(33656002)(53546011)(66556008)(54906003)(71200400001)(316002)(4326008)(66446008)(478600001)(64756008)(66946007)(66476007)(966005)(110136005)(76116006)(8936002)(38100700001)(186003)(8676002)(2906002)(52536014)(55016002)(26005)(5660300002)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?cMyeALvsr7pREoTVTo7XqwFgAx+ywZtiL0+kq3mY+6HQVTyRvQTbAGTTSPBr?=
 =?us-ascii?Q?6cM03thEYObnM2gokG4FHARo/tVFWJhe8sjoIRRKmfFDicTOZlm/dK09x4sD?=
 =?us-ascii?Q?G+VSwsPPmCXIh/+Q2hzDRZq+ERYLyxPV/ZNqRkzpWy3otj4PA/gZqOos+9wF?=
 =?us-ascii?Q?RcEgr7xA8n1rsredWSHOEoJMGzHrn4RGd9Jsg4SmEy+6CmshEIjntuYPpATf?=
 =?us-ascii?Q?AHCuwH8aa9S7YiLPchZDxbZQ3m3cSzE+3vHr7+iuqpPseLtZ1g+hcDuf09FA?=
 =?us-ascii?Q?hpuNgprx9EmAtrQZ/yfwkgp3xJTNxBOJehHo8V5P5uZ9dGx2ue7VowB3Rj1Q?=
 =?us-ascii?Q?1JdiwmLxXLd6lCKT2ip4yMO0yes6NnRvHAhQiYogOgLhTl23t4LthlUJQGBX?=
 =?us-ascii?Q?aQ0dWEOks5DnJsGruFSVD4WWW5u+gPbHOwR4kkr96iaPoki6hwNLRX3GD3pd?=
 =?us-ascii?Q?Gq2UKuHr3hhYvi+Aw59VY1HZn0lSfPxrVjEUXeTSosSBiVWK0CDfeoc71tme?=
 =?us-ascii?Q?nqC1kTHmOQY6NEQlH22t9rVrC0R6z3Ii5O3jYhKc6NmOFZv7q8FvdBtUKagF?=
 =?us-ascii?Q?pX124KtogsUwLvyDsHvZVkvl6oxgLAeiNSyucFl7Eam7CuUKpclW6boRyIPI?=
 =?us-ascii?Q?hfMdk2Xc82Ev3Hcl6x0KV8GbjerXQ9YdwcDi7mWnX2K4p0so2RTLLdvx0oXI?=
 =?us-ascii?Q?u8cTuS27sfteHxK+yiBFDK+1VQlAqVWfwsyaBNHi0kbd/s4Iv9bmZdkhUI62?=
 =?us-ascii?Q?eNyMtOgVAa6Jyq6Z6Seh6n5UUQAOWc5SkRvZYA36GVxor267X4sybhXsdXJi?=
 =?us-ascii?Q?ZJ8W/wmojlz0RqP3a2YbXGI89GlZQVK3bZtQlnkgHY2UKsoH1IJo6JC/I7kx?=
 =?us-ascii?Q?advmqtPmC9MfrYS9eIgOPMhFe3iwVJGd2mupmdelfZuMnrsF0Am6P5q1QMZF?=
 =?us-ascii?Q?3pGV1fVFrkLXkHb8bw86+SYZDn66qdZQa0E8RRrH5DoOatZ5RwXguBQL/1Bq?=
 =?us-ascii?Q?1P7549P4LDvJQlEE4gaDEjYIfmY0uSJvCCbcHuONA01f3UI+alUyvBxKtOw9?=
 =?us-ascii?Q?a+SKXB3ymgSHb5vcKP/xV4Z67g73PTU0Lzaycx9R1JVYCHkOHccccK9CzEW/?=
 =?us-ascii?Q?OvK+L4YnfuPnFnFj8LJW6kjOhCcKHc96pYNvV1V+FST5Q6T+6gkN4B8UiOWU?=
 =?us-ascii?Q?47rkU1Hcnok2PXGyNLl4xHwtynj6v+8HKmuoBbqcQQRGaAiT7G5jxVh2jwNE?=
 =?us-ascii?Q?r1uU91gZaaMttBNlrRhIRA7Bf5t0hjr+UyGyha0HbfTcmnGv29Et1ARRxajF?=
 =?us-ascii?Q?0YjsOhfK0jEugkVUxvC6iw7N?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB5559.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b3154ec-6477-4e21-bd4d-08d8eded4a75
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2021 11:17:48.3158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KCWKl3X6fVt1iYWRBnzprBxDALmBFLPVhCZ1D3s4Sdr9LbdIDkrtlr729ULSrBYjCJgrHixlf4HAIjtunnYByQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6961
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Ping.

> -----Original Message-----
> From: Bharat Kumar Gogada
> Sent: Monday, March 15, 2021 11:43 AM
> To: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>; linux-
> pci@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: bhelgaas@google.com
> Subject: RE: [PATCH v3 1/2] PCI: xilinx-nwl: Enable coherent PCIe DMA tra=
ffic
> using CCI
>=20
> Ping.
>=20
> > -----Original Message-----
> > From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> > Sent: Monday, February 22, 2021 2:18 PM
> > To: linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org
> > Cc: bhelgaas@google.com; Bharat Kumar Gogada <bharatku@xilinx.com>
> > Subject: [PATCH v3 1/2] PCI: xilinx-nwl: Enable coherent PCIe DMA
> > traffic using CCI
> >
> > Add support for routing PCIe DMA traffic coherently when Cache
> > Coherent Interconnect (CCI) is enabled in the system.
> > The "dma-coherent" property is used to determine if CCI is enabled or n=
ot.
> > Refer to https://developer.arm.com/documentation/ddi0470/k/preface
> > for the CCI specification.
> >
> > Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> > ---
> >  drivers/pci/controller/pcie-xilinx-nwl.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c
> > b/drivers/pci/controller/pcie-xilinx-nwl.c
> > index 07e36661bbc2..8689311c5ef6 100644
> > --- a/drivers/pci/controller/pcie-xilinx-nwl.c
> > +++ b/drivers/pci/controller/pcie-xilinx-nwl.c
> > @@ -26,6 +26,7 @@
> >
> >  /* Bridge core config registers */
> >  #define BRCFG_PCIE_RX0			0x00000000
> > +#define BRCFG_PCIE_RX1			0x00000004
> >  #define BRCFG_INTERRUPT			0x00000010
> >  #define BRCFG_PCIE_RX_MSG_FILTER	0x00000020
> >
> > @@ -128,6 +129,7 @@
> >  #define NWL_ECAM_VALUE_DEFAULT		12
> >
> >  #define CFG_DMA_REG_BAR			GENMASK(2, 0)
> > +#define CFG_PCIE_CACHE			GENMASK(7, 0)
> >
> >  #define INT_PCI_MSI_NR			(2 * 32)
> >
> > @@ -675,6 +677,11 @@ static int nwl_pcie_bridge_init(struct nwl_pcie
> > *pcie)
> >  	nwl_bridge_writel(pcie, CFG_ENABLE_MSG_FILTER_MASK,
> >  			  BRCFG_PCIE_RX_MSG_FILTER);
> >
> > +	/* This routes the PCIe DMA traffic to go through CCI path */
> > +	if (of_dma_is_coherent(dev->of_node))
> > +		nwl_bridge_writel(pcie, nwl_bridge_readl(pcie,
> > BRCFG_PCIE_RX1) |
> > +				  CFG_PCIE_CACHE, BRCFG_PCIE_RX1);
> > +
> >  	err =3D nwl_wait_for_link(pcie);
> >  	if (err)
> >  		return err;
> > --
> > 2.17.1

