Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7C50E9E47
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2019 16:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbfJ3PDb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Oct 2019 11:03:31 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:54314 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726175AbfJ3PDa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Oct 2019 11:03:30 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9UExuw2008184;
        Wed, 30 Oct 2019 08:03:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=xlUY6u8m9IVC+24/1OLXSFqEddPc97Ei5PxineSHvw0=;
 b=hS0urdtmZRCO1/Pmjt4+QYKckNghKNkEW9ydPpQtSddTKw6OBDCqx+Vgys1GaiF7jZoH
 2fFhvFkDQObbZQvRcb0DGEZ1YJ4mjyrDu2iBSrnXfZN55sfgL88zBjJjxU6Q7jQKkeb0
 tW2j2pulhgtTKMg5yzL3xqkq1YXIIG+ksW9AyJAzTO+qeaiLBQcV7wQd85uGG/nBR5f7
 ia2nh7CESPtez/nZ64M7iKgv4BEp8AG/fyMyaX0lsRjM3pl177GcnaaTOfwNtpGpbZox
 IvPQg7Ol1355CxQesSGW9pq1DrshPlENCcNriLcyScjiMc281No4kN+zmyNIFipdaY4N wQ== 
Received: from nam05-co1-obe.outbound.protection.outlook.com (mail-co1nam05lp2058.outbound.protection.outlook.com [104.47.48.58])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2vxwgeu3ce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 30 Oct 2019 08:03:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FA68R3tRrIUc704a3+IfsBm2V269OT8dSxusd1wuBXNe9B1PBwVQCzKlyO6wI4vrhM848abd/lNr06l6fthu33Fhs7e5KZ99Lbt2hhtfaeY1Bum8C5SZ2cIbuK1WASPtW2tcTwVEk9M8c7tG5aPsCrL+8MCNOs0SKusHBobjIrDB9aV0oMHz/pEbak2ZWDoQrF0ItnbHQEajD3KG+p3RkwXfGXoN2+MExy1IF+hE3zxrE0Z1ozjLTR50zCjt0wjPrhXbGrd4WZ2qAFPi6PWp0GuwvCvFbPJ5LoG4o0o0dAK7e2HLvTMDAZrEm4OMadhyXocbOA6NAflTOTmHAd3U5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xlUY6u8m9IVC+24/1OLXSFqEddPc97Ei5PxineSHvw0=;
 b=PjPn9Vm88o5lh7CCqvNS1Wn2E8QZiYZ/UOVxouK2d0x6904vNyprsyydQR/rb24FxZR9yibU5eInFFs7JS4cFiQuXyTKKE1pTtA5C+Hd2TmIBZS+xB1oiwIn70sC8DHvPIOG0e7vmp6heRxaF01eAJWzFJrSRuTdUW8sPUC34FQCUsfYV7qvB4ZgTjDHOyTVaHMWO/ehN//zYF1QhFrUa9OFESj3G8i+uk2tbCLsgzDaw/CQcmuCce0+4fRMNiTU1aTK2VMUEqhbz1AAcHSr+ALyXj33zhTQ+CwLoaJxhWWKIoYOTLlVLfe5DRiYiEWao4p7scpIDGosrGIUN/TJjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xlUY6u8m9IVC+24/1OLXSFqEddPc97Ei5PxineSHvw0=;
 b=o8okSP7SuOrZzst63oae8MWMRQvKyqMJBKvTfZRpdVG/yteh97a+o1/qYQohErwpFqs9jgwTsgclTLXI3qornvY16EVGb28oDlU75EXAsY+rl3EvAB2UMrIyuvJraSowVJm5qYjw9nc+pn0n6aZ85zDZp0hxuoo2VfjM1M7PBgM=
Received: from MWHPR07MB3853.namprd07.prod.outlook.com (10.172.101.140) by
 MWHPR07MB3869.namprd07.prod.outlook.com (10.172.97.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.23; Wed, 30 Oct 2019 15:03:19 +0000
Received: from MWHPR07MB3853.namprd07.prod.outlook.com
 ([fe80::684c:973d:d098:5c83]) by MWHPR07MB3853.namprd07.prod.outlook.com
 ([fe80::684c:973d:d098:5c83%2]) with mapi id 15.20.2387.028; Wed, 30 Oct 2019
 15:03:19 +0000
From:   Tom Joseph <tjoseph@cadence.com>
To:     Andrew Murray <andrew.murray@arm.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] PCI: cadence: Refactor driver to use as a core library
Thread-Topic: [PATCH v2] PCI: cadence: Refactor driver to use as a core
 library
Thread-Index: AQHVhFUjWC1bdR1eHEmUjgxS5fSODKdrbKwAgAe8XqA=
Date:   Wed, 30 Oct 2019 15:03:19 +0000
Message-ID: <MWHPR07MB385315AA79FE4E1EE8531BCBA1600@MWHPR07MB3853.namprd07.prod.outlook.com>
References: <1571252912-7354-1-git-send-email-tjoseph@cadence.com>
 <20191025134658.GZ47056@e119886-lin.cambridge.arm.com>
In-Reply-To: <20191025134658.GZ47056@e119886-lin.cambridge.arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcdGpvc2VwaFxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJhMjllMzViXG1zZ3NcbXNnLTY2ZWFkYzFjLWZiMjYtMTFlOS04OTE3LTU4OTFjZjc3ZDUzMFxhbWUtdGVzdFw2NmVhZGMxZC1mYjI2LTExZTktODkxNy01ODkxY2Y3N2Q1MzBib2R5LnR4dCIgc3o9IjI2NzQwIiB0PSIxMzIxNjkyMTM5NzYxMzc0MjQiIGg9IlFDUDF3RldWVTJlYktMWU1Pdm5ZcFJ5dXROZz0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
x-originating-ip: [94.175.212.46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c6daf8a5-e9e3-4d0b-ea25-08d75d4a4d0e
x-ms-traffictypediagnostic: MWHPR07MB3869:
x-microsoft-antispam-prvs: <MWHPR07MB3869F32DFABA691F3606D407A1600@MWHPR07MB3869.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02065A9E77
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(136003)(346002)(39860400002)(366004)(54534003)(199004)(189003)(13464003)(51914003)(36092001)(55016002)(71190400001)(9686003)(229853002)(446003)(76176011)(486006)(3846002)(6246003)(6436002)(2906002)(26005)(55236004)(102836004)(8936002)(6506007)(53546011)(6116002)(186003)(99286004)(14454004)(7696005)(256004)(25786009)(14444005)(5660300002)(6916009)(71200400001)(76116006)(66446008)(66556008)(66946007)(66476007)(30864003)(64756008)(11346002)(316002)(52536014)(4326008)(54906003)(8676002)(33656002)(81166006)(81156014)(478600001)(7736002)(66066001)(74316002)(476003)(305945005)(86362001)(579004)(559001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB3869;H:MWHPR07MB3853.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:3;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7Yw5b8tZ5eeJ/jiWQ1qELwcOi7LWj/v/5cQQZlnCo38bHPfIcavKIPgiOVmU/xkwRYfv7f8jLjmOmdJb5+7B3vBIu8NxEEcSBbpjEEUKRR4+0oLREaSw7oddKkaehGW70DmtCW4kGfLZQDlysyFag3e8/ZREG9SZXjBjSjLUHIwRlm3iGf0u7ehnpL6vRpRFZPyMGNcSN8jiLeuiUFNaGMbwAt08lQnPWTmd8W/2FsbOMiRBRkEDm9zlRrqgf5SHni2FcT8wkzJ+Tm5kyz4Tg3F5w/eGrxuH8sXXSkCTkptzGKvn0GD/AkUTPUVkfU+pkigTNfKyp2pYSdCWLodFJXXHXhpoqNiXFeFPeH9i/yYT3feQDHCCv0seziH2UkG4Ft3JV7T5ZQnurtnsBQCKhtcLYEN6qxos7s/bQhDyXTFVIFn2j75Pd52yrctwiUYnCImSdpjVKjP0ioPb+kZzWg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6daf8a5-e9e3-4d0b-ea25-08d75d4a4d0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2019 15:03:19.6451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 03GP4fIZ69pkKpDHWOjrCab0dCuVwUZ+NF0LQ/MkUFoACkOhgIYuQVA3mazcO93NbSNL9Ysxjilq7mv8n+r/KYS5LRoUZmLscIgKzAA/4xg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3869
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-30_07:2019-10-30,2019-10-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 priorityscore=1501 spamscore=0 mlxlogscore=999 clxscore=1011 bulkscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 adultscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910300141
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Andrew,

 I noticed that I missed to respond to your question here.

> -----Original Message-----
> From: Andrew Murray <andrew.murray@arm.com>
> Sent: 25 October 2019 14:47
> To: Tom Joseph <tjoseph@cadence.com>
> Cc: linux-pci@vger.kernel.org; Lorenzo Pieralisi <lorenzo.pieralisi@arm.c=
om>;
> Bjorn Helgaas <bhelgaas@google.com>; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v2] PCI: cadence: Refactor driver to use as a core li=
brary
>=20
>=20
> Hi Tom,
>=20
> On Wed, Oct 16, 2019 at 08:08:32PM +0100, Tom Joseph wrote:
> > All the platform related APIs/Structures in the driver is extracted
> >  out to a separate file (pcie-cadence-plat.c). This enables the
> >  driver to be used as a core library, which could now be used by
> >  other platform drivers. Testing done using simulation environment.
>=20
> There should be no spaces before the start of each line of text above.
>=20
> Perhaps reword to something along the lines of:
>=20
> "The Cadence PCI IP may be embedded into a variety of host and EP
>  controllers....  Let's extract the .... such that this common
>  functionality can be be used by future ..."
>=20
> I.e. there is some context, there is a 'lets make a change' and there
> is a why.
>=20
Thanks. I have updated the change log ( on v3) as suggested.
>=20
> >
> > Signed-off-by: Tom Joseph <tjoseph@cadence.com>
> > ---
> >  drivers/pci/controller/Kconfig             |  28 +++++
> >  drivers/pci/controller/Makefile            |   1 +
> >  drivers/pci/controller/pcie-cadence-ep.c   |  96 +---------------
> >  drivers/pci/controller/pcie-cadence-host.c |  96 ++--------------
> >  drivers/pci/controller/pcie-cadence-plat.c | 174
> +++++++++++++++++++++++++++++
> >  drivers/pci/controller/pcie-cadence.h      |  82 ++++++++++++++
> >  6 files changed, 297 insertions(+), 180 deletions(-)
> >  create mode 100644 drivers/pci/controller/pcie-cadence-plat.c
> >
> > diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kc=
onfig
> > index fe9f9f1..cafbed0 100644
> > --- a/drivers/pci/controller/Kconfig
> > +++ b/drivers/pci/controller/Kconfig
> > @@ -48,6 +48,34 @@ config PCIE_CADENCE_EP
> >  	  endpoint mode. This PCIe controller may be embedded into many
> >  	  different vendors SoCs.
> >
> > +config PCIE_CADENCE_PLAT
> > +	bool
> > +
> > +config PCIE_CADENCE_PLAT_HOST
> > +	bool "Cadence PCIe platform host controller"
> > +	depends on OF
> > +	depends on PCI
> > +	select IRQ_DOMAIN
> > +	select PCIE_CADENCE
> > +	select PCIE_CADENCE_HOST
> > +	select PCIE_CADENCE_PLAT
> > +	help
> > +	  Say Y here if you want to support the Cadence PCIe platform
> controller in
> > +	  host mode. This PCIe controller may be embedded into many
> different
> > +	  vendors SoCs.
> > +
> > +config PCIE_CADENCE_PLAT_EP
> > +	bool "Cadence PCIe platform endpoint controller"
> > +	depends on OF
> > +	depends on PCI_ENDPOINT
> > +	select PCIE_CADENCE
> > +	select PCIE_CADENCE_EP
> > +	select PCIE_CADENCE_PLAT
> > +	help
> > +	  Say Y here if you want to support the Cadence PCIe  platform
> controller in
> > +	  endpoint mode. This PCIe controller may be embedded into many
> > +	  different vendors SoCs.
> > +
> >  endmenu
> >
> >  config PCIE_XILINX_NWL
> > diff --git a/drivers/pci/controller/Makefile
> b/drivers/pci/controller/Makefile
> > index d56a507..676a41e 100644
> > --- a/drivers/pci/controller/Makefile
> > +++ b/drivers/pci/controller/Makefile
> > @@ -2,6 +2,7 @@
> >  obj-$(CONFIG_PCIE_CADENCE) +=3D pcie-cadence.o
> >  obj-$(CONFIG_PCIE_CADENCE_HOST) +=3D pcie-cadence-host.o
> >  obj-$(CONFIG_PCIE_CADENCE_EP) +=3D pcie-cadence-ep.o
> > +obj-$(CONFIG_PCIE_CADENCE_PLAT) +=3D pcie-cadence-plat.o
> >  obj-$(CONFIG_PCI_FTPCI100) +=3D pci-ftpci100.o
>=20
> I think in addition to the above hunks you also need the following:
>=20
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -28,25 +28,16 @@ config PCIE_CADENCE
>         bool
>=20
>  config PCIE_CADENCE_HOST
> -       bool "Cadence PCIe host controller"
> +       bool
>         depends on OF
> -       depends on PCI
>         select IRQ_DOMAIN
>         select PCIE_CADENCE
> -       help
> -         Say Y here if you want to support the Cadence PCIe controller i=
n host
> -         mode. This PCIe controller may be embedded into many different
> vendors
> -         SoCs.
>=20
>  config PCIE_CADENCE_EP
> -       bool "Cadence PCIe endpoint controller"
> +       bool
>         depends on OF
>         depends on PCI_ENDPOINT
>         select PCIE_CADENCE
> -       help
> -         Say Y here if you want to support the Cadence PCIe  controller =
in
> -         endpoint mode. This PCIe controller may be embedded into many
> -         different vendors SoCs.
>=20
>  config PCIE_CADENCE_PLAT
>         bool
>=20
> I removed the 'depends on PCI' as you get that for free seeing as the
> "PCI controller drivers" menu depends on PCI.
>=20
> Removing the help and text prevents anything from being shown in the
> Kconfig
> system - I think you need that here to avoid confusing the user (and to m=
ake
> this just like DWC).
>=20
> I'm happy with the above. Though just like DWC, I find this confusing. Th=
is
> allows future Cadence based controller drivers to include support for the=
 EP
> or host library by 'selecting PCIE_CADENCE_(HOST,EP)' resulting in those
> libraries being compiled in. But despite this the user can still unselect
> PCIE_CADENCE_PLAT_HOST which simply prevents that HOST,EP library
> functions
> from being called - i.e. to override and disable that functionality.

Thanks for the spotting this and for the explanation . I have corrected the=
se in v3.
>=20
> There is no reason that this needs to look like the DWC Kconfig, if there=
 is
> a better way that can provide additional benefits then please feel free t=
o
> change it.
>=20
> >  obj-$(CONFIG_PCI_HYPERV) +=3D pci-hyperv.o
> >  obj-$(CONFIG_PCI_MVEBU) +=3D pci-mvebu.o
> > diff --git a/drivers/pci/controller/pcie-cadence-ep.c
> b/drivers/pci/controller/pcie-cadence-ep.c
> > index def7820..1c173da 100644
> > --- a/drivers/pci/controller/pcie-cadence-ep.c
> > +++ b/drivers/pci/controller/pcie-cadence-ep.c
> > @@ -17,35 +17,6 @@
> >  #define CDNS_PCIE_EP_IRQ_PCI_ADDR_NONE		0x1
> >  #define CDNS_PCIE_EP_IRQ_PCI_ADDR_LEGACY	0x3
> >
> > -/**
> > - * struct cdns_pcie_ep - private data for this PCIe endpoint controlle=
r
> driver
> > - * @pcie: Cadence PCIe controller
> > - * @max_regions: maximum number of regions supported by hardware
> > - * @ob_region_map: bitmask of mapped outbound regions
> > - * @ob_addr: base addresses in the AXI bus where the outbound regions
> start
> > - * @irq_phys_addr: base address on the AXI bus where the MSI/legacy
> IRQ
> > - *		   dedicated outbound regions is mapped.
> > - * @irq_cpu_addr: base address in the CPU space where a write access
> triggers
> > - *		  the sending of a memory write (MSI) / normal message
> (legacy
> > - *		  IRQ) TLP through the PCIe bus.
> > - * @irq_pci_addr: used to save the current mapping of the MSI/legacy I=
RQ
> > - *		  dedicated outbound region.
> > - * @irq_pci_fn: the latest PCI function that has updated the mapping o=
f
> > - *		the MSI/legacy IRQ dedicated outbound region.
> > - * @irq_pending: bitmask of asserted legacy IRQs.
> > - */
> > -struct cdns_pcie_ep {
> > -	struct cdns_pcie		pcie;
> > -	u32				max_regions;
> > -	unsigned long			ob_region_map;
> > -	phys_addr_t			*ob_addr;
> > -	phys_addr_t			irq_phys_addr;
> > -	void __iomem			*irq_cpu_addr;
> > -	u64				irq_pci_addr;
> > -	u8				irq_pci_fn;
> > -	u8				irq_pending;
> > -};
> > -
> >  static int cdns_pcie_ep_write_header(struct pci_epc *epc, u8 fn,
> >  				     struct pci_epf_header *hdr)
> >  {
> > @@ -424,28 +395,17 @@ static const struct pci_epc_ops
> cdns_pcie_epc_ops =3D {
> >  	.get_features	=3D cdns_pcie_ep_get_features,
> >  };
> >
> > -static const struct of_device_id cdns_pcie_ep_of_match[] =3D {
> > -	{ .compatible =3D "cdns,cdns-pcie-ep" },
> > -
> > -	{ },
> > -};
> >
> > -static int cdns_pcie_ep_probe(struct platform_device *pdev)
> > +int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
> >  {
> > -	struct device *dev =3D &pdev->dev;
> > +	struct device *dev =3D ep->pcie.dev;
> > +	struct platform_device *pdev =3D to_platform_device(dev);
> >  	struct device_node *np =3D dev->of_node;
> > -	struct cdns_pcie_ep *ep;
> > -	struct cdns_pcie *pcie;
> > -	struct pci_epc *epc;
> > +	struct cdns_pcie *pcie =3D &ep->pcie;
> >  	struct resource *res;
> > +	struct pci_epc *epc;
> >  	int ret;
> > -	int phy_count;
> > -
> > -	ep =3D devm_kzalloc(dev, sizeof(*ep), GFP_KERNEL);
> > -	if (!ep)
> > -		return -ENOMEM;
> >
> > -	pcie =3D &ep->pcie;
> >  	pcie->is_rc =3D false;
> >
> >  	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM,
> "reg");
> > @@ -474,19 +434,6 @@ static int cdns_pcie_ep_probe(struct
> platform_device *pdev)
> >  	if (!ep->ob_addr)
> >  		return -ENOMEM;
> >
> > -	ret =3D cdns_pcie_init_phy(dev, pcie);
> > -	if (ret) {
> > -		dev_err(dev, "failed to init phy\n");
> > -		return ret;
> > -	}
> > -	platform_set_drvdata(pdev, pcie);
> > -	pm_runtime_enable(dev);
> > -	ret =3D pm_runtime_get_sync(dev);
> > -	if (ret < 0) {
> > -		dev_err(dev, "pm_runtime_get_sync() failed\n");
> > -		goto err_get_sync;
> > -	}
> > -
> >  	/* Disable all but function 0 (anyway BIT(0) is hardwired to 1). */
> >  	cdns_pcie_writel(pcie, CDNS_PCIE_LM_EP_FUNC_CFG, BIT(0));
> >
> > @@ -528,38 +475,5 @@ static int cdns_pcie_ep_probe(struct
> platform_device *pdev)
> >   err_init:
> >  	pm_runtime_put_sync(dev);
> >
> > - err_get_sync:
> > -	pm_runtime_disable(dev);
> > -	cdns_pcie_disable_phy(pcie);
> > -	phy_count =3D pcie->phy_count;
> > -	while (phy_count--)
> > -		device_link_del(pcie->link[phy_count]);
> > -
> >  	return ret;
> >  }
> > -
> > -static void cdns_pcie_ep_shutdown(struct platform_device *pdev)
> > -{
> > -	struct device *dev =3D &pdev->dev;
> > -	struct cdns_pcie *pcie =3D dev_get_drvdata(dev);
> > -	int ret;
> > -
> > -	ret =3D pm_runtime_put_sync(dev);
> > -	if (ret < 0)
> > -		dev_dbg(dev, "pm_runtime_put_sync failed\n");
> > -
> > -	pm_runtime_disable(dev);
> > -
> > -	cdns_pcie_disable_phy(pcie);
> > -}
> > -
> > -static struct platform_driver cdns_pcie_ep_driver =3D {
> > -	.driver =3D {
> > -		.name =3D "cdns-pcie-ep",
> > -		.of_match_table =3D cdns_pcie_ep_of_match,
> > -		.pm	=3D &cdns_pcie_pm_ops,
> > -	},
> > -	.probe =3D cdns_pcie_ep_probe,
> > -	.shutdown =3D cdns_pcie_ep_shutdown,
> > -};
> > -builtin_platform_driver(cdns_pcie_ep_driver);
> > diff --git a/drivers/pci/controller/pcie-cadence-host.c
> b/drivers/pci/controller/pcie-cadence-host.c
> > index 97e2510..5081908 100644
> > --- a/drivers/pci/controller/pcie-cadence-host.c
> > +++ b/drivers/pci/controller/pcie-cadence-host.c
> > @@ -11,33 +11,6 @@
> >
> >  #include "pcie-cadence.h"
> >
> > -/**
> > - * struct cdns_pcie_rc - private data for this PCIe Root Complex drive=
r
> > - * @pcie: Cadence PCIe controller
> > - * @dev: pointer to PCIe device
> > - * @cfg_res: start/end offsets in the physical system memory to map PC=
I
> > - *           configuration space accesses
> > - * @bus_range: first/last buses behind the PCIe host controller
> > - * @cfg_base: IO mapped window to access the PCI configuration space o=
f
> a
> > - *            single function at a time
> > - * @max_regions: maximum number of regions supported by the
> hardware
> > - * @no_bar_nbits: Number of bits to keep for inbound (PCIe -> CPU)
> address
> > - *                translation (nbits sets into the "no BAR match" regi=
ster)
> > - * @vendor_id: PCI vendor ID
> > - * @device_id: PCI device ID
> > - */
> > -struct cdns_pcie_rc {
> > -	struct cdns_pcie	pcie;
> > -	struct device		*dev;
> > -	struct resource		*cfg_res;
> > -	struct resource		*bus_range;
> > -	void __iomem		*cfg_base;
> > -	u32			max_regions;
> > -	u32			no_bar_nbits;
> > -	u16			vendor_id;
> > -	u16			device_id;
> > -};
> > -
> >  static void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsigned
> int devfn,
> >  				      int where)
> >  {
> > @@ -92,11 +65,6 @@ static struct pci_ops cdns_pcie_host_ops =3D {
> >  	.write		=3D pci_generic_config_write,
> >  };
> >
> > -static const struct of_device_id cdns_pcie_host_of_match[] =3D {
> > -	{ .compatible =3D "cdns,cdns-pcie-host" },
> > -
> > -	{ },
> > -};
> >
> >  static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
> >  {
> > @@ -136,10 +104,10 @@ static int cdns_pcie_host_init_root_port(struct
> cdns_pcie_rc *rc)
> >  static int cdns_pcie_host_init_address_translation(struct cdns_pcie_rc=
 *rc)
> >  {
> >  	struct cdns_pcie *pcie =3D &rc->pcie;
> > -	struct resource *cfg_res =3D rc->cfg_res;
> >  	struct resource *mem_res =3D pcie->mem_res;
> >  	struct resource *bus_range =3D rc->bus_range;
> > -	struct device *dev =3D rc->dev;
> > +	struct resource *cfg_res =3D rc->cfg_res;
> > +	struct device *dev =3D pcie->dev;
> >  	struct device_node *np =3D dev->of_node;
> >  	struct of_pci_range_parser parser;
> >  	struct of_pci_range range;
> > @@ -233,27 +201,22 @@ static int cdns_pcie_host_init(struct device *dev=
,
> >  	return err;
> >  }
> >
> > -static int cdns_pcie_host_probe(struct platform_device *pdev)
> > +int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
> >  {
> > -	struct device *dev =3D &pdev->dev;
> > +	struct device *dev =3D rc->pcie.dev;
> > +	struct platform_device *pdev =3D to_platform_device(dev);
> >  	struct device_node *np =3D dev->of_node;
> >  	struct pci_host_bridge *bridge;
> >  	struct list_head resources;
> > -	struct cdns_pcie_rc *rc;
> >  	struct cdns_pcie *pcie;
> >  	struct resource *res;
> >  	int ret;
> > -	int phy_count;
> >
> > -	bridge =3D devm_pci_alloc_host_bridge(dev, sizeof(*rc));
> > +	bridge =3D pci_host_bridge_from_priv(rc);
> >  	if (!bridge)
> >  		return -ENOMEM;
> >
> > -	rc =3D pci_host_bridge_priv(bridge);
> > -	rc->dev =3D dev;
> > -
> >  	pcie =3D &rc->pcie;
> > -	pcie->is_rc =3D true;
> >
> >  	rc->max_regions =3D 32;
> >  	of_property_read_u32(np, "cdns,max-outbound-regions", &rc-
> >max_regions);
> > @@ -287,21 +250,8 @@ static int cdns_pcie_host_probe(struct
> platform_device *pdev)
> >  		dev_err(dev, "missing \"mem\"\n");
> >  		return -EINVAL;
> >  	}
> > -	pcie->mem_res =3D res;
> >
> > -	ret =3D cdns_pcie_init_phy(dev, pcie);
> > -	if (ret) {
> > -		dev_err(dev, "failed to init phy\n");
> > -		return ret;
> > -	}
> > -	platform_set_drvdata(pdev, pcie);
> > -
> > -	pm_runtime_enable(dev);
> > -	ret =3D pm_runtime_get_sync(dev);
> > -	if (ret < 0) {
> > -		dev_err(dev, "pm_runtime_get_sync() failed\n");
> > -		goto err_get_sync;
> > -	}
> > +	pcie->mem_res =3D res;
> >
> >  	ret =3D cdns_pcie_host_init(dev, &resources, rc);
> >  	if (ret)
> > @@ -326,37 +276,5 @@ static int cdns_pcie_host_probe(struct
> platform_device *pdev)
> >   err_init:
> >  	pm_runtime_put_sync(dev);
> >
> > - err_get_sync:
> > -	pm_runtime_disable(dev);
> > -	cdns_pcie_disable_phy(pcie);
> > -	phy_count =3D pcie->phy_count;
> > -	while (phy_count--)
> > -		device_link_del(pcie->link[phy_count]);
> > -
> >  	return ret;
> >  }
> > -
> > -static void cdns_pcie_shutdown(struct platform_device *pdev)
> > -{
> > -	struct device *dev =3D &pdev->dev;
> > -	struct cdns_pcie *pcie =3D dev_get_drvdata(dev);
> > -	int ret;
> > -
> > -	ret =3D pm_runtime_put_sync(dev);
> > -	if (ret < 0)
> > -		dev_dbg(dev, "pm_runtime_put_sync failed\n");
> > -
> > -	pm_runtime_disable(dev);
> > -	cdns_pcie_disable_phy(pcie);
> > -}
> > -
> > -static struct platform_driver cdns_pcie_host_driver =3D {
> > -	.driver =3D {
> > -		.name =3D "cdns-pcie-host",
> > -		.of_match_table =3D cdns_pcie_host_of_match,
> > -		.pm	=3D &cdns_pcie_pm_ops,
> > -	},
> > -	.probe =3D cdns_pcie_host_probe,
> > -	.shutdown =3D cdns_pcie_shutdown,
> > -};
> > -builtin_platform_driver(cdns_pcie_host_driver);
> > diff --git a/drivers/pci/controller/pcie-cadence-plat.c
> b/drivers/pci/controller/pcie-cadence-plat.c
> > new file mode 100644
> > index 0000000..f5c6bf6
> > --- /dev/null
> > +++ b/drivers/pci/controller/pcie-cadence-plat.c
> > @@ -0,0 +1,174 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Cadence PCIe platform  driver.
> > + *
> > + * Copyright (c) 2019, Cadence Design Systems
> > + * Author: Tom Joseph <tjoseph@cadence.com>
> > + */
> > +#include <linux/kernel.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_pci.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/of_device.h>
> > +#include "pcie-cadence.h"
> > +
> > +/**
> > + * struct cdns_plat_pcie - private data for this PCIe platform driver
> > + * @pcie: Cadence PCIe controller
> > + * @is_rc: Set to 1 indicates the PCIe controller mode is Root Complex=
,
> > + *         if 0 it is in Endpoint mode.
> > + */
> > +struct cdns_plat_pcie {
> > +	struct cdns_pcie        *pcie;
> > +	bool is_rc;
> > +};
> > +
> > +struct cdns_plat_pcie_of_data {
> > +	bool is_rc;
> > +};
> > +
> > +static const struct of_device_id cdns_plat_pcie_of_match[];
> > +
> > +static int cdns_plat_pcie_probe(struct platform_device *pdev)
> > +{
> > +	const struct cdns_plat_pcie_of_data *data;
> > +	struct cdns_plat_pcie *cdns_plat_pcie;
> > +	const struct of_device_id *match;
> > +	struct device *dev =3D &pdev->dev;
> > +	struct pci_host_bridge *bridge;
> > +	struct cdns_pcie_ep *ep;
> > +	struct cdns_pcie_rc *rc;
> > +	int phy_count;
> > +	bool is_rc;
> > +	int ret;
> > +
> > +	match =3D of_match_device(cdns_plat_pcie_of_match, dev);
> > +	if (!match)
> > +		return -EINVAL;
> > +
> > +	data =3D (struct cdns_plat_pcie_of_data *)match->data;
> > +	is_rc =3D data->is_rc;
> > +
> > +	pr_debug(" Started %s with is_rc: %d\n", __func__, is_rc);
> > +	cdns_plat_pcie =3D devm_kzalloc(dev, sizeof(*cdns_plat_pcie),
> GFP_KERNEL);
> > +	if (!cdns_plat_pcie)
> > +		return -ENOMEM;
> > +
> > +	platform_set_drvdata(pdev, cdns_plat_pcie);
> > +	if (is_rc) {
> > +		if (!IS_ENABLED(CONFIG_PCIE_CADENCE_PLAT_HOST))
> > +			return -ENODEV;
>=20
> To continue my earlier point, I haven't understood why (in the DWC case)
> this
> isn't just CONFIG_PCIE_CADENCE_HOST - i.e. why not a single CONFIG for
> the HOST
> (instead of _HOST AND _PLAT_HOST)?
>=20

My understanding is that, this would be a place where SoC/platform specific=
 code could be inserted.
It might not be obvious here (as there is nothing much platform specific) ,=
 but just for demo purpose.
=20
> > +
> > +		bridge =3D devm_pci_alloc_host_bridge(dev, sizeof(*rc));
> > +		if (!bridge)
> > +			return -ENOMEM;
> > +
> > +		rc =3D pci_host_bridge_priv(bridge);
> > +		rc->pcie.dev =3D dev;
> > +		cdns_plat_pcie->pcie =3D &rc->pcie;
> > +		cdns_plat_pcie->is_rc =3D is_rc;
> > +
> > +		ret =3D cdns_pcie_init_phy(dev, cdns_plat_pcie->pcie);
> > +		if (ret) {
> > +			dev_err(dev, "failed to init phy\n");
> > +			return ret;
> > +		}
> > +		pm_runtime_enable(dev);
> > +		ret =3D pm_runtime_get_sync(dev);
> > +		if (ret < 0) {
> > +			dev_err(dev, "pm_runtime_get_sync() failed\n");
> > +			goto err_get_sync;
> > +		}
> > +
> > +		ret =3D cdns_pcie_host_setup(rc);
> > +		if (ret)
> > +			goto err_init;
> > +	} else {
> > +		if (!IS_ENABLED(CONFIG_PCIE_CADENCE_PLAT_EP))
> > +			return -ENODEV;
> > +
> > +		ep =3D devm_kzalloc(dev, sizeof(*ep), GFP_KERNEL);
> > +		if (!ep)
> > +			return -ENOMEM;
> > +
> > +		ep->pcie.dev =3D dev;
> > +		cdns_plat_pcie->pcie =3D &ep->pcie;
> > +		cdns_plat_pcie->is_rc =3D is_rc;
> > +
> > +		ret =3D cdns_pcie_init_phy(dev, cdns_plat_pcie->pcie);
> > +		if (ret) {
> > +			dev_err(dev, "failed to init phy\n");
> > +			return ret;
> > +		}
> > +
> > +		pm_runtime_enable(dev);
> > +		ret =3D pm_runtime_get_sync(dev);
> > +		if (ret < 0) {
> > +			dev_err(dev, "pm_runtime_get_sync() failed\n");
> > +			goto err_get_sync;
> > +		}
> > +
> > +		ret =3D cdns_pcie_ep_setup(ep);
> > +		if (ret)
> > +			goto err_init;
> > +	}
> > +
> > + err_init:
> > +	pm_runtime_put_sync(dev);
> > +
> > + err_get_sync:
> > +	pm_runtime_disable(dev);
> > +	cdns_pcie_disable_phy(cdns_plat_pcie->pcie);
> > +	phy_count =3D cdns_plat_pcie->pcie->phy_count;
> > +	while (phy_count--)
> > +		device_link_del(cdns_plat_pcie->pcie->link[phy_count]);
> > +
> > +	return 0;
> > +}
> > +
> > +static void cdns_plat_pcie_shutdown(struct platform_device *pdev)
> > +{
> > +	struct device *dev =3D &pdev->dev;
> > +	struct cdns_pcie *pcie =3D dev_get_drvdata(dev);
> > +	int ret;
> > +
> > +	ret =3D pm_runtime_put_sync(dev);
> > +	if (ret < 0)
> > +		dev_dbg(dev, "pm_runtime_put_sync failed\n");
> > +
> > +	pm_runtime_disable(dev);
> > +
> > +	cdns_pcie_disable_phy(pcie);
> > +}
> > +
> > +static const struct cdns_plat_pcie_of_data cdns_plat_pcie_host_of_data
> =3D {
> > +	.is_rc =3D true,
> > +};
> > +
> > +static const struct cdns_plat_pcie_of_data cdns_plat_pcie_ep_of_data =
=3D {
> > +	.is_rc =3D false,
> > +};
> > +
> > +static const struct of_device_id cdns_plat_pcie_of_match[] =3D {
> > +	{
> > +		.compatible =3D "cdns,cdns-pcie-host",
> > +		.data =3D &cdns_plat_pcie_host_of_data,
> > +	},
> > +	{
> > +		.compatible =3D "cdns,cdns-pcie-ep",
> > +		.data =3D &cdns_plat_pcie_ep_of_data,
> > +	},
> > +	{},
> > +};
> > +
> > +static struct platform_driver cdns_plat_pcie_driver =3D {
> > +	.driver =3D {
> > +		.name =3D "cdns-pcie",
> > +		.of_match_table =3D cdns_plat_pcie_of_match,
> > +		.pm	=3D &cdns_pcie_pm_ops,
> > +	},
> > +	.probe =3D cdns_plat_pcie_probe,
> > +	.shutdown =3D cdns_plat_pcie_shutdown,
> > +};
> > +builtin_platform_driver(cdns_plat_pcie_driver);
> > diff --git a/drivers/pci/controller/pcie-cadence.h
> b/drivers/pci/controller/pcie-cadence.h
> > index ae6bf2a..62e9dcd 100644
> > --- a/drivers/pci/controller/pcie-cadence.h
> > +++ b/drivers/pci/controller/pcie-cadence.h
> > @@ -190,6 +190,8 @@ enum cdns_pcie_rp_bar {
> >  	(((code) << 8) & CDNS_PCIE_NORMAL_MSG_CODE_MASK)
> >  #define CDNS_PCIE_MSG_NO_DATA			BIT(16)
> >
> > +struct cdns_pcie;
> > +
> >  enum cdns_pcie_msg_code {
> >  	MSG_CODE_ASSERT_INTA	=3D 0x20,
> >  	MSG_CODE_ASSERT_INTB	=3D 0x21,
> > @@ -221,6 +223,11 @@ enum cdns_pcie_msg_routing {
> >  	MSG_ROUTING_GATHER,
> >  };
> >
> > +
> > +struct cdns_pcie_common_ops {
> > +	int	(*cdns_start_link)(struct cdns_pcie *pcie, bool start);
> > +	bool	(*cdns_is_link_up)(struct cdns_pcie *pcie);
> > +};
> >  /**
> >   * struct cdns_pcie - private data for Cadence PCIe controller drivers
> >   * @reg_base: IO mapped register base
> > @@ -231,13 +238,71 @@ enum cdns_pcie_msg_routing {
> >  struct cdns_pcie {
> >  	void __iomem		*reg_base;
> >  	struct resource		*mem_res;
> > +	struct device		*dev;
> >  	bool			is_rc;
> >  	u8			bus;
> >  	int			phy_count;
> >  	struct phy		**phy;
> >  	struct device_link	**link;
> > +	const struct cdns_pcie_common_ops *ops;
> >  };
> >
> > +/**
> > + * struct cdns_pcie_rc - private data for this PCIe Root Complex drive=
r
> > + * @pcie: Cadence PCIe controller
> > + * @dev: pointer to PCIe device
> > + * @cfg_res: start/end offsets in the physical system memory to map PC=
I
> > + *           configuration space accesses
> > + * @bus_range: first/last buses behind the PCIe host controller
> > + * @cfg_base: IO mapped window to access the PCI configuration space
> of a
> > + *            single function at a time
> > + * @max_regions: maximum number of regions supported by the
> hardware
> > + * @no_bar_nbits: Number of bits to keep for inbound (PCIe -> CPU)
> address
> > + *                translation (nbits sets into the "no BAR match" regi=
ster)
> > + * @vendor_id: PCI vendor ID
> > + * @device_id: PCI device ID
> > + */
> > +struct cdns_pcie_rc {
> > +	struct cdns_pcie	pcie;
> > +	struct resource		*cfg_res;
> > +	struct resource		*bus_range;
> > +	void __iomem		*cfg_base;
> > +	u32			max_regions;
> > +	u32			no_bar_nbits;
> > +	u16			vendor_id;
> > +	u16			device_id;
> > +};
> > +
> > +/**
> > + * struct cdns_pcie_ep - private data for this PCIe endpoint controlle=
r
> driver
> > + * @pcie: Cadence PCIe controller
> > + * @max_regions: maximum number of regions supported by hardware
> > + * @ob_region_map: bitmask of mapped outbound regions
> > + * @ob_addr: base addresses in the AXI bus where the outbound regions
> start
> > + * @irq_phys_addr: base address on the AXI bus where the MSI/legacy
> IRQ
> > + *		   dedicated outbound regions is mapped.
> > + * @irq_cpu_addr: base address in the CPU space where a write access
> triggers
> > + *		  the sending of a memory write (MSI) / normal message
> (legacy
> > + *		  IRQ) TLP through the PCIe bus.
> > + * @irq_pci_addr: used to save the current mapping of the MSI/legacy
> IRQ
> > + *		  dedicated outbound region.
> > + * @irq_pci_fn: the latest PCI function that has updated the mapping o=
f
> > + *		the MSI/legacy IRQ dedicated outbound region.
> > + * @irq_pending: bitmask of asserted legacy IRQs.
> > + */
> > +struct cdns_pcie_ep {
> > +	struct cdns_pcie	pcie;
> > +	u32			max_regions;
> > +	unsigned long		ob_region_map;
> > +	phys_addr_t		*ob_addr;
> > +	phys_addr_t		irq_phys_addr;
> > +	void __iomem		*irq_cpu_addr;
> > +	u64			irq_pci_addr;
> > +	u8			irq_pci_fn;
> > +	u8			irq_pending;
> > +};
> > +
> > +
> >  /* Register access */
> >  static inline void cdns_pcie_writeb(struct cdns_pcie *pcie, u32 reg, u=
8
> value)
> >  {
> > @@ -306,6 +371,23 @@ static inline u32 cdns_pcie_ep_fn_readl(struct
> cdns_pcie *pcie, u8 fn, u32 reg)
> >  	return readl(pcie->reg_base + CDNS_PCIE_EP_FUNC_BASE(fn) +
> reg);
> >  }
> >
> > +#ifdef CONFIG_PCIE_CADENCE_HOST
> > +int cdns_pcie_host_setup(struct cdns_pcie_rc *rc);
> > +#else
> > +static inline int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
> > +{
> > +	return 0;
> > +}
> > +#endif
>=20
> I believe the rest looks OK.
>=20
> Thanks,
>=20
> Andrew Murray
>=20
> > +
> > +#ifdef CONFIG_PCIE_CADENCE_EP
> > +int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep);
> > +#else
> > +static inline int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
> > +{
> > +	return 0;
> > +}
> > +#endif
> >  void cdns_pcie_set_outbound_region(struct cdns_pcie *pcie, u8 fn,
> >  				   u32 r, bool is_io,
> >  				   u64 cpu_addr, u64 pci_addr, size_t size);
> > --
> > 2.2.2
> >

Regards,
Tom
