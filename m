Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2353D7DD6E3
	for <lists+linux-pci@lfdr.de>; Tue, 31 Oct 2023 21:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235851AbjJaUDR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Oct 2023 16:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234890AbjJaUDQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Oct 2023 16:03:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2EEEF7;
        Tue, 31 Oct 2023 13:03:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34190C433C9;
        Tue, 31 Oct 2023 20:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698782594;
        bh=2aV6IcuNuc4VZa9a7hwgLV8gteCTymOcvVS85W7p4oU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=awg5+Ps4V1xjtT+IA5wregK3t8Xmhvgs5CiZFN/K4wNY3yPHZmDvTVkkD1D6mBG3g
         rPgsfiWMUJwdqMg5ZPb+FehIVIN9IdejQgMik6WbmRqv9M83lHctTynaePH7Ne0/DE
         Mv7suJrW3+iSBV/pVpsLekNNigZuDO78L99G8P89XfiHrtwyf8UY9GfJb88RcMN9Jd
         xLxFZc7k5yftOF/VxdnZe+P/Lc6BKITq8GERBI4Ej284JJCDCwqVR3dU1pQH3o9NSj
         I3JF56VJ7fdxgBP8C7I8LzoPrpcpcVZtYPlR1aU8Cwsp7UvE2mY9H3ve1grvaCPgLe
         RKtQiQjeR02rw==
Date:   Tue, 31 Oct 2023 15:03:12 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI: Use FIELD_PREP() and remove *_SHIFT defines
Message-ID: <20231031200312.GA25127@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231027083811.9200-1-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 27, 2023 at 11:38:11AM +0300, Ilpo Järvinen wrote:
> Instead of open-coded masking and shifting with PCI_CONF1_* bitfields,
> use GENMASK() and FIELD_PREP(), and then remove the *_SHIFT defines
> that are no longer needed.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
> 
>  drivers/pci/pci.h | 23 ++++++++++-------------
>  1 file changed, 10 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 39a8932dc340..31da9fde8aca 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -2,6 +2,8 @@
>  #ifndef DRIVERS_PCI_H
>  #define DRIVERS_PCI_H
>  
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
>  #include <linux/pci.h>
>  
>  /* Number of possible devfns: 0.0 to 1f.7 inclusive */
> @@ -797,19 +799,15 @@ static inline pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
>   * Section 3.2.2.3.2, Figure 3-2, p. 50.
>   */
>  
> -#define PCI_CONF1_BUS_SHIFT	16 /* Bus number */
> -#define PCI_CONF1_DEV_SHIFT	11 /* Device number */
> -#define PCI_CONF1_FUNC_SHIFT	8  /* Function number */
> -
> -#define PCI_CONF1_BUS_MASK	0xff
> -#define PCI_CONF1_DEV_MASK	0x1f
> -#define PCI_CONF1_FUNC_MASK	0x7
> +#define PCI_CONF1_BUS_MASK	GENMASK(23, 16)
> +#define PCI_CONF1_DEV_MASK	GENMASK(15, 11)
> +#define PCI_CONF1_FUNC_MASK	GENMASK(10, 8)
>  #define PCI_CONF1_REG_MASK	0xfc /* Limit aligned offset to a maximum of 256B */
>  
>  #define PCI_CONF1_ENABLE	BIT(31)
> -#define PCI_CONF1_BUS(x)	(((x) & PCI_CONF1_BUS_MASK) << PCI_CONF1_BUS_SHIFT)
> -#define PCI_CONF1_DEV(x)	(((x) & PCI_CONF1_DEV_MASK) << PCI_CONF1_DEV_SHIFT)
> -#define PCI_CONF1_FUNC(x)	(((x) & PCI_CONF1_FUNC_MASK) << PCI_CONF1_FUNC_SHIFT)
> +#define PCI_CONF1_BUS(x)	FIELD_PREP(PCI_CONF1_BUS_MASK, (x))
> +#define PCI_CONF1_DEV(x)	FIELD_PREP(PCI_CONF1_DEV_MASK, (x))
> +#define PCI_CONF1_FUNC(x)	FIELD_PREP(PCI_CONF1_FUNC_MASK, (x))
>  #define PCI_CONF1_REG(x)	((x) & PCI_CONF1_REG_MASK)

I love getting rid of the _SHIFT #defines.

I'm a dinosaur and haven't been completely converted to the wonders of
GENMASK yet.  PCI_CONF1_ADDRESS is the only user of PCI_CONF1_BUS etc,
so I think this would be simpler overall:

  #define PCI_CONF1_BUS  0x00ff0000
  #define PCI_CONF1_DEV  0x0000f800
  #define PCI_CONF1_FUNC 0x00000700
  #define PCI_CONF1_REG  0x000000ff

  #define PCI_CONF1_ADDRESS(bus, dev, func, reg) \
    (FIELD_PREP(PCI_CONF1_BUS, (bus)) | \
     FIELD_PREP(PCI_CONF1_DEV, (dev)) | \
     FIELD_PREP(PCI_CONF1_FUNC, (func)) | \
     FIELD_PREP(PCI_CONF1_REG, (reg & ~0x3)))

The v6.7 merge window just opened, and I won't start merging v6.8
material until v6.7-rc1 (probably Nov 12), so no hurry on this.

Bjorn
