Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B78B830593C
	for <lists+linux-pci@lfdr.de>; Wed, 27 Jan 2021 12:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236378AbhA0LII (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Jan 2021 06:08:08 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:47168 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236372AbhA0LCT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Jan 2021 06:02:19 -0500
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210127110128epoutp039fadf3261c315d64401cf08141a58fb8~eEc0AT_7o2949229492epoutp03L
        for <linux-pci@vger.kernel.org>; Wed, 27 Jan 2021 11:01:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210127110128epoutp039fadf3261c315d64401cf08141a58fb8~eEc0AT_7o2949229492epoutp03L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1611745288;
        bh=H+sfLDg/moekuT4e6JRFb5LVIBuQYwwzTUPigmkehJU=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=NlUF8Wscw7QBMv9ZO9+YjlZW2QuGYsIhl4PDoq6DMXcIZ2FS5Bp2gYXALfoRV5aRz
         kjfbkH+vwFKAKm8WbMA9HMrF50nsvRCTlOVHGAMgBI2Q7NaON1JTC/d38mTSzGRpmx
         xgbpYGPAXxJLcSkAUJPbMh8736Hqy78NdOvQLsMQ=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20210127110128epcas5p4866ed78cbca408049fab61bf660f6570~eEczUwH1Y0372703727epcas5p4u;
        Wed, 27 Jan 2021 11:01:28 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        08.A6.50652.70841106; Wed, 27 Jan 2021 20:01:27 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20210127091658epcas5p377aa71fa163fea556d420136ce64c251~eDBkYr1tB2399023990epcas5p3s;
        Wed, 27 Jan 2021 09:16:58 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210127091658epsmtrp255f8201b53eb695fe5009f5c05ef16c3~eDBkXq6Re1161811618epsmtrp2C;
        Wed, 27 Jan 2021 09:16:58 +0000 (GMT)
X-AuditID: b6c32a4a-6c9ff7000000c5dc-46-60114807199b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DB.3C.13470.A8F21106; Wed, 27 Jan 2021 18:16:58 +0900 (KST)
Received: from shradhat02 (unknown [107.122.8.248]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20210127091656epsmtip2f81142a5a1c44a981cebc3dc170716e5~eDBiiktkS2437924379epsmtip2z;
        Wed, 27 Jan 2021 09:16:56 +0000 (GMT)
From:   "Shradha Todi" <shradha.t@samsung.com>
To:     <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Cc:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <robh@kernel.org>, <lorenzo.pieralisi@arm.com>,
        <bhelgaas@google.com>, <pankaj.dubey@samsung.com>,
        <sriram.dash@samsung.com>, <niyas.ahmed@samsung.com>,
        <p.rajanbabu@samsung.com>, <l.mehra@samsung.com>,
        <hari.tv@samsung.com>
In-Reply-To: <1609930210-19227-1-git-send-email-shradha.t@samsung.com>
Subject: RE: [PATCH v2] PCI: dwc: Add upper limit address for outbound iATU
Date:   Wed, 27 Jan 2021 14:46:51 +0530
Message-ID: <156a01d6f48d$29d2b850$7d7828f0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHJsRGfSFv8WioXtPNJkxsZ5VdGswG1HobKqkgOwJA=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMKsWRmVeSWpSXmKPExsWy7bCmui67h2CCwZ0VlhZLmjIsdt3tYLf4
        OG0lk8WKLzPZLe48v8FocXnXHDaLs/OOs1m8+f2C3eLJlEesFkc3Blss2vqF3eL/nh3sFjfW
        szvweqyZt4bRY+esu+weCzaVemxa1cnm0bdlFaPHlv2fGT0+b5ILYI/isklJzcksSy3St0vg
        ypj1ejFbwXTRirtL3zI3MF4V7GLk5JAQMJH4vfQCexcjF4eQwG5GiYUdx5ghnE+MEk/6bzFC
        ON8YJWZ09LHDtDy6+wkqsZdRYtPLx2wQzgtGiTfPjjOBVLEJ6Eg8ufIHaBYHh4iAvUTTj0SQ
        GmaBpUwS1z9dYwSp4RRwk2g7sAesRljAW+L7giKQMIuAqkTjxAnMIDavgKXEvt8tjBC2oMTJ
        mU9YQGxmAW2JZQtfM0McpCDx8+kyVhBbRMBK4lDnXUaIGnGJl0ePgP0mIXCGQ2L2mn4WiAYX
        iWVnrjJC2MISr45vgfpMSuLzu71sEHa+xNQLT1lAbpMQqJBY3lMHEbaXOHBlDliYWUBTYv0u
        fYiwrMTUU+uYINbySfT+fsIEEeeV2DEPxlaW+PJ3D9QFkhLzjl1mncCoNAvJZ7OQfDYLyQez
        ELYtYGRZxSiZWlCcm55abFpglJdarlecmFtcmpeul5yfu4kRnM60vHYwPnzwQe8QIxMH4yFG
        CQ5mJRFeOwXBBCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8OwwexAsJpCeWpGanphakFsFkmTg4
        pRqYlKd3bnBb0vaNSdKi7qi0cvBH0du+Is4s5/N4tq5d6Ggkn/r0TNDTfcV+H7+7LV4V5DxF
        I3H+reP6b9b6Kgtr3Eq3bOLKDGVKT/flb5+U5vaX87Rbxd3vPyZMK97fZaQW+e9sXW3E4jUJ
        5aI5z5Yo6v9bHfQxQ8QkskZaTUDCM+Nujk1VnP75i0WP3+yrfjhJZtWn60diyp9sNDsfYpO6
        3/XyvI8uYmJOXJvEZrxgfcXwoa8pyLF1xlUZqdVTQvg32rXN38P69vIFWZsJqp47UvneBswK
        3zc7RT5YoK/Xu/39HJljedq7VZieGJ1+fXJaT7jpgfz5v0vPJZ9mPMitJbq761DObwfmlsNc
        x64osRRnJBpqMRcVJwIAWcVHhdYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsWy7bCSvG6XvmCCwe75shZLmjIsdt3tYLf4
        OG0lk8WKLzPZLe48v8FocXnXHDaLs/OOs1m8+f2C3eLJlEesFkc3Blss2vqF3eL/nh3sFjfW
        szvweqyZt4bRY+esu+weCzaVemxa1cnm0bdlFaPHlv2fGT0+b5ILYI/isklJzcksSy3St0vg
        yuj671LwTKTi8f9fjA2MywS7GDk5JARMJB7d/cTYxcjFISSwm1Fi68lbTBAJSYnPF9dB2cIS
        K/89Z4coesYoMf3EPGaQBJuAjsSTK3/AbBEBR4nZe1uZQIqYBTYySfQd/s4KkhASmM4o8e96
        DIjNKeAm0XZgD1ADB4ewgLfE9wVFIGEWAVWJxokTwObwClhK7PvdwghhC0qcnPmEBcRmFtCW
        eHrzKZy9bOFrZojjFCR+Pl3GCnGDlcShzruMEDXiEi+PHmGfwCg8C8moWUhGzUIyahaSlgWM
        LKsYJVMLinPTc4sNCwzzUsv1ihNzi0vz0vWS83M3MYKjUktzB+P2VR/0DjEycTAeYpTgYFYS
        4bVTEEwQ4k1JrKxKLcqPLyrNSS0+xCjNwaIkznuh62S8kEB6YklqdmpqQWoRTJaJg1Oqgal4
        ue6uGpfzR6PVy1yP2HNPriusPBF5bm7xokDxpc/v9Zif9U5IZ7j22jq+tPAQ++6Fbk4zvyt9
        nLXY8uvWx0c3qZQW/JYS/Fj4R3ND+9kfM/zM99plnJydL+gwrY3z7ESZF39ffrLK0vhyNmDh
        csb+R2eCSnQv/vmxJrj9/JSjUcv43WYcW77xx/LIpamP9Q+cW5p/1X7Rmm98/ovvOQYfXLJq
        59bp+gYdrzdenn1gdlbbi6rWBLc/zt/EdvKe4O92S4uYMUlUaembvVnKbRd/7/xpmsF742Wl
        qX330giN3epzZ/MWbG3dw6S9rFFowWQNHmG7/FinaQue7Nn6Ltbpe/aRwuqDym8XtwnVHxcT
        VGIpzkg01GIuKk4EAPi1wbQ5AwAA
X-CMS-MailID: 20210127091658epcas5p377aa71fa163fea556d420136ce64c251
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210106105019epcas5p377bdbff5cd9e14e5107ccbf2b87b5754
References: <CGME20210106105019epcas5p377bdbff5cd9e14e5107ccbf2b87b5754@epcas5p3.samsung.com>
        <1609930210-19227-1-git-send-email-shradha.t@samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,
Gentle Ping..

Thanks

> -----Original Message-----
> From: Shradha Todi <shradha.t=40samsung.com>
> Sent: Wednesday, January 6, 2021 4:20 PM
> Subject: =5BPATCH v2=5D PCI: dwc: Add upper limit address for outbound iA=
TU
>=20
> The size parameter is unsigned long type which can accept size > 4GB. In =
that
> case, the upper limit address must be programmed. Add support to program =
the
> upper limit address and set INCREASE_REGION_SIZE in case size > 4GB.
>=20
> Signed-off-by: Shradha Todi <shradha.t=40samsung.com>
> ---
> v1: https://lkml.org/lkml/2020/12/20/187
> v2:
>    Addressed Rob's review comment and added PCI version check condition t=
o
>    avoid writing to reserved registers.
>=20
>  drivers/pci/controller/dwc/pcie-designware.c =7C 9 +++++++--
> drivers/pci/controller/dwc/pcie-designware.h =7C 1 +
>  2 files changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c
> b/drivers/pci/controller/dwc/pcie-designware.c
> index 74590c7..1d62ca9 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> =40=40 -290,12 +290,17 =40=40 static void __dw_pcie_prog_outbound_atu(str=
uct
> dw_pcie *pci, u8 func_no,
>  			   upper_32_bits(cpu_addr));
>  	dw_pcie_writel_dbi(pci, PCIE_ATU_LIMIT,
>  			   lower_32_bits(cpu_addr + size - 1));
> +	if (pci->version >=3D 0x460A)
> +		dw_pcie_writel_dbi(pci, PCIE_ATU_UPPER_LIMIT,
> +				   upper_32_bits(cpu_addr + size - 1));
>  	dw_pcie_writel_dbi(pci, PCIE_ATU_LOWER_TARGET,
>  			   lower_32_bits(pci_addr));
>  	dw_pcie_writel_dbi(pci, PCIE_ATU_UPPER_TARGET,
>  			   upper_32_bits(pci_addr));
> -	dw_pcie_writel_dbi(pci, PCIE_ATU_CR1, type =7C
> -			   PCIE_ATU_FUNC_NUM(func_no));
> +	val =3D type =7C PCIE_ATU_FUNC_NUM(func_no);
> +	val =3D ((upper_32_bits(size - 1)) && (pci->version >=3D 0x460A)) ?
> +		val =7C PCIE_ATU_INCREASE_REGION_SIZE : val;
> +	dw_pcie_writel_dbi(pci, PCIE_ATU_CR1, val);
>  	dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, PCIE_ATU_ENABLE);
>=20
>  	/*
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h
> b/drivers/pci/controller/dwc/pcie-designware.h
> index 8b905a2..7da79eb 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> =40=40 -102,6 +102,7 =40=40
>  =23define PCIE_ATU_DEV(x)			FIELD_PREP(GENMASK(23, 19),
> x)
>  =23define PCIE_ATU_FUNC(x)		FIELD_PREP(GENMASK(18, 16), x)
>  =23define PCIE_ATU_UPPER_TARGET		0x91C
> +=23define PCIE_ATU_UPPER_LIMIT		0x924
>=20
>  =23define PCIE_MISC_CONTROL_1_OFF		0x8BC
>  =23define PCIE_DBI_RO_WR_EN		BIT(0)
> --
> 2.7.4


