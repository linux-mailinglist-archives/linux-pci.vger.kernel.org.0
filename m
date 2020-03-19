Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A511718B7D6
	for <lists+linux-pci@lfdr.de>; Thu, 19 Mar 2020 14:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbgCSNgH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Mar 2020 09:36:07 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:64833 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727313AbgCSNgH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Mar 2020 09:36:07 -0400
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200319133605epoutp0202ed33b56354a632f8bcd3b554c628ed~9uAKTkhZ41573915739epoutp02f
        for <linux-pci@vger.kernel.org>; Thu, 19 Mar 2020 13:36:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200319133605epoutp0202ed33b56354a632f8bcd3b554c628ed~9uAKTkhZ41573915739epoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1584624965;
        bh=4FL33iP/jwSsQW96+6AWrtYIL4nfSj8zvnMw8LCMztg=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=fSS2rSdjXhxn6oNDINfpNeqFPOv54i7eXTlabPA9wFEWUeYjpMCDrE/xOL5Ka4F0c
         2Ofbp0cNVzjWgzBUJwQWn5/sxBt4HxwEa6gVyVgeTkj57F9AqS+203/amPEIAobaiq
         EqQ+7vR2Lj0VOiygkPQWo0bIWyi5JMJijmeOenxs=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20200319133604epcas5p3dbbb7941cdd45bee37c4c1caa320016b~9uAJzbOTa1621316213epcas5p3E;
        Thu, 19 Mar 2020 13:36:04 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        83.AF.04778.445737E5; Thu, 19 Mar 2020 22:36:04 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20200319133603epcas5p294d8a6f404e5d168d75cfa6861e393e3~9uAJGi74l1782517825epcas5p2p;
        Thu, 19 Mar 2020 13:36:03 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200319133603epsmtrp20dd7c56c4edec8817d0b58191b050767~9uAJFqWh63159731597epsmtrp2N;
        Thu, 19 Mar 2020 13:36:03 +0000 (GMT)
X-AuditID: b6c32a4a-353ff700000012aa-b1-5e73754435e2
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        13.C4.04024.345737E5; Thu, 19 Mar 2020 22:36:03 +0900 (KST)
Received: from sriramdash03 (unknown [107.111.85.15]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200319133602epsmtip10df7c703058970433bc7f58b98daa829~9uAIAvU692963729637epsmtip1Y;
        Thu, 19 Mar 2020 13:36:02 +0000 (GMT)
From:   "Sriram Dash" <sriram.dash@samsung.com>
To:     "'Shradha Todi'" <shradha.t@samsung.com>, <kishon@ti.com>
Cc:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <pankaj.dubey@samsung.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <20200311102852.5207-1-shradha.t@samsung.com>
Subject: RE: [PATCH] PCI: endpoint: Fix NULL pointer dereference for
 ->get_features()
Date:   Thu, 19 Mar 2020 19:06:01 +0530
Message-ID: <000d01d5fdf3$55d43af0$017cb0d0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIRa+BXjMtyeVOz/ELce4dgT57WJwIqUA0mp8e8EHA=
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNKsWRmVeSWpSXmKPExsWy7bCmhq5LaXGcwdVHihZLmjIsLjztYbO4
        vGsOm8XZecfZLN78fsFusWjrF3aL3sO1Duwea+atYfRYsKnUo2/LKkaP4ze2M3l83iQXwBrF
        ZZOSmpNZllqkb5fAldGz+wJbwTKBio/LfrE1ML7m7WLk5JAQMJF4OusPUxcjF4eQwG5Gie6n
        t9ghnE+MEvduPWOBcL4xSjT/esUK0/JpZQdUYi+jxNQVG1ghnFeMEuu75jGDVLEJ6EqcvdHE
        BmKLCNhKLN84H2wus8BkRokby3+xgyQ4BawkOvqngTUIC4RLrJh/kxHEZhFQlfh/4jYLiM0r
        YCkxb/tRVghbUOLkzCdgcWYBbYllC18zQ5ykIPHz6TJWiGVWEhOX3GWDqBGXOPqzhxlksYTA
        czaJ32+/M0E0uEhsbzwBZQtLvDq+hR3ClpL4/G4vG4SdLXG57znUghKJGa8WskDY9hIHrswB
        sjmAFmhKrN+lD7GLT6L39xMmkLCEAK9ER5sQRLWqxKvbm6GmS0scWHsaaquHxNcJF5gmMCrO
        QvLZLCSfzULywSyEZQsYWVYxSqYWFOempxabFhjlpZbrFSfmFpfmpesl5+duYgQnIS2vHYzL
        zvkcYhTgYFTi4V2wpihOiDWxrLgy9xCjBAezkgivbnpxnBBvSmJlVWpRfnxRaU5q8SFGaQ4W
        JXHeSaxXY4QE0hNLUrNTUwtSi2CyTBycUg2M+gHPp+5aecx8QZtgcMeuJ2zPG2c/6O5l9Td6
        8Mj9dXK+VqPvm0libD1SKrI5Oxd4rBfbuUJuQqdZ79ot86xu17zY2r46t36V98o6qfK9/oks
        Gf+n9v+JO9iyxaT2yI0PDzLEK1/6blxyK8ika9eZOO+iqAuRrTPMNylOjuD6zGpdkSDONqVH
        iaU4I9FQi7moOBEACSYjbz4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjkeLIzCtJLcpLzFFi42LZdlhJTte5tDjOYE6LnsWSpgyLC0972Cwu
        75rDZnF23nE2ize/X7BbLNr6hd2i93CtA7vHmnlrGD0WbCr16NuyitHj+I3tTB6fN8kFsEZx
        2aSk5mSWpRbp2yVwZWzf0cte0CRQ8ebkN6YGxuO8XYycHBICJhKfVnawdDFycQgJ7GaUeLGj
        n7GLkQMoIS3x864uRI2wxMp/z9khal4wSszq+sAGkmAT0JU4e6MJzBYRsJd4MWMjK0gRs8B0
        Rom2LbOhOroZJXYsWQ9WxSlgJdHRP40ZxBYWCJX42DaVFcRmEVCV+H/iNguIzStgKTFv+1FW
        CFtQ4uTMJ2BxZgFtid6HrYww9rKFr5khzlOQ+Pl0GSvEFVYSE5fcZYOoEZc4+rOHeQKj8Cwk
        o2YhGTULyahZSFoWMLKsYpRMLSjOTc8tNiwwzEst1ytOzC0uzUvXS87P3cQIjiUtzR2Ml5fE
        H2IU4GBU4uH1WFUUJ8SaWFZcmXuIUYKDWUmEVze9OE6INyWxsiq1KD++qDQntfgQozQHi5I4
        79O8Y5FCAumJJanZqakFqUUwWSYOTqkGxtD++Ueudz1imOohe1Bi0suO+5Y9DEp3P5ry54ap
        7/8X15/VvUm4gLX0vU35kcSQVwzZ05izpUVYeVXXuBgqJ2pznbW7urZN4I5bxLdXZhr8EkpF
        u49Fcp1cudp0U8Ijpbw0VnmzjufCm3U37G09fDLtHe+axJvxUnoHUq+dXLd7cfaBJ/VTlViK
        MxINtZiLihMB8/g/J6ECAAA=
X-CMS-MailID: 20200319133603epcas5p294d8a6f404e5d168d75cfa6861e393e3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20200311103443epcas5p2e97b8f3a8e52dc6f02eb551e0c97f132
References: <CGME20200311103443epcas5p2e97b8f3a8e52dc6f02eb551e0c97f132@epcas5p2.samsung.com>
        <20200311102852.5207-1-shradha.t@samsung.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> From: Shradha Todi <shradha.t=40samsung.com>
> Subject: =5BPATCH=5D PCI: endpoint: Fix NULL pointer dereference for -
> >get_features()
>=20
> get_features ops of pci_epc_ops may return NULL, causing NULL pointer
> dereference in pci_epf_test_bind function. Let us add a check for
> pci_epc_feature pointer in pci_epf_test_bind before we access it to avoid=
 any
> such NULL pointer dereference and return -ENOTSUPP in case pci_epc_featur=
e
> is not found.
>=20
> Reviewed-by: Pankaj Dubey <pankaj.dubey=40samsung.com>
> Signed-off-by: Sriram Dash <sriram.dash=40samsung.com>
> Signed-off-by: Shradha Todi <shradha.t=40samsung.com>
> ---

Hi Kishon,

Any update on this?


>  drivers/pci/endpoint/functions/pci-epf-test.c =7C 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c
> b/drivers/pci/endpoint/functions/pci-epf-test.c
> index c9121b1b9fa9..af4537a487bf 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> =40=40 -510,14 +510,17 =40=40 static int pci_epf_test_bind(struct pci_epf=
 *epf)
>  		return -EINVAL;
>=20
>  	epc_features =3D pci_epc_get_features(epc, epf->func_no);
> -	if (epc_features) =7B
> -		linkup_notifier =3D epc_features->linkup_notifier;
> -		msix_capable =3D epc_features->msix_capable;
> -		msi_capable =3D epc_features->msi_capable;
> -		test_reg_bar =3D pci_epc_get_first_free_bar(epc_features);
> -		pci_epf_configure_bar(epf, epc_features);
> +	if (=21epc_features) =7B
> +		dev_err(dev, =22epc_features not implemented=5Cn=22);
> +		return -ENOTSUPP;
>  	=7D
>=20
> +	linkup_notifier =3D epc_features->linkup_notifier;
> +	msix_capable =3D epc_features->msix_capable;
> +	msi_capable =3D epc_features->msi_capable;
> +	test_reg_bar =3D pci_epc_get_first_free_bar(epc_features);
> +	pci_epf_configure_bar(epf, epc_features);
> +
>  	epf_test->test_reg_bar =3D test_reg_bar;
>  	epf_test->epc_features =3D epc_features;
>=20
> --
> 2.17.1


