Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45609C2149
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2019 15:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731223AbfI3NEn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Sep 2019 09:04:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:46346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731208AbfI3NEl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Sep 2019 09:04:41 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4930F218AC;
        Mon, 30 Sep 2019 13:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569848680;
        bh=vlABKpVJxCoTy7HHvfFk0K5uGHtb528XjiDo33yIN0o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=r27qHyc+txDJIDpG2+55icHIxn1J/2AzXA5ncveAboHqBRVIDdVHaXsB1rokmXxEl
         RrBe2C7Uv++1mlL8KdeJQY2f5UG51yxZuByStSwfO/VB0ovLtC/As+VDurRfahdSuw
         VQxiV7AAWTABHIXD5KO/54gs3wQ9ZLLk8D3On860=
Date:   Mon, 30 Sep 2019 08:04:38 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Pascal van Leeuwen <pvanleeuwen@verimatrix.com>,
        Pascal van Leeuwen <pascalvanl@gmail.com>,
        Kelsey Skunberg <skunberg.kelsey@gmail.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 3/3] crypto: inside-secure - Remove #ifdef checks
Message-ID: <20190930130438.GA147884@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190930121520.1388317-3-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 30, 2019 at 02:14:35PM +0200, Arnd Bergmann wrote:
> When both PCI and OF are disabled, no drivers are registered, and
> we get some unused-function warnings:
> 
> drivers/crypto/inside-secure/safexcel.c:1221:13: error: unused function 'safexcel_unregister_algorithms' [-Werror,-Wunused-function]
> static void safexcel_unregister_algorithms(struct safexcel_crypto_priv *priv)
> drivers/crypto/inside-secure/safexcel.c:1307:12: error: unused function 'safexcel_probe_generic' [-Werror,-Wunused-function]
> static int safexcel_probe_generic(void *pdev,
> drivers/crypto/inside-secure/safexcel.c:1531:13: error: unused function 'safexcel_hw_reset_rings' [-Werror,-Wunused-function]
> static void safexcel_hw_reset_rings(struct safexcel_crypto_priv *priv)
> 
> It's better to make the compiler see what is going on and remove
> such ifdef checks completely. In case of PCI, this is trivial since
> pci_register_driver() is defined to an empty function that makes the
> compiler subsequently drop all unused code silently.
> 
> The global pcireg_rc/ofreg_rc variables are not actually needed here
> since the driver registration does not fail in ways that would make
> it helpful.
> 
> For CONFIG_OF, an IS_ENABLED() check is still required, since platform
> drivers can exist both with and without it.
> 
> A little change to linux/pci.h is needed to ensure that
> pcim_enable_device() is visible to the driver. Moving the declaration
> outside of ifdef would be sufficient here, but for consistency with the
> rest of the file, adding an inline helper is probably best.
> 
> Fixes: 212ef6f29e5b ("crypto: inside-secure - Fix unused variable warning when CONFIG_PCI=n")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/crypto/inside-secure/safexcel.c | 49 ++++++-------------------
>  include/linux/pci.h                     |  1 +
>  2 files changed, 13 insertions(+), 37 deletions(-)
> ... 

> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index f9088c89a534..1a6cf19eac2d 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1686,6 +1686,7 @@ static inline struct pci_dev *pci_get_class(unsigned int class,
>  static inline void pci_set_master(struct pci_dev *dev) { }
>  static inline int pci_enable_device(struct pci_dev *dev) { return -EIO; }
>  static inline void pci_disable_device(struct pci_dev *dev) { }
> +static inline int pcim_enable_device(struct pci_dev *pdev) { return -EIO; }

I would have used "dev" here to match surrounding stubs, but either
way:

Acked-by: Bjorn Helgaas <bhelgaas@google.com>	# pci.h

>  static inline int pci_assign_resource(struct pci_dev *dev, int i)
>  { return -EBUSY; }
>  static inline int __pci_register_driver(struct pci_driver *drv,
> -- 
> 2.20.0
> 
