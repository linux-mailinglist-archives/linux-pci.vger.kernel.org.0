Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87D9C2EBD2B
	for <lists+linux-pci@lfdr.de>; Wed,  6 Jan 2021 12:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbhAFLar (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Jan 2021 06:30:47 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:31282 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbhAFLar (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Jan 2021 06:30:47 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210106113003epoutp04f1126ce56903926d9972c9a9323365c5~XoSxbSlQe0720707207epoutp04Q
        for <linux-pci@vger.kernel.org>; Wed,  6 Jan 2021 11:30:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210106113003epoutp04f1126ce56903926d9972c9a9323365c5~XoSxbSlQe0720707207epoutp04Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1609932603;
        bh=tEtOvPRttzk1ZWhWEEKAC399d33v2dQxEsVfrEgb1to=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=vLV3JEmmP6mPERQPNpsU5GEw1/pY9jZwnivdbqNjZha+p0BMvur7ZOWXIBiRNitnt
         JCz7D1SbqrgBoykbqY7em0AFdg4uDdOzg9E/McxQvvtgiMW9dmEBclnYjkqkwXZVX7
         u345Gzj9G0/DyyFXRxXtCGmbYcRibXNJjtyb1MJo=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20210106113002epcas5p31b459d77a0982be70cfbe10f16825387~XoSwSK1b-0800608006epcas5p3m;
        Wed,  6 Jan 2021 11:30:02 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        14.73.15682.A3F95FF5; Wed,  6 Jan 2021 20:30:02 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20210106113000epcas5p4cb15bdeb397da85972a627ab9be569bf~XoSu2vrBB1308413084epcas5p4E;
        Wed,  6 Jan 2021 11:30:00 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210106113000epsmtrp28b12d375beb0df27534692e4d8465c2e~XoSu13XHD3122631226epsmtrp2W;
        Wed,  6 Jan 2021 11:30:00 +0000 (GMT)
X-AuditID: b6c32a49-8bfff70000013d42-94-5ff59f3a79ed
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CB.93.13470.83F95FF5; Wed,  6 Jan 2021 20:30:00 +0900 (KST)
Received: from pankajdubey02 (unknown [107.122.12.6]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210106112958epsmtip20865a8d57f07e030013a09aab653987a~XoStApzdw3221732217epsmtip2Z;
        Wed,  6 Jan 2021 11:29:58 +0000 (GMT)
From:   "Pankaj Dubey" <pankaj.dubey@samsung.com>
To:     "'Shradha Todi'" <shradha.t@samsung.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Cc:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <robh@kernel.org>, <lorenzo.pieralisi@arm.com>,
        <bhelgaas@google.com>, <sriram.dash@samsung.com>,
        <niyas.ahmed@samsung.com>, <p.rajanbabu@samsung.com>,
        <l.mehra@samsung.com>, <hari.tv@samsung.com>
In-Reply-To: <1609929900-19082-1-git-send-email-shradha.t@samsung.com>
Subject: RE: [PATCH v2] PCI: dwc: Change size to u64 for EP outbound iATU
Date:   Wed, 6 Jan 2021 16:59:57 +0530
Message-ID: <000401d6e41f$44fae220$cef0a660$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIugMS81mxWyVxXUcStsAlB72BGxQKGN/EDqVcK7AA=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIKsWRmVeSWpSXmKPExsWy7bCmlq7V/K/xBk27xC2WNGVY7LrbwW7x
        cdpKJosVX2ayW9x5foPR4vKuOWwWZ+cdZ7N48/sFu8WTKY9YLY5uDLb4v2cHu0Xv4VqLG+vZ
        HXg91sxbw+ixc9Zddo8Fm0o9Nq3qZPPo27KK0WPL/s+MHp83yQWwR3HZpKTmZJalFunbJXBl
        dN0pKLglXHFz6TTWBsZFAl2MnBwSAiYS307+Zu1i5OIQEtjNKLF1zjcWkISQwCdGibnbOSES
        3xglVj/7zAjTsX7lHCaIor2MEls+iUEUvWKUWHl/DVgRm4C+xLkf81hBbBGBbImFDw8ygRQx
        C7QzSVyZegasm1PATeJ05zywBmEBT4n/z5aC2SwCKhJtqxqAajg4eAUsJd7dtwQJ8woISpyc
        +QTsOmYBeYntb+cwQxykIPHz6TKoXVYSfw5/h6oRl3h59Ag7yF4JgRMcEuf2nmeFaHCReHKt
        nQnCFpZ4dXwLO4QtJfH53V42CDtf4sfiScwQzS2MEpOPz4Vqtpc4cGUOC8hxzAKaEut36UMs
        45Po/f0E7GYJAV6JjjYhiGo1ie/Pz0DdKSPxsHkp1FoPiXdr1jFOYFScheS1WUhem4XkhVkI
        yxYwsqxilEwtKM5NTy02LTDMSy3XK07MLS7NS9dLzs/dxAhOZVqeOxjvPvigd4iRiYPxEKME
        B7OSCK/FsS/xQrwpiZVVqUX58UWlOanFhxilOViUxHl3GDyIFxJITyxJzU5NLUgtgskycXBK
        NTCxXsz6suZmtOc/lfOChl84T++NdU+3OSW1XZn3a9bGVXJhHGmCrxQtT2pdVFHa+2PVteO7
        b+Q3Hyq199nwvU+/cArDpMUWC47e3Pnz78TtmdtdNsfdmHn60/lDK2b0/X1v+8BS8Ehic+a8
        6/nT5wvL+MVaSagVCsvJ7wtP27z99FV5ndRn85+Ipaw5tuKqm+yFjmvvtvgsDbGJbbn389uq
        2SwxUUYNO+/ZpPQeMDi+tEBliy+DUiir7sTfIk93l8RVvZ3551/uqXeeTRtC19Ru0xL8lr59
        1Vv9r3ftjonvN9z9vWhGdw/r7zfN7zlL/BpLv8iWnBZUvz1TZ+7xvaqs0Tlno0TXLevaG/VN
        psvgpBJLcUaioRZzUXEiAK1hHCPUAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsWy7bCSvK7F/K/xBk2rDCyWNGVY7LrbwW7x
        cdpKJosVX2ayW9x5foPR4vKuOWwWZ+cdZ7N48/sFu8WTKY9YLY5uDLb4v2cHu0Xv4VqLG+vZ
        HXg91sxbw+ixc9Zddo8Fm0o9Nq3qZPPo27KK0WPL/s+MHp83yQWwR3HZpKTmZJalFunbJXBl
        dN0pKLglXHFz6TTWBsZFAl2MnBwSAiYS61fOYepi5OIQEtjNKLFp42I2iISMxOTVK1ghbGGJ
        lf+es0MUvWCUWPD9KCNIgk1AX+Lcj3lgRSICuRJ/zk5gBrGZBSYzSbTNl4VomM4ocfD2PSaQ
        BKeAm8TpznlgzcICnhL/ny0Fs1kEVCTaVjUA1XBw8ApYSry7bwkS5hUQlDg58wkLxExtid6H
        rYwQtrzE9rdzmCGOU5D4+XQZ1A1WEn8Of4eqF5d4efQI+wRG4VlIRs1CMmoWklGzkLQsYGRZ
        xSiZWlCcm55bbFhgmJdarlecmFtcmpeul5yfu4kRHJNamjsYt6/6oHeIkYmD8RCjBAezkgiv
        xbEv8UK8KYmVValF+fFFpTmpxYcYpTlYlMR5L3SdjBcSSE8sSc1OTS1ILYLJMnFwSjUwrXDh
        c2XYvvrux13z379d8fb2z0oNpqtlzRMj6hgumOh6tH8o2nL8/r0HzI9e1VlN83eoTbBaa/9i
        rwyrxX5PPukdt84skq6qnanPN2VviKzIHL0p++avuL6g4IfK3GMfPv3496PF8ZPYv1iLPaF8
        N+ZxLrHh4pwk/ChU33fdYtXaDX83xeZOftRbfULVacsaj12KYRY6dXzy+i75bud4Ob/c3jLn
        jmFj0dnqpcdF/p2wT/Kot42Jbg+KcZJddSvSb4qq9qmaCU90GHMXlE9JkuSXNY6Q+f7+9tvd
        v7e1brvexqCQHFbUM8XGS6PLZc/CVyKv1RwLHJsKKlMjTBbMsuCdlfcrNdvnGKfFFuY3SizF
        GYmGWsxFxYkAkLZO9DgDAAA=
X-CMS-MailID: 20210106113000epcas5p4cb15bdeb397da85972a627ab9be569bf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20210106104514epcas5p37d8e3a88aefdf109f7fb4157d4a1f07a
References: <CGME20210106104514epcas5p37d8e3a88aefdf109f7fb4157d4a1f07a@epcas5p3.samsung.com>
        <1609929900-19082-1-git-send-email-shradha.t@samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Shradha Todi <shradha.t@samsung.com>
> Sent: Wednesday, January 6, 2021 4:15 PM
> To: linux-kernel@vger.kernel.org; linux-pci@vger.kernel.org
> Cc: jingoohan1@gmail.com; gustavo.pimentel@synopsys.com;
> robh@kernel.org; lorenzo.pieralisi@arm.com; bhelgaas@google.com;
> pankaj.dubey@samsung.com; sriram.dash@samsung.com;
> niyas.ahmed@samsung.com; p.rajanbabu@samsung.com;
> l.mehra@samsung.com; hari.tv@samsung.com; Shradha Todi
> <shradha.t@samsung.com>
> Subject: [PATCH v2] PCI: dwc: Change size to u64 for EP outbound iATU
> 
> Since outbound iATU permits size to be greater than 4GB for which the
> support is also available, allow EP function to send u64 size instead of
> truncating to u32.
> 
> Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> ---
> v1: https://lkml.org/lkml/2020/12/18/690
> v2:
>    Addressed Bjorn's review on to keep commit message length limit to 75
> 

Reviewed-by: Pankaj Dubey <pankaj.dubey@samsung.com>

>  drivers/pci/controller/dwc/pcie-designware.c | 2 +-
> drivers/pci/controller/dwc/pcie-designware.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c
> b/drivers/pci/controller/dwc/pcie-designware.c
> index 1d62ca9..db407ed 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -326,7 +326,7 @@ void dw_pcie_prog_outbound_atu(struct dw_pcie
> *pci, int index, int type,
> 
>  void dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int
> index,
>  				  int type, u64 cpu_addr, u64 pci_addr,
> -				  u32 size)
> +				  u64 size)
>  {
>  	__dw_pcie_prog_outbound_atu(pci, func_no, index, type,
>  				    cpu_addr, pci_addr, size);
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h
> b/drivers/pci/controller/dwc/pcie-designware.h
> index 7da79eb..359151f 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -302,7 +302,7 @@ void dw_pcie_prog_outbound_atu(struct dw_pcie
> *pci, int index,
>  			       u64 size);
>  void dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int
> index,
>  				  int type, u64 cpu_addr, u64 pci_addr,
> -				  u32 size);
> +				  u64 size);
>  int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
>  			     int bar, u64 cpu_addr,
>  			     enum dw_pcie_as_type as_type);
> --
> 2.7.4


