Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D927EAE57
	for <lists+linux-pci@lfdr.de>; Tue, 14 Nov 2023 11:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjKNKwf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Nov 2023 05:52:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKNKwe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Nov 2023 05:52:34 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F14186;
        Tue, 14 Nov 2023 02:52:29 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c50cf61f6dso75646031fa.2;
        Tue, 14 Nov 2023 02:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699959148; x=1700563948; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MiGXLmvRDdb+Www7N8zvaWUl2JSbQHy4Don+fAX4OAI=;
        b=EtSUC4SxcQB0UyfMJAZnzyZIyCIHbpL6Ub+abiPfrOsWy+a2eYQvTF5OvB50mIhzJN
         zCU5LWW79TUTlcBvy7ST3AkLXn46oaC7vwH5GyiJA8379OXG8vPeIlmjRMXr8DeXZTEz
         wkUoTYD7MJNgJYrk8b/JS9tKpxjoisiJFLZdDGFjsi7zZH5q1wXD0iqdv25PWwAfgA3u
         XHFSNMsa0wR5f3yIxmxJZKmU6/T3vJcAJQ0uA59wKXbeq+5CgytmxTs9CyjSYb/s+XEs
         uAqCms5sWozU3w+KoiR3FHqSC1/0st9dDGgxcVMhRNwLWCDcM+pRVsDhY2A5b5pqsji7
         ZveQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699959148; x=1700563948;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MiGXLmvRDdb+Www7N8zvaWUl2JSbQHy4Don+fAX4OAI=;
        b=FIiSzjabOi+dRMMJZF4PZiG7AJ8ykHp/0gI5J393gaY6nHQ2mO65yBgWBoRBlokQol
         mv9bD/DRN+VFqUplrcX+Dzokko3p1HiYYFJKKX3YueZnUr5mDfziM/HuJXLcu75ia+/X
         eZf5ZgzUn9VBkPbqBqirywjhwqsBeOK/eVU3cm69WAIGWNvLI53aOzzrl47wbgJiEyOa
         jMtqiZ1VRoEyaqfqXSUX8M1W8EvSyG6vFp44nNP7vH14cQGZokde7ynTL59BrKmNpdFt
         MIn9e80EH9KlPehIi8/dwxCYLB1JmwYrAvdB0N5da4iAbwTezI0eyyJkkE2pH6bGvKar
         w7sA==
X-Gm-Message-State: AOJu0YyApTRL8hMOTVyNgAdVRMudQc+Wpu0FUEZw/BKSLCSRDnjGdl3y
        wVIKmYF1ldRCxLPNpycPYmA=
X-Google-Smtp-Source: AGHT+IE9PdrZRmPPKjtZ7g+MzocMd9FllnEYhvcYqCcscmnCsiOqpUsEcPRNNPdx8X+72YM+SmmbcA==
X-Received: by 2002:a2e:91cc:0:b0:2ba:6519:c50f with SMTP id u12-20020a2e91cc000000b002ba6519c50fmr1770148ljg.52.1699959147731;
        Tue, 14 Nov 2023 02:52:27 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id j24-20020a2e8518000000b002c506c89511sm1269020lji.37.2023.11.14.02.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 02:52:27 -0800 (PST)
Date:   Tue, 14 Nov 2023 13:52:24 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, mani@kernel.org,
        linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 4/6] PCI: dwc: Add dw_pcie_ep_{read,write}_dbi[2]
 helpers
Message-ID: <qpw6zgqnxvnxqwzilelaev26xmjebimnyyvc5jzfgdyqgvjyvq@sne5unvwbea4>
References: <20231114055456.2231990-1-yoshihiro.shimoda.uh@renesas.com>
 <20231114055456.2231990-5-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114055456.2231990-5-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 14, 2023 at 02:54:54PM +0900, Yoshihiro Shimoda wrote:
> The current code calculated some dbi[2] registers' offset by calling
> dw_pcie_ep_get_dbi[2]_offset() in each function. To improve code
> readability, add dw_pcie_ep_{read,write}_dbi[2} and some data-width
> related helpers.

Nice update. Thanks!
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

I'll replicate my v1 nitpick regarding the accessors location here so
the maintainers would decide whether it worth being taken into
account.

> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  .../pci/controller/dwc/pcie-designware-ep.c   | 231 ++++++++++--------
>  1 file changed, 129 insertions(+), 102 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 1100671db887..2b5b5b0fa7a9 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -65,24 +65,88 @@ static unsigned int dw_pcie_ep_get_dbi2_offset(struct dw_pcie_ep *ep, u8 func_no
>  	return dbi2_offset;
>  }
>  
> +static u32 dw_pcie_ep_read_dbi(struct dw_pcie_ep *ep, u8 func_no, u32 reg,
> +			       size_t size)
> +{
> +	unsigned int offset = dw_pcie_ep_get_dbi_offset(ep, func_no);
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +
> +	return dw_pcie_read_dbi(pci, offset + reg, size);
> +}
> +
> +static void dw_pcie_ep_write_dbi(struct dw_pcie_ep *ep, u8 func_no, u32 reg,
> +				 size_t size, u32 val)
> +{
> +	unsigned int offset = dw_pcie_ep_get_dbi_offset(ep, func_no);
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +
> +	dw_pcie_write_dbi(pci, offset + reg, size, val);
> +}
> +
> +static void dw_pcie_ep_write_dbi2(struct dw_pcie_ep *ep, u8 func_no, u32 reg,
> +				  size_t size, u32 val)
> +{
> +	unsigned int offset = dw_pcie_ep_get_dbi2_offset(ep, func_no);
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +
> +	dw_pcie_write_dbi2(pci, offset + reg, size, val);
> +}
> +
> +static inline void dw_pcie_ep_writel_dbi(struct dw_pcie_ep *ep, u8 func_no,
> +					 u32 reg, u32 val)
> +{
> +	dw_pcie_ep_write_dbi(ep, func_no, reg, 0x4, val);
> +}
> +
> +static inline u32 dw_pcie_ep_readl_dbi(struct dw_pcie_ep *ep, u8 func_no,
> +				       u32 reg)
> +{
> +	return dw_pcie_ep_read_dbi(ep, func_no, reg, 0x4);
> +}
> +
> +static inline void dw_pcie_ep_writew_dbi(struct dw_pcie_ep *ep, u8 func_no,
> +					 u32 reg, u16 val)
> +{
> +	dw_pcie_ep_write_dbi(ep, func_no, reg, 0x2, val);
> +}
> +
> +static inline u16 dw_pcie_ep_readw_dbi(struct dw_pcie_ep *ep, u8 func_no,
> +				       u32 reg)
> +{
> +	return dw_pcie_ep_read_dbi(ep, func_no, reg, 0x2);
> +}
> +
> +static inline void dw_pcie_ep_writeb_dbi(struct dw_pcie_ep *ep, u8 func_no,
> +					 u32 reg, u8 val)
> +{
> +	dw_pcie_ep_write_dbi(ep, func_no, reg, 0x1, val);
> +}
> +
> +static inline u8 dw_pcie_ep_readb_dbi(struct dw_pcie_ep *ep, u8 func_no,
> +				      u32 reg)
> +{
> +	return dw_pcie_ep_read_dbi(ep, func_no, reg, 0x1);
> +}
> +
> +static inline void dw_pcie_ep_writel_dbi2(struct dw_pcie_ep *ep, u8 func_no,
> +					  u32 reg, u32 val)
> +{
> +	dw_pcie_ep_write_dbi2(ep, func_no, reg, 0x4, val);
> +}
> +

My comment was:

> From: Serge Semin, Sent: Monday, November 13, 2023 9:41 PM
> > I am not sure whether the methods above are supposed to be defined
> > here instead of being moved to the "pcie-designware.h" header file
> > together with dw_pcie_ep_get_dbi2_offset() and
> > dw_pcie_ep_get_dbi_offset(). The later place seems more suitable
> > seeing the accessors are generic, look similar to the
> > dw_pcie_{write,read}_dbi{,2}() functions and might be useful in the
> > platform drivers. On the other hand no LLDDs would have used it
> > currently. So I'll leave this as a food for thoughts for the driver
> > and subsystem maintainers.

Yoshihiro replied:
> Perhaps, when a device driver needs to use these functions actually,
> we can move these functions to pcie-designware.h, I think.

-Serge(y)

>  static void __dw_pcie_ep_reset_bar(struct dw_pcie *pci, u8 func_no,
>  				   enum pci_barno bar, int flags)
>  {
> -	unsigned int dbi_offset, dbi2_offset;
>  	struct dw_pcie_ep *ep = &pci->ep;
> -	u32 reg, reg_dbi2;
> -
> -	dbi_offset = dw_pcie_ep_get_dbi_offset(ep, func_no);
> -	dbi2_offset = dw_pcie_ep_get_dbi2_offset(ep, func_no);
> +	u32 reg;
>  
> -	reg = dbi_offset + PCI_BASE_ADDRESS_0 + (4 * bar);
> -	reg_dbi2 = dbi2_offset + PCI_BASE_ADDRESS_0 + (4 * bar);
> +	reg = PCI_BASE_ADDRESS_0 + (4 * bar);
>  	dw_pcie_dbi_ro_wr_en(pci);
> -	dw_pcie_writel_dbi2(pci, reg_dbi2, 0x0);
> -	dw_pcie_writel_dbi(pci, reg, 0x0);
> +	dw_pcie_ep_writel_dbi2(ep, func_no, reg, 0x0);
> +	dw_pcie_ep_writel_dbi(ep, func_no, reg, 0x0);
>  	if (flags & PCI_BASE_ADDRESS_MEM_TYPE_64) {
> -		dw_pcie_writel_dbi2(pci, reg_dbi2 + 4, 0x0);
> -		dw_pcie_writel_dbi(pci, reg + 4, 0x0);
> +		dw_pcie_ep_writel_dbi2(ep, func_no, reg + 4, 0x0);
> +		dw_pcie_ep_writel_dbi(ep, func_no, reg + 4, 0x0);
>  	}
>  	dw_pcie_dbi_ro_wr_dis(pci);
>  }
> @@ -99,19 +163,15 @@ void dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar)
>  EXPORT_SYMBOL_GPL(dw_pcie_ep_reset_bar);
>  
>  static u8 __dw_pcie_ep_find_next_cap(struct dw_pcie_ep *ep, u8 func_no,
> -		u8 cap_ptr, u8 cap)
> +				     u8 cap_ptr, u8 cap)
>  {
> -	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> -	unsigned int dbi_offset = 0;
>  	u8 cap_id, next_cap_ptr;
>  	u16 reg;
>  
>  	if (!cap_ptr)
>  		return 0;
>  
> -	dbi_offset = dw_pcie_ep_get_dbi_offset(ep, func_no);
> -
> -	reg = dw_pcie_readw_dbi(pci, dbi_offset + cap_ptr);
> +	reg = dw_pcie_ep_readw_dbi(ep, func_no, cap_ptr);
>  	cap_id = (reg & 0x00ff);
>  
>  	if (cap_id > PCI_CAP_ID_MAX)
> @@ -126,14 +186,10 @@ static u8 __dw_pcie_ep_find_next_cap(struct dw_pcie_ep *ep, u8 func_no,
>  
>  static u8 dw_pcie_ep_find_capability(struct dw_pcie_ep *ep, u8 func_no, u8 cap)
>  {
> -	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> -	unsigned int dbi_offset = 0;
>  	u8 next_cap_ptr;
>  	u16 reg;
>  
> -	dbi_offset = dw_pcie_ep_get_dbi_offset(ep, func_no);
> -
> -	reg = dw_pcie_readw_dbi(pci, dbi_offset + PCI_CAPABILITY_LIST);
> +	reg = dw_pcie_ep_readw_dbi(ep, func_no, PCI_CAPABILITY_LIST);
>  	next_cap_ptr = (reg & 0x00ff);
>  
>  	return __dw_pcie_ep_find_next_cap(ep, func_no, next_cap_ptr, cap);
> @@ -144,24 +200,21 @@ static int dw_pcie_ep_write_header(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  {
>  	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> -	unsigned int dbi_offset = 0;
> -
> -	dbi_offset = dw_pcie_ep_get_dbi_offset(ep, func_no);
>  
>  	dw_pcie_dbi_ro_wr_en(pci);
> -	dw_pcie_writew_dbi(pci, dbi_offset + PCI_VENDOR_ID, hdr->vendorid);
> -	dw_pcie_writew_dbi(pci, dbi_offset + PCI_DEVICE_ID, hdr->deviceid);
> -	dw_pcie_writeb_dbi(pci, dbi_offset + PCI_REVISION_ID, hdr->revid);
> -	dw_pcie_writeb_dbi(pci, dbi_offset + PCI_CLASS_PROG, hdr->progif_code);
> -	dw_pcie_writew_dbi(pci, dbi_offset + PCI_CLASS_DEVICE,
> -			   hdr->subclass_code | hdr->baseclass_code << 8);
> -	dw_pcie_writeb_dbi(pci, dbi_offset + PCI_CACHE_LINE_SIZE,
> -			   hdr->cache_line_size);
> -	dw_pcie_writew_dbi(pci, dbi_offset + PCI_SUBSYSTEM_VENDOR_ID,
> -			   hdr->subsys_vendor_id);
> -	dw_pcie_writew_dbi(pci, dbi_offset + PCI_SUBSYSTEM_ID, hdr->subsys_id);
> -	dw_pcie_writeb_dbi(pci, dbi_offset + PCI_INTERRUPT_PIN,
> -			   hdr->interrupt_pin);
> +	dw_pcie_ep_writew_dbi(ep, func_no, PCI_VENDOR_ID, hdr->vendorid);
> +	dw_pcie_ep_writew_dbi(ep, func_no, PCI_DEVICE_ID, hdr->deviceid);
> +	dw_pcie_ep_writeb_dbi(ep, func_no, PCI_REVISION_ID, hdr->revid);
> +	dw_pcie_ep_writeb_dbi(ep, func_no, PCI_CLASS_PROG, hdr->progif_code);
> +	dw_pcie_ep_writew_dbi(ep, func_no, PCI_CLASS_DEVICE,
> +			      hdr->subclass_code | hdr->baseclass_code << 8);
> +	dw_pcie_ep_writeb_dbi(ep, func_no, PCI_CACHE_LINE_SIZE,
> +			      hdr->cache_line_size);
> +	dw_pcie_ep_writew_dbi(ep, func_no, PCI_SUBSYSTEM_VENDOR_ID,
> +			      hdr->subsys_vendor_id);
> +	dw_pcie_ep_writew_dbi(ep, func_no, PCI_SUBSYSTEM_ID, hdr->subsys_id);
> +	dw_pcie_ep_writeb_dbi(ep, func_no, PCI_INTERRUPT_PIN,
> +			      hdr->interrupt_pin);
>  	dw_pcie_dbi_ro_wr_dis(pci);
>  
>  	return 0;
> @@ -243,18 +296,13 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  {
>  	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> -	unsigned int dbi_offset, dbi2_offset;
>  	enum pci_barno bar = epf_bar->barno;
>  	size_t size = epf_bar->size;
>  	int flags = epf_bar->flags;
> -	u32 reg, reg_dbi2;
>  	int ret, type;
> +	u32 reg;
>  
> -	dbi_offset = dw_pcie_ep_get_dbi_offset(ep, func_no);
> -	dbi2_offset = dw_pcie_ep_get_dbi2_offset(ep, func_no);
> -
> -	reg = PCI_BASE_ADDRESS_0 + (4 * bar) + dbi_offset;
> -	reg_dbi2 = PCI_BASE_ADDRESS_0 + (4 * bar) + dbi2_offset;
> +	reg = PCI_BASE_ADDRESS_0 + (4 * bar);
>  
>  	if (!(flags & PCI_BASE_ADDRESS_SPACE))
>  		type = PCIE_ATU_TYPE_MEM;
> @@ -270,12 +318,12 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  
>  	dw_pcie_dbi_ro_wr_en(pci);
>  
> -	dw_pcie_writel_dbi2(pci, reg_dbi2, lower_32_bits(size - 1));
> -	dw_pcie_writel_dbi(pci, reg, flags);
> +	dw_pcie_ep_writel_dbi2(ep, func_no, reg, lower_32_bits(size - 1));
> +	dw_pcie_ep_writel_dbi(ep, func_no, reg, flags);
>  
>  	if (flags & PCI_BASE_ADDRESS_MEM_TYPE_64) {
> -		dw_pcie_writel_dbi2(pci, reg_dbi2 + 4, upper_32_bits(size - 1));
> -		dw_pcie_writel_dbi(pci, reg + 4, 0);
> +		dw_pcie_ep_writel_dbi2(ep, func_no, reg + 4, upper_32_bits(size - 1));
> +		dw_pcie_ep_writel_dbi(ep, func_no, reg + 4, 0);
>  	}
>  
>  	ep->epf_bar[bar] = epf_bar;
> @@ -335,19 +383,15 @@ static int dw_pcie_ep_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  static int dw_pcie_ep_get_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
>  {
>  	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
> -	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> -	u32 val, reg;
> -	unsigned int dbi_offset = 0;
>  	struct dw_pcie_ep_func *ep_func;
> +	u32 val, reg;
>  
>  	ep_func = dw_pcie_ep_get_func_from_ep(ep, func_no);
>  	if (!ep_func || !ep_func->msi_cap)
>  		return -EINVAL;
>  
> -	dbi_offset = dw_pcie_ep_get_dbi_offset(ep, func_no);
> -
> -	reg = ep_func->msi_cap + dbi_offset + PCI_MSI_FLAGS;
> -	val = dw_pcie_readw_dbi(pci, reg);
> +	reg = ep_func->msi_cap + PCI_MSI_FLAGS;
> +	val = dw_pcie_ep_readw_dbi(ep, func_no, reg);
>  	if (!(val & PCI_MSI_FLAGS_ENABLE))
>  		return -EINVAL;
>  
> @@ -361,22 +405,19 @@ static int dw_pcie_ep_set_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  {
>  	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> -	u32 val, reg;
> -	unsigned int dbi_offset = 0;
>  	struct dw_pcie_ep_func *ep_func;
> +	u32 val, reg;
>  
>  	ep_func = dw_pcie_ep_get_func_from_ep(ep, func_no);
>  	if (!ep_func || !ep_func->msi_cap)
>  		return -EINVAL;
>  
> -	dbi_offset = dw_pcie_ep_get_dbi_offset(ep, func_no);
> -
> -	reg = ep_func->msi_cap + dbi_offset + PCI_MSI_FLAGS;
> -	val = dw_pcie_readw_dbi(pci, reg);
> +	reg = ep_func->msi_cap + PCI_MSI_FLAGS;
> +	val = dw_pcie_ep_readw_dbi(ep, func_no, reg);
>  	val &= ~PCI_MSI_FLAGS_QMASK;
>  	val |= FIELD_PREP(PCI_MSI_FLAGS_QMASK, interrupts);
>  	dw_pcie_dbi_ro_wr_en(pci);
> -	dw_pcie_writew_dbi(pci, reg, val);
> +	dw_pcie_ep_writew_dbi(ep, func_no, reg, val);
>  	dw_pcie_dbi_ro_wr_dis(pci);
>  
>  	return 0;
> @@ -385,19 +426,15 @@ static int dw_pcie_ep_set_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  static int dw_pcie_ep_get_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
>  {
>  	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
> -	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> -	u32 val, reg;
> -	unsigned int dbi_offset = 0;
>  	struct dw_pcie_ep_func *ep_func;
> +	u32 val, reg;
>  
>  	ep_func = dw_pcie_ep_get_func_from_ep(ep, func_no);
>  	if (!ep_func || !ep_func->msix_cap)
>  		return -EINVAL;
>  
> -	dbi_offset = dw_pcie_ep_get_dbi_offset(ep, func_no);
> -
> -	reg = ep_func->msix_cap + dbi_offset + PCI_MSIX_FLAGS;
> -	val = dw_pcie_readw_dbi(pci, reg);
> +	reg = ep_func->msix_cap + PCI_MSIX_FLAGS;
> +	val = dw_pcie_ep_readw_dbi(ep, func_no, reg);
>  	if (!(val & PCI_MSIX_FLAGS_ENABLE))
>  		return -EINVAL;
>  
> @@ -411,9 +448,8 @@ static int dw_pcie_ep_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  {
>  	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> -	u32 val, reg;
> -	unsigned int dbi_offset = 0;
>  	struct dw_pcie_ep_func *ep_func;
> +	u32 val, reg;
>  
>  	ep_func = dw_pcie_ep_get_func_from_ep(ep, func_no);
>  	if (!ep_func || !ep_func->msix_cap)
> @@ -421,21 +457,19 @@ static int dw_pcie_ep_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  
>  	dw_pcie_dbi_ro_wr_en(pci);
>  
> -	dbi_offset = dw_pcie_ep_get_dbi_offset(ep, func_no);
> -
> -	reg = ep_func->msix_cap + dbi_offset + PCI_MSIX_FLAGS;
> -	val = dw_pcie_readw_dbi(pci, reg);
> +	reg = ep_func->msix_cap + PCI_MSIX_FLAGS;
> +	val = dw_pcie_ep_readw_dbi(ep, func_no, reg);
>  	val &= ~PCI_MSIX_FLAGS_QSIZE;
>  	val |= interrupts;
>  	dw_pcie_writew_dbi(pci, reg, val);
>  
> -	reg = ep_func->msix_cap + dbi_offset + PCI_MSIX_TABLE;
> +	reg = ep_func->msix_cap + PCI_MSIX_TABLE;
>  	val = offset | bir;
> -	dw_pcie_writel_dbi(pci, reg, val);
> +	dw_pcie_ep_writel_dbi(ep, func_no, reg, val);
>  
> -	reg = ep_func->msix_cap + dbi_offset + PCI_MSIX_PBA;
> +	reg = ep_func->msix_cap + PCI_MSIX_PBA;
>  	val = (offset + (interrupts * PCI_MSIX_ENTRY_SIZE)) | bir;
> -	dw_pcie_writel_dbi(pci, reg, val);
> +	dw_pcie_ep_writel_dbi(ep, func_no, reg, val);
>  
>  	dw_pcie_dbi_ro_wr_dis(pci);
>  
> @@ -510,38 +544,34 @@ EXPORT_SYMBOL_GPL(dw_pcie_ep_raise_legacy_irq);
>  int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
>  			     u8 interrupt_num)
>  {
> -	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	u32 msg_addr_lower, msg_addr_upper, reg;
>  	struct dw_pcie_ep_func *ep_func;
>  	struct pci_epc *epc = ep->epc;
>  	unsigned int aligned_offset;
> -	unsigned int dbi_offset = 0;
>  	u16 msg_ctrl, msg_data;
> -	u32 msg_addr_lower, msg_addr_upper, reg;
> -	u64 msg_addr;
>  	bool has_upper;
> +	u64 msg_addr;
>  	int ret;
>  
>  	ep_func = dw_pcie_ep_get_func_from_ep(ep, func_no);
>  	if (!ep_func || !ep_func->msi_cap)
>  		return -EINVAL;
>  
> -	dbi_offset = dw_pcie_ep_get_dbi_offset(ep, func_no);
> -
>  	/* Raise MSI per the PCI Local Bus Specification Revision 3.0, 6.8.1. */
> -	reg = ep_func->msi_cap + dbi_offset + PCI_MSI_FLAGS;
> -	msg_ctrl = dw_pcie_readw_dbi(pci, reg);
> +	reg = ep_func->msi_cap + PCI_MSI_FLAGS;
> +	msg_ctrl = dw_pcie_ep_readw_dbi(ep, func_no, reg);
>  	has_upper = !!(msg_ctrl & PCI_MSI_FLAGS_64BIT);
> -	reg = ep_func->msi_cap + dbi_offset + PCI_MSI_ADDRESS_LO;
> -	msg_addr_lower = dw_pcie_readl_dbi(pci, reg);
> +	reg = ep_func->msi_cap + PCI_MSI_ADDRESS_LO;
> +	msg_addr_lower = dw_pcie_ep_readl_dbi(ep, func_no, reg);
>  	if (has_upper) {
> -		reg = ep_func->msi_cap + dbi_offset + PCI_MSI_ADDRESS_HI;
> -		msg_addr_upper = dw_pcie_readl_dbi(pci, reg);
> -		reg = ep_func->msi_cap + dbi_offset + PCI_MSI_DATA_64;
> -		msg_data = dw_pcie_readw_dbi(pci, reg);
> +		reg = ep_func->msi_cap + PCI_MSI_ADDRESS_HI;
> +		msg_addr_upper = dw_pcie_ep_readl_dbi(ep, func_no, reg);
> +		reg = ep_func->msi_cap + PCI_MSI_DATA_64;
> +		msg_data = dw_pcie_ep_readw_dbi(ep, func_no, reg);
>  	} else {
>  		msg_addr_upper = 0;
> -		reg = ep_func->msi_cap + dbi_offset + PCI_MSI_DATA_32;
> -		msg_data = dw_pcie_readw_dbi(pci, reg);
> +		reg = ep_func->msi_cap + PCI_MSI_DATA_32;
> +		msg_data = dw_pcie_ep_readw_dbi(ep, func_no, reg);
>  	}
>  	aligned_offset = msg_addr_lower & (epc->mem->window.page_size - 1);
>  	msg_addr = ((u64)msg_addr_upper) << 32 |
> @@ -582,10 +612,9 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
>  			      u16 interrupt_num)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> -	struct dw_pcie_ep_func *ep_func;
>  	struct pci_epf_msix_tbl *msix_tbl;
> +	struct dw_pcie_ep_func *ep_func;
>  	struct pci_epc *epc = ep->epc;
> -	unsigned int dbi_offset = 0;
>  	u32 reg, msg_data, vec_ctrl;
>  	unsigned int aligned_offset;
>  	u32 tbl_offset;
> @@ -597,10 +626,8 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
>  	if (!ep_func || !ep_func->msix_cap)
>  		return -EINVAL;
>  
> -	dbi_offset = dw_pcie_ep_get_dbi_offset(ep, func_no);
> -
> -	reg = ep_func->msix_cap + dbi_offset + PCI_MSIX_TABLE;
> -	tbl_offset = dw_pcie_readl_dbi(pci, reg);
> +	reg = ep_func->msix_cap + PCI_MSIX_TABLE;
> +	tbl_offset = dw_pcie_ep_readl_dbi(ep, func_no, reg);
>  	bir = FIELD_GET(PCI_MSIX_TABLE_BIR, tbl_offset);
>  	tbl_offset &= PCI_MSIX_TABLE_OFFSET;
>  
> -- 
> 2.34.1
> 
