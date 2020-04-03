Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E96C619D336
	for <lists+linux-pci@lfdr.de>; Fri,  3 Apr 2020 11:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390533AbgDCJLv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Apr 2020 05:11:51 -0400
Received: from mail-eopbgr1400129.outbound.protection.outlook.com ([40.107.140.129]:18400
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390267AbgDCJLv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 3 Apr 2020 05:11:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mIwdXunVl941Dl2fy80tulpa735YP9CQq8aYzlEMOFbc7IBWXdjaHvKTqBlMb17kv3ob94cdq6EMn1+/Fl0nVwxawjfbYKtvGOPjke+MMHiyFTnmlRtJZnCRTjQDvDec5n3SrlaCs2fBxtwxQkahmL79Dh9yQPjUeMsX0UNhOPzXAA0Jc+wBwxxqZGBIkfF9XqQY13+XErxwzefk1ZqQT/fqAlt9BrSm8/WrbOYUwbk/jRZi0IHIldZV+7fJf6gShBCq+obRGmOcF/jDjugepaVrmpCIZTI7qiLduXeEC3CM8NAfihwz9OjgDTrzleNgWqe6geJcPnVv0IruP0HrBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72wmPafCXmWVAQHuEPyVH5zwvr38ZQ+CeGkHUCqWOo0=;
 b=TC2FAK+UDGnSkIdnWymThBy1ASGJPSFI4F6Hsj5l3frYlsXQd2mB+LxKRfYpLDnHJPd1l6X6nW4BNxtXlGnWcAYTmLdm7yNVuZ01RVJ7o9gkKJa0VGXzGEIFpO3HEkDLzp6RhzEEIwZjh8PaTqrim0KhyuvdSyEZgs+DUcul9oMCGbPxDaOcHUB6dFi9v5cUC1RNtZlVd1h7XyKwtvKkSnV39UpG0eTS+b0Sep072rvIWkHn3E2FoAOPqzJXpTpe/jgW4lfIPI3lPqBsl0cUAtTFk3FkQCPJtvSvh82Ebsre6O745K/IjgW3CPd6cMk/gsKWJbuCTYpndrdsD4xVOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72wmPafCXmWVAQHuEPyVH5zwvr38ZQ+CeGkHUCqWOo0=;
 b=HIE6dvDDghbZbjF9xRSo5WZwgWMfVBUkyjiaIjMBDWSu7VPpyXLYV/9EmQhnE5stjmSWbvlCXmvKI/Re9HwSj0f3PrFTZykQw+oFhFN5mP5m0a0NAFdPq0z5jc5yzw063Tq9p3th1tzB4IK9LaDICT1TrxDfmo4sVysslypFOeg=
Received: from OSBPR01MB3590.jpnprd01.prod.outlook.com (20.178.97.80) by
 OSBPR01MB2917.jpnprd01.prod.outlook.com (52.134.253.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.19; Fri, 3 Apr 2020 09:11:45 +0000
Received: from OSBPR01MB3590.jpnprd01.prod.outlook.com
 ([fe80::490:aa83:2d09:3a0b]) by OSBPR01MB3590.jpnprd01.prod.outlook.com
 ([fe80::490:aa83:2d09:3a0b%5]) with mapi id 15.20.2878.017; Fri, 3 Apr 2020
 09:11:45 +0000
From:   Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Murray <andrew.murray@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Simon Horman <horms@verge.net.au>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Heiko Stuebner <heiko@sntech.de>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        Lad Prabhakar <prabhakar.csengg@gmail.com>
Subject: RE: [PATCH v6 06/11] PCI: endpoint: Add support to handle multiple
 base for mapping outbound memory
Thread-Topic: [PATCH v6 06/11] PCI: endpoint: Add support to handle multiple
 base for mapping outbound memory
Thread-Index: AQHWCSZxc1fWoIOK5Uum+Ci9vBCgnqhnD+EAgAALDAA=
Date:   Fri, 3 Apr 2020 09:11:44 +0000
Message-ID: <OSBPR01MB3590260FDE8EA7D3701EAE2FAAC70@OSBPR01MB3590.jpnprd01.prod.outlook.com>
References: <1585856319-4380-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1585856319-4380-7-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <TYAPR01MB45442959B9FD7299D2CB8D73D8C70@TYAPR01MB4544.jpnprd01.prod.outlook.com>
In-Reply-To: <TYAPR01MB45442959B9FD7299D2CB8D73D8C70@TYAPR01MB4544.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=prabhakar.mahadev-lad.rj@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: eea27f69-877e-4130-0eb3-08d7d7af0872
x-ms-traffictypediagnostic: OSBPR01MB2917:|OSBPR01MB2917:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSBPR01MB29175D1E43EEBBA0FB41C23FAAC70@OSBPR01MB2917.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0362BF9FDB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB3590.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(376002)(346002)(396003)(366004)(136003)(39860400002)(66946007)(64756008)(2906002)(33656002)(110136005)(55016002)(316002)(54906003)(9686003)(4326008)(7416002)(5660300002)(186003)(53546011)(76116006)(71200400001)(8936002)(66556008)(66476007)(66446008)(81156014)(7696005)(26005)(6506007)(478600001)(52536014)(8676002)(81166006)(86362001)(921003)(1121003);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uDkg5+iGdE8zVKSb68aAFIOSyNeo5vWtw62T45u8IB+/IjfAPATXfixoWt8AzrrH/AKFXF75PPYuJCTJHsFVMK8mRbAhvc7HanyuOjV371ePPMIBnMzqg4nTap0x02PL/wIIGcQ5LFKjH1iCUAgHO8XcQx6ONKt2YnPI8lyjeqjLqrZ29OQFzoqSs9eOShElXqCuX+X87cyYfZ6syHk6oUsnNZnfuUxfvZ3SXEM0+hDYEUr46Bw2FO9APk73Hb7vP3CFSlpt4FMwBlHrPdW1lIte8XLNaMfq5Zqbhljq1PGlmk8b5W0sV9CrTO+ef78krrsW76Fjn/Ovx2VCX+pp6qCX12T1V22OWs5WN1ggqWss9aazgc0IxhzxKg/+2b2BlxHbqLUtM2HbIBbnhaVhNHRI37ajJch9i4kZbJocLXKK5SsDvzyQOL+LIxDsrzqRj4JHABZgoEQc0CcyDrTwrtjvs8G9F122gg75b4SIKxoBmeG+Zl90Dhkhrcz2gXSo
x-ms-exchange-antispam-messagedata: bulWmnlFgbEgprUTy5mKyQzDL/yNuhPGIDHRhAMvmk10hOm0khrIenFdLxKjdkd7ycRIcJLCwOvhuRu3uIJDKchb1+xXmywItnwTm4MCJ4Jlbgsn38/MkUupOVfoIwlHX8A7hupdjFWti/2p36i/cQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eea27f69-877e-4130-0eb3-08d7d7af0872
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2020 09:11:45.3088
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3hGtYOHFbkyfU7t6aEPQGXnbHzWSyA3jXs3pYXYKORqmbYYFsnoFF/FnvXueO1xw+M0DEQ8rS9uOzeQ/FvCCZJwy2KGa7xxQxgK3ZWP16MBfgGjgVp6Fk8qICKJLww31
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2917
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Shimoda-san,

Thank you for the review.

> -----Original Message-----
> From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Sent: 03 April 2020 09:23
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>; Bjor=
n Helgaas <bhelgaas@google.com>; Rob Herring
> <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>; Geert Uytterho=
even <geert+renesas@glider.be>; Magnus Damm
> <magnus.damm@gmail.com>; Kishon Vijay Abraham I <kishon@ti.com>; Lorenzo =
Pieralisi <lorenzo.pieralisi@arm.com>; Marek Vasut
> <marek.vasut+renesas@gmail.com>; linux-pci@vger.kernel.org
> Cc: Catalin Marinas <catalin.marinas@arm.com>; Will Deacon <will@kernel.o=
rg>; Arnd Bergmann <arnd@arndb.de>; Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>; Andrew Murray <andrew.murray@arm.com>; devi=
cetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; linux-renesas-soc@vger.kernel.org; =
Chris Paterson <Chris.Paterson2@renesas.com>; Frank Rowand
> <frowand.list@gmail.com>; Gustavo Pimentel <gustavo.pimentel@synopsys.com=
>; Jingoo Han <jingoohan1@gmail.com>; Simon Horman
> <horms@verge.net.au>; Shawn Lin <shawn.lin@rock-chips.com>; Tom Joseph <t=
joseph@cadence.com>; Heiko Stuebner
> <heiko@sntech.de>; linux-rockchip@lists.infradead.org; Lad Prabhakar <pra=
bhakar.csengg@gmail.com>; Prabhakar Mahadev Lad
> <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: RE: [PATCH v6 06/11] PCI: endpoint: Add support to handle multip=
le base for mapping outbound memory
>
> Hi Prabhakar-san,
>
> Thank you for the patch!
>
> > From: Lad Prabhakar, Sent: Friday, April 3, 2020 4:39 AM
> >
> > R-Car PCIe controller has support to map multiple memory regions for
> > mapping the outbound memory in local system also the controller limits
> > single allocation for each region (that is, once a chunk is used from t=
he
> > region it cannot be used to allocate a new one). This features inspires=
 to
> > add support for handling multiple memory bases in endpoint framework.
> >
> > With this patch pci_epc_mem_init() initializes address space for endpoi=
nt
> > controller which support single window and whereas __pci_epc_mem_init()
> > now accepts pointer to multiple windows supported by endpoint controlle=
r.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > @@ -38,61 +38,95 @@ static int pci_epc_mem_get_order(struct pci_epc_mem=
 *mem, size_t size)
> >  /**
> >   * __pci_epc_mem_init() - initialize the pci_epc_mem structure
> >   * @epc: the EPC device that invoked pci_epc_mem_init
> > - * @phys_base: the physical address of the base
> > - * @size: the size of the address space
> > - * @page_size: size of each page
> > + * @windows: pointer to windows supported by the device
> > + * @num_windows: number of windows device supports
> >   *
> >   * Invoke to initialize the pci_epc_mem structure used by the
> >   * endpoint functions to allocate mapped PCI address.
> >   */
> > -int __pci_epc_mem_init(struct pci_epc *epc, phys_addr_t phys_base, siz=
e_t size,
> > -       size_t page_size)
> > +int __pci_epc_mem_init(struct pci_epc *epc, struct pci_epc_mem_window =
*windows,
> > +       unsigned int num_windows)
> >  {
> > -int ret;
> > -struct pci_epc_mem *mem;
> > -unsigned long *bitmap;
> > +struct pci_epc_mem *mem =3D NULL;
> > +unsigned long *bitmap =3D NULL;
> >  unsigned int page_shift;
> > -int pages;
> > +size_t page_size;
> >  int bitmap_size;
> > +int pages;
> > +int ret;
> > +int i;
> >
> > -if (page_size < PAGE_SIZE)
> > -page_size =3D PAGE_SIZE;
> > +epc->num_windows =3D 0;
> >
> > -page_shift =3D ilog2(page_size);
> > -pages =3D size >> page_shift;
> > -bitmap_size =3D BITS_TO_LONGS(pages) * sizeof(long);
> > +if (!windows || !num_windows)
> > +return -EINVAL;
> >
> > -mem =3D kzalloc(sizeof(*mem), GFP_KERNEL);
> > -if (!mem) {
> > -ret =3D -ENOMEM;
> > -goto err;
> > -}
> > +epc->windows =3D kcalloc(num_windows, sizeof(*mem), GFP_KERNEL);
> > +if (!epc->windows)
> > +return -ENOMEM;
> >
> > -bitmap =3D kzalloc(bitmap_size, GFP_KERNEL);
> > -if (!bitmap) {
> > -ret =3D -ENOMEM;
> > -goto err_mem;
> > -}
> > +for (i =3D 0; i < num_windows; i++) {
> > +page_size =3D windows[i].page_size;
> > +if (page_size < PAGE_SIZE)
> > +page_size =3D PAGE_SIZE;
> > +page_shift =3D ilog2(page_size);
> > +pages =3D windows[i].size >> page_shift;
> > +bitmap_size =3D BITS_TO_LONGS(pages) * sizeof(long);
> > +
> > +mem =3D kzalloc(sizeof(*mem), GFP_KERNEL);
> > +if (!mem) {
> > +ret =3D -ENOMEM;
> > +i -=3D 1;
>
> nit: We can use i--;
>
Will change it.

> > +goto err_mem;
> > +}
> > +
> > +bitmap =3D kzalloc(bitmap_size, GFP_KERNEL);
> > +if (!bitmap) {
> > +ret =3D -ENOMEM;
> > +kfree(mem);
> > +i -=3D 1;
>
> nit: We can use i--;
>
As above.

> <snip>
> > @@ -122,31 +167,56 @@ EXPORT_SYMBOL_GPL(pci_epc_mem_exit);
> >  void __iomem *pci_epc_mem_alloc_addr(struct pci_epc *epc,
> >       phys_addr_t *phys_addr, size_t size)
> >  {
> > -int pageno;
> >  void __iomem *virt_addr =3D NULL;
> > -struct pci_epc_mem *mem =3D epc->mem;
> > -unsigned int page_shift =3D ilog2(mem->page_size);
> > +struct pci_epc_mem *mem;
> > +unsigned int page_shift;
> > +int pageno =3D -EINVAL;
> >  int order;
> > +int i;
> >
> > -size =3D ALIGN(size, mem->page_size);
> > -order =3D pci_epc_mem_get_order(mem, size);
> > -
> > -mutex_lock(&mem->lock);
> > -pageno =3D bitmap_find_free_region(mem->bitmap, mem->pages, order);
> > -if (pageno < 0)
> > -goto ret;
> > +for (i =3D 0; i < epc->num_windows; i++) {
> > +mem =3D epc->windows[i];
> > +mutex_lock(&mem->lock);
>
> This is my feeling though, calling mutex_lock() in the loop seems
> to cause overhead. And, if we call mutex_lock() at out-of the loop,
> I think we can write single mutex_unlock() calling.
>
But the mutex is for each window, are you suggesting to add a global mutex =
?

> > +size =3D ALIGN(size, mem->window.page_size);
>
> I'm sorry I should have realized this in the previous review,
> but overwriting this size is possible to cause an issue at second time or=
 more loops.
> So, the first argument of ALIGN should be kept for the loop.
>
Could you please elaborate on this.

> > +order =3D pci_epc_mem_get_order(mem, size);
> >
> > -*phys_addr =3D mem->phys_base + ((phys_addr_t)pageno << page_shift);
> > -virt_addr =3D ioremap(*phys_addr, size);
> > -if (!virt_addr)
> > -bitmap_release_region(mem->bitmap, pageno, order);
> > +pageno =3D bitmap_find_free_region(mem->bitmap, mem->pages,
> > + order);
> > +if (pageno >=3D 0) {
> > +page_shift =3D ilog2(mem->window.page_size);
> > +*phys_addr =3D mem->window.phys_base +
> > +((phys_addr_t)pageno << page_shift);
> > +virt_addr =3D ioremap(*phys_addr, size);
> > +if (!virt_addr)
> > +bitmap_release_region(mem->bitmap,
> > +      pageno, order);
> > +mutex_unlock(&mem->lock);
> > +return virt_addr;
>
> As I mentioned above, if mutex_lock() is called at out-of-loop,
> we can use "goto ret;" here like the original code,
>
> > +}
> > +mutex_unlock(&mem->lock);
>
> and we can remove this.
>
> > +}
> >
> > -ret:
> > -mutex_unlock(&mem->lock);
> >  return virt_addr;
> >  }
> >  EXPORT_SYMBOL_GPL(pci_epc_mem_alloc_addr);
> >
> > +struct pci_epc_mem *pci_epc_get_matching_window(struct pci_epc *epc,
> > +phys_addr_t phys_addr)
> > +{
> > +struct pci_epc_mem *mem;
> > +int i;
> > +
> > +for (i =3D 0; i < epc->num_windows; i++) {
> > +mem =3D epc->windows[i];
> > +
> > +if (phys_addr >=3D mem->window.phys_base &&
> > +    phys_addr < (mem->window.phys_base + mem->window.size))
> > +return mem;
> > +}
> > +
> > +return NULL;
> > +}
> > +
> >  /**
> >   * pci_epc_mem_free_addr() - free the allocated memory address
> >   * @epc: the EPC device on which memory was allocated
> > @@ -159,14 +229,23 @@ EXPORT_SYMBOL_GPL(pci_epc_mem_alloc_addr);
> >  void pci_epc_mem_free_addr(struct pci_epc *epc, phys_addr_t phys_addr,
> >     void __iomem *virt_addr, size_t size)
> >  {
> > +struct pci_epc_mem *mem;
> > +unsigned int page_shift;
> > +size_t page_size;
> >  int pageno;
> > -struct pci_epc_mem *mem =3D epc->mem;
> > -unsigned int page_shift =3D ilog2(mem->page_size);
> >  int order;
> >
> > +mem =3D pci_epc_get_matching_window(epc, phys_addr);
> > +if (!mem) {
> > +pr_err("failed to get matching window\n");
> > +return;
> > +}
> > +
> > +page_size =3D mem->window.page_size;
> > +page_shift =3D ilog2(page_size);
> >  iounmap(virt_addr);
> > -pageno =3D (phys_addr - mem->phys_base) >> page_shift;
> > -size =3D ALIGN(size, mem->page_size);
> > +pageno =3D (phys_addr - mem->window.phys_base) >> page_shift;
> > +size =3D ALIGN(size, page_size);
> >  order =3D pci_epc_mem_get_order(mem, size);
> >  mutex_lock(&mem->lock);
> >  bitmap_release_region(mem->bitmap, pageno, order);
> > diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> > index e0ed9d01f6e5..d5da11cf0f2a 100644
> > --- a/include/linux/pci-epc.h
> > +++ b/include/linux/pci-epc.h
> > @@ -65,20 +65,28 @@ struct pci_epc_ops {
> >  struct module *owner;
> >  };
> >
> > +/**
> > + * struct pci_epc_mem_window - address window of the endpoint controll=
er
> > + * @phys_base: physical base address of the PCI address window
> > + * @size: the size of the PCI address window
> > + * @page_size: size of each page
> > + */
> > +struct pci_epc_mem_window {
> > +phys_addr_tphys_base;
> > +size_tsize;
> > +size_tpage_size;
> > +};
> > +
> >  /**
> >   * struct pci_epc_mem - address space of the endpoint controller
> > - * @phys_base: physical base address of the PCI address space
> > - * @size: the size of the PCI address space
> > + * @window: address window of the endpoint controller
> >   * @bitmap: bitmap to manage the PCI address space
> > - * @pages: number of bits representing the address region
> > - * @page_size: size of each page
> >   * @lock: mutex to protect bitmap
> > + * @pages: number of bits representing the address region
>
> Perhaps, we should not change the "@pages" line.
>
OK will drop this change.

Cheers,
--Prabhakar

> Best regards,
> Yoshihiro Shimoda



Renesas Electronics Europe GmbH, Geschaeftsfuehrer/President: Carsten Jauch=
, Sitz der Gesellschaft/Registered office: Duesseldorf, Arcadiastrasse 10, =
40472 Duesseldorf, Germany, Handelsregister/Commercial Register: Duesseldor=
f, HRB 3708 USt-IDNr./Tax identification no.: DE 119353406 WEEE-Reg.-Nr./WE=
EE reg. no.: DE 14978647
