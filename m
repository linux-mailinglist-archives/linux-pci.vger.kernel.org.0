Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC1975ECB4
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jul 2023 09:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjGXHqP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jul 2023 03:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjGXHqO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jul 2023 03:46:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F051BC6;
        Mon, 24 Jul 2023 00:46:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 865F260F60;
        Mon, 24 Jul 2023 07:46:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21A08C433C9;
        Mon, 24 Jul 2023 07:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690184772;
        bh=UVmBO2gCf2/YLN+4F7RNv/SKFqCFy9z4h+108FFe/80=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TEG5mta8qydZD6UKL85UqnWMBDjDtfjE7Uf2kAnQcmXufVNf2Rt19scAvw9b8528w
         vMbvv4Z15rEZJd86ImS53tlu4dTtlFZXqyBjuQSQrP6zslbMyzP36PdWGFVgwkGeEO
         bcE0YHq2PelIEhY5OnSKVZuLIp2pY4ucLHHQu74+86pOU8VoIp+pRZtMhIdK0psZUI
         Gt7HlgpK7neCDKsEP4aUJozX2GJVxxrS+PaSNbhqMLI+2NF8iesfpv7rmipSDTp6DX
         1/euAUkZGcSmGUDPakMqXutmWG0C+9vXQj+3lymtKdhjLbAlruYqZOyCn33AXXPTan
         1cufo2Lv3q5gQ==
Date:   Mon, 24 Jul 2023 13:15:56 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        manivannan.sadhasivam@linaro.org, bhelgaas@google.com,
        kishon@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, marek.vasut+renesas@gmail.com,
        fancer.lancer@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v18 04/20] PCI: dwc: Change arguments of
 dw_pcie_prog_outbound_atu()
Message-ID: <20230724074556.GC6291@thinkpad>
References: <20230721074452.65545-1-yoshihiro.shimoda.uh@renesas.com>
 <20230721074452.65545-5-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230721074452.65545-5-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 21, 2023 at 04:44:36PM +0900, Yoshihiro Shimoda wrote:
> The __dw_pcie_prog_outbound_atu() currently has 6 arguments.
> To support INTx IRQs in the future, it requires an additional 2
> arguments. For improved code readability, introduce the struct
> dw_pcie_ob_atu_cfg and update the arguments of
> dw_pcie_prog_outbound_atu().
> 
> Consequently, remove __dw_pcie_prog_outbound_atu() and
> dw_pcie_prog_ep_outbound_atu() because there is no longer
> a need.
> 
> No behavior changes.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

One nit below. With that,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> ---
>  .../pci/controller/dwc/pcie-designware-ep.c   | 21 +++++---
>  .../pci/controller/dwc/pcie-designware-host.c | 52 +++++++++++++------
>  drivers/pci/controller/dwc/pcie-designware.c  | 49 ++++++-----------
>  drivers/pci/controller/dwc/pcie-designware.h  | 15 ++++--
>  4 files changed, 77 insertions(+), 60 deletions(-)
> 

[...]

> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 3c06e025c905..85de0d8346fa 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -288,6 +288,15 @@ enum dw_pcie_core_rst {
>  	DW_PCIE_NUM_CORE_RSTS
>  };
>  
> +struct dw_pcie_ob_atu_cfg {
> +	int index;
> +	int type;
> +	u8 func_no;
> +	u64 cpu_addr;
> +	u64 pci_addr;
> +	u64 size;

Reorder the members in below order to avoid holes:

u64
int
u8

- Mani

> +};
> +
>  struct dw_pcie_host_ops {
>  	int (*host_init)(struct dw_pcie_rp *pp);
>  	void (*host_deinit)(struct dw_pcie_rp *pp);
> @@ -416,10 +425,8 @@ void dw_pcie_write_dbi2(struct dw_pcie *pci, u32 reg, size_t size, u32 val);
>  int dw_pcie_link_up(struct dw_pcie *pci);
>  void dw_pcie_upconfig_setup(struct dw_pcie *pci);
>  int dw_pcie_wait_for_link(struct dw_pcie *pci);
> -int dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
> -			      u64 cpu_addr, u64 pci_addr, u64 size);
> -int dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int index,
> -				 int type, u64 cpu_addr, u64 pci_addr, u64 size);
> +int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
> +			      const struct dw_pcie_ob_atu_cfg *atu);
>  int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int type,
>  			     u64 cpu_addr, u64 pci_addr, u64 size);
>  int dw_pcie_prog_ep_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்
