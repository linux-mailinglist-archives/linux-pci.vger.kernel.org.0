Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B047B6194
	for <lists+linux-pci@lfdr.de>; Wed, 18 Sep 2019 12:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbfIRKmQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Sep 2019 06:42:16 -0400
Received: from foss.arm.com ([217.140.110.172]:39012 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727485AbfIRKmQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Sep 2019 06:42:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 005E2337;
        Wed, 18 Sep 2019 03:42:16 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6BD743F59C;
        Wed, 18 Sep 2019 03:42:15 -0700 (PDT)
Date:   Wed, 18 Sep 2019 11:42:13 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Steffen Liebergeld <steffen.liebergeld@kernkonzept.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] PCI: quirks: Fix register location for UPDCR
Message-ID: <20190918104213.GD9720@e119886-lin.cambridge.arm.com>
References: <054ef65b-07de-7625-ebcb-f5ce64bc2726@kernkonzept.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <054ef65b-07de-7625-ebcb-f5ce64bc2726@kernkonzept.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 17, 2019 at 08:07:13PM +0200, Steffen Liebergeld wrote:
> According to documentation [0] the correct offset for the
> Upstream Peer Decode Configuration Register (UPDCR) is 0x1014.
> It was previously defined as 0x1114. This patch fixes it.
> 
> [0]
> https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/4th-gen-core-family-mobile-i-o-datasheet.pdf
> (page 325)
> 
> Signed-off-by: Steffen Liebergeld <steffen.liebergeld@kernkonzept.com>

You may also like to add:

Fixes: d99321b63b1f ("PCI: Enable quirks for PCIe ACS on Intel PCH root ports")
Reviewed-by: Andrew Murray <andrew.murray@arm.com>

As well as CC'ing stable.

I guess the side effect of this bug is that we claim to have peer
isolation when we do not. This fix ensures that we get the advertised
isolation.

Thanks,

Andrew Murray

> ---
>  drivers/pci/quirks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 208aacf39329..7e184beb2aa4 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4602,7 +4602,7 @@ int pci_dev_specific_acs_enabled(struct pci_dev *dev,
> u16 acs_flags)
>  #define INTEL_BSPR_REG_BPPD  (1 << 9)
>   /* Upstream Peer Decode Configuration Register */
> -#define INTEL_UPDCR_REG 0x1114
> +#define INTEL_UPDCR_REG 0x1014
>  /* 5:0 Peer Decode Enable bits */
>  #define INTEL_UPDCR_REG_MASK 0x3f
>  -- 2.11.0
