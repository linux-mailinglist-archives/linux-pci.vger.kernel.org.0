Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5032C6EB8C5
	for <lists+linux-pci@lfdr.de>; Sat, 22 Apr 2023 13:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjDVLPF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 22 Apr 2023 07:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDVLPF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 22 Apr 2023 07:15:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A601703;
        Sat, 22 Apr 2023 04:15:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6DF3260BEC;
        Sat, 22 Apr 2023 11:15:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 429DCC433D2;
        Sat, 22 Apr 2023 11:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682162102;
        bh=l3w0FMzdxB0P/xM6U6HuB/s2YmoY1YPHcnhCJ1gV3AU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rl1GHHrL5NH8SDlbr2LzyJglu2XxN+xShPcUKYGW2AKPSyKGLBR6Cwmu9meT8uRdc
         AeGf+4cIgzMsAfhsNXi0VuRuhzT4srzQrvIcOwgXjv6PpgaMPvCFDPeQq6Xx/qw8Qb
         E/xcoS0EOwnHPUwGHuZPUqChahDh354euyR0nCF1ky4IqbLcHlKBBV5ZgPWvI970SB
         SXAbRkXGV3M3+bt/u4HHAvjahi6a+w4SI/fgEab5hk52nGNec6t3YxPgY+njmDcoRj
         tA8XzT5eEjnZQQxl6y4nkNxtqNiUjK9Y3nuDC3kbWfQc1iPHfJQs23k3uPzSS4YEA0
         6C/L8ZtW6Rdnw==
Date:   Sat, 22 Apr 2023 16:44:55 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        fancer.lancer@gmail.com, lpieralisi@kernel.org, robh+dt@kernel.org,
        kw@linux.com, bhelgaas@google.com, kishon@kernel.org,
        marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v13 08/22] PCI: dwc: Change arguments of
 dw_pcie_prog_ep_outbound_atu()
Message-ID: <20230422111455.GD4769@thinkpad>
References: <20230418122403.3178462-1-yoshihiro.shimoda.uh@renesas.com>
 <20230418122403.3178462-9-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230418122403.3178462-9-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 18, 2023 at 09:23:49PM +0900, Yoshihiro Shimoda wrote:
> To use "code" and "routing" parameters on an outbound iATU,
> change arguments of dw_pcie_prog_ep_outbound_atu(). No behavior changes.
> 

Ok, you are using the struct here but it could've been done in 6/22.

- Mani

> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  .../pci/controller/dwc/pcie-designware-ep.c   | 21 ++++++++++++-------
>  drivers/pci/controller/dwc/pcie-designware.c  | 15 +++----------
>  drivers/pci/controller/dwc/pcie-designware.h  |  4 ++--
>  3 files changed, 18 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index a80b9fd03638..96375b0aba82 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -183,9 +183,8 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
>  	return 0;
>  }
>  
> -static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep, u8 func_no,
> -				   phys_addr_t phys_addr,
> -				   u64 pci_addr, size_t size)
> +static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep,
> +				   struct dw_pcie_outbound_atu *atu)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  	u32 free_win;
> @@ -197,13 +196,13 @@ static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep, u8 func_no,
>  		return -EINVAL;
>  	}
>  
> -	ret = dw_pcie_prog_ep_outbound_atu(pci, func_no, free_win, PCIE_ATU_TYPE_MEM,
> -					   phys_addr, pci_addr, size);
> +	atu->index = free_win;
> +	ret = dw_pcie_prog_ep_outbound_atu(pci, atu);
>  	if (ret)
>  		return ret;
>  
>  	set_bit(free_win, ep->ob_window_map);
> -	ep->outbound_addr[free_win] = phys_addr;
> +	ep->outbound_addr[free_win] = atu->cpu_addr;
>  
>  	return 0;
>  }
> @@ -306,8 +305,14 @@ static int dw_pcie_ep_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  	int ret;
>  	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> -
> -	ret = dw_pcie_ep_outbound_atu(ep, func_no, addr, pci_addr, size);
> +	struct dw_pcie_outbound_atu atu = { 0 };
> +
> +	atu.func_no = func_no;
> +	atu.type = PCIE_ATU_TYPE_MEM;
> +	atu.cpu_addr = addr;
> +	atu.pci_addr = pci_addr;
> +	atu.size = size;
> +	ret = dw_pcie_ep_outbound_atu(ep, &atu);
>  	if (ret) {
>  		dev_err(pci->dev, "Failed to enable address\n");
>  		return ret;
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 60e6522f0762..e8d4d5bde2d3 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -540,19 +540,10 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
>  	return __dw_pcie_prog_outbound_atu(pci, &atu);
>  }
>  
> -int dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int index,
> -				 int type, u64 cpu_addr, u64 pci_addr,
> -				 u64 size)
> +int dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci,
> +				 struct dw_pcie_outbound_atu *atu)
>  {
> -	struct dw_pcie_outbound_atu atu = { 0 };
> -
> -	atu.func_no = func_no;
> -	atu.index = index;
> -	atu.type = type;
> -	atu.cpu_addr = cpu_addr;
> -	atu.pci_addr = pci_addr;
> -	atu.size = size;
> -	return __dw_pcie_prog_outbound_atu(pci, &atu);
> +	return __dw_pcie_prog_outbound_atu(pci, atu);
>  }
>  
>  static inline u32 dw_pcie_readl_atu_ib(struct dw_pcie *pci, u32 index, u32 reg)
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 20a107c2e543..954d504890a1 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -435,8 +435,8 @@ void dw_pcie_upconfig_setup(struct dw_pcie *pci);
>  int dw_pcie_wait_for_link(struct dw_pcie *pci);
>  int dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
>  			      u64 cpu_addr, u64 pci_addr, u64 size);
> -int dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int index,
> -				 int type, u64 cpu_addr, u64 pci_addr, u64 size);
> +int dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci,
> +				 struct dw_pcie_outbound_atu *atu);
>  int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int type,
>  			     u64 cpu_addr, u64 pci_addr, u64 size);
>  int dw_pcie_prog_ep_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்
