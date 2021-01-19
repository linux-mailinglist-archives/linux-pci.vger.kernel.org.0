Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D30E2FB881
	for <lists+linux-pci@lfdr.de>; Tue, 19 Jan 2021 15:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390533AbhASMzi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Jan 2021 07:55:38 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:51025 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389207AbhASKlS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jan 2021 05:41:18 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210119104000epoutp015b47d2011ba2eb767ea87f65490442e0~bm-yKlsWo1165411654epoutp01D
        for <linux-pci@vger.kernel.org>; Tue, 19 Jan 2021 10:40:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210119104000epoutp015b47d2011ba2eb767ea87f65490442e0~bm-yKlsWo1165411654epoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1611052800;
        bh=UWEbuKD0Gjjm/J0hkgTFmlztBXn6nGW8Y4VqcJOGw1M=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=pSSNHiaWE3oPSNDfM9DdXrgAZihQoo8MrHfFAWUA1LkuaQLcPptjRZ23SLZCkEj6U
         lPc/wCjEhY0FouO3GGml3kDHKE3z+KBuE7D/hZV0IfVeKSiyJFPQ69m0OLFrn0HzkF
         HtrmuOC4gEzJHQnQeQDn9ZBP1QrnAlmhmqncQiVU=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20210119104000epcas5p4038247cdf198234fe84ae0b977f5b8b6~bm-xoGvM92063220632epcas5p4X;
        Tue, 19 Jan 2021 10:40:00 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        76.34.33964.FF6B6006; Tue, 19 Jan 2021 19:39:59 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20210119101206epcas5p2b31e6de44bfdda7d7819b17b11ad69bb~bmnbA_e151167611676epcas5p2O;
        Tue, 19 Jan 2021 10:12:06 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210119101206epsmtrp1fe56d64dc8c78463c94da3dfc42a8e95~bmna-6NdJ0268502685epsmtrp1h;
        Tue, 19 Jan 2021 10:12:06 +0000 (GMT)
X-AuditID: b6c32a4b-ea1ff700000184ac-71-6006b6ffa640
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1D.E5.13470.670B6006; Tue, 19 Jan 2021 19:12:06 +0900 (KST)
Received: from shradhat02 (unknown [107.122.8.248]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20210119101204epsmtip28499023aad8571cd774d03773fd3d2fb~bmnZFEtKu3005730057epsmtip2j;
        Tue, 19 Jan 2021 10:12:04 +0000 (GMT)
From:   "Shradha Todi" <shradha.t@samsung.com>
To:     <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Cc:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <robh@kernel.org>, <lorenzo.pieralisi@arm.com>,
        <bhelgaas@google.com>, <pankaj.dubey@samsung.com>,
        <sriram.dash@samsung.com>, <niyas.ahmed@samsung.com>,
        <p.rajanbabu@samsung.com>, <l.mehra@samsung.com>,
        <hari.tv@samsung.com>
In-Reply-To: <1609929900-19082-1-git-send-email-shradha.t@samsung.com>
Subject: RE: [PATCH v2] PCI: dwc: Change size to u64 for EP outbound iATU
Date:   Tue, 19 Jan 2021 15:42:03 +0530
Message-ID: <147901d6ee4b$8a39f3e0$9eaddba0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIugMS81mxWyVxXUcStsAlB72BGxQKGN/EDqWtjM7A=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMKsWRmVeSWpSXmKPExsWy7bCmlu7/bWwJBj1/LCyWNGVY7LrbwW7x
        cdpKJosVX2ayW9x5foPR4vKuOWwWZ+cdZ7N48/sFu8WTKY9YLY5uDLZYtPULu8X/PTvYLW6s
        Z3fg9Vgzbw2jx85Zd9k9Fmwq9di0qpPNo2/LKkaPLfs/M3p83iQXwB7FZZOSmpNZllqkb5fA
        lbHp/mTmgl6BikffT7M2MDbydjFyckgImEjMfLGJrYuRi0NIYDejxI01z1ghnE+MEp3357GB
        VAkJfGOUOHC9HKbj0I2JUEV7GSU+3fjFCOG8YJT417ifHaSKTUBH4smVP8xdjBwcIgL2Ek0/
        EkFqmAWWMklc/3SNEaSGU8BN4nTnPDBbWMBT4v+zpWA2i4CqxKevM8Dm8ApYSvxfsJEZwhaU
        ODnzCQuIzSwgL7H97RxmiIsUJH4+XcYKYosIWEk0zLzAClEjLvHy6BF2kMUSAmc4JPqWPmaH
        aHCR2D2jEapZWOLV8S1QcSmJl/1tUHa+xNQLT1lAHpAQqJBY3lMHEbaXOHBlDliYWUBTYv0u
        fYiwrMTUU+uYINbySfT+fsIEEeeV2DEPxlaW+PJ3DwuELSkx79hl1gmMSrOQfDYLyWezkHww
        C2HbAkaWVYySqQXFuempxaYFxnmp5XrFibnFpXnpesn5uZsYwelMy3sH46MHH/QOMTJxMB5i
        lOBgVhLhLV3HlCDEm5JYWZValB9fVJqTWnyIUZqDRUmcd4fBg3ghgfTEktTs1NSC1CKYLBMH
        p1QD0yZp8TPppdL5/lWf52ce/cromn9Y9zD7RZmV2QEWz1vOFFgw7VG+/7EjL+fU0vPbrT3e
        pa49+ku48gm39P6fjGV/nnyYGMngPre1Y+Na4XK7Ry+e/PHsjZJYEz1fOkLRbR9XpC/XzB7P
        M08SD4jMvXNRd9LOne77Hx+RC895dDewvnTCcx87/1Pbfty02ibVG/rbSvHM6XMO50U1MmR5
        T8nfkysv3MzT+ezV53O1PlMSpuwTXXJ0c5XlKu0Am8roH+e+Btm275se8JrJtiqjb9+/3YJL
        nvP7uK2rbhUpznpttV6J60tp97SULw1OlrsZyj2CHnRznb+87NWzX8/8zqqrf/W7cGnO0mO8
        f0786lNiKc5INNRiLipOBABl1xOV1gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRmVeSWpSXmKPExsWy7bCSvG7ZBrYEgz2vpS2WNGVY7LrbwW7x
        cdpKJosVX2ayW9x5foPR4vKuOWwWZ+cdZ7N48/sFu8WTKY9YLY5uDLZYtPULu8X/PTvYLW6s
        Z3fg9Vgzbw2jx85Zd9k9Fmwq9di0qpPNo2/LKkaPLfs/M3p83iQXwB7FZZOSmpNZllqkb5fA
        lbHp/mTmgl6BikffT7M2MDbydjFyckgImEgcujGRtYuRi0NIYDejxNJJT9ghEpISny+uY4Kw
        hSVW/nvODlH0jFFi8qxDbCAJNgEdiSdX/jCD2CICjhKz97YygRQxC2xkkug7/B1q7HRGiYO3
        74GN4hRwkzjdOY8RxBYW8JT4/2wpmM0ioCrx6esMsNW8ApYS/xdsZIawBSVOznzCAmIzC2hL
        PL35FMqWl9j+dg4zxHkKEj+fLmOFuMJKomHmBVaIGnGJl0ePsE9gFJ6FZNQsJKNmIRk1C0nL
        AkaWVYySqQXFuem5xYYFhnmp5XrFibnFpXnpesn5uZsYwbGppbmDcfuqD3qHGJk4GA8xSnAw
        K4nwlq5jShDiTUmsrEotyo8vKs1JLT7EKM3BoiTOe6HrZLyQQHpiSWp2ampBahFMlomDU6qB
        qcr9QGrKmrtLzZ6kxr7PnXxUwaf6O2v2xMfCQgZn13SHmOpZvHp/mLO9277eLbXjFx/T2dn/
        b6RdvvNS1kTCliVjzwab6X9S5r5TtakQKlLYfI7p4A656VYX/A7tb9p9rd52wdpmw0tiByKv
        hJ9SWBccdt401m63s13j0QURF8I2iBznCLXk2zljirSx7epPRiyXU3O3vFd12tS/0zmhoO32
        rO9aV+ew3DM70e4uk/fp+KZXUelGNbsE2OVPHX1d/4u36k+4usnb+bqzGjMdzP7qvP3QydQs
        6c57lTWttSb50vsrux5r/s10Pr6m9r7jJ/X0v/sNlx15nsymU1Nx9vi+Pb2vnjEe0r3Fnlcs
        qcRSnJFoqMVcVJwIAOR8u/E8AwAA
X-CMS-MailID: 20210119101206epcas5p2b31e6de44bfdda7d7819b17b11ad69bb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210106104514epcas5p37d8e3a88aefdf109f7fb4157d4a1f07a
References: <CGME20210106104514epcas5p37d8e3a88aefdf109f7fb4157d4a1f07a@epcas5p3.samsung.com>
        <1609929900-19082-1-git-send-email-shradha.t@samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Gentle Ping.
Thanks.

> -----Original Message-----
> From: Shradha Todi <shradha.t@samsung.com>
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
>  drivers/pci/controller/dwc/pcie-designware.c | 2 +-
>  drivers/pci/controller/dwc/pcie-designware.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c
> b/drivers/pci/controller/dwc/pcie-designware.c
> index 1d62ca9..db407ed 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -326,7 +326,7 @@ void dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
> int index, int type,
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
> @@ -302,7 +302,7 @@ void dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
> int index,
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

