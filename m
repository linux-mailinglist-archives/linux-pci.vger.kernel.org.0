Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7FC1C8031
	for <lists+linux-pci@lfdr.de>; Thu,  7 May 2020 04:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgEGCxA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 May 2020 22:53:00 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:33928 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgEGCxA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 May 2020 22:53:00 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0472qPD2001465;
        Wed, 6 May 2020 21:52:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1588819945;
        bh=77R+KN0P7OsXUgS4duR3XXp1coR50qLJMaCXXlSV/To=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=RxrFmj2xHI3XzwRDd6EzTkWMyRLVoJV6Gv7++CFw3vBoFCNYGBoD1neud85nJ/7Ui
         H4tk3kZFbkYIgVmPyDe4Y6M8dRGXJ2gD/vNMdLpf7k0jNXbSVu12/OJlC3NKQdOZDP
         pAViwat4VydyzOnRRomoWgYymz3/TFYv8phPKH54=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0472qPMY045107;
        Wed, 6 May 2020 21:52:25 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 6 May
 2020 21:52:25 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 6 May 2020 21:52:25 -0500
Received: from [10.250.233.85] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0472qJsC110440;
        Wed, 6 May 2020 21:52:20 -0500
Subject: Re: [PATCH v9 4/8] PCI: endpoint: Pass page size as argument to
 pci_epc_mem_init()
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Tom Joseph <tjoseph@cadence.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Lad Prabhakar <prabhakar.csengg@gmail.com>
References: <1587666159-6035-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1587666159-6035-5-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <8986f0a7-8e23-71d5-d718-def48a28dfc8@ti.com>
Date:   Thu, 7 May 2020 08:22:19 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1587666159-6035-5-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 4/23/2020 11:52 PM, Lad Prabhakar wrote:
> pci_epc_mem_init() internally used page size equal to *PAGE_SIZE* to
> manage the address space so instead just pass the page size as a
> argument to pci_epc_mem_init().
> 
> Also make pci_epc_mem_init() as a C function instead of a macro function
> in preparation for adding support for pci-epc-mem core to handle multiple
> windows.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/controller/cadence/pcie-cadence-ep.c | 2 +-
>  drivers/pci/controller/pcie-rockchip-ep.c        | 2 +-
>  drivers/pci/endpoint/pci-epc-mem.c               | 7 +++++++
>  include/linux/pci-epc.h                          | 5 ++---
>  4 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> index 1c173dad67d1..1c15c8352125 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> @@ -450,7 +450,7 @@ int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
>  		epc->max_functions = 1;
>  
>  	ret = pci_epc_mem_init(epc, pcie->mem_res->start,
> -			       resource_size(pcie->mem_res));
> +			       resource_size(pcie->mem_res), PAGE_SIZE);
>  	if (ret < 0) {
>  		dev_err(dev, "failed to initialize the memory space\n");
>  		goto err_init;
> diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
> index d743b0a48988..5eaf36629a75 100644
> --- a/drivers/pci/controller/pcie-rockchip-ep.c
> +++ b/drivers/pci/controller/pcie-rockchip-ep.c
> @@ -615,7 +615,7 @@ static int rockchip_pcie_ep_probe(struct platform_device *pdev)
>  	rockchip_pcie_write(rockchip, BIT(0), PCIE_CORE_PHY_FUNC_CFG);
>  
>  	err = pci_epc_mem_init(epc, rockchip->mem_res->start,
> -			       resource_size(rockchip->mem_res));
> +			       resource_size(rockchip->mem_res), PAGE_SIZE);
>  	if (err < 0) {
>  		dev_err(dev, "failed to initialize the memory space\n");
>  		goto err_uninit_port;
> diff --git a/drivers/pci/endpoint/pci-epc-mem.c b/drivers/pci/endpoint/pci-epc-mem.c
> index abfac1109a13..cdd1d3821249 100644
> --- a/drivers/pci/endpoint/pci-epc-mem.c
> +++ b/drivers/pci/endpoint/pci-epc-mem.c
> @@ -93,6 +93,13 @@ return ret;
>  }
>  EXPORT_SYMBOL_GPL(__pci_epc_mem_init);
>  
> +int pci_epc_mem_init(struct pci_epc *epc, phys_addr_t base,
> +		     size_t size, size_t page_size)
> +{
> +	return __pci_epc_mem_init(epc, base, size, page_size);
> +}
> +EXPORT_SYMBOL_GPL(pci_epc_mem_init);
> +
>  /**
>   * pci_epc_mem_exit() - cleanup the pci_epc_mem structure
>   * @epc: the EPC device that invoked pci_epc_mem_exit
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index e0ed9d01f6e5..5bc1de65849e 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
> @@ -137,9 +137,6 @@ struct pci_epc_features {
>  #define devm_pci_epc_create(dev, ops)    \
>  		__devm_pci_epc_create((dev), (ops), THIS_MODULE)
>  
> -#define pci_epc_mem_init(epc, phys_addr, size)	\
> -		__pci_epc_mem_init((epc), (phys_addr), (size), PAGE_SIZE)
> -
>  static inline void epc_set_drvdata(struct pci_epc *epc, void *data)
>  {
>  	dev_set_drvdata(&epc->dev, data);
> @@ -195,6 +192,8 @@ unsigned int pci_epc_get_first_free_bar(const struct pci_epc_features
>  struct pci_epc *pci_epc_get(const char *epc_name);
>  void pci_epc_put(struct pci_epc *epc);
>  
> +int pci_epc_mem_init(struct pci_epc *epc, phys_addr_t base,
> +		     size_t size, size_t page_size);
>  int __pci_epc_mem_init(struct pci_epc *epc, phys_addr_t phys_addr, size_t size,
>  		       size_t page_size);
>  void pci_epc_mem_exit(struct pci_epc *epc);
> 
