Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC3027E9ED
	for <lists+linux-pci@lfdr.de>; Wed, 30 Sep 2020 15:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730457AbgI3N3a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Sep 2020 09:29:30 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:56170 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730281AbgI3N3a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Sep 2020 09:29:30 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08UDTGZA123665;
        Wed, 30 Sep 2020 08:29:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601472556;
        bh=hsoYuDPI+x+q3djG2vNEPwSnFj0POKxAxdbhK20UpDM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=DXbCdIspb69cak+SgVI7kRzJrnW5xcrkrBMKvcgxab/Y42mr4d3iWZ11TtOsXpk0m
         q/tij2lc/0AxZuyCZN/ak3PQHfa2PdIGNHFdTgMIagzPtSt9LhwJw07vW85x3OBBCN
         dEPce5xeZ5UlDrwcHNPw17rB4UvZkHpc4Gc1Lmf4=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08UDTFMX098718;
        Wed, 30 Sep 2020 08:29:15 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 30
 Sep 2020 08:29:15 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 30 Sep 2020 08:29:15 -0500
Received: from [10.250.232.108] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08UDTBPi053956;
        Wed, 30 Sep 2020 08:29:12 -0500
Subject: Re: [PATCH] PCI: layerscape: Change back to the default error
 response behavior
To:     Zhiqiang Hou <Zhiqiang.Hou@nxp.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <lorenzo.pieralisi@arm.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <minghuan.Lian@nxp.com>
CC:     <roy.zang@nxp.com>, <mingkai.hu@nxp.com>, <leoyang.li@nxp.com>
References: <20200929131328.13779-1-Zhiqiang.Hou@nxp.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <6e6d021b-bc46-63b4-7e84-6ca2c8e631f9@ti.com>
Date:   Wed, 30 Sep 2020 18:59:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200929131328.13779-1-Zhiqiang.Hou@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Hou,

On 29/09/20 6:43 pm, Zhiqiang Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> In the current error response behavior, it will send a SLVERR response
> to device's internal AXI slave system interface when the PCIe controller
> experiences an erroneous completion (UR, CA and CT) from an external
> completer for its outbound non-posted request, which will result in
> SError and crash the kernel directly.
> This patch change back it to the default behavior to increase the
> robustness of the kernel. In the default behavior, it always sends an
> OKAY response to the internal AXI slave interface when the controller
> gets these erroneous completions. And the AER driver will report and
> try to recover these errors.

I don't think not forwarding any error interrupts is a good idea. Maybe
you could disable it while reading configuration space registers
(vendorID and deviceID) and then enable error forwarding back?

Thanks
Kishon
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-layerscape.c | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
> index f24f79a70d9a..e92ab8a77046 100644
> --- a/drivers/pci/controller/dwc/pci-layerscape.c
> +++ b/drivers/pci/controller/dwc/pci-layerscape.c
> @@ -30,8 +30,6 @@
>  
>  /* PEX Internal Configuration Registers */
>  #define PCIE_STRFMR1		0x71c /* Symbol Timer & Filter Mask Register1 */
> -#define PCIE_ABSERR		0x8d0 /* Bridge Slave Error Response Register */
> -#define PCIE_ABSERR_SETTING	0x9401 /* Forward error of non-posted request */
>  
>  #define PCIE_IATU_NUM		6
>  
> @@ -123,14 +121,6 @@ static int ls_pcie_link_up(struct dw_pcie *pci)
>  	return 1;
>  }
>  
> -/* Forward error response of outbound non-posted requests */
> -static void ls_pcie_fix_error_response(struct ls_pcie *pcie)
> -{
> -	struct dw_pcie *pci = pcie->pci;
> -
> -	iowrite32(PCIE_ABSERR_SETTING, pci->dbi_base + PCIE_ABSERR);
> -}
> -
>  static int ls_pcie_host_init(struct pcie_port *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> @@ -142,7 +132,6 @@ static int ls_pcie_host_init(struct pcie_port *pp)
>  	 * dw_pcie_setup_rc() will reconfigure the outbound windows.
>  	 */
>  	ls_pcie_disable_outbound_atus(pcie);
> -	ls_pcie_fix_error_response(pcie);
>  
>  	dw_pcie_dbi_ro_wr_en(pci);
>  	ls_pcie_clear_multifunction(pcie);
> 
