Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD3BAD2A11
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2019 14:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387841AbfJJMzS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Oct 2019 08:55:18 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:37638 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728274AbfJJMzS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Oct 2019 08:55:18 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1iIXy9-0001sw-7h; Thu, 10 Oct 2019 23:55:02 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 10 Oct 2019 23:55:00 +1100
Date:   Thu, 10 Oct 2019 23:55:00 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Pascal van Leeuwen <pvanleeuwen@verimatrix.com>,
        Pascal van Leeuwen <pascalvanl@gmail.com>,
        Kelsey Skunberg <skunberg.kelsey@gmail.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 3/3] crypto: inside-secure - Remove #ifdef checks
Message-ID: <20191010125500.GE31566@gondor.apana.org.au>
References: <20190930121520.1388317-1-arnd@arndb.de>
 <20190930121520.1388317-3-arnd@arndb.de>
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

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
