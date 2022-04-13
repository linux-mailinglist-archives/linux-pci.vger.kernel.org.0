Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE879500084
	for <lists+linux-pci@lfdr.de>; Wed, 13 Apr 2022 23:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236451AbiDMVFo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Apr 2022 17:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235758AbiDMVFn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Apr 2022 17:05:43 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABBB8148A;
        Wed, 13 Apr 2022 14:03:20 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id c15so3694531ljr.9;
        Wed, 13 Apr 2022 14:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LZ83DhkBBZG+nmgaAN5JuMecxE6+rXnsPcGZMd6P5Us=;
        b=A1CrRXIUjnvMG6dKthCK0WPXr1bst9Dthfm7oG9Pdug62bdRKTaJnXSbGLdMQBZOV6
         ugramo2G/EYDnvAgA+ON3SmPX9KDn3pUo/2i034jKN2SUJY4uQzypxgSP7cAzfzcuskc
         qSyjDC785Pacz7CSM6MlXhnMd7B6Xqux8oRmHa8xW0e6sziFV9HVSN+LDxJ7O/o3F80O
         zW0kCbcAeGRT3CJuVXKL06PLQzg90vTFB/zO4EiCT0Pozrt6ym0bhvcMODzlkP8SHLZK
         /cDTftHemWU/N5nGKE/dwlw1qmVmjS194xBjh+MduBOPrbs60P48KC1Dj5a4rRegioGR
         TAJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LZ83DhkBBZG+nmgaAN5JuMecxE6+rXnsPcGZMd6P5Us=;
        b=v6ClH7afCAwsXB546g6fAcfELxZeoR45ZN46SeQfhsZcjYheDwlnBNLAZq/4QNMyrw
         LkrwN7O3sXwrkYTdX5+gr3F0VcEYq6Qxx0rp5LtXGDigjVC6kZ0UgZuj8dzsFtnRCRIW
         RypFXDy+eZ+5NytNt0ms2VoB7r7nIPDMNid+Sz1VP1MvuakF/JLz2DonbkPjXFjMvWwc
         kb479+AFLbKKNJRxt/qZ1nUJF5d/P1XfX7rKtDSQom4zuRaMdT/hYIrTJqXvLuH0EZ6j
         4zyiR9HFugbYuyNgv5eaum4F2LdD40Upc6Qe1LuYhsaPI5be+DgNcrM/KS+18G+mkrqG
         KScg==
X-Gm-Message-State: AOAM533CQbCV/YQ2ZbpPRkqEcn2rPXGcqGAxsOGvKRwZd7uqxgHmfpia
        q2sh+cLG0l7woP8L/1ar9Iw=
X-Google-Smtp-Source: ABdhPJzYwv1HlyLnTGVUKLQd2vjVKNQJgZHMVDVmslMcXnVuVOGBNfFyVntbEQ2MADkUqkABZ6pXkQ==
X-Received: by 2002:a05:651c:992:b0:24b:99c:35c with SMTP id b18-20020a05651c099200b0024b099c035cmr27850033ljq.142.1649883798192;
        Wed, 13 Apr 2022 14:03:18 -0700 (PDT)
Received: from mobilestation ([95.79.134.149])
        by smtp.gmail.com with ESMTPSA id a16-20020a195f50000000b00464f8b13286sm6288lfj.294.2022.04.13.14.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 14:03:17 -0700 (PDT)
Date:   Thu, 14 Apr 2022 00:03:15 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/12] PCI: dwc: Don't use generic IO-ops for DBI-space
 access
Message-ID: <20220413210315.2tsmlgudbz4ezzf2@mobilestation>
References: <20220324012524.16784-1-Sergey.Semin@baikalelectronics.ru>
 <20220324012524.16784-3-Sergey.Semin@baikalelectronics.ru>
 <20220324082746.GB2854@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324082746.GB2854@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 24, 2022 at 01:57:46PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Mar 24, 2022 at 04:25:13AM +0300, Serge Semin wrote:
> > Commit c2b0c098fbd1 ("PCI: dwc: Use generic config accessors") replaced
> > the locally defined DW PCIe host controller config-space accessors with
> > the generic methods pci_generic_config_read() and
> > pci_generic_config_write(). It was intended that the corresponding
> > bus-mapping callback returned a correct virtual address of the passed PCI
> > config-space register. The problem of the proposed solution was that it
> > didn't take into account the way the host config-space is accessed on the
> > DW PCIe. Depending on the DW PCIe IP-core synthesize parameters different
> > interfaces can be used to access the host and peripheral config/memory
> > spaces. The former one can be accessed via the DBI interface, while the
> > later ones is reached via the AHB/AXI application bus. In case if the DW
> > PCIe controller is configured to have a dedicated DBI interface, the way
> > it is mapped into the IO-memory turns to be platform-specific. For such
> > setups the DWC PCIe driver provides a set of the callbacks
> > dw_pcie_ops.{read_dbi,write_dbi} so the platforms glue-drivers would be
> > able to take into account the DBI bus IO peculiarities. Since
> > commit c2b0c098fbd1 ("PCI: dwc: Use generic config accessors") these
> > methods haven't been utilized during the generic host initialization
> > performed by the PCIe subsystem code.
> > 
> > I don't really know how come there have been no problems spotted for the
> > Histb/Exynos/Kirin PCIe controllers so far, but in our case with dword
> > aligned IO requirement the generic config-space accessors can't be
> > utilized for the host config-space. Thus in order to make sure the host
> > config-space is properly accessed via the DBI bus let's get back the
> > dw_pcie_rd_own_conf() and dw_pcie_wr_own_conf() methods. They are going to
> > be just wrappers around the already defined
> > dw_pcie_read_dbi()/dw_pcie_write_dbi() functions with proper arguments
> > conversion. These methods perform the platform-specific config-space IO if
> > the DBI accessors are specified, otherwise they call normal MMIO
> > operations.
> > 
> 

> Why can't you override the "pci_ops" in your host driver's "host_init"?

I have already defined the platform-specific DBI operations. These
operations are supposed to be used to access the DBI MMIO including
the own config space. Not doing so is very wrong and will cause
problems not only on my platforms, but on all platforms with specific
DBI implementation (such that requiring some more actions than
standard {read|write}{b,w,l} ops). So the commit c2b0c098fbd1 ("PCI:
dwc: Use generic config accessors") shouldn't have introduced the
generic IOs usage in this case and it needs to be fixed.

-Sergey

> 
> Thanks,
> Mani
> 
> > Fixes: c2b0c098fbd1 ("PCI: dwc: Use generic config accessors")
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > ---
> >  .../pci/controller/dwc/pcie-designware-host.c | 34 +++++++++++++++++--
> >  1 file changed, 32 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > index a03619a30c20..f89e6552139b 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -528,10 +528,40 @@ void __iomem *dw_pcie_own_conf_map_bus(struct pci_bus *bus, unsigned int devfn,
> >  }
> >  EXPORT_SYMBOL_GPL(dw_pcie_own_conf_map_bus);
> >  
> > +static int dw_pcie_rd_own_conf(struct pci_bus *bus, unsigned int devfn,
> > +			       int where, int size, u32 *val)
> > +{
> > +	struct pcie_port *pp = bus->sysdata;
> > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > +
> > +	if (PCI_SLOT(devfn) > 0) {
> > +		*val = ~0U;
> > +		return PCIBIOS_DEVICE_NOT_FOUND;
> > +	}
> > +
> > +	*val = dw_pcie_read_dbi(pci, where, size);
> > +
> > +	return PCIBIOS_SUCCESSFUL;
> > +}
> > +
> > +static int dw_pcie_wr_own_conf(struct pci_bus *bus, unsigned int devfn,
> > +			       int where, int size, u32 val)
> > +{
> > +	struct pcie_port *pp = bus->sysdata;
> > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > +
> > +	if (PCI_SLOT(devfn) > 0)
> > +		return PCIBIOS_DEVICE_NOT_FOUND;
> > +
> > +	dw_pcie_write_dbi(pci, where, size, val);
> > +
> > +	return PCIBIOS_SUCCESSFUL;
> > +}
> > +
> >  static struct pci_ops dw_pcie_ops = {
> >  	.map_bus = dw_pcie_own_conf_map_bus,
> > -	.read = pci_generic_config_read,
> > -	.write = pci_generic_config_write,
> > +	.read = dw_pcie_rd_own_conf,
> > +	.write = dw_pcie_wr_own_conf,
> >  };
> >  
> >  void dw_pcie_setup_rc(struct pcie_port *pp)
> > -- 
> > 2.35.1
> > 
