Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 873D174F913
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jul 2023 22:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjGKUcC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jul 2023 16:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbjGKUcB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jul 2023 16:32:01 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C2B10C4;
        Tue, 11 Jul 2023 13:31:57 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so9838068e87.2;
        Tue, 11 Jul 2023 13:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689107516; x=1691699516;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JXtkIoco6DuVQ6fZ+VQyGkgj2zfXyu0LCNnqFu3Vrpg=;
        b=gGxLlBC6tjXycxTWCfaUY9UxfZr1V0OUgLiTtVHdICl+oMZwy8MXrMOWUF+ibR/gso
         SVIUdHm/LL8cvxvRQFq8BeGHtplDc3qNSXgq7q/QsCxjMS3T3d4BNrAXt8D2z5bCPWEL
         t/pwe3RSKDr/3VNJanFEW5krV3AMIt3RglRwcad+XY+0iRdHE/Eo9deX6egnb9g+XCgl
         zcI/iZYUm3eX/Yf3qTUH5nnnuoGWy7ur4KdFfMaVDdkXJAyMLinhlg+1WIwP2fbN1S4F
         OmcKElXaor7Br9vJbqt2kWhyfeBXXU7GvLZ8+mYW2SkgCh/WgS4E++Y2hHRGfzDKxEVW
         uL4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689107516; x=1691699516;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JXtkIoco6DuVQ6fZ+VQyGkgj2zfXyu0LCNnqFu3Vrpg=;
        b=dwCJKU9oNLVcYWAuu4IWO8idhyl+hoCGkkKOTIlkhzSvZn4xQ92uRa2rL1idswcZ9Z
         iXAR4KcUxVJ0D9IB1YZrywk9ztUg0gkvzxGgNdUn2Bo2h4E9T/8qjwxUEeTeRqmTCEE0
         W9cb/BhPxrgYaCULHFTgKw4bglpEe5SjvJ554CEgMSvf2dSg6NfzDMwehQbgnE/CVyT4
         GzdT/+DSoYY4KhvUX6tVxUXDwXoDnFFdf1RSiQiwPilfz/pCYEhwZrrdUcYoXbiogPeE
         dsL+Y3v4FcuCL2WAZjrUVLuDHj8vlhXuXTrkyz9+qU6Qn6EuOuRbbb34X6cpzk/bQSPL
         1PcA==
X-Gm-Message-State: ABy/qLbbPClqyasHVKKaIQtJt3MePXZp3nIxLCp1xpAdIEAYbMMkr04g
        jl6ahGQFqi5i9s6oPg3k/XI=
X-Google-Smtp-Source: APBJJlGQj6B3wPs6L6FrywsrLJlk2COMpuEpijOaEj2nEHwwzTAh3FMmlePVUHbY0rIaDzEK2CH1Tw==
X-Received: by 2002:ac2:5f86:0:b0:4fb:7c40:9f95 with SMTP id r6-20020ac25f86000000b004fb7c409f95mr12414768lfe.47.1689107515322;
        Tue, 11 Jul 2023 13:31:55 -0700 (PDT)
Received: from mobilestation ([95.79.172.181])
        by smtp.gmail.com with ESMTPSA id v5-20020a197405000000b004fbc01e17c0sm437906lfe.82.2023.07.11.13.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 13:31:54 -0700 (PDT)
Date:   Tue, 11 Jul 2023 23:31:52 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        robh+dt@kernel.org, bhelgaas@google.com, kishon@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v17 07/20] PCI: dwc: endpoint: Add multiple PFs support
 for dbi2
Message-ID: <j4g4ijnxd7qyacszlwyi3tdztkw2nmnjwyhdqf2l2yj3h2mvje@iqsrqiodqbhq>
References: <20230705114206.3585188-1-yoshihiro.shimoda.uh@renesas.com>
 <20230705114206.3585188-8-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705114206.3585188-8-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 05, 2023 at 08:41:53PM +0900, Yoshihiro Shimoda wrote:
> The commit 24ede430fa49 ("PCI: designware-ep: Add multiple PFs support
> for DWC") added .func_conf_select() to get the configuration space of
> different PFs and assumed that the offsets between dbi and dbi would
> be the same. However, Renesas R-Car Gen4 PCIe controllers have different
> offsets of function 1: dbi (+0x1000) and dbi2 (+0x800). To get
> the offset for dbi2, add .func_conf_select2() and
> dw_pcie_ep_func_select2().
> 
> Notes that dw_pcie_ep_func_select2() will call .func_conf_select()
> if .func_conf_select2() doesn't exist for backward compatibility.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  .../pci/controller/dwc/pcie-designware-ep.c   | 32 ++++++++++++++-----
>  drivers/pci/controller/dwc/pcie-designware.h  |  3 +-
>  2 files changed, 26 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 1d24ebf9686f..bd57516d5313 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -54,21 +54,35 @@ static unsigned int dw_pcie_ep_func_select(struct dw_pcie_ep *ep, u8 func_no)
>  	return func_offset;
>  }
>  
> +static unsigned int dw_pcie_ep_func_select2(struct dw_pcie_ep *ep, u8 func_no)
> +{
> +	unsigned int func_offset = 0;
> +
> +	if (ep->ops->func_conf_select2)
> +		func_offset = ep->ops->func_conf_select2(ep, func_no);
> +	else if (ep->ops->func_conf_select)	/* for backward compatibility */
> +		func_offset = ep->ops->func_conf_select(ep, func_no);
> +
> +	return func_offset;
> +}
> +
>  static void __dw_pcie_ep_reset_bar(struct dw_pcie *pci, u8 func_no,
>  				   enum pci_barno bar, int flags)
>  {
> -	u32 reg;
> -	unsigned int func_offset = 0;
> +	u32 reg, reg_dbi2;
> +	unsigned int func_offset, func_offset_dbi2;
>  	struct dw_pcie_ep *ep = &pci->ep;
>  
>  	func_offset = dw_pcie_ep_func_select(ep, func_no);
> +	func_offset_dbi2 = dw_pcie_ep_func_select2(ep, func_no);

IMO this will make the code even more complicated than it's already
with the offsets calculated and added here and there. What about
implementing a set of methods like this:

+static void dw_pcie_ep_writeX_dbi(struct dw_pcie_ep *ep, u8 func_no, u32 reg, uYZ val)
+{
+	unsigned int ofs = dw_pcie_ep_func_select(ep, func_no);
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+
+	dw_pcie_writeX_dbi(pci, reg + ofs, val);
+}
+
+static uYZ dw_pcie_ep_readX_dbi(struct dw_pcie_ep *ep, u8 func_no, u32 reg)
+{
+	unsigned int ofs = dw_pcie_ep_func_select(ep, func_no);
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+
+	return dw_pcie_readX_dbi(pci, reg + ofs);
+}

and converting the entire DW PCIe EP core driver to using them instead
of always separately calculating the func_offset? Then in a subsequent
patch you can add a new method like this:

+static void dw_pcie_ep_writel_dbi2(struct dw_pcie_ep *ep, u8 func_no, u32 reg, u32 val)
+{
+	unsigned int ofs = dw_pcie_ep_func_select2(ep, func_no);
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+
+	dw_pcie_writel_dbi2(pci, reg + ofs, val);
+}

and have it utilized in the shadow registers update parts as you
originally intended. This will make the code much better readable with
no much harm to the performance since the most of setups are performed
once during the initial end-point configuration.

Note my suggestion is quite heavy to implement and implies the code
cleanup. So I'd wait for the maintainers comment about this (Mani is
now responsible for the driver maintaining).
Mani, Krzysztof, Lorenzo, Rob, what do you think about that?

-Serge(y)

>  
>  	reg = func_offset + PCI_BASE_ADDRESS_0 + (4 * bar);
> +	reg_dbi2 = func_offset_dbi2 + PCI_BASE_ADDRESS_0 + (4 * bar);
>  	dw_pcie_dbi_ro_wr_en(pci);
> -	dw_pcie_writel_dbi2(pci, reg, 0x0);
> +	dw_pcie_writel_dbi2(pci, reg_dbi2, 0x0);
>  	dw_pcie_writel_dbi(pci, reg, 0x0);
>  	if (flags & PCI_BASE_ADDRESS_MEM_TYPE_64) {
> -		dw_pcie_writel_dbi2(pci, reg + 4, 0x0);
> +		dw_pcie_writel_dbi2(pci, reg_dbi2 + 4, 0x0);
>  		dw_pcie_writel_dbi(pci, reg + 4, 0x0);
>  	}
>  	dw_pcie_dbi_ro_wr_dis(pci);
> @@ -232,13 +246,15 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  	enum pci_barno bar = epf_bar->barno;
>  	size_t size = epf_bar->size;
>  	int flags = epf_bar->flags;
> -	unsigned int func_offset = 0;
> +	unsigned int func_offset, func_offset_dbi2;
>  	int ret, type;
> -	u32 reg;
> +	u32 reg, reg_dbi2;
>  
>  	func_offset = dw_pcie_ep_func_select(ep, func_no);
> +	func_offset_dbi2 = dw_pcie_ep_func_select2(ep, func_no);
>  
>  	reg = PCI_BASE_ADDRESS_0 + (4 * bar) + func_offset;
> +	reg_dbi2 = PCI_BASE_ADDRESS_0 + (4 * bar) + func_offset_dbi2;
>  
>  	if (!(flags & PCI_BASE_ADDRESS_SPACE))
>  		type = PCIE_ATU_TYPE_MEM;
> @@ -254,11 +270,11 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  
>  	dw_pcie_dbi_ro_wr_en(pci);
>  
> -	dw_pcie_writel_dbi2(pci, reg, lower_32_bits(size - 1));
> +	dw_pcie_writel_dbi2(pci, reg_dbi2, lower_32_bits(size - 1));
>  	dw_pcie_writel_dbi(pci, reg, flags);
>  
>  	if (flags & PCI_BASE_ADDRESS_MEM_TYPE_64) {
> -		dw_pcie_writel_dbi2(pci, reg + 4, upper_32_bits(size - 1));
> +		dw_pcie_writel_dbi2(pci, reg_dbi2 + 4, upper_32_bits(size - 1));
>  		dw_pcie_writel_dbi(pci, reg + 4, 0);
>  	}
>  
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 812c221b3f7c..94bc20f5f600 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -340,9 +340,10 @@ struct dw_pcie_ep_ops {
>  	 * access for different platform, if different func have different
>  	 * offset, return the offset of func. if use write a register way
>  	 * return a 0, and implement code in callback function of platform
> -	 * driver.
> +	 * driver. The func_conf_select2 is for dbi2.
>  	 */
>  	unsigned int (*func_conf_select)(struct dw_pcie_ep *ep, u8 func_no);
> +	unsigned int (*func_conf_select2)(struct dw_pcie_ep *ep, u8 func_no);
>  };
>  
>  struct dw_pcie_ep_func {
> -- 
> 2.25.1
> 
