Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0263417F60
	for <lists+linux-pci@lfdr.de>; Sat, 25 Sep 2021 04:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347671AbhIYCnk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Sep 2021 22:43:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:36624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347630AbhIYCnj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Sep 2021 22:43:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5254B60F6D;
        Sat, 25 Sep 2021 02:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632537725;
        bh=3qKrafgB+R9aRyaGwO41XzuxrHwCkhqpSPu2zki+01Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=nq/E5Tl8hN26pAjLMZx9l6bt3QGZdvGLZSB3OPXISzKglBhK0/b/vcUcseNhI6L/U
         t+hdZfH4Pps8t0EA+Litu66sWufsr5aR4u/Oa13MZAbEtf8U/nfukgezUI3MBtnkjm
         g1JjOvrQkX3SyVrRFsrTej4spU+wYVdRJl5BRoQXx2hKMNWEuT3POFGkB/vbVvMuwM
         fj4NS20JrdggcqqKe1tF8wrGG3JdDTBqOehwDtevHa/wtUU7Kl3k4Jh/FsNbTnBAvt
         CiumBeTCgRCF/J40Ur04jLsAvPxIsbFicf7ORh5qVwxBr2H/LimkLTwP6SMTV0gkTL
         fdqA4wLTjksDQ==
Date:   Fri, 24 Sep 2021 21:42:04 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     tsbogend@alpha.franken.de, robh@kernel.org, arnd@arndb.de,
        catalin.marinas@arm.com, Liviu.Dudau@arm.com, bhelgaas@google.com,
        matthias.bgg@gmail.com, gregkh@linuxfoundation.org,
        linux-mips@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-staging@lists.linux.dev, neil@brown.name,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] PCI: allow architecture specific implementation of
 pci_remap_iospace()
Message-ID: <20210925024204.GA459123@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210924211139.3477-5-sergio.paracuellos@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

s/PCI: allow architecture specific implementation of/
  PCI: Allow architecture-specific pci_remap_iospace()/

(in subject)

On Fri, Sep 24, 2021 at 11:11:37PM +0200, Sergio Paracuellos wrote:
> pci_remap_iospace() was originally meant as an architecture specific helper,
> but it moved into generic code after all architectures had the same requirements.
> MIPS has different requirements so it should not be shared. The way for doing
> this will be using a macro 'pci_remap_iospace' defined for those architectures
> that need a special treatement. Hence, put core api function inside preprocesor
> conditional code for 'pci_remap_iospace' definition.

Rewrap above to fit in 75 columns so "git log" output doesn't wrap.
Add blank line between paragraphs.

s/treatement/treatment/
s/api/API/

> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

With above fixed,

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/pci.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index ce2ab62b64cf..0ec57bb01a88 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4123,6 +4123,7 @@ unsigned long __weak pci_address_to_pio(phys_addr_t address)
>   * architectures that have memory mapped IO functions defined (and the
>   * PCI_IOBASE value defined) should call this function.
>   */
> +#ifndef pci_remap_iospace
>  int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr)
>  {
>  #if defined(PCI_IOBASE) && defined(CONFIG_MMU)
> @@ -4146,6 +4147,7 @@ int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr)
>  #endif
>  }
>  EXPORT_SYMBOL(pci_remap_iospace);
> +#endif
>  
>  /**
>   * pci_unmap_iospace - Unmap the memory mapped I/O space
> -- 
> 2.25.1
> 
