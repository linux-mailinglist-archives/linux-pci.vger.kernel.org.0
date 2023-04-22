Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1AAC6EB97E
	for <lists+linux-pci@lfdr.de>; Sat, 22 Apr 2023 15:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjDVN6y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 22 Apr 2023 09:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjDVN6x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 22 Apr 2023 09:58:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F35E1FEC;
        Sat, 22 Apr 2023 06:58:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 156E360B55;
        Sat, 22 Apr 2023 13:58:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5EB9C433D2;
        Sat, 22 Apr 2023 13:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682171931;
        bh=IUvuLMwisDgxBhFdgyAMIitLWQcgTJ6vAaB7zwp0YmE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jsNysF1JZTlJrUU/BoFSPk0ZuZA7FmsKrX2x/YQMjgFebFR/Yz+5XSJAj64dkzw/x
         jfpUT1G3awWj6ZS+UR8V3I4zbC3DiAIUWc2mTPIxvdrhlEsSL6+1ufb/24AEysQn4y
         V9gJORnDpF8Ch+P2bHetKQaBEvBo57doxXoayoayraSPb33XunSUKcNrSIl+RRvByv
         CLzEjqZlnKTuDc+cqGp6ZbFi0D0I6NizQsuhKNDAsZNhtKgCJpwMrZneHO99WQifef
         oLPud4o82Pygxt3oUN5VDSO4mPpM8Zz01M5fJ1RBTsAW6W9R32QZEvaUj9hFwTju6z
         MXCSe546W5gBA==
Date:   Sat, 22 Apr 2023 19:28:43 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        fancer.lancer@gmail.com, lpieralisi@kernel.org, robh+dt@kernel.org,
        kw@linux.com, bhelgaas@google.com, kishon@kernel.org,
        marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v13 14/22] PCI: dwc: Expose dw_pcie_ep_exit() to module
Message-ID: <20230422135843.GK4769@thinkpad>
References: <20230418122403.3178462-1-yoshihiro.shimoda.uh@renesas.com>
 <20230418122403.3178462-15-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230418122403.3178462-15-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 18, 2023 at 09:23:55PM +0900, Yoshihiro Shimoda wrote:
> Expose dw_pcie_ep_exit() to module.
> 

This is not a good commit message. You need to mention why it is needed and list
any breakage observed without this.

- Mani

> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 304ed093f551..2458ca2bc0e4 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -681,6 +681,7 @@ void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
>  
>  	pci_epc_mem_exit(epc);
>  }
> +EXPORT_SYMBOL_GPL(dw_pcie_ep_exit);
>  
>  static unsigned int dw_pcie_ep_find_ext_capability(struct dw_pcie *pci, int cap)
>  {
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்
