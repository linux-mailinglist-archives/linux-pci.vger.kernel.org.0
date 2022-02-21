Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5001F4BD4C1
	for <lists+linux-pci@lfdr.de>; Mon, 21 Feb 2022 05:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242127AbiBUEdF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 20 Feb 2022 23:33:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiBUEdE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 20 Feb 2022 23:33:04 -0500
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7BABCA5;
        Sun, 20 Feb 2022 20:32:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1645417943; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=NnIMQs3eqT9dvkAwHO0Pfs0BsiKSqqI8wSehJWEqLFwmUDTHLBq709n4Gcqqc6k9KU1VZ055WgHojuizrp/JG3k577Ebs6f48j1djQR8xNs6yn+3Ec1OfKPqyRWgBNWqEOrAJ19FlRtfD87fksidMpxzop449KKEFTGpEYfv/EY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1645417943; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=uCoUDDXYDZzsCGNKoUijSlbDmsVGRznIPyBrOC7a1FI=; 
        b=cSAgGyPRvVZ6ojw9X4Bdj/M4i36PLolZsfBybaVstY4vGe/W3pFaqXUpHJQRQDbW1XXmqIYSJ3dqaKrlQe6k3Rit9KP+DUwtMYTVT6t1XKuF4yxdj/w59ANl1URdbxxWcEGJssQmXW9/sKwoUk6h1zEOj0Yh0j5ZM62F/lTladE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zohomail.com;
        spf=pass  smtp.mailfrom=lchen.firstlove@zohomail.com;
        dmarc=pass header.from=<lchen.firstlove@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1645417943;
        s=zm2020; d=zohomail.com; i=lchen.firstlove@zohomail.com;
        h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=uCoUDDXYDZzsCGNKoUijSlbDmsVGRznIPyBrOC7a1FI=;
        b=RXtBUmvg5Rc12/BgqaS2zheqOpe5HkHSssnxDiFCYNKh746tZJm3yotNxAwAijMV
        J0B1cOhXjDoMl3egYRaDt3f2cEZI1d1JALbkNQuFhOCH7he4eTR13Lbhuid29LCi+18
        vqbNhJ91DPMx1in60SLzCyUaOShUF62NE7YTv2Wk=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1645417942359465.9924319539059; Sun, 20 Feb 2022 20:32:22 -0800 (PST)
Received: from  [203.218.243.128] by mail.zoho.com
        with HTTP;Sun, 20 Feb 2022 20:32:22 -0800 (PST)
Date:   Mon, 21 Feb 2022 12:32:22 +0800
From:   Li Chen <lchen.firstlove@zohomail.com>
To:     "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     "Kishon Vijay Abraham I" <kishon@ti.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?=22Krzysztof_Wilczy=C5=84ski=22?= <kw@linux.com>,
        "Arnd Bergmann" <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Marek Vasut" <marek.vasut+renesas@gmail.com>,
        "Yoshihiro Shimoda" <yoshihiro.shimoda.uh@renesas.com>,
        "Rob Herring" <robh@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Prabhakar" <prabhakar.csengg@gmail.com>,
        "Biju Das" <biju.das.jz@bp.renesas.com>
Message-ID: <17f1a8d4d39.cd2b3cf9157009.883751358829258141@zohomail.com>
In-Reply-To: <20220126195043.28376-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220126195043.28376-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220126195043.28376-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [EXT] [RFC PATCH 5/5] PCI: rcar-ep: Add support for DMAC
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Prabhakar,

I have two questions:
1. You provide both INTERNAL_TO_PCIE and PCIE_TO_INTERNAL, does it mean rcar's IP can do R/W outbound DMA and R/W inbound DMA? As I know, some PCIe's controllers can only issue read requests for inbound DMA and write requests for outbound DMA, I wonder does rcar has this limitation?
2. You only provide DMAc support for EP, is it possible to use internal DMAC on RC, like read/write EP's bar using RC's internal DMAC?

Regards,
Li

 ---- On Thu, 27 Jan 2022 03:50:43 +0800 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote ----
 > R-Car PCIe controller has an internal DMAC to support data transfer
 > between Internal Bus -> PCI Express and vice versa.
 > 
 > This patch fills in the required flags and ops for the PCIe EP to
 > support DMAC transfer.
 > 
 > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
 > ---
 >  drivers/pci/controller/pcie-rcar-ep.c | 227 ++++++++++++++++++++++++++
 >  drivers/pci/controller/pcie-rcar.h    |  23 +++
 >  2 files changed, 250 insertions(+)
 > 
 > diff --git a/drivers/pci/controller/pcie-rcar-ep.c b/drivers/pci/controller/pcie-rcar-ep.c
 > index f9682df1da61..c49b25069328 100644
 > --- a/drivers/pci/controller/pcie-rcar-ep.c
 > +++ b/drivers/pci/controller/pcie-rcar-ep.c
 > @@ -18,6 +18,21 @@
 >  
 >  #define RCAR_EPC_MAX_FUNCTIONS        1
 >  
 > +#define RCAR_PCIE_MAX_DMAC_BYTE_COUNT        0x7FFFFFFU
 > +#define RCAR_PCIE_DMAC_BYTE_COUNT_MULTIPLE    8
 > +#define RCAR_PCIE_DMAC_TIMEOUT            (msecs_to_jiffies(3 * 1000))
 > +#define RCAR_PCIE_DMAC_DEFAULT_CHANNEL        0
 > +
 > +enum rcar_pcie_ep_dmac_xfr_status {
 > +    RCAR_PCIE_DMA_XFR_SUCCESS,
 > +    RCAR_PCIE_DMA_XFR_ERROR,
 > +};
 > +
 > +struct rcar_pcie_ep_dmac_info {
 > +    enum rcar_pcie_ep_dmac_xfr_status status;
 > +    size_t bytes;
 > +};
 > +
 >  /* Structure representing the PCIe interface */
 >  struct rcar_pcie_endpoint {
 >      struct rcar_pcie    pcie;
 > @@ -28,8 +43,114 @@ struct rcar_pcie_endpoint {
 >      unsigned long        *ib_window_map;
 >      u32            num_ib_windows;
 >      u32            num_ob_windows;
 > +    struct completion    irq_raised;
 > +    struct mutex        dma_operation;
 > +    spinlock_t        lock;
 > +    struct rcar_pcie_ep_dmac_info xfr;
 >  };
 >  
 > +static inline bool rcar_pcie_ep_is_dmac_active(struct rcar_pcie_endpoint *ep)
 > +{
 > +    if (rcar_pci_read_reg(&ep->pcie, PCIEDMAOR) & PCIEDMAOR_DMAACT)
 > +        return true;
 > +
 > +    return false;
 > +}
 > +
 > +static void
 > +rcar_pcie_ep_setup_dmac_request(struct rcar_pcie_endpoint *ep,
 > +                dma_addr_t dma_dst, dma_addr_t dma_src,
 > +                size_t len, enum pci_epf_xfr_direction dir, u8 ch)
 > +{
 > +    struct rcar_pcie *pcie = &ep->pcie;
 > +    u32 val;
 > +
 > +    ep->xfr.status = RCAR_PCIE_DMA_XFR_ERROR;
 > +    ep->xfr.bytes = RCAR_PCIE_MAX_DMAC_BYTE_COUNT;
 > +
 > +    /* swap values if xfr is from pcie to internal */
 > +    if (dir == PCIE_TO_INTERNAL)
 > +        swap(dma_dst, dma_src);
 > +
 > +    /* Configure the PCI Express lower */
 > +    rcar_pci_write_reg(pcie, lower_32_bits(dma_dst), PCIEDMPALR(ch));
 > +
 > +    /* Configure the PCI Express upper */
 > +    rcar_pci_write_reg(pcie, upper_32_bits(dma_dst), PCIEDMPAUR(ch));
 > +
 > +    /* Configure the internal bus address */
 > +    rcar_pci_write_reg(pcie, lower_32_bits(dma_src), PCIEDMIAR(ch));
 > +
 > +    /* Configure the byte count values */
 > +    rcar_pci_write_reg(pcie, len, PCIEDMBCNTR(ch));
 > +
 > +    /* Enable interrupts */
 > +    val = rcar_pci_read_reg(pcie, PCIEDMCHSR(ch));
 > +
 > +    /* set enable flags */
 > +    val |= PCIEDMCHSR_IE;
 > +    val |= PCIEDMCHSR_IBEE;
 > +    val |= PCIEDMCHSR_PEEE;
 > +    val |= PCIEDMCHSR_CHTCE;
 > +
 > +    /* Clear error flags */
 > +    val &= ~PCIEDMCHSR_TE;
 > +    val &= ~PCIEDMCHSR_PEE;
 > +    val &= ~PCIEDMCHSR_IBE;
 > +    val &= ~PCIEDMCHSR_CHTC;
 > +
 > +    rcar_pci_write_reg(pcie, val, PCIEDMCHSR(ch));
 > +
 > +    wmb(); /* flush the settings */
 > +}
 > +
 > +static void rcar_pcie_ep_execute_dmac_request(struct rcar_pcie_endpoint *ep,
 > +                          enum pci_epf_xfr_direction dir, u8 ch)
 > +{
 > +    struct rcar_pcie *pcie = &ep->pcie;
 > +    u32 val;
 > +
 > +    /* Enable DMA */
 > +    val = rcar_pci_read_reg(pcie, PCIEDMAOR);
 > +    val |= PCIEDMAOR_DMAE;
 > +    rcar_pci_write_reg(pcie, val, PCIEDMAOR);
 > +
 > +    /* Configure the DMA direction */
 > +    val = rcar_pci_read_reg(pcie, PCIEDMCHCR(ch));
 > +    if (dir == INTERNAL_TO_PCIE)
 > +        val |= PCIEDMCHCR_DIR;
 > +    else
 > +        val &= ~PCIEDMCHCR_DIR;
 > +
 > +    val |= PCIEDMCHCR_CHE;
 > +    rcar_pci_write_reg(pcie, val, PCIEDMCHCR(ch));
 > +
 > +    wmb(); /* flush the settings */
 > +}
 > +
 > +static enum rcar_pcie_ep_dmac_xfr_status
 > +rcar_pcie_ep_get_dmac_status(struct rcar_pcie_endpoint *ep,
 > +                 size_t *count, u8 ch)
 > +{
 > +    *count = ep->xfr.bytes;
 > +    return ep->xfr.status;
 > +}
 > +
 > +static void rcar_pcie_ep_stop_dmac_request(struct rcar_pcie_endpoint *ep, u8 ch)
 > +{
 > +    struct rcar_pcie *pcie = &ep->pcie;
 > +    u32 val;
 > +
 > +    val = rcar_pci_read_reg(pcie, PCIEDMCHCR(ch));
 > +    val &= ~PCIEDMCHCR_CHE;
 > +    rcar_pci_write_reg(pcie, val, PCIEDMCHCR(ch));
 > +
 > +    /* Disable interrupt */
 > +    val = rcar_pci_read_reg(pcie, PCIEDMAOR);
 > +    val &= ~PCIEDMAOR_DMAE;
 > +    rcar_pci_write_reg(pcie, val, PCIEDMAOR);
 > +}
 > +
 >  static void rcar_pcie_ep_hw_init(struct rcar_pcie *pcie)
 >  {
 >      u32 val;
 > @@ -419,6 +540,44 @@ static int rcar_pcie_ep_raise_irq(struct pci_epc *epc, u8 fn, u8 vfn,
 >      }
 >  }
 >  
 > +static int rcar_pcie_ep_data_transfer(struct pci_epc *epc, struct pci_epf *epf,
 > +                      dma_addr_t dma_dst, dma_addr_t dma_src,
 > +                      size_t len, enum pci_epf_xfr_direction dir)
 > +{
 > +    struct rcar_pcie_endpoint *ep = epc_get_drvdata(epc);
 > +    u8 ch = RCAR_PCIE_DMAC_DEFAULT_CHANNEL;
 > +    enum rcar_pcie_ep_dmac_xfr_status stat;
 > +    int ret = -EINVAL;
 > +    long wait_status;
 > +    size_t count;
 > +
 > +    if (len > RCAR_PCIE_MAX_DMAC_BYTE_COUNT ||
 > +        (len % RCAR_PCIE_DMAC_BYTE_COUNT_MULTIPLE) != 0)
 > +        return -EINVAL;
 > +
 > +    if (mutex_is_locked(&ep->dma_operation) || rcar_pcie_ep_is_dmac_active(ep))
 > +        return -EBUSY;
 > +
 > +    mutex_lock(&ep->dma_operation);
 > +
 > +    rcar_pcie_ep_setup_dmac_request(ep, dma_dst, dma_src, len, dir, ch);
 > +
 > +    rcar_pcie_ep_execute_dmac_request(ep, dir, ch);
 > +
 > +    wait_status = wait_for_completion_interruptible_timeout(&ep->irq_raised,
 > +                                RCAR_PCIE_DMAC_TIMEOUT);
 > +    if (wait_status <= 0) {
 > +        rcar_pcie_ep_stop_dmac_request(ep, ch);
 > +    } else {
 > +        stat = rcar_pcie_ep_get_dmac_status(ep, &count, ch);
 > +        if (stat == RCAR_PCIE_DMA_XFR_SUCCESS && !count)
 > +            ret = 0;
 > +    }
 > +
 > +    mutex_unlock(&ep->dma_operation);
 > +    return ret;
 > +}
 > +
 >  static int rcar_pcie_ep_start(struct pci_epc *epc)
 >  {
 >      struct rcar_pcie_endpoint *ep = epc_get_drvdata(epc);
 > @@ -429,6 +588,55 @@ static int rcar_pcie_ep_start(struct pci_epc *epc)
 >      return 0;
 >  }
 >  
 > +static irqreturn_t rcar_pcie_ep_dmac_irq_handler(int irq, void *arg)
 > +{
 > +    u8 ch = RCAR_PCIE_DMAC_DEFAULT_CHANNEL;
 > +    struct rcar_pcie_endpoint *ep = arg;
 > +    struct rcar_pcie *pcie = &ep->pcie;
 > +    unsigned long flags;
 > +    u32 chsr_val;
 > +    u32 chcr_val;
 > +    u32 bytes;
 > +
 > +    spin_lock_irqsave(&ep->lock, flags);
 > +
 > +    chsr_val = rcar_pci_read_reg(pcie, PCIEDMCHSR(ch));
 > +
 > +    chcr_val = rcar_pci_read_reg(pcie, PCIEDMCHCR(ch));
 > +
 > +    if (mutex_is_locked(&ep->dma_operation)) {
 > +        if ((chsr_val &  PCIEDMCHSR_PEE) ||
 > +            (chsr_val & PCIEDMCHSR_IBE) ||
 > +            (chsr_val & PCIEDMCHSR_CHTC))
 > +            ep->xfr.status = RCAR_PCIE_DMA_XFR_ERROR;
 > +        else if (chsr_val & PCIEDMCHSR_TE)
 > +            ep->xfr.status = RCAR_PCIE_DMA_XFR_SUCCESS;
 > +
 > +        /* get byte count */
 > +        bytes = rcar_pci_read_reg(pcie, PCIEDMBCNTR(ch));
 > +        ep->xfr.bytes = bytes;
 > +
 > +        if ((chsr_val & PCIEDMCHSR_PEE) || (chsr_val & PCIEDMCHSR_IBE) ||
 > +            (chsr_val & PCIEDMCHSR_TE) || (chsr_val & PCIEDMCHSR_CHTC)) {
 > +            complete(&ep->irq_raised);
 > +        }
 > +    } else {
 > +        spin_unlock_irqrestore(&ep->lock, flags);
 > +        return IRQ_NONE;
 > +    }
 > +
 > +    if (chcr_val & PCIEDMCHCR_CHE)
 > +        chcr_val &= ~PCIEDMCHCR_CHE;
 > +    rcar_pci_write_reg(pcie, chcr_val, PCIEDMCHCR(ch));
 > +
 > +    /* Clear DMA interrupt source */
 > +    rcar_pci_write_reg(pcie, chsr_val, PCIEDMCHSR(ch));
 > +
 > +    spin_unlock_irqrestore(&ep->lock, flags);
 > +
 > +    return IRQ_HANDLED;
 > +}
 > +
 >  static void rcar_pcie_ep_stop(struct pci_epc *epc)
 >  {
 >      struct rcar_pcie_endpoint *ep = epc_get_drvdata(epc);
 > @@ -446,6 +654,8 @@ static const struct pci_epc_features rcar_pcie_epc_features = {
 >      .bar_fixed_size[0] = 128,
 >      .bar_fixed_size[2] = 256,
 >      .bar_fixed_size[4] = 256,
 > +    .internal_dmac = true,
 > +    .internal_dmac_mask = DMA_BIT_MASK(32),
 >  };
 >  
 >  static const struct pci_epc_features*
 > @@ -466,6 +676,7 @@ static const struct pci_epc_ops rcar_pcie_epc_ops = {
 >      .start        = rcar_pcie_ep_start,
 >      .stop        = rcar_pcie_ep_stop,
 >      .get_features    = rcar_pcie_ep_get_features,
 > +    .dmac_transfer    = rcar_pcie_ep_data_transfer,
 >  };
 >  
 >  static const struct of_device_id rcar_pcie_ep_of_match[] = {
 > @@ -480,6 +691,7 @@ static int rcar_pcie_ep_probe(struct platform_device *pdev)
 >      struct rcar_pcie_endpoint *ep;
 >      struct rcar_pcie *pcie;
 >      struct pci_epc *epc;
 > +    int dmac_irq;
 >      int err;
 >  
 >      ep = devm_kzalloc(dev, sizeof(*ep), GFP_KERNEL);
 > @@ -502,6 +714,14 @@ static int rcar_pcie_ep_probe(struct platform_device *pdev)
 >          goto err_pm_put;
 >      }
 >  
 > +    dmac_irq = platform_get_irq(pdev, 1);
 > +    if (dmac_irq < 0)
 > +        goto err_pm_put;
 > +
 > +    init_completion(&ep->irq_raised);
 > +    mutex_init(&ep->dma_operation);
 > +    spin_lock_init(&ep->lock);
 > +
 >      ep->num_ib_windows = MAX_NR_INBOUND_MAPS;
 >      ep->ib_window_map =
 >              devm_kcalloc(dev, BITS_TO_LONGS(ep->num_ib_windows),
 > @@ -533,6 +753,13 @@ static int rcar_pcie_ep_probe(struct platform_device *pdev)
 >  
 >      rcar_pcie_ep_hw_init(pcie);
 >  
 > +    err = devm_request_irq(dev, dmac_irq, rcar_pcie_ep_dmac_irq_handler,
 > +                   0, "pcie-rcar-ep-dmac", pcie);
 > +    if (err) {
 > +        dev_err(dev, "failed to request dmac irq\n");
 > +        goto err_pm_put;
 > +    }
 > +
 >      err = pci_epc_multi_mem_init(epc, ep->ob_window, ep->num_ob_windows);
 >      if (err < 0) {
 >          dev_err(dev, "failed to initialize the epc memory space\n");
 > diff --git a/drivers/pci/controller/pcie-rcar.h b/drivers/pci/controller/pcie-rcar.h
 > index 9bb125db85c6..874f8a384e6d 100644
 > --- a/drivers/pci/controller/pcie-rcar.h
 > +++ b/drivers/pci/controller/pcie-rcar.h
 > @@ -54,6 +54,29 @@
 >  #define  PAR_ENABLE        BIT(31)
 >  #define  IO_SPACE        BIT(8)
 >  
 > +/* PCIe DMAC control reg & mask */
 > +#define PCIEDMAOR        0x04000
 > +#define  PCIEDMAOR_DMAE        BIT(31)
 > +#define  PCIEDMAOR_DMAACT    BIT(16)
 > +#define PCIEDMPALR(x)        (0x04100 + ((x) * 0x40))
 > +#define PCIEDMPAUR(x)        (0x04104 + ((x) * 0x40))
 > +#define PCIEDMIAR(x)        (0x04108 + ((x) * 0x40))
 > +#define PCIEDMBCNTR(x)        (0x04110 + ((x) * 0x40))
 > +#define PCIEDMCCAR(x)        (0x04120 + ((x) * 0x40))
 > +#define PCIEDMCHCR(x)        (0x04128 + ((x) * 0x40))
 > +#define  PCIEDMCHCR_CHE        BIT(31)
 > +#define  PCIEDMCHCR_DIR        BIT(30)
 > +#define PCIEDMCHSR(x)        (0x0412c + ((x) * 0x40))
 > +#define  PCIEDMCHSR_CHTCE    BIT(28)
 > +#define  PCIEDMCHSR_PEEE    BIT(27)
 > +#define  PCIEDMCHSR_IBEE    BIT(25)
 > +#define  PCIEDMCHSR_CHTC    BIT(12)
 > +#define  PCIEDMCHSR_PEE        BIT(11)
 > +#define  PCIEDMCHSR_IBE        BIT(9)
 > +#define  PCIEDMCHSR_IE        BIT(3)
 > +#define  PCIEDMCHSR_TE        BIT(0)
 > +#define PCIEDMCHC2R(x)        (0x04130 + ((x) * 0x40))
 > +
 >  /* Configuration */
 >  #define PCICONF(x)        (0x010000 + ((x) * 0x4))
 >  #define  INTDIS            BIT(10)
 > -- 
 > 2.25.1
 > 
 > 
 > ######################################################################
 > This EXTERNAL email has been scanned by Proofpoint Email Protect service.
 > 
