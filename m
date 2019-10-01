Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6229C3622
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2019 15:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfJANpH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Oct 2019 09:45:07 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:12932 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726710AbfJANpH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Oct 2019 09:45:07 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x91Dg40f029398;
        Tue, 1 Oct 2019 06:44:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=UynjIT1Hrr3eaDz1TVoSQHPS8pNGbIH0DONzQv1xd5k=;
 b=J0MYfLA/wvZ8/w9/wBzdfg8QAPZYEP2AlIyHlBkinVOWZZGpVVv+XR0W6BDHHbWuxi1k
 HEpEPXW9jInzRy323F0CCOXi8Stt88OCRjjiUf4GO0vuYHmpIfUDf4W79wzHbMTHYMQM
 M4n9+Qu/aZgpyBh/AWbhtLLl8T1xnhGkD60rfgu2LegnfDO04gl8m550z2+CucKcFKxR
 +d0vncF6kVgN8I+DrdIR7+6P4jxXRGzMjXDyWyl8zotFdrw4bey0nUny/m6qTkp1Vii3
 nD5MDdH1GocCCijV5nuy7oaNTVmMcMFx74zQbrzr0r/Uf0yfiV6NiJyjYUC/6raT7+Y/ 8Q== 
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2053.outbound.protection.outlook.com [104.47.45.53])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2va433c3ys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 01 Oct 2019 06:44:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HvwgOh6ADX8jtLt/EI7/O7uzl233Lx4ui087tAv/lRiPs2BPyjCAGrsmVI/A3nu2yguz95R20f3iodm0SKzLHoLIky64xrsRso0fj5oMr22YP1Jc50miMMcw3WGN4AHASLXzBPC+ETglZnmGN+2VWCSDs0EyxkvRv+PxL2K6kb8q+4QcEnKPhxtZmCLq/r7fLGoCjFABCQEwP8Ilb4EnSqPG7yo2JJZQmmtrwDcT7fqr/8hddQr7uUuEEGAIpEaP9q7/iVKYdteL1QUyPcaiUCvmlitYcVHQs3X3r6ZmYtGkTGZQ2D+4eQ8OM3GyfphNSi/CfQJiJH60pMGB3FBPKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UynjIT1Hrr3eaDz1TVoSQHPS8pNGbIH0DONzQv1xd5k=;
 b=kJhek14MBRZtqX8PPljfQHbIUwOI1ZfFDPkMAfDm8uPSZlHm++uvxdgwrpl2W5/+824xhdYTZszQJ+2Wbn81o+Gs/IioWG3VP+vnRzzaNi9WB3kt+MdKKyO+ch46i/akVuShJ5B9pK9GkbC1pnhMrPuet324C1K6o8h5QpE822NEi3H/Kv2jVqZha3+4WE4Rfikk7rxZksLl0Jm0wvZdsX4EvYLdBLJUjTfjHV4zJ+Df7QYYHpD9ESF2wDdYkW/K2gzJiLT6f4zQFjLQqoyn82MyA733w1z1nrUf6nvvtxym9mVeVOSOP+C7A9YwdgNzE2NRsPgqrGk/Jn74xIEgig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UynjIT1Hrr3eaDz1TVoSQHPS8pNGbIH0DONzQv1xd5k=;
 b=dySFVm4zQkKdlCoxf2vX3ajnicHV0pNlyhqQrNSTfCI4HKCL5iyS3jlcd3dk14DEIEX3Fu3Na1KfK1RfEkfiqy88hNZwZkvlhCSSlFb0pwz0V1PUN62lmmrVYubd+e+PNPgTmqAzo3SYGESfhb72WDCZHLd8WUgjQDWGHl3rQGg=
Received: from MWHPR07MB3853.namprd07.prod.outlook.com (10.172.101.140) by
 MWHPR07MB2909.namprd07.prod.outlook.com (10.169.231.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Tue, 1 Oct 2019 13:44:50 +0000
Received: from MWHPR07MB3853.namprd07.prod.outlook.com
 ([fe80::684c:973d:d098:5c83]) by MWHPR07MB3853.namprd07.prod.outlook.com
 ([fe80::684c:973d:d098:5c83%2]) with mapi id 15.20.2305.017; Tue, 1 Oct 2019
 13:44:50 +0000
From:   Tom Joseph <tjoseph@cadence.com>
To:     Andrew Murray <andrew.murray@arm.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] PCI:cadence:Driver refactored to use as a core library.
Thread-Topic: [PATCH] PCI:cadence:Driver refactored to use as a core library.
Thread-Index: AQHVd64tW+05SSJVhUuPtpoXMpJoVKdFkLMAgAAajzA=
Date:   Tue, 1 Oct 2019 13:44:49 +0000
Message-ID: <MWHPR07MB38535F4770161FC7FF24CDF7A19D0@MWHPR07MB3853.namprd07.prod.outlook.com>
References: <1569861768-10109-1-git-send-email-tjoseph@cadence.com>
 <20191001100727.GJ42880@e119886-lin.cambridge.arm.com>
In-Reply-To: <20191001100727.GJ42880@e119886-lin.cambridge.arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcdGpvc2VwaFxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJhMjllMzViXG1zZ3NcbXNnLWExZTNkYzA1LWU0NTEtMTFlOS04OTE0LTU4OTFjZjc3ZDUzMFxhbWUtdGVzdFxhMWUzZGMwNi1lNDUxLTExZTktODkxNC01ODkxY2Y3N2Q1MzBib2R5LnR4dCIgc3o9IjI1MjMwIiB0PSIxMzIxNDQxMTA4ODE3MjkwNzMiIGg9IlRiRER0WTRJMkR0NVYyWW5IUjJnVHdiMDczQT0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: 
x-originating-ip: [94.175.212.46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cc4f0472-ba90-4044-e02f-08d7467587d7
x-ms-traffictypediagnostic: MWHPR07MB2909:
x-microsoft-antispam-prvs: <MWHPR07MB2909115175F430C3368E9CBCA19D0@MWHPR07MB2909.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:935;
x-forefront-prvs: 0177904E6B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(136003)(366004)(39860400002)(376002)(13464003)(36092001)(51914003)(199004)(189003)(256004)(9686003)(55016002)(6436002)(6116002)(14454004)(5660300002)(52536014)(102836004)(55236004)(7696005)(33656002)(66476007)(71200400001)(71190400001)(76116006)(66556008)(14444005)(66946007)(53546011)(66066001)(76176011)(6246003)(2906002)(4326008)(3846002)(478600001)(99286004)(6506007)(64756008)(66446008)(6916009)(8676002)(25786009)(229853002)(86362001)(54906003)(305945005)(8936002)(81166006)(81156014)(7736002)(30864003)(476003)(316002)(11346002)(446003)(186003)(74316002)(26005)(486006)(579004);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB2909;H:MWHPR07MB3853.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QJhRrosOs+0vmDcMIYYS1X0MrXch3pyyxF4OSLFZqAsGAcQsUqVoCCAJg87CQO9SqIxOrnp9h8tN9Ah9EpKUvSRqEYq//fzt6pzHMfiua67qbz5qjfZ+lS+w2vup/Exh7eZ4P1TyI6DlZ7mwGPTE3OM2HUIJUXKakf7/itAkWQogbzluxUfQhuJuZs49xC2VA6V3FUtxYSDjK6GA2BCr1NQE0cqkDDVdzOOTaIpHPJNwIlUM6NGIQAUNcgJ1qMiKzYe7mpsbCIzFlUQNwgEYHAxRVD1rNHJjZxERHgdaP2W/t18PnC70l8Y4N7PbGES1a0QDvZkuzy+FX7zlv7atE3e4ETNS0e0IQJ6D5k68zCUXOW5R8dWGOTqxNhtTQ5dtOZZ1ojIfSFlAPf1uWlnnsxFP28oUVEi71HReUNTkjrM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc4f0472-ba90-4044-e02f-08d7467587d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2019 13:44:49.8625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fu0O04cqkVUoGRCVGT2tah3SHAD9YmGdB2nCdRHk4Dqi/3fnuE8aNce45oaNfxQEj3TGB0k1ZDgvLejB2PZRzfnYfLccs8UstiBP7gmkX40=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB2909
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-01_07:2019-10-01,2019-10-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 spamscore=0
 clxscore=1011 priorityscore=1501 lowpriorityscore=0 phishscore=0
 adultscore=0 suspectscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910010125
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Andrew,
=20
 Thanks for the kind review.=20

> -----Original Message-----
> From: Andrew Murray <andrew.murray@arm.com>
> Sent: 01 October 2019 11:07
> To: Tom Joseph <tjoseph@cadence.com>
> Cc: linux-pci@vger.kernel.org; Lorenzo Pieralisi <lorenzo.pieralisi@arm.c=
om>;
> Bjorn Helgaas <bhelgaas@google.com>; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] PCI:cadence:Driver refactored to use as a core libra=
ry.
>=20
> EXTERNAL MAIL
>=20
>=20
> Hi Tom,
>=20
> Thanks for the patch.
>=20
> I'd suggest that you rename the subject of this series to "PCI: cadence: =
..."
> to be consistent with the existing commit history, e.g. git log
> --oneline drivers/pci/controller/pcie-cadence* - you'll also see that you
> don't need a full stop at the end, and you ought to also change the tense
> of the subject, e.g. Refactor driver to ...

I agree. I will alter it as suggested.
 =20
>=20
> See comments inline...
>=20
> On Mon, Sep 30, 2019 at 05:42:48PM +0100, Tom Joseph wrote:
> > All the platform related APIs/Structures in the driver has been extract=
ed
> >  out to a separate file (pcie-cadence-plat.c). This will enable the
> >  driver to be used as a core library, which could be used by other
> >  platform drivers.Testing was done using simulation environment.
>=20
> Also change the tense for this description.

Ok. I will re-word it as : All the platform related APIs/Structures in the=
=20
driver is extracted out to a separate file (pcie-cadence-plat.c).=20
This enables the driver to be used as a core library, which could now
 be used by other platform drivers. Testing done using simulation environme=
nt.

>=20
> This patch appears to take the dwc approach of spliting itself into consi=
se
> parts, such that you can have a generic Cadence driver, yet also leave ro=
om
> and share functionality with/for Cadence derivatives - this seems like a
> sensible approach. Though, as you'll see in my comments below, because
> there
> are no other platform drivers yet - we end up with unused code and
> confusing
> Kconfig options.
>=20
> Is there an immediate plan to add another Cadence based controller? - if =
so

As Kishon mentioned J721E is coming up. But it make sense to separate those
unused codes from this patch. I will update accordingly. =20

> I'd suggest that you include this patch in that patchset for this new
> controller. Otherwise I'm happy with these changes once the Kconfig and
> unused
> code are fixed.
>=20
> >
> > Signed-off-by: Tom Joseph <tjoseph@cadence.com>
> > ---
> >  drivers/pci/controller/Kconfig             |  35 +++++++
> >  drivers/pci/controller/Makefile            |   1 +
> >  drivers/pci/controller/pcie-cadence-ep.c   |  78 ++-------------
> >  drivers/pci/controller/pcie-cadence-host.c |  77 +++------------
> >  drivers/pci/controller/pcie-cadence-plat.c | 154
> +++++++++++++++++++++++++++++
> >  drivers/pci/controller/pcie-cadence.h      |  69 +++++++++++++
> >  6 files changed, 278 insertions(+), 136 deletions(-)
> >  create mode 100644 drivers/pci/controller/pcie-cadence-plat.c
> >
> > diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kc=
onfig
> > index fe9f9f1..c175b21 100644
> > --- a/drivers/pci/controller/Kconfig
> > +++ b/drivers/pci/controller/Kconfig
> > @@ -48,6 +48,41 @@ config PCIE_CADENCE_EP
> >  	  endpoint mode. This PCIe controller may be embedded into many
> >  	  different vendors SoCs.
> >
> > +config PCIE_CADENCE_PLAT
> > +	bool "Cadence PCIe endpoint controller"
> > +	depends on OF
> > +	depends on PCI_ENDPOINT
> > +	select PCIE_CADENCE
> > +	help
> > +	  Say Y here if you want to support the Cadence PCIe  controller in
> > +	  endpoint mode. This PCIe controller may be embedded into many
> > +	  different vendors SoCs.
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
>=20
> I find this too confusing, if I navigate to Cadence PCIe controllers supp=
ort
> in menuconfig I see these options:
>=20
> Cadence PCIe host controller
> Cadence PCIe endpoint controller
> Cadence PCIe endpoint controller (NEW)
> Cadence PCIe platform host controller (NEW)
> Cadence PCIe platform endpoint controller (NEW)
>=20
> I don't think users need to care about the platform/library support, sure=
ly
> all they care about is enabling the EP or host bridge controllers for the=
ir
> hardware (and then rely on Kconfig to select what is needed).

I agree. I will remove the string, depends/select etc  from config PCIE_CAD=
ENCE_PLAT

>=20
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
> >  obj-$(CONFIG_PCI_HYPERV) +=3D pci-hyperv.o
> >  obj-$(CONFIG_PCI_MVEBU) +=3D pci-mvebu.o
> > diff --git a/drivers/pci/controller/pcie-cadence-ep.c
> b/drivers/pci/controller/pcie-cadence-ep.c
> > index def7820..617a71f 100644
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
> > @@ -396,6 +367,9 @@ static int cdns_pcie_ep_start(struct pci_epc *epc)
> >  		cfg |=3D BIT(epf->func_no);
> >  	cdns_pcie_writel(pcie, CDNS_PCIE_LM_EP_FUNC_CFG, cfg);
> >
> > +	if (pcie->ops->cdns_start_link)
> > +		return  pcie->ops->cdns_start_link(pcie, true);
> > +
> >  	return 0;
> >  }
> >
> > @@ -424,30 +398,18 @@ static const struct pci_epc_ops
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
> > +	struct device *dev =3D ep->dev;
> > +	struct platform_device *pdev =3D to_platform_device(dev);
> >  	struct device_node *np =3D dev->of_node;
> > -	struct cdns_pcie_ep *ep;
> > -	struct cdns_pcie *pcie;
> > +	struct cdns_pcie *pcie =3D &ep->pcie;
> >  	struct pci_epc *epc;
> >  	struct resource *res;
> >  	int ret;
> >  	int phy_count;
> >
> > -	ep =3D devm_kzalloc(dev, sizeof(*ep), GFP_KERNEL);
> > -	if (!ep)
> > -		return -ENOMEM;
> > -
> > -	pcie =3D &ep->pcie;
> > -	pcie->is_rc =3D false;
> > -
> >  	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM,
> "reg");
> >  	pcie->reg_base =3D devm_ioremap_resource(dev, res);
> >  	if (IS_ERR(pcie->reg_base)) {
> > @@ -537,29 +499,3 @@ static int cdns_pcie_ep_probe(struct
> platform_device *pdev)
> >
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
> > index 97e2510..55c2085 100644
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
> > @@ -233,27 +201,23 @@ static int cdns_pcie_host_init(struct device *dev=
,
> >  	return err;
> >  }
> >
> > -static int cdns_pcie_host_probe(struct platform_device *pdev)
> > +int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
> >  {
> > -	struct device *dev =3D &pdev->dev;
> > +	struct device *dev =3D rc->dev;
> > +	struct platform_device *pdev =3D to_platform_device(dev);
> >  	struct device_node *np =3D dev->of_node;
> >  	struct pci_host_bridge *bridge;
> >  	struct list_head resources;
> > -	struct cdns_pcie_rc *rc;
> >  	struct cdns_pcie *pcie;
> >  	struct resource *res;
> >  	int ret;
> >  	int phy_count;
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
> > @@ -303,6 +267,14 @@ static int cdns_pcie_host_probe(struct
> platform_device *pdev)
> >  		goto err_get_sync;
> >  	}
> >
> > +	if (pcie->ops->cdns_start_link) {
> > +		ret =3D  pcie->ops->cdns_start_link(pcie, true);
> > +		if (ret) {
> > +			dev_err(dev, "Failed to start link\n");
> > +			return ret;
> > +		}
> > +	}
> > +
> >  	ret =3D cdns_pcie_host_init(dev, &resources, rc);
> >  	if (ret)
> >  		goto err_init;
> > @@ -335,28 +307,3 @@ static int cdns_pcie_host_probe(struct
> platform_device *pdev)
> >
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
> > index 0000000..274615d
> > --- /dev/null
> > +++ b/drivers/pci/controller/pcie-cadence-plat.c
> > @@ -0,0 +1,154 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +// Copyright (c) 2019 Cadence
> > +// Cadence PCIe platform  driver.
> > +// Author: Tom Joseph <tjoseph@cadence.com>
> > +
>=20
> The style of this comment block is consistent with the other cadence file=
s in
> the tree, however the cadence files aren't consistent with the other PCI
> controller drivers (or probably much of the kernel). I don't have any
> objections
> with this, but ideally we'd eventually move to this:
>=20
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Cadence PCIe platform driver.
> + *
> + * Copyright (c) 2019 Cadence
> + *
> + * Author: Tom Joseph <tjoseph@cadence.com>
> + */

I will update it, as suggested.

>=20
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
> > + * @regmap: pointer to PCIe device
>=20
> regmap? A leftover from pcie-designware-plat.c?

Yes:). Thanks for the catch. I will remove it.

>=20
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
> > +int cdns_plat_pcie_link_control(struct cdns_pcie *pcie, bool start)
> > +{
> > +	pr_debug(" %s called\n", __func__);
> > +	return 0;
> > +}
> > +
> > +bool cdns_plat_pcie_link_status(struct cdns_pcie *pcie)
> > +{
> > +	pr_debug(" %s called\n", __func__);
> > +	return 0;
> > +}
>=20
> Given that these above two functions are only called through the
> cdns_pcie_common_ops abstraction, they should be declared static.
>=20
> I also don't understand why they are here in *this* patch -
> cdns_plat_pcie_link_status isn't called anywhere, and even though
> cdns_plat_pcie_link_control is called it doesn't do anything (start
> is always true which makes me wonder if you'll ever get a caller
> that sets it to false).
>=20
> I'd suggest removing these two functions (and related logic) until
> there is a user. This also makes reviewing the patch easier.

Ok. I will separate these as a different patch.=20
>=20
> > +
> > +static const struct cdns_pcie_common_ops cdns_pcie_common_ops =3D {
> > +	.cdns_start_link =3D cdns_plat_pcie_link_control,
> > +	.cdns_is_link_up =3D cdns_plat_pcie_link_status,
> > +};
> > +
> > +static int cdns_plat_pcie_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev =3D &pdev->dev;
> > +	struct cdns_plat_pcie *cdns_plat_pcie;
> > +	const struct of_device_id *match;
> > +	const struct cdns_plat_pcie_of_data *data;
> > +	struct pci_host_bridge *bridge;
> > +	struct cdns_pcie_rc *rc;
> > +	struct cdns_pcie_ep *ep;
> > +	int ret;
> > +	bool is_rc;
> > +
> > +	match =3D of_match_device(cdns_plat_pcie_of_match, dev);
> > +	if (!match)
> > +		return -EINVAL;
>=20
> Add a new line here.
>=20
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
> > +
> > +		bridge =3D devm_pci_alloc_host_bridge(dev, sizeof(*rc));
> > +		if (!bridge)
> > +			return -ENOMEM;
> > +
> > +		rc =3D pci_host_bridge_priv(bridge);
> > +		rc->dev =3D dev;
> > +		rc->pcie.ops =3D &cdns_pcie_common_ops;
> > +		cdns_plat_pcie->pcie =3D &rc->pcie;
> > +		cdns_plat_pcie->is_rc =3D is_rc;
> > +
> > +		ret =3D cdns_pcie_host_setup(rc);
> > +		if (ret < 0)
> > +			return ret;
> > +	} else {
> > +		if (!IS_ENABLED(CONFIG_PCIE_CADENCE_PLAT_EP))
> > +			return -ENODEV;
> > +
> > +		ep =3D devm_kzalloc(dev, sizeof(*ep), GFP_KERNEL);
> > +		if (!ep)
> > +			return -ENOMEM;
> > +		ep->dev =3D dev;
> > +		ep->pcie.ops =3D &cdns_pcie_common_ops;
> > +		cdns_plat_pcie->pcie =3D &ep->pcie;
> > +		cdns_plat_pcie->is_rc =3D is_rc;
> > +
> > +		ret =3D cdns_pcie_ep_setup(ep);
> > +		if (ret < 0)
> > +			return ret;
> > +	}
> > +	return 0;
> > +}
> > +
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
> > +static const struct cdns_plat_pcie_of_data cdns_plat_pcie_host_of_data=
 =3D {
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
> > diff --git a/drivers/pci/controller/pcie-cadence.h b/drivers/pci/contro=
ller/pcie-cadence.h
> > index ae6bf2a..3df902a 100644
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
> > @@ -236,8 +243,67 @@ struct cdns_pcie {
> >  	int			phy_count;
> >  	struct phy		**phy;
> >  	struct device_link	**link;
> > +	const struct cdns_pcie_common_ops *ops;
> > +};
> > +
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
> > +	struct device		*dev;
> > +	struct resource		*cfg_res;
> > +	struct resource		*bus_range;
> > +	void __iomem		*cfg_base;
> > +	u32			max_regions;
> > +	u32			no_bar_nbits;
> > +	u16			vendor_id;
> > +	u16			device_id;
> >  };
> >
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
> > +	struct device		*dev;
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
> > @@ -306,6 +372,9 @@ static inline u32 cdns_pcie_ep_fn_readl(struct
> cdns_pcie *pcie, u8 fn, u32 reg)
> >  	return readl(pcie->reg_base + CDNS_PCIE_EP_FUNC_BASE(fn) +
> reg);
> >  }
> >
> > +int cdns_pcie_host_setup(struct cdns_pcie_rc *rc);
> > +int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep);
> > +
>=20
> What happens if a user only selects the host bridge, will you get a build
> error relating to cdns_plat_pcie_probe not being able to find an
> implementation of cdns_pcie_ep_setup?

Yes. I will add stub function to deal with such scenario.

>=20
> Thanks,
>=20
> Andrew Murray
>=20
> >  void cdns_pcie_set_outbound_region(struct cdns_pcie *pcie, u8 fn,
> >  				   u32 r, bool is_io,
> >  				   u64 cpu_addr, u64 pci_addr, size_t size);
> > --
> > 2.2.2
> >
