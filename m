Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBB419D210
	for <lists+linux-pci@lfdr.de>; Fri,  3 Apr 2020 10:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbgDCIXH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Apr 2020 04:23:07 -0400
Received: from mail-eopbgr1400118.outbound.protection.outlook.com ([40.107.140.118]:15004
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390500AbgDCIXG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 3 Apr 2020 04:23:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ChfcYv78eevv4PZmlPOXsOtYTrer59LB/9zzARi88W3wSIT5xTyTeN3Utu/FklO9ktnDxOIq6T7COEOb6/jrUTcedq2OsuIxiMbZ5wRMMopf4wXPmk5pNYleZ82sF96T+2krFvKi4SR/0aq8x/5b+0mRZoQCSHCzD+j483k9whit0hY97AEIYIWn3qFvxeEHi7uiMfUFO4jw4G2Rsud07N1CaksAHIZ1UqXvrmEbkDacHECOEGoXV04sisdwShAjvvSYX5uEmgaAVdCQdZcpNGMymLnmojwlPQwgxgytfERmwRLMlJnhW6hROwVwWyZtVamVZbIZx3QH0wfYTfz6Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGvyEbhqf0qyOFT/7/TP4FzUlZi+KYl/sQd7h7dKTwg=;
 b=MhTSXuWz92PHvQpNKjTvoAKmsyGqX68nkFY7trQc5ikR99FYHJwqVFMLaptM3yfxAUQ9O9xpEQuic4Jo+wLv4C2XoDq7adXkZtbF8s6eZnnpPQrBY5A4lZSLgASihPcjuoOmd9mOLdMr/jiXLpOVVwMrhkEoGzeXihqEgj7dYAOgdfVoKwM763Xo11uXV31k6gPpQlfFuWuLZdg6P43+N1XKem8w4Uh0hQka6KdbjALQHbzmsr+1RMpvxQvvHzGSEFHbwh2caVTh9ty4blj8InJaJQz0jRZal2lLG00g1UnU7RcnnUopBTbqNPMspTyDbYGXNJU5/0MeraeDgf2lXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGvyEbhqf0qyOFT/7/TP4FzUlZi+KYl/sQd7h7dKTwg=;
 b=Sayg3KkmjRbawCTFwIS+qJg0cSs57CHxgeXT1EqBmVWCCD6CowCAfUSap1977YH6SUVBxXX9Bz9Qgv4I4wVUpZKAvr5NXc+0Bf9Wbh9T0MBbVoXye0TPjIRUGlGc8O2Favv3oG9thqAmomQhc/p7PYr0yR0CrEVnxd2Iz0qBV6Y=
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com (20.179.175.203) by
 TYAPR01MB5484.jpnprd01.prod.outlook.com (20.180.229.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.15; Fri, 3 Apr 2020 08:23:02 +0000
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::ed7f:1268:55a9:fc06]) by TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::ed7f:1268:55a9:fc06%4]) with mapi id 15.20.2878.017; Fri, 3 Apr 2020
 08:23:02 +0000
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
        Lad Prabhakar <prabhakar.csengg@gmail.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v6 06/11] PCI: endpoint: Add support to handle multiple
 base for mapping outbound memory
Thread-Topic: [PATCH v6 06/11] PCI: endpoint: Add support to handle multiple
 base for mapping outbound memory
Thread-Index: AQHWCSZxsnMUaMwx50Sb61CF2skZ+6hnC2TA
Date:   Fri, 3 Apr 2020 08:23:02 +0000
Message-ID: <TYAPR01MB45442959B9FD7299D2CB8D73D8C70@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <1585856319-4380-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1585856319-4380-7-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1585856319-4380-7-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [124.210.22.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8f2a7999-066b-46c5-5365-08d7d7a83a44
x-ms-traffictypediagnostic: TYAPR01MB5484:|TYAPR01MB5484:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB5484113B8E990871C9B527F9D8C70@TYAPR01MB5484.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0362BF9FDB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB4544.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(64756008)(66946007)(66476007)(66446008)(6506007)(2906002)(76116006)(8676002)(55236004)(71200400001)(7696005)(66556008)(54906003)(110136005)(9686003)(81166006)(81156014)(86362001)(26005)(186003)(55016002)(478600001)(4326008)(33656002)(52536014)(7416002)(316002)(8936002)(5660300002)(107886003)(921003)(1121003);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IcPBzgJ/JYU42AePfmb8DD4OWFUwR5NPn/dXHoQ3B86kuwH1m0m+blBxsPfNTBIEVB1XPossB6K+0wrjrGIi9L4hetCkM2gikmTc1SdHP8PhF+MkFylYU9Bmdf88owaSorcuD18pm00KZTHbxIJCmIxGvd6H9+xVaph3plbYdoO61NDRm0yZxKuKDh6yDcKjWew6DvSEsf8BTusLqUL0OhhbP9gpQ9lbu0f6nrI3WPSSDhh9VRNvw7IF8Ws4xwRcK+WjMlxvUWaZPjpVvxYcripIQJbWKvh8N7y6sgiYGEk8yjWNLIq59kfR8KT1gsBav7WEDy8R8ynU0z/hbd9rNiAOnRyUnXEEpbWG5PQu3xLjAFq2t0f9f6+gn+UhJnKD7etJUy9lDdSGp2+S00AiJqBo0fvRknnbCevGu4kZUSp8u+70nPD19oxod5r920XN6rXcUQpYXlImME0knB0EmyMoPL8w8LDUUsgSD1gYsHjgYh3gm4EZR6+JVEHpOFJk
x-ms-exchange-antispam-messagedata: unVehdxk5f6RyEL7GkNCaxU9DNmVK9aBFZ8YP8/r3zhBIL2WH74VNaLzbzbDK0lBWr3hubeoPinw0YEIBaGaj+UVEcXdzITha5syV3KLq5AG1DCI7uZwAjyhz4TXuKBZZSW+i2cpZ/vVv9M6couYIg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f2a7999-066b-46c5-5365-08d7d7a83a44
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2020 08:23:02.6239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ytYDVHqRIeJc44AAupBX0nWvvtAuIQENHQTGa8LLPFB45jgzDaOupkput9nStgY2iQlstLIUgjxYZiL/G8qrUhGioNz9USbpm0+rlkWXkOAzhA5WaH6iLR27z8LHbQzZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5484
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Prabhakar-san,

Thank you for the patch!

> From: Lad Prabhakar, Sent: Friday, April 3, 2020 4:39 AM
>=20
> R-Car PCIe controller has support to map multiple memory regions for
> mapping the outbound memory in local system also the controller limits
> single allocation for each region (that is, once a chunk is used from the
> region it cannot be used to allocate a new one). This features inspires t=
o
> add support for handling multiple memory bases in endpoint framework.
>=20
> With this patch pci_epc_mem_init() initializes address space for endpoint
> controller which support single window and whereas __pci_epc_mem_init()
> now accepts pointer to multiple windows supported by endpoint controller.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> @@ -38,61 +38,95 @@ static int pci_epc_mem_get_order(struct pci_epc_mem *=
mem, size_t size)
>  /**
>   * __pci_epc_mem_init() - initialize the pci_epc_mem structure
>   * @epc: the EPC device that invoked pci_epc_mem_init
> - * @phys_base: the physical address of the base
> - * @size: the size of the address space
> - * @page_size: size of each page
> + * @windows: pointer to windows supported by the device
> + * @num_windows: number of windows device supports
>   *
>   * Invoke to initialize the pci_epc_mem structure used by the
>   * endpoint functions to allocate mapped PCI address.
>   */
> -int __pci_epc_mem_init(struct pci_epc *epc, phys_addr_t phys_base, size_=
t size,
> -		       size_t page_size)
> +int __pci_epc_mem_init(struct pci_epc *epc, struct pci_epc_mem_window *w=
indows,
> +		       unsigned int num_windows)
>  {
> -	int ret;
> -	struct pci_epc_mem *mem;
> -	unsigned long *bitmap;
> +	struct pci_epc_mem *mem =3D NULL;
> +	unsigned long *bitmap =3D NULL;
>  	unsigned int page_shift;
> -	int pages;
> +	size_t page_size;
>  	int bitmap_size;
> +	int pages;
> +	int ret;
> +	int i;
>=20
> -	if (page_size < PAGE_SIZE)
> -		page_size =3D PAGE_SIZE;
> +	epc->num_windows =3D 0;
>=20
> -	page_shift =3D ilog2(page_size);
> -	pages =3D size >> page_shift;
> -	bitmap_size =3D BITS_TO_LONGS(pages) * sizeof(long);
> +	if (!windows || !num_windows)
> +		return -EINVAL;
>=20
> -	mem =3D kzalloc(sizeof(*mem), GFP_KERNEL);
> -	if (!mem) {
> -		ret =3D -ENOMEM;
> -		goto err;
> -	}
> +	epc->windows =3D kcalloc(num_windows, sizeof(*mem), GFP_KERNEL);
> +	if (!epc->windows)
> +		return -ENOMEM;
>=20
> -	bitmap =3D kzalloc(bitmap_size, GFP_KERNEL);
> -	if (!bitmap) {
> -		ret =3D -ENOMEM;
> -		goto err_mem;
> -	}
> +	for (i =3D 0; i < num_windows; i++) {
> +		page_size =3D windows[i].page_size;
> +		if (page_size < PAGE_SIZE)
> +			page_size =3D PAGE_SIZE;
> +		page_shift =3D ilog2(page_size);
> +		pages =3D windows[i].size >> page_shift;
> +		bitmap_size =3D BITS_TO_LONGS(pages) * sizeof(long);
> +
> +		mem =3D kzalloc(sizeof(*mem), GFP_KERNEL);
> +		if (!mem) {
> +			ret =3D -ENOMEM;
> +			i -=3D 1;

nit: We can use i--;

> +			goto err_mem;
> +		}
> +
> +		bitmap =3D kzalloc(bitmap_size, GFP_KERNEL);
> +		if (!bitmap) {
> +			ret =3D -ENOMEM;
> +			kfree(mem);
> +			i -=3D 1;

nit: We can use i--;

<snip>
> @@ -122,31 +167,56 @@ EXPORT_SYMBOL_GPL(pci_epc_mem_exit);
>  void __iomem *pci_epc_mem_alloc_addr(struct pci_epc *epc,
>  				     phys_addr_t *phys_addr, size_t size)
>  {
> -	int pageno;
>  	void __iomem *virt_addr =3D NULL;
> -	struct pci_epc_mem *mem =3D epc->mem;
> -	unsigned int page_shift =3D ilog2(mem->page_size);
> +	struct pci_epc_mem *mem;
> +	unsigned int page_shift;
> +	int pageno =3D -EINVAL;
>  	int order;
> +	int i;
>=20
> -	size =3D ALIGN(size, mem->page_size);
> -	order =3D pci_epc_mem_get_order(mem, size);
> -
> -	mutex_lock(&mem->lock);
> -	pageno =3D bitmap_find_free_region(mem->bitmap, mem->pages, order);
> -	if (pageno < 0)
> -		goto ret;
> +	for (i =3D 0; i < epc->num_windows; i++) {
> +		mem =3D epc->windows[i];
> +		mutex_lock(&mem->lock);

This is my feeling though, calling mutex_lock() in the loop seems
to cause overhead. And, if we call mutex_lock() at out-of the loop,
I think we can write single mutex_unlock() calling.

> +		size =3D ALIGN(size, mem->window.page_size);

I'm sorry I should have realized this in the previous review,
but overwriting this size is possible to cause an issue at second time or m=
ore loops.
So, the first argument of ALIGN should be kept for the loop.

> +		order =3D pci_epc_mem_get_order(mem, size);
>=20
> -	*phys_addr =3D mem->phys_base + ((phys_addr_t)pageno << page_shift);
> -	virt_addr =3D ioremap(*phys_addr, size);
> -	if (!virt_addr)
> -		bitmap_release_region(mem->bitmap, pageno, order);
> +		pageno =3D bitmap_find_free_region(mem->bitmap, mem->pages,
> +						 order);
> +		if (pageno >=3D 0) {
> +			page_shift =3D ilog2(mem->window.page_size);
> +			*phys_addr =3D mem->window.phys_base +
> +				((phys_addr_t)pageno << page_shift);
> +			virt_addr =3D ioremap(*phys_addr, size);
> +			if (!virt_addr)
> +				bitmap_release_region(mem->bitmap,
> +						      pageno, order);
> +			mutex_unlock(&mem->lock);
> +			return virt_addr;

As I mentioned above, if mutex_lock() is called at out-of-loop,
we can use "goto ret;" here like the original code,

> +		}
> +		mutex_unlock(&mem->lock);

and we can remove this.

> +	}
>=20
> -ret:
> -	mutex_unlock(&mem->lock);
>  	return virt_addr;
>  }
>  EXPORT_SYMBOL_GPL(pci_epc_mem_alloc_addr);
>=20
> +struct pci_epc_mem *pci_epc_get_matching_window(struct pci_epc *epc,
> +						phys_addr_t phys_addr)
> +{
> +	struct pci_epc_mem *mem;
> +	int i;
> +
> +	for (i =3D 0; i < epc->num_windows; i++) {
> +		mem =3D epc->windows[i];
> +
> +		if (phys_addr >=3D mem->window.phys_base &&
> +		    phys_addr < (mem->window.phys_base + mem->window.size))
> +			return mem;
> +	}
> +
> +	return NULL;
> +}
> +
>  /**
>   * pci_epc_mem_free_addr() - free the allocated memory address
>   * @epc: the EPC device on which memory was allocated
> @@ -159,14 +229,23 @@ EXPORT_SYMBOL_GPL(pci_epc_mem_alloc_addr);
>  void pci_epc_mem_free_addr(struct pci_epc *epc, phys_addr_t phys_addr,
>  			   void __iomem *virt_addr, size_t size)
>  {
> +	struct pci_epc_mem *mem;
> +	unsigned int page_shift;
> +	size_t page_size;
>  	int pageno;
> -	struct pci_epc_mem *mem =3D epc->mem;
> -	unsigned int page_shift =3D ilog2(mem->page_size);
>  	int order;
>=20
> +	mem =3D pci_epc_get_matching_window(epc, phys_addr);
> +	if (!mem) {
> +		pr_err("failed to get matching window\n");
> +		return;
> +	}
> +
> +	page_size =3D mem->window.page_size;
> +	page_shift =3D ilog2(page_size);
>  	iounmap(virt_addr);
> -	pageno =3D (phys_addr - mem->phys_base) >> page_shift;
> -	size =3D ALIGN(size, mem->page_size);
> +	pageno =3D (phys_addr - mem->window.phys_base) >> page_shift;
> +	size =3D ALIGN(size, page_size);
>  	order =3D pci_epc_mem_get_order(mem, size);
>  	mutex_lock(&mem->lock);
>  	bitmap_release_region(mem->bitmap, pageno, order);
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index e0ed9d01f6e5..d5da11cf0f2a 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
> @@ -65,20 +65,28 @@ struct pci_epc_ops {
>  	struct module *owner;
>  };
>=20
> +/**
> + * struct pci_epc_mem_window - address window of the endpoint controller
> + * @phys_base: physical base address of the PCI address window
> + * @size: the size of the PCI address window
> + * @page_size: size of each page
> + */
> +struct pci_epc_mem_window {
> +	phys_addr_t	phys_base;
> +	size_t		size;
> +	size_t		page_size;
> +};
> +
>  /**
>   * struct pci_epc_mem - address space of the endpoint controller
> - * @phys_base: physical base address of the PCI address space
> - * @size: the size of the PCI address space
> + * @window: address window of the endpoint controller
>   * @bitmap: bitmap to manage the PCI address space
> - * @pages: number of bits representing the address region
> - * @page_size: size of each page
>   * @lock: mutex to protect bitmap
> + * @pages: number of bits representing the address region

Perhaps, we should not change the "@pages" line.

Best regards,
Yoshihiro Shimoda

