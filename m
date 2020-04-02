Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03D3919C441
	for <lists+linux-pci@lfdr.de>; Thu,  2 Apr 2020 16:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbgDBOcI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Apr 2020 10:32:08 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:32704 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729123AbgDBOcH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Apr 2020 10:32:07 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200402143205epoutp021eb16f8f449150517ecd0845d97d22e4~CBzD8wx-j1172511725epoutp02b
        for <linux-pci@vger.kernel.org>; Thu,  2 Apr 2020 14:32:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200402143205epoutp021eb16f8f449150517ecd0845d97d22e4~CBzD8wx-j1172511725epoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585837925;
        bh=+cp0ZuvDiMSHbLAAGznAy1k68BRkSTs9vA/p1jV7bWs=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=XIlks3IzXuzbNm4n0McXiVU47DHLS02AOlEtsK6IU4KfCQk5A085JeOEqivZj2Gef
         MkqJRGmVoPwdXil0FrZMWejrtvobheWf9nGFUSJg1yBtpmn0g2swdwV+CJpkOBabqE
         36TRoF7ZYqQAWokLRzhHDkR3xM/NB8EzwZHLZYd8=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20200402143205epcas5p42ad7ecb1cc395090db001bf5edbb1e32~CBzDZAkpa0817008170epcas5p4N;
        Thu,  2 Apr 2020 14:32:05 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        68.B0.04778.567F58E5; Thu,  2 Apr 2020 23:32:05 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20200402143204epcas5p1e21200ba2ce531ebbf252bdb9cac8859~CBzDDKKKS3029130291epcas5p1f;
        Thu,  2 Apr 2020 14:32:04 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200402143204epsmtrp26e40fc99a2ee446997c4d669f85f8156~CBzDCb0NG1118111181epsmtrp2y;
        Thu,  2 Apr 2020 14:32:04 +0000 (GMT)
X-AuditID: b6c32a4a-33bff700000012aa-24-5e85f7652418
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7A.6E.04024.467F58E5; Thu,  2 Apr 2020 23:32:04 +0900 (KST)
Received: from sriramdash03 (unknown [107.108.234.13]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200402143201epsmtip2750872a05723a927883093773b2ea40f~CBzAW-SK62373323733epsmtip2Y;
        Thu,  2 Apr 2020 14:32:01 +0000 (GMT)
From:   "Sriram Dash" <sriram.dash@samsung.com>
To:     "'Kishon Vijay Abraham I'" <kishon@ti.com>,
        "'Shradha Todi'" <shradha.t@samsung.com>
Cc:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <pankaj.dubey@samsung.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <a7a6a295-160a-94d6-09f9-63f783c8b28a@ti.com>
Subject: RE: [PATCH] PCI: endpoint: Fix NULL pointer dereference for
 ->get_features()
Date:   Thu, 2 Apr 2020 20:01:59 +0530
Message-ID: <000001d608fb$7ab39010$701ab030$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIRa+BXjMtyeVOz/ELce4dgT57WJwIqUA0mAt3aYLECuy3/8qexBBmw
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFKsWRmVeSWpSXmKPExsWy7bCmum7q99Y4g3vzWSyWNGVYXHjaw2Zx
        edccNouz846zWbz5/YLdYtHWL+wWvYdrHdg91sxbw+ixYFOpR9+WVYwex29sZ/L4vEkugDWK
        yyYlNSezLLVI3y6BK6Np6lXWgnOyFVd37WVvYFwl0cXIwSEhYCLx7qBzFyMXh5DAbkaJTX8O
        sEA4nxglul+9ZYdwvjFKtH1ZwtTFyAnWcfbYIajEXkaJ7Q1HoJzXjBInGn6zg1SxCehKnL3R
        xAZiiwhESfTMbmcGKWIWmMwocWP5L7AiTgEriTULlrKA2MIC4RIr5t9kBLFZBFQkTs7rAWvm
        FbCUeLvyNDOELShxcuYTsHpmAW2JZQtfM0OcpCDx8+kyVohlbhI/Xl9mhqgRlzj6swdssYTA
        czaJ3rXXoBpcJFY8+sYIYQtLvDq+hR3ClpL4/G4vG4SdLXG57zlUfYnEjFcLWSBse4kDV+aw
        gEKPWUBTYv0ufYhdfBK9v58wQQKVV6KjTQiiWlXi1e3NUNOlJQ6sPQ0NRQ+JrxMuME1gVJyF
        5LNZSD6bheSDWQjLFjCyrGKUTC0ozk1PLTYtMMpLLdcrTswtLs1L10vOz93ECE5BWl47GJed
        8znEKMDBqMTDG3G4NU6INbGsuDL3EKMEB7OSCK/jDKAQb0piZVVqUX58UWlOavEhRmkOFiVx
        3kmsV2OEBNITS1KzU1MLUotgskwcnFINjCtmZJ/4+V9h+YuYnrubNovun+TXIZ1j+TTaWeHa
        V4+f10VOxIZePH+P9/tcyZM3Zz+cPu1zwNqGqPbSUDuW6cfaNX6zmb4SVV+459+kOV//Gf4K
        jz/U4bEh/zZnr/50Pd+DZqJR2jW2zY1fZBZc8XlpOeXSiW/cW7teVOx1sJv1wfbrRNNHCzmV
        WIozEg21mIuKEwEtnARyPQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjkeLIzCtJLcpLzFFi42LZdlhJXjfle2ucwZypmhZLmjIsLjztYbO4
        vGsOm8XZecfZLN78fsFusWjrF3aL3sO1Duwea+atYfRYsKnUo2/LKkaP4ze2M3l83iQXwBrF
        ZZOSmpNZllqkb5fAlTFl/wq2guWyFT1fTzI3MDZKdDFyckgImEicPXaIvYuRi0NIYDejxNnV
        29m6GDmAEtISP+/qQtQIS6z89xyq5iWjxP41p5lAEmwCuhJnbzSxgdgiAlESk/f3sIIUMQtM
        Z5Ro2zIbquM5o8T6ZSfBqjgFrCTWLFjKAmILC4RKfGybygpiswioSJyc1wNWwytgKfF25Wlm
        CFtQ4uTMJ2D1zALaEk9vPoWzly18zQxxnoLEz6fLWCGucJP48foyM0SNuMTRnz3MExiFZyEZ
        NQvJqFlIRs1C0rKAkWUVo2RqQXFuem6xYYFhXmq5XnFibnFpXrpecn7uJkZwLGlp7mC8vCT+
        EKMAB6MSDy/DwdY4IdbEsuLK3EOMEhzMSiK8jjOAQrwpiZVVqUX58UWlOanFhxilOViUxHmf
        5h2LFBJITyxJzU5NLUgtgskycXBKNTAys/ndsVpiNdfC/+iX+LKAya4HSlYtSrfxnSL4UOf4
        8TqNO745R38eFrRju77k1rpNmiwPymS49u19+PHAlF+leZcMLHf8eWdakPiZNVxHuaKN0/mP
        8jcPDb/HzqaWTq63FnmIx+y5kXzqt5xc1aILPhF2DzUOzn25dqmcO6uv9XS/GUzZwd+VWIoz
        Eg21mIuKEwEFlho/oQIAAA==
X-CMS-MailID: 20200402143204epcas5p1e21200ba2ce531ebbf252bdb9cac8859
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20200311103443epcas5p2e97b8f3a8e52dc6f02eb551e0c97f132
References: <CGME20200311103443epcas5p2e97b8f3a8e52dc6f02eb551e0c97f132@epcas5p2.samsung.com>
        <20200311102852.5207-1-shradha.t@samsung.com>
        <000d01d5fdf3$55d43af0$017cb0d0$@samsung.com>
        <a7a6a295-160a-94d6-09f9-63f783c8b28a@ti.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> From: Kishon Vijay Abraham I <kishon=40ti.com>
> Subject: Re: =5BPATCH=5D PCI: endpoint: Fix NULL pointer dereference for =
-
> >get_features()
>=20
> Hi Sriram,
>=20
> On 3/19/2020 7:06 PM, Sriram Dash wrote:
> >> From: Shradha Todi <shradha.t=40samsung.com>
> >> Subject: =5BPATCH=5D PCI: endpoint: Fix NULL pointer dereference for -
> >>> get_features()
> >>
> >> get_features ops of pci_epc_ops may return NULL, causing NULL pointer
> >> dereference in pci_epf_test_bind function. Let us add a check for
> >> pci_epc_feature pointer in pci_epf_test_bind before we access it to
> >> avoid any such NULL pointer dereference and return -ENOTSUPP in case
> >> pci_epc_feature is not found.
> >>
> >> Reviewed-by: Pankaj Dubey <pankaj.dubey=40samsung.com>
> >> Signed-off-by: Sriram Dash <sriram.dash=40samsung.com>
> >> Signed-off-by: Shradha Todi <shradha.t=40samsung.com>
> >> ---
> >
> > Hi Kishon,
> >
> > Any update on this?
>=20
> Don't we access epc_features only after checking if epc_features is not N=
ULL in
> pci_epf_test_bind() function? However we are accessing epc_features in
> multiple other functions all over pci-epf-test.

We access the epc_feature after checking the NULL condition in the bind fun=
ction.
However, we do not stop if the epc_feature is NULL and proceed for allocati=
on in the
pci_epf_test_alloc_space function, for example. During this allocation, we =
do not check
for NULL condition for epc_feature and hence, if any controller driver is n=
ot providing
the epc features, it will panic accessing epc_features.

>=20
> So the patch itself is correct though the commit log has to be fixed. You=
 should
> also check if all the endpoint controller drivers existing currently prov=
ides
> epc_features.

At the moment, there is no issue for existing controller drivers as I can s=
ee almost
all drivers are providing epc_features. But, this is not a mandatory featur=
e and some
controller drivers may not have epc_features implemented, may be in the nea=
r future.
But because we are dealing with the configfs, the application need not both=
er about
the driver details underneath.

IMO, the code should be fixed regardless and should not cause panic in any =
case.

>=20
> Thanks
> Kishon
> >
> >
> >>  drivers/pci/endpoint/functions/pci-epf-test.c =7C 15 +++++++++------
> >>  1 file changed, 9 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c
> >> b/drivers/pci/endpoint/functions/pci-epf-test.c
> >> index c9121b1b9fa9..af4537a487bf 100644
> >> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> >> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> >> =40=40 -510,14 +510,17 =40=40 static int pci_epf_test_bind(struct pci_=
epf *epf)
> >>  		return -EINVAL;
> >>
> >>  	epc_features =3D pci_epc_get_features(epc, epf->func_no);
> >> -	if (epc_features) =7B
> >> -		linkup_notifier =3D epc_features->linkup_notifier;
> >> -		msix_capable =3D epc_features->msix_capable;
> >> -		msi_capable =3D epc_features->msi_capable;
> >> -		test_reg_bar =3D pci_epc_get_first_free_bar(epc_features);
> >> -		pci_epf_configure_bar(epf, epc_features);
> >> +	if (=21epc_features) =7B
> >> +		dev_err(dev, =22epc_features not implemented=5Cn=22);
> >> +		return -ENOTSUPP;
> >>  	=7D
> >>
> >> +	linkup_notifier =3D epc_features->linkup_notifier;
> >> +	msix_capable =3D epc_features->msix_capable;
> >> +	msi_capable =3D epc_features->msi_capable;
> >> +	test_reg_bar =3D pci_epc_get_first_free_bar(epc_features);
> >> +	pci_epf_configure_bar(epf, epc_features);
> >> +
> >>  	epf_test->test_reg_bar =3D test_reg_bar;
> >>  	epf_test->epc_features =3D epc_features;
> >>
> >> --
> >> 2.17.1
> >
> >

