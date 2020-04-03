Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7205819D3C8
	for <lists+linux-pci@lfdr.de>; Fri,  3 Apr 2020 11:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390315AbgDCJeN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Apr 2020 05:34:13 -0400
Received: from mail-eopbgr1400104.outbound.protection.outlook.com ([40.107.140.104]:16992
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727431AbgDCJeM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 3 Apr 2020 05:34:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FkQNtG8FFJH3j6wmtXv3f76b4+Sa7DuEFw4FmAafRWBzctB/MNwmWMNQp0Ov9SH4UZC6fVY2jCu+4YEQ28AQSQSH9R+yhO3S+OlteeaPiL6c7oH2I4B6C59U1qKffzDJnMSie7pb1YaVerVJLxo9XNmVCzr/HWl1D+cKs6tsTz4ljAAc+rI4rFjCIh8pXKS2fmdlhVgY2NvHRhu/Vx53JbPG00WQPO1QNdtVfQ2pjkLtMKyH41GI02IHQv98H/YLZ1xpReR0R8cGsRPbr/CdwQ24o1JvDUehxaH6xsIXfdlHyEBegVhLeY9JzzVOPhVQjTVps4gfa/leukI0kefrCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Q0ZZNr4DLzS67OgT1NktvakbNWvY8eyFbLlNpoRT74=;
 b=ZdeP5i87w/0NK4Ln2DuKaXyKiceOmzUROptkfBLYH4DUHqBfR17svm04ybyrNOzy4Nbcs30Y7nD366k7QNKGn0qZEJOaWSknGA044E9bBW7lLw9ugAdnURr0omO5r9IemMHnS1dW9Jur/RhSmtqUcF1qhcR8G/5v7ftEId0A43jtcj2VwVFj3s2dwaOwxNtdYq73V86tRNENZ3vuN+UEBSeR/wivFMPsQ6ufxlUsltsb4cdVkFg8f3yNqV2wL/0XcYCL74HVdIPuXe4L1ollijxOT93pl/l8BUW5+gbjeiE9jh/bgq49Jc63/FCcMl9CcYtHkiuEg9ZiMUx/0fSlyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Q0ZZNr4DLzS67OgT1NktvakbNWvY8eyFbLlNpoRT74=;
 b=pFKc3PVL+e7U7841I8KRY4QY+kqJblygoEEIJOMTzBCW4ynoN3gn4OIZihEl8Lmi+QWnrvEJKHKmteeApQRvb/YPmCA+l57lP8n6YihO0LJObu6X+GwdTfGM4AejZm8U9LOvJ5J97RrFdCOboHTu/Ms0rnRAcK/qnDOZYtgrLEY=
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com (20.179.175.203) by
 TYAPR01MB4192.jpnprd01.prod.outlook.com (20.178.136.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.15; Fri, 3 Apr 2020 09:34:07 +0000
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::ed7f:1268:55a9:fc06]) by TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::ed7f:1268:55a9:fc06%4]) with mapi id 15.20.2878.017; Fri, 3 Apr 2020
 09:34:07 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
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
Thread-Index: AQHWCSZxsnMUaMwx50Sb61CF2skZ+6hnC2TAgAASGQCAAABowA==
Date:   Fri, 3 Apr 2020 09:34:06 +0000
Message-ID: <TYAPR01MB4544D205BE659CE74205737CD8C70@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <1585856319-4380-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1585856319-4380-7-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <TYAPR01MB45442959B9FD7299D2CB8D73D8C70@TYAPR01MB4544.jpnprd01.prod.outlook.com>
 <OSBPR01MB3590260FDE8EA7D3701EAE2FAAC70@OSBPR01MB3590.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB3590260FDE8EA7D3701EAE2FAAC70@OSBPR01MB3590.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [124.210.22.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 14c564ea-5d2a-4caf-e03e-08d7d7b227fc
x-ms-traffictypediagnostic: TYAPR01MB4192:|TYAPR01MB4192:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB419216F99C3AF786DD4C9051D8C70@TYAPR01MB4192.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0362BF9FDB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB4544.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(39860400002)(376002)(136003)(396003)(366004)(346002)(55236004)(71200400001)(8676002)(316002)(33656002)(110136005)(54906003)(4326008)(6506007)(52536014)(2906002)(7416002)(478600001)(64756008)(81166006)(186003)(76116006)(66556008)(7696005)(8936002)(86362001)(81156014)(55016002)(5660300002)(66946007)(66446008)(9686003)(26005)(66476007)(921003)(1121003);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oABY1w/+on73vfTxhWJtSAT0zQQsC0vBaumCRukPnbzJx0YreBUFWzVIhRe3YipqGTjoSff6by6FuvHh4yJcYMyyCqjFNfOYKJ5rjWxqe7j4FT4h7d9ESefDe9Xtos/YZnjI2uf7OWWJ4dfT434AlOKGVhXS4LKbW0LKzuEnVoR5JDKxMXtxCTKoKGL21IhOxQO/l2eWInF5gwx1oSD1ssn6Rb9ACPhM/D74VQAQA1ky9qr9I+sabln9btbcn/Hw9trkihHETEpqGinxbkwwY/js2zF9uezuhQL5CJ04jrFcUjtwrOe+gJlrDU6uBu5eeaGW3I/6lTjd4kMxfcVt1HOdyDJ3U+dBHIC4MONylMckoVC0JnFDruSDdLMxsHoM1kYn1j1mBb97aRCe1/sa4wdT8LesGT8OZ3fACxlTTAGFeUyKANsBMHnSRM27cUgfEjnvUpERn6/HOTCg4xjsC0J1eJJHSnMMGXvve9pXaVEHwfPNopv3VZhg6uYviKF8
x-ms-exchange-antispam-messagedata: EbUYOefpxeYBXHJ5qmX3DHhGrY6PNzTmYTmZRq+Ipd2d+wJicWmuIcfKherpaFg+Ts2aDjeF2kzXkJuNQhXZKJWwrIvPpfHSsaxckgL8s8b4HT7Z0DVGykmoxzyOhCI7X3ZVG+HYu+WTFeaCf2Jfkw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14c564ea-5d2a-4caf-e03e-08d7d7b227fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2020 09:34:06.9290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: js1mjLIwWph3fzEtKcmfH6LyGwc/tJ20CN+iahlX+MkGZWQ51Lvj1X1Fgg/8ExsVxopTszQoTz+WP5Q8wE70ArFwjWQxsP3hZk4IX+5cCYs4rNN4aFEHh/Rw2BGaSqNR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4192
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Prabhakar-san,

> From: Prabhakar Mahadev Lad, Sent: Friday, April 3, 2020 6:12 PM
<snip>
> > > @@ -122,31 +167,56 @@ EXPORT_SYMBOL_GPL(pci_epc_mem_exit);
> > >  void __iomem *pci_epc_mem_alloc_addr(struct pci_epc *epc,
> > >  				     phys_addr_t *phys_addr, size_t size)
> > >  {
> > > -	int pageno;
> > >  	void __iomem *virt_addr =3D NULL;
> > > -	struct pci_epc_mem *mem =3D epc->mem;
> > > -	unsigned int page_shift =3D ilog2(mem->page_size);
> > > +	struct pci_epc_mem *mem;
> > > +	unsigned int page_shift;
> > > +	int pageno =3D -EINVAL;
> > >  	int order;
> > > +	int i;
> > >
> > > -	size =3D ALIGN(size, mem->page_size);
> > > -	order =3D pci_epc_mem_get_order(mem, size);
> > > -
> > > -	mutex_lock(&mem->lock);
> > > -	pageno =3D bitmap_find_free_region(mem->bitmap, mem->pages, order);
> > > -	if (pageno < 0)
> > > -		goto ret;
> > > +	for (i =3D 0; i < epc->num_windows; i++) {
> > > +		mem =3D epc->windows[i];
> > > +		mutex_lock(&mem->lock);
> >
> > This is my feeling though, calling mutex_lock() in the loop seems
> > to cause overhead. And, if we call mutex_lock() at out-of the loop,
> > I think we can write single mutex_unlock() calling.
> >
> But the mutex is for each window, are you suggesting to add a global mute=
x ?

Oops, that's right. So, I'd like to recall.

> > > +		size =3D ALIGN(size, mem->window.page_size);
> >
> > I'm sorry I should have realized this in the previous review,
> > but overwriting this size is possible to cause an issue at second time =
or more loops.
> > So, the first argument of ALIGN should be kept for the loop.
> >
> Could you please elaborate on this.

My concern is the following.

For example, the size of argument of pci_epc_mem_alloc_addr() is 4096.
epc->windows[0].window.page_size =3D 8192
 --> then the size will be changed to 0.

epc->windows[1].window.page_size =3D 4096
 --> since the size was changed to 0 on the first loop, the result is 0.
     But, this should be 4096.

Does such a case never happen?
(Or, is my understanding incorrect?)

Best regards,
Yoshihiro Shimoda


> > > +		order =3D pci_epc_mem_get_order(mem, size);
> > >
> > > -	*phys_addr =3D mem->phys_base + ((phys_addr_t)pageno << page_shift)=
;
> > > -	virt_addr =3D ioremap(*phys_addr, size);
> > > -	if (!virt_addr)
> > > -		bitmap_release_region(mem->bitmap, pageno, order);
> > > +		pageno =3D bitmap_find_free_region(mem->bitmap, mem->pages,
> > > +						 order);
> > > +		if (pageno >=3D 0) {
> > > +			page_shift =3D ilog2(mem->window.page_size);
> > > +			*phys_addr =3D mem->window.phys_base +
> > > +				((phys_addr_t)pageno << page_shift);
> > > +			virt_addr =3D ioremap(*phys_addr, size);
> > > +			if (!virt_addr)
> > > +				bitmap_release_region(mem->bitmap,
> > > +						      pageno, order);
> > > +			mutex_unlock(&mem->lock);
> > > +			return virt_addr;
> >
> > As I mentioned above, if mutex_lock() is called at out-of-loop,
> > we can use "goto ret;" here like the original code,
> >
> > > +		}
> > > +		mutex_unlock(&mem->lock);
> >
> > and we can remove this.
> >
> > > +	}
> > >
> > > -ret:
> > > -	mutex_unlock(&mem->lock);
> > >  	return virt_addr;
> > >  }
> > >  EXPORT_SYMBOL_GPL(pci_epc_mem_alloc_addr);
> > >
> > > +struct pci_epc_mem *pci_epc_get_matching_window(struct pci_epc *epc,
> > > +						phys_addr_t phys_addr)
> > > +{
> > > +	struct pci_epc_mem *mem;
> > > +	int i;
> > > +
> > > +	for (i =3D 0; i < epc->num_windows; i++) {
> > > +		mem =3D epc->windows[i];
> > > +
> > > +		if (phys_addr >=3D mem->window.phys_base &&
> > > +		    phys_addr < (mem->window.phys_base + mem->window.size))
> > > +			return mem;
> > > +	}
> > > +
> > > +	return NULL;
> > > +}
> > > +
> > >  /**
> > >   * pci_epc_mem_free_addr() - free the allocated memory address
> > >   * @epc: the EPC device on which memory was allocated
> > > @@ -159,14 +229,23 @@ EXPORT_SYMBOL_GPL(pci_epc_mem_alloc_addr);
> > >  void pci_epc_mem_free_addr(struct pci_epc *epc, phys_addr_t phys_add=
r,
> > >  			   void __iomem *virt_addr, size_t size)
> > >  {
> > > +	struct pci_epc_mem *mem;
> > > +	unsigned int page_shift;
> > > +	size_t page_size;
> > >  	int pageno;
> > > -	struct pci_epc_mem *mem =3D epc->mem;
> > > -	unsigned int page_shift =3D ilog2(mem->page_size);
> > >  	int order;
> > >
> > > +	mem =3D pci_epc_get_matching_window(epc, phys_addr);
> > > +	if (!mem) {
> > > +		pr_err("failed to get matching window\n");
> > > +		return;
> > > +	}
> > > +
> > > +	page_size =3D mem->window.page_size;
> > > +	page_shift =3D ilog2(page_size);
> > >  	iounmap(virt_addr);
> > > -	pageno =3D (phys_addr - mem->phys_base) >> page_shift;
> > > -	size =3D ALIGN(size, mem->page_size);
> > > +	pageno =3D (phys_addr - mem->window.phys_base) >> page_shift;
> > > +	size =3D ALIGN(size, page_size);
> > >  	order =3D pci_epc_mem_get_order(mem, size);
> > >  	mutex_lock(&mem->lock);
> > >  	bitmap_release_region(mem->bitmap, pageno, order);
> > > diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> > > index e0ed9d01f6e5..d5da11cf0f2a 100644
> > > --- a/include/linux/pci-epc.h
> > > +++ b/include/linux/pci-epc.h
> > > @@ -65,20 +65,28 @@ struct pci_epc_ops {
> > >  	struct module *owner;
> > >  };
> > >
> > > +/**
> > > + * struct pci_epc_mem_window - address window of the endpoint contro=
ller
> > > + * @phys_base: physical base address of the PCI address window
> > > + * @size: the size of the PCI address window
> > > + * @page_size: size of each page
> > > + */
> > > +struct pci_epc_mem_window {
> > > +	phys_addr_t	phys_base;
> > > +	size_t		size;
> > > +	size_t		page_size;
> > > +};
> > > +
> > >  /**
> > >   * struct pci_epc_mem - address space of the endpoint controller
> > > - * @phys_base: physical base address of the PCI address space
> > > - * @size: the size of the PCI address space
> > > + * @window: address window of the endpoint controller
> > >   * @bitmap: bitmap to manage the PCI address space
> > > - * @pages: number of bits representing the address region
> > > - * @page_size: size of each page
> > >   * @lock: mutex to protect bitmap
> > > + * @pages: number of bits representing the address region
> >
> > Perhaps, we should not change the "@pages" line.
> >
> OK will drop this change.
>=20
> Cheers,
> --Prabhakar
>=20
> > Best regards,
> > Yoshihiro Shimoda

