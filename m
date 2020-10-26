Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56F7E2985AB
	for <lists+linux-pci@lfdr.de>; Mon, 26 Oct 2020 03:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389382AbgJZCyr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 25 Oct 2020 22:54:47 -0400
Received: from mail-eopbgr60044.outbound.protection.outlook.com ([40.107.6.44]:24897
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1421567AbgJZCyr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 25 Oct 2020 22:54:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bSZDHkL1EBI93Oyjgtsyq9JdF7VoVi0To5S4AItUGJSb63e37o7X/jlL51XT+wATdZytl1hNw+ypEveCKEy18mXSBife12hxu3/AUAHNyRDjnnIg1LPOGkzRvxFy3Pf5B1bVsbvFeIeKj8vRYxARAVuVu/Q+qLChSvdvDPUxEs+6+kpJRj7XqFTV6m/yMF+URnupDIr6znHUrn3142i7qhTBtqBdQNu8mYie/Qjs0ePLBLHJDnYvDfG9CksBFoRfPlM+udzP/0SwSJDgx4N4rSDAw7EqCx4yHbF2SVXMfRnB2gzRuolByRUb8OR5Z1E8IURezKkRWeP1ooGj3vrxTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djhJS2BOuDw1K7qbF+USzqBpm3+DeEjepYbYXW4P8Js=;
 b=gAaxZqn7LAbahFtsJ0tuNeEY9fvFE/ODYrdtaD4h1JTA1N2H7dxxfZgLyVdHTfpFTmfnB5EMwsvOnLph76HaRLXRhwDRQ1iexOn6RDGpQJ1MzmzuECxVSD6GtJQXUsfYo6wvXdoL3ELHFGq+oaLsKyKhq7be5eBpg9Avjw4dmuBTaoJGFvQuXyOd4TRf/3Du88Y+otT9BoPX0Qj44M8QItX2wosTdYXn5iZg6TbvsYxektO7NRtlI/KZiCA4iuufgk8CBit6oH+mH0/SwBTLO1pAVIFf03EXYZpFKUavrOZJSS9AD/u6apELgjmlB5IJ6PrRpwMbj8oTXHthUVfOIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djhJS2BOuDw1K7qbF+USzqBpm3+DeEjepYbYXW4P8Js=;
 b=BRUmkWVsG3IuvCoGqyYxLfKRzAq7gz9ZcPWKNZJb4xsNQVP2JckJttTnreG84mu1Q1cf73CzMPSd47ZRDK5Yrhn7hM9XtHKtHZx7CNfa5kcVZZgm/VkmysmhIgltehhqJpXcdmPm97P7xzxfsehT+XxgZF3qUWn5RkGJKfKH2Rs=
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com (2603:10a6:803:57::21)
 by VI1PR04MB5389.eurprd04.prod.outlook.com (2603:10a6:803:d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22; Mon, 26 Oct
 2020 02:54:43 +0000
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6]) by VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6%3]) with mapi id 15.20.3477.028; Mon, 26 Oct 2020
 02:54:43 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     "sudeep.dutt@intel.com" <sudeep.dutt@intel.com>,
        "ashutosh.dixit@intel.com" <ashutosh.dixit@intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V3 1/4] misc: vop: change the way of allocating vring and
 device page
Thread-Topic: [PATCH V3 1/4] misc: vop: change the way of allocating vring and
 device page
Thread-Index: AQHWqDFPY7Z3VR772U+S1nPW/DeV8Kmk7HwAgARJSyA=
Date:   Mon, 26 Oct 2020 02:54:43 +0000
Message-ID: <VI1PR04MB4960119E6D56CF64E8FD2E4492190@VI1PR04MB4960.eurprd04.prod.outlook.com>
References: <20201022050638.29641-1-sherry.sun@nxp.com>
 <20201022050638.29641-2-sherry.sun@nxp.com>
 <20201023092524.GA29066@infradead.org>
In-Reply-To: <20201023092524.GA29066@infradead.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 54f1ccd1-c0e8-4674-d509-08d8795a7d87
x-ms-traffictypediagnostic: VI1PR04MB5389:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB53892544949ACB01CC1594A292190@VI1PR04MB5389.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yrfU2z8JX1desoMH5kl6N+tSz/f6pTMg6VwHhGQsYkOwedph7YB+Qemx6Ady7BAU9lvised4qwbjT55QdFRWpS3y1Y5NKoBE6aUVGmltbNQdROuTG+pmZvoIGxbnItaFwsT3951PMMSL1w4Sgpn1tPSf5pAk0Fvx+b8ZV7Yr6gmsB7iKEr0we3k/7eGRM8aXgPEDI+tFuD9C8JbTAwnn+SUnYZ8vA/Qvj9z8sYH7irPu4+YUpPAbJCIdsf5YZl5qmnGO896ncWTbpNUclFvEGmmBUyAi0K4OsQh2eQj8exE+vvmbSfk0AFc4ms6MkjPdwvsIIwuPAWvlMFDa7X5RbA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4960.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(346002)(136003)(376002)(366004)(66556008)(66446008)(4326008)(316002)(66476007)(9686003)(54906003)(76116006)(478600001)(86362001)(26005)(5660300002)(55016002)(6506007)(7696005)(64756008)(2906002)(71200400001)(44832011)(52536014)(186003)(6916009)(66946007)(33656002)(8936002)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: UycBHb3MEL++EVYzBACOvdYLVIQlQRYULg+IuMrsEHeLVcXqH72DFmY8jAbeBgwwSkT3X7e3qmuYYg66+CuTEZ3QZqwI3Bge9Op9cXW+VaV/duqL11Xg05JUPtBYw5LMi+caWMji7ghqbgzlYCqdzH5Tdus86FHa2v2QeES78vArenhqGyMZVcTlbjINpO46FWhmsDYSlrkpgP7B43YCeat+2yMrn2Z3SvvDaOzQPT8wfDsyW8JvkaekbYie6uBSWfGpK/x+bHp3ZLgS4iWEjofPqinFp8MVfLBAvnqD1FbetNo6sG3py4LQMsXGhfD31hNJtp+fuCOUJBCNeg7rnCK0ZKDO+G0Cr6H//NTb1wcZCVwxSW5MD3nqy47xrb5KqafYreZmDkmPIvGieUZxksri2unBdbNsEGIWlKm5xbutuwQgCJdXzbqNhfbUU/a04pEe7abXpudZbixzUN2eV4uFMvbpZWWpOlXG94/X/Kr7avhbFOi0iCBZg54KXTY1Q9GCcIZ3TDRfD4RcCJpncQF48jCOLJOIXeDiZUotrDv23wVaI+PfjI6vSs3A1oJS4aRVdSMleGd3xcmqkgiMsggCidCT7eqGnfut2Y1ZqGPHpHEhxKj9naqbWRzYZWZrhJFAS9JbaBOl0roCoDgeOA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4960.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54f1ccd1-c0e8-4674-d509-08d8795a7d87
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2020 02:54:43.1807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: stF9jid8JXVJxAa8AM3Vj+R+4NFwdLntQUZha2j439x+xgS5BcbbLZexp5SgpuJ9o0hfvTBZ9sLhzCg3iTaHAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5389
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Christoph,

>=20
> >  static int mic_dp_init(struct mic_device *mdev)  {
> > -	mdev->dp =3D kzalloc(MIC_DP_SIZE, GFP_KERNEL);
> > +	mdev->dp =3D dma_alloc_coherent(&mdev->pdev->dev, MIC_DP_SIZE,
> > +				      &mdev->dp_dma_addr, GFP_KERNEL);
> >  	if (!mdev->dp)
> >  		return -ENOMEM;
> >
> > -	mdev->dp_dma_addr =3D mic_map_single(mdev,
> > -		mdev->dp, MIC_DP_SIZE);
> > -	if (mic_map_error(mdev->dp_dma_addr)) {
> > -		kfree(mdev->dp);
> > -		dev_err(&mdev->pdev->dev, "%s %d err %d\n",
> > -			__func__, __LINE__, -ENOMEM);
> > -		return -ENOMEM;
> > -	}
> >  	mdev->ops->write_spad(mdev, MIC_DPLO_SPAD, mdev-
> >dp_dma_addr);
> >  	mdev->ops->write_spad(mdev, MIC_DPHI_SPAD, mdev-
> >dp_dma_addr >> 32);
> >  	return 0;
> > @@ -68,8 +62,7 @@ static int mic_dp_init(struct mic_device *mdev)
> >  /* Uninitialize the device page */
> >  static void mic_dp_uninit(struct mic_device *mdev)  {
> > -	mic_unmap_single(mdev, mdev->dp_dma_addr, MIC_DP_SIZE);
> > -	kfree(mdev->dp);
> > +	dma_free_coherent(&mdev->pdev->dev, MIC_DP_SIZE, mdev->dp,
> > +mdev->dp_dma_addr);
> >  }
>=20
> This adds an over 80 char line.  Also please just kill mic_dp_init and
> mic_dp_uninit and inline those into the callers.

Okay, will fix them.
>=20
> > +		vvr->buf =3D dma_alloc_coherent(vop_dev(vdev),
> VOP_INT_DMA_BUF_SIZE,
> > +					      &vvr->buf_da, GFP_KERNEL);
>=20
> Another overly long line.
>=20
> > @@ -1068,7 +1049,7 @@ vop_query_offset(struct vop_vdev *vdev,
> unsigned long offset,
> >  		struct vop_vringh *vvr =3D &vdev->vvr[i];
> >
> >  		if (offset =3D=3D start) {
> > -			*pa =3D virt_to_phys(vvr->vring.va);
> > +			*pa =3D vqconfig[i].address;
>=20
> vqconfig[i].address is a __le64, so this needs an endian swap.
>=20
> But more importantly the caller of vop_query_offset, vop_mmap, uses
> remap_pfn_range and pa.  You cannot mix remap_pfn_range with DMA
> coherent allocations, it can only be mmaped using dma_mmap_coherent.

Will change to use dma_mmap_coherent in V4.

Best regards
Sherry=20
