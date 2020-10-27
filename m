Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 868CC29AC1A
	for <lists+linux-pci@lfdr.de>; Tue, 27 Oct 2020 13:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899859AbgJ0Mar (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Oct 2020 08:30:47 -0400
Received: from mail-eopbgr150070.outbound.protection.outlook.com ([40.107.15.70]:21990
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2895615AbgJ0Map (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Oct 2020 08:30:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ABhAdVNzT9rEuQMkXNIHJbumE6gzq05kkMI3G6WTUbey6N4QxdpP/xfmUN32Cty3AEvRRB0BS0h1hefW353XCGRT2hS79KLwOR5OOXEzrCVH+2nMYC7VWG74P7UxPGo60VKP8yvhlW4z5ArPUFj5tqLJjJn2BJiDlUaBWBr9aNRJ/3xdSOzJ5W37MbRrmRecwHStxzILokghDhg5dXUVFG74FV3aArX1bm7HPAqmnbqvu3InnOJx0EpMwg4W15AAFM4rHlfUT2tLaKseVrM35Ya3uE+dnkapzOTRxOEPcvnTwuSTmWJAYrQW0QY4WX/iDb1XpCJGrlrdFW8+ifZyKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8OpjQJPqb7IHV93Xjw48jMzy1W8eIvdPCd+P7ZxJ7m4=;
 b=ZL6JwMeD987xYZvbJshnRlvMqUM1eNwVIk5NUVvJAOkGdEzd2k48NYQ6iD+lTI+7c4T4TS8pM04xE3vEZQmyR1GvGw85YBq6E4JgQsM8BSoSJTYlst0Kp05vjVbyTdUAjQE2/RRDLj6AMyNTPXx0HFDSX+kR2ewKXK3fFV1A0LGCw5XZrdE7V2icY5qhRbdBYUIR7IEKGTbo0pFD8CacME8Wm8K4Vm9FjOjyMy+ATK8i31WjDIWSXauNbfwz7hsDC5CjANPFB7MLoS0+TqtCFvflT3mmAb9nfpamvwnMqJVGdtTvF5s2oWR7iFosk/UYrfQ+TbV2VG8jOPMvUwcfwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8OpjQJPqb7IHV93Xjw48jMzy1W8eIvdPCd+P7ZxJ7m4=;
 b=Dnwsg4my0puiOvazF7eskQv9TvYrEf9/WBEfv9795zB84c9R28bfxdIDoMfnrcWtd+vjDuixWh/BrChCqBipfiXM2Qvxyy2JVYzMMnGQOWObB08Kx+3NkbkKyUrP9tvgeJcaX9MaRi2U/XpLXVZToUn+XcV5Fhtw4+UvwTumeLk=
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com (2603:10a6:803:57::21)
 by VI1PR0401MB2399.eurprd04.prod.outlook.com (2603:10a6:800:25::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.25; Tue, 27 Oct
 2020 12:30:35 +0000
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6]) by VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6%3]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 12:30:35 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "sudeep.dutt@intel.com" <sudeep.dutt@intel.com>,
        "ashutosh.dixit@intel.com" <ashutosh.dixit@intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "kishon@ti.com" <kishon@ti.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>, Andy Duan <fugang.duan@nxp.com>
Subject: RE: [PATCH V4 1/2] misc: vop: change the way of allocating vring and
 device page
Thread-Topic: [PATCH V4 1/2] misc: vop: change the way of allocating vring and
 device page
Thread-Index: AQHWq3XB1Alxry1a5EeBjuP0Jr7qZamrREkAgAAczUA=
Date:   Tue, 27 Oct 2020 12:30:35 +0000
Message-ID: <VI1PR04MB49607013A9221E3D3657748492160@VI1PR04MB4960.eurprd04.prod.outlook.com>
References: <20201026085335.30048-1-sherry.sun@nxp.com>
 <20201026085335.30048-2-sherry.sun@nxp.com>
 <20201027104036.GA7054@infradead.org>
In-Reply-To: <20201027104036.GA7054@infradead.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6255fceb-949d-4f30-423b-08d87a741ad1
x-ms-traffictypediagnostic: VI1PR0401MB2399:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0401MB23999E386362DD765884542492160@VI1PR0401MB2399.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1051;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ks2AXMef/irI+eONpyZAYrwcQ9tvrIeEwLeEZtbyGX/DzSh5leiWHRoR4UEglToedDyBSP4IBsDauPZCn4fevLrfhBjDk4wgJPuuIwYl5rvPJOPP7baqs0q9FbY4iGSgjK+1qyhwA44b1VLlY8P+g3OrlnwMIeMaZeiLzY5FuvHkqwCSTGZVbhdgYzE01k4Lvx+jqQLZF6a1hd261+b4zy9LndfN57T6LinqHZXXzjxn6b1VbvxjSNADZuG7RhMj4/m26ew440zd6EXp0GA8L0FXe6eyGy+4FzzmIxM2TeXYdpiWhvFNXfX5T2zej2AMWWZ/8McBRYH2LLxrah3uZg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4960.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(7696005)(66446008)(186003)(52536014)(76116006)(26005)(66556008)(8676002)(54906003)(66946007)(44832011)(64756008)(4326008)(6916009)(83380400001)(498600001)(86362001)(6506007)(2906002)(33656002)(30864003)(55016002)(8936002)(53546011)(9686003)(71200400001)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: ZLgmNca19qElreEZIeBgWR1mXJRVvJuQqMtn+HiDaAW2BwL5EzhE3JHLAJBvsxArsn1VYy9HcNjaXdvWBnZKHwaUJ3pqRRgjHzdvtNv398L1Yc8p+zaTYI8o7emZOdAvJuqnn0WcENSWek4f0DbEPCOAOVhznlqXdwz4sfdqRg9kTXselXZd6Pbr/gSsc7WPlsJbcXJGAYs3snAwJWgU2bXNH6tR6ltdVTMDE5Ua2pin8wXYbv5p1jyBXpOzRTS55jxbeVajErBzaTGokbw+yMlDNr+UcX+yjucLElLTAKa1irjAzmNfIZqKjUsKMG97Z6Ho5AqAxXD9Q9wSOvWj9WiinrrFAjUQQ+9CvH8nVaNg/rjlTGo7s4ns2LUyeupLhERE7rjgJHDrdZoPJ6tg8Wcms3qsHEOnkZ26KT6T+aHIOdUDzxjv1gxTpz08iUsihrJME3oV1xKrOx7HS7wJVzI5hZFZ/qgUsFBoy6bNlo7dIy7m/1m/lNbcK+4tKme8C6jaSDHpkGECmr3ltm+fkioh+6KZpKjPi/R7V1lx1LxhanDs5E1X4rBjCvzTe04JkDJTxhgyAFVWGTRrxyXabiOS56tpzrS+vA5WDK6mwymHJ9ffIixIArYbbBWmHuKvA+MfsjAMraV6OpO4/vs7uQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4960.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6255fceb-949d-4f30-423b-08d87a741ad1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2020 12:30:35.6112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eXnaB/I6Ue6+7pBapakmJjAEhAVbX+qI1KhVxf+RErdKZsMyMpqwof/eVsA6w0faxH2gJs5CSD5vFpm5pFNW8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2399
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Christoph,

Thank you for improving the code. I think your code makes vop_mmap looks cl=
earer.
I have tested it on imx8qm platform(arm64 architecture) and it works well.
I will send the code together in v5.

Best regards
Sherry


> Subject: Re: [PATCH V4 1/2] misc: vop: change the way of allocating vring=
 and
> device page
>=20
> This looks much better, but we need to be careful to restore the original
> vm_start / vm_end.  What do you think about the version below, which also
> simplifies vop_mmap a lot (completely untested):
>=20
> ---
> From 2de72bf7444ee187a7576962d746d482c5bdd593 Mon Sep 17 00:00:00
> 2001
> From: Sherry Sun <sherry.sun@nxp.com>
> Date: Mon, 26 Oct 2020 16:53:34 +0800
> Subject: misc: vop: change the way of allocating vring and device page
>=20
> Allocate vrings use dma_alloc_coherent is a common way in kernel. As the
> memory interacted between two systems should use consistent memory to
> avoid caching effects, same as device page memory.
>=20
> The orginal way use __get_free_pages and dma_map_single to allocate and
> map vring, but not use dma_sync_single_for_cpu/device api to sync the
> changes of vring between EP and RC, which will cause memory
> synchronization problem for those devices which don't support hardware
> dma coherent.
>=20
> Also change to use dma_mmap_coherent for mmap callback to map the
> device page and vring memory to userspace.
>=20
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---
>  drivers/misc/mic/bus/vop_bus.h    |   2 +
>  drivers/misc/mic/host/mic_boot.c  |   9 ++
>  drivers/misc/mic/host/mic_main.c  |  43 +++-------
> drivers/misc/mic/vop/vop_vringh.c | 135 ++++++++++++------------------
>  4 files changed, 77 insertions(+), 112 deletions(-)
>=20
> diff --git a/drivers/misc/mic/bus/vop_bus.h
> b/drivers/misc/mic/bus/vop_bus.h index 4fa02808c1e27d..e21c06aeda7a31
> 100644
> --- a/drivers/misc/mic/bus/vop_bus.h
> +++ b/drivers/misc/mic/bus/vop_bus.h
> @@ -75,6 +75,7 @@ struct vop_driver {
>   *                 node to add/remove/configure virtio devices.
>   * @get_dp: Get access to the virtio device page used by the self
>   *          node to add/remove/configure virtio devices.
> + * @dp_mmap: Map the virtio device page to userspace.
>   * @send_intr: Send an interrupt to the peer node on a specified doorbel=
l.
>   * @remap: Map a buffer with the specified DMA address and length.
>   * @unmap: Unmap a buffer previously mapped.
> @@ -92,6 +93,7 @@ struct vop_hw_ops {
>  	void (*ack_interrupt)(struct vop_device *vpdev, int num);
>  	void __iomem * (*get_remote_dp)(struct vop_device *vpdev);
>  	void * (*get_dp)(struct vop_device *vpdev);
> +	int (*dp_mmap)(struct vop_device *vpdev, struct vm_area_struct
> *vma);
>  	void (*send_intr)(struct vop_device *vpdev, int db);
>  	void __iomem * (*remap)(struct vop_device *vpdev,
>  				  dma_addr_t pa, size_t len);
> diff --git a/drivers/misc/mic/host/mic_boot.c
> b/drivers/misc/mic/host/mic_boot.c
> index 8cb85b8b3e199b..44ed918b49b4d2 100644
> --- a/drivers/misc/mic/host/mic_boot.c
> +++ b/drivers/misc/mic/host/mic_boot.c
> @@ -89,6 +89,14 @@ static void *__mic_get_dp(struct vop_device *vpdev)
>  	return mdev->dp;
>  }
>=20
> +static int __mic_dp_mmap(struct vop_device *vpdev, struct
> +vm_area_struct *vma) {
> +	struct mic_device *mdev =3D vpdev_to_mdev(&vpdev->dev);
> +
> +	return dma_mmap_coherent(&mdev->pdev->dev, vma, mdev->dp,
> +				 mdev->dp_dma_addr, MIC_DP_SIZE);
> +}
> +
>  static void __iomem *__mic_get_remote_dp(struct vop_device *vpdev)  {
>  	return NULL;
> @@ -120,6 +128,7 @@ static struct vop_hw_ops vop_hw_ops =3D {
>  	.ack_interrupt =3D __mic_ack_interrupt,
>  	.next_db =3D __mic_next_db,
>  	.get_dp =3D __mic_get_dp,
> +	.dp_mmap =3D __mic_dp_mmap,
>  	.get_remote_dp =3D __mic_get_remote_dp,
>  	.send_intr =3D __mic_send_intr,
>  	.remap =3D __mic_ioremap,
> diff --git a/drivers/misc/mic/host/mic_main.c
> b/drivers/misc/mic/host/mic_main.c
> index ea4608527ea04d..fab87a72a9a4a5 100644
> --- a/drivers/misc/mic/host/mic_main.c
> +++ b/drivers/misc/mic/host/mic_main.c
> @@ -10,6 +10,7 @@
>  #include <linux/module.h>
>  #include <linux/pci.h>
>  #include <linux/poll.h>
> +#include <linux/dma-mapping.h>
>=20
>  #include <linux/mic_common.h>
>  #include "../common/mic_dev.h"
> @@ -45,33 +46,6 @@ MODULE_DEVICE_TABLE(pci, mic_pci_tbl);
>  /* ID allocator for MIC devices */
>  static struct ida g_mic_ida;
>=20
> -/* Initialize the device page */
> -static int mic_dp_init(struct mic_device *mdev) -{
> -	mdev->dp =3D kzalloc(MIC_DP_SIZE, GFP_KERNEL);
> -	if (!mdev->dp)
> -		return -ENOMEM;
> -
> -	mdev->dp_dma_addr =3D mic_map_single(mdev,
> -		mdev->dp, MIC_DP_SIZE);
> -	if (mic_map_error(mdev->dp_dma_addr)) {
> -		kfree(mdev->dp);
> -		dev_err(&mdev->pdev->dev, "%s %d err %d\n",
> -			__func__, __LINE__, -ENOMEM);
> -		return -ENOMEM;
> -	}
> -	mdev->ops->write_spad(mdev, MIC_DPLO_SPAD, mdev-
> >dp_dma_addr);
> -	mdev->ops->write_spad(mdev, MIC_DPHI_SPAD, mdev-
> >dp_dma_addr >> 32);
> -	return 0;
> -}
> -
> -/* Uninitialize the device page */
> -static void mic_dp_uninit(struct mic_device *mdev) -{
> -	mic_unmap_single(mdev, mdev->dp_dma_addr, MIC_DP_SIZE);
> -	kfree(mdev->dp);
> -}
> -
>  /**
>   * mic_ops_init: Initialize HW specific operation tables.
>   *
> @@ -227,11 +201,16 @@ static int mic_probe(struct pci_dev *pdev,
>=20
>  	pci_set_drvdata(pdev, mdev);
>=20
> -	rc =3D mic_dp_init(mdev);
> -	if (rc) {
> -		dev_err(&pdev->dev, "mic_dp_init failed rc %d\n", rc);
> +	mdev->dp =3D dma_alloc_coherent(&pdev->dev, MIC_DP_SIZE,
> +				      &mdev->dp_dma_addr, GFP_KERNEL);
> +	if (!mdev->dp) {
> +		dev_err(&pdev->dev, "failed to allocate device page\n");
>  		goto smpt_uninit;
>  	}
> +
> +	mdev->ops->write_spad(mdev, MIC_DPLO_SPAD, mdev-
> >dp_dma_addr);
> +	mdev->ops->write_spad(mdev, MIC_DPHI_SPAD, mdev-
> >dp_dma_addr >> 32);
> +
>  	mic_bootparam_init(mdev);
>  	mic_create_debug_dir(mdev);
>=20
> @@ -244,7 +223,7 @@ static int mic_probe(struct pci_dev *pdev,
>  	return 0;
>  cleanup_debug_dir:
>  	mic_delete_debug_dir(mdev);
> -	mic_dp_uninit(mdev);
> +	dma_free_coherent(&pdev->dev, MIC_DP_SIZE, mdev->dp,
> +mdev->dp_dma_addr);
>  smpt_uninit:
>  	mic_smpt_uninit(mdev);
>  free_interrupts:
> @@ -283,7 +262,7 @@ static void mic_remove(struct pci_dev *pdev)
>=20
>  	cosm_unregister_device(mdev->cosm_dev);
>  	mic_delete_debug_dir(mdev);
> -	mic_dp_uninit(mdev);
> +	dma_free_coherent(&pdev->dev, MIC_DP_SIZE, mdev->dp,
> +mdev->dp_dma_addr);
>  	mic_smpt_uninit(mdev);
>  	mic_free_interrupts(mdev, pdev);
>  	iounmap(mdev->aper.va);
> diff --git a/drivers/misc/mic/vop/vop_vringh.c
> b/drivers/misc/mic/vop/vop_vringh.c
> index 7014ffe88632e5..6835648d577d57 100644
> --- a/drivers/misc/mic/vop/vop_vringh.c
> +++ b/drivers/misc/mic/vop/vop_vringh.c
> @@ -298,9 +298,8 @@ static int vop_virtio_add_device(struct vop_vdev
> *vdev,
>  		mutex_init(&vvr->vr_mutex);
>  		vr_size =3D PAGE_ALIGN(round_up(vring_size(num,
> MIC_VIRTIO_RING_ALIGN), 4) +
>  			sizeof(struct _mic_vring_info));
> -		vr->va =3D (void *)
> -			__get_free_pages(GFP_KERNEL | __GFP_ZERO,
> -					 get_order(vr_size));
> +		vr->va =3D dma_alloc_coherent(vop_dev(vdev), vr_size,
> &vr_addr,
> +					    GFP_KERNEL);
>  		if (!vr->va) {
>  			ret =3D -ENOMEM;
>  			dev_err(vop_dev(vdev), "%s %d err %d\n", @@ -
> 310,15 +309,6 @@ static int vop_virtio_add_device(struct vop_vdev *vdev,
>  		vr->len =3D vr_size;
>  		vr->info =3D vr->va + round_up(vring_size(num,
> MIC_VIRTIO_RING_ALIGN), 4);
>  		vr->info->magic =3D cpu_to_le32(MIC_MAGIC + vdev->virtio_id
> + i);
> -		vr_addr =3D dma_map_single(&vpdev->dev, vr->va, vr_size,
> -					 DMA_BIDIRECTIONAL);
> -		if (dma_mapping_error(&vpdev->dev, vr_addr)) {
> -			free_pages((unsigned long)vr->va,
> get_order(vr_size));
> -			ret =3D -ENOMEM;
> -			dev_err(vop_dev(vdev), "%s %d err %d\n",
> -				__func__, __LINE__, ret);
> -			goto err;
> -		}
>  		vqconfig[i].address =3D cpu_to_le64(vr_addr);
>=20
>  		vring_init(&vr->vr, num, vr->va, MIC_VIRTIO_RING_ALIGN);
> @@ -339,11 +329,9 @@ static int vop_virtio_add_device(struct vop_vdev
> *vdev,
>  		dev_dbg(&vpdev->dev,
>  			"%s %d index %d va %p info %p vr_size 0x%x\n",
>  			__func__, __LINE__, i, vr->va, vr->info, vr_size);
> -		vvr->buf =3D (void *)__get_free_pages(GFP_KERNEL,
> -					get_order(VOP_INT_DMA_BUF_SIZE));
> -		vvr->buf_da =3D dma_map_single(&vpdev->dev,
> -					  vvr->buf, VOP_INT_DMA_BUF_SIZE,
> -					  DMA_BIDIRECTIONAL);
> +		vvr->buf =3D dma_alloc_coherent(vop_dev(vdev),
> +					      VOP_INT_DMA_BUF_SIZE,
> +					      &vvr->buf_da, GFP_KERNEL);
>  	}
>=20
>  	snprintf(irqname, sizeof(irqname), "vop%dvirtio%d", vpdev->index,
> @@ -382,10 +370,8 @@ static int vop_virtio_add_device(struct vop_vdev
> *vdev,
>  	for (j =3D 0; j < i; j++) {
>  		struct vop_vringh *vvr =3D &vdev->vvr[j];
>=20
> -		dma_unmap_single(&vpdev->dev,
> le64_to_cpu(vqconfig[j].address),
> -				 vvr->vring.len, DMA_BIDIRECTIONAL);
> -		free_pages((unsigned long)vvr->vring.va,
> -			   get_order(vvr->vring.len));
> +		dma_free_coherent(vop_dev(vdev), vvr->vring.len, vvr-
> >vring.va,
> +				  le64_to_cpu(vqconfig[j].address));
>  	}
>  	return ret;
>  }
> @@ -433,17 +419,12 @@ static void vop_virtio_del_device(struct vop_vdev
> *vdev)
>  	for (i =3D 0; i < vdev->dd->num_vq; i++) {
>  		struct vop_vringh *vvr =3D &vdev->vvr[i];
>=20
> -		dma_unmap_single(&vpdev->dev,
> -				 vvr->buf_da, VOP_INT_DMA_BUF_SIZE,
> -				 DMA_BIDIRECTIONAL);
> -		free_pages((unsigned long)vvr->buf,
> -			   get_order(VOP_INT_DMA_BUF_SIZE));
> +		dma_free_coherent(vop_dev(vdev),
> VOP_INT_DMA_BUF_SIZE,
> +				  vvr->buf, vvr->buf_da);
>  		vringh_kiov_cleanup(&vvr->riov);
>  		vringh_kiov_cleanup(&vvr->wiov);
> -		dma_unmap_single(&vpdev->dev,
> le64_to_cpu(vqconfig[i].address),
> -				 vvr->vring.len, DMA_BIDIRECTIONAL);
> -		free_pages((unsigned long)vvr->vring.va,
> -			   get_order(vvr->vring.len));
> +		dma_free_coherent(vop_dev(vdev), vvr->vring.len, vvr-
> >vring.va,
> +				  le64_to_cpu(vqconfig[i].address));
>  	}
>  	/*
>  	 * Order the type update with previous stores. This write barrier @@
> -1042,13 +1023,27 @@ static __poll_t vop_poll(struct file *f, poll_table =
*wait)
>  	return mask;
>  }
>=20
> -static inline int
> -vop_query_offset(struct vop_vdev *vdev, unsigned long offset,
> -		 unsigned long *size, unsigned long *pa)
> +/*
> + * Maps the device page and virtio rings to user space for readonly acce=
ss.
> + */
> +static int vop_mmap(struct file *f, struct vm_area_struct *vma)
>  {
> -	struct vop_device *vpdev =3D vdev->vpdev;
> -	unsigned long start =3D MIC_DP_SIZE;
> -	int i;
> +	struct vop_vdev *vdev =3D f->private_data;
> +	struct mic_vqconfig *vqconfig =3D mic_vq_config(vdev->dd);
> +	unsigned long orig_start =3D vma->vm_start;
> +	unsigned long orig_end =3D vma->vm_end;
> +	int err, i;
> +
> +	if (!vdev->vpdev->hw_ops->dp_mmap)
> +		return -EINVAL;
> +	if (vma->vm_pgoff)
> +		return -EINVAL;
> +	if (vma->vm_flags & VM_WRITE)
> +		return -EACCES;
> +
> +	err =3D vop_vdev_inited(vdev);
> +	if (err)
> +		return err;
>=20
>  	/*
>  	 * MMAP interface is as follows:
> @@ -1057,58 +1052,38 @@ vop_query_offset(struct vop_vdev *vdev,
> unsigned long offset,
>  	 * 0x1000				first vring
>  	 * 0x1000 + size of 1st vring		second vring
>  	 * ....
> +	 *
> +	 * We manipulate vm_start/vm_end to trick dma_mmap_coherent
> into
> +	 * performing partial mappings, which is a bit of a hack, but safe
> +	 * while we are under mmap_lock().  Eventually this needs to be
> +	 * replaced by a proper DMA layer API.
>  	 */
> -	if (!offset) {
> -		*pa =3D virt_to_phys(vpdev->hw_ops->get_dp(vpdev));
> -		*size =3D MIC_DP_SIZE;
> -		return 0;
> -	}
> +	vma->vm_end =3D vma->vm_start + MIC_DP_SIZE;
> +	err =3D vdev->vpdev->hw_ops->dp_mmap(vdev->vpdev, vma);
> +	if (err)
> +		goto out;
>=20
>  	for (i =3D 0; i < vdev->dd->num_vq; i++) {
>  		struct vop_vringh *vvr =3D &vdev->vvr[i];
>=20
> -		if (offset =3D=3D start) {
> -			*pa =3D virt_to_phys(vvr->vring.va);
> -			*size =3D vvr->vring.len;
> -			return 0;
> -		}
> -		start +=3D vvr->vring.len;
> -	}
> -	return -1;
> -}
> -
> -/*
> - * Maps the device page and virtio rings to user space for readonly acce=
ss.
> - */
> -static int vop_mmap(struct file *f, struct vm_area_struct *vma) -{
> -	struct vop_vdev *vdev =3D f->private_data;
> -	unsigned long offset =3D vma->vm_pgoff << PAGE_SHIFT;
> -	unsigned long pa, size =3D vma->vm_end - vma->vm_start, size_rem =3D
> size;
> -	int i, err;
> +		vma->vm_start =3D vma->vm_end;
> +		vma->vm_end +=3D vvr->vring.len;
>=20
> -	err =3D vop_vdev_inited(vdev);
> -	if (err)
> -		goto ret;
> -	if (vma->vm_flags & VM_WRITE) {
> -		err =3D -EACCES;
> -		goto ret;
> -	}
> -	while (size_rem) {
> -		i =3D vop_query_offset(vdev, offset, &size, &pa);
> -		if (i < 0) {
> -			err =3D -EINVAL;
> -			goto ret;
> -		}
> -		err =3D remap_pfn_range(vma, vma->vm_start + offset,
> -				      pa >> PAGE_SHIFT, size,
> -				      vma->vm_page_prot);
> +		err =3D -EINVAL;
> +		if (vma->vm_end > orig_end)
> +			goto out;
> +		err =3D dma_mmap_coherent(vop_dev(vdev), vma, vvr-
> >vring.va,
> +					le64_to_cpu(vqconfig[i].address),
> +					vvr->vring.len);
>  		if (err)
> -			goto ret;
> -		size_rem -=3D size;
> -		offset +=3D size;
> +			goto out;
>  	}
> -ret:
> +out:
> +	/*
> +	 * Restore the original vma parameters.
> +	 */
> +	vma->vm_start =3D orig_start;
> +	vma->vm_end =3D orig_end;
>  	return err;
>  }
>=20
> --
> 2.28.0

