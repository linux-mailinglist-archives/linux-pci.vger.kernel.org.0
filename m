Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A958219D448
	for <lists+linux-pci@lfdr.de>; Fri,  3 Apr 2020 11:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389998AbgDCJsI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Apr 2020 05:48:08 -0400
Received: from mail-eopbgr1400095.outbound.protection.outlook.com ([40.107.140.95]:54617
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727882AbgDCJsH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 3 Apr 2020 05:48:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WjTIQLlDB0dQf03AXbFMe1foWLi5RKbSzAbv2e5LmYTh62VUSIlT4ygdQVubFWBZngNi8DJihrtcQT2dkSS3q44jj0P4bSBEnwbilRbpot8NqscnYmsHY443F6QRuqjOCFDSRdqpkPC4k17eA+/dItGMjJG5Pa84TvBX9T23G1pR6gYsOtDwjTHmYWP5sQAlT2ZDmhxRDM0nvQ2betl4lb9uFL96+yh1NIkKEOL5TXzr2smt3rxQa8QRzlrRRmAYNhT4FocCoJnDDbGIefIx0sihNF0UUG2YYTLsX/8kT9B61uWOyaivMVDfujCTYDr7WaQkxsnRp4L2Mhz+xyqmBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JlX2MuRkSEu7WnylOL6YgRf3TT0iLUVY+bK9qTCKKl8=;
 b=nbp7BPTdKri7nXO3PiL6bTqYT5PB1kIlik0ttrLaUeJaVD2JKq9tC5w0lBlXi29UIdbgvJamksAOBiDaKA4zqL9IlifMdi954GNp54qKxvRp+KAz+cxgTldGZ5viAApiXnbdiZRYS7xAxG+U9bbREaQMkCCZrGfwARW6+/G5ws1m2qqaQvEfGzSa3lSrgeRI92XfnabAg8SrH1tqlWqLXCvf4+R4KvuACrN/zbM+4wc3OQ9exG54Mdxjr0ogA3HJEiM4gdQ+AsFQNSHJEYoxTsQDfrTBPBPYrzQvz56O93DqHzCsu0v0/GLCpGCHoJ2Llzvm5VqM6Da/SS8w3Gdzfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JlX2MuRkSEu7WnylOL6YgRf3TT0iLUVY+bK9qTCKKl8=;
 b=KK4G94UEZ2dFjUY8As6tl3pmax0nRy9nyyQAf4SfP+K8PgF3YeanKrKqRyfgDh1wz068GdWGH+VFbzXJgPbw2QHYQXNHXfNru5WKI4P7ahYrpRCbDxzwML7CytT7D8IvMSparoJoHfkBRDom1EFKQQ/ASk8hd75rdBfvjanjgAQ=
Received: from OSBPR01MB3590.jpnprd01.prod.outlook.com (20.178.97.80) by
 OSBPR01MB1653.jpnprd01.prod.outlook.com (52.134.225.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.15; Fri, 3 Apr 2020 09:48:00 +0000
Received: from OSBPR01MB3590.jpnprd01.prod.outlook.com
 ([fe80::490:aa83:2d09:3a0b]) by OSBPR01MB3590.jpnprd01.prod.outlook.com
 ([fe80::490:aa83:2d09:3a0b%5]) with mapi id 15.20.2878.017; Fri, 3 Apr 2020
 09:47:59 +0000
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
Thread-Index: AQHWCSZxc1fWoIOK5Uum+Ci9vBCgnqhnD+EAgAALDACAAAjPAIAAA4Eg
Date:   Fri, 3 Apr 2020 09:47:59 +0000
Message-ID: <OSBPR01MB3590871E79F1B86A6F5B2247AAC70@OSBPR01MB3590.jpnprd01.prod.outlook.com>
References: <1585856319-4380-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1585856319-4380-7-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <TYAPR01MB45442959B9FD7299D2CB8D73D8C70@TYAPR01MB4544.jpnprd01.prod.outlook.com>
 <OSBPR01MB3590260FDE8EA7D3701EAE2FAAC70@OSBPR01MB3590.jpnprd01.prod.outlook.com>
 <TYAPR01MB4544D205BE659CE74205737CD8C70@TYAPR01MB4544.jpnprd01.prod.outlook.com>
In-Reply-To: <TYAPR01MB4544D205BE659CE74205737CD8C70@TYAPR01MB4544.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=prabhakar.mahadev-lad.rj@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1d56e7db-c2c8-4ff3-a094-08d7d7b41864
x-ms-traffictypediagnostic: OSBPR01MB1653:|OSBPR01MB1653:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSBPR01MB16532788074FBC8678DF70ABAAC70@OSBPR01MB1653.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0362BF9FDB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB3590.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(396003)(39860400002)(376002)(346002)(366004)(136003)(316002)(2906002)(6506007)(7416002)(66476007)(66946007)(66556008)(71200400001)(7696005)(76116006)(64756008)(66446008)(33656002)(8676002)(8936002)(53546011)(55016002)(186003)(81156014)(478600001)(54906003)(86362001)(52536014)(5660300002)(4326008)(81166006)(110136005)(26005)(9686003)(921003)(1121003);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6XAktP/sbBLpEzKIUOFU7CmqCBduq7dv1/u7iqZSUxfhZEhTpvYg3wdxIvXZUpgjd5VQjBYOckqvgRsZjESF5bt0TqIISWoMP3DmJ+Y2Tk0U8dpYgeL8Llc6E3HeRk9OydXAe1No+dXFRY1bXM43dzncx/KUpmo/XjAQbB7iLNswqrHeBuyadYTpsV77gbXyNCRFRHNNMV7DsHt/IFg3v/tKAqyzc202HTbAnarTc/XNXGzjmnRhuQCb0IsX/tWNz3hW8YfEQzBB4tSEOclM4ZjuMgEp9txQn3sYN8BFFwf6ogpY+FfHGuOD3cAwh1YGmtVW9jKr4qS3Ts4lKoMU0V6hvLCKheAQSPGua2lCWSSF45KsRQQ7q5c5MJnqfDBMI98Dd0LnZGBoERz3j6JvRC2W4I58RKJdXD3loR3vbZ0nV8klZpu/YZ4J8BMHGbKlPkivFHUrLexGs9JU/+Vg1NCbsv8aP3nAvAexfb2Jko0yxdTfctCq5joSU1wrfUko
x-ms-exchange-antispam-messagedata: Rfsqk7g5r14+T4/tj4Fs/xhL5f9cs/nt9hrYPycqkHWvixffvGdYriA+xJ6FkY6PCJJU2LSU9J+ecXdBhAYhcbWLmdvKA3gBPihh8Vt+KQ8ck1KqFFmvZCOgZjfkobKsdqTqYOySuzKXB6WBwiz6BQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d56e7db-c2c8-4ff3-a094-08d7d7b41864
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2020 09:47:59.6679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jOJUwuyQcBrD+uV9gxrSa9Hf4R1k2mWV5KJchKRaWK2BpdnsOhkMt495A4k1ev2CUAiUU6xPnhdbLe+DyhHH6rr00pou9SLfoqfkTMByk7uo2CQpTWjnIYN77ejYbMN3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB1653
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Shimoda-san,

> -----Original Message-----
> From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Sent: 03 April 2020 10:34
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
bhakar.csengg@gmail.com>
> Subject: RE: [PATCH v6 06/11] PCI: endpoint: Add support to handle multip=
le base for mapping outbound memory
>
> Hi Prabhakar-san,
>
> > From: Prabhakar Mahadev Lad, Sent: Friday, April 3, 2020 6:12 PM
> <snip>
> > > > @@ -122,31 +167,56 @@ EXPORT_SYMBOL_GPL(pci_epc_mem_exit);
> > > >  void __iomem *pci_epc_mem_alloc_addr(struct pci_epc *epc,
> > > >       phys_addr_t *phys_addr, size_t size)
> > > >  {
> > > > -int pageno;
> > > >  void __iomem *virt_addr =3D NULL;
> > > > -struct pci_epc_mem *mem =3D epc->mem;
> > > > -unsigned int page_shift =3D ilog2(mem->page_size);
> > > > +struct pci_epc_mem *mem;
> > > > +unsigned int page_shift;
> > > > +int pageno =3D -EINVAL;
> > > >  int order;
> > > > +int i;
> > > >
> > > > -size =3D ALIGN(size, mem->page_size);
> > > > -order =3D pci_epc_mem_get_order(mem, size);
> > > > -
> > > > -mutex_lock(&mem->lock);
> > > > -pageno =3D bitmap_find_free_region(mem->bitmap, mem->pages, order)=
;
> > > > -if (pageno < 0)
> > > > -goto ret;
> > > > +for (i =3D 0; i < epc->num_windows; i++) {
> > > > +mem =3D epc->windows[i];
> > > > +mutex_lock(&mem->lock);
> > >
> > > This is my feeling though, calling mutex_lock() in the loop seems
> > > to cause overhead. And, if we call mutex_lock() at out-of the loop,
> > > I think we can write single mutex_unlock() calling.
> > >
> > But the mutex is for each window, are you suggesting to add a global mu=
tex ?
>
> Oops, that's right. So, I'd like to recall.
>
> > > > +size =3D ALIGN(size, mem->window.page_size);
> > >
> > > I'm sorry I should have realized this in the previous review,
> > > but overwriting this size is possible to cause an issue at second tim=
e or more loops.
> > > So, the first argument of ALIGN should be kept for the loop.
> > >
> > Could you please elaborate on this.
>
> My concern is the following.
>
> For example, the size of argument of pci_epc_mem_alloc_addr() is 4096.
> epc->windows[0].window.page_size =3D 8192
>  --> then the size will be changed to 0.
>
> epc->windows[1].window.page_size =3D 4096
>  --> since the size was changed to 0 on the first loop, the result is 0.
>      But, this should be 4096.
>
> Does such a case never happen?
> (Or, is my understanding incorrect?)
>
Good catch, yes that needs fixing probably by having a local variable for s=
ize.

Cheers,
--Prabhakar

> Best regards,
> Yoshihiro Shimoda
>
>
> > > > +order =3D pci_epc_mem_get_order(mem, size);
> > > >
> > > > -*phys_addr =3D mem->phys_base + ((phys_addr_t)pageno << page_shift=
);
> > > > -virt_addr =3D ioremap(*phys_addr, size);
> > > > -if (!virt_addr)
> > > > -bitmap_release_region(mem->bitmap, pageno, order);
> > > > +pageno =3D bitmap_find_free_region(mem->bitmap, mem->pages,
> > > > + order);
> > > > +if (pageno >=3D 0) {
> > > > +page_shift =3D ilog2(mem->window.page_size);
> > > > +*phys_addr =3D mem->window.phys_base +
> > > > +((phys_addr_t)pageno << page_shift);
> > > > +virt_addr =3D ioremap(*phys_addr, size);
> > > > +if (!virt_addr)
> > > > +bitmap_release_region(mem->bitmap,
> > > > +      pageno, order);
> > > > +mutex_unlock(&mem->lock);
> > > > +return virt_addr;
> > >
> > > As I mentioned above, if mutex_lock() is called at out-of-loop,
> > > we can use "goto ret;" here like the original code,
> > >
> > > > +}
> > > > +mutex_unlock(&mem->lock);
> > >
> > > and we can remove this.
> > >
> > > > +}
> > > >
> > > > -ret:
> > > > -mutex_unlock(&mem->lock);
> > > >  return virt_addr;
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(pci_epc_mem_alloc_addr);
> > > >
> > > > +struct pci_epc_mem *pci_epc_get_matching_window(struct pci_epc *ep=
c,
> > > > +phys_addr_t phys_addr)
> > > > +{
> > > > +struct pci_epc_mem *mem;
> > > > +int i;
> > > > +
> > > > +for (i =3D 0; i < epc->num_windows; i++) {
> > > > +mem =3D epc->windows[i];
> > > > +
> > > > +if (phys_addr >=3D mem->window.phys_base &&
> > > > +    phys_addr < (mem->window.phys_base + mem->window.size))
> > > > +return mem;
> > > > +}
> > > > +
> > > > +return NULL;
> > > > +}
> > > > +
> > > >  /**
> > > >   * pci_epc_mem_free_addr() - free the allocated memory address
> > > >   * @epc: the EPC device on which memory was allocated
> > > > @@ -159,14 +229,23 @@ EXPORT_SYMBOL_GPL(pci_epc_mem_alloc_addr);
> > > >  void pci_epc_mem_free_addr(struct pci_epc *epc, phys_addr_t phys_a=
ddr,
> > > >     void __iomem *virt_addr, size_t size)
> > > >  {
> > > > +struct pci_epc_mem *mem;
> > > > +unsigned int page_shift;
> > > > +size_t page_size;
> > > >  int pageno;
> > > > -struct pci_epc_mem *mem =3D epc->mem;
> > > > -unsigned int page_shift =3D ilog2(mem->page_size);
> > > >  int order;
> > > >
> > > > +mem =3D pci_epc_get_matching_window(epc, phys_addr);
> > > > +if (!mem) {
> > > > +pr_err("failed to get matching window\n");
> > > > +return;
> > > > +}
> > > > +
> > > > +page_size =3D mem->window.page_size;
> > > > +page_shift =3D ilog2(page_size);
> > > >  iounmap(virt_addr);
> > > > -pageno =3D (phys_addr - mem->phys_base) >> page_shift;
> > > > -size =3D ALIGN(size, mem->page_size);
> > > > +pageno =3D (phys_addr - mem->window.phys_base) >> page_shift;
> > > > +size =3D ALIGN(size, page_size);
> > > >  order =3D pci_epc_mem_get_order(mem, size);
> > > >  mutex_lock(&mem->lock);
> > > >  bitmap_release_region(mem->bitmap, pageno, order);
> > > > diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> > > > index e0ed9d01f6e5..d5da11cf0f2a 100644
> > > > --- a/include/linux/pci-epc.h
> > > > +++ b/include/linux/pci-epc.h
> > > > @@ -65,20 +65,28 @@ struct pci_epc_ops {
> > > >  struct module *owner;
> > > >  };
> > > >
> > > > +/**
> > > > + * struct pci_epc_mem_window - address window of the endpoint cont=
roller
> > > > + * @phys_base: physical base address of the PCI address window
> > > > + * @size: the size of the PCI address window
> > > > + * @page_size: size of each page
> > > > + */
> > > > +struct pci_epc_mem_window {
> > > > +phys_addr_tphys_base;
> > > > +size_tsize;
> > > > +size_tpage_size;
> > > > +};
> > > > +
> > > >  /**
> > > >   * struct pci_epc_mem - address space of the endpoint controller
> > > > - * @phys_base: physical base address of the PCI address space
> > > > - * @size: the size of the PCI address space
> > > > + * @window: address window of the endpoint controller
> > > >   * @bitmap: bitmap to manage the PCI address space
> > > > - * @pages: number of bits representing the address region
> > > > - * @page_size: size of each page
> > > >   * @lock: mutex to protect bitmap
> > > > + * @pages: number of bits representing the address region
> > >
> > > Perhaps, we should not change the "@pages" line.
> > >
> > OK will drop this change.
> >
> > Cheers,
> > --Prabhakar
> >
> > > Best regards,
> > > Yoshihiro Shimoda



Renesas Electronics Europe GmbH, Geschaeftsfuehrer/President: Carsten Jauch=
, Sitz der Gesellschaft/Registered office: Duesseldorf, Arcadiastrasse 10, =
40472 Duesseldorf, Germany, Handelsregister/Commercial Register: Duesseldor=
f, HRB 3708 USt-IDNr./Tax identification no.: DE 119353406 WEEE-Reg.-Nr./WE=
EE reg. no.: DE 14978647
