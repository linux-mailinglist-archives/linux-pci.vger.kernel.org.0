Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0CE1B0530
	for <lists+linux-pci@lfdr.de>; Mon, 20 Apr 2020 11:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbgDTJEL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Apr 2020 05:04:11 -0400
Received: from mail-eopbgr1410131.outbound.protection.outlook.com ([40.107.141.131]:61401
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725773AbgDTJEG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 20 Apr 2020 05:04:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KI33g9xZBgHKaW5voW69jTw0gIidmq43HfdrX6QMYgXFNfwybamzIX+n8FZCI2BXJV6c+Z4E3AU9k//W+xZr4GAFjPuIfiK7MEwSjc7S8pTo9HRT/mOw+YxhXyuOw9J4aJpK/jw95zrY/gw1TjKLgwHIWtLmfe8hipmzJmbGE6NktHcArgIktQ8zhX5n/smQEFA7EmRNuCUsqtvkzONodNX8zkRcLWZWlOpBFKp9BJLew7347v/Q7iU+wSYtmd8q0PeaG6hIMS/mALstP6m3HHrj4dL8FjnitGWYWf3/ihe3EaRCL4B3TUMfn9xt7mfyQwyCS3dZk6XJnXcEK8hwYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7TGHtjA5Z7WbIVqJ1NdRUTSyiYds1CA/1Sub6kW+AsM=;
 b=dnLClVAWCWhhrPRoYohHDdI84YSchTRAEHy6ZF1laXTQ63irMmy11fNqP5eQ/XH7BKZ9Chz9edBP3yzbLMZUCH5CZvaWiJ6P9a5unQrRHI1dvrAlzxgJfBj6GAYOVaOs2shUsD9iYxZX8Z47zSTca5q/QrRTGNofW9P+4l7Zc67Tgfi3S8EhAE4KpjlPNVRKc1IoPsh1Dsk1hA2+3KW4n/k2evCsA86Kvz/rfh7mGqb/f8SipzkuWmeLsAgvN5XndjcgH94lg1oaLSenOWjaySWG7kap3JiMxhIBHn357FVo6U9gIRAX7zJh8cPVjZ6XIvs1mlZxQjE8WW3xrjF7/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7TGHtjA5Z7WbIVqJ1NdRUTSyiYds1CA/1Sub6kW+AsM=;
 b=pwDDKyOF1YoAfw1ZG+LryRjLQgwFZFnHHsIIj76nl4cD6qnLApYcMgWdkcxbeK+C//xC+dFdMvPH87YqeZGUceeNuZ2ptHsCFJh98kwFN55FXzLJSeXnMhL7JU66dOFWYqK5Ik3PIrIL9nf3g3dPBaHVbV4SEk6KAoB7nEAS1SY=
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com (20.179.175.203) by
 TYAPR01MB2605.jpnprd01.prod.outlook.com (20.177.103.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.26; Mon, 20 Apr 2020 09:04:00 +0000
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::ed7f:1268:55a9:fc06]) by TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::ed7f:1268:55a9:fc06%4]) with mapi id 15.20.2921.027; Mon, 20 Apr 2020
 09:04:00 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Tom Joseph <tjoseph@cadence.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>
CC:     Geert Uytterhoeven <geert+renesas@glider.be>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Lad Prabhakar <prabhakar.csengg@gmail.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v8 5/8] PCI: endpoint: Add support to handle multiple base
 for mapping outbound memory
Thread-Topic: [PATCH v8 5/8] PCI: endpoint: Add support to handle multiple
 base for mapping outbound memory
Thread-Index: AQHWFk5NxeIeMSjSVEWc7YIINcCN9KiBtnxg
Date:   Mon, 20 Apr 2020 09:04:00 +0000
Message-ID: <TYAPR01MB4544FDF2FEDBED104F6C6C45D8D40@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <1587302823-4435-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1587302823-4435-6-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1587302823-4435-6-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [124.210.22.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 29289b9f-751e-47cc-7a2c-08d7e509c438
x-ms-traffictypediagnostic: TYAPR01MB2605:|TYAPR01MB2605:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB26058622ED10DD7BFE47D86AD8D40@TYAPR01MB2605.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 03793408BA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB4544.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(396003)(376002)(346002)(39860400002)(366004)(136003)(55016002)(107886003)(9686003)(33656002)(4326008)(76116006)(52536014)(64756008)(66556008)(66476007)(66946007)(186003)(55236004)(26005)(6506007)(7696005)(66446008)(316002)(54906003)(8676002)(81156014)(8936002)(110136005)(2906002)(5660300002)(478600001)(86362001)(71200400001)(7416002)(921003);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tuuphgj5ozXh/JagCacIiYpiQHopSrB44vp7l4QbKFcfeL/cyfeYcrdVsVhBfvUWgwp8B7uRcq0k9jAGi/NBNdA8OASsTMuIYmr7ljnxK5kkMy63/VKrTapfgM4qphbExzhVKMEwwlX3d3Vr0OVxBTJNVvKeDs/Mg+seaAaYsbcvVMMM3Rsbrgk2jKKZcLFZMcATuCjd7cwyXEI0enm9q3Cx76X76BiYUuMw4+m7NaGEFb2o0uJjWd15C1ie8Hzfql98tG/wCNoPLvHWXbIc0QHX8w6XlOQvDIENA3YK+CvHhJLwEITKhizoWIt4FwrvBvi0i065aw1xm4iA8gNuH44lqLU95eGTdf2O44gSafTZKaZ+HqdOEREZ90atDXFcDwaur4p+qBhBkd2ZDrtsm+AAIhT4Id5f1uuAXB3psvO2b1WcE7Q5GDn2ftDBbgdfEBDMobrGDJTcGsFhvDDiV2zwTYXNn0Wu+ZDxKTjMhFg=
x-ms-exchange-antispam-messagedata: B5753voFyj56JAbim634rYGLx2IMGOn8IXdCWRgzA3Z+9c8F7FwlwMUzg9V5ysP5+N+GfYD3l2x0S5dkmKn0BIkNU38qvvl9QK35wxzWHz958W0ZHuMKYu6v/3qvoxXDjUha0eKNgoED+8nMK0qUXQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29289b9f-751e-47cc-7a2c-08d7e509c438
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2020 09:04:00.4087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D0AmiTVgX7RGN8P+dRYr045sJi9aVmMWAqWSjsZUPEBseyxbxCgZS+H4qZOTutGa0QupR4Up3qUed9Sf5UcFE0FX3uR444mfGB1aKq5jhqkZCP5Ma4d1K4EuM2zr95rJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2605
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Prabhakar-san,

Thank you for the patch!

> From: Lad Prabhakar, Sent: Sunday, April 19, 2020 10:27 PM
<snip>
> @@ -109,11 +137,22 @@ EXPORT_SYMBOL_GPL(pci_epc_mem_init);
>   */
>  void pci_epc_mem_exit(struct pci_epc *epc)
>  {
> -	struct pci_epc_mem *mem =3D epc->mem;
> +	struct pci_epc_mem *mem;
> +	int i;
>=20
> +	if (!epc->num_windows)
> +		return;
> +
> +	for (i =3D 0; i <=3D epc->num_windows; i++) {

I'm sorry, I overlooked when I reviewed before.
This condition should be "i < epc->num_windows".

> +		mem =3D epc->windows[i];
> +		kfree(mem->bitmap);
> +		kfree(mem);
> +	}
> +	kfree(epc->windows);
> +
> +	epc->windows =3D NULL;
>  	epc->mem =3D NULL;
> -	kfree(mem->bitmap);
> -	kfree(mem);
> +	epc->num_windows =3D 0;
>  }
>  EXPORT_SYMBOL_GPL(pci_epc_mem_exit);
>=20
> @@ -129,31 +168,57 @@ EXPORT_SYMBOL_GPL(pci_epc_mem_exit);
>  void __iomem *pci_epc_mem_alloc_addr(struct pci_epc *epc,
>  				     phys_addr_t *phys_addr, size_t size)
>  {
> -	int pageno;
>  	void __iomem *virt_addr =3D NULL;
> -	struct pci_epc_mem *mem =3D epc->mem;
> -	unsigned int page_shift =3D ilog2(mem->page_size);
> +	struct pci_epc_mem *mem;
> +	unsigned int page_shift;
> +	size_t align_size;
> +	int pageno;
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
> +		align_size =3D ALIGN(size, mem->window.page_size);
> +		order =3D pci_epc_mem_get_order(mem, align_size);
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
> +			virt_addr =3D ioremap(*phys_addr, align_size);
> +			if (!virt_addr)
> +				bitmap_release_region(mem->bitmap,
> +						      pageno, order);

I'm sorry here again. But, I think we should call mutex_unlock() and "conti=
nue;"
here if ioremap() failed for trying remaining windows. What do you think?

> +			mutex_unlock(&mem->lock);
> +			return virt_addr;
> +		}
> +		mutex_unlock(&mem->lock);
> +	}
>=20
> -ret:
> -	mutex_unlock(&mem->lock);
>  	return virt_addr;
>  }
>  EXPORT_SYMBOL_GPL(pci_epc_mem_alloc_addr);

Best regards,
Yoshihiro Shimoda

