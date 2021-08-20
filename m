Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5AD03F35F3
	for <lists+linux-pci@lfdr.de>; Fri, 20 Aug 2021 23:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240480AbhHTVST (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Aug 2021 17:18:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:58556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231200AbhHTVST (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Aug 2021 17:18:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B1E2D6108B;
        Fri, 20 Aug 2021 21:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629494261;
        bh=0obuSI1tNMoYAEs10g4gx3XozPflo2KTNqYcUNC3ajE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=hUXzQXJJX7z5iXDEz76jNQACqBTZhP2+SFmLhaK8V+9NTQ6h1fJ0jedrRsQRsnZK1
         Fob1Gt6j37W1yXZP+c32qkZe9p0e3pHDKwh8s4Q3cLFTFCU0KKCJwjLCdg6eag/JbS
         d3lE3/juTRrIhJ/e6chPbPLGa3l3hi9JD/lZkbRLibAc6xrtenPOcxNUR0Ht4Ii04I
         m487iA07HGsq1W04FlPaKcURaV5HHAH3SoGOpmDXiHDsOCx4xlv/sX63IPL3htU1G8
         1HKSgWUSU7ccMz1zWaxANnafyJDiOnQ2z/4NpJz3ZdfaG50YBdzgjNhJ4tKYqYoapu
         ggA6q3Gn4ABcg==
Date:   Fri, 20 Aug 2021 16:17:39 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH] PCI: asm-generic/pci_iomap: Correct wrong comment for
 #endif
Message-ID: <20210820211739.GA3360138@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803123014.2963814-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 03, 2021 at 08:30:14PM +0800, Jonathan Cameron wrote:
> If we are going to have comments on header guard #endifs then they should
> be correct and match the #ifndef
> 
> I'm guessing this one is a cut and paste error or has bit rotted.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Applied to pci/misc for v5.15, thanks!

> ---
>  include/asm-generic/pci_iomap.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/asm-generic/pci_iomap.h b/include/asm-generic/pci_iomap.h
> index d4f16dcc2ed7..df636c6d8e6c 100644
> --- a/include/asm-generic/pci_iomap.h
> +++ b/include/asm-generic/pci_iomap.h
> @@ -52,4 +52,4 @@ static inline void __iomem *pci_iomap_wc_range(struct pci_dev *dev, int bar,
>  }
>  #endif
>  
> -#endif /* __ASM_GENERIC_IO_H */
> +#endif /* __ASM_GENERIC_PCI_IOMAP_H */
> -- 
> 2.19.1
> 
