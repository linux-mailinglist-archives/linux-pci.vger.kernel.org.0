Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18F6310AA64
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2019 06:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfK0Fqq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Nov 2019 00:46:46 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40680 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbfK0Fqq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Nov 2019 00:46:46 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xAR5kRXt037624;
        Tue, 26 Nov 2019 23:46:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1574833587;
        bh=pbjyit+/eT0xKveYxH3ND1fiaLHAJQP/vqwGnu53huU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=nPvLSJuPCeYfPGYlOexHZtSDYUhgIxtaNbC/tS5j0eupAFnHQcr0sluo/fpowGvGk
         tN1CzGOqXxgSvT4SYf6WCQiSylvCWXyvu73ZQEh577vKEQ2tqUyWDM79Li71ZJGwyM
         sF1Q8NZRDbS++lhdO/WnsroX0ZgndnENX7Y/uy4M=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xAR5kR6b067447
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Nov 2019 23:46:27 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 26
 Nov 2019 23:46:26 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 26 Nov 2019 23:46:26 -0600
Received: from [10.24.69.157] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAR5kI7S027431;
        Tue, 26 Nov 2019 23:46:19 -0600
Subject: Re: [PATCH 5/5] misc: pci_endpoint_test: add device-id for RZ/G2 pcie
 controller
To:     Lad Prabhakar <prabhakar.csengg@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        <linux-pci@vger.kernel.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Murray <andrew.murray@arm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-renesas-soc@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20191106193609.19645-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20191106193609.19645-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <5b768fcc-b3c2-eea6-3156-446ea7f9b118@ti.com>
Date:   Wed, 27 Nov 2019 11:15:36 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191106193609.19645-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 07/11/19 1:06 AM, Lad Prabhakar wrote:
> From: "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>

Please add a simple commit log here.

Thanks
Kishon

> 
> Signed-off-by: Lad, Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  drivers/misc/pci_endpoint_test.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index a5e317073d95..346b03b6e4b9 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -66,6 +66,8 @@
>  
>  #define PCI_DEVICE_ID_TI_AM654			0xb00c
>  
> +#define PCI_DEVICE_ID_RENESAS_RZG2		0x002d
> +
>  #define is_am654_pci_dev(pdev)		\
>  		((pdev)->device == PCI_DEVICE_ID_TI_AM654)
>  
> @@ -797,6 +799,7 @@ static const struct pci_device_id pci_endpoint_test_tbl[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_AM654),
>  	  .driver_data = (kernel_ulong_t)&am654_data
>  	},
> +	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_RZG2) },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(pci, pci_endpoint_test_tbl);
> 
