Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9FB1AB9F9
	for <lists+linux-pci@lfdr.de>; Thu, 16 Apr 2020 09:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439247AbgDPHaH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Apr 2020 03:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2438921AbgDPHaF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Apr 2020 03:30:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5563AC061A0C
        for <linux-pci@vger.kernel.org>; Thu, 16 Apr 2020 00:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0NNGKR8amq0lr/W2puNLR/MTWXNKPmVv60t3Idf73Mg=; b=SYfeDDctxqujFlFl5H1Ojy7fUW
        iIiZ9hyvkeVqP9i7uOHyWyhOrr8zEhA2eNnhTxc+ss3+/paVdMNf7Hr1jQWafpeW1jBJhpBVlJuGF
        HQ9GQohULgz4q6VX6j46ecAxAkR2M4c7+5XVOlFhrf1RKq84h9w5D6xd76ykP2ZAQIzdPfQG4tojs
        zgicEwIoyvIcRLRTdBe+yPlggOFE3b+ahlJhX1UBj8pHpS0lLh2scTZZcuc5iemHLcCD4gUNvFU0V
        GX6L8JoyWuXKOaBw5aOGDMEoYlC33dN496GBRMhSj7CpZH3S4tCpho72S53eiHIM7hIK994z3X54Y
        3sMwEvwA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOyyK-0006Oe-RY; Thu, 16 Apr 2020 07:30:04 +0000
Date:   Thu, 16 Apr 2020 00:30:04 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH 3/5] PCI: pci-bridge-emul: Convert to GENMASK and BIT
Message-ID: <20200416073004.GB32000@infradead.org>
References: <20200414203005.5166-1-jonathan.derrick@intel.com>
 <20200414203005.5166-4-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414203005.5166-4-jonathan.derrick@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 14, 2020 at 04:30:03PM -0400, Jon Derrick wrote:
> In order to make pci-bridge-emul easier to keep up-to-date with new PCIe
> features, convert all named register bits to GENMASK and BIT pairs. This
> patch doesn't alter any of the PCI configuration space as these bits are
> fully defined.
> 
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> ---
>  drivers/pci/pci-bridge-emul.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/pci-bridge-emul.c b/drivers/pci/pci-bridge-emul.c
> index c00c30ffb198..bbcccadca85e 100644
> --- a/drivers/pci/pci-bridge-emul.c
> +++ b/drivers/pci/pci-bridge-emul.c
> @@ -221,11 +221,8 @@ static const struct pci_bridge_reg_behavior pcie_cap_regs_behavior[] = {
>  		 * as reserved bits.
>  		 */
>  		.rw = GENMASK(12, 0),
> -		.w1c = (PCI_EXP_SLTSTA_ABP | PCI_EXP_SLTSTA_PFD |
> -			PCI_EXP_SLTSTA_MRLSC | PCI_EXP_SLTSTA_PDC |
> -			PCI_EXP_SLTSTA_CC | PCI_EXP_SLTSTA_DLLSC) << 16,
> -		.ro = (PCI_EXP_SLTSTA_MRLSS | PCI_EXP_SLTSTA_PDS |
> -		       PCI_EXP_SLTSTA_EIS) << 16,
> +		.w1c = (BIT(8) | GENMASK(4, 0)) << 16,
> +		.ro = GENMASK(7, 5) << 16,

FYI, I find the previous version a lot more readable.  Or rather I find
it readable while the new one looks like intentionally obsfucated
garbage to me.
