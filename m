Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46EFC2EBD2F
	for <lists+linux-pci@lfdr.de>; Wed,  6 Jan 2021 12:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbhAFLcK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Jan 2021 06:32:10 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:57449 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbhAFLcJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Jan 2021 06:32:09 -0500
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210106113126epoutp03063368ecc5d5522e924edda2f916d0b4~XoT_R3jc03086230862epoutp031
        for <linux-pci@vger.kernel.org>; Wed,  6 Jan 2021 11:31:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210106113126epoutp03063368ecc5d5522e924edda2f916d0b4~XoT_R3jc03086230862epoutp031
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1609932686;
        bh=lmkyq8Nlom1m6NMi3K85HBE9w55RE7Wid/BQXbv/DBU=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=OiuL0lMDaMAQCCbRKfnv5DAFsvfZdyAOyGIbEl+5cLY8gXuLsNEUmn5zaJ0Th/rYI
         kbreGWE4lyqE4SlQ5Fk5xWvlYwRmmncYgAXMAyUAM5fdTwL03mj5lod1tIqwH7rDEx
         bbt0TL9GcQZEyOkwvC/ywMAG+HDoPEjs4Je4hmbI=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20210106113125epcas5p193f2dbac849dd612fc0de248c4dd2d55~XoT9eAifh2931929319epcas5p1-;
        Wed,  6 Jan 2021 11:31:25 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0D.24.50652.D8F95FF5; Wed,  6 Jan 2021 20:31:25 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20210106113124epcas5p2aef3f086ca351e044e892bf58d9074b9~XoT8hqUfb0032200322epcas5p2P;
        Wed,  6 Jan 2021 11:31:24 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210106113124epsmtrp2a6265edd927c030a624f67fe63a88263~XoT8gHrGh0037200372epsmtrp2r;
        Wed,  6 Jan 2021 11:31:24 +0000 (GMT)
X-AuditID: b6c32a4a-6b3ff7000000c5dc-fb-5ff59f8d6ed6
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        9B.F9.08745.C8F95FF5; Wed,  6 Jan 2021 20:31:24 +0900 (KST)
Received: from pankajdubey02 (unknown [107.122.12.6]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210106113122epsmtip20ee4ea9eb51111af1312061ace689642~XoT6s63b80358503585epsmtip2c;
        Wed,  6 Jan 2021 11:31:22 +0000 (GMT)
From:   "Pankaj Dubey" <pankaj.dubey@samsung.com>
To:     "'Shradha Todi'" <shradha.t@samsung.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Cc:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <robh@kernel.org>, <lorenzo.pieralisi@arm.com>,
        <bhelgaas@google.com>, <sriram.dash@samsung.com>,
        <niyas.ahmed@samsung.com>, <p.rajanbabu@samsung.com>,
        <l.mehra@samsung.com>, <hari.tv@samsung.com>
In-Reply-To: <1609930210-19227-1-git-send-email-shradha.t@samsung.com>
Subject: RE: [PATCH v2] PCI: dwc: Add upper limit address for outbound iATU
Date:   Wed, 6 Jan 2021 17:01:21 +0530
Message-ID: <000501d6e41f$76b1c810$64155830$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHJsRGfSFv8WioXtPNJkxsZ5VdGswG1HobKqiczqcA=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIKsWRmVeSWpSXmKPExsWy7bCmhm7v/K/xBk87+CyWNGVY7LrbwW7x
        cdpKJosVX2ayW9x5foPR4vKuOWwWZ+cdZ7N48/sFu8WTKY9YLY5uDLb4v2cHu0Xv4VqLG+vZ
        HXg91sxbw+ixc9Zddo8Fm0o9Nq3qZPPo27KK0WPL/s+MHp83yQWwR3HZpKTmZJalFunbJXBl
        PDx0mKngtETF2WlP2BsY34p0MXJySAiYSCzctoW9i5GLQ0hgN6PE9dYTbBDOJ0aJtxs7mECq
        hAQ+M0pM/5gD03Hg8QtGiKJdjBI3vr1mhCh6xSgx6XcgiM0moC9x7sc8VhBbRCBbYuHDg0wg
        DcwC7UwSV6aeAZvKKeAm0XZgD3MXIweHsIC3xPcFRSBhFgEViebjG5lBbF4BS4m5b9cyQtiC
        EidnPmEBsZkFtCWWLXzNDHGQgsTPp8tYQcaICFhJPL2aAVEiLvHy6BGwzyQETnBIfJx6gBWi
        3kXi2N/JLBC2sMSr4yDvg9hSEp/f7WWDsPMlfiyexAzR3MIoMfn4XKhme4kDV+awgCxjFtCU
        WL9LH2IZn0Tv7ydMIGEJAV6JjjYhiGo1ie/Pz0CdKSPxsHkpE4TtIbH46wGWCYyKs5B8NgvJ
        Z7OQvDALYdkCRpZVjJKpBcW56anFpgVGeanlesWJucWleel6yfm5mxjBqUzLawfjwwcf9A4x
        MnEwHmKU4GBWEuG1OPYlXog3JbGyKrUoP76oNCe1+BCjNAeLkjjvDoMH8UIC6YklqdmpqQWp
        RTBZJg5OqQamlR1R106F1BqmPi37xnSZ83bbsW9LWI+w/phQ+pHVWLTz09xnrCxXiqNW2Dhf
        kzFNXL1I2Msy7s5qJo7oPucnMYw79T1ul4Y4/AuyO7838/POOt55glsYRM4kRiv7fm+PbQj9
        Y22cq1YmLeHSIiH1PyLsnHHbicxNny9Y7fTep255ItNsaodFdrNHdeC/hVZfnlw8vqNfKSF5
        q+9Krs0HFxs62bKKbm+5c39eZPpViXxnp4ltD5/9+MY758pF+d4DH9rTus2Osvn1rf3M8tfv
        2dqzv2fs9y9UV2s8GMO4+M8NhsAe0/Nv06Z7VwbM3f205mKLj/Xlw5JnZrpxKl48n11ceDZn
        4+mlr7R2M7oosRRnJBpqMRcVJwIAmfvRtNQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCIsWRmVeSWpSXmKPExsWy7bCSvG7P/K/xBnsn8losacqw2HW3g93i
        47SVTBYrvsxkt7jz/AajxeVdc9gszs47zmbx5vcLdosnUx6xWhzdGGzxf88Odovew7UWN9az
        O/B6rJm3htFj56y77B4LNpV6bFrVyebRt2UVo8eW/Z8ZPT5vkgtgj+KySUnNySxLLdK3S+DK
        uHfgHHtBq0TF8bnr2BsYF4t0MXJySAiYSBx4/IKxi5GLQ0hgB6PEsYlXWCESMhKTV6+AsoUl
        Vv57zg5R9IJR4uLy+YwgCTYBfYlzP+aBFYkI5Er8OTuBGcRmFpjMJNE2XxbEFhKYzijx73oM
        iM0p4CbRdmAPUA0Hh7CAt8T3BUUgYRYBFYnm4xvBWnkFLCXmvl3LCGELSpyc+YQFYqS2RO/D
        VkYYe9nC18wQtylI/Hy6jBVkpIiAlcTTqxkQJeISL48eYZ/AKDwLyaRZSCbNQjJpFpKWBYws
        qxglUwuKc9Nziw0LjPJSy/WKE3OLS/PS9ZLzczcxgiNSS2sH455VH/QOMTJxMB5ilOBgVhLh
        tTj2JV6INyWxsiq1KD++qDQntfgQozQHi5I474Wuk/FCAumJJanZqakFqUUwWSYOTqkGJrP3
        Mgkpv8PCfX1EKyOO7OV4klt86eWLCg1fFp6Fzy5ZGbZ03ckWfHin03P/TZaVrqWhO2S7HCus
        vWabhbLKTdyam5J8/GZne0D+B61FCwRSTjOsXdjH+MfVbpposi2P01bPx40Zda5Wl68kJ36I
        3K3Se3eyv9Hug4tbDr5aU3Miwyt/XqyK2uTnG/49l3n8yS7B+lEOW/cbR6aA53r3D7CuenrK
        UESR+3ViuNTZlM779/ba/D+28v0f+bLZ/7NjVBZ7Mh1Y9+/JK47j0TM+JhaWTrq2qfLc97v/
        1C9Xqrx/t+/ythVXPeN8zXL5TTts5T7MLfsik3zW4lTIU8GNr04t38t/e8M7oaqoLzp3gpRY
        ijMSDbWYi4oTAYtuDpw3AwAA
X-CMS-MailID: 20210106113124epcas5p2aef3f086ca351e044e892bf58d9074b9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20210106105019epcas5p377bdbff5cd9e14e5107ccbf2b87b5754
References: <CGME20210106105019epcas5p377bdbff5cd9e14e5107ccbf2b87b5754@epcas5p3.samsung.com>
        <1609930210-19227-1-git-send-email-shradha.t@samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Shradha Todi <shradha.t=40samsung.com>
> Sent: Wednesday, January 6, 2021 4:20 PM
> To: linux-kernel=40vger.kernel.org; linux-pci=40vger.kernel.org
> Cc: jingoohan1=40gmail.com; gustavo.pimentel=40synopsys.com;
> robh=40kernel.org; lorenzo.pieralisi=40arm.com; bhelgaas=40google.com;
> pankaj.dubey=40samsung.com; sriram.dash=40samsung.com;
> niyas.ahmed=40samsung.com; p.rajanbabu=40samsung.com;
> l.mehra=40samsung.com; hari.tv=40samsung.com; Shradha Todi
> <shradha.t=40samsung.com>
> Subject: =5BPATCH v2=5D PCI: dwc: Add upper limit address for outbound iA=
TU
>=20
> The size parameter is unsigned long type which can accept size > 4GB. In =
that
> case, the upper limit address must be programmed. Add support to program
> the upper limit address and set INCREASE_REGION_SIZE in case size > 4GB.
>=20
> Signed-off-by: Shradha Todi <shradha.t=40samsung.com>
> ---
> v1: https://lkml.org/lkml/2020/12/20/187
> v2:
>    Addressed Rob's review comment and added PCI version check condition
> to
>    avoid writing to reserved registers.
>=20

Reviewed-by: Pankaj Dubey <pankaj.dubey=40samsung.com>

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
>  =23define PCIE_ATU_DEV(x)			FIELD_PREP(GENMASK(23,
> 19), x)
>  =23define PCIE_ATU_FUNC(x)		FIELD_PREP(GENMASK(18, 16), x)
>  =23define PCIE_ATU_UPPER_TARGET		0x91C
> +=23define PCIE_ATU_UPPER_LIMIT		0x924
>=20
>  =23define PCIE_MISC_CONTROL_1_OFF		0x8BC
>  =23define PCIE_DBI_RO_WR_EN		BIT(0)
> --
> 2.7.4


